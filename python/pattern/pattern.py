# %%
import re
from collections import defaultdict

# 示例字段列表
fields = [
    "AA_bb_cc_0", "AA_bb_cc_1", "AA_bb_cc_2",
    "BB_cc_dd_0", "BB_cc_dd_1", "BB_cc_dd_2",
    "CC_dd_ee_0", "CC_dd_ee_1",
    "A0_bbcc_0", "A0_bbcc_1", "AAA_bbcc","1_m95v_0","1_m95v_1","1_m95v_2","1_m95v"
]

# 定义正则表达式：匹配字段的前缀（支持有无后缀的情况）
pattern = re.compile(r"^(.*?)_(\d+)?$")


# 分类字段
# categories = defaultdict(list)
categories = {}

for field in fields:
    match = pattern.match(field)
    if match:
        prefix = match.group(1)  # 提取前缀部分
        
        if prefix not in categories.keys():
            categories[prefix]=[field]
        else:
            categories[prefix].append(field)
            

# 输出每个类别的字段
for category, items in categories.items():
    print(f"类别: {category}")
    print(f"字段: {items}")
    print()
#%%
import re
match = re.match(r'(a|b)c', 'ac')
print(match.group(1))  # 输出 'a'
#%%
import re
match = re.match(r'(?:a|b)c', 'ac')
try:
    print(match.group(1))  # 抛出错误，因为没有捕获内容
except IndexError:
    print("没有捕获组")
