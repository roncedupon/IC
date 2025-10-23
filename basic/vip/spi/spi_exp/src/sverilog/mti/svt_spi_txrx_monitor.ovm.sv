
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
typedef class svt_spi_txrx_monitor;
typedef class svt_spi_txrx_monitor_callback;
typedef class svt_spi_txrx_monitor_cb_exec;

`svt_xvm_typedef_cb(svt_spi_txrx_monitor,svt_spi_txrx_monitor_callback,svt_spi_txrx_monitor_callback_pool);

// =============================================================================
/**
 * Defines the SPI TxRx Monitor, used to access
 * traffic in the TX and RX directions.
 *
 * All transaction, regardless of TX or RX direction, come from the same
 * source. In an 'active' situation the source is the driver, which is
 * processing the data up and down the stack. In the 'passive' situation
 * the TX and RX traffic comes in from the analysis ports coming in from
 * the lower stream layer
 */
class svt_spi_txrx_monitor extends svt_monitor #(`SVT_XVM(sequence_item));

  `svt_xvm_register_cb(svt_spi_txrx_monitor, svt_spi_txrx_monitor_callback)

  // ****************************************************************************
  // Properties
  // ****************************************************************************
  /**
   * RX SPI Transaction TLM Analysis port for Monitor.
   *
   * Provides a mechanism for retrieving RX SPI Transaction recognized by TxRx
   * Layer. The handle to the SPI Transaction TLM analysis port can be set or
   * obtained through the monitor's public member #rx_xact_observed_port.
   * Used in passive or active mode.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(analysis,svt_spi_transaction,svt_spi_txrx_monitor) rx_xact_observed_port;

  /**
   * TX SPI Transaction TLM Analysis port for Monitor.
   *
   * Provides a mechanism for retrieving TX SPI Transaction recognized by TxRx
   * Layer. The handle to the SPI Transaction TLM analysis port can be set or
   * obtained through the monitor's public member #tx_xact_observed_port.
   * Used in passive or active mode.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(analysis,svt_spi_transaction,svt_spi_txrx_monitor) tx_xact_observed_port;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,svt_mem_transaction,svt_spi_txrx_monitor) req_item_port;
 
  /**
  * Port to obtain the response packet of svt_mem_transaction type from
  * mem_sequencer
  */
  `SVT_XVM(seq_item_pull_port)#(svt_mem_transaction, svt_mem_transaction) mem_seq_item_port;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the transaction is first initiated (TX) or recognized (RX). */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED;

  /** Event triggered when the transaction is completed. */
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

  /** Event triggered when one beat has been Sampled/Transmitted at SPI Interface */
  `SVT_XVM(event) EVENT_BEAT_ENDED;

  /** Event triggered when the POWER UP Sequence is completed . */
  `SVT_XVM(event) EVENT_POWER_UP_SEQUENCE_COMPLETED;

  /** Event triggered when the POWER DOWN Sequence is completed . */
  `SVT_XVM(event) EVENT_POWER_DOWN_SEQUENCE_COMPLETED;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  `SVT_XVM(event) EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

