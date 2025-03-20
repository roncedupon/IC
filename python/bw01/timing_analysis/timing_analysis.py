import argparse
import re
from collections import defaultdict
import os
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from datetime import datetime
import matplotlib.colors as mcolors
from openpyxl import Workbook
class timing_analysis():
    def __init__(self):
        self.start_pattern = re.compile(r"(\w+)_START!!!! time = (\d+\.\d+) ns")
        self.done_pattern = re.compile(r"(\w+)_DONE!!!! time = (\d+\.\d+) ns")

    def timing_analysis_main(self, in_file_dir, in_file_name):
        start_times = {}
        total_time = defaultdict(float)
        modules_data = []  # List to store start and end times for each module
        module_details = []  # 

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
                        # Store data for plotting
                        modules_data.append((module, start_times[module], time))
                        module_details.append((module, start_times[module], time, elapsed_time))
                        del start_times[module]  

        # summary
        print("SUMMARY:")
        for module, time in total_time.items():
            print(f"{module}: {time:.3f} ns")

        #plot gant
        self.plot_gantt(modules_data,"gantt_chart.png")
        self.save_to_excel(module_details, "timing_analysis.xls")

    def plot_gantt(self, modules_data, output_image_path):
        # Prepare data for Gantt chart
        fig, ax = plt.subplots(figsize=(12, 6))

        # Get a list of unique modules to assign colors
        unique_modules = list(set([module for module, _, _ in modules_data]))
        colors = list(mcolors.TABLEAU_COLORS.values())

        module_to_color = {module: colors[i % len(colors)] for i, module in enumerate(unique_modules)}

        for i, (module, start_time, end_time) in enumerate(modules_data):
            ax.barh(module, end_time - start_time, left=start_time, height=0.6, align='center', color=module_to_color[module])

        # Format the x-axis as time (in ns)
        ax.xaxis.set_major_formatter(plt.FuncFormatter(lambda x, _: f"{x:.0f} ns"))

        # invert yaxis
        ax.invert_yaxis()

        # set timescale
        max_time = max([end_time for _, _, end_time in modules_data])
        min_time = max([min_time for _, min_time, _ in modules_data])
        ax.set_xlim(0, max_time * 1.1)

        # 
        # ax.set_xscale('log')
        ax.set_xlabel('Time (ns)')
        ax.set_ylabel('Module')
        ax.set_title('Gantt Chart of Module Execution')

        # 添加图例
        handles = [plt.Line2D([0], [0], marker='o', color='w', markerfacecolor=color, markersize=10, label=module) 
                for module, color in module_to_color.items()]
        ax.legend(handles=handles, title="Modules", loc="upper left", bbox_to_anchor=(1.05, 1.0))  # 图例移到坐标框外

        # 改善布局，避免标签被遮挡
        plt.tight_layout()

        #save as png
        fig.savefig(output_image_path, dpi=300)
        print(f"gantplot saved as {output_image_path}")

    def save_to_excel(self, module_details, output_file):
        # create workbook
        wb = Workbook()
        ws = wb.active
        ws.title = "Timing Analysis"

        # write head
        headers = ["Module", "Start Time (ns)", "End Time (ns)", "Elapsed Time (ns)"]
        ws.append(headers)

        # write data
        for detail in module_details:
            ws.append(detail)

        # save excel
        wb.save(output_file)
        print(f"summary saved as {output_file}")
def cfg_args():
    parser=argparse.ArgumentParser(description="")
    parser.add_argument("-i",metavar="",help="path")
    args=parser.parse_args()
    return args
if __name__ == "__main__":
    timing_analysis_inst = timing_analysis()
    args=cfg_args()
    timing_analysis_inst.timing_analysis_main(os.path.dirname(args.i),os.path.basename(args.i))
