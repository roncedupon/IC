import numpy as np
s_mem=np.arange(3360).reshape(-1,1)[0::2]
mid_matrix=s_mem.reshape(12,-1,order="F")[2:,:]
print(mid_matrix)