
`ifndef GUARD_SVT_SPI_STATUS_SV
`define GUARD_SVT_SPI_STATUS_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is the SPI VIP 'top level' status class.
 */
class svt_spi_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Reset status indication. */
  bit reset_status = 0;

  /** SPI Status Register. */
  svt_spi_status_register spisr = null;

  /** SPI FLASH Micron Top Register. */
  svt_spi_flash_micron_top_register micron_top = null;

  /** SPI FLASH Macronix Top Register. */
  svt_spi_flash_macronix_top_register macronix_top = null;

  /** SPI FLASH Winbond Top Register. */
  svt_spi_flash_winbond_top_register winbond_top = null;

  /** SPI FLASH Cypress Top Register. */
  svt_spi_flash_cypress_top_register cypress_top = null;

  /** SPI FLASH Everspin Top Register. */
  svt_spi_flash_everspin_top_register everspin_top = null;

  /** SPI FLASH Spansion Top Register. */
  svt_spi_flash_spansion_top_register spansion_top = null;

  /** SPI FLASH STM Top Register. */
  svt_spi_flash_stm_top_register stm_top = null;

  /** SPI FLASH ADESTO Top Register. */
  svt_spi_flash_adesto_top_register adesto_top = null;

  /**  SPI xSPI Flash generic TOP Register */
  svt_spi_xSPI_jedec_top_register xSPI_jedec_top = null;

  /** SPI FLASH ISSI Top Register. */
  svt_spi_flash_issi_top_register issi_top = null;

  /** SPI FLASH MICROCHIP Top Register. */
  svt_spi_flash_microchip_top_register microchip_top = null;

  /** SPI FLASH APMEMORY Top Register. */
  svt_spi_flash_apmemory_top_register apmemory_top = null;

  /** SPI NAND FLASH GigaDevice Top Register. */
  svt_spi_nand_flash_gigadevice_top_register gigadevice_nand_flash_top = null;

  /** SPI NAND FLASH Micron Top Register. */
  svt_spi_nand_flash_micron_top_register micron_nand_flash_top = null;

  /** SPI Rx DATA Register. */
  svt_spi_types::word rxd_register;

  /** 
   * SPI Rx DATA VALID Register.
   * This field contains the Data mask bits. Supported only for flash Mode with DM feature support like apmemory <br/>
   * This field width will depend on the value of data width configured in this system by define SVT_SPI_DATA_WIDTH. <br/>
   * data_valid = 1 : Denotes that corresponding Index in rxd_register[] array is valid. <br/>
   * data_valid = 0 : Denotes that corresponding Index in rxd_register[] array is not valid.
   */ 
  svt_spi_types::word valid_rxd_register;

  /** SPI Tx DATA Register. */
  svt_spi_types::word txd_register;

  /** EMPSPI Rx Header DATA Register. */
  svt_spi_types::hdr_word hdr_rxd_register;

  /** 
   * SPI Tx Upper Segment DATA Object.
   * This contains Data Register and Data Valid Register. 
   */
  svt_spi_mem_data_partition tx_mem_upper_data_partition[];

  /** 
   * SPI Rx Upper Segment DATA Object.
   * This contains Data Register and Data Valid Register. 
   */
  svt_spi_mem_data_partition rx_mem_upper_data_partition[];

  /** 
   * This dynamic object contains NAND Cache and Data register. <br/>
   * Size of this array is determined based on plane select present in selected <br/>
   * NAND Flash device.
   */
  svt_spi_nand_flash_data_cache_register nand_flash_data_cache_reg[];

  /** 
   * This dynamic object contains NOR Cache and Data register. <br/>
   * Size of this array is determined based on plane select present in selected <br/>
   * NOR Flash device.
   */
  svt_spi_nor_flash_data_cache_register nor_flash_data_cache_reg[];

  /** EMPSPI header Bytes decoded by Agent */
  bit[15:0] empspi_rx_header;

  /** EMPSPI Payload length decoded by Agent */
  bit[15:0] empspi_rx_payload_length;

  /** 
   * This bit indicates whether the value indicated by status bits <br/>
   * empspi_direct_write_selected/empspi_direct_read_selected are valid 
   */
  bit valid_empspi_trans_type;

  /** This bit indicates whether Payload length indicated by Status field <br/>
   * empspi_rx_payload_length is valid or not 
   */
  bit valid_empspi_payload_len;

  /** Indicates that DIRECT_WRITE has been selected in received EMPSPI Header Bytes */
  bit empspi_direct_write_selected; 

  /** Indicates that DIRECT_READ has been selected in received EMPSPI Header Bytes */
  bit empspi_direct_read_selected;

  /** If this bit is set, slave select output feature is enabled, if MODFEN is set. */
  bit ssoe = 0;

  /**  Indicates current SPI Operation Mode */
  svt_spi_types::operation_mode_enum operation_mode = svt_spi_types::SPI_MODE_0;

  /** Indicates whether SPI_INT is active low or active high*/
  svt_spi_types::active_mode_enum empspi_spi_int_polarity = svt_spi_types::ACTIVE_LOW;

  /** This field specifies whether the EMPSPI payloads to be transmitted in 8/16/32bit word size */
  svt_spi_types::payload_word_size_enum payload_word_size = svt_spi_types::SPI_8B;

  /** 
   * This field specifies whether the data is transmitted in little/big bit endian mode  <br/> 
   * LITTLE_ENDIAN : Indicates SPI LITTLE ENDIAN Format <br/>
   * BIG_ENDIAN    : Indicates SPI BIG ENDIAN Format <br/>
  */
  svt_spi_types::endianness_enum bit_endianness = svt_spi_types::BIG_ENDIAN;

  /**
   * This field specifies whether the data is transmitted in little/big byte endian mode  <br/> 
   * LITTLE_ENDIAN : Indicates SPI LITTLE ENDIAN Format <br/>
   * BIG_ENDIAN    : Indicates SPI BIG ENDIAN Format <br/>
  */
  svt_spi_types::endianness_enum byte_endianness = svt_spi_types::LITTLE_ENDIAN;

  /** Baud rate selection. */
  bit [2:0] spr = 3'h0;

  /** Baud rate pre selection. */
  bit [2:0] sppr = 3'h0;
  
  /** Mode Fault Enable. */
  bit modfen = 1'b0;

  /** 
   * This Bit indicates that Negotiation sequence has been completed in <br/> 
   * EMPSPI Mode.Negotiated parameters are valid when this bit is set. 
   */
  bit empspi_negotiation_sequence_complete = 1'b0;

  /**
   * This bit specifies the status of Power up Sequence for Read Status Commands. <br/> 
   * Logic High specifies that Power up Sequence for Read Status Commands is completed for Flash mode. <br/> 
   * Test/Sequences must wait until this bit is asserted to enqueue <br/> 
   * Read Status transactions.
   */ 
  bit spi_status_register_polling_allowed = 1'b0;

  /**
   * This bit specifies the status of Power up Sequence for Read Commands. <br/> 
   * Logic High specifies that Power up Sequence for Read Commands is completed for Flash mode. <br/> 
   * Test/Sequences must wait until this bit is asserted to enqueue <br/> 
   * Read transactions.
   */ 
  bit spi_read_access_allowed = 1'b0;

  /**
   * This bit specifies the status of Power up Sequence. <br/> 
   * Logic High specifies that Power up Sequence completed for Flash mode. <br/> 
   * Test/Sequences must wait until this bit is asserted to enqueue <br/> 
   * transactions/Service commands.
   */ 
  bit spi_power_up_sequence_complete = 1'b0;

  /**
   * This bit indicates the status of power Down Sequence after Vcc drops to <br/> 
   * Logic Low. <br/> 
   * Test/Sequences can poll this to determine the status of Power Down <br/> 
   * sequence completion. <br/>
   */ 
  bit spi_power_down_sequence_complete = 1'b0;

  /**
   * This parameter is dynamically updated with the list of PAGE ID that have been <br/> 
   * updated to keep track of Maximum Partial Page Program operation allowed. <br/> 
   */ 
  bit [`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] updated_page_program_addr_list[$];

  /**
   * This Parameter is dynamically updated to reflect Partitions that have <br/> 
   * been been Programmed. This page address is placed at same index in parameter #updated_page_program_addr_list <br/> 
   */ 
  bit [`SVT_SPI_MAX_PAGE_PROGRAM_PARTITION-1:0] updated_page_program_partition_list[$];

  /** 
   * Indicates which plane should be copying data from data register to cache register 
   * upon READ_PAGE_CACHE_RANDOM or READ_PAGE_CACHE_LAST. 
   */
  bit[`SVT_SPI_MAX_PLANE_SELECT_CFG_BIT_WIDTH-1:0] cache_read_plane_id;

  /** 
   * This stores the value of weight controlling variable which determines how often <br/>
   * the RANDOM value for DQS initialize as ACTIVE HIGH is chosen. <br/>
   * This is applicable in Slave Devices Only. <br/>
   * This is currently supported in JEDEC Profile 2.0 Generic Part Numbers. <br/>
   */
  int multi_factor_wait_cycle_latency_wt = 50;

  /** Specifies the Vendor name selected */
  string vendor_name;

  /** SPI Agent configuration handle */
`ifdef SVT_VMM_TECHNOLOGY
  svt_spi_group_configuration spi_agent_cfg;
`else
  svt_spi_agent_configuration spi_agent_cfg;
`endif  
  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_status)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_spi_status");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_status)
    `svt_field_object(spisr,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(micron_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(macronix_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(winbond_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(cypress_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(everspin_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(spansion_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(stm_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(adesto_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(xSPI_jedec_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(issi_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(microchip_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(apmemory_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(gigadevice_nand_flash_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object(micron_nand_flash_top,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(tx_mem_upper_data_partition,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(rx_mem_upper_data_partition,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(nand_flash_data_cache_reg,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(nor_flash_data_cache_reg,`SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
  `svt_data_member_end(svt_spi_status)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_status.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
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

  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
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

  extern virtual function svt_spi_types::flash_protocol_mode_enum get_spi_flash_protocol_mode();
  extern virtual function bit [31:0] get_spi_flash_read_register_value();
  //----------------------------------------------------------------------------
  /**
   * Sets the configuration.
   * This method is also called upon reconfigure with latest configuration class object as argument. 
   * This Routine executes the necessary steps as per selected mode when
   * reconfiguration is invoked(shared_status!=null).
   */
  extern virtual function void set_cfg(svt_configuration cfg);

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_status)
  `vmm_class_factory(svt_spi_status)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
