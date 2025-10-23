
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
t5XWa2tOgnwfwf6UTg1K18wn1ROomNBZk/c2naaIrJTdeZUnS03wXZLpnD48dTO/
nDcNCzh9TrlWD1mFpQwAPXzs5z07azKoV6VXNG7urbiEiHkD/WyYxYkYa4gUKHqW
c3Ww63SDczxh3RTY/hbV/TeQB9XrZ/WfP8pnOWK7NhS3QBUoKQLPjQ==
//pragma protect end_key_block
//pragma protect digest_block
7I6ySzUYZQvMgaaREeArMytCLuU=
//pragma protect end_digest_block
//pragma protect data_block
QAZgEgsF+wr0rpuZrkI5xFkOODn8B2T//8V1gk163wxKQ43bIMdzxukQuOu1ajkz
VEGoj3LB/qQ3Ryt9EwRhW0oCVpS2Gf4DSHDmVOKd57VNSKxfFBcrEzmMdo9chn69
NYN+Syj8UrPxTO/Fe4KhUDzxRRCB2KY7qOCPlt8WzYl+fgigf98Foz7ly97o0v/w
ogiR1r5GDbqDhlJ/VUb54N5ZX6sviZIhLmxZSOrHjODa5ZK1P+F/nS2O691gbF7N
Xznk7Tg3l02aIt3yw7ylKO3gHkw6rNkeRtIRUyekr1/DPDIKGg4xWmKFvTBuzHdz
4RNGn+JvBF49rJx1Zk9Cvxiol07xhF+Dhqig0FnLuI2+yLz3yq5gFUXireIMe4C/
twMIAm8YFIAIG/tgd7LzL/qBz6EnGF2T3NqpVhOVwKo/FKl0kmBkYcugJSx0js0t
WoQ2xBq/ne0R4BvheNriiizsV3fHf8vRaS4xqRQkL/EXMcdtd+hXS9OM6cjBHIRL
IHrML3U6kmD/uUfGHNlbYG3p+KXPWNW99jgBQQhzqJO9/w1LnKG30k1nW6xfCRRf
/2Qs8zux9jIUcRDtbh8k/19AVUw80YJsHqjUH6BXRoLwav77hguxubx1X5TYQVyy
UU79h6IjMGSn0LOpzbaelNA9bL2opg0gqfuKOjGlWQHTuUiRBnCjUuvwZ2YHVnle
fSHw4Wz90UKyQ58Ye6lcOQ==
//pragma protect end_data_block
//pragma protect digest_block
Y9USPRI04WKKjk8rDq5r6lh0AuI=
//pragma protect end_digest_block
//pragma protect end_protected

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

