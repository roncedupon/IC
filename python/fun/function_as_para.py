#%%
def greet(name):
    return f"Hello, {name}!"

def caller(func, name):
    return func(name)

print(caller(greet, "Alice"))  # 输出: Hello, Alice!