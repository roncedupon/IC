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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BJBxWdaCjZ6AHKyJ2mAYW3GX7wexqYpurDpSo/4hPucgKq0rT8R+zhfysCwjL6pg
RYzabQ7DRPswAEfsvI+YTrBKeb5HZ9kntNQcRldb4MRD40zSdxDAj8/WIHm8ptrT
ro6l0RqM1H6DIfWY2wq/AnQfkWWABMoUxWcVUib4tKE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10058     )
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
`pragma protect end_protected

`endif // GUARD_SVT_LOGGER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IfaUYx6B7r+heQd0YXweyamb1ohfu9eC3a0nPPXbPLWwNFnXWtbxKoKV45cYiOtU
Ll8GsXvb9IqmcV24uaMn90vqd6+3F4AplgQn1NanuCt2JnCzgShrXJvbTAaJFBgd
VIZTmYZtA56bScaozVlA3ay++pWz0Z9JyW/95HtpqwY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10141     )
3DJxyLjaP0hLACIGcq1fuLsEjyvWeD0RF86UPCfHNGmYZQd/HXu/creW37xfrMFN
GiuFH9T8F3jV8OkNx5t/OJ7trsjbHS9qwfgE/P4OFa0kZajA2rbUteftvzDI48Gp
`pragma protect end_protected
