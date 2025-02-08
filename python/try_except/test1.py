import subprocess
post_check_cmd="ll"
def try_except():
    try:
        post_check_result = subprocess.run(
            post_check_cmd,
            shell=True,
            timeout=600,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        print("post_check finish", post_check_result.stdout)

        with open("post_check.log", "r") as f:
            lines = f.readlines()
            for line in lines:
                if "not eq" in line:
                    return "size mismatched"

        with open("cmodel_data_check.log", "r") as f:
            lines = f.readlines()
            for line in lines:
                if "failed" in line:
                    return "failed"
    except subprocess.TimeoutExpired as e:
        print("post_check timeout", e.output[:56])
        return "timeout"
    except FileNotFoundError:
        print("no check")
        return "no check"
    # 继续执行其他代码
    print("继续执行其他代码")
try_except()

#%%
import os
print(os.getcwd())
if "mnt" in os.getcwd():
    print("hh")
