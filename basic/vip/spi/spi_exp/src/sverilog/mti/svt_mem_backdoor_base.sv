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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QmocH3a3z45Ttk3h/nLaddZTY9Ee8eHBU6DkeZApk5plDX1vndUoow0Zur+ohNvk
0LQ0eYpSF5u8xmFLq/Ky2qPORr2GyU7jTXMAVXjbBfNwR3MmuMvOZqAJdE/1zwBk
w7eeou06AyicupzO+IK7gDUbWqPbbaWP8+ndKBO3Zek=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6494      )
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
2EgVnrCkJZKa2vkECGAtBg==
`pragma protect end_protected

`endif // GUARD_SVT_MEM_BACKDOOR_BASE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GCq1iGpLEpc8/qk6lz7dhqgBZtnuevP1j5nHnXI9Jhk53Le6Zww0rPRKVewVh5hC
5fk0a9xR71uXqkKbFJxs2qW5ooiNltJkhNW01VvZsxAtJpflr8GGFy1e3/4ygRjl
Br5x2wGGg4iStKVHDibI49WmZdc1SiKbMzRRNeLJhmo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6577      )
B+3ZljBGEJZ5hoplfDHxhyQnpGaHc178riEflmT/3qclVCAATKXAiuBSqbHDVd3f
NwWoK8EG5p7MPaYp1wYJdkCFNWW37dDdlstyw180NSNjvAQtWc3A/epA8AG1P54K
`pragma protect end_protected
