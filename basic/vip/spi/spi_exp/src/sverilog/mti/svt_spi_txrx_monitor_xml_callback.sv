
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_XML_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_XML_CALLBACK_SV

// =============================================================================
/**
 * Monitor callback class containing implementation to generate XML
 * output for svt_spi_txrx_monitor.
 */
class svt_spi_txrx_monitor_xml_callback extends svt_spi_txrx_monitor_callback;

  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for svt_spi_txrx_monitor. */
  protected svt_xml_writer xml_writer = null;
  protected real xact_start_time =0;
  protected real xact_end_time =0;
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_xml_writer xml_writer);
`else
  extern function new(svt_xml_writer xml_writer, string name = "svt_spi_txrx_monitor_xml_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_xml_callback";
  endfunction

  // -----------------------------------------------------------------------------
  /**
   * Called when a transaction starts at Tx Port.
   *
   * @param txrx_mon A reference to the svt_spi_txrx_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest
   */
  extern virtual function void transaction_started_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  
  // -----------------------------------------------------------------------------
  /**
   * Called when a transaction starts at Rx Port.
   *
   * @param txrx_mon A reference to the svt_spi_txrx_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest
   */

  extern virtual function void transaction_started_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Tx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Rx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hRQwYMQrBrqVO0+E0Vb8H5S0A66JVudPmqiOk5b4lHDXYl2b3IGU57fhnZvbloL3
8APvd6wSZ5jJ8xhzyXNVKqRWD5qFBHcxefgZVg5jQEX0Y6iAyyI0pysPBKWcqPDs
h/Vhji7piyZGmsVN//biWbXw17HiqCJBHvOxJWz72sQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 483       )
BmYQiGE0czlLLp8syLPxXnj2O0Li7Azhg4ah+a4r1LRL9qFTvVK5Fd80ApCa3nCk
aW87BRIErKsRoRK5znTcuUHrzHPOTUYmLGaUyvu+LkWC/u6uASapiG32lvFq1CLe
sNK7/QFy8701OJirARM2EXh2pVRvXGdr3CDl/rajpc1qEXf65Dgk7IuHCf5OQ+X+
q1HT+4N9YTNhdap6Z7EbLdVkRN94uBoa2AgcQR9FLWRXuxRAdEYE/RvehNyDNqds
qwpLy8Y0sT5uLnr9E1Sme3Pr5e3km2r6BIEh24dTr9Hwxf3J0umFUbTEBN21WdAp
8khp2g3DF24XNOANhstrX3ja52ytIRzDSfYOECAq7dS2TzEblakeaRIad0PN5zvz
EKpO8w2CvVdzVE7LoDyK8Q9QhirTZmSdgE/MuN6P2fj5igy9MZ1een/Qr42x1x0p
YsqY9Jz6v5V522rQMouN6GBSmvgfLwWBH23dvijLVAETWBmNtw4AJSVwgkfDVzeY
jcnBBICKX95Ry+PdmKlP9ohPuzW7WTeaJQ0bOl1JyR9nrd7AxcaYHIyH6yswoefX
A0Z7mt1DbTHHz6LzTcMPsREFiN8MZ0YD0PswTOF8G8MV8pM61Y1MRKjJNZ7dVuDs
KfHxQLK2BDG7P7zFPEUqXg==
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hl/RgBGM8eEtG1xsDHGHmRy1q+Ku4Xn+XN6c+fjgWELOSP/bZ33RN3U2OBMbvUu8
FbEWzAX3HdIlfu6gxNZvqciDRzjtSUjkFFC9L90MKis5xvpWLZduSZ2BpzzdICmr
4fWxheCf+pUo6OkRLcRQor/wOYDj6l3VWz1dtUVnl8w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2685      )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_XML_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NDInjXGx6oaBRAF/p2U84hu4j1exEKM08fmOjTkbFkgG3tX3t+CYEmP626rLsJac
TWPvHL0X1f529oqFhMLmrXwRtph2/vG4ULEeeAjm2R2Qd8p3eU2zuQNNrhZvMwSa
nJAOm7CXFI2w0KYo8jAPgxpAsCMLhasGJdLx2P+sus8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2768      )
6H/JCLVOU7UPP4sdf9qgxxl2JmSFWcXpZcx5O4tYTBx7VVDdrfxlfawOdSrBVHnW
MweBo/zIIyCbQKKTwyvtJSipPRL/9lA5KVBX+ECylT8kl8o4JiHdDSNybaZ0fMHG
`pragma protect end_protected
