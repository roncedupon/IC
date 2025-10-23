
`ifndef GUARD_SVT_SPI_SERVICE_SV
`define GUARD_SVT_SPI_SERVICE_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 * This class defines the service request transaction items that can be
 * triggered from SPI Master in SPI_FLASH mode. 
 */
class svt_spi_service extends `SVT_TRANSACTION_TYPE;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_spi_configuration cfg = null;

  /** Processing status for the transaction. */ 
  status_enum status = INITIAL;

  /** This variable defines the type of service command to the Link. */
  rand svt_spi_types::service_type_enum service_type = svt_spi_types::POWER_UP;

  /** 
   * This is the weight controlling variable which determines how often <br/>
   * the RANDOM value for DQS initialize as ACTIVE HIGH is chosen. <br/>
   * This is applicable in Slave Devices Only. <br/>
   * This is currently supported in JEDEC Profile 2.0 Generic Part Numbers <br/>
   * when svt_spi_mem_mode_register_configuration::enable_multi_factor_wait_cycle_latency is enabled. <br/>
   * The Max supported value is 100 and value should be multiple of 10.
   */
  rand int multi_factor_wait_cycle_latency_wt = 50;

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
   * by the spi_svt components.
   */
  constraint valid_ranges {
    if(service_type == svt_spi_types::MULTI_FACTOR_WAIT_CYCLE_LATENCY_WT) {
      multi_factor_wait_cycle_latency_wt inside {[0:100]} ;
      multi_factor_wait_cycle_latency_wt%10 == 0;
    }
    else
      multi_factor_wait_cycle_latency_wt == 0;  
  }

  constraint reasonable_behavior_type
  {
   
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_service)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_spi_service");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_service)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_service)

  //----------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

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
   * Allocates a new object of type svt_spi_service.
   */
  extern virtual function vmm_data do_allocate();
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
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this transaction object.
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

`else
  // ----------------------------------------------------------------------------
  /**
   * Packs object into the bytes buffer, based on the `SVT_XVM(packer) class policy.
   *
   * @param packer `SVT_XVM(packer)
   */ 
  extern virtual function void do_pack (`SVT_XVM(packer) packer);

  // ----------------------------------------------------------------------------
  /**
   * Unpacks object into the bytes buffer, based on the `SVT_XVM(packer) class policy.
   *
   * @param packer `SVT_XVM(packer)
   */ 
  extern virtual function void do_unpack (`SVT_XVM(packer) packer);
  
`endif
  
  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the transaction generally necessary to uniquely identify that transaction.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the component (or other source) that requested this string.
   * This argument should be limited to 32 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 32 characters are
   * supplied, only the first 32 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which transaction data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 32 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();

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
  `vmm_typename(svt_spi_service)
  `vmm_class_factory(svt_spi_service)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_spi_service)
`vmm_atomic_gen(svt_spi_service, "VMM (Atomic) Generator for svt_spi_service data objects")
`vmm_scenario_gen(svt_spi_service, "VMM (Scenario) Generator for svt_spi_service data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_spi_service)   
`else

// Declare a sequencer for this transaction
`SVT_SEQUENCER_DECL(svt_spi_service, svt_spi_configuration)

`endif

