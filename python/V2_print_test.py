def printV1():
    name = "Alice"
    age = 30
    print("Name:", name, "Age:", age)

#-----------------------------------------------------------------
#字符串格式化 
def printV2():
    name = "Alice"
    age = 30    
    print(f"Name: {name}, Age: {age}")#使用 f-strings（Python 3.6及以上）进行格式化：

def printV3():
    name = "Alice"
    age = 30
    print("Name: {}, Age: {}".format(name, age))#使用 str.format() 方法：

def printV4():
    name = "Alice"
    age = 30
    print("Name: %s, Age: %d" % (name, age))


#-----------------------------------------------------------------
#字符串对齐
class str_align:


    # def __init__(self):
        # print("new")
        # self.args=cfg_args()

    def printV1(self):
        seed=1024
        tc_name="12345"
        print('{:<15}{:<30}{:<100}'.format("running", tc_name, str(seed))) 
if __name__=="__main__":
    printV1()
    printV2()
    printV3()
    printV4()

    str_align_inst=str_align()
    str_align_inst.printV1()
