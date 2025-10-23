//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_BASE_SEQUENCE_SV
`define GUARD_SVT_GPIO_BASE_SEQUENCE_SV

typedef class svt_gpio_sequencer;

// =============================================================================
class svt_gpio_base_sequence extends svt_sequence#(svt_gpio_transaction);

  `svt_xvm_declare_p_sequencer(svt_gpio_sequencer)

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

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_object_utils(svt_gpio_base_sequence)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * Called if the sequence is executing when an INTERRUPT is received
   * on the sequencer's analysis port
   */
  virtual function void write(svt_gpio_transaction interrupts);
  endfunction

  /** Register this sequencer as running so it can get notified of interrupts */
  extern task pre_start();
  extern task post_start();

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequence instance
   * 
   * @param name The name of this instance.
   */
  extern function new(string name = "svt_gpio_base_sequence");

endclass

//svt_vcs_lic_vip_protect
`protected
=Wfd0_X9UZUFe=aSgX7/KPOObdEZ]1B<F;V9/M_I0X\KDO(gK/,+,(X>5AGLbH02
>#YDDGQ<c(0W?VY5d[39c?Q3Y>+[K(;9ZE9(,#C3fD5BEPF]B0Vd(eZ7HDL_]E-1
>2ed_aY0DA\JVIY^a#3W+D@/P2Q>Pc&?M]HRLI#,aDCX3aLY\GH^\_EQBD3@_6E5
UB&(\O&B@P4Q@AU5<eOb#8UI-cEfTN5GfC>Of5^.1/)_.+:aON4G.K81;80B+TX-
1MK?R46?P-(d-IGITd3TQ0)=HPK(,ZBdR)Bbcg4KCK9J@-,.Udf((TM;LOY4f[44
UM);D8PF^NH5\E#,9WP@(8#9NU;L^]^a^:4OVfZ3b3a-G0/_,FJe-]/cZ.\)3.M-
7+:K5AdBeZT]a83PUNVf@gDR:5aX&WCLKG7d@F;<9;&:C<NZ)S_OS6,>QWAN.5QB
^D(N5bBN]2./L?6JHQ6D0(,FDgE35G]V>BfdGaf-2f+Id45aZ-DF=6]>F^ZI<A(=
C1T0?cYA^9HPY(J2WN_PRS5Q/H8&<W4PA2eDBT0aW+K/28#Q6Z]>26g1Y-O#W\C^
8R-680D6#TDS-K@QX35A3M,^W3NJ1>9Yd6X5P9Oe^_Oc8(1Ig]B#>9c<&T<5(6()
e8If@c:9BG?8]NH;Ne654XSE5G[EQgN4cge7APG+&a[WWNGR[e)DILaQD>\FT7:7
W)+8#O&)/Sb3>3>9.YM5EO+-]4]?@bZ:L.:X;^NPU.Pb<J;Md87X3<?3Y&dDLS-X
(49]gJ<aX4Hb2Pe;aafD-aEa48[2a7Y1+<JPcKH>HeKW@)3\)&e^d6&?6=[#;)TT
D\3>?b#,aS]M7>#EUN#a=GcPJR(Q0/4YJB?UIRQ2ZJ4+3&eG+IKUW(W&Bf4Q\[=,
5gQ:OXW[[X0:28[82Q5e[D=V?:)YOIbJaUCDTW,cVgePb6@0:M5+^##?TJ)T]XU@
8?0U:F@;U[RY[GMS[76/J+d=BdRS#/]3g)_46,3B)N/E,.AMA-)J>Z#?O$
`endprotected


`endif // GUARD_SVT_GPIO_BASE_SEQUENCE_SV

