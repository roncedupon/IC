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

`ifndef GUARD_SVT_MEM_TRANSACTION_SV
`define GUARD_SVT_MEM_TRANSACTION_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_mem_sa_defs)

// =============================================================================
/**
 * This memory access transaction class is used as the request and response type
 * between a memory driver and a memory sequencer.
 */
class svt_mem_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /**
   * Indicates if the memory transaction is a READ or WRITE operation.
   * When set, indicates a READ operation.
   */
  rand bit is_read;

  /**
   * The base address of the memory burst operation,
   * using byte-level granularity.
   * How that base address is interpreted for the remainder of the data burst
   * depends on the component or transactor fulfilling the transaction.
   */
  rand svt_mem_addr_t addr;
 
  /**
   * Burst of data to be written or that has been read.
   * The length of the array specifies the length of the burst.
   * The bits that are valid in each array element is indicated
   * by the corresponding element in the 'valid' array
   */
  rand svt_mem_data_t data[];

  /**
   * Indicates which bits in corresponding 'data' array element are valid.
   * The size of this array must be either 0 or equal to the size of the 'data' array.
   * A size of 0 implies all data bits are valid. Defaults to size == 0.
   */
  rand svt_mem_data_t valid[];

  /**
   * Values representing the base physical address for the transaction.  These values
   * must be assigned in order to enable recording of the physical address.
   *
   * Actual production of physical addresses for communication with the memory
   * are done through the get_phys_addr() method.
   */
  int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
   
  constraint mem_transaction_valid_ranges {
    data.size() == valid.size();
  }
   
  constraint reasonable_data_size {
    data.size() <= `SVT_MEM_MAX_DATA_SIZE;
    data.size() > 0;
  }
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_transaction)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   * 
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(string name = "svt_mem_transaction", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_mem_transaction)
  `svt_data_member_end(svt_mem_transaction)

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
   * Allocates a new object of type svt_mem_transaction.
   */
  extern virtual function vmm_data do_allocate();

  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. If protocol
   * defines physical representation for transaction then -1 does RELEVANT
   * compare. If not, -1 does COMPLETE (i.e., all fields checked) compare.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.

   * The basic comparison function is implemented as follows:
   * For a given bit position, 
   *     If both sides have the corresponding valid bit set, the corresponding data bits are compared
   *     If both sides exist and only one side has valid bit set, it is considered a mismatch
   *     If both sides exist and no side has the valid bit set, it is considered a match
   *     If only one side exists, and if the valid bit is set, it is considered a mismatch
   *     If only one side exists, and if the valid bit is not set, it is considered a match
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
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on checking/enforcing
   * valid_ranges constraint. Only supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE.
   * If protocol defines physical representation for transaction then -1 does RELEVANT
   * is_valid. If not, -1 does COMPLETE (i.e., all fields checked) is_valid.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE is_valid.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_size calculation. If not, -1 kind results in an error.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE byte_size calculation.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_pack. If not, -1 kind results in an error. `SVT_DATA_TYPE::COMPLETE
   * always results in COMPLETE byte_pack.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_unpack. If not, -1 kind results in an error. `SVT_DATA_TYPE::COMPLETE
   * always results in COMPLETE byte_unpack.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
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

  // ---------------------------------------------------------------------------
  /**
   * Method used to obtain the physical address for a specific beat within a burst.
   *
   * @param burst_ix Desired beat within the burst.
   *
   * @return The physical address for the indicated burst_ix.
   */
  extern virtual function void get_phys_addr(int burst_ix, ref int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX]);

  // ---------------------------------------------------------------------------
endclass:svt_mem_transaction


`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_mem_transaction)
`vmm_atomic_gen(svt_mem_transaction, "VMM (Atomic) Generator for svt_mem_transaction data objects")
`vmm_scenario_gen(svt_mem_transaction, "VMM (Scenario) Generator for svt_mem_transaction data objects")
`endif

//svt_vcs_lic_vip_protect
`protected
,)?c:\EPa-+UPcgW@=<Hg;>VLY:6S+d9+b<37@75,QBdDG/b2)X4+(@eT2S93RgO
\-JN3Q+9_Ta:??A047FA.>#Zg6af8=IM[6,(T@QJ491?I[4N@)4>>bET8=3;Z?J9
P0X2G6\8IJ9<[Fc;6U]e0g\AJcTD4Gf39(.]FMbg<efL1\9@GaITe6d=2@-df);2
TC_6H]90+LHE@/@&_HR(._3WdL_?GT(UJ.LX=Ga33&=FKQO3\O>D[SN=B#8f&&@E
^fK:Ia?4Z\P(Ve5f-<XEVF+ROdRU(VdTAE0PDSJFK?9GPOc&NOEFCcceKNc#;3g4
2>?LgYgf:#V-@e?dXIP1Q\J[CeQ2J<:fKG_1YN:1RS0Z+/@CeB2fT15YSaBV7M-5
=fNJY\ZgCU\LCH<1,ZDTZBJNaC:F]e>LX-X2g];Q[0?;#W^aEK4I0a>EA<D2dR#N
#Za>W,PY04gMA^=&C97^K?0YOgeBMEB4,?ZN5ZQ56IPYO_&Y^gE/QYg1/;ca71-b
08>Ac3:gf#AefL.O>Z#IW=&-S:ZF8#dc0[ZL.)?9aX0f_:E;DFC&?eNWg^adS_&C
>#S+S3XXI,@fZ062[K@A5UZ+5TX+cRY[I)6gME0dPSJPd.Kc,(-1b^T[8.,CN2+K
0=>351c5[:?<[NLQ9@IWJ&_629+5JO6D2YVB>ZPO]fcQB]O(:>QF,c.a:&R&=dD#
P4[C\c24XWGeVY&Y,cHPK)7JZbO.2:V@L.<&.)A9eNG:XWZ_&-OdI#\d/9bUAgDf
>(7U+^SZM]e5OA]-]3FY)JU-C/DTLC=P,BIRWTU&U(2:^EGeI[;1,-M=He<L)_3C
XdJKNb^FcQZD:RL5JX]KadG]UML89<gP:F1g?[LM8Kf#:&d=PF39F(M]#HVZ7\=I
PD6<dFBS2LfcYYAQ#XK]>@:Be;D2WY=SNH#_TD;[4He3)E7d7Cf7:/GF_]09D.aT
#-9K1AAKTR)d3ePJK6T_.[_N-f,TJ24b9$
`endprotected


