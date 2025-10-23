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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
VCUfVCHHMc5rcFxXT1WGKsJkAK38tL29Juacs/WPMfTf65ROhoVQ5qoBYNu0AMZQ
Oh6glqt2SGflIjwFusppucRaQpI022YB+qj3J+ZwGNsR2nteLZ2SLOoYr+a2wLPp
3Ax5D9e/o3UUnksUzSNw4K+pG4GCptsWG1wKV+a89NppmKJVUBXPZw==
//pragma protect end_key_block
//pragma protect digest_block
LcDTuPnDlD52P6pPC+1d7driZMc=
//pragma protect end_digest_block
//pragma protect data_block
d/t5KwB/GyPQWZPY8+3LLHCLKXNWJqEMlagTfNqkFFJJaofYXXshwlchQG88XKn+
Jla6TR10FMjLPdyX5ADavfQ4L7M4JzMUvgEGBALw+8nS7EpJuI1jU7C9Yv4dq68v
80SY/qdyNGBb/EJQnhfBCHsF6stjAl+ukPGkpRRlAATtqZcI9wc6saDT+fo0pdRQ
f11THQYLvEthdVPeHDCgTlwJuUb8z1NhKN6NonPort3TB6E7qT2+wfVME10cyJ4b
Ly/g7BucIdp9qCZITqbH3ZY3LKDLgwg0yjaeazrg54d+th7lJ5F4DXISXh1UE10q
iBkMYtQktL4bUa+Mrumn3Rsr2eWd0HVbHtZ3pI/T6aONCUYAyHIaJulZHPSEAzC1
Jpl2imf+yvRCD8MCg+Q8GSMsWrfmdT3Q44UIKaBYPY/Ow3twegiWHwkp16nMfoZ6
hjRa0Wy1MSmbDTx1Ujz9TC0tY8Ake2OSMa7dsiC9CKpMSWykMCrZfOf7+vfH2ozK
I5MbZwWP3zrpYiq1hUthdsS+AZNpAz37Z5r+NdAnpmGb/Nfdit+Dj1owaUuEcvCn
Cmvg3zoifYIVRgSxTaJdTgUJqHJsO1NJmozUe1ua+LpxsFh1AINADeRdiio27eRM
EajKBJ/ELAU3NrWmQQRGIIHaP5/ol7PK9cAbVxD6HudQWbrURToF8cZQqtFXsgkX
w+XacoWX9Sd6ovZMgKz8zluf0pYWmmeOR5sY9gAfgNsbYbQLHJ63wTb6BEalJIJ1
JLcynlvncXR+E4UXjLHeR2ETBS3sMUi5SCCxHTAIjrGRjC/fMUPOewal+SaoTUgn
06R/K+XEqyNaOLl0nCecB2eHv/3oI3lVfBC3xcYUMltNFnM5+rkntMugcqsj0Lfo
FsnSD18IyqoJ6EaPKt/IZj2g1td7VkCM3ZcWu26s9ARzK2vRNVx3MpL3D54S3sLA
dcsluA8Hy5Rms8oc1Trw/6+DXAgJzgi5gj8JOt86sBweKbk0SN7xDpAct/cM1QJC
AAUvNvP07xwrW9FD0QimvIXXvmeWmwqP3kxiFCsfnhnD46cmDCPp0npv2p165OmE
wKdB4ox0HDgfSrCvC6VZaf3fBcAjHG/NyjBJba6DN8KJ7d9bzvHjaCdv9aIVxHFT
smFLu+ohtyRx1atZJzx8SLle3K1WNlMQHwABwGCP9ToLkzxll51YFNLprqTtdxF9
bSmAEbgv9jYFxUas6hKN9l4ysF97/OenTjeuKG6DyCEG9SnMpDA5tMafcjaW+ld4
h61pYCFdw7tDMlED17zWU9xMlW56BsY9Y7XzLi75GOI=
//pragma protect end_data_block
//pragma protect digest_block
GcpmbCliu99LlOz0OZXqSJHBfXw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_PACKER_SV
