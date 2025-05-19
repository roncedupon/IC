import re

code = '''
for (int i = 0xb104; i <= 0xeffc; i += 4)
    reg_test(i, 0x01llu, 0x2ce0069llu, 0xf, 31, 0);
'''

# 使用正则匹配16进制起始和终止地址
pattern = r'for\s*\(\s*int\s+i\s*=\s*(0x[0-9a-fA-F]+)\s*;\s*i\s*<=\s*(0x[0-9a-fA-F]+)'
pattern1 = r'for.*\n.*\);'
match = re.search(pattern, code)

if match:
    start_addr = match.group(1)
    end_addr = match.group(2)
    print("Start address:", start_addr)
    print("End address:", end_addr)
else:
    print("地址未匹配到")
match=re.search(pattern1,code)
if match:
    print(re.sub(pattern1,f"/*{match.group(0)}*/",code))#为其添加注释