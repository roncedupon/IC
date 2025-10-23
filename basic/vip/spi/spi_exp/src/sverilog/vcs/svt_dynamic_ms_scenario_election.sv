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

`ifndef GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV
`define GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV

// =============================================================================
/**
 * This class implements a multi-stream scenario election class which avoids
 * disabled scenarios. It is designed to be used with svt_dynamic_ms_scenario
 * instances.
 */
`ifdef SVT_PRE_VMM_11
class svt_dynamic_ms_scenario_election;
`else
class svt_dynamic_ms_scenario_election extends vmm_ms_scenario_election;
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Flags indicating whether the scenario_sets have been enabled/disabled, populated
   * in pre_randomize().
   */
  bit scenario_set_enabled[$];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /**
   * Constraint that causes select to be chosen randomly while insuring that
   * the selected scenario is enabled.
   */
  constraint random_next
  {
    foreach (scenario_set_enabled[scen_ix]) {
`ifndef SVT_PRE_VMM_11
      (scen_ix != select) ||
`endif
      (scenario_set_enabled[scen_ix] != 0);
    }
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: In addition to constructing the objects, controls whether
   * the randomization relies on the VMM 'round_robin' constraint to choose
   * the next scenario, or if it simply picks a random next scenario.
   *
   * @param use_round_robin Indicates whether the next scenario should be chosen
   * via round_robin (1) or purely via randomization (0). Defaults to 1 since that
   * is the VMM default.
   */
  extern function new(bit use_round_robin = 1);

  // ---------------------------------------------------------------------------
  /** Setup scenario_set_enabled for use by randomization and post_randomize. */
  extern function void pre_randomize();

  // ---------------------------------------------------------------------------
  /** Watch out for disabled scenarios. Move forward to an enabled one. */
  extern function void post_randomize();

  // ---------------------------------------------------------------------------
endclass
  
// =============================================================================

//svt_vcs_lic_vip_protect
`protected
G4HBYP(#aYC[69a@>0MNK5&_Z)PW,8)N,RG6@LDL:Fa\UE;.&ZKC4(L8QIT];/a]
Qg\a)c@\-FcRCZ,fK.BEea6N=0^I/&6[NRUA87T3;g6SO4bO]PO[VY)/>I8FD#0U
/fbS3QMP7ZbGYddX-TNRHM5YP8A_:[PfCT[V<UNX+e5(S.d9U4<e>bfY0@3JJC3_
\cbZ&Z>IK/c6;@K:1ISRH]/;-3aJHVGD64(GW1g@bE#KR-@_8#Ob,;X<Rd/0@;BI
AZPM;HJ2V#1PF:eJG&<aUWab&<8]?VX^GE4=,<e_;b@7))f#S8=V7V5XCKZ6&&VK
>(Ke+f@f,<?>)Q.CYcZ\]D:^PF>N^X8-(=8_(RM^6VSQdD3:[YJ3>9dbSd]-:^N2
8O<@Qd+WAQe+d/eb2TLQ^Q];>.f/)D?X-Ae0ZgEL)e6>G129g<_bC=JQKbeB]+MO
K7D\VXM?BY-W=R,(NO:&,3bMbUTJ\J&]0ZdF^I(4>C-HHU]58&1gUID(:XHV)>PT
51Id[^(_VHT1:<\.ED=eG=/_(\,RF]3843;9_.d88XAXf-0^ff7d@bJQR<;?O141
GY#EDBL):^Xfd_]J0)&Tg8Q>R/R:e-12[/VG_<U9d>OaDM7O=daYa]+=^FBPR.[K
d36IX/</9/^ZTcf-X>(Q[aJ6=6(,(9M-JS@#4Q2VI^5eZ.])P>g8^8(I@8)R^;OP
9X@BfgId6,O6CVcX(8W^ZLA+SMWH=C@B?5C3(H95cf2XJTg<E>+eFFd&F8_YK4O\
O]@2@QK,\^8Y(E,SI=]1E^MH<^LJ[WPLcPD==ef_1A(I2JO6H6[CQI6L#)a>+B2V
Y6TJ(a9+GC+N>EcHS,deT?-Eb6Z?^3,K5a)5>d]&-C\>N&6L1&]aYCSCJ;DM:gJ6
N:8]^@-3gU4YT4#ZHV8B^K;B]3>S8T[T\(^XHCQA:CPQ;E:[M(NN87f+GV(32HU[
ATN9?b62bQ\8<;8IE<LOX;J.BO/@XPYNI<8HN:G&F^WfZS=Z6,0f)N[T8V?HDfOO
AO4b2Ka8V6O>FE59f\a2R?S0.3IY72c1TeVd#QI95(>af;;F[2KE]TdRaUU]d+AZ
R.JZg3+_(BB7)CNWK2K\M0K:R,QFa5Ze#G30J&Z>N_e54d(DUSg2WCbg054f8^.N
7TR.FXe)MUZP[0=&<65[9B,GOcC=cK.g^Z2587_J:YD\2O\R:+IL&_V100)_b84b
>5>VE2a=_N)R##S>1^15G,[\P\JRJY7a=F&S]0>.Y=#>=;DIX70_ZE#YZ:Q_Y&:.
2EP>ae\Jf80JH?.VMMK8LFZT3+<QU<e7LZ(/ICbFU&YA+O3F&Z#0f-]:^bUe@S[I
CICZXH8F,cZ?OE_AM73R;IP[gdfDB8)(BIecJ+E;IE1d-Aa3UDNfHaV<I1:(_900
F:\LH-bR4JbZMeL21KI5NC7U+CC&A<F&7<a8+[V614KTGJE=R\gJBXS=/^:7Qc@e
1#):&70\c#6:_NHOE&fSf7WH(1,46N5+&;N:T@;>&L+XWHF&QJGU67fHFW#LOTQ5
cU3[YW08JBFQ-@-1[)^?g/WO)<CQZWL/>^8cE\9D6gbC?,?USVO,.5EEPTd,0g9Y
IIG.BNag494J3OAfHGbf1<^A0EHLfQBf&RK:]=JgFc)=.(7/ZO#G)Q])_>Y[46Q_
V[e\/N<FY?A]/Tb];6L/95]DPbRf4W?+<X6=Qa#K)e-IV)^8Q3AEG9)dKaLXaR,Z
JcZFQ3Z>MfDSWVSK0TR7Xf\J.fWbNJ_&a+cQZ5;J]/Z(5aRL:D(.CRV-GE>DMBN=
,V;#^=e76S2&YR0Pb4]U2N:;8&e4VHbPUK^g:&S-=I\04c<9?aEAI)),-M&NRC;X
E=W.5-[b5Ia55PE;X1?:B)O@7(PVR_:If.WH.?N/8Z4+)#g:d>;2F[K^,c0M4J64
fT<I[EIF?AC7?>He=&>(##c:0>J]_.X(_1:5Qa\(R]H/48#9<])H^,[8gM6W=L:.
ZFZRIbC=.)0^O21SIT\4)J=41_c2Lf2IN8HLA#M,F4deQJ_cK)Tf(#ONf/YaTCSM
c5c(E8HP18?(UD7>40GE_aMC,1W3ZAT[77YQfE:?OHILO6DNVGQ9_QBCOBH3L[F^
VA>1f6YRfLeQ[dWEO5M<#XfQgSf5SK=)bSYT2.]9WO=Kea,Aa(=IeU2X7:>740IA
.TQ5c><C>L#L-8e#QeDMK-<U78d>YBPTfc9g#&ZSC.3GE25DO\>\CWMZI_)YPDbK
ZGR3f[,d=U_bU+^a?Y8>GE3FN8^G2A<Z_,Y@N3bC17LYW#:.cAD-FCC5-S520bZ/
8b[E5cB1.VCJ0T?6N]LX1]B-+[ZZYQ4T/UdbJ-[6;0_BDZ4HE54/:JL\]bc0TCY.
GM,bH#[Y\MZGUVKB5V?,e5YfB6DRXV,RJ^VJ#(Ub9&V-9+8+XOKdT]1A.7];[2?O
S>D)NLcJB[O-aHN3/BT:gd?4/YdKAf+,FgO(O-+V^&MP+a32C)H2aCf3?@QPMMa2
P@6.fgdb32>b\M@--&<GW#NN[g>AFe#-G.UVZ:FgZG><<f9fQ7V:(WLQGL?RP8aT
L50IA^&O2S?V^(HK\BBR(R1.[<(;DY314+U(ACP@VAH:aFK4E5e>aP?;VW/T_:>[
-.TDJeI=]7]?RHVOO>I=PXCPc>g4SVfa:;I=B1c9&NQ(,]d1f01VgcEP#I:c4P((
MWXF<<7+F^8UfLd):MPfd@NL^gHODVWg#Sc^-/K28,GT+bIBVNa1.[>Z]UA1QW9a
K/CgS#[2T5c?SNV,GU@c8-W5gae4PWCgJP+O^]X\H9#CW)W);^3L80^A\\2b[E)d
^XB<5)_F1__KHd)92-K[#)J0UE^D43)W8W)/:U=3e(bCg,DQK0_E0,4J_S]VgG]E
PO?6d+9(d/]3a.(W:c7Z)1\;VTEKP_([I#4b>QA,JUdN:7ZPJQJ\B-YVF;TLXWQY
aB5ZRT/\b+WV\086#g#Z<IQ<RR;2e?D/S9f3:LC#\B(g#X1]-0NJ8@7;P?64A4&=
C&D:R5Y\>RMZI(&PJC5TVAAMfQ_@L(B9KD5E>EAS<S)T[c&ZYI>_?_29A6gR(0=U
MP\6A,f\&a-;bRXIX,>2Fa))F6C#4=c9<F2O&dN<^\:0ALe86Q/e,/-8,L;M\cY[
(U=c\^<;cedg1@A1XXC3G]Sb_CCbXcHF2ZL1]KFJe/9;1)d8Q/L.8RUK+,U>2Idc
d;]]T-2[_VgM;=F#QXgH[U.)KTDFEP5I/B4EPb>M0GXNV)8Bb1dQ[7Q,K0Ad8=/I
cT.6O.#GLT=dPedg3g[IL7#FK:0HF38c836Za&CVYO44Q3_=gN48U+C]CC)[d>KI
0<7DN]0e1.I0Of.Fa#\IA33Ge^NG#][D.N[Mg-5UHJOY+ZUK0/P,DD7+>0Y;HOG-
<&g3d3K>C^C6Y;g?),.-[G1Ffg\W-SB_[QVO=Z)b-&N1a[@Z>UNDT#2VXZ(F@@4I
I&3L#^]W2/Fb#B4/?Q0EPIX1H407)TAZ1)c-BdNUVa^R^@M=@cd#GZ&I3/X0HBYJ
4/;PHeTcM^bK-P3CQ5]-18BaE8aK3^C]_/5&GTS@A5FTf?1/AI@3F1[^MQ[B#@U7
<=9_+PWF\O)@T;L;N:]Zc]Y@Gd.,@OOB;7@eMT0YS\JL02/-QTfWD+2?\cLC3CHJ
&dB[?a]/8I.gE6d0K[T\eDVKF]#>07ZMg3>9+?>>3GA.KTYDZWMMW[1Wf:/:5[_5
U&\GbR5>L2e;?LW.6+U6^A0(H&L)Z\9Z-37,@92NcS]2D=I5_g<=#9=(D1R(6_5=
VGX.FUE1/d4gR5U.H+59Y(N@P.HcY\W?=4e9AH[O;.>&#f?ZEP-#fPf;U@Z+&/Jg
Q<QVaFPgA3#NFYE.WGGa6[AEGZ?40B7J4J,GM<5P?P-,R);c;W0gEC,/KcaQ)X??
?1+>[ebD8^.BKeV5RYMQc=+B9c3I7b9/X8>Y^GWIYQWYL/M6)\,eHP;-18U]M9I.
5F>f-=6&PTE-YS-M5??6#\#g<]UMD]a.b)<SHM@]ZHg:0T@RbcM&KOEA@\[+P,&P
GCP\4aFA8feZ7W<#B+:&U0g3aZY;/&5LB7//+A,H(T]?/cW8G6CK<DDT[[)HM@YE
[g@>G?HNU;D(\0e3,OA<\(-95[90A7-<]51&DeFV64eT2f9FPA(@PE)K4>Gfaa/Y
NAF(OUE_Y(62=?g;bQ#-#BGbc[0I<0Hd:$
`endprotected


`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV
