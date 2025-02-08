import os
import sys
import time
import json
import glob
import re
import argparse
from VCSLogAnalyzer import VCSLogAnalyzer
class toolbox:
    def cfg_args(self):
        parser=argparse.ArgumentParser(description="toolbox")
        parser.add_argument("-j",metavar="",help="input json path")
        parser.add_argument("-t",metavar="",help="uvm test_name for single run")
        parser.add_argument("-only_run",action="store_true",help="dont compile ,only run using existed build files",default=False)
        parser.add_argument("-only_compile",action="store_true",help="dont run,only compile",default=False)
        parser.add_argument("-simdir",metavar="",help="simulation dir",default="tb_top")
        parser.add_argument("-top",metavar="",help="top name",default=None)
        parser.add_argument("-uvm",action="store_true",help="UVM_FLAG",default=False)
        parser.add_argument("-f",metavar="",help="filelist",default=None)
        
        parser.add_argument("-gen",action="store_true",help="generate uvm file flag",default=False)
        parser.add_argument("-extra",metavar="",nargs="+",help="generate uvm_component",default=[])
        
        # parser.add_argument("-sim_opts",metavar="",help="filelist",default=False)
        args=parser.parse_args()
        
        return args
#-------------------------------------------------------------------------------
    def __init__(self):

        self.args       =self.cfg_args()
        
        self.script_path=os.path.dirname(os.path.abspath(__file__))
        self.json_dict  =None
        self.CUR_PROJ_HOME  =os.getcwd()#current proj home
        self.simdir=self.CUR_PROJ_HOME+"/"+"simulation"+"/"+self.args.simdir if self.args.simdir else "simulation"+"/"+self.gettime()
        self.mkdir(self.simdir)
        self.JSON_TESTNAME_KEY="testname"

        self.MAKEFILE_PATH="$PROJ_HOME/makefile/vrun/makefile"
        self.VCS_COMPILE_OPTIONS=""
        self.env_init()
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
    def env_init(self):
        os.environ['CUR_PROJ_HOME'] = self.CUR_PROJ_HOME
        if self.exist_file(self.CUR_PROJ_HOME,"compile_opts"):
            with open("compile_opts","r")as f:
                for line in f.readlines():
                    self.VCS_COMPILE_OPTIONS+=line
            
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
        # if not self.exist_file(os.getcwd(),"makefile"):
        #     raise ValueError("makefile is not in simulation dir")
        #根据日期或者用户输入的输出目录创建仿真目录
        
        
        os.chdir(self.simdir)
        self.mkdir("build")
        
        make_extra_opt=f"CUR_PROJ_HOME={self.CUR_PROJ_HOME} "
        make_extra_opt+=f"FILE_NAME={self.CUR_PROJ_HOME}/{self.args.top} " if self.args.top is not None else "FILE_NAME= "
        make_extra_opt+=f"FILE_LIST={self.CUR_PROJ_HOME}/filelist.f " if self.args.f else "FILE_LIST= "
        
        make_extra_opt+=f"CUR_PROJ_HOME={self.CUR_PROJ_HOME} "
        COMPILE_HOME    =self.simdir+"/"+"build"
        make_extra_opt+=f"COMPILE_HOME={COMPILE_HOME} "
        UVM_FLAG        =1 if self.args.uvm else 0
        make_extra_opt+=f"UVM_FLAG={UVM_FLAG} "
        make_extra_opt+=f"VCS_COMPILE_OPTIONS=\"{self.VCS_COMPILE_OPTIONS}\""

        make_cmd=f"make -f {self.MAKEFILE_PATH} compile "+make_extra_opt



        print(make_cmd)
        os.system(make_cmd)
        # print(f"make -f ../makefile compile COMPLIE_HOME={self.simdir}")

        self.compile_check()
        
    def compile_check(self):
        log_file_path = "./build/compile.log"
        analyzer = VCSLogAnalyzer(log_file_path)
        analyzer.extract_vcs_command()
        analyzer.parse_vcs_command()
        analyzer.parse_compile_log()
        analyzer.generate_excel_report()

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
        os.chdir(self.simdir)
        extra_sim_opt=""
        case_dict=self.check_args(args,"case_dict",None)
        if case_dict is not None:
            case_name=case_dict[self.TESTNAME_KEY]
            self.mkdir(case_name)
            os.chdir(case_name)
            if not os.path.exists("build"):
                os.system("ln -s ../build ./")
            os.system(f"./build/simv +UVM_TESTNAME={case_name} SEED={1234} -l simulation.log")        
            os.chdir("../")
        else:
            if self.args.t  !=None:
                self.mkdir(self.args.t)
                os.chdir(self.args.t)
                extra_sim_opt+=f"+UVM_TESTNAME={self.args.t}"
            else:
                if self.args.top !=None:
                    self.mkdir(os.path.basename(self.args.top).split(".")[0])
                    os.chdir(os.path.basename(self.args.top).split(".")[0])
                else:
                    self.mkdir("tb_top")
                    os.chdir("tb_top")
            if not os.path.exists("build"):
                os.system("ln -s ../build ./")
            os.system(f"./build/simv -l simulation.log {extra_sim_opt}")     
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
    def vrun_main(self):
        if self.args.gen:
            
            if "component" in self.args.extra:
                if len(self.args.extra)==2:
                    self.modify_uvm_code_in_file(f"{self.script_path}/template/COMPONENT_TEMPLATE.sv",self.args.extra[1])
                else:
                    print("WARNING:NO COMPONENT NAME PROVIDED!!!")
                    print(self.args.extra)
            if "object" in self.args.extra:
                if len(self.args.extra)==2:
                    self.modify_uvm_code_in_file(f"{self.script_path}/template/OBJECT_TEMPLATE.sv",self.args.extra[1])
                else:
                    print("WARNING:NO OBJECT NAME PROVIDED!!!")
                    print(self.args.extra)
            exit()
        if not self.args.only_run:
            self.compile()
        if not self.args.only_compile:
            self.single_run()

    def modify_uvm_code_in_file(self,input_file, new_name):
        # Read the original code from the input file
        with open(input_file, 'r') as file:
            code = file.read()

        # Replace the <CLASS_NAME> placeholder with the new name
        modified_code = code.replace('<CLASS_NAME>', new_name)

        # Write the modified code to a new file
        
        with open(f"{new_name}.sv", 'w') as file:
            file.write(modified_code)

        print(f"Modified code saved to {new_name}")
if __name__ =="__main__":
    
    toolbox_inst=toolbox()
    # toolbox_inst.extract_json("tc_list.json")
    
    toolbox_inst.vrun_main()

    # toolbox_inst.run_by_json()
    # print(type(toolbox_inst.args.i))
    # print(toolbox_inst.is_single_path(toolbox_inst.args.i))
    # print(toolbox_inst.get_file_or_path(toolbox_inst.args.i))
    # print(toolbox_inst.generate_filelist("../"),(".sv",".v"))
