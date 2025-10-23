
`ifndef GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV

`ifndef SVT_VMM_TECHNOLOGY

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected easily to the svt_spi_agent.
 */
//class svt_spi_virtual_sequencer extends `SVT_XVM(sequencer);
class svt_spi_virtual_sequencer extends `SVT_XVM(sequencer)#(`SVT_XVM(sequence_item),`SVT_XVM(sequence_item));

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Sequencer which can supply transaction requests. */
  svt_spi_transaction_sequencer transaction_seqr;
  
  /** Sequencer which can supply service requests. */
  svt_spi_service_sequencer service_seqr;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** SVT message macros route messages through this reference */
  local `SVT_XVM(report_object) reporter = this;

  /** Configuration object for this sequencer. */
  local svt_spi_agent_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_spi_virtual_sequencer)

    `svt_xvm_field_object(transaction_seqr,    `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(service_seqr,    `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)

  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_spi_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /**
   * Finds the first sequencer that has a `SVT_XVM(agent) for its parent.
   * If p_sequencer parent is a `SVT_XVM(agent), returns that `SVT_XVM(agent). Otherwise
   * continues looking up the sequence's parent sequence chain looking for a
   * p_sequencer which has a `SVT_XVM(agent) as its parent.
   *
   * @param seq The sequence that needs to find its agent.
   * @return The first agent found by looking through the parent sequence chain.
   */
  extern virtual function `SVT_XVM(agent) find_first_agent(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
  extern virtual function svt_spi_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`protected
MT)J<OYY5&<:B,f?NE6b5fD&O.R.&0R,)>\4V[,.F:HaV_4MZd7.+(\C>A9PR:7-
Q&Bd912&@^b)N:/3[T;S1Ka33GV?@6HE473+D-6C3bEI]\U22a(6B0Wa\8[G^0N,
6QJ?JRe(R)8EZ[#@S>d]_(_;-BY+?6?LK&24F)2^R05V0HIAK(PHJde#J7/KPb7E
JfWZIMY>Z5&1Q(8@BA4^.2&b28Ng:cG_P;cF9),e6MU@_/JdX5DXT#T#UB^O@Y1+
Q5;A^g^=cU8HUAf5D/)Y:VXEGKaXUJCB17GKc_7_4_C6?@:8gg@63K?JD(XBaJM?
Y>-<N\1CUfA+RNIf3=/U8eS8+.M.1-JbEAe)RL4(G59f1FFcB(8aC&?,^+XgZVd(
JaD:Ke-16aBDg#5Bg=PQI1ca:e#-1R8QfJ>Z7\3:W4<#VMT?Tc3##D141V<eU9CO
JN[[>b]-0O=V-UA@9Ab2S>Lb>/<7HQX.(1+A=YB2@7WQQa1-1K5A)Z;@9a-0?eCg
f9N\>eVKd5>K+3^9dg[d]\-LV0-;_V,-3/<T9QH3bU(FX?4E7<V18<O>W\>TI/Md
M2/DRYPO/\=1,c=OW/9N(W:+/CASP8?I#eOI_06QK/OKG)(M815^c.c#Va4d>9Y7
c)TQ+C]J-<2H;4\PXK6&=7\+:7/=0#\dPYA3<@#<Le1E<(IX93LY(GX2e=4MF0-A
WN6YEXM4B5:F[M0+cB976PB_>YbS,A3GbN)OabMJ@:8g8I8]_Hd4A5_T\9-1VE4B
Z_E]]3A7I_QI;7CA^4:F4]Q2+E84E+Oc@<0YVfT[NK8+UD3N9b]]P_)28QVM41#E
9\MHIAISPI)[=OKUfJJTCH0(Td5]C/fX;3?S\R(X:D#>7I_:Z:QCOH&N?.3[GFGC
OIALfE+SHP2\EL^L9?/_DFJ[BMNS@g\^,gYW_T_.\J08BYeR[g)-IL[:4C,>LNLO
)\UM6eU0?(:Cb(^N.SNI;?g^AeQ9g#<H7JU,,U)37Tba(IENU^IB)VAd:_AB58e9
8MZBKP3f17RU=gSK#</VK@/IXgAN(ZE+A0(:d4]a0.>ga;#P+-8>;T&U36g2c4.S
(Y9[2UeD@L[&+:[+9Db8gL8]O)5]56D9VgP)T&fA)Rf1#/RWN0=,O:;>;#MXIJ8W
]6E&2898B\DJ<C0G-.XB^YLD,T-<V9J0LQX31S_@a<fD.,Qg[>K.Z)G+SaLRI.OM
Uc0KE+<3I(T5cU>CcHQH&6,),JRX@_B-V)+Gg;_R+4X=ZFd5&L@D8a00.-dO9gTD
2P)]ABR6bCT]ecVK).+cd&(XRY1=E7NNdg2Q)-/=@CbZ=Dae-@=C5._3gZ_AROB3
gNKIGg6fc)egQ=f\BYN#F=6#@L+^(3Q/.HZQ:3+C88MSHFN;L\2;1b.W_G?\b0Y4
2@G9.7d<2J.=HJG9T9FR;<d@<eMA_8dMFB3WL;-d06JD]>9;De&L;3PTZ:Xa640(
K9+cKI.CK4EVI)08V91ZU8-fCLC6KD#71\39/U1;W\HQZ^)^UY54#4I+Dd]OK&G;
.P[e3U-68\LQ-_Bc?(X\7D9;EXO)\cA#)D\(#R057#,eXWZ0MGBJ7H>EVM6.O]DJ
XSKQ1e[6X60Q;A4/>c=9Rd22P,EZ@7c^eDD^0DE,f@e?Y;.[:g@=RgQ\&OTL]U#[
L)&6K&V\6,O@([_-E/:6.E/E2(=:M.WSU1;T//7<?9^C<&5=].@[)/H1BU+P:GW#
a[Oe4cLfA)aPfP=QbK70cENL(&KBI>dIe#b2HDD+28@E:;[[3AF,(U@LQJ=N/Ec&
g4fd]3g,-)?6F6?d0LO=;\aK9A&(1GYAD02JN(LRSYOIMN8)+8XFBQE9X)fMCRD(
9HVD3X;:F9]<e-B&ac^DO[[-51dN2MAaR]UP,AcU,ETO@4eFC7[7F&GU#MGMg>1\
BgI+PPfIe^fa.+(Z.d7R47F32766.-1#_M6Wf^d0f@=)NC#(T5/a6#7I4.d&H,)T
+_;[3Z\BAKPUYSMER7+S\3TR(X]+YCQ,CA(Nc2gR_ON,:WJ4N:d+]I0H&R4dV9gP
7:D4REU1],DaX9A&c9A-04(WSgae5FEGNT\;KW<A_G:-acZT9R(QMQ]g8RAYKA5;
R(MS<4a-#g_b]Z3&e7+ScUOTVX6CD]&RLV)f-/#UA8W.R(]YR?<:#0OFMfVGD&QC
JfPc@(a15S6Q98c.,4GMU[(Z<(GPO._YQ0WdXg(/^bCG<a;8>BB?2=]]1/T/5MWg
ON2(0CHc-^4:74V&:G3[8:fgUXK)N=60N8]2=G3SQ5@VE&\+C>9ES/L_b#NI1#Fa
,B/T#6/E<5<]_?>bK6IZFR.R>gfKOKHSR+RFdUF9R8b[F5XZL.7L,7YZ)fXR0,MX
+7<0?C7b[?NL<,SaY#NG0dgcM[/G].d4]R3VQ0Pa/V/(ZMJJPA8Ec[Y/S7J8\9a3
ZF8MU[(JIU.<PA&/dOVbLOBOTg[C,6M6a2gX\+D/eFO:YcL\]P:\-:A5-gX\FR>V
C^AF>_SXQC>C&fGNA?\G\.X\a[9bB&eZP^[=b+NDN-abe;ZD@BaL+-SZAaW79Z)K
2;?HS&]bEDT.,N4@EC7e9R?()KACKB)BO=CH8F#d\@(JL8@e(TPO7FaD+-3K9K\V
[R_3LR2B]KFJ6^9dG\1PFWBN\IPLNX&:D^4W2ZAdJX3CL4f[I@H9/7Ff>QacY,Ha
#+D<gI^41N4C4cW;8@b50eQ<_E)f6&/d&\H>IcE&)&FUW@(cM0fV)Q^FE[Xa5CGL
)<0,)@[7Z?CZ:>9X]+Se&LD.f[d?-2LRO8:O>B(HXR=>;XY8R2YB\8cc+@S4J[F#
QR^0\]WC:W58?-(L64Q6:&LWG@/J1?HSZg=06gV^1TYc-_/-,b;:41@FP:K_+.>F
#+DN6F._AWAUX9FZ+9EUX4L_Xd3c0)B2=4<X=D+#=F70IMQeNAAB_(QY1E)J1FQU
>B0.RPI+V9LT&Wf&]^f&R,Wc^ca5,FHRKLMY,D2(:]NH7@__,)^g([3A[cdECafH
H8XDIEZX[2:9]>.2.H<\=6#=b8(/eYbJJR1TBZSX\-2.CB;;dEb(K@e,@FF3YND)
;Y.cG,^AdW-1BdLM\3=BH>DUXa:?[bDa&/a3LOK[/04;dEY550<_3DX7O#V\.):f
3WK=N-C5-8;[b65N=GLG,1a:8Z\8??88dWa\UUQZAgG)JSSYRTcHP?0CG,1bIVP]
Y@GAVCVMf:4fUXCA=\/DTUQF2#:HWD^P\c/?Y4V:+B4_fd74A\\\15Pb#^/=19Kf
@R2cKb_9ULD3TVf[aRCLHa4WKa#/VX14Se\E6X&3SZ0S3YUK@M9>>?ZN8E@Sg:20T$
`endprotected


`endif // `ifndef SVT_VMM_TECHNOLOGY

`endif // GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV
