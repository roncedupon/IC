#!/usr/bin/env python3
import argparse
import re
import sys


def parse_uvm_print_file(file_path):
    """Parse UVM print() output file and extract variable information for each transaction"""
    transactions = []
    current_transaction = {}
    
    with open(file_path, 'r') as f:
        for line in f:
            line = line.strip()
            # Detect transaction start
            if re.match(r'\*\*\* Transaction:', line):
                if current_transaction:
                    transactions.append(current_transaction)
                    current_transaction = {}
            # Detect variable lines
            var_match = re.match(r'\s*(\w+)\s*:\s*(.*)', line)
            if var_match:
                var_name = var_match.group(1)
                var_value = var_match.group(2)
                # Try to convert value to appropriate type
                try:
                    if var_value.startswith('0x'):
                        var_value = int(var_value, 16)
                    else:
                        var_value = int(var_value)
                except ValueError:
                    # Keep as string type
                    pass
                current_transaction[var_name] = var_value
    
    # Add the last transaction
    if current_transaction:
        transactions.append(current_transaction)
    
    return transactions


def evaluate_expression(transaction, expression):
    """Evaluate if expression is true for the transaction"""
    # Create a local dictionary with transaction variables
    local_vars = {}
    for key, value in transaction.items():
        # Replace special characters in variable names with underscores to comply with Python naming rules
        safe_var_name = re.sub(r'[^a-zA-Z0-9_]', '_', key)
        local_vars[safe_var_name] = value
    
    # Replace variable names in expression with safe variable names
    modified_expression = expression
    for key in transaction.keys():
        safe_var_name = re.sub(r'[^a-zA-Z0-9_]', '_', key)
        # Use regex to ensure only complete variable names are replaced
        modified_expression = re.sub(r'\b' + re.escape(key) + r'\b', safe_var_name, modified_expression)
    
    try:
        return eval(modified_expression, {}, local_vars)
    except Exception as e:
        print(f"Error evaluating expression: {e}", file=sys.stderr)
        return False


def main():
    parser = argparse.ArgumentParser(description='Parse UVM print() output and filter based on expression')
    parser.add_argument('file', help='Path to file containing UVM print() output')
    parser.add_argument('-exp', required=True, help='Filter expression, e.g., "var1==10 && var2==20"')
    parser.add_argument('-o', required=True, help='Variable names to output values for, multiple variables separated by commas')
    
    args = parser.parse_args()
    
    # Parse the file
    transactions = parse_uvm_print_file(args.file)
    
    # Parse output variable list
    output_vars = [var.strip() for var in args.o.split(',')]
    
    # Process each transaction
    for i, transaction in enumerate(transactions):
        if evaluate_expression(transaction, args.exp):
            print(f"Transaction {i+1}:")
            for var in output_vars:
                if var in transaction:
                    print(f"  {var}: {transaction[var]}")
                else:
                    print(f"  {var}: NOT FOUND")
            print()


if __name__ == '__main__':
    main()


