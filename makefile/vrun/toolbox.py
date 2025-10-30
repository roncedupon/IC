import os
import re
import argparse

class toolbox:
    def cfg_args(self):
        parser=argparse.ArgumentParser(description="toolbox")
        
        parser.add_argument("-i",nargs="+",metavar="",help="input json path")
        parser.add_argument("-mode",nargs="+",metavar="",help="input json path",default=["m0"])
        args=parser.parse_args()

        return args    
    def __init__(self):
        self.args=self.cfg_args();
        pass
    def get_all_files(self, dir_path, pattern=None, recursive=True):
        """
        version: 20250401
        递归获取目录下所有文件路径（可选正则过滤）
        :param dir_path: 目标目录路径
        :param pattern: 正则表达式过滤模式（可选）
        :param recursive: 是否递归子目录
        :return: 文件路径列表
        -------------------------------------------------------------------
        使用：    
        tool = toolbox()
        files = tool.get_all_files(".", pattern=r"\.gitignore")
        print("Python files:", files)
        -------------------------------------------------------------------
        注意：
        1、这里输入的pattern是正则表达式，需要加r说明这是一个原始字符串，
            让py不处理转义字符\，因为正则表达式也需要用到转义字符
        2、需要正确使用正则表达式，.gitignore会匹配出各种牛马蛇神，比如Aignore,Bignore....
            如果只需要查找.gitignore，则需要用\.gitignore
        """
        file_list = []
        dir_path=os.path.abspath(dir_path)
        try:
            # 参数校验
            if not os.path.isdir(dir_path):
                raise ValueError(f"Invalid directory path: {dir_path}")
            # 编译正则表达式（如果提供）
            regex = re.compile(pattern) if pattern else None
            # 遍历目录
            for root, dirs, files in os.walk(dir_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    
                    # 正则匹配过滤
                    if regex and not regex.search(file):
                        continue
                        
                    file_list.append(file_path)
                # 如果不递归则只处理当前目录
                if not recursive:
                    break
        except Exception as e:
            print(f"Error scanning directory: {e}")
            return []
        return file_list
    
    def bin2hex(self, bin_str):

        """二进制字符串转十六进制字符串"""
        bin_str = bin_str.replace(' ', '').replace('0b', '')
        if not all(c in '01' for c in bin_str):
            raise ValueError(f"Invalid binary string: {bin_str}")
        # 补零使长度为4的倍数
        length = len(bin_str)
        pad = (4 - (length % 4)) % 4
        bin_str = '0' * pad + bin_str
        # 分组转换
        hex_str = ''
        for i in range(0, len(bin_str), 4):
            nibble = bin_str[i:i+4]
            hex_digit = format(int(nibble, 2), 'x')
            hex_str += hex_digit
        return hex_str
    def bin2dec(self,bin_str):
        if not all(c in '01' for c in bin_str):
            raise ValueError(f"Invalid binary string: {bin_str}")
        if not bin_str:
            return 0
        return int(bin_str, 2)
    def hex2bin(self, hex_str: str, min_bits: int = 64) -> str:
        if hex_str.startswith("0x") or hex_str.startswith("0X"):
            hex_str = hex_str[2:]
        if not all(c in '0123456789abcdefABCDEF' for c in hex_str):
            raise ValueError(f"Invalid hexadecimal string: {hex_str}")
        if not hex_str:
            return "".zfill(min_bits)

        dec_val = self.hex2dec(hex_str)
        bin_val = bin(dec_val)[2:] # Remove "0b" prefix

        # Calculate required bits based on hex length, ensure minimum bits
        required_bits = max(len(hex_str) * 4, min_bits)
        return bin_val.zfill(required_bits) # Pad with leading zeros
    def hex2dec(self,hex_str):
        if hex_str.startswith("0x") or hex_str.startswith("0X"):
            hex_str = hex_str[2:]
        if not all(c in '0123456789abcdefABCDEF' for c in hex_str):
             raise ValueError(f"Invalid hexadecimal string: {hex_str}")
        if not hex_str:
            return 0
        return int(hex_str, 16)
    def dec2hex(self):
        pass
    def dec2bin(self,dec_int):
        if not isinstance(dec_int):
            raise TypeError("Input must be an integer.")
        if dec_int < 0:
            raise ValueError("Input must be a non-negative integer for standard binary conversion.")
        bin_str = bin(dec_int)[2:] # Remove "0b" prefix
        return bin_str


    def detect_number_base(self,number_str):
        number_str = number_str.strip().lower()
        
        if re.fullmatch(r'0b[01]+', number_str):
            print("Detect input format is bin")
            return "bin"
        elif re.fullmatch(r'0x[0-9a-f]+', number_str) or re.fullmatch(r'[0-9a-f]+', number_str):
            print("Detect input format is hex")
            return "hex"
        elif re.fullmatch(r'\d+', number_str):
            print("Detect input format is dec")
            return "dec"
        else:
            return "Unknown format (未知格式)"
        # 测试示例
        examples = ["0b1010", "0X1A3F", "12345", "0b102", "0XGHI", "abcdef", "1234A4"]
        for ex in examples:
            print(f"{ex}: {detect_number_base(ex)}")

    def estimate_display_width(self,s):
        """估算中英文混合字符串在终端中的显示宽度"""
        chinese_chars = re.findall(r'[\u4e00-\u9fff，。！【】、：《》“”]', s)
        return len(s) + len(chinese_chars)  # 中文字符额外占1宽度（即总共2）

    def pad_display(self,s, total_width):
        """补足字符串显示宽度（近似）"""
        current_width = self.estimate_display_width(s)
        pad_spaces = total_width - current_width
        return s + ' ' * max(0, pad_spaces)            
    def colored(self,text, color="white", on_color="black", style=None):
        """
        为字符串 text 添加 ANSI 颜色／样式。
        
        参数：
            color      : 前景色，支持 (black, red, green, yellow, blue, magenta, cyan, white)
            on_color   : 背景色，格式同 color
            style      : 文本样式，支持 (bold, dim, underline, reverse)
        返回：
            带 ANSI 转义码的字符串，打印时即带颜色／样式。
        """
        COLORS = {
            'black':   90, 'red':     91, 'green':   92, 'yellow':  93,
            'blue':    94, 'magenta': 95, 'cyan':    96, 'white':   97,
        }
        
        ON_COLORS = {
            'black':   100, 'red':    101, 'green':  102, 'yellow': 103,
            'blue':    104, 'magenta':105, 'cyan':   106, 'white':  107,
        }
        STYLES = {
            'bold':      1,
            'dim':       2,
            'underline': 4,
            'reverse':   7,
        }
        codes = []
        if style in STYLES:
            codes.append(str(STYLES[style]))
        if color in COLORS:
            codes.append(str(COLORS[color]))
        if on_color:# and on_color.startswith('on_'):
            bg = on_color[3:]
            if bg in COLORS:
                codes.append(str(COLORS[bg] + 10))
        if not codes:
            return text
        prefix = '\033[' + ';'.join(codes) + 'm'
        suffix = '\033[0m'
        return f"{prefix}{text}{suffix}"
    
    def binary_process(self,input_data,msb,lsb,output_format="hex",input_format="hex"):
        #输入"abc1223",通过lsb/msb解析出对应的数据
        if input_data==None:
            input_data=self.args.i
        if lsb < 0 or msb < lsb:
            raise ValueError(f"Invalid bit range: LSB={lsb}, MSB={msb}. Requires MSB >= LSB >= 0.")
        # 1. Convert input data to binary string
        if input_format.lower() == "hex":
            bin_str = self.hex2bin(input_data)
        elif input_format.lower() == "bin":
            # Validate binary input
            bin_str = input_data.replace(' ', '').replace('0b', '')
            if not all(c in '01' for c in bin_str):
                 raise ValueError(f"Invalid binary string provided for input_format='bin': {input_data}")
            # bin_str = input_data
        else:
            raise ValueError(f"Unsupported input_format: {input_format}. Use 'hex' or 'bin'.")        
        # Ensure input was not empty resulting in empty bin_str if lsb/msb require bits
        if not bin_str and (msb >= 0 or lsb >= 0):
             raise ValueError("Input data is empty, cannot extract bits.")
        # 2. Check if MSB is within the bounds of the binary string
        num_bits = len(bin_str)
        if msb >= num_bits:
            raise ValueError(f"MSB ({msb}) is out of range for the input data which has {num_bits} bits.")
        # 3. Extract the relevant bits
        # Indices are calculated from the left (standard string slicing)
        # Bit position 'p' (0-indexed from LSB) corresponds to index 'num_bits - 1 - p'
        start_index = num_bits - 1 - msb
        end_index = num_bits - 1 - lsb + 1 # Slice goes up to, but not including, end_index
        if start_index < 0 or end_index > num_bits:
             # This shouldn't happen if previous checks passed, but good for safety
             raise ValueError("Calculated slice indices are out of bounds.")
        extracted_bin = bin_str[start_index:end_index]                                

        # 4. Convert extracted binary to the desired output format
        if output_format.lower() == "hex":
            return self.bin2hex(extracted_bin)
        elif output_format.lower() == "dec":
            return self.bin2dec(extracted_bin)
        elif output_format.lower() == "bin":
            return extracted_bin
        else:
            raise NotImplementedError(f"Unsupported output_format: {output_format}. Use 'hex', 'dec', or 'bin'.")
    def main(self):
        if "m0" in self.args.mode:
            if len(self.args.i)==1:
                self.args.i.append(0)#msb
            if len(self.args.i)==2:
                self.args.i.append(0)
            if len(self.args.i)==3:
                self.args.i.append("hex")#输出格式控制
            if len(self.args.i)==4:#输入格式控制(自动推断)
                self.args.i.append(self.detect_number_base(self.args.i[0]))
            print(self.args.i)
            print(self.binary_process(self.args.i[0],int(self.args.i[1]),int(self.args.i[2]),self.args.i[3],self.args.i[4]))
            #toolbox -i [输入数据] [msb] [lsb] [bin/hex/dec] [bin/hex/dec]
        elif "m1" in self.args.mode:
            self.binary_file_process(self.args.i[0])
    def binary_file_process(self,file_path):
        #%%
        with open(file_path,"rb")as f:
            byte_data=f.read(8)
            print(byte_data)
            byte_stream=" ".join(format(byte,"08b")for byte in byte_data)
            print(byte_stream)
    
# 使用示例
if __name__ == "__main__":
    toolbox_inst=toolbox()
    toolbox_inst.main()
    pass

# #%%
# [A,B,C]=[1,2,3]
# print(format(0x12,"08b"))
# data=[1234,5678,12324]
# data_bytes=b''.join([item.to_bytes(4,byteorder="little") for item in data])
# print(data_bytes)
# with open("test.bin","wb")as f:
#     f.write(data_bytes)
# #%%
# a=[1,2,3]
# a.append([3,4,5])
# print(a)

# for index,item in enumerate(a):
#     print(index,item)

# #%%
# A="00011"
# print(int(A,base=2))