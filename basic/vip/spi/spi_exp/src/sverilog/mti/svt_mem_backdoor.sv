//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_BACKDOOR_SV
 `define GUARD_SVT_MEM_BACKDOOR_SV


`ifndef SVT_MEM_DPI_EXCLUDE
  // Needed to select 2state or 4 state server instances
  `define SVT_MEM_BD_SVR_DO_E(R)  mem_core.get_is_4state()?mem_core.svr_4state.R:mem_core.svr_2state.R
  `define SVT_MEM_BD_SVR_DO_S(R)  if (mem_core.get_is_4state()) mem_core.svr_4state.R; else mem_core.svr_2state.R
  `define SVT_MEM_BD_SVR_DO_LR(L,R) if (mem_core.get_is_4state()) L=mem_core.svr_4state.R; else L=mem_core.svr_2state.R
 `endif


// =============================================================================
/**
 * This class provides a backdoor and iterator interface to a memory core. Multiple
 * instances of this interface may exist on the same memory core.
 */
class svt_mem_backdoor extends svt_mem_backdoor_base;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  // Store name of this class
  string name;

  /**
   * Pre-defined attribute indicating an address has been written or initialized.
   * Provided for backwards compatibility, but clients should actually use the
   * SVT specified attribute constants.
   *
   * Note that this uses the SVT_MEM_ATTRIBUTE_INIT constant, although the backdoor
   * code actually assumes that it represents all occupied locations, whether they
   * have been initialized or written to.
   */
  static const svt_mem_attr_t WRITTEN = `SVT_MEM_ATTRIBUTE_INIT;

  /**
   * Predefined attribute indicating an address was last accessed by a READ operation.
   */
  static const svt_mem_attr_t LAST_RD = `SVT_MEM_ATTRIBUTE_LAST_RD;

  /**
   * Predefined attribute indicating an address was last accessed by a WRITE operation.
   * Provided for backwards compatibility, but clients should actually use the
   * SVT specified attribute constants.
   */
  static const svt_mem_attr_t LAST_WR = `SVT_MEM_ATTRIBUTE_LAST_WR;   

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
/** @cond PRIVATE */

  //----------------------------------------------------------------------------  
  /** Memory core reference to svt_mem_core instance */
  protected svt_mem_core mem_core;
   
  //----------------------------------------------------------------------------  
  /** A memory address */
  protected svt_mem_addr_t iterator;

`ifdef SVT_MEM_DPI_EXCLUDE
  //----------------------------------------------------------------------------  
  /** Current attribute that the iterator is associated with */
  protected svt_mem_attr_t attr;
`endif
   
/** @endcond */

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************
   
`ifndef SVT_MEM_BACKDOOR_DISABLE_FACTORY

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_mem_backdoor instance
   * 
   * @param name (optional) Used to identify the backdoor in any reported messages.
   * @param mem_core (required) The specific mem_core that this backdoor points to.
   * @param log||reporter (optional but recommended) Used to report messages.
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", svt_mem_core mem_core = null, `SVT_XVM(report_object) reporter = null);
`else
  extern function new(string name = "", svt_mem_core mem_core = null, vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef SVT_VMM_TECHNOLOGY
  `svt_data_member_begin(svt_mem_backdoor)
  `svt_data_member_end(svt_mem_backdoor)
`endif

`else

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new svt_mem_backdoor instance
   * 
   * @param mem_core The specific mem_core that this backdoor points to.
   * 
   * @param reporter Message reporter instance
   */
  extern function new(svt_mem_core mem_core, `SVT_XVM(report_object) reporter);
`else
  /**
   * CONSTRUCTOR: Create a new svt_mem_backdoor instance
   * 
   * @param mem_core The specific mem_core that this backdoor points to.
   * 
   * @param log Message reporter instance
   */
  extern function new(svt_mem_core mem_core, vmm_log log);
`endif

