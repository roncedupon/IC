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

`ifndef GUARD_SVT_BROADCAST_SV
`define GUARD_SVT_BROADCAST_SV

`ifdef SVT_VMM_TECHNOLOGY

// Use vmm_broadcast for the basic broadcast definition
`define SVT_BROADCAST_BASE_TYPE vmm_broadcast

`else

//svt_vcs_lic_vip_protect
`protected
^GU=1EC8ONS:<;4?fKU#RfY?&8]0#-:Sa03[H0Z[L-Ub&B^QQfc#1(#ES.C17gAb
C=^M2T#YH<G.[J\>9STZ66a)(ESBZ+1BO0J-3&?R?3(4NMFBNbB=>/O4MJb2=MJ2
8cW[PJX#+(/OJ?WRdK4_XcB0NB^(J_21,bGAA1QMWG&&XU,eG1H;O.fS04fE1g_a
#_QKQZOW>^KY9&@J@6HKTUO645_,:?K\JHg_Ng9[-2JAYI1(OLI?BMa?F2Y4F+IS
8L=@+PDefG2DRcSS^5/9d3O65$
`endprotected


/** @cond PRIVATE */

/**
 * This code is based on the vmm_broadcast implementations provided with VCS 2010.06-SP1
 */

/** If using UVM technology then create equivalent broadcast functionality, but assuming sequence_items */
`define SVT_BROADCAST_BASE_TYPE svt_broadcast

/**
 * Broadcast implementation used to provide a basic broadcast capability in UVM.
 */
class svt_broadcast extends svt_xactor;
  
   typedef enum {AFAP = 1,
                 ALAP = 2
                 } bcast_mode_e;

//svt_vcs_lic_vip_protect
`protected
CV0147FZSPN4EbefHT&:IP&+HTGQ1g6I)D<deM9>aG@edLB+(WLb3(,F)AXHOR@H
QB-dX);QQD;E>,DXTU_;L./00K\Qdd-6Y-2eFD]FU]RDZ^WfBJ(BSeP=_(E55K,d
(^KY@^bS(WGC+#aS63U,D(N,-b^gY+B\cF;e.)9T>8_:.HM[_U/WN0Z4<#CD6\,X
8B:J?2I^VWVC<.A88OT#MD;637TUQZ\E<+bf)=:=Zbe:S00bEQ@;H;.\.6TVII(H
>cKE=Y9/[[H^Se^bGHUdH><.F(e4OO@]_2A[V[eKf:MQP]0Y\1(4\ZQ?+ZHcD+/O
EKLLVT)5e0^J?H6_DgYR=LSHW43(+(f^Eg1S_^C57DJQ8KI0F0W=RdQ>,dCC_>5;
#VX]D5RM5T=Ja&O0^87)b4]3B4+<<A84AL-(3IZ;F[SCS@cS:429R)Q>M$
`endprotected


   extern function new(string      suite_name,
                       string      name,
                       `SVT_XVM(component) parent = null,
                       svt_channel source,
                       bit         use_references = 1,
                       int         mode           = AFAP
                       );

   extern virtual function int get_n_out_chans();

   extern virtual task broadcast_mode(bcast_mode_e mode);
   extern virtual function int new_output(svt_channel channel,
                                          logic use_references = 1'bx);
   extern function void delete_out_chans();
   extern virtual function void bcast_on(int unsigned output_id);
   extern virtual function void bcast_off(int unsigned output_id);
   extern virtual protected function bit add_to_output(int unsigned decision_id,
                                                       int unsigned output_id,
                                                       svt_channel       channel,
                                                       `SVT_TRANSACTION_TYPE    obj);
   extern virtual function void reset_xactor(svt_xactor::reset_e rst_typ = SOFT_RST);
   extern protected virtual task main();

//svt_vcs_lic_vip_protect
`protected
cQWMIeP->3=H]Z&Y:0I?2/VC>ZeM8<@QSYX@V9AWDY(0Vf=>FC:A6(&<H43]1L8K
9+f;dQg9?.<[Iad/H<0/O[ESR>@AA5<2WKL41ea(7ML<ef#c\1>M&I>T(RcV9JN]
c=W-0@QC&]L6JOOd136B9W8W<b/;F/FC&Eg-K>RNC;G+=KZVM:\O2G<09=XH.Bd5
;XB.2H.gd=R;Y[C9ACJOSQ<^:39[V]Q_7dA)<>+<4&T]g6L2SDJa;G6RMH?DV,4g
(9IaWHC1f)Sg1#_WQ-MESW<^5$
`endprotected


   extern virtual task bcast_to_output(int channel_id,
                                       int on_off);
//svt_vcs_lic_vip_protect
`protected
YHK)AL:#B2XNYK@gQ;1,f.#FUd\VJ68XHIDbc=g2V_BRT.2>a0>?/(7)7YI1C]P)
5]BL:dG1HMb;+D;)f#4G[)-UePg@KT&:<CU,,D<S)+K+Q;W)HS9QQ&7:.HKOUgQ/
#be,QD>e_.JF].22@9X6dc)L=P6_?X>7(gbb;#PF4a-g/DI/BK)/:W^^#Q-fR7H@
&U]7.c/dR&J>1TYA=<&7,)4V90;Jc.FbK/0.>Z>AD&3WLFG[9CSAUd)Qf4ZIe^<=
U7g&]G0S@G^/&UH^Xb6K<>#F8PECeVZ;=$
`endprotected

endclass : svt_broadcast

`protected
@RFXBaYUM-PG\RPF&\HB))^bWJ+L<4][P4N=@>CdR?9IdJ&L];/&.)-5L4aT-ObJ
,RM[6\JP)2>9bIJB-;<FJW:De5FW5N@4>573bJF)Ke3P4Bd.K,B-)K-/;B0]2@OW
6I[;\ZRdTZI?O8L(=QZ5?>;W\?2DBP?;5.g./S5#[:@6bSN:E[CDWB:Yc=6Ld-ZG
b[_f&=^<e0H:18F4b?YV:>HMdGJBPQXPF><+AI<cf_D=_ec#&55VXFTB<J8.>4+@
I^5gDEUd^)5G)c6e_)[;L99<OR4&H\HfLf9&?<d-WfF=Z,I-\><6CY]G==OV0)AP
A+N\22(^312A_a3@8WPF0;5-.B7WT8#,;7N\5HVPLGE]HH.H9NQbBe/9\cJM(23C
/_g_cQ\ZQNJ8@O@_EVaB8BLK^MBRaQD@A(K,e0DO35>?a,GT)K#6Dc3N0L_<KQNA
J#=81L^X3+)->\Q5C+LP54(79+RC++QgOSRC0\U6N5<YAXedN[ddV:A5Q48.TQB;
T;JQ>IRRe9/b?FXSOHZ=4-Q>F.F^DaFQ4&3cRJMU__30M.ZB[^7WLM7_WS</1IL7
^OCHfQMSb1M?JaHg[G#dfKR/S_?+86^\_(5XBB.W5V657@V=;gV@]SRYGBCF2>;&
SB6G5U&M)C#[>FIJW,+aV@d9<E]dgV)7[MK>&Ob\cI=;O2-.OT3EGAN8a+A02+B-
JfYE7bMGc]P?7>Q9Zg4YL4BIKT-4]>11V)9HKc\2&5.PU.0ZSLVf:U&O4)6CP(<(
/-ZN5#OBNK,#(^f@DIZ\ICZ9NL/4G00>=J.LG;9I&\?c7KG66VE;Z0C^5^<@[M\d
c;YXaT5;]92c7HAL\2HV^VH=Oe\L28c+Jg.@3+CU^2)X4K=a1<VHAaJ3)\8B/V?=
T#WE<R1)>F0C[L6BQ-[,bP(7)QMV.a>9H[_A0N,UY]#(eE]OAV)WF,aF4Zc+g.6L
5]8)<>aac2K&<8D17cX2ec/8O.0-O7O5H1N.-3dG)f?G.,G92OD3-AQOPXL5:-Y3
)IZPT9UV1Z=,7-H:fZ4[TTI,3>M1F9Q/QKO]X==?f,Kd;E7bL=VU_/1d93&W0=44
)bXN7#8&YLa1=aV/DfWP=L5ZM78SU>/OgXPEcHDN/:gM^?Hf/fN=O\R#)N/Q9Q@\
Q)++=NG_eN]6TRI?7UZ<?H^gW@GBKW?_1b=VdI.0(H=PBIV#L3\\L+ZUPA47OAW_
RE=[E8720.WETCW(-4-^E=Dde<,BDeH(DeQ_4LGSdEA;JOQE5WA,>KU,BP/A/O/0
]4NfJ\80EX<PFD@b[3cE[ME[8N0+<64gg:eIAK^,NVI].RM:@RVD5a(=QJ=2)2d;
:6,5Pe4DX6@Q<K?b4S\_#_G7T.EWZAY0F^IH(:@9@SSOGcU/F<O9gE//4LYTE0-A
+CfK4WUdbMD2CIN?]aeT@2,&JNb9,:9[RcT>Y5?<#L\E&N\=5(QF,Ob9K7>NGAYL
6\Va.L4T52SC7H=7Y74UWF7\Y>.(<7&)Hg#1>]b70;-ga]:]_M=:b0b5W:9;^R&@
YQE](2,CIg0:UH(;8KRd/SSMH3^RH6=:EGS:HGJe4(gE#7,?25EUUL?S>UQRZcE]
-_7OeD]5C]c?Da2A=:T)@V/b3Xc=C&B2F5HV)(2(Z_V5_XUcGc1+_X52M^@^?RSN
4;aO=D0Z@39WFHGMSUT^@594)D:6J3^L#b_?3f/B86@4Z2ACg(baRcHU^7GAgHa+
;&:b]&&H&S?3W7GY4MW+U7XW&_^>cL;b)C-+^3-Q41UU=H#78NH,C^H##Sf\Gd[d
C]Q/?BW51F)GCWB)2g&6L/419UYQRaGe#C@?L9-\=C5;S=FLL]1_#U9>K?bgGCAF
a3/5U:5E<gYANdV9cWS:B]Rd^SeaL^[b5Ud>/Z>(GG<)EEH69L]/BQX^4K@DeO:d
dI?;8H5SbKU2[@2N(CRK1DI#G?CRE&H;daV.dLTB:C_J=<R5c75SFG:Q8OBI(33H
<)L#=K7C,Z\BJQY,7;LN?KgAA186Db?fCfZ01GL)ZN,BGX#A6bC__EC7,4+cG01W
.E=NSS@W=;BJgU1P=.-40OCP^UV4]5?#.80RF.>.C)KYaZ.J1UP4G7>2OAD7_-AJ
WcWQA3-#.B3bS-8IB.IWUCNI;4036V?>J,R;b_+YMP#UC1V,)L:D42f_^bR/>TT.
=]0=A&;HL\:61:4<O=QOL1V5b^#H;aCH+e>LM&<+&G1NC[1D]&K+/)8&3#BX<-QM
45)DTP(>UO?GcPMOV)Gc<0ecZ^.Y3OdDF6d#2HY.8[O0CgFO-)W#=BL_Z)VGRBU^
DgcW^TM#[#.P&@<d;F<?1S&W.1d&?)cW=-,4g_edeX6C?W.T4-\U01@G+D:[FNXY
J\<eXV?bGV_J,3?JLfM<Ef#(OWe2U#=:E35O01Qd7BL:/SefF+/]&?/@1g8.G#4B
-&X9#Z,Jf+]IA3D8Oa9-_NQ)8721L\.0YcQ6LgZ(LJeL-9D<E4U&>B<BE;YU)S@D
NYZe@4J+G92IQWHN,QY,U[0^<W_EMS@K2(;I7T2RH#5I1]_Y=&X(M0+WP(B.>?Qf
8X<?7]LQ#L,bPYYX,P&-J2LC[c5<VP>/)T::Ec.4&J+LaP\),:3X-Y4LU3ZU+6+9
b#;C@YX0)RM#Y5-:G82<24IF,7?J&=ac)]b/-BK5UKK]c^?[@AHX9KG6P(4;ec>P
(YRB/6/7@LZN#[E(2[:)8[AFQNXeXf=CG=QN1Z.Q[X?f-;#=P2?YD1)_(-DIcM2E
GKZg,.fSEA?ZML7>NS#fS)0e+:dd5R4f<)cD,4<#YXK4&V>8U&_BY3B@K,1AUDSZ
IfZH,SZHDbO@URCW>8NQ1Q9ALe_fK4Me8Qc+BX&H^=X3ZXU#KS<I+E,cAWLdYY\V
WK(TK&N4Y?8c6QSP2&@KGQLP7Z?PAK]WKHZ4cCDff+J8DIPO[HW@?>:1LU3-JL]2
dX.TB(fVeWbZX0eH&dcSCc)GFZ-Y_KOKJ9FQKdDDM5adeF6[OODY/65F39CaBP/B
V#9D>?5>8PI_74.\X=#_+5L+:[)CE_DcJW,QMXbN@X&IMCLc(.-;e,d5f^g>(?b_
C0MM84&\@N(_0$
`endprotected


//svt_vcs_lic_vip_protect
`protected
H6694c;3SU&(?20CL.F0PNQ[0##7AEO<aQ[5->A.E#Y;.+9XYYD#4(c&A:)HZAP0
[01e+;\]\SSK4>.<XcL0W)CI/QXZRD_YV-DB9<PUNbDOW]-b/VaZ;+Ke#@I9=@?8
M[,S.V/Va](2-FS=C:dU)dG_gWg^723JV?0U[Q#=eYfV+ZFI^#gM0VGT<EU)cP7(
ZY,&491;2BGYF5dbS<,F4+=T(Q^I/3Q@2(5X?(GVR8U=:V8SE:MgN=814^=cXVeC
(T\^.ZV7H3SHe-VPH4,B.MMA,[C8U(GG1L+V?D[K09&A/EKV(DCVY)H=/XKF&fb\
D-fWb^eY7^b3_K8Q4-+gM)gVND)B;N\a_d/N#cDVH8V.cO,b_SCf#]GJZX+3:XS?
S,@\XI#abSEMDCbV;(g+@O678Y>fBED)e2,=LJJ[HP/Qf&I>?[aB8e/.)@-+?37B
a,,^Qa7WfWGZB4G,Na2]<WIf60NL49F)OB;0EK7RR8FB-=)b<O(:d8GME/e4,9SF
VTeE1>c2D[WG=eGU8],1;)[<-aRFdABE4a,WHK;Y9A7P<cSD)07NOJ_R&A=Q(Z.=
6ANZF?8S_LN&PeF).D^/O-=^,\fM15=RNUg,;7)XOZ^XY0X^84,UR(G(M+K)/,PV
<7OSdVH\8XT^&?.&Z1T@^X]6JLCYR5,\Pd>(<-7E\@=cWCL(Cg5#?cN_b\Cf/2HO
?/D?D&TI)?]IJ^.3Z=NA8JP<D)O_/f__)<)b?IUf]Ge#KB(P;F2YBW8.QJc_OSQ-
A80KZEg1b9TZTYV0P30\/CEe8#T<ISQbA\G@HDJd(eL/e]5Oed(94E_FFR1HAU^T
ZNT/@.QBW;b],^7?_#Wb>Q]G/)N][YM,?S,;e4LHE&A2<D&@<^+XT/CJP;3\U^.T
NM\N;CU^IIFI4?Vf=Y331\V)M:/adbT]e1OGGd<VLg=48&^EK9YW-SfPV/a;K=MB
F(S8XPY&gO5Dc_)#/CX#M=.C?M5V\BAZdA./b@93BF@3E(^gU&g&.[AaN-EJX6K1
WIZ_:8ED;]QDYdLSZ#ADOH#IBTRVS).](RD;]g<b[7f7^G@PQ(V/f^QJ)-DfFd)-
6d9UT>PR\ODTe1RTJJ:^)\6/\,gD)IaK#0b0]/EC^5:U[1O42+V1>24YWYBE?&cA
WGaNTQU3;4\.5=6I?R-1@6;A<06HJNK/e2JKbT>?X8a=b^=1]K(/,9^;/KA3:G1J
<Y)9d8^JZ8OI/.W5Fa>^EPcf1-Ue_SDT<$
`endprotected


`protected
XR(R:/XGFL7B3baZQ(YT=I5PPP,C>Jb=\K4?b&Leb2V[)W5GP^WR6)X]]fXN\Q8[
D:?9S),@L^@J+0Z#2YP=W2gagF7H<W<01b)MF;OMVgIN.=&7MfYVcGTRPa2(UIV#
60@bO0OE]LV#Ng@+F).23e.^(5JN<9a>dTG<NBLQ[;0g3<YS/:Y(/Xgf/W]LgGX[
d^HJ,FEG.aSVMRa1e#I9BG^.OD4ETdEF_MQbZ0B-RHN0b?4N26bf0WGM]b2/M?U\
YXHW65;b=-]:CVIWD3#WHab)Eb\O[T4?=FBbJcUD/N,eB5R=>.7JO(^AfIN[c&@_
aLU?<UNWF=#IJaO&SV[WN.6A)cIFHcKFP8RURQBgD5E_9OI-71Z()RMO)Rg,c=QZ
TR8>=<6=fbc,_KOg5PRHUbEb>Q<KM0]HE5ZEeL\A25b<=+Y9gf^FLMQOWXRf\]OW
aH4TSN0)bX<gZY=<1+15J&Q]JH8[N9R(L^>C;T/^)5b8BX)^<]e3VKM\/P@ZPaXA
_Q2Z/7dZI52R6cU6^USXZ#N2EI4O-_?Rg::G[[I<G;XcO8ASS=BX0RgBb3+#>=W/
C,<=@1]##^a(@\@@558\R(6VL8PUXF\MYGZKJE7KK4T4QV@X]G6YFVdd#?6Zc0HS
_HH#^d17\S;:#X]2I458[HC7eT5YNJ4YJ\4&.@X#MX6:G@E0^PKB(_JG[_^fP;,(
9bV].NPg2;0M>CWZ(\C>GcJJ[N)&O-OES^,ZS-,B,G,CTDJ9#SVR1FcNU=)B=adI
4gN;;J>?R:Zg_KWd1&P^Q5+62&a<D[Yf8ZIIO+MCY#LQ\@\HSQ[,fR]5YOL0K.+:
(L[Nc83,Z[@>URA&WUD0==(+6dB19B4B)9:3\3Z22S]1NX0e?eU@Ze:V^DAO^N\_
W,ZeTL2PRY)+Hd[BPJ+6[D0&[G\4E2O&#WcF4&-+X77[<^82gS)gBEJ5H&XLOUU]
P#8)B;ZNdA1>59N>51JF8Zd[RU3BU+)[>NS,X98F#bT_OO=H&\N]7VPX,RG)BF,W
2EdUT-P0A/?XJ39Z-BS)147Y@8;NQM.5;>+HN>93/#&F3(68XW(#GCP<68XbMQOF
Z2(].A#>^N.1.W/I:UH/ORdL+UHP8S)Qg]@,d_F#ef0A2>aWL^^B\<PAObCGX=[)
a(7B31T9]?TdS0Q2N_@P@VMA5^,.UC&0Pf24M<8Z3J/C7b,V\de83#>P?J.4_<4/
9)95O1P3??JT]R/RJc8NS>,If7J)+(XC6+d@S5]Z6BHB\Q7ZPS^;SDJH0B24_-5e
;b.f,^[dS?5T0$
`endprotected


//svt_vcs_lic_vip_protect
`protected
XZ1/;J&Ae:Vb6?gE]<15DX;>?/.3F+8c>#6S;E#bL8K<I_-<#1Z42(4/74G8<@8K
GK-c<@-50F;K?PVD\.X\Jb?@OH0R<aMV71J<U\2^>[gZR7F/:TNUY2^3#.\,>.E)
>_9@TC9Z)E7_[FE0G>eVMS)b:<?S8G6]:(ED7^VPA)gf]DFRbFR3DI_,+7#X,VSP
gHYQ=R^DJD-ZcaSd4dfU([WTH0_.[68#[#8VLKX;KHQ/P4dE&b@JB?-?K>G^0B^I
WfG<=BVO9a40HAGEHVZ:E,55cM_]20V02771a26E,CZW50X_C#99[L\BTCcCE,G.
9G.W^J&D+;(HeLC5_]9(7VYf[R>38>+AGd#<=ARFZ/VDCGT--[V01\[=[Q=c@ZcJ
DA7Z0DMGGbW_(/,e6bdJb\W&N:[bf-BCOR&_)f,\d#ZPV7e=ZMAG0>8/7@IRMNIF
-L,ZD7W&3TCc@Ud2O_^Z&JVC_X:N;b;d#7Ca+Y;.&90FS:/<CG[\N=9?[Oc./?gC
5Y&X#>;TD/I5IHa523<PgQ1)@17S;]=A),LU/1a,a@IL])D@G5L+)3?b-)[LX))2
UE<[3[LN[?/Jaca)Tb5E5KW.PBFV;01.L>;T3T?D4e(I_aHV23)05[NNec7?2M=^
YKHPEW?f)@bbU3PIR#C.I2QJ]VCL<+=;8:+7e][Wb1fPHDM&&RH[6?cFH;ES606;
4V9AcVT_K-)#3ZHB1bL5L^4K1J)BNe#gBS&C/>BaaGI#^,/D\@@?RY^d(D-((ML_
VVJ;3J\.ef,K9_\?T-O6bbW)V4DU_:XYMa2YaK-K#.C[.M._G=,8#BPIM1A45P/)
H<B/&GLdDIfaC4U7[IJN>E[L;LETOKT4QR,;6E^;[YafOET^06OB_65\d_;da&&R
+a26SAPa_bRFHG(:eM59g3H4DT+@1GZOcWgbP0J/e)1G8>[aVS2H@_;2H0]ad5;;
fW]Q2QZ4M8)89S,-f])@8>SLCba;8bIe-:BG2GOXXU)cg)M?RCGb0)b9K/+F4/.]
>G3[bVV<A-RN0(fbRZU>f4@fW8HadZN-)E4[;+DI;W.cJOXO:HQ,>7F48W3G3.G)
QYX_EN#I<GY&(>KVED4)&=7=bO_edT;@?1FJ[DS#LW=TE:OaOBD6G5#gL]>7AU<]
JP,W:/=Ha;g?)Z@8C;SSR61^aCODATIGGIZT;e/O.;b<D62U:(+efeE6;:FNT?49
M.-??Sa-?>TX8\79e]HCF4A1g^,F.gQdJg<[#c1W4F.H.EU?G1g15W@::H>PN#5[
A+?RDU60S>:U.Q#RRM#,Kbc@g.X6=)?dMUHb5bde?E>+#@[^.J62=:J<0-[0BF5G
]UKON&M+\Y0H0UVPDUJ@YHMBEAV.WL4<8__-.aU]+\+[@f<<VLJNa.5>U7ea/[+N
P9&=X9H#LX&gBP+PJ./Y+dY/R2+,EE3.2CG(W.&]46]B5#XY8X05_NF(10?R[\[(
<>L,-OZL:,W:[GLQ?]PH#_#,7RUU++Q7-?@a>C.+Z[^EM/YT/b]Jf?/3@],S/YH8
FL:cXb=\-/G.8]Fa0e+7dc;[=\I0VK?OFYb?aN9,0+:^^-IU=,R[]()bES<9@IR5
6]ZT4c0HL22L6DgP/#e,B^WBQG)GK6A5bZ<6?)YYJC]C]@Z@K06Q&LJS(M1F=&K@
?OXM-:)VEe9-(O1eEUdGP?^/WWKZH2.A:bOVAWQ2F@>&H?1cUN&:NCH<HBB-;+;[
e9Y))7OFf>1AUMU8H-X..T6RKCP-eJCF<aOgVdHcLF&Bd7C#<NU/DP(<0gMFC3-9
4Bfg8W^-f<)7QTEZ)9aSO+#_[=cU^=;?aBYGJ>/W-RE)dS.:67gB;LJcB2I60fA1
.8+[ODFa^(Xc/<Tg12Q59[3-8c:a5U5+f>7<SN&c5<9L(M<INMa<4-:R-W=)MSX1
gXEO\^C?QXe&;BC3]],7RYI+.V4.Ye4fH\gAZ879eU#(6B.OeLIRK+g)SOV/]cI/
^)T=>b9O;5ZaZLGF@;-)RWOWY_(X79]ZJ23F@Wa-]bHC[2TP^#Y?cFB?OXVSW)N+
F3YH[ZPX8e26,c5M97&R.G:#_RF<V<?E7(5A^F98<4BXKdXbZ12Ua-Q>-CDO8?[f
Bf#Y&G\G&XWB#J)G/5/cDSKQ<egP,bRR6MZNR9)f,^YRe)5d(=+GF>7eFI25LfE>
\7D5IX@NB^4]NOA=Y0/SU3a0-=HSL5I8).bSbX-JABVA-:)N5FEQ+#C0<Z2D4BQE
XdCAeD&ea@baJe6YGJ_NONL#QLAE1XN724H&+dTRF(;\21;^U&]CXZ-\78?g6^RV
D:=8.S@-6#7cOQ6++(O,ObM=;PS#0aIE_FXfNDV(SOfCYV88-C^;)-<d<V;KYHLe
5;X4Z88&)?,XW&9N^+AM?#<e3F1?Jggd5E^WGZF\?dc3aK-U5Y=SfIX,VX#,AF_e
C^dI:?1Y[K28-\a7#cP[KZNF7NRgP<ccB2VJ.7@--,6C]c-fgUN_L#@X8L<JcO&/
VdM&D9;SYZ_8KK#0d#+\\<?)f@=(D>1U^S6C&Yg)J.X]==(5P?3-&DB05F77,b^0
d__D>>[gU\?&&?YP4^N8YASRg4VDb<4]8.<4a6#<]]>0DZ(JF#J;/A3R(8F?:]aX
3Q;cdF.V__UZ3E8S7;9#^-f7e8g\\V&LGSKCY=(36_AM<39+]/L]3daaSEX/d(Kg
8CL#eT0W<KSA0ZEF[<c(N,Ye+LI/R1<IBBE+G6-dbKSIE3Jf7JFTG574#:>,^\<-
J^Y_\Q1MHD9eYgKV:#&BHCD<;;48bfLA@Z^.XJ-D(JKZX;87)QFK@=O5&]/7S140
;4K2\ABWI83T2K@A3Ng&8fa^=MB[+/<##[[ZU]b]VPb7,>PNS.Q-AV68K_@:<U5.
K-36U[W5e1L#VB)NH9gD^BLd527L]Bd^^.f\,PgC0@941gfB3V6-HD4b(TAD^V)2
3S8MNESH;YVWeb0Y1XQaXUe<619B&ATZHf8MgMO4A3)T>g>O[eR-S\Y,#_+HeI#b
J-T@NMNOWH^LAa+XdCY66GCb<J)7TD@-2Ia_1+GEK[M@C=](L]]V0[-&a=b1<?)#
+X.(_]09?ReM2CG(VfMVe5I0bWcF6VU>O8H,;Aa[afg.\:YGZD9E),57GV53dg\0
fE=MKWA2UG5-AJYEcO,be/e]7d5>dK>-N#=RO.W^2.>LCW]]C>O[f+aNaYcN<cdI
)2^^-CF+X_T>D(Xc>RGJVbc&2Pe)@f-[gP.GK\)3gFAbYF6QVP6/ZNW;>eMFc8DV
bKe/;L)8A=&ac6^P6Q]FR&\NL-@=]1)OPNO]J6&2d1?]BR[/eZ<S:5Ce6H(;,H#V
D-+2<39;UM63,1/FcOK6XbP-A(>7MK-d?RVI13;(XGV)G+VNP)F:\D1GL#+],KCB
Ub36<6a(bA5&N;V<,0<65b97Z>G]X&U\f(P#E61?eeQ0F&?^:Ua.Ie-;JQ6CB0/0
^/,O;[RE8aVVeP^70g2:e29-&V;(9-CLEV:1bN3])a9LZ5f(Q,L@FUZeKK(@GEDK
WXe6NGdN)7#Wd:^^fP@/BV;CSMB-dQd&V;NQ3>0QOE0-:A&XLVX7Cb;(/dRE5@Gc
VGA6H]X,+HCOKTMWH[<=&T>0VB25:MF].G,4,N5J)S^A@2XeJLBg;+IU_fZ3C^1G
907;OAb=>dY/H1a/,2e,OB(Ye>TGRFJ<0VE9S9Pd_N1@9P=UI^gc=RcT]CYGb1<^
731X):I,Q:\YWR6>J:V<SIE4dg?7C3GM#^1785SO)d9\\N@H<FVH-9U@](V67d2I
b3&I,7]4OIL,>(8Y.0C@gOc[7&a7EFT_VR3K;e-cWFYKJ?6J7+bd+7g);\;#<+)C
cf.98HASTOTgE88Z8bDSK.25N8(BHU0DY9FcV6dXQ(a)Z.aYHY#>K\QT_]aPR_R:
@b)#R.1B&F#N.)Y3R>));-O)I(]4UbL^_1XcO_<6F&YQA^EWR-D=ZC80CR(<@O^[
cRVHZXcYF&B[O2X2>M@fd2P@T.Yb6)<Td08LW)P<2g]=b>JCPWX30TUM#0.\8(@2
eV:_RNA=M1XYX&,<P/a2<^&A6dY];L<(ZE=-PJY\LdVHSF55^_FHRWa4S1O07/3^
P,F:V4@\+1UY0;#<e7@GdUFHBdDa^aZNEUC6eJ7B<@ZTVVNYDVN=&18@9X+[I8@=
)J=2B1b>\3/K5T&HU;(bY?+c&&HaaOZB79J#T<&I17Z3/L,-e/+f0Ga951AJFMUE
PcSF0K^gK52V[1D9C5W>07>(UXDfLSLcR]ae5+HO-bLf6TO1a(.7D[)QcQH&T;WE
9[eOCPaW-T[+O&>E?d#+R5V/ZWF(DgJ0C.b\0P59dRF@1,gNeTF#T^#X[Id0[5L1
J9=bWT7.?/8SN?WYHLJF-aU0dQT7T;I6F2[_2\(R//A=gB4Ta\:f+T[c0JI2gG33
VQG,09?\&HE+=3^[\&5,9&;9W^TDSS;=<3PReIDc@U\AI?-F_]^73KL3g+XH(OXA
X<PR=NK,(X:dML16GF^F)#bDJ@4eU@<g36I-^6--8VcH<\TZS;DA0C[5T,CcWHFT
\U_@U_:KNR.\2cH0J]1M^]>c=cG>3U@<Z7R,<eVa8^BE_][E<ZVB6Y])W(9=ZE1X
);D^@4,VWS]OZE^[U;MY>7ZBb3-?EgW<KEEX1aO66]4[#42Td&.P.Jc<2;38Y=P8
dDLG0R-d4AO-(TU[YLW-7+@Vg-WLRXL=PPK6X\:^AY@VBRbUW[MPCI[cXR1YY7dZ
&=@GALdQ(f&^J>2cR\8+Wg,8F4V8BKb;10)[4_H[17-7+Y(^8aa0M0QO&HX:PQ;2
X98SDYDD>1OEf):=A7D_YIf)L2NaABR\040;:IQ#1d=cad8WI2[Z[+#V6/\)J^W[
Z0E3O0XSc@8Hb-@2\E-[E^a&XEf>R.^1aGaI=_9MX_)GIDQOF)LGFX,<2f[LdH<Q
gcKT,4FGTC\0>.R9W3[cGSM1;Q5F#U]&E&8D3#-4]@AMCN>07a19W9_f;_+/(,6\
e1d1?[H8A@616PA0-HJ58I@P4.V^4@<Q.afX@B@Ng(,6UH4f#_D75&N(28>2-C.F
[U-&>I,PN&g2ZS;Y?G58?/Wb-IBB)gVD>-[d>,ecGcABP9XUK2:X7ZG;S6c^;T:1
-FAV6=L9Mf&\1DE>fc_Z9Vd:EL2U5]IMJ3D>X0XZBa,[8GJQ<cgP#A[g5;KEPAeV
gYd7W-,&OPI(0:Y&TYD)4YMX_?N+VcA_DT1=3Zc_VPB;4]D+d]LUfR.DDO75GbH2
OU5gR@G2/BO-&HU&)V<?=Ub-@ZaG>-6QCX4PBH/M&Y,VCcYfFBcHYHQ.\c&0cEf\
E<-SS_A@_@=Wg4G_(_A&/KG_.dXQc>2HS,ZJ1fG>4ZJaRK=0aIa-.\77D)WbQgB0
H4<QZKA.Z]69ITB_IF=&-F&0cTKH9>X@.ZK@4GK,&eSK+bN^faW5&:^V[0eBJ6P1
AN4\&L]S-YYIbA.beGE9)U>R/=I98[)H9VSLE>K:e_5E-gdaaE&R<;U,\ZbW:_>_
A-871=0BHOO^C@f=YXS?]E8\W\5=233Kb^Ya)CYfN+-=(;-VN:6+>0:+7,;Mb2]5
g,>IAg\0dSL]8JaU#5(b1,<-21BQ&CII,95EN(g2HNIK0_0R=+KfJ7KTFW#N#a76
6aQG[cR=YZ]^E)RW.D:aCB.>24N3e^89JD_MORO+LE>9DPIPgJF0D\gGL-:OEg]1
gWaS80OX2:#<_Y\7)F+4,d&\OAcX1L5\#V/&-@PU7U;U[>/1dd<H^,WdOH]RYPN6
P5/F-.;<=E2/MM1gQb0VXIE\HgT647]UdX8;<Hb[798>PPK.)L5A9^XgJ)#L=:)I
&9g@YYUW(TRdJ-PH3^Q/JHQIS[,1KJY6]I>&f@F)F[Z^A#VZVCSQ^C?2G3/_ee4O
;\LaA0,H7DRJY3K#Z4I(,R\0eYe@P./a?C@Id[^C_90:RYABPIZ3bc3/\eO7?J0<
ZTN3bP)&F:E@HI03Yb3M[Me><3Eb>2^2#LPQ-T1cA=2fSRg=8=X=;.]]AU8RD&G@
;5PeLf22HQN\_c5(DQLGR^>1V\;V&.?Ta+_N3aUEI6KfH$
`endprotected

/** @endcond */

`endif // SVT_UVM_TECHNOLOGY

`endif // GUARD_SVT_BROADCAST_SV


