
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TaxLaprReC0l30T0jhvaXwQ9HW309pZzATh+1KjlHLLtbju6YpFv7QMDMNzNedPV
g/A4LX5o76l07AKYdMTe3j3fJLWpiNebn9CpkYVrg1dEA0eXMRQYkQq9F8GptDzl
PH7Ey19yBsHFvZVPfBWhEzREORqkb34LFBRC195Ficf7WWNB8MklOA==
//pragma protect end_key_block
//pragma protect digest_block
9/cG/f2Dt2vW98LY8ba5LND+G9I=
//pragma protect end_digest_block
//pragma protect data_block
mfSsOtSXADq3ffiLi50cCsshygSM23C4j65uUfYyJRdrUMLVse4N4dpu5Gfb9NDD
KnobYCGLYi1zh5ogHl37kUlyaA860qH28mSAm4aogvv7F508zMRWJA/XL+RtcF5b
HL1cI5L5I9MWIplYKqnIWtZ+hnYlueSSeK1P16vTNywWhiiyRpJyrW5hIxmT0+fn
khgfTyIHBYeONYRjvai8hw5/KcnFY7ouEYVhVW+oCTtCCshZozP6Hc0MsmucMn8s
A6UvRUES0n5KTwB/MHMndPjHnWbpVVANHKeBWIOQGMU5O4tw58mYQEDeC45hUt5I
ApEsFl1jWQ6hKASRg7yLJnFJumDZsIeY8m45IGdLVN+8SvyypfU4uXeqv1cg+4fY
FCskY8IkjIPvKWpzr80O+l0PNOz/bdd87QgwXGhKGfQf3zorRgj7Yoi7wPWosXG/
EmhTpcCEBYUXWz8XaTfih6NGVskFqQtmZHPS+dVap+nMjxfYm8MoIgo+855oseh/
X1n+2Tgo/6LqXuMhVYjeDYvtTvg9eaqQAUMyTWAG6knC/o7FX9yG7sQ98A8+w7yL
wkRxtlMacX9Fdv37PTrZXEXfMaEYHw+c9tGeOiA5zTkcZ9pZHATvR14HDSc1YtuV
kFKjzSf5HzuQnn+lPeHFw5iMhc+UUGHhBps2t6mxVRZUeoROTbMTpJvlWkzrxBYm
mlEFdbYdJn41unKKqZwi2XM34f77QmayKE4RlCc0jMfdd9KTttzUSnyj1brXYnNL
zkaI5Mgy7WHOSlaL0HlK12aMVsL3jURoUZz1BouRVTwkkeuw9vnh0LQUa6EoTj5Q
tSVGIx/AvhqKoJ3hpr08PsZfu2ekanHyhflHnk5LUYRxL9br48aD4YHOycg7xCnQ
Xir1E2SmM5u8OFr8SGnVEKBFRhkLiqB3QXXkWh4p+ZoDcZx+loyHf2OMvCdIB/sa
zVg6HFSpKxs2st8WsOgUYujXhONKTBHVhyChK3mCm0eAWLZwOfLta2oqndIusirh
DI6oGt5vAFYcsBI2vSPhhg==
//pragma protect end_data_block
//pragma protect digest_block
pnYQUG8+w8xN7NTq7XzoRSBL2yg=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2gDBDwBSlZuHPKtrMYSaRuu8LCdL7a3ztIPtb36fmzqxcT8Dk8dfxuY/t0DV205V
2asjgP/BHFi4zbzEObFN0tYr7IgSJYxSQYGD6WF6Hzzft93cdJfyu8N02aHsIeMl
1ij6kNL1BbytJGd/B1L2eL+9gS2i5qEcgJ/AkuEgJCqjQbnFJIYG4Q==
//pragma protect end_key_block
//pragma protect digest_block
i5siWLHk2VIgTxu6xHbaSeSRMD8=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
fWlsWEVr2jYJYbiCJYiuRVsSHgU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_STATUS_SV

