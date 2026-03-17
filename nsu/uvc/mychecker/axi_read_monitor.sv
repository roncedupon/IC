`ifndef AXI_READ_MONITOR
`define AXI_READ_MONITOR
import svt_axi_uvm_pkg::*;
class axi_read_monitor #(type TRANSACTION = uvm_sequence_item) extends uvm_component;
  // TLM imp interface for SVT AXI transactions
  uvm_analysis_imp#(svt_axi_transaction, axi_read_monitor#(TRANSACTION)) axi_trans_imp;
  
  // Analysis port for sending transactions to other modules
  uvm_analysis_port#(TRANSACTION) ap;
  
  // Configuration parameters
  bit [31:0] BASE_ADDR;
  bit [31:0] END_ADDR;
  int ENTRY_SIZE; // Number of words per entry
  int TOTAL_ENTRIES;
  
  // Local storage for response data
  logic [31:0] data_buffer[];
  
  // Factory registration
  `uvm_component_param_utils(axi_read_monitor#(TRANSACTION))
  
  function new(string name = "axi_read_monitor", uvm_component parent = null);
    super.new(name, parent);
    axi_trans_imp = new("axi_trans_imp", this);
    ap = new("ap", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Allocate response data array
    data_buffer = new[ENTRY_SIZE];
  endfunction
  
  // TLM write function to handle incoming AXI transactions
  function void write(svt_axi_transaction trans);
    bit [31:0] addr;
    bit [31:0] data;
    
    // Extract address and data from AXI transaction
    addr = trans.addr;
    
    // Check if address is within the specified range
    if (addr >= BASE_ADDR && addr <= END_ADDR) begin
      // Calculate entry index and word index
      int entry_offset = addr - BASE_ADDR;
      int entry_idx = entry_offset / (ENTRY_SIZE * 4); // 4 bytes per word
      int word_idx = (entry_offset % (ENTRY_SIZE * 4)) / 4;
      
      // Get data from AXI transaction (assuming 32-bit data)
      if (trans.physical_data.size() > 0) begin
        data = trans.physical_data[0];
      end else begin
        `uvm_warning(get_name(), $sformatf("No read data in transaction for address 0x%0h", addr));
        return;
      end
      
      // Store the data
      data_buffer[word_idx] = data;
      
      // Check if we've collected all words for this entry
      if (word_idx == ENTRY_SIZE - 1) begin
        // Create a new transaction
        TRANSACTION new_trans = TRANSACTION::type_id::create("new_trans");
        
        // Copy the collected data to the transaction
        // This assumes the transaction has an array field to hold the data
        // The field name is assumed to be "data" - this could be made configurable


        transaction_init(new_trans, data_buffer);
        // Send the transaction to other modules through analysis port
        ap.write(new_trans);
        `uvm_info(get_name(), $sformatf("Completed entry %0d", entry_idx), UVM_MEDIUM);
      end
    end
  endfunction
  
  // Virtual method to initialize transaction from collected data
  // This should be overridden in derived classes for specific transaction types
  virtual function void transaction_init(TRANSACTION trans, logic [31:0] data_buffer[]);
    `uvm_fatal(get_name(), "transaction_init not implemented for this transaction type");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
endclass

// Specialization for deep_resp transaction
class deep_resp_monitor extends axi_read_monitor#(nsu2cpu_deep_resp_transaction);
  // Address range constants for deep_resp

  `uvm_component_utils(deep_resp_monitor)
  
  function new(string name = "deep_resp_monitor", uvm_component parent = null);
    super.new(name, parent);
   
    // 初始化配置参数
    this.BASE_ADDR = 32'h4000;
    this.END_ADDR = 32'h57D4;
    this.ENTRY_SIZE = 14;
    this.TOTAL_ENTRIES = 109;
    
    // 打印当前的配置值
    `uvm_info(get_name(), $sformatf("BASE_ADDR = 0x%0h", BASE_ADDR), UVM_MEDIUM);
    `uvm_info(get_name(), $sformatf("END_ADDR = 0x%0h", END_ADDR), UVM_MEDIUM);
    `uvm_info(get_name(), $sformatf("ENTRY_SIZE = %0d", ENTRY_SIZE), UVM_MEDIUM);
    `uvm_info(get_name(), $sformatf("TOTAL_ENTRIES = %0d", TOTAL_ENTRIES), UVM_MEDIUM);
  endfunction
  
  // Override transaction_init for deep_resp
  function void transaction_init(nsu2cpu_deep_resp_transaction trans, logic [31:0] data_buffer[]);
    // Copy the collected data
    for (int i = 0; i < ENTRY_SIZE; i++) begin
      trans.nsu2cpu_deep_resp[i] = data_buffer[i];
    end
    
    // Assign fields from the data
    trans.fields_assignment();
  endfunction
endclass

`endif
