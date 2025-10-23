//=======================================================================
// COPYRIGHT (C) 2007-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_XACTOR_BFM_SV
`define GUARD_SVT_XACTOR_BFM_SV

`include "VmtDefines.inc"

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

// Backwards compatibility macros used to bridge a couple of VMT versions
`ifndef VMT_MSG_EVENT_ARG_TEXT_SIZE
`define VMT_MSG_EVENT_ARG_TEXT_SIZE `VMT_MSG_EVENT_TEXT_SIZE
`define SVT_XACTOR_BFM_MSG_ID_DISABLED
`endif
`ifndef VMT_MSG_EVENT_ARG_TEXT
`define VMT_MSG_EVENT_ARG_TEXT `VMT_MSG_EVENT_TEXT
`endif

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT BFM transactors.
 */
virtual class svt_xactor_bfm extends svt_xactor;

  /**
   * Transactor id used to associate this transactor with a VMT Verilog VIP
   * instance.
   */
  int xactor_id;

  /**
   * ON_OFF notification that is set to ON when the reconfigure() method is
   * completed.
   */
  int NOTIFY_RECONFIGURE_DONE;

  /**
   * ON_OFF notification that is set to ON when the get_xactor_cfg() method is
   * completed.
   */
  int NOTIFY_GET_XACTOR_CFG_DONE;

  /**
   * ON_OFF notification that is set to ON when the reset_xactor() method is
   * completed.
   */
  int NOTIFY_RESET_XACTOR_DONE;

  /**
   * ON_OFF noticiation that is set ot ON when the VMT model has been started.
   * It is reset during the stop_xactor() and reset_xactor() methods.
   */
  int NOTIFY_VMT_MODEL_STARTED;

  /** Controls whether VMT notify messages result in display messages. */
  bit enable_vmt_notify_display = 0;

  /** Controls whether VMT messages include the MSG_ID information. */
  bit enable_vmt_msg_id_display = 0;

// From dw_vip_transactor_rvm
// ----------------------------------------------------------------------------
/** @cond PRIVATE */
  int msg_to_notify_id_map[]; 
  int msg_to_notify_type_map[]; 

  // Vmt Suite Level messages
  //DEFINE_NOTIFY_MSG_TYPES_DW_VIP
  //DEFINE_NOTIFY_MSG_IDS_VMTBASE
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMON
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMANDMANAGER
  //DEFINE_NOTIFY_MSG_IDS_VMTCOVERAGE
  //DEFINE_NOTIFY_MSG_IDS_VMTMEM
  //DEFINE_NOTIFY_MSG_IDS_VMTMESSAGESERVICE
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMONCOMMANDS
  //DEFINE_NOTIFY_MSG_IDS_VMTTRANSACTION


// From dw_vip_gasket_rvm
// ----------------------------------------------------------------------------
  protected svt_data xacts [*];
  protected int cmd_handles [*];
  protected int xact_cnt = 0;

  protected int out_in_xact_map [*];

  protected int max_active_chan_mgr [];


// New for the BFM xactor
// ----------------------------------------------------------------------------
  /**
   * Handshake from the derived transactor that indicates that
   * change_static_cfg() is done.
   */
  protected event change_static_cfg_done;
  /**
   * Handshake from the derived transactor that indicates that
   * get_static_cfg() is done.
   */
  protected event get_static_cfg_done;

  /**
   * Counter needed because the methods used to set the configuration are all
   * void functions, but the VMT method set_config_param() is a task.  Since
   * tasks can not be called from functions, then all of the calls to
   * set_config_param() must be placed within a fork/join_none structure.
   * 
   * Since the set_config_param() methods are in a seperate thread, then there
   * is the possibility that the reconfigure() method could return before the
   * VMT model is fully configured.  Therefore, this counter is initialized
   * with a value of 2 when the reconfigure() method is called, and a thread
   * is started that monitors the value of the counter, and the
   * NOTIFY_RECONFIGURE_DONE notification is reset (set to OFF).  When all of
   * the calls to set_config_param() are completed in change_static_cfg() and
   * change_dynamic_cfg() in the derived transactor, then this counter is
   * decremented.  Once this counter reaches zero, then the
   * NOTIFY_RECONFIGURE_DONE notification is triggered (set to ON).
   */
  protected int config_set_threads;

  /**
   * Counter needed because the methods used to get the configuration are all
   * void functions, but the VMT method get_config_param() is a task.  Since
   * tasks can not be called from functions, then all of the calls to
   * get_config_param() must be placed within a fork/join_none structure.
   * 
   * Since the get_config_param() methods are in a seperate thread, then there
   * is the possibility that the get_xactor_config() method could return before
   * the configuration object is fully populated.  Therefore, this counter is
   * initialized with a value of 2 when the get_xactor_config() method is
   * called, and a thread is started that monitors the value of the counter,
   * and the NOTIFY_GET_XACTOR_CFG_DONE notification is reset (set to OFF).
   * When all of the calls to get_config_param() are completed in
   * get_static_cfg() and get_dynamic_cfg() in the derived transactor, then
   * this counter is decremented.  Once this counter reaches zero, then the
   * NOTIFY_GET_XACTOR_CFG_DONE notification is triggered (set to ON).
   */
  protected int config_get_threads;

/** @endcond */


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the svt_xactor parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor object belongs.
   * 
   * @param class_name Sets the class name, which will be returned by the
   * <i>get_name()</i> function (provided by vmm_xactor).
   * 
   * @param cfg A configuration data object that specifies the initial configuration
   * in use by a derived transactor. At a minimum the <b>inst</b> and <b>stream_id</b>
   * properties of this argument are used in the call to <i>super.new()</i> (i.e. in
   * the call that this class makes to vmm_xactor::new()).
   */
  extern function new(string suite_name,
                      string class_name,
                      svt_configuration cfg,
                      int xactor_id = -1);

  /**
   * Sets the value of the transactor ID.  This is only needed when using IUS.
   */
  extern function void set_xactor_id(int id);

  /**
   * Gets the value of the transactor ID.  This is only needed when using IUS.
   */
  extern function int get_xactor_id();

// From dw_vip_transactor_rvm
// ----------------------------------------------------------------------------
  extern protected function bit[15:0] map_vmm_to_vmt_reset_types( int rst_type );

  extern virtual protected function int map_msg_type_to_vmm_type( int msg_type );
  extern virtual protected function int map_msg_type_to_vmm_severity( int msg_type );

  extern function void process_internal_messages();


// From dw_vip_gasket_rvm
// ----------------------------------------------------------------------------
  // Functions provided by the different model transactors to create model xacts of
  // proper type
  extern virtual task new_typed_xact_handle ( int chan_id, ref int handle );
  extern virtual task new_xact_specific_handle ( int chan_id, svt_data svt_xact, ref int handle );
  extern virtual protected function svt_data new_typed_out_xact ( int chan_id );

  // rvm methods
  extern virtual function void start_xactor();
  extern virtual function void stop_xactor();
`ifdef SVT_MULTI_SIM_ENUM_SCOPE_IN_EXTERN_METHOD_ARG
  extern virtual function void reset_xactor(vmm_xactor::reset_e rst_typ = SOFT_RST);
