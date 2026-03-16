import lark_oapi as lark
import json

def send_message(chat_id, content):
    """发送消息到指定群组"""
    client = lark.Client(
        app_id="cli_a93ca1f27778dcc2",
        app_secret="SD9Zv2kpG2d716JDOBgHObIclv8iNE7k",
    )
    
    # 构建消息
    msg = lark.im.v1.MessageCreateRequest.builder().chat_id(chat_id).msg_type("text").content(content).build()
    
    # 发送消息
    try:
        resp = client.im.v1.message.create(msg)
        print(f"消息发送成功: {resp}")
    except Exception as e:
        print(f"消息发送失败: {e}")

## P2ImMessageReceiveV1 为接收消息 v2.0；CustomizedEvent 内的 message 为接收消息 v1.0。
def do_p2_im_message_receive_v1(data: lark.im.v1.P2ImMessageReceiveV1) -> None:
    """处理接收到的消息"""
    try:
        # 解析消息内容
        message = data.message
        content = message.content
        chat_id = message.chat_id
        sender = message.sender
        
        print(f"接收到消息: {content}")
        print(f"来自群组: {chat_id}")
        print(f"发送者: {sender}")
        
        # 解析文本内容
        content_json = json.loads(content)
        text = content_json.get("text", "")
        
        # 根据消息内容执行不同操作
        if "hello" in text.lower():
            # 回复问候
            reply_content = json.dumps({"text": "Hello! 我是ONDEC2NSU Checker机器人。"})
            send_message(chat_id, reply_content)
        elif "status" in text.lower():
            # 发送状态报告
            status_report = "ONDEC2NSU Checker 运行状态: 正常"
            reply_content = json.dumps({"text": status_report})
            send_message(chat_id, reply_content)
        elif "help" in text.lower():
            # 发送帮助信息
            help_info = "可用命令:\n- hello: 问候\n- status: 查看状态\n- help: 查看帮助"
            reply_content = json.dumps({"text": help_info})
            send_message(chat_id, reply_content)
    except Exception as e:
        print(f"处理消息时出错: {e}")

def do_message_event(data: lark.CustomizedEvent) -> None:
    print(f'[ do_customized_event access ], type: message, data: {lark.JSON.marshal(data, indent=4)}')

event_handler = lark.EventDispatcherHandler.builder("", "") \
    .register_p2_im_message_receive_v1(do_p2_im_message_receive_v1) \
    .register_p1_customized_event("im.message.receive_v1", do_message_event) \
    .build()

def main():
    cli = lark.ws.Client("cli_a93ca1f27778dcc2", "SD9Zv2kpG2d716JDOBgHObIclv8iNE7k",
                         event_handler=event_handler,
                         log_level=lark.LogLevel.DEBUG)
    cli.start()

if __name__ == "__main__":
    main()