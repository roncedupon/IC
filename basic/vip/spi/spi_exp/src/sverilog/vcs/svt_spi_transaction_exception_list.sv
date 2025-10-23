
`ifndef GUARD_SVT_SPI_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_SPI_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_spi_transaction;
typedef class svt_spi_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_SPI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_spi_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_spi_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_spi_transaction_exception_list instance.
 */
`define SVT_SPI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the spi svt_spi_transaction_exception_list exception list.
 */
class svt_spi_transaction_exception_list extends svt_exception_list#(svt_spi_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_spi_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_spi_transaction_exception_list", svt_spi_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_transaction_exception_list)
  `svt_data_member_end(svt_spi_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_transaction_exception_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE validity check.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_spi_configuration cfg, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_spi_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_transaction_exception_list)
  `vmm_class_factory(svt_spi_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
E/6][U<BCd:eXYP3GFQ\2&B:S)+NS2;+;MNZ6?S7?:/J_O>R4Q<B3)]g13;PXg<+
+f,.fO:8FZV+(f7S?<TZ-S5O?A2cfUZ)AOOA_MbGgDeI=ZSASfQC4:NR36G0A3_+
3)2T[:LNSDAbS;(+cST?=FZ8=J4g6&ZNcEVT=\1=:dE8LN70UTREO(:\LZe_#dd1
KbFBX6P]B2Tg_Ie&f+,W\[\(M>&QOaLIGH]L\gZ//2\I983Q5JD?LFOM#J=7B-&8
3=7<I,1V)=RbGN04-[7I_.[446KHaDAV4T:\/7L&;7HUR#2]Y^Z5/&-R/DB>BH:V
<(K_?Z(>QL0PSgD=EK;IJBcUEb+_a\RTLJW57e2]H0SeK;K_FG,\Z3B7V?M.0S98
I\;M;O0Y\X/bL74O63_AL)B]bA3?HNg9Hd9&85B+87W9R_10OZ\1<1/cT7NC++]O
L)Y0Ob-93B/)@.ZXVeL>\14+CL/QYU=:>?9K5/Gb#RS07]c<([,BIeDJObc+[Pb(
>Ld?Md_41/N;-I^Mc0+IM\,W^]=33G@W#G3-f3TQ_R1cLZ.TLaBJ\2G7.7<g\J)L
B:#D01cF<Dc_J9RENAE/6(a2d\NVA\1bJ06U1ZA[25/<^\,N0[/8G7Y>2G+eN+V:
J\(Q71O8[BZ9(,^JA:GQH/6>aPQOO@>/D9RPS;5Ld<5f,+9#Xg:&>#KdF\=U+7=&
QKYd(YB@^A(YgCYe^VKN+_=H_.?8bd9-V>U\3+ZYWd:f/\R=./S(^d>@f/.cW[Y0
.ZdXdWV6K40=J?CbFNdWK7^9#\=D.3>-815A:a.b/LW39.2SEVbREM+]NKAE:])e
&R@8eMN>L/5<CK720^c5g;\M7O(_SKFCC^(B0T6J/QX00McRJB;E_M1GA>TLEd\C
#DG.<H>dbeC0Q<V&gJI5P:B8;cf-)O]LgF@]_@ZX9M4fK2c@0d5HA]5-YVXDBI@8
ge92BcBN9?@]3HXNMXCVYT?:WHa\T=EM39&aYEATJJU@NHRcIRG#aU2WN=22ML26
IMXbGc63<J6:eKH3GQ-3>-RC8UT0HEcIMM-fW]gb[6\)?\[g^_>L7=4[F?]U-a67
;S)O7]Z,1ID0a6YRf&K(>L^@8Ffe21CT&(Ua>0CP>;LM#V75V82YI;BF<(;&O[3R
PLFfJM-+<:[@PDIR5O+U[bO@[P&5LEF2Ud:(:EQSO\L\K0YcM6ab[dIMg:^^f<U&
9V<(9eR^<R5@,$
`endprotected


//vcs_vip_protect
`protected
e)af+3/RX_?eHTCPLbT?g3Ga^_Kfg8JZf7U-.#TA.c,M@WV5>,7?5(@R1d;><;G]
=dSIUNGLZM#VDD(ee:\6W2B=Kg?-<>9F8PPA-(83[4ZF>g+P)1^B?IP/B@&f7_.D
U1WESK.YB,1e(7c5-OEQ24]Y(23g3KHWKA7,QTHE\2IT,a[)4UA)/Q@4HZcKEW4;
YQ@E[1T(N?.48H,,;WQZb>/QHe8#Lg/K.&TX61@B-/)U)EPd:N.G=JLPH(P\=0H&
9>>__Q,F/NFRT#d13<Q/Zc)MY>6<33:DFeLN1LVK6AJ/1D<\6a79#,G<6A:F99QC
-\?:O(&Y.?Pf?4>cMNaO1(@d83[XD3)J-5CQUaX/<S=B?-B;&fKKZGC.7cCH.RB[
&f+\9b5U8[dKH#;<O#f43.@:9]1NTF8MH]IL6KLS@26<@ZG\M[?<.e#D/f36:c@#
U<TS7g+4@<?)CfROJaEfZ+=3U;1(:H<A\Q^c-PXa(]MDWfT<E<^V(8K8.=OE;_ea
@Ag4\N5[QK[BBU?_(T)#T26Z^DCf#T3I]1/Z<6@@7L/\)GfeC^GP&IM5)C@d/cNH
PQ52f7@TV_b?;#_.S\_4K[^_f4aG(7d-(1@RKCQ;L&RcEF=U>\]K^_+(UIG.BH/?
=EeVV7S&[[8TF#D2E^:)OOZ@cMf<WVH&@<>UV(GA5Ce2[RDF/^E:2bZ7WcXC70^-
d+fKDFD&;/@(U[66-@@^0HP,CY5=H2G,g9M5UP>-LH;C)F1DDNW5@(.V(R:>&^MU
dZ60:;E,_U_[dC3S,Hb3O?)3eRVH&SUG(Y.6#C5WVb_88fEfKRW#U@^V\W19QF&B
^@Na<_+8L(YcWL69AN167@:UTHg]>e#F<^SXY5B_1-S+-MS]+8EY]M3LX:<R.P8X
b[^0:d:+Q&R2@JEPDX[.FC6d=9PSa=YLGPcI#[A@#f#=T.1_ALJU>@6]W@@/a)FJ
,.V@[.]Q6Z+>?.>P?/2N.U^@G[<Xe-=,JWaB0G<N99MHF(K1?WOcD=DE8H2dCg90
-8ARe=cbPaFDOfA9;=C=FS.a&_5EB_8_?X-YYU8YM(Y];6WKaNF1[BO]V62bBMce
_E5(TOZ#+6gD,bB/0-N-VF8,X)-?;-0NUb/e/XEPgS@(e20(7C@4QUV7ULU==1&.
T3Y;<4OLA0U(N:CAEAb<-g@UAa59B7:)5]d\CaW.G]A+6JAZFWd4W=K0=R@25]#5
f7D\1+Ge67L/B/Y5SZ:N)+=<)[#G?e1ODR#B.2Z]W>Ud\,AVC;e#2#>f>#1&8E,6
;61@-BR9fd>ab02a.PL+?H.LH2GA,NHL8_:1,<,&ZcLQ]@>-3H<B88W:OVG;D\Y:
Y5M1_7>5a=@5>MT[FW(DO?9b?38S<@aXFLVRf>7#,=>QDd-UdZDJELT.B++Cb^6_
dQU&&VPMg\:XAL=L9Y>1I#L:9^PQCNaU#(6GAQ@[R??KaB-1WB>AYRBF^=55JWXd
?EY=cbb9SF7>eBc2;Z\+a(R(fTLSg0b872+NA8DHg@gG>>Y8V&_ZP1c.)Idg+.:_
[#=T^#I9T]>DJU6f-H:,PQWM3g\fc/1Wb2SJF_J^6X0SY1J)A&1V5KeM5J8B#a7J
c;,[5?dJ1426C-RT3b/F2XIGJ\(:8WfM+L3O)I(EN>(6<g@3E2(DYgZCAg,PM1-W
=/#]D1\UFUYdB0Q4&e^IW9FA2D(^c(7]3-&V&9-a(]fHLWGg6IB0UD.[-dbM]@9N
-N>0P(C(:K_H?g.Q-MU)]bEAV)M;+M:M8SP<U4/U^]553:-7+1+_B;a#;7L&2UUY
_UIe4Ug>#/T1VAdUO7CdA4K<&^f;O7T-V-gYb=)QQMJ[Jae,^a7AVc55/A23E-BS
F[KbDWU#?/c-RS:/J0O]2c[b?7^IfY.@S.7SNRL7[=<_@[8F7FMIJ[3@,FZV6Q-/
9,;Se=bPR[7CMHaa^fE6ZZHCR<L_?AdD:e^N@_+,c-#>EM1B326AbC/3TSY8d0QI
0G^5O/L9I2Y>57aSP[,&F10+I.G9AGNW1Q#;G:T^a22Mdf1Se>7EYV2@/U#S#_D<
C3Y>0;6SOEH]F;,/,+^PT)KNZ,5HQ8T)VK]AAIA#-&4?Ud:983K5/cU(1)/7gT=G
+;[1O=J4(LcD@/9-4?K-4e&IRMMU4JY\cA\Lc1W(X;-(3e&c87V?R]=IA:Y9D?.M
9=7F\gJRD;bA2<Q&DYaC>G_K(0Q592MW2:H5X=CBE+<C1U)<Z_V/U95UdC7Z-(gV
X#Ge[/2aM.U+_W6)J=,L\.TZ/AaM4B]c^ADdLCT]N@F03cZ3^--RK(3XH3I._RC/
XVGWVGF?7S8eJ4:E^,:\BZVfW?0_;K&O8YUAaT_[/8K+PM8aN(GZVV0L(^=ERTK:
c+Z06S_;@UR^8>LA8SaM2:ge)]Ad^-T9@#&TWG.LI9#UC(M]>^GMe/cM[YXODVb(
?QCbKOLS:2XM)HU_PHQS3+XDRB827,A:ZU6.dfD:ec_7N#CL60#?Q_7+=GffgJN?
,^;caeSNa_&OD^CN7>.L1gf=VU5I]ZLcZ&-(fU>Ld14F59VU#c>c#=[X]C3aP.,7
/\fVN^.ZX3Wb>G4=A,fcYfO3MG=Y5PRU@cb[J-RMXDMA-b#.M+I]JFO#e3V&1X3=
9GCFd8>Q\V/8_Fg)J]bEg#RYBVRTLPUQ,8.7DJ(UPEBV-^c)8Q=GI;\WXQWY2MGA
E_CL)/[5774[;7eaV54-?WfX]fYS)E]@Y)K-;H+7KWg:KA0g0=f,d##LC)TFO0D&
S.7bH(R77Y]cFG&?)QQ^&,15KKL\FCeD@&M;KAP0:J_R<^Y,8=HT7AXAL=)#9&Z3
DCYMdNC<TeRQ08]/9>f4f:f0<(g83P-5L1OY.+B(.&&A@_TDXST3;9[TK4>F/Oc?
?T>EQRCLA1,&@A0MPE]VJW/gQ&830d2WS9[.A\a>R/?[G2Ze-^8g9&)1W&]IKNQ7
?HK3R_[2.F9IWg:7NPd.Y^/MgQWQb8LeAA5(&#FO/9ZVUR,Y<U\6EHKK@Me1@5Y5
=e;A[98BOWHKNX7Z52Wc49W_3<S@L\;^<E1?FbaHKS@X?Cd#g1Z\T#Z#CF3#B;<?
1<b-RU4SL:4>c?=-fO0]g#Fc.5LHVKS#b#OE##[&K(9DSOBG_GB(26^\ec,SNg#:
+8.GRZ1UV;WGDN+&ZcG81;=b23(d_0(&e+0_JY77H@9YfJA;<>VF]K8Y<#7:/@E6
J4.5NITfR6CE.f]1JAV-(R&:5CAZ,8fRER8C/NJW41@6bW1,/WI/\+__A-3.Pd46
R2V33=XXZ5?0Y4V#VH=IO:#D:T&;f-fOd>+^C:9\e,C1-4CHJa^FC2P_YF^JCRS<
]LYRP;7[2eT-.WYATH)PWP?Q\C2.N>9]d_4+QH)9Q>F9J]_U_dSAJ>_OaX9,\T01
AWP)(]#7a^2WP.,CB89C]E:E7MTNXf+]a)/2K3Xa8XPUGZ:5JM^+Za<[ScK=L\fB
7KG(8D^(26VH_\G&CNL@UJJ?/]^5LNQ\3>3WCcK0/,/aC7(1=KZU8IJD0E#?1ZXf
Z>DG](N;8aCHH[d1>7S&>A4=&N,0/6_^]C8Y9J7&_@==6Cec^+c00O-SA7YU+8/K
RHGA<ca[KFXXEa3?#(3gU3--X&5<246+^72L^QE<HS2R:?&T3dTc09Oda3XJUPaE
SB1^I#3B/O/Y8H=WQ(V@JYXDADd_=PB,U9CeC),05@RU/Q.E2(-SeNE43X6e9JbI
8^&AG(VO<Y\^WdT_38;@/JJ/P.E(]\SY8R:&)f&P@F,WbC\X<:1cH0]>RP#9(PbC
7c8,^g0<cJQD.?I8_eE:O)C_1GbAWZ,_O6;856_F)ER0_JLW?cKAIINN_A\_Ld..
\QE)_,]:B.fF[#_M^WHE5gGC,/ET]9)QGf,:(,=WJ2(=d+;KZ-c7@S_YXAL_&A/+
G0dX?/+O?QgL-P.I/D22E//+H(5AIU2V<b0Z&W(F)&WV=Bg\f5+.cgC.b6_XIJFB
:Q,]V>WB-NgJ-bb+/6LLK>L=a@b\&WVb1^KNY.e;^.TeSB=cLXMV?eHeZbQKV;+P
[@)g8T7].=e=K(F,TDMJWCbR>XK=?TZ2B>_<XaU88(cf_U1DFM^XD9g4JZfOGL4B
Ve[G<:,ZQMc+U:\DB2H_A;(TIQ6W1H+.Z,XN<<KQ?E5L6bA]#>FE(Pf12b/(B_XD
K)1,:I3NKdV.9MKH2P#7UMfA4MG0VfW7TIXgCg71?EI-M-._(G.a&#0YW8(L5&9P
8ZSeS\0:2(bIDPL8,H;&U@Nb2I.K+\N+d:]QB\dT.0T7dDG3;GS>]J^7O)>a;H7Y
NW\c);aK+XPggZB;dgWZ3f[FUV#1SL7-J36/E-:Y27ZD2:H65_>T5YB\=]:PJ-/L
4Q8ZOWNHbT+M1Q[TC?>N/c^+d8eI\W,L>b+/d_3#Y9EP0.7O^B>G)^;Lb<..b?5I
(8c,8gL99EI59R/X_JA/2Y7>2HS14YOQYbC0A6gb4<CJNOeV6]>UJUO.XE+Ig;f&
AM8YVZL#QeA0:Z>782V\56ELH3,M>2&S-3FKNC0&<1RAA>>YUeQCCfLS+6BP/QG/
^,[(4caP1[DX]#S-XKBfSJ-&UJ,g;bLZ]Y#Ua9eU4+L\3#B&7Z3.JfD@_(?[W\W(
Yf]M28Rb&5O]V[/,&Z@_^,#-9,P3P+NSE[@.FS8U48\AI8TOBeP:@^ZdK=_/Y/IE
#YU4(J0Z^Hg>&7U^.Ef4+ILNXL3A_L3JOA]=IH?/6aQ^T]GV(/eEE5/X+a))A)QE
PN8T=EGPT2+B/N?,Q97#,6I+0][2MNE@.B0]PS<^MJ#c2/MJ]RZFCHPTI9&g74@a
H]>DINA+M/Q01a?B-eHGPS1)\0)6.;UU#.dQ[/[F.[.c:E-ELM2cbW_>@,)A@R/Y
H@NBDH-J9f9:YHbb^8+_7Ib(]+3XV&@T6BY,XZ2;SAZeeO7+FXd<):;>6SF63SS9
C^^e+_K]^aP.@QLT[6+dc1Q5H++]JcQP0]RR#-Fbg:efK4XO3[/g]\>LPa4)D[HW
ge=F.^6CVM&4L(-<aI^:I3X+W868+W(7CZG.@\Vf5S0D__LAg4VZadQf,&+,WQLe
_F6UR9YCG(-64LQA6U]K54a)W8[c;dFO<Y.5_1HMWK1[c=6FV91-.]ePaPCGCa6A
[Cg]dL5MGBA@L9=6=REWdJK,TPJBYKAF?;(D9YU0@:@(UDN@0=]]E9UTbCMU+2Q7
PW69393QYK]bI8:78.WM6FOca0/A/(4;=R/U3]AMR\eKYV^)-/W240gBg]&._JEL
TNe3\BXIQUca;8\1WS3^V8dDJA?NWGBD8XX,K^Z=dZG^cZJY_^>Y0E#M916NKPB:
D#dD_58@-Zg(M2FM7M89.Q[fD@FMUceVT]-EF,(PdD7J>S+a4T/A?_\);bAV#LbL
RO-5aFE3Cee)cce2dM6-4DJB>:AdM-&5@)8VY-HP,MCgQPQAORIW).SQ#f1]KE=5
1N3-PZ?D&N4,U^^U?Y]JTF(4N+#fI\8T[IM/Z?5H]8(1F.FE^TPgY4?=-dL3aYB.
OALHeIKQG?NNPbL.FM=W-X=W;]OJDIK2E0-cK2(@9&(<4@FY/Ge;K32JGG5ATF->
>/)4W?6^M)QN3f@b@G;E?cP#H;Q8S8U1?M,55R&20RRIJNLV_0L:g@#bCC5BYH-?
+<?@gAZ<X97gE_[#R/Eg;8A,RGU4Z77e;J4)A2V(JI7MJQTSWRgB2WA@#R>#&.G&
QM;#\:A-a:\W&7/2>3NbM^T,-Xd8e(_;)/.::Qb3C2La_-eUcYXA>eL8@.K]9#N4
.W@T/aWO(H8b13F)U\,P?<L&0W9)O^CcRL9?#C-@B+O0OG&MXa#:4D>&>A]b=g+K
&MRDZ<[f.E3Y,OaK0dPQ5JJQ3ROV7EK=agR__e]:eHTNC.K8Z\O60/#D\8LJU&Sb
KR4QG[f2P7Oa&5dRE8JEZbZN@[.>BD)a#A-/(0c0]-\?c=K);g6W36^;M,05;LJE
?)[Q=e\I<)8.ID1@0B1,Pc&=HB-W0.<eB-Q]cP501Z<MbJZM9WDEZ3-,(7=@;gYD
]OD7aK[,[@FWGcE-07));)B(_P.f1A1gT:4U6d=,/d>RDBN8=3WD6IXV>KMUOO#Q
4L++V@?89-4e-D/ZHY@5^f>Kae<3bf6^?NPFDI.cT0?QF5V]QV;F,d]MZ2W40ZZC
VT15#MOFX,Cb-WfKSA7^+_)14T:N&R1.[B2Lad;).CUK.66\G/SQL_b3PP<8^WHe
HYT6Mc6O)<2&(/=P-ceBZCXeR@F/+A#U1eF4&?S(@f,MGfe\3fd;?J(S#LQ>61-)
2.\ER5O=G+7L>bC4@SZ4163P/1#IQ\eab&MJ7T@U/.?aJ-G<;9UM-3&[SL\5)Ia7
:81GgPV;<N0bKS\c&eQA7O)42X3(ROaC;LC\FQgU&X_bSf-42FKP2,g&8=#=ARS_
F6BI#>BO<@eYdNKXI&(/CM9))@94,&cFMe\:+QX(,QX08;Q2+ZDDga^=HE^MA[a(
(E/+D;=-9aC)AU5e9)[-:T)3.9]8<)<91e?VCYdS<aMTbYfD^Hg2a9g,X3&H8AH@
34JBLa^MWY;(^M&PgfWR3N3O(bEZbcEP&@FO&f+)g_A8;T]+0CM5;_>f=,-;>ZWU
@V[[=e&N:fA5;G4=V=YbQ-d2P[_M?W4G=cfB966Q?HFcK+YY4gV=VF1&gP17IH\3
2\PeLC8,&@Da=1(:g,dYGL]4&g^:LGdbc7O:Y^OHd[N68A^aHA_P8WW@c0X.BREd
DbV>#FdQBNAJ-\N[N5e/geOUZ0DR813Ta5:^DDG@:eZJMDSQ(.CB=_b8Y4_^0/fV
OR#J\X(aXa@19=fTL6^Ea&-V:60BB]]F5POD)&R.CBe[/M/HdK&_T6POB>.D.?A#
=5)ccTD.aE>5-c_<HQ8@EgG6@C+K&T\0UN.I)Z5B.O/5a>RLZS(BH-VTPbQEc[JA
IC.DJG^0MIF,#61+UNMb#^EI\I@K5=fPg(1L5WdS[DG)(TV.cXW:++A370R:,Ff\
#5eFZ_aTE;,LHJ/\MC@WA5I=UQ<W,;cdX=gC.M2?A(5&a?.^FS3_4XEQ=42Q6,8H
)D>]N/?/D/KNeP8>,CHURW#a?a2=P;C0>[;C/(cR8519+(+-c.&c;Xf1;U/#A<gG
?/=Z-NM.Bg[KVD\8dZ77MfPWNK9=@E?>K-#&[<7F7_dB^V[QVbXG8.W3ZXG&+.aH
bTA?QdQc(XU^&+O1YaN,BeLRB13KVWRX;eM,a7NC.XDB(Ib?2cZ+X+Z;);>X9V8Q
-2Y58NdPU7,X8AM_T/SA<0PA[7Sc^)f<2E1?a\(5YL0SDH9I9_QV;dYcXY^MBY0c
gA=6eS.gOa^a:Z_AD,45YfAHP-ZAUQ7Q/(S(^EBJ<[>F,Z-fL1,^dE)g=)236O0T
E9dZ[VY@Xc_bL4CdVRC;PQ)^c>-6<>DLd=f73gTg&&)O^0JWQS[O.aFU]BRe5gCa
R-C8H<gXebPf+OFA(-M<B:<S6.46^3<@:0-N#P6@]JYS\f<2DD+g6532TOA&7NOd
WI/8J:1=[G^&8Q&cF@,^?_SL:,>RKYS?DB+<5V.P5[CPJ,-GP,6A7C#JS\g,@=.X
G(e^VQN//YR-Q+D+e1XXLI2^PU^b?RK:-/TS.fN3IF(]#>?F1P^O0+fC7JH70RC5
V1VdBXL>FP7THJPJO\HdZ[?IPa<9).ZUCcDMc_/b]]YN4gS0CK\B][facK=CVY/+
7OdadB[K<H/&17=W#/CHg6#0L02N1W66FA<KHEL0CaQ;fA3cBEb0VPN#Rc_VF+.V
S>XJ4??R&[T47^HUTJ8)(.?dRJ+#683\?AI]#28G-T:F49O+/aYU)A\]cdgR_,aU
PZW9[KJ8@ZRe<5fa\]25]Kab5)F1aAcE\<beJ)KT1YLb]9fDg]A:D4I?#05LE2d4
7;AW/3RGM\\R;P5NJ/TWO5V>0H9Y<eM^-^?4d2,_XUg>EKI,W-78bG;/-LQVCJ<I
<)O>EYfOG=-]FWRV+)S,Od-,)]35=BA7bdCGZ.cX+J;R1cO^P9&?3JTC?F]ZecH&
8]0W,T;;YQH5fH(@e1GZZ_(AXV81<P9+gJMSc;E(N4VGaWOINJ=T10_POeW7cFU8
?.2,Pgf?(\:@ff;?@^?@@N36JHWe\2VW&:KFX]a_5_[OS.#,VGf<Z,K#DBa1BMT+
=@8,U,5@c_[SJY+1XR8>8Gf)Lf&T0H.2_;\3:DO5;BC=>)\X=9C15;PKg<,&AOH<
>=;+]=&6\2]9#WV;E7U.PfZ@C#DaOfJ)1OG?@&G^CUc5-LLJ&N.#NF7eNN#E4X^U
A5&AR73c7&&+2Kdg/ZLT81bb6(OS&Ya/LSJMa>7f/P<-<UQTH3fa>QKCCcB?;NCR
B\2d?g5PK>8O[S&YUe=QfU5NV8\PFT:/g>-WP@[Y75Z&#79[DQQ_?^YaL/3P1.PD
.<1U^5,\Y)0E@M5,_4@Xf]?Y/0>0E1YY8ROLc7VW3O6D/&BfLX6(27I;B3^cQ[9<
9,G-X,EdD(V<4A_/.B-\;(,^(YS]LB@/;L7?aK^_7<3g<Q&OTN<6^-gea\7FaX([
=M/4J6)eZ:7#@0-H,=9MU#^2+7,25>441<MU(X_b]6M.@>aAFb&ZfFY0[aPG=_c[
];1+L6g2f<^eI^)f<I3M8+WW/]QZ<b:#A:-[BF4d2+WeUa.18RZ7K-NQaRYbJ0Ce
4>6fd^?f,]2BbcYHBD-L8d29=YCA^P]LaK,7Z7]2):1&RK?B)eb>b<T53AM>=Q)T
d_gf-Q94RPIf4?/TXA_H)5fXNKNS7d:NV60M\=D_6-:?P862_\>M\]7Hd]5DD@W]
9WBd8.<?A5KIL0&(H-#JQ#WR0?&EG>9G3N&>P8E3,.&R5&dJ4UFL#ZQ?OIB:(<Q3
8FY#0VfVLHfd_N97U[QZS_Y=@JBZDf\UY4CNTOL&G2a&/_&TLXAWfE3MP=9QU4_)
&@KLUZ0MN1C3;/fV<+6WWX+&[1]0SBECS=aH5a=1D?01P:NIU_2Ab.If&[>HL(L1
gJ=\-E0(I^W@XeJ=ZR>^1B.L:8[/1[5AEUQ]EI4H=g]U2fTdH=9]Q0.=b<BZ_g\5
+NI)_<::[,7OC>IgaGIYWF>]eVU/WYGUW\e2KH+Xc,@([Eb+0KLfO=>ZN^8-9+NZ
cI,0e:Z=A5U+VIdc>EVFaW0Q,J_DWS4#dGF5R]NLUQPb?A6U^R17bC.FJWdb41HC
;\cZYB&I;036=d)PH2H\[2?,C@7KT4:6gD),F->N:J@CU3g]->I,b1K]>Be0&-A>
/Q&-:&&gRZa0T/Beb:P@.8_c)g&&W>AYA//P(\2BfdVWeJ2O0^KCM#H.7W3a.IW8
b_N\FE;#bL0b=RIP^1CS4_I^&eUbYF,S-;/.b_^_QeL-\DdRKRU4W&CV9D4FaIa]
JADS15#OD94JY^1I4@e)_Zg;ZFZ(?I&PK9fV4[7eGR3^=9KC9#&J:]1(\Odd8J<T
Q(;T9VJI#2d>#,DYf]Z5S1M&A7[8A6:MFH4<eVO2AH)3>=J+VE,^3aRc\,&g,:2]
V@[0V]eWUIg:U6BPJXJ/X1\Ld/S+2#-^^QB1=\=SDWP6ML-;IgP[UP46GN?+fO;U
R<+B/W@Ce[.GK?@SM38@]aP.RWC\CZ4G2gBdGB(Zfb(7SbCaB00d[A_>7R:M,-g;
5\]7&6bPNA(NOfM:L<e\Q:Z\&G>Qcc>B&&PW)E]c0I;;I58]>[:)7X<\.;SYD+1<
_7CfC51\[IW6WN^A6F.8.<]ME6WNF27C:+/Q3VD5?4aUg[XL1e=6;&/CDF?M&WWB
1D<5,DbX2IWQ]5cNg6R6fF3#CH@NdI+#9D^K)_:7ed.F,fM:3^LN?6&L2WB8Z9D1
b08C/&=&-6_GOMBZW;JRD]Z&P+HA8cNL[.]H]GTX)^2:?BKI\V,_HHH.Y=&N[3(9
]@4c\5W9Z#X[@YN[(_S(/&^6^&D#N00BS-FU,U/\cYbf,/V:,W8JD99J)&N,D_/J
]Y1P\\4\R,eLOO2+X^P6\Y<cV+:ga^<_-DU;#(8O)5V-]Lf_ZXEHgYJ\G8]N)POI
TW&WHASEA(\,aM7T9=(#TcaUJA@c(^&N>,U=fVTW,H:TB0TRPc]28aaQ/ZA\A+>L
DDUe6<@FZTdfa0YT-VKT;8-^5/Q_JS3&W;P(X6^V0]1aQSOG@b^(XKM#^;aU6#Jc
#5]C>>4UT50aWGY=]#.43(\ED<]I]KCF/P<Y,G.,FUHFe9+dT9\H^B7EAMPI^-3=
].C68C1dMdbLdOQ-K\E^\XH40(/.?P]e:2:H)CC)gH4)bIQb&[c>g<L1QXPcK4)F
eSY/9[:&@?FD?Q-^R?@]4N9YKaB&MZ7>c0JYF2M]O;DcDf1Eg;\HCYE9JLQBBWB&
.@M]04J;QIFPg0Y):<NU##@cG/MKAb56AD?MFL-ZRG):NL>4A6bOU)_=A+CWF-<a
CA<D0AJASNDg&A7)W24(,8g-?Ma?#2XB6W/<QPKC/>AbY&QAHHg./?.FCRU(X,W(
(:7?(bR9K.F:W[f)?8;@=@N8B+6-DHYQf9?T;EF<,4FSgfg]TC>Z-(2A/S8771X5
R]UK_+1OP3eEb89&OJ+ED(8g+P]30-@:6O[F(e^aBd_DD#TJ.8<H./0GHdU#d-[R
21:+QaRMR?2ZL_H,JbU3-1fUc/U][&2<>6<&XKB&PAOU\D6RAW\W.c0GN$
`endprotected


`endif // GUARD_SVT_SPI_TRANSACTION_EXCEPTION_LIST_SV
