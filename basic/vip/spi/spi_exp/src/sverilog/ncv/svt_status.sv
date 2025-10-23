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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qFD8EXaTLFxIPJ5X40ugz4NMFxjpHC3eR4VtEgSlTLClON0DxaPJUOSEWZEqzFg1
p8NVcwjehCh4toMwYY9C8oGE5HXPWAmxukyuniHuBqvPpQv0WcLEy1rVZ52Z1RJ8
nbHiO3Va76UjgWppVmpq3MCwCZflUKL4uvQ73w5esE7bvEmjVTxVWw==
//pragma protect end_key_block
//pragma protect digest_block
Fb9oaOgq+DLWJvyc/WpkMTP70eI=
//pragma protect end_digest_block
//pragma protect data_block
qsLIvD2hxXdBuD9axw7mmDS1FM6H62KYxU/hLjRytQvdseWmD1+bHtg4HHjxBo3u
4lH58SXPq7rWqGSv5YF8ebPiuS2muSTRAInf8PJ62WvSrL8lnZ8kubgGat8kNUer
8fAbGP1zYSmylFIIVL+/YLQTnotLbucfA8MqMpbifSp/ioBTx0L6Bd+7YUbOLFf6
ARluM62ZimMNv+mSVdoRZnKrCHgVYaD0HlCr1gtLjMJp/oSdogcAtQu+DrdZGSQO
wEtFeNVdISLxJvOnkBPeoyi8mHSzCPCVKCqj+JpDnRKmRyqTMgKE7jcj2iQU2a2T
X1kUbH7CeVjuvJ6ih+4zHCzsDQZpRhh0oGQXAac4g4M2Ljjx1jkhhPCc4l/8E8CP
ZtjnlvGnncbIfFxyGc9l/0YYU7vJJtL8TPfp7Ytx7TtqXqxjuB1j4hOWU/ptdBZy
qURFe20rZyLWqv6Mqc9HX3kL0CncYuviW8VXU735oUqHFahq/z9PT0gP2IXvliOi
CKfEVRbxn7VY5eSrSVpHzjx78FjsC6yo1cVK55i6JhAo9hUp+2NABvImQcSBtqdO
U24X/TxXndVrrxnqO2SIkTiOEhGk9V3Rau6ssQpnlbYzubJkJ4GfzKmDvszHOk/A
W0cy5HapKHzLHkyBHsvEBzLSKuKh8shGq7gR62/mBrV8RqJ02hMVBpfBpw3hFTuI
Zob/YZqwIM9aGWt8szQhw0Jbj7VnqKyKVgk87MmstRgP7/TrVU59OFysYZjEgZHM
G0Qtpn/4lIDE0IVKZbAqeN5+df6sXpyJqdm7jFl+tQ8APtmYONkpnmVoGjXXNjng
MhTzRrqqM1jihtWVYG4JN8BI7GyT0UtFnmh3chthEVLr6ppRQMKQ4ZRxOVXWEwx6
3QQ7kSc4OZ0053uPEqOfJpKThonCQSOzLaeM9SSP3gw2fwYq+r04mVVCtD0ErPRR
SiUak7YOV9JvuD7Unmt4Sg4KFrOZbu1nbHBOlGOtm77gqt9Cm3F9I+tMsOMxyc73
evgNAffOKIwNJT22U+Goc95DyLk4f3eUIZu9a+TT93Qxoo0ySq9ReTele+my0AGa
weWkpaB5bl/MdXBNScPpyU+xQ2W3y0ObdLiP2IHtOZE+zbBvCKf9aU0cR3wkpdXl
YBJe2I+FFbeOrE7do5Zqbvcf+WIw4VHnlekcTttwcYNg4imI3Uz48izPf0H+FoXr
HY7J/9w6/CRmnahaGPHMfCNGJnPfWsY2lcLfL/0mCBsQrAt2g/lQ4b42L7rXtNm2
Np65NFY2CPUf4QMDIpADOQ==
//pragma protect end_data_block
//pragma protect digest_block
U5KihcakExNVg2xgwYrovNY7iK0=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
I6PhkEX8J2eoZOH6qvKQ31LlzjLbsMHzRgPOX0YuCr4m+GCJ9cCVPtLJVFtt1PyC
vaCG2IX/MIw/ay118sGjnJnHA8pt/vYpwboUd26tbjzxftSXz0D9droWRtdTI7fm
MbEGhBojmv+ASa8/cVLo4xpd3ziJixMkEdomPyuQL0Lh7outTCcxhQ==
//pragma protect end_key_block
//pragma protect digest_block
6AMxbfaejVjMHR3TcfHIx6zkkrg=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
lThiexgvXeJp+pd1NjLCex5kPio=
//pragma protect end_digest_block
//pragma protect end_protected

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XmOAkKs788qV1h+qSOzsSXl18Bc1udIWBcuybecbBK6GdlufsRGmBONrLWvUtHw9
NsP556DG/OFkk89QZhCokbZkg5ZiNC6QPCOikWcWBXk4pJC3YXFofvnAuPNVO2Km
98q4b0TaP80RKXjIn4Ou5u35KXxQ0wAyZOoeTXWRMBgtCjnFmpdDsw==
//pragma protect end_key_block
//pragma protect digest_block
lh/j922V9rrl03RWAmT666cEPn4=
//pragma protect end_digest_block
//pragma protect data_block
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
NVTSWQi5eZMU/A/R5r0nsg==
//pragma protect end_data_block
//pragma protect digest_block
RAKADxoUKZI9dYWmrzl0Y7RZ0Cs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_STATUS_SV
