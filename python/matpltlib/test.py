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
