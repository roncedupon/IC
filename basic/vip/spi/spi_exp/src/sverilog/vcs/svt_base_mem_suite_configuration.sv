//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV
`define GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the base configuration 
 * information required by memory VIPs. This class includes the common 
 * attributes required by top level configuration class of all memory VIPs 
 * (both DRAM & FLASH). </br>
 * 
 * For DRAM based memory VIPs class #svt_mem_suite_configuration is available 
 * which is extended from this class and can be used as base class by VIP suite
 * configuration class. </br>
 * 
 * For FLASH based memory VIPs this class can be used as base class by VIP suite 
 * configuration class. </br>
 * 
 * The current version of this class includes : </br>
 * - configurations required to add catalog support
 * - configurations required for xml generation 
 * .
 */
class svt_base_mem_suite_configuration extends svt_mem_configuration;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * This property reflects the memory class which is a property of the catalog
   * infrastructure.
   */
  string catalog_class = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory package which is a property of the catalog
   * infrastructure.
   */
  string catalog_package = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory vendor which is a property of the catalog
   * infrastructure.
   */
  string catalog_vendor = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory part number which is a property of the catalog
   * infrastructure.
   */
  string catalog_part_number = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * Indicates whether XML generation is included for memory transactions. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * transactions on the bus. Set the value to 1 to enable the transaction XML generation.
   * Set the value to 0 to disable the transaction XML generation.
   * 
   * @verification_attr
   */
  bit enable_xact_xml_gen = 0;

  /**
   * Indicates whether XML generation is included for state transitions. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * component FSM activity. Set the value to 1 to enable the FSM XML generation.
   * Set the value to 0 to disable the FSM XML generation.
   * 
   * @verification_attr
   */
  bit enable_fsm_xml_gen = 0;

  /**
   * Indicates whether the configuration information is included in the generated XML.
   * The resulting file can be loaded in Protocol Analyzer to view the configuration
   * contents along with any other recorded information. Set the value to 1 to enable
   * the configuration XML generation. Set the value to 0 to disable the configuration
   * XML generation.
   * 
   * @verification_attr
   */
  bit enable_cfg_xml_gen = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_base_mem_suite_configuration)
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
  extern function new(string name = "svt_base_mem_suite_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_base_mem_suite_configuration)
  `svt_data_member_end(svt_base_mem_suite_configuration)
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
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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

  /** Constructs the sub-configuration classes. */
  extern virtual function void create_sub_configurations();

  // ---------------------------------------------------------------------------
endclass:svt_base_mem_suite_configuration


