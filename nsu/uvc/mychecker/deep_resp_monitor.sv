`ifndef DEEP_READ_RESP_MONITOR
`define DEEP_READ_RESP_MONITOR
class deep_resp_monitor extends uvm_component;
  // Import SVT AXI transaction

  
  // TLM imp interface for SVT AXI transactions
  uvm_tlm_analysis_imp#(svt_axi_transaction, deep_resp_monitor) axi_trans_imp;
  
  // Analysis FIFO for deep read responses
  uvm_tlm_analysis_fifo#(nsu2cpu_deep_resp_transaction) deep_read_resp_que;
  
  // Local storage for deep response data
  logic [31:0] deep_resp_data[14];
  int current_entry_idx = 0;
  int current_word_idx = 0;
  
  // Address range constants
  localparam bit [31:0] DEEP_RESP_BASE_ADDR = 32'h4000;
  localparam bit [31:0] DEEP_RESP_END_ADDR = 32'h57D4;
  localparam int ENTRY_SIZE = 14; // 14 words per entry
  localparam int TOTAL_ENTRIES = 109;
  
  `uvm_component_utils(deep_resp_monitor)
  
  function new(string name = "deep_resp_monitor", uvm_component parent = null);
    super.new(name, parent);
    axi_trans_imp = new("axi_trans_imp", this);
    deep_read_resp_que = new("deep_read_resp_que", this);
  endfunction
  
  // TLM write function to handle incoming AXI transactions
  function void write(svt_axi_transaction trans);
    bit [31:0] addr;
    bit [31:0] data;
    
    // Extract address and data from AXI transaction
    addr = trans.addr;
    
    // Check if address is within the deep response range
    if (addr >= DEEP_RESP_BASE_ADDR && addr <= DEEP_RESP_END_ADDR) begin
      // Calculate entry index and word index
      int entry_offset = addr - DEEP_RESP_BASE_ADDR;
      int entry_idx = entry_offset / (ENTRY_SIZE * 4); // 4 bytes per word
      int word_idx = (entry_offset % (ENTRY_SIZE * 4)) / 4;
      
      // Get data from AXI transaction (assuming 32-bit data)
      if (trans.read_data.size() > 0) begin
        data = trans.read_data[0];
      end else begin
        `uvm_warning(get_name(), $sformatf("No read data in transaction for address 0x%0h", addr));
        return;
      end
      
      // Store the data
      deep_resp_data[word_idx] = data;
      
      // Check if we've collected all 14 words for this entry
      if (word_idx == ENTRY_SIZE - 1) begin
        // Create a new deep_resp transaction
        nsu2cpu_deep_resp_transaction deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp");
        
        // Copy the collected data
        for (int i = 0; i < ENTRY_SIZE; i++) begin
          deep_resp.nsu2cpu_deep_resp[i] = deep_resp_data[i];
        end
        
        // Assign fields from the data
        deep_resp.fields_assignment();
        
        // Send the transaction to the analysis FIFO
        deep_read_resp_que.write(deep_resp);
        
        `uvm_info(get_name(), $sformatf("Completed deep_resp entry %0d", entry_idx), UVM_MEDIUM);
      end
    end
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
endclass
`endif