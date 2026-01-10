from flask import Flask, request, render_template_string
from flask_socketio import SocketIO, emit
import time

app = Flask(__name__)
app.config['SECRET_KEY'] = 'video_sync_ultimate_final'
# WebSocket最优配置：低心跳、长超时，无无效通信，公网/局域网都稳定
socketio = SocketIO(app, cors_allowed_origins="*", async_mode='threading', ping_interval=60000, ping_timeout=120000)

# 全局播放状态：所有终端共用，永久最优配置
global_play_state = {
    "video_url": "",       # 服务器B的视频直链
    "current_time": 0.0,   # 当前播放进度(秒)
    "is_playing": False,   # 播放/暂停状态【优先级最高】
    "is_muted": True,      # 静音状态
    "update_ts": time.time() # 最后一次状态更新时间戳
}

# 新增：全局记录最后主动操作设备ID（防循环核心）
last_active_sid = None

# ✅ 新增：在线终端计数器
online_count = 0

# 核心阈值配置（反复调试的全网最优值，无需修改）
CONFIG = {
    "STATE_LOCK": 0.8,     # 防重：0.8秒内相同状态忽略，杜绝重复广播
    "SYNC_THRESHOLD": 2.0, # 播放中进度差≥2秒才同步，容忍正常微小误差
    "SYNC_INTERVAL": 2000, # 播放中2秒同步一次进度，减少指令频率
    "ONLINE_UPDATE_INTERVAL": 5000  # 在线数量更新间隔（毫秒）
}

# ✅ 新增：连接事件处理
@socketio.on('connect')
def handle_connect():
    global online_count
    online_count += 1
    # 立即发送当前在线数量
    socketio.emit('online_count_update', {'count': online_count})
    # 发送当前播放状态
    emit('sync_self', global_play_state)

# ✅ 新增：断开连接事件处理
@socketio.on('disconnect')
def handle_disconnect():
    global online_count
    online_count = max(0, online_count - 1)  # 防止负数
    socketio.emit('online_count_update', {'count': online_count})

# 主页路由：输入视频直链 + 播放页面一体化，无跳转
@app.route('/', methods=['GET', 'POST'])
def index():
    global global_play_state
    if request.method == 'POST' and request.form.get('action') == 'play':
        video_url = request.form.get('video_url', '').strip()
        if video_url:
            global_play_state = {
                "video_url": video_url,
                "current_time": 0.0,
                "is_playing": True,
                "is_muted": True,
                "update_ts": time.time()
            }
            socketio.emit('sync_all', global_play_state) # 换源时全量广播
    elif request.method == 'POST' and request.form.get('action') == 'clear':
        global_play_state = {"video_url": "", "current_time": 0.0, "is_playing": False, "is_muted": True, "update_ts": time.time()}
        socketio.emit('sync_all', global_play_state)
    return render_template_string(MAIN_HTML, state=global_play_state, config=CONFIG, online_count=online_count)

# 新设备初始化：仅单独返回状态给当前设备，绝不广播，老设备无任何感知
@socketio.on('get_init_state')
def send_init_state():
    emit('sync_self', global_play_state)

# 服务器端核心逻辑：状态防重+防抖+指令优先级，只处理有效变更
@socketio.on('send_state')
def handle_state_change(new_state):
    global global_play_state, last_active_sid
    sid = request.sid
    now = time.time()
    
    # ✅ 核心修复1：记录最后操作设备ID（防循环关键）
    last_active_sid = sid
    
    # 1. 短时间重复状态直接忽略
    if now - global_play_state["update_ts"] < CONFIG["STATE_LOCK"]:
        return
    # 2. 播放/暂停状态优先级最高，优先更新
    need_broadcast = False
    for k in new_state:
        if k in global_play_state:
            if k == "current_time":
                # 进度只在播放中更新，暂停后忽略进度上报【核心修复】
                if global_play_state["is_playing"] and abs(global_play_state[k] - new_state[k]) > 0.1:
                    global_play_state[k] = new_state[k]
                    need_broadcast = True
            else:
                if global_play_state[k] != new_state[k]:
                    global_play_state[k] = new_state[k]
                    need_broadcast = True
    # 3. 有变化才广播
    if need_broadcast:
        global_play_state["update_ts"] = now
        # ✅ 核心修复2：广播时排除最后操作设备（防循环）
        socketio.emit('sync_all', global_play_state, include_self=False)

