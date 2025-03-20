import subprocess

def run_command(command):
    try:
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, check=True,shell=True)
        return result.stdout,result.stderr,result.returncode
    except subprocess.CalledProcessError as e:
        print(f"命令执行失败：{e}")
        print(f"返回码：{e.returncode}")
        print(f"标准输出：{e.stdout}")
        print(f"标准错误：{e.stderr}")
        return None,None,e.returncode

# Example usage (using a list for the command is generally safer):
stdout,stderr,returncode = run_command(['ls', '-l'])
if stdout:
    print("标准输出：")
    print(stdout)
if stderr:
    print("标准错误：")
    print(stderr)
print("返回码：",returncode)

stdout,stderr,returncode = run_command('ls -l /non_existent_directory')
if stdout:
    print("标准输出：")
    print(stdout)
if stderr:
    print("标准错误：")
    print(stderr)
print("返回码：",returncode)