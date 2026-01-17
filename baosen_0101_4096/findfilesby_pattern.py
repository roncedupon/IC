import os
import re
def find_files_by_pattern(dir,pattern):
    matched_files   =[]
    basename        =[]
    matcher         =re.compile(pattern)
    for root,dirs,files in os.walk(dir):
        for file in files:
            if matcher.match(file):
                matched_files.append(os.path.join(root,file))
                basename.append(os.path.basename(root))
    return matched_files,basename

matched_files,basename=find_files_by_pattern("./output/config/eda",r"all_instrs\.hex")
for i,item in enumerate(matched_files):
    print(item)
#%%
for root,dirs,files in os.walk("/mnt/disk_0/IC/baosen_0101_4096/output/config/eda"):
    for dir_name in dirs:
        print(dir_name)  # 只打印一级目录名
    break