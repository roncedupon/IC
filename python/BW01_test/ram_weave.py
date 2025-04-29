import numpy as np
import argparse
import os
class ram_weave:
    def cfg_args(self):
        parser=argparse.ArgumentParser(description="ram_weave script")
        parser.add_argument("-o",metavar="",default="./output",type=str,help="output dir")
        parser.add_argument("-i",metavar="",default="",type=str,help="original ram data")
        parser.add_argument("-num",metavar="",default=0,type=int,help="ram number")

        # parser.add_argument("-addr",metavar="",default="",type=str,help="original ram data")

        # parser.add_argument("-random",default=False,action="store_true",help="flag to generate random ram data")
        args=parser.parse_args()
        return args
    def mkdir(self,path):
        if os.path.exists(path):
            pass
        else:
            os.makedirs(path)    
    def __init__(self):
        
        self.args           =self.cfg_args()
        self.mkdir(self.args.o)
        self.ram_num        =4
        self.ram_size       =256*1024   #byte
        self.output_width   =128        #bit
        self.output_width_bytes =int(self.output_width/8)
        self.ram_base_addr_list=[
                                0x100000,
                                0x140000,
                                0x180000,
                                0x1c0000            
                            ]
        self.ram_data       =[]
        self.addr_list=self.addr_gen()
        self.depth          =int(self.ram_size/(self.output_width_bytes))
        self.out_file_dir   =self.args.o
        
        for i in range(self.ram_num):
            self.ram_data.append(np.random.randint(0,255,(self.depth,self.output_width_bytes)))
        # self.out_file_path=os.path.join(self.args.o,)
    def use_ram_data(self,ram_data_path=None):
        if ram_data_path==None:
            ram_data_path=self.args.i
        with open(ram_data_path,"r")as f:
            lines=f.readlines
        with open(ram_data_path.split(".")+"_weaved.txt","w")as f:
            pass
    def addr_gen(self,ram_size=None,output_width=None,ram_base_addr_list=None,ram_data=None):
        if ram_size is None:
            ram_size = self.ram_size        
        if output_width is None:
            output_width = self.output_width        
        if ram_data is None:
            ram_data = self.ram_data                    
        if ram_base_addr_list is None:
            ram_base_addr_list = self.ram_base_addr_list        
        addr_step_size=(output_width/8)*len(ram_base_addr_list)
        addr_list=[]
        for j in range(self.ram_num):
            addr_list_tmp=[]
            addr_start=j*(output_width/8)
            for i in range(int(ram_size/(output_width/8))):
                addr=hex(int(addr_start+i*addr_step_size))[2:]                
                addr_list_tmp.append(addr)
            addr_list.append(addr_list_tmp)        
        return addr_list
    def data_gen(self,ram_size=None,output_width=None,ram_base_addr_list=None,ram_data=None):
        if ram_size is None:
            ram_size = self.ram_size        
        if output_width is None:
            output_width = self.output_width        
        if ram_data is None:
            ram_data = self.ram_data                    
        if ram_base_addr_list is None:
            ram_base_addr_list = self.ram_base_addr_list                    
        # ram_size : bytes
        # output_width :bit

        # 先出第一个ram的前16B,然后第二个ram的前16B,...第一个ram的第二批16B,第二个ram第二批16B的以此类推，
        # for i in range(int(ram_size/(output_width/8))):
        #     for j in range(len(ram_base_addr_list)):
        #         print(f"ram{j}_128b")
        addr_step_size=(output_width/8)*len(ram_base_addr_list)
        addr_list=[]        
        for j in range(self.ram_num):
            with open(os.path.join(self.out_file_dir,f"ram_{j}.txt"),"w")as f:
                for i in range(int(ram_size/(output_width/8))):
                    addr=self.addr_list[j][i]
                    data_str="".join([format(item,'02x') for item in ram_data[j][i]])
                    f.write(f"@{addr} {data_str}\n")
                    addr_list.append(addr)
        return addr_list
    def main(self):
        # with open(self.out_file_path)
        out_file_path=os.path.join(self.args.o,"initial_data.txt")

        print(out_file_path)
        self.data_gen()

if __name__=="__main__":
    ram_weave_inst=ram_weave()
    ram_weave_inst.main()