# %% python set学习
modules_data = [
    ("MODULE_C", 100, 200),
    ("MODULE_A", 0, 50),
    ("MODULE_B", 60, 120),
    ("MODULE_A", 300, 350),
]

module=[module for module, _, _ in modules_data]  # 输出: ["MODULE_C", "MODULE_A", "MODULE_B", "MODULE_A"]
print(module)
print(set(module))
print(type(set(module)))
print(list(set(module)))




AA = "svt data"
if all([True,False,False]):
    print("hh")
else:
    print("fuck")

#%%
A=[1,2,34]
A[[0,1]]