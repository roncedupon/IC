
`ifndef GUARD_SVT_SPI_MEM_DATA_PARTITION_SV
`define GUARD_SVT_SPI_MEM_DATA_PARTITION_SV

// =============================================================================
/**
 *  This is the SPI VIP flash Mem Partition Data Class. <br/>
 *  It contains Data and Data Valid Array fields to be transmitted in the Upper Partitioned Data.<br/>
 *  Currently this is used in APMEMORY parts where Data is transmitted in more than 8 lanes. (16 lanes)
 */
class svt_spi_mem_data_partition extends `SVT_TRANSACTION_TYPE;

  /**
    @grouphdr spi_trans_flash SPI Flash attributes
    This group contains attributes which are relevant to SPI Flash
    */

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  //
  /**
   * @groupname spi_trans_flash
   * This field specifies the number of Mem Partition DATA bytes in Data phase. <br/>
   */
  rand int unsigned data_frame_size = 0;
  
  /** 
   * @groupname spi_trans_flash
   * This field contains the actual Mem Partition Data to be transmitted. <br/>
   * This field width will depend on the value of data width configured in this system by define SVT_SPI_DATA_WIDTH.
   */ 
  rand bit [`SVT_SPI_DATA_WIDTH-1:0] data_array[];

  /**
   * @groupname spi_trans_flash
   * This field contains the Mem Partition Data mask bits. Supported only for flash Mode with DM feature support like apmemory <br/>
   * This field width will depend on the value of data width configured in this system by define SVT_SPI_DATA_WIDTH. <br/>
   * data_array_valid = 1 : Denotes that corresponding Index in data_array[] array is valid. <br/>
   * data_array_valid = 0 : Denotes that corresponding Index in data_array[] array is not valid. <br/>
   * If size of data_array_valid is 0, all indexes in data_array[] are valid.
   */
  rand bit [`SVT_SPI_DATA_WIDTH-1:0] data_array_valid[];

  /**
   * @groupname spi_trans_flash
   * This Read Only field contains the Device Physical Address where the Memory has been updated/Read.
   * This can be used in Analysis port and Scoreboarding purposes.
   */ 
  bit [`SVT_SPI_MAX_ADDR_CRC_BIT_WIDTH-1:0] address_frame;

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
   * Valid ranges constraints insure that the transaction settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
    data_array.size == data_frame_size;

    data_array_valid.size inside {0,data_array.size};
    if(data_array_valid.size)
      foreach(data_array_valid[i]) data_array_valid[i] inside {{`SVT_SPI_DATA_WIDTH{1'b0}}, {`SVT_SPI_DATA_WIDTH{1'b1}}};
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_mem_data_partition)
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
  extern function new(string name = "svt_spi_mem_data_partition");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_mem_data_partition)
  `svt_data_member_end(svt_spi_mem_data_partition)

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
   * Allocates a new object of type svt_spi_mem_data_partition.
   */
  extern virtual function vmm_data do_allocate();
`endif

//  //----------------------------------------------------------------------------
//  /** Used to limit a copy to the dynamic configuration members of the object.*/
//  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** 
   * This function defines the print task for svt_spi_mem_data_partition class.
   */
  extern function void do_print(`SVT_XVM(printer) printer);
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
  `vmm_typename(svt_spi_mem_data_partition)
  `vmm_class_factory(svt_spi_mem_data_partition)
`endif

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bFqZczxiV5JC32Z+F/lkooiQfGGP8W9on1tzi1iXYEBsQ01JEuM5CmoRbFYlXTab
Xgel/H57n/qDp1TpqPZZr3B2J1UZJ1ca5/CO6wbG3Z/CZKUW5uyI5qsBpmc2isk6
KoJBemfV3MdKN7nELyOEmm9a9qoW9FTDG7XNKaK8VQUg5W1DHU7CrA==
//pragma protect end_key_block
//pragma protect digest_block
AH1s1jfhiCSryWyecXozE60XOsA=
//pragma protect end_digest_block
//pragma protect data_block
IQ4RgxLxnwIx47qp4Thpx5mTLmnN70yId0aewaLXMbMcXZuo6FLkZwT5S3FdlFFE
tE+hWkgnUQm+HwSat2J+LV1xPswsrFE2eyiX+YrP9fWe/agl+dH4GdEw929Wxv9C
/urAs76Y6gQX8iFHVoSzDsSdUbhkRaiz8KPEMChPShIUr82HMcvSip6RklYcPRP1
mKmM/y4rXGeZ3bvC8VqI6IeFi5frxV8JYYhLFaldreDiA6xtHvwkn4yqw5OeC36N
+OTK7OyNvUukofZflA8W/5qjpLuBvo13zzs8mTYnIjUMqdlXOiVTqpNgg8bjHUEi
Goq7LSOOtihnqNXiUs7Ft9qN8TMVY9jbpC0JG4ZKhDEURpZo4ZGzetd95FOOWkYW
oOX1aqF6rHcboF+KHSA12bos9W8P03jBxRlrdkGI5VAuUbcAQQVbnWwVXsQvqyfN
D0FDpJv9fcgWkBfqzx+ygpHqx3riYtNCG6/gWJEYwdBJzjRmq+GoZ3Tlv5LP+dWH
ZJLE8fzNMxtHXxT47Xiq7hIDxPQlTiDhTG53sWlAL54H0Z1RVj/pbT2qg8syThT1
owKS9c6jEIW5MB2FhGXCnAIArhB4IOJrzLJLDbMvar3H3ohWxchBuYh+8yLfxcNM
z8DPGN09n5WmouLEFsZ7qXq+lU1H49ASVTqXJEM21bGfsqI4IOx74ZAzGHNOCm2S
1d+EojB7kVuTIYUF+bDAsi54KxmRjQrSmfN9q7/BiKkIhbS222VdyquVeHnJDOpN
8PunhjOLmw7281zMNRlYdlUNSsE74bdFsFvAyBZ5SFPNUYIdZAki38DA8rlSSyCw
HcUoqkZGCrZD7hCnFCt3lnlfJNEeuZb0x+ZY1O/ExvaSSvbV2M6H2iX3VAefmccf
KuFpNbb9f4o/A5Y+GRkXt1ZYFV+OLHVHKEVxny+JY6B/QV/wY6R5iTG0cl0sz7B2
+qfGuo2RMr4wZ0Fsb5ujbWGQOXPd6xXlakEMgwB+p8br3Iv10CPqtxQHbQoHGZfm

//pragma protect end_data_block
//pragma protect digest_block
6YGfCf7HgT4qYhVaQyTIeSe6ZCc=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6uT53qrKTHVU1S22C6Q9lRLamPg4M6wmUH0s39KD3oCRkRH/04bLhXjvQiFV0Qgs
AkY4hx+wD87245+Gu/6h4F7lKCBIApYU3GM2HaHiejqKGIOXcP3aTTyGFzvtTLcO
gV1zsDV8WstYpYtpeM5wEmh2QAhgeCiK0er3VGkJL9iDqGP9DfRJ/g==
//pragma protect end_key_block
//pragma protect digest_block
O3tpByTtxQSEghBPaYOvl4tXVNM=
//pragma protect end_digest_block
//pragma protect data_block
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
wYNCuRGciT7NxpEv0gH3Hg==
//pragma protect end_data_block
//pragma protect digest_block
2lDDIDo03KENuLZgPnETH8Ml1o8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_MEM_DATA_PARTITION_SV

