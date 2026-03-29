#%%
import numpy as np

arr = np.array([1, 2, 3, 4, 5, 6,7,8])

# 每两个元素一组，重塑形状
new_arr = arr.reshape(-1, 2)

print(new_arr)
print(new_arr[0])
#%%
print(new_arr)
print("-----------")
print(new_arr[0::2])
print("-----------")
print(new_arr[1::2])

even_col=new_arr[0::2].flatten()
odd_col =new_arr[1::2].flatten()
print(even_col)
print(odd_col)

#%%
s_mem=np.arange(0,pow(10,2)).reshape(10,10)
result_even = np.array([row.reshape(-1, 2)[0::2].flatten() for row in s_mem])
result_odd  = np.array([row.reshape(-1, 2)[1::2].flatten() for row in s_mem])

result_even = np.array([np.flip(row.reshape(-1, 2)[0::2],axis=0) for row in s_mem])
print(result_even)
print("-----------")
print(result_odd)


#%% 
aa="123"
print(int(aa)-100)


#%%
bit="0111001110010110"
# bit="011100000001"
bit=bit[::-1]
index=0
for i in range(len(bit)):
    if bit[i]=="1":
        print(hex(index),hex(index+1),hex(index+2),hex(index+3))
    index+=4
        
# %%

0x8 0x9 