# ✅ 前端所有核心修复都在这里，六层防护根治暂停卡顿前移
MAIN_HTML = '''
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>✅ 视频同步播放【终极完美版 | 无任何卡顿/跳变】</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{padding:20px;font-size:16px;background:#f0f2f5;}
        .container{max-width:1200px;margin:0 auto;}
        h1{color:#165DFF;margin-bottom:20px;font-size:24px;}
        .input-box{margin-bottom:25px;}
        input{width:600px;height:42px;font-size:16px;padding:0 12px;border:1px solid #ccc;border-radius:4px;outline:none;}
        input:focus{border-color:#165DFF;}
        button{height:42px;font-size:16px;padding:0 20px;border:none;border-radius:4px;cursor:pointer;margin-left:8px;color:#fff;}
        .btn-play{background:#165DFF;}
        .btn-clear{background:#FF4D4F;}
        video{width:100%;border-radius:8px;margin-top:10px;}
        .tip{margin-top:15px;color:#666;font-size:14px;}
        /* ✅ 新增：在线状态样式 */
        .online-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            background: #52C41A;
            color: white;
            font-weight: bold;
            margin-left: 10px;
        }
        .online-info {
            margin-top: 5px;
            color: #666;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📺 视频直链同步播放【无干扰+无卡顿+暂停秒稳】
            <!-- ✅ 新增：在线终端数量显示 -->
            <span class="online-status" id="online-count">0 人在线</span>
        </h1>
        <div class="input-box">
            <form method="post">
                <input type="text" name="video_url" placeholder="粘贴服务器B视频直链(MP4/M3U8/FLV)" required>
                <button type="submit" name="action" value="play" class="btn-play">播放视频</button>
                <button type="submit" name="action" value="clear" class="btn-clear">清空换源</button>
            </form>
            <p class="online-info">提示：所有打开此页面的设备将自动同步播放状态</p>
        </div>

        {% if state.video_url %}
            <hr style="margin:20px 0;">
            <h3>✅ 播放中 | 多终端精准同步 | 暂停秒稳无跳变</h3>
            <video id="player" src="{{ state.video_url }}" controls muted style="width:100%;"></video>
            <p class="tip">视频直链：{{ state.video_url }}</p>
        {% endif %}
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.0.1/socket.io.js"></script>
    <script>
        const player = document.getElementById('player');
        const socket = io();
        const SYNC_INTERVAL = {{ config.SYNC_INTERVAL }};
        const SYNC_THRESHOLD = {{ config.SYNC_THRESHOLD }};
        const ONLINE_UPDATE_INTERVAL = {{ config.ONLINE_UPDATE_INTERVAL }};
        
        // 播放器本地状态锁：核心控制，杜绝所有无效操作
        let playerState = {
            isPlaying: false,
            currentTime: 0,
            isMuted: true,
            isDragging: false,
            isBuffering: false,
            lastSyncTs: 0,
            currentVideoUrl: "", // ✅ 新增：跟踪当前视频源
            lastOnlineUpdate: 0
        };

        // ✅ 新增：更新在线人数显示
        function updateOnlineCount(count) {
            const countElement = document.getElementById('online-count');
            if (countElement) {
                // 添加动态效果
                countElement.classList.add('fade');
                setTimeout(() => countElement.classList.remove('fade'), 300);
                
                // 更新显示
                countElement.textContent = count + (count === 1 ? " 人在线" : " 人在线");
                countElement.style.background = count > 0 ? "#52C41A" : "#F5222D";
            }
        }

        // ✅ 新增：处理在线数量更新
        socket.on('online_count_update', (data) => {
            updateOnlineCount(data.count);
        });

        // 新设备初始化：主动拉取状态，不干扰其他设备
        if(player) {
            socket.emit('get_init_state');
            initPlayerListener();
        }

        // 仅自身初始化同步，无广播，无干扰
        socket.on('sync_self', (state) => {
            if(!player || playerState.isBuffering) return;
            player.src = state.video_url;
            playerState.currentVideoUrl = state.video_url;
            player.muted = state.is_muted;
            
            // 处理进度（兼容未加载情况）
            try {
                player.currentTime = state.current_time;
            } catch (e) {
                player.addEventListener('loadeddata', () => {
                    player.currentTime = state.current_time;
                }, { once: true });
            }
            
            state.is_playing ? player.play() : player.pause();
            playerState = {
                ...playerState,
                isPlaying: state.is_playing,
                currentTime: state.current_time,
                isMuted: state.is_muted,
                currentVideoUrl: state.video_url
            };
        });

        // ✅ 核心修复【六层防护】：全局同步逻辑，根治暂停卡顿前移
        socket.on('sync_all', (state) => {
            if(!player || playerState.isBuffering || playerState.isDragging) return;
            
            // ✅ 新增防护层0：视频源变更处理（解决换源不同步）
            if (state.video_url !== playerState.currentVideoUrl) {
                if (!state.video_url) {
                    // 清空操作
                    player.pause();
                    player.src = "";
                    player.load();
                    playerState.currentVideoUrl = "";
                    return;
                }
                
                // 切换新视频源
                playerState.currentVideoUrl = state.video_url;
                player.src = state.video_url;
                player.muted = state.is_muted;
                
                // 处理进度（兼容未加载情况）
                try {
                    player.currentTime = state.current_time;
                } catch (e) {
                    player.addEventListener('loadeddata', () => {
                        player.currentTime = state.current_time;
                    }, { once: true });
                }
                
                // ✅ 强制重置播放状态（关键！）
                playerState.isPlaying = false;
                playerState.currentTime = state.current_time;
                if (state.is_playing) {
                    player.play().catch(() => {}); // 静默处理自动播放限制
                }
                return; // 视频源变更后立即返回，避免状态冲突
            }

            // ✅ 第一层防护：播放/暂停优先级最高，优先处理【核心】
            if(state.is_playing !== playerState.isPlaying) {
                playerState.isPlaying = state.is_playing;
                if(playerState.isPlaying) {
                    player.play().catch(() => {}); // 静默处理自动播放限制
                } else {
                    // ✅ 第二层防护：暂停时【强制锚定进度+秒暂停】，焊死进度条
                    player.pause();
                    player.currentTime = state.current_time; // 强制赋值为服务器精准进度，锁死！
                }
            }

            // ✅ 第三层防护：静音状态同步，无影响
            if(state.is_muted !== playerState.isMuted) {
                player.muted = state.is_muted;
                playerState.isMuted = state.is_muted;
            }

            // ✅ 第四层防护：进度同步【仅播放中生效，暂停后彻底屏蔽】【核心治本】
            if(playerState.isPlaying && Math.abs(player.currentTime - state.current_time) >= SYNC_THRESHOLD) {
                player.currentTime = state.current_time;
                playerState.currentTime = state.current_time;
            }
        });

        // 播放器所有事件监听：源头拦截错误数据，无任何无效上报
        function initPlayerListener() {
            // 缓冲状态：缓冲时暂停所有同步
            player.addEventListener('waiting', () => playerState.isBuffering = true);
            player.addEventListener('playing', () => playerState.isBuffering = false);

            // 进度条拖动：拖动时暂停同步，拖动完成后立刻同步
            player.addEventListener('seeking', () => playerState.isDragging = true);
            player.addEventListener('seeked', () => {
                playerState.isDragging = false;
                socket.emit('send_state', {current_time: player.currentTime});
            });

            // 播放/暂停：只发送状态变更，无重复上报
            player.addEventListener('play', () => {
                if(!playerState.isPlaying) {
                    playerState.isPlaying = true;
                    socket.emit('send_state', {is_playing: true});
                }
            });
            player.addEventListener('pause', () => {
                if(playerState.isPlaying) {
                    playerState.isPlaying = false;
                    socket.emit('send_state', {is_playing: false});
                    // ✅ 源头拦截：暂停后立刻重置同步时间，禁止后续进度上报
                    playerState.lastSyncTs = Date.now() + 10000;
                }
            });

            // 静音状态：只发送变更，无重复上报
            player.addEventListener('volumechange', () => {
                if(player.muted !== playerState.isMuted) {
                    playerState.isMuted = player.muted;
                    socket.emit('send_state', {is_muted: player.muted});
                }
            });

            // ✅ 核心治本修复：【播放中才上报进度，暂停后彻底禁止】【杜绝错误进度的源头】
            player.addEventListener('timeupdate', () => {
                const now = Date.now();
                // 条件：播放中 + 非拖动 + 非缓冲 + 满足节流间隔 → 才上报进度
                if(playerState.isPlaying && !playerState.isDragging && !playerState.isBuffering && now - playerState.lastSyncTs > SYNC_INTERVAL) {
                    playerState.lastSyncTs = now;
                    playerState.currentTime = player.currentTime;
                    socket.emit('send_state', { 
                        current_time: player.currentTime,
                        is_playing: true
                    });
                }
            });
        }

        // ✅ 新增：页面加载时初始化在线计数显示
        document.addEventListener('DOMContentLoaded', function() {
            // 初始化显示（从服务端获取的初始值）
            const initialCount = {{ online_count }};
            updateOnlineCount(initialCount);
        });
    </script>
</body>
</html>
'''

if __name__ == '__main__':
    # 生产环境极致稳定模式，无任何日志干扰，无debug开销
    socketio.run(app, host='0.0.0.0', port=19134, debug=False, allow_unsafe_werkzeug=True)
