
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
c++0vpyKxN4ZzJEAJC5/H0MgPHw6rnD8sGJ0ycIuaumpTFsUElhWciSd++eY8psI
1s93Exig2qpO5Zw5uezy5jQ/O6UxvSrVsZPOg77zEB5h2qcTi83Cd5G+L7TVEjce
y+qn1GAU8pArwnQxJol65NIJBCQQa/GPGqEQA6yCBN0VTFNqbUGznw==
//pragma protect end_key_block
//pragma protect digest_block
gOa8GX2bMMbhtWfvCkgvqQz38oA=
//pragma protect end_digest_block
//pragma protect data_block
dHws+8qFqN91X9amraS5XqwKhuVBG/weZEbmj4gaorLpDmsNmGu6FdDT18tvDsNg
+bo97DeE1C8DEaQ/sODuL6JRtJC0EOQjjAZvuNQntGeJKBIQwkXFwxHXIL1V27aT
CxF3+juRcEiw+0yZKIK1FDElQA5tZ2//MVSQArU67/5v5OV511TVIIy4BA7oX/1+
zwOlANF5To3uYwgCtk+VcxsemQy/b8EMEDW8uvU2qdS0fr6fMMJ9GC726tS1SLEX
cNfeHta09AetWdahctOk3CGhJ4oTU8Q9E//vL6bFMCfxyvuSZDYrgr3ry2QkllWk
7WOK/Xncm8UTLYva5D/zK8g1d+rDSTWaNU79tU3hnW6e4ghUtL2auxQM13BFgGKk
CN8fUoyEwGk30dm8q69ommXC2iPhIc9EMw2R4VnpS1cPX3xLQSVWbWLs3evqCBxe
lSvS4ZdWwQAd4bARgSd9XzWkGA4VS0A36ibUJCsVOyQuIrG2GuPMbL2QvE8t16GL
hVTTr7Kzn0R9A3814YFHh+NJCiVwz/59j1/VX7sSiqvB+AyHNbmDlkJEKIPQWYnj
DCHDoqAR5JSX5w9BXFv2rXtiwMtwQhMi+dGyAjIJ1ZOmJRzqc6KqRmHg0BI3UCcv
MKhQdDA6yJuDTxxNi9kwx/wVylFKzgsK2Rbc8IQ6dLEsQwHqnYuZH2khdE7IuPpb
0ADzDGO+Vz+Yze8AO60K/MRReodbeGlQ2fDRNL2NfrnC0JuOnLA6Thyjuxe5608D
Kf+ufe72QqxImLH9gnduOfgkamdR7AhsM6/wLeUbDlx34BsA2e7FijSO6Q0/PRp/
/wZyBCcJ+HpPlPjIB6mofkDmRUy35NzQCKEpaw1QFwMASrBUH+9P/ww2pLnOaEup
XOSqrZRljxHfPCpL2fJqy5O6MB8NAl91rJLBTmNNh7D9+CigQ+J031Hia8m+wgLl
y9g7pzQYicWThk+ktiBfC5Xi5stv4X1Njy0zc94OmjlUXwzrx2PDPo4oP3Hz5Alt
Cz43aoCoNQfDx3VxOk/GelYoTQbax2zAST+w0QT+BKc=
//pragma protect end_data_block
//pragma protect digest_block
gJ3iLsFVtAmJUjeWKnJvKNJthk0=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nWCdcqCk29hwvpZmCRH0zs+2O6203S13z3nL5YPkNazK3+GsO9IdvLOGMzM0t/jy
z/dsDk+MuVrVj5+Zqus2MdYpg7glFpK/GsPdHAgRJ0rmTFFbIlYh/lB85fAsqtt4
1Detd0RUoLaEsmdVPY342dUyHQYntCO4QcP7VCxzpUai9BIq6Eo9RQ==
//pragma protect end_key_block
//pragma protect digest_block
7U41sKrl74QkQjMH5Ne9vKMBc78=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
k4hf9rHw7f3SVvHKpervC9yoTGU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_APMEMORY_TOP_REGISTER_SV

