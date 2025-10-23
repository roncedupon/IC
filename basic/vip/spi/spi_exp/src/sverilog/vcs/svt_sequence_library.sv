//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_SEQUENCE_LIBRARY_SV

/**
 * THIS MACRO IS BEING DEPRECATED !!!
 *
 * Clients should instead create sequence libraries manually, using the
 * SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE macro to populate the library.
 */
`define SVT_SEQUENCE_LIBRARY_DECL(ITEM) \
/** Sequence library for ITEM transaction. */ \
class ITEM``_sequence_library extends svt_sequence_library#(ITEM); \
`ifdef SVT_UVM_TECHNOLOGY \
  `uvm_object_utils(ITEM``_sequence_library) \
  `uvm_sequence_library_utils(ITEM``_sequence_library) \
`else \
  `ovm_object_utils(ITEM``_sequence_library) \
`endif \
  extern function new (string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequence_library)); \
endclass

/**
 * THIS MACRO IS BEING DEPRECATED !!!
 *
 * Clients should instead create sequence libraries manually, using the
 * SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE macro to populate the library.
 */
`define SVT_SEQUENCE_LIBRARY_IMP(ITEM, SUITE) \
function ITEM``_sequence_library::new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequence_library)); \
  super.new(name, `SVT_DATA_UTIL_ARG_TO_STRING(SUITE)); \
`ifdef SVT_UVM_TECHNOLOGY \
  init_sequence_library(); \
`endif \
endfunction

/**
 * Macro which can be used to add a sequence to a sequence library, after
 * checking to make sure the sequence is valid relative to the sequence
 * library cfg. When a sequence is added successfully the count variable
 * provided by the caller is incremented to indicate the successful
 * addition.
 */
`define SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE(seqtype,count) \
begin \
  seqtype seq = new(); \
  if (seq.is_applicable(cfg)) begin \
    this.add_sequence(seqtype::get_type()); \
    count++; \
  end \
end

`ifdef SVT_UVM_TECHNOLOGY

 `define svt_sequence_library_utils(TYPE) \
    `uvm_sequence_library_utils(TYPE)
        
 `define svt_add_to_seq_lib(TYPE,LIBTYPE) \
    `uvm_add_to_seq_lib(TYPE,LIBTYPE)

`elsif SVT_OVM_TECHNOLOGY

`define svt_sequence_library_utils(TYPE) \
\
   static protected ovm_object_wrapper m_typewide_sequences[$]; \
   \
   function void init_sequence_library(); \
     foreach (TYPE::m_typewide_sequences[i]) \
       sequences.push_back(TYPE::m_typewide_sequences[i]); \
   endfunction \
   \
   static function void add_typewide_sequence(ovm_object_wrapper seq_type); \
     if (m_static_check(seq_type)) \
       TYPE::m_typewide_sequences.push_back(seq_type); \
   endfunction \
   \
   static function bit m_add_typewide_sequence(ovm_object_wrapper seq_type); \
     TYPE::add_typewide_sequence(seq_type); \
     return 1; \
   endfunction

`define svt_add_to_seq_lib(TYPE,LIBTYPE) \
   static bit add_``TYPE``_to_seq_lib_``LIBTYPE =\
      LIBTYPE::m_add_typewide_sequence(TYPE::get_type());

`endif


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT sequences.
 */
`ifdef SVT_UVM_TECHNOLOGY
class svt_sequence_library#(type REQ=uvm_sequence_item,
                            type RSP=REQ) extends uvm_sequence_library#(REQ,RSP);
`elsif SVT_OVM_TECHNOLOGY
class svt_sequence_library#(type REQ=ovm_sequence_item,
                            type RSP=REQ) extends svt_ovm_sequence_library#(REQ,RSP);
`endif
   
  /**
   Counter used internally to the select_sequence() method.
   */
  int unsigned select_sequence_counter = 0;
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Identifies the product suite with which a derivative class is associated. Can be
   * accessed through 'get_suite_name()', but cannot be altered after object creation.
   */
/** @cond SV_ONLY */
  protected string  suite_name = "";
/** @endcond */

`protected
MQ>>#.Q.2.5.1FYO@<fODH6Q1RA=?ZJMe&TCc7RTNK^+XF5gW8V<6)2#cTE]W:e,
AM_8Mf,I3\OYP.>@ZU6VE3a,+X<VZPS82II&9_aU>9_((SBe=,<7V-2#M$
`endprotected


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /** CONSTRUCTOR: Create a new SVT sequence library object */
  extern function new (string name = "svt_sequence_library", string suite_name="");

