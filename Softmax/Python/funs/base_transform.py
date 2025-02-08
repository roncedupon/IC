#进制转换
def dec2bin_old(num,num_bits=8):
    # format_str="{:08b}"
    binary = "{:b}".format(num & (0xFF))
    return binary  # 输出：11111111

def dec2bin(decimal, num_bits=8):
    if decimal >= 0:
        # 正数的处理
        binary = bin(decimal)[2:]
        binary = binary.zfill(num_bits) if len(binary) < num_bits else binary
    else:
        # 负数的处理
        binary = bin(decimal & int("1"*num_bits, 2))[2:]
    return binary

def Complt2Sourcd(binary):
    #输入一个补码格式的二进制数，返回其十进制
    decimal = int(binary, 2)
    if binary[0] == '1':  # 检查最高位是否为1，表示负数
        decimal -= 2 ** len(binary)  # 计算补码对应的十进制数
    print(decimal)  # 输出：-2
    return decimal

def dec2hex(decimal_value, bit_len=8):
    # 计算所需的位掩码
    bit_mask = (1 << bit_len) - 1
    
    # 计算所需的十六进制字符串长度
    hex_len = (bit_len + 3) // 4  # 每4位表示一个十六进制字符
    
    # 将带符号的十进制转换为不带符号补码表示的十六进制
    hex_value = format(int(decimal_value)& bit_mask, f'0{hex_len}X')
    
    # print(hex_value)  # 输出不带符号补码表示的十六进制值
    return hex_value
def hex2dec_complt(hex):
    return Complt2Sourcd(dec2bin(int(hex,16)))

def hex2dec(hex):
    return int(hex,16)
# 示例调用
# print(dec2hex(-2719, 8))   
# print(dec2hex(-2719, 16))  
# print(dec2hex(-2719, 32))  
# print(dec2hex(-2719, 64))  
    
# print(dec2bin_old(-1))
# print(dec2bin(-1,16))
# print(Complt2Sourcd(dec2bin(-1)))
