import re

# 改进后的正则表达式，加入了timescale的匹配
pattern = r"(\w+)_STRAT!!!!\s*time\s*=\s*(\d+)\s*(ns|ps|us|ms|fs)?,"

# 测试字符串
test_strings = [
    "var1_STRAT!!!! time = 123456(ns),",
    "var2_STRAT!!!! time  = 7890 ps,",
    "otherword_STRAT!!!! time=9876 us,",
    "var4_STRAT!!!! time = 100,",  # 没有时间单位
]

# 匹配并提取数据
for text in test_strings:
    match = re.match(pattern, text)
    if match:
        variable = match.group(1)  # 提取第一个括号中的匹配（变量名）
        time_value = match.group(2)  # 提取第二个括号中的匹配（时间值）
        timescale = match.group(3)  # 提取第三个括号中的匹配（timescale）
        print(f"变量名: {variable}, 时间值: {time_value}, 单位: {timescale if timescale else '无'}")
    else:
        print(f"匹配失败: {text}")


#%%
# 用正则表达式检查一段字符串是否在另外一段字符串中出现
import re
str="    reg_test(FC0_ADDR+0x9004 + 0x4*0, 0b0llu      , 0xb7db5llu  , 0x1     , 31, 11);\n"
if re.search(r",.*0x1.*,",str):
    print("yes")


