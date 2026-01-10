from flask import Flask, request, render_template_string, jsonify
from flask_socketio import SocketIO, emit
import time
import uuid
import threading
from datetime import datetime
import logging

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

app = Flask(__name__)
app.config['SECRET_KEY'] = 'video_sync_secure_key_' + str(uuid.uuid4())
socketio = SocketIO(app, 
                   cors_allowed_origins="*", 
                   async_mode='threading',
                   ping_interval=30000, 
                   ping_timeout=60000)

# 全局播放状态
global_play_state = {
    "video_url": "",
    "current_time": 0.0,
    "is_playing": False,
    "is_muted": True,  # ✅ 仅占位，不再参与任何同步逻辑，完全无效
    "update_ts": time.time(),
    "session_id": str(uuid.uuid4())[:8],
    "last_sync_operation": None
}

# 设备管理
device_status = {}
DEVICE_PREFIX = "DEV-"
device_lock = threading.Lock()

# 配置参数 【保留音频同步优化参数，声音播放精准对齐】
CONFIG = {
    "STATE_LOCK": 0.3,           
    "SYNC_THRESHOLD": 0.3,       # 声音同步核心：人耳无感阈值
    "SYNC_INTERVAL": 800,        # 缩短间隔，进度无累积误差
    "SPEED_REPORT_INTERVAL": 1000,
    "HEARTBEAT_INTERVAL": 5000,
    "HEARTBEAT_TIMEOUT": 15000,
    "MIN_VALID_TIME": 0.1,
    "MAX_BUFFER_SYNC_DELAY": 1.5,
}

# 心跳监控线程
def heartbeat_monitor():
    """定期检查设备在线状态"""
    while True:
        time.sleep(CONFIG["HEARTBEAT_INTERVAL"] / 1000)
        current_time = time.time()
        offline_devices = []
        
        with device_lock:
            for sid, device in list(device_status.items()):
                last_seen = device.get("last_seen", 0)
                if current_time - last_seen > CONFIG["HEARTBEAT_TIMEOUT"] / 1000:
                    offline_devices.append(sid)
                    logger.info(f"设备 {device.get('device_id', sid[:8])} 心跳超时")
            
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
            "is_buffering": False,
            "online": True,
            "connected_at": time.time(),
            "last_seen": time.time(),
            "ip": request.remote_addr
        }
    
    emit('welcome', {
        "device_id": device_id,
        "session_id": global_play_state["session_id"],
        "server_time": time.time()
    })
    
    emit('sync_self', global_play_state)
    broadcast_device_status()
    
    logger.info(f"设备连接: {device_id} ({sid[:8]})")

@socketio.on('disconnect')
def handle_disconnect():
    """处理设备断开"""
    sid = request.sid
    with device_lock:
        if sid in device_status:
            del device_status[sid]
    
    broadcast_device_status()
    logger.info(f"设备断开: {sid[:8]}")

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
    if not isinstance(data, dict):
        return
    
    with device_lock:
        if sid in device_status:
            device_status[sid].update({
                "load_speed": round(data.get("load_speed", 0), 1),
                "buffer_progress": round(data.get("buffer_progress", 0), 1),
                "is_playing": data.get("is_playing", False),
                "is_buffering": data.get("is_buffering", False),
                "last_seen": time.time()
            })
    broadcast_device_status()

@socketio.on('get_init_state')
def send_init_state():
    """发送初始状态给设备"""
    emit('sync_self', global_play_state)

