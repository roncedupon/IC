//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_NOTIFY_SV
`define GUARD_SVT_NOTIFY_SV

/**
 * This macro can be used to configure a basic notification, independent of the
 * base technology.
 */
`define SVT_NOTIFY_CONFIGURE(methodname,stateclass,notifyname,notifykind) \
  if (stateclass.notifyname == 0) begin \
    stateclass.notifyname = stateclass.notify.configure(, notifykind); \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

`ifdef SVT_VMM_TECHNOLOGY
`define SVT_NOTIFY_BASE_TYPE vmm_notify
`else
`define SVT_NOTIFY_BASE_TYPE svt_notify
`endif

// =============================================================================
/**
 * Base class for a shared notification service that may be needed by some
 * protocol suites.  An example of where this may be used would be in
 * a layered protocol, where timing information between the protocol layers
 * needs to be communicated.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_notify extends vmm_notify;
`else
class svt_notify;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
   /**
    * Enum used to provide compatibility layer for supporting vmm_notify notify types in UVM/OVM.
    */
   typedef enum int {ONE_SHOT = 2,
                     BLAST    = 3,
                     ON_OFF   = 5
                     } sync_e;

   /**
    * Enum used to provide compatibility layer for supporting vmm_notify reset types in UVM/OVM.
    */
   typedef enum bit {SOFT,
                     HARD} reset_e;
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Array used to map from notification string to the associated notify ID.
   */
  local int notification_map[string];

//svt_vipdk_exclude
  local int notification_associated_skip_file[int];
  local int notification_skip_next[int];

//svt_vipdk_end_exclude
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * The event pool that provides and manages the actual UVM/OVM events.
   */
  local `SVT_XVM(event_pool) event_pool = null;

  /**
   * Array which can be used to VMM style sync events to UVM/OVM 'wait' calls.
   */
  local sync_e sync_map[int];

  /**
   * Variable used to support automatic generation of unique notification IDs.
   * Initialized to 1_000_000 reserving all prior IDs for use by client.
   */
   local int last_notification_id = 1000000;
`endif

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class, passing the
   * appropriate argument values to the <b>vmm_notify</b> parent class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(vmm_log log, string suite_name);
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class.
   *
   * @param reporter Reporter object to route messages through.
   * 
   * @param suite_name Passed in to identify the model suite.
   * 
   * @param event_pool
   */
  extern function new(`SVT_XVM(report_object) reporter, string suite_name, `SVT_XVM(event_pool) event_pool = null);
`endif

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lBz63yx4nVMvgI5ULdr3zez5qYYeM+edVuJpW/tT4uugbreylHfgT6bqTHC/dh7Y
TOFbx40ZWQ+6qVp/5F/S2h5oHh/27mxbgSs2+Ekl9lrwLAL/Qo3/q4owM10typxP
7VQ85o23TXrk9VOVVV1vlTrTTl/BLNqbV/RQ9xLKu6Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 831       )
wcAa85sGDWw3aaEKE8nA7YZQLcsN1aK8PcTUpzD7JkBMFZttingPcFbxDvD65f0V
VDuocpY4/JsXOvLJMiZ01CY4jhQIzKyJ7JoWp8zhCGq4MdOdC47RlYEim7fA4W/7
nroDaBwTClFxmKQUIzMLDrZBPykM27ZFvkhSVvdQRyUKqnJhc89lrYAt2CGTC1w7
t9ilVDh5wS/8BKey6Fsqae/z36dXhw0uuVFnO0JLQe78h+p71OcOIrw0tf51Fe3/
KBMC3QS8Lezzvt1tx7Hr2MkoQiFxWhlb5AiugljwdysqzCf+C1L4nBSTC/RlT2xz
EwqC/M5ZCYaAF4yKGmWeYcY6u/UdYpE6lYeXF5Y23nhtWfjtevxIe1imd/GI/fHQ
B8kA+OVIQhrXplpaWvs3uh8rrRdpcNaC+DI3VZH6MJJnaF6VNNUB90B5WwTTmYGa
+m60n1BM9mDW/XiQAPca3GznRNpN/jltVtH2godLudxRLKRweT+U+CLjS4VRuoA9
jotlybA+uZKkxPT7+cF5tLmUd5UTC5o0r2tptRC7eqJZvTqhxNBBAyP/+WtRg3SO
PAKJt2WC3ACwBJTz08Z+AG6D50cCXo7UxfQoozjzsgup98wSR1ex1N7vgC3yen71
evUao2CY6OJh+abqGqq6Qtl2V9QWZI4InJDngvgH5ISVPV3S71NwWKodzIX6q+w/
2Zdp/ECEZ2hReNqnpSB3zJYoxmgJMXLh75UO+A/TBnI92tlMotRPudLzusDU9awc
zBeHSEgPJO6wVM1Em+bvf/roQgMDRleAgU2b2pi23Lfyc3SogSIarbDvDnpQL2G7
CmNWu1ip4KVvGOF0cEBKtaovgqbCtE5k5QmhoyNKWR2PZYYPWXVcz869vdAvJFEk
DoHmJmb0SJukKsGmAut7o0Erxvqb6rkRL9dZOZWCCQQwupd11ZoX1Nj9nw2sIa1O
kQnoDvE/zsbmvKCyOZTm+djYQv9n3xCQeVG96b4h1d+YVVp9VkGTyurzJNq2Vkad
9Un+aePsGkOey4edExKpakNgM18NNDrf3wAnv1FjKFd76RrUKRMMBQIsIiiw56vc
Fhc3LuR4BSEQ0LJ4dOFELg==
`pragma protect end_protected

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM.
   * Used to provide VMM style notification capabilities in UVM/OVM.
   */
  extern virtual function int configure(int notification_id = -1, sync_e sync = ONE_SHOT);

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM,
   * while associating the notification to a specific UVM/OVM event. Used to provide
   * VMM style notification capabilities in UVM/OVM, tied to well known specific UVM/OVM
   * events.
   */
  extern virtual function int configure_event_notify(int notification_id = -1, sync_e sync = ONE_SHOT, `SVT_XVM(event) xvm_ev = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to check whether the indicated notification has been configured.
   */
  extern virtual function int is_configured(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to identify whether the indification notification is currently on.
   */
  extern virtual function bit is_on(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to wait for the indicate notification to go to OFF.
   */
  extern virtual task wait_for_off(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to get the `SVT_XVM(object) associated with the indicated notification.
   */
   extern virtual function `SVT_DATA_BASE_TYPE status(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to trigger a notification event.
   */
  extern virtual function void indicate(int notification_id,
                           `SVT_XVM(object) status = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to reset an edge event.
   */
  extern virtual function void reset(int notification_id = -1, reset_e rst_typ = HARD);
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification and to establish a string identifier
   * which can be used to obtain the numeric identifier for the notification.
   */
  extern virtual function int configure_named_notify( string name, int notification_id = -1, sync_e sync = ONE_SHOT, int skip_file = 0);

  //----------------------------------------------------------------------------
  /**
   * Gets the notification Id associated with the indicated name, as specified
   * via a previous call to configure_named_notify.
   *
   * @param name Name associated with the notification.
   *
   * @return Notification ID which can be used to access the named notification.
   */
  extern virtual function int get_notification_id(string name);

  //----------------------------------------------------------------------------
  /**
   * Gets the name associated with the indicated notification ID, as specified
   * via a previous call to configure_named_notify.
   *
   * @param notification_id ID associated with the notification.
   *
   * @return Notification name which has been specified.
   */
  extern virtual function string get_notification_name(int notification_id);

//svt_vipdk_exclude
  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void log_to_logger(int log_file_id, bit notifications_described, svt_logger logger);

  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void mcd_skip_next(int notification_id, int log_file_id);

//svt_vipdk_end_exclude
  // ---------------------------------------------------------------------------
endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jO+/vhF7qYSQ8o7tQQsysT/txHIFP1ZWvv8UY3qVR26WulFfMzRk7N1njD3W9+x9
qSdqSkv1HqeQoDSgE7t986ucqV9S09pbHS5qY+7hSwBzHZor1fDi9sv9kL/i1zUU
HELYq2cuc4+88xb+L7z0Tdaiv39RFS8cC92/lxzdzBs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18565     )
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
`pragma protect end_protected

`endif // GUARD_SVT_NOTIFY_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cts+zb8y2xFazQWWi+mb0Iv5MMDeIZ6IK70GPzYSh+NNfZNIjQoF99Ol4NKi6PC5
UmyubSx9v4qOZOwisTgnkthWSl1IsTQzQl7qPnIhi8+dgGGgNGFVtWhf1Z5E2CDZ
ZoVlZcIIsRc1UeC5kd2zEc6dje07iFvCYocMDh07Hts=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18648     )
NiVBAJCxAEbnXYAGvelg84SDlhKpb2PJeougCQkZe1aB4GMAqRKRhYSVfMwQ1htb
EWVeEKXcQjoClNNgNpl2+kfrH20wlU/ADUnC3/SkJo+NwF2EFyvtioKOd9LEI/ee
`pragma protect end_protected
