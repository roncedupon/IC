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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Xssi1Y9PeVPPvNk5OeZsCla/eVUdF5dildsC/szKhsNGBfuyi63ksBYISjymL9VN
a/cYy3T1mKKg+yjrH1nIbDnqfWoSQPS420o7NTiZb0AYyvzkT5QMMjTETmz+UxKM
kV0siQopdWLv5jD625lMLXYIeioNYsMEgqyMBTyTq2BcSfxvW7mE4g==
//pragma protect end_key_block
//pragma protect digest_block
MADvLAV0mUWOhXn7VnZNK542VWk=
//pragma protect end_digest_block
//pragma protect data_block
azR1YRUu6v+tF/Pt3EO6vSAehMi0OCFXiF7cRqxtUkkNUzw7aAIunfGdNON427Kf
TKjaNMeDEmL7i3QfKOAVJ/efLcecs/b89K0K7Sdp1uCAKLloUodHfRVjE/WgrEux
Uh9Y/qOgt723GDiDLHT40TZ75e9jdfirz6EjArMxX4xWNi0uUapIT94O/2w4Z7GJ
UIn1PexYm0qAlV/fjXsO3XdxXCWtlqR9sbIqYLDMwGcx5ZkwdiqrZPMF+vv4bQa1
PCKYk4wQrihvzWhIb3wMab4G0IuF1mFMuDDw7H7QanWBvSkQ1uGss7pdApeXNQoK
jo1dMT9Ze8XaeBaEf3QedztTfpGkFFkt8o3y59aJrBRPbcLfXXFnj5ga614/rWNv
Mex1OKCHQe26rDFGS+6ntjsyhFDTt3H07BPfi+BLcre1AerFGDv29iRsq3FmGcff
ZTtreSIprvYh9WM+eb/riKDGOhK5QkzF4/4bfmiOM/qOxVSY91HsPzPBmWdCRgy7
PiCiTl33L7bluHCws8TX2JDFLQb7JnBZ+p36VOswKFSSRXt/w4UIYJYIBn0YtUTu
N/qUcsYF4VyhyvY42o/QzCQUqulUXJzVtUXDVOI4BdxJlomG4mki+Uo5LpCmpLMn
EU5bP//tgl9CNd0zRwRsB6VS+Wd/Ibpn8qAU2VP/Jk3CLOn1fyqu09QGVDjnPvT0
YyNc9QRTIdXZylqH4i+BbufYmlGmaRI2eqrQo1yIZ3JHzhaR0GLiwLSHf3NkhuuW
QbEoGThK2SK6U+UWuHcu9vFhI1g1hiJz4lTPIRmmvuqQJ9fGgJkVp2yzWo9Tf1dA
hEZ93b4E8c3940O4P56QOsepXWKdEnnMLn93yuRlrb+73gWNwaBqHlqV8kxeHzMC
CmHaEQfjHxjtIM2hSamwr8B9BIi3WF5LStko5jiOUlIxqbAY2CU7CJSToK1KlWmk
8zWEdYXG1jOD6KZBGhyF3MOnBfuQNDGKSWkLKmR6RmIymsIsnWHxJZ9uEwXzrM5u
gKnuRRMy7bPBRCIxw/pBCa+10s48SSHHOKw4wrzsgfH3BL70/KhyMfQpe3KWYft6
ssvrRnFwzj3seFCbpm7t+BOrbdvwD9DndKcdfVTweM/YccTBIYfEkz6UgRyrFtNl
9zZaxQf7IhS4RbfT13kcYprwSBy4t0Oam628x+hD68I9ncqwKbgzUD4IFP97Aw5a
vpvzc7Oz+D/JRUwlUsznD6i1JPh6+RwOk5pvlbbOYydrLCTpxSQ87wFe/0DK1HNC
jTeFi9ELGjRSNaNWu4X9NIIrOOZ9doZEyGCAx2HUecGU0g0NcTic+el3pmtB7D/3
xRVTL6BIkZYxZWYRXyuMpJFakrwHA0jGLRCdWY96DLnUeO/f+LZbAIJTNN5HtW4D
yj+16MMjBeU/jmD29SYzGlLxK05gxCmDjbNk0EqBiI93WC+7bmmhPprE7InSSWSp
Jbnq/DWdHHy2BUfDOBRjvZ4Rwnc4EGJnmiV3vN7Cq1CG8oqR+t5jS+xybb76aVIc
3E9sQu8lzeM7ZDmDhLU/HGlsLmmIid0Idmm7tPxH/C9mLod/nZbSg/zx+RGv8Prm
0I6/pZqHqoNqkBktJHyg7yjTUppoBpbJD83yFEaFBF839eJAbsEwc+BfTbeq252X
/HWGo+rBnnevgkYXxITh/8XmNNjSz8tvmgWMpbu4OnK0jrSkhEO89hn08JE2acO2
5TJIPHa/zM/9XdsOmcY1UufAiRNpb8C6O9nHRq/19C4WbWSm7R4j9/vh8urQpgFZ
rsh31i7o8c+Kc7sIK2q4iOwaccHJSc/bO0qpGcF66cqXuqRYg1t+hnVa18niRHTJ
+3l6Ee1L+eoTu73GI+Ggk1ZKUrrSQmt7ux29wFQ4p9ZGjaDXARD/5+sfMoSy1UkW
yEo5FZXhXpfwEvOkxBr3MNmD3gwRMo0ebQa8iaS1S2ol5N/dt/97vR+R7AlcysXT
Lv8HZvxX3Dqm/5LyGagDifwHziciLUAbg8SFHhL/bh2FVVPedxkAA64DezTcXaSb
jVM9vj5/0V054gBER6+JophL27w3Ps67PtqfTTiKxGRcPKNqLqWW4IlNAi9YHw0l
xdqsOZTuzyQdTr/MkJr39PHa71llJ7fQkC03AmJ1l5SID8aOjPJfUMSefziPSYp3
XrBOfnraPhGgCVNxvk7DHDYjbr11Ad855KWBWFB76LOfXYiFxlZ9kZPR5QU8xrrY
hMNXlup64CCT7n3LUE7/pjDIuE7w8F6OBOa5sblASSqCW/qULWl/VoIoLIOp6lTn
O198E8mBZZXf5kRB+0DoSjSB22LDyGLVL99sdQ0WDFMJxCvnkqK1xuXJHJeWOcQn
a+df+puIm/zhRsUca39g20IrHIC5jXxtp04b6nC3X9NhRdPJLEGLoaLeRodOydXD
1tr2Nvdnm/MDA97+w/YsGd0FSdcV+NNKnJUww5jw9+IUVXEISrA0sT1AFcvjbIuP
780fgmNEZuaml/joMI8ltbZqedOTT+Dj5V6Rb6OM+EDMYsVjr6assoHtPglj0kCv
zCnktyvBnZ8dWzczfNl+uFTHt1l5/ochGcd8knJCwzXZs7jt5xzSVWkM68Z3vj3h
dtZI/hR66xqAlY8m0LAeZyCubjP1eOLfatIvlpkMh9MCYjrTKQNnyJigDgKuznTl
iJgJq5dDhczyrZ/CjrTsIQ4oOsLPuJO8Ets4GGOWTSHNCVP0K9KQvctvTOrnRUHX
VsWCVMlSERMpxBDHe5bQ9Em4e1DrKXJ0BQBrbDodz9s=
//pragma protect end_data_block
//pragma protect digest_block
mlfiOnUpHXJqS8kE9Xws6d8zeV8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_XACTOR_CALLBACK_SV









