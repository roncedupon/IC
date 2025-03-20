import os
import sys
import argparse

def parse_filelist(filelist, parsed_files=None, verbose=False):
    """
    递归解析 VCS -f 文件，展开所有源文件路径。
    
    :param filelist: 要解析的 -f 文件
    :param parsed_files: 记录已解析的文件，防止重复解析
    :param verbose: 是否启用详细模式
    :return: 展开后的文件列表
    """
    if parsed_files is None:
        parsed_files = set()
    
    # 存储最终解析的所有文件路径
    expanded_files = []
    
    if filelist in parsed_files:
        return expanded_files  # 避免重复解析
    parsed_files.add(filelist)

    try:
        with open(filelist, "r") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):  # 忽略空行和注释
                    continue
                if line.startswith("-f"):  
                    # 解析 -f 递归包含的文件
                    _, included_file = line.split(maxsplit=1)
                    if verbose:
                        print(f"[INFO] Parsing included file: {included_file}")
                    expanded_files.extend(parse_filelist(included_file, parsed_files, verbose))
                elif line.startswith("+incdir+"):
                    # 解析 include 目录（可以单独存储，也可以忽略）
                    expanded_files.append(line)
                else:
                    # 普通的文件路径
                    expanded_files.append(line)
    except FileNotFoundError:
        print(f"[WARNING] File not found: {filelist}", file=sys.stderr)
    
    return expanded_files

def main():
    parser = argparse.ArgumentParser(description="Expand VCS -f filelist.")
    parser.add_argument("-filelist", help="Path to the VCS -f file")
    parser.add_argument("-o", "--output", help="Output file to save the expanded list")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose mode")
    
    args = parser.parse_args()
    
    expanded_files = parse_filelist(args.filelist, verbose=args.verbose)

    if args.output:
        with open(args.output, "w") as f:
            f.write("\n".join(expanded_files) + "\n")
        if args.verbose:
            print(f"[INFO] Expanded filelist saved to: {args.output}")
    else:
        # 直接打印到终端
        for filepath in expanded_files:
            print(filepath)

if __name__ == "__main__":
    main()
