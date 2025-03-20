#py 多线程
from multiprocessing import Process
import time

def task(name):
    print(f'Process {name} is starting')
    time.sleep(4)  # 模拟耗时操作
    print(f'Process {name} is finished')

if __name__ == '__main__':
    processes = []
    for i in range(3):
        process = Process(target=task, args=(f"{i+1}",))
        processes.append(process)
        process.start()  # 启动进程

    for process in processes:
        process.join()  # 等待所有进程完成

    print("All processes are finished.")
