def hex_to_twos_complement(hex_str, bits):
    # 将十六进制字符转换为整数
    num = int(hex_str, 16)
    
    # 如果符号位为1，说明是负数（补码表示）
    if num >= 2**(bits - 1):
        num -= 2**bits
    
    return num

# 示例用法：
hex_str = "F"
bits_4 = 4  # 4位表示
bits_8 = 8  # 8位表示

# 4 位补码表示
result_4 = hex_to_twos_complement(hex_str, bits_4)
print(f"4 位补码表示下的 {hex_str} 是十进制: {result_4}")

# 8 位补码表示
result_8 = hex_to_twos_complement(hex_str, bits_8)
print(f"8 位补码表示下的 {hex_str} 是十进制: {result_8}")
