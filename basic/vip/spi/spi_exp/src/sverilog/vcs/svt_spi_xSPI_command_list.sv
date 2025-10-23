
`ifndef GUARD_SVT_SPI_xSPI_COMMAND_LIST_SV
`define GUARD_SVT_SPI_xSPI_COMMAND_LIST_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specify the valid commands for selected Part number based upon xSPI specification. <br/>
 * Each Flash Command is stored in a separate class. <br/>
 * It contains required configurations per command basis.
 */
class svt_spi_xSPI_command_list extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
`endif

  /** This field specifies the Flash Command Name.  */ 
  svt_spi_types::flash_command_enum flash_command = svt_spi_types::NULL_OPCODE;

  /** This field specifies the Flash command category */
  svt_spi_types::flash_command_type_enum flash_command_type;

  /** This field specifies the Flash Command opcode  */ 
  bit [`SVT_SPI_MAX_INST_FRAME_WIDTH-1:0] instruction_byte = `SVT_SPI_MAX_INST_FRAME_WIDTH'h0;

  /** 
   * Used to select the mode of transfer for serial communications. This field does not affect the transfer’s duplex. 
   * There are only two valid combinations: <br/> 
   * 01 - Write <br/> 
   * 10 - Read  <br/> 
   * In Write Mode, Master transmits in all the Phases. Supported phases are Instruction phase, Address phase and Data phase. <br/>
   * In Read Mode, Master transmits till Wait Phase and Slave tranmits the Data Phase. 
   */ 
  bit [1:0] transfer_mode = 2'b01;

  /** 
   * This field specifies the Flash protocol mode supported for #flash_command. <br/>
   * EXTENDED_SPI : Instruction on One Lane, Address and Data on one/two/four for STD/Dual/Quad respectively. <br/>  
   * DUAL SPI     : Instruction, Address and Data on two lanes.  <br/> 
   * QUAD SPI     : Instruction, Address and Data on four lanes. <br/>
   * OCTAL_IO_STR : Instruction, Address and Data on eight lanes in STR Mode. <br/>
   * OCTAL_IO_DTR : Instruction, Address and Data on eight lanes in DTR Mode.
   */ 
  svt_spi_types::flash_protocol_mode_enum flash_protocol_mode [];

  /** This field specifies the number of bits in the instruction phase for each supported #flash_protocol_mode. */ 
  int instruction_frame_size [];

  /** This field specifies the minimum number of bits in the address phase for each supported #flash_protocol_mode. */ 
  int min_address_frame_size [];

  /** This field specifies the maximum number of bits in the address phase for each supported #flash_protocol_mode. */ 
  int max_address_frame_size [];

  /** This field specifies the minimum number of bits in the data phase for each supported #flash_protocol_mode. */ 
  int min_data_frame_size [];

  /** This field specifies the maximum number of bits in the data phase for each supported #flash_protocol_mode. */ 
  int max_data_frame_size [];

  /** 
   * This field specifies default Wait cycles in between Address Phase and Data Phase for each supported #flash_protocol_mode. <br/>
   * Specified as number of SPI clock cycles. For some commands, wait_cycle_count default value is determined based on command type, <br/>
   * protocol mode as per datasheet of selected device. User configurable value is obtained from cfg register.  <br/>
   * Wait phase starts from the next posedge after address phase.  
   */ 
  int wait_cycle_count [];

  /** 
   * This field specifies default clock cycles in between wait Phase and Data Phase for each supported #flash_protocol_mode. <br/>
   * Specified as number of SPI clock cycles. For some commands, pre_data_cycle_count default value is determined based on command type, <br/>
   * protocol mode as per datasheet of selected device.
   */ 
  int pre_data_cycle_count [];

  /** 
   * This field specifies the number of lanes over which Instruction phase bits are to be transmitted for each supported #flash_protocol_mode. <br/>
   * This can take values 1,2,4,8.... <br/>
   * It should be integral multiple of #instruction_frame_size <br/>
   */ 
  int instruction_lane_count [];

  /**   
   * This field specifies the number of lanes over which Address phase bits are to be transmitted for each supported #flash_protocol_mode. <br/>
   * This can take values 1,2,4,8.... <br/>
   * It should be integral multiple of #address_frame_size <br/>
   */  
  int address_lane_count [];

  /** This field specifies the number of lanes over which bits are valid during Wait/dummy cycle phase for each supported #flash_protocol_mode. */ 
  int wait_cycle_lane_count [];

  /** This field specifies the number of lanes over which bits are valid during Pre Data cycle phase for each supported #flash_protocol_mode. */
  int pre_data_cycle_lane_count [];

  /**   
   * This field specifies the number of lanes over which Data phase bits are to be transmitted for each supported #flash_protocol_mode.. <br/>
   * This can take values 1,2,4,8.... <br/>
   */ 
  int data_lane_count [];

  /** 
   * This field specifies whether configurable Wait cycles is applicable for each supported #flash_protocol_mode. <br/>
   * This is to be initialized to 1 if supported. The dummy cycle values are available in <br/>
   * svt_spi_mem_mode_register_configuration::wait_cycle_code_list and svt_spi_mem_mode_register_configuration::wait_cycle_count_list .
   */ 
  bit is_valid_configurable_wait_cycle_count [];
 
  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //-------------------------------------------------------------------------------------------------------------------------------
  /** This method calculates and sets the transaction object fields based on selected flash_command and protcol mode.   */
  extern virtual function void set_command_parameters();

  //-------------------------------------------------------------------------------------------------------------------------------
  /** This method return the bit size of instruction code  */ 
  extern virtual function int get_xSPI_instruction_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::EXTENDED_SPI);

  //----------------------------------------------------------------------------
  /**
   * This method return the valid upper limit of Data byte count for mentioned flash command. 
   * The upper limit is controlled by macro SVT_SPI_MAX_DATA_TRANSFER/SVT_SPI_MAX_PROGRAM_BYTES_TRANSFER etc.
   */ 
  extern virtual function int get_xSPI_max_data_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::EXTENDED_SPI);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid instruction lane count for the mentioned flash command opcode & flash protocol mode.   */ 
  extern virtual function int get_xSPI_instruction_lane_count(svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid address lane count for the mentioned flash command opcode & flash protocol mode.  */ 
  extern virtual function int get_xSPI_address_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid wait phase lane count for the mentioned flash command opcode & flash protocol mode. */ 
  extern virtual function int get_xSPI_wait_cycle_lane_count(svt_spi_types::flash_command_enum flash_command);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid pre data phase lane count for the mentioned flash command opcode & flash protocol mode. */
  extern virtual function int get_xSPI_pre_data_cycle_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid data lane count for the mentioned flash command opcode & flash protocol mode. */ 
  extern virtual function int get_xSPI_data_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid Flash Command Type for the mentioned flash command opcode. */ 
  extern virtual function svt_spi_types::flash_command_type_enum get_xSPI_flash_command_type(svt_spi_types::flash_command_enum flash_command);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid Transfer Mode for the mentioned flash command opcode. */ 
  extern virtual function bit[1:0] get_xSPI_transfer_mode(svt_spi_types::flash_command_enum flash_command);

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
  `svt_vmm_data_new(svt_spi_xSPI_command_list)
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
  extern function new(string name = "svt_spi_xSPI_command_list");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_command_list)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_xSPI_command_list)
 
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
   * Allocates a new object of type svt_spi_xSPI_command_list.
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
  //extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_xSPI_command_list)
  `vmm_class_factory(svt_spi_xSPI_command_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
)5I=5>b2L_(0W)4<&Q&M(?Jd?##S53Kf=cJ#?1KQI9a>2(H4Q^Ye2)P)Ff8+4KOL
@>A/<Y;;88:.OCJO7]:c33cgWRI1KHEB9\XdMD3XO(LZcUVIbSc/AE@G8RLWW:25
Od7V&:eRA[^.\LLP\XgMY[+M)\<P@V5U0Fgee/<#/?)RXB/R(-;2AA\G?I]OfQIe
=6B97.fOVS0U^C)3,LH/R?&4B7b-ENV#&+8KbWUDHT;Me)>5c@WOV>,J[>.0US&6
]EIb>?5g]A:_EC7HZ&&Z5_G>gL\\-eZ.0JfgOV?BL5Y8XB]gQc,VXJcV/Za.aC#?
d:S)]=NE?.68a^<^]1)6XEWQQN5dHA/LgG&(&O@89_.9)f,QYK3^B5LadNdg>S\K
\LB1;&N&WY)ZT_&Y.R90b,#@&Q1fV(C3SHbBFa6F(9e]<XO0F?_MTKR:La_HAUY5
OSg.(H>/.Kf;b#UCX1Pbg(?f>0X<aKb-)--POF)b@7Q>f0O:(QYVf?SR)-+759.O
?KRR_,=E_abbE8BJ64;D5,R^(8,RegR9RM57Lg.,L,CbcIX7#+79(@J3<5P4(VQ;
E.=LA+ED^W@Qdd7Rg-=-P^fUC]TZXZ:EL.G?/5X-cZdOP]]c^=W(W2W1+X.=T4(,
($
`endprotected


