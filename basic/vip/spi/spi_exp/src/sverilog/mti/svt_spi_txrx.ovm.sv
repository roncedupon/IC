
`ifndef GUARD_SVT_SPI_TXRX_UVM_SV
`define GUARD_SVT_SPI_TXRX_UVM_SV

typedef class svt_spi_txrx_callback;
typedef class svt_spi_txrx_cb_exec;
typedef class svt_spi_txrx;

`svt_xvm_typedef_cb(svt_spi_txrx,svt_spi_txrx_callback,svt_spi_txrx_callback_pool);

// =============================================================================
/**
 * Defines the SPI TxRx Driver, used to process
 * traffic in the TX and RX directions.
 *
 * For the TX direction it gets SPI Transaction from input TLM port, process it 
 * and send it to the bus.
 * 
 * For the RX direction it reassembles SPI Transaction from the bus and
 * then delivers it to the upstream layer via output TLM port.
 */
class svt_spi_txrx extends svt_driver#(svt_spi_transaction);

  `svt_xvm_register_cb(svt_spi_txrx, svt_spi_txrx_callback)

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * RX Upstream TLM Put Port
   *
   * Provides a mechanism for sending SPI Transaction that can be recognized by the
   * Upper Layer. 
   * The handle to the SPI Transaction TLM put port can be set or
   * obtained through the driver's public member #rx_xact_out_port
   */
  svt_debug_opts_blocking_put_port #(svt_spi_transaction) rx_xact_out_port;

  /**
   * RX Upstream TLM Peek port.
   *
   * Provides a mechanism for external components to retrieve SPI Transactions 
   * from the TxRx. These should only be used when
   * the TxRx is the top layer in the stack. The handle to this
   * port can be set or obtained through the driver's
   * public member #rx_xact_peek_port.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_peek,svt_spi_transaction,svt_spi_txrx) rx_xact_peek_port;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,svt_mem_transaction,svt_spi_txrx) req_item_port;
 
  /**
  * Port to obtain the response packet of svt_mem_transaction type from
  * mem_sequencer
  */
  `SVT_XVM(seq_item_pull_port)#(svt_mem_transaction, svt_mem_transaction) mem_seq_item_port;

  /**
   * Port to obtain svt_spi_service object. */
  `SVT_XVM(seq_item_pull_port) #(svt_spi_service) service_item_port;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the SPI Transaction is first initiated (TX) or recognized (RX). */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED;

  /** Event triggered when the SPI Transaction is completed. */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED;
