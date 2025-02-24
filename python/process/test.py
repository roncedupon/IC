import time
import multiprocessing

def worker():
    """模拟一个正在运行的进程"""
    print(f"Process {multiprocessing.current_process().name} started")
    time.sleep(60)  # 每个进程执行 60 秒的休眠，模拟长期运行的进程
    print(f"Process {multiprocessing.current_process().name} finished")

def create_processes(num_processes):
    processes = []
    for i in range(num_processes):
        p = multiprocessing.Process(target=worker, name=f"worker_{i}")
        processes.append(p)
        p.start()

    return processes

if __name__ == "__main__":
    # 创建 10 个进程
    create_processes(10)
    print("10 processes created. These will run for 60 seconds.")
    time.sleep(60)  # 让主进程等待 60 秒，期间可以在命令行杀掉这些进程


#使用top -u dy 查看特定用户的进程
#使用pkill -u dy python 杀掉全部命令为python的进程