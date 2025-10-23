
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
typedef class svt_spi_txrx_monitor;
typedef class svt_spi_txrx_monitor_callback;
typedef class svt_spi_txrx_monitor_cb_exec;

`svt_xvm_typedef_cb(svt_spi_txrx_monitor,svt_spi_txrx_monitor_callback,svt_spi_txrx_monitor_callback_pool);

// =============================================================================
/**
 * Defines the SPI TxRx Monitor, used to access
 * traffic in the TX and RX directions.
 *
 * All transaction, regardless of TX or RX direction, come from the same
 * source. In an 'active' situation the source is the driver, which is
 * processing the data up and down the stack. In the 'passive' situation
 * the TX and RX traffic comes in from the analysis ports coming in from
 * the lower stream layer
 */
class svt_spi_txrx_monitor extends svt_monitor #(`SVT_XVM(sequence_item));

  `svt_xvm_register_cb(svt_spi_txrx_monitor, svt_spi_txrx_monitor_callback)

  // ****************************************************************************
  // Properties
  // ****************************************************************************
  /**
   * RX SPI Transaction TLM Analysis port for Monitor.
   *
   * Provides a mechanism for retrieving RX SPI Transaction recognized by TxRx
   * Layer. The handle to the SPI Transaction TLM analysis port can be set or
   * obtained through the monitor's public member #rx_xact_observed_port.
   * Used in passive or active mode.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(analysis,svt_spi_transaction,svt_spi_txrx_monitor) rx_xact_observed_port;

  /**
   * TX SPI Transaction TLM Analysis port for Monitor.
   *
   * Provides a mechanism for retrieving TX SPI Transaction recognized by TxRx
   * Layer. The handle to the SPI Transaction TLM analysis port can be set or
   * obtained through the monitor's public member #tx_xact_observed_port.
   * Used in passive or active mode.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(analysis,svt_spi_transaction,svt_spi_txrx_monitor) tx_xact_observed_port;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,svt_mem_transaction,svt_spi_txrx_monitor) req_item_port;
 
  /**
  * Port to obtain the response packet of svt_mem_transaction type from
  * mem_sequencer
  */
  `SVT_XVM(seq_item_pull_port)#(svt_mem_transaction, svt_mem_transaction) mem_seq_item_port;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the transaction is first initiated (TX) or recognized (RX). */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED;

  /** Event triggered when the transaction is completed. */
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

  /** Event triggered when one beat has been Sampled/Transmitted at SPI Interface */
  `SVT_XVM(event) EVENT_BEAT_ENDED;

  /** Event triggered when the POWER UP Sequence is completed . */
  `SVT_XVM(event) EVENT_POWER_UP_SEQUENCE_COMPLETED;

  /** Event triggered when the POWER DOWN Sequence is completed . */
  `SVT_XVM(event) EVENT_POWER_DOWN_SEQUENCE_COMPLETED;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  `SVT_XVM(event) EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

