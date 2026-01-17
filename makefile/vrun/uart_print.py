def hex_file_to_ascii(file_path):
    """
    读取包含十六进制值的文本文件，转换为ASCII字符（保留换行符）
    :param file_path: 文本文件路径
    :return: 转换后的ASCII字符列表、最终带换行符的可打印字符串
    """
    ascii_chars = []
    final_str = ""  # 新增：存储包含换行符的最终字符串
    try:
        # 打开文件并读取所有行
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        for line_num, line in enumerate(lines, 1):
            # 清理行内容：去掉逗号、空格、换行符，转为大写（兼容0X和0x）
            cleaned_line = line.strip().replace(',', '').upper()
            
            # 跳过空行
            if not cleaned_line:
                continue
            
            try:
                # 将十六进制字符串转换为十进制整数
                decimal_value = int(cleaned_line, 16)
                
                # 单独处理换行符（0xa/十进制10）
                if decimal_value == 10:
                    ascii_char = '\n'
                    char_desc = "'\\n' (换行符)"
                    final_str += ascii_char  # 保留真实换行符
                # 处理可打印字符（32~126）
                elif 32 <= decimal_value <= 126:
                    ascii_char = chr(decimal_value)
                    char_desc = f"'{ascii_char}'"
                    final_str += ascii_char  # 追加可打印字符
                # 其他非打印字符
                else:
                    ascii_char = f"[非打印字符: ASCII码 {decimal_value}]"
                    char_desc = ascii_char
                    # 非换行符的非打印字符不追加到最终字符串
                
                ascii_chars.append(char_desc)
                # 打印每行的转换结果（便于调试）
                print(f"第{line_num}行: {cleaned_line} -> 十进制{decimal_value} -> {char_desc}")
            
            except ValueError:
                # 处理无效的十六进制值
                print(f"警告：第{line_num}行 '{line.strip()}' 不是有效的十六进制值，已跳过")
                continue
        
        return ascii_chars, final_str
    
    except FileNotFoundError:
        print(f"错误：找不到文件 '{file_path}'")
        return [], ""
    except Exception as e:
        print(f"错误：读取/转换文件时发生异常 - {e}")
        return [], ""

# ------------------- 测试使用 -------------------
if __name__ == "__main__":
    # 替换为你的文本文件路径（比如 "hex_values.txt"）
    file_path = "/mnt/disk_0/IC/makefile/vrun/uart_print"
    #文件内容支持0x11,11,0A等格式的十六进制数
    result, final_str = hex_file_to_ascii(file_path)
    
    # 输出最终包含换行符的ASCII字符串（可视化展示）
    print("\n最终带换行符的ASCII字符串（可视化）：")
    print(f"'{final_str}'")
    # 直接打印原始字符串（直观看到换行效果）
    print("\n最终字符串原始打印效果：")
    print(final_str)