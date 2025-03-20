#加载SoftMax数据
from funs.base_transform import *
from funs.load_pkl import *
from funs.generate_txt import*
Pkl_Name="SoftMax_In.pkl"
pkl=load_pkl(Pkl_Name)
print(pkl)
SoftMax_In=pkl[0]#读取输入的数据[1,6,197,197]
Scale_In=pkl[1]
# print(SoftMax_In,Scale_In)

Xq=torch.cat((SoftMax_In[0][0],torch.zeros(197,3)),dim=1)
flattened_data=Xq.flatten()
#197列数据，补零成200列
# generate_txt(flattened_data,flattened_data.shape[0],"SoftMax_In.txt")
#生成txt
ln2=0.6931
#先减最大值
Xq_Max,_=Xq.max(dim=-1,keepdim=True)
Xq=Xq-Xq_Max
Scale1=torch.floor((-1*Scale_In/ln2)*pow(2,16))
Z=torch.floor(Xq*Scale1/pow(2,16))
Z2=torch.floor(Xq/(torch.floor(-1*ln2/Scale_In)))#论文代码处理方法，可能精度丢了一点点
print(Z)

Scale2=torch.floor(ln2/Scale_In*-1)
P=Xq-Z*Scale2
print("Scale1的值是:",dec2hex(Scale1,16))
print("Scale2的值是:",Scale2)
print("P的值是",P)
# print(Z2)