/** @cond PRIVATE */
  /** System configuration handle */
  local svt_spi_configuration cfg;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_configuration cfg_snapshot;

  /** Shared status object which allows components (which each reference the same object) to communicate state changes. */
  local svt_spi_status shared_status;

  /** Handle to an abstract common class. This class is extended in two different 
   *  classes to implement shared functions between the driver and monitor (in active mode) 
   *  or monitor only functions (in passive mode). The containing agent class will construct 
   *  the correct extended common class and assign that to this monitor.
   **/
  svt_spi_txrx_common common;

  /** Technology independent support for the Transmit-Receive features. */
  svt_spi_txrx_monitor_cb_exec cb_exec;

  /**
   * Response packet from mem_sequencer
   */
  svt_mem_transaction mem_rsp;

  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(svt_mem_transaction) req_mbox;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_spi_txrx_monitor)
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
  extern function new(string name = "svt_spi_txrx_monitor", `SVT_XVM(component) parent = null);

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

  // ****************************************************************************
  // Configuration Access Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

//vcs_lic_vip_protect  
`protected
:/K5<[:T.YE,37A5Lg2T94)])-29+Qb&^C/0-[B=,>=_6RJ98Ng:5(B_CeA)MPM)
?dU4A^)7W1H26_YYG>H-+6fB^aZUV=]_&#UUTZE]Q4+Y3&G[L<@63^UQO.J?;VG)
2DVRR6L9QKZJ)NJ]>>E-(gb;bP2U5MY2/&]NFST_BWZ.>:/3++d3;Z]]A?>GYZ3C
7g4WcUMea5fHbVQB-b)L#R-1#\\62G-GX&gL.#6.O3O9)@9V9CHM<_2E:\MQ]^g@
3RP.W4c^\<QX8Y-Jb0Q<>(BPVE>A+F.XIc(6EG:4DBFM51431,/fI\<@<2ARHb@X
HB6-YV^-X9#7UN),_,NdbJa&0-+M/2YA4Q]&;J76Z<RQ]&_:949T4J=HPB\3T3X_
f[:.7^B8-,,7Kb2WLL6JZ26bSS,5;Y47d:.F7QX5Icf)6.bB;)e60@:B,?LG).Cd
@MfE5ROR7^=:A>4P+b7501U+]J5GM79_X<1_e;F>TK(GL(<DB;V?43)N_<>N8^7.
?GC4#<gX2@b_QZ\O9IGAB2P-gFU/6,T]f8[(d2I<0d8;^D8dU8^G1LKSK<K7_8M)
a7LG_dOgX\FQ-f;1?5C&&ZM5G\)aGLL6S0Yg0UdR4(CG_K7>WMT>F2_=7^H_6,e5
:TQXT^RN9FRa>@4)5bOadV9aB,4.:;K0VXS)OKTYd,#Y^C>BQL.IgaWGgdN.&KU@
XbI+=H9Be45ATXLK?VfDe[JIRZTT=O6&Rg9]PF3A-6D.[GPQYTJ]4D83S-#\Xe+e
9W3:M7(L83OQUdQSC]5aO6?B7MVR/IY+YTYO0/JLa6K\)1FWLaL@e6#d13d+MT]d
HSMOQOdR-d]bC8U#;e&OB#FKJOeH>2GfTebS<ZMKVC8cPVH11\Qb[^dAETc[00]]
6J53a^[:VP2c@LQ;DBOH@QF2_I0Ucc>e?0HS1&4D4FZS:2QY@g,-^E:YMNG2X&QY
a]YH)/1_Pa4?JB?\6IFe\[-2+,c^bNT^BM4;7WIU^;(ZH@GS/D2#Z)S.[bN@(LI)
O<fIHXZbHA>R@ZF8FWD6PN::K)6RE\7Sf:I,F1C;QVT@BOTfbRE,LLD.-ZbQ.?fU
]JbfII)eRK(fGe_1VFMd;EC^;J/2T2JZ;#:/3(SLFX:R[T_>^DIR70&N\;FDPN2:
IS9^PFI.H0aN9J8NTKb:g#fTLA38]9a1DRG(6KL&YOW>L_@VGF8KFcQ2K262J.3L
&IF&:W(E76SQ.6;7RPHL?Pge48=9-6B:+936U#Ic1.Ag=#/=HE_U)T[,X7b:eTCb
:>:4+IgUc;;Z56gaBF706e7JW2-KZQ+4G#H_&_QXB:@YX\IedGTJFZTHZbKfS_AX
UgP.U-RC9@G\?]##;>/aD-K/^]5c\cM]e6JL^]:R#f>U]N/EUUG7(BZR/O7R[[Vf
L(+6]6&=@\ZOaBZ,BNNd(BYB&[cCOGPB9FS<ce/191CG=ffIX/@K]dNg37)MT)&W
H-FC&>6=F?\V1.b?fHb#7MPUfbcb1b=([W2KZab_RFaYQ=OV;^<^gQB+?->W\NKB
bFF#(]7/c,/#4I=8aV3<>G7;aeTe/[DYS.S@P>WWE3+eRG<a@\N:RU1/5Og3SM0:
.^EdD]>^b6bGAJG1&O)[3J<;b\,&d3I&CVF&dd[,]Ag5-7=?:CQJ38H2:L>XW/?E
_[<(@//M>35d33ZSQ=-,c7W9#4-e>0JE9]1Qd[@8_J)V;ge_&0FWb5XVYKHXd1@+
@N7L@Y1R:YYd2FX<X]a#QKM4ZQ3+83W^U1<KEa74/_I7^:Yg_3YK985\WC.G@EMU
L&UCTZ3E>;Y+M?/2F0AJ/987F@Z3]R-7\f].M\#Xd]F_5P3DbB.A>=:FRDG0cC8C
aM>ZV,L@5/fQ>f?GYCX4K+015AO(WWK1d3A&GTgA<E;H5>B)X9YYJD6c3^DH):;d
d;3,5FT\GRS@ZDC&;_T@40cZ#:-K8BLcA\.7JK?<Yg#^RT)NA;0dV0]>[g#6O.CP
ZaP7g29FSO>Tg-caAIVAYT<=J<?g?:]XG40[cOM1Z.OZb,_S_gSQ\JUa#OWd_e2]
R#GEdXf/GBB^:aROa@c^B=;BIUAZAgD]bg8B6G;g&D./2D8SM^X&H/70DN:@5EVH
]/G-G#[UM(^2M&^1_[ZC^(Kf9?>)36P5Af1Ca+_Eb0L6&]V29ID6FgJ=SM,&<Nc6
Q\GSG>6>GN&(GUW/?JQ_6F3E&bP9Y7AE.cX/3851OG_=VFA2+?BU00F9@GJTeQ3I
VLD6e[1D8fN<XQ[I:JC&SDbKTaL0D])gH>4Y6@4Ud\+UE;490>+>.Z1\,]1Sf>U:
75BLU9#e3PHgJe&]e@[+FD[S8f#LG?^2aWe1:g#5)OV.25EI]5eg?]=9\DF8@^>R
df;fEWE3:G/=FK7K;VQOOJIWH@0(A0;E_4Z>?,:fSBU-S\Z]_^+Cc5HIC2,ba8_U
Vf>5GBE&I\9/WP25VBJ<KY#^J50HX)3<X/G.ORR/B8c/cIB5LP8>/4b10+=KK35=
e<AG]N=\5V:#KgHS?.[IKDO1YN_UAe;.AG<6-UJgP0D\\.V\aAfZ,:YTOK;H.@g:
F6--P4[LGdC^RY(YI;6N5>E2;XQRe_,WEV(a64YU=4\WO1D4bY3eI+=#\OU_H=4(
1]GDFdPQDZCGPY,-FD6PX5J7K5gWDS&0=92A.3+bWJ75(cX6M>]d#8)3=RO+LD#_
2X#e52aOBdfF.BDRg9Y,-5BLTR<.RWb_(Aa5PdJ0>)ff@_FB<SA7YOVN?Z]2^eTT
D>aVGYV5SZ\XJRZP;B+>,2:QaY[W<WLd1&V4>+dO_b?QLgOYea=fLEY;8A)I>[3?
\+L8bPb3F\gY6(A_LHG(Z].ITg-RCA7G3/W2@F#Tf47DWKF[4FXEfW-;5=7O#H+e
d;D;N.8^:9N._N66L#3.:[+3A+J)(A3LSJC/<0]]RF7UAFLcEEEa?/UBbI68-AU^
XT@cbU2<3ZB8CRF0Id+O-\))aUJEcAS)BPDE4S=H&a.1:7;f<KK98CJBKB.0KG;S
KMaBdQQM&aC-^#M@c&#;Re)J>0(UI<R>J-RO\gb7([cUH7)YJ&&O:ddHKe];3KBK
7F#X;WWf6S_0^Q?U#>7G59-YKC.7.^I^97=3N#JB,-=OEC=T5FY\IP.Hd\WENLXb
/;^][E,e^EW[<WSLUJDcEGU;9]JB(EOfPb2GCM:&1&SXcP;K<I)3\&/MJLX]e@0]
#V/;b;eWE1W5(.B<>SB2RM<KOP\CQ2gcGQN1\aF2?N?&P[RLVF@IHTNaY6f/F?#g
eOJCUYJbW)@-TF=],ECL6EE0TU9Tf,Yd1D#NT_G2WAHPQO_cIS)ZTUN_MA8K54-M
YJ#bY46#UL?,H)^5IMe6<fID:Bg/<=LHB-GTS&0UXR./<[T&;JD6Uf9d2RE-NZ#.
I#f:Z,\WEfM7&Qc5a/(A&Y.2H@GAZ0d.Q>AL.]4K9a;O3d_Ub9OK95M.<1M2=:1b
I?81Id/JG>3a&E4Na>0@4CK=fFJAfJ20VHXd54O@,G0>AG>^eK9X#X0G:K;5bHGG
Z?KQ+4fCN7T8a8^&Z0VM5,\^OgED=H.>F^f=YgXaUg1:5_f\-]R6c^@1L:PU?IA,
=I:2HCQ3fSL4bRH(TG>X#>..@I(dR2P94cACJ@eJNIKcO>f_]GcJ13b>@KIPH6V8
#<f62=GCOTW+@.-Q/.?c1:1Q;IDG^:I;WK(/E9Z2=-K#>b]VdBJ]-A\3g19^2>=9
Uc1+f0,_TJ^gY>0JdTb&A&^FZee+9^8ZD\7\BQQ8D+H0>E2Q_\.\+MZ6EEXMJOca
W=M7+O5-K,<Uf20?R5)BJ7O&)N-.;=c?.XM0Cdf=EDT&_IOI;@F.@@ggHaVW^4R9
V6YC^K7.^MB9B#OA5@G+=<L3Od./Q9[H)(HMX(&@+7SVI2&0(C/RJOQ-4HDH5\d>
f29\=^EN=BMGAb#)\0SE78VFA?S#[L?X(4?<5_)LC9ZDP8FX5J^^EKHR6>cI<^#)
E:V8?B6KS5cg3NU2V9BIJ4VY9^?]C_L+[15-[_R&\C9&3ePRX;OZAdP#[F_Z,K]]
YW&[S)6&_F8/Ee]=2d][8.>KBWBT<?6#VG?LX67NC-HYH\0GV/V(dMKd=1ZJa4)#
O8(LH0ag<Q)[@@&=^>f=g]cN7b^[&SKIS[VJ>V08cYY[OT-F8cU#@U--[gfKBIdb
69:CW-S0V(K14[XY)<OZNXMg:3<bW0&?.2d>ZEPdOU=J&(Z=&^U=dZ4AJe7<_egK
X-S;SPg?ED9/OTBeYB9&[b=f<\.gfXUT?Of_Wed(@IVEY6^aKQ[.+AYgR6:(#V46
DFZ:D.=HQ6@eFCAL4.;L\YVg=R/SIdE8>@78?>1;21-1W]PM?3d1aILeG^1DAO>@
0XPX.BHE\?\?:2>PBeDBGWJ0c:T/f+^-;F_:\RH,5;F-V(VQ[)(^5a3S8Q5Ub[UJ
=2KEff#EOYOGOIeIeS=N57HcL^b:^0bE^J.ef[KM:b&SIH<F_g@NXTB(/>MRN,2E
W(fD4U/2HZN6NRVX544bYLAZ,8PNGX.&>+0g>c0Q=F7LUVH1&#U:7R=;[a&C(@ME
TS_AXV<.eY^a:LE-G6M09ZAZ6$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_observed_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_observed_cov(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at
   * Tx port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_tx(svt_spi_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at
   * Rx port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_rx(svt_spi_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Tx
   * port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_transaction xact);
    
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Rx
   * port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void beat_ended(svt_spi_transaction xact);

/** @cond PRIVATE */

  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>pre_transaction_observed_put</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>pre_transaction_observed_put</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task pre_transaction_observed_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * This method issues the <i>transaction_observed_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_observed_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_observed_cov_cb_exec(svt_spi_transaction xact);

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
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
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
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_started_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at TX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at RX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task beat_ended_cb_exec(svt_spi_transaction xact);

/** @endcond */

endclass

// =============================================================================

`protected
\d8G)N<Z))_30#GMP5\V4&5[g;af3ZQ@)QOZ=Q6?NRHTXU.T\,eL7)(EdN5:U;6F
SYaI4A5SfUNI?2G5IRcN#QX7N<EXGg;g(=QF;O[=(CS#YM2;GG+--21^RI)@DC]D
P&^5>WESA@X?Vd;L4_5>g_HUA>X/&?.d@X<g^<R1/GT#YY7=S-[=[BD2XX_UEJW-
a)KRK1<JSQW(XE2PO=KaA.<?1PB<<_PfBccXe@>/.OBgS@ULVeO6R_:MM(d\454g
+:eO+=AgM2K-L&2O#?cE,Z8Cdg-S/F@(bBbSQA=4L1]BZP2gVf_f;]BLLJ]MGd8\
.H8RM>^_Y7\Ja5\J5R>JZTb)1^I6[K@@7D[0(=A6:XF:5YG;@eSM(MA@\V@OT;(+
><Yf++?cJbN#[Qd\?IGOWW#..\f]a59g><QXFS3S.d4:F$
`endprotected


//vcs_lic_vip_protect
`protected
<29I./L:(M@P77L];N6H2M)#E_a)(^c&+<J6JL]E(+T8DL4BaB<Q/(SX__8e=?]g
N3G&gNCS\F@N]?OB#eWR]ZR>(IJH2[-YUVD6g[.WZMScfXU[YA8Zb,G:cI,4D?-R
S,RY+=5e/PR@&H4Z&cVKT8]\U+@E74IbY45faA=AY::?>Q(711YT(b8<QLa+_:OB
]/25fO^?PN<S/PG:dGQ7[LS_=PGYe[_M(Y/;8^7J9&3S/;7Y:;I:db:-J2:;N<_6
0RYGRa;,D0UA7@a?V&:.IONCPSe6HI\++5A+)gKD;\#XR.TD;d^GdUUf96:TI82;
2OKYAg)POdfQ&OY9?cX@+\,YX_:+H,a(?J40A/(9Zg:0?F<)]<IcUXEg<NS#GJ=G
#G,7\QS=\O8SXHEKTPPV?[D-IV@)VOae_FW_21+OK6[@86:D8VDX)U+LQbef3FgW
7_6)))Q3A;NR4gOVb7=JHXIfF/XZ>a3.ZAF0UGWE&D4Yb]X6.ba6O_@b(_[Ibc5I
Y@(RN^NCSeYD=8[Zb]]E2KQe2+V>H;K1,=DIVFO=/Q3aWKI7.NbQ;f\6F2&@VZI#
XN98Y^Xaf,bYLFY(<&]Sd>D+W#SXL4A[W0]J/T[G:&BT-KdfC&L6Q=3H\S0^0?-J
0L=H_[<d.ZGOKTOKRY];0Se#<FGR+4RAedKL&]D1B<7dF1V,WT#A@L9&7FUHHOK0
=CdAW?ecF9ZK6_&/06_2AF&1,^9<Q)<2fOaT_].71?NEbD#M[BYI&?VPRGY>W8\#
\Q:Q6W-B:a5U)W5I<VI9\91[X/C_^0>aTYT/<&<U>ARW[1XI@IRXP.>-GV&V[U9C
-29>UULPJTc0HcLP<De8aaJL>SAZ9=fg-AEd;9\f:(Z(H1JI)JJ[cHTg\UB:bR@d
+eFb3fF>?HO0TV&N#6aH8=,Y>PeIPKZO#Z,#=;VO>;8X5HHDgFT+7_,@)V920\U_
V403TUE^7F(I:a8KYJIPg_OedbGgROM.F^3UcM7WFA:7XgKW1SLZE.\ZB,E)g9cZ
f2e]G:1_+C?DC(,aRU^5)CI3\(.QC.+1.(&:+BU(O#9d4TY165+)D>JD9G2f:bJ@
[R5]@6I2N6L@CUR&.-)&VRS4AQa@VU###E(,8;77T8AF6g=P,U[06f/LR.^UKDF4
UXbEgFF+CNO2O0K?d0=XAZ_J0W8R)4YSMA3H)_RUZ@dRSDJ.dFb.79>ESEI-b7;<
>Y.7.H::0P&d7CWd)cC+c0(0;c.@Ge+@-<.?dTL<]744@UTZdYeOc#g3[#1<(@ZW
?V2)82:_3/E)=K;90He(5MN/Q/JVcE7eFcg;=0-R\1283X0c39,O>Da>VK>G2Lb+
5Bc@#8.PMP0^eEAe,S6B:0=bb.Y;SIUBU7O5#Cb1)V_eVeYXS\/@9HHAO:d&,97B
=)I,M1aGMQ?(ET+E<;HAgX_#TA(.dU_8:\Lb,5b6UbQc=C#EeeUD==Fb<74-S8Jb
Y2=(cCG@DC9_LS&)N=9GA,SLJ]J\OFTY,F,(M<7OTHHWP-[a+.:ZT=T_UUaK/)bU
@A?,bH07^(M_:AP=LUYK5SX2)U9(2b8\);Y<&L<_0<[#a_V/Hf3M[9eT=@=+g4=9
e530<MRU932X>a&Ld.-L./?>6RKQf?UIL#gJ,26A/INL^ZRa52<)5Z4BMD&S6S:2
XKcKZ5^9)EGP1@PK&9,7eHR=KGU?;)a6cA.@F?fegZZ.Y0f=W[,N5KE/8=cJTW,5
N+cC.7;De0SNEFF8UERbH.X26=G1da=Y3)1I(Z:>?2\g,YIU5O1)343dC5[JCE,_
F6d2(B#>./?#6NVbbOT/M\IX96e<UPPJ-8S5^D,EJNG,-);1+dEK)EUQ0OLf37gd
98BTf_>RUbTFRVKcT85&_9db[ZJ8/MZ++W>:eY6B:A,6@_>XPKdV:VA=<JW7EU7C
S@5,b)G_W.RD@b>Z=7/ebP5=-]:-7#<5RgeXJ?VQc/&1KgH03=GT]4)T4X;-D_7_
X31?A[c</b(RF89-0;V?#a.)OUA2=W^^NaZUH4(QF1B:<bI)>9H/Te7B6J(g2SMJ
N8b,VYVR,8WK@e]<F=6)?4JT0-,:R9L5F^(4\0SKKd<a;>GWBREgK^?_MF1>1(-d
5FJUA++X;U?aCIVFc<<cWE+&4DeU(Pf?f9f^7b?QZU.c.YBLWT^TRDDI@CE2-B;B
0bV\N@AR<-gF^O3&;EQ+;dN3Dec(8(V99^E#4.=La)Q3>dbCI\EQ/XXTYMS/^[.+
5f+761e0I]<6/4A(9a&__/MHYOT\,[UC8D?__[N4RP&5e(@:1S4.CAd,-49?a[V6
aSPdE\BV/69&+B>PQUQVK<<3[D.&88Pf]b#<0@N3&WA:&9F]U?+O37I<=]NX]7#U
G[MGcO1L;N;>L\-(bK;I[eFV-C5]aUe:d)4P[+#G/7:#]R\H1[ZRAQM[HSM\H8_U
D4Q9CfP#@2=P4\.=V^b.Q,QHKWE1cPQM2ba2[5f9:.2,9_30f.-\[,NQAKS+NW_3
=SGM1T\gbT9c&=&d?b?Gf1dF,_Wbed:-@9((9G-&=2bHO79L\.TVLTGN5M8gcb>g
1(=(cE(a,DM^bg19CUY0,^/\J,=S3DI4-6BbQBAg\eU-+ARfYJ4G)?QQWFd124e/
?:&M=Sa,b]/\^Dafb&6..X+?/D6YdOCR45S^TWW+_2=QJD&PY,;eB09@1MfAX]LE
<T63b-K]M^;SBZd].YR8dOEH00=g/=ReW.UF;7&1Of_a<<f4M[Y.N=AQ7gb@9Z,D
+B=_C@,_<7[#gL[YP64NbT<9U95W3IRc)3VL]2[T8&a\&^,>8+P^8eWg?8&>S)RN
fCDfHIQAEJA#ZOU@?699CKZd3]?\+BeNO\<g\X3ZUAPXBGeT8E.?P5^?Id@X)1)W
W6XOA:9a->)HMG+_M:IT/U9\P;7.Y/Oe:DB7PNB7?^_a#+)7\Md:^e[NYUg+BNE9
,>O+5(WK5M8BE^?NFDdST06bb^^MMWc/>=4+eT3(WP:+>c2<E@QK2L//d?00<VT[
C\=P+#QL1@?RE+A;Y(Vb:fPZ;fgHATP=5Y)3_B==I476]JDO(;MReMR\HV_<VI>1
JVCXe+JW9=<-6I7Wc\F#:&ZS:c(M9HeYe?\WQ-5;N>gD=W(:Vf/Ig]\L:@(Z@Y1A
SM+gL-cHZC2^JF&/[\D12RB,HD@:LNW:aB8O/]@2;3=N>\Zea,\OLF:UJ)XB2WBZ
827Xa5.cf]4/\)+c2UQJD4-5[Y>-?4>9K3^_4WS@dJ_P/RRc-=S3BX=I-M308EZ_
\+KCAV8f=U,+c7dZPV\DV@ANZ+Vf]SNY4(SP?-)G/B>G94Sd.V<W7A6DgZKG1KaP
@cdcW:J?VFRg+FW2.M=4>8UXf7G[B..V1JG(G,9e9W<LQG0=;RSgeA;J16aaT7>P
>M]?E@KL&7<1YZ?1RV^G-d_T;B^adb9J\gI4@V,Sd>X)b/UUbC:>>A&A,QC?gUP&
\b6&EM3Z5aCUd[+Ogd,+2I#Bcccd4HG4E?(NcM4KG=bCL/0L7[AL07@?IIPT5e#0
#OJg\Z7#U6M0Wa>(<?T^MgLJ[@#gTGJ-VOB1gVSAQQ@OGIO<KRI0)6C\43/X@^FO
a+\O_LS\S[ZQQ)1PMbG\@2;..VUBOJQG?B9+.XBEdFNe[N.N^47acXW?2(QT:TYU
I-J,/C:<[,H#6>;6^bM625-daO=<SHN5E2HaI.I86C>)V4ac\U:RC6_(LDAWE,5/
LOS\6.VX8QUWBJd=PH4g^fd#dWefQI)QV3MB#;D19;\D9O^Xd4<<X=fV1WYPX4D4
RGGfc/QC,V3&:5e+U-T/S9+^__Y+S&N\H5c(Q2L#6-V6>^)S8R:Y1#2J+9#RV<fI
85Qc.Z]Q.H)?(G/g+VE^>[2MfT,+[PbP^WFF[FF)O82Y5b[@/+&ca^;8E9@J/eT.
-dA5);=[FF_gW#Wec:P4=W(><N+DFAD;C9_8IMQ(64V^X\9Q88f-]CG_AG,4:A.[
0].CS+0,G:._J,PW][#E^Ta([IDSB+06GE2,&,HOXbHW)<#aJFV/c=O8a2QJSLFM
VS0a8T=.@J&HD>(5K70DR@[K66KZGf)cP5[#,(e+X4^1:U5N7G=6]3I6O+:Of)T>
EA=Qd8eWI)U\GR(]E1GT9@R<[_Y=XQ[QF2VgWN986ZaH?^aa6-3E5UF:9<583eE:
>KDgDdS-Led6O-Z,,\D,1@@,\G9BI6QaX91=.7.P<[L+4<H>X(dC3C[?Xb:\d)9D
B1T[?B_d01M2<OB87.Q(V[74O+DHHcFH0BIf>W_VaTIfZ+6_g@81L0N@,IB;_UGK
a,.2TbWIW<;M+0N5eQ>(?:YIBWC)-\g(6;G/7XG<]ZKWf/Z,@gJ0;P:G)@dYFaDf
WP^T[/AU#&ETX;SJ.0@LJ\PUQ?g-1S3.gKRTD\<&5<bE&7DB(0KgPZg.;N6_,F^K
-^@\2f=c:])J=.,6+X7d>09I:QT27/?A85T,_E<=>Qf_IY<PD^dEbd1QRL^#_57;
LaY25:AKZ5=Ce-K8]f_G==ERX+K,D36-@a3FJ>0;=2@-XU/b,A#)U[/>PZa-BG3&
[6OQLa+:Y/^30=3Eb(D-0@a@6J<SdT/=)B2(@]0#f>XCQ+H5ZS.Oe\G0I(CD;fSS
@K)C(_]W&V3?)/9a1/I7dBPT6=L?2UefC;)/P]:gO4;+;34RYK1Z<VIHW^^A[WbI
1fU0g)9W]?dV?#KU>(P/AHGa625/J-TSCLN4_]RMBa+7f7S6BV#>=B]YO585W\Bc
ZPLgPFBC7cRC9^<0L/9DDF0UE:;[./@[R?,,;g.H6YbE^2^N3I#WFR:F)VHTH-K_
[3_EZU;\W.=.,KNQ4dI82\6WFAc)(d>U@&QX0SC[X\CW(/@00)TQFNRT4FT.B#Rc
:E4QJ=L:@&)JTRHDR;J+;Z8SRe;CbMFIRa0)F:E.@-GV9_KDXBAf?NG9BO_,XHAb
2-&//YB[)CeTf5+P8D+DFUAKeeTD,-AUM[GG,-P@8::_K@G2Y)bAe1Gc/U^X[]d6
=I&6@UV485Be=8OMDXB:caB<#]86#Z_>7UAg(OB<DLHXgIHPA=\OAXT@S?=__L[W
PC&ZV@(5Od6T)SOVGW]Pf^=?[IU,MBBFS2W\B6:@DD)HLD?R59;dg-;F(HR4&.d+
,:gbc&H=)gL?FO\)e.FZ\?H<)a0H4fAD7):D0\8c>#R)@CR=O7Ae1?PES]2gN=0R
6GfIVNCSS^X(8=,3[A?RHXZV-MM?3:)bWF=;OBH5V_fXTO@CDd6:JYK8gJG<ZY=#
J:5)6L.[_L9K9b2)S&8/>395bPa+E9VD<Wg\D#U]eL7f[,E9(TP4NDLP.VD8)c]F
.-[>@U31^0Ue0_Y\3?:#ZeE-.)1J#1BK\B@]V]1gcSPce1J:)8FVa+I^QQ-W89(U
60e?U8F/<a^JCX(C.aMCT#:MOL+GL\UYM/<,9/9QKc8IG#C0U>_3S;GK>G>Z;TO\
-<VbfdB.6=K-T)?C)]I8b8/_HWO++&)c@,C17UVXPZ:P=]8SaY5Wd4D3]UMB0D^?
b?=?[LAR_87QdO6.]-3J]^24f<6cS857g4<G@AFZfV\2GaZKf&^N-;.dIZ0M?Z3,
f03BC+Y37)[Cf:W9SRZ+FZgf;J_4-.VAWNg.8(],gg<PH._J?KPM;=&O15?ZUA@P
@B;V5QH5B5;6(,0G7)8Z[ZYF2;?BYG8DMd[O5#?D^#Q;R;#3D2;];A#g=O,+M75T
;P0RL2MN5S.7U(P)18F]QbcF.bDQ\4>_I+aE;9Ea6a>A7,9g<dOc6E]J0M<0@1bW
:=;cB]O2SKEPb?5>H1G)9K1)\[I/[4PK/_N57.d#-SR?cDQ7^cXFX2@@B@AFFW_e
9;(N8Q[HK;H[?I1IE9[<eKfZ4Y&2141OTaZc08KYZU=G4<4b9LCCEZY&/]8XM]A^
]g@fgP#[@)/:dTL=H)S6CHe&V7BZ@Ac.#A?(e1[>X-7;4W#a(@VTT^.(=+T7(_e&
S;5KBBQ8N[R7]8TT9f27+FUKI:)QB5[a^-+YgOONO\)(H[VCJUJ237BK,5ge9E7?
_GOO\G+#Q@?+e-Z:PT##VQA]U;9a@Hf)AS?BK8V\@&#G47<NP9f3N58cD=FeWL=a
;:^^(Ea[e;XAXc_fI/+,WLf1O^M4dZWB/,KO4QXOEdb:C)(_ONf51f66f7T&L9@M
+3ZY82)U1^^+7g<@T)ENMc^8O.=7ZY,:=\LSNDMOf7VX;:MC&5M[(8<HVc9;I72-
R?BT23V&)bRNcJ37-Sg]Y&#K:A&OL<V0GDb??Ob1GF,\>M]<,K?dgCU\e0BZRLE,
Z:e6Ge0Q^f5C:ZIfN4:>O57f[FZKWfgUf;=(.[LXUSaI9c#>0:2WCXEa7&S[NaC-
OK03.56#R_>4NT;J)U)2-@UcS?+Z7eKc2+:7=QUU)Qc=B\B21/fWJH@ZCOY6)K9F
A27(Gc5&5-?ZN\7@\L#cGQAVT54=K,0.\I)(7CfdDJJ+2&X#2Z#I&?T18g^g_2a4
1Y[[g9DB^<MA^T,b6J?[#\4_SM,\_bO01,Xd0X^^fON89L8\WDc(\L0[LeF+GB?+
W,\EJYDJ+?()J/34dDdY_,cJUV4;_XGBO]M-?UKV1Z8;dGVO?3E\YZc?^e5HNP/<
QW,(KCH+9V1X^5g/a4C#-UXB6X5.=T#G-,8\g_75f2<^8_EY#H1\^bg4BYW1=g\<
LU3I<g(V]W&/=+D3g0TM5PP,b(AZ69g7U0^77g;+K2CdIGTL[24I:A)OV3?C&O:5
cc7PCX^Sd_&O=3&?K.c#fYRVa3b2=K7E1OO<UL4\fXXbJ#E@T9]KOM]f/bVZ,V@.
Z54G\XaNA#A&)Q2>A=USGYDG8d<0:@;O?f/X-f)8:J@0)ED+&\1XOUQe4RC&F;8V
3gI5dI>?7=F?J@]HU76,Q_8e:-04UK,3A.=>A[]]K)Sf5&gY0<(3)XV?+R6dHLQI
PXdC81>-3-b#c_I#CUL3e.Cb.JESYHdW_G5XOWWJ(YQX<3P32e+UbB4Q(^@[Y]^4
b?+f;6H<XZBQRdDV7(^Bcg6((X-ZJVL@TKSX?VV@IL/XIB:Y7eE#A5W&J@J\4U<G
/Q+FFQ?f+J=-eeceAPH<TM[>:QV<C+]d.1>H(+[<892<Z8Sb#HL&I-DRXHPM-&0+
P\^gTH[&N[JQUDag;(/@1OK<)K<F5aY99fK&XdHBFaJ6L2\_].OZ)L/9E;X5ISO_
Xdc)ZdBd(c+@3D,P^KTC)Ca]/E?WS/O\9C/6SO;gIHd@a(bOD6HI4Be4>6H8f,;D
(<8\#F_ad(]9dX4#2IWZ1:Cg,?[gfT_g-PXWW.+CRG[&Sb.J&.(4@QQc_-f[f\WE
M-Z:EUdN:@41]=1>L:fT[LI5e?Wf7\&g;.5D4IZ:U2J/L-EZ(6LAf=+Pe#&DK+IJ
4A?G]ODFI.(a?dXCGbZ\7GQ<dYfZ/0g>f]bA+EPLF<f^T)M>D?BJR0g^)(<@\FC8
V.M\gWDT>bXU4(.]BR(Hf@Rg)KLCcTC/03R/7AMagT9/0eeDU&FNSaBICXS;Ac\P
XO@BO#DOE6L2=J=eE7c7_dN:X35;A?6M,]L?<[f<[?9KT<#Ca=f2fDXGYT:T#a)C
D\:c#6SW)@K7+ZR^)Wc6HU&M)Rca(NbEb[7;2UF7L200;aMV17g]_e(+@X=VB<TY
5DTW>C/.,;YWZKQ3I;L0\d9G2gUWQ>Y)^V8Wc2(K?.]FG^5M4/@7Q2dVKMaUO\OZ
0BXf7A_]T4^9EWDIUD/dg0CIVEfE&9^Q3W]EO\,2dYbWE:T\-H<Fe)Nc[0Te1JT8
W#K6NPOE&R,Dgd0M)e]S9Oe=.MCTZ(<<gQU:RZAFD,-G6+e&[N9_8J#GE?NTM:<)
7WANcOKCGXAI,\cNXD\:HL\;+1+S:Ve,RC#UY(APEXN5>D:,C>PH&_Gd,3\/d0IJ
,eZ(gJ8?I3P\G:(MQ8=;P-K+TOFC=QMOK6GgCeMa:BMd-[QbQR7<:[^2W;V)NH;U
&TE>ZHZM3)0F_WU2H=XX#M8I)P>bT&VT6(#L1G)Nf<eAUSJ]d_b;UL>KDBce92aU
GBS?>^3/Z^S6-5,]A#VU,B[9d0R-C^Y9?BOQ)NSPK0faG.,/_<0M,E?;&UBa-O6>
F+LRTIB\gOM/UA6cGb6)aAQN+[SaV>H?<b8Y5GbGe8B=>U<ZB=4ALUN?_KSB)_N0
0U&D_X:e&W?)dGVUgb1U/HYUe;\33J[F>OSUS@P;B_D5A6Ha?8UUbB8)ZOde=W\B
>c^;F(O?+T2a]?>P<-/14:1>R1PRgK[+X_NC2VU&>@CR?E?E-O_UD+?..ZO(#KFE
__W9I?SBBVe0J&U4S6B]N7X[/TQYLTVKA#2M&6.352]TW.A+f?(J@:gSa+5\c/3\
@2EB-E@74?V-D[?-97V8<AJXLBgbG(D99;S(L<3IX]QOZNH0Nb7f_2;L1\TMaGMR
8M;eW.]f95JC[3UOV/3T::<A.M-S6+ca7_)GDQW/Id)+^g3]#Y0d_d@[0_-344ZO
cFU(Bd_[CN&004#BZZM@RT(5@/dWda)A^[abcY<_S/-(637SG@9Q\L7)EK)A2+WX
6)4AMQ#gY.3@:FN1:aQd.>E;;N8[CN&9O/IEQWfV[b:K)(VbC9=WeA+Ze]fD4:Bf
C<O))G6,LWgO+SO1^-@JWb#5^37-J8aNO=WW&b(eJA(MOD_SUR6f-T^&GVUMKb;Z
V@&3F;<@7;2J9=T=,_<a-[>TaaIXTU#;UeFcIA[C#)F:IfOB?W=V]Sd#2HA:D#:a
L(I#\8I5QaD5=5WS?c>UWdBa>Tb262=43_d#5T;&#\BU0TO-[&070K5=#-TTHI;Q
&KQ\-8C@A4ML5A1@a@Y6##=+Z6/0/+TWIW5SXL2dWVP[>EMNL>L9@X6\;1<>I4GD
;O?TXVceQU[#BDERQ/48V4dW:-/QJ)Y935B<@[@GYPeaYPe,OK6]K((:6C23/21S
IZ#<U@HI]H5SMSMYN7([NA:1;G2KF3,0;7Z+A&46\\_&/T=JZE[7H8/f.^dd1J)A
(SM@&?&ZW]QRMS]cT-S1U8Y0Z:(c(EXP8c1]>fX9Qe@2@YQ=L@[X&YIB9PRgNA&T
B6JdaWWa[A[\2d?RWW-_F)Q23P]@bdd[BF(MbY.#9.\5\(G,\<J+G:_:Dg;)P=4e
V-WbPcY,4]S[ZBGbLW3+ZHbdK;C.@KQ;?^\Z;UAGYf<?.Ee@CU7bC.]4&_G9OO5&
Cf#+Y8He#7f>X29=;23D&Y33>?.)HD+>1LZUP[B?9>=28ZKbfOF[LNZ73KTE7>A)
H628158Ud:I=Xf@,+SY?S,X7aWVX6Q2J6UI7^9DR(3.SPDaH3A6F\0=eQD:T-#-K
XcFgD;e7;-:aG&6//a=??559UgN095;7/&D2ZD=:g>68C5KVQYf]P=?\LTPaV]D[
>M5EFQN67AYT8,^GXVBK7LX4ef>4/V[^eJ/T>=0@?6CB<gHM;aQYIZ9:=^JJXOST
H,eAggF#fGU>M1UZ:YZ]2HM3;T;H:bAc5D65_8Ve-7HO>#D47Vg?]Uc_bD2C9C1S
KQe:g<&<P,]<WN[];g[MGb,W/[7ER@1Ge)WcK90RL/]<K.3,+U2@&2d7/M1<eKQX
AVW>NcW&4T3(9\D@NC79=Hd8C#Ug]MM8SISQ9DC;FWWV\=HI].],(3XPLIBCGVW4
dSA^0A6038<B]S=SQR>OJa3C2HA\KX&6W26NRMC7V99SLX3B0E0aZ00\,.^#+(_A
P8e(LBGS5Ab9Pf/e(;+1:)&AAgHf@]2;XZ2E87f:TZ0].>=ZC8M=,E;9]6^cI0+2
J7.(+TYX)0KWH@SJ)=AKfcN5O_SF@U;OGUaEJFX4ZZ(,2VB6NB\MBYECX&G;B3;[
_\_W^>9?:8WO8DJ1agFHbbcF6/:&T^87&dM=3aCI7d^&JUIX:S@[gW.)/,PXHP59
ecGMfB/GaKR.MLUaO@Y0cdg+=S+4Q,;4E=NU^J_SX#^BVW74ARO]:,]dK<SJB(3H
,=SSHNKO&ZFHU)I..JV.4I>+<Pe9F6L[-?R5@1C(9S\^2>^OY&3&;;Ef]O;G>b26
YX_=eQI>PHH]89C:6GfO(HTV(]Z^#^_-YE(Zd[R.R8Z1MY956\V5+e8f/J,FBf[e
+5D[1(/1Fe_@02?BE_:S+EX>dITA#=PFF8Id]YeG[6J3HW<@4:AJFBL3QdgK=Z)O
Z>ZW,>R9f):\4U/Qc3TF\LbCMd><Jf2BKUM-ZFNN(O3SGI[LDI2[NdK1<HQK_FF9
.;,&3[10=d8[-4+Jg+gO7;8)<CJ:E9-T.YYK>RgV5-Q7GXaK618TT^UNSG=SQRE@
a<cNR2.I,^\&PFL:F#-3Y.B0[KMM;OS;&+Q_@Y=I(Gf@A>F8LP1CefL^,4YW,[0O
P6OPAO:VHfbL[2&WFRC](=7NK<QX=bLMN0LaP])fFP5#K7YJLI+J]bJN.C9(XGAT
_J<gP+.269\H=f]WLG3_D1G.^D-;&&?Pdd6Y/&RbD&VXR0f.-&H7e0J^6ZKE/Ke/
J@<-LLRSBf247cY.[d-A&AGYH(>C#b9:W\d/&QC+_H<^SeW?0dZ<SX)JB)5T2HNf
fE>g:W)(:S/O,QOF5#^^]5O3M0U:93bS-\X>/_G&@X@BBg&gaIY<4&WR,G:@0D2O
:&DSGPfM_B<TYa<H\NYfJ8cBW)\c,[bY;,W=:<9R78_J:?;&E32M6-&_S;AR6951
5(X61fJf>d1<OCU<A#,gVeY(1UbbR@0&fBG13Oa[7[A+Z\C.Q/:THe7[ZP+bTNR?
ge1R&\\V5DYP+JeS;PcDQ#2]<Rf/Pd3#5ee=-gLNb\AR[UaX[9#b42fV8:SX2UZ[
4cC_>3SB)R<;PMWf>,G:Y+9GKG9>-DX.,O^.JY:DfEG^NYYUZ\gegOU+bPADX&SK
[E\GMZZ7Q]CVWUA-5KGMHe7/=(QfA/535/J@,#ca.GB:Pe>]9aR:.g4NMS<S?NT]
d,g>BaL(&_#MEAF<?/^DTS38(dAAADH92gC#8)Dc(7.#>X03_,TbdD8@L</9XYC<
J.Va-@HE4/eYN/1WBKM9+C=&-geb]bTcXVIEbOSYEg.[HadaJ6GR-+M)6U[5a=)@
GEIUCf]5R8=KR<ODJFOB[.J\Q,0#)Idda+8.L94#8bT))-RVaVCeA6AC/IO@c8=1
;N;&1dg_Nf6@BZ>0(:MdObMKE23-]:4N];^A2FQ)Ne&\0(+PZO3IYQ&9>&6CTYEG
R:,1O:^TQK_<AX\@LFFU(\;C807d:<-+&7G\1U_:6.@NcQWY/>==C7FU:C,G8JRI
]W^:(-C_Y9F)5<S9RDO^aQ5B4UbZ5)AJT0Vd(=Bd8d.LD=@VI4a?E/7#TWZ3=Q]]
/eZ=a\:10fVcRP:9_f-LePc[?VC.TRK.6/RQ,+>dGTa[Y<c7eNCb7CHS\M>Y#bA1
\X2fB>^LbP<]@b#GHc2[a,L-U1#N^fSgCY:>SQF?,:H1[;RJVG<U>#H0(D[HPIH+
ASTdK;ZX]>GD-gZYaLcOB4B.7<U37aC82bM=LH-PS[@K:gYY=2Gf@6Y9P>4I9)-Q
35CD,A[Z&6c>aa<-;c@H^B];CR62gad3@=gNXU(9Nb&]?)LK.L<S4OA[6MLAIS9C
bKeN:T3?d(V?\dUbVfO)ec0,.d?A.&cQGQ^HG>,U(MB)R?aU#KYC7)RdD^&G39Qe
##cJS8De-XSVJ9,NHQX>RZV649@P>[:-B<cPD#MB2GND,XH,CMB1TZ8/:Y\A]LX.
g)eNK8=a#@S5K=;G@d2DIKIfWM8B(P-#F510)J4\@gYCLLF&Vc75D#K^1O7a<#d3
Q6R76<WI+I/Z0[850--bL5BPaOe=g.7NN[8+a(GgL8)PKaIZa+-2U>.(SO^#9.c#
77GQN?J_L^e4J3ZeMb@@N..I+?H4:C4c4Y]&[(U&6IWO1PLVS-B&A1FCFYSF@(8Y
9-3WIZ@56^R6CSX@f4JJYAaFYS7)73IH:d3?D\X34KSOKXfc5_21QKCK?IN.2N04
L<<<JK^d6f./EC.DOJ5aK=5FGN]E6Lc289TRMW3c+OIH-,CWP3O#2e2]VE=P?Fe?
@Q)=CQG><>P#(M+[9A=[<,OBH5UbR>ZAK;V#DPX6F>2BKfBA(A0RL?.AK,HcBfL?
E66U/QP+&egYK7[4?2DP-;?76f=>7b<cKgW/aTPCB#QI(I2?\ePO+=+4SH(aA<Dg
fE[Dgg_GD:>DF5fVA;A:@##GW+,]Y5)W#V/c5FbKMKNeAL:;W=7YR?+/8ER9,Q2(
eVN-2WNd&NA].;f,CgV,7H8bG)/<TM-2f4P&FQ3?=Mee.]SW4XCCeP1aPC=UH.f?
aRKM6:L=>(R<18XBe.ZL;7c:P?Y/Q#Z2f@>,cb9)OML&?7+OH?X9[^bQRW1#D-]c
b]7]E@g2T/F\Z@C;,8:E6F(A)6F\=(0=gMY3>)]QPWdR)?&b4YA(W8B#/&fE#WLH
@aN&_9bJ_&O.P39eEJM6@XRA1&0447WXWHe6gff<M@K[(N/ZJ#bEcVYZ<Q::]U#K
SQTV8GIP0Ee-VM7[OfNE5)OdTL5K3>7e?aVf:O\F2OA2^1fECD?#]623WgQUA:2a
SJRd8(9QeP\c9#5(SXI\JA:93&MXEfX&<K4ANd3:HgM&+61?9:7?8f#8&FYU>PG,
_)L#0f->(Fa.3W<)+@Kb28),)V5TAFD]B\@P)+g=G^bU+P=Tc^)#gS\8D7===N;f
IAR2#[Y]HfX;P1+UR:@9U.^5c#fEd,>[(XbR;[KNS2WMJ^3UX3Rda.Q^KLf)Q(:-
7?=\_?I7)J0]UFa^G&..__^=H@?.GR+ED-)N</Yc;T7Z1IcWN)(+>-gQF>XN@VHL
KRQ.+QJT5MLVPRJ?^bME[IX[eEgbd@T3+gC@/cW4.,VB:(7]?PZd7,X;)b[1FL#5
/6gHXUA4&Y<gP9P+8#L.0[g6J8:U^Z=3?MSYe9Z))W6ZcH]8#^=92S3G&FT,VX<B
a,)N\JfgPJS1@074(J<>&BFB_DUD1/?&1P7Ae2@F-G-BBQ(bFT=1\[,@\D3HM9YP
7;\?+1.dg4g:3d+SaY3?^#&]RO>?2c8OI8DSb:OZ?gX7PdMA];5LQ[aP.1a<B8:X
=b[8TO+DA_+_?.V51X.\H2[]\bRI@&21F@a&5Kac;[+FJ#a&2fFI>9NVX0)J3\6)
:P@4K)0A8C5V/g#,0R1#:R<-AH/N6G\+f9#6bQ63B:f;W-AMT9]>,ID8P(JP[1W/
W,bS@.),6S.e(:MWB@;X<.&D+NZVC,#_8)2fFG#DV_1g4b#8MSLAPF#))(N/T@86
&.I(IZ5HP]@cR+A6ZYJX+RgcUJN7(7B_ROICLB9=5LLBO/^)8e_A/91B&J.G=\;7
f1R8)Z.eZMSL]G3-XYT8_Z(-A(]Ya7LSQcQH@?0@SLP16II=5M#-@W\(J0E@f52\
SWVPXI=D[<:-FNTQV8A9dD/>NYX993.E.-_7=\)M(CXDNS5FU:FZ]Bad?F6^QVTP
,RWT93cFaKPVAXB>M&DQf)A+2+TRY=CJASU\dW2KY+(:W8V_1ZfcAA0ANUPa<e^J
?S2DJaJR5c?7aR_<a7LfLQG/D1TUS6.dO(:7eWR0dA3XCBW6DUX+a;5.W07XUOS:
?ETT1G9.9bKEMY\<e_3<P)C@b?XA-+NY/B@:;[TI)9J(]834X-d,@4\>Y<QY)GGI
G0&fBE:6H+ZgcYAO83HP-eLZ^?.E1Y<A]RfL.+.SK3(5b#A?5gYCgc0Ic2B3XCb<
C#Xg8Pc]Vea#.MQCV+)f)/g/NaV617<DP7;Ag5^TO,d9ZO=<N3_(BP<EHc]6;E.W
XH;L(TZZXQ51N8Z.9TK/7;W,beK)eGb&aY<cWf273K>&+933c:cYG[ZO[1JgdRZ?
99@7@+U4.Z7<10/+-XU5NF;3OK9@7X7<ZGc2SF3FEEC=J8>b9B)J3cP=W(+;=?01
Y]T3d+PEI,@.AY>)?VQ<K^G&IOKFB36Ke9.P7E&>:SOR]+O;fD.@-<PB69-,e=/P
MZZeW-.a1c:0DMCC?SYY&BWT,27KJ-OLY7H;2TNRHZ<d;JL78G;/.QH7YP3JgOCd
-O^RbRX)@JUZ\DR-Kb_5#c84M=O;M?])D/H4:]Ud3X\4-MQcdZO;20/gBG&,O6Pc
7Y0_PNTAdQ5+7e#8f_\KME_Q==6>AV=DfB_89aGEDT[eRAYR4STH(T^0#PY-T#a<
>fAAM_PX(Z+LLS8L[)_584GJR/eJ/f;N<Y#_dIUbg&?Kf(Vc(e.C\g^@B/K)DFfD
.]=F;XQUL1&6,T\e]PSLbAL=3,/UcF^-/S>J<K;>UH+eBBGM]<GDZF++cU#/XSg(
2fKO#TM8_IM<@?1R-7OO4/SFDYMRA)9]^a<=SSC2c7:e0RD6]9[BS@P<B;^A?RR#
g7AJOU(3P[cC..TYHX=(Z005HQSY3QL9L[T;Z);4/.fP+J\?10<_3S8dD/66>[)f
/VP4U@ZcSM91.6W_57.6\4OAgW6JSBI]f;AZQ3OcW9fOYP-:B)_IH<G&-&OS;7aC
?Bb/QY6B36fIGVg9e3]-3aO-]U1+:dUgJ;gC3\]86573LERKMK,2f_)J=?^fcC+;
?3.SAf#OM\?dDg?KbSX([C(@G\_agC)(3UYRW.Z0M<_\T7cB)]+dRgMW_^a);f]Q
KfHIeB]?2A/_WH+WJE\(dE<4V=/Ye/EMg>^df59Y@)<N>cV^GF(.)+M-&#>],)H:
,0O#9^9VK&;:;[AS9@LA[;=M4MW6+d?6NVa[dUNCK#]fMERR\^83>ScN8R^2(X7A
O<I;1@EX3K52^e+^Q_@(1:/fC6&QZ@Jb8Y(_3ag:64/T&;7T?YCV)?CNW-Xfb<_V
-Wf;ZcC]XW;>0+)/#YY5,A.O5OXEF3dV=C@f-E,XTf^\NS5d3HV4DeY8QI6a.QP,
398]#Ggb0QMEeR6#VW?cb0?N+J_HH3HOWDXP6e#0XHdL&VQ5QS</F,_L<,X5a=TY
+J)_d95LOF3A+)EH4GMR&\S6\5.7QZ?1WFH]CPQ0PMO_P??)Z^BG+6]bTRJI&3\+
I;3DcdIaD#:2:Y-E9NUV\QK+9fR&a0EVedD5c;(eEC90F6<8IfDa6UE778H^0BO@
+]0)TbIN:FRRa)-U+[fO3FCf]N68,Jd.7W(WD9JUKWB6c8P>4g0^_]D-[4PA4Z:a
[LE[H)@4.HM();:^&-DZ4(SEKg+UIW[38c,5Q&NF2TE;/LZP&U()M8E(LMFMb+Da
Bf@GOd]S:&0W4Z_Oda@e4[T4SF(e\eH0IF0^4BQRU8ACF3S#RZb_Ra.=;<a[&a-.
5Z0P)Y8d#^g8S9B5RGBfZLPdFXQcG403#6];M;A1KdI^+[.OM-Lgf?]d4YDU?(1=
R;K3G13FP>NBK&MVKdaPALE9D@OY0Ec.afbDW\7AWR57@ZbREUZ/L\dY2ecagUAB
c<2]Ead?HX#bfH)2X2\FaW?M.TYdE(fd:&]6(/,dEQ+6QS.2NX1KUOY\<TKTD:\>
,eBG+<=>NfQg9C3@V_HG4>_0\UX^7TK6E,4_1T-FM0G23e(;:A=C<9=Jc?TQ8e+K
L=RZV(dQ]WKeBg.S;VB.(aeR3e-ZL^/&B\,S4-g#S,0;bLL?BLI0WS7,BXeX,3+V
XA(Q?CZG>W(f&0P+]fb[e=&ISf3f];Q?FO[;cC&dRG3>@?\P=cPf0XgR,8TI\g]3
Z3HO47=X?H?+?@;]20MO3HEc)S.OEP]2M\QfN.E46g)?6+@V>e8DL7cH#=@^gNYL
[^;d&f5Oed_Te.+YS[#MOT:PTHF6)RfH-O+.5f:e@BU4D56[DX<B12HCT\\a^=WI
GGEK6aR52C<Z1,00ZPEJ07L3<TgZ<_C,;PM(4X-#/;@]^-[FVUILN9?fO7_YNL\9
g9c<d.VM95=,-=>5HW?4=#V-D#/UD;>1+Z<_[]YZ1L#/;(>(6YZ>K8R#K(39b4N7
T8VH4.GDX=-T>[@)R97P0Sb?X/@\gdRSY@--MT+8<<(7fJ]DK8)0R;,_RA4MI;]4
QCCgUG>2gg6RE(@40CVY<VCQK/7C86B8H<a&+-JJPaD?J.EO?(C3UOSQFD<\Tg3M
a^&7)9O)D]B2K\;cL^W:@B&g1(>4:LcQXS?G@TN?VPTW0&&I:aE:PXDRKTfJgX?Q
c,7A@EA-5&+c:4/4P5:4c\0(6=<+#R_BKSY_f1a(bBIR_?4FZIX5B9fX>_ZdXfT;
@4DX+E9<HM3GZ[EcB&V=[+(Se[N3G14DN@6[-RI/:e6#9([&Q:.TQMNKRNdUd71[
+.C=30W](4>[XNEXEM)g_HOd7XC]6c<,^E++N0=QQK0Sf_U.LZAG\\eNV8A.<XgT
\K>6FXQ.fYc?aXEgd8ZQTU-_R92(I7A-42\3DWANMA^15^7XFdOV1a37<E@L2(JY
24PW\cNTV0FBa,=PD8#P)fgWW[3b,5,aB)F+):.-=(.ab^,.f._gN8#O29?N/ERZ
IZUOE?TK>,SF#?#.&ZD1P6e60E@QOYSKd2Oc@Fb\+_AC0IB.caLJ;S2;2<IUJRKM
P6I338C#>H4?06\A(=f>f0/O,8@[)0>EA\+>:9OC+X0G\D&dI,17fCDQe?/Z=EJ[
:bcG0eQ;4:XMFa<5b#0F#(\5DTf/S7,6aUb#GOGO+ZWd]6#IQ<W0:-H4FE8MSc7G
;E;@Be.-_D^8LVW83)H93EX17S+d&F+PM:Zc2g98a?dB(N?_J5#O)=U>^^RZ4Y7J
RbIV8&Ac)V4V\&?&,?IS(3,FT3;-fL9-0=ecGf8YNdENK0C^6V)Rg0TYK99/Q,DL
)#VP/(4-a(fM&5EKEI@2_YVC5+D,V,=Y0ga4bPCb8>1XIP#\/d2Fd>PS(;\Q5.G7
2c<[,W&\I@3AGDI@MDaWR;&D<eW#/dI3&:bIDF+?H#,6Fd(T,4&aOeN4LS^R6Vb4
Z6&afU#>7?_9]@86O>LC-f,S-R3.+4,:f/<[#MdM.](^[C\Q?USC=K_4PKSN_3;R
O8a<Pf9RXC>)0^?_[\^[8#XU<XQH1VK/edDU3PD<POWUU>&D2\D,&7X#:C(c[@-O
#]//dGPWL9d8Mb+D(X3;<0./@;1&C/cXRW):WT.3HC;#\V6Sf&_&T7)M0PaPY2/&
KTD9\,L#.XB_/]WLR\VWaNf/26P:/14F?TbOP-\e74AaFc]_+DI+@;VXaZ_A,gE>
b>5f8I3AI8#N=R1+(,SF&Y93IGgJe1JT)HP+Qdd_Y6=/5(TLKZJ@d2/),Gg,;+NJ
):/0+:bR[HGCPW>5P=TP?8c3]gPQ-Y\]fHDN68FN&7-?DOWT\:IH:9c[^b1-g1.+
>d/e+bI1]DOcO[;E[YLRN/T&TR,IP<J7],\#Wg6?0Nc6X#eWJ(]_]^1cg@3^FU<_
YeXF:](BHBAg3cR_4SMM#B5?&c0SQS?BfKEV4b4YG3;dAR@\c8#QJba.d,-8IC4#
dOd?.b)R+25SNS<,+aAX2?R7Pb,\Sa7=3eII1WXH#<A4+)_fR_ZA=/HdR-@2gDMB
YH4Qed4/M@QR]D#]_Ba,UMX=4AKYXe6fV->KAV/cL8A+^(W2&97M4[>d^7NI>P)7
c9<R[TA0IFdd>II02;>IF96-7;>bSYGgQ#O(UDPW#g,ebg1DD=9#ZUY<U,YG@#\<
?f/(\@2Re:;34VRY4fYK2dA@:_>7OOaSH]B7(e2<Rg<[L1FIJSUBfN;M^,/F-DQA
2(1bZ>9VgZS56gBY:UKSHY?Q8;2M:S7cPJ=K3(bHV,U6RRWB>31-UQ6O6^8]PYO/
UJbD:?:A57BeZc?T_KR-1(cc-4WNYNYQa<45b;W+/CUMI\OMfP?U06K1]a4V7CaU
e#58UN>1#9g1Z49YDX.87DVZ4P<7X3>V-;D]/a(VVaO[XOMg8BVNHaYOZHN:Qa=:
Gg9A\X>)6+AI1A5\/::OD-XQY;HT_^aI7)<#/d#X,7ZLcc)+H(J/#Ff#;:;dC<fY
b#8X-adX;+;ASP)MXe@-Je,g/KeXOSTbDSQ;^D#9#V1JSDO4-J5db_;&-C6:gUK\
>2-cQ8TADW]?3B+3-[83@7_6HDBYT[KfNS1XI2D&N2Z[K^YGUXOd2@_S6g;Y.AdM
,edcR--TZZ>@g7S7<gNaO?e&7_\KW_UDV<>e+\A3H^L-+Q:SHF&W,cB?G4MSB4IBQ$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
