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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
W6uSa1vqJpsTztUgnuettMWCWQuwoMlPoHrRkOolCdpuZPpbb2yJFUv0QIyvVRoT
YB95nhDXo5cu+34LwHm/O7IwPKyyYCVgjo3rinmLqCyTNaXeVAFpsMASCMGoFysb
4szNmNSxSCjV02jouSCbFtJx53qRogSAVnLJmZjOPsh5KZFMd+f5sA==
//pragma protect end_key_block
//pragma protect digest_block
SWO65dNOd7onDtX9BCoVyAFQlUg=
//pragma protect end_digest_block
//pragma protect data_block
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
kFteYZhl1o0eZh8OMd0j9g==
//pragma protect end_data_block
//pragma protect digest_block
tPiDA6oEcPv1PKBk8vATvM3YHkM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_ADDRESS_MAPPER_SV
