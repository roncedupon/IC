import re
import openpyxl


class VCSLogAnalyzer:
    OPTION_EXPLANATIONS = {
        "-work": "指定编译时使用的工作库的名称。",
        "-full64": "启用 64 位模式进行编译，以支持更大的设计和更高的性能。",
        "-sverilog": "启用 SystemVerilog 语言支持，用于编译 SystemVerilog 源文件。",
        "-timescale=1ns/1ps": "指定仿真时间单位和时间精度",
        "-assert svaext": "启用断言支持，并允许使用 SVA（SystemVerilog Assertions）扩展。",
        "-kdb": "kdb-Knowledge Database",
        "-lca": " Limited Customer Availability features",
        "+lint-TFIPC-L": "启用指定的 lint（代码质量检查）选项，用于检测潜在的设计问题。",
        "+v2k": "启用 Verilog-2000 的语言支持，确保编译时兼容该标准。",
        "-debug_access+all": "启用对所有变量的调试访问权限。",
        "-debug_all": "启用所有调试选项，包括完整的信号跟踪和调试功能。",
        "+vcs+initreg+random": "随机初始化寄存器值，以检查设计中未定义的行为。",
        "-top tb_top": "指定顶层模块为 tb_top，用于仿真的入口点。",
        "+nospecify": "仿真时忽略库文件中指定的的延时",
        "+notimingcheck": "禁用所有时序检查，以忽略静态时序问题。",
        "-upf": "指定功耗约束文件（Unified Power Format 文件），用于低功耗设计验证。",
        "-power_top tb_top": "指定用于功耗分析的顶层模块为 tb_top。",
        "-power-dont_touch_mem": "在功耗分析过程中，避免更改存储器实例。",
        "-power-coverage": "启用功耗覆盖率分析",
        "-P": "指定加载的 PLI（Programming Language Interface）库路径。",
        "-CFLAGS": "传递给 C 编译器的选项，用于自定义编译行为。",
        "-DVCS": "定义VCS宏",
        "-I": "指定头文件的搜索目录，以便编译器查找文件。"
    }


    def __init__(self, log_file_path):
        self.log_file_path = log_file_path
        self.command = None
        self.data = None
        self.errors = []
        self.warnings = []
        self.infos = []
        self.line_numbers = {"Error": [], "Warning": []}

    def extract_vcs_command(self):
        try:
            with open(self.log_file_path, "r", encoding="utf-8") as f:
                command_lines = []
                in_command = False
                for line in f:
                    line = line.strip()
                    if line.startswith("Command: vcs"):
                        command_lines.append(line[len("Command: vcs "):].strip())
                        in_command = True
                    elif in_command:
                        command_lines.append(line)
                        if not line.endswith("\\"):
                            break
                if command_lines:
                    self.command = " ".join(line.replace("\\", "").strip() for line in command_lines)
        except FileNotFoundError:
            print(f"Error: Log file not found: {self.log_file_path}")

    def parse_vcs_command(self):
        self.data = {"files": [], "include_dirs": [], "defines": {}, "other_options": []}
        if not self.command:
            return

        parts = re.findall(r'"[^"]*"|\S+', self.command)
        i = 0

        # 定义多输入选项（可扩展）
        multi_input_options = {"-p", "-CFLAGS", "-P"}  # 针对可能接受多个输入的选项

        while i < len(parts):
            part = parts[i]

            if part == "-f":
                i += 1
                if i < len(parts):
                    self.data["files"].append(parts[i])
            elif part.startswith("+incdir+"):
                self.data["include_dirs"].append(part[len("+incdir+"):])
            elif part.startswith("+define+"):
                define_parts = part[len("+define+"):].split("=", 1)
                if len(define_parts) == 2:
                    self.data["defines"][define_parts[0]] = define_parts[1]
                else:
                    self.data["defines"][define_parts[0]] = None
            elif part.startswith("-"):
                option = part
                i += 1
                if option in multi_input_options:
                    # 多输入选项处理
                    multi_inputs = []
                    while i < len(parts) and not parts[i].startswith("-") and not parts[i].startswith("+"):
                        multi_inputs.append(parts[i])
                        i += 1
                    i -= 1  # 回退一位，以便下次正确处理
                    self.data["other_options"].append(f"{option} {' '.join(multi_inputs)}")
                else:
                    # 单输入选项处理
                    if i < len(parts) and not parts[i].startswith("-") and not parts[i].startswith("+") and parts[i] not in ["-f"]:
                        self.data["other_options"].append(f"{option} {parts[i]}")
                    else:
                        self.data["other_options"].append(option)
                        i -= 1
            elif part.startswith("+"):
                self.data["other_options"].append(part)
            elif not part.startswith("-") and not part.startswith("+") and part not in ["-f"]:
                self.data["files"].append(part)
            i += 1

    def parse_compile_log(self):
        try:
            with open(self.log_file_path, "r", encoding="utf-8") as f:
                for line_number, line in enumerate(f, 1):
                    error_match = re.search(r"Error-\[(.*?)\] (.*)", line)
                    if error_match:
                        self.errors.append({"code": error_match.group(1), "message": error_match.group(2).strip()})
                        self.line_numbers["Error"].append(line_number)
                    warning_match = re.search(r"Warning-\[(.*?)\] (.*)", line)
                    if warning_match:
                        self.warnings.append({"code": warning_match.group(1), "message": warning_match.group(2).strip()})
                        self.line_numbers["Warning"].append(line_number)
                    info_match = re.search(r"Info-\[(.*?)\] (.*)", line)
                    if info_match:
                        self.infos.append({"code": info_match.group(1), "message": info_match.group(2).strip()})
        except FileNotFoundError:
            print(f"Error: Log file not found: {self.log_file_path}")

    def auto_adjust_column_width(self, filepath):
        try:
            workbook = openpyxl.load_workbook(filepath)
            for sheet in workbook.sheetnames:
                worksheet = workbook[sheet]
                for column_cells in worksheet.columns:
                    max_length = 0
                    column = column_cells[0].column_letter
                    for cell in column_cells:
                        try:
                            if len(str(cell.value)) > max_length:
                                max_length = len(str(cell.value))
                        except:
                            pass
                    adjusted_width = (max_length + 2) * 1.2
                    worksheet.column_dimensions[column].width = adjusted_width
            workbook.save(filepath)
            print(f"Column widths in '{filepath}' have been automatically adjusted.")
        except FileNotFoundError:
            print(f"File '{filepath}' not found.")
        except openpyxl.utils.exceptions.InvalidFileException:
            print(f"File '{filepath}' is not a valid xlsx file.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def generate_excel_report(self, output_path="vcs_report.xlsx"):
        wb = openpyxl.Workbook()

        # VCS Command Analysis sheet
        vcs_sheet = wb.active
        vcs_sheet.title = "VCS Command Analysis"
        vcs_sheet.append(["Category", "Item", "Explanation"])
        NO_EXPLANATION_AVAILABLE = " "

        for category, items in self.data.items():
            if isinstance(items, list):
                for item in items:
                    explanation = self.OPTION_EXPLANATIONS.get(item, NO_EXPLANATION_AVAILABLE)
                    vcs_sheet.append([category, item, explanation])
            elif isinstance(items, dict):
                for name, value in items.items():
                    item = f"{name}={value if value is not None else ''}"
                    explanation = self.OPTION_EXPLANATIONS.get(name, NO_EXPLANATION_AVAILABLE)
                    vcs_sheet.append([category, item, explanation])

        # Compile Log Analysis sheet
        log_sheet = wb.create_sheet("Compile Log Analysis")
        log_sheet.append(["Line", "Type", "Code", "Message"])

        for i, error in enumerate(self.errors):
            log_sheet.append([self.line_numbers["Error"][i], "Error", error["code"], error["message"]])
        for i, warning in enumerate(self.warnings):
            log_sheet.append([self.line_numbers["Warning"][i], "Warning", warning["code"], warning["message"]])
        for info in self.infos:
            log_sheet.append(["", "Info", info["code"], info["message"]])

        wb.save(output_path)
        self.auto_adjust_column_width(output_path)
        print(f"Excel report generated: {output_path}")

# Example usage
log_file_path = "compile.log"
analyzer = VCSLogAnalyzer(log_file_path)
analyzer.extract_vcs_command()
analyzer.parse_vcs_command()
analyzer.parse_compile_log()
analyzer.generate_excel_report()
