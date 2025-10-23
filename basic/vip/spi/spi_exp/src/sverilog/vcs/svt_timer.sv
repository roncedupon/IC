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

`ifndef GUARD_SVT_TIMER_SV
`define GUARD_SVT_TIMER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/**
 * Macro used to check the is_on state for a notification event in the current methodology.
 */
`define SVT_TIMER_EVENT_IS_ON(timername,eventname) \
`ifdef SVT_VMM_TECHNOLOGY \
  (timername.notify.is_on(timername.eventname)) \
`else \
  (timername.eventname.is_on()) \
`endif

/** Macro used to wait for a notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for(timername.evname); \
`else \
  timername.evname.wait_trigger(); \
`endif

/** Macro used to wait for an 'on' notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR_ON(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for(timername.evname); \
`else \
  timername.evname.wait_on(); \
`endif

/** Macro used to wait for an 'off' a notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR_OFF(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for_off(timername.evname); \
`else \
  timername.evname.wait_off(); \
`endif

// =============================================================================
/**
 * This class provides basic timer capabilities. The client uses this
 * timer to watch for a timeout, after which a notification is generated.
 * If the specified activities occur before the timeout expiry,
 * the client can avoid the timeout by stopping the timer.
 *
 * The timer also accepts an optional svt_err_check object at construction. If
 * provided, this check instance is used to register a timeout check and to
 * flag successes and failures relative to the timeout check. 
 *
 * The timer is started by calling start_timer with timeout value. The timer is
 * started immediately, and allowed to run until the timer expires or the timer
 * is stopped.
 *
 * Once the timer has been stopped or has expired, the timer stops execution.
 * In the total absence of activity, the timer will not indicate a timeout condition.
 * The timer must be restarted by a new call to start_timer(), or by a call to
 * restart_timer().
 */
class svt_timer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Pre-defined notification event used to indicate whether the timer is
   * active. The event is an ON_OFF event.
   */
  int STARTED;
  /**
   * Pre-defined notification event used to indicate that the timer has
   * been stopped. The event is an ON_OFF event and is reset whenever
   * the timer is restarted.
   */
  int STOPPED;
  /**
   * Pre-defined notification event used to indicate that the timer has
   * expired. The event is an ON_OFF event and is reset whenever the
   * timer is restarted.
   */
  int EXPIRED;
  /**
   * Pre-defined notification event used to indicating a timeout event.
   * The event is a ONE_SHOT event. A message is also issued, with the
   * severity of the message controlled by the timeout_sev data field.
   */
  int TIMEOUT;

  /** Public data member which can be modified to change the severity of the timeout message */
  vmm_log::severities_e timeout_sev = vmm_log::WARNING_SEV;

  /** Log instance may be passed in via constructor. */
  vmm_log log;

  /** Notify used by the timer. */
  vmm_notify notify;
`else
  /**
   * Event used to indicate whether the timer is active. The event is an
   * ON_OFF event.
   */
  `SVT_XVM(event) STARTED;
  /**
   * Event used to indicate that the timer has been stopped. The event is an
   * ON_OFF event and is reset whenever the timer is restarted.
   */
  `SVT_XVM(event) STOPPED;
  /**
   * Event used to indicate that the timer has expired. The event is an ON_OFF
   * event and is reset whenever the timer is restarted.
   */
  `SVT_XVM(event) EXPIRED;
  /**
   * Event used to indicating a timeout event.  The event is a ONE_SHOT event.
   * A message is also issued, with the severity of the message controlled by the
   * timeout_sev data field.
   */
  `SVT_XVM(event) TIMEOUT;

  /**
   * Public data member which can be modified to change the verbosity of the timeout
   * message. Defaults to the verbosity corresponding to a 'warning' or 'note' message.
   */
  `SVT_XVM(verbosity) timeout_verb = `SVT_XVM_UC(MEDIUM);

  /**
   * Public data member which can be modified to change the severity of the timeout
   * message when timeout_verb is MEDIUM (i.e., when the timeout message is a
   * 'warning' or 'note' message. Defaults to the severity corresponding to a 'warning'
   * message.
   */
  `SVT_XVM(severity) timeout_sev = `SVT_XVM_UC(WARNING);

  /**
   * Component through which messages are routed.
   */
  `SVT_XVM(report_object) reporter;
`endif

  /**
   * Identifies the product suite with which a derivative class is associated. Can be accessed
   * through 'get_suite_name()', but cannot be altered after object creation.
   */
  protected string  suite_name = "";
  
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
_(f?1.3B.31KKT26GM[GK455cQ9g5TCIdE0G1_(ZBcaP+]L1R@;.0(CFb6(90V4E
10RJgQf_YWR@EJe4L(#P8\PG^2gMGO/^_Kd=c]_TeXa0M(?BOfO+ATTeB_J^C&_g
]DTY\YA_Z/@03[,/C/fD@a]P(IMEgd_QH>V[c4::RXHXN1a3^8Sg-2)dZ;g;fb]0
aRc;6IUDTP8)BQ.L7K@1=4]>A<P]EZ;>5^)K2U+>>T2[D/G55F3:KV@OL,VDPbe#
(NZPU\ZRT=B+/@Z(RU)GQ@IH=3Z0fN&Z#\GL\,NT-.APc0aaab85I/7>>,,/<D(H
8EBPWPG5B_GZKNK+L7WZNV891@FV;BdVB7ZWPEgEBPYf1\/B[dT_.D^WY[<.C9Fa
e.[g0C11fAB&S:8E]O)Jf,Q;Sc1CW)<9WV]&IA7CG>\QR4,F\W8L>Y#JV3/.9P@-
P(\QTX1;EJP2=F-Q7&eZT-[>0Td-D+3\)0#gSf>ULZ2^a9aabZ7B5\T],H6?(]\2
#-9S#?3C\;:TVf,QfIDCJCZY8U/d9E7:]643^_6&#g@dV.Z\fJD2gL)##XgDc@VO
@A.#a<;C+L0]>F#1dK7IO,X;O)H5^LF(AVY0T6FC&9QS&T4VZS&>EGA1Q(7=\97^
^)8SgDbY\MEKYTN/2.C7aNQR]P[0IX.4P&&YJHdP=T#G8CfQbRR-&K7A]0,J.::X
[GWN[P;17&H)5d15+5J6P=a4g=<Q+(@+DCTQ/,[V>HA+e\\.\]+[US/0@a[J.aJE
Y?Y_:GLY4?8NLK^JK+],5N=Q:[L8W[8HXHaAHYH_-:GTEHXEK@&,_KL[#IIES1.[
a3c8e/4aJJc5/1>cX;S0(4HW0,L7DbGU-7FbD\^B9gDW<^976[@E09F7S?9.RKH#
8NANaa:?C+Y#-eX:J/a@BUIHYIe5OAHSe?,fH\AGN6^1fR)/7U^87dW=3(c7]XM#
NH1baW&SLLY<IQ/;&RM40F6V&:L,1V&HeTe?X#=NILM9FYO;Q?L8g8_^(^=Z<DGD
(DX-;2N825;3(<JO?::d1c\ITK15O8:72[^_,LK1PbaDL?Wf3YF[P;65#W>9>feG
Nd5\XC)9MI?Y))[UfMP]>Y-<E,Tf&4Tf&OIZJg)LQAPK,](e4V)P+7_UH#E5@N9@
1PCDGS/3W/3S)g2U]Y&HAec#eS0.0g3IJPKLLTC]_N&IJCbLD9EAf7Hf@25UQ+52
;WXgH?IA,8:Q53f2?f11.F7=.0/KOS1&)b9\d-Z+\d6Q.c\WTQb4?AWHf7GE=#&(
S[@HYA8GM6^^5FM:EY7T91,LBZ-VW9Tc>5EI,E#29J<O[67<UY6@KODJPc:AaKKB
65-9(Lf2_T_,_PFSeK+LdTGCN1a>@^9Ge4N(^NJUI4&cI=7Y;@KZ/9]c,J<c+dAU
8Yag5U16U(HE;.;U0EN(Z=JARD.V&?,bI_=.9fZ2Q:b?K?b;W]V/OCb-B&>)D:O#
:QJH7bDf2?4M&f8;LD2RAST.)3[#d5M.+6B.2(?65IIc4WQEBKPX<LWZC/R?c(27
2aKP86_8AA0TYN]OEK[0MUd@8I/V1[MVW&P_:T_Xf5])TNeb4Q7)dG(YR8ND1RU1
f:_6fGMGK,:=1BD<JF;6Yc#cX8^&\-aRD3)0fV-&16+H68a-5,SN70g5B;JFPfAM
)UGLOa8#8SYW/T_K^-7]W/[QGE5;]fUHCcE4NbcNHLGeJIXNeVZ.)JR]+_EQKD/^
e0-L#3BR7FL<PXRC2YD+R7DS[aZ^gHHSA_-Bf-e\gELN?3]08EC7D8>d-e[LP-S0
QFFDVPGPRO:QEUO#7.63f)bJDb=)/R(@U@+CZ.+/N8K3)H9Ug2-[C#A=\N]JQ1Bd
aH\DT8-J-ZM]&X+XVDE29.3?\<C?U>;,F@W\<IXNOC8XA]\N>:J7+M)bVeF:e<Cc
V(LU1#-_/R).B69]7]X^9]O+))E^@X-_S^?YF1])[Y+<[(A1X61GY4VZE#c+T217
RGXC=LB:g#NM^BEb:\,WZU,g_(PJ#A+=C,A4W>:#5&Nf>?0Pe/E5:ES]NfWD6L>P
aJQR5RI^JFK0Q^)--LCQCXKQfc8HMW-GXBE4ZS1+:FY/)PTG^]),OUMJ0]WSeR6G
6\OJJDF\3]N2-I(d[_I_\:H.4OF9UU5,4])&:>/(A\M?Z(OG.K:XQKgS,E1Q=D@O
5Z]QZe;A4?[a2^TFdF)#BgD-4Kd?:R@fJ^-&dT]1F-AB<([TTF[19.QX)[Qfc+/1
N+Le991^BUVaD7Veg,GOU<&H;@9S(LV7I)8]@1a2P5DdO20fO]Y+OHU;,(@T,abf
4RHYc1YPH=:4N3WK>H/.FR<,fWKFL[JF^0P](<TXg8^bI+=4;\36RR:ENUe[;D)P
H<R1I?<+[N72a0&N=f\fM\VZa,U@#1>Ug;O7YgPad97(]8/\\A_PK8K/,-eV?JeO
MUOD2_583\+D5SM;SZ.T=RB+T,P7-K.(PMe07G8;_G,[@9:T05gMZdg4JOa@KL6?
cI(NZAPY2G=1B.J->N1K[NNd>PHFb4[a-<?DJ:KJ/LCPV>V\+/]O>?GTEO=^1[+g
LDP-8;1d[Q=(S4T+84-4>@D57He@7]KDVg^9]NH-a-^6:[\]9c.T3^H-OHXaa01@
4I9-S#&PY8(R-B;TY@I3WUZ]Z0:[HLBg,JHJ&OR30:J<(:R[Z<\c8CVHW5^W+8(G
1c)a;f\3D[-:ZEV-@T+D9BF?c&]b9[T4#S7gP8?JAXO@SW>eM46)KW,2Zc]QR-P6
A#(79[S7@/D2>@V9;P<5FBgEIEMb?#:4Z[U-bNY3DQ9gbI>O5J<6E+#XTNK&a-#2
J\VF)H5XE9QFI>=@<NFT<?@2Zf)E0C8AdfdcVY:XG_-WVeL)JgK@=]5XZ@(?9EeV
a[e))?7I?K&>R?M/STX7=_RA-W00a3?Y>bN&S6.V3f98LD8M0G=F[=:+Uda.LXXD
92,,c)D:P<;N1)BMK[W,c6D@XVU4/#3UQ9#gCQ1cb_AK6(d[U,DO^=H3;#3:T:D/
OG4GH.CUO:R]DcU07;64?c[D,)UHb_(V_=bWW:1gZ0>,7VI,B<G4c[S7IdS>_I_C
SL0Q]+cd9B?,E0<aP;4WP;VNAP&Y8H]G[CE#?M^c6M>]H9^bd9BY24N6-8a=YcSW
8K\H=^^fZV/&#AGK?]1:)/fN#2E0DOV6=Af@&(g@6[ZZ8]>@Z/_RJU/68.#VGF:_
G2N\T=AF&POW:0STJNFfWIQTYW2JZ0\NR0,.17NX6eM8F:b[Q[]O\E0aT.CLJa>4
6&LE1534gAD(C8(Z@5I4aT?9N1ALdLA4>YTX(WS&V6C5&>+#f../,S=gVFBVN>I_
>/8LeA.@8;<[.RcGbZGQfW7>,N_5?fd85Le>,#QV6aA5A$
`endprotected


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, vmm_log log = null);
`else
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter A component through which messages are routed
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Resets the contents of the object. */
  extern function void reset();

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Initialize the contents with the provided objects.
   *
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function void init(svt_err_check check = null, vmm_log log = null);
`else
  /**
   * Initialize the contents with the provided objects.
   *
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter A component through which messages are routed
   */
  extern function void init(svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Returns the suite name associated with the timer. */
  extern virtual function string get_suite_name();
  
  // ---------------------------------------------------------------------------
  /** Sets the instance name of this object. */
  extern virtual function void set_instance(string inst);

  // ---------------------------------------------------------------------------
  /** Returns the instance name of this object. */
  extern virtual function string get_instance();

  // ---------------------------------------------------------------------------
  /** Returns the current fuse_length. */
  extern virtual function real get_fuse_length();

  // ---------------------------------------------------------------------------
  /** If the timer is active, returns the current start time. Otherwise returns 0. */
  extern virtual function real get_start_time();

  // ---------------------------------------------------------------------------
  /** If the timer is active, returns the current stop time. Otherwise returns 0. */
  extern virtual function real get_stop_time();

  // ---------------------------------------------------------------------------
  /**
   * If the timer is active, returns the time delta between the current time and
   * the start time. Otherwise returns 0.
   */
  extern virtual function real get_expired_time();

  // ---------------------------------------------------------------------------
  /**
   * If the timer is active, returns the time delta between the current time and
   * the expected stop time. Otherwise returns 0.
   */
  extern virtual function real get_remaining_time();

  // ---------------------------------------------------------------------------
  /**
   * As the SVT library may be accessed by multiple VIP and testbench clients,
   * possibly with timescale settings which differ from each other and/or
   * which differ from the SVT timescale, the svt_timer includes a scaling
   * factor to convert from the client timescale to the SVT timescale.
   *
   * This method sets the scaling factor for time literal logic. All clients that
   * use svt_timer instances must call this method with a value of '1ns' before
   * using these timers. This calibrates the timers so that they can convert client
   * provided time literal values (i.e., interpreted using the client timescale)
   * into values consistent with the timescale being used by the SVT package.
   */
  extern function void calibrate(longint client_ns);

  //----------------------------------------------------------------------------
  /**
   * Watch out for the EXPIRED or STOPPED indication.
   *
   * @param timed_out Indicates whether the method is returning due to a timeout (1)
   * or due to the timer being stopped (0).
   */
  extern virtual task wait_for_timeout(output bit timed_out);

  //----------------------------------------------------------------------------
  /** Method to track a timeout forever, flagging timeouts if and when they occur. */
  extern virtual task track_timeout_forever();

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. If timer is
   * already active and allow_restart is 1 then the positive_fuse_value and
   * zero_is_infinite fields are used to update the state of the timer and then a
   * restart is initiated. If timer is already active and allow_restart is 0 then a
   * warning is generated and the timer is not restarted.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   * @param zero_is_infinite Indicates whether a positive_fuse_value of zero should
   * be interpreted as an immediate (0) or infinite (1) timeout request.
   * @param allow_restart When set to 1, allow a restart if the timer is already active.
   */
  extern virtual function void start_timer(real positive_fuse_value, string reason = "", bit zero_is_infinite = 1, bit allow_restart = 0);

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. For this
   * timer, a positive_fuse_value of 0 results in an infinite timeout.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   */
  extern virtual function void start_infinite_timer(real positive_fuse_value, string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. For this
   * timer, a positive_fuse_value of 0 results in an immediate timeout.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   */
  extern virtual function void start_finite_timer(real positive_fuse_value, string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Retart the timer, using the current fuse_length, as specified by the most recent call
   * to any of the start_timer methods.
   * @param reason String that describes the reason for the restart, and which is used to
   * indicate the restart reason in the restart messages.
   */
  extern virtual function void restart_timer(string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Stop the timer.
   * @param reason String that describes the reason for the stop, and which is used to
   * indicate the stop reason in the stop messages.
   */
  extern virtual function void stop_timer(string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Method which actually implements the delay. By default implemented to just do a time unit based celay.
   * Extended classes could override this method to implement cycle or other types of delays.
   */
  extern virtual task do_delay(real delay_value);

  //----------------------------------------------------------------------------
  /** Block for fuse_length time delay */
  extern virtual protected task main(bit zero_is_infinite);

  // ---------------------------------------------------------------------------
  /** Returns 1 if timer is running, 0 otherwise */
  extern function bit is_active();

  // ---------------------------------------------------------------------------
  /**
   * Set the message verbosity associated with timer timeout. This method takes
   * care of the methodology specific severity settings.
   *
   * @param sev The severity level to be established.
   */
  extern function void set_timeout_sev(svt_types::severity_enum sev);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
0#Z]@AO>C3K9;b]89SWCFCDf0MaV3aa1[>009O^=.,D;X-<?gaAJ.(gCgDR14#,N
/):2,YN45gGXTZ9,,Y#CJD0AN5YGEZK^fAI_?X7LAcaGZ=VY[;YYZ0,0UW3a:-N9
[000UI0L6)X00#Z><JdGDdXJgCf_3X2ABH<L,HWE-6_bHL\_@PbJ>=5.L-J68K=X
9^c74RMLDE\eX&aG,6KgTJXE-Q>UV1@EKV7N\+,EJ1M]ZA(Z&WY.c)N^A2&JU.g3
?S0WeFWA8c1@O2g=<AadBE0\e)[V;^J#Te.W5M<Ub=]2UQB7=X.f#T_#Ac>RY0dM
#Y>e1T-C.JfgfMa()877]5X,^^08JI5>d@OO6Q&A:0LNQV\<TXa?.FGOc45-=8.:
efT/&Z-F_gA.A#?X4<U>c,.=LgFC::f)KA(P@A^?#-]4+X3=B2+WA6>C[?W3a]H2
g8dL7R:WA[K.6(@b#+\=3^B\)57-F./2fefY;8^4@2O.XW2&VLDHUM(HS_<@NbRf
a&@/#SO6M<?KX2bZf;03^Q<?B_eOX[ZQc::N_VHa-;=TDfR=I1X\;I=\80CGeATF
1DMEY_W/a67(+_ATN+1U=C_.c]N,I>36^Y0=B.LJ/:VHV.).>1I5gacbE[NeCeAM
2KJU>;7#(&f.8J[MeY\QP16J<?T?@0;F(^XY=<5=OT)Wb6:B35Zg9A-JO_(IN-W^
TH4:5C0e/c.L8MSZQ?5H0>N/V;)Y]P05XN&V27J0Rgcf[H+9W6=CM7_)F#I5#]G-
@POLLWeEB)L,<E6DK79&T1PNCb/DcJ0YG8>6W)AC0W5PZU^cNa8>FW?FW86.@IML
<]?WRX25d#7WS0R-1SP7J+cb@2BgMCU>.QRC:X6^(70]T9fNFT57#EKIA=_fYK0F
:_JY/VR/=dOWQM_OWZ,8#,1@[8[9bXP;Z#4,R/M:O7;I<KNZIYe]]=_T]OI:RQL6
JGA.#E03,H1c.&G,_1OCg-dP[OXXC>eV3)HJcQ.5:2KPZZ,S62)H+U>\e50^-0Z=
=AIL&HVKb\J8aE/4S.@d]?)e7?9H&a_5SZO&gd(a//?b1@GM#g##U3P[Se0QKMg<
LH5+HUTR3GGE8T)=7D>+S\R1)HQLKG=Y\c6VL.J,b-73b)TL/L42O>9QbK?5&>_4
;]e9Ic+4QI.0EIPF4OS>EP,+I+.Wg\)(e.&#BZ\-:/+.=#ebd>TC,(YQbHR5HN_6
=EOG6Y2>eGBPCUM&0:AAFe3MM:.4L9JK73Q3-H[I\7MK,dJV=F0?PDDUXd<YM;;U
DAfb0KD5G)Q/8dY,#LR<+TJ:#L]3.:,#UU(dSHX4_Z2FHTd\5C>:995W3bE^7+24
J)]KdSgZ?[#I>KQ(NM3a&^S)>2E^:@5]RAV9fe-L:U;+2&F9L@cPgT36c-2YgHKe
LTCXcE??8:g6I/C@=^+5f+97U2f7NDT(I<U\g@CFY4EAdGeCM6&)L;YN&ZEYEcHL
?A4I@99::UB]fc#<(DUOP2_Dg9E?>;W+/>3/:5=MfgUP294aDHJSXOR1a9.bC[QH
g6;)L:?Z.5FTKHG,@+DgVAO5If2E98^4@?5dAU/Q0.[D6BWN4+^4A1@6),(HW-cT
&@3(1:2<OH;0?A8-&])KQgDc&5N0cUS_A3O^H&eBe+PX>eM_<O#66&<@aLVQVEVF
8+)N(/<.AXW78HDQa,\Y_cYC\V]_6Z-K4aW#OZ=#9IIB7&,FZJ_IFCOQ+fR9@W<)
Y7LN]ARUY]:BUEMfVFcAK\@)9g8_(,FG>F52,9OPSXH[1B3\+4=(_=c1>FQ9CM,\
RVSHGac>-/MC[dc@EQC3W_NS8T=#P+OI/7S#QCGMNLT=C;LU_-<<6Q?9cVP6g&/e
NDdcJ&E?U1<IZ;FX?L+ZB<?\KHX>J)WH@F;(K#R2)=?K_&>f8VQ>BH4gM:K59/BB
H/:I5J3H-5G\g]gBM1FfHI_4207^K&ZcUD-3D/?Z):>BRbT5BN6OO8R>1PD:PFbT
Z=,/1B#T>O];BG4UbFB-_QeTI,?_#/YMX;<[:0&?:6E2-(OQ2\+/0V5K_;U]RXI=
EE-DD>+XR4BA,H\VZB//:[(4TH\0b_9Q#dW=M_(QCIA6g#L1=DTH)&035+FOd7D:
c4-_eZ#9cYd+RZI+C96<>=D[/@3D1f)#QETf+V:XV^c55K#Ugc8]XW;P(6V;./,2
DK<JA/L)T4ZQFefP,1YV/462\LbP0Wa7:QM&B)0XS[(W_I=Fe)\C;XNGga:;D37<
FU?d_V[8?dRT_5-T_c^40_b=9Ia27WF3VHg&[)<H(6])DaSbfg^1]?Ja+=,^\(Y>
G;b-[;Z[4EJ7)d?VW#>DEI><+2#6A2W/JSCMc(+88JfIcaL/89;@AG@N2;HQFI^0
8gS.AVPFOUFV)8XZR7,dL/RW0=^V[O9G2WG3-J0f&T,1A+XE&ST]-<9E23DVUX#;
0F>e]GA4Af@;M;/9JN50_abFFVIS];.:=K-5&_T>GaWfbHcc]YIM8W.ffR+E@4>d
_A>Z/H&G3BdEQSRdQ_E64[Vd/=UJ2F_eJZ^XeOdU]2-Zc3[5C-4K[7PaC)2JdSTa
KUZCgb[MMT,Z;+5)P9g.[2Y/3^\#GfaIf<L-+(T=eY)4PBc59fMSgBO5\(X5a+Fg
2[QT@=QR_+:0SWe(a#Z=5e13J1N,8B.4b#6V_@D]D:A05CNef7:e&6KcEc+[K-S@
/HKPgRQ,2X6adN7+/MFAc:C1b:(d-PAWZT[]))M+G6.OHEJ9L@IDWd.M5?WT.=Y+
->a7A+4[C<#((Q#CWG73A7&68MNHLDaB,VE-^G[I0P_-5e9D;W(CNf6PRd92ID?:
+;S(R)9J<bf9(\geYX5bKa:I]R>P-=8>:YZBZ?/NA1>G>_bKD;VBWLAMF7U[S^U[
eM//T8POWCAc(Pg\7E@Q47WQJ;1@<#KH15_^I/L05NK6<Lb<@HfBNA,F&AP1I.<a
@d[B&]]^1L5d^HL6cPV,5//.@GVBK9@>/8M:JIW2XaW+T)BcZLHP8CF9JdcUeUK0
Q29M6W#_<D(2V.1TGI2c0ZY-[V@D?F#0C&F&BFfQHI#KZ)S]1_NdT,9E][_DA;Ke
b7I&RB98]8V4RQdNLDHcXd);YRJ_gf8VG&:WbG=G+R2:ZV&L9+8LR63S<+&,&B<7
[3F@beCI=):5<Kg/UT6T?8<?QR.[MTKB-E[N.2#>C=?Y(1dbXZAN[IJ1g1?KUSfF
9U.Y+<;=_3acQP//,EE-9MV;EI8M_66X_6^KPdT7.>:=;^LM?6.a[LJ+=gP+=QQ+
@>X_AYI#__8W>>_MB/Y[[@LBOYC9I>>P1FUEe]U#,7Tb0]_[D/Nb2Y2X09GM333^
N)?S[Qf#eF[Ic.B4KVOQ]/VGRULM3W<?4\eD.O1+H[C^GW5U;dU44\3+>dM?Q;SV
B=K3PAW+VOA=K=?TR:_APF)_W-M94fIK@N_>_[6S)c=^F^_NP_):Y92;[GIIbJOS
(D_UYK\>VaU9[X_)K=:.GPANf-df[Q\e&CXfKa.;KWa0.#D11B1c\LTGU>5e#\;(
9f.e9DeR.V.a3,.?L>ZO<_;/IOW?5bZfBOM1Tgbf7.<]U?[.KcIf]J@//afIO6@J
=_45,XLKBg-K>6WHMggCD?.]70g=-/=ab]d.6eD_B<STUa\H&b<5XR0<a^c3=790
^WJ^\?H1e#O1U<6A-T]::K(2T:CbX=2B:ZQV3+4O1]dbJ]L;>0CS4I9VA1V(VWM/
T\8F7c[H2;OFLN>WG>LU)S8g5BRe^A2=61dLF-&XaX^EeK0^a2_LO&R9<#T3aNKf
_C2V@@gZG:R9WER?6[MJD7fd2JD.4==58g.e6P3M^Z.WU7:#fZ]/B&@XbEfS>+NL
95<f@ba[@T1=0F.eaKTf1V)_1#g&RHT,<6LM(RII26K@0YM06DF6N>B>I0e#K/J]
=f;A<a,/C;.\U;S2YS6W8W]+3RT>4>>62]TL6,b7Q;D8Jg6\9XgTH/UV:AS>EKTa
TJ1<5VKY@I&Q,M[U;8g0:UR<0PL<=--Y]/:Y1d:_P(dR2)89X?WX.S)_6.#I<#b\
;=:UMNdMXQ,8_/IUY5SK&N/,H(K[QWDAX;FSTQ&I9?W/;HQ)=NJRM>2f\@+FZd8;
X,cYeNdJW?Pdg7eg^&GUZDP9RHXG6:,Yc==3OFaK;g@Q1?&fT?O=O#297G54SI1/
bX&b]CY,Xd1FTEJ>_)<dH&R&VUa\J0K[3:)J#[/&I@WI,M>6GEH9^IX+.c2#FfM=
dA<R\X2[-\4OR64?8eQQfZUd/PT/7]]UQ/EM9L^JEB:;DG7^B1CLGJR-8:?(=;T?
eVAL=M52](H^B,M?07J_Y#P2K2bP:[DHUG3)Z:gYC<H+T(QG>8,E#?XHM>WD?K7f
/AE/0;;5,1cFO5=^VY0AE3[)d-.e&4[]KOHAV;6:A.dc=^\JKNaFb2=2,>\D-G3J
A:^D?D2^Dd<VeJ)DIO&SW#;Y))Pe@H-e<>Xc.RZS\f;AH<Fc1LK?,#;B78_VO(SX
/:?:E(D^JCQ[SYBf)0/J,fQD.8\C;(X.I:+KaW];W&&0//fYT[<)e8PdFWgf5g>9
8@/4CKXgfN8@F\FSdFL:f4GeYR#_g#Z]baM0NJNAHd:fI&OB1X?D_gES5/_9&/b3
SgKeB3c8fGW:2?D+<<BfZQRb1XZ_L4,O94\3NgPT[,8]:9gZ5a-XNWc&55MUIXB1
J/\Fd52IMU9J4=I<^_=RDSa6RF/M=-:RPJ_:KU5c.__3N,#\d]C)A8Ka2c_@S8HN
Re\;:O(DMRf\22#1_;)6D4,PM>CLc5J2]e20&EYJ@>?c&(95B+LeV5_SZQXYFAVf
]@[=EH;ZT,>c0>f1:g-=Ab[c@W@J)5_e1:-[gK^#CQ?_F1ODJ.dcTA(YN;3[(]1<
;0Wa6=]eV#TJ;FU/F/]8ZU935>XBgG2FMXbKE_ES6Z&I946Z7Z)]3RBPaaa7_F[d
E^WLJ^BRKS=:g0UO:-G-W&QEOLNU.)fgS?N&C1a52FKb3J5FR_W#HZTY[cL)D?Z]
g9_ZJZ5&:[&bJ@[I)3IR@ReE_eU>UCQ>E&:MBB4c-.L_E1U(bH4XZZ1TLDRG1CUO
QJ;]H6)XY>2J:W365W;AbMD-;6C?QbTQ7H(0afWU&XPP6PVIaX(<_/&\FV=--D\O
bY_/&BX=0)<dUN#bVRJ)T3Y)?(9Fg:BF<:(L6S?M1gQ?<\8g?90SB[MUaIcCIYQB
RBVH6_#YLJ@R7KCE15W0@M?BG=Tc9D[W&0T8S^V;)<;PG\T8c@P3&CgNO)+b)LP7
^[HOBE?]FJXQ\MO-MU@c\db.6PVO][7K9W&\/PAG96^0FL.1bRNPL0+;G5DSZ)\V
^>XILRQ/#<H<1)>9a\50@(<=gHF.+#gCFL66DO+O<-4<OUHVJSd\f9c>bJD3[=LW
aMBHS&WWNSJ:YLJ1/7E7.GH0=ZU?V0(+d)@K@A?e#UH\?=R.C6-abfU)JEZ_V#X7
>7#MPb9b-M:/7&H@U:5HWVJ18KY0S&aML&(C(_b))CAE\19W8a(NeL8P@g#T9:H+
e1QZD[GP@c_A^7DX5IN,5=e>H^AfO(ZGUaEJH-H6+VgQBY2(QA77?[/9<-K2ccW>
8f1G6]<<=\5?HTc>Eg0[DLR9]@6^:O[D<b2bYbGP9=0+a=-FEG/A1AC27,cd:82b
Q0CPPXg.3/AE,IDV+4,UFK/))K&dFX^RNQ]Ie;FZ4GJHC25cK(R650eUO2VgK/83
T/15X]D\[Bd^Z#2./cdW=b7)MeLd^+7GN^).bZ]a_/Pb.[P1L@_c]^E@82@/Sa-+
<.g/,fCTPd0(A.aJB92IdM1DBWN4ag.E4GMM8aEff#;-VY<e9fG\6MD+)C^()OB,
YDQ\ceBQL#M6-YN80/SN74KN9PI8D7>:g:@3VaTI96QP-dX>&718Q;?U]1165Q=[
;YXcYaKAOPbVJ(;cH>F9HD6R_XQ<DJTHI^+<c=O8)4[)V#-=HE(NHL_]F+,:].ZW
?JN>(8T?gg7]8];27(OZ;+#\I-)?TX>?g7Ud1W7GA:c?W,WJe^d>7L:dC(WT7YQ4
(M/G)-[7CGV:Zb:ZcUKaUeETL9UcB)\e7/a8UJ5LCFBgA<=IGB=HCA[@I?XIgeC.
AQ+b^P&.c5DWAUU6EG4]][,a12+-W0Q2.^?.JFdP9dS<&:U?QQ4?c?bHGNa\H]Gd
bZ;BZ7^CX,KLCDb70C6EK_O(If]BEBC]a9d/_N+=TW>(.=KC.7:H+<=H3M#e(5aI
^WWRSR-f<:J:/5RVV_F5&#1\bX&CYL2JdJ:H(TXa]KIWGR33]6WX3dA),UdfS7O7
^]9N?8AfYK]F7G7GW0F6d@MOI5:8ZO3f9]+>T9Q3F9\L\,KY;:LZ_?Fa_fWNVVFK
K#CTOAH)3>M2<)5LP,/Tf])6L2EMP\=4SZ00I>L,bR/RXJ:;BKD89gW9GE#\BTa:
Y1R/V;M\SQB>gJC\#H?SbfGfV^X_&#/b8NQGC1G)I5/11S5XI^>/E(TDP3eAJYZf
.EagfTHF1W12I0]@[7E.5;[<IVF;Qa2SOKT3:);/>WTa11Y9g@eCVT2DX@LK?@VL
:TaI\)K[8PRC]V-N,^;,Q=^.Ed1T1)aZ,W4DENXLbFBJ52d;HE9>?1I7CJgTE9f@
GBY+]_e<g3E7\GWb.e]?GQd3HXZ8_^13S5,R2>b-Q@.KI^@QK<@df18e8RWPL45C
G;HBRXAbc+1bZ==@P/HW/b;YTZ/e=(:\S>=_)bD8=2[&>G,=PDO0FY)I,W^)PX:S
KLHIb7]S?REC<ZI[4FOcL#YJ1>^0[-X2,ZZG1I/FW\GLVB4B4H+XTf,[->Nge.\/
(+EOVQ7M@FM,GR#3W7=6,R?9Td#bOHeQ71]-.cGJO3896+0gCCY-?)V7?OPVNXQ&
Q/VS/UFJ9f)EfNU6LG@AWH?E)QN<O;M5DV^VO82/T[;H^H[FYA;HY#03+dgK_<8f
ZKVE]EAC#7=KA5:-E89PbHOe?c3-R2__gEb>8bNFf+Ub,?XXO/AR_,b;U?fO_-KJ
O8Q>47a\0bHMS=ULK_g7Jf,7JbYNb/PKK>Z&GK@:W4VRa<FOR19W;8.?1fL]:6Q/
=\.Z5XF,AGWd<WgfG-2Q<:=N<Gad1^1dKM+Q-]f:[[^/HQbg#/,WGI&M3]&@6]D[
#+<)^CR?RE+^9-WUN<EPU:KfAN>_R<ETK5F>9:Z0c#418E4)MNdT4&Q;EJ/RTZ+;
1?]D9XXYg_9WB25AY?8>WD&BR(5C<?,?V\CeB3N4ZK21P;FS7+3f<CTac.IJ^@-a
QUfEACC]QPLaUL#G3GURXS+MaaGF-0e-+-8]BbBJ>03:^+9X1B4J^ID^_/SfL8@L
?M2;JDYEKdFH]RIG,G;_\=;5:JKQ^b1PE42:SI&dHN;EcUUK+@[5eJ?+PQXDG5=/
cM-\UD[]IU1=ceL=7[EGaNA^/AdOg&UXP->]Y#a3R&8bPL8)7[1Zf\?->U/C0P^.
^(/B^Kbd.LeJ&I-Y\f#3O5B9+c4>P+Y:]5Pc?H^WHL]&eU1K0EMVDJE;XD+HGX1)
_C6EK&@Z0/,@f,FGA)DX/c8:]QG]PACI.J&_-6<f@eKa<d3TY,6Hd;T,d62LRPDU
Y\WSLWFB\7+51\^ARI5:PfMM8M>;\Z.CT7J;:=VMW+eRX)=TDF3JT+\P,EO)MY1?
,>f93U#Qga/6T1gG6PA]?F0H#,B&;JI^B<TVAeR.O>-e;+(:f+WZ1D98;QSFNI?4
T7OLc(6[RFCd9-\(=)MGMEA<-8S7UgG5O]/fe^]3G.U5(P_[:;NV7@Q.K)X?b5EL
J@>PO5eaO5NOT&ZAg\[Vec=Y[(#N-9Df9G@,e8R[NN-IaPaZ2C](C(M8X@.VXdS7
QK1#<Hg8gT].GV;(dR>CBF/]L#T4JH)#=6[O;(;(ZR>[4+HUE+8.(Q/E[G/[B@Q#
(dHCKE&K[g;@^:&D7YOQ[:g3U@g@]N)ZP7O(Z&>]SG)L;fF?a3H_IK6D]]3]aFC&
BT+0>g\>f9dYMUcY282]fWX;F7JfbNG+ZU85/ceYT\,]MaA(ETORJN>&f0gMQ<H)
W_MN5D8YXL>>a&L^XF_AaIT6#37c\IOcPNJP3[5b2OAVaCYCR2F0413:OB.9[[1X
YA7;MCPTY2^fEUP4Rad4(=:4.6ZSX3\+I9Xd#Q_?Aa>1S2::G\G:N]2,JGM6FdF]
Y6Y-5f:]E@C(b&A+&-94LXV\,2Xb.D@/)L1QORP-3;&V0-\G#fJe.9JA)]&]/aYg
HN\;@DVTULXGb60Z>Sf3@[^]A+P=5VQ+(R.WS1+W)f8423FRaLL5JKFN=CZ.\AUC
IEG#DXGd><0>842WHeZC_B(PT.,HHa+/0PZ<Z9K&,ZGIWY)8#+[.[H[OO;AV^9&-
B/2(UO^R75XMaLG>@HBY=f1X&eR(Y_0/QI?FM5ZI?6Z@Y9+]CM=[:Q=Je0,ILI6\
:H]M=a3)8BE(92&^QLKFdgf1W<GNefUf/WQ?PI/Hd20(YNG\V3/]IPWG&:F4e5#e
YK/.AaM?ZDdTa=X@<,1]Ne?4QO<X;C,AbZ#M=9Q)J7#J[J]PSN-bf4^/^bD.Na@5
a9?VPYY#6V+WV9dBLV],CY,JSVb7/=(X.X15d30C\QXeT[MUO>O?HN=GE&VD)#1)
<g,NJ0MIT4IGJ22Y:./=4UG>UU7ZSX7AdUc.PK.KBQbB[Z(+B:@_TC0Ua<Ib#);?
(+O<>E:ceR@NX(e-;<FCXb8U)54b@3FQ(Eg4S+F4L(F@7_+<c0##3\)5)7)_3e<C
0fO<_CT9:-3a>^_bbV1Y.\]5Y]MKUeL-_H\)CdcZagYSM_a#:;_@+K2\fEY7Zb0a
-X4B.E#9R8-R)MU?dab0ARHLU,gW.gJNVA-+?B7G>6(aFYZg@Ke^JB[R4DHV--BQ
B[UC8U)=>VH>>Ra]\K.7EE9;^29HgH\SDFIRY:O,,aF]P55Q^;HHX\;)c9F,BY,8
5U:\#D^UCcDBWIB)W3?_Y:_S,[Q1A:GMGN[I-edBE7U8[CB8S8I1Gb)AW5dU)_3C
McOE[?4fRQMdg>EMNfU&.685#TE);78<9(E_E(H[A^I3U3IA@^?PV&MG[/ZF\I6;
J/OL#7X:6aMYd.We@dWKR=:2[.GV=1a/EK)?#,/P>C],bJ@8G9W+DdS5ZN06?55N
gdQTaDWRX\Kg<OR^^DTK>@4:<]U2YM,D#35JFXE4Z),T@/\L2<c+>=I:7;?)9Z3J
UeAE9_-ZLWLFCPOQRDbX(]G>;9R\F)O_0cFO-#e&OgJ\AdN&D1MPRHgDAGRMHI6F
.:WRYAeMGSdf(5D)L/A\VOA\K?4.4__LR6O)c7,,RR&N>\CaCH6Y851^PgS>,V?]
/I>T7=eZH41\4,5;DW>)XM7:][\a7S\D4Tc.(6FN2FL1)cSBfX46.a=7R9Y,FCLP
6c6U3Q:A>4S)5Q>42ME9>:OT/&9cXbEWU43O9gA=PVH^a2gJ:0KJF-5Xc7Yd<Cd6
Z(LeO5g2ASb^3G>S_g;1/d=7c)7F+VAVPF>-7_D1>J_GQ.H45+0K?IA7FPbb;S>\
G]^/.M_S5;Qe77H1AL)Ic7(R_KbOd#/SHNP?D.YW[CH3D@-/,UUOb\bPHZH)#Cf(
gL\.FU4.K4)KIf)D8YNH9>\N0CUaPcEE6X/ED[0X&VP4WW&Y5RBaR872\cAD[FDJ
Y(/F85&P+9=__+dOG1C:9&H?FOGV<S/,OI^e,Q_UOJA/FNV]>;#CJ;LH+:CM#9W,
4?b9<O>D67f#R,bM-a1Y&O1.c8<05?1]/DTf;?UJ_#,/f.]IH=SLf+CST10WH;Y(
S5ZPK0VCW5+g4:eZBA>bL6I9W0I->C@6ZD>J(fTBT,NC;G)6Rb<BWV@Y:+=5W-XL
<KL-R\Z,8JZ2Vd/Cbd;(<KEf^P+d]X4Pc3(dZ&aTH7G;QJ-Y5d^DWI&&&P;KVRD9
93.D#]c^>dPY;5De7gFNO(?7aP?-=9[f\6&SBS8Z0I^MYL,;a]Y>:^4D8Na;O4T]
9X>TgD((54+NM&V=\e;X)HP;M>4TTfAJ.g659M)ND/>/DWGU:eaDI5MSPI,b12N9
B)Y=dCPgSDT)O&>)#N4@,1cA<C\VE513??^IJN_G,0MWeEQFJU5B?VZ+EJ;TTCI[
]a963QS]]QKaWXOH1>Cd)Cge</[<&e^Rg_(4WA44O=9)AaI\INed]KHc-f<B:WHd
-bg2-cGBO+Gdc\((6e#[?V#]B-K6D^4XGJY0c/2]T^4BUS5\RSgD[<]P_We.>Wa?
WZ[aEBWV<JNJdCBJI8+Z:HH9.02S=5NR]eb+VL80aS-/CfMS6)B:_7Z+^K_Q1>T-
Feb((J5UC=)bT&E2Z6?@668dZPFK.]>D:DERE@U^c&NP3;L1/@>Tf1)Qg\=fKa2)
S?8Q8ZH3[X>INH?XfHH&XD(OT8^dVY9&A.UJ<8GKX_>TGM:(QY2IVPC6U<(L\;CS
A67K/3=S0R9b,GAY71<J9#ZbL8UPgb53/K]88)U,F.;FM-##&KP&9GOBSL,^15[R
UX0B\?\^<^R^:Ic7K_87O\(F6XdEc<=Y+Q.[KFT-I&Q^\OCK+Lf?BI#9Qa6ZHf0A
Z82X?+)=>UKX/b,\X&^F#^U#@E\c3cF^NX-a,A3:YF5]N8B8(bH5UTK(5P\<Z;VD
(d5=>V.&e&.XcCJ\Q5/K]#=_[G51N25W/5.J5NY;cOJb(](ZRRH0XM@O\<@)8DgE
SVG2TLUF#2d22G@(#DAQAD_XB@7>B>1fNOd\#-abB0&M[L7EHQKQ;MRPdFdgJb^4
C]42Wc@=HWG)+04Y@JM]BI_I48KPT#:;c8D=+g3[caKEOa87PaeG]/AD&S9SE1E<
Z?Bc0Ua<+4II0T>IFTDAZS.0#f4^)4.:4)8bAAL[8eAC<f06\Yb]aTc5Pd3ABB(5
>?\WV/;@O=08DRUN7=VA&=A+,[:/BVfcEX^Lc^ZX3fA;b564^QP0AcbNGH)BKVZ1
?H?/<GZ,(c25>Y=ePL+[cP7X1GT<La#O7ACPT(J^IO&C0XI?RGE2#[3X:H,WaUN^
Xf&F)C(0J?QCT8E@Rc#:C:B>G^7<K8D_a#.[HP&c4f=8QUI.T22KV[eB2/_^/(E:
PV>E-4-a3C((09=bRB0TN[I?8/8=LfCWL1E2S@e/X7^@d&^;((?8Ha>U5F3KO^aE
a]JYLd+4)(eX-:5N@5.6E0C;_91A8M>PUL_g75,E:(dU;[Ua2IN>FWg44O46-.TR
_56[YS<WKaP7d/_V=>;#I@_9be:R\+2.+]>Ma8W)a>Q&W8]Wd&;V[E748WB,X:g7
@RJ4I8?O7f:9E?GL+:FEIFJEN(2V4.K#RSe8Yb:bWXT=OcSe<7--Qg.#1)7SG6B#
MXaX37MaN:.gRP[&246.-Hd9-\9Z5HKdfM\NL(@VD=D-Xcd=IM>EHTKNd+b-8(Uc
b2b41.YQHI&CRGE.ML7>;cA,REU6Oc)T?J?]XH^<H</05=)7[,5XaMcW0-Y(X,8D
YE^#N\aRf^.B,B?1AHA.X;1ZI0C1\KZSP&N<QK\63_2F05]+U#GJHc#(=2@a&5:,
<W^Q4HH(L+E4YE4Q#5:DM0?FBT8LXg#;(-bd5^C<aFP[W1L8=N1FQK3Q1.I)/AG&
cPHQgg_KU3-34I<1F0gN=eIf12\(+Ebc.W8bR@O8b-,6,^&BS+XN4H&U32+D\+e1
cT]TNdEH<,:RGX><53e0NO@Rf>H8:[IAY;-9QMVDT&3[C0>WcRc2&F95CMHW4Se=
WR<IL]/(Cg^J[BK]cfG#N;P+_B8G8#+-S]eFf:DB\H<fLRY#fA+0\(CbZ][,OJ3>
^5R(4G10]BK:46#Y<d-@0?4L)ADbcc>]:=W:V4GFIZ(XS-9=)HJ)9,Q6E5F,Y#_&
2a5E6-bM7RD?5K]1Ib]Q]b^gE=X.5CMIP;c0JA/7EU:1?f#-.EK+HJZdFDG:8a8F
fWYR69cB8IAGV/=FYA/a86SI1-(#d0+K]eIW4.B<I;_dPI#_,]Mf32,e1NNDYDR(
HOR([Y,e_FH=d,Jg_b,;M)gaJ]QO7.?6a<2<#-d.4TM5KA6>3M@OIZL77M<DB0?/
?(>_-S\O-FHWC)(03]=9.B?Y.]b:YS@D[^-XCa\+Y8G)/8T^5R:fgZ?IJCVL-cE<
W3V:[Q#gPI4\<Q>(9S:9EQ6/\6H,G/;AQa5TVA&+X6Add>f^JL@##[@If36@JfE0
XK8WbN45RG/B:7Ma:2X#8Zf<5dHN]<B^1X>cS9DG]N(-]e#+/H3aGgNC6L=>3Oa#
:4=^U>^54SbLVL.?,Y&8gP_Pd1O?H=>N]2A4Z0+T;O?<;?R1,L/Ra\XJTMMBVcE^
5.S=V/SG@N;T/8?;W&3S1.gDd)O#:g/6+<Ud1Pf>Z>f12cG^GH-7B0G4_V4?[T5E
d1IeQ9\M(W_EecQ[XbIfKIPLEVQN].7fe7>.CPVCMc@8a4\FJ,.4K_f6WGF>:O_4
1b<+CD_P>>#];b-OE/&UJ96U,28ZdT==?B2I_LXA/7cV7H54bCR]g?8/GWECU#QR
T#TDI2[LL5VBYVdc-Kc)[.3(K<aNQ2KF:@72KO.9XF9+G=BUUMb<+Tac>@P9S9Lc
f0WS=H?d>ER1[-].N879_a]gF<F]ANIKS9ZE7aJ^+>9+L5QFSbK:69<bIC\6]bDU
22Tf-\2@PJ(]W9N(Kc9=L1b:R@_W5HH@(NK.R#f5\4W:HED[_+<.)Q(ET:2cc@RP
(Y>M3Y.6HdSfcD+:/TF2Sg\:U&UaJSQa2N71LUDG;/,7GSd]95a#R<_6C]=]6Pcd
;EA8d_,-2MT((N-BK\^9edXaT=E)XH/00]<=C0/bYTO;IAR#PH[LI=#e6_g67OHZ
T140E0?7A.TR7T>N7g626CR_TR.J@+:[[?J+4c6=OY>dOg<O@NKfN^3WBLWcg:b\
UBXC[.-#d@QRLLW5a??XaR_PLd+fK9f@.WNAFbb>bV>2+7M;I_G21+25U/;2JXI:
)]f&+d1/<-^9c;J._(:)VE5ZD/Z#16XG^+_b+UeJS(8dZ39EW]G@62UaF+b+&8H\
8c-M)=7bI6;\KOIJg9C:<3eTUXb05P5e@dF?,GJ#JBc6#b/2VZ\Ka3L.ZG::7;VS
UHHeNX)L7&,b:W/QC..1+DZ#J#N,CgR#Y=A7D1:F06e5TB:[K6f;LDbYZY-6L(Jf
-VfG4K,b0c2=C&WIEQ&CMIZP^405A))I#LKLP)]Wf\OQFAE7MbFEXEJ/>(S-YD]S
U#OB7XL3Y2(/BO(O3KXK+TM3OUe3U>9Ydc-FK787OU37\D6:XcMLc+YKU:L;1JPK
Fe(4WR7e-P@d5MaI3ZP8)O=Q:_GQ]b200AH&IK#TOV\9>473X[#ZE>926I=fD]6C
QQO38Bf<<\CBe=dfgD>U^BFH7SXe;e/M_Ib<S#B5e,LD&IEYX1dSG8&<He&ZbeK7
_TQb4/0g[g;e-=V3IWS@>-SdJG4bD&::L.KH1JF1?DTL,T8NZ@N:)C917&1T/B2I
B-+4(:@S2F5.<;)A4WC5(-YMLJ:MW-RCL=OE)ONY,#:46=6/cWYQ@+:@89bTTS/B
]RSWP_<ZeO4CUVVR7R#.O6gfFSP)_df+9Q)eS^S0EFY=Tf14OCdH019MZKAT01d2
b66@JcI8E3;KdTPKaO6Q_;?A3&H6P(]C#3(OV8;OZ>J09_&F0Zg]Ve>9H2L04S:&
3IRQ#D\PFKR.JaHb)RJ4T3Pa55/C@8=<c.)C9GTb+_R@cM+<RVSTdB4<bN87L1=,
CW1fV9:a@[]?BD49ESb0f?0_5_.AdQQB0?d-9R-S0OHa7Y00?VbR=&6?;DZ;CQ5L
gB7OV_.^Ld6)?E5_b<62>WG;[E5>_ETUCe2fD5;HdAeP1N<&9f63SV<8d=J_DC^a
=ceFEBZHLd^V5.</DN/S8fP\^#PY],70A/cae=P&RbN-U=5aSX9Ca4#O<ad8BJ_<
9&;8R4>+FN^C=O]C^Y;4/4SS[PW\@CC4d&Jd(N<GV[GX:<#3ZGJ5M@FY\JE7D+XI
J2T8/Iba3+Q0dCJ^#OWQ#f61:4WWQ_\faNO_+YDa:V&@9,#EIfBb++=:N#>N.O<S
#MJ6EeT?a-c=^@NAW:3IdX6UMFD^U3&b:PLH6d\U?1XZ]gR0:g3,Q&7=KO[a[a^e
GP<5>dPV]b.?3L_VCZf^POT5JZ28J7-PBLA;7N<#^LSMIa5?S\Wa7X(/D1aN0P#Z
;QEG;AV>?1(e4:O?a1F=TB^8W:V3ORJ[7OJS0/.7f-VPJMQKdW1[Lb-U\.HARBI(
F97f@+:/=N]/]a6&1a:KRXL,4P)d9NDW8PaVC-UZd25a_P0bE((0;^;A4+7(98I=
UbL(,H7.\PLbN?=cgIY20O_2fPO;UaT28(]@g/[-dSa8,HQW2@,_@#&f,:F;8[J?
8P(MTVDH_MH5>FB63<JWU8N&V-W1/?8RQ4>-1LS4Y.H>OE1N<^94S-H_.#(T=4XD
BIY+2?29M8TGdG)_ESg8:)b^^]PP/Ua@Q2NbO30U7P-R8V]/6B5,]1<8,f^,:[\Q
QBC?\IO3P@N4e,Z8G0-f<PaW:(S:IgZOc8[)3EEBHN4G093fV=,5N-\R&SM+>XPW
+MDdO4X>]AG14-7bUf9c/>C@<g[CTZW/1HfG,GDL\d\?K[XbFg7e:8eC3\_&98AA
S6>-g)\?Ja#^^RAE:X.)g^g\VX;-8(?+O<Q71C[VR=eLL+>bPCF7/+^Z^,E,NdA?
9:d4+I=SXdTLDb0[/1)(U:MQO_8MWUTI1(?b-_/09gd,SdfQ>80=T]=:JOQ9((RZ
XdH121bcDcS>-M,^QNPJ#\LT,S(dc[S=HcO_d,bXR5;e/>)T9TB-[6dX17ZW4>S&
Yb37K[P8046bbS_61=Pea/3X;abPVA2#WV>\_1H:1DAIa.FG2S8X:8Nf(-cK>4)W
NLfXg465Z3S?7NV.PORaNCZ>cA.,7K16G+WIY/Z)3SfI.SA#PQ?15;H]J8Lb4M8b
71\K-T+e7eFUUZIG;LacN8Bgfa8W6;XN\NX[,],&;b@7R)/ZVaH&Gd(]FIL:_3RG
-E;^cbE74Ld_fW<Z>5U>QYS9B/2&S]W83@@(\U#A6?RTAW9a>?dV.QI9GQaL6dXE
aPGC0;Ab?-,c]PN8c6BdA?g+J<>a-B[]Q^NV8b)f>NI-fTMGB.9QA,IUF?OffJ]G
Tcc:_J?P[WcG(aDf3aCVN6T4UW.VYSeHg:R>=eM@BLLRDS:HB[G?KU#E;c^C:].-
d98G_^YP<UF7e7U8+g5.3;@2R:3WQU[H03B,-[J&.KY-QI80.<g+d>MQK[^Z<,;4
g/+NfP>6AOUF<\AFP/E_3L-M[ZFYa;O8Z@M=(CE2_8X3[/17@.+Q6:aZ&aI\Xb,M
<=9VVO,:NY&9@80fe+<,gU<S22ZD;fRBIPXKITHIGQ=MUdIU(.Zf)=C,a=?^R2:8
=9d=+c\H]_#(A2b)H2d;Q]AIVYfbRaFTCF@K6LQ+D+YH5J+[^MF9K3QRV/A(4NDf
>0+WA@fY@,1FC/W)bU9EYHc5^+[R7P9\^EWa41RTLEI@ALG]2D_d?WFO;ec26FML
Q&MBFCKFa^5I>81_;Z66gA\[gC46dWOd7@TU>KT-E:c=PNX;g&bF3XG?g6>;J7<+
Pb?.UY/:[b41\bVC=bG+eJ)[)A-dZC@1M&^;7PE\2O8fLMdNSDGUF,A&TA/.]b^A
K[#Lab9#aXLaB954@3+<DS7^U6A;YeS=E@dKVfFSV#.#;Y9U#WS28QBA#()UMULK
(MIB].ZB:\Z0?b?9,eONIMM:g7BEZ:UC:(C>2HI1[K;KbF[85K+-)9@cHWL_F)Uf
?.]Y,f6ME?>&2>Q=DFR&DX4fFId^g.X77;0[7H1B-\Ra^=738(VSQO3d,]1.e:L<
ca;gU=U1d-.MSNeA8gDPZR:IE2(^8RZ)V1MG&TLZ=@cL42<DRMTK+cL@B;FU]N.\
U4R&ZT2=dP>?]aW1YN.UY4a3PVge(J-9V2RN00J+JL:32A\LBHadM#>B\NU&f?2Z
&98,QGV>=(8KT_,UGD9)Y9Nc^7HIe5b&:cKW(F&&/->B1VRO9:PZV[]6(]W;BEdG
=3JAJb;MaH?>cPJ\S;7ge&,BU-=^S+UYT-06L9,I.#DA-=?YVg3>TO4>X:<DB9]R
B1V\L]d:J5B?_>[CP99eaSB<U0,8FE;<bB:/MFd95SVOg2B]eFgQ/:_[6GWU8#.R
2Y)f]c;K0]>P+]GH3CII2P1Y94X^c0GJW[D2B:8+:20C,HK-a0R>6(YY&M#VYJ\a
=0VTS+IbLeOK0Z;fe&fQN8e#?BHBB/1fd&DZ\=c[N8AJ2K7dNPO,S:]B]S[UG>ee
UALgA7LF:W.=#YN)CZ1.YDRB-/\\V4LXDGKUXWEW3XS4d\\SaZE98)-[27[bYOC3
c96aK<2Ra-Z[N[?eAW3/E<R<G.^B^JJ-dEV3.#8TMD[=_Z+@gSIU,VIf@PUUGRK+
(__^L87;+^[5K]6H167RQMEDOJ<TT^4:R;ZRD=VKCP,8XCXN#^d?@Y8^70[LEPdD
)Y41I:/@S0X&YB>X)X3#Bb+<I^:_5:18G]EbHP(D65]5f<\DTNTK39Q?4[7A?C.7
-62B5CHa;FMC<J+VOYF#W1]ZG7B5_+I3IUZO?(<QZJ>_#DZ\-LZIXDQ(1&JeF;CK
+X0CS/#T1RC8R>#Mc1-HYD6+.:C7CK,-G=D2OfaEe;0@CE/+Fb<J?U_3JAFP:P=Y
[^>b919OQHVFFFDK1e6fbQ7=3-)I3.<2]#W9;S?E(BIZEBa.FRZ8U4/I;bD?b#](
PL^X?(AaZ/A>C#9A68?H>,:XY##D_cPBT[0A_:JW)8W6J<#JZ1eN]O^We@.@ONQe
?-\G:16I+YgQK6((a/gX[=g6@bE\7/E7b8<BdScXYUMFcP@CXMUbP3MK\B5eGY.Y
VL.PF4V#?eaPVJB3C^=F>Ee)3W69@X^CW^F^-5?@6YX1/;LU3SH(O.N.g57,A@6U
I?R(/=#HKRd+_?aYXY.Z<9G6@D&YRAPC5N&PDGDNg4f[^K?K#?XWWRe,C:]92K]W
/U.9D,3LWJb-eKI+ePLQZE_G8U.:.?eS@J:H]J]GQ=5c;6L\K38P_YH::#=J9\gb
Hc?CX]LLR\&_4Y3W0&TeD15HYX\I#?0EILd_cA8KQRN83:9/].)A[SJbJ@#2LL\>
CadDU643BJ-g(6QN]-LX\V,4V=fYW&-:beU=P?[g.Q.^KgB0VPFI560RL[e4M6TD
0Q;/adWXV_)YNg]?bMf[H1ADN-NVU)a6V5.^RUO/[S:cD0)_RYGC1dSNgRf1FY]A
]bQd([W[P(TJL6H8).bFZW;3:Z?f>R0cG=.&J\+e5?,eXS[M/6/RXb&L:ICA/A7g
\6;Y@06A?[A<PS1bN&2gW/FCOP@/UeH>gD6#V#4B#/M]bWeXa0;DY+O1[)3W=OKA
4D:CeQI+H:Y4?HbZ:WNB/8Uc-]OQ2d97P[5I+28LLcf<V:5f+=>:Bd>HE8VNDYMK
37D:817J:#-,1YBE]Pf\>\d[+/A5M<:d,ce11U2+AA4VFBONM:1\ZJ)HJ(G++(g-
CH<\.AHU,.f7=L1dW5=eZ29JNgd3]72=WORP&<@_K/XK88GbO#4]8=VcTWecQ_D7
JG+_T8U@Z((HK.D\8G#c]/K6N>-Ib?^^GWJ6O(Ff.aC][/dAeKXP0+^Q:-HI=HVR
-#c75f/FH;WP0EM>CI:JJI586E((V(]D_f_^+O&1O#Ge_NWI?egKTNXJ#KBeZ#1[
2;6H_\B0AYKedFKce8Z#3FV5W=XL)cdcXUde&.\&RUe]0C#X;+/<g46ICfbO0SfN
[dIEA[5036b,\5\L2OE#dR)1#98(E3AP)dBdKd#GI_+/DI41dQ(I9H+=1X8)f<\<
=[CV?eSUX^W(&@0ECJ&\dEbM<69deK0O10E+<XK8O1R#K4dXQ7P+?]-a4<L+KH#Y
H=+D47,=[Y6db)CKe(E#2g.3-8\7Gecd\ZbTGLTNQ3a7KCeK7+Y;O=AD.gf@LbPA
G-Q&^CG=+Ze-3e(@SWS=Pc401II;#(BS9J3+;(cF5VCRfC,C,f?KTQG3AeV]8aNA
>7DWQN3MTS&)\CEJ[\O-3-:4LAH];Kb-O[0@T#gF^K,VP.d?F]&B(=5bH]ScEGe:
_Z#SXX@K[]6=fQ7cS[#2RCN@_aeA7C^UfI=NI3A)O(@I1#UaR(M4&;B#+f+KFU&&
I+;4c4R7=Tb_SE>4NQagH^GZ#E]NVd^OFTWg]TVT;CYZgP=(Q(I#T\gC-05EeA>,
T=8V,87_//PJZ9.Q2#1P3bF3]M1S).(CSX2)K7CW^0,.\N?@.QH/@WQ09,SO9;+Q
W.4gOWN3MCWZN&JQA<RQH\82eWcJb1;)?MePWDYW]]SS\CZH_5g5+Kgg?Paea/;#
FJacQF9?a1Q;P9^=GgHcL++)]<#JLQQ+5D^N#76Y#TA>HX5NHLcd@C-WVKf14FSW
][C0J_A0A)UY0CL,\EY>g14+AV?GS(=G7]2/&#LeAE_#6<=;0W(ed>NVdO1A,<YW
<QV1EAeMIZA(Ig9Va,R4+N_:]LcO&<\Mg,0<9J,b@aVU+gO8,EV[?/(fZ(B(0g/G
I/7\cP72/)]+\>Yb/5>fXOVSXcXS:RFDC&ROFKMO/+Jd_bE7ZdKHH=#^;AbMAUbP
VgfNL+fIQP>8J8MDR/W3+ASWZ\gW?5DULe@<d)S9J_OZ[7@-aIBM<D/KD>@B2#</
85-<a_THF/:>,Beg#fP#N<#4cT4#VZ76bXI2.^XN9]G@a3g.Hg)LP;=E0U[UYEgN
NB,0M&)fe?;SWH8KCSg\/]6MTaU>>Qf?(Z]=\UD39>f;C/LB0(P2YA?4Nd/c>K+5
XF2-G2T@G/aReb)+b50aAP]TYB@J(MQc.X-YC^[YS/SKScKF7_0e_Pef3JUL.Hbf
QY?UO08E9.9VRTA.?-[YfP@S]0Y+ZS4-cE6?IL+T>3M@dXM.VLF[EKEG,O)5?]5Y
+&36J(EKLd(1M/)R7,/G98W-RTeD3bAP9UOP:H?E4g2K1#RT_.T:_c^([F.1Z;O6
XTQKA[C/b+Pc\:OP3cOCI7^@H=RG\1c/E7I1.@Y&a5USQ?1+M/N,.:dVZ>&cKZae
cbEd[VgEKTB_dU0O2#A4Q/Z?L?Hd]NCf:P20PJc>B&eX&@gRKdV@@BUHUgeY,3<;
-D+[N[(3RM-5/\OP?<_\ALUUHeYNVE3K<,;LJF[1>#+7,UW)6(O=@2d=:GS,3\aA
9[6&P+[b&XFM0Q,>C3fS<fXfI_9b-A.OF.RS<V\C+MY+-YKF8-MZ8&d5@I[0W+T^
1T^&VdDcB6KS/L2:BD@<,O9A-^MQMfD#WFM#>XA<e1UF04.L;AWeL3A,e3cTf?\.
abR5I+2=^;T;e3NT.DC&KQFM7[P[a(AaK^@Ce\_,UJ)/\UX2CHLD=b45ELD_O(Qb
P7721-SBNSFb979XO=.EZdBgYc0;c^JFP9.E0]GAM29G6S7WA[]L>RE;I3:@:R&V
>_M#T40@@L)G]A2U,;??K1N&7(?FPcNfZd\LG-Od=R>GU#g><5NJ/](>Q6[SD,aM
SM6g#@4+^7SW1A&9&>a5]7]EI#G8(0<_ZD4OA35TLK4M&F5Pb=g56>H4BZV=Z8;A
)>Pg3=<48JZI=J:ASSf::M_EG9cN:[2GaI(36ML\R5A9@6JTK^89K)HVS-1TcVN0
]Wde6a)N[@RTTG=ZOS,5[/b&ZDQ(S@RPSN@-AdX\ZNNMH?41[Rbga+gM,G;-49_L
(\@W,82T_B:-PGG=PB.4QU->2.32NLJM:)bc66@)d34&7.UURJ-b56,848QU<#T5
Y?PUPS,W8fO2fK5NQDcG.bK/G,B?Be-FOVY9@Ub:4.bT;b?MWQQ6SMTHI;PS(_Y6
dA;b(])AVf^ZfH36GVc=+.(+B3(:<VU#Z(=Cc]<4[+TFfaC&6TX,\\2K:R=7b@dY
B(WZFJ9TI2S+(_?T7>]95J8cFXY>:F?PP&FfKA6?A2E)0IKCgWBNJ^\)QAP?PQ=G
8M#\NCM6/XR)?:HYg97g0ZDRS)JZ2F-D/XXE]15(0J,K^.\Q(MZ]-JNFL2[&K-_G
<2WK@L^A]YG//CK&CW-a>5>FPG_=P=RSD,J3-fQWL[O\DIMcC.VM(gUX+7M^H7)F
T83/g^Z88Aa+>.3])JKY_H:M,J/PQf<6g7QTg75aK9MC=+[VWaF(WN20G2OX;&gM
7/b094@[#=NYJO9C]^:]L\T&PC&Q:_KRYa@db/[KX=<I3>LGZ.P3@]ZF_)L;Bd#C
@R_S]8L4I#P]YA\fIB]R^M>Sg/R#HG>H;fR4g1LTgP9^(Xb2@2E/F46XS]R60+X<
f0C)I5/MOHSPa6+35-HY?;C2P5DFWaNQ_[>61Pg3;bU;W+I8GGFcQXaM>4+?+_+1
c:5=G_MIWCHQ(4g_dc82g9?e>B[a,+/dgO+/W0T_LLPGRG&C8b&EY0IdRDUf3Z3[
=gJ803I5]H_7P2_[9=N>DI-3;2/eb(EW>Yc3:M6@Id#ac/XdaFR<?=5&KD149()\
B_3^SB4VXBaS]Z20S<E#YJSTFKZNR\(M(6X2[WNB@(V^Fg0:TIFa4QCA<c9YM&La
REgffBdEA(?&:1^HSV7.ID[\/HS:a/:+L:<7Z>7YbIc[&MYWfDK6Sde3W82c1d:e
DSW/X<6ecX:?4W#0D1@V^622TO5dL6CGaT8E+UQPRf5a+aO)P_(6@LTQcYKNbNfZ
=/&Z\18W-^&ME5=5QAD\M:YJ^LYUeTE>U>S(Na#<e&gd\2,;(6/?Y55FaZ&^Z-8b
a6UCeQg4Yc\JbK]bDGD^JIBUVVS\6795(H&DXZ#f.3;1G,>[(>@JEU>(AT1+WH5H
Bd_.R(N^38)SZ/5dXH4FaE^TY8Z3X2_g2ce#4I^(;:aF=XaeL2\J-V[(bQ(bLCNQ
04e=BY)e.0K6>[A:NI),UPaBd)bJ)c;,V5,@K^S<9cYF?/L/]^SQ9SPgCX:\6T[F
cB9^3MQ=dB+J4W^ef7[(gJC3-RW@E+@/6I#W\aF.A+_&3/aMYb_6QBKNZ(KBQP-5
eNZ>CVCYYB\gM9g8HV>eMb]N.7_M2UR:4&Q<Xc3PCbCKJOD6d\bg53WSU5ELMDbI
O;L:e5SLf-C^3TOaL.KbAd-CIKP0D-B2RZYSaPGc0HcD[1Id#YUBY2]PVDRLTJPI
S;EYBBZG&R4gO9N(Eb@@+/3/)@0_7;76M0d8&4S&QYf@@e8ZI7<PQ2(ZcgAF4Q-Z
FgJ-g/WgOGX+.\a+<9)J^;fa\J1JKbI\gF44>dH4dc3bX)K)6(_H2/BZJ@S&XL5#
.f5#,E>9RX.7<(5=YF/S7\JE6/g@E5dc1Gd)+\fZO3QL\eDTFBLT8JJ\ZS(^d_]C
5A_EC@Kf/C[(,BSDCa)S>3)cK8MX>BSdQ^ebKMNRE\X-e\R312]d?g6;A10[3H0d
R#D1PH@aTTCgHZ)_RKW6<MG5G.C].I,LZQ.?G>OAe31;Igb^IGg/?9R[I\2ZWJXd
MJa5BR55LEdec1,+]deX^f(-U/7Af0U1e6U?3T_CDE@^:C-.ME\9PGMHeM9;+Sbd
1/Q)8RLA<]+.Z_AB.>3_S-E(5ZDM;W]Y/=4TH-;\D.fMf5@5EK;,ON=;I3Z@TE;/
6D5QB[a[4IJQ,X<<2\>J.=C?X=:++eQL4eT]<#(I1405<UI_bL8263d]V43#1=GV
9<Z)&DDNZ9egVE[WO1)[VWXIT).Ae-=Y58PJceg2_RCd-U^,T7B@WHXcZ8]J8T@e
0R#,cFH<V6_GHP(d&H4CW4(BE91[453^OBEGf_66FBgGG)F,Q^HANDOYA^PJNTPd
\,M\f]6;3E?_F?2)51Q_RS:;]J[:3E:PBYcHgYV?;I&9]Z?d9&RJH<6HYWZZX#D1
(5[93Ke;/T0/)&^O[RD^WM35f=L15(J=9b?IR]8>#K:+ZJ04FcF(-8Y4=EW)W4/W
TRf>MX^bC0[f^Q,S,5ZILC1)=44/7_G-5.f3CXTE7+a@B7aZOCC@SBUWPbTCJAf(
-Z:Nd,58IbNKaX.g&R/DEH^cSX0X&08#0,48QaQ&;@#XHY3U-79c3G[NBSNLg00#
1gU15FUefW>6IFNf9R(cG9,I&Cg6RU.G/e6[QYBb[gM=BaE2<f^&@CY1&df4SNeV
#UR/N.a.<VJW[CbRZF2,,5JIFd#4QM2QH-KOK@SIEJG^\VFB9;-8.+(\Y>G7G3(0
SZVN3WE5Y[Q2_6[\TE:[fIBTO7bVH-O7UM_)(LXREQcb)&DS?Z]X8TYWRPeZ>TM8
6U2GT]=/c3Zg=]+GgBPB6bF+_a=.Z))DSL/Te1^,_^\HA]1S6&ba2BJ;MT)+5He@
4aB-cM2)f5Z)P)T[:fYNT2YfS4cLVMbY:F92PTU7[f/SJGR)Zb1d>6:EO;f-#PZ>
4R&g6S9BI6#8GM)1I]PSZJLP^(1/a.B5c.\ZDaDZ)36H7_Q:\ObBIMA7I_^U0T0/
9CcaKTV9g+I3R)/N3fCG=/DQAL]+,)<I3\JT]^@Q-d@D=ASWW6STS6g&?HfX#J9+
&eZ&\6EPS[YCdQUPFeFeUb0=);d25);;2TbM\2,e-R-5MA?0bcHg5M3TFBHJ4GZ1
S\Kd/R;bH/:fV\0GeRNWd+gZccW60O8b6_^(X/N3FH#A+#AIK(Ac]W]6f\2&93GN
@O\JLO5dZbAf92IVS(=Kb8]S)MfHCM:_7#NCL\,3&L3<]F1]#S49.gJ309[<be,9
Z\&SGdVd8a4C=]BH9^MPbeL-JKUa/]@7D:#?II_<_fKA3[P;.NJZX59T&@9R8:P9
V_.P#[W/KNdG)+WQ.)H1X.T2UeUFN_++>Qgb>;:7AHbI64W6/b0SXS)aJdC:AI+1
0ac</VT44:B)9U/X?8:F<H=a(A,4.;)F,TXD=L50GJV2RZ>8#5bYLX@7&+bGMB,<
ENeg5EaS^I[_02H;:Q\X;[S6Ud=V79Ib2X_SU.(HF1/4.<(QKXF1V/1;=fJ?Y,?b
?@UNHK,-J:X(@@0&1g4\3EQ8_WD4+ACB(83?]V>7g?L7^992?:K[\&R^CAMPJ4NB
EP)gZ[)0aNS0S-D3(.I\]ML_98/53]B[JUR4(D4CAacf/;>Vb3NH-L9<^(N3-FNZ
WNK]Na=V+TYVIG.5aQU<:R=<&BK(;1P#.bWdLU79,0DZXC\Z?YA54aE_T.71d7FF
N1We[6O1SBP4QES:U)=Y5Q(6?6HWBD^ZVa<WPM0&fHXB-5T2CJWJg?)&XJL3L<OY
->gc./0cVGBN/<\8W^)g(EZTRB9E-PKaV11aE9\9L3GB_cTE=6:EDXF[_PI9B[TA
?,U;2.UV\^OP5b^U;ae(<)2/+T-#S@L]T66QdH5^f(9)(VDd.7O34W<)P(&Y=Dg\
+2KW_GRLO6[<I2FM8]HeP72K,;aH-_\<([[3.)37I)S)-_Z9J(Xa@bNKYFB5a\HL
f,6:9Fgg+(QJPf8Af1A[N)Kd82:/b@X[;?I.#=>a+e=Pb0:(VaL8.cHUD<fK-N+L
/9Y?27,Tb]))2)?(#D:HNSO2bH-2)0DCe\FY5Db<cPdcRdAN]=d4GB)A>0)JR8e(
[Y^XP2&_K#AJbdRU;IJKb2Kg4[##e6C7G&NCe0UC]W.I3g#>W&IDMEfX9;1C<>[0
Vf.U&\a>PZOf^H,PeaD3bM_QH7&FIQ1P>,1+[]08WUd2&#BLUK[7Ra)I)^P4[X73
5P+g1_<Y1^B?[01f&&;NXC0EdedJfDYGfDZ-0R<),HYE^N5LfZ9/P.0EA2KdbIb;
f(9<U[4LDL+37\UNTKC^5-ggG.,B=.Q5C<1^ZBbc#01aF1DV6g#e0<XU@ZZOC=LP
X](Yc9Z/SfBL<G)NC:_QJGgD-b9\(?XF.<RcH\c7bRdHJDQaTXfbW._]NTP>WU,e
,_NR9;6b7I+KP/=M].cK]J]G^<?U4]#-U;,5)7CVAX#;T?HQS43/c8AVWW3fcd9?
JC^8\B(ETffU/+6CC:@;G^]Kd&?B+::FV)X@bFW@7=KPdcMJSB.Y:F+JdZ_M:X1K
E?V=8Q>8eW0V(SP7L6G>.[??]S2NL?c/bYT72):/bb>5XCKSZc1IOcdH(3R:>JG3
9780I6.E)O:4PYW_>18GL#^OG07UdEV3+6?@N:U(S]gBB&B>:A84:>HcL5>fg]G)
2&25^3AO8[8^]4Lg[7S8UQ/)+)?Va:&dQdND0Y+_\H]:5IF9gB]5LMGGYfE<:>XV
JTe,VMCD9Af8b_8DGXTL&+a-IA+MHS.c6gcA]9<@OP(17f+;-?9c63LO5E&F5QV,
O+ebc:UYV7b6D&6fa-.(-a7)+ARF0G-6_KSUG>GeYT:bN4Q8ag(O-0,9M6\5BTL#
OZSS5K70J]_d_/Z\ZZ1Z>6>JCVXMB/g[76CdRfH2K9/CP0F)N)TMdIY^-BCVYQS2
UXD._L1^](\eF:9Ga7BAB,KHWWCIa.f5Xd2@WNcS#S/^(E&Y,NQ\F5AA]bO\,UUb
NZQK]#_PRA+UdMcR#D9:FYaOdbY+aLg/<+K441Mf=Q#N2ggH50cF&G26aFdSN6Wd
IU^I(=2=SF9?KKeN)N>f[PP::XVQ[G?KXPJX_d.WAb0@<3IIQ7-3b.1Aec#;c_&3
a=C1#Y<7)@,e6AI/B.U)3T-G[RL+\?S.:7.Kf?E\8eE@A\[RbYA8GF_H-?[HMeQ7
]U:4:cC+>-g#=[J^13=1PMUBMN_<+0WU>,D&F:]YR_.F5<\7a(a=DK=A+UcTcMY&
:.\HF7JT.JLfB(3Ued+FTWL+XO1O-.&fHfF7gOd;#CD4Q,5LPQBSE)R@4&Y,4ab\
LZONBXARFGVXRRAbO(2=?Z6D3gbaCTJJS\?0g?(]5572B:N>-K3E(=QDf/@P?6#?
cS?S??731:KA,OW^-9f>4\K#fe;B29],1f)C;gQ85gAb?85AH,VC#@9]A.#C=Z4G
\QNWO@NL-3(WY#MWPGQY40e?UZNH1,3E?_H^J(2=YW>7_5N:b/D6.0?MLOAD2T=_
2E[MR8b]W=0dJGWX=M@/9Q#CQMd1AF;_SAL^8J4&I=aY2)eHZ\cHWE)C@R,.?W3d
IPFJ:]8:R>fT9+#F_<,WTdc#3H;1ZMQA/7(#.]Z9A8g)a1Ve]daI,Me)58KJYW4D
79ZdJG[1<X.\f@8F/JJHLD?R,<9>-P1<6b\J,877<M1KdbS>W.f91>\=LG_D&81K
D9a&:Q4JYTVBZZYgZ;NMLZ_@aA#<FFOUZPF62FJYI9M:NfU_9&&eYH=gA5]N_?b4
CKGI1ZAb[,gTF#9072^4Z\eGGa>U)/7:V&CG4JaKI5<&)eN_R9,O6)ALKHC<F-K#
0W/cMc2W=-2B-?DL6CE=XS,b0+SbOHRD8,Q(\52(U,I?_@<=M+DLd-0gc&PP\E&B
?86Z30/76g>+0.O1RY?Q\,#U-&:]Q6)]D;0L,V2&C[,8[H\YGbW;G]^SA)\@Oc@@
_TRS#>/MgOP/aGga@535&9^T4;b68NbLQUg4I@a&R_dNLeaQ_.X=_9X9H@-Y.^#5
?_HRB\>.?2ZMH3[V3#XV5+[J&IA>D8V&S;<<OW6?DTEbK#^Fg_]UbRMG^^KJ]1QM
M4R.b2C[CJ3\.bA(BA_D4C@gGdf\c#E?[Y/:fQga\+5-:.B>BCN.6D5aGaY+P4c<
_WU.F+3RB_I4^abQ9C@K4cg[KWK@AP0Q-1W:>1IRWUS@f>JY/_QJ[J\:d/-A#fPP
e^EZY/bXB:@;,FKBB(GIdE0E^X@cXWJ+[@?R+gdP_W,HO5=)=5SKCf5FBC311YNK
U1fI8)>#J^Q.Q^>S3Ig9C83790gB_F&JCRLBc442Cd^OG?&7,K_f<^A)DFQZD<Jg
K_W=3OT9Qf1\cR\DQf;6<#.T^dXC3\C^I1C-eS/POVfL(+93HL#<_6Z8NfY&DK_g
RX\^4EI[&d+B;/O>EMeN;C(-,J.@d?/+?ZK^&:87,]cO>Fe)c^N/5MB;P-HZ40P<
,B<A2N\[ULQ=Y5cIg5\a+)UaYT.A.8Q(XOe&9T3/Q&D&C+>,2EJ8FaS+RX6OAUTL
QeE6[8Y)H8bV0W1V@>K^Z@ZK\#IaFR9,\VTUXM&-]-,;OJ<J+8UN68#b^GEA@HLS
a8XO_dXO4c]G^19.KKK=0O^O.8A)Ac?@UW]gJ+Yae8P^0YH+a^]bODRfMDT[<A:J
IVYDPSWRZK+gdZGCG2N@1>I/PG62VT5T\]Y/+](,1HP1/9dB@HUc4<?dAC)e]X=9
geX-#.c7.a4;G7Rfe93\YCg/S>f@MQNG4Z#HU=U.[KRM+G;BE]Kd/b56e4A6OEV.
R>?Q=3e>I3aWJ#VX=ZT/RLEbEJgPI\@\^>A.3SfLUK^R/a0@8,\,RA2]&,G]^2aE
cDCaLO)9;=.fKUGV._Ra:dER<_@Z=9@.PM#bT<2#>QA:(f_I#;6X6.+EJ6AP]ONG
>\X@Q771K0:<H&1KSB<,@HGd7V+N\[,@_JdcY5fb9#fT=6S6;[ICELM8V]>ECC?2
QN4I>,feIE-#7b[<[/YV3ec:XA&+KCN\DS+:[]@TDfZB4fK,HaJ9d/DZ:6\U/8:#
2>NaLE>A;XG7,0e\&W#O>8^ZT28f(\OZ8_Ve1f95^[3IP6e&f-/=LEdOXY_K(V6G
c1-cHMSc(3bVf#fg&Q]@ZTQK<#6MXB6d[)E.6X+>EM.E6;:dg]T30=^.D368PG:6
0<D;625G;Wb(74>3]W/Y6?bYD]:)fL#VABdVOL/LY0I95a2e=S.Ab+dSc,WSQ41X
g]#NGYK;=,SZcH<K86IIS+gYU-:,97_6)D>Na;+2VgF(6K=g<\VKc(K&4JM5eMGK
[2B>6[c[dSVM7U_\HD,ZOW=EH^VBZ1\D=7agfa[Y@CM]4>@\?XYGZ;IY^US=&X:/
47MH<:W:IBc,YE&XJaIUbS)DB32=E8_5C<FLc3#Q?5G)VcV99:?6J]ZKZDb;_>M?
e_.fZ.Z?/5(0K:,L8GfEQ=OA25D7gP^:#Z[EYM<HbeM:_N>]<ID>P5C5EA<&OUZ>
9)[C?T7D^b#JFUbXT&^)18P[QV.E2Ig;e__gY-+69]?DCY/cLVZZ\Y7XX5^9,2^+
=?f?A/,CAF_G4KD^OA-2Pf4.:_24)JR>9WAV2AU+FUDdgHH_X#,G4dX3..d3&TS^
]&12<e^g0#@4S&)K,edXY/K^@>)2Z0b3P1B;-^3O2IE/@G_161+<NMW8E3O,Q.BE
g7H_6bY.\4fBbB?RQ&/L-b=2^K&Z,F&#<TR5(1BAB>2G)\<^,A]R)VT2X7]<+2DX
Qd)?_L9]6SL9VFf^dfN_O1BL8XA^4S<N/0B8+E[X(WZ:=#+X#KC01=U[2RY5[:I1
JG4,U[RRM[R<^fbEWUP3KCcV]@=\M?9Q>Z#]^J&)_OGaSa?_\Vd0UU7^T&e44KC_
F@VKIdJ+HWD1&?KF4O]a1&]:A=:,)C<^YgI90IV\M->66<Q1#3MG?>_:@G1IR>7d
NWXVY8Y,5PUB9I<4G25#UQ<2DPG=HON&1f(;gTB^7L(NJCDBW^cIZ70PXMH.aF\L
P[P-E(/DCg-F[0+X+dNU[cP#:Q:8?JW&VJ6,@^2;fU2_35ZX@OgTAd3ZS+:b,U=O
=W0fC0K3MTTX75HN\c3f-DbBG7ZTT@VOZE:AD(1#8UG:]25>3?14(^+=UCG&7/_6
M#dFaP1.c>aEBD5b+afODA;S0?g>N(C5LBgGO/N,d;O1W9S0<U?+6Z[e-KK&(0[<
HIW(D#V.Sc6)ROOBd3_EJYW)HH^//:OPeL:KDORI5&KJZ?9geHBC)>>50<FVDSBg
/_>facUB_)DQ91K7.#30Y23I>WEbK>g(&e9RNc5PHN0HfM,@@d@8).5(<&1YYLWE
2.;9V+WD(H&E&Q_.;:e-C;KRafZDfS(2dcf81]WCE&:#SD.H3Tf&4P30?e/aPGgd
gg-Gd=8-@N:E-$
`endprotected


`endif // GUARD_SVT_TIMER_SV
