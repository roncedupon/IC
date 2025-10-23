
`ifndef GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV

`ifndef SVT_VMM_TECHNOLOGY

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected easily to the svt_spi_agent.
 */
//class svt_spi_virtual_sequencer extends `SVT_XVM(sequencer);
class svt_spi_virtual_sequencer extends `SVT_XVM(sequencer)#(`SVT_XVM(sequence_item),`SVT_XVM(sequence_item));

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Sequencer which can supply transaction requests. */
  svt_spi_transaction_sequencer transaction_seqr;
  
  /** Sequencer which can supply service requests. */
  svt_spi_service_sequencer service_seqr;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** SVT message macros route messages through this reference */
  local `SVT_XVM(report_object) reporter = this;

  /** Configuration object for this sequencer. */
  local svt_spi_agent_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_spi_virtual_sequencer)

    `svt_xvm_field_object(transaction_seqr,    `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(service_seqr,    `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)

  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_spi_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /**
   * Finds the first sequencer that has a `SVT_XVM(agent) for its parent.
   * If p_sequencer parent is a `SVT_XVM(agent), returns that `SVT_XVM(agent). Otherwise
   * continues looking up the sequence's parent sequence chain looking for a
   * p_sequencer which has a `SVT_XVM(agent) as its parent.
   *
   * @param seq The sequence that needs to find its agent.
   * @return The first agent found by looking through the parent sequence chain.
   */
  extern virtual function `SVT_XVM(agent) find_first_agent(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
  extern virtual function svt_spi_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ito8zuSQ6MqhxZkHnmzbtJIMieyQaffxMYMY8iaF2VwGyCeCppe5/jHcgzorOukA
7CXF5VbTMhBAXX4h6K3F/7ukDZCe0bhIxz01eDD437blB2/vZzHOo/EFjTfXvIQ8
9X+ryr7hz3djgfhz7Hi2wV4L6GFscs/CFpc8ndDFFg8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2526      )
6jzubIf0d/BGbnpfUPQ2YsP+766ttC8TtXmH5mBYrZfIp0AidHG0j3+bZJplsQSn
5lC0hz9l3hx7CSgLRdgG0mOQ8Ffj5MIhX0WyCJvSfiFKPnoFyJSJTMRTmpf0gYBN
hg0QErJVWnQEFMv8HuwoNum5+poWt4Kpa1UIwLr3/bm8K2Xra4UQ1gCUctFP17Y9
mXoeId0wpow4/XqiD6A9tkgyxmYjKJGZ4uJJvmghoVGg8uolTyn8PXfiSX5zudIK
mWxPIX/wgVwMTeB2vwgSzRTVzWJ+v5/hfsxeSEmJVfAvpjOZ6YpSyjCAgmOSuZbV
nMA/6u+sInqComxXLewlFZTQRiYLMltvDZVszLYUq6V2XD0ohdcVBPvm3ULSxRNS
Wi6vghmLK2kzW7QelE6fFYvpdUu/74BxEVlEzc5Ar96x0BwOuYi3bCvOPyWM65x9
qsTnelk7lNcsj5C9cBp6Dl87PmpBz4gYlE1kpkScKyFFAJJIz3DhIpHGdcjRIV+/
hnmn2JFPZ9Z2LPL8YJRhor1MHgzj3jfpihbwXXp6LGSyanEKswP7d4K1/vRMbv6q
RSH5qVPb+m2Z1XWQJr0wmfRRBbIKEpz2845iovYvI4Iklb1eddsU/vN9P7z7BpVI
SiYBs6XCCg/7LM1KE3InxdlwA7hrYz9kMFw2UwOkV9KpyHKE5KEYHhU6s9rwT1w6
YBw/SEq9fapEvS/iAYp8QhK1URJn/gZjfDD9MK5xz54SD9oOnKn7RvYeJS1rXh1J
efkB2rY12tGhv2UE5hBKnYDx2zIBCo5XmoyTRmsDNSHc7OTm5Np2ISKoipb+wUVP
FfqMHe85o/ahWbDlFVMCL4iBdkIZju558wov4RqqaCC+hYtZ3GRbnAhzUXerGTIE
DLpMnCoWNInAqTofdFx4voA89eSFH2ps4impEuHzXc9dzpN5tEmxmCbWdtQGWzfr
orXJnlaep0g2TO+7YTsPp31U1kl2SLar6nrZW2R9/kFLXzvBDJAZxY0llVR6tXwE
corAHZFNqeMR72N0Mj9zTXA3TM2JtAIyRvKeqOImZPCQUPqDnAQas0bKhf/iMbAx
AmKRt0mpCFJPFLnXw47mSKlucFPZ4fPz2vcL3dtrC43ams82tfoEW2KVBdDRvL74
KO8XIH6xR2gK9F0VxnWkqyfhgdJPzJPqoEBpds3nvbScRN1FylHo3PmefJlR9+bV
WHkPmXkx+cAZvAP2RRWW1nR9mFkzQbrRRxM1gNHTgpU55BxYQV7vwpZSaok/FRkN
CGUfiEqLmOapri/RnjmkncDLPKTN58GQ4bj4tWU6TpU/oFQDJM1KL4SI2mizSjay
kb0lA1+fRLOrUsdrag8u2YKDiLZ49VWytZs1VX69HJbjyfr5PjDgzau99oyctVF1
5FugiqkAE6nRsNXCmzPU5MqQF88hqpCdnp2CGiL99k++trhm/rdFFweN1x2i9qEF
E+Joy6e7BFotLsHfavv5o7z6PXoy39mMEqbglILdQjLkIzvyLjU+gwES1EvWsl0q
RJyoLdB78wsYH/AaO5HVK+oqr6cgAo+vX79osf2+0gm++z+5jmY4Ir05qFJMmSrc
B9PLE96lz/1i22p8AiNuZj3lt4+Wc66kk4uIHxYvDYAcpI/utQ2xClMtX22N7Eng
EfxxWOAHxMk2RAZCF5uvNw9QhoOSAJk7W04qEbB1PvgOh9heoMW6Y8fgc9T7hcIu
4fEffPRRRrrPbrEJhopy8HgW15tfeIKGPFKoFELUJN2zivPc++rbi1Lj2bwRtHaS
hP0wXxdW5mIky1YSK0/Z2C7BLJjc3TULOelMpf6IdDOErmQJzlyNFOalJRVcrCTx
CBmuyL/e+Rwr0t8jm1qk3TSgtfRwcO0/7AVdmVrr+xcclFxtFAJp1CCuslYb+jEm
iUUFaHQ+zOtMCtOYXu2NptMiFL+HOa/HQgFrT3YcXXduiKG7x7XcurfWCy3G3af8
LcMlAQxMeHtkhAo3rA69f0lLUBj9aNo6wN53gw7LpcYVThDg1Z/CuqsmkUgdCx6w
abEtxntQQLLPgD1o3CoLauXYkq9BcDw8Y8x9zSiBCEQTyS/8LWRixdXvxGjHcCV0
tUSxFiRtma6qkw2jOfOcEVIABXO8VExAjVJdDPSDjaupy5LjftCnWYItkntDF0t6
G8SHwXsPTxWVS2sjLHGZC+aocjhrtmd2PJUr/7XtZEJe9aMTuwkm+KMp9MtHLxug
uQswerpy5JFPx+e9N/sXsyY0g3yL+B08KXO6Td1eJ8gtCsTeXGX2eKtmsq43l8/X
+lSC/WGH88k//c2X2l2PG+27a4U8WYLTP/YwiicNYJ7NXO3oni27bm3cE7AZg3+M
ifXVK/ZIgkiLigZB/QB+lMnEnxeItyDdKUzigT8QygeB1gHeBqXxnBmCc0P2LsA/
WzILiCv85zu3bPyaSWL7kjUiMpiBthv0GSm+2T97s/rzsQFivMflgD/z/IamhxbI
BGdQ3gu16M/JqiCSViNCPgqtwvK8T7h2EyKNbL0HlIuuN/+drcNeKS/kSmY8gxlu
0woC1r4+5A2zSPsLBQOlb6hsnFr1OqKhOcPxj8IBtez82HnduccTZC/onLH7uONK
Rk7A95cycvWyKmf8dGw3UWVVd11jfxwRvuaagz3GQGPmgheTCT870Jo2uqMQnrk/
dITEQdmkKNjKfHKA5OE060Cf9U0DC13Y3EZTBwt2cc98Qq93gvpJd8Hon41FVYnX
qg+1I3whdOcLUXxaLjOaGky36tHymTt4D1HjgNpCOiJbkmXCuLxirOPYwCvFREZ/
qsK06ceyYb93WKJBKfy1hoLo7X52uLVdO7A/ZP8tAN5pySqLkJJBd8zFp51AkrON
g9XXlrjExp5gQx6ierqzyBf7PTx8d+hqbPPyNvfmyuVdlqhZm1JAYstXPKFv0oeR
mh0jlsLgsVt14PYL4qnZYTURBwcVL9/2KdlBdJ7iAESFE1mMsa3Er9EV18jiM7dw
tAS7iIuwlTdzuC/AejrpHPv4nsUFQg/E7eWjVAoGNycxTFjIBrACfO7S86ak3Y17
b4Q3Jb9ecaLZCDj+FkH7qtsU+vvyLIUGSoDGQK1P2eimE4ynBQQHibyF2kb3CrMS
mUKK1LcevLN0hCYRz7EHayPOcn3ziYTHf9CXNaTw8n/mtmaZN9o28kJkogEg7Lpz
3UQDQQZu2D0t5+qH1v/XMRf9RPWjxzXA3AICE2ABUf9+eRuIp5uspVr2hnZYZqlq
fnC+2bezV6P3+8xX2CZp+1tc73kBeddao+xf7ImM9o4HIzpeFQPTkWZ2vcZkKoPJ
GKbfMui1oJUED1eK/tMz1O+tmTnwNXjrFpbQiLdhGM0=
`pragma protect end_protected

`endif // `ifndef SVT_VMM_TECHNOLOGY

`endif // GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C6OgVN00h5IsOFkt1/LQ84hQYpoc6eYt5mdhAtM51k397LcdNpdabuVQA3j+ck9U
soz+TjsjLu3sw/U8xIHKTdMKf1hyf5ur7vzoI2Z9O0AJNArp2nvtfD34MHpMnh0E
X7UkV9X6qLuuxJ2pQjo/vwjpqs8441D0b2TjEmLMDx8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2609      )
UHpEhQUqdrf4qeIyN7pXjYYOdAuLXIAmG8vHU8nRgzmnOyWjCb6mur3HOPo58db0
slxPJP4KgfGAfa0PUoGY6wcyX8+wfkv7EFDLxMXgEg60D1nrmGhta6CCeHy8s/PG
`pragma protect end_protected
