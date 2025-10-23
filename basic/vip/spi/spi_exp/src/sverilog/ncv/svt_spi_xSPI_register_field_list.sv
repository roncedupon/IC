
`ifndef GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV 
`define GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV
// =============================================================================
/**
 * This class specifies single register field of xSPI Register. <br/>
 * It encapsulates field name and its default value, supported field width, list of registers that contains this register field. <br/>
 * Member 'nonvolatile_reg_field' holds non volatile (if applicable) version <br/>
 * of this register field. <br/>
 *
 * Following register fields/variables are supported in generic registers: <br/>
 * <b> <font size="+2"> Field Name </font> <br/> </b>
 *  1. write_in_progress              : Device Busy/Read Status             <br/>
 *  2. write_enable_latch             : Device Write Enabled or not         <br/> 
 *  3. program_error                  : Device detected Program Error       <br/>
 *  4. erase_error                    : Device detected Erase Error         <br/>
 *  5. dummy_cycles                   : Sets Number of dummy clock cycles   <br/>
 *  6. quad_mode_enable               : Device QPI/Quad mode enables or not <br/>
 *  7. octal_mode_enable              : Device Octal mode enables or not    <br/>
 *  8. ddr_mode_select                : Device DDR mode enables or not      <br/>
 *  9. io_driver_strength             : Sets driver strength                <br/>
 */
class svt_spi_xSPI_register_field_list extends svt_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  
  /** This field specifies the register field name */
  string field_name = "";

  /** This field specifies the register field value */
  bit[`SVT_SPI_xSPI_MAX_REG_FIELD_WIDTH-1:0] field_value;
  
  /** This field specifies the width of the register field */
  int field_width = `SVT_SPI_xSPI_MAX_REG_FIELD_WIDTH;

  /** This field specifies the access type(Read Only, Read-Write) of the register field */
  svt_spi_types::xSPI_register_field_access_type_enum access_type = svt_spi_types::RD_WR;
  
  /** This field specifies the field type(Volatile, Non Volatile, OTP etc) of the register field */
  svt_spi_types::xSPI_register_field_type_enum field_type = svt_spi_types::VOLATILE;

  /** This object specifies the list registers, which contains the register field  */
  svt_spi_xSPI_reg_field_register_map register_map[];
  
  /** This object contains the non-volatile copy of register field  */
  svt_spi_xSPI_register_field_list nonvolatile_reg_field;
  
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
  `svt_vmm_data_new(svt_spi_xSPI_register_field_list)
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
  extern function new(string name = "svt_spi_xSPI_register_field_list");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_register_field_list)
    `svt_field_array_object(register_map, `SVT_ALL_ON|`SVT_NOPACK|`SVT_DEEP|`SVT_NOCOPY, `SVT_HOW_DEEP|`SVT_NOCOMPARE)
    `svt_field_object(nonvolatile_reg_field,`SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
  `svt_data_member_end(svt_spi_xSPI_register_field_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_register_field_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_xSPI_register_field_list)
  `vmm_class_factory(svt_spi_xSPI_register_field_list)
`endif

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
dNXpf3tkkWfAwsWjAXdECssklET5N0YC4rSs9Ww1K3BdRb0S34GfTluDpc2c/dXF
M3rU6+hk7NfqzK7qWHCr3bZHNNILlItPvidyPb7aCpfVW5LHc88D7eBiTbtpnAhV
iJMrkh3WyUiCR6ZDemJfEa0nPgEpUpclr1GUk4Ugd8vQNysRvC+rXA==
//pragma protect end_key_block
//pragma protect digest_block
T5sk77ooli6Zw7QytYeihMo17m8=
//pragma protect end_digest_block
//pragma protect data_block
KcxKaDyX4rGnb1hE6s6kWbwaAhcufGR7AvnhD1OH3qrfbOpzUIy63pRvYLY8K6Sf
mVIsW4q82No2HIem0oE0bmLUZtDTcGk5RRdCKCQ2I7RCA1DlHxjzKtzb70bInQx6
Cu+2syC/pQAzx895nchNf8UjKpqhgjty+9GW6JWusr4ynnvibb1NrMcMylFZRp1J
arwRUPzvqN/zwbgmPJhQYlVH/v4SA3ytOy4tn4J3rBs0QujFk2qQFTI1WbgbEucO
JbALP0TXwAJeQ8lHiqu6jBpq00WRRKuHsKPsSUuUQvUZOq08AVbimrhbwGaa03I+
6gYS0gI69ULHCh6yGCdAhCgTAryHlEtgynuuQmT9tKijsX4ENwpfQlx+Mh4HhVIA
Aq7Rhg7NOQHHyUcfzGUlVNc9RpM+OQ576IQoL6mT0x34aWw324dwKOArN/VWhjNe
NbOX9VIthgYNuVCqLCguKBRbU9fuEB+rrCyh6KLkvtLwvPI1GeJLRXgJxEyfGX9z
k0dwljJMkS23sbrH7wljXLvHwEvUISaibbRogZaZu5RLLBXrG3a/eDHqxhGxw0pz
fh3FHNpcBzHIyH9nwwdyCzEGsSGu59q2TyxWpLhxDsPi034rktL3KIQ6nMXzm4Hj
qeFr0znN+xRcDNpSYwf3R6yoGbpjyucJnrUn+8PyRT//uMPnUfmIyd0HcziweRU3
ymks2N3QaJn+D4Fkk9YnTNMipvcNto98YO2XCeZxIJyhy6dufmMznQ5AegNxS9XU
C8sQAXWTWx6r+RFiv2/UfkCGEWegRe//NHuKJ6e8AMoedxL+y1vNTGl2le8IjMxD
oQbIApjJTpBoziFw3IfBTgK2W5ca9K+/SB4WH4W0tJXw890aE71YvoZ3QaE157ud
NiUiq0K5eQ9Dm/Jp1tT9S9C6/Rqt/6TcGq4qdNCGL3ayLvcPNVJgsXy4dCax0oTM
R+4FtQHIYPMGQyqMXb90UQYm9itwc1vznIltIxp4ky0NSK0AiHvX9fTgfUuV19qp
KV9b2yxu1WxuSXt+GOqGWZecwRjUhVniWo8zsIZOS/c=
//pragma protect end_data_block
//pragma protect digest_block
ZAAHeyoTFYN+X/puXppb27hJ+pw=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ydz+d08KmHbRGDz/RZtJ1VY/l+HVhvOjKCPwBFvZxeeWH+KNQNDNWXgaUpWnVOOQ
jo4GSJp535YfLnrQ4nidC75QUnWEvCp6BnnqmAlCoveRczuNLuyxQsfQJzltBbLc
xhPYAnT1xoraGqZ/H5wGXh/b01zVknS3U7h87vpW0wpAbTo/gTkBiw==
//pragma protect end_key_block
//pragma protect digest_block
DU/KW/YPbX8HgIsMBqrhT4FXTMQ=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
s/FkKbwJmlIv/dif0TiPrTX3Xpc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV

