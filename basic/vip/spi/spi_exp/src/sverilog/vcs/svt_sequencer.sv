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

`ifndef GUARD_SVT_SEQUENCER_SV
`define GUARD_SVT_SEQUENCER_SV

/**
 Macro used to implement a sequencer for the supplied transaction.
 */
`define SVT_SEQUENCER_DECL(ITEM, CFG_TYPE) \
/** \
 * This class is Sequencer that provides stimulus for the \
 * #ITEM``_driver class. The #ITEM``_agent class is responsible \
 * for connecting this `SVT_XVM(sequencer) to the driver if the agent is configured as \
 * `SVT_XVM_UC(ACTIVE). \
 */ \
class ITEM``_sequencer extends svt_sequencer#(ITEM); \
 \
  /** @cond PRIVATE */ \
  /** Configuration object for this sequencer. */ \
  local CFG_TYPE cfg; \
  /** @endcond */ \
 \
`ifdef SVT_UVM_TECHNOLOGY \
  `uvm_component_utils(ITEM``_sequencer) \
`else \
  `ovm_sequencer_utils(ITEM``_sequencer) \
`endif \
 \
  /** \
   * CONSTRUCTOR: Create a new agent instance \
   *  \
   * @param name The name of this instance.  Used to construct the hierarchy. \
   *  \
   * @param parent The component that contains this intance.  Used to construct \
   * the hierarchy. \
   */ \
  extern function new (string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
 \
  /** Build phase */ \
`ifdef SVT_UVM_TECHNOLOGY \
  extern virtual function void build_phase(uvm_phase phase); \
`else \
  extern virtual function void build(); \
`endif \
 \
  /** \
   * Updates the sequencer's configuration with data from the supplied object. \
   * NOTE: \
   * This operation is different than the reconfigure() methods for svt_driver and \
   * svt_monitor classes.  This method sets a reference to the original \
   * rather than making a copy. \
   */ \
  extern virtual function void reconfigure(svt_configuration cfg); \
 \
  /** \
   * Returns a reference of the sequencer's configuration object. \
   * NOTE: \
   * This operation is different than the get_cfg() methods for svt_driver and \
   * svt_monitor classes.  This method returns a reference to the configuration \
   * rather than a copy. \
   */ \
  extern virtual function void get_cfg(ref svt_configuration cfg); \
 \
endclass

/**
 * Base macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file,
 * and only if the client needs to provide a 'string' suite name. Clients should
 * normally use the SVT_SEQUENCER_IMP macro instead.
 */
`define SVT_SEQUENCER_IMP_BASE(ITEM, SUITE_STRING, CFG_TYPE) \
 function ITEM``_sequencer::new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
   super.new(name, parent, SUITE_STRING); \
 endfunction: new \
 \
`ifdef SVT_UVM_TECHNOLOGY \
function void ITEM``_sequencer::build_phase(uvm_phase phase); \
  string method_name = "build_phase"; \
  super.build_phase(phase); \
`elsif SVT_OVM_TECHNOLOGY \
function void ITEM``_sequencer::build(); \
  string method_name = "build"; \
  super.build(); \
`endif \
  begin \
    if (cfg == null) begin \
      if (svt_config_object_db#(CFG_TYPE)::get(this, "", "cfg", cfg) && (cfg != null)) begin \
        /* If we got it from the config_db, then make a copy of it for use with the internally generated objects */ \
        if(!($cast(this.cfg, cfg.clone()))) begin \
          `svt_fatal(method_name, $sformatf("Failed when attempting to cast '%0s'", `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
        end \
      end else begin \
        `svt_fatal(method_name, $sformatf("'cfg' is null. An '%0s' object or derivative object must be set using the configuration infrastructure or via reconfigure.", \
                                       `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
      end \
    end \
  end \
endfunction \
 \
function void ITEM``_sequencer::reconfigure(svt_configuration cfg); \
  if (!$cast(this.cfg, cfg)) begin \
    `svt_error("reconfigure", "Failed attempting to assign 'cfg' argument to sequencer 'cfg' field."); \
  end \
endfunction \
 \
function void ITEM``_sequencer::get_cfg(ref svt_configuration cfg); \
  cfg = this.cfg; \
endfunction

/**
 * Macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file.
 */
`define SVT_SEQUENCER_IMP(ITEM, SUITE_NAME, CFG_TYPE) \
  `SVT_SEQUENCER_IMP_BASE(ITEM, `SVT_DATA_UTIL_ARG_TO_STRING(SUITE_NAME), CFG_TYPE)

// =============================================================================
/**
 * This report catcher is provided to intercept and filter out the following message,
 * which is generated by UVM/OVM whenever a sequencer generates a sequence item and
 * exits but there is a subsequent put of a 'response' for the sequence.
 *
 *   "Dropping response for sequence <seq_id>, sequence not found.  Probable cause: sequence
 *    exited or has been killed"
 *
 * This message has resulted in a great deal of confusion on the part of SVT users, so
 * by default this message is removed for all svt_sequencer instances. It can be re-enabled
 * simply by setting the static data field, svt_configuration::enable_dropping_response_message,
 * to '1'. This will enable the message across all svt_sequencer instances.
 */
class svt_dropping_response_report_catcher extends svt_report_catcher;

  function new(string name="svt_dropping_response_report_catcher");
    super.new(name);
  endfunction

  function action_e catch();
    if (!svt_configuration::enable_dropping_response_message) begin
`ifdef SVT_UVM_TECHNOLOGY
      // NOTE: In UVM wildcard is '.*' and match is negative...
      if (!uvm_re_match("Dropping response for sequence .*, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`else
      // NOTE: In OVM wildcard is '*' and match is positive...
      if (ovm_is_match("Dropping response for sequence *, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`endif
        set_action(`SVT_XVM_UC(NO_ACTION));
      end
    end

    return THROW;
  endfunction

endclass: svt_dropping_response_report_catcher

// =============================================================================
/**
 * Base class for all SVT model sequencers. As functionality commonly needed for
 * sequencers for SVT models is defined, it will be implemented (or at least
 * prototyped) in this class.
 */
virtual class svt_sequencer #(type REQ=`SVT_XVM(sequence_item),
                              type RSP=REQ) extends `SVT_XVM(sequencer)#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * A flag that enables automatic objection management.  If this is set to 1 in
   * an extended sequencer class then an objection will be raised when the
   * Run phase is started and dropped when the Run phase is ended.
   * It can be set explicitly or via a bit-type configuration entry on the
   * sequencer named "manage_objection".
   *
   * If the VIP or testbench provides an override value of '0' then this setting
   * will also be propagated to the contained svt_sequence sequences via the
   * configuration.
   */
  bit manage_objection = 1;

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;

`ifdef SVT_OVM_TECHNOLOGY
  /**
   * Objection for the current SVT run-time phase
   */
   ovm_objection current_phase_objection;
`endif
   
  /** UVM/OVM report catcher used to filter the 'Dropping response...sequence not found' message. */
  static protected svt_dropping_response_report_catcher dropping_response_catcher;

//svt_vcs_lic_vip_protect
`protected
-TIXP[LBNdH08Y0cU)YU>-^Wab]09FURaDU4A?gQC=8GR9_Jc;]M3(+f9F,XG2/M
SI0,6DXdA?]8;,@]4MZg]7\Sfc5aR2;gQe;S42YV@,W[P\>[XM;;f.Q@&O:TN?Pb
UCDH9bW&M;6J/<1Z)c:5dF9=]0ZCA;6VaC1HPQRXQE-L;M,TT(D:)(+3I4f>[bD5
)=COEEVVJ#;>AQ3bPO4c73FWKge@(YF>YA2[D?3L<@fa[;c(IL#T+3eLd/LYDHC8
/&CE6f(\e):^D5TaX_QP/X(_.b)LH\>a=7-e]^)-SIN+8/1DR?X;QN^Ub1@dQ,,J
[.>+9&FbP<CCQQ\V73ed;@4+2(=-[g=2)SFX(d@=Q/[NFM]dZRB[J)B=UACa+=(5
U:bINML/]eE;cOO1)-).HPaP]MK0Jg?W515>:C6]Y]F)#LGSOYA:>B\H737BfK/,
A[>[NZ0C#I\)]KTQb?O.6Y;XbX-cdNVU5AJ[O[J4&<RY5X>[>.Tc-,K\^7DT4dL,
>c/LWOJ>+9Z4ga#6DYSC@I]NBG.aTB/F3F:DYDM[W&UaR^3(O<-L31FZ\HdCIE>c
?G=LA1eSI6,5CV?:a5,\5UO4,cZ^&ed55L9RJ./+:R^HQ^]WAU&PSJKaOgdY7?P\
_Y[-V=>:b((-AD;SaW@e#)ID1O<^LASbJMOH)&Q50b/95X(-#P@[^4HK/,1RKgY-
V-fN^,=4aW<(-N5I(Y2Tb@_TV?U05IF-4LO;P_<6[c7ZaR/S@WP\U,4FZR#/W_W/T$
`endprotected


`protected
_@^ca(PY[E3[f]9[8GN>T),3>YGD8P+GfNHI9>SP7d<WF5A#+(VM2)-;f&L#G?Ld
4-[4&:X,9.4GWD4QeS<8E_0b[LHR@V7::S-CV4QEX-7&<5C.M61Q[BFb&g\Jd)RI
($
`endprotected


//svt_vcs_lic_vip_protect
`protected
I:2]51bSBD4gUe_Q0MZ6C60Y2>K)#?Z/GS[RMK36,Gf<),;DT(]>)()^BgMP45[X
dHD>Y)#/S9U[Z8f-GF->Sa?NOZ^Ne:.R=9K34?F9a0]e3DO@T.,[0R2Zf=gJO>T)
98D,b;LY.IWJW4?W-HCZZ\E0+?<V07\S5fI1HEMbg)3K0H&]ScAE(>H.C.EB\]-)
Q<_H[g=#C<6@D)M2O/E=O2J):]C,QV+W9@9[O&YSMA[ebAYFCeQ.(7QNaN,ZJHK1
)bABM?D70Ebe]M\U>V/ZY)GU[4??]I?GRcEDKL[e)WC?=C4MXEHKIc70CG-F@]C5
SQZ/G1E=&b8=g;EFHR#,-cZ+6c1P,T[+.4NXEUHe#c()dC3I(gcYf)A:AH8EL=VD
DVJ&\Vf50;O?/R_VV;)N8&W-LBA#J/(MM]FY63<XF.RdV.f>I:_/4;6E72d[\(]#
\[QI]:E7H8Z\N_Q<d2/_CXM3K)^NH>DZLR:SeH8?O\#Y43;CDF9DS8]F-B66&FE/
J]N7f67T(U2\-$
`endprotected


  /** Class name of the transaction that this channel is customized with */
  local string xact_type;

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name = "");

  // ---------------------------------------------------------------------------
  /** Build phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** Run phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

`ifdef SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  extern task m_run_phase_sequence(string name, svt_phase phase, bit sync = 1);
`endif

//svt_vcs_lic_vip_protect
`protected
TGbeNQ;Z;;-#eVT+Id3WZF-?OcECMb[DLWZ&E@e\H0P\/R1#TB6a,(U8JBQBR0/G
[XWS+2eRabN.SAg#eA9J_L7<MNGfSa-+fNf[BNU.PE+7/R.&RYVf]?<Xd,eaHCa7
a4D]=H7g<+KJM53^U@V_]LYe9@_BXP)/g0UQZb98>>CcWV13XF^I2VT-2[+ZPMfM
TJIJ<F&215BYJ25CQ@7I.MOfEC+Y:Y[ED/)DaAcYfCQ/3HEU68:W)aHFZ=&2V7gP
bPEYE-_FX18Ld/<+O<5PV5:ZO;Z1Q^[I75O]==OMODc)aMf1]=E8-4=L_YA5a98)
XAeE6Z)LV#6HHJ#AG3F;0I9@CFbTII-]&M/NgE7YaH+<DXKJ5>+VUM\.VJKHgR:H
8=#:17#=/B#cc1UE6A:(TI9T-3<<f\6/Y((?(eOD;X:7;9L0_M&?)L#I=OR<9S4:
e5Z6U@bZVCfD[E+H&15Nf.gdR3&9RMHAP\.((A-IFGd/J+e+L]M5IC#II$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
+)ad?2QECVgGc>+Da13?g-L8/H+7:+Cc9;\LaTdR/4/TD.G_)I0d5)g?5W0IS.5,
>7A^4bS(#N;QBMTZ1:6-,V2YT?,EPON3;JYg7(Z-9[\;K&I>UEU-=cW\Q>55fE,1
31<?1,9bCVH1PKHaeNeaL.2Y1$
`endprotected

  
  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the sequencer. Extended classes implementing specific sequencers
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the sequencer has
   * been entered the run() phase.
   *
   * @return 1 indicates that the sequencer has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();

  //----------------------------------------------------------------------------
  /**
   * Finds the first sequencer that has a `SVT_XVM(agent) for its parent.
   * If p_sequencer parent is a `SVT_XVM(agent), returns that `SVT_XVM(agent). Otherwise
   * continues looking up the sequence's parent sequence chain looking for a
   * p_sequencer which has a `SVT_XVM(agent) as its parent.
   * @param seq The sequence that needs to find its agent.
   * @return The first agent found by looking through the parent sequence chain.
   */
  extern virtual function `SVT_XVM(agent) find_first_agent(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Implementation of port method declared in the `SVT_XVM(seq_item_pull_imp) class.
   * This method is extended in order to write sequence items to FSDB.
   * 
   * @param t Sequence item supplied by this sequencer
   */
  extern virtual task get_next_item (output REQ t);

  //----------------------------------------------------------------------------
  /**
   * Function looks up whether debug is enabled for this component. This mainly acts
   * as a front for svt_debug_opts, caching and reusing the information after the first
   * lookup.
   */
  extern virtual function bit get_is_debug_enabled();

endclass

// =============================================================================

`protected
JRWSWb))_J9=#+V:)UaT9Bg(I)ZQA<,PHSZYP3_f@8Y:+._=)TAb7):0fGg(>3Af
aM@Rd)9:T==BMQa)?PV/R&Vc,(>Og:GdLY=RJ9?_MPI;cK9U>T2_N]6gP/U=TDLZ
W(KKCb@BccfYTXZ8?@^4O+dRX1]GfPbgR[?<TG+CEXG\H>-2X@f^+^T8120e)C2C
/^>@C22PBRDWF,4bY&.Qf@E\5,K?4_NCHR.;B&OP<B605[5&0&VZWY;EVH3;<B&c
e-5g=B+I#EAg#]AB=T>J>bI7)NcRD.X/UbdK7J176<:+=&W)]cf,KB7@S@/RV1N[
OCJ(=S^gGVFcFYU^=.0>@FNW^F@D\]Gf)V-+a2B7?c[aMN<S]HL3#/N4^QJ_G[,G
T]4@XGaF@>S:Z1[S]U;J_HGV1cQ7d(PQGf9BU6X\2OI=D8^_Ad7;AK+4JX3C:F&X
PBTJ3139\BP78P4-B=P5\>V56R:?X:\E1NNJAXB)V/Z\a>VFcFYV&<,Gb?/=P];)
NL=\34fgA>f8c]5_[5;(?8=EQP=\?d)Z[d6:e75#S[_A?6e/d[:F&eW6a97]PFXd
A\(?)[IVA/<LX?-ZW#JX?E_T(DG\0M;RSAf3&L?@)M_PK=CgEL368+F^IM<Fg8CX
Cb.9REUWYWa,S)b9c<31AA>/T_RJB^eIf7BVPA/]3NN0(@D+^CL5>ODfC&Ne^a+&
XMD,eQdc-SO11Q##X+BeRX+N/NgYMA]-_7WdKW92701LUL<R6Q3Q([fX?E6AWS;O
J)+QeNFL:^XJ+FD0P4SC:/(1L]=KB@eP+;:e809QX+<40DW8VT1Kb:_<f:^^E,B9
2P-gOH=-aCaH.W0NB0,IKMf^QJTZMH>e_\)0OB=Y_gD]&9/^f3=d.?+1.fA?VO./
e68]UZaX\d1T)A46,G68^B6.g[cdb3IKVD0c&49WEAW3WeDWQ7WDDH1[VI+70Y6Q
460;5_IA>Q=/G,\:eO49UFBT(b7dCc.LPM-IG9Q-ZaS,#bZEMGWF(..W>;f=+Y),
D8^Bd@.YfWEM,U?W[C9]fGWgAG);55&GW]bd;ZG(P\:XZB_7YQ\_+[6Y\:^)(NeI
\9PBPSUZAf_I6Ya(UH?D&<I;MMDEE0GTdEgV=#J_(1-IZ/&6@0V<,T]/UU.SFbGe
->@/Z-b:RK9H,P;2+6^M)EDV__Na@I?.P3J0GQ6;^AKf]^W&aH3e;RF+-@#A)0cF
(aUQ4O5aPBgFJ83(5)KTM3c<LXTM[/,CV/N\).S0:\ZPCX?.9<\25S03=2D;>\XJ
[LGR\[;eB26[7a.3bNR@^65e_PBd:8P1CL:Ue=a]UMR?3T#W7?L2,LICZWD0fTG=
NN4OO4B5:CKIUHDMPG5e-CVI7TdMI;B<0;0U#]?XY#U0dV)Z>+[A1+A480,SPF+d
YH^d.UPGQ7aIA^P-f?(,/c-=CY@5@DIbO+G\QZ>a)&=6..>gba@8IeWIHJ9FfG8Q
MI-7J_CI^ICH&\.+]H@=DWM8=SLK3,I-D=1N)5:8[a@(K=41Zcde4Zb(=82BM\>0
U32O33,?(P_2HZb8-D?+959aZK4MPUZT#7YTB5:GTVHLAM3L^JCIR&[f/G]S-F<g
(190eQ2ZbA__NWgAU7Id.JO@c24/C2WPFWAS:?8d.)P;+eWT0EJUT<C2(U&K\H?)
Pe&3gPe_57a#WX-)-2g>C?9e#W1NQB5gWN>fe[5K02KT]@?CRgA.9(c#-B1Eg0(7
OJf-Q4Y\07@:,_=G;7YS.YUMFLSUIO9);]NAA=0PW[F/CWZ_ME1NM+RJ4JY3;P,M
?WW2>P,>M]U54/1-ZOGQ==H,1LI<T>&<1+G7ZG/\DfP[Q0D=>ebQS;b@:]SHXR/H
+W1SD#P-ZNL&).&QbKHWG:a9cZ0bD5-8]/TC8WZBfG>3RRPf+(S2:b@:?707XWe#
dKF>1.(XH3df^2^?S9P>_NP_Lc:57/@D<)_D1dR08IKRXI4(G<QJ]7N.16VA)db/
?[<5\ILLWO\_4<:f?:<fc]0S5)R\(5U+2O/#e84NS^;4NfJc:;<SR,#H#7aG+F>\
C@:V+C>3;8:4\,,W[5MT,+c9)?U:Q0Q+8T]E,,Uc?YP8OG<-^E)&GC0a@3LcYN&0
=^-5B24#+)G[8eXc=&OV6D2K(JT)a.YKe\5f.L)Y91CR9BKIaMOZFU]7V]a])N3R
06IMaG=W-D/cV0X5N;A5<4/-H>-2Y\&M<UVfDfHIPE2-9W-TObT.NBEXC8Rf>TLZ
N^I4/20c1:UD0Ee5597(69(R^N,,L)^PE\aW5&D7^K0YO=4+Q8&2gETW7GMJPSI_
^3H)_&AR:36Vb#f\AII?S](8\<,IKYG<d\^<@HN+<MTA2cI)9D>;+fg2J,VP_>g1
C[QW]I#[JU1(LQ-(EO8UFN2&.O/DcH,Z1.1Y48T4#S=BY:a-]8TT1QPEC+b+\MC+
4^7)(g?I,d,/AKa;XX6_>E)ABcF-W.SWgD0N#YQNW1BB0^Gf:g-52)P18R<f)\;9
YR9-dUO,f(f(7[9;;2D;@b0XDgZUe?K1J]/-cZQIOeH3O(X_O7[-5(ZSJa-)LL[&
/VD8gM)IU043_aV@J&HJWC0gWN&0,TaCMc\G9c4S9H&@@X?OPRDL\OU(A23dAW;;
>0:78eWB4S@5fKM.6(FT;K(e363ZAa;4?-R0f812;)J06<bF6I[V&^#^Q#SdQ?87
ZQ4Q;U0-^3bOTI)-,(12YE+H81HG]\/[f64H-(RX-25e7bL5X7ESKZOAbZBeQC/-
ZC+d(]IIP=#E2:AF7WX#-[HN6.1Y0efd-I]Y)8#EJ8(,/PJEPRGd)Q9a;JYIceX7
(#.Ff,])I:WfGS8TNf.=&A?<#?SgcXE#(3O&6R@(Z-IB=D./\-+@-FBa]FC>6=)4
NZOa?\-g,a5d6YCL<EF\JLA7SGUJMJ1(SE]A^UO[@9Eb36A@cNKP+;V/NNRJBH3B
KdgHQeALAYU0C>E/Z0W1-C?U?D]d1KK86cSA398MO;SNZGSNS0c&-S]A-3-;I.49
CAGR[#45a(A6]NSe2gV<233IOg6=/XEZ^2BLRX63FUT,>UcO^,]1Ge09CaR181H#
5J7,^;GbI+QQg4W+>ObS@8bY6g?=;DUJXF9bDHO=G1F.[+HOUe-5+2TY94>bDU(U
]4LMQ.NFA7CRc/&22N&;/SDX2\^aM.-6RAW(RP+++M)#a;F/[K42E^TO<H(/1GD\
cF9_LL_17@HT+f2>(+XL54<AeHR/Pd[bT1P<Z.-BKfJPff9@=aH(=I2_I&B9]=g1
0a.QWE+1IV1^&DX.SE<:?=Mb;7\IDdLfHe#(&DO6F#V[SG:&SP;GQa,(2]M]>1\=
K&P)#158ZD+9?[\[>&AbY_e._-9(898G:@:PHEa_&K)dd3-88)B./Sb06++ERfd)
EI,d\?,[[#bJ#a;TP>.bN/Q-b8,_K#1>Be0W9dF6WTWC:,>U/63d(@a(MLH\LY)6
L\Q5c8c8SF]U\bO<LN\.E^(9,e?;IS,WB+_8He;:4JEBNcS1])UaPC65&(1-g6_7
3/Ab]K.\;X16NDPfc^O\K=]9W.DBL+22Hb,Z1Sb+_W[W)4B<MWR^Q\12IJ9:0]?E
YK;6fR@Jd#ZU6bWB7Nd&(U+3MB6;c9)K3P-BgMNPKdOcdVQA/=#bH=Q<dWZ;^7Qe
EJY&&89GA<5<:dI?4=_DGJ:QHYJYeC?&3A:8_]7YGbOGB+NQ)bK+dPedN4_SZLF4
B]3S?P-^L8:a9Ob;/dOC+Hg@J1QG2CW0=V88T\3d8+_f;]O?O;]-[8SY5^d6,OVa
S6,+>A8QU=<2;[]I<RPHSNbB2Z(?fQ6H/c[X7]W;3[PcVPXERB_I#d-1,=41TUDW
BdYW4KY\/V0WU]T9S;9gd;+;,U<HM&>V-aHg\0\da+(18C<JM-ZNG&g;5A&=_TDW
(/BQ(:eS@7D/I5e/YcY&#fD_WCWc>3]FCfGgW2ea,278=b<eNVEMK0_2-EIK++IR
Sf<L-0LMB>)ZM=?e1[\MYYEU0.UV8d>@2,3H_e(V3E+c-[/fM4L/,&YH-J_8L?D6
P?94B-2#2R@>S(cA)/?Y8A-:JL_2)Ed/Q5BOB9b3T-.>G_4gGCG7IXE:FBL86>=_
YRBBLf@?WEg6+[8M_?HHa\6MKJ71.1HR06;803X;Wf[c)G40\53#Y\J+QZYBU.)R
:&N+d?P^G(_>#WH<bA-Dd>\/H03>:-[OgZ:2&&+50(cRT9M01GT<\_CX.(O<PCaT
M?HJ/)g1-e.#J/W,=5UB2HLgN7c]d]RHWH_+YfOAH#[H0PAS)bMc<&0@BM-dgYc>
e5Y,\Dd57Pa.EPZe)&cUb&?8)N46GTdLD:HAWT3ADQHMFODD/#E3J-<;_.YKW20Z
1IV+O[b(PB<OS0I2C7?g0,Eb6?Z4c<:&TaK]_/[A(aKT;O/W6(1VI6QJ9Q/XfLT[
Z8^#@3_R#T7E7&O&S[@-9NGWC13V?E[)UTM/&ZV3+D>C(F)6F?VT5IXN1c.\Y^KE
)(94e=]H]6c58HK5R:SGL4XW4T:)(>M@.K0Q?cZ^_<Q&L#F^8+#c?]3-]81Pe79C
UQT=d6+2W/N>3FY<3\S+_;Za43=PSJ134\,94(2@T]-[>-cO0D=)J[QBF.;(N\CU
dfP&MPabX\.PA9)gb80S&YLP)OF&MPBgfS3]O-)JE[[&=^&17Jc4L/&3<,UYT3[B
3\HGeJ2/?/[]BQST.>T/.MBT]@9D#SDG5MbZ1B8LD&A1L(,Tc.Ld59W+7[R=F#ZM
V&82AC=)&4-dN6P\eZS0,\>,7K\RA<,2dQ<b4+-D>.3<W[gP@b&9TXSV<20C80Ge
@?g#([QQN(@=fKSW\W=,[-K-2.NKM3Z;A=c0=F_E<&^=0V]+2>3DXFRRUB17GTAH
N69>REA<G\\@HMI]M&W.<P6b7)aH=-O9E8,:J>aE59IG>D8(1??eZ55MZS>\>b:H
L1+B)RE.RS3/8V;E/)6=f[A5XRX88)/TX?J[)4[\5QP1,]&OGaJ):.,7,0>:7a\H
-d4&c8Z@Df:LOKFW1=[4bD[K3Ob&WZD6VZb]3?LNE?FN1\Xa:?1^O8NX9;].g1(;
23SeMUZ-AI.&1/RA7[aI)WTJ-^aTfK-YFEPHd7FJb<\dHT]11Y+YaI-Z/W?;\@/E
U9-9g#K)YJOTTV#E>&ZW<4TbD>56E(87BQ:9-AEEHe\@P?XUI7(=Z01CRYA2O,[O
VKJI:9^/R;<L3\J;S2PJ2]d<GF7+bbXN<EfMDb/b;LSF_8QOOM^bF^Ac/-JZ/fGY
#Eg^S,Z10AP7EX,f#9QK,e]L?[If>ZYA9O@SU#B0XAZO2O88L\^G>.M^2CEP#Q]d
MH&=?E5O#&W)4G1T76RMgYLS;eadOF,;b:NeNOG8B.KXI^b589;b[U:D<XD_?OE@
Q4YR-M<+aSV_D-N=AUDfPV-@,B._3&(Z=67Q4\CG\gL#ZRDCTG5+&e:]4X=b)aN5
^da>QeE1A/TGbAZ.eF@3d];/.T@5eM)KR:4T3R5A>.M@1QC.A#8ZY)?2\F8Fg0eP
#dK6EU6gUGgM<95NH@?JN=WPQ&<L_-eGL>AM.46+1_J;I?KPe2VH0\@LU],I-7W2
g>3d@4c>gTbXB@<Z0EE^@73YL886FW/0AF/#^U&.62<;+XK.:,6Dc[6QQSa>g1Y,
(Qe]Z5]E@1Z_GSCA3@-0g8e^b/cbJ^P&KCPMIGR0#T<..-T@U/a9Q8L=QUW7fK9;
Kf[+M5K=;_@MHWc\F5[=H7MAT7bK8LP-3NI/[g4ERM[^^91E#;NTD;O9ZU(c4-0N
1R5X-ZAQ,]P;O1Q#B]_SKF:(UUK\)Ve4AEDPd-dgS9aHH\/DMSS(<RV.Z[DU>3bU
5\9SGQKH^fa<#(2#3ELU24SWG8)DQ2-Q[C-=E2<Y3-9PQ-^(4H^4YL3YaK^3Ie:_
]?ONH_cAGKR<2[)fD45\X=O@^@3_[5]:EDbS/ITP^Beg<Z)9+/\F8J+2TL=WP>&/
3,HPFd>A])6cAcK3]M8;g=?#[WOJfbg@#J:IH.-c4fIX,L82B1PecGeWT>S_5Q-5
+76E(HKDfDV694)H5aZN#;>C[;3MYababTLa_70C#JfceDMDBA&A_4\6;&JAE3D@
9#01-OUTD60-7M-fI(1.d1])?:JRbM@_]V4#M>B[3:J0Q=7bKHV<(QPHQ18XSf/\
A+dQPAM[JA@X1P7dZ-;SLCDV^4e)K/-a?Ga2aXQL/-PO3;+aPC+GC#L:<,Ka1JYG
_>TL-ISQ<SX2I9C<AA?&AKVUgUA=A#0>,VEBD#T&;(?:(^?<<Kg;4I0]@3\,H6(A
C.</P]L>\_Rb&IS(U5PZf)e,+MYcPJ-+&cYg/>7@S?>C0,E4F?O.HYJ81QA_;8fe
aGD0Q6U?FZ&EVM4_O5.38;_\Q,4EO]B@g089OH()\7LY=C>CKP](/,_.R/R0G-H6
@@&XQVVOAfTYJ4fUc>Je[UQE&^M2aX5.eW,+Y9CX^^7HFG:DF^TVL_G_[1H20[0[
NUMe6ffIIGGL/_:J6TG\AV05_bV?W0d-C=g6QcLEc^G._H/g&N;;,3,eD6YD>N6@
P&?IgZ;fH#6B,M3D..QH/I7?5bT8?A3bS9aUb>T4S2Y0/ATHTg)5[OP@<[N(IgP.
&[FIeY<A#&WC3GJ)eJKg@K-^]P,S^6.G#b\fB^3g4(KUN2F+X8bSDPAS@W+,?.^N
N1,8+HR:S59,+VMHbG@bTGbbFM;@Z20#1D\R6Y#b+_Q)cg;dKB2AB^.L-95?0b>V
89LK>a6@PTU:A843gD]agF(0U-9V5Q0:]I1/\Fb5GR4eZSR,IQMF34?^R;\VgZ93
B_5Y80Rg&KOK=@f8:\RTAP91\V89c46aC&aD_X=-_8D]Y\]1U-AS;5/QHD4=<]e[
R\/>;M@)J]?_;a;M-1/Af.dAH74e([M,+?1L[)-?+)5:e#92V_;L3U+5/cDW]/H<
L:G0BC<&Q<E3DQXSTe<ZRMeI)MQYOJ^^U^Y3eGG6R13a\)?D=?de]P?GYZ-WR>IC
RHb,Kd6eRS.LXQY6@K[MV.[a6:0gBKRe#W1HV>MYG&D=9A94(PAXO-b.4N;FaYDI
GfB2BdEY1g-JQME8A&4KO5RMC?WD&+#>bW^Z>f3d1=^G50N]UU(BMCC;a&MK)91J
V+(6F@ZM^QA@CdB5]KDC=U)DfIN:,B9-H1V6B16URY0N#7T\:/TNA^NUV#O)&>A&
6[c,ZfaLP<dLMA>):(O0Ea;KA5OY:()DD&(E+/CKdT5]:Sa27>b=@G)1O+eFf@@X
Q=4I<WTJIQ=4MTcE63V4gVgFZRYSDgdCW9I^_YKeI]<-KV5SH4H8,=H@Sg^?_>\b
\>d8/]5ZX<<O@?(NJ1K_72Fa5/U0EWGbTYDd?V=9:a\G&YLK-X9g?O0Z[G=T^d=^
3BP^X73,Y0GP_?3=PL#;agb\>S;60@eMHUd;GT&5@OS5;4QHXgT_;/;d8N6:]A-0
SV8\2f9[A/(<\K_-M/b-532gV>O@Q@e,\9P1Q62<.gM9R24M:)YLE=>0Z^@O7F1;
FQ/(C)ZJ.L28b&PGS[g_f6^G-TfTPM@e\c4#/7?I<\?;Kca#;N#S5@D\gO+[5+_J
]_^]97&,VL,:]^YK-S]-EEEeIOg(0[TJ8LRFc)&UXDaVd#L\Z[4_0^D),#&FTS\R
,8SG:dVVZ<,/^<4HTWKS\N05PX=SVdaGE__2AefE/3]U3P3]S5,O..>E.F4TCJ\R
.Bg,9I1M65;\2M63UPIDU+;\Q\UWBH1^Q468>d<[Ga\NV.H<C9R6.](f;G6H/\FU
DQCEUF]bMI7X77.JQ)HF>g6LFJ6;W,@b3cI=Y_.D+Ae:TJ0#Z4ZJA2>VNCVHE4T6
V9N@NC?d[5=X-e2RZ/DSdJT:L2TH?9egVYB[Ya#Od>46Fa+e8gL4(,;K=#,[26>1
LV\MbG35<TC+-W2IQIX9)O]g+d\e5LO:Kfbg?)ceK07LA@-(EJB2S=E<D0&)UJU2
c3&4V&H9egISK-KR)>)-;LTQ#V7CAY/6QA=V6Ib?QGN)A>C+a>Ld-.RcgSED1EI=
/>\g4EAKaD]&?K^aIT=C10\FRT]8._Fa[FAC8ZAWQfG?L<)(-=]LO7L)7Sf,T0(H
4YI>-PAQNN:<ABQ7,-Q/^5OR7-22J:-JOe.^bPeJ(,EE8JH29?:+d.:cDaJP8W1@
37.G9IPUT1GDOYTe3V#8)L_#>.6TcA:0Dc(D)_[_0]a<^a+eMQ3A17U^,c](V1[d
e/gf,UMEV@>-A8<fdK,M<8:0GEZ1>6,aCU;9f58@:a;58c@)Y9-N7IOHX:\ecP8,
S^=#/]^P8+71V,2S3#/0LE42PG(PZ2RI6VN6CJ&X1:Qg3Sb.f:g9?,CQA<5^O#H3
]\[a+,SEW685XL:e^(Q;)#g7XGV4&J)#<6-16T:V+(<5I,37;XcE-f(2WLW)^L&<
J<A<?-[O];0BJ(0@7H\AZ&e2V8P-DTE86JVeaa31;AZS_BZ&e&7)c778-Z1:ZUbJ
efFH\[PDU-(]f;:Dg8E5N99G9<+@5MGCVW68:b6)W)J=JW<1)^+=>&V;Z5#LTI@-
f4<?:WW9HJE+\>+(P?fGH20723U?=?Y3M.KBLW/.6+1eT0O]If=DffTBSDe<fYO&
gL]5RB+Sc4g)PNO]<E)Q^^d]3A>_[JALUIN<I5IM.0ZJ9[M-X&[/LKfXW6_PU[I5
+5+I/ON>^UM?[YY17_@fU\W.?(bgg[f?Pe78K^)E.H1aE_A^53e65C:A1Te#^<JP
E=HV>&9_;+fc+[e&0>P+ZRa<9.XS0b8A&\])ZfG,^Q85&(ZCe^M54OGXGP5(G)CY
(=;:I.I&HHPZYQ&.RWfGC&?K>g-(H,dY^O;@:<#b2/@RcG1.cKe<<OZ,F(2.BD@,
@K.g7XFU\BNQX_[<?^<-PQ,#@82bZ\a):/Z&<;EZ=H>Q]>2/?c\VA;ScTS:Yd\R4
\F(+K;_E@]^DTL_;ab(&W#H(65HYTW5D6_+YGN04U4OM674.b^EcLfQ\X\e(SXT:
8\a8_^(=BN9I#gG?ASTQFE=HfEbD@&L0),L-&TE[)V;Qf6P7O(QBU/F)SfGKOTFZ
0eDXF9/<7Z5bVf2.2C,9?f/a\+?M0P-.^?XI1T>JHN/)J.M9HI9>]3bdV&C=L2/-
,c,NAZH0Cf&-,RdCGfC/fKTa??GH(BY,eUH-Y:\[)0R\fD4W;[E2]7K>[Y0Qe1FR
_(H#>LXg]\&+]bDZ^-8Fa2#<AW7)BaTM=1&D7ZDX4@D3ADMT922+0fgg:]9TM[Y3
Qa?;V]dKU,XS<.DMa(=.(_EM8F]?,K1bP=D#9>AJD#VC4Wf)ZdEY7UVEU,3)fV)E
87/Y<5VTD<Zf)<_cCfaJ#;DYFBCJK:\-1[=)^INHM9J#O^;^,b8;&K<-\4ag@D&b
N]6YS>-8S,FD7KC,O)dZ3Xb2OK=;^UY,B#eAJYDPF0X@+@94Xg\FX6A,\2D[L5P3
X_faBSSe8Z7A8URD,#.Ca?#]JTE.f3+3VA(g-I;KcE:5bdI532DfTV>GG,H<ZGR#
J2<I^Q7@0IP^gLNY-XK)W1,4I,,G(2]>NM15@[,A?C[Y:>26CP>]M:M+3fJeGFU_
ce5SL6-d-fDBFI9;fP=-gDS],UcYX<Lc5)7&9OZW5(P:YZ5B^TVdI-^8K]\;gFWf
EZDC,eG3F;HR4V<e01L#I:PAe8)4e?ZVP[1>-N.,:3/^U<)QS1Q&G&&MI@<.Q]Ca
)c9KG9(47W,df5c_Z/<0eG8OR@EEPEg-?7+WQ>JN)G?JaICC&9UR:NS[NPYdZ&Cc
_/_GSUCaJD)FK?O=g,1,a)U9:T>N8]>787Mc7AZW[aVQUQLC1Y--T9?aQRX2BFE)
-QL[#:Q492-c/e1C=Nf_\++;=>ZgG]QeA8[SP3:E5PUC.cb.>YL;<6L0G@CLC15J
/HQe:+JA^S\@DH+,W6B&6I:Y@.#cO\(5.+<+IJ<(0+S\I\g?X3B9M[Kb_VB>,e\3
\W\O(?:?R7AbbINQAXA0X7\I=Q(=3Cg&WcTDSPc0e>WL3AHId9AcF.:/BM[4H,PI
<(/9>E:gGTI5#a^LAIEF>;MV1]PDF5/Y/9.L4D6M_6-_VGR\>3JXA/OIRHaRYA:2
UA#LUOLB\BBG?7J1QQ5TP0H0SbE[=OFc)e,AZL&5+)Pca&3=D<8_+H.)-UgcQX=E
d.YC,F2Nag3gF)IQJ81Q#bX;)S9RG^.)1Y[(7gO/@:WfY7aP<;?<V8)[A2C>I==^
:G[Db+YJ&ZH]6G-K8O<QQ;M-KQ)C72>OI#3T_g5g-/e^T;L;^.@TH23>aI@WP0c?
F^G]E]7BL1HJ>)a#N^OdM59Y8E+E0,#-N.e(D6Q^S/^EfN-e_M\+6-0d<fJf4?d2
WH_\SL]g1[C/_a_+/PDY[Dg/;R?=dT6Bg1W,Ja14^1^>)H-)>bQ,&>F7Tb30gG(F
L1.8?<(8ALX/&$
`endprotected


//svt_vcs_lic_vip_protect
`protected
)-W6Cde_<]ZMM2KCY/ZOJY2?&2&NWK7#cRW_?Ra8)QfV)24gWD>;,(A:S1H+]X95
71I7>?[eW#H+@(10f^T5OU[C7[W(&?3bG6bf1-S;ZGJ61<9bZ?POE,a=/g@R631H
cZ&&CX^)WN]b&[(<T2[S46=VMRKLPMB>a@b9J.K^9=_3a9.#59+N5:cH64D0_=-K
:I436K;RH#cceG=M:<FEg1Q+#_.5<MA[=F6c[e^_C^fG-P+]/;F[P\,4d(8.U]^1
eQZ1=eRUT^?QR(O_]4YK9b.JIJNGe\O=)SMOAP5KPL(8QQ5__/YD1I,8W+C\MB0S
-)@]<]\c6M2f]RGSfX;4]eQ9VUH+FNc#EgLI:<A(P2@S]49@A=X?:DL]]:ODTEc[
bX/CI<XeX+>]L>3)+W-K3EXNGAIJB;V.#<L^H4CI/&@YX0e8DQa/6Ee#ZS<c).SY
3D?S+V:QZT86\L=XBAWT[\^;?0PQcYF4PB6>:+_&<5bP_GS0NDXU]+@=WRT@C(7D
gMB5V]?/I_e>PA(ACD6<b&dWfcNT[FMD3_):NM;7^I9a/35O0QQ>a(;679MM9?,P
_/<L+G;H+.P(6L_+>aM6LBS-ga@6ROJ<5&<GgB#Y+<^A]8.;^d>PG^c1fL[0,>gD
TI;<b_eE.\f&QM\^=eeb6K0-&a4>](eL7dQN3QgSUZ2HO:eZK7gaaS5[Y7=I:(<a
30I\b^5D;B8/G6LOb#4YK9=d=g+g,G^L?dgbea60D1<U5CO^/BLX#Y\JNWV>3Be7
dA:#Nc869JA_UVZ8@^]7:-NY+?V[S(3bQ5DX-38AOJCM)H385I@a7KBf_10LQ[.b
D&&)d#Y:_.aADL:c-3),XO17OZ:dOGH32&PC)]bS<IOLR=a4N@60(W2:W5;2YJ&_
J-2b41eV?ZU^U]aKRI]G[#5>^PTSdLBJf-CRa_GP8cbLUFY@(&b3a-,eY_F1X3E(
JcHP70&B:6GLIfbZNAEAYD]eI5c.?eU+5g)HX;^?VL7B=PK4=9[8d=Hc7SNOFf\F
^d-b24G)_^2cW>[UcNV6287JOY9,ZNHd>Z\A[ASEP>;+I<X9;=@>0X.#:_#C&GSB
=YFa#IeC2Ka^4;dBKMGB7O,?A;5@,UNga(0SD]Xc?M6)>bWcFL0VfbG0^B79\7JN
1&#)fX:,U3]^R2487CS01YHJ1_^6HFBeg,8IV3=)7\g6I@[e)TMDQN&Fc(:HO6@O
;.68OBP>,c6O)S>=FVDb\Qe4J[_Z;[YJe+-3EZIBHGX:(A-?2./P)JbX\3J6_<O4
D5)-80LVcXOBIS)ZDZ@2W@)73b4f,THgfD,YKb4IdLYL\:=a.ZbX9g>IS@#P<=7U
@.NRg]]K)ZcERF\+??2eZY7G3A&Ae(+(^43\S^SU9G9Z(A/=KfIB[3I94E1C<>4Y
DM_3TOP:;A\\e<#B^7<SX98H)#42D<6\AE>96,2(A9Hd4V-Qb[Yc?2H8>;GZ[>d&
SA7S2=0;Z4GE,N/c[H\0I.]6JC=Y+O9]ZSb3?(?I6\a-5f,M0H(1M?1W]8(FBQaV
\4,(TB+MTb/F@SdE?Kb2M7/WbHNA3,Q=KHEa:J)fH29WPQ+N#FCWKXYFCECeB2N1
W/dY9D@14U:)fVTCP^5/^(U+f5Q8K@7E9E_DQR@:a<9?Z]:c/9?UNHE(OBJI,Y51
_Gg=MP8Y2G:2#17gO_S9PX-a6#=];gH0-EP(C//V07]6KL>N:DEEKJ&S/9D(;HSd
<I-e/Se^\)O+H+S&Z)2,P/W]F)(:)<2K(8aZf)],.,0aFL8e(EX3B20a=1-_;g\2
B);cbXNB\0>0CUW?,B5Ada.G:A.,A\;KIP>_1&BO)+5c/8_];#0FYLKK^OdHI^T5
S9?#=JHVI,0?@H,5(WGg,ADM39=^.a?;,#ICXJa@=K2L2V[+:7PQ745<2^SSdTW@
)9O9W[&O=:_74.VZ=0LX(BJ+,VLAKNfdT#)?]]ZI<P/J@(CC1;)_5Yg/@#bM#)V-
0LQX48?DLAO)>-_\d<fKGc9;;O7\CTZ5@N;@Jfd\fP@?9Pb.;W0517H?Z\;BQHF<
3e-S8C7JN830ZK),2OR&)Y-NeWX+BAMcddC;VY?S;JPDc51dRH(gV:H01)7Lf?GV
=WCJ-HREB#&BP,SX8>]3If3aU:)0J,IILV_;5\TQ3gI:_KdZ@K?.Ld,XUZgI,ODG
#E2e\0^_BcAUY@.Q^6F(J&<P-LPfB-)cLK):+\K^F92f8C4UXYb,LZX8A,F[a36M
LPHEG,UY=Sf)3H.^IZ7]NX>9@Fe3ZF5+;bMbMUff]P3D)c&=WO<gIXc3(K=;&9M[
VHa=R(Qb31T;^VQV#KYQ5CCKEX7(YU=J,2JC5OZ>OA6f/#CbFA/;b4dXF>A^+XQA
Q[f5);fGM3AVb-3=d\]Fe\)\>#I5ba(S+e#Bf-P:6f+^-M1+?7QR.FI^TIHRMRJf
(,c1->95aFYa7RFJC\c7]_4AZc9V4QPL91MIe-G&,=IY+.PET/EHBN]OR:>CYB]B
-)+NdTG&<>LHHCFLe4KS/LJW;aHMAYSR\KZLb0&H6KM>5)d:V4Tcd_B]eZ&?5fB+
=aMQ_C0O_Q]9a0,;e:A>3;CN_)7QbJSLKC4TW?++HV8&=G0[/>?7OELG>g7-=G]E
((?+V-f#=:BTV?CTA^,TWHMH@Z9>U10@5FV;Q4D@N^-_V.@/1BGA-HD0[\G.cOIe
(BRIgPaa1KG65F3Le=7)_bYQ#cb:.e4NAW?fD#NbF&Yc8WAcI_A1=HT2(FaP-HXO
CGgM+?_2ZXK]SbdGNUS^H=TMBFPg[N6cA?cJ##gaOfY7SU-\CT_5-HF::\MQ;EF7
:bVd2U:<dQO;1c<[6W+^GaHX5YSD2VG=24eEf0S^J[[0]M2H,6F2+;c:Z:GA4SE/
E._Y1J&E[44a,5Q]W?(_S_F+W+X+b:Z?(B<a.(0RDg]Xf(=MQ#L0OOaPHeA2((g2
?5SgVL?]\2@9?0(+<g&/b7)[-N&L[5e:03eCN)=P(W<:\3]1..b/U-J1&bB8a5=J
,46[GU74X1;9EgG+MFKPV7F>([L8\)F^=R;]+K;[W[QU^Vef/UU#0[2J@I?WPXCW
eSKZL0:O,RIJ?6XcJUQdAf]_G8=8ac;B#;7<d#Y9M,LO^C]e2)7Z?fGHM_L^&VZO
OcRR0e#1a?ST]eI)>fQ0e,7X9,=/E(GW8S,_[OIc2dLZMV(9#X4GDUVXUD&YXXb9
NZXI#V&g#P,<API+R8NC=FY2)<B>:bE@Of3CfTV^MYH9YG0CXEI;6M[]FKeS:ZI0
-+=GYL-MPC)[[QTCDNE40O/]Y5]DPB2QLe/99D)d@PMJE/Q^^1V4W(cd_g]J;KO4
EV@9GN+bFPWSFQAIY3W6B:<9e6gVf-JY&<7L915S8]cgS;^)&.9^QcHVQ::64OG)
YFcgaf:N<&ac)DaZN=_SO\#^,>41&XVSDT8aD6_:FK&?/GX.9[H9JRH55R8/);BS
SdU=dYGB@B4J5:31J427#3f>:fP=I+Agb(?V_R<3)6IcL,7H^&M?.R=@PB4R(W@5
[+Ge08+#bWdJ)9aOSB78^IWY2a7:93;8Qf==HC95<2EIQXf/BYE&-NZ)XNc6FV#)
<GUcBH_J:0/X?XP@C_0H4&MW)ZPE13SaUVW@[;P?OF,;\_)?gbND<\f]Bf_LRDE[
76e8^7:YO3,7[:.B3I#ZS#/N5=.Q6YI37@AN]S7fgA(T?&/BV#(T;_TF#S/LbYfS
1-aRWg_6)^4-I:e/<JaO?5N<bb=d7\6X(B86Z2F.(FO\CRC]LK(=>)dJV[06W,(]
g.-R-S0KUS[[W5_VFK.].D\P@.S;3-=IK9ULAA(BVeI4-1B]f(R<&I]\ZP</)ZL:
(5;#D(0IbR&0/65fd)#N6]M_DL40VQSfQN;7YT3ZMVGgFS:0Mc3HYbafIgR:2^RL
\B))@eQ[1+^AK3.S;34;a?T>H6J-7TD(KRQ]&V#LH27C5<SU8(-N^B;D:5cf_>EC
J9N,O3J+0?@VN+[LIE3(VL+g-\)4F32A2GRJD0XD8ag?/bAHNcVB]?N<252+&?)_
20?OV:)RU54QF?Y\/\aLcEYgaPN=X9gB^:cP+Y^^)J6>fD@UKN6JIT)^U:L.aE(a
8.B32091B0E8,F[G)2IWLPg;2A;CdGB-8TXMI[1GCFJHBFTb4A1O:4c9J(&RCI[V
AbFPM5cXcY<P;RO_(8&6W_/K.H=2216/;+U,O7\[U>FeIU6?].XF^T^Mf6Z(&BH7
32PW\8JBc]EP\+ZXEUII^DFIGd3>?E#+g=+J6Ic;Z@b>CXNdeFJCg2@f@#&ZW[V+
LM)Bd6.gI/g@ME@De]g<f^A^A<g;<3.O20aa3.\R-99YfDC3YOVU?7d.GE60[8S(
Y.@-1JWYY./_GO;SJ;W@2N4-T:M^Y:ULP/eMfAFFVFd3;dV-:=X?D<D.J@=MgYX4
CbCBAgBe/SFd.C.1),577E3EdB[,:1e@BAE);4]46dY;QaU9U0:aRd6D/e2CVG+O
ROK+MQNBVb.4-Xf]P)M1QOHB@M53/M>D@,XG4L6g9_gbROY.X<YMa0.R,D?7RFWZ
,eOC([2HP&LU;UX.8.M0LQUbW))3D9aA279L0F<X1G+=2Q>Ha8ZU)&\(<a);:fO)
5(XJ.UINYKF-=&+@@CQFJ^0?XQSB4F(C,N@9))a345W)3JN0R3PKW[MXCJf[M8SK
SB.bDdA=87RHRL<@SMY,U-+H:\@E\67(6(Z#]>.?RZ(f<UE3XU?V1e4&+bS<2a@X
V0&aaI\ed,307[<gLP8fZC[[fSRN<8.-KfdJ\QDL[S[<^4F#)Xfb2&-Z?1DPFWaY
KbD.fBe31dF[<:WXK_f_R4<1eGVQS82>:CKHbSbZ9Y&A3HSObG>aZ2V;FbPcIT&[
GCEYbPACa?&2[B4=)HC&[QPGbMEe&IcX^^P7+O<gS<?_,JZf)T,JaX_Hf768/)S<
5E)4<\>eLAPUF0Y3,1C4ZaA6,<+B(SN)ZSZ>gF^6HP/bN^5[Y#J>EG@;-820O8;)
MCd^KDFdYZe88>U]J(bV/dJD_MRJ\(7QC[L?d.NFEe[.dd=SF_4SS,P,J,g/XPZL
@+_+QK\-#\K?0#;VUb6[/^dDN<:-,b79\e3.:&[7E?f&T?V@:>7P8_G\Vf[^U@/T
#IAH(7-LU-H@b>,.<R9;BEWZ3>[,KXW[f<)B32(M0-D2)eaJS29KQB\;U<D,0/O@
E-CD.]KMF,5\5aB2#=,NX)@ZU>?dP#0A0/Qd-JIEIac:O6bfMA@LXe6\#C>PVT)T
[]=WO+N#eM.7c]J_M4:<G[\BS[\Da#Y^#,N=G?7^MA_1X3#F?e?\D)M[?cccS4=K
;ZIg(:T_].6<;[I)^G=^#3=U2IObf?63K2)\KHGZV>R^O)8^M#]P(BB>f5e#eJ\f
;d5;6Pe_[OM(VB1/Cc;Q\-H6T3ID/ECN+Z^LT>>;XTB@+ILEgZbG5BF>MdVZgXR&
fWQ\[.]E_+5TI=^5gK/Z8FY([JeI,=5:CfcSBWRfUR:A_9L0\cA+Bc4<df))eD;V
3,]eL3g@VSVe994V.]1R9(IS(37\#6^eQPSeW(KOLL.E<eg-P)=4eSS5\SMT.F7]
Yb<Qa[?1GCU&F.&F#.9<ZCH>g0YI0T>/d,E]^L=M2G0]Y&Xa:/O-_SS]C[Fa@f83
F1bR9N]a2_IXY3Z,LN(9GA]c>69/f.0@:1PJG)T(^7TaGc#bHV_@9f,M<9#?QPA5
0D55C]W[20A54B/?E_)C4GAf3HfS[(2][#D><>T22If?]AZ7.@M6Z76BA>1OBb0Z
A\JM//P9dF5W-KaY,E?ST4G>SX<AU&IG:-.6(Ld]5Z6,a3K8)DP6:Yb42V06\c18
382JYK5O)?T#c8deRND\S,A(PV+6Y;T?IRC)19OVa>gITZ.Y#T@@VF@@5#Tdd,Sc
[P@)<;X+97DU:I/AEA7I4./2S2PPE;L6f?Hdb#8_H=FAQ+HK]de[J+eY726a31eK
M\M-P=I9#F>I-EXdQ0IVTK/25$
`endprotected


`endif // GUARD_SVT_SEQUENCER_SV
