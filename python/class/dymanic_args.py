class MyClass:
    def __init__(self, **args):
        # 将可变数量的位置参数存储到实例属性中
        self.args = args

    def show_args(self):
        print("传入的位置参数:", self.args)

# 创建类的实例并传入多个参数
obj = MyClass(1, 2, 3, "hello", True)
obj.show_args()  # 输出: 传入的位置参数: (1, 2, 3, 'hello', True)
