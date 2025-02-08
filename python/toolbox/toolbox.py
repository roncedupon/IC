import glob
import os
import argparse
import numpy as np

import csv

def cfg_args():
    parser=argparse.ArgumentParser(description="toolbox")
    parser.add_argument("-i",metavar="",help="input path")
    args=parser.parse_args()
    return args

class toolbox:
    def __init__(self):
        pass#do nothing
    def is_single_path(self,input_path):
        return len(input_path.split())==1
    def check_args(self,args,key,defaule):
        if key not in args.keys():
            return defaule
        else:
            return args[key]
    def get_file_or_path(self,input_path):#input path,return path list

        if not self.is_single_path(input_path):
            return input_path.split()
        elif os.path.isfile(input_path):
            return [input_path]
        elif os.path.isdir(input_path):
            return [file_path for file_path in glob.glob(os.path.join(input_path),"*")]
        else:
            raise ValueError(f"input path:{input_path} is neither file nor dir")
        
    def matrix2txt(self,matrix=None,output_dir=None,output_name=None,opt="w",format="csv",**args):
        test=self.check_args(args,"test",False)
        def matrix2txt_test():
        #simple test:matrix2txt
            toolbox_inst=toolbox()
            toolbox_inst.matrix2txt(np.random.randint(0,255,(3328,3328)),"./","large_matrix.csv")        
        if test:
            matrix2txt_test()
            return
        #-----------------------------------------------------------------------------------------
        # save as csv file
        with open(os.path.join(output_dir,output_name),'w', newline='') as file:
            writer = csv.writer(file)
            for row in matrix:
                writer.writerow(row)
        
    def txt2matrix(self,input_dir,input_name=None,delimiter=","):
        return np.loadtxt(os.path.join(input_dir,input_name),delimiter=",")
        



if __name__ =="__main__":
    args=cfg_args()
    toolbox_inst=toolbox()
    # print(args.i)
    # print(type(args.i))
    # print(toolbox_inst.is_single_path(args.i))
    # print(toolbox_inst.get_file_or_path(args.i))
#-------------------------------------------------------
    toolbox_inst.matrix2txt(test=True)
    toolbox_inst.txt2matrix("./","large_matrix.csv")