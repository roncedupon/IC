import socket

def main():
    host = '127.0.0.1'  # 监听本地回环地址
    port = 19132        # 监听端口

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    try:
        server_socket.bind((host, port))
    except socket.error as e:
        print(f"端口绑定失败: {e}")
        return

    server_socket.listen(5)  # 开始监听，最多允许 5 个排队连接
    print(f"服务器正在监听端口 {port}")

    while True:
        client_socket, addr = server_socket.accept()
        print(f"接受来自 {addr} 的连接")

        message = "你好，客户端！ 这是来自端口 19132 的消息。\n"
        client_socket.send(message.encode('utf-8')) # 发送消息，编码为 UTF-8

        client_socket.close() # 关闭客户端连接

if __name__ == "__main__":
    main()