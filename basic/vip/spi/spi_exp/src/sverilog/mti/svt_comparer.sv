//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_COMPARER_SV
`define GUARD_SVT_COMPARER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(comparer) abilities for use with SVT based VIP.
 */
class svt_comparer extends `SVT_XVM(comparer);

  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Special kind which can be used by clients to convey kind information beyond
   * that provided by the base `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract
   * flags. Setting to -1 (the default) results in the compare type being
   * completely defined by `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract.
   */
  int special_kind = -1;

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
  /**
   * Added property which was removed in the IEEE 1800.2 release
   */
  bit physical = 1;

  /**
   * Added property which was removed in the IEEE 1800.2 release
   */
  bit abstract = 1;
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_comparer class.
   *
   * @param special_kind Initial value for the special_kind field.
   * @param physical Used to initialize the physical field in the comparer.
   * @param abstract Used to initialize the abstract field in the comparer.
   */
  extern function new(int special_kind, bit physical = 1, bit abstract = 0);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to obtain a calculated kind value based on the special_kind setting
   * as well as the `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract settings.
   *
   * @return Calculated kind value.
   */
  extern virtual function int get_kind();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MtjWrB+wedqA4Du+JFmHxB4C7ZydSPBxMNFvx/00yM2nGEzUGx333YqPdiXa6kkS
IcNZVnRqdsnfQR/Qdi5gh/VfKYDx3bR1Cxbc6epExOnmEbwkjyHXME1Wm1w+GX5i
2uPPnZSR/z+Yhy5ZjNIU6+Txn0JPkwy9aMuxm8qHM1Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1560      )
pY82ecTfbFjxFH39prNulwpgmtkCRVbK3O+egRZN7mGv4MNlySvBsbGoP9gORVw9
Y8RXD9gmQe8Sgbe5ZY/4zOAffdXFhWueDJk6ffPt7tNzKzB2ObpqGlb+f/MTEBBx
BWWGm9YXqwsBIdTXwfQGaSvTEr0/t8eI3/burraa5lh4EWuQsoGWI/m2KOx+vYHe
GNSP5mviCRDGLKuh/HH1SdG8Zv4tQUV5NoA/Xa4/iYIaSmifi5XD3Kl6x9lgwBWO
GfkFs/GESYh1WRdfa9bRPAa10YT14AeWzt76OtqdJ0Ye+JxjhknoO6D/sUGSFQSe
LFbpgP9PXG62v3otJfgPK9YPr6Lurdr6f3qkDhUMagtX1iU0nqN00VcHPiwxV963
tXbpa+VtPQktsjSVzsOeWP03CiPN+ssIHCIDgCCTrMky2eCAH5oPQ6PTM2h9C8Io
hqBf5gHTD3tBSt+rf0qc+Cge+dGL2PhPekFUadlN+T/2dpIWE4NaaHTeFYydgLzD
vhw65WTukItdEhPtmk7HiR2PyiT/fErgsZWOUZ2wXH5w4EiM+GAg0xu5gOUcAX8I
SXPjX1gQVj0n7HzR6i9FZM1K4ZXbjMXeaenRwKEj+exYXb3M7eLeO4IcES3Jh8et
C1VNk5GSJ3cDFNrEP0ZbfPb9QQ03UG0J4y+iLENa3fWwiU/oJjpatgFjpEKqymyr
CRcs31ga6Cy3yq8cywOh1RXh732EQGPh72r+vsbVb/Gz+sN4KBaNapS3rWRPR3z4
g0kchjgr55XyXY0jMW3ehBSBn6PohE5qa7aaXX+Ry0JxrM7Lq+KENO4KrcnYXkJk
hBp2yCnNFMpxFxnuUC9T4OjNmmNg9tH1FmGVbmTU0gxqN9R2ZUZZbBkSAu3qhsnb
v8CN1F5C4xQ2eAEQQYe3cTSaL3kdvqhomFWmFuXiRhyrGTdIE5cP/2EQ9JEhOrNS
8rldRRrgaPd0adDLfT6TlkyP9KSoFF0XVsCcoqa5DJiGTjv/fl/C328X2xjKxV77
P5fKnvbDHObbKptmH3iq7F6LskWNIJNeT9VP/lEk6Y033r4GUG404wZQ8u6eeMxe
pLuSYzzxtIrV6FF/eLFIT6DkFc0k8CrwncCynjmMtvlmnfiKCOXdcWOf+tSCWfdG
w+Ozpdp0Vdyr1MJmfHLYaTSNnQk66XMGKrprvPk1qULay/zLuDRdXfXVifeitdhz
p9kW+2iZo4hP1o6FRZbobNciWbpHvPzT2Pvh8XTRJ7RDM0ZOYAF8YEBKHEieUuwq
tryjD8rQC+/pvDewNFhKBlPWNYJYEfJnxde4ysvL1P6cn6hKV3ewh7JYYpWfBddN
zM4ITU25jzylHpDOBZ5VJyQr4ICT9436Lv9x2JnMMRg8dMw16jPanYJe4KKuMpi/
2OESNUqPEyCVtK7N4GAC9BubGgdp/LyAgSmfauNYDSstdvokWkIgNDY5zSkYh265
jgKwqIq3iLwvyiV0mOPh6f+J0q3t9QutZZlxZn7mU+3CD4mFhvQW89JInG089Nko
WN+GqZcV+szmTI6k2xNJApzvI/S5jsFnkbUPNMbySrrLjzWZJaW90ghx2HSXZbhU
1NS4+0kYfWJtsZ2GlGsSmjIAawJfMjJIZ4Klwfi0S1j3dY0yknDGXu9N+bKCV/bx
LwUSHit8yzsucNwMrTptTpZL5L9wM/CbCfvp5qyKYZyNmmFupg2WQrB4YFj62AN1
4PMthph90AeouzVpBuOJznjBkSDhBHvHIwcMYfszdlwpMrT8w5kPAUdHK0XmPeBt
UBqL1KxVXyD8HwaGzPxEcXT6Tg+5JSi81opLsqoy2ERdNOulKI1Bbs2kZd5Q1OO0
xPeXzbLOOi33/3DXHNE/b1+kNrAqqlAD8Uaqhw37bwXsYAug8CnYLt2e5LYC8gFB
BN+aMLGIkE/SsfwBPTbg/eEowvOjG1V2wkfZpqUdWoFj72nVZqXrBEf5twfbsTZO
IfmpA4A8VSy5AOqCJ+tQboC4DQXOBwEIBL5VzaqvYN2gxYsSUNexRCKiID8MTd+0
eWOH2mqgF5aGoq48BFKGHrMjUHDnED+In0RyT9K2rWA=
`pragma protect end_protected

`endif // GUARD_SVT_COMPARER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PqHxifwp9EHQwo9Kx9EaBNRsDuDyu0DZIan0VU++uxSw15+kaLSKCYk/8VH5145L
2ITCziiYWSobaXYmgnj1kU3hZ/Dc7q+Fo/XTNUlJMJEfrGE3ZzIEuFnIEeOzbtt+
KH8XkG5DkFoBGp6JZmqGRVpIMam0TTKiQLs0r1KUjkc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1643      )
6ebcdTtGDKFQFHf4qBT4At0nSDyvYTUARe7XzThu0ReJR3rogXCwMMH0t0Akjlrs
I4Bs3QxpP9sacYht7n78LMPPIEvMYwyBi+X+CZtNZ0o+19sv6jzyO4rqRz6cRnlP
`pragma protect end_protected