//svt_vcs_lic_vip_protect
`protected
S:M^Y7gG?99K>4VA2WbO_)5/2::2C>gDYY2K0[7^BM[W;:;c\Y_T,()??bW9JHXE
0##6O23Fg,5KOOR<NY:GR6d+C]V0GU]&MPV:Rd99+F(,0XBbOMf1HE]a]#RV(_IN
/P+C:1MbE,M<-MLcYf<8D=)2O2^T4RLI6JM[6.;52+&Z>S&CHW^][g,SSSGcf^\]
e?]&MC=\U9Y]B+b[8#7.<&0QGegLC;cLT=865D9_agDZ9c8<O^CG#L;JRPO]TWcc
-ZM1Wa9#A/2b80(C,/GT8-(H&;.?2MM?QgZ<gCA:HWF2:WO(9b8LaI84_:d[c.6+
X:@BIZRK@WSTJZ,#?,QFOZE\;5@GdG:DOW\>.8;<].;UOD),>;D;a(@dU+[G_FXT
?WU\^+PTgR?;ZeB:_\4B#/DO31&-:CJFWPD&7EHW)XXTJ;?0+0J0L1-=B/F>a.0B
A+c]d1SYASB=T/c34)^TQI8#d[HL(B<XZ;-HSHc<N]GB3BDR_1GJL)U]_N)IO^L3
FM87/Z7J4eA#7O,g9,>cH-Kb4dN?Y/0fIDP\\a2gZ_CGFQ_ZV]2CV:HJO2B)L/Ag
RANba(6:C3aU_0F42U&X8XVCSW&X.99a@A=G9[CYDa.+-@3_8=:aMPS_12^R@]>U
J&4cb[6YDYVcNBF11I#VHUFLT3#d6-&DCM:e8+LBR6C\0U13cPKR/11egMVKZ]=7
IOO>0ML+IMaR0A)04NM^O0;[a[]U=Y@c[VM2^)Q]V@DE8283E^NND[PS.+3GW_dP
M)0Lg/OeD?S(K_^#5F29f]<N6J^L81+3_QJDCR)L>C_IXJFdY9+]VeR;8>Y==ZB(
^L(XLMP78/U.V62;,1IdgX>S\SgQ)/>Ha00SI8cdA+NQbOQ59Kc&fF^GL0f9JXGd
fOL55L5SMJfK9]25NZ,a5T:V@fed6XFY5_9@M45^/;6;IW,YDDT.J;/W6O<J1E[Z
<:ZITcbDOZf;2PZP\E87W/ADM;f4^;)#?N[X8I4=Y/C@CE-9YI16X(JfX.Q>>5EK
07Z;:ET[+K9P>He0)JOIPW,F<E1]A9U\eCQX.WCRX,-aYYX]E0+<3bX?#=2N\Cf)
RLJ3fg]AQ4^P)J5]#3);.Xb5G<Y/I=AcNN)1F@G1,.3+S[SF[+O04U@1DPJW-^->
TA+,[(M>=VSL&CBJ6SGGHUY\N+a,7Ag<DU7^dY0>TDS2J_IP8?9=3K1O\T(T.MXa
]]SLL6ac1PZ-N?JR>[dE620Q2S3A<9,](,BTf;#aT702e8#I&/QP9aA8If,7(16.
[&BBQ=aI7&3R76R<&\S#8DB&OS40CK)O(P2O-,f(<L+TIabEAf[1K<VgT&H,\OCY
JH?g^<.CXTcU,)_03c3[S]&B-6g@.V1SPM;?RR7JY_#13AF)?@d;7[EP;AH8e(:A
-c>d=:fNZab)aScSOg/AFENV_RZ9&5>KLG1RgR[\Ra+K2=9)3FCG),4GN:dBQ8&0
SVPgb>YUJFIe8[6WJ)&3S@BGE=U6d>PfY4Ae;Q,<->Kf/[/C3B&e#fa@.GW6eUeE
RS5+R-8=g2Te-0a]2SNd-3-E-Qb\/B2]0>8;\(\g0<HA^/;cb#3J_AO&2M==&YG4
^(9g<WPV>UUQ+];2@eP#QbB&Y<G<(?dI9Bg#+/SPNaANC=@Ee8bZZ47Z,Q[DERZf
e4(0OSJ<-0fJ<_8dN1-.ba&(]9=A3<O8)b;SH9/.V,d>?;efRKP7^J.X+KDbR,B9
=6/,C<IcFLA/@)?VeU2e+TfE.Je.D@aM.dRIe/^bg&.#(Q_FN5PDMf7J(WI.eTZG
]SOSB0^XcUdGJB04RE>1f#g80\L5W[)9,?6e5;P1^HDORGdNBAR,E;c=G2Xd0V2I
]B,;^We8<>JRQ5NUJabHg6gK[R696<50LZGOB9OaRYXAFE:>976\6MK6+JeDdAI4
1I#:<F/eW\R(J15I8WLTU3Pf^:ffVB&(N#2fY&J1E(L9AHOc^GD)F>VI>,I0E8U8
73A6VdHHVeZX?(?bf8/d&fcKG;X<cM/8&gE/a)6,TV9C@0N^;X7>@=^PcG\Qb6UW
?7cLbEAV<]b&JV1,Za+Sdb7Jf_9UBc04.Y[QO4+T\-VAHe&K=#fDLB20X85K(2d/
gJ)^0/BHZ/<a_7RA)/J=4.Z^N<P[=Jb+-d&RGB64>--]#YV/>O?d=VfU\Y3X.:@b
1V3:;b#[E>dA2d@=ZDBH5;ERKS^#41E+VI,1OgOb?)_?T[749T/EGNYeD[dYLJ1T
EP7CQM-Wb3S^_A2L<P\aM)]W^K.Wf5_O@;2O&<@O1L^D]5c+\SgLI[\e,#35SH>:
.@V8[#6AHeS?NJKYMG^ZNf&dYTgXUbb4aC\>7/1bfJU3<N>a+TaU9_&7-J7,O1dI
>cJV]JgaE3W^&.+//_LITI2?N^]BGd&/U/2T>2d5?DXE@2)UPe48V?/>[SPTR<K2
[c?T;E0?V-VVQT1DPV8I4P=S8+G7\gCOO=P[#cD,;]2RAW(Q>M1NVcJOA)@-Ygd0
@.&+[3Q/]+E8Hc.[#-&5URe4ac7Q1aH7e6]b2,<R/350Yd1c0>dK:<d-V=WfVUcH
@#\/:?A)3@FL(<.PD1LDIF2cT890RAJ3/eb8dW=U>gUOA16S/Y=C)O_S?GXC/D+?
QWDFV32LP[O4.S\E(9,N^.dW[,8_d]BS0?JF.ZXH^,2e?Tb9.4?3aX?b.O/BJ]#g
:MS8Y?/=ZH7bH;##-GcV5JKc^9gN/dPVA.QL^[??/=2]gJMDE.VM2H&8/DIbdQ2-
OXE2JCTR2GGcbY7\VT7GL]SN[R=V>I=XV;)_N3c>B-YXI,&06CMJ:FGML.@U@c;6
AZY9=CceNYfT.NYC7WNF5L5c?+gX1f/&_5CXg#b?)25;]<fE?f4=d@PO0G:U<YCP
Y^8^2cLKf;V+:TK5RC2I=,A[#J95:?9.1^b9]:X=HXC6Y9_cS9e=A7[80J[S1BX-
4(gg030(>/2Q<1-RK]JD?gJC.+H,V4g4CF[?^5A_C^)6>B>9&KAK&g/Ld+_-_bA.
@9+TTfL.M.bCSWYFVg+\94fQ6gVggc<Y/c#YN5RQBZ)<97dNWY@XH@/,c9./Cg;P
Zf=<:fM/a0SK+#\_3Fd^\@&E_YK]O;EF0+(RfL8\V9Y6E;bW5e9Kc5IW28.11;(W
4Y&>#>G,1dYT1^e0&>GJaXY,;(M>+aE8G>Eg7-ZM/Y8D8M6E#-VHXLD\NAR&AC_f
9I,8^@FB^>8b<>9;97U9(dMRHRF:WG.PM3\IPIDLN3Kb#:(=fFQcOPQDYR+W@QM&
RLEAfK_fB\8;^:IM:cOL)FfYK0JX?FBLM]WG)c/_bJ8@8Y?-M3M,[BbeW&L(U/(J
dW_7d@51D1@HDB/#&GSFGZ8=I9G.01^SKf\GRdJV_<0?2e?-Z)B541&OG[S2?L=P
KGVRCFQ\L5^Z#_b].R;<)cM(NJ2W&;1V>[)YZ7N4P&_=ZKgYW_bML4^7:S@XJW6J
?1>8B]e)B#>Q=(4;JK-)1,MBR_b)A#SF9UA3_XNGD0L7/@_7DeA,Z?b/8)+NWI3H
BGBJ=b)6BLIH4HOdM[[WK#^1[QF.FN1[M.#7b?4LHWVEP:U;[[T0.._c?&X7)4&T
&.E601Z@Ee7++?@1\4-ED8WS7,YD.?W?6^;X(?E)=N;YX/TGOQ4ZaQ6I;F0=)g#W
?OJ3QEfbLWFfDe<-</_:EeJ+=f821cAGN0a&01#7Fa,UI8Sc?NDV/dQcHgJ=@M(O
XSTN+]IL4JV1I2;HbJ@5XZ-41/]M]a=;[PX@BP2cY>1.MA3dT_#Og1A2cfU-W^.F
57CDeP1U?7NR_H\U.F]WR3^eVN+5(>O,9F_.KID<7A.5]H7&-7\_<XA8U&\52[d<
3c]J4?f261H[:_FOa37/7OI(?O?5(dSBd]+If-fMCAY4J5AIA)]3GTVCM:=S3E.)
)Pa(7DFH.GYZ/&Z42c5R.?/L]&\W4]J-QDV9S=LJ-0DXMdaG9;655_HI4+KIDMeK
+^E^P=/>/SU8+/(W=TF)<;0f-4[3HAJ[4&8DRD^@aBNP?QOS)N)],E@K2YZ@+2fb
))02BVUZV3a?5SECSGZ_A.6\c2FMWcFSFKd0<7O[aSf3)#WN:XD40B2+8;KeP42P
RD?c#\Yc@b\]9/_f5dW3)W#TK[^1)F,<1cb49@4\6ZH8U#+J,;FaU6K@LW0V^89B
PXK/,d&.e;0c<MDe79<BOP<+Ja:8QaYH9BC.5XK=B53(Od2\Pd)S>?VBH(BA1(1L
C,<-O-)>&gK@aP@:^1[OEJA)SR1V#6@I=AM)VB6ML797ZTgMg(@)/62?N5aO:8-0
CbY2H]PRP<;,S)-4,_8VdCe2\.&5d@],IOe6\SF?&dT-<adI+f<S:D]-cN[&9f?[
=]-_>Z]>8O1H::-D7\[2cPe9E-8X5/5S67YDg/Q1,[--1KAEGWd83>aD<N:>DAKH
DR#(P&BK:S3dOU@X)Qgg2=ZFQc+7NGbQ492=8=O+/I,:be9L7(I(8NL8(1U:9JFM
8O8K0=X&:@T_I+VP:gb]Q?+)Q-aL#PNf]^P3]0Wa;8Kg]&1&eT&Ke2dC1;HRJ)VX
2TS<bQ-R4a.B]bQYJf0,2YPVJ\EY9a[:b)0;)CKB3Z[(/d.-/#A@\<\O3A5_P-_H
8a30\BB0Q&e@[4&/F#d[1GCN-33C0-17Q\3(D/O&=&1ZfC2JbHcUZ4DP7YIa_Ma0
3VXS7X9EH&c/AFG2>8c_\W=U_V5QHeHVPD^DKAK2TdB_9VK/3aZV&3V7,;cO98BZ
_EZ0_NF(_RFGS4=96>gBEL.)N]-a>7g?\(0BV#Z4T,[c+XT9Z4Q><H9:KPDMP3,3
K^+f8.C+M-7TT@,)HL3U9IDYNHIT)]VTYI&ecBSR?Z)d?bM2T9S>O:=C6,KO@#//
EM>[[3TG,bKf<?2WHUS8KY]4>-4TfJ@9-9f^LC@1H4K44@b[&F=^SIM&0G(.9aX3
=>^B-BYV>5S-8g02CK#N\_[3ZVJ#>E_3^W5g3cBSa0\(.BG.4V>>M^<7OBQ4]76(
TPB\e+5-::PCg>Qfc017:MN(5c9?GVP5;XeY:<_CDbC31gFE^4\LLdUHX..WX>,Y
^U#QaJ?A>gEM]g,;-TfA]<_VT,45HJ)aEcDgCOeUC)<6C.8TcXTTg:bLWXT^a8G)
W]_/QO:Td8J-R\2<)C64/SE08S=_UXLH3#P2/,g)WDOZbdY+b8N:Q+I<MOP&X_FF
6R8W#S,T1&>ZKWYbU+Mgg=-/3BPQ>1J0@b+)ZBH(Z&(&FAU@O62PN,FcVf>>5;#V
&9J^#[1bF=T>aVD(?9R_ESTXI/3B>?BQXe)FDZ=,#(W^c3UK2,?0/J9Q,8U3D6M#
g/4;2I63]O;f)-R^J/2C<fO-FBc7,B<Y;X5YVSMIH(C;S==@,db]:7UV<\HBPDI9
8^A-1=2^3eGBUB4-e(0SY]^:@+7f],bUf<\:=4H,&M((#\NW-5@:\[GCQH8Kg>86
,S41@f4afUV7Wdfd(9K.,(V5?/7&QO>ND31d2EGeZP;N]V(IX>BHL<+BM.g5/)DK
;?L=5XKM06bc^d=#3e3NSNVPf-66MfKSW68/SM@)MVX+541<KM66eW.)1P_]aSc1
-Z1fcYWGPO8##>If<\FPfe6@[/XLPY[8d1NKCZCV5)(P^H@+4.6Xf/acB[GH))Tg
);OWEH;.aBBO_M15^Nd^9>0X6/37O2W-P#e9/_bU&#LK9=gT_5WJD>@b4D:M9dX:
=?8bL\@MV@M\e1g^J8MT1Xg#&#+1\__4+<0E.-575-ATJH4H6I4@CU/4RWb0T@?[
=+F#HD66PcDa)bLf07NcfP9]/&=J:+#@?0[(c4.EZMGK0GSR?6.LUGfP\RRF8F9X
-FLb-Bd)J4a8OBMP>&LN]9^fFX?P[:Cgb2?FO;cdCE4=JYFe/R9bJ=W=W[,_(]WC
/]eU4FE4ePaD0H7-d/Peg@Z:GTQGa[>Y\Hd4OeG]Z077VN.;NN2M3_gbL:RGK3O(
BP;OYHT<,EY.gV<>OeK5]7[U=/)Y_>WBeKa1JS+)-3>KGf\?Kda;&cO6c7QcP;ZZ
5-28\9V=7EQV=>&N)[X+;VcE#J]ReJT[_4)9QH=M4T17^D2)R<>IYATaX7TL07B+
bZH1L1Q\?4J>U2QC>[HU+9Ade4&:,1P/_W.4/3S>e)@32ULeL>KNf>;L=,GJ@T<X
D2A:3fO_Q&1=TXQ-.2VeP)8.V@(O.88QN&.?6C8L[I_SZ9LB>)DD_]7F>bC[&#<9
R:N4X#g5N#<CaT7R>2,WcY>EP55RA-^CdZ]RQf;^>;\--aR_7_dI,)XBUP_BX_:F
_C4++AFUQfQI:G;9:_:C(K,GK(+7RQ5DX=)^(.7WMN]9YFPg35gNJaU8gBEGL+1G
Q;G5D<5NY#PD;eZ)L<9CDH3BBKe.OR]6J:X?Y4^(]#aI#6EK/>3RGI=:T+;>/O,.
GC6gJ7W;6@-(g[d5J@QL-5Ee#fXCc<L<TG3WWI:?,9.S9,0_J=LC30XX.&1E/O?3
K:O+82>U=KZ3\@SC]HAVbKKMY2S63-4Xa&-JWC^J#QMe)9&GB2a(]5B/#baP51.Q
2J/]ELOdfVRF</?DAPY^3A.aO+@]BF[:C+Re0XOe__-)O:C)E?N\+2Z4GF9<Ca5O
7Y#>7cQ<@)+MQ::7BSCI0U^\9/.WfRS6U]LY.eXO@E-ZQQ#N]BX\63>WYY58[,95
V6?Z1.+\)f]G4FEZVNFOe_fF7)3cVa.5-/Be<bNU:,T/(?TC][?3<&CQX?)?.=a^
O?KcCH0IWX4,\]IfO\=4fL__eW0Y8XdA\e0-b9#F9fVM1-T47\#]SRQU&PZ>C8>Q
TW>T29JHDZDJLMI+)C70LS<4M&EN&VP\3&/DcKQf.f@XM7Qdb]??[STbAF<0eIWD
cFMBc#?CC@(LTg..cO_Y1Fe(/-IE6(M04b4OY9bWNP=4#HCU.\38[6=UJ=USMd2A
@=cMbKD=3_<Y+6TRM&6J=.-3^N_f_5GNM._6424cD/C0BLB@f.GH7Sf612Z&2aRc
8f<[][=D?2K>[CF#]Ka&P+]5UA^&[1]T4=@NB>WN2,dKIcFa&N;IH@5[a)^TZdLQ
CYI\Uf7K[7HVE0+]W(FR^OA>SDQ)5DdUO1a+7>a9bX<09N\H)d8[4+2NaQ2)IP#K
2D)#?;fga>VAKd+1YT&[GX??g/)?#Q0=dC38HON5V)W=5bD7fb,;-)SWb86gfB,L
5;J>X2P_Lf.X&06ScC+dH+;(#>V03BLSQ<#:OD8;LP7^(PAbAIa44;0b)/2P+WI.
bg,,;(JA5aUKE,ILGLE\ZLfegJHIX;2D5Q=C6Kb2\R86e7E/WDb1)c4baGW@NQa[
\]@-5Q@3AgOI8N#3#JMKaN+CTXBVc3T,JAYR9HeUa50D0eG0[>K4#RT@1e]Re<[7
W&Z8WKSO0/I\>88d-Lg]X&@KM>#)J_C,9-@KFDc8(V?N,J?Y=NDc<RVbK?Cdg6(R
+PM?<B=2g(I.[O\>&&J+D4@<ZP=)aK@QO-eSXb1A,@cSL:aV4U-VG@c3JUT#9+Z6
49^GYe1[cUGaU6]VC\EC&\V)^=]U^2ZED/:RcWQZOLbD7aBLXQ8QP+9X?/3&>b.F
Y4<QM3f\./W-WMg+)/?CC^aM=MIBG/S_BW=A[R/>MOM-_XIXYLH>c//_E/R](gNX
bM\_g[K2HX:,>3;e8;b9K1.@6P?HO/SR0,/3G,N>JfSAOJ/><#YLebPK9<-8b_XI
f5Q=1X/?f_4KS[^-5D\.F7I=7NH0GXP#d:DG,9bfTgGC6<YF/X^V:5D.FgB.R^CG
V5QbBS6=:aW_V(^:9_1EgaG-e\(P;@0JRM8?_H\+NB)VFR1GT^<5G<aPWS9D7>Q>
E15gX7Zd2S)FY^NT6LUBVTJ]-eL2\/&_=JE=W)ZKW@(Q([BDCK:FY&;f59B?D)ET
VIM0XCQ31OM96M]JONHVQIXTM-ERRBQ5>XDOCDLX=fRD_]YUA+e45)\G92FDaSHd
+D3J&<76b<[AE@(?>b<Yg\G/a1-TG=6/0?NWN:0JVI[_>FdE2f[W[Y2<HJG1T2#L
N1&Z#LUW^O1O/CX[728@QCHVL9KA_&U]\N7YKJ.)BX@5(92S:7S@ZcSLQ-d0B8B)
WHN1GgLQf+e/K:]]aVTTdJIdW&#gcV^RFQ/TTSJa5:]W([@]W.d)c.2;[UA0;?=Y
^@:S&7E738,(3IgZTO+HNR>4L\^Z4W4?DBIQOQX4AbgV>Jg0Z4P@bDOFMPMeB2-]
1YLBXZI=<^]Z+42+&aLUH5;?U:K7H3g#+)gTAIfEQ):-JA/=ZeC6/S.\.VJQ1\YK
B&3X39TOdf<TL^XKfOOHEaVFN)QCFcdR0LccJLDU.3dS.E<D-d9R:EH]fF.U&05_
?..G@>],=W,g_da-I8?V?&ISV+BD@];ORNdZ^(M0D8G[e8[YdXW9/B3SR_8gdLfO
#O;(K3=(HF@.A5P]9QdEW-CTYAdXT#,&_N+P-cRH2]bSA\V>B&LRUM;6:S\O.P0L
SePc5-9TXC6XDW<XCM[.>bHJ-ACH@NMP8XTO3a?9PUO(X13bJ&Kga2cT4?]>#--<
[cg/bCUT-4I46Y,1&070fMBNEBAc)-XFGP>,/0:4G/:M0S_9:A9Z0K[._YIef=<=
Y6P_&eE81fORV?^JR\8LH_R5=Z&4L4;:]L2P;H>dK0XV4,(^:=B^B6D9_KI@W_3P
(>_A+5V4&G[>:KX0HR^I)>M;TFba)?RUWC#+WF;/cBgH&O#CfNR<Y4ZXHM,4&=O0
7T+R?;UW]RZW]fSXUFaXA\]e\YHIJFH\#b,5YMN2-X1g\B&Ed[?d(+8Y<L=PF[N+
+S6c,U&caYCAQ/9?OSSO_EQJ2VZ.]3NBR)2f,4=QM]fdPI+A=9A6,c&682g-3Nd9
MYK1Ob(d5=U@BaV2F<cS,C0f/,4IK3Q&N^[>H\^gW#:B]^E3gZF-_C81b5/05&_T
:=6Cg+T;OU7]S97K_e-T62L8?MbBAZ1Z&a9SPaT]WTLC-@E@MN(>,e&WZ;SAFL(P
=NRY16V&8SW0##/Y@CA\QR25/[\g>G_DOO,:VN4IF,1g^NNcd3.>]H1]@\[)ZECR
D&8JT5(HePgMHIb&;?X760g4G[e@PB@NG;)W#/E3-MQ/(7E>QQY9<MD(dc9C-#dV
=2=0[3;WQPOMLf-@PF](AP>Y?.]F=TF0g#)Q?G</+<cT]WCbNd0V0eMA?6>AW>;#
.aaK#\)039-=@],(-ZA,.U:_SFU,a_V8Qe24QPY>8f@^.3/7@a>@^>S-KE8[[0JF
TPc++Va@IWEJfB@MR<U9.H6P)UL;.+eX\W@>fe)@g3c@#K:+F&]eX1d]7O>6g606
^7<(:B69>X3fDYe)ZSTf<NC_&NZUF3D:,O25AbN8.^g??2=?0ZM_SA?O4Yae?J3_
SI=PR1LM.,?b/IL2b1#fW/?9V2(.Ube@=(.BIb^0dH0e,b^9VTFO__5>OAJY#Mf;
G\bb(K\d<(?XC];SLZ]-3P=Y^M/+1Na>8XTf?P4G(@5_S)>Y09-A7.gYbUTgeHe=
aPQVaOcN&Z)bYbV7,^7^6#RU\K4KE#fODc=4^U(#F@]6#84=<JDL\@b0]I=8R0\V
#-FM@5V02PL7Ad\2&V7b8POZ(S.]>:MgGbT^@-AQ,QBHB?a_W7bKBW@F3Z3IHZY=
(_;+d77dFU^N)Jd=Ha[.]5X4YIY>fN;c:-=L&bG0>D[(XMT2GNI/BQA.>MgVG=>g
5PR:QbXM<UbCXSNYX3Ve@IN(#0ZBG:+&9N^F/Ne(UV&PM8.9I5MOY^S7[QXcKO[Z
5<64[fVeL\Hbdc6YXc;DS<dcP>]/DY\@-5e;+=E/]((_>T)acI@^(>9ZZE]1T_PX
K.@HL:(3PH?^\a&&]2Xf/g2=C.F;,Ba^b@6GVGHG=DG0/TZaVJ-S4Z]F.dS4e38b
WfReQ-]HE^b_3OX2F0:.e>.#@4ZXa=aHaVX=M4(R.eP:4Ig&5(<g?3&86D97RY\X
-^M&S6K\])G66ZTF6#.C0&)Ob^g=[[WP+dT#[.)UIXFT?Bd:OcS2]gaQ?[I91Ac_
SXT:VE#efVH2@I+_]cFC9YK@H9gYH.5TBPA_<V_gG^=3d]K79VL_8HI7F2+\#Y)+
GL.Z-C:L)68H80)CP3[[_LL,1/#3906,.0[ULcZ.(g-//8dAIV?QB&XV?0);O^><
T(1d9Rdb[].6P9DS(I9[RIXG#0COE@2\\(T6:DG^7OQW)RZO()=ME<VTXgPMHWF&
>_9DVV.ePYcE;)(@<O]+b,c20QQ@?,]VBc>+H2&bTU4Ca1R,FK\d<\]gDF\MA,L.
I^]fZ3CY-M26S#,__^e(Ka?9QQ?4W]NO:b+VK2I5574/a]2IMRf941DbX2:B3B\@
_E663Hd=1WTU9EHLRG;[]FD1;4dGeHc.-DWGgGE2b#EYS8TYLNODO+4QT@\#<E1)
Ke(?&E1BLg:7CP57U7XSKA6)_\5g>BK_fEM.gZ-G60FU>P?[42\AbL(G)0@YV&(3
/O8;/FfB89HX#R=Z[4DWeIEN=T,JG[+705WQ)+?6,AZWf[ZZ@4A&(I261b7H,A9]
U:IFL:0eCQ?fQ.MP:^b_1(b+/9f0N&f+PB:gB#HHD#eW/=QEHB-):.K9B)237M2/
A_eX)>NaBC#3,+<ZECcd<C,F=X9)E-f/OXIJ<]PC25eT-AdE[62NB:aH&JH)JDaD
W/Va2F6_Q5)@9a;(I,g0@&CA#8DU4W]YI&WYNDI>3N@AS@3Y\d3fJ.ZT@AR;C1PS
406.0cAg9PY]0d]CI&e5AVRNa-DEX&9YP3P:DVaWGE8McQI7UeFUGH^L@;Z2c>EA
Jf5_ZCN)I>@;bU#SM,=O_/UPW2/CL1=ALdT^b&gc3#\95)VQU=>\3OEa(#:@U4c&
W5M@NK<JKf12@7,D;6I)+CV^:T8D:c<72KH9=PeBUA6_Ad3U6)BC8K]9@E<(/IFW
-7>6F]X_5@)0ZM(MMN0K[&OG0@A+6#PB7dTGEFSXN_3,4JbU@aR[G>93V4Y+DPQg
8QA<-E]6UgPL94OFS.G@XFTX8dYf?&\&5;^OCX.H^7SKWFU8^PSBf)+(,QKC_(.1
eM<]OS);SJUE)&LH8,^U29>\VJFG7[Y)#SZV.d@L@?ROP&aF<_GH&3XM<C1G3]Z-
YXEOB9E[VI)8;YFM/XE6A^27:PeJ<1RN&)I@HL#Y_@9UJ\E4.1X]EY[/^,P3OKN1
M4[+BOKOd)UW>=2K8gc/<^]<e-Kd.^-KbC7[K=KW9&^0KbF)&)>BfHVcH:;MMFJ6
4>Q-<EX)NT.b#2?Z2KA@LYA5&bIY5#30A:A:YW\A_g5ZK^](g]X0(#R2IbWYV4S=
J_U9ZA\D-+3R-SJ[e[>_0>\VYeE>P0M1^43S/Jc&?K&:A/OZV8SV[3-\?@b6,cbM
)W:2ZE3RLS3<DA\V<22,WM(Y?+#&?4<D]@HXVKd4GfR>5&VRK;A[XH6>d4.C<e,R
TC#3E-g?SGMV<_EUg6]W4JS,U.=@Z#5[=-.6(FD2A3VYX,T]O3X.(::KL6Ld7g5J
/F^,9b)OFLE.(4@P.PZ/29=CXP8I]bP+Ka&RAGed,46_C)=Q:.-Sa(V2AHIgBF[&
&X)-5PfRJKU_9D1\CG^dK3J]DH<&3a1#Z@e^.PL7Eb7;ILB5IV[BNM9c@5]TQ22\
U&@Ig(U,d)&=6]](g:_87UT\>A98Pa+:U:48=(,bbF\KJDPS1U<M1E[ec#40QHd0
M4dVJB7Ig\32_FOS5AU(A5deFHA(AV#530=C[J2_Z&:[_#,VF_[QKY8VG,QZK,;c
@^SAO[^>be8FS..7SM;Ra,\CELK=)S,P-P;NSCS5H6WRaO<;XW^?;3O5#Q>?HTA[
]UIKRH;-PEE^Ze]K880P\;OMTgg3<&C-8ESD4I<dFU3)1?:R9-?7].OWGRU@@:9P
S0,^4BS_fR+20RGDIO_]>+/X9/G>F1^]RS9OYLGH5bXG&4\e:Xd5?bc#8:M+1\5b
_1U3[N-/1+]QIMU2YZ7J)Ia4V)gM?;-,>SgPYUBW,E(V4g0=(c8+GO9Y[UGUdIc,
2_TA)08>&_J]4)O^+_:)FJ@c\G\MZO90O&-GDIJ<^NCBW74Ngc_bP)G0NK97A4K_
+?;d75O<GA2197T_:^eT8]]61(-ecdUQJ\a.b/4/+AJaL^<\(DR(^LAcLE]:[KBT
b2/d_(Fe8R703c_0KQCc@/4WaN\IX6XFefUS>dO#&M3c]DKC:JJ_fW.0=4BQDNI2
A]^<]:=_:aPDcE0DN2PTG<Uc3E3dOdQZLRJ@@4,>H^@F_<aE5UPb6(2PHd@@2Z^0
-dQ>AS3KXf>gGG]&23T)G4);?T8YLBAS;Q75b7XKXIaSJcWGeE_6(KC^7FaGCUOW
86R[b5+M&4QLPSV<7SG)0CV@+P36;=NI4c@DJ(XZRJ61gJ]:^(+N)JO6cTJHH6IY
d\:L&PDV9P1TRa7E;0;G(d8;S_Z.;+Y1G5P04D,8KEA5d^G/<?+acGQ43[?H7=CV
M5bLTN(<KWJ]]]PK;W9SI/\OGdEB^6bL9QPN&G8^?>R01D[-<5K<D/?LU(EbHAgC
1b(@1EV/W[HK6_7Z>T,<[A<<TKDb1H+OM0BN[9&#@?&>_O8@=cFR[TZWGfRE?_=<
A8[Mc>>F,MX#f]eRQXaQ?ccQ\UP^X4P;)@@.A0_4JU>a#P>3/caZX.>VCKAcg26d
FF7)X(K+&:BP38<[QM,Kdc@CMZcVX._RBc36_#dSEZKW:MLA&N;ee(R@E:J(K[ES
EIRA)=KeA->H\a(>\S+?^57-F[YJcBd>WU&?>[4,2R85OTS08?DJ.Q6;VOF3c:E/
#14e#Ag-C?fB5JW1K5[&3/T8fSTfNY8VA=d)SEgUdW;S.c;5K#I99-^B]ZU1AHC2
C/KR<)bZ:[bONb:5e_2a+#?UV1+.9W5JcWWZQ4JCMU\K88\b?#CdF.2(PY9MV5C_
gS</cS11b@MDJgCJ8[:DK((.(Yd->@XAeBA<WY<;WOJ1SV6/f9MCPb=56fKfJO-R
+eTG,TdW,)cL^OAI96Q=A#A4)_TZT],cRYRB@F/dXE6H6f,gVFaRQMH9\&_UG<aB
U7@BR,OT48M7]A<K&GIgH3S:06YM8^7MeQ_5e+MD[@<IQNUFbLN?,C;PJI/@TX7-
<HZ-MP>.\P/1FBf-^9^582AV[-;-Pe@_><2/>DPJQecR5DKG\AD7Z,8c4L5f0D2f
&8&?Ace0#CcCI3<K9?a/#+gGZWNPJC/\H0:^3FG2MgFAbWZ/E]Z2ZF<c,/D]RFK,
OEED49Q_Nc2&:WdIMU[&W3;5cFcYLV,M<<[)B/C(3ef<(Qe=B&]HL(@T=X]A)M_0
9dOg-@P];WO>c.1G1e=gd5H8[Bc)d,X8\Ff]^UeY[I=2LR3C3\MfQ>_D\#RLZ<OG
ee&5ZLIG@NPGO_XL0^;;[W<F[=\S<,faQ/=#P0>N<BeWX)-=?CD9^\KR&#6,a^0G
TS1b[8]OdYc4KSPMMUA88.&.fE;TJJG0?]fCMO8/V#8?R][JZH[2C+WDbXS02.#d
;gK(H4+K33SJCdg-1[#P^Cb_Wa&Q4\8>Fc#5e:^-gFP#<.Q8G^^83ed8&I>/?.f)
_>DWXE/2&)G)WDAF2Q2(XHK_SNFD,:XQ_WVLZNA9BfLTX)d+1Ka)+g::/-H5dXCf
/MH@,YA5QH7XN;BFC[W[QLMcbLaR\aSce#\;SM6RQ<8&g1cc6[OI:L5:<JWFO\K1
5&F#,&&5)..^J,W;V[WUa=-<S=)YN5B^0KU3eCMZ,Q=M\HHIBI#X8+NT.6ZcMT5^
6EH=Ef#7]6:e9ZfeV6)_7Q0MObGcbU#K:S;#]GHBc:4?e,8BCDUD+Z3Y381U+)CP
-BSAEE.8+0eR?F2M6EfY5H^1AR8.TRAIF5,<Ud8?R^f,SKUO--Y7D=bK#\(5_FLW
B4;6OB2)C-AG/8G6ZPB>fD.@X.BE1LP0L\Oc2XSCdIfefSQM][U:Mf]#Y0.Y_<[.
6[:VSAKCe57RN6/P5VPT8LM,@ag9;G=d#9gLRCaA0FV2dXfWC_DKU(Ja<;0]1Z]1
(@RV12NRg(cK>88]6)V-cDRZ2MU;&&AH.gU?/JQ+U/;M2+a(_C70B&[+)Z7f7S^4
G.KFCG7=@NSBZ^MIMWUTQJKVgHD^@RKg.3\&9+RY0@_^>fA&,(&-[gSAWZ@/QM&?
b5dN-=I9BNY/bCQ-=P(+fYP\T4H>edNA5H/EeEeX2(3;_-&D@TM:,8+S?ZUZ0/0K
V5WI5I^+.AA=aQb72<1T<(E_\O_=5V\LRF+1e[dB;]Od]AT1+/9Y+,8KEI/XaXM<
30>Wa&J#\.eU7a3,e(0-E1W&eWLcLEceN3dAQUM[EU;X7@QVceK\C=IGSfBQ@TB@
\1OP..)@X304)B@)aJe:/DV4_W#CGJXDe7e/Xe@-e5J8YgYV0JA,-C1FbA@4KVF:
#@=ZD8C>FcD];IaN(+H;2d&WN:GC@,9L?2;f&QY9\:T^T+^QK\gK>K9@[gZUYH=b
KCZ\d.5D5JPU5M3B.dY07-/)]E#Y4651^g\=>U@@2#:98?bC@^A1NH?)V,A,CE<.
-<6=886d;22OO[C;;cG2=E(7fGY,a66aR0P5<1392R,WTZZDC3F71HX;XEd_./LT
d?eE&X;[X?,U=fe@.CJ_X(9EHfY7UbXY&=@Ie508U<W:S#(OQ(\W>NZ#;<-c.8LW
SRc&EIZHYfHcH,LWM=YLa)8O=ZLD/X8U#,dbL>+g.=aYGMW^S_[ZM)GfdM2?<W^/
+?DMEHW.Y@L6&6Q).:V4AIXN@XG=+G4HA,&\7RNW@VT).cXAPG[<X<]-B<+K-TbK
Y(<ZYR>,9@bYJ\)V00&YO?Y;bZV/O]SV@8PAQ&;D.,[fc@K3P3S7&]AJ))N8=Y&=
4UZ=&H_K=.C(X.BNQXYIJBG5^AgJR3=DHUYJ5Q)]353d@>Z\,4A--F,-gK+8P9\[
T3Pcb?4@S]BJ;NM50=A;a:I?#GI]C)d#Nb#0OS&adNYPXL17FgcX35+9PdLOMOT4
aIf;+EBWdMZ#&J<g7H]a3D,a#Z<N>:EJV)R#;[-))&OM5(B.8;+cO(1O,9(C_B([
dIGG9^=4@XgN&12^AP7]fd4ca_01QSXd+5F_HLE6&M;2fMS&E#=:aC-eV(XK#+X;
;IHA63C)L3FaeB0EB&Ad8.)?W09^XBY8H15<OV#gZF^7ea_J<g#;d2@B[b@L3PSM
(35[f?4F)<39SK1F&M8-@2Z?)=&4,;S=?\WCO&T\Y]QEQ1,K0R-C@C9<(^+fb&@c
Id0#S[dH&<3J[&VO,[gD0fG^dDN2W#D38U.+>7HI:Q&_.),,2PWc]b^QLM.6?])V
DN0TCaX7F.^26Y\1=&>Y2[7YH<^c)I[R7-cOR^R_)dJXFJ(bT7+E+R6GM5:X(84T
P->8<]V^V(M7Y(=LP^TUWSd;9f<3[)89ZYI2OVc.Q(]LQ.T7fHI7+7cT38=D\(R2
S8@/5+F<\O.B,5R-8=Og<@_K[48-9)FgW89L:\]^\1d<F(5=0SCO[+L->5KTH8QH
\^2=LI</<\WB,$
`endprotected

   

`endif //  `ifndef GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV
