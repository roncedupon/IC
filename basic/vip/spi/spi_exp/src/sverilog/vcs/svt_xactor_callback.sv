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

`ifndef GUARD_SVT_XACTOR_CALLBACK_SV
`define GUARD_SVT_XACTOR_CALLBACK_SV

typedef class svt_xactor;

// =============================================================================
/**
 * Provides a layer of insulation between the vmm_xactor_callbacks
 * class and the callback facade classes used by SVT models. All callbacks in SVT
 * model components should be extended from this class.
 * 
 * At this time, this class does not add any additional functionality to
 * vmm_xactor_callbacks, but it is anticipated that in the future new
 * functionality (e.g. support for record/playback) <i>will</i> be added.
 */
//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
virtual class svt_xactor_callback extends vmm_xactor_callbacks;
//svt_vipdk_exclude
`elsif SVT_OVM_TECHNOLOGY
class svt_xactor_callback extends svt_callback; // OVM cannot handle this being virtual
`else
virtual class svt_xactor_callback extends svt_callback;
`endif
//svt_vipdk_end_exclude

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * A pointer to the transactor with which this class is associated, only valid
   * once 'start' has been called. 
   */
  protected svt_xactor xactor = null;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor callback instance, passing the appropriate
   * argument values to the vmm_xactor_callbacks parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor callback
   * object belongs.
   * 
   * @param name Identifies the callback instance.
   */
  extern function new(string suite_name="", string name = "svt_callback");
//svt_vipdk_exclude
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor callback instance, passing the appropriate
   * argument values to the ovm/uvm_callback parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor callback
   * object belongs.
   * 
   * @param name Identifies the callback instance.
   */
  extern function new(string suite_name = "", string name = "svt_xactor_callback_inst"); 
`endif
//svt_vipdk_end_exclude

//svt_vipdk_exclude
  //----------------------------------------------------------------------------
  /**
   * Method implemented to provide access to the callback type name.
   *
   * @return The type name for the callback class.
   */
  extern virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();

//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to allow callbacks to initiate activities.
   * This callback is issued during svt_xactor::main() so that any processes
   * initiated by this callback will be torn down if svt_xactor::reset_xactor()
   * is called. This method sets the svt_xactor_callback::xactor data member.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   */
  extern virtual function void start(svt_xactor xactor);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to allow callbacks to suspend activities.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   */
  extern virtual function void stop(svt_xactor xactor);

  // ---------------------------------------------------------------------------
  /**
   * Provides access to an svt_notify instance, or in the case of the vmm_xactor
   * notify field, the handle to the transactor. In the latter case the transactor
   * can be used to access the associated vmm_notify instance stored in notify.
   * The extended class can use this method to setup a reliance on the notify
   * instance.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   *
   * @param name Name identifying the svt_notify if provide, or identifying
   * the transactor if the inform_notify is being issued for the 'notify' field on
   * the transactor.
   *
   * @param notify The svt_notify instance that is being provided for use. This
   * field is set to null if the inform_notify is being issued for the 'notify'
   * field on the transactor.
   */
  extern virtual function void inform_notify(svt_xactor xactor, string name, svt_notify notify);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to pull together current functional coverage information.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   * @param prefix Prefix that should be included in each line of the returned 'report' string.
   * @param kind The kind of report being requested. -1 reserved for 'generic' report.
   * @param met_goals Indicates status relative to current coverage goals.
   * @param report Short textual report describing coverage status.
   */
  extern virtual function void report_cov(svt_xactor xactor, string prefix, int kind, ref bit met_goals, ref string report);

  // ---------------------------------------------------------------------------
endclass

