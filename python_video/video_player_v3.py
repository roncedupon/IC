from flask import Flask, request, render_template, jsonify
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
    "is_muted": True,  # 仅占位，无任何同步逻辑，音量完全独立
    "update_ts": time.time(),
    "session_id": str(uuid.uuid4())[:8],
    "last_sync_operation": None
}

# 设备管理
device_status = {}
DEVICE_PREFIX = "DEV-"
device_lock = threading.Lock()

# 配置参数 【保留所有原有优化参数】
CONFIG = {
    "STATE_LOCK": 0.3,           
    "SYNC_THRESHOLD": 0.3,       # 人耳无感同步阈值
    "SYNC_INTERVAL": 800,        # 进度同步间隔
    "SPEED_REPORT_INTERVAL": 1000,
    "HEARTBEAT_INTERVAL": 5000,
    "HEARTBEAT_TIMEOUT": 15000,
    "MIN_VALID_TIME": 0.1,
    "MAX_BUFFER_SYNC_DELAY": 1.5,
}

# 心跳监控线程
def heartbeat_monitor():
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

heartbeat_thread = threading.Thread(target=heartbeat_monitor, daemon=True)
heartbeat_thread.start()

@socketio.on('connect')
def handle_connect():
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
    sid = request.sid
    with device_lock:
        if sid in device_status:
            del device_status[sid]
    
    broadcast_device_status()
    logger.info(f"设备断开: {sid[:8]}")

@socketio.on('heartbeat')
def handle_heartbeat():
    sid = request.sid
    with device_lock:
        if sid in device_status:
            device_status[sid]["last_seen"] = time.time()
            device_status[sid]["online"] = True

@socketio.on('report_player_metrics')
def handle_player_metrics(data):
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
    emit('sync_self', global_play_state)

@socketio.on('send_state')
def handle_state_change(data):
    """处理状态变更 - 核心：双端优化根治状态竞争问题"""
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
    
    # 2. 播放/暂停状态变更 【主动操作，优先级永久置顶】
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
    
    # ============【后端核心优化1：全局暂停时，忽略所有纯进度更新请求 【根治状态竞争】============
    # 核心逻辑：全局是暂停状态 → 只处理主动操作，不处理被动的进度上报
    allow_progress_update = True
    if global_play_state["is_playing"] is False:
        # 全局暂停时，仅允许【手动拖动跳转/主动seek】，拒绝timeupdate的被动进度上报
        allow_progress_update = False
        logger.debug(f"全局暂停中，忽略设备 {sid[:8]} 的被动进度上报")
    # ======================================================================================

    # 3. 进度变更
    if "current_time" in data and global_play_state["video_url"] and allow_progress_update:
        current_time = float(data["current_time"])
        
        if current_time < 0:
            return
        
        if current_time < CONFIG["MIN_VALID_TIME"] and global_play_state["current_time"] > 1:
            return
        
        time_diff = abs(global_play_state["current_time"] - current_time)
        # ============【后端核心优化2：只处理主动大跨度跳转，忽略微小进度飘移】============
        if time_diff > CONFIG["SYNC_THRESHOLD"]:
            global_play_state["current_time"] = current_time
            need_broadcast = True
            operation_type = "seek"
            logger.debug(f"设备 {sid[:8]} 主动跳转进度: {current_time:.1f}s")
        # ==============================================================================

    # 无音量同步逻辑，完全保留独立控制

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
    sid = request.sid
    logger.info(f"设备 {sid[:8]} 请求强制同步")
    emit('sync_all', {
        **global_play_state,
        "sync_id": str(uuid.uuid4())[:8],
        "timestamp": time.time(),
        "force_sync": True
    })

def broadcast_device_status():
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
    online_count = len([v for v in device_status.values() if v.get("online", False)])
    # 渲染外部HTML模板（需确保templates文件夹存在且包含index.html）
    return render_template('index.html', 
                           state=global_play_state, 
                           config=CONFIG, 
                           online_count=online_count)

@app.route('/api/status')
def api_status():
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

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=19134, debug=True)