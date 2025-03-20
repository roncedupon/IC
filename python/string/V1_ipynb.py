# %% [markdown]
# # 字符串处理

# %% [markdown]
# ## 时间处理

# %%
import time
def print_info(string):
    time_info=time.strftime("%Y-%m-%d %H:%M:%S",time.localtime())
    print("{:20} {:10} {:50}".format(time_info,"INFO",string))
print_info("123")

# %%


# %% [markdown]
# ## 字符串输出格式

# %% [markdown]
# ### 字符串对齐
# 在Python中，这种表达式是用于格式化输出的代码，通常出现在字符串的格式化中，尤其是在f-strings或format方法中。<br>这里的{:<15}和{:<30}等占位符用于指定数据在输出时的宽度和对齐方式。具体含义如下：
# 
# {:<15}：代表左对齐，宽度为15个字符。
# {:<30}：代表左对齐，宽度为30个字符。
# {:<100}：代表左对齐，宽度为100个字符。

# %%
#-----------------------------------------------------------------
#字符串对齐
class str_align:


    # def __init__(self):
        # print("new")
        # self.args=cfg_args()

    def printV1(self):
        seed=1024
        tc_name="12345"
        print('{:<15}{:<30}{:<100}'.format("running", tc_name, str(seed))) 
        print('{:>15}'.format("running")) 
if __name__=="__main__":
    str_align_inst=str_align()
    str_align_inst.printV1()

# %% [markdown]
# ### 当然py还能居中对齐
# 在这个示例中：
# 
# <br>{:^15} 表示在宽度为15的区域内居中对齐。
# <br>{:^30} 表示在宽度为30的区域内居中对齐。
# <br>{:^100} 表示在宽度为100的区域内居中对齐。

# %%
# 示例代码
print("{:^15}{:^30}{:^100}".format("Name", "Position", "Description"))
print("{:^15}{:^30}{:^100}".format("Alice", "Engineer", "Works on system design and architecture"))
print("{:^15}{:^30}{:^100}".format("Bob", "Data Scientist", "Analyzes data for insights and builds models"))


# %% [markdown]
# ### 字符串按某个符号进行分割

# %%
A="123.345"
print(A.split(".")[0])

# %% [markdown]
# ## 字符串列表

# %%
A=["a","B","C"]
print(A[1:])
print(A[-1:])#A[-1:] 返回从列表的最后一个元素开始，直到列表结束：["C"]。
print(A[:-1])
# A[1:].upper()
# 将列表从索引1开始的所有元素转换为大写
upper_case_list = [item.upper() for item in A[1:]]
print(upper_case_list)
print(len(A))

# %%
B=[]
AAA="12345,234"
print(AAA.startswith("12"))
B.append(AAA)
B.append(AAA)
B.append(AAA)
print(B[1])


# %% [markdown]
# ## 字符串进制转换

# %% [markdown]
# ### 十六进制转十进制

# %%
#字符串转10进制时的基数设置
print(int("16",16))
print(int("16"))
# print(int("0x16"))#这样就会报错

# %%
#字符串转数组
addr_list = ["0x11", "0x1A", "0xFF", "0x100"]

# 使用列表推导式，将每个十六进制字符串转换为整数
int_list = [int(addr, 16) for addr in addr_list]

print(int_list)


# %%
A="0x100_0010"
print(int(A,16))

# %%
str_list = ["0x4", "0x10", "10"]

# 转换为整数列表
int_list = [int(s, 16) if s.startswith("0x") or s.startswith("0X") else int(s) for s in str_list]

print(int_list)


# %%
# 原始列表
my_list = ["00", "01", "02"]

# 获取前两个元素
first_two_elements = my_list[:2]

print("前两个元素:", first_two_elements)


# %%
str="00a11f"
for s in str:
    print(s)
int_list=[int(s,16) for s in str]
print(int_list)

# %%
import numpy as np
str="00a11f"
rim_matrix=[]
for s in str:
    print(s)
int_list=[int(s,16) for s in str]
rim_matrix.append(int_list)
rim_matrix.append(int_list)
rim_matrix.append(int_list)
print(rim_matrix)
rim_matrix=np.array(rim_matrix)
print(rim_matrix)


# %%
s = "001100ff"
A=[]
# 按 8-bit 切分
bit_list = [s[i:i+2] for i in range(0, len(s), 2)]

print(bit_list)


# %%
import numpy as np

# 创建两个一维向量
vector1 = np.array([[1, 2, 3]])
vector2 = np.array([[4, 5, 6]])

# 方法 1: 使用 concatenate
# concatenated_vector = np.concatenate((vector1, vector2))

# 方法 2: 使用 hstack
concatenated_vector = np.hstack((vector1[0,:], vector2[0,:]))  # 也可以使用这个方法

print("拼接后的向量:")
print(concatenated_vector)
print(vector2[0,:].shape)

# %%
import numpy as np

# 创建一个 NumPy 数组
array = np.array([[1, 2, 3],
                  [4, 5, 6]])

