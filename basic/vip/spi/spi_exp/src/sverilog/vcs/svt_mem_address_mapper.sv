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

`ifndef GUARD_SVT_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_MEM_ADDRESS_MAPPER_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This is a container class used by the System Memory Manager for storing source and
 * destination address range information and providing access to methods converting
 * between the two address ranges.
 */
class svt_mem_address_mapper;

  // ****************************************************************************
  // Type Definitions
  // ****************************************************************************

  /**
   * Size type definition which is large enough to facilitate calculations involving
   * maximum sized memory ranges.
   */
  typedef bit [`SVT_MEM_MAX_ADDR_WIDTH:0] size_t;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log instance Used to report messages. */
  vmm_log log;
`else
  /** Reporter instance Used to report messages. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** Name given to the mapper. Used to identify the mapper in any reported messages. */
  protected string name = "";

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** Low address in the source address range. */
  local svt_mem_addr_t src_addr_lo = 0;

  /** High address in the source address range. */
  local svt_mem_addr_t src_addr_hi = 0;

  /** Low address in the destination address range. */
  local svt_mem_addr_t dest_addr_lo = 0;

  /** High address in the destination address range. */
  local svt_mem_addr_t dest_addr_hi = 0;

  /** The size of the ranges defined in terms of addressable locations within the range. */
  local size_t size = 0;

  /** Delta between the source and destination address ranges, used to convert between the two. */
  local svt_mem_addr_t src_dest_delta = 0;

  /**
   * Bit indicating whether the address range defined for this mapper can overlap the address
   * range defined for other mappers. Defaults to '0' to indicate no overlaps allowed.
   */
  local bit allow_addr_range_overlap = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_mem_address_mapper class. Uses 'src_addr_lo',
   * 'dest_addr_lo', and  'size' (i.e., number of addressable locations) to calculate the
   * src_addr_hi (=src_addr_lo + size - 1) and dest_addr_hi (=dest_addr_lo + size - 1) values.
   *
   * @param src_addr_lo Low address in the source address range.
   *
   * @param dest_addr_lo Low address in the destination address range.
   *
   * @param size The size of the ranges defined in terms of addressable locations within the range.
   * Used in combination with the src_addr_lo and dest_addr_lo arguments to identify the src_addr_hi
   * and dest_addr_hi values.  The mimimum value accepted is 1, and the maximum value accepted must
   * not result in src_addr_hi or dest_addr_hi to be larger than the maximum addressable location.
   *
   * @param log||reporter Used to report messages.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(
    svt_mem_addr_t src_addr_lo, svt_mem_addr_t dest_addr_lo,
    size_t size, vmm_log log, string name = "");
`else
  extern function new(
    svt_mem_addr_t src_addr_lo, svt_mem_addr_t dest_addr_lo,
    size_t size, `SVT_XVM(report_object) reporter, string name = "");
`endif

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Generates short description of the address mapping represented by this object.
   *
   * @return The generated description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_addr(svt_mem_addr_t src_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to convert a destination address into a source address.
   *
   * @param dest_addr The original destination address to be converted.
   *
   * @return The source address based on conversion of the destination address.
   */
  extern virtual function svt_mem_addr_t get_src_addr(svt_mem_addr_t dest_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_addr(svt_mem_addr_t src_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'dest_addr' is included in the destination address range
   * covered by this address map.
   *
   * @param dest_addr The destination address for inclusion in the destination address range.
   *
   * @return Indicates if the dest_addr is within the destination address range (1) or not (0).
   */
  extern virtual function bit contains_dest_addr(svt_mem_addr_t dest_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check to see if there is an overlap between the provided source address range and
   * the source address range defined for the svt_mem_address_mapper instance. Returns an
   * indication of the overlap while also providing the range of the overlap.
   *
   * @param src_addr_lo The low end of the address range to be checked for a source range overlap.
   * @param src_addr_hi The high end of the address range to be checked for a source range overlap.
   * @param src_addr_overlap_lo The low end of the address overlap if one exists.
   * @param src_addr_overlap_hi The high end of the address overlap if one exists.
   *
   * @return Indicates if there is an overlap (1) or not (0).
   */
  extern virtual function bit get_src_overlap(
                       svt_mem_addr_t src_addr_lo, svt_mem_addr_t src_addr_hi,
                       output svt_mem_addr_t src_addr_overlap_lo, output svt_mem_addr_t src_addr_overlap_hi);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check to see if there is an overlap between the provided destination address range and
   * the destination address range defined for the svt_mem_address_mapper instance. Returns an
   * indication of the overlap while also providing the range of the overlap.
   *
   * @param dest_addr_lo The low end of the address range to be checked for a destination range overlap.
   * @param dest_addr_hi The high end of the address range to be checked for a destination range overlap.
   * @param dest_addr_overlap_lo The low end of the address overlap if one exists.
   * @param dest_addr_overlap_hi The high end of the address overlap if one exists.
   *
   * @return Indicates if there is an overlap (1) or not (0).
   */
  extern virtual function bit get_dest_overlap(
                       svt_mem_addr_t dest_addr_lo, svt_mem_addr_t dest_addr_hi,
                       output svt_mem_addr_t dest_addr_overlap_lo, output svt_mem_addr_t dest_addr_overlap_hi);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the low address in the source address range.
   *
   * @return Low address value.
   */
  extern virtual function svt_mem_addr_t get_src_addr_lo();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the high address in the source address range.
   *
   * @return High address value.
   */
  extern virtual function svt_mem_addr_t get_src_addr_hi();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the low address in the destination address range.
   *
   * @return Low address value.
   */
  extern virtual function svt_mem_addr_t get_dest_addr_lo();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the high address in the destination address range.
   *
   * @return High address value.
   */
  extern virtual function svt_mem_addr_t get_dest_addr_hi();

  // ---------------------------------------------------------------------------
  /**
   * Used to get the mapper name.
   *
   * @return Name assigned to this mapper.
   */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the mapper name.
   *
   * @param name New name to be assigned to this mapper
   */
  extern virtual function void set_name(string name);

  // ---------------------------------------------------------------------------
  /**
   * Used to get the mapper name in a form that can easily be added to a message.
   *
   * @return Name assigned to this mapper formatted for inclusion in a message.
   */
  extern virtual function string get_formatted_name();
  
  // ---------------------------------------------------------------------------
  /**
   * Used to get the allow_addr_range_overlap value.
   *
   * @return Current setting of the allow_addr_range_overlap field.
   */
  extern virtual function bit get_allow_addr_range_overlap();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the allow_addr_range_overlap value.
   *
   * @param allow_addr_range_overlap New setting for the allow_addr_range_overlap field.
   */
  extern virtual function void set_allow_addr_range_overlap(bit allow_addr_range_overlap);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
Q@:7YXVD>UGe>Kf9Q_4eRLfC5U=_U>QC^bWJTeE.Je>,bQ0e8eHJ6(6P2--\I&RZ
<+HUJe<=g-<<R?_8FMOa._H8g;dO9Rda1]6N6;+R^R&)<VNFb<[0^HI#L/SfY^U4
:D_<acRRY;&0A)Da(>D/gB(BgA@QZ1P/;/X>FZgVJd.1&D\5U1ZZW8[PQ#M:fIEf
0dN#N/6_Vb+P@;eL++.=5^65Q??8<<T&]#+aX3UESSXH1K/Y[VX2+0d16cY.8M13
AQABL8cgg+&b@,U>^=@]Ge83f/(N;&4IJ#4e5Xe+G5633gPNN-aV0&:.Td?+KYbA
,:K;)D8,;e<JJ0MIXP=G9W]UQH7,OU4&EFVYbG5gW?TW)g/W<]&Q:Q)#Da,RM7AL
]KW_0-@M\<&S>K>eH4c46G:&<Y+G6Nd[=M_I(6CKea.LadgJO#M0PBbg1[A:DOCW
8Ud(D:U<7IVD-A_AIED.BL;FZ\WV4I:V9Pa]Zd[+4Q?^O6CEW:,+GZMLQ:FR-(G>
\R#)c_D&8+D=-N&WNH:6fOC./bH6N9X&Zg\,MJ-cT)Lbe.MCfQ)Ke?1>:]bHH.F-
L[W4<H0#/E2K\]V]_;2L@8KJUa:-C4bUCB/M;:^,R4R@VHWVTZe;Q-)N3FO.R)2O
5#cbL.3B#Rb#DK)2ae@B&G2^g-O7bcO4LE_:Dd]30QW70SE\>&IN_KBgeO?TCC]0
6#5f\]ICJ\7XY]VIX+g>]5^XaC/-^c32L];b)JM&:+UNY8Z046S./gVW?L3RNUE^
bRZ-f&PK;+UgTdd=@]]L+LXSA+KFGMF_6K/Q258K2JXeaVC8aO=Y3^S(-O)(_:bW
CaLJKC97b9IR:gH&9d4I^&3U#VQ@a:=TDR,eeP1\49^2)]A2U1JK(]OT5_<2T[Hd
]a[f[::W0EIP29faMLdTC4G)+Iee_\aS,K+(##W<Z5^FQE5ZG5V)=1#Te4M<d/W-
V-[[>>be,eK.f^]5G(KY=5QG,K.YEVZ0,c[>H>a9dR0^<AZ[&BP4PH])\b0D>/U\
4+1#2aUP[32f.T(GI.X<HfFP_P7c(aLC<Tg&MfVWO81<9[^H<DAAE3IAG9<NM,SS
NKe_DP]?X&+5A+2.U&\UBCcN0\,T;aC>#K41KC8(/VGd]]@6;5QLETTJf2fNTHda
PJWQ4c1+NZD)#;e5EZQMd]_HDNMUGa[C^;3F)27N5SdLc;WR@gf4,^e1DC-_7E6@
RGe6)?:68]OS7=B608X+5/I)1.,aLJ8^>)=,c](-OAPI?7>N=Y3LcR[5b9)L=B:6
ZR@6d@&^1EBGN^<aTb=3cNZGH]&TIB,5],YSU;?/?++LbM^1-L^VHGeB;\)NAH^J
ZX4[>SQB7P#<HW&1/P0X:c)U90V,D&2N014Yg,[[Z:[H(=@CEA5@D\X6#GO.N]VH
YJ.U8c9_4K;+_CQ2:[\NgY\(Y)Y/9cWY2Z68(ggF(a-W<5-52cWH?fXCG/)X[ScQ
918b=62ESZde:]8ME-<^5P,P387Y&=SYSU50d4?LKH#PFcX(,&<S+E.VY6gJ2eM=
1GUgTP8D^<7E=+[]Bc+MQ]Bd:4a5d1U<K<L6I<#FGg[VHO2fd0FXE\b(9L9<Je#+
:M)\GTF<a[a(b2#C_F[934#=6^b.[/]XaB++SM&HBL1Rd?T17B\&.U?G2;7,/V-R
6J6))5cG++WDO@)6#:cE7&,+KH)ENMM6(LR7I?&R.J06@aaRXCNS2)DfECcGeg9[
TR?3(b20eM9f+WFT6+]T\DA;,I]BNbAb]V6[N&(@8G.)dcd_R6eb^N>?75QaNY,@
CKaT8H,&05HL>WBgH<&@Z6EN3;R7CH?SVJ)OdQRUC,E-[4C0>R[1b/#XgT9W<gO,
]^O>d4[2E9/@GNfGW;3(7ZBHYc-3J89>2:.f;MY(6X@,dI+#\UZd#A,\GeXW9?=)
:KcK:-[eBa80B)7=2@NZ@9)JJYd8#HG/(,SeLR[:DceOEXb_PT_Vd8+=K\DAM<V@
860?HCEg[];/<22_YK),196a<2H&+(#KK?]O.M(Z)-(F]7TR(8<)ZAFB3EX/c,I-
_R@J]e/?3M^b)UUTJG2Y,N=JB7R?H@][N64/9UJeA;R:A+],./eY/^b\?VHHJT.a
(R&-ZPf,.>f^OIA&S]KUc>fF.==2b54;\]6(#/@e2H<N-Q7)?^SZWHETP)6<3(06
aUF[e:F6)bHQBX;DFGCBH2M>-_PQC<N,>@^;[.4c2V.IeNS:/B=9A;3@Z2U_ES>b
H(a8TX\B60dB27]fML>0Y68?7MHJ?R_\49e?M;3]1[CYHB]O>AUE#eT7,TW.=V>8
K6T#I^#f#5CFY0FbD&]_AY:NQXc5T:_RM=N@<2KNM[DH+TN^?b>P.LJ)+MW=+@D@
b1-,,[Z,./)>]5SYL4<KCf55AfN<50ZRcD=;Q6R=SXgeM(L5DY+T:[gDH6]DC1IK
cQXBTTWAg)LY+/=f[]IMS]gGJ(bR6aE8M+UY3?R08IV?3Vb<5fU.-HdR]5eS-:LC
SG]MEA(\eP&YS-bf1WfB9S;E-]PO2++BV?b?HKb\=TCF:0?4e&PRZYY&P)/f).c=
feK]FMQ]>/J1Zf-=4WU-1TP5_9^U8H)W,+2\bP-3YRaF+X[CUX@J2J;Ub8+DbaC^
V?:eF9faQ[R&Y.E/_SK#Q\b\e)8?A7#2-TI(,BB;\[VKGcGQA0,_CCcA1KI<>aW9
?57eN9HP^8_d/NaTJg=V<S3aXE?d\/;JHA4dLBdDC\YJ\8-R=./M+4Oa8#TVJ:7O
:f6Z5()C)]2AM>CLcQHM?&VMPIU8_=7b@<:50.2[T(MM-_.f8S8.4XZ=J&K#H#AD
<;.fLP-O/C580N+6]42&.C7B8K(R@8-?[#=B_M.c?-52&R+-cK>M/g@+5BM,a(Te
_e]8,O=@MHOI<-Xb7&@W+8,ZJc6V54@Z&Te5]F4I-F+eHQA&E\]A@0AZ4QP7#Y7>
8&&M9cKBPY,3GMa,_52>;2KCA/18SfXOJ8[L?N&@]fH->-6eRP_BM?.^+UNeEgHY
P48VJ5>bZf9A.V7@CP;:[8K-XVeG8102YX^.HZ<D3F;)(WI0[HSEF]bXJ-;J6U,<
7-+AC)C/TYb6,X&9@7Y4W3)a14<?/T=;f6.3b5W@64&>M(IP(-&W3bA3>?VC3KXQ
L:TSNN>G>Sf#cg^_Ag)2C<WIW-6X[H:Q_0AHUMPVRSVWPNb3bM2VL>&c]ST)M0fO
[AX:K6a0A>_L:\KcdaQ>&DQ_84B&Q(L)XC@XLB\R3:SF8XNW+NN<44-HTe5.]?K_
>)+&VG,KW)2Q8]YG2)HcCEIG>F)MWGbIYU>?@G<Ia2[OPgc>2a[F0JZZ[b7WJN?a
EEGbAe#8))A[dM;49/QgEeMO@R7LTa6D-gEVe2AIg)BJ[][#^8[99)9g#dKW<2FW
c+^2_0W)-eVIS6V9G:V7Y\@gQ5DD;Wg1g_29M8ZMcK0J-6@d?VW3&:5:>bKANT3O
>cd6R4>_^S2,=8OY9G;c5_BGJ9fDfbB_P/:KY=AQ0[/.V(BcC;8BWVc:-Qd#EBL2
c38?edb&<T:.6fd0Ob\&0UF-9/V\QFOFDL=;WU\DO0\?.XE1@>3&8#+??/8g\ec6
EC=V5PSR9UWI>+@4(+EO/&eU=Za;g<O]-+CbfK_>UW?L/e&.M<#1S0^\9^G-UIVK
9ea0]57TMg_:+@NA?8HQ,PLKc;JNH++NA>QDU;>COF&b5S+bTPP(VD(ecD1ELKC3
SNJ.AgK@,U-88J3BP2H__e#L+[D_1HT3AC-./NMF5B>T.?A,IKORP?)gT9E#aKA0
Se+\T&/[_03WJG@X8OEX^+Q2E16Qf427O9B[d<e&_2_?b#8:@7@TbaYA[fL-c].B
+O3-1#FZPLM<K1V[_D)0G<CQ&#&e5)(c7O0-_&8N&e#[]J/g#L3(Ie:D/BJA3QJG
=g+@SKdX,>J#g&:Jf@ES#B)gdX+^c4Z[MRaIKD6KMVWB6><EJYVZ5LYJ7O#/AFGN
b08d+Lf=8LdLT0)0?=KcUG>.KT=_0&2V59G/>R)BTIDb=1UMLD6.EgIFLI]B^6.)
Y.eO\#>L6eMY982a>@B+9E5.8FcS[L/bRVMH?_&Bb<\?c\Q6I_&Ia(CZRN5JcTHJ
e,NQ0U\<\-aW\0E)TCNOG4/EQ9gMb\=MV<K9OYXbET@@<A46>b@LMf0^^:O/ICX.
bc,Rd7=[(6&5Wb1HFC6=B=7KO@>@;SVHD.OEDQS57S(2:RUJHd_)B.Mc[<1A7SZD
L5H<-B.ET?A?c_]MMWbf9g4TY#YbZL@I.&H@)d4ZS\+O.NDa;)f&H&JAL:2UR9TW
XYLVDIRDF6OHZM6^Nb0a:6aX->VTFSVb=[Wa_KbL?+JMdE)TAMQ&]ORGY8?RaD;K
JTA4BVB\IeYdT\G-DXg:G:04=M.caHcdUg5-U9UcACbI1aA_F?E^#K8?3)U@H13P
X3RWT:#WB5\<^&VM.HJ8\\KN33-/ENR2[DW_:-DQG#S3a3)ReY6#E=c)KQNAS[Cf
=c,,B=N^N[[PMOFIS))S?8TTKF1X9TGR>&NdQ)&CbG8.+^1_1_/c?V?BMd3Xc3H)
U7aa/c4B60e_NXeFTZQ6]^Vg;[0I@EcCE6>bG3LEPRZ)@;B+SX_0[G,,\CIVWQ3(
4Cdb(A:NI=b=UY;f.WL_)JEUA+1\60TN<PX(CV4USUbf?4151_42XM).42&XO\,D
ML^#,Ke5ZL2RW#.67g36Q)PIW/REH6Q=/3-3\]B1_F>f=;7(MTCb;&KBc7V5aIFZ
?9eF^C7M4UCP2>9dgJT]fade96?INgbLE2;?VO^Z5YB=I?E@&(C,VH#YV(SLD.)(
<&-/+;&XfER:I=/O]KD;dDPF2[[#aC]N<2WHC(KOX9bW5B+#>dT]M.@,VS2eb1T^
HcC0C6@&]B&)#KL)YI0^4NYNbe6VDOGQ\5Zb2=O[c2O+T0DUFP_E;0+[.[,T.A?9
RM-O.3MO+)BbF#L_A[=L7F.6XBeRY0YcYge@?/g7,a;bK:CY\.=\Y0^bT[>9W&?N
RPW]=Za&A8753d[9#=ac97I3JMg922dG9R-aJPec3^U&)6<0XXQgE927,YF4d,5U
12;FMNZS#c(GJH5LgFH;Ec/F^>3,L6,g93/#KN<T-<0VL3:Efb]Dce^7&2VXM6;P
76?2QZJedY_1)CSTI3N[)R:T3X:_@EZe#.E#W)+e^aWE??\G-VOd;#3U/4UX?9a.
A8\E#9I>_e=UScA+UdP5=ZNH9ZW,<fTMKD6N;FR2+.1\L7L^+PaF(aVb2V70^[H#
/XU)[,>FfL-EDfMJX<&cD@/.QA7X1@V>@1bBN,.DR=(+#POO,.WAW^<MGR1/R#NY
AHYR@RLL,A^ZedZcI)M2fJA)M@d45XVZH:R\8-3DH8T7TI6557)b@VeDUL9@FUbG
eVDPb<C15P84]83A3>R6f7Ya)?bMHXAO(7PgV]gH<^CY:D=IBO>4T=eQ>^71>NC)
a()C.Y=Fe[N9gBU#7D,38=,&Y>-6[\&976JWX9SbfZ&CS6FGYNfI^?eeC/B6-6RS
?ET\IJ5AZ/JNC74<#CH-B#Q>O0S+19Z7C?KWca^6:X,5Z1_DNF/5We8g9YH>JQY6
+54W6_4(3O;OQSJ9[JP@0M(R,cbHQ-c^@-C3&b-Q.f@00_X\N,YHf6(TF5L:5V6W
51f4aaLAJ/GH+?JQ4:SODTY?O&TD.CQ?QKZLMgTb[_NcfN8ed<Xf_&TE,KSNCNbO
F&EMg9bZUY^F\fL)gELe)I+EOT<Y)]Z@dL2TM32;.>[aB6.[9#&9T,4?1AQEf;^A
EJ:P=-IcKF@7S&/O=[Q,UZA8b\c:66Y28_0HG7[MQ.S.+OUCTQJK9dIZHK)-A][L
YZ&O[T9YZS00-HH8&TH=.6#a1-@MA_E/+KO0a3RAK\@FAH6KJVFW[]RFW+8,HHX?
Y_Q=7cgW6:G#X3;+(7(=MEH]IX)]?1]N>L\.W\M-FH@62e@T1+673Y7V:_4>3d^R
A1:.KRQDF;M:2=:,EO6581:L8K=:X2Ja2YC99b@_f010KaA)/A_WKGAMFMV[6?1/
))+&UH_@K+GCYR-/&?F?TW&2HSLdJ.:c/4R#Z6[#.fDO(02C#Y-LEQFROGd+Q2D_
<+L^OG)OH[_\bPAS:>PM0/9-:IZW3=[67]:L(f,C.?R#42ZB1#?\EPI0(#]I24-M
+#fJ?WbM#>fC9D+[bf\Cg]C8K;86MK(P98SfU/e/63M#32-?;dVPPSJ=a7\0c;Qg
7,D#@E_a.O55cJ7ZB,_\?H.Y:DdF86d;SXXG[571a95eC_T?1=5OEPHgM-9YT>=<
gU2\9GP80gNO\OU/dg2WN(dL,CeFO9Z.MGg8bUVeT2fKLYI=?-P=IeVE/AQ8AV1W
/WG:b9]\DfTUE-:9R</ca55OY_cFb/G,BO:_:fMFTT(MS[@9a2SD)C:KUID@PfO+
_)aGWF3DTF/R#c1HP<L#]4FXKFMP+=#XKMD9J/IZ(\cUA,<7Q<Bcf_\(SU@_9K[X
4VG:FX4/\MDD97;0X4e6=);=H;G1g/2d+cF7e2a99N8KEa:1IPFKXBO.b]SBLCC7
GO(4L[EP6gT]IR&2U8Wf_U^AQ-[].5P+f.;b/X7GU5J8NdB9BWCEP3a.:YZQF\e8
\.<cCa2A?9cNQ#g(-X2SdD>&8L.\L=JWYL,fNcd11F?(678L[e@]FVWO4B:2N]?I
&T(ID@&:bOF>C;NGQdb.g0e^B:Ud[6SNfeR9//^>D)T5TgVH]7(Ka9BD\;ITCSAL
W;ee#d;>g8G_f2:+aVd#4:B9&Y[V^#HU(4XT&Lb;&S9<YML/aX]?7^M_T\KC4[ZF
[M3KU,EKM->@#.X=f:6]ZYA]b[c5dPGRQY;dZ&1N[G4MSf1>V;MZ04QX,PF<#VVA
:g:_I=6_a[DR?eU59#B54;/FRET;&#TQ;(aBfL7XfAQM1?N=[I=CN9CT(R^Q_T+8
1bfGLd4=>)AEb\D3b9-B[S:T1Pg2YUJ@>f9J3N?dD^/ARM)R.4@/K)W[f9VUUT4[
/F:ZZN=Z(Ce/K+9b//>,da-S_-@JU.?/X^L8#B)JB]RYLPJfYdaPZKOA73CYL[)J
XD\Dg0DT]1Bg+JO[)@&EXJ^e:g7BYZPZR)HN;(f:f#5+B<,K612?S,[9:>R4c-0.
6.J8E7UaZ]VD@D1>,be0OF&YfT@3I&?G0<AS,O76<N;[#BZ_VF+7O[_Z=@CDVY43
=PXRfW5N8;.]HW;A06caCDI^D__dO?=4bB.IdCX_&IWB6A(B]1P;E.\cgcaW75\<
NT_X4:IGHf,HGC0f,ECESBES(9b)@TQNPXH7VAaGHSF_9:\74FZ):eQO(@_.V?2+
a>[KH[JZOVN[O5OLB]D.^K?F5/W:)Zf6D#fD<?2.fb7J@HK/eG67[fec94TOI?MN
Wg)#]YNDNF2IVNQ5e7E3/E1A^P1@UXHK031aIV:)[_G\5]7d,Z0aEK+D.DIaGD_,
N0eXSWRR)VMa:/T>+gSDSNg_V/=g=-;M?D3(:OJ8]#Ed#Y[KSG]-\8b/2M,WK5f3
<T+XD704ffI93bG0]:G,Y;3#c\TO#TLG1FX.>#QKHI<;UgSRdCX:Y1R+d/I]dP;V
3Q(f1H?;6KF>T3=g7U/#,<JT)_T&HE3NcY(WV+[ScY1G)KYeSV&aX&aC:7/B6KC<
bbK=@?8?FeL-#>XeO9RET>C[JKK8QNMK^^OH=1@+J-;B[K-DK8DCfU+?C=57.>@:
N/70TX^7PP(2(F3Z7P579ZFRMCaR;:-ER(#;6Af:,eXH9,=;1L,K.4>,3/:)@a0+
d8fF54PaDa_G6\dYDZcedGMb-\>FCWUc1R>adH/<R1L_Y8L+HL[5.aLP4R<gQ:RR
;,.bR[UeETR?<0QVMXX6,L05d_&WQ2/-YS:fUW+FW#,1KZ;&RY#f:aQY^,a_g-#H
9cZ?K1E,87&;08eTMF[(eRfVN]WHRQ)Od4b-.;2_0N98()3U,<Q=?N8X/19O2C,:
D->2D_7L4X/-.M<D(a1)[7b23SV&2bEYD[1/@-@]L-S\Z[P_cF,F7/dSgW<bWNK2
E<1g6dBgFH3WCbCEJ^aEc_<[,+7HESXD0aOE(O:e4^+OZW1B;>VfG,WY4?K&^WE&
?ac9VMa).X#&;<;L(&YZBg-C2-);B+bb-]^JOg3&4g2XDOO=G:LJ<24UD1Y754/W
HA]WLId093&94)1f^AB^c9aB?9e-gNOS[I)?/1(Qab&3RCK<_c7]15YKOBRUS2\&
Y?_9I9c],dQ<P7J:4WR-A2JSgR:V/g6X.dQ_B5A2IaTME3Y8B?5ZI/PBIT,422]P
&[1a1MH+J,\e;AVYU?.4??\@=]60ZE7X:07WbZ0.VTeC(G5ZKLLK8OV(;B\bHY@7
QMOQAKV7LNB1_2181\IYX+5?JZZTW;JB.>#?f_ZF#4=VX/fF;J[N0#5-^=a#5+4b
e8#M3V/d/5MaM-aOGeP.I\-<d7aQVK^[7NU8,4eCTH0UZRQ3YM0IA6LA0b0\6LbF
/0<W&ZXTeY,FBPD8REU&>RTce9N879d6<G;a_@.NGNT(d(/W3^B0DeI+BEQIX5c5
MPJNS;(8&V]XZBU,XW/SVDWHR5]LC.ALW6.Z&7=fLa:<:I/K6@PY)e>G0b;VG@7.
MF6U.MN\@0PbO3gW3<5V]YWU>?3EC:R9)aF]Sc0/^P.+(&-3:N-F<9#TJeS#G8U@
3b3&5IEP^8@Y+ZfNc.)bWOHXQ6G6]&BP=(-U&E&(W?U>TM>[WW_a)(.EJ\:If.C:
Gf:42I-fR:cVK@#R=\V(M;?NIEO6@BG5=BPD[[DJ,:(&\,eBE7+)-L56g1FEG0;/
L3#V<2K6GaJ5<g.6FZ64J>_91.8X-;Z7FNf41.9(R7H3GTD?)H[TXJ#\KHggJVUL
gHIZcNB8(C?db--)gL#X+S_=@b@Jf0ANT[847X+eI+LPQ(g2OaM/4>XS[K6EH;\0
eDJ.RDQPS-Sb]MU;XbXE.J5DZLSKYg2^SC1^HB(,0Q&4<19c#O0GcZ^(AcCaK;JE
H/aa]Ze^J(D5N=KXeS29c7W7Q75QRH&C?U61RG]b33[V.g#OgO8aO>^Zg58Ma(D0
PUBY)\6R;\(MX8ZIgC[<JN<99dcZ&O2>RF42g[gK]5N[ML6R3,X0adS+R-[,-04M
E_ae//+RaJPBReOD;BB&;f7>:\M=(;S(YbK#;<HT[8W>1>4=+N-9\cVaCMGa>>fd
91]2UFCR1:e7[>?3&M[f(G-+UCTYIBA[=bZ[I/Rg0S#W[T45=1:RS?LbgVUXC,FD
W+,\RO(<:#@:;&>5X/,U5P07[FLZXbd#TRR9eAG@)M;PIVF1HcZGeR/4S&,GV1NI
+=_c8Xe+#WW=<3:Z,R@5]\#b_<A<_f\A6^5<Ug8gJJ@T+F@aI-QTDJ,3-Sf5G.>8
]Q.^)Z^J,H<>#P?OBR+UNW/M+K3LAUP5-VFI,X1aW?V^4;MRNA1)^,<<L3E1AZ&W
^<#LFfY_?6YceSHCWT?d-],S=NOH49(@g)?gTF0_7B3C]O/bY=1>@TT4@19THT8+
_+&H6<0gU0+J&O:JCMO[3f/)bc6.AYP0Z,:;OYWR@@N>PJ<6RQB@J5LL/^W_B9\E
[W7&a]W<>]V=47VTXb=##/dSgET49-L^8]6(-Z9.A].,g2@+66S-3@]+=8eR&S-I
ZL=.]LCfDX_E7f:>(/69c]X-e7,BWa17RRH?AOJa?YWT@/(X:fI86XIa1)ID.L69
NFZ>L+Z.B,T?GGASS_,KIeD6R<-BQ.PaXDLD&+a@0S\=;HBG39Fd&_-M+#IUTZLB
@Rc(d57=Qf9O.g=d8V[EUbGB86ZQLA(D37Z[f=eMZfO<FaJQ?N)(18PW91^Bb_^g
A_E/AD]^6135:-JT6cc\&eAD(8f97^0CD:)V6GH3#]1U7C&OHU^&#@(@3<6b923Y
K4H6Y+RbG&V.B5OL^8=CO;;gd5E2dZ7T#_3<KAUe/2ga&R>CCX3I^G,>4#/]^0NE
P?Y-B\.>3(fDL[_/L3@C6]b>0+.K1)07(.V5)&^O6@Y=U6;;KTA>8QD/RJJ2b;8e
d4[Q+FLdO/AY:@RRd:O_XMSW&JYS:#Rg?9;=H7N\6f;\D)JDBP7#+T06H=)9I6>2
P?8e:HfP5\Z(^/IV@[G3S<5T,0KU<;U?1+3@=Rb=P4VZ8+NTb[NfdX-agQ20P&NB
I>(9a[X7dQ/?^CGZ>UNaAc<]gCRK=0,I?:?_H6GAgU5JXBC^CVfT=<>=</_Hd/VB
B@6Z[T6N4V4H9-.cZ]V9CVaJ;@3Ig2ZaU-D(0>J;bQB3[-[#ZOcXYK7_@FB62.XU
B<eYTK]FRf-JV1[&T),WO[D)f/D@E>H=:8g\UF/QZ0=J)L]aK@gR1R]=UF8\?<4O
BP@Q?6.Z-6^Y_=LB,BU<TX>\]8:T(0PgLXI[6Y=(N@2+;UB\c>-I@34HIga&>99S
M(SD/ILH.Q2@X@</^[cMTcU9^/W:gJNG\3Q_A#Jg4O/FSN>QT1A\F;P]O>^@Wc+e
(3e]>FQ3.03@/$
`endprotected


`endif // GUARD_SVT_MEM_ADDRESS_MAPPER_SV
