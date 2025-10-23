
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_DEF_COV_DATA_CALLBACK_SV
 
// =============================================================================
/**
 * Class containing the default coverage callbacks which respond to the component
 * coverage callbacks, constructs data fields based on what is seen in the callbacks,
 * and then triggers coverage events indicating the data is available to be sampled.
 */
class svt_spi_txrx_monitor_def_cov_data_callback extends svt_spi_txrx_monitor_callback;

  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** svt_spi_transaction value, should be sampled when #xact_sample triggered. */
  protected svt_spi_transaction xact = null;

  /** svt_spi_agent_configuration value, should be sampled when #cfg_sample triggered. */
  protected svt_spi_agent_configuration cfg = null;
  
  // ****************************************************************************
  // Sampling Events
  // ****************************************************************************

  /** Event used to trigger transaction coverage. */  
  event xact_sample;

  /** Event used to trigger configuration coverage. */  
  event cfg_sample;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_spi_txrx_monitor_def_cov_data_callback instance.
   */
  extern function new();
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_spi_txrx_monitor_def_cov_data_callback instance.
   *
   * @param name Instance name.
   */
  extern function new(string name = "svt_spi_txrx_monitor_def_cov_data_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_def_cov_data_callback";
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * @param txrx_mon A reference to the component object issuing this callback. User's
   * callback implementation can use this to access the public data and/or methods of
   * the component.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_observed_cov(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DTUOkGE8V3PRI2kTwQzVGVLQvNK3FqVzRYmkCvvohqMXsQecfJI2OPHGyHx19x7U
dXZA5PtRCDQ08N23f7o+z3EH9ZiXgH12XsIRtAgZo2i6ch6DxThY3HNBn7U50HUL
bYEYYN1Mh2QXJShyadHeg6RmhecUaGxa322z9HQo1fo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 426       )
crRIA6P8ZXMIPOfH3Etd0NwafEfNBk3Cs46nUkSMRfSd46bm4GsBj2+17sywsGEG
e8Dpcj906dto0TTKkF//a+G3lRzuQd4Cqk/sk5pFfTge6E67Iwwk+scGeijYh8Og
2dnIsxJseLf4MHqpJSk39y9CTOygtAednbXKE/96mH+Fx32HeSKtVaso7Olv5gOG
6RjSILZFCZpj87A3NeSS0cNfmhccmdTOXJt6zLarNxAL3Ukgw4MGbrYlcZ/yppDN
2Ps1usqtyw3q39A83MMhRuVHLBtqcXumSwZ5rXgcqZwJ88fFPgpP+sVvKk/Te+ye
2G60nYV5w6lU67gj1BCW+abSJ1qg9B1YUHCToCFOnY3IgE2hmUFJIUGcDRT4xNq+
AiI9nk25LvQWhMj0mz2gYEcdaMsuMmPF9nEKyW4Gc0TxqfBfIiXV80mcvuQXJ38f
oeZCiic97A2ADcf0PBF32xCnFc7ErvNaOU4a+89+CmivAa6E4tlJI3IO96l5Csh9
L3Dj7+z/tmr0B5HYnR8byopcMKEbgh+P6Nk9TkYGQumVopoxdzLw2MURk8R+ibWb
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lxmTWIJwxIM5IFRkTUQL8RbXCCpp88FpEkNIM6HOfhOpVaiFcBjYpEVdVaHqVKGF
xAqQs83ndUS7iDUHayPWj9ccoI0RZAt0+zFtjWmVF+NxCbLAmR0n7UrucCChUHoX
cgcxpSiRDUeJj0KsvQDSgUbodGba8bCMFrkkbfPFLRk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 956       )
SkAvxAVgiS8IfuoUdWcDpj9I7it8IgE+VEt2bIacwT7O57iGh/wLVkjlDmIyMPxY
x60FUNKyHWSsOe39/glpF29Ruyd6YsKxN5NrKS5tfme95GUIcWJqCQ14uyMPpoCy
X0qhM89SAfcQvUMokFy7BW+LnV8TY4IZmf0obWYXikTo5uQztc1o9X7gsQe2Lv43
kH1b1GeXkfJsh9vLTKeA+ERIRfkXCc8ktfvbWSRR6aFiqd4SOoXWHk3ce0O/xLA6
YMvB3juMzAGM8v5SeR8nWTIO/Z+v41PX6zTZcbqCqt7VHK5iztIWZPufPBNRsufM
dbxtp0dMVnZyXTyXvZUl5MK+ZAi3lkG9Z5AAICPMzDG2JreWazsFdLMKhhhxwcjZ
OfLtaSPuL3zy13SKU005WNuvbyXoonp8/LtTiTbpLgO+RoK7cnhjoFrvUotbPV/c
skLfNPEFadT8CdBZuhDg2tWxjRAoHdAQ1Zb1hEjjYHTJG1GchkiPRx6C11+u4DMl
ckwh33G7ZX03ilysHklXR1W45AbE5Dy5goCndqxPSsym5+aaPXU61/CDJoEo5jSO
0s+d+gMdiJHkQX3aCyH5loMJoPlM//xYcfDy6vR1d5Yn8RJ4mvct1ppxhIMSGP9q
rtilbozTq9Kf6aZNOY01EmF12jyKzpqIg+byL/ykAntcQcx+uySeT/gdHXsS0lVm
jxueCB91Mljl2QQgAXYfeQ==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_DEF_COV_DATA_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bndYbESh5y0+uVQTYzsII8qH8bBFNyfiqxzVvAZUKgtH+XJrHD49bAg5jJrevHbz
qexozVVtyGnH4Qw8c50hFyFqFBlHxwbN3zDbeQv7EtjYx9qJme7GpZwKoF2Kkr7o
DS42lO62KQuwO8ZpwI4DGpmSb+zAj7z2kytlshVglqw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1039      )
gFkvAg4poaCSpNARcNE2NSpGi0vIknrJWQuDTcz2kUHobcer6+KfMi00V6BwNUFX
VYAJiHs5rp9rEMEs1gWGMF83M7P7gA1vU/M9KUD+WZ2X+cROoUnMtWiZieZrRY6M
`pragma protect end_protected
