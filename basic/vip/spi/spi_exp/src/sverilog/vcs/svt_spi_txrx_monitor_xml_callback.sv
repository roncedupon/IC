
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_XML_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_XML_CALLBACK_SV

// =============================================================================
/**
 * Monitor callback class containing implementation to generate XML
 * output for svt_spi_txrx_monitor.
 */
class svt_spi_txrx_monitor_xml_callback extends svt_spi_txrx_monitor_callback;

  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for svt_spi_txrx_monitor. */
  protected svt_xml_writer xml_writer = null;
  protected real xact_start_time =0;
  protected real xact_end_time =0;
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_xml_writer xml_writer);
`else
  extern function new(svt_xml_writer xml_writer, string name = "svt_spi_txrx_monitor_xml_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_xml_callback";
  endfunction

  // -----------------------------------------------------------------------------
  /**
   * Called when a transaction starts at Tx Port.
   *
   * @param txrx_mon A reference to the svt_spi_txrx_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest
   */
  extern virtual function void transaction_started_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  
  // -----------------------------------------------------------------------------
  /**
   * Called when a transaction starts at Rx Port.
   *
   * @param txrx_mon A reference to the svt_spi_txrx_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest
   */

  extern virtual function void transaction_started_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Tx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Rx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

endclass

// =============================================================================

`protected
LS>),HD#B#OQ>Ua=K,);La?>8F?BO6ZF/\HR,/;RZ5e85NJ5W+\_/)cX?3fXIF#0
;Fe2WH8@Zc.f@FV@Q5X=LB:)@JbK&1I2S3REXWRFZGF?8;.>WJI3/U=:/:D>2YVI
KN(7)7@J2=eEC(>?)[FEeB3E.\Y7V.A[,eIfHZdJ25-0I)gBDL)3b(ZDE>Lc\/7,
5FEQa3MP,T-aK\GZ^T/X,;,C0I_J>WBIL)Z/fYAPM9Y+[.X0B0U]e487<0,#1EgM
\SJ(/5DUUU;#1e1)R&gU#61#<N<H/31(E]gH_AXH[(1eUDF;23edaX:fZ\d&AD\D
B?8>6#I3QeL1&4[LMT=8Y;?AaP5eV)bY&C+P>:1QaXJAA:WHO(N#P@8dW6+34YYb
)dEZ9(5-=g39-#4)PZR_EWUU8JT(F>.L?8CLDa=YCRTRN4Q>>URP2DM-K9gPFR)A
2V<]T1bC@/98,418&TI,5Z<GaGf]6EEJ=@D82]==00Jf\/7NY6-:2/M-I$
`endprotected


//vcs_lic_vip_protect
`protected
NR[0_DA@64OW.?E)X(R+(U3_a>A-=67(&fBf1W#^c]5fPG#X87?]/(cIB<b3F?O=
&,e/>X(<WgQfV1cG<1IgB81@QL\;E4NMS?]4(5^/aRB#)aTYW,bK)LG/LSSM),+_
1#ZPW&^=^^8PN7O>9e7ESEc7UW\>2:Kf[X<29Q69/+0MF=2,80ZXKGa>W#Ef,[I_
>TW?F54HK1+?Jg/WYGXH(0UY0Xgb?H\)G<RBW\QG]):g_FJSPS6ZVTaLM3:Z;_Zc
K4aa#_0YKP+]K4=;?^[NeaK52cLeX\WHUOOHa_bV94\)3V20b?eB_UGL=VdV3>4J
8,^OF,WI<#H+&2&\)^TE57BMDNO)AR9)7E@e_I1Z>-OU:03P41W@.9eZ)=-.ecD0
dJ#&a0?2cG2e5>:Ha>>D:?IS@0T5.BG+\cQ/Wc0B^b.TFbGQDI4^fF3:3T8D#1-Y
(B7_:[[V<E[,d4:.^a50;FeafWIUG9;Y]De<20g=5d-Y3438.F&\#(O@1^SDCQX4
gEROH,T[,-:V[RFIKH+A_EN^;GSN:[:2CC=^T]db:=PA?PMEO)@_<DfgA@ZYFLQ5
-TR9)/E<&-I1d&e>:,adWWW(g9be,IG2YG8==.8<TV13S;SbPE\g0@5?\1\N[ONQ
b,#_;1\_NAJMM[;R0X>U1PTLcb\XW\,Ib9NGWT2cD5F07<4VGP@AaLP^e\GAS1eG
H><GbTTY2&OB8fB/Of)ET;1>LaEK.XK2IR_\8O\e2#_PXSRODM#037[N-/\-0:0P
1MPH2<[MKT8/H00X-R_@8#5Z(P/Zb39d;;U2.Na]eC,=B>D/L71[7UWI[(A(LGY[
6NJ5I\3HMBW28Ff_#=//3.a[gVNLATdaCQJc((+Y@,[0I>MR/OG:I\SH2eL#<D-b
VG5HI;O3O6XAACAB=RJe=(\8.?Uc8#(/S;-dBX^T30[-H9F\FL\gW?\KbJT#ES+C
0(aFT<Y);X=MH+NCKYK_Q?CXV,_^-T6g^DTA.NW4Na@;K3^R^,M(<__517Q1g[44
X:J0:0^WB9K/B-E\D+aA[NQS[;H1P;3,B00cLG4_GPJ\abKDR]W4[Y7d>Be>g:EO
IO^3g5E;)QTRS:I?&)WH_b7.GGBA=)eV?](D3e+:\RaUO8Qa.4@P/5<5<IBR;S</
YS-bEV141:35efb>^^-1QbJ;]9H@Ma?&&Hd6KgJET])@(WA)<Kf=C&9_)60a72&G
UK\:OO6TUg3(Jf;?;QM@;HN_b35Mf8PNTaL2C2FQ,A&>=_=Z60H8KJCE]@D9B7F5
YN=P#\FVG(H\8MX<Y7K\g3]4#/2,ZA.V)I=(ce17T;)ZT@@6LGD:2f;;&VB=S8SK
A/@9>JM>aWAUdU6gS95J&>_a38H1ecZ86>&KYTfMXJ.?d61c>GFUCW2cV1.4DCEM
,Z<OC<I^FBR23#?/O@JR.@]STW#]cJ(S?IXfX3(@YeN=;90VTH/PHf89Xb-?IR8F
NZZ03\Mc#]H,(7(R#CBES?aIYJ0Od080:OZ:/3::2_fY19LcJ@MT30JOIR5;GC;(
V24]>TN+W#X<a5eFTMB30)DOTaW7c>QZfN>0[O6b4gWTW+5P/DW#N\\9QH-Va[Y;
2;,N1K=cdZ^6X0Jg)N8I92d9DV;CfX^)cbO5G80f)6JTLD5J,SF]aOXC<F^@_W?B
)5G8bNTd=4UbAH4FWVAD8O)<1Q[Wc4I]gAJ)7ZYe]H+a,bgLV2fQPD\+)EB#&f-;
32>g<_+XbQee[T,Re1Q<&gL+g<\]ZJPJa_^M9AMG18T8[_eG\DaDeWQ14/;Q7]R;
fH;T:YU=XB;C4GcI-/L85#^[4e<QGUMCJI[K\N.OKd@0a87GM2.RWMIa#10HM9&Z
3^a1EYNfO5Gg@O_31&A6^K_\^8ZY7O91:SbF+)1F(7Y/+/ZGU]8#_6>XBZ^f@d1_
/eAd0<?@.OL6U>YI1f(a(W&I@#3D/9aQdF^8(1<4\^L_PdgTa2S3=cC@&,Y=U@/U
9+Z:7^gBFR+^<Q)2(?Y\:DI5g1VI\a^NTP;#-,K9X[S&\>#ada]MKcH_VFE.aB8Y
JF&[Jf9YZSKYb>C>H[fJ=0?_6B(E&;BC&]8f3ZOBS>SG?MHDe[WGSf=<K-M;b)C(
1U[MR>EE/CT&TDZW+a,FFQ@AeeSa3<:KLeSM\KYK9085@ML<,+S[Qb]V)2Y#=>\c
U;P-A.]EN;K,E);A5U6LXYP;-BD?:GE3@)?cQ\(3XXI+^GVTD0S=dCc90^ZQZMA#
FO?/P;Y\)LfZQ/Gd7gX#YgIUOf?,C_aD^0<P_#N0XVdTfHG>XVYFMU(Lf3<);9^8
d^e3K+d=&Jeb&IgG7XR3H)b-JM&I&@/&@7UfMcVDFL.&/f<QT.4?_-NNH5:RX0eb
=:#M5IB\JSP+Z.51)Mf8g?eL#@\#,ZYBO_P+YgPV^bO1YX/aBQ6VQJGcJPeG_G\F
1D7?J2<F=#T<D]eZT8]f2/2Oa4ZB<_2dDe-Z&[-WZ?Xe1EXQ?C(0HX>BG&9:66,B
dFFFGNAMWLZBQFU8I5=YJVZ6Na_;@-S)0\MU-X[eRF#+X8THd?DCIS[<IBZ]M[YG
a#0LG@d10Q&e#OJ3f#-2NcRHWGWR5G-HS-R6(6:H-8d-3[)LF&.;W.0OOV[JQM9U
65E],)_2KN58YFWBOJF+]4+]8e)FEcMHfS4L;[Zc+=<6-YbE:,U6]-TE9Q1[WR^M
ID\:]#d\+c_&JG2=WJ+A/[c=bEMYX9VZc.dJ\M2&Xb/W8QR;9M,PZO8O]#XRUX]d
<RQ9V+6-g3;3)KP#dQ2?8F8N[_//IOAI.29M6CJZ>V;E,XZS1ZO+NTB>-11VQ;CH
2/PLOT1HDgCY_4G&LcfJ9e=NB]243#.FXGc]JMTI+7N)L;,ODgUOKMe<G)L,H6:H
??IT-9+MdC-Y0$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_XML_CALLBACK_SV
