//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_STATUS_SV
`define GUARD_SVT_STATUS_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

/**
 * This base macro can be used to configure a basic notify, as supported by
 * the underlying technology, avoiding redundant configuration of the notify. This macro
 * must be supplied with all pertinent info, including an indication of the
 * notify type.
 */
`define SVT_STATUS_NOTIFY_CONFIGURE_BASE(methodname,stateclass,notifyname,notifykind) \
`ifdef SVT_VMM_TECHNOLOGY \
  if (stateclass.notifyname == 0) begin \
    stateclass.notifyname = stateclass.notify.configure(, notifykind); \
`else \
  if (stateclass.notifyname == null) begin \
    `SVT_XVM(event_pool) event_pool = stateclass.get_event_pool(); \
    stateclass.notifyname = event_pool.get(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname)); \
`endif \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

/**
 * This macro can be used to configure a basic notify, as supported by
 * vmm_notify, avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`define SVT_STATUS_NOTIFY_CONFIGURE(methodname,stateclass,notifyname) \
  `SVT_STATUS_NOTIFY_CONFIGURE_BASE(methodname,stateclass,notifyname,svt_notify::ON_OFF)

`ifdef SVT_VMM_TECHNOLOGY
/**
 * This macro can be used to configure a named notify, as supported by
 * svt_notify, avoiding redundant configuration of the notify.
 */
`else
/**
 * This macro can be used to configure a named notify, as supported by
 * `SVT_XVM(event_pool), avoiding redundant configuration of the notify.
 */
`endif
`define SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY_BASE(methodname,stateclass,notifyname,notifykind) \
`ifdef SVT_VMM_TECHNOLOGY \
  if (stateclass.notifyname == 0) begin \
`ifdef SVT_MULTI_SIM_LOCAL_STATIC_VARIABLE_WITH_INITIALIZER_REQUIRES_STATIC_KEYWORD \
    svt_notify typed_notify ; \
    typed_notify = stateclass.get_notify(); \
`else  \
    svt_notify typed_notify = stateclass.get_notify(); \
`endif \
    stateclass.notifyname = typed_notify.configure_named_notify(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname), , notifykind); \
`else \
  if (stateclass.notifyname == null) begin \
    `SVT_XVM(event_pool) event_pool = stateclass.get_event_pool(); \
    stateclass.notifyname = event_pool.get(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname)); \
`endif \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

`ifdef SVT_VMM_TECHNOLOGY
/**
 * This macro can be used to configure a named notify, as supported by
 * svt_notify, avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`else
/**
 * This macro can be used to configure a named notify, as supported by
 * `SVT_XVM(event_pool), avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`endif
`define SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY(methodname,stateclass,notifyname) \
  `SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY_BASE(methodname,stateclass,notifyname,svt_notify::ON_OFF)


/**
 * This macro can be used to check whether a notification event has been configured.
 */
