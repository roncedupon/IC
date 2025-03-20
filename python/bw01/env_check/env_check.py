import re
from collections import defaultdict


class env_check():
    def __init__(slef):
        pass

class DefineConditionParser:
    def __init__(self, input_file):
        """
        Initialize the parser with the input file.
        
        :param input_file: Path to the input file to be parsed.
        """
        self.input_file = input_file
        self.all_conditions_by_file = defaultdict(list)
        self.merged_conditions_by_file = defaultdict(list)
        self.merge_conditions=defaultdict(dict)
        self.seen_conditions = defaultdict(set)
        self.condition_set = []  # 用于存储每个 define 的值，检查冲突
        
        # Regular expression patterns
        self.file_path_pattern = r"(/[\w/.-]+)"
        self.condition_pattern = r"`\s*(ifdef|ifndef)\s+(\S+)\s+is\s+(TRUE|FALSE)"
        
    def parse_file(self):
        """Parse the file and extract condition definitions."""
        try:
            with open(self.input_file, 'r') as file:
                lines = file.readlines()

            for line_number, line in enumerate(lines, start=1):
                # Search for file path in the line
                file_path_match = re.search(self.file_path_pattern, line)
                # Search for condition match (ifdef/ifndef)
                condition_match = re.search(self.condition_pattern, line)

                if file_path_match and condition_match:
                    # Extract file path and condition details
                    file_path = file_path_match.group(1)
                    condition_type = condition_match.group(1)
                    condition_name = condition_match.group(2)
                    condition_value = condition_match.group(3)

                    # Store the condition categorized by file path
                    self.all_conditions_by_file[file_path].append((line_number, condition_type, condition_name, condition_value))

                    # 去重处理：如果条件未见过，则记录
                    if (condition_name, condition_value) not in self.seen_conditions[file_path]:
                        self.seen_conditions[file_path].add((condition_name, condition_value))
                        self.merged_conditions_by_file[file_path].append((line_number, condition_type, condition_name, condition_value))



        except FileNotFoundError:
            print(f"Error: The file {self.input_file} was not found.")
        except Exception as e:
            print(f"An error occurred while parsing the file: {e}")
        print("parse_end")

    # 将字典中的所有values合并成一个list
    def flatten_dict_to_list(self,dictionary):
        flattened_list = []
        for key, value in dictionary.items():
            if isinstance(value, list):
                flattened_list.extend(value)  # 将列表中的元素添加到结果列表中
            elif isinstance(value, dict):
                flattened_list.extend(self.flatten_dict_to_list(value))  # 如果是嵌套字典，递归调用
            else:
                flattened_list.append(value)  # 否则直接添加值
        return flattened_list


    def merge_all_files(self,define_dict):
        condition_all=self.flatten_dict_to_list(define_dict)
        
        for i,item in enumerate(condition_all):
            condition_all[i]=item[1:]
        
        condition_all_sets=set(condition_all)

        conflict_dectector=[]
        with open("output_conditions_merged_all.txt","w")as file:
            for item in condition_all_sets:
                tmp=" ".join([tuple_data for tuple_data in item[:-1]])
                if tmp in conflict_dectector:
                    print(f"conflict detected:{tmp}")
                    self.print_error_msg(tmp,condition_all_sets)
                conflict_dectector.append(tmp)
                file.write(" ".join([tuple_data for tuple_data in item])+"\n")

        return condition_all_sets
    def print_error_msg(self,conflict_data,condition_all_sets):
        for item in condition_all_sets:
            if conflict_data == item[:-1]:
                print(item)
            
    
    def save_conditions(self, output_file,define_dict):
        """Save parsed condition information to an output file."""
        try:
            with open(output_file, 'w') as output:
                for file_path, conditions in define_dict.items():
                    output.write(f"File: {file_path}\n")
                    for condition in conditions:
                        output.write(f"  Line {condition[0]}: Condition: {condition[1]} {condition[2]} is {condition[3]}\n")
                    output.write("\n")
            print(f"Conditions saved to {output_file}")
        except Exception as e:
            print(f"An error occurred while saving conditions: {e}")
    


# Example usage
if __name__ == "__main__":
    # Initialize the parser with the input file path
    parser = DefineConditionParser(input_file='./vcs_output/rawtokens_macros.expand')
    
    # Parse the file
    parser.parse_file()
    parser.merge_all_files(parser.merged_conditions_by_file)
    # Save the parsed conditions to a file
    # parser.save_conditions(output_file='output_conditions_all.txt',define_dict=parser.all_conditions_by_file)
    parser.save_conditions(output_file='output_conditions_merged.txt',define_dict=parser.merged_conditions_by_file)   


#%%
my_dict = {'a': 1, 'b': 2, 'c': 3}
my_dict = {key: value for key, value in my_dict.items() if key != 'b'}
print(my_dict)
