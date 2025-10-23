//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_WORD_SV
`define GUARD_SVT_MEM_WORD_SV

// ======================================================================
/**
 * This class is used to represent a single word of data stored in memory.
 * It is intended to be used to create a sparse array of stored memory data,
 * with each element of the array representing a full data word in memory.
 * The object is initilized with, and stores the information about
 * the location (address space, and byte address) of the location
 * represented. It supports read and write (with byte enables)
 * operations, as well as lock/unlock operations.
 */
class svt_mem_word;

  /** Identifies the address space in which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace;

  /** Identifies the byte-level address at which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_WIDTH - 1:0] addr;

  /** The data word stored in this memory location. */
  local bit [`SVT_MEM_MAX_DATA_WIDTH - 1:0] data;

  /** When '1', indicates that this word is not writeable. */
  local bit locked = 0;

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class. This does not initialize
   * any data within this class. It simply constructs the data word object,
   * thereby preparing it for read/write operations.
   * 
   * @param addrspace Identifies the address space within which this data word
   * resides.
   * 
   * @param addr Identifies the byte address (within the address space) at which
   * this data word resides.
   * 
   * @param init_data (Optional) Sets the stored data to a default initial value.
   */
  extern function new(bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr,
                      bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] init_data = 'bx);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored by this object.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int),
   * locks this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked
   * state of this memory location is not changed.
   */
  extern virtual function bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] read(int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data word to be stored. If the memory location is currently
   * locked, the attempted write will not change the stored data, and the
   * function will return 0.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data word corresponding to
   * that bit position.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int), locks
   * this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked state
   * of this memory location is not changed.
   * 
   * @return 1 if the write was successful, or 0 if it was not successful (because
   * the memory location was locked).
   */
  extern virtual function bit write(bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
                                    bit [`SVT_MEM_MAX_DATA_WIDTH/8-1:0] byteen = ~0,
                                    int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Returns the locked/unlocked state of this memory location.
   * 
   * @return 1 if this memorly location is currently locked, or 0 if it is not.
   */
  extern virtual function bit is_locked();

  // --------------------------------------------------------------------
  /**
   * Returns the byte-level address of this memory location.
   * 
   * @return The byte-level address of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] get_addr();

  // --------------------------------------------------------------------
  /**
   * Returns the address space of this memory location.
   * 
   * @return The address space of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] get_addrspace();

  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this memory word object to a string which reports the
   * Address Space, Address, Locked/Unlocked Status, and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_word_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this memory location without the key prefixed (used
   * by the UVM print routine).
   */
  extern function string get_word_value_str(string prefix = "");

// =============================================================================
endclass

//svt_vcs_lic_vip_protect
`protected
VVKg:D+K]&?XIO0b#dO];6g.K)CAR-d9Fg7QJaV@bRXZWGL]>9dM)(C7+M@]d@L\
@HZAe;J@bC?GKWP5:0XC1HHF2>e0]Lc@3;(S2cb:G7O?d0>^@FO/V,N]UPO?B?L^
HP\AX(\-37U38D>9W(0)\\B45C;0CLMGEU@^_[20;7Z+YWRe:QN9]5G\-9AK;b=(
Y@9g#3SK2FV@LR9bJ)S655;/3VQN\EH9OEEK2IWT\37T<Da95(W>;T(Z^P(3UX2(
N,[^IT]&0)FWb#EC]<<#;S;6),^)cHO?eBKI#]agg;WeY=0/+56GL)QTXCO7XYQC
f,[H1_V)aJN(4C2W6,NAW830=.:?GS(H)f@8#\X;O-_0/L=0M[QN;g2<A##UdQ5=
&YNC;2dcKUfZ]YgT&Z?fSFJeeGAGL7-@V2fFMDQ1ZU9a5MX??K41?@JLVIgD>=BL
-IWUe^KVJb,]Q5.;Y)UaL;5CZ3]5bE60:EE7AFb44#7N&P_gGIH3F/.4I@aG0-&\
C1SbOc:_fE-06=I&g]a<)3FGcXa(>eA\03@4eB[,bDC^QDD7ZFPJ9@(VEM^FJ.&Y
EA6(9-]SgbAT]c=9VbKB;#5:LW[^W;HLZ#-9B=SE-R5c_ZY6bD\:KS:c&c5d,G_c
:c;54GO;NG7NIVZ?LafY;KcL,g8LV(K&PFVc&[LdcSJAO^MALbGZfZX\S;TO?N5B
S^3<]72d:ONRRD:D:?JRR__b62:cSPfgQ(We:8J.;A>EF[?394EK79&;Q(fKAI99
6829T4#-_NTZOYe/2ET#1YBN8Fa-\U>XeaC7C4M+84J=.7ZG]@73,gHLKS;-R6]S
P0NO.=?Q;3d)2Nf5GN+5g1F6fJAge=bG:4F/SG_Y.@DJVIM3OQ+<G=068KBA-I<-
a+I/]BbN7>bQ<Ff3S9OK<38:CNUeOe1GGN23aTN(7N]S_+aQ#@a\&\]@6\OWSUP<
X5K6UR8g2,3+=IfY][3@?#Cg/aId839QC5^C4)ZMT?OK@.Rb3E[:>ZVRQH,_E-g(
K=(JbSF428BAGIXCaHc>H_SB]#4&\/>1M&/&;J?Dg3PFOMb[H794S\C@SFf7VQa\
f1_/OI?44;Yb7F82E6LK02_J(8S=0)#/V]VS:g@(gEL=#[+V>1=ZS/a3-U<gPV^F
0/FWC[FS>PVd@#5IM5=87g(SLB>0^XK486a[>>Ha9LJV[G)6Zdc&OQM9.eDQ;@=L
R^/NT5;)W?6UKY[eK@2OV6#UJ8Ne?9@I0X^_<6B.,]+_&Zg3QVCA?19GL^<V6J+@
R.NJ7EA_V+U;(#ZF(8J0?)6:<aUE]1E07P/D80f+1.(,g4PQE@#[O-X2T[f1BagG
a@3,eP;1W)g26\5g40R+F6UA@OD\8LXE8dW:Ef4@#+<&BKDU.H&e5?[P;P5,,3ge
UUBG:dC<MI_6+#?Y/+1X;d^8)<L^;QOJRba>P#g>?WZB-MXV_[)#b&W/2#eC3+5H
=Q_M9fK^PISBfQK9]4I#==7b<Sg\[K&G6O7D;(7Cge)MCR:bP1Y,4\GNA:\VScXe
Lb(Q]N/OWM5W,D&CE@R(SZbC#M#&\@L;4KB_CF@f<eA@A,3-c#FIO=Bg;8,M4W[:
gA411U70G?@/CL?+8I_<WQO8NSDYZ),KgE.+(R3DJ^(<E9WP4B2IKQA8,4Y<>;f1
GUHIS^>ZAH#&1eaJg:e3AHAda7?ZSV8/CI#D-+1QD)];_0.#fcI#:7L/B;0V&H<@
ee\>-eFES+,[@UEF09)B,R6C.QTc,ZK7a3]B@NgF<#<Y1<[8SM/OQO)6Wbb0INI<
2JW#PT#P7]1?^UL6ZN-UC-Z_,[gFSdd#7BV/+2eVD4eS_.@[-I]WVG/Kf4/OJeY[
+<O]^,BASNIU]RCO?2ZYBPY3BY_d5cb1=0b^::XcSJG@VOX:XQC@b:CXB]fecB82
&0Yb0WBRZ9,g=&0NAN^4dB2)(=5CQTUb/EXYLPT_VU-]:KVg0YJ4.9L[\c_e&/NE
dX7/:IaLO8U.6A&1U97&Zc-)T;?_]W=B@3P=cB8LMK3c-e_,L[1R:e<OMM7TYE;a
g6+Ve=1CD4]KL0L-^M10E,[JCQG=G0#6R2<J#(a\W64JQM3]N@&AO.K&AMe]L/^c
4(SfB&MfTS.9c/##_ZIB17>I1AD_/,eXc(@@d&J,H#S<=;A6.0P(7AeBL,;XBI0/
=_I834Og7gbE0\U;<<QcC[K#b&]<I/N?>54HU_,5IZIK_)ZU\0]:&W(d)CK8d5BD
_BB;_RAcZE-^+WD=-]/;U/2^LddLa#b^c)dLf@([Oacb734A,4OD8A7QZ3NZ0&[N
H&KI[cb&4_HEL7+7;56E&Jea9MV#-[LI]=;H_R.aZDF]OL-8NRAJ@,]d6cW;/V;3
,J8I3eFMK5:>R8XIUG>10G9K&)HaSf).Ud0^<;Q_c4\5L5^EL@5(^[GL.Zbb=&MW
LYF./+O\dZ4((B<geOUdA3^PFLf;dZ.PRJF4]Y0A\fJYWe3)1QdAGN1a+P7BTcc^
FD/W[O6@UY)DS_;]@+=<VY5Z]P-+KB#.\&P[WR=<>26+Kd2Wgg>eQGb77=QXTQO>
/aIVMQ560F-GTBB;@eH)RY[^X-LD;a:;\:-b.@:<UOK_@<&5(UR7/0_PcN9[L;7)
5O6f]O]XRK#B_VZBGSVW8OgCeBYU:;IBR5e]IJSf>MdCDNL#7<DD:B+;_N8^bUg8
L#WD2eJG^M8&aF2+/5GI-RdR^&G-^c83T<J>/VId8\[4fCA]d:8,(?ITS#5F;-PV
)5.cX06M[&;WgIG@;PCQ96V3f2[1NUWZ3N);@]DJN2>a8=LDG;Daa>)A4#JM.gEX
UYGMMHB)Bb>>1QB+Y8OVC,3.-]N_f5[WeTB<9(@NT1_K@..NQH0CVI[OFCH&:.LE
L-]T7Z-b#9T@T,L2bJR6>I#(UJFJc3FLPTZB&/d3;9e8&7W2_BI7eKH-gC55MGY8
66U+(G&O4RH#4U:S(b/]cH5AKS/#.TXG1Q[eUF5+8Sfd1/G?O+bF/<O,Q/9(ENe^
RWZL;d\d7KM).1cgWOEKTEAgW>KC_W,b>_e9.MgE=+@&:eMJHZC6/F2,,]9?7;/A
U[3536^^JDCPJ73.-d0I@c4c;;1Q=&W^CSM=LYD16(?f4RXU^_3c5BIgd+6_:UUf
32?(NX^191I41FSGCXI2K<_TK?+ad<-_LE@D&2,K@QMU4\]1^?\M]5+Af>3EcI1M
)6GX=a_PVWa@f+)=](S2M.,1=E8-Rg;X;::=B4=5KEUG_M[&[G\A:QIa.5+([2CV
Y2Eb24N6/0Rf_C>T_:RVg9TYA:CF83/N8cB:>=.7=AGY8f0^Te(0.DR-QSJT4I\]
VMUOe79f<P.JV<A)47I]^3CYS(?:Q2.C6aP+8Z,;H9,a3-VY(^g[]1WFb&M?2c48
0):CPaZUSVge)f0XSWI,]TF>.d-9dJ>)K;]E=C&&]NF)>K^a]H1DQ\>TJG.^Y7)=
41BH_+;Bg\a?-fS.LSH)C#QQAKJ9a<)SQI6TM=<:[LYCU.KTPX;M[Pa8^8fX-8#L
:gB<8?S3,=+].c+,5#Ve;]LV<5Hc&X@ARGD</?P@5081YBD_DgF@CFZKG[I=LP,6
U[_>-USX0C_])$
`endprotected


`endif // GUARD_SVT_MEM_WORD_SV
