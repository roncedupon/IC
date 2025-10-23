
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
>0aG1^KDg1W//dYNgJ)bG0IKa#136I0:C<V+_;f,58K-R,f(GK&?5(2AP_UBWZ]b
(-E52M)FHIONVLX#<-_@?M@Z4G,B\;XSV=EUO&]OF3DQg3f3[4-V\\BIK<,K&LbE
1KGd4IF.86^\WgH:>cRT-gNK6XJ,WF1UA28IBD@NPFWQ5H)93/BYPF&9CO^/fNQ8
1;^>gZT?0]E<Gd3\&0^+>\2ML4SA<c09=B572PJX.Hc\;Q).Ic285c?]:XMYZa@&
Oe5VPD7VX&X\.aaYE.]WEQ]W0aQf:3/S??N/EH35aV01Af_L2K_3GH6>b(3][KG)
:KaIeTH4Z<@S]_6Y]Df07D83PO1>&#&T+JbN68S/E[Id1d2=6\LcLW+-L;S5)b;.
J]-.c>IIOHG34SV/Z,f.H]I[g-MUN9T3NN4X8FJ\BF]J/<55?A&@D2CG&B4#\.>D
?U3AM1,X=gd7H;HU?ITfTcf2RL\QFbBaG#)KS-6HPgZ60WO1OfV5:,3bM]3>A-LU
#4->)fWOYOC8@BB=D&_]7N1WT2]cfa>DPb/IPUb>HU:P,4?f>KC][EU[Ccg_Z&H_
3:4Y(XHc#H5e;>-#;(T4T[&JU@U&7DSP[(aEHY;IW._W,6d37I(TLfe(cSJa/]]5
Wa2@7>&W;O&VR7VN>54ce<cg,A-GYf;0QVTQ#-dbZAJ\XKR(eH_#fGQP=9?XW2aR
>X@LDE:;8[7fPf;;K=fUOeG:PDg2=(WOMb_B4;:J^V+-a;14+^2J&IAHTX+J(BZA
FA/LL)ceQ:]#K7e4K+Ue:b/1=]02--5[QH+0YFK3+,-gJP-5GeV32K];F-fH2H)R
dP)8M_IBWP\,@-g&.7c6PPTXTYLM?dAgC0A#/GG:XaDZEaf&;JJ4^52BTDQ]QL5T
Q;&=d.4Q1J;dGKZWRRG[9F+VSg_ZD>-/66LUAY3F?WaRH^S6>/.3cB1BP^-fM1D9
f^XBA6[0g-74KM?bXI7)\b?RQ=\LMF<SJ&WaVT.cES;/Z5;KJ&I;S0L.FR6:ZJ2Q
e\4RY>I+R6Zg77<7()@OgD/GAabR6b]9d9S\B)=HDed:AH49:PT/IB_B/=_>17AI
.X9C9:[4[;9&/bI,+c^[<]AT03Re;OILVb#B:4=EEA8,O+MQcIQgZ^F2#@]eS9SU
Y4YS1bY-(+T_B(0END<;0=]J5+ec4[(V]d^dbRADS2dIRA:AJ2,]MWY[b^_BcUY:
,GF56J9f#F9A[_3[C1=PI_VI,S6U:DJS#GNRZTc9^5HbBZX@^V9&?f;4g7IO#?26
Jd7\F.fPMN;>_.&:Q>&;4M/Y?.98U9a=Y#^AG38A>X7F]gZ2R)C^M_&RW#5?E81_
EV[>f;_GBZWX74UB]B?=^^X4AB+2Q&6>KP2[RXcI]V;IMPd-M\9Vbb737V5EUG_5
a/>TXVN9/^UNX<-1V.[J).8+T#+F0a1Q9TQAbI(CUcL-&E8/G^6a:A/^ETgAM>Ae
)G)^K+>;3OY_YXXLQ9gJ2E7OZW1-9RM<OHUaE-[a.P_+1Ya?B/;XLD<IWg_+)B3J
f;,BS5Z(P-9:b7._=+BZZb]Z2a_1>Vdg>Id1b5E,BK-7)^L9]PJ2>@L>(.K,&D4?
(g.IL]4Re4T#GRbA?L2WT/#T>1cgDF7&(QJ\L=9IDLPG#NWO(F1e:?]Agd7<ARQH
9Caf7fI;N:N\edY_+:bLgG\G?I=LP-\4>BANZL4aABBAd>(ZeGABBU^f?@6/T]D7
#R?R2=W\eTbbZDK4QfT(OWdEe8Z_]0LH=M\d93@]^^\Bcb+@G+XR44[7D(8#QYU@
4)PI.(eS583BM6+MBCX7S64@Z(O-Tc(g]Ae,c5P3RV?g);b3-0,HYW0/VBGW<QBb
:Z8@@V^a=VPOPR8FC6#^M4=6A7(c?^V#gGOPcOa:;W?[33444;+QBJ2^?E#OBA3+
14.F,VgZ>>E),&ffN;AZ=ONg2HdHe#:778GGMP2=/QUQG0+FA@ag79GT:[Ecb<--
#9Y4JL^8GA@IGVaH44A-/_fY9QB/1[Q1&6ZLATH5c49N]G:0Ge=4KeB:L[5#D,6G
g@#7P@I,(&D6709L&8/9>5VRE/\WDZ/>/>aaSRK&P/\5YaD,PQ?_D)F7;bHL.\-8
.@fb=E#P<,9fE.,_)NZRM,8[WY9CB(Z?g65X+[(D/Vb0dK,/YAffTDY@I?HJ<.FY
;JPTS_U+&;(O.<@/_5a+-[N1Yf?I&2G>HPN,/5PREHOQQECRL=MX=RcBVb8G?W\1
?+gA@Ug)FT1DG.+.@/C1.6=D^\=?dI0RH:4/1=5-JLfe#^T3Aff\Y=+L.P4AD7=?
E4d20)XQX)N-6c=OBHVeCMe(36#66[g=GcXg<O@43=,##MM3J9]1M8,V\dcd06VW
:>4;,+?@_G5XSNWX:NEB-6FC?>M8X1]=]FgVU05VW))G45]TaF@&fK3\)Hb>,&2\
>.6M_JPM->3X1Z+(UffU+Z0<a=[:E?[6RGdQ&;FBa)(6>RG<d4KAD08VG)_7,+^_
5ccPOI41#FN>8(2=4K-7-Vc7<Mc<eL8>g=c2_e8X?-dJ)b\c;RRA3HA_ONLW/d6f
fcV24ILT8B2OMb3@T&f1#4Cg[4WY+;,JF<+(aAZTgdL,<R1Kc[R0>/E<TKcLIe+^
U;>OCB0L-3]0fY++E7MJRXNMJ5-,#>3Dc-&GYXd9<,UO79CA/&<[395UGFIF]fQL
ZB1QfWNC7(>@[8ddLG_\96bagM5-A6X5FZ0aWdKDLPH/V@dA<RADWW2ZOT#\B:a<
aLW\O8Rg[9gPH84GAcc))Q:8NgU>;][g0)g.,IMOVNO_V75NK+;G.FHIQJCO&dDI
A2bQLS13,?(A4P7UC;#Y/E6[7I3GO>E;<FFQ3b9/))g2G2U5W+VW>S<8#GU6[LT@
T<B-+0JUOUIU:&BRSG-.Hc.HZYO\XX-X<51@(@OMa)IFWSPc;08E9.WLC?),95YX
Z#A9AU3O(bU=gfC1J._/4JF7X6/3Se\fd4WaeH6Oc^NGEf^-O)]7O)FBSNNUH(aT
:2AfDd5[1/.N+&ZYEF.^7=A?a23(e_@NfK&7Y#\E:6d_Rb5#S6PJ\c)GE(R9YIE3
+_P[731X>SHFbO]_-==6V6b)VcABL)]Z9YB)3CefFJ6D0<BP<]D6d0[TOZ#ZGgXc
G2M97ab7/ad@W)ecdF/7S.0@,9(KeOc6FD_MM#b=AVLURWRUHW/N\)Od2#XFRFR?
_1]>bUF>WPe0OEW#9+@\W:g(QN7?gdI]);_(3g4[=RYC;G<+U#A^^KN+bfc[d#).
ESG8UWT;#NK<@&Y(>G_>Jf3)^K&\G1eJ583I,+C:d#ST\[M<8WV8]_@aZ&FEBd3d
B>0\#Y]?]6<L5c5Z]U3>]GHVCI?.R\\K@g8eL[Za\(eKO(eX0a(GP(GR6K9e,8#J
VL&,0MGSeZVM,KKIBN4YK&T-#Q@K&&01E+^@R>fL[/##=4d\d?5P\397O)/d&_@<
JBCdER9g=71>I(BD^>V?6QW>F1(fC9,5S=^OYGALZQ5G<M0I4DLadgR^937/W.R5
.c49/dO<1>HD1:568X/.TH)OR3E&;PH0Ig3Z(N3#C:e?2Nae<fG(M+Y1Re8eaS^H
RTSWO#Jc>I03C2-=gA0H[RB5E0?&,B>0D71gO(?:XIe/[bC&\?GF9F2b[+&]<_f=
8,^4TARJRH]X//J86+,VDZF9O@VRSR2a(M/I;HUF)MJG5S8+ecb&Z8@GVL020Z_D
#=EcAD#)7_41BXcJXVffO?^H0A_NFA?[/ca=EJ&4==\3@[T;a13IG2K9+(MKNBW.
425L_3c95CH/E<4PU4-<1VOK@CR.F[TS1+&QDC>DE0&M]Q]U,ELK+Y,D@f6)]/LY
e7W,-b+T?faF)8^_-G-[=(VF,15QZ2,O[@9#>)UQV[PDYGb\Ie.fQZ4?LJ2H[XEg
G;?Qc_#SbZO#WJTLRDWXJABg9\).[Q>XT78>]3fF4>@2[g)OLSAD_d5H==V?2D\(
6HWe_NIXH1(ZVfF5=XG8gO\T-I@P+f&fQ4A1L.U@[^:[OI/>g8Qa8X+3]:J)Qc>W
OgK-1SX(Zg444-OAB5gU=J7E8DZH7]b8[Q]bIA4^+_NfD4>-5IVHR::QR]K3FZ1[
&/H09=0NQ)FbP^FPfL0&SeUB1:LC]J+X]JTG;LW-K;L34c/dA^)1;(-Pb0Cc2/YT
eG@&5#>[+T\P/J+R7Y.T,Sc62:F&PYFT>(]#C9][CeP7;>.]Jb:9d;1Ad/MI91IU
O6W-SS.YYQ(&g.7EUTHgUb9)-AH_P<VUELNCKFb^5X]JWH7)10&F;E1ZK/\f75a<
Z@a[6/5&)_4BRfL(^=K-HK=CPc4C765-^ZV_1OWISTKG>3YY^dMeC4NG;7^\UZ@5
I(J?=(R6@94ME25545VD&R=RKe/V\2&Y5gP&.1>Z#5;]?SW_RA1DV&_Og)I399g(
RSgRH7GBPNg#gW74+?1K]IUJ2.UeHD02807@Oe9IBTJZ._a?4?LJY@=G4+8)###C
@9#eR/b&Wb?2E&TA2Y[ZB&Z9<@2NK+a\4<PB@KF-Nc(][DCaK1XK6_W1(-cZGQI5
?S-YIKFW>(G=ZaNJ[a7;BXZ96$
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
;J/;14[NQ4;#3\]^?#,GbND9(KNH-3_RXJV@fdH4B_QY0#I(X#5)4)aF/ZZH59?e
&A@C];,L(OL^R0aJB-?BBK,_HCa^?Z.g5@1_C]1=Ya+[#T9eG(A4WGRc@VO5EJE7
e\9]N]T<I?L7D\_:K_aN_MBBM0O\A5DN]/Q@P3LZAEYO_-RF=f^QCcJ[)Z:IAQC<
FV2LA>e?#3:^AFZZZ^4-=\IW0a#SU3OU;7]UHWDZ=6+;P/L(,\Nb>HNY;M2][\?J
-LacQJ^[EU3A4[&W8VYXR9^ZC=GA\2,]H-LVa2D-JP^E?JOeJ0Ne;=L>]gd+SC(T
>N6dN7HGDd;Z<SFG/?7=g(5K,R5>U7Qc5Cg?-&dN04RB8>WKW5097ZV3\H/S<OD0
4&Q[_dW<fB,T#_@J]Eg1bK,S^SBc3_[=-_[Df:b-<J;BF$
`endprotected


//vcs_lic_vip_protect
`protected
-PIJfY=/?0A/d&JOd6@DG/9Wb6=]V_8W:<&H1\:#OYN7WJMd1AMf.(IfXBW?E^]P
[)>YUUE6YSEAH2-.RTY1c93b13VH91>,/e[6]II\fcI@a8#K9S.[#KF-A-#+^d#(
;Rf;SNHA@MG#_+_?#1-2dHeIaXGR7SBP+VJ99DJdI.g2;B1&EX16TLYA>^3>JT[Z
X3Ee/BNbgZ5Hc0C6Z)A>0=O/2XJE19XF\d.8g0H7UMOPY3J/RA;]JKKS7W:GFU5T
:cEgFc^]@BJLO6K;-ecgeF&a46bO6EXOa7F9T&T@?\UPQa:^2/M.3fTd;=;]EX/H
0H]daR16Ledf;T[3VP2<BF0HXS-eQR6X7XF)S0[+@_63]cHdc;.F^:K:1[QfAY3(
_<HI9T/_b6[f8.5d9GR&@B6IXYbXPXSR4YJ^L\NQ5S<Lg@0C]Z,=NJdE(b/e/&f]
@>554LKfAUFd;O=MOQ6Y?VW1\E+A[50#,R\OG[A?1[-[)+(\cbQ;EAT]PfGP3;.+
dSG4\A+RCQW5_.G3&_L=1fEPQ0H0#+WL+=W7BLb?Oc2;+d4?g?B@W_;@EAA;Obe8
;^K.@84GM8L;T2J3)WLD5g>-5)TdCICG=d8P;0,Mb9Ja7_(4;)RR;S-CGFd?EW4&
]+DNF<9+cUd1U&SI6-Y@Y3:&,C@>0YF=#d#6VK2A<(H&]E20(=B<;#R\Cge5.(=(
][a.#Y4O7M7_e&Ge4Y2f<2bA=HR2FTZ4d/+V^]QC673M(dFCVQ05@<E[\2JTb]Fg
LX9].65I)XK:-I/Y_Q_faH?O]?>JFL>QGX9PWR-7#+-5+d2JT==4A?>4Dc&VQ7bH
GKLa9I2+/+N.:@LR<#K9F@/J2KJ4d@0A:)D.8P\5gDAO]6(=EMU#PS>ZNN_g64&P
7C,O2UJUORE359g5@EGeK6#6]E9Q3ESC@:AW&I&UHRI^9H-JS,>,2(YJ]FSK&YOE
2O;8&R(f(.:[4P&O^QVDZCCfeefBS^2B]dCPEWRb3_LE&RgEN16>8a)bd7^WDf2N
S)Z=5TO<K16f]O??VBbD-3@\?],(XCM9IZ<EB2_B8.T>4D\K0U;.9&W,DR0WCA(a
EAeA/@&>_30PLb7DSRO&9J)^5Y/UG,;0aCJLf9]4T?V2Z82\d-L37B.+N?#)f6F+
S^56SPU3A_:3egN+#fW<?DC6>d5#)9==0dSFSH[F@D+C>eFbXJ-a:UGU5FIbO<+Q
6\d9.OM3.PcHHS;0fNDQ>T4VdLWGdPaZ7,)9Ta:^WMH,(U>3^ZB0_;J>?X#gVc+W
QLLW0./FTJ/Ob<4g[9Q?ISgKe[Y8)g.?7d<A^P=JG4c,73;EcG_[AGc15c?/NP33
Mc5d/>HYVfPT/+/c)?7F3)Eg07>^Ze,)@IP55bZe1NIP>_]QY\_6TVfG0#O=;FK-
fG6.O]=2]A=\)&&1P2EL\1VP^3aJ)8:V<YFD]_X)?#Z\f);=f.0M5?E5aBVOU7bQ
(gReM>8>.f0&5g]BL<8:1XF^Wd.\KF77gSP_+2YeW.G91.FZJJ1_#JTcY(g=.ALM
_K@UVVY[>Y53YKLL+-&^7:?Be@Nc]LSbZe:T?^0EN>7Y]bC2&]YaCaC-C2:Ya2d>
G4Y(#4RV@gc,2T6D9+8>_TY6Qe2FcO_OVgX]&55(L(27SE_TR^BC&8A#-]JS[>HE
+1(_)B=;+ZL;B9JURA0Z7B#&f7.59WR:\XM)Bfd3=L+VY1V[ZFde:PV@gUDQ(ZSD
=95@@)bIM1b89T>KH[IDGL#27e5(Y,\YeXG)e]c#;L0#1f,K&bUCRP<3.VdNRA,a
=EIZHVY:^.F+QcN.GETO\+5]5),/fFOE:7\QK&-d^YBRQ[2ER#bQf4(bA,2Te<;C
B<#)^bTc-;44#a3d0&E(SN#08T/G]W:+^JRVddW/2BS@74C:ecJJeTC>P#AE/.32
+Q0Jg;.0E(O@J3cG13^(e()LVKJV=:T[)]8]T/B#T@=U;+bM:PeOHBb03366eO.J
Z7Zf0OC)fcO@2><E80)eabQC>Y=bAAd2H(4BZFPU@fHN:XK8gD;73+.]#PXgESg6
_4aHXZ\9ce7JXf?<1faMSRVI=IFG>^PFLaZL-5A@84/PUCO3^XL[I6:GZ0/W,#e>
K]0[^?0FA^I+C&T/6UUf_.63PZU4J.-YDJ7ORZ,I(FF_6(0@I]53GDL.6U4(ZV?D
Q3#43(92T;g>\ARDNTOD?0^U7eO&U_>dWA,,cT<J/a&CW[UE9VY@)-cTELBA8)8R
NSBFVNdeN5KMWG+_1<ga=RL-OG],=:&9_Jb)U<Z7.U78NDb7b/C8J)YJ/DFTb=GE
5-^7X6fP_MJT1NKA:R@:.@(T=2P?Mg,@YI?\WW-:KOPFZ?7-YeGS,S8603\7<:De
aG:QSN7XcB)g7Y@2=L_V/-.<WD+K_Q_APY]]ALVTgA.&,2T24N._36N=OO<Q1;+,
]bG]Z#\/3N\(ZO_@gFb:eBF4DS;UaH_CTgC1=?U+3a3MC1,/K?[SISH61G0I5Q74
>N^d^KW6Z4b_JcY-HN):#8:W=,XRc)XBTD5=HI?/,U^bFg/f]NGC]3g.W6L4@.@X
8Y5d-U4H;dV#H]J>He&fDeW7@?5<2ZC>37U8LXY_,F7^X>PSAST1=CU..@Z+R0De
E[>gXCfI,2SZK9V1fRf_\5\K>J3d;a0/#W+DEX,F5=c(SAP<IXYGM1O_7Q?-,)f<
FC@#g#f.HNP3f)GdZJCGf+A._)]#0]MN53N.+8CBd=]TKOV8MSBaT=V(c4^eF4&E
&X+QS)MFO0(P7BZ[;]b\O[7L),^^K(M(/25+.NXW(L4H5V-X_E;UJ_?AaPdbNXY7
]\g5WI=/6Q0MO\>5-M5J+N(_\+\AV;PVaeY4]YW8g0@->[ZQJ9aH://WNI&O6Z])
FV7CHU@1ABXJa_3d^f2/A<Lb5C8^(gL1=-QWZ((FO(N=8?O50:;6F8B_11US:c&A
R4J>:eLA8.2JC42+N/YMN2Ic>;O22MU8N9e]^aP6cfY,Hc47dc3G:DD?V+8:ECS;
a0=[AODF=g1KK/.BZ4,a_S9:eC-Og&__g-Ja9W?0YD^a69X>PJW.7CQ^RS-T.0#X
TSNE:=0YDZXeG&0K0@/<(8eMM[_2P]RY/4H-F4S7<NaM=7UX_K5W-GG71:gE9GdP
C+/[1E+/+I+.0@A,LM5I<Ad^@W[//cgKg9A:ef6LH-;Z]]^&5Lc5E?N-3XN-fOG.
Ye8#\?_^f7dEAA78HK(#abMEH6D#dg-K>/?/Uf#b(^04;]O;+G/_KR:31N(g1/>S
LR?3(:#be:B0OVf\SM[B7V1+6[bFDJ(VfE]XM:.H^7fF8&^C9.9@26D[a:H1.fLK
HEX7T:;FQ;KGM^[a-@A,N9YG-\(1/\dJe8@.GcY_e.D];\aL9&VUKdFaacGYCW6(
08WS&-H3L;HBGXdX8B45IEaZ?gaaUWRcaA]ge/B\:WF1Nd)[K-9U3-)]>@TC<M+A
A0;fCZ9,4dT\?gB-e/ML\D_2gC3Da#5_Yd-f#(-c43SX0I4KHYIE-WF]N0E6DRQ-
H3eDg9U9Vd4H]f26[S@QeM72B&Zf:+YT-,1>_VI66N@^cbAV1PHY7&HI^>7,[C=M
G&,RD@9ZWG9:J&K<+]CFMJ?A6)3[\GEReIa0.#TY4F8ORAdG+7bN8GQ6FeEfX&f?
f>7KBV+H_1TQK7C]e,FH.](MM@4P\K\MYc_7L+Q.Y>;fY=I?bd-7&\5&dM0U3_dM
+b,@RM,+f7,a8OMQ8FX=Q4(WD>QDR1YX+8LB>-A_.1S(M8L=.KFFSQAZXA/0)NA]
fVTcF:2)ce?[BIZ#Y5(Z#(65RJ^7127RRB079-5I[gP3\AG[D.6@cN4R5]VK(M;>
TD6C][caJD,4Z@[-UbOGR.5C_(+Gg5SE=YL>.eG0L+2aEG>+Y4[W[H7Y+489V\e7
K[>UEgZ.-,<P/8c+f_CMJ^9Nc)GY/:Dd\a8T^93+)HH3Q1DT6F^(Jgf61=8Z_S&F
=fA-VLH6P[L_-&#G[_3-1WP3#_Xf1Z:/H29c@<2@]7YNG]gX:e+_5LURfCX=Q6EG
KA1&-b75&e5L_]KUVNJ9J5&6>_71(N.[/[7+@LeQVacU5X[T;J@ZF+fGKV=-FO0V
+Z.4NZUHE[T_.Wf)&Z0R6L8IC_YQ=02>8c,=632[#,/T2fRd&?K6I]=JCfaUV::O
M>HG1+HZ7D7Jg;b?OCGV_.P[J8C5#3L_BV5Kfg4RZa#:Lg8B]cERV,7_A=d[2L8;
KU@M=C5_6fP0XP617]K#fc&eK?VQeFXI&59V?b4>\OX9:>8,J6Ae@LD)UVQQEP^&
:#g/2@J.E5#E.MW0X6U=?L1H@1fSS5T=J2+O@1[F7W&FM8c&b@=a=Z931CK,:D,_
<JUMXa967g2-JPXbC79V#]Y[8R<\a-_9-/ZR@WQMHS;9>D#3Y3G9I#BII-TYPVGg
c(J-0./3C<cP0[0/SHJT<QaOSbI?f]QR2IE(I18;c>-CE8LCB3=^Rb;eK\<]]ZT)
RAFYWS(II,9V9HU[K5]Ie,,HWY)#6/.Zb9IN5aHEEQ2^1IY(1g,71K,&/O25YA]4
BBbOdJ]bZ(f6=dL<(->()OQU<e(:07BT-:bJ(Q3][]U\c=RW5d-:Y0H=0a16;Qf[
b89_>0^\T>,L?:^9gHDD:T-TW+P?Q1)>UB4,&G_fRbd#H,a-Q3/eDL&KTdQ+]gYC
b]e[O)TU=J=+>O-HM5gf@g6KEF8g:7UZ8Y&>8#@g<7H+-7SVLMdE.)/c+20L)N0&
TBZd0aDPR.RU.N#CgdLIEeJJW5\5?Vd:1P101C^Zd[0:SWP2=)RFgb)SIZ5=YdaD
Eb#;]8?OQ5P@&gF[(&([&0T<cd@K;8a:dJP>;J3\_GWIAQ=)E2KFC,LaQ;Y@BP0^
c]a8gK^cB@BPWO&T/f=V[VE6b^cbNb<RN>X42JgI)2\IdbL/98g#08&+HI(46gL7
;(DM[^0[\cK_ZVPV<@&[g@#:,#PBZ8ga?+M:&;c][S5M;+2C2GJMN.4-XE?GB/;S
9&HJ/31)g\7;@S@4)Kg,HHOX:=S,.,g<:G(A.I_6=Z2O7WRIcX:[gbR]Qa2-[@F5
I)/5He)8de443@^NSH:X0?.W9:]K9:/66dBUP7d8M<4B\W#T)7L#7=,XfE,-_B/D
FRTT9g4[G)13gV.)ZZaMM^W[M1L6?2Ra=SE5?\#UJ+Q>,8T>53e5O-GZ[31]&cCX
aI&]W&gM):9M[Q[NLcfL(\;)YL2,Sg:#gEFPI=XWZ<.OAE#Ogd3M3D#V?)S^LOHg
VLRJ0^B9EK@Ce_]=<(bQR4:]#/[D>7W:U8fQgFX6Q6CW/)@Yd>d>3-07eNC(13-7
a->2QgN>(6:/O5).^F(DD[A9(OU06/@Ee:AR,aH[b\BE8WgMR&g12GLAWS;?W)?S
KgAJAAT\R4@K0,5ZHgH<@VV:T@;^ge&+W9.>KWHJKLgG[V5L34a:,,OR05@S8M4+
e\,bE27,K>?F]I2/Qa(_G(36c.BaEg^G8,#P7QS=7aJ<RfS6^:X<bJ98<,[FC+:g
M+((2&/=KFe.T>8>/C6[T2U<DgW6CA/(,S[a:-:R(b3\TCbJ.Y(1:OH^LVTPK0ag
bYB3=9f9MY<?P@QZ@Ie2@SO).KZBg9L_LRLCfc;Wg6;;9UIec4HQcE-g(g5>B(]&
a56.0-&?a@a]1-YR+_TM]QWD(##B<B&&@F6^97D3Z@P[?KQ3XQ+&V/#YYUMD[?I0
1@gO(H)^MIePM+<ER:TVd&V?a<@2-=HE?7/V5/Ta722:g5bH0?^EDYFeTgGRH+-#
D&aP;?)M53FKG\bFV>I,U84T.:JVA/D.7^WfL/-(0ReRA,[KRX4N^+S;W2[@^72<
X-QX+dQP)S<]fQg:P^&;2W/R.:]R2)OgN4B].3(SSUZSg=T[Z=+3&KI<S719AO6b
8K3@e?YVCdXKP&gF.7BR\<87XJY+WgH)bE+8J?+/1IK54[;aTZWfI?@^[^B2a524
&,@,<W<W,(JIZS+H+;_+Y+W4Ba)HML^SD8FP11QcGP/_a_:b9.eAB9UFD-T_RJHf
dRM#80B;N]e<g[G,eXHCJ_[;WVfV/,93_:OI\OJT^97@JV]e(T0S2;MTF2YBUYO1
&&ER9K_A>Z);6YC-M9N8cQ6DHKBFaF4\+T(8V[]Y&KfH1]E-&1GQ<Ge))Vf?Ze:T
g4aKB+Z:A2A+g[P>FQ1Z:1)b@#CU9_JbWOAI7NA7IfS9191eU2;g:2XZ)/?2f9=?
3\PeWO&G,@7\Q4=)C=DB&7eW&)UBDOE?MVRX1>_51\24G)5Z>6\351?Ec2].5ZcX
K,I2MX--P-W\D;VPC]R>,ebV1:6V[=:RQR8QT#1=L/\SZ)<NO>INeN(+[5^^dL:0
E=R4S/FAO,A4-ER,eb.L<5g]1;;67\&X+R;G/MNFBSL,U\?Ob>65\8<OJL>V-)^9
LE-N9N[9^R:7()\3PFIP59F6&+3PL:?cbM/4;H4@1Y[A.dA6QXK//328\S@E9cV+
ZH6,H@@JdD3PO4(M)KU?)D)Q7[U4ON=7;RaW_]\([4(6]A1?T(Qa2I+c0;DP+/O+
+\_0;@06Q5L(^b8O]a#C(gU:6L/\-<8c8&.02\0Nb0YV+SPD7YWEX(,)aG6FJ#_[
<_J+IT6>#JE5c1g?BV1R./J+^Eb3RF<.ebdaN?.NEC/V@MAU\X-+X>4af7QHLP40
NN30IaKO?MJK11WA8:f]>B34-P;YK^:YTL=UL)==#9;S2W(#9b/=KcEGJS]9?+AX
GPJbQ1&\ED#_YC012IR5UVC=J.;X])g)<^D15cHA7-\U((R\8_LGU=;DDNP-T,5)
;N31]J;JP<61YK-KB<@aZTD,WU1:-8Ha9g)f98,9XY3J3^.NQSV?9ELO>VALJ+?V
)9A-gZg50ZGW<T6TbF-)G;F&a,Kcg4T63]R0M;9XA)0LQ>FK?.IP_U^abc\P:G.e
Z_dH0EdTB=CBCVeHN/R5U=@&OJIQI\S]a@^eGF?NO+N#=Q=:/+.F]/3g,^3>8DG[
1)8(b^&6-4S52^&SX(H<8W&Ie[RbRZ/X4/^LcU.d;RI[(HfQ3Z@d(N^A/DHB<F#J
/3,.LOF?Ve3[g80:7;VY-95TFTf7[Q+_)=d(XS#0\P/7H=<=[fSI)C#gH(,POP&8
MTTW<SOJ-(61)@Id(S_/7d6Wcb>+0dN?C,X&0X0-fKW?FB5C=2gagE=9,B;UReeS
>.bCML@2a.H-J93<bO@1cgP4)aJ:8+@&WPF9dVR\:g=ML8Mg7?6c?.JdEc4/Lc0S
&JLP,M?_Y))W/:g)-;NXH-bJF)=#ZH4:N+#bd_<HM6RQ,8Ge-WBZ6QdfMgQNX]_P
H-O0[aZGf^-X<&@=.HJ)f,ZaYKB3C^9G+.eO)<BbLKd75J(f1P(9(;N\<.)?b,>e
J,@C@7.@9D<VMU:#?7FCL53@#T,S;dPMCf&+I<-;<\AKg]]GWDH2E@RXZ#:+g3bN
Xd<5;Z\gMGO57W08C4+8b_V/DRe>Q=L]#gB7aZ:HH2WW#K]QVPDWea?26)P18^XF
SGL845aX./SO+PNQ;bbDXQ,Q4Hf7Q37A[@L,1G];8CO&8YT;<Y=>V?RNTL2XP(ZW
#>A72ac>PR82HdAI7]^KO\C=(@L?5FK/B=_M,BMDZ<^+[F>^K@4H&G_N;>?;AE(3
#MM<5]+#74\MfA&a@AdN^^8dgE2ZT[U7,DQV&G5(P,e9C#?eV)G##B6.Sf<7EJ68
#4#90GR::+^bZ_02261Qg+V3PKN-.e^S8/8H?+,.CG0/H99B3#AU>XQ8>g^JJR8)
0XKe9.[<(QC:JcW:.9a)L[(,fJ)0\-gV1QM3.WAZOIB)U1/DcV/,e/2/^<fPAcGE
PKc1Z[9>[22L&+;C].)6Z;5b_&C8:04_1C]8BW]R0d?Q@aUcg#>R.a]_;?VPQFb+
FSBE#,?O3?7^3L:ZK\,)BR_,Jf=fA,;T9M@3V-3?dc,B#\B>8d9(4T64+I^X&dP8
.YG&W#ZfK]2>aK0cAPd[)2IN@Y8J_>fM2W8S@?B].62PSRPc>(?Z_0F\ZC,0:LY2
K_?-0\bgd_Y>.KCW8L?8b-IJXfRO.g<2a.Q[UTAS3)a/IR](SN.M_&&+-STYN2V7
Ac;VJF>IfaIB;^EOd:59A(DJN^I3XJI0X40YF\A]/Ie7MX6/ILa^FCDI0Ea&Kd4S
1[OK<#]SBT_YDA@E=C?Nd>_&c=K#O?=]7(^+9PKU<K6J==<GfR1P?GA([<7Q.>UQ
QIAg__^3XgGNNDMWe/Y]g+8@;C7/R7@-b/f5E#Fb]E4RdRG)3fBAY:,A@ALHB8+K
33e3#b4MUUbSDM);)f2X9E3bZCSP&M7.)c)J=CbcD3H,6A+4-&UD6BAO^6IX<Aa8
WJBF2Ua]I\69/G#QI:/TDWg7eX=[=PCE<3.6,Q?^/db+M3WV-Xg8J/)1^;_fW(5V
+63U\9E;f6BfeB,8,Nd6;->Q+U<)OH)^TDe:&FgIE-PTdV3Z&?\^8D1cK4Q945_=
/K2CTgKf=UF9dP49S^NHVPQ0XdH-71>[+;_0H4^fN1Ca-0,WWfO-bNIQ-8GE)BEe
;^g(PY8d&@\=V?Ce1Z=g.<5SN1;YbFMcE4a_Z5G\(06//7=QG-57bf>&fJ<b#Ja-
>YB__&C6?,PgAWNO9TS?:<Qe9>&c6:HFME=/Qbe#P?,?JeH\B^J@Q,^6(U#)?/AR
6JWeHdJa6[IRAf&D;&2[;+.Kee:19=B>e8W-2A^Me@?\UZ2BgJ0@8[_56KTBNDR^
2,W3WDEQU?[@>Dc#C/GXX[c_^bD@[21R2-=V8&>_.Y?/26gU\C9Vb?H6@G>FXDQT
^E55Q=;+U5^IX7QB9fG5V[&&f0b^VU2.?(EYM<b#9bT^M/D>(RQYAJFUa6\FeZe,
]df?NKZ=2,8.(e)\aQOF6<A9SfI??I^HKSeg4aNZ7>JHBH71[@Q@^_H<]X,DTB26
Rd-.@DD5/19@06>KZQI4S_W6+HAS@OJ#F3+[>GT^d>:bAR3:gbWL8M/<@LKB5g^O
0#>TaN^[E4^8UGR0Z6NBD[#U(HYNC?a;Z\-g86QMBM?U@4]KHa^Ha#I)\)/Ee<ZM
Q(XE+P:OOM,D/GR(QT#9//UL5/XK2g8\QXH/Z3D?M[#9S,[^fN69FXT67Z:ML=UD
OSBJdR;TO\1/>H[YWYVENBV07;KgKWSWNcE6S\;(TUH5Q1F22__K;R.[++MC]fa+
3c1d63Ve.9U(gbD7#G(8.bKc_PLF)W91BP.gaV-,?8V;aAN\4)GM\0B/P>(A)?C6
bA/5,G=3.L]Ld:=Wc._Ye:\O?3F4fWTNdK#H#<7F@TSY;f;D=5J)L>>0aAL_UV=e
^&:-)LQ)A)Y:VGZ.IPAHSagCcS9g,=MD82G<Me.a+QUc\F9agE#(8K<7?L+:^Z04
g,770FH358]QV52LBaCT-e32DT,]EK/=g\eD9I-O2>a15AX(KfeINa\8Nfa.-T#@
J.FD0(ce#R@J8L4Q<94VX0MDJ).JMJQKg.>L^DW9F(=H5SC#/;eF4)B#,P8PNMGB
=bcI\/Z);,E,WQU^1^0<D[=IgUPd@36)YdIM1c+&gaES^R<X&UIL4XCab@+-D.:J
]T.B<-IHS3>?.^6-T=MC).YFe@0.ON2d[??c<[8+UKa+P_Hf:#bRP:\48=TTfdN?
>_K@.WK/Ec+M7=J#KReY2ba/G\MbIR(VM<97V3EO],B+6CB>-:6^gQVP)^fI:c:4
gXTHfZdb;V+0)F#:^g@1@?PE7=H5[D,)eIVQ(XWWD?3<XF?I0KTF_6&_00HL5Q]H
\UF#E.IcKP+N>16QYP/YFU)1_Y>Mf_G(B07M3FR&CQ,H6OaR?J)PK+\cP,/:;,9&
FHBH];AZBI\JO0=-(Q65.XE0dFP[Vgee_]>NE?VbKNRgHURX.><P+4e<=VfX^4Ef
.B]<_b,+86Uf:8>]<H=8P12cG-S@H&5B:]J7^+JZd&][Z:36?DYc\GU&TCJQ62]:
&ZI]+ZG0;D-B3;=[-#[IPc>Jg?&ZK+)JL>TdDFd?&TA<EV(R@^Z4#&V[)&^bGTa=
be35XB?62J36EB+B..1N[G.#V)BHY(Q:@,7M?aKMJ[L)5[.B[K]&B1O[^37-DbfL
3e?g3E9L7Pa]>S_WM:>[8A/G>P(R;Eg\S&NI8O.FSF>MLfS:OF<Bb@JGF<@J+T]@
g9;fJFR_--]U(GMMX^ET_IfKO.DXW]Wg-S>8AC#.2F?D[/-YVNFR].?^FL8JN^(1
51=D]RK];)ZH6Z<&6L<MXLK.@c/>O38?\7VJOXg_>RD?OS&<.)C-=Y^]UZG45[LP
fW-(8>(e,fSJ@-[8XC.U)Q>c4Z9_2_UC&WAB,Ie)+eWB?Mda\,Y=R@CaH5AXL9fC
/ON0Z#V&PFL3#WCI2GV6UdU(.?P4GXX)BBWMMA8)43@CFCP0FJe#DQ8^L>Z&.06N
(,AE\QeW#fCdHJ7;d\&b5eUE6\.#NM&:-G,9P-MEE#,(eOQM8V(XdB820L5.8+&?
C,LCc+-]e;JLGOeQbJTBG;f>YF.,[7D3PNa1R(@\,bBOYTU<HDAKBf=S.KA(f;Q=
I@G?<,PO5VY5EK&77(I_@9XKKYUMaII.&VP7(c?Vaa=C):f:NIeggP6/N-VUfV7F
9c<O_6L:f7B>fQMcN72HM=Gdc7]\C(C+I3^0=C7-ccK8SO#BJD9@DMd2,00+2PG)
9Va0ZI4-O=b<E8Q[gfDBD.3ETVM2@V1_;RRBFTQ/7SbZ(K&d.Q,NLJ8_IBET)XBc
.GC66#5/=&@I>9BA8d=8J1?fU?00^HX:RVBRePZN-3K6M[/fTgMP>72S.D3gCDLO
)Yee8^R^;NY(ULU@Xe8KdYGC^b:#RU<?S@GW/e<_^a+?6+M/J>7_:U^I7=L8R3\F
NB#5&=7f<(99.geE7[f;d-@29V_IBO?5K#eDS00&/FFT@d)?)S(#ZBcK#]J36]Y9
?SAW^@edEUN^CA4eTaEa^)Zc(1)-9T>(=DbA8_D8<DdRMb0^YYP<)0S>6Sgf.TR@
>L5]-OV;b_D#)Q(g:LM.F4S63H__+P;C\,Z#J8]Q-\Y=?HGFSO)V:1_/feKZ4U\0
McSLYVYHdX[@VOHC)/1fNdf,S;Tg:dNF7gG.:X07?Z4KaMbF@+d11;GcDL&YT])[
+LB(U)HcXC\)K(HX1/A#cTgcSAEZ7X^4\VE3W)C?U0,VE,OOQGMAABLL9Q?f?72@
:D@OPa8SBSF:)0AZC.)Y()cONGT-I\CX7P(.]OT]]HdMK]A4;GUB9I;Jc2>I=F@<
G8PA>([D3?(SAV/4_:(4AHcI^;SSD&/\IH8TO)L,=X8AQF^b&0E^3&SYQB^eT&WV
NVK#LGRa++O<_56>?F;,G?32YV(T&ZaK;/NIAHI.F:AJFF]f\P(-]0gV8.^2A0[[
M3D+d?[V#IMII8W=?-d85/a<b6ELB[3/a.5^CD5XP5H\ZRgH>A;fQcf3PX(1TXb6
X\,L-bCC4C;:SI\NK#f6IO;ZR0^I6=J75d7U2-PZ]R.[PcON<Y^,HbI=,,GXPD3)
//#Rg-&Wb46A:NH1,Lb0(dUb#-\>3OB4H[N5:?RQbQH2]&eef;UFU0:R@\Ld).KZ
3TUge@@KBGfE<R,39_X3]QgVP?/3dT9f>-:Xd&O&LBOE-\>N^d8AO-=c=QYSS3T4
&HF2WTfc;;X.[dHO/VNZ&\UGGD&TZV8?;3=JHBN.<G[7A.QYI=W5RS#Q(A7N0.#H
#STSN43Eg6._\SeP7&TP9MO(A(Cf;K-BCLVE0RSUJ64f3-QUSa#]WdLN?+75f^17
TcZfRdX;4J0WFb^I-1WgB7EBZ;bg<,J_E#WR^A1+N3Y83WF&P#6O:1ENE(S+7@Ie
X@JWdg0Jd)\9N4U8J[IP.D8AVN;-?-,Q-I+.K.4+B]:5;3BU:OP31aW7#eIV];M#
<#XVLQ:W(H?#)8YdDa5E&HJUNV61Z3SR8J#5BYH]@\,PGI9.]XB1;^M:7R/6HCEN
J\:]-1GX/&/JS/H\Qb6_GaW>OWa@U>81LRSG[JNI[EFb1EJI)gXdNf/3P)VVaM.F
T_;>#cYW94FAL^c\,CfPb9=G\Nf]GYQ1CAC0QU]eFaf>gJT@S.3_;>d)f84gJ-bD
Y&5K+2U<I7J,EG^:R]Tc>U(]4Bf8J?\(EbRPASG?<TM/0E?N[Ac_>I8M#g+T2V9?
J.Xc33C-(=7H).4#WbbA3=H?1Yc7^D,-O#1B+BATVE>P4[#ONB].=&>/J5&:Y[:G
H\6B1R[G/-))(5])C5:2PGT,NG^@&DENL;IU7?0c148eca[;-[O_dQ1[&Oa[)NT9
FW,+E_67GAD7U#OaF+[Z^I21N=-f.:UY&[8VV]fXTJ<)5&1KOL-4)c+:JD:-eTY+
c;<dG=C\/H]<FTIIB,_31UL5&RcPQ\[U^N?aNG,.K>_MW:[4KLNJY>Rf:I+K27He
;d0A:=_CR&]L8f-9>8+_UN97cHPJ7)eEQ.TLMSD>6Td5T9DR(FVYJ#,X-0JY(aBB
b7Af#Q6R,4=3e>7_VF2C\9>;DQ,LF_=U;UW+FL,ZSE)76?D??ZL(MI_:H1#NAF-I
A+FR9I#:_J=@B:T)#5;]2:aT5_K@dZR&\:2VdZ53fJd]&S/#g7DU/<@?;U/FNId)
QK&IXLNE8#aS0.Y_0Y&d::^TPHKc2NH(BD&^fCY3N;#6U,gdDe#bcdM1)2Bbd6.9
V>bb7JNd8a04AF@:3:TYBBbd/Y[?U7La_P=SCS8X0)N+PI[;4483Sg>I^[&Q@6.=
^&b3HBc\JgCTP88O3(5:MfMCb\;g.7]7E)4A>\eOa9>YJ_RHf;=KB0ZAVRa]7I)F
^ALc4W35W[NF6c6?Qdd0(LZ8YAF=&X.OQ/ER83=5T.0YT5E4A@K<#a+RH]W9#Cb>
Ve^gF73EA.)b1Xb7;P^,N?Z\.1]:d)bB&R^:HS&LC<B\-Qb\,C]R>;(D>Z&IPeIM
DB+D@XY2.J?@XY+[@8BK_CH?-GNbLCUP=a<=fBaO-.H/IZ\NaU3J2Fe)@L+P.e\0
VC),7E+FCAE[:NC[B/LcLK3g,8BJHIaR.TdTU[KXd7MR+C=RIc6_X2&-58K3eV\b
a29@eTO#C,??=P1g<aHW(#YUYIZD16L.FX&OB8Dg3(-EXdO+.A3[+\aI3=/M4PX=
(JK1cUKTB1:c<ZM<K)dga&6f5_W\f6N#<LBB.U.-:;E+)ILI]@g,SYNGQ-S0UOT=
RM56M\[#A7#HFD/M5]K_(,(IKX\]@-=(8fg<fOTV3MDe?BE[V+F[1Y2A+AdI4=Nd
0Q>W4BZ7RIgd[8:<[B#&SC]?(=]b2_KTg7H.K[6T.aL6\K^.+E2Ug3WNVGV>:VW)
gYa,>6#P]6b^6;]5G2U57OYB;V3,_=<,^B>@I2f-1^SEEa1gW2a4-59bC.H2G.?Y
YNO,d7Sa;E>;gC7\#V62EaWf)TaZ,GZ6UXW;NL]K5A^=2IVST_ZE[@J)g#/d0_\a
S]EF\7bK82-@f)#]9>Nd(S?UPK=KU(5?1eA7(a<<2.FfBDHA)4-+^O6B\gFFL5VR
)ESV]Jb:Iag+XfKG,]2P_[Y#T6OP9#X1@K\V\)^1/HXK-M/=HT3g/<FTQf5S9;U[
1;Q/BGM8_YFVUc7R<9YJ_?+CB1DO>#<1R;2bI?15NE8>OE35gS+G^#^GW0QE;Y<c
A]>^)^>S4cN\e_I6),1Ia/19:T@^HXEO?fRb2]CWDQZD4O[(9^0]>BUL_f4LgEFX
LBX92E@MKc8&:DN54-96Y/6ZSAa5cE2ZAWI=EGdKQA#gf#4fP=C61#Y@dPUe,I^+
.Y\:2D]4bX2-K?Z16(WFQPPQ07:<<ZWJ&0Hd@XQL^D^LPB4N453H)VV.RC2/#GIJ
Of/E49KR)92@OR5S]c.O:QgK65/0],<LX;-<.Dg)PU70CP\K=b[[,BHS?;0X:O[T
4/O^Ca^(9bHeCSSUJB>B;Q+XF4F&DYM17[0BTdcMG]?[72eAB.YUJ425F+3(BaS6
>bN+RNZ2QIbb<^<EWG7-#Z_>FaSHFAd,/-E:F@GD>f^^QP3#4O=gON.Oe:g06eG9
7Q/c,.9)K4Ye._Z/(MWee+>?)(HZ;>QV5M)VY\g;4Bc_;7F(F(3;+VP+[VRHGgVL
9e<-LQMBYE+X73.;cF3(RB3,A&OW>eQKIHb:=GMV8[-6<M-SbU3S^1.,a_aHY,K8
cS^O.\T(CX1G+Te5e1CJ7QR+S[TA3FC4.+e./dRR8&/Tc91W@e=caDK?8ODV4)/V
2;EB-WM<I9Ob[H?EZW+?eC-?PG=(\+LK>Rg4RYf29.fE<@TZWMP)EIc)AQ3/f4N4
;JNIJH:M1\<aF5edFRc.g@1^W>).X8JK(P\E8-4HV,@_@XQ?8.(G(6ZQ-845dgL:
I,0VKAB-bF0\-fe?e4C8CW#B;>_LLK=XcO=P5//KN9O#1838+QZO\49)/[+_\bT\
<VBN?beNfeD9&dY7_?6K2R_]/@JCF4XNEbSO?&/G+.NZ0g;3AO9>2K@7OV(41##1
VT[]3S]O>V]+.,(&8K7Z1a)CD=D[:]8BJ5STV&@b?dP7GP8NAVGdEdYR4dO;C7G3
I8<Y^L?,V8EE3O@)@TT6,9?Cg6_>H:Q+X]d2,VfEJ\dXT@@abDYbZAD(\Oe9</S@
C7,9^]CB9[Le5QL(-REQK_f@,^O&e6b&c/SK?B7@@=>0<.>GaVRG<_D&0cU<MO&T
\@B5;?LfaHJ@_T38BED><+N?gLIGW/PFc6bgOYELW;D<\8W;RK(0?:DQ<^5T7\CM
;Nc^[U0]20-&5VA8[3fEe>JTOe(634,_>^AXZFVJ39D[cVS_UZ>&/#Z.RV@U,-2;
e^eGI11V6bf/E9bfbWaP)F_@b4UWSYg6J:a,SGCWQ)31;,1@b7EZ<8\A;R7ZW\e8
RGR4G1HJDaZc9Q8JKLHg8<:]B>FUH4DcU@X.M#;+AS_)Ea(\47,C94->O3;ED#bb
Z03WfXXVI.I)]0cYHbJPS60#:g;\=ObDX(HY.(R#.eRM@II4][KJZE4\B3X9H[II
e7ZG_4c7bTWE3-cF(8,8.cW97#V?f0H=];^SGNL57^Pa>\I3W53#@1&cabe+QS:.
/O^\G=Z_aVM2a)fB5I.@;,3C]._E,:[aXcfY<Xc-?\a\GV0[AIaM0/8baRRaU:R=
(BC#5=ITP4=Y9L@<,K(@,d44//5P5;__<T/RU1GR,,LfO4/H#HU;YK1W@V?(^Y>Q
]LMWI@WW>#:@IX4N6+5NGO];04YIN(5C<NTf-aZG&7eMe]4#ZEO[:Sf-4.c3EA-^
Y3F;)#I5YaS1)6\SK=M+,3M76DUB)P)aK2@M@aNCYR[6:.T/=IB,1E?+]b@c9)5?
@IaGg.gR<3JH:)^cXDH-G8)_97eQ]_aLM3[@E1M4,:^Wc.=SD&VP);f_fZ-A<Pf-
G)G(B6E7-T1BN)E.ceAQ32?CPf7,L-N,D\OQBZ#DVX_>YQgQF/^-W^1C\/#-Gd&@
;B51DI0=^_SA=Bb0c+Ng>G@T;O3@H_,,:)[0/&AC]caEad<V6]+5UL4@bLJeEZI&
a9FRIQWF/51(eG1A/3P2<.HO^/\g8g&O5P5X]_]bO-0cA&_G2-;_VTR><=_?#Q=&
:9M-Fc-&R2ZRY0?ZQYJ=TE+(K1<Qeg]Z>7C/.4B7\>L=)B@+<Y2V4[e:=Z?X2]^8
3Q]dPQ?(cS-5CA9F)TM-bAX7G-4OEeVHD@bc^H1^^.41&A)@.X?X=77?>P[E3/=E
Od7=68AJY(Nf7K;R4#T8?KQ\SB&>:LO.ZE+H8[]G;0-+Q@8;G-K]SA1Qae^-SZ?-
9<((S\f4:O#)HZ34@74_<2,010gTB-/La34c/T_M2F;V&T1T=&3OOfH-9DDX(.d8
D,9P68:XB4VM@9TfT3#YN,G2Tb0aQ56F:@438)>)3H+A]EZEHEUW93D#5(4)cf/U
aPD-;_\2#+(Z&>QV?9c[=Sb\Mb\V(F:SP.Z)LR]<J#2G@MKLZdL#2Q[1e3acP(2T
&17K2V#YOPd3HFIJN1D).]\aTBaA)3Be<4:=&)J1b9RGRff:].F4GAC^.CK07_Kc
1K+[2#9,]EN#bM-.\d^S,/9&.X2;4aWaNL(VJQ2IMKB#5XW,\Q0O7AUH(PWYS(T9
RXW@V15Vg2?5#CE^PP\280bSDY;_.E</[WO:eG@X1.I@-LI^+e4=DLLdedI69=1a
/.I>fc[O,S3#-;=[(W#&M,OVEISI0H5[I^[1IRK6>D68-M49(BT+K+Y@:FZ.P39N
&_N/b5SFfe31#1#J<\.1#7R,)[><e-+D7:&RA\C:)eFY&RKWCMefGf>5OL;K0ZB0
eE.gDZI6Jc3(P<Yd2:2#)33SdGXag\F3LZd@8/8@W51a)M0a4cGW2YHJ<K(#MEVV
CW9JfA):/,.=#]O,]Q-\@]d];/FB>+aB\0#M_F#W+)0#bF5C#+S9O-74)RO9GCLC
;6^]d,dQCa#e,2\:<1W;f5_--fV;GQRLS;cKZ[?7+CHMU/+g0-&&Y@JfWLX.MT,C
KQ5GOX92Gd/)/f8^048-/IHPC)NVM-60&TG.:2O&[QT:[AX/?X2,[\.AKUQVaS)c
?1B\BJ]SK10@dBF;(A?FH:HFeL]X&D<#OIL98c,,#Q_(d)F2H?S3W-_e61:^@NgZ
8f-f4g72._K9&R3;)3Vc&Bf#D>[PC=)]feC/,>)A:LbF^A8aW#3>.L60g^b@bea4
]9^5--]XG,\d_IA7_;Y+=G^b&&@XR-,02M7M?L&?0=+FF=Oa4aMR?ECLWUTT[\Z&
R+>+[,7)PEUf=OW>g]Q+EK2PDadN>]_+OHHM<\.\O&BR]2dAgW1JbN-Z,9(]adS,
O481,fG(OUX1EZ/<.UCVE/:;_cF<UQc0I?)dU?_>-[_-CPaBGC-cf.C=X6(N5?G;
(7VJ,EI&f<b#]THdT#OA4D7@Z=e0H1&fGb?9I>RJC@+6;C-Db,DRJMIGCJARFJRG
ff.a/):&.:S]a0TY&OY-MI+^<U/\.NF6/4)e;LO&da4_4>#F:gI;08/J=d(Sg)b_
D@PZKMV#S6IH29<=XA=[^-._T5bO=?J0QXaQ5PdPDd--MeeRQTCLI_:A<ITVM3_[
PH>(U-17;:?MG)+CS)_>:a>>G#+e_.@A>S_YMM=2H+QdRJ[(DO=JXIJD<UI3<_EK
S<CW-+[E8AUaBQSDK,_aRE?)TFJXL0?ER2N+ET(3S1+>b4.QQD)^8f.XAg\@/@W8
9]2\SDR<-JDcQ8N<aYN5I3-,@\C3BdgYBN,];KO[_>2U(,&<ODZ61?Y51VF6HJSg
XF(AW,SYe0=aZR@dX^6A6KeOFg,3\V4g==Tc#@cdG@-C6+2eY+DP>bY7VD_OOg8<
454H5>TG[F^ea00)[E(U?0#6^<f2@++W3XKVcJADf:8>I77b,LTKZ^a2aHKg<c<&
3@BdMYK)PIO[3a(Af05DMX4.]3GUO<=_:596a#PSHSBI_CDdMJRL>D^YYE5&:=2]
96:(SQV(GgW)C_+Zfa=]cS?Vf7fT6AWAT(3IUCWA&M)DI[]@7_,eFSeN;U6Xd2\1
CEC1SLZX+HWI@K[@<[>Q:X0MH0:>?9Mg8#O#(R/DH[QU\I+P?X.-9GMPcY>CX7J.
@B<G<647>2,Y5<c+[EATW(@b:\b>KeEP;C>0K&?4XY/<T(:==<J-JF^KN7B@>C+9
LaB>T3GeDTKUAK7[@CGB:W;QONEEeN@32-QH35dO(9agFR:97He,)b=T@8B=5-;I
H+7eX0A4e+0U)2HC&L=M5cbO,bC#\&g&9JH2He.;-a4f[SX5^)Cc4KWY\4BH-eN:
GQfb=/DaA=#e&5?_^U#[[W^7e4ZMM0Y8_E9H:YN2?Pca4b@Dg^H^;IP1N9Tf2[_9
Y,A:O\(g+72S<N1KX+U1F8>)\Z937.>fdFI0)SHSBf)?ZY#X7d1B8R@aCa^J0TF=
3E1[G:>OTGSTIV\295C8@0FYC.7]9I+RI1QP;9eO:ZJf3\;AI]4EIVCBg;(+4T6=
V1@&UZB_ZW;IIR(@BW3ecX=bOV5=CYe43ZBT2&YeM1]G[6R>-@0X[V8_]>#Z^<Re
@V/1B?bI>,=[?b]88G8N+d\X;&,ITdG>P=OgME,76_:5cZ<MdJ1954_S:cXEEdIaQ$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
