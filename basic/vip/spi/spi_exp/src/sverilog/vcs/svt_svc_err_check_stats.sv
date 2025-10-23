//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SVC_ERR_CHECK_STATS_SV
`define GUARD_SVT_SVC_ERR_CHECK_STATS_SV

// =============================================================================
/**
 * Error Check Statistics Class extension for SVC interface 
 */
class svt_svc_err_check_stats extends svt_err_check_stats;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Handle to associated svc_msg_mgr */
  svt_svc_message_manager svc_msg_mgr;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_svc_err_check_stats)
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_err_check_stats instance, passing the appropriate
   *             argument values to the svt_data parent class.
   *
   * @param suite_name Passed in by transactor, to identify the model suite.
   *
   * @param check_id_str Unique string identifier.
   *
   * @param group The group to which the check belongs.
   *
   * @param sub_group The sub-group to which the check belongs.
   *
   * @param description Text description of the check.
   *
   * @param reference (Optional) Text to reference protocol spec requirement
   *        associated with the check.
   *
   * @param default_fail_effect (Optional: Default = ERROR) Sets the default handling
   *        of a failed check.
   *
   * @param filter_after_count (Optional) Sets the number of fails before automatic
   *        filtering is applied.
   *
   * @param is_enabled (Optional) The default enabled setting for the check.
   */
  extern function new(string suite_name="", string check_id_str="",
                      string group="", string sub_group="", string description="",
                      string reference = "", svt_err_check_stats::fail_effect_enum default_fail_effect = svt_err_check_stats::ERROR,
                      int filter_after_count = 0, 
                      bit is_enabled = 1);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_svc_err_check_stats)
  `svt_data_member_end(svt_svc_err_check_stats)

  // ---------------------------------------------------------------------------
  /** Returns a string giving the name of the class. */
  extern virtual function string get_class_name();

  // ---------------------------------------------------------------------------
  /**
   * Registers a PASSED check with this class. As long as the pass has not been
   * filtered, this method produces log output with information about the check,
   * and the fact that it has PASSED.
   *
   * @param override_pass_effect (Optional: Default=DEFAULT) Allows the pass
   *                             to be overridden for this particular pass.
   *                             Most values correspond to the corresponding message
   *                             levels. The exceptions are
   *                             - IGNORE - No message is generated.
   *                             - EXPECTED - The message is generated as verbose.
   *                             .    
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void register_pass(svt_err_check_stats::fail_effect_enum override_pass_effect = svt_err_check_stats::DEFAULT,
                                             string filename = "", int line = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Registers a FAILED check with this class.  As long as the failure has not 
   * been filtered, this method produces log output with information about the 
   * check, and the fact that it has FAILED, along with a message (if specified).
   *
   * @param message               (Optional) Additional output that will be 
   *                              printed along with the basic failure message.
   *
   * @param override_fail_effect  (Optional: Default=DEFAULT) Allows the failure
   *                              to be overridden for this particular failure.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void register_fail(string message = "", 
                                             svt_err_check_stats::fail_effect_enum override_fail_effect = svt_err_check_stats::DEFAULT,
                                             string filename = "", int line = 0);
  // ---------------------------------------------------------------------------
  
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
CGe>AQ7=Q7OS[BHeJe#[,H,.[Q#eTUdbbUR0ENYO?RL]T-8O5#0K0(^2O#\(:T;,
/]=[9-BggSN8;>N>Z7L_SCK.g)=0ZS4DNP6);g@:((1;HeYYdOV2#[\O=>Y/Ua^R
e#.JR_AHW:FMN]M:X9f4TMBPPNHK@&FH,_:/AcX(:dO#1D,F)UYT+IB;<N6NYG/0
\@WGEM&8;;><O2N-[SPK.J92I:TCGE4Q5-3b2dR[DR])TD;c5H<5Wc9Y(/_9Rab@
;DD(5>;=8Qf)D(Z._N19Wd&468B,N>SX#-9cIY=8BOCF>[.c9#\V/1@146?<3+S6
T4+O_UfKEN<0H7@5EEIVI1USMN,C&0JG6d&FdI8--c/Y6ZNQ\7GWR)M=AU8[.^&(
+f\Za_VL.d427-(cTd0.;45b_;;AK-a/gKS.CE(>WN81F-J6.5ZUACJ5c+-bV\Y)
g:OUaNU6]_;,:-VBg4=?C0@Ed54M^c):?g1N-,YMNSKKWA<<-W7WZ2JU-Z7b_;ME
C6[8]1)S&N97E0W[8:TO@4g1fY^\RZg;)L]&X7Nb3_=)c4#b(EB>KM2eW?AVVeCC
fYSIJ#deFE:NbZ/eGSZWCc1e9-?+Tc6N;S30GH\[Mf)[;/]M9SM0KR:(<HC_U96#
WK>=1#2RK)N1eJ/=@<#JeK9E@XFCG<U.?F#MA4:H1#=D?Dd2e7<&-37Q@7@>.P8f
JOSA9Se?8Va)TT\:=Y<RU810a1XeYfA-;,ANg0WA7dQ8D5<[e6,GF:LV#[P&^,be
43e[9YVgN:5R@LDL4>c_5b:R;/ME;+fN+0H8/[[0X2M0G\\J;dJ/5IfR1E7NUe88
aCL0-dE[7=5R/g:\]Sf3OL##BZF9b5T3>c^?-c8H#H69>VO_U+7]M=\GeH=EXHDg
Y2Y>?e<6c[GPSOAMTLOZDL7(d084X[d-:#TDK5_0WV,QXdbR<O-c?EeM9_DcQA^d
CC\DPg@/D:L2-S>1G5UO97J?OY0eT9K19W+A+3X53E[D6BJD&?8-WTBTe<@QeQUY
53)3G&:GR-NBDU4?Zb[2G?;:0OI?)]-a+O09Q?UT>CWbS@MXR)0254O.3N^N382E
)#D_D^OML=Kg@/:Q5L@cL=P;2,]g?_GM_+CS.S;VD\9#T+0c5f/[gLW8EC(7A8OA
A1PUQ:1]c/<UI,X4OA>:ITO>-SB^7J8OBYHWAL&H8)dJ,#5]B]MPXFgY)_N8b:=9
/<1/F/PEGAC[dG2SHPYfMf&9&;Y+L@:/J\f&\XF/TBXV6Y/Yf9B8)+\J_LMX+W=8
;Q>Qb_]21[Nf\g(SKcgCP::Y\#GG=UJLO\_5J,)0(C_g<[]K8)cUR3#WeJ:DYBZW
4RcL:8[CD&0.e@=(^bGCEQ<YgX5^:c^a+de)+H,A#3\5TF^Z,cg(N.]N7C4^+T[3
P3HT?:T[E3A0@5)DEZZ](SEBFaTPQ_3V,Oc);>:_0\D\+5S1_>8K>B88Y6:TD+4U
BdR2,?@UL+dd8ADK2M/;L8BNPSRV15[H?/g>R;O_aQRM).U[#20W@XJ;[-,[OEQY
4Nde^Y)48LEVObR+64CDQ6XN@]I^\9S?E/,L<9S(]3/8+&2_,T3U&0UO>A0@HWV?
DHI^.O5H3R)HF.gGX_Db;bF\EU;JC>.5.I;0>][C/7e<P;EIYg8dCS57?fQFXZJ\
;[I3fP?Fd.T<8/4b^R.R9^N7&_WI6_5&I^GFG/AE.8V6(d.ZLM>@+b[S_KWUW-G>
BeCf,^d:.>QST&Y68)S6cY\8:<&]BP64;/9/b3d79Ma:4710IV>&4[ZPK(>)^ce#
Wg(;]<JdX<@N-@?X/G^TV.-X0JP.QP20FMJ&3TLQCdf-=SZ?G7PT?ANA,XD(,QPE
0bJgGNUPb^N@PXZ3YdL4OY^O/1Z9K+&#.P3OaC1U#:CP)>?<9cDH#J>GbF.8UK;&
@OZcR&BV.Bd;25UNW(,9a1RPgc58Sg\P32XY9Q\9-29IXP70PDg3>8:]b+Z.:E,N
Be7;385\7X@E>cG0#P>([]QO^:2]>W?=OR)UFQ3,271gC,OGf)?fEE>A>Y;3[<WJ
G?LacWC(V?,_d81)V>)L>MG3S,@J6bd0WWX_e80/@bM+4P>RH-PfKcce@]RP5R)g
NK8FQU>a.@JN04a)6bTX(HE>1dFaR@?4CP.@?:gULXg<KLSTd9e/I/-Vd<N/GNV9
HQCKB6:,Hf.,C(LS26dWHC>3[Q/<1RE]QN85-S)33TT>TR\SYc;IQ4/)f+5+gIgc
:@3V/.d;-(76(gG;0J;J?^8e;-&5;dIF?#3D+]YcU4Vd0+SU-4fbW4+b?1N\fZ=5
Me/;O+]cG\DDF?+)>[LDS68K?eHRC;>Y@=:(>L]:(>>(bF,,HV)[YWO7@:E4>eaH
a?-51(c>P/0ZYe.2\&H2T=5dJG.EH[A1Z@XQQN6A4d14L)\I<#34B3S8BX/94VW>
;\H6De\RN)HZBW.JIc[<SD[g8X8^>\Vb@c,>M70\4O3^&g^=Kd+82B@d@C3T=O>W
E[WeLZ>Y0@J>HI6KgO0XJQd6LFL_+c\@O4\?JBN8;=HU<+G4d1L)gBE(#a+Raf2J
CQM^F<\,2JdI8B:(59A@S&Z3P^R,K9HG]3JI#(2Hb\+1[a9T,P8#B?I>FIJ8,L,=
\W#&A5GE9/K#PV0YWBe+.^B,YYX^1@Q];W9cM6O)Z0PW3CR?>R_SUR#958Ya1.[H
?>4RXAe0:>bZQ<G&#d5<GaT7Q8D,,e1G5S)f/c2NgYa7.deD2^CPOH@=TP+Y/_a>
)5B4+(,1g/AWNZT9H._RQ+;a9#,MA9cSU1J<C8;Ka0VQ88AgTd^d-BA5P@5PWR^+
&;8cR3,<2MAY/,^eKbZ7E]^7LTCKN:(KZYF.?A;,EHFTEfS8\bfF)3R=RMbdLWAa
5H@+]17\-NOLR=-e0Z9(2cIKO5/g+VY@).C=cD7F5:eDB;0C=ReaJ.P;.+aN1FBM
/4D:55Q7[LNH,;+6@d(2TMT=B\6A>L9H>gbSA[V4(5NdUQ4[DU@e88.BHCF<JIBZ
e31@Ub79TE1ZdI,)RY;Gd1T=5$
`endprotected


`endif // GUARD_SVT_SVC_ERR_CHECK_STATS_SV


