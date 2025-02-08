import re
import os

class UVMConnectionChecker:
    # Regular expressions to match patterns for hard-coded and static connections
    HARD_CODED_PATTERN = re.compile(r'\s*assign\s+(\w+)\s*=\s*(\S+);')  # Hard-coded connection check
    STATIC_CONNECTIONS_PATTERN = re.compile(r'(\w+)\s*=\s*(\w+);')  # Static connection check

    def __init__(self, directory):
        self.directory = directory

    def print_warning(self, header, file_path, line_num, matches, line):
        """
        Prints formatted warning messages.
        :param header: Warning header
        :param file_path: Path of the file
        :param line_num: Line number where the issue was found
        :param matches: List of matched connections
        :param line: The line of code containing the issue
        """
        print("=" * 80)
        print(f"{header} in {file_path} at line {line_num}")
        print("-" * 80)
        for match in matches:
            print(f"  Signal '{match[0]}' {'assigned to' if header.startswith('Hard') else 'statically connected to'} '{match[1]}'.")
        print("-" * 80)
        print(f"  Line: {line.strip()}")
        print("=" * 80)
        print("\n")

    def check_hard_coded_connections(self, line, file_path, line_num):
        """
        Checks for hard-coded connections in a line of code.
        :param line: The line of code to check
        :param file_path: Path of the file being checked
        :param line_num: Line number in the file
        """
        hard_coded_matches = self.HARD_CODED_PATTERN.findall(line)
        if hard_coded_matches:
            self.print_warning("Warning: Found hard-coded connections", file_path, line_num, hard_coded_matches, line)

    def check_static_connections(self, line, file_path, line_num):
        """
        Checks for static connections in a line of code.
        :param line: The line of code to check
        :param file_path: Path of the file being checked
        :param line_num: Line number in the file
        """
        static_matches = self.STATIC_CONNECTIONS_PATTERN.findall(line)
        if static_matches:
            self.print_warning("Warning: Found static connections", file_path, line_num, static_matches, line)

    def check_connections_in_file(self, file_path):
        """
        Checks a file for hard-coded and static connections.
        :param file_path: Path of the file to be checked
        """
        with open(file_path, 'r') as f:
            lines = f.readlines()

        # Check each line of the file
        for line_num, line in enumerate(lines, 1):
            # Skip empty lines or comment lines
            if not line.strip() or line.strip().startswith("//"):
                continue
            
            self.check_hard_coded_connections(line, file_path, line_num)
            self.check_static_connections(line, file_path, line_num)

    def check_uvm_environment(self):
        """
        Traverses through all the SystemVerilog files in the specified directory
        and checks for hard-coded and static connections.
        """
        for root, dirs, files in os.walk(self.directory):
            for file in files:
                if file.endswith(".sv"):  # Only check SystemVerilog files
                    file_path = os.path.join(root, file)
                    self.check_connections_in_file(file_path)


if __name__ == "__main__":
    # Replace with your UVM code directory path
    uvm_directory = "/home/dy/IC/basic/uvm_basic_v7_sequence/V1_conncet_seq_and_drv"
    uvm_checker = UVMConnectionChecker(uvm_directory)
    uvm_checker.check_uvm_environment()
