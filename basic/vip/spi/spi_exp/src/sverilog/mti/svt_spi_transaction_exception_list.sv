
`ifndef GUARD_SVT_SPI_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_SPI_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_spi_transaction;
typedef class svt_spi_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_SPI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_spi_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_spi_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_spi_transaction_exception_list instance.
 */
`define SVT_SPI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the spi svt_spi_transaction_exception_list exception list.
 */
class svt_spi_transaction_exception_list extends svt_exception_list#(svt_spi_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_spi_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_spi_transaction_exception_list", svt_spi_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_transaction_exception_list)
  `svt_data_member_end(svt_spi_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_transaction_exception_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE validity check.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_spi_configuration cfg, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_spi_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_transaction_exception_list)
  `vmm_class_factory(svt_spi_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LZkDNIZyLsyNUwtSclfOBZUr02ytheiIhR0kRc9QsBA436/PudWA9Y6Pv0N9W8kl
xj5mTBrjYgMrbXKbq5DNu9wmNa8HPbNJ2BY//YI5pCQoaafHWiGu2pC1gXGDlJ3F
K6SdEjnnCT6p6gs/e6oj1BNH++RRK0YN+cXSe5zhzrY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1090      )
tLG+ZAZnANf3hDpP4QNHGPKzq66ljgnWl0J0cft6pnx7KugCNAGlWtcqm+rHV92s
CNfm4Rb3Cl3kvkrPuoY9X1INykJp8SKB0kvQcVYDcH+FuKofL+uMoxZMibg4AXtw
bLcmdcJd6nvb0GEL9pCm+VMDVeWYt/K6ZKXd8/pYeLkOOYYYsD8dRbW6QLOn1uG7
EbxrXODHzMOd9lptblcIiak0wphOKRqDquLCGGoUy6KhuxDYXXiIi7hHAH5GLuSF
Z0B5u3lhggNeXABt0oT7rxVkQH1peKDk3Z8n8A2v4J46CpanBPtCnOKkLELksyjf
VlG8r7RhTt2MDrySvRJmFGT9vTOP2kwMPVQLsXveF+hWBGFZb+bgJn9CDpiGdE6H
UGLZ5cQ1XB8b7qfwfOIEMlrGy3zYI/EykWxtWczFh0jC1p+mpZufO3RGUzeF16Ns
EJ2lwZnChQaJbwoKoYCVHBM4vpjYfSyEvL92kFcpFeSVHnt0EMTPniw7xwGdQQh4
F3/w++V17vUlahFh7Uy45euCsxF71XO2bLZsayPaTAmoylQy8yfhZKnOImeKudnb
vJWYFa1+b1MygKlAfGoo9KmXUjISnW1Uhz0qa/KNoCIGWOrSWgnX2M+McdhP7yBE
WmwpXrRE/VGg5J4AbaKorBX5Dj3eVrJmldYCqDolHj0Y/5c4fv9Bd8bGMGVOqMPD
MUCGTVyRjtseSEosUu5rH45Toyva/MP2mP6u/spX8npzkLBOM5LSy5uEqlh2nV+1
wBq97GDZv7GoyJgb4kYX9U8oU3VnIawXlojaR4hscv96WywBlCHpYHQx2zaAQfyB
Cj2eIGjzwspJjTvL5f/64tOB/2SIae6Q+Sjhl9bQiN+lm71viQ0QKAVC+ZoCaPkt
hv+wckDWRLpzj8FIJsEoQYe4kKMJbC4QhTdHd1CQhsj8eR7KoXgVIVD7BY1X7T8Q
wLpMH2Mu+ig5itpdrGDTrAZdE1DWS+V7kZMOXqu+I0qKLXDfRpo31Il5U/8Te/WK
zxfipJLkZI5PLYtCAjbDQe+/rai6tJSgqgE4itsxfY+drc1KFbAPM65v/jAe8pyv
UcVECkNeV0LJht8db9Lh6NtMgWOiNkcYlWh7yhypnq4UOXUb21bsxDLOFEL8M9kc
NUa8oE5xilFp+W0n0VzkxRoK81/Eut+ZE2XhqOrbLcfWUlDCjbobx9KxeEssS5PW
0qhsRqC4XFqbkIXiogWnP/kuZZ0rE8X22w5HCngGN+HaEugzNQ/WNBa2Z0yqFtXy
syZMKqWrYIfVF1WeWi5r/DTP6E2Lo1PoCY7UtE5tUW/OCaPBYub7v4eGX3LVJLtS
sbgVQqTLkQuvIvnNBKv/I8FuJkTQwjYs/1tdI9QrVT0Xr0XOpJcEsHezFxHVhHxr
/1vA2pPCrZ7X1nworNuZysM15n8b1DpFvifKUPnO64UIU/wcxv3uJ6j5zRp2gYrX
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ccx6Q6aU9cCczEqcpHvsIt2q7XkkCnRZ606HnhrVUX5Hd/n6KfKqm/4U7BDt0O6N
vMydEv6+E5nmyM8VVnn1oiZ0SLyvB9GLrpAZznWHP34/Ykajn3WkRmq3BY7HCzxz
6vFkUIp+J5NIpBvSRSZ+CoB+xTgP377vTX3ICOBGa18=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9082      )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TRANSACTION_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KbBY1+AztWQgCcIOHfOpUx/ba4KPToFUuXFuOLtgsO+QLK3DI7AmSgOOex38LHYA
n5KHxuXIIpFuR5Dt9ms3OhvGy1tgZOs7ETlV7Sf5bbQtBtZcTzL7PcxwpSrHuKcQ
1SPEhFmDDZFySGwQCVAZZ23NmxP/+S78mRofbJfYPFA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9165      )
Lumk/0a8YEBon8usXPe9s9cJQkYQ5Pg3/UOpBiO7FwRmiljv4VE+MwUhavcKZSeq
eTDel/AmYcb6gRhbkrGBZGEC9I/r5g1basiyxohshTv1Pb3pHAqyjOEF3CVZ6m3w
`pragma protect end_protected
