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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
QyLTK00P5IPyJ7ovtS13n3Pb50m1HuPg2LajFB53E0DAEV9ClxHMCceAUAHKlFH+
kmcpxRVZ1VYjEnn9OvD4iSIZVu427ODk0vz8VphbK6hntqxJvC/C0qVh+vH2H5If
xhDfQZaI7IHzk/MooaREzbBjYxdeAOmsgVD+XjlysiIZzO4KSzxtAQ==
//pragma protect end_key_block
//pragma protect digest_block
I4V4mOPi3yfJLFtmvTDxHnNjoFI=
//pragma protect end_digest_block
//pragma protect data_block
VaDXlggOkhqt24TQRfDb1jJZmz7PelduNAQ0sWEIE5AyuOlZdwO6+zatLz6QrgpT
53Q3Zb0zvJP+IH3/gIOhqR72OtabK1eJlnWpvVT7xB5rB8P6A3EGtkmA5WgZCGRa
MzmIoZGG8NGL1NMubG4Me0b7q4V3ITo10ZWWRuhDh8yR5Su6q1oYBiRbhhI7ZDaj
ShAn2uWap1jytQoSPY0f9ZqfAnEVrNFDLeGWaRIKzmc8XG9TvaFhr+4DnbD2fTUS
nj8GWl9/kxiW/5qotChh0+6Ha9JVvZjD07q3eSPwlaBXq0mZAiF5y/MAIdFK9AsG
DZcY5pUkslvCf4VNoWnkU/urlYh3aB8jW/sexYz8xjCDOtA5o/OBHDxtHKqblUwL
ObEO66zWLKwng5YP3p1QRnk5pek3z69yuo+fH4EX4dTGH+Hg8tzAMVXo7xhjHxp4
bzWI1sGycgnj0gOxvtlzzZPcrZh7pIafgJTl2+CJLHVA1xEpKpsdZ0SXYyS0yeD4
WTLTpg/Dx3y68XiWulaaVr+mONFMHXPpkxesh/DXyS/4c+wpOz2AyjLTZmXigmhe
iNW2WeHIwok8AvMyCFOwgnPDEn0GDXuCGVn7wMigcq+3cTN4y/wQEHqVgdSf+sWG
edcBFbqK8CTK6Js5fd5gbsn/IAdQh6ssGOEyHgLALGhhj2HelRiFhFqw4CRw+GWV
QMwQ8JLdfjkAUCjX1fbKYZrYpS+1pGsg1iefuqHduVjMhaPYkg7JTAtSxJR3vyTT
MoL2Z44IMpEGtZz9owQTut9lQXU/KirBCe35PfbFEuic/pj5OpyNQYcO1tbtk97v
MsqkezpeAQrjW08HbUi19lveUIiDOOMhOyQ6ZdPW7xCUiXH7qt9SssQGTZ3e5Erq
4uTSnPjkEy1+HDGm1OuoPrR5IiGkLUX3iQIHQG2hKtL5ZIJmsQ1t9DeUodXjNU0O
ZHbH3EHJ295O5/hXRH5g5QyDxFrtcrnCwm22f9xzuAOJSCoTYYUZJ+Jd5aA7n6HA
j5CZ+8swSFan3Xpl0vtBXg+eM8HRWIWq1n3v/Z27tiAApdHK4cX+KPKvkh97wP+l
iVbcmMpcerJWaqrpvOT++W0diCACKHq4hD0psw9ElN7hxMf6MUhzlofnN0vnCvn0
TTbblWoh+9mOqA2HurpQWzDRZp85bGpq3QfJhuZNyOwoMJggeyxQIAcBLm8RqAK4
jIqnaqnzag8UDkCUE/Hf0QEuRmccGD+OQ9wxNY7YF3SljVgVZ/a14WWMOJuEi8d1
xOJGb8zjKE4V6lT77Mc65T38NATvC0qHynSCKWo9gaJGhleilj55Mx+1TE/hoH0F
qVescSORciYO7EcPOrhfP6+HQceP+1nWjWYRMco09MeErHz7h7p8YL/UDy1fXoRf
d+dRu3r2d4NSyfpzlIrOWv1Y8MZBSpHu4u6/m73PGGBz2cTyqtA8uEnpbyNQLrnF
3lOrmiv00+6Yl99+YQsEadhS7BqFLbdTGx8YlSRrkJgrZ0FyI78dhKB9OIejWLVT
yX0mASJksiT5XiL8Ftm6UUjleAgOXG7gOtngyPzH6loLfQyMRTTWiDi7Z9bppcsT
7JIrUQ19CIJIHDl7mXcQpcFSoP8P/xZOScn5YNbJR8ssbxUb1AsyNpXbi8X538gI
M0XlR9s2P1EJFNBjKl3p54zsNCgrxhCeoorcOmrBU9PE/G0GvRoWN5OK7H9z/Ecu
1DyPoHcUE+LX6TY7nnRTAlTxOgS2tOeMCPiD+kommy1+bpOoCSI1oI69JGubELAX
sA8UStAW7nUq7k66P5dXzOo/NogKmwjfMV74NGxsMDskVUkxVQNipXeQMljwmMtx
NvRyFzV2vpB8apOzrlu4OBHHsgkpk44MGWv0oofDs38n38SYIsamJxLmvV88PlUe
jStx8R5yh/ud1Q/HGbK1c5OfFO7H0jdvBsGdoWXZqwwKoHFJm0USlt5GPrWN4Mio
tXj/FMd/k61knG2BdGC6SpurYa8m0xFR1eWHQW5fMNlfB8UzZgbe67w5pzoxx7A3
XCVY1GAc9zBVqFCuBaNMTueAiE0PQeyibDl77Klw/E34LOLHO7ZsQ998Ir8mc/Y1
iB71zUAGWDrN9FzFJqTyyVTkvRxiG/YgI4URBVdXi+lO/wStqhCZ+3yb3oQr212n
LMfMYPQFaqYadmeZkVjQU3fh2P0ZqL3/FR+kvBqT0WSlRLc2hgPNHXlES8eXFpCy
0CbEKdIJ/NAXLlLfbktlmMXn3GvbfQyr9sCAbuG96YFy92QcdSEie6XLAX04+w9r

//pragma protect end_data_block
//pragma protect digest_block
VROsInHFg9hyv8WIk09JqAwFRRo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_COMPARER_SV
