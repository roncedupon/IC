from flask import Flask, request, render_template_string, jsonify
from flask_socketio import SocketIO, emit
import time
import uuid
import threading
from datetime import datetime
import json

app = Flask(__name__)
app.config['SECRET_KEY'] = 'video_sync_secure_key_' + str(uuid.uuid4())
socketio = SocketIO(app, 
                   cors_allowed_origins="*", 
                   async_mode='threading',
                   ping_interval=60000, 
                   ping_timeout=120000,
                   max_http_buffer_size=1e8)

# 全局播放状态
global_play_state = {
    "video_url": "",
    "current_time": 0.0,
    "is_playing": False,
    "is_muted": True,
    "playback_rate": 1.0,
    "update_ts": time.time(),
    "last_sync_source": None,
    "session_id": str(uuid.uuid4())[:8]  # 用于标识会话
}

# 设备管理
device_status = {}
DEVICE_PREFIX = "DEV-"
device_lock = threading.Lock()

# 配置参数
CONFIG = {
    "STATE_LOCK": 0.8,      # 状态锁定时间(秒)
    "SYNC_THRESHOLD": 2.0,  # 同步阈值(秒)
    "SYNC_INTERVAL": 2000,  # 同步间隔(ms)
    "SPEED_REPORT_INTERVAL": 1000,  # 速度报告间隔(ms)
    "HEARTBEAT_TIMEOUT": 10,  # 心跳超时(秒)
    "MAX_SYNC_RETRIES": 3,   # 最大同步重试次数
}

# 心跳线程
def heartbeat_monitor():
    """定期检查设备在线状态"""
    while True:
        time.sleep(5)
        current_time = time.time()
        offline_devices = []
        
        with device_lock:
            for sid, device in device_status.items():
                if current_time - device.get("last_seen", 0) > CONFIG["HEARTBEAT_TIMEOUT"]:
                    offline_devices.append(sid)
            
            for sid in offline_devices:
                if sid in device_status:
                    del device_status[sid]
        
        if offline_devices:
            broadcast_device_status()

# 启动心跳监控线程
heartbeat_thread = threading.Thread(target=heartbeat_monitor, daemon=True)
heartbeat_thread.start()

@socketio.on('connect')
def handle_connect():
    """处理新设备连接"""
    sid = request.sid
    device_id = f"{DEVICE_PREFIX}{uuid.uuid4().hex[:8].upper()}"
    
    with device_lock:
        device_status[sid] = {
            "device_id": device_id,
            "load_speed": 0.0,
            "buffer_progress": 0.0,
            "is_playing": False,
            "online": True,
            "connected_at": time.time(),
            "last_seen": time.time(),
            "ip": request.remote_addr
        }
    
    # 发送当前全局状态给新设备
    emit('sync_self', global_play_state)
    broadcast_device_status()
    
    print(f"[{datetime.now().strftime('%H:%M:%S')}] 设备连接: {device_id} ({sid[:8]})")

@socketio.on('disconnect')
def handle_disconnect():
    """处理设备断开"""
    sid = request.sid
    with device_lock:
        if sid in device_status:
            device_id = device_status[sid]["device_id"]
            del device_status[sid]
    
    broadcast_device_status()
    print(f"[{datetime.now().strftime('%H:%M:%S')}] 设备断开: {sid[:8]}")

@socketio.on('heartbeat')
def handle_heartbeat():
    """处理心跳"""
    sid = request.sid
    with device_lock:
        if sid in device_status:
            device_status[sid]["last_seen"] = time.time()
            device_status[sid]["online"] = True

@socketio.on('report_player_metrics')
def handle_player_metrics(data):
    """处理播放器指标报告"""
    sid = request.sid
    with device_lock:
        if sid in device_status:
            device_status[sid].update({
                "load_speed": round(data.get("load_speed", 0), 1),
                "buffer_progress": round(data.get("buffer_progress", 0), 1),
                "is_playing": data.get("is_playing", False),
                "last_seen": time.time()
            })
    broadcast_device_status()

@socketio.on('get_init_state')
def send_init_state():
    """发送初始状态给设备"""
    emit('sync_self', global_play_state)

