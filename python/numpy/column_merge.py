import numpy as np

# 示例数组，每行两个整数
arr = np.array([
    [1, 255],
    [16, 32],
    [0, 1],
    [255, 0],
])

# 提取两列
col1 = arr[:, 0]
col2 = arr[:, 1]

# 定义融合函数
def merge_hex(a, b):
    # 分别转为两位十六进制字符串，不足补0
    hex_a = format(a, '02x')
    hex_b = format(b, '02x')
    # 拼接后转回十进制
    return int(hex_a + hex_b, 16)

# 向量化操作
merge_vec = np.vectorize(merge_hex)

# 得到融合后的新列
merged = merge_vec(col1, col2)

print("原数组:")
print(arr)
print("融合结果:")
print(merged)
print(format(arr[:, 0],"02x"))