import re

# 正则表达式模式
pattern = r"^define\s+\w+\s+\w+$"

# 测试字符串
test_strings = [
    "define AAA xxx",    # 匹配成功
    "define VAR1 value",  # 匹配成功
    "define _var123 abc", # 匹配成功
    "DEFINE AAA xxx",    # 不匹配（大小写敏感）
    "define AAA",         # 不匹配（缺少第三部分）
    "def AAA xxx"         # 不匹配（`define` 被拼写成了 `def`）
]

# 匹配并打印结果
for text in test_strings:
    if re.match(pattern, text):
        print(f"匹配成功: {text}")
    else:
        print(f"匹配失败: {text}")


import re

AAA = "/App/synopsys/syn/T-2022.03-SP2/dw/sim_ver/DW_asymdata_outbuf.v(116), macro DW_cnt_width */\n33"

# 只提取宏名称和宏值
define_pattern = r"macro\s+(\w+)\s*\*/\s*(\S+)"

# 执行正则匹配
matches1 = re.search(define_pattern, AAA)

if matches1:
    print("宏名称:", matches1.group(1))  # 宏名称
    print("宏值:", matches1.group(2))  # 宏值
else:
    print("没有匹配到结果")

