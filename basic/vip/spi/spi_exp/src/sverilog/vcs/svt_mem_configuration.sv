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

`ifndef GUARD_SVT_MEM_CONFIGURATION_SV
`define GUARD_SVT_MEM_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the configuration information for
 * a single memory core instance.
 */
class svt_mem_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Indicates whether XML generation is included for memcore operations. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * memcore activity. Set the value to 1 to enable the memcore XML generation.
   * Set the value to 0 to disable the memcore XML generation.
   * 
   * @verification_attr
   */
  bit enable_memcore_xml_gen = 0;

  /**
   * Determines in which format the file should write the transaction data.
   * A value 0 indicates XML format, 1 indicates FSDB and 2 indicates both XML and FSDB.
   * 
   * @verification_attr
   */
  svt_xml_writer::format_type_enum pa_format_type;

  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------

  /** Defines the number of data bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_DATA_WIDTH.
   */
  rand int data_width = 32;

  /** Defines the number of address bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_ADDR_WIDTH.
   */
  rand int addr_width = 32;

  /** Defines the number of user-defined attribute bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_ATTR_WIDTH.
   */
  rand int attr_width = 8;

  /** Memory is read-only if TRUE(1). */
  rand bit is_ro = 0;

  /**
   * Memory is 4state if TRUE(1).
   * 
   * @verification_attr
   */
  rand bit is_4state = 0;

  /** Name of the file used to initialize the memory content.
   *
   * If the value is "", then no file initialization will happen.
   * 
   * @verification_attr
   */
  string fname = "";
 
  /**
   * Name of the mem_core used in C sparse array.
   * 
   * @verification_attr
   */
  string core_name = "MEMSERVER";

/** @cond PRIVATE */
  /** Physical characteristic descriptor
   *
   * Defines the number of dimensions that the physical address is composed of.
   * This value is used when constructing the memcore instance.
   */
  int unsigned core_phys_num_dimension = 0;

  /** Physical characteristic descriptor
   *
   * This value is passed in to the first argument to the 
   * define_physical_dimension method in svt_mem_core.  This represents the
   * transaction attribute field name for the dimension (Ex: rank_addr).
   */
  string core_phys_attribute_name[$];

  /** Physical characteristic descriptor
   *
   * This value is passed in to the second argument to the 
   * define_physical_dimension method in svt_mem_core. This represents the
   * user-friendly name for the dimension as it appears in PA (Ex: RANK).
   */
  string core_phys_dimension_name[$];

  /** Physical characteristic descriptor
   *
   * This value is passed in to the third argument to the 
   * define_physical_dimension method in svt_mem_core.  This represents the
   * dimension size (Ex: 8 rows, will have a dimension size of 8).
   */
  int unsigned core_phys_dimension_size[$];

  /** This flag is used to enable or disable log base 2 data width aligned address, default is disabled */
  bit enable_aligned_address = 0;

/** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------


  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  /** Keeps the randomized width from being zero */
  constraint mem_configuration_valid_ranges {
    // Should be at least one bit of data width and should never exceed the SVT MAX.
    data_width inside { [1:`SVT_MEM_MAX_DATA_WIDTH] };

    // Should be at least four bits of address width (memserver restriction) and should never exceed the SVT MAX.
    addr_width inside { [4:`SVT_MEM_MAX_ADDR_WIDTH] };

    // May be zero in case there are no attributes used but should never exceed the SVT MAX.
    attr_width inside { [0:`SVT_MEM_MAX_ATTR_WIDTH] };
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_configuration)
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
  extern function new(string name = "svt_mem_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_mem_configuration)
  `svt_data_member_end(svt_mem_configuration)
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

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

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

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
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

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Update the physical dimensions based on the configured memory size.  These
   * values are used when configuring the memory core.
   */
  extern virtual function void update_physical_dimensions();

  /**
   * Clears the physical dimensions dynamic queue. This method must be called before #update_physical_dimensions.
   */
  extern virtual function void clear_physical_dimensions();

  /**
   * Verify the physical dimensions queue size matches with the number of physical dimension
   * report an error if there is a mismatch. This method must be called after #update_physical_dimensions.
   */
  extern virtual function void check_physical_dimensions();
/** @endcond */

  //---------------------------------------------------------------------------
  /**
   * Walk through the part catalog to select the proper part number and returns the
   * path to the configuration file.
   * 
   * @param catalog The vendor part catalog that is to be used to find the part.
   *
   * @param mem_package Determines which package category to select the part number from.
   * 
   * @param mem_vendor Determines which vendor category to selct the part number from.
   * 
   * @param part_name Specifies the part name to load.
   *
   * @return Indicates whether the load was a success.
   */
  extern function bit load_cfg_from_catalog(svt_mem_vendor_catalog_base catalog, string mem_package, string mem_vendor, string part_name);

  // ---------------------------------------------------------------------------
endclass:svt_mem_configuration


//svt_vcs_lic_vip_protect
`protected
,AI=,??#9Ega?fCM&Q+>37EF=>XD<FWBDV9QDT^[F<N4LW9^-CYN.(<HL&eJR@4g
N/#^Xg1-f5\A])H47fgc)N()V9I_@_E&C^b_eFcU8UFE;f?7KFZCIHdb>H48&]f(
]Uc=IE9/AO5[881W0_&1fC<1;,#+7K15D@MBeRHMOC#KBY5MWMSGB?dO.2FYJ7#/
R1^(gWFU:/OI;C@E.X^/Xd[G64\bA,f6#^[_C,Z-e7LIVJN@692bb@V:4V_V7&O>
?4;FgA=U5]1]\I)5SH&[:#O)>M00A8&ZM,5/QJa37KAfLWVSA-@&WL4P.KHb<Ke0
6I_>&W,bRFWC(2)dYW?cVa8782B<NPc;W2.-OIN#f4R2/>e+WUHf8QZECT9ePb-K
C]]Y=?DY_RROM/O8D#2]8aVK(HJaOREY-gE\,2\;bY59<9M:3@K4B7,QcRPYHINd
VO>^YeNRBA0c&H)\M9P51#Mb5]e-N(.F)Of\g0\:4J&M\e:Y.99_(SN;b6::9=Z.
QbGUE841b\=&]Y#=e<;UYM<CH,3We8>)>;-23R1W>Y8&]E=N02S,KKH:5e]WL+0g
CW6NZ[KS\FHY_bQOFccFL^S>4eMU#gFZbRfC#&;gQ[c_\&d_<MOIcW&G9fL:)TFE
&e465&g-&S1@17EZ_L?6D#L5;8&H[/.0b9,+.NX=PYNOCJL#=M2,#)=7;#7SX>cB
(_LE02(8Na#^]UCM+a(2IW6T2A)I7TA0,;IE=CYE.e+28JTL5V.T9@0/Xe#.+YMc
?/dT[d8JZ;D\&FU4J./Pg+Y1d2S_R.Y365N>6\+7_>/D^5Z^PAKAe&Ne#&]g4\Hg
.9-4[0==.3Cg1X,c>12DWbY17$
`endprotected


//vcs_vip_protect
`protected
;d;c#4#9Gg.WQ=?MF/Sa6Y_gJUD>A[#Q1;bNO\:Y>\f4=F&KOB9])(D=/=J(Z6;_
6=;-ZZD.:aHM2A7_7=4Wc(C,0^+g[gdQU+/U5g,<(d:KF.c:Jfe>++E</[.dRf4Y
c6SRW7;_9XQS-^gZK):_a>gG&CY=L>8?)YEP?13RPa<OK5TOEQ9gHdFTD?/P8Q-M
+YN(<)>K05UCUd<9eV4gLM>)9RTPfA<fa/\D0&LL]S5J;F_H(/4gM?9ZZGUL,Ud2
ZYP,E]HM:dJ4&7:0b[cbK)bUCb6dG&;fEK3c8LA+108GVH92C<T?#0G.I-.)TaY1
.QGA^eE^e=eGB<7&,_F71AOZB.cT^Xg^Z,Cd2TC8R;&R3a^=fD^Z,(b_.5Qa5_Q@
-69XXWb\45@g.,\aG,###4e+K7@e?+DeFf;5aVX-e=c&1+XPZd@7IeB?faL.6XB,
fL7E_#g3dffbC#6.\&^b].#7CAY9CCPIA+58;6L&YB2EZ,9+G7.0;3/Y@GLTX8YK
A)&>&8FCd#-5I3d0:B\P8-fCHIPP)^SBQc3M;#_25)Gd/9F3<Uc_/[\#Def)<-NW
Zf5Z796)I.U;89O9<OJL?:(NHAf?WYCM&^ZRD8dMDQ?J]fMG3Q(-F=9A[9fC+.^#
>?_9EcaWBY/C]dT2DaT(@_7MI<6\Ka5>eQ6bF?cH7Qd5V64F7]=2EI_CK^K:9NH#
?=,5CQ2NL2G0\gFO#WfbCWO9_AO+fNW2f[C<G..ALOOIWbI)If,LS?6SLS(8]bbH
]5X;NV.O[JECg8]N5.S;<+_[\ZHX8F/Z[I[2FICUJ2-_?.N/U0SZe>PH?bTBKYB2
9^M@fT9QF#M0>@X]LO(>+5U[d^bCIEK]Z5R+O.TI^UFR\(W(SYVX5)OWLeLQ7Y<[
U:;DNR&bTgG);c.ST]Pe1Pd>.;f/O6I4Z;aK1AF)P)Z1QF<FbXB@KD[Cg=CG,L#3
J\TK&=31#0X(#OYJU4)SAEVC1SJ[INU80KB.AO?eJbd5?@SETb[+R2LP#=EHY=C>
N]J0C:]=+4GRWHfBC<Y_7Y4b#Z?2]5EK;KPG#1<I>cg#Y:VWR?3JcTE)VcUAG=--
)d_5=_7F;6AJBCScMNKJa76O-2S>+G5HGPE.f_V?J0N.#^^MQ=EJML-RH@]84\J<
.46_Z#[g8?2/f/c#_CE#deX,6P?SFC&TO8X<C=SY[RcgS^AW)_<L^ScX_^A_>aXP
XS,b#BC0QW9JL+YP.3W2E18+I^2\^)AA&2d_89[WIA@T5WGHf6Z8)bAX)a4C#PC1
SS[:9O;B_G8F\20?W#XM&A3ZJYC-/0=C0S405L>1e?SQ@^[/5#4KUW8D1RVSJaB-
d]WGN<3e&I+Ug+_>cGTH2V;8FS&/;b>J.HUC5\.29G8_=+6]1QVA^]PR</FeYK:W
E<,<_d/=M=QTB88S=_X8&YQ5:=^ff(]T&9b<YA(d58fP)?QB)6>c/^6P\-\->8)K
L1fUE,,TR\Y3d3<H]Z:1eR8B@fbfX8F)P+-UXOaXW#?W&6M1ZFS\?H81J7@@eQYB
6EG+e98F+B>d^Cc)6UHPMDfZ)J1e3##Bf#=\[A@]J((gD#4NUH:g0Y8WC8Y#(ePJ
#(-4257Z7?\#&<cfS]W+-WfC.]=>/Ld/:C-f>[?HOBG,0^/XB9cL+LNIT_[XOe0&
bJ51\:U<KSK@4HU8^O6cE]+0H>F-08AF0(GQO6<DMT87BW>5J?1ddEd.+AUJ?]GY
ReD^H.(SaRH5HCL<CS[A@PC8gC&+JX5DF>S@^+CeFdM=S(KJY)T+bb3]S;eR&B=f
+Md.N1BZ@Z9WE4JgS5BD[4SG(N<POb2Yc853J@4KXK3GYWf.5LN:W<,R;=Y0?Lb?
Q(\VA(3#,&0gI<]/:8A-&WC2BECEgNC-Ve/P,HbZ7Q094^2MD<>[9(9@Bc7(I@IR
G;fWe2A/1J/F/+-270]&C;SO3Kc7MM/,;a7WfL7@+,aW3@U<^J(I1J\+7J=<2?LY
J?J^N=(e-CbaOR()&K>_cRdD@QCQ[<+;\>8)HN\9+<Ke1_2O_X/Df;KB\a[(QRbL
G]>VH8L=>-cUYHWBKH=fO:762Ze>:)>HE89K/]=(Q6=aSP@6<dQ98eV&Y+g8Y(Z3
D=/e3d19e/R-K8<IKQa]f,b=,B3WLAg40NHJW#GW//IP3cV225f-2807eR;NRg,N
0(2(N#CA3&L3c-F9Z^-0CL.X)+R771J9>L21Bb:fDL->S,<?:7AFINB,I/7TY/PX
P=TfM7KHagL718OK5-aD.f+cA3OQ8+-6GTe\1WX3;L<PCY>&BEgFeefFTNKT8M9\
U+&6acXOHHf,^-CV[];QDBaL0SNTK)V:MPIgNa3?UGW;;+.LN9I31M=Z^TTfVQNC
]#U#\=6@\A,)F^>62Y+8>EY/(ODIf=LZZ_=9PID[[XTW9]<K<>J?#?b&:&;#S:DW
Xb2\WIJfHN0NeZ;P61eGTT>/1d&V<KOO+IX<.H_RcUVRPI3[@ER6&^-JX(M73DFK
38gL=e&K6&OU.,>5]TYVKNLVfBT2Z]@b+5PD_T/SBEZ5T.P/#/ADEa2be-6.D?FM
ZN@^#Odg<1(+6a6H#PJVaAdA_R1T2<_@:b5W8Qc=8D/=3b)WU4L]38NP=G+(A<C7
1(-/(L.FQG&X27:eE-#RH0A&2c+EG5\.TA3gd/ZL/aQ-PF^9g]:0<4AQd6a2I<Fg
5a=IK6OH[QfJ[=SJ?eR<\(f6DCH+?MJ/\,5.a3aHCWC]96R<)W[K?]#B79La-\,5
[GQL&ba;.AY<e0&PU97PWX]8?RY\R-P1=I@g9>.-97=S6O/fJ\^+K&?/?VRZ<fRV
[P5g0a]-_X09O9geK@J57L3?\8F=<:S-?\<5TJ4NM_@UTg]>feMDCF/.EID@/L68
V.6<JBE+Y(_@EaWb3#Wc^(EcCGJf44G@16O0aQTI].;[Kc\_N2ZaTS+<=ZWB+Cf1
<(L7,c@3bg8+#BAf&>SL5Q)I;&/\SGFLJ_/P167;bPcISf44_QVY5aLJ0HQ^fHLG
X+eT7ScUfL#.@NSLQ2dXB:/b1IcdeMLVDN+LJ-/6==F\fb3RH4\:=feP02=QJS\N
HZP#^_56+@98PU:X56J=,XBE&,251b^DNW:ACfOOE(2QYOL6^U6HOOE-be6+JCP0
FEX0&Q87QcY[2HB.#96ZVG+)\G^WSS8,La.#c=Q?W_:[;/65gU(BSKP<3(c<EE:Z
/F.J)G0>4B0a9IX.(/(9QD6@)FJZddYddN9HY_./OX?Bc)\d?_d)R@S;+agg,S=6
PX>;E4JEU?G=DJ<W\cKbI3:^<H@0Ie#Me?40ZIWeBWGF;XV\AK=,\]dZ@B#2QARD
1\,V\WHf9H\6#<UJ[aJF^MG9<I[Rcfd=E4;]/g&A9g(E7_9VecPKFR[[XNT+GW:V
LOL+C[-C2JHIPbV=2<Y.GXc]JI]C4+/M[g\8R-VaT0cJ09<>B]_4#6H752/;U2SR
A/gTBYeN_MG/C2Q6FT&31[)S^+3)WP0PN8&#_M2Y;NC+B95Y(M^?HL;Z6g,KJ,1,
-IK6I.-^TedW&ZLW#]7Q\3G/=T79?UNWf//JLfQRFX5/M8f^04,L4]fORGdO&(P-
b[\=ef_;=Z1R<WdD-5a5E8;f_IG(BPB>a)3X_Ta@33fc:1.QcAP1D0[D<9P0:TOI
;S)?>Q<BUMNJ[K_](2AW:4OQb-_@]BbLg(,NDJT>#NVRZPP][F26f0ZU8D59-f;\
G;Q&J-3K-ZLa>=OIS>CHeTLMN1DG1D=3NQ#a8Ee;;_WN<Kg1#=I5E&#0J90WH]Tc
&?7Q>L8=81>8?21/,B&_EXFaHfV(AIDX32M/ZJ\F0Y?.SS=f]<Nf8CC/LK>HeX>\
>AU18U=K-CVTN.:+;6PV>=LAN&FA\b^JEK8L1N2=d.ag^1Z2=;HPS.\#B=#EDecC
JPYPbK<#eH&7#AHfS1,cWIY8fe]W\_@H#?>8DM@O_c[^7]XNFf[:c&@e,/J7aEA_
X>T,CeLTU&:/2BFN5GWI8G[<B5-U7XB8Q_I1P/R3UV5-0fMf]:ZR9#=2&>RRMc#&
cA4d5Z,AZ^&VBY\WLgf[9?DT4+JWZ/ZCaVdf8\2L/NSQ-g_M>G(Y.B@D/AGJg_BV
U9?FaAM;S:CG7d9:CKUHSJJ=ECfMWTcaM_9)BR-R+21cE89TTgLff1^]IPI,RXGC
<B1^cHc47O^2+2&:(K+OdXaCI#PDALE]4L]5NB8Y2E-BJUFL9>\(N-Q[e?U(FU)f
,H/.5WYP22RX4@]<T5G0@.ERd#3?I@V\YCDbQb<0/)9bH]_Y&8-.X[COae.#0NMg
L&a_XE#d_V+f7LI@\PK;I[0D[S]UTUE)0TCR4&:&\U>;U.;N8(Q60&_d#KPKL=KZ
cC7J^LCB[122eQ7E#M<;&6UN_2?XVNM_STG)FK.6>:6&][N_Fd(cf5;@8+8,64EJ
Q&_R54S@HR]MH)I9L2W=5[]B[R)9^13C.@=>U<J7Ze>@.E#05&)Dd^[;#3e:^3T3
aG[Q9&=Ra>J=-)24;PA::UWZ2f#g2XJ[8(ASO0cX\LcQO&Z,W\a/O(BLCVT:#[bQ
DI6#W6;//Q3)]K+9-+_,Y9:f3(>=@8Y@,7?8CdL:OeF2/AUNW^,JOIA:2d;O;[?A
#TFWY39aS1SDKO>,)cU5PGW:IBZUZg9;6Je/]Ac9==6?7PW][ZU0HM]T56=Pa7\/
LQHC)K[X)UX//(\H62NV6fQ8dTD:_0&4JaS?^75,P@2d#81&/]70)+@W,O37-]IX
N+;IB(:/O031U([V99<GQM3_Ad.1[0gX.1+:1DHU\JL3L/f[6D-Y-HfbMW?I;2#,
R&?AMKS,KK[EQ4+-=T<\@1@=Q3b)FDG>M/f^^OZJ1e0K=H]6>f\;NMV#]P>)Lf5I
STB+?K5D?&BH.acE[MS1J[2TJEKQUQZ[\V5COFZGUGb?5T#\5\[A9DXFDMR]ZeET
46)0F#QC83K?6ZV+ILfbc.+ABTD]9PRLO?<=0b-ZL][5Cfa^5<9e-BbS?5,g+[2G
UDd5XV]2)Og^JZ1LTS1B>#g,U#K4V:e.dc[IRcXOM:FDgUf+7A]BLf2D,6#MB=Dd
V4BISL4e23[:g14f?0(P^=LKFDY^@=KD3/bE4C+K&XbROPUbO8)7Oe=^Z8BQaf[G
&AGPKB2dKZ:,@b6]f1\VP+45A#d90(bd5R^;3N]3<YMScE]#LBc>3UfMTWed0R()
\EHVWOPGSPIX;^W?>QU2F\T?HNW9)0IN8M.CRJ:I:#]6b611,79(#^P+aO)+)d+L
D.G0gcX=bI8Q9S5XLOA(dZ3H:;TA-RS5Y]UWd&74]HTN&@F;JTFX/Gc?&c3H^BQF
(fX18a2VKg4?DB7dVPENA12e4_X6D9a_-:Ud0PYQ@N@S67PDbE[d>=RcKZXY-c6H
X=E:A2>0TC#R096,JIg_/QK1gZ+#P3H_I_,f/DO-B-@HPFYDcaP7+a6CPP,#Fe2O
MX,Rg1282^?YX#L&]APW4.#(HB[/D1OTd.g7A8_9W64IZ:0<efad&,@O>8K9&bY@
>XfY&e4<\62ZC;[G_I/?Y&.>Y0Fc/+@\,DB&,1gfQ,=c0W6_8X<T3Z@_77I4-fbd
.<_M9O+4:M^^6]d1Vae^0WD-bY8,HT7LJL]0HH(GNd;(]ad)&DaV1J)0;&:A&dH8
?cK#AC,2U9WWO1_3d,Nd)=>Z?Ked/+V&9Kb]GC2(2[=8@,1g/8394@^O0]?/GESC
d5;;4PC>;#S;71O5bLf]D_+S<c-\>H:)SM++0Uf3NDFCKG_/XC8Q+7_^7=f#;;C-
GfZ4b0/X;(FWWX(T]3<DY_/,A)gQW#cB>E(\KdN_:5&S>0TNM]2H:J<FK)N\EbaJ
Q=\SP=#>HB+:>C&9B13.ZLV#,@^F006QQgQHOL4=N#3#ZJgJU7Ia[U@>QUa:6JL_
6D3Q30K0.,QI9^])&APBZ7HCBEF<]P/G\bU&,CaDN<OU-T;8(7\@E]1=3FXeCJD_
&C(0Y7OKRP4.TGBE,-X/HMbA)fZS(V,.4))&#YbS=U-bfO+JeeZ7>@CSPc7>EJ+8
LaO)\Ca#W;.g[TJgZ<J.@eHX1Z+aNFA3T[(D.>6fF.(-WMS8Xd#R_F&T8B\]UI/X
4L&f.d[0L488Sc[YL]:-0O7B?[X2c=E17QeKbUYI3]Z^:O9#=>IHU@28;X02ZU0U
KD5Ca2)5@b]R-ART+OO3&R12aAfd-Td4/C:1A,LdL97SDeE#-RE>fI?-00f+@66-
<]ST6I56<&WfWBI&P2eaSDM#(HG03]Y;SEL+:X9\6EabK<?3RH:e8=dCZeA&,E=3
C^fFcF4J>@f]DC-cT3:aJ:8L^/#0MAABIM9+0SFRcT;VcPNf6=f?6,YaS&H;G)7^
QI;PH,>(:RDY@D4J^[3+:GMOeY63,,IbDQfa7^[4@aMMW<?M;.gc=R14M\433F,<
3<<Mf,]SYc^6M7AC2/b^=6H\@dfbEC2_LPddGLW]GIKSHXVT,@cTIeT52cdCHP<5
87R-4>a6B-Y[F?#6NEZf_Aa0+5)0gF3>R_J7(#fZO]2(b?QEb,a.e@PUQ,F21<3.
,J+8)M8bW67Y6R^D98#6EPY.1./&ccW]afKV)>((YbXO7&S4/=)4/?^&1Y7gCP@-
P=0U[P1^FM7FLBV650OXUFY?R&:A6d<5#.X.OI[\S8XVd;8N;FMfEH),N-^eVg.W
7,?L6Y&)1I&M9NZYP6a0XVT@^>Q@&\:^ef8@RO@QV#Q#b/R1\UMg+)Ab-b=:=-IK
,T=e;@Q[B(7T=;J#TS7=8Ac2XT>5]H>TcQNV-TK)5&)8.4W88#PDHY]8^KS@H;,#
FE/<I,f89F]S:1?J4C(,NHceLO6H9Q);_,1==)LX6>AJdSNMK/2+/FgY_Ucf9MVY
f2H8BK3NOb6T4(<#@GYYQBePNgeg^JB8_ARHFPXK@?QeBb?Of+C8V+7G3gfZH[W4
R_1UGDe&##6@ga;^6e+2eUW#E6JXF,6UW/3^#0<Y-I-BB<R8\SHKZd[;fL<MI:Y7
/N:#)3;]V>^3[YD/FA[L#GWNaH7]a#e@UdXRRRI),8US8PZ4?a58a@I]=_U1JYPK
R+2fNXdQ)K2_VReZ(]#d[V9[/PVC32JTPBLD]5PS\T\e>G07Z.L(X]([aZfBSEdH
TY4CA[J(EB<@X:Y-52@?35aH</(KJ10[92^S+]<PV>KW@4eZ#77(@5c1?2O-GM[T
fJaM&I(<gT&)_8N2^4M9P7aIIbCHIO@fRMG_f5TLHJ_^dUMTEbe)&DELbY&V2/U7
[GIQ0W4F-C2E#/a\W7)^K6LJ^2EE]O3F@Z40(IJAX-f8)H^fQ_-P72J/<W4Z=88\
;<3\/ZG;0@6AB7#M=;,I541bM4?G8_9NL<-1J3f<DX3a34Pd+gfI\JK\C7d-[3b4
F[D2A,GDbeQZE3]8IF@;\+Y+^dVbR9D,INE4#:)QL<SfRS87KI^95.GI9^C(WaY@
<O[aH]\>VN2Vg0DA:-6P-dJ@R6,8+ag1H(KfDDZZW;S2.@WFQ?(W38>&TSW\0IYg
0(2PFa7Ua+(Q4J+5U(1aR_c\>RP=<(Y:Jgd_+UDb<H^C>:]N)NMUJ]UV2#2_;](d
QFQHe#7N_Ya2BD4)PEgKJceNL+]P,08FP.bZ5)efE@K2[[<<ae2Xe/C;0_\&ENDb
M^2N(2,9KLM1;gF2JNE0?T419A,/LZ=)71=eT/<g89K(1U<-\(-HZ<T:NYY2V89T
cLYX971&R5@Z=,L>D_(eV[WUZ0e&H(LGC=L#&EL7],ROg(-DRb1PPWVG)88Ua8GI
&#57A[1F:(FE.ba,13&M[OA)V&&G8EGMV@C;=ND\B5H/JS;6e<,QO,CED8N:YQge
>11_]6,3U6+Rg>c#ecdMKf124gg^e<KB&6F6[X3#XH#JY0054c<WgNbNN(L_c@[7
9>E?-Ma+/7M)-eI:Q7C-[@<>DGR)OgV[G^JNA1^;eb>1#MM[RS(BSf@YB_bFUM:d
5g3\P(f[^.DeTDV5BW9d]fde0CDfJ/CU4RXK59/=.69L;&4_W)dSIg\bP[)X057)
P)a/C/WQ7&/)TK64NQBTCf&WHJgaW8[/9D+]&@6Y)N](.X4??=e\_N[/P0aUCUAa
K5T&Ud3J](-@9XMgS?#4>?LU=D?ge/JRFE->8EGI6GWW<S)c,/>4&PWE0Q\Fb3Z4
gCZ:=B(]>gVYYU2/KAgAd.E_+,)&e7V(SN-bfAg24SXLXJ5=a\@4B04gMKNCACaH
fKSQccIU2UKT4IXFGg)MLHEfSM39RAQ2P&N0B(dZ^1X2C0a_3YgZe2eDg?ffAM]6
D&g?KK#>V=dB)UbWfNC0-VOBa/\U0XP0d5.cERdF&-LaY9^IS8#?(+X9ZIUD5R1U
3(8G>M#;#c=VQ6E8S_?->L](33_L8QEXa-faTVY]BeP9WTB;#>0&R?gfJE(K?TUY
_gT][/AR^:_c4]3_5U^2=<#3)-?]9)RIO6Z,6T06R5<4/@(-CNIDMF8&@g^X(da0
44e1X)NM@R8]V&+MQ)ONfgA/-,Y4.36Z_RdKNX5U2=d>f>Jg&;M-4APL]2b5(C@5
F\VcfNPdE<@:CX3<I>2^(+/(.:_W\Q?;KQ.IUJ8^FZb4UcD(FZJ^9(6f&&@SV^Ea
Z;WN\V_ITM?NL&E3<EXI/b83]F/^I?#8]@86,U(^(8MC/][cA>;C)9:I@C0eE/U,
S/1WH9=eX0;7/L>BeLZYJD_2HJ^)EV)D4PKE8T>R8CS1@cgHM]_#]/]BH.HJII4W
_DCS?7<Ib?IBW:9MN@E#-&aY0)3YA5/,2+,(Ng_EY;\a+RJ,]3XdL<GY;W60A#SZ
N0A(fOW36Af-];dg0H\]-\#W97H/.)BNU:QaVHf+Q[5V?3.,X[+E4V_X>KA.DK^P
Hb/eDT(R&;4+_9(I-/eT7C+LGCf]X-S9S2dNCR7d_GZ43DC7]QOBPeC.d8fKNQJV
>7F&-IgfRH?:4JM/AN,-D&GUY=g#2:K\b8?Hf)2AfM<F.2S[(3-b5RV8P]C#&[.:
8&^2^9@NX,MP2^JaSP,3HH37Wa\2eJRU.agW][eMVI]=cJfXd>db]C[:X]eJD&0X
&S&\2=65cg,Cg_K.[H=F72[6)U21.gU;FILXf@VcD4Ua3b37J-1]6_EH]QaX-d5I
8:O[eXV#85<ZSTdfNf?)9-cQNN^aFN?]WV8:[A<]=Uf=A/B3AATNV&F6FY;(5[PX
]6JMW5@9E@6(N-.KgBM(2=W2RJOd\?H9:QG_A/BA[gE_GRXRNRJNPgfUN_OVIR;Z
GU<C=<UF_]9_W[OOg(@GCcSgd/.ILNW4)/67g.cEGM4]J1R[;IdG1YCRLF&de#+;
f)<WC4[XS_\H6-E8(&]_d?.5fb^?G=6?a/?K<B3DSOc2R(B\&QCZ)VXF?G-T(bJ,
/.\4[L0U:[T,^@^?VP]9\@,EbOLQ9UD1gA<<?/V-Z,=8Ra(]-P^(MRACCA?QN1PX
EdMNWY,CaCWJP6-Ke3&C_J11KE/=A.D#9#IKPV<M,(@/#-F.f8(M7]L35K)f)fK^
Q9DI@E9ZY\CQ6&@b[(a7e;48N@_IV@;\/_MNVX>d+]GcR-&,0b-+dW3f^MGc53[=
^9ZU]V2-=L7#c[O?e5W4BVZ.cK#D,+8DRPBFI_QVDMO_/;>(a87eSU=T.Z.IB18=
_?7LX((B:^MH05_/>F08J_15W@1@F6/I^2cS=Qc@-N?]1.H3KYX\WSM,UPDHLE=N
\??03?eCN3(G0P\T,XW/FFBK7V5gH]VY2Sc[\H+7HYg&G21.(gGRfW5_E=ZIO]7+
8,0:U99CFD5CG_/8P?907YA325UYYZI&I<fO2XUB&Y8,5?B=-5_[Z3cfVH,G9^\8
bP-ZQ\WbGHUIBQ@&Q_@,1-0J2,1b/,a^TD(&3f[cR507^E[09LX.LE(ZQT=@?IaZ
#)##T,6aJc825TLd,73/RLG@.?#KKg4IC5-#+<;.&ARE7bBJGVF6B6;^O4_WDdEW
]+@gNNcW#(O6d[[Y9g:Y9]a5).2-T(-,eaFDM/US50UE-KKOg3aGTA4UbF=b8gcD
g,@SZ,NC7&/I@2K7TB4/;MY9/IM:e(^&78b&D>DRR^/MJI:;\)Da>9W>@)9cBgV5
/bFZaY2+\CcNQZf/1dL+<KAVZTf&52CUeAHQbC5?PW<JfVHe<JI=<E,g0>1WZ/d^
_g5_V3,eCUC&P\<5G)[C4O0eANa<.f<V3YH_#=0.:#XWR.6))5[A\-Yb.1)89\Df
X0DHVEWO+D-d-+B(K)7\Z&=#\(gHO2>JT#<O9CC:M_;=5<.#?X8TP3R3O^R1+P/]
N5D]5&.<2]P3BGg+W+^8/\I2=^7;C.[/T6+BOXB]gEBM3fcdYC>6c<ADWWWT/G5=
FYDCFa9_7S[Q>NT-H;?S75N5^#;4/,-1J\(>CGU0(?W]0VWLPF<a8BW&8TE[?KOZ
U1EPJECN0,43f+.+E@__R0FQ?Ee83M-@eNT3<;a;SDNC.:S,ZL\:D0c:FD@AEF)R
f4;N+R.+EefH\#SM=M3A<8])[00Q@CXPU+=63?[86IeV,[=5?6cEbNO(-/0H]FP3
9Pbb\F/g&a1HRUf+<&)RV\(d-N,bbI_(d^5H&QDZ8&D-NT5WJ]1-#9@fW->8/2A0
MX:+3gZ1I8NXO.e/UebUVV68DT[\DW?A0]/)DPb0^ET+>AE8/^?WUa6VaLO??9,>
FT?IbFK&;@P5;_bJZC09U1W./^\4,b3>0aTZ\J+^76MVCB&D3V^=ALP@X=M,=O_e
)e@3N_7P/aI55bGB/+O24,>S_3\,G<XF6K\2:_6(Z5A;(3P85FC0ae-7K,MPOHC_
R(\.Q4XS>-dFX+LB]5Qf>40=.:#V/;CYf&A]a\WeRCaaK/UISR+XdX34+OEKM19)
0L:=7GP++5cg9Cc_9.OK?\BI,Oe2XO:CD3XQ[K.HL5Z(MR;8S-g3]Sf<I\@3cPUM
:\aXCNFK<(W=I3<=N](-TPI@5#Ke-L0E_g=gB^BV9N,_.A/?>Y;<SUXSPV.+QEb]
_?^K.\LZ@K8LDKUFQV6J_5062>G1K0d]B9B>dY+.##W-P=V?@=EESO=87N]MV:+9
<8OaC@\@XDOD894C9IVP6#9^8L4/CZ)SRX;64fH^BS987(V^d)OfbZNL9OF?BE.I
V0B2&c&8_<J^](<#Z0,(:cREBH##+>.J,V1NRJ&f)P&2SK5/TJEZ19BgH-AM,N\U
C335g+>H/GOV60/8M>,dM0T7]9_+L9bGdBT)EU\4]&gD?EOJQMLEJE6;JP1MPGC=
-Z;LHVCeHQ(\H=V1/#fN0K;3.)KMC24b\)6ALW:WKS03KG;PR)g\:7gQ-Y#H>]TG
E=&YDW(4A[7IAE/)XBT@4KN;YA<CC6(1fG1)E?M7CU0_??P^-X\Ye>\^f>XZ>7M;
_JGDc.O2)V5,bB+8H[MWPXG^7Bg[^ee;WYF8?4V:I(;A9O/R)4[2XObOBD#gc.(K
)T)+LF2Y/)SQA:;+J+@691HGCD3gSgb8T#Kf&I-X=^_6/Q1)@5459SCEab6f)U\Y
K(#a(J3SOaY3B<D:X#14[/BK7YM&F^,(<#1DHA5Z>NA2;G?O\+1?18,K#3KCK?L^
C-HdD77KFc[dA^6MIG_(?_]MQ\RUE7e6\8W2bA(K,a\#5<NW=S4LQ5S\&UfM[9&(
;U<fD/;f/e&8;D>X_S3X]^c\N9?/16Rg^2Ne1eXB1&<GKY2\>\=5U+@71=T7JB<b
6LA5bK()4/A>8aYHER=U<.CV.e10bQZLO_543.LX9L>P)Y/@#:B[77>Y:.^)Ra6Q
QgT):@a5_0XC-Sc=<dB:@/Gb_;f#IYfE,TZ9D++)4Da5_NB^I+TcQB(:AFW#>4[Y
<T=ZMfP6R5UTINZaM.d0?V&F:AD0@X]M#QHYGBA1X+TFZ?-1;1S<W\RAc@-d(GAA
N_P3C+3X;R,08A(PT<CNb&XD)d3&.3I5?]6@<=b,FRT3)V/74^2:S3FCDI/FN=DI
=,>b0M=K95Y[]V>+2I:>fB.^7]>CO/=J0Ec05C&MN4V@6B29_;9E7?:1^F]QM5fC
CH?d7ZH>5OE9QO._gPcZa9+2Nd3UJ@O,XBd8g?^ZY]>P#O\>NT4KFg(eV^VHfaN\
)3IGbPg/^L5S_KAIP63VDSO)&313E1Q^QH(e?+8^I,ReOaa+5bF>f1]e=W/(VPXb
X)^X_b7/J.WT.?Q;8:/agQL>R=:?NFP0<>KQGZBBXdY7VG/C=/H::4BgM_TJZ[cb
TcH9>QfS?g?U1a/;#f3X]J(B&SSW2[9Ga=<M9A(E\&UO:4OH<d[\&YIV\0)FKX#F
DAKGFO@7d)RFafcIVHI)D3^U3daI.FQX[6JTVE_M[YN4fFV7c(0G[ECR.E_PAJG/
:>P6M=S45eY_.H(3-ZMa;M^R^]QJ3(2+SUPg]JT@a?7g&/K=eCHC=AYLNE^.P(^[
DcM;ZP=9QNV+FMUaBfZF[6:F\:QQO(XZ;212[VS7@[8:Z(<-H--,/c9V6Hc&91#7
EK/d,=D4SWSE_\gB?EF#)a0_^d,L69\QBAW2V,>9cF0a&<10<SBWN5:PVB=eI2bW
be49;?<UG85/9^CO,7E:()@<g=2Z0X_6Bb9g-8ZfG1E0G@Z([HZ/N.eSEaR7\f::
bb5AMMRRS2c_RbX22&H\N4MFR>\>73J,d_8)<;+]3Ug2I2((4#eM_V]W2PSTZ?f-
+GA=7)PS>H^fd)H&[8YRV+XCIOW8f@W)CfI.ON8Z8M^2[d&)a<e=0A:RG7_LR22W
>W[KRcA1HGeL2;d\g598Q_:eOQgaZ4I]JK](eEI:)#<4OP4LK:7IQ-g77LB<KPF,
,@J[5(;><=CfAO?1BZ4aZJ&Jgc#X4_aCQ=&LY]\O;0W/AS<@BMB?5dT:XZL]6Yd-
:&C7.Ec9N@#<e)49S6T9?I3E\5XV[8/2Q74+^#QG2@8H2\/\AX8AX8S5+8aQgZ\N
-+cb7Y5#(DTUOB+#W-1;V3V1e4#52ILd9YRDW=T.&aU=4LQIcG214/JZWP+Ceg<X
8g1GN?EfJCGeU8/:7b)=OO0</TM0<:OeS19Z3d\(,/_Y+eg&UY^OeV?c:^O79.-R
b5/5N@?(=X_#UF7I?KLJWKa,G5P+O+Eb_a8IN.J8a\++g4X+5;C7eV9ZKD2\.N^H
5L16Kc6b(.32G\gf7WLeSOTI(QA6,DG89[ZHL)b-,g24J^cg<XSM9Q8-(RS6)F2R
2EA)YTcN^Z&WM1:fRg:W[6YbMF/0IAdZIB,P&V-2SV0,E=.^7\^^8J_>/6_L6,58
V.,eO-]_M\H.MM_F#D8Z\^cZ<@>b1YADUc_d<.Z2/4=L#=\WZbA(#K=g-.&X0YPS
&@++GO^;T>6Y_M\L..0;.Y,RJ8K9E-,R@^/0MF?TZD;^[&CLI+d2;1+<T,-/.0:d
XW[aGSS/,&RBWYcSY8WO=A4(RH?QIJY,3.T36\;S?C<Q(=29>ZGMC?J<GcC.CF+>
.X+@5#UVOSK8[N2e\_5A>?U709)(K<K&,F/(eUc[W]cf0T&/9MX)2=AZdfCOfBGR
:T1N,7HEfEa7G<IJSDPU9MK\[e.>;^E:3K[WO+d_2N(6d_F/=0>NR=EAY[_TEBS)
FQ(9DV-C]Q;T2XbG^BNWUGcB,&M8cDTZ&dL0A;.)9CfKRLWfN4S2Ee#U>CSY(8gF
M)ORX(N&XH(4E]MUdWPS#N[,1Z08#3P+Z06EX=B.;eO4,@JL:dLR&_HX\,Y]WSac
ZeHP-&NS3=0P>R_=L0Qa6_O7;+EO:0VISD+Y03N)XLa22@GS]C.+-:TEC_7E+0cU
G(I&[[c+fEeEaQ]0e485QR2QG\3]KOV7>@J#@19O?M6eP;M6dBTedY#DL844)HU)
8J7T;)J7G5329cTD1^)a-UH7aV,&GZJ@8a^FN[#2S^UWVS32g4/VQPfC_8IRFf_G
F+N2XCEP^g#be:AM3ZUAaQ\./Obb+CY.gf3K8H+.8H7[a&H3F=QHZI->1UdP3R&[
d=V@J/QZb/OI8(JAD]M)O)<2C);V2-3c6?>;UZ0HQ58>Xc0SSQ-f@Q/;@&-C;85J
c+J?.3T61<,(66V/gf,O\^S(^6Y3CZ7)L=_bf\@cAVX9Gb=&IQ>IaF^BIC@b)S\.
1:K48?G5/_.EO)a#N^HRP>Y5LZJE\,9RQ&YVME]:.&gfJ6NDc-,YT.\GK&bM?dG-
)GV^=9\3RFQ17I<:_5Q)JW.-Fd@,<E9UV(64NN+O>P&S&T_O<X_N^Z#R1b)EGDUR
+L6Y#D7KLEAH\+\##?2M8?c)dfUS&#LSE:KJ9N5S[A8PO^e+51(=H,L>eacR:3OT
6=g]#MK7T-g61^VeG8RG&^KXdeT33CLfc9.+D[abJ2<R80YP>)WDUME.A_A3?]@@
ZYZW,M2.)3C8QJW.C1RY(5Ed.J/Db+JLHDWCG[<^3]L&Z[KAY.VM/8O,>74>;J/8
;G#L?cN;dc[@9bJ_KJ#\LBO#]HUU5(dOZ8gA=_I2BbZMTPaTQRC/CJ/dD9#F]9=X
A6e?QZC_?==b(@JdIR#(I<YZ\P/@T^&N1:AY:3RYeN0RMR/7H+[JJ+YAgV)9ASg8
eA[N)6Y;1&]8ZR#()V,B?.>Q+>[<V/RMV[7O3#\I>a1\?VN]TVD<YR.ZU(:dJE6P
,Lf6-&-8Ke7N<Ze9?Z8eQa<LJ.#TZOA:_;2?MI98PcaR]EOMCOCK,OIg=3F0U[gH
Jg4?V&GL]N]#UD.0>BUf1Y006TCLC;7\(PPIQN-?=9F3S^KaFO1@bLg)B=._XfX8
H?=d4@dZ8W-5+Y\aUd-]Z6.)P:Z_6VaR/^EfV:&g&PbX:Eg7-_KK3KT:3bA?cFf3
M550R]O?HO?4&Y6ELP=-]b-/-QUH<E/b=HB1]66a&d1RKCVgRRALCfTV^(>R6-,3
MCeIFZQW4=Xg#(ELBc#RW3F9UK<Z_bXJU)e0K9V9bCD3dB2F+<ECAEJ@Y1)<NQ_:
Y&:1T-EK7A/;)g9R\Z1<f>N1F@3X9][_R9I4(BcR16C-,CDX&;EWCXAY<PB,HDU)
8YVR^e]>L;g+R#:-)W9\4DGX;H&dQTGJ,_:6Y,ILB_@:ISNZIZN+T>(Q]0J0+8L.
\e8FG83d]RZ<V=5VB4C(WV+Z40U\2H>Z\e:C]0IOV(:/1)04-fX1UgL]4GK@B+@#
<102D3#Q92-cYJP8S+.bBHZZ5(^(8WFLMg2-GG<DbFLTHbSVI>4N0WYfV)6d2^;]
7.N.(TQ;POY,L<TW[HD++#NXE[cW>ME2BMRAFWAcdBY+.?@cX]&R/L[<++0KV;CT
W1[\UMM[3YF6LccX-1;3W_fgBW]SSMAWYC#[0U1OAXga1\D5bJF-QI<C(HN32\ML
g8IDa+BN+O-f=\NF--:[NZ[TYBE0-LQNPPXF3CY<?gNN9>+9\I3bG__D]S@#XE3f
JEC<28E,=Gc1:/F]f])=Z_+a<,5EE4Aa;UW^3>0_Q4^I[+X\c7QWb/TOgNA2BF]&
\<5G@a>_PK]#e#IPg+dXc2+4R4?V]^]<U78X/6T.TgV\(cBYg;N+CQb@;(d&@TBb
EN.GO(?T.Z0.1TB:M=CIE77Q-A9+,dM@dg(GaHV=W[1GI@.F]M\RUf@5YS(0O+(R
AIdWW>D+eG,ET.VYE#([E5G&07&NL4URF=.d5T.5A,,5=dc+OH;63-V^7afG+VR^
=b<_<?@U[XKcLM)[fY(.3PR4<O&AHY04:/V<1.A/d-Y^bd@@W/E:]fBXJH_]^L.b
W9KXVAf.Ic@^&e#aAA[^7:?eG:C#C].V?Ic^75#VE4[5Xd0AA_:H/@I#0(M/6aD5
MQ/>#[LBM3g@R7-:A;VU2AbO6B6cd;7KU@IWd7d-ML,;=W(#\;Xe4=:_L\e-<B89
2H1P9]66P;(W^g.Y7A>817Z-H[3Q<Eg36P5XFK\]1/NJ+^##aNF=O<W#P=bU\Db^
#;Z.K]?b0@Z7<7CS-RHML)Hf3^SPPfe#EGQ.7<FV=-]M8&;\7a6@f89cASSg(LR.
a/fM.f/T,Q:N^X6AK2:/g1X^HE2YWf?J09/?Kf1Z4cT>gZU[1>3_HVFI&=(d=0(:
PG:9RSG8D&OH9(X42L))N@eVF-FC093eB1B^GA613Q(XQP]LW3;9O/OUWSC;AD0e
e^,OY9^G7?4W2[]G)R]8?E.F:MS4I+41OS,WT>aZ[>JGcHL4GC=CGX6T^\I+G:eV
L7WH5E_7&BX4NcSQC6Y:&5TScIM\/_,PQ6M:\\\=5]U\P-)INGXd.Q[?<BBg?P\Q
\-<T;0]]NfHTZf4G5O\XA1K8-d/\YS]V][O)ET^WK5Fb9QPbW\-,ZaIW4G5LQ7Lb
O=D<+d0Q&L7HLF_]<cL#JIT:N1P^M_//9T5E/6D</Gg#QH788OW[TS;^W_]:XP+,
^<<Z(WTC>)6Kc+-@89b-Z6B_;4>A4T[fed8M<+L=7ZcVfT]aGV@A0^WAe7D8?///
.cdU>N>6Xe=;[&eX)-H=81=.ZELe(X.dX-?g<g[BK,#aNf9bX/(Z8EP^^1,JfebM
^-4<[3gWDOGK\@\J5H?(YX&P?VZIFPX2+?0K5]0O;[ETNT[)5dW&Y1;-AcRVRLfa
8g5cD5ZI:3X-^WM&UAQ]4Y7W,[_S?_H#R;#;-E[AG.)K13XEV_:]@Y6&E3Xc?\fB
<+2gQG<^?L#\9^E1\c7HK/MF0BWBEDOe&M@^+)GI<,R^e8-]TAE\2,-cZ+))4ZAT
F1P]F5a4.0La1HFD&F&0bc-I4>E_BPHFg=A,HEbMH8?4L.GLgO0HCH1CA#e5aZeS
:3aJGV:7ENJ/3HMdOL-P.=BT+F4M&CAUdE]0;JJTXJ_dbXP[bPKA26DKWdcNeWK9
#TXNG25#,FWbFA5Hf5>UDTDd--=3DQZW^()0JDg@G5f<MaKK7\d8+Kg,g/N+>L^F
V7R@U]\])04<:B7>.JV?SB#K^M/LTa7>TU&/M4Q#+J(&:D6(2(cFH9-#gLQ7C7TA
>d,+BXWS2N6)LZPd-[d)HJ]bg(,.&Ub;aHIMI@d8.&1Y+F>>b;I)KQU)D?:;ERca
B4NN;c1,;X7^NP9P\dgWXeSe1C^JG1]TU40(/Y@C&OSOJbM4b5<YX2?2IQb/AI(Y
_8DG\)6SX\^F+.,baV5>dQAZ<GdY<@/R+SR8a0,-N/GRR=W0F?0EgFb,UgeSMaY&
DbC,.50.DW&7&.g;e7A0M0a(LQYb@KMF?:JJU1RE<WO_6=4(-cT.TAX_O-.3e,\_
V01_5UD_]]NYT@eKOge7cI8,d2e/6\C),\UXaBQZI,HA8#HZ&&FaCIc](1Z;4a6^
MD=BUML8J)0H4D/@b>_<P8UGT.Abefb8B;(>-CYUWP/dS-b_4L0W,YZG1R>VeU@?
87:b&VN[JOHF7e=<?R8&bZ^J@Cb;eYENeE)55NUaLQ:9N&d\29E]<J@-R3c]8R)&
C_WFEHTgH)6.<Jc7\TGfJ(25.)N_]PAGF=X=/92<-D:W]>^8=,L)M.\DVFZOB#BA
,69d)9E<(>QRZ2GCN+H=J8]383I?N#GJdS?Y2Ab5Dg(R9#-e;0#RTN0^A-M.&G-g
#^G=QF?83.5@ZUY,@OC><&3.Q[I_AG.e_Y74S9S2O+RXHSLJ1L)TK?+5<IdSHO@Y
+C+D]CA8@>2b\M1)2/O^aW[a+5G>OTd>^P]dOaIeH]B<MJYXES83][_@YIGT\g2A
E9f>Nd[A+efGIbH/02P;b+FeS:-VM(0+9b0NMN)75a2RS:8XVeH5aPH6Q6Q:F=A7
]eX([)gGS/C[+[]a^Y?NDKXRPLXU:5Z,,OF^87BQ\f-XX&,-&\C8#FDV:C@=8W]L
WT1IMV>J^\g,_W\04ZYEefUR=]]QCK:R4^@,<-B<Y/<1LBCB&7@fOeY&JZS\\G?8
,:KI:Xe(\HQQ(b1eNT0DI?DIWZ\^8>\#/VV[OU0)Kbef]SP,c:TAEQg]H(VD,aHM
_2NDW92AS)FQC>3<E-IT)+Sb5K+d?]dLI&6c(L)9Dc]>1B9_-/)N2a(?Ub@MJHI#
6:=R[@.H83R3J\W2-JN[QHK],::M(N3^Q8TKR,eDbY.#A1&cc-G0L&+K7<>Z7?R0
]YBYE@3C-0C5;[)eR=Y8<DQ79g-KWX;bRZc,__&X1Pa+BSNLH\MKFb:U;6G;]N]W
?,L^O?GRd?>adB?^OKg#8d?fgHIIJ0A5R]d2T43-fc\V3>4.SKOU@I&adY?a(B@a
@J?gS#RYXf(1,YZL/9^N6UY(CL]2J-R^H(6R+F]2e9]3Bb;;FKTR5FW3;;2N,?gC
OPR;<W42g/^Q4L)De.HH@2R;_[3U0DS;W&FHQ<H]AH?3R(A]ZFN8-#W=FQ)^A_H+
;bLc)B[8EXKA)1K-Wf0AAY=31QUY<>\^.X8UOe:FEAW\//;_)#UD0[RDS3AF44KF
:_XM\\A@eN#^c@eUR,CS78N.\PJ8K0_5baLQJL^-(_-3U/e6Sc:,gT^(^^-G1=91
b1[[CK9&B6bUT4#@[MHA-03b_Gc9X6^g=_:CL/H5&#_CIQc43[JfZFOJTWAO8]Q.
1afCB7#GTf^cL^Q9e3SP_YODVGf;HK?:aC)P5G7J>V;XO7HDG,SA<aO&KdFf5d]-
9GdJ@/+@V7?2FddO5Yb;NL5-+,45J7f&JU))V@-ZXR72O[O1U0A[\ac]0:[SM:Y(
CfAR#4=8R-a9fIWc.MSJKB/.XF+&d=TP;;]f0c\641;=T=8Y):&=X+#AQQBM@Tb6
-Xc@F>ED_]9B(8+SH83_B1Mg]1eY.0QbQ^^KVU@;F@=5)B@gZTba];HI;NKc1&d;
-Z2J;<X+47cBe\&+GVeMFDa_G^^PUS\U(ABGXP2K6I6.VEgc7D:_g^1fc]IgfQGB
CL?e@;/DO/&eQ5QK6QXFLPP4I;0814dLaYe:P[KZ(MK\P_=c#HUPd+Qb..,+bA;7
L)9:<8+T5+2O;fQD,UZb+8(_Wa.T#gN36f)5=4A/g7)=+=eFf=^(TC.?XH3(BJWN
R]beE7Y=XU?UMKS=6XDKD;9g;;b<T9L@0962CcADPY3HFG-b[<SQQ^+4U#KH=7@>
Z/Z:d,eB(=#YacaP\<_LI0:W][AE5SG_&,QY>S.#J_39-7N<^\1SI;[.:KGGZ(5a
:Pb_fVKdgd<<;b9]W)gX3QR+1K,Wa&;^^2P5@>Q3Oa#&]FS?,BC,6?dN8\Q:d3G0
]2dfeA>A,:HOc0..)eS0OW4N3JAK4?#=495^B-3_9BPO0>\TVS&feUUeN+Bb)CKB
IZ:3WT5(8+P)0Ue0A&5BU_-NAEOTMIN@U\a_L,2O&LfY81]OQgF8@K<b0=d@)_f+
e-[[b6<e6.2Y4N?8UF?.J>\B8ZUU5,08e]9CMUA])B(FI^?UG]Y-C4>S,8NKINVc
f=fFJR.5K/]=9gG\()cO(A,1@e;9AV#5V#cB\_(@H+Nc)Ld\fISTO..U5R+-)-J?
-Tf+S\EU>([8aUVKOKOS=.9Y,P0KD6L7Y20M\_FP(FAK,Q7N2172A;7E?(G0KX;9
Q^K_[cP2?[?b6P5gDFf@S@\TJ>T,4#)D6<dIYdJb:MScA\eORXI52WR8>U)Q):cN
GXc/6RC&:#_,@RQ:MeQ@;_M)<1eeJE8^OZYRJ/SRTV_#98[cAULNb]g@[8[&W-+X
H5,LH@9XSfJeM<I,Y;Z_&N8P_L<(N^3X/;D1+90+#>gXKf@I:0EP=dQFVeecI10=
ecTG\@9P4@8F+H,_N1O.=U^8LaN&f6F0#;Z5VB(?/cD=QVUG71eIQGYOg,T,7F9R
2KDMXJ>;18.8J4C91YR4/G=9<d[5PTI+8&XJP\?@__54Y.CWN;#]cAgDA]cLCU@b
KbWQcVVS<&OW2;&E6Q9MJEODYY+3XC6VAf>b7,J?9+A2.dBHF]+cA9EXdSITN2^]
=;Vb&5P,A>TN3V35J38YHW[?]:)EDKd3R5cd.^RRdd?&=]NfNC-EGR;@?I<,I0H]
>Y(,&@E]O3&d=/W+>/[AZ0#MO691FG5WH4RS_7[RQ<LWHBfI]BN<9L4E<(gB]#7R
018?09T07?\1KB?2B+[Xd>GD6NA/a85@/=@&Q5a2K&,+CZHP060e405+J>f?fNXH
L6g?F-)O)6Kd7OES]T]?3BTTJ6ggI-DP.5?P^&Be9EQ>Eb(@?MJ_.B1JQc5B4;,M
K,=6A1[J7R5M,eFR.77-](^T=1eHA.<,gRVHTCMff)EJ?GGL6bQY>OQ-YT43FBV,
>H,(_>25OM7?9R<cY-fg^MJC\^EBBNAcST;HW<D2[@2+?^g7D0TF0DBMZUJ8>C]:
Qg9Le3.DJROBZHA0P>]RLD)KP0FHINYI6GQL[VYM&<]b3^W^D>F&W6ES@,A]H5YW
X7^.@J3IbDA[,\fEd,M0Z&SJFc9S_b@S4)MBA/dXbf@37KXK]a3CG(Ea@]:F7Q1F
8U2_GP0SfZ<F+9EBYF[I3Z5EUU#TTe_a[a&&;0)TEWJ9N)^6MTCdQO3_=]4E9C,8
K\GQ-8#:91A4>C9@1>G.L-eR7dMaGgR.5=A]=6Hg@5WHc\KAe&7I+?+FcCF=N_ID
M;J_T]9/=QdJR=ID3&RPRM77(NLGD3_9SHX:YMKC>fcecB[C=gfHA7S(a,(?M4gQ
KQX633f1MUJA_EZ<J=LA24/\PSK/G3M@\-:\,<5N]/N\E7:;f0HT[X<O(O;-BG6V
(46X.(3V@_+BDV8QWBfSg1JU.^7P.J.g.6c-b1K-#P2KIA-)DO8]ZM/P:4HI?C4D
UPT=.PK5JBgQb8M/e[e7:ATgQ1e8>&74b#-=cTT8G12>2U>J,]H4dTZ]6VER:+;d
MV=+QYUdg<WX3=^6OU3;&2cC,)aAK<H?,(^),BJA<?N)5-EL-1SC#&fdDCL7UB55
XO.>2GLW#;7+72gGd>T&@Ed_-UG<X>NG:34J(N=Q_RM08OX7=G1ZP8R/L?LZ#VAU
5A<T9[-W\=THN.aXf[_A3ENGd[:KV#1)#gD5#N2)U36fNg(L[-[?^B:_YMf3[&3.
&6_YcP[2BJ,@fF^M-OM#/_>P64(g<94b)b(1aJYT\cRIV8Z\K>^BCA0XST&0M9,D
;,G_KWZXSQXIGg,cXC4K+?AM,E[GT\=E8<VGZKL;A5f6.;GN8L/36XX,(bK/bXDa
2-Cf#QX(=HgBE;8ZIK&:]2JAY21S1)DIC8gd_75D118[CLR;gcR1^-egNXPaRHeD
)Q+XQ&4f[)TIR,B,E40GPbL?S?D1:fAEPKHA],^#N?,(E]AQ^HV[.,OY./<SU)DJ
T[D3&^49fX?50F\=-PO?gP((<6SA\A1e[M+eKcPc\W0E7:Ua)&WFaQDCR9N\H/Ga
CPfH7/ag+BIY+3,&/<(9?.F]QfZF]@(,:JYEYA-)bD](.+BM:1^2_E+-c[-0CIH9
CQAg,?7;@VUR)OC9e3HQ=CBNBUa#QcLLJDcOFU)-@NM^Y575R8GZI\__QdI;fBQA
gU#D<C\OT_H?HMNe(PFd&&V#d67^_B]XW3d<).>IZB,VTLP7I2Of#A4;X73>C,23
-@=AgQC>S@CN[2QZ8A,]>c<aU^@A@6TQQ5K+SBV2G=#L\>LEffR/:U.KB@F@;4^L
>;/VY3U).G--G80?#)P3:_9@X2FL8bB?Y;a0JJ9P65V+e[SAe_f0D57=J^5F5:,A
@:Fd>#^_g?88L?0>O]dT(eS(/F;X\=_eK6)gffTPTf;ZB\0ecF61S^JZYc@VMea>
U=bX,M<S<1BX681(NS/+?+Z=P,/C+Uf3^^W/cCV__1>R2Z6Scc0+0+)UWGV2K9P=
4=3;2ZB71>#349QXaf[&KbL2SVJ6H2=M3Q2cMVB/H[TgUbFK<<9SJcMRQI2OODQG
ICX7IKEA\_@LSWE#^bD@^X.M98]f<8QF4Y+J#3GX8-U=+0KXHND;C9Y6Db7[M-S@
#726>ZN2U&=cJ9g[,Te@@FV5LU:?CRa,)#Zb^T+(a2AD1e1^590PTMbbO-Ng?9F)
ELZQ7TZ:g(;Jg:B,3eF5G#TdH9H3g>4dS+0L8W14HD);]:e,2;A-gL3[gDeLdFD5
A2#S]Pd,)Jce,Z)<J.Z=GB1BD@N40I>M:[b8Ke\e-C<cA&UAJ@L6A:&3GB.\-CLG
2<g5MON^39IDPD8^c[Xe?=@(1N7E7]RTQa#JG=;cP/RKH<JbD3;IW-b.U\e;556W
M5LJYfBVARNT6]5BI->L=)V.1;V3dW./X;I#OIQGB>/.47;TaJ(][27W@Ac3ZIQR
H6#:I.BM4=ST=EAVN2-Ec?8FK-6\OJ].OOBSDJWIV5?e[b:COOO\@N<JVH)GUL.(
)-bGGR(bNLB2R7NfJD1^^N;^L-HY+2^0D3=QM@UDQSI9>NP[TV_BP(V\BcJ2cPQZ
Y&D\(bK3&/&8(\)gcbcC>E-dI;cN_AFE]FDSO6b5f2+P/a&.^C5V2_=L6;[H5e#W
N5#UO8X#ZIX=_C9W0_533R;f,@e2T+gK&f2-=Id.ce@T(;AJBEQ8063<LWBBf1+b
&W=[+.+QBY^HX_PO#K+a:N1U-XS\0==8baZPOI\.08O_-SJXS_-;dWKSCdJIZP,;
V(V>E>BAF=aM-[-O&N1H\.^5?gBVaOCRZJ>5VTc0=;O6503Z&g[FTS[S-e[>e;RK
f#BN>[NVFfT#]aXSA1Q[@b>+DDB?0=9E2eAYK6f\VDQ]\(LT^;(7RT^Z,Q454]TU
=EYJ?;5BebRC/G@)f34;&Ea=8VZLgEV)VD/O)U9E5W@6PT0.1@AD)O0<?:]6cDKE
PdD5WV),b[KY6T8PYD1T<PC9gA,-A@&RUPB?(0TW,9)=fg-:LDgHLGH^&4XNfUDb
NdEY<;TO>T>ZO3PTXNLZNG:+<IM:cNf-2_Q^4:9K5UYdW-2W(5b&Z66g05>/2#;R
+4P80(ad76]L#9#Q[Y=8F\01Pac/))JRHgNHO5TL2P7=8Z322faF[#VXIJW?]YcQ
bW4E=\IeWL5J[BIC^aY:#&=M3U41JaE@E=AP6UK-<D^B.XVKZ#;EHL8+CV2Q7GQT
_+.@_S06^GR=e.D/b@?B[gFAW=S4OJ137>EXF:\:10HDF)X5K:;JXLR&gHTNV24+
cZO#FP&X(17M.:b#dUNA/3Q1Za3<dZ,WRQM4KDD+^SG+5LSO8_<RPD#b[(:eVDaN
249A-4GDM;BW1NC97UXZd.;UB+L=1fC),IFNX(IAPcI.O[O<\:VB<>4?agFd3;0&
;>FLXP:LL_+WC^491=JEb7V+KN<[,FfJ&Oe^Y^FDedVd1L4M;<OFYdT36ZD9H,D&
c4f7T7B,J\IPUXV[A2SM2R4TBC?b-#7TU,0U<V0TXHSW_P[S3JUd/-F>8BcW\<6M
eJ#RO>&H^Q65+T>1UP?I?Zg.XM>SL\f<]eBf^/\1W/PPbI-#EQ#GVKT?+(R41.IL
(7)99+^U::B\1_;7C44SX(UXN-\[3\Y0CXB(VRV-1[6R68SC24AdV:Y)BV&?;/BX
3?_@Q>IJVS@R4IeE8-.L1AW[6c&AK0,/=S(<3K&1WI?d)5]d=a>Y0FF)OD-NH(RA
WWSIY/HQ=_Y3=&@Q^T&2FS,afDg,@HI&PUXW(0QC973<d>bIfB-M<\d0J\F0ORW+
6EfVDIC00<5?33E>dMa.[<S16+-f+(+8Sb9gWc?ReY>#WM^^X]IM)Xe9V>B74/WK
8(.5Od-8cY1FIAaZJ4C^,=>aHGZ_I-)8)LU3.gPQRE@dY)aVFLfaD-YdfLP33HdA
-YZWMaYX,48&ZO#+@#LfA[+V^RaG5M#FIU?./[G^NYG=IB4_6L)<UZNYW(aLT-)e
<(9.HY8GY,gc12K0H)#?C#R7(>5,b7VQIaOg>&0\Q@K<4LeJA2#[a\U,0@>g/:d5
/HY18V[PLJJGAcAGWb8^[9]\H^DMO]B3f0]ceNe-2.8deODNB56d]_fFcU/S0H>U
aO5g+JDH;T,G4WbFCbAER(gc<A=BTR((DXDdRaINSCP#/VDH,[)PN<Q0?6CL39<V
+>D-<g6@:YD2?ZQZe9G:3bPTP/>f#cb0eJT(9K,\g^VDe5f?K9IGDUZ5V+V,[O7e
46R@R._agG7bRY1UKfeN2H@L_09#)<OLW96^D9AH42)XQ4:G\EEg0XZU8X+M\^Hb
[./3?/:ZU#f)a=T_Bd40A8OHGAZ-;,;WMUaP8JC7ONGeGa\\\4<AJEQ28W/C1H6=
8RBWWIfHfE3;c5001RYgE&/c<,cH73R,NUMWP4<GR+KV783DgM8C^YB+X?5d]RJf
g/#BLXQJ>E6:@bPT:Ff^Me3)ZQ=^XIZ8.1ZES6X_20e<DV:=(P]eBTS6IP/.?7,a
0ZE:H34Q+:g4T>\D)9Y5W6VLE5)FNU9G7A[0N;@Hf7LI84,];b+RLUQ]OV.,.91P
EfXY12G=geW.9FTCP4V_LBJ@f@G04/8IB.U_R?GM:PCa25-@./d_[)8@#^3946<J
-&L=.?cV.,G(E<4S@-_7Y7fP/\E+VUK(E_2+#_4&gB.6^G_=1&@:O:?T8)M7U>e(
EEP=9[R<eFF_Q,K_KK8??F\ScC?L46I#dEbC-cgCH>\3cVYP<,9a>P-C(SID-,(>
I2<TX,XUL=A#G<Pa@F+/<YCMXPcVa4aE(b<ZGSQa\#S?YPYdgZLYT@_eW8/FD]\(
7EX7+]78V@AZ:V5JOF><5&ac^5QN3?:VGY7S8eI#&46WJYZTA0gfS0:5WS:Q7R5>
7DFO;)BR_:W?ST_OC#UB?]#(L;R[5E.aLMgJYJGUGLZW9E-FU.\EE_(&Z^9O0;.<
1bcB7IgUB5.aQJ4+b86)K.dG;Y,PDQb5^4RY,_P(<C/H5;b>A1:bbOS[)=)gNMdT
8:[65Wc)_dU)(Q&^K3]WgWdUaTO8DX5+<<SHAOM2.-:VYL9#0(<IBFO4IaGL_L\7
a._ceB/PTBT9Z=EQFE)Y7=N(CJ>D/SMaD5^@#2DT\d@Z3HW8,/D^UWJF__G8V5#?
U=cZ/=)c5TVD^VW^ICPQB:3LL6cE6380.H7D]09W>U0=)9,Z@T6)D?:aS>6<I)GC
)ZZXVGCG.O9,L;-6K/5F9F0aP4U^;cNLbH@7_S:VfU>g-P,X(E-W<AgS)bH?\e+D
B;QP:PD&A)K8.fgfV]BV<6d&5b)aTc:6I7-G^b\c3[36X&<fQe3R#SQ]MJE=&Le]
#,6YRb]0@bKe=f9+O;A^c0D50Mc<MBGU\(A5TfJICfNHgZO1UTggKg\(99NaZ>?^
Qa5/9].[f?(SAUTU/R31#gWOPHVf]R1d3APYKY&fP/V#1a(TJ^3#-bGZ7BJZP5Z#
L:[5_4&G261=Z>fcb5E?./ZT97RZ=T,3FBLDcFP6Z<aZ?=_K-TO^:e;V0>a6?P^c
gQf(RQXJW=:bg46\Uf>.32WM7OA1gaX:/XBfZB@,G93GY6HL1_W7c5bMHTX4&DQ&
\_dNKYbO5@CMFUQ+F:VJ@QE@@K_0,((;&?9X2LIGF&a([ZbY;HJ3feD;+A4P3G:N
#N\(>5YW)@P6F:FB3J_8NDO8[2^@,03RUV++Gg7@QQW6/N4BIfYS(K:LLFNQO&:)
R/1?\2L@a3#^NbLVH4]<#RA4IH9Z5.57R8I4#_34US]SR,7&28\ZPDdU&SNE=@#E
-VHNYeNF(SUN42-TRO5I<[CZbIITX^d2faAc+/20V_L^):1R,+X/.X7.K\,.FR]\
HMF8@1M(;0=B^0LO.>BDSc]=+C75M+#TX5EU1EHQGgJG1:=M.H&I?M\bJZH3Dg:N
IRGaCH_IcV=T=Ue.;:DdMKZ:bENJNL22&EbZM0@P8NLfA4_ea;^1\_-^:6T3KW(^
@1RCJ8b@93Ba<>Q;G_dLX(E7C3BQ)8,JJ/,Z6J9.>E^_E@_/JTD6FHCZG./cW:#5
A;WV-\:d,+ZQL0dKF6H4S+JT:6bB[O4FOEQP/)8GH^Dd>?BLCVFUe8Uc7X;_9A@H
+U]MO>0aYR,P7U[+6B,1bZ:_8dCE?JD8.YFW_Y3Tf]G2Q?=eIZ@gH\Ce#VTTY;IK
?(GdaZKX[5)BI^9)e(==ZCgTB8X/\>cQ.Y_B0OA^SC86U?C_UAIAQP^^1L2FTN3;
32):D-4/-)R#gd21S9IM^E6;/^QN)0e5J6JYV]/da:]C0>_446:Xd5BS10^6dFE2
d(/?(Ma;RRTYE_\F4gc8Nb[6M?2-CC[9gKfX[FC?=UcHePGIDU<&Qf(1GBD&<(,c
?[Md4C]<++G[S.6)3]C3b04dI0&ge+4@[1N2]NWZCQ^E#(PHR_O^[SM>d6O[aa,HS$
`endprotected

   
`endif //  `ifndef GUARD_SVT_MEM_CONFIGURATION_SV
   
