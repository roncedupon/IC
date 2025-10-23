
`ifndef GUARD_SVT_SPI_STATUS_REGISTER_SV
`define GUARD_SVT_SPI_STATUS_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is the SPI VIP SPISR (SPI Status Register) class.
 */
class svt_spi_status_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Mode fault flag, this bit is set if SS pin becomes low, when SPI is master and MODFEN is set. */
  bit modf = 0;

  /** This bit indicates that transmit data register is empty. */
  bit sptef = 0;

  /** This bit is set after received data byte is transferred into data register. */
  bit spif = 0;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_status_register)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_spi_status_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_status_register)
  `svt_data_member_end(svt_spi_status_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_status_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
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
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_status_register)
  `vmm_class_factory(svt_spi_status_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
g^Pg7TT)PNYFKCBEA?\6DE>Yf./)22cRQb7MS5[,913+LdYaQPQP0)-O-]DB0+#Y
<6cPF/HA3M.4d]#Pf_O]TG/JQ[3bVd0LT8?c97Xee_dG8_\HGO+()3G_0AaY[G(6
]L/._(9=a]Gd[N\J,4d+9PI2Y(fT;Z_JZ0Z^a;W<NO9(4Va<X?5d6FEZdZ=J6XPL
]6gO>QEMQfB&68[a@VV6_0<Gc&B<2UbM1[eQg=0??\/5[MM+>MU?5deEJ9Ja^cW-
4&+)gB[137N<@4<<]cQ\/P&b(Jb=_1g/(PJGe:N],2.,;\#Z;^ee&KV[]VPf;DE>
IK[b8J=(?UQ@XN3_8+3-]9\bd3YMELdBIL^^=4;=,FFFF>Xa/5MB3a_F;H3J)M+^
PEEE[c^CH=H(;BSEMW=U\,VAEe:EVXAe,H)=@]@ZAURDLB8S:EJL=I=B:Qf2NZ:K
T8;\\FTG^/=ZLONHH+M\;RRcUC<:dI;>3<aVEW\5(86T9]O^;(-\b+dPR(R5;e\Z
(Y0]H[Ig.R;T/\5XU9IN=D?K>-(]<K5),TM]8KVN5\d.aE#NJ6JdRJKUS<SWAJVN
]e1gO_70A++1\KN2RG3R>H<BL+cXdcYNc@>1ML_KFT7:>VN\I&K]D:a^],HTW3ELQ$
`endprotected

   
//vcs_vip_protect
`protected
)a,HfVfXAg7&E,6\00>.#9SOf?M9ZLf>/4[Z\M^S4>a;7=/)7TZP.(eg9\,=>b=(
LPG>H2@.e37E=eD@eCG\g^ZI.7^LMaZ4_;.c?#WeBaV\C#7;=@,LX+L,XdJ&,O](
93TOe>V;Ug;-9eFRLL?S4)ebRFBLV7[0E1L5J\K^Q\G=F71KEU5Wd72a,[AYN;);
<ADS6J.V-E(&+?V)R-a9N0S@SKa#4Z3Yd+HLY/-P1R:6:BBeUC[;4[SVR1@dK3Z6
+]V7?;E_f?Z#FS[B@4QQ)2;)W3AL=8EN\UBC3_J2,#5Bc=0-RedAK(-)XO:?XU15
M<;W?EG])5LXG,@cZcCJC9U7dN;be+A:Q-LDBY@N=D_RVIMBL1A)+LGSVc-BOMGg
>-Ja:Q+JLaXF3b)aXFR,LS6>0cHE1FEc:^]\N:,;1+DYN_+87STQD>\VF3(LcUD3
[R3Be@Cf.7O3[-gK6Q@T0@(C4d2/VUWV[e;_Me+^:7cNKZL4=BbEcCXL+4Z>edKF
2<c=f#3?Ca?<[Z9F_e8g?M@9G\TdYdPZ/F.BG(GFQ)58K@DVdF09)(HU.eC[FZKK
@Y=E&AKL_ZebYcJDVAHF)HBG3Nd:5097Wa?])(LgGcS_[^KV8V7WF@#EK=E\GW4c
GPB#Z@C\HD4eZF>d1,5#^Z\XV4R8XXHEX-J]&eJGHB1<_2Db-@D&&R_4W4V9M_7g
4@:fG#Z4LcCGL9AX]d-0Bd:J3KX(//1H_B>>45bZ6@I=5;O3YQ\XT1?Ib+(@)P;)
5XKa74V0RC];W/\[^,QA#\K<A/I2^f,=b#G9^(\J1IXg[g]5&He:[]KJ]12O]CS<
=[Fd4dX4;@bYO\\7AQ7\UVU[A4\d<.4JE(bPYS>V?W_._9KE7bFNIQ,VQ:RQN[Y=
8g4Id4=_0XVZRWSa0^87S32/I4Z/7cUd\R0WB;IE)bZ)-NNM27OgC7&fWS(Q[DC6
DD7f5NE8B/9&d(A_.C9X;(?5OIT5aB+Hff<HC8V</KU,a^c/LXIIbX7CdeBF57Le
TB@.Z55)_K,+WB]_)5_WD1DX/3^8bF&7OZ-:a^f9V5PHW)a33P2#bg;RcXgX+;OC
EJD4Z>W&/d(G/8ZCgHJ]A#43.I1PQ]SgZ]-?#MXWXO3TV<5b7P:&(CM:DX\T]K&N
;IPO293.9+b-15[O4Af1-=&G]fM)F^3c.bM^_T+GQV&/1I]347.9df+JW-THRN6Z
AIAHK/D;UU^dHVZfC#//BK)Y\A2cfa(V0)b=X/^WH#E<]fT:EaLc#UZ+V>Pe>I+B
]4KSKd3VH4Vc\,TLE@)O.PcLeKDZ^2RT@QT;VM2:U+G&.DM30bI1?g<G&1G&WRS)
K+gWVg_\<LF0E]b4b,.RF7aa4P\M<\#LS:+Yf2:\Pe_..[3@8,U5@BEZa]<:V>YR
(bYZI>?-,9A.fF:;4(@;d?\Y/I/LCdf&8R?R)9aG5d\#:L\TPZa+@_=:V7c;=SDX
_DUb)PYC5eN<T)JYaN/gR;A,<X-]g,SXKIW.;:RKAP/R1PfKgHC@-(-4>BUV>00H
N6g<@K&=]EUeC)5>P#O5TDWPe2B^GO7#)U[:aL]A@^bQA:-X3V#VL\DPQEB+,5Qe
N.+@a:&eY7?6P,1D+4D9(8K10H7_aQ6<ZdEBe<7<.8D.W9RCV@,=<:,2PAH?]IH>
cHa(HSJ\9?-G(//.5C/f)CEW[F;YQKTF)\3\C&L#daYK]SNH&)M8-d(S+[CR7CAV
NC4d^KKWaW6+OYfTOX-Y[(9TE)^-#747YNfB/&E[[I[gM\Ac1<ZA=3-O+Y+L@XIK
A^?0M&SdK#4bGDB,8X1X6RH2g.,+O]aTWML?7^H9OPYX4-8YFXQE0RA+D.D6XZV4
5OJ\#QWA-9G.=M[>\XD^SW=<81N]La+DNV+N(_4YH?(OF<ZaaL>)&4cG6f3F=VFX
T4>2SC>?HJ/DRJdOEfYR.V[4gFgC=W+fI.T_YV#S/JNdFZ](8d-d5L;-SgT#[ZN+
UGNY\0IeR_09)^G#\U&0Z\H#<.gUADQ2eJU+A)->^F_&<7IQc&CWd(C948-)2ZZ;
Z3>:D2SGd0/66WEMTGR&7(P/1gYa7GK:ERC_FZ\-42W,(VQX[DV?B.8^KI/RF&8Y
MSW14<5KfCdd<6L,43:AY5PY\[O53,RHW,WZ-7@WSCbWO4WDM@#^[O@fbNU@D]E@
b1fY0ZC:13U/6;S]6N0XD1Ze4PcH[WP9C1E9HH3E#WOeSM/e/WLQ(3S,[ec_8AZ2
]H^67\aA3XT=<XIXV[XE&D^BGH?#VU.+IDS-&Z_M&d]fRd-=:I,VR,W+9Z.D#[6J
2IPY<2_^I]9gXRBA>94E?c>>G[25<^OKASQL&;<0NI])PG)_2d:^1..Ca/B>J7A\
X,K&:]XR#:A>N(5RS+D/-9Qe^KF-_^;+4IIJ8+G=0C/XSL0/Z=BUgaI\^YLZRGHE
<M):YN6-]Zg\.DWPD+#2AHfTDJUg-XS<IB2bR<MfIH_G(INX:F#c+FY79764J5#0
OMKJX,I@2.dfR].D#C-X.T1a>K\^8(=,LcK\2MQb\O+4#Rg1:<Q6L,NJZ:4,cJTE
1POHKLOZSSU>UVDSVV[PT(?Ge-=1>J?[Y)84bLV.gc3FD[Wb8c98#Bb&+?+8@&JS
<S]eLP#X71?Z8:4G.(7W?>-QKQ9_5J8.,?PN(9&G8+-<L2A7AQ2&[MC]JH?9O>Lg
2bU8LO]Y0<RUPe]4Q=;UcHJX@FPd,Wa7YG/T[Z3;g+SS.ILZ2SEefaH+T1L+1URZ
g&8LgFKW9Be\.J(GV2S@&H)TfY=a[C/Gcb,1,(FXWacTV83c^3)S:Q(3A9K>a7B7
OK_6\a0,9<FB2M/B9_@EFWP?L/H=)]#6POHS>=B0J8\G=WOF,IL]:B96K=Z;7X7Q
[3.cM_T3ZSC>VeO2.?M_\RUG.W)HK<NY[HLg1))M5S8fd?g6ffaf+\6X4CZBb^J(
H9EgZU3_B3K-,>1.@EW2>2#A37>=;(0P_4eg74[?VE7R72CKJCGV)DE004_G.E#@
=;<R/9/J&06SKAT6e36K]E9R:FXb7)\JNHgCTK)]&)XfJ>,/CFZ8I\FY<N9P(6R+
(A2fC:M(a,G_USg\UdT.=&RYO=1_baR/#,T<:2VfU_A>:F^4EQ3)_43&Y;S6B_8E
YC84A-0_<-1[.KB_JJRTH:(S,[SRF)a2gVWFI;XLZN,R5M]L??&;A<fI@S6YC<QG
NQ?C=PP-BU:PZa&W[>].+(2^YV<(J4;[Q5#QUF9X?2a#ZY_c07.V=8)0P;ffZe??
bQ7R3YJ2gCC-@#A&MC_SJ,M1eT+X2<C4OQR[.f:If3_O;CIW7b0\JNLK,&2XQ7a8
QfQVVaB5OI\LBTS,P-&XRH@12V5C&84AQc#NSAZ)\8:0<[JKU]QPQa(#/;5&R0B6
J?&1JJD3aRca+VZI@8,P+_&W=IBT]<UeMX(B-R940BD^M6C>S.d/1(0#8]?+I?9(
ZVIaO9SZ74?bP_8aff0Gf7e<c23:JYILMZ+1G7L\\d:V5LRcF4ZZH:>6S[>>7J4P
KC<\7bgc/MPf_@;OW6N:A<4578<7IGCMQ1<X&WeM.7TfDA_5[<MfQd^@HH4=U]OI
c@bL&c]a#b[M:;.5E6]SZB@?BAd_<92E/)Z_Tc-d@2c0be)I&=,S:JAV2__/bgX0
U@d8)?-<16R,\5##?#7MfH5AcF/d2+#D+9F4S+3G6D:0K-+PHY\6]1+fPP8RcP>L
<aTPYae7SM4SgDK,IDQN=.U6S(KXX656bUM,XD8cB@+,==8:M2Ib&NA-]XU)9#J]
N0eJXHT[Ee/.0M[XH=U8R(If5:RII#XgMAJXYP.IcXf1gP\0)dLU2[4]c;=#JbII
9\CR)?DTBaY..d_:],Z)#+a4LDL(V82eaWMNWa1DS]2-C8f+YEZ+E]0EGTMf5Q7]
E5eUTEA1H+3I#/U0B)FTUU3N5-JU-XE<0LBDfVb0Ef0;NJ;/=a&:#NF^667ZaR[:
.Xc8ba1OF?^g<@[S&fc=.T1]PPcbLeReK,K8R)d&YF)S2BC7<((:Jb1d+8G^Y9f0
BX[dG._3T]S&gK4_E&P?FQd41>gR<6JHdF:4S^X>/G/O]7)J]=6GWR7LAe:P7;IA
Y+2\C7XG;1F\,/]BG>[,R]FVeJTMg^\[V9_^RCc5Yb)f4+PM;L0d,CBY>FgS&M@Z
Z;G/I@>HOV7\8ZGW_.Q69GE(1@H_cS#GM[YPU?7gQD^0+\DOfTgW0aH2Y[fd7DP-
=]14,Of]KTS7;6(2[6b>aQ/bK_OSHI,#M]R]Eg4AQ3F05IGXQTad#8FT&A#7c#[^
8a>D.P]229+[/IOegO;I[bIBKebKQ/85,\^9GG.>QVaU.]L]6_;_^1=NTRCWeVC^
,gG9R3^I1aKFYQIUdMHJQV4L;Of1A4,S>LTI@c[JXd&_/TAPXKNW-@Z?<bQ#62JL
\-dBd\]1D\455edR^V&f0d);[VfJ#7_<OSFEf<3?>JZ_Z=cPG;?>Cb,7<K[?\=9V
CO/4[d1W0b+.G;f4cY5MZHFCZR[YdeF+ORAbdQKgbTcVV&LCL?.G^Q1S@5VIS,<c
[cR?0g9F)Yd^T+f4Tc1]f)E60>9^c)VF,bIIMbS2(D^6=Bg4T#P&1O[W@P,LDG::
@:5]>1,POe\(-FDR<)(1RUA[^01b_gb.9G[,f:^W:A<[B#X=GdRJ>/JWMOP(Gb9E
Z1;AHXc01g3Ff_f5FMBbbQSfeS&,RN7@NJEeX0Re4g2.3F@6W]Pf-J1SF:=&EWdB
I1PD-;9^B)6W973?cc;61==g308R>5+CEK=.X6Y7U26_)C>@,]\@VZ>Q@FcI^G(&
G2aE);#+Me/[?RUgD[N?@M0:CB.];?DLW):M;LN<=Pb6OaIU-6.T4<?1?T^0@K2X
)???QQ^.JO\NS;eId<HZ(WPVVX)4SM27.7).G\d)5N[.FCXg(JEa@QA+McMT9LcL
LEJ4OZ>3f.B:ZH]&YTT@)a?:M.941.B?c<PG/-854S^@P6Fg8;WAI2CG&8cZ6II#
(2a2].U6H&2CMD2ebg@BGACT^Ub8B_D3/HTIM4+-,=PAQJfeZ-;DM(HJ;fIGc@B)
XQ)_fXZ4^;3+)^&,\dN9:8Z.fL=a7D=f.VRCV?7FEV48MWfJ<G?63[+L-RCERG#S
XBQc7SV\YI+Ja:DZ?E.FE1e7)GUO&/1UPR#_gN/fF8JA>b9KOBI&FBgd\K)[90T\
fG98HHAdfaFfR.,4-;),LG_G2,Vb_FJL#X&EAS@DIg@EaUd3[I]ZG6LELSK>g_(,
28D^bRK_TX2)>+D@LFMP>AC5&QX9VFU2C=4dV7.f(GIgdAeD_=JEWPP;+:J;+I\O
HFLYC)d\#H_\SDV[J3L-0S2dDO\9B[O.^dc0XJ,YA)b1+XBRO](I_R)Z<gB=(YL8
^(\<N)aK:20<H11PQ4W&@S2^,BY8c=GBUeH)H/W9d_>fa2cN@.ggF12)^\L&PW_[
Kd3g;LC](Z)]QR5eBf/beO(=#?8f?)_Aae73,DL7MHb3(8Aed<(ODHD33c0&9]<+
:6]DeR0-GD4^^aOT]d=[1c;[328DLc)&+3C#L=?39cN-Q+MJX-B,]76ZEKB8M)d9
@Xba++de\@X[fV=F-_6N62ObdLX22.VA]Y2XSd-.1,4Jg:Z:YN/4FW\&WF-X?\_U
#^c,OZRJI87OYY@#237/EeTdA<Y#ea:WOW-0K&VXC3^2Tf/:<@5Z+-##f0GgUN=:
UI1MT#B[]8?4[W1K3RNGBV03-?fa\)[GBbS26QR6BGCWTM=6Ec=W@C_X8GPHW)dS
L8NC@<LPY274OZ/0F=PKd(^O2HRQWSXR:=+?0Cb\T7B8POeXa[X8]E+6\B7<&UE+
6eQf,:\D/^YO(e#)M795g.:IEC&:3&\:8)^^Ba7-IYZ(X<14:DLWP9-9If72NCXO
Y^/W0d4SKM_AS[>.RK@KP-.b;QT_,@GOP^_\JT?HYQ+NSNK@17/>N\QBR/H]J@_T
S(b()PC8EVLAES2FO39)HH[\b0DY_;X54V=LAMR)2#]^],2&^+;YQA1WUHF(O&Q]
2\7Y^UOTeTZ].D<&b]5/+WOSGc)PTCX//b.SQ1M,#LGgcbeKdVT_2<9VDd28\E)1
./>&#,7bRY:9?c#EDJI-EP\,0;A>)D/FA^VX4QXP80f>V1^I_3VW@ABJP:e,5=?4
WHH,&>8CN48_9AEd,g+4,I0V0/PfIO42<Id^(3,XTI_M>HJ(8db_fUI9c:(F^La3
Qg^fFX5>cC+K_V099@FJZ&G+:b;f_;c46++F/OWP9+]T9e5N38T-.2])C#8YU[b-
OJ6];CaB]Qg>M.6O(9&(C^03]fOW)&&6Bb)SW0VeT<bLS8:AdR7A=E8e_BZM5fa0
53egZSI5OHA1JP3.;\UAe0^Jc1&dBe?U[NR<R@F_3df>EI>VUfc17,;a&\<<S+MB
1DNgAS[/IbgKY4#VVE/-eaGb-gBF;>B>)D#PdRQYUd&gGFIHW2<ECQ#LD>d#8D(b
=fO#3?)XK72<],^OC9@N)Y6ZIb(?L@K)GCFG.faHc>LD?7Qe<^LEe\H?c-J,S()K
K?8LT;.WZ]2TKHQ^=<L/F[QLc=7OcP(\6cNTI896(8:,2J?bc)=^H94;RB]W9f:&
UW3gS&A#5^.P8Y6,+5RUG@N?SZIBL.O5Q88L3LW>eVgWRSQg&LZ3Y@0Q6Ea/QJN@
V>KOH]]11CV[:L?+<CO#-Q6\>8&70?e)B6A,ccG?P^a/2?G<MYUFN_4OX]Z.faPA
]6/O7S1\4#Wea9)+OX@abPd[64^PgI52(/]4=7BU#8EIAaeXJK?IAI:BF(eg;&GM
,eG]<D,d.B43=f7@)fPV42aX-SBU9>1Y;M^6(G+H2FJ1Aba4K&ND-L31S?g[32D0
9I_=6(B\T<7B,XWd13PR9W9HC7EC)8_gZf33d-;BC62.6X\WJ^CFbdg3abSZVQO5
4WZ^:1#)KI(1E^F3=<d@\;#W,4+c2fb>-9@NB\WI<Af_:gN^@:T]7eEeC@aSB<F0
OOgTH#/A7]d3cb(eW)6a5ba8YgK/NF26AW.aUe2\AZA,__@GRAV/AJ:)Q4dW>QbW
N&\JL.,XXKIL88:a(P;F694[SJFV7EWO+H>V>J]<216e6cT-R;9G)4L00538)GNQ
d#b#cc+#QPe#?Pb./P[C]Idc,6J3S;eVP(5)R)+RONG:5CQDTKX+7W)[427N55PS
.;#ZV=7[#V>Q_G\(,&BKM>MO>,.]UV1FbEZ35;D_\O3Hf[-AY+ZYW#OO\Y87#ZgT
FYb<:HW^>3T].(bS:/@#dH29Q_8Bg>cH-+g?PcQJ0ZT:XWKAK6J\NafWZAY#IX0V
_IVF</\US4Rd0E[U-<R83WF,X#_N;]#Q+/Bc].HI]-;563g5<E<@DYY)OD,dXF>5
/9c3Sc7AFdG@>Lc^4QK4&#6OE8<aB3Z@TOb#2e1.+B3a.LH#[a8J/HD#MLTM_.UT
W=W(MB8Id8VY[0XL6BPdTT^?YaNA_L[VH[b+5,SF-S(-58R<+=)V@.,3QSgb0:IV
57NG:U\X0]>QcG@-/B]1C1G9M.C>P;B:fAL>g2@\aH+959>JcQKH+bD0-W<5N&Y<
f4J)a.OC4K@8+H+K]B>4Q=CAAXP0:094f^F:L\;MUH/>N6?L.SL#8gLR<]81D73O
b6N0<&UTa4[\d#Ye7)7>;I41P@;/:3ZR22EK-P-WSe+6G3bHeX_Y#8T\&A0]VE8@
MY[,/3e&[VZYWA1QQX]6(L(Q4>S)<=PCQ7ZIH1@.:agd\WbTCNCBYK,RTC#EKL=4
6-?2DX[]/WC;T5<G5?:Z\a6]dKBNF(JQWVXF_9/SNe^cIYKV\_S[F\^_HU25W86g
L:[1N)_MDHIP:VUXR<LeI1SOB.R)H&2W^&N[?=9.BS6AP+F@L;TXF8K=cBKO-J47
S0?N8R:]I61<5]L:b,dS&TRJK&&X_-9d:HYfV^a9(OaH&28c@?=g=T8Y@4I[Wca/
+))\GgAH=DTQeF;3<5^WO@5aG<MXG0GeRXUBf)BBYA]g8D9JF2Z/^KRVbdXMUI2>
]c+8[TIAeZ_-?FL9H0@,5\?A)B5Ra7/Vb40(W<O,Ea2<VSb^6MO8D:B?(3,<Y4b1
WIedgMBDe#FZXX0-(8E=OdeF^P?2:XP9cR4)G1R;VLRUGARKeUY#1(8WF.2+]LTH
b]@ABC6DIB09XL^Ne&+Za1ASS,T/8DCPHIYQ7<dR(3,_dY0d94SI=2&9U<[C>1Y#
):XCI\Ud#V0QR&9L3QC+.)Ga+VTH\H0J<EP1OP(@f=.+G0TYcIBF#7]\J,VD,,AM
^UX;&=A(K3fVRY[N(JF/\-P]TKE_bRIa4#R4;Z7TJ.&+Jf67/[F5>PDB-2#VM(U,
VY8@8fHVK=&JL38UX<75K6&6=;K#Ob(UIa/aMC,\d\Wf][a<D+G)52E^4c65RdCV
M4AdIN6bM&F>VO>bZ;gL?3B;0NfEbZCL^f]+D(_>gR3\9(Af3J,Q0_3_]@THREOV
C\MIc@7b?ZT#cFZQ7K=PZ[H6)??ZSWf0JDB=7FLD:#TA?Mba\K^R/b&eeeNaZee)
=C&@LBf<O7I3=];&eGg8]@^9JL+,6WT/_(3&/X(N>PKIQ8Ea[OA/X.H][<-;T]a,
J?^[DDWCO7L9cA.C5^T:Qe50FW9&F3a31Y6-Z7^;/:UA[\\IQ78=ee8NO7.29RLU
QR?g[J<J\;,L\&9CUB+0BGA(1_3;CL11(4&5=C6WC?+IdG^U\&Y7YPa,I5dQH.Wf
bX3-cc-@3OOJ,/(PV8MIY+ZS4d[\fT\0W#EI85dXJaC7AW>S[R1<]>>d@[eDbV4b
Qc5e@.O<MIO+[[E:ObT<VV)AbZ.\_U7Q?:KK-UKgS4]3Cb0786?2Nc2X8-f<ZQ5_
1_R]+81-;(Rd>cYOXS=FBSBEG\79V?g2eU>1VO.#bB2aZ_Ca,&/XbgeC(XgHU=Y,
#ZG4[54MEIgK#dGU4@P(PM:51_a)6bNID\)g<,fFS?Z?=2cSXHf/@#O1::YB7[=,
=]Q\-dK&S?AZ-VDDYCW^+@<3EM>fA(d[S2d]1P43c)]_aW60;(+Le9d6V6A^[a\N
bH@A]d>aWOMU/XA5G_J9fXAdKMJ&QV-TCOLX^^0-OO[dS\5^3TBPGe(I>@-MVfW7
aY9_AJ@3FB<MJI^aa48=.bM3VQ+GIaY+c^:))<FZc<4=>0eA-5)+?g&77ZcY(G:I
\Y/J1+=WVBB\bV#9S,V,DXD5?=QI5@FTdKS[]cXQ8Ob-DA0a&@LN.HC=YY:,CaF&
,Q_:GOcX+QUSbd31dN#Fc[fIaZ+6[9\J:ABaX]^M8_?R3ZdQ=U8<KV_19VX-Pdea
#O>?e1CB7M-ObLAU&DaFXZ9:0@#V906ZBK/^Z9OdZ15Q3L=03NLEMeVWPRZMA]YJ
N+S)<((5W_Q-VK<9SZFYD,K0M3N(QL8K.BV)B5eaX>ATU:L</SKdG_dI^R)ce_;e
:\FfAAJ]:(N>.S0:74]gD7K03$
`endprotected


`endif // GUARD_SVT_SPI_STATUS_REGISTER_SV

