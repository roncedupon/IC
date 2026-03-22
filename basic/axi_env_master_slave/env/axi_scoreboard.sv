//=======================================================================
// AXI Scoreboard
// Description: Verifies data integrity between write and read transactions
//=======================================================================

`ifndef GUARD_AXI_SCOREBOARD_SV
`define GUARD_AXI_SCOREBOARD_SV

class axi_scoreboard extends uvm_scoreboard;
  
  /** Memory model to track expected data */
  bit [63:0] memory_model [bit [31:0]];
  
  /** Analysis imports for monitoring */
  uvm_analysis_imp_master #(svt_axi_master_transaction, axi_scoreboard) master_export;
  uvm_analysis_imp_slave  #(svt_axi_slave_transaction,  axi_scoreboard) slave_export;
  
  /** Configuration handle */
  cust_svt_axi_system_configuration cfg;
  
  /** Statistics counters */
  int unsigned write_count = 0;
  int unsigned read_count = 0;
  int unsigned error_count = 0;
  int unsigned match_count = 0;
  
  /** UVM Component Utility macro */
  `uvm_component_utils(axi_scoreboard)
  
  /** Class Constructor */
  function new(string name = "axi_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    master_export = new("master_export", this);
    slave_export  = new("slave_export", this);
  endfunction
  
  /** Build Phase */
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Get configuration
    if (!uvm_config_db#(cust_svt_axi_system_configuration)::get(this, "", "cfg", cfg)) begin
      `uvm_warning("build_phase", "Configuration not found, using defaults")
    end
  endfunction
  
  /** Write method for master transactions */
  virtual function void write_master(svt_axi_master_transaction tr);
    if (tr.xact_type == svt_axi_master_transaction::WRITE) begin
      // Store write data in memory model
      store_write_data(tr);
      write_count++;
      `uvm_info("SCOREBOARD", $sformatf("Tracked WRITE: addr=0x%08h, beats=%0d", 
                tr.addr, tr.burst_length), UVM_HIGH)
    end
  endfunction
  
  /** Write method for slave transactions */
  virtual function void write_slave(svt_axi_slave_transaction tr);
    if (tr.xact_type == svt_axi_slave_transaction::READ) begin
      // Verify read data against memory model
      verify_read_data(tr);
      read_count++;
    end
  endfunction
  
  /** Store write transaction data in memory model */
  virtual function void store_write_data(svt_axi_master_transaction tr);
    bit [31:0] addr = tr.addr;
    int beats = (tr.burst_length == 0) ? 1 : tr.burst_length;
    
    // Calculate address increment based on burst size
    int addr_increment = (1 << tr.burst_size);
    
    for (int i = 0; i < beats; i++) begin
      if (i < tr.data.size()) begin
        // Store 64-bit data at calculated address
        memory_model[addr] = tr.data[i];
        `uvm_info("MEMORY_WRITE", $sformatf("mem[0x%08h] = 0x%016h", addr, tr.data[i]), UVM_DEBUG)
      end
      addr += addr_increment;
    end
  endfunction
  
  /** Verify read transaction data against memory model */
  virtual function void verify_read_data(svt_axi_slave_transaction tr);
    bit [31:0] addr = tr.addr;
    int beats = (tr.burst_length == 0) ? 1 : tr.burst_length;
    
    // Calculate address increment based on burst size
    int addr_increment = (1 << tr.burst_size);
    
    `uvm_info("SCOREBOARD", $sformatf("Verifying READ: addr=0x%08h, beats=%0d", 
              tr.addr, tr.burst_length), UVM_HIGH)
    
    for (int i = 0; i < beats; i++) begin
      if (i < tr.data.size()) begin
        bit [63:0] expected_data = memory_model.exists(addr) ? memory_model[addr] : 64'hX;
        bit [63:0] actual_data = tr.data[i];
        
        if (expected_data !== 64'hX && expected_data === actual_data) begin
          match_count++;
          `uvm_info("DATA_VERIFY", $sformatf("PASS: mem[0x%08h] = 0x%016h", 
                    addr, actual_data), UVM_HIGH)
        end else begin
          error_count++;
          `uvm_error("DATA_VERIFY", 
            $sformatf("FAIL: mem[0x%08h] expected=0x%016h, actual=0x%016h", 
                      addr, expected_data, actual_data))
        end
      end
      addr += addr_increment;
    end
  endfunction
  
  /** Report Phase */
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info("SCOREBOARD_REPORT", "==================================", UVM_LOW)
    `uvm_info("SCOREBOARD_REPORT", $sformatf("Total Writes Tracked:  %0d", write_count), UVM_LOW)
    `uvm_info("SCOREBOARD_REPORT", $sformatf("Total Reads Verified:  %0d", read_count), UVM_LOW)
    `uvm_info("SCOREBOARD_REPORT", $sformatf("Data Matches:         %0d", match_count), UVM_LOW)
    `uvm_info("SCOREBOARD_REPORT", $sformatf("Data Mismatches:      %0d", error_count), UVM_LOW)
    
    if (error_count == 0 && write_count > 0) begin
      `uvm_info("SCOREBOARD_REPORT", "ALL DATA VERIFICATIONS PASSED!", UVM_LOW)
    end else if (error_count > 0) begin
      `uvm_error("SCOREBOARD_REPORT", "DATA VERIFICATION FAILED!")
    end
    `uvm_info("SCOREBOARD_REPORT", "==================================", UVM_LOW)
  endfunction
  
endclass

`endif // GUARD_AXI_SCOREBOARD_SV