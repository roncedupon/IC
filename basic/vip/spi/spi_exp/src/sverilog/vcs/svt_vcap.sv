//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_VCAP_SV
`define GUARD_SVT_VCAP_SV

`ifndef SVT_EXCLUDE_VCAP

// ****************************************************************************
// Imported DPI function declarations
// ****************************************************************************

import "DPI-C" function int svt_vcap__analyze_test( input string test_profile_path );

import "DPI-C" function int svt_vcap__get_group_count();

import "DPI-C" function int svt_vcap__get_group();

import "DPI-C" function string svt_vcap__get_group_name();

import "DPI-C" function int svt_vcap__get_sequencer_count();

import "DPI-C" function int svt_vcap__get_sequencer();

import "DPI-C" function string svt_vcap__get_sequencer_inst_path();

import "DPI-C" function string svt_vcap__get_sequencer_sequencer_name();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_count();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_path();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_attr_count();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_attr();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_attr_name();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_attr_value();

import "DPI-C" function int svt_vcap__get_traffic_profile_count();

import "DPI-C" function int svt_vcap__get_traffic_profile();

import "DPI-C" function string svt_vcap__get_traffic_profile_path();

import "DPI-C" function string svt_vcap__get_traffic_profile_profile_name();

import "DPI-C" function string svt_vcap__get_traffic_profile_component();

import "DPI-C" function string svt_vcap__get_traffic_profile_protocol();
                                  
import "DPI-C" function int svt_vcap__get_traffic_profile_attr_count();

import "DPI-C" function int svt_vcap__get_traffic_profile_attr();

import "DPI-C" function string svt_vcap__get_traffic_profile_attr_name();

import "DPI-C" function string svt_vcap__get_traffic_profile_attr_value();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_count();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_path();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_attr_count();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_attr();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_attr_name();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_attr_value();

import "DPI-C" function int svt_vcap__get_synchronization_spec();

import "DPI-C" function int svt_vcap__get_synchronization_spec_input_event_count();

import "DPI-C" function int svt_vcap__get_synchronization_spec_input_event();
                                                   
import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_event_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_sequencer_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_traffic_profile_name();
                                                   
import "DPI-C" function int svt_vcap__get_synchronization_spec_output_event_count();

import "DPI-C" function int svt_vcap__get_synchronization_spec_output_event();
                                                   
import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_event_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_sequencer_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_traffic_profile_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_output_event_type();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_frame_size();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_frame_time();

// -----------------------------------------------------------------------------
/** @cond PRIVATE */

// =============================================================================
/**
 * Class for interfacing with the DPI code that reads an external VC VCAP 
 * test profile and incrementally returns the data specified by the test profile.
 */
