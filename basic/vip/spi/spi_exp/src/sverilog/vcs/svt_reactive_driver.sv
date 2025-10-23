//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_REACTIVE_DRIVER_SV
`define GUARD_SVT_REACTIVE_DRIVER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_cmd_defines)

// =============================================================================
/**
 * Base class for all SVT reactive drivers. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
`ifdef SVT_VMM_TECHNOLOGY
virtual class svt_reactive_driver#(type REQ=svt_data,
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_xactor;
`else
virtual class svt_reactive_driver#(type REQ=`SVT_XVM(sequence_item),
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_driver#(RSP,RSLT);
`endif
   
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Request channel, transporting REQ-type instances. */
  vmm_channel_typed #(REQ) req_chan;
   
  /** Response channel, transporting RSP-type instances. */
  vmm_channel_typed #(RSP) rsp_chan;
`else
  typedef svt_reactive_driver #(REQ, RSP, RSLT) this_type_reactive_driver;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,REQ,this_type_reactive_driver) req_item_port;
`endif   

/** @cond PRIVATE */
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
   
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************
  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(REQ) req_mbox;
/** @endcond */

  // ****************************************************************************
  // MCD logging properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Class name
   * 
   * @param inst Instance name
   *
   * @param cfg Configuration descriptor
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, string inst, svt_configuration cfg, string suite_name);

`else

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

`endif

  /** Send a request to the reactive sequencer */
  extern protected function void item_req(REQ req);

`ifndef SVT_VMM_TECHNOLOGY

  /** Impementation of get port of req_item_port. */
  extern task get(output REQ req);

`endif

endclass

// =============================================================================

`protected
ZcOJ/g@eMEa/788J@9JI/;eUQd^g#+2^d;FKXR3)X#Lga1ZE:H#g1)6&_&FKeKWI
X:?_Pdcf\?A].OFaRee6cU/\GIJdY]:Za+R>K[.MP3\H/eZW=SSB6cB@gM>EOW52
L5cP0<034XYG;21[-VA\/I44c&aKXGYXPg^gP88):b5&.B:))g1fYJ8U9KKLNOOI
;N_D_[8>BWLD:AHZg;M2e=/:02)aR>X,3))a8bK1W=Y[J6S)0b1X,Uf7LW)KE7U=
L#+?cR02Z?cW6Q=^,5>\.Y>QN8UKLIfV>cb+X88E1-2DGU77V,H8CDb,gab>+HY)
ZHgU6b:.cVd:49M,bVS]_CCPA)5HaNfeZdXfdFdSV)b/@<5B[@9ZJECJ).[fU4A]
<#)YAM=g/0I&/UFG.bZ3:AE<L59P_,L^3NZRP^QaQab]-.78H,0OEdGFJ[0=XJ.f
2Q+1)YO4M(++</d1L3VGU>OVf&;eWSF^[..:)?9/e\,S#.e;ZXA:[/DK9B0Z-81Z
>3418_U>T-8MK/.GK=@Q#d,AG4.&RDa0-^a6/f5]4,/_19&gb.[<<^O6XFTG\#7^
g,W2?b(Z;^U[V4F@<YbWK[C0Z8IGgDVe(HA4;NVefYD^I[C(]HG9?Y,I:F&=7ENV
<A4S3\[SX-Jc,_]I(<8f\I]bD+AZffNHb+N7@e&B^7S@H=D0#E-A]RN\Z=c[]DWG
FEgOXa;a7O2f4fccO9&7SX(ffF;^/D<E9$
`endprotected


//svt_vcs_lic_vip_protect
`protected
X4ZTdCP[gH.fJNT1KNLg1gY8U@36)2TDF4VaVW:Q48EJ;U&7UB9,0(CYG7);f5g-
aY?bBZcfUJa0>9I#df,-^WfNO9K[;Zd?f4MTF?J[^eMCN_YN7f=#SJ=?[V-3gW7J
#JH86,A5NYdaAA^Z/H-&7a91Ja_6fGINfO4/Z+b?@OD1DP/M)C&&KKN,A9fO4\_U
dW6<OO/IWbLD>Cc)U]M;CW+OCC-8KC(a?PB]e/6a&>M+40#XTXV-AR<<Of2TBCBU
L)HF<<S85fCBS8<A>\=FXT;AVU2#B7]3-1+1RbK2NeI-d[S6VP[=HWD#CR28QbYB
D><9DUIZF<,CJ.MOWgb.R\E?M+;,>eaB#.IH0^F9gLMYcBTQL\FEZ^3VD0:.ggX9
(9=03,MWS,@?I52(K4c5YI9\J;+VASabURA>;)L?JeAF0O(cHTQQ=+[RIaJ?49F4
[7CDYLD4cS(GdGY9gP+ZX[GSFZe,IB[7=HCc(9<Ma@@=)K##P3dT]7Ng@8_SKKMg
83DRLH+\3.NXc1=2A;8<Z00@]N/&H:G^NHGTbH5.L&1UH01KW#9I3Cfd;3#VHgO,
[,7MIXgX[KI?BU:?)&;Ha.J;J&d#_U884(1<[4JH;<+6V[AVBB,>+Q&Z6MR0\>TR
X\>a?CGa].=V8J)a5C&)L)&-K,MJFDd4^g3BIUQ3/PZ<QF&)gI,P&#1Y[bde7[QD
Q0eEC=U?b.=0gN:QA0W>a4Ag&2)+(>#ZX-a+?_P.B03:3<X&XWfb+d7XTTd5RfN]
4&_/V,+#B+A0d-c:ZD5(.F.[/dcRfZP7VR.E;0,VT,[f_8LIb#cRN.IfB0UA84;3
Q[JA+M6Y10eZcHb(#?9(Z3?:=J3aP4(DII=KfcfdCZTE+c2ZB>;R9)0-ZM_S@/ad
S&X(3-SEP=AP046(<a-.Z,?Q;4FJ]4g+;_D<KE3gGDHEF$
`endprotected


`endif // GUARD_SVT_REACTIVE_DRIVER_SV
