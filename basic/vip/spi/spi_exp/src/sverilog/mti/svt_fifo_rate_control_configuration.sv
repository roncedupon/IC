//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_fifo_rate_control_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_EMPTY_ON_START = `SVT_FIFO_EMPTY_ON_START,
    FIFO_FULL_ON_START = `SVT_FIFO_FULL_ON_START 
  } fifo_start_up_level_enum;

  typedef enum bit {
    WRITE_TYPE_FIFO = `SVT_FIFO_WRITE,
    READ_TYPE_FIFO = `SVT_FIFO_READ
  } fifo_type_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /**
   * The sequence number of the group in the traffic profile corresponding to this configuration
   */
  int group_seq_number;

  /**
   * The name of the group in the traffic profile corresponding to this configuration
   */
  string group_name;

  /**
   * The full name of the sequencer to which this configuration applies 
   */
  string seqr_full_name;

  /**
   * Indicates if this is a FIFO for read type transactions or a FIFO
   * for WRITE type transactions
   */
  rand fifo_type_enum fifo_type = WRITE_TYPE_FIFO;

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  /** 
   * The rate in bytes/cycle of the FIFO into which data from READ
   * transactions is dumped or data for WRITE transactions is taken. 
   */
  rand int rate = `SVT_FIFO_MAX_RATE;

  /** 
   * The full level in bytes of the READ FIFO into which data from READ transactions
   * is dumped or the WRITE FIFO from which data for WRITE transactions is taken.
   */
  rand int full_level = `SVT_FIFO_MAX_FULL_LEVEL;

  /**
   * Indicates if the start up level of the FIFO is empty or full
   */
  rand fifo_start_up_level_enum start_up_level = FIFO_EMPTY_ON_START;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  constraint valid_ranges {
    rate > 0; 
    full_level > 0;
  }

  constraint reasonable_rate { 
    rate <= `SVT_FIFO_MAX_RATE;  
  }

  constraint reasonable_full_level { 
    full_level <= `SVT_FIFO_MAX_FULL_LEVEL;
  }
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control_configuration)
  `svt_data_member_end(svt_fifo_rate_control_configuration)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
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
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
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
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
endclass:svt_fifo_rate_control_configuration


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eccvgxlQMDxix0gR94DbcBfPl5zIXOdf8fOa/falGv8JyzlzoBWDHW9JJf9ie0Pm
Nn+cbS1X2YKVEqnY1rZLceOytWeItIbJhCbGanBnYRHIFKHJel8xWEvjjs708nOA
me/Lfpn/GpPGTB7SgPi/sH0kv2cNFaSR6A23gRchZQs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 688       )
nrdXiitnnjMRQY++shLnziX8tLmj7rNSx2Hbii+BBkPZB2bqHk6PULHG17UTcT1r
iHi2ZfRSyZo52vKoNYQIHT9hYa4Za/bPVDHFADsnMXHA+Bo5PPSeYYNyNN3lloxI
PcVT7Uf19GfDljFgSKkPtqXA5I7rUkPIoeM3U0HTqsgaD8UGKfJ2VYwhcGaaj6bY
KDcsjmrhkJ8TdD3td27sI+vQHHCHj77Tft9u9joR302HRCA/tiRlsGpUsRZbfKLj
7cRYvv1cZp90/PRgCB0CcEfr11xGrHJ11TMWQr9Gxtl0e0+Ha4DWz1mpxHlS6C/T
IdAokKz2EvU9x7ziLJcctjdkSz0AK4HhBb4H2S/RjWG/ZX4s1HdtZiXCn22oqTOc
SrHgIfTQypMLPSxibVqDxKkSxFEWJZ5e5/uN/XKfUrHDkBq+tS+10eUXWvYYxk9d
Gl962Fa9AEi6jjyEvgoNr5Ik6nFxQR9ZjVe6acbhyie0NWuL95s3GESYx8Fu7C4r
iY4TKEpEws1DmtWnG3pGhi7oQo51+cejjU3JTpnM9ux+vpLPg6sitxM8fofGuBza
UMNS+VhOzyPZZWUFMcywGSaUnXlCP/3LMvGAcCEaGt28JjbNuorej3N+d7VVzLgH
VRNQvKOsiMxAU+yOCj4tJaLnuy9q1ePS14dQq6pTbK9hmGmGOTdf9RFD+c+zorlT
jL7gh6IPq1nB1+vsJI6ipGGOQXSjrKoSRG/57yiyY/gRQ37ghtbMQVrycDmfVDfH
PfnE2bwSN5ERyFVe5hVBwqPSgd446QNWlfIkckIHCj8m2biVGmaFvNDE3Ra+gCUV
jpqIySwrjcbglfwmYWyQBXdi10KxR2401QqlRm4CCatgFsF5K4YyZUDdtZr2Db77
nTebUNp0BHFllWCT71p6HLTO1TO5wNI+3l12t4EbisE=
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LTG02QJZt3rlxDzIAQzwdwqPGIzUjMHXLsdm6L7pc11lqwYajQ+xbkl6TCM3IUCa
3h5Yn/CwABFKdQjQwn6N1z7lpyVeY+60mpfYJZBddC1dLvTLhFMTRErmMcTnIU0y
4LAfA2kkHggVoqUdqcnbps4ouvY0hR8RSnRUKlRGZ6Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16503     )
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
`pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bGFHLoQjaXuxo8bHm0dPoKnA/tSvkFh9E+1uJi4B76Qve7qkvUvmKBZMfuH7wXo4
R0rhTw79xQVwbXbTm8eRHQtQKwao/ailcjupKE1DaIQisRoiDo4zgic90sNutOgl
eLhgDQsOPH1iykQnakDFjr7aCgW/OY0E+0//BHz4h6s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16586     )
szWWYz+x97Icw1yeQzODiOD05xc4aggtcJVl/KhpWaSV/IVij6kz+WOpiLczZppD
sNDRMVBOk5XHx5QPwomcB7EYG1KoExkvDqPsVNHMsUhC0RntzPADO9a0+AM3Aah9
`pragma protect end_protected
