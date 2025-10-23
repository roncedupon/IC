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

`ifndef GUARD_SVT_MEM_SYSTEM_BACKDOOR_SV
`define GUARD_SVT_MEM_SYSTEM_BACKDOOR_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

/** @cond SV_ONLY */
// =============================================================================
/**
 * This class manages a set of backdoor instances, converting requests relative to
 * the common source address domain into requests for the individual backdoor
 * instances using the individual destination address domains specified for these
 * backdoor instances.
 */
class svt_mem_system_backdoor extends svt_mem_backdoor_base;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /**
   * List of svt_mem_backdoor_base instances. The backdoor at a given index in the
   * 'backdoors' queue is supported by the address mapping stored at the same index
   * in the 'mappers' queue.
   */
  local svt_mem_backdoor_base backdoors[$];

  /**
   * List of svt_mem_address_mapper instances. The mapper at a given index in the
   * 'mappers' queue defines the address mapping for the backdoor at the same index
   * in the 'backdoors' queue.
   */
  local svt_mem_address_mapper mappers[$];

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_mem_system_backdoor class.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
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
  `svt_data_member_begin(svt_mem_system_backdoor)
  `svt_data_member_end(svt_mem_system_backdoor)
`endif

  // ---------------------------------------------------------------------------
  /**
   * Register the 'backdoor' instance that is responsible for backdoor operations
   * for the addresses represented by 'mapper'.
   */
  extern virtual function void register_backdoor(svt_mem_backdoor_base backdoor, svt_mem_address_mapper mapper);

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The peek is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   *
   * This method uses 'addr' as a source domain address to identify the correct
   * backdoor instance. The poke is then redirected to this backdoor, after
   * converting the address to the appropriate destination domain address.
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
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
   * This method works in terms of source domain addresses, converting them to destination
   * domain addresses and redistributing the request to the appropriate backdoor instances.
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
   * This method works in terms of source domain addresses, converting them to destination
   * domain addresses and redistributing the request to the appropriate backdoor instances.
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
   * Loads memory locations with the contents of the specified file. This is the method
   * that the user should use when doing 'load' operations.
   *
   * The svt_mem_system_backdoor class provided implementation simply provides entry
   * and exit debug messages, otherwise relying on the super to implement the method.
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
   * The svt_mem_system_backdoor class provided implementation simply provides entry
   * and exit debug messages, otherwise relying on the super to implement the method.
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
   * This method works in terms of source domain addresses, converting them to destination
   * domain addresses and redistributing the request to the appropriate backdoor instances.
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
  /**
   * Initialize the specified address range in the memory with the specified pattern.
   *
   * This method works in terms of source domain addresses, converting them to destination
   * domain addresses and redistributing the request to the appropriate backdoor instances.
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
   * @param pattern Initialization pattern.
   * @param base_data Starting data value used with each pattern.
   * @param start_addr Low address of the region to be initialized.
   * @param end_addr High address of the region to be initialized.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   */
  extern virtual function void initialize_base(
    init_pattern_type_enum pattern = INIT_CONST,
    svt_mem_data_t base_data = 0, svt_mem_addr_t start_addr = 0, svt_mem_addr_t end_addr = -1, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Compare the content of the memory in the specifed address range
   * (entire memory by default) with the data found in the specifed file,
   * using the relevant policy based on the filename. This is the
   * method that the user should use when doing 'compare' operations.
   *
   * The svt_mem_system_backdoor class provided implementation simply provides entry
   * and exit debug messages, otherwise relying on the super to implement the method.
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
   * Used to convert a source address into a destination address. Accomplished by
   * doing repeated conversions, starting with the source backdoor and mapper for
   * the provided 'src_addr' and ending with the destination backdoor and mapper
   * that is reached after the multiple conversions. Issues a warning and returns
   * an address of '0' if the src_addr cannot be mapped to an address supported
   * by any of the destination backdoor instances.
   *
   * @param src_addr The original source address to be converted.
   * @param backdoor The backdoor for the destination address.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_addr(svt_mem_addr_t src_addr,
                                                       output svt_mem_backdoor_base backdoor);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to convert a destination address into a source address. Accomplished by
   * doing repeated conversions, starting with the destination backdoor and mapper for
   * the provided 'dest_addr' and ending with the source backdoor and mapper
   * that is reached after the multiple conversions. Issues a warning and returns
   * an address of '0' if the dest_addr cannot be mapped to an address supported
   * by any of the source backdoor instances.
   *
   * @param dest_addr The original destination address to be converted.
   * @param backdoor The backdoor for the destination address.
   *
   * @return The source address based on conversion of the destination address.
   */
  extern virtual function svt_mem_addr_t get_src_addr(svt_mem_addr_t dest_addr,
                                                      svt_mem_backdoor_base backdoor);
  
  // ---------------------------------------------------------------------------
  /**
   * Generates short description of the backdoor instance. This includes information
   * for all of the backdoor and mapper instances.
   *
   * @return The generated description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which operations are supported.
   *
   * This class represents multiple backdoor instances so this method indicates
   * which operations are supported by at least one contained backdoor.
   * Clients wishing to know which operations are supported by all contained
   * backdoors should refer to the 'get_fully_supported_features()' method.
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
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_supported_features();
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which operations are fully
   * supported.
   *
   * This class represents multiple backdoor instances so this method indicates
   * which operations are supported by all contained backdoors. Clients wishing
   * to know which operations are supported by at least one contained backdoor
   * should refer to the 'get_supported_features()' method.
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
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_fully_supported_features();
  
  //---------------------------------------------------------------------------
  /**
   * Internal method for loading memory locations with the contents of the specified
   * file. This is the file load method which classes extended from svt_mem_backdoor_base
   * must implement.
   *
   * The svt_mem_system_backdoor implementation redistributes the request to the
   * appropriate backdoor instances.
   *
   * The 'mapper' can be used to convert between the source address domain used in the
   * file and the destination address domain used by the backdoor. If the 'mapper' is
   * not provided it implies the source and destination address domains are the same.
   *
   * As part of the process of forwarding this request the svt_mem_system_backdoor must
   * provide the appropriate mapper to the destination backdoor. If no mapper has been
   * provided in the original call then the svt_mem_system_backdoor just uses the mapper
   * associated with the destination backdoor.
   *
   * If a mapper has been provided, however, then the svt_mem_system_backdoor must
   * provide a mapper which incorporates the mapper associated with the destination
   * backdoor as well as the mapper provided in the original call. This is done by
   * creating a svt_mem_address_mapper_stack containing the provided mapper (the front)
   * and the destination backdoor mapper (the back). 
   *
   * The 'modes' field is a loophole for conveying basic well defined instructions
   * to the backdoor implementations.
   *
   * @param filename Name of the file to load. The file extension determines
   *        which format to expect.
   * @param mapper Used to convert between address domains.
   * @param modes Optional load modes, represented by individual constants. Supported values:
   *   - SVT_MEM_LOAD_PROTECT - Marks the addresses initialized by the file as write protected
   *   .
   */
  extern virtual function void load_base(string filename, svt_mem_address_mapper mapper = null, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Internal method for saving memory contents within the indicated 'addr_lo' to
   * 'addr_hi' address range into the specified 'file' using the format identified
   * by 'filetype', where the only supported values are "MIF" and "MEMH". This is
   * the file dump method which classes extended from svt_mem_backdoor_base must
   * implement.
   *
   * This method uses 'addr_lo' and 'addr_hi' as a source domain addresses to
   * identify the applicable backdoor instances. The dump is then redirected to
   * these backdoor instances, after converting the addresses to the appropriate
   * destination domain addresses.
   *
   * The 'mapper' can be used to convert between the source address domain used in
   * the file and the destination address domain used by the backdoor. If the 'mapper'
   * is not provided it implies the source and destination address domains are the
   * same.
   *
   * As part of the process of forwarding this request the svt_mem_system_backdoor
   * must provide the appropriate mapper to the destination backdoor. If no mapper
   * has been provided in the original call then the svt_mem_system_backdoor just
   * uses the mapper associated with the destination backdoor.
   *
   * If a mapper has been provided, however, then the svt_mem_system_backdoor must
   * provide a mapper which incorporates the mapper associated with the destination
   * backdoor as well as the mapper provided in the original call. This can be done
   * by creating a svt_mem_address_mapper_stack containing the provided mapper
   * (the front) and the destination backdoor mapper (the back). 
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
   * This method works in terms of source domain addresses, converting them to destination
   * domain addresses and redistributing the request to the appropriate backdoor instances.
   *
   * The following comparison modes are available:
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
   * @param mapper Used to convert between address domains.
   *
   * @return The number of miscompares.
   */
  extern virtual function int compare_base(
                    string filename, compare_type_enum compare_type, int max_errors,
                    svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, svt_mem_address_mapper mapper = null); 

  // ---------------------------------------------------------------------------
  /**
   * Utility to figure the downstream mapper to use based on the contained mapper
   * and method provided mapper situation.
   *
   * @param mapper_stack Mapper stack that is used if the method provided mapper
   * is non-null.
   * @param front_mapper Method provided mapper, placed at the front of the mapper
   * stack if non-null.
   * @param back_mapper. Placed at the back of the mapper stack if method provided
   * mapper is non-null.
   *
   * @return The mapper which should be used for downstream operations.
   */
  extern virtual function svt_mem_address_mapper get_downstream_mapper(
                    ref svt_mem_address_mapper_stack mapper_stack,
                    input svt_mem_address_mapper front_mapper, input svt_mem_address_mapper back_mapper);

  // ---------------------------------------------------------------------------
  /**
   * Used to get the number of contained backdoor/mapper pairs.
   *
   * @return Number of contained backdoor/mapper pairs.
   */
  extern virtual function int get_contained_backdoor_count();

  // ---------------------------------------------------------------------------
  /**
   * Used to get the name for a contained backdoor.
   *
   * @param ix Index into the backdoors queue.
   *
   * @return Name assigned to the backdoor.
   */
  extern virtual function string get_contained_backdoor_name(int ix);

  // ---------------------------------------------------------------------------
  /**
   * Used to get the name for a contained mapper.
   *
   * @param ix Index into the mappers queue.
   *
   * @return Name assigned to the mapper.
   */
  extern virtual function string get_contained_mapper_name(int ix);

  // ---------------------------------------------------------------------------
  /**
   * Used to get a contained backdoor.
   *
   * @param ix Index into the backdoors queue.
   *
   * @return The backdoor at the indicated index.
   */
  extern virtual function svt_mem_backdoor_base get_contained_backdoor(int ix);

  // ---------------------------------------------------------------------------
  /**
   * Used to get a contained mapper.
   *
   * @param ix Index into the mappers queue.
   *
   * @return The mapper at the indicated index.
   */
  extern virtual function svt_mem_address_mapper get_contained_mapper(int ix);

  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'backdoor' is included in this system backdoor.
   *
   * @param backdoor The backdoor to be checked.
   *
   * @return Indicates if the backdoor is contained in this system backdoor (1) or not (0).
   */
  extern virtual function bit contains_backdoor(svt_mem_backdoor_base backdoor);
  
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
P0fG+vtWnodF1sj1XmvUdCsJxs+BdMvBtg887jwRSJAl/tVxvdzOdXerKYUAkHeH
aKY5VPZdRLN1Y4RBs3ND1EkKY6+XTg+019+EBO7W66MjlrLIrRWOmfgoBfEVr3lm
MRpF/ntmWjY1XZFkfCi80UovPbUnfH4pMqQeQtjjhX0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 38798     )
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
yiIY15odElvXro80v2FJMrCWJ+HKc7CqJ5ECWv/ylkkwzovi731aeenRtGMKjT43
C8kzHHhzBcd/Es+08ZRCvNIeJx03aBTJxpUT0Tx3nHh+3J68sPd/azEFUuEjA6ZJ
kuMaPoLqQnQ94LymYEQZTCEVvOwhzA9icNYCOgEtRe/+5FJ+qCgnqP/IUop0G9NU
M78WOJFdyNSwxLF0zDdZoJQUnfnuS2Z9hpKmCFAQmrcvr8Q/iVq4LMIS6RqMxsDS
EIxoeR4QsrJlm6IUhxfW345Q4bBqE8GprAnrL94r0Me2LJGb5Llla3VpS3cbIFe4
AsFcopiOPxvy5V5jLWcWahMvX5gv8U2RbW9VPVlVoZ9kQnNu4w3r0BWRXZuQ5JhC
IqO/7dfWhWPps0JJgdLrLCzgHDmDN2olhRutfSTj/U12mUyCNxMs63WVUi+NTb2M
rcqKTYZ/ryTo+Emn6aQD4UHX8vP/hVooei1uKKG3pz9tH87VBPVW2ZV5Wx1yoBGi
zai32BKDfK9qlKYhhdmRq640LQznzdjGa7vwdcYocBkk3bpDWZW5MLsvg8ULPFhT
zLqkuB3OLD7lm43rCWyWjRPO0EKxnjoeVPjl9dTGXKi+Jlj0o/XHHitPGLVaOcTR
ZN7tLxNWF/O19snhXhMATQ==
`pragma protect end_protected

`endif // GUARD_SVT_MEM_SYSTEM_BACKDOOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pSg/GLwfXXgCl1k8yUiS5ooS4bqa4b2ERBrcT8MKEIEcFZLu36SSMilP7fqUxVaa
/eXQI5ufrj+WwjMdEB0wXrbweHzTzCpUANCNP/+7C6vS+oOwmnuWvzjmhP9kfpQG
TFr+enK1rih31Hmxu/pODVe3dU+UEH3V/Y3TdrV4cJY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 38881     )
WAlXWyiEFUqRIJQTpeOZN+bsjnuG2yAyPM9D61CY4Myw4LZd9KZxXXKrjtgnPtZC
MnNXR7xzZIt+tkmN2ff/kZUc4GWdAjeCF6dfBZgBUoBDPMQHi6ak6JTMoXUCjPTz
`pragma protect end_protected
