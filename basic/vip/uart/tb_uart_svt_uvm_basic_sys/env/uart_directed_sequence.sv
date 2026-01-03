
`ifndef GUARD_UART_DIRECTED_SEQUENCE_UVM_SV
`define GUARD_UART_DIRECTED_SEQUENCE_UVM_SV

/**
 * Abstract:
 * uart_directed_sequence demonstrates, the way user can control the subset of 
 * the svt_uart_transaction class. Transaction class members are assigned 
 * values here. 
 * 
 * It demonstrates the creation of transaction, by assigning values to the 
 * transactions rather than randomization, and then transmitted using 
 * `uvm_send. Here One uart packet is sent back-to-back.
 * 
 * For full set of transaction class members and their complete description 
 * refer "Uart Verification IP UVM Class Reference Manual."
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with both DTE and DCE agent sequencer
 */
class uart_directed_sequence extends uvm_sequence #(svt_uart_transaction); 
  
  svt_uart_transaction tx_xact;

  /** Configuration obtained from the sequencer */
  svt_uart_configuration  uart_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(uart_directed_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_uart_transaction_sequencer
   */
  `uvm_declare_p_sequencer(svt_uart_transaction_sequencer)

  /** Class constructor */
  function new (string name = "uart_directed_sequence");
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
    svt_configuration get_cfg;
    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(uart_cfg,cfg))
      `uvm_fatal("body","unable to cast the configuration to svt_uart_configuration class");
  
    `uvm_info("body", "Entered ...", UVM_LOW)

    /** Create instance of svt_uart_transaction class. */
    for(int loop=0;loop<3;loop++)begin

      /** Assigning the fields of Uart Transaction class*/
      /** Inject the directed transaction in the output stream of Uart sequencer.*/
      // `uvm_send(tx_xact)  
      // `uvm_create(tx_xact)
      // // tx_xact.reasonable_constraint_mode(0);
      // tx_xact.direction = 0; // 0 - TX , 1 - RX      
      // `uvm_rand_send_with(tx_xact,{


      //   tx_xact.inter_cycle_delay == 100;
      //   tx_xact.packet_count == 8;
      //   foreach(tx_xact.payload[i]) {
      //     tx_xact.payload[i] == i;
      //   }
      // });
      // tx_xact.print();
      // #100us;      
      // if(uart_cfg.enable_put_response == 1)
      //   get_response(rsp);
      // rsp.print();
      #100us;
      uart_rx(32);

      `uvm_info("body", $sformatf("UART PACKET %0d sent successfully", loop+1), UVM_LOW)
      #100000;
    end
    `uvm_info("body", "UART PACKET has finished", UVM_LOW)
    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask : body

    task uart_rx(int received_bytes);
        `uvm_create(tx_xact);        
        tx_xact.direction           = 1;//RX                    
        `uvm_rand_send_with(tx_xact,{
            tx_xact.packet_count        == received_bytes;
            tx_xact.inter_cycle_delay   == 80;  
        });   
        `uvm_info(get_full_name(),$sformatf("waiting for cpu send back %d",received_bytes),UVM_LOW);
        tx_xact.print();       
        get_response(rsp);
        `uvm_info(get_full_name(),$sformatf("%d data received.",received_bytes),UVM_LOW);       
        rsp.print();       
    endtask        
endclass : uart_directed_sequence 

`endif // GUARD_UART_DIRECTED_SEQUENCE_UVM_SV

