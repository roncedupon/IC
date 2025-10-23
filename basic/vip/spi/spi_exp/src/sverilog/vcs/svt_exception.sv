//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_EXCEPTION_SV
`define GUARD_SVT_EXCEPTION_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

// =============================================================================
/**
 * Base class for all SVT model exception objects. As functionality commonly needed
 * for exceptions for SVT models is defined, it will be implemented (or at least
 * prototyped) in this class.
 */
class svt_exception extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * If set to something other than -1, indicates the (first) time at which the error
   * was driven on the physical interface. At the time at which the error is driven,
   * the STARTED notification (an ON/OFF notification) is indicated (i.e. turned ON).
   */
`else
  /**
   * If set to something other than -1, indicates the (first) time at which the error
   * was driven on the physical interface. At the time at which the error is driven,
   * the "begin" event is triggered.
   */
`endif
  real start_time                               = -1;

  /**
   * Indicates if the exception is an exception to be injected, or an exception
   * which has been recognized by the VIP. This is used for deciding if protocol
   * errors should be flagged for this exception. recognized == 0 indicates
   * the exception is to be injected, recognized = 1 indicates the exception
   * has been recognized.
   *
   * The default for this should be setup in the exception constructor. The
   * setting should be based on whether or not the exception CAN be recognized.
   * If it can, then recognized should default to 1 in order to make it
   * less likely that protocol errors could be disabled accidentally. If the
   * exception cannot be recognized, then recognized should default to 0.
   *
   * Since not all suites support exception recognition, the base class assumes
   * that exception recognition is NOT supported and leaves this value initialized
   * to 0.
   */
  bit recognized = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_exception)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of the svt_exception class, passing the
   * appropriate argument values to the <b>svt_data</b> parent class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * exception object belongs.
   */
  extern function new( vmm_log log = null, string suite_name = "");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of the svt_exception class, passing the
   * appropriate argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name A String that identifies the product suite to which the
   * exception object belongs.
   */
  extern function new(string name = "svt_exception_inst", string suite_name = "");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_exception)
  `svt_data_member_end(svt_exception)

  // ****************************************************************************
  // Base Class Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception base class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted.
   * Supports both RELEVANT and COMPLETE compares.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1 );

