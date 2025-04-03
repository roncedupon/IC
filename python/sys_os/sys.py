# python有一个sys.argv,默认长度是1，即当前运行的py文件的路径
import sys
print(sys.argv)

# 当然，如果运行时传入了一系列参数，那么sys.argv会将这些参数也保存
# python sys.py -h hhh -a fuck
# 输出：['sys.py', '-h', 'hhh', '-a', 'fuck']

#于是，可以使用getopt来获取py脚本传入的参数
import getopt
opts,args=getopt.getopt(sys.argv[1:],"-h-i:-m:-j:-c",["help","input=","mode=","json=","clean"])
#此处的args是非选项参数的列表，代表命令行中未解析为选项的内容。
print(opts)
print(args)
#python sys.py -h -i input.txt -m default -j test.json -c
#输出：[('-h', ''), ('-i', 'input.txt'), ('-m', 'default'), ('-j', 'test.json'), ('-c', '')]

#当然，-h-i:这说明-h不需要参数，-i需要参数，如果不给-i参数，会报错
#python sys.py -h -i -m default -j test.json -c

# 当然，上面用的是短选项，还可以用后面的长选项
# python sys.py -h --input=input.txt --clean


#%%
import os
import shutil

def copy_and_rename_files(directory):
    # 获取目录中的所有文件
    files = [f for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]
    
    # 遍历文件列表并复制重命名
    for file in files:
        if "x0" in file:
            new_file = file.replace("x0", "x1")
            shutil.copy(os.path.join(directory, file), os.path.join(directory, new_file))
            print(f"Copied {file} to {new_file} in {directory}")

# 示例使用
directory_path ="./"
copy_and_rename_files(directory_path)

# %%
import os
print(os.path.basename("/mnt/disk_0/IC"))