@socketio.on('send_state')
def handle_state_change(data):
    """处理状态变更"""
    global global_play_state
    
    sid = request.sid
    now = time.time()
    
    # 检查状态锁定
    if now - global_play_state["update_ts"] < CONFIG["STATE_LOCK"]:
        return
    
    # 更新设备最后活动时间
    with device_lock:
        if sid in device_status:
            device_status[sid]["last_seen"] = now
    
    # 验证数据
    if not isinstance(data, dict):
        return
    
    # 检查是否需要同步
    need_broadcast = False
    
    # 1. 检查视频源变更
    if "video_url" in data and data["video_url"] != global_play_state["video_url"]:
        global_play_state["video_url"] = data["video_url"]
        global_play_state["current_time"] = 0.0
        global_play_state["is_playing"] = data.get("is_playing", True)
        need_broadcast = True
    
    # 2. 检查播放/暂停状态变更
    elif "is_playing" in data and data["is_playing"] != global_play_state["is_playing"]:
        # 忽略无效状态变更
        if not global_play_state["video_url"] and data["is_playing"]:
            return
        global_play_state["is_playing"] = data["is_playing"]
        need_broadcast = True
    
    # 3. 检查进度变更
    elif "current_time" in data and global_play_state["video_url"]:
        # 忽略无效进度（视频未加载时的0进度）
        if data["current_time"] < 0.1 and global_play_state["current_time"] > 1:
            return
        
        time_diff = abs(global_play_state["current_time"] - data["current_time"])
        
        # 播放状态下使用较大阈值，暂停状态下使用较小阈值
        if global_play_state["is_playing"]:
            if time_diff > CONFIG["SYNC_THRESHOLD"]:
                global_play_state["current_time"] = data["current_time"]
                need_broadcast = True
        else:
            # 暂停状态下更敏感
            if time_diff > 0.5:
                global_play_state["current_time"] = data["current_time"]
                need_broadcast = True
    
    # 4. 静音状态变更
    elif "is_muted" in data and data["is_muted"] != global_play_state["is_muted"]:
        global_play_state["is_muted"] = data["is_muted"]
        need_broadcast = True
    
    # 5. 播放速率变更
    elif "playback_rate" in data and data["playback_rate"] != global_play_state["playback_rate"]:
        global_play_state["playback_rate"] = data["playback_rate"]
        need_broadcast = True
    
    # 如果需要广播，更新状态并发送
    if need_broadcast:
        global_play_state["update_ts"] = now
        global_play_state["last_sync_source"] = sid
        
        # 广播给其他设备
        socketio.emit('sync_all', {
            **global_play_state,
            "sync_id": str(uuid.uuid4())[:8],
            "timestamp": now
        }, include_self=False)
        
        print(f"[{datetime.now().strftime('%H:%M:%S')}] 状态同步: {sid[:8]} -> {list(data.keys())}")

def broadcast_device_status():
    """广播设备状态"""
    with device_lock:
        online_devices = [
            {
                "device_id": v["device_id"],
                "load_speed": v["load_speed"],
                "buffer_progress": v["buffer_progress"],
                "is_playing": v["is_playing"],
                "online": v["online"],
                "connected_at": v["connected_at"],
                "ip": v.get("ip", "unknown")
            }
            for v in device_status.values() if v.get("online", False)
        ]
    
    socketio.emit('device_status_update', {
        "online_count": len(online_devices),
        "devices": online_devices,
        "timestamp": time.time()
    })

@app.route('/')
def index():
    """主页"""
    online_count = len([v for v in device_status.values() if v.get("online", False)])
    return render_template_string(MAIN_HTML, 
                                state=global_play_state, 
                                config=CONFIG, 
                                online_count=online_count)

@app.route('/api/status')
def api_status():
    """API状态端点"""
    with device_lock:
        online_devices = [
            {
                "device_id": v["device_id"],
                "load_speed": v["load_speed"],
                "buffer_progress": v["buffer_progress"],
                "is_playing": v["is_playing"],
                "online": v["online"],
                "connected_at": v["connected_at"]
            }
            for v in device_status.values() if v.get("online", False)
        ]
    
    return jsonify({
        "global_state": global_play_state,
        "online_devices": online_devices,
        "total_devices": len(online_devices),
        "server_time": time.time()
    })