`else
  // ---------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception base class fields.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
  // ---------------------------------------------------------------------------
  /** Override the 'do_compare' method to compare fields directly. */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
  //----------------------------------------------------------------------------
  /**
   * Pack the fields in the exception base class.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);
  //----------------------------------------------------------------------------
  /**
   * Unpack the fields in the exception base class.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in verification that the data
   * members are all valid. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to change the exception weights as a block.
   */
  extern virtual function void set_constraint_weights(int new_weight);

  //----------------------------------------------------------------------------
  /**
   * Method used to identify whether an exception is a no-op. In situations where
   * its may be impossible to satisfy the exception constraints (e.g., if the weights
   * for the exception types conflict with the current transaction) the extended
   * exception class should provide a no-op exception type and implement this method
   * to return 1 if and only if the type of the chosen exception corresponds to the
   * no-op exception.
   *
   * @return Indicates whether the exception is a valid (0) or no-op (1) exception.
   */
  virtual function bit no_op();
    no_op = 0;
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Injects the error into the transaction associated with the exception.
   * This method is <b>not implemented</b>.
   */
  virtual function void inject_error_into_xact();
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   * This method must be implemented by extended classes.
   *
   * @param test_exception Exception to be checked as a possible collision.
   */
  virtual function int collision(svt_exception test_exception);
    collision = 0;
  endfunction

  //----------------------------------------------------------------------------
  /** Returns a the start_time for the exception. */
  extern virtual function real get_start_time();

  //----------------------------------------------------------------------------
  /**
   * Sets the start_time for the exception.
   *
   * @param start_time Time to be registered as the start_time for the exception.
   */
  extern virtual function void set_start_time(real start_time);

  // ---------------------------------------------------------------------------
  /**
   * Updates the start time to indicate the exception has been driven and generates
   * the STARTED notification.
   */
  extern virtual function void error_driven();

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  virtual function string get_description();
    get_description = "";
  endfunction

  // ****************************************************************************
  // Command Support Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived
   * from this class. If the <b>prop_name</b> argument does not match a property of
   * the class, or if the <b>array_ix</b> argument is not zero and does not point to
   * a valid array element, this function returns '0'. Otherwise it returns '1', with
   * the value of the <b>prop_val</b> argument assigned to the value of the specified
   * property. However, If the property is a sub-object, a reference to it is
   * assigned to the <b>data_obj</b> (ref) argument. In that case, the <b>prop_val</b>
   * argument is meaningless. The component will then store the data object reference
   * in its temporary data object array, and return a handle to its location as the
   * <b>prop_val</b> argument of the <b>get_data_prop</b> task of its component.
   * The command testbench code must then use <i>that</i> handle to access the
   * properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val A <i>ref</i> argument used to return the current value of the
   * property, expressed as a 1024 bit quantity. When returning a string value each
   * character requires 8 bits so returned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data
   * object array, and return a handle to its location as the <b>prop_val</b> argument
   * of the <b>get_data_prop</b> task of its component. The command testbench code
   * must then use <i>that</i> handle to access the properties of the sub-object.
   * 
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command code
   * to set the value of a single named property of a data class derived from this
   * class. This method cannot be used to set the value of a sub-object, since
   * sub-object consruction is taken care of automatically by the command interface.
   * If the <b>prop_name</b> argument does not match a property of the class, or it
   * matches a sub-object of the class, or if the <b>array_ix</b> argument is not
   * zero and does not point to a valid array element, this function returns '0'.
   * Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val The value to assign to the property, expressed as a 1024 bit
   * quantity. When assigning a string value each character requires 8 bits so
   * assigned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
0F3XS[S-<N@-QXG-W[&YMW]K2E2&Bb#@4BX^DY+FIDMeUT2+P+5/,(9K9b-L;S\@
IA/;H:;DX-L//^K:@aW+7Z5J4SBNF_U_PbN:^J<e,P54fPcEXV5HQRa(Z;./I4LZ
1@dH/\.RC)/#_M:Ie=?UKbb:(Y(/[@eC@I^5_:gXY9Hg2+>\-]T;;e\d3/#PL.&/
8?49e>cI</bIS6]0NU5aU,-LYbEC3R^<]?Q&<ELWF;6EK?cgTDI\BSfa+DTe#Ie?
1d<35RU&fI#<?U;B@_D4e7YZ<(ZRA4@UOY\Id-WJ?K21D]\I9TZ]3IDCL/BE)-U:
55IbZ5WUPEL<APVUG-=Dd#]O04Hd#SeV8:U2;Y^Fb)X2<L\A2[)9S4R1<:XWb4R)
OW-IgM0VFMMND#RXN:8UXC43,2b];TT\0AgOB>?-6JS[C[LIR+e<#(;NAAcFR-T3
S;e#BPRMVfeRB3K5)Y00.&8K:RG=UOMc>LPG+Zf:LDE3..LI/9bN],,:468C9+]@
7[1,_13VN6a)g4>VVJdVV.g>6Ne<<UB;3\^NY=L+<Y_9:O<62Y]ZM2W<_PCg39G8
#WWZHb4A\<W\:Y=gWO.CZ;W&ed2f5:@H\83))LT_B+X&=P@/XJ>]&@?dO<]g2EAe
PEX/,Zf<<M^0QgU,J70YV+9S&T5SW^gH2G3Z[Y/<I1(;&Ce.@G?>D-23LTgGD@F:
<F>RG[I6S]MQ9W)IaK9;<R(4,JZ60Z6F3U4=:#V]C@Hc78bZE&EG,V=10S0+SN(K
704K:Y,>Y5+BO[2B)LO/7)G8J&dT(6K?d4f7;EXC?D7OeD@NEG]4AGOX(H7IBA:4
a1S=g.55:K[--+f(STKa;9C3OcSCbJcW?4d#KGcT\:81c;6B7>=Q:#Y3+gV(eF,b
WA>47?:0<Sf7Y3LfQMB+LCBVH1:>0B/cKNFU8+cb8\gE#][^VF;39fJVL1[c];;M
aZbG;cIbR\(e-3eQFF-ZgL1,6>(H\a[?U2WF)QW.=I^2:K8=./2M2g4E2#CA3-K[
6/&,0]TBBN1I7O:D@5W5eDD-_gbV+CKWSM=KQf0)T+(F#:\Y#88>6S](I?PN.B]-
McD8c&Y(0+0fGfeQ(Re]bD7S)&3(fbI__b_\gJYIZb)De+<[IKRcCI=J1F,)/cKB
P:43M#CHfN]R:g\YHDWGHP)[e-Pf@,1C>?ZPABMP4)[5gMIg#bKUdf0(YbFTA=:T
I[G]RdP#Gb6ID<dCAd8]RLBX/NQ6)3>[+7Q\=-Vb9dH3(>\LZJ0XMb^U-M\b(S<a
Wc68G4Y/[ScT84G.SP]-Q9EN,]S&=-9\2g?gg5H(&X@G&JU>,)))7)YQ6/Ma>IB6
GBd)\N>88cRGgWZ]D=[VWT,_CN\Z63&XK(MQ;O2]EA:G13>?-Q+(E[WFHfHA_,fM
ZOR6N8O/AN5^,[;bJLND0AV-(cbTE(K^7O4Md:H7eHgV/[[,@/;(UD+MV;M&\^#9
:4KY-Z]G3:725Z-NGGf3:DBF+RV3e-;V.&66cOH8b+OQ)YM4K9ddO:3.7K=KH4&<
DS,eX?ee9HR4S_6[F1LQe3_MI=#[P=&OQ1MdN6Z(Q/:F@LOXb[7#Z>F[g35\)\K[
LeCV<gXa+D71\EQ1bEZ2OUB56HST[c9Cd:8^bTPTHN5aQ>cKc#CNN2FUKZTR<9;_
^N?7DFKN\\8:CBJ[=[M45CB>2-<=?RH;5:J3=1-dYZJaYQL0D)IID2GZSQZ?TSJK
J1B)Mg#@+Z1\g+>#NKXR@INH(BD<-.4dU_<4_WcA,Ae/8:eC0Z==WU7g[bbd5##d
MVb9fN#;GK92WYcU+/e_.Kc(X7,b+P4I-BTHY9CXXY&EbBT,#L2Y>5,N7(TGQ?VM
&R(X3G[<6[KRJQKcOBL0]M]YZA+D^c)D16@.=IYF&<d(F7H\I)H+.Qb)<:V-_GWC
XZ?EA<Q^M#&KJc5ZJ4SN2d;cI7HB(FHR]B);;aY6CHP[YM@(O=OLS@[HV4>(([M>
cE(aOe7P,+^c&EE@;cE9XJS^bMY;RN(C4),B^9C)&1OE<d9/?P=a<.8a3F>g7^?Y
CfM@KCR2CEe<(PNM,\b4[HT?#XbG&TP1_N.Ag21Z=.8W-eV]D>(E,<M8_N13V\[3
<@fGU:N111;U3<=#dU0R9Yfc]Dg1BUM?K,^cI(14ZB#Md68H0?]C?)_LD7<Cgg[P
LD^X5)K>MDC#K4Y60)IF+0=&?G1^8OP(7[?/^ZQN3F]>W86+4=,0?K-Ab[II<O[I
c?;A:FL\-^TMLM)gY4\34O;4UVcH[\>@AM7)4P#_N#g>[^.C;OE@)&D4@+5NXJ/?
V\H[^Ra)BX6+b,)+3dS2eRW[2.W74PC:JR-01A8^DV[4..(#)?Y6gT6UA),7f;g<
/LM+SXGR<O]W:C\/cA;)W/>QZ9A-d=)/df?+I>?B3JZ,N<IM)MS@4.#fBKO6FOR0
)^A7JPA0/G;@fcPFPZ-7B_QV]=\#P?1Y-;5]43Sf18AV>9U3\)9WU^RIM1g@Pd=<
)\3__0L0Me4TWbI9#T&fYMEfVg[YTdOG-agMDe/&-=;+&A8S>c,@J.AGXFV.&gBT
[E<+VF==/(2Q-gdU89?(Zeb6(@R<8b8A@cL+SCJfX&AcdRfcFDH2R#R(<MI3EPE&
>)(B0SD?5YV<OQOSPKb8LNX/eQ;eOP)&Zef75Z5J45NS3\Dbe=@:GTY[f]2g_(d3
?9J_c81W^\B>_TZW]&IMRcO8X1FS3fVA?_KQC5SRZ3/f?()T5#8bS:Y0[5WIG?_T
Wba5Kb8SC\N8&@=R3J)e-Z/6#>KX@L?abGV9Ja?J_O/8dbN5ZW@&+J<?-C5/G?Sb
e]K3&NH1AYSYeA+-,gaMC(_4<BR[)S)(EM0&B-]+&-AXGCQHf;[Z=R4ABX<Xf&cF
/<#Yg2/Ac,J5-YgTTe&a9/5RHc^A.WAR.-63(SBL?]C&4-#_gE6EC,1?1e-IELed
0,6)eUZ9f;9Q\ffVQcYb\.5#KVWL96R=H,T.4=Qf1EUF\c5_AUH-,d[9.Q/39NJ0
G.U0BU#@:74/Y0HGCB^;T)/YL([9C.d&+?[L<270RR5/^.L17P#UVU5.NYBU_KGZ
L6HRR2FfLfUA_P>BdfL5[804I@Iab:B^XH=YfX6aE(=3/PSN2N1e2_5QJ/=-OJP]
N_f]@-1)K_V[<I+YBDe8g)6>7Z(cQd>QDI+#N5ZW/DEcIRD?D]e.K)H0eC<FA(J#
bAT&V/A0+)49UZV]]6;K@G4I#7)DY=acF=4Q/d;;U^,C2J8(^2GBV)B8SfVMQ\&(
WUeSg@48>@Ng=FC^f/]/-(+;AS\),c@Zb(NH,K_8Gfa_-G1&1<O_ZLKJT9.dFZ7e
H(&-NKJ>ZR^e62E=>&(ZUP1\_L9KBc[_>QZBD+=8]Sa@7,dBa+b=7NU#UH^7LbVL
>/Y25,95\XLB)9(8._[OCG55.G)cMFf.:6NYb<Tf4JSPX,8E/8:=8][+e,DgbKV.
XSJ6-=P/WHIW?OJ81#SZ>MfT=IQYJB)MFOJ.64,[U/O0LS-VE)LJAPc,?ebEX+a(
;Z9.6Q9.J5DTLGWK1[S=N/&)DD3CWc\Q7Ja<:QWI62OJ@+6X:,:UJ67SS_R@&I,-
aKO\2-:+1J=+BR6[0f7=20B[,]cgbP)@Z(9T4ZI<:5\JY#[_H2(2&2S(M@Y=/O]S
5C]H>&]5]Y0AJKZQA<X8<N^-=?4O&,cOB0\Qb/=S:fYRK<2deKOWec_MB4c\DL<-
2\RZBa8(Z&)OgeMFcZ2SgI/?#Q<CW4]XJ(bdK_Y2@H(G)af2WI7BCNA220<80MGT
Gg6^ZZ@Q8A09ZgM=2FX[C)O#NLLOb08W)RO[^?)cTM3LT#(UM4\<VGKf#f&]L6ZA
e3SAUe@N8f/G(b,CKf[U2FLD,\A5H5O..R=&H;X-<CegWTcY)@X;bELHRAHQ[ZDO
AHge/@+-a/#>N=[17ZM2A)PbY&263Z[Y)Hb6HVPRX]4W+0GgP__X^7g261V?S,7Z
,+dVKDZGBdYB(8bBb_K0\TQH?QVHBU]RU_d;#(VV=BdY7HO(3<=>S8D>G=00c7,W
^&9S/S\0-QP:\C=\=8[Vf0>O/9;XDL?SZ#bO^JK7H>>D@c=Nb/f^TJ,Q7;JY_SG3
^G86d8M7D<VD\F8gIfTO<WFZ_eX/QIR=I=eX]5OdRF2D,C#JZ,4_X=J;W9_=7N[X
Sf/\[\0F;/YK0,-,;1QLN0NPH4>1Yg1)KR_[,:UBXQ^]J[Ic6=1D?f3=T34BaO8S
H:b-[XAR,aPVYc#:4.Cc?N^+ORYGK/[#[),;e8J)A,^BSFYPS.8HZBEY:@dT61>K
46-]I:.3-U<\4#D45T/+eC;J,d7(_&(,MMc2HW;^;F946-P)S:D5U^0NL_;?WSXI
,U/A_G?Ie(&g(K\b64YY1#>BX9@+4,:)/):XLXA2>/H&Leb/(&F2E9d<f->YXRAK
HbH]FS>T?\Xg=W0d68<X3b<T._Z5g16JPDc.6Db;;4d4^L?SQY07e[geO28K#IWf
IQI:a&@90+F\ERD,e2.32f9/_RSZFTaQ#AZDNI4,>-gWOU3=U:<X=YT^7;.I:^Le
6P2X\X.;@E.4NJ37;;dR&E_9^S/ed+7N:VHGXP7W5](=^CO-IGUC^FM;1C)f+Q[]
<V1U.1?28FbQR:QJ8.]F4UG4^LN9L\J>=>MJ#Y#RF5dUQ4>#7<170e[XQ5Gf8Hdb
?.dPCAR0d1E?NGOQe?(XQVM&@f8&K@:N(59SAKT8K/_>5B9fBZaT9]gDPU>B?RV1
?X\PA#?I>,?J<AUE72VLHeMb_7PL9bVE7cLM+[M9Ca@(Y;,b7b(?39BgYR._SfMH
[OM;0[PQO>6XXO1.06080@-]WB,67T82S,.0#\bR3(U8V6#EbDGY^,=[Dc?F8?_F
6(X)8E>Q;XE4A//H[5b:GE&eBK(1CTLD;bN[.KNPM&+aZ6(d,Z&&c1c/XTF?&#KF
ag<c@WB<OG,dZO5T6IOZN.HEcBfa^dUgK0\0[H2ZRcc_@W[0/ES7Z_&Xe1)\.#G.
J(0QSU5C.eVOVe/F/M]6A@H5K60IY5R;LEI@,+>K]DJE1Pd^]:>7,)L5IHgUS^c+
7G+;99V\1R=<A.OAg=.+YY8HY&MNPNUYW9/C3JI<Y=[SBSNH?)gHRUOD9SNU_^gJ
84ISZ@LK,NYg-=@R=>+[J);0ZaMJeU#MNL7(cg^+_4e5;]0&X58H5^4Z7]c/_bEg
P-NS:ILQ4KF)HP@c1D\.XJP:39WWO2FUR<WGgZIa=N+CM2GZfU>0^XZJA+3b9NON
XADb+?[=^e(I/1bR=N9Rb/.TN9Hc#U>)[V_WFTPZ1V]961FaUS2C[9J=K<BTI-[<
RTQ8E=]D;g<8ggdB2>UC#TY^]EE,g\H0(ANa.DIGJJZdOf=0C/A>G<YQMP.)Q;,f
V0A:93aUe<NXc&<L;:\/f_O+AHB3=[67YJ8Ud879DL3]21\AI9g.8OXJ-=O5](MP
F7RH2]AMVJA6Z2]ASH[Z5LS^5NJ\^5C#)fd@B5F6X^6:N(aDL=@O#OJIG<JPNDOB
V<dRf?-bN@9>DK7^BU_d9SM?)cMGHP51:5#fHORA0YQZ3L>_Q.7CHPZXG6M&87@(
ST9fdSHZUUT:&D&YSf&cdD_([Aa#:AB?@+(0(JWe]aaDa]2(DRFJGcKP3./>eVE>
feQ^RaE-).?3B<I0:6(_4@aL^3Z\@C33OV(g>-H=^<#F3=Id=D<]L,2>H-E>ZT4)
C+Yb?W@SF2FXC^f+BUB0c^,7@<cS)=?FU0]^L]JYe]VER4FX?ePDfJ&K#W0S<ccX
QV&#RB9F7BMCTM:-;\K5RaZR=@5&/HcD+6>9DIZ>X:;Rd?Y0(\]g?@V7eJHKP3W+
FH+.&>_N3VcXT[8:XZf7I_\)J_[O=;;9MBDTOG5V9:=J/GJ>3#fHJ==aO<S7[0g/
>Y(J]RaVC/)72g>=3^adRCT4K6@]5UM\e+4J1Db/d(MW/W(RWXfKFD-@=Y1@.W?C
F=>>@QKVEafQNgNIR6YG6Y>?(eBA)]1GSba;@+SZFFG#W;5<dgRg-:Q8_FIK<U\d
Q11Qe/:+b_C134Jg_/AG8EX/G<BXEKH7<F@1P7]BF;@R8B-V_d;_FF&XFP?gQ8&E
b<aP,PTSgUFPeL#=@K3==aNWeHI#+dacEHMH:BF2aYK_dd@\JV-/@&&J@^&GX(;6
<b^[I71gV1aLbgb8cG]Y^@ZOKT,11N1a8@D#(CfOHM_>5.F88TXa1R_;>+SA:?G1
R77?@#..>fAfY1[&gA2_T0NO1KQ,&3MPM>B/?6/g)bV#;;?\-AM4DCHCf?:L0IV1
c2DP)QW-<5ea>VbS<6Y/fHE8QE,)W5B3GW#T2XCePM=f:FSQd0_T]U35Q529U3-5
RBW)&>27HR-UO+9fg<1I8]_Eeg-3:cLO-[TX.WBP=X1e36TY6fTQ9M]<X:>)+-D>
:H0>C>^WVXSZ\YNC;d#WC2?/HX0ZD.J1;>?gLV_f2TD8.L[A1HQLE&BWJ,=;BJZ5
_8SN>=41Ne.IGG;@T70TL\+6@?FLJ4E,#0HJ/=fFZ0RZE-E?&T7+DIK()cc^\R)L
.;=cF](0dK&C6cW]U,e?/JF\1NYG1O.T4N,RQCPI,FgBVROZR-@E;3L[>fb5(#M9
IF].Ja(G8H;Q>7<I.8V]8\^]TG+VbPAR6=9F+N-8UYER^4XY-cQ27-NN3dPAW6GW
c<a[g-SFJ[K<_]C0(Wad#[cD8PX:ELT1)4e-\g(P)VHeW2+LdQA=^YgK_11U\;,1
P+P([&:L:JB8-KLEDZM3+6#6\^dMN.D;B<4M=+cI8)B4&?QYL=1)X/0O:L&7M(;O
;geQ;#I.VM^J.OJ8g4YWfFe.b_Nb8T?]2eD_=gF)P4N1&ZaV24J6e:1OGD9(7Ac\
2LA\8VUOec+\g-<F?H2+<g_><Ib]cK1&eAIXW\:[:XG^#EAbLOH7BD,:],dN[[_,
U_;D^5TO-eNIMbW?[#JNf<FO>3.X>AGb@7:4+\97/E?d;eDR=L/R+EJ-4<T3A7e<
,)(TS?SUUW0CZ-(OVN@>TS,&=@,XW@f+K&f1L19<g(5NFO4c[_f?9=MMP6=Y>?;V
JM3H8T)+TS,1X]g6g;K:?PeZYJ&SP;H7OgWABTc59WU=Pef>R0=@F]=_88<IJ0=?
-,(NN#M>eCe?Edg.bcP4dNS[C0YdgUG[HCPfaLGXg6DDF\Y]0P;N&0cBJ=b#b#5f
^U9+W:8^L1>[gQSMAWg7[CGSX@d,_LA:ZWd4X<]Q(fDWgNf0c6S+9Z>9egKBgbDX
HB>73R;4X2+:U-QT_#Ae^-R[,LOJ+gY\Sc#E(_^9_ASHV,2148WW+2TNY4:3^V/E
[b/,Q8/#CZ3E[5R^BQQDD\3)7JW6W=N=)A8U+P@d3/3R)a0PFa;@G_4D]?a,c#/c
IG+8f#9,KTD&DK,BH]5GE60X;-RR]e4I7ERA3=ScJ?0ET@cQ\(ET=S>4T<=Z]U3(
aS7?QU8N_:,#J3LZLCgZD#ccgD2F,5WS9R.)AP0>CUd,][;AW..5GX=I/dV@PES@
.1C<_EI\03+FYBJcEK1_FI^4HEE(OI2P=#1LHA,WYc+IY=dYT\DS/UI6E_:HK>A1
CI-&Lc/UAZQ5O]@-450ON2W7?-CNMa78#;^HJYALZU/Z14J?+79WB.8SW:-JEQ7L
/NSTd6OIgJ5YQEQ:3EI/H8OWP4fWXFT8C(JSXUMP--&C&LG]XS3))Wg;YQ?=\&#S
TE>_14QQD)/J\SVfD#V9PCD=]DbS2]RR2#3acY4&_Z]+X<VaNXD(Y]I68]R7)\4B
HRO7bE+H0#F?N2C>[\<gg7L9\eEVH_4M\M=F9&^b;=J5YEJ<_AIXV]2&g>?,TXBM
T2T-:P+7[Q;PWA-0NXFE[:]]W6PN29AE>RD(_WJ&M(WBJ+9C?88,D^AT4_T+d#gA
=U3A:0/F^:\UOWg@V940:?5D\U2<#QB/U5N1V\VW+V-<1Db]/K0@:>f&U<3aeM:0
e]b).<THA\Y?95PIWK_\9a#\b&SdRB9N];(e+#C2XG_&e_LU34MO>^>1@</Q8FJD
@?RZ96)dg/M9d,O2IU&EH6S]V=IA<W>YJ=CLJ][P<WU^X9TB=Yc/.45c^XMEK&8G
A892d2Z^-W__g;dN=I&_YXXH.dAd1WBTc:D@(O[e0>HUc&(<#T=>6+V.d(<@T_,V
;#NY6,2&1VR&6g<3-,gFG8Kc_3<]GD1AbND-QZY++F_egACC@6&>F1TR824EF]#[
EA0?3a)P4(4GWJD?H_4=M>DEPVb_]AfG3H[PFV+RH=gV5f>P_V<DK026@[g.7,T5
IaR18NPNLYf5)8G.]D+5_JMR&UR>AbaP3VS)V__;(<@W>Y:I=,G^3_bPg1/7&/;D
G+]KQ9>#):R6:\Ng75Q#ef/J8HR5d\JU8BXIcP9[dOA5eZYHG)BM1)CUf)IH8dI(
GN++#6LaD>?,2ZEUfFd<^85L\XVNM->;)dA?+2b-1B6SRdO@cKDS-5-_\XRd\AC?
G4(&Q/OaaY2TO4I])_2gF6K/^VPO40NcBG2(b?Q/LSJ@;/g#:SR9[TFc2_eHUPX&
]&]e4c+Y]gDJ65)c^.cB?OZC:IKND4<,Z7A\[R\;eZ\1aaPeR<8gG[ST>T>2g432
+0881@:KZ<IJ^1(^Q&T0NZ)=Ha+@[1c[@:c?2LObF8XE;1)KNI<>Db>KXS+N1_9P
O81QF.RZaU0:c@e)4SG61O+FZMIWEaG/cWQ65gX5:Z<UONCSE8;-)Y.I<,^3b+M3
>6Z7E_KVO57,E5=LEJ-d=)7KB:a&3#:#X9GVM,Y7>0fd=4=\c.XeA68FMDC/<YU(
[Y8Q/ELDTDA5(#RZ+U-3abA-]_K]Y6XO#YcQX01I8L,?,4#VV_cHMOg7d:Y^N[:]
&F97<>_6O8b&SEC0.&)HfRZ\H\2.-QZRIMBe=D,XE3Z78@,AQR]D&9P@#T]/Y1fb
8DaXM]g,AW3N5^64C3VFW[P4BRZ6J)R+AeHC\+B3=RXBIe,>EY114AU<:1R]X9:7
C2&caW&+.,5Geg==;@&)c<)>Wc+S6Q_-)OJgVHda-AOc\=-ZT,;&W4>V4V7?OJ=e
-/-?T1gd<O8IN^5f0U27BSJ1&c0NSAW_=+8QL2[RM;R0NI:)C+@.0_<IF\S>QT0H
9LY\J<S;IX7#aGg/P>S-WO18FI6;_<H099#0E(8)Y.Xd33T@3M])5ASd/RKa9JKS
^#NL@gK,K+&d/:RNG/5L=@#HWDIYg;_#?C6S8@:L;NV:DP5DNET#O=Q8=#X2.B#d
#5?<+BfVK_cJF^IYR-.a<2))1+d-W9]:WRA(Hc.I@V-LaPUaRU66O07@;;X<:S.7
K9g[+4^W-44bKeWX:M7W=QT-=P#NE@U,TPUTbNWMQ/_7#AIE35/#]._J4KUQ^c>Z
#]AP<:,?3;^1a(I,-6ELSKC3\E;:ON>KFN5M#+X&.PTa;Bd:+P-50RF22OVMT&eV
(F9c6E=F,:/>Cd<cLb)H>U54&e]DHT3&1Q?a,fMG(?a+8;4::a&3JGR1K[9W:AW7
)_4c\+C0S9YNYK\Dcd3>7:WcOZgVSDg2365U^A6[0WWK&(Zb@+DA)C;4PY6-?9UY
@H6281I3H,U])g-A,81fE?N6=V1GK>?](e\=9@0/.[\,[0e7;_HO#,T[X7H6TS>B
(+)TFd->7](IL>L5;5/,Q)Sg/KT<H^+982AbSN,Je:YXNcK?,:4:9+@(<4cdGQ#?
T]0&Mg[(4\W+IPg36E51=,U=7g:QDAZcN.-/^d=C#c5Yf&c6&eS@@&5QYH#BDKX(
]\Y_AL8&]1f1;=^T_XAK9HOK0eQ(ER/3b_C&AXNL>9NCaG^Va=IUM3C4+CXHf?17
Y_,I?[f]7+VMCH-faMU?SEG_O)PBE,X[a[SG>EYAO,07OHVf3OAIDg4YIT03beVH
Wc-2>+c>Fef/W:&)^39UfP<4.\6bAFWIJ;M1=eQ#c\2dC9-:&+e-AS9c1\4K8_9Z
ZCbVAaWC+98-?U3GAFG:IHcS^/@V0X0bJ7Y0a]c_\F=?Y#3FH^MZD3_UgN=#\5TR
AVBR+X&J(Jc,Y5Rf,fYF4LR_0:Sf5Z\QMLH9GE+Z<Vf7KAdO1g<.W>K-f:K7HZXO
<)E\9,]\I-66,#XENJ-C)4UZ(ec:AI[6<H]\gX/HG+KI4e&=I:KEHW,f\>0^(-De
()UZTA^-=Df[=)A3NN4&?.^30M;@3,OL>Q_ZNc4SLD.95TgJg:Gc2^2-GX0fH6OQ
>?-4;+C,:a?&#(5?P?KMPIC[=W^/Q69-ZS<2TDP0P?fAT,;,E:52V_cB7UTTHQN?
eANE-c?@^2+8(YQ^(5Y^d(.7NeLg)?HSa8RMOLgQN6&/Y21G:^,GW0^K@&SQVIKB
+e1;d]TD0A=UFI#7a@2,>E+@]b>[=aILB<D_=#-H5LGGAV+#ZWNTfXP7P-CP8XQO
I@/E-\@82fAM9JgAU#U.3>4UZ(-C::N<ee4(bEB82(b\bB?(3_H\\/;,F;GDd-UN
RJTeA8W=G[/O&GBB8)-\#P27Y?-[.;^7g6,C^aG639>g,9R>-J+0eJ.E8<XBHVKC
,J4HCG[O>1G<DHSeeZB.097]gTBfI?SIULZZI[A+Rd9U2-R5Z_)1d5a.T=7F=VCL
>e9TM+R4I&[T+PbJAb)=O+M8U6[Q.Y0S;R-S=Z]KI@-aQP(.O=40]a,K+V;]RWPX
8+W4&aXXK8AE+LKW17/JHL-T/G63daTP:gS<<.^KH6B1?6&U>T22-5=D:\H4?;cX
:/aQFBNaGaUTc<_cVL4&^#2.SYNHQ3[UEI/U:ZFNd(GK_F:152L68X1_P;FN_\e^
B)cb\]>Z@D.^[Q6d>RTJaU7M_C:UX@6aZW8\<F5U\DCe6FTCJ?I&UI##IL3)(R9F
d=AG&IPC5HLf1#_4M<[M=X0S3+6bdCCUWG)7?X.6R0_TOP,3)-2R6[SUG@UX_3X@
TSO.5-d(]\,-NZU.2<6O0TNCN+g?2)&+RHTC(-,6^I.>E1-+:>B1D1MZTg@&R^Q@
C39\9H5S_Zg+C8>a]OYJRgcUA92F;U_I8PdILXOL+GH]??79:_-ed=/A?d,Z&=;G
WM2GA@5DCFF,c^ePAS-C(TNR^:_BJ2_ePC+X#?[g6[^7gSD2[DgcYdRI_7GZ=4.6
PV259<(Y-XU?\[],&FF[@[\9Va;LTDc(Dd+V#\R\c7U<OZ6.;P8FW^MAeBLFFZ;6
.)E2O+J(D,=5?b\g]+M&NC9e9.C5BC(M5UbY7I80BHaaJL_<S5eI@IO.U]\cC(c2
ZZ/]a@SLN6-C.ZL^M-A+R>B.KBZ-4e=aOL[11a=_+#M.dOE<Y4:f)c.]#-_JX,1W
ZIbV.b8U4D]2f+Qe1Sc6W],C-?_gX8P(?gAD[c(2d^Vg5@\DMeW85S:.:1/T;6BD
+MNcbZ_KYA\Kd>e?YZTb\e^+100MF<B.2:)448[O+35:(/G=,VS1T1C]W:ORR:QH
Y&;UD7^?a.><a)=7IgM1a.N@]fZR=6\g8N+(/H@@DR?N27>TC]W9(M6FV81D(++N
#G^H:8Ief)Q&b9WTbF@&YcW?#BCHX<JIXUCNcCg(8BgV&SM3SWP-\?4CXc\D(eHH
Re<5g?/c;DC;aRORb+;P;-<f1aR]E,;KHS?@[\FJOfB/SI8(+(/MeGY9V3I66b0?
@b/Pab,(\:H(I]Q?7G6c0c4@_V_BGM7GIZL6T6@0FVH.AbK@,ONR-EBYNa;_OgWY
g]S9/H\(J<PF:d;3Xb@6fL)eY/XV2NXP.15KA[QJQOa\RB&\D+eUAc_(-ZK-TGBQ
.59JC[?-VVSR]d-S4\E2K8D@_bC;BT3a?0AaU-BQ##Q(K,I>/O23CT&.<2bH0>7B
GdE2MO6&\e0TWO8_P4dV+H^4gg9ES7f=bD+.:P29(@92/M+,=E8;NHVVXO5,9:;+
\DSdCCaF0L1H=CO3NfL^dOE7D2#<:d533YIf:;H#A1Me/.OcIba:M.1ZFc35BZ:R
#5TD=]5Sg7#70R6700f+bM]PZUW11&B/g9@7,YGdg>a\LB)_&F+=W333Y5MP@g+?
-NgR:28\/G(JBHV\MM+^g&@6&CP<YCc3/WKB0&R;)A_aW3IY1:H\L7B,R^5a(G88
dWQLI3(K=C.IURD?_4YIQXfGP@,G-[D?)f6DMFNJ-3bUU-]]E\+)(^YJFB.0F3TE
U1+=MI@E:4f+GN@geb.?)][CYVXV5_NXCX==7K91GK0-V=QA61_f_,4F/1O)Zd7Q
dg8TPP(9/?J\:)QK@cEW_K]NT7QDXRIVe0Z41B(Ve@4V4EH1O02C?R=#U8f+[DK3
DHH_?([>6?2(baR&DM4CM?@g^H.c:d.NVZ\5e#7Mg:=J2Y7,/O.W.E?G8#F#(3[;
;3.0L:_&Tg??#fPJGIe1NebKXL-Ig<Ogc;/E7/1AACSK.f?KeFI7]+6c1F;9L[4F
@(CLPb)6fL?D?X@#]>N?(.1+88D24>-c+XN\\<Vg8/JKP59]T]9X@.9C>96a8G2d
\5NH-3A:5bbD8gC66e3dPgYP,)GTdf+X3g]dI/-V87@8>UB\1TS2TMM(e_F6F-+8
A-O&6T(P50G@E[^Y3cVDP@L2bK2D2A@QR.f8AZ=N2.3V?47]IM9VKSdF]f)aO<)5
+_:Y<.JAL.3X/&V3A?I&YaEB)R+Bc8W_PE>?-<=Z;EBI-fVMDIE-e;4:\B3HLSbJ
HfV(M92,Uc5(eg3PgSW8W;J[g9S1+LVSG7XGOJC?.S-fXL;^=:V&?0IbZC06c@7C
,>bS<56QVT6SgE4NL=f(:@F?KLbRD9VaLV-1aCIF#Id;GA3VSP:aH_g<dI]S+#M3
Y_gQe1[440PZ7L5XH7R:JD?)A4#P>/.F=KaGYY\)c-S9I/=O?0?35X.RQ#I_0:Xb
MB6<<,:GP;.+<][)bVAP,?1_(.3<W5^\QgWLIN7,;)HWgTQ;Z2EAQZ2:K_WRGQ9X
MLG7a])WfDUC+f(N-R3SUVUXRF1@@F(#W@Nf1KR8d?2-:Y41O;AFJX_YJW[5#dV/
0R//99M:Z/I&cI=R53,87I]Rg<VV\d#-RT]e9^=]OYUfaES-U=#.\G?FQU.S]aE4
B9A[bc;)Jc[THg7Bc(HNKgd+I70V(CKD?WU4V=[^P@3;_\ggK(.<;>#d+#760T5/
5^8YTPb.\L<=&(/8J573f4U7+_6G[K@W4bY>,Nf#.XS0V</,<EaX2Q;:I>4UK;.)
fd8]cJ&ZfK<?HX[]UJ=)U#(-GJUXg3P\f\;2(\CRDR+RMY&XM<N1QI(O6AG1:YJ/
6:,3<1c]I/#9O=B0AYZ@^^XS1:8[b)c9TQ_W[I.;OVSWKW^HL6)I)e\8T:7GP7\]
<EY2KO)fY/=U?6)aP@)a71,\?#dBKQ4GC.FRS8R9=4Ig3X7.]F?XG3]9G)LMY&^=
3UQ1[dS?R8fUZYVC&/QIEIV[7.);J-P<#Da9K/R/ECPNJGA=BRG.&+0UUCZ:U\D?
ZV6<D(U>+D.IC]V^dD_#GO\]bJ#a4S]W)-/5).cA+AJMc:f(+\H+)Pb>(aRL^4IC
D@31:((.5<R=VPHA.7^>+@36GDM;ZS0-c@eK^Sd=F-8ON+ZCB[G.V#X5(-&?H&K?
ZQJc&fKB6NQVJM)>a+\fPM<H-#+e_]048&)GgL2eE.d<9(/;0.]Sf.3g[GQeQ\.P
9>_ZKM>c969K707f0>a^HBF_YBcD>W3B_G:WZ:.\-S-(ERO:V#3X?I-D-([1E[[d
10eO?\AS_Z,9)^(;VHP[AZYfbe0D:HJAI/K5Qf&\KeM,R9?,B@b)L+#,+U0]1+6E
)B-S(DM(EQD9-NEU28b6O7V2.Y46?EL>=GNTDg@:2,R>@M\^D^_.a^WBUFIPf,IP
;2;d_ELB9J/a=M^XVO#G]>dG,deGfRc1>ebZ8PAI9A_A:bJH7A0:UA/G>DFP6K>V
;Fa=W+,W7b>X<92LPR32///&e\EE@NAIO2H/03-PA5@2R@120bP91Y2T9>:D0/RO
cB7,EF&OO;.\P:Q3TfW#K.?+&cgN\@&BJ_Mf<9T>1gZ\TedWX2-1QS[16K5K?(>V
W(d[P<9?P\W^,+3c^a3<(TXbS.3OgWPLXd]f1JBdL;aG=LZNT[:aCE38A+TEB&Kd
b0P)38RT#0>1AMN35MLd[P[]-d0ENR6Z(GHBV1DaQ@MdaAXe\2)G/0HQ,-F+Z&Ze
O7bP^<F;XDW7?@bU+gdLME)f(L&b_a47=6BJ\O]MD,VT8DIZcI],^A-JQ&P=-F0J
Ig9e51IQB?>NSFHdNJWH<L?0G3/+V;4Oe9dFU+G>gfdO8+>V=AU<?3@WYYM+^=5@
-[g=A-78IYY4:cX(dA]@G0:a]Nd;CSa<5f19\c@]V/HJB;;JQ(EfII-Q#L0[b7WR
]5RK6YMI3,0)Q^MZMD8+C94)OOY4VeKXP2JR5L@F?F8W/SeY5.._6=OdR1_:)Z=Q
5;/U8.EKa)Z3cPT#+>f/P9UO^f=_V&/L>;1Da#C00R1\]?c><)3Oa,S1[Zf/8HIO
HWKB1:d.f2YTG]Y_e1)(H=]e.P5&5]NY_U4H_1&))_/cB,\:K^;@HT/)T-(./4VZ
_^<LJ5AUZ5S.WS7MB9eb.<7c@aT+4<54U-Z9Q&5/W&0.;0K+2\g\If>EQ,P3[0-N
B-SX4FM(4AF#:g[4X)&0GQ5B5[Y)B8K-Y<gV(Tfgd]>?QNB8MgU3J-OYFWRc.P@L
NA&]e#0_#/_#-$
`endprotected


`endif // GUARD_SVT_EXCEPTION_SV
