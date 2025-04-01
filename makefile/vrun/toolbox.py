import os
import re

class toolbox:
    def __init__(self):
        pass
    def get_all_files(self, dir_path, pattern=None, recursive=True):
        """
        version: 20250401
        递归获取目录下所有文件路径（可选正则过滤）
        :param dir_path: 目标目录路径
        :param pattern: 正则表达式过滤模式（可选）
        :param recursive: 是否递归子目录
        :return: 文件路径列表
        -------------------------------------------------------------------
        使用：    
        tool = toolbox()
        files = tool.get_all_files(".", pattern=r"\.gitignore")
        print("Python files:", files)
        -------------------------------------------------------------------
        注意：
        1、这里输入的pattern是正则表达式，需要加r说明这是一个原始字符串，
            让py不处理转义字符\，因为正则表达式也需要用到转义字符
        2、需要正确使用正则表达式，.gitignore会匹配出各种牛马蛇神，比如Aignore,Bignore....
            如果只需要查找.gitignore，则需要用\.gitignore
        """
        file_list = []
        dir_path=os.path.abspath(dir_path)
        try:
            # 参数校验
            if not os.path.isdir(dir_path):
                raise ValueError(f"Invalid directory path: {dir_path}")
            # 编译正则表达式（如果提供）
            regex = re.compile(pattern) if pattern else None
            # 遍历目录
            for root, dirs, files in os.walk(dir_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    
                    # 正则匹配过滤
                    if regex and not regex.search(file):
                        continue
                        
                    file_list.append(file_path)
                # 如果不递归则只处理当前目录
                if not recursive:
                    break
        except Exception as e:
            print(f"Error scanning directory: {e}")
            return []
        return file_list
# 使用示例
if __name__ == "__main__":
    
    
    pass