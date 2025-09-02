import re
import argparse
import csv
from openpyxl import load_workbook
from openpyxl.worksheet.worksheet import Worksheet
import os
class cc_extractor:
    def mkdir(self,path):
        if os.path.exists(path):
            pass
        else:
            os.makedirs(path)    
    def __init__(self):
        self.args=self.cfg_args()
        self.out_dir="./output"
        self.mkdir(self.out_dir)

        #sheet type define
        self.CONNECTION_TYPE="connection"
        self.ALIAS_CONST_TYPE="alias/const"

        #connection head define
        self.DIRECTION_STR  ="direction"  
        self.CONDITION_STR  ="condition"  
        self.AHIERARCHY_STR ="A_hierarchy"
        self.APORTNAME_STR  ="A port name"
        self.ACOUNT_STR     ="A_count"    
        self.AWIDTH_STR     ="A_width"    
        self.BHIERARCHY_STR ="B_hierarchy"
        self.BPORTNAME_STR  ="B port name"
        self.BCOUNT_STR     ="B_count"    
        self.BWIDTH_STR     ="B_width"    
        self.CLKDOMAIN_STR  ="clk domain" 
        self.DELAY_STR      ="delay"      


    def cfg_args(self):
            parser=argparse.ArgumentParser(description="toolbox")
            parser.add_argument("-i",metavar="",help="cc.xlsx",default="cc.xlsx")
            
            # parser.add_argument("-t",metavar="",help="uvm test_name for single run",default=None)
            # parser.add_argument("-only_run",action="store_true",help="dont compile ,only run using existed build files",default=False)
            args=parser.parse_args()
            return args    
    def parse_cc_sheets(self,xlsx_path):
        wb = load_workbook(xlsx_path)
        sheet_names=wb.sheetnames
        print(sheet_names)
        for sheet_name in sheet_names:
            working_sheet=wb[sheet_name]
            sheet_type=working_sheet.cell(row=1,column=1).value
            if sheet_type==self.CONNECTION_TYPE:
                print("creating connection csv...")
                All_rows=self.extract_connection(working_sheet)
                self.output_connection_csv(All_rows,sheet_name+".csv")
            elif sheet_type==self.ALIAS_CONST_TYPE:
                print("creating alias/const ...")
            else:
                print(f"Sheet:{sheet_name} type unknown ,please check it .")


    def extract_connection(self,sheet:Worksheet):
        name_idx=0

        #default value config
        DEAFULE_VALUE={
        self.DIRECTION_STR  :   0,        # 0
        self.AHIERARCHY_STR :   "",      # Warning
        self.APORTNAME_STR  :   "",      # Warning
        self.ACOUNT_STR     :   1,          # 1
        self.AWIDTH_STR     :   "",          # None
        self.BHIERARCHY_STR :   "",      # Warning
        self.BPORTNAME_STR  :   "",      # Warning
        self.BCOUNT_STR     :   1,          # 1
        self.BWIDTH_STR     :   "",          # None
        self.CONDITION_STR  :   1,        # 1
        self.CLKDOMAIN_STR  :   "",       # Warning
        self.DELAY_STR      :   0             # 0
        }
        COL_INDEX={}

        idx=0
        for key in DEAFULE_VALUE.keys():# column index will be generated automatically
            COL_INDEX[key]=idx
            idx+=1
        
        max_row=sheet.max_row

        #default value config:
        All_rows=[]
        for row_indx in range(3,max_row+1):#start from second row
            row=[cell.value for cell in sheet[row_indx]]
            for column_name,default_vlaue in DEAFULE_VALUE.items():
                if row[COL_INDEX[column_name]]==None:
                    row[COL_INDEX[column_name]]=default_vlaue
                    
            #count config and duplicate
            Acount=row[COL_INDEX[self.ACOUNT_STR]]
            sub_fix=""if Acount==1 else f"{num}"
            for num in range(Acount):
                src     =".".join([row[COL_INDEX[self.AHIERARCHY_STR]]+sub_fix,row[COL_INDEX[self.APORTNAME_STR]]+sub_fix])
                dest    =".".join([row[COL_INDEX[self.BHIERARCHY_STR]]+sub_fix,row[COL_INDEX[self.BPORTNAME_STR]]+sub_fix])
                if row[COL_INDEX[self.DIRECTION_STR]]==1:#direction config
                    tmp=src
                    src=dest
                    dest=tmp
                
                enable=row[COL_INDEX[self.CONDITION_STR]]
                # src
                # dest
                delay=str(row[COL_INDEX[self.DELAY_STR]])
                clk_domain=row[COL_INDEX[self.CLKDOMAIN_STR]]

                All_rows.append(",".join([enable,src,dest,delay,clk_domain]))
        return All_rows
    def unflatten_forloop(self,str1,str2):
        pass
    def output_connection_csv(self,connection_defines:list,file_name):

        with open(self.out_dir+"/"+file_name,"w")as f:
            for idx,line in enumerate(connection_defines):
                f.write(line+f",{file_name}_{str(idx)}\n")

    def cc_extractor_main(self):
        self.parse_cc_sheets(self.args.i)

