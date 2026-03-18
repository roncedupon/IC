//=======================================================================
// AXI Slave Memory Response Sequence
// Description: Responds to master requests using built-in memory model
//=======================================================================

`ifndef GUARD_AXI_SLAVE_RESPONSE_SEQUENCE_SV
`define GUARD_AXI_SLAVE_RESPONSE_SEQUENCE_SV

class axi_slave_response_sequence extends svt_axi_slave_base_sequence;
  
  /** Response transaction */
  svt_axi_slave_transaction req_resp;
  
  /** UVM Object Utility macro */
  `uvm_object_utils(axi_slave_response_sequence)
  
  /** Class Constructor */
  function new(string name = "axi_slave_response_sequence");
    super.new(name);
  endfunction
  
  /** Body task - sequence execution */
  virtual task body();
    integer status;
    svt_configuration get_cfg;
    
    `uvm_info("body", "Entered...", UVM_LOW)
    
    // Get configuration
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast configuration to svt_axi_port_configuration")
    end
    
    // Consume any pending responses
    sink_responses();
    
    // Main response loop
    forever begin
      // Get request from monitor (via response_request_port)
      p_sequencer.response_request_port.peek(req_resp);
      
      // Randomize response with valid constraints
      status = req_resp.randomize with {
        // Always return OKAY response
        bresp == svt_axi_slave_transaction::OKAY;
        
        // Random read response for each beat
        foreach (rresp[idx]) {
          rresp[idx] == svt_axi_slave_transaction::OKAY;
        }
        
        // Random delays on handshake signals
        foreach (awready_delay[i]) awready_delay[i] inside {[0:5]};
        foreach (wready_delay[i])  wready_delay[i]  inside {[0:5]};
        foreach (bvalid_delay[i])  bvalid_delay[i]  inside {[0:5]};
        foreach (rvalid_delay[i])  rvalid_delay[i]  inside {[0:5]};
      };
      
      if (!status)
        `uvm_fatal("body", "Unable to randomize slave response")
      
      // Handle memory operations
      if (req_resp.xact_type == svt_axi_slave_transaction::WRITE) begin
        // Write: store data to memory
        put_write_transaction_data_to_mem(req_resp);
        `uvm_info("body", $sformatf("WRITE to addr=0x%08h, beats=%0d", 
                  req_resp.addr, req_resp.burst_length), UVM_HIGH)
      end
      else begin
        // Read: retrieve data from memory
        get_read_data_from_mem_to_transaction(req_resp);
        `uvm_info("body", $sformatf("READ from addr=0x%08h, beats=%0d", 
                  req_resp.addr, req_resp.burst_length), UVM_HIGH)
      end
      
      // Cast and send response to driver
      $cast(req, req_resp);
      `uvm_send(req)
    end
    
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask
  
endclass

`endif // GUARD_AXI_SLAVE_RESPONSE_SEQUENCE_SV
