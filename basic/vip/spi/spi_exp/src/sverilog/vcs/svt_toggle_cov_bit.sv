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
`protected
N_=KEJb[D:-#KMa,.JDRTJ^#b@2_6G3eC;GTJWadAN9e:MS(T>Mb&(?P26_,-_Ac
CTYRQ07^_gPO:-==64MR[Qa4KB<f,)33\N6I;(VM:A+(BN41DO^+,R9=>>2+V414
KD]=eR7b57G5=Hd<7X1]1XZ0Q8FRc@WgFXNAE/P#-)EZd[#=B/0ST_3&ZcBDK&E:
KaJf251O+&a4E@f5JfQ&ES7T\S=I2;N=]GQ1T4<]?\JBA1DbUL9#\M<.J[V55-XN
_Lb2.bfT1+8MBKWE/2@MU/ENW+5N6AE]C+6K/Q#Z?M53-G+;_a\UXQV;f/GB-E:3
1I^<1;PSa.d5X_&FJb6:>a=9C^5T<9#6eDC.#ARC@LLVBUVN7MWK4LFcfUYD59LB
2/D<YI7[&=<0#8,V^P18X^,fT_^81YeSC5S-B:O7K^ddGb&Q0@O18O)E9+_:O71<
g#;]HcS3dC?.7SXE)SJGMfXG=.8>]=)[.25e=EEU&\EO:5<.GIKS>7(AK_V8.D)S
)B@&<W3\AcGECY2V1LD@Z&:-6)&NR#VCGUZc;O@ZX5?(OcUG]&(X@C3#YP2eF17G
9W^@;PRJ](0fgA4fMIaAKM\D97P\fZG)Od#2T)EU:CGPTTd+bf(ed/7T#Hd7(?H+
aH)Y-F4+[7E+>ccggCeI(dZ4<561?0J3-gQ)2ASHQDgPL.5Z[P.f)6&e>[KWR-^6
V5PB@7)/S[HFPEOc9>5g>UZB7G:Q_GU9+/;?Zb.:9SN^+Zgd>B+d?I-Zb^f4>HZ]
JN7ZQU#B@RQ2H1[8g(?4gONCJ3+O6]FC,5K#/#V#He]REE:WUJ7AQ\Q.<2<B8GRb
Gg]N\8WR24?->V<-E3,c)7;//RDJ\?3_@$
`endprotected


`endif // GUARD_SVT_TOGGLE_COV_BIT_SV