if __name__=="__main__":
    cc_extractor_inst=cc_extractor()
    cc_extractor_inst.cc_extractor_main()


# fields = []
# defaults = []

# # 读取第一行的表头
# for cell in ws[1]:
#     text = str(cell.value).strip() if cell.value else ""
#     # 提取字段名（第一段非空字符串）
#     field = text.split()[0] if text else ""
#     fields.append(field)
#     # 提取 default 值
#     m = re.search(r'default:(\d+)', text)
#     defaults.append(m.group(1) if m else "")

# # 写入 CSV
# with open("connectivity_template.csv", "w", newline='', encoding="utf-8") as f:
#     writer = csv.writer(f)
#     writer.writerow(fields)    # 第一行：字段名
#     writer.writerow(defaults)  # 第二行：默认值

# print("CSV 模板已生成：connectivity_template.csv")

#%%
import re

def replace_nth(s, match, repl, n):
    """
    在字符串 s 中，把第 n 次出现的 {match} 替换为 repl
    """
    pattern = r"\{" + re.escape(match) + r"\}"  # 匹配 {0:2} 这种形式
    matches = list(re.finditer(pattern, s))
    if len(matches) >= n:
        target = matches[n-1]   # n 从 1 开始计数
        start, end = target.span()
        return s[:start] + repl + s[end:]
    return s  # 如果匹配次数不够，返回原字符串

# 示例
s = "LAYER{0:7}_L2_{0:2}_xxxx_{0:2}"

print(replace_nth(s, "0:2", "AA", 1))  # 替换第1个 {0:2}
print(replace_nth(s, "0:2", "AA", 2))  # 替换第2个 {0:2}
print(replace_nth(s, "0:7", "BB", 1))  # 替换 {0:7}



#%%
import re


def replace_nth(s, match, repl, n):
    """
    在字符串 s 中，把第 n 次出现的 {match} 替换为 repl
    """
    pattern = r"\{" + re.escape(match) + r"\}"  # 匹配 {0:2} 这种形式
    matches = list(re.finditer(pattern, s))
    if len(matches) >= n:
        target = matches[n-1]   # n 从 1 开始计数
        start, end = target.span()
        return s[:start] + repl + s[end:]
    return s  # 如果匹配次数不够，返回原字符串


str1="LAYER{0:7}_L2_{0:2}_xxxx"
str2="bw01d_pkg_top.fdie.loop_flash_die_single[{0}].u_flash_die_single_layer.u_flash_die_l2_top_{1}"
matches_str1=re.findall("\{(.*?)\}",str1)
matches_str2=re.findall("\{(.*?)\}",str2)

# str1_flattened=[]
# for idx,match in enumerate(matches_str1):
#     lower   =int(match.split(":")[0])
#     higher  =int(match.split(":")[1])
#     for i in range(lower,higher+1):
#         replaced=replace_nth(str1,match,str(i),0)
#         print(replaced)

def expand_range_placeholders(s):
    matches = re.findall(r"\{(\d+:\d+)\}", s)
    if not matches:
        return [s]  # 没有占位符，返回原字符串

    match = matches[0]
    lower, higher = map(int, match.split(":"))
    results = []
    for i in range(lower, higher + 1):
        # 替换第一个匹配
        replaced = re.sub(r"\{" + re.escape(match) + r"\}", str(i), s, count=1)
        # 递归展开剩余的
        results.extend(expand_range_placeholders(replaced))
    return results

# 示例
str1 = "LAYER{0:7}_L2_{0:2}_xxxx"
expanded = expand_range_placeholders(str1)

for e in expanded:
    print(e)

print("总数:", len(expanded))

# def replace_all(str,matchs,str_to_replace,last_one=False):

#     replaced=replace_nth(str,str_to_replace,0)
#     if last_one:
#         print(replaced)
#     else:
#         replace_all()