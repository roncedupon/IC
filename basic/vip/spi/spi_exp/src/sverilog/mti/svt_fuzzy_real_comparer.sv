//=======================================================================
// COPYRIGHT (C) 2013-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_FUZZY_REAL_COMPARER_SV
`define GUARD_SVT_FUZZY_REAL_COMPARER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(comparer) abilities for use with SVT based VIP.
 */
class svt_fuzzy_real_comparer extends `SVT_XVM(comparer);

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Data member to control the precision of the fuzzy compare.
   */
  real fuzzy_compare_precision = `SVT_DEFAULT_FUZZY_COMPARE_PRECISION;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_fuzzy_real_comparer class.
   */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Used to compare a real field.
   *
   * @param name Name of the field being compared, used for purposes of storing and printing a miscompare.
   * @param lhs The field value for the object doing the compare.
   * @param rhs The field value for the object being compared.
   * @return Indicates whether the compare was a match (1) or a mismatch (0).
   */
  extern virtual function bit compare_field_real(string name, real lhs, real rhs);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S8mV4PPyZPQiouN0pkkvURtu8E4RXRDlKkZ3CW0VDCH8AgybUHERTOhwEqXnQLtd
TAWpJeoYLDxBLKj6sk7zseJfIPyMn2Mnyaw4rOGHt13cXllfc1H0fWsb9mzEJ81a
QbHmsQk35uAZ3SRPxw8jL3TOPFmaE55K2BoCDfGxHxY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1027      )
1i3tCInhB7Yz5D2wJHTtrOLqUPUjReRB7Yxxhi2uWhU1s9rgQX+zoh0q9N3Jp3UM
10OtZ0RV7Qlin6KI3pyWZsFA+hl8g0ILg2hosvijaVbpW4V5mc/tmZOQHYYZ6cGl
FYH8vatfCO665HxjSzDDg84QdXU48hBNkEV4wTICRfAKXXvlA1FshP1TE+kTcCOA
dN/Pr2WSM6oOa0NMe/zCFVnWF+1Uh/tlWgwqIfF8ZEs8gx6IT9dfgFfKsB8E4LGr
ApXnM9MIYB2py4/IaHfm2JFoaMe8MSk8b874b+5XPbTZJXF1SXTbeCZwAsrH3gj3
mjf0r0yRNbLMuaLzNt1Ip/Z06KcCyORz8Uqey7gdIW8h9Veu/GYtokIlg+ooMz6p
6r13FApV6PnmkDYZTi4Dxj9va47+FcX0DpXX+YiyB/ocVQY9QrH9R6LA9r88cTfa
lwzFlsHoV9COZkRG4Rleb8Suwo8CmDebkjwQ6Syg3bSRwzXFziwlBXziTzuhfyCu
64NHhxQuT0SKPp8cYBdJs+3io01URt0ZUEj+TSwefgvhmjPMXWENRC16hDi7YIkt
QcDRon+4sgcHGAht+HNV4TGBxn3v45amZWqi3uFrQrBKdVPrZ9V21Xgam7J7Lh1d
cgeGw40y0jyqrO5KKtDecaycaFIuMReUk9X+ZXQiWwNwUv2L3EDm8Ku/i3jVkjNS
zVoFKB3TC1oSDCmeu37GwMZEeX6/GNUaWk7Q7QpBCsdNn6piRq9g5gMpyKU94tnm
OdgGtJdsM2Js9bxAO39ykR9/g/Lmzn+jx0mHQFE0O/L8kEkfQHISxq06LTN6xbGE
7S+A2Cmd9d1YymzDKeFILQwHVHXySLgF2dP5O3t7HRFTTzpT2wTutGbTkNg/3ENM
Iwrfw4N0zDXonVyON/PVDfha4557DQI09tKwi2DAQsrhyCsFv7l2YSIdCzIsy3PS
1HRmi4Aj5eLEZZRC/8Xjc7j8x6sRLGfJeVhVemEH/y/27dLO5wV626njza5YVeRc
A9T/gb03E3JlraI57rKLe/yZyMPTeaE6BN9UB98iUo0nsfpzEqOn2Jhle43UY1Qj
XV4PjhU5PmAW7Q4v0vayLy8VHTHPjA0xt1D4hE57Fsk8sXVzNomvWn3I21GUR8nm
9ED77aXJ7EblkcdDnRNmJum5EVput7gdtTtvs/Rnam0MxveoQ+ZksOHSKIzrA0sk
jN32JUMZ9s60ocdTGUGd8K7I9PZroyBN4p3iErGDxohpTswCq03bbs+4cwIpyHGm
edCp+8ekzFxhAcMJ33iOYFIaNaqqgox4gIA0TRvPPptDi1Ni6moSexSOAwjpMlnM
w6Akh84FaiHlnEDBV6fJ5bnRdwUOXGFyjRqz0kBLR80=
`pragma protect end_protected

`endif // GUARD_SVT_FUZZY_REAL_COMPARER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SlHpc/K/0Ff4b17mO7+bTjR60OwlNHhqnvmxiPZYpGRsQ9YuLSQNvAQDwLXfIWuG
1i96yPerP2/gs5R34AsMUFyKWyBQmnep9eUqlAKqQhxDPDYqD5Jsxpo9TM6UQG9/
aWbQfReW0rLVR3lQeKaLS9ZrhJIrE8bDFFThY+V1mQY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1110      )
5fHFnX+Ba+hWXr4RQ6+/1o3VuEdEjoNXh3XOH6NxNqG3Rt/PDwzjtwJENgVPSeuQ
9EeM7CNf5a3oxSpnfoIm2uL42uTu0Kk/V9IMfhds5aWEaw/UP5CkUXL9GguTSeaU
`pragma protect end_protected
