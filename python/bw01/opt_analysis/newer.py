import re
import openpyxl
import os
def extract_vcs_command_from_log(log_file_path):
    """从 compile.log 中提取完整的 VCS 编译命令（支持多行）。"""
    try:
        with open(log_file_path, "r", encoding="utf-8") as f:
            command_lines = []
            in_command = False  # 标志是否在 VCS 命令内部
            for line in f:
                line = line.strip()
                if line.startswith("Command: vcs"):
                    command_lines.append(line[len("Command: "):].strip())  # 去除 "Command: " 前缀
                    in_command = True
                elif in_command:
                    command_lines.append(line)
                    if not line.endswith("\\"):  # 命令结束的标志
                        break  # 跳出循环
            if command_lines:
                return " ".join(line.replace("\\", "").strip() for line in command_lines)  # 连接行并删除反斜杠
    except FileNotFoundError:
        print(f"Error: Log file not found: {log_file_path}")
        return None
    except UnicodeDecodeError:
        print(f"Warning: Unicode decode error in log file: {log_file_path}. Try a different encoding.")
        return None
    return None
    
def parse_vcs_command(command):
    """更鲁棒地解析 VCS 编译命令。"""
    parts = re.findall(r'"[^"]*"|\S+', command)
    data = {
        "top_file": None,
        "include_dirs": [],
        "defines": {},
        "c_flags": [],
        "ld_flags": [],
        "uvm_src_files": [],
        "file_lists": [],  # 存储 -f 选项指定的文件列表
        "other_options": []
    }

    i = 0
    while i < len(parts):
        part = parts[i].strip('"')  # 去除引号
        if part.endswith((".sv", ".v")):
            data["top_file"] = part
        elif part.startswith("+incdir+"):
            data["include_dirs"].append(part[8:])
        elif part.startswith("+define+"):
            if "=" in part:
                name, value = part[8:].split("=", 1)
                data["defines"][name] = value
            else:
                data["defines"][part[8:]] = None
        elif part == "-CFLAGS":
            i += 1
            while i < len(parts) and not parts[i].startswith("-"):
                data["c_flags"].append(parts[i].strip('"'))
                i += 1
            i -= 1
        elif part == "-LDFLAGS":
            i += 1
            while i < len(parts) and not parts[i].startswith("-"):
                data["ld_flags"].append(parts[i].strip('"'))
                i += 1
            i -= 1
        elif part.endswith(".cc") and "-CFLAGS" in parts[:i]:
            data["uvm_src_files"].append(part.strip('"'))
        elif part == "-f":
            i += 1
            if i < len(parts):
                data["file_lists"].append(parts[i].strip('"')) #将-f后面的文件加入到file_lists
        elif part.startswith("-"):
            data["other_options"].append(part)
            if i + 1 < len(parts) and not parts[i+1].startswith("-"):
                data["other_options"].append(parts[i+1].strip('"'))
                i += 1
        i += 1
    return data

def expand_file_lists(data):
    """展开 -f 选项指定的文件列表。"""
    expanded_files = []
    for file_list in data["file_lists"]:
        try:
            with open(file_list, "r") as f:
                for line in f:
                    file_path = line.strip()
                    if file_path and not file_path.startswith("#"): #排除空行和注释行
                        expanded_files.append(file_path)
        except FileNotFoundError:
            print(f"Warning: File list not found: {file_list}")
    return expanded_files


def parse_compile_log(log_file_path):
    """解析 compile.log 文件，提取错误、警告和信息。"""
    errors = []
    warnings = []
    infos = []

    try:
        with open(log_file_path, "r", encoding="utf-8") as f:  # 处理编码问题
            for line in f:
                error_match = re.search(r"Error-\[(.*?)\] (.*)", line)
                if error_match:
                    errors.append({"code": error_match.group(1), "message": error_match.group(2).strip()})
                warning_match = re.search(r"Warning-\[(.*?)\] (.*)", line)
                if warning_match:
                    warnings.append({"code": warning_match.group(1), "message": warning_match.group(2).strip()})
                info_match = re.search(r"Info-\[(.*?)\] (.*)", line)
                if info_match:
                    infos.append({"code": info_match.group(1), "message": info_match.group(2).strip()})
    except FileNotFoundError:
        print(f"Error: Log file not found: {log_file_path}")

    return errors, warnings, infos


def generate_excel_report(data, errors, warnings, infos):
    """生成 Excel 报告，包含 VCS 命令解析结果和 log 文件分析结果。"""
    wb = openpyxl.Workbook()

    # VCS 命令分析 sheet
    vcs_sheet = wb.active
    vcs_sheet.title = "VCS Command Analysis"
    vcs_sheet.append(["Category", "Item"])

    for category, items in data.items():
        vcs_sheet.append([category, ""])  # 添加分类标题
        if isinstance(items, list):
            for item in items:
                vcs_sheet.append(["", item])
        elif isinstance(items, dict):
            for name, value in items.items():
                vcs_sheet.append(["", f"{name}={value if value is not None else ''}"])
        elif items:
            vcs_sheet.append(["", items])

    # log 文件分析 sheet
    log_sheet = wb.create_sheet("Compile Log Analysis")
    log_sheet.append(["Type", "Code", "Message"])

    for error in errors:
        log_sheet.append(["Error", error["code"], error["message"]])
    for warning in warnings:
        log_sheet.append(["Warning", warning["code"], warning["message"]])
    for info in infos:
        log_sheet.append(["Info", info["code"], info["message"]])

    wb.save("vcs_report.xlsx")  # 修改文件名，避免覆盖
    print("Excel report generated: vcs_report.xlsx")


# 示例用法
if __name__ == "__main__":
    # 示例用法
    log_file_path = "compile.log"

    command = extract_vcs_command_from_log(log_file_path)

    if command: #只有当成功提取到command时才进行后续操作
        print(f"Extracted command: {command}")
        data = parse_vcs_command(command)
        expanded_files = expand_file_lists(data)
        data["expanded_files"] = expanded_files
        errors, warnings, infos = parse_compile_log(log_file_path)
        generate_excel_report(data, errors, warnings, infos)

        import json
        print("VCS command analysis:")
        print(json.dumps(data, indent=4))
        print("\nCompile log analysis:")
        log_data = {"errors":errors,"warnings":warnings,"infos":infos}
        print(json.dumps(log_data, indent=4))
    else:
        print("Failed to extract VCS command from log file.")
