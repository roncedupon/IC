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

`ifndef GUARD_SVT_MEM_BACKDOOR_BASE_SV
`define GUARD_SVT_MEM_BACKDOOR_BASE_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

/** @cond SV_ONLY */
// =============================================================================
/**
 * This base class defines the common backdoor method signatures.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_mem_backdoor_base;
`else
class svt_mem_backdoor_base extends `SVT_DATA_BASE_TYPE;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Pattern type to define the default value for uninitialized memory locations. */
  typedef enum {
    INIT_CONST = `SVT_MEM_INITIALIZE_CONST, /**< Initialize to a constant value */
    INIT_INCR = `SVT_MEM_INITIALIZE_INCR, /**< Initialize to an incrementing pattern */
    INIT_DECR = `SVT_MEM_INITIALIZE_DECR, /**< Initialize to a decrementing pattern */
    INIT_WALK_LEFT = `SVT_MEM_INITIALIZE_WALK_LEFT, /**< Initialize to a walking left pattern */
    INIT_WALK_RIGHT = `SVT_MEM_INITIALIZE_WALK_RIGHT, /**< Initialize to a walking right pattern */
    INIT_RAND = `SVT_MEM_INITIALIZE_RAND /**< Initialize to a random pattern */
  } init_pattern_type_enum;

  /** Compare type which controls how compare operations are performed */
  typedef enum {
    SUBSET=`SVT_MEM_COMPARE_SUBSET, /** The content of the file is present in the memory core and any additional values in the memory are ignored */
    STRICT = `SVT_MEM_COMPARE_STRICT, /** The content of the file is strictly equal to the content of the memory core */
    SUPERSET = `SVT_MEM_COMPARE_SUPERSET, /** The content of the memory core is present in the file and additional values in the file are ignored */
    INTERSECT = `SVT_MEM_COMPARE_INTERSECT /** The same addresses present in the memory core and in the file contain the same data and addresses present only in the file or the memory core are ignored */
  } compare_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log instance used to report messages. */
  vmm_log log;
`else
  /**
   * SVT message macros route messages through this reference. This overrides the shared
   * svt_sequence_item_base reporter.
   */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Name given to the backdoor. Used to identify the backdoor in any reported messages. */
  protected string name = "";
`endif

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_mem_backdoor_base class.
   *
   * @param name (optional) Used to identify the backdoor in any reported messages.
   * @param log||reporter (optional but recommended) Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef SVT_VMM_TECHNOLOGY
  `svt_data_member_begin(svt_mem_backdoor_base)
  `svt_data_member_end(svt_mem_backdoor_base)
