
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kVhEYxGXMcGcRymj8M3wNgA0C3LZTJdBXj4etIIwH4WPbVGSWAEq6QT1Z6V6bkrx
22jtTX2pdVc0L3Gpt/H+MdMBvLfyky2mPtjsLD3TyQBjIbjRXoeYV2b39VSOrZG9
PeILVqcWt8aEjthXDcuOE32edHdlI6+oB3Lf+3v2oKOmIwDhzOFNOg==
//pragma protect end_key_block
//pragma protect digest_block
1Bdb4BFZz4qFTgErZNzuNTRhVTE=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
K7sT2DON8VCzlqIemmi+SlCU3+o=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
O7L+Gszpl9JdVaS8pTXn0YXWXHOihPX+YY2DEO06Ny9vFYwWfKy+znCa/Z2Lb7pa
nY5oC/km5cFBarO4eR0s7A2MkHns0S1kDhp43CDDInljq5GxbRY2TYMPGOvd/qys
RqUgrwFwQkc7y/5yPFCbvUc9D9zYGX+L1TFT4+hLZRMIAPG5vm5+rA==
//pragma protect end_key_block
//pragma protect digest_block
nsbfDF2nZg9C09c3tDDXv2Y01aY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
vkbVE+OKhxgiryQ5aeKLyHXcGMM=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4G6ahZ97SZHiWdqyNubtUmkhJtOjqedqyclksFnWieRJD3NTNNkeh6T85+YBSmGy
aexJJqSEUfNFElv6S8iqE7fm4l22S1A/RufhLYld2KPyqJbWeetMaORPtfxjkwiR
EXwjvEZZfsTgNNrOXzIyy/FOTo1skPlJi0rnmXTZK3idyewdz4/GOQ==
//pragma protect end_key_block
//pragma protect digest_block
pzNwcBilvsNdcT5yUf0Tx27lB+U=
//pragma protect end_digest_block
//pragma protect data_block
Q7JP4jLOpm1tAUGZbc62KfgCXDTjSnDI+oXzp4nw6JxgitR/O+qDK046d/Acxvwi
WROoW4LJtCWRNG6McepvV1aPNEzEVKmjGsGBhlpz3cyHaHU27SVZR9gFSEgHUZSF
BxxSgtBONAA0unrPNiDJju4Sl/OZ+7LKgXNlzlTZqzWTwMNG08fhM8ZDxLAfV3Gb
vDFyGdJgLfdHosFmGlOrTvyUOaZxfi7yNObpWo+DHP/gyP60l/4jUsgUbvVR75yx
RvgnZh6EoNbGqeGLv8mYkQ2U41V+6sRfOuUAJINTYm3pEBA0n5Mq0Y0an9/cQeFi
uxmohyWh9GWUkH0P1dY3EG3g2KAC43hkL54YJanMKpv2YlnJYKJ6UwzLQnjy8ch8
MhKJVwJowYWiXoH/oXkgO4ss2oGmjj44OdrJlij89ulgf3nYr3y1kOvbMaYzHEKU
pQqZjUIoItTzFT2u9EwVDg88hM+GjOEVAJaHNBiegW4VTsKaO2IsRaEaXYnAFToq
+y/TK9TzdvU6tpehoYbWHGDANgeOHQBUgLaZs/bCWOUUC8mpwop4HL0V+oITojhp
8GArkXajtrYp/g7BLR5NIPwcBCXbIWyJnhR+U/dXoMOslcTM1XpgKMkV2ZVdhfie
VeRtqNdANqk/NlPiN0QsFII14SLEo7eyF4yvOoHzQr/6nBZuqnp62ZCPZsReQ7qQ
V8qLNbnw5iiHHmAjKi3xWYcfV2P0kDv4reUaaW8+zvA9Pz9gFbv/PqCwe/D4ReRn
u7+3BAkNN8XjMDRJ98nTxByk8LoLKoAMjvuRpCbNZzlWb/UYp2sMp4QAGo9/QHJH

