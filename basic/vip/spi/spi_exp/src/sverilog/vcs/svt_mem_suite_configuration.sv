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

`ifndef GUARD_SVT_MEM_SUITE_CONFIGURATION_SV
`define GUARD_SVT_MEM_SUITE_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the configuration information for
 * a single memory core instance.
 */
class svt_mem_suite_configuration#(type TC=svt_configuration,
                                   type MRC=svt_configuration) extends svt_base_mem_suite_configuration;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------

  /** Timing configuration class */
  rand TC timing_cfg;

  /** Mode Register configuration class */
  rand MRC mode_register_cfg;

  /** Width of the bank select portion of the logical address */
  rand int unsigned bank_addr_width;

  /** Width of the row select portion of the logical address */
  rand int unsigned row_addr_width;

  /** Width of the column select portion of the logical address */
  rand int unsigned column_addr_width;

  /** Width of the chip select portion of the logical address */
  rand int unsigned chip_select_addr_width;

  /** Width of the data mask */
  rand int unsigned data_mask_width;

  /** Width of the data strobe */
  rand int unsigned data_strobe_width;

  /** Width of the command address */
  rand int unsigned cmd_addr_width;

  /** Prefetch length */
  rand int unsigned prefetch_length;

  /** Number of data bursts supported */
  rand int unsigned num_data_bursts;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Valid ranges constraints keep the values with usable values. */
  constraint mem_suite_configuration_valid_ranges {
    bank_addr_width        <= `SVT_MEM_MAX_ADDR_WIDTH;
    row_addr_width         <= `SVT_MEM_MAX_ADDR_WIDTH;
    column_addr_width      <= `SVT_MEM_MAX_ADDR_WIDTH;
    chip_select_addr_width <= `SVT_MEM_MAX_ADDR_WIDTH;

    bank_addr_width + row_addr_width + column_addr_width + chip_select_addr_width <= addr_width;

    data_mask_width <= `SVT_MEM_MAX_DATA_WIDTH;
    data_strobe_width <= `SVT_MEM_MAX_DATA_WIDTH;
  }

  /** Makes sure that the data_mask_width is greater than 0. */
  constraint reasonable_data_mask_width {
    data_mask_width > 0;
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_suite_configuration#(TC, MRC))
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_mem_suite_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_param_member_begin(svt_mem_suite_configuration#(TC, MRC))
    `svt_field_object(timing_cfg,          `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
    `svt_field_object(mode_register_cfg,   `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)

  `svt_data_member_end(svt_mem_suite_configuration#(TC, MRC))
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   * 
   * @param to Destination class to be populated based on this operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_sub_obj_copy_create(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   *
   * @param rhs Source object to use as the basis for populating the master and slave cfgs.
   */
  extern virtual function void do_sub_obj_copy_create(`SVT_XVM(object) rhs);
`endif

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

`endif //  `ifdef SVT_VMM_TECHNOLOGY
   
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  /** Constructs the timing_cfg and mode_register_cfg sub-configuration classes. */
  extern virtual function void create_sub_configurations();

  // ---------------------------------------------------------------------------
  /** Constructs the timing and mode register sub-configuration classes */
  extern function void pre_randomize();

  // ---------------------------------------------------------------------------
endclass:svt_mem_suite_configuration


