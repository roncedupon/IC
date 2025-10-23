
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`protected
a[g=J7RAbHbDOJ6])UTIgSP#XEMQ?cH+,G#_=C_^^+Ld0\bIQM#Q4)01V<]\f\HD
B1^OBR.:19>#9KK))#R2)]=JK0H=f/QQ9aAO-M.#62Z<Ab7e^UJ-5^(I=gA_AfEc
&]&X3C#G4e,CadZ3GF]?VTKSU_g@0[\=b<YR;NV>VG,4]RgI[J1fdb>\Ff_\N>H@
/G.KZJT[^VV3>)AU6.&A@50NgGd7)@.AS,E<>Yd0a[M8:f?c:7BDY5G1+[WdS#:3
NdZ3FB^P(TL;6BdbZgg6V1Z.P&-P_SK9D-?HK[@M,aX8((;S.(U.0Q-&ZZU?#8H(
VUPMSB_QgTNd5QKC;=3I_B7LBE?^#P+b@^gIP.@T?CG:(&^9YH/U]E=FF&>#Vf7>
1>4[@^Ja(-=LRL&Bd]]/e@>F8E=P6UXC@Z4-J:AV7O=DN@XEIHMZ;02\KH??PKV=
J\5+[#2R&>,&]8?UT<2&M#[XO8Q-9B]X(^2/YQ=HRQ-OPK@baeRZ;H]OWaCJ>GBc
3IeK3eY#51/(d8]d<QJJF]_)JWOM/.20?b;a8@70b#4?6cRCa.B^[C]OK$
`endprotected


// =============================================================================
/**
 * This callback class is used to generate SPI Transaction summary information
 * relative to the svt_spi_txrx_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_spi_txrx_monitor_transaction_report_callback extends svt_spi_txrx_monitor_callback;
    
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** The system SPI Transaction report object that we are contributing to. */
  `SVT_TRANSACTION_REPORT_TYPE sys_xact_report;

  /** The localized report object that we optionally contribute to. */
  `SVT_TRANSACTION_REPORT_TYPE local_xact_report;

  /** Indicates whether reporting to the log is enabled */
  local bit enable_log_report = 1;

  /** Indicates whether reporting to file is enabled */
  local bit enable_file_report = 1;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Creates a new instance of this class, with a reference to the SPI Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1);
