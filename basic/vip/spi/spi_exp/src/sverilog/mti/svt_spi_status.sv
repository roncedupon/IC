
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oHOHWXrEDF8QLOp8zd6Y8TpNf9bFoNQ7UR0PFUc+ubOckPTT2razTTkVt47hhgux
HSlHSfUouAtwHh7QPfm5JoY8lbaP6tClXu+5I4LNBqKI+MrFQrHw5mAeIAvgGUo8
BFwahAGKVvx/kmAy6pS7Ssct5EkzqXCHAeqtiZwKad8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 615       )
qRnuu6DQi6UW4Cz9WQuMRWs5AH2ZHeZCAVkXfgt3n/xwwmth7nmjQB5HUteDFSVl
2HNjbT5IXAS4lkzxM4LSqdsr/utMpbCB9rZ7xuQXuS4IaG+vd6bRNi8BLoiXj4Lh
zFNTn6h25bE+dcr2OuRxSFOwNddIzvoODlGMI5Gu41pLdsK/pJ5PunUYKMnE9JJw
GLn5wgqqCIwDK4d4wdZE3l2Y1d3fa5erAEJLtfPhtKed64+ZWLUC+NO/P2cbAKbk
+kjrszEnVfuVRdA0ynzVa20NIyLZT1Yd8+LqRUgBbi9YUp21kPcfkMfUZhnmVFgU
9rw4YHeBjyAkYr3AmgCJixOto6Qn5c2zr+TEZdoNoqNH8NFkrTNhXFdfJNw/uyIw
MMCyV237hS0EUdMFFwRJBdv3VwOTVc/ty2tTN3dK4A3fNRYjtew0WnV2xi67SSL2
M9yMhI5JqN7kuCescpyU9K+cevDhyr4fZSFbpIrxOE16Ew5UTmsVaLQxRN0eH6H+
dfbd1kmI05VQEEcaxm9Qh9rUwW7IKoYVKIvIAydfKjrppaZuNFGowPXHT7TxHu10
zRW+jfifN4G02zvqoUoFpLf3SGd6GAzpD4J5sCuKK/+65FAno7ZTL6vt85TJmPHk
fNObmufoB1L7J9W/0Ut5ys0/M0nem3uY6I1wisHWAkWAC773IvdhKCYqnLhooSnt
1OJUUpQ0nKCKaNQwzirzClsl7QUzEHZFucnr5iQkenPAfLWI1pkRnFV2I+whSsI8
H9XTSJ8EyK/G0eWhcTBv7fDjBLUrsWZePUc54IACbdd+QiFiXlPbBZgMZn6nYS4/
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jE8K2rlHas2VAy29cgV8sXd3RrZAB1+XqMaNGtGvxsyloKOecm8+XqXRWtLMsY/v
T/DfrtclNt9kORxA8RNCbiNP92EsgOMpw2Fgx9dbY5mm/GFry8HpZz76m2OaXnPc
KZrCBjjik4eCrUU8dTu7sufW5YVwx/KaJCqylhnbD1g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 36961     )
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
oxeqqmNNd6o5kyWQwo27zg==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_STATUS_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G4yAWCbrbNSJBYl5KFnpTDEDn95DeH9cxmSKANEdkeGMwBs4b0IntLq9XNHR1814
ZyDz0bEQZU+uyHO3NrBu10OT39oCAGTLZFqS+oqioJBTXMTEbW07M0BpFPjiQ51N
Vq96iqiTJR8pkEdBAk5xeDv4MOdu3RbmAEZ4LbJQrbw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 37044     )
EegmSc6IKeH4UJFQuZ+vzIHyNhX3hho4tjQt6Fvlf+sApY62AGggTmSEkPpu5vRO
bl1OteYHeUY9ed78kRG8lKFrhIvkIgsZ3nc21ak06wgn2PJLKAR45QpjIO5Tr+ox
`pragma protect end_protected
