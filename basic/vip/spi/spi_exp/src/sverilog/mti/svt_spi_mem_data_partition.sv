
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e/oZWv+wMtNJUqRT28sFIo/6cVDocmjRbsCtErTr9sDsU6NWnvZHPB+DdNbDG7mi
fAPBtT7UzX9dtcZqeexUe62HloniEXIpW5+IK84z8VMKXmN4pSI6mAK2gLr1GqSH
iIASiTG0iqCmoSsPgTvJ+HkslQjeIqsu5xLG/zptYh8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 598       )
hW+2YHt9Iz8tfEo/Nace3VLHDEFV9zdC4YqsKRJt3PECEq7zXQ4LlFM6UiZcoFFE
KL4Ws/5Ht9sTCaU4XPkLG081W9Mwl/hHQvrjS9deW+NAZMOCNIhV6NKY6L9EMP8J
Zzh4Si+khKOujffNwnPieo2PLDH7YDzYCg5Nz5gP5qvWizwcowokHRQULALMNXTM
kxXujjBUehSwOuBspN0tIlTkUiGxWsb+GqiQlp7CwlBkvmKmUxDnXi5pz0RWXUCX
HuZzyuQiB90qdrcmRMyudyYWVR6AE8bZH1gcwGPD/8W7UYN2ek3NzuzoAclMrrQD
D/WhfECz92hxqyE5RHU8e/nfw33EuM+Kmg4O0fvty+39N1SnDwEnIAzEFZfPc0L4
//XOhwwM8XYjlZDksyMYXUnBAVomVjTXWVxelogdm2jnfiMRVOokWbrABxNxEYOY
uYqTTkuT2uFaJSlb7TOq2L9jw60TujkNMwVK7D6fetJdM6N9y2udJ0IM6cK8MgOl
q667dPIhxhWosa9WLF0GZDQhOhzO0pISJ1fLZ1CHG96D5Ib4OF0fLBVESWAqCgrE
HQN4R5kqOWOMsbUosXJff48bu7+gfjliZIACPVtzyuO41bo0Ocda4KvUqxxf1KFh
z2YDrOfwAdIypJePmqjK4DwiT491UgQEKgPBGm/bNTtDCYweCKKHFrdSZ1Boo1N9
O2mzhnPbTIDiXbkA9D0U+x+MZaY526OnFWZC4cJH9xj37vbTq9tnnZBG9zX7kvOE
dZvtec0hCwBx4Boh9jx4BkmK4BU5jZdYGh/J+IhFyiY=
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dvkdaN3Q3YElYiSymiWqsjTKlct/lelV5rTX8aLLAt7lPAH/ncLjFWFzQaXzp8zI
z8ZkAk34VwzPYCVsczrggCdj7kWrPMS5JGgiebnfVRiexrjQa+CWGthfaJUDKx40
jLvOGcCFK0S4hh4UYndbVy9rLiVge/9wiPhi0A2DdN4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12632     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_MEM_DATA_PARTITION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
E+ZD+tzBbQrR0Xqd96ijBG2zTkq3mYlZmQ1cqB0FaZmI2TimYrvq3VPWj26KOewq
SkVUs21cBI4JegYax86gRY+tjWkDlVkRU4UZN2C/wCkxE8R2+6f2px2AN+biovif
jKqdx4uz1c0KU/TP/CPJ4wE0u/tMmgEgP2k1exxrXBU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12715     )
iXzWyyMgQ3GVorkPe/Uk4FTYCv0piULpiertDv9YCJxILUUhNlpj+B+B4gUthFwW
AqKiyYrZPQzX0PA1YvsbzLVv8LwDG7QeLXrRsbS19bU9g91TJMIoVTdWYt2T+4As
`pragma protect end_protected
