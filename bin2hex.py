import json
import numpy as np
import os

class bin2hex:
    # 打开二进制文件
    def __init__(self,map_bin_path=None,**args):
        if map_bin_path is None:
            self.map_bin_path="./map.bin"
        else:
            self.map_bin_path=map_bin_path

        self.output_path=self.check_args(args,"output_path","./output")

        #默认值控制，以防weight和bias的尺寸需要被修改
        self.out_col=self.check_args(args,"out_col",3840)
        self.out_row=self.check_args(args,"out_row",3840)
        self.bias_row=self.check_args(args,"bias_row",32)

        self.json_dict=[]
        self.json_length=0
        self.weight_bias_base_addr=0
        self.parse_map_bin(self.map_bin_path)
        
    def check_args(self,dict,key,default_value):
        if key not in dict.keys():
            return default_value
        else:
            return dict[key]
    
    def parse_map_bin(self,map_bin_path):
        #输入map.bin的路径，然后提取前4字节，从地址8开始，按前4字节表示的数据量读取mao.bin存储的json文件，按ascll读取，然后转为json字典
        with open(map_bin_path, 'rb') as file:
            
            pre_8_bytes = file.read(8)
            self.json_length = int.from_bytes(pre_8_bytes[0:4], byteorder='little')  
            self.weight_bias_base_length=int.from_bytes(pre_8_bytes[4:8], byteorder='little')

            # 将文件指针移动到第9字节位置
            file.seek(8)  # seek 是0基索引，第9字节为索引8

            # 从第9字节位置读取 json_data_length 长度的数据
            data_bytes = file.read(self.json_length)
            json_str = ''.join(chr(byte) for byte in data_bytes)#返回的是一个json的字符串
            print(json_str)

            self.json_dict=json.loads(json_str)
            self.weight_bias_base_addr=8+self.json_length


    def get_weight_bias(self,layers_dict=None,base_addr=None):
        #按照json中的信息提取weight和bias数据
        if layers_dict is None:
            layers_dict=self.json_dict["layers"][0]
        if base_addr is None:
            base_addr=self.weight_bias_base_addr
        
        #step1，先提取weight
        weight_data_bytes=[]
        bias_data_bytes=[]

        with open(self.map_bin_path, 'rb') as file:
            file.seek(layers_dict["weight_data_offset"]+base_addr)
            weight_data_bytes=file.read(layers_dict["weight_data_size"])
            file.seek(layers_dict["bias_data_offset"]+base_addr)
            bias_data_bytes=file.read(layers_dict["bias_data_size"])

        # step2,再将提取到的weight，bias转换成矩阵
        weight_matrix,bias_matrix=self.convert_weight_bias_to_matrix(weight_data_bytes,bias_data_bytes,
                                           layers_dict["xs"],layers_dict["xe"],
                                           layers_dict["ys"],layers_dict["ye"],
                                           layers_dict["bias_ys"],layers_dict["bias_ye"]
                                           )
        #step3,输出weight&bias
        self.output_weight_bias(weight_matrix,bias_matrix, 
                                layers_dict["xs"],layers_dict["xe"],
                                layers_dict["ys"],layers_dict["ye"],
                                layers_dict["bias_ys"],layers_dict["bias_ye"])

   
    
    def convert_weight_bias_to_matrix(self,weight_data_bytes,bias_data_bytes,xs,xe,ys,ye,bias_ys,bias_ye):
        weight_matrix=np.frombuffer(weight_data_bytes,dtype=np.uint8).reshape(xe-xs+1,ye-ys+1)#按小端格式读取
        bias_matrix=np.frombuffer(bias_data_bytes,dtype=np.uint16).reshape(xe-xs+1,bias_ye-bias_ys+1)
        return weight_matrix,bias_matrix
    
    def output_weight_bias(self,weight_matrix,bias_matrix,xs,xe,ys,ye,bias_ys,bias_ye):
        #step3,将weight放在out_row*out_col的大矩阵中输出
        weight=np.zeros((self.out_row,self.out_col),dtype=np.uint8)
        bias=np.zeros((self.bias_row,self.out_col),dtype=np.uint8)

        weight[xs:xe+1,ys:ye+1]=weight_matrix
        bias[xs:xe+1,bias_ys:bias_ye+1]=bias_matrix

        self.generate_hex(np.fliplr(np.vstack((weight,bias))))
        
        print("end")
        
    def generate_hex(self,np_matrix):
        # 将数据按8位格式写入txt文件
        self.mkdir(self.output_path)
        out_file_name=os.path.basename(self.map_bin_path).split(".")[0]+".hex"
        with open(self.output_path+"/"+out_file_name, 'w') as f:
            for row in np_matrix:
                # 将每个元素按8位格式写入文件，以空格分隔
                f.write(''.join(format(x, '02x') for x in row) + '\n')
    
    def mkdir(self,path):
        if os.path.exists(path):
            pass
        else:
            os.makedirs(path)



if __name__=="__main__":
    bin2hex_inst=bin2hex("/home/dy/IC/C++/GEMV0/map.bin",output_path="./outputtt")
    print(bin2hex_inst.parse_map_bin("/home/dy/IC/C++/GEMV0/map.bin"))
    bin2hex_inst.get_weight_bias()