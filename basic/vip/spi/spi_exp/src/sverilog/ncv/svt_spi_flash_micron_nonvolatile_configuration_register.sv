
`ifndef GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP 'top level' status class.
 */
class svt_spi_flash_micron_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  bit [7:0] dummy_cycles = 8'h0;

  bit [7:0] xip_mode = 8'hFF;

  bit [7:0] output_driver_strength = 8'hFF;

  bit enable_dtr_protocol_n = 1'b1;

  bit reset_hold_enable = 1'b1;

  bit quad_protocol = 1'b1;

  bit dual_protocol = 1'b1;

  bit address_segment = 1'b1;

  bit address_bytes = 1'b1;

  bit [7:0] wrap_mode_reg = 8'hFF;

  bit[7:0] io_mode = 8'hFF;
  
  bit [15:0] register_value; 

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
  `svt_vmm_data_new(svt_spi_flash_micron_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_micron_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_micron_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_micron_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_micron_nonvolatile_configuration_register.
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

  extern virtual function bit [15:0] get_register_value(int addr=0);
  extern virtual function void set_register_value( bit [15:0] reg_val=16'h0, int addr=0 );
  extern virtual function void set_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_micron_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_micron_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
QJuNrZ/bAgnQvHfYQvoqx3EobhBNfbweft6tg08egdgnjIu+Zmb2iCUBg+DJem9W
NZiu71gQnETPkBk1ATYbJ8KQ7sPPLJ7OkGRwSU3/HgAua2p7f2Ti1xY4zaI5sLhd
GGqaNVrxlQumEvQXd+f25NtN3zuMYTji6PKZXwTAaABvvNJ8VBpSbg==
//pragma protect end_key_block
//pragma protect digest_block
HlmXysFwi4HbHea1L4JDm/Q5+58=
//pragma protect end_digest_block
//pragma protect data_block
iG3oKU+1JALTYKaXSoAbC9cl056ikySczTuuaX1xtGjJ1Ngo57lL2zmxhDsRMrGd
ZT3bTQH1glHKLjzeLbKPHSluyG6o+S627wCkVxaBXQui6B/TJTBEh6MDt1RwPW7T
f5PykXgC9IWIp7pMj3gsW2UUG8mxjKLJbmJGuss01Gx0WQWRL0WDvj2MX+inKlKs
+NP5N9KvRHvq2r+TE99DJa+Dx+GKjRX7trey/oG+iN4t4tqrMSM0w8kyhLjaEBeg
39b14mJ//njMnwp/XwRlcm3X8VjxhNQ6COJEv9mM4GARDrTCf5mfwebuCMzONfIw
6UDAMQaBIDuG8uO6NYL7qgnzWwT9hzfwsNbRQ4qxlmHfHUt2lNU56kwXUjk/HeHl
FqA2Ncmxm7JSIlHD3+XzyujTcXapE5xaZ5W7stDrqrm4NDwbqcUki0X1Ah69RwXQ
3HZ7fH4EywWWjmAde2ZEwZXaM6dYpX32eD6Q1whKBaaZ28S1bPoieCYe39DjyUIo
hG625yTKMl/yOHJDe4JbgYGKmVZ1K0VR+A0fvKRZ1fTY1AvNvg+KNkud15uEMsPs
hzAgi1VrrwMrRQeFyFJ2poZTow+jE0zxKITqeLyf5tPlQinTX/64iFXxlMPvd7jf
bfPBqQMgHoFf1r6H5CkMTg1v82aFrKvcKNldaxGlDpJlHVqk3PerIS+hNskg5zFq
vFFn3zXGjBmTBy+KoZi4laGnoXIDj50bK/BcAWdYiYt9YOMFio94P6E3T4n1fYe3
TdOhQ3DkjBtRDSvZAXfob9KxMk7qjyoD09uYG6emjhCGTCfW5kS1Oyn8/Qk3C8tU
e+cHMHfRfhGH8oRCs3X+KsL5//kqTdwelSWjCEIQMEH4eaHWNgI+rYmPfoNWkqFc
yF3lj7JbMNUCRORLWgbfIliXsywrVlrtpbLrCHHizgGP5VwAKUBvIWTYHgP1LTUg
DyNBV44RbN3CtOxdmp/LfurpGJIeqY3hX/sUaVFdrDGUy7L4BU+LBN7HNiyv/vHg
Jq8aeVaojuvD/jaaUteWENg+4SqcjLbiFQ1y1rydRfG7P6Zo5OpWMqNnuV+oLHqS
DxnwI9ksXsbRGAYa4p01dyktY0prqUKyKm6H2at1iZkNCTIPeV1IU3xIRFMgsvGv
IFcLh6iiNuiICXfloHcP/bMjJU5ho9DatDMoyRl4ZZB/6lKYj89Ufw+B3TD0hGrK
0q5WROVCffojEHo0YbaWLGZoQqLQu1HwkD9i4KknaA60UTGlnFeqwh6NzGNOjYhm
hIvF+8o6rtjlogqtYMBARUyKqMSAlxHpYI/rBijlC38uZ2gkoMG0Ts/27iiJ5uhq
yvttpKm74FeVqV4XYTkS28yPvrU6WTWYSGMhe2zCqQbClxkAvtd3Lm/mHeiqkJ2W
9qw4fisPfYIQ9f8CE+4xC2DT0ZbDEVChQMhfPbKRsFcsYZBmt3MRM5tgBG7zjsUv
YYpXARN7tdaYx/8No6GmdvyEHb21rwn2JFQObKEIittyur/eVWWIz6Ou+r3i3bie
6/9pl8HChf2Nxt85i9AnIwdn6UnA3wSiRxLMya9y3/YdrU00/VgXGhqtM+CMd4JV

//pragma protect end_data_block
//pragma protect digest_block
XNnw6Nx2mvdFofFaUU1vsLPDjMw=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qEa1nowRWNi5O2O/LxpmVv95/AIUKGOTknaYyjb9RguJlMqYrTv5pTntSg0BfuE/
laWJO6WyrfQsezjeF+xn7Ma116zjmc6k5t7h1TAOCEyXWSkuH6mbIYVMoONWUtM7
wOUeKnmz0OovQ3a4A79Uaz+xOFgyiR6MUWRP8ZK1fAnFMvP8Ep5tiw==
//pragma protect end_key_block
//pragma protect digest_block
qokSNOqdqRq+bcnDCuUSU322dH0=
//pragma protect end_digest_block
//pragma protect data_block
4Tza20vHxYaNxa7zlT4x3whv98E/6MVnjJ2YE+b+dwdJ0hWMiapc0ZzfaL11eM8H
p1ByssuZyyDWCL/I7ouMiAQK0+WBUxbDRKbtJz31a87d/HG1vGOt4T3IUPIyf814
UI0pnCfbgSjAZKylQJGCSx92K2Wb1DPLl0bg7cQD9Y8sts7tOV7L0FXldD8PoyLC
0LyONXpvTdlChQFuVF3Oc6CkQu7/HjFH/VnXHCce4Z2aV6ycZ43DPhYQf9L1tdr2
Vh7sq7rM0utim4hdpfpf1r4QUWJG8H0E0ysnl5pr0QyjvJM0QrkC639BMTAFgoii
NJBASH7KTh2T3Lb2L0ZEvIxtDRAcHrgj9tnUEGOpXFp9Qm6BHHXMr1zM+zhFeziD
aAiMkZvlMGtdZGtyRuk7LkwIm6bSaKCZebOYjhYzxwuSZ8odYfqq/8vnbUi8AFIO
v1exobn4TSaE8CfLNN3x38O31NEtDLqbULo42FSduHd3bTz9Wrb6d5bbCcoLZBIk
WBGvCH5+jF3PyLfrGDxhuHEPg3JtZePtlQ+Qfzz5ZrRvMKgiBPAbKUHhUPs9b45a
tsqlp4jBS6vRJxit8QrkVVSI+JjlkDOutWKWtQ/iAQJy6ijbf+rzd/fF9Vzu/FPb
doF4dAwJFP5Eq76wfih5fCIxaWoq90EU9HiZWHPtAIQfBYbEP3cwVaVCs+miy+0D
OuT1cOpPGh3FxF4kAJlLxtiyNAGFiv4RTba+TwLHzFZ3/5ZeW5IX9G2FdnxtPfqL
5zxoCRB85ksG+xLLgROPyzFVgj5XNAMWogvY3yNy/Wnxa8qLk1sXdjc812vWf9Sw
QIPFr8urtrGt60CzTgbX4GM/TZeBr55DCNEq6ej62R3SSZxQnQQp7p7+g/ydVY0l
SIHf3xPkXfyHFJevrsEcNF5W9YJ1KQThRYt3u3b7tajRgCwiSjhTFRLVoY73e7IY
dsqoWlZQVKEVeltx5dUnaguJKm/q9/J88qi8h2buKUWO1eBPMXUnzLIflNd0MgOp
csfII91tAcLxqvTHfQmxagWJwDC5kFrTcUErHehVSujrQBLZLbkAWLjNNwWpjFnX
DDVlxTeyLTkramufJ4c9HqcV6csAatjCS9/mfYn2hb4RKLSZ1cX9At3FVIB+9H4i
0ssMWoGApS3x0LmQ5a+Pi4m5ty8BAWr+V80YIkmPosQGWKYmk3fhAW92p+ZusTxs
KuxvzkJES/wVRpiVD/w/jIbqeQ+X8Cjd1dHjDV+JhF2CrbGFRE8PX1Xft4IUgyx/
dSONlDER5JsF6+qx+eVsNYhLwopojkz8nLMQ0ADBGARyuHQ50JwNbRLmLBBFmMPN
Ju4piHfWrS8jtDld3PFOkEqkPdFAw+pZHLYsbEtmiNBc2ZfaCzPn20KPL1sBRafi
v3jj1U5WQ0/oLb5WbvfJYRKaZ6HZXQEa+pO25OjyDdtrf9j3xNcFw/1cEGpQ3MF1
XyEbaieczXDSLGyoRkgxv92cc5hhUaTXm7gztRLujBiSv6334jvzT998/aJo0wSK
hFsyS24kLdQ/XoLZYeIrObyHHIy5nfdPB7JndStzwWOxpiQQt9A/p66z93au8Srj
F6hS+UAKm6yp9QolY8WQxu6GVS06M9Rqg/nsnTkSklIbmRGRmYObQ3hRRsNhMeyj
cFwkH9fAri8f8f9FNjbqw+cOD7ku6GCBtLdZ64c8OQ9S3/UOum9jG2YaJmzatkzA
iM87sXs5u6X+vRf4ZWLlxgEEFttzG1b8aBVI1fr0kzdiGQfJoXJLahxWHuUoLaiv
t3CkB/A51U42inUYdyUXuKc10e3bf3/2MlK2KPXct6RX+DMGUmDouatVjG2Rb2Ou
hm2cFMr2c/+MnllEZGuB6HnAL0/U9ymY5dn92lBAqJC0a9moII6quvmRQ9N54y+r
Bg95b1T6+sDLoI/RIVjejZ0vznULLGTQcFBEzIAtIWidVwO7FPOhuZZCD2B9+IXc
Hb06cXe54TPYZ8IfkYdlAyHUgml22u64dRqNgmZjTBQx+1NdAvKIuNJQyiGiLDGz
hfyNINfIapfrZOWdo/OK/qPdRzj30nRAsCYo2hGRJF/mvNarWGlN9rykqhiE0E4f
2D3yaKDplZ8cmcpJTXG9XfsPCT13yvMREVdXmC6Lqrq1eNnYVA4oeaqk2uQtCA1i
UfqOHW5NL2ZOzUjTRcd8RaXkxKDHVCGpMO94F13cvqk2SNKJdtCLHJ92H23172a4
IliewTJ5r9q7qhB5nZFi4YFJ7+mlWZzzaI/6fv1KSc6+hs4pRHJqujdpU11GkihK
5XyTZXzE1RO6HoEgq45BTV8u1u/F5X+sG01B0Y0hH+n7tNI/uo+FHDUXBU7T2FUl
VX9b0Px/Q+45FJxjtugDGuMkIp55oP0PI3eiifUFnARpzvH2niZx79qS7L+OyWdt
qc3PgtQIA1mnRaYxWi7DrpkfePDUQhVA3s7ebHDhd09IWbqShOigBG3oQ0IBh30O
SqQsFxCVj93RPnX2JJTv1TTIzxdmFU2/H/4i3iRUuMNGxQEQ2TpSfGqcPS7DX5kZ
ACaFu+9tnzPqVl+RXuoqMYkh5i79LUNGVOTcti688XacuDB+HNpdWEzEGaMCj7Z5
roZ/WUCqS3VBF93nIE9nCKrdjjPMwoOaI5/ygjHwfTAGT7zNkk60UAgxubpjBK0l
mgqAwsBu6aFvTkhM8IGmk1yNJJvWyHrwWMmNYM16wbyfTtLef+nRTdBFiBzILeJw
xHdHJileX7r9Ij0dWfDTqYDKQuR0donkU4We/ayHF285fZ8g3tBXAwh02CRAa6Uk
oy77axf8Q9BaeJu47H02lIFS7wem/+XgxOqpf1UTP5FnkBTyKe/HABdRnEDrovOG
pfyj0HK7SB7fQjuceXCcajf2Q6TZz1vmCMApaBijWSWvaDVUNQc2GT/81q/YGJp8
RNHZiVaZ5cgBwODpTU/J+oNiO//aODXaMnfd0jn2PlDYYl3TtXb2uytvIu8a9RrA
E37vcRJyK47eQ/qXReoCzBAfHPLuluiAHohYfS6yO4IMipkSjTKzAqy1AA+RjoUm
19HCB5aiw6fDVp3u2BlYZEXMtddKf3iInNBB6oWsNV9gJw+jWSH73E4W1mSW9UGU
wR/+jZ+Ezs9c2EtS91rsI6Ee+pLcHAlvpNh+Yec1TgaH0G4vGf8mOlOn1eRDGGln
7BPVzzACyr95FGThefNTMYc4bzs0flpAVkJKQIq8pP61yJTs6zGE7L73szlu7ByZ
zBc9h/fu9He+ggN/eExTD3kBPxhz6sPCJeHUJb21cZRuVoEsFG6F2aJcv8R9lkUh
NR9qYw21qFybnjAP8vugEqXOXSLSqDK5LxnjX+Qp9r6l3Yr96nYWvfdp4OgQdn3+
19UZ3kIHu60w7WpkCPGe+I/DRzVXKI7gwQE6eT/avgY2VN1KRjnRjDrkjUDYbbDQ
AIKhd31bTEVgVVouPonRJQoNZ+iuQ9jiCjaKNM7C4tN8V+3OMkTXVNypoKW19mW4
w4yXxsGa5s4KRy+/YqnAPj8ZL3eXYnLNjksrszwhbT74bksbTK2FH9jOfGsdXyL8
rlPuFnkWkqz6hLoQvUUNoKgCWU9zN4H817WM4k7j4GbxdQP5CvDcDxCwVO5ws4Rr
hIEoc1RfIn5QMR1Xcf9cit8+qQEiYW4rk8i38DXN2vBoZnnFIrVf4wMhBadwXk/6
kc/PN9rSj3SyeaP9Lrfr3VK+U1bl29ppSnGDqz3RWNaiKXuqIjQL6T8se+iFp1R7
7ZUoxUmTHuPQRv32tGHDukO3w11UV1U4EpT9OPO53KmzRujgrMzZqVALgV1xgteY
YUedSuY/gkfuhpfwRZZEmyqRqWKPo3j4sGj/GUpXrPvTA6y22h5u8e7ZXii5pVhB
vzKHnTK1vAbstpnEXGOTOoQf8h5Bjfp22sDkhp/son4/hx+bqyJpCYVBI12dNWti
wnMOwCylC9ioNSen8Jk6Q3Y4jITqT9+5xBjNF2cssugtU33AHHfHfgmRnuzRPfbP
YjNvmhbwMmv7hI1ZTDDQFuUkTuD1qIXC64HHbL949eCTQLDNMVdqlcthQ/gdDM0S
5ovh5p8rp8VNmgXLusXaxuQoPweQb2ZBG9UF9U6roqLvCCF47JgnxwfcRPWLEjxq
5V16P5R3Wz/2n7YhmULsKnh3sX5vh8mch/F4KPnuZ7oqZwMPnNiwKJn1q0mpwMvb
dhDK1Jl0MtbzGDhZbxbUWuuLgNJuwSeYrre9hRZHl0gZh/b65zwf5rWUh9SdTCcv
QhmuNaRAPNlwYG24L5noRlL6DnvMjCdHUN5O3VtIGuf27ejX9A47kRhlUqlnsz//
eARcxDEi511G6OOBeqtVBHrgFnlmXSvCkgS+W8iJKhKLe+3fWsO9FFaeOfcRtLzQ
y810XmoOyU07tLtEdvjLCnpK6cDRoxMCSu6YMCocQWfKWGU+80rqx5veqg92+QPM
LAUJaM1yF91uqrxxxCkkLctSDazYbvv+5ei5AwI+DFt9DDlcO+Jyvk2KnLWYOkSP
hMKd8H/NRdQM2zGq/VgEbcsF32BwFQ2Z1aw1HfMrZOZWw98tLoeObZwAiE3+5hem
Z1Qw3cN9743dLcWZB+vH372RjtefI8L+8c/YtBiK0wOnoOfbY4cGCeVdoVe4sYfZ
3ITKU4+fxNEHdv3wUwnUNSSGvqQCthX6+k9FUMRoAQHh12tvAcBNdyzpGH7/+e2/
X2czHTml1Updg7hD5plUvvjcDlKcwcabh/vA+uSB4jjUfvdu6xxnR+p2s92KkOyH
7ynxNvMsB7w6eNH0jSN/z9MAkJIqwyW839x+Pi3jW0hRHS4BllxEA5yBV8r5Rtm7
023PQeTIZ7s21J1FEkUfAurRj8EBLMmEiwWOw0RgzsxLjMOqJsWJgBBCQefLE3P4
9Wm01P64X+MFoNEDCcD7Lvu0FhyXft4LVM6OFNpmdLaHR4N28JKVERmqHqHB+6V5
KQnT2xb2qsDhQOvaH4s2HqZk4Kk3c2I1IUyH9B/ZcXUDjf1dqaYYi+nrMd9VbnpN
/2hb62WA4z9rXGzIxlouN7v94ejK+FW0NbR7XiLwQwJ0XN7Sk8/YJG4Cj+6vjbci
J+EjfBBUJYMvxlEXf+Vu09Jtt7e8cXh1gDZHdN4pA9nf0/+UbXjEo+0iNFLhhV8P
jj+Ujm2YolOVTV1VGFA50srhg4M7t8Oemj/ZI7f3UaQs69mcXMueMqwRKvcn+o/B
8Z7EoOGoVi1FnqlK0p7N0SrqSqLFERAIDmwDftB3ieTSvHCaU92hJwrpHO2gf6pH
Qc5JV+usy9Nxw9Iq5/x9oHh61gvcKKNgVT7uFSsBQUdBnNAib9fMMHL4DT8eSXoN
JFWcZx2MUauMPFlfYsGg1x0knbHtFtWq+c/CClgDIr7Ho7x9va+FttYW+NBLVd+z
ab/BMlVtvetvHwVDblWTYfxVgSDySvPMzi75eGeME72tsCshsBvpvJ1++dLn2olN
MY641ktMULFVEyhiadMCEvu1dCQ8bKcl+AR7UZNtbf0pyrtedV8hIdXvt4r30DdI
vw5Yv5HKuMnz6LAoy2N90iJ2LVub+7gczen7NYv56vfrXbrVy4GCOYK4UoEYBzp+
KQmjI74NCJNf6PIv4SQzkQfX/vAWCuJYosJ2QXi56Ih/NDNsQunh75ecqqbkYzm4
zrGknGt6fIX+xH3du85IzRwxUlm4oD/RYx1EwM1lywwrQnmOze4xgUYCppVZyVds
j9lPrY7a/RIOhM9bjv3AWVZLwDNafEq7LH/u3isAnY4qd10+/TS0Xmdwum970+Si
Hn5KjwyWrQ9/lsOVoAkWGBg/yGgSRwZUlVjaqCddS5pqWG/JKyozG3gynfQXTPPj
teR4FmTwl75w/85ERVP9j1gIU7BhH7cUIFZ2D9XK2DIBGkbTWTNO9z1A8V84YWOQ
WGEuqkXxlLMsx7zoQ/9bIw09FQk+k1PDd2dXHTQsG8II8kf5ppTkb1RpuCOFGAJH
A/9NKbsN0N13ztwGP1sTZF62LUXEskJ2irtz8/7BoLZK7z8VT9KkgHWttLjfoz1p
92oHH1AdrAtH+UZdavwaADR93WOifMeNTZ1f9H2Tz0P8R6qcUxhOT9lQlRaPWsc8
yhg86IQ+70/gJ2NyVE9ll7Ub4yEe0j368ZpiT6DVPDyNv3EFzMJVr7XbgQUcS/Jb
8b7iuF6oKLjNvDkGL83KySkFWZayQ3FUTW+pANJiMVquC3m4KBKIpirnHsFMCK9B
zE9of2JI5mjn5x+IOt7rL7URAmIwvjSPTNteHZ51kqWl0oG47OWVMpA3wgfaoMYW
uTw2HGlpD3WF/BEtGcwE3V/5IycmZdjpcCup8Cy/Ljun7DkJ80BMh0JGcNCelR+I
kxfMyj1ewHRR5moK14obewQZuWX34SAZi+acuL7TPXrqpH8VA4ft73xOybpejKY7
1AQEaSvs4xqX8dBQFQ3Eet08pX1MkSDRk6hJ0SgSsYp2xIS/2iXyelJ1E1b+geII
wt9qCTVdzpza3XHAq/1JxxRZRpQJQU9/hCRfFSDZKeNPrsUjZ1oTZweRufKkjSx2
eoPV0vcWvYVz/vdi9xqKU9DpBlS5FORb89EsjlF/eyD4xbU8qySissGy0b9P7k5q
BSQYsX/z53TtIVqLiaG2KL/nvboU1sfgPx7shAdULPqpTBlCa8JK+acFVjEhowS+
/3DiRSvTOfmPdtBqI0TbGzwJXKbMCznLLY9TB2t4QOPLqGOQf3VsKzohYvgF3HAc
RdB+nDkcKW9VmXD3HBINJDCf6ZCHx5LAH4FWJDp13SQf9Uuk+Ut3L3vDeM0x5YNf
j6m/itDBtdxfQcsCAEmxzzQdJWDPrK3/4JsFfyuGt8Ty0f60u6u/h7jNPs7sjdRe
oFXcTArWo4uFyeTqKdUsWgGfJrnAcJmaieDZEerZlLMG9L+qA4PXtPS0p8kZfRJF
BQlldjFZKPLaEWk59WWF3jXe7XYuzj8nXoki8CyZmshk1jnzCDE6TlSKCDEG4tz+
HruxofBJW22GdopopZmiwWbOQJngjUmZ7ULkP7UjLatfEvr8BAPnQKmqeai4p6Ny
xBNf9Ow6BI1HlhYUFrU4USqVfjfScvMEDzpeLFSpuRpPqnorSAwF3iseidY733eL
IDkmMdq0qBkumD8JEunN8U1DLsfczql6KTlGPho6BEfUg/MVZFlp2yTmIcgWdBQ3
44XE1Zh5sdfhz3KaO65yoYLOmCenwtk1eQScWvujrd6ovkgGof4JR3IQJa0h+akN
1qqZ2WRlx2daYpzsEzpXG2HsilKbiX2Qq0sz6qjSCfAxbSIJQlD662wltznm7pd1
LOgmgJHypWZF8bkCbmoMeRftd7JH8xiFgywga1CVXAxnsnBnn9u08fyi8ARQSQfk
hE2Ut2nISB2EY0iqgRZ+55kQI2A2wwK8GtB7IlI4YBHPHaeonr3EJ03J+lSMUCPj
gD52AXZhSAER1HeI2EgYwkgcHsoWJT3TjP3tqzP7U483SopR/B76OJ17wpoFa11v
FzbOzw2VzMtm+O5v5+fQsHciCia8fYs4lGbSTrlps+PTIJyBu+X6kZEuKlMCTVnq
JyaJmqlrgZKSrxRHEZBEloZL1JTv+9amt2QQR2IhW4wOfC92KdKZkvJbJIUaUY4z
JkPpD7694XT6AuELNYtpnIEVIw2dSDlrPUwfmrrWUijXaOk6UjuhjpmlgOdccb9h
wwWrVncnGt7oGKuxvicLClUOoQQJggQcdXk/wbwVHHDFFWNu1JdxCOo5ZVX0tFjJ
eH7wKkHcNCWxS1+mKXlag6sp5fPvg0qoxfPurnUKAfGCzW+YPlROBn0SopULpUzN
G7UBXeVGCIkH8Y/ghqE+5uTgTSjIFZt8X5DHSXD6HJEP3U2A1Dn7tF6JYJrJzXgm
2tigWnhPLargaVPoJV7Jg4Ww7dEnoeeUWISczshBGEK6WgbRk0TisZ9eUsB2Hvwu
M0p1J+gO0i+G8XffgyENoumvsRBu32xuwxTxS8+S11KqrCOWx4y3eWFwrZAXpzNX
XkJ3l1nsgxz4BaAjwD6QqLjjOV6VmrJvpDj+HesEtOAWeP9H3Cp2287egCnQzf50
xbbYrfpcfMzFAu30jqsuqam5P4vEGEsDcaimaX/G8b5ECBeNJ3z/x5QQXyZLBsPp
nMlPQaXqXPWvY7cAcPVeguPsPHFbDoKl6EC16gLfH81fXwDewU0SYURuAyDdBb2/
Q0RGYScdRmG/b2mIs9SkLAEU/NOnKS0MTHrfAz2dfE+Mnadh818CbtApKDBdfxUB
mQ9P1bJnGbC5K7cWWrsGjPBZ8++grXvZnu7757gDGKYXG0+o60KrBBCEUW/48Ypb
jtcoRfD5wZi2EtHl1aY58YN8vKlKdg1q8YYrPIoXaHywiDTYxL7tjMkWptfYJpg3
ottT0AZ6Z+eocbF0HxL9r6Bgrfat9Ugejnm83A05EHren1jdIK4xaPGsY7DQ2O1+
QSmb/+P2I8Naz1/VSEa2Gh18rUCM4Sm9YTqTbnmtdo+++2zkCfst8ANuMTZPJs2r
KYBS/mjJcQbXDiHhBZKQXKhZYjT2hraq1eg2vj3oNUiqsHy+GcccKHIsXDyXiJrz
0TXD8qpX6X7AF8kTAzxnTHbCRCXR5Xhd3YPzyyvb4MiLejzqcGdrrAGFvwH0do3h
TAYdTYUi30J/wdVjT7ga2/Bwo35vuv5cVGbn2i7EUVROkF5wjuZZEDrKZR3empUg
r6jEoq7lMn+SMTXn+2mf4fGqYOEiwofug9IPJoMcyU+CxovmBIyTi2ZgFtl1iobg
F9ORSLZdXqvQc9FB/wWNYn3/rEQBWzrlC+a+vQ+DeZCTTihNn8B+yXwG+yMutV6J
/o6SEihVD6dXnAcfKoaCH1Hukyel/rXFRSya+/Fb8G8jEEaqZRgpyQkBlFvNqUbx
xc81NeobbZtIQYR/CwyX41kEHqHwXWzyAJJPUEDXyrHiYFljRIePV3/adc8/b8Gf
OtcK0Cs2Qewqh2NLSC+W/XOamu5BCzyBWkSvPKC4Q2pcm4tGY8WCro+59qVMye/2
C1CDqDPCO0rXxJ3qdP0RCniz1diQH+WZ5Xkk7YK8IXQD/aFsEYeAefHcYYEaHxMU
KwKoIC3andh+sEIFeCVuHQqr5vmBuJC86UmKNWfvMifzOt7baMRV8624YBL+h1iP
ROX3PMbmbYYSoSmvqkKTkvBJpPD4cQV6cGZH0Ou/IdI3c+pSeUWGggajKKmv1ZOE
BrW6drJdgBaNUfQbhKT197x/aUeq/n0BAwqXVl+1Sexv/xEKjfG1XnWAJNyGgLMi
Fqe6INwLitMEy42Uam4Y6yDv3NNypW8v53XtytbMwBoOK+/I6UV1FViSbB2XcJmm
8ig1eSJW4ZUNT9CkSfWq+ghAQv9YJZ99WCah7n/ILuXUq4HkdVP+qkHLLNN2mQf8
lVEXG+wIkzs1yPyFNGyfgXEyl2KD0+/xneE85Mjzaijymcc2G6suNuYI7hhbnINX
Fwl/y2WQuzkyUuEAdmp1r2c6YdDRN/cTq6OUKT4GUjgJtqYb3zK+Uab0iMKzCEAk
DAsbG3tHm+1cZQZcPGOWmNSCsfg2ESbfr9yoy+dTEhdM379Ws6tGTqJFri0YUDMN
QneH9eqlskSRmyOGLOQdQE9v63GWm8y/QdmSRbtUy4H3i2SPDPvQge6QbK8XeY5p
XZcLJ790jDV3GyDxKLfRVmFzg75nVvRta573vcDB74Eq/U8LU99akIRunWgUb6LV
1xBB5aSdx2nBTX+wlIby+y7JDxsaPQd38X9FL9fBHFfQXPHfOJj3G42cZwwim3SB
xPlSTnN+BS8BbyGenuVfBTalBP6/ugKNXbWe2y9FlG0L1SbaIb9+6+O6Ce2kCAj1
BjDndY6IBLJbDu2xbrglGBibUYU4MdDWOLhUnPOwfj8VcFtulFgdzuOpiBka5l7A
3FWO04i3U/s6+5h0UqlcKdyQxrSZmxuUg/nRXPKlGbFL6CqdOCVpF7bHPiYGneMI
pwXhtgu6pKEX/NJtKU8mvVQ9PaCfMpiDKQvZZGMIp6rpYMYxLMHosgAiqEhkKqnx
ofhFOz4jqQ5XQ0z7Fz5W0pR8mp3mBSsyCdqbIInzBUf4BoHGcepVmD5l4g4A3JV+
LPhlBl5FCsn8S04QeC8Vp8DARFM8V8VgLVJTrS8PaD+kgPGeSpZ+8m3spk9Pf8HP
GV55iz343n+pUSLcvruvzpYG9pJ3+sn43VnUjC9kHRFBEs25qq82+GiVG7FIh6mG
ZlxJi8b4EUMokDDV8auAtpUw7NnHt5o02NCCDRc9u0TLxgGZyn5qNv+VtD2xdnn6
j9UvK122pT7tx2eb2yXHbGyejBS7wMUW1zOPQXqtFTNo7wySiAdewYMwUFqT3wEi
s3RB2Sx2F3edLARa3vfO4NM5Ef4mO0GEzm+AXZHciaWw1DryHDiYJkIPag/4k5Ew
3pkZ347zBv69d1QBCzcBeFGW+hx+I6TtkXsKMNP0T3KDytDRxexlVwOZNbmrpUhf
v8mchJ7gZQSprLaSWyh9/qpyMALGrQGfQA343G20iEvtrDVWC33Jxwd5FX1fjjzy
SpnhvqGgm1YQ0B1VR9MGaqpj2hJ9LHcllnWTbiPVz6BxXCD7zxFleqt/MsYF0vna
EFbybhxNE+LVD//TKHg3ACZhqeXZ7aNCewHszkE9X2G54TU98ymrGt3dPUBY1NgC
9KyTYe296g6Qrap0FtlomEwUq20/+TID/Ypz3mXxgdbTOWjZnTkHZEVIursy5qUf
ye8zbmguhESIbaCDCVW7FLhOdkuhRA2jw3NYafsjSaiIwJr7YGXjWPDNnD2bW0Nq
qlq0Y7umbtyl+1TC96WuWRZxVOq2nIyImZPfbWmHzMFYlin+34765X4AZ1f7GNXE
I9HubX4BSD1ge/4d5jSjTB0mgxbqGvJ7UbhDsC8a6de8Pktee4hkzSTrHxXknQn/
NApjM1KAIu0Z08AdT4EGFX+3bv6q7IQcH76yZ3mDdhyMoDnZgFrfjX0ap2ypBvG1
G7fXsRhtBXETzLa7IpQy5THOCGbJWPCKGwLm22jWnPxysCqAvYzP8MYBjc8ii+Bu
ilof5WJvOsnS1UoolC9pC1XCSvaCyu+YNtogktb5RktwxzhmWdJn2ttVilYPLOtF
WtVoAfW2sOMCHyGaOkA2dd/aBRVAJTI19rrz1+4zJYc0oCA/opWR6S5fIiyjbvcQ
iS37BNBWMX1KlCdgCxYhh5j7W6Zlb4odOEr/O+1wODtf8AOF1NrcY6I+6uGHONuz
PfdWg1UE80heWE8S+a+WnmSu8dGYjGNaYYaDD5FTXNUCMpFcy5IsbYcgbw1KwKin
Ojb2Z+9ja3pWk+ngkhFJrY8xjuC2aF0GhusETc1SKgaWWloSWuvm1eBLNXo88mdv
bbjvRn0D0vW6k71R9yCBym8cTn4+oQzIh6SGcwgP37hz/b/0+9sbMkXPa4YM3892
pf1cFg06LDahnALlSlTSpdBReFuBZpLVTnSN1o9lIAxJVTS87dUB3DkSBXB/sLr1
qBuvkGEvWO+EAehoixrR3oEBNnMCOyuQZB8ZiA32SiqCfwxcRJV6VDsUmdOakTrt
dcCO01x7KkjTBt9rQhhgSC7hmlBPur+Dx1RvNVrggyFOezP+dPu6256vZMeA2DiP
cC3hLHVRbarrj/zwoBjIuHkJYn6PUlpt6GIZsUhpIReD1XDCZWGt0j1xP+MvoS2g
3AE5nrvlbKho5lXb7GdR8+gK29A8Hnvp1hYngilqH8zQjuyVRpOuA2GW7/bV7OtA
Io13CiVrX2zB4mIUrItfwvVdMmiq0MfW96Mij67h1NgyGah1iPF0mFz+TK2C18Vj
1EPA9QR6ZQp7aiAFFFsOHAYq2GehhLU47aYO/+iDUWripJMSyipIsFrej4EJpOxI
sGcTKzKr0KMewiU4e2N2OKgxxSfBcr08SxV1kBD5M74L0fMhQlG/jaO6eIHf/NQu
T9us4gRPsDXzhW1NR35uNQUl766om2tzTz17LLMGh1dZXWJy9HGkuFpQ09M4/wSr
qCDlO+3Y1KF7wPbTerYB3nSglTkKjqnGEEa2fWgn5LzJlwOwOFpxTWq7Y6N3Ys67
gtZmfsXfj4Sxy+1AIYXjWuFXmp1k4VZ/s3oGi3mdbkH8RVOEIpKGlWfcrMxkZk9T
gUJirH+QQD/z2iD1aMWU+zNz2T0NI67mqAu5cJDCyZ58tZy84U0pKLIGTFT0pyWe
1oAn3+iLQnXl792uyLhP9fQah3hNPDryHuP83jnTk8C11T1o1VkG2NJlhPJ07R8s
+DDOjQPUE9sOHr7LjwJ+0y2vt7ifdjrzGFvdPT1VHVnRMJ140XC0RIG3HW3j0h+r
Yqh7tL4HmIsZ0eiXeVtYfgM3EI2XNxP8p8MbMsGnkCnh3VIa9JL8SS3r0qdJxpxk
5Jl/eXa8Mn9U/PZOE/AiC+TVFkgLZIX9B4G7Hn0Px0loeo2D6t0eZLgi587ShBZn
niadHKdh2h5f4MxtR35ZbBnLEA5EqnFAQsG7VMYAvnV57nQC4G+LHj42es2Li7Aa
w/2sYLjIa0P0JVe+hNDxggpfzy4kWEPr5jmwy4YQpl4jEXF80rLYOY7ZWi9DSdIs
b5XzB+/hA56ZOOCQtzZUjLP1UT+G34S8uhvjYWKreF6nNUlp00n91iqIaBwjHt+7
xY9kxm/RrpWPGk8hd0o2bNO4bwQ8/h3XT/UcjM7RyAXlxlBxXLEk7D72dUt3ijb7
2dZn/U3M1tp7yYQpxgwk5Uik/fFTFLEArBfO1548AraP09Ebfhccn/dyu/fx43wi
ikZbHtDWgfO3vZmcNNanvJZulmBG0ZCZyb0NIPB2DK+2j3O00T0QhUbbHDaceSaW
iJIzd8aJdmKenvRvdoxJUaHg70r1GAOSPk8QjLz+ZZPmatoqv/BFoTnPTxSHKRwS
/xjs3ZvpeYHwc9WaYJxuW/RDd/zqfZZ2/fJQhQ5Fpi+GyxDWeWGTSKj98F4bWqo0
LxMnl+nWRvngpahMcYQ1Lv4QF8bc0o/qrpzpkzrN9Hr25SHH+kjkDm4lzIq8Rllv
TWScGrlusi8+Id/+Xa8izO7fQijYF5YaXzn+7L3reG5r4Jm6PbR8R7yeSU3cGVr2
Dhco7a367onL0wNZkL+mYVdBs7Rglvb9Bj3SbxIpnHSSPjQyTXGIxi54C0nyeNY7
RlLu6xL0fPV6ghMDj8tlPROshDTZ7q+wczCqcyoOFfRDVxO2p9R62rw2vZg4MBwl
AomObkpY9F0KXbTX5CICQxuTd61uzbGxYGPJhtZE1bRT+ZmK14KfZyT3GgNI1Xif
GWwNksagOiYfqKUC6BQTWRnAXZwSlsU6dc25I06yAAHgq+o3SyJjSm9R8o7AMP1d
2JPZs2R51hAIsE1g9CfN8pqHIDi3a+WD0j9hejnKiKT85Ih3plCV7Tg0CUiRvfCf
7ILjbnyx7jpiOYJk+hDWZiynR/3RpWaK/n/HRA+mxMkzbmw25cNrGmSsxcDaFtnf
LhlrX3f0eZQ5vOYVw6QoKGzKXAOzSQcSJbvtA0GSIiIkJUmyYE1x2ywWZ5nLwyxY
mkJ3JtqJOpUKfWPpI87BytVnkjlhtIJ/o94FKFp61apn9y9mvGf8Q4Ss7VvkdVVm
VZEoTKC+3UmithzKQOZu9oh6ohxDF6KYUReUJrf6DzWsW1njuiP6VWgScFA6xZt4
hweROnrZd0qEXgTW5+R4LjpnhA6QvQrtj+FBQgbkLHc/Ym15mfmPzF8TkLwYdDeR
q74Su+5H1S6B7wgvgrEBYi4rla65EuKMnpXnJtALckLoi/bmiC2ZVbfS6VAbnIYC
JbeRQyAko68ojM4eaT3efSaJuNjjyL4zLjhpaSTcxWE3rVvQK2qMmh8TBvEhZsmv
5RwEpWymLUQIswYDAMwtKsm0OFBCMKVYrwDYpUsDb9K6ogi+Nu0RHM4eNoveK51j
UtzKKb8cTd2jE+fYc/HAbkE5pHH3Mx/Y+uOLvpPpk6H3P3UB1qR5hsrCoNsZwOuL
lEGuQUIsspCej5GB2ovjwf1LN9RNFypVx4A8bL32JOAY+9g7YrEjbq2TgAYaoX5a
l5a6nd8egk8jPAnFdpClZq2gsstvm2AD0mbXTHcZ1V+rhfElRL2xaeSsCwHb1ngr
GsZvHmqOUQoowQAADAhBsopT3ZcsbAHBKrlrcEikDG0doec9/w1nuf1OelqMXn52
wi/OfZVNMquJpha6bmzRQpvGFDA8TEVDgUAS1Cffk1zthWlW05c1FJ80HTQeHKyb
T7OwotEjwPJOvhLR/C83e3x7uvvjqHanv661JgMWT+f6+UChXUP6rA2f4QDyKZtR
gMZyGJr1heEF2x3i1rzwtF/ZghdrVgVWwuI7v/KUQnmhANs1UnU/m/j8gxf2NfDE
9QUlOXOG4FVVuYFQxHTXqk7I836q7Ql2ZlnDeWQIANGAkvkmwp2+EAgVmw0Lqa5c
mZmSeC1eEloTbQ45hW8vqwLs5Ehl2gU6neR/iz/X7F2svrP28QifQUvChHFifJmH
N1dwR8njadGROe+MriYKeU+AlXdcvCk97zOT6ceT/7hjkY3ewrB47j58HuEWwqVT
JM4vxTx3x0IoM5G3sOXKPc6oSC+B+i5V7b5QhL7Pb4Y/RpOavbwOt+hH/Tp9gPrV
rwtIQN9t0VIJ6lbM98nECICWprBKvyHgP8vt/GxgSTQ9LlhbRvag0xpnnLvd1F+w
Mk5bU6ROekEMYq49Np30MbZEdeeycdcla/nzydQCUAmkCptti2qRCMFN9+5qa6YJ
Pto0bGDdfQ9BoikEKlwLJSsIRC1YRtEp0WNUp68vr8nvdxSCvdHHn6Z5UzGmIEvx
bcm8npVgqjSVpiBT/uqetuxB8Wk2XDRzKNmUFF+khH0seOYoYU6cuGlF2OofAwmf
e4x6I3dTJqhmk/GfSUw1FgUVNXKQCItfcC0uw9CAFUUTegpiFzQSVkdvbBMjhIc8
Bxizo/LhNwubi67WGYTOIerzs9MVlj018arNwbuTOv8g/aA5XXLyQeUYweaVUTh7
Jv4N0jcBqo094doa3W17BzLlQHl0KR6EkLRkgGi9B/luuenrdkPqdfS7akLwxaQ2
GYfD6T5qzchqvtp0QiNX5GpvShylCGsTPjbLiAUKSa8E665grl/uFREz4ZtVn2+7
HGwzdzbZtFcFbRkjChHWWjVW6yCczcfYGipL8P4xpUVj3Hn2Gbtqlp+DFfGT2d5h
2gRCb4AU/sOHDzlPtpQSKRKyeF3TVxP8TVk55L4IFL3q6vxaW2RRhW115cTe1BqS
PD3UkqjUfhwjdw0sjSLmW2L7s1aEg472jf0IkZpPLOZejwJLT1XQP5JDq7v9v/eB
YTfnIywA7iGqQyvg4k94EZ1QE7HXhSyuePtg8NqdD76K2YUSGRdjdtzj1YmQ9XRu
jgpPAeRkeQfJF/40LdU33VR+IcoiEJRoStfr/k8ligoojbC+Wy1AvcSE71hAYSw5
tJt4l8GveWqAXgnY5oQpvaPUdmp+qJQWUxeXjxMLhsSX7o2/QnmfHKrv49qtkzMj
FOqsC8XvR6dzX5+Do1Y83UZ/cfk611n2ZRT8qjaf9CHjr7V/X/N7hIJ1GeCTcFs4
CytCBoKdfM2/gftPae5BYqSJyttL9KoS1ED/6t0r5dJ3Gcvz/zzAnSKBXWMSMsR9
Get6u+BLH7cdBie7QcUkmMQoz8O+LwYlsnC6iBfXqXVJfACyO48DBDrvgChY1M49
cXS6bKvNLaXwwx/PsbBz2GShFcrSsucgC9NS7ARi9wyxPUiHrsb3vKTaQu/KT/N/
5XixBg3lrbFK2iL1i0azhPpJN7QzqQbvVixPVdI8igd1aNPpw3ULgyREQctc8KwO
+ESfM1hcIkcxPgwxKA0cG2RoJ4LNXDO7We4AsGGJnVXEqLdjrt7+zd037BQVxnLV
DjBVCAL6o3iFOMCqit3eJCEZM0xNfEJYdo3RIKeVOtiyeEZrQwMCm3tkHbjaXOgi
oA/v4osajxZXTCIYqYvGZa5LW6grHu2AjOR1xpDByoFVWFi++krup3bI3eaeo1NT
dvxe2IlUzoegbqMbWm3eS+7UK8Vc9zj3pO/RYnDupTGgfOWqWaiZeAun44zm4bB1
CgCmfrPk2Gde8b6rxxKiUVOyh5JHwyaM8Jj09lSs5SqptddaDVid1U2XPEtpSNXH
zPrp/Kfz+7Si2LU7ehrN/aaDG0x9z4wfKyY/aEUwnT6supi0rkIjtlsrPYtpNMD/
zwgOlatVdTeEX161qkFVZS+s0ZtlWDwDxrPErcGXzURj/a5CROQno8/B6m4I3M8V
4hBwpy49c6u5QQ+D56yErnG4rge+PWx0b3JRZDXTjlBt7i/FCVStPjKI2bNwN39p
IyE0PdlpFIZmC0/e41jYGJ3qv2iLsgTT7LWHs9xBVUC1eBsqXNs+l2UFyDSyBZPh
I5R5Dmt2PZVyeBwrff880KbvF/ekPjjXUNLNgIr2RqWjv5rPw1nM6csb3YRMiOLh
+sOa/5GZsI602U65STesIDLHixQm7jC4YJmYlj3U+BlO+x+C5DiuUXz3tZn/3jUo
cio6LzNylXX2ZUBg9gfFu5FFYxfYfWqPzxrddLM09Uh9t3dvBhHOCtuuRhMG2V1q
xqB1k3xEjCTSTRswGpC7eYTY7HKZJzLXtV8XevsCaVT5phVKVBiIpe/xtOlcJy91
MVze9uDNPgIP7Hsn5cVvO17ZRDEt/WfABTMCKkQICBAUy6f0wdMi1J0KmkJ4B62K
xrmAlZDOeyqqNzx7AzISpeNxU36tFRYw1pWbT7iCjnIsYqMFw9llIamg9egxnfje
gzxFcefgPxbnCzkCf5RnZQgQCJINKw6Uv4O3ptr/GBJlWjOmJHuxCurrAR22LlUQ
slMu2N9OSe3Km1zHLd7iWfSF7NQN8Sxc7tOxTZEVDp/izWsXw+anrDLdRS7ULArZ
t7jabg5Wh9rPwTEPy6UR2y2QY1RHqiXdMlkkw1b6k880baFKt4lclEQfXLg25cnX
KAPRPwWRGe/5YOz0A18c+u4ZNDpGsd/2FPOKR54z9cvx0/UDkVoZYTWE8w1d+jCR
gtFN2GkHKD9k27igJOX5nJgwwvKmMNABMGAP3MkAuc0zMpL7QRNbkQkdCsMzqQPK
alFIoAxdCKBdlSXwIFp17LlF8/0NLPhYwtCf0ygQXN7AUd8uhccOxEhKIAQkdnrl
/S8+Xib/Hgbr0jju1JsqTbRYVpHodxTQKVE8e6Ocv5/KOkwVayYceyBwiSidFt3G
ZLgYJ6TmolNXqn4vxvPa6Un0Z/ZnEAySyKYkq6FUy4/1ZZpNhnhkuV/rDE9O2HVy
JJM5VDb8RcVqtt78vEpKiPyT1c6ZLx2PkWHHZ0t1G+OaDsW2WeRIv/mldymqrrqJ
Gd6BuUVB8usfbgqfwO8F4F+SLa+1ejoTeRhDJBESIZiXLUGhLDc0uVyzhBhuG9/Y
aI8mvrqPQu3RgB/fh7R2Do9P9/fPyHw8ndJ1v9wvDKcGCxMQwC9Or0N1wXQF8lmD
bqkRNhDAutBzOR6QMLn0Q/dXBnfha/5RqrKVMuHoEEKpLG1wihsbVmzF1222s2wa
dTwEcoU0UIRfYQ+7vB/HIg1ySU5tpE2QMFd4/PBimCiPtHG2Bm/1UPQ4ND6jCbr3
srSLpESbnSUhCglghAdEEXZSdsRgg8NRNJwsIuC7sxquV+YoiPganYecZzQieifC
ZaFJlBcVD3wH/Z3td9mDhku80jCql6zVvhgrwi4CjkRZP+ZOFwzSPvuLn/fFN31S
G7uo8aKR+8XZvqJyntyCrvyJFC8H2mkgUr5K8Qn6c+7fZgaLsHj97vaqYq7r1e+0
mYQyvttzK3y2sdVqXLFVmv3z6NUA9oMQssEuowyl9k21XzUQDc9VdMI/pSujP7l0
Fg7cpUkWfMUIT9aXmTgVoA2SRfPa4nI3rokCce6QgjZ8RekvWlARHDWlIar340ph
Vc4G3kJ7PUp412tPIxtw0ZvETqwoM7uw5HCl4hiOEhGGy6jcgzouCGo0LYiEHOSg
d5IZWgveWUPsrgQMoMNwuofu6AZl3IFglapgEyS77Cy4xieA1RNMAIcyuHJRO8fN
4UuRxj0bUmOAvLafqjYUolZFWm9nNTIYspMhMjFtP2XKMybXe+NyebLgIZIgKX4B
CDbi/iYrfFAZZZCgXX1eWUvgnJjZX3S4VLRcV6Voe8oRgMfL3w649GJbUnwon9/a
nn0fZz8ikE7EKb8Oey1ZqAbVVioCi+6c/qlbVr650OC3YnQcYqYAmhVsYJpnLPNL
jCln8GLo6aN6E4ZGrpEyStnSMZe4IbCevpy2GmeLz6uRtrYYpzD2yqZs2Z/Bri3D
Ks77wtHIm6bfaO+5gEYr0sdgjt+RuYfK7yFxsO71ZxfNQbKk3EOjmSMmiXuKADb8
Zr3gjxIagCQQ1SdYQW3N8O7nGSu8TnVTF30ATZnN+gVJxHgQgY4MthIq4eAGwkPo
zB6Lfg6S+ZI/gmsLh9MgO6J0vok4/Y3N4mAGjclcrLJ7LwwFw66jqtRUcRhVZ3vs
mYVTutfEcLWgo38W851QPR56BHaXYIupHHqtKn9kLQunFcgBr+Vfp4PTkk8L2wWH
7GffAUiA8N8N0jRwLd34stWL1kG3d8mxDYQsOPsF0dNm8U0JUCQroGuEpEyon+v7
Gf/MIG8skFB7F/9pN5mMkcI6HLqmITnVBOk2k4CtWC51LZtY/HKIjG83LXpt7Vn/
pP8lifMb5FgekvQLsMGTjOUrJUYKgTzUoDPmV/PbeKfFcoMTOIarFxJMzmoEPU9g
YeM2xT17H/FT8tlEvg2WDqxXm3Ho20fAsAd/HFrM/SzFe1orpfWDNdXlkGWIFSQa
9P+L9tgAniR/ArDSC+pWbEEqj3WBRVUHfh66z4gP1fwhheNaWQn6qOP/gqakO9Am
apiDOAeb2v8LvwhlkKRyzg0MSe5koEm0OCsj/absnOMUfml9awycCGssvLXwg48+
7Zwrx+1BooSODRvC1PCGnbXQOdVYwl1zX2Woxe45Bby8YyhLfMwW8OkLgRgYfu2g
qVvgnl0xDryx+TUm9fPwL6g6xBkHDBlDoasHgP85oDDNMJ4oAQiNUBi5GA1RJ3dh
EhMVPSAwZAbZAG0IgqA4d2B5RYo3BXPAVx+MeYZjjy46oYhRzsjT0tmhwbboa+sS
DlzUL4EcmE5pRHtFuNdFSZ3SlskfpuqlhNZ+TSGavSDZPNDa8kkdZyfik+DXJgEh
LgkfAOqlFTK+KgO5WQnvhm9QHEOXgZAPFue6gV6d8MPt3lySaLaNk+Jc3tbMTwNK
Eax0Og3NHyWw2qewQKgrVP5mNFC8egityn5ij1fAjrFoIEpZOPEJAT14RSJU1QHM
IbExzexc91nrqAarmQNXGhpgeG1WEcmwtgYxe88yD5DLNyDrPVGE/UwAFyxWKvYM
PxxIrGX/WFTRCa85giFfG2WvoTaCnxHXMfjbSXy6X20wrNHfdcLJU7gakLooQifr
DH5hwafDVoa6hf/N/s4d1xw0hJHGyOofYAxDBOA85y2+afMUNZtNpBgy7TaAr3UZ
4/xbeGn4uFvn3bwZSPKl9+alAUR04yrN2y7ND3PAp+BZEn7nV+eOVOLigzJ3n/id
cva03TuEjWdpy6mHKFHn0LhiqLlbR5EgsiSY0ndkSVU5vJOJ6K2SRnC08RzBJGxQ
Pw9PJHj1pMePA3l4dg/tKLo+6VXSrqOeQncZvOqmTqgb8lq1qUlyx9TfB7T6ENtE
JHTAaHBOQUj+FBEDY3rANjzzRZWHnhkWtVcarHffj7NUFmvYxppftn1ymN8gJGjf
3yD8OG2baueyadF6UJ969R/to0FldxDvN/yyddQLjJ49QJP0LzFNwk0KjYGKkT8n
l74YcqED9lybYBoaT371MxY7VAPfSNblgATwGKW9DyQRSxdo6jT9Yvmhas6Z4kmJ
oCzfcajEHZ2SCkfWW1ATrgNs/Ipawt6DvgaIhHe0glrU+s7/hmWj/LauyZ+Cgj0l
kq+xDKiqDt2qg66jegi3Xxw7wGsNhbG67P9i1VLBzUMUsh/Vxq2v7OhuWIzCHCKo
AlLKRptFAOGYmnwnwhQ6isXyUeAmv0PwNcye1PqgW8tQ6jDqBLEbtt6qUvsY/Hcb
EwSUUnK5QYxHllsTdnjFZYtC0F0tuwWg0i8RPrekXxiLFOQQlBKqpeFnSNLf3ikR
cFVyw+OnWHFY54ZH8JpXNOHJUNPYuIihzyRg8kLGJgjjZLE7t/cW3RmqII1qQM8x
VG1etxJJAgb6F0044BpIjif+l9cg5Syq53wFvwsfJ0f7IzxOR6pvHyJQ3SrP/BmG
81zBpiq7bnrmzsHYbeReAPegPZinW/MJmJdua0r4qEzIF5AqDeVeRc5Gvq+z7X9T
TzoqKHxVRXJvtJr3aCJ5DfG1hVQCkt7MOCffj0dyzaOLdsGdacjbSdB5wRtnmBc+
de2mczsp7UrPZ5EVrJaIC/JCUXabQGP3rVUM7wGxqddejOnqKdD02WZgN2sER4KX
+mZ0wPV6lhjVN6Gzr022NkW+RSf7q+RPKwpqr5ra2H3A0kCQDITDPHM8S3diPY/8
9UWdT3jbtZOCZex7888KyUUwwiWIawW6hnihXkQZ+9XQQq3ZHlr9LT+B1EEgJSEz
6rQ9FB6QSX/RamsfLfcLbS5vO49ZcgeFKRZTLeuY5oJEsRvHVz3c30yDGViEne8b
e7vfLcT7HmgiUfag5rD3wg==
//pragma protect end_data_block
//pragma protect digest_block
0zEYYDBrQkJURziHjUc8LM/LB6E=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV

