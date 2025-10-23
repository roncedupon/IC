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

`ifndef GUARD_SVT_PACKER_SV
`define GUARD_SVT_PACKER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(packer) abilities for use with SVT based VIP.
 */
class svt_packer extends `SVT_XVM(packer);
   
  // ****************************************************************************
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
   * that provided by the base `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract
   * flags. Setting to -1 (the default) results in the compare type being
   * completely defined by `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract.
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
   * CONSTRUCTOR: Creates a new instance of the svt_packer class.
   *
   * @param special_kind Initial value for the special_kind field.
   */
  extern function new(int special_kind);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to obtain a calculated kind value based on the special_kind setting
   * as well as the `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract settings.
   *
   * @return Calculated kind value.
   */
  extern virtual function int get_kind();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
LO4Y\TN:R0.8U]AR5UH#D)d\PL3MV3:LJRX##.e8<WTa.];)?O6R.(_G)GKgO?Kb
3ZU2-A+O:D0^Z]b?[-4Y]cV:dVSa_R6]X]g]M;Wc1UMA,Ud5]0?/Y5Q6@R,VN5JM
QC;^?L,g;TfT@/G0,N><ZG,e;#AOM>W.4KG<28R/O&[,X.KP?;OAHHe:39KB\f83
ZObbYfQQ=b6U89ZG/.KM(+MNO=eK<4IZD:J@?3bTc3\DM):b_(:)6T2,^S1]S:JY
^K]b3(5dP&J>G50TfAC\:@K>H6JD>UJ+3XA=PS;[Fe:1<);bEe@XFbLNF4=B(UX/
JE(ZCO3X>(HS@YeeG@MaUddL+Y2-YaXBVdO\/?cDAL4>4f:a^N8gX@Q=PB^)B9.8
-EXRTg(4WSV@\UPF+[PUfe/aV;V<cAYL<07##-TZ^MV:g:Da.fFQY;:R=RO4X]Df
:UaJdf8C6O.e0SE#L]?Z@/7.JXQ,\eFe8aM6@1P3F_YdU<RFSM9LPD.cbd1XHLIB
TC6PdGDT_S:0[AL\_:3-.(&PJJR\<;CXF.AQPBf;IUJ>#,&#B7CVg;Wf\]O[D418
>2dL@bHBISUJQL9E;fH_e)OR6(7^W)GS,4@f#e38;@J_NCO]\N.YD9\+GBN;007J
^dWeO-fX8AS^OLCc@dVa5S@SC@N06dL,3SRMQBJAd=HB^gJ#9&b48Lg?/,S6#V8(
c@ed]=\G07-C2M0:7Y1aA\aCRO(K_<a6R\;45T8E<B@-0/\M?a#HFW>&bD&\/J._
LF?&[J0[.Gc4U+J<;9@A:KIV89Y09P48/eD<12#&CEIZ<d.HG#DJ#FI3ZWaOb#c]
aE:Fa<6T22#.#NC:XF\(L.JAHF-240AFYA6GWA;BYHHb?>6d_5=1;\-6+bNe6Y^S
6W&BBcM\L\^O.TU6?;&,03D/b-VKR.dI9:]UWF1e./,TR^._[[C-&JGFdH9/)9bP
#VHF7I,b2)GA2GL0GOBOd>C)54.NS0A+#9MUD>5aTfAeDaEbdTd,4T90:H5E_,=K
N3(4P=MGLB-)F;+5I&X7DBC)4$
`endprotected


`endif // GUARD_SVT_PACKER_SV
