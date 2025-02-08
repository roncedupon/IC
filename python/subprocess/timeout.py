import subprocess

try:
    # 在这里设置超时时间（单位：秒）
    result = subprocess.run(
        ["echo","aaaaaaaaaa bbbbbbbbbbbb not eq \n aaaaaaaa"],  # 正确拆分命令及参数,  # 命令列表
        timeout=5,  # 超时时间 5 分钟
        capture_output=True,  # 捕获标准输出和标准错误
        text=True  # 将输出作为字符串返回
    )
    print("Command completed successfully:")
    print(result.stdout)
except:
    print("The command timed out.")

# 检查 stdout 是否包含 "not eq"
if "not eq" in result.stdout:
    print("在标准输出中找到了 'not eq' 字段！")
else:
    print("标准输出中没有 'not eq' 字段。")