/** @endcond */

  /** Event triggered when the SPI Transaction is first initiated (TX) */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED_TX;

  /** Event triggered when the SPI Transaction is completed at TX */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED_TX;

  /** Event triggered when the SPI Transaction is first recognized (RX) */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED_RX;

  /** Event triggered when the SPI Transaction is completed at RX */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED_RX;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  `SVT_XVM(event) EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

/** @cond PRIVATE */

  /**
   * Response packet from mem_sequencer
   */
  svt_mem_transaction mem_rsp;

  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(svt_mem_transaction) req_mbox;

  /** System configuration handle */
  local svt_spi_configuration cfg;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_configuration cfg_snapshot;

  /** Shared status object which allows components (which each reference the same object) to communicate state changes. */
  local svt_spi_status shared_status;

  /** Methodology independent driver for the Transmit-Receive features. */
  svt_spi_txrx_active_common common;

  /** Methodology independent callback container for the Transmit-Receive features. */
  svt_spi_txrx_cb_exec cb_exec;
  
  /** Peek Transaction */
  local svt_spi_transaction rx_peek_xact = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_spi_txrx)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON | `SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param name The name of this instance.  Used to construct the hierarchy.
   *
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_spi_txrx", `SVT_XVM(component) parent = null);
  
  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif
  //----------------------------------------------------------------------------
  /** Connect Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  //----------------------------------------------------------------------------
  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

//vcs_lic_vip_protect  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CoNxrJO7tstNoXr+50oiikAfnJwILoQGIP1nmrZqRjD40Vu6SJjwDwHqSABevvbb
Qbi47wxErpoOU/QvJ5EBPkhOKQvqnZVmTKWK+R9HbiWkK4gtMLr50n6DyktjrN7h
zTG6cMtmDRqr3VCwHKc02KiPMs7pMj/7ca2e8lGIKZQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3098      )
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
`pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * This task gets svt_spi_transaction sequence item from the sequencer and make it available
   * to the common driver.
   */
  extern task consume_from_seq_item_port();

  //----------------------------------------------------------------------------
  /**
   * This task gets svt_spi_service sequence item from the service sequencer and execute it in the common driver.
   */
  extern task consume_service_request();

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction descriptor
   * out of its TLM sequence port, but before acting on the SPI Transaction in any way.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void post_seq_item_get(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_out_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_out_cov(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Tx Path.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Rx Path.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has finished tranmsitting its last data bit over SPI lane(s).
   * This is used to update the data content dynamically while current transaction is in progress.
   * In Master Mode, additional clocks will be generated to transmit the new data bits.
   * Data driving to remain as it is.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest. <br/>
   * This callback is currently supported for SPI-Bus mode only. 
   * Only svt_spi_transaction::data and svt_spi_transaction::data_frame_size fields are expected to be updated by User for this callback.
   */
  extern virtual function void load_tx_fifo(svt_spi_transaction xact);

//vcs_lic_vip_protect  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bkIXzLKpQHmIjq3Ddt1IzCedHkVQ18RdEfEzAY6/bfSCIvvrM/CP3K1ROtM9YMwC
4Sx0mJBgT77xlWkuEBXCPsQHUFxpohyH0OtQpexEfECOwqH7rVX0OmB9dAfaWgsW
JYYUNS5ODSuSRIgxSYrw3i3CUiUL2hGGIvddhB6VMvw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10262     )
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
wC0LzHidei4PQEYUCRUA1NGPPTzQR8O9Tp9xvl4ZK77MFxBAnyylTV4JMxalMhra
VbFxFKtCnNj0oWxo9J1JQ42WnVjioPwUFS6JxqEUU0mzBguVX5d2j5mJGB4L8iBd
19Ldkfwj5DOYlKTnaDJVTMSPUyxJzuG8/n4inL5C5q/Vh6nA9WG2MrPndnKIVDTu
Y5j1Po1MY+M2vTBEZ2vacB2U26BYkhcoFuOs4OtncH6pDktn9pB+GF0UH8aMAUeU
nIf4OjIGRbnkqjVrn5Vr1/azTA7OyWc2oa5AOZ+LVpcfjWshNI6IMxQeDqC6+w/c
vmnPVmtZX8tLmxy6oKsTi7cjfSoidDiXGN3ZAt9je1emh5ElZcmj+k+iKUgOMB2c
8z/ocw/p6PiFr0NXSjf0O2WcHRxcdY/623kyl+rJSUWmtzWncTYWx1oOKc8OyVMF
z+EV6U+4llA8GeLjzQ1fqu7WozpqmVp4AulIxv+jgIPNCik2PbhH8gV3eO8xOsUL
jczn/FcFMNCiJn8hQhAI5Mo28RwhNapmbrbwxdKWSMozxBhqvsemQmAUFghqWuvc
orYeRPuZH9IJAmlvf2K5kde/eZHMtNnHHZZlZ8vU2yKtKO6tjp7Ahg05kz1FDihR
ABNYxjk7R41KivZ5BICSoLWND7XjtXc+4UgDILbUxjH0j6MBQGN2o24mTmuRthl+
lModDkvUWRDLttxyhw1YWTbep5wUFru0Uu2JkJGhJ+Zh1W//Flz/3NarQdXO+TUr
h1ZFjCbFXUu2VeGRg1zHbZxrPaDIuXu5NXK8XJhjZizhWzC4YyHi7OVLkExxNj09
2lZJVSPX6ZmS+SrTQQSAvu6LqUOOv6XfFAQSur8Sk765ik2Hg4emuOEnaV6kuIIf
dM6Wc/FAp3aoFfO7Jzw1CK41d3CK715QeYQ+ZhnN3Tp2rcRgEz12vnQjkHb878A7
8MaFv/j7KOXeGJZLcAuKp82so/dp0IZhqWw9EUonMU2JPo3zrVv+wslORSj8Vvr7
bwQkKHJ1RcmH/qaR2STdxupZdzERJS7sXZgtOIZA5kUoJ2rHkyiJA1t4FbXfmN4r
zFZ72EOWs8SBRjDjnqocwwFfCykH+65zGkm5tq2fZ3dECnabPpCYccQd0mBzM1ws
b8GU6wQ/7hdnq7AdD7mGOGp8PMobgwC32jpkHlDXiT2yaAhO0JuVrvip2CalvRdO
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
j5DJenIJ+ty2OTPZq2MgYw==
`pragma protect end_protected

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RXpbfu5YmEzfo5wrRR1OsYTTw3btzYhoYm7bPuKXxTqyu+dgZO4bFjfQaOeworWO
5SwKORN5h5Nu7OvATRrUrhyUltBncaF122MRrKy+lmTtz1V6LB8uLB5qef6oJYGw
XutE4piIuYNVTVEQ1O3r7fpXNuk807kHc/upVDAAU5w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10715     )
pATyzsFopk3NEBNcmGe2KqR1kpuy3Hq4OhOgqY1yHCOhR0L594Ra8UpJFiaTCUDh
78kAQjW960KcjpLcQagcns3QI8Og3QjuePmorSrF3lYWnm9X00nKVaakHrjLj0fH
+DHoh5i+AwnLdMpigIS+kMLTyqN/yrWOrvFo5A3tXl4qY3P/FJQG03ZAPVxLqrTX
n4PQvDKb5wP98EYX8i4z3Do9/wI2C6YiO5t7AVxoGOJV0DpiOHy0IjvFX7CH/VYN
wBfhO9hAN8qrMlaNy5whNx7JmMjv+ZY3pHTOf0bqkeRyqJCGwPPkP7adsUJ8LJ/4
+6IEbXt41DLti5EQ/EBDnXoQPNPWiLqjlOXt2z9NkjH12KlXWCbkx4s3YvJTGILO
gjbugWdaEJz/MNHKRZjKI8nJwF7Gm6E+MEnow+ULbPlDD7+17nhWTLfucMDnwAWd
oWMWRJtDthI+aSuGx396Om+r1cm0cTW5sKtOGvnFqEUow9O3xAykQ+GpmVS3cCey
1dlokjloCvdQKps0ul2emejfcKkyWaIhu70Vfe1igFMezretUWnlWvxmkZUPEBq0
l3zLblCZXZQoxjwIBsOKgmFKfYYLQE2iX33O3xZWKHA=
`pragma protect end_protected

//vcs_lic_vip_protect  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MSOkGx2dUw+VRd8rh7PoI2dOXpbAy28+js0giPPBvBTStks1uWNjYax+pMYJHme2
3DRl7sjg7qdyhu0zcLIagqWtG3fmaM09j1Cygi7t531ZjUFhQMxpydnythmaHQL0
XsWR9tA7RjoMWgUZ4slI5Sjl+AwPH9ngKOPSfm0RlXc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25658     )
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
RTVMnY7b8Di+HwcQ5yTN1g==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_UVM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LwjSX9O6j6QtRdGXBdrYyzNkLp5/+QhRgoassdIZXa+FGTNuQkrPl6ZRhGZEQgkk
8sVyYlExUvyt4SBQHBHDBccy3dFGGhctoUIHgC/UByekBxaMOkfJLavwIGWVGBFV
bkwmYbljkTRIuXhX/LkmJX07oMBzs+PMbVtn/YF3vQs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25741     )
84pXly8cv9hHJ4B6GcZ/kp3OFkDoBNmFO/5zuhkEY0kraKNn+llEsJz3PBF7ZB2z
xcOxsWWI/hJuW9nFZkHpCfLxbgaSvZekZ0dKLX5dB8GS5XdL6jtCK3AwwwrLYrvA
`pragma protect end_protected
