from flask import Flask, request, render_template, jsonify
from flask_socketio import SocketIO, emit
import time
import uuid
import threading
from datetime import datetime
import logging
import os
import json

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

app = Flask(__name__, template_folder='templates')
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
    "last_sync_operation": None,
    "last_operation_device": None,  # 记录最后一次操作变更的设备ID
    "last_operation_type": None  # 记录最后一次操作类型: 'user_action' 或 'passive_update'
}

# 播放列表管理（支持分类）
global_playlist = {
    "categories": [],  # 分类列表 [{"name": "剧集A", "expanded": True, "videos": [...]}]
    "current_index": {
        "category": -1,  # 当前分类索引
        "video": -1  # 当前视频索引（在分类内的索引）
    },
    "update_ts": time.time()
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

# 播放列表文件存储
PLAYLIST_FILE = os.path.join(os.path.dirname(__file__), "playlist_data.json")
playlist_lock = threading.Lock()

def load_playlist_from_file():
    """从文件加载播放列表，支持新旧格式自动转换"""
    global global_playlist
    
    try:
        if not os.path.exists(PLAYLIST_FILE):
            logger.info(f"播放列表文件不存在，创建新文件: {PLAYLIST_FILE}")
            save_playlist_to_file()
            return
        
        with open(PLAYLIST_FILE, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 验证数据格式
        if not isinstance(data, dict):
            logger.warning("播放列表文件格式错误，使用空列表")
            return
        
        with playlist_lock:
            # 检查是新格式（categories）还是旧格式（videos）
            if 'categories' in data:
                # 新格式：直接加载
                global_playlist['categories'] = data.get('categories', [])
                global_playlist['current_index'] = data.get('current_index', {
                    'category': -1,
                    'video': -1
                })
            elif 'videos' in data:
                # 旧格式：转换为新格式
                logger.info("检测到旧格式播放列表，自动转换为分类格式")
                old_videos = data.get('videos', [])
                if old_videos:
                    # 创建一个默认分类"未分类"
                    default_category = {
                        "name": "未分类",
                        "expanded": True,
                        "videos": []
                    }
                    for video in old_videos:
                        if 'id' not in video:
                            video['id'] = str(uuid.uuid4())[:8]
                        default_category['videos'].append(video)
                    global_playlist['categories'] = [default_category]
                    global_playlist['current_index'] = {
                        'category': 0,
                        'video': data.get('current_index', 0) if len(old_videos) > 0 else -1
                    }
                    # 自动保存新格式
                    save_playlist_to_file()
                else:
                    global_playlist['categories'] = []
                    global_playlist['current_index'] = {'category': -1, 'video': -1}
            else:
                # 空数据
                global_playlist['categories'] = []
                global_playlist['current_index'] = {'category': -1, 'video': -1}
        
        total_videos = sum(len(cat['videos']) for cat in global_playlist['categories'])
        logger.info(f"成功加载播放列表: {len(global_playlist['categories'])} 个分类，{total_videos} 个视频")
        
    except json.JSONDecodeError as e:
        logger.error(f"播放列表文件JSON解析失败: {e}")
    except Exception as e:
        logger.error(f"加载播放列表失败: {e}")

def save_playlist_to_file():
    """保存播放列表到文件"""
    global global_playlist
    
    try:
        with playlist_lock:
            data = {
                'categories': global_playlist['categories'],
                'current_index': global_playlist['current_index'],
                'version': 2,  # 版本号升级
                'saved_at': time.time()
            }
        
        with open(PLAYLIST_FILE, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        logger.debug(f"播放列表已保存到文件: {PLAYLIST_FILE}")
        
    except Exception as e:
        logger.error(f"保存播放列表失败: {e}")

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
    """处理状态变更 - 核心：双端优化根治状态竞争问题 + 操作优先级机制"""
    global global_play_state
    
    sid = request.sid
    now = time.time()
    
    if not isinstance(data, dict):
        return
    
    with device_lock:
        if sid in device_status:
            device_status[sid]["last_seen"] = now
    
    # ==========【新增：操作类型判断】==========
    # 判断当前请求是用户主动操作还是被动状态上报
    is_user_action = False
    if "video_url" in data:
        # 视频源变更：用户主动操作
        is_user_action = True
    elif "is_playing" in data and data["is_playing"] != global_play_state["is_playing"]:
        # 播放/暂停状态变更：用户主动操作
        is_user_action = True
    # ========================================
    
    # ==========【新增：操作优先级保护】==========
    # 在锁定时间内，高优先级操作不会被低优先级覆盖
    if now - global_play_state["update_ts"] < CONFIG["STATE_LOCK"]:
        # 如果当前请求是低优先级的被动更新，且最后一次操作是用户主动暂停
        if (not is_user_action and 
            global_play_state.get("last_operation_type") == "user_action" and
            global_play_state.get("is_playing") == False):
            # 拒绝低优先级的播放状态覆盖，但允许进度更新
            if "is_playing" in data and data["is_playing"] == True:
                logger.debug(f"设备 {sid[:8]} 被动播放状态被拒绝（锁定中，上次操作为暂停）")
                # 允许进度更新，但不改变播放状态
                if "current_time" in data and global_play_state["video_url"]:
                    current_time = float(data["current_time"])
                    time_diff = abs(global_play_state["current_time"] - current_time)
                    if time_diff > CONFIG["SYNC_THRESHOLD"]:
                        global_play_state["current_time"] = current_time
                        global_play_state["update_ts"] = now
                        logger.debug(f"设备 {sid[:8]} 进度更新（不改变播放状态）")
                return
        # 如果当前请求是高优先级的用户操作，则强制通过
        elif is_user_action:
            pass
        # 否则在锁定时间内直接返回
        else:
            return
    # ==========================================
    
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
        # ==========【新增：记录操作来源】==========
        device_id = device_status.get(sid, {}).get("device_id", sid[:8])
        global_play_state["last_operation_device"] = device_id
        global_play_state["last_operation_type"] = "user_action" if is_user_action else "passive_update"
        # =======================================
        
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

# ====================【播放列表管理 Socket 事件】====================

@socketio.on('get_playlist')
def handle_get_playlist():
    """获取播放列表"""
    sid = request.sid
    logger.debug(f"设备 {sid[:8]} 请求播放列表")
    emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time()
    })

@socketio.on('add_to_playlist')
def handle_add_to_playlist(data):
    """添加视频到播放列表（支持分类）"""
    global global_playlist

    sid = request.sid
    if not isinstance(data, dict):
        return

    video_url = data.get('video_url', '').strip()
    video_name = data.get('video_name', '').strip()
    category_name = data.get('category', '').strip()  # 分类名称

    if not video_url:
        logger.warning(f"设备 {sid[:8]} 尝试添加空视频URL")
        return

    # 如果没有提供名称，使用URL作为名称
    if not video_name:
        video_name = video_url.split('/')[-1].split('?')[0]
        if len(video_name) > 50:
            video_name = video_name[:50] + "..."

    # 如果没有提供分类，使用"未分类"
    if not category_name:
        # 查找是否存在"未分类"分类
        category_name = "未分类"

    video_name = video_name or f"视频"

    # 查找或创建分类
    category = None
    for cat in global_playlist['categories']:
        if cat['name'] == category_name:
            category = cat
            break

    if not category:
        # 创建新分类
        category = {
            "name": category_name,
            "expanded": True,
            "videos": []
        }
        global_playlist['categories'].append(category)
        logger.info(f"设备 {sid[:8]} 创建新分类: {category_name}")

    # 检查该分类下是否已存在
    for video in category['videos']:
        if video['url'] == video_url:
            logger.info(f"设备 {sid[:8]} 添加的视频已存在于分类 '{category_name}': {video_name}")
            emit('playlist_update', {
                **global_playlist,
                "timestamp": time.time(),
                "message": f"视频已存在于分类'{category_name}'中"
            })
            return

    # 添加视频到分类
    new_video = {
        "id": str(uuid.uuid4())[:8],  # 添加唯一ID
        "url": video_url,
        "name": video_name,
        "added_at": time.time()
    }
    category['videos'].append(new_video)
    global_playlist['update_ts'] = time.time()

    # 如果是第一个视频，自动设为当前索引
    if global_playlist['current_index']['category'] == -1:
        category_idx = global_playlist['categories'].index(category)
        global_playlist['current_index'] = {
            'category': category_idx,
            'video': 0
        }

    logger.info(f"设备 {sid[:8]} 添加视频: {video_name} 到分类 '{category_name}'")

    # 保存到文件
    save_playlist_to_file()

    # 广播播放列表更新
    socketio.emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time(),
        "message": f"已添加视频到分类'{category_name}': {video_name}"
    })

