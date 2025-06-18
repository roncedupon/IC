import re
import numpy as np

class BinBlockExtractor:
    def __init__(self, txt_path, bin_path):
        self.txt_path = txt_path
        self.bin_path = bin_path
        self.block_info = []

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
    
    def dump_block_to_txt(self, block: bytes, line_bytes: int = 128, out_path: str = 'output.txt'):
        """
        convert block into txt (default 1024bit/line,little endian)
        """
        with open(out_path, 'w') as f:
            for i in range(0, len(block), line_bytes):
                chunk = block[i:i+line_bytes]
                hex_str = ''.join(f'{b:02x}' for b in chunk[::-1])
                f.write(hex_str + '\n')
               
    def Extractor_main(self):
        blocks      = self.extract_from_bin()
        for idx, item in enumerate(blocks):
            ppid=item[0]
            blk=item[1]
            self.dump_block_to_txt(blk, line_bytes=128, out_path=f'block{idx}_ppid{ppid}.txt')
        print(f'Extraction Finished, totally {len(blocks)} blocks.')
#
if __name__ == '__main__':
    txt_path    = './cp_test/map_split.txt'
    bin_path    = './cp_test/physics_map.bin'    
    extractor   = BinBlockExtractor(txt_path, bin_path)
    extractor.Extractor_main()
