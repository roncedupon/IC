from openpyxl import load_workbook

# 打开已有的 Excel 文件
wb = load_workbook('your_file.xlsx')
ws = wb.active  # 或指定工作表：wb['Sheet1']

# 要添加的一列数据（假设与已有行数匹配）
new_data = ['新值1', '新值2', '新值3', '新值4']  # 按需填写

# 获取当前表格已有的最大列数
max_col = ws.max_column

# 将新数据添加为下一列（例如第 max_col+1 列）
for i, value in enumerate(new_data, start=1):  # Excel 行号从 1 开始
    ws.cell(row=i, column=max_col + 1, value=value)

# 可选：设置新列标题
ws.cell(row=1, column=max_col + 1, value='新列标题')

# 保存修改
wb.save('your_file_modified.xlsx')  # 或覆盖原文件
