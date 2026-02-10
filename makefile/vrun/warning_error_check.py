import os
import re

# ===================== 可扩展接口 - 核心新增部分 =====================
# 全局匹配模式池（包含原有规则 + 用户自定义规则）
match_patterns = []

def add_custom_pattern(pattern_str, flags=re.IGNORECASE):
    """
    Interface to add custom regex patterns for error/warning matching.
    【User Interface】: Call this function to add your custom error patterns.
    
    Args:
        pattern_str (str): Custom regex string (e.g., r'^\s*MY_ERROR:.+')
        flags (re.RegexFlag): Regex flags (default: re.IGNORECASE)
    """
    try:
        custom_pattern = re.compile(pattern_str, flags)
        match_patterns.append(custom_pattern)
        print(f"Successfully added custom pattern: {pattern_str}")
    except re.error as e:
        print(f"Failed to add custom pattern | Invalid regex: {pattern_str} | Error: {str(e)}")

# ===================== 初始化原有默认规则 =====================
# 1. UVM_WARNING / UVM_ERROR (original rule)
uvm_pattern = re.compile(
    r'^\s*UVM_(WARNING|ERROR)\s+.+\(\d+\)\s+@\s*\d+(\.\d+)?ns:.+',
    re.IGNORECASE
)
# 2. Regular ERROR (original rule)
error_pattern = re.compile(
    r'^\s*ERROR:\s*\[\d+(\.\d+)?ns\]\s+.+',
    re.IGNORECASE
)
# Add default patterns to pattern pool
match_patterns.extend([uvm_pattern, error_pattern])

# ===================== 数据存储与工具函数 =====================
# Store all unique entries after normalization:
# key = normalized string
# value = {
#   "type": "UVM_WARNING" / "UVM_ERROR" / "ERROR" / "CUSTOM",
#   "original_lines": list of original lines,
#   "sources": list of source folder paths
# }
log_entries = {}
add_custom_pattern(r'^\s*MY_ERROR:\s*.+')
def normalize_line(line):
    """Normalize log line by removing variable parts (timestamp, index, line num)"""
    # Remove log entry number (e.g., [10437])
    line = re.sub(r'^\[\d+\]\s*', '', line)
    # Remove duplicate UVM prefix (e.g., UVM_WARNING: UVM_WARNING)
    line = re.sub(r'UVM_(WARNING|ERROR):\s*UVM_\1', r'UVM_\1', line, flags=re.IGNORECASE)
    # Remove line number in parentheses (e.g., (162))
    line = re.sub(r'\(\d+\)', '', line)
    # Remove test index in brackets (e.g., [0], [1])
    line = re.sub(r'\[\d+\]', '', line)
    # Remove timestamp (e.g., @ 494369.000ns or [47370719.206ns])
    line = re.sub(r'(@\s*\d+(\.\d+)?ns|\[\d+(\.\d+)?ns\])', '', line)
    # Strip extra whitespace
    return line.strip()

def get_entry_type(line):
    """Determine log entry type (UVM_WARNING/UVM_ERROR/ERROR/CUSTOM)"""
    line_lower = line.lower()
    if 'uvm_warning' in line_lower:
        return "UVM_WARNING"
    elif 'uvm_error' in line_lower:
        return "UVM_ERROR"
    elif line_lower.startswith('error:'):
        return "ERROR"
    else:
        return "CUSTOM"  # For user-defined error patterns

