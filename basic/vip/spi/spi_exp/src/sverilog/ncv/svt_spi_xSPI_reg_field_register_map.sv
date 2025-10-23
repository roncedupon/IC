
`ifndef GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV 
`define GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV
// =============================================================================
/**
 *  This class specifies xSPI register that holds mentioned register field.  <br/>
 *  A register field can be distributed in multiple registers. The valid
 *  locations for register field at register is specified through 'register_field_index' member <br/>
 */
class svt_spi_xSPI_reg_field_register_map extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** This filed specifies the name of the register which contains reg_field. */
  string register_name = "";

  /** Specifies list of 'Received Data' Index that are valid. */
  int valid_cmd_data_index[];  

  /** Specifies list of register field Index that gets updated with respective location of 'Received Data' specified by #valid_cmd_data_index. */
  int register_field_index[]; 

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
  `svt_vmm_data_new(svt_spi_xSPI_reg_field_register_map)
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
  extern function new(string name = "svt_spi_xSPI_reg_field_register_map");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_reg_field_register_map)
  `svt_data_member_end(svt_spi_xSPI_reg_field_register_map)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_reg_field_register_map.
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

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_xSPI_reg_field_register_map)
  `vmm_class_factory(svt_spi_xSPI_reg_field_register_map)
`endif

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jhdLKuciHBkep+CJBFIGc+c9E/OfiUlzCUZT2umTKy6l5rqG/9nXoUTCD97u2/2C
L8xvzEfu56cMB2mJwd8KMH1FVEjeG7XtJBkQoUiBxobm1Prp/6eGPJgnMIEr+5d5
XdaPQ4cfsdKYLqwTTK7u2YYZnX/RwganWka22PxxkWl+bNQ9ZI/AiA==
//pragma protect end_key_block
//pragma protect digest_block
sFXES8ZjLIdrLUGKPF95ZR+5MKE=
//pragma protect end_digest_block
//pragma protect data_block
UhebT5VO1HCNHTrYWTrgkqG4FpnyyXzIPrEPDMoPv5ZX/SNHCTjp9KdFV6qa7A6Q
XIakmJ4MAvro45/6NyPt2RNJNB9YUllrRPx5zgkg4vm8h/+D5DJ8IG7ETTA4nwY2
YpWVjM+ta45pbG170gl8jxRbygedTAwmi64sDMH8WX4UvjgIOD9TaO7uQtETWRHN
zWoRZXwlKuDBFDaVAxfdmveANfVqII7tpzAOglKJtzXHl1tuDu6Ifg5Cbr9TR5lW
87FVf4BJZ7o6QvdhEUJZaGs3pO+vC1R7tn16BWrhE7fVa7i8wxP5omYTjCdxKDqf
9ZF6on4UBI4nVHNy6m92ahfxF2/cZSkuR2tylu7dPO878/Pl5W/I99Cqxwa9Nfbp
wC5JqpsglH1PfQIHAgvxuqFJHzTswLkml0kdJrbONRDogj6nlxdkv9UK8BHCvssq
mUtFup4VYkORPrcbR1xfTnMPFX2oAId2YCi6gs87Tdb4S/XdkI9W25E7p7Z0vjgs
BrD+qv5xEs9xQA0GBlsr0sFu7E3pgHKwX5YE2YxQyy7IrWiHSh2Se6IhI78Em3XO
Mz80JsxNpnTemYLn2xQMULTDMfRvIVlUpRcpUYENnD7rnXk6/vvhCdzA/C5Ec13s
1XnmVWUIqGvVwyHbgvxnGEN9Kr8/VXNfK6giGNUxwbJb7LHC+qhuoHwp8w3IzuPe
gXfvvOBa8/Hzt8fADchHAhdkvSkti3uBOpNNU1UvBRFUUUvZFkYBzQ38vOulJe7Q
DB6wbumpnTGAFHeGh8RMp63vOvcmzMOxqdFxq6rmPu0yseW1GAnNKDm4AYCIKpOu
N7LMRgPGZrx9TBewDWA0Q5ceK6jIiQ6aLP1sJSJpu5LHtArp48cWqFW3GtNpmz3s
liLt/ZxP51NMfU3lOyh3ThVEF+mDPcEt7G7NXFTpTBnq9N9U8L5LS8oZSlWbtODM
ePARjSpPLBvD2kQkBrcwmyh7UaDn1k7GUY2VkUfUEYigxLR8aUhOzVOACNDtkj1M
pkgHdhd2FsaCjVhePr6Ndjv3x78UMVxuoQTNVsgZrvU=
//pragma protect end_data_block
//pragma protect digest_block
swHIaEjtJ/wOGCfBpRlbDmvkQGs=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lBdhgaAeRzAZ5a4SWRIh1UfIcNy+COnuU6squ4BCmOeHnysGzL2gtMfyD9QW5IND
FJhGw7hyrFC3JnvtEqk1tHcmyo7CGCk/A7hH+GQ4P7QD6H9SW03lKt+apUTIs91O
28gNmSHxCeo6E6TqIUpflSpQSyT0SbOFYvUZmLHnHm3904ruIhelyQ==
//pragma protect end_key_block
//pragma protect digest_block
APD33MobSTEyNjgOODgqXwDnvw8=
//pragma protect end_digest_block
//pragma protect data_block
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
CvrfzhDWw5b9iBjdi5CMyg==
//pragma protect end_data_block
//pragma protect digest_block
750c2xgakylesol1RzmEq20TmmM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV

