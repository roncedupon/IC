import argparse
def cfg_args():
    parser=argparse.ArgumentParser(description="Welcome")
    parser.add_argument('-t',metavar='',help="")
    parser.add_argument('-f',metavar='FILE',help="")#metavar用于在help中输出一个占位符
    parser.add_argument('-check',action="store_true",help="",default=False)
    # parser.add_argument('-check',metavar="FILE",action="store_true",,help="",default=False)
    # #需要注意action和metavar不能同时出现，因为action不需要用户输入值了
    args=parser.parse_args()
    return args
class MyClass:
    def __init__(self):
        self.args=cfg_args()
if __name__ == "__main__":
    MyClass_Inst=MyClass()
    print(MyClass_Inst.args)
    print(MyClass_Inst.args.t)

#%%
A=[4,5,6,4,5,6,4,5,6]
for idx, item in enumerate(A):
    print(idx,item)
    idx=2+idx
#%%
for i in range(16):
    print(i)
    i+=2
#%%
import re

line = "reg_test(FC0_ADDR+0xb100 + 0x4*0, 0llu        , 0x37d04350llu, 0x1     , 31, 0);"

# 提取括号里的内容
args_str = re.search(r'reg_test\s*\((.*?)\)', line).group(1)

# 用逗号分隔，并去掉多余空白
args = [arg.strip() for arg in args_str.split(',')]

print("参数列表:")
for i, arg in enumerate(args):
    print(f"  参数{i+1}: {arg}")
