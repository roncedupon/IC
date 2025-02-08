#%%
import numpy as np
def row_transform_v1_4(s_mem):
    mapper      =np.arange(1680).reshape(12,-1,order="F")
    mapper_front=mapper[:,:138].reshape((-1,1),order="F").squeeze()
    mapper_tail0=mapper[:8,-2]
    mapper_tail1=mapper[:2,-1]

    
    mapper      =np.hstack((mapper_front,mapper_tail0))
    mapper      =np.hstack((mapper,mapper_tail1))
    print(mapper)
    final_matrix=s_mem[mapper]
    print(mapper_front.shape)
    return final_matrix
    
row_transform_v1_4(np.random.randint(0,255,(1680,3328)))

#%%
import numpy as np
AA=np.arange(9).reshape((3,3),order="C")
mapper=np.array([0,2])
print(AA[mapper])