# 将数组转换为字符串
array_str = np.array2string(array)

print("NumPy 数组的字符串表示:")
print(type(array_str))


# %%
import numpy as np

# 创建 NumPy 数组
array = np.array([0, 1, 0, 15])

# 将数组元素转换为十六进制字符串，并去掉前缀 "0x"
hex_str = ''.join(format(x, 'x') for x in array)

print("转换后的字符串:", hex_str)


# %%
import numpy as np

# 创建一个 2x16 的矩阵
matrix = np.arange(32).reshape(2, 16)  # 示例数据 [0, 1, 2, ..., 31]

# 按列转换为 8x4 的矩阵
reshaped_matrix = matrix.reshape(8, -1, order='F')  # 'F' 表示按列优先

print("2x16 的矩阵:")
print(matrix)

print("\n转换为 8x4 的矩阵:")
print(reshaped_matrix)


# %%
A=np.zeros((10,10))
print(A)
print(A[0,:])
print(len(A))
print(A.shape)

# %%
for i in range(0,10):
    print(i)

# %%
A=np.ones((10,10))*128<127
B=np.ones_like(A)
print(A.shape,B.shape)

# %%
import numpy as np

# 创建一个示例数组
matrix = np.random.rand(5, 4)  # 5 行 4 列的矩阵

# 在每一列后面插入一个空白列
for i in range(matrix.shape[1]):
    matrix = np.insert(matrix, 2 * i + 1, np.zeros(matrix.shape[0]), axis=1)

print("插入空白列后的矩阵：")
print(matrix)


# %%
import numpy as np

# 创建一个示例矩阵 A
A = np.random.rand(5, 3)  # 5 行 3 列的随机矩阵

# 获取第一列和第二列
first_col = A[:, 0]  # 第一列
second_col = A[:, 1]  # 第二列

# 逐元素相乘
result = first_col * second_col

print("矩阵 A：")
print(A)

print("\n第一列和第二列的逐元素乘积：")
print(result)


# %%
import numpy as np

# 创建一个包含负数的数组
array = np.array([15, -2, 8, -15, 255, -128], dtype=int)

# 将数组中的每个元素转换为十六进制字符串（以补码表示处理负数）
def int_to_hex(num, bits=8):
    if num < 0:
        num = (1 << bits) + num  # 负数使用补码表示
    return f'{num:0{bits//4}x}'  # 十六进制表示

# 将整个数组转化为十六进制
hex_array = [int_to_hex(x, bits=8) for x in array]

# 将十六进制值写入到txt文件
for hex_val in hex_array:
    # f.write(hex_val + '\n')  # 每个十六进制数换行输出
    print(hex_val)
print("十六进制值已写入 output.txt 文件。")


# %%
# 假设 matrix 是一个二维数组 (比如 NumPy 数组)
import numpy as np

# 创建一个示例矩阵
matrix = np.random.rand(1000, 2000)  # 1000 行 2000 列的矩阵

# 提取最后 1944 列
last_1944_columns = matrix[:, -1943:]
print(last_1944_columns.shape)

# %% [markdown]
# 

# %%
import numpy as np

# 创建一个示例矩阵
matrix = np.random.rand(3, 5)  # 3 行 5 列的矩阵

# 翻转每一行
flipped_matrix = np.fliplr(matrix)

# 打印原始矩阵和翻转后的矩阵
print("Original matrix:")
print(matrix)

print("\nFlipped matrix:")
print(flipped_matrix)


# %% [markdown]
# ## 文件处理

# %% [markdown]
# ### 获取文件名

# %%
import os

# 获取用户输入的路径或文件名
input_path ="/BW0l Proj Digital/yao.dai/myscrip/prog tool/die_0_L2_0_L0_0"

# 获取文件名
file_name = os.path.basename(input_path)

# 输出结果
print("文件名:", file_name)


# %% [markdown]
# ### with open文件读写
# 会自动创建一个文件，无需手动创建

# %%
with open("test_file.txt","a+")as file:
    file.write("hahhah\n")


# %%
print(0x20000+1023)

# %% [markdown]
# # 获取当前py脚本所在绝对路径

# %%
import os

# 当前脚本所在的绝对路径
script_path = os.path.abspath(__file__)
print(f"脚本路径: {script_path}")

# 当前脚本所在的目录
script_dir = os.path.dirname(script_path)
print(f"脚本目录: {script_dir}")

# %%
def generate_filelist(path,match=(".sv",".v")):
    #recursily check current dir,and create filelist including every dir that include ".sv"
    directories = []
    # 递归遍历目录
    for dirpath, dirnames, filenames in os.walk(path):
        # 检查当前目录是否有 .sv 文件
        if any(file.endswith(match) for file in filenames):
            directories.append(dirpath)
    return directories        
generate_filelist("/home/dy/IC/Basic/Vip/Official_examples/tb_ahb_svt_uvm_basic_sys")

# %%
import numpy as np
with open("test.txt","w")as f:
    A=np.arange(10,dtype=np.uint8)+255

    f.write("".join(format(x,"04x") for x in A)+"\n")
    print(format(A[5],"04x"))
