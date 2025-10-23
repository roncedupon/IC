//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_BASE_SEQUENCE_SV
`define GUARD_SVT_GPIO_BASE_SEQUENCE_SV

typedef class svt_gpio_sequencer;

// =============================================================================
class svt_gpio_base_sequence extends svt_sequence#(svt_gpio_transaction);

  `svt_xvm_declare_p_sequencer(svt_gpio_sequencer)

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_object_utils(svt_gpio_base_sequence)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * Called if the sequence is executing when an INTERRUPT is received
   * on the sequencer's analysis port
   */
  virtual function void write(svt_gpio_transaction interrupts);
  endfunction

  /** Register this sequencer as running so it can get notified of interrupts */
  extern task pre_start();
  extern task post_start();

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequence instance
   * 
   * @param name The name of this instance.
   */
  extern function new(string name = "svt_gpio_base_sequence");

endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
i3/6Ia+yQ+Yh9NSJlNtQirGENHYzrM0MYgpM3MwLBYUhAWIwtgzQ6XIETel2ssD3
fJsCpzzSyT6oTbVwB8OGXWH16RhlakHGthl1HmuEL9WvDhA4vVU5Wy+NZU1JRFyq
LpUAiKl34i3XEoSzSn2Z09Pt0GEulRGz3T5EhnkSYyU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 793       )
ZzWWD9MwOKzHlRJDvy++F4KJpPj6LwfJ2ZMk8Bl5pIg00CC3cxFNMt5pnHawU3Tr
ZwOfr2HilN8flndA8uSwhAjc4SxTMM7haxJ84t5GQa3rV+zBS77d+/ceuNuqkiuN
pu6Wd4Gg9HKpSkpQWTYC51n848kjprhTGW+cyIC+Erw0/YFEz0GQe8ESsMsu7gF6
ZxvbBTCWu45OU9Snqh9DrIbUpzxKB4+zfXuUHzq4vvqGATm0UVyOjqlSJ5X2e8oD
KUJTbmf6MEI0zkAAu4FOwkphN1eIVPwgFsP4Df5xSiQygGjnpmcDudA3/AGehIum
oXtPh4yGQMolKFpSuwrxIZiagPvP6WZygSYqErejnglDa/7Kqnul0JnRu3wXwXkz
Qda9dgfSaHOwnNV79fNhYkEOg5hbifwl6RUsxz3aN4NQZZtglRE3o5VoNizffmGV
G6ocIu1GquzWqvVgQPp9FeA8oSO0hmY1xPnGbOpEJqSzbFqnc++VfQRWx5/rZw3a
qeCmbiW9Umjhoe9K6XXCog0SyX670Kpb8SlhPYW1x/EzZZQgEyBYXTyAMlCZrvft
qKxUagyOlRvmfuC/u2AlOBxNUhmRXAZUIaAWlwSznKacOgITWUBdL3KxmMfTIoBQ
0/Og9FCBKKBdI71SfNRvCQoo7Ovyfm5PrUeAJy7BX9Hkz8z49heqX+zJ4JCua2TF
84jo4ZjBUuFGm/DxDiY8H5aZEdy3JP7F9kV2aoHopFxJ5eOOXIClT0QbEUDfkwly
1qDQPUiYCVf7jI5QWN3Vq/z6dc8ZsY7fhfh+FLcMs7WEVhCxCPBtGDiDrJoSKIoJ
Id00QXj9r0EvC1yjsZH9MGdwCOff5tqsSJQTUtbVPhXAXMunq6aTnwqdOxprOh52
Z3vO10Ck2IeJzRGFy7tMtFdr/aw6zfwHLwgkJoXETDovCDNGgTpk59mMkQITMXJp
b5b6o6RPcd0pyObClQcuM93dvlT3+f/kKHu2ln62+dKS+W7TMWKFUpUIrHR7bIEu
Wi18nQkpiUjCFv23WAsCdl/JT+zH4uUoUDsL6g6NEzc=
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_BASE_SEQUENCE_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
o3xL9Rr7MO8htIxv3H0aWNQ8QFZXRFz77GyA05F+l41u41pC7A5oVbIHVCBJBikl
bet42ANUZ5AiyN7Be8D7p6fmVvdlSwDS5jrNFHk7I+i7326/hKE0eDRBTPZUV8r0
t7RsCl14+uVh1eDQ8I96PxlAz17xJlc5k7NRrAaHBxQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 876       )
4u7+wNKjMjNhI7U1mt4t/wy25YyO9yw0Ry0TPjdmvbgTpJsA0quzJhLZT6mgaBo1
EFXdw3NYaseyheW8JD3n6WEviPc1uOP9x+Utm6u6oipPX9ItkS70f8V6PU3E3Spi
`pragma protect end_protected
