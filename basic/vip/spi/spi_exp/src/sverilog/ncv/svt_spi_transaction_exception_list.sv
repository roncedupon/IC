
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BH9Dhpj4KcayINcTl5Gs8cC8L7uAj6gCQhjgKfZyS0T9U+71bM8amEvMBedYLZRF
0fk5PWW8Tmmundh5HC92rM0IUxAGwS+oAE4VQCVtCXfuBCtrb6WoAy9XjIGpgNE4
dqpUAA+4ll3nsAVyoidotN7Obf+3Uw8xQqfiCZH/ZSyDX1Gp1+ssKQ==
//pragma protect end_key_block
//pragma protect digest_block
uBA0cuG1VJDccoqj75k1h4B7hBE=
//pragma protect end_digest_block
//pragma protect data_block
01Z5ObmXcH+XHyqfXQkXaNEHXjx+si7yIsCU6oarrrifuVlJJ2nc8kG7dzqh3Ikq
tlr4QtaZx3EUcGVgGnxbb/EvMLTOdn41qGgtcfKnAhMnBzwD9RHt2JORbL6gqDHD
yVFiS2GJB5qpdvXy4hwBEE0I0lYFB3vKwqI5zahVd4OaCxE0dHbfzXFSc97EDJUH
V1LEGhq8ElY9VEnOPL86Pk7KpsEn+2ADUeGTPiLCII0U/o+Y6xkJ7xU/H7GSO0di
dVwAx6I6sxnP+Bc3n15okN8BhBv6dV8s0fwQTCkTkJWMPwjG1NBk4kMvjtNNF1No
LfPiIRfqXx1l83/EGNWLZZhlB+SRJBfLOFNu+ITPchtF0XY3P/ktISQDhkrjvJko
R3SmOXERqvBgdRzf8+vmIk2D1diCUSR0fp65kxp1LO2+5VHef8KIvxqOOHQXrqrm
nlBX17z4FuluwB8ra+faKZf3ETsOEiGJauCqT2Tc7hl9MqNXHlUpXlOgK71v55k5
0pKEruw8hVN+9gr5BGXDX71rXuUaGya//6bTmPdNiRqZcRloVANDQz+mhIk9JR3n
TCgylBxqq9wa84VF2Dc7jUBm7H/ryJ4QXWO40xHlYPJlVTEh6zHeuFpgViLdUrTA
BdT/PBUxJDSgv25hCI4Z5OwZoE1beUSXhJWnSY1PiyDWdnNI2HDg3JjpvZG2chhF
75HwhipJlM2Nu0yYPHz8q5AunpPeH2skOH7Q3f/DbnLWS1O4bLd9o3//ZiJ5Vwmw
SAwgxTlNLQYlSAOuXjfrQB1axggKLuouZ47NTV7nmeDpqSascLEvNR8zrmZFUqvS
GDMWow1lPvSnc/AIblmEkXOh5e6SMPf0cNsnTwHWUBcuJHAB5E0BX5kFg9D+tl5Y
lr8XR75TmMLDvDmP4j3oIVRdIyvxzaCSyB+xY9ALrdI3CwtSFX3pPAAAjdxmLUM5
Ef3CJ4WQkpYwIqpcTdE39uWLWQXNl0MeW64KbB9KGC3HE9YiUC472fpYEmjzf/+D
vdTLcCKYI2vHHerlwdARebAlqieVGJCmQ+CzZd3O8zr6OwHnVOlx4KhpiTTDEO8t
jRH3wRQFO0S9/wclfwpyD1MNNHHHqOp7OwTS8qCOjzVVzSboZDaJfmNGukRMhiwx
XL81RrpNmPyiPDzzdV1dofuu3yNGqt5TcO3yk3jj4I3l9qDCgDe9Sj4EcJo8EVao
taKxaL2g8fYidI02PIZrw7RHM6P1HMgRqVqp7eKFvgEABBAzqvyyzyRG5pckn1Or
zzAfybTjGGDEjekvOXh+yUJE4mSCWB9vIlqhROTKqAuGf5hy8Y+mS9i7Uz6gnqT1
qNckLt0rSAeP95liIrEQv0bYzO1Ryqu6WHnitQgWxfxXHvpXDb8olkN2LGW8hSyK
y976K4k6ewJzNAtGHYv6rlA7HYlKnvEGEqoGGtbeQzP50sVl5JlzARCxEN6qKtZQ
UODyWxa7Re8W0tU/UoI7RxwLB6m9BhWfU1CaISZJfjps/E8w5xbAyturxQyG7MsL
RM6+iP+Gtan7f40wcgkTyATRcefDOVznzC0DxV9/cf3PnY0R81tUxFKia5mZPpXI
D3x3YnYZTxgKQO0qOUCEYUU1bo5BjCuxslPr+yQu3ViFdiDRhMJOvhWp6oa3yhZj
mobkqwIetqPHHt7v7utwSA==
//pragma protect end_data_block
//pragma protect digest_block
pHTvYjOBF31yETmb/iKtFdJ3RBc=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DAhdgyFhfVh/WXobTpDqQmguLKdcbZInIUF5RXuwTW4KX0PLvClD/fEIyfTNSaYa
lJJU6Qf53G9wvVDp3uNYr9jMGb515iKfQGdw068hG95qHL0qcmgcxwo0v27QjKoM
1EGmCpXHG7EBfvuf2u/UHcE95wjoOEyBai1OH30sCga2qKuZK9msNw==
//pragma protect end_key_block
//pragma protect digest_block
uqci4wxi3payvfhHqJ1zdj62Scw=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
MRjth7Y/utHgV32dvPGm0Q13ISE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TRANSACTION_EXCEPTION_LIST_SV
