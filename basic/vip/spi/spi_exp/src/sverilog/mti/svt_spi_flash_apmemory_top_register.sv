
`ifndef GUARD_SVT_SPI_FLASH_APMEMORY_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_APMEMORY_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP apmemory top register class.
 */
class svt_spi_flash_apmemory_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Mode Register 0. */

  /**
   * This parameter defines the min read latency and maximum push out for     <br/>
   * read commands. It also defines the max input sclk frequency.             <br/>
   *                                                                          <br/>
   * latency code         min_latency   max_push_out      sclk_frequency(MHz) <br/>
   *   000                    3              6                66              <br/>
   *   001                    4              8                104             <br/>
   *   010                    5              10               133             <br/>
   *   011                    6              12               166             <br/>
   *   100                    7              14               200             <br/>
   *  others               reserved           -                 -
   */
  bit[2:0] read_latency_code = 3'b010;

  /**  
   * This parameter defines the latency type:
   * 0 : variable(default)     <br/>
   * 1 : Fixed                 <br/>
   */
  bit  latency_type = 1'b0;

  /**  
   * It defines the output driving strength: <br/>
   *  Codes        Drive_strength           <br/>
   *   00              Full                 <br/>
   *   01              Half                 <br/>
   *   10              1/4                  <br/>
   *   11              1/8                  <br/>
   */
  bit[1:0] drive_strength = 2'b01;

  /** Mode Register 1. */

  /** 
   * This parameter enables the support of ultra low power mode:<br/>
   * 0 : Non-ULP (no half sleep)      <br/>
   * 1 : ULP (Half sleep supported)   <br/>
   */
  bit ultra_low_power = 1'b1;
  
  /** This parameter stores the vendor id.*/
  bit[4:0] vendor_id = 5'b01101;
  
  /** Mode Register 2. */

  /** This bit defines the good die bit. <br/>
   * 0 : FAIL <br/> 
   * 1 : PASS
   */ 
  bit [2:0] good_die_bit = 1'b1;

  /**
   * This parameter defines the device density mapping : 
   * 001    : 32Mb  <br/>
   * 011    : 64Mb  <br/>
   * 101    : 128Mb <br/>
   * 111    : 256Mb <br/>
   * others : reserved
   */
  bit[2:0] device_density = 3'b011;

  /** 
   * This parameter define the Device ID. <br/>
   * 00     : Generation 1 <br/>
   * 01     : Generation 1 <br/>
   * 10     : Generation 1 <br/>
   * others : reserved
   */ 
  bit[1:0] device_id = 2'b10;

  /** Mode Register 3. */

  /** This parametre defines Row Boundary Crossing Enable */
  bit enable_rbx_feature = 1'b0;

  /**
   * This parameter defines the operating voltage range:<br/>
   * 0 : 1.8V (default) <br/>
   * 1 : 3V             <br/>
   */
  bit operating_voltage_range = 1'b0;

  /**  
   * This parameter defines the refresh rate: <br/>
   * 0 : Slow refresh <br/> 
   * 1 : Fast refresh <br/>
   */
  bit [1:0] self_refresh_flag = 1'b0;

  /** Mode Register 4. */

  /** 
   * write latency code defines the min write latency for   <br/>
   * write commands. It also defines the max sclk frequency:<br/>
   * 
   *   code     Write_latency    sclk_frequency<br/>  
   *   000         3                 66        <br/>    
   *   100         4                104        <br/>
   *   010         5                133        <br/>
   *   110         6                166        <br/>
   *   001         7                200        <br/>
   */
  bit[2:0] write_latency_code = 3'b010;

  /**  
   * This parameter defines the refresh frequency 
   */
  bit [1:0] refresh_frequency = 1'b0;

  /**  
   * the PASR bits restricts refresh operation to a portion 
   * of the total memory array.
   */
  bit[2:0] partial_array_self_refresh = 3'b000;


  /** Mode Register 6. */

  /** This parameter is used for enabling half sleep mode*/
  bit[3:0] half_sleep = 4'b0000;

  /** Mode Register 8. */

  /** 
   * This parameter setting applies to Linear Burst read only on RBX enabled devices (MR3[7]=1). <br/>
   * Default write and read burst behavior is limited within the 1K column address space. <br/>
   * Setting this bit high allows Linear Burst reads to cross over into the next Row. <br/>
   * 0 : Reads stay within the 1K column address space <br/>
   * 1 : Reads cross row at 1K boundaries
   */ 
  bit enable_row_boundary_crossing = 1'b0;

  /** This parameter defines the burst type  */
  bit burst_type = 1'b0;

  /** 
   * This parameter defines the burst length:
   * 
   *  00 : 16 Byte <br/> 
   *  01 : 32 Byte <br/> 
   *  10 : 64 Byte <br/> 
   *  11 : 1K Byte <br/> 
   */
  bit[1:0]  burst_length = 2'b0;

  /** 
   * This parameter defines the burst length:
   * 
   *  00 : 16 Byte <br/> 
   *  01 : 32 Byte <br/> 
   *  10 : 64 Byte <br/> 
   *  11 : 512 Byte <br/> 
   */
  bit[1:0]  wrap = 2'b0;

  /**
   * This parameter defines the Data Lane Count 
   * 0 : x8 mode, data is driven on 8 lanes
   * 1 : x16 mode, data is driven on 16 lanes
   */
  bit enable_x16_mode = 1'b0;

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
  `svt_vmm_data_new(svt_spi_flash_apmemory_top_register)
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
  extern function new(string name = "svt_spi_flash_apmemory_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_apmemory_top_register)
  `svt_data_member_end(svt_spi_flash_apmemory_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_apmemory_top_register.
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
  `vmm_typename(svt_spi_flash_apmemory_top_register)
  `vmm_class_factory(svt_spi_flash_apmemory_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_0();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_1();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_2();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_3();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_4();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_8();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_0( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  //extern virtual function void set_apmemory_mode_register_3( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_4( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_6( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_8( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KF4ZpGDfz/ufohqf5rNINdRhfzVlO6HN3DugYq5tPOdPJ70S1r/3rPYBFlLmXv09
jwOfjDqewTqnYXTXDGuQYpGVpJAIj4O8F0OGtx8i7Lehn9UrOAi+pAnGAeF+1QeS
CXurFxiJdHqyneOlnDLG8+xOpj3p2K8ClQBNooExdCE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 634       )
s2mppO3WENHtX3aQz89PmVsl7RYeDjpYlmk7pr8nY6bIlQ1Z/9Buy/NG6E4ryvK0
Dy7P/yxFa0NTYnaWk+3m/iEu4dUa6DGnvsQUwFJHGE8NxxL5waMOMCvT2CS98lTB
EHbbSHDt8g52xOVgcNL0uoVGswF30SrfCiDDQv3TWcty6TfDIBmfcUmEXgUPU+l9
mR/KvObej33n46b1Nef07eh/9oUFsfoAyc7GqG12E3tDlUr3Nraj6VyqYn8DIJ03
Fv1YRgT3dUCiPW3aVrg+joIl75tsQacxqkUlhD1Bp6ALWIbZKXcG0xJbmyZ+hodC
9vtTkZftJf6XvXRhB8KIyGYrhsGDWitxtDjJLGsQ1lw11IiZ6RkE6h1V/LYGFG4c
WhyXCKJ30dKr676mnMaegAD5Db7vjap3uJ/MFSSi4+X2rDYPLZZHbhhBqM7SKlCT
Lu2x8DagAcXc+DbIK0bsm90LCJiYT8vzpeyku+AUT9xJt2ys5nFEMat4eyzz9gVF
6slH2SHptR69r+vdQKUYFhrpaYU83ftl9zhAx+3kLw9JMNZUq9/arwCx6QThMekC
isILtUE0r95klhY4kYcRB0MleWSMfXljLNKsiAs5ynPk3TnJ9KG+JtZ2AuT/MNsy
XsXnHp2ZhV0U2l5NSmPnav+Y1D7L4TI7S6Pc0CikivP3PXbmTw6qQ+VybyyJZbLE
wrYa1tmNsN6KyNym+DLMdPmWp0aP/ynQUKbzq82s+9YrHPP8o5zxIL5WIJNR5lb+
TXeQiEy5x9dX6B0o7RhABXA+IXhp1svX2TPu6OGp0x0e9P9IdCXtvPNuFBb5K/nh
DnscIwaSEFb6zScC6G1j8g==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UMbgwfQKrQ3fYLG65w3/KbuHEQX/B6AJoMiAbqqYKqAPlOrRfmZtoR1bMukwR6hJ
tWzlShqJhDiKZGpsUqm+YGrZUGX9HeXtmBvwm1wss6R+8qdDjNtKQziuLpCblhd0
m9icfO2EJQ0rwQn72VTXGzNUYCczSiAhcuPeIPVDCU8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20185     )
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
gff6PJONebCqe708g0YAkA==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_APMEMORY_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TU5QzgTQYiVIL4lAGa5GisS20MbuTou6CkkFRDSb6Z7+34Dfk12A3XOg0sUZG2LH
oL8WIauN05kT+f1ZYsiwal8i7Dejf1cCJKIxOwjw5YoDE/VFKKevF8PuI+s/WfR+
wiyxzTptpif2U698W8SgdFD2lA+UZ5X/jce717jtgDw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20268     )
Q1ugHxihbHFfX6adOcCX7eJfp4OibxfZtq3s2uUyrtY6hInbJ9MC1zQLrxVNJ0Bq
yoQXEHXc497gHy9cXdbow2ZtspRbGpiZylLa41JIDdJse1AdnUpX+PVN6oWgoliL
`pragma protect end_protected
