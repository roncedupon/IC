
`ifndef GUARD_SVT_SPI_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_SPI_TRANSACTION_SEQUENCE_COLLECTION_SV

// =============================================================================
/** 
 * svt_spi_transaction_base_sequence: This is the base class for svt_spi_transaction
 * sequences. All other svt_spi_transaction sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_spi_transaction_base_sequence extends svt_sequence#(svt_spi_transaction);

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_spi_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer) 

  /** 
   * Constructs a new svt_spi_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_spi_transaction_base_sequence");

endclass

// =============================================================================

`protected
W2;J>SY^=62TAZ,&BU1P9VM2>Bg\7)M2GEC+^E;Z5I_X8=2.M;1Z,)8Q2SeZY:S?
a7G8SUIN=B9Q4(\;dZ#^7SSMSXHa88VBWI?daf:E7@)fVPLE]Ae:OGI8SC-3#0f6
+8I1(_(.(9FEgTCd4L-@6g/#17U.9IdS=@@eB/b>&O9CC9=J5:(4^M&aYW4Af(3#
Te/19-_bbe[-K5Dd3UC7VaXIY(>?2SNAWb>Q<FDUSV>^;.K@LD:4.;&fPJ=_QT+2
G_X^.fB71,aYLaRDa>#XKbb+/QH6fIfY/0Y&?<^&g8C&N/a,4&,MaC?HDCX04&;b
YaDZ_RCD[_fPA]=gg+^4+9b+5$
`endprotected


// =============================================================================
/** 
 * svt_spi_transaction_random_sequence
 *
 * This sequence creates a random svt_spi_transaction request.
 */
class svt_spi_transaction_random_sequence extends svt_spi_transaction_base_sequence; 
  
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_spi_transaction_random_sequence) 
  
  /** Parameter that controls the number of svt_spi_transaction requests that will be generated */
  rand int unsigned sequence_length = 5;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 10;
  }

  /**
   * Constructs the svt_spi_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_spi_transaction_random_sequence");
  
  /** 
   * Executes the svt_spi_transaction_random_sequence sequence. 
   */
  extern virtual task body();

endclass

//------------------------------------------------------------------------------
function svt_spi_transaction_random_sequence::new(string name="svt_spi_transaction_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_spi_transaction_random_sequence::body();
  svt_spi_transaction req;

  /** Get the user sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  int status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
  int status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
  `svt_xvm_debug("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

  repeat(sequence_length) begin
    `svt_xvm_create(req);
    `svt_xvm_rand_send(req)
  end
endtask

// =============================================================================
/** 
 * svt_spi_transaction_null_sequence
 *
 * This class creates a null sequence which can be associated with a sequencer but generates no traffic.
 */
class svt_spi_transaction_null_sequence extends svt_spi_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_spi_transaction_null_sequence) 
  
  /**
   * Constructs the svt_spi_transaction_null_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_spi_transaction_null_sequence");

  /** 
   * Executes svt_spi_transaction_null_sequence sequence. 
   */
  extern virtual task body();

endclass

// =============================================================================

//------------------------------------------------------------------------------
function svt_spi_transaction_null_sequence::new(string name="svt_spi_transaction_null_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_spi_transaction_null_sequence:: body();
endtask

// =============================================================================

`endif // GUARD_SVT_SPI_TRANSACTION_SEQUENCE_COLLECTION_SV

