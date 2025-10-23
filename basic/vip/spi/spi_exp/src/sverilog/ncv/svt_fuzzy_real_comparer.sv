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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
UILsud1V82L4j9JyfLjky/3hO2PhV24wpTiDmz0sgzzsUuTejkAs3wz2lpiWe0Pu
ajuNAooC4iCgKsV5vh0A8/Jlmhfh3sNN0pY532x7wDGYLZ5DlkOxH923bZGy0RNV
fqQn+rW7LMTTD9dabILgzmKZGi5C+huvTtQJJ9XEvnd/TiRDHhaIkg==
//pragma protect end_key_block
//pragma protect digest_block
LL3b0i6LDqVGFv7vAr+zX57gyPM=
//pragma protect end_digest_block
//pragma protect data_block
8fVAELKTQSlXkYnc5i/TnUJ67lHMnNcrWzJymt2icTl1Qj7ws8hhepegyU971YeJ
V8BgN3Lgyp5ujv3sWbHspRRHdowwKrtxKHYmIa8gYE0hyE/CknlFyBUkIGBrlUFB
HVUM7xHaJsZOywo1r2zubJ/0xzvYgFTrNqVTOzwDYcrq7X9OzzOBq3rrxzmO0pbo
NZA2VOFvQlOdU+YLiItUQJCaYB58QM10Wt5Mq0FNt6qbP8N3l/hRF5wfVyI9AfF9
tzsrvV9sGHMXu2kZ7SaDKr/z1HqIMji66BfqwqKY53BC9l4oFuJQpG1nWHenC/s5
tGp4iu6BeBbQZO7Bq2CRJ3a4ZS75ghdc/2+H2Y0XdPagtrQiaUd8kHs/Sxc3JgO1
1vQaGRtWCJH3+bhamVBwQ65vGCQ4nrk/ECAF/4MikYqv5Ud7YaKMLSsMS1ZXgWif
xpSFh+Gub5vboWf6RcAOgfwXeWqO1FUPEdEupPkqPB0JclKDluLyrKRgM/R1rtOU
xGENWk/nRKCzh0NRyGiZqFklSAz8HIHp7s5/YFgEkvCBwbDbCeX8Mvh61hy4CRl6
Zpq1IctF/0X+D5sLSQY6CuQSWKOmHa9DAfhBPxgt25wUfeEyGSTihl66imQxIPLU
VNXs9lvRaQKTPjIivw+9VE6ClE+VxtLN3bZoIhbEzQHOvMm5GmU7KsxsvyOnZCrs
uevOiqa4G+eXAJISXxMO2vebpVxHVi3PObiueafx7ILTFV82kZMv8d+wdqCxmmqr
6t4+NJ01ttSV8rzQ3DvAH9TG0zTPXuxrztXjO7oGDb2LjMjm/lOSUgS1HnnmUipK
/Ls5cFzl/+cD3BUSE7ne57u052OBlCAQdXmOX/UmUg8Na1V0ha/OCwDb/I2+/288
XuWANLAb6lxh7IrKKaCfFu/6T6u90fCbB+45dP/a9o5x0JEITkIV1zD+3926rCgv
NL8mvPoLvt84T6dCYKuZbw3OLgIajbJKFySxmXnfk68YDspoCLZUc+62nDE4Dh/G
02lG+4A6QIYrg6PGSIBKz4pUl4q7vOegKj8t16LwnvdeVjCTzafnYONMApl+drFO
lmJg1MdvXK84Cz8a80TIEHQQaL9EBjCA6d+JU/e+HP65SgadrOu1E2RBjVBsTvQX
nXfWqMFXp7C3c3AaPNbvqEKvW3YK+MYk1Dbj1K7MakQlFFIeb+tqKlu4LirdW4ej
4KV6WDFb/ItO5G15Jg1PlFgj22uF3a5Su+idTpfSOdYIJL91G4C3WJonrJMkReUx
keykeqMo3pm5DMn2flVxXsCYkm2zWJvQIAMToXNO9Q6GQYIUNX3dmafO5b1lUpZg
eZvSh4jjEX37AHxNo1PMSq1ZCiDKW95ncLHGjHJ7VpqaJQMyr1XBnISyhISwlbcc
ZoQ9CNoG04lc2WK8vwEDa2ic5zf00d6OZn4hqQgU+nAU1oqcbzmns2RungGcuzz7
HhKUttnNauA3WPMGUcxKleGSAU8n7gNom9LuMQyGx9yZKPPGpGMjteDPTKaCt2wi
Pncuo7wcd27nl7H9XGKfrR0/uf3vqFfGbZyGpY8/4atavJG5CkzavBx+dD3J/S7G

//pragma protect end_data_block
//pragma protect digest_block
2QwuRdnXk+Ef+7QDpcgQ+zc7aq0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_FUZZY_REAL_COMPARER_SV
