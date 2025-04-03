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
import math

class DataConverter:
    """
    A class to handle conversions between binary, hexadecimal, and decimal formats,
    and to extract specific bit ranges from data.
    """

    def bin2hex(self, bin_str: str) -> str:
        """
        Converts a binary string to its hexadecimal representation.

        Args:
            bin_str: The binary string (e.g., "11010110").

        Returns:
            The hexadecimal string representation (e.g., "D6").

        Raises:
            ValueError: If the input is not a valid binary string.
        """
        if not all(c in '01' for c in bin_str):
            raise ValueError(f"Invalid binary string: {bin_str}")
        if not bin_str:
            return ""
        dec_val = self.bin2dec(bin_str)
        hex_val = hex(dec_val)[2:] # Remove "0x" prefix
        # Ensure proper hex length (pad with leading zero if necessary)
        num_hex_chars = math.ceil(len(bin_str) / 4)
        return hex_val.upper().zfill(num_hex_chars)

    def bin2dec(self, bin_str: str) -> int:
        """
        Converts a binary string to its decimal integer representation.

        Args:
            bin_str: The binary string (e.g., "11010110").

        Returns:
            The decimal integer value (e.g., 214).

        Raises:
            ValueError: If the input is not a valid binary string.
        """
        if not all(c in '01' for c in bin_str):
            raise ValueError(f"Invalid binary string: {bin_str}")
        if not bin_str:
            return 0
        return int(bin_str, 2)

    def hex2bin(self, hex_str: str, min_bits: int = 0) -> str:
        """
        Converts a hexadecimal string to its binary representation.
        Pads with leading zeros to ensure each hex digit corresponds to 4 bits,
        or to meet the minimum number of bits specified.

        Args:
            hex_str: The hexadecimal string (e.g., "D6", "0xD6"). Case-insensitive.
                     Can optionally start with "0x".
            min_bits: The minimum number of bits the output binary string should have.
                      Padding with leading zeros if necessary.

        Returns:
            The binary string representation (e.g., "11010110").

        Raises:
            ValueError: If the input is not a valid hexadecimal string.
        """
        if hex_str.startswith("0x") or hex_str.startswith("0X"):
            hex_str = hex_str[2:]
        if not all(c in '0123456789abcdefABCDEF' for c in hex_str):
            raise ValueError(f"Invalid hexadecimal string: {hex_str}")
        if not hex_str:
            return "".zfill(min_bits)

        dec_val = self.hex2dec(hex_str)
        bin_val = bin(dec_val)[2:] # Remove "0b" prefix

        # Calculate required bits based on hex length, ensure minimum bits
        required_bits = max(len(hex_str) * 4, min_bits)
        return bin_val.zfill(required_bits) # Pad with leading zeros

    def hex2dec(self, hex_str: str) -> int:
        """
        Converts a hexadecimal string to its decimal integer representation.

        Args:
            hex_str: The hexadecimal string (e.g., "D6", "0xD6"). Case-insensitive.
                     Can optionally start with "0x".

        Returns:
            The decimal integer value (e.g., 214).

        Raises:
            ValueError: If the input is not a valid hexadecimal string.
        """
        if hex_str.startswith("0x") or hex_str.startswith("0X"):
            hex_str = hex_str[2:]
        if not all(c in '0123456789abcdefABCDEF' for c in hex_str):
             raise ValueError(f"Invalid hexadecimal string: {hex_str}")
        if not hex_str:
            return 0
        return int(hex_str, 16)

    def dec2hex(self, dec_int: int) -> str:
        """
        Converts a decimal integer to its hexadecimal string representation.

        Args:
            dec_int: The decimal integer (e.g., 214).

        Returns:
            The hexadecimal string representation (e.g., "D6").

        Raises:
            TypeError: If the input is not an integer.
        """
        if not isinstance(dec_int, int):
            raise TypeError("Input must be an integer.")
        if dec_int < 0:
             raise ValueError("Input must be a non-negative integer for standard hex conversion.")
        return hex(dec_int)[2:].upper() # Remove "0x" prefix and uppercase

    def dec2bin(self, dec_int: int, min_bits: int = 0) -> str:
        """
        Converts a decimal integer to its binary string representation.

        Args:
            dec_int: The decimal integer (e.g., 214).
            min_bits: The minimum number of bits the output should have. Pads with leading zeros.

        Returns:
            The binary string representation (e.g., "11010110").

        Raises:
            TypeError: If the input is not an integer.
            ValueError: If the input is negative.
        """
        if not isinstance(dec_int, int):
            raise TypeError("Input must be an integer.")
        if dec_int < 0:
            raise ValueError("Input must be a non-negative integer for standard binary conversion.")

        bin_str = bin(dec_int)[2:] # Remove "0b" prefix
        return bin_str.zfill(min_bits) # Pad if necessary

    def binary_process(self, input_data: str, msb: int, lsb: int, input_format: str = "hex", output_format: str = "hex") -> str | int:
        """
        Extracts a range of bits (from LSB to MSB, inclusive) from input data
        (given as hex or binary) and returns the extracted value in the desired format.

        Bit numbering assumes LSB is bit 0.

        Example:
            input_data = "1AC" (hex) -> "000110101100" (binary)
            msb = 7, lsb = 4
            The bits are (from right, 0-indexed):
            ... Bit 7: 1
            ... Bit 6: 0
            ... Bit 5: 1
            ... Bit 4: 0
            ...
            Extracted bits (msb down to lsb): 1010
            Result in hex: "A"
            Result in dec: 10

        Args:
            input_data: The input data string (either hex or binary).
            msb: The Most Significant Bit position (inclusive, 0-indexed).
            lsb: The Least Significant Bit position (inclusive, 0-indexed).
            input_format: The format of input_data ("hex" or "bin"). Default is "hex".
            output_format: The desired output format ("hex", "dec", or "bin"). Default is "hex".

        Returns:
            The extracted data in the specified output format (string for hex/bin, int for dec).

        Raises:
            ValueError: If input format is invalid, data is invalid for its format,
                        or if MSB/LSB values are invalid or out of range.
            NotImplementedError: If the output format is not supported.
        """
        if lsb < 0 or msb < lsb:
            raise ValueError(f"Invalid bit range: LSB={lsb}, MSB={msb}. Requires MSB >= LSB >= 0.")

        # 1. Convert input data to binary string
        if input_format.lower() == "hex":
            bin_str = self.hex2bin(input_data)
        elif input_format.lower() == "bin":
            # Validate binary input
            if not all(c in '01' for c in input_data):
                 raise ValueError(f"Invalid binary string provided for input_format='bin': {input_data}")
            bin_str = input_data
        else:
            raise ValueError(f"Unsupported input_format: {input_format}. Use 'hex' or 'bin'.")

        # Ensure input was not empty resulting in empty bin_str if lsb/msb require bits
        if not bin_str and (msb >= 0 or lsb >= 0):
             raise ValueError("Input data is empty, cannot extract bits.")

        # 2. Check if MSB is within the bounds of the binary string
        num_bits = len(bin_str)
        if msb >= num_bits:
            raise ValueError(f"MSB ({msb}) is out of range for the input data which has {num_bits} bits.")

        # 3. Extract the relevant bits
        # Indices are calculated from the left (standard string slicing)
        # Bit position 'p' (0-indexed from LSB) corresponds to index 'num_bits - 1 - p'
        start_index = num_bits - 1 - msb
        end_index = num_bits - 1 - lsb + 1 # Slice goes up to, but not including, end_index

        if start_index < 0 or end_index > num_bits:
             # This shouldn't happen if previous checks passed, but good for safety
             raise ValueError("Calculated slice indices are out of bounds.")

        extracted_bin = bin_str[start_index:end_index]

        # 4. Convert extracted binary to the desired output format
        if output_format.lower() == "hex":
            return self.bin2hex(extracted_bin)
        elif output_format.lower() == "dec":
            return self.bin2dec(extracted_bin)
        elif output_format.lower() == "bin":
            return extracted_bin
        else:
            raise NotImplementedError(f"Unsupported output_format: {output_format}. Use 'hex', 'dec', or 'bin'.")

