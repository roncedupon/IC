from multiprocessing import Pool
import time

def task(n):
    print(f'Processing task {n}')
    time.sleep(2)  # 模拟耗时操作
    return f'Task {n} completed'

if __name__ == '__main__':
    with Pool(processes=3) as pool:  # 同时最多允许3个进程
        results = pool.map(task, range(5))
    print(results)
