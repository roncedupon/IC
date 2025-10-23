
`ifndef GUARD_SVT_SPI_STATUS_REGISTER_SV
`define GUARD_SVT_SPI_STATUS_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is the SPI VIP SPISR (SPI Status Register) class.
 */
class svt_spi_status_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Mode fault flag, this bit is set if SS pin becomes low, when SPI is master and MODFEN is set. */
  bit modf = 0;

  /** This bit indicates that transmit data register is empty. */
  bit sptef = 0;

  /** This bit is set after received data byte is transferred into data register. */
  bit spif = 0;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

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
  `svt_vmm_data_new(svt_spi_status_register)
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
  extern function new(string name = "svt_spi_status_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_status_register)
  `svt_data_member_end(svt_spi_status_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_status_register.
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
  `vmm_typename(svt_spi_status_register)
  `vmm_class_factory(svt_spi_status_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SJ3t8zy12nvqv6gtDP+M1ti0Rs6hnEqpNw8OBgq9+dqx8wAHnav5m/b6d3MwOV2h
setcxO7FXF6HiWUIXY3UF/XFzSdztkbM2sAORV54o3zpakF4/vB+vJzji7sTo1B/
8UIRKA1svDF64bxyzB8GTPG0np0atL3ZFyXc9GHOGcSGZPJFbvF/Qg==
//pragma protect end_key_block
//pragma protect digest_block
5WxhkdeUXKU6ZeNW+1/dEv99Ykk=
//pragma protect end_digest_block
//pragma protect data_block
IZ0Hb6W6LUrmalzG8bosHDanTDN1GfPb09QdfsS3oF1iwOwXLGYpGF3SqEWsP4O8
ivx4drNfyS0Ssak22WNc1uuT6irjVAOsIEoAB0fcgluj+ZSEeYei43LFfZ66+WAK
/fkBvcTDmlKrHpKJtUof1Va05yRm/nQ1Q2T/O70wfQyAArqnDdKpJr+sVnHUsoLx
bVC6GDIxe+zn8GNyy6MP0nMzWYi0Ko36NxORp69yg5Tg7RCcrbnt6lOOOYumw11p
2/Te/9Ph17lg0sGfb3klpIP7fpNNiRj1EYWsWtbHD9vtxdp9jt0czZT/68ggiFHm
mZgDFP0xxD+SKbUUaGHropd4Z4oaFAhg2h/4E7o/2cTkT+Hs4rzWKErZQhWZhRxP
lZxc5x/bD5FX8bwSr4CXHiwsY/G7oN+Yk09tBtEEqeacs1tS1Zqerr5nukdsBUfB
N9eXXD5eic9wfd53m+ZKAxOGf6YVDgGT90bOsdCH/UHgwpDgo2bDLTFUPZYv/MI4
NopwMeGvDy8DqecLvK5Pu+V1Q5iLWHDo87zWPYqm/IFelzDn8ffNiN5Lrh5Do/Y9
p4ATXMYNwuBTly/hVxG//9EKlF8kzPFjBPTTkqv72flIIb4xTGhtTaDn+FbJT70b
UMii/BVkcK+teZkKt1Sn7iKi5OFACoBRbXJ8Jl3R2dPa4Jen8Rukbxm3Uicl1izt
uRximIK20/y6GiO6q4UeZCzn+b69sLYiQY4ao79YZMOTR9OmclCH16SsAFf1rt8c
zCfMr5jkQwm4MEkMiVB/FkBgZQl+SMUM0jHx3P/7Zh2Hvi3BbFnHqibX5lARV90d
9A+hgSZ8PSaV7NmFEF/4q0vxaaTEMzeyp1a+BQgRryv2HEdXDDp5NT3Fhw9mS+y8
t9uHlKSsX+NRoPkzdUhmtUJtw0UT3ew7aGXFXjV7u2FPrYdl+K+lJDNddxZrG/hK
xYXgpoZt7uLwd1bt+wRhMme0WzagP+bVUeAt/C32Sns=
//pragma protect end_data_block
//pragma protect digest_block
eBxwuPQxzuCkyzfHJdI6bPID394=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FR25WWeJtONpyGRN4RP6qpXQSlvUt6jTGS53Qr3ZQG8Z/M7jW2JoQehqaiUSGGxh
bQZiCV8dxZTlB6QY0r/mtjNZ6+/ii2jpzxMv6NFiWssaI0D5YL1M1aa+L85QC75C
k7P1ZQXUF9hSOaYIUdOheGKiM/6e4SER3FdwNttycgdYC4zFVrQEdg==
//pragma protect end_key_block
//pragma protect digest_block
saaVqbkaavzQLNjQz3OdFGoJCIs=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
WWZmxbtqdWL0bLijefCw1gU71Ws=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_STATUS_REGISTER_SV

