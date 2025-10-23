
`ifndef GUARD_SVT_SPI_AGENT_SV
`define GUARD_SVT_SPI_AGENT_SV

// =============================================================================
/**
 * This class defines the SPI Agent class. It has drivers, monitors, and
 * sequencers implementing the complete SPI stack.
 */
class svt_spi_agent extends svt_agent;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** SPI virtual sequencer */
  svt_spi_virtual_sequencer virt_seqr;

  /** 
   * Shared status object used to convey events and states between components.
   *
   * NOTE: This object is to be treated as read-only for any accesses from outside the svt_spi_agent.
   * Writing/modifying any of the attributes may lead to unexpected results from the VIP.
   */
  svt_spi_status shared_status;

  /* 
   * Reference to the system wide sequence item report. 
   */
  svt_sequence_item_report sys_seq_item_report;

  //-----------------------------------------------------------
  // Instantiation of the SPI Stack
  //-----------------------------------------------------------
  /**
   * TxRx - Driver 
   * @groupname txrx_agent_parameter 
   */
  svt_spi_txrx txrx;

  /**
   * TxRx - Monitor
   * @groupname txrx_agent_parameter 
   */
  svt_spi_txrx_monitor txrx_mon;

  /**
   * SPI TxRx Target sequencer
   * @groupname txrx_agent_parameter 
   */
  svt_spi_transaction_sequencer transaction_seqr;

  /**
   * SPI TxRx Target sequencer
   * @groupname txrx_agent_parameter 
   */
  svt_spi_service_sequencer service_seqr;

  /** MEM Sequencer */
  svt_spi_mem_sequencer mem_sequencer;

  /**
   * SPI TxRx Monitor Coverage Callback
   * @groupname txrx_agent_parameter 
   */
  svt_spi_txrx_monitor_def_cov_callback txrx_cov_cb;

  /**
   * SPI TxRx Monitor XML Callback
   * @groupname txrx_agent_parameter 
   */
  svt_spi_txrx_monitor_xml_callback txrx_xml_gen_cb;

  /**
   * SPI TxRx Monitor Report Callback
   * @groupname txrx_agent_parameter 
   */
  svt_spi_txrx_monitor_transaction_report_callback txrx_xact_report_cb;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_agent_configuration cfg_snapshot;

  /** 
   * Writer used to generate XML output for transactions.
   */
  protected svt_xml_writer xml_writer = null;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** SPI Agent configuration handle */
  local svt_spi_agent_configuration cfg;

  // ****************************************************************************
  // Component Utilities
  // ****************************************************************************

  `svt_xvm_component_utils(svt_spi_agent)

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
  extern function new(string name = "svt_spi_agent", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // -----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif

  //----------------------------------------------------------------------------
  /** Connect Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  //----------------------------------------------------------------------------
  /** Extract Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void extract();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for the components.
   *
   * @param cfg Handle of svt_configuration class
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** Method used to set the agent's system sequence item report object. */
  extern virtual function void set_sys_seq_item_report(svt_sequence_item_report sys_seq_item_report);

`protected
5cASL647<Jdg+We&KbB2ZJHDgYZX)7c7Tca]H,eCV?#Wf3PYg\2[/),?5^eY>gH9
O>b:<5=SQ4LQ>[EN1>^dd=]Md>2J[L_g2@0/XCg,1[>/XcX>_PPZb_58)XfD?WMV
?TdNIW3[>RCgG1^-M9W/??cZJ&,XVQH3)/[&<B2?R^D6S:N6DOF@<QQeXWN>MAb<
1\Lg?>&^U9L;]_P>P_]?O]R5F8/bXPY+IfV=fX1E58R9_e;9TL4EI1Y)A[E>B:/>
1YNC0O/1]YO[0N?dc&GUPZf:71,K;S?PI^;LWL<LXU=O9aggdX:&9#d&]JYcLOeN
KKb,gK))B(fCPJTU9VLE@T>2cYYC/P.MGU\X6<AS7IA&9W60eH5:I9J4O&CO1IZO
TL1@RDO,OZR#bUO_+O6:DIRN=<QgE+2TbNQ8ASQO/H[YOeaOed+PG/7HRgUA;))W
4-O/<W>]X\Q](TaE?U)D=BM&NG,:<0JfOgN;]4aW=LTIJK8)SQ/5;W:<Z6;4>R7]
_>;gG[2;<f(9;6F=bf7>WPNgW8.,_L>#0;Ob2^J<HT@&[(3OC-EIFF;X3SNg:;,I
W]a.0]>V3(?]H#+ggK;9eBfC0&92g\NN?\.[3b(9L>Wb2??EA2f4bcOBWXMdOEDQ
#.;BX^ZAJ_gBKaUC.ZcBgNKWLb7R<0Pff24M#JUQ?6F(W;(7d(e?I1HaP,]R3-US
^XTGOD+eGUKdQ0e>)Y78DWMCO?ed,.L([61<ND)&[e<\P[W;Ke+R\7[EN6DIcN7H
3]OC^S5OGWX@>AM+a)J2]Cd&A#[@/S77I5:f6IW/M9^Td?/2Uc.MC;FCC5C?c,C7
-@LTe7C]&W)OfaN36XOVL=G@)T7ERQ:&;C-FI++MS_N_8g]::?R(W&E/=I.L]?M\
C_>2)6&aTb2XKR&OdIP\A^HD@E/CD3N6CLL5^6UFd2?/9Q62>0ATL=K^;Le5;g/5
Q[ZP)[6AEZV:(,cH>5<3NT6\4;[,U(cgQYc6f?49gHU2cM#ZN.U<=T=KOLFUSTf:
cRL&GV/0A,RT=d4gQM-4H#c+:;&f?N#,b^YT/0KXSeS9;]WIM;UF-D<=PGV7N0M1
_;:^.UcLGR4?LCLIB0<DbeaC7E//c[:eAVVS-7IeO+4gQ_(;,fa;EJG&6XN^_P)QQ$
`endprotected


  // ---------------------------------------------------------------------------
  /**
   * This routine triggers ECC calculation for blocks from ecc_protected_start_block_id 
   * to ecc_protected_last_block_id in specificed configuration class & also 
   * Program Bad Block mark in Spare region for all Blocks in selected device
   * This routine must be called after agent's reconfigure() to update the
   * mem_core data base as per the latest selected reconfigured values.
   */ 
  extern task initialize_mem_with_ecc_and_bad_block_mark(svt_configuration cfg, bit do_program_bad_block_mark=1);
 
  // ---------------------------------------------------------------------------
  /**
   * This routine triggers Tampering of Pre Programmed Memory Data with its data.
   * This routine must be called after agent's reconfigure() to update the
   * mem_core data base as per the latest selected reconfigured values.
   */ 
  extern task tamper_pre_program_memory_data(ref bit [7:0] tamper_data[]);

 /** @endcond */

endclass

// =============================================================================

`protected
c]W:?#&Af-;_S5G[JP^161LaaAA8Z[5;f3)9Md)YF5Sgda^+_9YJ7)3DV#Z:=)c^
Aa2e1AHT/&-8I/)C<C;EJ_.ZgUBT4[90BDG\e0gX1TYQ+DOU2b5[I))a=?P10g/J
+H:T3MN0KULO:9&PIZ9=E]FT;(\3TQBKb=RVP:]eD[fTaU1e2;69dG#9L@VgO=A3
^U^gEYURd[5a_bV#cY&+8Ve)/RE>G7d7J9XHCODU#Z^QGT3.GCIGfG]5SbLEb/\F
_72+P#Db)K_KC#TJI/A#>>,V-FW[_>(e8N[2_Me>AP-6JQCRK=9bfa]5P$
`endprotected


//vcs_lic_vip_protect
`protected
^2=^KS1?S:VE\U7F;FC#MHSFF+#DS(dN]D\A;W];=L-MDPI_10+g1(f9Q1DT3&c>
I5V^DHCW@(F#-1[^.c&>7NR/9_&bf9E9aLM/=52>])A9[E@gc-?La[M>=HLHKRJR
/J8NS_e,X4RYe[/1D3D>\eHYS4Z7T9WP&;OPK1I.Gg^S8)G&_fNS9aKd.KID](CZ
Sa#8=4VfQRH>NZIfY@5\G^+5bf0C&E&8Nc,[09(@C4IL#0:Lf,]AVbfG[J=[U(ID
fE6_1&7aFZB&.gU^G4CW)Q56RM&TXOM@P/J^=eJdgP:?I,b_48[#^[T5@_^3S@bb
LGFL#05CQ5\XG8GaDD]d-15?GN/eR@;\+CV511M6I<LL?+Z)g=1TGDE4e\U,NGFI
-#\Q]GdbaC8NT5<?+E^eIbSdRHb^C1c</&Qf+I3EWSaGVY1_5Oa<^.(H6UEdW3>F
3[,9()3Y,b^f>0cg_XCSaZ3V+4<FRa41,<I&g7G1K_].;-0\BccGY._eB3U5@[W;
)E&e\<]MM8Y7JDIAg6bIFB#=&9V^SA0Xe83;34,QJF(9TW:\D?9^H/2_3]6e^Q(<
TM?,^g]Q[BgV3_aNK_<T=;b]A<C;aZT5+9[TF7A&--d9CaG9If2ZL:OfQQ)8IGO4
-R#95_a</3f)fT3K&]#^L1gJR3Y:FKaY)-C8;2SQ+\JQRSeY_@6ZUT=c^Vcb.0=2
#NL@5@a.[2U.ZA^CKY.MK9>DX0//cZBG-SK;FT)2/4C3GE(6[1X;]BeJOZLQ0>\4
MbeE&4LS#0A6PXIIW->O9V?IQe0\G)TIVW<gV>ZC)1Jc(,T]TROB=6Y@=/UJ-W12
LbURTNf/8R9g]@bDafCM^/<X((7VcVDZga]6)(&I^I^V-dfE@4Y7LO-Q6G/4g#M+
[D:YC5;M(HVX4LS]X4.d32BK[<3+=e5aJ7.X#4?5=++g&M]H\.R>UU<fA>9J^4AT
YgU=AT)eD&?L&C2FI/,&3@c@dJVT)E:8#fN;TA#1#:(H/1=Y@=5G\=1c)6fZSZ0-
^M#2<8D;^Z1b<7.J7-G5e/X:g:8;3,Q/]f2[#e\Y(V=VL113TVbcS^C,^>2>4=D^
KBGGX=FaVbHHacBP5GL0JSLCRKR1IKA9Se3bYdNZI..@b=aNG?F,[Q9Dge+:c2I)
CAG//(^8C1f@AeSUH90<8g>]cO;DaMc?EG>M[OQ33(@=L(/,@;/A?IKZ#PA7\2[<
\GD[gA&/a+#9E<#N_g3VfS7A=:YOHRdC<GIG0U4dVDH2W0)2U2FFd?F/:[LM8.:D
HIL.U4=]cSaGg+=bHcBI3YGTNc7[72)B/4Q-92\=G93[2Cb_G>#OY5d9e(e]1\,g
-?D:P)LW.BY?]X/FKI63OX?MPKf7ePgIQ=bg6I.WED.45\3A(G(H8[5bZ7MSM>Ab
V9cBJMU:?KN=(H;)bM+>_\\7ZSJBbG5<NEQcZ&?R,:-AVY]0ZUP7;/-H4?3DZ-7d
HT(b4J.f=f1@[=G_#T::[#V8BJcPO7+c]b_g>O/MCICZUHY;Kg<?^c4SAW@.EI<c
0TB1PA,DY=HQGY2V@X\T8CG3O0a/<K98WT-WS:O^.C(=L)67H5_d8YU5L.g<De2&
7P](.BSEbV=6?bG)P33_[E31+>NEVe@S^AU8PKS#JRT=R5SVY23eWE0,,18P)3NM
NS_GO7-UILW5RN^V[=)E,>&M>Wf=&90>=FSIc-900db9NU9;_SQQcPdN<gT]:=C&
M^Fc+Uf3#@8c&6R2QP<]OCD9R#(W&N_.T?8CBYA+Jd[T#R(#KTI+-eR0Z931,-@a
;D6WU^=P:A6_HKJaP@3+0+907Qe2[/_VAWF?-SHY3N]6KYfMK=R,PO(9c(LcEGI,
(.]TL2WO)K2WNT(:cY>\KgF&\-e#WTb/@b+^5=MBPFTc#Q5/MX31WB<]XM_K@I>S
&9:D/PU?[NR0/4)[#FE>AdMP,7Cd;G6)SV=/T665FB)a7R^UAMeIB5#]d)MG\(U+
@bLY>+=([Gd3Of<59b2/ZG&Bb)Z#]a1g9,KT_<14@P;+8b&)(DZDJ:WYJ^^F^Q^S
L^[bG[+2(3GTN1AGAOX:Q_aK@R-2(NJRb98R@]XQY1-)=&4f,^QG;NJ0&>TQ)2MN
1-/GW-dbE)Y[-.XEefRG;9FL[ZLf0]/W?^NBYZI\+WZ57XeL?1)B4GGDYP1=F1@0
9)d@ZHfQA8aY#.P9KAN2&\H.UI[4b@;<([LaU\MITHAG&VgY@B71W[7Y+(&+<a0V
V<1.RSd3<KD-N6;<Q#e7M0>>a;CB/_FS_7#I-c=YP_/1bb@&b+0L+2YU)-A^T)[K
gDe1Q36I\bb3.Y3@1M82b,cRfHM?V,fN_N)A<c[Vc=+\BQUAR_eEE7DN4DJYd>GG
U@P^5>\E:/aTZ[Ce5UX#/T.V>D)J-/>KU1/LH&?TU7Y6b8c)RK]0Cg3\aFaQ.#9A
M;951><De<a,0S481gb__[D^1\OT7>+AU?1Gb26AJ<-f\@fgcU?ZVJQ_[]b0JEHS
<gQbOUM]VOY6]bP8^DI9YeXR&R_L3TBIS^5M+LL_AgC=c(X34>OT>8(.-5:M75&e
<BV?8f#,K9bKB?95cB>^0&;EEb4^aXG@V-67^XXIXXPXP/7Q<9WHZ+>-Q,>N@,H8
PJ=\>Ab^KdT/bNU:DU(W6C6b53]G;5@cW>@PVFeVQFDY3:4bQ4Q:7UW,/fSa&5KM
/e1b_eP?cU(_:c9EEZNd1P_@9NOLA>-SZ&cP1eCVade)a<J/:W5CKE#AO+M>5_..
YDIQWY:LA;K\^9@S16fEBIe;Lc.OWQFMP(.\E?WJ>GVfQZUQ+QDcJLCM+1?\W4cI
.&,Q]g4BGY)+M^f^+c1b()cCRE3Z]<2O5&YgLbL2XJ;#6Lg/:V;:P&O\WYW3+):4
VUF:YRGB-N2Jd/^D]7PXKX@WT]YK0:K6XMEH?IRf8UVJ[<bbaSCOd14R-Ac_T>Se
\BAAUd,\A,9E-BFTV6UE?e&CVBD3_NRZ?X_dVSN@?2B#JH-YUV:;712#52X+[=Y4
?fNSQWD1#Vf63D^2.<6EM&:PNTFV@/WYT10PXBN>X/bfY_?6@+M.&4G=#aZ=.)(8
df_aQ?&]9AJ(RaL9K_6+HTRcGRQL+XJ#]WYg2MW6fNX53\\1e&2C2E68FPIU#DgN
:EY7WXa2V\;_+]KRT-Zd_c4ag5FedS7^?XXO\P--PP0603_]@MWX0XMV&H(Pa)\N
QOcJ6Q,Ve1:IPN8GX7-ACQ6O-ZG)[-+X;HT;\I@+UIg/E(6&4GC64__[:5,?-#-^
O_cPY1Nd]NJ#D<bIccHU[4&7N6EUPcDf2X2302ROS1E<Ob@QgLV>S9]#NAEB)g/[
eJO6F#3JMB>,GCEVea=_2fW#U^45=(aBO0U0<ZHR2)6&a=^-&1:gdKIGDRGaW#I>
(e>TG@3<Pf>G_b&bE>\@:-cbCQK8[gFa0c5_YP9Ob_73;=@:JT[\DBRbVIKP9_Xf
YMd^E4W)JDO\SJGF.5=9GKPS4&XZ+&ER5&,e=I-<,9g=\1=M0#1>?OgLG^DBQJ[)
N)B__;>(S?e0RLR(3GZFQ_?8L]QE[cZGfX6^IPRbH]8NLSZ:=NL]3HQ^Q2-R?S)b
R[)ZC\E@S<Q/NJZGV#^P+?@[bGN6M@A(7D4B]=8J;WC?CP27<U?bFPB]N)OB.b/A
L64L\5F=3bHK0=a&Y?3L4,H=S,48VIRK8?0BE7L:FM.X9Ge.f[8CXN4B0>3+1af+
b6^\d5G_^B9LH,+SbDE:7AT2[IfaF1-436>a82DBIH0b.ZKTX@T5TNH)_2OCZFYM
\O-LT@AC4C.Z>58c7>-/F/Xe;gO(RQb\DVC36aZ\/]D-_);<@d0^1ZKgCJA#A^WU
TAf.+@TR49C5AYfM\dD,-GH9ZMR.+7IZ[Z<DO?1Tg)90TdIXG9R?Q9OZ>HMJD+8>
UDY?IVI&WUg6DY3&M1[GfLW1R]OU+]geRD#e2V#eb+f5Q[1A,D)2EHAV)T1&X9NF
Zd3&V<B&]c^5\>GC]H<6+C]986LKTVTV1,YD+P0@6ZI_PBd;QOJbe[1>D/1)ANg3
C[Y:Sf@K_4E]J3X&@eWE2D?#[W&TTbXLCNWI5bX>>6^MF6-)6=2[FYL]PDQ:H.=G
SH\MZd99Q3>V3MD=^K=]/4Z\]@J>-G1AY]8;EB/-51D&26)PO)W,O[0</6<69?I6
bGg3LbW=Yg(g-c6Gg6HU/?Y+N3B/O&g&VE--7O1K;;ZE:&8OFJ+a60;gLd^f]#f_
,@HM789BFYDZ;?<EbeCP;ZP8;7eTO=ECSPY?BXW/=ODB3;E626W]ESIF:+gb:/;:
Hb(\@bR888J4aXb9.TZaX3d+g#U_^+A359GfP)a(\OdHP]g]\D^P4c])/4/>7F4K
=YdV.JQ8+@_DB0aIff+=&^.1^)35M1\aU\EPd]1@L;BgE6,4S-a;+:G.-S(/G]4V
XND1\DG2]a^OfXV&MGK,LV^[857Y.1BXC#6MM6P+RV5MQ\^U/F7BfZPI:+1AJ@?^
_5HG3#f\7^:MO]41>/X/XJK;,6Q,31b:IJaL&3J9UdBA&Gc/\b+LWF)EN1:91VFA
,_5)NKD.]eI/C>RRL1[A>MGg85(B?9CaC+<65)6EDVgCYD:bUJBbJ\G(?HHZ9^M4
6.<2=P<W58L._]?S;fA#V\b43,X6.T)>-[Hg8+@ERdV&fZe=T,<>Yc=9&LQY>GU9
+aaGNf+_bf#L3TNO-UTcF6TfKD2)1:\g(SH(fb@LK&Zc@P<H\QN8H2[=BZV#5A-I
AE7-6IX/9Z:f;,=2TbC)>c:g+/&T74?^d/7<>W84[e&[(N1/ecUHD=daVY0=8IbH
LUP(@>:;7ZM?bAJOAeHF0/5gNK/P4XNQT0MZ15Q.G/YY=SI&M6QHJVNW1)N#6\_H
-?1=TYQ#d55Ra1Z@A?c3)E8GHMU)=&)M2K:CYb&66OL7AK[X6U<gRQd;1QNQM)U;
3-0@ZY^G]>/\[SWF+4\D,(e3@:<YR<08K-a5B/7C9g[^8NSHd_>Ed3<8.QRb/Z2F
e^5aM_8--0I0f0D=2f#BIVXJeWac>Ma]A8#NKLCOS(#NHWY0dOd&gd\+FB9@:OB[
V#/\OC^3JLJC)_NVJV2fg^H&O[R+64GcRVU&CBEFZGZ-ML+B#=gG(WH#?daSZK^T
9[7@YDWbdAdXERcY\Q]SJLJ30Gc94\&W2O+LIXH67/P(bE_#P5D[SS05<K&SU4Q.
3f#a&T1]137:.3N+&2R8U1\__8J4Oc]-B20Ig-KC=]=H_@R[8ZK2@G_H\SV2;1=S
?V+Ea;I670JJ@660@-X63Y+2fY8@^]WMf\AGPB2P_P?fKgZg+a],Cd[f6E#ac-8\
N:g->A:Z]1Jd#K\IQ3,e@0e3:1b;77?LG4_<:[[;2FXSKMK6c90C[9?dX3;/TSUL
=4TGX=I8&O]Ca8NOS)a>@eeR/+O.SSX#=[TCFI=.W0I;JcT<\d<6M?VXZ7\NOPZG
5c6QC)>)HaD-1?V,GS)O9[X&&93H,IA<K2Z:P2:75cYU)7>c[g^<F&QKZBS,(.RS
9E>3BUbd>Q]10=a-fBB<14f]c3(b2egfU2J/1D5AUD)&ZU0-[YHNG2GEJT^9U6&e
I?&O5?/IME,&DfL0e3^#b&\e)C;MW^+&&:S,IE&ZLKaPdU9A.T?S815-U7P;@-?<
_6R=+62f[4c9ZJ\(a.XZbKI_Cg)KL-BRIK1=\19-S4KHg&d7VGbS06X(P8G4Ngdg
3?A;d>]Z:Rb9?DZZ)VP,69\>cZ7H&<f(UZC4XE)-_T]X9Z(].9=\W&(T:gKB1P@_
(P3RVLRJdDB#B3T64g+g,UY?\0=R;5E?7a,E=a<WM)#fSbX>)17Y5?)=?M==4a-&
Y0/-cZ8Oe)F5cT6.,JOHV>_2G+Z+3M?]eL8c8W?F5T3c9dK_b/,,5]Nfb(7DZ.Te
^7,O-G:;.A1U@)\d1_T//fIB[S10PWH3-e1FZQ.<;<I-34=(ZD;aDg]D&Z<Ue3^K
Z[]A^9(d=)QC_-@B(P=6b@(;^F0VZXcOQ#fK=JX^&6c5=N[QE>E;\X35eT7__Z09
YJ7,[]30#3+Ea]?fgcYNFa-&80R3YOZUU1/DG@78?R6.H1e;WVY00SQf0d/X)8a6
NZO30(I8+BcE0^=FP01X=UHC3g7NbXPVOX/=0H^&GRX@=XM;80.]J@K]4/]L8aUe
OZ=(([9g&8N1\7[)VQ^A85MQ?_fSZHR&J_eFV+fdV4>L:E_AE2b0OOV[IV1SCBT^
4I:4+B&gKPAYS.XIAIE36XD)FJU?>G93IT@YD+e-63XN>(,2MM[DDP/_A/Q3d^.B
e[OG;SdecbA-AAO_\AV=C(KMg/efS1MP&;7I>?TV@d;N,]HR3J3>T_-H#[=C\)3X
46;<HSBS<)S+OfAcM_8gY_I(EZb@f^U24PL-D7D_4/G7F_eOFPN/LLc9)02Vf>a#
@J;I5J_\AJ9G_X)>>CMMG(BJFF:1(APAYB(0T+^,PZKTUM_E1)JR0cT.ZH7].IN?
fT:,>?P#C;GZQgK8:OacMUT+&d9(;8C284+EJ>e.O6\#=L[7:\8_YY&;R^C5:X_+
1a(UXO;F\O4Nd+,<0VUB#R_+Q(G0W5:B<BTagMacR5gb>^/\W_73cPH5VQ&(#DQ+
@0/?5Bb@A?8d2_bO\UC_QK)N];g:FMb6-0K6-2J^C[9-g/?5A_M069(=#f;U=e)^
QVWIM4(^>D5NT2#H6Z+F1RNed?C<\^92BX#?e/MW>C#Z#ELf],ST.(V3P#?Y@4\+
2XK/+ceAfE_LD0@fC(,adX2Z([/?3Z988,&.+,IGd,#@:->/8(V-0WT]U<U@-F1c
B-fC6K5gc.1T6\Ab[&;ZBc18W.;6RET/;P&.I7?034A_2-Vb&S)fW(U3LC09_g]0
d4Ce9_&XY:SZA&J5-1d.eaG&QPMPVOT1b^;B,P5V\90NV>ODaK7c@6KACT/8;075
/cHReQHeK][+8;<a/T=TXK(\IY.KM[X(>/2\B:8QfO#g((Q[G1d8GJ;3e?#T5-9V
Fb66@](6<^5G:.H+[0W;Q5Ea=.aS:9X,0V]R3PYMgU(WaX,g7c]X1Zf@)D,d.=V0
?=@.M2Ag4aF,C6RUAI,E8(T:H)D@8PRL<=(@0c]Z?bOQKW03LS-Y;VI(a:Nb&bG#
\Pg?6HDcN>AUV.?M)8WP(V;3,)eY;a]gf5IK0,HA>fUY;#LH[;K6V\VDQ&Z,R^RV
b_+ESK#&bEW4fN/U_+<b[d.+X+8@Y:19(/1dK9>BIO9bK-P,&J]IY6IQO93XY[1-
);(\e83Ec?7PgZ/MUe7KJ9XCOf<?&,=E0ZTN?2L:/ZE;KPaJ)[=VUb28><(Y/)a<
V05_XWa4ceY#QZdCX>G9\GP3O-OV>B=JccH#bDF)=-BSQZdIe>FV<-L)gPZ&C@D4
=Vg=Z,eB4+0f])J#c_W/&3UX5;@[,dGfAV\P6@SWXCAJTIUT4:T3\^27LR4ZB568
1+I_)a@-EQ^?,[A\,O9.UGVCbDAU?E@D&3cOCa<14d+6EZN5-B5d72eVB0c(E4ZB
g;DNK[R=9:Q=KW)0_eC1&\=c,ePFYg+1E5U(97E)OE4gc#fH9U(=6O6f1=W8>IIB
Y+@e[d-F:4#FO9d;;M3AQBH5N.]<W]PE1091dKH(cO#[\59EaaD0V+67K/f.93T(
[G2+Wa7YXfI[O<O8ff-Jd(;J-57UO[-a778GH7bH+E?13NMBb0c([7BQ0AFf6&84
L7:GXLR6gIb>&9b1K/d.N[g9IG<:XA,+DZg3^[e3)1FKfCdP,]aY._Lb[#?WA6ET
>I=OV&7;6ND#?WbEF[7fJ84>QXI2;7eeA]c,.=85ZV<RH,aRT+<8.DT_OH=(Z(+9
>a,9?:Gb&8T=XZDI92/42?>LRLbe6E4Lg:DB_=)82[;M:\[4B\@NBOMJ-Z2bV6JI
f1[BMK@1)P_>T.G6#1@AMISA)[7730,/B;fAG1X3]1]fJ#13DVV@&LE5bGQ^-Y+/
_^I=&R2GX,YH(:ZLORRC)MUeAPP5S]+KIIg7K@Nb/.Z]3;QX,FLE]9IQX<_\TcbS
-X#_eHZ7I3.]9G=CU8:8SG_+S;L[C_c3&;X=7bK-E1+b_bQP\&+VHaG=N;a_TTRN
_DT9ae#e=@bJJ^V\c:)8C]1&a>\&D4a&=La/VV?21aBY^bMWP<]GYN4OM8ROY0K6
<MbD-V:\KJGCcg_SJf[H=PCb6X^+cdR)57LHV8?6RaX##JI_eTTO\aZ[?e1JPW,2
=FMaHTeFL:#8WX;P\]N2e_I6DcOY=VB1Q)_R(4WdeQN)21=S.QGdZ.AcB&PAP]43
LOgI#2dVW[L0/#\YYLaKe5]Y:8+E[.L?X&:.6=1YQd4J@CK219C3^\H7.&/^XaE,
_+]55R6Mg1:(4=5INWIEO7LGGG=Oa5@/AfM<]\2GV75C>,-6d#]0]+0#U-ff=?d6
O:G-?II.<OSXB\;<OVD6[b==e.JDdYPaM+WQNa0PS9b>Eg(J?H]EQEHYDBTd_g_[
+&b6+E21bZ&JZLYGR[A2>EK4,^#1W+Y],]5#SS0H#F]Q_7CS/bT[M[(=-UgT0L2\
b,ZY.\g83@Z(HddfJ(609D,GFSHWIbdd=D9D,6WQZ6dTb7O5CFMd\>&a5+8H0A(f
8_Sf#(#7)3&_,&?e30,+LMA;)CK06XeOKKKQ#]3QXe.aYbVD],a:)(A^I3]#aZX=
GN5J<K=Y/N>.ZKF,[b3XPR>+NMV1Zd6?Eg,8fVg\eEcDedX>-9E[QQ1@S3<&I&^G
6?SbeQdDB5S6:D(A?DE<XQZH:QeM=38-N@W0OL96[,5R+G+48(WC4>#AYMf9<bYZ
W/VYEG\.6YddgK_@cg9=Ca2JCLCd6&bKgA\=5aJ/M^;-aa@<0N19S+@_CXF[3]A-
3a)RVYa/R7<8Hd>>:I0e\6OfDJK7[(IEc;O][S;W1::M>fAVK<.\WDTf\9UUIIQK
R)1:;Y=6a1MQc622^cbJ;^<_+aOK&GOT5GL>_\1HSV#bWF?\^2GM,=>D<:Z7PV>5
,5EXHNG90YA_C<7NBaIRYV:ggT6A4;X?F9Mg((c,F&,)H3?8bF,RXd^^M0V:K>8H
:adBS17_;LME=#,B&cIfVBWg892J->/MO/63EH-5f<:-KI)d@N:a3@7K/d-.QX#R
?@M.-RVF7dYXC/aAA@5.\KFATTSN\(+g_YeU##U,?/-C4f^K&)]T@88/FNW2FTNJ
ZEWSHNU.3c5,R<SVc@Z<QJcGgP9-=0FO]8a:3P=.86L5f)];g@-E1H=068fHGfOC
S>9fLO7=7(?>K)OC<A+1.b7Ca6_VV6,FBN0X5BXR(N+)<O[>S\BT&>BF#^>>N@07
a1^4gZRISdQMC6[NA7Ya;1YHWc@7@]1]--DIZUZ9#=LB:H,55^YXegTFSUF0f[LO
a@Q0&IXCaD((^3=Z8@c:@\0Y0H.#OF2GK,)B?7Fb#&?dUOJQD#=_,ec&PJQ<J;B<
R7N+[dfe4FQHN23S-gR97AEW&+<93dacROSbQCXD(,^]>L97?HX<E0geOKcR/:HL
1a^<:=P^e#X,JWg=\9U<8=VN/8R5AgTC+eO[d^D+MZTPJFV,eY+2<])P3=Z.J7@f
6CcX#<,)c0_P1JMff#ZA9d;3+5[FQZ\UKQ^:]<+fULK=F0cHXNdKSg:M&+9:aW\)
=OeE:A][)B[/5;5@H7f?()&Z=6g_Ig7DZPVeC:4P:RBF,0-TA?M#cOS5[BS+#Q9A
PVMgX3LeE]=S<1;;-4W##732@JO&ISb@82H151QY#+\B^0SNYZ\d:/SaV@]17D+K
79>7)eH#.P3:W:#7BB05S=#\.]e0-C8039.OJ0_:V;e(6];-<AOKa>J#4M=0IB/\
X?D6B5\GWT^QA##;g0YZF-IK3RR/a+W0G.\C5L>=;X7VF[\C&P)N_BA9/Z+)[<GK
W<fWLR;gN4X@(PVUMDLMI0WUa+FIaI&Pg7KK4Q1^W2?RO>ZWRQWVaM59/9K5T;-T
?L(7@>-62F6&J\T3H-/WLTM<Lc]4E^.]:gZ+(SbU974.Y)(>05_L\<N1=S@0:U;C
=]ge(gBU;97ff.10Wd3)KSXReRD0?>SVdOGCQTWNJX-0cQGWOFdM5:#20f10@T97
^<bPO-A:[0<LXg3#7eRXM<HB8-?=:(3\e-;R,):<]6&6(Jg1@PVQb\2<e@cgVIZ&
D(E-5@>e;IQ=e;_;fRHba\^@64HKC7^MP1>TM\JXaXP6#ZQ8+<5_e,V[UFZ5GW@O
[:+[E^EZOUaI);f9V=X;2]]N_g(8DdL,MBC;X62J;OJ2GW04W>\DCDXb]@O53.g9
9,<O5g+)+\\:)#;4)LOdD@D^#Y7NM(CHTa,6RMO=B<170>6PVa\e9:.2QSLY211c
X+eH\QeFZ,A(+OUHN8[FSa\+ReAZFgPc.:#aG38LF9c7fD&TA@&9+a0M7=DfD1F<
Jc>A#JV,<U?Q/(XeZ)fX)d2H^V(SND=d;]OQ+-M59T?53N9/N5LD(gKQI8fJ)#\C
/@E:R(?-Z;I[.N_db.7VBdW[AJSfP2IVUf)X\fb7Z#ST,)g7e\(eK553fB?6M)fT
D5dNU?^J)^]#L?3-]VXTF;L5D=Fb=9>P=BN,XHdSM;3]9N/+#R[HWD,?a?GH0MUK
O?#DV5:gL/R;VEbW#WO^b]KJ@cNb2XVabC?6P-g.&],1K##4EfT_AFUS[FZT+V7M
.GB+07XO)a_Y>-3?dc+7S.N8V6]9+D[:7CX@>\F;feJ1VM#)6EPc([S.1Tg52L->
73ZE5F<eAeG<LJ-MbY<CN[bX13QNE^,K#@DZ50:R,ZTNG@4+/P8d^86cFTeMS(7d
@Q4NM\>WJM;N1=#ZecB:XDEIGYKA0CEV.J]cG?:R&9WKDP9N-HHE.WBbAG;+/cNZ
<9><G0WHD3e>Q\;[.0._)<1\,14bdE&[a@1X+D/,/2Lc@#+2:(N4?6gbCF@:D[03
_6?1AT[#/=QM2PV04-[XT>;QOIGK@ZMCG_8Eee-R3Ha/=RG6\aG?]>[LFg?RSHb=
P1AXTT.4P(^ScP^3(L[X\gP1#S13KA05T#FM):&-c1@5@fL9C@5H8K1e/)D5Z)c#
c<4IYUX-]:ESNBBLRK79g,3<7X;IRb()RMQE?,JO,4X-#55AXO[#gR]N3A-[6(R8
;2:(8+A;6S()=5#2NF>=)bdQTU:HS#163Mg\[34c#1?Ef=YZ[QBF+T[US^):P[XB
]<:KRO3+YR7./B:.2Q3MKgd0H/)SdKPMIMR,.E](K8=H<6SB9#3efN.XR^]FU#1B
J_=-^/Q1e20NMM?XcJYZCc2Ac[g2cOI?6:CW]^R8@9](c0.^:2G+FeD5;Mf[TP],
ce92R8B>F2KXI?5[4-/+X2ZTS/25>809LffMaVePE1D6?;_.;6+0VNNQD-,LQ00^
@M>X,YK.d64^\[O+PYAA67>Z0^5X(e0[ce?U<#g@(2-EL)?]E3<>8#cb)YOFX5U<
g^LH+(V6T>2b5.,d_9.F.AGIB&cCGT>TB/=-EMHN@12V-H6UVR0-[QTUX,0EE^I]
Sc8<X^a.Y^A]57QWX=[NUT\8Dd.JV<NXOeV/[73fPD@B]HXeO(-[g:U>Z?9/(S#4
50V5:dHL/\=\L1?=L9&#8+Vc3XOFPRA2=IFE_KJf1)DU:b>AM/A>3:=]bc@[BKL8
,V4T^PIL2XTT2cbf3NG9L4Y_]8/J/#?P7X2M&1J?.>PZ-SLPU;&IeAKY.6AY7a&5
5b7^eJ1aP8GWFJb<59ITP1:dfWM/G_-Lg#6?6dMF2C0RJQQ^4&E[._#&V&=U\=^)
T_-FI]>W.d?a]+B1@e2@3H-9KO5Ob?OB\0\aK6^c+BD(C:CUHQ2\e,].@bN,TZJ&
^0?WPe8c+9<51;O>[[15c.AgGNQAcf[N,&_N<f2IF:4f-)=Z=/78Aa[Y+9U(-LOg
Z024+fZ05d3D+D,UfgTJD]_IBa.UN7>/O-PJ#SMe.DN)WB+6+O??aV?/J(D,V@VH
U09FD=VA:MULL-F7;=dECM(CY:]0J#0[>1;C:MBHAe)<cL0(EQAX:3NG7g)JNS>+
\:?.VE@1bfS9H#/+-Q5P2#F6He4I)?J@2B_Q#1=?Y[TU3T]Y(0U:JO\-SbRAU\,b
JB[E.\W)ES1a]^PF[_98+(FGFHb5=J)dF^4d4/8FFY]7>Z)50&+_3,/,Ka5F3@O;
5N_DZaAJB52ELSB_&03NMZWMK0WJGFFUHaA?Z_ZHI8#1NfRF>A+dcMG;?YZF8OCP
a8TUV8ECA/UeA,EUcfSZ&KK0J]3?LU1ZBOa(=7/V1?&^b;;7^&SA?VC#geV7]O(,
(@:\2S&Gg>,1UDL)04B#fg0&LG4.@U.H@^RW&/5(Db9@T9&#3?L0<NcXTL8\+M=W
+OWJHPYcC9FYH,Fc:R21OPR^(,7A3A45SS0/Y[L,.T8OTA@B7XcXCKH]0_g#D_Z_
PK7GI]+@YaMVKKg,#ZQ4KHISUZ2=2g:=J#9:Y[KL(N.G+B\?ITTgb/5a3Z54aE^.
=a0,SN5:2I>\S6K0Z1aWN)^gQF]JET.@RQ]HZb(#=e=VNG>(;:4>,&<MS1&SaGTd
W;X/,R]Z6XKR[S&LB]eB#K9JXT[6),9=G/b;A&6KG97Gg(D#cc61<8D(2>6QBAaN
9X^Pf(eB#P<CSd(CTGBf#D=G<HH0:RS+/0^P#80+e/4Z7@1,CT)BRN12)I-IF3]a
))(KfO?a\Y#Zd//>8-(SSTAB_#;S5J+S4.0=,Z8<HdP43\d;\]+cV?N;^U/90C:Y
f9W@a20HJ:H>gPQ@@M/5+/QPSLa2D(11#MZJR&O-9f@_#35MQH>g?QN<#V,bG.23
2@M^1<5,Z@36;1),FTXJOTeENd/N<eDYTB2[N)P=LBc/Y4C>+3;9]bO[08BZ9D>?
B_dB#4Y-&]<<9^/.A)AeW#_Za?>:c#]_>#Nb3TWKe(g9BCKbfI8C1&]]X&VF).Z]
Qce5+C56TQ78M?#P(X+OSX#:&II\OP\/OO,aF]M,DV9E@/Hd2@.1K(^S]8Z3GRNI
IY)4-Wd<N)1V;7.;OO=bI_5a)c0#@+(KDC=;XNQT]J@+XaT/GWJSFH(5IMCf/bc6
T=E<ZZ3WS#>CZ5[.GO3)e>(8CE1f+GO;dUHf><MI[+f0bgf<#f@]BOX;PE]F)<+H
L2a^cGY@g=OW1(dG]M.RGN909<7[A<8WJ[f^ZN=+BC-ZPZ1fIg-f+B0LP(#,F><K
3I\#UP7CF6CJR_PdZC[J.]U@>/E5+.9>fF-F/=RK&GC/A=eXQ9S\3e;R8D,a7;_e
d?L[a2S?U7Fa,e:B499/&HQeP<G1<^d);64)2EcI>=TH5>FfX+&;)3gR?MGINE#=
W/T3HgE:#O/(G-BNODV:7fCJg_\JP@/A8B+G>AI?7T\AV+S5J1-?9BE>[9QDa\Se
&NXJ9AOE/cH4T;K=f_Nd9Ce6,@^/)\8=#<4#3-QI6;Z@7BD-@JgfVb:8J0/&DM/&
D5KFN[^:Q\;b19e:18@-)b1([c6=Y8>.6[6?N@7]U\@+K#+;cDaf-;=11U6DM1F+
V_B86-?gUX>ABI-OE?Q?;2=+]UI5bd-7Q/cG#K(3=:R[&EG@^CQgU>bEPV9T.\@T
D+g.#54<_.0Y&Q=^XK8Z2b/E+.ALg+.T9RWPO#cd&.M<L_c;^JJEbXCMHdXA[AY#
,NQC0Hg@EP2S\1U8U<)dCd&dY1X+eUCX9:E\4O&;#M[BPfCaWL,60G\2\E>.]MXD
5cON/=/SGN1fQ#W,^FC>^,\VFDRCFB]ZT0Q;?)B0S)f&a)KaOdWON>\a?8OC[91M
8/GJY1eI_1DOW#I[:+aK[OMP=e6SWdc@G_BWS&J_^,QIR2gQIFO/US+-G79:+;?.
T#4A9WM.LS9VFN:e/ePfOSG./eTaOR^Y,&5N+,>ARUGIA$
`endprotected


// -----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
task svt_spi_agent::run_phase(uvm_phase phase);
  string task_name = "run_phase";
`elsif SVT_OVM_TECHNOLOGY
task svt_spi_agent::run();
  string task_name = "run";
`endif
//vcs_lic_vip_protect
`protected
@19Wg<50ea)eL#1YQ3UFSZH;RIWM+LBKY[Kg:HLbW]4RZ;A=4WVG+(;?JbE,L?7M
g\=cEG?aeYcGTTGE-OZM_U2Yc\RRM-.E<UU+2SM9g#V#VIU07BM<-<OP+>?T[dCO
PNO#]F]D(ZCd=CUC#TaOb&?M_,@47KVVW/\<@#9@(N3KPK]:G=@[bE@01ag2TWWQ
ZZ&OW9YEY#L=5RE)L+:=2LWO?Me:HSOQMb&R.?d/O<Df;?^#CMXLaQQAD1(HDP6^S$
`endprotected


`protected
O]42@E@,J/d8\YN[HSD]BKFWR@R12O[DdfTa2+,/)O&CR9U81W^f7)J_HP6;>EYY
60JM4]SE^B,Ve<?.Eae:PF-SFeS80]MH_#@SM\-AI2.9_MQd7HSRW>J_N$
`endprotected

endtask

//vcs_lic_vip_protect
`protected
=L?1O.BD=fGc9PXf=W?U=N8S9X_E0)Tge_<5H2YfJbCN2DN7a=VD5(P8.E@N12e^
Z2IMGK-N2g^\KgS9\M@KVe1ECKIY6b\G\F(Q2Fg.AX?Z@#[FI^NPcY_#1g#cSX@B
7+UG40AGJa8WZVF>A^K#L4^[1R73^7[cBCZEUcXg-FBSFY:6=++K:dUVKBF>^ZN5
.^R-FL/+;]=\,>GO<g?2#Z2&a6?\U.[S:DcD^c(+HT>08_Q<9K/]Bb\SF)KK6L^I
,Z?_F[>1X<>#N4,E\]P9PaF?CEV;9KW-;aK<5VfX@F=0@=;MM#dcB]ZK4e8effcO
0Bf?;\)N>PZa[HI@1aE==FPKUMD1R\HgCNg&1Zd1O9,IS_aUf^GddbbEg7c0a@OW
0#bH]-Z^IY<g=:KEL(LS0CZ;SWEe?b?0:(XR.=f)#:R&H#KP-Z?S)+)&-H1,,_+1
aJYVKMI/a#e=YHD5EUZT44(ePN;[M#XT\G\bXSEKIcHa;_N6/]8eINW\TRW4P,=e
(YM).JJ1L,]@E..<>#,8e[E3Z^IF:g+?b#5[J=?F\c3]g&F#XRcE9V-^8KAM9eLQ
g-1^-N>9W4/a)GXUIB7.XQ-.7S^;?N37GbTRfg#>5@NM;XL9WKB]2&f&:#MB[H2)
Z(THWcN^AE&W/4571F+DH]-Zc:I(b4LJV/:J(X5I:YG;,FXQB8]&\eV]2N:G:_BI
1\+NS<CZAEVZIS1^J:+aF_VOWU,c&.bLI,VN.5+QGTVYc/7^4e#[W5Od]/Z4(?XA
NP>Ne(?L5bSMaGW08NE+.MBQ\1_2C[]Fd-:4UFJ5Rd<5M2:)<>ea+&]Z?IY(\IU4
2KJQb4]bE3=[=6/KEL:6gBE(2W(8VM8,8fG#NUg-P-+;SF/1eX;OSDe<][6AgGJ;
K3S,ABbeE?:Q0-D[E1X-)IRBAZ\R;BJNa=-4]\Heee_\V;d^PIa]2&<@FLAI_.N5
GV#Q+3Q\Q5C0e44(P6K4G<edGP@06-cVVCeEQgZ=c9LK1=3<RfITW2,WA[dT\(K5
\10aJ#/fA4OTMR+X\]g7&7G<Ca_-:B.5^FL-E98bG.[XC>3514d70ZQ5d_\b.L]4
0#PMK>fJZ:W/.b2)f8+ggPZJ6Z@-caN0Y,ZaQ1Zc:f>?SGV))TcOg+HWO,JgM17W
[?6NUG\-^\OFRYJH2F(FV8HRK=4FN7)Y#/K4G1U7)gL^FW3f4N1J^ZTB;#A@M-+<
&UdNI#V)YZ36.GICfV/<_JK41LT/b.>NKAZXa^(:f1U6LUQ]g2UFOe@6&F3YEb:H
^2:0B=Z-Y#A7XMc&Y#YYUZ+B()IXCDFW+[LX\6),a>&@-DaRFXYP41DWB1O@.U.G
E>04>2d.,L=>_Z/>/^5\^:6HV3ZG]+J^\RAQ(AaSJLTHO0KbMd<#_GK8K4K@bHPJ
Y.9e5WM.K#WU3d^8FI@(=dGc-,f1bQQU.&JW+GTF<(V9K:/,B]Z0LH]O7Td_DLf2
D&JZ92:8Zfa>dMg+?=>D^H.)C<JCD-:O;_F(R:\Fc]_11^YTfM8LZKO,DA?2L]f7
Q2;M+5>[(cS<CR5dFJ>+4fP3X[MC.Z)I@R+F5H\GD8D?87U[85@cc_+;]6^K9,B2
R[S&^BD?b(X4),/<=6,bKF,VE]^SA]/UHg0:?SY8)HQec2Ke;^:]\f:;VZJL\9<5
JaKN(4<)E.?01:V62KU/a8MJ[O+,0J9#8U<_3^3XUH5eH$
`endprotected


// -----------------------------------------------------------------------------
function void svt_spi_agent::reconfigure(svt_configuration cfg);
//vcs_lic_vip_protect
`protected
J00D1fHd>]HU9EUE4BOBEFdR;:IR;[g;<&CSEPLP#F[:_.56TEK(((>:cTV#Q-3]
KMO3TO0T48UgX_^/<L&6MJF7FD^,gU,dDI-Hc796>&(cg./;1H(JU_?A_2Z38OI4
d>aW[3fJfJKec2>8TVRX+Xg(Kc5WMe0SgAQEY:[\#S]0RXXJK.@[+Z3gcb1RO7a.
-BFI#4cBY]=WLXDbL54R484T..][g5.WO_M.@23/c[Z;;466IS6PH920=T5X+Xd^
bO1Q\KEYGaT#.A_BC?I:eXG_(KJ;=4a1+:,e]K<3^F,e.+#a^O7G3\Rg7_K;@+U&
3eHQ>B1eH-PFLY]gb3aCVM?6>M9d[@Q#HI[E<f-#T&)75gG&G55Wf)c##0+Q:aLW
M.g7WPaAf?0QUOP#S8a.dJ(^,NTf-DKF&JKHZd.U2B4+AFaLeYGFVSc#K$
`endprotected


`protected
UH]Y9]?;d3VV\?b;E(@S\<J=O=,5Gb;JH3g8.,,Cf#\88OP4JCL?1)8:LH7RP2J4
1(ZJXLOU4G?_;g&^MQ<Sf;g?Q473d0&9d9-.YGF/XG_QF&]dX-O^MZH/ga3B+SDK
S<WgDF#1795S=UW3/?cPTQa(CZ09>L-)R;^eXdGQ7=Ia_ZS.[91.-cH/L$
`endprotected


//vcs_lic_vip_protect
`protected
QI;D=dQRE:THZEfK9a_=eX+IR#JAH8XQgI7^L3BAK>B)ZcDVPIJF)(8_H10UgF#W
R71(VIIUIDSNSLLL^H6FJ.1:O\e<-[ZUX^fGX;;T&MXg>dUT;b-+&KE#Nd7Yf>JG
Lf_&d\09:.NHIAfAF1XBa@)-\?F^>SAOVGW8U<?c>R:H7E([28]C302[/6GC8HA0
A@E@^&MQR5XYd-?6.2gEH<RL-XE5g[]J]NIe;[a&65W2]+\3QM^S20\Re.Iga2^O
B5T_Tg_:A(c;1<<5T/\DB@87YNLI/Pa-8J;NQQX;;@^9JNRWBCcK41=BC1T_^IGO
#>L(3+TE8_E=^-Te\V+02UcaVQ:6O26);RC+J)ITWO^L@gK\M(B#cQG+4BF4_)J#
VCUD]-gTQU\CJB92@L6b5USASY-W0acU[]&c27=OT[9;V;J^XO6EQDad7J&>T-SS
ZM,dKE.W&ZR,_F:V_7XcTHIeRR+1YGC\<:X.J01[Q_X6e5e7&BFUQ+g-aI9Nb>(]
QXR,(fT<[0Y<HSbXPW<K>&&+++EJ7B:,UO\<&0Da0V,392ffWNb?cW=aI=IMN\:6
5\F9R7FFU518BfWdF0G(NT^7WRGL\PO3VS5(U8B/3^_dR>QP/35&BbSDH+1OUO?5
I[@8QJ8/Ld7PB([?=bE3-P]D?+I7C3AOWQ8_+,c3Tc,(1eRT9FJ0#2d941.P+7Ig
U;dL#e)YcMM@/_P>K@ITW^SJGTWLKO-fHIB4Y9>]ZOfYaJ>^UR8Z]Wg,dOX@&V<2
+<NVS8<)(C&EQae3#K_Pc[c:]1/)B[+2R3JRUg=eAO9f[L?ZU0B@=UX36K>)cY<[
Mg6FNG9=&.SPV&SOZf2,QbNdCdc85[0AdNfAF54/85fB]#-ZV/abX.MAQG)SUQfF
V(97>cY)[Z->SDI/U8eSR?8^AFgZ(aQ^U=N3/X_JHYOEf=MWH-dKO&X/Qa6/DgTL
<U.#B<D:aM.>@?B-^fBH1#1g]RM.e/64\8C\T?,@Vg&8/e-#fU-)Z2YQdf-\4<BL
>-edTMTT_:ca>\ET97PQ@ffIX^4>8J@S3KHL4E8PY>Y[[S(8Wc@ec+X6b4J5[5gL
QVH[LK01+a#D(2.&NEacJT)C&b;CeR.VD#ZSFWfR4eI.-Z_#7EY&.CA8WCL./4M>
;\?4#8,50d7cA-SXTW/YZB?N(;MON,@8XG\?gb:\=OKPKMF\R-HD_ec2186X_[JN
Z.@5#Vd#,Tf4fO9T]([5U?MIb.(K<\KU:C=U^.H&@M;HN,,IQ/:<0X8CGKCCTP+A
UJ+)B=QY\(C)dUCHH/3JZE]9UGDaUU)=@?,+b8R#8+:Q<9-11>4OT,,Q0fP,Y;Eb
OeK(Y4BH>f_(Bb_gR8(Z&>R,Q@[>PVC4C1=8S)^+95Y25cF2L\UELL?[[Z\-bcKS
(P>=>?g_:R^(WC7Ef@I/58c)J_61W>BBDN4?f+V6VaTB?V+^d9IXL1F[d<E51?IN
J83JC)&JWc94IO7052AcK2@8)@MM8A7.L+10Z^T[Ve-cD.Sg^=FZ-Hg#Y&U:C0@:
[<[4B#e(\0C/Lg3.S4fa:CdN1@c\J850;@TKK-LC2;D\80?B+?\RKaIMYMZYK)/]
#R;aT3DbGJTM_^#=.7WV^5HD@UYEc&Nb7Y6.VJUB^3JV&B,KLJ9(/,E2JeF3&C67
4@JcFA5K5a2TXC=U;)SK,XQA?:<dc5S7/8FQ=[DZK/4LRBN=ZgZAdTW4QdcSJ#/M
3D4/-B+X@345OHL2;OfPKEKgFT4gT.1c6JBb?6C6:G882c\fCFD6D2W4K$
`endprotected

endfunction

`protected
26V,cQM@NJ]8Y]URO6&IaDO-9CV^H<<-03D56#a,ONCCe:C+g49L)),(#Z9)<<VP
^[#WJ,f9&EH.[C6S7HZB37]6GE=(4eJ0P0F_bI,;;QDDHSLG3ggg7fXZ;b\c-U7J
a(bd;c8McPb6&1c,,M(SQW)?/N0&I=\73T\_>8Ee4[)O><7JK.8UK@P)?,B7dP&Y
WBE9QK/+dC:A20CL&G7>Sa\:K]5,J9VHO5/7FXF+cXY/5XZ#S1O[S/UQf?1VY2Mg
#5<X.Fe6.\YMQDRLY:+Dd<?.6DRO-FO)?gbRH[T?KGH\?a2B#,6),.TO0_GU?#;]
d0@G\F0V0[Ob9I1fcX]T:?64.7Uf&DM65\W54_@M#HVWJ1]&Y9fD/A=XC:L2PM[#
7\;B,g&ec&P&,<:gCbDC=\R;e+4EX,2H\)g9Q3SU\7&OF>Vb/9UBKXXEg+cUa9:b
9#D3T\MCADX[TW_P6\N7^HdBCAC-)9WBIJ1c3>0e5cbPFW-Y\77f^/e+=fM9A\\T
LE9+F43PHC8>@\7>9E@/ZU1Qa\c;TE)d(SVA:-RBESX2YMK4//U#&)0-C\8b&-B(
^+[Zc)c+f;6Rg>e=J+JE/cL6@>@g_RGGD(5MAZK^eSB48CKC28->C4PN^</]adZ:
N?ET,.FKb#GW];dUeW6:De3@1K6Y>818dTPHaUBZ;ab_Rg^0PbO_e_3#CB5LPU8>
ZdUR>+=9/ga\YEAd(caIU07@=K1Y4c1VZK.DPLIX?K6]9-?<[^a=&_A-g?#RZ\b]
dEJH)/YBf\0,1BJO?J9&B4F7@->ZMU&[H^e,,GMWS5.:U^2,3^_&11\GIWY?8g)>
dcbSTeaEHB:1#dQ<LG[2J;@1#+C-4@G]e+fe62M#e=QQ(=-AeI55;0YRK427J-3_
7&G-OQ[999=8??>NUVA&03Z\C?gHRe>FF?NXNR@B(3M-+XNT/89?E79X[BWD?(1/
]OSObXH>#6>dQ+5gOPDd\?4b/7LX3HV-,@5:?@UdDTcPNK+98P)ZMXb/_[S&)-YW
X0-197(DFOT#\0APAdZfELKUdKU3EXHU;dK&J:gG0W[/W1RdH2#X__=DgC2fcH@.
3;]+#H0=2DOPHN4/Ce&2LJEY[4Ra,Y-e0Z@=[Kb>3KMg?K-5K4.ILV+B6+?0?ZVB
K;3H6-@[V7\&;SgLUb:bJZ#;TNRb5P)e6AHUNa;A#f@e4DGGQXG-(L@F#@B8^KA)
aF(Ke?XLK(D)g//>FOV[HRCHJ#(]YI):YZaZ-F8K9eD2&7[VG([_RHTD=O&N:DC0
VMU2DHb]TYFQ\ZeW,f?@Q?P/6X_g9fc.&FOT1J,6WZT1YFX\-IM5b<H1@;+95H\,
973gb-()b&]A-INFBIb@Q#0+ACbJaL\P)>\:4>G6]\3R=NO2=75]8A;)cX7+^DIL
B+f?A#6L1;8^O2dTFbHg#(WE#UR<JJAD:X1LNCbP?WcT_ZX-:,I+U1E?V4H-a@SY
b)/a\9MP8HgDOe^&K>IK5;09W9FL_<5fd7^cg3I\;+,/bV74-gW6_I-cY+?#b,_+
&g1TKAP/c7b#R6R4R2eOX^?d(6Q\V@db_Qf&WSI)7@,_J\.?J-BFOb-cM$
`endprotected


//vcs_lic_vip_protect
`protected
PY+1]e_)d;>,SFEdNJ,\?>d+g/\9_Bf<WBXMWB+:?&UV/;WGVJbR3(?_Zebb0Z7_
_>>_4M6:HgT?CH2:W2GBYH@b[9+Nb=e/7]644AL7T[a&Z&KQ],AQ:-J6+4IBW54;
PUFT8baAf2\BXAA[W17JDYdQTSZD1@@ObfT,7;#>]0BNK?R/a@]U6^9b[S]9.cOB
[UWH)9Ue\D#53UQPN+:fY/I?C[D4,TdN?4;K,H.,CX>-+c7,EIIQPJJTX4MF4\9e
FaQZ1;g3MCV<?NgZP?V@d&S^7[&G&d7=b(OF-;e16C9T\;[9_54SY36,;T88DQ<0
ES?U+G<TA:;ZO9KNcN&]?[5(:2>?6GCL6LF@3dVc()8JYB5cc7D:J#4eaIZ<HUg,
N[a8Z6JZRB+^[K[\FUPJ=81=627Caa4D=SWWFQP_b<O76f\99PPP6^I+:98bde2V
F+dQEH^Xe/1=1LQQ:Z,L<A^-=QD@#&0@&\Y@Q^_D@NYgEVIQK0ag^)9Q[b+baF7g
R3gH5Tg[(>=5<1g<^;^?[bHS5b]/ZP&+ZNHEPgPUT+aOe^1U[cb2<V28+f=F/0EL
;44IWIQ3SUJ-2c(@Gf1C_AfL:S;/XR4LgFGd3_IL@g:.H_856ES>TW(aQK(]Q,e.
#G;<g_E<#\DQ_)._E4UV<A&UQ1-AXA[>SEE]+1e[4EA9.\0H_],L0)RLg9&PH1;<
GcTU/gJK[??/KeCNeXO;Mb&_8EHY_.AOY8;fK:_/K]L<aK.,2>>KVeO5PXWP4T3_
^RH?/U,V59:\gJd[NB,ZQ8]a3.]b]&))]G#CY9[<YRX&NJE1VQ+gF9@4B+Y.gXLc
K,#(98CMOQG:Y4B9aX.(FHZ2=B=fI(S0>.E@</4N7NPK@2GK+YHZYX1>3,L8C2X_
Q&d-aS2>I^ZfQ5,2O5:X?E_+fbAcN_@aNZZ_7,J]H:K2\ARL/XR8P?eJ\=X/>+Ac
1B+]F.JQE2dSMS]LHR]U-<f?L,Me)KfYQ;a6Bg5fPb=6X=FWL.L6c\H-GfE:31)&
Nf,K;,4Ac?:MMcFXadT^&]<TEG.aGD]DSd2J\]@=P>XZS7d8&HV+.1OX&5f(Hg;>
-?gQV-TST(dEcaZI3<>=cCdc^;@VD8bPgXKE7>]X,RKWdTR\577aNUfS58X-&VU7
\5>Z5@SC3D_f3.EAaO53(a[AeXgW-JEU[F0)Vb7S:PG_&2cI&R8\F1O=I6S5GRX@
NMX;UA]C#<d[8H#/RN(78@\::M&CP;;/aQ;?#Qc@X^:KRX?g05K5^W/ZZd\?N<OD
CF61FI904+K_E)4]^AaD^XM=8F59+_-SfE.(LQ@N98.;:L9XUZ+P^O88Pa1HFcY6
_)SKD14dDQ#;CaKF)F/ZB#fcW9=5=aQ2SXT0[X3EL8ce.>4[PbdZDd1e.,#A?S5,
Kd;N.X<2_b2.Od586fS,VQab=+RS-;6>A8b,)5g/<gP=)U8O5]UbB>+?;)DY1Xg]
O^N+6@LeBT6b^CNScaWU1a&fc8BU9HLb.^PSNX);8429=#ECQ4U(-.[>@8[HUCCP
=\e&>fNKQ+.5GA7Y&gRCL&cIe2YMQS,#8XeA[VZ.YL7VZBQeLb]GCAHfD+D1QOLH
L1SI-=.2,N+,+GM]R\KMHA(JW](D(fY^E.(R=b_;gMcMX,EJF[8a]L,fF^\e8W;L
_/0C1+Pg+O6^A[XWR>5.4.)&]U4W9F]=^94)44NSMcHKV.@]50>FI^58N7V+D)VE
bIQ677556\aHg88SU_P5W17DW_OIDdXAYP.HAQ11=6//W&/LDHT.HRF(AY4P0C_2
e&;D+D,-=#Ega/-IB\-[+c1IXdBV();@c#7@02ZaN^A91_?@ZMW7HDgDJg3H:&\+
G,LK_Y8,YQ]9V00_XYC^cL(5fDD8MR4d<JKX8VCaSS9e@4&ed<OY55Ucg1B7M:TT
G\K97C(-LC0D]U<]B_bB(<^^3O>+I#^QN]7D8)a0KBNg#EWT+S,SG>NM9[AUMZ=G
BP:]+NcTfdFYOBD?BI,OTCece9A8=,USgZIOJ_BId=DP#I5+2(bD/3^=+&[3#;2?
de=CKBHbJ(HG\\<?b-g[]@V>cOG0GZga:a&PE)54<UX6X#QX;E[^<\ULQ(O64E0K
JBR.CU<JR5Qe3&XZ,0,)HIO403DLH5RB,8<T@^]9Zfe6BBWFV\L:1)QZNb_V.TVR
Z3IE>M,6J&c+(;9C@,:gG(7>NH@NaZ<;M73#;29J61-c5\LJ3aC06I0T-UTKB(J^
YUHe/)-IAd&d2f\O@Te+HHNY>=Z@(-8INA#Sc+((9Y8(XNS)9\^EGb;YVBb:<M>Y
gF?HTGO@W2.PGMW&c.2(OeQg[9+e;Z]<42#)@P/+.&8g[(#J?\)g)7FEZ1STCgP@
=5Z)MU?47RdRcN2NFc(V27(33WJL7)PcXNf;D#JK-)F<:CYI+Y-4eF&MJg42eUe5
+@_76[6NI+VbLR(7CB,X5PP-DHG_S6H5Q#E952@0E-2_WQGPZDeF7.cd]9#CXgQ[
_@O+=;-MNf@4AG#YdZ4-7?=:]/#PH.06[E-8BIMMPL[V?3\\8WN?=ag?DN7L)&&B
d>/0\=.:V04bVTb=\caG.01.\D6,6a8SO^7,#:5,UWH0=SD_W)YbdZZ?/CD)2fed
(T.20a)J/=AOX<R9.A+9<W-Q899^6dY^U\<4[;.LD)P;.?E3#DH<3./QUCM,LX9J
T,P8L\FaFDFK\&(=5cB==_C/.cd?g<BcB+X-GY2YG+DMGP3FDS>W82RM+O34B0#H
[R^aLC(IMI4B(SDeK<5W\b]fF#&D#(d:EbWIfNa8MN\>QP57\S6&+HEBIg#W#6U7
f>?/?WD.9ff;?T^LH9c&\fDD37KM7fAS1(Y[I]S,+F,=;<7I^1[NYH_W@22EOJU3
bIcCL/IR[PXBV+NN)]U5S]VD#c6fHdZU/I3]^&N>0M3K4<eOOPeNbL+Vb^SZZe+G
G(_c<U1RLgG7EUA#ZgJURJ=0[WW5,HA<N.c0cOHIS8<[g:2=J^_0YPFSbPJ7XP/Q
3WHA2DI5>FU+G:-<=&>BCIDOg(#3E[6gaSYC6<SFc[aR=ZZJ[2@DJ=8,B8V^OK[=
f2_G=U)IdK#QFF3;2:/)MVG104UQN3dddYEB,ZEECQBR;O2W?T:KL&U-LbS#B9?@
aLa.3ZJ9_Gf60]>Z7AKQ/fScVMY4.7(#E0-8OaF:-RAeF^6][O407UAW=I>]HZZ4
7;GO)Yc.OQ>U@+?b>1)-P/=05@6JP&2TOQeLMZSK50Q]HG9M/69F::60R[?48=\;
PC/1,;dY9FD[G4N\ed>DY:>+eFUJ#DGE\28NV(+29TW38X_4L/Q4H(5/V])7(5-6
#,P4ZgFL9f5OP3__(MbGXB93Y.?W&HU7Z+9#RY>,RA-1)ffK=M1AP;[f4McdO(GU
U8[_<MEacO;bI=Sf9FS)a.ZWJPV>RMXW0X8^5-1W3^@-R)KT@Z.Jg+LX0g^0feY/
MFg@@<bcF1eN6VJgCI,;/e^#gdUd7VKdEF>58-Nb5\U9WMaEZZP=.L(\+DSS>)&a
ZT<_R=PF,-BB&YFXVdfNXY5.<YWE1GGAeGbM(&ENRN@1P4a9[W[RF<beH)(AaAb=
G+_D(N=>Z((cM)(0X1:Z7b.#).F,Z>\-KMa0K#7fHcD32):8^baF:91A..03]9U1
9-5be+930H&7BL4>3fe\27cF2D.0@.PI=2GfTTVc+cEN(;e));-S\ER7+WB=K9HP
F_-U9)QIA;(+YUURKEJ,,aGJ?2:APV=QdHYMGD:K5ba_]aRDE]XO]O[GTV>89;_B
c1fE2ZH#E4Edd]<@]L4]UL2?e^1Z;\CRP[:],a+[8>UBEWdS^Y[F(<#S67<0(LYS
#;(-SNBfCKC:V^05[-G]gcH&TCb3?AH&H^>CZf&4CTV6(Ddg.g5ZBAVZC-78C,<D
GAE[JO,.TYQHB3Cd8U,69b^=M#78L2YC[Zc>T)^1:V9@K6A21J9,V)#,5]FX\AdL
WZcb&5F2B8LdR=)P7Q+6QBfQY>08[^K<3[JGSKYcb=IB_Ke<S:.O[0FR>9-4+]FP
4+E?^OO4R5/0430WK[W38RPYA+I0dOeC;N#;\Wd,&T9DVK&)A8RaMX.G@T:(Q1&H
RQEH@.7U.;SL#9#(6CdgaV+&2?ZA9@4PG-+)SRX#&M-E2-_6f-&V>TEO#[Z0)9D/
KOf25?1S&c33FOc&F/#ZH_ZbWc\8#^#&NWOUT;&_a@;fVgD_K/HOZS&#.,8CT(5d
FSP4E0XS#2@J9c97SS#@Q=Gg).I4>0+3@[b4(CFRc]Zd.X#:;c&S7UB?FK>:92gg
XR+T1NU<&#KB595,KVZE/d>BEb^WX[24?\J;a959Sga4^7LH;MaCW5)H:Y+#b@=3
Lf3O\g_f0<HH-<HRaFU]V&I+GdME2e@5T@)^..=ED<2/GZ]?9IC#dML-I<=Neb\(
D]F4C.A7M<_&4S,8=/VMbYLVV-f/_.5A0)[0=.9dYD:ZWQ9[<J871FU\,=R::<_2
\CBSS;Q^9-[C#G;#\U457LaWb@#>[?M1=WVgeX-FKcUHPL3/LFE^\;7KT[T9_<[1
F;2:)g3:d75+4>HG\PV/CgOVWEU;_E6O8\I8)B;ZIB[<L4,0C?R;GSNV>>=?V;VC
WOQSW0BW.P\YYWYNAaJf-\aYO._C7_I:B+aa6@J311-?U(IFLJ[[<1_W>a&N\80C
=&VP249Od&S-T8Z/Nff5Pc6ZF^++C<[3-dQMT?3)d.4cX,R&fBB.11Z>GeW3CQ2D
ZIAPPU;H6J7-(=)9]5>eQ.EO=?bABC^LN_aC#MOV^B(H\8O[M#4-M^TYc,X4[Pg:
Q\]d4_AfP#&SJ/9#8d\G2L4)[d_EYM33@9=6SZR(UF+I;B6=G-4S7W\W49^GX>N[
&TYd=UN9I)+d1H6>>8(dcPa_F9+b=4TdF6g[.+c4@++]B=:a37=1/?T#K5(aRg0b
_.L]7X(FVfP.GaB;ODM3TFZYG^;^=\8.^3[/fa,DD-VQY<PI,Y[JLdbT56UJD#.V
8eb>D)9&V-;G2#5Q4Nf.FJH9H_J,c[5XTDSR]1IAJU?6g\/BT=7Q_;<=.f,U..Kd
2[LZ-A6+OO,;GSa75,#GPV-3c2<)Se=dBPL4.M1;#3/Q8]CY.8=^50=/OZ<=M)J]
],=7LLXRD1]^J]=@:JdLK4LJK_^I]5L,W-&=QaP_]DZZ]8@V?9,@)>S>EY[QCCRf
JF0W\TcCVBTg]P#E/F>5dgMD-)#F^P(/Q12/;A=1Z;a<;f_5+B0Ig6^9,X^43KAg
ab54-A[ZHS[a0fg8^gS0@9>+D:+gcMJ/Yd.BbCEW\@#DQ^K?GZH[Y,N74a0?Wb;T
DENZ[F.6AG(E0(,PF.OaAgQ[X^(TY21LQ]0XTSDO73D,_Ee-PVB-M.,YZ#/DQd=<
g(8VeaY_@M1Y9&]I:=d&=WWBR:CK_<KV#B(II;0W]7\T^]6bP0:LLPcNUbQUAP40
JIL8W3>,8c3ZS+:GR>X-0:XTF0<03#?,](\?^BLWD[.D)MVLTRD>X.[QQ;3Y,GaC
DT[K>/SX5I&+DE16R=d)g.L<FCaX3ZA:QB;7Dg1a4Kg3Q3[[#=ea4CT5ZCA#63c^
_3a>eXJK&XZUQLQTf2FBS,\#>=e5:fJ=@PfCNC=W6d2S.S).2K5D>WCY;6gM.4[6
PB-DXSdf;bFEd@KB[?9KF3[HFS98Q;XI#Q#>(^_cUQ#(X&#,C5Q;6-.dDPSTIS]A
^+W?Y7>_CdAUgM&Y7XIQU7W2?X\APG;b4fDcAEeeSGBC1&,5]-Q9P8/<FX4H,/.8
</\1fdP3VO&c8:_[-1=f1:+VC\2F<E0WZ(WbK,QM9CIGU>:=52d#M7F_#Zc5PS]F
[7FYcCV36G,A[.-]BMdDSP[D[N\\#fNG>E&_?@V=#1PR<73Y_/;V-X6BUN,?Rb+T
6=F(Z9.2R3SYTW9#?S=39-&L/]264.d(eXf11IHB/\74g20IUWdfKReC0WZ?&&>K
-?;&P4PT,FA4&UU289ZUcWR^A68<CIVPfSH9?X+4e5=,65&9LeRC^ZQ,\8fN]JVX
KdAG^7CW[#IO0f)V&<@Q9)a<,+&AYfJ,Z5F]::9OPJP6XEQ/<+6KJ&;/?YWL.2#Y
:AcM/AecWVM0,[.X&O=QN-+/ecQCI0<NbNF@QQ<eXaf]DMI?-<<HW(F(7I\JCdeQ
:4\Y:2cP&1W90M_0KY/4ff.Ba8<P\MZ/AcbE;O=OV4JdAM>@J6g:MY=0HW89eX@V
/Lg>^U#0@_N=SI#VJW]2,1),5,,_eS,081\[@-eMMdZDLM=fFFV;E.gIeFLPRFE1
LHCQ#Z4BV9N3GKgdA3bbM7B<_XXb@+]dB>7^-)I^5e+GCA9F6>H=-/71:e/Ddg0J
cI#)2H_Le04X44+]c/e16H\?ZNEf^CMcL(94X)(XA3T=:^719S0JYccg-V<8=SF.
e7PZ]Ig[8.^R,:Vg\cL2_ED2(G>M+d=-FL\\_;d+)a@E?3_E9RKIC)LNgG9dc.KS
LZS/D=I(OSI;2H.7Qc);A&3_,Q_0#:1TBRec:W,G^HgYG)2fQ7J^^E:D4Q]dd))P
E=)aPZ#2R\K_?Y6M(J:5g;Cb6df__#eK?9^g5d(T@PeA,fO/#OV6=bF/Be;SF7KR
GOBHV2X=J75X+4Nbba>_=I38VR3)GALNKg_g#f,;=/A^U:[KQdF+D-GYSag1-4&-
^XfSdQQ@P&0]E_f+gT0P.af\aGGT(-S=@\I3MWDOAR7WE]Y3>:V1c3fZQ+;\/B5O
W4/IIQYW.7<]\Ig+&/+=P7(&JZGVZ8PDe79eITLTa>,+6TO+:&3f?4U80b]aa?3-
\;AbE=eC]8=@<Y1V3<c619(]&9.,KBV#8<89-P5+/_5(UZJ1gF1eQ+;@f[RETNAW
#:N=&=-2JbQY&A0][dHP&VF(H0H^J6V>)G_d(+XG:?CTNA7a&+:4Nf\P:/#^<2:4
&98S&,5LNPdg-X(I<bL8D-LH_:+@X;^^;-+UP6<X?B=0ZGdD\K>?c4&:a0ZTOV<0
9@3g?fQ^@NK0.L6fL/AD8XK9PKFe-E[O5#&7JU,<[8,P;Ga5Q@^fW_D1WJHQ?-_4
_023E],-;]KCD;e0VgNR5:fJcVeS38\?#.ad\@B2C-[=QXdZ#+X:.B#BEZZTdgG5
1_P#C.,<^>8/_4-@;DG)Z(FU23MU&,R21&g@Q^&-SUE>,9c:495Z1=SCQ0VNTXY\
baZKBU27F.eT(CXCg>\VO^JR[af_H_T]AK2UV_IS#&ZT.,,NP(O/TB=M?:IE]K\f
[c?][1]B9>AP:JJ;RFZ.62^&Q<ac8eJ<(#NX0b2]K\-cIZ5I@^5X6-OY(L,]TI9?
gXHNQ8@+S.R<F>A)UX7#3Y<TCea/<5B;3EM]ddQa.Z0>BQb,3Fa0,])3E]cfYSR,
+&.Z.C]cgBXQT73GCI(Nf]P1<<<:AY5AN@V&C4(f1UWOOf7?M?NU)@@(HPcW1LWb
cVRb(R_T]5B60PB)O0d01SS^689ON>N8B(_KOc0RaK#:Z<=_Y_f:bW:2S[e&K0TL
P6O10MN-^K5W/N^F=7b[g(PM6Zc0W4\@83<?@W0#KR?371(G.BaLKL^F=cU@U?gX
Q0IB>/?(B>S]Y?F=D3Va-/ZfHE(^X8A/@&-#AFf9ML?c.YK(FeXP1-AJdJOQe\g_
eCIeTQ,VZ>)HYQ;O-/#-Qe_ffg,0X_O3c42Wc,_>U<N-@O7\/:]<daeI#=YL&[1A
^Td.7-XA)7I4,:.E6/6]61AHbOX,NADZfOaGJ#<>EB:;MO-)GVU0Rf\a(c><&2I1
-BgCFPB\fYRa_CbLB^NZ8CaZW\9Y)&A>@WEeFOc^[KZQ]>GR7E_UJA;/RDANS\H5
8NF,[/d,=-dM>__/&Tc[RIUXA,_:YF=:ANN\bZ?cNC;:Df>,086K+Na_P]\N#B]6
CdVHM1LXP0:X=<YgRNZ4,eJCXf]1TD/9?N=#:VWRAKM[C=41e^]6MD3O/GaeA@H[
\8313>/6c6BcB@39L:QH&^G\O9a3+07f_(J8/5=HT.AeIfKV67EC:5L>MA/;0C=M
Q?=(1V),EQ4@7Y_:aXRf/01[B3;>,=bB3AF:FAb@1;4gB;G>Ne2(/3BVS-#Vc(,3
,Zf3Zbd8B:9_0<#g#2fcC-@R\_/N[ZJIdYCU[b=3,SdgXeY\L>-;KD-#4\a9>2I3
@bIU4GROW/M9.##00N;fFC@#F8:K-&DN8d\X\4G3-e#&E04:>8OUD&Y@(AH3@18)
FaY</)PB]Wf2^<\,=QY1H\A+BbLP+SUZ#ICW2A_C8bBaKX>:F=@DgMf2K]M,P9XB
c4G,8Y-\B(=YR;8baX#OTMFAX-T?&(AbXT&-8^LX#C13(X?U_bO#7Qeb+1M=^]9?
/9-b.I+SGT_YHBBLX:^<H347G3@)P9=M+\(D#(1VW(DF&086(X\JS7bDOKUS&O9+
,ITFX[C/=Q];7^6DKH97LDXLS?ER/OKYZ42VJ33V?6./6+&MHTdRYDU1->8P^dUf
Vb306UaVdAS_)WH8>V<-RceT:YUb,O_.I0O1&+87Y,-fP;>T.];ZXXDD#EO&/_Yg
BZE6e=L>_00L5+2ZYRYMQ[2+Vc#R2V<7#]\eIa20O=/-,_85cZZL#HPSbIF<dG@f
dPLXNPM1,5UXc^NI6ceD\?MZWLH.H2]B=ccWQ&_&S2C,&FG4YMB):fEc#/FFQXPA
1Y:W6R5Z:d+ZS7[68/(LDb/>AT9IZ2RP50Bg=+71Z4)<N@<&d2-J2.c]M1_\a02a
T8H:AaBQ4bga-,(7TWbaag4EYNCbFFe:DZ[X]^,@aTE2I05LJ=@^SWQLZd]VLPJ_
4e.Yd=)QFe/&#N78;&:e4#e<cFLIN:27_<+UQ>^g#Y0&aYP#IMb\QW>89XeX_a;F
MVUZNg[EXA@8#b@,^_76=)7Bb_HAb<H\Dc0DNJ?S;)HXTC5+[OBKJ20c6><CMGPc
4]dZ[6[1R?C.=Ja,8aSGf3+g[aC/./;_,WOZ.IDE(]Y6ER1PZFN>.c9Ae4#.#=8a
K1UXOFG^eB0YR-Q-+G&f)?[]CW\UV3Ga]J1LVa_RQ=8c.Cc?XZg<<@]f61YRbO(3
+[WN<2?CMC7#^KK,(>IFVT=F#bZ(Na=_O#P2I8/QIfb7Nc6fB419KSX\&db[P18G
6/_b[,21c@U4V+)E;#ND24FDU^65eUZ=@T:GL[ddR:Tf(I&1.\bL1b5HcBK2XL_X
.)IMdXKP,S[AReg\G_+eLO2#7;THEVDG8SRgX,8=P=/#g_H7(_PG++PJA.B(ZW-4
LY\=SI2/1f<SKdX44]H8M4Fe:g9X(+73P/c=4WOGcE<7U^T-c=8ZJB=E6IG_M;TA
FLJK-MG>]K@K.RfD>FUMLJ^=HFDb#:Q^E<@fX,fQ0Bd46+C/3bFMe<E1)F5W3T(J
;&e/^7@SXG7GH25.C9T&3fT/[9d=fd<K>>WM1]G4G,=(S]VcF#T4,cGTHKC@0-;J
[,H]5a-2+&4@?.S,U)\DMA6@76-C\d8^JLXFCg81\e6=1.YJ66Z5^Xe8ZBXQ?W4V
0;O^/&STDV]FIH:WSc.e@]gAAJFWY]IGeLfEgT6;X[9eX6U<XLT&[c=WRSNf?\]F
60QWWA=(JG,=D+:>MDX\LN(.fB8HM(77U:;]Xb<[/;6T0ICRWK_JS)7L/R=bDa>C
YACT/BE[K3b&R:BF>e3#IY+@[KbC\L[MWWN3c/[O##_C@O):[0VgY#6;:#a&RHac
Yf92a]8g;XWFK-]5YabY-[A42Kf/ZXF)aX/DMG8EfBVJ-Z(AU(d\I@3Xc.7-,7IE
;3ZP@@=^^-,gXEP?;6Z7Q>G2H>g(a(_^/#KGA.:c0)?<M(O9Q&(0EacEU#D3(a>[
Xb1[YFXNbQEH3.XbU2#3c?Gef=6RM73;/1Y6D(ZR<QYM4fHJC#/GUfgN&B5KbFGa
Y<YcL2K0f_K@MJcF?V@XdEZTa(TT@e46GWF9fYH6]>DHA.OMGX@46PVA>^2gS?-X
]5R3Nf&N_]cf>Wb4b9A3(NI?RJJG/\9c[:Te[+:R0<HLgD7SEP]R>5E)2[KdcUNd
[N0V87OLD@EXV+)COJ@gK@>5W]-;[H,//cgC@C2)F]-)c[Y0GDJKLWG2ADg7.^I.
MT\]^XV<7d?F2JB9Wg.1IFJ\PS/>2VQ,REeQg6A=Z9[T[]BGgdbF9#?]<f4]?CCT
X5g<b(O@UEfb0[6TCcbJQ41VY?Y+OBe<XVC5U[9U<EZ+#M_XcE>-8>e07KV:eS\/
LRQMTT,NJ8137L<=;_04PPO6VM<BM(4EeL2Y/,A;:a[\620.cWEV<WIdBA4_P+R,
Vc=(8-3;MG(9GHO9e>RMg/eHPed&8]L(BP-b;Sb\?O#aeU5HYaEeM60(<^^J5[>J
(K=/#4@\)BZ3a0F>I4BeI&HU@9Ub-&-@]FAGcaX28.:69N)7Qc0693K9N0d#Q)#g
;):a3P7=>T&cb>fWbQRB:=cBPC?F;L6;]6:^A)G<c\Oc>9J/-S79@K^E][V=,cV6
,G]3aVYRF=V:ReJME>;;\U[+[LMcXIJ@ENP-X_Ucf\J+&4-;,(=/M()JE\d4\bB,
f3(f;8(.OKe(ENDec)F>T#aAO)0&KN6=]6@R0XKIV>1#\V=+5>U,C[>S5K[6HECT
2<AZ]dL?(7+&?NLUKHNeO=7>>aG9R_9-&XL2Z7V:3=]dJ4@/6^R?\RT/+[./ZDe^
7JP\-/;B+#4ZB#T\bc>Y9(/,7#S4HSAV<NVJ/KGH77I;bZ;N<A2WJ\\7.Z5&;6:=
BfI9<]PFS<6b6KM2>?@gece]70_K1VCKF>;GCQ)F<Y[_MJg7AE6AG,?He(LcMRe&
NRUe,<Q553I:VWcca9e,&MGcHgDE,;)g@dU[W#)UIV4:S,<\>U(7Tg.K)H(_Ld;R
PgE83HCUcf\OBUfMc/^Xa[G=)eMWDK/g@G\KT^^8^;4M,&HP4D@O1TSTKSQ@2[Re
W\?4HL#/3/8b+0ad)0X2V&<UMd173-XV?P[ZWKJ2\:LM;\5KcN)3Z+-M>@2ST\0(
RcUJP4TW<cFE9>6CaYOY<(F(9]4bH^<A?<2R;@K@0^1POD5]GS_<g+UfPAQS_&4Z
Bd+B\;32OTKB44?,R1bBI?g4324YUFX8)/4HW>B3W<=5G3#7Be<5#QJE42Te-?GV
V;\)O\ZaO=2[fd2&8H.GBK-@,Y+:f^6>b#@.b-5F.DNPQVd_,/O-49ZZ:>4&)&N/
MKAKCgO1Se33[,WX9=b^d@H@H+FCI;[:Z@Vc/5<_c_1U5J=]CN(db?0H/cO6K47a
T-^CKQ/+;ZCD-RCc5C\VZL2<9[7[P5KE(Z[.QYE:FK?4:H6b89g(c&dd0\c7G^FK
44Ec^FT@dde]P:86..XEGFA#e\f8L_;E4Abg1d@>b]O#OSYT?aXSfE9e\:5V4]YG
7/L\E)V;>-Q+KTX,YR3Fg2fE2LGf/XR^YU1J&&H5WWdQOT<>ag7[(B]U[&7eW3;2
SfLVG?O0R3(#PFA9fWDTNK&I.N,V5MSC-.YJ.9YXdR)O86/SC^>PIDKS:=7\=OOV
#793H71Mad>BW=_LY_Da3,]()D,A)5[:+a7c?LO0aeEGB)c;BHU8R5GA>6NGL)Y[
NNOG168?OY>7+5/cTKT7\MJ#WEI;1;gIgV7G4ULCVe1J4T_54ZbGWI4.0]HP8O2e
B0&?-d:=KR?^XAT4?5R:Eb\BMK^<@_aG6D?K=MT50;3#9ZE[QI((P:2P\BF=Ie2H
+WF856N8]A#62&I=OX6F/(A+Cg5OT#dg>c7F8+F6Je(D[B-,>F\-d/a2X>aEZ5f6
HKZ5U4(8PVfS,ScR:cKX.7R9W_I&I\P@-#K0d,\AE6ICRJL:)T__da2g3(YV#(HK
T3;<\U30JKV@b85@=T8=>+Uc8W=]TYWDN]Y)HT^/J#FAC[.\R)Z=.<RY4G(HCA#[
T##7X5_e\TM_MeL@:b-XbSb#@d>TIPeEgA1cB]:KRSHK,F)_7]2]-2^&NJ,CEONg
A[WVGDeFEE7.UV>=?.4)72^)_;^(XDFYdLB6:CM5VP5J0YAE]FZTcRH39K1ea1)-
\YBF-??Pe1WHX]6VPYb[Q^dfYP6@?R=]]^DP=>GTHI>4OeNT5N[)N1&SV[5gEPQ;
R>bL@S<c)P>Hc/UUV5d-9cJI)>2;2cZR11[3S+d1-,LGP)#-_K][3F+:T?(IH]7=
+8ZJ>?/Q1ObaKbIg>YWUX(S)ZTLBGQ,AXTfcLAD3C6gfeP(9(QDY@84]C<R1MJ1L
TSU]IDa0+)aS.<N7Pd]?3)3#(20;Md#.F]41(+R1JL897ZR+BDPM]_Q]B&g&)=MR
H?0P6]aB7gPL[0@K,e3\:N^L=L./\.XW&[>FT.O5J;HUQ4IB:#BSU5LLJ5&8ICFc
dL>IB#G;e;LA056Ug93ffW#BL##ZP+JK#_[g(NYGTV\d:N6G#IH_S4e.0A-G])PZ
6&L0CC2D\1=V?([2cg3C,RVS0S/GT7^bg+(LZ]\A,UI/I[/Vg8-eOCW?4eV&D0:[
bGaKR/Y@>3<Vd9M9(.#.E(7GP0K;+#(Z?T+NPD\15><2(77UYad+NU[]IA?,cCRG
F)Q5>L@BH7AaUL5O9g92JK-788CX/<6?X4B5))b2If=#)5VZ1-aSH#fb5,eNT3/X
F^Y7-<U9H=YL^,A2VS1)U0?^8.+KdZ;6<-_CVD6L?=OCCDN7RL-Y7_TBKJ)cQ.6+
-&N-F<]>\SO5@WG@f_E71<(&PLeS.SB4(5V;?_._?,6+G5?A8Sc\He>079N:B))Y
a>RA5&USB^=-RO,/\6/d2X>De+\YXI9X#P?dZ9Mc8Z:_#&S^,_5a@=c;VVc.cY/Y
f#d?+ULcTIfg&21Ff)9?7e&&R51##WX4^ZB#>Kb@,0UTS4MM(;aM1c&5D@SH99AJ
?S5+0R31aaf4b-FCDPFEX5K)6=U2+WZK:>G997\M:6)4FE5\Q.DU>W&#8HOO)L@&
)-YC6)V5+J5YZNGU-1C8GM[LO<^2E:_c=LC(-a=1c9C2Y:a,;]9b/>;BD@0Q72#E
-P[U/ZUfaP#&>Q]T2-:C=&>5EgH#7]V.8)eZXFOSVg@N1fb8c63Y[<d3:,8L]:OA
NaBA,T73DWgU:&G\g:;K25FfOHg5A=WWd)O)8[,]=9GNgP;BMb0D1[V1HD+d0c>H
D7JS;F_6+(1c84J\V\U)M/af9^bY1:e+#GHWADC0Y?<9PV1#QSEbG2PWV?ZZ:,bd
A.-NHX2(+52ID8\@f5=/.8,PI63X;?IJ&X,X9UESfZ+D4EMM)Oe8FO54c,>_@JgX
_=>?C=8QOdD.+2_,8,L3[5gAWG&Y/#K<V=6PdHe(M/GKWN3K2Z\BX_F2<7ZV6A6Q
4X\67G\1]@CZga:]-?@I10]FW#FBN(DQIf_Le5/=_2&.4MHW:2Tf_D@S[UegB@G0
eK\#UbR@eTOV>6?1DH(aRRA.0O2N<S3@=A>4+;M,M?a=X:cdV0G5-[K[IL,]Bg1\
WSI/57EZO]8+?:GCCPNVXNNd)BMV08g(L1AK&b(#07fM(5BT\/AgT++CAW2g1VK?
H(T9f6,??VV;IgUGc_+(MLI+W(+>\JYLQ.?.DS&<N>W3UO/J64@J/--Kb/dAOH5+
Y_UOZ9\<b-.(5\>VYDVY/0WD;N8OFHIAM3gCR>\fN3O)]A__WU?bGEJXO&X\fV8J
PeDD9fGM2f+,gPf0?-\K=f/cR.T6LcYcL5GML?>5?HL>B]V4Ag1L2BIGc2T58<PZ
XJ[???NV9[@#[X6DU^4R_0^fW/NG+L]6-7[cQ:I)T3/>61=;XL_#OH)B72280&PP
fIe<.6C6GR8NQ(JF[:c+0X)-@4H(UOa/JAg]<V42^5GK@RE<f##A>1T[NY-X5>TF
5QU.QPQRR0Fce&MQG)&Ig#4g2M89bC:PaF)1A@E9R\>RJ]PC>?]):JfPL3E<<.;b
0JOL)VS\Q3S.aAgMI/?I1Cce8eXfgW;gH>eR&(6-#YI_(56V?d_7Z=JKFL^#,HeQ
b7@A5_OP:67\S56Mfga:1W,2>W6PJ5#BW55RcX;+#GMHH&J>Q/(FC\M-c///6K)G
1f_I/<],[K0/X]1aVOfUQLMg7>+<F_TE8QKRB3TX(8c)BC]#/YOH(3Lc=6(0(EN1
\1=QV;K=:BdMb86D?9eX92.b]&d-R-[04Xgg7WbHb#gf?e3[.SET>R&U.7VU[fPH
d39G:_N0DYgZ#.P=>Bd.#A<UH;(E+?DXg)6[FJ+bE7QdXB#R1YKNW^]TBV/aHE)K
[76O+Vf[&UYQYe5eF[&G=28GIHB9GG7Ned^[ZN(S[0][VS(W#aTG&NI5ST<4J\7,
1EV2CFJ?UFWQbfU,bfZHGdC6cb>JWKZ+b,L#H/dgUcUEa4:g3SW:+=aWQKaXNbZT
>c9gSf,&[Z5Kc]Bb>?69bdST;<fQ0;dbLG,T:X_G=1@V/>_;;f:RYYI.DLDQVE@?
.MMA?HG+bPBT:gf[IK3#f]^_I=PI7&I/J?&Y@&[?:X=R,\8?_34f&6S4feScUUac
D--0@aK+&L-?B-bbRAdAEE::I27d>=M,AfK7D<:8?Obcc>\@b-W8g0W>=HPMGf&Y
=4.MMWL0ZggM#+4T4<2S\b&Q=eQRXC>38F>4X5]ZcEOPfNdJAIJgGG=^E-&Ud(Z0
ORdf,+R_#,g-]/X>VMbV=GAIZR17P\T^+HVT@#KN8JI=18<^Zd9L&X2J\S5C\ANG
FEF_d+Y=<Jf,<=g&L1=.C.ISeMDQP^4aL&B+)8F(X>B6>]&UY##D\\:7D)dP,?JM
@L#:DKS^[2XL?2bQ[HJKGXJ;EKZJGGR^<d.MQe,S1)NF\+OUJ&?V5.37D)4U:^A4
^J,=DQXKV2?FPGZ/WX8TY,gGT:U8;WJBdfS;g-Zf>O4(JOY)RL&f1B7_NZ@LC^I5
;-3Z]@;N-DP^[5G_ZOM0]L[d?fg-1WKO1MC6=G3V<M.0+V9[+7+I+3Y;^I-5R4=<
?(#RMD>.H<c@fUP7RTL3N6Z?Fgg<TbJ[=)bEJX7@C?.OQF;c,e(R9,/(IUK47-R>
:U0?2@\+LI050NO>T5#KJ/ZTI=;9?eKK_]#N5f,Se<CCHAS4Z?6(b(M&9BW8GgIV
7Qeg[FbA1[AaW[&Mg[5GRHM+V2fDR^AK3F6G/B8>8)8GX&_HQ6fR\06=O-bU4^KM
1cX<WAfc,4JQXUWID&IOFHg^^]?(RV[.D;f8L_P/P4J/V>>He_2F+01dQ@Ge3BVc
19BK9A&YZQa@THHN.+_E036I2Qf_(+_Af,T#;0,.K6>eHf+[#0DMbJ@>KNc1J@QT
?VZH==,I6C9Gf5H5Z+;7\+J97SV7g12).Z=3P5gg@6,+<a1dM:YCa_,F#\8#K&b_
1=PW,Q@b(3<g[D>f2]:d9dFb3^S&Z.-(-e4[2\>>A.XEKd0Ef_4e/9[FdJ6?/NU_
4NfYgO(:2&ECR943bQF3O+SSZYc?K\G2<7&Yc6X4.60#f031>LBSAP:DE?1B_NAF
,XTb3I4J(^P[?:gL##[9R>GO@HQ??,^fH:S<MW4A]HA]+_afg?J#3F4I2QZQcR#:
6Hab9KD7^A,WYSIe=)09D8/B#(+cgcOR&Wg/g@VKPPYC)&)LgG2_JLc]>Q,Uf.Kf
]FH-;<MNJ.^<H@+?7O,?^5_D<4f4A)bUbR-)5&XcV.K9,(ed@SGN-FF24C@X8Y/?
7L4K(&3Ee5LO\#a5gae+6CNVO.&f#H<e7,=5):GcfGIJT?de^HKbYF4P]?509VG=
5G+4-A7d65^-?M3G./#D.F=6??g5G4D;TGg+Q\=(Fb?7[+E(@3d^,:8=M.P5Z42&
[M:@D:YI?V-57/IJ/-JLVR/18^Q+4RX<@]Td4g?eYL6)-g-c0<C3#gBDE@HJ+HJW
a8&O?YOH0C(2&9RIb>X>caXF?10&STUef<YKb+Y\<#bRc-TF=RMF(GcVIZb9ff\T
QM2--Z>Z?PVJ2DP)#U_b5VT+VC_AIUALD]&Mb)UL_QM4;NeQ,]SPE6->dHQZEC?_
JRLL(:_^)[1D8P(/0#g:g[fQ\D#/,&Q2GQ-.0^dgLT3_V)S)@-EUKXb+069_H6@:
+Y0OTZSW6=M1@Jg)CCCcd?:VK8?_=9dd?JWN5b7e1,Y]R,(0,OQY-(386;R)MMFd
0e09FM6:XGL[)1M\ET?P2(b9Y@7K=&1.I@1A5bFa-CgN9^fPNI(D,/H)(FFFEURc
c>#4YdRaL@1-c^.6\37@>EBg(5BWBf_-R]D<IK[e9/G/8.503J81>/>^Kb1AJ#M<
^70gHDa_6R@&4CM+G:cO9ES2;>&D&.T<G_D9I=+RJI)Y,?E:@(]0;V:gg[--ZU3D
@5f\L696)_M(_JJ<;N1VU=8a1140(W8]02SUUP9W3H#H^I;0G8_B;P_0R1DDGB[^
OaZc3^RTf7;;_[.<Ac1&:>UYT=TK.ENJNI=Q/L[6J<;[Y;V7c3/.?ARfNaC5SQ82
:4)P)SFb5bgO_QZT#aD;HPGY3&:0A6aOf?.g.UE+S<Bf:M-Xf(V4U:.=f;\b7-><
X-f(.3B0Y89c:U#.&HT;eZ:_J,d2&Y7Xd?9ZXa]#F[J(XeHM1BMV\HU=Q3C4R+M=
]ecYB8R#G2T-bU1YD&#QbDF+Cg<F88g3M<[Z].^C^4KW>QDF)6-A+-LL?;1^WIA+
^6J)c,<=UQY_b=VY=\Ke=(?/&gMa:5V(a[_3844FO_>)_&fFA]e/E/4Z8HI@Bg^L
NLfc/PQ+K]/?:\1OY-K+DL/CaK[ZC;Tf9,aQU4N<=IW,]G0fU,TLAXT&MID\BIbM
\6Oa2#0/Bg>G[OQ6AIcM<.;FGTG186\4\NA,<0<:,PKJ((e==KT&Id8.QWO72/T@
[dP,2c-(3/&>IJTVU#1]?>Zd57X2AG^W@]T_P:.-UN,-O(3fS&@1NLfIg)_3/3AN
e6XBU+G@H=ZVZY:,(OUZW)@R?NXH_Caa-CPc1H8&5A1Af.daS639.@)]7e?PQ2:L
bO[_B;/0b.9NS,?:a+g[S+4eP^T7^<+<;1&8QcH2K:-J.AHXQ]J)(JFO,#_5>-OT
GgX2BcSKWdAOU,M1GaR(6;J[JM(5?)X9EWT_NM&H4FELI81g,H30#AWB9#>^WR/(
BW+_^Y:MRYKO7>K.3P9XWW2e)BdJ+EOPYFD[O<:]&.AH11],I:Dc#+bWcV:ZM)HB
(U^L]H#P7PUKIA=P66ReM,?LS?6KZVX?K4bQVM>C^<YIe9/#\abMO>66gCLEUI?]
TPAfW^AX2HBf;a+<;:f/QD\;Wc6JaJDF.eFGgeS[AS<K;>Zd^]D-X:T6H)b._Z1>
fNU699:O2CZ;g.>g<T4+2;7b@;28<1g)1V?(//]XT9gb1FEa80;T=>CXWd+C\WN(
S1BY]DS]Yf&d_NXU[cOFFTD0G-be,aP#Yg=(HJQ8ICOb./R547VE@YRN:Y8W(@[,
PYAE\WX4&^R_J0dW<5We]FM45@YgB&&\GVGJ._OOAe?.YGL4GgB7=H[^c)5g19^b
TdG2QcO=L.2e+\[]BS2YgfBc:4DXN<TA]4A98QN;?A8+M4>N5/GCZ42M/9/FNWKB
fT]13_45C9ZV^S5V;KL8e)XE>)S8Q7\51]MZO=7[/:W8(.=6-@=[5+T7=\c#\Rd/
gbY[LPA.adN^gCV(0d139U6J&KWS+S=5R\GOF<-,2UK]3+c,V+MSBX:c@L]<;)DW
G-dS17T^Z1M0#V76G@LYbef2M2\[BFcU4O<LY^:E3bHG2JQ1HSd,#UA_ed=W84b+
f0Z^M[,Dg4<A4U6P31]WLXC)[Z31XcCYJR8IKL8W,?\KNA5^<6dE7@;##7B9G#HX
DJ#GH.AJ@dc=TF,7eT8\C6c.A4G\3AL(5(30JWc=P#<SRJ.BW?(P3c]D:[^XTd;&
)JSXEe9ILXH#DKQ<XV/abE=V97K.BGc^OQ#Bf@\eDRMIO&e&^6Qb9E]I\=C_C[;:
&_0_#(W1f5A#+V&cK^=a\1<A5/YN.M?/,B+QH1.]S[TP>Q^IO<[#-XS7Q_(RC,[S
@I3dcb?-2S;>LR5d0R5QY(MCY]9X(ZN=2KeT0:M8aN]F)5\;7R:I+J.dgQ^H=\bd
eX)#Q2\TT[S8cOB0@#B/+W)P]R;ePVg(0UO59&gW[G;,;-]T&O]ScP93D85,T;)O
>\M8>MRG4[aXM0J2@W42H?IMB#gB363\W#V&R>LLf,UP/2XAFL,b_91fT.aT_?=d
U>K?X((C:,>J@K8/BW-3BTF).WT/a+H-IT,b_;J9-:ee0MG[Vd[FD_b_U/LOe(_\
5U:b_JF1Ib?Q<6P851@>-#+OSJ/,85=51JC5g8SGa.-\5I:8&d,];f#?]P+HR&]=
Y_)HSZ0bGK/W0PYH-A<MbDWD9eYIBUYOb(L1[=I<VLC<c7]BG?dHFYE98c_7I6]W
KZ1Y_1RB,#R8#,,40J<9=3a(C1658ZA0D^WW-F<2<+IXY]F>SfM;U<[8-EN+X^Sf
=NRU=E=8P68]CdL+U(=&\Bd;_9=]cNTO05P#;]/)72VU=cGL.Sc4/63b&\?<-#L+
@D.,_](FC@;=4)NK5g#[PQ,:c;;/GUGOg7@VZgDQCS7\0O<>\T3e5^f@Uf#fa5HB
g5.GLX?:TT+\EJLVUgS#f7-Gg461<HASKIDCYR.Y#DLHJ[4e_P6RGS[[+O^ZS_CF
^DB;;A+(+ML#KJL.&Na.7IHE(2&(R96[<ADAFU0).H3]aF@SP@ObRLJgNYb-?d0(
.LN.;64SG[5VEJ(d:2@FH^,?+B,Z?dPeBXWA[0f87ZF8E+97\3_K>/_OcP(><2Ab
S4O35Z]V<CHI9;.^2^#]/1e1DM8YP=+8&<6LQKF@<7ND_JDAgL#)0NOGZ9)KA8B]
^3Q\/eTK2V?S(.HbB=-bU^dNGHbbZV-K32(FE9bK9++/a/0S#09=IV?[SUf/^>M<
C_2a2EHY\\)D)_4#Y3/RX[)@[0C<a>J>90^4,E_:2WX+#EVURdL1+JC=07IfT8^]
(JS@dM^<-)H?)[#=9ESYf#RGJ..\2CO\UdB_2TLL@dTQ?T\I9.Y5N_H@Rf>?,U<S
6F=9=9,X/<N>(CFPSAYg3^]BN?]MAB[+6C<A6C1[@fHT0cX-OK6MeA/3-&99UQLH
>R9;8>Wb:)TCL(bdJP@Gag]?8;\9TOQGQ/XK],>F^@J9#X(:U:cAPfcc@-FNFHJ;
S[(/L7J,7WNDP3^\SIM)_THL^)@a-f0@Zd8=M-NC@9YdZF.[#6J;])V+U?XT.\E3
KTGGR3GXHH4.5-35FC1g]E@=JSBBURcZY&eN3S&F9I3LTc//D;UMRZGI#7R@-8c+
C@;C[FZ-3M8_4CU>A0^VB,W>RZ0]fW--HZFCg984FNC>J;>9a4^5f=(QG:C6?#(E
&QU4JTN[CY40J6Ta(1ZRL+TLL]fZ?ZCPD0^@J]3-(;3I8_@QLDR8[GgC?1^8;_.L
fLBH;.0V,D\.RM2V<<-+Hb0DD2/P?5OV2^^L;&[=Z6M&Hf5OI-<Y,S.?^I[(M4&6
bg77:g,4c[e#C\=:>e/T)4O]]98F2:&J())_PRX1MA7cKZ2L4=M)TbbaM@AOY3U,
;,&762Pfd#3a0?85<@IP:<@UfEZAO^HDL#K9E1c91K=?<9L_T&]V\TNBS.[TGAVK
X^f.]RS1HW5#?fH;J_ddPJ;-.[HBL@#5Pgg4.eWK_/6\a?KAb?9PX,,,Mc35#P@7
f^,]\&MU#D&YZAN2#45R()F#M]1T3-E7?3E7P20?]Tf6]5aSH_N?L;_ATXX4ALKY
[gaL/cQ2)XG;^V__XA\2_He:A;2#L54]R,)f<;4Q90B-+28Y1eTCNFUEV5=8Z685
8\^R(=(7U?KgN7@DaP.31@4FIF74L[4[HLd24MA53\PS=P#(NMV39>LF3f@:cg24
QH&Y,QNcM@P;+eQgcXDf8BdWQZ?7V5ZNI>8KTPP_M+fK@KS^7/_@3M=4JO;7Q/-^
eM&Z6:@L57Z@>0NGH)YW>34T51A)(b.f(3[DB[(<A;RO38.<]e#:72DE?S(Qc[Y-
2J<V;9\@QMaNI23R65D:;a:=H0X\W.69<fc]/#W3&O6X/MY_0W4X+2_WX[HGgT(]
<[4U3>_UW,aGUgcPgLMA8G/7\QZ\Xa2fb_gV9C5BdaH<bGIeCO0</Z/&B.\C^PWY
-\63]YaNB9cZN06IfX#fYD,fc=<FLD=g:-7&6#cQC7cIZ-3CN[EVVFPd+N_LgDYX
_UdATVd#&Z_b8\I#H27TU:gZ@e2c--g?3F9CN/4-9^cY\&+SX5fVW1PWfaf:.8J&
]\g5I3]>ZM,QU(#+3[Xa][BAYV]6^_LbQN83IFHAWZbG3>9_#+<-HdO7YD/[4W<=
MWB]AUL:]NRI1TaHIQE]<]&_TV=E\&#6LN/DT<>5)^DG=F_40aG<H/G(c(UDSdYF
L4S37LV.3-,WFT7LY3RI->\2FJV#:/3(7CZGU:Z-bU^J7&C)TU?I\I:NVDQ?+_HV
\H_\FL#.7bN1M@9+/@ORNQJ^eU;M3X/T)X)4H6<R#[<]F0#a29a^_91BS/^\&2J[
@_TZB-OJe+E9&]Cc6L+MfSXf#PGcXB@-RRXNPW(\\0WO3,:VdfXCKIJ80U=PM:NS
#6BO>D\QR6&dDAI</]dBH&80NgP(3ZVR])>FNC2YJIJWZ@5J\0]/U^>/4dNMR/ad
.2,--ZQ@D&V2cE[\?.2(2bVMSaF#FP-1M60e>;SNH_)ab2Fa+LU;>:/Z_+FC)O-9
7aW6.I+ZWQbDGL#G9#ML4aU/02]V9,UIH:7^1_Q7a7&OX-Ka1,edPGdWDX>+_Lb7
G+[14V@#[eXa+6X=f2bePM(@L;UX4F:X=@6TA[1d/dXHG7TgX?dKg-PI9+0(a+6@
;GP99DS,D+STS<EA9eS]WGV#^e]XFaf.^35^^)_/1c^P]8EGVEA-8)?]_DdV4\9S
\OGS2E;&ER<(g-e1+B90/T/,AR(D;e603XGfe^M275-OZF>7DLX,^3@cA1?.V13V
D8f4&c4d\5S5.(aOC4#/HHI49;(ab1MG?<g90I4&NO]<c^ZXF8O4BL.a)UXgCUA6
OR4<,?HJF]WJ6dd#HYa[g1U74B2O:R#DMAa2<H=.;9CWD5bO=d#39<\(bb?963(a
VC;GdQcWSK#ESFBKJ:PV_3Fg=HTCQNNSK8L.2GbT\2H4>L&#[)=Ka0Cd7eI-]YG:
AI(UJ;d5NJ,.6c,RBAF0B1\=g7HXbB=V=6>[M40SP7(R\C[HYB@+W><;#&)AZ<ZX
aY=.?<Z1d8e6=g=IC<_WfT(Qg;U2c4E/J<NKaVc&PVP]_ZG@0KZ>@]^+R#e-/(@>
F#2ARP@LgRH?0]V4].ID@B499ME^-dF#aT>WZAHQJ4VD#?DaE<Z,1DEWF<:;@TU>
T59OWOT]N9:_+E1HcbA(b5-H,E_AZcCD2EI5^=S@/?XF(6Ma>_:d1)FY91_\a=M\
\BL+&B(J#\3L>QI<IYGL3@K33^UG6&WE6W_\T2OQU&fF&L_H7N:>,(-fV30K3#MZ
_J_O2H:CEgAc:bPN\2O/G<M3Q7EJb4S2ZRUHJ9Aa;?ZGgM0=@>AF:,:K45?>350M
c_V.UV6d&IRV]8KGV7V&Y/U/TfUQ\PZ#TV3;HLFE6,@UfY6@BLIR>I+6HU]@B.6P
H8(KH6VY6LK=]MDV^M75]&;-Y=MZ#eEgR0P.F.V:G&/G3(<cfFeI46D\9ga\P,M_
(7V(SSU2<6_\:ZQAUg6CC1EBRcbDJ/AdWTYMAZ9?7&)YZ(7f;JU(]4<1<Y6UC7a.
Y8f>NM0eK1M#7KdAX?Y5a3ZIIH#-b6R@?gYAO?<d+&K\=LV0>&L&eRA869?ZSR&@
)+A&LQJKP6OX9_&3Q#g[0:W1@[6acQSYZ=B>Bd)\F5_6B^1;]OKACI.KUQT#4O+9
[I\KOd@E1V9&Ef/7JUN^dOK_MBO..RGTHL-.0</QSWW;d]2SbC/_:]#CTQD^5QW4
<N=cQI_KP14@d6LT9#==0GBgKfPAB8+g7S7&96O1bBI^_^4e3+AQQ2WFR4UQ&>CQ
^3I/>T:IB^eCLDN6AOfSO\S=[Tb:R-5]0IHW8A;Qg93FfGE-WGS=cFLeK#[a[;O>
?N7M9&)V:dSDC.?eS8TJcE@1_@Sd_We[@=EVTQR[5<_.<1Id3SS^BZ@&17Y1WMJQ
e.@MXCB[F3Ff8]G/;CD?>(Jf.YJ_O19MTCB5VKcfHP<=Eg=),GYS8bC,Kd/_H;5V
\LAT>U;T#5b&-Pa8=D#Df7IeYT-Y_U[MP4I6)e,0X4c0B5?JNdC[3N@5:6N##TR@
=.OX-&]GHS4S8^T6;6L>@-e/EEI<)0ULPG/6CF.=?4@D_I(W0HO^D3-GaaeEI-?V
T9Kb.46(=:Uc9.68ZJ\##\c)?A4^XJ7HV3&g1e3WB6KAOD+27@bSN4:8R[c6G85V
<MbHa;G:0.fbF>C,Y]U11S4)KOE5SYaHYYGYCR0a#DQ+XdUVZdFC#M(CNZF7QE]I
.gJ)]R[P\@g_@DT#NC]N\[RFX7_T[7g]MDB0]Lf^X.ZfQ_#@40C;cJL87-2@M/(9
EcVM]QH7IEV:X?,KKX22B,G;M[-GQ9YT0fLLE3Qf2@LLTJHEd.[KI^XPDCP_P96[
ac75Y2gO]O0:^L)d_7S,eU>gRP6\57d/:W410V0\DG3eZ_[bM8L(O>=a#_9)c4DW
Y^9=JSZ.2XO\XR_Ub&A\R/5aTND]_ROR(b][CXRED#YX^NOcZ6Df>_dV(C2d\SG#
T6^?G1\R2+CHBZY0gIA)C0NFF>2MGgd-<?[8N@4g=aIa13GP^bNI]ULT.Yc-P&LV
:G+>>)(:>G1TU.Z?7QgJg0=B8().SIX,.1)cC[d[BIPOZNX[#;]dF(@1XM-E\N49
efSC;PQA7NDI2XLAM/:34KU8(3b,fQ=@[SMf[)c1#IUTIY&CL3M.KQK3J.R3;7)P
2XXd^>S2DQ9[LXaW&>-dDd^X)H=+@@5/cQK?We\cIURV3>)H\.9Q4SMKH9CN-PEf
BS_N3_=0M@P.G/&O7S#_EG/J2S<6-8b4SJX.<UUZ\26P5KPMW.ZG7.A\FH,K:8#\
+6DQf=Q<J+JD:L8P,DbWNERE#I@C_T+YU+Ib-bA@gHC.\=Y?>8/D0Y?U^?(8eWMc
^)D;\)bT1NEE/4e/c==EM;+,7WfV>8QSFK4[?11/K+e&\d-H8ZeGK3b5HZG,4)-6
3KZf:5V\\<TSY3-564W.VOHZ)AS)a5F;EaLcN:5&:MD_>a=f][8XGePeIA?.S0_+
A&9^<6H7D?O<3PfLKBQGdd_<g/D1ZF,@D?I<U#aSYAW8)=C(5W_<=D4XEX4NHRHM
ETN5Y;G5_@5LCS:OBGe;f(+(>E(24KVEN14a6G\,=dCgVC,c9GZRK?DM1_L-HI;.
,e1RVIc;YW^-X;c]@-:7Ae5-;YXfPC9N,CUMM>0UETX2>X]=>e2D=T=AS^[H\,WP
W#gWGTN3:P=0eJW.UbWCaW2,H:Z4M0A304AWQ_;9&+XQH(;aPQU6=>&U0B/VafVM
XW?(8/=#a[#+YXMNNW_TH=d4c++OfTWM7XMCST/1S\XE:aW](GWfIPB[HE7L#dKX
X^QK[Xb[X+f?@51YY;Z[bRT_J:V.B[E)6fW-O9)7JdK(-E21#4R&.dTK8+S:N15(
KM??Y[POGNFWH?MJ>XGJ>RT.^8;QA3A(FX0/BV?2D1ZFO#F&U8D)WaTY=^;L8:c+
RX#cW<5RW>:ZU94+ITNA&;C+Z1@CfGLe\?Q0NDJ0^acKD39fISLHKeHTIPC.+bZ4
NOef.=AQXX]9.@.O[17-c[;&6N2OC@<YeX_dZE82cQS^BZ#IAL4HD=6FSOb5ZX,:
Ug@NBPLWf<;5YUSC>H.<Y>DWD:>#GW7>>J7.,?91+0aPGVD=#QI64MG7=B2OK/ZX
5_7MAP?>,4BB@^A-O8IY6@D<W+AT1Z6RGO<+bCMaZMQf8<0ORWF8VX(TX7=BAX/^
gSI=bUg(J\bQ(c6FF,N;OVXS9)QEV9==M[F=+Gb]5.B&__4SaQ9^YPf[<9IA&F7.
,_cJ#HT1_dT1[?5KfL]1CadZ0A2CJU@8SSMP#C3/\&@VN=YO;CA@NC>YfU@W:Te_
)G9e)R/&Z@#7,>WO^8)CDCO=)=K4[)>@:(1L?8b]\g.;\E:Z0d2ZcVfI:a-.T+b8
VAaA)H^eEANI8b9\4E\=fI=T#81#DNV?#?U&/\99e8G:VS#G,J\)>VJJbAXd5NBP
A5E,O6cR(cMKYIZdJ.S/[d2J,fd70F1(MaHd4([g=51bD]ZJ/aQ-9g3#LO4cXUF1
,&CIVN3)4-TMW.P(#-VC<JfD)(0>RAGbY6AJ(N^2Kd&P;.Vf7bC+YCZ:b^M4PM\X
OfU;&=Q3X89CT)>2Q>E?^OD\:b9D1/bYOB;A@A0C-?TIJI,G/3VEHe:_M;9V?D>9
;9=-NXEQ-+E\RT_P=4X27Q7F0/9+5:V[F&Af.&d9L?BD)e2(NY6+,PMXVP#]E;(&
JO(9ZBZJBQAeDeJPY;P_K.+C-YU3Y;<QDc:J7&&]c1S0]?.f,e=L(#;R3FVg5R0+
OAVPA[@W.Q19#[dFIQCZHc@L@CMTFR=Jf5a?(CQM@BKEQR<8>fH.N5UIaL8Dc](c
\(7L8>f8Y\FTZ\O(\PI;M1-36d:A/2M[eMNG3K3Nd8L@AJe08(acIbL7e.Y5gXS4
Y9U;:C8g#[V&)051H?M4;1Og0<L:4-X=F)8012.B<]/6RP0d/YO@TC9^KW-I<_A8
2MgG#&TV]R^Gc.:6>B0H2>9Y0=2JQ@a,POHeLL&SQ3Ye7-QZC)IKbH]@SMdLVaB4
5S&I#BN0Ha,/IV,)><CTBbIT;G81RK5&.[Z+\@ZO780eTAOc363fOY1c(884\\#_
[ZCP[0aTZ#9K23?AUVL>Z),@AC1WQKc?E5#MAZg,=1>^DWcC1RW]XA;GAaK47:HU
7cg[H=PAJd-KU8^9MJbANNUVG>^VF[:PV6O9C[);TOL>94f\(=cfV6J?K.Cd)[G,
8;2If;<75bLc>+Bg9OfP_b=><0R-+G6\0@8?fD4^SU&)T[8e:QE?[ELBS]GMcX2O
BI-^_O]R,@L.Yd2b,JT0Y65I=f0V\BB5L5cS88+,SSO2\Q^g@3LE&T<Q8J/NU_3X
GP76,9g(FcO27O7V5DJ;X,Yc,:?6@:.[YAg\gIL<gJH.B5,7HQJgKVC]L.1HX=Oc
NGD>3YNPe.K)@dJC7UQ3Vf:QV;CWXAS_LEJ@LNQ_2JBTd_JTX?&?dO)78I;+?V84
(73?ROEc;baV0Se)+JaU+,;=JP?X8Mc@QGgdJRY6Z;D,&MA5U0c0G8.^215BMH.D
?^&>Ug^9F>KaJ?NG3&,PTF^UH0,G;XB;LI/&b5/UAY3O[S&HgOLdF+GL-E/2/<9J
)+:,:IB4IgG259R3SPL8>QS#=-8]U@58B[]8>4aZW7;8&SG<-6R2FU[8),7-(3_J
CQ>\&7;@/@:.M/?Jf7V_d\d=#C)3A0SgQ5@L<3D0@8-;LYC]?-QM#:[/F2Z\&2[=
#RMCO=;ddSc)TD^;4_N>5E7g=L2Q757c@E=,a#532QLed-b,_c;J?L>JQ(7UC9T5
YgTDPFOgDW,@5H0Y7TC+88/RaPXG54)d77[\[(Q^Z)YHObP1&-GG.>5B=f\&U[A>
DB@,J[:GVW/;QE=E.5=Z,U\JV)#O@c..2AN9/S;^gf?<dZgcIdT,L;A@?#W2QEQV
/Q(V5H=?U;^Jf()HI7T]BF?M__a0Q(?>957SN0e7@WAQ-,)^G?c>R(Z6dbX/Q2Q9
I671(g?ZYH>HKH,AaF9.=8KdA,JcFE&<:H?8.I6DRN=DeaaG7&9aZNH;3QJ4C=H8
e4?-IY#2M(-\4QeOE/,]YE[:&YM_7.D)&<IXJgWYe?=Q0AK>cFQ;e<^,_\,3T(F=
fU(E;/FYG,bPUR27EaaIE.E:SW<S233<:[XQdbM+WV3)7f7AIL6?ZF4PaZY>,Z9U
X>SL^@ZFSXK?0\]YNM12)\B=GQG/d>fG)H#Md@&Y>S+/N^19LJ0QIE/8-\F)UaKA
58Z;2F^4WF.cC[)]>JGDVe;5)?Z=T[Y0\<dI/(>)D_0M<gEbPF((.b).ZC;PM3;F
E#8Hf?Q(SMY40K-dJTF[ENFHJN5,1T<]5L_]0+?M\HC/:RMVG[[00PAT+):UO)PR
Y7J)D9ZUWS@4+$
`endprotected


`endif // GUARD_SVT_SPI_AGENT_SV
