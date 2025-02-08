# %%
class ParentClass:
    def __init__(self, name):
        self.name = name
    
    def greet(self):
        print(f"[in father] I am {self.name}, and I am {self.age} years old.")  

# 子类继承父类
class ChildClass(ParentClass):
    def __init__(self, name, age):
        super().__init__(name)  # 调用父类的构造方法
        self.age = age
    def greet(self):
        print(f"[in son greet] I am {self.name}, and I am {self.age} years old.")   

    def introduce(self):
        print(f"[in son introduce] I am {self.name}, and I am {self.age} years old.")

 

# 使用子类
child = ChildClass("Alice", 18)
child.greet()        # 调用子类的方法
child.introduce()    # 调用子类的方法


# %%
