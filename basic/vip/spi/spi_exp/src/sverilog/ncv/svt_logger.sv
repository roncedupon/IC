//=======================================================================
// COPYRIGHT (C) 2010-2012 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_LOGGER_SV
`define GUARD_SVT_LOGGER_SV

`ifndef SVT_MCD_FORMAT_VERSION
`define SVT_MCD_FORMAT_VERSION 3
`endif

/**
 * Used in the command model class body for each callback to make it 
 * available at the command layer.  Implements the inherited OO callback method.
 * The base transactor should have defined a virtual method with the basic
 * prototype "callback_method_name( callback_datatype data )".
 * callback_name is of the form EVENT_CB_...
 */
`define SVTI_CHECKXZ(portObj, portStrValue) \
if `SVT_DATA_UTIL_X_OR_Z(portObj) begin \
  $swrite(portStrValue, "%0b", portObj ); \
end \
else begin \
  $swrite(portStrValue, "%0h", portObj ); \
end

/**
 * Logging support:
 * Used to log input port changes
 */
`define SVT_DEFINE_NSAMPLE 0
`define SVT_DEFINE_PSAMPLE 1
`define SVT_DEFINE_NDRIVE 0
`define SVT_DEFINE_PDRIVE 1

`define SVT_DEFINE_LOG_IN_PORT(port_number,name,width,in_signal_type,in_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  $fwrite(mcd_log_file, "# P %0d I %0d name %0d %0d %0d %s %s\n", \
          port_number, width, in_signal_type, in_skew, sig_depth, ifName, clkName); \
end

`define SVT_DEFINE_LOG_OUT_PORT(port_number,name,width,out_signal_type,out_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  $fwrite(mcd_log_file, "# P %0d O %0d name %0d %0d %0d %s %s\n",  \
          port_number, width, out_signal_type, out_skew, sig_depth, ifName, clkName); \
end

`define SVT_DEFINE_LOG_INOUT_PORT(port_number,name,width,in_signal_type,in_skew,out_signal_type,out_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  integer xTime   = 0; \
  $fwrite(mcd_log_file, "# P %0d X %0d name %0d %0d %0d %0d %0d %0d %s %s\n",  \
          port_number, width, in_signal_type, out_signal_type, in_skew, out_skew, xTime, sig_depth, ifName, clkName); \
end

// =============================================================================
/**
 * Utility class used to provide logging assistance independent of UVM/VMM
 * testbench technology.
 */
class svt_logger;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  protected string in_port_numbers = "";
  protected string in_port_values = "";
  protected string out_port_numbers = "";
  protected string out_port_values = "";

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  local bit  logging_on = 1'b0;
  local int  log_file;

  local bit[63:0] last_time64 = -1;     // Saved 64 bit time.
  
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_logger class.
   */
  extern function new();

  // ****************************************************************************
  // Logging Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void open_log(string inst);

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void start_logging(string inst, string name, string suite, bit is_called_from_hdl);

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void log_time();

  // ---------------------------------------------------------------------------
  /**
   * Buffer the changes to an input port, this task will only be called if logging 
   * is on, so there is no need to check if logging is on.
   *
   * @param port_number Port Number
   * @param port_value  What is the new value of the port
   */
  extern function void buffer_in_change ( string port_number, string port_value );

  // ---------------------------------------------------------------------------
  /**
   * Buffer the changes to an output port, this task will only be called if logging 
   * is on, so there is no need to check if logging is on.
   *
   * @param port_number Port Number
   * @param port_value  What is the new value of the port
   */
  extern function void buffer_out_change ( string port_number, string port_value );

  // ---------------------------------------------------------------------------
  /**
   */
  extern function bit get_logging_on();

  // ---------------------------------------------------------------------------
  /**
   */
  extern function int get_log_file();

  // ---------------------------------------------------------------------------
  /**
   * Replace "/" with . if exists
   * Replace ":" with . if exists
   * @return new string, string which is passed in is not modified.
   */
  extern local function string clean_string( string in_str );

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qz91kChT5W0mqudJXOR1P2jKSyuxboJ+rAVSTc9n2X/51tJHVpbaEg2m92N9k9m3
mCUfZBi4Gp6M9qaW7/hKdNdLLiGAsdGvGQagwK8neV7iiwnC2E4kQ83VLzSmVc5g
I2BksghkUqvAQW4IOcxMMJpkr+Iw4JE2258HAbUDTntQxxZRZilQAg==
//pragma protect end_key_block
//pragma protect digest_block
Ix+IX+7ThhmYq2TjL5YLD5dXHOI=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
OohfXWJCwWdOWE4zn3von73c5p4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_LOGGER_SV
