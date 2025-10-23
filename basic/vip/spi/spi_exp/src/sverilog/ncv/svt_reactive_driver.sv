//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_REACTIVE_DRIVER_SV
`define GUARD_SVT_REACTIVE_DRIVER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_cmd_defines)

// =============================================================================
/**
 * Base class for all SVT reactive drivers. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
`ifdef SVT_VMM_TECHNOLOGY
virtual class svt_reactive_driver#(type REQ=svt_data,
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_xactor;
`else
virtual class svt_reactive_driver#(type REQ=`SVT_XVM(sequence_item),
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_driver#(RSP,RSLT);
`endif
   
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Request channel, transporting REQ-type instances. */
  vmm_channel_typed #(REQ) req_chan;
   
  /** Response channel, transporting RSP-type instances. */
  vmm_channel_typed #(RSP) rsp_chan;
`else
  typedef svt_reactive_driver #(REQ, RSP, RSLT) this_type_reactive_driver;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,REQ,this_type_reactive_driver) req_item_port;
`endif   

/** @cond PRIVATE */
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
   
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************
  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(REQ) req_mbox;
/** @endcond */

  // ****************************************************************************
  // MCD logging properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Class name
   * 
   * @param inst Instance name
   *
   * @param cfg Configuration descriptor
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, string inst, svt_configuration cfg, string suite_name);

`else

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

`endif

  /** Send a request to the reactive sequencer */
  extern protected function void item_req(REQ req);

`ifndef SVT_VMM_TECHNOLOGY

  /** Impementation of get port of req_item_port. */
  extern task get(output REQ req);

