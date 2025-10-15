import subprocess
from collections import deque
from multiprocessing import Pool
import os

MAX_LINES = 10000  # 日志文件保留的最大行数

def run_task(task):
    log_file = f"{task}.log"
    buf = deque(maxlen=MAX_LINES)

    # 启动子进程
    with subprocess.Popen(
        task,
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        universal_newlines=True,
        bufsize=1
    ) as proc:
        for line in proc.stdout:
            buf.append(line.rstrip())

            # 每 100 行刷新一次文件，防止频繁写
            if len(buf) % 100 == 0:
                with open(log_file, "w") as f:
                    f.write("\n".join(buf) + "\n")

        # 最后写一次，保证完整
        with open(log_file, "w") as f:
            f.write("\n".join(buf) + "\n")

    return proc.returncode

def parallel_run(task_list, max_processes=4):
    with Pool(processes=max_processes) as pool:
        pool.map(run_task, task_list)

if __name__ == "__main__":
    tasks = [
        "python3 your_script1.py",
        "python3 your_script2.py"
    ]
    parallel_run(tasks, max_processes=2)
