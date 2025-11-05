
`ifndef GUARD_SPI_RANDOM_SEQUENCE_SV
`define GUARD_SPI_RANDOM_SEQUENCE_SV

/**
 * Abstract:
 * 
 * Class spi_random_sequence defines a sequence which generates the request 
 * object randomly and sends it using `uvm_do() UVM macro to the sequencer. 
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with DTE and DCE agent sequencer
 */
class spi_random_sequence extends uvm_sequence #(svt_spi_transaction); 

  /** Parameter that controls the number of SPI packets that would be generated */
  rand int unsigned sequence_length = 1;

  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(spi_random_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `uvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new (string name = "spi_random_sequence");
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
    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `uvm_fatal("body","unable to cast configuration to svt_spi_configuration class");

    `uvm_info("body", "Entered ...", UVM_DEBUG)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    for(int i = 0; i < sequence_length; i++) begin
      `uvm_info("body", $sformatf("Calling `uvm_do, iteration=%0d", i), UVM_LOW)

      /** Generate SPI packets randomly.  */
      `uvm_do(req) 

    end

    /** 
     * Call get_response only if agent configuration attribute,
     * enable_put_response is set 1.
     */
    if(spi_cfg.enable_put_response == 1) begin
      for(int j=0;j<sequence_length;j++) 
        get_response(rsp);
    end

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask: body

endclass : spi_random_sequence 

`endif // GUARD_SPI_RANDOM_SEQUENCE_SV

