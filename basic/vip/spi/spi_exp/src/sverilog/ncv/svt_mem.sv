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

`ifndef GUARD_SVT_MEM_SV
`define GUARD_SVT_MEM_SV

/** Add some customized logic to copy the actual memory elements */
`define SVT_MEM_SHORTHAND_CUST_COPY \
`ifdef SVT_VMM_TECHNOLOGY \
  if (do_what == DO_COPY) begin \
    svt_mem_copy_hook(this.__vmm_rhs); \
  end \
`endif

/** Add some customized logic to compare the actual memory elements */
`define SVT_MEM_SHORTHAND_CUST_COMPARE \
`ifdef SVT_VMM_TECHNOLOGY \
  if (do_what == DO_COMPARE) begin \
    if (!svt_mem_compare_hook(this.__vmm_rhs, this.__vmm_image)) begin \
      this.__vmm_status = 0; \
    end \
  end \
`endif

// ======================================================================
/**
 * This class is used to model a single memory region. 
 *
 * An instance of this class represents an address space. When constructed,
 * the address space number is assigned to the instance. If there are multiple
 * memory banks/address spaces, the value of m_bv_addr_region should be used to
 * select the corresponding memory instance to access.
 *
 * Internally, the memory is modeled with a sparse array of svt_mem_word objects,
 * each of which represents a full data word.
 */
