//=======================================================================
// AXI Master Write-Read Sequence
// Description: Performs write followed by read at the same address
//=======================================================================

`ifndef GUARD_AXI_MASTER_WRITE_READ_SEQUENCE_SV
`define GUARD_AXI_MASTER_WRITE_READ_SEQUENCE_SV

class axi_master_write_read_sequence extends svt_axi_master_base_sequence;
  
  /** Number of transactions to generate */
  rand int unsigned sequence_length = 10;
  
  /** Base address for transactions */
  rand bit [31:0] base_addr = 32'h0000_1000;
  
  /** Constrain sequence length */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
    sequence_length >= 1;
  }
  
  /** UVM Object Utility macro */
  `uvm_object_utils(axi_master_write_read_sequence)
  
  /** Class Constructor */
  function new(string name = "axi_master_write_read_sequence");
    super.new(name);
  endfunction
  
  /** Body task - sequence execution */
  virtual task body();
    bit status;
    svt_axi_master_transaction write_tran, read_tran;
    
    `uvm_info("body", "Entered...", UVM_LOW)
    super.body();
    
    // Get sequence_length from config DB if available
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length = %0d", sequence_length), UVM_LOW)
    
    for (int i = 0; i < sequence_length; i++) begin
      // ========== WRITE Transaction ==========
      `uvm_create(write_tran)
      write_tran.cfg = cfg;
      
      `uvm_rand_send_with(write_tran, {
        xact_type == svt_axi_master_transaction::WRITE;
        addr == (base_addr + ('h10 * i));
        burst_type == svt_axi_master_transaction::INCR;
        burst_size == svt_axi_master_transaction::BURST_SIZE_64BIT;
        burst_length == 4;  // 4 beats
        data.size() == 4;
        foreach (data[j]) {
          data[j] == (32'hDEAD_BEEF + i + j);
        }
      })
      
      // Wait for write response
      get_response(rsp);
      `uvm_info("body", $sformatf("WRITE completed at addr=0x%08h", base_addr + ('h10 * i)), UVM_LOW)
      
      // ========== READ Transaction ==========
      `uvm_create(read_tran)
      read_tran.cfg = cfg;
      
      `uvm_rand_send_with(read_tran, {
        xact_type == svt_axi_master_transaction::READ;
        addr == (base_addr + ('h10 * i));
        burst_type == svt_axi_master_transaction::INCR;
        burst_size == svt_axi_master_transaction::BURST_SIZE_64BIT;
        burst_length == 4;
      })
      
      // Wait for read response
      get_response(rsp);
      `uvm_info("body", $sformatf("READ completed at addr=0x%08h", base_addr + ('h10 * i)), UVM_LOW)
      
      // Verify data (optional - can be done in scoreboard)
      if (rsp.data.size() >= 4) begin
        for (int j = 0; j < 4; j++) begin
          if (rsp.data[j] != (32'hDEAD_BEEF + i + j)) begin
            `uvm_error("DATA_MISMATCH", 
              $sformatf("Read data mismatch: expected 0x%08h, got 0x%08h at beat %0d", 
                        (32'hDEAD_BEEF + i + j), rsp.data[j], j))
          end
        end
      end
    end
    
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask
  
endclass

`endif // GUARD_AXI_MASTER_WRITE_READ_SEQUENCE_SV