//svt_vcs_lic_vip_protect
`protected
)c5ec2NJFF?Sa7R>Vd4&CdL-A-LZZ3SdQ,>BYaP?Mf]fZ>LR=0930(_AGD[L<FW1
ML=N>VPb)\]+4(MeeQLP2.9,6I9BV9Ae4GB<.ggNL3K-:543+T#dB5YScC+2KZ0N
S.5&/K&.S2B2+#gRf]a,Ea,Yc<D&gKG[L&W_?6dPW<BbQAdFZ>VKR9Z?E6;\.cbY
V7W\)Q\E3e9\F2&D#dfS3WQYUJ-==2FGaM?Z)W_Y:<d:D>&d_BW>feW<fC:R[G^>
(8EGLAJP>SC8E-(<YS6P/15SA6(:#C9UV]Q&COeJ/W@D7FX^4UTg=\XFAD,13Y28
0_B]d?Z2I^#X57#c,T2\O.c05:A:9[=-.a>:^5/]Q.8[V490@>T^>3@O_f]M^61Q
/1PRU7?I;4<H</;U:I@&BFW\-??9fNFS2F37GI:?aQc,IZ+f0,G7W<1U#OVW-ABT
MNGN@B8b/P+B+Q_5/3FF/g,f#)>b-PF;>_V66MC@eV0P8E\C2g[L1T@EgW.O>?#>
.fHb2Hd&Nc)XO4J2/.G3Ea3B)3]4\@f1bX88;Wae@?dAXK4>RK@>V+.^VS^e1P7f
Mb#NTK80Q8RK_2=+fgc:\=c9HGI/;YZ>(JfZ^Ye;,=W_MYFI4I[gG+ZRdUJR3Wa@
JT0]g(bBF96DD_DEScZ+0)JC_=NC_Y#82ZSE)J(7K#3aR-Y;5-U)gAZRI$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
Ve^d+\)LE@_T6Sc<1)a^_e=QQ9X8bg^/1@:bGdXPR,.&KI\cc(9T0)K>30L6BfIK
_BOQU(g2e[V:B@Q-f,a/R9<eR<:_gJJEYQ]SR_^J52&&eF3B]5)#EKJVHECZ(Lg:
5[3[G?bS17I:/$
`endprotected


  // ---------------------------------------------------------------------------
  /**
   * Populates the library with all of the desired sequences. This method registers
   * all applicable sequences to an instance of this class.  Expectation is to call
   * this method after creating an instance of this library.
   *
   * Base class currently implemented to generate an error and return '0'. The
   * implication of this is that extended classes must implement the method and
   * must not call the base class.
   *
   * @param cfg The configuration to validate against.
   * @return Returns the number of sequences added to the library.
   */
  extern function int unsigned populate_library(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Generates an index used to select the next sequence to execute.  Overrides must return a value between 0 and max,
   * inclusive.  Used only for UVM_SEQ_LIB_USER selection mode. The default implementation returns 0, incrementing on
   * successive calls, wrapping back to 0 when reaching max.
   *
   * @param max The maximum index value to select, typically the number of sequences registered with the library 1.
   * @return The selected index value.
   */
   extern function int unsigned select_sequence(int unsigned max);


  // =============================================================================
endclass


`protected
HJ7,F(176PUC,_-3LF1F/aa-::)f=T[IV&b,\8#MdZ[f7dH@6fT30)/=C\MDU9F>
[[D+)8;;&YPQ\BG+aN,H8=TCg/&()Q^:@55_QU0AV^QcO=N1:3dZX.KEM9f.[-=?
I3MCW6gO3.AB/fLcXK:(/F73>\PRR-88IM;f:EeH0YU43aK7g.cUd3JQ;c\>-FA>
6,:PI:S[H9?TO,R(,94M(f9>e790PN6PH^HE[QB3:BU0SUJD]LADT&^CNUC=3W=&
E;/T&TN=:FUDGbRBbI4;RFK3HADc>E8dK[A^F(?DGI_D#-:fU:+DL=fXgd3IS=VC
7B@WS@B.9N?ONZXc7?Jf6XK(e8=)2+K?C:VF/&3dNd#^A+:c;ggLJ641BXQ)TP.K
W_T2[L79><+G.b\SCb(?4RS,H37SFYOI1.S:[L5#X1I3FDFO(]S_BK6&R>.1X6;;
6A((FXJON&M^7Gd/Z<NX+#7<0=AV+XZEY70QMM)4:0f5W4A5Z4UGW24]e:&Y+DJP
&8Hb.-Q;a=-+QTeHUUIEV#OYc,6^R.6RcW(.T\O6/U.AX8D20US@)d_\;60JID^5
;SGJ&[3Qa[F[C>e/XaD]1P)cg==:aaT@ddaLX,I(XLBY/Qb\,b(><2Nc))YfPP-U
2@G;1?RI-LSf=P-&<=8(7:A^NSfe[]OT>1eL8PW4ORS49H>gf(e,B6D?>VEgVFK5
<],P[V_)bZJK.,E5W>RHcRH7cJ>Uc+VgMcGAaGGHbCG>RD80]d^K/[^X5>f?8P?#
A#3cT@HZ3^MGI+=BY@1BWH]/DQJHGD;JT#KEC1(L?#I+ePOc8AQEcLSGPL1Q+XK7
XQMFU17b[>7gDBZ]U9C#GN]/2$
`endprotected


//svt_vcs_lic_vip_protect
`protected
P.#EL>3T)B9+\_VcLDIA#YMU=a\eF1D+dD7QNaI..74eEXb-X&MJ3([BNR7b=+(H
Q4^?OT^K+cTGVMe.<FN251ZH4D2>10cFF9JD?7+V[#1c&STXA4B#2U3\18H=-A=.
9Y@eUa[ebTZ+0aVGa8EL^THDbXL7##8.LcO&&fdM_,A)J.C098EdZ1MV)be;?44d
I2AdRH3V&1)=-.#]Dd[-^UbT(I<.?cO:3^R1OZ+>92Tf4B16A=b_#]DW?+Vd?KbS
DE)\)63e/[6A5b:AO3-N[3\0?,:N.Qc@<?ILVG+BUgPPdbLL-?W;]<3N>(>^MZ<<
5:Z9Bc8-U-=O(JAAIE[)[0^@aYT,(-:/E?1[I)Y:_3-W[ff38)R,4,&^C(;S\a8]
LJM9EX7b&_gJYWE,:RIbF?3#JJcHLZd-H+I+?Pf9-H-V.P^T1N&^629c17.JCa&0
;=[.PFA#\>-U#<FCTdd-\&8VF_CA;=g=R>Z:J5BKI5MA4Xb_)-#+I&Yb<aG?^[,d
M@>/B3_YdMF/&^P_;;b<&UY_B-5&NWZU_2XMPAM=G(HZ=bP9SSELLfGQa6U&B\f1
2d]ZE<^#]1:B_>Q.@1_<b^3B/ggBP3\<6<S)/9]A#[\_8g:N_E^4<<JH#WP:>&>F
e\)^SZa]a@XJDM<A)#MBcVP&@]#Z&8-a:2(fGW3SeE@fVbC)])M^4MKaOWOU1HYR
?N>^22NT#B=Qf-Q^XHJ.2(b0EbX?OPP<<C9,J?AGJACXB/g0cCdE5/E&=fY)SMFK
>K1QKPA556E,ZCDF>&d<W:[a[7^B]QTAV,RXg894Md:\#^bVQ8Sg^C48cV]Ng3WF
<T>^69W3?(K,4P@4SgCP+ROE1/67]4)(4d)cBBb>:)0#)YV^\Q)?LKI6Q&fR8S3[
+c3ObU7.I4fc3FZPPSB<=[5c/OK8IU(V1V:UQAIP?:3-_PdE<]^>C</Z8/cd-6HT
F(M0Y+aW)&?6&;cE6g]C98>,._=G,2-7#VQ&)D&IBNV+>UVdcM0=23d;a5bG41ZP
IR+a97]42e/COZ53?CZTCJ;[_13XIJX1&U.,fEOLHeV8bI#bI@;A?HPc^55.:K:g
bQ7:8FZ[][a:S>^H+gBE:9UYCe^>HU]IIR@eIA(L;2C=_97\OGFO-#_-G_=+ZMcI
294N<NP/4egcD;0H+dK.\1X3J.NRG@(g56cM&3>D1=+D,U)X?T8]]X@IEgH?U4M:
(&V1:b<YOMOE#2B,a/-X/J#]IKZ;XR?;5@,Ub#NNgd(G_]O)dC)O.0U,/1AUd;;K
2G+a361H@)82WY-A.>8?O-HD,6gV]cQaQU0R6R,-f_>^OC&@NFd31G/LUYcI62^:
J-3DH>A,-_T@PZC1E.PP]PJI;e6>Z;4bHb-#XOFKdSQ0+b<&BNM.gRXF?#LR?(4F
TbfVV:6O27I@=.K9g=OKRdWC#)0cS8Y0K2fIc/YUB#3@3e#1c&,0V5]&/^S3)4\A
e19C7B)c0^KI0K<ffU#ag:1LVT&33:3A9?g]3.VTKUC]N&.DUMB1U<Ib9-T[IAQfU$
`endprotected


`endif // GUARD_SVT_SEQUENCE_LIBRARY_SV
