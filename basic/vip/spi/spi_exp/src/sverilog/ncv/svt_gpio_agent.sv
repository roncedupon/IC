//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_AGENT_SV
`define GUARD_SVT_GPIO_AGENT_SV

// =============================================================================
/** The svt_gpio_agent operates in active mode *ONLY*.
 * The svt_gpio_agent is configured using the
 * #svt_gpio_configuration.  The configuration should be provided to the
 * agent in the build phase of the test using the configuration database, under
 * the name "cfg". 
 * After transactions are completed, the completed
 * sequence item is provided to the #item_observed_port of the agent.
 */
class svt_gpio_agent extends svt_agent;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Proto Driver */
  svt_gpio_driver driver;

  /** Sequencer */
  svt_gpio_sequencer sequencer;

  /** Analysis ports for executed transactions and interrupt requests */
  `SVT_XVM(analysis_port)#(svt_gpio_transaction) item_observed_port;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_gpio_configuration cfg_snapshot;
/** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this agent */
  local svt_gpio_configuration cfg;

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KztOcK+/zbw6w6Ly5zkwLjJ7txKv8N88GKp4ShwX+gIQ0KXPfxPrzKHwscpPuK8u
LKJWVVvpiyssAcm0NxxwWpVxMXQ31yX1U7ROJiOyUwmldKjWYazohjDw7FY2Crjn
O+awlMhktmEbNBIxsKzz45tqQIfcpXj6QyhJNqOPg5WuezfK1px0KA==
//pragma protect end_key_block
//pragma protect digest_block
wKDZHEA7DD4O6/7eDB/3pbOn/aE=
//pragma protect end_digest_block
//pragma protect data_block
q8TaPhLs/2qDFfvdnovR6OhVQpxTvWFOAinVQ7BdWm2wC+k3LqVK7ojdVuNTmNEE
kHEBJUq9bL1TT1G0DviJVtWV5rPo4OXRI9q+qEwecF3ZoIi9YXmG8nnY/foqMkFO
13BUpLS7wdRFnm4DOAu0DBTjpXlXwuyQqWSojVKoGSbpq3blCmiZ+59YgHDOYlWs
EPssd4I9REL17vTeMYEimE/5uxMVwZdXtjvkPuN/3fqvdhQdVfDfz57RIcv/HPWi
+y9AFmDtxv8wwWuSqbXxRYxUj0Tf6/Izow3zgx8aQEC4QZMJCVXgu89OS1IUZR3j
lIl88yuFQYxplIAGyo1+ywSuiiWfWMHrtXpQJAkeO4e8cDCHzery/ixR1nOaeBaX
KXKn/a7sUQfrqwHPMdlvkuWu9TNA28gRsCN00WIBsPg+pV2xOQVmen3t9jHa5Wd8
N4AZcn041XYpcymvoEcLhAXHE3WFWAAFBBfI65ToVQBfoKe2WuLmTh1Zh/Tj3dc3

//pragma protect end_data_block
//pragma protect digest_block
97faCkatCYXTrSAaCdBvT3qv/R8=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_gpio_agent)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_gpio_agent", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the #driver and #sequencer components
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer components.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Convenience API */
  // ---------------------------------------------------------------------------

  /** Execute a WRITE transaction on this agent */
  extern virtual task write(svt_gpio_data_t data);

  /** Execute a READ transaction on this agent */
  extern virtual task read(output svt_gpio_data_t rdat);

/** @cond PRIVATE */
  extern function void configure_interface();
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
/** @endcond */

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qwKhe/jB144OjbgOwt27AUVkGF+tZDnwelU5/i/GS1G/P+Dks/F/wuQlWVkvZom6
m2XJ0U5K1HC3daOQ79iOcFsa6Zgr8H21OWnESxMUhJ146NRd1TZWZ5Utj2//Ac2S
uxcRLNmiApqaDxNbDzFkVmN3r7JRmMKrvFOGg7gZldJF7pOpYpOkDA==
//pragma protect end_key_block
//pragma protect digest_block
oPi0Oh9xkxQWEP2N0r6ByiTvXcQ=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
Gbjavpi5pT0iMVnXCprEJxhNA0U=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_AGENT_SV