`endif
  //---------------------------------------------------------------------------
  /** Returns the configured data width of the memcore */ 
  extern virtual function int get_data_width();

  //---------------------------------------------------------------------------
  /** Returns the configured address width of the memcore */
  extern virtual function int get_addr_width();

  //---------------------------------------------------------------------------
  /**
   * Creates a new user-defined attribute that can be attanched to any address.
   * Different user-defined attributes can be bitwise-OR's to operate on
   * multiple attributes at the same time.
   * 
   * The return value is the attribute mask for the new attribute.
   **/
  extern function svt_mem_attr_t new_attribute();

  //---------------------------------------------------------------------------
  /**
   * Release a presviously-created user-defined attribute. The released
   * attibute may be reused by a new subsequently created user-defined
   * attibute.
   * 
   * @param free_attr_mask attributes to be freed.
   */
  extern function bit free_attribute(svt_mem_attr_t free_attr_mask);

  // ---------------------------------------------------------------------------
  /** Create a write protect to a memory range
   * 
   *  @param addr_lo low addr address
   *  @param addr_hi high addr address
   */
  extern function void protect(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi);

  // ---------------------------------------------------------------------------
  /** Release write protect to a memory range
   * 
   *  @param addr_lo low addr address
   *  @param addr_hi high addr address
   */
  extern function void unprotect(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi);

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found a the specified address
   * Returns TRUE if a value was found. Returns FALSE otherwise. By default. the
   * attributes are not modified but if specified, attributes may be set or cleared.
   * 
   * @param addr address on which data to be read
   * @param data ouput data on specified address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);  

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address. By default, the
   * attributes are not modified but if specified, attributes may be set or 
   * cleared.
   * 
   * @param addr address on which data to be written
   * @param data data to be written to the specific address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);  

  //---------------------------------------------------------------------------
  /**
   * Return the attribute settings for the indicated address range. Does an 'AND'
   * or an 'OR' of the attributes within the range, based on the 'modes' setting.
   * The default setting results in an 'AND' of the attributes.
   * 
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional attribute modes, represented by individual constants. Supported values:
   *   - SVT_MEM_ATTRIBUTE_OR - Specify to do an 'OR' of the attributes within the range. 
   *   .
   */
  extern virtual function svt_mem_attr_t peek_attributes(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Set the attributes for the addresses in the indicated address range. Does an
   * 'AND' or an 'OR' of the attributes within the range, based on the 'modes'
   * setting. The default setting results in an 'AND' of the attributes.
   *
   * Special care must be taken when setting the 'access' attributes for a
   * memory location as these attributes govern how the memory package interacts
   * with the location.
   * An access value of SVT_MEM_ATTRIBUTE_UNINIT, for example, indicates the location
   * is not occupied. This will result in the failure of subsequent peek,
   * peek_attribute, and poke_attribute operations of that location.
   *
   * Changing the access value between the different 'occupied' settings will not
   * not result in failures with subsequent peek or poke operations. But it could
   * impact the outcome of subsequent access checks which rely on these settings
   * to discern the current state of the memory locations. The 'occupied' settings
   * are defined by:
   *   - SVT_MEM_ATTRIBUTE_LAST_WR - Last access was a 'write' operation.
   *   - SVT_MEM_ATTRIBUTE_INIT - Last access was a 'poke' or 'initialize' operation.
   *   - SVT_MEM_ATTRIBUTE_LAST_RD - Last access was a 'read' operation.
   *   .
   *
   * @param attr attribute to be set
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional attribute modes, represented by individual constants. Supported values:
   *   - SVT_MEM_ATTRIBUTE_OR - Specify to do an 'OR' of the attributes within the range. 
   *   .
   */
  extern virtual function void poke_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Set the specified attributes for the specified address
   * 
   * @param attr attribute to be set
   * @param addr address at which the attribute is updated
   */
  extern virtual function void set_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr);

  //---------------------------------------------------------------------------
  /**
   * Return TRUE if the specified address exists and all of the specified
   * attributes are set for the specified address.
   * 
   * @param attr attribute to test for
   * @param addr address to test at
   */
  extern virtual function bit are_set(svt_mem_attr_t attr, svt_mem_addr_t addr);

  //---------------------------------------------------------------------------
  /**
   * Clear the specified attributes for the specified address
   *
   *  @param attr attribute mask which determines which attributes to clear
   *  @param addr address to modify the attribute for
   */
  extern virtual function bit clear_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr);

  //---------------------------------------------------------------------------
  /**
   * Free the data associated with the specified address range, as if it had never
   * been written. If addr_lo == 0 and addr_hi == -1 then this frees all of the
   * data in the memory.
   * 
   * @param addr_lo Low address
   * @param addr_hi High address
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return Bit indicating the success (1) or failure (0) of the free operation.
   */
  extern virtual function bit free_base(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /** Free all data in the memory. */
  extern virtual function void free_all();   
   
  //---------------------------------------------------------------------------
  /**
   * Reset the iterator to the first address with all the specified(bitwise-OR'd)
   * attributes set. Default is SVT_MEM_ATTRIBUTE_INIT, which is interpreted to
   * represent all occupied locations, whether they have been initialized or
   * written to.
   */
  extern virtual function bit reset(svt_mem_attr_t attr = `SVT_MEM_ATTRIBUTE_INIT);

  //---------------------------------------------------------------------------
  /** Make a copy of this class, including the state of the iterator */
