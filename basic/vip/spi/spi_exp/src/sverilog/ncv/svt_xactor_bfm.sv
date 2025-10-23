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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ozeK2P+LwIcrMntd4JndCn1ouY9WAwI+68Rt9nABEt8eSIDeN6jSw5wlRGk2BmKE
IH4rKFMJ8MRyOtfixhC2fWriJIHintlMYGNZBUlgh5HasA3WrDOD4mNpt3Ui3QUN
w0grhcoGbtuxx2QH4FYT0pN0EHZRIcyRYYM3Wc56075Q9+0jAx4WlA==
//pragma protect end_key_block
//pragma protect digest_block
pZ/Ck02I2H+VDHXKGKF1GPZjC4c=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
vLoANRM+jBY4NZ67OdL5IGAy3+Y=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_XACTOR_BFM_SV
