import os
import sys
import time
import json
import glob
import re
import argparse
from datetime import datetime, date, time, timedelta


from toolbox import toolbox
# from VCSLogAnalyzer import VCSLogAnalyzer
class vrun(toolbox):
    def cfg_args(self):
        parser=argparse.ArgumentParser(description="toolbox")
        parser.add_argument("-j",metavar="",help="input json path")
        
        parser.add_argument("-t",metavar="",help="uvm test_name for single run",default=None)
        parser.add_argument("-only_run",action="store_true",help="dont compile ,only run using existed build files",default=False)
        parser.add_argument("-c",action="store_true",help="this is a c file,need to use gcc compiler",default=False)
        parser.add_argument("-only_compile",action="store_true",help="dont run,only compile",default=False)
        parser.add_argument("-comp_opts",metavar="",type=str,default="")
        parser.add_argument("-simdir",metavar="",help="simulation dir",default=str(date.today()))
        parser.add_argument("-seed",metavar="",help="simulation dir",default=123)
        parser.add_argument("-top",metavar="",help="top name",default=None)
        parser.add_argument("-uvm",action="store_true",help="UVM_FLAG",default=True)
        parser.add_argument("-verdi",action="store_true",help="UVM_FLAG",default=False)
        parser.add_argument("-dir",type=str,help="dir for verdi or something",default=None)
        parser.add_argument('-check',action="store_true",help="check regr result",default=False)        
        parser.add_argument("-f",metavar="",help="filelist",default=None)
        
        
        parser.add_argument("-gen",action="store_true",help="generate uvm file flag",default=False)
        parser.add_argument("-extra",metavar="",nargs="+",help="generate uvm_component,[component,object]",default=[])
        

        # parser.add_argument("-sim_opts",metavar="",help="filelist",default=False)
        args=parser.parse_args()
        # if len(args.t)==1:
        #     args.t=args.t[0]
        if args.dir is not None:
            if os.path.isfile(args.dir):
                args.dir=os.path.abspath(os.path.dirname(args.dir))
                print("Specified dir is "+args.dir)
            else:
                args.dir=os.path.abspath(args.dir)
                print("Specified dir is "+args.dir)
        return args
