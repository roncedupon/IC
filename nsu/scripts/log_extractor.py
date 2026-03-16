#!/usr/bin/env python3
import sys
import argparse
import re

def hex_to_binary(hex_str):
    """
    Convert hex string (with 'h prefix) to binary string.
    """
    # Remove 'h prefix
    hex_val = hex_str[2:]
    # Convert to binary
    binary = bin(int(hex_val, 16))[2:]
    # Pad with leading zeros to make it 8 bits for plane_pair_dec_result
    binary = binary.zfill(8)
    return binary

def count_ones_zeros(binary_str):
    """
    Count number of 1s and 0s in binary string.
    """
    ones = binary_str.count('1')
    zeros = binary_str.count('0')
    return ones, zeros

def extract_field_by_field_value(log_file_path, transaction_type, match_field, match_value, target_field):
    """
    Extract specified field from specified transaction type in log file
    for a specific field value, and count 1s and 0s in binary representation.
    Also count total 0s and 1s bits across all values for the field.
    """
    # Convert match_value to hex format with 'h prefix if it's in 0x format
    if match_value.startswith('0x'):
        match_value_hex = f"'h{match_value[2:]}"
    else:
        match_value_hex = match_value
    
    # Statistics
    total_values = 0
    total_ones = 0
    total_zeros = 0
    found = False
    
    try:
        with open(log_file_path, 'r') as f:
            lines = f.readlines()
        
        i = 0
        while i < len(lines):
            line = lines[i]
            
            # Check if this line contains the transaction type
            if transaction_type in line and 'integral' not in line:
                # Found a transaction of the target type
                # Now search for fields in this transaction
                j = i + 1
                current_match_value = None
                current_field_value = None
                
                # Search until we reach the end of the transaction
                while j < len(lines):
                    field_line = lines[j]
                    
                    # Check if we've reached the end of this transaction
                    if '===' in field_line or (field_line.strip() and not field_line.startswith(' ') and not field_line.startswith('.')):
                        break
                    
                    # Extract match field value - exact match
                    if re.search(r"\s" + re.escape(match_field) + r"\s+", field_line):
                        # Use a simple regex to extract the value
                        value_match = re.search(r"'h[0-9a-fA-F]+", field_line)
                        if value_match:
                            current_match_value = value_match.group(0)
                    
                    # Extract target field value - exact match
                    if re.search(r"\s" + re.escape(target_field) + r"\s+", field_line):
                        # Use a simple regex to extract the value
                        value_match = re.search(r"'h[0-9a-fA-F]+", field_line)
                        if value_match:
                            current_field_value = value_match.group(0)
                    
                    j += 1
                
                # Check if this transaction matches the target field value
                if current_match_value == match_value_hex and current_field_value is not None:
                    # Convert to binary and count 1s and 0s
                    binary = hex_to_binary(current_field_value)
                    ones, zeros = count_ones_zeros(binary)
                    print(f"{target_field} for {match_field} {match_value_hex}: {current_field_value}")
                    print(f"  Binary: {binary}")
                    print(f"  1s count: {ones}, 0s count: {zeros}")
                    
                    # Update statistics
                    total_values += 1
                    total_ones += ones
                    total_zeros += zeros
                    
                    found = True
            
            i += 1
        
        # Print statistics
        if found:
            total_bits = total_values * 8  # Assuming 8-bit field
            print(f"\n=== Statistics for {match_field} {match_value_hex} ===")
            print(f"Total values: {total_values}")
            print(f"Total bits: {total_bits}")
            print(f"Total 1s bits: {total_ones}")
            print(f"Total 0s bits: {total_zeros}")
            print(f"Verification: {total_ones + total_zeros} bits (should equal {total_bits})")
        else:
            print(f"No {target_field} found for {match_field} {match_value_hex} in {transaction_type}")
        
    except FileNotFoundError:
        print(f"Error: Log file not found at {log_file_path}")
        sys.exit(1)
    except Exception as e:
        print(f"Error processing log file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract field from log file by field value")
    parser.add_argument("log_file", help="Path to the log file")
    parser.add_argument("-t", "--transaction", required=True, help="Transaction type to search for (e.g., nsu2cpu_deep_resp_transaction, nsu2cpu_rcmd_transaction)")
    parser.add_argument("-m", "--match_field", required=True, help="Field to match (e.g., group0_ost_id, ost_id, sel_addr)")
    parser.add_argument("-v", "--match_value", required=True, help="Value to match for the field (e.g., 0x10 or 'h10)")
    parser.add_argument("-f", "--field", required=True, help="Field to extract (e.g., plane_pair_dec_result)")
    
    args = parser.parse_args()
    extract_field_by_field_value(args.log_file, args.transaction, args.match_field, args.match_value, args.field)
