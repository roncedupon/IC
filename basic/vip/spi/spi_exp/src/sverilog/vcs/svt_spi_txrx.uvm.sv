
`ifndef GUARD_SVT_SPI_TXRX_UVM_SV
`define GUARD_SVT_SPI_TXRX_UVM_SV

typedef class svt_spi_txrx_callback;
typedef class svt_spi_txrx_cb_exec;
typedef class svt_spi_txrx;

`svt_xvm_typedef_cb(svt_spi_txrx,svt_spi_txrx_callback,svt_spi_txrx_callback_pool);

// =============================================================================
/**
 * Defines the SPI TxRx Driver, used to process
 * traffic in the TX and RX directions.
 *
 * For the TX direction it gets SPI Transaction from input TLM port, process it 
 * and send it to the bus.
 * 
 * For the RX direction it reassembles SPI Transaction from the bus and
 * then delivers it to the upstream layer via output TLM port.
 */
class svt_spi_txrx extends svt_driver#(svt_spi_transaction);

  `svt_xvm_register_cb(svt_spi_txrx, svt_spi_txrx_callback)

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * RX Upstream TLM Put Port
   *
   * Provides a mechanism for sending SPI Transaction that can be recognized by the
   * Upper Layer. 
   * The handle to the SPI Transaction TLM put port can be set or
   * obtained through the driver's public member #rx_xact_out_port
   */
  svt_debug_opts_blocking_put_port #(svt_spi_transaction) rx_xact_out_port;

  /**
   * RX Upstream TLM Peek port.
   *
   * Provides a mechanism for external components to retrieve SPI Transactions 
   * from the TxRx. These should only be used when
   * the TxRx is the top layer in the stack. The handle to this
   * port can be set or obtained through the driver's
   * public member #rx_xact_peek_port.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_peek,svt_spi_transaction,svt_spi_txrx) rx_xact_peek_port;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,svt_mem_transaction,svt_spi_txrx) req_item_port;
 
  /**
  * Port to obtain the response packet of svt_mem_transaction type from
  * mem_sequencer
  */
  `SVT_XVM(seq_item_pull_port)#(svt_mem_transaction, svt_mem_transaction) mem_seq_item_port;

  /**
   * Port to obtain svt_spi_service object. */
  `SVT_XVM(seq_item_pull_port) #(svt_spi_service) service_item_port;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the SPI Transaction is first initiated (TX) or recognized (RX). */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED;

  /** Event triggered when the SPI Transaction is completed. */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED;