@socketio.on('remove_from_playlist')
def handle_remove_from_playlist(data):
    """从播放列表删除视频"""
    global global_playlist
    
    sid = request.sid
    if not isinstance(data, dict):
        return
    
    index = data.get('index')
    if index is None or not isinstance(index, int):
        logger.warning(f"设备 {sid[:8]} 提供的索引无效")
        return
    
    if index < 0 or index >= len(global_playlist['videos']):
        logger.warning(f"设备 {sid[:8]} 提供的索引超出范围: {index}")
        return
    
    removed_video = global_playlist['videos'].pop(index)
    logger.info(f"设备 {sid[:8]} 删除视频: {removed_video['name']} (索引: {index})")
    
    # 调整当前播放索引
    if global_playlist['current_index'] == index:
        # 删除的是当前播放的视频
        if len(global_playlist['videos']) > 0:
            global_playlist['current_index'] = max(0, index - 1)
        else:
            global_playlist['current_index'] = -1
            # 清空当前播放
            global_play_state.update({
                "video_url": "",
                "current_time": 0.0,
                "is_playing": False
            })
            socketio.emit('sync_all', global_play_state)
    elif global_playlist['current_index'] > index:
        # 删除的是当前播放视频之前的视频，索引减1
        global_playlist['current_index'] -= 1
    
    global_playlist['update_ts'] = time.time()
    
    # 保存到文件
    save_playlist_to_file()
    
    # 广播播放列表更新
    socketio.emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time(),
        "message": f"已删除视频: {removed_video['name']}"
    })