`else
  /**
   * Creates a new instance of this class, with a reference to the SPI Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   * @param name Instance name.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1,
                      string name = "svt_spi_txrx_monitor_transaction_report_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_transaction_report_callback";
  endfunction
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on SPI Transaction activity */
  extern virtual function void transaction_ended(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** Builds the data summary based on SPI Transaction activity on TX side */
  extern virtual function void transaction_ended_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** Builds the data summary based on SPI Transaction activity on RX side */
  extern virtual function void transaction_ended_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of SPI Transaction. */
  extern virtual function void report_xact(svt_spi_txrx_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Controls the implementation display depth for a SPI Transaction summary log and/or
   * file group.
   *
   * @param mon Component reporting the SPI Transaction. Used to identify log and file group names.
   * @param impl_display_depth New implementation display depth. Can be set to any
   * any non-negative value. 
   * @param modify_system Indicates whether this change is applicable to the system reporting.
   * @param modify_local Indicates whether this change is applicable to the local reporting.
   * @param modify_log Indicates whether this change is applicable to the log reporting.
   * @param modify_file Indicates whether this change is applicable to the file reporting.
   */
  extern virtual function void set_impl_display_depth(
    svt_spi_txrx_monitor mon,
    int impl_display_depth,
    bit modify_system, bit modify_local, bit modify_log, bit modify_file);

  // ---------------------------------------------------------------------------
  /**
   * Controls the trace display depth for a SPI Transaction summary log and/or
   * file group.
   *
   * @param mon Component reporting the SPI Transaction. Used to identify log and file group names.
   * @param trace_display_depth New trace display depth. Can be set to any
   * non-negative value. 
   * @param modify_system Indicates whether this change is applicable to the system reporting.
   * @param modify_local Indicates whether this change is applicable to the local reporting.
   * @param modify_log Indicates whether this change is applicable to the log reporting.
   * @param modify_file Indicates whether this change is applicable to the file reporting.
   */
  extern virtual function void set_trace_display_depth(
    svt_spi_txrx_monitor mon,
    int trace_display_depth,
    bit modify_system, bit modify_local, bit modify_log, bit modify_file);

endclass

// =============================================================================

`protected
;C+5)J8CR^=?08Y7N-]P^+W\U;ZCB69Kb>M@S2B_VNM8-S7^Le0#)),\IS1QE;3@
86(ccN4(,&:P17]#5<23R?R&0KESLAKK-:RHV882L8X)[7+\&J,1RLPcVY^;(;d;
#:WP:[9a]4VC]Md>gc9fYR<)MV7]/YP+OCGH/TVN\P[I4V>=6EBd9&.W#&5GNeR#
:2Z=UUB<+e?UM:1T;?f9&K2;EEBWB?5.CXR0YAXV)K5?#cg:eadAO13C^.)RH^4&
H:];5c</X]7DB=+S0LK9,VAS2/1fNdQ[CKF/+?3PIgf/^P4\+Z^HWRV5&IS1HL]G
,MFbW0Ig53CSfQRP5H8KAfZ=-_[3W#9^44068DCe/X@RA,KY-8.f:/T?J7PDQ>0Z
[/ZKc.;4Mf9,>7W5aQI+)-fE?Zb4\Qb\8C_)V@2,C(YM^5]-0W&,SPbFe=F5R;GF
@IX5R(MQVH1W]7;ZAPGY>&?b+>2M],]H4E(?-FYFRVSVDG5K8:KbMRdI/<->4-3a
M(B8J@fPKa:1\N4/I/L86:@KJ_;>LVDgHe=?e#<++Y\LZfb&@5<,;5#.FE@+),XE
<&I[FSRNN?Q=;T&cPc:&.?XQ:@VQF8RT4G,/3@_D^/#N1KA[F+,EAdY2dbKK4cPV
\;-?&=J0?RA(Y0RdT([^LdZ:\OeA<_a-RM=P=^_WUf+<TC75c+7b4bU^d^C?O.;Z
Y6+_^6E.N<LKKe4?\9]9XQ8gXPb&]FZ]S6AU-3_@B@7GCcc71,XR&SRP>Y/&HS]T
RF>9&6\#,R<e?Y3?cB(aFFRg1L6/_f;gX4Ef(g8F[L.51YVcgeY0b#^<>e-.(fIA
aFX/(;M,9K(Z-,>gXe-e5XAd>c7Z5_1AY:L=bTP<Ga:9U:GI2LV+Y2@JSBS#S]/C
Z+/<OUNK@O=(#?FKS0^</A16DG)<1YI+\,ZY@+aL,F;E5-&W7ON+7Nb]X)6M10V/
0@7e3D\J6C_N=L2O(.@PfR>F\R^cU2\&K+,8]L-^R\U>A>(SOM:\MMEeZ6d.Y6(^
Q@1)A0_EI[FMIN+C\,5TTU\[J1H05TI\;=RfV0BX;WN]K<_=1T5>K1,3VMGB1<D;
A.M<9L3RM?V\DeY]4FaD4+HK>=0d6P3:=U@_4LT9AL>b>CAN^;<IRX+4&-Z=TPTaR$
`endprotected


//vcs_lic_vip_protect
`protected
B4e3-0)N=JRgRE3@(<YF80?bH\EVB_aY<SLa:;_+HRb^=\5T[NdG,((A]J<2agDH
f6+S<H0QX:XDQ?UPS264O\(2RCL1@&SOI5<L3<4,1PJQW@#)I9BS)W9PG>041633
a[d?W133bc^J:RbEECUb0\\5f7?V4a34TEf@4;N5UYc/W?M(9J_27XG1W4]JM5b?
@]N(F/;2AH50))@8,]CZF>:3YR?S2aE-U?J6EH&#U,g[/+dO,IaTU@5-<:c21P<@
gSQQ7[]HDE_BNS>##TDWU#0:EY5_ESLI,&\M,3=^HL[NYE9C(f1dA;@B/P:>8:fY
/2S@PZ.#N52#E4e>&-6^GaG1[R&)FWH8daL\e>@146V+)gV)4O^3TX+OTW3D7V\7
F+]ZLf/&+&])UI3OA0Z)a4P?BO;[\E;>gX2>R/C:8;fBVK?a)=F<B.3eQdE764,8
b@#,AYFR+L#C<\HL2ET/NN&)IRI/-8dgLa?FYDGVC[Y&;L6RgWcM</PC6M1HYB\5
eU/;R=EW8PI9d[)XRU#??GQg/<D5?.T/ITH-JI3Xe+WXd?>L^fV=C+QgZ#4?/g2A
cF]<cV:<HfDTc2X.V\Dg_bd,eK:JXQZRFg9fSbSXF:bF9ERQ>YQ?Qc38C^Z4Lg9-
9/R;PL8X0C^S;G?Ge,)J.XI2b)@/F?_;.DRU?W1,7f?4_)L2/>ac0[/gRC.O7:]g
5RffFSbUAU(HDS^-YM<gB(E:_FPE/07X;c7RN6?VA=X.QRBQ5^3)2XNB>U#./8B+
R/FAfADVYfO]Y/.69e#\KX_SbQd-3P8:^YXc)/WbG3d4>3.K_aUN^:X9bRBJMO40
#12KE8_^0MYB?]J/26XdK?OTW4./J13\F^5N_cN4\;90(F;72-;,d[89\ab7U>TT
@cCeR8-PSeFC=YU3&L/:K5@RQ_eU-&Q5[@4T#3DA)LI<UL45>G5Ab1a6Md+WKH)A
bPXaGPNWRV[5O4((Y4b39F3Mf(0588O4e:2BJ^6JI#bO0\OHd^H^2VOW(_7b-_.Y
;N&17Q^g?@K[=^JWG6M-e#ME#@F:g\V0+=.FH.QCRC[3/8ANYG-ZJ2c+4FI&,9d?
A)(M_Nd1#9ZNee4=>7^5^CWUfH1M&3Tf\UX,6:\1/4dSOBa;[0#H3S(@-1,OLa7^
LgI7V2KD+-O<a=E>a9FfZaA,],5A:DNbTg4,)=HgJH+6.<e_B2g_/J_C)-VS)T[]
G@E\daYeK]_+>3P8Ee9O:#H.&3S&U[OcKC&[a^FS54;OE(1U.79-C:BQe9RYTcKF
9)U.J6/36d]D0Ae,E&AS_[^SG4I_IWXRS1HE#/[+NaaU&AY)IMQNJA07R<(B7/S6
O_?b<U=-+>)^cO/-N5BM8EZ58Z.D@-TQ4^&O>RS2MaS._gTM-6]2/gK6J-QNWd&>
<69b/fXU5KCF)U1+A]@KP7Z4#ZWAV;B^_EB,>(VPRV.9FDDAMGHQGaAJVgQV2KfJ
^f7Z@eO+\_1D,L7>=YVP_)R,W260U#FH(VNa97?-Z(J+SA/:&Y/+5EAZ^c2=7@+J
3[Y).?Bge2bI,Z\2C(GR5W=_AFEW^:_I,\[ECW,\f+dSH)-NXSaQe2CZL<\I>.]9
]]=EU.IQaY-,;7TE_;\MI(@[QK[9J@\&TAgG.:\Y)@F,3&OX\gUA_=DEQF:[<fEI
H)ZTLAG&]G#fbU6R2\f4RRY8>\]V^0fI;8-JCf=HP)+YeIYT.3QHeRU^7YFLSXDR
J4ZY1D:3#L62.+IP9FJ8=[SdZY/,=8VN7Nf@P_f24\W/YZ5QWBa_;E_gK3gV0Wa;
c\aYWXaZNM?/F\J?B19).?Wg]):QJ<[#083Z+2674\X;M/e<G(WW,LZ_.T?M(LAE
##SL&7YdRA_=VPL0cK]aZV68&Q,MV;<YURF,]K>1(cN;-d5+Q6Y.efM5,(f?_fE2
A)M);8-#fbLHbL,[VUS/)E:(\gIBd^6S\3,<Z.B^9RL@SG8=D?/EP^M#&f^^c+e4
6RQ@6A(K/3T9.Ed5b_Y6,U5&e)F@aZD/^_9G8gG2.LY5;^6g.X5c@8XBH4-D:_)#
N.Q;WU]MGDV^6W1P3N\Y2JLLLZ:dcF^Wa1e^T0XI0SSSH\-Wb0V1]3;Jb\QZ_b+1
&#[Hg&ZgJD.B()PQ^,WG,:g0;E]-OO2LfX5?VODB1U>?6>EQ5X7=Q-52E>K)4_1V
=gD>D:Q5^b^L:1#e]@^A.RQgMM\EVL#H0)gJNRDS;<c<5@6<5f;0OfTQQ2F#d4QZ
8^>VQ,,&K?<R,9MWWBIJ_/\G92VEIC3C]G,\]?=(BeM,9^2+T7(1caBF3V79KSMd
\D72>T>]JCJ,R^.)J((S44Bg?#L(=Y-YaZ].T.fP1Q8H-^&95=1C;\<5LBd,f._V
cD0VbZFB,>(;4LB#MJ9]YL[A-d#;I:GGEOFV<3-cYWKgL;;f1U>UY(&]V8[,[>LJ
GCNaaWDX5L+-2MCB;AMDc8S>-6A2K7,4d3+8+Q=:NUJ980VK#Q&[H+>ZZ:E)D::>
g3Z2Q)d9>W:Y<cLaga6L88G:OBVU(L;RSGO/G2ab<XI-OVdL[A;G&+J.OC7G(FG0
888,^:gcQKA?cXTDGPQG\TWf:UAR3>X92,<FYX3T&[?]-CX.7(D@VE_;NX[ZZ+F=
bBWPQ^6\a?JZFa)7Yd.a4(3_b:HI]R(;/C13>-OVMS=\@O,567LBTAJG2CE6Kcc,
HP&A<>)/([M4)@^Q7+U_Rf<UcK3GaXEPDKU+&-.^UVC:<cTM@.#D#XG&))a5Z<]g
Z(;g(4#+S#.6,4<1JB)+3g:Y<7e:FWI+[<AAD\><:?60CPQ_W6T5<.K8Sa2^[E58
HN\CTJCB\B5Yc&M=RY32B&&YY4?DB6&a<7&(XA_07(9:BRQ+S-&Me4-YMV4/D+,g
aEa7GH[V)\fQT12[HP4G_A^BQU=gJI_23^Q=+4b/bRT3]cH,;\EbF)PJdc4SUd,&
(g]9d5PTKd0g6ZD;G#N54YM[J1HMXQ,BH.J&)E?9]AU/?1J,0E^/e#9HPRY3897#
EV,c8#&(DGX92WF@C#&&\dD/H0MM]ZE>1-#=<F>1-WG74<2O>.A_:GR(T#ZDB.LA
5PdeIa::BaV[dF]\/bQWN&6@=W#eDM;gU<T^:[9R]MLaJ+BYN/0LE,B9-AEV>/P9
)S7fF.JKP6J+TJ;1]&K(,[4[22Lbe7:9GINZ/Q8??#\IAgG83[/YP<.Y4bEGEU2?
3a1[/H@HI#:/[abXgZI-O,@Y#M2I-/YQ_He;X(V.3DX-V#II:Y#Q4Y-JRHNf5;2H
JI5T+-11g>S>J#N/O.0/+:f^;P0f\OeF/a3DB/#=-I<=4=R)6.<XDXH16UZNGa#R
3[=AUJO_EQFYe/X9Fb]/b-LS@8WfA\]UIO\Q?J(^)cU0>6<A^N0[c#FfF1fcQI>,
PeOdd_.5(,]I-1Vc,e0=TCN\4,A&8[DDBMK;WGA&.:1#BbfZd,I-b;687?C#e#-Y
>Y]UYaF20B]a1P146PD9BD=5RA(e^LWA_e)BEG84ZVCaE..Z[,BMfE9+QcINeVQ/
#7DU@YD+&^LN,R?IP_ZGDc;gg7cO(^]Q,0?HgC:=PLbC5#5XXEMKGfV9T5f8.IfC
BRc;=86XYE0G?@a/PD\[B^V4e0Pb#Ad-\e)6eTL#6QGIQfVF35I57d]=>KJM\BD;
FKA:#@]69L6#V,bK-7GEA)HKdO8,ISO]7W<1b-3;+d<KfaLc8?c)Y8HXL=_NSD)G
?<LQf/4eMG^^LgddTW<7A/[M[ZTJ[;#70=dOQDbA:F#:aJ(feF<29RQ/)1?b,#=5
LB0KQ?P8F-4aTU&7U?2?NCSD._1?V_9e?e<+)3/=&c?AKL\_6C<^d8LLSH=EgO@:
\AC0X-TOP]&WagUAIMI&^;]S7aT;YO-;S(5H^<5]Q+9LUIObZObG[EgFBBeHb=YB
;<D,=<REXXHO)1TW\T1g6Z=NN1RW\PI<,Z8\WRB@@YYTf&c>\(b/]b0H2FTUcIU)
:0&\]G(\N^JR4[2R6SU\gQ+5:c5;M1I?CE-D^dLb^a>2T#R_/A^fTM,@Q[)RZPTg
Q-1S-U.;E3X;dI)g)TS<R74ZU6AW3OVHgO42aTPf0+>&L75/RH/SI_U([]G@eO(.
X0>eM7971S17JGOBg]>ag4@DT3;_Z5<W6BG4N5V7N&Mbf[aME2A/CCAROBEKSVVW
[A/BVf;ePCaHBdW[RT#4&/.I_7,WN[R,_90RI_@/c=-^.gBa=cFQ+RfQKQ(c?W,K
4/@R_eYXAEfO9-/Ve5GdHF2#2aI[AcJ>S:5Z^WKXW.07U-[KA7:S7=+1^)EK^I^^
FUU6<)Vd:R+9Tcc]SI;J[2/-W39I,ET8J?QZZ460:./ZMEDT\R5)H]fS_(RN4K(D
PMTM[-EaPT6D.&]Vd5R<9&_WPf)CcAG;_O3]-?,@:f#N/2F2/K,L\(.bZ)&J;efS
Y(V0>Z=G99@UcO^VH4=AU:B#Q_K@gX2ANAPU#]MVUMU7W:D2T5bB6&+O5-Be4GC(
KL(MK\?M8D>R>MNRD<Z1P6#HcK_GWL\]deDI^-/OPUVR>C<(XIA:7GBY;)CaOA]J
+AP2dOG5d^8^N/bG9]NIIPVLR6F\&C\8f/\)]U9<@^,GV#6VOBgMO^8b65@.<d?Z
C#4MMC^I.,^K/,DWQeB,)TDOG+;a=,Uf,4(]U)W:XWg5I?MO1-P,CEE;XF@HCV=,
3TOaBDNf5#VF\B.2D3cH#3g2B;;a;c<D\_+gJGVg_XRF7X0@\f,_W-DPL5ZCATWW
b-\R+6CZ(,,0EN.\GHWgb1QH)8B&NT4/(f16D/6?;@L2#9EU<LeIa?PSAJQgEH._
>(OA,U;aa(<Wf&_S_dM-+1D3[W.),1OPSPS7<dWY#Ub]@TL5QP/a?<DRX+(_A_R0
Z@P=H,7E)LHbK?T;P#7L@#F5]Z(>9@bB77O.4E2>TGV+D_8E?5GRd26MZO:00L&_
H0eS.FG/[e#ED?06,?X_TI#Z@UWK(@=-^Zcb(KXQ9:McOYF\DZJZ695:3=61+Y.X
eC_ZS9b=Z#P7(CaF).c5H#Z7+</UZ?3,^@)+N?cc\04Y07T+W&E4M.()?WLSW3U7
#AO/Leae,V3aY(93+81K>ZfN^9\@(J455H+H<C\QJK]GfF&aQ(cQ7\cZae-6Da,0
F,-^9ZK0G6c/,P\_afd&SM+X>WZ]CJ+KJNY6+[A@Hb&=,#U3f^]JOZSa@[cDF:LP
=RCUP<OI?=4?Ie?3b0M@B#PLaO/OJNT\b#+Z(BSfPGDCTZd=fW6Y]SI,+2V^B[;;
.PERaS]Zg#QKaSNa&QgI+1UTQcQFY=^GM2<f,b1H&aWBDf]DEDUE\NO\RZ&IQ\]M
JM06caCda(9_Of][64D.)K;5;:8@DA48^EF=-6ZC?FF>(g8;@:0;O@0X]&I;BWO\
AAT]0-M<XPOBZ+0>eT2_II_B1>\>-4/5KF^SEI:EJW+42[ZZ/>KG1:G>M9JITaR)
VcF2e:V8f=]#bWa+c&c(DMT]R66)@>F/PV\b&]GP2:GM]F,QOJf>1781b19?^8;/
&cE[]TZ:PQ_;eN/SL/74PJQe)XVf&EXa5^N#U9=DO<J=HGFLTGg+WbDB+)1_<PJa
_:S&T.?&.AOfB?B9^U&Y]FU74N,-2@dRC(XNK59(3R+M@1ZDZ_HT,0W8H858?=)c
T&]#ZB\#C3U69<73=525b=SN/CD6.A>STg]+L9#Qb3>V#agfV+&Rg.+]14S28Zg1
?5TJJd<DKZ?XI>0]LODJ[2-QBK+5=+U8D.::&CfO?LL?\gU94cW&L;g;]&_87;B8
FFJe>KZ[IFJ1&=fNZ)aKCG.[+UHL2X[\WNGOHSg/7:Q(RfG2N&M6///+Na/Vf,a(
WbabM0?().OE4gec?)<YT/gCfT?8]J.QMba79XLbK/EB0O:Ldd,Uf7U_a5Vg]G)?
[;R#J>#Y4&SQ-X.QZbUB>VTc^TdL-G>2]K:DC1]J=?7ID1#S^^,IZMP))1EZfO(W
IEISA)@BPPfFESO7fM\fZ<KQ(@gc,^aX5cgQKS<L;.)FC4I40B=G>T^6A3]P4U3O
bR,N8;D.[^6[SN=VVfNI>[I:2E7XR(Q\,+M@H+V(R^5XM0cGQ.3fLYPOfbXH\Z;E
?4/IJZeHA\3G4e((QQZ]/PZ0@[b7H6GbGBE5=L/#D7]Sca#-\\1QaFC5?7FFQNQ>
Q.FAV03#E6f@^?^ES;<gd0S&J:L/P;JgSEIWVVe_J[NXf@_Xb&a#d><O#:X/]W@1
,027G=JUYTdO[R(?/HY=C<d85LD>/WbXL\HD-N-gMTN[fX.N0&8eKgJ(SXP(?57^
P3RT+G1TcfCO]A(>8_dPF=B_9A],L&bK4/\IZR/@WgbUH3^FX_[,-Y=cJ:D8+8e7
XMXY\#>N&a[J.B1d05Y;V4J70=If<gP,eRB4C.afZ0Z^a,?_QDQ]gG;<O#09f3H6
&XMEG6,X/&S=+2Q-cBN_H\QD4cY,@(]1U@GAC1NHO^YH;+3GJ9a7aeB^K40;4>-P
1SC(2[_e_RUTec_b<285?NQ3TWdO[MaISU+)@P/T;UCKKdPN8Q0Z3_R_/_eTW9gM
gL=\V;^E]:@HcB8;6c5R-XS\5T_+_QQJSeY)C/[7C]9&/YJKcPebeYUMRbU#L&53
KUcLa;+[FAUg[gA2YcNFY84f\d@dH#2M;PO?VCJ:ZD;36B:E#Ef#>>#CbB=a9>2f
,a?FE\KYI/Y.X6d8^7dORJH-GHeaVWZTcA-)1f]_C409TM@37a>.gML(g[MRW__&
b]V;;O(6_YS]eBPB5RUg9-HHZ18PJL8P1fTTDPH>HWZJL>@]+5D2W&c+g&ZXX;\>
<I8VS@6.Z9fG5X>LSIaN+XH/G#DQ;C\S=[-?YI)MMfQ:0gC]cN/0UNK:I&MN(XF,
IG_)Ug>SAJ\P0GQd>>@E,\_,]f0\AD>gEZc&#&57-(<Gf8?6I-]:O]7R@dYaN=?5
,E&+)cd3,S3aY\-U;>\GG\7;K:SJ+JFfT1,dTU[4E(95<R^3FfV_E9XEW/V7;]-D
3C2aVg0-FICc?Y/F(=-;+D[54ACZH_)VZ;=1H?63Vc<R:J@<D76,8Z1P9XR\@]A]
;_^B>IK+ECK(dFO2YZ@Y(-G;gKOf34\S;e86@_O@N>##423[0aD>4P=6g2M-PFS&
UHN^eH@Z,AJAf]=28TfTGJ5Dc>E9S1(_A139F44]_/;g?=e<.c1;_4>)L^EfQ#YT
6&RE/9U/TGaWMd5Db);B8M5XKJ,I?7X\X<@Y_6cYJFGBd#:gQ].GXA3PN@IJ:3M,
1T8dT_T^#(WPc+O>SVVO3Z-a.M&+YbZU6a7_bdOWJG^Vg-b@20gU\eJ<7J,_)QF]
1DQ+:7K:74CGTaY@;MU7<VRZJI>C97a6QRYUZa?IDZ:#<d?MS6DMcKGCMga&DN&=
O[2I+YHW6VZ2VR4SK3WU9A<P:(=]Y&7eQFIZf05F9:2)eBOHg=HYU7C0F&_0/^<d
-<6);7;N#P?B486&fM&U>>CZMEF4/W]/24)2DNN5/e8(Yb#F&]F1OD?L_P8EVGJT
V5RNG/N-acE?PfaEHE0E,HKL(4Y&]DMdI.6a7)8OAHPcEB4Ub_PeL]W)Tf#R?_7B
UPHSA4;CIJ/^6\?A,9?eFKKgI1&WYZE#;(NG_Me^IT@UE:=?>VGccS49/6-SWWT[
RTfPBPOORafU(89ZMPH3GM^^K.M9M9IF?gf(/<e(55^g:C]K_B)YPDK_B#;S)X[B
#[GP.Q)B\UM&[-6,+JD,KV8\NaV2/#GBHKaUgaN/\:0\]X^K5Z&b>Cf<VE3RDV2C
7F&PIacJGT7Q8dEOcLO&?2&E0479^DGDYO\g^LBA[U^[E-^K@>[.?B[<e6Bc(I;)
1YdDc#;4&BeFIea^J@Rg<INY.9cS88Z#J4dU@Gc;0&?A_ZgF+Z0I84,0c<53?,=T
Za_SX0E=9P6G?7OA45-gDL@6-.TE6dc-:TPfR(A\8:7<<(\)J2RGTZ>gdeHJQJ#5
0\C31S7fL6+g>I4O,TN,BV-GFQ#@SgGZ_\>.>#N/b?0I@LgG&OHLYT+L&aZ0AcC8
b457T<L;(^@9-(d,D@5J#HQ:())TQ+N/]\SFFfU.bLD90)SH01_=H^aaG-Da6[A7
/EY:9&1:NHa)3&f7eMT9A>G^\:B3f3gBdd]NR-(0TK7\8bb2K>09NZfEafMe]P?2
@C@JJ^T7:?8SSH253>Ea:H)_OD9,<:eXe:@5bK.]^8=-ZFA#,BcSU.[)dI-1d3VO
)QL)gMQ&\TL/PR6f7WZ_FZAgCO(c>=4^/-^,.g.-9E.UY1Z=NdD5Y+9<K[fOC14D
O()&.dgQ5+(9P+/F@K95P+61KePb:b\R-af(3<f;EbJ1F36(B2=ME=O3_b,Y4Y]\
;TP:&=T#C>8_,F:175K#STg7fS6C(f(1/L2;&E/Y2[U31L(OQ9.:)WNHaC8\RbcD
]d4Y1C_;X5MbUgB84_@[\D@N)LYf@)/JUKBcd64fg&/5O(J[W(,/]RA0GQRL:,:9
Ue@;AZC(eSH9#)H.aR7ZHU1dEKB<.,TZB/KHMAX_gR(CcNPE@Uae:#MbIX#d^aO5
JILa[,G-^6F8[OUd,=@4^>BKXaN)A1(?LA,aD,Dd1b-KR\O(\7-bO5ET9[1eM@QM
IO?0TaQ.V_3<SYd+AABV3NZI<C[/75XYBSAT<64cN<2B5COGZHEM:PfeO@YH-4Cg
<31SeL+GD<4W.07Nd0#U(#W48^]]\/.H>YH?L/3+IRY)HR/59;23N_g-cPIC#Da>
^XbU\YOZ3+dAY.GU1\X0AS5:DOX@OJPM@/_7I9A]T-2.^;&3TQLNZ?LaK:UDYbS4
7d^Rf3GY\:&>YD7P9gEcXe(0J/3O55>K6UO=VB6/9ebZ&b>;EYQ3(]-gPKbKF;fT
@Lb&H>LPe&/1RQF9Z?7MC9V<9I[G66@)(CI2)Z#edZ^D:c\5fFQ/Y_eC9IGDX,ZT
?7[GM+RU<QQE/<A#Z(OCIfg.X,&Pg1E2:E:2\?d5TYM6>?#0=\0[^@KO4K([52/@
;eDH@UZ,;[92#VN@1K0HB2_7._^&^X;1,WJCSQUgeU(GCU4LGV#VY;F2B6b)La2A
K?3KK[F:#UO[\^EH<WV?fOH>4X##SO>EIT.J6/96-Ba6:c/?]P[cJR<Y8I6a.@W@
^C23gM?).NS<.FaQHMMQeP^#gL/.\]#)66;A\9LeWf5PeORHX.e/dgD5)[Z90gAR
@c[GgIc6KKfdWJeRE:,V3JBI&RJV:PQ>^R+^_A2<]9W/ET]Y4H:]N1Xf2@VMLW7=
ADRK8c;XV@/g]@NECHZO)/B80\P=01<KD3FM]2?#L9e7gOP>U3[5W1P8XXI_eU@T
/9GER7X_<NC@A99WCNIL[MU=D,Z(+31.d@B#1>8ZW3f?1O]GTN>\B^[38M2KTHFL
XCJK>JXI,7DJVHI1BO9MB8E-d)Hb[9H@?_cTD1ND]6e[MDHU2BaP7VUdWM[D[#7M
cW8453H6+-T6bN4UNZ6H#\PC^18D,04Ra64(F+D>-XdCUO+&KCY(PG7.bVFN-b-S
Y3eQ0c3aID/D9J3C\(M#9CPYX)<:D^e7efG8)CZ:0?^=fT^HPIRBf5]_.g079FXI
W4_L)15X.MB7PG]TW#TbBI<O)JWB\Z&C_)IKJ;D;)@Z-[1J^BWc1_VA[a#SgQL4W
(f[>-Sg&/>cISfN]J\(bV>XS\MZ,5HM8(.@,&CdQ5YdF(dW5T?+<:L/2O\O/T7ZY
WVPZX8Q0BS[R(L<B6Ac>=#Lcd/1;S>Q+63,TVP,OZ6d:[T[)?Q@dOf9A23[,]:(D
671;Q#2EKK_LQ0.WWTIQ1-=Y69LFb.#TC@\S1/QO8#FE6]-SU>O8&J4G0P^M-EDS
1d<1)S[HG:M8D\3cS6ZYEF,McLMFYGYFH5QcJI@#;Y?#F1)3Va6fJON(0TQ0JVLW
&O0<CJ][@W>+6LYXBXVINBd[8/482-56]XG;32N\Ib4[,6^\O3)]&7D^GO#O5R2)
FROHbQAMFEM46dQ7.VLcPJ.2=45-E?\dEa)?b&,<P/S<OQ7)L@;AOD,9>IWc;d[R
LZE)DD;T?CWZVUMTN0;g__52L:Z;PdcK_)3;/Hf9:]\(MMc:52Kf4cGf=VMI#5+(
.2+GZ;8FGXdOHH/(Dg#7/.=>C\C>P;6.8[XEfb6:5MV+WLBI:#]7CTfT-1Y9NP#3
Xc0a[dHU<IRc=VO,cA4[_F=>3$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