class svt_vcap;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Attempts to check out a VC VCAP license and read an XML file that 
   * defines a test profile.
   *
   * @param test_profile_path
   *   The path to the test profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int analyze_test( input string test_profile_path );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of groups defined in the test profile.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_group_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next group definition and returns the 
   * name of that group.  If there are no more groups, the method returns 0.
   *
   * @param group_name
   *   The name of the group.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_group( output string group_name );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of sequencers specified for the current group.
   *
   * @return The number of sequencers.
   */
  extern static function int get_sequencer_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next sequencer definition for the current
   * group and returns the instance path specified for that sequencer.  If there
   * are no more sequencers, the method returns 0.
   *
   * @param inst_path
   *   The instance path of the sequencer.
   *
   * @param sequencer_name
   *   The name of the sequencer.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer( output string inst_path,
                                            output string sequencer_name );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of resource profiles specified for the current sequencer.
   * Note that one or more resource profiles can be associated with a sequencer
   * OR resource profiles can be associated with each of the traffic profiles 
   * for a sequencer.
   *
   * @return The number of resource profiles.
   */
  extern static function int get_sequencer_resource_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next resource profile for the current
   * sequencer and returns the path specified for that resource profile.  If 
   * there are no more resource profiles (or the resource profiles are defined
   * for each traffic profile), the method returns 0.
   *
   * @param path
   *   The path to the resource profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer_resource_profile( output string path );
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current resource profile
   * (for the current sequencer).
   *
   * @return The number of attributes.
   */
  extern static function int get_sequencer_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current resource
   * profile (for the current sequencer) and returns the name and value of for
   * that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer_resource_profile_attr( output string name,
                                                                  output string value );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of traffic profiles specified for the current group.
   *
   * @return The number of traffic profiles.
   */
  extern static function int get_traffic_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next traffic profile for the current
   * sequencer and returns general information about that traffic profile.  If 
   * there are no more traffic profiles, the method returns 0.
   *
   * @param path
   *   The path to the traffic profile XML file.  
   *
   * @param profile_name
   *   The name of the traffic profile.
   *
   * @param component
   *   The component type of the traffic profile (e.g. master or slave).
   *
   * @param protocol
   *   The protocol for the traffic profile (e.g. axi, ahb, apb or ocp).
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_profile( output string path,
                                                  output string profile_name,
                                                  output string component,
                                                  output string protocol );
                                  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current traffic profile
   * (for the current sequencer).
   *
   * @return The number of attributes.
   */
  extern static function int get_traffic_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current traffic
   * profile (for the current sequencer) and returns the name and value for
   * that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_profile_attr( output string name,
                                                       output string value );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of resource profiles specified for the current traffic
   * profile.  Note that one or more resource profiles can be associated with a
   * sequencer OR resource profiles can be associated with each of the traffic 
   * profiles for a sequencer.
   *
   * @return The number of resource profiles.
   */
  extern static function int get_traffic_resource_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next resource profile for the current
   * traffic profile and returns the path specified for that resource profile.
   * If there are no more resource profiles, the method returns 0.
   *
   * @param path
   *   The path to the resource profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_resource_profile( output string path );
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current resource profile
   * (for the current traffic profile).
   *
   * @return The number of attributes.
   */
  extern static function int get_traffic_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current resource
   * profile (for the current traffic profile) and returns the name and value 
   * for that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_resource_profile_attr( output string name, 
                                                                output string value );

  // ---------------------------------------------------------------------------
  /**
   * Moves the internal point to the synchronization specification for the 
   * current group and indicates whether or not a synchronization specification
   * is defined for that group.  If a synchronization specification is defined
   * for the current group, the function returns 1; if no synchronization 
   * specification is defined, the function returns 0.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec();
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of input events specified for the current synchronization
   * specification (for the current group).
   *
   * @return The number of input events.
   */
  extern static function int get_synchronization_spec_input_event_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next input event for the current 
   * synchronization specification (for the current group) and returns info
   * for that input event.  If there are no more input events, the method 
   * returns 0.
   *
   * @param event_name
   *   The event name.
   *
   * @param sequencer_name
   *   The name of the sequencer with which the event is associated.
   *
   * @param traffic_profile_name
   *   The name of the traffic profile with which the event is associated.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec_input_event( output string event_name,
                                                                   output string sequencer_name,
                                                                   output string traffic_profile_name );
                                                   
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of output events specified for the current synchronization
   * specification (for the current group).
   *
   * @return The number of output events.
   */
  extern static function int get_synchronization_spec_output_event_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next output event for the current 
   * synchronization specification (for the current group) and returns info
   * for that output event.  If there are no more output events, the method 
   * returns 0.
   *
   * @param event_name
   *   The event name.
   *
   * @param sequencer_name
   *   The name of the sequencer with which the event is associated.
   *
   * @param traffic_profile_name
   *   The name of the traffic profile with which the event is associated.
   *
   * @param output_event_type
   *   The output event type (e.g. end_of_frame).
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec_output_event( output string event_name,
                                                                    output string sequencer_name,
                                                                    output string traffic_profile_name,
                                                                    output string output_event_type,
                                                                    output string frame_size,
                                                                    output string frame_time );

endclass

/** @endcond */

