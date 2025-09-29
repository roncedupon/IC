
/**
 * Abstract:
 * class uart_default_sequence is used by the testbench to provide 
 * default transaction sequence which is initiated on the virtual sequence 
 * through the virtual sequencer. It defines a sequence in which it generates the
 * request object randomly
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with both DTE and DCE Agent sequencer
 */

class uart_default_sequence extends uvm_sequence #(svt_uart_transaction);
   
  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  rand int unsigned sequence_length =1;

  /** Configuration obtained from the sequencer */
  svt_uart_configuration  uart_cfg;
   
  /** UVM object utility macro */
  `uvm_object_utils(uart_default_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_uart_transaction_sequencer 
   */
  `uvm_declare_p_sequencer(svt_uart_transaction_sequencer)

  /** Class constructor */
  function new(string name="uart_default_sequence");
    super.new(name);
  endfunction 

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase phase;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.raise_objection(this);
    end
  endtask: pre_body
  
  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    uvm_phase phase;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.drop_objection(this);
    end
  endtask: post_body
   
  /** Body of Sequence */
  virtual task body();
    svt_configuration get_cfg;
    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(uart_cfg,cfg))
      `uvm_fatal("body","Unable to cast the configuration to svt_uart_configuration class");
  
    `uvm_info("body", "Entered ...", UVM_DEBUG)

    for(int i = 0; i < 1000; i++) begin
      `uvm_info("body", $sformatf("Calling `uvm_do, iteration=%0d", i), UVM_LOW)

      /** Generate Uart packets randomly.  */
      `uvm_do(req)
    end

    /** 
     * Call get_response only if agent configuration attribute,
     * enable_put_response is set 1.
     */
    if(uart_cfg.enable_put_response == 1) begin
      for(int i=0;i<1000;i++)
        get_response(rsp);
    end
    
    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask 
endclass

