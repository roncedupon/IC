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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Ras/0vpV9/YLIYE64pHOigKCrR6ur+IbnArXBHTimOSJ6vk04GoFKS4sEPl1gNXV
9nhsYEqdpm2tZRR/9TAcQbO6lOE1JerTKCeM7M+K8jc51K3qq1xAbhbzABLoYV+5
SrpjKOiOg1yK4/usJvs7TAqdBWJieI4TXUzOel7So2iYo4x4AcgRbg==
//pragma protect end_key_block
//pragma protect digest_block
A6P2TTINe81urWuu8eDNWC6Pw4A=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
2rX9CVtgT6wrrFgZotJwNaXQKi4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_BACKDOOR_SV

