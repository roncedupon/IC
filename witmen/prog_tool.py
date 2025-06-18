import re
import numpy as np

#step1
def extract_block_info(txt_path):
    block_info = []
    with open(txt_path, 'r') as f:
        content = f.read()
        #match: [number,number,number]
        matches = re.findall(r'\[(\d+),\s*(\d+),\s*(\d+)\]', content)
        block_info = [(int(addr), int(pingpong_id),int(size)) for addr,pingpong_id, size in matches]
    return block_info

#step2
def extract_from_bin(bin_path, block_info):
    with open(bin_path, 'rb') as f:
        binary = f.read()
    
    result_bytes    = bytearray()
    block_list      =[]
    for addr,_,size in block_info:
        segment = binary[addr:addr+size]
        result_bytes.extend(segment)

    return np.frombuffer(result_bytes, dtype=np.uint8)

# 主流程
if __name__ == '__main__':
    txt_path = './cp_test/map_split.txt'         
    bin_path = './cp_test/physics_map.bin'    

    block_info = extract_block_info(txt_path)
    np_array = extract_from_bin(bin_path, block_info)
    print(f'Extraction Finished,totally {len(np_array)} B.')