class svt_mem extends `SVT_DATA_TYPE;

  /**
   * Convenience typedef for address properties
   */
  typedef bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr_t;

  /**
   * Convenience typedef for data properties
   */
  typedef bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data_t;

  /**
   * Defines values used to specify what type of data is returned when a read targets
   * a memory address that has not been initialized (not previously written).
   */
  typedef enum {
    UNKNOWNS = `SVT_MEM_INIT_UNKNOWNS,         /**< Reading any uninitialized address returns Xs. */
    ZEROES = `SVT_MEM_INIT_ZEROES,             /**< Reading any uninitialized address returns 0s. */
    ONES = `SVT_MEM_INIT_ONES,                 /**< Reading any uninitialized address returns 1s. */
    ADDRESS = `SVT_MEM_INIT_ADDRESS,           /**< Reading any uninitialized address returns the address (plus an optional offset). */
    VALUE = `SVT_MEM_INIT_VALUE,               /**< Reading any uninitialized address returns a fixed value.*/
    INCR = `SVT_MEM_INIT_INCR,                 /**< Reading any uninitialized address returns the incrementing pattern stored in the address. 
                                                   If the incremented value exceeds 2**data_wdth, the higher order bits are masked out.*/
    DECR = `SVT_MEM_INIT_DECR,                 /**< Reading any uninitialized address returns the decrementing pattern stored in the address. 
                                                   If the decremented value is less than 0, the returned value is 0.*/
    USER_PATTERN = `SVT_MEM_INIT_USER_PATTERN  /**< Reading any uninitialized address returns data is based on the user pattern that has 
                                                   been loaded into the memory using load_mem(). The pattern loaded through 
                                                   load_mem() is considered to be repeated across the entire address range and the 
                                                   data returned is calculated accordingly. */
  } meminit_enum ;


  /** Identifies the address region in which this memory resides. */
  bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addr_region = 0;

  /** Identifies minimum byte-level address considered part of this memory. */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] min_addr = 0;

  /** Identifies maximum byte-level address considered part of this memory. */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] max_addr = 0;

  /**
   * Determines the form of data that is returned by a read from an
   * address that has not previously been written.
   */
  meminit_enum meminit = UNKNOWNS;

  /**
   * Value used to calculate default data returned by read from a location not 
   * previously written, if #meminit is VALUE, INCR or DECR. If #meminit = VALUE,
   * this represents the default value returned; if #meminit = INCR or if
   * #meminit = DECR,  this represents  the default value at the minimum byte-level
   * address of this memory. Default value of other locations will be calculated based
   * on this value. 
   */
  bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] meminit_value;

  /**
   * The offset to be added to the address, the sum of which defines the data returned
   * by read from a location not previously written, if (and only if) #meminit = ADDR.
   */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] meminit_address_offset;

  /** Stores the effective data width, as defined by the configuration. */
  int data_wdth = 0;

  /** Queue used to store a user-defined pattern */
  bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] user_pattern[$];

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
I8kBOfWLuEv/1VpeTdcQTJr2deDyZP5dzQFgLWA15VBtsAJfX62CPWSa9V3pgjz5
aBw23LrT7JBcZ/DAn7p8dFiA/joCyBD3JDpik10WFC4uBl3Id/wE+6R7RuVq2wxA
jq0rr9XCZEr3iwHrLzjsiHMI6ZPAJiTYBcwt4A3BBcnJG0alxHaiQw==
//pragma protect end_key_block
//pragma protect digest_block
WQuxmN+cDXmqkCZ8XCkdQ0FqIts=
//pragma protect end_digest_block
//pragma protect data_block
K2pEnNliw7WU88+cZT4+CewuCunghR8LRuIusuITXCf6qt1+x8gZRSYshbKUhXDH
1jQ2s1/jsbwhKlgrbMgl6fEJ58leIzgzB6lB51ESyHgT/Tp2/7OFwcZOsdtC0i+s
10kbwuc64ZUAhs9mTvS5KYpIXghUU3W6EGHeKZcFwIOlPC7tjrVKD4XumC0roevp
AEf8jhfhyrWublYYpdALXkHYHyLcfHY7s5XmC5mUluGzmq0J0I7eSWLT6thKFY0g
MiRhY5BU1zXufU5b/tgTsPYDv99jf2E0EOFBYbpm+PL7VJvchhbggq8kAxjo20HU
ZgRw24mDbKFm/owgTYoLdf1HGE4qfjAu/Kjnb7U2EDWNCEsIX5F0OvV4nRJ/83Rp
0O8WMP71a3OawgGmhD0apZJ4oMkTANRSweTp9TbpUZnCYALWxyYm0cWSzB20zUJB
2zI08MVzvbqIfU+Uf1VS9haVO0cdB7EYU3uHAk0v+NGlcO30n+nS59g7sbBu278H
ZrhCNYn0SR65003nTRy8r1+9ghgwSwWStd6eO4q0+e23VYEZZP2u47Z74+ky2BFi
6Ef5lyV9pqZBpUWIt7+YYTO7Oc9OxucFw5vDsBlhszB6KFwIcl4pFjEtFXhlG3ng
/bKJYVyGcOkvZUWCHsFpCTPQWLGVGxY2smFngxiPmbxwUx/AepXFoTjdX34r8F2E
DqazEK1vicThQXbXUfQlobs4g/gbeqkJ+IBQI1n9WvYCfTBoMpYvqpSYMlwfyy2N
lRrebrs3i3RHORqztL6Sllk+mrCnTlCqRWhdTpQMonAyyw5tH384bUDXZOt/2cGa
HyK0QeSK8Pimt6I8f1VBGPuDmz0Nx6z2cELY4k0ZHPuMJy7dYltwxwFXjjr//v8z
ZQFPHMNkNwdWZPMkY6amJ4xxqNBnJ6KbORcH+vnNUbvNNosZqIwe5V2fjYHEwyOx
PFbr/tB28vNDXS+80hOY2ad90guI00iGY1vymsmmlxPIg6VDDg6ovRWr4hxalc2j
poTJsdxnqq4iWwW0mPSPjO7RMjwC+yoTDK9J22xZEh9aXygxgG6DlmjFoP5V0pNf
WQosLDSexpLS73HNFuzVAZ9v9dWGhfFb1f6D2JAMJdBro/jitJZdBW6Ho5Rm8Rqm
NY8ZuApQFcmkgp77p1OQB4+h8WU5BbLXsCgFOd7aJiFmc8fw13ghQ64mYsV6p0Rw
bXVmQTcHXuGt0aucsdhiAGBYSYgyai4xZ2PUm4ceW+cx9f59O2AfzrFkjN01+1OT
qJItqxAltlPhF+8I6sJl2LlD5Obui25PEScncNEBYSJPj0wWR2qa52UWhuQwyC6h
45cPES9XSgjhTXWOpgP3vxoQ6RQOzXlyRfY74s+1PFlRtFfFMhaoFa+/6GPRp0xN
w8pcSsaoWludh9gyMYLSLrhn2SV/JobF98b7p4WwfuvBjeNnhEVAE26GM5QVoOgX
DcCrjlp9JkMrQCHFKZm2X7hIEtExE6Nk6bxUVPb31FKQ0mahUqF8l9Ep0ynEFxSq
+QUg6lpgcKX3pn90RnAXGdTMkRpbXZTtlVgmSgzD/KlQN/wi5tgaBOGu4BI9aEkH
1/TzJ2eFQh/E21EynNj8PrvijYxK7I8x+U6hgtWlgG/pwDrzlBHmN1ptPCH6gBCA
xtz6qYJ6rEbSDW8JKI7UwfaRJSVG056F0Jm2y34ry4XPc0XnNPJlQZiVXNR6/C6W
tZq1Y6bvtORZQoxbJ3Bm2Yv0vVCEOXcb3vcrM+SBPLSV838vjpUwVd8JuOVchUVu

//pragma protect end_data_block
//pragma protect digest_block
GE5vOf6QkFD2GtCMOJ/BGpC4j5s=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_mem)
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the memory is assigned an instance name, 
   * data width, an address region and Max/Min byte address locations. 
   *
   * @param log The log object.
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param data_wdth The data width of this memory.
   * 
   * @param addr_region The address region of this memory.
   * 
   * @param min_addr The lower (word-aligned) address bound of this memory.
   * 
   * @param max_addr The upper (word-aligned) address bound of this memory.
   */
  extern function new(vmm_log log = null,
                      string suite_name = "",
                      int data_wdth = 32,
                      int addr_region = 0,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] min_addr = 0, 
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] max_addr = ((1<<`SVT_MEM_MAX_ADDR_WIDTH)-1));
`else
  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class.
   *
   * When this object is created, the memory is assigned an instance name, 
   * data width, an address region and Max/Min byte address locations. 
   *
   * @param name Intance name for this memory object
   * 
   * @param suite_name Name of the suite in which the memory is used.
   * 
   * @param data_wdth The data width of this memory.
   * 
   * @param addr_region The address region of this memory.
   * 
   * @param min_addr The lower (word-aligned) address bound of this memory.
   * 
   * @param max_addr The upper (word-aligned) address bound of this memory.
   */
  extern function new(string name = "svt_mem_inst",
                      string suite_name = "",
                      int data_wdth = 32,
                      int addr_region = 0,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] min_addr = 0, 
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] max_addr = ((1<<`SVT_MEM_MAX_ADDR_WIDTH)-1));
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_mem)
    `SVT_MEM_SHORTHAND_CUST_COPY
    `SVT_MEM_SHORTHAND_CUST_COMPARE
  `svt_data_member_end(svt_mem)

  // ---------------------------------------------------------------------------
  /**
   * Configures how the memory structures data to be returned by reads from
   * uninitialized addresses.
   *
   * @param meminit (Optional: Default = UNKNOWNS). Refer to #meminit_enum 
   * for supported types.
   * 
   * @param meminit_value Specifies the (hex) value to be returned by a read
   * from any uninitialized memory location, if the <b>meminit</b>
   * argument was passed with the value VALUE. Specifies the value at the minimum
   * address if the <b>meminit</b> argument was passed as INCR or DECR. 
   * 
   * @param meminit_address_offset Specifies the (hex) value of a word-aligned
   * byte level address. If (and only if) the <b>meminit</b> argument was passed
   * with the value ADDR, a read from any uninitialized memory location will
   * return the address of that location, plus this offset.
   */
  extern task set_meminit(meminit_enum meminit = UNKNOWNS,
                          bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] meminit_value = 0,
                          bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] meminit_address_offset = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the value of the data word stored by this object.
   *
   * @param addr The byte-level address to be read. The addr should be aligned to
   * the data_width of memory, if address is unaligned it will be realigned to
   * data_width of memory.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int), locks
   * this memory location (preventing writes). If supplied as 0, unlocks this memory
   * location (to allow writes). If not supplied (or supplied as any negative
   * int) the locked/unlocked state of this memory location is not changed.
   * 
   * @return The data stored at the indicated address. If the address has not
   * previously been written, data is returned per the setting in meminit. 
   */
  extern virtual function logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] read(bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr, int set_lock = -1);

  // ---------------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   *
   * @param addr The byte-level address to be written. The addr should be aligned to
   * the data_width of memory, if address is unaligned it will be realigned to
   * data_width of memory.
   *
   * @param data The data word to be stored. If the memory location is currently
   * locked, the attempted write will not change the stored data, and the function
   * will return 0.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1 in a
   * given bit position enables the byte in the data word corresponding to that bit
   * position.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int), locks
   * this memory location (preventing writes). If supplied as 0, unlocks this memory
   * location (to allow writes). If not supplied (or supplied as any negative int) 
   * the locked/unlocked state of this memory location is not changed.
   * 
   * @return 1 if the write was successful, or 0 if it was not successful (because
   * the memory location was locked).
   */
   extern virtual function bit write(bit [(`SVT_MEM_MAX_ADDR_WIDTH-1):0] addr = 0,
                                     bit [(`SVT_MEM_MAX_DATA_WIDTH-1):0] data = 0,
                                     bit [(`SVT_MEM_MAX_DATA_WIDTH/8-1):0] byteen = ~0,
                                     int set_lock = -1);

  // ---------------------------------------------------------------------------
  /**
   * Dumps the contents of this memory into a file. The data is dumped in hex format.
   * 
   * @param filename Name of the file into which the contents are to be dumped. 
   * 
   * @param data_wdth If the data width of the memory is greater than or equal
   * to 8 and is an exact power of 2, this value specifies the data width of the
   * the words in the file.  If the data width of the memory is not a power of 2
   * or is less than 8, this value must be left at its default value (-1).
   * If left at its default value, it is assumed that the data width of the words
   * in the file is same as that of the memory.
   * 
   * @param start_addr The start address from which data in the memory is to be saved.
   * 
   * @param end_addr The end address upto which data is to be saved. 

   * @param enable_autosize_of_saveddata Control to write/save the data with automatic sizing
   * i.e. with leading zeros, if any
   */
  extern virtual function bit save_mem(string filename,
                                       int data_wdth = -1, 
                                       bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] start_addr = 0, 
                                       bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] end_addr = ((1<<`SVT_MEM_MAX_ADDR_WIDTH)-1),
									   bit enable_autosize_of_saveddata = 0);

  // ---------------------------------------------------------------------------
  /**
   * Loads the contents of the file into memory. Data should be in $readmemh format.
   * 
   * If the data width of the file contents is different than the configured width
   * of the memory then a step value is generated that is proportional to the
   * relationship between the two widths.
   *  - If the data width of the file is less than the configured data width of the
   *    memory then each value that is read from the file will be merged to write
   *    into contiguous memory addresses.
   *  - If the data width of the file is greater than the the configured data width
   *    of the memory then each value read from the file will be split to write into
   *    multiple contiguous memory addresses.  Care must be taken in this case to
   *    not exceed the end address if one is supplied to this method.
   *  .
   * 
   * @param filename Name of the file from which data is to be loaded.
   * 
   * @param is_pattern If this bit is set, the contents of the file are loaded
   * as a user-defined pattern.  This pattern is used to return data from a read
   * to an uninitialized location if meminit is USER_PATTERN. The pattern is 
   * repeated across the entire memory.
   * 
   * @param data_wdth If the data width of the memory is greater than or equal
   * to 8 and is an exact power of 2, this value specifies the data width of the
   * the words in the file. If the data width of the memory is not a power of 2
   * or is less than 8, this value must be left at its default value (-1). If left
   * at its default value, it is assumed that the data width of the words in the 
   * file is same as that of the memory. 
   * 
   * @param start_addr The byte aligned start address at which data in the memory is
   * to be loaded.  If the value supplied is not byte aligned then a warning is
   * generated and the start address will be modified to be byte aligned.  This argument
   * is optional, and if not provided then the load will begin at address 0.
   * 
   * @param end_addr The byte aligned end address up to which data is to be loaded.
   * If the value supplied is not byte aligned then a warning is generated and the end
   * address will be modified to be byte aligned.  This argument is optional, and if not
   * provided then the end address will be the maximum addressable location.
   * 
   */
  extern virtual function bit load_mem(string filename, 
                                       bit is_pattern = 0, 
                                       int data_wdth = -1, 
                                       bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] start_addr = 0, 
                                       bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] end_addr = ((1<<`SVT_MEM_MAX_ADDR_WIDTH)-1));

  // ---------------------------------------------------------------------------
  /**
   * Clears contents of the memory.
   */
  extern virtual function void clear();

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether a given byte-level address is within the
   * Min/Max bounds for this memory.
   *
   * @param addr The byte-level address to be checked.
   * 
   * @return 1 if the address is in the memory, 0 if it is not.
   */
  extern function bit is_in_bounds(bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr);

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether a given byte-level address within this memory
   * is locked or not locked.
   *
   * @param addr The byte-level address to be checked.
   * 
   * @return 1 if the address is locked, 0 if it is not.
   */
  extern function bit is_locked( bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the aligned address.
   */
  extern virtual function bit get_aligned_addr(ref bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr);

  // ---------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Override the default VMM allocate implementation */
  extern virtual function vmm_data do_allocate();

  // ---------------------------------------------------------------------------
  /** Enable the VMM compare hook method */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Hook called by the VMM shorthand macro after performing the automated 'copy'
   * routine.
   * 
   * @param to Destination class for the copy operation
   */
  extern function void svt_mem_copy_hook(vmm_data to = null);

  // ---------------------------------------------------------------------------
  /**
   * Hook called by the VMM shorthand macro after performing the automated
   * 'compare' routine.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   */
  extern virtual function bit svt_mem_compare_hook(vmm_data to, output string diff);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to format a display of the memory contents.
   *
   * @param prefix Prefix appended to the display
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`else
  // ---------------------------------------------------------------------------
  /** Extend the display routine to display the memory contents */
  extern virtual function void do_print(`SVT_XVM(printer) printer);

  // ---------------------------------------------------------------------------
  /** Extend the copy routine to compare the memory contents */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  // ---------------------------------------------------------------------------
  /** Extend the compare routine to compare the memory contents */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  /** Added to support the svt_shorthand_psdisplay method */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  /** Added t support the svt_shorthand_psdisplay_method*/
  extern virtual function svt_pattern do_allocate_pattern();

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mjjy1XSaBZnNB8aBdfdiqMZBiVZSM5oQu0J+ZYyTYAEHbZ1ugejB+Q0PwBLYMCF5
S5yUEDG78+AbL2b1rl8zUiuGqJZC9qao2sykUpgdyv53gCb+mbtoK57//kyGjbEi
9m8Fcl9mlcnJWcChcxJCIfMm38AIk3HY9/IlYebxG5tHcxuz5AFFsw==
//pragma protect end_key_block
//pragma protect digest_block
Up98+KquEsHIvL+qn6a65aEXhc0=
//pragma protect end_digest_block
//pragma protect data_block
MAppM078JhDbm7o0KZRaTIYcu+dvcnKm+xvQ/pLiNUiTn2qW2eDzreZn+NHslhSz
a2jsRl4USjmua0C3G7xPE/WfTCkyF3g4yWIdJVKm3gAV0viiwKEGnlLJhVEM8ctz
QeJnWLs8v6BxT29mxFKR68jfvIUjE3TAgX7vTT81eZhMKMU++Wu0qB84iI17gIjD
JlM2rwfFJ5twpARsi8vDFFF5JP76Z1AxMMt5qn+J1bcph7fbDRt63y6Q8WN4kHiT
F6YXl+139m98ljZtLm02vsSFGlstUXA6Podaq7lUKRctTgch52dlYgLbJCGH5z9d
fcveQ8CLQwGRGMF+cgdp0IgVdaXufFmr4e4c2aqtTrMddco9rsIBoj1dtt51MGK/
AzFTlEzDiwCaFkQCDoDG57apuifa/bIRikIMlM0xNDDc+M2LTSK94y5Tptjjue8W
DqyrbHnn4q5BqgIDNTE3/eyIyV9zhziKLtGwPEYGR/E9xaJgKK3nclFWgqJjSRbu
2z42saXfc37HMzP5BCQ2Ld0yvQ+t3aHjliglAFwu8443xLcfsiOD0S0F8mK3yOPR
ly0VggLTJpwImNiBgIrbHnPJvdWA8Ka0PsIEKlhU+wJ2bHHnfzQxnM7Pkgyf+Zxq
VQ563kcau9s67wi7bhWDDloJisGR1GoVGrKIT1Ur4BEj9OjUCXKYhsqzGg9s4t9+
AI5lj/7E0VVHAiVBsPw67WVsK9c5sVyYFSxCJ0lT+YJRYt16+NdmpYW+hy5/3N6e
l4voDyEOQrjspbIvEhLC5midnklGPg/VbHNGp6nSFgeWJI4hnB6mAX/9dtj6+qbB
D37DOYtxZzWCWEQxyMdvmk4gIQSmOz//Y4rLcdc0/2VUuaJ3oMHsjWonNdPNgY/r
zf7e27FFT9EaQ4bHEzWf976SAs3Ls4aw7uHNX4zCGDtSGlKjx4aaaFg/KVMRelnX
0vTnUndjCB0N7g+k7f6Uq0uOjzQwqsb+PeS94HBIX0WOGhqY0ehAkxqJ9A7BLbzi
9NXwxql61J3FgqeYi7EjvP18o1kbWMvXUjT3hEkM6h1YCJQ0J07YcpxYOzqDK6TV

