#%%
import os
if "DISPLAY" in os.environ:
    print("hh")

#%%
def get_nonzero_bit_indices(value):
    bin_str = bin(value)[2:]  # 去掉 '0b' 前缀
    indices = [i for i, bit in enumerate(bin_str[::-1]) if bit == '1']
    return indices

# 示例
n = 6  # 二进制为 110
print(get_nonzero_bit_indices(n))  # 输出: [1, 2]