@socketio.on('play_from_playlist')
def handle_play_from_playlist(data):
    """从播放列表播放指定索引的视频（支持分类）"""
    global global_playlist
    global global_play_state

    sid = request.sid
    now = time.time()

    if not isinstance(data, dict):
        return

    category_index = data.get('category_index')
    video_index = data.get('video_index')

    if category_index is None or not isinstance(category_index, int):
        logger.warning(f"设备 {sid[:8]} 提供的分类索引无效")
        return

    if category_index < 0 or category_index >= len(global_playlist['categories']):
        logger.warning(f"设备 {sid[:8]} 提供的分类索引超出范围: {category_index}")
        return

    if video_index is None or not isinstance(video_index, int):
        logger.warning(f"设备 {sid[:8]} 提供的视频索引无效")
        return

    category = global_playlist['categories'][category_index]
    if video_index < 0 or video_index >= len(category['videos']):
        logger.warning(f"设备 {sid[:8]} 提供的视频索引超出范围: {video_index}")
        return

    video = category['videos'][video_index]
    global_playlist['current_index'] = {
        'category': category_index,
        'video': video_index
    }
    global_playlist['update_ts'] = now

    # 更新播放状态（遵循原有的同步逻辑）
    global_play_state.update({
        "video_url": video['url'],
        "current_time": 0.0,
        "is_playing": True,
        "update_ts": now,
        "last_operation_device": device_status.get(sid, {}).get("device_id", sid[:8]),
        "last_operation_type": "user_action"
    })

    logger.info(f"设备 {sid[:8]} 播放视频: {video['name']} (分类: {category['name']}, 索引: {video_index})")

    # 广播播放列表更新
    socketio.emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time(),
        "message": f"正在播放: {video['name']}"
    })

    # 广播播放状态更新
    socketio.emit('sync_all', {
        **global_play_state,
        "sync_id": str(uuid.uuid4())[:8],
        "timestamp": now
    })

