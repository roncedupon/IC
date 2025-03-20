import numpy as np
import os

class MatrixFormatter:
    def __init__(self):
        pass

    def vector2str(self, vector, format_str):
        """Efficiently converts a vector to a string using f-string and join."""
        return "".join(f"{x:{format_str}}" for x in vector)

    def split_str(self, s, n):
        """Splits a string into chunks of size n."""
        return [s[i:i+n] for i in range(0, len(s), n)]

    def str2list(self, s):
        """Converts a string to a list of characters."""
        return list(s)

    def formatting_final_matrix(self, in_final_matrix, out_file_dir, out_file_name, cell1_width, cell2_width):
        """Formats a matrix and writes it to a file."""
        try:
            print("in_final_matrix:", in_final_matrix)  # Print data
            print("in_final_matrix type:", type(in_final_matrix))
            print("in_final_matrix shape:", in_final_matrix.shape)
            os.makedirs(out_file_dir, exist_ok=True)  # Create directory if it doesn't exist
            file_path = os.path.join(out_file_dir, out_file_name)
            with open(file_path, "w", encoding="utf-8") as out_file:
                output_lines = []
                for row in in_final_matrix:
                    original_str = self.vector2str(row, f"0{int(cell1_width/4)}x")
                    original_str2 = self.split_str(original_str, 2)
                    # Correct conversion to integers:
                    original_vector = np.array([int(hex_str, 16) for hex_str in original_str2])
                    formatting_output = self.vector2str(original_vector, f"0{int(cell2_width/8)}x")
                    output_lines.append(formatting_output)

                print("output_lines:", output_lines)  # Print output lines
                out_file.write("\n".join(output_lines) + "\n")
            print(f"File write successed to: {file_path}")
        except Exception as e:
            print(f"An error occurred: {e}")


# Example usage:
if __name__ == "__main__":
    formatter = MatrixFormatter()  # Create an instance!
    in_final_matrix = np.random.randint(0, 256, size=(3328, 3328))
    out_file_dir = "output_dir"
    out_file_name = "output.txt"
    cell1_width = 32
    cell2_width = 64
    formatter.formatting_final_matrix(in_final_matrix, out_file_dir, out_file_name, cell1_width, cell2_width)
    print("file write finished")
#%%
import numpy as np

# 创建一个超大的 numpy 矩阵
large_matrix = np.random(0, 256, size=(10, 10))  # 3328x3328 的矩阵，元素范围 0-255

# 文件路径
file_path = 'large_matrix.txt'

# 打开文件以追加模式写入
with open(file_path, 'w') as f:
    # 使用 numpy.savetxt 写入矩阵，注意我们传入的 file 是 f，确保追加写入
    np.savetxt(f, large_matrix, fmt='%08x', delimiter='')

print(f"Matrix saved to {file_path}")

print(large_matrix[:10,:])