@app.route('/api/control', methods=['POST'])
def api_control():
    """API控制端点"""
    global global_play_state
    
    data = request.get_json()
    action = data.get('action')
    
    if action == 'play':
        video_url = data.get('video_url', '').strip()
        if video_url:
            global_play_state.update({
                "video_url": video_url,
                "current_time": 0.0,
                "is_playing": True,
                "is_muted": True,
                "update_ts": time.time()
            })
            socketio.emit('sync_all', global_play_state)
            return jsonify({"status": "success", "message": "播放指令已发送"})
    
    elif action == 'pause':
        global_play_state["is_playing"] = False
        global_play_state["update_ts"] = time.time()
        socketio.emit('sync_all', global_play_state)
        return jsonify({"status": "success", "message": "暂停指令已发送"})
    
    elif action == 'seek':
        current_time = float(data.get('current_time', 0))
        if 0 <= current_time <= 36000:  # 限制在10小时内
            global_play_state["current_time"] = current_time
            global_play_state["update_ts"] = time.time()
            socketio.emit('sync_all', global_play_state)
            return jsonify({"status": "success", "message": f"跳转到 {current_time} 秒"})
    
    elif action == 'clear':
        global_play_state.update({
            "video_url": "",
            "current_time": 0.0,
            "is_playing": False,
            "is_muted": True,
            "update_ts": time.time()
        })
        socketio.emit('sync_all', global_play_state)
        return jsonify({"status": "success", "message": "已清空视频"})
    
    return jsonify({"status": "error", "message": "无效操作"})

