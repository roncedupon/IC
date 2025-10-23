
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
h2Wrzsw8v8q1tmie+UvvYc+3KpcotT1hYF7pv67BRrUVM00ZPdU2uOLpRDTy195B
l+sd+gM/A/6LTyuZdLUs2APnJq42R/1jilnnuxYquuu0QjP7cBDvNh1HR7OzvSI2
UMtSz2o04XWR2ft8x+DUo4cazAYqzzCoudRKMRKYEGjDAC9CIqrHzw==
//pragma protect end_key_block
//pragma protect digest_block
gV/w4wTk1PzPUJmO+uZHlLUIxhI=
//pragma protect end_digest_block
//pragma protect data_block
y+sVgyIIxrQkqPtLY6YSUVUOatZ7kGwZRybTlBI+ck/EIX9dIyCvdcdByfJ2+1ol
7oLiyUY5FbVElU5kQUT3rf6Y/2i5uaDnS4I8VybVmql7pv6Y3sr2xA80kENhNF7B
e0S/qK2H292xWhOwO77IqvZP/EwMn0UXS4a35lG5NY+bwWPrEDVsVNPPprNp+wea
0ggoF58X0beEXyFbiXmkiEDWauIX+w5k1pIp2SwNxe+jEHq0/UNoTNgYdJ4Ivl6F
KUW0+sDSXUga+8Grt2axyIrSEEG6IKm4EmpuW2VAu51V0bIBcRXHOyqquwPV0HAf
y4ISxhN6cHD1j5oNokzzYcibuD2litFuVQ+tXIccCqPjvX50pQJVSsb3giYZDTHQ
9tNWOgEyFWMKpMTbpzgYGWOzVMzMd3WBW0qmkkdETagXyNNGshXM2mdXK1V7qYZe
Tasc3lgK5q8GWaoqAszTZ5z6VNsYxkkxhXp+8MSsaO+SMDgHsB6y+LHSzTREo2qk
sKC1Fappjij0aAHjgD2t9WxoHKSjNtuwnE44YQyiGgwajiChqMSe4TUdwfHmuNx5
mX0USlNxNmsomLixsd3YfmlWd8qv8sew4d6VLkO2SmPRN8h7WhRaPFuhWlVhXqyv
5OInDz8gcukaEVonA3XNBZkqN2MUqG1BMiWQdBgX7SaTrltHSWAzX/1y2BrLKB9O
SyHZVB5QeFAtvatndyBj0VwVkWvpu9JY+WDSSivcLWcKSmMpjBQyeK7eHZmezHBC
XfDYDAofSck99UCYZMDzAxkM22UsQZb4QA85ebt5WngMu+qFd/oqhcmFcszCTR1L
Nd23go0jErR8CE8h3PIYTR6ylcXvz7ClrvOd3inSD/Y=
//pragma protect end_data_block
//pragma protect digest_block
tMuJbE0ygt6QznyYvqaZb0S3BXQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
K+qdRB/zOMXBW7H+QGZdiVofsWwKN3hbR8tJ5+r0XJbTTTGDcIP+CEn9dQ3XKL92
RdAYCu3fW9xGI5iOp68CCgXunCYjmmI29TI+z8dpZSzQE8wshMX3enXp00wW8hKw
niLn/kXfjQVkuuIW9+5NRYYW5SEupL7IKo1DVfTuADFK/NmCJpR/Rw==
//pragma protect end_key_block
//pragma protect digest_block
G04yF6Orntae63+3VUG6VTDz9ks=
//pragma protect end_digest_block
//pragma protect data_block
9MfxZRK7GlNWO+c1DH5UT/UW0rWgbGAlB6zmxPFJlZYfN3Q0rvHS2dqVEl5kAVCV
l7xf0zfPoKkrxZRD1orJhFTftlDVTF/tZbA/Tt7oUTbLek69+aE9wuLKlBtVSs0B
scNo7wBsWsRRJmdo5ruqPIybBkReu6J1ZfGZn6OVVelV2Zzt2uqmxs0ZOsBxRUsy
3hOc5oLw8mwOtZBGeyADeWmDvzPjKUNp76D2DSWAWqrrqRWOXSHHD2TEcFZ95eyW
4mQFOXFxRWWUf+q7OfnFQJk2y4ao0idzi42hBxpXd7XTK4csVEu2CPv6mxc122D1
+Dcc+GjlSmGnvdSrVwc5bRT9IAYs0NoaoLpIOyXC7hcNsfYqomhWKqDuPOmfoi0D
sVAD607/YSZMXeEnQ8f86/MdTP8g65JGH5HMO0bQX8o2qJsQdLqRC7X2COtoIjy3
2WtayTi5rFaXXZT3ldetSy5o6V8CR8qljTPaAhtmsi2eMGxTop5/CGYXDPAzZOfi
Nq6Z3gZ0perHpqnEJE8mG1iiCegIvEuRUVLegrAZtLauUMSMj41tyIf105/UnoQn
QLe1QX0lr2sKF9z2uPDtXC0rEyWwJE/qG9PrKq3aT7ka/Pdk0wUy98wzQ5X6ziWJ
D6t8/r8QnxIVeYc9X26km0t4eyYXcrd5r3a952ysyQ2LtBAQpdeJWNuRSUFB3nCQ
SbTdlPQGdS6IiPEqQ9SzDhVPp53XRzy7zeI0/ddXQDN/nNc/lERsRBb21msEJvbi
4chwvopYTIcTgJizpucyEIexwttUdNIEFb81whHvBZGcKTGwn1tJjVsUfun61ysa
7ubMvaSabQu2Xd1vXBuyx60POOCl/AboQO0gP0mlgbPn1CTmT9IM5T1mE7UKAlNd
G7HX3LLraxUxC3UjkGUfyHmqh0VDjIsNF5mZllpQRkHie4N3GIPB7XScCY+7A9PW
I/FrbRdh24ZVv8d++IfCgE/I984BS9QE1mQ+vrC+MovXWX74TztNFFMcFtV98OLK
f0e3cj8wXjHkYoh3+8Owdaw4sIhzgBMKGOmT9idPxt7VIBcj0bJTs2dH6pZI7C4U
ZtJWE15niAMguabikknfo0TOePTJZRHVQSyzLfhxef5tQFCYA0A6X5yJuwh7Ek8V
cdbEv7prNohy/VlqZFHhzEOtInUGFhPGn9bOFEqw/HmIrjjCexrKzDkHd3gyfqe+
qIJtuwLyRCU1N1ndNo9HUVKJ/I5UrbsMMMuB6mRXLsPI15t8t2VBvGJg7p9UOroZ
Inpjf3eJofTzh0suQD83Ss4RPGrkJ3fB25GDa35YmzkD8NYnZXU5KN6/844YXWjL
wp1YKekchXX2fMEewYo6wKwl4fHuhlrPMmvaMqlpVyERONvW4LvUkugy1zOf8yyB
W0G4ei7q970OE2MWclMMKesE5XwUyJEGXbAcIxlkV8mgd5ad11CzSvLi/HFfAkAk
SIGkaaPgCXGErbodYrhNBxN6l01W/cDMjo6oVDSSz8LswMryzsIizPK0DmPmPssc
7C2Lqm1tkQUxewtB11+1kUvTuBjV1xoZjT+91VTLIOSr+aiTlPnwdR+xu03Fl/7X
67Tjiry/QNLtY1PfYYu/FiqQF8V8sUMcWD1RuF9wwU5Q7y38oZiUoFGOOfIrKUN+
AvoSvuocZaOr+BJ7sqm/3iq/X3UHmUklMxqP096cBZos4mQ3EFTsr+orLsv7463J
8TdYAaZtqBZUbBBHrSnEiqnkzj/JkdspN0aZ+SeEdZ67hxvC1aYD3urf6BeFFrI0
Kpa/AMWIF/hDEVz9MXn7vF+/bdea2cTK9NypvKe699mstTJaGWX4u4u0RGk2A7wE
GxbhQ+dF49+7eL6krUfpsDPkBDRPTd1OPN/vNKM3nbCSVRhn0Im74YTikLthhvI2
DZ7Cp6xbgaT6fJRfUkwFqaj0aWk55p4cYrsQURXYJX6rGaNSS88HMlGg2CfvCyz5
WfQxwBgKhXRfS3W+98eAmeaVzqd+p8SGxFS6eVfrAl9r8OwZe2dxoE1G5QNmpch8
l1euUVyvjdvC7wGZYtuFGUcxIYz6MMXq/LLWvYYugjUBDdt860ZaNKEVjKhdPOF7
uW03AtQRo1mmfH2rbWCn5WcVGJlIn9GRrhcS0OyTeqM8J1XztVn4/k7sbh7n+4jU
14mXclokxqPUyq9oTsNZ3+DCMtWkyqDYxc1bCgL21RVcFPcOml7GbGAZ+hOlyR+z
hADrYuzsD6H3c9kQk+8Vf6lGl7kDxU90lwvV/9udUedciBO/fIZKlm1zUCsZ5N47
eHMhFuE9J5rGYze0FO2sUQ8qLmQQfOHNCEqc22jSE5zjFLKnyD6QDRdH/HT6h9MF
UTnpLV0n8GswOJtbzq39yXSzc0BrdFxLp9cRxcvduQXEnwtELdKPk09hfVfhB/yw
2Kn2JdAfoWf30uAOC0fUIwa81f8x95uwZhELCFX/zyPggn+YSFk+K2/UJtvUvnVt
HmyTJd7lKRWnCrlSkC/VuKR3l7bHvzFto9dnxplsb6Qo6JwS0IDHruvjvkHQ0+87
Tz2LclT0O6Kqk8BOaXWBpeH8Hir/bx7eLGjkcOm8Vd5d1s3UNDrk19OtGu/dgdU5
VHZbONHG/E0Isr0qBIkPqEt/RE1Afv3lapYYuGTOpCuK4GNpOVMQq7+EmL6AxNW5
IjI71IsoFrFqSGV9SXXnyDHRak0INLZwKX8MRl1e8QuV9jwXPinzeveveKp2vm19
1z93z3VwPvCKcbvWstBdVFiDTACu+l82WKbZpNMiaum2WvWcuVtpcpw42SMoj3Zf
30uQclX5VHeNwv4yYS6XtIooLIUIlD5S2BfhYrL7RYATcSXciULXYSjZabIpm75n
TvLqeH+eWLYGmJd69iADjhZxO5D/hyFEJikNAUrT25001EU/p22sMiXQ60Tu+10j
LFGkosSTAnv2iM4sJvOhU2veFmC6cAuZo/xOYkk7zasKmY3z2dwQFCjA6f7Tfpm7
Lej4COz9deYFWvWn3nGJvRLOiBMDNvxgQNIzafhddchNMtLAtBB/usOWcD4G7diO
advJqo8zGWxkKQbdgFaLMTQy/lnHABPfsqzENMf980leCHYcqwYliCSreAoUEUrQ
ID+x/1kQ8LlBWIqc2u84ZQ==
//pragma protect end_data_block
//pragma protect digest_block
G5MwJVfPCwXNwMENX20wCoCgoKM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_XML_CALLBACK_SV
