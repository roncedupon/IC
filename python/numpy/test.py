import numpy as np
class myclass:
    def funA():
        np.random.seed(12345)
        print(np.random.randint(0,255,(1,10)))
        print(np.random.randint(0,255,(1,10)))
myclass_instance=myclass
myclass_instance.funA()
print("--"*10)
myclass_instance.funA()