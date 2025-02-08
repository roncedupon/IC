import numpy as np
import math
x=np.arange(3328)

y=np.arange(3408)
redunant_col=np.arange(24).tolist()+np.arange(1704,1728).tolist()
redunant_col=np.array(redunant_col)

r_vector=x%280
q_vector=x//280

r0_vector=r_vector%16
q0_vector=r_vector//16

r1_vector=r0_vector%4
q1_vector=r0_vector//4


r2_vector  =x%8
q2_vector  =r2_vector//2
p_vector   =x%2

y=np.zeros((1,3408))
for i in range(x.shape[0]):
    if i==3327:
        pass
    q   = q_vector[i]
    q0  =q0_vector[i]
    q1  =q1_vector[i]
    q2  =q2_vector[i]

    r   = r_vector[i]
    r0  =r0_vector[i]
    r1  =r1_vector[i]
    r2  =r2_vector[i]
    p   =p_vector[i]
    if q0<17:

        if q1==0:
            y[0,24*(r1+1)+96*q0+2*q]=i
            print(f"{x[i]}--->{y}")
        elif q1==1:
            y[0,1704+24*(r1+1)+96*q0+2*q]=i
            print(f"{x[i]}--->{y}")
        elif q1==2:
            y[0,24*(r1+1)+1+96*q0+2*q]=i
            print(f"{x[i]}--->{y}")
        elif q1==3:
            y[0,1704+24*(r1+1)+1+96*q0+2*q]=i
            print(f"{x[i]}--->{y}")
        else:
            print("ERROR")        

    elif q0==17:
        
        if q2==0:
            y[0,24*(p+1)+96*q0+2*q]=i
            print(f"{x[i]}--->{y}")
        elif q2==1:
            y[0,1704+24*(p+1)+96*q0+2*q]=i
        elif q2==2:
           y[0,24*(p+1)+1+96*q0+2*q]=i
           print(f"{x[i]}--->{y}")
        elif q2==3:
            y[0,1704+24*(p+1)+1+96*q0+2*q]=i
            print(f"{x[i]}--->{y}")
        else:
            print("ERROR")
    else:
        print("hh")
with open("y_data.txt","w")as file:
    for i in range(y.shape[1]):
        file.write(str(int(y[0,i]))+"\n")
