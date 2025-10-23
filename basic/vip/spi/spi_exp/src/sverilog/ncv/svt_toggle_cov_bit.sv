//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TOGGLE_COV_BIT_SV
`define GUARD_SVT_TOGGLE_COV_BIT_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Single bit coverage variable used to support coverage of individual or
 * bused signals.
 */
class svt_toggle_cov_bit;

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** The value being covered */
  protected bit bit_val;

  // ****************************************************************************
  // Coverage Groups
  // ****************************************************************************

  covergroup toggle_cov_bit;
    option.per_instance = 1;
    option.goal = 100;
    coverpoint bit_val {
      bins b0_to_b1 = (0 => 1);
      bins b1_to_b0 = (1 => 0);
    }
  endgroup

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_toggle_cov_bit class.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Provide a new bit_val to be recognized and sampled.
   */
  extern function void bit_cov(bit bit_val);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NjLz4qntFfLwShhEo2Sh5PUFEcahvUDlnD/kg8yAE3D8nSa5fu6to6topcgd2WZG
NC0n3AdNvc30E6aLK2WiR8jElBCQFSWlTmTKNswKzYcsfIJDzHrI0WfhTWY3SEyU
RbvehOqYr7siQWKVw5vdj8OSgNQspbUv7wSc1ZhXH77hTkt9CZ8JKg==
//pragma protect end_key_block
//pragma protect digest_block
1tiyrjXcZtz95IMYP+yXpMtt1AU=
//pragma protect end_digest_block
//pragma protect data_block
Worju+RL1tt07u/nfKPvYhFPDbStHB6E6Ys3j3skILtHOsG7DENyOoHjpdwFS0Ov
tLYKloni0NHlCq9NtDT1Pc2yp5QMWQFgzyg57X788J1v1q9nj/yA2OkXgGQLCp4D
P4ZkO1yf2I5DXxBRPR/EBvNr1/OhGMYQn+qqLzMd7Y6D/m1grF3c/gvSIFfYNy7+
3uXh3Z+vm3wc9P9DinxH+MxFeUJ+ERfD5zs6vh+z3EDaZvn7AFPaRyMWRuZ5aP9L
lETsSrKmxy//pmQBqSvevhm1/G2CbJxnXw8I4vrqI5zWKmY/wexp94p36LZs9AM4
W123L004KDATPXowYczIlsCT3lqf7wQfyqktjklfcPwrX9gu681A/p4Fe/1RIvV8
k2ssxjOcVTX0zyKO4x14ke9Bu3L+4mcKTwZxn+DZYsDDTl65AUvAKZJS19GKQ1MT
TA5q2ifd9+4tHT9lDzm09OzXvJI2yReiSgcbMMTRIUDhDdJ19g/8fiEIyaGCLP2b
iYoS5woR3keSvpArEvvF6Ca639axwlGQd+kf3l0tG3v+xFjXdrM/vI/NoFe0M+aG
RmR5V0+pJRzTxPoBjxrSU/pHIoj76aSu4HnGP+0eO7AhsIqKzbLFjxoCDnIGHvsp
8Pv9lpleF/O9W4i8I2tkBFhLTLUZVyX0PCz2pu06BX1nZSam927E4gM2PIUP1Zzw
Tv1ZWKUbirtCVftJHmVvM04ZgIPT7Gow0WviPTEtfY5ILxsZjmBs7eB2qtio4KQ2
YiQ6wAkzG19aVc1Ui7MjDLzT5I+M//X8M06LUL9ZtGhmtP0CScA7dEMrJh8GDmV3
jZnbV/XthwKK/NM1Om6UkGK95IqdmBD9cfVMUnkeDoVbvMRmp+cRaaE+tX8buWNt
hneKBCD8jNHm3QSScivF0sUT5X1eIsELRxlPffkVAzV6BjrtNpH2E7Nn7zurhjib
/tQymUCbd3KkR4ms2CzWQdos6hQ6wzQLyst64WVVpEWH1iD6nK1jX3be5kstnjJA
dsrK9OwDGM20IsGk37bIs4rWNCcOYrlTjVpfh3O8s7jZEyuRrwdKmcKBtcyXN49/
DvsdRrgKsrWMbxU+746B3XtfkWEV2N/5KwnR1tccI4w=
//pragma protect end_data_block
//pragma protect digest_block
FFQTbKsSpsHTYtUPa2P/BkuGYSs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TOGGLE_COV_BIT_SV
