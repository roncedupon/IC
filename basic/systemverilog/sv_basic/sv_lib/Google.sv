module mem_load_1024bit_example;

  // --- Parameters ---
  parameter MEM_WIDTH = 1024;
  parameter MEM_DEPTH = 1; // Only one location needed

  // Memory Declaration
  logic [MEM_WIDTH-1:0] data_mem [MEM_DEPTH-1:0]; // data_mem[0] is the target

  // --- Task to Load 1024-bit Memory from Hex String ---
  task automatic load_1024bit_mem_from_hex_string (
    input string hex_string,                    // Input: 256-char hex string
    inout logic [MEM_WIDTH-1:0] mem [MEM_DEPTH-1:0] // Memory array (expects depth 1 here)
  );
    // Define chunk size (e.g., 64 bits is manageable)
    parameter int CHUNK_WIDTH = 64;
    parameter int CHARS_PER_CHUNK = CHUNK_WIDTH / 4;  // 16 hex chars
    parameter int NUM_CHUNKS = MEM_WIDTH / CHUNK_WIDTH; // 1024 / 64 = 16 chunks

    string hex_substring;
    logic [CHUNK_WIDTH-1:0] chunk_val; // Holds the 64-bit value of a chunk
    longint temp_long; // Use longint (usually 64 bits) for $sscanf target

    // --- Input Validation ---
    if (hex_string.len() != 256) begin
      $error("Input string length (%0d) != expected length (256). Cannot load memory.",
             hex_string.len());
      return;
    end
    if (MEM_DEPTH != 1) begin
        $error("This task is designed for MEM_DEPTH=1, but depth is %0d", MEM_DEPTH);
        return;
    end

    // Initialize memory location (optional, good practice)
    mem[0] = {MEM_WIDTH{1'b0}}; // Set all 1024 bits to 0 initially

    // --- Loop through chunks (16 chunks of 64 bits) ---
    // Process string from left (MSB) to right (LSB)
    for (int j = 0; j < NUM_CHUNKS; j++) begin // j=0 is first 16 chars, j=15 is last 16 chars
      int start_index = j * CHARS_PER_CHUNK;
      int end_index   = start_index + CHARS_PER_CHUNK - 1;

      // 1. Extract the 16-character substring
      hex_substring = hex_string.substr(start_index, end_index);

      // 2. Convert hex substring to 64-bit logic vector
      //    Using $sscanf into a longint is safer for 64 bits
      void'($sscanf(hex_substring, "%h", temp_long));
      chunk_val = temp_long; // Assign from 64-bit integer to 64-bit logic

      // 3. Calculate position and place the chunk into the 1024-bit vector
      //    Chunk j=0 (most significant chars) goes into highest bits
      //    Chunk j=15 (least significant chars) goes into lowest bits [63:0]
      int high_bit = MEM_WIDTH - 1 - j * CHUNK_WIDTH;       // e.g., j=0 -> 1023; j=15 -> 63
      int low_bit  = MEM_WIDTH - (j + 1) * CHUNK_WIDTH;     // e.g., j=0 -> 960;  j=15 -> 0

      mem[0][high_bit : low_bit] = chunk_val;

      // --- Optional: Display progress ---
      // $display("Chunk %0d (%0d:%0d): Substr='%s' -> Val=%h -> Placing in mem[0][%0d:%0d]",
      //          j, start_index, end_index, hex_substring, chunk_val, high_bit, low_bit);
    end
    $info("1024-bit memory loading from hex string complete.");
  endtask : load_1024bit_mem_from_hex_string


  // --- Example Usage ---
  initial begin
    // Example 256-character hex string (ensure it has exactly 256 chars)
    string data_str = "FEDCBA9876543210FEDCBA9876543210" // Chunk 0 (j=0) -> bits [1023:960]
                    + "11223344556677881122334455667788" // Chunk 1 (j=1) -> bits [959:896]
                    // ... add 12 more 32-char lines for chunks 2-13 ...
                    + "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" // Chunk 14 (j=14) -> bits [127:64]
                    + "00112233445566778899AABBCCDDEEFF" // Chunk 15 (j=15) -> bits [63:0]
    ;

    // Simple length check for the example string literal
    if (data_str.len() != 256) begin
        $fatal(1, "Testbench Error: Initial data string length is %0d, expected 256.", data_str.len());
    end

    $display("Starting 1024-bit memory load...");
    // Call the task to load the memory
    load_1024bit_mem_from_hex_string(data_str, data_mem);

    // --- Verification: Read back some data (using bit slices) ---
    $display("Verification: Reading back memory value slices:");
    $display("data_mem[0][1023:960] = %h", data_mem[0][1023:960]); // Should be FEDCBA9876543210FEDCBA9876543210
    $display("data_mem[0][959:896]  = %h", data_mem[0][959:896]);  // Should be 11223344556677881122334455667788
    $display("data_mem[0][127:64]   = %h", data_mem[0][127:64]);   // Should be AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    $display("data_mem[0][63:0]    = %h", data_mem[0][63:0]);    // Should be 00112233445566778899AABBCCDDEEFF
    // You could also display the whole 1024-bit value if your simulator handles it well:
    // $display("data_mem[0] = %h", data_mem[0]); // Output might be very long!

    $finish;
  end

endmodule : mem_load_1024bit_example

