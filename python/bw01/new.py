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

# split rim and mid
odd_rim_arr = []
odd_mid_arr = []
even_rim_arr = []
even_mid_arr = []
for i in range(0,140):
    for j in range(0,2): # rim data
        odd_rim_arr.append(odd_arr[i*12+j])
        even_rim_arr.append(even_arr[i*12+j])
    for j in range(0,10): # mid data
        odd_mid_arr.append(odd_arr[i*12+j+2])
        even_mid_arr.append(even_arr[i*12+j+2])

# rim to logic_y
odd_rim_logic_arr = []
even_rim_logic_arr = []
# N1*u1*p1
for i in range(0,20): 
    for j in range(0,14):
        odd_rim_logic_arr.append(odd_rim_arr[j*20+i])
        even_rim_logic_arr.append(even_rim_arr[j*20+i])
        if i>17 and j==13:  # invalid 2B
            odd_rim_logic_arr.pop()
            even_rim_logic_arr.pop()

# mid to logic_y
odd_mid_logic_arr = []
even_mid_logic_arr = []
# N2*u2*p2
for i in range(0,100):
    for j in range(0,14):
        odd_mid_logic_arr.append(odd_mid_arr[j*100+i])
        even_mid_logic_arr.append(even_mid_arr[j*100+i])
        if i>85 and j==13:  # invalid 16B
            odd_mid_logic_arr.pop()
            even_mid_logic_arr.pop()

# logic_y arr
logic_y_n = []
logic_y_s = []
for i in odd_rim_logic_arr:
    logic_y_n.append(i)
for i in odd_mid_logic_arr:
    logic_y_n.append(i)
for i in even_rim_logic_arr:
    logic_y_s.append(i)
for i in even_mid_logic_arr:
    logic_y_s.append(i)


# write ori2logic map file
with open("Ori_To_Logic.dat","w") as f:
    f.write("S Part:\n")
    for i in range(len(logic_y_s)):
        f.write("Original Addr: "+str(logic_y_s[i])+"\t\tDAC Addr: "+str(i*2)+"\n")
    f.write("\nN Part:\n")
    for i in range(len(logic_y_n)):
        f.write("Original Addr: "+str(logic_y_n[i])+"\t\tDAC Addr: "+str(i*2+1)+"\n")

# output logic addr according to original addr
for i in range(0,len(logic_y_n)):
    if int(ori_y) == logic_y_n[i]:
        print("Original addr "+ori_y+" is mapping to logical addr "+str(i)+" in N part")
for i in range(0,len(logic_y_s)):
    if int(ori_y) == logic_y_s[i]:
        print("Original addr "+ori_y+" is mapping to logic addr "+str(i)+" in S part")



