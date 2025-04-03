#%%
import numpy as np
from openpyxl import Workbook

# 创建一个超大的 numpy 二维矩阵
large_matrix = np.random.randint(0,255,(3328,1000))  # 3328x3328 的矩阵

# 创建一个新的工作簿和工作表
wb = Workbook()
ws = wb.active

# 定义一个生成器，逐行生成数据
def matrix_generator(matrix):
    for row in matrix:
        yield row.tolist()

# 使用生成器和 append 方法分批写入数据
for row in matrix_generator(large_matrix):
    ws.append(row)

# 保存工作簿
wb.save("large_matrix.xlsx")
#%%
import numpy as np
import csv

# 创建一个超大的 numpy 二维矩阵
large_matrix = np.random.randint(0,255,(3328,3328))  # 3328x3328 的矩阵

# 保存为 CSV 文件
with open('large_matrix.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    for row in large_matrix:
        writer.writerow(row)

#%%
import numpy 
print(numpy.zeros((1,10)))

#%% 将矩阵的没两列合并成一列
import numpy as np

# 示例矩阵 (4x6)
arr = np.arange(24).reshape(4, 6)
print("原矩阵:\n", arr)

# 定义转换函数：将数值转为2位十六进制（去掉前缀'0x'，补零对齐）
to_hex = lambda x: format(x, '02x')  # 例如 15 → '0f'

# 对每两列操作：转换为十六进制后拼接
hex_merged = np.array([
    [int(to_hex(a) + to_hex(b),16) for a, b in row.reshape(-1, 2)]  # 每两列合并
    for row in arr
])

print("\n合并后的十六进制列:\n", hex_merged)
#%%
import numpy as np
int("22",16)