//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_DRIVER_SV
`define GUARD_SVT_MEM_DRIVER_SV

typedef class svt_mem_driver_callback;

// =============================================================================
/**
 * This class is a memory driver class.  It extends the svt_reactive_driver base
 * class and adds the seq_item_port necessary to connect with an #svt_mem_sequencer.
 */
class svt_mem_driver extends svt_reactive_driver#(svt_mem_transaction);

`ifndef SVT_VMM_TECHNOLOGY
  `svt_xvm_register_cb(svt_mem_driver, svt_mem_driver_callback)
  `svt_xvm_component_utils(svt_mem_driver)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
/** @cond PRIVATE */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this class.
   * 
   * @param cfg The configuration descriptor for this instance
   * 
   * @param suite_name The name of the VIP suite
   */
  extern function new (string name, svt_configuration cfg, string suite_name="");

`else

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent, string suite_name="");

`endif

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS available in this class. */
  //----------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /** 
   * Called before sending a request to memory reactive sequencer.
   * Modifying the request descriptor will modify the request itself.
   * 
   * @param req A reference to the memory request descriptor
   * 
   */
  extern virtual protected function void pre_request_put(svt_mem_transaction req);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a response from the memory reactive sequencer,
   * but before the post_responsed_get_cov callbacks are executed.
   * Modifying the response descriptor will modify the response itself.
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  extern virtual protected function void post_response_get(svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /** 
   * Called after the post_response_get callbacks have been executed,
   * but before the response is physically executed by the driver.
   * The request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  extern virtual protected function void post_response_get_cov(svt_mem_transaction req, svt_mem_transaction rsp);

  //----------------------------------------------------------------------------
  /**
   * Called when the driver starts executing the memory transaction response.
   * The memory request and response descriptors should not be modified.
   *
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   */
   extern virtual protected function void transaction_started(svt_mem_transaction req, svt_mem_transaction rsp);

  //----------------------------------------------------------------------------
  /**
   * Called after the memory transaction has been completely executed.
   * The memory request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   *
   * @param req A reference to the memory request descriptor
   * 
   * @param rslt A reference to the completed memory transaction descriptor.
   */
  extern virtual protected function void transaction_ended(svt_mem_transaction req, svt_mem_transaction rslt);


/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  extern virtual protected function svt_mem_configuration  get_mem_configuration();
  // ---------------------------------------------------------------------------
  extern virtual protected function svt_mem_configuration  get_mem_configuration_snapshot();

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Invoke the pre_request_put() method followed by all registered
   * svt_mem_driver_callback::pre_request_put() methods.
   * This method must be called immediately before calling svt_mem_driver::item_req().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * Note that, unlike the other *#_cb_exec() method, this one is a function.
   * This is because it is typically called from FSM callback functions.
   */
  extern virtual function void pre_request_put_cb_exec(svt_mem_transaction req);

  // ---------------------------------------------------------------------------
  /**
   * Invoke the post_response_get() method followed by all registered
   * svt_mem_driver_callback::post_response_get() methods.
   * This method must be called immediately after seq_item_port.#get_next_item() (UVM/OVM)
   * or rsp.#peek() (VMM) return.
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task post_response_get_cb_exec(svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Then invoke the post_response_get_cov() method followed by all registered
   * svt_mem_driver_callback::post_response_get_cov() methods.
   * This method must be called immediately after calling post_response_get_cb_exec().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task post_response_get_cov_cb_exec(svt_mem_transaction req, svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Then invoke the transaction_started() method followed by all registered
   * svt_mem_driver_callback::transaction_started() methods.
   * This method must be called immediately after calling post_response_get_cov_cb_exec().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task transaction_started_cb_exec(svt_mem_transaction req, svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Invoke the transaction_ended() method followed by all registered
   * svt_mem_driver_callback::transaction_ended() methods.
   * This method must be called immediately before calling seq_item_port.#finish_item() (UVM/OVM)
   * or rsp.#get() (VMM).
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   *
   * @param rslt A reference to the memory response descriptor.
   */
  extern virtual task transaction_ended_cb_exec(svt_mem_transaction req, svt_mem_transaction rslt);

/** @endcond */

endclass

`protected
[SGA6LC?9TI4AC@[EF,EZ.M8>+6R1E4/Wb:PDVF?,d8X#7=M?EU)0)Z8C-8<MI>#
L2Z@8=JR+J9\fMEd]d1g(=0K\KTJ[II<SH.VA[G03?JJIK=;5-Zd]UT4Xe=fda_,
^5KK6(1?EaYY?W.OISU]7TN\^(b\,C6<aa6EH]8.LUHO[A?eQ58G>H5QUJ:af;XH
2ag)f8eJUd.5_-4Q>-78UDcGJad@K9)aPNEY?^#<05__0K;Hg)E;>;I<LIg7,?2X
54C-ZREE]1eIL+G_MQPPUfYb24d-8CKSQDOJ@b3:J)-A,@#T_.[9AS:,d./W-DEE
VPI:L\N\^6W<GBGRbT\+4RF-Eb)3CC25SK6EGWBH=BbN,EOI,0BWeAIF?YaQ2F13
Z#/IL/L^Q3>EGW7ZKCY;9/S1V>F937A@H\B9)Y09FN.eB7cd.;5ecf1F_cIFY@]G
-3(Y)(RNG8K&/c]>)OD+=JXdcE_.eI/Wb;0@]?K#cTb[8SU//N4#ICVK;f[VG;N5
4?6@6:OG6RccHZ,<F5ZA>&f9M(aeeEEU/[7(H(RCO0-[E$
`endprotected


// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
aPfb-e[G\62LL1F+IHA?T/-SN-5&ZeG[M5L,@I-AGAVW89W+5U170(b[U=A3\TI9
6RU[+IBM@76WHTC4-WVONYgH)VHTX)H0)9Z#KGD9>UN=Ia?DgWfW/#=&FP;8ffB.
5]LD/=OFe6Y503M9YO+WAG:X[T)cGV=1d^I]dJ]&2@Z[)eGSZOGG6I.;5:V,RRDV
c]1O69S88A./W6VIa=.bUPIO@W@.e0IW-Yd?Q<EUS#ZSc2V76+N\^3\bgG9^Q_?@
4==R4;=aTD98[GPHKcGdIa1ZC[;GK00JVHe@]<4RXX4?#CG@IB>RDCK\f\XXPN_d
.14\Of@fGG^E\^^Q>e?b]#6T3:,:HUO=bKW=B\)2-OA2]V=0DH@f_0Y+T0SX@LDS
S???CMZ&6C&C7E3MgQJa#-2R)\@Ib2d+Q&==EKW_VEL7M^5NK2CQAR-AV-VN[3@X
P^O\XHA(4+5Za41<7NcUAb_];Z4=gFMa;I4IbJEF(I.R(E=Z24[:,Hc\@Qfc:b3J
4T:6@7;EC:c-RU,eNSHeeKL&)^4(V7J=5;#@Te0EFg]7c/\?<QI8Q1/^BEEE^bbD
EO9(:/+2Dg(8+>-/b@>\PK=@@9R37A<f+T8_.]+MUWa<WYD=4I_](<ED.H+K_I]K
V-Y#-cf@eaa6PJ^Nc&U11]8R,-.8N0>HfU8\WGI03PG@0SBfBN#;&DX^B+)8;1;#
&TQBJcPE>:YEH=1+>e6Y:+(O&_I0(_-XAb<<SF&C285J489SQG]K4:PJYa0?d)#W
.4W6ZbACJQVUTX1](Z8aZ\RTUY2Z(H1QW&6aeebZ.FH&#52-HfDaB.=QH@W^D^(c
I2ZfYEZ<<BH0-5<cS&dF=B\:X[<@FBTD+B>IV/M-:A5fcf^/?0K39/-MO>Z:,15_
fSW3QW<UY>.GL4/PK>d,AaOV)+RP__KKOb=L93/7(Md<^3RB2]S,APUL3_<C4F+#
d[PY.W9>\aK0eVB>^0SAN[[>:EB<b?+gY_QZ_]E3<PcAe/[T[]N?7IZcOG+;g/I/
MV<;G[6GBf-(^+ce2IWPXeD;NM\/+3,A4CZ7?f2-1#^NWKNHX+?X(eLb;=L-?FcQ
^2gf6O4,K@UU[7)@MUUQSQT3_M2>@SLR,O]c:0R>S_[aOUE]SISPQ.AXf[/(?Ib,
<8&V3(cb\831J<^N<W/M;1e+aaVYMfRf^N/M9+#QSg26.0<=.4FPGSO,PTCc,LL8
f=Y4GX03=X:<5>Y66.Q^RE&SGae@Db7H+Ub,?J9;]HJ6L4RHW3#CGTMTQ3P&@=a8
VK9=aZ[ITYbRI(\8.W8RM]bb:<H?STQCdM(=W?U__3,H[+SZH).SE-):Xb<STIVN
K8X0<#M:Q>JfIV^Nb;I\U3230L1f0QH-YVX:2-#1FbGTE>H714??T2gMQPQ82C7f
Gd_cLA#35L3b,R7aQ)5A]4ENKUG7VaI^e6O/#0S5>Bg>UYY7S+@8YXK9)]ZLBG\,
d>N))=d0]2dR_#(I^BKP63fA9^Eg9S6^G\&FQ0XaQYV:@MBMQ^ZdU\)JdM3RDTEZ
)8b[D]FeD9bK\X&FRYQ4fd0a=AU0@,\D5]Z:(^5494C9@)FD,..;A)H&(H?V@A/<
ag/I.cTW&UbPA_V:S\aS.?_Gg1-6QZOCLc+6_BTFa^eY:7IXUdXDNFF7\.DdbHf#
,S-(FCIe,#,Lb<VPU&Gd/\H,TWdd@Y+3aAMJ6Jf=/;M5OX1c^W2?,c.;dKP7]W?g
#dYc1AT4CWT7Jg0]BXWQcWG8?9dT/a?QTg7YdcY6Qg?>bUR^894\AQfcRaBS;3^D
fC,G7C1d-ROaL?>@)a/,(c78VcGf,08D#Cad4EHU2FeCf_#KMZWd1=Z=R;Z]AJJL
0C[7VP#3:F@999Z2fdc>E,Ab[=_LeX7OID)B^N=QC2>W^&17O=>4AN.9+DbI#(0<
ad=@F+^-P<09X]2b9FI/96E>]:PUEY,?/#g];24KS7<be2fR,C+fFY3TPeH@T(]U
I4];O?]e>\#ZbWKLF]d(:FT?ZRL;NKNE&C)VAfVZ,a+eRe7\UIBCN1cN=W\.JgaU
JQ0B]N:,17MC70+#JH@Y@<BZ_a(QcVCYF3;\g4?FOT@-CX]]=&4]@OX3^8,Cb2ff
.G)\MW=Jc?)g(Z>T/5C^:&F9Z\R,XYZWJ+<Z-3P<H(/a?>f]STJ9C/XMP+;/VY>9
0_g.e@<OW&@#0L/>Y3V_A#<;WPaESUc[47>&eX+;@^T\e\)CELa[<MV<X;=F-D4V
?NMXZ7>[9_>dAFE)^LF(AeAV0&<N-_.@:,+7)0V1bX_>?QYXR-78G&:#[5MM6J6@
5:S^dd?g+<FS=:_B[O8R)FZE12)G-Hg:(5a_WE#X96g,cOI^EfZ^B-SDJXKea,Y3
V]Y_\20,8R9\25,T6#,R^[Vg)][f=&92gL3@5I;L>T+SK1>J=EJ9\]@ICE+eJR1V
95:B\DgS./4DegD=e1\X&+BE);.@Y^a>GMUf9PV^bH?KUf\<>G4G/(OII7eE[J,?
Obc^0CH[ANA-&=W-NW[<a,Y,_);C2\SCHR;\YS6>)C5aa&DUV_O6aX<M,7Q2g7cO
ggQZO7J@T=Tg>\/WV\ee?1-6Qa_dVUZ\8&22c[DK);-FE9@=A(9(22VKF3[ZP])5
F_0YObF<(D2QB(cS_T7KJ(\Y<O@]Va.NHCS#_>:0^-(,J;@dVWPW5O->f9:BA\UT
>U3^B(NK;UP^D^+HWZKN\4[,aFJ-Z>_F)03I65)Sbf9?29S:g0^(=Sa3@/9+_1aI
-:V1CBMZ32^HP(56@24<+@&)>_7Z2OEc4>]d&W.edZ3=;7B?>#fY[8c-eWK\H7I&
N+JY:P3.YTR82:7+K\@?>/9e/XdbNYQ3a9?EG;?A<YRc2RR@_Y,a3&[HZOc=E)J/
eB5S\CAEA0\AU:RL32G4LF@>9+cG+2U:,&MBE([YN[H4HY/EF@^OcG?7V]#:2fQI
&BM0=b9PN/8ZN8Y+)#U^e23=aWO8XHXI(<(I^7;1\HGXC0/?g03,92.?RT>WTE\7
N0e7DUN8N5S-HdI_DeW_7(D5<34M9]a163]A.D@5/aT&J1@F)<5aE[BRR-GgYGIN
0][]-X<0>Dc5d:SH/.^gR;eYA=(K>HXbB;E)>(9VE]&&K1<YedM;.?.cHcB&.<N[
g.>DWeCfNN(O:,+UV?f,_Xb=IbJT#_/Lf..0A+]5LFJb6RKe)e/UPM[Ydb]_)&Mf
7]8X,c.NDM0=QOJd1XW29dGbFV+O/R9(&\7+H#J>bR7g9GD\^_>Q^-)6-CdU2AO?
SHF0Y7_V<XEXI)I29,4-0[d==H;E/#T@18@QR\D#g@B:EW1=gC(Z01AE3dEW.(2G
@MM@38#1(_CD3S(]_;3PWc);2cU3^27<a,DU\@5M=QZ@XU3+^]:=e;#C=OI;V#;H
C9T_94e2Y6Z+ee7-4XYaN2AIgB]Y5&_ILG7/dVaJI)V)5@4:B01?+(2CFJE+c-cU
f<Z.2FIN3geZUa9]0-N)_>3@-GgJ+WR4+LEIH2fBY2.;&c9K9.1_>9W26\M7fJ-(
(g?@^U[&(:M.0\M+0&]^9@P18J1#6R+.O#IMU6?G)[65NM#bY8CMC^0a0J)OWUKV
NZId5/G>aNc^^(+VE1LXIWCTV+6PA@]C#D1M0UZK^4/41^A2=Xc]9eNK2RA9^b[a
fH.IQKe5^d&bV(_/98U54f?O,]GS6B>0M?5+==@[Y-\=P65T7dMCWR/8:[cJ(\F^
c:4(J<-K.(>N]/E:RLb#_d#bKZ2S+&NO0=bKM(NMQg6c4\S,:0E;)L/&WV;Z+1=#
P14XOMe^X/7;NCNN6gVQC1G_UA82.(CAVA4Z&4b<Z@DA^DePJ0H01C5Y7^6D:@8]
aY,Se=:[e^>e=;eF0Z0U/WU&[3U(3K::Q=UPBG\QaU>P5ZCSOcLc(g0^JRMMH4J2
\GSO0D.bf(JSXKf,/OV&+c;dKJJ6?gVS9I0S51>71YAC8Ic^:.H?X=bG6g9g6]4O
LM(&RK-V]W&TKATeM3+dZ+96[.WWe6C5[#We5C29;P-K^@L=</Od=M3J5M)92<&N
,^_.6T)?&M^.Q[F,e#CGPd@;;3b16_C6&\Y;-P^I&983C1^CK8LWZIBQHR(MgfW_
fO3\^NDNLd3H@_8E]Z8V4Cf1ZKYQ7-HccSTb6J>.HF7V=eR=E955_&3@XCNa)(\]
-<?6HM;fB?P/#377)2<:^X&/:IKG-B14UaNB@ZA>A5N&I6_YT;QeB07=INbTR+:L
S:A6YP=-f@=(e-NKX2WHZ=[)SQP<SEDBN1N[O?J8g=fV\dCMR:N\(JZ4:8,8(AJf
[0__0^UUKcH<T;M&g?U@V):CfIAF/9dE1b0YB6T5+^TP&\AU_CU>TD=U)QH)/I)e
=8Q?8B&X/#KdU;5gI[(QVR_&A,2W>BR3E&](JYd;5:]4[,0Z17GG;WZA9gHZ11b>
ZfAXM4aJGgKeSd2e+fbP-)YPTF--@,^^V-/,CQIA(Qg5dX-GfZYR5fB)5C^d7=f8
#YEG)VP32NP5e?eM<E5.GSc+W.R6[_2->_)<=2<eH]NUgY4c;)fSJ(+Z+QJ>G]B3
3ZWGVA1XTA?;II&.)+I_H@--cIW@A@NB6gJI-(KLDZLcSgZWSCPZ&(^\[WAT3-6a
2XQ;2\W1Y#++^PJK_g(Z2fNNa@UE.EDa>TZ?ZXJ>QZ-bG[QfP4+\18V7IG5#C:XM
7;Z3^30O/\H;QQH#U(9[0YAF3L8eGPFN=aN/=Hb6cH8I0[R4K6D^XbR)>II&?NJ^
8,.(H<H[J>4XR#)b]E^35<^>JM:DBLQfe)9XSB[82G<KD=^V@JgUdXc_B1,D;G9F
\YH4GAH_XPa[GZW>/WX:eDKI3PA/ZR-.@3FPS1dE<3EG3Qf<eg)5FH:fWU@UeeTc
2-AY#EKdaf=HX3=0R_?b4B&](U^R0G]R_-2d9TeYB2HQQSgUKQ2dDHDF=@](N58\
9B)^=A:D6+AS9cR,+LRc;R9_L+-PAd?3cF_@8F>DIaT.E[N^+6.EQ;#/H7N^5#:\
J>P(J7L0W:M5Tcb&BY35NM,Q7AIWM1bG^3P&7-1gQ@TeALR)A.O0/X(5eQLFU2[3
LC?C;</FdB6;=SX=3HcHGBEDHB[Kg-f[G(g4\QBQP8;c&G_R/0Zg37fa3\&W4J6^
L+>K;NEW.<U-MAJa\d[M(^U^,6&c^=,_NdV7c@IH6],Je()V0+.d9dfB=aP0WZFL
YHV@WISL5fJT@b>a7VTW0=fQ&U3,#I^+>,Oc+)WJ^,UY/_-f\0&=HJbB(IEF\Q7E
ZH]@;V>CagLI@RL>P<9SY;?Q8C.]BZQBI28EN&FSfSF0ZKB4&U\8IIg20EIa:R8W
L4gT,HY;f[@)IR7EK\BVCe\6D7-.KT3JHEMNA6SB^5Md99A^+_JI.M#=NLf^AT/c
2eaE1)K.g<O=:NPET=HM=)&?>O_.1,:d^JcG3Mc0>EV[+H3<f=1]=H2;23cW:FT/
9J,/F[JaUO)9VC23,aD#QI1Y>25-[SDU0\M9X)R=;N81DVSCe.A_KRbC;K)J6V)=
?+N+_\PZFdT,;5VX#0#O#:CEeT:B/G8[Y](6WCP>W3VIN,JQ^.LAP/7WE7_<?ZHe
E55OA43_O?\V8U[7gX9GJ<S=PSN:?fOF9XU9YJU[b<PH-]bfQXHELNO;3(S(fOD?
#N2Ffe5B621@3./c#4Q[3B>T_b#^0gH4We+YaQJe>_#<MPOG)XJg]=fQNI8\::@D
/#Ua](N2_K4bDQ8bQAK5U=0^F_HTG]M(4N;/_]WZ1,_8KFCF/./31J9>-XDQa;8W
f9+AZd=7XdE)GbYV)-9E-0&#I>?bI^XN<]];GKS\.GJY[-GSP9E.PC:gDUX8EC<7
?=.[g7d?6CQD)J6IAD:<4S()T1E,_2Q[U80T^5YNNX\F357@I7UD#Dc46J(B<&)0
7I/\U(5^R,/\gL6Kc?]+Q(?V@VS1#g726.4c):K/9g/0I-X78515d/M=&<aOW2LA
E[2bWgWLb9K<R77f)U;U&/.dI(A00N4,2OJG(CEPNcQVWTT_DIJ/CX(f+=/WCQ,(
#Hc(-@9\V0A6X(8FE?f[ScV)41HAd/;ED]=DX:(WC5&VaR:K3a8aTQO1),1)4;d_
((V;SZI&GGIg=KfR[2.<4-Z-+>)>:&AKZL^8>=(SdFFMg2>X(5A,HJ+\[#3<B02-
C&\eLCe^d96UUI5I6.4IE17HHP75CD=LH+7,><?#WIWG+g(JVZ?]XRTReR/9[^PK
)4<Ga1N<F[[W.+B4-^D.W]4)I=1Jc0/J:MWdAH<PY/0K[TWB5G5_H_I9G,0T544&
ZYCEa46+CXR7.]aPIM,/,fSGPA.PDb?Z&M&J-Hb<Xg-6>F10T[HGbGOIc=06,\D;
d3@9dYcgB^:RO70#gQ=_4-DdVZ^GO)C4:G<6+eLf#.9=H>f.ITNF5@>b?UL)/8UM
YZ37#F3CaJT#?<C6D#0QK0B1bJb;N&G^1a@/HV0Y9<W+5?#?R[WH\]f+([<0L2gE
IS6fZLPf456^9BRYSJL()?IKUJG-3DYeD/CIKI&E<#Q>.FFQg8H7&(SSWD;0<WFg
eL\OENJcV><IefG\KgA;R_6\963I4U5b\->3UMTQ1[01P^R>0.>#L9d(@T/\AC?O
@^>6-f10K]U.?H[&bg<NX8_BJ.5U(Gf2DV5cObU0H\(Z.]5/?+g4YD0.AP>bS.KL
_(IE:)(b)4R7d.(Zb:b@?<7.UP)]:Eb6YED&&ZO0gdLI@0SS1&(1Y]0.N$
`endprotected


`endif // GUARD_SVT_MEM_DRIVER_SV