`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek(svt_mem_addr_t addr, output svt_mem_data_t data);  

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke(svt_mem_addr_t addr, svt_mem_data_t data);

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
  virtual function svt_mem_attr_t peek_attributes(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);
    peek_attributes = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Set the attributes for the addresses in the indicated address range. Does an
   * 'AND' or an 'OR' of the attributes within the range, based on the 'modes'
   * setting. The default setting results in an 'AND' of the attributes.
   * 
   * @param attr attribute to be set
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional attribute modes, represented by individual constants. Supported values:
   *   - SVT_MEM_ATTRIBUTE_OR - Specify to do an 'OR' of the attributes within the range. 
   *   .
   */
  virtual function void poke_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Loads memory locations with the contents of the specified file. This is the method
   * that the user should use when doing 'load' operations.
   *
   * The svt_mem_backdoor_base class provided implementation simply calls the internal
   * method, load_base, which is the method that classes extended from svt_mem_backdoor_base
   * must implement.
   *
   * The 'write_protected' field enables write protect checking for all of the loaded
   * memory locations.
   *
   * @param filename Name of the file to load. The file extension determines
   *        which format to expect.
   * @param write_protected If supported by the backdoor, marks the addresses
   *        initialized by the file as write protected.
   */
  extern virtual function void load(string filename, bit write_protected = 0);

  //---------------------------------------------------------------------------
  /**
   * Saves memory contents within the indicated 'addr_lo' to 'addr_hi' address range
   * into the specified 'file' using the format identified by 'filetype', where the
   * only supported values are "MIF" and "MEMH". The 'append' bit indicates whether
   * the content should be appended to the file if it already exists. This is the
   * method that the user should use when doing 'dump' operations.
   *
   * The svt_mem_backdoor_base class provided implementation simply calls the internal
   * method, dump_base, which is the method that classes extended from svt_mem_backdoor_base
   * must implement.
   *
   * @param filename Name of the file to write to.
   * @param filetype The string name of  the format to be used when writing a
   *        memory dump file, either "MIF" or "MEMH".
   * @param append Start a new file, or add onto an existing file.
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional dump modes, represented by individual constants. Supported values:
   *   - SVT_MEM_DUMP_ALL - Specify in order to include 'all' addresses in the output. 
   *   - SVT_MEM_DUMP_NO_HEADER - To exclude the header at the front of the file.
   *   - SVT_MEM_DUMP_NO_BEGIN - To exclude the BEGIN at the start of the data block (MIF).
   *   - SVT_MEM_DUMP_NO_END - To exclude the END at the end of the data block (MIF).
   *   .
   */
  extern virtual function void dump(string filename, string filetype, bit append, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Free the data associated with the specified address range, as if it had never
   * been written. If addr_lo == 0 and addr_hi == -1 then this frees all of the
   * data in the memory.
   *
   * @param addr_lo Low address
   * @param addr_hi High address
   *
   * @return Bit indicating the success (1) or failure (0) of the free operation.
   */
  extern virtual function bit free(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi);

  //---------------------------------------------------------------------------
  /**
   * Initialize the specified address range in the memory with the specified pattern.
   *
   * Supported patterns are:
   *   - constant value
   *   - incrementing values,
   *   - decrementing values
   *   - walk left
   *   - walk right
   *   - rand
   *   .
   *
   * @param pattern initialization pattern.
   * @param base_data Starting data value used with each pattern
   * @param start_addr start address of the region to be initialized.
   * @param end_addr end address of the region to be initilized.
   */
  extern virtual function void initialize(
    init_pattern_type_enum pattern = INIT_CONST,
    svt_mem_data_t base_data = 0, svt_mem_addr_t start_addr = 0, svt_mem_addr_t end_addr = -1);

  //---------------------------------------------------------------------------
  /**
   * Compare the content of the memory in the specifed address range
   * (entire memory by default) with the data found in the specifed file,
   * using the relevant policy based on the filename. This is the
   * method that the user should use when doing 'compare' operations.
   *
   * The svt_mem_backdoor_base class provided implementation simply calls
   * the internal method, compare_base, which is the method that classes
   * extended from svt_mem_backdoor_base must implement.
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
  extern virtual function int compare(string filename, compare_type_enum compare_type, int max_errors, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi); 

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Generates short description of the backdoor instance.
   *
   * @return The generated description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which operations are supported.
   *
   * The backdoor class may represent multiple backdoor instances in which case
   * the method should indicate which operations are supported by at least one
   * contained backdoor. Clients wishing to know which operations are supported
   * by all contained backdoors should refer to the 'get_fully_supported_features()'
   * method.
   *
   * Each operation included in the svt_mem_system_backdoor definition will have its
   * own bit value. A value of '1' in the bit position associated with a specific
   * operation indicates the operation is supported, a value of '0' indicates the
   * operation is not supported. Note that this insures that as new operations are
   * by default not supported.
   *
   * The following masks have been defined for the currently defined operations and
   * can be used to indicate or check specific operation support.
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
  virtual function int get_supported_features();
    get_supported_features = 0; 
  endfunction
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which operations are fully
   * supported.
   *
   * The backdoor class may represent multiple backdoor instances in which case
   * this method indicates which operations are supported by all contained backdoors.
   * Clients wishing to know which operations are supported by at least one contained
   * backdoor should refer to the 'get_supported_features()' method.
   *
   * The default implementation, which should be sufficient for simple backdoor
   * classes, simply calls 'get_supported_features()' to determine which operations
   * are supported.
   *
   * Each operation included in the svt_mem_system_backdoor definition will have its
   * own bit value. A value of '1' in the bit position associated with a specific
   * operation indicates the operation is supported, a value of '0' indicates the
   * operation is not supported. Note that this insures that as new operations are
   * by default not supported.
   *
   * The following masks have been defined for the currently defined operations and
   * can be used to indicate or check specific operation support.
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
  extern virtual function int get_fully_supported_features();
  
  //---------------------------------------------------------------------------
  /** 
   * Internal method for reading individual address locations from the memory. This
   * is the peek method which classes extended from svt_mem_backdoor_base must implement.
   * 
   * The modes argument is optional and is not used by the base class implementation.
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);  
    peek_base = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for writing individual address locations to the memory. This
   * is the poke method which classes extended from svt_mem_backdoor_base must implement.
   * 
   * The modes argument is optional and is not used by the base class implementation.
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);
    poke_base = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for loading memory locations with the contents of the specified
   * file. This is the file load method which classes extended from svt_mem_backdoor_base
   * must implement.
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
  virtual function void load_base(string filename, svt_mem_address_mapper mapper = null, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for saving memory contents within the indicated 'addr_lo' to
   * 'addr_hi' address range into the specified 'file' using the format identified
   * by 'filetype', where the only supported values are "MIF" and "MEMH". This is
   * the file dump method which classes extended from svt_mem_backdoor_base must
   * implement.
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
  virtual function void dump_base(
                    string filename, string filetype, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi,
                    svt_mem_address_mapper mapper = null, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method to free the data associated with the specified address range,
   * as if it had never been written. If addr_lo == 0 and addr_hi == -1 then this
   * frees all of the data in the memory.
   *
   * @param addr_lo Low address
   * @param addr_hi High address
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return Bit indicating the success (1) or failure (0) of the free operation.
   */
  virtual function bit free_base(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);
    free_base = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method to initialize the specified address range in the memory with
   * the specified pattern.
   *
   * Supported patterns are:
   *   - constant value
   *   - incrementing values,
   *   - decrementing values
   *   - walk left
   *   - walk right
   *   - rand
   *   .
   *
   * @param pattern initialization pattern.
   * @param base_data Starting data value used with each pattern
   * @param start_addr start address of the region to be initialized.
   * @param end_addr end address of the region to be initilized.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   */
  virtual function void initialize_base(
    init_pattern_type_enum pattern = INIT_CONST,
    svt_mem_data_t base_data = 0, svt_mem_addr_t start_addr = 0, svt_mem_addr_t end_addr = -1, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for comparing the content of the memory in the specifed
   * address range (entire memory by default) with the data found in the specifed
   * file, using the relevant policy based on the filename. This is the file compare
   * method which classes extended from svt_mem_backdoor_base must implement.
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
  virtual function int compare_base(
                    string filename, compare_type_enum compare_type, int max_errors, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi,
                    svt_mem_address_mapper mapper = null);
    compare_base = 0;
  endfunction

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Used to get the backdoor name.
   *
   * @return Name assigned to this backdoor.
   */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the backdoor name.
   *
   * @param name New name to be assigned to this backdoor.
   */
  extern virtual function void set_name(string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to get the backdoor name in a form that can easily be added to a message.
   *
   * @return Name assigned to this backdoor formatted for inclusion in a message.
   */
  extern virtual function string get_formatted_name();
  
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
HO+nmZzt26xIaf+hZ0j1b+mZ1jgTmLmLDkQSHVUh9VCnMYxP8n4XWwS1bxE9KgoN
2Td+6NSv2p9dAs09vECs9PzCDLqkGarJxFhI38WMhAWnxhn3fzm4+ooA//glXdWk
ugsczytTXltfHcyk9WZNL8ISMEgCtKpQdOWyQoo9PRIfGYQn74L+iQ==
//pragma protect end_key_block
//pragma protect digest_block
p2XtXzLXvR+10oSbc9KIC1BVTNo=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
mHvP+LSsqoh2jES9jNxScvTzpVo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_BACKDOOR_BASE_SV
