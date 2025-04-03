# %% python set学习
modules_data = [
    ("MODULE_C", 100, 200),
    ("MODULE_A", 0, 50),
    ("MODULE_B", 60, 120),
    ("MODULE_A", 300, 350),
]

module=[module for module, _, _ in modules_data]  # 输出: ["MODULE_C", "MODULE_A", "MODULE_B", "MODULE_A"]
print(module)
print(set(module))
print(type(set(module)))
print(list(set(module)))




AA = "svt data"
if all([True,False,False]):
    print("hh")
else:
    print("fuck")

#%%
A=[1,2,34]
A[[0,1]]
#%%将列表分成多份
def split_list(lst, n):
    """将列表分成 n 份，使用生成器逐份返回"""
    k, m = divmod(len(lst), n)
    for i in range(n):
        start = i * k + min(i, m)
        end = (i + 1) * k + min(i + 1, m)
        yield lst[start:end]

# 示例
my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
for part in split_list(my_list, 3):
    print(part)
#%%
k, m = divmod(10, 3)
print(k)
print(m)
#%%
A="ABCD_abcd"
B=A.replace("ABCD","1234")
print(B)

import re

A = "ABCD_abcd"
oldname="abcd"
B = re.sub("abcd", "1234", A, flags=re.IGNORECASE)  # 不区分大小写
print(B)  # 输出: "1234_1234"