@socketio.on('send_state')
def handle_state_change(data):
    """处理状态变更 - 保留所有原修复：elif改if 解除状态阻断 + 缓冲不修改播放状态"""
    global global_play_state
    
    sid = request.sid
    now = time.time()
    
    if not isinstance(data, dict):
        return
    
    with device_lock:
        if sid in device_status:
            device_status[sid]["last_seen"] = now
    
    if now - global_play_state["update_ts"] < CONFIG["STATE_LOCK"]:
        return
    
    need_broadcast = False
    operation_type = None

    # 1. 视频源变更
    if "video_url" in data and data["video_url"] != global_play_state["video_url"]:
        video_url = data["video_url"]
        if not video_url:
            global_play_state.update({
                "video_url": "",
                "current_time": 0.0,
                "is_playing": False
            })
        else:
            global_play_state.update({
                "video_url": video_url,
                "current_time": 0.0,
                "is_playing": data.get("is_playing", True)
            })
        need_broadcast = True
        operation_type = "video_change"
        logger.info(f"设备 {sid[:8]} 切换视频")
    
    # 2. 播放/暂停状态变更
    if "is_playing" in data and data["is_playing"] != global_play_state["is_playing"]:
        if not global_play_state["video_url"] and data["is_playing"]:
            return
        
        is_buffering = data.get("is_buffering", False)
        if is_buffering and global_play_state["is_playing"]:
            logger.debug(f"设备 {sid[:8]} 缓冲中，忽略暂停状态")
            operation_type = "buffering_ignore"
        else:
            global_play_state["is_playing"] = data["is_playing"]
            need_broadcast = True
            operation_type = "play_pause"
            logger.info(f"设备 {sid[:8]} {'播放' if data['is_playing'] else '暂停'}")
    
    # 3. 进度变更
    if "current_time" in data and global_play_state["video_url"]:
        current_time = float(data["current_time"])
        
        if current_time < 0:
            return
        
        if current_time < CONFIG["MIN_VALID_TIME"] and global_play_state["current_time"] > 1:
            return
        
        time_diff = abs(global_play_state["current_time"] - current_time)
        if time_diff > CONFIG["SYNC_THRESHOLD"]:
            global_play_state["current_time"] = current_time
            need_broadcast = True
            operation_type = "seek"
            logger.debug(f"设备 {sid[:8]} 跳转进度: {current_time:.1f}s")
    
    # ✅【核心修改1：彻底删除 静音状态的同步逻辑】
    # 完全移除 is_muted 的判断和广播，服务端从此不处理任何音量/静音相关数据
    
    if need_broadcast:
        global_play_state["update_ts"] = now
        global_play_state["last_sync_operation"] = operation_type
        
        broadcast_data = {
            **global_play_state,
            "sync_id": str(uuid.uuid4())[:8],
            "timestamp": now
        }
        
        try:
            socketio.emit('sync_all', broadcast_data, skip_sid=sid)
            logger.debug(f"广播 {operation_type} 状态")
        except Exception as e:
            logger.error(f"广播失败: {e}")

@socketio.on('request_force_sync')
def handle_force_sync():
    """处理强制同步请求"""
    sid = request.sid
    logger.info(f"设备 {sid[:8]} 请求强制同步")
    emit('sync_all', {
        **global_play_state,
        "sync_id": str(uuid.uuid4())[:8],
        "timestamp": time.time(),
        "force_sync": True
    })

def broadcast_device_status():
    """广播设备状态"""
    with device_lock:
        online_devices = [
            {
                "device_id": v["device_id"],
                "load_speed": v["load_speed"],
                "buffer_progress": v["buffer_progress"],
                "is_playing": v.get("is_playing", False),
                "is_buffering": v.get("is_buffering", False),
                "online": v.get("online", False),
                "connected_at": v["connected_at"]
            }
            for v in device_status.values() if v.get("online", False)
        ]
    
    try:
        socketio.emit('device_status_update', {
            "online_count": len(online_devices),
            "devices": online_devices,
            "timestamp": time.time()
        })
    except Exception as e:
        logger.error(f"广播设备状态失败: {e}")

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
                "is_playing": v.get("is_playing", False),
                "is_buffering": v.get("is_buffering", False),
                "online": v.get("online", False)
            }
            for v in device_status.values()
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
    
    try:
        data = request.get_json()
        if not data:
            return jsonify({"status": "error", "message": "无效的JSON数据"})
        
        action = data.get('action')
        
        if action == 'play':
            video_url = data.get('video_url', '').strip()
            if not video_url:
                return jsonify({"status": "error", "message": "视频URL不能为空"})
            
            global_play_state.update({
                "video_url": video_url,
                "current_time": 0.0,
                "is_playing": True,
                "update_ts": time.time()
            })
            
            socketio.emit('sync_all', global_play_state)
            logger.info(f"API控制: 播放视频 {video_url[:50]}...")
            return jsonify({"status": "success", "message": "播放指令已发送"})
        
        elif action == 'pause':
            global_play_state["is_playing"] = False
            global_play_state["update_ts"] = time.time()
            
            socketio.emit('sync_all', global_play_state)
            logger.info("API控制: 暂停播放")
            return jsonify({"status": "success", "message": "暂停指令已发送"})
        
        elif action == 'seek':
            try:
                current_time = float(data.get('current_time', 0))
                if not 0 <= current_time <= 86400:
                    return jsonify({"status": "error", "message": "进度值必须在0-86400秒之间"})
                
                global_play_state["current_time"] = current_time
                global_play_state["update_ts"] = time.time()
                
                socketio.emit('sync_all', global_play_state)
                logger.info(f"API控制: 跳转到 {current_time} 秒")
                return jsonify({"status": "success", "message": f"跳转到 {current_time} 秒"})
            except ValueError:
                return jsonify({"status": "error", "message": "无效的进度值"})
        
        elif action == 'clear':
            global_play_state.update({
                "video_url": "",
                "current_time": 0.0,
                "is_playing": False,
                "update_ts": time.time()
            })
            
            socketio.emit('sync_all', global_play_state)
            logger.info("API控制: 清空视频")
            return jsonify({"status": "success", "message": "已清空视频"})
        
        elif action == 'force_sync':
            socketio.emit('sync_all', global_play_state)
            logger.info("API控制: 强制同步所有设备")
            return jsonify({"status": "success", "message": "强制同步指令已发送"})
        
        else:
            return jsonify({"status": "error", "message": "无效操作"})
    
    except Exception as e:
        logger.error(f"API控制错误: {e}")
        return jsonify({"status": "error", "message": f"服务器错误: {str(e)}"})

