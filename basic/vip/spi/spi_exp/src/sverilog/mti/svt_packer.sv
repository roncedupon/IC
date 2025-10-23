//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PACKER_SV
`define GUARD_SVT_PACKER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(packer) abilities for use with SVT based VIP.
 */
class svt_packer extends `SVT_XVM(packer);
   
  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Special kind which can be used by clients to convey kind information beyond
   * that provided by the base `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract
   * flags. Setting to -1 (the default) results in the compare type being
   * completely defined by `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract.
   */
  int special_kind = -1;

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
  /**
   * Added property which was removed in the IEEE 1800.2 release
   */
  bit physical = 1;

  /**
   * Added property which was removed in the IEEE 1800.2 release
   */
  bit abstract = 1;
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_packer class.
   *
   * @param special_kind Initial value for the special_kind field.
   */
  extern function new(int special_kind);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to obtain a calculated kind value based on the special_kind setting
   * as well as the `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract settings.
   *
   * @return Calculated kind value.
   */
  extern virtual function int get_kind();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LOHEwTW49HsVhn2GB5JIPTFiq/gstW8mCJdkXf4NzeKSpN7JqZ8BnOLoAhpXg3lE
L54HYUP3hdsi4rUiT7v3rnvBus8/1DLSLBqB4AJMqqi+XrZpB+nnbMAziReCvXHM
5/pjBjszMaZsiZx6+tNd9thinAHCf0hOYTiAlYIhNtE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 814       )
jB4bBXpi/U369a1X2yILEIaHkzy/N3iPrCsR1KD7yenWPEQQQ1yPNv5i+Ir3qLZR
azGeX8ILMfnivO9JtODoi1wMW4X96436K8v4ZEvy7pMHrlM4eqRJPcUDtd7pxtvs
X+cwMdf0Pz8vvBROhf1r9ttWz++hflLqOs/pR/q6DFPLL2NmWrpcdV115PwLvDPi
QF79fepgggFG6osL/gDQJH/Qq8c75ph/YDLXXxLWW50TQ6Jx/Uu7Vjj4YZVd9JX7
IFw5pHFMfNEWVy+yXyqZXUVDwJ3zJPvrs5Is3xX7+NrxepRYUXNapK00FSA5aJQe
qGBfjZtO9pZDOM4j+dusnnw4LkPgiBlFhAWLX63VxSfSMP/llo92yFxaGB03BrjN
C0DRuTeKlWtJs5nE59dtm0EbcPZsvmxJp+wOgc7tQ/9SDXdtj+2SxrESPpDn8kD1
SqkWPLreVwvlbjWolS/PdLZQLXw9B2qQF6YVgssPPZqqtm2n2KUVj/ojWUsvvOIx
+/xYeTXdqXKoZyrs8yzsbnPzUDNPk6qE8+JaKfQjAkipMBf2P/CUjBvybcvAmS/C
FiF3Dw+Itl08rDcisXM3hOGCHMarP6osd8VDnsL9KEj5BbRf+fUtT1yoPwXhWjN+
h44CcTmbwbTj4rcOT+znYa6X5KihVsLyTOfTVMb1EYeQ9K38fzGE6apt70Y37vdo
ozsYewgfjP341ta/fB7ZUmS2SyH9yeTpvd46FY16GTxOfQnoq3rFTMUDuHa62q48
DT+cKMFWBE/m/YW4T24oCBKyKaOdkaj15veROOgzBQRRyAEKWqBwqCRZZuQELvZc
oY9UBtL4Fi6/npDAIH9/KkGWHIzGi0XzSUN6ETIWS+2aA39puXU6DTDICqrqgImS
TDFAofOr/wljnt6pSlAAo3FT4OcEV/eekKl7RI6NkW7y6bwKwB85Q6ksxar3PbY3
3Aa3bYM3UNllKsebO4HF7DdNjryHOnY8nwN19KlQsijStPR0ZKxWUh9w6Lcw5qfT
2DvzimmjvdZbx2iu0qeFuBJNtQfgw0sf8vbvavpTZE6YFddcb3uXG2fJSN+k6Z2+
`pragma protect end_protected

`endif // GUARD_SVT_PACKER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pisiyxGF0kL9twwyss4NZ3OnP2DIHH0AEY9gbyIZN+Uy1UY6edWwnpITuOV/9QZw
Dn5iBZ0R7whT2dsJD8O+BLAUwWoVArTtJJ5x7F7xAJFMWHMte9vGYYYRJznM7b6o
Cpv44+QKa+fYHGt8whwG8VfJNRrOyRsT6h9gv362VbY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 897       )
y+g1XMRxynxWb9sVQpvIDtkweIzeJRAE+f3FrbTOOr2CQ5CBbShk9TS24ELmXFNZ
cMCa811XCue0bG+18Y8bbXr7ELfBbvys3WhZlxMA649G/r1TQTK67uKWaVPVvqcP
`pragma protect end_protected
