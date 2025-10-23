//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DATA_QUEUE_ITER_SV
`define GUARD_SVT_DATA_QUEUE_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_QUEUE_TYPE svt_data_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_data_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_notify
 `define SVT_DATA_QUEUE_ITER_NOTIFY notify
`else
 `define SVT_DATA_QUEUE_TYPE svt_sequence_item_base_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_sequence_item_base_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_event_pool
 `define SVT_DATA_QUEUE_ITER_NOTIFY event_pool
`endif

// =============================================================================
/**
 * Container class used to enable queue sharing between iterators.
 */
class `SVT_DATA_QUEUE_TYPE;

  `SVT_DATA_TYPE data[$];

  function int size(); size = data.size(); endfunction
  function void push_back(`SVT_DATA_TYPE new_data); data.push_back(new_data); endfunction

endclass

// =============================================================================
/**
 * Iterators that can be used to iterate over a queue of `SVT_DATA_TYPE instances. This
 * iterator actually includes the queue of objects to be iterated on in addition
 * to the iterator.
 */
class `SVT_DATA_QUEUE_ITER_TYPE extends `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * This enumeration indicates the type of queue change that has occurred and
   * that must be accounted for.
   */
  typedef enum {
    FRONT_ADD,      /**< Indicates data instances were added to the front */
    FRONT_DELETE,   /**< Indicates data instances were deleted from the front */
    BACK_ADD,       /**< Indicates data instances were added to the back */
    BACK_DELETE     /**< Indicates data instances were deleted from the back */
  } change_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The queue the iterator is scanning. */
  `SVT_DATA_QUEUE_TYPE                  iter_q;

  /** Event triggered when the Queue is changed. */
`ifdef SVT_VMM_TECHNOLOGY
  int EVENT_Q_CHANGED;
`else
  `SVT_XVM(event) EVENT_Q_CHANGED;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance that can be shared between iterators. */
  protected `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE            `SVT_DATA_QUEUE_ITER_NOTIFY;

  /** Current iterator position. */
  protected int                   curr_ix = -1;

  /** Current data instance, used to re-align if there is a change to the queue. */
  protected `SVT_DATA_TYPE              curr_data = null;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_QUEUE_ITER_TYPE class.
   *
   * @param iter_q The queue to be scanned.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY instance used to indicate events such as EVENT_Q_CHANGED.
   *
   * @param log||reporter Used to replace the default message report object.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, vmm_log log = null);
`else
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  extern virtual function void reset();

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator. The client must use copy to create
   * a duplicate iterator working on the same information initialized to the
   * same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE allocate();

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  extern virtual function bit first();

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  extern virtual function bit is_ok();

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  extern virtual function bit next();

  // ---------------------------------------------------------------------------
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  extern virtual function bit last();

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  extern virtual function bit prev();

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  extern virtual function `SVT_DATA_TYPE get_data();

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Initializes the iterator using the provided information.
   *
   * @param iter_q Queue containing the `SVT_DATA_TYPE instances to be
   * iterated upon.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   *
   * @param curr_ix This positions the top level iterator at this index.
   */
  extern virtual function void initialize(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, int curr_ix = -1);

  // ---------------------------------------------------------------------------
  /**
   * Initializes the `SVT_DATA_QUEUE_ITER_NOTIFY using the provided instance, or creates a new one
   * if possible.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   */
  extern virtual function void initialize_notify(`SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null);

  // ---------------------------------------------------------------------------
  /**
   * Called when the queue changes so the iterator can re-align itself
   * and see if any waits can now proceed.
   *
   * @param change_type The type of queue change which occurred.
   */
  extern virtual function void queue_changed(change_type_enum change_type = BACK_ADD);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
^Jc8DI15ZU:E6MKCA830W.[ZY6&2AZVTI,NeI#b_MPFDJ??aCOX9/(YGGP(Q7W-D
gO]Oe&\JH_GKH9De6BAM>+_EK-\3]4R0c[\3NP3F=A\8Ua8VU;VgPdI(A8bG2O<#
VJR<)/NG9^M1B[:6NcZDY9L(PDFdU54)V,e^AZ6f=N2&XD-<D/ESLEF4<B3Ee#=R
>PS@<87]O+>cFNS=9J;6NZd^)GfaGEFH9EKT1cOM1cA+._BYfD-.^b\IgdM^423F
X;S7c?IHS42H.A15EO/YaJ2+XSEHHYBH)gYYZG/JCaHYDd_fc-M-LVXPUP:)_;&@
LD/ZW@e;ZQ#;VSL)<Z0\]WCFJ2XL&Q<>#O]W#Q3EDa#OE0:OMFG[-0LD76@HH2#X
I\WEcJ5AM5NL184><<A>,(8(IP,b=abeN(gC(A4?]3H?_DTJU1X6I61YQf0LQ\dF
.9F=VU?S>2,/@<5U4-#d1gEIG6FKX#X>dD\;6GOdK/#KFD?G._=6GO9-;fg[LVZK
#]fVeKX4L:ECOG2FZX(S@CFd[8K7LO?Ge&SfXe^c-4WdUVb\#L7Y8]9P#d\g]&QO
J&F;WPQa_B=5LNVGP)A[Hgf_geae&&)E\OeI07;ID0R7L1a;V+VA4^Z\-d44LXRW
P5Y>_<+J(VLb8IcQc>X.T,UC[cUI0NVKcd6?#AK+P.[CO+_RO&]+\@&0f:6d8,0@
=N-0L1\J;Ke->eBP<[CDEEE,9YAO7QD#9<.ZB3aT&3)&O5Fc815(d#HY/O1:>:9D
92M3]\-05[N+D/1:gKWTU5b>YAA)fL\^aaXaTS#Z3E.OF:gK7=_0Cd?2(g0@I9KP
^ea9AW.06Y[\(THNec>)U13025<fW/8:FZ;[5S^D.HZ+eG6VK]9G\GNTYEN]YY_g
1.XZ=eW#R)H&NGZa6&6;ed6aTeNbL^^31=L:aA]T<(4]JO=>C??:<GUf]+T7L4O>
,2.SW(&<L1bXIc;b-a9RK,&G[J3]=6=>,D1,TcWa_^@1cFKT,bC?EC2IURcd8JI(
bgJeCH8?B)S93LK9agfO)-Hb/FeHd;OI9@^fO1>=AFG[+MIJ3\@G(()24;WD,PIg
RKD]A:86D)&JcF<KADAd_,XB;LKLSFNXGVTcPXPQUXA6&.Y.MJ8?>MGL+;:.Qec>
=dc\C3RD<C7/Eb\_QB=cLYJ=+TYPNT1,;S^PbCZ@W(-HJ94AMKP;dS&L)UVCegQI
.Y(00E\N/MYGT0V:;+7@(1fNA5X/e1(bFN+QTIPVU=8D:]<I7MGH/&aAIZU6E>Db
4VP4(6DYEaa_E,K]?\53SR:@g3(&@8dT]B[a3D8QXDS]fH8f>.LFaE_N_H;49bID
J]KKK80BU;>B]PDQ2V=72c1<33\1FR^:RW-X/aS8I07G[b=4ZFB,U)#=CdW#ZUga
S8;b7(]#4a\5&24<_9M^OT]-NSM=ZO)(R/RF1Q+(4?9@dRT8f]d:D5g_Kf4O900E
7=8-CVRf&><:e1A<-E_bJ\5V;6e8D5-MN44EY7B\[([.)Fe9F55HGfUS(2eCR?3_
-,@^XYC_5,>4?\&)^RV[5d?/cMg.3MFJY#=(6U.?LdV_\]c.Dd1Ab/baOBLKd>JT
KDUY:W:OfLCIW]RLV5N:WgJ0)c0?[B.JD7KObQg#32U7/M>_@4_b8=cDNYc<W+B)
6UcNT5eLa@ebHc(b6/27f^JQW9X(KG,(5I-eE+--0J(>A>;\NHbY3PWO==)+.e7B
.(U3@EMCX54HMN+M9X<)Pe-?(PcfLM8NR>=2LVE6_WLHY\S?7RG^JEDb_@cZ08?A
6NHD+7DeIdHQc(_PcY9;e=80L,)a2#<FcI:4#c4TY+fadS_fDEFMCZG-88@>4Z3#
0HgYG?C]8ZLIa+4PZ<U5#12-F+VG6/\[\F=30^UIMB-F;)+eT&&U;]&C@:>J\Ndb
TG#FC4e,D8VUdOP9Eg<aP\Z:KgV:@)Y@9TVeYPFN_6Kc4ZT#KXZ?FVJE=ga-<3.J
5^B;44P3:a,4BP?aNA(J(4YX+eVbSK].C@^@F-N3d<&R^.>C:BPP]W)5XIRb+0R3
]^\8@5d:5-@6Fd_QIJ2S\J(DRM4N+Zfe#TYFaL/=e6UX-DK;=-e;c\T7QcEaR2N>
#?Dd-La34)3AXa,=]J1f0I>5:a2JB92>8?QgS+:XYK(^SQXRWLU3KQ==deRWD.PX
N?R)B@>FcE=7SM^a:g2DM+VARE/^R/M<TPH(g<_F]PfUdR3QPU;8PfW5E(.9M&23
7BU\+VB8C,_cOO#T3@aA5Ld7[,GD(UP:I:8dUH<<E67/Z8#-2ZM,_8<\Y:GGEIS[
C:AQV,WX<6VV6_d5R&F0-bXI&eBI/@R6.I93d&<1ZDe-L\UB/^N117M7--Y5Wd#7
>0P2WgHXK[F/^JTeQR7T#FY.&)[\#8Rf9@a7cc4>.EbZO-G.?IY7fE59F7(\CAe8
#;Q_c0OTb[YeZbU]8e^Y.WFL?bH;C>^2P.C\f0KZRf(-/Y-\9W#O5Ue&Y7VM1PSU
Ub9VB7EE0CDV^GFEf\D]48g5K6Lf(C,X8c27MT.5;,TU]2+eL1b3QO64,BNB)45,
RH&-.eE_-:/85B66N1R&bIO9DN-^4K<E[SJ3>NUC,<_)#<\M(:G&cMZ-QeJ,2BfQ
d5+Y0ZB>T<89dMcg\#8aZMRD;.:f4P61dA[><,DEe&&CSaL5ZFSJ7=baJ4Ff;gOT
/:)-=:K+;?VM)S.CDY&UbR48^K--g@,8/YON5SQKXSD5=U0=S)J12[T:]^Q#C[3J
F;N./dY3H\++:3+=\:684aUd-<2.(@0.GCX<3f9eaG+\-XNZJTfcR8;C^=\N6_3L
a0)T.YMQ_F)IM?B6W?8#f@-(QWQcX?K6:B[A#eWYH1NS5PEcX<FGRf44LBMV+e+D
O[4=[[-^3]_U6&13dC?CJBcCUCR5PbM?DDec9JT92G-Of_e[.dT+KN?=CF[Z&2EG
HXLZW;W>XOc)Y.Z(ZM&O_5Yb[N.:71L@+A942XKTDEG<V_IGN/1T(\BAT6#fEHAL
_FEfaJ1P(Z@E<^1=@EH[d>?2@O1SB2BWTA9#SD[P)YXDN6Z61[=?1)5:&,XQ-:^Q
5A3&(_CQ(LJY=a]WVDAW>C?Q-OObf6dJ&+_3e#C01M_-LDSC_DGbfT(SY]gW_?#5
&3[Z4?0]V4@1^W2EYFJ<CC:,RYDYRE32CEN0?EF_;:VL<?WQ?/5\CQP;DJ+,@@3/
.Z0PcaPPRND-?0)AKOGUR#5^<(N-F05W[9JEMS))M,3&4AY[ea+4e(Eb<gGL+3?f
\]_a(X,^Ec?D)V]bb7JJIS:JD1,[ZU&6;dP[J&U3AA-HBX_/2M6]EZV?X\L.A690
b)]\?g.G[:<P5bN=3=;N521K#\,2>X#EdgL05ccM.>+gN^YJB58AI(#+AV=e;4WJ
[;MHIBDebR6SHf&Q8AK6@Z)C0W,eMQRIZ6TYR2#ccE@XZA7KX,/YKP)C]@b,L-^H
BPa\FDd5C&XPJ2=@C(W#3/1+J[cIH7LY#X\AEa<[<]N)ceT#YVFV/ZbIe5fT7=Vb
;DDT<&C[P)-1eLHb+L;][R@,aP\;DW-C3_ebE_3JX(d4;6XZ:209[d.UBIVLVK\O
SA&NE)M>b30aQ&.fO-Z#@L+dXb.9,/[D8I9X;D/OeW8PJO7]4:FO(1eAg@12(O;S
9/=2e<YfJ62#DEgEWFADY=D)daJERc\HPe?C]Z_>Rd+[#,T>/_/Ed&T0MQ5S?1H]
13R1TY)Y-?BTRef.V0RRDN:?P(&9TMSQC>QJ6L_F@,X]d6NUTd?3/._T(:@^bWM<
DQ5EZ=3B1QF;7UJHU:YLV20K\b0Y98EMFa69Pef0U<#D,H^[==F5Y66XQQ\>KO:I
7/>EQR\2KgWU]7c&^-IG@_M5(UMg9PAB5;91U=,VT<>E/dY^/LMM<f];&G9[/70G
3[TLNHGJa9ge>^U^]3)8Q?ccZ):V/M-JJR9DN-9.c:T9OBGW7L[de9daR<+^I:51
Da@VQU6PC(W+Y/BKXD>X2KDXN)Kf7I=Q2-RF[<S1&#E93CYBH3KK8^,_(@S6@K>R
RC8b.NPW_6F=.57#W7d.8:@f@M).<M_-Ca^X-O@3S3J&5J-FSZ-TL.1_CLFWO;QP
4=]d,->&+5OU^66J-3D)C;=Og_Y/]bNWD/R(^P<B8N@^:cU<7a4TJC]Ld=VO@[/g
B_Z?KE1K9b9(]\0]SgS,,2b^2DG\=Z4CFeeGCP/&KY4CK+FVL<^@cf;ED\Z6X(>Z
XX:f1#T)Z(>A4YU>T+PEfIBUGbaIa>,b=3W\L?]#OV#_AYT6DgJ?6_85=\J#6AFN
f592+QZAD;UcP#_/FFVEc8WX6K66\cFH6MLg.N(.E:&NP2<c/e5@ORB6+aFTb:&8
db[?;[;_QZY>(^06/1-:\V@O;J;IIU4MU@6^=[58VIELPGM;(cE;&ObFY]H;ANT^
4J&J1[8R0P597+U2gAAMQA(=Y^DCC;-]W28L;<G(?1c=#M#QC(O&X?][GJ@2-X;^
4[)?THS?B#7;1Wd.gc]B/b7[B-C^[JVe]D\<M)P<IWRQX_LF.e?[E5P>^V538FK;
?P&f]9OHU=6_e:0bFf,GE8ae/9Y+U]=W)&cg^Y+2Kg7+O]W6F_>\7O(W)G8[7d.?
+^:<G:>I/6)KEY_59g/YH]ZcI#^FD5[2G:R8#^(]JY^7LJCN0=V@=F?E@Ubfc4&Q
P:4_48Uf+Q=7?H;[_4g-5gY#gQ,B+2B>Bbc7J78]0PSR>UL>-I+<P\Gc/4@I74(8
JT)VBac[XC\D4Ee#1\8BAS:/-aXH^bFQFCA99d.g-PgIP,),d:[V?\2;_Bf<)a=I
6<g3IPM-A@6U#H)LP5aGU.DbNS@3YHKB;JS?-C2Y-:P1QW#[Z=(ZE##32Eg,gYRA
M)?5OfRK>IfV=ICBW49JS[8ZI.@4MX@.P6YZ?@2(/U7LBJ\g4+bS[KaSI/Y[)5]E
)97#<PRG2K4J#/NUH6IUb8Va4=UdM_F^SSX^T6RD76V_4#NM>aTg:2DQC<1G<S(Z
b.@Adg[XC/#.:9?0C;b:N4T]aI^3RZSD#L27b.[X?G4STcaKPB+Y@dDW>A,G^[23
SWUOIHLI.M_I7b#FZ-ZJ-W6;aJ^<&^;AOM]cW;KcM4YIBTfgEBYO<OQ&A3MMecN(
=H:\DS?N;=SH@&1OV=+8:Z0@JEH#BB=c5G5gb#/39=;C#MP8>@=:F)8L;D,S;HW\
TgMeL)&9(,L#AXX@WbOWHbB7JdNUT0GBNA(QD#+-R^[Vd96]If.X(cd#11P-A]BR
>;C?/-#H6I7fY-(4RWI>c/TL>TLO@FV\g6R_#L(EZfV+^NW\UcW8fd+SCPU=0CDg
QF6L>V7:9K.QE9=G(P9ZcQ#^E5RBDBDFMRZR(6Y44NgP,5.FRO?3DMB/&IA90B2_
MgCV8@T=N]P[&C-c8f4C@FA8K<0XD0c3X#KXF,80/WO1G[6Z.T8f[4Ac.OQ/0?(c
4[f6XaBA3Lf:C(:ffDY?5]A4fCb5_,.[AfbFUY=_J1[L#\7d6XR:HNHF2(GK@(Xe
D[RM]JW77e3Lc(;aA\J\D3AbDNAc:fKGQ9U/Ng)8W-1Z1)72We6A:&J.L_g?=NO?
=X&B.Y^,=D9Z\(Y//X49&IZU#G5E.3@P+,TE->F=bWSIf[#.M^QNfHS:BG(;,L.T
9gb=G(V3LVb+aA(\WH3bV)._E=[e2649)?_E&34MC8\#49PL?6;b/G(XVU_QALGg
J6@HVf4#?XVSOUBX;;W5#Z^4U]9,A=Od&OR,N?eYL:ZU2J.[XITWe[\=aKY=2aRd
3=NOIfPd=T(MC1e9ZC]eQNL8)b[]\JX[C#CK9R\B#:3^<bI9_\eLW(O5ZS10=GaM
=Z=M0.C\)\)#_(e8NTdFY,#J,W2F.[RY)3fEIbO-Q59672<MA\WaFT/B63bS)-a]
64bMKP0ENMaC4@E7@415IN\IM9dX>4a?;0,#DFG1/.5C4)b\+4B(609e\=.)CfN1
J#PbOY6+f;/0,BKTL>MO?5,f=A^YF=Z,K9)AHQ/IJfU6[N<;-3?F=X+bO;f2C5KT
P/9De?\;VQ-]J<E27QZ02/XW1[QONL0fdAf6:O+#f>-UZB=W#I3FT>^W)WH2T;TB
58W[@Z7Q:-3SgYJe<E^/AXLc91d8HRBU_?EML=)X,A8,3O_(P7e1\Kg7(/6]39TL
;1@f+#AcJB6,?F&5/6,4,54;S-+>DA)G#M6POV0F30\_@U/V#.1PAM>a7>A;b4_M
f=Od9SOHAd#)XaKR)#O:IL\4WAfeg+,T?#V97^Lc.U=;P626eJ-YJA7/VGC.F]55
?=0e2<3G@E(YT[5Z^6;+S#WacB61b-I@+K8OXb##T>QcD0+W4DEI4(:,)P<TU:8J
6:56[/\4-K2]0)#abYMQPV\3XUX;+IU8CX>N;0P-G<[]N#G-+4g-5b70S\>GC,[&
-+Q)FVX=9^[V1B882EaNeU,>KA8A4]RKKQb&Z;87_LT-?B@BQ9[e)<cDN7MN<QVB
FaPI_\U68&3A-,Y(#QHH=_Y:<Xf8]0a<(Q(RO-2/IC-9#H0C\#FEJL?VLTaWE2,d
;^a&gACL(0fPPC66H\7_17#XD]R4CT4a(=,SWa\KX#97WKNVIQ1Q,^;YLIL/W[d@
0?T\KD1dEE(f2+b-_d=HaeVKJW<fR6,Q2ZXNJ[]8+VZ4#.Q^A^ggXQ(?Bd1]G,Jd
2OVPU5:O^HAKVU6K=,6^L5,3D7+PPC,OMSQP&?d.-=KWBBN4MS?+B-e5)agA-[8C
9\MF;gF6A4B.H5g^K1_Z_.UHYMA8/_ggOYB,XG.(&];g(8@1;WA=E(Zd3:,BAW@C
F;GAZ7#&0&2X=VA43e=+WV1cCO@IYWTL@#OE]^0=:05?VV#2?G4B/7/K+Q;Z\_cW
_8.0bU>^=/aDeL3H&Q&bLQgRZ<JX(P?@V\<\@3[9?<U_0a[@CLYBCe(:[++=Tb,<
W#SX^bDeT.#R9LWA8[dc3F3(-dARU_e-AS7S+g0-+Mfd\Z/W7+9<_]AQ:X/D\O[g
1G1K,#Zb=O+a>KZ;TRKJ6J1O+4>)_&(,dEe3G=RA,F^ML++T?00XcI-V>2VG#f+>
&(9X1(4Q#1ded4]B2=)U4f03;ICP6:Z7#7IX,CJC)21,21P98C:^^4fb&/W]_aXe
<6KD>e[EEY<cW]3F-fda9DVabP;05WbK>B(XWG+2(2SY[9QV+)7W32UIeI&^c)@[
d=)E))2#QJLB<N17V:.[RB,RO:c:L5b3=:6RT5PJf7fY?3L;f)TD2S20DBL<gZ7d
Ke.&GX)Y.@1Q+SMaU,?fQ(F4TI<6[@F_5,[2edVWD&\IT@.\32]T/DZbA]PC&4g2
aSa)3Cg[X\#YT=ZA<#NN.,e/L0J[]&fQE8GV139W^0DS1R=.?^JaKJLHNY0(PbWH
-TIc@1B8=4]=FD4F^44JWJ71DB9Zb^KZ@:09Od0?2-eK:XQ;IXO(5^-Dd>[8)7AI
g)MM1K^XB7NUNLdg=)=b?R#^#0c0FGI8_H_HCR?_Q8]gQB(I.\78B8RTbXH5X.2O
I]VE8Z@I:>5Ab,7()/]NcR<Z3UMRF+g/36:/,[[IH+Sc#>]CX;\^bWeZ/[cHWbW#
<OUBO:.SZVEUdWXPS&XVH&OcXQZ3-\F[KDA9ON)a:<D+GN(3H62KCfd?U=W9M#aQ
N-<&<N3SdICJT(\X[I8fQPHa6Ke>M7]cJYABf]8]>IA&34J=<CLJggc)Vg53#;e_
\?=DCBJR<)YCJd_++(aOBfWYL=5NO:9-F;;=@S83((Z,cT,YT3(fAa>)D?;VA3B?
gFIG+M1AZCgM<JD#R(P2+BTY30gO&LO6>A]H0D_X&\B51#1UHW?_7D3Qd:O_9LQb
)_eP^FPX@RVf3^:AW68.ffZ9I=6\+PF>ETa](L5_D=1:85_,U8:[f#dT<.T3N&XO
2&:A@\V#Ad[Z;,.VG>W>_Z]DZKBBF[^ZFc&L,cg^N:^E0S)+,TT,^,AC/A1KN;S[
DC9Y@O-^J<DL]#0)Y/4YFd;_#9.PS-@:9J88MPbcgZV9@e3:8TRFKPM#\(5RK_GO
>DK8MD\#(d<WRH]=]]^__JY7\[g(4_<P1F]>(a8fCKOE#&J46J9B)W5U(W)_3A@/
8aScVEK/Q[CW1&&?K_F-f^Nf@IZSbR1Z,PVNEaL>g+T@^?RL]-0^d<)SRS7.?C@9
K?F]9,I5.G4S2<R1QGMIV@WBOg-=XTNCIA:.]>@+e4^.>O==\D>N2S>M:<)J:BA;
-NI+-Oe?+)>+C2HRRR^/90GMHMFXM]^R4Q4VKWX=4VLRHG^39S>fP:?0^&Xbd6V,
T[\&W(T\S?(U0U@#UK8=#=J;:g8J,UNTc#G]UE1VJ3/HF:@XGY2X<44RSeI<I,X>
XW;4,95VU\2dd]gX8ZU>0;<\-fCO/dDQ_@fIQeHA[J/;<)E9=Y9X75H_2E+,.5^G
eWP;#X9)acGUPRSCd6<HV39f][U_<YF1OI.Ic:bRYV>_2-K&C5QY49I[C5Q6T=1C
.LGB793;PD:=BA?f]N7\)Y[Vb/.:E<^:Zf;[cRaHa&9dLDb0XLQGNCG08/#6I>W6
L5Gf(:b5J;X5bIRb(+a]C&MW5WX@4)\.9FC)G>]C,Wea>G&U@e[2dD>^/\gKN.N,
?Y,(-fg&\I0A10;EK3QH=I]PHd2KRCbY2PTeb;A^3cG/&\YW^OW[b@SW^&ZD@ddV
d\GR1LaMLK@>:D/#:_AgAdP3[<WJ892GRIK<8(N9C_QZQG6T6^\W)2X?JP;NA3T/
dfcSF(@IW0FVb=.2))]S2N^C1cfN,NX3U0fZN1G9V<WG#5PcRdZ.]+76[U+EKG^a
&6G/ZVR>M=/K#W\QS)O9K/.I\LQ?QV@S7.XG4AZC[c[;L<VDAJ<HcC<01[S/U10g
7D-gT\_=dUI7X\YD>_0.(H@]&4(6U&K/a]9C[dC9#)8(YEXQeSJ52<47<N)XDK=8
Of#GbZ98RT;TS5[XL:4S6B6HC101?;112,9(.Idf?I2e25UXH1DQH@ZgLb2@VY,7
b:\dYd/1=0cMGg7?JE_)0BCRAJ0GNdNSfG4A)e_CQHNYQTWL3=C<&>QC#\S]Z3/Q
7=MJ&=abdgPQ\C5W=)KS0YF1=a-8N674gQZY;7_=a@JU#3aJV@N@KTNEQ34FgAce
b#ff6&G>&B6ga,ZBUIe4)29TJ,V_R(S-^8EHZ?8H?G:9DC_Y/3Gf(P:&S3(C.&[+
<Y=d=Z]CdW.2O.>]FL0#WZT)J:E1VI^CY(1Xf6RDaCee#Gad,2Z\A-f)ZQFE)C?;
?2O>S21^0&de;fVI@@?71gR2<3gJc3S16JI6IYDR>VYDe>e5M/c7=E1E^(HCEI&)
Kc<+:,f\TS//f:>P<8Ia2A(^GOCHd&5f\/?f;(SBQ/Q>f&S#g=WF]?ODPGeTf#03
(ITWXCK3-8#VY>e[)Y6,D\g4bH@aQ;S+CX=GaR35gMV[7[OfNS8JQ.(&7&O<NY&A
45?T9g.X80#[M9@\EL\]URBeaGV&e=_BH^e=^:S&(R0,JXW8Ta\]0A10MRC<V,,.
,)YTOANdZdP1GOXZ>K(FSD:73IYDLF3Q<.E<XYH7TZO@VCE?\T[+M6>[&-S=c+T9
+VVBUS=,Y<<R.5DBU.O\#c2=@[)/6cM]5A2GY6bB+8+.,6Od6f;;9BKJM+?^FGOX
HgHBH)4cI:JbQ3:/[RU+QPG<(=OKF-E)EH#1dGDA-JO^2]#+SJ,1bGXT&#.(90?O
=ad]+,]4S(U;CGWYdZg7\f;XKRbda7SMg;-(Y03?S:9=I.0XQGT5QZb;g/++S]\;
YTGb/R<6YH0@dTC7>#9)F]SU&+?9(J5]S<3+@O7N,4VX+Eb[BUB6=KNM7O\5DPCf
(DCT[HMU?@L>SO6#?[7JQaH+;_W_I.9Mf?cPe^fWec8TaZSQ)BH]TQd>a.)B,b\3
V4(IDTO^]JLJ>5_RFG2WTD:gV[(S=d>+L=ddg1=.0^adEf;,;:5L/OUf-VTCI,dX
1d6=Ce_8f,DcecV?PP+NIb2-L+-9(R[/@c+622(QZ,6SgB37R@BFF(SY@5gQV??S
-8BL_T]f?/3T5.\XS7\C@d1Q1&IQ2#FM1)JFSH(EVRS&EDN,KHC86ZeWZ.RB_b2E
YR;f0UX.HEA(ZS[5DNg1N]BQe6,[^-Y+OX(QV&:fEb?#HZFFBOMVW=-L@cKDH^C=
4bD+RfeS]Y5eJ\RD9\0W-N+\MX+.JD5YQ//VgRM:Q>/WdW9c=^DM&Y?,#>H/,0Wg
SdE)R>U16M]dIS,Z=HaW7(S&U-E7U&J.J+S2Q_S^NId9A>F-:2?U[.8S;/:?EX&b
e9SgPIKS5_EIP+f,8f<J^?\Q7+Y(#I&e&KY7JXeE.X50MEYU)&Xf3F-]ELIdW?0M
NVLF#:6Y<#d[,;ZMUM>YA3DG7Q5ZeGIdAVAaHO+2Z=K\HPTVefTL]IDYV_W);O7@
4:@<OV3@WVg\.f^)IbgNU;?S:JeeUf.F):1eaF;,7bN/=S8.<?,R6V/T.6;TVbNZ
T0;:CPN\,5Nb\QI47=dC/+;O/WgQ9DI@\c6cRgP>;HMCa#/_FgEfV4HFDLgQ>/DA
_82-S-B7<^;P;PMB?Bbd7?_cE0d_Tcg4W^-[,VOTO]QN+]H54?DEAQ)]eZ&D<;Hb
=&^&I=dJ=g#cfJ+;@WXEUY1UP\a:=^fX(O/:,-A]QM\Md.0#6UNIX-X6>XW56HAC
OQG3cNF>.[<E:bYMR7B0LL(g=GeSUg?3?+\#;UBETM&d3K+6QILUPd7,E@T/GbU0
51gd>[L+59#.1RM7+FD[2C:U]fA\>-J[24W&E&(^/+T8<,OO,LHM?U7,G-.b7]_E
KIY??9&b9(JB5B66KbF>LS:[.bcU9:8Ya3QO-0Kg]bP7Ya[B?VD#]71U;?ZT1LS+
6.^caA]?=P=^5DRdIXVHJgKC;#/(H<aG9&0KX^^?XBcYf-6L^C@c2\FR@<+ZEa-]
P;0YJ7Q<7425LE.3P1HMQ3/>.IU6[IJ1S1XcV<2\-T:#8TUZX5CJ3/7=Tg06FZ#\
,Q8XPRK-@7(P7-RCJ<E;d/>P,4LbY8^P-9T[F9?HW=?H5C[J)02d2I7TgF.GG3>K
d&5\#EX6Z-[IM)(G7a.YT_JSX:KY3+T;_B=K?ZQdfC;De./d3bZ#6)bP77R-._9Z
/;2Z5>>8?]8U0b_D[-R9KV3.&=RC7>W0JIU6ge6IYM[0DQL<DC1[bfR^g^dQGdN7
&&[?4;-2;Be:e6V6T5P]RZOWG.a+H(dQA4>/1.=+SSU:bQK9]/X)T(6Ee+#gb#M#
c6Td_.\?3GSVB7g6(N@_UV#JS3>>03(e.5YB:[Xg36W(&W8JNSVOYCVL4U?5gWJ#
03\HDJ>c[0\]HE8]V<#]NN4;F2W+1)7/IT6K-Tg(7F^LUV\)>O&Na?PGAUBSCPJ;
48EE?OQ7gE@&Q.U@W\C@Y+DDCS97=C_FZT::NKNg1,[d=OYC?b2IO,(aE1D[V(N^
=Y:#/4<aG.OL)5g+8bBUbe#Q]CS>XI&X<Q(4F8VA[NgDc[D],-aK2,N7#@.0IAYP
I3Y\3@B,fYJQFELB8VfdWG:@g/8R,/??0YSabfLVO_;U.R/XSe@7)3a#^3Z61,(V
&&+DDAB>f\8dX1Q]K+Ka;TZ)AHd.>A),)R?E;5)7dV&RNXCY\/>VZKFD2PDa01Wd
)184Z70>X]JL6[JR#UBc]?20H=5\[VXaOQ>/bd#J)\=Q_TedPRUC9@.8:=_:&(R&
:;DBVfW1dXQ40PTaU&[QQ:J_JFK31V\4HW@/@EWY_3+b.0.c8D=7<?Db^BTf,8WN
A4)L&T:>B@W6&IX8_PCf7P=TITFJ9Mc)TSW@]fZU/@4(X,6>[NDUNDXS_:QW#)2\
>N51:a]F+3F+0ega3R6SUZa2PX^\NKW5P#.XC.eDAaQ=TS?g5HEDc2:9G5==C)F1
MS^#SJ_MIN,90..EcNXPU@Q901Ra/Q7QPAR05UYea.4QEE[(DPJF81JKJ[@3Rb1>
:B07R#6.b6H,QPB>fVP@.SV+L\82>Xf^;Qe16bU7/0[U-Y&)#ZNJM/<bT/1?EA@M
a[<cO>B&D?b;/HTc)K-YF@RWXdb&WJ2M2bG#=[2:ZdVFXOC6-+0<+(QFP?>VUGDY
,VO&R23JE-_QcR<3AC^H[]A)/@Q],=:?CICQAR&.3eGIFSXC][Z?d-(IM<fdAD4D
+-37AOag-;c3b_BG^(::KBSeaR:DbZeLW.;,()bD);@IZ38WfZHLX>Jg;>+V:P+8
52#cX>cI^>,+0ME/3OG<@VJ9f?BY30VI(SMS1:<-QZ;#1\MG&ULdX+)O4H(eK\V]
3fQ[G\SFKI#=PcNb07[>M7PLUAaL9Q>97dU>NI4[]3ZJV>8)[8CZJ;VZI2L_2FJU
F5@)a^>0?K-A#>_1]G&a0E]E6[^+7B8-VEV>._L^Tf)I&]:\2L#[fP-O.QbAN>83
3c[W[537Ka7-g+4^1Qe(,f^QeDQ66&KaF9HH5:-E([@U^TaQ\YU[HC9UFE]4?^SD
A4Y195FAR/YM;Z_2/6H(Z+eORe7M1ZT3\O6E@UD_IBDf<[K/RI^:DG(A29DPB0TR
)G=g1,^[[/V8RFBaA8B[bT;.A-W0W9:OgMg^-&[XP?W)6AWaR/P(aK9:dcBT><?)
@I;d1UOKN]@[[JT22b]X0NdR@TGRD[)R^;(1e_Z;86RaZ@Z5BgO84aYf8G^aE1Qf
71#:EOAR0[IdH#)TU]8Q9^LT@4M;>=HLfIeVCAV)S&f4UV\/QPTG=&Ee</2YE5:Z
7[0aR921-H0=BDIG9d9X^U^C:]BbEEQeP83H0fHWT([>)E1E&267(.P[Y,>IDK35
5bE<HCf/MAHHG[>^c.(T(?+]RG;4Ye\.6>E6a4-RA@]+57\N/RU74=5EcEgb=HcT
16dG]:1DE=)?GWTE0&9IBKaG@)U>:_+f;LWNc_)?G1ZE-:@f#eH]>CG.@Q#L0+CK
c1.;87L_\-b#5??P09J5A9M89B\+2XPW>CgaE/ZR;^5DMd8f1#N36F\=#A<1/XO:
T1+;S8R+?eW]XK,L[]29(HDFRd.HHBHdIMV9QH^0Z,/E2P4G?S(7B\Mg5f^WD0M@
Occ(#/CYfQXf6H)1aS6QM\=)HWCY1GW6B]^TF<_^UM97F0;KQ/NTV@[>N\U=ab.)
0#0A&HKD8-g@f;3A_L=aXFLaM\L_A?^Y0eFA9(YVTW2_ALI??51.S.I[O_EW9KV>
JJDRbSfASA-eKCVQVR-/0e,[GL>-PgPP:3404L-J5Y32^6/8=BAeT[:.2W[.dPQX
R<La52FYd+\C,g41)UV\SbRYQ-Yc2Vd0_3RWQ/,#,^SB@+#=U06Y22YA?3_W=W.2
=>(dGdB7JY]I7S7FRH3RJM]NUMT9<dR7BNNMdcE#Z#S?+CF..-^76J?:VHb(:R1b
JJJYWZ?JKD@Z\Ab#4RP8Q6f:-HUBaX;gd[TfK@P/6(^@9O+?#W[+Yd[3:QJf9dd8
6IXa=EX2Z[beW^1.(=8[V]&-CE;T+dB7.6HRQ_^V82?/]7DT<RCaU[9W[2&Q=Ra:
\27GAH/43a(#(,^_\R6H1@K,?L,(XV3f+9DcS\D.^U[Uc),L)H(BaKUO;>W&3\=G
O^=4\?(T&L2E5)Y,5+]U?\3deVR\g2aKbM<Yc=N^KGF-FY=O#&S7gR57LTdOS4NW
aX[S4L>UeecVIO206BIKMe2O_YbdAZ[<dA1U7;8[T\1a0#L,AE\46c<YWc)fQRSc
OJ11_?JD_I(365gFJ40U5@(UD240e.B:FA,,SJP.DYfP-DL,^RdeVLC?8:b88\4e
TEb&S0B(ZV7Ff&6TEW#Y6;+0Z?b<XQU;6e^00Cd0656;QX@M)RXgG0,G(_08L1LT
OSY6bXE6]dV)X&3T/9DB=O>JSc4TH))I]E_L,QS98Q?P]Hf40-BXf4ULUCIHb]9E
^>U43LC2GO;1;J6L7/6;D&Gc@>ZIHOBVF(6[Ge0D^XQ5,6Z1T0a)E]Y0HP-g/D;M
gD3;fYXIHY_,fL9Q_d5QB:DSYPcJf#;P<;^NYEN_FU[\f2NO:7QWX#NIY^L=?.gO
-EX8]TOOc/5f@aeTK0(ZC?D?Y.FJ5E6CX)U<ge-I3/:6DMb[.VM:G0,ZJP4K]DEX
&#g\=c@e9O+bgDYXZf@S->&34.HYM&^=?a=,#?&71K30#>e[f_Xb[f5T9Z)MSKZY
;#0++Z<AaPW#:X^PN3(WX6gc.HcOFdI]I\,(a)aWHIH]aX)3TQSJL3IgGbgSH)(K
fe@(:Ze>_P&\5V;GI-9-_EaZ\LSC\2NR(/J_8c+IFP8R1efB\_.Q;RT-X^]_3B2@
TaA8,;SW<ZB8M.1;R2cacGPdAKdd9fN?E],;.4Xa4KTT9F,a4X@3]?X&A<[]9+QX
e1O\/PFa[]6Y=f4:A[OQGA\&[T^T2U)cWg\U##268M_IUB+H(BIN3:f=\:@:2d_T
/0[_3&D?(g]U1X()\,/6BPICH,<QZ4M4ga+2;+00?Y6UMODS,\,+8)+R]76X7.@)
B@fdM5)7&c+0;HZ\6;W>K6aSfAgWYLHGZ@G\\3d\<[-5Ud^5^,5-4+U_?>/G3C,0
[\JHeTWL=aS:-/WZ\0WOaK/#=A)g@(<2XDX1cPYKDFKJ_^RG?7J_-ZS9Z.eC^XK@
J6D@[8Lc0Q<;M\VTF5_7dZP8fWSP8<4Y]eEI?/O0_F7),4E><ZPc(&SddJ82U3)B
,3,1Dg#1YT24)T^?\00UTa2(?33MbD[JR@+FW>__QV]NTO^DOJS)L0^@_-S<.^eN
T4R9BXO1fU+2M]^@&gRNU3UeG^JCc0HBZ_-_VM06+f27RI^X.9I?FU76.&^;S)Q#
fT1Z<7f=Z64)ffL[:R4CQIBQBU=QFP\5=O:^,X^aY52/4.Mg.7ZNcD>9N+d+9:B&
NV_)g#\UNS=[N\</QMc6QV7VP-=2[M#AT9:8EebD71@7;4e?SaI(cfaR)QR([JCI
5FV7,/gXQ-\R+\A@5<Q=SQ,17ZQ@RMLbF](?GQ5,]fI8&cbD=bLTggf8^.;_FMgQ
<:EIE=H6[I0cZa<Pa.B@2=bI>#:BWaDD;5_T^?ZM:gL:>9QV;6T@<7U.2NOE0(;?
FM_H58I@>NNID@T^,R,G_S9L3S)H6M-FG0BGB^^+LT:FF7,Ief8.M1J;FAV+R^@:
_,,T4&SFT=S.X;<C<72f?^\?3eLFNL>EEY0.IgW-fd8^dA6UYgQcW9g7]<).a\/H
J0W;T;5>S38f_#+]bW;WEY;DgP6??.W\4FPJA<:&6@E=TCK/4(S]^:QfS8_Q678S
QM<FYXI<)SZZ.d;Ug4[c+_J6T\-9dZbR^=dfHDYbM]9U?K_cY4_\Q=Qf9/LPZ7/+
M91ZA/UbgN+)4(2BOXEH+23U\?\S4;U,b22FI3AKMc:T7WS/2+8U0S7^;<X]7?2^
Z[PQL]aT2/7P902T;6OG(EC2?bF=,[C:5D/AHBH71]J\dGD^8)J=86PKYTd<E<<8
dg,0L/a.LZ1;.6I&SSXU<0DPKNIHK;OPf:<#&L#6;ATG_+f2<F][MC&_;?HMfLKF
eT?NVAP#KYR57L5J@PfB6af&2,EN+BPOWKB@&L,C180^L=71RTeS:(g.PYEcd/&K
72Y:#._W;#Na59G=9?.&5:1R0L-M-L1GCG(cQ@+5V<B8-SUB\Q1bGUB[>JYGM-fX
G/Xf(2KT7ZYUH66KG_6B#cg1(?V[+#I4=FcGIPd:8VV2-+@A8c]F:-a(-C4TQd-:
C:]ERVc0#(b5F3QZ[_&0YCg?bI9QUYG\0=K#INA;S2+(OH:1@)R/VbRIP(S4)3TL
4.H0&A?.1&KN,_4@XM(=bN/EBK5]ZL[FNMLdH#=AVS0aZSAGT;\cLTbDOFg;0F;X
,]VccUAD8,#WV_+8(5<a5LQG1E,59U6]Q_H3HY?MSOMO.&_fCPHdYNZ,L_<F:WHZ
@(?W\,09_6-RbEeWYNdRLH6f,7?<-.:KHZV-=51/f:gd]PTR(IcHM0\@X90CJ;8-
C2?AA1X4MaWeGaFPA#H[+@\g4NNS7@9gef(YK@3^2WO^].c;P0:MQ;/<e]63.8Q&
]V0_H4&V/@__Ic0;3@gTWMB5;c5>3DNA\D5MZ79)<M>=E7NU8QX0\+?P-B5cK]72
#c6G\H(FNcZU6ES^?I<#a3U(K\/@:X:T^FRUSY<b0G\bRZ_BMDSS^_)?[?A&7B-]
B=D(.1_X307Z<1<>J/T<)V-Fe(SJADF/,=CW&VQ4QSSCBg(N4f=2W17@G693L17V
4Y\BUZ11U4<+9<P[)+(IRSAH7S+<DO+C/_b:<V:8ga&RcWLR;e8c((;-CC@18A9\
O-5U5-CU8X:R[g\]b)G_\O+UA#873X^)PPYaWJ8REO&/9[,;:4f9@L==K@X6<\VY
E-P_Vf=0BL8#Qf4<6d)E8A7HW5c3f9Y._fUCbROUfJVU-&__S^/WJLT1M@ggHeC=
8bS@+:RND9SgRX^I(S?EfIeS7QVc>KI[bEC[,=746<cfITJD_WbWSN9c(c29:]G:
G:dP\9XHOQb<gXbXE3=C4HFPO;8&4HGHW5:<TP8TIc@U3DU1XVC)IKKR^3__5:Q)
L:AKQB41b(1LX??ZXBF]gfRS?R#DQYSUc>]C36#FQT,+bT7>S)g7g</.eA]P.2:Q
1_bb0YIEA@L0Ag:F,TY[JP4GX();5bcBOY\0-)252Q>e0fb=+-V35=0(LLV[9BYO
UR-W;?@f;2TT(+Q]-eQ,>^8;,KY,8gY)48/SNe1f?.MM5ZWOfJ/7M@Vf<&d[+CF)
MU?G5d+Ae7IP2L_E#1UUW::7fW+(^I@3^S_dd+VTT/F2[;/?74CC-e4_VTPffdI]
0-W<+cNZaAXXLdT&.8>]M>@PDdbJS&PM@2<(7]?e=98T-RFA)LXS^>QX^72Hf&Pc
RX1]6KQ]IK9G1D=.^g5[6TGEHJF(c#2^>1PYP:(4E=,^3TIJ87)eM2\bYP2@2,We
>P78JA-#Ha(&;]_bVH.L54\,GN\:V&gW+<V0cJS<VbS;-G((cQG(</NIaRQ?agcE
=BWSLSP#GQ?V5ae@9Y6@GXF[8-<E=W+WW9cg>2MZf3+gS320bA;EQ.Y+(L<=DRC+
Ia.]1^cOE1TT)+BOaK&9XD5fO#SJdK2g,TgXKSDB/c>5F7FVX0\SeN;a#)Q<gD,I
Z7YM=RT0GD\;#9Ze-[TJ?aBD.gf^]Q_fD,a>TRR6WfT7?>6(ePB2Ue(7]/dQ#P=>
F.LfD:S8C9P43X<eA@HME#?7EdUJ^?[M@-H;:KBP^8UA>LE1^d7K[1>b@bZ_9bHA
Z1cK8c;T;.&c[78/>D:,V<8b,XE1I0623-:DV,N6X&+&gTg]4\_WA=.aA)M1+=)M
(3/K:JVS8OTP?5/MfKMRTY:)fS=4e192/,FFc?LXGC/8(Z/K3f0YB,g>/OLd_&1J
\A4Qf&H^RZDe6A#--K.X=Ag))M)U/,7.+&#@c<.-)9RaUe:>M:aXH^(^]KHFW4&Z
H5XPDJ\1U0gUZ6I0C[P8)47K,QcL/.4MV?36=KUSQ48fR?HM;>9[C;:f[&\c.J]I
3#R55A+LKPJYgXE+Z8Z69fJeJ_MEfA[^>/N@@gHA]1/][1]c.<aKg4LA^++^[NOU
CF3^b(,QI1N\4DI>8G:&F7dP)ILL47RB3=f6R+K2NB>5FGP>fNY--I[-2ZT&Gg<9
WfZSFY<DDM0<@R.ge[1CQ-N6ffA>+a)?6]=#]J5HSY\__H2R]CHaH=X=1JF+GA&e
]P>C.fOH[_2/Db@TE9+CCVCC+f1H@)1Na[g(9<@<VFEI?Gb+6<>P_Q;M,.d0_/RY
c1?;Z9g28ER0-a/f\+PJ6&-[K/)GdD>DHG),B;gT:&0<DRG[:7KRVGKC5-Qe(-4J
CV?\6U/<V\G;].LEUC9,&P8PXT=6\Y5J[I<6V)FE-#8+AZHY]8e4LecUI[Y7Y4BB
U;Z3@Yd@ZUcgAO)[f[X=BE@6(0ba:a:g4PI6:VF5;4[[7A=IM<Rf\(U@><J7cX(d
H9:Dd4WP:+4R^QBS5I,FGRe0Q#&61NBN4>[Y@=:JK8W?P+1Y-5E<DV=)Y9_)348A
a,.L,^9JW4_]T8SV4W[SE/I&.NMDc?G\ZANbXRGHZFSS1Uc_7U7D@Q.H]bDOT.g&
VQ2>>b:-H)Q<:>MNZ=U:QQQX@D-0126K_P()J8c7_\+MX7XgYEb7f]&NXfV.<GAR
]K]?3FG>Db^Qe:A0K76MNT6dZ^N+CG/V:,KaGbfEaS3[=RUP08(6eB]a\-&L#_d0
Bc2=,c?>6e6a0e&T(G38dRKd\.fSaOYR5(bSKGL;.@P-fW.D75.8f,B9U_:U2H(G
9B^]=3VY\--BNTWS[]de5_a-b>GDL5e]U7?d@-RC&.gGBa7VU9S1Y+B>KM5F@^KX
@+_PfWX/97Ga[L;KQB>@Ia]b8@@OaH7UR.UL@d<Q4cVOF6/P0H&8.:M-9Z12RL+M
^;7[P>FY1bNa&SgNB3D>B>PMJ.A&+GM3bSX-7/9C9e#P>#6K>be6.>#X3UR^HHWK
5P_7S1PdL<+O-ce0fg2+3EO6.,=-UX<0S9a,V.4=I/bP[?B,LO[1U+V\>9/7RYHb
<:]+YJ_fWI9L9Q(f/8a0+UW;PPW4-bT)<a@SC.H,<<^/S.gH?d?0d@,?.gYS6WT5
QRFa(;9FA^@;[,-8EdQWM=6SVDa/@9>JgD?@D&DX&#P6ZKA,5N7He1dPIW_=+E=,
^&I<1M@FYNQL6f&STf2,990Nc[@EG.bB2SGgSN0.KWHad]JbEN@Mc5M\Vbb[O+U/
\XANW8+9OF+SU5+fDB@1VCQCJfg=6)V[;+JdePU;.BPC)KCTC>XPN(Xf^T8XQ:Y\
0Y&\EW@,H3[MN2XYETH^d>+aKKYZ?2JQ-S:-@d7_eB^--FT>/1K&^^@ad/TN]Q,8
:WRJCX73c])/,_C@D:DEJAVbf=ZO?e5:2EH@D.9e3bC8<C@8_1-MRD.<dY2b?PDB
ZDcbfANM[#74JU2DWUd4M:K/K5bS(G\M<e:KY=))Q)_Zf;:\U+1=\CLUMUa#bB=S
8UDcHe-TCIHY=A16[EEB61JUSWcC^YX5J@6^ZcTI/P,/#\2W6#ACe446JTKUI=Y[
A.=O4XI]X+39gX0a&/M6:0E07f12HfHAV?QU-J0SHR@2?P1QFcK5DD\2G??_J1Yc
A)4E5QNfPN>dNcL6aBD-(fA-P<Q0<c9R8C-H+>KV?/G]3A@d^5WLPFOH-TPe9FXB
ac3-c7e+YUbN==J(IA&eP06A86IG9CbEUGN.Y]Q79.\:HXbU+bYLLIGZJV:+CN8@
_1U1IRY2X^;IH;,5Z0ebX-(@@\#E#fW#&23:G0Eb\)@OTRE/_[/(G4<55,04>ND9
N&>K:5Y01C99=Ba\FQ@K[6)Lf7<WI3:fMIPf\<&9>B5K+a:_>c@QYUR;YYD8[M1&
VE)O8R7gMOd?MOWAA[N^1@.aIJeD)MX4QG:bB+7M\J93f56.<Q8^J7c2U.;W7PdG
G\KIQd4HA9=1IY5WSD=J\T^GK/e;A-MfL#d\JA\CAM[KeI+O9XJc<B<&C[Bc2A:3
-UJMZT3O2?DaZ7H6-afPR8I(Y\3=&T(;#099>fYK],4TW0D1@N4WZRM^[D9a@+1-
caT>eU:/eR&=>37[0.,/FZSQ9?N.8eU)^+ZL2@,GU+F+DDg)G91g8CZ;ED5EUS5(
gHL@);+;]fUQZ1)WT&4J43-XXK+3EFHaQ__:S9.fe,A+H$
`endprotected


`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
