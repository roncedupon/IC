import xlsxwriter

SEND_MOD=['MASTER',"SLAVE"]
DFS=[
"4-bit serial data transfer",
"5-bit serial data transfer",
"6-bit serial data transfer",
"7-bit serial data transfer",
"8-bit serial data transfer",
"9-bit serial data transfer",
"10-bit serial data transfer",
"11-bit serial data transfer",
"12-bit serial data transfer",
"13-bit serial data transfer",
"14-bit serial data transfer",
"15-bit serial data transfer",
"16-bit serial data transfer",
]

FRF=[
"Motorola SPI",
# "Texas Instruments SSP",
# "National Semiconductors Microwire",
]
SCPH=[
    "0",
    "1"
]
SCPOL=[
    "0",
    "1"
]
TMOD=[
"Transmit & Receive",
"Transmit Only",
"Receive Only",
# "EEPROM Read",
]
SLV_OE=[
    "0",
    "1"
]
workbook = xlsxwriter.Workbook('chat.xlsx')#创建一个excel文件
worksheet = workbook.add_worksheet(u'sheet1')#在文件中创建一个名为TEST的sheet,不加名字默认为sheet1






#===================================================================================
def write_txt():
    rows=1

    with open('chat.txt', 'w') as file:
        line = f"[{rows}]\t发送模式(SEND_MOD)\t协议(FRF)\t传输模式(TMOD)\数据帧长度(DFS)\t相位(SCPH)\t极性(SCPOL)"
        file.write(line + '\n')    
        for i in range(len(SEND_MOD)):
            for j in range(len(FRF)):
                for m in range(len(TMOD)):
                    for k in range(len(DFS)):
                        for l in range(len(SCPH)):
                            for n in range(len(SCPOL)):
                                line = f"[{rows}]\t{SEND_MOD[i]}\t{FRF[j]}\t{TMOD[m]}\t{DFS[k]}\t{SCPH[l]}\t{SCPOL[n]}"
                                file.write(line + '\n')    
                                rows=rows+1
def write_excel():
    rows=1
    for i in range(len(SEND_MOD)):
        for j in range(len(FRF)):
            for k in range(len(DFS)):
                for l in range(len(SCPH)):
                    for n in range(len(SCPOL)):
                        for m in range(len(TMOD)):
                            worksheet.write(rows,0,SEND_MOD[i])#使用行列的方式写上数字32,35,5
                            worksheet.write(rows,1,FRF[j])#使用行列的方式写上数字32,35,5
                            worksheet.write(rows,2,DFS[k])#使用行列的方式写上数字32,35,5
                            worksheet.write(rows,3,SCPH[l])#使用行列的方式写上数字32,35,5
                            worksheet.write(rows,4,SCPOL[n])#使用行列的方式写上数字32,35,5
                            worksheet.write(rows,5,TMOD[m])#使用行列的方式写上数字32,35,5
                            rows=rows+1
                            print(rows)
    workbook.close()    


if __name__ == '__main__':
    write_txt()
    write_excel()