//pragma protect end_data_block
//pragma protect digest_block
Caxbh2DCRWnwFLQzh0h7jn8/Qho=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mccLv+rgeqyxTcNFw26zzhyZdbAnxzq8dqqzwqwLuaav5cNQOwGhZg2o7HQXa2me
DZOuVuWxnvtiq/2LYAZjSVxo9TDfpyzxfWZGUS4+8bLCszH67jSxc3+nxEQbJUFY
zrndHNytMcmWHG3hQAYuXCo+T6hVHvSiOFc0D+Ikv/Fj1tf0UFos+A==
//pragma protect end_key_block
//pragma protect digest_block
AiM9Uz8W5eQbXpC8ZdPuT1O1uTM=
//pragma protect end_digest_block
//pragma protect data_block
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
xyXBgkNrTePyh5Bji35X/fhMiWy4PHd6BALEStFSDup5zhtjY/nE2W3xseRZtvx4
g0YMg2kTluOGLV4vtbmI+EQTH43T3e51TOlTj6CBhVtpF55PnlqLB/2G/+sX0sGs
Dvb3N4r0s8S1V6AgVy1K573iud7g0hT8j+NOfUbXCRU49nvFR+5nVy6RTZz1QrQA
W/9l/WJzwveCDf19zM/jloyDXjKmNQfbTR3bTRIxckN+axulRPHz915vhP3j1bf8
OdYjdfxqZ7UVtHy0kvIrey+HpOsO1sSYo9LNspsoDRFTvJtM5I68m4bIv5ZJRsd2
cF7Jdo83fIbLCMJXB7qKQdSE0pvLJ/2rJV5PS1NZbrmjRgYwmkOBYS2RPLtmA44x
i75cE6muzl15IyCv9itfuEpVCbTVwkQUEWeDJpX+aRoU+ylEPZogw4OpMCE/PalM
XugkNMgUkC05YNzRLKX3Iup+mb1W//wsd9cOklyO3YK/v6x9wk8j1IK/jmdmaSuA
I+/RBIQtqEkW5DjPjbZSNSkPGPMwnEQu2icZ++TXS4ZUSGcw7epLnP+XbsI/jGOV
zMqYXduM8/ROFr0pOe5s3WnysOumC07jq+2itifH8XJ0a4r8H/v2QZulYGa66U0a
9WatbUZ6gWmwrnUhbZRt/AvOHxi8QAnZJO3rLPiF5HB1wLxqdv7KpsrqJesIOX9E
UUg1wF4L8unESLUy7nTMaBs4pflCR6Dfmx1HeM9e4vpDFWRtamZHLfBofqZcHSop
j1twPihm0iCnGIiLWQj4ZMZBaLYxT1Y/FKqTwxpTNajGPEN4dlSTvstacGzznM3c
f0XoDMPjxNJoFVD1SmXt4V5niJ/sq6LclXaz7P4CuTYkzHJ/nVWoynuMI2pKUT/H
hnS8zdqCmHoeAQxsGEpuzuzBHQPdzMF5Qhmr0/7osnYtk+kWehLs8IO5yX1xlwXX
b9YoLQUD49wG5COUxeYgNbU7artebWzGlbtUTzGBl1bNCLNsfJ5AU3TUcBDV6qgV
iE58qwzbzM1WcX1EYjtAo6TCZyP1piCoeRdryxtjZX9xSWd1um8lwQQegxMp5yIB
UsoKbaRbRF7LaoEJXDyek9gtT5Zob2Cm+3g6Ms3aa/EwJWG4NfSkirUuY3V1+1Lk
z67tsI326KQdnwM/CcEUxjpoF59maV8fl1nY1AWG4tVErwh41+6H1WIii6FNhfDJ
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

//pragma protect end_data_block
//pragma protect digest_block
7ji86GkqUYIMVUdhSvY1QkcTYkY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_UVM_SV