8AfGF.9D>>FF1@QdEGH09bJR]P@&2.Y1:XdJ6NQ;X14fG\0b;]W86)5EY4TfH<MG
=^_Lff7ZV=N7.H>37R9:PbG@8I;N@Ubd^2f.O:)ae[Ug0dJ[>bUbIVJg7H@bF^OE
#&S>RJZ/1QX_Ib2.4X2d@:VfF/Yeb/dDC[:<MEIgWL4P2.MWGb7TW^A;95eO0dMB
SPfP^I-;3S3<;^RUS[=#eQHZab)V(gHYLgbT4PW6-V.:bA45aZTXS575U6(?a9,\
(Z7<OJ]HTcZKFD]TZ1V0]Z?;,F/QBI9B]<52W6We([5<7N=cDBHP[46VN(Q4(I+(
=;>+S;?[F853NF9aO^W[H[:1.ePH;@]?@X/K+HJTfe0TUBMGFYNX\WWM,_BYYLd;
(7(.+8F.,f&R?C.RE?SP&+R@>_?@<[fbFR:c28Ta39C+K,Ac^.AQK+ZSCf9/4A^\
/A#f;2TG@MVg9:BZ>^93LKNFP.9&2GXL4LYP_O_fAL[9YEe2#&3H1bK(T1L\]La@
73Nb3)6(fA\IRV4]7cd16Q^ZYKGYRe1I&4UL\[P9<a4-f&Q#\2I0<;E##fH-L0,>
gY9EXPE2YBU]9=UbYVN5UGBPe6@7H2JgN/0M2XL]6_fLR9CB<#V)NRY5fLQRZ;-f
RE1WNY8)P)Z5^_#9&L5P:f7>UD)b\Hf&=$
`endprotected

   
//vcs_vip_protect
`protected
-&/O=gGHCVaKcQQ4EdY=X]RX5SDNRGT[Ud#F2b4+b@Xf,Tff#?>#7(#6,N]gGbRP
227cA8Z+EG:KV[^#-RAV=(U8,b2)(.bT8JT5V@)D]5Hb9?GEXJ>R>AV,W=2_gf^A
IY=7SW[S.H?S1-F>1NLE]QML/^fHZHf<#[X2(D-EDWM3-8[I4@&C@Z9-8ZR]?@#M
aSE+]9,,.RPW7W)#8#9bA8E7,CZ3&-LJ:U?HDa,=4<\6?7>gENAZ>-gFA5QMZIK0
-4A#;3JdfL3-A)/7KJP(L+fBBd#bVNVPTf?d.@1,,RH1TFSY?BfbY.FSMgMJV8#>
EHH44PA09VOM>6]bP,G5_4BJI4L+b.V?J?<7M,f:B0UJ@LKI)dV[(/2K<CBCFETB
7g0:JGY1OHa]IGX]L<WR\.O#GO5:6E#<<>(T7T^U,Pf<5+E3)9H02FOP>YI0Nd\D
WW.[/?cO0P]4H8SLP=G&RXb_VLZfJE:HM+f-8d740OMUM8FO(;G;L8Ka_aQDB?=)
)Y_F#\=1?C^dE2XVG^4_;W)&N/bYUTbNa-MXI4dQ=EGK#_ANGJ;/Hf;^TE](M])a
dT5=W)1&2a4A.Wb2[gdYeXV9-F-Y)=Y@5FCM(badDQ>VgRZGH#,\0+UM:/[RKH/_
J2/.F:1eF[c/Z^RO\G,N.:T9cL>;G1@/)/CL:E\90dHQNQEZ,N)6IQ_Rg&A-KNcF
XQ:e&GgC[0E&^Y&]+fGbTTAB54-#d-^-[X@_O;))IY6>(3DL0H_PBZG-H[=^Y8d6
dg_D;H2-Q.#+<C+Q\\V2fPL?(90T?;.7>NfML+XcX-.cg[b#C0;\EKC#+F@EIJER
SA\,Z(M?#b1C.AT55W-,MO_=Mda4YH9+.90,(=VAYAEbfI.B.Y.+c^G7dQ#8W/Y]
&-EAgI+9c1=>&_7Te2<OHYMb7+86LY56Qc/GUGJ:\CCb8W]gVf,F2\QXJg\b9Tb?
-&HTY7N\>=dP5fL1EOfQWZ?-GbSD4?)J47_(dQgE5NG2e&]<+Xd>6eDJ/(S9IS))
.5d<PLIM0[H6EUGO[Y>RgT<0.+;.0F^KLLfTX)^V+>L88ZJe5&>#8+L&[9Qaa;6.
TeC2GZIf\R\390W<HS4F-Z;[584?3<]+g;CBT71+K>Hff[&H3SFZU5&EK\M6+bb8
Kg,L;ALF;7I97=M>U,bRPP(4CYKRE2-d^eM8XQ/f(</;:K:DP2c:Y02NM6NN7-0R
NeH8BH[&WAFEcD73A?b5&3R+4.R6)>7D-bA<RDDD7Vc61&:0T4.UDN3GR&BZ4=&V
3<fK,>Sb^@[Qe<c:J=?D-)KY.N)PG@9?Q[fCYa?)\P2F2/Q<cb@b7S4cXcJV(g@a
e]g_JOb^;,AagHX[RM\&e[gKe(Pc?CL6d/OR=(OC30N^RF.e#a.RM.Yb,3K/Fc0H
HRDa8>913FD??2(]5--VYd1Dc,7a<P3L<S1H<\W>(28U/?-094G;^aFQ1KQ;=[X&
aRPP>c-[OU]c37VC5Q^gGH;\2[WIX([>ZKB_GH^<fG>O-.FDT]3N]3+Y]J&&b/(T
gYEF:05[N+JL-YVDV)e[f(Y<Vd/4G,EH?I9/_,;ZN4,AG5Be4#e]AM5\Xb4VI(;c
:N7d=G)6AO10+\)=]PL,7fe,0[HS5JVgOd5((BD.2\SfD;AB]KFMT3b.AMCUSU#R
=5L8N)4N)2cNbB@M)MYS(.EFG/B4;<HNcPXMR\G1O4+IQ>bHEAP,ITL7CJX/SO.=
VJ(M]N321@U^J\-S#_]KX8_&NaBT][</D<P9D&9-::TO6Cc,b48Yg6M]g?R7(EFD
._L4T<ecdG;b&f^RZ]TSe^VdG:I;?AF@V:?YZZ+KB[KO]eN@O/4T[M3&ZS0>ZfF-
.08GdTV.#KAV8G/P:/TcTG/S5^Z4#Y_cGfLXL,F.[V^\fF\M:(Z3#eEM8DJ3:.fT
W6M>O;7)-:G.<GEA7[A6^H=,@8+RL7TIKe]1Q?I+:gQfD8\6@8U[D2VPbVWNI?YY
U@)2M<L5g7K=cfB010=C[EM60<JK->?#K;K>4J]V>.fV3Z9LWf8BeHe#/KP9]Z\@
2]C>487N>1.7SdD75K8;G#O_)6B).?)^G=F7]9c;8K(@P[M:,fcY<N:1@2gGK7<N
G=Kg:TW(G[@_f(F]9b##M599WRK+,E21Uaeg>^Y;5A+OYIPQef.^W:aS;_:-(aWJ
(,8N#PY:c1S;UJcXT9AR<M)TeYd\OKbU0I9fDf-5??f8EgZD@\1b.-Mc#HeS#9]g
21D=JMIKI=CHA.(:6MS.GJRAK)STS/,DFKW,>JG<,N3M85ZT7\OYU^Md4\=HA3V#
fB5VT))#K^_)[]aY]CJ07aB^?M6@8(A>;Z:eJ0?Wd2dM.(ONL&0N=9)&SCc8.\&M
G@[cfFDAOafGBK,JV[2K84RCE4PD9H)U;7b;2E5g44?N0U8N7S:859Y>\6d&RRMV
U<&e+ebLD:a].I++R7MFJVVae3X+gJGXH1DOJ1DH5fAQ&/P:G&T0PD5.AF?4W2>M
cXJ,7KTE.W&Q;af^.\AedPA.0W^8N1HPaU2V-N6B3<1E6H9gOga1K[TTV=Y@/8KZ
eOaR_[F@CF6&@M7(+e<JB@OSge4OT(gF\J&99P]_,>85(B]U^V/Y&5aO1N9X<XAa
W<MTfXe+7C0Ea73FSKOgSb\F#)O(L:2NE+P-L.&J_W>Z-G/2AQ5^7])^MbM(4CbV
.Fb<Q;;<>@^-S4>1S;6(6S+fP\ZO9.2]DXc3fO1HQaEL[V1\I@V?#H&fXd\QA&3)
,(D?E<HP\_)9\B7fMc(.[)?TA;>Gf[P;Og<G<R#MNWRS9626O]IW8eX8B?JL#WaE
BOHNK<S@Z]1-7?-De^LDF64]@@.<0YYK)6ID=J_KAY;LL-2KFVU6@>_Ncc7Z4.BF
L)L7F]d=,F^SSYQQ.f-e.1WTN.LFCeZA(c0(eY(U.@P<HFdM4J,VRf/06][\E[9X
U_^38ZN34SIY[8E3:C/eND+g3/gI2_.ZWG10F([XX:XARUYW(4aB;Ycc&G\V#Z;=
Q;H@^9Red[,(R+?^EMR<;LSbBFLYe^#W_AV)0dO;EIS&MeTSCO6BH8N(ULZKAUE/
d[\L(:Gf?g4aMg>cbHM_R8_/9?XHfW:cZ@=?NBB,D/KK?QJdW62X+&1@]9b>)PS[
G<F?bIE4d,b&&#K?L<5MIPKMBOg4Z[e/VK1.fB7L-/N:]B/<.Q27WFZAg3^Q<[,#
:+HB[[_2,CS23M;[??MEaCS[df<KO/SW@:YCG#M23Fg.fD>P.HeA9RSb1W(<,:\(
JT@:Ag:M?@.:;S8@T^57/2FMDEdO#_[3(I9XN-INW0M)45f5H3b1S=KL1,D11#+Q
WF;^:LA=EfQccT_^V(I#-_KMfY^&O@.0F01+FY65Q-5INDE[FCBU]0L=5\ZW:0R4
f#Y6&c0/=A8OGVJ;>_\=YbU@U\bI205<N[B:^K)._)I+f8_ICgAc[TB^N1b#[geb
0ZDdF4N.Q]e+K)V8d3Qd<Gb]RH9D1-H2^6,e&1/3\X](S=+7eAgRgA:Z0716<B/0
BW.5cU(Pb8<0QgDW:HKI6F=UBWS4b\H^D:53:Y1>1ZZ/&N[[S:IMRc#PUA&b]T>@
U=&IW7]aZK9OQ/_2QQ0bI0+4CEGDI6##@ZX=(d5ZB0HBPg:0PWC9))4UK9S99FfV
/<F]UG<2+5:NW9&0gXAX)F3J8?:VG_@XJIW?6O6,PNT;NXd=.QHF)P)0NIS>^2L/
Z:U#3W<Ga<&<>G:#EP7YCTb11)KT<QYTC,0+gJeRfPGJD(+@0c(b&Sc-QQO5X,]Z
9AX<VaOU1(O0K+A[4<9=]><-:,U.B)7(?DR?1\B0PX@/J0aZ\C)(/g7De]:K^O(2
UH,g=/)]UU-)b7X&,[)HL-MMR?gRTGV27TBcH\=10K,&AIC=1V/H?B>cc6]@+6ae
><?EBZ(MU-292]D0FfZ>UR//D]QFTR8I>Z-@RO-.Q<BG,PX3\T21T0+[L8,C4>SD
]d^ZU>NF+MH>=:FO[T8JfaOGUB&(51J#+3>8\N(:9Q,X?_NOPD0[[.LQUYPTTFL1
(_FY\cTKgPROP\b<D/D+_\D)K0</UP0O<;Eeg37)&DN0eZB8]M;De@/gJc=2dZWR
#H(ab(KQ)Cg&WAL[aSc[3Wa/+,HL<A.cX<3-P8VSe6=B7RKI9aGa_+F61(>AL+9N
a5?9)#ZC&4EE4HSDU5:]7b<NC;;A=LK__E^O+Y4C5DRBf@<VdW#RX0@E++Z6V69.
c)g[\IRSN?Y-2N>X^.HRO+(I>7R_c55bDZVfW@@;19_T<?.D2^H+1+37#4-H14>E
>e<([KW#Y,d42_N66-)5;KIC@G3X+RR6]+c.72I8SE6(ScHQT..1<8f2KMHLa_DJ
W.G1:@aP0(]dI[22GIa;T>>\,/AAY;OSc<?3E]fWE()IeK/?V+N0PT50AaeXU4Hf
C5?GeRR-,DfTY/de+dEV4U,?(:A[)FF680\e>Z,UB,E;F+PgJ):&MKcZfW(YO1>f
\&O^^M_ZX2fOLBWEB/08a&\0F[6Y<[48R98bM?UI-OgY\_RI_C^34[bG:\P#RK#_
Q]=^NaX_D.TC/c+,OU]c1]QcM)C?[KWTb;6cD1=LR5]]7Qc[FaGFAGHJgFISMPf0
BO2Z]6b8-1-8,-f.NTR^aRef4X;Oa6ADH+6VWMA=EZ[OLMa8-..dHEE4b62KSdR(
1:eE/CP&4;A(D.:S\bT396,1e,M0Y-R72G.?NCRJaMD^0ZROOSRE=N<(A/\:QO?_
eIg<RQEDBD07)<1He8&BYK:bC&:CQ@_T#;GUbS/>5&SUXHQD=K?9SZN(1:T6GB6\
KPS@09GV#P891JB>P3FEP/I1D4@2T^=Y/=Z(<_5NRMD,24K19c;#TS1YO38OJ,<.
cN7>E6/Ca[\>\N;&,,4#R:@A[UTI_TN7e/YKdf0=P^3d:c-(9LKZUUL6cQ[^0aVA
Y<8NUW(I>W;c&5cAL_QGKNGc0XEQ,RKEDW#6KB3^>0;SCdI?3I(f5c,N[I;]\X8C
=]eE/>XJfP(=:[+G:[Q_D2EOASF(82<W+?\Q(VS#0MOG\2,cXFMYNOOT#SOPVI0W
.4Ab[F/,2..b(:]6&b)Kg8#283FA#6=)?HX1/Q>[9-VWGReTK69.@8S3TQ-L6V5R
1-)H4[35>O9N.>\RNT9^OXH4P>6^OT72?DWW-/NEW(T,19Y-AZ9OM.[^M)=JR(P-
OJK7a;]Y7c<@FZ9(.84G8QS4KF^]YWaCb0E9g]BP>0B^VNG4U:3C#edgJ;-9E.5\
;/VeP>RId=cJXdcdg+Y4YC5QG@dP>B&<\ACG_;UPBD@eC/(<2/]TZFV_]g@F5FE,
9Be._E6Ra4ReV\(0C>U.Ca\&D?T3ab3g.ZX>0]0W[b>SW;Tb6ed(HR7C7FHbXd5V
8;Va@J76.\)LX1Eg:1./VV,8N6U52dBH4)@5SNf)SYT9bf:NG9?M#Rg8Zd2J5NB+
Z?TCVS;=@KWXaMg#cH,DK<4dVFe/PF7Lg&c3#Q2)f:A0@?9>NQ\FGDE>18<g6W64
GPfP9[_b2)_)_XfAO?WOag97YQ.+Z7:CNVBfH8^(42aKa,OKN8C/9<P+Y-?MM?OA
@+=#B3b(,1[&H_+JXGWHER@UFLO/EbR4\g)_52)7^cf.XK.QF4YGAC]=2HR#I30E
f0<&4FAg;D>fVI6^EJSGIE#]V-f-I0N=.RY<Sb8#J-ZG0Y;U_GR5PfW4J3UFE:.U
1Y_ZG&#Z:DFKc3ZI0^XY8R;I-E#]V\<E7)PX_0RQB>Z>+WHUTIIe;#.WV#.^[QE2
-J/C/,3T9_&T?Ub(Jf;eE5]eB0.)a3cWNNRTKgc;a_C4P<gZ_PUF6fgc=7B<#G8e
HC]FV:[:XYcfE^<+NN>(#N0Qd4QL?d.S00)-HWADWEFPg0BL0#CV=R\G6c37aTTf
0C57\Ea5f<L[+EE\,-)1&.[LBQ@C1K.D;Dc#3-114F&bE_9^W<#UWg4=JJB#PXQ\
+FY@6cR5N^].FdN=8K?@f:dTC3?-5ZZZ,Jd4Hb;KZB-IP)]0@)EIE1_7@(FOA((/
d5OQ5>1GYJ&/K]X0cP>3YS\&YgT(dLK??a?+UOJ@5HL<4MBG^B+M5^9ZZ#bKK?WK
\c3_&;eOgA/d[G[gC800f0V9EdDZ&N/4d]cEL:33aFQ40,/E,-4VF;YZP#I\MT-K
0gd,M/DYX:,6#J)eH#856Z6C_5(+[8KN+b2g^cLVKN^62]+8b(#ScN;cCZ9Q&fI&
4RED,G@@LM]S+WA5f93B0Na,#K7V^=(6,d=1aL>WG7Q&B3:N1A5[GGef>R7S;@2,
:B[BDC[gdN5W=_:#G@IK=D0^.1C0Me7V0[;Ya]W8TYg,Xg:_JN>X?+H4WP@Y4)?X
/_OOEP3H>c=0a/IW/#;XL0+ZaNB<#?VJY]NgM\N+ddUYgC82+<[9FE/6XQH<9,Z+
_56NfK]XJ+H.a/VM6_#]06]=FJeK&.5dAJI;Q13f750a+[d>=Q\DN11Ib6/bY(4E
25UOVDP:+Eg+.ELN]=Y@)D08YMFZ1ZgK<L::f2].--I6,MFX\L(ER/72F&)IA\:E
A<DVeaQ2V(_LeA\/T/:=4Y4LQK01\EW,\]c&H,W2Cf-REb)</[0W3U)ZKBVQcSf?
?S+MFdW3=[XP77,87a:XN37P?NQ1Bd7WK)=UIVE/\K:9W(I/L0H-BAGSM)2.\_eS
=V/L7d,Q20^BI_O[K0dGaGVUa/D]0P[dcMd6;b?f)61D67EZG-[(f,;<geVYHZ?4
+Agc\ZW<FDK.5.a<#T<H>[_JF1#HR(RaX]Z=B6>ceeF[T:VS0S>L1DSABI_<#\JQ
bQ^U+OZ[<Sd)(Y#)/W;R__HNfKAJYYBcD_3R(JaYJYL\FGfS5GNM6,d]aEc&^cC(
Z^J6_cYT360e5A]dWU<)_/H]-7:VXZRTZLKdd2VJ^9CD8+Q)eePfHVYP?0g#=+A5
XC,4^N8C:+:8\M[<VB-4(#BWQF<J;IZb3]Uc;,)e+O.PQWAPPIQbM88G;=O]ZY9]
RWb\Z.-4,.XD<DO]>DZ8?aL;FfD0ZZS2/+-4;SC/LO.W)#NXE@Lg;]6O/<02&OOH
[^C)d&:W(ETeA#Ob0Q,Z=#0d&#1.Y&7P&3V86@^M0Z>N.AJKYU4XDV3_7X04fI[0
+WUV:TRQf6D)c_J;J&-WCR+5S>,g+:PG9O@<8&]OZ>8ITHI)#JMZ/@4;CKJXWEKU
/G32]M;]]JIIFL-P63,F0/G[#[MNZ[dB(R-GX75ACaOaA6b>J<P>HKA#&CMCV#aE
>,abEISH@\2VP8&]L=cceN^@E4;5)KU8-+?)KN4SR)\-\32A8-C2(FB#/a&3C,b<
^;bBO4Z+L7_2c8ee3BZCV:GcI-U_QI7JR]SU3ERRT2W]J3;7W_59Fa7]>1LJ(]F<
#]&^R(1L#DSJVO7E@fJG5-LbHY[,E4SWWdfdf+ZAJ:CUbZaL(S3;C-4eI^[X0?#<
,T#7P#LZg:4KV]a?&^[FfDSI3W.8[XJfM+>;g(g(b1J2:5=c:d>(A9JMS:Yg1^:K
@<.3JeJ5U<3@5EdOZ7I-00H2O][cR@7==2##2bQ,BMOM5PEO>,3(FF4#JTA1=3db
+&^Qg+Q-ZOVdGe<#?&g6?SZ<d=,)\eIZOP;Ld,f8&D,ffD9O&(c20X4,@GJKdH<6
SFEDYOVD]cRZ=K\e/^S1W_5d:+7PSF=f,ad;e/U;([J8gO8L;4R,\@GMaT341=<-
Oe-J.d-UVSYJJ_Bd&F?:dM8JPJ+J,#^3Zf[)]b[3ag0K-JMH&-d8^OLGHJTGAFRF
)MdAB9LDS,5^MV;9=);[KM)f54BS?@4H/>Ec>3\N3[EW-LM^bV.?^7ITYYMDbCA>
;OY->M?IZMN7VV?A;RRLYYPUUA4RN1-)#76ZU&/340K7>_BCR=/#0A]=cbT412SR
C\#3:3V+80HJW3#Eg\DK>,CR=[L]9:55aYS/ZBCW0B]XI3<OS10G]Q\Qb;]78Pf0
?3&C;3?3IZBH>Q(#b?[YSfK/[I8.3[dC&3:XJI84))S-OFSe-+RPTH_/FaK5=K(-
OE8(=7feTC,Ag_f72EB4P1R;g(/>B-#/T4COET5K)SVRCNUQRZDHE5g1G:YVg/Y@
&+Yd80(ON9+b0CFR@cHJ)@@d;A_FP]5>)UZ66UAO0>YCVZ2Ye>Y//?<:,45Sf(YZ
SRIL/3:_H(QF#RAVHRfE@XU].T9K5[V&_CCKJ2?>F3==P]+X>\I^2?CO.44YZ6.]
_F:GO/T_aW#78P=aOe8JXMVY-X0#?e())E)5+aL/^&Q;g[^4XbF7X;+;5\Ibd2;[
CcWA9TaOK+T=ES[VV>>N:O2EP>6E2J89\@a^]>>.-WQG9J]OfN-QU=-++)L[2?.#
-SQaB<+194&7O4)DIJ-BU))bN/I0e6<28=]e(gBM8YL8g^:/.3#JG8T^fgMT;&@M
@H:QN6^#=eIF<c,#JRd#1D@H,FN1ZJS90G<<b#>>0V?5Q=47-c7YCXe=VWW/MDYY
K.g(FHOcV9\Y:VaA^G@&TWKA#B&+6]?e-OB+bL)2N1Z2?R,eO38^:2P]O-I3EYR=
UF3#U0-.LSfC6KIdCD>I.BJ(UH]MONTS7gDP8DA3M-RJD?&:J(_A13Z,PRO6g5f?
DM3-_;23DbZHQT+g&@D[:71][U&OO]9ITP)JL_.#M,3[:C4GAc?QQTBY4_[H..8[
?NM_2]AH4IU=RYW5.E[6L/?g+F)7E4]6HS5TaXRW@POd(IL6a8;+;_)^/9O=ZAR]
g+4)8O_335_D8N4:LLb+#\52N8VEHb?LL3#Y&JTaO;\5OdB7>A1J5X[[(OZ#HX,S
(V5-+J6Y<R#O=aZTV?V+D+_NY[YO]LZEQ[cW>U>2Q)\IBCe@dNgR)&b2MZ?_N(?a
R?_aO^97+9+@&W5MGRK2ReWE^)gQ9[aK]195?d3e(S[Pa:V_O;:I>1NdK90L5CII
\QF_JVG=N;GX&?=6YeS\#:SK1@C8T,eZ/0[,H7X?,5EC+VSQ=U->F3/>(gCSa>XI
T5RC[;7NG<KaH0a\W&LBQT@>);54-Y<SHE?>Q<5bQT+L/-)0^::U),4A1&8e9G+C
MGY?:Nbg]L6V54T8DF,4^@/?d2/^=1EN\?[0X(P4aT,ZH7FU+OeD6fRJEC)ZeHSf
Z]Q;eA5g_7#,^OGUSXEYCB3W.FBE#XN5=W8;GQO41RIQ^bUD@N2I-[Q.,)XCEDBL
VI(c2@_=618LbeKL;3<f_E26TE#,.4W>HKSON<WW,H:(K##;V.?E6U@aZX0e(0#M
XLB6^A;CY]3F+g<=/W9DWHg;gJRd/L@dH&\#&OF4f]4a=(6P298.C(\)eYAK=Q-,
TU)d(d9&TADg6@(,XfC/2A8K5dA;R,RR6+C_<<0>B56+T/;W_H;X7:Na-CQ-A8e#
ZW+/D3eXHA/0#<7^FE4a[eGFNN(a<?0\>BF5bd8E:X)IZ#<AA499HN^ZS[(J,J4N
<KB/#HO)Fad0/213W^]L.L@gU1?+I53)H/99+LagK>_>D_2]_&:dL0FgRKE=0PL8
B?H:WEH(^&D5^]NM7f/,cW:WBZKS2@C-Tf)g]=(9=S3Z7YX,gF6RE7X4PW.fd8\S
6^U.(W]-UcM9\V,(AX52XVUQRQ=6)U/@SB,L25LOJ-S1d_-LQ,GT)ZL3-6g],BRG
P(P:.W^LBST]UR1VVC_4M\T8FU-GB_f,)WZ^;^><=PCCH^C_ESY9[+73gZ.&0,Gg
eD1HQ)6:4POE&S+0)&EV^^YJ<VVMRca:16NA3e5aFDLAXg;Q-,&:#<B?:3\aMfFf
-I1e7@a.4@K8b81QX.aKL^O_SECFIP)WIffb4/C<?UHO\fC/VG\1Ba8;/M=7U2g,
,e>]eb)^<M<d7QFX=D1Q[BQ5QcZ377ZJOA4AHPfDU-+C8=)4I(XB_9]5E:C2Xa95
<HCPaVa:Bg)Od(02,FD;aB2=AJ76L,Y^)g;2;aM]N>g9FY9:,JR8S:Za@O+bBCW#
QR)XAN5RbZV_J@JL4,U-g=Wc:G^6PI4E+f[BGd0T9=_F?&6AWG^BDCSDT;<F[O;V
9NU_<\.CBUQb.,_4TAXO:,8:Z64G+=A7BScH>[cYEI\S+W3QS)#T+&XYF=A:8V?#
cA#Cb_@C,Y?<^XG0QFHBf56SV#MNS^HK]aPdR:c/0J_YNgQ46c>@ES+f91^3^Kf-
gS]U/^7:I9AD[/aY<:1e5(cbcNUQ@C:LQ1SQ\ZCE&Y0[B\e;BM/_<:9VHA-Fe<.S
G8HD7P;1<eb#1HfIHQPF/T]1X<>\T)U@\[eY:ZR-?6;JMNa]LD,1KZQ@^MQL]^dZ
T<.fKUCAN6Y>J6@YbQWBX?D?:9RdT=)dcQ]P9]8Q^-2TS#<e)HB-J?Ag1Q)e;S]X
g/_e]?::_=),>GEVD_,J]MDB6&A;#12@Q=OK#HgCHgbM-@,&-RD9O_LEN]S7V.#\
?1027OOZd?;&8-cSC:Y5#MXFNK\H,+8^&=2JGI:8+a5BOb-&e\YCI#@SQLAPXGg\
(cUbBeY,XbgA@17Udg?fGgH?4f^G-R/@^JN73YY2;LQZXVXa],gT@dG\]Xa@7_+(
AdI;8DE^-J70d;UE(4Eb-BFTYe8#-,0=RBcR<Qdc93=JZSXDKTcgb(.O8DH_X:UO
-3^&[JaGHd@+AQ)B^>ZI0XB9TT+,^D#_E>)=N<@9]BgJH@Y^6K<Tce=V14Dg5:S0
O9aRU5,1+?_4g=#=CHEcY7C#?O<6N.&<&A8Q9YX@]O612UI7WU<[ad_:D9T^#)9E
D3J9@6JNC5/@^21I[5dK9@-<2cLaS<\4@?O39Z-Ofe/\PMK/@54+f1M@C^7&^F8W
9JWH?#V6J-I2_#/^fPA@;5HX7+P\G4?+VVd)E?;;-b66UQDH_G4B(T9D=8[?:]2O
1M-O)RdBR]L--e7(0MCg8MQc^Y)O[8TQ2LQ4G@_:g@Qge(SFV4<AU8C?Z+2A](LY
UKPO&@J^5&)b0DFb5,TX=#c4@0]>Y2B;EaH(-W>5?X/:aY,RdEc7L\L[3G-)XC(>
JL90PgBRL:.Pe.9X?PPT:G+F\R7>aKCIV@8W5P;<a)@3ZP/b;C+2L05ITX7+XKFM
9=D4#ZT/UB[.fVONB(?Z=Ie@UJbb5ZQCYNgY/##KZRXD^/,QC^4Xc_]1LE7?aSMF
+JU+I#,M@E=O:feDLU=R/,XT\@/KL9\_;V.<ZDXJ<CbS,dW5Xe)aH+eNV^5-_W_V
88H<\,MO&PA<_/M;?cLTTgF94GK>&:K?:+5?2()89B0[J7@Tb:B@;)g=bgZ\]4:;
.SYLZ59-XX/SKe2.B:dXK]CFW-1X:1E?da.=2GNPU].fMRH+/4>9^?R--TU9BY5.
-[ZfU7;Jd2a<IN.([g?C9];L)C(Q2H@6acHK.N:c)#39YLUGFJ8g=.#d,P<Ta/a9
K:F@HDgX/_TTMfg-U=GR)0R9^XgL3)&UJeV.e@1@LXS1ZP[JTQ:\US,=:__/X7=/
EFU;A-d<[2S2&?3Q#(#d95WVK#,C@b9TI[VdPYE;f;5A()eT/#Y<,<SD(I_cTG:g
SQ2T##U-d@H(b=d7a,6MAI<5cgSF-F44XS3NNR9^C:)<U]+]4X#?1^:4D&cP)/GU
>,<U/b;C30^<#eZgOb)26?\3&SOSe+bN2+RY\@.N/T;62X-N1&XW^(X\0C]6VVNG
,33CeG3?HT-TXQK#\#0XJb1dd7\Z<c4L)BYYA?[0dD>YB)?dE.bB94g:NI#)L0\A
DSX_?;2.K&FL/3G5:b,3]2ULI]H8=f[L,e7PA<G;+)#NU5/Rc&[c0e#J-;O<D1&X
//9bNFZ>/)HY,\B>SLI^fG)K,K)R5:7Sa.3HWB5O=OC\dE@(^AHRS>F-ca,K.MXU
4)OFZGECH0&-S8b].S.)&#;1c^c&d>ZWCNLbWA8CeJK]@fQW6K<8JeDbHF;C)<E4
<?ce[7Z6_JZYf8:QX>)<8C\c+S-.5VADJBFKXUVU>Ge(g1QLd6bN:_R0KV(VV-TX
\Q>#[GfIBJdI]N1)I1??Q+M7HT7-9dYbg^F6X8HE0[A:&eI=3BD5bB9=b]bLHM>a
S]PS8JWXbdMJ-N<KPF=1]TN4>((XY)a.2RQ(GM_8(7CYRK_PQ1L)\O#[B<PU7-B=
;eX?QCgGJgc@O,+KQ1D?Y>M7(IPb=fP?AUUFdB:?(?+C0(+ef3C6M3;RV^9T)fC@
A[G/U/LE;cRU#Ad23cC,\A,,[8_]aA5a:Y:[_HN,B+fa+E2/@1[,-Q;,[L7ABGA;
PA2?.Y=,^S+L.^Cf^9LS#5Cg)\D.4dKXN0<G2S]INA.ULV(_1O\13RYc6F939:R\
=.[=-^2TNd.#?(TFdTID_DE>G.0&L[SH,/>O&=E3A:=[?:SfJ=N7a>+S+^2XT^,G
L^-0gA+9P;bA(P73A/B?>A-d9&fWYW\M9BD.6QeD:XHQ8T@.KUb.;]E7[HSL?@]3
ad=D8dG,0O=d(?J\P+2<c<RdfB6-]#SQ\]a<MR#54?4R/RJ/=e(QdTQOgV9-)(>A
gQX+3A8E7]8T+V/AD20-5ZCFRXCbT8=J9GgS&TOR3]C\I/gfB+X3W6e)<eQOM^g7
^(VPW2=,Ef8>T3EX]X_cZ32c-PS];/\/RQ8cJP.[,=U=A4F(S<7J+M8KbCOTYf0J
V:&2P:<)B?=-9Hd?MF_FY[c/Y)\Z^.b.0Ld8-?=ET:DA(MUCO_c#Y:\&6E/X2>78
>(:b-C/C\VO[.9?cSeIN1HN=A=d_gMgRXFadJKQfA0;XU23?0W\f2.(THRO<2K^G
)?=-IYPY8EBJa&O=V.TN_0=SEgM/U8L2\A<H.[CCe,;+>,7C-Y=\+6faf)@1T8(@
fZY&MT3UZ[+MD6g0D?SQ1,_,3\Xg#EJabZJ&V&89O=#?3:WfOd:62PgZ\8OO(cR3
@2M49B=@CJLFD5YC58ZC-7LVXOZ_S3C>N8S6;X+U6]a_S_UX&8,[GAdGZ]/=19;>
TDb7dfHJIPK7KW)7\-<@V[VC5a26?<TKS>SC9OX]B&TC;@=\=PSQ+e8;SZ&D5YWL
)E<FdEQ]S02SR2RW3T@PgV.Z9CRdXf)T>W?F/=6&@3KL_S?KQAfNWUO_YLQWL86[
/Y5MOgVPYZ6Q=HN#O0JW\Ue>#Tc,KSKI1,BJ8d7+):[@WH[M@5)VD.[XaLcE<K^W
C)95H02[b-SNOWLb2YIN4bQaHT1&15?X@YMZg[?9Y#7WgBZEB&QA)<^=^_Adf8CV
22B^2WMC\bTY=YL[aS>0gE6FM=NC>4LNR1CJIa3Q7SP\UR>KB;E(df>BXC:<IK/c
f\dOd,f4I;?L[OMCBZEP?]+(O9JS5_f+ZD<U+5]D1^IGC[_)&QF(5_@9eb.B;]Ja
0P>Xe]^:QO7N(#]eO)??>&E/><--U8G4[AHC2+,VA<>UITA09UR/QN:^14E?b]Ff
M:J>SP1Ag<(1aQT_X457g-V4\E4TT2-@X8=[gb;^,B\Y60Tc0OTIT?Q]c-+<a0.T
@80fF2Q6CK:NNC;#8>I15/f=PJ-,H[Y2Y:B&9GT93[7E>[+&<L;gbF=Ra4=U^,Kd
BL6c&<D2TbgFVMNP\e]R_KP9;EgER;03X4bEG]61GFg2acCI]7ZM,G]_[<N5dd;/
,fP\>E+7[;G7/ILK27H=Fg9A=NV/CcDBG#7dd(D3.=XBV?CN;[G(>,Q]=N;7Q1XV
Q+G<IR\Te;BPYPX44)CFLB7.DP+?QV1K_.(ZSI)SE3=&f5ER>A5:Z\3>U3@W=5SY
bQX_eBfGJICA8B+^-b?FEeE[:5]C&6Q)-.5/4V&gHWUIB...e2W--^DOb&:b,)f:
)b/09f^.(K)](/\GCM#\(T[[=A3ZT0,f^HOSQE?ICSFE.,^df.F3E5^GZf+N1A&f
?=OSF)1eKQ&a946BC4bAXK27-3L[ID>SbRU)Af+A@_:0NU4N,T5f:a#?9L@agE.3
9/SfOgfE4]&\[1b](f57/A#d&+\Lb#[Z2:)8(0EU.I1^\UeZca4[X@b#3B+gfgQU
EB[BTF.9>]3_bE(9cW8KOZ-Se8bWOfQ3J.Daf)<eePNLTgE2Lg[1X65RKMHS5S,e
\e.E:\N]f\?01#a6-gb[P5]@1#^aWLdC/R?#\FNdW<>e76(01bGM),-gYG&CUg_:
d6f,:AKX(0f[cCW>9JfAgDE8ALCXW)cdFN/GIM5J[?SAb[WZH^Z4FB2_(0^&Pf9O
XJ612(U7<-IJdQF+NL@fE(7T#1EI??DYGcHg\e4#Pc7D/TX)3aS6S0:7F:2J&<b_
6N+809\<YRdL\M+d9+]@)Y9I.[)0F&fF+<3^Tc&eRL-:Y34<.RFC(RG#H.+5e[dA
,+dX7O77A++C)X&C)OKfWXTb6L;>_Ge]X,W@9R0D3()@3;ALeRV#8@77TL1?,9P8
#S@,OMUWLeA#aaHM5^#C0D[2240I]=<^)e(CT1c4ZTV/3,RL5[LgNFU<V<3YBXD@
RFB)<C.O1.U(B+d,ggYE.D&c7.R\)KP)_9I\EBK@e]A-FgHZ[2(R=c1=JN<fQ;U\
LMf_NH-F<^&P\EH9U9UQ,X7?0\6E;9-+T6J,V2J601eAZe@c)9dg,=8@_,VY&43J
bHVL;9e9CXf6+90V(2P6f\^PDH695S2(P&IGZ7:I.M?fYNQF79G@3RY-^&.M^W;5
_/B88Ra(YY8OMG.7V&9_&;E1]gHaB<#P,226C>YRdL9aNNH5=Z>6W4?RQ[98[[g8
8CPPg@RW12AH_/TQeDP_&a.@KRP4S=Y[?9:?gV@6C:E+H1398gR)D#&OKFY_Q5A&
^YUZ=FL8cE^^PVMCOWNMP@X2H/)R=7\D4C:g#eG][YA:4:APJcDE+Fg03<UA-0aN
VZLK1]\C?bUaQBGB^86\V<5P9XSG:Z5dV^/&HSG\4;C>2RbU]fc3@WK[(a=,PH9-
AI:;ZGPE)+a:42A0F?CBCG^C&?D[RFWeEWc4,Pg\9He:OMJ?,@O>Bf:@^N&=8U>.
.Rf3ZUN\;1@eCWB,AA:HLDDV=V#>9N0I[fgY<RXLP\J?#/6-)IL/Z07TXHX3?-8Z
Sg0a@6^NV#23T5&f0fTQ&3]cA^=;S5(#;A4Y6(PZ2Lf(4[@IR<NJ20LYI]/@3gDZ
;;L#K()@[6C7-b4M:OVZ.6J9=XQ;BJ-Z>\S(D[7S4BM^#EYW^<2Re._<7Z-W_C0+
R9-Z4bCeD7K0Q8U-ZY9,_EI>DQIFf;IY8,RcV/XbPGZGQ0-7A2UQ&,Q1ZGQ#dPE4
NbHC#bMILHIb<&Ff)XGP&GR&@ffN]TWCSQD_N[F)FC]Q38@C0R4\0U2c@/c11I^-
cT8b;c/_g6YFb8:51b8SBK6Y2DK[U,(Q35?5.:>OD\L(g2[3d7];dXV[[))NgL8,
X/IGU=7@Ac:8Jd=(T:T66CP(>PXE_B7>V\CI_O^C0L)AULY?1RE(_F_aO19S[5bQ
VVP)2efMe9gWCb3_D=Z:dd4aBfY2@(2OLHDS3BVZfAGg@92A1<d@Df;#E&#J2?D@
QOe7DE=+UA-TI)OI#S6A42\HECGa0@4\Z6IQd+)EOVCT@<)604VC_/SU09L9QBfI
fUG>8=>G.g<1\B5K[+9&#<^a;De&TDZ.g1R^@PZ9\:7Z)Fg,B7=BZ:c_<6U?b=>2
LE[fAXafWLc+<b8T#/>LKe1WZ\1eeV3;9P6)3JcS>UKDG15)37DVSTO5NE29NOZ9
@VHa\C<&_MfVEY;3EA:WW/7^/eg\56=ZW&<IO-/WfG-]aW64A0^<7-.CK]dRcORH
/g[aDb.&7;b.>Nb.g0SM8Z7KGXfJ:f_Kb#-EA:GF0W[c)ZH:JD49[^>7A.P@\O]X
c?&ab^5b<30TXc:U_NSRK;M/8WVCAMNBc;5cO].:g/S,7+-Z?4H[dWJa0+a(O7:B
8K@)36,B8,/[:/&=]].R;RDRV,PH+[64\ECPE,K/H9IR4S/gDGE6&,K[=IG?fHM3
#DbG2?AMS@(]NEcd(LKFa)8Da;7]M#(J\-f:a&<GM)e-^<YgDK;a61^/HUb0P\3W
J[2G5SHJ)9X:I23-cKC_^NcJB(B84^\__SNUI2UNf31ZLP?ND?.=8d7BWe]CVX-B
K)#L?#P9Z3-bG#(6If&Y\OeE6R;TM9,Q.4<R1>KN1NLYU9.#N3.[/US57SJX^Kb+
9d(/cW[B<E(8-=\[>@M8He<bPf0-a@-4ID]_^A1#QIH^N[FGQC<=-R4<[S_&C5<,
=2@A<(KNa\2_5d.ECMf@C5#X1TO>b3EHX042]>NTSg<<R>TcE)VC8ARECTeJ?GUR
]>_TC>FU9fG-C[MS[>8.eS?3X:/J]LIMD0dS:/-J(VV6/XYefB/deMI\)Mb=_JZ#
EPg8+BBTK::&61YM/Yc[c&)=aa.5V,,gB^;6@(#T?JTB2=(L]BL[)1UL0H9;De(&
WTf;7R)M])5=@Ge[VNNUF:^aV\W1:Ub5U0XTOO\^R:QD^X_2V:S2#S<NK7cV-EQg
^^cLLJEVE-CYB2M[W>^Q4c&@?+3)I0;?BPQG]<UW6@X/&N/PYGO<FLc8a:d#T+M[
N/J1^;ZcP+g=6&H&PH:>gWAS&fTd=SCY(&<d7I=#aVB8X<_6;/^c?D3Sb+S+I5OZ
.fHA\&YBG1=B-3?.>4a7S(b_HTJO>BI\+>3]H;WB6Y</_EgF-X6)GZIdT/e]L7;7
5+K9Z5Z7AA7#g)C#PR6Q<a?D57<N7)MVUURJ(93DODAC_IA@e5.=K^S&LT(KB=->
ZJ.Z26eddJ-\X(KPA53ROLJZE-]+)T&O,>/AE>B^4\Q;7761-[E#fP,9UAJ31@6:
DNcZ=C4(8e.8EZ>TVV\da[XOYK[e,2@,>a\9?&3@,[_RdC9IP^)9+9U<f01K<;Y:
9)PBeKH^[-IeA_07(MV)2X\PR5EdKD\)0X.FG>20B_T^d]3+4#c2GZ5fgg<AJRI9
TAKOB#4cCD\+)UZCA8_YCJ<[dK1U>G)G4?XM(AI]Ob878S-\X-M?@LR09=V6_#GT
>f37MLM_0_A@9+OcEI=@.GTf4DaMPY3.,EAL)@8/4[)A1)9UX</75D:/SA6?,QOF
2JCELX)UNgC\XId2N?A[N,TcSa-&F<II>^E,EGYU2DB;[WSgQJg9a^JOeP#eP.>B
@1K@U0]@C:cMbZ1T>CW<=efb)?V9]AFI+fcb8F7cQ;:)(bE<LCgd-9HHNGPS8e-I
CYg1+#N65L9U2JHG=M<=G;_FRD;L[,?E6&H5\NQ@I1F5V-68XU:ILC,U5gS?4fQd
fd:e;;Tf[KKI46W>9[2BCTa+cSRDYY34:PcHE5F(&/fAM#0^45;L)K8?X8H2&Y_W
B]\EPa.Ug=L./a7(#=VK_.,R()8K#ac@=Q+@IBQd#S]5.-)UcLf=O1E>d/dfeCL^
,.]1Z\<L8G^[Sa#J5JRMICRDdcPB3d>E4K@5V;=GUIGO<C[_d@K+L^ZKL=d^.5Rf
5DX]b.R-YICdd#/70R8>XC_E_-F<^H6QbL5_G<SUUO?ZE/Y,V[eKJ<Bd]PB@Zc4:
-+a13CEQ1P[.HeaO#]NfdaMJ5CV/GMQKIM#XZ#5?:IN/HULd_E_a\);=c]=GR_H6
+90P]C,g^,<LafdAc@1;:O@6fI:D[-))AJK,cgL&H5H;[&S.bX5SQSNaX(H5^c;(
&BNC:7+]Fe13a+]2H98B7PBE^=d5?&#F_#1ZFHUCPCVHP6-AdD/(S4W4V-N/<JN+
\bf-__A5gD8MV\HLXXR_1901+3]g(0>J&3>3@CJLb>0=I#0Q;g2f4?C_MWcIb?=]
N5U\^5d:I3=I8\(<TB(>^YXgb8#/?+69def\daWPf+4SZ+WT6=GUN11BL8MB\CZe
d#QMO;[.1.](&CA2e:_UNFZ-5b96>UUO)Rg50I=.G](cQ5dZ]Z2T9>PSI&NZ4e.Z
LF@NPT853:4R^,A1Mg1_RQ.Za)[IV;+YB&g3KA5e^_FYJ/bT3#?L518g8WcA/G1.
\^,:(=P@c9F2_=.O(D&RS09=SKfI\GGT.S\9Q^.2,6Zdb\3Z>80bd=EfXZ4b&.;B
&:2gW@4Med36bC)[ZZ+S-22:_,#P7V[J1RNA#Q&_@J8CQUYV^;8;Dba&3C9d6Nb]
_I#J^-I#YL_XZHL,WZKbDHf,A]T,8Yg(FY,f1@L\_Za5^>K3L^e8N;e:V)EEXD=N
5(DbW52AeG#1[M;#>+a]Y7g7gfGY7)JgRT[@EONNDYU/ddfI=E)A/6GF:E+O)AGF
?CW-OgONN;\LHRJ0NKQ7\:/5ZWMNHf0aN;ZAg/,fadbC7(Q)Q]C<8I+)>S?ZUWY4
&M:</Q1X+eXE3Z)C0^_Qd(+>0QU0a(Z24>=P8B:.R3L./#NK4>)S\8NV_N?(1<F>
Jb.P,^ZAJY(6E_D\=S8\LGM:\>-2DJ46\T>PM>G<4g)2,#T53@OC8f/OAM#.-SDV
B1KH]0R]^G>Gf9[B^VIN^-Ad847W8.d#B/A_e-FRIa+,DH/d[8A92U9#JC44EY1.
J1#[[\=^<A5[=O1DfPWd>]A2;0eV6P@WLA,G.P/S,aH@XI\CDaAPQ?D5F5Ob5-]R
39\eR)b^9JXHM(4TKFAKQ2e#KKL>UW79R,&>fa/<C8@f]B74+Q\(6aeE@DMGM#AH
K#8S_OM^PYS1WY=:0KW@6:TC,+L9;EZ:\7N\g#;e)3QFO=[F?>NeL0ZAYT)T97BN
gYZOVA1BdEU#aJOfDD/AFT4H_KQP((B15MKXObHO8A,HT]@QAJ[&4(_BZ7gd4KD1
a68/:d+L/_\aKW7ZT+<@YEKCU.f[M+M[XIQJfXVE</4DA/Rbd,F+DBK07E7A.C6M
.J]DO\(W#[-.&@Gd-078HA-(>6Jc?CEO3YaaWVdaP\/+CXY#/#a-G\@1YeB(,C<,
K6X_QT+g=ZK^eb[:XY#>=E#XXLIeL+0\O1)TEAYb4a8<CI<R=D:e-cTLJTT]Z1VY
OOYb5g<S\+FF2?3#5@SLB]N>L1YP^>/&H3_=_e2KM?1b^Je\I\APPF^]DVVW[=0]
HaZW&\,OIN>DAU]f;Y=9eG)LaNBc0U#J>FH..8+-A_7^EATa(HYJ8MXA9_LO2MT-
<]0QbZ<fQ/P@P)4@1B[Ra\b<6XNX2d^X[G6]-/RIgUY0S?d#(S\[=d2;/cPTI/>F
(EVIT2Y_LYC;,R]PMA&RdeI4-2:QWJ.7FE_E?C;2XYK5CONI/R>E6G^,I=FL3NOD
FV/8H+&(XW]9+:234TA//LU.Va&#.YA6VT,;9]+?bX]B[6HXS&3e[cgE,37]:HJ4
4VaAL+bI8&-0;ZES2O679^S^O7eV)9B3J]&_J/,#d6[SD48MB:e,^<g(DP^32=K;
O.\;bY&=/3?aeZN657^[R.UC\.<6?77>U2]FJ37Ub[Ug.(_^,V0.Q(6Qc-YB0BK+
1P)-W..?OC8<NKePMYAbR6eS=7?D2U1NN_3D\eO.>ZZILEb8]ZK>2.4[,Y(]/K<,
I)d/DG;TIb>\A_37[UCfIPSF341VOZ<59]KUd&,-.C(F0d43fD,FM#OL,JCBM?LC
L@.(5>MRQda#IP.430Vf@ZLC]NfTeQL/4MDVKT1YU&R5X,10.#D7+JRDW..AeU7O
IT/7S=L)(S84&e&CW-6]&GVF9;-9V.:QTLKL<I[@e\[Y.VPgb:7ILS-HJ>_V@MGF
#:(gW9YSg0G5KWbD[+e,9AU3XA]g^EN_Z08b4=GUT+1_[84:0GZ,<Ac45C@e+HKZ
COg.AD;US=?fU4SSg765;S:Dd<EL^Sg7NT+KY2+6)<He&2S@<7O_EZ](AA(C75##
;G-H(&9RG72Z;d#>-_4#8E(g(O]7XaQ937Q&aa18[_d1ELaPM_gMX(LMegc++#K9
fZ4BK4gXdgBe\F,W/^f8A5Ic=_JV^)EPXKTL:e/DOL.M/N=)P.;DKAX0W)))9\?a
d5bEFLKK8H.[W9=0efORMZCT:+Zf<0E3:C1Ffc:(fU-#2;=D_B?L^^S3>_gX5G,]
QA02M(1HeOVFCb/2],.2e_2fSb2bP46QJ)6MUO4+_WK^K(VR3X\+#?Q9dgc/+\YI
-=&C6/fc,&9@[^G.J8QX+D5_aN.eMA(,d/&0;88_:QL4.CHaZV=gCQZ:HW7D#V)R
RDIAI^\@WJ8T^3N=(aCCDKa6+IL6NMaBb2Wa6H/e9UN^;X]-=Q/e=4TTN#;b#:6@
\c&a-SfOAWB+KV&QH79D_M316RXeB_Y@;P&Vf5RMCWB3^O8X?<X^9c;#L[9GMGg=
d;\U;+^+6H[VJ-S_U<bab]AJ0?3,;Z[E>JHa[C+3(fFG4d00X?g&e_P;:FI)?V4X
#^?3(./&F8fLNP-?^\3,<]&Z89c.K4#)X6>)eD^>T-6<4<0c<4M7U4QIfDP[39K.
2BZAX)aTJS61^U8(c\8df\-,eA\1CRJB2dYM&dHBK07AGfWDaK@]7b6]]K(;S&@N
/563g5,MPDD>71Y+I&MWd/R9/?D^;5H\/0##D_ZON2AZ,Z,:A]Ee(A\7/1C;MbgP
)a=;4)IDR:<I^BMC0#YDI-Q1Y,(7]0XJ/fBF3EP&9L@BSa#(T<TO,E;L+V26,0DW
YFf#1S1974N_Xb0A5HcMW=^2=bFZ1.aQ4_6WLF;-4_K_UcO?7LCda1Lb/#6b^a?1
Q2(T3@Bg89\M5TX+6e4fKf(PQaa[T\[:b450>CL.+OHQE\E^cUK=/HW-W>aWcK:d
^;>ZX5V^KE]&2+M\^5--)[/)LCVGcfJNaCU+TA,f>@E:0]Ee-QCQQa98<ga5GI_g
=Z(-?M^>HYd/CWP7/\<4PdZ<0MQ4MD#BNK9M.MPLXVV<Y.IV--\O9I.7#7XFBWHf
&24/G+ZV]bB>dd]@5OV7WIIYgP#/Nc0CR/[D?,(bbB4cdc(&DPL.X[7Da/XEI^;>
/g[3)U#5E1DF14O\L3YCAAMI--O:8/S)1MbdW-VO=A9NL>C[#EN1R,gG@][:CfB_
;DV+:QQ=;.IL\OK1&e_2@ZT#.IV.eR+#LGQ(PUC#(d-)I#QBaB@Y:NW?7:BKSG-4
a:YM#R5,LH7Ve9^P4X6ZdYL^12>Rf5TF/EWC1c=?f7/V7V>Y;5I95f(<;<.61A,&
5LbX(W;a=MgM?M0.TJ1N/RVc#]GK7D.N(&FJA-<1^HE#[\@f&S-OY25A_.S=+WLB
1&A2;c=42J2H>ffa25H+>Vg,CHY:^#dYT^;RFWFA\+8]aMHb^UH&IMO-V0gFJ]V>
:K?VB1dgJFEBLRCF?<;CT?+X1400<QSX8;+8K.4?UEHNdQgSbE3L\=<DV9N,,EeQ
Gb.]^_UO>]f>Xc]4fDZ4A1+A5XX3II93W-,<cITe1Q3EXI1?G:ZWU#^-YBOf<)O3
HBFFA#GV1]KH>C)d5?SJ6f?;&KIZ7JUX/5,@/T+1,W#Kb-(<PI48K5aDN);Pa+5Q
_Y2#^E?W^<9-_8GU.87+7We7ARU;.K?)@@]-DMD=b(b8G2Ne-?.&N0LSEL5GSd]8
\JHU6UHC@?ASba+F]W>&^9B-N]_@K2IH3#N_W36IBUS&]SDLFOPe#LNg#@CGRb)]
0Z?X;dD,,0Ce,U1D&GU52[0.\QO_TVQ<NG+gRdX:T24S)=df3G)JFNIA2AQ_VVeJ
O@6[<\>7[g_cL:RGPD0J^XCWB9XY](+.E@J>IdGA&)90c/T-NWWb90)2LUfJd.Fg
:8#_>-d?[-Y_Zb[6[LTU?Z+XF/X(,)#\I.-eO64Y>.AKRZb-QUJ.MWTAQ]3[afg(
+>-R)7N5G/CQ6Y?;fd^-I<8+(>D_IA].WcTAcZHZR7D+P=H<BTTef>gb2GDdXX,_
g9/=7YH+GgG<<7IfM<f?YYY8#:VR?9WUT.VcaC5fG\^+Qc-HZ/YRZ<IKOgCQ]2LN
.MB+T;K3#:52^D/[C9N)+@<ea;b,VCW9^S<W:HFL\?dK#SO&\a[:Ad[Y4F/?>X//
bEZdKH=_J8.J:TJ^0/E6S]AR=e3G9,G@4S#:?[\H9a=PeF<1@=VDTe)^a^@fFa^/
V/V9+UI#&S6[QKI[U8Y=Kf3\A\+F7&bY;/KbTPW5Zca.,-eND/EJ=G<;E4O@KNYN
A5DAD3:g>>UE_F7V(;?6<0(]&_6[eYOJEg05+]]E/>fT2W(XPK^T^;0EBJ[.GH]:
/9@9AQWOA36Cb=S+>8R<+L[>TA.8_[8.?LGM[O.MZB]3NaW]-5OCRRPTC?W5#[Ga
dP6LU52KN5/Z=Q\JR6A(:DH>&<CRPUdI&E&>K-[1U>L4Z1P:-8_TAD_@DH6K_66b
]HXQ3T0:8N7MJH]+;F_JX]5/^+QZ0:K1W<OW^,ZGD.;XL5=?@\JS0)F3RgI27JPS
dYg[=X8A>I4c&FK=0F+U@8=T?T5)@B2\=G:><cAK4P^0DTIN:_:P+3NZb0=T@=GX
M[bRHR^8XI-0g5I,R84<M3_W<HadMG^gBX49]9BFY&1)5[9KWeSVe)8EgHW^RI0/
S=dHGR0CO0c_6.R7EXEg1OZT<BX<U(S-FL6=CI[?.B/.OKUN0[#XT,#TO4[Z:<OL
<e+_?g?O1U;H&c)L(72&<X7B+FJ:XWTdPO\^dV?KD8c\,1Tc_==e;c:<:@09ZIc4
_0GL4+.\e6-DdPA46@(BW/5,M-B):F44(H;W=M:P7bI&Bfd6N-eW#9,PgU)fN2RF
YAg^af@AM_,G;.;_gL7S7eWdM:4&a)+Q61P/F6D_;10-<Y^Zc=166RXgX8g(91+O
#]ONG,PP4(^-#CaL_W)d^QO1,7&F)H7)V]:HI42_>Y\K/,cb]R<(S1^.L4;Z2B8_
.Oc57TgXA7O@^3D8QBPJ<AB9Ob2_Df?)PGE,YR;g5Q\4]\SH,[b+PYfQ/gWK#a=3
/-_M:IZRV#c9E162F4EB\e]CI;IH,;(;#b6Mb[8([PV@5\XSZ?[(X+8>ZSOa^?Hg
,\X9cNJN/A4U=0eG=3XLNWL@TS-OZ==@g-5X>;Q(;AWDAS5U:7#9LH-03<KTUB8:
,b/QG=/S=d-BW]fW-:f5f]<:R/c-Df,(?,fB1;NOR.>fX>LbA#K?=HTI#YRFYUG8
[4&e&__(2)UZAA6CRO;G-45((NORE1Dd_R[^<SJ_/(4_UT(#579>.WMT8R.5Nc^?
#XE7a&5HJA7Le9SLC3UN/TGFf)5//Z^2KDL1G9X@bZd4CH:6KNXbc_NGC[[U@06U
YMe\(&S>9R/DBUBFT90\>7@+R.Vce797DQ)d97H451\>:cM0TMA[@YD[[c7&QY\,
9>/VY3M9V__3WeDB^)/>I@M,Da/IZ1:[UfD12>dG?#A75C4/U)_A6NdBERBK<dbT
76(3bTg\a;#BVN8X:48L/=H.4-(H^@e/=@HVLAW_;.b>@M\ES>/]@Q6)a74XZ,C(
6>fB&a&bID\RE=CaRR+a0JH^NLfZ5S3W/V(6-a?1[\Oc5.J2CYAfP[=A#_6=G)C:
R(YG\.N5P+d3OEBQNQ_&CAB3/>g]65JXL/SC:^HTC853,]Rb6.:[N#?YG7S505&:
=[-4c[5LN<C),?5QgYR_[>edQ3>EBg3X11KI;dgA(<eP+cbSBDQ)LWU:5f^A]><M
>Q98PY7d(8)EQ:GJR<W2_YI8/OGSAYYZ9-Z0V0ZBB6WcXec)@DHVg>H-:]d8,Hf7
F,&KQB;GSJDXZ2]&[+Z5bCF\L(>@UH8Age:\:JIV00J,&&^&2G2Z+MUA5I/Z<fQJ
Ng>\b54e8UT,8daFFY[6F;N:AbG1N5M9gL3+4_HeG)P<ccZ:@?K5E&RK-cI<#FXJ
&W,HPL;KCOWaL[J6)F4,^^KG+W+08-\QVfIa97A_[O552XX=<1C9SN+&U,e8,SQI
M>#Ef?+g7+W<SgJQE(\gDN1UX4)D[=JY;4J(g+-H]QKFebL9;>@<RdN0P<@5:6VI
>8(C]C3J[C3IEU+D9)J+9fP((<<,8B9XKb0cF@ePYO?F&-QY/-KJSef&@\/cb8M&
fCJ6APJ)bG,#C[R6T:W#?.Yd-@g[5FF7U])FZZ=:TIGWDgb/K->5FG)JGfC2/Y<5
4N<;^(<)#JYG^M+3JF^QPD=-56?=,ZK?O4R5LPNVV)d4[3?/FEW_SH6W(:F<922e
a2Y17.][8)[3/d.X2&]7e2=,T#I/G.<[8IP_\DJ[Eg-1?d^E52gEJ7]PK)77#b(2
;#-@#BO>=Z=Jd0@Kff_:]EXa3A8(98N/06e=)QN;9#^_;cb-9cE2YQQBfDB?9OYg
aOUE3F905C+SG(#S94EUJH^ARc]]aba]g^d+3JfQJYRV1.K5APLI0WP#Q((Vd[2<
>@GC/+C=.27F2I)1#g(5]>DI:6I8LO/=V70N>KEc,+M]29Y6KV^T?5TQZ&+GF@F]
G]#<#B0+Z0&[V-9(7AZ?E/Q3F93;;>:#1bg.77S=I<34?)Fc<1L#\Q&+Ea)N?g)(
H[T,?_3&S8+bQHNH[84EXCBLKW6(OFK9cV&=\=2bb509ICgYgDGBgYAD9_#A4Wd+
K+EL]\_ga&CE&<TVa.94;fW(+Q@Z=?DA..=Z+ZNdS2-(CY#X9QXAe[7S]\b(7/2H
SgfeD3]A-/L0P3/gV2PE4]_RU]D9KE9/3\U/aGTVe8f/K?6FCRKOB(AI+#<6J?T_
]#NAABWLVI88UK>SX;g6&bNcPP2?4_J[:Z,-_RS.YWPBbBDbR?YQ,a^<Ac01Of,<
NHK-cKDM,_PIeKYf43\77R#e-,0Kf>/BKSYG3_SI5V34GS6e1I7)>gF&+bV:-BF3
1^2@&?@T8_)I?=gX7Ta\VQH:OC[fa><(=W_Rgg#0F)]6eI>)d&3,_Gb&2Zc#C9SR
5F;<Oa,G)a/f7A@Nd:d0gP\69D6=26^L25XE[GRAR45:R4XNVg02U.,4UN+GO4Q?
&S;ID\\QBY6D/,1:K9GNPBFA7>;fgFYLDCTDH?S@/?(b[X&?;YT9:[dTE99;1g5Q
>053](Y4_dEOW0#BUO;[)fDRI<_5NOG5JQ#R@cXc<]d2&J_J6)(PWL/a_(-9-T=+
&G5fRV_UY9GAgcP]DY9S<P^aPW+Oa()d[ZF>?]>6&_BR\QMIFRAPeWIUbgP>7dKg
7LGC,.?,2eE7g3U)</_TM)6E&fX^VYWN[?O(BaAZD,8XFAQ:.5X;]S.>6S2#CQZL
=6K.&(.=4(&M1ET/?b5PDR:_)R9?KVD)D>HCQ6AbIA:\Rb7d5-QG8S-E6B#N+)3L
YZEB:U5TP<HXY2cHQTf)bX5X8Y#CWg78;-d6;\RTU5=8588I_Z&>+>X7V5@PAg;.
.ZR79A5H,FEB_T;ZT7ROKgg;V;H[N&OHN^TW7aV>)R#4U[Q&;5/(/dA/P@c++GYa
g/5MUGZ]4MPFK3gFJ5dZ@M89\O:TZ675_46DNbZf[bg?d\b)8,#D+a^Y+;<VE</9
V1UWOBX-^NB-[Z4YdTH&,G.&L9)1V@e^96<U)B_LL.#_:IXaX]c?#+U&XOBG3KLV
Y7K@-TI&(K<,<ZWK?\>0ed&c7MMFK_aQ>J1?G)@C=AR=DJVM4NP9>+PK#PQ.9LZR
KCg_3b3&H\QScRXCFBL.19T17fBVS;NT+f:E)JH+aE&_\A/6\[?a:L9+V1TYSe:A
>\VeX<H=M97QTFF:Y@446gO5YT2_T+W,2=#Y[c6bZ\8F84@bI[3H0T==Ef-XS_-J
a1-7^O5-O&@D<]03<Y/<N&e=]4K2d\gNG026H4C/VbI5fdW^]F3UZHEDX-2=SG88
M:]#F<48PZ-CU5KA;C#/>HV:Q\U)IF0,:0H>a,1):LF0M2[^I9^H>KFe_LNI9-B=
_-RE^faGM_)6^_G+;]J2OO(\;(FIXPF848CS=-Ea21STB?L=:(-F9@R9.YCX91C;
H\@E2[)>44O.>)R?\fC.KU^AJ<#c9A:g#3eZ.PJ4&]ZC8D,bXTQ3JPNI^]G0Y[ND
^>G2OAKDTZDTX0SP[gX[a)>4]M-SYI[QII);N2N?#5J<]^dRV\?;W1J\HdB0JU#U
Y(>JXCF]J[7N>TN]3&-6@7cI\>S,XD2Jc#S3O.D84?K;\gL4SD]DUV>#^O)02b=]
b)5@A,2J>?H#9:Q9ZZKfOb/c^(bIC&Yc1M:RFSVgXNc_;W]H(aE)3F0P8Y@P?^W9
P6+R+HZ,[9X4GCVNM-&W5113Sd35<E)JR5CZ1OH^&4A\76R25Q&I18(SF(^;T^(-
2.2a2K2I(AbVA_?+d6[&.W6KAP(=AF+9B\7H8?/F=V1J3B;JMZS(&a(#SQa)_HTM
HBIR;AHdTYO6Mc\V#@Qd3b&RC>@9UaC87]##7C#SGc3dM7:W1=V\DJAf3U<BL^:(
FD6_bC])8F7/F9?]WF8+_-NQI[XR/Z)PE;IVYEV2\ffVP5.#/QO,PJ9)Q<J9]JO1
GfR/HRZ@b>gWV5.:5?2;Y,K9]G;\6GbQ<@F/PYY>JJW9>ae544<>=>MRKfcC1.2]
(Ue[T;_Cb:f_f7P_A6A=,LZe_CXU&+?67@)bUN=-#RN(,d>MG]_Ug/SM#=?d:73]
)TM+VSD^AeZ@8_#ES(d:2F(FSEg1\N>b]LZ2\9KcRV3/;;4K.\<Q:5_<g7ec.<DL
<;)D5).=(#WSF7O(_#GLK@\e>HF.^P:09AF^AY?F/8ZB)GM,5ME+IB>V3^H1?7,]
]EMYV4eYUYP54AO94dES\CPgF<-a<PdVFW/YZ5g#<7XU#AK35;+.HPe(^ZgPZH[;
IBe70\>[&G9_b?a]&S+gPR::MM@7S1@8()=\FK.TJfQKKW-aGX6-<XR/f=@=d9L(
cI>,3W8S2?TOe?c1C4E5,W1]AALb0Fe2649(KGVKc-cH+UEO4(4Y6&VL@F)X(L;>
1g2-,[D&7VS;W0N6<JI8OA+>b6YWKYXc&g<@cLG6R:@SJ9BYaE0bPQ#9Z\7O:FFY
2UgB3P\GDB3-_IAYB+:./:(YGWQacBgSLNTE2((T44ILd^4=-N-eAEgF,aB>[\?2
CeV0_@F_I9:9EHb)#/?1C(1f7R.B<U/D)(;75VD(0FIO2gFW4b>eU06aDF]-fND2
f7>/V4BRX51J+GEBO8T:=;LGP/[CC)XYM:e01O3)7-1\:=KY])[V#gWYNdf-&U&f
Lc&IL#+ET264bH<5EH^=dT/U&g.AfLMf/a<dGM?^R9_1@@#_&PMOZWM8S-2_5/&a
^[9A.Jd4S:[5/3-FXK(df.BMR((;_Z-()4e49Q,-6dC9JF[LA_ceK0->aPg=+c2V
G#[K2dU43LV+JK59+@@<32?&4ECeGBF+E_)bAdVKYDN\fcV8WL.Ic)4N2KLZ+cWf
.b>c6V3e2F<MJ;cgW6>,2^0Zg)O&KWLHYA.JJ:LD7,ENG3-/LY3JM<L3M&Wf(DGd
3XI0.W(\NJRUQ77TKD=#1LOUK>1D=A^Y[T?Q^1VGC+_SV.VLeR.TNA4?,c,ZE0eF
f0@,J,,ebEV)1/ZWS>F/?VOXP9)/ASE<fZLAG5Ma0/@::@OI?P^gg]]DDH9F0[Yf
B[;()W?#cg+&=.-MGR_eZ0NCP23Y.=AX]TCLAI>dU=9-&KX6g@_)-=S?E&-C.DSV
3=^<)BT0PI7K.c9C7N?#dQ1I+S/R/IU62/@M>e6\W6\+NFV6(\0[3:,,5<&KS]^d
bcf[bc8&\AI-IW4L.,VNML)2>Z&g_4P1JcG;AfQU0d9(8@@^#(\./(?A8T@bNC)=
90PQXLKGN,EQ2J;<]eAB/A<4bg#@@P.\c>MI4Yg/FaSES@@1SR=)[GPK;58PG<@L
SKV1&^IME>/9^<V>_I77&b<KTP1[<T^LL7(;L>NIc7J]]bU9+Q1:GZMPgI5=5g[?
0>)[Wf:b\a&->g4edK-a+[3d4E23<(cZeX\_).Ed7:;c]agaTfGJ#V5?c9WeT<&\
XOUXH+1&IA6/1+aMg)A]/]&RC_3gDL?8/,EZ71/Kb+Lacc@&HVW/4KE82ES#?^+X
eH0)>YO-=7/YQU:.:KK/2E3b(fQZgE.B9.ZJN/]EQT90W:41[2gf.:c.J.&V3(UW
G()^Rc\@aJO_7N.8>?\;WCf#Wa9(S_g>CLaEFVR6R<c,KQ]<\1b7#YRI0^K@87EU
66TL9]Qb_Z[AbbY)^Y<R>U2YC@R\;g-H@2Ha641#YgOFU2I_7CZ-(XOMD&fC0#B5
U)S5ER/1>aHc8@Y[S=)P2:\@T,a@]5+SG0H+JeTOeH5+d1f_ND:+1LZ_(E+1R0M:
=E.H&RK/aa:)63F-GH@SF[W<5bB0\+R>8)M#:3TD9+2G?WDN-(@1IIRS5D7^7S_Y
X;RY-,bA&VGBB=^V?Deg]Pc94>#JKZ+TO2,I09,>Cc8<dUIP2497>_X92E;0T.6V
Z-0+\C/N2>73](G9)]#LLMBC[BU&FTNaPP+@GM<N5=0)GGgDSe6Vd.OA+D+\=35&
\Re.&e<)7a&RVf.D+/gc++Ca)fQ&;?cV>YMCMN[a1ECIbN:?;)Q)Y3a0f]&BJdUL
O.F0/,Z820G]gHg1N@[4.OAP616-LfY9?>ge^U;9f^Cf>A/1YUUfP3\1KcJ(1NO?
,BdR/7Q47D?W/N04^W97eNLHFMYPY369G:(cM-Q-@d-F?XdP)I/990H)N1HKRG50
Y#NB;8RJ8Q^B]5XS,#D<XNeMFA#AKL::I:;)8VaA@91IS8d:SO\?KMeU0FJ=MIUG
5_GJWSf_41N5#D1BZ)LC>OP&9H/e@gZ+>O65:c1->LFUVU<EY(71>8>?bWa^(VGK
1g&b6;=\1>Q2TE]0YD54]g/^e6GD&2G&D^57bc7V#_VA>e@&>0(NJ\\&.Bc<3d@0
O@\SF66YV^GT[I@@ABW6#dS0X]/4_V9PYL3<3.d[8XDKT5#Vd9Gf0RJ,/2K&dCW<
c66NL3af^d>H:J_Qd<Q&3Z:(\Vf4_D@.ZaQ[920+@fXCPP5RZb1P0d@HQQK[893[
AVT0fCe\;eVL=JK0&Q1\f7C_c8Adg^;W_bLQ\5H\0(D^)ZNcSNeI4fZ<M2?;&YWE
9c?Y^932-b@Ja>R^;DFS#C05ZE\:8d8/c)5FN/,PgBed#_\0C&#__b+XI9.(:KaO
eV1]Mf3Q@gc-EUPf^.E8R,AR#ac9a^Y66F8-cMQbWgE/4/N]d+8W?7P;M]B8D0K_
6cCaU25bCR@NgbX);+acaGOX;gGY@B&Uc+\H^YD0;9Z,<]Z_NTEZ?V/_G5S0BTX_
B.)[@DV:IQZ<&[NWbKG>5AegJS]#1QbEU3@H35A#U/d>[=L,.]?W]V#2Lb41M<H/
TSP#@SXCT[&ZK\]aEBW^#U\OE7c8g[4Me&c\13<[9@,2Z87Z8NdPFf4?PHW53TA9
fbI2O61&VCS:/8UA@LRb9EY)5ELB+5/?)I-,T:0;FV[K?a&LENTT-b[49BV=2;5O
@^DT>9;]Z<DN7;()DKMZG8R-_b9Z[.g,PB((.9J4TN,[&fEQe_+[[N3(WM6G@]O=
)Fb0FE=P,9<3@DC&+HLWJc\;O3Q3g/.CP=Rg_2J?^28Bc-:9B)SGa[)4P\BS3+=[
&J<J^#,U78cgN/=3f+8gVO4AAa-+.eT]^:Ee;L([aE]g;-]1.EaL[GU.^26>:WE2
\5a<+d].O8BPD7=3eK=5?dLN<QIN6dH>HU0Y_E&J\JB]M)XKf]2QU3)GI8AId.L\
D#A8dd-/dO5P99U\9H\]_E6VfFRH<BX@g^eCf9GYdL>f+@9c=-\I,:gU<HGd6ZEM
+3[ZHJX0]FNU-eN])C2c[#2[^V+_N1=]Z?[aKIW<a,,>6,6^Y.<HbbbSI:2OX0Jg
Lf5E\^<6KA2;_+KX:Z4N^U?SZ35.R0gJ@:<#eQV,A(WSCWY\HdMO527GZ>(EMV>G
&RdgSZ&Z049^J/E]I[&>ZH:D7_eNe](MML@2d9FNf66G/6cHN7+KUOF))01aH0(&
=GI2MN(\I;[&aa9\XV.fd9[J81Ue8dJ3+g(b2,cRI#cY+9FZ6bEcG5EPO4G1aGC8
XMGC,:g6Y)VFX4&8<:REba^=F4B:dHM2]U_V#AS0;WJW9-_R4,7fR8CY_.>;OCJE
+<^V8,SJNd,feDKK456(#]ME:3W0,H>G&8,-)4+S^3A/D_b>O5O>S87]OA\4I(2O
MTdbcgcY(PBX^W3169TPEM.\3P>\)M&g)X0G][RV,UY\g(,RB&736,2+5\WCa(IF
7NaHS3Gd^L;KCIF_/[<8..DH3Ua#>=V;L6]1Qbc8\L>2:eTg<M>\<F)2@-S-7/IF
>7cP9A4cHecZ8ObfAAM@J.A@2b=X9>67[a)9\I+9#M@)A570)MSfC_KIDC8e0M8P
9+ff[QZIbH&/d_A9FA8#VY,Vc;HI#4)eBbfWY\28Q>08FEA7#4J;SFfQ]QaOQ1aQ
7E4c(H7W184WE2P93G5;(dFL;cePBCK@K3RIIDS\]R#+T&D@LN&_f3d\Jd6E-2=X
KVOB<0eIZT8<JPHOK?1L@GKYW#<+JON#:8EH[]Wb:4WL(/SgK1Sf)(<LXb][X0GF
D1eA^NE\&B&ITE2U0,d(H0?54R,g3:bYKDgCA&]bgM2O[D^-<J+JW<R?GDSU+>^g
AXY#\[a#+@[O6+-MEC4<TRd_f57PBd68bc#ZO=1MW6+ALg+&1;+2=UR&_2WH5D2(
<-f>7cWUU7dd>(]fLZd[J(g.&BIG;X(>:+R#:J197XWUb)?>=cYF5L90DA2;;@P-
-Y1DM,/c2>gF4-;[-@T(+^LR.a[Qb@C+YLJbJ&e95X]A7(V8T>GQU5IOK]bd&>0K
+gXM<-^ZZ3W:FB4]1>TgFD+b[,^5E])_4<IW,4//Y^>\KFe>Ya,YY-(g&2Q6(+#H
GKO_P07(HUKV4Ia5W\&TT&H9e<#&O+@SH7-c>6a_#0H::Z^Y_X+JUBKIL?D;_dN3
QH\d-L?JA,]cN&2E9.(?R)feF.^gc&OF1P=F?\7U/==8V/OfgM[IK\VXR/1cWLI@
0E[BXgGTU-=^NK6b8-3ODb\Q,b.U[;D7-G)Ee53D[[(/SME]ET2M3WV,g^Uc#bKR
3N:Z564=Jb\_f;g&G-?/44?1IBRAD+.8Ge:WA9G>?EUCDgR>UL:[SZcYKf>E+E.)
??>MLW,^<PDA&+DE1O-417@[\NXLB:U@IfLf_^bfDL-5DXYS9_P/E?^#L8.M)UZ8
Q[0PPgc[PVI549A0O1=4:YQcL9KNfHeT&0J5f<IKUWJ[O<-(6R^EW,+_6AQDDcb3
KR8<e3[<R5be33PELfX+P=Md=?;:Te_.DLATZJ7FdVLQ;e,40+T0;e6,BY7=bBag
83NBaa3;b?ALHg7</H23dT@X<+C86@<1[SXV6f/Ve7)Z&FRb7:RBK4Q+4.7;YO-K
O#3Q@X(N0IZ;Y@^3Y^8Z2L5[Sf@C^Vc.(#Y#5+PX-f3#fQWC\CKX^fR6c9GSAFM2
^+=\D+a_04CL@X>)V@UfED&@OS_]/.6M:<A66>X8ccR.B/5B(:?4U8acXVKDI8_F
_OL4/:_640]S&?IW[G<D36[9:&=T+++B\UR<XReW_D=:4GF5.-8Q:]g#D.[L@V)2
-=(D[IR8f/Ja+N60<MURZgOUeQMaL6>))1PLfKM8bgA[&1H:6:E4DFg5.SVV]#d8
K5(,cD:I5X+WA[#\3[S8O=TI.7K-^dIG:GU[YVg6JSYd^b,E-BZ-F-P^d0HgL]VB
F)^fa.W4H9IEPQYDe7JL3)-R1HAH0e4/_TXTY-_+@15E_F[&E_OaALe:3:J-B6#K
UDSb/UO;a[a?O2E8gFJKL4]E#E?DBG3Dd?2L4(Ib4:a2_=cY1)MbL:O6f^d#6#)5
S5=AU?>[Dg&f1;ec=X?IO?+Tb5NY6OD8]QOEf>RGb/?A]2L1SM++4:ebFDK.F/R0
bULfa1#1RdVD5J_;A-S>PHaY/aaOfffb^@4B(_;VaID^Vc<)dQ3\V>^P[KJ:76J^
7-:W7:<B9TV,?/=gQ=++T[)XW:[=3F,^6]C0=#G1T2Ud\A]UWNF;R\;e_8=O2RAT
4A^RgZD)d&/.<>@FGXALEF_4_5_ASgBK56a-e2HUL\?7g8RU=0P-PJ5?UMH&&3:P
DBNaaG:2^MTJT)@SNO[NCd\8c03BL7K0+-?f\#8>F1XGb3.<SH^XH+aYTdQ#5&Z?
(34YS=7D7N;FXKT,HXZEDIHIC=3@OB=;A,E^92A?DZY]W,@K51d&@0KU@+6VMCYK
H@8@R0II1K^&Q7?<dSC6CX7NCPe5fN10(>aJ5SULM,GYUI]A>:LE04V>GLC;7/a>
&3(]CTZbA3^D,AF7/O,4),\1?C;:.+\XFHFL82@B-RABea))?YO-<O2bHVbI5JdR
414^2;1c,#02XDOea)UOLS@B5AAVY-]R7J]8f//VD+;4bJA@WL:S1^+>c9T]dZP.
KfdVXOZ&#AP^+BERO[YdLGX<]C88KA3gE:\C>(]&RO1S8_]XBW\KCK[7-+)5Wg6F
S;EP6)8(@P:2@cJR2a0\PY<N_3bM.CQ9B9NVf,\\V<F87^QL2Of[LI(&)XT+Z<Bd
8:#.JR\WGJ5P31?\QG]Z1T_H@:>GEd@L/BG86R=PIH&:69R[M;6/0R+eL@4IMSV+
S+;3HJ#Nd^C+#J5ACbV=>BQa]8eg2\A2NYE6Z=+.^)/d#W,fNcWE#-c>#Yd96A@R
FMQA/YAW-cV+WEcM>fR,V4WbXS6)Cb(&L(:5Z/>d.9,P-L6U0FOY5P=b.M)93:-H
K4E[_aUWE1FaaMC(EGK:Z9@6+14:fS-ZA#&9R3OQ:K#S)U:9W9?,bOC6[ZBUBB,1
1/1=J?MME2CLc(K22b(6CIX&/QXfdgDG\a.9>]IUJ_:2SS@#^&1T;Xg3^3WX@=.7
7aZ_6Mdd23W.1\RND/Kg6B.&C]7+Y?-AA9?NZD03U>edaPI)e\DUA[X(_F@QJgeK
#/3D#W/9_PJ9DB9;Q3T1[b[OCCYGSA8IR([[RO1aI@#?DX7?VX=e7T@+VBAF5ZV1
>1>VV>cb4C@d)IgDZXTA,f4?Z.8066()A/YPOgJ:_46BP=d2^^N(;Q3XQ@]]L:Q>
:2a-N^^[HP62>^EJ80T\5AgXUcW42=EQ6g9&0R7AC/cJ?5+g/4UZ1.<NF#VUPAaH
cDN7R(NHFLG6L:>8J<;RLA36NMDUGf\RJ>=Q_X^5\[Qb/[>L@IbcEXJ\X:,]9M/3
-=90Y51dRFT=(-89,_,d63PBH@0NNRA/Df)=&bbL?OZ;ZLZDO2;:FXD5QLC^&\QQ
XI2VP6f@<SB9)6A:UR:.ON-&JP<4<U8OHdYNOJ2V51U<2AN7BML_LE6EEaW+d:1]
(@_#T24[JJJaU2_:G^RM.>^0S(MAJ#SeD,6.M49?G@0TgFHRJ6X9925&NI-930Of
gbO2\S.FJ_L1::d#<INC6?WY,OY/M(W1[I)8>+M1_?#NI<EI?F92/-=]\Z0Tb-HB
O(]ZVa;2K\_bNX;N.b;D[4Meg9-.#6QbMZSM=ZGU1-(PH+IAZ/]EF2S=(#>_)U@?
P0^Og>P9Z[[bc.^\#=f1FHXa,=W?b.;N,9&55bHHOQ&TP>LU6OFe6e]eYa&0GNNQ
3K5(?)<3.IW\QS()WX_cS)0>[0@6B.NVgZ-L7Fa?0WHF^Fc/K]OPDQ5FI5Z:1/=c
OL]DW3B+63^P6^A-5].c&c+]C<.e@\+C=@?6AI4@^O)ZHEc.T@MQQ?QC9X]+?4Re
9)ge3gQTb_b)?PGY=+&&4^YCX;b[c0)_BNXZ8dRUJ1.T7Z?IU\EKQ;,L_3L(XD4C
aHY5+5=>Ie7R+,>AB>87#G:+-6#+\DIIF:IQ<3CEKN?RMc#aK4A#\TOOfB=V.9,4
F?DE,\RB;1B/-@3L^7O\>RfAI3d(c72U9US?TS9c.KV8G;dfDOX2>C>BI/;ASV;Z
I&ZNVCGdAY#I@K4-e8)Kg&cX+40U,M@&U]@H57?-6X.W:B:V?NLaXARMT_10=[;O
Z=T5:5YIW4O6&(Tg&Sce.JKF[f?0<DDgATV<dgaD(0>gJBU0?CO/R9.:-,=,P/K:
CH=-B(H4:O[<0XSSSfR=Ca@Tg(FE\81#66R.)LPD?Y<&IB]e^:KPNE=1--NY9RTO
F/dc[\12L)UF:-W/:5RY5LeWYXW&V3d50E2G]-5FFeY/-3?1-MB,VSKW(/B1Pe:&
4(2UOT=(aFVgH9fU#NgTQ1X6AKgf(-+:YCAe^ORUK3B;[QdM7W_d=W(<1OY?f^8-
4-=WA7IZE4X_8W7IQeL\)I74F,AMYBJgHUP=+Hb.C=c4,@QZP?&F^028dTSa9c8K
P8?:_fRH5Ad,Bd5Sb+5(K5(9+QMW@TaeQ,,9a&<SaM?/A/[3KX:A+c9;]E>[.-Z)
&_+D@E+1EL33Q9#L,S>(_[RUA,\?@D2g:=gU2JB+;+N[56#8;TWe^E71DIU.(O4S
Z-#@L^6dUbT90<F/D]5)Z41\;YE]d&U:FIAQQW;,f[KR7<)Ad&J=8KDOdA&H=&(g
ZV;([8Q#3;8LBPaJ-<=7X-:/NOL9-;C(E\O(0M-0Y8F-bIAM46/cQ56S1S-1;be.
+_DZT)1Ma4L2LL;\fFC7XWF/cc<(50dL=4eSZ0[GGLg9Z]JBZf.@(AQM@MY2()Q:
.XSJE@.=C7MAfWVOQ#QH_,4RJ\c;7?&XDB;NaN&Q:Z^;bH[84IZP:V<aHOY7XZL<
EDHBJf/?\\0Q9>X+K;QHVSKb[3dFI@:b4TE0-W]a59)f0I^9[LEbfO@O=M[I6WKQ
K-TY]C/2gH^]&JSN8S>@:F-G=:X@S]A6#>A8IPHZJdP(V2JVCT[];dK;A^_A_3A7
W(dAd+?@0R2cP\Z\/X-M2R^0cB5A<P7Sf)HEd9-7:1.QDCKIQ4S=(MeOP,ZV?.7J
X.Dc&a=2OP.6\^T[0U6F6QZ)\S\LQ@1QA&PR92.9F@-8CUdSRSPTX?G^UT>F.e:R
W&OgQc&d5K8^C+1cDa04-eS>BM4#E6fe4?;Z:X07>(K=VbNJ&S^U52@+J9f/7,VN
K]#cb@JZP.<WE==f6(-I.;H>M6CJ3<MVA,[eCL0O6)QRA9,&_+_AKd<J)&^ca=),
:GfC<\\5#9[cKO1a/-dJg(eJ08],_PL99UW-OJ8.<B4E9U/2fVNb>A>+fR1:SBPC
V/O&UVLLfb_UX3_I0#3]>a3P,dBX(Va467F2,ZY+FKB7+Z?GSOLZ_dLYJ<d/S+Y]
#ED,D)WMYcFS&IgfLP.[F0<^8/&3)Q]QL/YPX)@CX^1/J>b_M^>-FL;476G9)=5Y
_&8,C_+KT>71b0/FJ:?g#Z3IRZA,cZb:)_f)9=K7#L:RJXV^;,M7aWACR8?.bZ[0
=X^,@#4&P@+>,PCNAIf3X-O_#5TMYb2^(HX)EOQFQFUb:I^XOP-CJa;6,KX143-W
=RDDK37/.O_2Q:L0&UZHUC79.^BBBFZcK@W:,176.8^gEfOGCW-576TJ30#[Oc]M
?6GdJ66,9T+a&&8_YA1M[[/e@BcNOFV27JSf::)CCR\#8+/8IW54UXP6Y8>@B]UE
]DWc9LV\Z(Hdf=cgJJ=&]C8K:JQ;;=Vb)6U]NfD,\OK8Me0.5/1A_+HAOO[0+ccN
g./<IP>()QUIZTUNE;:QN/[JfQBDL2E+V>7+g.?M2[Fc2A0=(ddCCD_O^[H.M_>?
a@#IRCE9\JTP33aFe77EU9BR5O^/]5F?=S963-0MFIPdfB7[aUd@KMT(a?gQGLS,
VDPZ0\ab;4X4@K-]aCHS:46:dLHBD&24gR0^KV:7.6R@N:aQK[9B+bg0XPSH/I2(
e1G&#QIdbQ[97.F8=7?0GL,JH?Vab9Lfa:c:UG.0E8]APB=-X1:_(\\OgY6X4F/]
9-C<TSg09RJVHL#;.K1gX[POJV;>+PZ7W1@19e25JCH4#6aDR4S@e./Z,^#7\A_^
4D]d-dW]JQbR1fD&Q8Q)T^0RCI<E@OG4IQ;K.MECBdG19;&PD.FeaLa>A4AKK>?K
.(YPaQ#24NH5__N,<=CCf#YWV]PLFSZ-+8_&2#f9\#7BDBS^YcgYAf<#1:(fXBK(
G-.HD,4A8^gcO32Z-?,c1+-OW/3<VM9[,D4Q3&GC;<+X9eRMQKcO&[50W1JOCX#\
UUXS-[@CDC(&2@]d;NR9A7Rf_6)f-Lg9U=5Y.QXdR1X2XJ,a0M<YU_f);Z@LHC&W
[eaZXJCQfI+]Y64(e67:/Df8C-)/F?DJYS(ZGQFS(2>>ZN)^<,L8^4KGHOT\G8I(
J9OD<WC20:TULC2Q5@DL?NfHMVQSeF<+(YS6^)+(FM7^LZd4\+7b-C_2V^6&[_V.
3>bCCU:501X1Af:CNURg:EFLVA9Y\P]?a8]Of4>N7;ge;004JEOIR2X1J8YX[1\K
8A9A?1FBCaM[31@>d\f26_NRWcQg:ca+QV4_L>SG5QFVbKFfZ7VPIf&fV<KZ1CF@
LRB@.0gBC;_F/CJ3UYK<:J?6^S;K\HMM)N7]SRaXda-B2N?U15P?>Mf::PP8;N3_
ZGA?7F/9(.@6f/;<J/YB6G)WK=;G<DTbd57C9J2^?Y,8V@AIcgY0PZbZP,@LPN0N
/fCOOS(-P:CQ.<ODS4G/;@]O@@>CE@^W:\>(^N+A(_S)aS,B-II=ZC51QQZ,G(ZM
RObe;;;7CHG,]Z)g@5LK\78?6^RY,L9K7I)A]842D3:XgOfA-R8#Lb[_D&MB)Y@X
BJP)?1L_BAAAOgJ.=N[e=.>e5,]2+4e_@:IL\S7D7?6GSR<4L>N<WH0=LU7>6V&\
;e[EgHPV^d=O^#)>.F;B=?=g:6]2VWH:@e9&CZL:RI4DBLB\Q]OH]fP22=c<a:6(
V:8b2c?d)^X3BRGZI(91MAP-93RBBe++:9(3/H.[6ALHEF_N8cTa-TK#)OG+:bQ=
+gd>R;.@1FBL2]92C161BPL3KN>VZ#-A\[5:J)0eY5EQ=UMTS(QS,a:fD(LdWBSg
=_C\&7UOTcT]1SFVZBCUFKJ0+WG\8RNXC[2L#fcLY:E:g8(f]P#L]NZE^RH]F1/I
WW:^300LS)>LOU@>eg8JW(g48^-6c9091Z)[AfOLVBT#KWR=c=:9GP)<ZdND)(O1
S[N1ALR>RR2-5W=1,GQ[0H.Z^:E0D6KaU5=P>C-SL>ERP.BWY#S[g.KQKbRP,\2Y
5g/5c.PPaeg+;D:^@#.CR=K[D95>d)bH5EFVR]5TaOV^J^[KMV9fd#4fN:HVH]E+
^7DeS;9RU>(J[0LT;fGIZI-72B3A+2Y13W\<?+>G?T8a/eN5,O9NE(S[L,\1[_g#
dfd()Tg&d]S?gf[2ed6//NY2D-8#DdXcG-Y(?FSgLGHU/M_d:/IN)J,CSHKYa8O<
ZcBK&b=X,GB6/bFb-aIWM.NSfK##?T\6UK[6?I-D=^EfMFb_VGDMN6+8:/0HDfEG
5L+=B36@49AfXLBVE)HAK8(##>I431\6c_\B0U:KO>?_eP8aAg5RJ9<=1/3#AUF-
1fMYKA(F_@gG86=/PcTd,f\X#?;IFbGLZ18\Z0PQ(T),V4[F7dcZf2K91/X&^MT9
c5YP?-62V1H.c9=7SKd5bR3a/O&1D346.E]/O@.NX=2g0e0TM6@d5S]);LP08+?c
bfb4S#aZY.>#:VD+NI2I5239;5WWR+V#e;D[PcUNMc2-R+S25SDK1L8TeIe1,6,D
O:f4_W4fT\L+0(P..=gb6=&6FcFO_ZHF4@F-DDT4@a)^FWD>&XbFD95Y.bV6#@4=
b<#aM2WUYOYZ+QNe)S0dBMb,HHKDf8LW70f/F6>&0aEYI>_gK)IN^fcYX<^?X2D=
K=KCNE[SJ\()E]T29=\1NL6-U>\L8Y.BP[Q[>QP3D9VNR(cY)U];Z;>VdRfQOV0>
J-@C63RV<<^LD&[RT+OF#6P6<WKTARE9:e6)MLRXXM<T:X^5[IWb8Cd_F0S),WOg
P6+XN+_X4-XTfb@#JO@,IKc^RS=A+/G4H5MfQ#7;aN6XKa\S(bU20BfD=f8:ZDe9
FW^?G]-]P_5QV8A\?e5@_(V?8N<O&298:1Z4JU<BeG]+TWdQaY421)<6W&KLZ?_(
EA/[1LQD.R62<N];#5;),4ag&:N\FQ@b-/>=[JO7168I+>-:]7\WI,8MQ/9GW17>
C3(e+fZ6MW(-eV94bI^fHTNX1Xg\)e&UJgLLP-IOQ:Y?.,:EN3gIT=V@d-87I403
)c7NGA\J&?,cYJ.3[?7.92AR;JGdO3E/WUSa]aK1DY0\QOXZf\)N5U&BY)>QE&>O
S91<[NUS0J-C:)<00DN;XR[@>A^WBV/)B^?+EK(@TfJK0^2DD<[F<G@2,,-V98Bc
DWWe1ZHWR3;eUV,?(5T5V<+Y[]ZbZ<]H4T=N((]J0FdT^+<aLaZ(XJPUg=#@T;RS
ebE5K@^]=UJ6N/#=UDY#_c=-8fB.1D\:bUN3LgeeAWU@J@3DKc.L_;/A.<(36Ae)
#2dRJDKBcQ^QHCcLA+d#V#78RPQH-He5f/(a.CKE=dJW1AK3a.?=SUJH]B<fHcUJ
+c7f_LaLe<&D)8W->dH3b\?R?f_#WU-(:4K[MRA]1HSY3=C(6N1QBb=\GAWJ=+F<
?2?_cUf;AM7(NP7dVQ6aNT\]e)SX.A3&;WNVABT-]X[MJK<<Z]cBIK)E<];F9Rg,
#R5<>EBf^F/#9I.Q&CN<&1#16Z57W<](-()X.^R1G_>UY#@<G(:&[HFd#6)R-b<&
.QP+eYXPCOH=IY(K.JG;.UBO(If?0Cb+QgTNe&@e;b@<_/a#N:Sc,@<BAJW9_E1#
0Xd4UebO6UWD7dWb#-Wc;QRUT4g,e:.0C=K7X][:-Rc?ZCAg@<>8]QX0KB)6[/P0
UefG[FagYHe-@P-4D@&QP^W/\?Od4^9@D3_.W^PQE0V(S+?eZP=(&Y0Z8^1)eKEf
P;f25406Ze.()IR8A7T.aP6K_?,B+(Z#b?Ab+5?OQW3Ib??15D_HPYAgRaQ#UX=C
,,:4Ka5T<#-:=-)DR1LD-@J+E3@fJ80WWJ3LeV07QKUJ(&F\YL2/>BXQC(e=Q,/J
[?3baW]UWJ0Zf9FL6#N3BN[XbU\J1HRaU/OOJ-4,>5XM+A^Y_>X?,UMK>;Y@KAEL
##=7GPZ\\D50CK1=(Z]51^G5S#WZA@)-1[GO=2_,_NV=a3F#a>-&LWQ\/II-FLR0
-YN.)22/RR2D\EV\I<@B]CI:b14-?XE>IR#C1;9S5U:a5R-4MAa\fY7-5,DGXV;_
C]?^(_bP/KR^d@d,9YPL\5Te2;E_@6T;4D1cbW_M(3OdGTLHaD_5\L,PG\^9J_T.
5_R-@E)HfGC=W>dQ7SHQC:6[6UGI_XaG2d_,_^CZ3bC--@++=\@[;B##U4DG#00d
_J(;?1<OC]J6Wb#?:QPQCAH(PX?KJZOf=+)Kb95PO<#:)JXQR:=:b1Ug\026ADLM
]aTTZIT<+&\PV:bJbY>JCYJ,YHQ.+>g&g.-S7&#S,+:KW(JS^G[JP-cRA=FXQaHd
^R@8L>7)1,b9]SP\cA?-gAa]#=@;-R-SN+#&C5=^)@QS)H9IZ9JEOT35RbZB8W#(
1=&Q1IG>TQ7ZV&582W)K;I<=A:D0,WRdQ)QY,X,]L<.Z(^cZ-NTb9_Y#4U,ebM4M
MeUB)IP/NI[BWY8b)6[e;047V3]-P@;KFdF7OW)MH5@0dJ@E876>7&_M3-=9G,Yb
;1AH#eLL]IEPJI4b#QJWKEI4HB5RX&f3)P\0:F?BgP,6Q^?d(Q(1FgY&8X_gOdBX
?3abON\@L4FA<M)]#a.YQ)N[S@1_XV,ZB/)5VF4]??/26V^(#Tb73bIfY\T+:JRN
+J1dE;/??RgL/^]R]1^)IA/\KBbZa0[F@;H]LA:I6XZ7g[>1:[gH#1#U;B+>5]V5
f..Pb14BJT=/3Ig=L@V6BU/VOG.=HbR8WXOF:7WWY_MK#f2JbW+a7bO_ZR(EG&;X
@R30)6[[Te(QT4-a_D[c,H)g3KKDJ<[.X(fBga^LBbbX?4/QP8bWEZ+TA)Qf8c9L
JD\7<g,gVQ(]_82^HH5_2<dN]0Bbe<3U[DRC@UD)ba/:f@)dgEe23]E^.,V^[+2\
Q5H:N.eQFKK29KP_Y1RPMY4Z\Z#YKT[9?:(Sc8++Tg@@g6_2&WC4>0<+bba<^XS7
H#1dJ,Xg6K;c:e2\/bZD[M<8QFM4KH\#5XDE4fHIfP86<37]PK,[>OeF#;PN9dAP
P9)3]c(_EU=J;TG.1N>_[?cFX35?ZUL9NGW,0&6+EBW7P&9@5b?1EM0];AG]VGAW
Jg#6He=(H5)YdVbTc()O6&^[REYG;(aE=Qdf[OB:RAF9g/]<?M[1fabJ:W6O2@8/
7T=/(^b&(V<1KP@50#&RR:S@CEQHB[HOTQ,.KLcfD=gY-?4EDO5Tg1BX6+_,:1YX
U&HX3#5<IZJe\F)S62&=1?T:WPZCF0<SKU4=6S5E:DFDEIgI/X2D043:.(\1cCZP
D(A>6_VNR?Ka:MBLR2?/0@#W[;90B+WHRe9@+\bY68T92T@X3V^3<7/AOb8d,/S7
g&9\:.9ZMJIX7E=_VZJbCa7?X-aa)B.55,/W@PK\8D?XRK9c,N<FES6SOa1]^24,
NQY;+.IGU6XPZ5);ME0Xc-9a6E^X&OKM702fSI3S5<>9J3ZF04V+S?<I:)1+g(;F
c\4G4Q,A\(>07e5Hb&OXC7YXY^2]1U,V[2?YPUf@]XTSJf3F)>X#2]Rdgf9)&b7W
8R.-@d]:64_Sc)d>>:edOW_7O2b/:73IN5T\Q.<@ZY\Ea66]#6<EF@AKgFNP;X2b
)U-8(Q3HUPM,@S8E7D=3+@H8[]d9Q,H:d;]=SYdZHS5#RR7S9Z+&>BF,#UJZUN7C
D84IdbQB1#QBTGaEeA^O=<QEbX]4&HUb/@edV[ZH2DQKbD-<0BOH/J\AEZ<FbIg:
_0=PB\E].XN&8@J&N3.9G^@9E/DGVUQ=ZM)I19gIeC#P=@.2f1c@0@W.HVNG#0AD
V)^EKT?OML]B7bWb54fM6Y:(UP>?VG18e@ca)R3dBVF:LN^e/bHZJdc0;L8#[6H(
Ta^=.XB(N7PP^6b6K-=@Ef]G).NP1KW5LbA[S:O5UXL:g&H.6@>XR(5b0J3+PBXd
RZOKBPLXa>N+#^N[6OI2U[6Z.2EQc(cf^2.R2B=.H#/&Bg/+Yb3\7Q.#3LX=a7?N
D54(^b\6_G#UbF6M>WK#.eAT-EPQ&VUO);AYIUc/>cc5>@AaXMMLD+]&:c+#@=cO
1RRc^WBCBT]P0/2<X_cVT7e)@RPPa8(OCZ7W;4=f2B7-BISFSWeCMV:,^GH2<=Of
Ic2g-L4/2J))d.D]bX=,0A#M>J2YJ(Rcb=QWBT0101H>NCSRT3dCG2+/+30^K0;R
/IHc,/&I<AR0QJUFZ&\CX,T&F>ICH)?4</MD#@DV9g+Y0U,6,+ND3#1BV&<.=K1E
,L51T;5XKSYL4X]]dK>@V7g>Q/)T\;&2H6B/ZXN[U[dgb7dQYb;LP)YYF6MY<TWX
RL:,QV?/LH7HJ.:Z&]1\[=HJBCI>b]\3:8ZYI+Ke668KVAG:/N.[L<-<CF,,&f__
-SH<LbF5[)57FaP<&V-U.J]T8Y77cJXdd&\L^5-/O)Nd4IQ_31D)QNFeK^-H<^02
.,I<>(UAc8IAg6@)AWM1a/QDC]ER]RC_gV]@2I<gg98[>D\^5?@I2:=)I4aTU;YA
:<ZP]X0,3FZD&5;-[NZ0=A<>?419PN8=39F&abM5#<.#d@BVg_?aNN&@8\^EQO]-
W3XVPaZd3aFaJbS5,COMKQTcCT/U=Hd=BJ3.8)_=/[(]PdP:N^U3MF&/\b]4&VW&
<>_7,>2,1HI7gV=(=W\=fQ@27@&X.C?f;A/L;R-SA&X6&#/GFGbf#Qd\RQN:>fZ(
^e2_[/.IfeZOC(&[2&(XV;GWU5@a:2Z0?L6FA(0Hb(>39[).b_0PG_5+OU)JJE<)
1T?W\_-3Q9V8&f3f@++:SY1DdATD<2GY^TA&Ca</c<M:;Z8EH1BaK#>L:OO<:^9L
fF7_g&00PA>DZ/2_cT]3bZMW2Z^TXR;3fBeePM2CaJV;Q.W@NcM[F;;08><f:ReT
2;2/)B02,;,/U.=P7G)2aD@4BS.3JJ0UF&g3?<5FBe-N6S/RA\FJ_OX3UZgCCc]f
=:<IF9;+c,++#YVH96UD)adVL53(db6PQT14C=.F+\LXG@/aE9T6E<:T.PcRaN7O
E[6]-^0SR0@aC)T;XTMde)Sd#GGJLF;0-1Y/)fL\TNdN<\D\2Iab0I#63HEB?R\N
-T]DN3?:6?Ug3aJNJT0GL=,FLEMK>:(b+:Q16aPL0VZA7L&3.eOGA;IEc;8C565R
@>5(@c?g#&60C_2TKFE/D3SD0C6Fc<_RE7cPb/E/2<^5g_=.J,dV@X\PA/T+WW8I
8ZOP0(F@E;.Md3#4?)=DM>90aG,6:eOd,TS.L=D]NQ;AQS071QH^Ze5WMEAMH4[M
[HY1eND3:VfPZ9#bDfNSQAcY#Kd(:G(.R\.D:eAPWN4BS#MOF,G:L/QKJ3+\EeCR
1Ta)<(aR7e60^GXPHf?<8Xb-1ND=E_05N[<^]fNf/eP>0/S^R\F,MKO1^JJbU/bf
/WJTZZbPU>#+M/PX,6T4_?K(5FI(f>UcRU[#UeI0IL@Q6?a;+.?:QWJ]fHYTDE8B
+R[@@J9abHV3Q6g#ZITGM2b59@>QAK11&TTEN(2/H=HC^KB5+cf(fY4cF,QJ_Gb.
b[1>;47KQ&=MQ#X;AXNeA)O&_#(GI5,RO&LM:Vf:<CBEJ.dBbU/V?]I@/RPcT>cO
E79?A^6)70ef>EB]@).)T)FgccZYRA;1(0K#GGNLf4R-gWZ9cVdGD2XC(TbG[F-/
RJSA;0VJYAH,6DA?4NY1Tg3@<.KC1M9JP,G;]R6>VH?Q/=,6,46&+Zf^4N_&#(UW
9dZSH^fA_S^;a^B]^JHMOHSM,18ReT6.0DFLMEK#c4&YeTML]NdGBAS+5f3Mb9dQ
REI>J2IB8(MX^K6K,4e7+e;F0dZ+<\+6XVgUVSCegd1E1MT[3X>IG@LWJO0NNf:^
NGTb@SPUgWANYcEF5\cYCP,L:ZUJR[TQe<LFa70:DQ.3g5HKF+SZObg(BK][._.T
1VPH>8#HKWVU+5dJf@DW2(1^CgQU[NC^O&4W_,U(LB4bH)fd0/(+7TUMIc&^Q>Mc
UMc_E7&2\RcWED/dL(C;WeIc2a8]c0L]S@7I_Icg25dLO5cb^P-ZY_4KK&bf__YX
V39^8=1fD#OE>3,/QCXPQDAA5/F=TOB]c>XYBO?1^>McQN\FIB1#Wd+KaN\.fP1S
d7d-2D1C=YBG7,?[G#NbF,4REb))RR@PS/CNQbFI;ZHKT?HQ<+3;#VgQg./e1_Oe
I9?3C1.5.ABdceLZT.F1c4SN6-GfL@I\)]geePJ_QZ9V;[72JF,c<VcU5HG5d&\(
J?>g2&<J-g^NIEg18SJ+SEPIBGFO<,D^bT^MMOR2R#P.JLE&VS8TO\.X(EHf[G5g
7a6Wf<K-\+V/PG9(Hbaf\8T&,=US/:V)3-e3^@Jf]XV77cfT_P9aYR(/^T_],?2.
,H&J8,3UYUCKc)\?J)58I+_-JE[LJcY?N-YBS)W9-3>/W]-S/ZFI&e[De?I<MX3C
2(UaC0@DeK/Yf:GZ64/,Y,VbIB;@NEb@fKDB2E=T8#.]JW>[KEAR].EFH1GcF4eC
&0K/aeD79BdS1=T+c>J_K0X0[GY=P0(AIGK1;abfHAH]fT<6G9LTgN/G1?H+#TS4
N650T#>?142T+aLUIL@&^4eCc>\@:F&[]VSP.@SP@2bG<&HT8JgEJ(R>GfJN)?W_
W.PJ),M@K;G^^Le]BPHCK_#GbFL2>LK;GbG0^5EJL^g>,3C1]D>b0_1=R<FU/\CA
SH]HWOJ(XQ@J>WVO:WYWPSLVd28RM[fRH)[IW]>ZXQS:CLCSSd\H?TW0cgBY4A+U
U#Pb@X3QK8T:QVVbfNBPVfX)AbJPV[<@.6)EdFK.YN:C2Q0dA^ZS)\_Ba;_XPYXX
?a&WSJ\Ya4MR)#+H]Vf\=dc+OCFdEW?=62[TKGTfSXLW07G,1T\E[O=Ob1U=BGf?
@PI>M,GG#-.F5DM+#SXF2cTNF<\>5]Z(0MA,A3Z-+S6QDW?F>CYP0C.M2&=OB_<O
2QR-731:[QZ//A>SGY<5)55dUXJD[V?<><PDN#4=c7Ka>(/OT:.;2SMBD/UXf1]>
B-4GEfBV(D4Vc2fZNE^P^dgQ8:T:(0J.<7Y2fQUeD.+B@:)]#TF>-AB)4J6,>^-Y
(<2K>M1E-.Q]<ATJLTeCGR76J4SD>Nd^DQ\R;RA;XE&[+4?O40WPKI/_^&XSWg\S
BP82++H8.+(_VcX)(MHI9H9[XI/(#,bCIYY&0+EW\7S+4=5_H\,>#TMUff59eeXE
=2@dfQY71>XP0?PO&G]YQY,/WLDFga^(PIO(gAe;BF6\ef2P)8&)RX8#-3MQcNN5
AZ[f2Te_2/;UY.9Z9fee,Nc0?/503Bgf:B1GTSF<O>f8PG44&\V(M/F/ONN04<Ba
8BdSg#UK?_=e(\<+NDNgP1=,.J@X7Wb@&7+WL/[@O8:Q7GKL]M_9IF4&Z_a3],g,
g4@EYa-5&YQ8dHDF:c[g8JAKBZ/0\c@gF1TU1^(L8VI,dNEF,+dI,WceYcTK&71.
JRCaC11/>@9cN]D&N.:83IPgC;=DAF]CAc:9-7Fe>;&L/IXA<>ICcYga?)^P-P(F
@Z:I5+_6+QU1c#ZWeTH@NcI5XITbLMR]SF+AM&BDdaIOc8b7E=cRbRaT0,7>LRV_
[IVa6eX6LQ[=M;>][b<<^;#e1EQN6<)J2X,ME&;>@MUY2[#_Y(bM:2W,EG12gR(P
bJK:YGR,6I1@3O+UN6=?I^J@;[7I2LDVIW5,E?c,C<X+Tc#O3)GK6G),M#H@;bWD
I:B&1-O-VdO)>M]M>H@C-(5AY@TTX&\QIfWg/S/HJ^^K5Y-(F0aUISX)B+?[O76W
SG=Z?UBZZ_M^#)0W3-IbBK9Z=?AZ=C1FQ?06fM5&R60K=@/)Ce#(c+WDKEI6TJ]0
FZP<<cR&BbKQHXC\A]DSb[H4fdU9GUFSM;].YXN#C8,f__(51V.Y4Y0.:=B>\gD1
\6NQ7\(?(c\A;eKHMFZ7Z=M1ETK>7E=4gf#901_BS)8\(Ha^JU?UDJX5K^^5;6J=
E,#<2;VS+#H1aUP1,VA?+QH\#ELTA-VJZ.VJLRXHO[e<&?+P=8J.#U\\-)?U6G<@
G-<]01-4Q4RX]V43<MC8:S_e5J)U10C(KBGUDCK8[V?+ZWf,SLa[6WXSE\GOTEgZ
D49HH=+8,f)\<@FNX+I.L^/A(A<P:ZL>_&V-FPG^#U6[ad&Mb_OfZM>H&MQeLd[6
N_[=;;U#6\0XWJV5KGV\EY0;(<1RRMT\5=3CMX3Wg3/N0TWc83I#dG-(K]64FP9Z
K^8S_93&,3RI-ATB-Xe&-)Mg-H=BUH,SD.\dM516dK>;9)<YbC7[XLH@&EEF+.T4
,,]Y9)&1b<B5b6X(]ed2?[&T]O[+d,K^?VVb0W91(-B?,=5:fKG:>;:Z))[\13T:
WYAcK#):P?\NI2>[H8.e&WaMbS6X@XRaeCRcM7),=e_PaEJTFLX_IS=cU.+[AYaa
,L8Ta4YMMUg<DgGF=0X=DC9S+SA?\cFF9Z@[Hg+K0?N:#<>U1Q#@C/1e6_[b\XOI
aGVZ1:@c6#5&C[F&b4c(c)d[H^VY](&<&#fJZLA@/)5)1\E/L26G=<6N4_b5(1aY
KSOS/M=;3V(4AIT=1H7U::f0R)>FZRV+_bQ.Be0.:^Leaf@Pd7#Z.XOb.>6]+T.E
\\P&E(bX]TRX0-@4.?X/PR9;M;A)-+Wc9b]2S]0=2d)^??MgD/dI)\QW/+&M82Rf
(_b)5b1][QZPSP;+)(@Da?XTUZIJL56WV6-JgI.>5B;K8=^FLCUR08Ia7:0<8HUZ
;(8)CA\R?0C8gGL6;1Kd@O561Qc&#R\7,@(.W/YJAY_&])U?Ee[6TLcCGeJ(?S,f
OR;>CHZ8I2dWBDV\I[+&N69F3#5K6/0E,a_,fg)aPB,69^]4QKPd)E.@@;0aIb33
\+<#)3X^,J/90J<Jb.-O\4?Y9HP0G@^@_YZZK_M&GbVL[[[/4;RL]1+b->=[EbB4
;8QL61GSCL&\/0,\bO\ZdGI=F65FU+)Q9AQ>/#/&Q;cb_W?PAdN&^06R>7FGXF-e
B;>;JT2a+;?^)Q\M(?f1O01g=^-^1JIa9e&\B=93J8@BG&eUF?]]FK4)1N+NX^GA
87KQ8+b4@2L&[-:dOT][\\F2C?;[Pg0M@#U)QXVWB>#J1&Fe+0;5Y#BRWT<5TIWY
NdZ:>d;WRF]CI)PHR.&f]L.071C:K]G3^S_<-R_L:,B;K>ZNG5V>>8[f>+T;e3<E
+,39]RGO_8RUO-bcS/eR]b5:&](5)e2fR<1;g#D>3W>:YC@\1/HS,Pd/\87E6XeA
5Oe3X-LQ8Zd=)NRfQ5(H+P&0F8:M/A2132=N7U]W_@?.HBJEZ5[[,\OC+,0_K)MX
?UJa]Z@bK:(0\aV(TTG/AJ^/\2XO)KZF?4/F<C^bIB?Ab\3\0gVLEYe.J/\+Jf6L
C(N)-[,/-6TN6Q^De12/c9R7;YJHJ[\Y1eR>.IM+8,75SKH8LbM]>[F8?B,aFL6^
2U;)8>;+78Df/g&?+G#=X;88B@6NOf6cO34^5[Cg6\8+NJ8GZ@OdC/?:>(AC[)#N
5S@gJ\<<+-a;V+8AccC3dG<8\LAD+VN(aCB4\8,=07->]L[b>=O6Nc/g6fFU:WWQ
(PF.(K2?]_@OT4N;B>6MF<Gg6[G?;@H,#9;cfaRJCX9X+[9+dMa,d#C,3O_CV&;G
6JHO0LZVVN-aCXJ5]I=>NR<HTKb&dN-NCSO4RN^fKU9EgU-[H0U[9=;9T1OdZ;;0
Y+;9Y>PBG_5MR>?3N;4PPfOLSN?>N;D7RQ_W-KN1f?QFLX::Y_=IcKg-N[3,0(1a
S((2fSe3^MZY>E-;b]-P@8-2M7ZS/DYJ3+VJ8(daD3/.P,XUE:fQf6cJFC3/_F,N
I83W;)6Rd17)0PD4cPbI)IXgCLC)TS7O@I+dc\P\06+,]T_7A=#WM^1Sf-0g#V>Z
O>RF6<Q:e+)f9;20?\H@XOeUCG19KgI,:VR8a_AB)0X,cRM>M(F7PA[#SL.,f99J
0f@,@(7-518:3FEPI_<QC_8V>G&Y:=4U:H+4^<T/;]gT&g)E[>7>EcXf.^/-EaR&
/[U8H8SDSIPEV7JV,?7M1JFN(G7:0>>Gd]P\SH^H17fE>^6SLW,6dIf)2\E79eF@
CaS@JC:NGT&c2d+dC,E^Me.\^GdOSE#7.P41/\:H1[a4A=F0WPf]eg@a_U;;BUKF
8\IXF:(RI#;=;R_U++8[0VVCUfUG+1=@&KS&:3=bGKC\7TbB&\gbL2]9_]75cTMJ
4\CC-3W;76aLBOEbAWWT7,_[UY\ZPT:/?UeWecTa]_YK+7PMe+<YQJS6]D#9=g)+
<PRN:=[UaeHD/P-1>6+&D>-LZX3GX8U@_C>V7PKQG9,e1#T]NC4/5DYVf?@)Pa23
E7C2eP6Vd/2&C&Y>-]2Yf:=RM[/>:g_?fVUQ+4X&cNG&38[&JZ7&150M-N).K@AR
HQd9ff?FFd+W(B0H<(F,_L2F\M#g;S41b9YQ;,=@<,PWN/KGc>0aUM,,GH+d:.=@
N:RG8&IYf\a50[P?7UJ).1(d>c:E[-53H3e#EUXHb/bUBY;>3+7LXaRK6//IMK<\
2MRPF(3a<FUH/096JK/8N0WWQDd5)?;,<#LXV)Ug-6HcJ>C>Z():=?N2c#XGGB6M
7T[.J[)UBZa=L8.7VBPaF],1(EN=KQN.M@FSCTF&M6\&F1RAUWfCIH8&P[HDT=:,
T@V,a+G_&GDQ8J<=AW>#H[We;0[HCSM@@A<_f;N(W.7(,]-/S[Ae;e]+@<V=^3KO
X69J;L.R74731Hb;@cSR]AfMX+Pfd8]AJ;1d4JQ)1?2Mg2=VF5N]-Q4gR;E56[=\
&#KG)3(JZV;T^K-41-@341^88K]d3_0/gH0ObI+Z.&]4F:HdKQ05\Ab#,16_>VYX
cBO&37]5DTW??)_&+ZO3[Q^Gfc6>5fDN_K/Y-261d6>(3I#R:>5_I6@d<6;KGI]4
BI2G@J3a9f+9Za8@6bAd4;/A;ZeO@PPF8)<7]4;R;):#5E.R-.@J@#2A[X0#&FH7
a9f2/U,O&0]P08COWY?;W@>@FbGHLNeLG_:CG1f2;?3#I50?(VN185)FC3?fV9N,
9fSGUceQG7]KePZ@.bc;P@A34T&A&#L^DaN6c2ACf,9+:8?-Z6P_5PT9F0LW7X8+
3X5NCXX=MGOaIV+Fg(gG^CP]#A(,?LcFS\AM[PY5[&AeL^&a.YBW9.^I3ePPSG[=
//\(J<<9X:_:OgHX\63+>KNSL;fN+KG0a3<bWg79J37?NX;a,WJA>=CM)&bD\Sac
XgU>Sg-&cPS8YGP297Zb\/^/BH;-9N;b06NKGOFRLM^;0,Y^SYYL^N&:Yb;?2O[>
.@<,1=S((TECGETZM+(\4U5^,Z@B;fH18Y4GfC3;Ja4\D(F[G=NYCYOeV57>UF\Z
MP\7&(^S(;AVD,9ISHGb>;,8Z<;#bA+RE-?EZBg>AN6RU[B\+>;O_\/9)4Z666.C
GF\DO@M&Z,P]74U>8>8MW)HN8:HV-(f8S<A2MaPH@90deFMF8-,_[?8Z:gDP,SB:
ZMIgA-<]4#39.:H6TF<CLE:A[EF>;@c47QGKb,)\<K(X].[N6IE@M5#O5#f.@cO;
L\1S&+;\DOfd,^OO?8@O[I2:X;>B,]JL8,_IZ2/6-6bLL8;@fN4FN-2^eQ2a?e]U
0.L;dYdc#UbgLU2VHWO57<?5K[^9@8IK69&.dF=_.WW7&Y)L6VXFUB=a5Y.KHgc>
)Zb]::Y[1)0HYHEYe010g8SgIg=<D((#-:1CAO[XO);]f(NE[Z_9-X(=-.ND=XOf
UAG6MF]T6X9U87g)H3WVAgK9bQY=&dBcFMRf9<B&G3KZ/QCDNZGAN.^.)KWNF?66
?(15N/BZA]0ZP(WPNJG&5#(,6aMVJ.D)@$
`endprotected


`endif // GUARD_SVT_SPI_STATUS_SV