@socketio.on('play_next')
def handle_play_next():
    """播放下一个视频（支持分类）"""
    global global_playlist
    global global_play_state

    sid = request.sid
    now = time.time()

    if not global_playlist['categories']:
        logger.warning(f"播放列表为空，无法播放下一个")
        return

    current_cat_idx = global_playlist['current_index']['category']
    current_vid_idx = global_playlist['current_index']['video']

    # 计算下一个视频的索引
    next_cat_idx = current_cat_idx
    next_vid_idx = current_vid_idx + 1

    # 当前分类内是否还有下一个视频
    if next_vid_idx >= len(global_playlist['categories'][current_cat_idx]['videos']):
        # 当前分类已到末尾，检查是否有下一个分类
        if current_cat_idx + 1 < len(global_playlist['categories']):
            # 播放下一个分类的第一个视频
            next_cat_idx = current_cat_idx + 1
            next_vid_idx = 0
        else:
            # 所有分类都已播放完毕，循环到第一个视频
            next_cat_idx = 0
            next_vid_idx = 0

    # 获取视频
    category = global_playlist['categories'][next_cat_idx]
    video = category['videos'][next_vid_idx]

    global_playlist['current_index'] = {
        'category': next_cat_idx,
        'video': next_vid_idx
    }
    global_playlist['update_ts'] = now

    # 更新播放状态
    global_play_state.update({
        "video_url": video['url'],
        "current_time": 0.0,
        "is_playing": True,
        "update_ts": now,
        "last_operation_device": device_status.get(sid, {}).get("device_id", sid[:8]),
        "last_operation_type": "user_action"
    })

    logger.info(f"设备 {sid[:8]} 播放下一个视频: {video['name']} (分类: {category['name']}, 索引: {next_vid_idx})")

    # 广播播放列表更新
    socketio.emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time(),
        "message": f"播放下一个: {video['name']}"
    })

    # 广播播放状态更新
    socketio.emit('sync_all', {
        **global_play_state,
        "sync_id": str(uuid.uuid4())[:8],
        "timestamp": now
    })

@socketio.on('play_previous')
def handle_play_previous():
    """播放上一个视频（支持分类）"""
    global global_playlist
    global global_play_state

    sid = request.sid
    now = time.time()

    if not global_playlist['categories']:
        logger.warning(f"播放列表为空，无法播放上一个")
        return

    current_cat_idx = global_playlist['current_index']['category']
    current_vid_idx = global_playlist['current_index']['video']

    # 计算上一个视频的索引
    prev_cat_idx = current_cat_idx
    prev_vid_idx = current_vid_idx - 1

    # 当前分类内是否还有上一个视频
    if prev_vid_idx < 0:
        # 当前分类已到开头，检查是否有上一个分类
        if current_cat_idx > 0:
            # 播放上一个分类的最后一个视频
            prev_cat_idx = current_cat_idx - 1
            prev_vid_idx = len(global_playlist['categories'][prev_cat_idx]['videos']) - 1
        else:
            # 所有分类都已播放完毕，循环到最后一个视频
            prev_cat_idx = len(global_playlist['categories']) - 1
            prev_vid_idx = len(global_playlist['categories'][prev_cat_idx]['videos']) - 1

    # 获取视频
    category = global_playlist['categories'][prev_cat_idx]
    video = category['videos'][prev_vid_idx]

    global_playlist['current_index'] = {
        'category': prev_cat_idx,
        'video': prev_vid_idx
    }
    global_playlist['update_ts'] = now

    # 更新播放状态
    global_play_state.update({
        "video_url": video['url'],
        "current_time": 0.0,
        "is_playing": True,
        "update_ts": now,
        "last_operation_device": device_status.get(sid, {}).get("device_id", sid[:8]),
        "last_operation_type": "user_action"
    })

    logger.info(f"设备 {sid[:8]} 播放上一个视频: {video['name']} (分类: {category['name']}, 索引: {prev_vid_idx})")

    # 广播播放列表更新
    socketio.emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time(),
        "message": f"播放上一个: {video['name']}"
    })

    # 广播播放状态更新
    socketio.emit('sync_all', {
        **global_play_state,
        "sync_id": str(uuid.uuid4())[:8],
        "timestamp": now
    })

