
`ifndef GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV
`define GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI JEDEC top register class.
 */
class svt_spi_xSPI_jedec_top_register extends svt_status;

  /** xSPI Flash JEDEC NonVolatile Configuration Register Class Handle. */
  svt_spi_xSPI_jedec_nonvolatile_configuration_register nonvolatile_cfg_register;
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ju1Ref8nicdgWSsGrft9WZgCUljXBaA0Ur0PEydDSB4XqC73Pn1Hw7ieRKE9fS80
aZ1SKxdklAJ+OvjubX3GMpKh0IIi/wlkkMu0WyuYepOGEWc/JTCKdoDXfSa8wEn1
YN1cYmKvs3oyb4wEtETyEPigwiiU3od16C+eGBSPkKUAm/LXmmxOtg==
//pragma protect end_key_block
//pragma protect digest_block
m7AeoAOkx1OabG+P8CLXGzNOdh0=
//pragma protect end_digest_block
//pragma protect data_block
HJpMW5xkyjepxuBKzI+WiBvx2W2OaRsHcBshQlIm3AK5Mi3yvMhnJgGER+50bTz1
HGLs1yBU9qrRbHVFI2bI5RxnaHcNIUJCTWnHUNksUJZ5psRrFf/MDL21NKaM94eE
pNHTEDm5ACUP74t7Mf7ipdwi0rZPZB7TvtszaHP+4l7pkLgfbe8WPLpzOBWnQkxG
tRNl6eK2anZckQYpSqgD6cr22RX6V5tMcbTQPgehkJOsvNCjWIDLKHOMRj/UpEYn
p9NV8WrtHizuGkftrOxwSWB+LZnRsEzSEifQdJuDhOZJhizUwmQ4U6GznH9PHCjY
rHsviuGbvqfvAdC3CcziUu4C5H6uRxfoQXWnhJ59YrCD45otaVHjxi4g/BBVH+ra
IZ6XW1/LOCuURo2a42+cuQssnphFz7DzyYpF1nTtPXwjG5Q7a0xtaoU73Deo3rsx
WwTtYZQSQ/XGN8pTc77M6IEHsHCIq+4IOShqi7LL+/RxfKfj8rWWnEdmGf0bp/gW
o44KCcsZMbe/oaHDZO9amfMdbvPmMdcQ4aD9964AJkAZPgy4zcF8wvLInbmBu6lN
Y04Etset4+ITdxGV6KigJSHy0vyu4V0fzvtwJxmJx61L+9PPsHFsBt0z9UdGUV/P
ei6f+1el82fK9qY1//eALFoFLRVnWYRB/7soJbkg6C4=
//pragma protect end_data_block
//pragma protect digest_block
Ub9PLd69ouUcrwC8YE9v1CUK1NE=
//pragma protect end_digest_block
//pragma protect end_protected

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
  `svt_vmm_data_new(svt_spi_xSPI_jedec_top_register)
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
  extern function new(string name = "svt_spi_xSPI_jedec_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_jedec_top_register)
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HbHhbAeMD2tScxXIVAUnug4YVmnSIidm1vmD/2unRabnNNfsJ6KtGKMpoJW+YbLi
6jjMpdQakatmJXFOoqk31y9Q+eHDQpPh4cVcOqR1lCVYG1Ea5f6PwHKBCNdQDj8s
el3Ocl2uZWcvaFPwf6zYBYcVq8SMqUOTIn8lSIpilUUjCVgXQMM6KA==
//pragma protect end_key_block
//pragma protect digest_block
tyH+pdSmX3Af35vpYzFLNWt2u94=
//pragma protect end_digest_block
//pragma protect data_block
iUjYKPXZs/QlrgB+Io0/xwQhVrzNaqeig3NXN3ELVlCX8ZE6Afvzf65QMiuF+gw5
wC6ikm5kEq2kFLbHm4fV36Ux5QM/DQWbrfJcEDCfYUF5jkhAhuR40voJ5ItWU/FS
kVl5hHTTfgd8m+C8mb8FNYTlsLc1DqA+KPpjir9mIbZ0ZHPgh+gXZ08kAvKpQAIT
kjFq5JM6A5DsmVqyg/Ci8SCjEHwhFW/aFNJIwNX657f0mr/dKOjcQ01kIvFlfma+
/PvNtJpPvkC9jJc4JsfzmDpXyesv5sAEcJS66UVawgLTDbF41I2P9XonO/KaNuQw
wOcVnZL14m+deAFBAuVeThPxhf1hiKFXaA7lwauuC747tt6gz9G+1BC/BPYF4RcP
hUGg6KIjn1dspOX9/bH4whb9paVPflSuD2SkSfcdcJ1dk3jXCbCAr2eMFd24rAGz
dENL6OxZ5zIYEhOJQDEkXZ7O+seIqZ+nhwlA+ewaa0o=
//pragma protect end_data_block
//pragma protect digest_block
tiWypueUAu1vfWp53/MquZO0Jmo=
//pragma protect end_digest_block
//pragma protect end_protected
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_xSPI_jedec_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_jedec_top_register.
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

  
  // --------------------------------------------------------------------------                                        
  /**
   */
  extern virtual function void create_xSPI_jedec_nonvolatile_cfg_register();

  // --------------------------------------------------------------------------                                        
  /**
   * This method is used to pack the register fileds into their corresponding
   * register using the bit location provided in register field class.
   *
   * @param reg_name specifies the name of the register.
   * @param reg_val_serial specifies the of register
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function void get_xSPI_generic_register(input string reg_name, output svt_spi_types::serial_queue reg_val_serial,input bit enable_profile_2_0_mode);

  //----------------------------------------------------------------------------
  /**
   * This method is used to update the register field with prop_name_field
   * value.
   *
   * @param prop_name_field specifies the name of the register field.
   * @param prop_value_field specifies value with which register field is
   * updated
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /**
   * This method returns the updated value of register field.
   *
   * @param prop_name_field specifies the name of the register field.
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function bit [63:0] get_reg_field(string prop_name_field);

  //----------------------------------------------------------------------------
  /**
   * This method initializes the register_pack objects with all the regsiter 
   * fields of the corresponding registers. It stores all the register fields 
   * along with register names in their respective register.
   */
  extern virtual function void create_register_pack();

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
  `vmm_typename(svt_spi_xSPI_jedec_top_register)
  `vmm_class_factory(svt_spi_xSPI_jedec_top_register)
`endif

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ipJ1AlNFayypDjzvPlFUfcbE5O5opx/aJsyYZqFABp4z4ePMFWOGsTVEQcq2z5iG
PkE4+PCC/DsL/wArQwxTkoD0X97HOHJvqikxueaE3CYg6YFmIRouRAqftxN/qEkY
J+Mk+P9h6/+kvmZjjaZLGETCO/hANqdil9PS0Z95mMbwvJf7N9wEVA==
//pragma protect end_key_block
//pragma protect digest_block
cpLtZDeO4y6o76Efpdfu4CFBWos=
//pragma protect end_digest_block
//pragma protect data_block
B5KWNjAJIdw+drkSAKftvwG3fWmNE4NJyHPWWoTt+XgM8KV5ITRmsKlLtA6QDXzQ
Z5y/Cs5HwS22WxSsPs+QzFQGa4eBBHx56L12iPTxIfCDz7Kaao/Fdw9jgWnTnwtN
RX71ivXob1qn57yPUd9g8l3hu69Ohj6su+wGcc/XYmxzFJgmxDySMm970Jf8c27/
UeG77hhZGy3xjbiwyByJcni43BLrGbNCZv4gw7GQYwJXP/Gqqs9mnheRalpMyyQW
gCKIu6Xms5kuU6VlFAgEIGFwXPWEnsiIuRp2YPCVbTpSzWsUqDLMPqLms/GTI7vt
J1wghqr4q9SzSsWxrmg6FiWmenR6iEN8zP+MpwGJKKJKdAR+zCUtvHv0HdHTuFYP
rWOm4mBIbfMxgxE8fDsjYX+aY1ffZ6eKa5Z+fbxjhv4XBEhccWhKwmATSOyagbw0
dSJgo9ChktbNAdF2WilwJaoSdYjhYanCKnZy1FtscxdGEaJlTaSkLJVY4AKVwU9k
5CMad5q+HoF64A22a8yfkcuOStlsO/9PWnlYJ2DEtoj2U28TYa87q9JXr3B+xIss
ImEhY/vEZYnebE5u/8QQdsYML1gK3HKGjaK92SNlTC3VyjCCT3CR/UXJfLpE4l+o
IN03XOhKsvtYZ8ejNyoGLcqq5wKgYYD0QCcFhYzJgaKPnnvUU/6G6SowDwp0ogB3
ROhUTnqOzQjQcki71hEMVlg2gxjTWW1G/egtfQbfJ9aVdDZN36s3eNb6J58HUky5
GeuXSJodX9GsYIRU0jBtYwYR4E8qfrFT5yxaNOJiL5QuY8Gfq2ZecaGANi2EI1R7
YGTwFlVu9u+x5to6XLfzOrEfi6PULsjkJJIJnuLcncHbpHGSe6DuRSRbFI2C8GPc
eEAg1ceVWuLJKxr51MVMEYQ0Fs7s71598adrJdBGIPp7W0vZT3qW0mPy2TbdmG1e
euDjf2IPhgkfjcZlHFxd/41n2QrO5VjN9eHVvnw2m+hh3WwZ+8kqbiSQcZx9ytPm
zkqUnxosCBjO4jV6BksexA==
//pragma protect end_data_block
//pragma protect digest_block
mPthqlHmyguB9gPY++FY5m7GvMo=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Nwc4n0Jz8VQkMOV6Vfi62i5uqjFwErtr4oLkvXCTetJEVS6r69d4MMsVT9yjDk54
pxJrF1n2WJ99AEnS5Q6B9z4yDVhtgYhlDwCzX7quupbmq77+ZZ0TdKbkiIIOjgWK
lfr3OpEEKYUlFQ/KOgn7woaw04ORCfxF3cZ1FnYXulq3nzIchMdG+g==
//pragma protect end_key_block
//pragma protect digest_block
NrUhMPMVgeAuYRkWCEsn+NRdhmw=
//pragma protect end_digest_block
//pragma protect data_block
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
0ip1WvuGn/oOPJ1YjZgFpEMKH3nvawH0XTO9nGtfp4SgkonFn7J5jSaX7gGiLVSD
UqIdyIi52+Qxk+JIJTIs+xTf7hGbO8urR56ESCwhYebqQcsyrEHFYwXlTDn1PNlz
aHXEafEtK0gxwTC18WOOnY3NQUvr9m4XQW4UHyvheQLFrLR00XQ3iv6lCcbOpTXk
sqQy1QeNMaB4lRJELeWTYwoHKCIdbUoiqi+yBSvwITkZS/dvcz5XgQBe2WNf/NW8
RrqkLq1cusGkYd2IvP37AfO5Nu6UaEFajkoRZTMJuYnI18IpxYWbA46wxpizD9QI
g+It57kb0RbHNV0I4ZkVXmD2VmLvrvAAHwsBN+RKDpV6SjnrPhDuMOTxkleOTipf
RA8ZTCsCYuCEP3ZJ04YTV3OubEh2NaoQIierORPMix2HFyodSMxaEfJzjNCbmfqK
y4F7LUqfKFDRDVDc4ZYM6lN7Z2GrNEz7mbGjNdZ0gGTDgdgCMSn1BOXfoP0eMuhk
wEc7hPO5mo0SSmfQ0mIj0qb8x+wPWqxEVgf6K8vXjqawj90J3+K72l8CsJQUaOF+
q8NqKXVcK/Qduupf3eq97I9v2/AnOHa+KwyqKV14l/Z5rSO1nxhKGL1pYDAWYT6r
3GgANK/aVYX3u60M/qYx5xUKurrFAp2MN0nePQV5r1GMnGWYSqRFihEwjSTghJrO
bv4yxm/nTP2bszpedpWNr91+r0Vkk+pH2u+CzfvNfKLVGHOoMGx1U32p9NFXOc8E
g5XbjKDcLz8TDCETI8q3TsMyHLYIXEBUTqhRCqfxKEPrX3xz76H00PRgOF0s7wIJ
Mthp/bD4gXhjddh5WO+zfitWsh595iGZyRRANyNxrRlGzhHbf/fdh4HHrpRoGquq
ewCTti96QbZCQM1kj1oYn4sD98oBsx7vmxllof7AJ7UNPVaohuZE4/omAmqTubVr
YuwktopGdGBAm2z2e4Nu+MOvz0vKOIjyH1ZxNxU9yCwtMIizd0wF/Au6H31EvC9b
gFB40696cljsRHpdJ5bCUXNOsSzNSsMzIcU27Ku+XXBdv73UW7+zj3JToPrtReag
7K5Wc7HchvXyV/JwwkPKGP1d/2xkHhIgzIvRmB0CSXFMviXmSTHcWcO5NS8kqNaH
l9BRUxoCCt+wSsiKavANTr0WNhlNBNDJIMRutAZNlHl6IfmKWsojQk2mxk7WAu7m
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

//pragma protect end_data_block
//pragma protect digest_block
DD8entjcfZCZ1C5Qu3Gkbgiy0Os=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV

