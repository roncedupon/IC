def modify_uvm_code_in_file(input_file, new_name):
    # Read the original code from the input file
    with open(input_file, 'r') as file:
        code = file.read()

    # Replace the <CLASS_NAME> placeholder with the new name
    modified_code = code.replace('<CLASS_NAME>', new_name)

    # Write the modified code to a new file
    output_file = f"modified_{input_file}"
    with open(output_file, 'w') as file:
        file.write(modified_code)

    print(f"Modified code saved to {output_file}")

# Example usage
input_file = 'virtual_sequencer.sv'  # Your original file
new_name = 'my_virtual_sequencer'  # New class name
modify_uvm_code_in_file(input_file, new_name)

#%%
A=[[1,2,3],[4,5,6]]
B=[[7,7,7],[7,7,7]]
for i in range(2):
    print(A[i]+B[i])