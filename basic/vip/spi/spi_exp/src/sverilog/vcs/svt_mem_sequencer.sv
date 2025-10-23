//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_SEQUENCER_SV
`define GUARD_SVT_MEM_SEQUENCER_SV

typedef class svt_mem_sequence;
typedef class svt_mem_ram_sequence;

typedef class svt_mem_backdoor;

// ============================================================================================
/**
 * This base class will drive the memory sequences in to driver.
 *
 * This object contains handles to memory backdoor and memory configuration, sequences can access
 * backdoor handle to do read/write operations and can access memory configuration from 'cfg' handle.
 */
class svt_mem_sequencer extends svt_reactive_sequencer#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Memory backdoor 
  */
  svt_mem_backdoor backdoor;

  /**
   * Memory configuration
  */  
  svt_mem_configuration cfg = null;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
/39]MMO7CN=L&X>\eZ/cf5UgV,G8fa]?1Dad_]M@7FEaR#=7(/_Q)(VWPLG^,GUK
W\IRDO>bQXKW+4C;N0LF+gAZ;.KDDG0PUDc[Hfgca[fPO.5FC4]1:#@(5c<&/AR3
=F(ICI,4bWd?1C6EJ(=1[d;82V_[5W^TDRDE&)^af3JT+cR-,TA<7X_R#]ZRF\?5
e=bFT9]0C_WV^aP6eDeNV+_@51BA8@e=<?cf\^;J&BaTF$
`endprotected


  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_mem_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_mem_sequencer",
                      `SVT_XVM(component) parent = null,
                      string suite_name = "");

  //----------------------------------------------------------------------------
  /** Build Phase to build and configure sub-components */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  //----------------------------------------------------------------------------
  /** Extract Phase to close out the XML file if it is open */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void extract();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Return a reference to a backdoor API for the memory core in this sequencer.
   */
  extern virtual function svt_mem_backdoor get_backdoor();

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Return a reference to svt_mem_core.
   * 
   * IMPORTANT: This class is intended for internal use and should not be used
   *            by VIP users.
   */
  extern virtual function svt_mem_core m_get_core();
/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Reconfigure sequencer's memory instance with the new memory configuration object.
   * @param cfg - configuration object
   */
  extern virtual function void reconfigure(svt_configuration cfg);

endclass

//svt_vcs_lic_vip_protect
`protected
:T@JfI8^VN@X6)a<YA@0[U&dCa5b\9ePA)I/\]([L@:.I^b1VV3@2(91f;RHTB?J
QB^,R;CXU\V/8R],W@?SETTVZ9UIS.B/@&SDMERWO>=B7Z5=2/+M>_1>P3OEC58?
?[I=^>b1I_GD<f;Z5>@B)191d.XN7N4Ya0FKPYb&FH&S:AW9Z4AHT>(<Q@:-U>cE
c)#2)LLOeUB)5,QZBAb&9/H<:&5HD>/b2afS7ET-8#3WXO4INLf949;3D@P+FKQ]
e++NV]gDfSY.N,_WR&]?Q?\MLaLC-?>5?8[YXGaPND?&T7A-VH4b-W^\)fFP@WbL
JYe^-HW&#)b]:_RT^UQ2P8XWJ3FFZC#(be29_BV#78F7<6G8BQWJHRB\Pad((dbJ
Y=af7M]/R<B:HV6GZB.PX7GTT45=V@e7HIT:CG#X]aOL]Y-/CL5aK,H9E7H]P;dW
2#Ed@UaF>D7IC_\&DO<f5IX>(4gOe:\T\.,+gg_QRM^_b7#<<JY>I0=G/=>f0VX8
O-G0E9;4C0)@3(TLMce3]&=(:_Ge3>N5SNOI\EF?\ZCZJbD8>Z+TX7]]?I/1Q#P(
L[(2M8W<QZdB9\OLT&ML4Y_+O;5IA=Q(I-KV0bPCdD2b8MU@T9K.Bc/.[.AK/7&#
-PP9.E]e(.#C/.LLf\4>O7MNY#3RQ(KH6-<ARMbS0@,F795RDIGSLQ2C]ZP5g;L?
J+(D5[BcMT.>B<+2(bRMG\7+D@-C5V&Ke[LVX]g)@V/;d@YPO]]C,QUL:]?,?<b+
aD?7=KSK3==a]+E6^Y9F4A/g-(8Oe(2?LcEEd/H]R<.Ha064d:PcUcU^4QL&(&2\
c/D7=#:U[(EH[Xa/]<5[I4c-T0<CAb,]cGZ4WD,/X,4=013+@03Y(1aL72R8>X8;
OcE#cS#fMaVgfWLeQ&MT6BJ4Gg6XG4I2c8(4g_@:OCc9&+SK.3RWKV;/dcPZZ\f1
I_XMMaE98M_;-;4YZ0FG4^_fLbZ_+L8XI#-3>e^:Hb;56]RM&,FeCKbMARKS5RZ&
[@Mc&gEOJ>@(=7A#)bP6((T>IP@Rg]DW,##X[NSXM6OY/0c8JX^G[@>H?J5QS-.(
8/9YT[97&9f,0ZD63La^JfKSJM.8V^CZdNH-]H+=VIg/PIWO#Ze8>V3=G6c#Ie?]
CQ9S)TU?ZG^>Y(#?LM_F6.2b5P<2DNfV=Q7?=/28L_WN(U#adY,E=e(V,R.:=g_#
I?aY7KUMC#2F_UcG)/6Y<-5e3Q\_+_aOP-<8ZcD3;MEDbN0#DW#3;3V)bJ6EK\>?
BCJY0)LILMWfZE@#6Q4c84NfcPVD_<AOb@&87WIf+ARWEOMI^;9;E^dbfHBd&/T=
J8:@G<b-T<X5\;Q^#VU@8/A9.f7<cGe<A6>);JN-UcURb1DPHS__>II2,^FTW;+\
#?LdbI8[(MT;[_F+:6V;4:?+aL&+aB>WP\36;,7;M::X\X3A&f9;S(RF7,M>9Q)T
-K1aZES]^b+@07SS^6T>HVe]d2ZWJa7N3W9_DdPK8R1bLRD#>V#9BRd#+aGAF,]]
Yed@^E1d6#J76L7W6D<V#BH^XZ03V0_R,Od25d,]g6/[=,J.08((HSFQ1_@)Y\XD
K)>G&Y\/Q?YNLP_DDQbX6C-N\++-<Z7@U@Uf;R)#Q+Z\BIP]@EQ81Kg#1.=.YI,?
YERB7S56debX@R6EEZ7.H.?P@?UZ>Jd51/^N2BCKQMVYCOY_fY[6-:R;MeV\aTQ#
]MLW=,U)a=H4>a4[3GKD_A9+(M4Q,Y4F@&ZKQd@DYR1CLM]6UIf,c[R.D[<;^V38
Pa5C;]@QKMUfAV0HP]IZGF-R=1X@=V_Z&.ZK=]U.#g2Q-ZU]Da@C>),LTMDR0f/F
5F74#S(Jd4BWVJH23CG4-.(3/U0[878_d.5S^[#.e]^R&)@9+IK?NMF4BdG=93NR
_b^2I_42)(FQP^9FL;8,52Z[8;8[8?]JC3,Yd;dX+N70H5A=7\YLB3V\(bfDB,V?
0IV9AY(f45Pdc183I#g^=g#4T9I&@fd#?IH[H1SB.>/8/887;2Y4gD]eLXTZ=((L
=D4TdZfR;JM<Q#4_QF5/>?]<K)dN.4<ST==HIZ4^Y)N:a4#C-)5WDW^OTU^>Z\_4
J/M@a+P2>f2^H:J(<[P2Wd=S)\L^O-7dKDD4:E69V[S_.3CAdU7e/A;P0e>ag6Z(
)a\f1PZC7+Qb064VRU.>?V3JK>(;9g_<.g2aBZbY;-a?f@.0ZEH;2Ee8;7,1>Zg?
9_5?7ETZSS1PRUUIC]M;Rda4(YK1/SW<7T?EB9)D&4/>OLg?>bO;<BYWgX83Yagg
=dXX0Y8\Jb6/HCX4F(](Ed4))-.Ya<:;P3^\9(-M11LXUTP28_g@E)Agf;\Y26fX
OG6b+(-d_CNLHV0DI)C8Y9<C(W[ZM,d]G/OIf)?E-FgG8a9f]Z-CVN+?#(J>RLA\
U[ge))PZ^:NF29(7N667&F>4g2N\QD[CTTbY(&G3C-0+:-.b:+V(+,cWN4B>B[N>
)I.DLZ5cSDTGY/F>OLM9;GV9E^/X7P69&E(\A7=65\&,L.2e+\@BW.@+&;d)U5Ae
3GP#?^=-4;1DN;]4I4GD8A42Le>]=O]H&^=CgGR4DP_0:\EQ07dGM/;\TE5>;V_.
5REB[XM=IC,E-4-U&?F-70eg1g[^E6O5,dOc)7(&&aF^1VYGJGUdM=Zd.FY,K\0N
U7\2]#4R+C:O8BbTJF)WTR>-@A5gWI;+Z(00?:_2Z#B76>Y1)Z37#F@=(_b+\F7+
WAS=+P9#8\g7N(a.PG3I8>W6E4&aO#8D^McJ:b607W[ag4,gaG3X&=Y;JHW_[LU9
MM19LYGJgG1KN=+/6.S69_X+.=c\PbT^Z#U6;fR_)8D7-^E98E6R5,B@-WF5UM/e
A@:N#;_XT8^PdG06dFW7PeC&@C&)6QG)K);S-MLGNM6F1LY7W[L&FL/Za(W;PJJE
dY?V8GN)9AHU=9bU+A(XW,:W-\VeF:f^_CE44</-BW5]2faMX_KcXXNe]T;cB_&^
=Ee08+MCX=5?Dd/><O2gO2a8?QWBUf14N0A&L\\5ZS6>CaH,,)L:Ng864R7FdIXV
^\O7@M5\O=69@N+:C5B.;:e+Ug52TcH7X[JG2ABQ&,BLC6V[UWIX;(9+4.20FMK2
VJDZF8_.5FZ#K@XD](<YRY6;<]17&-6f_I_IZ:VFV,b61-+5L&O>T-YAV.Sg&W+B
[E@WU?AN=X/Z^f-KQ[IgGIDBe+8Y_S44FIBK9U#0<dU&^+0(,\71]0L,--Ma6(GA
=ASeE)e;I_.fX=K[1KF0V[WP2BFAOPY4-_cA?70R-V0(4Gcb@BM>DSB#J^Y[-^dM
F?0GPB51c9(eHI:g,)Zda^\+:A.XdOG(O5,P>J]Y..a&O,@8-H6H:XHW.6VEQ,-g
_795KB@FeaMFLNEB\^#327)(F^)PHe4_b,C1R?66A^9+gC9R?25V+LYBZSQP8D-=
,2TW;1P_VUS]6gCK](+c4FVKf6)S3W)F@d]H&P#e2.&HPSO/O)OQA+ADDP79:7YM
=_5BP#ZL^B?M^Y.?92b^0OFD#]]dY9,F&+V9.7(Hfa.=D:[+f&9F^-UO#OWU6FOG
XI-c_:FL<[?UO7,5LN9]J=&gF=CG-.JHJJPJZ>CZ3]4T<O[?>D[.L@f?ZgC1@S5^
E3735OPQ@W_2Y][eD7\QP\_c\HA;<DH:19K^I]:fQ/U(70MgK8-^GC0U,QM\^G63
#.E5BYA]:N5D\][,OgM&7AQSDKgdf9TV;VcfZ0O:_>&Q@C+8ES3RFXb37b9U,&_?
;^QRDDZUfD/K?VF:7Re5Ja0)gg[6I6YgR[[]7^U\.46WCAK-bTd/FX2AT+>Y^@W<
PC)Q]U()6XV:0-@IEb\3]JD0;/7K<R?D_.c+A]^WNX-59-^C&bcV#H(UL)K+RU4:
RV.?28@5XLC7(14ZN]?ZAIKd;[76:.8-1XM6I3bC(EQ/_eB]PcJ]TTPE8&Gf_1b\
D\B556^V#T/b/Le;VI,07K3:fD:<N#[H);1g1:##]&N-06UF\:>f@MHJ0#?:QH&f
BH&Df:^1&Q-0)10T@HQe^KFBMWd;HUL9@TcJP&+GdEF([aFN\BI[:Cb#8+G)G<G7
C-MCCMB:KNWW5aXA5C<GEN?Rc7-C[[A<_Q:)=Re8aWO[AO,5&0YJ]7e]+Vc?-eU<
^3NNL4cCb3@XgF[#5C87NOMLFP\fM(Z]]/75JfF#;\MXMAD:]2^41\=8VYJTJeG6
&EIfE3KT5HO7H9XJd_/]9?Zg7P\J[<\H,IcI3gEJcU\PUP7=#(:f&d;6P<@9/]:2
54F:MLXFT+b7+0?_//L=QZ5(bZ[ca5RMLePHYg7IZBGCbAP6P3gfIX(RF.93<Lc(
S\BM<>fEH<,IcBNf64HPBALJbPH:VF,6IN.d3&YOc;ecf?QfY]fEM\)JbD&L,600
:6R^bK&G8LF=0L^#G8>/YW#NaJD7KK@2^;BVG5C\.K,N5gHV4N\:4dbA_O3_f=gT
Y=e[f><HAH+PW@T@X.0.4E5WK(21#Z2bJ2;S))J5_4C7-ed+<3@?C[F9\>)/]A@A
\QM+RG-4Q09LM;VeH^06D99?/UXb=0gJ79Ne=JgQI,(OGfFD=A+WYO;@18QRFMeW
?V#;bEO:fIaZ2\(KL=UaU+Y@U-c@99K07)W>&93d\M8eZ5]NWD^MBU<VF0TAf]QD
0_&ON@>(V#1;]MY)9:U0[3U.H44)@SZgPDR#7)?(eMA/>A_VDNgA85WHc@Bg49Jd
Q\(PXOHX)/TV;,X9)]db9[E1fcJCDJ^N17+c/SEG_5;=Tf01Z\fBMMZeWQRV9RV>
,Sg?dV3X_SG641#0ddaXOUg.@J7EA-DC?+;Md)7JG8(A<(3J#3-_<BO<LDR#Rc?Q
>R;g<W5MGJ1[?EKZ]QPg+M(fKBD>4UV,?fC4[U<D2(JTG7N^/dPV=COHFG<,C<@M
5R9[U_3G0M.^=3Z^AGDW+V^O1T>/ND@W)[=S9]FNdHFDS=E5GL,D1NH49[S3+@Ue
CG=9#V)-PW:LVCa5A9aR10=Zc.H?Xa.)/f;(S?ORE[@)]McFIM>..8@(SKNdZ\C5
e/=/22XIQBZ0?IC5c8407#(Pda/>DQ,[HY\b\L7D.1,<7ZGg(b?MYXd>T]-J\+-d
d]dMJ)F95cSMA2&HV3OXPMdJ2c4P(XgL/;S-UGR;R#U(I@NK]O::X;+JO1?^8ZK6
cT:KOY<^F0,B;9ZJH:+#10UNa,(cUfL/7C]UP0((4gLH8B1BccJ<465&XaT2=MKC
^I?RF.-(C\GBc^5bO2&dPQ[F>Nf/04aMK/cUD\JMMH6FR89U)B:6OK(:?W2N3[a-
5aP.A_6PC=R?D25MN7@=D?4^2QUU[D#KOHYWec59JC:/AD2-[.DbHEJ6^=A=RI=IT$
`endprotected


`endif // GUARD_SVT_MEM_SEQUENCER_SV