# HTML模板
MAIN_HTML = '''
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🎬 视频同步播放系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }
        
        .container { 
            max-width: 1400px; 
            margin: 0 auto; 
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .header-content { flex: 1; }
        h1 { font-size: 28px; font-weight: 600; margin-bottom: 8px; }
        .subtitle { font-size: 16px; opacity: 0.9; margin-bottom: 20px; }
        
        .stats { 
            display: flex; 
            gap: 25px; 
            font-size: 15px;
            flex-wrap: wrap;
        }
        .stat-item { 
            display: flex; 
            flex-direction: column;
            align-items: center;
            background: rgba(255,255,255,0.15);
            padding: 12px 20px;
            border-radius: 12px;
            min-width: 120px;
        }
        .stat-value { 
            font-size: 28px; 
            font-weight: 700; 
            margin-bottom: 5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        .stat-label { font-size: 13px; opacity: 0.9; }
        
        .card { 
            background: white; 
            border-radius: 16px; 
            box-shadow: 0 8px 30px rgba(0,0,0,0.08); 
            padding: 28px; 
            margin: 20px;
            transition: transform 0.3s ease;
        }
        .card:hover { 
            transform: translateY(-3px);
        }
        
        h2 { 
            color: #4a5568; 
            font-size: 22px; 
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .control-panel { 
            display: grid; 
            grid-template-columns: 1fr auto;
            gap: 15px; 
            margin-bottom: 20px; 
            align-items: center; 
        }
        @media (max-width: 768px) {
            .control-panel { grid-template-columns: 1fr; }
        }
        
        .url-input { 
            flex: 1; 
            padding: 14px 18px; 
            border: 2px solid #e2e8f0; 
            border-radius: 12px; 
            font-size: 15px; 
            transition: all 0.3s;
            background: #f8fafc;
        }
        .url-input:focus { 
            outline: none; 
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn-group { 
            display: flex; 
            gap: 12px; 
            flex-wrap: wrap; 
        }
        .btn { 
            padding: 14px 24px; 
            border: none; 
            border-radius: 12px; 
            cursor: pointer; 
            font-size: 15px; 
            font-weight: 600;
            transition: all 0.3s; 
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-width: 120px;
        }
        .btn-primary { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            color: white; 
        }
        .btn-primary:hover { 
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        .btn-danger { 
            background: #f56565; 
            color: white; 
        }
        .btn-danger:hover { 
            background: #e53e3e; 
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(245, 101, 101, 0.4);
        }
        .btn-info { 
            background: #4299e1; 
            color: white; 
        }
        .btn-info:hover { 
            background: #3182ce; 
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(66, 153, 225, 0.4);
        }
        
        .video-container { 
            position: relative; 
            width: 100%; 
            margin-bottom: 25px; 
            background: #000; 
            border-radius: 16px; 
            overflow: hidden; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        video { 
            width: 100%; 
            height: auto;
            max-height: 600px;
            display: block; 
            outline: none;
        }
        
        .video-info { 
            margin-top: 15px; 
            color: #4a5568; 
            font-size: 14px; 
            padding: 20px; 
            background: #f8fafc; 
            border-radius: 12px; 
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        .video-info-item { display: flex; flex-direction: column; }
        .video-info-label { font-weight: 600; color: #718096; margin-bottom: 5px; font-size: 13px; }
        .video-info-value { font-weight: 500; color: #2d3748; font-size: 15px; word-break: break-all; }
        
        .device-panel { marginTop: 10px; }
        .device-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); 
            gap: 20px; 
            margin-top: 20px; 
        }
        .device-card { 
            border: 1px solid #e2e8f0; 
            border-radius: 14px; 
            padding: 20px; 
            background: white;
            transition: all 0.3s;
            border-left: 4px solid #48bb78;
        }
        .device-card:hover { 
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .device-header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            margin-bottom: 15px; 
            padding-bottom: 12px;
            border-bottom: 1px solid #e2e8f0;
        }
        .device-id { 
            font-weight: 700; 
            color: #2d3748; 
            font-size: 16px;
        }
        .device-status { 
            padding: 4px 12px; 
            border-radius: 20px; 
            font-size: 12px; 
            font-weight: 600;
        }
        .status-online { background: #c6f6d5; color: #22543d; }
        .status-buffering { background: #fed7d7; color: #742a2a; }
        .status-paused { background: #e9d8fd; color: #553c9a; }
        
        .device-metrics { display: grid; gap: 12px; }
        .metric { 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
        }
        .metric-label { color: #718096; font-size: 14px; }
        .metric-value { 
            font-weight: 600; 
            font-size: 15px;
        }
        .progress-bar { 
            height: 8px; 
            background: #e2e8f0; 
            border-radius: 4px; 
            margin-top: 6px; 
            overflow: hidden; 
        }
        .progress-fill { 
            height: 100%; 
            background: linear-gradient(90deg, #48bb78, #38a169);
            border-radius: 4px; 
            transition: width 0.5s ease;
        }
        
        .log-panel { 
            font-family: 'SF Mono', 'Monaco', 'Inconsolata', monospace; 
            font-size: 13px; 
            max-height: 300px; 
            overflow-y: auto; 
            padding: 20px; 
            background: #1a202c; 
            border-radius: 12px; 
            color: #cbd5e0;
        }
        .log-entry { 
            padding: 8px 0; 
            border-bottom: 1px solid #2d3748; 
            line-height: 1.5;
        }
        
        .message-area { 
            position: fixed; 
            top: 20px; 
            right: 20px; 
            z-index: 1000; 
            max-width: 400px;
        }
        .message { 
            padding: 16px 20px; 
            border-radius: 12px; 
            margin-bottom: 10px; 
            animation: slideIn 0.3s ease;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        .message.success { background: #48bb78; color: white; }
        .message.error { background: #f56565; color: white; }
        .message.info { background: #4299e1; color: white; }
        .message.warning { background: #ed8936; color: white; }
        
        .loading { 
            text-align: center; 
            padding: 40px; 
            color: #a0aec0; 
            font-size: 16px;
        }
        
        .connection-status {
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 10px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            z-index: 100;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .connected { background: #48bb78; color: white; }
        .disconnected { background: #f56565; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-content">
                <h1>🎬 视频同步播放系统</h1>
                <div class="subtitle">实时同步播放、进度 | 音量独立控制 | 多设备监控 | 优化缓冲处理</div>
            </div>
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-value" id="online-count">0</div>
                    <div class="stat-label">在线设备</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="session-id">-</div>
                    <div class="stat-label">同步会话</div>
                </div>
            </div>
        </div>

        <div class="card">
            <h2>视频控制</h2>
            <div class="control-panel">
                <input type="text" class="url-input" id="video-url" 
                       placeholder="输入视频URL (支持MP4、M3U8、FLV等格式)" 
                       value="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4">
                <div class="btn-group">
                    <button class="btn btn-primary" onclick="playVideo()">▶️ 播放/同步</button>
                    <button class="btn btn-danger" onclick="pauseVideo()">⏸️ 暂停</button>
                    <button class="btn btn-info" onclick="seekVideo(30)">⏩ +30秒</button>
                    <button class="btn btn-info" onclick="seekVideo(-30)">⏪ -30秒</button>
                    <button class="btn" onclick="forceSync()">🔄 强制同步</button>
                    <button class="btn" onclick="clearVideo()">🗑️ 清空</button>
                </div>
            </div>
        </div>

        <div class="card">
            <h2>视频播放器</h2>
            <div class="video-container">
                <video id="player" controls playsinline preload="auto" crossorigin="anonymous">
                    您的浏览器不支持HTML5视频播放
                </video>
            </div>
            <div class="video-info">
                <div class="video-info-item">
                    <div class="video-info-label">当前视频:</div>
                    <div class="video-info-value" id="current-url">无</div>
                </div>
                <div class="video-info-item">
                    <div class="video-info-label">播放状态:</div>
                    <div class="video-info-value" id="player-state">等待播放</div>
                </div>
                <div class="video-info-item">
                    <div class="video-info-label">播放进度:</div>
                    <div class="video-info-value" id="progress-display">0:00 / 0:00</div>
                </div>
                <div class="video-info-item">
                    <div class="video-info-label">加载速度:</div>
                    <div class="video-info-value" id="load-speed">0 KB/s</div>
                </div>
                <div class="video-info-item">
                    <div class="video-info-label">缓冲进度:</div>
                    <div class="video-info-value" id="buffer-progress">0%</div>
                </div>
            </div>
        </div>

        <div class="card device-panel">
            <h2>设备监控 (<span id="device-count">0</span> 台在线)</h2>
            <div id="device-grid" class="device-grid">
                <div class="loading">正在加载设备列表...</div>
            </div>
        </div>

        <div class="card">
            <h2>同步日志</h2>
            <div id="sync-log" class="log-panel">
                <div class="log-entry">系统就绪，等待连接...</div>
            </div>
        </div>
    </div>

    <div id="message-area" class="message-area"></div>
    <div id="connection-status" class="connection-status disconnected">连接中...</div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.0.1/socket.io.js"></script>
    <script>
        const socket = io();
        const player = document.getElementById('player');
        
        let playerState = {
            isPlaying: false,
            currentTime: 0,
            isDragging: false,
            isBuffering: false,
            lastSyncTs: 0,
            currentVideoUrl: '',
            loadSpeed: 0,
            bufferProgress: 0,
            lastSpeedCalcTime: Date.now(),
            lastBufferBytes: 0,
            latency: 0,
            deviceId: null
        };
        
        let syncSession = null;
        const SYNC_INTERVAL = {{ config.SYNC_INTERVAL }};
        const SYNC_THRESHOLD = {{ config.SYNC_THRESHOLD }};
        const SPEED_REPORT_INTERVAL = {{ config.SPEED_REPORT_INTERVAL }};
        const HEARTBEAT_INTERVAL = {{ config.HEARTBEAT_INTERVAL }};
        
        // Socket.io 事件处理
        socket.on('connect', () => {
            updateConnectionStatus(true);
            addLog('✅ 已连接到服务器', 'success');
            socket.emit('get_init_state');
            startHeartbeat();
        });
        
        socket.on('disconnect', () => {
            updateConnectionStatus(false);
            addLog('❌ 与服务器断开连接', 'error');
        });
        
        socket.on('connect_error', (error) => {
            updateConnectionStatus(false);
            addLog('❌ 连接错误: ' + error.message, 'error');
        });
        
        socket.on('welcome', (data) => {
            playerState.deviceId = data.device_id;
            syncSession = data.session_id;
            document.getElementById('session-id').textContent = syncSession;
            addLog(`🎉 欢迎设备: ${data.device_id}`, 'success');
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
        
        // ✅ 保留所有核心修复：播放状态优先级置顶 + 进度同步后强制续播 + 无感知进度校准
        // ✅【核心修改2：彻底删除 静音状态的同步逻辑】播放器静音/音量完全本地独立控制
        function handleSync(state, isSelf) {
            const prefix = isSelf ? '🔄 初始化同步' : '🔄 全局同步';
            addLog(`${prefix}: ${state.is_playing ? '播放' : '暂停'} @ ${state.current_time.toFixed(1)}s`, 'info', state.sync_id);
            
            syncSession = state.session_id;
            document.getElementById('session-id').textContent = syncSession;
            
            const needPlay = state.is_playing === true;
            playerState.isPlaying = needPlay;

            // 视频源变更处理
            if (state.video_url && state.video_url !== playerState.currentVideoUrl) {
                const videoUrlDisplay = state.video_url.length > 60 ? state.video_url.substring(0, 60) + '...' : state.video_url;
                addLog(`📹 加载视频: ${videoUrlDisplay}`, 'info');
                playerState.currentVideoUrl = state.video_url;
                player.src = state.video_url;
                document.getElementById('current-url').textContent = videoUrlDisplay;
                
                player.load();
                
                const loadHandler = () => {
                    if (state.current_time > 0 && Math.abs(player.currentTime - state.current_time) > 0.5) {
                        player.currentTime = state.current_time;
                    }
                    if(needPlay) player.play().catch(()=>{});
                    player.removeEventListener('loadedmetadata', loadHandler);
                };
                player.addEventListener('loadedmetadata', loadHandler);
                
                showMessage('正在加载视频...', 'info');
            } 
            else if (!state.video_url && playerState.currentVideoUrl) {
                player.pause();
                player.src = '';
                player.load();
                playerState.currentVideoUrl = '';
                document.getElementById('current-url').textContent = '无';
                playerState.isPlaying = false;
                updatePlayerState();
                return;
            }
            
            // 进度同步逻辑
            if (state.video_url && Math.abs(player.currentTime - state.current_time) > SYNC_THRESHOLD) {
                if (!playerState.isDragging) {
                    const wasPlaying = playerState.isPlaying;
                    if(wasPlaying) player.pause();
                    player.currentTime = state.current_time.toFixed(2);
                    if(wasPlaying) player.play().catch(err => console.warn("音频对齐兜底:", err));
                }
            }
            
            // 强制续播核心修复
            if (needPlay && playerState.currentVideoUrl) {
                player.play().catch(err => {
                    console.warn("自动播放兜底:", err);
                    addLog('⚠️ 浏览器限制自动播放，手动点击播放即可', 'warning');
                });
            } else if(!needPlay) {
                player.pause();
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
                
                const now = Date.now();
                if (playerState.isPlaying && now - playerState.lastSyncTs > SYNC_INTERVAL) {
                    if (!playerState.isDragging) {
                        socket.emit('send_state', { 
                            current_time: player.currentTime.toFixed(2),
                            is_buffering: playerState.isBuffering,
                            is_playing: playerState.isPlaying
                        });
                    }
                    playerState.lastSyncTs = now;
                }
            });
            
            player.addEventListener('play', () => {
                if (!playerState.isPlaying && playerState.currentVideoUrl) {
                    playerState.isPlaying = true;
                    socket.emit('send_state', { 
                        is_playing: true,
                        is_buffering: false
                    });
                    addLog('▶️ 开始播放', 'success');
                }
            });
            
            player.addEventListener('pause', () => {
                if (playerState.isPlaying && !playerState.isBuffering) {
                    playerState.isPlaying = false;
                    socket.emit('send_state', { 
                        is_playing: false,
                        is_buffering: false
                    });
                    addLog('⏸️ 暂停播放', 'info');
                }
            });
            
            player.addEventListener('seeking', () => {
                playerState.isDragging = true;
                addLog('⏩ 正在跳转...', 'info');
            });
            
            // ✅ 核心修复：拖动完成发送进度+播放状态
            player.addEventListener('seeked', () => {
                playerState.isDragging = false;
                playerState.currentTime = player.currentTime;
                socket.emit('send_state', { 
                    current_time: player.currentTime.toFixed(2),
                    is_buffering: playerState.isBuffering,
                    is_playing: playerState.isPlaying
                });
                addLog(`⏩ 跳转到 ${formatTime(player.currentTime)}`, 'info');
            });
            
            // ✅【核心修改3：彻底删除 音量变化的同步事件】本地调音量/静音不再发送任何请求
            // 移除 volumechange 事件监听，播放器音量完全独立
            
            // 缓冲事件处理
            let bufferingTimer = null;
            
            player.addEventListener('waiting', () => {
                if (!playerState.isBuffering) {
                    playerState.isBuffering = true;
                    addLog('⏳ 缓冲中...', 'info');
                    showMessage('缓冲中...', 'warning');
                    
                    socket.emit('send_state', { 
                        is_buffering: true,
                        is_playing: playerState.isPlaying
                    });
                    
                    if (socket.connected) {
                        socket.emit('report_player_metrics', {
                            load_speed: playerState.loadSpeed,
                            buffer_progress: playerState.bufferProgress,
                            is_playing: playerState.isPlaying,
                            is_buffering: true
                        });
                    }
                }
                updatePlayerState();
            });
            
            player.addEventListener('playing', () => {
                if (playerState.isBuffering) {
                    playerState.isBuffering = false;
                    addLog('✅ 缓冲完成，继续播放', 'success');
                    showMessage('缓冲完成', 'success');
                    
                    socket.emit('send_state', { 
                        is_buffering: false,
                        is_playing: playerState.isPlaying
                    });
                }
                updatePlayerState();
            });
            
            player.addEventListener('canplay', () => {
                if (playerState.isBuffering) {
                    playerState.isBuffering = false;
                }
                updatePlayerState();
            });
            
            player.addEventListener('canplaythrough', () => {
                if (playerState.isBuffering) {
                    playerState.isBuffering = false;
                }
                updatePlayerState();
            });
            
            player.addEventListener('error', (e) => {
                const error = player.error;
                let message = '视频播放错误';
                if (error) {
                    switch(error.code) {
                        case 1: message = '视频加载被中止'; break;
                        case 2: message = '网络错误，请检查网络连接'; break;
                        case 3: message = '视频解码错误，可能格式不支持'; break;
                        case 4: message = '视频格式不支持'; break;
                    }
                }
                addLog(`❌ ${message}`, 'error');
                showMessage(message, 'error');
            });
            
            player.addEventListener('emptied', () => {
                playerState.isPlaying = false;
                playerState.isBuffering = false;
                updatePlayerState();
            });
            
            setInterval(() => {
                if (player.buffered.length > 0 && player.duration) {
                    const bufferedEnd = player.buffered.end(player.buffered.length - 1);
                    playerState.bufferProgress = (bufferedEnd / player.duration) * 100 || 0;
                    
                    const now = Date.now();
                    const timeDiff = (now - playerState.lastSpeedCalcTime) / 1000;
                    if (timeDiff >= 1) {
                        const bufferBytes = (bufferedEnd * (player.videoBitrate || 2000000)) / 8;
                        const bytesDiff = Math.max(0, bufferBytes - playerState.lastBufferBytes);
                        playerState.loadSpeed = (bytesDiff / 1024) / timeDiff;
                        playerState.lastSpeedCalcTime = now;
                        playerState.lastBufferBytes = bufferBytes;
                        
                        document.getElementById('load-speed').textContent = formatSpeed(playerState.loadSpeed);
                        document.getElementById('buffer-progress').textContent = playerState.bufferProgress.toFixed(1) + '%';
                    }
                    
                    if (socket.connected) {
                        socket.emit('report_player_metrics', {
                            load_speed: playerState.loadSpeed,
                            buffer_progress: playerState.bufferProgress,
                            is_playing: playerState.isPlaying,
                            is_buffering: playerState.isBuffering
                        });
                    }
                }
            }, SPEED_REPORT_INTERVAL);
            
            addLog('✅ 播放器初始化完成，音量独立控制模式', 'success');
        }
        
        function startHeartbeat() {
            setInterval(() => {
                if (socket.connected) {
                    socket.emit('heartbeat');
                }
            }, HEARTBEAT_INTERVAL);
        }
        
        // 控制函数
        function playVideo() {
            const urlInput = document.getElementById('video-url');
            const url = urlInput.value.trim();
            
            if (!url) {
                showMessage('请输入视频URL', 'error');
                return;
            }
            
            if (!url.startsWith('http://') && !url.startsWith('https://')) {
                showMessage('URL必须以 http:// 或 https:// 开头', 'error');
                return;
            }
            
            showMessage('正在发送播放指令...', 'info');
            addLog(`📤 发送播放指令: ${url.substring(0, 50)}...`, 'info');
            
            // ✅【核心修改4：发送播放指令时 移除 is_muted 字段】
            socket.emit('send_state', {
                video_url: url,
                current_time: 0,
                is_playing: true,
                is_buffering: false
            });
        }
        
        function pauseVideo() {
            if (!playerState.currentVideoUrl) {
                showMessage('没有正在播放的视频', 'warning');
                return;
            }
            
            socket.emit('send_state', { 
                is_playing: false,
                is_buffering: false
            });
            showMessage('已发送暂停指令', 'info');
        }
        
        function seekVideo(seconds) {
            if (!playerState.currentVideoUrl || !player.duration) {
                showMessage('没有正在播放的视频', 'warning');
                return;
            }
            
            const newTime = Math.max(0, Math.min(player.currentTime + seconds, player.duration));
            player.currentTime = newTime;
            socket.emit('send_state', { 
                current_time: newTime.toFixed(2),
                is_buffering: false,
                is_playing: playerState.isPlaying
            });
            addLog(`⏩ 跳转 ${seconds > 0 ? '+' : ''}${seconds}秒`, 'info');
        }
        
        function clearVideo() {
            if (!playerState.currentVideoUrl) {
                showMessage('没有正在播放的视频', 'info');
                return;
            }
            
            // ✅【核心修改5：清空视频时 移除 is_muted 字段】
            socket.emit('send_state', { 
                video_url: '',
                current_time: 0,
                is_playing: false,
                is_buffering: false
            });
            showMessage('视频已清空', 'success');
        }
        
        function forceSync() {
            socket.emit('request_force_sync');
            showMessage('正在强制同步...', 'info');
        }
        
        // 工具函数 无修改
        function updatePlayerState() {
            const stateText = !playerState.currentVideoUrl ? '等待播放' : 
                             playerState.isBuffering ? '缓冲中...' :
                             playerState.isPlaying ? '播放中' : '暂停';
            
            document.getElementById('player-state').textContent = stateText;
            const progressDisplay = document.getElementById('progress-display');
            
            if (progressDisplay) {
                progressDisplay.textContent = `${formatTime(player.currentTime)} / ${formatTime(player.duration)}`;
            }
        }
        
        function updateDevicePanel(data) {
            const grid = document.getElementById('device-grid');
            const countEl = document.getElementById('online-count');
            const deviceCountEl = document.getElementById('device-count');
            
            if (!grid || !countEl) return;
            
            countEl.textContent = data.online_count;
            if (deviceCountEl) deviceCountEl.textContent = data.online_count;
            
            if (data.online_count === 0) {
                grid.innerHTML = '<div class="loading">等待设备连接...</div>';
                return;
            }
            
            let html = '';
            data.devices.forEach(device => {
                const speedText = formatSpeed(device.load_speed);
                const isBuffering = device.is_buffering;
                const isPlaying = device.is_playing;
                
                let status = '在线';
                let statusClass = 'status-online';
                
                if (isBuffering) {
                    status = '缓冲中';
                    statusClass = 'status-buffering';
                } else if (!isPlaying) {
                    status = '已暂停';
                    statusClass = 'status-paused';
                }
                
                html += `
                    <div class="device-card">
                        <div class="device-header">
                            <div class="device-id">${device.device_id}</div>
                            <div class="device-status ${statusClass}">${status}</div>
                        </div>
                        <div class="device-metrics">
                            <div class="metric">
                                <span class="metric-label">IP地址:</span>
                                <span class="metric-value">${device.ip || '未知'}</span>
                            </div>
                            <div class="metric">
                                <span class="metric-label">加载速度:</span>
                                <span class="metric-value">${speedText}</span>
                            </div>
                            <div class="metric">
                                <span class="metric-label">缓冲进度:</span>
                                <span class="metric-value">${device.buffer_progress.toFixed(1)}%</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${Math.min(100, device.buffer_progress)}%"></div>
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
            const typeIcon = {
                'error': '❌',
                'success': '✅',
                'info': 'ℹ️',
                'warning': '⚠️'
            }[type] || 'ℹ️';
            
            const syncHtml = syncId ? `[${syncId}] ` : '';
            
            const logEntry = document.createElement('div');
            logEntry.className = 'log-entry';
            logEntry.textContent = `${typeIcon} [${time}] ${syncHtml}${message}`;
            
            logPanel.appendChild(logEntry);
            logPanel.scrollTop = logPanel.scrollHeight;
            
            const logs = logPanel.querySelectorAll('.log-entry');
            if (logs.length > 100) {
                logs[0].remove();
            }
        }
        
        function showMessage(message, type = 'info') {
            const messageArea = document.getElementById('message-area');
            if (!messageArea) return;
            
            const messageEl = document.createElement('div');
            messageEl.className = `message ${type}`;
            messageEl.textContent = message;
            
            messageArea.appendChild(messageEl);
            
            setTimeout(() => {
                if (messageEl.parentNode === messageArea) {
                    messageArea.removeChild(messageEl);
                }
            }, type === 'error' ? 5000 : 3000);
        }
        
        function updateConnectionStatus(connected) {
            const statusEl = document.getElementById('connection-status');
            if (!statusEl) return;
            
            if (connected) {
                statusEl.className = 'connection-status connected';
                statusEl.textContent = '已连接';
            } else {
                statusEl.className = 'connection-status disconnected';
                statusEl.textContent = '连接断开';
            }
        }
        
        function formatTime(seconds) {
            if (!seconds || seconds < 0 || !isFinite(seconds)) return '0:00';
            const mins = Math.floor(seconds / 60);
            const secs = Math.floor(seconds % 60);
            return `${mins}:${secs.toString().padStart(2, '0')}`;
        }
        
        function formatSpeed(kbps) {
            if (!kbps || kbps < 0) return '0 B/s';
            if (kbps < 1) return (kbps * 1024).toFixed(0) + ' B/s';
            if (kbps < 1024) return kbps.toFixed(0) + ' KB/s';
            return (kbps / 1024).toFixed(1) + ' MB/s';
        }
        
        // 初始化
        document.addEventListener('DOMContentLoaded', () => {
            initPlayer();
            updatePlayerState();
            
            setInterval(() => {
                if (!socket.connected) {
                    addLog('尝试重新连接服务器...', 'warning');
                }
            }, 5000);
            
            window.addEventListener('beforeunload', () => {
                if (socket.connected) {
                    socket.disconnect();
                }
            });
            
            document.getElementById('video-url').addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    playVideo();
                }
            });
            
            addLog('🚀 系统初始化完成，等待连接...(音量独立控制)', 'success');
        });
    </script>
</body>
</html>
'''

if __name__ == '__main__':
    print("=" * 60)
    print("🎬 视频同步播放系统 v4.0 [最终版]")
    print("✅ 保留所有修复：播放中拖动进度条不暂停、缓冲不打断播放")
    print("✅ 音量/静音 完全独立控制，永不同步，各设备互不影响")
    print("✅ 视频+声音播放精准同步，无错位")
    print("=" * 60)
    print(f"🌐 访问地址: http://localhost:19134")
    print(f"📡 WebSocket端口: 19134")
    print(f"📊 监控面板: http://localhost:19134/api/status")
    print("=" * 60)
    print("🔄 系统已启动，等待设备连接...")
    
    try:
        socketio.run(app, 
                    host='0.0.0.0', 
                    port=19134, 
                    debug=False, 
                    allow_unsafe_werkzeug=True,
                    use_reloader=False)
    except KeyboardInterrupt:
        print("\n👋 系统正在关闭...")
    except Exception as e:
        logger.error(f"启动失败: {e}")
        print(f"❌ 启动失败: {e}")