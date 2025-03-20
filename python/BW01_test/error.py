x=114
r=x%280
q=x//280

r0=r%16
q0=r//16
print(q0)

# %%
for i in range(16):
    print(str(i%2)+"12345",i//2)
#%%

import numpy as np
with open("/home/dy/IC/python/BW01_test/output.xlsx","rb") as file:
    data_bytes=file.read(4)
AA=np.frombuffer(data_bytes,dtype=np.uint16)
print(len(AA))