/** @cond PRIVATE */
  /** System configuration handle */
  local svt_spi_configuration cfg;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_configuration cfg_snapshot;

  /** Shared status object which allows components (which each reference the same object) to communicate state changes. */
  local svt_spi_status shared_status;

  /** Handle to an abstract common class. This class is extended in two different 
   *  classes to implement shared functions between the driver and monitor (in active mode) 
   *  or monitor only functions (in passive mode). The containing agent class will construct 
   *  the correct extended common class and assign that to this monitor.
   **/
  svt_spi_txrx_common common;

  /** Technology independent support for the Transmit-Receive features. */
  svt_spi_txrx_monitor_cb_exec cb_exec;

  /**
   * Response packet from mem_sequencer
   */
  svt_mem_transaction mem_rsp;

  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(svt_mem_transaction) req_mbox;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_spi_txrx_monitor)
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
  extern function new(string name = "svt_spi_txrx_monitor", `SVT_XVM(component) parent = null);

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

  // ****************************************************************************
  // Configuration Access Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

//vcs_lic_vip_protect  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZaTq13Oakw9EtJo31R1r4niScTc/Zh+vrVARAgsuZxI2Yu6C41E401jGVJ6Urvx0
FDXD80l9iWvev6stQCNbv7ncApO8BId8JP1HSajfDq2s2YRYDs64tnmzaCcXFCKi
6pO3l0cWTycdL983Vx81dE7Zma6ZDCx4SJ135EG026k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3456      )
3Mb213leC+oqcSYkZNrJlDHZfeXIQCqSwUwYCt9Jpz9rAT5OquyoUQv4lnM0MMqG
8f8IhVhF9xYZJFbWawu0+iQipgJpSWz5sLqSzuCHT9YSC/C1V6g8MGvXs/f+JhyG
OtWDMsxftl6f9ZyNHE/Jbu9ZYU4HUakmjDYV7jxrA1Bx+JNgzenhBLEcs96jGx5V
/BgIp+33eB9BYmXTsrsPgmflqG9Tde9n8UUs63S7iuCy54mEpQo6Py+mI3/cld3K
Wmbex5LP47nLu2UnNd/srYciyS1+nOwqOEou7oO4RZ50wW9/x8BvwwK3hR5f52Hd
4o0jrTH3TK0Rrp4Zmbqn3dvXbLZldWrGmow8mnEXKTMKUr4Ednkiv7br2Iizf6vW
UbIhYecp+oQ+6KbP79C1G+Tn8tk7PPBM1x8F1C4BW5oJ+bKf6DOfv6lEtytRJi/J
Aw10OXBo5Z47oP+E0oOUgCw8+BlywfcaaQS3zeVGwM6GRCT2NT3k+0L7R8N+LTsW
3tvRHI+tUMRImOwsK6xpyvSH/lkrZoKQ+0PELzHLf1nJvpivy3Q10Vo8w6QMO9pA
TBdS/m/sfGqRw5rVZQRb5w55nYYYp8R2uBUqtM+gOmP6vLjR/YjSqT5cDkfdwLtx
feRIOCl9KP6cyyjJfOVd3BT6I2etN4gtNeV5H62yVxy7wCRpzH1MSMJmYN4cdy2S
lxHfegN+jFiRcGNL/txcOKmTXyjfDD42nGhLBVL2QHwd7GiSIAviuMH+ConpbHTR
LLyBslrofm1XXzLT4iUXzLkSRDE6WaT/Ppf51HiKX1KWf+hwjdOa/iK63LhD7LxV
DtfxgdPFUdXC9cd2YoAR324W5gARc1BfbP5ylklzvcgXWhp4oZhXS7N8kY/hrHfA
deyRwHc67eqpw4/grm6Lmsvpr4rMMRAhIDzQ+H8J0ljDywNe/YkWOa+5RVlt2EeF
mv0sLfr6gcIHQRTv+SBp4kI2FVztcSXjbFIFfUGYkNNDnC/Il9MIYcyHwW57t/E7
uhn82d+OWBSpc3h9Akd7wqRzl+5Xt7XJwOSyrAXGGxuR/aDP7uzDvn3wbkQ1nL+i
ytVQSvXrt6xV+TZuqeVw+F7lwLgsEO68YdTycHuEQmznau4tPxnbRpNjWAoUUn/f
g+KtbaJh8timEBbdRfp5yUb6LPmGT+OwC/uDH7g3YqinEWMY7E6TEIyexvm0VRDD
SkRQfP1oKgZo2FG6jQzVUxU3PUHK3eMU9ljvEN7rJsQ1SgpqBrvMEPixfIzOBpN/
u24zy3XxTfs5DPpXmAlSgDUlpnJJbd831xrZrEUFIUmHPOWHM9wbOxMeUnTfu0gy
Du1hGJ/IVWYIDASQgv0bJtWVBNed6qa1MILpjmhPJmfKZa5X3x/2jmQHjfR+uxKm
1HhutEa7uqMl/aoQx+2WWeGrg4FWm87i2Bd2rNf/RxFjwWKwCcR9fEEpm84G/N01
c5+JrCwCGnYRTGmt4cBk4YVFVM8ooY9yzITqA3vOOxLyK9rIveaa5XS9O2MWUeTK
3MdK1Xyz3/RL1oCDk4+VjMmoxF/A25gdt9H+e7zcnBuaTeHAFbCnKzeCF5QjEydW
cbHvWCXnGwLcCcl1aLKCUhL3Ln5nWcxx3dpUGkEkmLE7yeHZcHywE/V2RH8oqxEU
tBRnl4Sua8v1+51LPYdpiUjSNWKj1rCsBxeOHnyopGCKpGEqiQ0WNeXGPAlOUr3s
MpmtK7zos1k7MWwV2ZV9V6WIn9AEoXGpkCmct01ua+sLnfaoponLy14vwrgmU9e3
LBERTDqZ0WYW3Z800fEAUfEFEgbfu7ckt+Z67yZgJJaHNv1lUDVHvEJgFuw33wuM
zjwh3MFQ8rYwqEFVblES6f8OZHtPLxyn+Dwa++OPQACgyFfjW5kUgM6jHjuKGVMP
WYtqVQI9JLNIOLHzSOgnJ+Aw2X3od7zEnP7Vmh6fiWOSL1Q4F18f2mvv6Y32wdiK
ueDB2tAZx/ESUXk/Rc3k0+UEz+uei9QAytB4ocH8UMnzGkJVH2tKF2rQCbmXix+/
hokrWZIkj6QgxTlKkeLzYgXis+DwWeKlDfeDjB5Yb/SuwwvluxeWf2AbtLR67182
HZNmqsr+ptl5KV6QMfMppNNGC9yPh0lktASGlmta9hD8hVAphmi9FVwR/y/rdp2D
VkYkelOmoh4pZFf25TSgjyecj6DTJ+6A920zbjVPTJ5KRVWKL4+z8RzWiTE2Njl8
fZhljgMAhFt63/Ef+P9YqanKJELsVV2ZszOAHAnaPD/XPAgTbkGyPXsR1FhKo0is
aMTggHbwTdqLKWDuYz08GW4DzFTOjOykKOWTKJrComcDj/4oxnHwjGKNOLGGIx7c
YJ+jnQvHPtuaHXFmwYgw9Iow4GutyfoGAqeHispm8rpi49tEsWDZh9C3WTKoirEn
GatbqoaSFH9wJ+X0yyCbgzFj81FAeMXZIBo2Nnv7Yk2BKYgiGrjSrxPm0nFO1qnZ
KycP7VxyjBMmTYziBiD5YNobsiLPUxA98CHFx68tDMQWfiWphOVcXXpwikAIoz+E
Q7esLp/obYF/MKhSgCLLE71dkC84j1ZaMubUgtyzEnaulnO+LaFKcw1TQ5p5z0Jk
DEUA/lIsKxv4UT8gKiEqgxFrBarJpK0yKS7bHQCwl1hBHmIJ80HwtAM3T3ivBAkl
aAr+c8+z6q9V0UOObkhF156HCR8M4AqZRYXv7vtR6Gv7KWVEXJOSuydG3hk4F4sD
5AtfpKoUa1+973XSQ6Mgpkr4o864Cgy71p3DsTyojJYjX0zcqJTLydsrkzv3xy9W
Y31EH+4jgoCqntKYajMX+M+XKaXbvQbbx9sFEa9aFaXXS4/Vu7DL/tUxENtXZgZF
WMBV4XBQYidrLMKXkACQhqb4P8kXuDJ6+3fpLYsNE48lLf8AFyDbWpf2u/OQu2Ki
/KMnKII0zDQJj5gWcBzaWuvFhnA2Pj7hLBUEbYtNG4G5Fp9WloARDT87UEMlmFLx
L3nFi5UGU/Pag6uTrh/fdKrsloDXOrDE2Bur2VOKQrymKYnLY31USFr2yjk3AeHX
/2zQI4kvM/SIy0JMywUF2jbVdurG7sMIbNn6UtQPPYYKXw7As3JZcC4qGXe57hTI
TvEhCG3mbhoYFKMbwc4+9I91XPXo7NV8YEC/y2PzSRWKZH1drY8QPaPq7w+9ApUu
YDSujqwJBhSsxtgXbiu1KPFlxn67E80OPEMnvHdprAX8MO3vLFJYChTg8mfWQppa
RmiWlFB9mHuDiTawfZi0176q19o1ejA/nR+4VQw0BUeaBN5uzM0rP+BphDxU55gP
yySIdHTf4/ho5e3nf1+eBF08KkhTApe+Ayvp1q3UJcnfOKHwWcJ8kR4ahXybU14d
VnSPCfYiMwKxBXJ9apEN7MZge4shhk4Yw4lvUNih8Y+EpG9LU4EMAO98NoZBMAtp
ksPtbYSxuW0zZs3NKfFg9igA5hkqu4XxnxHhdDp4o8q2OBa0a6oh7/AxUYAhHXOR
mgHuZEgUgtzN8TTQVzEohm/np4SpFKC2FtQD47bQfrPmi6b2VAcXfA4dN4aF7pkH
gIttvsvhuOOQd/cBeUMcGf/bS/poqxP46XeJEKoPE0QFJhr2PTMlYElQHFd6JCsQ
iHJ1tgL52OXDx+7FkL2GjLeZFSlOlpvFn9+x6FcbXobdhtkQkdKIiCb0icgK4Q9y
MQsHfUvZA59rlr2TMTRfMGQXC/6mz9CA+eoH23EUZnkA4GWJ62IEdLLiXI9a65dk
8NJwKmLJeWgr9uTDHks8gDcm88hHamH724furPkb4ei7Zr640Jvz29Z4LoY7vsuV
uEAVnPDvbeFbZ9+uTL5XRyR73xv7ORl2GgkNy9Ac8kvy6ebzwSgDUOXrwiJCCC3+
hCk/WMHG7/7JriaPIv5JigfMJfW8KRSFktHPhvGNoATMKtclAkzCR3mscNFWNsOQ
ehF6dXvUJlCd8kKMgkBVRuDmP3/A/7JuHwbZCyhU21VB2sFHiM07TI4oKZxWy31t
rClvnYxYKj6dWlOKq54wVa1ef+ruT9NycylSpTuqJ7XQtn9qEsPOF01LH09/8WoN
riaE2sZi1KT4B98Jmmxlsg5QPmiUnqekA1pGFVc8CjoAWBtEKv3jNr0vX2F/OfqW
ddixmwQj9DYSOOPBSbEvVJnRbZ+LIfIpZpyt/rLNMnEO789URNF7IJCjhpur0GQv
IWB2vcGUMUOIHo1sdIWXvx9OKQ8b6Dl751L0rn/mEifOaFZw7SV6igMKLOgq+46q
mpu3j6nsSSoHQVGK4t25wce5O5eqXafY0ap9JVXoZT+lzgX63mJRkXf4wGC87Avl
iBYUTkrM3Mbb1XGLuqRvbazujfAv2oGXkUxFrA8v+/hWOQwkMufl+9k/XK9MGLeY
M1R4HBTLeewY1edBIaSnhXt79bzo2cEvqmNvRk8vYX/bbSE6yjs6G3af9m6QqFjp
pBsH214FsTBQhqe92zmA+z4gjz5uam3lPwXiWd+CSXA2MoTOVF91kQRh+EssAsZv
D2gE5QSlx16gG3Hq0W/rqUtwAOxxPqD1gScLsCBGnC1XvAi4fLmFHcRKW1uatexH
rbJ8sAVI20I4eshcIIcBOw==
`pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_observed_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_observed_cov(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at
   * Tx port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_tx(svt_spi_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at
   * Rx port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_rx(svt_spi_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Tx
   * port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_transaction xact);
    
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Rx
   * port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void beat_ended(svt_spi_transaction xact);

/** @cond PRIVATE */

  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>pre_transaction_observed_put</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>pre_transaction_observed_put</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task pre_transaction_observed_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * This method issues the <i>transaction_observed_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_observed_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_observed_cov_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_started_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_started_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at TX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at RX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task beat_ended_cb_exec(svt_spi_transaction xact);

/** @endcond */

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oNGh8Jg56adsIe/d1sRWuutYCCUxcc4G6t8QAsHooVVKsGFdvkbmclKfLfXL4KXU
A4tbyF6UWyutgsJ6yBggJIL2o1GwOV4dFrwxqHgGCydlrejuZGkVl03sPcejH9Su
XU3AN1msQk7NA142afjB0BSvuMdV5cBu9wbGhf47PMU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3921      )
YXve/f+BkzVTbd1/OcqgGXZU/ikRNcnlm4RdKF83QLDf+maEbkVoDgIRpVg1p2jf
BJ0gTwXCl5J3l8nmzmBwk/XQL7tL3KXcEjBOazBzR7Weh76DEn85mpqU0JLoB70G
LJuQFQIXYWvdWEY6ygX8mEnx5IpfoBNh5AXaVf0PwkstbDHaMSbZOEO/RgQo+zxD
Er/A8VSI/Hvo36sKVroAHjjNyIBzh0THDAtINy3K6hqBNWDn2D0nedkA4bxS4dyV
ZFtnZWGRLFJzYUrR7N0eXCje/pFYv+awtuBdZXPSt3TEK/nqWEdNBm1AI193WMUx
to416Fkk++HmPiY/ZEgLAOY/7npPUJnNUOtOXH90PSj3hPJTQlCwRcKlnJp8kDdF
xGwD06ne+0sHDEyC1WysvPUGxX24zSOu/8NhzvzLqapMKTC+tWaXSCGeAHCU8OSW
LlYIEkLbenzk2QYVyJ7lsvJ1Mk49X28nhZ02AHTEBnMbtqTQfPJPjBdNVmUPTiBu
CSIMkaTfPyqmB7Mzmo2tbfk7Dvz5pIjHiFisFbimO+nXxZdWo+JcHVIDMirTn1kx
mTyc7GfQANj6U3Aat3Y8SWZ2PbLI0124s+JzSxYwXYxjMnc6BYekgNoAJtcf4Jej
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BTBv/Z0uAnlxzYmePCdEfaEiYEwnSVqH4d7hufbdPXvEeJvL2dUU+s1UMrpKrIMg
esJuu2TV2f2wTiQdOWy0aRW8ziRtxYVb9qU1dQ8LWDtJl/Gye0FwbKbLurJiU8r9
KrhDH0G2UOG6ulvBgrgDRjtIZRfSZTIGOsHK9s40Z88=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17436     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QfmoEznu5wf2VEyku8Md40H6PIeRtBeQVn68OYPQsZDjCMbvnA6xCnWnvvKY1SS6
newc0A1R0Pi3LiUSIn/UHop/jv6mlA+OVRcBxZz9pklk5SVKzL39uYX1gHqagszK
4IFEetB2Wzjg3ZrDP5+LAqlVtiSZSOMGTmgRX2QI22M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17519     )
84TF8A0fYhOAbl+fMtHq73doGeMaFTTAXqBfogMienwreNXL9lM6OLDv2yAN0ceC
/YF8mtYjpDLfNX0silJoJckxgA8nGYeMJpeWbGl4LeWsWVnX3etke1PfFc3KgV0F
`pragma protect end_protected
