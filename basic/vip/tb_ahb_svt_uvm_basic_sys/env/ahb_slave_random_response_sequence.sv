
/**
 * Abstract:
 * class ahb_slave_random_response_sequence defines a sequence class that the
 * testbench uses to provide slave response to the Slave agent present in the
 * System agent. The sequence receives a response object of type
 * svt_ahb_slave_transaction, from slave sequencer. The sequence class then
 * randomizes the response with constraints and provides it to the slave driver
 * within the slave agent.
 */
`ifndef GUARD_AHB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV
`define GUARD_AHB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV

class ahb_slave_random_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  svt_ahb_slave_transaction resp_req;

  /** UVM Object Utility macro */
  `uvm_object_utils(ahb_slave_random_response_sequence)

  /** Class Constructor */
  function new(string name="ahb_slave_random_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entered ...", UVM_LOW)

    forever begin
      p_sequencer.response_request_port.peek(resp_req);

      $cast(req,resp_req);

      /** 
       * Demonstration of response randomization with constraints.
       */
      `uvm_rand_send_with(req,
         {
           response_type inside { svt_ahb_transaction::ERROR, svt_ahb_transaction::OKAY };
         })

    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: ahb_slave_random_response_sequence

`endif // GUARD_AHB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV
