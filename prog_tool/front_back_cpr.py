class front_back_cpr:
    def __init__(self, front_width=12, back_width=8):
        self.front_width = front_width  # 单位 bit
        self.back_width = back_width
        self.file_name_list=[
        "ne_x0y0_inner_trunk_n.data",
        "nw_x0y0_inner_trunk_n.data",
        "se_x0y0_inner_trunk_n.data",
        "sw_x0y0_inner_trunk_n.data",
        "ne_x0y0_inner_trunk_s.data",
        "nw_x0y0_inner_trunk_s.data",
        "se_x0y0_inner_trunk_s.data",
        "sw_x0y0_inner_trunk_s.data"
    ]
    def _hexstr_to_bin(self, hexstr):
        hexstr = hexstr.strip().replace(' ', '')
        binstr = bin(int(hexstr, 16))[2:]
        total_bits = len(hexstr) * 4
        return binstr.zfill(total_bits)

    def _split_bin_to_int_list(self, binstr, width):
        return [int(binstr[i:i+width], 2) for i in range(0, len(binstr), width)]

    def _read_file_to_matrix(self, file_path, width):
        matrix = []
        with open(file_path, 'r') as f:
            for line in f:
                binstr = self._hexstr_to_bin(line)
                row = self._split_bin_to_int_list(binstr, width)
                matrix.append(row)
        return matrix

    def compare_single_file(self, front_file_path, back_file_path, expected_shape=None):
        front_mat = self._read_file_to_matrix(front_file_path, self.front_width)
        back_mat  = self._read_file_to_matrix(back_file_path, self.back_width)

        if expected_shape:
            expected_rows, expected_cols = expected_shape
            if len(front_mat) != expected_rows or any(len(row) != expected_cols for row in front_mat):
                print("Front matrix shape mismatch!")
            if len(back_mat) != expected_rows or any(len(row) != expected_cols for row in back_mat):
                print("Back matrix shape mismatch!")

        match_count = 0
        off_by_1 = 0
        off_by_2 = 0
        off_by_more = 0
        total = 0

        min_rows = min(len(front_mat), len(back_mat))

        for i in range(min_rows):
            row_a = front_mat[i]//4
            row_b = back_mat[i]
            min_cols = min(len(row_a), len(row_b))
            for j in range(min_cols):
                a = row_a[j]
                b = row_b[j]
                total += 1
                if a == b:
                    match_count += 1
                elif abs(a - b) == 1:
                    off_by_1 += 1
                elif abs(a - b) == 2:
                    off_by_2 += 1
                else:
                    off_by_more += 1

        # 输出统计信息
        def fmt(count):
            return f"{count} ({count/total*100:.2f}%)" if total else f"{count} (0.00%)"
        print(f"Total elements: {total}")
        print(f"Exact matches: {fmt(match_count)}")
        print(f"±1 difference: {fmt(off_by_1)}")
        print(f"±2 difference: {fmt(off_by_2)}")
        print(f"Difference > 2: {fmt(off_by_more)}")

        if total == match_count:
            print("All elements match exactly.")
    def compare_all(self,front_file_dir,back_file_dir,expected_shape=(2082, 2112)):
        for file_name in self.file_name_list:
            self.compare_single_file(front_file_dir+"/"+file_name,back_file_dir+"/"+file_name,expected_shape)
            print("-----------------------------------------------------------------------------------")

if __name__ == "__main__":

    front_back_cpr_inst = front_back_cpr(front_width=12, back_width=8)
    front_file_dir = "/mnt/disk_0/IC/prog_tool/output/final/Layers0/init_golden/emu_12bit/"
    back_file_dir  = "/mnt/disk_0/IC/prog_tool/output/final/Layers0/init_golden/eda_8bit/"

    front_back_cpr_inst.compare_all(front_file_dir, back_file_dir, expected_shape=(2082, 2112))
