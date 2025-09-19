import re
import numpy as np
import os
import argparse
class BinBlockExtractor:
    def __init__(self, txt_path, bin_path):
        self.out_dir   ="./output"
        self.txt_path = txt_path
        self.bin_path = bin_path
        self.block_info = []
        if not os.path.exists(self.out_dir):
            os.makedirs(self.out_dir)
    def extract_block_info(self):
        """ [addr, pingpong_id, size] """
        with open(self.txt_path, 'r') as f:
            content = f.read()
            matches = re.findall(r'\[(\d+),\s*(\d+),\s*(\d+)\]', content)
            self.block_info = [(int(addr), int(pingpong_id), int(size)) for addr, pingpong_id, size in matches]
        return self.block_info

    def extract_from_bin(self):
        if not self.block_info:
            self.extract_block_info()
        with open(self.bin_path, 'rb') as f:
            binary = f.read()

        result_bytes = bytearray()
        block_list = []
        for addr, pingpong_id, size in self.block_info:
            block = binary[addr:addr+size]
            block_list.append([pingpong_id, block])
            result_bytes.extend(block)
        
        return block_list  #np.frombuffer(result_bytes, dtype=np.uint8)
    
    def dump_block_to_txt(self, block: bytes, block_index=0,ppid=0,line_bytes: int = 128, out_dir=None):
        """
        convert block into txt (default 1024bit/line,little endian)
        """
        if out_dir is None:
            out_dir=os.path.join(self.out_dir,"./original_block")
            if not os.path.exists(out_dir):
                os.makedirs(out_dir)        
        with open(f"{out_dir}/block{block_index}_ppid{ppid}.txt", 'w') as f:
            for i in range(0, len(block), line_bytes):
                chunk = block[i:i+line_bytes]
                hex_str = ''.join(f'{b:02x}' for b in chunk[::-1])
                f.write(hex_str + '\n')
    def dump_block_to_2bank(self,block: bytes,block_index=0,ppid=0,out_dir=None):
        if out_dir is None:
            out_dir=os.path.join(self.out_dir,"./sram_backdoor")
            if not os.path.exists(out_dir):
                os.makedirs(out_dir)
        line_bytes  = 16
        bank_num    = 4
        bank_list   =[[],[],[],[]]
        # with open(out_path, 'w') as f:
        #     f.write(hex_str + '\n')        
        for i in range(0, len(block), line_bytes*bank_num):
            for j in range(bank_num):
                chunk = block[i+line_bytes*j:i+line_bytes*(j+1)]
                hex_str = ''.join(f'{b:02x}' for b in chunk[::-1])
                bank_list[j].append(hex_str)
        with open(f"{out_dir}/block{block_index}_ppid{ppid}_sram0_low.txt","w")as f:
            for i in range(len(bank_list[0])):
                f.write(bank_list[0][i]+"\n")
        with open(f"{out_dir}/block{block_index}_ppid{ppid}_sram0_high.txt","w")as f:
            for i in range(len(bank_list[1])):
                f.write(bank_list[1][i]+"\n")
        with open(f"{out_dir}/block{block_index}_ppid{ppid}_sram1_low.txt","w")as f:
            for i in range(len(bank_list[2])):
                f.write(bank_list[2][i]+"\n")
        with open(f"{out_dir}/block{block_index}_ppid{ppid}_sram1_high.txt","w")as f:
            for i in range(len(bank_list[3])):
                f.write(bank_list[3][i]+"\n")
        return bank_list
    def Extractor_main(self):
        blocks      = self.extract_from_bin()
        for idx, item in enumerate(blocks):
            ppid=item[0]
            blk=item[1]
            self.dump_block_to_txt(blk, block_index=idx,line_bytes=128,ppid=ppid)
            self.dump_block_to_2bank(blk,block_index=idx,ppid=ppid)
        print(f'Extraction Finished, totally {len(blocks)} blocks.')
#
if __name__ == '__main__':
    txt_path    = './cp_test_0619/map_split_debug.txt'
    bin_path    = './cp_test_0619/physics_map.bin'    
    extractor   = BinBlockExtractor(txt_path, bin_path)
    extractor.Extractor_main()
#%%
from collections import defaultdict
stage_dict=defaultdict(list)
stage_dict{0}.append(123)


#%%
from collections import defaultdict
stage=defaultdict(list)
stage[1].append(123)