//svt_vcs_lic_vip_protect
`protected
=HeWeQ.K5Ka/U-^1>G\UDCUKS)&J827:PK4/\3+?U,&V=5:dKDIY3(QE3209V^Jf
MPA)QSR>H3U;G/]S8FR?Y[QAbERR4>+/3,LdeQFQ58_W(3:<8[MVWG.Z-@D.J;^[
<LRYN+^d3YHP<-d?[AK1D\CYc;-DSOBLe5T#NE3PQ-bVLcF3K)3)X:@]3_Og<>[V
^F=GL(T?T5Q9X8OU@>9D\OJYNV5>MU45NPWP;#?+]D</B,ZB5Ie_>+I^_gdH<7La
DFS+C&gc)--(LT[/V8(I-<K7G@;?.V9dV^I/>d-B665C.0EV0S#C.dK5_D)d\496
#7/,Ve^)Y(<&NB^gdUHe0Af^G#[]O<Q2OE]2ZA?RG;9A(CIO.S16<KaS)+I,VYUY
J^\25HR<K5fabS#Y/g4;_PD0bO)6V(^e_8bO=.FJCJB+3ET64.PfZ)YA/S)Q]Z+S
C3H?b[S&fKN(OXJ9I/^:CG698(-FWRGN)8,VZ>)--N(Z^)KDC92X.-IY?=KZ\0:_
)K&+2>7?F)7WSACCIbEUb5(cf(XaB.A5&7ZdTb49AgI(XDD--fMHg-#F4IeC?gUT
KF9492FK)#&AF93SY4P-F.bYeO3GGRFQ_Z?_:S;I1_KE.fZ>XKQ]f-;9X0)4L+K;
L^PbEfE^?C6&g+V?CI-/-.Qe/MSfe;4A)C5J.U0_LCZ]XE-Y-(7bZ.^HM>CH,8(1
T2]@ZSJ39G^7JZdT4EEI@5S\M?-7XA\d+^9-AK0,Ra295e_<Xg4QD=BFE+9,8)/1
^dGg-\MeZC,gBQIM^)Q>7IT>4(G048d1D6b,(AXb\+B<>+M^<c&P?EB1];0@dY#1
^b<.=3PAOLD0F(3acJ[Bb6^CbWBVSeT1aCHHZcY)KDdXDfSd,YE/RS74c9U\)C34
Q<D2UX4HWS9+1\0PV1CIJT=Kg?C7JH(+\Q(_7M63T>W<,A:2OB@S7:Z+77PN]+10
4+2PS[cF92#4f=L.7:Q,#6R78?GQ/KMd91GK4EbR+FH-8VS)V9@1&G&KCG9F9W@R
PYcFRdC60_TZC]LTfKV31C7_D;+RHHBPNC9FJaI_^0OZ=]c:HBVT-\<]DfO3aY,.
(6.gR5CS)X2T_F@4S@7M2B]HFU5O(;KdMb9S17&/Zb^Jb1JB;K8RV)5Y;XM(U(<;
0b#d9/L@8ff;ON2F)1QUA0cFTa;7:JM:R9,;HKT#CcWCUL#(E+&A?bDG:P8J=E/_
/;\U,/BELf&E64/#8UNH#/VN(7]UUWL8IL,/,KTcVMB\/VQ.b[&XDJc\\7G_9KF3
0XDMbQ^g[/K[d:ERM\Y+^5UI+fIEWOW&J_S;Ac]R09QW8+IbBV.2GfR6C7f,-UbX
>_8XZO?W04bM008NS/8?+#8FZEEA\W].RfeD&QCfabV-+N,6<:]9VC\e#dO^0-QV
]EdG0:&dM5XJ4LE),PeVEMD@Z[^0NBe[M-<>?CX512cc:a^MU&QAXdL3dP]H\XL<
-OS3De7aKD+.B0>X=SW7N,3M:<G+/=THHHB+3YLC[,)a.e,]dXHQFIO43QI8F@9)
P#eCQ6+(#:#D@QSD,ASL&_084FJ7f9eZOM\61Ud++B1KW]g7Z0YT9c7?<V?M7R>;
I&,Z7Fe&\#M3-D(Zc(-FTWJ1A=YA-bd^@XL;ZV+>R/2EKYe9g02P>)6?5dFbXcE[
.KICF6:-N,N>IP:gIW#?CGA;M=d\:2&1[2VZ[+g(aOK,a739#IL:9^MAIF(ZH4MX
Zf2cZ26@[f#AZbD8aC6],^8CTT2P@S>R1+=/[+6Ca_UR;e]>Wc<(PS\J>MD;&W>U
813(U14\=4X@,;92c4W29T<5<X\;<>&)Hd:ICFQe^_TQ=[Z1LR7O@dDgOZTfI/<9
&,=54B#K5T#F=T/]RdY<<]FCS9e\B\?.LK#X>\)5G2d.eK]&bLa89I1(4GGC+@^A
9CO+,2PGWODQf@L)0<5.O)#g&^PO4A6F=]\><5;TP2[.)^?-b<#^a\Pa7]]bGPDI
=05+D5]3bEfDV_OJ>a;d3#)]bF)\L1YMfA7[1VKK(DZa,+O8[\ZfI2/EN/2RVJ@;
UZ5]U;4T5a]-XJGH-f0U9Q7e]#?EY@;H5&82#UfMY,WF2#@QbJJXU+F._U>@/VIU
202HUZe&9I&BDcIH8<R<Fe.cK7,)_d&5cFc>ML]=,8fQCd.4^.Q8V2X-5V47^P?L
\(cA:K;(V[S4]ONY]P66?/^C7TTW,^-;M.A(B>Z(L6Ma5P9[Y/IFfcfL7;&6LNa0
XaJ5W63S++O+e.RfT:.#[I_H&]TTAHMe9TW<T,GLd[BF+;<:U]fdEb[=/0F)W,aH
T9?HEK>;SRb2)+/M0Ked?KVFEYeD..Q>,@R2&Z.gMagG0YR&MW#FHS6)0.EA\J2O
Y->&SefaZ(HBR#QX4;?/>g0EFP0BG]faa@_DT_5S@=_a)Q#CeRS\91]L>)Y\P.+e
(7X6<6/eA4-=US&7_CI,?G/ZG2Y#(;\g)Zf&e73@Ia:P+LOgU:,I^CU^Ae1#@/R(
A).TfHZFVC-8/Y;C_D)A2@e_6BY\85)gIY18O@:[:<&eF&LLdWGcI.8FSL[?Y&>O
NVK9:\[Y]Sc44<C@GDFKe3V:@d&;fMJ9?d5UW]OT(9./bgb0E]4M@L]8-&[6/?V)
3eb>5K3QMTNT4Ae]XE/A33?&4A5]J3gX/SJ<XQcJ>@U3R4OA/2TRY,c7^94:aM&-
Z(^W.OEd>,^;T&OW-b64<P6ZYgEB.#,[>1BTDW[;VR013+,.J2C_eSQ:_ODaA?Q+
/CB73R97#-@R5-e#0dX1#9&@Kc<Mf_7V_W)^ZRb(0=SIAAaa3^g-/ObbQLeK&_HH
a])cfU0V38=d6C8?8P(&Z1BDCK+QAJW7VIU/g_\&1ZLLR<T7W;c:O&-:^I[BL_[\
6H-Ge=XD6dgCOH;J\KC)eU^Xa&MM[SfI^9IX5c@>^Pff;=eO+7LS=aEJdZ;>79Y#
XK>D_aS/<DGPYK4R:(<:A\gN2DRM7[)aRL-D\Gd==_7E-=e6&+W?:+Z1b4@I,a:-
5H4b,;#FPD9@:?f(b9TC,,2Q7XSILfNHK3_VTD^M/&fW^Wa8=8b0bH4TAgd&Yda8
[/^EPC:PJS2cAUSO_H/86OHgf?RfVB>gWda)aT.JaY:]_?B3<2eI;3O72BceI<aQ
\@AbQ7EcB2+f0@OYX1N)+dd6]YgZ6OS=FHfCOOO\[O6E;gZ[]Q.Ge+A)0Zc]VZeV
_FBc?D&59,GI\3/]1Z/)P6&>#:4gG0QBROY;DU4353H.P,_G?-)G(OC,,KSZaM^S
c3F)eg?K5[d,Z1^58>e#3\d+^O7:aQO[J7VHR7aAH,/.S&:S+STHT@<\WJVeegb\
-BUIFH1>RJAN,JZO-84N_IJ^b.bC3?M>9@DP,b.X/RRe/J.:8T(D>L8<NH:6R<2E
A::WWa3K5\UP)79<;Y4a)#MOA[/\)6=\Z780Y^RFC:Hf_P[IbE^_KWGg-=,H-J/?
>Xd2E@b>0DeL]fLPFVCB9bSO[U^@BPd)6D0-d;)9N5[e5R(/.O-@47eDe-9QdJAP
8[..TN\AZ;a1&:062A1H]=SKPdBZG=.<_2)3<S8-;RN#EGNESZ\Y<\^6[JGIU&GE
/B?6HIRE.Z7fCWPFV0H(A,dU7B8Rb;[XJ=8?G]MQA]LSF.<FPZ/D#1TT&cE;S:2,
0.4d3<3S4-,aCa@Y#T@bVYEHTYFdgHLCNNPg@O[6+4B@\Va&Y4MbUO0O=(b-HE(?
Q7FDJe2RUP^M#503OM\W]M_7N2Y?L4^N-M7U5:4;R:c4Z>eR=4P>XGUTeTDH]5X&
@CY/985I,aA6N6))XV@IALE0LFYbfcB83g;Lb78NWXH@>R8V)a#G^5/Q#g&2\SAX
LR^K5G[L5S/Yc[H>BN>_MFdBE#Bb0R6,ONM5)CASMB0?J[d5^U,-^Q(_ENVZX/bf
>H?)F0)_5Q\R2<)P7\6EF<(.TKB-c_f9&a#I=D)D]OD.3aNV#@5)<FacC8Z^W>2<
=:aAH(UR^#2^+W?HGF7M8T78V..X&W/Hf[1O[K&:+WN&9M:CK3N/5BSXbG#@H[c3
/7+UHY3/(&cF1)+cJ.JF&8RP]U0MILM16efM?+Q]cY9/d,P(K(A6F>6Sg>7_;G/J
D^MZ)VL_-U]g1F_>Y=d_40H2]W=f&MIIGGZ1Sd4IB.VcLEHb[#_fJI8&C@<09Dge
dH4=LN?-5=P\aV@Z[4fYS?=gVeO@@WWD3+FfJ2/BSK^2:Z_N4HX>VHW&cV]O9(/Q
H&Kg7IcKI-SECVL9D45,=S0_[._4-eH(U=8F1NI^UWF,NL)Y1>U,[bQ2T<SV8RWP
B]6XD4JYGB3Ub^U^_=E=PNOF:)BPOLF34+0[c(&;#dP0?^Heag[bGLLZ8c:/D1Tb
]D?M<;f+2/T9P#ESA79P/^cg=aN3.ME-1=8YI[,[.SJ@/(;)/_G6\aV0BA4L.G=c
X)b]Z\3M=NaS?b1FCD6[:&KP4+E_R#X4MNYL33;A\/D.Y.@((99?H0YfgL&9M,W:
b?=\QAV@fYSIT:/L=BMU&B=BGc/0)d62EZ@,N+^J)OKFP<41/\9a;)AKU6<0R^8e
LNBIKBcDWJULQH6WC3;\a@2?WR2S+#?M(EKLCB-]Ug/eK/&/K3\&.6-4;_^g&UMe
Z+T8Ef)R&aDLV3,2ZBK>2XX^BY\Y/#)QK=2XLY\^)+AfQ\fZ0IO\0I#M5(L53b>.
D,SP-FT=-I\dX<L4>P?HV3D=5O0ZJ6bDA=R&Kc;?,3H&F(c^OQD(-=KE)]7UI..S
:b/=C=SJ>J(#7M,@?VUX8Y5?H_V&IbTZ598/?:>Z7<K0GMN8H3?BO@YRG2A/=gd\
W_/3B?EPO9M_[ZG?^B0PXGQB[W.6GXJ=B-3HAGH;-;BdUYO_E[UYb:XD#O]<GcI8
)Nf3=AJa=de:gA:NH>Ka[R5OU7/a2:fI#:5_cJ_MT7T9Tb\&@IR&K^.+/])#E3]R
O1V,g@?,-\&f<?;fI]6J2WT=B85>(TS+5B\9UZ34+ag(OMUYeg(T:K;:f5IQ<YP#
eFUQ.@;)HH>2&0?-ET;QDG-K]<#W#L/\S_cT9ZUcGDFZ(ZC9W&E<Fc]?[GeY]Uag
5A8[I1/75Ib;75:<GTO]6c,Jde0AP?Mf&TVa2;]Ac-Y_=TON^27YS@cG&7AN<S.T
L155T)gHXTW<BW:YGaCJO[bN>CIY2IVW17g0f2]RA:4WR)bKMEN=YVe:832.L3?(
0OZgUU4-RJ#>.:.(TMRW.C4P00=N6SDc,LCTa0X50QH^Q;aHUY.._+SJP7G/KR2P
g2f0?49(eH2#/G-W+aO;WdF6@?1>Kc=1S+c-f:W&3GVJ0]V.#VA6A<,Bc]M&0e(-
2X364E,UF;=<?EPST7AJ:^(cW[@TI9S=DC\A1K6Xd7KO-3/0#^:1M02:EF]W##>\
P-DV7b3c\^f?JAgNFFG9>Y79/)7M9CJ0baV7-+[C/5K;\AdD[9JANB3/@V#^>CS\
D?Eg27)Y4ZA&W(G82Ndfd-@ER0V+I);Ra701^eNQRKW=A5LN]XHZL^R.=(#3dD-Q
[H0(OK#8cE#N@DAd]1c6>HYUY2W],\WA:=fMWbE,g&U9#)P3VT.BOcJ0M[Gda<;#
-)XT#B#\.X8B.>QcWW924W0J_,JfdCX4;CHJ?/^-XW^W)Cc>XB3bgQ4dQI4,eTQE
M^2#(MJL,.X><ade4P?=G4WDOa/>L]E2NfMZ.(@-+>T8Ud[0M[b)7R^:F#[;e8Ge
MgL:8,RN?NF05HU=_BR-Yd+83JM^R(YL99DQ3e7@f;HC4_3gb(:bF)Jf1#[_>AEA
OA3O4XFK+MEJ_.NWF]f/,gK2ZPH[]N=E(W,AQ#PO>e#1dVVcWbV77NX]dR;E.P-;
73Me(K5RfKUYeWJe=N[_-:Ib@4OT.0CUBCea@#JB510_ef8+@,3\VE;._g:;@>6O
GYG.&JXWYZeU:)YZ/c])YJGQb0V^HZ7Bb\OEHQX-c&L?N&W->5XPZ?EN;QOTgb<J
9dT+WKXGF>]H+WIB>S8e>TXf<-Y_1bB6+D.?9?>MD)ZY55\#Q.VVb)C#E:W;.#Eg
,OK-?14=7BKUc\O>\;KX-Od.T\:aJ)EKWTC\2AA?3P\2;ZN&2,93D1a_6/[+Qe;7
U-2;/8=1fD(TdA_Z4?;?LOb.JJeWZZ+g-LgZY/WE##Q),>C@(.GYc/O<UT_0fBLc
31>QFQN(DR-:PC@<CN?8[TCb4fZ/TPDe3Q59\LP<#4cI&\;)8#9]B0WV5e<_eL,O
@S748fa9)HP?;=.[E4_g5>H?J<6ZH(e70/HbeMeSG#PP#0_[=20WXBCUL\.0SdEF
07b?B^/,Eg)I8JUaM9BU?/_)f74U.\&&c+&6FMg&/,Jf:&0@H-ZE,4f<ae<))bc]
:=e_09bXW(e3KQJHgHR;4Xa]=V#R/BUH0DM1c[e8XD,/8af._3SYQNG3]B=8..Zd
,d,2f8gU@/.NB25E_^7fVTa#3P-;NESeF8_HT](ESLE@3I4>cLO9J2\;9#8:2gRf
c]MQB)e2I3.)JbD;FQILKd6MTd,^DWRU@BTO]];&J1;Q2(AFYB.FO+1:Z0&0Kbe2
GAH-TINSGY&BMN6eR:5F1_]&g;7)Z,6a,]>,DU.TA#N_?9/^D&)69F</F@A#\8C<
)SJe4dWKS3]HC>g<NAB]C;eVUGcYFZFJK^_?Dcf<0W3=H#UK5>:&:T+T,R[/VDSM
5YMJfM(8AB^X:E-4XE^XeeY(8\)^DUD>Y1P_GPROJ,(YM)Zb]B@+4V\K04E_K\]g
b\Z(K3eVZ,^Re?ef#b8,)[a<00I_LG51HL+H(OJ6Y7IMfK=Y=>?^^,G&gUC[Z04/
7TKJVF?JZ8AGf7XI/\G;BHaP+1>URF[\K=M<5_:6W:#MECZ=#/8HL)I1/&1JQ)-=
AaTP1@D?L-I2WH=>^T3(C5H22YQg6JR_]W_X88GZ6&_S<T>X,X_cB^?3Vb,XOYTf
,#M]]J9/>B5Y67b8WA=PB).-D0.;]]Kf(W<9HWL(@/NgQcWR;,<]gWddZZB+#@VI
TK0^W:c4Ib<bS.95K_/)>8#a4?6#-PY4NWBG0N8@8g:J;R=+f]gP1;;cSO^\TH<Q
&P4G=,@D1S9LMCHJUKV9XY/EJY<6)HVfJ4<[ROI/ZOB..,>FQYQSJMYM=L0U_XS5
c9EeWIJS+K(;M94XB795UQ\>Y8PaMg1KE).0JK14Ie]](9Ya_[fIBSX0\9bT2K,,
E3AZ@4:3H(Yb4;#c/>=@@Sg4Z#C/61Q@78Gf+BQ6dAM9\D]HNTPKII2D-J]TT@1d
A9WaA?P,&,LGJ-d6e&dUOJE_=M52/a:O+>8GEYP]+F7a;>#e<6c&UHWd#0SDHQLg
7BBc#RT@LI-?>)>(e=L/6Q2g46XXY6TYGYD1AOUb5^OPSL_H5E,<.8X67=PB>MSU
fgYUK)BbfZ:#L&VR+&:R(9TM\.Rg474RDE?YFXG/)_Zc&[g1SE?B#(S_>MDa9\:f
NK3,ROa.STWD616J6/T4CN^QPZ&HBAd&R]Z37CQVYgOC\FPI^QT.&&MA2&&ZJUC[
dA?R?)JRXUL^J:EWf4(^:O:D0ed\Hb3FM0O-B.FF2RG0OH.QY^Ae9[O1NHD1;SE\
G9V,Y+-OBKL#F076&9]M8&.^E:]U=0gf#S>7S_2\\gD^RaA4G=3\IU:LZK3(.a?V
@_GG<[UD22\MOZAO2Y7gSW@H&Y3H&=1XB^Pb6IbI&e2XKdXfK:cWJK=.XLB4DQ?#
YgOCW_EHdS:(HRWPYY/b&f?F/+M=T+9AdQBY]H-C+,LKSIZO.1?G(Y-D7&E8F+1e
e@Y&R@W.Z^L4RNAJQL?d;MY,a(#CK):P_+cK(Uf)@f[AX:X;c#^CPM6LOdAb2?f+
_I3gDaA1EX9W8gE9>37LK2^Ye5eZIaN&89N#V?&SI\4XJS,b+??6RA;+)W)K7E,R
Zg9@@SdSNP6]./#/#(>W^EbHVf.LP@_0C<FU4d07L/?Y,P\E3O&:+gX/FQ-Q_cP5
aX[F>737.TW9J.PV[8NDKdL#+V/BZL7997STCO6HC6.dIY,<Y+2&UKTR]Ffb\.f+
>+f\[9DXDJ?)c]=D<R?@\CbfRKFNO-DESJP9BE\g8I)]K&LRXCLSX1c>(N?gP.8B
3&(VN28&,,^-Ug<NCb#KA6><X7)=9W@Lac3/1XR/g@3c6M0G>,/R1(\fRcE2[P-=
,U-f4c:9N:ZY0Z[B8ZEQM.S<6W#EJ(^-KG+5=4]c]\R(b#,S5]IE(0Ob46.,d2U(
P6;]LBd?c_BD^cf_&H;RDLgUX=,7XRH&6CIHcPXeFS?-^(]O<Ec5?2L]gIM:[_Tb
Z7dQ1fd]@(9[/P#e3fV#XU:\S,Ad@=;&Pa8dZ)c(&15Z2.A3#Sf,XPVT;I@e^a-?
&38d/>RdD+8A+&WP=\-.&K2#H-RWQBBD0;f-c]QT(C:BS;/M[G]R?6W1U=1JCU80
;Ke[^:^]XJRgT))F,Oe/GZDK1MB5P?C0E9F\-MLXbfHdW,#SB(ZMb0CFX0#ddF?W
g57G[de-.,O:]g.cN?IMV9&DV]G<F,@4Bd=@QWV)@C9=Qd74^PXOWaD^8,J-8L[_
8@g(9>PVf_DJ4OT-g4R1_:KPUY,Qd1dFF\8,5^4WMP37:38@dNZ_DYTB5LD+Tca)
8E@0X-JEW;BV=<#Odb,)Df6_BJ)&SFI>N=[8FAb/;NEMcKIB_JPg?-MZL3P\;,O5
+HZI/0)WFO]C.d,U1c]1,]LP<?.?eZf=SeLXCgD@60K<7_SfS[VLFPXZ<N7<NW)0
e?,?T;f73-<+?d6_E-_]dC4c4SfCV0O/1gbX@WK^V(#b-#^XfZF>cPgK.FT:>O\N
6I;3cION+D]<&\[(,d/J249X>QJ4HcLL:Y5FWZ.P1KCCD6PV-IGJK.5Df\Tf#F?\
UEagYAfQJANQ(0Y[.J<C5FWHS,SF1QA0VUK1?<>NdHJ)M9;edW2KVQKNQ?I63E6e
@:d^gVDUdSW>&.aTX:V>gP,eK6VUa<R7O2ONLL^Kg31/H:[T7^6-Ja^GPI:A8X(Y
b9G#B;E(>K@Q4@2eIGK9AL<J@XcUgVAM2IV3d2/+[XFT+O-aEI;#SAZ6-T2bIY:;
Jdc_V[C:B^gASUFORfLFMO2M8-KZ=)aYQYFSH:3>PCWU76N.3Q9/>BN#M7?\dOWH
(6^Y/P;fJKG1I4,]cTWIUX15#DM5N<5YcX&UGg.7C2F&LC[)D+<CAVZ^/c2LCC@2
f,[J14:.GJF>g83<,g/)3AaBKCS1=OLbP:SbZXY6H>7<6Jc)R17&-G1D5Z/@/VU;
.B(eSVe9cQWY:-XCC^Cd1O0DV)eb>d#f[15562Y/J^-TO0C&c8F(,-?Q1ZSFN+6N
YL)1QJ7NO;H;\J17.]eP-aN]&^L>D0<S7bF?d-4OdFVXSdIKUQMFcgG(8+[G3K2;
dN8d2fe4XbFE)NXReD.UO/&YBQ.@8XS4=]_L-\[W/X)/-G&6T..EPTL1:&V5UL5Y
4DbV:,IeAUfVI7I4)U-,IL#CEc85GdeJ:gI7QB<0DXJ<0@QKb,F=P/2OYOd)J73:
cQY4W78##FJNe+8\[ILLV36];K]MV+_?DMGZe)W<DGV]g:.]ZC1\YETVS80=],M=
aEH>b.E_JVQb[P]<8R<_FZGPRL-+1\3#DF8]5R?>RN4(9#C_+CG,fJ9-&8X5QN4c
G]=Z=f0a_[D_ADg&c9&W+I3Ab2<MZKAc<GK6c_,bVDWKO967OB;K#OEWIM#&4KTO
STL=67H+CZB.2@=MIO0;8S;]_GV;1Pg3S6_?DZ=OUH9,D7X#Q0XZZ]cTGYbD=^[Q
#,LN,T@NK&#5.4JXN0DQ[VOb0]OZCNG_,^M=I6;O&HWC_.N>c6,ce_&EG5=Y_5?V
IeCB<1&ASYPR6)LZ5fK,.8e\<e8^bDD2-JUgK[@MH9H/Z\@.IeILY,NL](#.QbT)
9^MP:8@NJZ14:O33d(AaR,<3f617CZ2G2#SYM0D>Id^__YDc5\H8HCb(<^#1QT9S
\>J?C3B2/@B[?].5L4L+e,MS,NTa63KEN5+)Z8M9?c]E<32LYXg_+PEUP6_[QO<F
\VY2NDBac,7S_Z2,gC>X1eG<0^>8\+=HDTH,A#7f5(VMH\bA&57I9PJ>9RRIV/)/
H).)P7+U+^b6JOPV93N7WA9KV>]07[2KVW8.\(TO;@#>?0fH#BSH0Q=EOg6]:TYS
^>F]:Q.J21FNZ4\2Z#5IGTJFLI@CI;&/dI\STCTN:(LN[AM<Q>2.=X(/dd7B_X5&
/eSI\Y]Fc.]_I>HI_+_#[][ebO\5[1Qc[964+9)_&_&3cX2S+e_6<T1;N2a0NOH,
,]cV4:_9Y8]EQH+4fQ0=ZS(W=O,+<Y;]baIeeVBcG/@_NM8<<]SN1J,>:VI8GA1+
4B8eg8f,S)W,N9JZJWY-LgPaYM0#_c4R;.=Z2IPD=S#P;?#RcXg9/.E)+45g&#3K
Oa#4+:a3WRKM+4gW>LVVFCNbNW6g_W]?#dNS+c6^bJ:<8S<K;G\>CLMD-<?f@^2<
)&<O\=?aNZG[NMYf)dcdDa.M@RC6@M<BQB-A?@WgTNQ]59[_PHIX4d(3Q0<H.\8A
CfCc+0FJYLPFX0C+.b;VN<Oa5;Y\NV6]JcVbGdBT[G8=SZCA-=:7&cOCB::Y#=H8
TU(Z8aN)W>\O/R&=]R\V1E^/>Jc@Hc=P75F^dLAOHZZEBYSfYQ^dgSTF?F6#VHDI
A]XQ]]26^1SM6:Xd8,M394RM\&.3VF7Z,&&-2g8IG82.)_<MD\YU6O2+9eWFIW\[
f\IVLU6TM[UUS,CIY2I,I<IL&N#)?B(\8fX/-4>G_U#TWTNZMIWH(KS^A5T@1=00
Q)VgSgdK+#f^EMeG=f7N8e>O)YZN(aP-PfA+9(?YS^:6N?)P)^B#2?bY6/f\1/S\
fZ;#.)EZK5Ja?AANO,fHT@+2QBBYQ+MaPb@OP1;F[c2;;PY.9NOQU/1WRG??KdT.
D.ELY3^KS3_BQV#[HS6)bV:5)BU0/5eOMR@H3M??7CG.Y\:J;V9PbRM1E#LT;)ed
MOAdS.3A^;B0<D_DR5f.-D;;#41E.]#T&9B)V.f#[B^fPE_.MFG+0)gY0?@PdMJP
N=^#@Oe]9,Y9QSf@Y=@,X(>5FQgO(:+<I)/BJXNCa6Sa@7:[[AD_XdB9UY=,999;
F\aId^b;Ac1?_,_fa^?Q]V_9f^WC_Lf9&,Z9cKSL-H4JJ>c06Ba[-_U[U(\J^8/-
+Y)\=_RY<GHYScfMBaAOKH5e+;5&[LT1(]36G;M[)[,PN:]S)7/=>9OX.#,O[PON
NFEb]2FO6Y0gX@XS-NA;9FE@LJMQ2OG2Q4E]F,T&)&dWU8eF&\Ce2f-<JGA](fge
T@9B8eVS>-2S>Ace,F5RTB_Id862fQ/,gb,S(8)MfHaJXW[@)AdacK4F4AGCC;a&
XE9ceHBQT_S7CXUKS^aEDB6a+cBZe9A?3&f\c0<3<5O0?;VI<W>J[Y&ZfS&P?V.B
g6DZ&1;JHLg.)1@8)NSBRBe@68?8+>A&T[XcScQW.P)F?WPGSb0F^\+?\2]G>DG/
CO6c<=[MV/A,JR4D2H-0/QWAXO7(4</-ZIWb?dB+d=CG;RdM:[A3A6WJ:>O4[f]O
_Fa]-F2>-ADZ2XIW7]5Q8TA0>gPJ/:Y-.JD<4UcJad913dI5ZRX;/ZgQGfU&2>IU
K>0L+LG<B^gcfX2Ia/3d3&b^]YNWg)3@RN;,8GZH?9+]bJ-M7\&L(Sd]_MWY?K]R
[fBXDgBf>BcN_ggD81TPD]KN]6V[J[5a^Y]IZcDFd@f68+FAUCT3dLUUgJ<MeRdE
-TU0-NJNVUDK092:\]:)c2Y+7][AQ@a0G(]XSG_7K=]NE/]@IAY2.S?d3g^JTW3b
SHe())24TDUY/>R]+c]?PE6/ac0^J@2aSEV]=O_05-[f2<L-X+Ob/DI_3\K^(cX9
[ITNZJPF)?E/7KC+7GdC;HS@\+aJPZ]B18=92M&IER=1SBf7:OCbb6d2(/]fLcfN
>.#cgWfbd^\gc3>(-QY#1+8=F5bN^KJ6FU-8BQe&a?EC:Z\<6D1M(fZ=K4I/^PDQ
.Da8Jb;J6HW#.=D1JJ2#6#(^SaIJJ9:LS)US[#_K_;_:JHd:D6a2Ec>5OR\2.[T8
aNWb^a,aX6f0#4Ef<J?VW6+)<UL02@:>C^XO4>R:0@@7GYeabb8P>e:-?Z?/B6YQ
F98B]eF0@2eE-Gg(@Hb4Y0.>7_UOCYRH3PHZ4EEFV<,ZX_0O,&aQ[P/eb^Lf-6aQ
^)G(a^P&c0YOd6#T)DBIZQ5I=NE:)E#OI4f)=@gc>V7Q7<,=[McQ3OUgf@OIMU_d
<@D5J)(9BGbOWU0[gf_88QWYFRJ#[#DEK<c#e_H9=.[#9K_&c1=+&?PaSXD[Xc8I
#O0XXg#8+)S+>/=dN7QVW0c:&M2XKb^aU/e@@6[_eb.88SKE5WLGF9PUC([_g8[P
f9;aYDgG(bcb#A#=Z;7F>GU,)9U\G5E4P@WD-CN<gC+FKfD1=WN45b:71116W,@g
70J..G]4:(\WJUS1YXeTUa23g>KK3[=>\CWcFG8DZF&3Y]c=<2Q&U>b=ZS2/CP/8
\>-V:C?#EBL7e>XI24ATHY674-f5R38_KWR2FBBH[KDOf9BZ3@IH]93_\SdQ[-3a
8K]_ag/8<BNM_b:6K(J(1=Cfd+IZ>5NR)=RX?P/<QP<3g+Rd\@0^N>>BG6UMYIY<
KJf_c^_P0U<06+PCT)PVE<eNfAKc)_KTAUOU>P5][@2GB.SWL20>U<I99B.Pa>=6
GZ9:OUC4d]>0E4@Kf5fYLQ-1F075XCJJ;)ORb]49PO^(eB]ef7.d[W7Y.dX.eH16
:P8)[C3+:\OEW+cF1TdB5PD?;,8/+SYNfCZG2@=//3:;.cH_-86XBHb3e/E=#[(_
PaZ-N)+M&R#B[DTRef.,[V]FB#4SUeIAScGJI-[V)e)4JM6R4-gE,431W<P?Vb;N
RCGEEK?A3J=W\fT#G7H^TfDO^@4T(b3O^B;B&#-TK#gQF8Ce(F38fbCEKO^12,TS
HbEg>\MBEKg151@<5:I^cMRd&+b/0JCa&-gW;^]]g9;QaG9Y;P+Y2:D@57O;L2,U
8_8VfU]]:YeK<H9G_AfT-fPUV?QMeS<.a7?aG\cQV&:]Q-cYb#4J(YATO,Vb-2bM
V5ZL]M((d7Y\[_/+)3ESYUe_:+;/?6aCY46SQY5#&BQM5/IXZX/AGBZKSJ(ePO-R
CV6BM7#3R#]YTW71;::F,^T2aC?ZY0(R1\#7+ZI&fGK>1I=1RV=F#O&H6;eb,HS7
fQU=Kg6gc4L:V61Q5eDa&_TQLg<.ee]//UfMeU\M8e]5:?T483A7+c#P&4YQOcJW
WQI_8gH3e9)YMT8dd:b:EJ=C7+A.;M#0_]?/Y?.\YUcXJ?@H4U-Y)d3,@#6[ff^F
I6/XGaG1cF00(8@^GZT5>;#82NH[fbJ2.-#+L8MF_0#2#0C\]CMU)?(M306R)GF:
B[G3OV8SUfMLD,KFcBU,UgET)U0:=BG//(:(aFe\/;>f]49\bBeRB06Cg\.2EbK1
=W.=X1C/f05IA82_I5)b2B3U\E>-f>>.C+<LD-3L]LTT[eNP+4H:101?T7;#:FW0
6#NEMMUX0&>:6SN;FQ)6Rd0;LB+L8R4(gN6@d^F(>XQJ_[)+D.D/6_Sc0JXc@fR0
(B_?^=_3?V.YNTHa:A<f]2BEU-UML+aXZ?05=QLQ(EE^@5f2;dfFV)5LUcQOT<[V
:0(]6IQJ)=EJZ,S.&EUc9-4)GD00<+OF6^Sg+Db4f/\<Oe<LE6761@-DaLdCdT)=
?(F98E]I9YPW#7#bW\+ede80D#UJ=CZM8)=ZK5c5C4]KY7d2.eT?e<O0B<1>X+MP
a]Bfd3S@Sa9R++1VZ)(cRETW6[N+D6I3ZY]P8KO3&&)S0UAJQI+VZ_C:T0\)X^Cb
0UMTg88,4BDeI4Z/_I.+\H_OMK3_4GEM8[U7Y&ISVJ._63^HaS_MMS3Y6@cWaea@
+?e5[caaP2QKc>/@D6f=(bfJ\IaHHWRX_^WOJZV:::@f[X;CZY=ESO8d^f[_F&1b
N>:(N8UI29aWZ7S<e=U2^I.gf:bGTK2g/^MO3IEEC3U@+\c2df)(:>M_C[+O85be
HdXNL\=FU+bH<TQ3O+<U^aF]:eYaN_H#GRd>7#QBb&@M>N,-GD=F7e6JFG2E)c0V
,(3GIeRNd@?/,Yg&/ZeE(/CdLZ60Ud[YSUW=D=1@P6a\;d3/=77IW50AM2\5g3IN
+aBVR9dU52ZZ^@JX).?5Q0A.><:A+?Z@bWUUW8S(&K-<@:1/F3GaGX-R)^]<U2-K
,=84[++&U1JG:0<LOI^+-4DO[dRUMC(4Y\9R\#150WF<Q#4\D@1LaZ^7A/&b6[HP
F?V9Z\L3Ia\MS)7_c5DMBcOA0N/+^>0RPO&1d.3=D9FDCC_0>Me30UeF3WGO<W,?
Pd=3?c.X>X95?eMJ5Nf4TeWdFE=Q&fQXB2)S9gdf)9\DI2NS&7E>A+&PGe2R4YWD
RKTA(@FG_92BR9AMFRB<S7]_UB7@7:[V(;\:ZLfUA_UIb06?M<86SV3/F;MObF<e
0[QR,#7B7=B^>K6\Y#Yac#,:5Ef:9D_.2K:\MZ6QE8\V[T811eABU/#CCE,S>YW#
.\/<V?JKQSE9A_7bX1RR:5-7I#W(IZQT,AP&EcBYaJdbMb;EO<@XB68AW&DHWUc<
M#AdPcJaLNN:((=0C2D(S_d(R@-W;JH>MNPDJP?=.+VfM1I4NDE\QHG6BZ,<edBD
H2UXP7=4CCGbBQO;fE]\2>/02dKVg=SOH58],4MXBX^X9dH<CO-/,RK-e;<#LO@Q
KKR4aL2;@8<+b)@>N>)SHM^Z53BRD\@;VZEB3TbPQKZEeBU(KVOII,S&P&U7XP;B
.W\=KfHA5X^(E#(a#ceZ]W:)[2O/7:ZHX90bd#2<6/-T(g&;=,JQZd>0P3(JaF]Y
B<(B=4gSH5&3AVa21CJ:-Cc.[+P);b94<K[B[(Sa)/7EU>[0edFQ3N/W#\&ZK1\<
b)_VOEV-g&\AFF_YQNg\E-S)#^S?P#2(\L&/<I>_]bOU;TPP(>QDU8bOe,2.I4WO
7ON#gK(Wa+HN>\FMZ?[,LH(]I-=Y#+YMAA#0cX-e6Rg^#ZUC)B-F&GJ2J62+[OEJ
Q8G3RE-AFK#DAAe(>6D&]B94]O;+L5fNgY)e4LOLFPR-X[KF.4[JXCD^7a1N#3b8
NSMD^QOGY48P9I8HGBOd1JZ,EU]<(Gc3Zg?N@FWB)&[b;O4T#5G[IXTV_8HL-+(L
16(W/I2bd9CT&>_\4:N=]0>CfKHHXN,Fc;&^8F=@d+^HAKUe<IO-YX-CAII<RB9R
\d9(5F>9[<&=4)bL;fEKTYdE7L5M@=I9>Y_d5[.BGYM0;#c+<Mf6fN;_]CfW8+M(
,,3Q,3)bX<:C84^)A392aTVIbAe907;E:>Y)]0LcC1Ba#G6BdUR,X_)]gJ3?#ALg
g0Zcb//-e<\b04VdFG_2;g#(DAaX\>f?3C.:L&S<YD^KH_+a#W2,,=46=5_57KF2
a+639&dRX/M#4GZDKS8YJ)]d,;&@0[C8ReC2QM+/@8#OE._SBZ)ceTEX0P903<Y:
D:(.ETaK80W2\J#V&c-_9LHTQGgT=>:@J>6a3.(HbQgd])7cbg?b&(e#\g=f5C3(
1(gD6GM6RF9bGPNf&#X8S4AS&&H(\QRY9b>b;+XSW^dI.G-A7;D?A72D3UP#Aa#^
bNP_H,?3B>)EB[=\1(O-_?=S>O=Oa?VaYS;OT/c]8IC^_+?@H-NRYAcX4ac.-5N4
J(\eX:9/F_9Za&1O#7GCM(J:bXaSQ)\CC7_]B&J4W;[;P;ROgg+\NSTEUI8NM<RS
SC0VO7J)6ZX-_c[&_Q=gI/#b]@H3:_F#AE[,C^eR+7EXb7?X[FGTc7N5L2N&<_Q;
;H;;\/D5HE06[(^AMD67W&(8D#\+(1,.9Q6&1@R_WcRJ<U_B)#6dPgO>/F)[I7?U
SJ;GPSFc=#3L/E,[DPCR-/MaOCFBF^=d_&f<3-CSRQU)<I5bDN-PJ;N=R(+/BA&[
(K1S5K_IVGeQA[\EJZg0HE.C#3ABV]:>FJ0QJfPSd\3T6ZG6AASXG4=b4+Q0V[2C
ZA(9K,0b2MVeMUJe#\FU5+b#6:\e[XB#YH,HXA,_Q8?#5.O8>_YKa&>dbc=D9Wcf
VS#01YUQPWHQf\Mg^Ef]P/=LCgM;V;I1@QP.K41_d7:D6<g\a1OFBf_43L2AefCD
;S3eL6I]GS6L3egP)WXdT<Ug>5#WFF;4SGI.XJ=59f6R5B=\;5O;>+g&IY<P]?0W
fW+3X/NYKBO^/G275WY<?C=E7/.Y3DZRg0a.C9dFc0.142W=\O_M.H/1-S-/-6#+
=8AZ&aI_2U7G(39(_URL3PC/PIM9:(;7,-eYPFHFcD7F:)WX78fCH4XD27R1(CL/
\X@Y/GTc/&K-aJ1OJH^cGZ:.U\dYgb<F=Ga7OdGOe[FN;;ACIZA_f(<J>.^8YF?^
J5&W3<;31b,aWAa<V+MZb]/F7=>]W@0B=<P>A^XgA9]_JQ_G^T?JRM;>Eg4)8LV^
<MHgYQY=<?;7QgK+;CR<6F)9><Ha/DC>J;40S>WT;1Xe\1Z=W]e3OB171e]aVfF)
>P8.<Na_e#,[FcKYTG,b@Lg5CX3-R5e,BBHT&f;;S25WA:e1ZF9Yg+,\<^ZV:<<R
CVc2<<M@?<V,Uag+O>Fff2a6.33=+?HIX@02T\,QLO=Gg5(BO2EfNa&2bIQ<aH0W
P(#a.5&(a&ba8@CJaf4@&)FJP5[@Mc=MI,YT6\bP,;4HgR1JIb?+5^5;Nb&R0Z\X
@B63=_8\[09<ER-&cS29Y(Gb)bF9?2IRXJ+EW;:TZ]?bO[,MaY)3[c)\?.EEbT&#
FgUc(G&0g=EV4,<Be>FAMg[THDXOKI_Ma]^+aFZ[V9&J,]P&[7M-&501a>BTH0UG
:@A<BdL74(+K47+39bP0;,0YA)Q2IL)YR_<-C_5\J8LH@eKGVZP:.PI@B5.]Aa2Y
[QX[?>M\0;Ta,9PMYP_Rb7AR>c]Q:2]UKLL/dL/[\<d9YYbCXS\FL:9_g-#E=/eC
:^6#7\46b4+&B0XS(T=GA0_F=b.M@;A9Wa?-8V@_SY35HEVP-g/FB3AL[UgW)F=F
01XM8P.H31EgGFHfVPf&CcY(gAeRN?^KI7</)8DYT)3]g;f.K[>DA7O<#]?+RV6#
5+?c&UR??^?KR#eIJ@=EZP.(QIWP)?7&#/O-R11=3a3W2<Y3@H#>+/(2,#2F#&7V
bL&SAGUd4MB.SXRf2E3)J-WF=--+Z&ULS49,:VcP6C(U07@KVS?fFN^=BEWdQ;N6
D:LF;(U/F+51);RAD1gGbRQI>6:^.IORb=6]KB.)3A#Q[J]JbC:O6FG#JG\4TJdd
/S]6DK8IfA.B&V-d\AJF2EE(ef4BI)ff\&C5ZBQXBR#-8,S:G#@[SV](be;MS5T-
<K]FgaKH^=f_ZZF/I23Z-fRKD0JT7\7IK&3=X3O[JJbCbb6E_H0SN(If):0^VQe6
f8AVL:ZF[F4S?.e2Q[@(:FJBFTS(H3@UDG>c0DYb=K;baP]19I3^X596=3Z@E=9V
52T;>7:4M),)B)_P_=6+(V.66O;-fNDaaLUY/:5<ALBV+XJV,D;4f0TCG;Q1,_H9
(NHa=V3NJ7FbJE\9QS&3+;0&9B1/bRVA9&,8fCU/LTWABH=VVI@J?cZf]I2d-G[H
YJYG]6:YWEF2=2FET#6[8LDg3MH(,_G?O[\DG0ZHgW#^?DM0P1:d..M1\TJ@Y)g2
U+^-4d[17DSR@E:#H?FE6)[S>0&ZW[[5aX7[0SNS.gN_<Kgd4JCS8FULEb#300a)
dBWT24ZJcf&MJ0f>X51cF#:&RD=cO/:?WN4+>IE=ZTR:7+FR;J=E,fM_aQF89:=J
S@J;Y,g=<0cU/cA2NTb-c:5S7J9[=@ggJA@T6Pf)FFPE;QJP[=Xg/B+bLZ+#O[1R
[]]GFT;R:3TZc8383gPA/&a]SZXLAX@&>Xa93L9EF?NBc2:S0<T,X[H?4I[2LD)6
<5g=I<82]T8K,6(C=:6fG+?AM[\N,J;LXQV1fG5d,(4Jba,YT\UBgOg94P-TU[fE
3E2TNZ+@=AF<B6SfeO#3I-P/PKYQ(STY3g^;NRVd8]&.5OK1TP[>>(6OE@O<MD[@
6T@K-I&R>-?;c]#45<Xc8abN9f&AeC@&6ZZS#V;6VIW;;Ve[9Ee)=>D0eQ1OK872
>_;I,WMPI4gd7]IGXg@BdEQ2R+O^K)_8\6SE8^-OY9>XMKPa0]N8=\J[4A?#/&-_
5]+723/Ue>bL9U5_R1O8/cUfA8K8<>Fe.g&S3E9,[YgU?f[2Le6?+>3IC3\1gRG1
I]Z2WCB<XSaF6>4D^)77e@V4Jc\[>:&?1/6(OFNBGQ:c<NB]a;GO^2^ZSFD;JSb.
R_+6]]RX8RdTF^#0@_KTK(L#)X_XF=g_&0HF0SG2/EYJUUCGgD^faS=1Z3VC?8ee
a_D0bAMGS(cNRM(95HXXI;I@#7VK+LDQSffC,fZO4D=^E5+)2O(=d#NM0Of;9,AW
D-;e^b]E>)C)RAK/__/6T?P^S:F=&9F[H:HaEe+IOfV<Z@)EA?MbHHf4R_?K3?af
BMNP4XSY^4P&>7I7Y<HgRK@[48&K0@b-\./;C>cP^BY;cO2ML]DS,D=5MQ;aYU77
NRWQQ\aH-<4PF8YD^S]eS]+S1/ddI7afZ9SX27Q_f^;gZY_E^b1TDM(7KI59/Eb1
BX^,XON^]\I_F0T9dUfCN^c+2CFW#H@ZZ;aZeB6OS-<5[^Rf>,^ZLMVAbN)&KAe8
NOSB4K/T8PCZd-O<\ESfN/]8OC?L&NM5M_?.F65KA+2,gXK1.a-OG_,7BZ2?67e5
5,T[YYIH238@S#6C80LD0R=-C)YAc9A-MV,PZ2\bUQ<:WP:.3<VfGb=&@^J-B9I\
6[BE?Q[T&T6DRL[A>LZ>d4#>a#)83K+A#QV5M1R]4^,LT?93fSC\dEF(#Dc+,<N9
3.KdD4O)6:U(6P)Se1&e?,a-?^;)bdJVS96B[:NIR[;U-C=H,PbM-<R2g&Jf=0E1
NVFW.\Y97CK>cU/7(;[H9<R<f5B(\4=a]]GE]BcFdNdIHEL0O:bQ04AQ5V)^MFX.
A(JKeB]\/RfJ?MG[I,EP=/\2N<<UgAB7DMOH0&-]b87@2Ia+c5[.5K9I?8WF4SVU
2&_/BK0]I1>FLKKZfSZ5D.#6NdSX\IbA8)]PGNC9^OfgIcfC[E8YcB-BQgE(,+e_
ZXbY+)TNe#g<Lg1@B93SbH45gY7(g.>T+?#-@E?44WCJBD_=YIJE+TG<BJe=K>a,
b@:_?REdB]d:./TI4,6814<g<87+:e86Y(#MAYJ8)MO1##UOdT:LdEda9TIbL:XQ
/Df8a>(d0#6[-e<<J>UNJR9V\L4CNa;Z><K@PcT68/(P^QIe\<EM;SIC3f-;PNb:
\.Q@^HXOA(YcMXAYd#IQ<UF7BZTP1?BM/1AMJ>HPO&F>b<bJ@57,ZW2/bB2I5WM1
C[FYLT]H6N^@L.&1A2aHKT?O]&ASVI7SB),3L_U^ag==));Y@;f+Y+:ZdWNI-,g.
+DfA)-;-1HV]\QJ,0FS4Z(<_E_6;SBOKXT7Q7E13#^N&79T<L^C1E>#c<_4TZ=NT
06X5+LMG/OMU;R.(g;#,MDC;_AH#(5M-O/J_Y7ICbBT]W?B+DEPHJeLJRSVeKVVC
d,>^2VU;DW4>0_9f8C]eXf<dO4bBg/(B(-5^R;S8KAUC]#_O/@O;NFG&WK>4[\G5
[Z^b2)+OY5<bIZN]DKF()EI-P?^->UXA)JPbe+++Bc+b@:(6-(OJAR+0^aQ@aVAZ
4L2DP+/BP^C;N+[)S?AIf>eOe.=IL^eHHJ#X/#d1@\)ZQVe7ga,(SaZS07T=CA(1
_;#;B#2J^284L_P)P5=Ze5S[g_1?I8;AY+OC3^:/XIO8d)V7OGVKaL:J9-fHM)9M
VbDX1V&\TJ,Xa&e\?K\@MR@WF[^g-&8BIYM?/E#?D/=I-M77P(]_&I+<S#?=/&RG
8UTNg;gBddX0aK.Kb:UY&;KH^07?/eV?e8JEM)P8EPd<6DF9-?I\C@_/4bKF,;FP
eBO@:4A;J23Id6P\Y.)FDMYP;/a<Ec\B6@&eX:2bX;ZGZZ2(S/RFO,1/<I4bQS:A
[/6#3H-<SMWc:9G>6AS)+/VQ_//=f&_fgD.ITd==P&?GaVE&X[^^edY9IAXNO998
AQC[a^SA-8S_c:6DR)>=SUGW]P@.&)52M#Qcg-]JeNGg(b:)dBXaa,6O1V+aHPA0
\8+SP0RVJ,GEXM\AO6</fRN]BCZb\=P5)\EPVZT1)eO)D>+dR1F4P6_ICC\5Z43T
eaP&eBB=FK#E_[I9:5A<(9_V(XQZYeE?OBB&O([=BaCAMLP3XH<5//[>#1Q?^QSA
CVJSF&SfYg+>fdeJY7f+9(C/2WC_Y3JfGK;).;7\<f4S?1(]<S<f<JbGf=JGI?g5
6#8.aT5_5N+Ha(>WKSJYWGAVWXc/6IdO+=A]IfO.KX1Z=C#@&dd.=_2R7D405L_C
U&;.?g4K\_M8SQ,P3Rc^4AZM1b3+DF]@,d\+^<F6Me)A(+e67Edad(@L:Ng,O@K7
]W1U?M(1<S6NK:1Od34JG5K]7[SHDCSX\e?HQ6Q-NQ-?:f0;KZeL+H9:bC]6-<M4
@Ng/)P^UPL=^<EAR<]V6/KVL\bE@(Gf\Te]+\CS.H\CPOaY3MI3gPgKYCbJ.)7@&
SBY8ZZ-d6^NEKH)2CH)GU9V-B>A7VBP(.>\0Kc68J3<3Y;L.;6caYT33^20dfE)D
a.Ea/)+1M4+=)BdB3YNO/cK(GCMPGDdIGJJ7-Sf#Bg>T#,WO6gWcDOUSCJ+IbCS=
/;[4O=9ZD+^g8&2_OA8?@^^YC//H#ZA-D4R:NdDJB_a0WV3FFTDg8a/fI07NOP0b
^_GC?./I].&A(Aeg.VJ1ASB,7Y@Hd7;GDU4K.]-6#cEY.K1aUbA\9Q8VYP]_5WF\
((e5YD;ZH+MHAKJ8dF_P2K+;0IJ6=g>@8.3gN+\f3#,MUM^>ZGP\5LL\KeR^OOVC
I/P-:X;H?4W>GNAe)<EMOX()TYK<Wc30DeZ0e?4G/K1,;QROeTEeZ<RO4-]9;^+Y
HLC\>)3ddZbgPSEJCXG0N(F2M442.I4I]F+A&2;7^J[9,;X0:D72W<UXgJ#2:Ibg
>HB1RWa^4<B^XKS:3>3AQFAEY62c42HI=(OYbJ/f+Q5BJ(0P3+5VUH331fURZC.-
&2&<b>]S5KP26K\-E1,26FXV,Rcb-1J?+Y9C=M(eQ6E0BMPZdSb^WX5WB7e_aYV]
WN-TM02cIQBL:3Mg:SLH74SW&^=+ZWU&B6HbaUMTYAOfBaI@\J1DO</Q>:M.Ab_:
B]KVL1CU;8)WXOFa/b22[+eFR2P\/c-X?-YbdM\1)[/J<BUNOae[Z/DBA_f^e#-a
545([g0Sbbg;ZB=14(cGBLbCSBC@XVd>8==N_@=DB-db6fGH>MT(2C?<B9^@D)Mf
]+e5KBD-aZLTHC2Xf5f&;RSJBFG\10GEQ^\?B<+XB6G5=486d\5,Y[S6)XYcDRH;
0=G]@&4@H,3@9)9BJC#N[455&a?bEA->59#DVA::dD9V4NIIge<egE#X)B.RJ[)/
O5G6[;W5&GK(A3d]\g3gTdQ94S+a2>O(S/b:BA-f(f#dRSI1\U=9S4,R/5ORD?Kf
BU9)X>]Q0+QAbEdD<Q30A6g?PBa-G\K@4ee2P->RbY)4:;f)aI:=V0PeeTP,DgX>
=9E(SRcG.G>(&F+[.4\Te.V8C(dUZXM1OeecWNIe-;EWGYJ8:I6/Pf5)--I^-b<3
Y9K6-(RXEHaAg^ZF]_2.^<;-7ZTZ0(=U=#8Y2@P^>8V.D@+-T+V@=&HCGRO.=GMJ
^?TQXU9S^J_O+N@O<f6V-d-,&>?7>E=>1U5^3g?=M3-+BMYKMc#O/)5Kb+NX_)Kb
AT^L.C-ND-4TVY8bPE)156Y^-?+,(2N3KJX=RR3+f0CD#fMg]9M_OA=I=(RX5>T0
L,_b3K/LB>#-/IIKR\3gA[aF.[&6f5CJOK1(OM@<DaWD\E(<d#@B:J?M/26S)7,B
ed)Ce4>@F7)FH,2-b6K&[f_\7[0\DIQ.,-&b.fADX83(1PE>>5>_3R>Nd-73PJ/2
2<Ld@+V/,AK,fNB7NeY0Y+8/f;(YIf:Hd<bK4CI^VO94Z(@ZM.E(EIZ_FICQW5YW
Z?^>XN\;5b/E:;NRQSa/T>5+(>[SH=:UgI24TUPDcG;UN391S7b-->\cJEHPd-V;
e,IXUTgK8gLBI^=][/<1MH^H.NRV@_.KA#8=aHR>U_>.fL)F3^9X..ZdgRWYA6gO
f+6[/NDG>-a4]SL;>-H_HL5[<+KfcB+0\;GWG^TD>-YXa1/f;PP-<S:EEAfbW8<c
dV6IL)/48WW-PJ(e\98:be)]:I4F?a+?CK67RG=#R#.?+ecMb&L0(9/cE]2=5P7(
:c;RB(\-@):P\Fa0T;NIBcV2DA3Neb.NgL3bY50ZR+W27]/_e?QY0[T3-g[KF^<1
/_R0eb;K^+D\J[QKI]IU&JcB;\bQf];5@8_\_7d[,92Hg,:3TSd\]K)BY464>V3F
MHV84<]MGX\c)ENR6CX.0(OIC);3Z[GOQ=4f9c]CO+9RYRB[1A;T2#<35#9J(/.@
/SRU)VJ]QWe&HR?36>KV4]aMLER/3[O_>:b/@=UDQ=TQ;e\-G)):YPgO0;1N]Q3E
c4=J52)L5cCW]ON0@6d>d#(_F0\&B1.8H72/I)fE_f_?0\SQ:LJU)EOg4[^V-)\8
4L(<aTOJC>#5NO76PCGBT)(VdMH0(1XKO\FD:>9KTAO88<b(7(BB(#c+NQ2P,J-5
/-KQHXA\JHAYRE#6bAG\-V=d^KK52Y<^7aY(&,b+8^7a6d_c>A._Yg5,\-\W^Od1
(&INVbMPWA;Tgaa==LIMTfR0Q\Y<(02XINN/\f7.aUdS=P#I^(2+-1FEg4/PD6O)
[f25,GK7Ca4\]/1@f\4e7g7=ZO^Y-6IN1Y1a^5Y:+[bTeCbO7-F4PNG3ReG^6)OT
JK?D0E?:TLVE7eHPQ/[ObW[9WIZ(#<fPZUA^KBEW(0(caAbY0QB3\TM>B61C-NS;
G+J=W<;.1&AAFNUN62M1-O<,&V_;L=g^)D4KIAf.=&-TPNV?+eMdcU-fW,NLCbU_
S>;(e63KTJL=;IH#<^g#Rd]O+ZLA#J)P+;=)+]&L_3XA(JIdfEEV-@;ag\P2J=;:
+0ZecBg^619P8?Ha/D\,c&A/YB@BNA9,XT]=OEOe?R<>8BWB>F.@1([7gPM37:Xd
9,UQg-&XUg+L89b;c[2T7@=3T]QGEW^DL_.)4GOcQ-(G\N67^<?aaS71\FD;JN?X
I&M_368^KRNbf]>60Kc1E6K-1EN[IMe)>=(0B]X7g?3R88JcXg[[5b7N.O2T+a^6
eRNJQ8N1G+VP[VLQHXR2]5LHO2.:_B]CL;IaeCS7]J1(JfbBS>2QUcB:a9P9N1>N
H[;YfD-HW>f_)3ZUU/S26eRT\)F:TE:g7JMI7)Fb=Q],(#QWTG.P:U=f>&/#-#fY
UEgR&_\,4GG]B9WJ_(FCS2;N9M:/UI=+C73\e&BAB(UY4;:G1aBKf,L&.,+-a;CO
D@fU28.K:0I@KT0RG]b7)YM=9V2/g3P6BBWUb8aLR#T_8dCB6(UZC;UX(C:a\4L7
E3[H&\-?JCYg<20aa4gBWQeW>g(W90T7_4NI;ZG011728S./<fYE>UV=)f,bb_VD
L5&4=OWJRKUP59O7+;]<]H66(d=MMf]H)PYOe_M5YWKd/=L3SV<8D=/WF[PYG/GD
5)5G;fcfL+O1UZb6EI+N:Z8>#,,=fEF6baNK:0W)cdd6-;Q+NCNX[:=PDS8L?,UR
D7eU&8Kg#_9SBX<,35-(TT=+X?3VBf,#:)_dX_C[-8IB_O>E-Fc-c?YZ4?WCVI-P
#g-J]F170=76>_&8.1Z#?Z599RD@30E@GTY,\>bc7#56)&:_;0@YGV00cN(=7<-2
2@2Sa6^WK;27f@R?;T2T;fIDcDM=e;4?525SQP=dH@e(D3;O5]d++7A#/EJX51Ob
d)5+O^7M3CU@0Y4:bbFDIgSc)faUPV_d)8[DIL_aKO(0R)]ZPC85788a?IbJ[?9D
#L24]fT=INB-3HF<a1I7B4_;\Y7EMNU+e;SgP)EN_5RKUQUKd(87?,7a8_NS#H&S
G[,N+A3FKZ]P:A5aG42(KS#7=BX@5^YU.7XBW05BcA_CTT70LLA]e^e]&;F6^Egg
K??,J],O^_JN0F(cX_?J96TX\O#N7<5@QP2R/(3QC4[f5,0AEWWA&80]8^&Bb@R\
<<:Q-S/:dU&@(_/]9YKXUC(JB_B^9I:_P.SO)2\H7U+85+,XN37X0B_d(-d<b;VU
IG)1]JA^2[+R7KV=fKRJ.D4ARG8&d]#,Z1\LI1</[1MT/BJ0PCa?KDT,XQ=DRF4O
3@<X#@d#1R37G>70FZ0_B/ZN]2:LcVBKXTO+Tg:T;:]HF7M-D5gNYA=M9Ng@YD=+
g-P<:H3b/84VYW+.68DK\<1-#/+[V9-46?JVQQ,IU7JJ&62O@>9&]A<MW.,CW&Y.
S;e:T:cRT(]8H^Ya.2D(#44V^:,eU<-5>H#c(<8+4Z@M[Q=&&SE6+,RTR6,,\&41
WQdBc)f[46<0F3d+YcSX+4P>S=Q5BDCHR])NKI3[9_.Q]G+[S;Z7J&^?b2MEY3-1
IC^6NCM48;e82<10bI9:c76TL?G/[)JQXbgT4[+]P>dBe.g)[Y-X08)e=7aFY/JB
@/3(.J[5TH55U15O4D5PFX5K6UbaA?dA;3AQH-JQK8I&e>MPO,X?b?)T01Y\a0Cc
GMXSfUS6?;]eO?P^,T];@A\>(?-Ub(b6K6SJRLMHb4:P:-07[gEJCRD_8T^T^5<>
=.FDO,LZI<(Y<M&YC]RF.2/Sa7<AM+C=YV3=L[c6O>8?NDN0^YYP>TZ#J9QTLRcT
P-:TMa@QXG=O@\=XS7F=9<3L#U_Z6bd20SIN&Ab=X[Pc2FXBS&U7,e0&W&0)3GVJ
1[BA<&U<.=QU/L2C9Ib2eaC,VA@3E\a#aT:2+VN0.#SX<,DAGRC-^[:^RD-c;d[S
-;IP40TH,g+J8^W:/YXVVcTG<K3)4A5P-.[:5BU15cF^_CNTXgC[5^cPO,faRc5b
EL>EDA-UY>WN-g;A:2+X^OdBI4G<JD9_T7F^<(E[d:fH1=c0/J1EEN2R,BN/Za1W
)g,5-_Vc\.\\[X)^F4Cd.4LP_,8\7MY<LPM--DK92&L_)WYFgB^dEHdMKfYdDYL3
@D+^.X[\VVK7J6(>EGVS8#V.e99QQGg_P8dMGO5/BK:T0+fa)U6LF0@:+3#.V+6E
2@B8@657N^019153V,,T.03cF6_eFf7@BIeN_KQ+Cb@I/CMfe&MG7Ad=#&4^cV/3
ZXM^2YeAgE)O7gdY6PH(a^>I\RPd&2=P52@YL(_U\^7Zg]<XJ)SS:eD4NcOaAFB+
K[<JQ\/KgN=d(-W0ZK,2RS7=1./LPAJD?M<5U;YdE?D\g8c,.&5A/>4f>g.Q8H1&
b&FS?I<J3,1W_LYBXKZQHMX-P^MKKMe&Y#AP?V[Z0EG2TgM(Db;I_LJD#]C[Y7dD
;QN13,:dWS/W*$
`endprotected

   

`endif //  `ifndef GUARD_SVT_MEM_SUITE_CONFIGURATION_SV