# --- Example Usage ---
converter = DataConverter()

# Basic Conversions
print(f"bin '11010110' -> hex: {converter.bin2hex('11010110')}") # D6
print(f"bin '11010110' -> dec: {converter.bin2dec('11010110')}") # 214
print(f"hex 'D6' -> bin: {converter.hex2bin('D6')}")             # 11010110
print(f"hex 'A' -> bin (4 bits): {converter.hex2bin('A', 4)}")    # 1010
print(f"hex 'A' -> bin (8 bits): {converter.hex2bin('A', 8)}")    # 00001010
print(f"hex 'D6' -> dec: {converter.hex2dec('D6')}")             # 214
print(f"hex '0x1A' -> dec: {converter.hex2dec('0x1A')}")         # 26
print(f"dec 214 -> hex: {converter.dec2hex(214)}")               # D6
print(f"dec 214 -> bin: {converter.dec2bin(214)}")               # 11010110
print(f"dec 10 -> bin (8 bits): {converter.dec2bin(10, 8)}")     # 00001010
print("-" * 20)

# Binary Process Examples
hex_data = "1AC" # Binary: 0001 1010 1100 (12 bits total, MSB=11, LSB=0)
bin_data = "000110101100"

# Example from docstring: Extract bits 7 down to 4 from "1AC" (hex) -> should be "1010"
print(f"Processing hex '{hex_data}', msb=7, lsb=4:")
print(f"  -> Output hex: {converter.binary_process(hex_data, msb=7, lsb=4, input_format='hex', output_format='hex')}") # A
print(f"  -> Output dec: {converter.binary_process(hex_data, msb=7, lsb=4, input_format='hex', output_format='dec')}") # 10
print(f"  -> Output bin: {converter.binary_process(hex_data, msb=7, lsb=4, input_format='hex', output_format='bin')}") # 1010
print("-" * 20)