# ===================== 目录遍历与日志处理 =====================
def process_directory(current_dir, max_depth, current_depth=0):
    """Recursively process directories with depth control"""
    if current_depth > max_depth:
        return

    for item in os.listdir(current_dir):
        item_path = os.path.join(current_dir, item)

        if os.path.isdir(item_path):
            item_abs_path = os.path.abspath(item_path)
            log_file_name = f"{item}.log"
            log_file_path = os.path.join(item_abs_path, log_file_name)

            if os.path.exists(log_file_path):
                try:
                    with open(log_file_path, 'r', encoding='utf-8', errors='ignore') as f:
                        lines = f.readlines()
                    matched_count = 0
                    for line in lines:
                        line_stripped = line.strip()
                        if not line_stripped:
                            continue

                        # Check if line matches ANY pattern in the pattern pool
                        is_matched = False
                        for pattern in match_patterns:
                            if pattern.match(line_stripped):
                                is_matched = True
                                break

                        if is_matched:
                            entry_type = get_entry_type(line_stripped)
                            normalized_key = normalize_line(line_stripped)
                            
                            if normalized_key not in log_entries:
                                log_entries[normalized_key] = {
                                    "type": entry_type,
                                    "original_lines": [line_stripped],
                                    "sources": [item_abs_path]
                                }
                            else:
                                # Avoid duplicate original lines
                                if line_stripped not in log_entries[normalized_key]["original_lines"]:
                                    log_entries[normalized_key]["original_lines"].append(line_stripped)
                                # Avoid duplicate source paths
                                if item_abs_path not in log_entries[normalized_key]["sources"]:
                                    log_entries[normalized_key]["sources"].append(item_abs_path)
                            matched_count += 1
                    print(f"Processed [{item_abs_path}/{log_file_name} | Found {matched_count} matching entries")
                except Exception as e:
                    print(f"Failed to read [{item_abs_path}] / {log_file_name} | Error: {str(e)}")
            # else:
            #     print(f"Log file {log_file_name} not found in [{item_abs_path}], skipped")

            # Recurse to subdirectory (depth +1)
            process_directory(item_path, max_depth, current_depth + 1)

# ===================== 结果保存 =====================
def save_results_to_file(output_file="log_analysis_result.txt"):
    """Save analysis results to file (grouped by entry type)"""
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("===== Log Analysis Results =====\n")
            f.write(f"Total unique entries (normalized): {len(log_entries)}\n")
            f.write(f"Total matching patterns: {len(match_patterns)} (default: 2 + custom: {len(match_patterns)-2})\n")
            f.write(f"Generated at: {os.path.abspath(output_file)}\n")
            f.write("=" * 60 + "\n\n")

            # Group entries by type for better readability
            type_groups = {}
            for key, data in log_entries.items():
                entry_type = data["type"]
                type_groups[entry_type] = type_groups.get(entry_type, []) + [(key, data)]

            # Write grouped results
            for entry_type, entries in sorted(type_groups.items()):
                f.write(f"=== {entry_type} ({len(entries)} unique entries) ===\n\n")
                for idx, (normalized_key, data) in enumerate(entries, 1):
                    f.write(f"[{idx}] Normalized content:\n{normalized_key}\n\n")
                    f.write(f"Original occurrences ({len(data['original_lines'])}):\n")
                    for orig_line in data['original_lines']:
                        f.write(f"  - {orig_line}\n")
                    f.write(f"\nSource directories ({len(data['sources'])}):\n")
                    for path in data['sources']:
                        f.write(f"  - {path}\n")
                    f.write("\n" + "-" * 60 + "\n\n")
        
        print(f"\nResults saved to: {os.path.abspath(output_file)}")
    except Exception as e:
        print(f"Failed to save results | Error: {str(e)}")

# ===================== 主函数 =====================
def main(root_dir='.', max_depth=2):
    print(f"=== Starting Log Analysis ===\nRoot directory: {os.path.abspath(root_dir)}\nMax depth: {max_depth}\n")
    process_directory(root_dir, max_depth)
    print(f"\n=== Traversal Completed ===\nTotal unique entries (normalized): {len(log_entries)}")
    save_results_to_file()

# ===================== 用户使用示例 =====================
if __name__ == "__main__":
    # --------------------------
    # Step 1: Add custom patterns (USER INTERFACE)
    # --------------------------
    # Example 1: Add custom error pattern (e.g., "MY_ERROR: xxx")
    add_custom_pattern(r'^\s*MY_ERROR:\s*.+')
    
    # Example 2: Add another custom pattern (e.g., "CUSTOM_ERR[123]: xxx")
    add_custom_pattern(r'^\s*CUSTOM_ERR\[\d+\]:\s*.+')

    # --------------------------
    # Step 2: Run analysis (default depth=2)
    # --------------------------
    main()

    # Optional: Run with custom depth (e.g., 3)
    # main(max_depth=3)