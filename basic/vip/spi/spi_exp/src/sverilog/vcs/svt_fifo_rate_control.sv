//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_FIFO_RATE_CONTROL
`define GUARD_SVT_FIFO_RATE_CONTROL
/**
  * Utility class which may be used by agents to model a FIFO based
  * resource class to control the rate at which transactions are sent
  * from a component
  */
class svt_fifo_rate_control extends `SVT_DATA_TYPE;
  
   // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_ADD_TO_ACTIVE = `SVT_FIFO_ADD_TO_ACTIVE,
    FIFO_REMOVE_FROM_ACTIVE = `SVT_FIFO_REMOVE_FROM_ACTIVE
  } fifo_mode_enum;


  // ****************************************************************************
  // Local Data
  // ****************************************************************************
   /** Semaphore used to access the FIFO */
   protected semaphore fifo_sema;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object -- only used in the call to the super constructor. */
  local static vmm_log shared_log = new ( "svt_fifo_rate_control", "class" );
`else
  /**
   * SVT message macros route messages through this reference. This overrides the shared
   * svt_sequence_item_base reporter.
   */
  protected `SVT_XVM(report_object) reporter;
`endif


  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** FIFO rate control configuration corresponding to this class */
  svt_fifo_rate_control_configuration fifo_cfg;

  /** The current fill level of the FIFO */
  int fifo_curr_fill_level = 0;

  /** The total expected fill level */
  int total_expected_fill_level = 0;


  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control)
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
  extern function new(string name = "svt_fifo_rate_control", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control)
  `svt_field_object(fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY) 
  `svt_data_member_end(svt_fifo_rate_control)
`endif

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
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

 `else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif
 //----------------------------------------------------------------------------

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
   * Decrements FIFO levels by num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param num_bytes Number of bytes to be decremented from the current FIFO level.
   */
  extern virtual task update_fifo_levels_on_data_xmit(`SVT_TRANSACTION_TYPE xact, int num_bytes);

  // ---------------------------------------------------------------------------
  /**
   * Updates FIFO levels every clock. Must be implemented in an extended class
   */
  extern function void update_fifo_levels_every_clock();

  // ---------------------------------------------------------------------------
  /**
   * Updates #total_expected_fill_level based on num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param mode Indicates the mode in which this task is called. If the value passed
   *             is 'add_to_active', num_bytes are added to the #total_expected_fill_level.
   *             If the value passed is 'remove_from_active', num_bytes are decremented from
   *             #total_expected_fill_level.
   * @param num_bytes Number of bytes to be incremented or decremented from the #total_expected_fill_level. 
   */
  extern virtual task update_total_expected_fill_levels(`SVT_TRANSACTION_TYPE xact, fifo_mode_enum mode = svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, int num_bytes);

  // ---------------------------------------------------------------------------
  extern virtual function bit check_fifo_fill_level(`SVT_TRANSACTION_TYPE xact, 
                                                    int num_bytes
                                                    );

  // ---------------------------------------------------------------------------
  /**
   * Waits for the FIFO to be full after taking num_bytes into account
   * @param num_bytes The number of bytes to be added to the current fifo level 
            before checking whether FIFO is full or not.
   */
  extern virtual task wait_for_fifo_full(int num_bytes);

  // ---------------------------------------------------------------------------
  /** Resets the current fill level */
  extern function void reset_curr_fill_level();

  // ---------------------------------------------------------------------------
  /** Resets the semaphore */
  extern function void reset_sema();

  // ---------------------------------------------------------------------------
  /** Resets current and expected fill level and semaphore*/
  extern function void reset_all();

  // ---------------------------------------------------------------------------
endclass
// =============================================================================

`protected
(=FfKT@ade],YT^#b:bR]NcIgS]WPK2B[IbO3I5<AdPggY-J.eMI7)MO0-_I&WED
6<Y0eFUX^(c)e<[=J?=V)GB.I)C>N:gH.MIW0[ZC=Y8Q\?]G).PcSM@FRGY_]M3&
Vc<HG/:,T]31_@^JBHP87V6^,\VJ]?N:B4fY/+N[bU(Z^R==MUCf1Z?<e\XBIE2c
a=V0_B=gXES:_f#8(d&2)cd/1636,>^4&QI5R,a@WS?eA8NMD@S+4WNS7<5/B([\
+[fV&JW&5NYBMA?9A+<([bT_7F-6+_c#+(8Bb_&?K_XJN>B7,O^^gc4(?\X-#YP8
9NJE]FGZ63U-HFLgaB].D30f<LUKR]L4cI8PUB:Ea@7S&\[aRRdE82XXf^U),3AB
WIJU.0WHB]R4&_ZHa9?bKWL^XW0XQSQMYO^U3fOdUUVf/-(S?8:7QJNN:#M>=CT3
ZO(ZH:<TS0?d_C<abg.2c_7KN>&d)?<cC:IT)aZ5C#f;Bb]<4HZJ]R)aY5LTJ_BH
XbB4<:E0IWgZX\&\>?R5cZ^<-K:d4#FeP902WZY+EV3Vc.]W_VFPeL][/65M4eDJ
JJ\fSHG,f;g^5dc6-9;SC@[@#:J-IH<;^VJVG_25QRN0;K8I&(;=Z&TF2XHEB@YN
($
`endprotected


 //svt_vcs_lic_vip_protect
`protected
L_@_DU<V[b5=cfTIc;OQDY#gP,)_(^6DQE9:Mf(WEB4;/\JDKENb7(I?3d]f3NM^
SAd9YTVa4E,EXSH2Z<WNcZ-)UN]G^CHFVGgHR\aOY5J-]13R,4^K#ANg5g\Qe#eb
TPW2FCM:[5cVX1[<6F-<1:AIQJ1D5dE8\?4Z+PH?1,>>e5e?]W-:X(XaP<Y^W5Tf
(TZaJWNd=be>N\:[<97&Cegc2K.cOWUaa>];TPI7_4b8IX]F0-0)[3<@2M31NIe9
f;bJ/a\4ga=.5J^_+A<^>9L1:Z>Q^MST))?-_K2;KI0X1ZEX02A;1cc6K7DPg)]H
E+LN-VF_G/.83PV[0(eQ3/UBLAITPHH];e5]P30UG+S6_&O=c+/;7HRJ@\4W3OE>
(U;;0X.g<7:T?5?\\.\c=O:3H^WAce&U>X;cRBfF>Q5C6CUQHe>V4+;ZWD+]R@]8
=]5^PDdP<L/W_U&-[f@]d\^Dc8gY])@NCCa><]:4#HCK29HSKIe,63GfEGA6OREd
?efOTPNCFcYP)9/;C?KN:BGU,38_IV7OL)Fd,MO1\P^);Z>.NgYRNWSI/KI2Z];4
-+PE2,aAUNYTF8+g)Dd7L6a+cXHYc@O0cG+C&Z\g113&Q>MfM,W_I+H,6H-G]-[6
::91Uf])&27G6NG^IP:V.W>N-,Q[OX(6K@&BF9&VFI(]K,e/edeUBYMOeQ(F^8S\
>Mb]MQfCXENT#CT,H]F+Oc7)FUFQec^EIZJ;X:2LA(R<C#g8Q,W.Ra0:29L00Y=c
0-F9)IbH&b9f\:EEDVD8ZDD^a1BBRIA<LJD\CW-D<3>@=L:/#+VV8\[N=2\\f,BO
2RZ0WP^4MEJL>2T9.U&)RaEPGF\V[>)ND?=/=:BQN)EZG9,9V)[./I^[1(#R.ORS
9K<G#S&/SE+4+34)(DS3]A6dP=0R@g(OFYPcW\Dfb9D\14Y65.5_TKLDVG7Je1<]
Aef@O38Vd1b0EfI#WXT^C?D@-^+gFF:2ZUTDNEFJ92E2.\4#ZHH0XQ/E:B\4f)T-
TDg[B(T:E?bKC>8SNA@GaL/2,G4+Adb?[YN.S@D),K+Z+9<N,Va2;X5eeUA1CO^A
-aYOW0(H+.&fZYM5:I/MBgYWRb3R+D;Z_O&(=KASPf53S0M\OFGKW60TPBI.B;SE
e4LGYL()e&@2;WR8^<.OEM]+_SS:&<Ee.P4C.B(L1(KS7JM/gd\OdZ,4>;Q.\+PI
_aESJ?e5?C&-Y-#ZBJN#4BT:4g]dH(]41T:L\LIHX:N[49,QM+9I+RQZ(B3eYB<S
0Ab^b#Z#F7^;4Wg6FV3cAe,A>^OJOTSA:\Of4032?cf:/3\^@Y8M-.J-0LUf@^bD
-1EN#PF+ZP[\)X;g;aZM.V)&E=M7MD^<:b@\g+gc-#BT([C=K=EPSFa8X9<<9H>Z
+E^MI,^?/K5D6b<7[55?<>\Y<&(7;.>KDWSIBe#U;[>Z/Cd4[6OF8?#Sg9TMO&I,
Ib5A8E,&5>M/0O(W.XW^#dAQ6bFe#4bOb956;WcH,V=+4#d09&89P\aMND2H-X^&
:b123:6EDRCF(CKD+CZVZ;7;/B5,BK7G>>1>Z77AF.99a3<:LLQ)]0F;;@3+<PZ-
NZ]#LL>;AJ8\).<OX=b&E#+AeZ^a\HRH]98SX^,UV?I.S-#W]L_:HF+[A\)aAK81
Kb]O&f9gb5^R^@D#YSeMO^..P;C9H9P;,VIDR[d@@e=Zc6]a9D_DMV[F-FO@W32(
(=@IO#E&P,JDH=D(RR(T^ND4dRF.B@Gd4S2-8bb.AcB784N=\@3.;R06F8+S;26-
)TD8IJB-Y\UaA?A>O#/cbM_aD+d?-:BL?B4^FBTfC)IV9X5568GDJI^:^@HV/@Z5
HPa2fM1F6GXMHIae:U)1dR_>DYJ-4Z<:A8@:?]ecSI]7L7eA>J&+HTTF)8c#_??U
\ZP?g;KTN]LaK;>N5.eRK5SMA/GgA=\>QCU&Oa\I1P;6#8()S0(6GEfGKD.2/LFD
(=I1Z<Ld15RKU<\<&]5a9+=72W,2?,#M.WJ[]Gf.SEU2Q<98&RW\gAg,[FYf\7NQ
6/991E?(/SYRMKC\=V[]I3<?)c[OC]K#JF>[a&TB7IX8EUc^#[PD>bUWT)Q/P)H_
^I,[(Ve.=QG^9CD;[TdPLUJ3K(]BW\_PJd<)JHBca&A8\V:fR+P;-B;L.aPUD[8.
F^EG&6>MC@I3S/S1+HKYP^/771]YQG,<\D4d/EJM<5fb;8d?F=](5<dAg@bXdYdd
9Q,:e7R+;,,:I[V<LPS0;b./aD[U4#5d^Y[=J):>_C>eaa:NFO<JG3TD\UF54E&R
6MFW5&bQd\M&c.I;Y+=]&MYN;3/+XV+bCWTB?N0UJM74?Sc>-8ZPS=ec<0b2D&,W
(S5(;FS<U:+>)ZFHOD^JZ,/D3>NYd,I.D?0R-:H-<;-[)J^OP7_g;&LEI1eaU(,<
N/=9WYL3^KIHLD7:WEB3V[X&b,&T)c[RG._P7g[9;,C,W5G/Z+]gGY,@_V]^K5-6
.,e/MI#N5W\-+(d3?=ZH9,,@]&c[^L:_8;[X@R<.Hb.gc:@<##RF[[#&;R>S_U1=
;:Ue;819T]e&-LUHAb;<RV?A9)1K@K5Qb4KfEOTM[XaL+Oe?;f=T\Qb(9VL8Nf9D
&+a9<GgV6a6Zdf5GH9&;?=LB\Z9=gNWHK1>F\-&F+Q9JZ[9gVAQEd]\+]=P,ZIKX
c)0?;#7S(&6H3X4KbX-,?7]\5)26N7ZF87/O,5_,&LHO].-^C?:ODTO[J7a_e:JA
@<HP9@_])G&81^ZK>Dd7<A_B[IT?5_/-.A5+T:>I.3CTO:/O#8d78VKLVA1.CK8#
B?F9/0?^#R7Q8H&&7f2WDXP(CBT?2cc\(a@e(PL][[1W[GK(A;gRDU12I7>JdW;U
0a(TX0RRNcYYHMFRFVbY3=W[:+#_JUSQ[8EbFSONK/0>C:5ZPK>dg0K_b+J7A4F4
NfH0WKbC/]+]eLT6c;W5+edg;(Q7E^U[CU#IG.DR4d]WWTUT=Wc@9CN:D>3T,Y>+
Y4KDBGZJ0d&Z]J5=P1ObG6[cB<=(?;)OVERVA0CMA_6Ib;+HDDe@@[E2.K@NZ__3
fb<2]D2M6?+(B#DV9dbZ,@]g^bJ\RFTKg4b2_\f_4e7]1+MIcC2EHeHQBB&bRU:A
,OG8;N1(R]<+Q\G4XUHPa]7C+,RG8-;eH?Q<>Se79B-5^CbQ[/VB,#,NNLf8B<6Q
/T=QL-OgB>W]dgR&4_=,@M.>6]H\Z6KC))0QgdAL5?.Z>IG7EcELTXCSSLcIGE2f
PQWR.EO6Q7J_6g)@BRFZ80/bZgeGEIb/H2=bcFLF?_T)ON3Yg?DG8/>4CZ@AJ3U\
C16PUA5=\>J2G7cQ:YEb[ccF),4bF,,RfA3,7XZ+NB_U.KP2RLdLVL63H(KL#cJH
K.P&VF(KgF])2KI8GeJRZg#:I.PH/BgQG?)VE?K/W^a+]<@MVYWD8ONfFNa_3XaF
N=g:^JG5K+^=W[ORTB[U4Ge7/42-2;&)50N+aa=9XMddSGNNAZP^CWFS-N]6DD6.
<fW2[2^CUO<(G:.O&/C05P/Y?WS)5H?1Y83bD?SM:9GT?c_;SIB6gdC97VF8U^0V
cMRfVX/=#D0d.3+M9E()??E8>83IRCRS\^0,)Te2??\7@#)+R#\QXJT<@//@)J/O
6@MFA8d6c/GD3PZ+(C.=W=8Z4g3F.WDW=R3C0RB&g^X[fE;KMU-?eB47J;+9a:b7
Y:OZ2./L3XO/PfIO?<RBRUa0,12.F+^G=cDKeJfAY74cYQDF?H3#P/)G5<4T:92<
L9U2/;EWd9V-+1](a0c?@.4.N\_?]G61\.T-)5[,O,4_4UD8@JfUIbd2cOGKCE->
^Qg8W0faNUBP62?OOa6MUfC2@AZ85)E\0@;ga6WW)@APBG[#S;_+[L:0GQ^g@R8Q
Jdd^0LM4H0QV43-TGTV3P-H1,[eG?GN8/XR6^2>ZDfe^9DV8@^IG6g#^eZ/WF-Q_
FJ-YKH4@YfU]S6N,(YN8(g9(V\BZ_58bYP8R,0>7d<4g_cL(gM.b=F=&E,-La/]H
eH?7UW0+MHWIT^\B,P/ZJ[6#B&G9R]FdUD)4+N)Af5#V\Y1<CUQDKJFc&e-)B(=Y
b-\#N(Xbge2IdJ;86)]PBDH]e.S]Ead6/.Tg5HO1H_Y+b<HQ7BL]&70/._-G\a)B
DbbKX>\)RO:0;,5)VXWW=Jb_/(<?Zf4gXZD<^N@#]Ta?F-EK5(1AR>JdSWCDZ<V]
)V]JOeG]4ODI+<M-4&(;MF[JZ,88:;B8H?].OAKNII)8\b,b:Ea-=Q/VAJ0Rb]f2
fO11<2KLODAc2b5.&e.21Fc+?bRR2NBJ?P[Z7>dUDW[GX>3<)MMa0W--f.d--VS;
RNO:>GeX:\](>M862;P<gHQ^MGIFV\CF8W2L4#<T_2LD6d.cKP(#ZJ;^1S)=:H=b
(DB2.Ta3.\C9Q_Z+#_196\Q.H@6NA@;:LS+bEXB\V>KY>W.PQ=KUa6MIECQ-Za?L
:/<^&MT^\f4_FK[f\e2^9BT)]1b^]MS,)CJGQHVWDS_QMWJVFR@4?&EfT,R&g[<G
RH9+^&dZ\-/d(SDa-23-aASaMdU#;W7B]b8(A>c>[I.)EVE[+,5b#PRG;S@UI>K+
cW?OR^134@Uf39bK(V&]J;K#M.KJ8g@YL,UAVdV;70Fb@\dY04Rd,^@(/;-d>K3?
M5ZQ\=(RaTZ:d5D>/+?5-ETd-23[]XD)D1@;>=4?[d-X-6f&4R@?e@SQ]0T=XY5C
d_,&Y.K6(:&Jg71B/UKA-&-/C^X_J7b)((2UEHF.)QR[Hd9ENN<4SgC#(#\Ydc7\
+.+cUL3_^GR\;aX-e0HE5gVI^ND/6>S9XeK-/T?[c7=S6PWR:eb)LC];=^F[\&#G
]T@K:6@@d;W06-a_.#NH]a]1K<T\)YWVag-cdC:@;M\AB\Rc1g/BT^.O79bcYJd,
@G;27AYW?J3BH]OI=fMVf0X&2E&^OE)6\SY)UHJ@dWBX:>Q#cW6a_-1ML:I:1]g_
g,c5e^;=Ie&;AHA#BH>NK)Cfc_#@Ye_BNN@6P-<NLD@NL1Lb:a/Q-BHKO7>8d.E>
be+G40NIXF\1>]DQg;@0CN/Ha)=3G0B@Y)#_.gb^:,Z,gB&]NIa;.1Ga7XW^-&[C
RZ3,8.FLKZ6QAXP.1@2P&Eg\gM&5Re_VFE_KK\ZY0(M5aFVZI9PI+(=]C=VB?P5-
5W@#\ENLfWHHE?<W0M/@<[U61Tdb>G]QFLJ#>&?F.4M_DF6N;Z_[]QV:YDUI0M?7
L=5C-6UM&2GX=(\>T;9ff)_XJH)H+PedGSfJ6LC,L)bB[.>W#CW,G2R(@W+:dZ0.
K4V<?]]e42egC?I8Zb#X_(80YYE#:M,8\((LQDSFEX7fTYWa#I1DP7@.LJ(B8#XG
A1C.T1W(5_d)#_57K&Ka9-D5I\]KON)T2Q/6BSH17U#;62f=0a^,G1W)=)_#6Q0?
Q1^8L\IVB0HSJg_8NVB0E(E+)FSfW9E+GJH77W32MbAJVTT).bcKc#45,f:<)M1Q
,OPC=WU8>FX+7/b><F<0WcPZ#_;XO[X+^GDOe1AWO_2<W::25f>Q/aI,(GWa>9eU
=fUe0Y@(a4I8ac0cEV+UOSb,]_UeNGGCG25#bg93^g?M4IT7EPag<;VJ^HVSFL8-
KENDW,G58HK9XR7][&,_Q1XW<48Y]IFJ550XV9YUR)VYXV2Z&\>3SOJ<N6a7M?cd
-QOgL[O=I;7@gME5F3LIC]=MMHSa4)(Fc=PL6ADJAeY</_1P5a:OP;85ca[#OZDF
)AcR:)eB-b6@Jg)H27gKI.g;aE0LGVZJ;>Q@S,KTf7UXRcUJ^+21eO5eV&B7R,BI
0U>?50&CP?>M6N8\8L<C(geZaT8DK/,Y)_=M.V?I?)FOVT]?R\S.g:2c#>Ya0](6
7-_g]dNeT191T.E6B79f<)]ZP@;J.WOBb:V:dX:eC#X^a5@KP)H@daaH4f=G.E/?
3gD9Q_-Y/PH;&+E=5EO((1/L-Fe^:+8Z5a=^?If.L@g8K056GOB;K).?6.KYE2Jg
16OTZ9(KcKeY.=QIfDg.X75:E<X2WT79I59>9(7=95:M+2O_bLTLeM5>B=9A^ZDU
<+[]7Rb-<gK3L&-.CRgAW+O=F[Td]?g.31]gSR\[4HH;QbgM77&:KK_^(J=W^W@e
)e\U]-##R#ZA\<de+L,WN6JND7X1ZW\&b)YZ?1^]b9Q7C6IJOIAdM]/9f,)&EPIY
0/LKTJP>A^<;SAP/KJ@L7N[GA1;UELXP:))03cMH)9FDK0KN>TCUd8/g?XS&g&3b
#]X>0@0AO#4Ob0^#]Re6Y]b(I;8XE&bO2VX.XYLTDTC./V+g\D.)OOONP?Z.aR[0
8S-U?QM(O/P3=&#Z&,J,7gBV3+Qc4=;Xf@YUR76YLV,@gTI4MdT]IA7=:8;.7gJC
7^0GWd2<E.?#T<3LOG?eJ4\8YP0XJ\HXP44U2E_OLbU42#dT=)19e_(#QfPNOU=a
Ze2&Y+FK8VSM^UMHbJgbXeU3I4YV/.:&e;\4=(U&-Z5W/5b]ORNN9H1K3a^7g;=@
X@7;Y@5PO:.g6)97>YGWOS:]<P2#7<eV-A@B)\eXH_L/<)?^/H3RA0<^N;a7OI5<
@4@3SZ^D+>/8,-0FgY72Y<-8,DLMK)>bU@2Q:;.D<aR(YK[HW9UXeX7080#gKgZO
_.5dDHY<+,OZ5(RRA8>218C3gE->_(GNP>/8C64U8TI[V\VS._W&>FP<?YQA(]bG
<,#+W=8.G&JESc8P#\UfJQS=)9\,FcG(gg-SdC)eT7d_UJO(ADM>#+7\N1gSWK.7
8b.[ef6,+-SYMA1]+VLbgH&1L+Cc56@UQUgLH-?,fU)1OA+120WNY:0/W=F_e,+^
0KZLa?b)N0,OC2&R?5beZ>V8(@<a8K;2R;b>6a9\-_Oc)RIK.)D(E6KL5(g[G;69
bISLAO7J.cI(Dc&8g1,Ag+4B.N(_aQ&0#F;(=fWBDIP&IG]Q2PHO947J:3LEOKL\
P]EI&UP._G_ZIe\JQM<)SCU8.32<TUeO^[W:9[PF/(DE9D92@f,5I4.c7VYP7:TW
X8,-KHH8#aadD2AJ@NG+U-B73:SA:#@4G>GYQ()M7MRA[cO(G&cW1]EHReb2Ce<P
V^/E3DfLAF:2^.MQW&V1Hf&QTd@P,>JZBMFIdg2).SO[GMX(.O4P0(Q/>a6I_E/N
f^3@G9R,.fAbY^Y.\/GSU).?:(cCD\;Qca=+eCQ;g9WW_7gBcV[OdSdb;<(C9@1L
HW&>(CS0VJdCDa0@;KB(1cN1XCd9#@c=N?S;14P?EB#=R->6^/ZcDI.g1,DIAEWF
g##95\S6Hc;&AZ>^9ZFC?S@MD:I-Bc.^C>M>TR5YHJK?gL)GW\\f&>K]O@2P#8GH
-N4]MX0GO(S6SJDM4OI-&ZTU(AA^P@)5^,V=5<C11e9/EHONKE_?V^9_e:6.Za3<
cF+8Kd8FQ=)6TZdY]7X#@6#-PO-+BBAfeLaH>JQKNISSI:D:_+HfRT&eAfacJ;M)
AF6PBfB?F&\C^fgfMU0Z3F](\1:>gT/&HM;eCb,]2U-HG6d-g9_c/Xe&:XaZ=H.^
/=RX=+AT+K<WJ?]=?27aT>9=[.Y;<e?9OVe)E]4bR_(0(G0<5381>PZ;gPX/NP@>
AYc=99N^QW?ba1<-@]dL,L&)JW.1K,.#(\U.PebBL4\-A9L^E):;-XYRT\SI9?NQ
RTR[O+)_9>[7Q\dbG:NUALbHPGP];H(MCN,I3B56JOI5CE?W<,_MQ3FLJI?f/L]H
&(CSGf-3_;14g.#d@KMKe#V9).U?e+&YOKCb,B_Y6Z6LFJcWH3^Dc-=75SSX/eC0
gRS8gY^XECS9VZ=K\[SF293.=18Q16H1?#,BZZU2d0>Q[LD2W@4@.A=LC/:8<&R1
=c2F0N]-SRW.e)S3?FAN/(Ef:<44)TOWU5VD)QT\^._9?NI9\7_0>d=P(gP;1[_W
?H.[;,O;_)R#]2(H>5>N\KF<]TS^8_/GY>01NGHZP6EV3M8B-cL\T#,T7SU]eg&g
3CK=b^#d?=?f>A]Ja(#:,ZG.)OM]SEc8ER4_U+4_a@<R,&e?.77G^TaaD#==NbZ\
#=V4G_,e;HF=R83&5g==(Tc:-SH)_3:+^fH/:R;f2a],).5BH6:1e];^egMPWFND
UYLPUBYMX\HW&O+RD8gdMdGR\>NM7-=R3).Z0PAcWU(8=JLWMGNP)F]]F:VBS1OR
CZ0KC:e;U0OC)^24e..2<PXCU3;C4\KY,#RKOQ,(DOS=[HK]5-,-?^#)fP<R+2(2
8WKDY>Y1<H8+H\2X=[H(59CWbXd7eLDa#NE3_[W>9g5VP/2-V?7^Q+FT:><@::[U
,X2.?1/4YSM[2H5cc^;ag8#(Jb-S:^0dJUK=EO@YJb_QWcAd;-Kg,0S:f2[3LddM
[]/:>1EK,^1S-;cT&#_K8CWI\C?EPBJ;#Xc0g+@<DL\Ib()UaaEEQLc#?5AeA<8]
&dMMO1X?9(B<9SRUE=&d&3)7-?(60.E#b0\VFMOBQ.^(KgAfHg^/TCb2->@<Z7>9
bJSf]P_L=]JaF]:EW-P>-SZ+U615G)B(g]967#2.+_G#ZS[)L<4(A?b>bB9U?(eT
15FcWJUX9K^Q.b#e59._Z(Kg4C,AIWAB4TKLK=IX+@0(O:O+>EON20XDb#Xg2;L)
[?V#X6D:JPAeQXCOde5LCZQ-0P6^(fdKQ=d2DW^6<T(T8X,,:>VH&_Re<?D^AQb.
DM>0&I6\LIIM54[=+3e#HZIA)f\\P6HAQ,>^;=R;L;UV^)D/-2Eabcb:EeX=U<&e
O:D[(ZQTYfaY2GPNdZIfS4E31U85[b9N[0K?J1LJ.99F(_]4)S2_QQ9WB4b2GFL^
P5B@P9\I5c(NWFcF:6]54AZU8LB/@1A?:91[4VM[RAN?Y\U\fO)(RA)7:DGJgW(.
X\Q@A25KC;;[ZT;1@Y@Y]/=bIFf+(BEGa?>:.d&MB6?]F&L4#B5FVV[STM;Fb#(O
_6K&ENcWIS7,0;NP7(-A.gXW3/ADR\?@DTMgf@.;RfOK4KMBa/^?LI[\PSFP<LfT
7[Q3:Fd4WWZS(e^W(bNPegQ(_J>U/O-S(=GLAOS:&dE>0:\M;UK1A&40W>Z-aBQD
aM/O5U)e8Xg@QGYf>KVI-@@4.NZ_>-=.#1&UW0&PE@7->2TbRb^X1bgdf\ZdFaJ>
V;c&N1dI>U8S=QLJfb6<S=TN4X015Y\KIN_RZABbHFF\@U][AQ&XX:Ye,_EZXRfF
9KbI1;,_=Y>2YCR8_L6+54Wc)8WECX\fXK2@&aX@AP^NXLA\,EKYD@^]N:)IQ0b[
?FD3M:XS3gbMD4-45E3&8W_^M\/<N1B=c:Y7/:,;I-4#DcLHZ&:<N,\8#WJ:^#5<
@5G7(#&#gGWV:OVXA:;bC,#&1.FX&1WE/69_fb4QM:F+^)OR27,?@7;ZX/@a<:G2
RM<1J6<CX.SPYK&U_3UDN-PFJK\>B/eBR/(YeS,dD03P:PXDQ8XMe\GSJ/Ee037J
U#Ab)DK@-L.D_E@e>2YY;3eU;C85WTeZ@6PXcbU7.bWDd?8QgLKbYG#2HB+eXP2P
.IYAXGCDN8/RR+Z=28<R5fK75bL_VO?g8:K8c>ICg/R;3HHYI8\U8R4,-G306P_e
O7QXI+VMQa-/2JXK2PU9GM<8--B:dR,WFUG5_S,3<<X?OSQ&d]K.Z_,#7Oa+OAWC
ZMXE37_9eM&&Odd=:CGUZUD6LOQ]=e+KQV4):E[[W.=[VLC@OOLGG3BcM:NAI;Q;
P5?ES0&JZ#A<#O>;UC>UNcPA2W/_aS3e8aE[])G-Ja^cda0FR]U,V4O_S.MM;g<]
.,:O+WF2IbRM+./=BHTWQNec;5</V#11=:\4M]>1U_>E[@UZ<;^AXO2).a7D=J@8
O^&@+[/C(1Of\a1_)QRMLCMMZ3ZU:P)+ZRYB)N&1#R\U(1UR8KU\<:;?V@2NdJYW
9N1J.BHaR<&@7D\TQ;PgG?@9QWEX&8_7Y,6=<7>Sd^gYIS]6Kb&CHV2K@5e\?Z9(
U@CQeP[@N<9f0Z+:9PLVf_.H&PII85DASL?H9KeND@<]LHDW&(ACL->02#R+X7]A
J&<SFHFY<J=J)KD@B6e4c+/cO,K+U,;gBe,F3=VQ1-2ML0W;G&AU>Y1^c<QFJ^1)
>bX<]]&Gc5K9/C^KLgC1?R=ZV[;B<:G/&I3Z^X,16f^0dE/((L1&Jb^B6K1d(g=U
T8QD-.7;,]4g<8eL&B)=<)5/K#A:)M?eLgS8@cBC1&WHDHH&(d#)>H#bXE6B7JG-
A9gHLMKHN]F6F7O97@OOT>?F]8L-1EM[K)e3(7J@DSf3-&N>W9:MER[EWWQ+Zg1d
1@B9GeJ-?EL-YX98aR?UE<,f\SYbNNKWU6;=U>8A[X1AJef77c:DL)b1fA+1]GfH
ag+YfeWSa/[;bgGg>fN@ZfB]W59I]=#Z+Gf#8aPOJJ6TKefbB[]UCEOUW+C4L8@,
=4M2H#X+VbQ:BW6BSA1Ea-Db)?R#)1_E<g[VW5-EFcYI[Y)YMXHLCQYaPGGV1^c&
8-Q3Cc3BIdP@^RADXLEe<\ab/a#ZF<4KC-A2)Ja(P7gc1fc&[:_d3/E<_1V.;-R8
/12B&5gJ3#c_^OJY)Z];V(LVS)+#ab@edK>OSK0Rba_<-75Z2]7/<87L+:HC]FCO
1D0O_)Y<H,NNJ)EW0.<==;6/]\Z;4OQ-aYM0W?GGR(BO45WD7?]^-b#]7V\MfH,?
\@639agKPL^N=VMJ:]G#BHf?,Z?/e5bH5.[_CFg;4>GdGUZJT>VN_8)cbG.LZ^CJ
G0YeN5]6NJAW9\SPYa[6K:J6aR4V(Jf[?048H_3Q@>@MT=4YW.25)O=;C85578O:
.0YJ==F:6TSf3GAH1O)NZ>9<71GVc\cS:b/-4P__C:Md-@S8X)EccEWP\VJ;a\.J
bPTJ(7P-@,d=RWH+>V,3O+/C8e=AP^2LM[+JG+2c.6U86D7Y8MKM/-bfH\]e-HNU
]T#/MD+LAd<?WKZ3LO^,_Z?GdN8O4X4W.FH6c-:TO:=@J1HKf693LO#V>bK-C7D>
M&.V08.4c=BG-0RH,g0[Ib<S#O,2^@0cG-CXd@:fV5#Led:D6SWgCY)(ND:8WH-9
f9<Gf2UV6PRK,H<2_Z#[W9DC/9d56=c@MU\g;^7;K(b51>Eg-9dH:_0\\e4dGW:U
)L=@:d9aRFESZ;a[]QbS-H<V7;dTU74c0+-.\\,aSc?G57:\W]JO\D9C.AI3477:
/#7e\VGI0_Qf,\ETA//U]4Q#QXF>I=7OcKEa^MHJE<M>.SX.Cc06MB6RE7c:6Ed4
6YP>IRO5)A>/HL?13J_63B:1d6;WE?A7ZW;[+.F=4&RUE>U(F+2gN:(MfW-XGC^B
Vcgc-)aWde3R>TcP^(6U&2_##bZNa2:/8S@PZ&5QRAS5e+@Fedc?2CO\B/.,\<;V
<Z]SeXfJF[[C6BT/<V0\S/I-_aRU)=GX(7,010E&4(_76QA/aXcG.5=H<X:WRST#
V2+BIG7>J/V/Fg4=(D0&ODbRf#^>=d[+I>_Q]:d;II@e7>P++#TMIVM^-\7;]@;E
];9.S5cOKZLe[HbQ]09-GIg<(;1Y^W/2#U+#<6_A::6_+9S@d>Cb1Q&9[=b:?R2O
0c1g#U^AR9gP+fL#WL,N>2=<#T[7WWeA>\2:@J9>S?IC^X5,QCRfY<L1b@c8.g^N
;WIeY=Ng[<P-_IU]QeCf-EYgg5Y)^K-WI#c?gQ[X=G/Sg@NY):FU^0/X)#=)DEd,
5>WJdgF;bfdfb=]W(=-98CCO<E8:1P9RA>c^20V^8,Cc3?KK<PR8)HTF-fJYg3Xg
6bE\?)@/1KI)#1+=IcUQ,80f(TJ)NFQ7PS\]9&&9W1+C@(1a]IBLF[ED</E1SeVU
e]ea\JBLRV+f,6c:g4=d28aQ:Na4P,IR<d7=@^>bX3:MC9/:RPP?GNTA\;:H3OPc
=/6&EO7P[ff;QAZ\-eQ1>TJ1Vb-B.e=ZX-,eDfSaBXQQAEbF/I7R53d[?OHOWRbF
7>:&=6,7\A[BEA@39Ccf&_RgY-CUKHUa?4c9V9^Tc=cGa)TeB.7U6B2Ae/)R@V:,
#P3\d6E+IR1caO@;W6FY<(4(VCbJMR]E?^Xa5SG5DK3Sg^6++BK=F[+aJ50Y&&[:
O<[VT\?LYXBSC1=2.e)PW]A4aWBbU:dB6XTKO2P3g[3C9VCP5I>?)E.U&>@(RM]W
\UdVT,I?gdbMWJ:89=8\b7T#(FX&3P/6O;&EC)Q(9Qc6LgI9ZcG#1-]UGZ1Ce[IT
/&A&Y7Q&O-3AA(&(^0RZJc5Ygd9<17C(g>QVd#6O5a1T6ZW<V&4F^?LU[HXX^]O.
F_[Q+)@@<L-<23bV+RPP>P.HE;#)eba(fN4GS[_<[-VKCW0cEf0ea+bJ+;&QO:SU
a_V,HVe=;-VR;UW3(80N9,YX9?GQ/-Z&Q7+e\O,M#EH;1d(bS=GB.A:V>Q0,+aI@
I+T\IED]D+&e2KOa]MB084OJE0[AK7+@/WOfBQ^NObLa/WVUHQEC9?01]41d8>5,
(<-&XHQ0>-Ge-f\&TCcPR<>bg1:)S(f3b<03;Fe)f?63O@ZO,Jg8SMC=[VH7<;#U
M@-gReS<:^1(.8<g_c#FTeaeSefcRg4&N<LNN]a\KTaT^=Mec&0EDH2J0GDPcFIY
E)cCS9W,W1&05b(/O4DP3b2gV^)IMcHdT2KYNeJ]O#>JP1^)X2<.P/fYR=bJ#]GK
+C0]C@D>?P;?<7>TLE+>^S6e=OT\)C\QH08RN88Q/(S^DOY7>]+PTGfbX/5<051T
C,Z\2T+cd0/L5e-=0W7@.Y0?44J=?W+9;VEHF7ZQ/6Q:cCX#:aK5AIOe\:.#ZcL<
+)\_YTHNY.J</LH;>0f\FTR-\Cb5;KSS8=BFD?<.EG1:5@#21WK:MP<^7e/EK<e0
c#D3U034,1X^PFH8IJa8aNJK(,[?@Z/@KD9U=>ZO4&G]Vc/A,KJ)MW6HV&EYNO&6
+X:3AZbH#>8N.=I>(1[KE&FI8T1=ITV&JJ66>;TJK^&JHX+E?JIS,JNJVGHg]eEV
JMW\V<=S/gF?#=6-D[P).Sdb-MU1E#Q-&#DNT<JLRcT9a2M_7=PYE3J8W_K?LTFe
A>5I.=+,7-9(EMd,-.Q:2?:&/d<NgO67IgSIcS0H(f\WSaeI,,@UcTF>/Yf?)L]_
<FR)dB33KUg9CdXMDa;^7\[3</5P4E4X>2AF@eB&DOY2J1Y7\4X[<X7e1ISF4HP4
YJ1^X:S5/0a;RQ(c]&GH&6W[UL4^F\Eg_Z^,bTIa(Z(STGLVK,)VB_SDF-]OF26^
]L##HIe]_UGcbAaGM_g=f+.+ZK_S^DQHRZRN<W=0NMJM,C1IYR4cEB1=CZ(S0K]e
>RALMaEG[&V2)WS)RKb-@=^,G&)gYT;X,EQ_NH<OOeKbS;/CFf(4>Va^AMQP5dg]
c<90;9>^\\AGWP]^>7>9-#F>(YZ3?08W/ff7Z\.VD,,?Cb4O)X7R:Q.+,VK-Wg?#
=GKX1.^gQS_b#:?Y<ZQfB+BWJD?Pe\a>N7NWI,D5NSE.I=g1?Z+R@7/I+LEb/XZ\
73)\KN^aZX&ecE<T4<9b@IY[WP9aIHV4SZ0)2aTI\3]<AD=F=>=1Kd[f.)?DBd#+
BG]6cM]XYA+@E#+O8AfRc5-&W>ITSX&]D?8Z@^253:BDCKFWEDMC\?d3_KLX]=c6
U&QI;6ZA_##D4/g6666HOSeI>N\c3Pc/Jc_6F&V_B9AR.a9BRgG?a3C+1G]YIa-;
H3#GJ#:J>329X:WV5Vb:(XZ<,L,,+JB3ZQ&1\U1<gR<]024OcD],g?(bA1bdKFEB
PeY0@T)I-)^-[S,9[J:d:0bDO4<&>X2WAgA2gA(@2U59Y7O.\9LEG7PF:DO=c?&>
N)1^6g_,KVBAG0_INgcV,W1:O1(.R9Fg]]-UV@N<CRQAQ3e.DWbeHD1+5)O:A,-e
/=,[NZa/@BgL:WFHYTa]T2aI]OcZdRbN_YdbKOLX4e:D-GZNI#VEXB4^Z[&g.#89
_)+EFSg,A9:SV43I4>Y1,1cG#HOM:YB)KMY<9d<3(:]A,a6YQOV-#<I[<,+KQ#2g
S0FHW(/C<e]^3MM8DZ>Qf@YW511P;RDM/Xd6;QBWUe/bJK9C5bTW2IN:@QS0PA7.
9<a&FFEPA@V5F#c.2&5R]CMNE_;JG=g_cbA7LCV7+fL(UGO0C^AbMaLN9?6&,O8;
K/5g>;>R->UgJX/c9ecWE?S6Vda)0TT>ZF@OedL_1E.8<f3Q,D5@]K4]a@6e+TU(
B<ag4GIQA81Tbe>H6cS;7C)0c^OLB8-^<7OSIU#W=1f)_Cg&BZ?GbC_[<T2]U<]G
,6E6I^0/EdFOL.b-If@]<U+4bB/Dg9fO?5[Tg+?5#S6CXCJK;^cL9X+2U?]VX3.C
DbE/e)Q<Z/0/V1DFEcg#gf/Y22817_Qd=O9<05>E;L/XeY:1@]41ULMZ:]E=^^^]
]:U==4@PLOY=1fVKa+gKP)ZTZ?<<YW,L3Ea2YQ7I:OgQ6[SHcQa^+2BA9b_=_1TZ
O<?/MGLI9e/e(#PNL-5E3QaHHLf(QD6g^:L:0WHf,ZNMR/W9Y2K\/PYJ_[D[+#1@
BCge2M18#;ZL&VLDTT-D9Hc>8bG_(]PY>;FE\TUWA#3:JBf,U?c2K4@aT7WQ8B,V
0P?D(ZgV>0YY_-K:c^9TN8S;-I<T=L8]OOSf7f@/3]XLLDIC=KK+KfbRRR&Q>:K=
/OY:b]QMJfGOXX<T(YK^,8SKFMP9\(_1;APLc3@H-UG_??6dZgH^BI<)=C3<cg&;
1Q?MNX46?XYTTN.&3GDK>c:=C9Y(>?^7g6Y<SWFBcVA0<@Y,R4P</HKbCNccA0X0
FNXKUU]7U<QZdH[/c[\.86&YTCVKFfEBJ5GTT=BCgRW\/I#>8Ggf=Q9D@a(c=W0>
W.fUTDe\V^.4[\fWL7Z2YJW,/32#+1T)2HQJ>0=bP1:7TGMBTcE&H[g(\QC<[@7E
W6eK)Y^/2@<)Q+RFFOLKJKFFDJ@6GfK^KcV96@Ae1fH6CIG;Y()ICH3OaeDHD8<N
,-M;CB;dH3PF9,(_Q32;5Y\\fNY,Gf,UZgCV/Y#;Z8dcABM997FaKF]\_@I-5K2D
2^IMS>5@4XC8(G52RA&#L>gXP4^QE55R?X4Sb0/K=QF60)8:PbfI51b\O\6-fM:7
2LXPcP\fT@3-LH3?P7@,&V\Q3MEW8fVXSW4+Zc0X.[_YVV2\cUSUHE?@ACNE4C3,
86;0:AI=H([G_:#@dD0PB#gS_4@)\VCS_5Fe8?#8\ef_8)c#:GZcM&&]-/NBGUT)
C>BKK#2C-2dU-R5#C(BOBV?IW4XNag3?aC>T9VRJbVLPS8H.D>AS9[2OD&7;@[G=
3#fKW)U&3/3M80VE21dA@=]P>[]7D-069\)8S#D-U/F]-0bB0WdJ>Y+,^LY6@?C^
M118YD3Z7IfYBGE^a/.PQ\TK5#P7]6.V>b4E]eA\F:ZM2O.J4S@-E,eFBP\#g:&.
=&_&14)4d.^2\1YLXb.>#<O-dFfcC<-?H]_J8+T#J+7F0c0^(I6&;Ag>-KUT>8=\
Y)\L/KHTdL>7<@M;4#S#\)=T&dD3DH4EI^(U#FCe/W0HFM?[eII[[>Q1^a<0@BS+
8@:g#ZYHe>;1_eLf8c8]B]dX8=E-0&0T(+CX6B+QU(DF\C/<-_J:ZR&+]cV>Y?U#
9\77J:+[7f\MbYegDR)K;2O/F3(OQ]+LS6N,@N:O.4H##M.:H4#7^@?_E+gII>CO
Z&N@1gC[?e2V#8Y6eEP=#X.9Ia:@/;b]LA_@.d\T]8U4b1?CWSEWe#N<;7dS2FTH
b(J75RfgHFM]0#)^X]=aIeMB6AMS8DXD-9IY]c_3@9MZXA(S<4D#UP.d#0GMSI0O
<[&@bY?0dbE810bT8;]^f7;eEGS#gH+X33)=O#3/?V;HV)>6ETKgQT#@X2g@8_N;
Dcd]bEYB@YC1aJB?cI0DF&88:MUDGX2S+A9]b;eVW[J&W7DOF2ge;LX0/5QNB/_-
R&f2DB.XeM8)@OPQT0YAC?6V;e,@K(DRc\I(\g6L@WIBQG8I0dU2?;9Ad(U]AO4?
^T[;R2RT_(FF9CD:=LST-PWJ2-.XcG<aC[e0:]=ECVHEYMIHPQc\NHg&EOS)02UD
P?U^]WX9T_OB>4d\)1OQ4^a4T:>H&@AX,M@,)(-c3REJUgEDYY_&d5IGNI66NV/C
FQdf6Zd&cg9V.__UJ2/S\\VP-:eF[X9GZe=:VbW6[6dE/LM]CP@9I+(WQ]3&G?)Q
(_bLJ_:LVJd9<@dUJ)FK]RG37JNA&&YBBG5/N:)3GWaKd>]==GAXBP;33883/P&P
L6b<WW;TH#N:MGWPX_CeF76ONX^342F4;:de5fT/-@SbUW28TL<\gEg8;H52P8dC
=L5K8-;AA62f&/D)GLgd4X5@#5=AcAYN[@[TIgJ99Z2X:W?.XKTf++IER:^8T?TM
DEU&(UfGM6OgH#1S3?C50]C/eZ0f7^+EZFcc2b^eBU-K(]Q)e6>XKG?7X.\B@)(6
QM._g16.71B&)aR#2ecgF4>;aWVL>Xf7X0O++G538e]OC85-L4<96X,ER1(W8::]
2VE-J:e3X5F_2dd&KZEW2@E6g5cN]Y,V\H8EaO;0<Wg-Ka]G@]e6[^).I7Fb.ZSL
A?,RYE#21IP,_^<9Z#RD\9?9CT=b)@R]1fg0bR&JC;_::a=A//44R^Y-X](J2e3(
FBY,/We]:KGFN?1K>1;4A_-QO0P)IGETYF/KPQ5ZQ2Uc\L3b@,7_KcDJB_4@SRbT
g(T0]eFd5c&8H>[e?:0M#c]1Y8_]CJ684#eHZJAJP[;U,3[/04PTE(]4ND3d?Qc8
(CXbaMI]S?&e#9/5__N)K1G;f=D.ZPTN^Q18b]<]Oe=.]<TB6;7=ODg/B>@bFPLJ
[[<@(?T5@6TU?FMMR^ZS<^)JR+2?S,I/>$
`endprotected


`endif //GUARD_SVT_FIFO_RATE_CONTROL
