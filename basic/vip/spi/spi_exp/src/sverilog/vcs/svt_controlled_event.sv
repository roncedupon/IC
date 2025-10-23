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

`ifndef GUARD_SVT_CONTROLLED_EVENT_SV
`define GUARD_SVT_CONTROLLED_EVENT_SV

typedef class svt_non_abstract_report_object;

// =============================================================================
/**
 * Extended event class that allows an event to be designed to be automatically
 * triggered based on external conditions.  This class must be paired with a
 * helper class named svt_event_controller.
 */
class svt_controlled_event extends `SVT_XVM(event);

/** @cond PRIVATE */

  local svt_event_controller controller;

/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name
   */
  extern function new(string name="", svt_event_controller controller=null);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_on(bit delta=0);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_off (bit delta=0);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_trigger();

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_ptrigger();

/** @cond PRIVATE */

  /**
   * Method to implement a conditional check to ensure that the suite specific logic
   * which is used to trigger the event is only initiated once.
   */
  extern local function void activate_controller_condition();

/** @endcond */

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
O3FP9@aEU[TfbW2+RR;:&S.dI.:[Z@X4S_A^IZY\XP#FCYc6R/e8((6CH\_Ud-I[
UULV2@YV?/DT(e-N=.+.G)e94(H+<(^c@KRF;2LYL/A?]YW@VL@=-/]CfBQT^=aH
,@LO1JYcDXPR+8\a<],E@<fa(&,P/0C]bL+/#bfL(gULXZ2WBf5^+d4(VG9[NUT<
>I,/_(TODg+=HG#3:U+a0DD?0c-<;E_]2;&/?fP9+Me;]+Zg9U8ZJ-84+TII/=;Z
Y)V-a5;+S0KE:&,AYH8J?F77PXG@U=DOJ7O6I&>8\,SfKQ9Aa2b5dg;X3a@.F.\S
MeVP]^<4/B4PZ\JB=7eT&a.2^NSM31Z5+(UY+EPHPPF&_,)Q._JY]0B#M@3-Y#XW
0Y(EaIUHXMO9fb,6EJD4Hb^O^b\a-Ab#1-bg^.L=H9<a10&DC2IV:M24D4[9WGI3
?/eY,L)3S1_4g<8\?9gc^eK&TH11Sb[01DX(+W+KBIR1,,;SDOOLI-(dN[LcQ=4B
dgMc6-[aaK]N(^3MY-AJ=/A#cLJ6-dDQJF?\D_P?1FK;V3T+YW;?5e&&\\D(aESa
]eBVMB0TGXa@Uc@N73X2R,DZG(P\+)LDegXTXU-+U#,W^(XHN-d@eSL-GHW[YH3O
&EWX<=/c,fUS[XF#&\g)]b#/38VMPI>UC1[\:;e9CU9^/@2-NOL+Te9R+FI(STPg
2d#NSJ<V&&OH5NO:\=AcRGJW1P/D^D#6GV=F,NS&7:HQ>E;#BKE?KE7,/D03U4a5
a#B\2(M7D)P.]-I\-Vf3MJ]S<V)<WBZRfg6g8&YG@eTZ=[Q0>d#._f9>CfF\;B;H
Z)[\R(Ue0gKa\@<Q^8@);T6FAL_A6G]73FB43:e_]AI+a?3+8[2F(2>b5(-.^/aV
=CQM/>DAR#&6NO==I3^_>JeG@MgU8^9SX_@a<,RBWW-BMM?=GV1)EAXgeR@dNYdN
6N,?&\81OI]0RQ?B/[2C()6dYeF=aBY1K]=ePcY^_/TaXg(IZ+SPeE?2G,FVY3,6
0BILAVd@\WFX#Z?;FZGP]K2P18c5^F?S]QJdXILZHX?:(#da)GfJS;d<P0]OX1[E
I<c.0<0,Cb4SeLKMT.<@:a0)Z1P)RG=W#X6QUN:fX^I<V_S#&3Z.)EH-2d5Da7[4
Kc+Rc@;]SBK2:(c&S0EDa22YFRJP[A@(M@I#Y+W=d0MOD_A/PdEM>>W:VCZ6]LUE
e]?KJ;>&W#JBV2LZ@Z/F-P)TF_Oc<=XaQ,WUB2Mg;]4R)2TG7,_Xd=PabZd:0I>(
C\S@LK.1MLSM#PB_7;+Pa;:H\01HNA]S_Y&b0:3+_ScG^eaA<#eL3O4;_&=#\CT2
&D]aXHd1WS@:/5fOMdC:TFURJIM]Jb0Vf,/S]4X,Vb2fP6KaC]dc@3.L],F#[Ng[
-&04;8[IRZfRE(Ka?ZAF5VfABfJbTa^=ag&Qf#Gca#WPQE;/Ye].Z8bM9HM1[R/4
MZ7SKR3Y,(,Z_)Ce@(H_M8)I-d-E=X&<bcPV754CYdg87bYQLH?=7DEZ]8b>\MFb
M)UYT#1K&K_X(U+R0<>,[CQAWMD:11;@cGYVY.&cJ<?-Q=:Cb#D#B=GQWPE<eD]&
W\+0,FR?UBE=E7V8KSSQ2\8X9PY9]&]+:VHL9.\S3cVOQAOHV5Ze4A4?YOQ&dE,=
]\VO(>C#Fgf7S/gbY:Lcf?G5DWC+@KOLZ>M))8E11Y,2^c/>f5?HJK4JQgD&Z6>f
.bAT>2/5<(QJN&b8+RDe\D&8VW3NK[)(><&@#XAMPY5H?fTA7=\7&,R9;R8bOP85
]dGWab.9Q<R\2-bN_[MaB[)J8-Q[.5c)(L@?d#B(OWT?3I.I4O4Xc^Ed@N@:(-L+
9F2[@dQ_dWg_B6)O=3f+;_.-]W4QBN),I@]V;1GN9K,>5d<bIUL=[NB\-6JQG8TL
gNTZaWY\=JJ)DONERF7)93?JGgO+d(7)\[FRF/\>e#_,SI\TD?\AP>ZM(WJ#P#R/
Td->LR2ZHIS45RHDg8R.5V?4(VXeMQZ85:Vd4LS)V@2:c>U3IZII-FgQdQ7;f;UM
7=,dDWaCIFCJ[=AH_Ma8@b?e8:_?4P_NG&=SF)9f#B2DYP)OTNHM.5[FJ0B2^H3N
.,3-GFC\QE]_&9/4PU7EDJ&5:6^U.4TQ;<N27J>P\ZU)B_]]68Q(UL=g1da56g8G
EI\)0^QISBgA^0a5K/TRMaN<[=9\?>1,[f[A/]=\M7+580K&<8d2:<G@W0P&S1K3
BZ[N[@_YS842EW/^UX)9;.=BS)U=IR&>=dYd/5-W41SX-8Z8A^HM]JDdZ2@f8,+K
QUG;(b3P&6d+U#=4FL#L6W#44e#H]Ug=MWU2M^bNQ?N2,:K<bB.ULG#2gE=K6>.=
Ka08<DgHgd_EMQ.g[^UHfADN(44E,-NT9W\e6W>6:9BRe[^I]4.Ib9eZP?3XQUQF
15&gD.-;d02>;&\DM8&&FP/M=f0Q,]-2>$
`endprotected


`endif // GUARD_SVT_CONTROLLED_EVENT_SV

