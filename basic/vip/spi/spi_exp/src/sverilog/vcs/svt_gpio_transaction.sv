//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_TRANSACTION_SV
`define GUARD_SVT_GPIO_TRANSACTION_SV

/** Class defining a GPIO transaction */
class svt_gpio_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Transaction command values.
   *
   * - READ       Read the current GPIO inputs
   * - WRITE      Set the GPIO outputs
   * - INTERRUPT  An interrupt condition was detected
   * - PULSE      Toggle the GPIO outputs for 1 cycle
   * .
   */
  typedef enum {
    READ      = `SVT_GPIO_CMD_READ,
    WRITE     = `SVT_GPIO_CMD_WRITE,
    PULSE     = `SVT_GPIO_CMD_PULSE,
    INTERRUPT = `SVT_GPIO_CMD_INTERRUPT
  } cmd_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** Transaction command */
  rand cmd_enum cmd = READ;

  /** Data portion of transaction.
   *
   *  For READ and INTERRUPT transactions, it contains the current GPIO inputs value.
   */
  rand svt_gpio_data_t data  = '0;

  /** Data bit enable
   *
   * GPIO output is affected by WRITE or PULSE operations only if the corresponding bit
   * is 1. For INTERRUPT transactions, indicates which GPIO input(s) triggered the
   * interrupt.  Ignored for all other transactions.
   */
  rand svt_gpio_data_t enable  = '0;

  /** Number of clock cycles to wait after the command has been executed
   *
   *  Default is 0.
   *  For a pure-delay, use a WRITE command with no enabled bits.
   *  For INTERRUPT , the property specifies the number of clock cycles since the
   * previous reported interrupt. The first interrupt is reported with a delay of
   * 'hFFFFFFFF.
   */
  rand int unsigned delay;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Do not generate INTERRUPT commands as they are used solely to report interrupts */
  constraint valid_cmd {
    cmd != INTERRUPT;
  }

  /** Limit the post-command delay to 16 cycles */
  constraint reasonable_delay {
    delay <= 16;
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_gpio_transaction)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_gpio_transaction");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_gpio_transaction)
  `svt_data_member_end(svt_gpio_transaction)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

`ifndef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else

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

  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
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
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
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

`endif // !`ifndef SVT_VMM_TECHNOLOGY

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
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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

endclass

