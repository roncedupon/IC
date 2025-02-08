import numpy as np

def generate_hex(np_matrix, opt="w"):
    output_path="."
    out_file_name = "test.txt"
    
    print(f"[in bin2hex] generating {output_path}/{out_file_name}...")
    with open(output_path + "/" + out_file_name, opt) as f:
        row_index = 0
        for row in np_matrix:
            f.write(''.join(format(x, "04x") for x in row) + '\n')
if __name__=="__main__":
    np.random.seed(345)
    A=np.random.randint(-128,127,size=(10,10),dtype=np.int8)
    A.dtype=np.uint8
    B=np.zeros((10,10),dtype=np.uint8)

    B[:,:]=A
    print(A)
    generate_hex(B)
#%%
import os
import re

def find_files_by_pattern(directory, pattern):
    """
    递归遍历指定文件夹，根据提供的正则表达式匹配文件名
    :param directory: 目标文件夹路径
    :param pattern: 文件名匹配的正则表达式
    :return: 匹配文件路径的列表
    """
    matched_files = []
    regex = re.compile(pattern)  # 编译正则表达式

    for root, dirs, files in os.walk(directory):
        for file in files:
            if regex.match(file):  # 匹配文件名
                matched_files.append(os.path.join(root, file))
    
    return matched_files

# 使用示例
target_directory = "./"  # 替换为实际路径
file_pattern = r"^V1.*$"  # 替换为你的正则表达式

matched_files = find_files_by_pattern(target_directory, file_pattern)

print("匹配的文件路径如下：")
for path in matched_files:
    print(path)
#%%

AAA="failed:adsads"
with open("matrix.txt","r")as f:
    lines=f.readlines()
    print(lines)
    if "failed" in lines:
        print("fuck")

#%%
def bitwise_not_with_width(number, width):
    # 创建掩码，保证结果符合指定位宽
    mask = (1 << width) - 1  # 比如 8 位的掩码是 11111111，即 255
    # 对数字取反并应用掩码，确保结果是一个指定宽度的数字
    return ~number & mask

# 示例：对 5 进行取反，指定 8 位宽
number = 1
width = 1
result = bitwise_not_with_width(number, width)

print(f"原始数字：{number}")
print(f"取反后的结果：{result}（十进制）")
print(f"取反后的结果（二进制）：{bin(result)}")