//vcs_vip_protect
`protected
UH4ce_AE,bH1_&,?O8TeD;[Pf)I+bgeBDe..W6W-\]7Q_UL2F.1E,(M?4&\+Gf/^
Zd:eI0Ng;4:41T)Od@,/2d?0L[9_?JBB2+5@QD<Dc2D,YM.OC[#XIbAZNgYO,ZgY
XYAU9@78AF@@0eK2]1Lf&b.bH:DVU)]0A+9S[V>YZ^g#4MCQ206A,QMEgEaKb5\K
gUb4:]&@;O/^f3.RCc0EB^6MG_LR,W2Ea5WG<IeRU&#&)OQ?HXSbEA\OY@_&]O(_
(@U8#8<\Ha):2R@(-a-<gF,Sd1gd:_N]7Z8Ud2b;CZ4NOLO(RcC0g&fV9<3d^3IT
.f>5\KDSe6D7#Q-^I2:<EOaQBRK<;e8(T=3JWSN-Y/=_22YePg=X0=B[-;I5]VQR
?W6L<0BcRJ[cYY5;,:Og5V#41c]41_P=:[-F9>f-+\Ndf1)4Z?GX:++T^QUNa#gI
5;[IXNf;OKXS9,=ggKZFQHB27=dR2_J:U/PE&.#=(XLea?FfJJLg)1P]AEPeNL,8
BIUgXA<)4Xf2Cbe+;g_d8UZ^0Ha.HY@W5Q9B-L\>B(/H\QH=-BY]CAA3O\FgMgTf
L^U]4+^^ZIN==E4d,[/8^#]1<,;D-IMAMNZQd6LY.36:BccB6(/67NE49/P9=6/3
(:T,C6g#OG)#J?+b3fOBgg-G.2S?O=L-D3X<(_FIg24[Od4dIXWJM5F4R=AI>K-F
YTeOL^R3=G@ba2R@4;,=_]gJAO7:C:4N05.IT4^c@(dTFdX(@LIbE&dcDc)=e0S_
643@2Y3RcC\:/CZCST]O0MdW1NHP[FPA.+W\D_)86WA/3L]S/H0Hgg63F8^P;SV[
0aC]2<)([-VLeg+a;EA2^Lg?=OEY#LI],^0@c.-6J>^MTbM,)&.IMeEeZ1SdaL6b
\QLDM3f+QZE9a^JLC0U.<]&/O@W-fg3-11fZ],V93+5^M@\QT8)Ue4J=_c:<W5b_
8/AS6#J0X(^5IC7\53)87XU4O4Y,UA214+7Y,K9d+fDTTBPaeR\F,7#<F_FM-RM=
_1HP#VSNR<Y9eC+5JX;XOB,U5-6:<?&J0bO30XgTF]U-<1_JP=<Od&U;OM378&eX
O@]]B5TF_]GgQ7,TNOJLUIQ).\PZgAAB-JGND14+PN&2^/[U3gQ]g\=L(JVF]5Xa
,_BTc[81_C(WQTZS88IQf_6J?cH[++0Pg/X&eI/S,J)P+6Z77f\LLFV+P)IS/CY^
8#\60)#=C=;I?:O)1G:cegG/_+?gQJHLg)Q2J>NF9VR]XI==,TdfPXLI3E-aT&\@
77_/;_L[cFFU,D8=(&(5Sa[I=0RF6NY.D=98Q3[?Fa.?A6KX:[6N\\2S]VA)5BSR
\9)&YG2=7c[&:6Cg72971NTMcN3Q:UY@^3PR34C/=WDX?L3R+<\NRgO;1Ja(72,C
3E_aX&/cV)-ZM1IC?TA,:.MOW0eC)=L5P[1b#2eGDa&8>^5gg#\,(I-I78d4eX3d
_Pf2&X[(.?_ag=NYD.5,K0Cg[C:5X][6U:\a9/G>cbT8,fP^YI(/IVG-D(c]QcHf
Nbe6B3D=.Dg6/=?g5T&M/OUYYK3g@/8),WLR4Q;61M:2:7R7Ac_79Z;NLMM(8@;8
N?Z&AO0_V/V[W;H(P)#Q^8UaL\P^RB>3_^XC^JL83IPGPeLVF880YXJ).[U8bN0(
=I_bSfL1\;GQeK6\ZaKQZ)eLIV+;A,?3Z2f1PHN)U[6U1LbRS_F;S??W(:;4bWC_
NKKS>E\>4\N6)Ob.[1I_JA@2@0g\^M,aC_,de3<.(/JI7@JN-C9QWIa..J3,#5aN
VJQN14C)H_MTd]3b-?Ygf.5Sc+\HD6#[bc#YUY]3ANU0U,/,@YFFX7:S-2NRR(c8
/]6T)A.\Ea]PQO_]1Feg0Z&.b9+QY]PU>07^NYKQ8C^MS(D>\)Na><NNSGQU]][N
4(F(g2d+Gdd>DeV>9]?F/>>,Gd<XB^CJg(J7^3]8/bRN]9[W2CL;&c/ON#A&=dC2
H6T@6,FH/\VRZ[6dC(+IK?V27g,_1aG8<=]2-(d-HKLY5?MCH>3AYdK,C]>a3C,&
\f::0B#C?(C,]ARZ:I/R)B4EFKLGJ>]Ha)ZfIQ1=g>,g=C0#)69L61Zd+94#EBH5
fWFN\JI&2cf\5BHfN\,a2S,)^Q9C3M\>1KM&K=d.H[W?1U-:gdM-<(<7CY.PQ&O=
XWYX(TZL;.;NfR=+#+(6W/=M-V)1+\(A/=:;1?AK<P:c/JS@KYY;Q2e@=03IbW>7
TY8B8J/YRc/)e_6UfEM8KRTNZeQ0SJg\H2<.^425]IISEQF_>Ed\Z\b>^W+/1(-b
=3HF-LafRY;](:=S46[V5G:_&QU^WOU_]e&TDd,,,Sf.DJSMc2DDCZ^_S95]A<Q4
f;DWF2b\S?XNTL:6W=-TaaO^NX25<4=\YUT,T,SUT<-Q>\I=VQ?eHS:0f_(PX/A:
g0I7D&NH8@JRA\+Nd77Q9V5V]5GJO.,gNCUAQ?)+Q:N&;?)PM+W70MFRJBfcG#^d
E]-fJRf2SbfQ\I.?C.@J#[F2#E88b=Z.?G;PW)-&Ee)0/HR)U/R^L/T)UgaF:U#G
T^GJD1LCLIM,<MS);J,HA/O,199\0g4^D&GQ#LOHeVTV;J:=AeMW=BKHK+?Z5DIO
4f\>ADB#TT_ZUW4bL-+c+?0;)__?QJ9A0g2E7D^MG<X<F&-L=5>#DNE70:Q@7P#B
-EFWDS(c=g04#72W9VaONeMQNZfH;.O(SG-KYeYXaVK<6II1I:e8]g@QP0N000M&
BX):(aPYQ7d=1f31d.?>N#_PN)]aBDQ-R=AP+3(INPX2/?<<1<3[@(CAG6U4@(CD
d_1[=LF]7ZFb#J+H8;0KAaB)<Wc/.\@6(62S3aEB&J48#\.Hd^?8ec67IGg(I4(,
5GH<WgK2IXFe\90OgcYW67BKI_<GUC-\?=,=_f[>c;<-U-CV7QBd3?g&=-HP6R-#
;OJ/BE1Rg\b_+6\ab:fW:bNHKf2^[&SQE<GMOIKI^cD9,,DD]TaQK<b<b=SBd/>^
>5c_M#eC#ZR..3MRa5_QU;K,A#_KKR_c;^L)]J[cbQ-IS3+6:G;F@Yc,IDH5C&/V
a<IfDNAMJJ3IcPW-?DT-1KB0Pc[e[IIIE8DL\D[EcL.?_fM<3,9f0ON^O2HCfWZI
]U:T59DKe8,?Hg=ILXKgM7A6A^^R<dMAb0LB_,MDZ_cEF[B^3RE:.MaJT4_1EN/X
9OEP2FJeOI4H7a5Y)B_QEf-,)JV2M6/,,daRQS1,=Na9XI6AX[<c4H,U7X).E2Rd
fWLW,X2[e(&05I.FI0V+FO/^+T:\A6:=X0T1]G\^MN.[,cEf[;3PTN(R]&WXT_X8
&b-[WLG:T;_MB/Zg>JC(>:OY:H3NS10g\?6Y&\I_GggAH]PcK2,b?8EGA</)eQ:,
1d]^1EbK[MR1gLQJaZ[OWO2N,+J0Q>gM:PQ#UG&^DbX:@3)CVW9_)MG<]U<WZaeJ
@#K&Iba&P=IJK]CJ.-BX@c_U6^EbK3Kb#_L1O9#NX\A+XbT728/)?BMX#G=1#8c^
g.EG;X4]AFR<T8e&-c8W0LTC@]7b_0c.^;SN/b]5<M7Z_O@:KKTT@<eF2f)^]McR
<5e2b=BGa#QMVVJWEef?@a.B5[1f2C9QWM<L2>JQ0ZQNaYN705/cJFVM)Ud-X_?f
RI3.Q>;:=MVC]WXWOCG=:.2YOf]bg-_B,)d9(,.9&DgdA_LSXMf.f]=.^b6fT6F;
HRXN4BUgHg7\BW=[bc\3=D;f)cI^e)=@)+BN-0R[bM,LR0G-Kb9\PG7U[&Ybbd=Q
890ec\#.11>09R3;fZfTXV4Q^>8O6A6XJ&4,J++GN;R4^YY2Z+f6aGTQZgR&NO0M
K6+P9M2JO;J\,+=3Y9DF(:6Da7IIKVNWU?O4PKe,;P64R[V5YJ8FG>LI95+=c]PD
Ze&,(>?9JD_A,R1B9=,V9C)@=?[IB)fR4>Gc6^WUO(FfGIG>=6LceL-[3=09Z;MU
Ba\3@8/dE8SUM\GH4^<8\&?=U9S+)19X)X;;S,&S:QSLUSY.(fUDN)0Id+-F=E6G
g(9+EMF&U=6()aC(@<0[)WeN/7G3EQZE6N.0d0PPYO9WH@Ved4/XTA^D=bDCI6b/
2F+JZD?0=..TN0]D3^&;X(a/0?/K#NEW98f_]&/LG8(RD050-+,6,,A>XZL\94Q]
HSL:R@S#dAMdUAT^CY(<c])MWPJ=(\JR]NOBAg1LSKOYV==gBDb&2g15]cG1OdP,
2c)U-3bG\b6?[NUH#5=6JD2Yg:X>@4KWYc=:f;BY;&X@,9@[aaWd#3=]ITEM;S=-
)^eP[#(@6[0fP@\:_\Q9O7C5YTeEII8..><>ZWXdV,(?8R0FP^(Q;[>/2)]dH_aT
CeJIE+)ZW7@f9,c7O\Z\b0gR#)H3X-4RJ&E[J&JN4[=b/X?FHNVD@J@6E:5YgeLA
>AF=+b3;?@?:KVXZ0J1ce.#19Dg_69Ig^/W18DFga3&[[Y:(5[Db[&[Qa7Ng6?Y^
:YQN:Y(/Dg,X33)Z=2FbXONL0,IQ\OQK[FX6-DVDJI7]?Fc]GUVFMES#gOUV-_0.
R6W?9;c,+Y\dDSgOb]ZaO35?e9SA3H]N;U5d.-/=:DU5#>8Xb4S(:Z4NI.I2H=Rg
_3Z1)H[(_H@Df:>^W+ae:[0Qc>0Z2G##Q3GN;fM=P/HdI(G49C&A>L;?d83-9J/N
JNV48e6-/Sd-/A6L4@2&=P&f(#I1HJ9K>SEH2cH-P1-5\UZXY1-8<Ig/[#G9QE0L
bC5;X/3P#K\;64?4NLW\\,__/<SWc\^d2UKQ29,]OObf,TM5Rc)==KWaR\V]4?#0
?dE=7W2ePT69\T5=00-6GR)9N_Q&eL/E[\35OJd4G7:E<B8gQd5?BK7dB/HI8.V(
dE9;U8eAAQ[\9aPb_K51>HP6J(=5X(=X4R+]16gd[:10(#SFSSL52Se.><@Wd(fJ
9CP7FA0Zf&Y<QA?Y1Q=H<>/4YX09?WKX=M;Vg>TUH&#?DBW3WMHT]X0>J0?;R/,b
)VR;C2NPc49S&>,F6[gAT\RW5+=dZ-S2PWbP5Kd+9[VT?X9Y-aD=3CTB(A3+)4<c
STL<KfNT/T0S+],>@54MgF3_EBZ7&d/XEQ6&K=W;7U5+Oa_N^_]=4EHU9cg=gZ4O
)^dBLb8BX<+fgE5&.I4bIOe4/<SK[4YA4Q?;9T^LeZI=&e]<Ua0]3KF1d&fTHY0\
I?K6PCVBCRIJYc_625Y;gSf[aNU5^a@Ca0Eb0dYbO1VEHA3@Hg4/B?]1&LOCY&Z9
e(Z@-@OQR<dgT1/TCA>6HD&5+0>FH+;_5GeJFD;U+I3JE=3D-BRU;V^CeH-a11NC
M)gEPe902YWW/f61.-IK[fV.J4&ODGE/=<36PG#P.TS60&Y@GSfgQJb2c33H,;\5
1-e.S@25.W?ePDY2Q=KZ6bUWI;B<Hb-]]Y71+5(Sg3VT45;V<X6DIQQ+8Ga\eQ9d
I8b+P.]VcP[B,\/UE9>M];X+VG<9A.aDC@_-@gY(4T,><-We^[>>VLaA)57c)^MH
]]5[Q:SZ><b\Z;3SQ^_#D?71:.W8+DfGJO<Wa#eFPXJ0&>S-@eTC&F;<8;3-.&UA
Z>cI,-K2OLN/ZJ,aWgKDI.DXRSI8WJSHDgKZ<;Q/<2:M8&S-5G@/U1eT>>eDL;QO
LC2#=9&b@0A#_YW8G;b6^GQa#Gb+2030fe0X_AUY]L\4(d8?eOK(0;MM.GAEV4<a
P3\3Q\_fQ<)?Q:8PSF.HWc^G>cBC]A+6_3J368X?Z)405DMMBCU_7]be+?d0L)AU
c#=5IWSCE5]Q6HMP;<\c4DJ@8GL8MTT:AIVO3a1F><]^Z]5UPJC#9;5IccWEB;IJ
,1QSQM.P3]N,,>BHVP\fWK?J);T5C.(C50CG<XT^<0QW#[8QPFONJ2GCKX8P2^H)
>R5^X7Rbe3M0[D6ZWd@W(gZDf2O3P?@3DQ&A3]b.B@&WCTQV\TKCPX.WZ[GaeZ20
#XOPDeYf)3aHOA1U89>bf.eWA=<b=Wg38B@3&/Y=\M+d#QI5&R&HVF\fW.6P4+EW
9]gLb^VNKUT9;EC:dFRNKK8OT:FE10dgU1DF3(8:=+/(-:W.\&7J07eV/0WVR/@O
5,7#b+[:fHFL\;1D2B[43Ge8c(^AK/J[3__1._NQLaYde;e]PF164RZO.MBS/-?H
+63>0OP1eSL=XGYb1B@RM4_DZ?QL1A_-gR]A]?.QC./EbTg4<\5YA<P(7bc#=Vg&
45Rg>:2)?<dJV#3c@c]UbE@?)Ya,-+1+,SW04_V+BaFaM#POAW[c-Mb@UQ^6=F3&
)]5A&/<[SX6RQ5A@@6,,CG[bPT96>,.4VYNU4<HCXR]f:(ZDc\P:RPUI4)Zf@c^e
9_#T#X3gTGLF[0.U,^9P6G\L?4b3.=ZRDT(9VA<aYG7JGcc5U1^K[,0H:UeVY8d,
G#.9)/=ZQ]=4=/S<H4H.I8_,8#H3[.9S(,AHCf)S<@@QB&5)]\7Vd18L<J5[4:F<
c9TRRY>EG&dD/<C;G.eDN;DU]e9ELb[23E_fYcMcB1^agEg5KYRI^.LK0EQ_cTaQ
fA8JIfMVVL?/P[40JX?CMP^P9K-eIf<I-SK3EG4aUBL(X43_+@C?=Ac+?cEB\]1W
3fRFM>.8)[X[CDFT5b0+C)-JP(b>#^dOI<&faB@28JZ/6Yd[@,/X]7(Cc=eaNUV8
_XL]WLN3=I3gIW;b788(?6S])9-)CV>@_0e_.c4F/^g?E#O6NBZT/+gVd/DU,VI@
[BDCHL&YHX,dK-&V>+fOC31g]d[<M=VcG+)+gcH)E+8Vc4^LYW=4aYJ_aPMIU3=(
b=ObD3:KD0,OZgLYK\C3<1]aW_D8^1FI#CJ9&<.[5>M#M\N3;JPM_Y&b^44,AZD-
-N2;_:fg;9W_P,\\J^0+96Db9_+ZTDT=8[10<NJeUC/;-XJ=<eQTG0IM3\g3MIfT
@c5;]#IN,S]Se/LM6&#4V2#-dO+=H_f[FZQPP[G9)EVJ_eL1bTa9RTV5D90cR\4,
]Gaf9-#2).5A+B9U,9e<\5&F9-GI4=RRgT5<4ELb36Ub#Nf,K&KQQ85fI,[+RbOP
K#8Q6JT_\_A8Gc/+1D4d(98AB>&Xe=dXK==TT81;@g<ZQBbQRce<bf.B5a^F,?:>
NN?8[W49Va5/(aA^K]bbA3A7.8(U2Jf;DTQ#_JS?Rd^O:bJO+gAF]10QdM5W.fb&
BOKJ;SNd\WUE;B+g#J[&#VPA-PE0UH)4.d_W)V#A3R+AZGA-K2fJb>@CfC(3:)IH
W)g-VT_6b#QH&XV(A6\7e&E;9V=a2/]b1c(N+MALdLY&?AX\>PRReHI>B3_,5;]4
bXb>\;-:V,5@7gE:DMF>?:L:C?/(aS.XLQf]LGBN6DK\Df?Fg=DW(Q:LFGa2YUJQ
C^M#2;[SE7gTAd;,C^=UfFTE]V^,:.]/&cDGUXBDX4QCUHLY&9.]\Q<E]CU<HW2\
6cFLaN9KGE)JL>G-A5Bf3F8A54UYDbLF4Qce6G.0aAEWX9[QYVRgN6VE^BN>KR7f
R:07XS#RQT<>cX=(L;F\+Fg@/L.Q2GabH?P=QDf+@E#1:D\_GS:9^BUHQLR5[cDQ
b6G2E<7+JQMSEH>QR=U,<NM8)TX6E[]8IFA,La>JgP0U3NPSWbXGNW&6>@eHI9V:
T0fB?_,/94(.Aa.C#M8eZ8D7de327,D=ZYWS5Gf;WD.&P:=#0^^(0ICNcY?LO:dD
O;1P(1=X&:2^V83CY&L4M&5@]T,639XKE76XQYM<Bf6Q7-[-,A&/BALT#DU+\cGC
b(G@c7I3>P-M5B/LBFP/#R>4aN^,9--/OF/d;bZbM(/>ZKDE)g?,3?H/\1#(ROdg
3[TOT(7H/ccR.JEIS^bMR_EGcBZ2L[c#=3<@[KM_A>>A/A.N>)QY&_94FAeR[.S/
.fA177PTK1V7\4\-aN\]^W_FY^W#S5dQb&?J5(>UeVC8Y;2Eg88WT\M9#6)0.3<,
]L.U7eYC&5&5+PO>4=6_=8c@RHN-Q3[-K1AO-gEDV5Y;3Z(eNI[K.b_.<BPcO4@g
g5EH-g,YN&@A^b1e]I+\?D\^@8O=K<:G7Bb+7-H[7L:,<8ZWQXTJWXCAJ2&(f[F/
8fF/bJ1Q.OU6d36D#Q2bGV[&cE8NXDMH[>TXg;Y8X#UD4ESUCOAQdQdL6Sc.Oc,I
B]a5X8g:#:a;Q290#<]Y0Y1H26IVHDMfc@Eb]f:?53P9\.F/AFW?<-Q8V,_SIR>_
GE\_(.AcEYB),OGeN.5J1SE;VMc)_XO#2#<Ng,bc__0I0HE;9PQOE-QV@B0<#3PO
54UL?A?NQ7fWe73,b.+8Zb6BOU-G<G]US5O;366#H;4EP.7-68MW&U3gPW?K175E
fHXX;G.B_dBW1<G(g#?&CdO,=QHT@40<9O;X?PBAac\6OL9CHJF/T1DWB1S,-,+I
.A[,MHYM=QB7?,O8VT;1BT:@BQ>)LLGcIK:G_aVW.T+De[E,3+(.1PO:]&=:GIS0
VcLKcaK>E1AYH2Y(H4/A=6DQ3Ng-Q+Vcd(VeO)3<IYAN@bHSJ]cbg.-d9SLYe_)(
g1MdTaZ7S)\_N&@ML89(EW)_c3Ue4EXH_GG,Q:BM.bW1MC,>A:X\(5ggFN_I)RR2
VD,.Z88[)SE(PAQGV#+<9XDbK/2)Kd@BZ#B)V4[S6+b;d,M:@aX+BH(=M&E;+fYU
EeVWLc1LKRc33GUWHCHK&?&aT?I\F75]f@>SbN2C6cc]=0M)3<-SHBc?&+Gb=-SO
A6/I,897#F7I_cO9=+G:Y-VY<<E<46C@ZE/f5Le\-T&..-2[9^Xf9d)gK+,>Q/CZ
.V?U+d(4=R,1/d+VPB@LJ+AbO6#?[:Bb[D0FeV^[EV))f[Pb/_XHXNM4DMP3@TAT
d>(C5&FX<Dd<CEPDDO?;T\b7+I49d<F0HEW[FYb:/Z3/d;G6\e48;XNf:W]:I0Q]
HbR&\HN2\7RQeYb=>\1&_\/>J]S^;D>X)\?Z6M\+3_74=-+\0\BZORTX1aE1G,MB
_J_38+#9e0L.4Y#eJ)B]HPVb],,9^C=R0DS:YYQA4ZYP4?PcM+[gKe(UcHWH25S\
?4:?OVML-=V):RUgX.KGEEG-N7\,]B(QM.7R&89DOJF20[W\_]ZHR>7PIA]cZ=CJ
TR9@&64.8b1MR#1IS\TI9WL]5&_<Td.\HE.8Y##9_d^<fVLT8VMfPcD^f4]4>YQ\
@/AI8;5O2G8^A,fa-M.OK/YK651-]V1>VN8C2KHc,3ecRK&<K#14@Hd5GDeRC0Bg
]BEJEDFeL7DGQ[Qf^@cdG?gF:d>:6?@GLW/(J,d;3AXdX[)PDc?IaA\GNGNUR[Cg
]>))HK3UY&gDgF8e,04AL9MNJ?e00-R5_W.LVM^S;A5\2c1;[>#RT&g=QG._42eB
HM3K;1WE?N9P^(]Hg.=2PdX_>&Tc4;52I5O)(1#2-)^TgCKT0KeHXU6U4AV,5N65
PC/Zb0K6-;4J8:f-OW2dR9QONb&GTTM5.LbbEDVbbB&bbNZTNSb=P;5UQ;R[X16X
OBXS]J@==/4.J;;33VZaZg_DO?^S1O^4Y>g8@]BYe9#RAEVEK_9CIebEc>\A+^3W
&dJN4?9fL,;\P.,f/#;0<aQ)0T)^/J:Q4T4/EMcKB(cGD3Z4<<7SaPL.IR.>^:Zg
PYL93_C:^5)GX^B.P3LJaf6EPf1ST]KNG2dQ;NBg6UG;JR^B^LN=Y^SgD,))2F4-
]N&.a)U410;Z7Q:.A^NT3JO9S]&_EcAZFdEDUIJUEHT,_fUES=B(T\QaPM_K7dRg
65+8UK+a7I&Bf@,#U@<0CA54</-J+?0-OEMY].B5C+=/6JR@dEWTJ-BX_N,Qf]cR
Hb:d2)S&g8PfB(5S+OX#6FZF=@dQ(,>G-Xf\8Z@]#AQ(\WcS1e-7H]3OJM2O2/,T
F1A[C#:>RdMOK\<^7<)ga-=?&GNY339eTR#Y)8G8PW4-6FMW^HQe^.EG_-/Jd99G
DA6=XbRQC6ZaIDJe^?M4L]&QP0.g2M&aGG@Re0A1]gZ)E3T/ZX6A6M1))A7<GO,C
=L:<0#fQ#E;OGfK+?#25JATRC-fW#bMG-064ZW5QCJEN_2He]Fg[]WMA-R)E:5#V
#)Ce8S,<K_SPgM3=-)0ZCZ4,IDJ8A)Z.SLGEQaQ>PVS,_/a67L_T,NO8_H77]Ke.
PP<:&EWdg.5JGQSSJCZf@K2&Ca2Y[LYJU]8R#GE,]<2A#F(_1#GG[#5MJ>_KT_A;
L;MLG6R_DaAbBV#N6dEIH(02OeGP8B7&?_c<6c,_G@/^@eUb<N=#PO0e?d6(geXg
FJN-.FN_6fF1.^g0c5H-cSD2,:)eOAY8E,704\DI=@f3+;X&U1Qg):P5WB>KWU#6
^EeYcGEE@ISW@6]BHaR[VJIR8.AMCb_gROEDf@LXYV,_KRM4,b9\N_JLaRJ51=B3
[_0[#6IH3<:FKNG4BOX+PQB@[7>=d.G@97.;:&?-3;gd0SJO#K1&XL=E]Q#L^J7;
&_C84^X#V735]F)^H03;DfV<73gXDaCN._+8Qe&QNZ#<Y.:/448NL[(4V=6)INBK
48M>MgBU6]P+J?IIX8#-KL?@(@GQ\I-@c:IOT:gTC8;K6c^6P_Q0ARGJ1KVY/W5a
59c08V1+I>1W78-QaG^^(.(M.eDb6H[4+[=)X8RSI\A[:ZH:d)RdKN]]6gJOXCfZ
XE+YZWc7JK3CZQ(1T-7MA\,FV@O(^##P-bW.eXX,Q9=K>R2eD>B,7OW(.OXR5KV1
Y?@?,_O7af52E?+193a5^88H3+I,,Q3?#^WHdaV,6;3T=]4]PbSX^YDHFGJcVVCb
BCH)B3:[/0>c;8B?59a@Ce9-XFUY@PVHfB=77+LZ[7U0CM0fTA1Z=d8:N-;g]1?7
&-\OfNN/=RT]K,;g^8d/WPMUWd\-XPB:bUNFQB3VYA0aAIN2gXLMbGG3X]eT#=1=
fa4]+3TcHFMM+?;U(@,R8[[9F]b].IGNZ[#e>C?K,OQTM&&Ad6bZH7e@>YCRTb2+
Y&\BF;Db5dIV)(V;g]G+-5WQ;\_^6Z:H&Z6ORSee3C71<CWc6VFWIREWd_XaX3JP
dcQWH7MKQ.@UHE/Wa8YT.1.99dQ@>_FUS(_,gX-g;3.66,FKH[.8QP:b/BHCO<#T
PUIc;fHb/2Xg-:07L7XJ(c^9cLK4[;UWG@&c]cIUVb.1J30f.C,1Y_B+ITS5gF]^
8-GQ-_;=5=]Q^>gXQgY;+e)&d3OC198CSV=d/Cd8Z299[O7c@a[Y=N8bCFS3TCa(
L7EJ,S)4RG>U[L-V:@TO?42/43YE4:R0<4TJBV+AB#/+1O0^S&(>?6#-&\NEN]>G
#E\WbZ+3E9&V3[9=/ecKgCe0E0N:-<B4,Hf1^Z>CX^SBPOQ3>Id6B/Q-\K,M2-Wf
9Q0aDJdYA\19.=@>#BWH03;+//dPL1;)&Q>dd;/JNJaUZ=],_JT?GCH@;9NFEN6#
481,6#6CU-WZ#aPLPXUg8F_I:XB43#:e&GdM64\W@9QI7+WHYZ-Rg7aYH6KB+]0,
DQNMU@A(f.S\XD7Aab2:Cc3c5K(P6OEAUcd5KK<a#SAg6b6(1XW#@:P-<QZ+P8WE
>0c[\DQ0QfbF_48<]@L8c/2N(&dN15X?]1GJDLZ0):<E=]CW/UFb13=0,6?APLQJ
4]7Q-f5,A,[=-_LP5(US)8(CA72R)NU,ZMKK&=#4<,0UV4C5?88&?dDc4&/)Sd.g
ba\d>ReLe4EeFg&\DB4.V1Va1.EU8:6beP?P#ed3#N#U2.J7AR\W,F)]HZ+;@Zec
@@,SObb[,cV,2<K:2cXW;<&Tc<c3?+N?d+VF;@4W.]JM3M]1]YDc^]e,1d-AgVg?
\P-@7X<?=C4.;#0;L9A(67IZg62FK3I?9\,S=U#9P6VRg:1UM^a,ZG\bM246GWc=
57?>05>FD8[@P_OUZSJ:f)TPAO:A-XK#KfXANa/^ARMS5GY&E>/WF+VJT4#)-Hg<
f2</P#B.@c@I=1^@BKN4.V2?WGX9bUM^5;GU/Q\B&cK97B-f/2GJXFd50Y>DI,g:
\<VK>TZYWMMS,8?/K54XOIb@VQEV_J6g+.U<#:O&SDJMG?K9I03S^35JfN<Y:6aS
W[08PPTGV_41[L:-G--]:c7_GE4)X&-@;YH;)Ob[JHNAD1[,Zb@@.1#(X3<fD[J@
.7+Idd+];C5_F@3<gV/,\6bLD5&:WY&MdFe)+IB1I],>Pg/T6.MCFLS)8C29W0;F
IZPad;cE8)BAB0SC@DU.4JJ00<LR15Nd0PIN;d8DM7c&G@;T2CD.F?9eN<Xg]&4,
MTK76^5D5bdCEM^-KWB0X&FH[Jd+/B>>I#G9a[af7H<X+[./+.5Rd,KN/e08<a_,
Gc8Q/#?APR:2#F-PKeL]O7\L?aS=P?B>D#G@f0..eZXL23ddMFOeTVR[IW;LP)PC
aE)@[E-8g:AXLD1A,<I-XU^Pg[MW<A:.+;.#g=JNNHRfcEK2YNbZ^#_g>KJZ[WXZ
T,;EU,VI^fW[Fb_S.R6<d5(:UL?.X1TGO:S+9<^5^SdRC>:e:H(T<f+cAT\@1B4)
M5F;ba-B)R;4)ZdWd-X,\)&MK6L72=AV:BT[Q#7:[+MZTgO1=S\g[+(Sg9e5BEAW
>QYP@dC57\GfIEWGA^@.1R5.)1N2a^L,PYaQ8bd++PfP)Y+,d0ESB\G/d=.U_bbP
Jfe\&^.3B)<V>YPfZ\)=LTWa?GQ[JS@eZ<HK.#e#(LU&^LdXLFN-<-(bQ()[Y>9E
[:+&RC0YBN4Q@gMW&f<W0&A6/dG3ZQ(AcZbe[L[N@0:ZP^-PSfa.aUQ_e:K(b=T.
-TN,U?##FKNW>b+QOVE./6HU8[63dXd2T5GA&EB)L,L8#Y3bSTdXT+8WgO2O/a0b
_DR@D=<:Q)+(8N7;=N_TD.LOBA@[44W?aA+O9GQD_8B5IT6bbTTb3)@>DbF1gMUC
?BEDHB=(&DWLHNMO3Y&AB&A]C?e]M:6+-)3d/#Qb^4J,7ReZ;C9YW<O_90=VFg.9
cX15Mc&&fZPePB>=0YS62\-bQ+TM\ZN<g0VIXCVgQC=JUYN_4=dI@LgLW].40Q9J
gVR]@A(<DFQX=:DZNHP[;dE6af9+KPP?1[L\.@1YRd95;0.P/8YK8XP+]S3N>^G_
QQ=?a/Z>3YHLC0;.DT)\)_EKANH4>W<TUR(JTQS^^Ma0HU&.YK+M:1Q5dKP&V4(_
Q;O4+.>@LKXH9F:S&fD^NG;Q=AaL)KFaGI37#e8cdK<7:[2,:S48f?_0&46:/9P]
e6W4&A?O38X9S[85[UT@eH8[NWXaOABPUZ6#A;d)e]8VZ#bDb2CSV>a-P[,I#/E>
aW=4_I]]Re]V0XBWG-UEREWU>-B0gDUG7SebE?]K50XIV,J-;8(WVWd7AW?/T[e?
DAGAVFSQO6Q2P?(230YQ]?PB5U,EBF,QQGLcV#8[,N#7C8edPLZQ&Rd9VS?d,S.:
O+U,2U,<>1A0U4^:d;UB&F4)BVaB2Z.Ec:FPATHLAL(;=dXCaMff1PVU^)/5MKde
<)OP3VS+(c0VH(b.]:SMc8,/E^5HU1N;g16R+^GIbg\1V9==eHfA08,<#,@N3a;0
[F)^a7)&Fd?^C<aIFP6+Z+E)#@KLD]M??bLNY89>;C7)6(X;/Z\>G6e,gGG>Z5_C
7KVU/K1T+a\e6f.gJQ3RS]b)GH)>-&(:A[W&aX]F9=WPRHMB8MWQ(eR:0BCR=J:>
:QP&>G4W@M#fJ^8TFO);_M.g49P-FOPH61.d#)MT(1)[B&W1f?[@>6-VagY9PQGU
;U\GD^GBL.R)]K1;XU,W^#\b;0PYNFS#U][ZfXL5E:#A_X(^U97KYDO?91(9fD-G
&9ZTeX5C\9\4FSZYd.<_AUQU[\E>IIKb46Y@P./5)dg./.8?JP[E/_\]QaQG??[+
e1Z)96cRdOS<@SAME73NdTSfY0eY@.O^[+C+e1Mb6+dXgAc:\]a7<;2EbagO]F8I
]W;D/KU#67T1VK>UQU/d8E=,,0;^1K@f=Y6-f6LUc1VTE2E0e)XG3Ve.LF:AV0XY
N7Z5G.NaZf,+JJ.1,^0=S@:g=WY(aF-^eea01SXM+==YdB=Zab#(M^N3:A.fJAf]
DX>b+Ne:+JKN<_[]9NMN2fJN2/E]W/b4E3GM(WU06_4;==N0AV49C=^?f<8V+(2H
9UW0/S.[VI7L=9SGAf/.K7]46Q]57)HG+8A=McK8gWDM(CMRHaR?O)SZ/CODYM,A
7?6Z3I4\KLK=C&F_VcZfQVXW(MQ?.#d_2PcX1Q4<J+\K2aEZ0EUNY):<dU/e+^NF
e_Kd#/?[M^(GfE5JDVI9-g@)cULS(SKdM./(e])g38A(\+PZ,Z8/-Y]P0@T97>a+
NA>/5-5ZX2HdO+_0<MEQF-Q\=c]aV4g3LTYb:XRf]+8J,S(P2a3ed8IVQW5aCQGZ
OZ#25^@LTVcF&L@UKd<C@V#3OAZZ<Y+I1<YP&Cd;:0>ZKQE8QX?3Y\adS@_1749c
8MUX-UR&)Y+-@-#WK9.ec.2@;Pd=?V-AM.5DeZ[857[(Je0136H0GJ@WA(UM00J+
@SWOBR/.;H159.dOSWVTPSC42MC?)=A7dH0<(L3;GCEbMcbYXa7HeaOf0V9Sg:&A
RK9P46]O_T\Bd]KD5_#[>;).@5&&(G535a9<FKSH7@&Dg>#7]:00eI]+3Pf=L6^>
.SHC1YZR:#/O<gg=,@J0N))&B24T^.9d;=+B8R-Ve+^O)LR/U]HEHO7KK[7Y=-aA
L8WEI@F.+/HccSRdaXfN41&IZ<89\g1&2O&f8MC4D9&,TNF:<E&P_c-5(.VWUM:f
5LHHWYTC)FNJ<2f585d?B,75R3aR>VFKFL=26?P-U(+^2).Q7fG??)#&Z7<57aZT
[O]GI;F7<TPF:e?[NFA)1/Y+LXHBP<<8>N0P90>CWA/_eA;,MQ_39UB[=,49T(?@
]68.?M#R/P,H#BWf:)71=N#,->HPLbUDgB#4V5ZS58H:/SEf/O875g-3=eOG@,X<
>H6R5RBNE9G:[>^[@&@a2/O_6_RS^2^baIQeJ/)&[-CN-KAeBgWRJ27,HKH.Cf:-
MCdSOeXdKb0D</e@K:/;dXFCG&.1^R[?68g9.T(d/HHE18NY8(C+:)c3=@GKPK=0
\S_Pb(;0X@CLEYHcX@^bZ@bUK;GR2JSIUV+P]3,\d/cG=#9\(L,>M51U\+&)3V3<
)4U9DOH8Q>:43M]aF^:a3)M/<PK2#/<G5PU]2@L9,D([_^dWYdHe#Kd+1)f5<fff
5WL;X#B\JNX#)cf66Z63UaePZ076+][\NVeB3EGG8fE-;[G-<2,O,B^7AfPOCaOD
KZ)\bKKEbKOT-(02M?Q+XUS4B(WbTB:KBM\UZ&^XE__3bDK)>&(=I8G\DVAM6X6a
182P/Yf/(TH]?F&;F,JQ>=9@-G,VgQEL<c+-NLQ4-^36g991ZQ3Q=X6??0MTN7[E
dHD2\eA?-4=^(?YMIN1C41G+a4EVH3<UTe8Be+;&?g3fDd-G]VfgSUFbeF5f841(
PM@QIAebDQ.C2Pa3QE[,O\dY0N\Qgd1,QM-]8@d-g:f4I;NI3+:H3>K_-4[?^gF6
H9G1=Uc/CH,MfP(3I^XfJV^3?LW/bKM6[VOg@?\3cQaS<RAa\DYA)T#FNU@geE&A
<HJ&fb-@?_3e&E3#@U\YK4IQV9YYeKMPFW=Y:&gMZX>dg+39V#OD8HSSFQO_->9K
OO.BDW96LUb;T_8=[,e22GDe;#/SJVFIN84g_K2.91/L[VXJf92fFE)KE?D24F&T
eG=W[<c^>1GGFLRFc2e<7X4dSD;ZaaG7c85_.>\0/&.J#.b8Z:.#>+/^0ZBf]WBV
1?0C@KSGM5be37QbTa.;@2TRRH4JW8g^UP04W\?T9:\=O?1UJY7M<7@?7[6;&gQ\
Q;E-]>G>Z@V97+gWZN8<RVCQ<51@#;-QYf-WdF\3&9FWNT88#4d)X-2Fd\FC>(d&
8?M5.fN]Y^6V>2e/L:f]cKSIZC&HM3:YIARVS4H<:<1XW[F2P3NR(+VcM79I^@ZJ
eB>1M3:@4/\a;D[(P,Re9/9;<BK]M4+#>Y6c<J(POGM7#U2W9VH^6D8AD[[\]2MY
S,K#B,DA,OUGC.673_e83e_]QA9+agT<^X7c2+^^=I,YOMeF)UPGJ\>RR0He<e7J
)R-(KTW;RN:8Q=F,QO_g^C&Jd\](F-f<;^(,3Q)=Z>WV387K4PI:S@YI?g@5.6LD
\Fbe<Zf2FFLF\J@5W-:=Z:^_IefUPGecgLc@/CYNg[HfRAMV/EA7R212&J)[@S66
fg:=.QKB#A48b#.SU@f,4A)+;NYKPU0Wb4[(3af;/B,4>(463WA.#\W\&:3]cDYU
V5S152TG[GV2=d0??U8a<cAX7\C5H,f1WKPQ_Q:4:^[_U7gY=&7WLILR60XZP6bK
H^_8C6_MQVc@\/3Fd,J.LW+OB0EPc,d#7=(Zg?;CEcPf^dBNG7PZ;fSHF/YK2(f?
PUV.@C1+E]C)-7e?PA<=<EG?YFH4Vd@3D3(C+_?6EX(?XIV?&AD#W7]8c&V3U];6
dE)L<Z?SQ/:JX3[[S++Q@4f/<Q@cMZ^&HbZ8Xff20<.D<)9VA9RS.@^&DHTE76F1
W+,g]BQ_b7&4(bX&SWBXg6E(N^<E-4F6/cW]A])W;&F.b6(<K@&6@\gKV>1?M_]Z
\Fc@<LEI8fZ1W8.Q@U?RJ;_BP4MMEFdLH2d,.F>N0c.8BZLKWbQF#4+QZEH^1PLY
NWdS?(1V0<bba]9:ZG+U#66]e3BX?ga6?9fWNc>N:SagV,DXG-:B4#3)&M^Y\610
4U@3Ab07]@,N)/0]T(F<?NbF-fQAVEO.W#.,?bJHc-3<f&HXBdS<N2Q>;8_Hd57e
&Fc5=PNBL4,E<E>LP(V7G&VA/>W;7g;HA/f3\4HW+N5Z-@3C&WF:)d<V5I88.V]:
VQIIG&GTQ\U>#S&/.B^TOTI01eHJUCHcGCF.#,U40e&gZ7I9f,7/YTJ>BM0W@G;;
a#(c#<_GC)FCLK96,>,eK-H42;bSddP18edRLE>:M-QC?E.ZV&6C[6Y1ME6X6TW>
C#6550QQ9bPTf)&a3T(_83B.=Q3_?49AH7ASWS1)b[#g(G@fGEZ/)U/:)9RB6>bC
)1fR)C.c/XO_cf)=&2+We0-]Bb64WB6TA-:Xf53S=2JPbgSd68KC#_&Q@ES7Z=0\
M.8WgaabAMaHb<Z-NXV90[A>^V>P)b]XbOZ_6(g<(ZK,#)A,=21B\&PaO1OV/OQT
?]I=d+IEO4](1;6<+V1HH?b7GbS_9FcAaRO[KYda_&4CPd\g990#^9+O[-C2R3Af
(<GX)[beQJH,0JSH\2ECTRH+0W=VG]Fa4#S:Tf8_F;9D_RgIS:][J@&@HNe3Ea46
T[Q)WEHW6407NNcc#7G8G:6M9g/IV)=36cS/&;P>9#bM45_@bP?L@AR--MG4FIcN
dHQOAadDAEAE_b+[)_Hg(4YBM[3H+GR=+HgIJbXf6D(G3RHZH0A_e1L\^61IX;&4
aF\XA;<7S#--<FE\3&.Y-ON4a/cacFK/e\7-Z13?]\6ZZ>;+U)\cQVP3NUXX4N<J
BB)HTfH#ASE.URSQLQ:J+WE\X;Y7CPB4[-Je]\5X=A/Fe,.Lc_c1c_DaA91[?G5@
IM++9fF,P;:AB4<af048.7W+(^0H_Z(e+[_,bI?d^8g50Y3eN\QY,.,70d_aH6][
Db2^+>G;(b4bR(e7Nf.0N@bQP,UDI1X8^A4.48V&ENf6R[0U_c+8?(O1J2;AbOOg
E.+O7&M5)IYa<3M:41c,@Z#YX,;6-.<&_GI_a]\;I]MJaVMaHPH,X#;a\BU@F<E\
&dDc#;bA[R?X#<:_>,PHBd@CFG4ORVQfD<eVV0cU3<e<R-B(O2T-5@J]ERM?eTMX
BP:ZQ1P@H4gdW<N(8&-=c8DX?X(0;YLa+CE8/Wf8f(TN=2H^[(09GC=MF6J:33Q_
4-(d#OV-D<]4EQDEAV__:&TgERAUIZS>]WX\N-+]QVAb>_9^D<edf>3:7ZV7(JA)
L+]AScUUObBJ:d;c;_b\Sf)9);QG?dXf@G+Lg0>Y(N&&f1a=P;3baPfHa0&[;7Q4
V_:8:SAKA[aX1g(5<H?1383,G:8/e_6,IORCMfW:aXP)X+5(Wb(X2_88ZRe3&Ig5
8=IJE?/X?<&/ebIZRV[?[IO2&J@6U?B/C7X\1-_^gX=OJNfQ[Wf3EOc[22.J/H8F
0=6]V7_D)8ZHfE/5cCe2Nd/UU/;;fN[8J5YU@P6B)FDNZ;HE\JR=O?C)SQ,W@2G9
c&eId130:VE\FETRcgL08&&):_Z^6.E7eHM7FZ_&LAQ^W3([b1U:9ODAXMES=/&S
@Y4<J?,bbR>QDE1>^8]K.,7#7M-Re#+Eeb[968.Nc3Y?dUOHGT-NK5e&&)M#/^\3
ZJ^#9_;XSNP^,GPfU)6E2^cL4;:5,(G<XOFY^,+e81C;;E[Se5/K7J=V<Ja>N9:I
@A&HRd)fTdHONB+6U@[>\GOAf(^R3EG=TH+\=?_)UO6KKHF\c>\cMZ@B@g>9U3<N
1POC\@_ER<6\Q84gAU(B?-]40WS74b0,G4WG+U-+P?QT0=1T93.IU3(7[[MYN)1\
PDe@H<8IgZ_F+cP1-\+XcU9?A(,G5CJ51fgC4HDcOOP+D&-S+T0=9M\Rdc85D6gK
e4]d:[GW8J-BHaX<<6S#d+<QPH#:IAe0d<J5)O_3fc+e@d7O/fb/0;.HMZ29S5[N
WK&b>]Z<Z.J\2G5FXSRV++&GgNS3@@X_,8O:-Da?[MTZNc?@-G&>)_11;RD1SF9;
Bf:&N0Q<C#NeaG,M/&.0EZ=HZ9aK.MK6T0<EA4IZ6)>ZNN)Y5NNL]\?TWD-@)<#)
M3US^1Pa]cM6K,]3>Ufa/L8&c8ET#4UKYL[0>=E+5K?,;BBG?B>\b)@Vb:\?/E::
O0VB104F^7C&.\.+e9c/7bVAeB;YfQRWg=:H616d_SP5b1BgGXJA2>]0E>T[BCO,
c#K&:/L:AKD]\c?-8Z[LAHf<C_@/-S[;[c^f^ZQe[Z1c7DHO<(beH<A^=gBcYPK:
))Qg;O0NHG_D70\a?<ICU&I15AC>_V>>PO#^^N8#0Wf4WWNBNO9W]H0S<>IM04A#
4,;9,HQ>6I2&S>U:Y[Pe>b:dS4ND[)D+7>W=:P2V_)[^[2D&_2U7ZG)V01fV_f+@
N8WKK\TKQ:XI-2V+gFV:E/AIYMb\d&3PVI5XeD:Jb3E+8=MdTaJb;fgR5Z2H)1>N
fMN<?;=BT([14[I2=-LE-6]>;D0b34U&R2^3-+8-35ZO-;_S&/01/=E@ZZO\Y5F&
3N3IRg:19J=OeJV3=fd5RUHF^&;J]A_GVId/YfG3#APd4\&f<Cga>[,-A/SDF?I8
5)[(FV^Q;Y4^CH:HKQC1AI[]JT0];Kb.D+PV9gW4B7?_^&ADZY-+KA6gF:<FMN?3
A.UJ(35I&\K9>Ub.HY<6bACTO3U&9c@Za1L6[&JZO0#WM]MW@8V_HLI(=K\CGa4[
34d:b>f?DMC;g#Y9[5(:EN@/L@gRD[cZM6<Z3[+10=_54ECc]c1;Z<788V<;V^5+
/^2P8cJN]S=c([KTZG^+@X^^d9<33B=LA)&YF-&&#aY5<2_@CeN;KS8b+9@;D8A9
f6VA:cWA9S.P?28;ETEOW-OX411>)@DNf=,A?Wg>;S?Z+>@0;^7YeW[IeK79>>-2
/:PPbZ1ca@F-\^-3:8cLAeII.9D0Q_be,YcWM^IBC+\>@25Q7#9XKPgYQ@(KY<2f
KL6-.]>?1:L]3/\)A2X80Kae>LGF0+19P<D[B(I,FWgaC>\QJZ_[BE=7_SP^H.YM
a>K:S@_0C@8a&,a\TcCF\G+R>[/364O-)8e62FSfAaHec26?:dcBB6)B6)Y\XZ/)
>G@b:HD?A,GS^H^S)4(C1+-EZ0g5T7VS66E3ddO>1^DIaLMd^[NJ-D+NU\VA<\^9
I_9BVX[/3<V0UgC6=XD=_aDQCY1LO&Y.CL&)a+O9J:FJJ>/NI1FGKUB5XSRN[<DR
[0Gb=cRA\.4(FM>:#OB>O]H9D@;=(UVP9^4eIY6.F\R-GNCHJ,^?.@IZg+2LIa3P
MQE.VI:MB^KLH/WX9)GfFc)+AOggH+K3^ccWCWB5Z<158VPXW8ccbOc:.#Y-X;J>
eA>f8;:T5CR+[VDQ_Y.FGFR9S4R=O1>XF>Z9._OPX0]c@:<Q#AJKFd?G@ZU8YQ?0
<0P(8\e/\W-bAXR\_?:7?=2\]g5(RU)QVUQS.U-.(3JWA9,J#ZU/g,PVc:E6RgeR
D5DKU[\ZVF;D4VKGSR1ISN>X.#6SZEV_J#98fI7[11J8A7,de5[=AG@;Q43aMgCd
MSU-g-?6\d5,KcCYQHRd(K;;B9FX;ACK6_^,4^FTBSNP59N]>HQ3O-\Y>5@BT.+-
MX^EBMU5a_JJ^V76S5d)UTV//2UG.1;0S1P>O8g[.A<A\1cT=>R+Eb=bYBJ\-K;/
e8TVQ?E?Q:FF1B=QC88(ZNC[d-eHRU]Y#X_aB4DCLeY4F0U;-,O3;BF)J<EX_/JU
XW)3E9I(GKIKdGLa^L9?&Le50gg-fJ,=>cMH(d8ZcHSML]EGNNSATg2)3Q?<+H7+
B:()J8fM5S,Fd7146[<;J,O&SW[HH+0#(&Ag8<1+3eD;IcS5C\@(WDUZP1,4FQ(P
<VRPBRf^E5/,TIc=/a;U&b5,(^:/Be1Z2,\D0A98/KYPU7CD:]+ND.?^@NeMBQQc
[+8A>&BU5&8CUb\^ZdDTRR3O-JC^FET@O?-T3<b01gZ3OVDeAB1#31YaQYO+>7g:
JXJEYb;5YK[EVJ1G]?ZcAg/IJ?1I6.GS7(EH.9^GVZP>gT.7K:UQL.D+\^S^IQ67
ca,=P8_Y,/D8I776A?-A=K^QXY^0:Og5Tf(S703<-^BLXLSPS=aYN]SI0F/_b9_d
:^#a;-J[U5C?>8YfKF2OA=+_4L/g.c=IbcP]]8D9FQFXY@)f,[MB3aZ=>?=\J+Gf
QMI]TT=W(Z?R9VB:@&#_W(29:@e>P5HbCX1^/P25R#IB.2AGb?I:G6.T/1UUS:2J
[GP:JLC9@AOCRe>F_6A4]I0;a3E;/fZRAL<D/UVZbc,^@-.V#X\/1e1<6RQ/DUQY
BQR-<49PEWK8#Y[>MRLW2R-BgE58MC&+e;DQQ-Hf4G/]0W:UYWO4^)B2B:1/[UK,
N1@@(&dcF-_VC@c,OLF#UBO3(/a.W8Q7)Z[(O/V9ZT8,UENLE^:f-aBQJ^83LF@M
NUN0L9g.9c^MUfBM<dYeaCPDT94@Q_dA&]?4I^CC0a5A2H?>FL9eGL#3MUIT4>K^
\/PMK@LZ7TQe<UEGG;9gA?TG0E/+BJS/\@F<4J?R4)]WeZ<D70H8S^&A)@TV>9JB
UE&>+>5K7=<32&ZW.3Y]=S]eP1PVB-0TR4QYcZfOU;3.:Fg+S(5+-(dZ#UW,TB1J
,YW?5X(6>f,D?#=Q3KgX)HO,\#dDRRUFbV5[[cA49I7I>1S10UUY[<N8E;=2G+C2
:.G4U;fC/C;e_f7B<>0_KcGB7K;Y?EIT)-f;P<+6P@c>6)DeY9fA-5I)#H()>WR1
@WKKQ[Z+&9PGL,>gOII28K#/3cAI4(N55./C\50LDXLQMNU5^fg)J.YL]NUcbC-&
a:GK1_,X76c1:#:4Za<VGa]H,30OD->Y/I3e6cD=A>XV;;ab=O/V:7YLO$
`endprotected


`endif //  `ifndef GUARD_SVT_MEM_TRANSACTION_SV
   
   
