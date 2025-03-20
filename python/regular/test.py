#%%
import re

# 从图片中提供的模板
start_pattern = re.compile(r" (\w+)_START!!!! time\s*=\s*(\d+)\s*(ns|ps|us|ms|fs)?,")
done_pattern = re.compile(r"(\w+) DONE!!!! time\s*=\s*(\d+)\s*(ns|ps|us|ms|fs)?,")

# 示例日志行
log_lines_start = [
    " worker_thread_1_START!!!! time=1676787949123456789ns,",
    "  image_processing_START!!!! time=1700550000000000us,",
    " main_job_START!!!! time=1234567890123 ms,",
    " http_request_handler_START!!!! time=9876543210fs,",
    " database_backup_START!!!! time=1645234567890ps,"
]

log_lines_done = [
    "worker_thread_1 DONE!!!! time=1676787952345678901 ns,",
    " image_processing DONE!!!! time=1700550001500000 us,",
    "main_job DONE!!!! time=1234567900000 ms,",
    "http_request_handler DONE!!!! time=9876543215 fs,",
    "database_backup DONE!!!! time=1645234570000 ps,"
]

print("开始事件日志解析示例:")
for log_line in log_lines_start:
    match = start_pattern.match(log_line)
    if match:
        task_name = match.group(1)
        timestamp = match.group(2)
        time_unit = match.group(3) if match.group(3) else "unknown" # 时间单位可能是可选的
        print(f"日志行: '{log_line.strip()}'")
        print(f"  任务名称: {task_name}")
        print(f"  时间戳: {timestamp}")
        print(f"  时间单位: {time_unit}")
        print("-" * 20)
    else:
        print(f"日志行 '{log_line.strip()}' **不匹配** start_pattern")
        print("-" * 20)

print("\n完成事件日志解析示例:")
for log_line in log_lines_done:
    match = done_pattern.match(log_line)
    if match:
        task_name = match.group(1)
        timestamp = match.group(2)
        time_unit = match.group(3) if match.group(3) else "unknown" # 时间单位可能是可选的
        print(f"日志行: '{log_line.strip()}'")
        print(f"  任务名称: {task_name}")
        print(f"  时间戳: {timestamp}")
        print(f"  时间单位: {time_unit}")
        print("-" * 20)
    else:
        print(f"日志行 '{log_line.strip()}' **不匹配** done_pattern")
        print("-" * 20)