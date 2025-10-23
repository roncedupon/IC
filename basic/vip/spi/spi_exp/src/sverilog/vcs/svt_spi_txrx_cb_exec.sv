
`ifndef GUARD_SVT_SPI_TXRX_CB_EXEC_SV
`define GUARD_SVT_SPI_TXRX_CB_EXEC_SV

/** @cond PRIVATE */

typedef class svt_spi_txrx;

// =============================================================================
/**
 * SPI TxRx callback execution class which implements 
 * the cb_exec methods supported by the TxRx component.
 */
class svt_spi_txrx_cb_exec extends svt_spi_txrx_cb_exec_common;

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * txrx component which implements the callback methods.
   */
  local svt_spi_txrx txrx;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param txrx The component supported by this instance.
   */
  extern function new(svt_spi_txrx txrx);
  
  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction out of its
   * SPI Transaction input, but before acting on the SPI Transaction in any way.
   *
   * This method issues the <i>`SVT_SPI_TXRX_CB_EXEC_COMMON_POST_CB_NAME</i>
   * callback using the svt_do_obj_callbacks macro, as well as the
   * <i>`SVT_SPI_TXRX_CB_EXEC_COMMON_POST_CB_NAME</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the transaction descriptor without further action.
   */
  extern virtual task post_seq_item_get_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>pre_transaction_out_put</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>pre_transaction_out_put</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual task pre_transaction_out_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>transaction_out_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_out_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_out_cov_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at TX.
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at RX.
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has finished tranmsitting its last data bit over SPI lane(s).
   * This is used to update the data content dynamically while current transaction is in progress.
   * In Master Mode, additional clocks will be generated to transmit the new data bits.
   * Data driving to remain as it is.
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * This callback is currently supported for SPI-Bus mode only. 
   * Only svt_spi_transaction::data and svt_spi_transaction::data_frame_size fields are expected to be updated by User for this callback.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */  
  extern virtual task load_tx_fifo_cb_exec(svt_spi_transaction xact);

`protected
8&64N<d?GV@@c_Q5@bFYJ@;Y)&4^F;^W8RP[J=./e[&W,,&+DHI^7)CGeC=fT4T8
A#<R@6F]/>\JV@FR#eg8fY\A7Be5QDd9L-Nb7Y-<D&G(+S10bceY2a;U]:]HGGeO
M5<M,g?HbN;;@b4@f3SLC6.eeH.0P1-,@[T26>U;;PNVaC]:Kf6\2&;UI$
`endprotected


endclass

/** @endcond */

// =============================================================================

`protected
[<LPcMYfP-O#P<gf&CZC<^M&KECM[;P(0[+>(X7&?(L5?E(dWbd14)XB[H33bb)W
D?(:8M]ZZdKO#+6)L;QS\-d&8)>4E9[dLQ_XWM^@TABb+[]g]CPG8Z_=(,MC1#@@
cc\1.,d)Q/aHP2PfH2.9R)N)egAbLS;DD#=));VWYL,MHN_8-4[<ZZG^_:[8Z@WU
[((_V^93Ub_H0$
`endprotected