@socketio.on('remove_video_by_id')
def handle_remove_video_by_id(data):
    """按ID删除视频记录（支持分类）"""
    global global_playlist

    sid = request.sid
    if not isinstance(data, dict):
        return

    video_id = data.get('id')
    if not video_id or not isinstance(video_id, str):
        logger.warning(f"设备 {sid[:8]} 提供的视频ID无效")
        return

    # 在所有分类中查找视频
    found_category_idx = -1
    found_video_idx = -1
    removed_video = None

    for cat_idx, category in enumerate(global_playlist['categories']):
        for vid_idx, video in enumerate(category['videos']):
            if video.get('id') == video_id:
                found_category_idx = cat_idx
                found_video_idx = vid_idx
                removed_video = video
                break
        if found_category_idx != -1:
            break

    if found_category_idx == -1:
        logger.warning(f"设备 {sid[:8]} 未找到视频ID: {video_id}")
        return

    category_name = global_playlist['categories'][found_category_idx]['name']
    removed_video = global_playlist['categories'][found_category_idx]['videos'].pop(found_video_idx)
    logger.info(f"设备 {sid[:8]} 删除视频: {removed_video['name']} (ID: {video_id}) 从分类 '{category_name}'")

    # 检查是否需要删除空分类
    if len(global_playlist['categories'][found_category_idx]['videos']) == 0:
        global_playlist['categories'].pop(found_category_idx)
        logger.info(f"设备 {sid[:8]} 删除空分类: {category_name}")

        # 调整当前播放索引
        if global_playlist['current_index']['category'] == found_category_idx:
            # 删除的是当前播放视频所在的分类
            if global_playlist['categories']:
                global_playlist['current_index'] = {
                    'category': max(0, found_category_idx - 1),
                    'video': 0
                }
            else:
                global_playlist['current_index'] = {'category': -1, 'video': -1}
                # 清空当前播放
                global_play_state.update({
                    "video_url": "",
                    "current_time": 0.0,
                    "is_playing": False
                })
                socketio.emit('sync_all', global_play_state)
        elif global_playlist['current_index']['category'] > found_category_idx:
            # 删除的是当前播放分类之前的分类
            global_playlist['current_index']['category'] -= 1
    else:
        # 调整当前播放索引（同一分类内）
        current_cat_idx = global_playlist['current_index']['category']
        current_vid_idx = global_playlist['current_index']['video']

        if current_cat_idx == found_category_idx:
            if current_vid_idx == found_video_idx:
                # 删除的是当前播放的视频
                if len(global_playlist['categories'][found_category_idx]['videos']) > 0:
                    global_playlist['current_index']['video'] = max(0, found_video_idx - 1)
                else:
                    global_playlist['current_index'] = {'category': -1, 'video': -1}
                    # 清空当前播放
                    global_play_state.update({
                        "video_url": "",
                        "current_time": 0.0,
                        "is_playing": False
                    })
                    socketio.emit('sync_all', global_play_state)
            elif current_vid_idx > found_video_idx:
                # 删除的是当前播放视频之前的视频
                global_playlist['current_index']['video'] -= 1

    global_playlist['update_ts'] = time.time()

    # 保存到文件
    save_playlist_to_file()

    # 广播播放列表更新
    socketio.emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time(),
        "message": f"已删除视频: {removed_video['name']}"
    })

@socketio.on('clear_playlist')
def handle_clear_playlist():
    """清空播放列表"""
    global global_playlist

    sid = request.sid

    # 计算总视频数
    video_count = sum(len(cat['videos']) for cat in global_playlist['categories'])

    global_playlist['categories'] = []
    global_playlist['current_index'] = {'category': -1, 'video': -1}
    global_playlist['update_ts'] = time.time()

    # 清空当前播放
    global_play_state.update({
        "video_url": "",
        "current_time": 0.0,
        "is_playing": False
    })

    logger.info(f"设备 {sid[:8]} 清空播放列表 (删除了 {video_count} 个视频)")

    # 保存到文件
    save_playlist_to_file()

    # 广播播放列表更新
    socketio.emit('playlist_update', {
        **global_playlist,
        "timestamp": time.time(),
        "message": f"已清空播放列表 (删除了 {video_count} 个视频)"
    })

    # 广播播放状态更新
    socketio.emit('sync_all', global_play_state)

# ==================================================================

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
    # 启动时加载播放列表
    logger.info("=" * 60)
    logger.info("启动视频同步播放系统")
    logger.info("=" * 60)

    load_playlist_from_file()

    logger.info(f"播放列表文件: {PLAYLIST_FILE}")
    total_videos = sum(len(cat['videos']) for cat in global_playlist['categories'])
    logger.info(f"当前播放列表: {len(global_playlist['categories'])} 个分类，{total_videos} 个视频")
    logger.info("=" * 60)

    socketio.run(app, host='0.0.0.0', port=19134, debug=True, allow_unsafe_werkzeug=True)