`endif

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wXHNwGz9vGfN8vdzcuPqlGO+AJ6TQpcx00f99jr4N+Pwa08k7QWhWPFphu6IzPZQ
xb1VZrfexzxo5O5dt2lRjJCzLU4Nhpl/AkJqGqxDgSXb/qCHWV6O2si0XViPVmbC
mviz4pK/3oVSEOiYUFC2EufV2IaLdcbnYNgbTPEt4RoXkyMp7QB9mg==
//pragma protect end_key_block
//pragma protect digest_block
pG7lOs3iLRdqoBwO7iQ6nYArTG0=
//pragma protect end_digest_block
//pragma protect data_block
0p2UkQ7/dR7hn/L/FJfGiNzHCxGKGbZih1qV7604BudRHCXcTyD17brH1qJV7G5x
PdcKFAq7ByYDq4ZFOBGNw8D9L2KS+aLDF+u9RjzdCp+nQT4ScgGx13Htt9PhkIH2
bhOwwGl/DriN+rHNbWAK46kR7ETlLpn0gSmDtWzztXL6UCOLrW1N445VRZf3c3xi
w+uajAw1luhZFabgGBWLPOyncojA2cPXhyu0AhoS8xFy247wCLH9GuWn/cpdFZO3
zzNZOzPrs/6C5a+6jYlddorIyrnz41pa/o3Gn+AWfKz/dc/1EbTVR/i2Sh33eEwu
5+ZZixqDgCdLqy7c0AN/PntcxKGbioJxU1TbvezjDI9K8lg8xb82vdHoRIgBfwg2
kjRqpGgB6WrPYAhxakd8VG22IYL5c+Ke77MHVPiSz0udo2aUOn9m9k5MBXtdohtH
1YZ4d6amWs4J5yPr8uSkoeBTXSIeTYzhZ7CR43Vgwu9m8nxiuMA0cWVpn0UbmfNB
qmYY9ZSf3AuCJ0g+NrXrsMHp4jNeJL4LnkTVPlc29eLq2wYRZhNzUdAhanoQaQXv
zGs7ud/LjQS9X/SQh/QZhvKGlT72/4sjgubCnf/FJCuL3suNQ+TV8786i4bCm1Kx
ik5k5z/R/vaHTkECR0ujYmd4y61aZhYTWbgDzp9lMqVnLti17LHplrZ+SCC+jS7g
Sm/A8E3r+/WHoijSHNLeViMxsxCzTfvAY/Nkf3XfoxUKusHYAMxzZfKLOjAbJ7uO
A8tLpiBroHu4J4sOPSA1ncTcOB38ZWjSnFGECCKDfo2RINBf6dZquJfPJVK+CZSF
Yewl63naJzkc3CA8HRXl8QmQwd/JT7P7zRXqlrEnifaQoRIh3nK+tPBSg9qlP0vX
JbP3DqdjXHcF3BebNLMJNNNDbZRvB6lDTjaCgUlNO7KEh+W8m9EjHo3C49UJuOiW
gsWyiTzv63swcIeuZkHaxBYesQyyCFyhb67PP9Bca3y18hxsNRCtn3B0GPR7bmjj
n9IB9e6QougLlXEt9vxUHsnDbgYAYjJClVgdHa4L90vnpnX5a2H9ebJwIGB5vIW1
S4ghTSgEN8xOGEKW+VNWhA==
//pragma protect end_data_block
//pragma protect digest_block
0THnIOsPdfwm+7zrRPzUH0LS5JE=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2dG2PjoDy/uQuUZwFiOxYRGUTUyozNd8u46oFUwjrYJ/SxNT1dasiOkUD0rZ8DKo
C4UiLxYkB58fFoSYuKPD5oaExNCPVt3dXJ8ahqoRSR7T/kw21fzwK8eREDXia/4l
6FkxMWti9NXf7VJ2cUUA2CZY5TkJedyBYHJ5zURYP78u34C5M3xYLg==
//pragma protect end_key_block
//pragma protect digest_block
30RMH6VFPOnh8fYtbiROnplv+2Y=
//pragma protect end_digest_block
//pragma protect data_block
TCd+Sq+J5lnDrXnn6KsEiRWs3lMxj6BUQGY6D3C7ccmF/sElmu4FNPI5T7fPRWRQ
0M6aVfsda5Qk4F0B/fmN/taw0HorC1MeWsgmZME21qX+Ak1pg+YbIqWqf5MoQbvZ
CcJbHNqGbp5wqy5tdUm6kVk5OXDMmzjESVUfG6ie7O8/C4b+fY905CyHmWRiOOtw
m+v19B5iLAOV/vB+eS3sp1jH76LRFuIPsRkQX2oSg3zFne1PMMXumv/TP0p7GnUV
kcc7cmRhBxowzULR4gxMrCCDB+93nGp9LMUJ0BNQ0qmO6zAN46Vy7MPIVtopdIH9
2ptORAuJ222h3AsUhKGvUafIuftn4fx7axEaxaDi0p7PKwn1X8JHz7MgSeESTo3Y
QJDe4bhmp2Rn+ruQz/sAMlhZ7vlEeYZJ9TuCmCqzFiVZFAHUXlUCwyVeoqpxzMX+
4W7CsxlPBnPHMe2s1uS/jWE76vWK2IL7PWVcWx4QV0luLY0h4/ieFep2qjDht/57
TGl9Agb5jcAXRKiZXEbj+KFsoQvXX5JSd9PlskPr61XFeuLgMHsSBp3luonXFhDj
wJUHvVAF0wwKNQIVChLXbPe7yjDdJbQW3WOm/gDYs6Lc2I8lKRfrQU1BCvt0I4pd
a+lUZwJuCbOhjEl8mXG9GcaOUU8SIU2DapNPKgyYUbg+4fvPoDhZ1ydocLFNm1Zw
b/RYWh9fs/NzI9DI0uiW7F+q9Qxe0VYanxwOd3qrpkThxCE8T1nNFyTxXEX4EUFu
+FNWs0ofTEPxP1tpYy3/5Qrt/WOxZplVfLoipZ1DPAuMQFHOag6sUEvuGpZDDlY7
wTajwoYNfoGveyE50zR0rdBXMpMuw0SExNbP+JijUOvB4x1zk6ArP+/+bVTEFLVA
2KZcwWbgFg4bCGJFJXgAsnBqC+4pR2yMr12XRACkO542vB2OVFKVdAt9Sa3jrt/l
/dtm56FhqVnoXegrvCc80SpPkgIbbw1cXV5Gm7T5XsKqJIJZ3UbF794yY/rwmTKV
0urrtiPr/yvgoE19uu+vyhx88hg6o3ady7gGS6Bg96eMyuRleLp9XEM4Z7JOJ+C8
Z2vk2xOSaV/hSaR4nIGTBIe1NXI65IAOyCqNBJOO+g0AYWmzgGL8bvdrJHdedN0W
/3Ay+bFiUtpNG/r9G981+i7pYu8q7OI9bSOyMLFapBq/ovLSr9Q8Wkvg2jnhOHAq

//pragma protect end_data_block
//pragma protect digest_block
vYt+I61lt6m97FtpGfJgOSdCSlk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_REACTIVE_DRIVER_SV
