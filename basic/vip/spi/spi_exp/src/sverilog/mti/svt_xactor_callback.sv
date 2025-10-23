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

`ifndef GUARD_SVT_XACTOR_CALLBACK_SV
`define GUARD_SVT_XACTOR_CALLBACK_SV

typedef class svt_xactor;

// =============================================================================
/**
 * Provides a layer of insulation between the vmm_xactor_callbacks
 * class and the callback facade classes used by SVT models. All callbacks in SVT
 * model components should be extended from this class.
 * 
 * At this time, this class does not add any additional functionality to
 * vmm_xactor_callbacks, but it is anticipated that in the future new
 * functionality (e.g. support for record/playback) <i>will</i> be added.
 */
//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
virtual class svt_xactor_callback extends vmm_xactor_callbacks;
//svt_vipdk_exclude
`elsif SVT_OVM_TECHNOLOGY
class svt_xactor_callback extends svt_callback; // OVM cannot handle this being virtual
`else
virtual class svt_xactor_callback extends svt_callback;
`endif
//svt_vipdk_end_exclude

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * A pointer to the transactor with which this class is associated, only valid
   * once 'start' has been called. 
   */
  protected svt_xactor xactor = null;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor callback instance, passing the appropriate
   * argument values to the vmm_xactor_callbacks parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor callback
   * object belongs.
   * 
   * @param name Identifies the callback instance.
   */
  extern function new(string suite_name="", string name = "svt_callback");
//svt_vipdk_exclude
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor callback instance, passing the appropriate
   * argument values to the ovm/uvm_callback parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor callback
   * object belongs.
   * 
   * @param name Identifies the callback instance.
   */
  extern function new(string suite_name = "", string name = "svt_xactor_callback_inst"); 
`endif
//svt_vipdk_end_exclude

//svt_vipdk_exclude
  //----------------------------------------------------------------------------
  /**
   * Method implemented to provide access to the callback type name.
   *
   * @return The type name for the callback class.
   */
  extern virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();

//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to allow callbacks to initiate activities.
   * This callback is issued during svt_xactor::main() so that any processes
   * initiated by this callback will be torn down if svt_xactor::reset_xactor()
   * is called. This method sets the svt_xactor_callback::xactor data member.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   */
  extern virtual function void start(svt_xactor xactor);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to allow callbacks to suspend activities.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   */
  extern virtual function void stop(svt_xactor xactor);

  // ---------------------------------------------------------------------------
  /**
   * Provides access to an svt_notify instance, or in the case of the vmm_xactor
   * notify field, the handle to the transactor. In the latter case the transactor
   * can be used to access the associated vmm_notify instance stored in notify.
   * The extended class can use this method to setup a reliance on the notify
   * instance.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   *
   * @param name Name identifying the svt_notify if provide, or identifying
   * the transactor if the inform_notify is being issued for the 'notify' field on
   * the transactor.
   *
   * @param notify The svt_notify instance that is being provided for use. This
   * field is set to null if the inform_notify is being issued for the 'notify'
   * field on the transactor.
   */
  extern virtual function void inform_notify(svt_xactor xactor, string name, svt_notify notify);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to pull together current functional coverage information.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   * @param prefix Prefix that should be included in each line of the returned 'report' string.
   * @param kind The kind of report being requested. -1 reserved for 'generic' report.
   * @param met_goals Indicates status relative to current coverage goals.
   * @param report Short textual report describing coverage status.
   */
  extern virtual function void report_cov(svt_xactor xactor, string prefix, int kind, ref bit met_goals, ref string report);

  // ---------------------------------------------------------------------------
endclass

/** The following is defined in all methodologies for backwards compatibility purposes. */
typedef svt_xactor_callback svt_xactor_callbacks;

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PPalHQmi7rqZvW61OPhTPExeUTuD+oYhJ9j3+25O/2hQPj7y1VS2gBuUa9hGnPZ8
pUTB46rh4//HAWMVhF5fhxvCzrg0B+g6NS/FJMRBXpak8lYopCFcRfvLAc0SPZGf
zjK/PjsjrGB1r/tGCidVrr/01xEGwAfy2KtPNJ7+030=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1916      )
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
`pragma protect end_protected

`endif // GUARD_SVT_XACTOR_CALLBACK_SV









`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M4Ve+etwGh9mvgvZs+PRR6wzMpaEGM6RKQz9EJIHj9aCJRu0qPO1atbOolMgGnoh
HWxhbHh8R1oW92t6hN+5DQI1ZEqNfJv+6lz0v++8+hrr7xBnWPxBcUa0dxpNzEdC
hwqyvJne415S3+faAY8yeLQNaZObqyeuuAXiLSwlx7A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1999      )
fBxV/Cj1CgLW6ZYj+q3Wv0151fqSrwDxrb7W5YI/RYdsnp6dD8Sq1SsKVVe9KPEV
X7IOQ69WIFqZrQAasSSwobCJLvRU6lGl69RiLVW3fwXF4CMVRGVqaYtMoJDM4Q2l
`pragma protect end_protected
