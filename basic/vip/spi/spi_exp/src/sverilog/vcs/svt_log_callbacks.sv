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

`ifndef GUARD_SVT_LOG_CALLBACKS_SV
`define GUARD_SVT_LOG_CALLBACKS_SV

// =============================================================================
// DECLARATIONS & IMPLEMENTATIONS: svt_log_callbacks class
/**
 * This class is an extension used by the verification environment to catch the
 * pre_abort() callback before the simulator exits.  In the callback extension,
 * the vmm_env::report() method is called in order to provide context to the
 * events that lead up to the fatal error.
 */
 class svt_log_callbacks extends vmm_log_callbacks;

  /** ENV backpointer that is used used by the pre_abort() method. */
  protected vmm_env env;

  // --------------------------------------------------------------------------
  /** CONSTRUCTOR: Creates a new instance of the svt_log_callbacks class.  */
  extern function new(vmm_env env = null);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is extended to catch situations when the simulator is
   * about to abort after the stop_after_n_errors limit has been reached or
   * a fatal error has been generated.  The only objective is to put out an
   * appropriate Passed/Failed message based on this event.
   */
  extern virtual function void pre_abort(vmm_log log);

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
ceO2-09EO5OFZI1DXY-X0ALJ4;7\:B_aCQEIc,I,M0]aS(0GMX&G/([gFIL+48eO
>_9^P09@L]\KZ))VK(7?F@0I8&3>YWb5&AW;0B(R(YP\#IV:J.@cH,ZeM2Tg#2Z;
0K7+.fH/VSTQJ;.)8SFPfgaF]4F[&X-6BU-R6=b4-_CI,MW)-DTe)YCL<U8Me/,T
^U9PWAf:8-+9PBU2FBW.]4:?Sf8F^e4H^<NK&^:Cb8(.NSPgM.1XM@0((c(:G[Y^
PYZJ\-+@7NUWZ96>H<A_B_?gPLNRE[YVZJIBO,IX\8U@KLWeX[5BE)Ud7c^;\OM8
;Kc@W<O?<#3GGX_2L;Q81NPYB>1W<f;?OQBb34[cS<dd_Q4&cC@.E&POKXRA(.<C
Na>EF3cRJ)5Sg2fR7(Q/FY[3Z86SGeHO2H#7X@./LA-MHMMa@.HY:Gg4QN0f#X7Y
5:T9(<aGS/>T]1Y3K?LTP[LWA\JO/K#Jac_A,X4^DK\1HQ;;Jb_R]gP6cV=1\KL+
EIf0;IO(FPM:PdUVP@DRTF12e25I-7L^&ZWT9]4g.^dPD,JGE);b)+P>OBL,Q;eY
:@a3VcGQT+KT+H#B(&e.S8ZF3CM.J4&/8/&B67Z[UO8G&2]H4QZWTX=0Cg>]F?eS
=g^E6+93#aD].7E0\US7Z<E_EM2]9F)J/JQTTc<E+5R\4:B/8baOV[6A0O6JP&LK
=Q9>H#Z#&=;HWGGOT35,)?,dQ>XbPHKV&Q9XdZ@ceC39cH//+e0UZ/:f3g7>QN(J
885M\cDR;I1-#MWgf1W=LUH8N2AP0E=]KNLD?S(5#cP6.9&d1]#[IHSeYJb&R6<F
AC#5/3(1\S4Q3UdL\2>)cU/VDT8F]2,7MK1&PeC2Tfe-cHW.RP9UeP>7_ZHMG3\7
ZS(S:TH3\gFML87f,GFVK1775#;c\9\]/UD8BMB.e.D&Sc)]U[gNSY+XA\W&2JZ6
a/[ULe)GHEAM0$
`endprotected


`endif // GUARD_SVT_LOG_CALLBACKS_SV
