//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_EXIT_TIMER_SV
`define GUARD_SVT_EXIT_TIMER_SV

//svt_vipdk_exclude
`ifndef SVT_VMM_TECHNOLOGY
  typedef class svt_voter;
`endif

//svt_vipdk_end_exclude
// =============================================================================
/**
 * This class is provides a timer which also acts as a consensus voter which
 * can force simulation exit when the timer value is reached.
 */
class svt_exit_timer extends svt_timer;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /**
   * Voter class registered with the consensus class that is passed into the
   * constructor.
   */
//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  local vmm_voter voter;
//svt_vipdk_exclude
`else
  local svt_voter voter;
`endif
//svt_vipdk_end_exclude

  /**
   * Name associated with the timeout value. Used in message display.
   */
  local string timeout_name = "";

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param timeout_name The name associated with the timeout value used with this timer.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param voter Voter which the 'exit' is indicated to.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(string suite_name, string inst, string timeout_name, svt_err_check check = null, vmm_voter voter, vmm_log log = null);
//svt_vipdk_exclude
`else
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param timeout_name The name associated with the timeout value used with this timer.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param voter Voter which the 'exit' is indicated to.
   * @param reporter An component through which messages are routed
   */
  extern function new(string suite_name, string inst, string timeout_name, svt_err_check check = null, svt_voter voter, `SVT_XVM(report_object) reporter = null);
`endif
//svt_vipdk_end_exclude

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. If timer is
   * already active and allow_restart is 1 then the positive_fuse_value and
   * zero_is_infinite fields are used to update the state of the timer and then a
   * restart is initiated. If timer is already active and allow_restart is 0 then a
   * warning is generated and the timer is not restarted.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   * @param zero_is_infinite Indicates whether a positive_fuse_value of zero should
   * be interpreted as an immediate (0) or infinite (1) timeout request.
   * @param allow_restart When set to 1, allow a restart if the timer is already active.
   */
  extern virtual function void start_timer(real positive_fuse_value, string reason = "", bit zero_is_infinite = 1, bit allow_restart = 0);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
HZ/b(?/<dTf[[\ZFbM_Z,CCg[_Fb__\,,81L;.JIEJFaAdYN\8-d5(/0Y<UfM./A
M0>5X<DZg=[L0./FQ(/R0BX?HSe-N:-JG_e]/2ffDT>K8O#B(Xd6=5(Eb#G+3PN9
;Mf)S@df(C?da0P(RaN)=&(d7fCZS0/B3)BCKW@HJGK4DQ6bbDXbR]a)3=W?2WD7
CX/c:U+aWPBAe;fEL^]eB[Z=daTOW3G2BSAF/[\_Z]952/]6S,_-fEF=?Z:SKCCF
J[PLN,,74Wf^=;??[>=[H2VV.,XQH#6&&;aO]JQL->_F]>2;6+gbBV_=;\9]7JY_
W_I=;,bc<^TD6DENOU(T8?^]PQI1PST24+[FR_\2KC;DCZ)FMS-4A>0BWL@,I&?.
8\-VQ;N)gcJOGdSA/2V2\9>THX9??/.JQ9[;H<R6#/<#COX>,R4,L?@)=0RdXQ,V
ZZ\g>FeVMC\dgCMC9(@9Z>JdX8E\(J&.A=__Y,<?:YC_88-G[WO)V,KYd:V@Z5G@
BBL^.0W>TdDBUH[F]ZG=\4VUV^/>/>6PXdMCTf2-N2G>-e(4=<MTa94GR^]f&I8^
25TF3D^494\>16IZ<XJPWe=Ya-,J;P;WUL)AHM@KbKdF(2\79DGLB4?-VHR,LX1[
KF]\<1FMaE;[FR+[K,8628+5=#W1^)[HUG)4N4WG6M4HX:4]0(/YXgE#NN\@+6<0
Ug3L9LM7Jb:M@gU<TUZCGD5<5a/[431Q_8^07O_?PNM2/MT=-1FH>Pe_U:Z/aKYV
<7cV=S:QOHfLC@OI:T:-&<OfYB.)]GZ2P[3UYc^fSS5R_,/g0W/PAcE/D:+GX]+F
-LeHEXDS..GGA=F,CM]O@_TU6c)DbD&(ddNY4]DGLYQZ#,A+M.#Nf)S+3\N-T6I-
f@b>IcI?,6WgAB1_JdRfg/.KRN1ePEDg)MeIXb_6F8E>:7CB.UO&PZ;f<b1\C:E.
aNP3P7O=&gHJEDC<bR+\US9c>=ZFZ-.2e-8fL-UN-B5CI<3CA),Q,>b)F+>22#:c
ZD4?OfCXFd_(V?-b=&+9B_-Q;YT,QQc/.PAN-XS[N]H.GZ1BFYO+T6KN?Ff<@F0Y
7KDe=2dA_L=/)86:MKKXGULJH-V5&S.1Q7G+C.,Fb\+SY>L1\YT<_\QIC:;[LOd@
]BLP<9f/8PCJ3SXX,5FWW19M\<&dega[3)WNQ1:c1B5=BE)J8^QD6dJRMS^7J^;0
0e:[FRag26&:5HV45HOaK[\@Q^GHY9,-9G8&-U4_V[)L:KEZIQ-K#)RD3A,@<23A
T;cJN/5gR&L9PRZZKA.PD1^8DB(Y4#_S0/8\R[_PHZ3GV/P4F??G?@f4521[,/<E
QU_#;d2VY<(O\\gd.R+TU.5/+KEfBJ/-2E<;2)9O55G[bKVQUJ=6,e+C,[b8bX=I
+F;]1\8?53]IgKNYM(IE_FTVJg2[K?.L?T5W3K0[>OF\4ITCXS>6UQ(@1@aFPS^.
GLST]4G:E1U^K@]4UIHPO2_7OLE:,AB).^)_?<HS-BPIOE/HGB>6Q_9L^Y7C1A.4
bD.BY_6UAS+CZ;0KQD@XXM0dSPHgDQ@Va>_&U6S0COFPNL/EdO:Y=NIF^QDPLGbZ
f0(d7XK9PW7_GSEHW2;5IK;7SKP:OMI_?/S3L8[Y9;F,DYP6M+Md&GYF845R/XO@
7.3(&#3a+M&QFJ##)XgZS8-J1JY^f0bP)e8>8K17cGeHIR-?a,(+4)egEI50.)M9
4:e91b:J\;D3ZV22faM=&PK]Tba5;W_T4K0[c2JYUb/XPec0@]E.a_^]RH9F>-aR
6E8HP]I\NG16:[V8F3KgW@SeVPF81N7gV+QfKC:f.D[D4cB8;W3SFYX+O._F^V=7
G.]7:U?+-?0;6acTA8TdX.,D>2aG\GA@P)cS6H<J#+6#;GHF.MTA[X>DJ.(8Pf73
U,(dAV?=A(XBf<Q/XA.b[\XgO:S/7IMTI/9OLOMfV=^SZE<>1Z?23DFFW(XLMUa)
3Ae(>9C7d#CBf=e[Y600+W]=@P.cS;f@IRDCU?4HK^;a.Z6D9V;[R#3([^a,c)f-
gD/MFa.U7.KM+Y.;5/S-b>2IB<A7fS5MKV3E2_[<C;#[a:IZf-d&bgAPG(:?fZA.
A4O^4X<:@bAVC0^N5V]ba0+#26Oa4=/H\O6>:+V<CVSB?@I=?CcdZ42-=1,aG[eV
]K5W(NU^=__Z?,(T(-eDVggP0)Q;RFY0(JH^?<502PCE8Q\522f=a9bSX,\-[Scf
[)\,-=5I>?dPVX5#eN>-+6ZGC?Q-K=.>FD-aWQNad\Q3AVJ1G2-CPIN\ebD41E\H
cNa=d\+EBN;P0/NdT66FIQIHJ1D,V0,Sd3Ed&Y2OG)eVcN&EYgCC<&[S?02U(KBG
Yc58=J&SCcbG#B@GYPL[R8c-\JfT8WE,V)eT&><&SG5@6R0XdNWEV1XRUQI^Y4ZJ
:@\67[+9RV:S7WK5?7]B5]@.G-(^b34=2IUJ?HTcS8ZE/O9c[+[LeLdH+#(?>3^)
016-U^XNfa8#F\7LC;Y&O:I<9=eJ)[&d^KNF5ae)086]S?PILL<?QB.BV<H;D=Ac
Z/Y-V>fR-?cA;3f_cQgKSE<f^\]VC:BJ8fIP0Z,WMU_78-,5VA\F/RCS^B=aQ2>5
K7]d4^[RT]8,a:PXb)U[f558BFBWaZO9G:@P3Z.Ac=,Pd[6T(-6&<5AXd\QS.0\-
G.]T/R&?KNfePZ/Y:-TOd?,M1Xa<<L@\Of^AY92)&AFUD_V[dY#,/])H5EV7)DXI
G:R6,X)c\5A6-C2@&?d55;5+2S@8X+;W7P7I^FALT8>Aa7<<dHK,8[;8&2YC-e:E
1MPDKM=?L+6G3aVC;V2/b;OAeZT^LS3MW9f0A0DAV(\17]^?-,[0>J+XIdCDICg\
;?Q>#=Q\2&HbEG1WbUXe=PP3:]5+#R@624L_)]0[F81K1C,gY([E\8E@gGY7cBa0
f5(-Vg,-;9=?:H4Wfa/McW[HaIb-,5>KW&b4EbAK:-3(eXHg57HNI_HGQ;H5M[#I
])@>cE6NQ9NO7=(/B9G;.#3J34ID4;V7dYeD)>PB:XGULgNg&3RW[-=fJ>_&2=52
^>9_CE\^+eg]A2-A<(AD[>NBT\ZF)/:f7XD23gcZ-J(0+6/L9Wg+?S8P0?#5QTXD
_?.80/X<&9ECg]S:I.A@c7\9fd#]8P:=?b-A2b3ULGP]IVY1/1JU<[LK6DeJ5-P@
bEVLcUgaNV@Jg3YAOYZ1NQ]<5-)QAZV4V<3@D3<+e[#]S-JO.<2I+MRMJ6:<:9(<
3LLdG0KTE>9/8CICG8B18VTL>g?H/:f+EX;S=HB7E01PS8@Y-c&Y<c+X6]?deC.<
4NT[?8_E[OENMR,7C,(3b\&T.=)]E;]WB:C631J=O)/bP:8=HW5RaKD>7\X&[77)
]O.2]8S>Hf&KRJZ]KbRHbI[FP?M:M\5U9d6ZEB@9_B1^@<bO\ecW&Re-53&+;9[8
+PPF:Z5c=JCeO8L5AUe5H8DV5g_.0K.)8LdA0#.RIdB5,3#)Q1OcGAQ[#L48,K@<
60M_4Q81,(EZ:IQ,LVO7;NJ&N[WX[725Ya@La8&]de>#O&g\^X(N/E2b9X6]6=L(
&GZ>>TdT_L<#<4AJI&A4Q1J2AcNaAaJ<e=dTKT57Gd^O_;GS(R5+HU/E64R/de9/
=O<@0\6407e#;XAWTe(f,<DPJ.bG&A\Q7FF(H?EbV_THD?+S7S=1+&O><40\WZb_
S0f<SY0[/AGc&7.O_==7L40E)2ad6bI81;#7YIB8Qf?FRLN+W=f9f6:SU;T_<f0c
-C1KQ8e@g,G@:da#5\;[KcXAf=\(=S25g]&1IH2MQJ(FE$
`endprotected


`endif // GUARD_SVT_EXIT_TIMER_SV
