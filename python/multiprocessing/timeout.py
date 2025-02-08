import multiprocessing
import time
import os

# 示例任务函数，模拟执行时间不同的任务
def task(name, sleep_time):
    print(f"Process {name} started with PID {os.getpid()}, will run for {sleep_time} seconds.")
    time.sleep(sleep_time)  # 模拟任务执行
    print(f"Process {name} completed.")
    return name


if __name__ == "__main__":
    task("mytask", 10)
