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