/** The following is defined in all methodologies for backwards compatibility purposes. */
typedef svt_xactor_callback svt_xactor_callbacks;

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
]:H#gPd>NFEG6?414<JbY]EIeWTALOJY)XL=BL5^/]SRIO&9c,?W.(>&50QLd)G)
3ND4UaCO@42(:-^R9+JD#ZbM:W>,_P]b8#F(d\EIR1e-d2:#R>ZN8\cC]_-SWeNJ
ECGDZ5H0C=dD.5cdW<E.:fE\Z9>W<WTKR\OQ,PD[DKE-Mg.IR1XKbdZJ\(,O_PXL
UNf=OT1>D?2SQXA,S8eg0c[=fPU5<c9HS..BEaPLGT^FaJN3AU/XG@[08-eX],#N
cH8]YG,0B&c^+(9H7F[+[1S9Ub1O4_5+eA86cfX+e3SZZ=acI/_T<[/5ECeHVe>8
RU1_e2Y+(<KdD(LV)Z0.<UP9fFgRNM:bG21C?,F&)F&2#(b-#_VS2F5M@L<BCF@+
3E:9N4-YZHFTE1e;0]:3YdN<3SMX0(LUbgWF:c#K^/_XSFe;d,^MH5)7Z4==&9QW
XQT_,_,LgNF(KVW6IX8[<d,6&\VDX-HA\P1LPd?,2)B>Sb:[f2d2+^;G/P8f(e\F
N2(C&3T.=1PTAIW[R[;cOD\>gC89g]C3>@WdF<=;#-5)[?T=D0L1M0ZWUWb9KQ>6
(5c3?S8=ceY02&FEWE.<60R#;81-Dc-UTZL2ZU28:<S6dGFMC?GbTIQ>E+[Xg8R1
cCPd#ZV^.cC^e]YZ,6EcObH\#1X(Z62(JSFOS]^(+Rf^KQe>/[Z5@X>NE;&7D1Wf
49YKFbO@=CH@BM?4007A+c8#BXJ=CGU7]2ZgF+G/<E\3Y_3FZT+Mc^(8I4),@WSG
eZDGgNCb_=F+HQVKYE73;Y2+VW>=f5_KE<H35RFc=UM,=FNRBGD5FB3UXaEUB(DY
_Z>:5+X@I;I,_?W6V=<CL-/1=/Daa[30JH9.NAA#\47?d>>Y8ZZ\J;)Fb44I2AM.
BAO.13dd-c6YI475dSO3KZB_@>MeFRDUG60^(A8O?c?_0>7L//^0O]T56A\2[B#>
,,g\HbJ/cIEURfL[(X08HDZ6:Pc>>GaE_1F/J1:VU(^>_<AW@NC3:@+&F=@M[Jdb
6JEVeA1=Y.P&D_4>NMD0\YdL8^?d@GeX4gG@d1B,T85cDU(;Ne2c0Xf/A24d&YIA
Pc;\4X04^?JbIbK1+Ze<@/<YS);^=UCPK3e>&2(&F4\[8Xb6V;5S(INQC#VbVSNC
JS.g&HC>8DE+<D]C,8GdOZb.5C_Q,);6@#,+[P\^MUL^6+Z?SYK>[6(9C@;:;OWM
5E:\X:K=WK6SB<FO_]a=:551)TO<-7MGC.>D#ZT:GH/=<7,R:8gQgdd2E<^X<1<+
JXeG6QWP1>gaXIfU,E-#AK^>3[AdWefHGA6G(/ga#7GF9?.[V6/=A]WWCT,E&Y:_
ZF[NEb;.eV&_@C\6IE:D&OM[9OH7bb0c5.;S=8-gJ,],Q<Q.5SCgH-Sc^]?#M\=7
.MHa=_a3BG&];I>BDZ>I,@7>\f(0NU+.Y9--OO3BYN)&:\0S@5IW,J<#dT+Vcg[:
Q&C2)NG9#MB>d^S#^4fB:cgVa#&G1=[UYcK]WAJX_^E?^H^dgf^E;4^:]/7d;ASB
9M4Q<3>,X4]W2b8ccB6<cag8LY<c4@2XPd+65Z?(IYKU(#PY6dZ-:LGF;gG]6b0_
Gd>/#-:7T>Y/HTG]Rb<EA93K9NL#@=U>eMMKeBZ9aM#.YGZ^(([9NabPZeZNPE<2
b80AgR<;&ZMVC1=Sf&=X=2Q\905A/Q-a6OTFK5[9])HBZ7+9-Q9MM/MZ_WZ<H&O_
\50b(H0-Odb?ZEKME.2B\];b6]5I48?J6eeIFT+Qb5HH5HP8+9CS0\M/XNY_R2cK
ZOWF/1RBb^<JUOLaM[]MKfIbG/gPP?790Y[>b&Pe_bB]N=@F?8APCGX2J<)6,S1@
F.NV&10e4.1DgD-BWRRd4QPeU:4D_YGc?V<1W@?@,-9,?#(B9,d)6XK7A,>9;\K.
DNHG2PfW@?9/^Ne(fg8M1_Y0>BALI]c@->^Zf/ZdD&31<8JMaQeA_\PNF.FFDeR?
MLCL7@F[SGPU>2HcI40G<PB=?QV#FDbCfSZY]^@Fe>OI_[cC/DXV2E^a2Zd=<.<D
5[+/S6D\1#VAVY@&K5S#4E#>0X19W>_)+O5K.<Q8+^aD89Y=aK#;0c]]APLYS^?+
&_2Rf;Rcea;VUY)cbEMWT)f8)<+(5FfMC^F=WTZf<Z5a@+Z@RBc0,F]+0HQ.PR=:
=U>I[6>D^SI67+2CbC:1X/<&FXb^b3#G[dJaY/EV<B^FQNO,^6eY>Mc6C=)TfF0<
\9Jc[<5R544P_Ng-[=Z^+2+ZB<R.\aDA#UG0/fOdgBNQ&[MF14R5ALM_bO/11W#e
E11(#dP_ACU2eKB,=,YeF0#SE:\QHKOBaU(P];cDIYVgb#LEN6WM6=4;IE^UV(VY
HR+Z1=CLU\@VdYM^D;/8LFJ-Tfc>0CM>DUXGX3e>WOD3eeDQYJB>DD&[=7B62>=G
9:7gVM7):fIKR,E>d2EG+=6:?RHd1\2N\_4>@+M&L;c]-@O?+3<@6/-->;^b1T[f
UJ7)+Nf+VDV+@7^eabLA;?6:2$
`endprotected


`endif // GUARD_SVT_XACTOR_CALLBACK_SV









