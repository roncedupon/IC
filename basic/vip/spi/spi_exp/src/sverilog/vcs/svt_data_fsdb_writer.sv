//=======================================================================
// COPYRIGHT (C) 2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DATA_FSDB_WRITER_SV
`define GUARD_SVT_DATA_FSDB_WRITER_SV

/** @cond PRIVATE */

/**
 * Utility class to write data values out to FSDB.  This base class writes
 * values to an FSDB file.  All values are stored as strings to simplify
 * the read back operation.
 */
class svt_data_fsdb_writer extends svt_data_writer;

  /** VIP writer instance to use to record the data */
  svt_vip_writer writer;

  /** Unique object identifier to associate the data with */
  string uid;

  /** Singleton handle */
  static local svt_data_fsdb_writer m_inst = new();

  // ---------------------------------------------------------------------------
  /** Constructor */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Obtain a handle to the singleton instance.
   * 
   * @return handle to the svt_data_fsdb_writer singleton instance
   */
  extern static function svt_data_fsdb_writer get();

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val Bit value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_bit(string prefix, string prop_name, bit prop_val);

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val INT value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_int(string prefix, string prop_name, int prop_val);

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val String value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_string(string prefix, string prop_name, string prop_val);

endclass: svt_data_fsdb_writer

/** @endcond */

`protected
9B=RD,MU1gSJ->IA_W,eRA-4Oe6.81OX[VdD2U:0>/I6IL38SS[9&)]@1SKDQPdH
E)f>Fg.4aW>[ETN<D#VF1g1KGRE5=P4AU)UW.7T@ZaA.Sf<X29OA]FL8E3QZKS;F
HYOJC-4]3XBg[X)ff@>T1e0_9I4ceH?-CG:SA>Z6R>.OK^6U:/T;e<DZOJNMOd#7
E4TH^UfS63BV..?LgHc[fZU:UISYJ16,@7WO4[-SMFROG2@=@YU6]][Z)>JC:?72
/>\6>LBMA]4X]2)];50TN7fUU+&a7PRXF2MBHcO_>E@e&b+,MU(ERgOcKQ]Y&6eR
5>:9NPL7=f5cN&_WW],eRdA7=190EB+PFOgPY6Ce^S9JQQ4P4FDb1dbSM+.;@K4M
bGCBg,E3-/:C&>VQH&f3BcXEB+#KOdfB/,:<OWBER-VBSSaM]XfDD?#eF4@=daZP
BFLg(#K:XT.H3.HMGDI^WJ0KD/_N.>,HV])Af>[X7(Q5bC([?JS:_a1SYNO@2O,J
H#S.V[?7b/KMEK/[9JXD^BJ4U)_cU5C5McW5I&FY>@dNL6EMB5/dOYF9,[R7@J3<
R.[TF4D:_aID0&FY-0HaNNcZ[6^NZ2.XLX7dcENN:,gJPNgSd[[aLF>AdC,DD[[D
FP0B:2f5CU@,f21Z[^6+[(#d?5#fSY.Wd[Vc^.g2ab3CBMeGVE^NJ/7a#^fC)M1]
BQb#c]4baFf>BfAO/7Q64NXgD\dI>NZM)(2/#./7Q0gW:UW),K&4Z2-f6E)2CS;3
<U8^NTO:?H2ZQZ-+bAcG5>V:Y5fd[J,GKNE?C\5[SU+a)F:<8I17ga9&RfG#>PEe
G3+a-W..Ke;?&KD#dZX4L5J9YeYF/^32DdV?M:C0E@ab-9&S7,5J([+C93FQTa-=
D;Ke-(McDZW3&>EUK5b@?59b2O-cTe].]?>.S@RHY8eD^T..e^PQFF-C;L.7LfF+
YT/a>\B\8d92]FT8CfDGD3XB?25JTd<XS=S3&0\C/_7<K8Y+H,JHCKZR-1L?93A&
3Yb1,/QdBPH)ATdT-)b+O,Od;[SQDB3ZYGU,UC5?CJYd0GfV0D-S>#?::&DA77X#
S/,G+Z:QNB@H)JCPf9:JGTITOZ6;]PLD/R,4+_138>:MXM]LHIE+F(\Y-#9.RBdG
LP&>M(\S;41b2Y]+4BU2bUPN37ZC\2Q;+EN6UI-[5:5XSYF60._\fN#<8.LPR_9:
68e=\R6ZM_(K+e\R7A<[51aV,ZF1=6)D/?CA34K??-BRg436OKT+cOQ.>AfAP>0f
^W1Ta<I#_K^[_A7f?>ed63Y-V?(O&]gCKAY:(?Y_?>HSE#.,H,BKU669dMX]5Qb[
E3deU]gIOa1HLXb&)fWbU=+&Y&ORJTOP@/8+e5#SIP#Q]NAL7;3[fV5_LY,&b-7R
WC)+<B7?acM#X9HXIRbaTK;X1N8H8RNZgTH6U3<Q9E2Ta)Yg-a2<3@;YZg4B6Dc=
^+Y@?AL3(-/fR:[_R?X0RaeV?S&R86-#M/9/cM(5PGG[1ZKB3:W=F:/VMe0V6[TM
f7_MOD[DC;4P+]Sa^[6K8TAPXG=C@g7,NZcPZ5B_g=OSU<5\beD.HI3_eC:O;=:M
Y7VC0\PY8^c+#VeS]6EQM:@-Q\=HIcJ==$
`endprotected


`endif // GUARD_SVT_DATA_FSDB_WRITER_SV