import os
import sys
import time
import json
import glob
import argparse
class toolbox:
    def cfg_args(self):
        parser=argparse.ArgumentParser(description="toolbox")
        parser.add_argument("-j",metavar="",help="input json path")
        parser.add_argument("-t",metavar="",help="test_name for single run")
        parser.add_argument("-only_run",action="store_true",help="dont compile ,only run using existed build files",default="False")
        parser.add_argument("-simdir",metavar="",help="simulation dir",default=None)
        parser.add_argument("-top",metavar="",help="top name")
        
        args=parser.parse_args()
        return args
#-------------------------------------------------------------------------------
    def __init__(self):

        self.args       =self.cfg_args()
        self.json_dict  =None
        self.PROJ_HOME  =""
        self.simdir     =[]
        self.JSON_TESTNAME_KEY="testname"
    
    def get_parent_dir(self,path="./"):
        return os.path.dirname(path)
    def exist_file(self,file_dir,file_name):
        # 检查在某个文件夹下是否存在这个文件
        file_path = os.path.join(file_dir, file_name)
        if os.path.isfile(file_path):
            print(f"file {file_path} exists")
            return True
        else:
            print(f"file: {file_path} not exists")
            return False
    def generate_filelist(self,path,match=(".sv",".v")):
        #recursily check current dir,and create filelist including every dir that include ".sv"
        directories = []

        # 递归遍历目录
        for dirpath, dirnames, filenames in os.walk(path):
            # 检查当前目录是否有 .sv 文件
            if any(file.endswith(match) for file in filenames):
                directories.append(dirpath)

        return directories        
#-------------------------------------------------------------------------------
    def compile(self):
        cur_dir=os.getcwd().split("/")[-1]
        #首先，必须在当前proj的vrun文件夹下运行
        if cur_dir!= "simulation":
            raise ValueError(f"now in {cur_dir},not in simulation dir\n this script shall be run in simulation dir")
        
        if not self.exist_file(os.getcwd(),"makefile"):
            raise ValueError("makefile is not in simulation dir")
        #根据日期或者用户输入的输出目录创建仿真目录
        self.simdir=self.args.simdir if self.args.simdir else self.gettime()
        self.mkdir(self.simdir)
        os.chdir(self.simdir)
        self.mkdir("build")
        make_extra_opt=f"FILE_NAME={self.args.top}" if self.args.top is not None else ""
        os.system(f"make -f ../makefile compile COMPLIE_HOME=build "+make_extra_opt)
        # print(f"make -f ../makefile compile COMPLIE_HOME={self.simdir}")
        


#-------------------------------------------------------------------------------
    def mkdir(self,path):
        if os.path.exists(path):
            pass
        else:
            os.makedirs(path)
    def check_args(self,dict,key,default_value):
        if key not in dict.keys():
            return default_value
        else:
            return dict[key]
    
#-------------------------------------------------------------------------------
    def is_single_path(self,input_path):
        if input_path is None:
            raise ValueError(f"input path:{input_path} is None,input path is required")
        return len(input_path.split())==1
    def get_file_or_path(self,input_path):#input path,return path list
        if not self.is_single_path(input_path):
            return input_path.split()
        elif os.path.isfile(input_path):
            return [input_path]
        elif os.path.isdir(input_path):
            return [file_path for file_path in glob.glob(os.path.join(input_path,"*"))]
        else:
            raise ValueError(f"input path:{input_path} is neither file nor dir")
    def gettime(self):
        time_info=time.strftime("%Y-%m-%d_%H:%M:%S",time.localtime())
        print("{:20} {:10}".format(time_info,"INFO"))
        return time_info

#-------------------------------------------------------------------------------
    def single_run(self,**args):#in simdir exists multiply case_out sub-dir
        #simulatiom
            #simdir(reg_test)
                #case1
                #case2
                #...
        case_dict=self.check_args(args,"case_dict",None)
        if case_dict is not None:
            case_name=case_dict[self.TESTNAME_KEY]
            self.mkdir(case_name)
            os.chdir(case_name)

            os.system("ln -s ../build ./build")
            os.system(f"./build/simv +UVM_TESTNAME={case_name} SEED={1234} -l simulation.log")        
            os.chdir("../")
        else:
            self.mkdir(os.path.basename(self.args.top).split(".")[0])
            os.chdir(os.path.basename(self.args.top).split(".")[0])
            os.system("ln -s ../build ./build")
            os.system(f"./build/simv -l simulation.log")     
            os.chdir("../")

    def print_json(self,json_dict=None):
        if json_dict is None:
            json_dict=self.json_dict
        print(json.dumps(json_dict,indent=4,ensure_ascii=False))

    def extract_json(self,json_path):
        json_file=open(json_path,"r",encoding="utf-8")
        self.json_dict=json.load(json_file)
        self.print_json()

    def run_by_json(self,simdir=None,json_dict=None):
        if json_dict is None:
            json_dict=self.json_dict
        if simdir is None:
            simdir=self.simdir
        for index,tc_dict in enumerate(json_dict["testcase_list"]):
            self.single_run(simdir,tc_dict)

if __name__ =="__main__":
    
    toolbox_inst=toolbox()
    # toolbox_inst.extract_json("tc_list.json")
    
    toolbox_inst.compile()
    toolbox_inst.single_run()
    # toolbox_inst.run_by_json()
    # print(type(toolbox_inst.args.i))
    # print(toolbox_inst.is_single_path(toolbox_inst.args.i))
    # print(toolbox_inst.get_file_or_path(toolbox_inst.args.i))
    # print(toolbox_inst.generate_filelist("../"),(".sv",".v"))