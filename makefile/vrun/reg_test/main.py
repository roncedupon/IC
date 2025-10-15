import re

input_file = "reg_debug_dac_up_tsv_reg_test.sv"  # 源文件名
output_file = "selected_regs.txt"                 # 输出文件名

# 用来匹配 reg_test(...) 行
pattern = re.compile(r'^\s*reg_test\s*\((.*?)\);')

# 存放解析结果
lines = []
unique_by_addr = {}

with open(input_file, 'r', encoding='utf-8') as f:
    for line in f:
        match = pattern.search(line)
        if not match:
            continue
        
        # 提取整个参数串
        params = match.group(1)
        # 提取地址（匹配 FC0_ADDR+0x????）
        addr_match = re.search(r'FC0_ADDR\+\s*0x[0-9a-fA-F]+', params)
        addr = addr_match.group(0) if addr_match else "UNKNOWN_ADDR"
        
        # 只保留第一次出现的该地址行
        if addr not in unique_by_addr:
            unique_by_addr[addr] = line.strip()
            lines.append(line.strip())

# 取前3和后3条
selected = lines[:3] + lines[-3:] if len(lines) > 6 else lines

# 写入输出文件
with open(output_file, 'w', encoding='utf-8') as f:
    f.write('\n'.join(selected))

print(f"✅ 提取完成，共 {len(selected)} 条，结果已写入 {output_file}")
