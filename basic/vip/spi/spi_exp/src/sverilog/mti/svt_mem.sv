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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ON0L+bytoQqykn0aO1C69yurymD57I7rzrvDjBdiys0LxPnCoPwMT4hrBGoOQldO
Yk+0jCinvXw5IY2JhWga3ABt9UwV/8t4YjRkicZMchNgXoo3ISyXNcscLzWOBV4T
vUpRALqyhrRMd++xcDRZNqi/5U2W09q4+da9axIjeEk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1173      )
xaucIk0T5WIkXjwl2PjNcbBgwKJV3n3InLo7Gp1e5/opfnF5lcctR0gBS7TQix4P
9v6rV2Euf6VlRXKALrklPyMzW1s9413Wcou0dE4y5TYgvHcbuv1r5rWRM40PVagb
tJNgtbwqI79PxSb2r9JDqGfaH+9pEmyAssX/RW18Xviqlpc4wemT8aeDlzmbomZA
pnJkf4Ul16evkr10MieFQzK2in0ayWXbjBVjchmPZQW5YFPHEb4Gd8j5xV0BPTsr
bGbw82mGiqvwFYpiJgOa1Vb3TwOtMnbJ5BUho5kzEHSmmRntOfDhjTHPyznAzcF1
bk6qKjRjpQeL6w/7MIdtCGCxq39NMc1nm3IQyr3ki5XhbYhQZY6cYyP3LTOdqDlJ
LbNkbOx1JFMOVmZbWFTHKTOGkLWDTGh3biEA8z7Mbb8eQHNbbg0eO8MKizC0Qx+o
Vf2gUwu7v3Y/+JF7uIwSCCmAb3gPPXHoW8UBVFdvvDR/YaecjfcJa1AYFgpBJkeU
yMyG9vo53ZSOZE2ZZjUrJQkHHxhQuO79oP2X392Og/ixBM59jL4XYi0B2XEklFya
Hl06hwLBb0lCXXN/+Y4eosAvK2pQjjfN7aoxfSJBz/z8H47g01k+yeBr5PAJnHbV
HeiGRMA8iSoCOmciEk5vnlDzyG/KdoGNFdTGeVNPy5U3fAHDhKt3b/EwUK6sn4/L
+WJHWiyC3P85yKKAQHAMWBOjEmcK4kBW4B7gh2AcelHvIkdcl4E6HVpYf5nH+FSl
pcJIvSkWxeIgvkUc/Jj1/8J88U6tFhNw/8X4jvJMzSP+qLZv3P87U5cg6hQVCGEK
KP0f8vra+OYC/L1XQ8QZo8Qt7yS2EidRW4c8Rzen11IZ8h4yUVO9xX7qp/KKiBFC
sbJhf7SZhP7eW1+oet/XWIhvdilaXX+UcKsmIss3Eb7XdWUc3D/EzWm3RVG44yDk
XDofUp6jENgIazmi5B4R0BfuO6EAH1CCc4TtostWHCPX5t3DGAIwXXqImHwR/Tjq
y2IPMvMGbaZHeaz8lqm3iLksC1h871LXmfJ9bWX2Gers7U+ahcSR0CiE33xL2MyP
spiCUzn1tO4mU3jjLyQGWBFWzOh4GA5m0LU7INHUibSv0eeSOZh5acIarmAwOWg6
EFa58hgv4e4gdjYtGsUG1yelZqXz8SOXNa+iaMG/s5l5HvaIYkga1Y1wf300sGvV
SmZllVjvOLz+5jTESkTS0N1v3BrtBcK4OSonU8OAKbzaSaqY9OOfl5NjwSPyIa2l
GHMXGgWDfA/WbEHUJ28q28DIiqxWupUsVYUa03eXodQpCYWOvu9OJeUb4JWcIPQJ
ccwZ94W6UP9QpDufvMUEy4MXyB0kUsQjOxZfa+W9b3lmDleaFdsY0x2o2N2XdIsr
z4peCi8o0UyhnomySwk71rdHr2UQcv/JC7JFE0u/FCRjiJtXA91LXuijNpVUIimc
GPMAooigIgbTdzkgK5yWLoEmsQNL8/o78n7+h5wkXzgEiBvzFeVuQHCOkBPB35HC
t6u5dZJqh+HPMW+lJk/IpsmzEGPKzYL/yPUsyIv6PLM=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZPlDwc2hDAqm7SKMDXIGMLPjKCMKbA3xINkSAPUW2Dwxr6Ulpyac7/s63sutGSbT
Pe6XTfQPVO05oyNnMG+LEMZqbaD5WeNaKGdih4XRpufQ0YEwGrEntNsRJ3cLtJw0
h6V6Q8HoVA5YGK3TwvkbvPJxbF+RY4jbb6BRHboXMfA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1815      )
gXjVkcSzinoS60/fVx0nuOVx5ZKxtN7MiiPKWWW5Bv4/+TJJjbLoqfcffJYMqQyC
KmI4t47/CVXKwKPXN4XT2/FxPjH1RuhdIxjvd2U6DAOFaHIxF//s1Ei43DaODURl
+l7E7eIyWuMyYoee6+jmLfWknvWIGy0Ce7ovX4mQ/4BzSqLS5bqXo6JbdWUmqFR8
XwaDUWFr69JZ4y8g5iJq7OsBtj9PUVZcu4FRMmnl4nIOKqPhxw7zTA3zLv2rp0C5
86Yud5ry0NodaL3jdMwyAjwMFwwCCiPdQwLjiXey8gyqrX3QVU3yhT+Ool356gyw
gPMJnXZO75KEJ/MiFszbhQ5T0RoGMLgC2FFKxmN9mg4C0GMhaiSojceQkadeCkhL
fbTL3UyNEd4TtvYx2KmRZ8YiWMWnPoFTI0c9BAfS88tgP1uF+otyoBdYCtGXiGRo
QJWLwXWNb9z9LpKTi0vKXoICIRbj76GiT7yhzH1f5tuXNoNKzN1ZdRW7k/7HiUww
5SYV2DIlQsUupM3h+FI4lu1ADNd3Eq9jdEeR26GMe4N6a1BTRMi496Iyg9gANiWG
SvudY/mYlLmbu3gV81tC3XQqd32w+uUwAJOZHE50XG6mA3sZ8gaYwl5Sc3HaTfTr
PgXGEANqFrjYVctZH3mdoBY7e6/x9IhJ6txkDwJQ9V+KcWfbnFwkqe8OVzj7uMq1
hzyIFAHeOPNuY5i8dpyePuEdm6Vx+OVHi/ghkM57yrXMSij+TlD51AW5JX86yshD
siBuuavQOwtrOXQdaQhdpDGjtXAPxpoqrvNe5wV+N/5phxplNo5jIMmUdAxQ8Jjn
5XfSGgi50AoB85IZfaO41ouu3Lnn8mwZQy+fvTGq27Y=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ca4mVqXu14HpnLqp0b52mj+ZTFow7xQzsZor/5wrVdaW9oroOA4ZNwm8G8Zd5aJu
nIIc+ku0CjGbSbxzvI2VhCC3AvOO08uUNHSWFY/hDx/j8ooj9NrVL41WW+YzXYDv
druR4+HAMgsWZEQa3mrcmMze1KCk4gBr4JfEfU1+ORE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31368     )
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
`pragma protect end_protected

`endif // GUARD_SVT_MEM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CRFA5E/uBMH7GqpwKJWnNjFh+j5LuQGy48pXs2ZpsIYD+CY3mLSXFCjgPeyuou+U
uSrRlYiRX4QshqDxtJPV4LGrdc5VvnyAMcepjEiAtUXOQ+zmufL76c7ufRoFkhV7
2QXn16iXQd925MNps+6PUZX2q4ADw+ZvdbRNgkQqv10=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31451     )
UkIdWZ46lWr6Yd5gdi6uFGm1kNOl0EMp2cIKC5MvpXDGCStuEn1RBAK2r+lEn7jE
1VSPjuwslKAMmMvMnBPCUCIPklxyoQS2Jtrmepo5wsEZMNEf2mufDQ87kP7+ZvKn
`pragma protect end_protected
