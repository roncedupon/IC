
`ifndef GUARD_UART_RANDOM_SEQUENCE_SV
`define GUARD_UART_RANDOM_SEQUENCE_SV

/**
 * Abstract:
 * 
 * Class uart_random_sequence defines a sequence which generates the request 
 * object randomly and sends it using `uvm_do() UVM macro to the sequencer. 
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with DTE and DCE agent sequencer
 */
class uart_random_sequence extends uvm_sequence #(svt_uart_transaction); 

  /** Parameter that controls the number of Uart packets that would be generated */
  rand int unsigned sequence_length = 1;

  /** Configuration obtained from the sequencer */
  svt_uart_configuration  uart_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(uart_random_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_uart_transaction_sequencer 
   */
  `uvm_declare_p_sequencer(svt_uart_transaction_sequencer)

  /** Class constructor */
  function new (string name = "uart_random_sequence");
    super.new(name);
  endfunction : new

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
  
  virtual task body();
    bit status;
    svt_configuration get_cfg;
    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(uart_cfg,cfg))
      `uvm_fatal("body","unable to cast configuration to svt_uart_configuration class");

    `uvm_info("body", "Entered ...", UVM_DEBUG)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    for(int i = 0; i < sequence_length; i++) begin
      `uvm_info("body", $sformatf("Calling `uvm_do, iteration=%0d", i), UVM_LOW)

      /** Generate Uart packets randomly.  */
      `uvm_do(req) 

    end

    /** 
     * Call get_response only if agent configuration attribute,
     * enable_put_response is set 1.
     */
    if(uart_cfg.enable_put_response == 1) begin
      for(int j=0;j<sequence_length;j++) 
        get_response(rsp);
    end

    /** 
     * Below code is added for checking mismatch between payload and
     * rsp.transmitted_packet. 
     */
    foreach(req.payload[i]) begin
      if(uart_cfg.data_width.name=="FIVE_BIT")
      begin
        if(req.payload[i][4:0] != rsp.transmitted_packet[i][5:1])
        `uvm_error("body",$sformatf("rsp.transmitted and payload mismatch ::data_width:%s payload :%h transmitted_packet:%h",uart_cfg.data_width,req.payload[i][4:0],rsp.transmitted_packet[i][5:1]));
      end
      else if(uart_cfg.data_width.name=="SIX_BIT")
      begin
        if(req.payload[i][5:0] != rsp.transmitted_packet[i][6:1])
        `uvm_error("body",$sformatf("rsp.transmitted and payload mismatch ::data_width:%s payload :%h transmitted_packet:%h",uart_cfg.data_width,req.payload[i][5:0],rsp.transmitted_packet[i][6:1]));
      end
      else if(uart_cfg.data_width.name=="SEVEN_BIT")
      begin
        if(req.payload[i][6:0] != rsp.transmitted_packet[i][7:1])
        `uvm_error("body",$sformatf("rsp.transmitted and payload mismatch ::data_width:%s payload :%h transmitted_packet:%h",uart_cfg.data_width,req.payload[i][6:0],rsp.transmitted_packet[i][7:1]));
      end
      else if(uart_cfg.data_width.name=="EIGHT_BIT")
      begin
        if(req.payload[i][7:0] != rsp.transmitted_packet[i][8:1])
        `uvm_error("body",$sformatf("rsp.transmitted and payload mismatch ::data_width:%s payload :%h transmitted_packet:%h",uart_cfg.data_width,req.payload[i][7:0],rsp.transmitted_packet[i][8:1]));
      end
      else if(uart_cfg.data_width.name=="NINE_BIT")
      begin
        if(req.payload[i][8:0] != rsp.transmitted_packet[i][9:1])
        `uvm_error("body",$sformatf("rsp.transmitted and payload mismatch ::data_width:%s payload :%h transmitted_packet:%h",uart_cfg.data_width,req.payload[i][8:0],rsp.transmitted_packet[i][9:1]));
      end
    end

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask: body

endclass : uart_random_sequence 

`endif // GUARD_UART_RANDOM_SEQUENCE_SV

