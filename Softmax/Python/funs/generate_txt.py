import random
import torch

from funs.base_transform import dec2hex

def generate_txt(flattened_data,size,path="generatedTxt.txt",nums=8):
    #flattened_data 是一个一维数据
    with open(path, 'w') as file:
        for i in range(0,size,nums):
            for j in range(i+nums-1,i-1,-1):
                print(i,j)
                file.write(dec2hex(flattened_data[j],8))
            file.write("\n")
    file.close()



# data=torch.randint(0,10,[16])
# print(data)
# generate_txt(data,16,"data1.txt")

# data = [random.randint(1, 100) for _ in range(16)]
# print(data)
# generate_txt(data,16,"data2.txt")