`define SVT_STATUS_EVENT_CHECK(funcname,evowner,evname) \
  if (`SVT_STATUS_EVENT_IS_EMPTY(evowner,evname)) begin \
    `svt_error(`SVT_DATA_UTIL_ARG_TO_STRING(funcname), $sformatf("Notify '%0s' has not been configured. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(evname))); \
    funcname = 0; \
  end

/**
 * This macro can be used to check whether a notification event has been configured.
 * NOTE: This is kept around for backwards compatibility -- classes should be moving to SVT_STATUS_EVENT_CHECK.
 */
`define SVT_STATUS_NOTIFY_CHECK(funcname,evname) \
  `SVT_STATUS_EVENT_CHECK(funcname,this,evname)

/** Macro used to signal a notification event for the current methodology */
`define SVT_STATUS_TRIGGER_EVENT(evowner,evname) \
  `svt_trigger_event(evowner,evname)

/** Macro used to signal a notification event and corresponding data for the current methodology */
`define SVT_STATUS_TRIGGER_DATA_EVENT(evowner,evname,evdata) \
  `svt_trigger_data_event(evowner,evname,evdata)

/** Macro used to signal a notification event and corresponding data for the current methodology, but with a 'copy' of the original data */
`define SVT_STATUS_TRIGGER_COPY_DATA_EVENT(evowner,evname,evdata) \
  `svt_trigger_copy_data_event(evowner,evname,evdata)

/**
 * Macro used to check the is_on state for a notification event in the current methodology.
 */
`define SVT_STATUS_EVENT_IS_ON(evowner,evname) \
  `svt_event_is_on(evowner,evname)

/** Macro used to wait for a notification event in the current methodology */
`define SVT_STATUS_WAIT_FOR_TRIGGER(evowner,evname) \
  `svt_wait_event_trigger(evowner,evname)

/** Macro used to wait for an 'on' notification event in the current methodology */
`define SVT_STATUS_WAIT_FOR_ON(evowner,evname) \
  `svt_wait_event_on(evowner,evname)

/** Macro used to wait for an 'off' a notification event in the current methodology */
`define SVT_STATUS_WAIT_FOR_OFF(evowner,evname) \
  `svt_wait_event_off(evowner,evname)

/** Macro used to use the event status accessor function for the current methodology to retrieve the status for a notification event */
`define SVT_STATUS_EVENT_STATUS(evowner,evname) \
  `svt_event_status(evowner,evname)

/** Macro used to get the notification event status */
`define SVT_STATUS_GET_EVENT_STATUS(evowner,evname,evstatus) \
  `svt_get_event_status(evowner,evname,evstatus)

/** Macro used to reset a notification event in the current methodology */
`define SVT_STATUS_RESET_EVENT(evowner,evname) \
  `svt_reset_event(evowner,evname)

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Gj1f/z0kQjv0zFgX2I2pENZVfl5X8eIL4epvTyy4UCy1Px+3Ig+wtxxFkwNqpAen
/8nGJQ79MZCAaZDjrxcUUhy61Y/VusC/cZDMH6MtqOF7w/h7l/X0EDY54luHOX8q
bEaYXPu1S3/Vg5oyfOhQpwTI+h1SWkp+5U9yEoSFMWo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 799       )
dvCyD6D6CGkKxNDVo/WJcZCh1kuh+zYEHLa+6pp70L64paSIV6uWmZtItnqGkaAX
XGoEeXdRXLt94I0Px4ICCZMgFY677EUDip6ddQ5fgIfTK0mQu7sY4zs2zr4r9fW7
ffuMeBump0nERyr22Ekf/B0vNmtuV8MQvyGIhxtcAF5whtP52r2LNyd0LOq76B/G
d0zaR2QC3ctKktuCZmTXXgoQAvgRlAOqTH5ZxAB5XiQ6ZRcHt4hB6csbivILwRE+
6PkjKV7S/e7cb9OYbIT6vEUT3SSIroa9+8XNPpez9Jz9NGTERx3yT+Y5GNDfICfq
yv2u1fanM8elAjG0zwkLVWJjaeNVHf//RextX8DVEcs5wpmWf0bz4uRh1k6XujoU
gxQdLF0ueibVsnlRuXMEAX/s1eS8HLwpB6SNzYIhKuokw76UcomMx32zxtAyzZws
8n6iwIFI0a9j8nnTb7F5v8/NvDZ2qBOgJujXpnpx/ozGEPUrah3rNy+3hxG9aqUh
UlRuRQ84Ya3nYUIME97BFyvq5VbQ6L87q0nQkLwiSAkXzLIN25HP5eg0vN6Dop/X
bf6iK6NGj8cn0NVigaqvuRtKHRGFlVYYhIOnQQfUDAu41NS1UroTY5Ty0B6cleTG
+XUYK7SNyl9MhND7Kjoi/pjBiIEq3XNHY6SvNNoIBPMD+Bo2mrDAq8amRGJUzF8x
n8j3TEdkanLp89Xc5XVdRfRVwZQMXnKhH9YkrsxFz+JPOwFG9OJ7bP4umh4LjOro
sRpV8WHSgt7RM2vz1zVpfbB3b54X1WrNDIti8omN9s78Y6SMX5BvuLajyOte8JYi
4Y+DLkntSb4LBSeUSPQV3C2EkQT3oBsLuTvPUcj8Nlveh6DyPaNPfHiwoZI632s9
HZ/CK97uKUhTva588VagXdl3IONlTUlv3kk7olhWj1A6TL5aLBU6ewmJ9JYmcZnR
AEgr6X1prVo+v9XaS9cBC1uXTcPOeYuki4t+E7GiFnkLnDZURLcQhxjtUSN2BHhR
0QgBL+qCkZ3BPxsgbP2hThvPG4nYIxJH0Y+pyYIdSWM=
`pragma protect end_protected

// =============================================================================
/**
 * Base class for all SVT model status data descriptor objects. As functionality
 * commonly needed for status of SVT models is defined, it will be implemented
 * (or at least prototyped) in this class.
 */
class svt_status extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Used to report the Instance Name of a transactor to this
   * status object is for. The value is set by the transactor to match the 
   * Instance Name given the transactor by the transactor configuration object.
   * 
   */
  string inst = `SVT_UNSET_INST_NAME;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_status)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_status class, in addition
   * to replacing the built-in vmm_notify with an extended svt_notify which
   * includes the same base features.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * status object belongs.
   */
  extern function new(vmm_log log = null, string suite_name = "");
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_status class, passing the
   * appropriate argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(string name = "svt_status_inst", string suite_name = "");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_status)
  `svt_data_member_end(svt_status)

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Helper method to get a handle to the notify data member, cast to an object
   * of type svt_notify.
   */
  extern virtual function svt_notify get_notify();
`endif

  // ****************************************************************************
  // UVM/OVM/VMM Methods
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LjOQ2b1xtq0/0QQUAfGjuApP4SjvwOZhrnC7iPYNjXn7fCtAXy9qRLIhSHozuZhD
JxzY1LRVg/11bFAFh8e8i7/JPV+e5ShsZUIeHrcwsllprXqq5buAwF+gBHK0Eyhz
sUSzKy07jEZsszLgXYlHNYQ8zeLcVOtsoWTcVo5gh0w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6319      )
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
du5agVrplxrw4eh/SDWKFA==
`pragma protect end_protected

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lVv2bq4BNwahpO4Rfoqxj5tN3rj8ROsSK8JLOrNijV1JyNlolGZgxn8vK5ESDcvG
s9Au6DVs03YmbRU0U7k3b1pEaO7hfMmG3eTmSKlSWD0GKAJlKrCJdTW1WASeY2O2
eBM4D+iqZn2JsLOFdqkbuLvaYtIdTC7p7HvH5iF/YM8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14276     )
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
`pragma protect end_protected

`endif // GUARD_SVT_STATUS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OgdtfFxqlFC5MbziTusM6XtnREs0+6JEjHb4Ndq606vZjYjrgOvg73kUX1NioqSu
nELhP9qjizmYpFQAxKx3wcBpyDvQuxIorcQ967Bm2iOFRbRvhihUidM0hcEIRO97
QvrQ/RWQbCTvuLVMaVq4oUf1jq8rO7pX/Xs8OrIuTH0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14359     )
fTtI1m+vCXk4U5/8jqavxoaZnMccwnYhJeFbhR6EOoFRCC8y94cfXY3GmmfNCyEm
m5qclWK+S1c9zxl4QrKwz201/zNtSsaEh1pHfWprFVlBqO1O7+BySlRuzfbQCrkK
`pragma protect end_protected
