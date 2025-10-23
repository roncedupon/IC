//=======================================================================
// COPYRIGHT (C) 2011-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_ENV_BFM_SV
`define GUARD_SVT_ENV_BFM_SV

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT ENV components.
 */
class svt_env_bfm extends `SVT_XVM(env);

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  /** Flag to track when the model is running */
  local bit is_running = 0;

  /** Flag to detect when the model is configured */
  local bit is_configured = 0;

/** @cond PRIVATE */
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /** Identifies the product suite with which a derivative class is associated. */
  local string  suite_name;

  /** Identifies the product suite with which a derivative class is associated, including licensing. */
  local string  suite_spec;

  /** Special data instance used solely for licensing. */
  local svt_license_data license = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils(svt_env_bfm)
`else
  `ovm_component_utils(svt_env_bfm)
`endif

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new component instance, passing the appropriate argument
   * values to the component parent class.
   * 
   * @param name Name assigned to this agent.
   * 
   * @param parent Component which contains this agent
   *
   * @param suite_name Identifies the product suite to which the agent object belongs.
   */
  extern function new(string name = "", `SVT_XVM(component) parent = null, string suite_name = "");

`protected
WYJACR,KZCG0KRZVX+KCQV81^eF#.B3B-J3]RH+,,#1cG+6M#\Ee.)MfQcOI?==Y
#a>><&]>ES)HaU2-14FHdOT=&Y@<-R[+2.IQ4Kb92f&d^/GC>f)X^7#VIHIW<T&[
[JZf+12ff5]&#6Ne-64gUcV3;V&&S-Q+X;+_^4LVfI:dD$
`endprotected


  /* --------------------------------------------------------------------------- */
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
EHM3;7-da-/KYMUN\QLacb)K,C/FPO<&^M8P9/MeS_8+#6P^.9<15)TZEP>>7I8>
&RBGGBMbfRR.C60gR5LN\+^7L6SR@PC-?8W?c,=Z16QVSB>0C/;ZIe-DgRX7C?89
GY;Tc,EafW@./$
`endprotected

  
  /* --------------------------------------------------------------------------- */
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

  /* --------------------------------------------------------------------------- */
  /**
   * Returns the current setting of #is_running, indicating whether the component is
   * running.
   *
   * @return 1 indicates that the component is running, 0 indicates it is not.
   */
  extern virtual function bit get_is_running();

  // ****************************************************************************
  // User Interface for Configuration Management
  // ****************************************************************************

  /**
   * Updates the components configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the component
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   *
   * @param cfg Configuration to be applied
   */
  extern virtual task set_cfg(svt_configuration cfg);

  /**
   * Returns a copy of the component's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   *
   * @param cfg Configuration returned
   */
  extern virtual task get_cfg(ref svt_configuration cfg);


  // ****************************************************************************
  // Utility methods which must be implemented by extended classes
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the component. Used internally
   * by set_cfg; not to be called directly.
   *
   * @param cfg Configuration to be applied
   */
  extern virtual protected task change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the component. Used internally
   * by reconfigure; not to be called directly.
   *
   * @param cfg Configuration to be applied
   */
  extern virtual protected task change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**\
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the component into the argument. If cfg is null, creates
   * config object of appropriate type. Used internally by get_cfg; not to be called
   * directly.
   *
   * @param cfg Configuration returned
   */
  extern virtual protected task get_static_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the component into the argument. If cfg is null, creates
   * config object of appropriate type. Used internally by get_cfg; not to be called
   * directly.
   *
   * @param cfg Configuration returned
   */
  extern virtual protected task get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the component. Extended classes implementing specific components
   * will provide an extended version of this method and call it directly.
   * 
   * @param cfg Configuration class to test
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

endclass

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_env_bfm extends svt_env_bfm;
  `uvm_component_utils(svt_uvm_env_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

// =============================================================================

`protected
(L.ST<3.4:Q)83fNE0]P/?cg89B03?D\+1,28GMBH\Hc?518dF5X3)^24Pfg07<b
(B7]O8Y(e>.ReW_M1IJ(;R1_IG3\OU_-<V<^4\JNE0)SKH9gaVXST[/V)C_3(5FH
J)J38M#]3>]&Y]a#TQ0-WQYcJ/AP<;Y6e)1ZN]DB#/X_B@@NK1TGP3ScBW^XUWB7
UM7S1=FJ0N;G8&D3S>gZfK2J0_1GK^;a>>D]Hf-?[9L5&Ke0QMe7bV]a?>B=6^RH
3C,H@TX:2,DFdX9UJ;_1YS](=S>bL3Q#\F+\cE86AM;ZU?/BM8fA?A5Z?1ZD#-H5
2]1WS1Z5G^0a?[YIQ?e2LBGTdSRB=3G?N>f9K6]U@ZHK9RG\La8GW?MF&NS.0B.f
=DS?4+9RZ_g\J^aeTA+4[d^W]RJ547P,QE,<57:Dd2,LTXE(G>gb)DdRQZATMbHP
f7V1-C.Ha/V-.JHIf?,9:.T..?;>I-)=GS/0gXUT)<f\=9f6^/<:a4MI,,Nf7c+&
:[Q6#-H6T4e@X0Z+-WWeM)35FY3;-93MJfe:=Bc7O=e4<7gfL]S-=4_/_.YBP0F7
NU^f>(Y:_5B,@)&QJ;,Zd5Q9S7Z9Y.3c49&#SO5R4(]50<6-KV=fH#acZd5fIY,P
V,IS,D_f0BR-KRY-;:f_KUD2G,C5/5YX0I[?-4MP^Ib+3V4V_EGe_=Q:1JI+6FPV
cKgC&H&JY)4L<]eBH[J+c;86P)30HQMJ<?UH;Cd#P^>T/>+bTT#Y2OV;/+3IB#BN
2V+a&LCXXDKU4V[aM8IXa2e&=3HKXcVOAg(@-8NB6L3]QLdQd;OYf/:>a39,#(e^
<]cKTM<5M.OZ7D<)H.T5D9)Be[c/e0?@.Pf/=.=/MeX^43,2OC5Z12Z34CcGOY4d
6<3cT?,C,E@@T+3cXH-+CLE+?@YV@J)bML/BX.Bb9[<FTNcGe:P@UN5?K[Y.EJ6@
f+GL+d3JDfB_H7aVdWMP,>VE6+Ie-b^1\)a]7(373TM2V#5B:aY.IZC<WVFaTV=4
#@)dZHAd&c)/.09+0HF=d7LX^U4[GVDOG=AKU5(O,D-:g3K>J&GUW\85S_e\\Hgf
be5Bb]OR9We_ALASY&ADgZ<Z@d[KHcYS#W:IZ7f48(9FRDHHAFQeJM\,D3)KYdKT
0Z?7a:FG>825RHO_YS]gO.,a,8OW9VHJC#^9#[&+XL5](A\;DAFL_/V,B.7aBQe:
LYV&PJ6W&SfIGL6IO#G(==F60+:KS=.BI6<H;YQc9.c23_\4)I/2Re-2d=Ue7SPR
=?QF<B?.T>DML&?ZgURG-QLS-T)TB#/N0e-bFMG1[Z-0W4?SKB8[J5b#Z#YZMaC,
HM9G[9356,/-4L#d9\.\T?G]F_M;8TR&f=[M<L<FS\RD@7U8BDa\/\=,gX#HdMdG
<;Y4O).7\K]fX88#8dS0-<QbN]_WD^+aD@_:=NFF2YGC3-E>8+JX0I^TRK4WPZXW
1C^:+>JEK,ND2bB(&A-&#bY#5@EVJ=<+/fMD=MH97,g<>W.S8gX6.N4+g)-fVLA6
-#&:Vd>E0GHc[>\fC1J0S7:WR=_VQ,aOg+/.Z(]+[:]ZbW&,ZEC/K,d)RL8Y8AP+
V(-V>P^E2-&f1g[>^HUYTEA[?1&&DV-@/,BNGWP-;Ma];0gSHc+6=dM/(B2,A_[,
+]&@4YeN347]<[#+2f01:.5\=&:Z3<IT2DST6\NM:1TF7/G[=32FC.gSY#@EQK.B
d\<O.JN[/WA+a6c\>M7YP4&81MV3U.I3R3?Q4E/:A-#Ha.JW;fNI@6,/&I.A5CGL
EN3#CX<T=RW(YW&;DQNNKZ?5#DU:&))GEAKPd:420SZP5BM6TAa36M(_0@[U:76[
^f])a^S4;.9QCRcY8&8OQ5/@LXTEJ3I99GQ2#:egM3#7JH3E\fDe.[L4N99J7C1T
Z[YW?W<W66>JGAC+2cgSV_^3J0-8;4,KNU-@RL^LP,<?2@MeT+F0GcfH>QT\])?2
_-DHJHJEBFWQ#Gec6-A;dNVR3KS6fDL)/2E2YBSRIWF>bf)LMJS>M?G4IY]fX+<W
TNMg[NDO,N\(Q3]PB_TK]Y&K,8.=CZO<I/NK15QU:O#1<f(;Z)PJ;F2Y?(XP+XL]
e[cLQI2eO6.Y91c#<[2U4<1):<7SBB@7]W1_CE7Gd][Od&D6,d)]B;0=ed3cUY?0
;KJG;.U6Z,8gc=TT+)X\U0XdKIH]?<eH,QN0+[I\a@57KVBJ<E[KAPMGMbC4a]a>
(L@Ee),Sf7,PaT7,)R1X5<D-1=>QYKd;-[4T_\OVKX69[W305<a8UX4ebJ-)8#\@
0f;&_,9&6D2SE+=.TO&gWH5Egc:B?fOUdE&\&U0JEKd_ZDRd2S4+GS29./0L5(c5
Q44MQHA9#I6[D7V6=Q@(6K8bDGGebdO4]_.7L#=;M5#\:0c,/@(La[]^]/)YUTR]
BIAF<bXVSU0]@M(#D2Y4G?TM+Vf4A+:c#geDZ11d2]12I.ZdbZ>b72_N#KID=S^<
A9MZZXW6#7,3YA)BcU5K=O]KTFJGH5FQRe:bBCS?K6/H=SKJXa#]EL\5d_S2^[4<
J,#^V67#[.)H#8-.AIHN^C]U([MZTe#ZgGd@0aQ6^0)R5O)Z+1&KCI^5;ab6SF^&
2=DOJA,5HBRQ[-U5MbLP.+,9BLbfW;X@51^aDb/b4N(5EZ\<fGHG_8.g/2bRWNW;
]&_#c.W0bPZJ_T4:WDTP99VQfc_?MB+X=UX2U1CaS/-,B-).QSB>,=@/W\M>@_=F
g5<@XDQ>N^8Cc+,FYMfJdFVLc6#/LJBAaKKb0e);/+VUG5R9RN<UB)<Vf188AM6D
#Q/LJVTac^LW5egYXVKXB/_Bd/6-+^Jf+bCMY?d)A\LE](P#Tgd8Z2O_+A<]#P2:
BU@&K06IcGJP#d^G8IW\-#RDIOF,F91K:)BcDDQM]<g7Q1ZN5Wc7bQ21W0O70,W?
LZPK4:8Uc-.DJVO=#9\#5PAR7a8\.BA0MB+=E,Z73E7T:K5KM\GR74a^<OO@EXE2
YI\gIe696b8cE=P_=#FT7Q956XRNFO_;80KR>_;KPY.Y_B\;#>TBC1:c6753>?VW
5C?ffdCg.Vf&HcHO@)2TK4/[?LeVe2-[RW_7XS<A\cbgB#aNUC[),eGZPRA790Xb
X745>XL9YaRXcd(]R&>AY2;[S)c8FcR7,\1&3IgEdGS((.I7/W62C7KU.La6SEM2
#^2Z<:T[?RdP9E-LeZNKJNMP([=f_geH;Q2:C,,YeS)J[7#]D=,,R1;[?[Z2H+Md
P8[2XEQ^VHREgVQZ:;)<U@bJ^W&_+WEMU=/&2R)FVQ6@);]?[CSY#R9J,#7EZbBA
]]RBFgPPK12>BNL#g2Ue(R_:KF8,/Y<AbWL+e\OKO6W6dg[=T-H-IM8_@G9<_]G,
966T;_,67,2Pe64e((<)WIV#KC>)DIK\P&B43-(gS8Ha6ATSDg^90fc:V9dGSO35
]]MI^YYOAe2=C?(Q_UV0CHd,B?2;&_YZVEHg+&PN_WOH@:NN:R[A;,Z)+1>VD_Lc
EfB6DQK.W==KD8JR/a#-_J03STF^DQSK,&-@.+7e:eUZ7[VDdHKe2P&;NK-,1b#3
XN_XU;V-EJc2=WKOT1-=e<4OSg/N<6U;c+<3#_R=,3<7_]9@T#H^K-O+SLMaFGES
+N-g8:3U5Y<0C0LT5RESJ;@JP/W?&.5JJZ9/4R+.R=b&HL4K/>YcOK[:eSf:>?C&
1Rc9@\/0?G[,aS<_V/f0\8g>GK=3F)dR,<gB(#Z6ZS\geCM3:Z37XD5_8g@g^6>6
)BQT[X]U-].X45J.LNQKR^&-ddOa&?6[>72/T&_Q@05[)LRX\)UO[<C4OVe5S@aN
?A;a3WYIJZLJ9#/,+_K&HV@dOFIdL;MM@-ND[XAH8[^[;FSWR<?#64ZeGUaD;,5+
F3AQMNPScPgZH37G8RJ<B@DKe=8U]GZ<>)T@#VS(-](KKE?Cae7W06c&=3ZK&KL>
Q\Y9@CNBeJgZD?4[+)(.>eD8cYcbE1\6C35G#)I(Y7,V<\[D,LPI9F7Z>)QD(@\e
C<1<:>96b6WP83+M;6ZI\ZZEH(CGT;4BIX+^-64JcB)A(U#S[YZS(&,I6?/_f6,f
[cYe(ee[3;&,<YZaZ2WM=0-IU_XD1Z=[/VJb1Y/6(5>JfM8)F08e^NDGA:JcOcFD
TX;,90[Lb1f1JFa5+S5&]G,f8>I/I8F2JP)/+M[7fNZ3a\_8H)KPLFa\O.HfQS-b
ZB:B-f6+U]1V65XfH815eR8LI>5ONK0)e&ZW1S.f,)e</DBdD?UR;KXeAK;].];T
BAE)8R-L)1M5C>E>8CSJ6;g5OTZW2+HB=eAYCY[T#,QaS@A)R&VYL&7#D_GOaV0.
IN=7e+Jg&?e;7/E:f-/X8?<e/HLPZ;Y?:6)PQO,b/T3N=@5F7QI.#PHNRb-Pc0D?
4cIf/,=9cE5:1If?9N5;fFZDLPeC^=-/P<_,d\H@)[Y&^@cSe&UdGE6O__>2A9UQ
c8=b5d]]eWGb->9SWcO#+VTVKPHPXf\H-)/STDOB]&HVXYVC)VJGEKH9>(>/2ABa
WFT=eJ[O-a,^a--bB=d,-cKQAg/BJ@C69D6[BXZ^2AX@AT1Y[GIICJ;G4Y(0I^MG
eL-X9_JP\@@;3Qg#DP@O[WD4X]ZB4e-7M#;],,660Ae39a]EbZS&XRDH2?ZXV)OZ
I<12K7-GH2+gYV/KgZJ;--.=,O#\58^Xb,,Z6H?e&F#C5O#OFNEL&=cQXDDU-X-3
,F(a+Ra@AFZR<H:.)fWd18]Pd&+<TJ1I5:3?e3>=2-JRbdde[Nf,X_>B7\)GPR<3
.B.WBM>/cb74ALW(AD5,]F\+R61@RJWF-W0XPcRUOePJ0[VZ7X;8\-UMZF)-Ca1?
a6_40KL1V_-a-I]CG&A0X/E_4+69I01N&Z\dR6d9RY->LQ9FX7M0RX1G0RI^;KSI
&X-K6#KZeZc5cABgA)[BKcY=05HVBNC=e-V.,ARgQ_Lg+UAAC)@;@<J3<&Pc:X>)
7I@D67&2BCXLZR=5DX,MM2<Ue,[=A+D=I+9gQ_Z/-C:J@C2-Z#W6I+[;?;/a-IYW
MNS0[KWf9M0f9(,b#71+@VQ8E=]X?Q@M<AR&(eGY4).0RfBfd0F8E5Be\b]V0&6^
HC3<?M#f\.EN49c\+gNF4aCTVZJ98S<LXbS)S[bM+RU(eE4GS50+3]/M9YIU,HT3
=eK(MV9YKbUAcaAe.b+.P=.>+.<35D]cL=-AJ-.@@/V;RG[NT^_?).9;)_cgDFT4
gG6gS:=;D<>5=HMQ-WVa0Pd-OTfD&1_RRbfTgCI2.O;\I6PU><)A2UJ9AVX05Z9;
T43M<O1Y/(3.E?@9V;IPE3>S)66:D=04S^:9d75\?_09#-K>VE4P+,2O7RgaBBWe
9SWE-_Z[6((^_#S#>O[DD,JZ;XD_e8ZN-5Y0H]^K2N3K@[TAC;7&Ua_KI(9V#>ND
:gUE4BB8(U0GYZ-0V4d\<-_^X&72gZP,:[=7:cN#89I;8fHL>^>8/,<M^_aS\KBU
>PA4ZU#U0+e.WXf0F22.PF(AVN7cJP(eUE4G9V.&)+YIJPbE)A.7;/dR@.T/D^;a
^&<YX4Q..S(P]<HO=C1,9U,Nd>D;P+P#0aI1OV2eY/FgdQ;Vd?bc1QAT7H)Ic1BI
5c@dFf6JWAaSOY9+0R#J?,FaKGOa_;A#7;CKd)T1U(MY<<NCgXSMONEVZ?I0OFX0
<U2Odf;N65a+@;:HSJ(P1fY82.OU6;eb=eX/CX\J71BI5#MTXbZZ17Q^1G+\+1A1
S9GOb?5c_;73Gf33^W&5OB8:W[>LM.1>4c\#Rg@+cTA@]>Q6#HaW+@cB-B7?A9S0
[L4A:0JT0CXUBe\+^I\^VdZ;g0^FEYeQTLIC7;3R]f_3D46.PU3U#SQC_0f2;_T4
3G=e.@Xf#U<ba48Z^>-O(abT^+)fB(b-FVEL+:3IR;JRdWBJ?TPAGV;),QX0^.g<
b[VbaJ-XS5[_C9U;-<WA#=&;dS;UE,ES,DDT-(PQ&^A_TDR;bY<:b?/GGA]+EU#U
:D07JE;4DJFJ2bDO#G.=([b#?[gZd^[_NS_5Qg,4@1\F^.1FIC(?fSA2[@1+5VCd
D1(?57.SVBW)]AZPP3#9=XSc57>EO/5&.G)-M8JK6e\KM.HTX#f?^]2DJQM<g\7O
@?_F\EUg>G))*$
`endprotected


`endif // GUARD_SVT_ENV_BFM_SV
