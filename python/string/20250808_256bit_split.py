#%%
#d22cee8d95c3ce52c94312527bae0009c69ae7dc8d8ccd210925c03cf6ef9fd4
#将64B的字符串截断成64bit的，小端
str="d22cee8d95c3ce52c94312527bae0009c69ae7dc8d8ccd210925c03cf6ef9fd4"
str_8B_lst=[str[i:i+16] for i in range(0,len(str),16)]
for lst in str_8B_lst[::-1]:
    print(lst)

#%%
for i in range(0,10,2):
    print(i)
#%%
import re

# 原始字符串
s = "899484600  0000070501070700050203060705030507000602010504070006040001060607"

# 正则表达式匹配：前面是数字加空格，捕获后面的数字
pattern = r'\d+\s+(\d+)'

# 查找匹配
match = re.search(pattern, s)

if match:
    # 提取捕获组中的内容
    result = match.group(1)
    print("提取到的数字：", result)
else:
    print("未找到匹配的数字")
    
#%%
import re
str_data="0:f6ef9fd4,925c03c,8d8ccd21,c69ae7dc,7bae0009,c9431252,95c3ce52,d22cee8d,c002d9b1,8a730239,562cde63,2bfde578,34d90b90,6affdfa8,1c029a27,4bdb1c91,7a6b9fcd,efee3203,3455e28c,be19d6f2,883b9f6b,63938174,86641ed5,2143db74,dad25388,c02e7504,5089ba3,5901ccff"
str_data=re.sub(r"^\d:","",str_data)
merged=["{:0>8s}".format(item) for item in str_data.split(",")]
for i in range(0,len(merged),2):
    print(merged[i+1]+merged[i])
print(merged)