`ifdef SVT_VMM_TECHNOLOGY
  extern virtual function svt_mem_backdoor clone();
`else
  extern virtual function `SVT_DATA_BASE_OBJECT_TYPE clone();
`endif

  //---------------------------------------------------------------------------
  /**
   * Copy the state of the specified iterator to this iterator. The specified
   * iterator must refer to the same memory core.
   * 
   * @param rhs svt_mem_backdoor object to be copied.
   */
  extern virtual function void copy(svt_mem_backdoor rhs);  

  //---------------------------------------------------------------------------
  /**
   * Return the value in the memory location corresponding to the current
   * location of the iterator.
   */
  extern virtual function svt_mem_data_t get_data();  

  //---------------------------------------------------------------------------
  /**
   * Return the address of the memory location corresponding to the current
   * location of the iterator.
   */
  extern virtual function svt_mem_addr_t get_addr();  

  //---------------------------------------------------------------------------
  /**
   * Return the bitwise-OR of all attributes set for the memory location
   * corresponding to the current location of the iterator
   */
  extern virtual function svt_mem_attr_t get_attributes();  

  //---------------------------------------------------------------------------
  /**
   * Move the iterator to the next memory location. The order in which
   * memory location are visited is not specified.
   */
  extern virtual function bit next();  

`ifndef SVT_MEM_DPI_EXCLUDE
  //---------------------------------------------------------------------------
  /** Retrieve the attribute mask for the lock attribute */
  extern virtual function int get_access_lock_attr();

  //---------------------------------------------------------------------------
  /** Retrieve the attribute mask for the write protect attribute */
  extern virtual function int get_write_protect_attr();
`endif

  //---------------------------------------------------------------------------
  /**
   * Sets the error checking enables which determine whether particular types of
   * errors or warnings will be checked by the C-based memserver application. The
   * check_enables mask uses the same bits as the status values.
   * 
   * The following macros can be supplied as a bitwise-OR:
   * <ul>
   *  <li>`SVT_MEM_SA_CHECK_RD_RD_NO_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_LOSS</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_SAME</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_RD_B4_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_PROT</li>
   *  <li>`SVT_MEM_SA_CHECK_ADR_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_DATA_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_LOCKED</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_ERROR</li>
   *  <li>`SVT_MEM_SA_CHECK_PARTIAL_RD</li>
   * </ul>
   * 
   * Note however that not all status values represent error checks that can be
   * disabled. Two pre-defined check enable defines exist:
   * <ul>
   *  <li>`SVT_MEM_SA_CHECK_STD</li>
   *  <ul>
   *   <li>includes RD_B4_WR, PARTIAL_RD, ADR_ERR, DATA_ERR</li>
   *  </ul>
   *  <li>`SVT_MEM_SA_CHECK_ALL</li>
   *  <ul>
   *   <li>includes all checks listed above</li>
   *  </ul>
   * </ul>
   *
   * @param enables Error check enable mask
   */
  extern virtual function void set_checks(int unsigned enables);

  //---------------------------------------------------------------------------
  /** Retrieves the check mask which determines which checks the memserver performs 
   *
   * Retrieves the check mask which determines which checks the C-based memserver
   * application performs.  The return value is a bitwise-OR that determines which
   * checks are enabled.
   * 
   * The following macros can be used to test whether specific checks are enabled:
   * <ul>
   *  <li>`SVT_MEM_SA_CHECK_RD_RD_NO_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_LOSS</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_SAME</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_RD_B4_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_PROT</li>
   *  <li>`SVT_MEM_SA_CHECK_ADR_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_DATA_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_LOCKED</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_ERROR</li>
   *  <li>`SVT_MEM_SA_CHECK_PARTIAL_RD</li>
   * </ul>
   */
  extern virtual function int unsigned get_checks();

  //---------------------------------------------------------------------------
  /**
  * Initialize the specified address range in the memory with the specified
   * pattern. Supported patterns are: constant value, incrementing values,
   * decrementing values, walk left, walk right. For user-defined patterns, the
   * backdoor should be used.
   *
   * @param pattern initialization pattern.
   * @param base_data Starting data value used with each pattern
   * @param start_addr start address of the region to be initialized.
   * @param end_addr end address of the region to be initilized.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   */
  extern virtual function void initialize_base(init_pattern_type_enum pattern=INIT_CONST, svt_mem_data_t base_data = 0, svt_mem_addr_t start_addr=0, svt_mem_addr_t end_addr=-1, int modes = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which of the common memory
   * operations (i.e., currently peek, poke, load, and dump) are supported.
   *
   * This class supports all of the common memory operations, so this method
   * returns a value which is an 'OR' of the following:
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_supported_features();
  
  //---------------------------------------------------------------------------
  /**
   * Internal method for loading memory locations with the contents of the specified
   * file.
   *
   * The 'mapper' can be used to convert between the source address domain used in the
   * file and the destination address domain used by the backdoor. If the 'mapper' is
   * not provided it implies the source and destination address domains are the same.
   *
   * @param filename Name of the file to load. The file extension determines
   *        which format to expect.
   * @param mapper Used to convert between address domains.
   * @param modes Optional load modes, represented by individual constants. Supported values:
   *   - SVT_MEM_LOAD_WRITE_PROTECT - Marks the addresses initialized by the file as write protected
   *   .
   */
  extern virtual function void load_base(string filename, svt_mem_address_mapper mapper = null, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Internal method for saving memory contents within the indicated 'addr_lo' to
   * 'addr_hi' address range into the specified 'file' using the format identified
   * by 'filetype', where the only supported values are "MIF" and "MEMH".
   *
   * The 'mapper' can be used to convert between the source address domain used in
   * the file and the destination address domain used by the backdoor. If the 'mapper'
   * is not provided it implies the source and destination address domains are the
   * same.
   *
   * The 'modes' field is a loophole for conveying basic well defined instructions
   * to the backdoor implementations.
   *
   * @param filename Name of the file to write to.  The file extension
   *        determines which format the file is created in.
   * @param filetype The string name of  the format to be used when writing a
   *        memory dump file, either "MIF" or "MEMH".
   * @param addr_lo Starting address
   * @param addr_hi Ending address
   * @param mapper Used to convert between address domains.
   * @param modes Optional dump modes, represented by individual constants. Supported values:
   *   - SVT_MEM_DUMP_ALL - Specify in order to include 'all' addresses in the output. 
   *   - SVT_MEM_DUMP_NO_HEADER - To exclude the header at the front of the file.
   *   - SVT_MEM_DUMP_NO_BEGIN - To exclude the BEGIN at the start of the data block (MIF).
   *   - SVT_MEM_DUMP_NO_END - To exclude the END at the end of the data block (MIF).
   *   - SVT_MEM_DUMP_APPEND - Append the contents to the existing file if found.
   *   .
   */
  extern virtual function void dump_base(
                    string filename, string filetype, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi,
                    svt_mem_address_mapper mapper = null, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Internal method for comparing the content of the memory in the specifed
   * address range (entire memory by default) with the data found in the specifed file,
   * using the relevant policy based on the filename.
   *
   * The 'mapper' can be used to convert between the source address domain used in
   * the file and the destination address domain used by the backdoor. If the 'mapper'
   * is not provided it implies the source and destination address domains are the
   * same.
   *
   * The following comparison mode are available:
   *
   * - Subset: The content of the file is present in the memory core. The
   *   memory core may contain additional values that are ignored.
   * - Strict: The content of the file is strictly equal to the content of the
   *   memory core.
   * - Superset: The content of the memory core is present in the file. The
   *   file may contain additional values that are ignored.
   * - Intersect: The same addresses present in the memory core and in the
   *   file contain the same data. Addresses present only in the file or the
   *   memory core are ignored.
   * .
   *
   * @param filename Name of the file to compare to.  The file extension
   *        determines which format the file is created in.
   * @param compare_type Determines which kind of compare is executed
   * @param max_errors Data comparison terminates after reaching max_errors. If
   *        max_errors is 0 assume a maximum error count of 10.
   * @param addr_lo Starting address
   * @param addr_hi Ending address
   *
   * @return The number of miscompares.
   */
  extern virtual function int compare_base(
                    string filename, compare_type_enum compare_type, int max_errors,
                    svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, svt_mem_address_mapper mapper = null); 

endclass: svt_mem_backdoor

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iPq+qxyoF1vXY0ya87VKmdaMg5Twq/kilRXIGOFah+hAaBA3yzK3dcR9UWpovhg7
qidLINuN7b5GU8aiAkoZGB+csbAspT14ifxxBe2gcRlZ1n/7EZGk6+b1M3HwN5nJ
zhK1YnzMWaamNHBt5GHrcNC1bwiaPY5JP/w2oPNFKJA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18577     )
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
j3kJj0HQ5b9MOXSisFuSD1e1HMMx/u+ZmlhW14oZ54Whx9s2QwI99r8EmpXa7rtL
42GJ5bQqj1wdU/VQYFj9mqFTUkrQ3tVNo59KKyxertzT1vDapg4I/PBt7IijQ/3X
SZqquxWDvD5BRWLmk/sSjTzCFTwgXL4lcEDbBv+uIZjlh0nPSeT9txzN1GGRJuNc
hlpQlH79ogWmjnRob/z5mAM/lFtbPiej6l1I/Ejum6xv2J+4j41LyTiL7bfofHas
NqH0txaTbEqve9BxvNDWcOoqOtv5shPgADoK97bXjXEUn5F66ilVOHBEPWKv1939
DhYHKzkdSN/O4gTnHcH+cLSJ5fFwZLynw3HcVQCMVIUdaDNb222ul2lMbyzZoYtK
yYdp7bTeyue7jyWsiMMvB/llSU1BRwpOkAGLp190PNlszHdpAFznA99edWF18rhT
DFN0mM4MGWQyzeUWsC6Jk3CT8UrIAFGKJ6yyQL58dpaBGHgJ8Y78TqyI8CLiMDZX
enlBuFI7B7UmJVnXI+zjwDtSCogxRnJm1RrzNLCMjZ9TYA03vzWflJR1I6bg+Lof
EETtvWYQrpH/PoeJ5R7xU8X3IiINphfCq0TkDCq66E9t22HKReXbgJSmz3b/GgPq
xi0VauPtJmnwfMeG+Pd4ywsWtSdW7IQO0A6R6VUWv3rUYVHnvC0m9AH/7np/1Rkz
u2hwDSyAkSnsCVal7MRQK82crMgg92h6r3EyQI75sEVX4lnVqyNIz6w6tFIxCoJ9
OSPig+y0i5e5QOAYtjNqpfi8lWT/1Uv/4dlSCmhcFyUsqFXzhRskVgFfB15rArgD
s4VKBh+qNoS93bqRotZ5vHwyYOqwXAAHiBbVhWdck/queP9uYmUR41x7GUzIIvDa
PItWpMyarsL5g6xWxbCltyB2hy1b/OTLn+Im8Wn0VJMDBPDA8GZruJ5HdImrklv3
wbL2uaf6424f0A8dKnKbUttDkC4y1MZP5tnbn9HredaO2mDJZQeOBSk+CxfiiB6x
jLBtcXPmjJZZKEQ0jLWIzuDpJpmJreadkND6Uy/+h4RSMS/wqQmUf+XyZa6S6vmr
7JUPeZsTV0VboSaYy9svAER4Ae95nqSt4TfJqarerAyBYlhb/cI+ociLfYkpUKXC
ndyVWeEzsHgu3785j4zGg5f/OvSPbD2hfeeUZ0C3uX6ODL/jvSB2guD/F/87QDCa
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
y2SZMRVibj8Oyfk+eCdH9Q==
`pragma protect end_protected

`endif // GUARD_SVT_MEM_BACKDOOR_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YyFG42r/vrX5SO4UvFIk9zNCvQpmFVEG2vlWYEvYdXeAm/piwjuakWZGlXmw1Hhz
VPHbeop+PN4ZPk4Rr4sabWQ/1Yj4HKNvnjpJDcY5FOPUxNOyl5k2H/2YVSvDyM0o
KiE4EtQ50OCKvEkawVVL+RSS48Ou1+FjTUsMQkfSigo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18660     )
6huPpPdabTbTum5b1bLoMb8aCCwOkmEU8QcwZvUJAC4usqSz6y3tv/YXwoYJEx4Z
tygVYNgQAPmVSwGE3TblU2qDJIEFGEVHw3qVpWr94fcknf22y0juoqLllQ00OGwf
`pragma protect end_protected
