//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_MEM_ADDRESS_MAPPER_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This is a container class used by the System Memory Manager for storing source and
 * destination address range information and providing access to methods converting
 * between the two address ranges.
 */
class svt_mem_address_mapper;

  // ****************************************************************************
  // Type Definitions
  // ****************************************************************************

  /**
   * Size type definition which is large enough to facilitate calculations involving
   * maximum sized memory ranges.
   */
  typedef bit [`SVT_MEM_MAX_ADDR_WIDTH:0] size_t;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log instance Used to report messages. */
  vmm_log log;
`else
  /** Reporter instance Used to report messages. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** Name given to the mapper. Used to identify the mapper in any reported messages. */
  protected string name = "";

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** Low address in the source address range. */
  local svt_mem_addr_t src_addr_lo = 0;

  /** High address in the source address range. */
  local svt_mem_addr_t src_addr_hi = 0;

  /** Low address in the destination address range. */
  local svt_mem_addr_t dest_addr_lo = 0;

  /** High address in the destination address range. */
  local svt_mem_addr_t dest_addr_hi = 0;

  /** The size of the ranges defined in terms of addressable locations within the range. */
  local size_t size = 0;

  /** Delta between the source and destination address ranges, used to convert between the two. */
  local svt_mem_addr_t src_dest_delta = 0;

  /**
   * Bit indicating whether the address range defined for this mapper can overlap the address
   * range defined for other mappers. Defaults to '0' to indicate no overlaps allowed.
   */
  local bit allow_addr_range_overlap = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_mem_address_mapper class. Uses 'src_addr_lo',
   * 'dest_addr_lo', and  'size' (i.e., number of addressable locations) to calculate the
   * src_addr_hi (=src_addr_lo + size - 1) and dest_addr_hi (=dest_addr_lo + size - 1) values.
   *
   * @param src_addr_lo Low address in the source address range.
   *
   * @param dest_addr_lo Low address in the destination address range.
   *
   * @param size The size of the ranges defined in terms of addressable locations within the range.
   * Used in combination with the src_addr_lo and dest_addr_lo arguments to identify the src_addr_hi
   * and dest_addr_hi values.  The mimimum value accepted is 1, and the maximum value accepted must
   * not result in src_addr_hi or dest_addr_hi to be larger than the maximum addressable location.
   *
   * @param log||reporter Used to report messages.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(
    svt_mem_addr_t src_addr_lo, svt_mem_addr_t dest_addr_lo,
    size_t size, vmm_log log, string name = "");
`else
  extern function new(
    svt_mem_addr_t src_addr_lo, svt_mem_addr_t dest_addr_lo,
    size_t size, `SVT_XVM(report_object) reporter, string name = "");
