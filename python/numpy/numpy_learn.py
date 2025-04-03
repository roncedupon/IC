# %%
import openpyxl
import numpy as np
import os
def matrxi2xslx(matrix,out_file_dir="./output",out_file_name="matrix.xlsx"):
    os.makedirs(out_file_dir, exist_ok=True)
    output_path = os.path.join(out_file_dir, out_file_name)
    workbook=openpyxl.Workbook()
    sheet=workbook.active
    for row_idx,row in enumerate(matrix,start=1):
        for col_idx,value in enumerate(row,start=1):
            sheet.cell(row=row_idx,column=col_idx,value=value)
    workbook.save(output_path)
A = np.arange(0, 1024*1024).reshape(-1, 1024)
matrxi2xslx(A)
# %%
import openpyxl
import numpy as np
import os
def matrxi2xslx(matrix, out_file_dir="./output", out_file_name="matrix.xlsx"):
    os.makedirs(out_file_dir, exist_ok=True)
    output_path = os.path.join(out_file_dir, out_file_name)
    workbook = openpyxl.Workbook()
    sheet = workbook.active
    for row_idx, row in enumerate(matrix, start=1):
        for col_idx, value in enumerate(row, start=1):
            sheet.cell(row=row_idx, column=col_idx, value=value)
    workbook.save(output_path)
A = np.arange(1, 10).reshape(3, 3)
matrxi2xslx(A)
# %%
import numpy as np
data_width=8
data=128
data_flag=128>=2**(data_width-1)
data_complet=data-data_flag*(2**data_width)
print(data_flag)
print(data_complet)
#%%
import numpy as np
data=np.arange(0,10)
print(data[[1,2,3,4]])
print(data[1:8:2])
print(list(range(0,9)))
#%%
import numpy as np

data = np.arange(0, 20).reshape(10,2)

result = data[1][:]
result=data[1,:]
print(result)
#%%
import numpy as np

data = np.arange(20).reshape(10, 2)

row_indices_to_select = [1, 3, 5, 7, 9]
result = data[row_indices_to_select][[0,1]]  # Select these rows and all columns

print("\nResult:\n", result)

#%%