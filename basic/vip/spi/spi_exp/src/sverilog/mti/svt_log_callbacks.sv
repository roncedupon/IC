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

`ifndef GUARD_SVT_LOG_CALLBACKS_SV
`define GUARD_SVT_LOG_CALLBACKS_SV

// =============================================================================
// DECLARATIONS & IMPLEMENTATIONS: svt_log_callbacks class
/**
 * This class is an extension used by the verification environment to catch the
 * pre_abort() callback before the simulator exits.  In the callback extension,
 * the vmm_env::report() method is called in order to provide context to the
 * events that lead up to the fatal error.
 */
 class svt_log_callbacks extends vmm_log_callbacks;

  /** ENV backpointer that is used used by the pre_abort() method. */
  protected vmm_env env;

  // --------------------------------------------------------------------------
  /** CONSTRUCTOR: Creates a new instance of the svt_log_callbacks class.  */
  extern function new(vmm_env env = null);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is extended to catch situations when the simulator is
   * about to abort after the stop_after_n_errors limit has been reached or
   * a fatal error has been generated.  The only objective is to put out an
   * appropriate Passed/Failed message based on this event.
   */
  extern virtual function void pre_abort(vmm_log log);

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ed5XUvuyw4kySjswIE+uiYGSKmw33+aoSb5eDp9ptegNzSwIjZA3KHgTz+v2gV/6
Z/Iqdbe+W9ZsiIlFy7MokRvL3P2GFzFVlALMa35E1z57lxLzEpD7qWgS2JI4rMBm
6mLSn/0WOpzZA1l0qbXScMF9PKy56FOKyilGoDBtsr8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 762       )
y4OxdXtvs18vyZq8fcVzmQpIDueK95ydIe+r6uzZ73KWKSHHFK936yZsQ3N0/QX9
qtAOK+VSM2SC4cAH3DLsqRR9Q426R8r/gzjnVGCy4IlhaEoA++szTfdQK2PHDi+3
TCZ1aPSVTguNkLrICWtgIa8xhC/EKvTDuhViRIGUM34P+ACIZ622Z/BFw/8YooXP
/5TlVtFJzIZf/qxf2UxhwahgWbQYJPb1zvz8PdRa519seg1MKqF7HB+9xXNsSZQ9
ATxF4jAgB4aWOuy8idL78PKNO55t1UAeObLtMCE8EPySwoWf3DRa7YY9yXgDZJ7X
faYVfI46Z0HobTB47XCEVF2WWO5at9UvYGXlNjUaMDqGCYJE7UG2Nnq125m1a+3y
dA1IVnBOO9epl8pfryeQKBR4JwdJ6lpaROxBto6VKRnvbE1bbaUnXpAUOjBi41iv
8pS26Edf+Bm0XEG5bFeoC3NiPjJlS7XKCL36XUfvYDOgvTXa9+qPXoEHsPzXnDgk
wyX62KXC70hOl54nHBNqjliZQMpfYmdHPf6m3F/fx7FXc15CUI6c+nRGdrYmfuaC
IJdrWq+LrTlyfe0VRfvFpBrcLC6gBKQm7esui9ArvKQ9o0BntLzOlmftEeN6ECKO
MIkTtYp37CV7jMaj0oX9SGOj+o4aBnScwIu5Gqtd6ze80WNyvjxDIK8f9d3w1Sco
VD06wtO4TxB6GRDy2EkarLYetUDDZi2u+G8E8yeXFh4exPd2MmHms3tn2don2B3h
vmSRzrXDlm3YqXjBoZZ55j4pJSVthQoaExBh7kt/7OJ04O4nJvY4bz6sMC/CGBds
878Xi9gZB+FjxECe52flmu2DCMEE0vVoT0CnMKngXd3ZpcRR3KZStxMayWSiphb3
CzpxdXPO9SBP9YDeAuq4fTylWk0OrKZLD8eM+qwSTEHqx06cZtKt5Zjk9JrL0dXk
EHLLIcXrih2QMqt6EZgCspfYgPrDEYmdPBAtMErYp++YBSrkrtzB6d2hGHNRUSFo
`pragma protect end_protected

`endif // GUARD_SVT_LOG_CALLBACKS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UQ9m1dG9t2Su5CVPSju8U+lP6upyuifa7a8hrlGfcTDQ2wRS2ajJc7ggMNNmRz5R
TuG8R0E42LTxo2kSCAqdO4K3jDDxt2f61q1BjoO8UR81tfBx7/UjlY/ZClRhKFxG
nDz5fyCKqHoksdPBoDLLPVp1lyyQVBbCOe/hXx7q6yw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 845       )
d9PbQ5eEN8cE1jUvA4Akc74KCw4pb+hCdd9Nom9YQJG+5Y5pqzrqYdM3WrmHn86y
ozJz/m9IsEgf/BkHcpdp9KTVcA+kkVSYaFPHKrx7U4uPrzwLqBWOHDh48LFW/5UU
`pragma protect end_protected
