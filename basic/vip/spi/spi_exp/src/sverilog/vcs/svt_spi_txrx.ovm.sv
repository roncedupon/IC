
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
UVWP+]_d?B_Z9L,IB.7+ZA:TLLMMY27^/+BZ9K9@YN)9dK:>D.+c((V^/9[-/<4>
?M0I0GA/2g=KCP65>=>.A?UgHGROI-)g77CRZ^6ZK_MSJIFVOMbYcOXK5#B(0Bbc
X0;ca1?U8(AS(VKV8S]#<PcT1=@7+/=KCcPbc_Z=)+[Sd78JOZ9LAK8XEaWZ#/O_
TIIL]S&MXb]JOWGCSe6;E5A/8/YR<2f9__76-K?M.)]50Wd7I;UUUEOcQJd09_0S
,P-R4KFXaDQW_()6HXfB;2M<R<gd5fUQ?2KQPE2UgD7GKB/G<D:KK:.C,+9DAc?\
1T+F.7W?<JDW1398_BcI10,GJL1D/e-E14?,@178K6C(HJd0P?NF>BWNSMc;)V86
BTG.&<-^;2/7894S-a.G/d;):=1aF4NO+#N>)U=IcdA^BMHRP.,HIVTG4,8G@A]Q
Fb1S.P03a_;UK\5Qa\Bg>0^,UI(7c6N4S#dJ;Q\G,&A3#a1SU(:P.A<_2E(,daN4
,LVOI22XCXJ^\+L>Y=S>V6)&_G5==Tde4W][(_&Ff2DS5KX(?9.D6CYKIbXTc4_c
=\ZgfT:;?F&U.<E56bNbAPDD@C:MT-4Ke#53FP5gbDOK:UQ<O0^gH+-[6(M<+aW(
(c>F1I4<2\&bcB^E547A6M[<,K/&Q[TD,#N^?C2g[YQK2#SN9DL+G//TJ0YCYVC+
=XV3H^A,+dHFa6;?_E(,8CNc(WTMO]PP-I2e/T13S;DI.<^8>Q>K,=0-G,?K?J7#
g(\)UK)JeK-H_:6(]U3c).=-5G=L.bLNeSJ=JNd[g,CV.41b0ZMNRgVB2R<BD[be
JVQ;K]PTY8VIaW-_<88/DLe^U6T@I9caKLK_9G_DC-ZY3eBfO1T6?)&2K&Hf_<2g
TACCM7^]]+f2@L@N(<R:S>b5>->XH5+1?[;F.<V+\PH[@-))1Qf(FYWg[RM;PI0C
Rb7LUAeO[O9KNV&[29:MPc-8<cEc>K#4S9BePHbZ4X19/.DDO?6]K@H.@JMD^Ibg
J3XM\1\RZGPED(a_G94e;.YH;&O<4g5,).=eOM-2O>D2VP2a(EHUX@gGJ&/V&]6S
a8X7QO1bLOCa\#,cd)3I80)D\RNM?XYc80]H:g8Z^-,K,1W]_cXL8;f<NL@A:4Q7
bWR.K[3W1?RI\E)Se\eGVf7S-(ddeDb>#:)(O/a/25,7M^N2V9VCUd\&@<L8\#5f
-c<V.TR(:&3;0H>QT-00;544B^-13CNX./L.K]JK,M.4)dW/6I\\OWFN-<L3[FN.
I\KBb>.3WfN:I(d6ab[]e6IR-c6[Y5/-]P48(I3e3?&RPIPO\F]^C56Y/)+Gc>\]
>G4g\;f,JB6@4(;e4_NLKU0RR+((2B(6_#?+NU9N;N-_5>G[7P<SH01Fdb&D4?;K
E_X7Q3eSG/54>OE/++RJTQ2POI@bbGNQ9,):]J-R),&/H?1+^WX.W(D;^dTg)+?U
RCKG<&^:aNOQa-?>G<JNfRJ-(@McIfR2]gaC_^7B6CPbQAA/@>>^NR)]S]=g)VYE
gV8YYAJ3&^8AKKTS/[6Ub_,UW)<A&NQJ>F,=YPEg,.7^PO[bU>17eTQY>_BQ;+M(
(BT@c#V8UHgd=DbFZe]_VDd.D_P.ZJ,-c?eHbH8>@PP<4:A9Ic>,@QE2&CYHKbX7
ZD@S7=c9+.EW3.GETZGS)P5QA0Q8dX/c+/#MJ^Sf#&]/O<I-66W.:K9@Pcf-<(3A
.KcD=<a1O_B/MDSA(?Z@6I/F,1ME&N\UN]LS3&Y_XI,]DH,f#dC_c/5:5M6,\JT1
b>V1Mg2;BFXXK47L((g:E-Z24&6N\fDef:F_,&ZNSMK6(IE,2SVf&^.+)VH^<:9#
D0^8:F,W5[O,HbW:YWK7QaeC_AB5.FA,#3V?-AH@RB5EcG;)WT8?eS@IL#(I9K-]
Kc(KPFg>fJKW,OVQUIg;/ZJ;_]9aS)X24CI.C_Bc-Df^d(.X#NHZY?^SCD\2-Y]:
VHH?gabJVL[bY^6\Zeg[b\CKT\MI:N;-D0P([5GD),]#3:Kc=eNXGM6VV+X_gS2e
K>HaJS>9FJI.aA+>\d=U78Z\WM+NM^J;0gdOF2ON8)V+eea[CcQ:L?GB^&W]/CJ=
5e/)OX:FE,N@6#DGDT,<MFa9,^fL0V#CX4MX<)dg8[V,18,T6H_J#4)3[&UCGZOK
+/TgP]8.M^\Yg@9Y0<POH]?TO[gR/V]/9VEO/SJ7Y;F.NCBO9EZIdR7.X2W&eReS
ReR=LBK-STWYKY#6YEe=:Ic6d>=FH7X3XgVd5]9^/4f4&fRe;PQ5-gP138VCX(XN
G=HL]]F-)],<b;..S1d2BVJQ2g:R0d:IO#6CG95FVS/fSH.#eF24;VKbXTdRK,+I
(_c?(PA:0^2IA1A)bD8->V&g3QaXO/+R2VZg=M1:W1;&&OWUN^K(:9MLG)a]=/D-
S)IRY_02=K]2[gS(5F[A/RdBbU_6[Y4#W2\bQ)I,2dY(1_E\5360B\U]NOB_6\H+
M#,2If4V_bC_bPO:14)f/SbWf\g=#5@fb?;EQ(19JbSW;D+R#<KUEgI>07a-GV/,
gf/:)1TY@YQK=D\?9QcA69aeC\b<X#>R<6J;_OD7.RO+a/+^1@He>Lc8S(BFLPV9
/VEF[NDG=:\JC-^=8g0b#fbP4#IEC10IR_a.0]f5NbII)737D/UG_=@2-5a>9W8\
Q&Ta<K:b]XD_J<d0,0:3@fRBCc3W<B.I>XFZ.fF0gYRa+PLH<B=@+ZZZ/49?74GP
c.&HH<0JK0<J#_AGXV].E)7HBdL(B)J;P79-ca3[1/cTa\cT+[/_(+5SWKQMXHWD
LX2Y,)cX[X1e,<]DUH]KfYG4LDL5)0b/Hc,#KfR568[S;X7EIO7[KD_=.F9EPX)P
7U\IUac&DPLB2Qe(Z8N,:b3[;P.;5=<XU\P[,3WIG1<7/VCN61Tc^g2&.OW5Xb/C
SA<1XEI)=&>;X5WaHSV7beAe4W&?d^RLf/BS.&EfVY=AV5^VNW3_6?DQ:U48EBF[
\CW#>S^^e<6J8?aOSf#L\:5T<7D3D?;C#&O>bS3@YYU<62P?Z\J@\XB4LD;a[VIL
)/0C0,)fdI;3cYg]TS?<4B)N(S_8W#5?<dU)^D@?0NCaY_(&U,YBJV#7a^YbE?dc
-;EWDP4>LL=YbR^=]W+Y&78#]OWagRY7,>T4D&aZW\^0O?Ng#Z\&)\0Z.>NCS4_2
E4+?aMVVWG.2A0>54e-R#X,WIMVb?6cU+0#aE)bd3#<Tb.6/9:F6^KDJ7+>5L?SZ
35?5G^30_b4E8&9dIJ6L.5#V?I9<)>HC9f3307b.<<&=Hb^;CN>A.OX.Y9UE#NPE
X#V1,gJd<UKY<B&01N3&;K7g0#C:O)KfU;-N.?AQOMa0bP72Z_bHbKMUTgU4VJPV
ae6^CE-:J(:ZfA?/&#/Q,5:+ReHbD-QN-I,KW&Uge<8<&O9^=bAO\cNK,GT50S>&
F,@@ZeI[.Yf(PGI&Pe@,B:D;1X+R^(J7F03^/99MJ3VPW#@5?De]L<bKV@e.a&ge
<KC<c>9.57G4;JH0E&SJ:6SI?fI,8DEIN]4,T:,ZH>>+,V50J(WP7D6AX0V5UW#-
_MbX;)A3RG6:DPc?G-e:J-a,6I&;OT_@J2J3FbFLQK5CD(0N-KO:g.fX@KQbEBT/
8PSb5KU#+Yg^[,4YgWgabGM_RPdRT.@C-gW=-WOg9G6_KQN5;L=^P?<U[eWSLH=D
NZcgcJJ80TLbG(#2,TIa56BH_GS>,#&a1Qa,SfgMO:ZKTF:PI@b,ef+ZF4WB@c=7
NPUG106]BbXLg8Ie?/?9N:E7(BU.g\P.E7GfJb7BU/E(XOUT>\fAKHQXbZOJ3-IT
H<e9OP;Wf]T#dP+EL3eQcc1C&3=Icg>?J/X_I\Z1V3BM=QWUU^H_6[0I;W6fO\c;
Td?(G0Q@_.]>gAOLU=9])[\.XK&P8]EUE_X?<f.Kc59dM+9VM4S:7&756X&,^+A<
9M?TaW+_F:EEN(-9\gU]>9B(TA(+\g20&)[K64#JC#3QITbD;E/\aLOeI>1-FaN-
)NV],SKaeGT\;1VI=/>0O9]O=cd7VE9+)BYI^Da2N8^P/)[7YTWG1dOeP$
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
>d08+.DR&=\J@3F[HK-V->ZCP8XMe&H:e_Y,2e-8L:JJF;/@MX(76(39^PV=H>+0
c/Z@+:/=LV(#-#+94F/eBfN[g@bX05@R@eeAJH(&VZ7Y0NYFI+4:I(L1#fZ25OTB
gSM;Obg,c.CG-:a;/5I60Q<CPe]Y;@GZ@)H/J+gU\P@bRTa9d/:X([2+4GCEHHR(
9AA:_MXE_E[?5H;.G&Z.C@#L+MOAfS=?gN29\C>BRM&:TVJEdPI6fL>0V)OLK3f<
Wbf>_g7(>.[S<ReW2-e.BVD9LQV^fcE9d85f3\NbKZKa8@=JVLg&R.C[:^5?M:b^
3B)J.c&.@#92/V2c#IY>^GMD]8DB_F\JT\2>33R)WCDZJ/+8OF#?ZE6.?Nf1V2+^
gAf0DPPeeRB3#a2TR:ZBeIb_C-f=7,8=G5;OY:0^g[c,39d_1>JW19_A#P9LNJXT
QA)F]6N0F(0K:R8G?:-GX(Vg;BaHOYI@,ODL5-#ZWGFeKJ5(G,8L,^-7MS(@,5=]
#=YRAVUNdKCV^)3)CF^5JZ.])Q&?XLEXWe+c-<;ReNgb4cZU3PLXA\I^Z=f[cb])
6#?>IN@KM;^^UNG\KZ\:4FYQA]3NWJ4\.V\g5gcXQYFNR[N,f6Jf;eG?Ye00]EHN
g5,F&^:9)^<48EN=_4a]6@86O@,H/5UUG[SI65(>>3TS07@(cVAIG6RJ+/(<&#Y5
_0(;#43[JA#A51N8aQ.\c^PH2eY_1=e=Z#8XO\N^LT4e?Y?;^[(g9PRMa&Z4JB3>
:EK&0aMP8LH&;YHB9?aH/SBFX&PN97\>MS\7A:L@&U(MQ[:c,PBY31dEOCHgVDDf
F2g;L,JE2?O:eDg^C2]EO7<C+U<Ef:IfODEES-5G)V@B88.R#dUGQ&T25gA#bG9<
DWKZ(QK/@#;PH.aK[Da?L8VTG2TZ6<X:Y(#g?,<FA1(>KSUQ-_#Cf(8JQ;?APDa:
.-EJfe\^O_T,O34PI\0<?X4,a:.bV)DL)==(+bea)K</YF>d1,Y8>ZKW9OeLU0aA
XSO#C0M.VH-?^8Qc:S7VLKY<?/:-.d0+A3bQ8J&)Y9,(fUK[FDFcN.2P;3eZ,XR9
bb:S(1W,eW-fQg_fW=8-I7:(;/>9>G]e=6EI_>+\[d#;I3Z7J)^PRRI>(^>cBOc9
e7P+=QXd<YXT>R#I&Wg3WLa#T+3VUHc]HLgL1QG/RO2O-3D+6][DA1Z5=&e8f#OX
c#:E][D_cRLZWPHI;Q55E]+=B.#48TSEbWGc0cZFJ\AY-:@H>W?e)-A:@(E3?_4U
/ER+8<5+T[K.A0XGc4F>&-?\__TNWQS72DUSKS?4\V[cS=2]^-VX:K1SW36:][Ld
E=Y]=HF.S3.?c0A<F5TJC(<M//GAO3Dg88d:?+dWYff_+:N-2D-3Ue#QLJ(5J-\\
-JA@LMN2+2ZAO:56KCS,C[NY>.aC9B/bK-aR2^JJM\.]TZ;EebC/V=CfS(_1OC3R
UWC>MPFGV7Q/:c^(4HD;/ZH_RZ14Y34Z8ceZJ:N7IR\EW5P@<+S3GS/?#\F#8MKX
#G/RQ7YY<OZFMF=5T9VU](Y?_J[6PNN83:gdS^aT,BR_G.Z)]Sc+\eQ;3F8W+F79
LY4E8E/eU-LRc9ObQ+>+1_#]B_WfTU7C^Y++8BF[K7aMXgR<e6KV4R@#<5=bE[gV
N[S,6.F0KgD9-)W3PX?eD9KCZS1AZ9QgZCVZ1O:PMOf-E)^>C)=SXb>;W_b_a6GI
5a8_<FK<(0XYN#H#LN6U[D8g;^L&M@>B+G,_g+b<O-Z.#dJ6:#65KX=\GOXFT4c1
,bEK;[.f5?-B5-OGA@?]?M:TB+,fXT(CRAd??a]<2H7+KZ\G^3XM(FA1KJ(#2A0C
,6&Z1bCMS(NC5;HQ92UWDaUdV(I-I+E2;3\L9Lf&,2eaUB)>1e75Gd8&G5K,-WVR
Z@TZeaM9..?CE.M>/4K_gR1;_=.B7<b\Z(EF4H8];1,f;J_TP,?7TfSDNYg3A#NX
V::dY;]IP.W;NXCT7E)XU3XDB)E4^,aHHZBQ?#dZcFV-=IYcP-V&91K@dGTPfd_d
1fI.fE3F\,b,M#H69.)aV)(Fae/_K7SL/cJ>H5\/[b3#aHSDD]?<_2N;/BT[]Q6^
38[7XI/?I0BB<XD;R-;-F^2fSV&7UE4A#,Z\W)1Ra#-X;BF&HSNDAPaU#E6,)@8G
g#9E6a05agW\V,T3\((a/McfCNQOR->NVKJ8D/V;XF+AVR8L71D1<b_VIEg&?AF@
M.P(2#N/BgMHc35U/C2gLeFB>2Ia?[))ZMaJY\NJ<+d<.>Q(?CR1<OW30\,a_bN_
41\g0R-N1=YQ=@<0[PI&c/V7.cgEPc-A2L_a#cadQ6H4[XB0:^C;SbABWfI_G>WE
<G0J:6UPY&/V?32(P/d2^][WH>KC7@e-MN>3XSF#K(MWPNPN_&1#QZH:_NJTdO.L
,_TZJ,++_3YY\#0H,?dUF#?@FA268A1UeK#X/G/Cd;+];@4W,.M\gIW<J8g<gK](
@MV:fW92N31&B6M(:c<XGNJP/.PQ?-HJUH-PNGL(L?)\V=0TNGAe?\[@TASa4PWN
CKVVBc>a69f9-8G#aM77<VMC^L.Y>(:B/[(_K<Q@;)c=?,0EB),SWK8+SQ1-UH4=
gS4g))A[Z#f/Q?GG<\LB6.]?8_PN:E#W2V6^H.T@G@X6K68_@R5UHSN9F#./dcM@
60E_LTM[-0J=>BS5J1eZ;>9=JcG.DK5LD&c.,>LB>6\U/K<4B3TO5HW9,<T2ZJSd
S+#CA3T=2/gaZ:\21GXR&f3@aQEKRCC9(SK..2TS>)I;dUWTLL/0884X490WL2?b
c:G#CGM>?PKQQBK0#//Off+,F9c1(=G=BPfYSfK:QCT>QRJ^)Gca0cg+e7TB>S)E
ZJ4>JeAFX_22c_&6.N?R\Z(QR[&RNdP[cP?^6S^D-E_#K.YMP#O_=c<I]Qgc5V62
/2IEA4S^W<a&.ceROd;MG.OV?^X,OUIdDK\;8W\3(#DXaYD?OGgOdVOJVV4_c#YM
L^gWDJTOT4PS=eV_OH^f+_HAJ_.H_HDe,^>X#R5#.M[)>LUf1DbEGbc0O.(c]0[2
NEcXaAX:GSK/&O9_#3/;2E0WSeLcfSSfCI6U7X&70?;3fT3=#K>3=4K8b/0VFI.8
<DX;D1E#L@Ec@@1Hc,KV#1E1f#CBG.PAb7Q5]B;OdVc#?1=\?4f8=E9&/L[X/]@T
C.Z;2#NC2b-I\Ig@K]+JFEM&0OSaG3#GJ<<<_BW/K+>Re;^]]D,\B=;\96T>ANLO
Z8dY1K+]+R,4f.GE:B^V105]d-5,G]S(=-P-:E0@_Oe;Q4dC?NL=#fUfOd=e6g<g
I:e)PJ8<)EL8&bKH&#7aLNS;UXK:M9,QHTR)d?RX7aKIR&+LdU)5/ICEF41^aI:H
bHWd:&E@3;6]V0,=49TO=?W+7gbH=0cXd0:4O73XI7:8[c.MUFH/#Ka[^dFQ9,0e
:8]&1>)bFL3^8.MPA8J2WQ;a=Q-KN85[I@EZd7d+@S.da&Q&JHg#eUg1TI(SfLGH
PRV_L2C]K\(f9]/0U[c3#[AZMWYF4f\K^bfFM,,CYfMYY+@TYSK0@4IHW8M6OV4e
QOLB.9V9F3e16U@K0_[\6F7&XZ96FKR&Ud;,FN-<[/EY+:0;0J]e?SdD:24/Y55/
4Td3]G0:ROFNbDH?2NWgV=RAZ)>@CQ)[DfT[70MdICM.3]eGfRaT+[;Ia)U,]7M<
J7TW,,/+OZ.2e/U5b&JNF96^bT2=FC.J__-d<-M<IBCWI(a5;<\+9XX[5FYG5A0.
W;2K/B[64d=6,Db34,3:<\UT4@\<6ZbO=W-&&2D3]FSNWeM_eaNc,.KWXH[Wga0P
EeDNe2J?[HKRCIJ&8#2RI<21ZYAA+cNB<?6_E,Z)_]DZ37#2.4^).K\0=BET^JU<
a/HAEJAUASA7F+UP8I[;cd#?=,J1T>XB9S\G?(WNSgZ6#0C0;AJ+:-JCa^[gKRc#
0NF-LJ.^FO(]7L38\cXWa0Z1\_RMLBacT7fVf,#I&;O5]?@EcJ(PY?V80G&(6JCW
42:2+P04=,-N/IFXY2b8T+>#NDd(fAG)9]_=9acg,;C\6]X_017HgbRc9\7K?L2U
LR]+O_J2GDe8]NeWcI_<;:=IRI<&J_-V1;C92AG8+D]V>2TRC..6L&JebSZ<K6&Q
]DM-g+IeERTA8D=@a,=R+T62gR0E:[&B?8-.C\Y^0A;)_3aeKND5gQI>4HB)_(K2
cL7R=ge0PRPfS^Y+LTE1@RK@.e@Q[KDE=S,-RQ1=<1^4b,IOK^0&,KdKFE]g5;NR
]_7&6KPA,cWU>[DBde^Kb-cHY1>YgA:DGGZ^aG],Q[bb,g^ZcGXUe-K9&2&,+X1A
>QR,8fMQM(QKeW^AZgH1>fda+B2QP>2@74(?=2dR,dWWR]\a>L(G+Q/[\(#&Q;?,
g=P51AA>eQT/2-[O(L>5Mc=YOe8=#eI(@4cdf:1&AYW6NZ>H9\93IWJb,4L@Zb#f
E=06>(66-2d#^CP3T];R2YXH]FJV3(6+7W,_G#a<0>8;&#KP>ZAZ&O-FPX=G,[PZ
/(e_Q>>1B1-[SO#9Z=F,X_PSHb\,B&Q<dD0]SYU?;N_]BS_5.7HM(J4AW:e=Qc1;
KI;2JFEODfI(3SR@ecEKR=geCTeIZX8O29WMf6f93^A(3,g7[B3/c^MP1A)Y+44.
0V184-<@(3+d0G=Sf7NXXbQA<3b4:0HV=@=R>2#NEQ7L(RGbLg7_K==ZZ33Y/a7A
1_]+U=Y9M\Ad;-_C9EYa(+2/+T&\V7:>&CSd;dac^J>=&G+3>XK1XVgcRM2RF<\V
UR:T;LJ(.@^bL>B[>O@64P=ffCB,>&CZac_Ue820eE&A)@H01Y5<G[]I=[:-58Z;
L;WT0W_gaR8OdJW>?b,UcE7(3WHOY;?JWPC54]<Z<0;[Q,)6HM=eD5gX7&,2?V#M
:)X#f+[5DCTJ]5ODeJNLT2ZdV5[WH/&FA#S4,PTe+d290K=[1IT+G7-X\^b5#GN?
9R+,]=&2OD\I4DOgYd&c^OPY+3?cYUcK1YG\=,Z:&aYS=5@TPI5FB&/_25ZP#e)d
bV-035c)1SD(41dY@UK(M)MO@XgQ2O1&@I-SDBGCSMcM60e[UFZ-/_][Ra<+9fSL
FbQ+Td_WFK#RNPgJBQ.P#1EdL>/2a6+FNCL3\ZS31\GL=PX^259M&5^XU^]K(M.@
\KaDB64\;f)Z([#dDF5MK624(eI6eCU#5.0;fYNVg;X;_?(Z7a.0DVb_d6a\_S7-
NO^^]04[a&=a0-8QdWB4@.VVe/:J6M8F?@L(Cg6^NMQ.E3/JU8g:f0ZBP4@MC&GI
K8-@K#;1cdIHG>M9CBI_0M@(?R/#9>BWR/=@;K:-cYTFOZJ1M>-CGUK=_a(#;IS0
B.MfEN;C+N0R4M4-FLH1B,b/d9I92PU[ZUG/MR=8HYQQBC9S7G2YD)]+a1+?<f)O
:g6AD56^71#f)E4f[F)6bRb8+Q0M17+^6=,aA3SV+gcd+L&Gb<YC=9?0)/JgWdG[
&R?T7B;V9(?V15]6cce;<\6bSGE3Mb-U+O\_/#a2+ARa?YMHQ[_80<aHT7d\4F?J
YDZGAe6^BT#Jb=b8\3W8#bO\5@)XZB7[PRSPA?6E#F/2QE8g14(Gf?_C+C88:XJQ
;+@JX_@b44LeM]d/aV(ZFMd>F@bM+<Y?12^>9W)]BF[:91(F\EVc^ADeZ7U>T1E>
ea=ga5abK)Q;C5++AKPd@4G1;SY>gSDWFa?=[02);I,N,UI?^+K14_^N.B7-#@PK
RdDVb4G_()(&>&)PKd06G_I:/UWXAV7VHJf;BB9J1a\A:1XbgRL=:JWX)R[e2B\6
8>=ZC^T)TTL,c/@>7@K@+@4^1_Y[(86J]/,97WP_>_25bT3:=;Xeg4CK&Q+66-;Z
/?#P8<K]\NZb4&N-eE8?@8_5.A\^-3CeU<O3Se,R__E249F\7JZAJSWIKFg.+\WY
LWdAG_H(\35]E-TG(3N]^\c5&=SPDcfVF/R^O,6Y@JN46UZaUS\b:ZRR-4(TR6?/
DA:N5VH:L<=GO9UF?AaCS771;5INN_K1e4S]FE-N=2d(QGL4@P6132bF39>\<6OI
=0?1.@QFQaII#)b.7eQX/PJ_JaH9GT[?U_4>M^R2d)#0<JP102&0=XWJ@+c?g_<I
G/J:,:,dK2#<P@4F8fBK0:VO;M_?7G?Odd+J8E<\/191De.D3gUe,g]GIG#4eMUa
?f<Y3-=)P5X[4<R5Z9c#A2E:9]+eW>HSK^7+_<0[.&C/&dXfdNZ=BFfA4[C;9GUP
<cP6QIff:2B^,N)>VeKQW[,>4E;WE:MOYec5UNW736cgV]<g5X^Y)VgP2;B.&dZ1
BT)@QE+Pf+4gOW21a^ZNd=#a)^\g:bV=H5D4N<V6>\4).NB;\+(JVR4+B=;A([3J
[LDGD_MM8MYIC,@Xg[BN&OL#E.]4+Z@g^H[GR]SCG#K5E&TR/R2UeB7X3Oc8bE/c
7FDEOd.A:]2:H+Ag=+99;=^A1T3]);Y7_c3fYLEO0_3L3?-2QFWU7/7E8ABIHMM5
;f<A@5>^B7OM<G(RY?2UJ)3(]_BW62aXPB_K9Sa(6M_\g::OcV\KB0M?d?3__16Q
RF=c#NR??a^4/Me@5?\,N[ENQS=I/bGeV8aJSJ[A()R]ENVc\HW:3(>g[./:LO6E
e1J&L8ICcdC?W/NT&,N]@RU__D_E\FB>E=F#1WbdMe]e^X8C^TPHMfDa@9Q>V<d.
BPFWRRSR^Od(RTY3=g1<),Z:^PC0G;J0e2W:DBeK71QQV1FB9eI[GHV<S\\P?OcK
M4((3^ZAX[O/(\[Z67>X2_\]WbSB=X,@8&?\+D,BYPWH7/fIU,A?[cXR=(U=23Y;
V0Q>+=bECR[1FIe6aSX-/.EW-]^.76f)&)ZZX43U_[3_6M\]69SgR1H(=EM?)Z-.
5IUD_7,N#BBB#MU[F-aAcNZ4YCW,:HX(,H<_g-^.2?MB>L6MP7D>Efb&MM:A&:KN
FIf5#<B:Y]E#:-[D&--PN#P:E]B8+KX8E-&gGH.?M0E[FZWE;XL6bYI1VI4-/Fe-
,)&ISRGHAW1@W87F1Q.C(,c#7OT#P#bK?5;TTGcF.^7T#K;M5QYe6YHCK0S:(>B/
R@K8,fS[8XFGdVQX#)4^6E+Z5-56:J.D4HTU:BH)O4&TI/)<LH8LMASHA51?V[UM
W9^^QR6R?QZeI2Q_a^A,9.P^8U]AA(]fHSE>g#VTA7<FP))FX\d)V>6?E,^5BU4H
D04d<&/KE1dcPfQ+)@Y2LTM1eG#_^G@#D@]@Pc370J(LIPHWg^#L5/@cF[cC,S]J
/HNaUC#YZ<5g=_BP6VPNE+4Rc8;?Uf;Ab<2ZACb;Of\L,C.7P1H)?K0H83cRF--@
_P[B7d+_U)=B&]<AT8HcS51<?)VAe_58HWV/M2LfU-W#EK]7^?8gXCUcTOP\a<a9
SU]A[=NT95B0f>9?8TQ]Vg.7+>?FbR3]Rd:B&D-BQZ>@Egd=\8A)3.<Eg43g,TbG
g8U]IGg7UJDX#2g93@ML;fIa]Yf6(Y:>\CTL>+MT.SV\\Q3P<7_Z,:&eVc^e#-K)
=PI?c\;V,^WcNCd3K@WK)Z\\O^6#:5<LAd1S^B55<:[1NB0T,ONFMRA[>SFbMMUQ
XLa@JJY+R1B7S;[>S3XIbId.L5#KUX_)B?3C982#^cQFC5H]HJa/cUG_aWg\8IST
eCZ,;_QfaA^8cU8)eeU)D@a;>A[RMZ8J_egH2//fEH9S@\QTRJG;R?KBPDcSe@MY
?#@;4I]3\(#&XKUF?fABgA5^/<W,e.9.-ERe?T]:,B).)CGe<f;5>J=c^dC&_8Oc
Z,?I9^<9V&>Ff>AS,Y(cT65A(Xg1-M=(fZ5E28?5)BFO&>SfQ1W9(D<cd+gRNH]T
W8_E8IYD9)?d8+CZX)b,T,-[Z77)&78WFK4IP&7#0>PB<g?NL[4JJ5:/I]#6CXN^
I].@8=050RM2\4B6S/FbVKEDESE.c&<CH]LKC)<VX;USK2-O?egKWJ008S)OSW[)
M[bEB?,#L>]1X#Q1NU-R2F23H5.b4G]LIQ,M/O3I&d+OU(;M\ZfCO5@3CdDM/9Ce
CAWJNTUce[-aUdNT6^@a&X6FL^6/3^_d1AXeYc_eN#7Pee1OFJ=?EU-&5=,1LH93
Ae1aEAR8gAC^AG9R]1<V^JAK/I:>b<7/_GV^)<M&/N_OaDT=J9d#f5Q,[:VW[;&3
[#1GC.G96[R.DG[d0=F7_YPCPIC^,>J&HD377<VCX<TfgD-R/Cg)M^^4#8H]M<FX
abU)WK1Yfc5N3YdCD&JJB[BbKd(JCLZOTZB[LffF2c7#0D(KGfg/G31WgD;0Xg8&
&aNW\JSS(J2P5)[GA#AD+@<R+OcG6]4^^53X76Sa(7I48[@28CKU?X^4].OI_&G)
?@cW7eC?Sa@F/YEa[QEMbOaD])LS5]eWW=Y&N4SW:W(M+I:QY+?#8b43/L,1Y>Xe
6fL^.5W)L+H@RMF,YKdPBefAg^1CFO<^0LMFM(+&&cUF3cF,JL33&.7ZB=Le1M9Y
]MQ^W-;X3GBTQ&\4?0NZXEPNG5H^K7Veefe[=@1PRT-SV^YT2]CX]V[:DT>dQYL,
PCY)/Jb65&(#OH6A_)_XP^f=e@AVMYVNc(SdaT]3W&:\>&\:C@B95LWR_W)E_(6#
:f&+.dU34[QMW]J&9[b<\&(HbDHDZ9^1cD\4C)L.YYIdEE1#d.L?Q=6IKO2c&T20
+GOU8YF:1JSf^fg?1EMX_#a]M;F#MKH-(5M2;5fAK,]SUJ?[ZK8[1/JU:3acXHLO
Sd_;X)cS)Ja\^IJ8]#JDA+Da.O-Y5_.E;###^=HH^.OQ>02QH2;S7E#cH4K0X;g)
3.Z:1^[;02UIQPH1^8V8T8<G&=7QD5M6U)/?.(\\.+#RgDe&dM]SETgJ2a=RGX2#
CcP[1+T:N[\R4RZAc8fa)(0>FT](.ZAegL)T]+.T+-Bf?;V0=^Q;L@BL+T=Y-&aL
2I/AQ.).DA]0ZUUL+eJ/HLS-g^B.W;\cOJ+?U/ZdLPPXX.=I.Q;25A#3,<Wf=D45
L]A1_/X?WWXG&>PV=eB#+:7Hg)Zd9RYNQ1BbI\9E#Rgf<>)>K^GI>K4=D-fUFKJM
@e.ca(BC1f+V51)F,V:E^Z42K=bEH+_7H8,-PeX4#+Q8OdW<7#5L2VK-]eA0WMFX
_dM4DENg?2,4G1b2NOJDO^#(B5KA_1Z40U^/06S&_PS]\86,NEY_^-(_89TP(=SC
WWDO<#CZ.7,X^,T/dCUG8^22dB7X1XVgP:<FNURGE=e0NbU&CDUSB?SHb(XL::0&
<g-T<f^dXU>(f<=@>,S]LaR-RB&ZB-,.COOVT@T[V586QaYaeZf(f[Kd[]=Pf/E)
fR?&)EOf(Oc5Id<MY9L_aGWZ&LKW_-0Z:-Xd93D^Z0VJ4&G-Y5HHLP>)J6^Z;M1K
1g)/.eWe0#-2P_SH^e8<1C&ISN._8:=OEfRR,\4[@d)bQ>HcW8\BdRa\-Z6ITZTR
]/UIRGfVXS<#EAZ63g24-8,I/dKJ4[__4@a)D<Y_XO=bB$
`endprotected


endclass

// =============================================================================

`protected
YeG#IZ=-F].1PS16QbB:5bNaGYb#CLY,Z]BYP2X[+:#XQM>6<VRL/)0VZ_+1c0cV
&g;W>-BH_GV<3?N@_aUA0A3Ga2cOLPPg#/&-&&OF1,1#<-:J+B??OPX-bHf=#TBf
0J8bOQE3V[YHEc)N(7G_L[:V&.(FfF30b2ZS6B^Q97T.10>9Z<Z9==0d&.[>d_Nb
GF=BD48d/_=B-Q/8eK6N#8cXcNE(RNc_(@_S&9f;^R#@=527K;([2KCT1=(QGF,4
N7.W5OSD4IZc,:fC)@dA7,#KL2G<?e:/aO60BB]>9KM@^,9]1Hg]f?&OEcXHJT&6
+dN_.(>\Q7a2NX^6IB/CFH7S=]>DOIZYC5Tf;<8b?P/(a/U?2aT[#E+O/2<9-E^T
]?NH.S<<FON,4E.[UdgMg2R#3M5;\\2K:$
`endprotected


//vcs_lic_vip_protect  
`protected
b)OKGK\M8Ve\SV7KbIH+VOQaG)2=2P\E&>SH/F[C&5/=dc7-KD7C0(@SUNa3PPH\
\ZW_@JFA-5gU?YH2^^_3OMZQ/YVD?RFABA#>^#C^eU6]\+<dI8794QC241/<+TY]
TRVR,IFZ4MS;BV,2f2d#(R]70DU]@IT8;O9GfN[e/J&8O>I&>>STB(WK[0=CON[[
/R>3\(PRY\?<)cZ[?S?[TD#U\JWY27<0+&Y:D_XEL),WLD7GLH.?WRFcbP(J,HS:
?XgWR-I.(_c#:ZX7W\(>5-G7;)_X-WaB/_NV-F+_ILf=g)+O>6#ISM#)E>6Oa6gR
^7;#EB9a[G[C#a)1KN9bQMATdE2=g4LE/O<J85_1#/VgFQZ=9f)3c=#=4,E&FT?a
U</]<3,g&WbZ7;6f:;GOBC/L@ATT>#aA08??GgR[(3Q>\RKMBU)I94.Y=@YDZfE&
a.1c3V::Y0;OG=N0DZTF-M?d-fG:W]fB(/0,PAYDe.XeN9G-J(WHR<LAILY<T/5,
S&]>8+Y4=VW+I<1.:UJPeG(WZgTU7d<bR6R;ceg]B0AfH\]2&=fJ(V2&OaC[9LGH
@&N?a;WOAY5gI8^2PQIUZgbTa.38PAfUJB8g8(V\X(=KIPE\-,Df5WCD0L,^R#>5
+2eJW1cZFf1[_;cdVEYeQF/G]J1L8@F_=AebaLLGQ4:PfaB&C\V,._Db>dNT+=9V
[B+C&TX],C2FPU[HUd=>R/gU3g0/>VTEB2#-fA].Z&#T6#76L@?BX7#51+cS3efK
VD)C+-><PX74N.^650G+ZUCTfc1BCVB#+Za_QJaV4b7X8JQJ+JUb8[f<Y0W4T;c^
>AFd?W>bS(RZ&Y72<9QZFBRTWJ5Kf2aF&<:#f?(R[S.af/Q2W;]<CSVNI;R/BB@@
MP,0f\-62)9QJ&(IIX[,_98VMG3G6?3RAQ08-0&<8DBP,<,)C,YZZ08AXbVTX6FC
VH]/5LMLMQ<MC-F(6SB]O>)dNV,\0UZ?\D0<(E@MWgPY-gaRd;AaF<gGbH^b@40b
^)OL-e<G&VKENdPM?PQVN+-3)W11cS#XN1YOTZO)/<PLP@XfTM/^>&Ug)]B4IM[;
MNb9SK5B5+U(9Wc=JBL6.d4@Gc<K]G;CF>2.I_b8fD=e6ML&?D(;78QY2M5<R#(7
3UMS,9b;\)19a@WE?XL;6JS<:..4<.A7Q@_D&F5RORS3)4KbA,B.a7Dd(OT1.?[,
K8^=G(>T9@49A=,JbY&H&)+)@If0:WKRU+[B:P]fcSGcc^VO/A_@D0ET,,@1Pa#M
5HH#\c2J[IJ-HOZ2[dE=#]6a3U8fdM-UNdE]ML#NUDI:CQb?>HZT,Of94UZ3g1/K
>F=WF]&TN?CUHM^YM<dUGTO:D2e<WP7QfV[[NP>bYb]b(D9#29UK?XKgQM#,a1>d
M#R]0HB4B;f@9,N.;S2);PJTI)VV8:8ZJ35:-8^_3-AAgUKAJR=;0MX,D-^T]g=N
<RSK+3-bCMdO3F?b8IOJ^3#)DXHNfZN:?O+/W8Vg&#.8b0UcF#W[;2BfEXGXTZ\[
E4Y#)^O@R?9)3@XdgD-B,Le)G7@X0YdEWXIb;K8FdUYb[JV,K_WF<G\gI7)LZR)J
SY]56(64_eKP<QWcOd.@O2/5[8Ed_-YE3/?AKWLL/KSD54BP+S61(]J4J\bIb&^T
eT&c,\SL5e2f5A6HU)f>W.R3DU?A0FAX3a_O4XK_g[Bac_.97L0EFOCPH7)>ZO0B
T<OI1,F>+^H0U_c9QY^#E\(LA<W2VUT/f+6R7-0P)Q5>&Q9cUOfWSQJ9Q,4L[aaV
;/5Sc\+:NB@3?cCL]Y88OD+.46U7aP9O@)e2e0<L\<UD5>>=ETA@.4)A@M2A/W6[
J5UQ_-&]84&L_D&-_=K:UCE;X1_--#,4N/[82&(/ZCf805N;a_M++2WfD@.3S^/_
@WO:@5+O3CA/\-^W-JZf5SC?<bQHUK1:3#@Ad/SU6D>X-T@?\/fJOAVF+g5(HV6I
e8S6=^KY1V.&@@b6+73UaIbF.#S]>6=0EcUa\2;P0S08[V>7OUde?&6IU7=QABY(
#U]bAgP1HSAY;J9:TM;RT[CL:0HP2=47[\W15TCM?g45<R)5BCR?:H-P,B3@8_c2
OASWggY>Gf307OW^Y=gBS0GDc(4>W_<#B>(+]:L[]K:2I]48/L/<A]LbXe5E]@5>
Z\5QBT,fH=7H\QK7T3ZJ(AEd4cHD>NF?6>BQA+.<^I+e\b,\]_d\1T>O+SA&^eTL
Fcff]bXf=b&K289g;GX;b0:MW>4eP;15aY?7.#T:UW^g&/1#1.T8GC>D/=;=@aC1
JNCP4\(bO<:4>KESP;N__E[\6(6P=O<\VD=#F.fXG[K1_;\GT:IZT7DK^;FMD>IY
aQ2=._7@=@B<df+8f^P?4_[V^>2US9aP@Cg(&M68gDaR@:ZXGfg.0\A?O[9IcbUI
8CSb^[I4ScPMUS;:U:+V(g/Bc&7O;4aLe.b>d7g^(cH&E>TJU?1(.1MBP+C8#^C\
4@+Z>+c2)=N#9_00,RdFE(]7.P@U[G[(V]BC7G=+-R;_]-:RH2Cf9G5JdZ?LXd5\
;_)g:CcIFdR6PZHUc.(bT2Va/9NbUS8.1b#PR?3[b/Y:\3L^g3XTPT+D5TPYXWIP
YP3#0FO5N?^^55\Q]bX62,&,6Y#D/Y<Re_a&7:f^X=U&-;M2H3NBLD&^b;M^PH;7
N6I]YVV]85=CZM16c9ADEd322ZK4BLCHG2#)b23Rg[]c/_\@8S@E)[J@V?XOCaH[
(BEF2TF@^><9H(5_R9/GVPIH-?;bV4\\BSe1a\bQ^O?:S9,f5IK,?>TP_NaXV#RC
_gY@VWU1F\\V2f-g[RZ0V&EIW^E3_9I<a#]A8Ud6H0YXOW+I^43H&AgJP&:UB9If
0)F8AHL<.I)Q[[4EFa[RcYf4XBO&ZU1aR<Wb#DMB?0PGa@A_@g95^Q/?>SY.VaA#
938fb@WW.AE:1OHd(PcUR8?g?FS/(?\3?@7S(EN:C516,U@L(X]11S??+ZNZ0YLO
3=5TJRgCG(8g/ZEcSAe(<fX9R7;_53,W]f(:Qe-A26aJNT2.g_Q#IATbRZX3g\Dc
bLP4H4^<]E5e-T5?IeBAX_(L()^f2NGdHc-3TA5@6#9d05@N-ZdLJ3EKD[@W,(:/
R\0aRB?A\[>+SIOdT;@:a49]Ze:&J?f8-eV=Z8;.YHNJH0L/3b-:e40H@_FO(KaO
SbgcXQ2OYe])EN^IL=Y9;2)VGa5DB__2B1/]5I\?CJHBV^f7IcgPBQ:9+/1gDMMg
YJIe(T;ZH;GMc5PG_._:/CP:&gZTAG.6PB^7W(3O4^)bg=M36EXVY]=6CRZ5.#.c
-\E=Ed][QF?DF1H[@,b5(<=N27@21RD53[=WOE0S?/)W3-NCN^f,.LVE(3dT+1QF
bB-2bf+?))G\:YWXI[K2;S8,,CH+B0(7=J,dbY==g8N/Y?^9BO//e=W5XW2J[EbI
T-DR822F&1MR^=+TQg5Ag^\bOK8,]aD8gf)EF:G6\5CQ\U_>9WTW;:eB=+)8gQ44
T/X(3Yc\2@MFd]J9C89FS;3:4Z1R\>\@XS=HUB#Z_&]A&O#2e&7)g85:WVf#VKRJ
/L\H=14B=Kg-,9-b<@d8S_\-HQAeQI;NH+.<>c+gb]0?0H//fK8b1??BA_JZ:<Pe
g(CUa4.L>JU)B\::5>f@#4RL>e\&1_(.EcT.Z<XcEG8g.JKI4#C@5ZWD4RC-K2d;
R>SRIg-B+A+9GW[MOPB/V.fW@3CC-\]3g5ZgF>OF?B69P#OUbVde+cIeZJ6V)[#f
6PBOP;(.gPYH9Gb0DQ?P=&<._S/ZX;2,,E^2]G=+.\@,DN+D+<#N;/4Y4]aQJ3U^
V,#UgE>G-A88P_fg+/D5,C73W+Yg-a&CQ#2B2WAg\7,P6>]LQaS\+U1]/?b&>0S9
5^f+J:LaZWGF7,GYU8_JR_&M,GZY[T<W&1)\::JLLHM_&O=BFGA84\1TWCg@&_bH
RK=C17OYH-_,14W+Ka\_)0d4U6^:/SV<E:0(Y^)\G_O:?T/4Q??W--3AL+_FUE/7
1]bHZL8KJ1Ab9TbWddFB?G?P;YRY4Eb1+EY:49C(JP6SU-g)RKOBc-O1fe2d?D@c
G#ERTR@TFCQXK_@CX[fbG3.W>7VEJ_MQRcNL_,Y>&,,#(454RL-?2@4aL(ZHZ:CT
ZaDe2K-e0^[N:O6?/)9?_WF?5Eb0]8cf8P[:,ZZBb57ED@8d2e^:H]08;3a<P2JD
=Cg7CG6U&>3Wd,<W(]R#Q4I/(>CFb19bSDQ:Cc&RA/E+&G.=a3HW>Sf&2_+e^8GC
S#SE=1YX[]eL?81C;[>0@-Eb;G=SCW&)3Ga9=Qe>K<@-^72.a5_[CaDV7cXbMS<3
#?6F,Z:SB0?IEE53Scc1e&Bb=J@QfZT=B+,&O>Ff3U+NM=_=,M\O/a,J;DV=(eMb
MHB3bLa#_ZH@?QGZZPE/>]>6DTZc75,Z#)Ne;=U:FdSYSXV6f=08@#NI_@.1;)PG
2aCg+ZI79K&@<8dK_:.3-NJ)^(SL[7E@fXe>^>?/[#XfF,A_I:VbA?:MG.B[,eAD
<[<73S?Y&D3H>+[88>YTH>8]HY;W&6VLF;dbR6.CAbZ?+PK^8E/bYVV8K9UV,bUg
e/F5#3/NW?D\QF^bbY+8OZNI)GBAT1PZD;YW;.Z5ZDc1YGM[KE/b-B,:#Q9c\YAP
:1Z]0EMA)?.ge0Q/3^497ET0SN^S_K8V0]d6-/1U<]g/\fI&bGVMC2IAF7Q=.B-B
A5Z]0L[]T_WSFPG&^_03-:459C?,K7VGcN.B#gDGW7/O+S56KW;NTIH/:d=O856M
B6=)8FFMA\cf;59MGe;GS9+XIB90N4NgQ-1NFX/Q0.\\f]9\:+S5_),_M8V5^(6>
1/,=QCXd#0X_.<]#\-fLYR.(MCc+OX.(N52FWR;d\TZU8M[HI+WdMSJc<[&R?4>V
4T+eTgU3>\MB0Bda/ZB9d;cEf#V+[A<#3X21KU2baKJ0IDH</4)aHg>&HA0PORE8
.N0-ReE0MS3f];M<e@,2XMIKZ7gXM<0c=6[)OVI[W<E?EDW.gHLBQ5/6>I7#QYc8
GIL7a-QJVU@Sd/CIWfFWYXP@I^PVfMd6:1^O0WB?>.>EXaG.(#R]9,2C8NeQ@C\[
b4>W2<LC8<@G5)/PF_Uc>TK>?1>[PALB.7)PLF?ZVR3HJ9bb-:_\d.I^50N-0,=(
);dVJ#=DTJL2::?1MN3M-1:Z?3ETc]W-7.M?e7.Y:ELcCM@:a>NGMR.3?;&J4C\_
Mg;8,]HG[MaGO08aP/PEY:8L0]AY]9@\9eJKR#PT=e)-P(U=0D@M@cDQaYP78VM9
C^>F5HSe)e6);H4QO57L>eCeG[d2EeL/_[PfVH\8Mf-2e<2e[G]Kc9NC>(7-G<H>
C[a+^I]W@0.53EZfG_/VK1.LKYaI54c/6E/2OU;)^MZcC.E(T2JKe/]W-Q9R-618
-2>HcIZNXT-.DP/cRNTY\eT(7YDQCO1g0&)A:<W(L_:(O?M[)/F&3W/#TKcF\,[Z
\\SHQC,\T]:9.F61MB\-7;DDcT5(UEOFG7)<5KI>&E1&#=<2:.2-^PYS^_I:dTUM
Jb)LRX>KA5eQ?aeG:K.^1J,?bDcYW:VT&)gX-([^LA[=F>QRTXS?H0_d(QO=-AZ.
V^;#.E;+#S:>/]FUVHg??H(-4?+YbS7X(U,c7GfeVTLP(ge5FSL)QXgBa>PbE,<M
KN(d_H=:BSW1M:D8B0NKDA&1a-_40eE\3NP)Xf&f:Q)M#c4V\.AB=e/geX4GC<Y;
Vbb72L47d_b>3dcPfaN>T?e2H_FeNLa77F#0O_ddc#[YM2a5B.&=S>];N)aPfI<K
#)gRD6NVf]O\g5O-W.C#V7YGeadQLB3U#9f)\N[M:Xa;W)JY>4&.&FE+.)IZK0c#
F&ZY)S>#aDNH_f(I,dMG#WG?5bKL>ZcA+A(@FU4N/4PKC]GIdML^Q2+6SU2(>^V(
QBFPe<:K;>@#MKgE1AN->+10KV:9#J[Z1<&G4LRB)2+BD_4b<AT<WDPIC32N.a6H
-dCbDgZSOc?KPXJ=H[;=b([/aD>4J8:M#S9^HI.]a>a>_X[15BS+_RLL>?EHa[ZZ
a0DA5A52FB[_cSM76)a=C_eR2T1DOZ835DF2SX7UF27f\N0@[;Db=e7+.\=WLQFM
#^ZEFTTA#V&ea?,C9>?8K8ec0V+]6>IDVLaM.^>C:-_BOgG1F.1]6CHb(#1_E8C4
e4S]#Z?_PL:IUD=U&TUfYQVc47JfF@>F?(60.7?bWcLS=SL<4MYTAAa[MA.ZXS:>
WC/G#PDSLE_KJ:8Y,:6_#TLLI7+(W^NNHU#-#&BcAW_b&<2C<&(TRRc]8QON02?e
5ReHZg9=AA/=/bNMJU7TLO8NZ#OB4e2b\Z8OF@:7JOf@X@&,-I,4MZGGN2^5+dfQ
CT3M1\8AN8:FBKXF(SX<YOf4GbYRIG.-dbd=K=T&+U^A(cE/He^G>WcA)5E20gNb
[cSZF]^2N+C8,Ifg,;S7HdB-^YG6^QWEXIFZ^5a35B44<QP=KX(.L:2(1NOTAMY=
ITE]Q60NcVA7B_Wgc>c(/A&bN9[X@c,]W+XUNL6\9Zc+2>;IM&f&OE(fEDI(2)F2
BZ/8&B&3fAN[0Z^UC[M6]X+Hb(X;;W&C)-TN(C9B?FZA#O@QTaQC&QFGQ:S_#Z?;
K\[/4M>cDC=2+^165_<R5c]\D>Vf,5>:AeFPH@7=1>?Ye+-K.Y-XgT01Y1>&Eb@Q
<5]>OXML9NQAH.6ODN[1^D.bZ\#PB4-5GU;c]1^a?\P=D=+>+>-<BLHXaQYXX#92
ZBSY^4;F9H5HC<4@A0V)Q/0:83b8UM]077dJ\>WGNaV06fA<T<1JbK4A+D,E(@8X
g&?95<T]8,D_K_TU(SJ8;2^AVS[_-NCgc;J#R2UR5Q-[;T,IeH&N18b&ILURP6eO
,TA\b98URIWdb>aX]5H6X_Y]GE;eU@]f24PObF?L@MG7,<TgJ/W0MDP+?K]SL<.N
#9_;Dd[D1::=ZHUcXadR?Q<I0&4b[964=NXaO>&VGXKA;1KAca&--V3R&^Y4:J;(
Z:FP,>McXAgZf8TJ9;dE-0QSIAHaKP#AB?[DHKX;#ZGdKb9EO/GeGQ^)JPXdG=;]
Xffg@+f7?N?39B@_-M0_9-WL6bCE5\R6bffIeH0&(NNBRJ:g4MeL)7WX787I->f_
K->FO6-C,2?MbRBCHH2U40DGQ(?A4VV?]HEK#G2HA=40M[<1#2a,f@1A\J@;DURT
=>D?Y\Wg-J=&Ocb;]=><c[KeA\aK]#2#:)c=H<=K&?UF3/UOCJdVX5GRUa-[f1(\
G@#FW,?,:g-W;-f-W9KW[6&(4e+NS74AcFZE>)f8e1g#1IOB,262g1F6_/5g1Je^
N7)]NY5Q)VeP^[eTdPFa;7\;W/TA]#5J:FK:[BY=UU=&-W\H.(L>fE&=]U^5dCNA
OgLVQ9](6WJ&aAD+,K8O=Oc1(J?Q^:4,/[HDFa]ZDdMKL[XAN3D(B&<H6&PQ-:]D
<b.CJ:1W=a,1H4cVd#a3A&2>KC8S046b+.Xb&;=SfWO&8RP>9]O(8X=[ZAZ4Z^g[
,Xb2KYW?-QID#SH[Ub2XJF3/]PF\gI,=AN@_=_XG6(KD0^M6KO.dF?[X@cE@2?P\
G7@[)P5b7T<;Qg._8J20Q.PUG]#Y[ZX9-6?Fa#E=AGgF0B^0.[P\TWQ9&8J##W3#
>=QG,H10Y2_5M^g+GQDSA2XF,I^2d1E_[8g\P_6EC6)&Z=,T<,[=R79@9BMBTF=1
+S37-B<H0^LBg5eaK/?CB9)SbGO@Fa8Q9XHEXUU9PL(8ZIYG#(7BJNHTZbIaR2d<
aX3D<bN.4@B?3RG_K8YU:f9;5Yc-:S?QD(=6]</<^>g\KBAUBZ\..[9HG;TM:4d5
Xd4MOc826E@F2Ieg+Z+;62e?\)dZaU_gGHO;;bWHA,e3+47=-F_QBJH:a0T^DHP\
fgDX?7:8Qf7EaEI3gNc7<E(XEQb.SWa?3d+JSg.K6[@E_W+30ZRe=[5eY@)2CI(,
_[L4\)@[B>E-G,eO9TGFHNdAY^gNHHHMdH+9+ba3T1/PG=[L8BXZBGVR:<0AE,Q/
cQ5_WVAH,cPQRgP6R,73IF+T0Nc?/#?FbdJ2D^BMQ,;PVQ[SSP7F=++WX]Q31:A+
T-g=N70TC0PNNF^@PL\D#PUK^3ORP+BU4\M6>I+UZ-gL3Z)#X8Z=4X2e9IYU/B.6
&<(DQbN4A0D#(H6QY\A]4CZPL&OM0VbOeJO6-1BI^gP5HdEd[McT<,P?C6GDMQ>1
fd2I6LR>_2TJ>OMW18eNXZ]QR.EW;&-05_1VA]=#RYOINT?@8[>5Q<>c_A6cP_WQ
JA_+1L?D9T@7^/UF;Xf<>X&U+Gb_RHRMMCQEREKJJ92(Y7aB@Z^CYU[&5a&<<-T9
ASc^UcLD>Y@A6Pfe-I-);gOU]8X&]^&P#K4bagZ8Wa6X#)0&<Z4P)PY&bbB<6@ME
5WY;N@#A5JFa(,_9>g88R#Z;_7)JGfKHD,R6^P0_DX_&g=8TYUaCCOZ_X96F@17e
^P1RV,,+>Mcd?Q-=Q7\=+Nc+/ba,YM69X.&E6XC2+S0EgBZU<\)8PGX;4a-]UUV_
P_Qd,<-5F[c9WK@4fL3QQ^T:R\Sd62fT/S4^,H5V)ETf-2b2]O&ELG,&HC^9]]HU
+_/VKR61<:\BMF.9O;fP#Na7.gLW9A]Ee_M(@?);8)^FJJO#29J-;7LNC:e;-ObN
&J\)5X7g=64Q_\BOL3gAI#B)c/J?g[f).B(^GZSDR0Z.4U8V\_].c70?E:>6KA<0
:N\deb>9dQ#2=16\P=-CA3#_T1-9+N^Ga.@J&U6WKCOT&O.U@XQ-(A(N^>4OB#9E
cGXeI.)XH]I)\1Y0a9,g3cVU;=](:3TL3HYKCc-Pf70Z1-WT[(&GY0@>KW\YeUU=
aMT\9^-TX/=D/.+?&-:Xa5+XJY&d.<Z#NLDD9/=\.A1HDf7(4U6&K;bY6C\7\Xg\
<_+aU<\X5cWD5D;5XH9W7aS6(2]f41^9@cf_UDWCA0;R)I1KE&c0TR3^78B=(QPY
&Z<PVHQ0@dLO\Z./^OgL?D,2]WA3a8B-]d,UZPW81K_ATERSNFMQKP?TCTM]HfJ@
>;AV5^gRAa/][^-#=\I_2XA)14dEX>]dGUU?e6N8/2X2eg2P9<aLQB_2;1C7@SZN
0Ec/&0,CNF]cbK/^R.Sb8e/OQcHWc]L??QAefBd2O2])Q6b2(>2>X\\PJYK&c]]g
5X:bRZcI-b+gCPR/BV/M^-Z>=+2FV@bH+)82b)[/af5\UgV4.UVCF:gZV\Pf&,#c
;(YEJLUB=CPK50DDgYDa32ER-=Z:,KSXF@^[7J#6aRL/cS&_#QMV1N?VD6Dd/CfG
U-:1=>eV9BIKV.LA@&,&CU;Y(1\;P?TCP&4[;)SHb)gH3K+771?E??2MGdG/:gMZ
(Y&BN&)RCVQGB0.BfN=T-5+(7bZI]-+-<.]^P.;/2@+6(2BPdXW48?K#;e&YF3R?
P<L(b\<<8VcdAgWA_+L6Mb5-f,;_D2[H1549<S/[?8>1LSHI94fdG0^6\);eaeC]
OG5K0,T0J2fOQE-2d[@bO-X_;;8LBX3:&SfA2c>3S9F0WK0GOZ1UVFF]=2Tfe(b:
:Y;U<>]f^4X1GOU_[@4WA/f0,SOZ;,Y;IMRC@WM1>LN+(#:\3,U/V&&KR[1H:=?X
RQ^)-,^Ne@]V9^?Z:I<K_;;1G0ZE@W5@ga.,DTHF;3E?G4WbCTN\:&J7ZQKAPD>&
?eY/0Ja18:3[Q-B7<7ZZ+HbZ47[VLOYWXS9JW[R\a-Z2LV_:O&SFaX-5Ue6[C=aR
Jd=3A7ICWB,R?7PCNP1OG:7:DKRbLOJP\&3(G[5b?4?11A2O7M;>E>a-E,F)B5B;
A;@K^+<-cBU:^+A)XFZQ78V)J=\HVN_Da9^&AgbI)ZKYL?d9EdCSd#@.GAb?I;,@
[9H6EQg\B6HbcIH()\#\QY^KT\?42)C[?(>b,C1Oa;]OdR^DJ?3JCUN_1&3E2ZPb
:\6<.b@EHFZa@>81-2Nb^D,8/Mf-fB>TH5BAX6<-8LSK0We7.TbJBW.TOJeAHXC)
0?GILGf+O8#X]W+=IV+bBHe_0L&F&2eG:TL>IXJI92gW2L(3-e#A\c83;4FF5@A)
KBJMHLZNQR9<.#e0DGYg2[1gF8&-EP>XJg94?0]?GTc?GaOYT:Y=^Y#P@O-1F8dH
YSaQ-E@.J1VJ<AS.O2d<N-;+e(H[3VH<1E6b\0CHLb)]d,->22J/+I&eBKGHf[]]
C:>2;J+C?TZBNd9[,8H_J>2Ee]Ue1>CZ0UXQC-2,)/IQX6(QeHREN]<&SEZ7R/KW
\+^(f.[]0_:g1)Y/84^e;CCKM/4Y(KX^2Dc#\_JPg@.T(WbZQ?WO:MB6);1#TRI/
F2;6TaKQ0MZR1S([CafP:#b;>TY@8fYHW4NZ6.\R4=-_/M]/>BL1D<]X_M4aH.=W
LF3LON\_AV=8[<OJ,.Qe6^E&_Q+bFd(d#Z>L@4OC#a0-&J/_:-8-0J>,:b<ZQ?Ef
:X7E7SM2]54<56X1<AM3Y]A+G4U\,/[HfT[X2JdDDQ&IY,_J\F08dfH2Wc@\f^BA
_D]2-#;7<ZM3H>VE,G/I[EF>GJc[JaL#<d37G.X+JR=c6CV[=1Z(RC3>aURg[NW+
b8VNM7^6+D<H.B:FG4-H^]OHAV5:4I4NJC_eZLV+EFJG6dD+#5O-PG7,cKb?,ZV&
;AaS#1S2c)F42KK(>eYfL+=?^a@ETF20.8UcUQH7<_ZQ/f:AJ[f9BJ^J3b#Va7#e
(ZNWc?QW8Ze[0EE>c+W]Sb:,MfU#T6;,/I(?4.c;/SAFGVgOMFf-A?7GQLN=Y]3+
KM=E<VXIQIPbUQU-?_ZgFC<QH0M6(9S9cSI_)\;GY_)#55^+P>@AEAY&d<B[XdF+
RX,A?2I-dJ06C,MA?E,4:..52K+7,@Ng;F,-VK\9<K<Q-K,@H3G:-)0+378Td-f=
W.>gd<)4D<P;GMW0@:O(Y5QZfE:GgE]S?:6agJEPU5H&3][g]e6X]^Q;V^R&8<JG
3?6+cYKdE\_?U:d1=,T5IP;H6]1I?K[.J\LG>O,13X^BPGP8MdV#N42/)IP[_,N6
^B-AIf/IgE_C5Y210O#McPDE_4+gU7I201S8)E1>YI.Z44TeOWI+/cS2DdOe6_2G
JT>0-YH^:S[Y?[DYW]@XFde5VS6Lc,+PC].J5P5JYL^_L(G3:/\eUWL@_XBf#\fI
=)+O7]L(;Aaa^OLZPLZ)[M#W,T@28KB2=-LCN=I<NU-.I5]G6T>\C.3SW@5P<_.a
M&UdLU[.^EP9^d28QY@8b5TVA^BBT]8(g]FG=:-KRUH@&bAFD<Af8(3a]gbLaP+g
W63d-bZ&g76^YA[;[IR?1eXF<&_L;eOU4LTg[E:),[M<R&E:I<R;-#[:V#-K?Q@9
=cQ2#5T@P4+AE;+IDc]<:C.\S2fHNBUfY&1DK&.Z.@P7-)F16K[09+.+=]+RRd.4
PTAYP\R:U8-fA5fC.GFe]SSIN#>e@UC)=.3SJXcP8/07<cJQ+=FC.XYL;B?R#E:V
eEIE3QI/0F&&Q)E);IEC_/Ze]ZPg8:>KJ_M2Z\g&2QPAZ<^cO1##4K<]>N<DR&:T
bAB]WBQSeeTUd_MP)M21;D84EMQJ[EJ@#9d#?^UaGIW:@OI;?c.(MgFN/^Q,E(I,
_^Od=gg0&6=6AR/aJZ-ReTTJS3M-P1=,J)]1=0CV<E#SFgdIGJSTO&eX<;4ad5T=
dEfRGDQPX[3K:QV3D4&6727..JeefW_a;2I7Y5+=Zf_c+C#+XSF]:>RA=,cbQ\_H
MJ&McY@=QER0K#X?:NeQ&+)BN@SJ+d)P5Q9/a.>WYN?R#S4.Q:2I78_(M]HcW7&R
2WK93P]1?C[9^9EbK<Wc7X>VY/,&A_2M)=V\EH[206/PALRN5dXfQ-QXXCR?]/-E
(_X?/6c]Eb?:aC01^);8#L3?[gLO(UPCAU&Z27B0NPOPB[R3QP&_ZL+0BZdM(\,Q
CDXMQDHBFOe2GXF295[M\L5d:AD^cW\De1TddEEJe25fd;Ve4])Nb<)-ET3?97&K
^/HaM.1CV(#)V4Gb9/>&D8)YZ7PDeW/^gLG2bBTQddH4&Id/WI<TP2fG1==0TdgG
6[UET\U?JRgT5L+2Ke9)&G=_7850=L^\09JHcNJ<VI9V91PC>-OS0++g,dM7/H@_
fQ;T3E[J#DUTdBO<ecG&FUfCGW5(T7&ZW1FZMFQQ-2CO:M8P=D5C&.(PU[HCFS-P
^CU2>RKM:DC:2bUI(J#?G=&4>5U[,<>AZ57NZa40<30cUbAQL_?]dfUB](6^>>U7
9KLVWKL7,_bE-<U,##=0M9Q^Z0JJ)0f1c+)5g_c<dGFHMEXG(#g.AO]6\/QAJ-0]
:B^EYD^f=X9a&CGVID=X^]T^J7K-YAW8bRLcD0#;9U<RE/MX]]#H;E#HaD275X#/
9SYR8#37dCEWBg^H=g8>261].(CYM74Mf>)H_FT:#9]N.S@BC<:<=1).S\F:WG0_
4TgbE\[5]QV:-21-Y-g,d=0>F(\6[26GK4QAKDO5.0@]U6U\[AN>OF/Z&b83HK-V
6PH=MO)Q83&)4)P/88PY0WI?Ba=RTBNe07=]=3#5aeZc&UgK?EZG?YZEK#@-HJ65
_M^6K)MAc>Gf,TIaTCB0PZGVaVb)-.dg9+eI5)/S)\MV:])5)#W:-U3Y;WLL39QY
<H+3f/9^JUTg2-EN04=f);-<8NHL^A,)YDN&We5e<Oe,dG6SHT];\BA)OL/=KCY_
I;#CQ-+G-a1Vgge,9/d)O9fWD.,LaUJV,A=b7@&=ZK9/34=#0c<XfaVgb[d;A[IX
TVJ>X,[I8/M;LbI^M1&gMGD6-[:Z,a8>5V^?J(^ADbQ9N/bgS^6FXG;7Q-J<E8L@
Z(2,D9U(=Y]EcOAfJC\/dD-&GJ1G,9K7&:4>>fKMYVNP9L^8a2#8XSW?d:QMd/XO
gPXU#[\7<2NOcM&bg)Ub#29)PbfBf>+XBbB)I]BcT,2&1>O0a&OD1@V70Q,F[.E@
@E4-VLCE7WD+JGMc7c@^:7C:Q965^;0AEeLIX[8c<TK2>UO5FPX6dK[Kc+^TE)1a
IQcY1\[/_ZffV;+?\<#><:)d4R9VDXTEdYZRYPYTNT-a3a8IW@0ZYb:4B[&XS]PM
=<5XPAF;Ge]Q12@0I)G.0aL2QU-4()Z).XVPBb/0+_<01R\F3f\@0b6a?\7\Y)X\
O)c&\HDXGdcMO596B1fA9NVNIP(WB+=,>Z1TU5=B4;5,cWK)ISY69)C\8OL<ZW.@
MS5b1^I\O?8XS>@>daWI8^2(;M5^/R68_eE7]84fVBT03,gUSb;gEe9IHCMd2]49
eB,]f-VaXMMI[G0@PWc+,8IPHg78?Qc-J(KG-+H?I]CQ^+UQVgEE^/<?)5_bL](H
gFAA\,N2S8MV<TEfJ2)4ece:FSG5aPGVg9)B6fM,J,U^cbB;0Z1Wf#X,5aEHEW=-
WB04L/&;]7.VGQ/:AbGg-/1?D<,XJ+f7&<)2@\YE1QBG^+](,TV3UIE4M?FP.@K:
Yd4gNd+>+^ge&IEcU[F_DV?QUXL\,&dICN)cb?ZK<B_.e/1JGd5[P/36KQ^WA=15
TUaW0P2:O:1CC/&3E;,F0BVJJb>BK-7GE.G&;I/[TC#HHaS]UA(IM:DI2<@?@f5O
>,QDC2_[MZ;#=J/Z@b;P5BEZ;JO8,Y/J\8BUD5\Q4\FK)=9.K-.-7B_/[L(GDb<#
gc7B_(6VTd#K9I4b930Ia1I-JMOdQRV[;-8P[ZSAES[JUW7BLGT3:RK2;,LS]Kb\
-N:;W&&+2C&K-H[R+N8gS+AM?^(a5I?+SZ9<]\1TaP;L81E7:Y,UJ-:Kg_W4&^2Q
[dd\A)FQ->cCXW:)X==AdSTLTRLZL12NSM>Ue)C47DLf@Ae9-+WH,GeI>2D-]=7G
CcZUF;<X[AB0<Y><e//3fIWbHUHYLDZCg<fKH)WE>48(UQI6]ZU:=X#I+J(\2R^Z
N[5E&e:U.6;WJ7b#=0Q+Hc5G7LC_0XA1+&[gD7B-@]K80S7@ZSTUWQ;30FDZ2&OU
T&K9<?;Rd98bSH/UYPYS0N;5G#PRd<F2^;8CYgNMF&^+QN;TTI79+ZYNU?g[BIW^
UafSFC53)@+,.2J@YZgW;(>7#0XY+\#[-#71dfYL=.W=>L&<g[[d5L9^D=2)Ad0X
JN<fND4\:,aGc8-?)A].)=;bdM(UOZaJ.gbJbG=(8FQT_9\2&e6XedZ--TLd(d<G
CP0HCB2af4LH71_0KVXX5P3)Q.0:J?G_MecXRL//>]\J&]+?N-TE;a<Jf46(YSES
VH^/VF3a0aV^I2Yb?@;,WH_+bVF&K:/FUD;=GdF&:?<L&<f4(7.9bX?3IW]QSSZX
g<_:-V(CV\#?JfdL_=[=?R#d[9.IfW><I<LT\F<6-V4_2R))K3:&M-^dCF+fMHO3
MR(&8QP_F.61271S.Q08FJW<NaWcD9Lc<GG+&QXJ>&>)5)ESFLM@<(WY6be&F4Q(
[J_Y/15X9HIT2/5Z57Xg=O.fU8[fd:JO0X&(1/TO;8L1ccgSXFH7Td&DgD>+eZU/
5^]8]V,V9C7W:B]+Y()WA(8TYM6_H[J^P\#GA?K:@)0V27?\5g,):??NEIc??X_,
90?#MH[/.SA&SRbcLCPXLdOM[-Y>)UQfRQIJNgT_bUM-3g>>Z25C4T6XH7Ta6?[0
DEM?3G28;(?+<;.<XcID4O@0-2K\7CMI;7c\DJG?Z[P^Z5+A4F[.AO1#eX\E06g3
7Ee&AF&I;(bfcQX[JQ,#W1(<.RFXQ_(4WKSJ2?[Ug_.,-+3)g8:]=&.>220F_<?V
/H3D=6_@9HI5]Q1\bcOG21ZL/;=dbAVR?-b,K@3..R0V5@3S2U;/bA70.MI1,O,4
Y9J[JO)X=/JN9ZQ6Od:G5+KV=(W=KP)e\B>8&B(dDQZC:]&\d#<N89M.GJN.^aF)
2BL2K_L&004e))G)<\N/<<BIc1?Q>M<_MD<cagb#Z\]3(KR?LL4>YNGCPdC+ecZ=
K<dAOD]B1R<1JJ()>Y4#^9O6?:A50IG(XG[LQ\:dN:+S<P^Y)(=&C8f9,;:5/S&(
0e;U-G@SF[94>a,D1+[#-SQT)#+I/UCf&K3NV\]2(3#f\X:Z:P.X6P3CI<fYCI/L
<QRdR;T\A2RW.X^b8GXNMGKDA5[#PDR4[FeHP(;1C0D(EZ5bR3G8G>N9B_e#=(DQ
4((SEJQU^0O;YERQb[(^Z2/Gd8SOW:EH;^](dXeZ,HLU84ZKQeKAC3&N]E,8GY?R
\@S_Ia/\8^4LFVJR?;<W?UDP8TQ5?gV9]2A7XAN612NV8]9NFNZ.&C.e7Z#\SEX+
+JF3>)Q\)7.ZH@]X-2BQ.JfG0B)Q@K6fZJ<XH.DFB7dI&[<eSTXH/g9F<CJ7J7U,
_QgD-@Y0.GZF_YGB(H34W&,7QP.<#H+/)R-gR1OM&d72LZ&L3B0\^g@(-H>JA_]1
;<4e6?g,FeSY0g?:#_J-A,f5TEG)>Ud410K(aF(OVI7RfQEA/1#8\(;7^P#V4a,Z
)W^ZeT)5D+^\J#X-/B:N0-eJ4_AV;(\5>feA#d,E0VP2[C8d[c]5ZIE00cC[>Qfc
F,2MD(M,/+)G?/K#33e@]+BE?Ha@\cgRfX;,J]V\?BQHbR4<7#:+f\W82_.F@47+
0ZN88DX]L-O?aX_40QA_@g&;g=_[F0N[9V)+JQ:E0ZVbRXK2,.Z]J35+W0RRff]3
RNT7GPNC;Q(9NYN62BJET]V0cD\9O2)A(V.\9C4L\NA#Pd9&E4F[;_eZBa9aQKRA
)IYTAP=PDcVb@5RGC/L5a88P1JG.[P3L_OESSa;WH6#c[QNf7Y]R..dX1OZE4]WS
RN7I2VT1.1LIQQIG.>/4495Fg60Y=eWP[J/OIe3[?<EX7#L\><I9]^TLBL\+=>gJ
9Z0[^a-c26e&_&EMe.O?Yd.#5,:D4>MCgDK1<^H;O5XCYGF6T>HSNJ;cCGb4UUW\
=HWTGQ6P6-;8CLI63]XCD^#LW;WM\#6\)XW71-=/W0CX.(&DLPNQ#UJY9>#YF?gg
:Z=P,QUM?JX+SLZd#0>Z5,DOD[U/PFYA:TB^)F9:AP:AM6M>W/#0B&K,1Z.)[ZJW
^T9:6P+LVZCY]?F^G&-[TX8eVV;3a(gJ30S9H<U\+Ke-RTB@gF=<WY3DS;;UH1D=
01a0)DE)JX&D30\#JD2^#5]3bM1CBO@<H.]UK3B?P6d/d>N@X>X(46f2WX@E(g/A
?eL8A-,?\Mc0;,E(:^-4UT>2&cQ=8,0YA.IfW<3&6_Yg.BXT3]GHgP&)6/;7SOc^
U84N5^dN0A]M\?\3E^Mc,&KF772P,CB&+?XA\A--EO?_ZU6#;1b\=8<X?O/\GY>J
^</Xa[BJ+0Q>0:^/=bD1\feLVN/DadC#16aG1].3#6NRIN/&WTOca6._/Z(18?0,
\9HB[6JTO97,QC-A5LaOec=;RIU?JL8afb>d<8-5VZMAV;N@cB>?IeE4g=@5/??c
HfgY^FQF/B^>&KKQ0UfWWUfW>HWVf4[6>C]#eJ-U:5.UJVa:6+HBZ2&/3MSE/J&M
#MM4@#NWE/dVH=OIdU,3R_b6<F=+dWI<AKgeI,\Kd@TaN7ZO780L.:Y(eE33DADE
]Mg[NBZEJe\6SUC5,HN<.bM)@O/MF\_cMJOC&]3@8dJ\BJ;\[[(P\F)(\V7SOS1=
,>Q/18?\c=7@/YR&+Rb#5Ee7fTQcQO/:)\R^)6/[FG:4]U=SNKLCOG&U4fS2\4ZY
,Y^+3_bN\YVRV(3B)d_e5eFX?fS:Y<#[DI/Q,^g60IB4P5QWTLTYU7P(&(L(@gFf
?)BGJaSN)c[OC(XC).4UP:4c;01X/[<]-^MVD\A/KSDXYCN8f&?H1?BA(MW<ZL.M
>\>^SH;Q;5AV0WZ(gBF2\dX6(g3C]I@-[FRHb/+X,\X-&F7O7,>F>d,faK_FS.Q)
X^8E6&\D/UaJ9H2_<]a&CP#(]:S^9=#=<^bRF-V&EN]6K1Z_8BdXI11FJ&;^I&M>
-U\Tc5VdZJg?LbL5JN;9^TT9@PCBg^[f@(IT#&?\Y5N47e_V<9Q9@;_(0_NMECDf
aUTLZ;]fQ.WVO=RLbSQQAP]b?AL,)C7V41@)SK^U3F),Vc]F0)8DB_e)/Ng_aBef
cW1K5,7&,+<I?-9C+Pc-OSXVCVIUIXfYd0Wa7<(3\]E.9;@8P8WZTgSJT?E<P#52
:7]15)RQZG4-B7cY-]T]E3\Q3S[03\S.,H<\e/N:UI70/]/&AQ/X\R-XD#ODBUY;
OSOb^]KS?+-2Y\\/NBS_T(>^,=[f8UZ>T@RM[e(,QFJNLEBc<;]eWC\B:,C]U&98
gCg\37X3_fNg6:;).Rfg8;HAYUfW[cSH6.+5&XR,eFAS7YbPT^).\F#9;O\^e<V?
P?<>_R_S)G:NK:;[BPg?a6dbFKg&9;)JY+NO:XH?a-#]D8c[W=9bIRH.DR(Vc+D2
9d)<42N1YM8,EB8,[0e?[PH69=O0^4E/4F]B.=)I(,\AOYO@FQe,_aCgR7W(-3O&
7aQH?T#TZ7TA\=&RGW4eEQ:SP7-@;6(^P?T3E>DW1OT#:g0LP1gP\4;U8)K>E\S(
;U3\_USe5[8I8@;W4P>M[MceTVI#\I<\e.7->IUUJM3HHBW,AG,5PgL@B,?/6EV8
XX?NG1/@cMRNgV\?AfBYF8XOZXN&R7EgbJY^WG>G-(YF=]BL]g,67c0=Ee2,gURZ
>V)a2Tb^-<(++NQB&],E<CD+E25,,BeBGgEHSAa(TWfN6[\#AX7TMC0be@Z?0@8D
H6Ye3HV_JabY]?a_8#2C[(:&Bf=TN_g1_08N;=Z_,QONM/W03)5J-:ULNbK6CH[)
W8L_;SZA,D6D7=IeJA64K:JA]8(BdS&<5f+3MgX4L\TSX81g)12>=F.9_Z57AU&^
X(Icg-W:^.X-#[;62&OgMXF9<,&b];>J&WB[G_DfV>UNTQ^:BOPAD=-dDM\B:@PV
0(fL1)9PTAPe(XcCNA89,L8S#,S=5O,dfS:##]#V?AO\D=E0&3M?TO8O/1Yd_R-V
YKY2-\YUR\0;V&15YPANbaTXZ7UF.3//O(0K6^AUY9+cgL>Lf@5Vcg,]+_6-5eY5
IYc-CeDSV&5O49PK-(_@b69R3)UE@T;G-<Gd:0d?C]^D]0H1E=_.2Ld#RZF),>Y[
e7&H_93Z9\H9JMVM=3U5T/_0-W>TAM8bDTB5VM)RC0P8H.N.Z1C;Q0FN^7=1YSUI
7MF&3RB&,-c3.??_<FMJHASJ:QeGfCTKQWQI/AH-++WL7D)cZ_[:.SV/]X)(C#J3
6RQ=CE&8)@+?K\cR:0[Zd@]O>>_aP0eOWJ^2JLT1C<eRS2O<)ST5D2=/E3(Sc)/c
d^7/8>>(G_e)bJ0We/Z_SdO#R?.T((@<UQ?G200S5CC43>@/>D<R3;/f9KBVMQ&W
-J#:#KDRUOD=V>>Ke\+QeTPEKLK_2\=&YRR9\TYBgIJ#c+]QV1\DZ=W-e</a+.=S
&&W@X[B@A:SM/Tb4c9E&9Lg4EgC+d+>15@E7Zg,ZY45K18>^_JOXd8JU8I#dVI:<
=:bQ^]dWJ:X7DF\=<@LH-+1CC]\RNA?Cb8^Tg1^_;?R#0eBS8(gDV5\+:VEP/<-R
JI:HFR=f1DcB7,@Ga.34@Qe#3&^&^,>6+B0I2b@S779X;>b]G]SaL(/3791:2[?=
0e\HSOIG<JcEUC?.E-3CY/.IP8cg1)?=Wa=(NHVD^9?3^GQeP,EZ@U60ZZR?TfZ8
M<8619L5^7?\[<gKTf^cF(58T9B;>J59_H<c6-\5JQO0_TY(F6.>1dVdSa6<9YcR
XNA6:TL:61Ic9T1e@>T1SC8I252=6ZIg66fG6#4B^56Xea>BW3@RbWfVH1P8O<HY
+;Xb)GK0:)g@[CL=RV_fU9@D\LGFG0)]K5a24(L:7U.24M,\1LGDP_+LTQ2\fY@c
W&D&Z2eP[-<JL79):/(d6V=YIa1gKe7D_-8&0^a5_L=(?f,-2Oa?eGZ6GPKaTHN+
-^4WX^.V-M,41RQe<Pb\)5aP<Xd.5H@OFXf4LDN;@d\7T(9QN,K=HNN(X(\BHLW9
1<H>EC:=Q))DC0&bG>]E##EBPcUA6NH,=EQAE[PUAA\MXeaR;eO/R.GHA0TA^aW8
3@=gCe62EHJGPdMg(1c7^#(-NQcKXB;B+Q.a9^E#\:Dd,Lc^XQG+fP?[SJ(fbWX]
,a1L7/Fc3-fdXNg10F2^dNeCZd.Y0M&O=-dZ_e;T?\E[85V(03^#JMa9B;=C?,K+
OgJ_9YN:8[@F_J?=X9YVgW<XRaf^/HggZd73bGC1XT]#(U/,UbMc#Le0R^eaCKDC
b:3.X=a+f-3Q/_5U^,<H#]+9:eXeOMJ2[F),/;M+S/ONH[N@0ZUGg#^J75B,_,L]
VXCSM:dRN=F_+B4f5K_)5;_(8KBM)c(I>Z#O+=#LXDR00b3d1S[7@(EYF=G,ffI5
>-c3I9<;N#5eG_9\V?H>(3[;^&0BXB\OT;5<S=5F7:\#+JD7SR88DCM8g38N)3ZN
X)OK-E;,)cP>ceZFV:W\Z_1=6B+(CRDQSX:F1I)7dO3U&cUN7f1(NM@S1Z<Z2ga,
XbJYSBH#4]75()DIJMaV>TPCdR@Z(4=a/CG@M?M_WVCD@3/<RH<gU(K_[#O[Ce+e
@0@Oab5A2<b4G9?4Y1_A&6g55TK9OYV6.G,U7Y3#XPP@SL<gI76e02:UB(:&RU^?
?e71?.gDfA#LCSREMa]55NY5C3J3;J]YHa53:;3S#@1W&0@H\4^_[AYE+DeDLIX2
^(8&,?L0.CU)ZCD-B-54LHIPTSgTGQ]73;C5LBFX0OAX:Y:LEg=L/+0;1gLe>=O1
SHAMgWG(NJe.d3]aL?U6HZ\NOU&=M1=W4d\W7SG#M6I#.T^8GY63>.I(I#]F?B&&
EOERBQLed3[c[&bI]>:^CO0V9;d@^>(/N^,]JeM>9PI#E$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_UVM_SV