`endif

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Generates short description of the address mapping represented by this object.
   *
   * @return The generated description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_addr(svt_mem_addr_t src_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to convert a destination address into a source address.
   *
   * @param dest_addr The original destination address to be converted.
   *
   * @return The source address based on conversion of the destination address.
   */
  extern virtual function svt_mem_addr_t get_src_addr(svt_mem_addr_t dest_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_addr(svt_mem_addr_t src_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'dest_addr' is included in the destination address range
   * covered by this address map.
   *
   * @param dest_addr The destination address for inclusion in the destination address range.
   *
   * @return Indicates if the dest_addr is within the destination address range (1) or not (0).
   */
  extern virtual function bit contains_dest_addr(svt_mem_addr_t dest_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check to see if there is an overlap between the provided source address range and
   * the source address range defined for the svt_mem_address_mapper instance. Returns an
   * indication of the overlap while also providing the range of the overlap.
   *
   * @param src_addr_lo The low end of the address range to be checked for a source range overlap.
   * @param src_addr_hi The high end of the address range to be checked for a source range overlap.
   * @param src_addr_overlap_lo The low end of the address overlap if one exists.
   * @param src_addr_overlap_hi The high end of the address overlap if one exists.
   *
   * @return Indicates if there is an overlap (1) or not (0).
   */
  extern virtual function bit get_src_overlap(
                       svt_mem_addr_t src_addr_lo, svt_mem_addr_t src_addr_hi,
                       output svt_mem_addr_t src_addr_overlap_lo, output svt_mem_addr_t src_addr_overlap_hi);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check to see if there is an overlap between the provided destination address range and
   * the destination address range defined for the svt_mem_address_mapper instance. Returns an
   * indication of the overlap while also providing the range of the overlap.
   *
   * @param dest_addr_lo The low end of the address range to be checked for a destination range overlap.
   * @param dest_addr_hi The high end of the address range to be checked for a destination range overlap.
   * @param dest_addr_overlap_lo The low end of the address overlap if one exists.
   * @param dest_addr_overlap_hi The high end of the address overlap if one exists.
   *
   * @return Indicates if there is an overlap (1) or not (0).
   */
  extern virtual function bit get_dest_overlap(
                       svt_mem_addr_t dest_addr_lo, svt_mem_addr_t dest_addr_hi,
                       output svt_mem_addr_t dest_addr_overlap_lo, output svt_mem_addr_t dest_addr_overlap_hi);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the low address in the source address range.
   *
   * @return Low address value.
   */
  extern virtual function svt_mem_addr_t get_src_addr_lo();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the high address in the source address range.
   *
   * @return High address value.
   */
  extern virtual function svt_mem_addr_t get_src_addr_hi();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the low address in the destination address range.
   *
   * @return Low address value.
   */
  extern virtual function svt_mem_addr_t get_dest_addr_lo();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the high address in the destination address range.
   *
   * @return High address value.
   */
  extern virtual function svt_mem_addr_t get_dest_addr_hi();

  // ---------------------------------------------------------------------------
  /**
   * Used to get the mapper name.
   *
   * @return Name assigned to this mapper.
   */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the mapper name.
   *
   * @param name New name to be assigned to this mapper
   */
  extern virtual function void set_name(string name);

  // ---------------------------------------------------------------------------
  /**
   * Used to get the mapper name in a form that can easily be added to a message.
   *
   * @return Name assigned to this mapper formatted for inclusion in a message.
   */
  extern virtual function string get_formatted_name();
  
  // ---------------------------------------------------------------------------
  /**
   * Used to get the allow_addr_range_overlap value.
   *
   * @return Current setting of the allow_addr_range_overlap field.
   */
  extern virtual function bit get_allow_addr_range_overlap();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the allow_addr_range_overlap value.
   *
   * @param allow_addr_range_overlap New setting for the allow_addr_range_overlap field.
   */
  extern virtual function void set_allow_addr_range_overlap(bit allow_addr_range_overlap);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IwJv6efd2156LXC+SFFbCtdDSk3+Cj95Q1/VXUurSogp9Su6Cb0PSFJuHcCrgHe3
cfD+hCW8CZTW3bxz0KYRsfv6YCzTI8Jyt8cl/PAX/X0fWRMi1lI5GioXqEUxoJzk
xEF6r31g28uAr0493GOXM5wemqFcO3VCJnmQQHNRkI0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7865      )
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
`pragma protect end_protected

`endif // GUARD_SVT_MEM_ADDRESS_MAPPER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Jh5Yp/LtpS88mAbiB14+NfVs5vvb5Pwu5Ct5SYAh/UdVV4+Z/72G0hfqUj4cBB87
u+yv8NKREujcSELq/PoL7rgFBMqeRCybrVzwDNCN3isQVk8HkqK8Zyk4vrerehiM
Sl8L5wF6kZswxkcAgdJBhycIAJKv3jr4PNtOcJxkMZQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7948      )
dfa777s9vxY2GiS1QgdkFU3rJfpovMGDRE1zgWQirbNiML2J6iXKgkcgk65jHYbz
K2Ju/BxPNj43OZ6Vb82gFoULg0HZZG0VuAt/N755iObjOwn0I1bL6UAqOwc0V1WV
`pragma protect end_protected
