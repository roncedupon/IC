import openpyxl
import os
from instrlist import *
import argparse
def cfg_args():
    parser = argparse.ArgumentParser(description="regression script!!!")
    parser.add_argument('-i',metavar='',help="input regression dat file")
    

    args = parser.parse_args()

    return args

class regression_statistic:
    def __init__(self):
        self.args=cfg_args()
        self.PASS_CHECKFAIL = "通路PASS,CHECK-FAIL"

        self.PASS = "PASS"
        self.TIMEOUT = "超时FAIL"
        self.RUNNING = "进行中"        
        self.fixed_order={}
        self.newcase=[]
        for i in range(len(instrlist)):
            self.fixed_order[i]=instrlist[i]
        print(self.fixed_order)
    def mkdir(self,path):
        if os.path.exists(path):
            pass
        else:
            os.makedirs(path)
    def merge_regression_result(self):
        regression_dat_filelist=[]
        regression_dat=[]
        if os.path.isdir(self.args.i):
            all_entries=os.listdir(self.args.i)
            for entry_name in all_entries:
                if entry_name.split(".")[-1]=="dat":
                    with open(self.args.i+"/"+entry_name,"r")as f:
                        regression_dat+=f.readlines()
        else:
            with open(self.args.i,"r")as f:
                regression_dat=f.readlines()
        self.regression_dat=regression_dat
        return regression_dat
    def genxlsx(self,fixed_order=None,lines=None):
        message = "test.dat"#input("presim name dat:")
        if fixed_order is None:
            fixed_order=self.fixed_order
        if lines is None:
            lines=self.regression_dat

        wb = openpyxl.Workbook()
        sheet = wb.active
        ###header
        # sheet.append(['number','name','status'])
        
        data = []
        existing_fixed_cases = set()
        for index,line in enumerate(lines):
            if line.startswith('|'):
                parts = line.strip().split('|')
                if len(parts)>2:
                    case_number = parts[0].strip()
                    case_number = int(parts[0].strip())
                    case_name = parts[1].split(']')[0].split('[')[-1].split('.')[0]
                    case_status = parts[2].strip().split('(')[0]

                    newcase_flag=True
                    for order,name in fixed_order.items():
                        # case_name   =fixed_order[index]
                        # case_status =regression_statistic_inst.RUNNING
                        if name in case_name and name not in existing_fixed_cases:
                            data.append([order,name,case_status])
                            existing_fixed_cases.add(name)
                            newcase_flag=False#这个case已在instrlist中存在,无需处理
                            break
                    if newcase_flag:
                        self.newcase.append(case_name)
                    if 'blsel_instr_switch_test' in case_name and 'blsel_instr_switch_test' not in existing_fixed_cases:
                        data.append([88,'blsel_instr_switch_test',case_status])
                        existing_fixed_cases.add('blsel_instr_switch_test')
        print("============new case detected===========",self.newcase)
        for order,name in fixed_order.items():
            if name not in existing_fixed_cases:
                data.append([order,name,None])
        data.sort(key=lambda x: x[0])
        for row in data:
            sheet.append(row)

        wb.save('instr_output.xlsx')        
if __name__ == "__main__":
    regression_statistic_inst=regression_statistic()
    regression_statistic_inst.merge_regression_result()
    regression_statistic_inst.genxlsx()
    ###read data