// -----------------------------------------------------------------------------
`protected
Z9:D)9g?6&1Y3C0;G?UEPEHXAZ93_dVG2Edc6Q7=B/4\-1NNOg8L/)?;+@U(?\2G
SAEfX>>E,D=,>e+82Aa+A\-;YU->2(7Pe;0DO,9TbW4Y0b>V>++,;(C>ML#U)cfH
)_6eH7_J7efaO/6337^Z\De_(I(1eTD/H?_U]N_B3Pc-K(+@2;Z,8.cZLMcdN1e/
fH76<ga1N]3KHR1b/YfN+eWMScZ;DDTO.1)g-\+S\1ONc7CTX58(R[d4UJ[_Ag_W
XQ5-CYZ0(JI-P1c7JIU^fZ4#33]DYU_IW<-;/3N5W)QA&,I[9=B8WfVc(-gbA,7U
Kd]JF]QM7A_B44MJE:K3+H:TGJ+(._H74DJ_<E41&MH_+7J4Z>1:Za3>N+N3#>)b
.e8U(X>^d4PZ3-Z8JEcYY\\ALIX2;eGR,Oa,XH[F(b/fAHJ37HI?2\Y+UJ+UCAa?
Wd_Re9Q>L7/6C?-JUOHNU63E<,/F.G>23WM=^2JL/BRI>1/P_aZ_-C.&\;QOKX&I
ZB>?Bg.L_HLKJXcZE_8\[_L>)gKDT2A88N3d(FebN0]N3DTQP.,c?\J\N=G2fc>>
+K(H+8(FTW8M)ZB8CZX4>>:\5[QR[00B,)&)W;H;?>D1N@9,JgU>3bI.VYXV_PDB
/EGG^]J:+O/BY](3bC@U(;L;b7B7<ZZ\X;;T]e)[,)Ig9IJGY,M=@K<GPU,)#81B
fAZ:R-QJ0S@[dY=\+MB8HfN>TCdV[V^[,S7D:(U.Q/fYC/?[-aD4R5ce+Nb[6&4b
FL(#VWS9\d)VJXe5T^JSA:Pc0bA2T[5adL9.QWI:(P?\HLFXDT[8U._TLIIIa):(
5^MIE(c29H5a198e7&&&[[5cF:b0AG+)F/3F78Q7\QXI=M>dE=WY&BSSHP_4N-VZ
SV.#\5U+&4+\MgS?EIJ7N()3H.YCEL=YBDE6?08SP5gKX#2G]#f<=:IM#+=_JMcg
bGHX-M;1:(4]:BP<E:60X2?P;89g&L&#JbgH[0N@CfPG+QJF1EEMg#GCO6-G,3@@
N<EBB)15S1CT#4,8[PG2MSV@>f)D^G)FL-4Ua0HE-FAAd[=@\@=(Z5C5=2/IE\_?
TCbT>AMgFAc\O(b8=(L)gGf^4MMQ?fW#O_N+>I)FAcZY6DK>ZNHY:0DZ9K&PMI6X
0018N72Y3FPfJ>J](,V\>_,7cEd23.d9DIPa6OK?3Y2_#/:>-gSCIcI7-W?:6YEN
-cP=2YWfJ9S3(]]_bC>34U.90@d87X&XG420.YY2<TWYYN.X;SKI=H(HL^N?MXXV
VB]Ub5,70O;?b_&Jab-0]-AE50TM&36ePS&];d=,PRKL3?e3(:_QLHSVd2QH[T=Z
P0=Mb#QA7/.L<g9:(OBR=-8,>UR^+F2A1SU,&M]B6[;<AWP;Z6BF]0KZM+;YI,^W
,JN</&1a)Q(&/TGdD^KYW^@@=A]1SPc-\3O7gK/(U(2a[XKaLT7d@5CFA=&U4OH?
]JCR;EALcO&W&+6IBFTNYT:8>2&)(_egJRIOeBdSX>RY+:LFLP0R_(^^@+]GMM(2
6094JQPNE/D?/;1)6=P07:Z^\cN]a@ZF_Y6?9e]_O52=,AbRb9;JYNAS07FVU?U2
R0T[@/]gI9LF;,TLASLZ)8]FS@>gY9QYL(GNNCU:9/M1LFK.^I\Z4JIbdR)PBX:M
aaZ9?NT3IMMFLGZd4A^Ta_40S=>EN)S(36A?.g(MVafDaTO5bTEAfcVSKUZ0LZ8L
G6S?RERb9BCM_[<FbV]PXG-,)Z_55g3Rg1CGWHN2HDZJdJ\JTXG6PIVTW2T&?+;.
T:0Z)KO=)e71W+G[682G:7b17^WNOTSTWe=BCI/6M7R_?da?9b-UC:&M+-[SG74X
N<8a[PN;E>edM0GNM-6HV<2DIJBb68bDCOH5K8dR;I0M[CI703\\YP1>3.)W\WdC
BKUV2c)\>HVCL[(D]0;INI,@_D0,J?=cG_K/;cKb>fd^<2Jg;L_WNY>7:b4D<N-1
52REC&)989=[Bf]H[cEL=eSN7T<?VQ#5V(bObIK2\^Yf?W:OeL\3FJY:O.4(79[g
Vg#L;CR(73d\8HG\#^EQC(?f/L#3B?YG]OQ7S-.:]2X7)f2ZFCKB.aS61U.][^GP
V+6dBL:OBPTN(g,^=1eg,)S]^W?73bM81,NMfFZOLaAcCMN)E@g.BN(GX=e6=U3U
SU,c)_&JWSM0J-=T>?WBIG#;-eEFD-S]+5+aQ:AYGJ3CM>bZ\M.?(Q0WC2?&,U5Q
4RF?0^C+JK0@52\78Q/_eGD=)>5&5.0/c7^#gc&HaZ_73K@6N/:7K4>S2e+)5U97
]c62ZB>Rb8XE;-UE(2UJ@KXWPa<8G>#88WETEaMGWXb=4:HE)VR54QU=F3JFbbT:
g9ZJ7=2&7IC&GJg6Q,TI@J@c,(VH_HV[XKbW6DB;PBb&J><<Y(fD;7f5d\>AQbN@
,Q^8-b#44K?5&4ZH\#8;<#_1+I2Y8YB;IfL2NGBXVN1c0K18fMK>CVcCKTDb[_58
U@.9JGUR=<8fD8cE]E)aY<FD4LQ2SA9W_GJY:NZ2?A9CIH-ULS[7?+c;<;0N>)cS
49N3T8JNG-SN>e\8^UR?5P@SYVEJe5FbDF,9gSX.97AD13P(G7dZ<Yg;G&XST</(
@c?c3.MK;fe?P[cf.#dcTLO1O]T6YLTAQ010KEU;E)Hb/<)[XJd)0?PUBLD;58IT
P06VM]CGD\]@4YNd1(-41TBRY>I6AD96F6^c?QVZM9A/:TVM.?\ARIbX^G,F((<X
aI(dN2aK&]7QJ7]\OGPKf5>\ZAC=-C<E+a-BL_7(EaX\1BNe).f74:]c)#8aB(>9
Fe:A0BJ>,e^E58-C?gGJ.LM>_D+RRFG14(+[KF3g1YX;2a?F.ObH8[>3;K4Q_K,_
#=KCS-@M8;XT;c_eXD.=HXDQ&^aUd(S1BW:d\VZ,B1D6J4:>.AR]XKLJf,C3\E+=
3WK.HZfNB0CUL7>d9-6HLMXQZL_@<MTDDLA0<KU86C;Xc<,WU7#^^?^1/?-&#1LA
4f<7?<[1GC\257FcN1:G:IT6Y32g0_SW5g?Lb4:47.H(>I35N7S=974b)eNbT,8c
G)UW_<L0H1aSIC>;G]b@FNe37bBNI+]^K3E7KTd<c.YVAAUZa@aILdEK:T<e_6BB
,AA/A>FV6IS(5DJ6-OW3RBZ6VC&V.cY0JeOg3/;DFHg@_M^(J=&;I5:6CK/^bZaG
3b\8;(JeVFc@)>42(PcC,_=&K2GX\Zd01[aa.G@g>#eCO/WCRH]6JQ0cQGbT>@AT
Y]H]YUSUaADT5@]EYMH5R?Z-TK<UT<LF#W&XKbF\;P:>U^(SW5f6SGJCeK,gZfCe
WVVW.,QdbKXC+d581=VQJ>X+4P_^&LY76UN#8\]1\FA)Bb-3(405B.6OX27)+-bH
fM<=L-W#0XV@aN</A&</:2C?L?TM-e\A@a^XLL5N@U5L(5c>CV-.eZ5)OMeXg>?,
MHDF#\NXG]1X6W:L[^R<0L.[BBc308:6-@.R:..)91g-aa3BY5699ScKD(AB3CJZ
<<^/]cY+BLMO14[fUXX<Z<2=0ZdTOMBaD8Xeg+IgI(aH/gF,e_f1]PZNQa@eI#F(
0QP;2X,S^35KFQ0Bd--:<[[IaJIeVS\KQ+2MH[+@EUM_Mg_IL)KK[VZYfNZQ=e?N
#RBFb\V=3SK)YA1R;E+8N0\FPTeT4CV[++Y>Z\[<++W::NL73IZ8.>(-cO8UBC)d
:,B5Q(6&9SPWe4Z#?L&6P@X?eB5b[,;RW0[D-T_Q[]?V8DAg0..-UG,W44Qdc6bF
\_EA,>LEfUeNMg,)fNK?Xg158DX<GLLbEUcZ&+4[:,_Jg[I=L#.b,R84].+62?<S
)LF,>UP]\TbNAIaAB#^gTPWY)U^PYB8^(4BM2RAT-(GID))A8@38T^A)Q3KEZX?7
e:+,EeMU8d74;.(d@47@O&P[gW9-8+2/6/N4I1+M8,X=(5Ze4Abc#=ZY(d4Nd,07
5^Ic(\7>0&#8[93gXJU&#eDK>8)2:N)AANY^gS5KeA3(eOW1W_<4@R48>;M8=]c-
S0@ARff3&7_Z(3DO7KNF?-A-A3_BM(e&\&dReRMU6]-/[GaCRC^MdO@=f\3LG,D>
\?9B3a0c5@14\A=,A@J.4QHfD8f)G9ONA)e1a))TXfL:A\OH,71Y43JF:+X6<JS6
f\MeTT//+c]\6#)YWYNX@K\D9[)5C^4M_8H)U(DB^]O1\QaPPT9L8_e&L/6C7RT#
1d(<[ME8WDLZVDV>&>[Qe-gY:=_G5?UCf/U:);Q4>>K<C5+(^,70?EYSfMO,Z-c7
5@XL-/M_8CP>B9[+Zaf<^ZV.PK]M?=JUMIFT\JaCYRJ+\VT7FMD)/5\YfRd4NWd&
8.VgT/-(6B(=LE1?LG<K8XY,d@<0B@RM:8TS\[KF]1BWF(PM19&dW3[(L?4d^U62
M[VA7EK8<b;PD8d(;KG<#)0N8]I:KW6]/O1McO2/e^H28\e)/^4\a:?JG\&OIGMI
BTJC]H1b[;:XA=?2bCL-E_C0M9g-@9FA_SVb_((a)dQ,>_6U(_,1)S]PfBW8:=ef
6JD&VOX(\KZ6J_>Q[&P>H8Db3/O9N4HZ9=5B1S5,NFW>a1^GM]DbL)(9UB;W,-_>
J?Q7B=-?ILQ1^@4MMg8FXb_/5M^-ICA(b<Q2>OK^3c/E9^51>LVC_7Odd@0;&IeF
de;.8F[7;cO,==5B4&DC.6PHc/#4[F<B]+A\5RLUZQ6R)PGaNNFMfe]Z:@G9X,MY
;GB_^N]FP8U(OW>X6QfM?ZZ/03L2UI\QXf((\O8,@&TB,#VbKTI,3RHC+\?3O;9/
,?),]BX/A5_]<[eHeTYAPDaWga#SF_a,[Y6P]N-g8CO=[CeGgULe@1LdXY.Y0VNF
9?Rb-b[6g;,Cd8FcKJ-5RJ<T9/P<T3.F.68NZ2UgWM+M?)eG1f22d?ccHa^827RD
_C)AeM&TfG^KMbO6S19KQcc<X3f)P+O/,H1M1(NGJ#ED]b\G6^[bG/1gfYKbTPKJ
gU&3YLRR86GK4#TG)JF@7@,fH=?6#40=4dGY1WfDC16YWZ&Rb+T[dU)TH]E=7UMg
30W-ed/;;3f_ZV;V3fUZcaRDHW/4TG/gY7g?K@A-eEbc3GIE:MD8TCc\bCHN.=\5
:@Y,_#G2-#b6;PA<.-Y[ORJX+E=V9S3Zf_-6LM7BKE>PPYBZeMT6f-Q00ZNQG7_F
J&ICD-Q>=(<:&dfK;B)M)Y#bgN<+^&+I\1>C7ZV&2H.f-a2)34F0>39B^@<4XW@3
R^bJAH<COeRHW[?G/)XGU]J?+I[bN]K:H<KeFYTDQQD/c4?QTdWab@bYdWW6.=aP
H-N5ZS:2>G7UVR]a3TLIR^L_CB&Uf;(J\W&Y8e/8-]X.H@J7M?C0XTEWPb_/&UND
5L&17Mc3H.F4a<<ADGN7J91T-#C/W=6bMV:PF1[egTV)1VCNQKdK2-DJ/>b>K^8+
##gVIgg_2UG_4:,dM;5KXcP/@+3TE/aXF(M4WGZ0BIH\=KR<;-cN=d_@^3C\S6@W
HUCJZM?YX(-2JYL=3]<]>,@:24\.3CddJNN7B66R6?ZL1f/8,+@7,C97?_.1eM(U
QC1CT.MR8WdP\PSc5UYSPA@TUccZW9:bDZS6fD5,@fbQa;HaKI(g1?:=bV&V91bX
>UFS]CV@CV/+N#2Z]PF,Y4;2a2;(DT&Q7#&(F36c]:4?XAOKfIf7e>XVgK?:]W(&
@(STTbBB;S;8EFa.5f)HCXKXV^=;QWPO+KN4@f6>,GB@4Z#8EX(RHDBf/RB3d^@<
?deLHa=CR8?A6c-7ISTg7AXgYSL08;17gLB&\HG0)>/LIg>IEWeSD\/+Z0J2>MB.
6)fE9Y7/X\0_49N:32GW62084F=[25&fJ+9^?[HAW2fR56_Wg.[H@,90)bX:^,NM
;a[Q&Z?^TUa/MP[PAD^RI+d0.U&W6FG))MCN?8)UO-L.C:IL2L37=&BFEW&QB/7]
L>VO-4-4YB4g9#3e0AaTFFVf>@?aE38;3GdI=-97M-bDA/D:@VAaG5b3b2NTVTP7
E_1W@0@b#85^]O2&0#^bJOOQgH^Bb+=AQEW@TK]9b(Z(]AF3,ZC=e>cAC.VTW#G6
??[/aaYde5RE,><TDX]F?00N5&cP9Uf<E2+A6a1c2JQDKWOJba9A2<fJ9P&(JSX9
dge,=dY+e(Vc=L,YVa((R8g\JMD_W1e#F9YeEQ@LQ:WK[6,aSUB0JbdDDaXQHBBV
@:BZL)CTJUeJfITMZ5]a=3Q4BT#>2IH6N<PK4W?>Y)5H&:&CJ+PF(]_EN39eD@LN
-:CQX)YI(@RI]e0\U<9?2UVE0_@bc7QGC+NbW0&S\HX7]=9\gX;+R+,XVeJc)2g5
2R:g1e3-Nf^7RQ9RO7-RUWb:,RP/=6L5=O7X+cYA](.G-GSNRHW3BO0PSMD>+NWW
5a^TM:#3J/]_I/g:T2UQBNM)5F?A>T\Ac9XLQ7G7a.?KgCd@LBb\>HceMg)L)@@U
W=6K)Z1C#RC0(TeL7I0FC)YC-F0EbUH9&LY=>SR-bTB<?4EAD#;9C0/@625./U9_
G7)R@CIQ:NWcM?8[64+&-YeTcLWFTO=Y\4g3(]N@S6b\e?>^7E@,N+X-cJ>#;+0^
TBBa5XeZ@BfdSLN[WC_XQ@bTVZXV.KUN4VVgL/FEKAMY#TS8GObe,H&7fSc]fgF+
C72fHN>9^R.RE437M]+O;Zg6>1ccDQRf9>/^8KeDI>e:>/OX?;[ZXN>PdTCL3O<Z
U@0R4g5c936GcCE[NC2XR4fE4&\C],?KG>2K93#]eI?SRc/=cfVcTZ9?[6AX?]I;
7[IZE^.SHK&F0Lb(\e;PQ8T1KN4?C:+?>;N\R3=,#bNTffHI=,82)R9F-,JN3eAC
gF,2C7c=/bc#JX0e\E=^N+)JQK#UKC/;6^QSUJSLU?.fFSb?0+RZ#KQ&J+KfS^WA
KN7PHI=UC0;#CFK7>,ISZ>fa?][9bUb#d-?^Ma2aYd;[^6&Z1V7I@d?_N53+:Jec
,2+WUf5;87C+2a#19CNHI1:,H.bREJOWW3b6)1IU80>GA8)g-I(<DP62;2gJ0M\)
2C\GY0)=8^U/;PcONeWA4L@V1-.(cFWD7#E]_NbcZ=A81P1=X8(M3?,&K@D)ZOQP
MTBP0E6/YG>NC>#eX>I2dcX0(S-VdZ9?#eN&BA>/Q[13[aX)WG:BP,A)8?H0^[H3
#?(Vd?L]V-/8:QAaX[,H)[W;A5YA0;g07#]W&55<&T4>0XgMULDX5H[B^;N)7AHb
1ECd+05K+J;+W6J/9KQ\@T6IR+c1/TNcIPP711ZR[OVWCX/&e2YJF30LUaCCU\[W
U(CI/GO2FQP:[_,JO@,B4J#009#KXPg(+aZ+ge4](gTW3_AXVT?980VOKgD=&D.T
?gSFC3()e<^R(fB3<bK1(:(4NaZ<CL1@<Ld_M;4J0dX6P\gG)Ug4G\\LOQQCU:.c
_UF;b@9I8cR)7b:FM6Rb>g[Q2=?KK).fg--.6J)APA/)?bb?5/CV;0cLD(Cb(UFR
Vf8K7LTP)0^_c_D1\Z_U\EaVa-WO1-/+5V2)ORINT+L[AAL=abXf.b[N[ZD80]bF
/#gX;ZMKOQbJVgg4Ga(#a&6+<9+LdHI)L+^Z4X5)3KKTQP>_00WYFMHHN)Q59/Z<
G2#T(2c&8D^-:O=O^+XeSQ7BDPeVDLH,QB/GXOXTD.+UHI]K7_XDXU<31ge;US^B
SPAQN2<U3gGC?\]#a^@Q.MV&AJ3B>6e#S63e>bVJ&feA[.fa&G(?eH951KW:Md=9
[5+?U^D,6GF+O5(,_f]2WH)-?<L4@&4S>=4]#?.UU(g-<&5_=;5U=3V785HKI=g7
Mc7;VYU/WJ]bG&Te3G#<C[Me=RH;1PSMJb@RL9L9Y[>U<WEYMRbe4g9H^SL\dE)Z
e61[8Z?-(#(fd2H9fD<-]^]BA2?LWd]9UJR1N]FY?H?_(E;WT:(SLBe?O=<Y2W0O
63379[]a0UJ/FT8MJG_J7+L_UOVL?-@H=@W@<e61W706\&,#LMD>-DNE/^cM96,_
>:/_&]eSNe>gbD(VdfS.LJT#NO<K-\E(4g#4b7LFMF9[E.-&K;&3.f1&CHfGgJ.-
9F^CH8DcXfbWC_YWafD:2>^Y+F]AFH/[4..US2QfUY(.S+6DccVE@T)KGMZ;b3Vd
,M?_QDg,DR(MK9.A\T3#aU7@U.=F_E&2H<fP&g-BUE][T)KeFF,-S&WKg-?)]/G\
(K?&BaF.6LI6VM(IfPN)P=c(P/;M?1T,(0,MC5^;.cF>A>CB5W1.0g;cI6_>F5#B
T\)T&d3&IgBY[E.aKRY?WV?O[\]<3SKK608))\U7[LVB.g&MD+NY.;#:ZQ:OO5@L
P:[f)>B7X2Y9JS>3e,)5O:(@L(79C,\U.4+Db_TO2+(&JQE9I8VDB-afCAYeA<SA
<R6?K#@/7-HP3@B1Q,W4G#@NB\OGFY9V7?SDgU><F?AL_FI=UTXKXU0_:43L9DG9
EI^5)FU3TU4>+O.L52#),Ec.cU:R20BbWCEFfK.Ve=)KSg##U8IQaL(Oa9eH:eW4
F2/VO(XNWR83)1MFIg1^X-B3K_d\AQ#\4-UWKfXK.NUD8WHbDf23M&B3AKFW&cGO
QU]6@^a7(.QcS=U-]RK]/[dA@C0OA[[Y84a/M.Hf>URSCYE^AUg92Y2V_#N@0D</
NMN1g5>+.XV1VeI;30Od9Gd5P)-F34\55\U5IOIG<A.<>ea]@I<C5-YJTdB_9TFV
Fe:8dZ+3>.c?.b3,A-L2-5,7=:0@@SaA[X07.9K6L1ce;[#8Ed6[f&VGNTPgfXU-
R&CPe+-RKHK-_#<18g^@HaHYdD0OeQP3\gT63A6E?H1dYENb\2FbeSdg):3QUOT_
24JM6?A6?SJ)eE&C<Z7A&^V?bU\CXN3C_?ZKR6HL\UH(@Na[/V.(FXZ9PQ[^eSX-
:7B^M18Q:0dJ6-e/U\F:a@09P]?4.9,952Z\>[@BNe(6@N8G=G4XZIGe>I2;WcM\
ed]7OULIb#P[><R5J;f,]7b7M[/Y=Q)aF)S]:^O4MG=5^#W.O4J44Sb.]g4M_]BV
5afb<@HdLUL3)Q3Y#.=D]fG/2gN7#T.;Q&[H@&8N)VYd37E;.3E+GIXJ=1/[M1f<
[RW(f,C<EOAG.]bN:UURZ0@^1cJIY7=J9b:MXAML82>W]+X-:VP^e4_,_beWEEg]
F_V>R,g)MeGb49-_Bg717,M?BR)b5ZZJP:fTMTV<G[8DG/:#.Ua9X=dCa[;aP8#a
Q\(Re7;[CV6J/ad#,?J^3M_\&&=KPVPUAC,7F_8Y)805N:6d(D(-V7Kd/C^TLIH5
,:REIKe9[859\fD:]cO:;PTE.=<Z8SgQE[4M&IJPGQVGO40NTQ]4BU<4I??_[f>(
I5C0(c^9#Fb-4@FS9R?c#OG)>Bf+gecY(S<7g/(UQ(:V08[FJ:;UJ/T<[&T6;.?2
P5:U+?DDT=@[5MNb[>(HA>T_N7(:[#aSB-5/dc=\A1PRT:#_,:5KKgQ=#3K9>/YG
>L_cO..,Y?:I]_YTH\GaH>C:RE.Y2^WE2.]/;U-97;OadX2[MB.cHNeU9ZDK[R)9
ddDQ?ac#R2VY;1XVBH[ecA=;\,\>=7b@/.,,D51U(-cO(#B06)_.[(OP]M3[T],L
RMK/A>KF-<^d8N;Bc/V+.\9:<9bfF^F&0_U[\Ud_OWN)XV?QJ0<(4c[W]&;O?1)G
XZY&9+5@=QJ6>PWH3Qe@_,^=(^e;.f,;Y24==-J,B0BT&KCF\GL2>Qe-BUH_)a&,
AYf7JOW.;UH,CUFH/D>Z8a0V?fWFIS-A@S1[Z=<J2d-KSG3?ZU&FDS7OGU_S&WJU
PcLE_&&KbE+64KD=Cf9E)(IC(EDFVG[(#/P];AbL9&_gObWT1(eTVDgLb/J+I:=&
aTV4\1S,;&gNZdL.W2QQad,?Mb;;c89ccFYQ9faDDZW,LO,,L,I7dEgW^S+U32X?
W^G,[(=2e#SXagE_3C[fY)SaIKQ3dA9-4_-E[#4J3][d1NJRCHK&>(9HS:c[^XDY
e(6G&D@KCQ?W;_OKK,b^H#9bQ:)@R_HGVHM<2[G+=9\NeE@6?NW>C1KVX?E#OD3D
Ja9FH7J?00fVb:GOJAF-[c^4g597Je3^fB1Y=C1G&L,(<(0WIY4fee?^\fWJ?[SK
I(MC8P?^XW_>Z(^?DOW]1?4,L=g418OB[&ID]X&1K_JAZVN\c:YPA9_;[FeG3@;,
LA/(\W)\#_f=/VHV^OMVRGf)[3DAdA,/K#&?F4WX@I(4F6Z4ZUWCZDJJEf?E:5b^
G;9e_9XdAHc,U&5IL4JS&;cI4Y+,Sb9dR[UcM-e[VdD_9+^_RDC__TJR4+0:=f.M
f0a)?bf1[I88HA<C5MbFZfV8+8[^ZY^L8G6\;2a6BMJ,@Oa9fQDTT1MOSNaP)EU<
8?.Df6J#S#LJ?XgE;FPBXH(+d[;W1(cCFM>V;:E[8@;c;/&1/-[].?3,bGHcL)@X
1gZMU\d_-Tc?F/Y-]+[2^J6V2XT&[Z@_X5GU>U,K,O;#fGZCdMaedIH@aZ6gB.-9
[UK5U7KCW#[;PWE##U5ESWJP/_</c,PM?$
`endprotected

// -----------------------------------------------------------------------------

`endif // SVT_EXCLUDE_VCAP

`endif // GUARD_SVT_VCAP_SV