//vcs_vip_protect
`protected
^8-IER@U=N/HQgS&&PeG2TMDW[0&eQZR>RXbZT;I39S+GAGc0.L0/((_>3O[AR;@
,c7\MDIEVCVgffEgXeZEI46S/Jc\.P+]+L5+^[=fP2.4M9T</;fOP)(\Dg^_5^N2
#:F(CfY,dX1H?H0]\A5(C#cD9Cd0R0Y_@:?SL&/c4c=WYXY&WVeQfSR]U)4d\Lc1
#R]Z3?eQR]e/J_?EfM[XS_D8;_Ud@g:K-JG5R;NaQbY;5&?UfKf&P58-L-KP7g3K
,A7C=dd?\3?RYB>GFG0[V)KDE;<[]-E0H>K_1)](_?5If_1^UJYCSg>9F7GQ[U=G
]:&RaJNCNA@CAaf#._ZJH7-/.8H;9771Ze92KZDaR<T?)L\b#J1;cfKa#ZabWg]?
OZ<JMVC8V1//8VDQJc7:]H2]N<UGdOM[@)cHN@S(,Q#/@,N_/5/:-/?.QEY4:+dH
1H5PGAa?X9@3NHI?YQ<Q]QJgd[1-[XUP2_[c(M@@Ye32KN[&HN]HSN\G@Yd-0GJ#
FHbgfNLN&[aKMcV79W+H,+ZT+K4PX]GN5#Lg>V[<[&]573P@T4BY68G.]2JK#E(D
C6VT]M>Z.eA2ANc96)4ZZI:Y8ae\T#\13-E5bP4gF?_g>[WO[g84,S0A0KP_^;,e
Bg89C_G5TcG.5U_E.>:;+cX,E64&1>4J[0=<Y6V&XSST&7f<^:P+.6GE\b46USR:
#_S,a<0L<Y14MB[VRE/b?PGQ>K^eYdI+9#:AXQI]]9P2#<9K<aL?c/2),]:S8B]6
;[YNQU0Y^?YL9ba4&UZ)aQK]I6f^A,Z9GfK/AZIA&I6bD:U==#_^d2K#Z4J,CAFY
f0ZALMVG6_-AQHLW@FCG;C_GFcZ,,U:=f?E#bKb6#)_/P9[AP\:E4ZCPL?^UE9(A
TIa5&]4=[CC^MI_?a[/LXQSe-FGOEg=X^b4#\.NNOgH1JRLYS-@6OKOA](.T<@]F
HR@5=C&(8>MG?G9#9=ec>PQ=Ogac&EXE\3<;bYVO7J0]/A1A)dTR/(/3V:NX0X(8
[VaRIRIF;95ZFAKAF2E4>_.LTT]gX5CRUbaE^\</\JODO)4(3O0AccAgbN>HXc_Y
73eW:3&H(<2SKb1O]Z<@->W&VOE/3I8ZIL58[a/.KCe>/WO\Ndg(-C:2<(R>DKH;
:NUB/K>JXUCaBD;7gB6eTC?9D(U&f:6]E]./DPAFa:>WX6+VHTDZc[bG@GHI8QJI
K&RE.eZf8;ES1b:P@2VVf(B+e_Id0=65P.N7:;cW7[ZDM>\R?G9bbP9O3^fFMCY.
+-4F;;M+;;bA(b;C7Z;A(KXLV(\^2K3V:XF]?;:H[\D3923dJC,PS.U3(086LSQ,
cA78L)fD(A:[B<OSUWF)+-SPZBgOK0@[KIUES?]_6c=T1_M\NecKbVXCMdc/YHN)
.YS^1aVDS<)88+E0)fTe5,Z4>a&@+S;.BR,FA8-A\/7_LTBK,[Y.<RGFV7.F,b;d
HR7VWdL5/#K#W19&RFQPIIKL##?ZS5_<QZSLAQ:)J/;JWW[bAVW,FDOL0S_ReSF3
d>K_IH2Z:TO2Y=?[,<aBM?5)WOY1HEQMG^C_Y?+CWQ5/GLBW1bbWB]SR/,BJgGFZ
BLCYF0^^0FV5#<Q37E10d33a85_O[c<TJ.NReI[\A_1550E_d,TR7,MZ\XW7d<U1
2K]/K2S)TVgK36LP;;aI5P5ITJ2:/Z01/?V?#Tg\[)QRJJW;@1MPY;MGIU2RS-\g
(M[V=-\<J03H+D]JJBE+27\\7=6)3@64cK:BK-)7RBG6HI0bOWN@Y5MVW2d6G8+2
0DO;9H2eBV-+J.)gIA]P+IM_dTL:SPcC,J#(^F^(AG_.41]Fb>TcI9b]NC1;IJfO
J]-gO8AUc[]HZGS50/2,=PX3YB/b18A1U&XGHQ88gbXbX=b=Z@T3gN07:_V<a=eD
Oe-G_\(c8S7EJ#J?(M_Mb()gNSSDPMUfP@()?;c1U#XU<^9C0YgPGH^;3]R99Za[
OH/bJgPY^c>Sa5cI+0PTWHL&LNb^)JE8gNff+2Oc7,^=ISTTGD\.?8]_d3MM\/<;
aFCVBIED\C\;5[a5>TZT)@T]S:362/O,Q8gPTDW;eGA#<-:-@LbH<VOaK2QL?@RE
6<&(-J6XeVd+cM;OW:0T82S_.4fFSRgAPd?;-M:6fC1^Ye6OC<DbO?OKD#EHY>\X
F<2=EceH^gL384G^QJ9ESFM(C)WEg#:]c^O/gG)JY[ZQV(?aUR>;b-6b_cXT^2E;
9bQX7),faRg5F_e9YYU\S=_DS8g2Z.f_HOUKSTGaSM)[ab_1f3-TX/TI^R+b?J6V
@7,>eTHNd8<Od#DVSUTff7d(,3P</_;_KKd6JcXM(,&#JZRCH&Tf84.VEPDbe,4T
?(fSW_X3KV/1ESa(2NU\)FIgYMVgSQ3Dc-(\X4&NHFWFC9B\LOWA?7YQe2Wf40KK
MMgfAJ0U/^Y^>[?/G[2GccP0UZ?JF>FBX1PXOddJ-=58/fGbf6be_CcRb1K&?UcR
<-D]R5?#[UQ(:QRS:KK)<=^63;Z[H=MG]@3#9&0_F]5.8-P,b(fAZH\WBXTN?VQB
#Y]fOT7>SQ<D1);J):K38UgG;>J,g1Ae1;N?f44EYI29TddaOP_8(V0NV8+B23aX
ddA.?LO@2bLda\eT7+,<\g<QZ/\G@=@/?]UWW\HMFH4&5f4B\KL>??>#5/.]WZQ)
ECDdMQ+F-Z6a?T;&M&cF]^F#WaP,C4<8(a:\e=@R;T[\P>&Z01HQVF(Z7HI<cH-#
2VC]<ae6f454(cfGRL?&BW94.])BdCcPIU,\bN+Pe#b1IC:PSH5GLL;U>+859;:N
(30EFDBU<g.D-F9G\I>BO.a?3b@4WAZE<Yg3YRG0[?e?e-C=cRg2>dMLGWUPY/N[
7d8c-MCfa(ZK1:,Mg9A:TS(WXf<6H6BNVI_7H@(=E,GQ(5&5)c0V,XT34D\7ENB:
?+647BYBGL/.29a[Ng9A[\Q+0bUbL3Sc+2X_4b&N:c5ME[90\>c001WV6(.ES\Af
FH>^^Y7\NF#S9deHReP+9.=2X2b6>ASXR[R(B_5E/A),H<G;@fYLf&7TZ2,c6Ab8
-(G?E1T:<VEga03XDA(HK4-QCV6FT-6Ufg:J58JD))UFK(gWBWWDF:HTB^9X@0UU
,PRNLBW9KOW<S.XNXXDE_@:A4,U7fJ/(VZ94?a1ES#T35>OJ)4[Z/7-Ra6:(?bRE
?&1WcM@)X0A[AaVVKQe?>g;0GSLeG@X,a&;<R68a><AQ-#0-49=/B7-CF]X.1d,]
De<Q,(:aLa<,UeFZ+0DOQaG6Lb:(#X=(0_8?8QEeH^gRZ\NOY_@5;X8_T:3:NWFS
^GO<HT[((T/,.>RPO<SLc/:=I)=FE,1A?.Y-5D:];#7@W9Ybca]dd-4F;D6Y:Lc,
:e@TH_]8fEF7D>^KL_?4c:cf6<;)LeI9J]SD@)80<-8U]9Q.;10b:_U49B6Nec+7
ae65MQ4V4M9T24=7D/,6IG1C_X\gWW^L@8L.4DY6_1)f8BBX_UgE1-T<+MgQVL.U
9dVU5LF0+/XdF#<AXfW>(/_+L@]],.MIc90SALQM70-B86]:)?95BfO.:b>5^;,g
bER:1;I94XX6[6>MK?PdTgR>TaV>XO7/Y,cSB>65c_A5F0HU3.>b;#KZW2Q#2J@c
dT\;0&(<#MYebP.41d(RG.@8:DD)-3Y.@X[Ea6/EGN@.2A\3[FG=SaI[gZa#c10,
O375acH\JgE?GgM32KDVF?RY&[AI(NYA7a\_HP>BBE2#(5:<b-#Zd7Bg-d_2gDRK
XFe9,>#6[A:_7=/eB-LCVN2,WEU;]-;C3dJ=MD-6(?@3X6M[E+JF:3I3.I[?;E5M
=Ae(CPZ]P_.<)6=W+8^g_d>aFFJ<@V=TIA8-[>G:cQe/TL@Mc5?Q:G>fCQYF)2GT
]+:5N,6SHDTFA(W)Z_EE7-4.1,?:;4K]C+HAaYQQSO3;;c:&WC4<fEbIXKaZ)UP5
UdeVB8DB4)#D@BQ2WMG6e;(D;RD_3UZ2OOXFcDTJTYE)3JF^Wg\MX(\L&A#A?GZc
6M;73aO5)7;/8?ZYa^AU&?SdASLAJ?CW,MIP129gXYC\.6UAN^5(UJ^6-cUP64Bg
d4M.GJ/6)V3PP6L1=c92@;)N^VG+C09[N8GaNH)MK;E#>IOT)EG,#&c3FIU^>&0P
g?f\ZK-(YA>_c&-^-H64-3\_IaT48GX8cfJW.0H#YBC2+g^OJdeaI7:6BFbfZQ8I
<6I3aE4,6D)&ZefBH<C=fWOcG-(J=gZP1;.BA])+]c-5A4(X3_IIJL\(F_L\\7R_
/77J,VF5\TQ0E<]cL=L2QGecTBJH,,X\9#?&IdcRb.XIaW?DT:<c@O]f:;ZPP]C8
(\eN212U+H?CA#&(3GMeBA?<HKSN9MBJ^O^6+38@2.)eS-B/Z:4C1YOGU5&LMLAF
^@=6HS]5)W^E#DRH&\=e.CD20RM8C>)Ve[M-PMOf=B],@A0c&DQDVFdKYbY<BKTY
?;_FT#KG)gZGI>T.@LCA:M=gYJ(RJGP)+F),D6Wga43?R^QcL7HA[.#M\;NDS8.E
?cNCH7f#7;O_X;@e&EbI001RDf=>\KY&^.5[5:28&I(g3U[3(L,QSW#M4XD<M507
?e7_^d7VMb?f#VR:XAZE\Uf_6#IWO&3a+R](+@eQgWKK,cUT2SN(N_#aB/Sg=WO@
,6G1ONDT-@a_24O/c^F8=A]cN/GQfE#I:-MH;aM4K<R[c9,eb\X7C<9>M-?>1RNO
cKSTT:a^3fVT4:06c9Q@(bSgAb+7d0DK#49G8QMVW-<U58M^ETJ^6:@:g8OfJW:;
<cgcQLLFK@QW4LF3a>9<PIcX&2?QLM4+<_fYZbE_Q1dJ)Z<5D:^Db=,(c[;b4Y&\
3A,\)d9.d)B+2<#cfBB?ECEDM1I;f>QGbJBUXEJ/E>KXR452OSc0;?2ec@-?886&
b;BA0#V_)CTaJ<5F7e,/c];GE;,cYX^f6.E\V)1cJG:#Ja,.,R20F7^83#CB[Q&W
cXAZ@H6>67X3I.M.V@W54<f)1UM/1R^7d:LP]S]-SbQab.a.YBg5LNR;+G-AKPV0
4[^R^GZfYHZ-S?\NgJJ2K+)X?/HR;DCc7F.=B\g5>.;2=57RG-#^07:H[e<ZU[>C
G_^.6eKd:&#W/.H_^V]1P2OagI>7<acH1H,((>9K7-;Sg=AIXB9@EPS,X8FIRE:(
BI7QO9EGHf_W1CYFO1:31]8I-#:X>\VR\[[CD5T^bgJC4T#B\KW;fO,D;g6F/\7+
K7_-\LKeVF>S=JCB(1d/Z?G<MVb)>>I:KAb>M,ME@>3TO3CQRJ4(Q)+4gZ+&\WE>
\FEF<<,fOG>66G.Z4OK0&bbZVAYR<\\4>@6_L^PMfP+@JQ:+P_e^>H/)FTN72JV(
/)EPU,Ce)9-08&4R<7PUZVRf?^gKd=#5M,;9UM6#-b,2O4+>_-/-HZ^H8fG9K)MQ
+3;103Z@Lgc9QN.D:)HB@g)X[P;\b]#/9\1:YE[H)4S;5U;WV5F78,K-.OM5TGV7
@eIK,T13&R0P^Z-SK\bcJ@dcE0bLc3b1@N6Q2XLfHY3&6]LD+\9R>J?f&X\_9O[&
E]<e\\#FC/TKIdYQ2WBPgW1W&44aBZM7?LSa<?541^\6&\JN3+=.8YV91R]L(4LD
)[:(Zd??X>NTPf2aGAU/XD=-fNI>17bgg_4g(DN?C5Se@,ET)7WWD_5+CI)^XWeb
4?VF5@U:-3eQ^Z(VNVgd]+Bg0&CFY]B6a#eW&(EfX)DO((+<#VS[g>V]#6RSOEYe
#JeY5ZgQdXQKF@G7S/_.E3[9:[A(?9Of15IKF=H2[ST7c^GWRMYdMD((=OM_P-QR
(+5R\83K&VWI=<d@eP^f?,Q<(6BO+L#_U>d<+.M@df05XX8/2T8)8F6.gA1P\T89
UZ0K96[Sd_/<90b111EE>5&;-WF;,>&CfS(9[0DW=](F1@M4>^_D@(6K,-(L9#f;
.2\ZaCUgL68?QP-6g7eVEb2=cOb2dA4QN^44(_<0+5KJKSfM/3=/061UDfDPcP8O
#Hfc[_7]2UVZbFBZ11UeJ\R0CQfBT3WT5\e8^aP69MQBM^d/YIde\@1<ZD#fSa,A
ZB.EbHS#a.VPQJ#0,8.:VVNOIZ^A_D@I-4?R8441FgbfB1GdBG?,JZc\Q=g&?CU#
.Z2<?/VD.f\W^#fVV>TD;X/;bM33?_3UMA_<#Rc>O9KdJSK4.LeJJMZ3VAa^HA+W
7=2GDZ9LS??KRT<Z[#)V\DKb>EM9eK,cD6G#Fe1FJK,b1g^a2R,J5&61#X3:3(1?
eZ617S\13dS_D#-2AZ=KQ5TSUG\3)g95K<APWI3U&H^+XPD[6b:#@cX38Bac35H8
YVQg1><e.9OT/7N/##eHW-8:e(_(.gWaN^:=4C+EfdFg2SZeaPdDQI\fMF<[OP4d
DS&L@6NXOL)U0ZUT-.JQ=T^&LENgFG;6X,DO\ZKW0bWC-Q9,#:/ORVCZ@<>0\/0[
NPHE+a11>&PT&:e,G37+\9CeYT\(P@f/2<@K::,]HcKg8HIf.)G3eJEG+@S3ZED6
8K_);;)T0POL2]aT5Yc,U<1eX-_=bKfg:f.BD-e&G40T3&-T87AO&/(:?,4)-#bI
,CXRY,HO0bGA]D3B/)bB&]A3,S[=0#A1ZF720TRILHZK^eEaP1CRP@S#V=/FD?1g
BR@TE1M=c;g_[Q?=gAW#Xc_NfWP)cg)Z?20#RMa&fde5>-1H=X-C9ffA#)UZd;W8
Sf63NO8d)Q74F&TLYBHZ5,\WgWL0[V=dfVKUPZe--\ObT9T\PUPP3)7d1^:<[^-)
[LVA4+;ga-PNaQ,?B1-C]C9G&V\,(1FKQQ6cfIB(E]7GA]3a<YX6e5PWW?9HFe9W
XJ4P4>0CNB2NP5]Qd89GFH^;I[-d58eH-N?K>13_+7P-TR7(cK(TN)X7H;&,SeGU
J=/S7F30aBTga^ZJbU?DTf@Ra_EI6E.1Y+7?P@4c[egGQR<4d^Q](?&aWeaV)ODA
73XAbC7?R?g7L.)T&2IS=&P3[\g:I1CU1GJ=Uc=:+\GJL.>=_/<Y.UC+WAYTJ.U2
&T31ETOc[B82bA]\fSe?d[HH\[6C7V?Z^;1f>gJI;G^e1P:-8G#5ZdadC(##X>V:
[.EfEf;O/73c9_M]YIDV_,?,CQPS.0;dVL[/K@B\#CU=)K[Fg[5W?L3[H@[Y3Yf#
H7/5-KCcA7=^HgOK#b_<Hd\858gT8J6>\Le./J)Z[.<0)<]<.f/e,T-U2@7^V>4d
&#X36HZ4e6I@S&OC+LZ0(@g=d]&9R8<)/;:U/6O,I8[192_eM)-UN7aSXdFb,6+V
2A),KDY;4/;P40>9.fA0#?HA/1R6U5O<C&:9/OM6&cBg>#MB56P+6Y&Za6]Jcd[Q
)VEPT5cacec7IJPg.:1=[0R?2(JPGO+PS0#T+O\LKJZO131LME&)YO-NdBT>2&PM
)Gd?caQA>TBH](P-3UMB,4Gfg>&I;g#:./VW:SfWH^6^Se\5E&DJdQ4]VB)JLa??
&AR[8DMGbb]KR[[I8\g-HF,Q2H=(CcaN..aJWZ#;RV<LG5f+M&KUbNT7XD^aI\D\
6fSCA>C3^2JVC<DDJ))>We]M2K&LZ.YM42-WG2IW9QRcbg?MO6b744N2&#Xb/^H>
bFH^]Q)^Sd&VfQ<a/:&<QGBE\7-deP2YfO^U4afO:VX8T;d9e6=3>:NKVAO1_H>,
dGOP2>4Ic@/H(c30RA:PMI0WfH<@CDD8/Ec/GdOJDV-[YOc+T:9fJ=2:+1eEXB(&
+[Xc7B[(+CYK1(/dH,fd)9eZd[b4[c@TT.\RO00C<U\.GecebD4(@AfCd()6g0?T
Y:2ZRZ>X2d)+JXR?VcA<]694#Nbe33SY5c#VU>2;)Sc]UZ^X8Q)Y_L^E2a/1YX]J
?(^R0W/3>4,G1.VDT.K_HIOfMU@RLEQ\(W@4[,(#,C@V.PH9?F#JK<?2LF<DL\O6
9(,eO+?2(b3]HBX3c5C:Tg64L6;B8H098)5Me+;8#EeEZEH1OPG20dffC==1O>/1
H#a:YNAE5#dD9Z+F251J89Z4[UaGP48(_LF<]ITPa[1^_2D^9O(If@?dCdX?JU&9
+((PFRZa2NAWaNU?cf.@_DS1?#3VUA,F\XPS5^HU/MB2V-AH2_[cCQ6I/:0ffg.c
F&f?K2ITLMH7eE=5fa#RSTEC1U())#J>5DA+Q:(W@0_C[;d8KJOcYVag@dCA9;,_
FfF=4e+EOW<]&>,_</P46HDIDf7c>\)&<>-W2)63Od4SOQR8g1YZ=PF#:-9)#U8R
HfS&1I<ED&]A#H[U5Wf+KOJ:_AENBHDS5W.@PaM.W7#?Pd/[e=7fP&aN7;Q@D:R^
97b[&B9HP[Pb?0EVVfcOCb=7?VI4HH=ED>,ZYBL@WWJA#&=ZTIM/g1[OE/HPPU;/
0Q4=Fa;6@LaG_;-3^[F,1B3(\fHQ/:3Z6L13P2C&PK0+DK/0#;=ET#8Y=UUI/EC@
D3,))+dXP_eL6S1LFD5E#\P7BBP?EMLIE:/EN#@Q^1ZJ..L47cPeG9_^HDF<,GGe
^(cb:0TI+Z<PO,BE=Q8S4_QVfedg,gP3<2A8a]X#R(3JV7?g=I<=UL))>?E_HPMQ
+0bRS0;))@RLb]/6/e/FX\FQLWUDP,YWfa7385eU?3>]M68c38I)2))H86KI[XAg
+d_N+_ORbS.8<DDUDRM2Jb()QA9<1e#:7fcH.dcBb\>E#TJW4Y)+cJ<VFKMPAaLR
:QcXDE&G^ZI[,BZ2VVB7HcS?RS0[5^Zf8UD#c49;Y//119TM@dedbOC3IY5.SgGc
b02]L]CCcV^0aF2H(A=U-?=E\X-IFfR6#\497?-gGb[L>:]ebb)gg+Z5b5UW39,:
IH,KdB5TWa(bH(G;?9R2]gYL2,Y?c0&JR,99@O;6#BE-Z,.[a2c.Q@(I<1_+WE\:
gBF08A+f]<aR4?.C5^VC66e/BOU)e=6:edcCgQ2=5L&a@bS)D^FDK_O2O[<0]+3-
&K2=aR1.L@3D-0Q:b<WXdGBOaFD5,V<g6e4M,TR&cdDb+e]<&K](/>7O#H6^_]eK
;PX<68LJ^LS79<Pg5_L#e9G2OE7E;A;W1TJ)-D+[4/PaHE-;\_EU?9K2eB9+>2?]
PM23:IVbHS]_?B<T>Y9_bAK6gZ:O.N7I_a/X_1ZaEW&@QXX-f-&(K_I<1E&C+-ed
76Yf2O&f+4=NSL;JI=;NQG=#f>gOCJ3ZTVHX3,6+]2.59THZd[M8G&_BLI,BN(X,
&RVZI8,<30_/EYX^G+MY98G/b&eB^NDc&e)^5V=JD#ZN\[<[[e(WG(+Q.TIF(D#?
0&3J9NJ2V++M&I[Q0)UZN(<)4eYETJ_8\-C(c,+OI)FQ04)3e_ZAVXX?B1,C10-B
YK+UN^.eK3=f\T:HgJf3L-IX-g68[gW[)H+=FHYDVFO_eSU8P=7=5@G#U56TUN9d
C7C:0e\+E#beNWR)E._E=JNYYD^#(:+IBbAHB;C]MO-S:A_+5B3@+E@d_a]N_,8b
^W5Kc)d9gE3XdN:2YF6S]=WY7KHI.1NfedaYAU5(C_0cH(5;_/1V12]/YV#2T,FE
Qa;5_0SW48a:3a1=_fL>_^2GVA(+fe&c5#D45W8GGaD2:c4G3A8/bDgA(E1dJ.YZ
eP1a4KO>eIPX6g2LV.VGS\d,;Rc3P\2_aE=<.2>6FM8/O=O-4Q:33b6/]>;_O.__
_Tf0FA&0-&;VMVQII,S1QZ[PYH(0Z_2;MA(?\a^1_e9<(?WMg-1SN1GFPZRS3VSC
a1B4^_e),+^1TD#g5E:b\RbSOGOd^DGNTTL61OffDRHWQ_TH(<X0,QC]^CQH#.?1
++.f8>\J6b]\5.H@^MV>:4)H.+A4IRIR^:bY#Ad8X41FAa7T._,/Y#0^aLW[Y\aI
[.;:g?PJ-N\2(:/aC>c#Q:Y9fC1JbJ_V_=\gK&<FO=3U1(.B&4\_1S-cM-RR(X6Y
73-FZ6df>55<F8f[)7#,JJ]b;.>87g@K?/#?bR,XHQ4YKaHJ#3Ug<gZSG34J]N\/
d7.D0DV1JOR]L,96Jc<3a.VR(2-QJd-T]F4X^?6L(=@g-YRVd1J/WSXD(YOe(,OV
HS#_G&a/TP8A=(>8DaAD/F8U\ZGBX;+;-0d[M@Wd#;b=JRLB3:Xff55)f2(KCI]J
=7(&)P@836##fabA&VNIUO)YedGOSAR;\EA1^XcN^<Nd=M]L>YTf[Q/KAHI7B+CH
OWX77[M17&O^P7C5JNG.baP&YHL<g0bX:Ae&6cVfT.&(#^\^48/>a6=L#&,\7)AN
ECEFN-)PFJIT42g?Ubfb0^<ZB1;c1DA8b0g\2IcX-EbQ</Q6OQ@>:Da:8R^^@C:,
O^8^AgI?#T5eR_f+LJ\/).Y=deQWf1D4GVf_G-Y<2NF^@0Rb9f=;#)6<IJb/:YY^
]c.L1DBSNaKd4?NE^BTZ#8:;B9@@G\@8:;HOIeII:J+VDb>:F02[AWg,ZCPQ<.Q/
O_S-&WQ?B-+[SHfFR-IZN[?520bUKd&5g\<OGbPNE;.][LE(04,g11NL=YKXI@f]
G]JaeW7\P1e-\2LKP#d]O#3](@g58WZ,<G<9D/L_#8,Gd4WB(Eb[_#QLcZ>P:Nf2
1G3]eP+:<;0_/M+_^/_[T^Nf[:W1D9O,I[J=>XO0XCLRZ.JLWNHFd#;QSBQKE[[;
Y#OgN(EMdWM^I->bF:?daD6c.7G?.#&:-;X4cJE]/)]O0=H+L;.QM4O5e_66KN;&
1&ed/=VH9bO8T?&P4N7c0ZX1]C:CJ:8Zd^L_JT+_#P>-_QT^cJY>P-&?XS85Me;b
H;@Z@:R\WP?aY,@72\9XPHG<<K?JP&ALG&Oe=eg&.T=d]WdADa.e0&X.a>cdDc87
^Xb\<#adgX,f&Z4)C5S#SXbK(HL(f]R>J/TP22a3d9E6U7B?ZadN#O.g07O;F.-<
(7M+7#LR2a(US:K)@QcT23DUE_gFS\OYZd-FF#,SP:C645MP3EFDF96UR1A^H;U9
CY=\NKMGMJ]#e<c8UKR^XWO()U,YFX7_K2JYL0/KfbaV-Pf#6eKV9<];,0V,d,:C
gae1]Ob0DAJ4:WTL<\8+gB>DY9O06[[bG>QH3H#1FMOW+9>\<=@(BQV7AV.b?,#\
<V4LFOC^6)c[G#R=bSZNEE.6f6b(9eWUDQ>9AT9B>H3I2d+&BY)e/LdMa>=UW<JW
0<0S961_N^J[[;N;GLbWG5SUG+^G,-MX2^c.=FDZ2?eGS7Z(J\67^.;K&Ug:DAD7
E&5aW(GF3^:#SI<Ff_EG7>239S8+I7EGGH.FK@fW8QDb9]O0+3U]I^N\;?H/c,].
Z1)FR?+GPf3]S4S.^:@AIG:Fe84:]df(&a8e67NgITaHER3V&+<.3FIY:cNd;7-f
K_+>VgUW0./YJMY6H&&.:<H14?J9C4]C#e1:a=4JJ0[8VbacFN(_QKE>YXOF7O,J
@\7d?H1?PWE>W^Q?<#NV=(RN3)B2<4I1QLFg@8a\XN=[Cb=ccN2O]D0@T\&FK#.>
+PEF5XJg]ZE6[;CW?\bf68gC_#1/]J@OK&d4J60&J.ZO?Ng6W9VeHTL&>/B?#V)\
f1>G=XNdVP_2/:T3)(aeV@A&=?B1cG>af--;Jaf;agM:-cS;40V(>8O6\M\+?YN9
/:2.0Z<P\\UD-M6c^M4CN.D.>&c#2A.HE?>)JJ^.0D/Q9P4+V)BLAD]<-AUbW06]
/AL0HB2e?H_((7Y<([S>Y2W^1^7<b>Sf8.1_dTU@0K:+V+I/W@BBX\6,NVIVE;8N
F\ZT.0R]LRG2PZ)(LV2<^@6dL=T6E:2?V?J@A=9X0Q55><]cJ]Y+8Cf_9bL&c+DK
_D1AF0T5&AU)\E/L9X]-^^BPF:6R4?9;E5818,F=e?D/aK:21<;R2K/-=2PbG])I
)=T]RQV;;3(aNBIf_:(ZF^215Q4#8EBaR1GNJOC9PMT@MVeca>7f@?=P2f^5=S._
FX\C4##QJA)=A=M<=Y3U&P5aXg@S\\R(e=)80Kg\Y+91V;cC;WK+YI<33bH3GA6#
V]F]&@&+5DaBCaIV3#PbTZbc&_N()f^N9N1AFfM;OFWLA<4Ad_4EXJ(8HS\W6]F&
1[&,KUPG0D4BKbE:cHIcS=W3Q&CO9abeZZFZ>E+\JJ;9Y_8RB00,&\2;F[C.Y+IU
.MM?^FdLc:2H,(VQAVYB0QVW/I9Ie^LMf+f(d?2fd;)#f>;Qg674ZPa,HC?JE?@]
.W/@U@#d::[#ZAS8&BM3+L/B@edG9Cc+_-^Hd;6a5(a:HT@9BIL:<B.H5L&LB@JV
Abe\H8CK&_^ST)J=be74BScD@V=40M08NKd>&<cX+K]-(gK0A6g;7bZbZW;4H:>H
=XYNb,)JVSgc-QC0#R9eE[:PN#39X9B9W]G\b5M-144P?\e#A90gWdYIfP,XIJU]
^8=TdXV3H?.HI].ZOU1^a>]?,\(GFRRD][\8#)QJ6Z_RD/55#d/>dS1L1g0>N_Q1
@VIFX+WBSVg-.Hd?V[)HD=c4EUf,?YUV?/U2I4TP_YJ)=[f3>I#gT3aMOdf)F\]<
1^\+YH?2IZSE?M8db&(VLFI6d]=8JPWE#UJ)N#1;QJ(;.AD23\2Z_B=V4U/?I2X^
e]T#\D^XLY;9.T>3.BM.S-NG#VZMUWe>;;Hc[1Q0_&;]\_06:M>HT=E1/g)JTc1J
3[N#Vc?TeU8>DV>HB#<4GJd-gde1gT+C5WIdOMT6D802;)VcgFaR/W.=KNN4RG@&
,?d0WDd3NN[d.5S4>QYRe54,(P6c0^c.0c-.7<Z8Y:9^3Y:S3QHbRWa:\=N7KKaD
:B8a.:J?2F?PTYTO6fW.2KES]ZZCH,#6Kd<M+;?+.O6=:TZ9e12e&c8^c+D7&K:#
>a3VbJ)5__XeUEU3Pb_RUE7cFRI(7A7#6<3YdWEU,FcC[P2f^N6MJ-2)XOC=6X0F
2.66Hd<VEC\^/L\69:fD2NR,bMED+NF:XO8D^F1?HL&8G9=1dSIMPO5Gb):L)^\R
D]4.44e:F6f,>a)1&@U3_VMWZC21?@.;BJYKWC:Y(K2da.=<#/3E2)2LTE-1]CaF
###RKBNKX<MNR6#86>bZRDOIVY_B+,cJTBUK[K75c>bdQ&@P>M\MM607Dd59I<LC
K^FMb8E<6YV=P+R:FWc]1=-R8X?5OV+cOR\?54T,IMH?gN96R8,;>[d^3^,78ef&
0HeEbPTe<EUVaa&aRaOa)J629@4&L&I(J&@fX(?.^2d8P7[>/;A+-V3R8&U=]WN5
>8cQ<VRcc&S#Y/,TT-44<]U70=X#78+cOc7>Re]Y,_+(J>5]:XDVKX[_#WNL>E3>
F+50Y:FI(I3L;H4WEX2P&G>I^^^VDL(KKGF19;dW@QV@2&^e1@D5e:5].W;A&6G[
F6<XN9J8^(FUL>#PK7_4D;9(-N^KA)BI5a;0F1^eEEf?\(f@E.8b=;GCH4G)I+9X
L<[L^/[^-D?\[6N.H6PLJ:BfOVD[RVF>U7a11FD&ed?@.)3NCH4S+gYPNS881TM-
X(Ag_7/[0F-K2A+W^0F^-CQ<gb]d<#XA\^,;\#:<82aLVKEC>_1KL:,?ga#_UTBA
D4?.KWE&.?0_UaQPA8;OY/e,)?eY&ITfZTM7&GC/_,e]E3IY7V<>.1\W6b&4a5g^
ZF?&C1?1-aD5@2K)gWYg[;_<<[(PH].+-D1;J0P[Y3ED5UJaG[;N+CJ+O6S&bJW^
R:ZHR69QB/4d(J3,^B2+8BFCJ#?5=)/(J;DW/C4Hc^Mf7GB:fY>C0+WL4fdNR4:M
<PR&Q<M0ZD^deD&fDIXA/-5[OXBE7LM)C]H6d&&0)g<VX.X?08X8O76T7Q;_-RGG
RH9)3gQIIVJ2E&LcdK/SCZE]Kc&7@_Hf<0(^<4Z0?>:/F8,>0D,<SR1.3dVQF0-a
W?(PX9HPW&IC:-7ZNEIf4M],E8XHJM#/R9?]-71Q]/gNa?5HQ@WB[.R8Dd<:eMbb
L0aJ:8,TKM1WfD1e&ff1H3[#MKG-/)BeIGbD@KA>N](CUYd^V^?-A?IS:X4:_dB5
#7MPEf;E@?f48B/WKZJ^g)A0?)K&SB<d]WD+e)#OY)YCb)Z2K4FW=9e&7f)f4AcY
aQ,-0+^62&.P]PL\AI6Jd3AK(=.L_W/XdX5DeT)#B(UY=^&?gQ82-#H2U^E/^[8>
BBZ@Q2+QN;===60@A6;.E34(G7.[]4K^A#/UDSH8C@UL5GbY;1L3D.M>9?\N<#<[
eS\L#_?.K^F,2EW[_#-cdBVX)XU29Y2c&aVEID&H0cU3WO&d.T8N<QYZ>29M3QS)
+ZQUD2.:&H&\#-;F=Q?C7BWe,L(UP>8-EI(D].;ZFW/1PPGU4_V3XY;RY.N6aJe?
Z27]aE,Ob1Q-\@fc:L/.-gXYP5(Lf2SR]JIYYS3@;MG+5Q20YR1]LC\-KOSZ9R>4
=)FKHTL9^LTVgZWBQTZM7WL1)OaL]e>5IR,;dfP^V5H4bWN/YJ/A>OQ2)IHY#2L,
#?\QA<65_B,J-XVEIOLT2?6Q#\4#1_M2Z^X9@8:PY\I&IU_^<<3=a-N3)fG0D>0Y
RZ5228fKcVAB<dK\5fOb\H-bBUe)FD^8V3=LPIUa\=7XF^g(_aO7D>6?e5HS=1SM
>Y3P(S#Q:]SCKR=LdO_<9b;MU+I23Z=]I,Zc29@I\g_,220/8ZNY692EC)WYE3Lc
-?,b#_ZaeQGPUQ2b@&6,Z5;G8QTG)S2/O&T]F8BWGEIP\&<e5@7_[.&)CAS@FGZC
N:_a^.14,;_YD3YBFgbY4[>cE/VA5WS+YR;H;#)cP^U?X;9PCS_/H,9c+0/26Y.H
_T4QSe?5->CLNN96Q_aJ16;A?XBZe-K^-d43^0]DIE=0FbY#CSG,2_\?KSWXcEO\
f8Hc+@3P-U(?52g?/W+_K8PH2/TBLaN,RV0S#)WWd49JG[[XL=)c1&dDg67\FFC>
#1Oa27)6c[0>>fdb8@?Hb](]KaQeERH4_g8@<1#Q>A0,<S?8D?[W_>\MAD-VR5PA
G2OfCA6b/b562WV81;-W&YIXT3aYH\>-U3J+6?525#7ETO;.7;0C1aSd,77G=X6H
e8:<R^@_b=I;^>,0Zg><=P[K&&I9?/_S]-aKE66X/&H+7UO?J+\6E5W&PXD&4W>:
@<.0AWES;A3HD(7[d;^59?#>d;>_9,[g<)3e;W,3c]:#49L@bNS2V:bc.^//#E&.
M08b=f7F@ab3f3H>9CgGANM-?Gd6+#Jg[<YX\&2=T/PNeIYg@/)DG@F:)aDGB\-@
54LR::#P,UHXK3VF;0]<[Y_[L[egc9:dZ6KPI=AH^+3PP+FM6L5D+cHGSc-C-J=/
#LgA.H2e1.bXO(c@3f.EaZV[O_cEHO.<I2CB;1G#..Xd[4^LTN2P9d8cH=DV-&f2
,L0_4)TC0RD;4\V##84?2-Q8_5,(7;0J#X[OYHBgM_dATV?b6d@L\,a(B^a]FfJ6
5R-^__@OMJX5\.HLg+XF#G^4OAG2_S=JVXf?-6a_V+N]c<UGcdTdINRQTIL1FR4W
EF]V0dF&Z)F:L26:5EZ3B25;a3,C.I4#O/\^B7+Ce3EgQ,S8R3EL<5F?IHH;B3Og
=>\14Q<;-6+:^0,Ig?G(?)FMRODJL5P>E,M@F66c?]><87/X4@S)]R353KMdM]X6
.UB5ERB,3V6EFH7<aJD)#NVA3Ff)6EGP7WKeB.I@QVIAF.2G;^<A,C6>FaE=7R&0
&&+(+EU0;1??J10,0G0cN2JdO@cG8(V_Wa_A<Q<gHG#7a_O8+Aef^/>EQ:\A&W08
[81[B2L_2TJ6UI2^8I_UC;.(\QeVPfZ:S6Zgd)JJU+]^8a-T@e.4<V(c)18@La\[
ZOY3Z).-B>Ycb(gBR?TA//eX:4=DM&IMRP=:X3eII23Y#d5Me;I0T&cQ5Q?cY[0W
KCYAAd,04NKPQb,LJT7QQ>dL&W^(Q(V,\P(9+\4X3g-d_R<5b^@GfUQgTPK;M3H<
34fSJX7R?SU;PSM^5OP[7+PD@QEXHMQ:N_H,PgTG_9<\?N(\O4?\S6O-a+NTT&AI
/Rgb3[;2U\6gG5:(gGPO3dF+fRHPRW71)8SDE2K,SJ5=,05H==6<>.O6NgU.PSUc
NZ@1fNJBc<57VFZA[Hd&L\P6?#Ff^fQ//9WWPKRDdE3/RDL<Xd&7gT]]AFBFB=eE
U^U=W/C0fReNAP]fY6/bE]]Me.X\dG:O.@4(H(Q?;IE\XGRRRXYO=5^;1)/U:_Ag
ACNB>cKJ=Z]&([[P[M9f,c8-ac_+44#I^([N\.>5+,?Z..6]6_;B+.^@_O(\;&D-
<1-cJX,B_\Y3[F68ES4BJE;42a-7^KNRXELMZ:]2KPJb698TJYPH)SEW<TWYP#\-
dLUA_R1MZ4R)Ye:I#TH2KW[;;8P3&E54[d/Rg;7YgP?30c3WKQ\KQAb/_ET^\SD6
:6b;f8U4F7IbNF-<DQ5UE&E/7?R<5/X0/C2Rd9[b3_3CY.?J8Q^c5@W)=UJfc&d>
6C>f_Wg2QDb.@aeV..GS2>fYT@0YSO?BbLMWY&^^>^Vc\P/A8)cY7B0(aK4eJSIV
+/10/P+:HS2;6O]SE?9__#EC/+>b11?WV-V-5,.87P>f:,fJg^>S6(10M6?b&da,
3C[O?VLdDZMZ[UGO=6dId#2E5YEYQ2-.bRZ?gNL<57(DXS9)9EeKU>ZcBG_>85YT
SJ\:e]gfZ;GYfTL6)2^::YWO+MdR2;#YBbH5N2X>729@LH09]2)/,YOe@E)?5X</
7<;/Hd&\EU<LCZbaA]Y/)#EXV484KR[XV6cY9DFU,=cGL_L\T]W43^\\IC>JFH;\
2-1F/_)9>(0MQ0&2(DN_Z^^/ebT\(+IUd_+>^H<Pb&bW^49[I3MCQ,&2-HT3XcRB
a(?9@UGZD<O4R3[O287bRYQM5Ug[@>\B6U?NK^\7==VOb/bWP4FZW[4BeB_dW)MX
AF2NgP?MgH[2KV:?+X\?.#=)-[3gPa]D;1]]KJFF@5.#UeWBX,>QM-0EDOY2W.DR
c(;;RGa-CdNXD_1AXeTK(?.Qe:4,C<7_](1:[^6G[?OeVH#TI?9O/X(M,6E\WCBV
P1+]cf,Y@[VG1,8-TDY#@.V^M7d45P?fY@68[=dCY<296#1&T1S</I;-GJO(LFAB
B&F1-J\)SK2e;b_+Ic8C4e><G_15b1g(4#b2)^WLVHFeMb3ZM(gD)/FO(IM1].I<
4S53?GZDcN6/6U\Q_RG:ZETR1F,#MNOYO3XAf\U<RG,D7T49_<R],.[OBPPB4JC]
\\/]gX]+Y:P(UH,2\a97cdcXVZCOPA=(feLG&)1.#(8[3;6c>TBSS5/Y+a@1+<Aa
R:Z8V/=&0LBOZHKcZZ?A]UE-&bZGPd22f,81P[8^<R>:.AG^9F_]R?EYMQ<A^I@R
&]:TcY&/gD,CS^=&AT,5:8UG0+9/g?91#A@Z)9.GY7H)B-?-B=&UX)\1FYU4;T2A
,R7(18g&eOe#)S\D>gXb/-I+S8JNQ:4LUNJ[0E#@#U[QZ7HI-&KT\C;5H^eXgO_<
Ib]A-57[D#13gEP,,BYIbH73H6]>_8AS>0207,,T^dF0.@Dd)SUR@B4TJD5WSBFV
W9^L^^I8=:gZ/.\I;U:?W(S_#F6UU5A5VDX_^_@4/@?CRB6?1WeJ.M9A9-d.#X^&
7Ae47P[V#[P@9.BU;)J2-DS\Yg?B+5?F(0SC3(FYPe;5Q/b,@L_6](/V96cDZYBB
[-Fcb1@[:4MbWCGR9>_6?TX?fUMDLg\2bc/M&41D(OZYT?A8;_aC=eRB]U<?WD=M
.L&gedE:9:>0_CBL8^a>^W9_>)P2DE>NJMJH:KfVXgE.<]BOM^8)Y>OU/Tb]fZLA
4_,83WGO3/Z=VcQ:H<L_4IF>7DOFK8Wc+/O^3Y/:(d.D4L<,gZF4IQ>#C:#,QaEU
UNI.(W:(\>.J&^_egV)RF39MJZOXI8-EI&66=W?773eD&_gS3L-^;E,>5)L81JE(
-YIba3MYY0_9Z:(<\,X3QV1H&&A.=B?MgRA-OGM>9.3g6LB;fUV;b)?.9RZVS:ee
GeTc4S@bS48NPYcRMd>(GY.]D<LEZQ0SO5UHUEH48fAU[>&YgDLHTf-eVI0b5U5c
TK1P.0?<FWHd#e9WTGSga]BS^S8ON1Zd&:.?L](9T#P[dIZJ@;01ZcZ8fOT@2M@,
B0;<_FMSGNI)F3XGF]VQ]0,=G6E91F:bc.P1</F#^W^De[2QLRJCF1f7.(N;4TS/
[,>0QWIX?RX@E8UbQeNKT)D>?#DcF=.WZSM1]-OU,L5GLO33VD.-^Mg&S2J29HbK
OO/5/.+G#J..AY<>R_B5.=SVHHW=D9@4K[Db^DY_K[=]5c>;a6Nd\aQ6>^Nf8\e:
)dT.5S+72IO@d0WRJIV@.f-gXa=abb&#L4?9:8aPAW47PF?<XCB]=9H7W0#.=<8O
Ce<KO]5O\:c?-TQaJBRO&3(RJ2[VJ-=^9HgN;^OHf:]C)YYc[A70-0RQBJ?1B#<#
RBcg&SBC&;=_X84:.2;FT8;#ef@f<J;\c[f>_N(URN&K8>ANJ:c.JPO7071)b005
()/RV6\6&S<eM9Kg2.aBMebf\7_<V@MAT8:M@526Fg?--e;-[Q4Df#;3E_abOHUg
cEF5OAdfFAYS5JW(dC?acO;ZJJ,H8b4H:Ad-.9<30\f7XXeU,-1;V;?Ke[V1FH8d
DcQ\O4X74f;C0.)JKgI0d:V28>JNO)aNA@^@I/^DRF-7L@7]>XY(9TDYd9&A>]LH
SB&gNJ0]2W\Ga+b1Q,JYFfT3Q1T&6fR6V[1K1MG>?XB(e:J>aO=F+HZRgR(PKegX
9>/Q3AceO2IAJ2PR)\TF(QY1aH1L21S\:[[B\D+cSG]\/Z2;)O&ZeLTJ?DBa;Nab
7D\.H;2A=PKFLfD434/fQV6R#,OS&IL+NQ/C(2,f=<P\HK0BQ(ee45/^CMK^WN5>
EN))dd1X\C8Y-<^,T&F;D.HIE)Q.eNA[&2aJIDV>D=1b7]0db^R@M:Ref,5HV6=-
:g)3a1[@<U(HFK:_Agc]\F48<?A5([:8O][Cf_E#B=C6[/J7?<QL2YK4)4MV&JZM
(@2TS0=aL1f_I==F8@e5:9VL1TcQ[BK[\:4T02H5Q]AG4a\B[BJ.NRLc>e7]B7?H
[8M+V6:0)XDY>E.9LQJ^b<aZ-N2WS4]fZg<M03dF6@XYJOf,:3=/DF<5(]Z6\;MN
4]PZI^Z/Q3O]6Q<)Ta2=[Q.JeH@_T9/^UfMS?7\ca]02OSDT&VI3SG27E44+W;<B
8WN?P5YDT.EcZ2-f4F+([RfO-#/gK^VO-<WOYK-g\WSOJ?8aB986+L?:0FcTBXYb
.;[WC5+MNB=S2VI&4aE5c7WP.J.G8[KX;HW0@g+5I6+3d\>2<E/8eVKLXce?,@e/
Y</9ZPGL_L8<8Q/G>Ng^Cf?>Ef0g(Mcg/R3a5c7-1)^3ICK(KW/aL<;+.<.fZ6KP
f8@.-Eg&:V8f+?;:<EAT1E82[#PEEHN5ac[Hg>N9?H6IcbJP]7FFMeHQUMf=6NEB
M\7OX5/3(70d^GKVHT:F0D-WJ]<9caGH7d\PHHI/8\)/.XSGQQ=K6bACKPC)6cJ#
Q2Z)G+740MR&0RE^?>G4@&d)Y67aNTWE9b<66OE^ZI.ET;+G9]^86)?@VSHJA-F<
?FF8>E3G:Oc/,6SM[/-08G3:I#]14G0_7[#LIE/MINaEW+=<)#@PPJHfZSO31e:G
MaN56A5COUY=_&aNa+B1NA3N4cR^FSJGOS,aXgeC0FQXeaNJV9Xc[67+8OePZGUR
.0F<I)(:@MOK>[=?(RA/H7C0:@OKc[&^egXY)fLF(:67A0(M,&4FKB1+gN@-0QI>
/LK)I?b^W-=Md,]Z27V=Q[<<0e9XU>ZXdd#]aQaYKgdO(\\)B27+8#C?[Q48@36(
@LK<8.+U(X&I?@[I9Q,=UfL_/)#W9SDNV]:D://Eb>,A7A9Jb>P&@LR;L#,LTWe1
Df01aQVP>d&O-#G[R<GI\WOT2F]GUWN<NTOUZ2d[/c:;-264>.63fBO6TI-)V#-R
K&eQ[ee@Bc^6RE?JE\dGS7EM9#6[19_:(PeKR.A]A<./ZB,HeD0Oe):7QFEcb(,A
Cc0Ye?cA@PC1]d\Tc#da#S5cc?;+/\c8H0a=XW]FS;&:IfOdGO,-\XJ-S^;QC@6<
W.].W8YVc.Uc((4b0[/\.H@X=Xc(,QT848e]BG.1W6]4H4PTJb^(G:HJ3<LXJ/_3
3^9O3K@N-I.IM6bS\9X&P6SWQdHRbS&=0W>E3VCT3c],9?:N[e<UYP;_6/>Sb=aO
)O^J5(&C7d_gS]>@<[6O4gPFT#V:G.TV4.d7g=J7Eg-^-_V9HA5I1:=D@]Sc#>?4
>IV@EHbA;DSRaIX/a(NW-&2Ge3:ebNC=3T+O1Pfa(.E)\5gH3f8@T<HY-f0A<N)b
^8&J6aWTSa:JR[U(ZT.(Y(K_2,VZ@<E&g,WWN=e(3_b-HN:.P^T)]1c),0Oc2S4O
1??-3g&\ZVUZ\(Q8>/d31K^VE0NP<WKBHMRKGO^S>K8Zc_MHfEKNFWG8]eb7JE2R
OEW@GUPG:d(^)gMX9_[Va5f3,5_(d/2C)\QaF3#g427D#&X,B?>^PIU]8L++5>2d
50g&@(E2#^=T=]A;VDNG95MT1aIR<\RR=50:D(g#D[ZI,WU-KL60/>&U)[NETFgK
;_@cKg=G)3=QE);^4ITY?J]ME[T\4-[A=,SNc>&a>Ce.bMA&9V^,1NbH#C-[X-E^
>L3;Y9<cBd])6D.X\8a=.]WbX.682[7Y>?UHE,X-7C1SV;9I@=IU66<WI9,bg&).
&VR(A55+Z2GE)gU2198Te6=SD_2Me/6f/g\TFcecb,V((]Je@2MP#d,F<Y\BeP?7
3I2/97]ILafNP#gXFXeI96XP3LEEOI3+0W-dI?,)C7OG(UP)O^\fb_/60]45GO]a
IGO_Y\Faf]VeDP^Y(ACea_YO):772K-eXV?e(GSX+125)6A7TA/XJ[UNX&T0)a82
a2-4Va47>cG2CY8VOQRIOV2-9DIJ&ZEA-^U8dOUFY>T3,96L#[?e^L<g+g5VKdE8
:)W[5OFc_J+Cb?<KLaFd0--7b4DI(_7:e^_F9JV<D-S[c]D@NK]Ld583D)5Q=E;\
=;AE8[UDGUY4(bS2<d36If\#:.1ad5-0aSID]N(GT)#>cC&U<^eCg?T5NN_6NP1b
+KZ/f6=:R^#aD_U@1gB&>L\Y:4T(NI??aCNT]@\Fgg,<R_6N;73QFOeGZ9-NK^\5
=&JVFN>TfQf+J)2UBENU4UbGdZ.bf+bfJ>9UZ\2T>\(M]9K#FR+/VX4d+\QH)S/R
a#O7<[.F=)^Je>\:/c=ODCe@KJKC.>1PeaD&,,e01OU8K2_4:/gDUbLKSMHN6N\G
CW^>V=.]Wd[:7CDR6D255-U4/g_e#-^J&8+/S0D&<OD]F?cE(V]-#[-M3NV2RQ(4
A^]ELH&CX@@cTN-=OR)+#4MWOJPS[#6c>Ua2#c6@dI47Fc5(\Q;9MFL/\V;&>37;
>f:@WI380RAU+7<-e8:Xf6]P.Hf+TR42&;K2)g.JQ45_24H=df_?3_GIDaY?c#K)
=CZ@NXI=:HbHR1JR-Z,GS6YaU2<P;2gUV4e_4S61#+16-_@W66<[:df[;3=V(D2)
?D>R7c[Q/g1LEI=ZQJ7J0UE#e\ULCIV2WHEXE<92&@6D3PfDZ[#WG@aWCG1L#7<Y
UZ3D,;F7IA9=P8L>QLOTUI&MA@6+KG[Vde:#6Y4M]9-XB@JEUCA[KLXSDdU3@,_d
?],gX]gB.TYD(f_:@6&g\#[\1cg](6V(SLAd5J9&Y5XQ>FT0>C?XX@PNEMXMZa42
@/Z@Y##-.=0=cB>DI?M\;GHX]UG5RVCN.909Oc?V[B[E,=MDOL9R,J(G?R<_D=Q;
0d[GH)C30c>a_,5=Vg,J/eeQaT&+Z8PZ;ReZLf/f5,12N3AD-X^&O5MGgd/HWXd7
N<NT4C[fcYP\#ODI)IYB2[@>[d.[\J>VE+94SKZdRLJ/M4)F1UB,c6]eNSaG>1aP
(SSCJ/If?0NKL+TRY?,B5TfVIU&eD:=G)0.,d8Zc#U?XVP5EV&G2X#b#;dI#+5J;
1^7bWP,cM85eIeAPYd@Y1OB2D]aKB?Z3ZP\;K7DE^5.+B;/7V6ADLVM]WOK/#H<1
0?U5__FdL0(,X9\BVQ.IQ>H6V\JJ_3D7/fdRd9XcMG3A8KPKB3-cV>HEWb3)fge^
;6=37V?/QLH/6+Bbf^A(SR=f\=KDZYc6M,VX8I_JPd:b.2<(fDT)8O^NM..c5YU,
:KP@&aeOI6HMV.dLBP7>K<<E=09dIOG+G1DUEZNdF5\Fa?OC@U?X3JZM-)A<P&M2
U3_fGN/<+OfQBP^&S10FJ&BEdeBS(B00=NHWLUec(.6E6Q2#0R\44<J&JHaR6QIL
(5[Kb#1\0H[]&QJEO54BO:=(,PHKH?5?M:=_NM2bG96/3SQ_4XW_J@dF53bZ]044
4,&<AN,M-?cEJ9K]e.Ke<1LOY(P-5B[(IP@@^TBX&-?NWDC??HB67YBY0MFf)1YI
)HL^.VVB2ZZ7=Y/U;L&@I.SB5-D/7=K98AZfDVL4_UfW^a_,#,/4X+f<+V(N/bI1
VI:N\d)=?):=[HfKV3,GTQ.@EKZCac^+WM2?TXeK_^JI\d7#a]R9C<BYADFM2.I,
1aXR6K&YN<B6-:L\fJL]_=IEOTEFQCY)+:VWaLN69d]A5/G[/Yc_S86Y1#\XTZ?T
9)dZDS]c[.W+GVWe/73EW+N^0J(+BM[V_^?MHCH8UUY;<L1=Wb-e,]LB721V]I])
NI2?C)\XcP8be7SR._2):)Q=.\=eTIbc7A5]#,O8)QRY:f]-FL9X=89.&60S.A>(
.d<L,[fLF,d=FT[,682&9>e8c.&0/X,4>02,,2,HX<eXgeC68a81-F.YP>Y(/5&U
d1)O^8TK6(30ROA.HNOWCJd6KMNR2A@T[IQ#FA90L)JY_aMB43Y6Ae,WILWWPH6(
;2e:[,#G[ege433[B?9E1^B<#T<@;<_aUZM<TPRQE+9VQE.86bE<OL,gA;G+92eZ
C(?;5]5^TJg6YYT?&e8L&45JcPL>;:O215gDD&8B.[+9DV_fa_Qe/=/@ZO?5EH<P
0F<MW>:b@gKa,^f.;E]6D:M-=L]:bb2;[=1b.e]cb?SE^\.EgR2I:Z3:W/Y^:+7W
TfU?LR/MJ9TFY06NWV/.c&IDI8BWX:>D,BdTBN?Zd,=JLB#]<2bHD=3F>IT>W_C.
^#R;Q(E>A^_T6K_6>/8(eb4_&BV_0g_K<TE(4LaJ9\L(7+f(?;OQRe0X)E6Ag\Q1
#3aC(SKK^-#feT6IOH8gQ.+[V]#L/3AE+=?dNFJCggOcb;#DM]PLOE>#_C9Pb:MM
\-48@RE.5/=]C-gO^?NR-e)X2ea4HHeVHYH=P99c&5If:-LI:\[:8T5;e182(45?
7f8db0LB-IWXW-6G(45ZDb]:RS6UCLU+DABd^C:eX?:fE>33,WR)J=X-ND)_3/JD
/LO_N+^QSTZM0C>fJ6H)ES;J2\H9RATa+ZX+P#8M=@3f,e8_T0f[67<)g?V=71#:
JZB]@SG_(#IF)O0N3T7\1Q6+V&/1M74J-AF&bSFNVF..>8?)_]I@(?0N&+6\3)EQ
Z&R95WZF;?0R).MG1\IVE=6U73H-0Sf)2W)_3#aNBE:7D0ePYNKBG7gf9G,+6,?C
)W^VgHE5LUg7L_BZ7dNVNcXZ:L_\.bAML>J4:eJQ7fA2GS8@gUQ?QS#;7Fe?-=7d
(A[?+dQ3BQ4.ADZKed2.fH#O]=2_A]dMbP))<TbS_IdUHWFEDH)=b8.d72V>C-AM
fb0=YYJ;X[.0_-Y:&?PMPccST,WHbDZ[=b\HFAPT1];+cZWN2-E\9B3HKJ?F>NFb
5XKY70d]XP39(ZOZR_NMBPG\+(5&8g8B78Z.,\AZWKLO8,9TeOK/M[JZ7(d<S=Me
b9[7;R6Kd,=e_93WE@9+]P:JbX<0/#eD-R?eFW?AXA)7FF22cO[8]3JD4,?>V>d0
1LN\[^93HD777(^S(3MdBIEC)ZT524<g,_IZ[Q<8,Dc3=-,D>KH]0f+08cK:9.5T
BcG3>/V=b]DIbb0,L3/9_&/eG=>8L/M]:fNK#I+TBfRID[FB,5Aa+#NI?#^]9S5^
J^Y-XLL(,T/@[G2,36&GZ:F1daWD>0Tg;?3UM7g622,#7OM,].aNQ1f(818ac\f0
g2USCC[Wc[f,BS_>:W(&HYW-J&Cc[U,S/IWI]W^ZPQZDOW,\&@Ze=Y,Se]=LE3BC
7a;=:/]8_N[c6-d=A2EW&+6[FDHQ9YM)9aS^[/J_Wa(?R?(Z4R73Yc^X+AB+65OX
])daf#IJ1cY)Z=9ga94d2M&?C?&4f]#ERg:?NQ6-@E+,-Kb78DI_FJ<^O2g^NE3[
JO9W(6?4WTBD/.D6^:NHB\>DKD7DMUN-LfWSY#7U>7@+#P8gSHOE@2L:C/IH/__^
\Y.f[[MT0#;453?1&H/Xfb2Q9aFJG)A)J3f@WK,Z6&IZH&[B+Uc0WAP?c+JC2OFD
2VE)f[\O6B8FbKC=-O[GMW+_AWI-e;d45,=>I(aLdaAL7g4X[SY@=1CWf?cS6Z2J
&c5-Y=^T+D)6de>bS?J.=K_M@;:DH(5U801[O)9C.:<V+DVUZ318+/EV>S\DNGZ#
L<#:TAIBeWG4cUAE+929NAI@P?BOT/@Baa9C2_\>6]\LYf3L3:(37PP[P^P-I(H&
Q<fVV+<,,&e[f+-:D>:8+O#NI93&be;ee#M-PgS92Q3<;Q1a7;&U_B\EXN=/@VR@
#afE+:9@W1<CJ12E@c3ZV-YU(GOZ8Gg7U5H?&eI/V(M2GD03X-/VF#^\a(2]f]=[
3:L@eZ1SG3/GF-_eUY[B@,W&AH4[Db,1V]:ND:=QgDP]/3O4R)6R-W8Q_30-SI7G
fJ1P54C>D+-M@2A-?UVE1XDbW.C4U_=Hcd4L&>RccR@B&HHa3b55AKP?gJZ/4)#O
P?b#-\g+2CX/?N-dKY=FPY6dEFMec^-ecA;IcHaQPC@B_g_D@.8O77GZa<e@f/3Z
)2@0()^[T0>bJMHFNSEE;R3bgV4bVT11W7<@F&U_c:#P8:Z3CEXZKQ_IKaQMg)IH
9<=1Mf,b/GIB5.E4#K#Q<f-)UZ=P4<2WA__JA,Yg7D^D0QDCKY<]\D\8c#2,b9K:
2Q9Y9]?_S]:1:fbc>dWG[/;O#_F\aM#8A@:LA+2A^;7=:e?BVK14-0aR(OK0D,4V
+d:3HO4)JdS4cFfcB#O<2ce)8-U[CPBTWb:b5>??c4<9Z(\I(.;fJ_=#,c;#>+J0
&9?eC:O\T\)063#:DAF#Z#7JI>-R1C)dLE<\)c;-7c45AKfVB]e0@7\_D6>8G+:.
Y<#Rd-B\9P7BW&I;JV7K22:/E.SQ9)_9/(8#7M?TK-&WG(8_dAUN[@aG73WVZ:>D
c@1bAFbZ(,GU0HO)GL)HRLZ]X(gSf;>#^gS5MOR597cM;#bYV29:WDS=Y:-Jc@HZ
Vd\ZWg0:ZYV\QH-#@@<P[<O3dNcY\5D:,FeI8N>Z]Q6JHAH@XKLLc]KYa25TN+XV
F/8TC<2R(CcDYUY7)VZ6),])-)SLF/6GTJSK67V,PMX?Y=E-<d?/^+C8UGLXWETf
Z[D;BXbZXdY:bOPgKN9N1F^V+P8#8[2Q\RK5=^g.dc(PZ6d\V@8Ee<,I(8FNMgFD
Q[HOWB[14+4Q.)J=5ON75I@E48.+E0KI50=;\G_?^JgN0VN;/2--D&D0cb<.]IEI
1<I4)S1c/RW<Z>>PK-gZ+EU?V4EKBX_+aHRG@@33(M-KSg\H2^24_^&CBBZIPG0F
4O,@B#IJ.270cN_89I2NEaCE(YX0gDKLF+1,Q2]P]Z:P:a4[JIO@dO-dbPc;5)d/
^67=QW-#&C6KLg.CfU#;DFL+P]8,5>[aGU-[L)5LLZT&B_2@P8I]T+LG)?[MF2.=
00PgITg,K3c7W>47/\A<R4HOH37S:Be,^M8=TWPO<\-O-W4ZY>IA@96XRa48@@_2
K#XWR#,W(]#:d1L-+S<DX3J3b9A7\5DCD0J\=HI-A>M5@P;6YM3SHVNOVTP33]Y^
UVGM&&6NBNTDJUZQ-R4S@9]GSE@_bU?>U#9G7G3#9L+d1ZBN01dI@8RL-<eX;L#T
J8Y&T15SgL>I#FZ;1FTASPV[X-J<W@&@<Ka8X017O:LfGaNVf8-GQIcK.=&\5IGd
acQ:2:0RMTY7-P<D6a17H3GX@Y^3Z1),YM09I8@JOCc6<(R2I<LC71U9-L3,eeKB
>K-8^:QdFT/COF-f23QCL@ZC48;D5g[8:3XcR2(V.5,AMYSIT\Qbf=K&Ca]=<bPb
C1^9H+YB1T?gT7a4f7.0QSKS=eJHSMNBeC6=O)9g8@c/\Q>2d&>KV]3X)6L#DNI^
f6Vg0>Ig4b4P7,<.FVVf/_)WO.?#^KAA0+Q>#;e/-\-+L6XE6>e@7N>,AA\21/9f
VPA71:=@YO.#XCJ+Qf[#b(W;-<HdI/OS1H,\g62<gE3M[[ZF^Yf&_K)0D^f<#BA^
US6fWFP.=EcKC06=71+8DJ<6YG#]:&M/HX2T&:4e>M9;EK^\GTgFZ)XGWT;1MBXA
9LQ_QH.HUTc(YKWe^LF#WN1SYA]g.c=d?c)+].O@SPL#<-I>,RY00::gWH0@4<AS
U5K_J78AQ-8^]efE2RW0MHNL0BL45Q9^H^,f[gG67GeE-0FWFBaZc4#.&K?4J-4^
;J4^RCBQbCa_Z0TA(9@N7ReG9JVQH6^LRQ0/NB\/c8Bac;9X\FFIO)DE=D1fB/=:
2=b(-OS66MLW/>>@[V<]Oa)=GLYa:2_aeB>,FPb?6/d^/,UHHKND\c:XIH28df@N
gJ[M3S6DETaD#@3]e1^[&fgVN5^/J-@cQ?+b-BFB@fI0XL&<-X-9-@Ra\NXGNX-@
^+P6If)0\:d,;RZH9#H4UVL))AJ[P1>C=2<>)<P^J+3USMPEgFb0X>\K4[@A7eXe
^dV9H;CC-#(3;&f7]MF[Z]RY7X,7N#Z#MO;MN)a@,ebRWSJYKUI6[F#afQN^T+aK
a<:<#;3G(,;a:d3=5BOBWX<=X)#e,Q0I)TGE9>N^B7UW+Ea@-;UeBVZQ;eO3Q^R,
.RZ1[Q8<F4/>PD;>Hg/Y+D6B382dS][gJ_8B.L&ZbBYb.8..U;F/<U_PQeU4SH&-
I&.[KHa@D0KW2;@;K.N#Q271W_,IO;Y:2H>+-#\<AVg8(4FEdE)8fVD7IZGH8gNX
>8K[2fP.KB+_TS-^Ug[YJ>D?3TM\?]X\^F--)1:INAP15Q#Y@Jba-cS[5[?1(f.I
.P.YcP<Ug.E;-M-[]F\B4V+6.Y\:d_3fa81R)Jd.F+Mg+BQaVB8AMc&>/^(&e5KY
^T4XGR8=[,JG/]bB,3DXGV^Y5O?A2]a>#KePGC6>4<45FL7>+?FDY[,NJRc:S<fG
aDe.O@K1(8^8Y0DIC3FWN2TL>\]27[IHWGHd823]ISdTAXf^WS-)3C0A86E4aUb.
b=N@O/&af0dT_58d[cTaUNJH>D)e&(_E]8+ZEFOU&#-XQCQcc/BG3Y(^];UM+K1Q
XY@XB#RJ1#RS?,NS[XdT0fR7Z/3T/H8_=f8FPN1/KU[Q>5I\e#B7NCMaTLG9T:X(
O4A;8c]_K&3T#&b&-4[T\RA74bY.BG/3O0AcNZY,EfV(,ZTf[[MSe#\XX8+aBP)Q
H=_3UIfP1)b>F7bV-)7;SHY\SMNNaE,GR<K)M1TDC9bZW;+OQTQ6/\(2LD(#:g_B
LY(45KX5S2T&K24TG3.H;GPf6FH,#)61:<Z=:K?#U=CGTC#G#>LX+U86I3ZD/-,N
@SAX[J0@01/;AR8_OE5DcZ#\DL@E)#&G(1OHX0a?S-C#eRA9b48XJ0?\Y9?;:,a@
P\Q7)6PaUH:3Z1<.>>8L]bEKM+fI0Z4CfHS6=2+CXQTGe-MYQY0QFgg-N0+Z/9\f
D]([)K@&BaC9<KGOdIN/>_C&?>gH9f;LZggYYe@_#3<;d=#1S;B,K)ENK[=2)d[,
8ONI;HNWLZY8?-(=+LW)-3+#eef,?9\;L5a8.T[>>:/K<afW4X:FH[HgWK^BP4RI
D6W)NNDU]:;e[U81.E#@NdHC(=)&;SX6\N7[&C/cEaAE;MVVPJSVRfTTX;5dSJVL
_7dBdT=68:,NAaF(J1RBI10Q/W+)Xg3UAISd_BHRO5R,Pd/]\;&Sb8XTLR73ZSIa
BQVG/edUC&4D4QcMW-c2:JCA25;?/;[bFIU4IK-dXOfMTVY;>T=.HPYae3?I;aG6
V??/?4M6BJdT]L4OaAA3[DPYIRE68Ca:4@-P=\0.ec(?9/\-^B7LcZ2RVGY2MP53
.S#5ZAL5MOFgHB,04_J+9e@#6Y-_?TWZ668EQ/e5Y);^?;7:1F=bC^\dTYX58TU=
^D3N/aBB_#8Ag0b,_5V#UA6PLI1aB8(BIL)_BSU@J<b,([(2GHQ@@/_Od)5Z:Q(B
5\<<[>G9e^7XG=6TZV-]<Y,I=d)\;f+3LSb[b_1L^C81L3NFUf@QbPWV>K\d-\=P
>RYQ(IRV#:?]O/C.O&WJRR]/Z.b7K?,aNUGTX9^:HcE-DSF<Be_A[-B0OV<-7f>I
A76AM4A@Y6E^\(S&KXe\.RH.dQ=^TI(+P<@O]5?_Yb#PS:ZbF/AcR\1]16.IT)fN
#:=+E,0P+I@LOP0L.7W+RcIBBe)6-NNM++WA_e7cS:65[NBf;KZ]Wd-&JgKAQ5QU
\,TB23d^#1##[NW((5ccd7+RgUFa3d@8_?SZ(6Fdga28g<\S>\E>ff=c)N7REfYG
-@cO;1ROOF5Z>EEE.^b=?22X4e-[CI\B1X.,.&)_V=d1UJCNS(=T;JEX@6945c#+
4>CV83HeBZd?J@LJa1Wa=Dg2UF;U-QEVf(U0GRC?7;>FHAgJO/D)\+(P;\@<gd6a
R^KKZXN72Z3)R.F]Kf@gJMB=]aS=<M\E16BZVeD@NBd7DQWYW\H,(/Ga1E]b(@\]
@V,;7WLf>:0f<5&V-?@M9&Kb5&Rd9_Ve9Pb3,MV.OW=e4g,3+8F./g5T52EaET0N
c]8f;aeg23Q:CIGHIRN3]FD/D(b.NI+X\:RHfAZ\Y?SE+8@<L/6/@1Z?b51<74A5
5&FDL(B]eJ[S,E:)DVY.:)0Ka1C3Af(/Kc#b\@2R;f:Y:W2@e_<[8D(;.J=D_E#?
=DO;\Me4W+]ACOL7AXUZ]_=;5J(&C7.6;,#OV7R7@]WcY>4__ac[B_b0eCHQZZ8X
+RLRY+HM8[#?7(S=Tb;&(9&0&CUM3GM>R(9=:fHNg,ANM=50S&2(3EQB:>;KNgN;
A6ZH57\U[I5GY-CUYHJ\ML<0JFKW,eWZJa<WD<FaU6L:Zb[UfW9O&B)^GJH4YIRH
NKD8#DOO^KY[gReU1:653_72ME(<N[@ca+edY-4-28FTVb(X^#cKU)@QTT_dRR\9
,&)gaB27fU9+M2.ZE4G&>gTJ(]-aIRXXZ/a?f@2dPYUSUP5(7RJ283H4E=DTUb?:
)@MIY;4da?3HNJ4A7(fG)0>gE/3[/\-(Lb8>SfMN<PNH5>Q,+#bW\I9g+?Q^<&N/
PMgf+6gAS\52)6g?HG70+4HD+OH5)BAP@R7S_4d57fd868/^4HH?7Hc,a?PU;DSN
?T47^J/dC>1<Za,[H/OQ0YW)C[5]eI67ZCT0/1+3ZUO)>0J]H[FA8^eC&.#VQ1bL
8TG=ET80M[/8[9/RaK?cVN<.f;+5MZUL)9+,BNe,9FLS,/&9=)JZD;+[\,5g23Q=
F/B3JODJUB4Cf\S8\MOFd<:-/f?12A5?,55O0-]H[(79+0(P2d]?EH0.).AD53P1
YT-V^5F#&58^QeXKWac<>4@=O#J2_OAcDUR7K&E>]J8XOeagTc>EMdA37dU=?.Id
D\.BW[#00.,>;4g;1CRFKBH.Z1X(aY5,/1C2.BMHB.VZF9#O@c(dJ0\^[T8,P<?&
+1La<e3\?(c&#BX6=_Hb8=89SfW_f04.,fKGLTHbTA?[DTM,8197MS>0Fa[N-7Wa
CCSX/^3U/0)#8YM4@JVS.R0SBcW_P84/]C]3b0)b1AAO6U3XR6N+=4;A<Ee@3FPQ
DE_[DUCTZ-a,O;E[R\,SEQM6QTH>dO,YDPA_[21Z<K<T9[^7.MT7;R[.VL@3[(4U
GbPEU+,7VC_3,J&?,Tf#L26L_CH7>D/,PU5fd3U&N[?J?)^G;f##?Db=QM;@V^b8
fD6.]8c^fG&)bQ(^N:C,T\NEYd5.]EPYaYRe42PRTMSHgE7::U^?U:^^/P[7^V@e
If/I&8E(9Qg]9FIJM=AI>((Me09?;^-E^+-)?WHW4FH-VHWQ2NGSIUc)/)?4#>Q:
6XY-R4WB.6I=AfgGB_XdcKLXJHYF9.-IWL^0KXOM\1[QbMXY@J\@BZYdKA#XA[;&
UI7FLb5fcaP/&<:31\<e#<DH):OReT2T\Ob7QcWY^QRML_JQ:TYc#>09\]19B8^H
(Z_6[WCI67bIdaC(5-Q?FFIJFH1YYKb7aSOH)X:cg9D\]6KMb/8P:CCfN1/8e94)
1c\BL9&2a9+e7fFD,C]MBPg=3EUg_\dERXF4[]7LcBdGM-Cg6S_\^?G=E,<UaB3D
&)#F2Qc]XPYDQ=[2Kb102H@)[ZWC9g)@_@GB@RN@WA83H2^\fT)c<L&01@fA6<)?
Qa@RQ@0#,gK_]g#,FBU_/K;[.YXGIM=(=B;db^V_#N9-:>2/]Eg[SLO((@66086G
[B5+M@]N)]KFRIZ/,L6FNdDU>cbE-#K4#d7_b:2Kaa>4,2TD98/@LN4aD:.-RY6]
4^d_Pd?7a+YYI\VOIe,UgDMMPd,LPLF@1Y5/3a,ZT(J>\2/WMJaLRdeE6La<3;@-
SYP8NHb5L,Kg\7Y0QU8DTWNNb#WH?BQPLd,&ec]R:&7IGN?9cSX?gVcL3X;2&MLN
cbH#Y//QB;WE6+>8_SEgG9[M7_QXcD.=-N5S5LgO3-#8E=PY6<dRZ&db.P)>Pb_Y
1N\,DE[NGDB4@e4eFC[Of(>\b>0O67>YW-W8dRV(ZR@<3TcFEgPY&>O8--52-a-?
5Jf)HK?:?JLX2Q45.YN@=D59d]4IC<(Fde:FXY20IDeV)[@gdDV;b-OfZED55gg0
UW,ZaPbeGQ@RWE4aFH+#X_],AJOUI/=N_T5MOGYeQc4Y[4LGRL_AN+b/D#Z4RCe7
4USI=Y2E0ANL=_?e-\egf#2#G;[;>U&P8;&[g_II;e-EEg+F;[MdHD&V6EBf(;:A
9=d;#PC0FV65MW@7(M(GO[C^I,K9SaW4N4]GQ)3YF_\P+4X1Z^?V42^=T;DA,Ac<
&MI_UHE7)a<OY@@<XK4>4(U8(S)WE[=f1X])SaRG1J5I1>^MU]?:?#Lc9,^.<+);
KO_XDMC[4I+PQ9XYTREaHL;OT27a@P:&A^c_BV:g3+a)4V3b71>^XG^0K)1GP@,=
T\dV:VQA+A(/=AeAdVXTF#KPYM9QUFa\B.bgZ-C<CW),5b#..D<9:&3WH^AOAA&@
WcPNAHTD/C0#\US5=LfcD\,U)TF9+<0ET5-,e5d2GcT<1^g#(WU]b^<OI0?>E+KC
:RFQ=4fS)<_QB<5::KE5K9IQ7O65L:+M:e89Hd?-bL1A,b6MMA:XL&\?d)6G1;QV
D:]OOaIJ3G>]CWQ=7-0HAR+Q084S=LA?JYZ#.W#\I\F6;FQ9b==36TZgbP\?+H#O
L-DQJb,Q0Q28Tg2eG0R^F>g[JI,GUROQGE,UaI<KR:M\+&1NK2\+YD3fK?aF+e9I
4EdUG_dfH#c1g&^)AUgB@/ER5F7c@X=baV;KMN_<Ba7/c&67Ne^9GQ#+V@7Ud7c0
^g[Sf..1(O@/P7#8<TgE.GIPR/12C)P3HL-2RGT\Dg8fN_79\9L>Q@H9N],&0YPa
5+&aHB>(80K^3,Wf,-dW5)94O_TGa7EJ+)dR[WGDN;OIgR9FIF&+YJ+K9:5>LfB@
XH)7@MaWAUO+T37,6&S,3)T0I/_Tc2fCO/]5Y>HR-ZaF+8MPaa@(.]ORJ]Tf,_]S
8Re_W@f][J?_ZN^CKgX-a2R^Sc=&b=P#P.JGW<-FE-G3c+Rd#)c/b^RYHZ(#+BdQ
8Z>O7AA?+^L\([cFFHQ3(BB.W(af&Ue--[YFIXP1B9JFNM))77I4[=8Jb93bH5S.
N]43\U8<:?L&Jb/e-.\K.>/];^IJU#6I/CWU3YZ/=IED/RcNTSBA/1JM4&KAB6/,
HbZUR<CDB]C:MGTE]:;5-.0f>5KP.I1\g8Z:3J3Q(&)-.D7eUcf:6,5H5g#97P:[
URc2#E7eB^CIVRHK];LJ0R421b8Bb6LTX2SA4C23b@\(01B3Z=bCNUPAG;NJ3c1.
CD@cLWaIH\A&LKB3ef#L=c]4f\3)XWMWRRaGMZ(/NMO\bgN[NUSO;Ka]Ngf?G^<O
5E5bb-4&U[,19;?9c5,O13CbDF0NZC7.:=SNB2Y;NaTDTK2?WK@K&?CVNB3&8/4N
bG<S#J=KBIS6292Dg40A/FCV(XI>VaVSdA:0;BS4d+M=\Cg:SOf[WC8<&=AYSZG:
F#bUB;B^;0:#f-A>eOe/dH/MDX]6#VRM],.)@W(gR)Y9eUM5Zc+:O^5bM1@HG.^D
fg2c+bJ3Q7Y)9OM^(Ea6S^R>dfJH/J+NLV?CTMHQ9e+JKH_M[MLL@0Sde[H(:DD,
-\OU<UO;+UbOJC5W=PH&gG1/be=>9G#.<gbO3;#6+=(>FA94N@cTN-M^?N=W5)OX
dGD=IC#W[_CfRH;I2L0.U.Q8IefY&Ue8G?7SWHR1+-V7J/_b>:C(RIR<OQ]OFg:0
SKc+5b_bE;_cg98KU-@Y-6L]_-\Ec=DBK3YWQe/24@\,gO8g(KYeRF[##GVWgG7S
9)7F[EYf,>IY9Q\<I6?P@0GS++SQ@:P#],7\8IRXM\)6KYIL^Q6FCD7N-A9_Q5J1
,_f>LH.,T5_G5<KI4b?2bba5V,Y@38F2U(BWPf1PT=37dZ&1<5F1SXX5Y)]E&NKS
dEg_)Q@RZ:&HB?W8ObfQ)@6\I_P&B<UA8K<0Q^LJ:L(B63B1X_--8Q#V_WGdB.HD
eU>OW<W/WX-AE0fQJVPdOV\WD^1DIX^H(CP5>3XcBW0E:G4G+(94e/MR,/^7KFdG
(7/5F,b0.ZC&D[CMOC2IWBfe_1\5@e<3@3^+,N[KG1IMU=9_.1LWZ(E6]T?^]LKQ
2S467eZ)4c-fD&S/)@/DVKB9TQ.BY[:HFVEPU>:4eLJ1\Cb^]>aba)cRPaBXF;4R
0bLU\c1Ua^>QDL;faJc(dU@5I1UZQ,#3#;V]IG)FJb5B^19PVWB?@DH<WMZB(LWS
G_+3H=SI#9D@AR@H2-+B/FH@?T;[&SU-)-8LS<BD#^FC=:XeA=KKO)OK>CN\e8#b
=\Fd=f02?@::aPIL6PX84,,V6SaLfDG9OB-b;.EODcB)/#0JWT0?/Xa0;RgObdgX
fF?JIDY+I#HPfW<c+>&=fO;LF)RQ8X8KEggR0(+Q2)8d(H7=AV^3EHBK93;W6S3;
XL[<V4;L@7R,1VWWX(=>dc/dRa7e&H^S.K,Y1]K?XX+E_gbV_>E4\:M?;1gZEWK(
<XM\(VO(]HX+U5bU.C][dPLFQ7GV[YPN>G[8&ABK2I4Jc\69]AF+b]I==H@U1Nc,
I#^9-JM^TK=(FX@W89KSKgZV&N>0W<XXK<8I<Gg9@Z\e5Q4GR0BJcEMF500HfJ^P
]SN6W&Z\b]WB8Z8A0PQ3).+@=Zg(c6#TEM5MRZ/TZ20XeAbX]g)](OGL#7T94TKA
HNS-f5aD9L?DX2]AK=&Q<CLJ^GKX@;04QYW(DZfN#XXB>1d(?Z8MS95FO8f-.KFO
C40VZ#(fUT85\5)1WXGNTMLNFU8SgKb=T5-]2VPH0MF\KOKWM1BSeZ2;-D(cb;WS
[1,?<R1=\KL;\;-2C@E9D&CVV^,RK]P+E@c7TdV?OU.4RGB.QC)D#-eQ+DTP:PZD
Bf4+CZWgDH8.Y:WORJC,0+&=UFU^V0cRU/TfL/_7=0.FVW\gCX&8&Obb13E)Qb>.
OPUT:H]?]Z56KP\b2_>^bF>42:J&F]/:<O&-T<F.Q(-IXQ[Q9,/RI,F+4RedT8E\
G1^cb6=TgWFK,O+NR,BC:@19SeMX=W<RL>HZaYZ@.ZRFH+K=53.X-)1BNS7],WfG
.TV;(PK=KV7O7?BAU&C&XSTJg\GKF2YS,g&acHM>:b.NH8Vf&M7<;0Z)&)Ya>K+8
]daE+f7X(8)Ob,1ND:Tf@d4:#[A;^.9b<BWaY3D^V4J0)adQ<^CD+R+_MKeG[63#
XL)gD?_UKZ;bBP_,Sg0A)]ebTg2X6WG\CgCXd\[XfB0BE&:7].)1f<dC32g:(e+-
)J0[PEV2H3Ra8&NXdeeb[GO8-9E7e^ba.[HOY?6HT2&ZYXA2[6g?bcELGbW?J9C1
>5=e+A1AK;N-\LJB?\aS(Z:,D2N&H+2V>QD1>>;@;Z&^]RTHEde4L:2_+Rc<OO[Z
c641c6R/X3-<SDWQ^5H?PU:g4>#B2@Q-^5^9:P3.I8Q7]#U_14EdN>e&I_OJ@X1c
(:\(2\+dDZBec2&+:H7.L.CABf92XAeIQGcPVNY?D(XY6+B?RNbUDaSH@T2?ba86
N9HVA49)UFNA7c=,NfcU:MS5-:@@YU3EBgeNf47GdF.UP(Nb?eOc+.O<1/GUg+#(
P?@I/8SbeL<&.:aYZM,C=>Id?Q?b&<M5e1PBbCCHG\\<fK-7,d-WU95\I;FfYQfO
RL_9>&7W>4ZJ1C;6U<@7U&151MJ.d9Y#eN=^G(A<G):NVN9Y.]PYD/f[.+YS0NgH
=A)PBK&\6]N[)Xg.J+HBSAZ==E[\IcK10RFg#(/Z5EL[#BgCX)&N<Y0U/YYYIaIa
:K65-+-#:cI4X=VGB\CD\cL3I:?@@QYFSc/^2X5)NeS=5d\/:cZ]d3HAPAYdd&2A
5?]bPWMO2[LAAR0-WMTA./\S+LA#3NVPA_DE+Ic5R:S]gTK8e^G7L)fTFOEY;d-A
f&.R],GBRL;,=L@+Re4::XfL(VAJE).H\I\GObU9;cT)aJ5P>Ob;L)V^;&S?K=5A
6PX=IB5QH1\5e.,/^.YGF5KDZL5:gS4VfZH)[;,(]g3_CC.0YId[eDcG3,f,-YaJ
RV,&YaX.RO0H]Ad]=PKWIS#90#f,+a:5;P)=<XA,[D;<J-7NCAJ\Xb-Z]HSTT-8)
V;c:SKU8=\3Yf^/P0X5=&W5&H9=c6OL7D3&VNT:-S^g3+J>+5VJ[@U(db5]P3g/d
IY1>VPNaKG495(X#<=b9/cZ6_4+Z5Jf(7R1d/RR-(/Z]^[]1]?B)<ZM.aQOGV95G
PfU=@I]PP>NQU>XPW)T_ea9(Y0EJ913d.^Pc0eT8,<RU=,N:4ZGX]L74P-^2J9)]
7e(7O?[OgOD9Z4F9+W9cPYCe-gP<?HW6BJ=<=?#_P7V>-R3B]?5IRE&80S#?:]5c
AK[>B]#?\2&/.C4E4c+(9J?ANGH,):)C>B?b0X.4OE;U9?1>3RZNB:Y-bQ=>=I:L
SVE4Se:&a3FaFZ[_CNM(Hc,6eIb8:HC,)3f^BGKQKGMP+;XP@7c/FU;:YED-76fC
^PJD8P&M7)d.N@HD]K@I[UQITfU4PEEFOV@beb-GZX;.TY=T/YB+O;=c.V?b>>4Z
XCFUOJ#V9XW&Z#-TgD8d8^#6S8IEN7UKD0b=@GZ\cL;3GRe.RbSR#-HQ6-<XCfUT
0F,XE\ZBRHce2V[9_Q@Y(dYVXNBH9:c&d-bN1@MI>G#8?[+PD2V_2da@)55M+7T&
8ABR#OJ..Z;P3&ZW+g(fFC@eI[-^Hgeb5CQXL_4>LH5<0WI29a>:=e51:1^\M&D>
>YZ_;NJ+7A@??H7f54_R?&^>PHAQV#+&-fbJQ_d^7Y9,SCd:J77SVD4fg^KHQW6H
fIcLT)a<.)fU7:TST1\KCI+?57f;L=L2/&JPWT>\0[<13,&Q\,-_Ye7>6.#^F16E
@=S=VJ#&dM)2@,(>dKMW2@RWF0QE=D17W)(dLX\+@FHcBYR[]S&O+QPX\V7f0e]/
@eREG[&-#)@K=[7+?5?J&QJIZ=6)^JG-@N;?></G5(],/=8dO^5&\#7K7X)PF(fe
dB,gGJC_9Q[Te,&A0PC,,@H1.5N^c:NOS9+PA7+^^9=#8=ce@I55+JUd\AfU:eG.
;7(Y9)a(Ce])MA=:cCCI18ECW(gN<AP8dTQ_CbF@6RP0Z6e)ABL>CGN(C.Ff3//Q
MHX_/,T<BBV/02dD]4^K^P.514K3X?M2e=X9f]L;IP_4b6[a#-Z0HEFgZ35U9,O(
A0Wc(Q(2;,_26RDWXMAFUaf,L3g3,41=T4Y4geIRGZ049bBS3Y+B>NAP^@S#9Y.<
DKL/@47UKZ-B7SMG#6BZZJ=f]5U^d&F6b6?8A]eE#27#J7022JG4D;L=fW<O>3=@
UU6;K[:<\1]_ZP2d[f(8ELJ@6__=Z,K,6F>HRQJ?_QMYL^aD)<;VPTAL72^4_Ne\
g]^Z/CM]EB8[HU81JY5##-D2=eMd/@NCFSb.7a(c=3ROH@=3R7463gT#.@=N3=KT
]CT8aZ\b.+R>JQf8,&ae<c=aV5[U0f_fbK<B3SGB)Ocb@4;[C:3;3:9Ga+D/>f6P
&T/Rg_#Nd)2>N[T^fO]QKOeNTV5@V,_6G#HBJ?NN6:P]0UAC)A:8Q86S@&HD/I0b
g^,7aHRc;U8LNfgBT1dZ0e26A>EUN14gK.(A.8TLI3Y?UX>b^/XP8O_K4eb[CMg=
#Ga.[,OKIg\;Q<00XE99R_Y3J-)#eE-@b=,)8?;[S]acB=?.E8:;AS0Z4J,L5A];
O2?;.N^D.N:WdBf7Y_,B>F<K<IZ-0a>&)PSA?EVWX0CW8=-a@\Gg9<_7?4\/(<KF
]5ID_2=7QE+H0fV6N)2S24-]B;=IS:bUPATQ>_,?V\=]S?B/6:&]#Nga3fXI,)PG
c0Z>(]TR6UZ?SaSA_H=SE[M9;;7TZT3YZd_W6.56fF..A9@3S;P]A)XG,R4e#/XO
6BO.[aT:5(3b[T&4(g3H(J20b[)(9;&B]ZJV6TPaJc73@VEM<K==GZcTYAK:;+(V
;I60VR:FK,\2G[aL?3b;5bMJg:8g.#[/I2LAX4\5E1Y7\KM4H:PJUe6O/W&Ad2FJ
GFXKcbDf)7.:O+Q1Y0=9>N@OO69_K^X]NT=V+=:gT@[8IgC#KG#YKD24ZbPRdd;=
29>_?3.+d:2@VGIT8:Z<;UNY\4JZSbd1O06;UW.&#&\<AA\\M3FCRQ:@C#X&_MJN
1]F#NQZ_bPGUI<?B(4G_G(.V\7=4H]&O0ca;+.6H.9V>gVX^]5KBJ/+NG438?]6d
U^A.DM_@+gGV64@bc<51M>cED00:.817E:D0FS6,ag8Pa.,#29ZB[;2cF2)Q)ZP(
P?@,U2eE8bWZ0g]QS-A>;4\:=)<(92AWO;+P8]OVJTaB<YBJZX1@@V^5D.^L.;B=
KO6f4=3BFE6Q_=aOGF?RC@Z)Y-+Bdg8W)].VR.E\N[?.=.O>UXF#3I+[XRR#_ObU
gdb(5(D_)SEP#Jf1I;[#PgZEV>;&OM8+59Q<AI8_S\]OA1Nc>FD[>8G<[I:J]d0b
DN;-dB;0)+g]<HZC_2U=0V9AD/-cQ0c3C;-Z6J/#5Z\7e#;MY3N##=Ue-?NZ#[#P
Z?,a8CPK,I#K8I<F<48R[?GdRIGI:d_4af[1VA?)[Ta:bM6H(^\+K49;-O&K0\9=
,W8=dB6Ia\3Y))W<3dUcA1;+)^4M9(&N[[T\EPD+U^W/2D[F<40g;0+c;:II,TBQ
2N6))D=f3.H;<U;Y0^A3JZX(6<X:Z\DO3CFE7)N,0T,(fGBSO]B_aYCXE(YSd.1S
Hd@J[H1Ice.MQ2BQA3Ra=eO#JFP10ZF-+[W830](fSe&c:#XH>d&d?V0PR7=@QMJ
+LCUA5UGeK/0HZCUOQ\eeGHeZH1L>[^A=+XIDP,,[<+gCAF]+XZ\)aAc72@-:ZVO
,YL,EEEgBEE\[K?Ra[[-)ITa1/b@H3J.VJ\9,NCXe0g7?B?@4Zf@gdMA6EC&@8d@
;UQ:gJgZC7@-0@eB6K7SM#1BU\]7H@\5AGBI]H>#2D_c_6L__U3DI)Cb9TAb;99K
<EEX\U]?O#ARDKL[C?-5&<<]Qb&+JC6O3c>aQA;1H]KKHcK/X45T;=L_3T:4(dT7
LF-)_6)71OaMX<>(VKTOG:#CeE[U7&F.b&9>4N.MFBXR4gK671^K9bHF_BB_b:f3
K>,T6cJEgSeZ=@e9L9]f_(WV6P?b^EKIT+3A&+\WWG>PRK5&,IDc-Z-#B6O9?),0
G4d=cd-b\\^GD@fbeD1YVEORGgM2faH.)DN0,1U4-K&BdMS?G[-eK/Y(MM-Ga\Yc
>de.U8b^Z3F7UJ=+bU)F;&):G:AWP5[5>LeEf9c+ZQcDV#OKO,OJ8NY@[@)O&_9S
dfK>]/#[1WgIfNTcgd+A(-M[;Vc>?d6Ydg9bB2QEcJH45^ZN\OC[gdWf49aSKB;K
S^(PO)4SJ>D.OBe@\BSS=_=:K84gUZ]>>G@,^5e;8_aP6(=Ab.8,KI0B/M=#SW@A
a[9I\NH3T=LOFXA)_cAFLEd6cB+92QLX4C3.OZL;65H891NG:I+U-=U#Y70<2WI>
R#7YKKUA>3=&PC63CUBX)5DTO(L\d2gfa(+4aaI5--)HP6dP=;<S_GC54SS(X^]+
>P<WNJI7CgSUg^#9Bc#THJI[c;(&JK<#(&N)=T)d-H;b(2(6K_F-04D01_K.>QGe
0I-,4FRdBBQDH\<6QOIa\bP@ZJ@;:\^?02R,QL;I-SLgG1]Hf/I^#efNMC)ZX.FF
g68JdDD;^G:=Y9^/f<7a=M\0NHJN=Y/>R+Q:d>=Af6(Fe-+3YI6WCg;K#A1+HVE#
YFa].ED+L.+:PTG(LCZ0.)CC&W972[BIeK)D@0W3?8B:NRDPN4W/APYe?b;)@MNL
G/\_=&L54V^.Ca(2^I8^T0;=.<Ba:D_/Re@9PA3IdLVPW33-+GUN3+TV;\TdZHc+
K-IF/gVJ>aH7,.JS/cMcc0WeW4SX0@LKP-aS(FGfJPG(2[3X..GYFG<UCW(I^2VK
_)2;BK=&T)_CC3JSNe+>WIGAa;<Gcc]08.F/S9W8[dPZRbFM:R+0dSK()-3MCaY+
DM[=OKIQUDD(ZOI:[V3Mab\NTQ-.a]XG3@Q]O&U23QFF-]@YHNIX+U,UeAHcG,ZX
Kf@Ce-].FWEU8JG==1,PRM#Q1>YQ]\&90HLQKW1,2#L3MG10EU)YT,P5E4S8OG&(
He.DPGR9\IC&dC0HL]UWe+;(V&][U[#(RMAK;g,_7F8&NQZI3>EU)AF+5&V1SDTL
#eTMdD_IGOI0AgZY9LNXGN-D&D=Z+?/)K82BQ]0:)+1+043.FCB17(BSG[gee7GQ
_R9d,HN8862+?S=4#KffP\A(-<KARRAG@>R:GLM19PQ21d5TY[X)8N\d-GFX[7A6
>^K4O(W=D\GWME:W=4U5?-/f:H11U^:>cN2\.PX6PX[^Gb4@T251[]:INDA,LV,P
cG2Y4WQTD,a@YC+[MHD:9.,:QRQWQ^6?1f[:(Z<TP9QM7+ING/JN<gdH79D;XXF+
N))3&2X(d[O3Z@]efJP+E6]QT+FSZ2Y#?[Pc,?D--Z8&0=?&fc7]de^@Mg_>OS1,
I8/+a;Hf&fVLK/[U;.-BXX>14@I2H/Ka^K>V(UA@5X>L0ag0+\XUA&R/#+Sf\a8I
=<JfK@f]K_/J74/cCdE?(=JS[5R>O:a0>F-0[(#JAX4S1<4:K-CNU=G\/[DLCVYe
XXf;W#HZ:R6^3HL,::/JPYMPDW[+O1AW)2S6Y=&dEV72@PE)HD?JHIU5[?O(;)a>
cHF(JG5TF5.H<F81g8X)TR?UN:]d3DNI1>MOLX?7.:L+@Z?6.DRg?S=SbGAZQ>YI
:QD5cB8\DV#JV_28ZaCMc+2KGM+UMGHd)QFG=@VGCDS\K1TF,6ZXdN)/NIXT-L#X
#BSH4g[/Cb-N@+P0XRAS0)_[F(GB4VHYLB(fd77L9D8-5L+1bL=G,PEbb6Nga35+
J>AD9eY9bZbQd3KYdNW>eYG-VD-;&8HK<CEEb[..M#&LD+7\S]fMIXFV:B15=_.K
ZH\-ZXEOM>bcJLRFP+c^3;DW==:3FFgGdN^WMK?\;Dc&:C>gBd-UR;365SPP=O&I
c>599E8fF30TLN/,6AQ2SMcR/47_TRK5[_fZ+6a4B=EMIE?B;=2:bJ\AZ\YD004>
<V=:X1&MRLTDW],0G2#&AP.\V>5.4LK[A<JL=9.LWKR#[5)@)FbX9g(BX6OX&\B_
Q&Z&@PF/T]]TBWMd3HS=,V,359<1G+M?.:8E259bOY.aXWGW)gIJMf3Dg/TTZ.e0
B[F#?XgfQGC\-.S]^WX_@4cB3=>6EN-Y?YHVMd0RO-003[WFC?T3SJ-H(X>M76G,
edCTQ\1e<+\?^]5P=;JLX660^T>=UX82#c=U.F_D7Y/:#/gV,2#05@2:[(@9^8c\
D#>^g.X?U&9DV<XbLXBQ,QB97GJGIY:0A/RD/a^\J72bcg=AHF6XWE\RMdV,?Id?
]5S_BA@,(Y/<F0OOeVUIF=fX<K\_^&R;029,bff#<J5_JP6M7SU_Y4I@09<g_[;R
G>fF4P,=Q4O:cNZL:9(]Yd<KTI@H1XSbE7=,eK?c(/+,NTdGV&)TTEG0._e^F2b.
05;bRZA&>_Hd.OX?bWMKeE2VV^/TP=NBZW@d3)@8L]>I4:f&_CdIg<<Bb]1[OI<7
3RCNYA\9F5<N.1Ta?4#[NP=-^gOX1[)UWc0A(1>L-Jf?2KG8b\PL(Fb[MWWe,Q@4
2LY/9[C_<;NgQf-SRb7Y)U7D9;P(#K<_+)dY,eB<OA:/-?DJK09f?.N?GH]SbG;_
7LR^.^)DPK=e;M3XN9fJ6<g/:@X[Tg(+0FXFV](MGQU/40PMO4(ZHF2G[CYU[\]:
/XJ-_RFfa&V&:MNBb=JBXFa14ADU<97VIE5Kg31EBWc#/I)_bG9T?HCBA,QYBJIZ
cXG_g4@#E8#QNN&>Md8:L125@)F[c5d^(0^c5D4c_4(FNN4M]1,:=:9RfA]0#+85
[&CZ@]IIC)G4^P0#<f+S2#;+EUR<Y+B-gV]-fUc]63\-]9T0G]<INW9?LF9\-A[,
eFZ(g68ZIQ7SaHGR:.YWb252-2E1S3,6f[7FeUcKaM:^C5YEG4I\33LcRU0<@<=5
H^WS,Z-LJ.)&6O]J_FUF#[IBQ5@YKFDW]gZLW0-4S08>#/5A&1F6:?&J]/.b,Vg0
K4Sa7OX@_dN0b]bJ8JSE;JEAMSJ561&[+eW_>O^ZD^b+aW&dPR9:AT>//)=.>2ZE
UNH-/IbY__?>_=_PS)FGM[\D54@&\:2@6L;5<GQdFgHgMd.LKVLbHB6:=SU?<GJ#
LL,c#0ECZ>c,b86[#PcB]Q9_GST&G3OO5SWB\eW(F@[#7f,?>^RZ^Q3JD9G&+S]B
H;29&7SHcJfA/.K^)()Q?I+0<EXX;-PZF,\)+RdMQ##c/?,D@[AQ9.gTa),5CU.T
<D;X:=F<V(g1.ZZ9UP9bMgT8,2+T.-\:CQEb2BBRK1)9#K<a4-)/CUMc^ZMQI_,;
gESHGL5OH8-Q)C-<TFC4&WWfLM_JT0bE.GdO5dI=_)HYZ>[(;?#P_a\Z;R88X[JK
+96#R7C^]KW7=E9Id^Y/BE&Q1SB+/S3EV_GHU3-0dVFd7;EcEC^@)e7O._TEC_YM
#R5SO_]Vcg+bP5U/8#_:<>[efRa/\cN\:IO161JC\a:J-6KBP^KW&^Y^,[@YBg1^
/QGT&8GRC(4Y@J67:RAB46XbgRaK9?2#FT_gC\:]g34>3.cS^<^_aXG=Z8PYH5F?
\+<+U^4URQ4HD9#4eTA^SZ-KD=G6g,3fFG?9^ZR?g8_6F?[Z<N[#7IDKeHS(-(_M
@gfXW@@/VO[FL]2dbK_Y]TIg.K6),Ue?(MSTHYW4C2\a&8L.1&DIM;MFaIKZ:)_9
G)(VI^0U<I<Ua8g<8g=IUTP0)^\-@\I2Lf3G6U/7eP]VJ6[dNKgM+6GC1cP#B5=9
?T4BDdNcY9S,]>.G80c@7e.K[[A)O0ZPQ[/Ld)-D)DJ,Kd.E@-5OFRG=>V(dJ])1
F;[=;RgJeR2,OJWIDT9c]D)<O>-=H@]HD-_N542ML<RR-#Dd-eSH]2DR>gV3G#_f
3CDb5\)B];S)WHA4TNP)#;+fKZ6_=U:U1VN?N;e,M/<U>Va&HS22P//QBE<Q:/X3
#((6=F2IY@IIQ.(9UEB2bG9f5B1MaOf0TdgII#:]2^aNB2IJ(LYQ7J2X._XN6d+e
M/T.eNM]QC&UGE5D^J]b<43JD<<(7=T60_<EbB-98fQSD#I6#>6+N#=?<+IN[F3>
NX>@P27F1>]Ea#^I,9BFH/c[T2^2b9KAA3RP,dL4J9Q@?eVLA.442-fH;e>Vg-#,
e(8N\?YcQOR_&GO>[&8?eCe1(SF[TQ9@&c(RS;IId<].O-QAd/XV0-gQ_a[(2X;(
IOLbD4CI76gWY&I3-/>eVP.2S0[)A5O3)JHEc6IFVcEXc_8aW9[-AeL=dP+;P;eX
:;ZPR(\TJ>:1W=V[Ld9EE\.&(.P-?R(YCJ@_fVbY-ARL6YBQ>;#b5D)9d=eI[ZQe
1,/&4)S\NKcY;[V[17?d6FScTRC+@EZG8RJBVb+[2Sf&8_b:/&d]#fU\BTBgaGK[
MX<Q1UG;bS;:6WAaI2\YBfWaMULOR&/gg?B>:FN6P;UPdN?K:U?OTI6K,DB(.E3E
]&2NS,cAAEF8[H/bf:?b1+5cM+3^27e4=[XgZG<WAC]4@U([_.WZ#d?V@XED=@_6
MS)3TW5X+dW0KMaPe@V6(7/02,REVcQO5OgL\X?#_7DQaORW6\\?N8eQ,185DHbE
,gc^U80/8C>77VT9=bK>?JfYeGea2PJ?GFOE;L>JbNe3;cY0SDA+8+EJPVZYcTTS
]U(HM8&:M;RTP5R8J]T>6NI=@b[QKIbA:)N]aI>LI>?dJg.PHY#6)VW&XO)MJ,cU
fE5Id9TY;@#==]J5TO9>.C[9-1C7<8N#Ye]EI@F9K;Gb)1?G@E1CT730)b.F68aZ
c2-?2SF4G^eSf;8C]/A^F.<,52d@XagZ-0DD7?KE--aW.Bc)PUa27R52b-</_f@A
Bcb9#F)^;8aWA35;P+N[APP#F]=IW;8P+NWX9@]7,(SMcM64,XH7K+Z.+I]Yb]_M
/Ec/c^Leb.SfT5:\0J8WOg[;KW9(RM=U@ZcLY+2/beL_/XgA0I+^2<g_\IE70&\c
H7cE>L[c=O:Ze-Z-70ER&U&3-WX0c-L0+JF6JWbffgMg?,^TDcLP\D;aV-Qb=<GZ
4bPZ;-_W?75/=G+3B2LXFH=>AcZ5_4[>fNUd>A[dfPBe->=VY2Db7QQbQ.-YEX1[
94,Yb1;F97cI)Eb9^TaFcQU8/a5#?EFfYD023CgSMTMTK(=\(:;bQS@OfI3VZ(L^
VQ?0Nb/8g5:4@4QP0&/]UQD09?\_P0f=?a6:MXH<;F=b1?CDEW?LKF^XJ\4C1#ST
6R<F>b3f40a/PFe36SOg^INQ2:d,1_T[WXYLH9:KH7&,<M<.1@Q.;S=(g?J9ZKM=
J/+.Jd@@+_U4O2CBG6>0,T(BL<,;T/7-J[.&#@[A&7Z=0dW3&_f#IAA=6O_5S,AM
=XZ8EaFg8agA@#9C<#6BE+V4^^S+?Ra>gVNEgaUOA;_X[1\fR]137.CbcR[]J=0K
0[C8DOTE<H2H7aW-4=bIZJ=JA-.U(]]\>RP/EA/S-BP,KGeSBO.(-I]]R\ZB?K>J
U[^E2E3ESSE-0D7R\^c_7XN(QWD7UT)Z.S1/.dS239(;]P8&M\HMJ]c]]&cKBE+N
OPA9EM_#:.KP#cbXAGW@ODDJb6>1gDJ4(.>FVZVK2e#X>TQY+5<=WeYD?<0?+S3/
>FI78\6Z+<;Rc(GbR[[)8=Ed)DPL,7,WBJ.X#77_W.SN=#0PA7Fa6J/65\(Ibf:b
.>N)7RfLG=EP_VM^K<d(^RWC>eTC(<4b_R)IGa2-T/?54V@W&ac(E)]P[@<L;0#F
77BP9RUbYR:7ZY?-)dA#Tf=?P:5AVa/XF_];2&ED,ad-Y4d\)JEB;.cI<4-9=b5-
U5F<Uac8L\5TO)D__C-VMQ;MY?6,57_IJ9])d,+IF/Dc\.V&7:WcM1I>&AA2-ZCe
KeLHHQ[O[6Q1-OV>+IQ,J]8LV3=B3?U5GW,C3:N2T-\]L?(9,@=Y8VB4]5OA>2&5
Qg@cQAMF8OTI?SRa/a@>eV_-)&@R^-[1)=bI+<LAAQWZZJNSW7)N9DP.D4=&(SO@
4#4&<+dMXYHX:aRUY,ScT>]:S.,GS71W4ACZc?P2g=[/8G/bK/(BK01QBe6/]]dX
@ILgaJIEd33\Dg]S^XWN7HN/Rdc<25I@]b/_HR>E(?]KIe^VSJRf5O8W(gBaM8Ff
M-FMD,c8\6TVO,AS3FNG/#J6##c3V,.a4b5<A#VZWT;_TQ2Ve?X3)NaG+)b\7/#T
\V=SV^\[F,28JOI,3PN:cN,2L/8&UX5>JcA#b9B\,^YTCB)I7/-VGfBZV.Qc4]\J
&b.0K]AKN/Y:\(cZ\:-a(BH=M6BbF&e-O(MA-Y+U1SC>-@CM5]fdH<R+-5/V3W:(
EH+^#eNPcc=SC(:_IV:fgW^UYR4)NO3Sd18=H8[FA3_b5f8F8J4BUYLQ3VU30CY(
\QEQ80G;>@ab:,1LeI)>PDO7=eXg45?5@DK2A]TXC^D<[3>4(EKJc3TVL\^P#S7.
dF=&Z_7?FSNXDW^b=>3NZ,,-#UJ3I)?f+&1EW-B1J+978.\.gNcPSLTIEAd#@c9^
/Q;acMZJ&)N(cg[9dD]..1V(C92M.SECcYZ6C/GAgEeK>TFE3GIDS8WGIG2C_0T>
<D8?a401I0La<FfN#42,G;X[55GB>:6N2dN[eUR9.H/.U?]TX9cf6KU5B+fVW8FY
I1M/ce2NH0FB4<GS]/80d7,320Bbe31C.(d4bY88]e:X7+d\R>&F8NXM>R+7KR11
.9TJRZ:@bY9D_D.#>=gJ1^d7=fR5e>MdT(F,H5CQ1K6]Cb//F2BD4<WTR1]FT@7K
:ZVDTg(7aZ4_/dF]W-_aO:PU<XGH(LYC/X+_7^,[F09+C5eFC8FP_FZYLE_6S:Pb
c5bc&>6eJO0;WZf<[YgH[+]<K5DP;K>&R(D9ZD9JH1+J_^MW14G#HJQ0.,H\.Z1M
</QHC>GbAL/A^I1b.X,c^P(NS.4S\Q>8^Q/dMK@BOEKSWNBHX=12[::^3-@]/B@?
U1DbT2IOF=DYDG8U^bS(ZP@K_:_W1+R]2PG>CWI)0?WeZ325[X?Z+FM[X+eP3cRU
eG1&NN#MV9_T<bU5RD1Uc/LSEc\7YEEAC(AN#_MO2[^c8=(L8;9a.)^PT+-+Q=6C
+-_dJ[?>7:I=?aTc1L\U_)M5#OMJACf86LWS^Z]DdSB?G(&J0WHdV)<NVGGV-;K.
]3VC++HZXA6LI3E&=DMG2aI<GbM73C(aDSeA>&[I<60]GWO85]?+]11PJVb^Q6,<
:UAML1a3g5;5(eR<LdKZNI7MCB/YF7]]-I/gHAWO+L:0OPFXSNXV87^Z:?dB;?-<
5Hc4fb/4^C36S,AC>W7I@DD=-X9;C4/V;3(F(X-WbHfdA-LOT/fNd@cRV,WYHP#V
JZ0LKbR=Fb.^VFWVeBL+M4UG;@gV[<H4fM]=I6,B:-M\cZ@EAJ13Z37KIT13A420
Xa7[aP^<\1/Z<ES]20N3J;QEL48R&_W=,1:(JZ.Q9e>YDbXNa[N(X.-P_W]gD7ba
,P7:Q\^[R2aL7Z.8R<<&Sf>=Hc^,\\,1.<DGd;15.8YDWfJ9A6U:0IUIR>gTc6D&
g+?)5>-LS8ccL=0\2G[DDRK)T2b#g[N.XaL6-.:E^bDQ/F-fII#eKg;KXRP]Eg&6
<>CALA)]-_ESKa[X\_AFA9a#E,XN5VP[I#1Q?efU^>KW7G/8d_^;]NQ=X;aPE7aQ
&EG^=8Q]RR.,dSTf+YZS+C83+DM1e_X@3d/+9<gX\2,:<,A;N4/4:/\QaSJ:fd]>
PM_YV4<Hg1OHM1c6T1BL5--YKbXbU:5PWJSE#JD5bTW,KPW7XFeQ5M&[=FOOQEgJ
X+_:9SHJ7(L#O8M]570BN:6ad6H]Y[RHO]9gWP_@+ZZaEN8@1()AEbJ=9dA9f1@=
//Y^aB>M2]0XbUL],6V:/?aXcK@f=OeHeK(a6\fPRD-EVFUTC0T<8GP79bH^YKBD
YeIC4JJZ00f_dHB[QN=b1I+/f_QcAL-6d+ZOd]H7KLXL5^O&8=@Y&W9<[HdP(#9I
;&cM83))[2=UI:g4cd^3QV[+DRb^CH+SO7D;<D4TCS2ZF(^dGMZedJ_6ODY4H=TM
KPSTbT#TDKULSObZHDc-1aUD&K\(,MUBYbZ]Hc<P9@E6=[,?.ZI?)#4U0cKWRX_I
^@8DaBWX.+Z5W>YgW=3R/W>XZ33/+(#=@CZPN:DXX:Z4IXI#N2E.0#2QU[D1[467
A9?M^_R.VPT@fF2Xea.UPB:.K8eG(VYY;1<44f\PK/F1fJT]g<G\c])OB(,GGf@<
7P6NI+A1NNKF_?:FGETNe0V]0cc,^fH#<,X1RZ3bI@D@V]B,cT_^KJINKgN@V/d1
9=]8]P>JE/A<TZ:EQWS,KYBU8a)JCabE]TKVbTaMJcMc;L7^]6NZd8UVd<EZ[G,P
&,,e=&+FLQ5L2H.-W^(eK]V;IGd#.)_J?;^4eWO^WA;9B)?G:,4QU.XfZ#9\7DJd
OJ8b_<2)(J(6BBKC2XIO^G^_L&D:#-bLMGQa.[J:2YeZ>I]LbaQ6C.NZ=>V^WZVD
P3XO)+@GB1=VHC8H+f,-a,]@KP<:<(@;^\U(ULFP0S+H:[-6/;&c>dJMbR[D]BW5
PC#^ABTQ5]Y#;)f=(:\)CA-09e+(K+eH&TU1TE0D][:#TDXcNeTZ>bdC2,VTG&>g
.+ZPIRV(@R[KO[c&]:NQR1Hf)AP]22AF)^2B&b<0NQ3@:^BZDB2=1.^IIZQD]/KN
JPLSfMP#A=YPSE=XXd)KMU_G@M24NKI\2GdQGR9PJCI7L=5O_AUNQ;0;57Ab>J>1
\=TC93CeG/>3G3f<aSF8<]=D.;O\AHLgE)FA#<N>J7YIdB.R.D;fV@<D=<@e2\Rb
M;L1+O+3-D3MP,GDW?0T,bI^D@:UE-c9Y)-+0+UWL4M[;&Bg0BcbH@OX=J_H>eRV
I4FHBdO2@1+#c/,d^@MGL2Y[E,9E,B>]M\dU95c#&f?dXfG_fA20D)W,XJfX2SV-
TcP-eY\Tc:-8V.;15)\>]24G6YD[H^H86L/We5B->ac/=Y?EY.]CPEV#]A0@,_Fg
Q(JSa)O134,44SJ04Ka<#M55LMOO5;(+ZT:0&62>4M.ZCC6I/Eb#K)ac9bT4E7)O
cZ^UX@ebL+g6CD+^SO;O)N@.b_d>I6[f]:HNbU+Me0/+]G9dZ^3W6V\68#(]L6I0
PU?<c\KTg:f)HM,J+HR<,X8HVadWCO_6H8][_[W+OdH+5)<T<@72fMEO;KPI24<)
EP?U8K9I/XA9689fe=0&7_0[@N1)9__4gSV.PcR(C]SQ7G)e2]#3D7G^WeURNg8P
^O[VI2?0/;Q?P1_)N\]2:X67+=L<Eca+H_B&.O)8Q4g0Ce\,/&C?42UdUYa:.QO_
P<B\>3OSVNY.g>b,[-C5>ggT#R>H9->E0TT0I?L[N3PY,ABA^JYGT8^DD?e=5.7O
J:N1c,G:VR;d;fSHP)55H_278^AM^;),/4IcKJ\&7CXb92I2GB-RB1@D;M[WU4G=
7&+abRg5/\9D/LQ?8[Y5FCICfKMQ^NF>B-<OBgdS^ST//P8V(.Y..TJ<0C3/ERV7
IF)H/SX;^Db^dNaV-.UO]MC1I>XD?,AHIO:>&/)W#CYB>g;/H/[,Ya?#2c(NVcBP
I?-(C<)^J@]53X<cG)M>@,b1PI?[.BVX>OW-8Ib(&g5Y/gdGJAJMPKcP7K6:NHLA
6(<MKGC[^_,0??UZ[GFEF4=#KM7fBFQeX5^0UeNaSDaNdC-=K38:UH@,d?977\90
2dFG^V0eTA3ed6/][DJ5Sb\KKK8PT/b)5=\ILTX.9cI]:AXH7]2)aO(eS5+\APAd
;e9P:QICa2BS,CV#@=B)9U+<8;4+9FOV<1#V?UIOL&+eCf2UZ.4-C57SO<F;F3C;
4JbgTL12R::WSZ^3\0+2KO8N1.Wa[#@6N;PI#/bW^O+[2A2b(>+9Q1CZ(Pe2BH7S
cd-cG=0C2PAU;^L7^K1X@EC;9^0#(4\\SY#28]dRJGcb7CM;>S.G.PP5AY,BPLGc
6ZX:2Ya8FHX>[?:PR[Y>EAZJQIKZdT=c@UKD[+&L6<@IO:OI?--64Y\+<gNc_fH+
-N1_B=E02=\Y=^412N2JgY8N\[4>dTZX#_6,EDYD#==^1L400S@13=b34;<9#G\^
SDQcZaMMIBd_CR-R4f<I<-1C3=DAM(OM[R6Tb,QO#6aeM^/P&0^YaN?e&]A^FT#_
FKF_[XATdcGHbbF=KB;D2aBE)C-ON.>J)S5fXK?R3bQe.[a&@@=BBO\D/Q@.eK(8
Y(WOUEaV9Q^U1&K.:_GSdP&](U(00_4VK3[9OJA3ZbS5X5?MW<L:f2:^M7d(RG&G
4D:2\<VN(_>_XO?X8.W;GEaLP10;KfX0[H;01\,bJP36RK>-6^H6Z-b[8X?/N;aF
MdN;ABCRN,88J?D4SgI)8[[U/ADWS<N]GI@E_<0[<NBfN3g=2QTGKX+.bW[Q4E^9
+7Y5MVZfHZ3cIA+gYBC\BM(4@db1LZ/RC]QVYN5KGOI&bDDZf.P/HDV:_\@C[PMM
0S2L4b1CcLYGGO7UF9bDX^^K/+aPTPf&eVOI2O=[5#Z?YG-WV>:+716d3V#]/(;8
>gFVEU_bGDSgV1&25XH.Ec+JfAHQe@GPM#Qf0MVd38,XO#6ZE?I,R]G^B@>,.<GF
-/,U8fH3d/gbVUac[_:_GC_8eMN<EZS=A8#:62RH&aPVI&g2;3:KMKbfB-d5QAUI
@OPP#),E?WP)3.;_)Gg<g.a;T5P7@25YKfN4Z\_3GDPX/P:XQSE)f.T8]Y<?KJQa
B)D/T#X[:R,C2f(BUacXP,6Q<)@Z^)\#S(C\R.)K#&64O+X4F_N4>8=)CDIL7=FB
43JdYZd6W)5[_1.[49N_R?(JIN\7Q>524J=fKSKH<.H/c_YI\#<_0LcEJ<P92I)8
HI[^XaA_9<:XO@4BgHU6G5YM\H_N8(^5T8]/[7M7X,EY1a0XME2_,2)@XMKM0T2)
1P0+.O#UW+T2a^7<J,6YGQ\:HH-\&=Z#7@07<N.e,C_N6PA.)J;JJ^XHMe:]2LYY
afZX/6I]K\;_e(31LL230JVS1fd;JISd1DHAK9AQSI1gSSWM7^\Z0gcDbc=g<>YY
P,IS3W\L-YX4,F4OJLS->:_/b8YL-N3^Zc2VTW_WPF6P0I_B)7[87A=UX;ZW+@Z7
0V<-P2Ba9D=-?-dL8ZTQ13V;(+8^e?@6E(],c1DMPIDRU3)0[B=DL8WHKeZAZb93
?F?cZD1;d]WEaENVQC6e1f>fA-Wg(CRQ>_F\P>,ebZOQ7TD^@F,c9f:^U>S-f&#@
cQ(^/(,LCMNL@#-H5?B?X_IgQ38^S;#KVc_QcQE5b;O/&Xc>WOd2eCJ7((3b7M>/
ffb14ZIWT.NL6Q9@F-DPRYEW6N5K^/dC5cP_C]2H+DT:^fSVe5>d_^P9>Nc)EfYP
JUc02+1)Ob/K9L[@HWLB6:T-RW#6G>BCC_gK&=NO4Md?/&XLHK:OMO(J,?IBP&O5
#/3/FDPUDW7EdTgdIVZ1PJg>2#YcZ>BZPCKEAL7UI4P\dM()6(Z95CS8fZE/I5PD
CV.&Z?^fFYVB1;S3))?>TXS6O1>Y3B4C3L8Pf^K-^7K:9.Q:O?E56P+aW<#1d(g+
IBVGD[(Tc+^1,0881e=5>g][f,L/f+9EGNOLA+1UD8)^DV+2IO\F)Oda7eWY0EV:
19>OT8UQF@Of_LY4N?JeE+4@=_EE=VU>aO;ZM(A8<NA7O,B-P.6J57@\1G]aM2XD
2XVNAUc>C7HTTPbc1@NBEe,4L[(O1)P?BOH-R=^60X0BG@gUUI^BA6gJJ3eW&26a
T5,B7gD;b,;-H:f@bgcEec)\B7BPNR(^ceY2I59^9S9UV[64-QAgT[ePaFAD34+\
3<#T1S4&QA5KHFE1?5;_L00YR7@e2^-EQH2SX<94?W([e4]7)URS<)Ze[APc@]e&
H=S1^)dbN^B=8^=8?0XXJXIJ>EK\TfeB4YaZ]-;-#,TTAdNOP-M94QAf,;4P/be\
0D,D5e\.^U:4W>ZQe)<GKg=@G(KQIFg#CIf0;^WJfET;_P^QV,03SGQ/E.&&9)8c
d&B_7>3=O+,X<#FRV7FL-6(7G>U^,\J[Y>CH)(UR>0dX_6D(<NJ]8[,M0fNH[TBP
L@)PA8W3bT@I[AI?/-5^,(-CCMMc2>R8O9f[<K?a5WPM;^7,aeZd9^]STZG;TGTd
JKc.+0Rf4K<0U32/>?^JU:/0N>_Cg#1.BDabG=43P=d1R>9b??UW&/aO7O)5Lb#g
/a(2Mb>;c1UTQKS,>KUR;@_T[fQ7MU](DWT7/XO:JC@G7I[(HUUDB04+OF#?D7DL
O>=^-T2QK,/#M>DNNN6U8He@D/Zg(C8,LaHT-5\J>^HM9#6##B-RITHJ=fTS<b\+
3S;^9E&4BbPa:0JX;Q4<K;X;9WOO(eFF&&&.839:W<TL+U,A[0NQ,Y9(a=3_9^aS
U]U3J>[e]c>G[C:P&eeD/BZU=<L=HP+IB4W:P?d6eM8P&&6:J&(YO)K#)[9I28>R
:8efL(##(655GE+A=R>70<EN3FG+)<;TWO@aX75W_Jgc54W?YJc)D?-T7_88GY\2
AfHWPC?]-gN2>Zf?3KSSa/.f.&Y3H^Qb-AJ^DG1L[IW-\fJ7g^&X8N+HGI:<]@e6
/Z9eIUcQSI=#0_KggHdOOEe)IbK2G<9+C^-L]C4,#=0,ZYGO==9JQ@c0)&c72+B\
>0N6T&,\=FMG5E0>PBQ\NC-\U<\MQW\GD:fBT,?T^Z0,R&FGe(I^4NT088O94+a6
)b54#8Tf+WM7ND><9U-WA59=ZSdaRF7;:N,?P.4Y8F[cf;N2d_K7/29-d-9Q@#>_
C<R\Jf,AUbUQ[Q:G9]B(f70[66.a^^=NRYAE4Z-B2>WI9G=<AEQ@SJOc2T[UFY@\
\^5Fg1@Cg5E\Ad(1T\&b]GBLNF/=](=dG(.S#BY.PN/+6Q\L_94O55adX<&E5Q9C
MN@AB:ENg6;/A==TKfOYcX14T67N_a[GPN;1S=-V[bMNOB9PRO1-DGB53;d8@ACN
Id-\2&G]Q)=69d>EWca4YP#X1XB/.4&?O>DS69+,L92+(O?=(.CWcU_6-9-\+=2,
==\VLY.#8_FDX[<?QTO/5[7^#<ASS0HbY=OK6W7P^KM?)-P_c[=YF/>cbI7Xg_>1
P8:URMc8YU/V3C^VYRIf>582C]R+P,>)4\>JLN;7E\+;fSW3/[6HEPE[/f#YHET0
NFeR?&635H_AcDSEZ>gD+MC++QecW5]PM4f\=fCYNG^RCFLG0LVR#/-Y)00gY<;Z
<C#c.?6S;KD60\e#U1WQU_JA#PB3C#G2[T53+/2&SC[QEI979ddOV=^28WY.d6f>
N]2IKG>SC5@,5(d5MXA1@[\@5O+,9[P5F0f)R+V[c1.7\Je^@.:ORXb/4UGegER8
+\)5XA?-0d^ga)X@7Ia(XBYA&H&C<&6EB8\]:d\0NK/2)<2Ce+3RdZ;CR8B_AVO1
-f=d9aE3ebfF:WOcAALG\/P+RJE3QJ=Y.\@Ad[Ra_5AK_5KXbA>)OJAE90;Q.M\T
,7F@e1WbY?1Nc22E._=-L611Le.L-@9F[WR7QKB.X(eL]Z<)9MSX=TRPHW<DD.Y]
#S:]5,P-^/HIDEeS<H;Y&=XSWGY[_/9(Y8]0WI:GQFA\/1CfT;W/-DNO(KL-D(;R
U>4S:5^)(AaNO3[)D/RZV=V2OMgTPY:aH0V9_,3-Tg9[bVeTC-CX[T+R^L+3P?T\
#\)J3IP<g#S:gV;YfVSGgRFI.DM@^+L@7bZY(Sf:N&VV\9+Y1DZ9=B;26NA/(MX&
Q?/C;GJ<E/+]#W6PGePR0ZW=RO8;feHEV9^8C5?711Zgfd,\\YaR9TC)KW0b6#Z(
[WfXCG+.=4,?JV6;0N.#dcVF;(4TB#:H\gCP9@HC;G<Y)F@R[:XSdg-NVO/0&1DY
_=)?]@VA/9W]D4J+G4MC:CO_EJP/^ARcHY40I<0+(#]KVd#d:/UdcJD&ba8c-I:O
gZ;.@[LPfN#_H^fcFbGNefR63)5;KcZORAWSHdUPG3A]2XfE#)-_FcAV]2RL59V8
dGK+C2B/UL0.P;7[PCAD>;BO=CJ[Hc+D2\20;[f8J\H&OSZ?,I>MW;.:3]6G=Y^P
,^_4JPIaR8J28e(I?K0D=M?CMRC4b=#,^?7_Q[1BG7_\532N:-Xfe>E8AC(L.EO.
OXQ_;Q5gDB#;=b#)RW&->7.Pd\7SMC^9Ia\GD4^fZDE:E^BZ:=f0=)6V;D2&OXKV
e&(6--2c5:)L0\3(HH#R,[[JO]1K=4B+#3<D;WB1P.c3aP2Qa98>U@KCUg(e\,P,
C/E\b4-3,g+AMfIUQV)b4HC6Q>TfJXVP2D?F36c:+6.Id5)VW[\(<;XY8ZcS\4,d
^VZ2<eGIe^dG/d19_X5T<8:HFbNgYB:+.VK_4bF1cH)20Od9,]2<?I7ZbK47Hd;T
T)6VUcP_TRAB:Ab#A7IP,-7),/?B3>3:-^1S9/:Q3NVZ#D]GL@8fCH:A/gMF/@,S
MO,9K)LfO;+4d.2c\H<NH]Xab1BEYM/8#Z^b?BaHYO63QUeA1NV.+f0B8Y.#g:FZ
H8&,&[Q4MeEa^2^e?[)7S_3=YY\MIMX[a/7;ZN;=D@X=fZ?:-,?8?NAI9=\d.fH^
S\Y9QUA40E5I--CUE=>>5Og.4CX@^L=L]AO.4/;F3?5A:(Q#)+0J0;e^&K[+;Y&5
19MIKg&2;U3_E=Y-cGP<@U\)^VB]O;bbaHNJLTI4[0?aVELW=22QY_=;:\+X/?\C
6aE)g_=687HIW\PF-c6PI=?JH1S[aM1_a2B2-:\c-XSOU>7J@A&Y4<]C2Mb:ITE6
8^HL\Y#1aYJZF<SE+_dHP9\9g_7]O\;H?I<gE9S2V5=[f(7L<&ALY4Cf,(CD(C7_
T\:0QA7/^,O#&F\afQ.0W/>W/Ydc=QaegXE.^OC52W47O@.?b;1c4IT.g&8aEbR=
\&.;.QII\I977?4#)bJbd-<aM_AMb#Ie=J0K4[D^9-_(ABSQ,)>4c6a]99UfUU8#
/^7IHF\2gLYca>OH;\66&Te/,>LBJF8P0[75-/[#BH2Z)bT&d(VH23RW>FYLHSO6
MBe\C@U#94CETW(abV^-cV&TST)bc/4SOLNJK04K7=88EeIPIHH=T?VOI#^;MYe9
NLC_R_8=T^NSb@+<T._ND@T^;G\Oca)_VL+b(@=Nc-YG@Y>IPVYUA1ef5.=G.EG[
dO(;Ce^4g<H0e63?9>9cX9KG^<Wdf_YZ=\c^PNJY]5cUE,:_J^89T?fNH4/?3DV5
06R=XK4-<=PT0IHgQ/L[SQMA2QH+B8TY<Q6XN-\Mg5d7+?WYFG1dZ93Q,XF+CTF2
YT&D7(@-DK\I:W>PFWA0BM5Da1KLO-O-<aD:;:MA5IdT3ab?ES-6@)[J?A]\97KJ
=2UTES/K1O(0PQS5c?ZWIIC[TWfQTMcGbB1KOcf9#V;?;T3L2.WQ;,Tb)9B6&.+6
V.W<0d5S8E1g6Q#AO;W(.cWbQS-^\.H8Y)H<7^ON.L?=Y[_</LLO-B/#@OK?Sc./
6@ODSC#ENX[=<YG:EaZ[?UF\.)_PD4/&:cNH>Fba9,TR+;H7LdQZ_@bIN-@fCJLJ
@+.V7WS>/PM^1ZZ(-^gY,3.,40:W1a>:Dd+8V[A8P&b(R:?5T/C,^CF@HA;.D)FM
WS-5?5dgXO,-TH6S[]=IgKTKe5@7TKb.+>@XJb_c(A+)\5#bCUEU##7=61\&W##^
#aW>5ac&X3J;)FW+=TA,U\)GML8R1ET-H9K>Q[.B#_fN+5?C:3A)WV5e\W4/J:Rc
W09TE4Y]5/23ABN>Z)T2QfM/WgI0,_[c&?.YdAe)>,)K@cR]5<;4AHY^KH1c1)3D
IN@H3-cF)aYF3=C&)VcB0_.@DLS>7YZ5,8K29]5SBZ?&#bcORMg0Q@RWD&B]4B-I
+<DbLUFWRfM,/]3V_&_LaH>9CbS8-1N+=H1HQWB9YDA_+5+E12<W1[Nd[5;6]2Vb
B3^THCW,QT[F?YI)F,#.][:f7@c&SKT)d7UJ5U/K,ZJ0BTTM?<SRgR42SeZId#XC
.Q4CK.U/2J.8+>F6^Kg<4aCPWCI7Q@@N;N\+HULCB@>faSQ]Ed&6A.>L07&;:XKe
\Vd2Jg6+2O4G-H(&.K7g-N-f\SQ#,5>a=V;f(PWK+RT^+g<@4Q-?a7&7ORYMe=VP
&3F:LG63P<(@LQK>HGR\H3O&,:cGXRC;0&dYTAPcXdd2HaCUT>_>D@L\\<1G^9#7
U3[@,\F<>Bc6)?_JY;7_.SgGf_@D5Z7W-X<2MeO?._e+T&cU-5Z:^OW[/]6Fe&aR
EbKaDWK.X^A1<cM\QO7_4.M3TLgD3B3KK6>dX^IGHSUE/62D08FfgDP.WPb&e&=Y
@Fe;f+SAF?)+Cb1&7=,,V@bCI)?/)H0OWcbMN[f:d1M]4I\9M(T\CH)V;+=1H,K)
Q/0A3JYH<C2d(Qb479AB>91+[<@4VX@:;=Z6@0&9M?[8&d(7<gfeTTW8F8_7FEea
TWASGW?:R0b#)[\6.fA_<a&>Y)5cc#JKR\S3(GFPb8(GQZ&EI[@SQ>TY4C-Z>^X1
L+._.2#\65eQMgd?U-dICWAZP]]G&G&:BX9#/b=KF/3IO+#/:GSa8@:C-?5R/a-\
b,UZ<6@d\V4G@F?__b=#=#12ZM=f>&U>^C2D+&bEYdGV[?D^96(_(E,>.HTG;P_e
ZVR7S<)_P=EWMb>HaLf#=(:N3Y\0)]3D8TI5L2R[>QGZEM5J_W#ZRBc;/\7R?C<#
.\3d@HV^;5dTU/5I63c<TgFA;<R5[@X</<5P?TgDB;X2H8g?eHO37MUe8aZ\\_LP
>VQ]PM&FAZ/=SY#G.3WE09?K>.INS^)M370FKe0]LVBHW]eW,&N=4+YVQRL0\Y;e
U4JWgKg[OM-bJRFDX;AS-J4QR#+]IcW=C28d,A7((EP&)<K3K4;];V6=R7ObP0Kd
D4E+(16HTb?J&N.:8/2\EPS-3J5X=,=GNJ#b.=>2D#4>34PC62fG(_8G?00T\OgD
KCME3g<0-I_FM8;W)-b,&gBLd<)/IZAHBdK0F#DU4Z:[)Q[,dS3QB,V(3a#M-(^W
ObMJ\06?L78E2/-LZ6NU)+T2[U<AfUIKeB+g1XfS2P?B>-6?,BE;RDS?X,SX.Z:P
eUJ^B/+]DP98aT:Q/V8_Y,gM-XX]>WE1522-5[1da\-5V_>TN_.W(\6fNLJZ3VCL
2.B1G=AHAcZT);G_4K[Qe94X30\2:aA6N9fO]^fCCe?P.NQHP+OG9&OB1PC#?DDQ
C7;U.(g389CF81OUgfZE(e61BJ#[AQ0@T?&[#6J,5G+BFEdXG9?AdP/g]g1PD2+^
.^4aLa7LTdX5RVC\_ME&:MD+14;1Z4RA:4/I+EEU]E(2BS?:8W6VIIdB##22V(d>
IR&Bg=gHSAIRcNJCOT2.UUV#.)=2Uc#H3]76Z:YMI]1e7>31]aN)4b@\HCR3f3RG
EJQWYc3XO0XD0OSb#:N7WN?SPcJ,(?Ue3DfA68Q+MYB4QE[S=3gX+I#CP)OGXCbU
3)VA-+EMeU]@C\_10Jg49/26)Z-#a3OJ8JebK4[VW)d0WfA)ILDa2>W68N)1\9F@
\A@=E36,AcOLO.&+AJ#.Q_6U\c9Gc;e@-dICF&IL7G#A1>Td/L@7P_6>^9&9PNQ&
;DG&5+KVHG+Ac]Y#X]A091IQ;\9=P@)6_?bH@Y<)9B[a>UHP:?bg+(C?)TR+0(#7
(Hd5&BC#T@EFLc/?Z48Q<]&>?NW6dII@b:7F+]Xd6O,abS.1P0:NRTX>OM-WPTdA
#\Q7O=#KX.JQU@L&>+fJZ_;&(NeRRVPD_3W3LY>,Z/@cTDbCCHb@5IbM1QFe>QJ:
2^[#5SF#DY;(5ISXfN?N8NWHa)Bd+:HJ&b/FNZ>fUg5fHITSZP55K]837-+=TJ7(
._aVYa2\FR(^BMX)7VBEB-g1&cTO+?K[<0bXa9[WeE53Za,;1P>98b)9&#Y/RCH,
J=E2W]\V;Sa-XU_@5TS8A<U5Z-EW5H9/KDc1KJYY/dEb-NEX5FD<B&&GB@,AV(<=
8T:TI>E;Pe2=ZN=+2(Sa&1be<X0OW:C7/URNf+N=B;@_-<5;6_E)(=;P?)a)7#CM
5]+b3b;,/(Y)GP5+X]Mf?:4eC.2N(9=CDa\44..2S:C+J1SN;Z[4S?QG+O,QY03G
fCSI4:f2Rg@2&;X)g)G+8R&YTU&O-b0SV)N;Z&NS]BFV1N:f2YO^:@.+(YT5SW6]
X+)>K?_D/LX\edda-DgF^^M31[[(Z0F9dQ6VJ48MIO@Ic1&[9Kc400H0<=R\<(]9
F>\+YaWJWAf],0-K7S[UN3gd/C(1Y,&&BSKf8bRNB3]8#]=+4,G)K]5g/]-R.FR>
T\E-HaZ2C9<85N[[EH_U;IdFZOGI>L2IYK20##I_<,135K6G9KAQ0C_QIP)L4MEg
>+=MS606K9PN?YJ8H]@g&DE_@fXf0THA=]RN;(I9/^4G(cZ=N#bLG]CBKZYg@EI(
9R86>.dV6YYO+?(DA]9L0B);:gM\fN(78>Zf44,AY?&2@]/L?X;-/b[JaQ1)(B2<
HCL]-[T&VO9WQ2BNX/T:X.,?gE4L-5^>1U-BPOQXHD?E(2Q2PYIdF9c4</IG#J2+
Z#?gJ5K.W0ae]WJ)621NPG_5W-41b>C@F:_3>:Q2LSA67PV,f>F6.(]S&B>H4(]V
+aJ[Q6KKSd>(CAB6XRE?_-<5@OfZUVdVc\3OF+>4<RDZTa#0b\fbJWfPMHX\F4IR
fOcaEWP+9CMZS32+W,-K4Q=JaYVKI@0YNUW><<d5W.UUa^.@3N5I\FO3.(C))001
PM<3JPULBBOS#._eWAE]Y@O_858G=c]P:d9b&Y]LI/Ug=P.bQc[T^>EUL2,SH+EA
95:+L0BMI8:\IU<a;EeaE9#L3??R?^9-,WUIN^T9:aCL@&NA2)ET(DN<Zg=0UOcc
LY>TZ+V33BN/]&VJCX5[4CJ&?NO@aJPZcQ,UfL9=8KFeJ57d]W)NPG<K##\f7>.:
>+=AM[6R10ZHHgbI\PP1\#\fb=?gY@E5c@P-<\^M7+:6++SVIC]F771]\9,MRf;;
&[1+H_)L=SSVF:WQ>G]?_LU#ca?9fX]EMb?M;-LSe;cTe<41><=GF?b,X&MB3S)3
d,0@O&[F[#;;ed3(\dZ&a1)PcNMbCa]WBPAZF(<#Y)Z,8Q\J\MKdL0<K7?aLdI++
?AGKU#[#HNCeLAISf#42Y>1=AN>HUZWVH,6d60#R67M=1)XNLHg7MPD9/ONJOW8L
4,V)&5SgP@NOPMDH6WZT@YJR#?M(bV?I8U5HE2&0/6D5(&9\<]U@>fE02Z#=A&+R
O5;85<CQP=:-.(@ZQ___R9+#PS6I._T8T@7cZK(J#9#>\Y,U1SJa7V8L,c87=U;#
_()FK]7@R&8cRJC8QMAGYPF3XL6S1L78?A=CEe=BY,IQ>g@+ZBGc=T9XY66Cfg:a
ZDO=FOX9W>_>G+FT(?U6fS+gbf3\aEBEENF:dc]]N4@]);^gb3dA=W3.2a#gV?L+
0;4dH\:9<f(M3?IR3,9GZac7N]VQV-BY^f>[JG@=+63JDP@J8OJZaO)]\>J8L^R8
<O7N4,f-+a(PS(CHM5L);F.L7A;U_L=/]:02cN?U=X6>Nc#ZDM,IcY(]NW78DZfX
M,U+ZY#UFec&TGAF?3_eZHb^O&gDc;3?T>M?+UA(@31UQ&d(.=\1)<?Q3@XeV6Nb
C?/J+-B.:2AaU/:^H1(UKRLT^)_/2(KZVfY3;9(HV.EVeD=C[:gge[I^g\f=5-N/
I[2[g5[8ReHM1.gN<_P3:\3<URbe/eA>:^^L?:9Gc:EZM_GPSEM4538TF=^]gRAb
W.YM>=4&fcX6,TR<&B0QMNFV3aA1+8]CaCTA5(0LIK5C0\dUIS]O\XKfJN2\O;NT
C4&5QB.(Pd4TI7BYIA3D+b;;QY8_<A_/S7B@/LZ#Qb@#^,N((J4W+eIWBTA/Re#8
RgA-REd7JZ1Ld_e0F;efdLEAP\)]F=c-0AEb?2ER5TBX9_d2gP4,@?AGA_.D.7B/
BVe:)._OM7e^/V<RC[/A6<Y7:).-F/ONP.U/YSIFS^eSZQ6X,f5Y0<AGM$
`endprotected


`endif // GUARD_SVT_SPI_xSPI_COMMAND_LIST_SV
