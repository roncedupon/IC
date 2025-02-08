
/**
 * Abstract:
 * Class ahb_slave_mem_response_sequence defines a sequence class that
 * the testbench uses to provide slave response to the Slave agent present in
 * the System agent. The sequence receives a response object of type
 * svt_ahb_slave_transaction from slave sequencer. The sequence class then
 * randomizes the response with constraints and provides it to the slave driver
 * within the slave agent. The sequence also instantiates the slave built-in
 * memory, and writes into or reads from the slave memory.
 *
 * Execution phase: main_phase
 * Sequencer: Slave agent sequencer
 */

`ifndef GUARD_AHB_SLAVE_MEM_RESPONSE_SEQUENCE_SV
`define GUARD_AHB_SLAVE_MEM_RESPONSE_SEQUENCE_SV

class ahb_slave_mem_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  svt_ahb_slave_transaction req_resp;

  /** UVM Object Utility macro */
  `uvm_object_utils(ahb_slave_mem_response_sequence)

  /** Class Constructor */
  function new(string name="ahb_slave_mem_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    integer status;
    svt_configuration get_cfg;

    `uvm_info("body", "Entered ...", UVM_LOW)

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_ahb_port_configuration class");
    end

    forever begin
      /**
       * Get the response request from the slave sequencer. The response request is
       * provided to the slave sequencer by the slave port monitor, through
       * TLM port.
       */
      p_sequencer.response_request_port.peek(req_resp);

      /**
       * Randomize the response and delays
       */
      status=req_resp.randomize with {
        num_wait_cycles == 0;
        response_type == svt_ahb_slave_transaction::OKAY;
       };
       if(!status)
        `uvm_fatal("body","Unable to randomize a response")

      /**
       * If write transaction, write data into slave built-in memory, else get
       * data from slave built-in memory
       */
      if(req_resp.xact_type == svt_ahb_slave_transaction::WRITE) begin
        put_write_transaction_data_to_mem(req_resp);
      end
      else begin
        get_read_data_from_mem_to_transaction(req_resp);
      end
    
      $cast(req,req_resp);

      /**
       * send to driver
       */
      `uvm_send(req)

    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: ahb_slave_mem_response_sequence

`endif // GUARD_AHB_SLAVE_MEM_RESPONSE_SEQUENCE_SV
