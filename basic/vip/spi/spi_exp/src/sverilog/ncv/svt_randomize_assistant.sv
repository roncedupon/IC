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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
o5QzdLjZvzrvh6umBEFVFrA0miOCsJPSw7L+1P7mHQl0KyhFCTk3xHGcmehevuUJ
WM9740T0fd7Y1aPWgK/KOu3YyhdRLtxemcF24Ya6I2xgu/bzCilxyHAYZbzR7E3e
Gin2RKxUQemGr8eZ69cCH6cnhnRxkGdZi6qHwTAkW4Ovl26wELEaRA==
//pragma protect end_key_block
//pragma protect digest_block
kXWLMyQtNrxAsG8udCXbeO7pLz4=
//pragma protect end_digest_block
//pragma protect data_block
kgIILnd9nx6M0z55lmM9okMJZaX/TiQrsHQQ7G1LxPvK6qtXP0GdRr9rW1GZr33r
pB0T9vSDjj58XtCG9W60ijmyHOSBSOVMnZKKKaizew71EAKfpxESUoDfCrwCFtQU
jD0eHYUXZV0N20y1CG8zQ4lXhziLDFuhvfCbDmeqnr4bE8p/9CtdfpzvEfICRe+g
E+5Ysl6VuPsRTktCQ2FMLdT/Y9P7UU9D+YZ/Sm4S48qHV8fisYI8KSPQDwH6ibsl
eepCrCFWLG2xTSK14eDLL9XL494su9nLEE9pa+jw4hHT2rE6wHi6LuyJwV3VNnIO
e/sFnGFaXOktCGzUXzIpJ/lps6aIBjFGxLnyY9Dk9+oxSU1j7pN7XwH6ERE6W4ab
kmVLyltH7WPQZyDHbIcPPfhygP9XmST1hj4F6hEHV/JiP8oyVcIKjj4Vs5z7/aRz
4so9XnB+Tp01f2XMfNVgx5J03eINAnpxszAqt+/Y564rBV/oBVtAYucdcWB+OQWB
dv2qliUDawPDph0QZWzou5HQVz6bpHs3Vi4n3rWaNzug6eA7UWcpMz2WZEgUpgkX
yloktMdW4hA0aeCWzrzYKSrs+HWeMf2GgBGZCSvEKvt+azRUeGPsmKg5Bad/QROz
wtrBPgaSFvfVU+blh8doGg1GTvzorU06N6IXAHgKbjafUGfbhR7vrs48vYk4FG29
PTjQwJfgSsaNxkxDbMMhGelV7eeGYqRr+brX1g30/NkMqDe26RA0IsnYj5kGvg4i
MyaOxFhDjUeyLVGKOE4qHndRau9VN0c4epeuhMAkYfCR6OO+K5KLNY7H3w5vXtMR
+AltujdNMZ2fbWYBZr5sXhLP93IPtdnkvc8ZEw7dOfjDd55DOBt2KzSD4MCqhLUV
Xd5FiUSH/jDnT5qUgLKIuZmsIiN5GQyCMJoYYM+1T9WV4ejqatpkvjPYWDOnw9Nt
1pFZqIy+ExSAMj2+hJLuBXPMi/E6BJDRzI/GUhFtGjRu0tAUMuvWvlQsx1DX3b/B
fcsW6W3jP1g3iIULFQAW8e0R4cNz4U3/M0CVTZelQsX06+qWaxW8MkJoXHS1TtcZ
JyYjtPhwrMgqZKGWRXV7FZdyr3V2ilNExhi13spDAP8LJrYfS845C4TnomqdzBqd
fImzguL4qp80YEjURoqwLuxTaux4ZmkcV1fIRUNBejEYfq9KMy31HvwCVQ9gVB5n
3H34NsU4GNcjH0Ly++GcQA==
//pragma protect end_data_block
//pragma protect digest_block
bvEM0/I1zNkXbV/qwMZXqLbx6wI=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
++3qHrw6WKyTBnmcvF+57WIJviW8iaQ2hH9xpWoMXkrCAfOT0TVYRqsLJtlEdK6h
ThN/4AkULhcD4HnRnKNX7+UocZQtNTj41ABbzPevwjgb300WMQSg9OKyXL5cX1Nb
YTP+wnq1Wlqlj90tsrVKg6NpsJ8dWBUs0/WLRhx72mH2Az9vp3yE5g==
//pragma protect end_key_block
//pragma protect digest_block
uVrWiEgj0y1G4fCw72WYW18CQUg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
IdC4zU6lZbPmn4Naz80lqlOGAw0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_RANDOMIZE_ASSISTANT_SV
