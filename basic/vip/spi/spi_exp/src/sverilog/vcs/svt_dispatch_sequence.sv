//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_DISPATCH_SEQUENCE_SV
`define GUARD_SVT_DISPATCH_SEQUENCE_SV

// =============================================================================
/**
 * Sequence used to queue up and dispatch seqeunce items. This sequence supports
 * two basic use models, controlled by the #continuous_dispatch field.
 *
 * - continuous dispatch -- This basically loads the sequence into the provided
 *   sequencer, where it runs for the entire session. The client simply keeps a
 *   handle to the svt_dispatch_sequence, and calls dispatch() whenever they
 *   wish to send a transaction.
 * - non-continuous dispatch -- In this mode the sequence must be loaded and
 *   run on the sequencer with every use. This can be rather laborious, so
 *   the continuous dispatch is strongly recommended. 
 * .
 *
 * The client can initially create a 'non-continuous' svt_dispatch_sequence, but
 * once continuous_dispatch gets set to '1', the svt_dispatch_sequence will
 * continue to be a continuous sequence until it is deleted. It is not possible
 * move back and forth between continuous and non-continuous dispatch with an
 * individual svt_dispatch_sequence instance. 
 */
class svt_dispatch_sequence#(type REQ=`SVT_XVM(sequence_item),
                             type RSP=REQ) extends `SVT_XVM(sequence)#(REQ,RSP);

  /**
   * Factory Registration. 
   */
  `svt_xvm_object_param_utils(svt_dispatch_sequence#(REQ,RSP))

  // ---------------------------------------------------------------------------
  // Public Data
  // ---------------------------------------------------------------------------

  /** 
   * Parent Sequencer Declaration.
   */
  `svt_xvm_declare_p_sequencer(`SVT_XVM(sequencer)#(REQ))

  /** All messages originating from data objects are routed through `SVT_XVM(root) */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();

  // ---------------------------------------------------------------------------
  // Local Data
  // ---------------------------------------------------------------------------

  /** Sequencer the continuous dispatch uses to send requests. */
  local `SVT_XVM(sequencer)#(REQ) continuous_seqr = null;

  /** Next transaction to be dispatched. */
  local REQ req = null;
   
  /** Indicates whether the dispatch process is continuous. */
  local bit continuous_dispatch = 0;

  // ---------------------------------------------------------------------------
  // Methods
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_dispatch_sequence class.
   *
   * @param name The sequence name.
   */
  extern function new(string name = "svt_dispatch_sequence");

  // ---------------------------------------------------------------------------
  /**
   * Method used to dispatch the request on the sequencer. The dispatch sequence
   * can move from 'single' dispatch to 'continuous' dispatch between calls.
   * It can also move between sequencers between calls while using 'single'
   * dispatch, or when moving from 'single' dispatch to 'continuous' dispatch.
   * But once 'continuous' dispatch is established, attempting to move back to
   * 'single' dispatch, or changing the sequencer, will result in a fatal error.
   *
   * @param seqr Sequencer the request is to be dispatched on.
   * @param req Request that is to be dispatched.
   * @param continuous_dispatch Indicates whether the dispatch process should be continuous.
   */
  extern virtual task dispatch(`SVT_XVM(sequencer)#(REQ) seqr, REQ req, bit continuous_dispatch = 1);

  // ---------------------------------------------------------------------------
  //
  // NOTE: This sequence should not raise/drop objections. So pre/post not
  //       implemented "by design".
  //
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Sequence body() implemeentation, basically sends 'req' on the sequencer.
   */
  extern virtual task body();

  // ---------------------------------------------------------------------------
  /**
   * Method used to create a forever loop to take care of the dispatch.
   */
  extern virtual task send_forever();

  // ---------------------------------------------------------------------------
  /**
   * Method used to do a single dispatch.
   */
  extern virtual task send_one();

  // ---------------------------------------------------------------------------
  /**
   * No-op which can be used to avoid clogging things up with responses and response messages.
   */
  extern virtual function void response_handler(`SVT_XVM(sequence_item) response);
  
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
T1CQF2GaQR:MS&K7/6IKKO1=LG^6HQJE]0aYTF[9HNASGPXE9-CO3(#E.8-eE[S.
B;TK_GaaCd.Y3Z\)?MWH1FNcANIIM4<^V;M<38)gT]4SDc\&HC+FNY\A?_eM@\)P
[^+&-Z-&>XBHVY>f5g(T&7c)GTaT+=DX-9MWAe/[M#Z5-d^75EX@=&bPF3&Y@DG.
e:-I<2^4,A,BXcQMd>0+K<5eEY#D@TA=FQ<M6J-I_fTL3<?:PU4g)KS3X.6V<ZMK
aTZR4YGX#7SfD\5R@aA]WfL0J^..9WN9HHO<FAQBEKdVCP;36#\7-.UTX:4MQ40\
Z=0GQ-SL&Sa^O?=(1a.^/B)D1]NF:ACeHEGOKU(OEFQDPJ1BT\GT7]_@Z?<Ze,2W
EZT[OE>C2f_ZfcS(6ZET5+W)()_V_I9LO&9^R:-@4<FYbT@2B4Z>YHK;#9F;ZBL\
FIeC4R_6D.Nb8J-,,9;URRF=bVZTASRH^9e7V8291MHLSEY.]@4>2_GX9BB7Gb8[
/[g@SEOC<HD4.<)L]N_IHI9Q.8RXWf4:]697?d@]934QP5[X3V2)RSD(cLHAFeAQ
g,g;\S9LcANcG62Y98W:)6W>0YaVU;&<OA@HENSHWgaKWJc@HB.b0>1EU^>gTRcA
.P:;T1(TPTL.;WP4P;#N2B9;52/3R)?//.U4]K&a=bQ:+MDOXNEIE0/L:N@D1K]:
4DA_/6I:9ZU>0FfKUFODJ<:_b][?U?;YGQ5c+Xe9[W11OgOBP);b:MDL0I63g:b4
g=/6PZ==E)MK<^9eZ8.8W66TW@^&00Ff1U7\BTVJA--.ZC5bcW<M^Te_0OJ3V>.-
._;fM@NQ9T,6DJV:\V@1P@AFOWV\7<EFF3^fQ@9H+=;^&7YA_2;QLA/7X\9)+Y9e
E^ST8A/c=;a[ZQ5287BMFJD]OPGI<GS,WB&H./^L8.6RUed:Z[[4]C16_2d9EXBI
F];<Z_YCQ7T(]RR(_6889PN)=1/:C7Y+f/-[<;LQB?A\6\Z00cMH&,W<=?@V3C)T
6&CLg=KMYDW63;e\04ZXSNWb:K#b2M?_-@d1L^-[P0AE/:VB]=bMN<@,ZV(NS1;X
CD^6/MeI1V5PH7QBX1:Z_a[b@D@+4);NR5/=+))cVF9H\]O\:d>@5;LGUR^+R2EX
RU@9S^1V@T@U5Iaa6#O6,1AfV:BG(fJYN2EI&9<<e87@G3HAg:eF>+#@bEBEPO8[
P?-EG).<S>VYdRZG5e0]Z+XO/,?W/Q;aDeAPQO2^IQJ\8)E#))<7dSVKBb8\gIa4
0:FB1A(.5GMBFR@8N,?e8TIS;Q_Y6T,@>GK0[[QM\?6_17>1I+&Sa+)S9>Xb&7X1
]MJ5]VOb(]FH73<09B/&>(fb@2A+T-I)+Uc5\<8LX58F+Hg9[Y2?;_(G:7DU8SS+
CO=B(_UdMcYI>GEQcH@?/5d5)<20Y+<-08F5S3T5]0ggA:U/DT/Y7If++A2\UK+;
R:CKVHM(WL4Mb]5cF\a(C3P3(ME21bR,^Ba&CZf25d<,B2?Q+aBZCI@:;e>CL&7d
_?[\cd6LOQ6.XX@8b2C(Mb7?\f/TW[O7fT@fFW)6XP&&(=@R=FcH=#=RcK_UaVZ,
C2JcJ]0?+:@^@Y13WV;ea>7-OGbP?Gg]gL,LT4FP8PF9<-MMF14I<0E&a[-7X?6_
BgM[FR7<ZJ5B:<eEX<d3P&M0TQC4#NFg8WG/;YL0K-9L>=F?<C@I]RE9Ocd?T&.V
4AF4,(M6DK)f_5AU>8W@HPBU]ONf&cNDJ>Sd)[3[1F?F(8?.[-QL_B425D^7J6fI
62FH9K?]Y5)bRAg:/PK22U10REYOcT41/#OaHWeV3/R6^/;M4/]@RM.eC&+#RYgI
g\^J1G1GB@X:[8B3SYR6LZ4]R_KO&0>0K:cL:dD?fY<?IJOUZPAF3B2?,=DIUOA?
)&U[RL-cb8#K>ZGAYPWc6Q;YMaGTZ<L5;[IOSN8)B#J\]e-cg#POcH_eJ?We_I>F
ZgVZK5MT7.=c@8S]J)OJ[/2baTcU)5c&-SG:0\)HFK^S;Y+gJaMPgESb/Y.:ZCAf
-Z]&7<bYSK36@K]?XWgDDLUN9ACQ22(f+,GTc#;W6+PXX/^G(CX?;U26YF]@D=OW
-:F1]_eK6cUE0_g4W1A_Z9Z7#Bb1GDf1WLIEaV35(]GPe\72KS5;MdFT2@RXCgB_
>A3Z(9_W4f_fcLL3=OS==UP8-f:G4f9M.:B#;RQJ.;MGVY0G,B6:AURZWbc]9eb)
2X2?)XZRH5FHB0RcNB0ZV6Zb+&]9B7,6>&;6J+fPNfdB]D[#/e1bFY#L=&?Q@=+C
QKF1gL@4V_\;+IaI)R2;b[Y4)U#=W@1RJ/#9e1A;XVRE33C[DVd#AH3QKOFO8ZUd
H?&436E.1AE&PK^:O(3/6R2/8YF#&df6Og=c-3V6<,M..6V\L__@KP?V.8KaFSeA
7Q-W^49Q3\F^>MX:A.a.,P:7I5\13,fB=06\5GW3Y_/0SHbCP&91HOa]f:e1387N
,=WSO@]Lg)]=G]?R_McN,/a_Y6753XW474MQ]]3:gXA9Y3cE8R+D7-CS?@9]f_SB
81>U,GJJeTJ^]XMRe?RZ3d26I5Nd)Z,R7g2AF[LI1W1d2cO]/JF,QP6ZLI-]0&H?
C:d36)cdSF4CQ4@?U&BDWM,\L5I<WIC>_J/89HMBd9-e1<L1PWb<O;M0DeCGf,5P
WJBH-SRG\0\2F62/P4B&5K(L5eL,K]/.cXaQ>g7(R.ST:7H9Y\UY[SQ#<I^7\0U?
S6.JMW_e^?W8d9MC[[,K#-N;?[]&:RH>^\<+?DM7@0N^HN@]3M92MY##V5ScV08(
[,DN<45P=^]&B5:B@A6Z;0B(E[gbGE6K13&./.?+2AcMSEd,_[+??A@b_B+=aX5,
S>f0Rd9f^6(1>P?gG?c>EV8\<OXN2@XZ=YJGdfV<TN[e1?4Mb_=)<b6Ya^6OEJ_K
;/<gP5J>WHSZ2a8YFG]+-2(fe_XZaaeAKIFcaG^.111-<0TH:c13eSRE6]afAYCA
b;TM)SM7DJ3KC5V4c+GD92KHE^6<J#SXH+57L1G<XgR<]B.:YOAS4^T]6L3AH=M)
(-;5CO=S)Z3Ba]IBQ]b[Y5c1>FQ0IND;WdAf06PVd05c7Y8b+a.#7,D5PHeeZD4T
]+ef\Y7Y@g@>aQ(PG;HdZ-:OVYOeOS58^;Y><0SJCLg2QaS#Z;c]/(X&)Sc9a)-.
E4AX?f4?V,-&L]L:JIIg6?HXg[[=4f-fQ[g>bFeIQ6YVg;e3JY(Z;.5g^]0A/DeK
&G42d#I=TI]a7/B5[N,H#DD:=0@W6GU12IQ@ZCC.G-?Ka&_LS]#b[]4RSbC?8(8X
2JW-K0#<?>@<3I1,cBUS-7<&_FI?@LLP&,\;V#U_RHb2+#>VG^&/:AFK[M3P\X.R
C/R5ZP)]H0V4bI7@V8G@5L[a2:)6XD,0G<N>OeeWC\QD18_O2.C8eN4b/T;9[SI>
gEYb+N)a>?X>B/(@6==90aAY,;fRH1G>9EDZ.,3Q<1.Z_\IY1ZgK,LIdE#_[ZN+>
<B^D^2@)7_;5[\8>HWRC<U-X@QeX#\g7KK9+V5U#FYZ-H4.[bDI7)EG5:EbLE/U)
Z&1U<=_Z/DLW3(6X<K^b\/XP2ADL@-CN<dI@eeZDbPNe>@L1[.=M2?Lg4gJ0T@(I
b2JG0-OF&&[bOX3[&EP2C9F8g1[<-P/40WUXR/P9;)ITXeZdUG+PLB8I<COBe9f)
]=Z4K9CP4PDL8T&JY6KQ#Y2^8U7a>L<41)(A1YP/70T3<IOIeNc+T=E9(&g^O?RA
A?EWY43-VIY2]Z-[V;c,H8,;;SDF4E]e(;C/&(QI#NQ\T<0=:D[1cO+I^3&4\77M
8ZcDaEK\U9A&e3f+cKK:F>V+K^(S>;cG=;g_H[>IJR.I55XS[Q?2Q5eK.f,5HO.B
29]8]Y47DYIL2V5;O=KUX4f;f2@,)e]JYU&&\0V^He<[]YW.^d>@=&dfR\(Tgd.K
&WVeQ2Y(U@Tg:<TG3?dRdN[4d1NB[XcTT9=K[CdWK2Gd#b]C[c@?<A:#A^RLb_9Q
#,f8^G@^T7gd@X9;Y,Sf_#A5:Cc7eXKIG6+X97C,O51Ba>\OSO0=1G8YNRd3E::K
3B&WfP+IRJOV-9U;=HT88Mea:;571_aSTX&Xe.Q<V=f^-OIV5SPabB789O/aF4)N
F3U^VWKW^)A+Td88\,>fHE,_AEc2&7E#<.9<Y;N^5K+MQ\5P5L=(\Ld?-H?I1CU7
9XB2+fdcAAYLPJ2YeW#WK<TS)g#02KgU<,4OFL,V76;g7VPNV,J<AaC03ZF9TT&+
].JDL?GV0-LTBU?Q@SR?S:RG^Y>e_74g44b+dN-5>-XNa<[S(-.?b,DX2B(&;_d<
JMO#+WA2GH1.MY^\P=R=(.+:a;b/A]ND.JG^V[eNZ)Z66.:0&)fZ@4J/YSV9#6;D
;?6P+<MNO5N.)$
`endprotected


`endif // GUARD_SVT_DISPATCH_SEQUENCE_SV
