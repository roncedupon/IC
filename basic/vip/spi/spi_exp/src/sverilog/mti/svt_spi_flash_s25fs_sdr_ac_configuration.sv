
`ifndef GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FS family in SDR mode.
 */
class svt_spi_flash_s25fs_sdr_ac_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
  /** This is a handler to the SPI mode reg config object */
  svt_spi_mem_mode_register_configuration mode_register_cfg;
`endif

  /**
   * Initial value for all the timings which indicates that parameter was not
   * loaded from the catalog
   */
  real initial_time = -5000; // must be smallest then all timing

  /**
   * Minimum Clock high pulse width durtaion.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_SPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (DUAL I/O) command
   */ 
  real tCH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (QUAD I/O) command
   */ 
  real tCH_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns[];

  /**
   * WP# Setup time
   */
  real tWPS_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tWPH_ns = initial_time;

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns[];

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns[];

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns[];

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  `ifndef SVT_SVDOC_CC
    /**
     * A helper class that can generate random values for non-integral properties
     * 
     * @verification_attr
     */
    svt_randomize_assistant rand_assist;
  `endif

  /** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Randomize tW timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

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
   * Valid ranges constraints insure that the configuration settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_s25fs_sdr_ac_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = "svt_spi_flash_s25fs_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fs_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fs_sdr_ac_configuration)
 
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

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
   * Allocates a new object of type svt_spi_flash_s25fs_sdr_ac_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to print only protocol kind relevant fields
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function void do_print(`SVT_XVM(printer) printer);
`else  
  /**
   * User extendable hook which is called immediately after svt_shorthand_psdisplay().
   * This is extended by this class to print only protocol kind relevant fields
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif 

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
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

  //----------------------------------------------------------------------------
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
  `vmm_typename(svt_spi_flash_s25fs_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fs_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N5ggont9A7taZmkDZKmleXtElNFGFUoZvH5D+D7e3F4s0gaTJdcyKGyaKB9nRSb5
y+MUONFC2ZsqgBbitiHhGTpjQySNk3HkAbjTtk2ZuQR1eoTIlIm1A95OnYNDYMt6
b4g/RiChUVwTMeB6tGGYnmJ/OAcA3E8Oq4hD3v+dmzk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
956GylflMcgVi/pzk+lgpAHIdEhUukX5zSlJfi0BlEyodX5ibXyd+BA/nc0DQj8M
Fnb7s8yz+1/aEGMPeRikwKfsYS/+ujbCJ7n8XaUwbMT1XhZcCOpsvHwOgvAoIXdz
7rvjZBCuFq4ugy345n/g4NFqDWDyPRnSj3jLohMJd5A+SDYsPD+atkpBskIs5M/Z
AtMLLOQqFrntFiwyYRmwmybosANrBMvl8o3UCBCcZ9gDs6uJygntawru2XTsGlfw
EAdIWpYqETAna34vb3GBimedhpgpkEvriNYam6bPpnwj+5rzayYmbptURHHhMD1l
Eskfmbax67RYs2FAMjQljG5TWiW+jw05TCoW0PjWpkIl5O79Jgq6aTz0B1SUtClw
SzqF/xnCr5MSNKalHmTPxDvjlsZLJsOvOsRi62c2xszdvuAk+kaZL2ABUozi9qJK
G6bK163QnMENffV4k2Rx/PCgnV+uCpFzq0dlyN7jY2k9v0C0FGKPnYgA5lB/It7t
3ULB9wRPlcFpeGUFwmZYhrxm873O9udDM/pmFA3wy6TOHAtv9NkEMu9f4Y0D1p3n
fJOtJN3Cf4nHpqmxSU9J58an4/NgO/O8xZqYD8obL/J97HJRDkoCKMMQTui5QThI
LWMHiB/V4rMngFaeilLyKZm99xJhiimcHQtfRjdcXE1t/dkUrxxZ1E6ZraXaA6VI
jYrCnAKg7Bu6hIr+Ub2/f6QmkhSfZzYs0Lg6GUAiLk/LlkHeqcKNvcb3vpnMRklI
B/kkbUfNZGIOb3jWoM3rG/NuF5hjhh1SLAiEBXoRdOu8qprXE+5lhgnhm/zXC7qo
9WXh2ABsnCL6TA/DKVmyrltgYIiEeBAvfFDM7L0AgoFVc7V5jPrbwAATVHAG10UJ
rcn4HpOECOfrcVwEnLwZ1Qdnh6/hHJ7OvQ9WsoYDPRSrU+k0xdzQaHtO9xo2Th6o
p4qD37pUrGNoVgrEHB3YAhs9NEoHn4CWFFuH8Zmj32c3v0+ZID+4foQCb8dE1yWG
94d1o/DilL/lzAEfSsX+Ng==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F1iEbqMtQJ5KPhLcb105IOZtDty1gZ/5kSybafZe1RLRz9Vm5vqXi/AVGbpAs3/g
ZgXXXPMug9FuDJtOiAU5h67t4E/JthL8dwrMDtDhGZmuAXWzvuWbMtUjRA7K9hec
kPO113iVeoXU/Ngvn4IYNodx9yfm+QaoNLus67K4qTw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24354     )
zOvAfRsml6E8/WzY0AeJxIR0ymWiFPefcx8g6vRVZuWEqQL9304f4AAThNClUFd9
HfmUnN6LxY7bdOQEaWOhsAL63Q2O4XDUJDXihvecszO4AyzvlS9IW0Y5ls3MQHdw
o4eTkO53UCojPKnmRLu6k5ZCP/dhXO6VGJF23eFyOwp0GEhMQbJRqSmwUF6eoHtL
en7RjZ36pAOJ22r461ecHssgAixY0WqkYx6wE8pgPbAXmLjBxLA9d63mFhXqbJfA
n40z7iCSYvVZVe+wslGNkcQJwqoqHKFUUSpuT/oicx+KasEJ9J8hJT9FwVb34rDM
uf1ArcoNM3r2WOKjCaKZOMQ4m3bB+nb2FJ9vNJIkQwpBSbozL8SRjpJXkGssY58L
Bwx27p+cm2WcjSCZ0MN8SeQ2eakffZE7Bo2SRuYM0hlWvpf+yVy8BvtaZXQLlanQ
yAKQxhhxVQFkuSsp3Z+hgpHHkXUGYIb9IPR863VjHgrfT8ytenjSYVZR/zOnhJGD
/zWvmjrFCmzQWMRXCunyFgMC9TrbiSDGnKSCIb/dkTSjLai/znKvQa2pTIJ0h3Wd
NMKW/B1hX8sq0q7E8QhZc3O7TPgohY9kyy1Wbh22zClLsH3pA+I4Bxx1juBoerVd
A9Sgh2u2tL98JysG16vyoYlycMZyQuAlB1dCIJMLUcfc4npkyK+jbi9LR/9VnlI2
y5SN0PmoFSzTY3uv4iKLz8BG472ZC2EixtX70ND47cavDR5Kn5egpMBdPVDS1yT/
B7FXvWss0JkqF6GbStv9YP2gVHQAv5DlcslY/Ptv12jtALUbljoVmsU1Ls/Igkk4
UAzGBUddMf6nXQfMciKRWakrwq7Z2gD6s5QLpiPFglUI2j041VirJDoIkhwhjG1g
EyhdQBv76l+axwzAdcYT3QARD1BlPQrTFnYMpxl+GQzdrND0QwfZwpKWgH4dnumO
bvZPpjDloBE3tGaH6rzSkz0+hGkfIk4crAw2dJOgGxhF2dsc07MtwO/CHXQFp9DV
M5Rzs31O48pFHkK4kPlKuHrv4Myz6eWi5SiMjKJIw4iED0bU4lBGzS5ybHS9JcxR
5iTpa4dz1q61YVfyrOjDaC5YxVDEqrQkkDErqdhcufW9NBkk3k06xu8gJgE+Zsup
StWVovZLV9McDchhXmNlIEgeoXLhEsWffIovDeJMhkJb2KzKhrOhGvEx1CnQbWVr
L/ol7a7YbyCxoc8/P5dKdkLdDASlVAVQHH1ah1upaT5Wc3sl8Sw5yvWWVrZoSUCc
tc7o/ngbFVEaBETaw0EYeSNhNg+e9E+tJrSjch9SntM43C8idAICC/pQfEHPhh84
DS5UaZ/hI8NTCLST0qVIB615CM+bxGwUaEMbg0LZDZKQ68JuYmuEV6v70zZwgJyW
4vWgbPq9KgJLpHUaT3qC3zzkItkpd+MkV0fqGnVKakYOC/rCdHX6sRSVFxuX7KYn
db0/8hcCXPSw6GF7lWxx2ttrObZGl+wRw7u6mV+xJbYyFyrWvr8/t9bxKUE9SsaZ
VV3VnAnR0e1tVXVsFBVfJ2CYpNbA9F6ms9qqmlhJPaWQK26MQLcUgeND4GUuAXla
Nc7TdbihHWSy9D/B05YGIJ/l7DZpF0jZV8O3A7PyfWP0gGWozVjYBTv/tga68fta
JbRmlvitYDyoFXIMTBTwTyTjx3/gHdfAD5fq9ohTX+G1KmF/DiC00w6iXggQGOSR
Zvb65D6dhX8A/STsCQw8Y/7uL0SvudToy2j3as96Zz2bexHeKftA+eKJpYqyPf78
kYzRYCHYBRJ8teb2p0ISAAfuQGtu9FlHfF9aO09lITClgrN2s4kEHilNgXG9UQmq
9KxcGi0xKYCzzTcWm06ww2hckodM06MBGBvPvL88weoGGinqap9eh9QQ4u83Js3T
gCGlPjXYTedaXo3PEc0wHrHA8zliRlOeX8JodCqQM6QdIvsdN/2CVwONti9/9QLy
rxKZUp0PgbjWxNhu/r7sMoIy8Jd+rB7fzfaaTxnN2pR2Re31ilUyWsvcote6Bj+3
SkcYTCKvIUpdhY3yrIP+sOxKnYpIi83O4oX9XNxVo5adkvyqEh4466VZFcKWHArD
pRiGWLUIiBlNAjMDrvhnPNTawNPRafrKkKFSoTt4iBru908alFkvUDr04CsXS7Wb
QMqMVX6xbdF+3vofoLDOH/Js2wcVkDkKhTnpZkjyUIt7OZm6v0gyMPOLijvwkwnq
6me6us0cyXBKUwQkLkcvK3Ok2fshnzUoDLxKnPftWxBWzMOPoxhQ77DYjrLB8cSE
Zbpm43IYbuJ9C8VQwEMMuOFSIMr7e1DfUjOPrOwo75n9+nHGCSpjwsrubFoXWwrX
dNr/9tPHK+MZMLof92ASLNloELoW+JGH6bOe6dHETACZYzw2rvQla4tHaoKd+E63
186U2ks9GjRWDMCQWMG52RCgBY/V13WkcCvAWGXpYV4MpkJaOIW7kskIiU2kQy7C
hlpYnYOH8IJub8cqyD0U1lV0gp+jsC8o1LYQItJ3hgUhyuDcCUGWpylkj4XEDopm
eJdc5BBn9pjo18JKnI4FqfrlRsHnaSMyaNBzre1PKOjH9cB3OE5P06PiciN3s3Xa
gxhgToW0CN6VzaqFsgoB2tn0etbojxjeV/uQibJSDd1FnDpAbSGgyyz32G9ddXap
jonKH/nTqO1I1k/xxOmQgZtYEUFQ0KIC4CC2o95758+uWjcPYjwZoLp7JJwYB7ky
XUz8j9MPpWD/m1PMyY8t/NG3ilwKQ2USXamXadIKgRqglnFlbF4/yGJ4EnwZ5X8K
akDK/Jp/jZtvGoGuHQFT//s/qiJwwvh/WVkIjqGQKiAuw+roZz6xmtpTeChZZ203
WI3FfU/fabqo/CzuspUv2VaNX6OwQgPR9GKixcoByLVrybB+OiFV3jp0NPW72hK5
4vcZoGNOnqoR87H5PL6Yfbdrlw9bKIomWKDcuBRjfTe4ZKdwU39xooyo11QafzVt
3C/+hbX/GqsVwlyp3Hb3j4VKZJa9u+0j8l6uMPN3w/xXdpy7SCXHccKdkj0zrn7U
gzABT2+u1YbMpvWMcFsl3wXH9flCvkMHFBdTHZlrHd3QC0VMjKGn0ofqCtszmQY/
dHp88y5wcfYbSMTgFiWfuwcw2pqyuLrQD1lQO265pFqo22+d5jPsk8SzVrjlgcYU
RXl0yZZxM7GSo3qRLtlWGbU8k7iltTffghlxee+0HmZiMLZOjywR0MOhFA4i7+BL
HWU4fAuxjZWgOK5o6ZRdzNeU0OqoUejTdYU6u4weas4AfPKqYsFQfnhbztsra4o1
OsBMTGCkr4/vjDcLE81fwwbOEWPQ58Y7gTtJH5RLxXFT+km8TYm85UuHP/nld2bJ
8A+7Fbry0+Cdv+eqB3JUUrbROHpYAumWEx6wAwxU216uhN/qruoaUAPRJHPM2K+9
oi2ThWcQxky00wWVUJsacSqd9HFWiZOaHUvihfGrmg3pR2oy07PU4A7AkdZOn0tx
lmOPxQefCMyfXL4AObutBP6sjT3sQVAsveRioHHcWSDNCzf9Wv6Zvh0buPx/6IZF
kWYq8NwKX2KuHzFTyQa3X78ZjZlquBw8zu4p141N8abyfkVr5LTE/tQGu3uTBDXy
gX5xW7TJLFbCIWXG1GI0vVDRYzjAJ69GOL7kTZTfgqd7bWc3x7oG+CUkseS6TEan
3nLivP1Z8DcASp42ET7A2vTo6xcW6QnxDaZZ7mDCK9EsbtoEZ/Q1UBXRKKJ40atv
sivUpyMdPRIZqJYO9wl3m9lPqbHO8eGo+iv9O7q63nZ9wo370DKdwNf08Z7uW3fl
lfAq4mZyoVBk2Dh+enKChQFyP2HA42TWzUPiNPrG3lTeasY8Sbj6L9HLgrBaV8AW
wmr8gTZ190FJroWDiC/YtvwAwJT6XtK3BcpL/dvy/ImeNZAgRK1KEaUNnTtLB3Vr
TQDjq0JrxZfZ47YfBS8yCI177QFh8vXYFCnWRFXGkEIihVs802zNcXnhzwBqnYoN
vvM6whaJdSsHAWFXUJoTkkmowLDHjgsJjqux5HA8SOgqI8b+hq457lWuR66xK5QH
vIQ90LBiW+7aIAVRv+4Wx7lvJeScVW03oEGGkvHLN8qxk/sLamjCkeqYHlAwDKdR
G1Tb4c8mb6A6Kx9dtMmFjfwGAagjlHylKG6FAz5S3Y2AcVXLBicr4M8y8UTMRY0V
LxRInqAOA1tz7dHGklycPQ1CiX/pnA5z4J7jN7k+uhbsciPSVytiOZYElmyulzXg
ZHdMx4azK0rMiWerTBUfrb6/ZCH0jm1wL5yizojHvOhL2+liyFSOsLllWh0e+Lds
q5q/M83iyY53SnkSF4keqytfDKxkPLW6ycPaFYT6zalcrKs8zwTiw9jFsKhit37W
kZaj8OXgYrDaAYN3PussHHMerpeahBsX4rpVJgZA0Id3L82GjblklvXuJ5nJuob2
dxIfCNwAjNRbXNrmbjrTxmF9Il7ZM3KaLQCqWptSx0xxYYp1jZWCZPQD6kLFr7UB
ZJEBrcv3acI6rTZ+iKlH7sVGPfiBggUGhLSC/jPB4XsMhlXKKmm3La2/YGdiUIWU
hGfpDHPsrk8c5eJaf8dGkudiY/IGBUtBEEwq2Fvjp2RH+4rjo3tyKfrQT8DYHhx8
u22xzck/RRbqHEaDV0dx5Y/niop7tTPVbJ5uQRc3HXe7tc5L9qmU0UPa8zNdkHxC
3LB0JsoLmnE7iCIa81qhy2mkazZdKdojO2AIz0WtjMlAfsu051+2cqH7JMubnGf0
3nDv4A3EO36koJ+5i+7t21qo4gZnwe4gvx0j1TEnJSQ8fdcJCoNm98ZcXW+/88i3
0qzyReaSRu1y3Zsesv2oUPxuuF05Grmqo0Od/I6YU//DiRMHEuCHTAEk38EzOICO
Roab0apyayPs2OZ/3eXEawu2CGHjmYG1Za8B57JwiWWLCPQJvT1m37VC/VQ1+WxH
kPXTXX9LVb3vBpe/o/3YnsoSC+Xm+CiwrN7bb4u6UswDGHoLUUxlSjGO8vVbgt91
HiIlGE4lt4hAgMR5NVzPZ9AOgguprf2w7F8uzNEuwHjYjKs1esgd1mPRw3jMB3lR
nE7OXBu5gU9V/gATwlRD/fvIQSLilQJmaJNsmkqahZNu09mO2qmJUYL3VlIyyz1I
ycmdkz6oKVbzDQQVdc8xaNFU2OsOHI8rPo1pd8ZRzxQk5Y6BOGieuRRJpMzpt0B7
qCiMXRZY/VTk78PrgazKkAG96o1D101S47Z04DgSX6WRdJDlpb4KMjJ0KadEVrX6
28/IKS6HY3qJYNVKkKVgnLUPiY/P7Le/eBzkTmNZtUOtgCmnQLeC/ZoJrWRuoiY+
JtGoSi1IrzkmHLsRExCREqHX697IX3sNUBi71nYeEYEV9Z1McTvZ+cjzo4QEDRpF
6LUE8IhlmRhY12uDEHG0dhhy+UHIsetnlRt3fZ9nNb++cAWIHnZrsklp6fhLTULU
+Nyr05exX7C3tNlHjsrXTUj6k5bgwBxXDwC3skD4/P6Au4zWXxQWL8YoY8SIGz55
IY25dbf0sP3fAe9Ie39CjyfR97D43ZDKqobgzXVgW5j5Kt9jSiGXxVNOFhmbcSk8
nJ8R6Z8vIAZl7AvIk4mpI+O4DJOVxP5E1MXue71EgV1osWbwWDBesrjVfQzucBtX
UWrkiE7Vi1AS+73ilChiYyPchklVWuceiaE+18dAz/FfI0EFV/Ijo51EAI0i/Pku
G7l+se3HGttzFuBtAfvF9Iv/Db/yjaBO0Lz0CDL3jpa3/OKO7kv4wew0/x2Bbjz3
mR6sPpny14TDlhO+4zXm0PPDywrXNnOKnuavHtS2d+JPxszAmcYg2Y9VQznv2H4F
vg/5uGXxJbbNlimBOhpZ+ptF4B1jua1lQBnXhu3CAFf2o2HILqpJOmaxQ23XkZQq
2xwns6AcvWRM3vUcQN1NmLLETc3hOw6pkv7svr51pvQJy3Q+ZyRxgcgo/wdfsuT3
HNNEK9uO5KDrAOzhWsqHkzATq44cHOPeYIrF9UHQMqegtv4BIFBBNr27Fzo7+mHp
vkR/5OrxPg5E0sovQnCAg8ReN0AdI92uPsKcxybOpZ0VzSoQo3Of1IGtcsXftZue
h4ogWZwkV1leJ4B2k1tOzgkjH5AUdsRUzkmw0vUF48SuIWgfIkVm2b+xocxtRR4Q
eY85fz0hGSyt8/EEp+G7/m0t7vkNTArQVUu9hPe1yZ7xrh91gjSbuug1BmkQXnM9
DdF6TDf4jpqCbns2yhXTJM/ipOFaR3cr7lv87D1BvFHQO+GPvpTlPnWrWgvojCFy
e0Er3KbR7wNHdb5npoCvSp5Ncx+amhdt4Q6IfBhhZ6s7gEkMroyVHgSxgkRh8zOx
yG8jmYBVNZTD6p4tUv6BoI/SaeaBoLl4V3DmSzgMwtvccW4f4kOCgTeKY/P2kygT
IHDqymGtsEr/LdZF6e5FM7hOR0gk6yGBBCeSjf38P/WZDj444vJ5c3aNuzXSjw/C
CoyG2slOCgN5RE/mRHzNeMahkA/vPRlTS8WM0riNdmo4cKM6ZyTimNY1ayyhrof/
DWyDhus5SCvgxqR28tOPecmZTcIsaC7OJjBb4WRmzZ3sHqPbMOvAve94m0umcEnu
3W/mzKjzs93DZElE2P7DpyIu5oaph/WB8TDsRDh2W2+eu174cEmSlhK9qCWjPokt
IVVdAKatNYqQlM2ZVFgzq0QdkiiwyfLY5XCNoKZtrNAHCt4R+MK3I4HjnIraEpM1
7yaEnyoWWa5hnZ97TLylffLTmM0+BvB7GO/RQk0Bve5DyDczTr6T/G+ZdFSdS+Z2
AAQ7SyOleHMqDHNhHAD3SlcRy88ea7+/IiYE38QESMpg9GK7cjrH45cArfPHEuAV
vLPSwDH3c6+stxvKJVJ7xgO8ls/RY1/ZsF2TpL0FOkqvFvuXyLGmpF/2SiOUdH0e
T/44GTemr8CoRQNbyyYZfQANKqkydVznsgbsry4GoDA67eqXQqeJ2krR/FSaf02A
4qZEHfDlcCiHN2TtaVMSCwT2wkth2yOlEDaKPmt5Yi5Uvvh+HAVgu8H19TKKx8sr
GY2fr/lhwp0IyqlPAt9oTltbqAG1f7uUjrb8mOIACYAv6DjvNjKYClXadfMKgwX/
cqvH6P3rw2w/UJQ17Vj7hPEW2Yw8LWw8kyBa2Za7618z0667/QkuXWHKNSnah4Nw
/xB7m26ZQYdYjJYATqsX77yBYZzUGvjHx4Q+xdL/RhgMwGa9J62iYvt5dRpk+lRH
GTvqHGdMZjpH0ONkUqr8VvPIoHRYX6hYobGkhjqeTCwspQzxG54i/NA29X5SR3o2
Um+hnXKJytb73ngQeNiNLk7L4axaAWj9cZ5aMb/ZojkzEe3Kicfd5cMaw+Or8oxu
TefD8BMIXyAHdfIPSChIqlqEFF/JZdctGMEuvD+aUFvWVHQmoXVk65XtnTeRX4pQ
tIjj0A7RZ/b8XTupEBglwbh8r7mguvCmoNTH+dBYSAkKYawgzVDsuOliyORMth4t
e+j2VCP3rBsgEVDCTl+Tok0QjldV3KNfQpK8FIvV56PRJA4SfTcVn1XnBfFekS7U
BGy8lMk4iXTvVPcK2QK+15xIt4p3zeSAeoXu8g+EUTExxWEHRqBxVinc4AnbD6JQ
ApfEj0gH0vtNKa7UaJaJQWsQ6L7Flcefu2cCQXCTj7X64xnBlkGFAeom+Uxgrwv8
vJJIKC8hBUij/aOHn66/huWW6utm81JC7tT+vUwJVoBG9nEXgZF/nAxDE00dwLsA
5F10rId0AwqdB+xo3szmbqBv/4I3kRyw7BUQ26Iq6nN9k287JD/tboJSzw/s5FF5
tZoEGS7lhZ2tYu+JLdqCUeFsZVnXpJQMkuWyeJpeB2dzrLRDu2xEbteRkSmwZ0TN
T0TOk0pC4ID7rZJAV/8xxzSyxDO43eZHeOP5piYFR4DQbc73XrhIINwMSTh6GB1O
V1t5i4PuIuxKF0i75SL9Tiet7M5vZG/IylpmGC7ptPKSsOF8IYE8+ulD14YSPhx2
xeVr3/ppL28OTS6hcsRs8bSCiCrrblSfzCHgv3xl+yIla+6Ntx+UUmnl/30xZcN2
SbaHexBpIgp5uKC6A1zyZMArWDW/EpAoDJ/XArjyr+Zd/LaKGO46R4U/+Cy2+9PV
t//ICOfFaMN6RuWg93oRJyMtSwv9kJ7BMDqBL1gX5oFxzZFVR+gE9bjR+tpk9p1J
IVYii7fIbJ9SPlELh3RG/wHb3QD/bQ8Vj6VNediVeCHeOr0nZlYoYWTtXoj89L+5
2MIl1wo7NETk4aw4zdG9606AiBLFhdNLnnUNNiNZTbBSAJoHzs9W13PqQNyu5v52
kQxIIF5nH1gY3Z/xJ7UU8Y8AGM44jEnnLCr7ZCkKmeN6NTTPPO6Mo3UwciAIXzUh
T6IiyaMIa0sILFaWrmMXZxce5a0iGbPORliekFs7B3o3Nnt/rJLCoSpwVBGuryT6
G1ztv9vdmFEDsPrKrptXrTyF2q3sCQLo9aF4phdDn7JWoY6GSEX/b84TXR66ZoPO
F4RppEqXlxMC/9Gulb4cUEB8CQqTbksbZv4ZSr40GOM/cRHEYxZXjbN+HtF2XGLp
Fi/CkYlPMiZ1H7ijOgyzufSd2qxrH+BoRYLggvxcVSMw75PeBEsIyluHKB1ld9up
gZYBYSAPHWVvrkFpGRwBdB0O9R9KgFNwgGNq7uN5Y7egV425+qoS/cqkWPRP2Wg8
07GExfFU43IRfgCXC960uoT0IdU2yHhD4mZ2wfV8EpF+Qbs3knODLrSYXKCHeIFM
HRYxJJY5Ba1ouDjLouLXwUlGPDrzMaSxzuD4CzrYk34uWJgJZvpynEN3Y4cF5Z5b
kEMMevb6zYq1oKD/T9FESPMzZRvXMM0rDIKwatT5bIeVkYW67ZSdy6Bxv5COCJ0W
hqHHXxgiYLBgCcMzpBeGTGx/t4UCE0NWdZMdB0oe/JVleNx1OiX7jdOH3dyPKHJC
82tCg6mk4ibhDQjqv+FiwuDunnf3lIV7LXkNMedN5ZXujL9D5X5jocK0czBRIa/O
F1oGBNlQHlHx50Wies4Sp9Y8Ii1Wx+wpYUm+wPU7mFPakd7RKrvJQsE6Kua7etyl
4jJ0cmLFagAv719Wv/qsPfM4DZKCYv/F9aMqo2pjXHSzSiTD4nT1P4ehch27x7Dz
ZfU/90KmMTnVPv9i0w0mPvssv4nM2gixAWDfNUDV2V4JebjYfZGGCNpM/4+37aJs
Xnji8k8GZXzkUmUEaIs9fwVbhwRQuMRwTjb8riy2/DsCxRf678Cl0yQyHPYUIa5Q
LcXb8M1z1GSDgLYqS9tE8LrQB3pmpik3m4psLHZnWDrzyc4ZJp4mBCpD0kkZ6d9P
chYwqeR5/4dEb8O/QdXqA0USTJlslrEXOz2aSETt661IMz1zj9OF9aCLbJmuMDPU
MLF5/1x1+SB3a+NPmBCBw3ld6xLECvtBdFTyFt6jXnNG86F6sEgGc5wi0P5cfDoI
WYw+WhAcvEm+h68+QgeV56sB8fdnn5W1Rf1WhbEZzJhiUAQaVOmHv8krNWe6qJbq
TnNJwSr08ajOiB1zE5leEBMnoT9XsLHsAhyrkCRga9DOc+bhSUUIllE5w/qhlSQe
jtBMzDJJwPuk7hl0EPhZAeKspxi6eOhf274429HjHpfarMs/NAKwM1Ge3pZ1MewU
JiP+VccXd31mmwFWTkxuXNOVO5XAS2//4VIwwCCbkQGg2E3TYqqOVwuY5kb0B44D
sghX92EsgtLvu3rGoalFtbaAtoDoSTGLse/AIJEBxvRruR9O5+3GnxkjcX7a4SPl
rECyhgoavXSSHvEOsA6RGcoTH2tlTmiJ1wCCSGEllCzogD6G1JYzl2pxmGKqCPOt
814duUlwsQvtzN8YRBcrbeCmZvnt0zgRyWpnL4z73ZVXk5F0+JZB12wHPDuK811d
ykTt/pDjj+BLCeot5ktih3CPnK723jYx9pR81FDa5ev1iHL/egTRAc2BlrjQHgpM
YSgjcU+Tu070OwGkcqA75nUh1FpL46yh+VVzl0II5mid3ENYP4z4M45KPuSeqigU
p8TEZNobrZyTbi3wNMDT5v7Yt9sZNi0kFEAYTtIAs6WPcvhTOLhYImik6RcQgJzK
EWyICn/SezuaQD/0k1K4DFoOf17P6Lx3I+kw16WnwPtcTfzyfzNfLMViX7lWZPil
g5xZmCRcYV3vFPfO9vpQQB7tBnXY+4S8RhtHLvAnKW0dRRZ3LztbUczFswUnqjV/
Zj+CvOik/jYt6kQN9y3fMxMYwqPDpTjddJsZcXVPWFwkx0puNg9W/kRqsul9SRS+
LZFzadfpwv1IJ2iBpjxfEyF9YTV+n5mgOkXCjPwybpZd/K3gdwELtU+Kp+/Dq0Nj
sGfJkr2jzMQQGYm9ByAZMqreoPWaV3aVfw8+FMueOFCe+LfIgipIx17ZurkqrGaU
fu3JbjZbtSq/24c+MSji8MTGdQYJwuUYD6KP8O9kfkgZd37bVObg5886Pm80dUsE
mwYanxdR4QEpYefLI4v8ypBrQfHdTYWrg46DNQ9L1jjSYttIK0R0tfsST+6Nz0H5
zWe/aZ2usP9zY7NjbGKqGYlUwgCTRuwys6HjenvgLzzBe9zVOUVZReyqgy5Ag9JC
dIlesWDqB2nq20RC3bxSSPqUDIhVmBPXwRshUy8hRSUXP99AjZKzDwYR+V5FGw6k
xqWkfNs6Q341pvtuccHjwhxiwL/0+WTDITwNp+iEPdlb18MbYL6TYmNKJedtoEdk
EHzjGewj2KWAsno6q+o0IRDgK2B/8WDm9YaIW1o+yjItNvj8IqugEPGHmNj4GCsW
FmFjBNuVzYX8NZ04joqRCFzKbbyZQZ1baaGI34H6bzEcqkJz8zsypGwRXU4I1V6m
NxrUvnXZuId8ZN6v0BWYQfMHmeU3l0OSf39npDWxkYfQ92ZF9Gc82+otD2BsLb3O
nfUx/dWqmZN3kKP1aAuito5nCxb/nvUvdiu5Eax92fKumMACltasBtwcIQZt3dAC
VWQes6T6cUYCGMIvb5eWxIWFYkDouI9VFQYfK/Yk8wbHEN4ojSGuA9RvF1q86AOd
Bh4GavqxVlMHnKvMBS8x8t16R30MSjQ+hsKg3hVGn/P3qFCJ2L3rix43jwe63P+d
8IlmbelwpLeO5ebyjk2ZnpwgbTXNbizxo8uQCIYyECfenZtoaJYXuJj50X5mIO2E
3NlyQu1BXhcHKRZ85cCv6tF9e5JcN8QyTEwD3rIqKxG8ZyXatNRImAroMhuiba1A
VzFuAjz1VbVJAM0ohD8pguKtGfvnn2WxyO71jk50bWmw/a94E7++gj9UkYIZjOLs
7CoHz//M5NSZZmA+NUVtNGMZ+fq6S68U/HVsO9qgWiJYu0nDQmveLNGWcqD0O7Uu
lWcYhnn1rLDXXy9HN9wqSnWuzpCfvsaqpRAOQgDFNTafwf4kkILoYEtMMV6xrVfs
K1EhIY5WP6pGMbvfbVSapN44OlY/lOXlvZOfuhzN13w0m01Pu2Kr2y4K6d3ulpn4
Wnxl+D2C1n+uNnNtuRcqzG6LSBeTC4j1EthGzBcRywnBde6xWeX0EsEY2ISCgUBf
XBJnWZSC/pa7mTLSSajjwow/dyZDEzoulDvTEmW1YdlnQnwZhAaiU957mnPfoJeo
W3KjjHpBKBmcCA7db8/B4wz8ZBxNGCp0umhxnpa/ebeLhSGJPcgjEAOqMM/ffYAu
H0LRROY/aiyUrB6Kwd1rle8872YXqh5LTs6QLBBVh2IsifqSf91xDKefoj3cWTjj
1uheAVSs8xmrUz3LWZ6IKgP4nBMWTEvQ3bw5vWoEy5C8Kk6W9g1nHm+qfts02r1c
sB4MyIngWkxisz201CHfA6Umv0v20cTLX5SV7eTg2gKTWyfA2ph94Umb/qBjuYZF
WbY/79+58gLbZMkTh7eLhqgz8D5q85rR3ulzz44t142W47KWcANb5SToqd1FZHac
R3hR74hEWOf0RvYsdD6nWG4XpUoDpTPUdWusW4vcT+1sOzzC3TH+/+rH3znA1LZ4
BAwhGAMfYc62RAlcMizE43VUhDy5z/WOTW1zLGz2ZNAMdGA8nUvC+6Gi+pX5WP1S
DF5l/ORsasevgLzSlimmbbJaA++yHVCmy7dZnD+2CMWDLZyHGLe9msQ7vKSOT9cP
mHEixYPtM8Nms5C9jJJ6Xp4w6umyN0Rubt/Wv8Dad0R8XUONr+johrpmLMp7gAGi
vfz2Nt0/JbPyRvFjO1DqL80d8jco1SGZgB5g8Q12VcQPzmx+jDzZgSeueMzOpFf9
0ilQhIld1F9veOahoQ2TDyWKkDvQZo+QK5fLj527dokpabYwV7J9XOIcMT9WHRyf
ks8X2EyYjaQehaLYNL90A6+mbVJ5M9NP2RW22Z58Pf8uG0/lU3rLTEQl515/Z6t6
Wl7Ensa2UmTqTSgEGqhEwNzp8TmMmdXyBIi9rl2/8LpUH9ZfrWdiMrYLD8yk83F2
qVe/o9ALzfDeNniTlHJd/heGkX9srg+fg3wm7lWApxXb4WLh6C9GyiHEqjo1woQc
fc3gJxmTQyPoAbL+CyzvoRbkm5AJhpVyMKebXLtFJzLfZQIu1JsFFAwCXE2SGy0r
QtnBiYfYaRpgmWEZm51nlaByISG27STF/lCNYlEnq4OjhG6kjOUiDf2o+h/4Hls3
5c+IWtAUdBlWIi/fjfdPztIIRYBXL72EJbBb4fCZbUB1sk2jnoraKQMui8ZpTOF1
7LnDkoD39KjIazOD2Sd/0Xyg9b24KVMfVIuFDIY/7q4uJRky7dXO3wKSVs96Djw4
rzvM80rHSjY9iDbIUk2WG2W6CEmzrs71z8Gh+JsIarBFD9Tb9uLCYnv1/pgvpba+
yfTVlp91vDX6rRXCdlMEYfDv6J28d5ODNV9IHx3eKp1XDpHOcTch75HssoNUz/eU
qsCKz9+URxkMpzjroBBNP6JdnOz89OnUwxSDW4ZWhOTetAArJ2EsCMHk7Ll9wgzs
dgV8auK8YDXqPkCmmQizP0JuX9pam76NQX34ioIanYhjedrf+zGCDQwJTSqeOdhQ
2MLVWMV9yDXdNh3O8nUnO6yi4w6ysWO82H/seOZN+CgErX3Rl8F9xU8eukvB9i6G
R0ohXFiJqPNrCtpvZAEVW8J8YOoC9lkeKL3hH+aBjFQo5c5BKMm6sc4wajL2lOWO
j6iV8g/M7Vx0JK5Jf+EPzxpDOYBSbbmo9hN7Z5iqafZw0gBBXhWduoJaPOUAeKvl
ZWXLkGwNSayLF6Du/ANWskaDPgGePgVl99nvRCo2GjqAE5eDJwTQnsYVlOVqEuPp
VFWV5dE5SAfxtY7RkPDxpHIALPsua2cU5NWG6rj/eTBj5d8y8ozCLAJBco07cWhV
kB4HAPKk4apLGJo4fGfg3c/EcZYweN0GuFF+dBl3uUdvr1nUlR8ahPvKYmIgjn7Z
GRR7dElRRgywUPYo0R3Fk0FfhlUiJdhk1NdDGCOVeASdPDUhb5lIzt/8ansunovN
k3hJnld1KgJH/FvTglG86CG3uOgnDsb8Fr2tcAivAhP93GxnZbfNyEogfzQEbp1L
lYsQd/VIIBNKQN7WZMkNkAAFqRkgLwRfesf5xR+izBPO5mQ4XdL1Vds3Kt/zfuLU
LmunLtIjwPYLNHGUVkt0q83Q9MB8kO76QNDMZZwUDqU2tvKieC+4o8kkFVDlRA+P
m86ubEljJyVREnpq6eFhyluI6PJ+ys6Dfqm/pwQO8+C2/U/sQLqyHnq0G+8XEYLt
2DqDnGidw6pjmVBXu9nQJ+QZZp86VlxhkQZSJjMq1aZGgqhSdqekmCXPMOO2ghIE
DZxDxgJ8c8ZUMin10S6IRuueJH5ZYpNXAYamAarLpVlcGPykwi+ukk+2oPztBzFP
rDm8kBeXqowaxJuckKCqsiiPnfBlKo0fT5DMBdVg/0DAwt6ZX3tu5a72Ecxs5Uq+
BgNj2GOpa5xHuZYz4gf65kgH2eYNIpGEeUpuCSW9FXKu1j8hGUJEWQjQjczFUKnt
MR7FfZ2syiyEOSzv1DN7yhgNmtnhKa8ww+o2z7A1vZlY9xPgPSWvsNTbsQ75kvg0
h2yu4ENRXUPgFXaqp12+ka7EAhAhWb2CgkbJmh0YTlsBPYkFkwFSD5z3TvJ5dvlz
oyWqFSof4jY3C7agM3GJZ8+koQysLhTHCKAYgI9rpqFAxbJRS4CPvPO5hND2XEQH
8sedzFG78vlEh9NDOynuyp29dfN9kualdg/dS6hUPdpZ4HZIS2wGkSYXclx+njDl
ABtAjPJhh3D6KH7H6Rpo8zDErH6+4QpcLs9a5kenxZ6Y7qIUawKipKqWr7v6NTNH
Y5dltv9fEm7EFoOcvwcH8a2uUxNiO6Yfx86Fx1UAh/mFdGOhFH7NhR5WGjeU6AOL
2WZL9J09vmFKkeQ6Tv0t7nSj2QKOLlY8QXJqh27xXFd/FPnSurguYGQIj9/rDyT2
Z+EYrIlub+LtiBoo26UwkrUu93VehbpgEMCAwJp2E/4jgPVzcAJLvBSyg68gAc5j
keJ7Wy22TcABmi9RuWhOx7WlB1kxtG3K5hHvHw0J5IhIh9yJ1zJS/aM3udV5zWit
BXS3VAIjLFQP1eDcsMyM9iIOnXyGMmVY8Kg/bj+yuO4SAWbflzO+rrsYkLf563Uq
lOWjkMrZ4w6meXjaqMUuM5oKcTBvrD/nMrjC6OyDP1SmttivbOPlNxXLLiHfgd28
glb6/0tOA8kQQJ6Kw0+FoJpaX8SIVLfu6NJhzQGcHxP6CAIEA4lnNzogKDKLykwr
xdENYFNe7awBEBiBLh1E0SkJA7cAuqwUwcTJec78sLixpKmazPEDUr8NHRHocjbP
/o/ahNJlwZjsce62O6+MbPA3MfjEyl6gYzo+epbVBlQKSrbsELLAwSiKl9KDrzTp
7Y+O+E0tTmwj2YPRJkiKxsNXaEMdatHTqtA+P369WtEklH0XoSAd7hnEm6C5drjq
Kra3ufv7cigdxcaoHlg36/7JRpHx3+Vvd0Ia0kK5ywaK2pN7fBawuHPQTlO56FPL
SM16CNoWblgiXnqk3VkuqkyPqQMFMHIImhYgy5nQENauXh5XtsiwfUROThBfKJVL
KyyJIY8l9jVBN8Nb/hVqt/mCybwpgcwZBdno0c7lXq3GsRR6AYAGhJTXkF7vKTNp
4hPbPGkax2LyzLgzA2X91M+U5mBRPKfqdeZN4skKomWc+t4yBQRB48y2cEyEfHfP
K2CHAyX6LlMOoOoX0p5Fc1vEfh1nvpJYwwUwiox6QApOdsXU5s0LUJtwatTuA9mu
piPLdT3dF4z3+OUa6+Z2jO2p61ZHw/40Mo/pLlJvBpF+UxV0kAiGmwY7PSLSDc56
17EIWQV0qkoe1v+LwJJMiqTkQcgy5yjarq/EP9LsTd1M8Z/ay+w7ezBI06DKVDvq
Tw1M5V87rMsjSS8/pMUX7V1MAdKub5Ajy+tWKnuXob5Yl8oVgXM7h4GNcn6ZPMsF
uuYT+nTCSn7AvfzzV0+9vgu1IPojBN15aPMdfWnOxzrwEJUSa3cy7piaCQSbOnzb
I5xXwMtBP8fHmX1e3fkh4wxOX3bJSqiwZIvJj2DPB4EdA3ml/krh7vPxuecRx0It
8SbauB7I9tfW5DRUWzFrwxJurFvYwyG+UVFhTDArAycReWztUpyWBpPVhkOo1jzR
GFusJH/hCuqesr12G2iGLFM62stuL2n+fIIAGDk51YBvTURkzhBtxuve0lZizbdb
ma2E6uEehaEvQPeNMVJ/WxhdVEU7fdJibtOoe0Tg8zWRID/BZCwewdtRXvZD+GaL
qisJ0FTbGZJwniDiH+dUKrPc+JiCKOwI5gGQQzlSEugJ7qVIIIXWRqrkFsycue0b
ySx9omHUpBOkOPywCCMmbYrn4ScV0H/qRAnXyQdUeGD+xfeNo7xH7snE32bXQ1IN
EJxK6PMWFK5VpzxtxKcSVEDWnoI51QjS4zgawZ3ws7AoyivRNe1ARLTrRCYh+rCJ
vNqEyw8XGY57VIclNBkT2AFKsI0ovyW6ZN/Rr+lGSQceHF+cG7iQxpTwSz/M0RqY
Hm7BmeqXVMLh8P53oxAfPcQEqezzX7MKJuYxi7RCR7hsuGJ9iS6+Hf6wIZyE5rTq
vK3U3N3j8sk8HDbKxuNeaTv60pkVR9+Wwac7rgQKrobk6ZNuII4UffhAy9G20Xbc
pcpCFKyqXb5nlqTdtnScHIMmontHWSSF0NHbGF1EKrbSIUmLSpUJ02tqutDoCxel
+wtmz+SsOH5ceswApO2eTE3AroMAMP2AcO2h3wmQAHzS3TBae+DW52c0wqKWdeH8
YAal1x2TzAhnGIVMsTe8Y+9vVgoW4vclnRwgHjzoC6aW+tVFEeBfqedYVO6SCm1K
Rm+IGjZOEIi9iwBy/2yq6zyfUFaWFCJICU05hCvkBrQCJBByfQUmrOsuP6oFs2mR
lgQVXKI6oOuyxaTB/NLNBYfgXnDmKfzQXFN9QvxUgH2PnVIlTd1qtgJJ9sDE5UHb
JyWQAs7k/p22rImqnEJUdFBTBYgPdTbsJypsgH8Kx90ChTfxbfs8hccZ23LjsIup
2dmFn9yPSuPo4ttpIT3FD0nu6WQ1Ve6BQFZH4PedM7G88Hhs+bGYoumXFqYdTWrl
FI8LQfE+7Qrk0FmMJ86oBnyaNs1FqlhCmCCEmbMC6I5Uqn3lVj2+KV6sooAIcEhd
6cEwdTQt+iavEovOo4BEVseoPyeAt40Uvqg+MnC/rg92TXnSqGAgK/a+rVLL96ay
BEUxzMyalprjG6ph8Hs93XTCHa2uqN9TZYwoSFEdxUgYzdkKqh+Hk09t4EhhO7RB
9XcJg655J6Y6wSfM0rVpZt4ouSDEU2kG+3zIYlEzxsbqKtrOEegC7TL2oXjtsPKy
6pfryar6l0aOvDvlkzTWrWEp1V+BYkdBdtn6qfeykD+chr5XAolwucr48xISCKDm
Fpg0lsJYxx1hzfKyQ/df1xOfJrtLF+t2zMNnMJ5kcOkiVyrRjkjrE1k9EJbgrWTN
9+0gkw01yTtqk6pVldI9IwStfFfS+mGXqQLxin6edCcaEYXnEY/v9YBhHuBHjHNb
ZB82jTdcFRPsimImsUgVB1oS5s4/TjoNJVcIK6NhdneKaDAcRiSySgE05iPbDDLy
wcDBaf/Sbxr1e4LgOXL7mgrCkEdmMOVr4oBJbGjNeShXtxlXBCsx9KgW4+PnHpHb
eEehScHOzmLHprDxc9HMY9lvdv3dE8IkLgnuRhuNr+rv0fEO+4YLlU94HbhLiTCW
Frtj4Nm2hSGLJGCuXrrAwXTC3+AZHRhTQ7ydcK52+wwnkqKqBK68MhTYkXtGjpAc
51vcVp3FoKiCpn2BjgKCmbQP4Ik5Rdo+VrQ5s5U77RUYj2Ik74QX3ULL5Xcchwpy
WAI7+khdePFDPm1/TDd4yxC7gQiactfUowwPaBw14Ql/dxedx+DqCFfJGGzadF0r
UBVjHnehyKSxvlywY2g3Q+12EBRSiupGR66E9G2+GV3Yj771/B0d6N22iXiE0ijc
gyksS5HQz/U3QbFbaNULhBnwGguFyT1hiGyOGEsxlBIxB9T2eWC1Dv/WhpvLgvKf
IJaNqvlf0WqhcFCebWN9WA+W26kZObW/3SyIUN8TBewvQSyq/kEwUTEIfVkRs1+x
7shmN+lMa0LZBFTFedYSJYEhLfIgYTSIYXDMzaDPUqpZJujDuN7JUgsl4SmxdfrN
twcnFa9Z1e1PpihWeVu5iCQZVeQ54+UetMLydGmKUo9H+YjsNWRy/pR9i7oaMmkD
53J5DIQspCXyziHj9PgipUU2b3zqxeIboFN5kVTRqhnT5EXIt2Cb7UN8gCepyZlo
ver78tvKP2Kl5YSgTOm0T77IE5u/vZ+N8Vr41INvrdzhUg4cueVQ775jefPxT9N8
GF8jX4WSSUqpnY1j3+uaPWZtluf7tfCWO7BwTLDbmqQLWm4FpJ7yHbKMUdkpXR31
ut8vn8pFzgWlMe40Lt9spBxBOwmKzPIaLfK7HjbKWdwg6qLwvycJgd70l/hLwago
Zlo/oFBD8gAJ27Bef5Xix/KGz+9vtHwnrK4M13nV8kz72fIVyIEkIVP3P5IUjFZC
I6RAwAUAQh1R6Dy0hLq26evs0Jz30JfUnhPMt7P9ZdcKTRXQ7/AtLh6g/I7UTTKZ
umP+RjUznTaiEFuz97nHRIgIp5Slj4pmDk6i4/2ZiMjCMn+LPdRYBNf4+xCW/1Ns
CS5VLeJiE4kdaGMGyeTBZSpa7e+cPElSu2qgiE+Mk+OhyEkcDFeIiL9t5D3nEaG0
DmeeXwoHGSznz6H++dvkpgdQOUn18hHPV4uTf4bW9RqLZfPzMsOjC0TbZ3WKMTCK
8gfy8xiZSCYLbbeEDgZl+y0tU2o7cJtDkXDzMGCTdqNqX2sjtO7sCfjljVdaNesC
3/OrGblK3s+cXCYoJz18Z+sub+J08FvNWvzvpGMlKo3rtyaGeMOA/FOwta5WFJBq
NnglyS8ns361B3AHjffSHTw0cH/Ua3FvEUde6sr7B9lFhEI81pBM18pb6XM+EmJc
crHkHUuMQboU6dzzOMVJUplp/QkoByiNeWzqUaUvjB5EoOx0lThsx1KGFcKRzwng
M5+P/omgu1SkFPTFiIhQzjrIRt4HblwCn6Zf5cIBG8Buj/ioa+6aKwm7iOas9oco
ekL6EmXURDO9yf3TfUfO8z1fEzUPWbdJ7cDoH6azU1wIPlpmvxFIcALmpDkDFmr7
WqGRdqUiNCfPaM15iwFIeV7kyJY961p/m6CVucgpa1evDM+mw23LNKFMCWD6VLa0
g3dhzDda2EpajPBBXAdcN0URix2WEdn0bLYnFZnuj2A/LzrQW4jLREVJMBhwYmW7
tjIOZVscsxm2j7an53TBTkyx/xl4q+3WnKpuA2a9Smf0jVJDseo+Bp1L8yKI3joU
FmiM8itU6+N5tvwt16T25Cfc808NuEfiGRD4vGHOkyXUETgV1seMYKwXZRjeiNMC
1Bn/z5fiOI80F7XigxoaS8PL+q/X+PkzFpu9GSpYreBZkEUD3MCGRPyFVyrrlg2J
XAx1AwoThSV9qSASajCMZ5vwF8mA4zOTfpQ+Bq5n7TYUjTNKZnVrFNWTJaCTF9da
uOX7mJvwhIaC31+QSy+xkW7rymtDtqIojsj9fUssMbazlGW1ek7GohttBJ5w64X3
1EarryjUuPJQF5jhmVar86P55OpLz6JXyYlNL/86oJUGse55kgXixmFDGTiVFJV9
55QwEa+4l8He/4kA+rGlevEcXF1a3VQYAJcHG0Myo9buCs/VFafIu5jv7y7yal2Q
l308N5lh9nvyxG5ztGyowWzDhuqbtifo1+dmGqMtNoTrX3Q4H0njW0pihfsrLUBc
LzJiTj2qigMl6FSH3Y38QmiWYznDGqOO7trzVE/8hX9n+PMQcaxBDxUhxz5Kjnli
/he1WmswEkHNOQz07JZcz3vMyIE++v/8ZfbpJhdvGfBhhHQ30k1wMYVb8iAvO0oB
GREux6leXs4vAul6uP4UZjFkS4yrBDDNkO+P7h+Qf6J7CUPPYqEu2Sct7XEPzmA8
6s0IhUDxnYTOSy5FoO7u6PPieDoVhSrVpUa3Omr2ztP65NcaezKkM9+/b0UixPTl
fxmHRm01UD5PnBj4D/CCH17Ov1DuJFzkeH4uZgULK8r8ZFnQNt4b4FDpDbds04Bn
EXbRbsM66dECPb+TC/+ZyR9FKFO9AF8aSVJM1VfyIFTVI9jjbW3Wl/uhLa+zZYmo
uX7pk1ZvxJQ/mZfSSKtW500zt3qW2AGcSk0j46OwtjUwXU10EDYAolepkhC3HxPB
Huu2Z1bQk3EUiyeUoT+9EakYNCXxQOru5ftF928SYW6TnwhEAOOhFbFTh75g9wgx
m2UlgM0mkhf7r0uTj41VqHG7blTJTdgYlcfX991q1XnZHPPzBsGrdx+bi3XmmBwj
a/QfxyU3HkT8Ae2b9N6CsEfYy9hOPeddhJQzBIciUyr0VoAQi3PoXNn9gQYc4Ec0
YaxyZ469yyaMwDmmAjzPUGSevmwyUSUsj0r834Az1+Aj24S+hXYbp9X+Z6fXu9/2
gQDoYPo48u4+P4O37IctBAboU9PyGcMP+M5tx2Wb8/ES9Yft12Jakth2VnjlGbUf
rWYxJ77UQ9Lp/a9guAB1bI5oA2D6q776WesAhDmFOhHzrJJ05IdekxiHPr06G+q+
MlWMFSsQlCz/PUubAfXTnsowT4OO0Ud5BbL9eYiL1tnIzrL2u4pZnuh96vl+CT1j
kUWos+nLm/6k+Fe9braH6SsFXyH0P0tZWBEPE6bwYmDDdcjREv6wSRpa1rzgywxE
1SS+wfusG38pLTOhUZVf+Yu8m/3rK0anyBYJ7JEhBesC49YH14WS2T/PozmLhHk+
XisMEj12GxSuqn+6PZkiOZhaA08mrNri1bKBNiR/L/BuYWHZ8/I1qI/+z6g9h+RM
qU6fn6wpvrzUDLNm9OoZEiwmLanr7E/DLV4QpVaOdpuYkYH4wFj9LCuNvVSBcD2A
F6SN4IVY0Ev1VOBQHYzZCkE3Z9u7SwAFXE88kCbGu0SQWKXX4ZyS82XU8bKkhnVy
KODWyyur2SORThGzIyoVpMMJZ6HPWXm++TTneyHMm+3g3hPHTG/1Ju6LKbWI/b6c
sZXa1wTmAReVg5p532LCdghrpFwxRT3wHKcNXxG6C/GVJTGEua5dToMsBhmzWFHl
Yjr9RiR3vrMqYaTOrH6IMs0ykcVIoGd3eUYnRwZkzRVCT47+vNwXV0f/Gm3Ddcjb
VmM7rOYGMSbihZBKMU1E+QeQJSPhq34NeKbTFx3srtOFTdofXFc09wByiDeS68HV
m8ZN3wIu/TWm0BwrpQETHo6Fd+VFJGhdSuYcoN3njQCOZtd1E/Dg+grmXWdxDl2A
YwQNt8S3T9k1KULSyygrPnPkykqbbsjdAhNMgl3rT5PJLWTXANib8FKAlgM82ndC
Qfj5iCq9nfRHkn+/UtosIVsQOulgc5O5EdKGnZ1R2d3d4j6a6N3t40mj1lCBITFC
L/HBUiKTCaYZsX+61f9PoOitJtPbWBmQoZqpHmEbH8uB/uq9O+oOvuqKpMMAVnHa
PueO3i25YYswevIXPBfX/hqPX8nQFvD+KCXiFxOreW637UKOTzOn/smUi5QrhE9+
6KXimPpUBx4J1u5M9l3d9uYm8cqSiqPocoho4HB2IDAfnZoUiW9DzeEO2l8k14nP
TjbnCJLYGwrkDF4Iu0KrZtsMNIK8xf0ETSraDF6i49+lLghfsSo3VXeUbLB+r9D+
sCSu+enyWNm5iyYGELqSv+t6uzCt3fHW8TjeZOUnibFbpbMrLwOBz4l+oNNWRgd6
PeTcR7hrgTlWLiRcrJU3fF242HdGnUhfpo8rwBlnumX7Rx9nUbsT5mbeMXa5tAu1
MwVkOGfKobCXTRmc0oXZjKLqm+VRvIY1hX7vNbhP8sUriEmSIk83mWL4J8/sB5dh
a5as93NfbogUmolpvAtaok8vPxh00r+1QFI9axP98su1aG9u9OeIkftMnzGxqOZP
aCTnUmjzlPE8EhOiIxjg6JhX/AnySRFSz0nMdPKPhKN3Ep2JI5l2J9yfZplenljS
yjoOZs/3nrToSP0aaIkEBAsy3EJQyYjd2qbJLi2F2sijIVCtT6MCT2ad/pAy/nc5
3hsfZ9/FhaSxXJG53cQ48TLWGt4V1fk8I0sb71ONSV1r1lp17g9S36PnZd330lyT
3glgO3fFELffAzfwRv4tZt6Qiom1PCUTAwpKUW+K+hRO4egtNoZ9ClKEbt7tZJh5
U93ZoW2lgul8JWaJ7oprxf2GdgQXdXlSIpv4xkaqUg0Bo87V8Z1g5lZETfQeCZ1R
LmfmfFl4TeJOJ8mPriQewwQQ14m3PIM1N4HaAQT94GWJcTrf88TSlCfZBGf3PZ8E
FXUMjwnqx22hzf6rXJRMxnmtPg4y+r5gSzqBAZCxDjbLaj3l4y4hhi5N9aFoBxMs
ePqVAOwsbz+lQBsle0Ruzqm3f0Tkv7rYPNdR7xFb2yWQ/kCmGvwGXyAv/RJLsGJJ
x91x6NgbFFSD93Ipn8JjL5CldCIc87Vm/tG8SMCMsE9aQf7Mxl1ZDKc1n46ytl44
9hi39nbD6By0LtRqnsG7YcMAlZaA86mRMw1Z6LU3gql08p4tnXrLvfpPN/eyinBN
4tNbdJGYcCDEqi5KEkSMj3hCdfHSnPxZk/HvKKLfthQheL64A3byJksl7GpFqd2P
Eh1kb7vncnnqElHN315YI9i5NDIAGF0lVSJ/+QUks4RPmdqKCqlAS10T8socMc6l
kcBeCiLKMSRu6jxFM5XXYwtKLUAehxR3FrG4orKugXQ9NElSlwz+OVaOjwjnhU2n
Yx+U7Kt8xlgGpS6jaudaH2D7TD8NMcmYA5Nj03ytB0bcP5p+IvtDs5JicARnORjn
jgZvXwh3gF+jIQYJ6xaiR2C+COEnZhKaZD92p8Rvs/gpZuLzlJko1ShhYn4FNX6C
JnS03Pe+oDuR7ePaM/So4/w6mrTViKPmABZfpdhsDI8xxZyX5sI2aQ2+hD2KoCTt
q+7Xp+SBg24fNFhxl9V75qRdEzVgFonR9hwIIPzNj3czpOZNTp8glIIWPZx5ptn0
tViDBz80oiyfzMUajB0FEev/1W75v+CcADjf7Do/l1VOEKk40O0BeWNaeSXSNtaG
hzeuwrxv0JgnyDqdnr8iOGGVtE/Dv2CL0AlkupMaWmwcBpl1msmi4O7d/ryjNMt9
HuCQeev7OeclAb287MTjdGLIf3X4Tm2Jv5kAiSIRdvCLl9i2sG76Qp/UcEv9s6xT
clu5aca0/rZ3GcVCn0QNlVcQL9mQ6WOxP2H+iMmd2Rh4rPdCx08IaFnHOhPFYSRL
SMxMynQig4flQ1ONVOQ6Uba6sE/OK6swctB3e5ewcg+ep4zrmZxJmNa6FvnfGaYS
Yx1jwEDoE8SeRBBR/PMtgCZjBWX2ioul0e9w6qtyjSTi2k/uvKw95ceAO6/I7ics
D4VbEI39Bua7a3B5egyc2inNoWadnADxv8wFFnwwuHhl0AUSOp3D5VZAhTorRo+c
KL0meVI7dX2QkAGifmkVMycseZqwCKv+66bfgzOm6kMvKMB0ow6ZTMKAfbpzPkeq
TdUSWydSr5VjBZM6PzU+j2DbkZMOyPiP+n97aHPqs/OEVeXw1Z9oK+9yD9U/6dG8
Y4b2LedDPU1AcRPtgVEqibt4KRt49lVxTcbyAAuMYV5ewOxIjZ4J1mjy/3LAZyxT
jLFZM19WApGHacoFPD92pVUxlM9px7hjnRUCCi4DfLsV8xprBy67HNqfUdTU8+67
HG3DAT5owaf5HCj8RYDJbAwVqHwW9ZNDVP4dCIJeWyvqSgLNs+BJehAbeUS+y2qM
7Cr1kAAXnMAqM5EhrcJ80sRrY9p/J/S67QMj+F4f27MnE/V7IwejVpWEfKERwuQ9
YpOrMo6JKtrtCR3CTB5FZYCNpr/0I/rZSwboRRV/bubXBdP2i1b4XQAsclH4BwY0
keqOOcVuNuk+rXiLANTmFcTucK4uybZ2jN6lifgSHY0AafVgUrmuslWD/CJYcUGx
VtINkjRmCNibG5Meizjqrnkg6DTcdSsJgJVvRhol4Rm6y0OWaHoiq1DFjO2H8JZH
yY6L4DdTPGvBkv84jkojqemdGezfpS2PVdKpU5dm9pdr7Ddw4O+5Mzk6j0b1Xj5w
J4F71f+TZHGCzwJsyp0BXwpnKH2FhAftL5AlCLUzWJ9Mr9WaaoNb6Gt1RN4E3IcY
5vFH/YyA2ZBNT6ZW0TfkqkarlNunFbuyk+phEMJcurLj/3kwZ9VdZxQBpQnFCFil
lL8ecEUT3MeDh7Vjp2k+fbESJks5GYLbnDqM6F9pgRNP0NRClUAIAByBK/nuKRU3
y0ygVDXR6/KcUVZcMTRwRRhH8EpIy4AdDVEb0P5SdtGewwBabmc0vRRpPQvNoPlW
JeLZeiY8r0xTcaLwWWOdt89gcwsbA787vSfII+9YTCLteN/ZGm/kbAN1V0OzU5ai
d6GDrm169FrxdCnVDz2I964uEpO8iD/TwTOgTPTkFnCeU864Py8mnqh8QhxrzRaE
SC06SWaUnXJf9EeTlMip4ZK540xgSLVsmhAvS9N1Rt69mn0+s620AVNYTrUy5LiS
pSCgiPcO+pyT9nPj9TaA4B8z8EQ3rB4vFdf7espCZdINqxWR7ornUgSBSK+xJ6DK
VIrg4r+GiZbw5WcgA5Ig1WxaZz7/I8fuYcV6Ax9HRi6pTryhNCWvbBsvHKXy5Zn9
4r4hDZvqCAgFLlUacgiOfEumyGmxYIPcBvVs2kcYJHb3qXVhYYBvW9xEKkfIh0lZ
6ugEsxkSXjAbttg9S27V93Mau+Q5tJ1x0HcZy8A7evtU4nYVkvkXKuYuGaB3I8Bl
Lrg2kriWvrnAgMNtsAiav6UVv3VlfoE+2bqnk9kBxKLbBJynEGggN80ALrBzsyBp
TcSKpFfhX1frTOjEYAeEbFOmxwJ2kW7qEiTeN6E24qENH0JU/lRgeEJfu7uwa7PJ
kWcGdw1EyGF1hbqnIQh8tbsgwjuYwZn6Z5PtAsbYpCnJBR80cvCB57IV2mgVhWtv
KhW9QlvQd+aD9dqpLx9U9tznTP1V3ancmb52GGN8ea+6HbOwfqvCgTA4JSdyXMuK
TDi25EMOzYNRNz6YGC8JJn/H6RXzNc9VonuM56YrCiOuCV/HzYrzXwtmNK7hYBD6
ubrN3b0UiY8RDjtUgar3uZoWd8KwQacQalzOHa4qFzs17znDnJS+y3lKYA5sPvfh
lYDTrg1BLKVrDT+jLlBGoqbAFLLaQm3ctOZ6issr5w37Zi3Ab9pGAdHozY+uaNXC
wFWPMDwhMHg5Fe4MXlZajR3G/IVi7E4w/L56dqQ8ht5SiyrLaPtRJR05ZKj531zW
Ye3tPiLtbTV1qN51UXzL7DDy9OG9pjxZWDQ9nFYb7Wov+k8Fr5QDiPunOw/FuoPC
vl28zZaTRqoX05mcNURpVE0kwOaSZEv4Ir3ZZu04JhJRNkf8c+7Z9JTh+bGiHhey
/rqI3EX55eFsjLqIOoAZhpwFd8xOPLwQ3SK+vtUc1xcviayc6vu7BOeMscNln0Oh
z/qw3OjdtlrhwtRNz3N4VF/lWnrVNjC4kYnOpVep2qNppG+FrqIjjnm8z8PUhQVz
R2UYvlxAPoy/8eK6zv87cG4gPU+4ndgHMxjYG6zo8W7Fo41DiXDPG9ur1ptWgV/J
kblzp6/ooruRO1EArB2mjfzIQuZ8zDp1m9ovg+ndydeCStwCalHhDWS2tv64yBDA
XTbeAEC0PYMsqeYnaNkjnjrKeQlIXOh1jrKd6gCNbXgqbPccchOwJu+pbIrccklr
p7J1y0TsU1V2ESrtI/JF05CIT+W48iO6Na+WlPPNqofASJ1sWeDhHr64pNiUDpXS
QyWR7eOJCugTanYURIvRIX/EFbHnTYGCG+a3HI59rPHCKhchWdkeaftuYc/NATnG
YiBdDIcXKb8+DYXED/jQVL0VSzRJpeeXAycZa69tiYzmRautNABLGoMTlIn/p8w+
OF9lssqoubAFyLmZoJZ9FFKaVbPFnKcNrav7+H5AneXp6nWXKbUqcA9xDLwZtWZF
ClW+6JHA/9SnWANbDEPTuMzN3JhYbG0IFIib0gwEVHmZPL5RfKEjQeJRxEbTngDz
KvAY1JybkOd8QbVbI2QjfbaH2j9kd1nNp6sfHvuLBywer4oPXiZGUIuPIyAPaff0
tHyBcELvIgXcUYx5VuPbqbsYM6yevMBNLUGB1bP+X7TGwN7Gz9CFV3nHz3Nu999S
AGpIJOPSa0F4BNooISm5cIr0PzNwZncEL8CYnq4QOUY9+rExgFr6zhF6Kc7rOYVt
letcQlvGHzhHNO84F0mmYSSundnFuQ+9yBfxXvUhAqijfOf7HNceCv2Zik197VvU
v1pjeurMJR8UJBWQFzx7ART8S80TaN6e2mJQHj9pz8kSjFb8Su9/abzho4HaGU+b
9BWvr8UC9zz5D43luyZFI86dEikw66A3LtU2ZUQEkDIj7XbL0Ok8Nt1ASHCiesLo
xqK0ol+MTVL7+Eo0w4YA9EjVTk1AbaZyqmWtJ39GzFzm/eAyye/pVj/fMOccgKLy
bxS63wTxPw9TeV3Q6LsUWrhySnZEzSL25SG1hDlkTgKakbCVcDGg7tyJLoxz5d+b
r6GMuY0zZOyuvPUHd3ShP4HPLIia5d/yfkurA2jEsgGkdPJNsmGmqQS6rRRLtuNp
pNkUqigHcO9MktNGai7uqQwRkr8/PuI7weVGFdbY8XPvYY2mNao8LrXbHwddehRZ
LIFMzejY3j7cFMaBFeJ5nyaIa5MjtrmqMxVYwJCN/Wk/+0jc6+1SDjEnZhE6aBq3
3y0+YIO7td2ffjrzxxT/9SnonKiXEmCcA4wid6Dx28RC1+8HAPSzO1VcUWdwj3e0
gqiA45RA9hQL4mJ8RJT79UOyr9EQZyCsckvIvYxCbZ9GbvKAqT0YAOcGaZKPEpb0
HkuOCORScK1dEbsaVOf1qowzj3kUjST4yeK2oaqK4b56G8a8fIQmoPNiUJPFDLa7
93CJQaqAzMJGX0WvEbJvshMJUjof0qZ6FXQwpVtF0ZSlgRXLg70DaaJR7i/nCPjx
qaNr3xQ5te7g/HizJh5rn4Hvfy4tXbjKVGsM/hy79hNttF2wWZofGqVBrKSea0Yw
yepxS9nLsrkxc8ca71Adcm+VB4a70mDHOxcs0Q1wYoT63gGZA7yZjnMPmjZIXv0a
3f45DTERZbhnUwIqoRYs9t1Q+s9nUK6h+KZXRA8/6FtbRRtlr1yHhspGehEnr13i
ElpDejwfmoG/xtkgSPn9AzxMmRT9iasoTX00EUmNaY9LjUSB6bKbZ5kTCxcuoLEH
DV1IQQZYWYhVrhN8SNzVqVw6NPp1vOURusk62wDcoGEXy6xKfVoztiKKGrK+NmHn
xqQA4k5JurPE+3OWlrVasME8/d28zrIPCQ3BUhriCxyzipqd2dtae3LsqLaK8eA0
lW70o4YsbdNJ4ysG7vNSx52mggUKe6SrRACIaQ6BlIzIWbjuIIY/t5Ng77i0D4id
5w+/ZWlIXQLo8B3YLeTmZpAXS/rVwdzUocFcssVsHTL1rZdkfY/wov9XmE9R06bI
A+atLXg7be30xpHxwiF3Z6SNEBq16/kR5ngUTxpFBQWvc6GPf8YHTWJSdPXNnezI
p1SiLkv3SqJRUoVK4g7qk1S9s/z0cCTnOzyODlxA5f6l2yCJ+y9ichRtFeMpt58j
qvNSDvnbehJOSeJdoHgIQnsxb14haw4oA1BFvl7nV5RTLdwaV828PsYJw+ePuYFU
+sZRSJp5SdUnDuuMAAl1ZjHEdRRSSIp0on7ahtZAlfQPGPFJxKu7B4LVzN2iRhAW
X1qgULU1YnB5q7xmGCpOxj6WnTXtnxoZj8OHkQm5ugBTeke7L60oTS5mn8s1rePQ
dj/hNMwQMyV4VkivtOEpcnsgjY4qMZ8EDNj92ikUn2c01FByyrxnAETyR4x5kPV7
eVZKo9HBVgIPEUpkx94wQeSak3SLkGSyg2r5GljEvt+l+RBo9PDTywDnpDRDOWdM
pjzMiLna3OOHSgvXUNb9XEeJX+Plx0dU555diDOL66jjrP9KyQ+JNl7TL58bRt70
LLmGtFiSIgEnc/OB5bXnW01g4bBjs4JhQxjwgVTUCLI7EszCwyeIHoy0b4t7TFr9
OWjxgPKHVXyndS+LiiBxYCREWPbWZJ4n69fQyVxQjA3L4+OSglRm/UqwtJrOtmyj
KeQz4CZsn6lqhemkz0i4XkoGjypaXXxi5U/ftRvUrIdf3kNgN1T9qKUKV+KC2psW
2tg/0CKfPI5XQO6HYSIq4fMjTSqfLEmYbc9l5/Pl0PsJ9NKXmUc3/VUMhao9r3z6
DUAiEuYIQynltzfUuG4SuNmbbHyksM4IeyPE+FitSX+dS+X3115fk1WxHcJ9gj5w
6KRLa9ScLXL/b0XITXWg5oe1WKREU1p0T4GZSMn9Kjm8wXqjIX2QDrUeECWyReEp
HaW7V0oI7wleNset9zegW/TIRpJNumc9eeqqoX7SdLwelQn7pVlrdKHmk6+MSR6p
3FNi1lQXAUQebcrDl9wzszFFLjUYS9GmR99QGVxAFjy5xe5FF96KR/lRrodjSmSr
ZZjB97MNXasAliE8xsO+JcGd0mRnzp+74I1L0dLb+6CPalnlzae4Tx+f/HK5ED9u
d3zK+S7n5y5tddQ4mfL3ZRkJaSmhq1sxFuFhp9Ud2O8mrjrgHXlEPZUCgRk/Xajy
p29bOcNH0kC3Pv3tXY7ZlPTD7/oZaP1jdh0oGWKwIr5QSiWHWHGrGagBNAq2pCYd
LJ661cthF7nR0dHiiKQoWyqjUokMy1VRaUkSyh+1vCYBnAvaioEy8Z64EOiN3VEg
pB59uWKR9OIdD7XhSqqYE/z35rfREhrnwJSHRkmzs/xaFxeWm9BfXYo3FPudS8ly
3r6qazkAt6pSmri6TdI4cZ87G+QtHUy/6SVN9VbFdVH5/4ZENPpv0B+npH6ptJ/q
CQGPifs03uJwfAl9AZ4OcjbnrZxABZ+jm9+4/B7m52DsM0aNarhPGAqJ1GOVyJzp
ZQJCuqaSrMES4iOqUyuBlrogP3a4MFJYhIYAzqP+6oTFLlbHfaeaH2k99v0plH2c
Ib4qFYBbWc1gkNyEyZX4oYuVmmE2vr45nFyUfXxpX51idLfIpSn2Kp9ns99TYYN4
0ZQMF2FF4+reafcj86CCUYdrrvuEMqE3jIVnAkevIAwTa0Mmc3Sk8fM1dfNPEazN
3mc9PMb8eO6HXzCVnY7a/hsYenWb5bRJQxLZMPV11oEkIKTu7il2RXBGYoW93E5W
4sMMLNncCO0mHrRJkybCpvl5l+tPdZfGCp0c4eCywGCviD43oz766zbsb3BgR1ah
A5cLWCxGMc029WJRaMGnMCttYEGkWY0ckEW9OqtIu/SyXVnse57sK7gmQgj+ZiEI
FhaW/nOHGsnmEk3wczC9gJZxtS1615SiWpZr16lzcuhfoqx5bawmOlKfrDGQ2zgg
rEzSR44YgD3d9Djpt8s/2rmh5veTA2z8W5SVMzl4rY5IZA9+71zOPIcFzwxjL9xn
vvTThmMy/poOkCe59EPraElhFKbimvFVUKCMEEEy9BVhRHzqUOKneDELxPvHuI6n
dytiaeqALMCMsvIjlGOiYvRdNt6jstBP69CdAbqRYI0xabuD87QLFPnqlhRB3d1e
GMDPWKGtvZarzSPFKRlGxHz99rDxQniAoi0cdEnJOVc6AT77vMDECqGLF3Pq/6aZ
pK/6i4W4X1rnPUe0b78BrLgf+eyYEK2W14ljnkHyu914J1dKRqlTSHL6z2fD4i1W
Oct+ejgMrSWYWZA7KQU/5BLK9utTlMVstbrTDyC9TuEA+QEvmYoYY6THZVLqxLGk
Xtq4/Sp0H+Se9Rp9g3hy68S3gzI+qGoMpTtvNoPn4ZdUFKQ71Qoy2rlVPvZP3mSa
bU83am48UDGstX/OwoeFO1RBWoJ/iKI3MsQo8u20BVFCt+DfvNigxZLj8Xepay4n
bN/FBr3USfxL+ML5BpNB2Rzf28ljyGnzvSkTklwOoilyHXRA7AbZqfiUmlb4ITCa
rTl4RnHLEuSfl7vIBlhIX0uKyNGInFNBWTMkxCor/Hx2NbYB5DS7EZHJEX2cMqKd
oval9LLSmZFiQ8uk3vLLwKEklXaSzafefe80DBS71ak0P6QK7HryagG64rP9MQMw
PiEaEZDlHGOwm/iKeWdVVSgUSoD0X12qMWgfBTZoS3rc+RY/ZgfmCGpjhQaWPEYq
LnwUbqNBG8nQh/X0ZY8n1yHcgRnxmNfDkYfuTVIq2ldNGX+6K4J0N7cDL/mSJ3rp
hMa8vBucHADOVqbEEGGDlO20zgN+IfrIS8xNAzp+T73QzMqAnCHiuJgAES5IiJjm
VzEiDxPuM2w4ki3Dn5PY4rIKRCFkpHzCnXMEZbN0E+F1FSsTxCpv0F791cSxcbD8
n7Nm1jqIMim1KZiqL7ZdIaFJuFrdhKYn3zrQRP0dSYa61WFz96u8PWynB3iQpgDq
ire5zuBr6yBb5nN6+JxMeuWtSCyw+jhXsER7N7CQ52a+/aMqMRnkkMfAGynJabC4
InRW+KtSz0IJr7ntND1Uh0ZVDcVfCJQphseAMeF1E3kwvqDkBuhCVj5zrajPCDQb
rVQZigMu6+42HoOLPKw+G8xo3TpJBpzHLbsuMW/rERToc+bqNqcwZUv5BhUpDh3h
oOnFlxBrrhaEMzaxxYJYnglk/HbmQYtAGFmC7Cy+3Q5f6accA0laqRaRoZAurIKL
l8Kb2Ul/hwUEOKXzvl33BV4wePuRufXxar3h/4QH9eGr4hlq3ZpcMF4wYifVKl5j
Hy2v3wri+6LHftnRbTYojlh/TUCmUy9F3SVVB4NxN7jbp7NDU5RaEIDgGRQyqTj5
yPJFlFScXMq2bsb/KRthu5Jn++qbTHrMZR7seWAxvvoxqAHxOskZ1hOeqb1Ve6Uk
3ouq4mXXzuaro7EGsoyxxC4DgbsrRxnQsjHQxWUq20SUPPyN/slGiUxYYcMP/jkw
Cyov2gGF/ysnItJPgB3UjS7cWpJWhZqCuGWi8ZXKd+GRbaJAFyt/MTr5zN11XztZ
Yu6myZX/AJlwqxLNxIXwwIuEAP0iKB3Zu2QPMml1D/7gLb0Hjdxp9ka0uxEMArOv
zhBwWaX9mwcxyCYqeQW7AcWse2JzqmAC5QZzvhnwll4+nSA45vVzPoV33oAgajyl
0uaEj2eiNzWorKaX7C+gZOsdSLjB/Zzj1UTmSNxWdhvauUgQvuvrIwPPOho6JSe2
mkzrpi+kNTpViOu/ibTScj/EwNmQ07czzvFBzhWEbssWMtyc2yBqaHIaVlYiwi6/
kV7NztSPf/gzwqyziO4wt7dv17NVqWcJRyqtJ2LtL7FYZAls1WZiOdJYS658Ftbr
jKNt12tAsqJoVQTKRZ3FNF943Y9pAGZPXJOSS2C3wVfW6r8cG0HUcsEwdd0o/R06
BK/zwm3897BvE0RL0maoNvbaubiEAywfOozvI+uYzmufv7O1GMxwRJ2nl3M301dM
XAGJ704eZF0dnS6cqKXYzScdXm1pco0WdNQzrvVXe721x4oPyCcM6/04eRvf5VgB
YwgrS5JSiFqFFSyfzPBkNQoEi2Q9jZP3e9AQlz2u23Lr2R9SvC0VAg+um8cGCc7K
K3VjKY19/0Nlim0FWgXReJOtTORUnpuaMaLYvod2MM/uJ281TmLtQF4KYPc07yL2
gdt9F7Ce9/7evsmdXY2zIASsFgMVsAzsXKbT24osZSg=
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FnYiUqU8d0txV33q31SQ1IIqKtreMPL/BpbFsQoYROrbeQ44JswoHpIq781gOtdl
KlTzhSp8dBtwmbmevrv4pF/yMf7AeoPbBsoq6BwWDxAJH9o8Ucz5GGe2BM8/6tO6
CdqEwFAaQ4se4Pzz0ntY8acpbk530OnQ4ynnu/XyhSg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24437     )
fbPlvyyXP3lDq0X2w2tib+OVL0/jCLwOuGjgMkBjhOLdWut05psbkRdoc1xpAhyU
jvbt3abCOkMchIh3n/KfKkgwSiCvs/4ncDbfrKdwvnbA+gjZPzgsdPtylAP6I+oE
`pragma protect end_protected
