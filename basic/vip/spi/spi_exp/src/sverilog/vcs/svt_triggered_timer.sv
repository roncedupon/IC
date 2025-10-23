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

`ifndef GUARD_SVT_TRIGGERED_TIMER_SV
`define GUARD_SVT_TRIGGERED_TIMER_SV

// =============================================================================
/**
 * This class implements a timer which can be shared between processes, and
 * which does not need to be started or stopped from within permanent processes.
 * This timer is extended from svt_timer and otherwise implements the same
 * basic feature set as the svt_timer.
 */
class svt_triggered_timer extends svt_timer;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /**
   * Specifies fuse duration, as provided by most recent start_timer call.
   */
  local real trigger_positive_fuse_value = -1;

  /**
   * Indicates whether a fuse_length of zero should be interpreted as an immediate (0)
   * or infinite (1) timeout request, as provided by most recent start_timer call.
   */
  local bit trigger_zero_is_infinite = 1;

  /**
   * String that describes the reason for the start as provided by the most recent
   * start_timer call. Used to indicate the start reason in the start messages.
   */
  local string trigger_reason = "";

  /**
   * When set to 1, allow a restart if the timer is already active. Provided by
   * the most recent start_timer call.
   */
  local bit trigger_allow_restart = 0;

  /**
   * Notification event used to indicate that a start has been requested.
   */
  local event start_requested;

  /**
   * Notification event used to kill this instance.
   */
  local event kill_requested;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
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
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter An component through which messages are routed
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif
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
   * Function to kill the timer. Insures that all of the internal processes are stopped.
   */
  extern virtual function void kill_timer();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
WNZ-KQ(>A8CY.c))2Q6:-S<\gBa?V68\+bB32^XGT.?<b[JC0RX87(6KO@_X3SI,
/S4A6C8J;0B]FF1ES>RX0K08QC_-f=>(?\d(<^A.X.aR9N;G0[;[A,5+MZff&H&J
R\WIC/FZY:GYAQT7Tabd7Y#GI2:D_SA\^aENMXXE@RMBE(17d/0QEd>C8UZ@9APA
B#G&d&dEH#KVd,E2SC4]M8fXU,+c?5NGH^dcZ,/DFT&F,)3PZ1C(8#@;W);4R^G(
9be5;38GB]\J_DaTYZDTW?MJ3UAG1Db45dBC@JK\>c.X9T\.S1-b:>I18Q?F0C1=
QTR[A=)+F^J0&[@SL#AMEC31RNB9&2;-_#U[S3Y.P=<E.YR_A0#F;UCDcW(c16=5
EW].QbA1[];eg_,YQT5E/F9&V_M#=3c#\(:W_ZdRa[:E<)D+KgC-[.#[5gcIOL]_
N]6/]>MEfI@U(cTbK/J8^[6@S6IEX.Y2)CI:]E.00dYUeWW=S1e(_Ia\&LT=DU;M
:R2OMJE3SaD3cE-AUR];&5ZY=8,DDR1_?]O@3A^Z?-_HHUcb_g[L#B+Oe=#JfBJe
CA?EdBM2.HZA+&Sc<+UeY?4>>R@Yb55(#,SX1=[#WeX&g2g-#A^ODUFg^K;TC-G:
\_fLC?]bc1<GIY?[F7[#,Y=&bbK?\NI=S[KB55YRc;O4cYf=W>B42Rae@Q>ZbY1;
/JTV1eT2]N&J(#RGD_+aBFY01PPM6OF+F,a)&PV6@dV5?]6>.bMZ(/DHe3abe4Kb
C9S);]<C_LTDa>f2)N1K=eC+2#U<VJDG96]Q:D3P_E3&;&^,(B.PMBZN5]WQK+9c
AD,10:dT:7-Z12MN5@=ZBQG17=]=)@<WVWF)a3Fg,&fJ8J=9cf?MP<2VGLE1aU=C
=R2/U9(ZP-fLB[^?43DL>1\b6>ZW66PR8^9R:Jg(F]._0WXaB=EHeeO517bO>#],
:Fe-,@\2g=f?]eRC5Y<H-BDTTDfd^6.9CYRDO+Y1,?)5CKNT;EaNUI277;,ec#^\
34f1BTV7AVJQLRRXEe,#()M^&?G\O4<\;\]+gCbU/8fBdD[(?2::BcfXc^@EdH9U
6Y/P>/3BLT,d]ZJb&(]^59fQW#SY5#4YN-Z^;>^e.8W9[\=_gA?.-87)UO_^0fNb
//VWNX:a]X<L[d^Q?3_De<5&#?4Z<TceWVc0IWLWL&ST@HOU62]A1<4VM]-D]Pc@
//)5UD^L,(L4X:d0OW/bT,fV9:4-Y2cMOD)a.=B]MNH_^cI^K)X9eXAK44#[?/8+
+<YE8)++17[Pc6[238@BDcf]a)A@A,Q9E5ZD[KU;QfHbJ\W&0OKK/e6#dfZKMDQg
O]4g?#9b:HDG+E\<6e/_D#IKSF[;Yd=&@YR=[W5\JW+9V2\RY^2E+:Q:Ca&Q=@L[
PME8g6ADA2;FW^ZB,A]A:3gEID\7OW:bG&<dZB_#9bR:PE)C)6EGg/)6<XfCdBJ>
98<LV9Q?V<QI=51KG33-7g&8g&HfA.,f>Oe8@dZ(33JTX,C4UHBW5/S5?S(.YYQ=
FcOOI+(^J<G:5APZ[Wf46H==[SL([Q[PFE?7gBU<FMc-)b##^AW#>X#V54JF/)H\
QYC7d/ZQ)f;YFdg?M_N0UN^6,\8I^Q7JNA^=K_MAM9/bXZW1Be;[RVU]Q^f0I=YR
_1^ET4M.6S+V8WdZRZ^MENaSD1X@Cg-\&Oc_N+7Sce/?@e&7W#(Y7TA3(82&A/&V
.YP\W:e[dB.T-6<[eOJ4fHUK,1K4:)N@3L+]GJ3PBZ1HgF=(LA\(P,;Z0\AZ3\?9
]7Xd42,0HG0R?8\JAfS(#E#?Q9[#ODKPKO#_I=TgL]T=AFIHK?//.3cG0gZd<cP+
8?bT<_X#2b6U::9#c\_<S=50&#8:[R8EO;XQ2OT]U7Tb?U]d4(g/VX?6.e2b@^<T
]_[K=deTc/&/;M3L2-DEG+K;+1[\8;#6]BQR\2E<6WW]N-^VFB#7,@G3QbUA.F@4
479\JeGSP[=)\HcbIGRA,cJE=b>BO(H:Q&2;?2V5,4bY<3A[4AO+1S<59.[UB94c
.D(DJ;-A3\DC[-VIeEf6d72+]U+KRbNU[BW-(N)->XDa+ZJ[=_#\Sa=:0UP4FA9=
\,Q5^a;[E+[+CS4S&+)/0V\=aLSP<B:HQ(CRW?AIK9.R22HIVU.QN^C,^&1>,>C-
P)17OA72F[g4)=G08B(AVY-F&g<-RK4\^75_NFZI6THIaAH4dU\,=bFGbcc.FGMS
@A3e(.Vf51<(M4LD0:<&5a+6\cg.C\IKMDWS.H3QN_^IE$
`endprotected


`endif // GUARD_SVT_TRIGGERED_TIMER_SV

