# HTML模板
MAIN_HTML = '''
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📺 视频同步系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #f5f7fa; color: #333; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; }
        h1 { color: #1890ff; font-size: 24px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); padding: 20px; margin-bottom: 20px; }
        .control-panel { display: grid; grid-template-columns: 1fr auto; gap: 15px; margin-bottom: 20px; }
        .url-input { flex: 1; padding: 10px; border: 1px solid #d9d9d9; border-radius: 4px; font-size: 14px; }
        .btn-group { display: flex; gap: 10px; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; transition: all 0.3s; }
        .btn-primary { background: #1890ff; color: white; }
        .btn-primary:hover { background: #40a9ff; }
        .btn-danger { background: #ff4d4f; color: white; }
        .btn-danger:hover { background: #ff7875; }
        .btn-success { background: #52c41a; color: white; }
        .btn-success:hover { background: #73d13d; }
        .stats { display: flex; gap: 20px; font-size: 14px; }
        .stat-item { display: flex; align-items: center; gap: 8px; }
        .stat-badge { background: #f0f0f0; padding: 4px 8px; border-radius: 12px; font-weight: bold; }
        .video-container { position: relative; width: 100%; margin-bottom: 20px; }
        video { width: 100%; border-radius: 8px; background: #000; }
        .video-info { margin-top: 10px; color: #666; font-size: 13px; }
        .device-panel { margin-top: 20px; }
        .device-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 15px; margin-top: 15px; }
        .device-card { border: 1px solid #e8e8e8; border-radius: 6px; padding: 15px; background: #fafafa; }
        .device-header { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .device-id { font-weight: bold; color: #1890ff; }
        .device-metrics { display: grid; gap: 8px; }
        .metric { display: flex; justify-content: space-between; }
        .metric-label { color: #666; }
        .metric-value { font-weight: 500; }
        .online { color: #52c41a; }
        .offline { color: #ff4d4f; }
        .progress-bar { height: 6px; background: #f0f0f0; border-radius: 3px; margin-top: 5px; overflow: hidden; }
        .progress-fill { height: 100%; background: #1890ff; border-radius: 3px; }
        .log-panel { font-family: 'Courier New', monospace; font-size: 12px; max-height: 200px; overflow-y: auto; }
        .log-entry { padding: 4px 0; border-bottom: 1px solid #f0f0f0; }
        .sync-id { color: #722ed1; }
        .loading { text-align: center; padding: 40px; color: #999; }
        .error { color: #ff4d4f; padding: 10px; background: #fff2f0; border-radius: 4px; margin: 10px 0; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📺 多终端视频同步系统</h1>
            <div class="stats">
                <div class="stat-item">
                    <span>在线设备:</span>
                    <span class="stat-badge online" id="online-count">0</span>
                </div>
                <div class="stat-item">
                    <span>同步会话:</span>
                    <span class="stat-badge" id="session-id">-</span>
                </div>
            </div>
        </div>

        <div class="card">
            <h2 style="margin-bottom: 15px;">视频控制</h2>
            <div class="control-panel">
                <input type="text" class="url-input" id="video-url" 
                       placeholder="输入视频URL (mp4, m3u8, flv等格式)" 
                       value="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4">
                <div class="btn-group">
                    <button class="btn btn-primary" onclick="playVideo()">播放/同步</button>
                    <button class="btn" onclick="pauseVideo()">暂停</button>
                    <button class="btn" onclick="seekVideo(30)">+30秒</button>
                    <button class="btn btn-danger" onclick="clearVideo()">清空</button>
                </div>
            </div>
            <div id="error-message" class="error" style="display: none;"></div>
        </div>

        <div class="card">
            <h2 style="margin-bottom: 15px;">视频播放器</h2>
            <div class="video-container">
                <video id="player" controls playsinline muted preload="auto">
                    <source id="video-source" type="video/mp4">
                    您的浏览器不支持视频播放
                </video>
            </div>
            <div class="video-info">
                <div>当前: <span id="current-url">-</span></div>
                <div>状态: <span id="player-state">等待播放</span></div>
                <div>进度: <span id="progress">0:00</span> / <span id="duration">0:00</span></div>
            </div>
        </div>

        <div class="card device-panel">
            <h2 style="margin-bottom: 15px;">设备监控</h2>
            <div id="device-grid" class="device-grid">
                <div class="loading">加载中...</div>
            </div>
        </div>

        <div class="card">
            <h2 style="margin-bottom: 15px;">同步日志</h2>
            <div id="sync-log" class="log-panel">
                <div class="log-entry">系统就绪，等待连接...</div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.0.1/socket.io.js"></script>
    <script>
        const socket = io();
        const player = document.getElementById('player');
        const videoSource = document.getElementById('video-source');
        
        let playerState = {
            isPlaying: false,
            currentTime: 0,
            isMuted: true,
            isDragging: false,
            isBuffering: false,
            lastSyncTs: 0,
            currentVideoUrl: '',
            loadSpeed: 0,
            bufferProgress: 0,
            lastSpeedCalcTime: Date.now(),
            lastBufferBytes: 0
        };
        
        let syncSession = null;
        const SYNC_INTERVAL = {{ config.SYNC_INTERVAL }};
        const SYNC_THRESHOLD = {{ config.SYNC_THRESHOLD }};
        const SPEED_REPORT_INTERVAL = {{ config.SPEED_REPORT_INTERVAL }};
        
        // Socket.io 事件处理
        socket.on('connect', () => {
            addLog('已连接到服务器');
            socket.emit('get_init_state');
        });
        
        socket.on('disconnect', () => {
            addLog('与服务器断开连接', 'error');
        });
        
        socket.on('sync_self', (state) => {
            handleSync(state, true);
        });
        
        socket.on('sync_all', (state) => {
            handleSync(state, false);
        });
        
        socket.on('device_status_update', (data) => {
            updateDevicePanel(data);
        });
        
        // 同步处理
        function handleSync(state, isSelf) {
            const prefix = isSelf ? '🔄 初始化同步' : '🔄 全局同步';
            addLog(`${prefix}: ${state.is_playing ? '播放' : '暂停'} @ ${state.current_time.toFixed(1)}s`, 'sync', state.sync_id);
            
            syncSession = state.session_id;
            document.getElementById('session-id').textContent = syncSession;
            
            // 视频源变更
            if (state.video_url && state.video_url !== playerState.currentVideoUrl) {
                playerState.currentVideoUrl = state.video_url;
                videoSource.src = state.video_url;
                player.load();
                document.getElementById('current-url').textContent = state.video_url.substring(0, 50) + '...';
            } else if (!state.video_url && playerState.currentVideoUrl) {
                player.pause();
                player.src = '';
                player.load();
                playerState.currentVideoUrl = '';
                document.getElementById('current-url').textContent = '-';
            }
            
            // 静音状态
            player.muted = state.is_muted;
            playerState.isMuted = state.is_muted;
            
            // 播放进度
            if (Math.abs(player.currentTime - state.current_time) > SYNC_THRESHOLD) {
                player.currentTime = state.current_time;
                playerState.currentTime = state.current_time;
            }
            
            // 播放/暂停状态
            if (state.is_playing !== playerState.isPlaying) {
                playerState.isPlaying = state.is_playing;
                if (state.is_playing) {
                    player.play().catch(e => {
                        console.warn('播放失败:', e);
                        player.muted = true;
                        player.play().catch(() => {});
                    });
                } else {
                    player.pause();
                }
            }
            
            updatePlayerState();
        }
        
        // 播放器事件监听
        function initPlayer() {
            player.addEventListener('loadedmetadata', () => {
                document.getElementById('duration').textContent = formatTime(player.duration);
            });
            
            player.addEventListener('timeupdate', () => {
                playerState.currentTime = player.currentTime;
                updatePlayerState();
                
                // 定期同步进度
                const now = Date.now();
                if (playerState.isPlaying && now - playerState.lastSyncTs > SYNC_INTERVAL) {
                    socket.emit('send_state', { current_time: player.currentTime });
                    playerState.lastSyncTs = now;
                }
            });
            
            player.addEventListener('play', () => {
                if (!playerState.isPlaying) {
                    playerState.isPlaying = true;
                    socket.emit('send_state', { is_playing: true });
                }
            });
            
            player.addEventListener('pause', () => {
                if (playerState.isPlaying) {
                    playerState.isPlaying = false;
                    socket.emit('send_state', { is_playing: false });
                }
            });
            
            player.addEventListener('seeking', () => {
                playerState.isDragging = true;
            });
            
            player.addEventListener('seeked', () => {
                playerState.isDragging = false;
                playerState.currentTime = player.currentTime;
                socket.emit('send_state', { current_time: player.currentTime });
            });
            
            player.addEventListener('volumechange', () => {
                playerState.isMuted = player.muted;
                socket.emit('send_state', { is_muted: player.muted });
            });
            
            player.addEventListener('waiting', () => {
                playerState.isBuffering = true;
            });
            
            player.addEventListener('playing', () => {
                playerState.isBuffering = false;
            });
            
            // 心跳
            setInterval(() => {
                socket.emit('heartbeat');
            }, 5000);
            
            // 报告指标
            setInterval(() => {
                if (player.buffered.length > 0) {
                    const bufferedEnd = player.buffered.end(player.buffered.length - 1);
                    playerState.bufferProgress = (bufferedEnd / player.duration) * 100 || 0;
                    
                    const now = Date.now();
                    const timeDiff = (now - playerState.lastSpeedCalcTime) / 1000;
                    if (timeDiff >= 1) {
                        const bufferBytes = (bufferedEnd * (player.videoBitrate || 2000000)) / 8;
                        const bytesDiff = bufferBytes - playerState.lastBufferBytes;
                        playerState.loadSpeed = (bytesDiff / 1024) / timeDiff;
                        playerState.lastSpeedCalcTime = now;
                        playerState.lastBufferBytes = bufferBytes;
                    }
                    
                    socket.emit('report_player_metrics', {
                        load_speed: playerState.loadSpeed,
                        buffer_progress: playerState.bufferProgress,
                        is_playing: playerState.isPlaying
                    });
                }
            }, SPEED_REPORT_INTERVAL);
        }
        
        // 控制函数
        function playVideo() {
            const url = document.getElementById('video-url').value.trim();
            if (!url) {
                showError('请输入视频URL');
                return;
            }
            
            playerState.currentVideoUrl = url;
            videoSource.src = url;
            player.load();
            player.muted = true;
            
            player.play().then(() => {
                socket.emit('send_state', {
                    video_url: url,
                    current_time: 0,
                    is_playing: true,
                    is_muted: true
                });
                document.getElementById('current-url').textContent = url.substring(0, 50) + '...';
                hideError();
            }).catch(e => {
                showError('播放失败: ' + e.message);
            });
        }
        
        function pauseVideo() {
            player.pause();
            socket.emit('send_state', { is_playing: false });
        }
        
        function seekVideo(seconds) {
            const newTime = Math.max(0, Math.min(player.currentTime + seconds, player.duration || Infinity));
            player.currentTime = newTime;
            socket.emit('send_state', { current_time: newTime });
        }
        
        function clearVideo() {
            player.pause();
            player.src = '';
            player.load();
            playerState.currentVideoUrl = '';
            socket.emit('send_state', { 
                video_url: '',
                current_time: 0,
                is_playing: false 
            });
            document.getElementById('current-url').textContent = '-';
        }
        
        // 工具函数
        function updatePlayerState() {
            document.getElementById('player-state').textContent = 
                playerState.isPlaying ? (playerState.isBuffering ? '缓冲中...' : '播放中') : '暂停';
            document.getElementById('progress').textContent = formatTime(player.currentTime);
            document.getElementById('duration').textContent = formatTime(player.duration);
        }
        
        function updateDevicePanel(data) {
            const grid = document.getElementById('device-grid');
            const countEl = document.getElementById('online-count');
            
            if (!grid || !countEl) return;
            
            countEl.textContent = data.online_count;
            
            if (data.online_count === 0) {
                grid.innerHTML = '<div class="loading">暂无在线设备</div>';
                return;
            }
            
            let html = '';
            data.devices.forEach(device => {
                const speedText = formatSpeed(device.load_speed);
                html += `
                    <div class="device-card">
                        <div class="device-header">
                            <span class="device-id">${device.device_id}</span>
                            <span class="${device.online ? 'online' : 'offline'}">● ${device.online ? '在线' : '离线'}</span>
                        </div>
                        <div class="device-metrics">
                            <div class="metric">
                                <span class="metric-label">加载速度:</span>
                                <span class="metric-value">${speedText}</span>
                            </div>
                            <div class="metric">
                                <span class="metric-label">缓冲进度:</span>
                                <span class="metric-value">${device.buffer_progress.toFixed(1)}%</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${device.buffer_progress}%"></div>
                            </div>
                            <div class="metric">
                                <span class="metric-label">播放状态:</span>
                                <span class="metric-value">${device.is_playing ? '▶️ 播放中' : '⏸️ 已暂停'}</span>
                            </div>
                        </div>
                    </div>
                `;
            });
            
            grid.innerHTML = html;
        }
        
        function addLog(message, type = 'info', syncId = '') {
            const logPanel = document.getElementById('sync-log');
            if (!logPanel) return;
            
            const time = new Date().toLocaleTimeString();
            const typeIcon = type === 'error' ? '❌' : type === 'sync' ? '🔄' : 'ℹ️';
            const syncHtml = syncId ? `<span class="sync-id">[${syncId}]</span>` : '';
            
            const logEntry = document.createElement('div');
            logEntry.className = 'log-entry';
            logEntry.innerHTML = `${typeIcon} [${time}] ${syncHtml} ${message}`;
            
            logPanel.appendChild(logEntry);
            logPanel.scrollTop = logPanel.scrollHeight;
        }
        
        function showError(message) {
            const el = document.getElementById('error-message');
            if (el) {
                el.textContent = message;
                el.style.display = 'block';
            }
        }
        
        function hideError() {
            const el = document.getElementById('error-message');
            if (el) {
                el.style.display = 'none';
            }
        }
        
        function formatTime(seconds) {
            if (!seconds || seconds < 0) return '0:00';
            const mins = Math.floor(seconds / 60);
            const secs = Math.floor(seconds % 60);
            return `${mins}:${secs.toString().padStart(2, '0')}`;
        }
        
        function formatSpeed(kbps) {
            if (kbps < 1) return (kbps * 1024).toFixed(0) + ' B/s';
            if (kbps < 1024) return kbps.toFixed(0) + ' KB/s';
            return (kbps / 1024).toFixed(1) + ' MB/s';
        }
        
        // 初始化
        document.addEventListener('DOMContentLoaded', () => {
            initPlayer();
            updatePlayerState();
            
            // 测试连接
            setInterval(() => {
                if (!socket.connected) {
                    addLog('尝试重新连接...', 'error');
                }
            }, 10000);
        });
    </script>
</body>
</html>
'''

if __name__ == '__main__':
    print("=" * 60)
    print("视频同步系统启动")
    print(f"访问地址: http://localhost:19134")
    print(f"WebSocket端口: 19134")
    print("=" * 60)
    socketio.run(app, 
                host='0.0.0.0', 
                port=19134, 
                debug=False, 
                allow_unsafe_werkzeug=True,
                use_reloader=False)
