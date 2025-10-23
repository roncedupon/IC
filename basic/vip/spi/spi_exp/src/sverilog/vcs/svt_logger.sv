//=======================================================================
// COPYRIGHT (C) 2010-2012 SYNOPSYS INC.
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

`ifndef GUARD_SVT_LOGGER_SV
`define GUARD_SVT_LOGGER_SV

`ifndef SVT_MCD_FORMAT_VERSION
`define SVT_MCD_FORMAT_VERSION 3
`endif

/**
 * Used in the command model class body for each callback to make it 
 * available at the command layer.  Implements the inherited OO callback method.
 * The base transactor should have defined a virtual method with the basic
 * prototype "callback_method_name( callback_datatype data )".
 * callback_name is of the form EVENT_CB_...
 */
`define SVTI_CHECKXZ(portObj, portStrValue) \
if `SVT_DATA_UTIL_X_OR_Z(portObj) begin \
  $swrite(portStrValue, "%0b", portObj ); \
end \
else begin \
  $swrite(portStrValue, "%0h", portObj ); \
end

/**
 * Logging support:
 * Used to log input port changes
 */
`define SVT_DEFINE_NSAMPLE 0
`define SVT_DEFINE_PSAMPLE 1
`define SVT_DEFINE_NDRIVE 0
`define SVT_DEFINE_PDRIVE 1

`define SVT_DEFINE_LOG_IN_PORT(port_number,name,width,in_signal_type,in_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  $fwrite(mcd_log_file, "# P %0d I %0d name %0d %0d %0d %s %s\n", \
          port_number, width, in_signal_type, in_skew, sig_depth, ifName, clkName); \
end

`define SVT_DEFINE_LOG_OUT_PORT(port_number,name,width,out_signal_type,out_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  $fwrite(mcd_log_file, "# P %0d O %0d name %0d %0d %0d %s %s\n",  \
          port_number, width, out_signal_type, out_skew, sig_depth, ifName, clkName); \
end

`define SVT_DEFINE_LOG_INOUT_PORT(port_number,name,width,in_signal_type,in_skew,out_signal_type,out_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  integer xTime   = 0; \
  $fwrite(mcd_log_file, "# P %0d X %0d name %0d %0d %0d %0d %0d %0d %s %s\n",  \
          port_number, width, in_signal_type, out_signal_type, in_skew, out_skew, xTime, sig_depth, ifName, clkName); \
end

// =============================================================================
/**
 * Utility class used to provide logging assistance independent of UVM/VMM
 * testbench technology.
 */
class svt_logger;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  protected string in_port_numbers = "";
  protected string in_port_values = "";
  protected string out_port_numbers = "";
  protected string out_port_values = "";

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  local bit  logging_on = 1'b0;
  local int  log_file;

  local bit[63:0] last_time64 = -1;     // Saved 64 bit time.
  
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_logger class.
   */
  extern function new();

  // ****************************************************************************
  // Logging Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void open_log(string inst);

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void start_logging(string inst, string name, string suite, bit is_called_from_hdl);

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void log_time();

  // ---------------------------------------------------------------------------
  /**
   * Buffer the changes to an input port, this task will only be called if logging 
   * is on, so there is no need to check if logging is on.
   *
   * @param port_number Port Number
   * @param port_value  What is the new value of the port
   */
  extern function void buffer_in_change ( string port_number, string port_value );

  // ---------------------------------------------------------------------------
  /**
   * Buffer the changes to an output port, this task will only be called if logging 
   * is on, so there is no need to check if logging is on.
   *
   * @param port_number Port Number
   * @param port_value  What is the new value of the port
   */
  extern function void buffer_out_change ( string port_number, string port_value );

  // ---------------------------------------------------------------------------
  /**
   */
  extern function bit get_logging_on();

  // ---------------------------------------------------------------------------
  /**
   */
  extern function int get_log_file();

  // ---------------------------------------------------------------------------
  /**
   * Replace "/" with . if exists
   * Replace ":" with . if exists
   * @return new string, string which is passed in is not modified.
   */
  extern local function string clean_string( string in_str );

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
>RFHTK.#KObI_dMQ]=aA)[JB:]R^aGW1Oe9HS8BB3I)>W5+&ED8A5)YfeY.^f1#@
N0@BAPUV>)CERO]W/GOeH0;@CI-)GB]0fW4M9YYA#\a-+5>)DL.XDH>+):C8>^9=
JI+e=V9XLIc?@]073&ER&3cK/5c>edDKW&[G^-;6/XE2=4]MM+7-7UT/4@,J<_SM
][R).dGOCGHG(@W&]LGbd&?X&AcA]G9H(PPAg8@4+UB\HHC>JH(cMFO8?[C7Lf>I
_,)g,MZ2?Y+3W(_=(,WKLF:K.J.WNF3d=<W=.8[9e?_YV2bHUd=e>+]T6b/5H?Md
G>H8JULb)<]18EVC#6),R4JZ^MP.MS2b-=9K01[RXJYJ&=^F4DH#;PUOKM9)RR]c
Z)N>gCO-9FT(@eTEE;OMKg/9GHC;IB;++:?@e(0c?^bX(ZC&@/T;UBMeT]]N&SV9
1NV\#PGN)F\gV19e:-MAXGO[-c_2aZ)Xg[S8[S(00NT&AT4GNU_\df8--EcgSfc:
K__)S-c,Hf<GZWa4T)Vb;@g+A=)WEA,^#T;C-#C?7G58ZeXV:gE127Y4Ae^O]A6,
O=@7U22=Y?#8>#<I7_=;gPQ(,9.DAH&Pa,c?G=JEfSWXO2D\FB7>aZ2YAZH,8C>O
OQ[QHe?VX-O[f/.D>0bK3QO@,+Y,JMJMZ97BH_QP+U=dNJ?I?5bA8?UYeXD1&XA1
-_GBg?b_(HZN/,f\^-UPH1IEf@6XJJW<:&2B@gVd_&E^QOgbHfH&)c1A1C[:DJ9P
]bZ?8X]g[K>]f8A@UcS)RF3eZ:=D=O[?96U^?^5]]VcF&M0,0-C3QeA4T.d1PZWQ
_Ob>Ba6YUL0G]3S,gOUBgN^WHFGAT:F0I4,OV?Rdc3??W?eA4X6bVPSO545F:0]<
04D@L5]B(RdRJB?CW>-dMII4:&\dIE(;LBK,T[^E0O567L5^LgbVgQM1JAgH,Lb\
2G3Y.beP3M<HE#8OU4aC=,1ce&0#gU8Z,_JR]A=R^f=14:a)@YBLG<\+)YRO1=9X
P8a.XJJQ?1-4:?C58bc(G_]KeSZb3;5-H#228;&d?g.)53)-GL&)JA#0=&>a:9,-
YG=5dYXL-[ZgY>^EbaV0GBYFff.E2]Fgg)65VP;K72WD0_X5aPV>/GLRF73:Gg6E
eAL>(7:8&4D&b&=YQL4)#U^N+>@C-BLV/4[>+=MdFTU4Y)=&Y6_QERd@6::A;#c2
g;E.:\+OT&7B)22Re(C_9AF>8)gJ\P,,MZ4^39E_67CH_(VO7J59^c(=?T@K(2C>
V]\OUJe[_RQ+eZ&c<Q;?NU#fYZ5A#I1HEZO#(Y<DF#P#PaX_>Y__M+#CB>:1)>&T
0K)<?_Xe?CG4HEN5)&W6I8Wc.>3^6)Be0PW7,f5bS<FUg_P:,Q+W3d0_06,P<Deg
Z=/g(:aeF&A):g2g6>LLa;IE1^N[Za_N9dBHS=<TEW><:H_[NHJSeEQf?aJ:e4[R
2<JP:a,HQ@9G?J#8Z);@aNCDM^eMK3b9G[I#>9:ARKO)fA;c;33H5KYQJZ;QF,YZ
@9?J,/5TOc@eW3DaZMD=S7U,XQA877WV5^b7;ZS^,&>E4=NZ:)D5b4GgfWJEfa=E
/_Z-.,,8^NI29(\eSO_dbG[SReZ\[Xa6D-O5X2LTF3#Q6O#C)@5LJC)cJ/a\GJa2
Cf^==R#CER/7V?>HAH:)?<[J?(.I5b_DO7fQ@VA^M]W]CDG2K(=TTDOOONd><SL;
J2@=)HA^5#EJ5,NRa<RD/c4Gggde4QSCe_I.B2Ld_g0(<8:V0BH>U^c-)ZA_#IK_
,2NP28/DOaIJY_;:R^;Ng2LeX]>aR+70Fc93gY_5b2>QL\;RN\eKJ3X5\S]Vb#6M
J-D+36d[:O\)X4)N@_1g[e9-WQVHB>\NV3#_Mb5^a0^[P2c7K?;VP/4_=J__Q6g5
=JTAY7aMU(0K@+XG5e5&@EHS4#_19MBX4K]\0GEZ(+:C05a>/_W_C=<Y<Xb3RF(@
\ceXMGF.1cZ65+:K5eKQaUfcf(aBZR:^ZK:WOHK;JNJCWAeN/O&SGc@HK#_?L1>J
2[G.:12<<U-)BD]0;f3V\2Cdg?G<GZCTU9>e6Ne-[+e88IcV)F=.&N#Ra]:/-X?9
Wd/-<;SB3LaQc7NM,[.?U=-8][/RcbZJ6Ge6W47879)CMOg#_(P.L;Da&_N@S/HY
#(+.cI8O(X-,cYcM47e.W1:NS1(dB8^?d0cN7dQ=7;UBMed(G)+aAP(689P4,/g>
J?G6^dIOaU#(.J;cH/AAZ76W#=]>/9TfC=O(6U5MSc_[;>AGXa</B4G5/bfe:IcG
?PPf4+KW[YJ<3Qaa,+H+]QTg@7b\2f^_^2-0:(XL)<NFf^+O)PH:6&+39==6,]S6
;0eWD9-f?SF.)JM[T>&;W\UeCgBE,,FL@&:SIX?a9K+IZ2cfSAUH5?AQBE=4W]7C
<&84/b0LHQX_M)1E(3#EAc,ZH[I\cF#MSK_NPgb#BJ#P5Kd9aTDE#(dbV;;:;7BN
#-RN#,7d?EM&BZ;M4//>LVLc<=7<H8S7K>a?G;]YX6)@A/TVbH9BBf,aWDE2KP@6
6Ndd#R_gW)AH#2<>?3@U4\+4#]SWE.=9W^IgH5:fS=]J?K6[JM4_>\&6@0DJLOc7
#JL^GK-2:CbL;]HWfdaabUKYWP2K(e4dIXb8UUf3bbN]dPg]5J;5WeaJN_B/W?4,
-eLad7F?OP(K;2bB;\IYaAeQ[/g6SKg4aL/X-T1II7W,)c;)1L^:R[[DG)Y7GaT(
H5&O1D&-fS\aUF1N6WYReeNC.Xa\FH#6,400C1C\ecJ,1Q?6>O9Ha7CffK+^@449
65Y;3D2Y3^FE.Y6<:2X]Se6VU=>+O[7+.7g;.P?c3T7\f9UPXONV>8KM<XT55VC\
]=32[9S[[-g#:12]a#N(Sg;QW9..1?8f^HCARI<AE4Rc[EW8\8)SZfDQZ;G:f+;1
83)dfVc=&OWEaf>SC&CN#K1<-<\?M;:D+G3@Mfd@bT;3<[4/[fJ33Ca500Rc\@YO
K(N#NC]GO[C1Ze=^V]^Qg6B19_V@9KZJE=5@[1MMQ2)GIbEFU-1[BV^.d@5cM<;&
>;gR:FXL=aTE\?W33,L2V.CJD2N/79I-1HH;C?S@ZMD)7VG5GVfP)?S&:>f4GDBT
MaG@@[cN-PCQU4IFSd73:\9_DO/4IOFC[;R6d-KFc.R\WV=+47+=O@E4.EaYB@H,
=_27E_<cb7__=#>__:1S;;ONbFba[T<<XUA\K<>MgYReICXSB<+])a8g<EQ_SRZ9
.DO;_;@JVUTa-1Zd(@.]1R8_#f/<UUdLW#1a#QDXV-3>aeZ.[aDFM75.YS^WS(QD
NT]:QW#BSOWM\\6B1IPPR\W:RP=?LR2&E4Fc\cTdB3RT[0MB=GK).BHJKYg-SR2V
74#K28.OcU6@8+ZV(1?Q=GEZfFQVF64MU(V:3^<D:KWFH88VP=56?P=81HX8d[CD
6bUKHYHcUNM[a5e4-P6)]DV.:Y&TH[cFCJEdgGWXA/+FdBFP-Pc7e(0/I>\W^FK;
:98]O[06Xf5+VdWRaGCVUF/211ALb:/dCe+76@60LW.RM5>:36&PLHf:[>2)RSQS
#1-F)8aI5W:JASdBBaC_2V>;.HD_._>H>97[Y@CH^GVHZNe4.Xa)19U_>XBJfXc5
1)?X=N)[#,,dI_+cLJ&G(8[6[cZCB,EgCK3K<f_g\fTVT2GWY35Oc=G30d)AdIbA
=c67(?^PD#MD;(bNK5-@P>AS^Ufff\G@Z?24@5YR-RA<QKQ4_X1d&Nc\XcO[QZVR
#G2c(R0NX1LMJb_PD1W,?>cVg_RP-Uc+Ug)\<OBD<Z;L0.J7&,R;;(OabI6,TG,U
D6,,:\Hg&gCdbeVfEc+87UO;WH[bVcG[1I7UE;,]7T<5)EPa<G8;R1+1]LRb:\.W
93^T.TLdMNB7T\X.U?RCN>;2W+)1UFG,TW9U^11,NJ?NH=AI,W2F?[AYIT1U0#E?
)WL(MJ+GO2/\\:72&f/\67QB1RXe_DNX([0N3]TeKE>1]?LMBVCUSJP+b?^MCX)&
K8aH1&(.?0f?,KB@W>O0/;dQggc-(O)P)^46f_LI^<bMGP[b7Ng#Uf85>76+:>U3
IgKMU^>E&4RVVH]F4bPT;:KAL.--RT)/LQQg2cVSWC+LU)+_S0?LR4.;:_g98VgH
S;8:\C&S15X^QOd??a;+YWJdB,9STL-KA:OK?g.D,R^@J4HGaPLZT4.@2),3^/.5
8\Ed_,,efT&D1N@M;cD?3&-]W1&^Z/;3]IDD.gT/FEe)L:A2.>A8:bHJg@ZHgIJ:
>#=Y0a:2#)DR_R/e#XaKDB=&Nd,?454^\f/0(9E4aLeS@5B\WcBGGeP(.I+0H(_?
M^K/NfE,&J&>03(E<2=+Cc]g]@LFI?dUPHJ+EMdc1J,gIK7-TEEcH),#-##OXd3:
[geN0__ef&8/2R[ES^3PTQdAFPPbGPd,U^IR@(/e0Xa))(#I8=GRR/KF(W8&[#Ae
2Fg_>[(91Za+6c[/AUNZ\->LeA?Lb@3:^MH2F(1D[+BRa\PdX1bd^\00&BBD4&6>
V5@Q(HKAGO@gc(J^+.OY7DFX&=-bC5+3X(:G@Obe5-/07g-&:F^,VQE/AcH7/4VH
Y6?eA4AgBMa;Q2BT).BKXVYW,FVD@>FSPc:LaS?D1U9W=[:Z?aW^E_,PJ6I:G/H?
J\&ZD#c(KRJ,6+)B#AgFQM+[>@@9Xb+N+;.[;^58U-(4P.(.Ee/cQ6VG3(AYPCO>
[)E@(KKN:b.f66PdTV;>;?BTBIXD5aH00&JVLGZ/ST7fIb17Y(V71ZOb^)=^G^R)
Z@bR:BKGQ.:W<)^HPZM0._;g1cD_0&G5GY\7_6Lc0ST.f@0F#/;LWC7-SIX]/@PI
_EAfPP0E>.CXX@=&>;Y4+_/A?W,ge>.4EQ)&M=NK/fKP_:K45-QgKPKSU0g:@f>O
]c-7PFC?GaY0:Yf:06[<//Z;0B;_SR_M_Q\&(WZ2.:QRXD#Y;030G)[L+Sg(3_PJ
O+&Q0Xf2#8AdBV-L4=g&8b3f[WV^Z(bZR2D#W19\5_D[RP=;HOV7WZ3T<SX2&3aD
<QIc6@\\Z]E&51=>6[46#T7^F>dP5?WHB;GDcc#<b?K8)eT][abE9+__9,QX_[b(
<3Ha1JIT6<FX4fRNNSfG(7HP,N)RJQT/XL2-L4&e+LCT8adX<=HTKFPP?6VYec#T
Td53\YY_9Q^SI]NcFf0.#(<Xb+A-(>JR^ZNPQOITTf+MH59&@P]W?fB?M-1Af9E@
^SB^@Mf/9.dW[_;,&3C=L(2(Ya(9SH2#;RQ5<9;ce\#&B?Q&+\5&(7b_02HAaNL&
]@]2[;cQ@L:/c?X/U\VQYfRAF@[KU[0D)5SVf@bU;XJf,a34f#<0:8M1Teg=A;B+
,MfD98Xa[O=66-_#[(ACAI)53-Qf-F=IgTcA?)9SLfGPQX&2#1W/1>e&GV]7CD:Z
E1:8@L(\:=Q-WacB>:aAURY1]4BU3b?;U=3S5K+QO)>19T&:-\D#e)++Y-VaFS[H
0>X38g,@_,P@6+N)N[CRX1S]H?c]AO=RHO7<,fHVa2U;3c96/1M926DSf)3>JW-P
_IePZIDA1B8V(RAId/GMW,BI7E-41;U.Q2-_+#<#-eG-?PX4O6Q(b2BGT&LbdL?-
W7I_TX[K<_=e.W>85TROcT^IM&K3)?#_V@7YE8>d]7)<[NDU/]T)/D/g:b8DPB\g
Z()SW@G[=L)NX3=0XL2=_XJa8DS8a<fBNT.La3_15ARNe?5e8W\c>5aUF6:Q&bZE
5]M9KBM:S;PfIL]M16[<P_TffQ/PP+J5Z9)9U_ed/If7O(@g\Bf1PURb<7O4V[d8
HT.LCJ?.^NMeQ4^H,/AWYXX#C/U]H^U3?H6(_(\.\E48#YUAH1O5.O>,D_6&A,fa
eUH:K1cSf+#?_[;7ce;=aWGZg=d<TGe^62TN/J]N0KV;&OK0d(V=eOD8+SY;bNZH
OZCSUDZUB>[W&+Wf7dE(.3IMc?L5#6&eM94Mea1BAX&^M)?(RD;(8W/g=Z2KWR9P
W>@1A9X;\]-g)&CRe3c^<EEf?02#@gN&V6EXPb4f4a@ZVZ+Z5UdCL#NX#NcC^I3e
KU(F1U8O3B[K<RLGM8\PRWb?UOA5X^R.033#4D=cNa?#f)96EF+,ZY3GB\B@Ta.3
[GU(g;(<JJXb5,bN,cNYM)CD@&VLfgF-JO2V)@dHNN_RKOfO+a_NBcXfU@5?&g5V
T0&M9>G0B5X1.)^WZ<&&c0\6MB..8(ge>?:f[PT,2A3dJS_2NMS5@<Q:<F>?IB(R
af^N[7.9<D+C0b0Z8XZ/Y>Q5CW)+?KM4<(G9JVEWe,HJ\bYdG])-RH/Ca97-&U6,
PYbVIV=e.P<ONNMP34Kf:@&T/[6ObNRF<J=f><2W6]7-,d>?&gJ3XP4>MaaWTOSH
Y20FA](\D<G?2DAc+G[,87G,OL_C3)YVG?_PL/\M11CadSZ@(@0T4_6LWW?F4aUb
1Hg8cE9J<;ZG[LQ;BWNW<H)(@DV/WM[FFg@4FeQB46>1TL#_;g7?C]7?gFONXO2F
ZObFMEY;@[S15>FGT6@3LeX0:PbH)<>Q^A]2@XW1dB+]FK0[?YP\KX,aUH#U45&;
M9V.W,6fc\E?O_c4/(6>c7YNXT:Z(7XdfDdI^&B)BQ_,J7=I=XaRIF1MG92SW5/+
GBXZOdY]38gH+Z1,e;P,RHYa])?F?LHKgS70IAaBgfEVL5>d>RC9^0BP#6HIYQNe
KSEIb_9V/Sb0#+,[c1LZ\))F[S-aULaOfQ#<Y/9NS+,Q@9S5]ZH.[0FN@D3,E2);
IVVUATYO3Xb8(2V1ZC[#WW\8,(Tf.IRWIHXOYM7O3@]E:N.BgeD;L\[bM;1M,\(<
BdE:MKU2JPe;c8f<?[F,=_[?;=S4gdX=gP:K8()O<:L2C\2MWa1f\aD3K(G;\DF=
2L9YIe86&0/ED0eLg?M,(]::6UcTDN@eX/(7DBf??X^e:5;0JFH[BK-CRP;BFeGY
_#4JCa.J,bb=ObG2M9?Q@=R9BL3JN,(DO/8[ge=;Y7R?OD(#U=2]DKdF:C68R6_g
=\c?_#.F:A[I):KQ=;_=a1:/S:]6.gV:8BbY.&],Q2MXSL8O,V_R/b]),+A.SI?I
d^I1]BYN.)<_I,>+9HaTGRH-bL8/LZfKC>V)\;-H-Oa<7Ed[.P0JV@><NJd&?LGb
8^V_G1?A=R=7dVF4>6X]@/70]H&W)[T]8[=>MKE1PAUHNW]H4Q+TC49J^_9c<+69
dXIDU5I^ORCR>;UD>g]GG+DUeGf+2ZFN\&C\?R]F6_I<K>_[ZbJ]?:^?AW#\4BSL
UZ9#OG(>6@U>G-(eP6c7aNTRZ.9(bG;GSeJ:1.<SRbL&?TZ+VSWD/F8_<\D&0<b:
c=C0cQ=BEE_[F4HdB7A.:[gET;Hf5WFHYWN/W&G-)J(JGc[5X/O99VVS0#0U4f&;
=F9F;bQ,DHUDPeV^)_N0D50e;2OE5QcaeITTO\.MAf_IEYV?<=HLdU6VWJ03[/gR
D_VX63.ZG9N3A2WZ)NFf4I>HeY5@cX2&Q-d1J&V5J)2W</#>1dR/&HMd6NQ7#5Q;
W(T2K(JBa[VS_1W5@9.eN(]],YGMe=:3U\[.KBfc3B^:c7X=5+W2P\.0d0J)f,1[
(=Ue\SD_S><A+2:\a8b+-7eE[#Yg1F,=>FX<+=[<I.cJd<L9#3J\2S]]JZK/ACO>
/e^1&dTMKJa(?]-J2)ZGO9IEU=6U<PC,_9c\CUE_5]90J/P>2U(,C]8dVLdL?A]J
Q:UG<(:62KE[24\d\^ALf,?]7AVCQLK+M/C&)#3P[936JL4D5:#BS^6][F[..1S1
07Mc&HJJ^;4dB-=OJ-TB62,DC^28]e#0[5N6:>IC.;,0D2>Ug_(Kecc/8TWW6,H?
AF8Z452D#[UA/2Qd<-M:V25D&KKJ]Sa[HB;H.64dMQQe@[PfO=1_PSdAdad\Nb+W
O;_3+Yd7MB<B/Ifa1^S.DJeG</N2Y0g.:VX9WM&:fY;BSZ0aOd@Z#04.Z\CJO#FN
/@d1LP,2M0BI7>+O,C5Vb9b)X4M<cZ]Q_F4_#[2ICV7^?)M]KC78FE)OK+9KK>ND
K@?TX3(;8UOO]Z\SR@b52HMc7?(/E;>18L^:CD9c;:B2@&25AP[f_f&[5NbF-.]:
,@B:<W1/O_8#8>g2>AQb(b17THC#WOG^#d&:+_A.==R0NT.M1g1gBO]KPASX71?I
UA_L&RaQ]=QGO2JVI@>M:4(bQ,?->YL(QVBLKb:,G1D,YX7<;1Z]HD^?BGR:dF;(
O:]69YKX60&M3a;bM2KA>ZW8+)7/]DP\ZM>@.YOb3_>5g;X2MD-.PB2d)\)PaX-M
KYZ&=(Of,aJU<#U+.Xe1W5d3^MCU@b)IES0^<5(H<78.WDZCWHME^+S/Ge6A5HGf
-,@N\24TS570F=][,?4=\XI+C48U2b=W<?+MaHC;]T>-?)9VeW6(c-X+-^UT2?C1
-P0H?0KQH6U<H#9>XTP]GdM8UeR5_0@-Pf4baSd[eeSP1PUg-EI_?JJMKNaX;;N6
T)T0EZ0VGDG[7C5Ia+0<0OBQD3BK=N_8E9/90Z=\ZcBIcR48_2<496U7(J4e^WUc
e95DGaeL&W4FQ/2:/84g&#_\EOeL5bH:f\CA-aDP/gdc&G,G+(I#=(ZC)PMUU&Sd
93O)g=f\9Ug:+BRG5,F/0^/J]>BgCW)ESZE)[PaI_=gKJI^C^-R4NN5c^A7K>BKJ
.3LM@A:1YYTL)\#3f]RVU(Qb4OCa=[2MMO24),D-?KH3DS=dR_:aS5?=WKPV_9EI
bQ0V^9+,&_3X2e#aB]E_[=<fH1<cC<ag&KM-f_^:K+@<Pa^)Vc=08FT?-4K(VCG]
\3UCa\ISQTJ(KO38667I_7GC1]gE#+E(+,?aO=bgX@d++@=.1BE26,NP\7;+aK+Y
^Y2F#Q+;3&]JNX-XUC=:]NNRH?(1V1=,^TK3FJ]I=V50_f,^\A^W:Y2Y3#\_<37,
8IM.,VWAXIH5#?&DQ9^7PW_.[OX+NP(SHadIE\-_9S-0;Q8GG?_UW4A#>YU(]fY(
26=FOdbK((S\F07)8&5#;4F>Y;LRVg-8?D65GAg>)0Nf(<N[Sg@V?KTYf+7Y62\J
LO@T4^OG3,8fef_e14eA=e(f.Ud4HQZ-HJ+V4,gG4N;>O.1HCU?N[>[DN-4[/[^G
M@(16eS1<TTI-IJCP)IPA.:7Eb_-?#A6/L@6??AS\FcR<dX5D=aT,N64[(-BB&8P
/=47O4&8BIWcU]&\JR:N&BXeG.cf8G=M[=UHgg)@\1(5]+^5eGB>)IXb&#=T+,Ra
2H^J8@=fEDZd>?M3,VTOOZ=D\#).Lc#QUe7RV,<(]@L:;df)]6[2]0(+U-aFQEG,
R)GB,dY/\c_84g7&OJUa4)19?0acAUODD#Q46N<)(cCG)#bU2>VEbF=:;IQ2=P&&
78;.B2bGC/1Z>Z:Z5^190gc58RSa(YfE<K76&G@:>(?LJUO@2=Oc/-d199]IdS<\
.@22?+FSDXFHQU913LYLFA,+&JeT:.1;H?TG7;UGVF[aSD^:M\-47bVXD34JN@<#
[PNVCfgI)E#^=S;&-fLaKH7;E^1?HCUg(G@6>D(P-@/=g0]@:OgAJ9W1?SDg#5+2
.&_A7>JK)CXVb.^E,_Gf7P<K4;VK\Xf4UYdf)@C:)YW&g1,\L&D+O?_T6.f-&\TS
fL\+V\a;T(S>P21gbbFGg:AgS)3W+B).c&UVO6#T)@gW0(=@VXG[3-QNS\.H)3A8
M#6Y#d?SJV:;L[\aOH[F#?F.c?8GfJ<B0_,/Ub:/+8K#;Jf#.Z)Y:US9.LP^Ie9=
R6GH(:A8DT+;>PY;H0]#8<MA>/:d.7IGE+5FY5TL4O+](S7g2g0>SFO5=^A3gW?=
K:LGTNQf&ZUSAQ)/)77d/BEW7.D<UW&2b^K0IIKF5_6A9(-f?XRYRPd5>)=P,)=7
/H_T)a&cQF=ZCXO3S0HfHUd+Z_Q_<YXEdZ7>aFHN8F+Gg3(YCDFT4]]].CP;DEM,
9-;</]P@7cgV;V[VYa;1c5XBEM/0@Ke5Y/CN<1^;,2g0I]H7C2cN;MA1W?X)N/4:
gC]F(0e-M<,\,gQI,D8d?E^]Y@OM.?T]4I5/B5eW8F/c+^M.ETD_>;NXeZT#G4^=
;PeB_JDcDgbO>-Ag0TeWBC<:UFJVd=bW:$
`endprotected


`endif // GUARD_SVT_LOGGER_SV
