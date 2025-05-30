import openpyxl
import os
import sys
import json
from instrlist import *
THIS_FILE_PATH  = os.path.abspath(__file__)
THIS_FILE_DIR   = os.path.dirname(THIS_FILE_PATH)
sys.path.append(f"{THIS_FILE_DIR}/..")
from toolbox import toolbox
import argparse
import re

def cfg_args():
    parser = argparse.ArgumentParser(description="Regression script")
    parser.add_argument('-i', metavar='', help="Input regression .dat file")
    args = parser.parse_args()
    return args

class regression_statistic(toolbox):
    def __init__(self):
        self.args = cfg_args()

        self.json_dict=""
        self.STATUS_DICT = {
            "sim_failed": "Path PASS, CHECK-FAIL",
            "sim_passed": "PASS",
            "sim_timeout": "Timeout FAIL",
            "running": "Running"            
        }

        self.fixed_order = {}
        self.newcase = []
        for i in range(len(instrlist)):
            self.fixed_order[i] = instrlist[i]
        print(self.fixed_order)
    def get_regression_list(self,json_list_path):
        if os.path.isfile(json_list_path):
            with open(json_list_path,"r")as f:
                json_str=f.read()
            print(json.load(json_str))

    def mkdir(self, path):
        if not os.path.exists(path):
            os.makedirs(path)

    def merge_regression_result(self):
        regression_dat_filelist = []
        regression_dat = []
        if os.path.isdir(self.args.i):
            all_entries = os.listdir(self.args.i)
            for entry_name in all_entries:
                if entry_name.split(".")[-1] == "dat":
                    with open(self.args.i + "/" + entry_name, "r") as f:
                        regression_dat += f.readlines()
        else:
            with open(self.args.i, "r") as f:
                regression_dat = f.readlines()
        self.regression_dat = regression_dat
        return regression_dat

    def genxlsx(self, fixed_order=None, lines=None):
        message = "test.dat"
        if fixed_order is None:
            fixed_order = self.fixed_order
        if lines is None:
            lines = self.regression_dat

        wb = openpyxl.Workbook()
        sheet = wb.active

        data = []
        existing_fixed_cases = set()
        for index, line in enumerate(lines):  # First, check existing cases in instrlist.py
            if line == '|16        ./instr_configburst_test_59907/instr_configburst_test_59907.log                           |sim_passed        |post_passed        \n':
                pass
                print("hh")
            if line.startswith('|'):
                parts = line.strip().split('|')
                if len(parts) > 2:
                    case_name = "_".join((parts[1].split(".")[1].split("/")[-1]).split("_")[0:-2])
                    case_status = self.STATUS_DICT[parts[2].strip().split('(')[0]]

                    newcase_flag = True
                    for order, name in fixed_order.items():
                        if name == case_name and name not in existing_fixed_cases:
                            data.append([order, name, case_status])
                            if name == "instr_configburst":
                                print("hh")
                            existing_fixed_cases.add(name)
                            newcase_flag = False  # Case already exists, no need to process again
                            break
                    if newcase_flag:
                        self.newcase.append(case_name)

        if len(self.newcase) > 0:
            print("================= New Cases Detected ====================")
            for index, case_name in enumerate(self.newcase):
                is_last = (index == len(self.newcase) - 1)
                if is_last:
                    print(f'"{case_name}"')
                else:
                    print(f'"{case_name}",')
            print("============ Above Are All Detected New Cases ===========")

        for order, name in fixed_order.items():
            if name not in existing_fixed_cases:
                data.append([order, name, self.STATUS_DICT["running"]])
        data.sort(key=lambda x: x[0])
        for row in data:
            sheet.append(row)
        self.regression_result = data
        wb.save('instr_output.xlsx')        

    def calculate_status_percentage(self,regression_result=None):
        # 获取当前数据
        if regression_result is None:
            regression_result = self.regression_result
        data = regression_result

        total_cases = len(data)
        if total_cases == 0:
            print("No test case data found")
            return
        
        status_counts = {
            "PASS": 0,
            "通路PASS,CHECK-FAIL": 0,
            "超时FAIL": 0,
            "进行中": 0
        }
        
        for result in data:
            for key in status_counts:
                if result[-1] == key:
                    status_counts[key] += 1

        max_status_len = max(self.estimate_display_width(k) for k in status_counts.keys())
        print("\n" + self.colored("📊 Test Status Summary:", style="bold"))
        print(self.colored("=" * (max_status_len + 18), color="blue"))
        for status, count in status_counts.items():
            percentage = (count / total_cases) * 100
            status_str = self.pad_display(status, max_status_len)
            count_str = f"{count:3d}"
            percent_str = f"({percentage:4.2f}%)"            
            if status=="PASS":
                color="on_green"
            elif status=="通路PASS,CHECK-FAIL":
                color="on_yellow"
            elif status=="超时FAIL":
                color="on_red"
            elif status=="进行中":
                color="on_cyan"
            print(f"{status_str} : "+self.colored(f"{count_str}个",on_color=color,style="bold")+f"{percent_str} ")
        print(self.colored("="*(max_status_len + 20), color="blue"))
        print(self.colored(f"Total test cases: {total_cases}", style="bold"))

        

if __name__ == "__main__":
    regression_statistic_inst = regression_statistic()
    regression_statistic_inst.merge_regression_result()
    regression_statistic_inst.genxlsx()
    regression_statistic_inst.calculate_status_percentage()
    regression_statistic_inst.get_regression_list("/mnt/disk_0/IC/makefile/vrun/regression/regression_json/abnormal.json")