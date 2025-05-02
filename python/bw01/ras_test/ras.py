import numpy as np
class ras:
    def __init__(self):
        self.ras_col=16
        self.array_row=4096
        self.g=np.random.randint(1,3,(1,256))
        self.scale=None
        self.ras=np.zeros((self.array_row,self.ras_col))
        
        
    def calculate_ras(self,weight_matrix):
        parts = np.hsplit(weight_matrix, self.ras_col)#return a list with length=ras_col 
        for col_index,item in enumerate(parts):
            print((item/self.g).sum(axis=1))
            self.ras[:,col_index]=item.sum(axis=1)
            
    def int8_quantize(self,ras=None):
        if ras==None:
            ras=self.ras
        scale=np.clip(np.abs(ras).max(axis=0)/127,1e-6,None)
        self.scale=2**np.round(np.log2(scale))
        ras=np.round(ras/scale)
        return ras

    def dequantize(self,ras_quanted):
        #ras整列求和
        SR=(ras_quanted.sum(axis=0))*self.scale

        return SR

if __name__=="__main__":
    ras_inst=ras()
    weight_matrix=np.random.randint(0,256,(4096,4096))
    ras_inst.calculate_ras(weight_matrix)
    ras_inst.int8_quantize()
    SR=ras_inst.dequantize(ras_inst.int8_quantize())
    
    exit()
    weight_matrix=np.arange(32*16).reshape(32,16)
    print(weight_matrix)
    print("="*10)
    
    print(weight_matrix.reshape(-1,32,4,order="C"))

#%%
import numpy as np

# 创建一个 32x16 的矩阵（随机示例）
matrix = np.arange(32 * 16).reshape(32, 16)

# 方法一：使用 np.hsplit()
parts = np.hsplit(matrix, 4)  

#%%
import numpy as np
a=np.array([1,2,3])
b=np.array([2,3,4])
print(a/b)