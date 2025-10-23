
`ifndef GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV
`define GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 * SPI Flash Memory Transaction.
 */
class svt_spi_flash_mem_transaction extends svt_mem_transaction;
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_spi_mem_configuration cfg = null;


  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_mem_transaction)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  //extern function new(vmm_log log = null,svt_spi_mem_configuration cfg);
  extern function new(vmm_log log = null,string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  //extern function new(string name = "svt_spi_flash_mem_transaction",svt_spi_mem_configuration cfg);
  extern function new(string name = "svt_spi_flash_mem_transaction",string suite_name="svt_mem_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mem_transaction)
   // `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_mem_transaction)

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_mem_transaction.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

`endif

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Method used to obtain the physical address for a specific beat within a burst.
   *
   * @param burst_ix Desired beat within the burst.
   *
   * @return The physical address for the indicated burst_ix.
   */
  extern virtual function void get_phys_addr(int burst_ix, ref int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX]);

  extern virtual function svt_mem_addr_t calculate_phy_address(input svt_mem_addr_t addr, int hier_index);
  extern virtual function void set_cfg(svt_spi_mem_configuration cfg);

 // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_transaction)
  `vmm_class_factory(svt_spi_transaction)
`endif


endclass

// =============================================================================
`protected
:Yg:GJf;AgT2<P6G<GD31YaPZMgGG)KM0U+QbN:7I])V,e0U5-O\0)d0)aDL<+4E
>/BUS49]ZZ,?;Cf9X7S_0X#&#5ISI6)VZHb@M^N#]TNC(L>/:4c9]dSK-FE#Rf,S
dO?80)OaA(#5DMNA:<9EHS=31[H1T3FE.+[C(/STE.9DK,FQ]b6NE;MW#XaXA,2W
>Y1YM^4O40&:J[N>fCZVO8cZ[;-Ob=Z+FI7,I8)<,H54#-:(D+&^b-<+:JNeXCUV
LX&2QAX)B=>OC<4UZg8\O-/M=bfP(RP).<A4V5N1T#EP3bL;2TG4,5a+-W2=6PNF
YT(@X.[>gKeQJO;=PO2@&OV?fQe>KcT@>:72]4b;aWVU^0eD496:B6FFZ6a0)Z5+
9>[RL=6fLGM2P@JJ3:-:X6A5..W6QPDIT4bKcCIORTF<:\FB_;Cb7#N^2E56QN#=
eY/+aU]&9Xg5FVb3PK_W,GI?=(a>Y<fSR/U40\J\SL=7C1)1E.R+.P1WB6EOT-eW
gcS044GB+>TWBdGGR?g+eDAFC-#U0#AAPBZbEO27U#;7aN#6)D6Z4-H9@&2aI_M&
;??8NEF?&>7cHPG31MYLMEd[-X3Pf]M=_O:2LYgHDS9L_RMF#>RWJ-43WL\XJT]F
&M)?,SS;?<J6TdeOe6\7+0-?18CabOJA]37[#SS32OUO^GB6KN&K1PEF1L<ZKIZe
QV:RZfP+c2FZC\Ke#d35b,4M:UOQHTZRUTWDA=H[M6bGH+BJJB5TK>1BO]0X;dG&
($
`endprotected


//vcs_vip_protect
`protected
WbAHVF?,cG4(9?-;@Mbc.1#@OL0T>FIPAMA,\0D7:MO7C)fYDeKF7(::28_4Z1g+
C#0cM4IFE9T_U\]W8MgAA])WW?_M6VWC<#&Y#aO59N:M<2fL-BPR054[TT=J11P0
3(4,C5E/0>MT7f:eF/afX-#NU#\eV?JcJf+IQ,eEL9FYe94<D+]5WT#0?VX\J7:d
P#c5Z8B)AGVI8d]4G>;N]bM5##HFF[gUSVI@AL5U]g-KE166E0gg;;C_Mc.MbVX@
)3S;-\<e[+@dG:NR<W:#4T/<Y7/RfL,fTf--X=_+<&<D,;FO1M0cKZBZ,10b[N<f
]\D?[5R[d=QL:G(>(E3UKOP/6<SDR:&(ZK>K1>+;C@Z#YN19RXI?KMc=2<+fIP?Q
,:g7RC[R@1g0d>O3eC=@]O7.\=d0[>G9fI.V0AK+J+c[(aG=QTEH,QY@YC=/JOOC
0KND2YR7IGSZdZZ>H69>6.L)LSFOR0^TaQKc7O;8\K^M)8&XNZAU;P@Ya.]Nc^Z,
XNR8e5g>W:+-D+4KK[2a>\>)L@CUH&VJJ>>0]a](QMI2P#4_XDY335<,@7e<6a8N
c.)5#G:#e2\Y3Ig8dG1gLYa>d@VT+HMVH[R5##6&R-g;R]b>^=>(=7X1LNJ\B+f(
#E>MB&9_gbG^.OXeN8?4\0\<Va)<BL.1.CQbUg1DT=(BHCC;BaN8SP.aAL6PPWQ,
1[Q#&8U335VOf@^.-Rd\N+HLWEGTA:]LJI[]^]&8)&5GY=.L.5];N&fe-+2gF\;W
7K:Q>N5?;:KIIeBb7/HY4W#9ODAO1)_Td5Ce/7PV0\;+ALbVd_gU<=H^#)Ng^0+7
Nc\X?UYf)@@-WGL[aZdM+.f4PbCMK/TPTa5)9_fIU7&cFQ2I:TFEB6-.EYgA#ePR
C)YTJ2O6.M(^:e5Q05.A&1YAO7W>/1/ZNL/:)gWGGdb&gOBS3OTJWSg/e_GDJOC4
:4/:IXVJ7K8Ld))X9Cbe=YR,I5^Ab<K-aTN7R\T_8]Z=2,9Q6H9I:(@?eN1+89\>
QEPB61cegP-KIO:=A&f^]O_EJ:+\R\^X;867VOUO\I.IEP9D=d8W=IgON6]7YHF5
[&UR[KdX[Ha:6FbR-XFP@^[JOM-K0U\aH1d5E.8^;-\>U4TcBCJLN+0^C<OGOO\<
9B#S^OZR)df7PJ^b.NgOc2T7,OAT./+QN3D?IY>P4P#/8HJY#/-#c?7YX7AUI:++
4:_dI2?.HR=aLe,^J?[Y7QeU\4)+>-bGG13Je]-#4YMD(].H(fRY7VAICHT_W<L^
]K@bRNbUCIY&EG<UN71L:f>#4dK\;1[EP&HF1[1a/SbO>SF9V64<,]>QPO)WgDd+
.FZ2,XNA\B@3\F.#@?L/:U6=V98A3S;YE(DR&2\JJWCgW#=2N\5(.Fc+c9bA6=&/
A?#Y;/9#.B#90bd3F6Z?dU#TI/OL/?XCbPfT7YMGJ7\d+g-=7dYE-CZV,WQ#^9bF
[/a0SC(Q(PP++T1<FdTAB;)@L)E,cJ<:H8K34d9Q112PT8HVZ2(X[[Q.TVRTVB1&
08VY>Ae^cJ-SIQ&(2/fB3:5;^OgQW,e\7R),PM8fS+J9b:TKYG04d0c_Y=DTL]5Q
?0g20P\0>_ZB:5>[8@g>;beS/SF.HEc&AJ@4U]L=eC#g_H:Y#fA_.UL0F,2&)cR?
c9F]8Q],Ogfe/DB-gRC7T=\R]=YRR7\BW/D1Z#cb:S9R04J<8MN+>F_dXRP>#?AK
#6Y\-TGPAM[B5#.bGLb)LZZ]A[EWLEJ;2IfT+@-d7@^9DB/TcUEO]\EXc->A\I0P
1]_Tc+=^,3/WSX0MP72)\WMe7a^Kf9<9<b4S[E6#_<.QgdS-64bNNgd(aR@6X^0;
QD83ED9#MJ&WJJ>#I;9#D8B=3B8KFT4XZ9(;dZ)W4>91f6T6.RRV--D;K8AE/8);
?)/.,SR>4^?[^,H(.OGCI6Tg+Zg(.56&]Z8F+bOKP2FLM]ZbA6L-aC]Xc^.4a4Q7
IJ/C:36K>Wa=]L9-N#9S/DVUcO9;g-JD]VMOO)C7UWbD,U7NA\b>TAGXE/bEe]_V
//:[+F9MQ3/5Q49M3Y&>,_Q=27f6a,>;9O@S:U/L:J@L-7PU@B]O.aHFXa/,Q-dE
3aVL2F-._VDE8L2P[2)CLbcY:JaL)3cc/>HZ,g+,>D>\F,659K8#>TL&.,G5B_G8
\KJ0OD^^I@TcZ.D8;^^gbYJ-:<Z0QJa=@:@FeZ:aZ2<SFQ:9PJd(VgYUK[_A^/]-
M=\,4OZ_TE[1L2@a.e\LV?8B;FL+CHPe3MgKg)eB.W4;L,fL-7:78:U7BNcX0^8G
Z)E37<=RT>V#</a<EQ)XTR(dG>)6S5dSa)4+\NH+&>=YL^A=X7><N6:50;b9?b2=
FE7,]b2SV88;XV;Bf]2+[^6>)&)]](>FeSad\)#-U&RI1fV958A?.:N4@8G8/0#F
)Ma<#/RdZ,8N/8&5ZCML/aKbgF_fgP8P+e@+QL_IbLA;RM:?091YA2TKc2D_K@,F
U@>C\UEQM(Q^D#[D@dD4/Q\^NWTCe4=bK2^68T&]4W>V_:-bG-E@&5)N10RAL1U^
<5>-/P?N,=P4C9Ee.@\LA(V<&-X]aE)BH;CeWeZ5/57Da[[6.fXGHY-O3,e\)W>S
KGL2f4;A\IbT+Xd=389Gc^&7NG4@O[d<:E5HTNHfO((g#LG_&93T<29+>/X4S4^U
/6QX/KNKI+[gDYQ[F8/Q&R)_(H[KP-SX+d(ReDK8@YdaBXeEK:V8B#Y[.V>><EIV
YV[8P<#/aCQF<3S?U@2UcSRdUfBL(A;Z;3]9Y16HY:#J+;N4MY][_FI&1d?5?X6a
VOOSX_YN\GEK]L22N1CRGJLLI=&F,c&NM[QaFFf]^RNUXLe;(#I+=5Dfa4=O4X[a
HDJ01deOgbVI>E&Z[;:\9&D2fdC+:Acf7VC@TN9^#ZY,N7eNYX\YK/G>AD@(d1F_
\Qe==U;.e<>gK#2gQ_8QaeO6JPdebOZI(ZB\.2BE?bK4)&cI3Q<5de)WJ+Wec4K?
]A/+CQAGFHEf?4Y^G.+;BDdN?JSS/aMMA_4]L\I]7@@(8FE#[KU>(5/Yg(aSJ)EN
B/LL=e&IA91;FWe94.7NC5,1SY-H5^Q#)dege7^::RF8\bSaMXNA,=.FA2]FV^.9
K<P0GE^Q/ec/a:T869#c]Y6,+)\,WHREYgJHf((8C]S\ON4U6]_ARd1KY0@@Yd8e
N1,Uea.LR;X_Z;g36?012_QQ:_T.^IKI2\0TL,Q07<@WB@Ga<edO=>-D+4&Z.,9_
1gYGXW,>BK=@0G-XX3I98IL&JbR8P^@#7QKD3CSHXc5T;gG8>FK[bRcCE/F12O:Q
A+X]N6\KKGV9C<=,@d\HU1(4BbE[+1T)WAVD&S^O+NYRDPD.O4U39bM)B.D&Z=Y,
E.RV;O(.7I2OS:IHfM7fe\#.B60_8O+#^<K.KVKa[Y_&V9,A8Z9I98E+M2>Bd6[b
)-8@ZYCPfagK19.XY-5P:Z3B3S1Z0a>APDW58-8X)VA,a&GTZSE(+8aAH=7=IAD)
L;aPC;JSVgf&C3=dTU(&V:^R+G/E1G#RRfT#U6W,[E_IL8#+<LH,gU2QOR._Y2QN
2/WOd7d6A)?YaAE4#+f4A.U53eJ?6Y:J1Kb-XPBAQZ30)R^@M.(XY6@gBW_M+340
#;6@c\9&@Dabc>KFfNFI&S7YZM?B#3Z\6;53IH/aKO<ZQ4D@aAU#:<e(UK9^dB.P
.(GDMce,dI6JA,B.fH9:]S8>H];(KS#ONKY-9;YQ5@QeZ?.AWXYW5JgL</;,f+eC
^U[JP6[4aO4R.O1/-_bW@9<X1\(cKINFP5J1TD/dJ0[BbXJ@4BIe;D[_>.B/W^F4
\,eJ2X&c+I6@+=/:/abB3#bX?P,;49TOQ>>)aaB9,,ee:0Y,QRcJ#K@IRb6+(?.1
;N#K/g=74&26+RU<:+:UVSJ#(:3U[<7cI?O7GCM^T(:K<e^IT.&WBX2V)W(L3_L<
d&b&\d>30PQ@;[8]H,2>W@3YJ]>\T:0\VNRCGT1UPJe+62gGP2LZb2Cg8ff^b_4,
eP),J.<.87E.P&U?[(A3=/5Q\K-GX><,MWL@B9c_YQ?+8?P7EcQDBQK\@[H)fEHO
/-R>edKI:1.b#]O9bO2=eF<&0@0GQY^>P_V)UWJ&],9ZaAD[G5T/I&2HCSf)UG5E
<NN/K4;7YXbVBI4<)\=/7]+#X#3)&If3R:1>e)GJDLHfWPV0IdF;gQ/OA\Vb.G.P
D>Z2Gec8C=Z?UdKDPRUNX&LW[c##-PKHF+5.7L&R:WA+Pc&c2^)WOBg;)1G2=,JK
b>^[GGQP>fC1SN:E.4a(Qa#KE)4D,()(=@=dfB=8FD)aXOQI642B<,O-L+FIM,3:
.NX+MCQ3FNSC4\E.4I1?;VAGM/QaFQ#?7Y4(?c4L),A+]_F7P3^N.4\&NV)6CLMg
bZDFf:-K+2^?NQcZ5T+0,JH4UR#/A:7I#Obc=4A0EI+(2)E7Q/bJgCCNH9[=N.Jg
/fZ\aT:&Eb.MD>IV[Q@3Q<TH=B^6,aeb:b4cF=R&a_274K&#b81KM>aJZMafHgZ>
A-=EM&TUCA;R[S1@?L<D1e+C_e?DGM3Ug1LU8_/?EK29,Y7g#<cP=?][^gGBGYE+
G_WYbU=K/K;R^AQB5=gSR+N]?O5:/&ROY4&CfegPKJ\E+)UW1PJ2T3\]?[&+\=&3
1C.8:;WYX\5fb.JL;f>8YCd.&g5?DIJbRB=L)C<RLP2)XY(QOEEQGbW_eQ+4-?H-
eJ#_?=.M-B(=gc9\BgN>YE_S2?8U+VLV5,eC\E^[)5L&B>Nb0eTW.P,&XL8)Q&RX
\=>5:cTTU>1FB50@,c]<-2>\cfcQE8>>,f9YTgCL_eRB(CBS83TgZK:A.(NNg?&b
_@H)(E(A705+eN_BC117:IXLA5I5g=)U70(?9N&7+bI[+H_;889MF,]=QL+_4G.;
MW]2/FM?IgRF?+D_eYRA0TDEceT2MTNR@\d#JJ)]1DaK/G?;ESD-:7M_(1@9+4CH
M\8+Oab#FLIbW9H4Q-:Q5[_Yd0aU8:D)K8(Y7XDQ6dSE3-YIO9AV]JX]U?S3PU26
I/>FO+ZS:,775K0Fd^S->M2deJJ(b_X005_#&U1E1EK]=/RDJ<&XV1K,Y)Z3BQAP
>(O\^L_&4I-0,J7\TWd^+AKH[T[340[ga?&VS+ZNDSO/0^c4;.1VK=d0G/P3TWF[
GVPI::Kg-K[;WD/:DN_S@S-C&b-96<9VRBGSeW1TdR>QNcL4PRQD+LVb1OgSOE7-
C5dD1IL_Q7c8[b]aMMTG@MN8LL9-_WN/ET3H8L]3C9)1\[>T@H?Q-?aKODYf>>6g
GP<bNE8\dY(R>2gMEG#X[F<MG<N+YWE?8R;2<E7(K:5+5\e?De,3@ETCCeBGN+_9
2#/[Cd]O8_,KT9d+KMIfMc1^(#YI:6e5&?<@Y)Z9;./6;HT[XbD4PCGcCJc#?2/L
S?0-Q\^ddPVN[63PK3O)bLNA)2._5>_^=M23IOQJ1TO#2O(LHNQDg\/3.629I:K^
a\\Z_4G.^/_4RO+SU4\)dcA29bKWX+U5a@\S+OC^I^W[Z/gN3H65_fN+TbRL&7Y.
[a5MV<P+&>_&#=g<gNaF/&e\RZ/^#42UMV76]b5CO:#S29&;?/-:GHLd\DFIe;,2
W^2,LX,>(68:&./beL\+JfccFH;(3,<P<#Y#SLR:CME;RWda;+I[ILPC=;6-_W4U
Z]-^+)[4CbAGQ46\WP;#Y&99R.DXN\g/(g0G4JV/CP2(@)eB9ZI-?c\Q5/L1faHA
D(0+OJ.J+N)6aaLg=;D^9+UWT/ZULLJ^g:D)A=B6Lf>2NK6S8+UZD2O@4,9bMT7R
ObZ2Fbb</_#[8U<Q3,K>V&gGZ#XIbB2(G/4K\#^Oc@#:?)V.8&3^]2R:F+=E+caP
U>eR<BfMEYA^5+L2][DLf-gG8$
`endprotected

`endif // GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV
