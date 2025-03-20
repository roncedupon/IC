#%%
import matplotlib.pyplot as plt

# 创建数据
x = [1, 2, 3, 4, 5]
y = [1, 4, 9, 16, 25]

# 创建图形和坐标轴
fig, ax = plt.subplots()

# 绘制图形
ax.plot(x, y)

# 设置x和y轴的范围，确保包含0
ax.set_xlim(left=0)  # x轴最小值为0
ax.set_ylim(bottom=0)  # y轴最小值为0

# 调整坐标轴spines，使得x轴和y轴从原点开始
ax.spines['left'].set_position('zero')
ax.spines['bottom'].set_position('zero')

# 显示图形
plt.show()
#%%
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x = np.logspace(1, 7, 100)  # 生成 10^1 到 10^7 的对数均匀分布的 100 个点
y = x**2

# 绘制图像
fig, ax = plt.subplots()
ax.plot(x, y)

# 设置 x 轴下标为科学计数法
ax.ticklabel_format(axis='x', style='sci', scilimits=(0, 0))

# 添加标签和标题
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_title('X 轴科学计数法示例')

# 显示图像
plt.show()
#%%
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np

# 生成示例数据
x = np.logspace(1, 7, 100)
y = x**2

# 绘制图像
fig, ax = plt.subplots()
ax.plot(x, y)

# 设置 x 轴下标为科学计数法
formatter = ticker.ScalarFormatter(useOffset=True, useMathText=True)
formatter.set_scientific(True)
formatter.set_powerlimits((0, 0))
ax.xaxis.set_major_formatter(formatter)

# 添加标签和标题
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_title('X 轴科学计数法示例')

# 显示图像
plt.show()
#%%
import matplotlib.pyplot as plt

# 示例数据
x = [1000000000, 2000000000, 3000000000]  # 纳秒时间
y = [1, 2, 3]

# 绘制图表
fig, ax = plt.subplots()
ax.plot(x, y)

# 格式化 x 轴刻度标签为纳秒时间
ax.xaxis.set_major_formatter(plt.FuncFormatter(lambda x, _: f"{x:.0f}"))

# 添加标签和标题
ax.set_xlabel("时间 (纳秒)")
ax.set_ylabel("Y 轴")
ax.set_title("X 轴纳秒时间示例")

# 显示图表
plt.show()
#%%
import matplotlib.pyplot as plt

# 示例数据
x = [1000000000.123456, 2000000000.987654, 3000000000.543210]  # 纳秒时间，包含小数
y = [1, 2, 3]

# 绘制图表
fig, ax = plt.subplots()
ax.plot(x, y)

# 格式化 x 轴刻度标签为纳秒时间，保留 5 位小数
ax.xaxis.set_major_formatter(plt.FuncFormatter(lambda x, _: f"{x:.5f}"))

# 添加标签和标题
ax.set_xlabel("时间 (纳秒)")
ax.set_ylabel("Y 轴")
ax.set_title("X 轴纳秒时间示例")

# 显示图表
plt.show()
#%%
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x = np.arange(0, 1000, 10)
y = x**2

# 绘制图表
fig, ax = plt.subplots(figsize=(10, 6))
ax.plot(x, y)

# 减少刻度数量
ax.set_xticks(np.arange(0, 1000, 100))

# 旋转刻度标签
plt.xticks(rotation=45)

# 添加标签和标题
ax.set_xlabel("时间")
ax.set_ylabel("数值")
ax.set_title("时间数据刻度重叠示例")

# 显示图表
plt.show()
#%%
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-10, 10, 256)
y = x**2 # 抛物线

plt.plot(x, y)

ax = plt.gca()
ax.spines['left'].set_position(('data', 0))
ax.spines['bottom'].set_position(('data', 0))
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
ax.yaxis.set_ticks_position('left')
ax.xaxis.set_ticks_position('bottom')


plt.title('原点在 (0,0) 的抛物线')
plt.show()

#%%
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-np.pi, np.pi, 256)
y = np.sin(x)

plt.plot(x, y)

ax = plt.gca()
ax.spines['left'].set_position('center')
ax.spines['bottom'].set_position('center')
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')

plt.title('原点在中心的Sin曲线')
plt.show()