//svt_vcs_lic_vip_protect
`protected
SHG5M+(0W4]BBZCJV.S8V3d_9g=QB.gP2:ZX_,a\Tg:W9Ga\4+7]-(+DGP1.]_<&
-5MOK;>-6E#HQ05<0H&N0WQI[Y5_Ze87HCD>Z37[cA\S9K+DOP&LY&Q0_ed8B^K:
J7b]f8BEI>-I[Y2Y(?,<SACF6==@WROX2I]3-^P(b>C<2>Y7)<QcI,:OVTE_H1WX
R5WbMR2B_S/P99KPYc:H#^9eLQ6Y96N6M1J8]K79(fB/@GZ;NDgL-UO1EGGNTR8O
U[ACc6PY7\DZ2B/JcH,SMP>8;5,Gfb:\]aVS&7&I-G/F6+K9?Ia\PSB+Q9?D=G#+
c..B<\R6T+C)AB+N/dM.4S/21,D8+6&gC:-IO?4#ZSG1WAJ9-Z0</8\^b1Kf-85<
ARAT+BB(_79^JVQGTRD]&\ZV4ED(MD36,PPJALT+/)a>0KgGNK.c@AJeE=K?]B7X
_<;N[;)9,X4JdHCI+OC)R:ZCIC2_Mb37C?YOZXFVN)\NL?G?&COM]UCIFC6aZ700
=.YP;XEf88>D:>0A:?_Xcg/NdQ)]@J(C:Q)WE7U0XJceg06<TSF;9=0^#O?A_O-J
\@gL3gL:3VWd5cU\]X;&DFOM?(;fb7^c#4:NgPA,R\d>>LeXdWFdIZY8(P:#a@1R
3<g6)<,D3],-+2dGG\.NCGG2R@e_):<=_a8aYA\>#0&b4-\MY+EGIfVNEHTe=XG;
2]WA0aL/QO_@(=Z[Wf-U7D>FFENCAJT:-XcHH_QdfV#fVd:&@R2_3Ad=J3A/K0(A
O2<cNR@KeJ58WW;&861c,2R<^9<0C8OM8<,6G[?RRC_d6IgC;D4<U[MZ&L#NUHdD
_L<;T3_?T.cLgBd0+=.+05X\d;Sd,<MIE57LI;^a=Q#=SA)dV,H_@VR(A33G12Q6
8\G,_5Y,;OC&UM1ZWg_PIR?3[4PY76gK7[\7E#VeFCR>DC)55KgL@35C[1Db2.V3
+9G?=_Q20_7#;&F.SIJF(EFcYSWND-=B##A>16a@A7\#O4>/^?:RWG<G18M?&M)S
.MDZe+170e;U7]8]HbeXHPR&L:QW-1S2b37UZYU58:4WIIM(MWL;C3LdK#SHAeaB
;I(bQeK8G274H]AGR5X)>C:X]]TYJ>KJb+@OBSMHAJb:6>BTH?L82;-]=bE_3W(+
PFf5:M;HWbMQJ5eKSe(5Ka1d^@?@-&:_]IP2?9f3K\J;7OGMZ.<>WOXF[:Pd3[KV
MAU8EKIg\d^^CJ,NIZPK@#I)++;031\C2E;3ReSF9GOg=H^]LY=b27R@5@?/fgV?
]J:2[df;)E_V/&Y9T&FMO^f-F9D@GV8,(?N;#\SaZBV5R&C7.JY5->4:\We&g6?b
G0RC#E)9L^K);X<HS+ND;QCJLdF(_1@c]M5KJK=P0T#b@Q0]AX:5GSIYT?W8aMdB
^()6K&d0+:Q/4E:Y5SV1?@,Hcb_gOPIT)bS+Jg&C34EM=OeNC3>)EF-YL\b5b:N1
5?2BgMeB]cR8;Q#WdSU9Q82KaEU#e33,3fCXPXD.>=[AcG:OH3E;4C3FEX:,K-.+
LN?6e=8[809a/#2_CYG>A52Zc0R4Q?H4(RCNJ;BE:2J9/)NTMA:g)EGUH]Ob;O7N
+<5fR\1HU7_N[#f-(V]G0?WcD6^&4/T)=dI<N(0\@UB2A=6/,)Q^OZd)F@b@-6O(
87)D4dV;Q2V01/d2SeKfQ3]J.QCFBVL-&[egCW#,,DgYL1;YGWH[QE@)U+L1Q]0U
MW1PGcf?2T.8J>(:ZdPU8^cY\Y&9IY]AL[9E_\S@dU)e;^<a6eaN0d=M6HfcI_6b
\V9#=+-fdTVX_S=?+B_ZJ>GRJ9&5A_XRc_3\^ZgVMAQc?a>-2&OCFMG]D[S\3HFV
(]C@\3bI&fLBX,597IfD6^;)P:,5P:>G#Rg>GgL\@BMNGNG\:e+,8PI;S9VZ^Z6T
Y/Bc@EYLV/OW:_4GOS[_9,[>KF9cE(E,Z0X)WABIQ+]P7dBVE2SE>;1g>cYNN,fe
#d]/_/_:^@85/?1]&3-3/OUML0Z/3ZG,6IGgE\9?1c:+Y;efBKB47KLG(?62g24,
T[a^MdE.:PVX9agJ]1YK\;7bg,V@17JP2L7+)X9HKO9?U14+9I5\4([1?>W0WF>Y
#7H(M6.Dc_ET32]5\D^\[PV-2](UCgbPWE_e:6fCPWgZC]#M.R&T7AGe]cN?8Q9)
GS[-B23\0\5;cTT+[@IW63eDVOcd1&U@W)QcfSTBfE=QCJ:Y#P:SQCE6IX)ZN0M+
^a6bKDC1OZdA+?I]-#ZEQ.;51M#6Q_G[ZMBVV(Q#Y(0>R@b&WXW]L<U&5_?3O,eb
gZ1(,b<VN0\.5?)\0+S.1,&FQf)V-QA=>bcUHUQ<T=X[PGOCOX<]A/=L_36V\P&R
(+f6\@&I->8541aDHONCV@SG8C1/VQFM-[U3L;&VJ^@35U2ddZ8_1\?UJgD7(Q<H
^P<<g/P1ZPI;STD4,#BGfgc6&3fO?1[J05@?(CDODR4>C4RWD9@NM?Dfg>gP#e<W
V>&+V#R_>JGT][f4#W^R5KS<3Ye(NLX=6:1GX\4ag#^gI9BLN3/)K94Lg9<V-J(5
g=\6@?HWS59RgdSXHXEg?a+V-UB).Wg2S25MQ#5E7QO:=9fa>5=<T\>6]HR=KBf-
A7NFTHY=T6JKcJF+-#)7TAF.D8\<0Q-ULBS4EM\P0U86HR^8Z@f&78Cae/4&&=H&
b--WCeOOdB2BUeJ,3,NWWN;4Y-,DAPag/FW:@QFYO:ZE]#F33K1bSAYL+e06MB;N
[O(EA288408Ha,eJM1E/#-F:QF-VLgaC#60&T,+54Z<A@cMIdL#QW7WfF)ffWaJP
+:X-We/cM#:@V1#E#ZK3JRAO((&#Ng=g=E\TH<4/aS7.>L)O_XNEd0#f[45XJ?PQ
A=JdKffd1PJN139OAS#T\NAQ#].XZO(T/Ka.1G=&&=_9E;W9.bLJ80U;ATNaD-UG
W#XfF^-a2O85VG&fA;b-a87,-?XS3&_NK<6\>=](HF.E6G7bfE22^NU\_c&C.#Sd
DS7Z4I_B_0W\3eB<6SBJZF=^9:3?@(@HX:&cY7]JV+317K.+.@5c8]cgY+aXDAd:
#,U8A/PU6_2[:<4>R;.aT&1?efS.a)E=QQAR(7>MAGWC?JFH3\M)EM:1I3GJ4VM1
]_9e?PE#f?LRWZN,SAK.Q>:I3:R_U/6F(eacVC>,H=]^DedbU;9PS1;+3([ZcNH8
SBOD_c)LMSP\]bGPU5N_HB\</R.7d4;=QP5[L0DH(FW7?&6)Vb4=/d@>^LWU24]5
R&@]NB\6BVU6[&c9Z_gfZN/:0d(CaGaSD;_2/SM2:P&KHR,+;,BU;UA1+a,GF^LG
JS-KH+?W^B87A?18?;P9@8dA;#S[,1GT]35;1@.8_E,AR1aR#&Rcfe9ad#YH&DU,
892)/UgKgB)L,Y?f702V.U7,[.C4#aO_ED4LGOX7I,d7<+-5g2]L:^,Lca-IQ-6b
N;^b#Oa=DIT8CgE=Q(R(0AVDT4D\WAc<Ic5FgAbGLD)aHLPHIeC-.Mb1IDEd6VB7
8/Y^B3TQD2ONL/DEO#LHNd:YB?+R?+3I<UZg_+(,_5?BT1O2NITF&@_=g0J61>4:
e7:Y@eff895H([C3VP#c7dJVPOTNW]gILEV.6/1ZH62XJ1Z(WQO/>NUZL]ec]E&6
=4?309a/Z/]/R&f?)A.6SN/OD1IQ&#0@IeY.9&7#.1fKSDcX]SSYM:d_OY_e;/_H
PFU@Q<?36HBRCDUNB#I75P^1dcY\1)?K&>?K+)BB@J^UcAB2IBJ.e7(WJ2eNWeL5
=8WJV4W/3P2eV?4G==+560AHacEXJMgCa=+;37UWHPP+b=LcX+9GZa32XbJ]d@1a
;80d<L5U^&REOU/\S#d@6QTgGUF^eKW#Qd@(C3N?IZfBS(QU;&#>3];OE><d/C>b
b;K[Ef0ES-_BeHO\&WA/C5eW9?Se2,2&McUT;?1K0E7Tb5-,@;W:W3X8@UXZYAE,
6<7V]W(X9aZINg?ES6?M=3R=#Rb2GD5X+VP2L@_,O/L:1KP^O1-W):P5IeM8GdQ7
#21fDa2YRLRG@P+NX+,=TeI_+RI27(fZV4.AAL)RgJ8XNb?EN5:(&NHK>/JcTKQE
ZT;_Q<b0[.9=+ZNJ?#Vfbg0-WcV09L.CZ:JA/#BT)\@Vb/ITeR@HQ^[gCP^Y)_>Z
H5EXOfaQ8:L9WRCU&)Uc.K\2@b8P?5LDa#bBXG>G=.gR>@S@Z4(Q1-+SeTCK0RZF
)gNI4;YV\-dZb_2CO+AUTQ1JI)&-S1=GXUVfI2dV2<X#Z@&&UK>#J;BVSI[EWF:+
BPa.@2+DKGN+WUYU;5QTUF;9FHb#=<eI;G(88U^K5cCEAG>ZWI.2S>-Fa5aX4VcV
d0[>-)_5KTWfJNU3QA+X:W^P.^QH;1f(^#8LOE-:0:Rd77NdHX5@.\Z]VgQFAeWE
&3OU=J9(TT9G5Yd,HV:]@LH+2ZUXA3WE/BFbIM@I@e:CcJ\(,,\#2a0<U]W.165S
OR3N4TT&:P;QYPcX(XM\CJAU_;8TU_XF8,PCFJTN/UBYY6NS+WBY<,94R.Y=&Fcb
3WFAHNfd6O44O0/a/d0GTNLW&>?_b\W&48FOADHPN_G9T)#^[CgR/D0B;g[1FfW[
L;0;TE\/Rf&N.AIXI2,[<>CMO+cDLLL5=>,6ATbFcJ02IQ1FG/TdXc1,YMEZ30P<
fOdGSZ>(]M=(&5/6f.I[C?>C-#]\_8\cdb.GPG,RL<G>=SPZ[@<GUK.Kc[.IO&^V
N.&SENMVGZ#Rc;1>@eHG7aA8T1^DXK_RR@a#+3LeK)O?8OBI,[bL:fH4CX7B3+)[
CUG?99aJ,.X6?D4<(S?\,db2I?NQEW8^dfI3N2-O3.XO):Fc<BD[cA58?;V<_4>S
\.+S&OA^L^0bZ#PFHC6=WOb^TLFOJC.b5BXK9;/S&5.,cB3+SL4Y]K4dK-)0@WeN
g>@[<N82SGH/f&PKFHIG\b1BJ6]egKa#ZBP12Z@,a<,04#D:(8PC26\e+=b95\AX
1[Zf1Jd,888_16]PSA@K7bTROJ\QP(f\\X-b,,ZWH^5CF7&cLCDOIZ\)@#+(I4_H
=@1a5QJ-\[T52BG8[]GYaTJ:g-C.D1KBg<1f89GPTL6JH6[Ya2D#WH^6PX6^We0F
bDLH&0TAAX?A5AHKc#M-ZKME\5(T?6\F+9_e80B0FGNE]7Eg5=C^Z?L20\M;BN_9
aM@D.d6?PEN@NYO[B&c.bHFOK^HA_>AbFSTI:<K&Be9gKF[74U;M,)ZV\I.ZNf(8
P)I+ZG8^+QdSJa:]f6:dGG(<b2\R:9_<S#;SV+XRBEQ<egf\VOf8@MWbE1cg+TSZ
05R9f^O1:aO=L(L\<.)]86/FUC_;2&)F\EM9^T_g8<A&,B,ZA[^X^H/#\#)R4RQW
H2c(-1OOES29.KI,6F8.J3YGKD26IaSe5YL.@^AW^<TXTX(5VNU,:P5(#c0PHR7^
K:5,PXOfW&6\<;^/OE&;)ZFg2HN,L2K?6A=aG9A,+Q8[Q7=E9,=5J8)JTgMDAWa4
6QX4,cD_RP@cORb;-4#O3HW.cB6UfN_D6Y(;-?/P@(&I7EN^:(]1>=]4]-M#K68U
AW1=>Ra\H:Q43MK4Wf.)_-H9Bf)RN;PPTJg?/Qf(:F7I&6(T1L?NE#ALHd-Keaec
UHF&C6+R0_1;:AYbG<6b,PI3cfBgZP9d6YXMC]9-+UZ,S+.L8@f1cJ7<,PM+_dbG
eWFT&g53aPK6MdK_S+bb6Ob@)&cR3=;78]:\O_>90\^8Sf(DJY^/D#:]JVFU>gXC
@d;?Sd_9d,N5YfBb?S:/8-8^\B_-cZUGZMR.=^:WO)9LbaET#9&K95IQg0AN/+JO
cQ+)6c2BZH1)CSfZ\?U4OJJfP;-#JScFFSbc\J\,KSWC];N&bQ0?A@@ZO-5S@c@S
IS\.Z4U3Zb\R(7ZYGIg+GI[W+[T@UHQ&JFcC_Vc1SRBNQ>HDa7<N[DF2a785f<@A
Ad?;Y4XMH69;&/^E@_1MIeSVN/-=,)4)Cg?NJ4c>@=ZVRe&L&/>YfVXWC[aSaI0W
4K#AZ1[\3:;Kd6A?&U3()f>XH&ea35^T_U\]d52N/-&b>HU)aW6YNRTZ9#LZ/N.3
&7[,4;B9:6dET_#68(:CGb?6D3JUSVN/F>,)XJA=TE5PWN+Wb0US;UIQdLL0Y25^
XQDS&/#,PV:,b8?aaF^9K#:Eee3)(Ob0,a=d6W3AZ@Q]ML.^>LCd9d9Be@M60)RL
S/@RR+&d34SK]G1W=ePKYN-R6+A;-T\=c^XK>TXW8)>dL;AS:5G/9Y[_KCa,U@69
W1eU;B9RN,?K5ENf-Egcc[86=]C4F#J:MI)&C&XO([R&@CE-=-=R90Rg+7g//a]A
bL+gc.aB@K8TfB9b^UVAda1&_J?)]-GPC6=d=3>42)D.##a0E<VL9989(E8(@7EL
;,.#36@Gd?F;d33&LG;W:9\MWMDcRHN>-?<,<edLB4D7K_JZ[eYN\SA=E^AG^J(8
^DGDa;>,M-Y\c7CU_P)?9BfeRG=>:/(?&F0I)X3)&PUJcadDTD\<\^Uf@7>)\DNA
Q@1L=&ZN3NPT7E=3[<B7KaHGHAV9^66()(^@405UN)Rc-1&cN;B2XgWD?c?eCJM=
-6aA2dUN\V/3]^e[A^8KWK60W,FeX[\<217db4=)<4PU:^EceI;3=+XYg8DL;5gI
N&YJL#NE^5#WB23c)YT9ZZ__f<2&b)S#1OF]c3^Jd7+A64^/_:BB0D3J3c1<\#QQ
__(WW=NZQ1UE1DU=Q_8AKKB56_XMNH(cBLPGW\M?/<E1@^?;MISUR<&aH:_KZA0Y
4(WGJbVDa):TGG#f[K_:KOK,#<DMd^;c6M6M<]78a<K)HKZJCg+]&,^fRV,ZHZ;V
\,(VEM)2Cf)c\F>g=4PJT3]Tb_4:f)Z.[C[F,090?@\]bb@>]c/C?DB_JSP1(&cK
R2Q=/=#1FDH.RJUQK40>R#CA1UVY(ec5:EA.J\5a&[CG7WFae&@04@QL_NGV\&4V
12NU\B>R>R]=\gBb(H4,gZN,aR0.UVZe_)(T.20<>@#-\&V^T@g2J=3K66^4#;;M
MPES54(/.D&17I#6Ra4>5L?86-RIY12;^?b_KHUXT:;F@H^,[Je3+DZc;H-(G2Qd
+=NL[R<^^SQE[&:G^6^D[JQJ3SbO:BZ\Z&dBF>RA-c&N_CS9?E?&?\X8Zac\=PI=
CK6&<KP#YZEgHeYXB9^1#f85Q-B@[#GZWW-K]V?XB3556733eV8114?0/QK5g(^W
+3]]XeAH1[cbM^D/@9+]IO2d@]L:0]H;EYKVdJI_OfXQaeRKdaE?#1&>]8\&E?LA
;\XRCd:(ZYbI?9+B>]gDd=V3@)81,bZS/F;H6KQI#B\OITZW4E2A5-3#-B:LESP^
1_BU(R?A2[0+?E]05(Ya4g_-cMW85Y)Cb07fA_&120)f=(MGA]ZM.f&T2=:>UcJI
cD1O9))@e&B[TSX\DAfgEDBSQ&-5TeAC<\((?=D=Z5U;&3C8SGD)^:>b=VdZ0T@U
HJM0Jc2^Ug95&JUTeD-S&LFF2FO:]Q8I9<\<^aMU&g#\aE3ZUfYb0NXR#=U<8OG6
)8=L2:K?8JP#d.aE:-.YR,W\Tb2\V&5VVGcC;)H&TB=SKV+(RKe@0J9f\,6D_JN;
YHP1)>d8DC@X8-)dcX&]-.@+;_Z?5d]D7=3F&>dQ)GN)R\8]JBT,D?)G92D/4aZ2
/H6HGeOBT_D5>\L3.Wa/ZTWT,XUE9>^F._@>/K^>CdL>P2]Fa8<G?&8W1E;2g1(B
gJcF?e26Pd_Q2fQFc8\^SS[454.SDL)38J.V[XR1c[Og[6X-MUNM4,^H9BL&+]Y3
d(0/?)B^Ig0]IZ/X5M=A]g>(DW\Ad;\M/>If?ABN22We/^(EQNVK:Qe/IdbG)>UI
F6O6\S[]Cb-H4QJD7?CUJUUR=.fCeT2]=:1?bbA55BZJ)4F2^RQ^Y)7FR@F]QC\.
YEMDa:24GAQ=(_)edU&+#\M?Q#HL+FJ7cHSL@3>S2?>^2??b\_+/.&9J9IF6@@]f
YC(21B@+.72\2?3S5O>=7U)6?HXc17P_4X6-d)F.JBA\JA0V/WMX1?4&6Tg_fV>C
-?=^#Q(B>8XPB+CJ0efWeINb(-[Z]bT&?2T5T_14?P6#G9,.+?0+\]Y^4YM.(<>#
&U5KZ[]>9DEL-&.Va/>KeCcB.IBKgO:IOPND\I#V/Wd@@\JN+S9[?>2JZ6(N#e#d
23gA]?e-,@-Y7/PF(_)KR?e@X3PZ@^/8c<#0G,24&4H:EaM(H8Q&ZTd]U@/R/3b7
=6f@)6cL/fI?4<,2AY1FEF9,KK:MMX6c?QCMUNdc11OSSTXa0ED&F:+&4MDKOAfb
7)X4I,2c09ZGVBOS&=R.=O&47ISD2G3ZcJa+IgH7M=^[eG>CH?3F?bQ67gH/^3G#
U?-7LALWF(<FLS3(AY(E;DJFQJ(O(g.(VKW-G=GgKe+T^AH9K/?O?G-_2+SELSU2
#=eYD_9N6+dK-a2?9@9G49QaDRK;]2M6=@WYG?YC#JTa+UV?+[6U0f:]V^.-MR4I
MZ&[/e4<_=^,c7ebR1>;T96Y(H[c.;K[XACRV;M[[X3&=-&EKO^^f.<dVK[LFag>
TFR(:d@C5bLbTO:a3RA0]@.DKA3?5FL8^E,_-SGZf&BMBOW14D:-L_O(+;QFVa3g
,f#:/aFK,[WQV[;?&:KD+8gE_6a[K>#0-XAST?U9>)TO]4DFIDH;P(fBMQ,OHP>(
1Xe.U)BYY>Q_I62&:)LC@1)[V,/RaNL8TK0F6>25c4]R.QJ<V^)#;c=B/?RW-T5X
a4bLgR,IS0M.bGb0MKV;+K=@Z[RcK996_g9MYH]&W)fB?b&&(OIOUg5WH0I/)AOY
MfPH25NQ/<9bV@X\XN86d#?^U-65G)F&5QcWM#\QXI-,O)Q<G;T.LNGZ<-.@P;W4
Y>c.A3GXG8/>,?gHbNeQT/&J@C[BK&;a55\a)BIc8E-3_)?2BUScJge:Y;6&<&8D
&)HOSJOLQ:ZLZ7IfM_-(Z9_(GcR1c].g;c>69=S[J^Ya^9CSRXA+QQbCP<RW+F:P
0gP^HFPP5-F(<XS^-1g#c]Y?>6N7EGg>7-.#<3^^c[_&GH.eP>\7T2Ae_4@&\9gc
:Wb76c\;W(_;K2EIT#<.\9^L9:ddb9/R+@)#P6FYD@V]WMUNId>,6OS]\,R2[:B1
+RDb5(-]8NNQ)<3PYJ)#MB=Qd>a2C--E,2G._G+-B8D0[RI8^-;<E-L6=O^(MZ?b
G4HgJ-5_&4?TE3=[:1<E7]/T3T8UI9Q)@9U]O2PcQJ0[J3:g0<1SE#PY18FPIFI#
dEPN,\N2]7_:D65:W2^.=QU)=9/ec\P=eVE_-#5;_OF?DPS]30IEY#AS39Vd=_JM
YLb6^LKDEd;(Q0=fKWI-&:XNQaC\gW:<-@GcL+O#DOM\/>,fRPZ5B5K)7eHW#018
NVd6G81OC=3d3Sg/N[Q2:8dD?U&MAOaM8^GA,^8BbeHUUNb>0_ZY2b61@JIAG\&_
9[IF@13Y;T4&J8<0WLe4[J):&M=dZMT05@+RY/C6\fR<\LQS+?36g7.=a>HcVKVH
+@Tga,>P4Z^A5@YBY.LW9B/LMGVWHa5Rf0_0bGL2;)8U,ECH1@<OX-^(+?QcQ/.C
\?KRTBFQZJN7(c8FM=XGOQE.<g9K_9EG-QOCIENP4&U+X[SLJ7[T?[O/8b-B7FbB
I3EVCW=c++d8eSLJG>0FYZ)Ad9B#Q3G9_NXagK10Y4/1]IbV0P=P6+g;d?]F(MLW
JWLY)#U/1[NITX&;P[T<aSG8eD=M+[18gZ//BgcQS1LO>O7O0@)=J(MD&L;RK2OB
g]PCBggNb.[.^CZ-9:eO2+T@1@;PRZ(0JV/^dD>5ZfRP+-3W0X/FSAeYGK/XcMb(
NX#f]4,/_d]N0PMT60A]P,_eMc_&CZ/=TVBC-,Led;Q4@+M<[E?EY&]b.>dX#5ec
KQCG_NGF03UGa/=7O@La>Jb@A3g9U/C=-Fa)HTMbANJ.MU_A-;g4[3:2GX1MFDK<
f\+WV(8,>APRZZO=/e8K<Gf;(,[H=\Z5)Y/]_2\OCd>9Y?L)g6C;67Yd\cc;?/5,
M></\bHJbP<CCddDS^LWCV^adgd8KZ4F<13DUH-EGS[Ke?AbYB;Sda8XLV(2XRD@
,,@QDfQ#_I3]/7_3gZ5U<@KTVAC:<:<3UFOBDW.,+4<3WNU5<YZTX\W@FJ9IQ.W)
FFSXJbK2V@(+J54DbV7#f-aJ>e6.1+:_#-Y+c&:3L-=:)PXJFf8L;F,W^3\3]F;[
E#@?U0PDa148=LH<cF^M,-ffSUEC33Q>9US[T9QEc\,BM4:AMRJI_=5VR&>FDI^T
UC076Y3U,HUZQ>)3g(7.-5MQd3KN(9H#1:GWW.>Lc1cS0a63V<^F;J0Q@abY7Be7
LY8ELX](K)31/R^UDR4;b@:QXD];-M=S:HFg&;U)K4eSN9=.]BL>d=8)fTUJ\?4,
(W[;0YK;98?(7Md)DbO1Gd4\VI)@LZH5Z9E]+(4/>H;2PSfRd(a105X;.,BW=[+Z
>ADKY]J>XOa6MVD_6P/1=20Je-P-2g2&-?<eb=K6:S;,.KX6J)FH0GP)QGc6R^-^
2S]Z5;Zf&RMNNM?AbF26:cG^K.-Z#^#O9IP=HV[-(BM[&=/:3NLGT@LT3/+(27G:
6?/47\FOFRFDQ0=#I_Y9g6(79ID68?@Tfe;_7A(MQ]4]fT_&+f]FX5LQR)CRZ,]_
d/6.1M_VVACA5^+Qa()Z>VG\BN7aJ0e#(@S-Lc(fR4@INP[J+0L1ObIa3gTG4:2J
N.]?NGa[XZ0MGD0K]_f=1-(6(a,bU_\0;E_4,#cRX-C-GZZ8\N]\\KKeeXS740a,
/fF5&eJEOeb8DN):dG)F61>?0JDJQ4.H2Y@N287_MI5R]^KWL/O,<DGD)b,5f7F2
I-#6RIKfRRB\EADWDW9CU0/O8(+/\g3&WD7.42[T>>B=(@<A]>FSQJ82/8cS#f-?
VefQ@[T9\5HXW-DX:AcfEJVY#1CZL@W(J,=Ae>?_TbHM3/d5\S-8RAQNaO(W7_AA
_KZ:=A_<U1:Yf/Z-8_:AVMKZP4+LYQ?M4-K\E?Q^EF>2XKT/Eb>1]:68LA4WK7Z.
d^PHB-M\T:/G;=CWAGE_g[#CW8JRJ)0?d4b7IXB1HA[[bUP><ZHEeW4AXbMM2:6R
JTMB(C)ARc.>EWU+AF:)41B\LDPAcH<BM1V#4Fc=XLOOC7c-(4KE:BBO&7G^B&(#
[a<3+Y5=M4e?68]>cd^-ZN.-7&TB);dF1O.bg2:S_QDW>1)A+Gd?W@2VL_d:[WLP
gAKW\0U^<T6ZDZNP>cWCSeR7K.V):V5b0X/K&/a864d/&:F@\B#/1KQ-6(70>BQS
VV<KGa,&H#)IHU-X_(Ud6.BRLOS8\;/I8cV=);Z=^LO2_O?QNNY/-?dQ-=V5.&g1
DV2/9L6(GMBdAb6eH21QKF0VeILX-Ha5-P^XcP]:5Q/6H+TAd-EP0/X6KM\^:T(1
71Z+8gV(2OC<P3#2[R^>]T=eN;Qb+,AK4U7b9PAb;<-=Kb13HYE2T3/-A:4^+_>@
#FU]7)EWKeDa&1/1PaRAB)@92b2X:EYJRR@^[Yd&>a4Q:9O7fA-5+VMTX8PYK@;C
,P,<4NBX:A\c6Y]<I\N-9b^9(WCfQ^#_Z_Ea<b1<[;Qd^A+Q0Q5SN/E+J+7VH)XX
WGPO>)&-Rd>PGFSEJ\&cFYF#a5c6I352G5B=XYK#N1X=LaQS8563;@,&]eO]1#]@
BS7B.)c]be&W;6YOR+:G0F)&.C>.]<fK,2[bYdc(8+9#XC_P[IA1-JZ_D&:VKZdZ
I?ELb#8A,b56::b&]Y&J-&?^]J-fG)073#E.&gDU_<GP:g5C6N,#3/2>=+33H/S=
7L\#6c=&eR#7:EAeJ7Q;:/18]A&7@.V11-fV-Q/_2^::?-6eWT,PNE;DUQ8NHUBf
YQMPQSB8<L>0:bXZVKHE]]A\Ac#MV])N4dPefaKK_S:Ub]Y9LIMKMg9_L[\G:^[^
EQdBeNXc2))K7[A_6=?T_9Vg,(FM[AeJRJ)>fQ#1E0L2^fSg@1&50d_Q\;+4Y?bU
25^N)4^Q/)RN3\]dEO7d0cH-O)T&GVWN>]^OU7DfN[V]M9@Sc4YfM.XM+4?JTT.P
/;<PX-aFUB-6DUga/_/P#B)07H)3L9)7?Gcc/69Y9Sa.-FUe,=5aZX5EcB8(UW#d
-F+X#=4P4SG-;TfdIZJ,<Q<D>Q^;7a;D>JcE-^Q@BcR3W5E74Y&edT/7D0=1d:fH
ZL8)MCH>)-[5eO6FSO):I9(ET>L)3eR.=D81X(]c4^7RJgO8DH\TNRBN,e,-D>4g
f]GTe>B5_OfLdAb2fRPcH/9,bT94O3C/UeT/N;KQ>TOAT+IcfJ6L8f<66FGeK:C-
(c@e@XH)U_b,I(Ag(,dA16UfcVc2_[.;G:T,FC7f\dZ<GWA;B9;^aIH::(I1_X7f
?B\gUOF+gXO97\2+1:2N-W:0ebHC&-.<3(8=>ce-WePH9<=C=.TSe?0W87,\ZV8R
SB+\?-3E2\Nb3/),/M0DLdJ+#+_VE#?+g-H)We/-U)d)11^VD\cUUVPU#Y#1=e7]
BZ:@VLg7/PV,<6e_[a0d^BW92,09^CG7JYa;(L=9@U)-N@\+L\.@eCaGK\0HGER6
JD,8RXYa42X8#6TUGGJXP988Y]^@d;a+bVU9BT8]Rc;Z)J9M++\?F8Y]]Mb>6YG/
/J:WUL;GL8NeSM_OJ^,]9&?XaY6KB)fg?BTKMI-+V7+,);e9NcF>5Y<:TgOKg=D^
]WI&:ZT@++@g]O3(VBWP9G.-Z#N<WPPVM9/2dGL2VPAJBQ3e)_cc;8\BO;C1F9/U
M8\CRZR2O?_G]aX<;8T::T\NOFVI4XZ3]]]C-f2_S=M#^MCA@QegH^6#:1e99YS]
M/22IIJSd^PB^3ZaUa/H@_YI_C7Q9X_2L5#3(WcGA9Z2A&514I31)K)C)6VdU9F3
5]KeX)AAZ9^4eI[4?EKYSV\_Bg#T,Bf3EGJ2WI:I]Y,7bS\(DKd6(eP,7?#O,QeL
<4be]d\7.b\EWV2#LN8GQ]\eZEGV.2K#1H9@:QDC=0]PZ=AT:.N^1f=gfd3dMMXE
7FbO^UQ+@N_9O(HZ>6+89ZV7N@<WK<Eag(\U@<VBJFMK+LS5JEI0;&4=SY,2HCAR
XE2F[T?VM_E8PbeeUFXfT_58/J<6SGdXQ&1;UEdPZG3NA);BSc+G8NRU7?&VZc/L
,CAY(/IU:=&9/J94/_Xa8Heb6&ZT9=LLbIPWO4I<F&::;dWW5?BEW,DDDaUN;22B
/UbbTe<+b;b(:0He+5N[7F/[OO75&b0/&;@S6HPF1S:D@_AC_V;5F<:9#S=N>(7?
:G7RZGT/OZ#D+?MKG.VacU/<+^-H7_-PQWTYM?JHY-7BRT3=-2S4F_A2b)E_#TbC
c5M(W]@g_4^T_P(==V-<3NUN2[0.Y@fABUG.0dRMLdK3]RRE\+@I)8&=bRW1Y\0Y
T_HP^ZVPH&DOS86^)Q]c>8<4egBUd]9ELAAU-?a[Y2<H+225H\O(CPA]1K--E#\g
HdVVbHbdIZeDRPALc+_Je0RA-,&RGBaX;FD\_\7gNa,eFP:N@DVAYUP5@=]=c,Z.
AdFAd0-<VIb[cZ2H&3\#4?R?T7-HYf9T4[6:KdMWS-GR1W1WF_LbM=ICFRH_H&Q,
@=]]DeM>FOA(=OH8/g>,_X:KKaRZ#R3[e_HOM;S_6&>]VC_&SMcMf6R2:OLC3(JT
JZ:=:bR4OX,UJ[YRaL_DUE4OD/>(=\/bOdLGM;\QF5T2cEIM0M6,f3X6#Z,>U;a.
S)(T_?U<@HPb:Ug=DP+HZI0W;B/3&.@:KA=g86O3SGA16#.]aKbQSU)D2gT0a4d]
1BSKXW-D\6B1?KW@;/Z:80FALJb-<2\+-_U;QB6(3POa#3,ZH3aI/],P55RR01S<
MU8bLb?#8WONI4DG,3^b1H<>OB,7,;BN-WJQ2(S,Ag#/R\JfTT3(:KL/cD+D@7&]
CFG1@&WJNZB-&Y/7,A2KU9/I;.gOR6)=F@;T)<0&FK3F/W#@CM=:DFVd1^RcTbYe
d^&EcYfXJ8[G-DNaKKFbO25^?.HF;>M@,J29D#0;9H73[W_,PS#[K.-\(bOPGb0P
]#e?35G_&defQ[U7cK;3^/AK1\(6)EAe0)MHQZK[9ENXa(+J]#,^LQA7IB9]-+-;
3P_L3R=>/aT2-TacZ=0[b.Yb,J>2R&68(<VSd]_7K]9<+(B8RVUcW>/g5G=HU:B4
bOXA9\d5_IT21.MeXX:W@VcOC/80)6^G>9N/:S#;[IUcI7XbJ\F9X9.,[X0V]WgY
/.B:/<ZL:@NKd+J(/cQ>H_G8deWc_f?V[FE7VOXVc8N15YdZ,9P;./C-4>,db\B0
C[9/,U30dRZ9B#;Bg+XV]K9\EUN3aDBeDa?(](1G(+55_\eHKY^ZWfg4#beZDU/A
cZ,IDR-J?c@fTC9OO()6#>SCR7)M#Z=\c8A3?<cJDFc,]T9@e@V590b#>BOMK?5/
6[)ZY<-MeTX88QRbd0;]+f;7?bWHFg_LOXNVL?KA-UZUJJ0&8B#9UAW:4g1g?D[U
9J#KJ/W[)-859,e8LJQ+6e:c9/8<dDPUS^:,37Q5?3\5_ddY1EPF8E8Rc..F1/Z:
f1.<FX7=W[\8SRBQG#@G>OFDQ2Y#&A7ZQ&N[Sa>/L.AHR2XY7g/8#8(UIN,@<aCG
Dce:;MbgaK3LKQ[UUBa5ABYJ6LPfF<43^EDb6SE^g_\T)f(]6c?3<VE8]:RKH(g&
MN<0FZL59OIXf.ET]6:Ib8d^P@[#BRV+A2ZVHf5(_M(]38?<b,dL+&-]#Q5+0]Od
S8?[#C<.9.)NA>&a<T[LBF4R1S8NdW^Og+LOC<\)^=Gb?02f7A&BT),gg6--XQNW
NBG=<UG,I5g;[,(0ZER92B^E.S:=(Z7_K\,Dc0J_;J)CD^AYRNIdBB^Y3aKTb/9f
O+.,W:fa=/Nf3P0>Q^(;L6e?9>)Q_&T+@:264^eF;R;,f(QC&TPJY;efGIY(V3C8
9E>3T>=gB\WW-d3X#F.e[PPbXZ5d3ZXBUD\KP9RA4D<9\0(&38MU.M,C&b&A&HO4
SbAUMeY=>R,e(E7dLUE3)_8V\RA7K&S@g^NVJP7O5P?1&T&+LcX6c<a&.P_6C/fL
9C>(QgfF.EDW[K#5M3[]F<B;9+2J9>^2?C8LWed60>4+[SRKZ@f2OeJdSPcV#YBN
IL6,W7H_&6<V95KQW(+,Q<MfHJWDab.L)T:ONMD,0GcE6-)503CK.)\<>.4X,8)K
V8A)dE\X=F^)VBJ5:S#/UUG[[g=fE/EN6;;1/A)&OW@G8U9f-.8g?Dd>747R)@EK
[>7f]U#;B0c71[5cfC-HL=>^,4e(M+<Y3]6IC/4J2V:aY.[O(gR4C6Aee,^6WS,3
X#HA2/E1-BS2#=IW4_SDaKXAT@F1Ya^/gaY26ZLVTHU_X2624O1a@Od>BR?=P]0=
=M8_OW=Mg?\e.G<,^KS6]-7#<V#_<K&0_6<S_9K-FQK),_=#;K<+;/KQ_C^9H31X
Te,,WCcXP?Z4d>>,RTLA(,&gF)_J\):?\)IX-@]/V&R(FZ_)L(<0K9SQQ2XYaH^D
1N:gdZ#^eR@M1Z-&0BN0#P>Wdc;EE+c#Eb^6/0S>3Z6XQL/eLW=6/M;:68f>[bCN
b_)@P6=99RISg4gA@9T/ag6:QVFFYXU;VP(@^Md-7OX\<=,JYS8CMf--)J?2#\V.
3B&dLAVXXgYDb,4fU@0Z-]?-M4;7^PdbV;T7OAWX]/;RXb0&fK)ZG5B,C[C^/5KQ
_;JL<JXPAN)Y<:_9#944Ee0E\OeIXQ1J7GALdEaBH)K(^LOXD7PDF.dNfVW7#T1_
L,_4&cgZE5>X3JE?[S1cVbDdR7647Db+[?K<S2JZ##0)HNWecI?]&PB-bUOQ\9/3
:V\a8f79TA^#H>G))/]@WFB2=0:=5;fL5+O7eeB^WP#]KJQ/<Nf@<eLAN4L&@#CX
;]>5ET8AeV?KeTCC/bX--/W;^@32G5CZ\JK7&4Q8B;D,VH#BP>#0>Ya?9?,857;B
ZTOdCa:5;0#K@TQJLI1#4BN9(#4DFbI#N6YRM=)J([e2.[\SCEK]F<\GW+a;:V95
-eUd[69fM5_1Jg2^7XG77HRRG]e(0c&Ub=,-6Ib[?80JOIWM>=08CY8JF:J67Q0/
JGOBFG7]8.?HR33-6MVL_Qf9M?GSN-B8+7X=#K3LN@QF;,.a5ePA1XLLJRU^[AIJ
AK3/OX<Q2DT7LN54;:6UDH;/P[X3VO95:$
`endprotected


`endif // GUARD_SVT_GPIO_TRANSACTION_SV
