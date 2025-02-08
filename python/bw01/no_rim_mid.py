'''
    Script for mapping original input addr to DAC logical addr and physical addr
'''
ori_y = input("Input original data addr(range=0~3327): ")
y_sel = input("Input ARRAY_L0_Y_SEL(range=0~7): ")

# odd and even data array
odd_arr = []
even_arr = []
for i in range(0,3360):
    if i%2 == 0:
        even_arr.append(i)
    else:
        odd_arr.append(i)

# odd/even to logic_y
odd_logic_arr = []
even_logic_arr = []
# N*U*P
for i in range(0,120):
    for j in range(0,14):
        odd_logic_arr.append(odd_arr[j*120+i])
        even_logic_arr.append(even_arr[j*120+i])
        if i>103 and j==13:  # invalid 16B
            odd_logic_arr.pop()
            even_logic_arr.pop()

# logic_y arr
logic_y_n = []
logic_y_s = []
for i in odd_logic_arr:
    logic_y_n.append(i)
for i in even_logic_arr:
    logic_y_s.append(i)

# logical addr to physical addr
phy_y_n = []
phy_y_s = []
for i in range(0,1664):
    # physical row 1 ~ 13312
    phy_y_n.append(1+i*8+int(y_sel))
    phy_y_s.append(1+i*8+int(y_sel))

# write ori2logic2physic map file
with open("Ori2Logic2PhysicMap.dat","w") as f:
    f.write("S Part:\n")
    for i in range(len(logic_y_s)):
        f.write("Original Addr: "+str(logic_y_s[i])+"\t\tLogical Addr: "+str(i*2)+"\t\tPhysical Addr: "+str(phy_y_s[i])+"\n")
    f.write("\nN Part:\n")
    for i in range(len(logic_y_n)):
        f.write("Original Addr: "+str(logic_y_n[i])+"\t\tLogical Addr: "+str(i*2+1)+"\t\tPhysical Addr: "+str(phy_y_n[i])+"\n")

# output logic addr according to original addr
for i in range(0,len(logic_y_n)):
    if int(ori_y) == logic_y_n[i]:
        print("Original addr "+ori_y+" is mapping to logical addr "+str(2*i+1)+" in N part")
        print("Logical addr "+str(2*i+1)+" is mapping to physical addr "+str(phy_y_n[i])+" in N part")
for i in range(0,len(logic_y_s)):
    if int(ori_y) == logic_y_s[i]:
        print("Original addr "+ori_y+" is mapping to logic addr "+str(2*i)+" in S part")
        print("Logical addr "+str(2*i)+" is mapping to physical addr "+str(phy_y_s[i])+" in S part")



