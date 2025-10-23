
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SVzpT6LRbfjGipcStucolhYrUKJHZCsCpJstf/eJF/XRIJrFCyUE+NQMr1Dld4IK
lD5XtsLt7iut4j8OztltjWf7bLy1bYJG2hyX9PV2geF6Es5bVwiN6+RcbmURwEUf
WLD+IaSclHpEAxxfYQ1WLcHg74vNf5PLYLScwLrvbUI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 367       )
8NiiQZ9pA4ZzPdBeLc8OFkKhRYUCBJTnyjGeo5RUhxS3cRBdtnP5V2udrK4aRFBm
CmgCoFYELMESqu39xTd08t1CkyswWwu2R38kLhyqaNb07ldZHOkSmM5e9XKsbo/Q
mXL+9JX+OSbuElyskXMQPsqhDPKzip5y22pW69+lrmUmFethDctIxFvpbdeyF310
svGm7ycxfJxOZQmB9enfkTU2Eom7DWOBERhmxhZcaVwe8qrD8eix0j3jiL7yXjuJ
7pOozjZS+nLFbMrbpml3C4GZLCAariXrN+YU+aKCIXLGUmIVpImw1lj9SQleqwBh
DuX/Be2bCgf3HnsY+w87DU6Tbiiygd+Lq4G+k5mdB8uSRoYgCv6WtN4Xw9eRloCd
hjiNU1xCXriGespsH/BXVZNhOiEHI6LzsW0SN/Yabd9CtepKQt6OCA8T2nS1Rtrx
q/PM2rKtW2tyXVs1dNKCuShuxqFkOqYQDv3BiJIgAYk=
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KwR69Dt8XEuMzpLGuX0pEwJQIMKxDWF4WCx5TvVtmPChFi6wCwYuBspxW8FN1mPv
7LDPnqI/XdyAGvpFjMeFBi9+llB8dCkFgC3B9LQYgpkZ81ZalIT1CTPkE5TMf3IA
aDUZzde7T87AvNIyk9sM7SznRU594KY6S/TjuKki63E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 450       )
wYR/4rdqW/gFloOwKvRSYdarkD++O+t9gQ1bUYvaFH7K5ZPvqv0k+1uwo9kY4sXE
AAA1HIvcj/jSofqrTXzpF/USUFnLvLCoX6YCTCro1grKnnKz7cRxFC08yEMPUDCG
`pragma protect end_protected