#-------------------------------------------------------------------------------
    def __init__(self):

        self.args       =self.cfg_args()
        self.script_path=os.path.dirname(os.path.abspath(__file__))
        self.script_dir=os.path.dirname(self.script_path)
        self.json_dict  =None
        self.CUR_PROJ_HOME  =os.getcwd()#current proj home
        self.report_name   = "regresssion_report.txt"
        self.simdir=self.CUR_PROJ_HOME+"/"+"simulation"+"/"+self.args.simdir if self.args.simdir else "simulation"+"/"+self.gettime()
        if self.args.check:
            self.simdir=os.path.abspath(self.args.simdir)
        self.JSON_TESTNAME_KEY="testname"

        self.MAKEFILE_PATH=os.path.dirname(__file__)+"/makefile"
        self.VCS_COMPILE_OPTIONS=f" +incdir+{self.CUR_PROJ_HOME} "
        
    def launch_verdi_old(self):
        font_cfg='-font "Courier 18"'
        VERDI_HOME=self.simdir+"/verdi"
        
        self.mkdir(VERDI_HOME)
        os.chdir(VERDI_HOME)
        case_dir=self.args.top.split(".")[0] if self.args.top is not None else self.args.t
        print("VERDI WORK HOME is ",VERDI_HOME)
        VERDI_CMD=f"verdi -ssf ../{case_dir}/waves.fsdb  -dbdir ../{case_dir}/build/simv.daidir/ -rcFile {self.script_path}/novas.rc"
        if dir !=None:
            os.chdir(self.args.dir)
            fsdb_file_name="wave.fsdb" if os.path.exists("wave.fsdb") else os.path.basename(self.args.dir)+".fsdb"
            VERDI_CMD=f"cd {self.args.dir}  && verdi -dbdir ./simv.daidir/ -ssf {fsdb_file_name} -rcFile {self.script_path}/novas.rc"
        print(VERDI_CMD)
        os.system(VERDI_CMD+" &")
        sys.exit()
    def launch_verdi(self):
        
        os.chdir(self.args.dir)
        print(os.getcwd())
        fsdb_file_name="waves.fsdb" if os.path.exists("waves.fsdb") else os.path.basename(self.args.dir)+".fsdb"
        if self.args.dir !=None:
            verdi_cmd=f"cd {self.args.dir}/../ && verdi -dbdir {self.args.dir}/simv.daidir/ -ssf {self.args.dir}/{fsdb_file_name} "
            if False:
                print(verdi_cmd)
            else:
                os.system(verdi_cmd)
        # else:
        #     print(f"cd {BW01D_HOME}/soc_verif/sim/{simdir}/{testcase_name}{self.args.seed} && verdi -dbdir ./simv.daidir/ -ssf {fsdb_file_name}")
        #     os.system(f"cd {BW01D_HOME}/soc_verif/sim/{simdir}/{testcase_name}{self.args.seed} && verdi -dbdir ./simv.                
    
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
        make_extra_opt+=f"FILE_LIST={self.CUR_PROJ_HOME}/{self.args.f} " if self.args.f else "FILE_LIST= "

        
        make_extra_opt+=f"CUR_PROJ_HOME={self.CUR_PROJ_HOME} "
        COMPILE_HOME    =self.simdir+"/"+"build"
        make_extra_opt+=f"COMPILE_HOME={COMPILE_HOME} "
        UVM_FLAG        =1 if self.args.uvm else 0
        make_extra_opt+=f"UVM_FLAG={UVM_FLAG} "
        make_extra_opt+=f"VCS_COMPILE_OPTIONS=\"{self.VCS_COMPILE_OPTIONS} {self.args.comp_opts}\""
        
        print(make_extra_opt)
        
        make_cmd=f"make -f {self.MAKEFILE_PATH} compile "+make_extra_opt



        print(make_cmd)
        os.system(make_cmd)
        # print(f"make -f ../makefile compile COMPLIE_HOME={self.simdir}")

        self.compile_check()
        
    def compile_check(self):
        log_file_path = "./build/compile.log"
        # analyzer = VCSLogAnalyzer(log_file_path)
        # analyzer.extract_vcs_command()
        # analyzer.parse_vcs_command()
        # analyzer.parse_compile_log()
        # analyzer.generate_excel_report()#现在先不生成这玩意

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
        extra_sim_opt=f"+ntb_random_seed={self.args.seed}"#加入一个默认的seed参数
        case_dict=self.check_args(args,"case_dict",None)
        if case_dict is not None:
            case_name=case_dict[self.TESTNAME_KEY]
            self.mkdir(case_name)
            os.chdir(case_name)
            if not os.path.exists("build"):
                os.system("ln -s ../build ./")
            os.system("ln -s ../build/simv.daidir ./")
            os.system(f"./build/simv +UVM_TESTNAME={case_name} SEED={1234} -l simulation.log")        
            os.chdir("../")
        else:
            if self.args.t  !=None:
                self.mkdir(self.args.t)
                os.chdir(self.args.t)
                extra_sim_opt+=f" +UVM_TESTNAME={self.args.t}"
            else:
                if self.args.top !=None:
                    self.mkdir(os.path.basename(self.args.top).split(".")[0])
                    os.chdir(os.path.basename(self.args.top).split(".")[0])
                else:
                    self.mkdir("tb_top")
                    os.chdir("tb_top")
            if not os.path.exists("build"):
                os.system("ln -s ../build ./")
            os.system("ln -s ../build/simv.daidir ./")
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
        if self.args.check:
            self.result_check()
            sys.exit()
        self.env_init()
        if self.args.c:
            if self.args.top !="":
                print(self.colored("USE -t TO RUN C","black","on_red"))
                print(self.args.top)
            
            file_path   =os.path.abspath(self.args.t)
            PROGRAM_NAME=self.args.t.split(".")[0]
            output_dir  =os.path.dirname(file_path)+"/c_output"

            self.mkdir(output_dir)
            os.chdir(output_dir)
            print(f"gcc {file_path} -o {PROGRAM_NAME} && ./{PROGRAM_NAME}")
            os.system(f"gcc {file_path} -o {PROGRAM_NAME} && ./{PROGRAM_NAME}")
            print(os.getcwd())
            sys.exit()
        
        if self.args.verdi:
            self.launch_verdi()
            sys.exit()
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
            sys.exit()
        self.mkdir(self.simdir)
        if not self.args.only_run:
            self.simdir=self.CUR_PROJ_HOME+"/"+"simulation"+"/"+self.args.simdir if self.args.simdir else "simulation"+"/"+self.gettime()
            self.compile()
        if not self.args.only_compile:
            self.single_run()

    def creat_test_from_seq(self):
        #用指定的sequence批量创建test
        pass
    def fsdb_adder(self):
        #used to insert fsdb dump operation
        waves_sv_txt="""
        `define WAVES_FSDB
        `ifdef WAVES_FSDB
            initial begin
                $fsdbDumpfile($sformatf("waves.fsdb"));
                $fsdbDumpvars("+all");
                $fsdbDumpSVA();
                $fsdbDumpMDA(0,$sformatf("%m"));
            end
        `elsif WAVES_VCD
            initial begin
                $dumpvars;
            end
        `elsif WAVES
            initial begin
                $vcdpluson;
            end
        `endif
        """
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
    def print_tc_status(self,fname,num,name,seed,status,common,**args):
        # post_check_result=args["post_check_result"]
        status_f = open(fname,"a+")
        status_f.write("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n")
        print('|{:<10}{:<90}|sim_{:<14}|post_{:<14}' .format(num,name,status,"Null"), file = status_f)
        status_f.close()
    def result_check(self):
        #  if self.is_error_waves_dumped:
        #     return
        if os.path.exists(self.report_name) :
            os.remove(self.report_name)
            #  self.gen_rl_report(self.report_name) 
        
        os.chdir(self.simdir) 

        file_dir_post = []#all testcase dir
        sub_file_pre = []#all sub-dir of current sim dir
        sub_file_post = []
        error_tc_list=[]

        all_tc_num = 0
        all_pass_num = 0
        all_fail_num = 0
        all_unknown_num = 0
        all_warning_fail_num=0
        tc_num = 0         
        file_dir_pre = os.listdir(self.simdir)
        # print(file_dir_pre)
        for i in range(0, len(file_dir_pre)) :
            if "test" in file_dir_pre[i] and os.path.isdir(self.simdir+"/"+file_dir_pre[i]):
                if self.args.check:
                    if "reRun"not in file_dir_pre[i] :
                        file_dir_post.append(file_dir_pre[i])                        
                else:
                    if "reRun"not in file_dir_pre[i] :
                        file_dir_post.append(file_dir_pre[i])  #TODO                   
        error_count=0
        fatal_count=0                        
        for i in range(0, len(file_dir_post)) :
            # post_check_result=self.post_check(file_dir_post[i],False)
            # os.chdir("../")
            #   print(os.getcwd())
            os.chdir(file_dir_post[i])
            
            sub_file_pre = []
            sub_file_post = []
            file_dir_pre = os.listdir("./")
            tc_res = "timeout"
            for j in range(0, len(file_dir_pre)) :
                if "test" in file_dir_pre[j] :
                        sub_file_pre.append(file_dir_pre[j])
            for j in range(0, len(sub_file_pre)) :
                if "log" in sub_file_pre[j] and "swp" not in sub_file_pre[j] :
                        sub_file_post.append(sub_file_pre[j])
            for j in range(0, len(sub_file_post)) :              
                tc_num = tc_num + 1
                tmp = open("./" + sub_file_post[j],"r", encoding='utf-8', errors='ignore')
                # tmp_list = tmp.readlines()
                ALL_LINES=tmp.read() 
            #    for line in tmp_list:
                error_match=re.search(r"UVM_ERROR :.*?(\d+)",ALL_LINES)
                fatal_match=re.search(r"UVM_FATAL :.*?(\d+)",ALL_LINES)
                if re.findall(r"\$finish at simulation time",ALL_LINES):
                        if error_match:
                            error_count=int(error_match.group(1))
                        if fatal_match:
                            fatal_count=int(fatal_match.group(1))                        
                        if error_count==0 and fatal_count==0:
                            tc_res = "passed"
                            # break
                        elif fatal_count==0:# re.findall("SIMULATION RESULT: FAILED",line) or re.findall("$finish called from file",line) \
                            tc_res = "failed"      
                else:
                    with open("/scratch2/BW01_Proj_Digital/yao.dai/bw01d_top/soc_verif/testlist/bw01d/soc_run_cim.lst","r")as regr_lst:
                        lines=regr_lst.readlines()
                        for i,line in enumerate(lines):
                            if line.startswith("@") and sub_file_post[j].split("test")[0]+"test" in lines[i+1]:
                                print(lines[i].strip())
                                print(lines[i+1])
                                i+=1
                if tc_res == "passed":
                    all_pass_num += 1
                    #    error_tc_list.append(file_dir_post[i])
                elif tc_res == "failed":
                    all_fail_num += 1
                    #    error_tc_list.append(file_dir_post[i])
                elif tc_res == "warning_failed":
                    all_warning_fail_num += 1
                elif tc_res == "timeout":
                    all_unknown_num += 1
                    # print(f"@seed=[501:501]\n{case_name}_@seed +dir=bw01d/flash_die/cpu +UVM_TESTNAME={case_name}")
                    #    error_tc_list.append(file_dir_post[i])
                self.print_tc_status(self.simdir+"/"+self.report_name, tc_num, './' + file_dir_post[i].split('.')[0] + '/' + sub_file_post[j], "", tc_res, "")
            os.chdir(self.simdir)
        all_tc_num = all_pass_num + all_fail_num + all_unknown_num+all_warning_fail_num

        all_pass_precent    =round(all_pass_num/all_tc_num*100,2) if all_tc_num!=0 else 0
        all_failed_precent  =round(all_fail_num/all_tc_num*100,2) if all_tc_num!=0 else 0
        all_unknown_precent =round(all_unknown_num/all_tc_num*100,2) if all_tc_num!=0 else 0        
        all_warning_precent =round(all_warning_fail_num/all_tc_num*100,2) if all_tc_num!=0 else 0
        lineformat="{:<40} {:>10}"
        print("=====================================================================================================================\n")    
        print("                                The results of regression test are as follows.\n")
        print("---------------------------------------------------------------------------------------------------------------------")
        print(f"\033[1;32m\t\t                    passed testcase num({all_pass_precent}%): " +str(all_pass_num)    + "\033[0m"                          )
        print(f"\033[1;33m\t\t                    failed testcase num({all_failed_precent}%): " + str(all_fail_num)    +  "\033[0m"                         )
        print(f"\033[1;31m\t\t                   warning testcase num({all_warning_precent}%): " + str(all_warning_fail_num)    +  "\033[0m"                 )
        print(f"\033[1;36m\t\t                   timeout testcase num({all_unknown_precent}%): " + str(all_unknown_num) + "\033[0m"                          )
        print("                                     all testcase num : " + str(all_tc_num)                                           )
        print("---------------------------------------------------------------------------------------------------------------------")
        print("=====================================================================================================================")

if __name__ =="__main__":
    
    toolbox_inst=vrun()
    # toolbox_inst.extract_json("tc_list.json")
    
    toolbox_inst.vrun_main()

    # toolbox_inst.run_by_json()
    # print(type(toolbox_inst.args.i))
    # print(toolbox_inst.is_single_path(toolbox_inst.args.i))
    # print(toolbox_inst.get_file_or_path(toolbox_inst.args.i))
    # print(toolbox_inst.generate_filelist("../"),(".sv",".v"))

#%%