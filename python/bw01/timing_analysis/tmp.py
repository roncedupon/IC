import re
from collections import defaultdict
import os
import matplotlib.pyplot as plt

class timing_analysis():
    def __init__(self):
        self.start_pattern = re.compile(r"(\w+)_START!!!! time = (\d+\.\d+) ns")
        self.done_pattern = re.compile(r"(\w+)_DONE!!!! time = (\d+\.\d+) ns")

    def parse_log(self, in_file_dir, in_file_name):
        start_times = {}
        total_time = defaultdict(float)

        # reading log
        with open(os.path.join(in_file_dir, in_file_name), "r") as f:
            for line in f:
                # extract start
                start_match = self.start_pattern.search(line)
                if start_match:
                    module = start_match.group(1)
                    time = float(start_match.group(2))
                    start_times[module] = time  # record start

                # extract done
                done_match = self.done_pattern.search(line)
                if done_match:
                    module = done_match.group(1)
                    time = float(done_match.group(2))
                    # if done matches start, accumulate the whole time for specified module
                    if module in start_times:
                        elapsed_time = time - start_times[module]
                        total_time[module] += elapsed_time  # accumulate
                        del start_times[module]

        # 输出各个模块的总耗时
        print("模块的总耗时统计：")
        for module, time in total_time.items():
            print(f"{module}: {time:.3f} ns")

        # 绘制甘特图
        self.plot_gantt_chart(total_time)

    def plot_gantt_chart(self, total_time):
        modules = list(total_time.keys())
        times = list(total_time.values())

        fig, ax = plt.subplots()
        y_pos = range(len(modules))

        ax.barh(y_pos, times, align='center', color='skyblue')
        ax.set_yticks(y_pos)
        ax.set_yticklabels(modules)
        ax.invert_yaxis()  # 从上到下显示
        ax.set_xlabel('Time (ns)')
        ax.set_title('Module Timing Gantt Chart')

        plt.show()

if __name__ == "__main__":
    timing_analysis_inst = timing_analysis()
    timing_analysis_inst.parse_log("./", "log.txt")