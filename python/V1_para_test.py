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

