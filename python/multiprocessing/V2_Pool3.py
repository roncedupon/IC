import multiprocessing
import time

# 示例任务函数
def task(name, sleep_time):
    print(f"Process {name} started, will run for {sleep_time} seconds.")
    time.sleep(sleep_time)
    print(f"Process {name} completed.")
    return name

def run_tasks_with_timeout():
    # 定义最大进程数
    max_processes = 3
    tasks = [
        ("Task1", 2),  # 任务名称和睡眠时间
        ("Task2", 6),
        ("Task3", 1),
        ("Task4", 8),
        ("Task5", 4),
        ("Task6", 3),
    ]

    # 创建进程池，设置最大进程数
    pool = multiprocessing.Pool(processes=max_processes)

    results = []

    for task_args in tasks:
        # 使用 apply_async 异步调用任务，并设置回调函数
        result = pool.apply_async(task, task_args)
        results.append(result)

    # 检查每个任务是否超时
    for i, result in enumerate(results):
        try:
            # 获取任务结果，设置超时时间为 5 秒
            result.get(timeout=5)
        except multiprocessing.TimeoutError:
            print(f"Task {tasks[i][0]} exceeded time limit and was terminated.")

    # 关闭进程池并等待所有进程完成
    pool.close()
    pool.join()

if __name__ == "__main__":
    run_tasks_with_timeout()
