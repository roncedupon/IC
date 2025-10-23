
`ifndef GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25UM/MX25LM device family in DDR mode.
 */
class svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
  /** This is a handler to the SPI mode reg config object */
  svt_spi_mem_mode_register_configuration mode_register_cfg;
`endif

  /**
   * Initial value for all the timings which indicates that parameter was not
   * loaded from the catalog
   */
  real initial_time = -5000; // must be smallest then all timing

  /**
   * Minimum Clock high pulse width durtaion.
   */ 
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns = initial_time;

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_OCTAL_Read_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * Data in Setup time
   */
  real tDVCH_ns[];

  /**
   * Data in Hold time
   */
  real tCHDX_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tSLCH_ns = initial_time;

  /**
   * CS# Not Active Hold time
   */ 
  real tCHSL_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCHSH_ns = initial_time;

  /**
   * CS# Not Active Setup time
   */ 
  real tSHCH_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tSHQZ_ns = initial_time;

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns     = initial_time;

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns = initial_time;

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns = initial_time;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  `ifndef SVT_SVDOC_CC
    /**
     * A helper class that can generate random values for non-integral properties
     * 
     * @verification_attr
     */
    svt_randomize_assistant rand_assist;
  `endif

  ///** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Randomize tW timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the configuration settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = "svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
 
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to print only protocol kind relevant fields
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function void do_print(`SVT_XVM(printer) printer);
`else  
  /**
   * User extendable hook which is called immediately after svt_shorthand_psdisplay().
   * This is extended by this class to print only protocol kind relevant fields
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif 

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

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

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
 
  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
OTA-ZM(8:M/BJfTHbcf^W.7#T:e>1=4DD[J8aU^6==c8C;O.AaCQ()[G[9VDP0\T
073cg=#d5I?;^/-8LgPVQg&&\U,J9(#+W9C1@]Q;;,@VL:G4EAbKZgf/EJ01TXFD
/c,/375S-@QO6KXO,O]TF__fSR>_X-:0CfZ\W#bS6IKRX7G]J)->4TP3?d09X\B8
R/bS;GgSggZ6-HE\RD\eOA2bT/2aDRcB34M#_47bHKY]4&K&G]DdWTE9MZ7P:Y6M
W.&1A:UBI_I7/Z;]:1CER,\^23E:ICJ.;\UgO_Y&1^W\gTX0(P68eW1&6IW1J:T-
be>&GFD^d#T66#(d>4)55)ZYSHPM,^?O8&R=.Ec4YY/;gG_PZg6bde(/b(DPL9,Q
cRA4JH=-CcP.WLT^0(KFK&7<ccRE&(U=9MgMf4E>BTe.H@,gQN9;4SaJ:>:3^BE.
XF6Q/B;QP)_W9Z5@f-=;b,)<-SHf3M0H]M@V=?PIW>_7FKAZP(+EVO&3(X8HEb3>
;E7V=:GW\;>QAc1LJ2NBN]6\LVXX16\D@V6eZ3/N8)<4)?[.R/\6F([?8LQ;_NSb
2PRc6SEG^Y31@+W1d6E(FGF7G^T;,Gbb.O3Wc.gC\d;YfT)0Q(2-]Q]1bgUZa<g]
K0^Q/7#-6dAP4J=8+8D:@#A&X;b.gK#cGA?fRI\\_<^5.0gP,T/6@gTXQEA8gg3D
&==I_=f+6QWPK/.,15IN3]VbcY:1DTdG@GF74Q#;T0,90^.Fb[6H@V7OQbOG:Z:.
>81\R0;#VS&G[<6?Z,U;P^5M9^5KUc3/=M0BV?E?F@c?I7I_>0d/;QaI83A/_d]fU$
`endprotected


//vcs_vip_protect
`protected
42+3)cU[,Xb?I(b5:67#&J3VZ@KJe3==BRN+B.V_eYe5Q4HBbcg<)([EIW)S;PK\
d;6@_dIF/TS5[):=251e3d([?QA.W@#^cB#CT1Nd7IY\g0+6g._TU,>AS92EM5M3
VQIC?@[3RbdM0cWG4/4.-?57Ve69>U1HDP@+g[=K(DL8Rb^X[/@[d>=+.db<K:9@
)M_H,Fd[NTEa3TX?)B6#POdI6e-\D_>\-1G8AB25\;_(+1)\4<cWA391O16E&C[7
H/>A&P5M.9P?6dPO\<KK1:G?[aS6@0AVJ^8=Vc_(]D>BD]d;gC9G][gLV&=AbfOM
>ND[8,=^HAV8;XGE)MIQBO?K[\G<Q=aWSY?aUS8[56/Ag2ZaJb<C&a[,e8<)\Ld>
[7ENQ/>@&^_#4c0gKJdLe\a0]<9L\FJW_dc@7EPNNbPZ7c\>eC:TDL=&fPf:(B=)
_gf,G7NZX=cQDd,@0O/</.,9M2K?TX@?M5.a6^V1@6E4HBH1:Ie/.3V\2S21BIg\
&7Y:EB3_d:WL\LcQF_)&MS6(MX6;M)G.H:5+7b2[Y\P0AXV4XAF/3-Pd&<A8ZPM\
AJNM@M<HB[SbLaYHAL@bEGUUQ\S-E=.dJS^:>YgV3&BOY<TWfQ(H)T]8Q(g5XV[D
d&)@4#3U:Qg>IG-a_P+0]+X=24#ZR(>=T^GI_>[6C/P4X(._#<2#ZYV8e7_UEf8H
\bVPFH)OV;NZeBZHCGTMe=2V^Q0,?J-YgXWYM)O1,&P:GG.MWH.<V?M>I<3B38IC
EAfL]=gW,;?<a-?\[K[b(N_HeSeB_-<680Q8P_N,ERfO5(P+IcY5/9/<f70TF,H<
_YJ@;dMc<,fAH>^-45EPO5_/5\WGW/=9PIL16.b._&5G/1K0#;75.C2Mf;f12[1#
Z1IBEI>1TF1>K8RE7a?JQEVDIT<+N.g=T7&BH36H;@F1V.?M&-N7N#A]DP7NYbP<
\+fOX79O:LP459aW6;;JaM-/)Cf#D]EFGe9DVQP#&/&#N_b8LbU:1S.7Xc(G6_4K
L65f.J@MSU&?J^C26ded(fDHRdD2S>AMO]_H;JW=>MbY6S@_A\M]d&=PE/fJ^9?E
2HN6E0\OcI[@9.)+LdD@fGH(3.3eND+G&9S#Ze#g;ML?HO9N6\LJ],U;ZMK)fIA8
;_aLWF/WY/GC]?OJbf&TP#Y<FZ,LRM_cbbVa<B.5V/ISbDb^c?EW^2VZ__-FE==B
0,F<UUV(N14c-4gCOWD92]I.;MB)@bZQ_66F.S5=M59TTZD4QBU.J2Dd_SL.V7Hb
.T[eAXENAcA&F#XSbF5#,^4YYDe,c@-=AbU1O,LW21.]e(F.4SB-E7<-M5X=ccaU
SK[P7GJ^Y>#).@)MX\eO81)TR9eZU/>3F]eQRZ.+OEXfP3b2X_bZK797dY?[aBAF
e\Ud4b<++cAFc@+]2D@L0>XH.8MH@PN&;^dN^54I1Ef5a?=-CU/b&e50)X(P8eTT
dSf;WUaQ5AS&WaQ#8^K<.0D[THfW8U3eNa:&(]9V8AZBZe9f6C_F6]4Q53ZSF<\B
^YQ/?][Z/gP,1L<&,131f:BcM:gW1I5=BH0XR.[;&_1f&^d45aMLSMbMA#,MfV4)
N7J=U4dI&-0,LZ)#NZ^52c]RW]Xf3.@TMB=4\BGP6H360F6f,APVY37TAfa[#G-H
;3a-ZF?RU^;[@5C?fAS89\J7[#fR#;938@J;&55H?DQ@SB\29U?.]_TG?@gF)3^Q
K>?E1>/>E&6T2@.>GF,e8#Ae)D1P.>Y5N<8R;QIRDZWc^(O.SFFWUE.V>ec2WMR8
&78W9e5IA\=;RR7V_aW=N,S&,3_2UTfW-06gZVD(?:UM@cJg5I)-5dJ9dbeaVeE2
VGU7.(A<PV#82,[F)TV]g^V(3,b/1c2[9&?3OIL^c,\,\[6TU=O/7)[(@LD+Pe/J
[a=<DNJZE,aWPgH=B(YLE/XS>;G9U:Rd[Uf4&&c5b3>Y]QP74>TALIBRZAf85E[3
e0L3YA=?BWM6<M-8912+)eG;AU.>FBVI^d\aN?L&Lc)9?Y-g#F?;UMB&W.OQ&,0R
34X84aFa6]]@P[d)>aO(\TO/SMbB.[(##O;eP6-QK>G0B5UFBU?F(DAKZSAM@]TI
.NO2^&;V.gZB5N;aOf/g5bR2<NI3(QX5g&b658IGUT,_>Hg/2\4b#ETI.4)S@WWB
\.e8c9LfK,3.g.]6N^MT,Z3#LFec5U-OLH[^LKKE)&:]?c1VGMIJ@IAC@&X<:M+A
N\U^aJQ0+<71?H2>T4Q@XB\bWM_8D2HdP=B,G:I<f?3f0J&6\PQ/5+f0+_TfMf4U
,.RW,3T,04,0cB-(<:^12:?fg:VP9>[UbK&VcG#O#7#M&f(_=FdTZJ=-7?BZY(4.
UQ)PXdeC:dX@G<IK[NdYV^C77\PJ.NP[d4EP39SP0WARfK48JbK;8_LG]<5b>G;Z
&f97b]&OdeG[8#<=EAcdTa]f3Ha+gcBAa2QF]Y[OB;,?dJMb;:JJcJ=-fR3O[\]<
+-]A;4Bb;34QT[0(GXQ\XdfgfH+O^N&U,/S:BA-+eeMb/9>(3B5UW<-\RG@dgRgG
9-S56VALP,5SAJcgHE/3@O\&DC>/e#RL<_4.P)\H/(W4+HXZPg&]ISI(>A;\\N6/
\bIVC3^054ePE)YgWId#0^MC3d[&F-g04(UB\J-_2X_]C^8LF\;QE#YX#56]Mb.]
cG]L]?99,5+/a_9&@5bYS)?@TV>IbP892(WZ;RAOCD^F&,(2/B3<SOcDU.=K^eAO
]8DU_3Oc\D8(3Zc,@4fR^X:R6Y)/IaNb+TZD5XPQf\5MCRabGe4LBS5WLKE/7/HX
-=VPK<-(U25Je[)-KC2)b<0LV@[g)#dE(LNaGKYdJ<2XCY+5E_fL=[A<,g=1Sf/b
OGX.=b3:?XUV[Z,R3F7N,Da+B]VPTE(5<J7R[A2\MEE/J8A[G#RWc;dG+Z:^fL7N
8ACG3]&J;1Lc[/#.YAUAV=bd7Xf?S30>.M]&_ae5L998N1XHL?F<(FEQ_FVWU6@A
H5H15)+Z-=#+Y]Q_TB@(Pe;4_@gFEBQeC6eB>=)HKFN?ZIKVA<D#:L=fOgC]X(.8
^^ZBQA:L=F[64e8WE_76c7^^-UdQU\K=g)#@:N&(KTYg&,C>c<2)BP#E:HgZCURG
092?G<GIgOWWCA?[CMC:\g=K9SbSaE]J:8+V=LOVA0DL8_TPWb,@L/B4@U&4NK6E
4NCKE0>[-CJS,F^_.@D)fce#5,&ND655>)32#1)Kgf4@F(gT5S^2I=9VX]KDD=WF
ERcITT4&QL+L6[?8/AH+ES])gVX^eKTHGP0#=DcEcT2;ZN6[<Z1.E6>0L;R4<VZ2
,g&UCN5P6b6AAdFAU9\5;+#/&2,M,N;@J[0N/?d#NcA\R8ZR7F)OZ=Da;S?^_>OC
L^H@7/(13;92HIC249QLUAN=PD:XR?f/?:)\PA<>+;.W2H/:5[:3;H0?2\/PL&#W
S@+WK6,I9@>#SX),DJ2\#H-SCI8,0>_0J9B1^>]Qa/7g9H/]_SSIC6bSQ9K6S:>6
C4NaO)&VJC<Tg&H8eGY?ReC8Pg:H+C@8Pc:[B_,f]=gXVb)XM7[cNaOEK,Y_PW-3
a5e&CN2JLaD:>.Q[)4HKS0D?^_U#c9dD69HB\WH)S#,/WHUdf?C4G0:e;T338U/]
b/9N_ULMK)@-F@<2N\)_^<;E],\;>UaDNJUPX83<T3XK\g_F]GAdgQ>7Nd9bQ?0:
+,RSJ#T=g&?05ZeV\BODIF.V.1]9-NP^ZP:S61Ic30fG;HYY&;.[S+8KL]NGNcM]
]dQVFeJ=aaGL0GfHSeC[Qc1XVgZ2XY2g=,9E]T@NTf\;^US+TeCUM&<I[PdXVNg0
MHIWH,^?g\dJa3N\@.J@>XTG3c^>[+N:L2Wc,(_N5V_6Kg_;gY,?F4F4]cDU(OUI
X\-OK[RY=^?R/V1g>#TDN9bB#=W(8R7,f>AJ,J=;MES,PGcAY/^6fQOc:UGFNNc?
:Y3VJ?DcH>D;8&Ha4>]]+V.=E4,EF_?@\4(]\&_R-Fb_@c@TT/H)c[.#Ja]g[/]d
F.NEHgf=U]geX(/BggS8U+>N7V-@S/#WEBfB>+?-1UUF31PLU#T?;(f[?YNXe@Q=
W_7c/2PR9L4QO8RE6/QY=WO^[8,[]_#TCfC?aD(S,-0^1[CPIPGGGVGBO5:F(;[A
(=fWI?MXb.&,[7]ST7>FcYe56P\A-dWf5\<A^L3H4ZP0,3F^9KYYTe1)23OLcBGB
3X+^A7][EBJ==\5]1O1<1BN<WKE3>N+2A?7CabKT2Db^@V.]@.<bHY^<&8F^6HR/
?0]8Eb0#WcB_eP&fFH5f+(a,b\>Ua2:_;J3]^=U\/:L)3:AWMeXB)-XF(VfGOS=^
34;J5EfS:Ieb0cDFV+NSBD2\Z]F5-_\7e2;]Sa;:8A8&7^]?=&0@B44@Db8UKLbW
24&J]VL47ZJO@4WR?J-@/PW4eOC@KRDbFFJA>TS\V?[BD?639,>UH+W^e\4<KGfW
A81b7dLD&11^/A64]X2DZ)O06:1YO=XP;?ZCZLYG9gTGHG83:>YG9Yg,7U<WPY?=
VGCQ^1(dT9M9<&+BI#W1W<2]0:EW.g=.H4@]2LF9>MXEMb6Z@3/1I14e<ZafZ2cD
VBA/^&GYXIFa>DS?D8?MN(Bd:Y6,FG^b]5FeJc:A1;)/Z_+AAOR)[J]IK0RX3738
Lg+<Id&TCHK9#c&;:+#WBcY3>Md;6)JP7bW(R>0-UKV=7gN-AO+G)>+72U_96/@U
NXDX0[XJ9aOI?e6Gg&d285+fD@@7_,IcO2LAOQ5<#L\&6_bTR&,P5QBMA5IPSVQ^
XFZ^+a#G0@QT-D40<VQ308/UII8L9F#V+6^XAK20c>g\]0BEfRI88^g0CGN-H/#<
9F?V;)56Q.QFOFN<ILVPQ/:dc?Cee^V4+=P+VL]C._/B=^A<#B_UY_SGde@+#>R9
Q8ZUWW90\dZ2\5c+RGcN^M^bdf,E;=VD:^N#Y(VFOSc]JWe(7Qgd:]OAa::3;?0(
[16[SD.DH:;]GeO72D8MdA6<+M@RZ=Y1g57JgGa30YfBcR3:6\\.5V@e?11_F#N^
4H+&#3Wca7?A(T?NN.E7-_WD(U4<0X<AS#G=P1cagbU.DK)aP)gZ4WY\Hd.#6ZAL
2J>W?>D9NM+J/<7_3_IE/8&GD_OAT5-F96=f,(:-)F(K0US5e<Z.3O5Y<Z0&_HG/
O9<3P+2e6AJ_#E9R&]-O>N;e_T8]Jd+K]MFd]I6,V_aUY5H)d+II]d]2\Q7-ZIJZ
ZX;JeNbA]JTdf<FD0fTC[V7J_:Ye(FMF18-VL;J>FM#0\00O&3e+>fY)+)FeIU>2
FC/6;Ca02^^BV/>d^-QE^KOI.c_MN:RNWEb8<C##e_[_&<f_VfEL>,a:NN:Q((AX
S2TZSgEYY53LUQZ]>f//WY[1=]b(^[b_2fXg5G?2&L92bA(/BBK7^7FH;&0M2B@0
YF#(&<\)ca7a?GA)g62c=?45LSMe-bV9f^K5EG3OUA,FL/-UC[FH&MLBeS,3294N
PXXNKCbE;cW[;9S.A8[OOUWW[+L4;ZZ(>QM0CPE8JYI.7_7;0J&I1HW^>H2#CbV]
9LaWAL)MSWS)-cQ]^J;+,g1P#[DZ]W2V1,]:<3WFg<e^f24LU2gaN@GcLK,=@[c[
P/Z[\PPU>YWY/f-U#B&@J+0b>fL>>Hg1-EI/H4210I,G:1gS64S^.a1/\\<GS2d/
/A((bFQ+]=Ob4GE;Bd1K0,G.G3Z=a<)VCc[Q(cgdI-9Q(_G<+7QTCPP44JCWP?SZ
9)[BH+;-WFQeOPU<aJ_/O^fB(W28UW;+YTH.Eg+F#eR;-/^88J?,(4ZKNbe8DXNI
RIOUM;NR#/H(Y)M\NV05HIA2YR?LXc(P^_gc,gG3<fC@::#3NQ@gd8Ma24EW=]);
_dBRC\Q=^2+J1bdVGGY?S#PWE)eMgPCQFS&VH^R+3,GA=-G>]26E[4UbWTUc\9QO
aeBJ&gJd&=2A/BMK[IA#^.BY\X8[gSTMETX9ScX?R7@M(/gKL8=d#?J_@PE+]fM9
JJ;YPLGccO?6L0=e5@CH>J--:T&?+BK&^GBHE7P42UYd:L,J-RU>W@>\(81fN\HL
L/PC-aWAJLdH8R.(-ZPA=4Z(QJfd+bN@g+Fa7=FcVI87LCGdQ2\(ABZ?N/47,gX8
A,(-):EHSU<+9QXE3VB>K]3?F0X,O.H[U9QWM=MIZ6;VGD>XX);R&^(,Y0XVg.NE
ac=-CeZI<;5)0-Zdfd\@L.G6IA&4OX<4OQ)>3H=65/6/0#e.b;\JABbHWFAKH0<]
VXUb.ZJ5;/M4bIQ:eOO4>;YfM#OeU70Q<8N52I0P_U19N:QD=g^5Rcd=Z:^IV([-
aK2];M\d#KNE79[d7aG?:,;(dYWd3_ST#0-MTZ;/;.?0O4EaA06Y[Zd/>Gd-f23-
]58:JT(QgR3>@XB;9J31MW1PRUaYb.]0FPIC/1OF-OG;8\:C?8AY8\fUO@N8G)T=
^=M6EE:^F\7?QU\?5d0\5G7B[PNc./c/4[G,AeLf8NP3aP.DT]\Pd)LX?VYe,US7
6C&WE:(T&V4Y(28\e(QY33,=g3U.Ieg<Z8<aNO^Q5R-K92B0Q[VgIaM:-DfcCCHe
\K_4;&>=VB)]Z]MJ[+G2)[g&1]Ga-XG01YPb<Lee^1_MS+b,EdAQK1>JN.:L[P3#
;<YJ=\W2FTeJ/\d1cAaV\eNVXHbW_b5Yc),=IbUVQ9&6D(UX>Gbg>@L3FL-P01/Y
)Q5f>1QU.X[e-@:&[23V[:\&EXONRV7AQWV1dHB05HK0<4B,[P9-+[2+&DAZ3B#]
MK).G3_9@3FF>,Ve\B(LXG)(@2)gW/ZTB#ZUS-#I3J2;P=(IV4f.\6/FFZ3G72N/
#CdfG6G-6H&NQ?4SE@O0O+<PFH3X;d/Jc?=0#aKI#)[H<G4)6@g+Na,5ID^/\RQ,
\]5<\AfegS;A;A>-C.Q1S4P,MAX<aCCIY=GK?2gQ3[HOE;VPPHd2;RA(ce<7#3;4
[8[-7^YJDTD^?N4IE\feeaf1/4U)V^<0/_P8LY+W(M_+?2=9IGS7?6fcLPDJ&=[]
JP&BaU,?IMdOcZ<dJcMY\:8\5\(6NcQO8R;(c,f28<PGLV3WRUHRFc.6<e(Z:Ac,
E[K61IfL=G.cUc#g-e^/c,:T/^H>,+#2DN^&],b@M1?A[F4bOQ]2^?a5^#KdMg;#
e[c1.Xf0<PUe1:0=74];E[;K9E8]QH]O_Y3^eOA55@?F03(S_Oa;G+[DcH&;55--
+)[/&bN:/L[H\R6e_@;DG?ae(2#QCC;<&WCfE\\[.Ef^RbNVgRL(9:=Y3.;81IaO
:)9MAU9P9>f>;/T>W>-E??\BMY7/Kf4C4J8f[[(B]EGIT:aee=gc6U4QD.WSCGf-
gC3;(PVF@.L@dXNcKaKKCT#=6[SbBWON?D1[1YPbJB&DM31US4(W,;S<Z1>G-g(Z
Od3.2/VgSD&[JGfAE3KGZRY5<dfBAOHCLM(9@bcdW??eC(3A?B<<E0_USIST_QOQ
+@8/)#.?92(IZB@09gCU9]d=]A9+]a5PPH/Sc8Y\((?U5/e7K:5fHA-Z4MMWGT+)
@g\Z:>@S-,B-&74<V,8aZ\^)(&18&@eUg.IF>R-=aQY<;(BW<+c3P[.5KM\VgdB?
.X/C_6F_DcX5b0eCL2-.G>_><3b,(/4F)-O:Te3KX)9]DVH##0E9\QUG:KHJ_7Cg
c/X_3bGOR:EbC=M\Q[D(<V4?@Vc;WL:1/MN+0T>OL2PB19B>5>YV&7g9\<KRCLeU
Xa#3H1Q2Q]N66eX9X&e\XNEII-55D1V]:6858Y^P5:dYBKOWcd+#>\0K#XOAdRXR
B8eVU:?P^bTI2Ne)HR&ODI0./=\M4d]R30ec,Z@_RI2gQ,=IJFN7H&I[V4f77XX-
OHfRPK4#bDD/Q@B[V+d<V/[6e]7SN]2L=AD;Y-_]Z5B_XN1:R2IR[X6^@a;@Z0[J
8ZJR+a8+16^^5b->7/HGLO,#4d=()Z(JgLTWTa1XFFJBXG.62YM;.b:SMd5+6))F
P,=R[\\We;Ff)^eHM3=-PKS3g?R-@]@RAMWF,6a4cW5J+d4e9b7FAXJ4U<CSV:Be
YF47&Rb:Pbe9Fc,dG>IObI/AMc9.R>dQ>EMASCJFF(ccGOR7Q@EgFcBIJDGKFPC@
S80QEdV?86VcM)W=XZBODJ+P=DE432KU#_DQG^QXF<7S=K0X+g/_T3@-A2,3I47H
60A(4aXL<3&PF>NMBV\UUTXP/_IA>_@0Y\V:^ZAT5B4\;#@)f&T8_YB=VSB44fB7
LKEQ=;GPUM0]IWe79KgGYc.OG:Me(e]c:eRC9c+LYCNCd7N/FPb(cUUWf>Yd.dGH
=ec^,EF24W\ID1TG9]SDR^L9+=#1S/\1fU#PF34EH=GS<H&NV>Y)PZH&&f:]0[7d
F(=N>N@,\B(V]YGW^P?AMOTeD9;cVW0A.)DCdB&fYK)N/@U2-WTg@DMI-1R3(cb9
UR-fgfHH^aIPJ^-PbY&JO7c3V2UQ2:&(APWcHJA[Z54UDZa]A.Y(;I:@14I)+bX\
9bH>OF6O(0CS\e,I>0dV6(1#.?4&_[[9e,O\H=ee<_6JbT.@Z.2dC?da#K&:OBDO
fV6Je;&PafKDZ9TbX;GCMZ&b.Z<P4TU^N-dBa_9R6@>._/0Y9/5;.Kf&]c.C1,7:
^H]?aAK\7_4@F.P?-e,=bDK159X)HS7R#G:4a]]Z@g29[.-_;RA@WY8OLD8c37gI
L15\YFJEb6+1N[2@@-JUBOY:C-?U7SU(D_1C37,;H14=aHHS7<(8@TW@f-,<;a=^
&:7VJ3CZ7Qb\,_S?G9.T#8deI).b6=J,e<W9JFO4M:;^BBecA-C-CL@4==c:A6g6
\LPb+80D4[K5FH2bC6eBd;[GU#8Y.-<GX&Q,eB]:?.b,TR6^)9X;_;:@ULFIHYIB
S3B\V=D?Q/3&>L8dK1Ig@,cfJ+dfYU/Fa/3\\<RZT)IJ;^bPZDPa&VAI8&cMJNTD
T@]b\HQR\a\R/053I;d;WUY2J:L;<@f:,\EA^e&BgNX58dV/+#ED8/<M9EU9K>UL
<UF?XMHG&2(?J=;NfB;,^8dPbEdX#cTeH-<,+)#E8R.cDX>BA;YOL3JCO;J_:D@d
,^U20@13Q##IABcc.)[_LM2:g<2D)U=2Tf.e6[7SY:Eg.+[4T>bFN&&KJC_-LV4:
&?f0R9ZFN9E/AY\@NM(2[/AG3OgScgRd+9G3KMABY+NU=M-FMIDI<bCG^HU=B7S7
<+bYPX,BWB6(.-e]dRD+f&,THHB_282RK;g[dUK6P)4_O98\Ob#HfSfgWI-2BCbP
O>YD+,gU>>C1Y4UXKO+0J^e)Q-])AC4G:_;SOO-GCURIQ2HAH#?G\UcC&,S>+b+8
HNZ<_abM\/]UIM\C0&^E[Ga\,M9V:&YT;\a>(.[(AA(-.11QUYH(1<dTGeDYBER@
2cKYb#eX<SGX\+^2?)+1IYfZ[]51B3PPRWICcXEO+I@,YdY@@&0-N7gH#9LVHc2O
<Xe]FP4^GMKW@EK7#eUX9gebZ5UBGa4:>C&Og^(Vd<?8EB<=MNVeJRa\QIeQVEeW
T3>>LGM=9IPV@NE)GCd#.MQFa96)#NZPPGK6(IeB/3cI+,6RT6d\]eUJ2>1[bC,Q
C3H5RAQ?M;?JePCW_eZF^KCC+W^/+[O4=dM_EfT5D[=:OTW>4=#M&IU^2>G3B[VN
)Q<_#dSZT[EJ,a,RH/9S##WON(0EAFW3S6@>UPL\(.#FPV6HQaQ]7-B[6.OfURb5
;O1&Rd6:UAG^C.DB\,TbQ_5UL3-Z&)B/OKDP\/8P>)U[cUQ[DED(O@ePX7TI^=B?
CG[P(LG>X#QV<<6;&99L+ab<f(R)[L1;<QQe5FNGPJ6P24HVF#,+]UJA2MS=Q8Y.
&bff\BGM9(8FA]#[SHaQc\RH8MJ</H;B>4e;cFP]@58QSe?MBdSJC2@G[.M4c34+
]\(#:I6+FGFfT2\)ZK]5=[-\Ec9P\AM9BCJX^Q5M3YcVE>P@6\+TP<#60,[gSI.X
.)-PBST0gNGQKKV?01(N9J_3)_;JNfDV6a#MSCFV547VCWP7=-_[?KLNa45(F:1J
bY;^gB_(#M,RG4GEZ06cF89IBL1dLSf+CL<DQ5=SJ,=).W5@MFa_C\><P9AaO+.g
.[JK73\SRda[-eI3><]Mg)@G8eEOJM,(M3gD5M;[Jb.WIIH:6PVTN;PFQO5H2](J
2f=;@^RB3Sd=Z,6EOI&(1f#^1VQccS891RR\f<S[[<HLID\e3H>f#cR,YUVd];c>
gTAc9g#TDeO0735f[U19B9072b8S>_ff\-]5B8L8M3+;R?C(UP?S7X;V6^.c@9Q2
g(L=I_#;(+F^(Jf(^g.cZI_,D&.WN+C\eIX(52G]ZJ-+U(.9SFTC?P^9O^aK+?[1
B+?gTWZ/R<IHNgZCTUH;M[9eD\g@&2(U[ZP6aCF^?7PJ>TZ(<Jbb1;HNBS4AJG7L
.29\_V_2KB3\]309MLKH\-g09NKXdLLEdOSU+.K#?LYM)HYYSOB]2;BK,<9/6e.Q
7>YEB</)\(-AM)9:,NX+0K]&3;[R6>Kc2T;G#Xg4^eXH9d6XRCT9IX/:QEOZC(g/
dGU+I3<e43eHA\aTHAT0G6IcERW&PXBbQMVF2&JaM377L&6OV2;4KI)2_#EUDPZ6
\NXV\7@D9QM_e^+02Vdb6PM159-SP:R[:RPaTGO\J6II#/A-ZTfRbN-7]7@E/5A0
4,NOD#2GR79Ld-7G3Ve\fI<GMf^JgBF[.VdG/1RMA#0d^=ZbBIY(e9eNIa0@M),d
I+e6^EE7g(<^LAB3>F@Rcd6dX1/G.<6N3][9d7&TYB-)C,[>aDd/eM_Xf/:=R_]g
C;F?3X61dX:T913ecC.e2,../1<YA?@^=ZS5REHPc9;2OOE14Mf@-)<24gG692:6
E@;W2ACg1MM;I#.aOF.DE.,&A>=8[Lf2JYSPcO9IMdf6/8NHbYOJD0)[F_b/dF-b
PQ,8O@NSI>@A+ac0e_bS1E^Tf7c,8P<>V&>0.\/J69J?+e4+b_5/A5.dP]@HP5YR
1KKd4B7ZJc\f4@+1BHZ6MZ-NA.M,G&\dZHL7E24KdC<7S0[d9C9D(bB_Y5/4DII8
32]c8C=31Y?@C5MM^9=[4c2K0686/RbI+0#[Q](&GT>@6)),<a?<J_&8P7_3e1>J
QcPF10eMc2AALUCC<5W[>&e,&F<G:TQE?K7_.@0/[LJ8X_^43PEVYMQc[A&\&b2_
gF^_J,6Y05P\Gf/Z9-QU:T8ORAE,0?GEQB;N00(6CJaWY,XfE:O@]-L>9V6?P2M0
MELNaVJXPA#75SQ:0G])YOg]c2OU7T95YB24WDFODgOIQWfW?ZN8&b>BS8-9c>)/
O[BH+U]S^JKdM--(0V#BJ8#a4T,Q[(g+H9+L7PW/-CN<cOTUNF;Z8TCTZf;QM6O)
SMO(<LBPGdPXREUgTV4a+M9)S[)Q_/1aE0Z>#TX,M:)1eW;CH.D:U&A8L9;6#.V=
?Y0S:aKSFV?;(B<;&<0f_1JPe;YK.JI]Q5efK15PdMe5K;&?663,JB]73X(M=TT+
a2cBB8&A?-3-YacAD7L+dQ332-4DD=M>W#DDeCCC;W2E<&f/((GY4@/Y0&NS2DSg
VF23QXN^5g1?BA/-0@]-^M0>(gRQ0IU;SPF<:(.VZg7f_PN+8T&:_0cK14c=[_8f
;#OReHHA=YRT@N6@.U3W/\.#@Mg7BfC=BW1SA:0/c;9Kgf[63?O;4G:,JcP2BVJY
_fKafP5IBR>:&./[)ZW8H1:=BdN)N58N@U7ADeSg\W[56EM@[.a)dE.d@O3.c7FO
W2bQT69Ycc[P>/9Pcc2d1\gUF@dDfJ5Td7LXF.=0M@5U#dC]afdf1d3UZ\9gJ?E;
Jg^KF]Dc[b45]MV6(<7Q\:&>_0XbJKPCfe,b4L6F@X.W2f)B1C3_A=U=d,]#Ee0D
/UDWY-KE1&4,GAY>QE3Q1AF8I\;4Xd(]N6;g++#NII?+;/&6&P)<#f@b/[#-[Dfa
0Y=&UTLHY5(Wa#2A-eX,/aP=:H:/.?)bOI<-:X[,BbYJWUP+H0&f^=<0AQ84E/>G
3R](a+;-5ZL@-f@\HSd-cfE(e9g8B0d;,(AUFH3_50Wa/804HYYeZJ^D><4V)e_+
8&>>0ZN25:+Vg1UE\^S5Hc#VEZFEDXcQf1.WO(>A]Z#,Ib4W0eX\?.#eESACS-(f
F++[?A[gV^B37N+4:adEITJ25;V>SLD0G;]CLD#;ONXX\@DP(TZMX0@2^\@U(;</
0@>(HVN:gDD<#>L-TY5.b?53QdN4XWJe.O;#E4_d6=U,W6L;R>YJ_K>^6S-Z\O5F
P2JUMVab>FG9@<OZ@Lac3;H^PNR_aHXS,<HO;#T:/D1^Gad/d<(U:XOM0CI?[<N3
aO4e5+JEX+OW7dB+35<7VLf>G70-W7V=:FAMU-2J6K\O<J?bWT&ZgGZ>Cc:9c+]c
R(O[[7](NY98aKOCI.PGY]6b3#=,cHHAQd#E5beg_SKOYRW\.ORIMEfS[1JaPRNC
f[C6\0+^M,HQ99Ke[BJ77)33&_T?&SVX>KAF^#T_#C,\<]^[.BIc>J4\J_3][<)B
7@:^C2;gIBJ<T>@F+cb)g=cC[Xc5U@>,/KS]9PK<JX[2dM+4GFG1Zc\6\2U6\2gP
UYgW#[8B(NIB=K9Fbfd@)86F&WBX\f1ad\]Y?TD>N>03HfV1<G\OCS9EDf:e_9I(
IWASeI,LH1&2E/?31b;[R(Nc+&-WP6fJXB4.[AI>T_1aTL2)Y>OQP47@/6a5I,dG
^(K8CD&<>a=Eb0gC<:a+X):bI)Wc.J[W7CAVD#eEQ,g-I,--1.EJK[S_?2cf>Ucg
AcPGEWA6&5HSE1a-W_9b7X+_\a]9+fGIg,FWB;+Z<R?Z/].gT[fTLYK@S2L<+4J1
a5(,.].bcG=&T(a[NeJ79ecPX:0QB:E2:AB;bb[]:a;[>Rf9g7?Q,1#QfYb1N>g9
F(?SQa;[HaY:GGK?CC]Qb89JP@EQWe<Mc2:\&UIZ/]T?2Y86gPg8f46<4OJN>(++
#^OVNLT@QEM)^__2CNALO?LZ/?KLX/BV)I[9\7=RZ(]?gRTc#<P^Z4:Y+&L#cUQ^
#VHB7Q41RJHD5;Xb@9GDf/dJ0gIU=#a/\c.8Z^5@PQ(/L=V]ZVG(L7.H4Y46(SdS
]X3;9N10@NGfST5877OTT,\=BZL8P/CU0e]:b]P:#1ZbaBT>\[2LW+7(7gP>),W#
<8,TScVg:^ZcBZYS]U>5VAD+DLG-?,FL#g+JCM9U72[A3D.b.PJ=+-BYKNcK^(:2
..2WZ>bP8FGK8]FdCS-O?=AB0]()Tg81GN>^]f5bg&Eb=&Y<.;O,9WdHeS0e809&
]@fZ?RI3R/0d0eM=(8:aQO1R-1cfIZG16K]6R#I[IFE+V0CTQM,HEdHADC...-Z9
Q12/IZSV#&Oa^?H3EW+AO41J#0[WgB0cWf4SEf;[;gL4O3gHXK[Q>#07:4<-f?KD
VPd8&H:5G46U[6c\8=9P/#X5^OAf)dJAcEC;5UfRJF2#5.f6:a\;dC?eLX;BWC_M
BaX:CCZNSU:(K32KgL,Wg3T[e3EB[IJJ0A?ecf;RJ,]<&MgN;O3SH:P]>E/WgAO^
E5@.#gXC]f46FAQWfZB_W5++?d_Ge@HgL28^VV8/24WebPWOHO+abF2M?)\I<:Lg
M8,eFA?D-L?e-;D_4&&ZG\Wa(Q?/83g2D/L__D;+EKUc:>:X3ecNDGMd+^V@@H,:
EF=e5P><bY,+e9GYKARX20@+&DFQaTP1RbBbO=U8^6bUfBK^XgJ)Lc\2\;NJHB:5
L]=3EcWNfXgM^N)<ILR>Vdb[c;c4]ZT/2:#GBG5E9O1JDZ(ZKdE>UDLPL5+:I4aZ
:.Z3_-+CQ?G:].g3gT6d8aW1X9R3C&ZU<T-KaK93]Ng[/^V^Lda)MW0G=@SE+IaS
_5MDa1ZJPGHZf?[LQUDM\D814PUD-5(@&UO(92YcBBb8e>VGSKN5GadF&\ZEYde>
XfdLd/V3e.,9+?T[EX]\FT;<^9SG2LO+^@E_9f/1D^U_4Qee_G;CN-Kb?P7FeaW0
7A,--JdK-P#I=-J7(g(X[T:gJL3#KY:?\g:3/=3Y1QW+0K@719XUJ2Q3.^J.cd9(
0UWD3^T+Q@BfN-5:;.-d3TFOV76JT<>4,/EA<<&(+L#-=aJT#HN:#2K@38Z(__M3
ZcXCME03U>aM\dVNXU;::@Q.&,PJ22.1E1gT=_W1O#WD+7b>_2AZZCNJO_>OY2F=
92&PJJcV)^ZTDSWXfZ6X<@a<SO>7ET-6W)8>=aZH<P#.I#D1>O:E<UG;FTB#8WEB
L6Y[W;7aNI2,#<?GGg-VR^&@TCg#Mc#Q#HEIZW,5cPYKURG2fcIYRGf@(\G@X9f;
?DfCJ,#8(&:9TW(>#Kb-&ag3&\WU)GK:+LND-HWKXXc73?P9B@1H9T]=;#bNB(6V
CG7f1N[J&+NYNE1\^IZa:BcD6HN=;UgYaD2OMUQ>YXLCc/0a,>5PMDaL]V?>g8ZZ
.Je90=PSZK]SC&cQeX=7^=F@N5@S\WbVIO>gW4c+RSR<\8bX11Y2#0RL-a=Q;=BC
(Ob?9Jf)aMQZD^X?<H6YRP([OBb67<7AD;]FVe&PM7#be+M<0e<987IP,UT@.J0V
dRf8#7I)bC^FFX>-5\&)SS#c/)WFYe?#+G/4d<B+O^F8^1X[e/,[ZNL3:&5CaBMA
)/O;9(OS6;[ZdTb&;FE2@Ob=,<XN?IcOECKMc&&,L3QW#Q=(g9X1N,&Q[.LT+)LV
>M1]]>K6[Mb(:ZW4M0DWV#2A?=c>fISJ:=2C;eKV&ZZE=H<XWC/L>KcgK9.GF-0@
+YdUf:H#[[V)gH^H>VOHMP&#6aCe<LTg/51f0D_H[A(C7F\TG<eJDV[7I91GU,CA
;1cA,15_cG+Z0Q=\07)c5CK&WN9?c,Df-+A^+c4Z+JOG^Q@NHCXW)E[JIKKHdD)4
UQ;\\=cA>1H2U5P]NR8K(g5#Y0][(gdX\JY)7R[6ePAFLeF<)&BK+1bL81CQ^(Lf
9R&=DPQD3<g?V#5&P/QI3SGD&WYVGY&EEJ/PR2b67X/D:0c7/.@C/DF,V:+R0W4G
KKca@3M?H<GZR633bOdD]:\.g&P_HSD1^;\164a2bB3@8_U[IHI]&@V)GY<B.1&K
FNS3T?:04A@TaNA:[G??<,.?EgU2gKd.JP?bUK7_b_6_b.+[3#cY]]MRLOW,YJ7J
-6Z,LYe6We2Fc4T.U)T<Bb2^4_[ZWMKMQb9Me?XAKSZGPUc)+\TW(M>GN8@MNg4[
@H7[_@CaH5Waf=bET5;VOHb^Mg;Zc(=H^MW>:&?Q0^PP/)L.(TZE5Z[,:Y5,d\F?
Wg@<NA/\J-E32KZgU@ORXINKH&W)VaMfB=_bI\G.SRYWC<T;gQ:cK)0#<@LQ0Ua.
cHXc=H[)=eUF/g2eWDA;\#<8\0ZU3\/4<@<E\/(Q)c-fYJ]1Ra8[^<&R,,?TDZ4B
I2Z36^4-IQc2/J15B(X/[fS2bB<\9D5,VTJ@SSE5]H#^.#:-HC)-#O7CF)c-+&fF
?NISP,?.b64N8XO>B+D(Hb(]XODS(&1>7^A]/@/(^___1aGM+F9IA8-KbW#2FN0=
Z/FMG\O@I@:-3_8&&U:NUQT1M?DS)H9#,I1HF]-MCReCc+91Ob,P7YOT9^NIBcGT
HA0@CP08F=g/Y-.>:1V9K?66PcL[4.R=C)&42A39(3<f0GV4X@F.f9/U.c84W7Cf
^(Y2L/FGD^R5-BAC/-^3[DXG.]4\c522IF/<VOGZYGFWBa[Z&WSAR;F;Fc22)ZYY
Ub+2#Q^:K(;02,b31==9TT01gIF+-Y68F\?5cDQCO<]BcKcNa&bVNL#U4XQJ,:[_
&J#c^dNF<7R\KdQ\0U(2,)V;Y\9Xg8H<#9e]aXbC@LI?&9Ye/R:VLQJNX:])IV3E
NYcIec4XA-6BQG:]YGKY;/b,A?68<IU--A5fLQN3TO&d(G+KY,_<)5a8#R3R8JNf
J,-TcZ=cLSZ&C0@/VH]E.D]Nb#@^.\ZgTJ3+\H9TB=DbB8PY-BEJW=b&M_(EaBUM
C-BDa4/&bT(WdOfJD6]V6O40&KF\TT9dQ-VRHUbO1B?>N0HKR4#aOD#HQN;.=dRU
26QFI4QSb;+//&N0SG(R[gIDJWAZ9@:P93-X)1P>fUbHTH#>8-Te77dM5\;Sa/-a
(CI7&0K:V@_@LNRVgK=.eM]SZ)30,K-MJB(WG81KP[NJ_4L\a.TTgNROCV/BE;@>
GL4_b=\#P;KH=&4^:(G55;J</Ma)@g>:<TSPOb_TJ4dF6b;/FA)2[N97Z#7@Hf@4
I1-;)UBfYe,afM_Q5RY+&)G>OLDM-VV+V/K^N#VdDa9YK_OTTNYQ_;4;--JY1fF0
U3\3B(aNT92:#,fTZ6NZ9Q6X_(7aVZUS.LG<ZEJ.X/bLFCHAGC\L);/Oaccb>-A[
1\3,:+8KYaY^HO2EGOG[0U-<^feCRg)7M)?H6>BYSTIJY=,9(6eO?BS&1TW&:cYF
dGaEbVSV>UZ,Sa7.Zf8R5cG(WHF<b1,fE/HO4>.]f7449HR^YB@1Z.C6=&YO[BL>
^SYN5&f]=O2Y/]@7:/A3D2LQ>4IEXX-E_8\5CN<BJ)f=/2F](3EbOfB+^?=2J;U.
W,B:JY?)]SR^@19M#IX72[-]9K0UN=UZ#IH.a,:#:5:[R/CVN/N>2:c8V@9U-5I)
A9_N@U;[QcD;WS&4KO,e>dAcCCF(Z+.P\_\cCHCb/F]dC)?HE;b&YT:2eZ4=T2\W
d_Y7J@J_MHH5J<<_8:,-;3WJ40b/7+H_b[.fdS5^YV;E66;O\J#aWJ@0/C#WD?WP
E1;)>N7]6Yf;3B58F,PR@MK5(cOL8=81;8)2@WY>?7B4^ZE[dDN792:Y\0HP][V0
&^WCM=4?N@V(GQC4QO9d7PM@b)PO9M/JQf5=bS?N2WQLKeUV;&Pf#MP#R;-NXTJA
?<QRRVA3(e(+6a=9V3C.B.,]Z?B48Df@9Y@,Z&Y&/BR1?#)M<W5J_84RcX(UGaa0
>NK3,@75e47J;A2M8D0DEb0(g=eY<6(,=d0]PF-M-YJ#Qf;9>LP>JY9YdC)Q<9+R
U8RVKd[^M6O:O>J8GDAB_L#c_U3AH:0GMOV3@gL(BaKS;Q=9W?UeLbGFNV,J2F+-
9YH@dEDG3+<VReN=V;[N2CQ4IU)FY>N>Xg\0OZ-6B&cNg[D:1TDX:]AOD;.N=]LF
bB[9E^GN^A2=#^CM2?THB?P^SAP^/.L7N&;Zc\@T6<YP@g-K#,GaU=WOB[7a=g2W
YU/4R@(Ag]PIO\4g=?D1W34_TBYB^<RK>MF4=[??<Y(/_/<B_9Lc2]1f.QP#<L/4
eC<W2G][b.J0edV?ac#N5c^1S?&PV2eDS&O9+8A\CAa_L)5Z4&./a.WRRP,<@)KU
bb-L9;DgHJU)CF)?S&IHa\3F/U)F\9W:AKT,_PE5(f>9AKE&B0gTZ/^BRFIS^)E&
X2=,125>36]7MFL\NOf;&FJcCeUN4aB+/H(CfD8[RSV/;C/OZ4JcX8Wc/YRQg1\;
6GZJ\_V84I+3=I9KFgc^gC[B<SJ+>N0@UQ4E\QRAY85#R>Sb4f;7bW#B,A0V/-5B
<Pa=\6B_\5ETIOfA99P]\.GZ]4Bd2<_K6Bd4\55XVD@)gF,AL36VG7EJ9>>VB8FE
g&\G9,3_B@^/6;SHC#@SO]+/?)&IR1ea,D2X?/@H#T@P8.(=>/;QMF\+?4(]fY7V
KXaL3cI=dH58Y6N8BU,eH@fCAM:6_?Y#bJT4^83=[CH)F^+Y+Y0Ie3OKMXbBG4@X
=a[Z#5H/2ZT75d=<8L5C92f>Y;7FSPK:)fXN2//23\S39RM3K>Qd[_aV/bU\^1^e
T9BFF.g=6F6cf3bFQEP):_ZL]M.4(XV3Q1,#;&Y&)54>dM--2/g@]/g>-ObZ4>,;
K4T].J_U-9&cgF_]c#U6Q+9Ab>T5dO9A7W/MeUG]8cJF\R^NH\+d)RY7e.Vd#N@N
96,cJdO7)d3,[NReUS9)a0#-74C];][MaeP).73gPI8Id9c+,)\O.<_^&.PD0@?K
<f8KaIKFcC--[E;M(Z;A2C_5<KMRZ1XM&(&DT6WS/&f#);86GIK>Z=O[8>D.45M]
<Z7K<JdIMYJDRAQeLM2=6fVcJ&2)=JV+(#Fb[-G0OBR3FYbdGV:ROSG6YZV?/fFf
TSUeJAd+PGPJ_Y1:ZX+D;-M?HWBVfD3@RO/-b9f:C-=>@Wc;3)CE^\E@bS]/(4,W
LBUPIN@c&^f,W7F=1#38RfBA,eaec@O2JKU6f3T0)cK5#Ed^PaHZ]R-EM3c:L)N,
>0:X#<aIFgB-F@6.,JN_U7Q_MNJ,8F:eYd\4E5Y#3fT=A-(C]8P&NWaWA4g?bWBO
d_(Y4d;<?EVFBe0]54+J1,DN93ee5P#b@(a^Wf:M]eW27A3._B&fe[XL9\+^HLWD
P+W=_d&&NS4+C+A7GJ/.QAL5U8UTdbXR3#;e-)=A&aQgGeLaa;],g3PRT,3T9+eg
aTdd&K)]XS:^aCG6^cfGFV;fH<8UI\@N#S/ad=0LK->OH:-,7MQ;YXK)F6<#H^Q:
J^c=.U=2FQ\0Q]K;f#+>LS8a<,O^U4UDMU)#I?e[412Oa9GO3RF^M\HbY1A-=K9#
;.F@>AD?_:@JP=-+NCARcCVA#U)+MBW>\(MOOM]C\?E^LH^1(b([UTD&aC?cOd^[
;>4;-CFN]_[<eaSPeC_1gf+I(aSdNKZ@RcHa/8LJ8M#^W?UKA0/GS@CN-0IY\ACH
C6NCf:?2U(@M(:>8:bK561;.cX0.53OES:8(Y&3<T1=)eG?_A5d1Vb@GLR2TZG8V
/W#B2#K2VX_6de:^4G^d)B3Tec06&>8R0<1g2KS[?V^GPLBJKegND[:Y[A=0_fM+
=.-;\/#&CcG+TR)>F[V@>@06),fM=Hb7C7FOVeF=\5g04VA-F0=FT=P)/eGg:9\@
23FU+\LA7=EXI7>44:KW=MW5--?g8N=ZJU<(ZLc8LD@UJe.dg0H;.b43<H&Y<ZZY
,HD<8LHV]N?X1,:ML>PLZB+JYSZe+FDV4CUAA9@..U([9KL@?]?e65;QTY(;]]7N
+;E[HebB-5::]LF=?8UFO_VM<c:AJ0J@+J2.F0WC\PG9.JG8;EO](MJ])G5H^VH7
d7,C<NXd6[1Y.I)>J&P=B8X#GFVK./RLNcN17L(9V5_9\0Y\[[8.129a7/LD;7DA
21bd>>_1WUf0DNLIQ<_Ac##7CW/N>:AIQ_S;-^(C.b3C6aQ9KJ3fQWL:[C@]0gdV
&=4-8,DLJbFM[ZIP6><;R58HJ:>ISC6?GT)V/391GCESDFRe<.L&Rb][P=fG;8,D
0D,-cTLI2JTU3gL4D=#FPMEWDA0?/O4\4B.(GA;6/3c6\d_KeE.a(f=^><2,0)L3
TMY&B1YR@3_X6E-B??ZFEUeD\dQ6@Ob+Y&M4G.NBZ/<BcZ,LJL_E>>4^U-[f&ZBf
)OH7E)F.3P=c]E>@GT@c?>;Y82CODfO#(Ub;Tf3LJ?=<S#HYK(HD[C7C&Og5[E>3
J_V1#cSX+H0D:g0e0KUdHfa0K(78.,5G)-]G2S:[+3M4EO+V)\03=RJ5=Ea+1;3F
.2-eTObX^QV=4PA>B)/C>/K.YR8KCNeZR3E8\EZ5R3bfH\Q/DBP-XJd-9Vb1b1+(
OT_0W._)L&D>=^<A;B4^#,/124&(EZ<)aLXIFY9K_^eRQUDdHWHKYe2^CJ]JQ3]>
dQ8,5=eP96JJ28QdQVeZ^XB+@98^LZ5+IRZYG?Q\\B&f4E-dd+Pa3-+9&N75KJ<_
?aXECOJ/D1;PH/-d<^K7f8B1R[CGXGbT-SeRY,/+K,(JEOEWc\=X0YA\DTLGKH87
(TK+&>N-KDS->U_Z[d)Y#+G?1&)Q54#+_Ca>gd-9F@a00<-[H_E<:53aKUHFRa#)
96.eA?,)MO4_NYe.9K33\J;C@aQ.<5c]a<.Y5@D5P?@gN6:>L,#Q.D)eD8@JKg8,
J-UD1&K#>dRL7DZP/TTEH9eecF6db_BMg9E-H-(d/P1_Y(YSBa\WJ]<1]K:I;6X2
:L.)<-cBCfSM4\R,BU&#[9=&FC^:3YPVNB8#GDXU)PXb#/T5B;)[?W32GLDCNL@I
Z]P8#-?+SK2-Q9M5X9WK5F(1?X.B+P(:^^4GZW,Q.\aF<6DY:gR-F+RfW?^)FG5G
Ee?N)0:WWd&.L&:fF0_f;3aET>)E=9V2=0a[9(YO40HG:EVI&\K7,T=[QAe1I(D&
97/[6gdR3[/N2)@bbaXF?DTK6MN22,UF7#JQPN0#3cR:-M]JX(BBEAF,gJdQVM[1
GPHNO34D==W-LUK\1J+8&:&RU>QUbSYTF,T;&@;:./VO_ZVGbgeMDO9=88L\:X#A
LR9I<Z#2Y<11?,gONJC6DM+8=bD8L0OV.1/_b:WZN0,>VFQRV_NaM(=O[3>e[beK
5b_5L#O+XgQ]V]7,dY3(U:U3YQQ]6S::=:9ac^LJ:g&Tdf:dEW;;[;KRT4cZaC6/
=\.dD41^Q=#QJ0.afS\gb8+=Ya:=?,<ZcAZ^E[cO5e,1VC1GVOd>IdbHFW-Q-WWb
-f3JB_Z/c,Nc)6:GYbJb8,O&@IEF_I&;>H>?:NI1P3&gFgW_;<e#R(I)<-fG+bAG
&+dR5O+f].2Ya.DNYLO2X)DKIff,)\=JTP8EK1//O5gJ6_7Q#--6?7]QaNF_#@g<
-aVQ7,K-?UR&O;C6b\+\OZ9dK]DS=;)M=KQ#_ZAPa--67Z?5LT4K6SYHfaB-?^CC
W+gNJBA@2R\\1A[2KP_Y<2:3)0X([B7V/0NP03P-=PQ/+VL6>J>/?-#.Ug4Z.g&d
ZdWQMOe8X\F.8GY3e8U.,Z@?5c2Q3e.;]d,?f,4CLG4<QBDV^WPOb4g9>O-FAKT)
-MBWF#.IZ?_S7,OP)9+3=f?d6fW:6Z&[\)Eb8b<QSTD(15RL_B\#J\[.A_V_;)#7
C,:R;N04^f(,M6S<1,<f;F@M81c8838H9G&I7SV.[368dCV^:DY_ecK2,(D-T65F
2gF:=:DOZe8fIa81gFG+)gZA5C7c3]fQ+#=b=/A#@S2N<SY2KNWD4S,J-115=1B\
E?Yb[L2E?]J88-0D]F/#V;CNQfV^;SCZD4F#+?CC<e[7aUI-M+:d12C93Y]f;,&G
;?4T-#g_G[>JSTb6dbGTQ,^@-0T358gH.HQF<2eB:3]#F;)aBR#]H-MZ@g0\TW(X
ROVZL9a-(TX@B1/IF)B6ZUNS=:XRD/N@e83b,A=W.?-cTN,6]]Yf:\1?U]<E(CCg
SD[)bc(?Wb9Sg;(5J)0GFT[:]4J0N#Q_\A^>N0D8VN<Y6T@?\NCP:NbEALbS3dM/
CH?d?(ER)bK-WBX4UXB-f/eIaUV(]()gTYA]?g/e)A+VFa>b4AR@Gf+A:@J#fN6=
)>V3]4IK-g]^J_U]0ZdH&FKdB@L3J<]cDfO5Qg;0P6SJbJS50B=dc?0Y8;Rf<BRF
S]A+,bE^&4gST0UUR,L0@#0M\/V@C(TF2.(BNO3gVV(B1_V@NGI0BL>1P;WE,_4A
[A(C#LbfBQYQ/R6)L(E&:-gR43>gBeC:>S<FPC+K=YD6DXD6\=ZGX?/G749G@bI<
C(cI(TbbSa=O4UW1,HP.VH,gE_KE3VA4M9P<.T5OV,XE7E0A5Va/YS5WA4D4>1VW
E8F5M62/[Sd@=R_9=<IO;[IcXbeIUKBMAE0T&4^e3MLg1TaB44dZ,KI(T90>+&Q7
16JYb>cU-9IEd?VDA(#SE991E?eMQ?9/>TOH47Q,DXK2cD.#+POY:[.Y5+Ic@?c4
AgMb.SW,]Q4bK59N3W#KbKb,>-6cbO8S5I=C^F2G<,d29-8-46Bc]H?K_L([9D;+
2H,L9fCD<HOc7W;O>:YVb);<>=+(2+2D0A4@RYMgTTYT9C3]-K7D^)#V>0.KKUF@
dKIN]@@cFD[=7N)5AZQMWaW9KEZL0KJV5D:ZJeQ_b[QDP55HDZ+B_EE6eO0QSW:]
Qf+Lc0VX0U58BNXZ^L.cdZ@SXg6-@B^YbEF^gQD)c(GDO^fAQ4?Y&]-X_F1QWJKN
-OFYD[B,e68B-?JG+dE,ANCcV&eXfR>8d2Zb@;+fIeOJ77RfV9ZVa_5V(]c?_>H4
/Q#QM<,T;b<[+GWUdWd=0B_e55)==O4R.ZXe99?U?6-6RTa<?GRIe=:^(MNegT::
C@=[LD(-.+IKGdFXE3TgYG3+Z?M^\)S5P@1((S:,1E,fZ2+a((51594_(c-Ya5[(
]^M:7(WAd-I@T^#6c>R_>e=(I@8;)N(@_f?B-;eZ=Q/#gSJ-_[<?FAV32/P6LO&b
AJS5&ddX<\_dIf2/36)P(DFDc<]M\#V2X5K(GS+WgTbFCb1SU)LW)WVeIJ_PW^R,
7M/L.[VgS@7g&g),2,UJ/-c-fC1LadB:=^+F38P:&dA?J2ZIZG)3dLQ]/O;NHac0
.cEP3R2?g[f53AJ:ACe/92[1?2(&cA64Db[/E((gRMLXWI4a0R;(=aN&#SYCe3SB
1<]=^\E7PIC3SFeTOAeP9g_\D/,VX&PB+Db6-FG-\U3AXT98FfdJ+,3\0Hb>VPBB
):Q/B)HEa?OgJXbS?<OZ\K(g2b6#PRJbgHSJb6L08^F#.-<H?TRQ;e\845;7IVW5
1W5423]bd/;QV@c+WFf4eSPM7QXYPPV]>g.MdU<]63f=QYWeF+)OG&c_?N7e8-.f
0#U)SPLW>I?4N08f+#Q)X\RC.A?1PQ&cSM;XX+f\D3]QJg3?#8g=,I\YU_ZV>W]>
aAB[D4=(>VMHSKCHbZ339#(de;[R^Qg9-V+f,Df<E-B3E_Sf:7DT+[&R5\g3OdgJ
:4Da/c/Y>[98Yg[^7+-&d)d/<#7Pg35Ja1.ZE#e5;:YXP@SVYcWLJ2fS-OIKZIf7
[3J8B,]a[ALef69ENUIe+LX,Ua.,LHPLF>9YB7KWMRPX-1;?HLKE@fCBXNZ->^.M
4e_G[<d;OLO&QGg0UG=M9KCA?6RWRWGa-#A0<XY7^g:Y/5:dU2#_L/(LZPID+.?G
YY4PKX&MYC1K:^QHWcP^d?(LA98,4-))X75UVN(dC(]Ne-dM:#e@/C=I07;e;9L2
P9f16P:J2RZdBQATJaVA2)EccK2c9-:ZO6^ABcW=8[fR28&=Q9NW08^La=b<.g)-
M9P9YgD/(FI4PD:#Pa9RSU6=XNR-10\;-20UD#:#.T1AWE.P54H3,HT@H<VS<e29
DZZHDd0UR]@@O>XB3SaN1]\W<JFf)\69#G\I3(:Mb4__A:+RgD\^(=\(<9VG8=8L
5_2SJXKQG;3U.JBVT5DR#N/+Pd.LIY/TP-IFF=d&ff2YB/X-&US>+,X+7OV2UHZ9
(-XDMC<7.-UVY(V1@WYY01F12=B)c-HV\S[f=]#+aQU9/Uf/?)(\+UU\=F;9]>\-
+?M+AbZT:bT15DP)H^4FbH>5U?K@>Cd-7=FR71C-9TdRSd>&;f18/<\BFR(Rb/f?
YA/]-NBYJ<M4AU25R0V;GGJFKFa9^4b(9=D\?92:F7#Y+CPS-IB?Y;S(GE5YcV>)
gF6e&V>EeZ/CN868bK7(M_aN+KYMEBAf](AdJQZWIGG&NI5QVH-DbX1B:/U-IG0g
GM(HZ59;(dSRaAb,(D=YIQSVZNAP583/gIBKMAU.7-AB-\[ZE:C#6f@YdB<HJR3G
S2JE1<0>VCe>Pb]?7RaK<g#HeAUb/Z[c\.=+/B#<dBDb4d?A(YL?X5OK;HX-T7IW
8:AI5)F+>)./#3bdSYDNTeH[Gcc.(W[VJ,4A8EAdU^H^3N1H<TX?dKX>6eB;CWO1
e1/B]c.?6M:JU7^KPKX.0=CZ(_9XJ-4YHM/O>R/Z=>^DKV9QY4dI23:=<Ud64(GU
CLPC,W&B66IMc^fO##/2Z7F<HaBgc,,+fATL/+WQ,+WFLU<cACCG(^@0LWa8LdaL
\HD8TMHCbPYJN^a8BUL9E[(A,5WA\(Bc?#MWC?@_-GNQ<9?N@[0\//8_#QfP=V^_
Q3>#^V]B9R5U.4K61IS?[MadPN;gB_)/1gQ7a3@XfHHGg>a^9d6R7X43ZeE_LK@8
5\2/f2?aKg\N)]:IMX^M5M]3=T1#Te5^Q2^7Bf/=cbI<Zg8,4a/=Ya91YVVUSc_T
,N(BaQTI1_=FY=FZMTEc3S/c4ODRFJ;bBa>E\b(g@&A8LgB-RG)S8RBS2NK6#F/H
(Bg;V\NbCB)H=[=A230S(f2/_ZS1f=L=WLd,cFef0B,1JW]FaK_WPE>KY>J>_V58
U=gN,,fXa5&>I>146YI5_BHMUG2GLfY3Z@--F+A?SQDYb9)GSNO:f1fHBTO43M<@
^=M74+Cg9MZgJAW4O5#(7b4dJ+BD.63PD8?H>1UEg^,W\[dG;VBA3RJMeI#WA>;c
#c)&,[_W]#.^KN?Ve4cgO.V_Ka_eSW<dQ=dEIH#+V0b_a^HN@1MGfX=?ZcPU]\LF
B?ZF8Z\8;N3gb[.a9@bA)JNPMbFA/T;VBY@^H@=Q4P>4,>P1@&2.3,G&[-&UU3eC
e[Y<UP::0#&b&H+=]I:gN9=6@H6US0SRP)S5>c5W]:K+BNYB[2T[5S>T5+7;(f:,
[9[V\;2\4g;;bU0ZVG(<M/OdZK_cT(TPU]4PDQ51Gc5Y9HAGH^KQ]JZMX6;4<Zb_
>_)8R[-,M@Gg9c4IKWP6.6MJCHADY+U@X?R.7,[^L]7(K-O6#Y@T[I@0S=H.B@3+
&FBKATN,MJef=UJ.=bIe]+R0E<U8+^+2)9?b/V\bDU5/[PCa^V&]Ig7<.K=J+P4K
Ne4I44.4?QaY=P>&;L<bHTW@&2AFB>4)cfe:DgBGO/P;K:.[M#,adb[V523_4S^V
N6.7b:8FO6(<\.eYKMEXB&ZJ)5H7P/KaBU?9,GSJb:;dAHINO()WN&Qg2CY:f6.6
E;HZ/4L1Ba<4@KV&R_6,f>KX.CNJD:_2eV4B&dR1AXW:I2(e]RbFPN7=[=+?+-^C
H97g]>H5879;:fgP<#-(g]Ob;6Hcd:<M#H;eSK>G2V_-^b(fX(+Ic(3>Y+5JaPY#
UUB5^5Z)-[Cd[0A4#W&[:,Y.DAI?;44SW7-MNWR:2(5ZQfC68f#^JJ>X)c/PUV=d
DH[&CTfeIT,/7:JafGOb.>-+B-#aAN\^AgLQN.Y&eZBO3KI]-:#YQJ0gaJX[-,ec
_8,#g5Y&b#4aN0DUG+A0IT:>XaAL^1QTdcL9U(cXQUE,,E)DFOIX6,R0e6Z5B\1Q
)c4^_#\G59fMaB<VNOf7<c:K]L&K[GMTB#\BO_VH>dLQHSYa,)4f#48fb8Q7R2Ee
ECH>8_c-NJaE.B#E6_c/YA^Y]b0e+.J1FQ-MbNI(\#Xe/4aKE)J,f::#ZB9AYLOH
O)+=OBN3d[_>JM.9N<eg6<48+5@B.<MA&-A3BBE.P>;SAPFEAg9<,?bed,BV6\?3
+0Me6&&f4EK#86W2JEZ9JX-4(F]gcVGSCES8L?.3-1;IM;Ce6<(AfQBOPSSYaNND
X)19e.4Q<?MLAX4+(>X839D-[>V)IULYN#(<Hb,9YZ>[\NNXA:)_OQa0\P;W:NU>
gV[6E\_\[WcFW\cV9WY]1=IUg^:Q<cT(2YS1,d?I/]SL9P?c#S^MPS#4SHUKdNgc
(:7WWM1MG[V6&BVS(3LUZaeg:^S?HCTU@V]B)UKP003ad@\3eJW/)9?A;;S++Nf\
HA9+?:=[6U:c1]EG852L50CJ5UgP:D[Fc5(3@6;^SO@&><VLE\b5P@YG41_IeE.A
.U@dd@?H13#0J10dd9?<0_<.6I^CbI[0B&?SS@]8925gZM(8SXLdZbaN1)CMKU[c
a6(Q?:Q@QeM@R?Q)E2ZK7-E8980aF-8M0M1PPZ([7fJZNG,.110b./(aJ#X=+20&
BQU_#WJ421eV).#fTY^4@KBMC28LC]0P@0RcZC@J7;#?e[2<8bDc]C.-E^3SWB2b
b#,BG)T9LKA_GVL@4V.ORNG:NCWE)M(UJVX9^>)O3C8fXdH10:]<-X:G?aOP\^BP
)WdVd_eH(cY:V;?V7P[[QM[W.WV1G\\eCS6\EP42I0H2UB\85=T&WR)W,>D>Y_;[
dJ&)L3SfMLe:[3+.Da^+[RLg]M/4,9;TB^;eG#YHJ272\.7@4^BD:BF(/&H]XVWD
<bA+1_M;YYP.A&6QAW##dY&4f(S\WcdS(g^b]g/[)3cgOFHe6C7;>&;UGc_X#fS?
]b3Y4de/^H=2+8UT(HL(AX^.Cg-81<J<G#Tf+g>B7BL:QVNUW<aX86Sbf:&WM#PK
d9(cZQWCQ]=635D.>7a,Hc_3[\\6J0:8)>P\a)g7e-:,f.agX=9(SE)C;NH8;[1R
0QcEY0R+KXY\-c]VM+dJ18[3;Q:cUf0?\[18+Mc09cZN9(ZW(>R6_&\geK+>c^M9
.)2=CMEMa;>c=E=&0BB;RgF8c?[(I=U=V_SRT8KXI3XTRYW=Ic)+FPCd48TC#QCE
>gOPIQXS#7c[@DY<<>ee15d\_d]e.8&J)\WX38NZ-]>66ZET-)2AH/:61@OL<_B3
/R,NeJQ?[LbG_\Zde.(-0/db-V:cU]RR-9_DQYNdVRfVNGIZ^Q3T#B:D8PH:]HfI
O5FDCf&;B1ZX\6^Vg\2d@Ldb2$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV
