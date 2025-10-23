//=======================================================================
// COPYRIGHT (C) 2007-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_XACTOR_BFM_SV
`define GUARD_SVT_XACTOR_BFM_SV

`include "VmtDefines.inc"

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

// Backwards compatibility macros used to bridge a couple of VMT versions
`ifndef VMT_MSG_EVENT_ARG_TEXT_SIZE
`define VMT_MSG_EVENT_ARG_TEXT_SIZE `VMT_MSG_EVENT_TEXT_SIZE
`define SVT_XACTOR_BFM_MSG_ID_DISABLED
`endif
`ifndef VMT_MSG_EVENT_ARG_TEXT
`define VMT_MSG_EVENT_ARG_TEXT `VMT_MSG_EVENT_TEXT
`endif

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT BFM transactors.
 */
virtual class svt_xactor_bfm extends svt_xactor;

  /**
   * Transactor id used to associate this transactor with a VMT Verilog VIP
   * instance.
   */
  int xactor_id;

  /**
   * ON_OFF notification that is set to ON when the reconfigure() method is
   * completed.
   */
  int NOTIFY_RECONFIGURE_DONE;

  /**
   * ON_OFF notification that is set to ON when the get_xactor_cfg() method is
   * completed.
   */
  int NOTIFY_GET_XACTOR_CFG_DONE;

  /**
   * ON_OFF notification that is set to ON when the reset_xactor() method is
   * completed.
   */
  int NOTIFY_RESET_XACTOR_DONE;

  /**
   * ON_OFF noticiation that is set ot ON when the VMT model has been started.
   * It is reset during the stop_xactor() and reset_xactor() methods.
   */
  int NOTIFY_VMT_MODEL_STARTED;

  /** Controls whether VMT notify messages result in display messages. */
  bit enable_vmt_notify_display = 0;

  /** Controls whether VMT messages include the MSG_ID information. */
  bit enable_vmt_msg_id_display = 0;

// From dw_vip_transactor_rvm
// ----------------------------------------------------------------------------
/** @cond PRIVATE */
  int msg_to_notify_id_map[]; 
  int msg_to_notify_type_map[]; 

  // Vmt Suite Level messages
  //DEFINE_NOTIFY_MSG_TYPES_DW_VIP
  //DEFINE_NOTIFY_MSG_IDS_VMTBASE
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMON
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMANDMANAGER
  //DEFINE_NOTIFY_MSG_IDS_VMTCOVERAGE
  //DEFINE_NOTIFY_MSG_IDS_VMTMEM
  //DEFINE_NOTIFY_MSG_IDS_VMTMESSAGESERVICE
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMONCOMMANDS
  //DEFINE_NOTIFY_MSG_IDS_VMTTRANSACTION


// From dw_vip_gasket_rvm
// ----------------------------------------------------------------------------
  protected svt_data xacts [*];
  protected int cmd_handles [*];
  protected int xact_cnt = 0;

  protected int out_in_xact_map [*];

  protected int max_active_chan_mgr [];


// New for the BFM xactor
// ----------------------------------------------------------------------------
  /**
   * Handshake from the derived transactor that indicates that
   * change_static_cfg() is done.
   */
  protected event change_static_cfg_done;
  /**
   * Handshake from the derived transactor that indicates that
   * get_static_cfg() is done.
   */
  protected event get_static_cfg_done;

  /**
   * Counter needed because the methods used to set the configuration are all
   * void functions, but the VMT method set_config_param() is a task.  Since
   * tasks can not be called from functions, then all of the calls to
   * set_config_param() must be placed within a fork/join_none structure.
   * 
   * Since the set_config_param() methods are in a seperate thread, then there
   * is the possibility that the reconfigure() method could return before the
   * VMT model is fully configured.  Therefore, this counter is initialized
   * with a value of 2 when the reconfigure() method is called, and a thread
   * is started that monitors the value of the counter, and the
   * NOTIFY_RECONFIGURE_DONE notification is reset (set to OFF).  When all of
   * the calls to set_config_param() are completed in change_static_cfg() and
   * change_dynamic_cfg() in the derived transactor, then this counter is
   * decremented.  Once this counter reaches zero, then the
   * NOTIFY_RECONFIGURE_DONE notification is triggered (set to ON).
   */
  protected int config_set_threads;

  /**
   * Counter needed because the methods used to get the configuration are all
   * void functions, but the VMT method get_config_param() is a task.  Since
   * tasks can not be called from functions, then all of the calls to
   * get_config_param() must be placed within a fork/join_none structure.
   * 
   * Since the get_config_param() methods are in a seperate thread, then there
   * is the possibility that the get_xactor_config() method could return before
   * the configuration object is fully populated.  Therefore, this counter is
   * initialized with a value of 2 when the get_xactor_config() method is
   * called, and a thread is started that monitors the value of the counter,
   * and the NOTIFY_GET_XACTOR_CFG_DONE notification is reset (set to OFF).
   * When all of the calls to get_config_param() are completed in
   * get_static_cfg() and get_dynamic_cfg() in the derived transactor, then
   * this counter is decremented.  Once this counter reaches zero, then the
   * NOTIFY_GET_XACTOR_CFG_DONE notification is triggered (set to ON).
   */
  protected int config_get_threads;

/** @endcond */


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the svt_xactor parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor object belongs.
   * 
   * @param class_name Sets the class name, which will be returned by the
   * <i>get_name()</i> function (provided by vmm_xactor).
   * 
   * @param cfg A configuration data object that specifies the initial configuration
   * in use by a derived transactor. At a minimum the <b>inst</b> and <b>stream_id</b>
   * properties of this argument are used in the call to <i>super.new()</i> (i.e. in
   * the call that this class makes to vmm_xactor::new()).
   */
  extern function new(string suite_name,
                      string class_name,
                      svt_configuration cfg,
                      int xactor_id = -1);

  /**
   * Sets the value of the transactor ID.  This is only needed when using IUS.
   */
  extern function void set_xactor_id(int id);

  /**
   * Gets the value of the transactor ID.  This is only needed when using IUS.
   */
  extern function int get_xactor_id();

// From dw_vip_transactor_rvm
// ----------------------------------------------------------------------------
  extern protected function bit[15:0] map_vmm_to_vmt_reset_types( int rst_type );

  extern virtual protected function int map_msg_type_to_vmm_type( int msg_type );
  extern virtual protected function int map_msg_type_to_vmm_severity( int msg_type );

  extern function void process_internal_messages();


// From dw_vip_gasket_rvm
// ----------------------------------------------------------------------------
  // Functions provided by the different model transactors to create model xacts of
  // proper type
  extern virtual task new_typed_xact_handle ( int chan_id, ref int handle );
  extern virtual task new_xact_specific_handle ( int chan_id, svt_data svt_xact, ref int handle );
  extern virtual protected function svt_data new_typed_out_xact ( int chan_id );

  // rvm methods
  extern virtual function void start_xactor();
  extern virtual function void stop_xactor();
`ifdef SVT_MULTI_SIM_ENUM_SCOPE_IN_EXTERN_METHOD_ARG
  extern virtual function void reset_xactor(vmm_xactor::reset_e rst_typ = SOFT_RST);
`else
  extern virtual function void reset_xactor(reset_e rst_typ = SOFT_RST);
`endif
  // common vip methods
  extern virtual protected task manage_chan ( int chan_id, int n_threads = 1, vmm_channel chan = null );
  extern virtual protected task catch_buffer_event ( int msg_id, int buf_arg_id, int chan_id );
  extern virtual protected task catch_output_transaction ( int msg_id, int arg_id, int chan_id );
  extern virtual protected task catch_out_in_transaction ( int msg_id, int out_arg_id, int in_arg_id, int chan_id );
  extern virtual protected task catch_initiation ( int msg_id, int arg_id );
  extern virtual protected task catch_completion ( int msg_id, int arg_id );

  extern virtual task catch_msg_id(int msg_id);
  extern virtual protected task catch_msg_trigger (int wp_handle, int arg_id, int arg_type, int arg_size, event watch_trigger, ref int obj_handle, ref int int_arg_data, ref string str_arg_data, ref bit [15:0] bv_arg_data, ref int status );

  // Note: getXact_t is changed from a function to a task.  Also renamed so as to not
  //       collide with getXact below.
  extern virtual task get_chan_xact ( int chan_id, ref svt_data xact );
  extern virtual task finish_xact ( int chan_id, svt_data svt_xact );
  extern virtual task garbage_collect_wp_xact ( int xact_as_handle );
  extern virtual task sneak_xact ( int chan_id, svt_data svt_xact );
  extern virtual task sync_cmd_stream ( ref int status );

  extern virtual protected task do_post_chan_get ( int chan_id, svt_data svt_xact, ref bit drop );
  extern virtual protected task do_pre_chan_put ( int chan_id, svt_data svt_xact, ref bit drop );
  extern virtual protected task do_buffer_cb ( int chan_id, int msg_id, int xact_as_handle, svt_data svt_xact, int obj_handle );
  extern virtual protected task map_transaction ( int chan_id, int xact_as_handle, svt_data svt_xact, ref int status );
  extern virtual protected task map_to_transaction ( int chan_id, int xact_as_handle, svt_data svt_xact );

  extern protected task start_command ( int cmd_handle );
  extern protected task end_command ( int cmd_handle );

  //extern protected task clear_xacts ( );
  extern protected function void clear_xacts ( );
  extern protected task set_xact ( int cmd_handle, svt_data svt_xact );
  extern protected function svt_data get_xact ( int cmd_handle );
  extern protected function int get_cmd_handle ( svt_data svt_xact );

  extern virtual protected task set_max_active_chan_mgr ( int chan_id );

// From svt_xactor
// ----------------------------------------------------------------------------
  /** Extended to update the NOTIFY_RECONFIGURE_DONE notification. */
  extern virtual function void reconfigure(svt_configuration cfg);
  extern virtual function void get_xactor_cfg(ref svt_configuration cfg);
  extern task get_xactor_bfm_cfg(ref svt_configuration cfg);

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL
endclass

`protected
dc>XCUU-6bD=4R\U>1A\DULbeY@2+V_4U5FTBDMIIH_eO[W;V><^4)JP2_R)9R@N
I@c=RNQ=c0TS@KeHSK2X5^a@O/+b&@81cA9/W\ZXGN4RE&N]DfRJQ=:56&^-1XK9
XXK\2d,VJSF8\U#[SP1X/;+c(D^&\d\Q&HJS#-RT;_#@Q2@?MM6ZVA814Y3G9RZ.
9JU7=FCSRVdOTd&I6aY;QG8)KB]V.@R#@cd;H>0/M8>=,&5Z3K99D/+(DV]=Z<@=
DYNUMHO(6]PNFJZ\@P\LfW]]\/:d?0LUOgT5\M(3YK?/e&(e.R+e2(@?cC?NGP\H
J#g9.-E9+UEdW=\U@F^PO>?BcZ=99/MTHMLG([9d/\K_PI@6c<XRHJ,52g?7T^WO
dP=O(5YHG2XTG23P;N,K&O&beQgfHZf)<e?.),c1\5_,BE_+M[60C8GN^,XJTJ@=
)^K-7#)Zf+;L)RdWZ-5-VfVPSQ3Y/.-&E/XQK^.fU;&XSH[.=V&Y0&1/RG@KU_8H
JfM,8SAI[OAD68Rd=S4VIRUY9L>O/PZ;5/5d^&()J4:U:7dS+7+QHW0/Q?5Z<Ra9
IMWJ4PF36a.PCW]OMY8Fc&aC3FXM^dDgH-,ce,@WT3&#8aTA.Igb\0^X[P9H.T\Z
>;UBF^MfG6<1DX-07A@XA>QVTI_X<2<5#gc26f;@K/g/M:)26b;AUKGC+5?I4G-+
J.XeO..&OT?9C+1MJ^2BJ#TPcD,UZD#OB[U9U01X:4^LBV80f&EVM((BfZDc8>,F
bGBGGZZG?7/2UZN)SR#I&#GdS91NC7fZ,]6PQN-D\FbRMI[;.gYT[I@RQS&g:SK9
T.8LAd4K?LK5-&6b[ORe)3+cC/ESS]VB;@f.O^[U6@@KP^2X[=)BacGL98ae_2Hg
#BeHEA3YPg?e9+;;c/VfN:93_SEbQ]]CU47=UE#5T:f\-CJA1F36EQ90fPC6BC0\
0LPJdZS1[/?4Af#&4[]ec]RTIc>)9,8S@O+fQ.gTJ9,6TWNO5VO<Q^.c9#UB>^53
/1]9_aQVH5fS<+ITL4??&H1E^BZ;aC8^(cVPY;80\]eW84HK.6.;V-5Ma>@b,Y;<
\DWb]2>5b6?b4(J#1[:6=FP^V2WVJ^;@gSKM=-<FS5VG#=Bg?,C[dE;]8IL?423(
@&<EGP=XG&[B^FES04T,B2-fS7Y8XH>C)I1ZQ+[+=9e[9\&?7Z(WQ5++F34@^:JV
Ng)XO_89>K8_^NbDV4(=\c6g\UG#4BA12dI?R-5Q/K^&PUQ4f_Q8G#QH,)e2C#1,
FSb6OGgEV:D]4a)Ue3]g=TIQ;fUR#7V2MI5<K/_)N_&=_+ON#I[d>001[FB9&#:&
6W)S.[,f/,JF>+S_:g,&+]^[d+8G0)0I.XZSdF]5c,J[VH(G7aa98&WWfK:84RR.
EfO>a0+^e;0BGKBV^b<F2&O3F:G#<[J[(.cNE<X@d89C3E_18@eF;QK-aX7<N6c^
@aSWO8&7^FEQ41MdY8dVOC?,fBSI(KM10),0WBZ&V3bEP&4-)77=YRJLa68Vf\JY
QP/R0FO=1FR(B/[Y?d]Z,PWd/2UEC(+7,_<8/>TJOOENB9HSC#/&RaMCb\K^cPPf
A,-4B6FFY)?7V6?BBdU(FbQJRe<97QC07C].PC2f++FX6R8.ELV2@[,<[>#ME?OZ
I-QRNY]O^;e7CD^CTJY/@N[WZ60#.&_CNC<QB?C/B<JE]K8P.E[8#I=59:^^#DfG
A(\)>FB@SbCUF2?E,?Q^^0afHGP]Ng&,3E5P1:C9L+RQRb_V:ES[6I1BfB\TYKJJ
.KLc/7^7)+dc27ECUH_HNRd+&d27SOBYP6=8_0I;)]KR84243BV>;[CY[@LM#7(^
13BUB4\BN4@d5d=d69I_4EDY<3YE;[aVc=<N-;U:KZIdK(\J9gR11AUA/;#/HNa#
XE2Gg0^I^([aW-R<N)T+2NCDZQEG9;A5XBaGFa,@F9U-[]Y\fL.c,D(H]=g_9-YL
JgeOT3A^:+=<d]Fa@)AF0H_B2RCZML/FcY+@DU#J<#e8IVFXGZ]3QJMdA<#If;0X
JddD(ITX&P@]e4C6?DeB]8d(7(\9,.U#V(),QTCF\a\3X5V-6?Ta4:<D/)5](Y[#
U.DDdG1[fRg0cAgL5?K0-H?0YA0HSg?O/YLLcEecANc-7<.^gNF8#B3IDI),GZR(
)3II<4AIA_:=6>Nfe7b2I3_24Gg/<X,=Z9O0URQPN[b@>FY+X7WcI,K),_RWJb0a
;+F>d>d];\J1D9b9,7T?@?CM:\1E\5Zf\\]C4fJf066TB:/LVS/HVd8=>6U7W:K6
@8KD_b@aXRB](+,eQEOEgDe6I-F,]U5DFeeQ&dZ@4&J)11Y<TB,OC8(G/;XT)09T
eNg,>N^7YDKPLN5B8ZSHYIFNWI3E+U\DDaB]Ab4]4ea^T1B0BQI;83UFdM;E55MN
\EVaKPW05?(/fER6I8WVX2\Z@aS@6&&94fZd,TMK,(7N[J5Nf&4f/+=N<Te5bTbP
=Nd:7)@<M<@<1RN&gZg/.J,F0a\4JM5d8#YVg8F_gR8]O3^AM=_&TL)<?7(ME#R^
8cTA>63f?JC]W+FQV0[Ybb_#1[.-_JHG2LMH#U1[DAdbXFAV#VbMI)Y;Qc9,_BK(
8;]2YF<d]D#AN.4&]a:eF4?Q8LK--;H3P<&KN66Pd8Oe/.NcGWKWIWLYUe<bc>WD
EXY=FLb?R>KU#2>[3H)_5a/7QVMU63GC?LcPC)L&J[3LI++Xd]37S2e9I@+IZU\d
J2a0:agP[431BTc,0?V9+,W/..]g7&=.]T/(eJ<+7TY-/5HE=;>JV5>0K(:^Bd1+
>>>DU3URP@7eWD2BG>[:R,b]HS]4Fbb.S]@1/[S>ODPXCJ7a9\[VgNY<15&4.M/g
\Q0BfL21@/(eY\&BV.6g:,/Y_V@NH-2_RCUe76KHc999E[Fb.?fPW7/Z-B+C)+ZV
e9Ia\E8WU)gU\G^bEO#cJ4:&d5b#7beHb;\..PgD1?Z+@fE(UOXO+6)X(?_,6+97
E;+,CeU)E?\(T4dHS4#MR\0^KKJXA]a?PZ-e#C#D]_>I;11-/4GNc0445eJO]HUQ
;G&_gKLcKe47\9CYdQ\/\1Aa.M?B@c\2c8]LR4O&:/F6XZ]bdNZW7ROQ&T6R5g[Z
KT&e;^C;SGX\>O+7H>..BaA_8?I+^H#B_Rd6I_M]E70g,0#;9)ff6O2AF[K3[R>H
[;fXgQ3=8Q;LN9:2GCc]\.J,.57NU(Q]B8Z?fDfWJ?\:NE.9S3Pf@453>g/481,K
<d;5C[85]F0/Da.4UddZT-@5gb>+7gT__;ae2=HcPRd2FYeWKfDc550UJN4BA^F4
Q@/PHGcU6-=W:G4@OCeA_#Of^Z/7/c,=@N)R>>WDRGb]TYd],1\0BCS=;SY]79<Y
.]GG^T7ZAWe]/fVKf3A.LP&CD,-Ee:3:2B(b=70&NEN;@a)-6c]G=D^IVZ\\I:A&
Zb3gA(KH\EWBA2(;dM(D#R=L(QL8a>RYU;+88_&2G1\#<-a\f3=8KC_)RUbL4SJM
baP[fOM9ZA4Y&ZQcg8#))0.GP9,H[[WR#N#:F?)&=C_S^4R^11J]+fBKOZ26)^Y#
I4F;Y(_=T_afa;Jb_HO14](JVVBJ^AUVPN5^a1aS.Z@Z\8a<M1:eV7G#I9=SUV30
QeY9PO#DgV4@+4fNGYO/8U7^d[4G1[d9OaT_c^U@;06T@MT_Bd6#FJNT>NgMEA/A
>H\[OZEbXC4e=^ae?Ed+MV[L24-Q\=Ag;(SVI5A4N^+K]aGdMg(<SZ&=b&W4N6DZ
&H3GMU[ID+7O@/9=K.D#Ka6c2U(.K^39V=O]Gc0:#=SVXe<4QgRdPf,#Z)=,U)R2
:)@dD[E3L&AFc_,fP1=-5FPc9fIE22S]A9dUca\29_YdX&\J7aVb=^Y_A1P)<?O=
V6)EWIY\bV_>NM^4MK5g>L^Pd;;c+DF,3@:=#]\F#3/DFK,FI:NI#Y_FB6M9>0FI
YHIgGR>(CG<]N_<O23)/)(-Q(MOKQ]1YbP1GZ#4_FKeQ;_Z=:aNRHd:=[3+F50SP
#B[897]M)-.9,NTEH+R-:IJGB),9:9=0M^R[V+g73c/NNDN_g33-Vd]]g3f,?:VH
^&H^SfT(KGeC^5/2]\BRKZZ^RUgS9\OBBJ1ZgQ(WQC18.5PP(T:.[dHe1IA,Tg4)
f8B,S^L:PV2BUYO]5JFU9@XUG-&]?dO.9<@?)W>Y2]9YSE58<Mgg\_bL\BA.>Q^g
6S(K3M&<>E4KJQ==D0,UW8KZWb\(]6O4]fR182_E21W9B7U:g9\5<I?Ca+P,E-7e
?21ZZ.,+C7_>5fKQ39T#HQ/8=H)0.87fb9SY+d24(CN=O0c^e#^F/KGa7TK4PJ0P
&,_F4_Tc.BE8M\U<]TGbdC[<(=QPG/8QSJY;<f.I?#U=6b7P.FaTQ9#9XfFPW>9L
b6H9P._/^FKHNIdIY_?/NS#7@E(-7-]g1&L^J9E0+6I#>LC6-X1UHGW1OLNRT587
C3&53#ZSLUDHa&HD.3G&Y^NC2e^[U37F0\F]gRI+OM0agI&[^6bY3HVZfD)d(0]7
/I82/ZMd&DfcJ,ZO#A/X<2L0K>1ZCe+533:MP22,8\=0O:CY/+28/E.ZcVc)T;9_
N)[N+_cM4&9UgH&0IETSU<Sb):89Qe0PG-W<a/Y12WcfMHC6:KH)8LIWdQFC/OgQ
GXLe=0]AA,Z)Y&d#]HdF7CE,E?WO5R:-V>MGcSaGX9EZVg47JM:?YWI(MT0_ED4a
V.S_8)gXB=<T/\A2?VSd42EaG_U:D[QScXeX4_]I:YT#;@H8YX=(RAUJ+13S01H+
?<OQQ86MH0)IPYg/RLb.9>;QRcY?[(=R(2):D?d+YVOXTV&>ON\fSMMPW?ddLLgU
3@DZb4UX:e5BeU_=g0KgR@4\&?f[e>_FANfK2/+C<;CO17geA&E:X2KA3[>c+a^,
BaJNWMFLbbO04.F.M;K#SCJ[E2cJJ_d^QH7fB?I#J)ZZ=X\XO(3Q65-#UHC[S^(Q
=AKSd6a+H?\Z7NB383(_/EAd:c+&SRJI(Tf;??,4fI)CG4YSLUcYb_fe.R@GA;^\
JR]:#G6UY\O<X:dcJU&J-9g:O6];4gH\cD7Je@fS[2HJ@Z79d[RPG^@T)YJf;X:^
3CR)\-A<33[fH.YbJf(Sg;-2ef,L2NC2OHW5^_IVDZ@FF1_5Ke1OFA^8g\ZGc2#(
2Oe]=91BTFa,;:84(<ZH9a>_(I4XJPAKS>GE36(^+E;.+#74Zf[/&8be947Z9ZQ)
H85R9T=Bg(/<31R8)LBG?,bDWE#g7R#O&8#H1J3Ia?W>4L5(_cbQYXb7\0a-9UZT
XFG[eD02N8&40Z60;92=bbR@-ILXRX:^d-.<:>Ng84M,E32YG.e0;a>@RNU\@#7&
9A[39-9?Ib,SDT4@W)@:V8NaYH2)@>BL5dQ)<Q#JV.CTK[bQSM.L5XJYKM;&\GNT
Y8_S5c5W^Wf=Vf1b_8,JU7APKfB=d#6U37UQ-GAZXE5WK^Yb<<X9@P.90QSE]#eE
[dTLK4bLN[]d;e=,9g7AJ1Zf[)J5fbD<ILYK1EH-OJBLdB-4F)NWZC7M\.dLgdWO
F&>R4_O;_<2AaRCZWV_Lg#O@_T&=SP-TJKE2[E)Zgeg-NE#D?3:=&R&gA2CY-79.
gM3(9HcVI9R,B/NZAOPbCMWZ[MK<7W4M;g#\b<_^UIA\:ZE[;_Ib;&L0:]fROWeg
QICYE@R,+>OdVQ8<F562&-+,e]CO#IDgLcBNI?:<#O6\[g,Ta<ZE1D_G(Q#d].D1
)bUa1L;^S2P9>-QOU^9+0T6EH^H9,=J8+BG35U226/@#DBVW,@&c)\dY1@94a(OK
L.AYU:Y3:EYDbX)a2g17,Q09V7?#7g/>[S4/TZH8&XLK85C0Q^()gQW9P.[XIAYH
6a_/B1O6-ga2_Tb:S0VZIX?):83fV3;KS(dK;7fd^LAfK)NA_@T:Uef^9Q635,IW
P5F:4B_B_E,IK:)H[BBVZP.fTX2R1^4Q=1,c+_d6@I20ZC+2GJ[.W33?SPH_SYQ9
Z#CUeV+^1:,X1(RHHG>/;=S\^5BP>VUR;B0S9I#=LDOYC/A9&UeED0-9BYKS++8+
L3KbRD@OA+^;#SRZF:0/&UV:3O5ZQTe7g8[#SHIY3F]gFYN+>51#AH:)R8^4dY?K
9UB=@Od33>Zd9.V-\;#;<M>K;Z&\N\<5A,PQd(Y.IC+;ESdVFK@ZT47GWOYK9,>M
C2;9f=P=BV=>T&A/gX7]K?7ES8/FMV>81Q)B)eH=4dWd4bY9F)>-UFJA#5BW.da,
PU>20JRc08R]1U(dT(8B2P>1J5edD-Q;SK&#c:7b@N_aB@TYQ\IaK4(YA)N9GaX6
NF,H45RKV]6F;HHC8<bU53c35Z?Z=Rb_-><F:bO#B.05O1CCJZgFa95d4VVB4)_3
@[\SRfC+b,__N[?@^_deQR<=MC;JRdUB(4BX(/9G_W,4.>M3@N].:,/-O\>6V5S\
M,[1cJ9<6eVB.c?bM))dRUR&FXWZC6L](^g-/ZgMJ#OS]@]F#WWG5.ZJ[Ab;V9DR
[:#V:N2WT<-9TWB28OCVK:-)cddQA/#0-YTdY^V8cM>/O)Y?;1,Q:I_.8]RGS-_R
1C_QNYaQIZ=XWG4cGgH<NUE/.(::OGR2#AYFaSK),/Kd4(J1>e4/KIOJ\6d,6R?5
0L>H^]@Zf.fT/)gB_^KHIJC0]ON>62LQ7\-0)KQXWdM;T6IM62#[?]R&^IeGRI@(
_a-Q=(R>#R^F(IM5+)]L9JPSI\>WSG2XR.gAQ.JTC86,a^F&BM3),R@)ST>X(O[<
014TW_E2_;LCRO:N99Y0<&PPg-Q7ab5CS,LCU@.WGT1WJ@177;/AbOYKZ6T9;JMK
DbH,:.34eOASBW)\2ENDfZ1Bd>SgXe<dfZ8L+Z7:)RW9E][YefJ]f3)L04..c,Z9
+X34&J)ea3H]dN=4RdJB\Y78cF>,^\+76fadU);2[G7JVH#JfWg4?_&a+U)&OdPf
9ULE4Ob[<6>P21(L\Ncd9,\K7OIDKL5\OMC(I<MSc91)UMbV[NY9J>faM8Z35V^e
U22U2_Ob933<<&1=&K5>NcAY:M@OW7K]VbWN>;-^EUJbQF2+Seg^Rg]&FBAH4ZCL
,Z.RO_^#b(\LQ_W/MY)FBI9LEa[JFEVA#[RKTg[14;:UWF8/?H4RUV7+Z+FGbJ[S
;5FYT@K[D>#M4Tf9Ag/P16Lc1PB)X>?57aK4NLU?T_+P[J.3_.8:O[P\CKGdN)9O
HQ;eMWdK(9aM0=7R]349U3b31_a-\2;+NAWHN/TT35P8,=<I6E/6dL\4UQ\0=c1L
EYP##fK[7\DRSE.9C8d-M6(HMc^Z2;ZIX[8QV#\6+.+U&Y7dYEN.1L^6PIUO.+aS
M874<&H4@;89J86B=0Y/<a05,#fdHg))N3U^+0?^+N(\&gN\3]?+3H=[R&Y:1FZK
P)V7Y#W^0R\IK+Q-ON_T#&e]g3:N5OG/Ub>U9\eJ&.I=4=,1WAON60<YTE#M7YcY
aL\=3R^d1@1JWb=-c@),3K;QcgH+-I)#_BKCX>P95G@/gSI5;VW[VH9.4ARL+_>B
c7g+^IZ\g+93LEJUg(W<I<E1>NdbcZeMOFcAD2NB,Tf(U9VN/_Z97;_RUD7TJ1?Z
CXYS4=Q\Ff7&cCa/]2)B&N>CDaLBeP/^g73L_ddNK<7R0L&TN,2JL5P_+:dC=A1;
DMY4]@;f0[@YfV2\E=TebCSQ@EODc6M\Te5g_R&aTLYL&/+282E0F4eY>PZgBc?,
&O?4DE9_Rga0,d>MPcK?[,+IF^-WY/F?O&2bE\g/.C@JIG;WW28cVAI.1_M>eaaC
M,,RD\,)A?G[cB_GS_#(WdJ7RgK7KAHV-)?DE]g0>5SHL5MD/ABI<-C==BKXEVc9
]6F;f1:0fd(\74[Te;G[(dI.&6DLD45(ZVe)ae:V)FY^f:CF_Hg717C:=1T8<fC=
7VY)^?aNIK1:BMf]=;C/\(/V+\)&Za.4HQ&g.<.DT7#OD;a+HDZI_cFZ^&fWYV<X
HHG>CaAb<)a@&NPUZ:0e2G7J]AWd0cK/AU9YgcYNQ(CI2Cg+E@A]3#4f(b<e@,?M
f@->G8d\<I4IOfFSUe5f,0/c74NDZd3[(KECM&CbaS_ZM?Y8E^X,^LPb-B(-eAAI
/_XZEKCQO[UE\<G&\dJT8\&FGY20<SVQUg/KAN0d>gZAaWf13C[LJOXOQW#GN3Z5
G]E7N^.Gb):Z90X71ddOQRP_KB8UD(\W#Z^?99V0bdbYE3(QW+<gHeOZ:L,O8D-D
9Q:WDF]>(\JR9_MMO@4?DA[T).;KfK3#Z(JLNLMg:-.R8OL@_(01aLD+PJ?NV9Tb
[Wf+R[7YbeNg+H(#E[(W)C49dI,JL7([?(V65K)Tb9D7\B5IIaZeOP4)(E9KN5TQ
Eg\,If+XVQL/F-DTLf.?G-f[f8YcN\,1Qb@.G869@EJ[G#OaG+V>B\C]d11b=EBJ
IWe@&R7aT;<B_]bEFR_aQF.5/?a33)&#G)e9\ORA@XE#G\>Z]7Ob&-/7S[bEUS]S
2,Q_3R>RUKe64Tb6>W\\.9)UN0;@4REH_RgaSV_eT>F06a5O1W5^]]+N484a(GA#
XcCFB?K5..IKRg-E#;dOT)a#TCdIOR5X4>g/d_XF=N1?R6f5bV,:XAB)2,0O?L:.
-.NSKM_9I>KfQ3)EY#]ea[bDY+32<17JRdHIa+dET)/F_RN<(b2JE90?e+_#I#fd
JH-17]8EV80;/5He6R(##YMG5/g95)HYQ\9.H,I2R-gbU8<HGG6f1dXTMdXDfg<M
eE?gV?7KN\dD6^X-F]2e;5eW?4Jc+2?:?+5IXD/UKW,Z-EU\7e9+>>KVAH=D0V<a
W64?@N9+&@1XTfG]>HFf)&.MH,FTcF8c8KE@?R25XBJ^[I/BWY7C8(>6/[&FH#_M
W:;6QT]\AMFR5V.4A6P9+MU>VQJ7^Z95C^4#7f\/5FEK-cG>8[;UT4(=,bDOb;13
R3&c6b.:U;J<FCd_7=cHY;^bJ\;F[Q^@A,Y5?+IX1B^V.be=e/aU^e>SVR-(AgT,
#PY^L_=>C>RaC^L#EVE0?7OK+:6c>+A6-B<YT9S[.WG#RaQdS/\K,SPE[@O/;e>_
OF<Tb((g-6;Dc\&#]&(;]:),VPC>B:D6ZL1,SC@Y<R4W7;V>bBe+a[a3[ccXDT5G
A94-C/g694L2&gDE<?(bced4ONN_d;D1+M4cKR\R0Ed.gbN.C?3X)CHZ2gYM39.g
OU,UPO[fSQ6bRJG=Ic7a5eRF4RNJ,I.XF,e1CXG>5bR.O7bU_MC9cCd(..fVDI1P
.E>eHNI,X..S6,Q,EfKYfE>bU+=B:Q7E#X;Y#JCa#QT.0,65J&LC/ESf+#1d^>a^
G7/aFB3],C4;R)g/P=W_4V\LD170R6(M(N\cA7R(2f5:b(J?G&S;GQRA,&D\>I0V
-8L@Q5?[@8_f0YCX_T;O:K_K4C;(IZF)g,)GVJCdP/H4+-K..eJ]J&#SWXE;EB_@
]L><(7^4?7E.3B#[>8a=@,b+<cf5DS=<JFV[_268ZX0M].5#3/J(MPdRTWW9,@;K
)/YdafJ]U0OCcKeIY.],C2Z7b3)2,.R3+2JcN^e;ObB_LP1/Pb^@+[@[;BEb?6f-
LOQN8\-ZI_5TC4)e<-:M^W_DBac[:78P(18b_WRa,4BFg16FK[=Y#T32N]d_D\_F
CJNZZ8H126CgR6,W7)^QeZ<V+,CF^03GG+2M-T7Z30FY[=R2SW=>3>YWg@gRDf/#
?7JZfZ2(?eZEYT183;T0[@Q6\=6-X1WVV)T:88RXHXX+EVR7Wc(,98eOSNP+A0e-
I:;K14-g87.8Hf80d#NZ^;ff(_AV2;J]N16E-.)O6aYYNNV_,XY(1ZLQR#@ND&-.
J@UQ7bKGZa_^9BA>=7WH(cZB_4?91dWR:LF03EIU6H0X@36c^,)M7ZUe@#+^59/f
e.;?BbT87LN2a?PQ[3@U<\;\VRS(4IVd3Na\7J@K/a,#=.GS-+g&-T3:GC8d#Y]R
1FYT07-9N13IUbbgL3M8?_.0SVXdOf8)86VO-)Oc)\3T@M4DX>1a;2MP;P-[R<3E
E^FQXDcaB\(=X,(cL#5#K8,?(D/&8NdaAJGbX?=T^^SNIJWBHO:):ZP-^(2fa]fe
<KH3.0e^P,S6,L4B#DD3^1[e&P[_HW^gP;SX.6dNNgb?ddd#;1NbcA?cOaYK4)6(
_Ve?^2AC.YROSD>HJF0:PDL561eE<@eRb=BV&.a;3QU#dFI4aKRUU(5G=,;3^]DF
Z<6?_[I\da<BXYLTdZ#E:0Rd-gG4E-3&65:ef@aULA1.a0)EZ;8VJVR&HR.;Ea1B
GW#UN#K;C]=@@JE+9gYJ6(0:QO5=9C#,:ODO-g^S#)YPM3beT@_FP#2@7;+B;_RW
&L+bbA[RDYX#VH3XXQ=TVKKf.Y0Y=R:P;Hc>Ae[S\]?_1?(&,dF<I/-L_&THN[VG
<=>P=K(J,a7;AMI:)SU]=QWHCT<_YQ.3e(4]c?8BTR^-LdPeB:9S?@CaO+C6FZYg
.@eY4:BN5^e?]egJS5(K2RLDf@]D2/QTPg.86/<14DLH]Oa+F8D]^:H,W0A)7/eP
N6D+d5ZN2ZW(]3?<L&Kc=N^=)C5f&\G9B\_7(U4(eacI<)VGY0X;,C6Z0,3S8_H&
G57df^;GaD0?a,21_07((L6,Pc3bI(VK0AG(Sb.4.T&7>7+fb.6?SH,Gg=@c+<)T
N&.-CD44303[Ta>RF_72d(+WdYEK<.J@O6#H@.gM+4<4.TLAA9A4(<M4<8CNF<_;
+6X#Q6gfEF[Y?cB:3d8P6gO;Zb#F3/AMdC9,#)QH=YOf/5d)b^Eg&0VPOeP:L-V\
:PRG8FEE:6Y,>9Y>XTKTBd5g0\=GP>5-VfZ-V\-L(@L9Ob<9a?N+5eD-d2&M8:.[
5T2H\#YV)d9/IFYJ7dKS1YJV7>N_G:ZO7DLU(,YM50,+3O9gQ9>a,&IM-]CaLQ3,
BIfDRd6ZW=_-18JVC))2b@<RY_\CcHc[U0g9GQE+V+ZRCSH?80U1692TY+e#T+O?
,9Q\H>=QS<X_ZFJ&TKHcMLd4(P9U#(]DcS=^/TH9_U#b#:W5a4=[Y7,eV34LTdg1
7_c6R@6VB)gGfUI9V]V7M@/9Ka&7gJDTG.;Q\LEY##UUNC.eZ<6Jff;T3GeIEd9M
T)L=2fP&@gC;6SB88-Z,,CY:.6@a[\L9W(f@KP=&^AF;K=BD8AUH1,d=QSJR_Ma;
3020+FUR=f\eb2cI6Q@O4>X@QM24>6TYXA.d.0D7=E7/+F\Z0A]I:22KQPccS?87
HGVS>7:7_>69=RNd^KTWB=O7S/+d_-5QYZO^WcU2(DIcIVA_S_<SM<b#,-S/X9#2
;cRLR/\ZFS99X@JfPT6_A(O.VCD/&Z<IDGP=SESbX/e@I\;^X]=IU6<eQN[Ed_-9
U/\c605+7a>8EV@(=CP.A^KFUOJfQc8?^<NY5M6J8O2:O_c-1d.&CQ67IQ,G:69M
J^Qbc+95=D8da8gL9)VV-c@SCAd4@2_b4EX/\.0)AL4:<TU<CfFS]&.Qa-7IVO4V
eNfR5+VHd61H\Z/H@G\(F,c&1]6#\IU(=W3MXW]GP:O.\WCLOd-=,2;+WdVb[Z[8
UZYFRV45#f&2.:[P+0L)RF.->V@XZW=RZ+D/265):3^<:5QK(NLG:K6YZHaMde0S
O4eV2;O3fA4(3^:P@KPYQe#;PMZ,;eQ+<588LN78_-5dP]]RN<=FVNHDbCBA..YM
.(DL7<8\?^L__c29HZe8eFe^?]69gBAU]HAbO:(9gcK7&[&4;((+F^.>^BM6EOd<
E#LLBa9Gc)WICQJ\.-F=4;^d9H;>V)[OEAXX6KO&d:^UZ/.;TBUQZ?Df.BgZ@a&e
6=V0N832>_Z-LfERFNWFb1Hb.KZPF?5SdQXVbb(TE3:\3VC.C3-+1PPH^@A=40(/
1Z+R,P+Mf9<^BP44GId-He^5e5A>f9CK]A_HB6T6N#-KcW&(M&Id<8Hg#gSJ7g&d
Y,a[_a^C;^=dWB#[LZXaCb+gBRWY379UV&QPZ+F,dW2Jg#&TS5Ga4CX(AY_a+45<
UYK1;@?LPVJD3W_,F),KT9M9YaRD\S)KUd6<9K?2+[dHR[3?B[-3X5Ved7a-5A:)
&7?JgV9W7:I&a_)WN?H<?a/&3Oe\.>MJZ;/4Fc>+f##8/DER(aAbL]EWYT(1Y1UU
LgbV.XN0Uc-M_#]0[WE4]AgP8\OVb.CceaFT&&U3U@WaSI\<]WC.K&C(Qd&M6CT#
Fd\4c&68O6L-=V<UGDBT7a72GEJB;N:c_OI1],cM#+/K:eE[-:B&Z0LEPOX2=,EV
WT]\X==68X.6/D_8?K--B2d^D+ad)7F4=1F(4:K[,QFV[/@-Se&28gQEEfBD8]Q[
R,P:BE_GeY78N)02aA78SU=>=RZ^C\KS2,+333S-CA,POM2)GJ-(3bKL=[UH6(J4
.PdY,(Fcd7=#KQWWR6-X<Y3HJ[G[V+1+MYgU7^E^b-ag_1d/=1JGLQ><PfJJB<[X
X&+bVZBRd/A=5DAa#0:-^V7a,^HgZPDcP8P[1VNTTB(.P46192:WK\Y2M9R.7#=,
0c)T1]/A\.Z:/O8B=Q].L=#Z\@OSCM^ZcXd31P+AH-]gEF:Xb+Q&cK\W25@Q>;4X
7EESQE.V;e)8=SB3DS=[SbZ0R](FT5C/.-C(EFU1977?IVBK8@3Q00-2e&BgD=,E
OQ^[11/#L&bL1,T@Q[b5,U+TD4A^VL3]OW#LDT:cP61gPF+<X:1/=KeK-D0]2gB4
6/\V3[WM0_X)Y3HS9GJFKK0#I2I2I:J>9-3Rd\SGaG&Ca\5I@3(KF56(O0-<WPXY
NGaf90a,+4F#f.&eK\T7.;8L&T)IF.QX>b#S)-I>N1>BF+-8c>Me1/(.9gWEc_#0
f6EbE@7WRU_A9O9[:J=.4D;GQ=.-ba+1>X+gL?Y3G,<A0U>+=F3\EC2/=LKS[;.?
>P&C7.,>6HIgF[-2.4^]Dd82dBYR;Pd&;e/8EeYc36PJC5,QMV81\ZNY;b.O?B[D
d6dJ@M_&G2AM>0)TR_S^C#RNNTL./;O9JI08&U4S8aZLD#@-W;5DH8NM,gIT]W[,
)INRZ>>/XLB9=59@?bC34(FR=BS.cVGALaNC)\V[T65\3^FUeJD8_@ZW>aUO4-?3
[[?;9?c#g?Wgb5R<Dad7NTY]1g4G7)VTbD57&TEeZTQTHW_\>&0.aZ@/=<@6RcU1
a7T]XITdM<(/=UQ[IQ^@&Q678@2HFQ97WSQJO)5bLGHW;;;NATPQW36:.E.--),b
B87@,LbO;HBJ+SG:IR2LV/T(B1Y5b98gT,K637c6?+FC)B(MU:>?,2OH[.-cC5MD
&5Rf.eFZ]^aT-]O\QK^9+^F2?TM[+C//Te;B)1T5T_g@KIT\<Q)?M2/F?^g<M?PP
+H4-a?47[DCC>5H@G&Ee0B3O=Dc=T+<A=X#);R^35@a?C/G9A/7D8,BZ?f]S[A<W
DUcYE6C/=_S)WOe,489?e_>a4:V)(/Q4X0).S#^4UgTM]4I<7WWJI#A6Te>S-4QV
9Z^\)GMGIUWTZ_KFWN)U/.bES),AB8)Y5FP9PSAd/V8H<=[JK,1FNJDNN+W/?H.,
OCSf8/cL.=U6SLZ9gZV(d2&)5??7?KN\U;5@)L8Z:B.077H3C=OWB;WI[&HG>IT.
O4dBNP.MN3(E-@<:W4d)eTEeK5UPKWK2#UK9ANG6-G2,K,YSD>U+EK\\[1?]BOa^
+/=CcJA=9O<(IQf=59G.;8-I#D>[:F:TCZ9G745WL0838f^FZXRf)f??a[b3=YX.
39-(9LS-->M1HCFHPB.8B/&dHY2+T8e8^M6(8:6T^D>3^W1a;T)33_)Q//a@PUCU
HI#DbQ68Saa:-;ZPbK>fG/]RIM#O+gb.U>L-dJKGLE:T]C\O7(L2W&0=<[-05(Y.
6ObUI)NRPX,4eS1IEB8I:X-b.<fQ<@8Vb@4DT31]2d.CT(1#S/_9/S.MYY9VS?EN
<A4DO[F=4=.H,>A#LgEeDE/4602F#N<aTecXY^MaU><S]dU.5[5/P>[>=9B;Z>O)
>+8^X8O7;E>7V<3P9[e5ZXfH)A@O>b2ME4L(F7G77WZ.&)DT?d=RGA(\B4LAYA_G
^4SH=<Q9bdaZW.-)^c?&0f)0Je1W<3R5M\;-K\<Ld-=.RU+H]C[EVcO;?A+^@=XZ
ef4]L.&YQ^(:aX6QSP26eF]IZN<3)13EHJ.PfUQU?.MBd]:d:@,&fD]M2F79bI00
dIBSUY1RI6d+BYHOSN/S#gIH;YRdSD]5b,A4/P3UEN9b:#-2+-5ZS.+5&K@:3Cb)
6G\2CK<URIRBKO\[.2b.b.a-F42K,\W.9I<f]&@-K=ga-:dSV8=:2,J;;6U;,9UZ
GTPfgMf@QXcfV9Q;+/H#OfI-_/TT8&[e>9b;;_SLPJ,PB40E2.Qd730Z-).KOdba
-)#41R[@.F#-7NAP1@Fe(NE-.Y>>04&I)c:.W:9;45MFS(;E.a2MH6BDK?6ENbIV
:\3Ge/I,1@FF(e3\9X=?#J&9N&Z8?XA76Y_A:S<U5a++UPF?ZQSdb+c/WSTT\E2#
=GcTI/c?,720UXO3L;J-W\QGO6H=Ub&H65FAT,cEN^:U&0J#3Uf:Jec_d698EbE6
b#cONe<M7H[:_f=M-I.+RKPU\()R#Y.e5D]-HGIDPdF,RC#?8Q@.bc5d&>Q=A_.)
9_fC2??U[.P8HD=f-R6G+]0V-X>L+T@B3Kcg>IOX2/+YH_MI8AG4#ZgPP@(:7JN7
&_4(I(>4SG<J.Kd,IJ@^3K1g>bf<=U^;ZO7Lc(M2BbAV&5.G@>OZ\\#]3[M=NO7?
<b]N3JfK1Y61,64/Oa[ad1dSL>43J)JB-P=[,E/7BfYJ3ZXLE6eaM3dSd&FB)SG(
<S1PU.MNZ2GOA.[Mc56eU[TEHTNYTD@0];AW;7S:<&FTIX/8W_39[EV;X]I4;d@L
b_OBZHESI&#Qb?L\LZIH/:DL^:PSL<\/c(A5/?#f7bKH):\F>,_5bfA?>-Q(2#:W
9B-RBUDBD_J9K,MUa>NR#VE9-G\I#XLEH;a<aJ[/,f7(.@.:3@=T/S5FR<D9+O/3
cRc9gBa.BEQDHFQ6[9Z77(\,V8[KXYZ-PD;&9J686/]YV9eL6Xa86]ZR9G#TNKLB
QT8CMR5BWG#,8dXd=7BE\EU85@V/9Hbd-=\9c0ER.++eKD]HYIZ&b:4/]<M,=&NW
RgZEPI[..GWC7A?#94JS9PK&9Tc.-8[_<8(RG<9+>[.3&<977dcB?7?/&R9^GRT+
L3],+#a8a;8\[/[.ONH)UK;Fce6\:0_9(,4QNXKf+W4,:&:/eDO_EXG-T#2]DW)b
^1&YG#UMRa8SEX<:9V.W,[>X.H65Z79SFM=&LIdd9#0@YfKgEDR.^H^VZ]&\^M0.
cc7eQYG?1ZTHfERLK>#EI/g:aW\e4D-@P2K)YIg74.W+3KOXA)N;/a7NKC,Xf;BN
@<M(Ba[M.0V_H67#fd)QRYSMg2RS,^=VLSTCe/:&L8B<D04@;bdZB^Ec;>QMfG:(
7BID@GLdO3L3D26.KbML#B+4C.5A1fU;\<8OS-O\>L?UbgW#]g_]I8b8cA_LN;f&
Qb5=RDIX4UK:7AW3S.TO5-GUH::].PFWV/0&]R4(_XM3Ob(O=[-X^GK2RYYGG]:V
X:fGD9E[^-^>aRgDOf#SZ]2fQ0)F7PZ82U&@=c02)NF5I4F(c]7&7;\8Q)8H7#==
V7:0YO1(O1XKO:W<d+V68g^5cXcDLK7Y0Gc17J\cR[ACFe]c3XUgM6D+96K^<.^Z
M_K4EYGPG,F.Z6N9-5&RBII-He[a>87?DOK6b>S6K[1IeeD3a:=#DW-<IQLBN&68
]W]TUP\NV&1gC.VbfF0HN3@DWP.A1_::;[VKU_DXR,Nd+2ALeG(d5Y]0<e^OT/fC
1L/6-N&7:Z,PgGD>5LUV;\aVF#WNE0J7[?TU.ULNVI[&[@XU^[P&dW1bU>1IJ800
;)V3XIJaD[[E/YAQOVWQP9FJONJEEggDEVR&]YV1EY5OC.<gBXeKf_#LO&PK;5gf
dfZ9LIBK66]J(I))7?1SID23dS2B-P77?7,FH5YY&7T.M(4a95O]dEX1OaP6c^1<
_A3f3GfUJ_W?(7PQ+E[)5CT[Q3Q(JEDg#FgWD9+g.OfFKJ\#5EZCN(EII[Ac#D._
4\La/65&N=gITd6@dUL7069AZ:<.S^Ng0HL31_20=#WHPUI?UNBc7?=.J7:MG#,e
:gFYJTVEQSSPgfLX/A=RUEJM3A>ZJ.L^W?O0OV9ge;2.dd^0=ZA.07=)1[J?6&cQ
1d1Ce=K7D3<>R#,)T=JB?^,&]3\1EFPMW)5.^^S(fTXA)(54E@KC4ZQbd3OA2>8@
K#+21D,^D1T/MG?^L?;GU#&)@QMX[D>]g]@Z7CJa#>CaH-@e-VKWfBA6S:&9d/7g
+?L=X507dfISPF9L)M93R^M64PP;cE]BZa?HZ?(T@RDDQgIL5a]3RBP/d(.FZBbc
b/??YA:gPH[I68N8B]\RSHK-6(_;Ie[/R=Ga8E?XbA<cE<.7C]G,ccIb&XBQU]]f
A:.#X6HRFbVYKGOMTcH7W@3LVFN6Bg=:)-R[XLLf[Ya:TGG;Ub?9,?c[/189;K3J
@Fc0^U=+]V>;A3F@S+bJHa6:df32-<7G@\0Sb&^;=c++Ha],_QEC#A42#X>b>M->
WHE.-KJ&G>,/09)JAYRB&CVQ5=V]:KOQ:6#e#?4#FG:MU7=O&W<Q?5]<<@F=R=42
5:F1GPTaP/ZR+RdMA2D]A3g=-QKfJR?Dd,0-WF0A<P_:E12;_2&/9]^&P+MM]U,8
//37XW.55MKb^^eaEOg2,9W\2UILfP@P)LaI(/;]P<;8ASO.Y9QdHd)#b=dE)6,Q
_gJ\O&=+LJ.N53T[\>L#G2G.\P4@;1-(G+/1ZEKcU^3C./.<GUEe1DN).KDC@VSc
Y]Fg=Bf\.fXO84>RR.9D6]W7S(#FN.G+bYVgPVg_72HJD&WU_?&,LNB//WW9N(fT
JPY(SF^A.@),8>J6@85C^?VC;4>-c#?J-#UW^HC=.Nd_<XSD7>A^8KZfJA.OEB^d
T82ZCU^,Q+EcSePS6e?>=-\D#H3>T:GQa_CE/R=R)O7G<O/5&S#Lf<)=8O0ggfWa
:=Z;4bNdM.BN]VZ@C\VCEB+PdP(U92GO4;<bBP0,8\_P9Ea[M\&GTIN09GKBQJc9
c?XP,(&,RS\R-bgV&1A((?G-HNL3eU.C1LEUV^P:Rg4[/?b]N/G#K^D(>1&/[gTL
2SFM?-TPS/g-S<D7,cQ[C2f:9?.XU7\W0C06WELY5FCc?@60H,BYb/Ng60Z>R-J\
6FZ^_\X:cD]#>>1:3K:gf-&bG=<]76)1RgH<S&W5@[B2<FbGU+aUa1NHJ+,g)#E^
MGQF=;\^Y<?5)?66UM)67:7N#[M.U-1e@Z+^4&Yg[M?=cI[aHQD3R3LG@O5M?b-Y
\Ue>cH_I&d;2=\AMZRbFPHVNUK.fQZ2b_V,Gaa[>LIO/U9&;XH)1EX/D-EH0,PLF
X#;[+d;bKd\e>]EJ.8C.;ERR?0_>Y+f4S7Ra6=\L<Q@ZXf^5,GXDT9-e8>4G6-=Z
-[RcE0WgU.UT)Be8N0@Ua;FaX:84?)MN#Z9AYAeL.fPdAZ\c=YEH:-LZ/SQ@)SP,
1D@N#;f()@Ud)=[a\U5H78#:]5c0C8S1acPIE66<7J[3#[4A8OK>M6bZ#OL@#W4)
SMb93K#SX<\>bBSaG=9YUD;4(/A=KI[TLW:,7LBBd<>H#6-7f[AX7C+10_/HRR#K
<]Jf;[cF].1(+ZYG6[F@D-L)aC6Q,QY>Z0(+#?f7Q)g+NAD,49,J3:-b#XIZ&2:E
JL3^QL.8gffTg_WNS-P@YMd0bWB:.4ZS1cY59aQM0eAGIY#d+eeEZ6?OWXCEWM&e
;=FPHYTcH[B/d.K3Bgf?2B8B\?1CEWQ)e=9SR<g2T21TYDY#b+8.M;fSMR8M;W]D
/.9-4<<&f0:eJeLWRg8;aeTP/K84K/27eQeTQ_@(HZ^=K0Z2Z=4+6QKF+b52(8W;
<cGYQcI^96^#;WG:].)fe;]eJ(XY@O64<H#b2+,4;dK(-<_1FP:?c-#LEHJV[4@<
C4]7ARH]da2E[H<QPVYH[?bO1CBQ2Z.b#ZJK^(1[Q.a.-,1L\dBM[MN3:5P-f,9@
KTEF.#.eE@D.5JRCW<)A,I^+F;QXE?-=-2ac6_#TS3S>1,(@I]^S2,gL20HDbaIQ
K<TNIK[6<83G#0U);PIDJ01_X(\6G)Y283QA9_4PbZa4GI>P1,.GXYVF3Eg<)Y3.
FI4b#FLX.GcJP[Q?PW85I+[O<2WKE6:G>@WKO8B5I,(PfY?/IA8H;bbf0+9[Jc;<
YCBG32KBIdJac(6)=AfI]-A,S+-)g+]I@Pg9@DJEHDW&47_2U--9.[SJa&.gG6\c
YcSRZ(3V85@CP^I?DXAN(OWN86FQLQ4?\7-CR7=RDMPa&-2A0E(Ma.<:;@MMX?7\
G3>Q?5++E0?d3[MDD)-Z[K;OC)ZA8WYH95@PJG,DO=Ne8I6g7bUP@QQXK_b6fgVf
KQeK(GJ,_-^OSE@;=#MR,6KbF70XgG.#aL^6b04E]4X6O\KJN150UbPVK<gfTD1G
[3C(\7gMJbD6M\V_(CYJ\8Y(Q+IJU.(,&ADX<HXM20aRff0#P]BYbN6QVJ/O@RF=
2aU;f[G5+,XJ1C:0H_TR4/4LBH#AfAA3;RKR))bT;^]-()W_&/9,8T#YdFR/f-<W
DU^+?ST_C1,ZFZMKD^@AMFBZC4:V@()(cU5bXAg5aE<1gVA=LI[E3-.2Lc->>OGP
+#XX78HLIM3YBT:#\/F4b9R+b\K26[7bOM)&gaHA^J<+INV/J7c#fHI:EZ>WQ[1X
2A=,[Rd2?TafUSS._#402dPLPfYf>Qa(b\;23F^G/U.I:ZZO/[>7NC,;):(A39a8
agaM@FE4#KP/f^-3V@&Q;W-fP>>.OT\ZBX&4TXTJSS)^4\7DD545L63VD>C.[X::
G#POP&,fbZaEc;&DWe^W=G&X?D;#Y;I/XgP,aMH5c6<\2:69JRN0(J&1D/S&8@]K
GE;91\(Ldg6/4a</D+2XW\^@H8JL]62=Ba\F,3:X0FB/N3:U3YHd:X=#9VRLBO[M
.RfUP8X(e/-TdL&&a3]3Ed/7Qc\F>)-;&9#FC>-C.Te2::BTA5[UEdI2<493WaQ+
G)1X:d0[ID?#FgA\YYT8;0(>;I\HGHM[e_,=C).4.?,R#R9EeB9K^8^47HaWf\5_
E=GG)FOH<3PK7#U^X6#A5CGE#/I_8ID/U24.A2&_@:\\;H1g[\M/.4(?VQH0=Jcb
F_S3f:5D,9:/W>d(8^RY-E]0#,2b=3LECLKPKI0+2<?eU-0afCYWOER)X]\H#O>2
FLYMW(CeA/eUJd1VbR8#B>,]d\L1?ADF&eM=^WF>a#TO+9M72+4+e+[QL8gW>=Z2
.XMH>b\D0;Y1Y]J@R<K#U;fMZ4<4?^LQ.:QZF,P:K_M)K<UWIU[]][W4[daTdP6c
//2A947IgV&>:Z^]M8d<I:./L8<8PU+[^VAa#Wbd#<73;IC?b&LR=C&J-cD.9b9&
f-WSE&UNa)SN:[K+6RL4VKY_NBRdIXM2Tg6@780Cd&6PgJH&@/e0X<-Wf59(R>[-
eYE2I+cUe3<EI>C<<>A\UXXEUb2D(be#.@#f<L=:-EaFE6+=aI-cEbT(7@KWJ.L_
XR59<f[<d0=E+G>OBDTbZ-c#UZ39LT.c17<Y8.-)N6Y2C&:V\TYQZddK(0CVB.EN
.]Sa?I>BN](7NKVWV6beI[.;6W3d8FZfb\+<;L8CC\X:;4HdD69_cF][1=0<Yf-S
,f:9E-58Eb-d0^.X6[)MaTYHV;UT6>DX>F8)d9[:H=Z;-[XbY)G+=b+JYaFNQIUa
CdOaWNdA7&.ME/6eAReV#(Sa/.EVdbMe/6XeWRg&=K+1ORb1Z7PXgASU(gT-c/A2
W)Bg15XGIgTg:J8^CeNM;L\S9Z=+dF.EY8T&GaWV6@@(_03)dMd[#3AL7:9b7B2#
^O&\S^/+]4^W(,9WGf459H:SH9Q5_M:YAO-eWIZL0H.@2MJ<Z^gGSf]AQ,c[74)Q
b2;a>>#+6/U-O]6JCK;g#>7^Z)\#)TPYEJ/IF1SHE^[Bgd(e53Z[eSE2H?,a0/16
<MeWTf+\(O@J,.8)6QBT9V=a.f<9e1Xabc3B5,0+>/U:cU8+KdB^,QRR?>(HAVFW
O4BWW2gGa]C2X>S^-F/bGbB2L9I]X,[dUQ?J166,8Yc<&65,E=.fF1HLQ2D.\fMC
8/4I,SN&Y:4XAQe,P6-7PRIJ&ZV)gaL1eVVE8^aSQeXAJB@P>SD^eW<O6AST\8[W
a<G^Y@;?9</SbU\G1^[eJUUXCYbR9.db+?KU4VJG3<[15G#3@Z6A6G68ML/?-=8e
,9#2G5ERI<De=^\aZNVLVQ?V0AdIRgdUL=e.1=OgIFRB:QK@Y9B]M;TP,W@O0)8+
;gS(TbS9C;AZ]g9eNE&WGcNE_bPHN4?6+[OG-3NBe##[F;\1I(Ef\Q9<PGIcAN]R
;f\aP]N>&=+DPP1889+f>E;</,E8.V8Tb2@-?ENHcRBa/JIHIC(E>TbZ/Q8FLe>6
9O[1#V&QM(RE79GI@71Hg3E;?N8EOXZ>fN95O?YAN?FPIX4a;2_);1+-1P7cM=X+
OK:PUeE;PC;c_:LXdAb<@@LFKOY<[,)2Pe=&.c2OO/BIccB1OGUfEKG&6F6+L#4H
2J/F-b<Q@]fWSXV1aUIE-5A?d(WbBZ2Q)<f64U(EJ4G/OF/KR,PY1Wc39D?/8?6P
EK5UacC40M#MB-8L8IF<)76d56)5318-OY3J/:C-V[O4C&.?RbKfEFcV44>bYC:\
gBKG3XJ<J-WKFUPW>WgT=>6>98T/6#[C0+af)g.gZ5:U/OT+H-UJ.e0S+7&?X?[=
JHe&;Tb2T\GI0W&-a^3QbED+4;8THaA^1]_[C-NKQ&6@0KZI)-e]L+cT.6CK1cRa
&)V)-WaDK#b;^aW#Pe>ad.eXIG7c3S,:3\(DJWCIF@O>Y,+ge1?#^L7aV42+W?AX
DRX7.F+d70CXNT@1-UV<T[7a:^34BKKKN73,JMIIEVQ9&M&V=fdE73CTR?P,9#CL
IR@05\CQX>Bgg3<9R#]bc-1VFDO+::V3;B7?:\#C2YWU#BOGH7B6QcQ+\WMc3O<K
8KO&>a[bTGb&)NLF1555Y0[S&.B(?f2:@;VN<+fPU+a?VaZG17\LVG8e?^?\^K1Q
aH?D6#(>M9;^#@(4.Fg74=UU1SF5BC<@H/T<O(g3>ZQ@3e]B=6=+:6,<-8TB(ePO
H)N9UOc1+EVG>L-bX7-@CBJPEDBR:Vf\[e-(9U7:9ScHJ;0K-K]/1Q+T?:,>7\S7
&FXT13A.2R1;OO;NIUV6/Na2V)..])Gb9OXO?f3U:MacX)2/&L^<=Z?HD3,=7f5X
dU.\2:D6b:Oe(aU/GQ.c3NTONZ>29:a8;(#cPXO+J-YR,?\M915\]K]R.>[9>d+-
L,J(.X-MP-.^^T,L9E)VW-F#DP76bTe+V->XPAG2WM<Q0JA]7Ce6a(Cb]X]1V-;d
Ze)fY0cMHON:1(.X+?eg/>87gMNUa1R0R_YD1CX>I;VV@]/_720^(KPM6I0@:24P
]DDAYAd]c>/eNQB1&T5>+O;Pe#U.0EAeeeAS,&dZSHMD0f_=c-V]T2(GBMH=IBD1
FU4-_W6^c7g)#EP>0Ed;GN3aHY6.3(&NSaPL(BfH/R/LXII5Z7ASRQ^:5[9UJPc(
+/#,\_39Hc\]H80UA)d2+3BPNWO<X:;#+KOV4,QTYPeGfME6G\NPO7XFa?K(,YJQ
RCX1QTEHE4X4)c<GT1I[+LPV_GE2X]dQ)XfR7/#A<C]cFJ?Xe.BY72N>^/)3;A#A
)CEZ(=8/-+JN:(Ba2.)2CR28S>O?CP:FcCKK3YTDZTGO3Y9)8\,Q&T)0E#NI&3-c
SUc>=).R4NS3=.#SDL7=K,eLII7F7g[2J+(gS)JU(@<H)N7a)\MYdf.5T&Q)Rgf<
A>4S>8]DHM/ZUGB+<[H#a^UYKg5ZYFBXW4,Z=RcK^)2T@bb#(fOK=gZeR_IK0_1<
Tf@>ZC0K^=?dS0KU@fg78]&2\H1^>0XHKN,9;S2JXd@>(H-(KQ-7#37HBN:cQed0
9=A/I5>OZL;[dF>g;&:7?c?JcYD@N\I->Tbc3,@8O><[W=T++6M]f;P/P;=UH9.P
+O>2=T?^J)Se<@,+G50/S]1TQ<g&V(0gNaWPA[3?aLB.2^QQS<IJ65;[6I.e_^IG
2--<SXe->R;O?U#77\\c?N9TG]ZE_WIGZA@RV)>S;aVR+JU2\4L2e3IT\A+2dAKP
.(.fSO4&H-_PWX:&YNMIL>MV)-;,R?_9Z;GD2=a[^,a^3FIJ-J2D[^0Sb5Ve<CNI
Q2R-UF1:dI?(g];.f.-gF3SZ);22:NAAR_ZH@5K2S4McVLA?T;bHMV>&_\1[2)EE
YfRT-a3(Wa//D(\?L26IY_-98M:?G&0B8Uf-@.<T&d2a6Mdb32]8ZUc1eF2NQ9FD
NCG)/41@76bEC3K(6>9;T7XQM.GF6M\527,163]B/UXQ#Q5F_H,+=<LM]9M:T(a2
K#7&:+I=QV9Ud0R=K?2DXSJ4.]@IC6;IE)IT_Za2=0,ZI_]JQ-XZ1SWDC=.a]bgW
ZU3QMI1Fa,&0<]RBaJ4Z,/BKg:M(L9=ZX>DgcP=B/@g9MQ>Ge6,I2Id&9E0T,8)a
.&Z]RA2GXT=W3OA@#J3ZGKaNcWDa&>Z)F9+2g?c)_c94M=B:Q)X^]ZL&Ie&600)2
_I2-C0\:[-R>;QfS:)dN<[U=Q,]:C5^UQ(VfPA(6ET<4OOgMF<71_QcT#5/0Z@DM
c@;Z.M(a)ZAfOT<2RB[\SS)\M5C??&LF.?78c(VPYBRR##c9XF2Oa]aa,RdQD-J]
E57+;F+/Q,=^80K(Q,--=+eKT0]FM#UB#S8<Y4QS7<gD1g=>^eg9BJF]3:01f)7K
fXTa#2BXCTGPLKD)27,6JR(S_b[12<5Z(ggF[[d\\;8-@?R/b+L+^+X3SaUGT)(^
QWHfa^9SL;YF;WgeB[=XV.M82/;TKSRM?Y]8_)@<^ff.^70;Z(G@bN]O:AQHaR&a
_D@IE&8-HNM:4?Y+.Q_@V9>U_A#O#(eE9[fEbG1^^d>Z(ae,OX&/McCASH:Kc9Ua
-XW>MDIXK-PBb&^]7W1>Z^VDcDQd6QaeMOFA#P08-TJ?fFaA6G=_CBbLAc/;S9Y1
WN3.a2>4R4V]YadUW6[f5K9C?A2IeH[B9e\>Z+DP@&^@IW2dT77L]\Q>KNKOd(&-
.VVg,DS=&PKYGVc&X;dgdINBUe7LaC>ZdS[bPfX2eYFS+@b]/UFXJE63G1N47[fe
Q(IH/cSb.4DK:XOeI+8R#_.g40]@f=VERd8f1b0U?f1cE,47C])d(?-TH-DS,KH+
NM=>Kda/JJ8C2;(&60:&aT&a^4:&7E7H2^U2^A;]J6/M4LF+5?ggG>&bbOM-cdaT
<G450(O,6HTW7+A159g.WAI>Rg-381feGeee-^ZT#aHaCWQ]/f([0REfNLN=RQBa
7#?Af^L9>=#4,BP;0f--E_B)9L&XD7V\fUU9H;Te_T?+;4O^e(JCf0188Z5HA0+H
2++R-SW)@1\RY5.P2CDBeZcGX6]bSDN_:2->5,C@Y9T_W/Z<WVB.,-7@N]026b#/
+J^fY](5)5;DEU]FSKIB(EIGP#8@(,Z8K);3)YVb?>-0d4YV55P:;DdLBe1f^]??
E)HN5ON1cP)Ha65U00=R1Q(<-,D)LU.C#)16UPfI.C+;E?U+S3@7J28OL/TB(:1f
bg3T5G.@WSMe<(NMWALN5[/XIfK#LY2XR#(/L#?=:N0eH::Q1-E33Z271BHF:d[[
E[\KFXT^,bQZQ@2e\FN@dY>QV@=(DQg&.J,L],fVDfYc?BOBXRG?(DHG&&93ZN?d
c]d73Q6e6\QVA5011\];RCX-OY#K6Tf_;YKGWI<bJ&,X\>8N2Qe:Q>=#]?WOf6fc
B++CMD_0WA1XVKJSDfZ9-c#=5K^E8g8&AgbO:<If3Y9_:bEP0H0UUJ9d;fb5WfEE
?]0?_Nd;GL(D@IPDG9]Y:WdDR0#ILV660VG_>US<a3<CPb>bPFLgeJ4@I._a3Y8+
BY(2:<,6g\=a;E:\7_1SUE6NA6T<U.@?(C2O2cS9TU:J3^Nb=KIY>7E)eZCacSRF
X^I3Mg99N[S#g(/SJ/(>bRJWUI?/HO;gb-#XMfN-b=.)X:[a0#[DA67]VNIDA[B9
FCS+6e+-9H@6CPLG20961Ed4Y3YYN2U=g(/A)aC^]SV>aG6c,a)ePf=d[;D]:c#]
--W5@D>U:FB(,6PL.<3d4Qe[XA@b>@.GEP=_=?=J=T)/T<3I;^2JWa;E?.7-T(?A
Q-QRa)9GS+ON1V)f=eU^X_RZ(6XdYAa,^6Z7>)@MWFA7G,SS9/(=AeG/A;V;UOEG
C2NbJ_C3X=;I+S41Z.E/fF8L=gT[c4)H^1H=X_eDeQ1X\H^6QabEAH;Q#a40ON2M
OM2<QJI)#M7OM@/DRCM_EN?O-6A-7&@:I<2T#?K@dUT&48^bG2gBG0?P/7fBSMRa
O9_TeL;g<<K&V8((&U1?Q_5F,YU,dPN31@S>c+]2V,CXK/)Q[<dH\E,bZF.;;X7Z
P-<:C/+-eMX7R?[9K/21^FWA3K3addT+WJg4M2<?OQ.FeNga,aT6I:P<^Tg?&BHa
O]ad?V+_G;K7F2J1G4gf&KSUKFUY:]</OXd6_NfCOD^(9A/.e]7JgA-?SO=MbgaJ
Nfa,,^V.J;Q>#QSX<g\>UL(W,^bIR[d[W(7@ZAcNUTVA.+INBYSABV[QVcCZHcH?
gIP&SP&;G6KbY\XZQ&Q]N1JT\8[(35f6bS]I?02[LN[A#fDYG;3Pd\LFL-(:[0M6
&0K:\Z5e?cg.f#[-+GTG<Q04,a\(G[(6KMGL14&MGF;KPTD8E(b.,6c?W8VVBFS>
;:[D\d(DF_LTA<4>R-@I971[?#JU5eY(RZD6:d7f0QH>d87G(V_[2B^HF3FQA..e
O5(BJ1^b<Oe]D_KJ6g0Z-8c,dPMHGA-UHcGWEU[(A]S&UML>Y,=3UA2(0>#HKNb?
ZcJG7+g4RG66,e&364[UQ)f4X[3-RM)-]71(L-#GK_NLNMea3X3[-QM,0/]YReTg
g.b7KNB81>5Z2I\aRc=cR,5KT4,>Jba?<@<TfFM]UAQS3B&ST8Q[Z^df7c-</1,I
K]5G^75W>#aW57.UY[:&HO+F/#2UfU.PTE.4g(Q+G8_A]_4WBfOLD^8YKR0@+9#U
<#dd2QYW@5J-C<g^ZcJS.IU9/KD@U1&g.Hc8eV7+fIA@C<Wf1Ta_6>>bf2EQF9G8
9cQEIKERK0WYZN423F/0S6N@gK/U?AH<W)FVFBGcACZLc2BI9R\g(?/Ea^L3R5QE
adTSFA(C):I3Z#2aJAC#RJ;GJc,<-#8;YDC=N)^e65^H2Z#T(2\(O==USFVg@O73
E1WGeNDU#(M4<?_Q[Y&gc-=dR5T6_RQFC3&I)ICE9d?>NC93^JV#UD+7JBK,R92b
3^(8b4P@G276[7Q_VA+>H89[NIZB&+7SWf?YgU837g+TS>IMNP?+O[>+WV&?0>XM
3HFZ>_\fV/79QXBTc(RAWfE28W&6@=Ic&b^C\XW8JQbW_:e,.-<Q+bf&B4TUC.U+
-6ZAbSCE&\NEND-RKRY)A.H#C#-7,T>-^I,Y:RR+N<V+SYH&1/RJYa:TN-L7(c\=
P@:T+T7^^fQC>^a]U\b49KF_H(B8X2@GAPI2]4SB2ZI;:8SPg)-)F0KQ^Gf=YZOD
gdT>XVS3,3Nb3+ZH>\EcFTg;8@/\;GR>d7.O?@g>]@L2JMR;d=4LKb\gbS.E;35+
aGb7?@F)<?fd_4+K/DP8FX2(7deg/c;Iccc]RacGR#);+HG#TaO@VPYcW2?aA82@
\U[@Xg<JI\9DR2a?R9>H9ITL<a__DaAU7<.4HTgFN?KUK86d5,1^7NK#6YAAO6,D
\DRc8]Z&TGR.HV=e=.HMR=2VbfTY0>@<1_:+N(P2J78J\X)7R95S8NT_6.XDBC8)
@5B[50VRd7Z\7Vb;J:OGZ?H(,LEL_=&eW7;gKW@OSaLP>1S>1R[)9-dP2-gLdL:C
XQ^H_Ld=_GOFBcb=#SUSS.ZJ^C5?T3\1R/Y^IR8\Z>Ka1UFY&/ZJf,<P.dN6^-e)
O+g^=5,SX^#JNXX6OT;a<&K/&aegB1^Z=8L^eK:INM0NK6S<AP<0Xf8_c-EfM?1g
YB^dZDXe5O.7H]\M.c/A&1PVDX&AJ+8Y\^X?fg>;WZ>-gdI+d@::V-9)[N;O-<+M
33;40<gKLIO6F\N(GRSP_;S_<cf<L/<G9DbB,H\O5?fI#&TGb?>FL(K,I-]eBCWR
J8ETIP.TbMS#H[64UGf<(>&0B&e)-<eKe>>+T&,\9I6W\CHS1gW>CWa[QCNd=;/#
>DIBS<AEJ.b.f(aZ87bPH,)S16=U=bOG4OXYEC_<B1I+&77c5/?8DX_YfCXZbcN=
SYWE\_VABD?:8-)_(Y9V:8\PDc_1U-bZ9:TBK4U9O=C59:4;TT>#)0+,#/:?083@
F/9R.,1QC6<6:U8+U-@GEH/C\GW&K1I>(5a7&91H^=E&#D=,S#C#SP2\Lc>:eb?:
CX;<DDgTZb,?9+5^Z@/fa<=M9#;IGJN9e.X;G_RI)5Z]>YNRN5JP/F(a)a2GEF81
B)bb8=+.\bK>S(4;><P&//C?,+.S3SM;94d\^)22[JFS(IN1BPKFHdD=]NMc>?>b
9Q+b1V&MN26)<>#fH@eb+ZfE2DEF[/[T#S;A<Gd4#FG47PO.K-)B_Jf@MOgfZD&2
(]YaI@/)_cK&E=;K\e7QKGb6EX<V?e=5b^+=SE_6f\^S<b.gYQ7EL2]FKR^_,1YZ
[?3:c>04]=OYCMbG(&LDQJCOg<M+#A1fENdJO6Q[:<F8=MW#WO<_.6=;1Q0C4TSd
8X>NXD7K(C9>M]ME)6[42VS7+(.WQI_E>LYWMH<ER;RgO4I,?C^XSO=/,d@Da#_[
)HU;ERcI7WW(=NXTQe?SPSd:;_GE-Oa-bP8P8F8c]I.QI/AZ\U)J4DE5D6<?:#IO
bg.7Y#SMdG.7e2/gM:QN>GH_S>/8^3UfQaM[Wd=GTS5SXC++EgW/72ae7ELEF48S
&(_gJWK)0=g)[NXADS2^V7&?b?/@F8GUUe\fAaV\>^fc-E9^8UM:ceJ)TH.Nb>5O
?RVA0a>-5WdYfL0O]J#fU^?J62;(&3,6]MT\ZD[dL\QSCg0UB][P22L,3_IK@>-?
fKLHO+]a=PAKT17Uc2FJUfREFe[#G-c\M:I@Qd@N9LZ.>GMOf/6@JcN@[;T)/5f5
+0J0AX^g_K#Ga>Q8N_WCbW@<1?AX2M<0(9OKeBVVHg##=-2O)51(6<OI0NJ=M8B6
^K1Y^XdMZ7]QYME;T1-L+;^]eNgJf,PS@BSKB7>5Q?a:5E\eYU_RcG^d#(V/<;E>
\23cVPc5/17QdE>A3=DKc_aG9cccTeOHa6#RCZGW1UfS:LM4]JMIH+>=c(cSX/QQ
8HCK<E@7[WYH>XLK+V@)ZgUW:#:&HYB<KR65Q&3bB[V\#Z.PD<bBC\/JdNL?;B;H
#a2P1^>d;E4.)<S[)UW#LF3dbA(NJG7,@C0(8@R.L[U#J@,^INga/BZT^]cSRUE(
f1<<DdaPfT?BHP3=(7Z5fQ3b?80D>dBCMXC42dbd1+-WM\O.^f_UXeP?C#,c:59H
aK=bD+<Z2]5.WO:<Od);#OROPbP5cf@fT>OIdM;0-./=FPaU3YX@a31C_G4&&-c#
^3e:E<8E_FAeRg;;X9M>[=?O,8MVJ;9&#?/:PH@Rg]#H:/_CM-5X9bRa7T@e,AS@
bb63^Vd&@)X5Y+e,GbH/MO&?:U/K2/B,>[+PS?0gH65f/g8WH,(,8+\?XK25&=+D
):]dZe<KH.Pd[a3XA>gUWI;,e(;4<G#>_AL2,RJ^TEIU_OOdL[M9+7W77?L5VGAS
(LB5MUf8.)Z<c,.@E42gFa<OBF^73gXE\[30F52f\)V0Q]([.4f7_65c+7gG3OP.
)D,2+M@=O;:G+=GEJ6fE\(K>LRU<YNP#Q;DA360.a:P-[+NJ])6@a@\44>QSH[S/
/+6F<4@X2:A&[P,)dW,J<Z4S/7bCHOEMEda-aEB]B_[^R111;EGbI>gN,g_G71Q=
_?Uc;VGPc:5Ea]8LZH<c-e5e:f/X8OZB4_IJN)Ag0LXL6[KB,Kcf7;O)DBX?7=G0
N)[,/6@P(e(.=Z^DTIe<:]0G[\S#\U0KW?FOISEO?0eJ34SF2MeOFS]KCQ;Q9SaB
PcB?=8&I[?<EEX1&dQdRR4CT&@4W;/a3^V\L2@DcJLSW0)[CF7[2TAN14Q:3gXM_
EXR+=EH8_?8/eKg?b<1bZBc2J-B_,f-S+?P\N+ZV1C9QS;QOUR>E.4R[gNY/.E)E
MKT]?fQ9dUfX#7:?=\SC.3N.YYTCT^YFTI]dH)Pe[;eJAce7GG?d;I_@)VHc=S_a
S54]9g#N#NJI6b1HZ(?/7d\;HC-^LDZRTYMT7CP#[LgZaR#Vcf5;=1(VCVca</<4
B&?Hc>@faEO7_NCVC[(N?.WR7C2OcUM_[RG5FE[G?KfT.:E<8@#6DbNKT/75QU2F
^/N?#)27/NXV.9dG;OFe@2T6YfT7:?X@]+B_(==D93gPWW?T6YP#QdDPaIBO=:,-
Z538O-(X5U+<_W&/dW4[J<:M02DW+8YeXIf=^6M47aA:gfSX;(3M4506gIf5].E^
&#H.5SN]I>-^T/8e,F]W>LA-EZ=L48.eN:]57YJUM#1R9&L(&9K[gPf&:JJML8aV
V>Y,QYF2)0<a.:H_APc)f&)QT-K.&&^YE>37+_KXDIdLYEO/:8#PKL9M>P>E77R0
X3NK]PJ.C[3+J^S9g81.d-aJd,W&D+I(;+Y>..5QL-#R49-H-3V&NT4UX=9Qa=U]
774H9U(ME2.+<67\[GD>5LeXJ8MI9XS7_MXP;<.2^B(SCO,,Ma+Pcd;.NQf:5?D/
eaT):g88,2=c_=KCgS(8VB7&0<G>:.6dU?NR+CD0Z5-??OLBb[AcFX3eX1>XVD^:
2W0;9@?P@V>4bTF;cOGQ.STI\[^V[Nee:-ENF/<W1Y4:,@P#=IE#@fZ)>1a>9KHS
(UMA+]/WJ28=25-[N8Eb#Y(6MI-:0&NA8=[Y2^=/0WS4\\\4;5QQH-IHEQbUdW=B
PS:R)LZ.#(\@;1B20a@dd/VH2L5#JRPLMI8ZWN;__aXY+&JFW[UP,f]36ID&M3+8
Fd,OY,K0f=::4^+5S<9dIH/HJ<&?@5]LA&\.T0OL7DW#X+)=MNTU_E<TefV^93L.
cGfea8L(.a7DE\E@DB:^c>RdJP7cJ-b/BW+]eHUdQ&&8Wf14/DRUW21XY(QG#[TA
0AC3;+&6,@VJ7_7C0/@S^8G3=/],XG;3dOS_C=e7&].PMVQc&EN/=HLKgHK_SGPf
LAOV,/VfX[N4II]=eZ(5^DfFK/TT.B45)CTRW[>)]IUSXIZC9E/G0>TRgT1Z#2Ef
2CED\YAc#1-,Z;K6_;S;,\9FHB@<UHG#NW6Nc_4^CBO)<X7PVA\T,_fRD)1D[O4\
SOI[;?1cO@A-QZ@>3J?44X,\CWTVU>IEM?ec8eVJJ.@eDPa]R_\C=GV>9P/:VcFF
==.KdcCeZ5G+D7J<^4E[dX>_WL[@8b3R:6@OR9(VDK<b+FNCU4.X9,@JR^\g5IFY
40C_IBEgUU=#J3_G6-KX7#?T8@)FCE<ED<;eNE9U5XLAIMN0WF0G)U9<4B66F-La
8/+2@B;Nd02@?FB+18AQT1#YCa/8:8T132P#[IISDVZG_)#;JANH)B=UfL,IVUI<
W4T^1a4/?-COJD<O/5R2a4MPI50.^Z4I6fGPe^d0GUf]9\.[.>gYUFMPQBFaA&(2
VCP3dZdPe4Ma&J?D8;)?L,-2/e,_ZKQd.cC?HCQS&>_?G]3VG9a:^#\Nd1\8BaaU
QG0-6X@42[E4@RCSF(TXE.FNCI^))Y,2>A;0:a5D]C#5a6@-7OS_/5@>;ed?g_=[
^?^E6,,^=:>#>_dNYU&UO;]Q-C/3[REV)GN06>S:Qf,;S6?CTRC:;aX#K05?#6JQ
S0R>P2ee.)fS__aW\T/BP^5CI7bYD8BWd].Vb],<A8d6K/R?cGfOCKH2c>Xd7dXJ
UM<_QfX]\7H85;SK(JUUQQ,NL.@Q(5@e3DS9G?AReGcZV2f=2+PNDAR;:+ULd>gb
XbeIB2?NZc]egYB2P>TRAHgM>-V_S&(1]HP04/ZA&)BQ39g6C7gLad^#,]>C6^QT
2cV3YF##d@9e##2-DGAMaR(QO=57Y:<>aX;Y(8C0c3LNEI7QAB5\O1b5XR;g/8F\
c^?,)2Rd3f+52SeVF(G#aI/JWKL.<(CG[=(Y8W/.5_UB_QRM)02,5IZ.()6XVH74
,6]1f]HPG(GSd@Ka-I_7I5SOCLJS0T)&EO+KA/)9&UF,f5,EKY1UO,&d:VGMGU/e
=Z&P.=OU6dGM>P(Z8JN5G7,,2<Y<WEI(DJRD/PMST(g+5)D;AO,6&.79MNEYSG8d
?8=Q-M4^F)BRI6N#L5Y@+SMSPE04+.ES>ORHN@6gWaVU1]PSU0K:)V;?>L[-9FcI
aEZf,BR2?9cRK4BXV.TAI?_\=@bfg2.EU&@cFKbV:@(\L\fe:6NUf)GOZ4Nb.^D\
W6\KUA2CEHe)f.<J(0H5,2V&7N=BfOT#)OGR,N&G@5]N^@CEJK&P+:P-@c,/RLR_
1_BCBXDa5)RC^,C.3J^aaX]Vb5YIF0^K78[Y/]NH7KNcaPB@9L/1O8a^5UFa(PY+
8.1?-D4>\gG6QPT#:1;(1B^HPN;7R.9>Z4V1Z5bb++ZVf[V<I2,.W=eQZ#>Y9/<B
-SM>N=SaW0fV.,F<,JH7,;_,VOMS:a-e)P@BYO<g7^OR31f;:,D&_BTEKY&DND7]
20\>WGUb5G2>0aQI36fN\O^N(N,+Y@[8T\7Qa^,09N.N2]bTbK==b^:?Z(BJY.G8
L_^OMdT^XBQ>8/V>PW_;IZX0e;)4N,/_T3HM2A\ZI/Z+;=b+:27CSPR_;&WOae(.
+YH843\ESW78K,GaL.JHef06+[C_<4)ZSU9c=<cf;LV[.eRV3Yc)9)K);?&AbQ.X
A#\GeG.CS<PJ^T1GE3,ee#.1#3&LA],5U#T(c1=)c3;aC0.(@eI963UaZNQVM01^
[EIT4afSb##X<Q]Y:\YRUNa>Lf9TfdROO3#W+LJ/N800UKL00.+V.KbA/IQ4[\(2
@8YYREB0S4J:2G7a81;PM_DD[+=+AAA&N9fZY,]c/.7J\Y96a7YNSLJVKc935+-?
Ge<bM;?fU>H:BKY5SNRQ@df^\WgC:;\B??JHd@+-Sb=VH:Rfd^aWD,RRK8JVMZ[[
8<K.&RaB)FV5AD)K/OUU4^.^4)/a(@<[P>2ITc2+3PE<3]=>7;.0ADIF\b\a5Gab
UX<=N&4R@D&EI:K2HH.M7C3BWU)a;ZLW&S)_UL.R,^3AY7&->)CKMJJ1:HOdVcC4
(:SF(5KG_#T1J/gHAG:;H-+0ObKEFD<;&?>R;+LSVIV;LTA8C8Y=,4FJCf4.)eD[
]dbG9M?EF8Xc<\2:TBQ7Ne,4?O8(bcggRB6_P1/WOd21I5#b#_=59bCbfJ=1Y4I:
M_B;(Pe\b9<f7F\Wf[5B>7<+8MUHGP.S-(R17abf61a.W)c;8eeaO0gS&\:2IVH0
@W4YYMgBVaD;CH@L8+URLK4dC+(e[)TC)Ff4G7^T,DN_,,(DB(?O[KK&@G>5[/K\
D3L^d:-^>/?;N.<M\<c1QJ\;c)e^-+6&K=52E4MeaI@J;3-:[fG_0(TQK7fR&1N>
>VXgM&ALYTZa3BM@2M01B:Zca[dVaU:>C#-aRd>90QGM0EICUL#UUJADE0:=3K51
=,JgYdB,YJ@TJ-/Rd]H/\cZGS7+WKQP(@RH>2JC_IR,2>Xe:VL2C=/MQVdUcOJR1
<VA;Ucf:<1USNeUHXI5)_YVC3,7<(-(9DH.=HOF<ZU)5J&[@+V0S#Le5c@O<:K2=
^#TS=3dNee31EW#Q+)#PXKKb?0dP\BXA7.9RgPN,=E-_cKCW+AHga+P=77S:GJ;b
,NP,_6S\<b,6)?f--HI/eJcJ10/RV6X(f,dU3bI3JWSSPQf+_d05W7DUQS8ZOH2W
JG\,L6b8^8V_8aCUT0N3eF&DaN5F,]V_/1G[VD]1O=9O=-KW\fLCX<<K).4GKQL2
_Z.T2cW#0f[RS><,(J1UAZOL)/d9;A5007-YF380d#d1B\=ON>&_YS,+Z<&VeH?7
L,VPY,PDa[>)[/9P49f-^/1@0)dXX_Mf<AK>bE+_>DR[cPfK(6>5NE<NaPOO6:#_
]O:Dd@Y[[X-<+I80-.=4bEL33b2?gG24bOV:a<J__8CXVR+EHH;#&Y]R;SO2QYG#
H?e:N[S3<@,aRBZ4.\<>eX8^3_8]:0^O#NH]FBX#8>?,D(@?cb:]G;)++gE((X18
fV5D]8SM.8XG^aRE(gcW?;c_aOLg;3g:,SX_><JNbTJ[dUZ5bILAb\c#2LNO)-AY
/TD-3(H2Y)S1+EPVbUT37dLQGF#^00eNQN.MYIG)I^5.Eb4F2U7N4&TH+?H6B(dd
92FUB[3:aXM9/a0^4J@aV]+H?f;_;5<\=0<8I+8S@b9^8ST=Y16aZ8?<-UB]X[4[
-7V8J8\#T#;+IMdPcC/+b35T.6+3^]X/V)M&++g,85[7I4C_#BVDDdYN=8R0@d02
WY1):E1^+-SE/0FK,T_LAUU6=gg<5J:W1aOb4K0Y0PgC-_JM8TH&8O(^W20A=NLY
4+/4@Ke;af)#J4c?S&Ief4@)d74/>;][V(9H=HMbRY)3S6;>CRVA:5(EdGGVg>eL
2YT6dG#<fXe=EY5BEOZCW\:HTL5URJ[Y5efb^Nb[\QF)TJS6&;OY84H=62g:gK\/
6MOfG8-Tb9fBV;BZO<.<KPU@GT?I3db)>Xb3g9(A3gNH@);(dbKIJ-#YFdKNSOU,
/,B^[aF.HQ3g/]C6>VTYfVZ@S01L?bf#Yd;\YPbefbgYDOe3[EJNcY,VGe4CWgIF
<(]W2a-4&P=-EPN.9=KgHVT]#,\OQb>cU0OSOP01)4<c(.S^6&K-+B<NT^,7#X4Y
BQ/G)866EcYZ5/^QLV]KXUTX&3Y;]B,bI633@L/O3)F)\PL\B/Bf63)E#X/f5P4T
Z@4HP6S71b0d+@?\CG#;;Z/LLg?]\Wb?/e=THM:G3gK5SGe]KJ@QNeW7(XTTQ-bJ
c9@X=;<b=PA4O&eLCK6\\]B-A+(ZPXE[719NDTO/S^;0W/40T1L^T?c\d#4g58T.
7^]-dZ]]HR#^H+4K);:.-Z:)F3])EPb7[)G-c65YKX=>Ua1S?=H>a/0c@)A\edFb
a&gM>Ka)C[J.D_D[T+TQ:S0HGO(#e>DD6GXMEW9XGN21@UaL;;+E;294C=YCA.&W
^/PaBcP2,-]E_HTZEBC]C1L,WS[D,#W/[dN7+H4(?OZ<WVT),68L>U(</?Pe+MRa
BT6^ceD_a0e8>#)/PRW;8:UAG5A-d=XJQCe30\F;d)f:5fMg2Qfb2g[MT7I_O2LH
43,CHE,O.3(L@EBSFOY&>gd;/D&V=ASHO=QP(U&c,dZBSOMPf/5BSf=+HXHe-.8c
AfGVfabETTU4c?)D0fDfII@L6G^JbCA,0g5ef62N9Q</]OV\)g0HIK^-6E713U5E
;-PEF\>79B5R]6[M).O6Z?3O6G?b(:X^N3TRVM2I#M1=;MZ-c;X,6\aIPfd&^0S0
]fIHX(<&HQ-9=D<b=Je>QHdK1EBAX)@(CYFLNCCH9A?>-3+J+AI<Q2d\)e<Q2]#;
45Y(bAbAfa3^19A9UX+;EZUC6PPVI2cC5\:4KgWEIP6CZU]c&ISN#RTbV8(fMTcg
8^6b,)(Ra4PfaL)W:#;@Qb=M&DCR(=E>^IQZ2)982Wf=I4X_IP_)cBI[VVA)Sb(+
T5)@VN/@7_7CCY&N:7L#PEAd>\[JP;90HG=SZ+:[W>K[K3HY=NL556I=#)[@;:DB
GSD=N(O/IG@W?aJD[5Z6XASC8c,-@_=-WD#[0FDJac;^dU<W60>Te1.&gcBUJC_@
&-6P:)_^&2\Z(cP+2+(MCF-P,N7eN4JVY?NMOeCgfP5I[feA)5VZCa-O/c+JJCC0
=]bF8Qc9c[5+HQ)5KCJI<7]42e1#^&cX3Y_[/-B?NTP)/&@>OE6H(2?/;g9WXT=]
G^B^U/d)]?77AJf>D4MTX5^[J\GZJ3OLg4BBaC9OD@,7Y.NV?2D.bFT]1YOHfMXR
@5MQ3(071dU#I&A20eE90e6/?ePF&I/cFW-88=cF/1]R[O&S]SC+-gWC@TL),,2R
bZC>ZO+7Fa))#Ed-&d30R+3T0VEd9/7WU@U-;S0C-;0S\a<Q&UJRB?Q<dRENW,-4
=,;98?Ug@Dg6WgBLe.@R2,#Q3FQJ_G]BG_H-G^We:Q-O/4dZ>[c#><BD>UcK^8(U
ac2PR/VJA7UcX&)Z#KgL[#JW,OAa:@OJ65_Y;(/?TMSb.Ffa3g-ET4Qa5Zg;YQAV
,fN?AQ3YRYb]O1?(W,VaB&#3;OTg/9SL5&V3Q7M:K5ZL6QH-J2&H5d-,R@(:f\/A
I-7/.Gf-.^]=/&f2:=+(NPT5AZFUF7SR\T=_G8Ma[g3eLWR.D:76RE.eT+:,OD6?
@2,.4M/<H[<&)T;:BCPQ<6&XQe&<Q4-TP_+944#HJ014TQSXLV#?3d(IR)c]P#e<
?7C2,7SO@3?8;D,45\D\MJ8B\Ma1c^^:1K\@7;3OBF<T/)LfC#M0+bFO>Q)dbGY>
d8+DRgd_]BT1XEO@N[N2,GeN,3<?\@\_PZI[Bc7d92&-Z1HaY0[(?[dVPX=?QZ7>
OX^a&P.W+0/4_MLS-1##E/60R4Y_]\6EZ6>bT2f#2EbKPH[=8P:6DG+5>2O&)P(D
6TEVD-1ed8@2E8\RaC27MRPB#HM_2/X-Y(.E;JB^M?CEUJSH;gMO7L[1bb/[9JMY
Hf?PEc#WPf\=.;dOK<MKa76C#6(9NXH^KMI_--+NH&YP]=H#7H:M45E^0;R(@?JH
?WQ@1K/6+WY-eZR@c((QdF,R(:>Dd2-]5FW^);8:EDc8#V)bSa8NF9OT6ZZ/-)(C
0F=Y<+_<1#7aW(G(#-dKFUQ&ZL2(S-AgN4#C]R870M_Ig>-?2[PBA4>HH]WB<6OQ
8&#=\T/I78@S<Tf)20+gT.\XKb1&B0P?LA8cLT:CB+SPD_,&75P=-?Q@gI0/W53#
:?A=IP7,3cY^SH+DX)RCDfAT9VVU4^Y(E2V5MG+bG8+>L+4_F6#@OQeOUg+T][6B
0b^0WC)0)@;MP;STN?KRHP?KYPN46da.5ET^I?9TDBd-K1Q)c.Qd-c#Xf,WdFZ/I
E)7P[_KEE17P.IN4XC07J#POG)fMP@LCUbB[CSNT3(35eIgN9W+HTgM60a>aU>d5
C&fZfY/2X#OEI./DYE,5Fg#/\0GZE\[Rd)gaS_J6/S20N/d9,Z4];ZLfS1FC_a;3
DRJS3S?LeKK6K;[G)1B4K#M?BIU?ab+)NO3\V;.:YIG:,X4dZWac)g]G2CF+>^T<
WCcB?6@?/;==C0\Z_@d_9Y=D9g&^X3gJ,fMXK^GOYH+;)60G,&&^bGda:NEL7=e]
24F_-8E1DU5<ISGEEWb>(fQ1fG;QG9,Wd6=_M?7^)@8cA/La])_?BJM2D@1&_R5[
HS707[)(4VR05_c[K#@O^NdMVc_ALCV<+BB7=eN;;:>dXZ7D=CJNC.139(XYX=>E
IEP.>]71.9Hda:@C0_@_Wa\[H2KS5C:g(_DSPMPBTB-VU,/C2-W[?XK0\>9:R#c+
<>R9Ye17>G/d-$
`endprotected


`endif // GUARD_SVT_XACTOR_BFM_SV