// =============================================================================
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oftljOQu+02bs6xJbjzMXZFIV5B5fVV14R2kl10wE3hktL1/7G/oTnyfNZeatDDh
O7ljOAD6oPWq3HmuhKpQBfE+2symcBz+g+7JFKcnssmmSTABRHwRDcW6r9Q7hFFl
Ocwcj+/nJBjJ0veC+Q6EM13rp9jsgy1tDuo/Db5m0Qc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1227      )
4CJ1BIkwuqE+IGxSBbjO3uy7wSKlG5eyC67IiBBn8NBYouueSKilPxIh2iYTUO9G
2AO9OFTAv8SDgbIUHUnyTMutfnu0qYCofP5Al5IT14ByFG4Ud6SfXKatwVUm5had
G2stGUkUnmaUpgzO0E3aCM1Fx7+cpzsppYfKXt6ISihEmSA6avfjrxPorJFO30Aj
FSC3AU8Id0b9vVrYukQtqoJykBDhsUako1sZVOaK3ZT1YtkD7OyBxSIg3jnSoihS
cLxvNANpKKpkKrVCGoxYXArDG98fmBI7OAkO2uUui5Zj5PuZu/khZC6MsU5sA3Ws
vY+tjM/FSU2K5ybo8bKLOV3sW/n3PLQgsGBAj7xW4ik93RFR5ogMz6uUsVCP71QM
gI1YsF9QOMwdMjHsGbnVp38lOSlz2t9n4Ri4Q7ceWLnxIEhgmz+L+xsxx922+gkB
3kN4L+glyzun0UDSOpBPwItjmMuf5Ii2p7yTi+Tq+T1FyQAKpSb/Z/2U90yprwiu
DwPIKH7bDMHSN+/aCKpTuD7rZHclVyamXflQ3aUiq7NFX3+mWtd1WqO6dSaDe7VG
IlgEyFzfOrcPqE0wbucJ8kMr27hS8W1qLUYtncQKSwp6P3L7cAFmqqQsQ9vDaAP7
c8UV9+7onnt86OiQi4KtCTFC8RU3HphT2Es78TrO5dlFnYye9SbTQdagu/OeY5XR
i35RAKpp/zlVHMB6wBJbDSyZJTXu7JNS0wMqfjIWCQFIgP1BIzwTGzB17MqRBHMF
6LvyzGqkReZ9xXA53Jz8Y830j9AfisUTRrIvHus7IMhfiRxbFABfoQh033GPFjbN
o9KlZCLg1LB2q2xGavbeCAo0dn5fJ8YHNhwZbJHYb+kHVLpgUK4tuHUI3fUYFYRz
OSDlx2AuqkVWs+ISCfIfSvLmUMnoy+OekzWsjmYc3pKsAstyMOzpFxwn0JmZPksJ
fYvhOXNgMlqr7naDjfH2tV6kxhRT2IG+tguxEcXkpd3+uMWi4jdlAMxebdXY/43o
GMdCzFcm7Rdzj7AWRq39MhHOlkx4KPShaOQbKvRMwvoTliUfhCqVJe4+2wUwm2w0
MrE18TinXtRyrRVwHPVrESJraO94+QY1a6YMvfp3Gupw7FHJhT8zqtiFvBZwrA5l
5oVJ4PIjdQiOS9HKJh47QaMOi6pogrQGVKPGFURN6vmefafst7vARAlxb1iWGDsK
1JtHTlthGwvlVRpqZLIdf1is9FS4BJESZi+/Qoop1porDn/HGURkIzz20RXEk4sL
0pdi9n42WYiur/Lb2S1N7LlDHx6m7oU1zYZ7a1u87L+FkixfiuwWWgDbUkBF0k5e
QiGOvSviw5/oIaTyWx78deZVQ9INgMfBtQgf4yQ/eHaHHf43djwDu32IjpBrmci2
EEJaFocTkp4ZOGKKtao6KV+iv547ZPyrjHTONNVJUkfHvsuMfsgfBM2qcQQobeT1
n3+bhyUYliy3/E6brAq5kKaKCV+vbGfZs6G3lLFRaHQBhnb462EFJUwCzs0mm8z3
I7ZdILYU7PAHEm7G3P1Ak4wAk3KHP/EA4jlIiknyRtXSMT0tZFFAbyRFSDtDEjxe
OmKb6BlX5ZKHlr2whnLuJTbCKoDvE+SANRvj8cozTHw=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B41RBMQVzTxmhG/Muo9240gP2lwBhwLQoSy7WT7piUCAN/dlNKWAzuQBpVEsYCcd
M0b7muBDl5iat6L9IYKNUwf5OvbUwusodw7QLV5xGDqCkZpeMwVAnrVxffsFrn0f
XFnV6d015iDDaDl32Jf4WEzZGHlWpn3FvmVEqCLB9MY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15325     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_SERVICE_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lqVilNx401h1uW2hhMfysNYQ+u/38kLYDjX/JbypP7yt8T1rQsLEr3MQjAlh3i47
xQS1k6BekUjW9jsv2JhtqT3pr2kHhCbAwRWVNboH/4qwvi604vzN4BAPX2g+3trU
3i8Xah8uxwDGr+7brtB8DZeIsOX2qvZXv0SBMDi3YBE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15408     )
kGYW7b5CqT/70BC6hvMeFTqCj1gFZ9zTzuk/bCT3i7e74CnyhBHHnOJGp7uKyrfi
4Si3c4/BuG/1tGZfCfVrxIGC5evBvyGDNY4N8YGjMCKTLNII3ENpyBVSf7HxD8ff
`pragma protect end_protected
