//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_RANDOMIZE_ASSISTANT_SV
`define GUARD_SVT_RANDOMIZE_ASSISTANT_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// =============================================================================
/**
 * This class provides randomization capabilities for properties that the
 * SystemVerilog language does not currently support.
 * 
 * This class currently supports the following properties:
 * 
 * - real values distributed within a provided range.  The value returned
 *   from the call to get_rand_range_real() is controlled by the 
 * .
 */
class svt_randomize_assistant;

  /** Singleton instance */
  local static svt_randomize_assistant singleton;

`ifdef SVT_VMM_TECHNOLOGY
  /** VMM log instance */
  static vmm_log log = new("svt_randomize_assistant", "VMM Log Object");
`else
  /** UVM Reporter instance */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Fk1aPANr0btZY++hXQbOomy61Ai/BZzGNLhUBCXhU0zCFb2zhXcNWPwHoGPygzPo
wDAZbj40J39DTWjj5nw4Zz8/dlPm2FjxxWAN2D9aBgjVeiORcFXvwItxE+mSyqcC
1vgqFE/0sN59qdk+Aksm0fVdMzjFSYKzzb7No8xYzpE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 751       )
/kOfV2Wyh20xV5Qx+cLZlGH6oPLZo1QdVnatyuyiiOlt6kWg7iehUoeLwHxn0162
rIIc5jXsuzv7z7bsWMfL70M+f423O/Y1By/4ddxbp/el7Ill+Tmndz9zZFU2r7j/
PxDNwz39t0fTVZLx01kr4i2o1xx0b5GZRok4Glt05KuE3pvwMBKlMi3muGzDvC0L
xr8wGuqYZ2lwmDOVVQdujfzC299IfTNqsUSUZEW8rbvdnGDBy5VfaS6e2j5tGJPn
afBaWs9tMOZKY6Ttc3CgsGzZMkouR3dULdKo62EyXu1/QROAnIL27QTD/T/4cLhp
fBB3E46mNpSYIVIZc7R1hLPyeVicvvKYzVy4/w0aNOljVKHCsVgEH293gHVY3JCF
rB+1TU+aN6FTw7PhJQYwSD6Wv8k3H/lAoMKVSj7LZnFeJbjJ9UDOSA4p2V4YvPOU
fbKdgJloruHUY4VR2FLXylGtJgs3deiL1ZcnLMompvL6l4zlL5ykQxo191J/a7B6
/J01L2LBe7RqIOLOqQrYvnuJ73FnU/q4QHm90wdpuz9iOVy0qeXLrYZDO0cE4noI
HBAVHhbHSdXqTzUEW6Elis/dqktIKfK5jtp0kO/CNgBQ5nal/VS7Jx9t/KC/6GsT
R/rIVTEoiWWVzb+6GO5CezcwLMAe/hmnfuSNFpNHStCRgRTBSVYnH366zN0GWKlh
0zFHs9/A0zT6dpXyUEGXNtuCHgRh2GoEebIh6ea6XgKvDUi6gBzAIS7A8+/L1bso
2YSWI2j1VFDNfyQSdfyaCcYCtPo3DzBUA/nkPmK4i9xSEf05tNmIYbDZ5QZHPIa7
+usC1P9UcdY2JjGr5RI+6jeOfFv3hsz6eGxfjxiPKpsuIVvCKEiA7KF6Whx2D9bk
uMdNF/D1b6TLAdqyvT7tSqlrC5/y0rtaYwOV3Aq+/sQ2NX679+NLI3GUCRZybrT6
yOjcOKRFV7ACIdDLYwKSkIcs8Z1vLECbnRT1kGRg+hY=
`pragma protect end_protected

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Constructor */
  extern /** local **/ function new();

  /** Singleton accessor method */
  extern static function svt_randomize_assistant get();

  //----------------------------------------------------------------------------
  /**
   * Sets the distribution control for this class.  These values are used by the
   * get_rand_range_real() method.
   * 
   * @param max Percent chance that the returned value will result in the maximum value
   * 
   * @param min Percent chance that the returned value will result in the minimum value
   * 
   * @param mid Percent chance that the returned value will result in a value that is
   * in the approximate midpoint between the min and max value.
   */
  extern function void set_range_weight(int unsigned max = 33, int unsigned min = 33, int unsigned mid = 25);

  //----------------------------------------------------------------------------
  /**
   * Returns a 'real' value that falls between the provided values.  The weightings
   * applied to the returned value can be set using set_range_weight().
   * 
   * @param min_value Lower bound for the range
   * 
   * @param max_value Upper bound for the range
   */
  extern function real get_rand_range_real(real min_value, real max_value);

endclass: svt_randomize_assistant

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AHAYQgxScdgn3qE9ZclDNrf1pKHs1BAcMZE39iASF37h8Fo1pR+XTRycgumaCw9C
64GUTL9PGOx5DiR6D11HP+SL5jOUl/dOj+2kehSUF86J6YUgfRUbePmoRj9YJ7ZO
NwplLxkJQ6t5v5QsbhRNuWOp8ipXRs238oh/ntlB4+g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2253      )
xRf8tZRyQcYpp1MYCGlv2k5PLsVD9HTDKTAnGl32eTrgPjjJMWKaglx0Lw0sXOEl
Fiy3C5eJHcDKCn3Rip/TrXoXXU1eSmUWxhUHbp9GSB75DS7DHvpCnSO/Ps3GIm6M
UCwu0bWqbcGbXgwIXdpXm+tgdjH+i/t85/Mte7JHi1/xO5Mq6/AothlET0f6vURM
JmTafwCfwrpt68eRlAeeg4eeVllB3b6nrMsywcJAAOJP16FYU91UKb+xMMSG5HTN
oXbnO/+ekvLzJJYD61T0FsE4eF49u9DAcFwRhjDZEP5yWwTgBcic79xYMfQQ77sr
atg3pBUvCSjmu9ZNbRCNoTNTqBVXUQ5kEMrJNMJsemGh1Uy0lRnMJmL6J5tQ+EyN
xZvNo4X/o3DIMOrDgVOpf7MewVg/wid1RWkX0Jm8xY4kHs/b/5kMhrOnyLryOf/t
MFnhphzxjTBcmE/aXkCXC7X0qqGbzxuBLxR/wn/Ym49hH1AEpFYouHntNRUJJXH4
qs2cKdu/1zfU+5O0+NKFCkSUwJjTOb6i6rP5n5lBT2YeX9kyi1YFoVdS3V9LmJfK
OMy8WZkxWkCxBBhCGnknY1Dlep2uBCmF0UnT6rWf9beBfqdGa0b7w7Ss6FzGEpuw
uqU5BOA8UbtewPK8Lovh3YgXtIAK5ATvXkGrlu4nxaPvuJqu6eh8QF30VbAIKMUj
EymOutfraWPyh550gm+olXCMEwxltR6gM49gtTPgc8uKwNUgs+g12RrXX6PfPQPV
UX9pnN3pPaQZ+8WugEC+Q2uJRxpNiAOWP4AkTzN3ommxuxft+vPYwvjczEqU0L2N
8XtexenYIrx8zYKRQRmMc3/qutSOTP8l373hiaFbMMX4N+K0ExKIAkbqPuUIZLit
j1Dn1s1ijNzayUHM8EpSZqiYGzHNhZ35Eu7uUJ/QVc0uuRoKvnnmeVeryHsvGRKF
79F7DpiEy4j+wzNcvi2AK/yKEXUk7zTZw8HBBbNd66rO65DsDuJ98ffbf1VQUwzz
Z7ooNhHskC5zFPv+OS5uPeMPMccjxZ5m+7vhnwI9eK1lqzfK5GUy5PJab3pihZXH
adl+wqVM+2/C0veSp41+41f7Wm4MKbM1kbSjCrmxVMuGo2kREPApdCv3ylCeA41G
Dh07v5FwfQeVwZjpAv9JzQKY4eRLbzNCfN4+RsfhwyWLs6U4GijX1Ds6BwuJQjic
GwJB2CU/9525sPu3u0sTKW5LPzXqwTuoZlHe6F/fJWGwr2Twdi+Zo2WIlh4/soYB
dIE/Y/Y3LGIgCVxVVPiBzXPIGOlShxfzBzjljNLGkyRbYE7YfvPMPF/I6YR1QODt
iBS1TRBoWcxuAiEjzu1KyTQRxQSdPzleIlwnQML8crBKHofEM5Nae6yscLn07RXn
755nPqcrwmW8bgwgxVxIajCxU2Qtg/CRbh6ERUOA19n1SC9DoDbbDLA/7rBalxd9
lu0OuTPP77GF8kvZTdH078590to35CHTqRKQKCmMzanRAoBQxm65EcoD9R7F8gv6
kASnE/c/dUtKpuvMlkKF+rtgoItY9Og+dMpt8NPwL34PkkFTMyaWDoFE3fTmDmn3
SIsPkTS5N5XIQtRjwWvuHDWX3xj/C2o6V1zHnqowT+WImRbzmizENPq3AgVJMvB5
9bTHYCfu/+6GIA/cHCyGNeadt90gP5OUnbV8XmNZH2IfPpSK9n07419trm/RydNe
leAavAFY9ugcDdTTKx+tuF/aoRsAsA3wglub2rgGqmKipFfN3vlH66AZEQvupbNq
yujoQY4ZlX7S4J7382jgdfXdDrgcyT4v/Jh0Ne7mFQa9W/waRSsY+QC4DLfP1kGh
nDRzz8+IhAzM6CjvKCenpNKhcFHJ4REjqziutw7pVsxrC2rRZoXRtYXQWUrxp2AE
PWzie0Shac1v0boXjEX3EVLKeq4D2FAmLMHfIW6mfhzrAoUsCxwDrI1dDXirs1GK
LzANmfHZO/fd5BXl7T2Dgg==
`pragma protect end_protected

`endif // GUARD_SVT_RANDOMIZE_ASSISTANT_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ak3ymR2FZE2PBZQELjawCO/TpdIrbQeSBaAUvSfUrAyts5ldEWWu3RXCPpIPGCGU
ASmyEVPIdLJqyjqQqIzWfgMBOr5mZZWg0mplAK4cuRxcgebuB1ug+bvkHUaw2l4K
ShH2H3JDPGx/dg+1l6PYRGjZOXgkm49ryHkgZpkyynE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2336      )
DYr/nwAG0aWtjpIezvNZ9OJ8DIeLsTxz0B3IJCk7NH8VDYCzE4I3rj7DA1aUVdcO
YCHyvoox2esGPFLTBavHUQfKhWlaB+ebaH+TLLQULo8m7gzuVcnFctWKETYg7dvs
`pragma protect end_protected