# Extract bits 11 down to 8 from "1AC" (hex) -> should be "0001"
print(f"Processing hex '{hex_data}', msb=11, lsb=8:")
print(f"  -> Output hex: {converter.binary_process(hex_data, msb=11, lsb=8, input_format='hex', output_format='hex')}") # 1
print(f"  -> Output dec: {converter.binary_process(hex_data, msb=11, lsb=8, input_format='hex', output_format='dec')}") # 1
print(f"  -> Output bin: {converter.binary_process(hex_data, msb=11, lsb=8, input_format='hex', output_format='bin')}") # 0001
print("-" * 20)

# Extract bits 3 down to 0 from binary input "000110101100" -> should be "1100"
print(f"Processing bin '{bin_data}', msb=3, lsb=0:")
print(f"  -> Output hex: {converter.binary_process(bin_data, msb=3, lsb=0, input_format='bin', output_format='hex')}") # C
print(f"  -> Output dec: {converter.binary_process(bin_data, msb=3, lsb=0, input_format='bin', output_format='dec')}") # 12
print(f"  -> Output bin: {converter.binary_process(bin_data, msb=3, lsb=0, input_format='bin', output_format='bin')}") # 1100
print("-" * 20)

# Error Handling Examples (Uncomment to test)
# print(converter.bin2hex("11012")) # ValueError: Invalid binary string
# print(converter.hex2bin("GHI"))   # ValueError: Invalid hexadecimal string
# print(converter.binary_process("1AC", msb=12, lsb=8)) # ValueError: MSB (12) is out of range (12 bits)
# print(converter.binary_process("1AC", msb=5, lsb=8))  # ValueError: Invalid bit range (MSB < LSB)