//pragma protect end_data_block
//pragma protect digest_block
4eBuoJiuAbdrzrTWraHY8G52ky0=
//pragma protect end_digest_block
//pragma protect end_protected

  //------------------------------------------------------------------------------
  /**
   * Applies a property value to this memory
   * 
   * @param name Property name to be set
   * @param value Property value to be set
   */
  extern function void set_property(string name, bit[1023:0] value);

  //------------------------------------------------------------------------------
  /**
   * Obtains a property value from this memory
   * 
   * @param name Property name to retrieve the value for
   * @param value Property value that was previously set
   * @return Return 1 if the name was previously set, 0 if not previously set
   */
  extern function bit get_property(string name, output bit[1023:0] value);

// ======================================================================
endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kr1ZTcYNITzzZ1Nn2kdYO1grqraQBn3EmTG96RY780JUbY4xd55C/ZbmNKWJYWFo
9BjD3oG13oLZeB4ZMDNWpey9TTtoadRA6w8i72ZCRKZc4QwRlXnFhT9kFNG8MqVZ
20sX+Kml+YqXlrORyRj9YlQ6cs8oGuKLusNinvZqxp/17ixE6Ac1Vg==
//pragma protect end_key_block
//pragma protect digest_block
gfETqe0robOKnNWKpqu8PD66AnA=
//pragma protect end_digest_block
//pragma protect data_block
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
aKH/zdSoorTV9GnoTvtotg==
//pragma protect end_data_block
//pragma protect digest_block
R/EDQ5nWkcsOAMT6VsEFj3GMtxw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_SV
