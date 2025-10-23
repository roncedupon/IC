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
`protected
MTL)f1IGPaBgL.4EF<M#F;]C]S)KFPMC6d6NU=c?LWLBL]NR[UW1((_#B[2E4TE:
5ZU?C0M.+IOP2:\ALUEJ4D4,9K0OLCd21ReB5b?;LW[fGB-P6E&>N3-MZQL9JUBU
ZA4VF?+I9GE))=eT/-=A5FP[/-Y)?PPBc:@4R14LAETdb:b0A;aE3DKa-\KE)FfS
.5bDddPH]Mcf/88G[^?aR1d):[O:4)+1P#+ZYBT&_^<g(5M>@E+,-O3B:PeaUa2G
>b5=g0XTJJ8_N(gX7@RF5(M<E_W.W1eX8QfQf=/M2KVdA(X\ODd@7-DU?]g0QBG3
bG,Q9f^<,.X+I^32XX>@(YQYVF1#V4_NQ;b3657P2U3FQSeaW;W(TdCL#(<#5([^
DC3GVe=-e==Pf4O26VcR=+]&)>S9:^_I21DMP5)05HQPR24Od:83LY_Vg4BE#7=D
.\JW)]eB6XHOOA<3/&c5N(aDe&NZca&V:VH^O&\^V9QH_4gUD56+8HdG@A[]^I)#
NW(<_-SG5AgO.I8g&H<:L;[RMMgR1&S\@9E--L@+NJC&a1:@LH8;8R<-/98[K(@0
.9I9Z6aTSBb9J3<O&GB@I-+gUI&d+@Kg1gMC_]K)S42<NWBO)N.Ja6_;LC@f)D]P
T1/?S3,BC/QE6ea/d7ff3d(?1f0>DG=UUPQb#O,GDY4;)1+AQb2?7.&LgS4YMW(6
/d<1X6?M_+5GQ0bY)(9+;X@2LU[/cTB#XR5A16\>>4DX-Eb4(^eE3YIVWB&Q8\bW
LO?c;P+3N+5+F?EO&>CK&&a38/\,9=fQ&)#+PB-b@C]-a.F/K.CgM,LFZ5dYS<^:
dcP8PdAd?PL+fU7Y1(&BP83Zb>WL19\9^YW+UO);:,M+:)gd4O@00]gUgF]ZUg_.
Wd\#84C0g[_]>=-579AHD?[3?c;-H@gUa^?P,8SQ0Mb6eUZOHV#NJVH6GY:;(.1&
I1@?JAS,&WV>F;Hc1MS+fJ2WabBX6aCDfS1>9Qc0G@I2+,&4DdJ]N476\9Z(Q&X5
/GCIa#&)acXL(DO&2KH9HOA,L1S[:fM^e]]H8B542/?JWgXT@Y_Ke\+2ZON@3Ia]
8BC=Z(Q8W(?O[>0//)3V7+5+aIa.g1Q?<XfYD6-+P/83=5<L=:?0BHM]GQ7/S&L2
PGdPc(2C^<\4-20NX/HOD92&ZH^#]5BQEEVUX>=]3BK)F;a4JK^8=]b5G=-ZDf;0
+H;JYM1A9I_0_<UNf;8F@#;=Z,2SXN^A7fP+:6.>[NP8IRXLL<:L^U<WZ=I=)P,4
77\=-18I<e=eS\Ic]8[S@8FQH6(Va2bY#OQ)W##JKU@2-13>6I9BND<WI$
`endprotected


`endif // GUARD_SVT_FUZZY_REAL_COMPARER_SV