//vcs_lic_vip_protect
`protected
LQ+H7#W3-:#\T^<&3#;4UPT1^??MVZ#>D4@HL>;I=-SaVE<fX1GC((0O>\(b\(PO
bLQ>QR0c1P8QMJbY+N4FQZI.c5\+X>V^DZEKEKCbT;5HYB(R-PXYCZCbG85b\()O
1Y6^.TIP7gW@=O[LZ9W1#IZH4:-JF.cPPZ:7\R,S]0P]1U1UDS45AXH2\_JD8CUF
=IVTL?C#fR_D-NDABGSLb<23N(;<J-c\6>:XA^eZc2/<9cKDRf\/+cY(D9G1Md36
01b]]?[CRH>SObH-E86WM22&?<bAb7Ob0=O/aGRJ&DX2d_X<]Y-TR_TaCCSXTCPD
OeBb]7J/ZbV#db5>WBPa77SHUg\fSaE8HNIFXNPdggEN>@8TE(.17CD[[1G1g[_C
@D0CUfA05N0(<3@KeJ_4Q(<cK&K&^f]88ON=/[/7J1)?beEB7d@:G]AI,[aR&4Vd
a=HeQKA[(_1VUE;5H/a&T78=5LRS7:Z.dA:C+G#KL.d_8aZ[/9X8+2G6VOR.G];3
NZY/=ZMEL5,caS7Ed&Mb.D7:H^LOc^cS#Q)\J^8@+FG#3MHe#fY]1<UM[HQ@EZBY
Qe<5FVXI2)-ab^:76aZ[TY,2_PR2gDR^)+7?3H,]G)@R0d[:;0e,De[<R1TWKR=X
,XM3Z@=ISP(RD9\B4Cb0-\-RRf<LM8BUaYXL_96WLU91fY4:ZK3DZB7--B8OZ;+P
<F7P9MMAbFcYNDBJL?89CVRce,JScT#(:,?UL4RT1ORLDS4G\.7KB>J5a;6Y#3Jd
_9eX:BJUT+?>&M@CY];PT]QRcX+b(JUA#)EE[&a9U(O/T;]V0>-aJG.F6:+8DVEY
PQY2@Kg?K@M0g1Ub),fWZM8+WOEbP^LMU@NSfb]>TKgIac44UT[<FF)D<1>[g/W;
WAgS=59=JC7acP#]3).07d[gMcE;fY<a8P,aa,JQC#XKO:aJD4?#;V[W<&)&9U=V
g@McSLH+/&]#DId&Od?_QPd^BZR]GARbGG_SED\15@\AKa5KEe>CPHUg_AE_Q8+@
&#P1=86CFR3XDQUC[2SODa[>K&56cMNR6eY:ZCd70aYX-5[-1EX=K-&OWf;X\P)8
:T,K;15(HaF;YY/)[c:OU8g8A&)/P@D9(2f2Z26,,KM?A8N;_P1P3:?>--b?==9b
E^/[7?9E7EA>@a[>c&=TV#8&a6QGJHT->WP3>g]Y@,9cP.(&f?8JC^9\9AX+-C;A
MUUT;_M;?KEaCS@Ig->+?\UNJK>0N3CC@H(>gEQf2T9[?<:e@a\S+(BUUG3VeW#L
aa4_.8&XTU98UN76dT[&7.&_?6F:?G<M[JA;<_>,>>V;RcY_C[Z?:]5T^F=^Ua1(
+P(&]FF#=VO)VHfD>WP1Z+ULc:RYg8]MF5^32LXO(?YVH<bb9_3]?/<\XSRWNTPT
/JK3Fc-)e];./e<+M,]>@&Z2K:8+IVTU[#8(EPR0N[V0]2KG7&5-b#-TOZ[N.7[:
Y)7S),L8)^1(8&XUT-=7f9[LN;:O:4XEa)@/NO[5dg^PYNXD44(aNW0\e21?V-5/
<bI/2Pc)@Y;>DcFSGFXZ:K+;Y=E9=eA--6G6/@fI.\&X61@1Y/gSg#Q?.FWF:2SL
cP\KReY2>;GaB.2+X0QTI],:O#022QHPf\#]&<>R@36JC4RfTQ)J]<Ob?N)C0A.;
QQMF@T#V-&=D=W@=VYEH]>FCdY:LS=eJ_+V\ca2NC0G0U>Jc)HPY1ZX8I9(BS>B=
H7BA8XXC_1f5:JVaNX2>YESL5MD<3DA+#3bP8Q=NKg8LYRW_/C#68P3MI>;_4YU/
a@3X.L9cEP0b[B>a)3Ye_SEX6;S27X<d4TU.B1GW78BPJD90a9>+-CMZf(Hc:-Y7
REN=QR4Y4W)gGK\C1MRGCcT)8U,D&C7T8GV8G,HUSGJ.+W4?E\]M5fg\Tc6c0+Ob
;,:,EfW(ZF>#\\gP?f.Z#AQ11[_2Y:1bF>Hf8CB]d7(:a@:]6>GM,dOgZZM^(G1Y
aNU5PCJ.YE7?+/-dD/;N8P]R^ZWf-0ZQ:?:-6):,bA9^>]KcM0N10>?CBZ,5WY1\
9Ra:a;?/^Q_5>;D7<1YY6YP)@?9G;+DK,&[?,gWOZKAIO^J2P+E=YA);1V<Q-@V.
_^#O0J9.6>4,P(S[Z;\D,X:&4EXD9:L?)NR@WHdc^M(J^Cc.Z_Ra\I+4]H5cJ/83
/O#bO]=.df(/bK0ICI4T//c8(ZJ#e9c>c7J6-?E40XY(6FCL:LAZJ.XTX(b8@RI@
Je(DTKbSGf^#K&_TE87-)ANAO)QgWIY.d?DGc56#(L;e0GZ&4G5;#U9[;=Z]/^X1
d[88??C4J;(4Tc\;>KM;HUf-(=PcRW:=1D-7L3^IS7-0Na4<a<5[/IB>=HJGb/@(
eX/+X01NNbed)M/8#TJe^LfBG&&(V<Y[>PDLN/Jg_F0=.^JIJfg_8U;3a<1BX8BN
PYa1fU+/EYY(QY/&[G8S^,R3@NfP3T;,@,Rg&PS(gGWR[Rc>E+.52K812^F.+&^,
JI80SO<]U9d,8AgRKBNKX?X\g+&Td<C5JW)bc5FF=W(_DO^c(5M+dCBAECIP2ZV,
>XM(R56cK#<cKCUL\Q\F<YUE5X:W70DOf+\7TEO=>PTfUWZ4HJV=1VK?FGGE&H_?
Ib8I1+C\I(2@1@\]?Pf:@LO3<8R6GKeGTb-aFa,^,-[c>#)7JQ,217WQ-OdWEWSO
E>Q4d.YgfT659gVDQccK7gMF^XG1.9]]=SR.7b,NfD1KFP_75de81;2_YPAPf;T9
8V/aGJ;1K()F(c3]OV,@?Ca(+6,U.JB,.YXJ#7>LVdI0,L.<)DAV_/E?a=6SSW11
TJ6ed;C:4(KEWfIO1A?)4XX])?4c?+;O/?Q_<1S/X#0E-e86OXSf,^(JD6I=24Ab
V/GVg?Q\3Q-8C,CF5DR>fOHJA)XLM;aHX80Q88CeZ-VPOSaZC/@Od7.S0)Se9N5/
@.5M?+ZV=VU6AK^Y_+6@,fS=FXJ5.E1HQe>>&e?]<P&60TEX[(PN-#^./G>aJb4A
=K[9SU,JSdP(2)WQS@&@P@1L4WeZP<,T1Y@BVZJ_V_?A?PPAd..Ua6S9U#,bVUM.
_(^7T]6e@@LJ:bA.FS-C_^37ZKF>G_1a<T^>WX)7_CMCD?L8/:=+NX)-]+XZ_-\1
VIY.XG+:dL6C^T_,9@491Ed2213_eed[(6e03S]AQcN6f?XA3(R]M;4OPQbI7VB@
0<.UXBDNQT1&4S+@TZ9EE5dYf-\:KPTHC7>N5dS175H)GOb0>a^2C(ZeN96R3.99
H\JZc[.8+K&O^[ee2Y)27IA@Qb/OA48&R-AIMN,,T9F78gYI+8NF@aD:;#=d>@L#
T4a).]]d>R?\R.F9)56>HB&aNe@6<#b>/6H6&g>LbE<-6KK+IVBLbOeYR_,J\4>[
3ALd.-&N(H.VFa?HD9N-0/6bJ<W)01CFDUgXGa<4&RMU7N,>S=cFDJ9&F]OfC=N=
WI1<+<R)3\GRLV#gM#Q9;^CEJFHT+.N;[3.)6gP,417WcR9:)6&#XN.eAb4,gaf.
d+7JGA_5F-U?=L;Y:;fZcW-]V^O>([=?^21c>)c9XNCT.X-(HL_FGT0;00?VCNeH
XVY1[;^ST9C<-D8gaN)#G8B3XY?eE.L.cMA-;+(EU)aKMGNNXL]EMVYP>+<8#I8,
:TEUaYKJ^?b+\)=V;XcV^UG?8#,B9Cc7d^.BD?OH+^N2@,]P[1Ae-94X6-+V:\>O
aO?K+BcTFXM;B\/F6G3N,dT?B^Z7K3WGJB()--a?4-7U;AOdEKFW-]a0PWJ2PF0N
596Z>)/#fBL+(>DKIQbCfW9824EVX+c1dR6TY^@FCDI[1]I:/._B(#@]>#G+D?HJ
H<W@1&T[:f=319R3#UH+fQHfYOLR-Z?:?U,VLJWBd<>ENJZVSW/,gM=_gZ\S/^Oc
8,[gWdO2gL1QIBU#d8>#[:P1>U/6D#SS^FX<]4TCdEKICbYd)GdC=H<.WSbAacJM
,OBMFAF7VK.K@C.)<>CK^&8ODL8_2:9@3;^@VJJG&CdbMK_d8DZaH95GD-J[7M#C
B.<.:B[A9H/[f1()_HD21H:/(dINfC;)A@_1g1M>.V=_9>QXd3L0BfRdRX>8^IJ1
Y55^AITO520\2>HB=Gb>YTeJa1N#Qb:XUHZS)\ZW_F>MN101EO.E<^6K&A(?00I)
dP47X?Nd[RYM;1#bM8-EFeD7FMT9cF)<#YSQSEO:V]E.E2#40W7\T<?&>^R1-,-]
Q4UH9]NY__Z)6=(4#83(3(,V#LPe8<H:Wc0:Uf_9-_)QPZ8].IEJ7PJ4ZWa=U4TE
LOW+GdRQ8[eRJF,[B3(Z&R\aK:A@>)&E2_7-F+?A7O93W6\PVW;03]-b:?Ac/TL7
c,??N)#G>05\T9RM_c8<8>C\/C(C]JY2L<.4Q5M/LLd:S>7=EGI8dXQKUEPGd_FJ
[<,@B,I32:.)f4&?6\-dbA7YO4AR9+U?(GEP902-T.eW4-@.M3>I73fXFVXYNC58
\W<;@N<6/Pa0J\?<H=6dT=)CV,O(f-5E2=@Z]]9N_VL9\-VgJ6e4;JRZ,<HB0^=a
=aN37YVANBYBBXLgT3gYLEGJ&KU;<JT-<@;g4Y/3ePSLW_^.)AKZFEWW(5RL;77f
.143^C#e3;+aYL7ISSbV3A&EdU#,6+&J>09WCP=>UZ3Q;R3,LgMD:9DA\G]5<7BY
SB[DaN;0@7(+c1cPMg1L>>O46@BU6F]B+)K]YS+=LY5:2U484Z6=)[;/gEC74&;,
RO&:8F(f)P<+GI#HJ_RTeFbVFNB#?JJ7,E31B6+<98(LU4L_3AC/Z+:WJ#0:03ED
0T>9Vc,H#)VUGEX&KZ6_;gXG>fZ(g^75ASLg;KW2):J+/&YLQ29=?IA5^FMO\QXV
QF1b1))X-GQO<aND306,=fPS\4I9Y4;^<#D4=6)]9U]LT(b\::gS.JL3CNC&K]84
AG<dG:1<I=Q2gU2K#QYILS-9RK_F_+g+Wg?GBMBg/([gc0SSWYJb;&M]UKT3AQQE
^;AQEUg?HQ0@<2QFM=SF(E.Y9T1I1SCHKKH7GXTXF9^QJ-1^f-1,:ZCY)OYGTZQA
Z.AV;1T,)N>_F&2/c7QF15C9OJS;dT<5,>BH[,B3S;J90b0@:_ED0Y,P?2&V2b5S
GMTC?H_TD_.#\_^cV-O;aM<Age=#EB[U3IeS3LaV]OLIJ@.:UD^g;gdBPBLBa/L>
UdT==Z]Wf]A/EV^,a)R@BBQEfQ4^>,d45K7[>MOVFJQV,<SG:4I8D#8Y5IC#Ic2E
CCJCFOF8d[A4=#66-;bG+=A:#?M/2K3\RSZSEWN7NDbFEEJ41^EVEGdYd<DG/C=(
g>We#Z->3E3>XT9Y2B9Z9D1;=>_J3C,<<[JH6][<76HN3#F;W06fB?TE1ZKQ?:d7
R3BQVXMA,R7Mb?dC]@O+OUL=f#8L[1_Ua&e2IR9]HR4;&T)\R;,F1HDBMfaWH@<g
S=d7KAZfC?#ZH>A(,>RYeF_/;-6H-V4E[:cCJ98aW+SPK(4-D8,0Bg&)7]]--;_\
EI6Gf^C#KQT-S#f^#(BMX-.<=_UPf.VKB3K6\Q/T/20.FHO@:9FNGY&BTM2G-9X?
HBDNLS7P2Ua)I@J4TFEPYMDZ)2FHd=>:0,R4.UHRIe<;)XXMdK</WUFU0KL;K/FV
TRUc]LD@GNIO6W2YP3#Q0Ha5cf1HTDE(FCZ/4C]^I=/d/dYd4dE<LXHR)[FXDQ6V
U<f0YL2)6cF1#W#d([?ZCA.IE3N+G-IRbg-N1DYa/)FNAEXKaR\IFg=N9\BP7f4a
>d9+c[KB(WJb]E.O]2^fFN8JIME\O;RIUc3Z<WTJ</YK<3<@DT-dBKOac)HK888D
F]8BY.Jc=NR783Y9U&@5LQ:_9WKd>KG\B>f[Ke))LVZV6;Ud2IY+RGefMG2T>O2X
3WR?O.SD-c7>2,V/+EY+=O2P]48X.I1f\g,^aQW&08.9HV/J.IZ3B/-T7T@KKfaE
<cTc]W.H][Y-V_g>[g:]=VB>\O>[@]K?>a<B;GC3(9YdQKH?_VHacJ9.3-7V^PPK
0[2O]^32:BfWN.J1JDY/@0>dG-M3)MQV:E2_KTI-7)>&6)MFUdAa^VE)2b6P?;f1
;<KYBV9WfZbMX@STa#;5)QP,1QW;@JYY7JR:19\-T8d?EE?IPb#gQ0>8#_F=_9N7
5/VYKZaT>U,FDI0fX^RZN-.aBIb?dP[[8@+_f(gS4Nf;+aHKPF9.5AMV7X_b(Me+
^D2@#+>>>4L8AA#RTGVdRdOR4U3?+U6CO-FXN^@F(UTE+.GJ67NNIJc^6V=L(#]_
FX1GWL3ZX39DD\eUfGaRY\LFCM6HMEFF<PRXS&_G?_QO4Rf,SA1#>@.-g?;QFOPP
YX5e4S9-aGY,&\0ePWg8HCLAD>-^.:c&,g\]J_JaU<Q?;B[+Y46QS(O-@D3L/+Sd
[DP/2_YWEC500R7]8cQLJ/,JK#CHI:8:EcS=d_+G40QW(^S1L1[?TW24:)<6ELFT
[UDO+H4XRfXP;373&SFf/J([+M6b+#XVWEH&:4a^gYC,2I>1T1#(fF<JFY(Zb/&>
ZMP2?JOUJU8>/WT9]6NP#Q4N97=RQ_L@2:S.4=X=D5=f;?&_QPbM\Ed<1Q.S7ZGU
<7I6Le+>BO)C.,4BPa3^T46JS_e:0BJH<5C]S.GGBLERQg]4<85)9.Zf++6_Q+G9
CJ85Y5D3,)9TVYg<F2afc_+ZRIV486PMF:Zfc=Of[Q6a4RW[WC4Oc>_-C,5PgQ_A
=ED8TQeRSP;=OWdL-O1,]SF1_GRFK(DQgQ(6LE#=8(5+\R37HW>+Q1M@7VUdZ9H^
J[P29GN^70KeF?I)gGE120P5N))_QHU@#FBW<c>R:_6Bg(TH8VBKV2O_UR_L[:W4
cA+U]IdJSFN7-fb)PMU1.&Z6=@c^\]YC\.:D6>MA?eWGWDe9,8AXO<#WbN1LWQ6S
P5R/SC^Fb0S<CKV9,+4+RbKM\UAW,7V9MffS?c)JY\c3@U_+#)^EEDa8TPJ+GHI?
RQFd[?RMW9:cJ(I[&c7f<K,EgQS>@1/a6daD_S3Z>)G.B9Z0Ba^=TNR;.aePg)&6
<.SZ)bfQ<IX.GEPDe/ZN(JU7_Y;g\F:9JBXcAea+<#S@SJK]_f@,_)\.K..Ub8].
2A8.ZIcD:VH2B9E3+N9XgNMA5)-:G_b1Y)#[G/f\eb?N>M/+L&_<;5a5<.5M><fe
IM1R/_a109[>DD526fA)F?5QC:WR5N^0+(?)-S:aH3385Hac7Wd+#?N6M<7VR&_,
g4_gSgfQ5J^A(\b9Ff]>AaB7d#MR:>@I7-Na(C:M?51Q.S6G@&G6#6N6N$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_CB_EXEC_SV
