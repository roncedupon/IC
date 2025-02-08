# %%
from openpyxl import Workbook

# 创建一个工作簿
wb = Workbook()

# 创建多个工作表
default_sheet = wb.active  # 默认的工作表
default_sheet.title = "DefaultSheet"

wb.create_sheet("Sheet1")  # 添加第一个 Sheet
wb.create_sheet("Sheet2")  # 添加第二个 Sheet

# 切换到第二个工作表（通过索引）
sheet2 = wb.worksheets[1]  # 注意索引从 0 开始，所以 1 是第二个 Sheet
sheet2.title = "SecondSheet"

# 向第二个工作表写入数据
sheet2["A1"] = "Hello, Sheet2!"  # 在单元格 A1 写入数据
sheet2["B1"] = 123               # 在单元格 B1 写入数字
sheet2.append(["Name", "Age", "City"])  # 写入一行数据
sheet2.append(["Alice", 30, "New York"])  # 添加另一行

# 保存到文件
wb.save("example_with_sheet2.xlsx")
print("数据写入成功并保存到文件 example_with_sheet2.xlsx")
