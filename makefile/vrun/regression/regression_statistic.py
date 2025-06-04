import openpyxl
import os
import sys
import json
from instrlist import *
THIS_FILE_PATH  = os.path.abspath(__file__)
THIS_FILE_DIR   = os.path.dirname(THIS_FILE_PATH)#dirname will return abs path
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

        self.json_dict={}
        self.testlist_all=[]
        self.USE_JSON_ORDER=True#用自定义的testlist顺序还是用json中的顺序
        self.JSON_LIST_PATH="./regression_json"
        self.REGRESSION_RESULT_DIR_PATTERN=r"regression_2025[0-9]+"
        self.STATUS_DICT = {
            "sim_failed": "通路PASS, CHECK-FAIL",
            "sim_passed": "PASS",
            "sim_timeout": "超时FAIL",
            "running": "进行中"            
        }

        self.fixed_order = {}
        self.newcase = []

        # print(self.fixed_order)
        if self.USE_JSON_ORDER:
            for i in range(len(self.get_regression_list(self.JSON_LIST_PATH))):
                self.fixed_order[i] = instrlist[i]
        else:
            for i in range(len(instrlist)):
                self.fixed_order[i] = instrlist[i]            
    def get_regression_list(self,json_list_path):#1、create testlist_all #2、create json_dict by testname
        if os.path.isfile(json_list_path):
            with open(json_list_path,"r")as f:
                json_str=f.read()
                self.testlist_all+=[list["testname"] for list in json.loads(json_str)["testcase list"]]
        else:
            for path in os.listdir(json_list_path):
                ABS_PATH=os.path.join(os.path.abspath(json_list_path),path)
                with open(ABS_PATH,"r")as f:
                    json_str=f.read()
                    self.testlist_all+=[list["testname"] for list in json.loads(json_str)["testcase list"]]
        if len(self.testlist_all)!=len(set(self.testlist_all)):
            seen=set()
            for i in self.testlist_all:
                if i in seen:
                    print(self.colored(f"repeated case detected : {i}",style="bold",on_color="on_black",color="yellow"))
                seen.add(i)
        return set(self.testlist_all)

    def mkdir(self, path):
        if not os.path.exists(path):
            os.makedirs(path)
    def update_history_status(self,regression_status_path):
        if regression_status_path is None:
            regression_status_path=THIS_FILE_DIR
        for dir in os.listdir(regression_status_path):
            regex = re.compile(self.REGRESSION_RESULT_DIR_PATTERN)
            if regex.search(dir):
                print(dir)
        #如果这个case昨天还在里面但是今天不在里面了，应该被认为是删除了或者改名了的case，这部分还需要额外处理一下
        #如果使用的testlist.json比较旧，新增加的case需要自动补充到已知case列表中
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
            if line.startswith('|'):
                parts = line.strip().split('|')
                if len(parts) > 2:
                    case_name = "_".join((parts[1].split(".")[1].split("/")[-1]).split("_")[0:-2])
                    case_status = self.STATUS_DICT[parts[2].strip().split('(')[0]]

                    newcase_flag = True
                    for order, name in fixed_order.items():
                        if name == case_name and name not in existing_fixed_cases:
                            data.append([order, name, case_status])
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
    # regression_statistic_inst.get_regression_list("/mnt/disk_0/IC/makefile/vrun/regression/regression_json")
    print(regression_statistic_inst.testlist_all,len(regression_statistic_inst.testlist_all),len(set(regression_statistic_inst.testlist_all)))
    regression_statistic_inst.update_history_status(None)