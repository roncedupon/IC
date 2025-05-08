import openpyxl
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
        for i in range(len(instrlist)):
            self.fixed_order[i+1]=instrlist[i]
        print(self.fixed_order)

if __name__ == "__main__":
    regression_statistic_inst=regression_statistic()
    ###read data
    message = input("presim name dat:")
    with open(message,"r") as file:
        lines = file.readlines()
    file.close()
    wb = openpyxl.Workbook()
    sheet = wb.active
    ###header
    sheet.append(['number','name','status'])
    fixed_order=regression_statistic_inst.fixed_order
    data = []
    existing_fixed_cases = set()
    for line in lines:
        if line.startswith('|'):
            parts = line.strip().split('|')
            if len(parts)>2:
                case_number = parts[0].strip()
                case_number = int(parts[0].strip())
                case_name = parts[1].split(']')[0].split('[')[-1].split('.')[0]
                case_status = parts[2].strip().split('(')[0]

                for order,name in fixed_order.items():
                    if name in case_name and name not in existing_fixed_cases:
                        data.append([order,name,case_status])
                        existing_fixed_cases.add(name)
                        break

                if 'blsel_instr_switch_test' in case_name and 'blsel_instr_switch_test' not in existing_fixed_cases:
                    data.append([88,'blsel_instr_switch_test',case_status])
                    existing_fixed_cases.add('blsel_instr_switch_test')

    for order,name in fixed_order.items():
        if name not in existing_fixed_cases:
            data.append([order,name,None])

    data.sort(key=lambda x: x[0])
    for row in data:
        sheet.append(row)

    wb.save('instr_output.xlsx')