print(A)

# %%
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
    A=np.random.randint(0,255,size=(10,10),dtype=np.uint8)
    print(A)
    A.dtype=np.int8
    B=np.zeros((10,10),dtype=np.int16)

    # B[:,:]=A
    print(A)
    # generate_hex(B)

# %%
A=np.random.randint(0,255,size=(10,10),dtype=np.uint8)
print(A)
A.astype(np.int8)
print(A)


# %%
import numpy as np

def format_array_as_hex(array, width, sign_extend=False):
    """
    格式化 numpy 数组为指定宽度的十六进制字符串，可选是否补符号位。

    Args:
        array (Union[np.ndarray, int, list]): 输入数组或单个整数
        width (int): 格式化宽度（例如 4 表示 `04x`）
        sign_extend (bool): 是否补符号位

    Returns:
        list[str]: 格式化后的十六进制字符串列表
    """
    # 将输入统一为 numpy 数组
    if not isinstance(array, np.ndarray):
        array = np.array(array)

    # 转为 int32 以方便统一处理符号和宽度
    array = array.astype(np.int32)

    # 最大值用于无符号范围调整
    max_value = 1 << (width * 4)  # width=4 表示16位

    if not sign_extend:
        # 无符号表示，负数转换为补码形式
        array = np.where(array < 0, array + max_value, array)
    else:
        # 补符号位（补码形式扩展）
        array = np.where(array < 0, array + max_value, array)

    # 将每个元素格式化为十六进制字符串
    hex_format = f"0{width}x"
    formatted_hex = [format(val, hex_format) for val in array]
    return formatted_hex

# 示例 1: 单个无符号数值
A = np.array([255], dtype=np.uint8)

# 示例 2: 混合正负数值
B = np.array([-1, 127, 128, 255], dtype=np.int16)

# 不补符号位
print("不补符号位 A:", format_array_as_hex(A, width=4, sign_extend=False))
print("不补符号位 B:", format_array_as_hex(B, width=4, sign_extend=False))

# 补符号位
print("补符号位 A:", format_array_as_hex(A, width=4, sign_extend=True))
print("补符号位 B:", format_array_as_hex(B, width=4, sign_extend=True))


# %%
import numpy as np

def decimal_to_twos_complement_extend(num, bit_width, target_width):
    """
    将十进制数转换为补码表示，并扩展符号位。
    
    参数:
    num: int，输入的十进制数
    bit_width: int，补码的位宽（原始宽度）
    target_width: int，扩展后的宽度
    
    返回:
    int，扩展后的补码表示
    """
    if bit_width > target_width:
        raise ValueError("目标宽度必须大于或等于原始宽度")
    
    # 计算模值
    mod = 2 ** bit_width
    extended_mod = 2 ** target_width
    
    # 转为补码
    if num < 0:
        num = (mod + num) % mod
    
    # 检查范围
    if num >= mod:
        raise ValueError("输入数字超出了给定位宽的表示范围")
    
    # 符号扩展
    if num & (1 << (bit_width - 1)):  # 如果最高位是1
        num = num | (extended_mod - mod)  # 符号扩展
    else:
        num = num & (mod - 1)  # 保留低位
    
    return num

# 测试
num = -120
bit_width = 8
target_width = 12
result = decimal_to_twos_complement_extend(num, bit_width, target_width)

print(f"十进制数 {num} 转换为 {bit_width}-位补码扩展到 {target_width}-位后的值为: {hex(result)}, 十进制为: {result}")


# %%
import numpy as np

def array_decimal_to_twos_complement_extend(arr, bit_width, target_width):
    """
    将 NumPy 数组中的十进制数转换为补码表示，并扩展符号位。

    参数:
    arr: np.ndarray，输入数组
    bit_width: int，原始位宽
    target_width: int，扩展后的位宽

    返回:
    np.ndarray，补码表示并符号扩展后的数组
    """
    if bit_width > target_width:
        raise ValueError("目标宽度必须大于或等于原始宽度")
    
    mod = 2 ** bit_width
    extended_mod = 2 ** target_width

    # 转换为补码（小于0的值直接映射补码表示）
    arr = np.where(arr < 0, mod + arr, arr)

    # 符号扩展（最高位为符号位）
    arr = np.where(arr & (1 << (bit_width - 1)), arr | (extended_mod - mod), arr)
    
    return arr

# 示例
arr = np.array([5, -5, 7, -7, -1, 0],dtype=np.int8)
bit_width = 8
target_width = 12

result = array_decimal_to_twos_complement_extend(arr, bit_width, target_width)
print(f"输入数组: {arr}")
print(f"符号扩展后的数组: {result}")


# %%
import numpy as np
np.random.seed(1)
print(type(np))  # 输出应该是 <class 'module'>，否则是变量覆盖问题
L1 = np.random.randn(3, 3)
L2 = np.random.randn(3, 3)
print(L1)
print(L2)

# %%
print(format(123,"05x"))
3328*3

# %%



