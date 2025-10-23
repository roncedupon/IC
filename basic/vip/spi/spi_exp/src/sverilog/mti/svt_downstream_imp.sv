//--------------------------------------------------------------------------
// COPYRIGHT (C) 2014-2015 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_DOWNSTREAM_IMP_SV
`define GUARD_SVT_DOWNSTREAM_IMP_SV 

// =============================================================================
/**
 * This class defines a component which can be used to translate input
 * from a downstream 'put' or 'analysis' port. 
 */
class svt_downstream_imp#(type T =`SVT_TRANSACTION_TYPE) extends `SVT_XVM(component);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  /** Queue for next incoming transaction coming in from the downstream provider. */ 
  protected T next_xact_q[$];

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new downstream implementor instance.
   */
  extern function new(string name = "svt_downstream_imp", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the next incoming
   * transaction.
   */
  extern virtual task get_next_xact(ref T next_xact);

  //----------------------------------------------------------------------------
  /**
   * Analysis port 'write' method implementation.
   *
   * @param arg The transaction that is being submitted.
   */
  extern virtual function void write(input T arg); 

  //----------------------------------------------------------------------------
  /**
   * Put port 'put' method implementation. Note that any previous 'put'
   * transaction will not be lost if there has not been an intervening 'get'.
   *
   * @param t The transaction that is being submitted.
   */
  extern virtual task put(T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'try_put' method implementation.
   *
   * @param t The transaction that is being submitted.
   * @return Indicates whether the put was accomplished (1) or not (0).
   */
  extern virtual function bit try_put(input T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'can_put' method implementation.
   *
   * @return Indicates whether a put is safe (1) or will result in a loss of
   * previous values (0).
   */
  extern virtual function bit can_put();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DZqbeJbYFIBAt/RxucPSBKHJrKmMXAHDlDubgs2xcM0ndZt2ePyPTiFhAR0DSgki
6N0r5pzylgshLTEETu+o3KuKAee8EFbLYeeDfi17ppX8eN/HfGxWemlXF5my8c7Y
cBq8Cc+BJ9/OHvkgVw4vn86fOe7z6qXNhmxe9+HroLg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1581      )
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
`pragma protect end_protected

`endif // GUARD_SVT_DOWNSTREAM_IMP_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Hij3KE0t17+11FhS831YhYq+1bFOs80TY+4IzTYT4i35h2wQ08oTpZUdKmMIRJIX
lrj4MKJQMDkwFEb66RfU94nVV9BV4D5EHLNPkNGKvrzV5vERhIJmj/1R0KhAW0sn
n4kt2K/7JDSyXnOXobfuGF89NQh4HZ41ADyklOfUnc8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1664      )
ulhNimg6VoIrkroNXKsPTkbr/jl8Iq/m/kAJUd1JQpdTqOsxzn8r9Bk0gku8nWBh
x07xHAulVtTo9gy+x/Sf+jiD7ldZlzMtjqaLL4dZYBpNT0ZXomx1x+FxYGhGsGU6
`pragma protect end_protected
