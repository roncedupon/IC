
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_CALLBACK_SV

typedef class svt_spi_txrx_monitor;

// =============================================================================
/**
 * SPI TxRx Monitor callback class defines the component callback methods.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_spi_txrx_monitor_callback extends svt_xactor_callbacks;
`else
class svt_spi_txrx_monitor_callback extends svt_callback;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_spi_txrx_monitor_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_callback";
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  virtual function void pre_transaction_observed_put(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact, ref bit drop);
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
  virtual function void transaction_observed_cov(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been started at Tx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_started_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been started at Rx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_started_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Tx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_ended_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
    
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Rx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_ended_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void beat_ended(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SszcYGYE/rTwO4WqSFwHo0bxTtl4MF6xdQeIeptpr0iCX1GFQ7iiVnY+nfw6kgLm
OlrYQM6sCIVQjs9+wjHIAwzyMAPh7B/88wCYXB427RfolqDHABdCdun7vd/WhyIU
sbGW83qqqU/kt6fivhx652q2+xaPtniPllKQ8X//nVc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 562       )
0Y/ZE3fl9fZ59OUpSsnWBfMmzb40nXqONZtvhtO53hyBVVXxqZWT9gJqO4sZ3Fz4
wJnUBWwev5LI67KzYKz0Kjjx6UhHwe1YKnrQuOiTJdoKl1iOOFUa8hOrKvj/GApL
EOVA6FQTs/8vMH+5ZXiJ4WD6MHFNfbK68iRbnhVZf0HQPCS0bSDVupRDNDKTAhFs
NUvK8t7xYvQAnxe2XUXDSDhiT2zD2slrTiCk2PyzgBzXXcRnYS4IyOExYECo06pw
jrCQEZYdHIlcZGOU8vxJD+rKHVx/msmI8HtscjtPt4acVuRCuDGuiNPzrBZo0sUl
lyI5Q/wuDChBN1Y2noGFL2Sn7DNvVYQJgLnKWBxEfLrAYf2dx2d9FYRSS8EFT/WV
7PIk2PJjm/9wOurw+d+QpUT+MjOqyEqdFBxI6/EhG9kJwV26ZkzxokbZyOLq5SmX
6xX6le0QAYUgKWvhGeNwEG1wWE238nskNmHKznecm9/2G07NW42U1OEWL8GfxibL
CenAfz771n8UcJW8TMBXwJ7H0hdzwuSwtnL7L2JLvVcpxWLoSIL4LMbxh9xAqLIY
H2iYyFtYthOnj+8q1xHU+Y4bXewgA3QqavjT6C/eGMAy8R4tnmxbSk99FhtPRVhZ
EZDbcf4o6LS6dj4knwTa3aXA98C/mtGGol+8+VaZL4tMakWsgJgq1jJTKqShf/7g
0vrZg38CyvY2UTLYzv3HWIMY013PhDmb6x8K9OfntlmxtH+VaOo7YKk2Epiwjr7a
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YiDWTjzXxwm2Fl5KrUKrrz2daduUlhNOEB5D43qAtEXayeNvjT0TUEAPCXEapupa
UwdlUStRLjg8aOHA6X1jTocvz64RuQAg0fChdbeRi2jI/fotqdkWOwaDTIqiAkdZ
QppQBdZi4JuDbVMPWztmXFT55Z59NgKV0BWQJvCvZA4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 645       )
3wZe5m3rzQjf5awGS7T8cVDjm9ugEIHeqFsamhYZyHSAeqlOruDV+AWv0jADtOBm
kCvOI7rczR7qmlqSoZIz7ia7G2emVQz7liznJz4x2dEpH0zJ7mjVzwcJPHynvbGG
`pragma protect end_protected