`else
  extern virtual function void reset_xactor(reset_e rst_typ = SOFT_RST);
`endif
  // common vip methods
  extern virtual protected task manage_chan ( int chan_id, int n_threads = 1, vmm_channel chan = null );
  extern virtual protected task catch_buffer_event ( int msg_id, int buf_arg_id, int chan_id );
  extern virtual protected task catch_output_transaction ( int msg_id, int arg_id, int chan_id );
  extern virtual protected task catch_out_in_transaction ( int msg_id, int out_arg_id, int in_arg_id, int chan_id );
  extern virtual protected task catch_initiation ( int msg_id, int arg_id );
  extern virtual protected task catch_completion ( int msg_id, int arg_id );

  extern virtual task catch_msg_id(int msg_id);
  extern virtual protected task catch_msg_trigger (int wp_handle, int arg_id, int arg_type, int arg_size, event watch_trigger, ref int obj_handle, ref int int_arg_data, ref string str_arg_data, ref bit [15:0] bv_arg_data, ref int status );

  // Note: getXact_t is changed from a function to a task.  Also renamed so as to not
  //       collide with getXact below.
  extern virtual task get_chan_xact ( int chan_id, ref svt_data xact );
  extern virtual task finish_xact ( int chan_id, svt_data svt_xact );
  extern virtual task garbage_collect_wp_xact ( int xact_as_handle );
  extern virtual task sneak_xact ( int chan_id, svt_data svt_xact );
  extern virtual task sync_cmd_stream ( ref int status );

  extern virtual protected task do_post_chan_get ( int chan_id, svt_data svt_xact, ref bit drop );
  extern virtual protected task do_pre_chan_put ( int chan_id, svt_data svt_xact, ref bit drop );
  extern virtual protected task do_buffer_cb ( int chan_id, int msg_id, int xact_as_handle, svt_data svt_xact, int obj_handle );
  extern virtual protected task map_transaction ( int chan_id, int xact_as_handle, svt_data svt_xact, ref int status );
  extern virtual protected task map_to_transaction ( int chan_id, int xact_as_handle, svt_data svt_xact );

  extern protected task start_command ( int cmd_handle );
  extern protected task end_command ( int cmd_handle );

  //extern protected task clear_xacts ( );
  extern protected function void clear_xacts ( );
  extern protected task set_xact ( int cmd_handle, svt_data svt_xact );
  extern protected function svt_data get_xact ( int cmd_handle );
  extern protected function int get_cmd_handle ( svt_data svt_xact );

  extern virtual protected task set_max_active_chan_mgr ( int chan_id );

// From svt_xactor
// ----------------------------------------------------------------------------
  /** Extended to update the NOTIFY_RECONFIGURE_DONE notification. */
  extern virtual function void reconfigure(svt_configuration cfg);
  extern virtual function void get_xactor_cfg(ref svt_configuration cfg);
  extern task get_xactor_bfm_cfg(ref svt_configuration cfg);

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DG9KzUZJKm3Qp/5toCt9KO5cRhGrUp28fko5z456sTog2y3c0xlhqCAWzeYWhJkl
GwjOwpPJndMuHLAs6oOTAz1PQhQg5vbsTui9cjD/bIx47EL5FZ9hkPg3z58jl6aJ
TGg73+gNk3z/Tcm/8CLb0ruH62Z3g+7FY0dIaghN2ts=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 35135     )
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
`pragma protect end_protected

`endif // GUARD_SVT_XACTOR_BFM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
odG7A0Lm9nvUeK7g3IWNwM2BDlGU0LAu/b7192H+VTkAt3GWkx1arsIMrBUkpeK1
jRYZnXDB9u9zk6B37oX+GDztJo9o75kmQKOz6lRc3JlTpPQ0lqizjosi3/YGGJBU
qMUv0WW3P3BxVlhiFRsZQRoRXzZ0ovySF4YPIeApv+Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 35218     )
52FCBKDg/U5OqJ32rG1SY/U5qwg5eNjvkezPhW5tnS/nutOvRv4jYYfvNMOeGu2j
JfbpSe8XSJQVLH5pAOc+HtYvd/pC2CJ5cebdBHvXROcLAnS+nHIp7zFouXYPrRZU
`pragma protect end_protected
