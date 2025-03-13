import openpyxl

class openpyxltest:
    def __init__(self):
        pass
    def get_table_value(self,table_object,row,col):
        #get the [row,col]value of table
        return table_object.cell(row=row, column=col).value
    def join_txt(self,table_object,input_str,row_num,col_num,reverse=False):
        #table_object: 一个表格对象
        #将表格的某一列与某个固定输入inpur_str组合成新的一列数据
        #input_str: 一个固定输入
        #row_num:需要从第几行开始拼接，默认从表格的第一行，值1，2，3...
        #col_num:需要拼接的第几列数据,值1，2，3...
        #reverse: 是否翻转，默认是input_str在前，第i列数据在后

        max_col = table_object.max_column # 
        output_col_num = max_col + 1 # 

        for row_index,row in enumerate(table_object.iter_rows(min_row=row_num),start=row_num): # 遍历所有行，包括标题行
            cell_to_join = row[col_num - 1] # 
            print(cell_to_join)
            

            cell_value = cell_to_join.value
            if cell_value is not None: 
                if reverse:
                    output_value = str(cell_value) + str(input_str)
                else:
                    output_value = str(input_str) + str(cell_value)

                table_object.cell(row=row_index,column=output_col_num,value=output_value)

        return table_object 


if __name__ == '__main__':
    # 示例用法
    workbook = openpyxl.Workbook()
    sheet = workbook.active

    # 写入一些测试数据
    sheet['A1'] = 'Name'
    sheet['B1'] = 'Value'
    sheet['A2'] = 'Apple'
    sheet['B2'] = 1
    sheet['A3'] = 'Banana'
    sheet['B3'] = 2
    sheet['A4'] = 'Cherry'
    sheet['B4'] = 3
    sheet['A5'] = 'Date'
    sheet['B5'] = None # 测试空值情况

    excel_test = openpyxltest()

    # 将 "Prefix_" 前缀拼接到第一列 (Name列)
    modified_sheet_prefix = excel_test.join_txt(sheet, "Prefix_",2,1)

    # 将 "_Suffix" 后缀拼接到第二列 (Value列)，并翻转顺序
    # modified_sheet_suffix_reverse = excel_test.join_txt(modified_sheet_prefix, "_Suffix", 2, reverse=True)


    # 保存修改后的Excel文件
    workbook.save("joined_excel_example.xlsx")
    print("Excel文件 'joined_excel_example.xlsx' 已生成，包含拼接后的列。")