/** @endcond */

  /** Event triggered when the SPI Transaction is first initiated (TX) */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED_TX;

  /** Event triggered when the SPI Transaction is completed at TX */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED_TX;

  /** Event triggered when the SPI Transaction is first recognized (RX) */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED_RX;

  /** Event triggered when the SPI Transaction is completed at RX */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED_RX;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  `SVT_XVM(event) EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

/** @cond PRIVATE */

  /**
   * Response packet from mem_sequencer
   */
  svt_mem_transaction mem_rsp;

  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(svt_mem_transaction) req_mbox;

  /** System configuration handle */
  local svt_spi_configuration cfg;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_configuration cfg_snapshot;

  /** Shared status object which allows components (which each reference the same object) to communicate state changes. */
  local svt_spi_status shared_status;

  /** Methodology independent driver for the Transmit-Receive features. */
  svt_spi_txrx_active_common common;

  /** Methodology independent callback container for the Transmit-Receive features. */
  svt_spi_txrx_cb_exec cb_exec;
  
  /** Peek Transaction */
  local svt_spi_transaction rx_peek_xact = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_spi_txrx)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON | `SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param name The name of this instance.  Used to construct the hierarchy.
   *
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_spi_txrx", `SVT_XVM(component) parent = null);
  
  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif
  //----------------------------------------------------------------------------
  /** Connect Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  //----------------------------------------------------------------------------
  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

//vcs_lic_vip_protect  
`protected
G(.,f\DA7ATO:KSR0VcUF3+X(VE[=X\0QKaTbeC3S?W[0aQ.L2>6)(YCf=E>3+PA
LWcc?YV=C&ac\SW,7KGSJG=IS<97\W#R=TE[H84HHINcdEXCPf[I;-:I][\.a.eI
P)&,EbB<U^7-aLK/U60GJ-<Gg)dANJ/PS/:^R[XF+LdY?0dDTSVb?c6P/>3-<=_Q
;TKGW:X\#,f4?2dc#>.F_,G0I5T+RJaa5XfeQB<H@>0+U6=Y:Va6dKeYf79(LC(H
X7=cR##H[K8<Z0f\YZ>/C9L3ECCSBc^4XC9UETJf_]+G6OIKA]-b:,fS6]UG]H&B
&\Uf]BK>_d@DffXa5P.]\?(Y(;/_6P9IGPX5COT7cg0TTB_KJ)R_AL(-?-K>[O&6
L&37d,3S&,V>@]IUT3\)E9CO?>XRBL_Rf]^Ib;C]PdCB1B3;O-+YdN)b&?S+_b9D
J/+;L7RRb@X[BFRa4EL0<a9YUeE9<ae-CHS/9;//15V++@HRe61F)[fG@fV0AHW7
)>>OEF)24T\Uf45Z=J5KJZRD/ObYS8H,HZHQ)ID24ZW/(gdVeQ+;-RWASXP/Z[W3
[V.YAd?(X\geGSQ>4Z-XDJ,aTLM&a^UEP95C@7&+U?1JV0NAQ_9A)]D@5Z&9f;CP
Obf.PFFA_b-HO4@R0//O->7^+2OJSW2W]P]d&/JJYF:[@GN&@+2M3@&T&B/Q6?Oa
?SCTU<DV4UPI(C\YUND#^<&<)/CYb?Y\/3V[d4KDB8V0PK2TM/L]8QV7WF9#(<dd
>P84Q@g+E1;.Q;O^IIa_H?&4fFA.QdL4;1ROK@8Oa9FO+PWf)MC<SA,<@\HOS59b
>;,P(K3K4;IE:HYT++RN)A6^IN_@a?1(8Lc-?^:gD)c7N^MeL;Q:E2>@6;[(#P\S
?[BD#;JS:<_4]@U#B&H57S7aab?2MXG9L+]_N+SKeK=gI)QD1]^EV3)ALOQQ6#;Y
@7A4>]CX+0>e?,:,_U7CM-41c?E[BXGRZPK37(OX7E\.dOFU\\AOBZ?@E2?Q5fKB
99GCO+cY5070]AA?.ZTWU)PS1>Y&RM@TM5gOF6J[fVK6R@V7J8X]9T(\JMO^cC,a
J7Z>BS=R5+c@=gGJW3&ID-Yfbe1P_<V>)Rb4)^^[B,00_2<Xg-\M1bNI3D-O3:BG
+]d^G[E90<b#ET.eKV#NR1cRMf/^\=D7XR,::5:d>,/IA:O/BPRLM/[1e9QMMFg?
K+<IR-XQH[939/:ANP0G1<&C7Q;(9;__EOEK?0//;7d:EaT9)\IX[GYJ6[0_D2CF
F054LV^&/0T5;HJ(X1SU<-;=2VTVa=WX>8T)V<J@/(Y(P5&)INZ6Ed#E5;-KDLQ#
aPOa9#gG?CJY;_)^?&S.5;A,0d-.8JCV@f/CD2Kf.O_-5CGY;J)-?B(2T_2>E8[.
a3OV6BYW\]6H0.AI?=d,V<@NO^MgeK#7fWSScB[\=NF:9F>D8J..<BB:#JRbDWN<
#UJKe1UH;7]JL&_KGL/I6QeU36&5;>?I9LGfTWQ&]cW:()R12f5N6#d@Nd-J1CGL
_X+\_RY9DdT7VNQC1?Z;Y],N+F(,V:D7.S7JAddAQ7\B4;\dUBB2]RYS[Yc;,Z]2
E@V]#>ZM=g_@?/BWQf7(4D=bS<=:7L\^e@G8EQX20Z\13=D5c30+G4W+f9BJ>T:/
N[Mf_HI#5;52Y1MZM3L/S<:3^^_9+[)gCWC-FE8-_fMc+]_F0L0W,7^NEY-:#cN.
PHMO9UTAK;2QM8bVPS<DO.D+U^b1X8-PdJ.[AU#G2a2@F6M;Ef]eR\QE@>P8+U&4
g:UA1=5-gI\Ne^,7c^\+I)_Y(9F^cXQ3)=CG:^]AZZ6?)c45J:<#3eF317@d:b_O
X5CQ=_5JcXDPY@aK\EDD<#\QEM<f,e;Od^f1UOV5(YXOVO./_G)(CeK#7&KKBOcU
GLYK&eE_c\=LDH&1L?g/N-,B)EL^D-T(Ve7Q#(Z#UJFbK8cENN7SQRW^,HMQ1[XQ
<@=6EI?J=E^Cc5WQD5+713gB&#BTD0A34aP-YWKHZCd48A3D2X0T7@.-UDJdY.I4
K.4&QSZgAR[)F,>Q\4cS9f?3I](27&[M2?_NfQWGX6V5JMVB-H,,gbS?SJQV2(+B
X,X)AT56GULN[4XI3e-F&3^MCGSU-V]+@KBXXQC4B5@>f831=\J:Y^QEYL,GRW4?
U=M/(4-YY,N3EDPZ70FFNc8Y7Tf6S7_1dcc4+R<3>+LL#<I@P(/GBJa3SD6K77B>
f.S;&2&+4DHUgV2CX<XUC9aE_Y4[YNUe&E_[^b/\Y(aBcK#4MGZ>>-[P(4.g8B^E
W#RO1f/WB+SE,^8TG48_DSRV6)RYeG8UBgQ>3^+D.75Y&1e2_HI8WTZ08)<&3.c<
,0NCJ+_BW(7Y,W^PD,_.V=+?3)DNa1#C@;1W1HgF&,L>@F.4F+K@>g\a+&58TOT_
D^5:FZ+825fd[PG;E[8I.LdH/I.BHR[V@TX3A-f(-b:)PcI5d?(=H=7@@,V=0=3^
F>=(3O,bQL_Jf;1E1g9?Q16\Vb6_Z#9Z=9SUQ<=&1KaB=\#9,M;8fEGFB)3(fHV]
FY-aK?Fd5Ug0BIL_MbA(Ze9Q3FdV8:+\1J5ZZD#gPfW:(93^9A&VCR4W(3W9beD0
b3X4\\a30,F)fY2MAW.g^H.RLf_=agb,0cKc.7JT28Z:--bS3#B3U8#:N6Y+ON&1
K4WdcMXV\,dR=?FZ(=-S.43<D9>\]46&dPHUdTPU^^OGST[01DYD&_bgHXbcG_g/
)C@4AN+IZB:0SY&EW?A-17BJgMJ4I(:R:GQ(^S,#=LPX(@E5Cc1+]TE)Bb\WHGK/
)\?]:5Te>aSL.)DYcNCJGa@BSZ\O-g[V)CdL^Y-E<\__7L;@V@8UEYPZ<QQ3a8_d
XUKTYJ-V9&4De4U^X^8HOIa;&E,OM(31ge[E546YCd8-2b4:[=aB=?0]9XZ.F]SC
G<IE>0PRAR0d7\0G(-3^UJ0K1&Z(>D-XWU&Ie03M97U640F3.=OW8a(7<+dc##\<
TRKI=4,7Kg/TTR7J.G5L>8(G,=NWeARWI#/Q^(6EUO<]=727dfT?03)K(?W;PBd6
f6Y9Qa]^7XZ.dI?a5gL7[PUaKf?93(VQT4.1UP);7JK9(49\97f^@5=X@-D9U&@(
Wc-HdPE[SS2AdX[ZJ(SH>aQ/^ZA9OR6[1_1XN0+0U=_#c<#)V0A6W&c^KCEe&,9?
J=LPDEKCK1dR0]KNVP:YdHF5ZcS^_04^XV#?-P?^Dc4-LFIOIUGS=(gF>[9PL4Y>
U@YA0+K+gDNfdX[CN=b4<11=^)K47->QV1ccL)N.5N\G?VO;:FSD0W>22\&4W\&_
]</BF,Nf3D])bRNM\1d0?3PKe\I593.X>N#,+AO7G-YD8TKPTJK:fHeT)><LeVH2
]YATCR:5WC^9]:G[0-FQI(IUL:N\8TK+G72#_>cf-12?IN@@M/:2RJ7dOT,W\FK5
85X/</OE0Tc-T0^@_Of#Rf75@1W?OSX#bJEZ;[70SJM>b-\ge-HQ<>Hc06Sa@T9d
M7#)b#A==NYBfDYUePNC.WO.NFcgB=?ONaT]Y5M32@)5TGE>dX4M3\/9R]AMC-FY
W#?Z=(C;+T)cT&)VOUO(^Y0U7P01FKFM8;Z1G9=#1LA,-Y8&>K4c.1HS]G_0)e5X
GI)0=1>/ZER=[SJ83K76O.9>_YS=g0:b,[YdK^GF:(,6]L2#8H-DHA-_QUfU2a,D
,+CKGRI1_eX,>@FKROe/@WG\&:V]/K8D,]QbA/WX2:BK3C,TdSb+fWT96Y[?_KFI
;M-eMRfDCN52[>.)FUF,AE)9_S]DO)2fV(EbGdHCG>KE^1e3F8D,IDI3[OceR9e>
\9f;]cU/V:&,/W[#60F;AS/EW;;_?deeB?4B<T9P5FLISAc\YQQESPK8O]fG/3&K
_\[VgeN^LI&QeK:YZOX52=R1/2KN=MF9,:=b^?M^?[--Q4-4(JCf<JeJ,LLOc9]G
agYWOb0b8F4SgAb7dQGJ[e>bd)ORK61]X7Y([KGT,7\UEQ3K=K=6Z_FZ,#OA,V^e
.=a4fLgA[K.;U]=ZU/@LBNDb)OUO+H>;dO=&bUEORY.dd)7X(M3\Z3FZP$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * This task gets svt_spi_transaction sequence item from the sequencer and make it available
   * to the common driver.
   */
  extern task consume_from_seq_item_port();

  //----------------------------------------------------------------------------
  /**
   * This task gets svt_spi_service sequence item from the service sequencer and execute it in the common driver.
   */
  extern task consume_service_request();

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction descriptor
   * out of its TLM sequence port, but before acting on the SPI Transaction in any way.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void post_seq_item_get(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_out_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_out_cov(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Tx Path.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Rx Path.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has finished tranmsitting its last data bit over SPI lane(s).
   * This is used to update the data content dynamically while current transaction is in progress.
   * In Master Mode, additional clocks will be generated to transmit the new data bits.
   * Data driving to remain as it is.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest. <br/>
   * This callback is currently supported for SPI-Bus mode only. 
   * Only svt_spi_transaction::data and svt_spi_transaction::data_frame_size fields are expected to be updated by User for this callback.
   */
  extern virtual function void load_tx_fifo(svt_spi_transaction xact);

//vcs_lic_vip_protect  
`protected
fMG\N]RW:^\J,BOfUMfET[ZQ[1^^\bJPZ=_-8SbUB-&JH.gSE[S>&(??0&d>fFV/
S?=]6PJC<>V5)ZJ-9PXaC5e29Q8\CfDNPaa2_PJ,]F9AT-5gdV?Ug+M+[/7d=b@3
V2:/EAA(;1DSAT\08I<_UP=LYP6<LT;UWbY[8G02AM.2VB69W3f)8>U\:>cTW6;)
5;<(W#T/9PN>=J91gJRMd#US0EE4gPGPS[L[1GM=OCc4U@cSIODIYFV6gYW#MC7C
,N08A<?Z5<fTgWTQdcX<K<d1;P3aD)PDX(8UG-V_/8<0CPLY.):[@YP5^7/ET5US
HPAEZ\7EA33ULJdBW6TEG-HLD_Z]PVS4KY4LQ&SL\,S-9G3F\/QS/)IcOVFe;E51
)X_>L.G/cAOX=?3G5]HX9UGZB\JZ0<ZPA1J4I<;g,Z20_a^C(?Xa3SC\)dH\@Y+6
BgX-Q0>)3FI)__SSK@4.K=1JDT]7_M][d&Z@cWO==PCdACLGEDf0g11aR1EOUM?W
#4[4Kd>6A(QU-6#VOLHUP.Y,4AL:.O@FHA)RWG]LDQX)e,A7)P\7<<5:&Na:+?7Z
LV3eQQ;_#cJ[RC1FKB7g)>M,gFf;&76VUcY0KdKOOTAb@(B:e^aDJ;@)8NbQ.XPc
:EeAV8YEcfQ;IYF;fLX&)7(WYdV[7d.7=TgI_=1;AEG+\+7MCSf8/LFHabUJI253
WdQ:f0Q;YWK4--<eQZJ6S8Z<20_&5,CF(R_\aNIV3Z8)@@^^X5aOc@IDbI4_QBLU
LeNIN35f:ecF6K7<8g64)]QXD8W#95MbJ]MeRe&7E7M6]69873/0=eY1.C+c&SFD
b=7DZQ.7A_Z\2a&-VOUHF\gT@IRdcT.7W+dIL3?95cS^6<80Ae3(D6_+P/+=(]_X
I4//0bC(B\cU)5Z^cHfM/JCe#L#4_&CGF(PXE#[(FZ[<g=)/[NPP=g>+O^I4+D\?
fJ()b/[M,bP]/B@?FbX.79,a-<JV3-T-faWD>A1([3K\V:,2R]LIfJOHY#?f6cV?
[?<([#:<cV[)&EfaVXdZ2X+c2_2</e@c=Ueg[D;393([DS;1RT2+\[aQLU]+M;[B
F-42KK#aL(8;:3fgJa[=B5+8S[;/3NA=gD+60+:)[GX-UQ::&)(@I40:;3V\WDZ&
R8Z.FQcY=:Rg/)HTY4bYA)\;9eV4]/F;KS]/081HMAOfbCZ=D]Y&P<^a375:7T[D
L0T^GeW0RN,W6>O_^[IS-7S?&J=;NRCQ-^d8-IDWDMd-Y6e\B_<CF\SFM\Ya_B]X
f+7K0^LCQWe4J/F-SB^T>PQ7d>7e_c&#)4JOPSA\M11(S.V35R24;KJKZ^Z-Z,,6
KQ>K;@B:UfST>a+6W1BVY8D)<@,bN/G02T^]J9]M4PCC=Ld5?D,KT6U=g@T+cR8N
MC-A=MCJ[B5e\I.?^5:?,Z6:)EDIIJS=S+S<PG3TD\;C/IL,@cMY&Y?_8;JO8N-7
c>V5J4==+<Naa(2d;Yd^fLN^:1NBOA96KJR,3]H=bP7B?Q90UA)TQf#FRQ?\cN?/
S,R+#We?/OY8RJ;^VQ?<D<\#UE--A[0,E@f(Y<GI)2E#X_[=4_0MVS1N;Y<S5/AS
8KZJJ/_KQX\P\CS-V0ZFGe@F6GScIZ7FgOKJ5gU0?^XHfC^Cf\7C3dHg)ggQ?1)Z
P+dQ,S_42]E&H&g2B[>I+4]IH;>DK2\C/^^74[_.A=7fCYY9U]P.4ST:@@Fc+L.&
OYVDMQ8a^b(=X1\0E)#bIE/?fZHF1eI<WS&d4(??:N18\955eWOF^JR=#0+OX.TB
+AV(A@V4EWZG>d4]RF_K.,_U7<dRe/U;X^I>)RT_0FBW\G5XW<ODV&]5MV11?Z_<
b,ED<5&_YKL]#O6XJ3SSQKU)NCS2a-Q,?Q+W2H3KJM3P@I_e\&5,>1-RdU=?&D7b
#T@-2Ae\]O#B_#@8@7P@<5^Y/cFO,=]F#5)IS.AC[aTJd)E2:MPeK6]f8?EJ4AGe
9BcZLAY;]IW(&K_-GcbPMb8KERPd<+3ZH/_T?7N4I@H_912.+T?SZ:6?d35,W#Z8
8+4:A)8(_=1:D59XO9VP:S6\0V-L,]??BU11T@YIR1Z7;HMFCG_]V60>R#42/<g+
bW+43MXUT:ACEKO:d[RHWEP@PT8,0U2L3TR+9D^NF1.HG945Ke_LDBcNC,BMOQK1
a]2MDR)-a#@)fgP)I2XZ+5/IZY\VF98.4cd]JbS1fHfWf8F)3Dd()VDL9;B<)=fI
4Zcd(b.KDZ0_aA^6VQcU<+?O]R_FBPB1&/7S4Q]T>HT04Q+1L4Ag&?2B\gee.VO5
O=+&XM\D4N.UQC>PadR)PB5:87B:-.K:):eBG?DWcTC-#(+.IJIaQEP@<U0UE[BI
C81731b>>g64PV5aW8^?@:<MbP70@5,DA9?7a:.5#/.+H:G73de98B.eZPA8SUU4
;LX4.a>=-bDG@Z-6EOEca^aMP#)/J^,RJ=TCS63EKJUQ\5JLACTH<0I-AMAT473;
0+7/d/86d<NaN@?8=<^K:8>E40Ee(UN/FYeBPWGF&_YT++3#DOZKV(G,G[McP<E\
:eTbef8Y&Q8fPcX&-#GZE-RA#LcOT#T.4[PI?.cF9O03DDF7=?^d[Y?C(W7FSU?g
78;[N<CFd7_FF:IL[G.W(FM/-FC?7@6,+@=[ad:_URND(g(TR:C8D]f_[c;X,A=.
9b:4V\TXU:IT4+LW1W8.]-ZJdM;bgfGBG8TeTXJNT^?Cg:2)NeP_#[DeW4M:c:]H
[d\fWa\8UcM4eVCSb2Mc12OX^g-0-YK<Ve2K7D(D+NCe@MQDU5OAC1b6O&J2>S8O
0M]02N0/?GJ@1589Y(D;^3FC#.JTQI#DJgM(65gD=MDW,G#YW9)R9D?I>PV,C>7#
]4?7KS&.@U4GaDA-bJ8gO@NM(8QK>OG1:N#<BUQF0350[@VW7(;g,DBPG\,,7E4:
IBcRLCa/I?M]=5]WSUVHW9MST<NNg1R//<JM@TA,e6O^aOZ9<?U1Xc\eR(N[5K=#
NLO0;X(X1Y3;_+RB3VV[:OSGC\[Z1a]&:cYGJ3][Q5d+,3V2W-FX];,YcH2MHVM6
/ZVHZ#&;4gB0O/HgaL7U]<(>;T]VeX3E.S<2SbQ@)1R4&a#/^IWF)<,]XV=7&S-:
bI_dFYa9G>G2>Ze&Y0ZVCa:&\3_T=c()e@<f33R2cc>V9(bD]3)bKMb\7W;(--2=
;X0.B.842)E[I:\DU/fB0B4-Sc??K84V\6;LJ6Bg<]&,OZ91Q&0U5f(\7;_eG:(f
P8.)aK3#J0Q^Ffd;8JTIA(JW-IWH1_K]4LcgOM1/=-C7C@2d,@#b3;#c==@JUd[H
DZUe9PH7O;DF[G]]9>2@5\Ia]N21N0,/?=^UOcXFH/d^(/7.P0-PH:P@QY:P=+<e
D;g&4bA>F1)DfNc)/CJ4MUYZQG&:S#c/(V>P;^B.c97RSA,J1_<A1f+1?G5=:/3&
a[+@OMYOPFaa,)gPP-AT_W\,/_H1P3)NV)J<>7^?d3ZO)g3(6M&?MGP-Obg5BF@9
1[UEGG(:^:EFTV.UH,A4);a)90.>1FY>2LHR>bIG/RN>22@?WJW[[<S57<C/7CH4
7+dVN47^KQL-f7dH9e+^<S&Efa@[6)L.H8P/B6W+W5Q_O6HQ92C-ZU6WfFXZY-4J
9AF;SZ)aMbK[4TWUFO5F1A2faHZ6@/3g+c@QE,-[M[7cg5)4Sg0\_U3GY+O/3Aa)
^Z\gPf/TBf-Fb>NK&7=Q8<B>8.<IEE9N(bH4=]:&3J0(@8)Pg/#V[[&\_Sa_U-KX
(=X]2RMEUHB\B[f)(H32YM[;D,2LPJ6#a#MP[3bB50=YaK0HJAD/=7Ye<-70PXBB
#PG+bAP:2)Da34A,1b_.1J8e5a]ZdA;T@De,(7ce=6=N2#4C5/6_UV37<>6eF3@_
NJH291<1E&eeYK^]&aLTZFXK>_2]B@Y8]=460U=DM.aR//Ab9PZf0d^X(d7K16g;
cIM@1-LCPD@VYSP\]6^#AT//3&HMb\/f:28[<(12=12YFKdC=R6)IFMY.2L/YCW;
:DWEYUT9PQR0=2_6SX0UYgU>.Z[HM=db#IC(W>@X>bB0Ped1V_LO[ZfEGC2[<-gK
C9&2^7]<WY>P6E02YCV5G4=dQ+TR9XEH3O^W2_(2#&QHT37d4?_FYdEQO^W]5KNR
;Uf[]5R9@T:0^c]:#]_5U1fX,g]2IFFScJ9N(30R#C0-YU?#+a)1-VXT#fZ1/(OF
QVd,3-=[.36e0CF)Z;d(9L_<Q8[9]2f5920g>V?48]BA]e704g@TH0(BR&DKSQJB
c5C4)ZUEEA<b)IOSeY:d-Q;ggRV.WN1CT+DM_0GC?#bTI4@eD8f[PQMN\>TF5B0:
&8cXB(:02]<>P0)3,WYeYb_Wa21Y-\SZFA9[TUQFab(93U&7>W3&Q(KDbeEAZC5:
+BeLgDP8DW@&SQ.ZK6_D8Sg03B3BcFON3/@.YEd\2RUKCcAGYZ[;IPBN3(Z6^&WM
7UCTQVP)(B&0a<+;aJ.1;EdHH&#YZf?RM]S@?AQWXDNL1gNDYPOKILW71Ma7FB60
;]D.deOa3a+^_&XXe]>CZ8K3OQ]UKX=8I.2W?ceKKJMQ@aRLQD[EMP[&4,?-P#B]
WNd)fR8G.-N1<fC836[[6g[(,b-6QGG7]<X^;XO))BUI68QcdH=4bdZIRG5K52:C
fDPIf0Xe[;SFWZ=MZEEU,d3^+)PD.=P&MOGNc59-T<SD.==M)H&1;JOC6.\:XbIO
(e061-.C&6aR0:A+)3VcB[:O\&-=d=.M6/926A^^+P50bZ>^O1([_&--<G;TZ-C/
LH=PEOL:&_(2TP/3D8@@+f/ODZ?f8<D#SIQ5P4E0L.J\10;7B@MSX?OPODFQ)_7(
0\6SBUT[I:QX9Z^Z+?4NMA9UTAK.@AE[:WBS2aeBaTU3M33?^,)[5^)Sc(Ae;4<P
C=75&D\^YHF.W6[d488c,9FVEZ[?,ZLLEMTNSRO5R3J4e0/E&e[FZ(ZH4?JCCa4g
1bY\:6:BOE5;:#1a7NR.HG.b3,OMde]4^NUf)QbT+cD&4<&4;4O3(d8CLV+PZXe.
FQ5R;8XP52cNODeD04?E\;eTH&M&TO#cSJ5V\\>FN^N&EP#3bYHH=^JY8F6^1#NQ
V?KH1SJGE-TU3GGXf^^)cK3>LcCZ0S_R,gKg=[HS+9E<KSF@]5DBH7>MDMNTOgK\
]O]+&[TMB0X3d;@UcLG14;4eM(]73>a+@cV9I5NK0=e2-&Q0WL>\D(Bba[YfG,].
>K)07Ha7WL66Y2D]_D,_2X:08dC.4X+8^@==2CfNdaA_a8.,e3BE=K)OB+JeP-2\
0,=IXO&FH:=cKQ0W.aaIPP/S]b)Sg3:A+g87=.L18>Q2E&3e:J@4[I\=5G.VDS?3
GM]Vg=W1:RIDE8DI&M]-2P2H4C^DGF.-=N69B^..;L7))O46FGcfd:N+7/U9=OTB
)VfW)OX\J#T_R_,\c)I_?g/(E9<+2fX8I.:LcUGN59DMbF<MCb3.W6#Qg9]7B71F
4gGZY;6(e[OA=(fRGE<d5(R@-;F.?Ea&bf4ID6Sf;>Le.E;#)&(+GUIWKQedRR57
c^f+J>bf)N>-04-UU<?QIS/LY^fJT@gCJV4CCO?-NeQ/O(/Q.EL<H_gbWXW+&VA4
_QC^YX]cIXC.-BbcAc06Mf/DJ6,YSJP<Y/797.I6d.)OdJQ<(>_[^JU-a3[:;#B>
S]4I?>GR[_-8X0^9gGPc(SU3+L.9J2[C-_b+QPgK5g)MK.GOMA.L^NSGE:-(;=@?
cMR_0gY06W2d5DPH7CPMKU.IMHaMIAc_I(1JJ&:<LIX=K:8^gY5=;4\[A6#N<5e7
aT?K=DfJ@LScS1,^L>K94&ITH(-MZQ9@-/6D[U5:>RI20^M6d_.1C7E/0_0X/-32
JF6#V0TgHg/^O-F2@Pf67B189O7;E+7/#L[Ba2&YBZ)3&L,KKHY>=P[4cW59\#-A
d=T5D9b:=,@#&Udd=dU=#BU(]IYg^ATP_,:5YMB[/^-X/Nc]DXe#CH5J0=g9D52F
J6D0C\.]^1[PEdO5aZ]XUb6Rb+<+B_&e)g)SdWHgRaYE.TN=BLROO\H<D)_GU2[P
RIC[DD+,gZ1CDa?EN):48,g]5#2B=2#=BU/gWD4,bYWdK/c<0g#4VA:&=TE.<K<.
fYRM8H178BYf,#MY7QSMc@S7=7bG+?K=X^_B/_2E35_&H/Y3899)LJ5Pc>c2)]<[
\[?62HZa-VR(/VL(\OaMMb/)7U\#fQMT,0PN[e>NU(<23@@GST[MWCa7D?C0@(RQ
dMM,VP#]@SKePGW2\F-PKU,Ia>1dCfTE/GKP=18A45ZcQ@&,&\7&6LgdGaRA]Q.B
X6A4RXH(FXfKPff28LAC6a6A?2=8Q;_=1>@E(a[I#=2_5PedB3OO_4E[NJODL+XA
O#dF^_NW4P]PIT=5C/74^AXC1ba@X096E88N\XS3@D(DN#JeW[N7MdL6</)C;=<C
U,,KB1O/1L7H/M-DTL,LA,3[X.(D/DBM0?=OXE7O[1KOH3G[RL52XW7D/aFCbWGG
8b:=;3J:ZZdDe7_fYD><]TWaT+\bE3_FJ7BO8\LXUCO_I_CK,(B#3?Z,-,Z2#g&W
D\04Kg\M8^=?NJRW?_NRY+A1\@8d[J#EW311>#Rg2A8EHH_b&62]/NI#@+,T0/95
K..T0.FTMPM5f0O#5)TJMgNe4^YL<7CLX+?/g-c]bUa;XG0--Z#5c+1bR\LK#2Xd
8Ig)ge(H+&/2GfIO1Z-XY2g/.TNeZb.N:\><U\N_&6JB6W4:c.//OeCC1N4VG^CC
W^:VFR9J^e/EgK5@B3E9?.E<S>BAae]#WH/G+8=TZI.N[fK>4XP#Vc9\bEX\Q5dD
IcU2:-K1aS_b96YK/M:#f-1I.<P7KbR8;1d^bcTYOBUPKG:@),=2+E;be;DLYWLW
J/M2TPa-II.R<I:=BDGBU5[1V/<ZM8UdZ.Md<G0bAM24I[eT6b[<TTIG0NUCOG)8
5=@LI-WTc-3J<68eg3P)[+#PGV5/YU,-EOeGD(6^d+Y]&Q<N(AFc=40c<RX>:@Le
J#Y1:5,FD0\(E:S7L=.CB4)>?7eMb,]^c9N++=&D,7;K^dTaOG/,7b;EOIe<)HX/
]3--H?L42M#-3cVGaa/,AA>O?g13<ObQV^?c]QFFFSfPaWg<P0H<KCV;.\1[>...
/C?K)Ud#,-b)L9)[@1beBVO(1?GYGGR/eZ:Vf:/,[3Ta2WSU.P-e_9>^M.JFgYA4
P[dC7:?3eMRKY]&5\8RD>Y?5-_(UaedZWQQ(=Q_KdB<H)9b;dMHY9VR3/baL/S-5
)^bULN<e03O;M#@OJ1RfFg#cKcEF=Z<XF=BU5bUBSEU@+bU6ZR-QD7JQD)4Id)Ng
=DG<@M[?A6LbQaS[/HYgFNH5P,QXFHUI)]@&J-3P\Ya.++Rd?JP/9&69XIM-\6UL
0V]P#(MIU7O]18_:F\EJb9bSU/DDW7C3-WH:60K0FQ/>-A&LRE;B.0W0RZ+a+TG,
D^BN]>d:I_>Ycc]7^\b2PfST[,=87I^/&#X^9P9dOOP>VFAWdRJa71?P^3Dg:AbG
NF\\5.OBc-V_gC<gW?(5]W^?f>UL-BA)D/)O+],aTL;fA1F@=D2eg.HE]?N52aVE
aWL(V0\FM(?XQJGHM[PX#&5()g;=STdeER.A1I@(bTVM4QW^FF-<gHL+=_@74[ZE
)H+7a^Z+H-YY6VC&,R9H>-c/;8GN^EX&].ZM:OYAMb8.,P+IBOUA7ET>^U8/1@H@
7a_9E]EeKW<[/abgKR;g&W:RN<2cGDQJ#H?LYK_AY;GU/CCQJY/GSIV&<f5=/=[5
H0+1\5IO)5Id^XQ4(4/d&^XP,?dX/#OOVQ_,)0WaCD\IQI2OVFKd95Ke5Z-Z/LgB
V+F>V5GEgO]QMY.]8@N7EM8#C5Ic@6H&HaP(K37XNFa5XV&8b/[1,_M+8Z7Q_@35
</=c5S:TSXb3.[>.T:S::QZ,&V23AA4EgY=]3UXHWIF[IK[@AQ:S7\Sa&:e?+/J9
eb.]2WcZG;(>0CC#2I8.6>T=gW3\D8G@5K.+=b+YSE2[I/;#48E3NX=)+cV]BP1U
8NQIFSR;T[MggUK(QaQP/@3)>_gIO\b20;>+)#S4ESY+#d7A>]6F:PVEg-^&#KA9
ARg-,_&LSZ9>#79>d#,FXT(d>Ua9W,da/VY+\WgdUE5/<7Zf@+89E_:(YH&_=(Yd
5Q5e5d<?c)f<V,I<]A2HOa#88?4#,3RPP&35N_99NLD]QMJ##A8KVE?.((7eQ=cb
?)I&3E#5)gJ+1]91V)6Z[12^2T>fT9bAQD[GHZMHI0&fCG>=4#\g8BU.5A_a8X_&
Eb5JIH;)>Xg?.d2ZF:GY9fCYaQc4W3A47B0REUfd)3+EA7ab1YPSGPZK3Y9fU[XT
M)-cfId7He3=1N19#fe>?>72OcQQR;V3,LH7Z03Q\VF1]f?VgCZg7+UeMYMU+5RV
PP1J:;BfI4;QBC+@a&U-)N-T0MRMU)LGPFL;X53EdPJ6IHED9;J)f:cCOeP-(&B2
6NKC.Nd4#/::+K6WN3f>?:G,DFE-I0BR7[FX)NNAAME1\cVbCc2HF,H)I>PK<eCe
2R#aQNdE^=,^3XbI,Z#+b.aP+Na2Kb)4;LPRWHQNY0NKSFBEgVZ#]>8@dQgI94K)
MXg3Z0=Y&[MM7Q^cBe9)>S.+KaD5<KU96:).)K07#R6ZdL@-JcCa&-d:6B3[SV\T
MbAZ^0]EQO+c.V]<0OSHf2\Y\IY:?gART<S8RG01T5S)^a4G/I\+Hf27F:K0?I^T
_eG7?3CaLMN-^SU4FaVXQ\;?RgO)cOa2@QS,f8DH\GD/8&J(eU_IEO[CYfWYK.[?
LSQC1P.TFWM_+dJ(X(:8X0<HDZK/^3E5L1MK)_^?b9CbH@-JT:f+>A=Q-X,f^V(>
9?ED45+g<7_5@^eLQC7.gBcTO45Fe.1SN=(UY^6YZUJRSgf6U>D-.f)dC1fED2Bc
TKV:E/e)E1a#^[DPXb9#[c1[C/<FA@SUHbLaXDAAVHEKUWV,IZ;Qd7I)G&:397&2
D8=P11d9Fb1eR+69&OLaC2bI@H:EU([H7&W.T9/=cRG&AEXY))58^b[@<:g.-?Zf
,EK#W3ZNJ1b7OMO2c1<\Z/Y+>b8#g<fJ;OBY[&GRW)/=(,G+_:#+9@)e8G6)1B:O
/\.Ic7BS0]#I-+7VfGCA0&U?aM0Z[(cUAJTI3EWB_XT9=MPVZWELBE^_P3@<1,H8
aIYTU7=BGa?(IY\eC.+a=c,8\AG1NS8b3a&>^N(eQ,bF5OEaL?SR6LLAT7aU@?=9
FQ81Z#G?S29f]]5T/-bPO)82ZaST@O2=:eYYBfQ=?=g4V?03JN)-S3FeeT[UHa@;
GFUbW]b,e-8HIOf#+R(T^/NIdHPXfK4@>?<;]?,ONM@e,.CGT.1(M2:5e9:?S7aT
VD6/K+WHdBICf??^6G<6JFN.feTCSH^b/-,7d4@H;d=N=b6+#>CVM(a^BXe^b/_c
05IK<aUC2K/0,\VcQdg?3.@FgfU[(Ugg9N2J]e1Q/R)NB$
`endprotected


endclass

// =============================================================================

`protected
DSI<WUSWY?M>TPY7A=]b_?W2IG:1_8?F<OAB#d^1U+-B[C<5g;1L+).O^&CERcY4
TbK&e8RQ=;)(gHO8O#-TYc<+&),aSWbSAeF&3I0\RS/f:AZFOd87P?2Z^H3A(]@=
H_La+6_45??P-33_G&H&><OE0GC=K3#.E3KFMa@LDZ33C8#QCbVF<JCA@T+,TAAe
<.\.TFW#]TE3>Q.&6-=M[I52.bT>c<9E;fUUIYTWJTbNRFf-#&BaV/:a:OQedW5Z
=(1c_K3CJL@+.+VfV0,M1HXc51>(-=OaH2.U:)OP\#2Y4=\fV@VK;7ECG4[JARRR
O02FdOL/RX34XOJNIId0P]b=C-(,>-5M(#DAP=T)=^a@T>+166G(Mg+#DXUBKLA6
SN.(YKfK#U^NXf8<aK;@YN4#>9GQ2a/N:$
`endprotected


//vcs_lic_vip_protect  
`protected
O3)(T7R,;7M4B/++b6-g-6-aAfK>=\?D#B@^g_;OR+&[K6=Q79fY+(BGEKOM.K]R
9E3d]6BgO0H?D]M\7gH]^FF6[7OC_)c,Ee8E;5]e7)Q#&M6&a[SPT((?@Y^e&9H#
[eJEJ?ZHM&)OXc-Ad2b)S/d9a5gd2TQJ.ZPJDc-bIG@4O)YIg_(3+f+E?S,RL@.0
2T+@&=^:Ud,KHNX\E3J\8RKZGf=:M(@WY71=XZR_dRVeYX\G7(KJO^-fX<d2P:_M
4=?DDN)1gb[N(eHX.YYDPFg3/:Z1PD5^K/[D<#U3AYP;ITAI_Q>TE?()[0F#NXQf
)6T[B)[KdF)D1.FAG2(NJ30HfAJSePGU?XK+V](9Y5,?<AW6dR8>@J^Q>P#C0XgE
+bYA+M+(Yd=^LW7PVI=1KaNE^QFR@Z@45^)O.=_<A7=#,aKdF;MCFaVXWdRb8a.d
X^LcTe.WgXCH/(EGfQEO9U3Jd7C:.]X1JgA[X1g?f<BIgcTK.=K[@eBNf/c/Z\E3
VNd;O@CaXKMLC_TYVXX;I590Y<aZZ[E1.HcNIN0.N9<06f\C[3;413)\UgT]8]Ge
eb;fgd&=d0Pfg^ZGL[7W(;)=L[V\:45JJ>OfJO8H>A:<VGJ\ZGZSC>-dW4I&a7(#
.28IFM:-)@Z=+_I>AZY&-DYZ;9:LM&#L0Lb.F@>3QdP7^fKXaY1F93NI7)&C8J(V
RM=L3ZIV-NHU6[;EDAb#bZM=C5fLRE#a?gQF5F\]ZbE[CVI-J?b,BX6X0;+(-A69
/0>+:aC1)Z>G-Z9PT:FMDbC7A.MQ4L,;.?J9f2gNOfQ]OSc30:=Hg:YWWZ.8?GS3
e>E(E7Q_FaKf37\>6&7_@QVHSPP)B7/]Db3POAdR^U2g&-),OG?DQdXA)Y1Oa^<-
/Y7)PV6ALPZ5R;LBM2GX+H8P#+:B1V7MQA8/SU(dAJ[.RL,]YfJ6[f)XL7E0VLgU
NW51QJXBfA1O0J60.UfBAa\JIQ:X,TGR^bIJTF^BO21M/(5-C1b:^_Fc()1]\AeC
YOSD/FLF,^6XBE8AgU/67&,=3?_IZM\6F/YIN73CC,?C7VCb,?ZH)3F,beO@VI1S
8/?fa3_WF97b/N&U6KXGA)OTBT+1W3d/)P;2PgJNMg@^)V2RK+117GB7B(Y2#<I<
,6LWd:\M\S<XT2P3O7#1/cR8]Q#@_X[.@g?b:0@eVE40:G5(B(C.JgG4UON]>RC,
QdW^UJU0gg/b1<4C(.S,QQT:(_-#W&e.--HUfHXQ9#^_A;51Ng.8Of4U^_14G.4]
YYFM[O>\<<6H2,E15,R6XE3=[YH(=A<[B/1D=;O\X8^)DJ^4)+(VMHJ5?4d&M4e;
?,=:_^2:V^OD(:PWRWE\b956PDNgaFCNUR5&JbA#MV3QBC=9?S--M>#a9J^YLb?P
?.QQ+.FH^1/gD-98:-O39H^a,DFRXVX5T)c+EIF^Xb8<cL0dE7dHCFRNNdF&2PaK
EI=Q-V/Z,FNb67#TJOQ?Qb1/aG/JE+2-.X6K>-#SIbCWU-@X=V7:>,Q-L+L9XD4;
d0>,dYJ9<1QLG5C5EBULLe,;X4^@7b?^\#FCCNZ^Ya^P4JU2M/#>2^[PF]YJg?If
M:b47GVKHc&IF7E1(N#gRN=IYC\\,+8:gcCA8)dObO6]T7D6&eIE^gVO3)6(2c>#
+KP_#(2E0e.-W3d\H1&ONU9K?T3T,CYJU.P,456962\Gb)3Q;1_CP.-C/2:(T9G8
?UfYT30Hg&9V,E;6He7S9)b=7JdL4YK)IE+XKMP0(:&@T4)H+JebT-a;TY2O;D2-
]bR^bMEY/,(JUVf&Hd?[/6WbDdO5e\]WAM7S4N?X4I_2A]G.@cTgLN/5H74KQJ@K
B1aJ9GBNe4BIa[RG#]b,=.ePB#2Zf5AVI63GE]/(AE+#4+Q(.SOSdJ3R?9O22+aR
BDTVQFN^&a5UeT)D0@MfJO;V<Md.<.R^NVgL[(Q]M0@D16(8I]#>;&E?bD.;[;7/
:Kg,9YA_VL+Zc-VL9KT7PLLN0NcX[KL?M@Y:LFe9CdPMe;5;K<TdV)-S#dEM3@W=
;:(1+Ab=96PUbFL&G=^_@4Z&TEeCT/6&3/2J39O[8<D(ZDWb5gC3\3B>-2cIg36e
g(9+Nd@?XM4PVBe?-[V?7)5).65XL1.>L-D,U;-TaD\#]Vb-5#P2K^f\WPS+JUIV
1=.\Z/BNTdA]=F3[I1f63B[dOI\aS&QgNV;9Q3f>LEP8V/?>c1\IA5=]1KbZ9QS1
4UVe^PFHb)[L;2fH#ITg,b6ELdc2d^cf;a>aX@=C=Ke,2N:DSMWa.:aEXIAXOYe9
(Yb\<0^:W)@XM(V5J3<8C,P729E>+U80>TOLDQecG1ZU)P,LIa&G287MFT>88)FA
+4#]BA15WCA+JE1:5@)A#2c-6NZ[J.I.L8I_(>,d7f0P8a=]C#[B7d\IPZH(IZ:Z
O[d;]]e,P#_gc4I[df9A9eI<[B_(f4]dB/:OgU)^6f<[T1AP&D-8-3<cc-/,fVDI
/d.P=G(WOd3)Q^O18\LZS>8c/POC-,><6F5Qb?-:,&aM[LY^_Y@.J.eIaabWLK5K
H\)D,1cb/Tc,c)2.=?Tac\.F^#;KSSN=4aGUI2cNWS939C=/M6N0G;Q,eI./2a#]
e<I2@a1/-.Xd\WA=[[;+]I>]7B1>S#)014/AJ-0cF_aUU-6Q@TYBL3;\:)FK.<2S
@<g5W.TW-W7Y1-?3.AGTgeNSO>C@\b64(A^N2I7TSBMS7Z1DJ,W^RT[&6eMVH9@,
>YaZ4I)B,dQSg-FQ.V/W:eJeGLN5XD3&d+\WG+;-WeQZ4\N>A/Z:1Ifb5\^E]BM>
?e8(C2>Lb\FSgDU&cFF1(=JH&We.1;L8D+aE1VRIVT6W6,gND@R0C3BYP[&U8E9/
C8-MO>,MUZ0L0RReO):S@d;gJ2(RODQI+M@>KBMA[\2PbM[&(,-)G54P^cc;XF)V
eA=]NL&U5Ba@((,#E=Xgb@3f#N]<E)=Y]6R3g1TdZC)&_[gIG&NS@AT67agOY-1f
M.4dc.=-6>>;K;BG82-QC9?AGMQ9F^^Mc5(CbWAATc#.HFA8RU/<aY)&E_[8^52W
EaLH,AHX@KSFNNY]Q)G\VP;TcP#AXREOO?S]^aRgY@&@gZfN4QCUZFSG:UN)]<WN
KY(UKf?#4;/:8UWUQ8S[9^L_0)GBdW8+^XJ:?;.NDE5?.EfKN6ND_J;g(bg4Ebg\
8EcTEF1DfU68,B]G7eN;Z>Q(^\d#VY.P=?&.Bd@XA4\C<L6[0D83+@U4+>f@2H97
OW>8g/[VI88:&)T/E=#2(A43.^C]fH7H=Ze&]bf;/[JD+PRLfYcf5M97-8US#7/K
M+O0O;[+TP\A&&#N;>7ZTfZZ>Q]gK_CF/RgE+6-U)dbS^OM3M&:=5WU4BC0HC\VV
@&]4E6VdT9/S&;+(:,/+,768P,CQ]+dGGB=XQ?TAA>;KddSR]WI#VZ>M]\I3bOM5
cd#4Y9H>/S+:Q]:\2Q?45gTYF3AOM84/B&QMe)T47Ec/2\1Z3AKO&:(Ec8>O-]I,
1])YU6bKK3;T),8S0cAS+-3-ULT\FM-@H3IdL4-E=4e2e8>CHMJ4Z/W=GCDO2>0^
&9<HgVCbC\TU-(R_+)EO.=V&+LF;H.9@R9MY1P/L#c[G-.LZT\ab3FSd.]WZ#a(9
;9Gg.ZJ-+;\a9TTXKP-&TNIf:\+PGC+62Q@K:341/S1T@LO:XD=b-H(d)S,g(OLW
gA?J]+3A4I^A9>L3F907S=^.d1-JSI-(08P\7ZZ08Q.-:bHQL4JI34V40(aITI#+
T##6SEEDF^J;I\8\-M8PZg5f^8E+1Y3D4d4/8Pf=-<#.B,0+f]0WGD.D5XdDYOI)
a0cK&R#gXb(W1#8Pb<,aB?O/]KKR&<F,5If)(9KZO;58W#LV:X,:Qg4L2QZ.T+g5
U?\F#G?9A6+\#a7XGdG>I]Q47(&V-@?Z5-0aUgQB+(V__^aPQ.6K9-9\Y1_=f46N
#>(SU8QUe;0=+E(I&2JC(20XBg^O436+HQCVQHLgUUZE>H:QZc/@Y3V40K37-LCN
#:/=0AS(\aQF+>4=bTA<8AeV\+cFOA,GHTB:698WH,#X)F=8#FEM?BIO_dUbe+]#
JVUS(Ua+E),Gf@K+,[I/T:DKa2Pb<b?JdO6FN-XYMRaMZEfIW_/8SXbEJa/R\H+M
W[O<:/?^d7H,9P>d0Ie7I7N,42=(7+927JF/b@e6=_.=\E670O7C[Z<+;NAJd/9>
-V7&@M?U[4P#G-J&6.8@07.IH,X>ca(b(c?ZGG#NO2J=aI^26NFG#,WV:EeSGC>_
5dLg3L>(81LD^V7C1VR_B45\J7HM9TW;SGfI\_<K77;2<&Lf8UIQ?<,g,I.V;&9A
B]I1(_cAF)PIS/XRcH=Kf<G\2c[13H]B[5@,fdIAeD]S302[-=2DT?cGMH<P.c0)
M:GV<RcXLT:;@/DdK<W[/LO@M)(_S]WB/UeDGaHCeZW<RWDX8>;K;QFaTMR6gK=L
K\ccE9LI^<N=8/8\+A97QHK#_=>(b7]O0#NC<aMAV,;262fC.=OP#,gF?3F\+WcT
>=;7Z(;/Q2,Y/@fgN/(bc<@PCJR#(TFXaHDB=<R+\E2Kd,-IPNJHA<,ASb-3>&F-
/<.L<,fADgTf_7<.1)BE8AW?8=O&KC3,P\gIEdRdRQ4SNXTa?gHPbeg.;g2GQPf_
Q+]+]7K:Z<L&4a5/2fY4?L8OQ1T)F>=[Xg[?5LDT/AY9PN,)eEfSg9#Bg0TI]D/6
LeKFA@B_IA)7C24KV3L&c7,e#7K4#dX>=S4>db\(&)IcMTW)WCFf->M1&b+.>3[T
M_/O6T,1BR&:S#J2Sd_,d60(Sab,a.0c\9>b2DB_aPHDd47PDE;0bR/JX>3S&SM.
;Hbe=+ZB]D;DaKUg[&^=LL7[]QT2[[B+b>,76I\.EFL2(bGV30WfC)a#D+?(41:U
)D\9V0MIIHc_]HHQMeWdYc2NDZWX7L>P0Ad+#C43_F@gQZ;E),2=+:G:Y8c4^dA2
F^?e&a;XZPdSE1be3@YOWYR4G53LM@&T(4JgcG@25dY[W2TDQ=3JcJb]4C05X[BL
8/)HcIXY8ZgP-TafTRd2.b\bI04eOBVF&/]9JfGeXI3DK9^GE8D18g#eb(0M>7/D
/4aX_O@P?1_1<T)(V:B+S_?FI/;)1TY>L\B7;2c\:5UZ/J3:Z[7I^.&)?[gZf/8b
e32d7FgW,<JO<7+^W1.7OET^SQG.>0.;B<D+>3NK[?WcfE/WSS5B6d(?N]c#D=.c
5Bc+:;R;T2eQ_KPP;;M0O18SgLWS_N0I)3;BIJ:F.0Q(CdA]MGHOZJ]Eg0,M4^7N
^JDAT^9D]^2G/QN)eB>F^H4=DT/GBaH#4+[V/4))/+Oc9bO)(SB?;GLU6]OXYH,3
^.-[8Y<a-(--)&)Xgg&-;ggUI(FL2Z[BYH]S>>GB(_S:K5[J?13S-cVO@B11QGM@
?((?5ICZM^,fc>HK.&-ROP^We@4>9@GB)\.(+e6FH#J&_N;F:YB6EC;/^ff7]>-[
1a()T>JVP>aQRd33:CK#V)D:d-#(EYTT4J6^A@8ZKaS\WMb\EDUCN>5JR1PH/?T#
GPUP/Fc]3F8;d.8@c8@M@d832Ke2IJVY>U1?>3Je9QA0\[0#P3;a@Jf\;(b]K=Oe
Y,?RIU>\IP.\-Qg\2QE.S[M@f7f]:Yg#fLF2D]#ZcL2U^C)=PfReBP]4.Wa:G9.:
7.-.O5RMXd/;M.4_[W^56Nb7d.B/74P]H/7V0N1B6V803?N:BK\<;,NP\<#dgW<&
6-)];BRNQLOR(I]9;OW60U;THP5MPOgeA_NGCXZX<gO9Mf[FO5K^YCZeH[I=WD^R
5+MC6bI^9--C?N=JE,+=?UP]8f6Aeb+g,J,]Y?cO@@F_S1/E>7Re4;4WXTCfIAPJ
M6K_)>-&&Pd@Z6KH30/@R\1/.=QDAS6]A/K:ESIP^-eg67=7]AfB>V\BU?B[W.fO
\M00cXGMY7Ic&K=gBCbIOd,K-6Q]Z5;ea?c;[1T\GS(SB/=]7JD5XDf;Q<9He&G(
[W1IXA9,Xc54U@fE;S&N+Ya]Q9#aLN;OAL/UN0W3&LTRd.6]X.6=_CY7@04\)L(K
6a2;5UOd67RMUUH,Vf5?)26D<3e@@7X)Ib5H3-JGRcAcIZ_5NGIf3g0/ZD#V[fL3
bXZRGf#^\LUbWC3NA>79NZKLYd_Fe7\]2(X^5DKJDX-T1>g^(+]N\4\ec=_2(612
V)J-XfKD:=2.I#.I]d.ML5J[J.OT@KaIIUC0eGW-UZ)AOF;V8-(V[SSY[S54XPW]
BO?1@C5(06,3eeL24_IfR_@J8e]Z+MA4[0)a_(+++HWB^7(3=d&VO284KD.SW41.
VN,fHRI9H<:QGD+>fKU<<0O[-WB3AdQ]:Z>;Kg?RS:<4I)ZTMON.C/W:()Bc:085
@L_Ac?P(9NLd-\I,B([N)9.]W@XQD^4-=6+23:H;NLXJAa-<e_\KQVd]c8UHS^>N
+VI5:415[g92DAO3\)J:DL0CfV^8[C/HY+0A6ENCN2Ef^6eb^I^#GAXYZceD.a+7
0?J4H4T]&fd<HD#WC_-RbZ8OXK=VHB:U&EK&QW,^E&G8=e3J@3-0Ea>W#1fUVHBJ
G7cQT,A#>c5M6@fWU[0KaU@4GR0(4E)_cQHF4a?ZRdSJYHLKYET;6fSY4A9PYJX0
@U]/gfF+SR,2GGOE68_B?6^<bb5>N0M(O.YLf[UgNH7g@O<@WNO@L6\_,B5<]fH;
^PK0N9?7f\\_32A=X0K9F_-B5gHW1LO-[6De7_N32O1Y?4Og&ga2-Z>GLMC6]SgQ
bLR?-M;(Ke?F=(G96DHWEV1,.V;AFa4-T4=.0a6,0=\a4P)+A@MY/SVG_Ub#(5:_
N@3^2&DHP]a@941O7+):Qgef&I<g&b=^2_<deI43a5=>[YT5,FgKK6_g)J\ac:88
+?BXgP-F@O9T,?3N6aAKfaF(_(4^cSNCZ1^7I.XaDR@(6A(3/VFAY069VM-1eJ_,
BW<?2,=3>3ggXcUJ=CIV2^Og<)eT(K11N&4C9T]c+=F#9BW2XG+6&=FPD>cX>V#3
dZ+bDY3MWcPV@#Qf]H_dX[3c#J?BbNJbb/.PIWU52+2EW.W?>b+\>5QV6JKDH#TP
3)E\9&<:gPS\+24fdQ:TFTfKZN0d.Ac.0DB91A:(_,^OW^K[;&69O&\8H^ZB_bg0
P^ZLbS/F@Q<BCR3d7^_cbNB\a=N?8>d+G,\>^T]G-/@@cO,]E\fd<=ZX[YePKR;M
SOD83T68;.UY>aZ::M/>3,5?2Z#\e8KNQ4(GUCH8=[\.+W?f+8:6M[0fe8>C89^9
Ha009JK^7TP8E&713/>?a-5aGL]Y2LYPEAMAf13Q+;R5N>]1MLX=f=9-3OFe.J^=
]Y[TSA<RD+EW/eI8(PKabFRc8(S?-a9Ea[==E/EGSd1D#4/?1,bgYS>?,HH92NBb
e=?ZPM+CC4N9@]a\)Z8WZA(UOQ3OHVNS3[OJB#[b0C7,#KO,D,-K&ZQVBPT/3:c+
L_OS<.KL((N;)1b]-#@#Y4?0eW1=NHI#9bHY/Yf-E)Y-3=7KfYF)1+;X+HI4:5-.
A37#J2Q>-)>-N-1[MEN9.dNGb:>BRYY3g3.S&0MW0O;6_ZcaKXMg.eCgf;f[QT,^
Z+YB.,gSg@+KaJOJGgZ6d(^5+[P6O&.66f132_UWS7FVW>6,L,:gNILRYK^ZR[+M
M8O9QD0M+/-#ff]g[]GW29HLbWPLQ-=4\A87ObS^.O.#3b)MW1K&I(6:d1T;OJPN
(&e0F8[R,XE9]eB[<LDIU2ZNK<M@bPZL&T+,)C>Y?#+P>XWXaGd(2d7>^SS9E9+5
f00D1AG.a@.Z(^]7Z^J[,cTKGL2LZCXFFe)fFYf=WHb[4-7Lg;Pfg8=e<]E?.NNf
1FXQ([:WGL6Q]JU#-V>;:[BTD],:N45a4]YYLM>FEMX5KJ653c/5U;4eJg4D59Fd
Fa#945GGJ#NDTYV7[(Rc5UXg)SH+\,5^>db7a>],4\D--@1_0<H\d/_g-FF=#5B5
cSH[]JQX?CF[>5U8gDQ6J.Z72b8A71VB9GUUf,D9+)cW3IMAV2].Ad)7NVP9I[d&
ZOUQfZAd_QC,?QJbKSD&/G5FARLO??9\a;F2VYa8#G1-])DS/O,A@[)KJZ,)Z_MY
+03YY\O]M8E[^6WNecg_Cb+fONRB0Q);;[,)2U1b-c=J5S->aO.5WF5IL=FA07(1
K)C-8RGVQ\-G?.SMBSC=[D>HNL=e(35O^B6BE6).LA7b(@C,c@6#]N9O?c7NJ80B
68g5I0;?NII/C[bI93LJ^>Z\aB)82YIJ4GGId;e.DfK=0?fW+a&W/57@==AX6KG+
.=b>WI,[6e@3JAK30;>GCb>/UD1d&/@#:6KgV^R=4#OdJYH_J>8_M9(a/+8OEc&?
2+EUEGPNe&Nf2/JZ1B1<Wcd,dQ@+[U<6VK<Jf#&6OLLQb)^Y/^++@^?[F&#H42Mg
[2/aLIGT3H,#R7^^+S1:b+<\H5SMF<GXEc2#]<8B.3W[7E?>Da?;4^P\8@UO(Ge/
H-P4Gc\4c<g7=4=J3[^bL+Gb=7dV3BBTS[T:@_.bW2#<&4?85GID:\bH9JN6K)MU
b):Fd2QeHXU_9OLI(egf+cf)ed?a),M:)R,BALHHbI4+Z5R\YIP;cC5NA#b;-6MC
[XF@89JXbQ=-ZO#f4Z7-K3;\)/0Q2(fG<K@\Y6S;1-(XKV79D:YVg5-@I<NeZ=U?
H,(NC[-dTJUQH+N6(26XBY5:Vcc70=V><E=>()#<LDN^KLc\CQ))9_:?+58P@Q6W
9gLZO?(KaI>>eG6^+(+g_TJ(99-NXb;5RMZ&1TK-G9WU_c3<GU.^)R7+71^OHOgX
JVaSN=fO319f=SJSM0FCXFGDSe(N;HTa-K\Q:1B5aJ4,OOWG?/O&8Nc,G:f1NMdS
4),g1aU\#ND@PM06@QU#K&&-2C8.HWSQ;\0D#]eWaa;EQdMQ5OZFZeX#dg.Afc<Q
Z(AUYE+bTd-K)J6F4P1.+R,J6Ya[OD#<[[O8JIVcKB7YAY9S3LH3,?/8aH:G^]62
EVS\X)EIB:_4SNW,N^26JQTD>7Q0_4#U/=0[2E];:TX3#9^6bE(\G(X_F?<,a0=,
26F39^8UZ&K)<R(+@,)9:02\>1AC>)AU](cSE=BAV5a1QH[)0+ZYA,/9C#V&R]?^
Bd6F9/bTIM:.cRP1DG6@&2G=>VNI;91\[[.UZ-YJGR1&Q0N/KJgcB8a592cXd07E
JZ/TLEX_9fAaY^27^0/ZL\I/d8I>fd-TEL_RUc-O0=?F_+_Sd;[F3>;+IJ#Y#L(\
5>BBAAB)O,a)JTXQ?VEe^9O2K_a6G5#RK.J0_;_Y+UES?+G5N)>1cC@]_DV]0:_D
-T[D,U[DEYa.<2G[9b0;4,PJd[A4JVZ,-W,=N/R6Z;^3HWO]050?U:8c@TI&(_=1
Yb2WT6NX[M]#a<;/#)RCX:#DW?W):0#.BD3TD0.I[7YG/,=EC-J>5V0cU1@/GfY?
?.U/TXfg87+=[_@&afFK#8O1e.I=6a8HB[/]Q2IfAX.^-;AMU4I2RC0D4ZUfS0H@
CD&c4SBb<\S:aGIR,Sc@4=FDWTDbI=+6Qb:MT(>dULa&2&,?1VMHEdG/TZ@3(37Q
BJ(cQV+ARf\N--.Vd,)D=S4/?5[5>c0@((^0/#W>f&W;V=Q==1;9WF(QOa0L61YO
OU9&UKN@@-^F101)fcaO>6_:T4b2c8N/0C_,)IAgE]S5aT<HE8USe<dQ69HV.)1Q
@.E/7MGD9YTV+N#LRQS[>QA6bM_H@\NG(LNeZ>/=cA>IU3#F0aGP8fg9]M5PcLJ4
A6#(2dB\G\U:e>Ac7GMKHN8LFH-(>0.Y-\OF&gL(aUHWMBE5)I>I0>\/LEb1A04P
bP.a7&\9?1U]_a?bQ3^UJN.J+,CFWO[4_W/+9&FK[3CHcH[e7=D?0M?84,f9e[:A
H-=Yc[Q=d:-9JF4\B0SQ(;L4X1YLXD^eRNBH?;3;#dSH33E?\+5)3,W+A8b]=3,1
:G71^NA84SQ@H.;9cJT@E\>](92&;cH1UZ:+/(HI]/;YJJ?[-IC0PL4VQMTe51:3
K^:=7ef]bHWV81^1-O9&/.;\Z3<3cYR=\L^K;[1=M-8E5XJ@8+)Bb,O@2GRaAI,a
W]21?Aee96I@T_>[TVA1Mg16JK6#<b,\_RULG]5J1OfACLXTO@B/ZOG:fege^N2D
>D[&[LDT;O:+SHVYFU)A1Q<6=<MHH+1,]>-OT-W;5ab.S5ab#\#BXbK7.g7DFLgQ
R9S]F)B8,B<G9RVN.K^JI?4ZK6T:be(WM<4JY.geFYWNMJ.LL(F>-[5f#cKgCNX>
SDHJe)1&LS[2C&Z=N<EK)A[10L:;GX(,P>E_gDS?g02C\_+g#8c<MfMbYHd619\V
eSBP3V[]<6=J>eQ:15<QffcY9B?U<f+))/,]412Y1R4]CFHe;/WPH_RUWJHC&P5D
<d.<BCb5^[&^RTdU04##,[IUXT1=;EL(N]90NWRE>&F#+^I&aP#EI9bQ.7d5<+WP
]>f#gMcJR.QYF0^R-9XVBfMA;4GS.XERG-b4QVQ_SQ+M+[gI8ZX539;:CP&@XUgA
OQ1=b-Yg_FSVUB_aR.G#[+RR44=cdR@c[I]<c#CRe+]_W.6_cQG:EK0S#UT;)<DH
dQ=,,R^fb97DLbXC>B#JC@f9E#D8)b.&SGEEO8ZWP)EI_eZ<ZB4-K1#_/b<I4K]5
=L)Y/C1#D]_&]Og?+LRDV^(6L2fdM?UIIR_A2#8#=:Z1A>=B\gg:S<Jg9T]AADQ]
2JKUZFW0<;,2KA;-A2OYQ>GZ7LA\Wacc7;b8?9M4MS/<?;.B<3TNBK36:\][4Y@7
<67g=]Z2-CVEQ.;5O074TG/4ZY^;(g_8f35HccU30gH-f2KDOPO@HE(KcXLgg\B-
C1TcK_^/1Z=>;;FFDdW/b+cJK&ge]bX\:Gd-5-@76PX7MCdK=WeU2T&8&K&[\\)(
K=cN^IgBDP,gPTgV[&=[cdQBV?3Ae3O;MacJB1N;[&4)QB57_;g1G+]T\+/ed86g
AGbT+U<8d>Ua##g2_<L2R,4K)BS>3P;EN&VW@)HfS^H5a=-Y(VdHg93dZ?A])c0N
@>-9(>0;NSVN]_[C=W416JLW#?SJ<DR,,O7G)PFM82>[#cX30Pc]KWfgb]a=2OJM
aP(NCK<4b8^0)=OZ>Tf;+;B0>[M#MBO5/PeV0g^#1#G=>9SgA[BUISaW:9M^fX@#
@T1-T]K-5I-/e,#MfcB/9KFVRLU1<T-7R>?^EG@7aK<?]-GF^O4\L5^WT\P+b(5C
]@-YWDEXEY9VT-f#MD]+G>2D)7/;FI66<_HgM:MD.2S.XB[X=0f9@,_>CU^=EgVN
3=&-,INA-1N>bL-SV>.cE[.&A5A8a?@G?E_Q#7@Cf//QI#E<^)e[H,]?I?7_&+/I
9V.[S7)YZ43=TWN;X1=]&5a71OYV>0A:URBacOKI+S4XHgC5Mc13La#G+b__7B@+
@_L>,/7FZfgVW0cG9EODY>BIR60V23d=U,Ta:O?IQF5<?T086(^QQ@W:9M00aB7A
7IHK1.eEH6QCQ\=RV=41-2H6Tb>Y]]L[92H2>V849T4->>;6.JDf.[bXSdAGIK/b
[Na,@PJ@5OIf5?^9AP6^UTN#9:4#9[1_a?c>U0b@cSZ;RRZe/I3@1.@AJ&FE=ZAD
ea;),,1NI#B^bd&\=OKVKTMV&A]M]c&0[;aRRE=OQBLO=/9,3G>-Q.9.;d79(5BF
5cJLT?J2G7^15/=M\E1(6P6J[JNSV\TU^K^VTE1JObE_1QP/-aT,^NdMTJ;7NV8^
3Q>IaDVLR)X7QbVA1H]b#-&HAUYJIN<(C.@SBX)27C_LYF[5b1I(52K4:F@OZFDd
XQ#:e&M/\P++VI_P&cJ]B4NS6.NOPMNPPI.53MAFK2D.41MS;@(1W,YKKa<FO_46
?K7JW:0Td:bN_6W9L2Nc-F3)b:NKIEV4@;TL]Z9(Jd>SJAPc=C2;C_.4AUD\W]X3
RHXDD4f_7EcYH<1GgF)@PDD9.8+6X^]/Zd[6a;&A&P5g:>J,3,dGYEKd@7^0=CBG
7g)K828L(@:-);#g@f;MJTANfRZRE5JGF-(,V<8<BN2b04d?KFPD6aSfIA(XVC;8
T\K^eKO-0U6Q?#.40J]R<9Rd^;]YEFAR\b#KVWGdSZ4MFDY&IL1ZL^G3^Mf+bU](
>P?ZT2W,Y.<OGY0N+K<^9[?O?ZHW1(g+;S@_L.WGTGC,7<><bE.H7e3_,WNSK7V^
LU:O4X)C9@8aQ)dfM3)-BK6\;NP?Z,)(2S&LE_ZFIN02d60dKJ1X03eTJ8?2I)8?
^QU-acE^]fAS+8U0@[<Qd;++8EQeBPA7Q?Z32R#ZOS8e08Q)9EUL5-P#G:X5JKBZ
1\>K/LD\]0bg83BYCcfa]SBZF_;V:JKB[B9;GQ?+cgI4.6M0f((68e4bILeYbM(a
a1KbX5._SSU2Me9[0O:7L,Pb,4+da?+gR6+g6E(B4g(5;5]bO\6NQ-TbP:?#>Wf<
CU+:A?+@Ka6LT@4A^eC,,<0dX:KM8eV)NJ[[dR#bGU+b-Wb)F/EI.\/9V5a58d(b
V+UU:S4gJcR#90baAQ&/3^,f6_c0N]5US:G4^c-V1DJ5?F^RKGWb+?9;4]Q-)K97
,5<O?67PUT#Hb(0TK]e0Td#:H=Q>X(aUUE^:c^7U3]]b==MWVg+2dTZ^DGab&D[2
#1fYX2AXT&RY:^f3[+bR^Ke1NS4R?Zcg+AY4[</=JJ2G,1c/XB5=TH9C(A2?RGf<
(OI_Q,G9,8I,f6?f[3dN>C/.4F95C_WIY2+Ob-a8PN3LZ>1-/U?_baNc]@.XA][/
#Y/=R4X64;BOA8R]/VaIO]L62MI,ZL].N.(3C:=+N[&/GWd#fC4d.O/>EMZW>4CQ
:,AQ5#c(2=OJ?<X(T-L6fQ[-Z<@MR@@C.TPK#0(\D=[L/ML<#a2P3,UQ\0[7<]>H
ZR8/+?YCNVE2LNT2VB[^9g+IRKZM-eS>[7e/\0PA6FBO6a.g/7Aad[+,BXS#:84e
,1_89^g-Q#,D-:W5=8&A=&Hd;e?G[)A=?LN1[Hg5LJK2JF&UPSUMO;g@I>Y78d[X
Ube/4KVGM1E16TRID]H@6_<>_6>OT-1d&2)<:_/aUBYY]YS-8V-FX8,:bc[VD/L?
DHE0R22/NMR>M8?AI37RQ=70GE;HNT-Qa?ec1_,CI4?Sd6JL]I?/8?:,ed?5e9=D
3-G/?_[:#S0(8UHGX]AO8Y?PID8V:=M0V2=O_W-<&I8gT#D=28)T7.E0_X@&DQ:B
XR3[[+Q9b@#DORLO4(&UTbCFCH2GGN7Z9#SgH.P00YE&4D5UNY<E7=VV8Y:@.Td]
fG:#+ag0d4G@e;0XKaK8TD15D@QECE(.Z6\XCP8d.Tb:LRW#:LEJ>Y++-)HX=)4V
c0@d,bgEZc&=Bc@\:H0+^G:2+VV17]50.9LAI(cb:^9JBX@+FIg+9+ab4KaU<EYd
2Xf:)[Ag;(UB.f=HVT2(=Kb6Q[FLK&6\2V4&@?;>@W9<?[Hc\U/BJD@HZ&B3f<1]
YL6.^]K,;YRZbCFG-b2DJNHPN?U=<+Y;U8XJ,?#0A/S^P1_dW8R^&19H?\]=HdL_
RSBL<^/#/5IC0ObD907BIZ/HI80TeWHVZ9MHA6Q@RN4eW.=:=;fRZ\EWa^_]5cP,
SfHGaTXe^OcGS=LQeC+HNaTE.HO-cEb4?VUW#ERG(+c4S.(^FN::(:Ca?-YG.dbM
X_f&(>__:NX19<4GI5Z.a0<,S1^3[g963=[(Ed1>Y&).Jg]]5GCJ[54a27VWY3)K
.+I42bQ]#[T-TO&fM(^^+Q2K;O-P;T#-:9FWE1>RNC4,?U;aCNF9W^=Id_&O0@,,
W96b3Y0>UGeB_?FeD/N^;_WQGMLE2:=SZ/;W#O4H85E\N9+:?52fP8KPD,>0V2#f
<(-#@]->IRE@gSH<Zg(6[R:0G\DT.LCN>G6PbZH:(N,5UHT;\NN8<5DOea2K9#18
P3TOBJA\4;g9B&EIc2d+,9R/)d(_B(40JXF,gF1I7GT#[?/_cT&W8cO1Y<YVB@.[
C_D5]cMA=)dMc2J&(;],//#@JO_98LL-2G&Gc6SPXdCS(?7?EVDH2HaKHQB?eB4A
TAL>gAS7\]BTXgA;1GgEE6<S,?^NJA_QV?dLQ[((N@L)dURI7]a?d^,/eKU&(+OO
WF;&H&:BcR4SC]#F3>:KI+O=@-+#Y_98#U+PO5cRD&^5T[d0T^+2F)RSe7_L90af
c]XZ4J@YH-B(GSWWKTBD>5fe;eYE&#=S^/LCEW:&,KU3HJOFDA4C@2KdPUbH,(ae
,YQTLVXMJY;BcaC9=5+UQ\UKT&6?]g;2g^VA=>:.>S9g4gCT_5^WPXWFD.MY+Of5
BZ@cH4g),O<FU:3B4Jb4e->6W^R9c2E#c9;,dDJY-I6?=;8=M@Z5Lg5I(7<-6^SP
1=VWGW9b>>d@cFeAV^_)/RL&UH84O<OF090=DOKLV+GT&0-0R(02^CY>X;779,^5
&&daSN&2XCAA_2,__Tc0D>bM@#13H@.,BTNNV8#3W1_U^/QKWTLb84\9a7Q=bJFX
:UA@UCGYDWM@\8JQN7:J9UbLJ^##G-cd<e=5eQY?;9>QS?S#^HG_DSEbLD46P/^8
Ue/V^RUe\P8R=1M71Nb/;84856S.U7>JeU-:9/H561e:SI_gC6GN1VdF/f33#-T#
\,M4R)10>DD7?E4[Z2(GC]?e3NG_cc&#aE&Y./.(+V919?Z@]a?_2?XC9MSV+)B,
H&7Q=G)?NR=SbReJE7c7W\^;_2CMDT&O/ee:@MgX15KF=ROSE1BD8:4d--2fKCG4
=HIX?U]J/,S+[U1.f;.?X[Hc90TK<]SCLIW+aAeMX?OR^2>&5QDAKM>;;C\Fa\Og
>0].TW,f3?<,IXQ@AC_=30HgCV;WT3A<\CbgJZ:EZA/5ZVDP^IDaJ9bW4\QB30#b
ZO7bLb5R,4:RG4d@&a@O#XCgA:LcA5NT0Fg&YM:E-C)+0A\M\7Q;]U3(#.6<K,Ve
[A9,42d#^8FTMU=:;3WIPJ09)gg)V_&23CR:<R@WPZ+Y^;.g?6)]Z6FTVY&6&E#4
D_O^@2fX.2JO>f97:+W8NR86-_FW5>.\9RbN/OR<J7LP=?ROBFJA\G6S)X&/]@aC
e9(B6E?Tge<Wa1PS+\T/IgW?=)T#C0I4<LM^/XEH0_CK+\I_43+V1f]G51&00G?a
S1\<Y(5C@BZBB3E<Y7>K+ee&f[0(Y6L3HRXEHWK4-FRD/7gJfceTe?N?Z2g3H@AA
]_b1<H^5S\[KYOQ497Va;\N\?8Dbf1#Jd?&B/b=^[:.#[DS4c]D]BB0fSMP>e@[W
7Ad#Te[5,9]]7OZ:,ZIaYL.UgXQefd66Nfdc80>V18eJeDF-ddLWW04e?1g5D<W-
#A,J5;A1Da>5bEAM2)TeY5c.UUF(#<?Ed/dGHd<#[WZAfcMI3)0D(S2&(CWD=C\Y
Ee3[.G8aZTaTK5a;8Ggg=S1)70CXHNNa=&[+&SN_[NK[0D715L1R>2ff-N,(J_3^
_d0/aX];DC=QTE<]KaZ)07\fP7H8YED3Nd^6I1e0_-XaIV:8B+d.F0@##a\@,?J_
2K.HI3.dXV3fCX.+U9IA-0O^c1+9-#e5CUa(&+Zc7)X:SE[]9;06#:4:#+C1FFUd
8#QE<2S9L_<D&23PT<P,/[A\@];X)Z;L/-a=FS159+,@F3]W?MS^[P9FL[cC_3O,
26[6C@[-\VGA&4BfW._3>IWT;)Sa[+[JV+S/A>:]+f(]:4O6V/:BF5Q2^:4PY<FS
M:</8+RKH43K_1a@18CbR9Ce9/f]):VIfTA4Q,3X-?J:,EAH9fJZ2RJZLfUIBFf\
\-]g3V>S-1SFTc>-T/<W)D=J+07#2f3YgKAG[H(HMJV7]&DVMC0?Z;E=5F\)g=5=
Nd1N8S)+17a4O7;N6f>gdH13e1aBaaX5P[dD]EYNJ3UPOe?N&KA@\fE=cPGP@W@J
Ib@H.b>A0-.^VGOJ#;:I6RJAE#a^-KD/[4C0@BZcTJV(bJ98cU8IA@c#a\a<QLeL
6BYQAP(B@ZC90^LRZ/GH+4F9B=0LK]#^7/4(g]S4Z-EPI)bBBbce)?eZS)00:\^0
03<A6SZd1BU</PFa^M.DX6HdZCLeWC-<dJ5K>/78.1JaWDY#.SJ>,AGR(-4V:bQ?
/7GMD&@9&Ab0N&Y8TY?^>PUFJ9X;R7(QAb_;R:R5OPAKf+EJ.W:J<2^]M@#73GEB
XgV?V0UO,0^Z-C;&K3#TZ0^Ce3970,]F^LCZ3CETeN5O94KV)>A\Ac566LcG;;GA
8ZJW;U(a)^+7X:+/:bVW\>06Wa19+]V:Vg(>2e:^KBQE\=_6QCF6ZTYNSc_T&FO;
g/TI7EH]H&e@6^c#Z]N>AS@3cZE>D?;\?^H2.@E6=1fKga97PB7eYVa_CZIg7AT)
V;WPUT[MX1](^4cc;;FY0-B:I1]HF#(TAAAM123GSCE@S<\OR9E]I:FN[O_Hc8PC
-<RV9XV;5,Y&fe/N#IL^2\#8&1XL\PbgcWS7?4/7&J<B19Q),e65U7&UOD24XKcB
9f<eWK,0TV<.a8)L5HX,.Fg;,&8ID)7/G5D8SE6QH:MENGW9)2;;>1X;UP5X6AC:
B0\VEb8^Z[WaIS[&@RGHB(;;P6<#O6J0&(>g1\F4Td4AATZ/5O=SdbFPGN;69<=J
<HQR]?=+=>U0Oc9_B&:I_(ZBO4_-#O<La;TI2&&a\\:[+gW?B9A8(?2.Kc:a6O+R
,8=92TQS9S<GdK^L+B@G&XVLE<@3f1F&5E6>D38/KB?ER)/J<D&4P_4E]8AQT62)
4]AL0dQE94ROcS[>Z5&G)=BZLR,2+a16,M_;N1A/Q(L@Z0C@I3YZU_H[IbF)QRO;
5^ZM](@8fG^<Q+c+Y(EN\A1QU2X)fR(75dfSd3OVA>YOQ4E6028af3.^La,J)_bf
4Lf-6V&:\13+TWf5PF.UNKX32T;BeKbW)Q>ASA9Q.dAULEB@[A=cbe1U0+c26d..
bQfK?+2gFWPI\XWa2H)2.^OYN7HV(3N7SGPZ@VVb&a44?&C5+BgFL@N8XV-9XEZY
1?9?U1^.aP-:#7#Sa(e-\7KA2WH3_N:P&J5GP;S6&\U5W<I&T:&E4/9e?Kaa>:gG
LMH+N?HaD_I4Ia&aXDRIR:-fgW[7+AJEDPTdBNc5Z?+2L;8M/-;S2<4[f.3e&J@a
LTLg&#)8]_R_O+Y#+K:+QAcS0?2BbMgFcd_E][=?<Rc]L+9+25J/V-0DDWF4Y^+A
C,I)JfNL,H-IXF]]W/.>,eR6CA8L6)WK;=CJY#JJT^X9.V8/;GHM0fcR.\IB@1/-
bSegN3<IB>aH#.-:#7G(ePU&XHB>2P>WK_>>R3^B:g7>aP<=+F&3-(K6VQA5FK3U
H/9O-=b]J947g<<I]?S_g50DdT4]I3/Z=5M=<[D)bDB4CS;Nc:9<X[bAcKOJ&VIQ
XA3P)bGOX0-RZIaM2[\@;Ig13468/=I(AWPSX\(G[1acFL2M?[]R^@=,4&Q;>Hc@
4bb#H.E,I(fS,S:L^>>6FKL.:U5ff/D,^V_#dS#R-4D@bBNf;=bOJK06&eGdY<)Y
A)NXF9IGMPST(W-8-]H-;NF1#V+:?+E:N=dC[:]7#b_gW3H6_L2X9N:B&##(WaeL
7^P5][g5+-O[EHe?F.(H<AH/,2YHA6Vg3I;BO0,?(EXK@Q#A6;Y<.64SOJ?;I2H1
DI7aQ(AC8G@MY+TD#U3>e7PQ?>5e<A=UCO05/&IK.P\(5>&VESTddEbfQc;=DgDb
f@N1JUcCeTYb7G^TN(;_K(T-1f8#S/N35K29E&UZ+aS]+-Aabd(gJc/]JeE^1/GU
bgFZM\:>+YSZD096=FS8_E;JTQ<N1^Mc[A4]P:IJT0+?Wc?N\FI0:1K1O>M;\@91
[]+J-/Y5]0HF<Ec6aRc,:gT24N3Of;W:b6L1b_]ZJ>C->G;YdR^;-98EA]Qc\/:R
T_SY4WfS,ISZ1S/T68;9-W3Q7&1>Z7PeY=)5X+4P/ET89ZPF2N?V,88FU;;,;AQ2
4V@bg=/=(#E?D^#Tc5^0S)5_4d1CB+MA<M[M<T)RF-?(,4KfMe\E)QZ3FQQWEHWc
P+f_K6Y\V1Q@?FD_1D6<O.2\AG6dg1&WR/#XLO:_@109Q_,J7\gI>;WK0CM&-J7.
IX7&FA1cQ0<2JX<:B3:IP3;;_6a3R4[1EGUN1\.IZ,E,?FE2S[#8<Ed#20WH>^B=
4KNMOX#/bb9/,Y)VP:He5?\]EW#cXYe+5dL9ZO&@CVQ_YdK4:ARaQ&HAPT41c/ON
Q&F.G(2IE=cF4b:WZd,R;/fg-\:g-?9TKKT61K?E#6ZROYC^/[>1CM<:;D,FL^X-
;W[2d3\26W;Y]SP86Z6GYNSWYT1Rgb,CGE]\dNe7KX8BMA8M>Kc3GGGJ4U2E(?0H
.#98EJQBX9&V:<=d:d0W)=N-.0=FD.@4>7MYed7/4B2XJG_KeA>ZR4]NC2[X5+;8
SRT@PCLM]f8^>fCf]dJ8cFXB>A5F7?fdJg0+LW.^VLV+Q@<a,;BT+EYU..#C.S9K
W-WF_493::/6P40(7]AG4_K+^(Ud5.1BdY\/3]Y^gG7SfC9B3.X0bM\?/XLJIO5^
VgdKMg02^GJ(8ZHO#)4bVR]OKFc)>PT1ARf8+Rd67WPL(H[:R18/E\@_)13Je@+f
=?G8?RI>1(<RZb?FVGfb;PV]P\?+a>:-IGCO#)T2,00;fAg(0NN448]^f#OZKddd
;><7CbK-O3FB:U)<0-,c=U[/eX\>,cAW@_M.F0E;M.W/=(=#PcbAeEBTFTK[#Uf=
_)G_cN:Z(c#0(d:e]B[/:gYZ;LZ<<;->K/QJa-8M-\YNF0L_8\HedR3(PVSZL3;-
W_@(CI#ecXbX_d;SFNT@X#I5HSFg7?+@J7.95NYGXcN=QGJT_bgYT.L0JBb22fR#
/6\AT?U0TeG9C-,afE9fcNQR/F2Y;ILIP8e]+Ib1DNf0bF2FB[D^_HVY91+85_AQ
;<=[a=CeAB<CZBUbQNS>Ub6P/Df_d4L;F<Cefc;CMd&XGdW4G8c11+K@<[5e@@TR
8=IGa+H9&;\gXb/Y@@L(J(V5X53J]AS4U.C@gK4;(G\IefG80.@F>4<DIAcM;1O:
/Pd>M?X-[RPdQ0+K0Y^Q#P==](R@/fI_gST3#b1]VZ3N,G1QFKDTd79;A:GR],TL
8DRYQ5(2TXF#F:72CU9,@U&VNMQ2)CDR]]&DQ,/&8g>X2B##60KWYY1:::8B_?19
FNc)La1.-[JE#3<M@H<29&:H=L.34#>PE?M8QDa:HM1R6W5KVGVKe4]bW\baDUX#
dNL^gV+K+)345^V.-2)^c5RK)N[_9U0D[GPP2.8a>K3f2/H=LVV3BL)C1]L-6/S:
cVceY+._U.TS^D7&+1P:R,](gQ&b<]CR.?-_U;3<:QAfeKHY9g5=]+3YBJW&ae3Z
)GZ5fS,dIV1B^GKW:=Z=B4^R+^E0F2ZKU>aL.#/g4a.HW1JC/?,@7/dg8])X&S)I
dWdgba<?AdHW4<f<^I+L03C@ECPaFB706X8>(#G)82Z\2\A]#HZ_?N[D6Y:?.SE2
@TA=D7Y&F_MN4,8Qc@f#KBc,,e?G0<UJ@#Y-^&CMC#K4P8.J73UL>Laa^9>36[d:
g#ZacQ22E_SC)ZZ4JXRJIF:X/?c[8,;>MGCY@g(ELX?>Qb_IBKedg/V/4;O<_GfF
gb86(EC7.]bXHJH,+V/>NfR^dL-]L@S4<BfPdQBSaSGe@?CA[LRK5CP-aTK](\7^
@0\V;8H(7ZYE7<7QZ&TWZIbEWafZIdBNFcdg0=HQ6=7-.CSgEf)GF4Rb@RKZ[fU^
La-Q/7d;D@M]W1[.dS3MI^\EL>>D87:1[FT,/7^K+B6^]SF5FWVE575a)P^YEOJN
9LA:VgMZXDYe3#446RT)B/6-&a\OA?];92PXSd.[?EC^E$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_UVM_SV
