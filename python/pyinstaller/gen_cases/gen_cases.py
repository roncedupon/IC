import os
import sys
class gen_cases():
    def __init__(self):
        # 判断当前运行环境
        if getattr(sys, '_MEIPASS', False):
            # 如果是在 PyInstaller 打包后的环境中，使用临时目录
            base_path = sys._MEIPASS
        else:
            # 如果是在开发环境中，使用当前文件所在目录
            base_path = os.path.dirname(os.path.abspath(__file__))

        # 在此之后可以根据 base_path 构造文件路径
        template_path = os.path.join(base_path,'template')
        print(template_path)
        
        with open(os.path.join(template_path,"SEQ.sv"))as f:
            print(f.read())
        with open(os.path.join(template_path,"TEST.sv"))as f:
            print(f.read())
        
