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
`protected
O\6dV@dP2_F_0ICNM9ZPGB1B@aIN7AVTA7aec2)HT@@@^dT[9/16&(N<:X^.a?87
)<0?^aJZ.DfWS17?dU5B4Zc4W.3#[@)6<LRX8L.AJ162,0<Q+3]YQQL;]0YU<?40
-^HP&DGYY9?4\cYG6gZTX]d?/1ED4GdCR@^N@Tc1S?8++I_77T<Df3L,/DPA78SG
5=JXI/3_\?ZN#9HLO8U^3]#FFXEgQU:_:JQO]ZFETGC1@?X53ZdH-5,Ka&EN=ON^
+MK771=R82?OC-)@OPS9F?B=J.>#W[TIKE34If6KeX\Z=)V]^?D=J;7F<B>N3SGa
A=+g>Z,V>\K9(X-<eXXCb_W7V\3ED[7PVK_YEAGa#(P?Hdf;P&H>D@O5^JRD:2E^
G0-a4+dX/ZWPGaBR);cUVYQ&V2V+BI-@;NNOSN+=MJ1(I2@N5=J8ac[@5Kc[=>8;
)BgYJO@A+)>QH>FK#(N:JcSGL4XZ1bTa/]D2P+(3[#dA@;^(,F[9C=YXN7[1+JE9
IJS\FEdLg&532T;/ge4_#ZDTdP7..6b&9T,3(JU33BbOQV.?U)=Y[D)D]3_T/J]K
@<YRKH0ELd>/&]--@&S)J5/b<JB-0+Y@UD=)&M9N=H.#7e_\XCYMX<g)8C/e#C-b
JXPJe:^T513J7EVg[)0-1(eW]?P)<P&OFUcPDVR?_?.@+SA;AD:5I>_#=CB-DML<
)^eZ_4,]7^4)(.26#+G,GR4^YVQPa8698;-NCMDRA^7fGTQI?BFWKXFPYW5U[]M9
T8Q>=MZ/M#Caa<=Y#8/0FgH=74g/B-O7;6@D<Ma&a_130KYYOd6(\d4;-[?-@=XS
2,Wf#W/KB^B7.ZX;](P#d&&R-9ObW?4b,OAG^F1f-NR&UI]CB7^RC20Q]g[N:^Qf
\9fMfT_VUB)I71X?R)EP21<(R7S?gVbf4]2H#8LF_4VQ5?gX3-/H./:U<=<Bc:=U
3GB?Z#UC#=b3T;2Ga_g61\aPA(CFD(_::JU/Q-f9c(,b25(g(\6Z,@M.XJ/U#-d\
79\^0F8_.SSF7CBE:GQ102/Of47#2)5^FN6GDS\dKE)#BLJH^<;54(MHULe-6+2H
980f.&/T<)SG0=(LJ_;=>cP@2:S0Ha0#>\C?>,INbWODQ0edAEA;d1Q&g41)gXg_
MZB?,d7^6,Je(VJD^G-5,]Nf_eU=UfQ2a#CJ9G<\FcfJG=TZ)8,Z6[/Z^b6K.#TN
GD]5Kc01c7:+bcO08eGQ_H2EP>]]L8.Qbe9C,.B8BaaT[806/^cUB]d5]PKbOH@W
=D79,+5-7-F92cPJFE3V:\d(g;=e[PUc1I&^N?SQb4QdH^_AI(;Y-=Y^=C>3>425
<Q2fZ6LU:BMf14Q;CYNU\]/c2-+8LI+9IU_@Eb-SfX./#I_OKC+\cfN-Gcb,#aT[
Ia>4\7D3Ob6I78)(F1?N]P]^X0=P_MeWc(R?/0;4EW_8Za6RH;NA?^SS4a_Ya_]:
AX]Zc(N3KbcO;T;P@]L7#Kf.A??0,M[1,8.XbIR)F)JL:#6;P]NST24G_&7,9E2M
T61Q4B;G:XGTP0AKC&;W;f,=LD@Oc81=S4V0X<>](DTeS\J&F>?;=\f#,Q;M<[K;
a\.2+5KW-+R[gZ19OZT^C6U9SY[,0TRV=1:=G1.CgCY))[:/^4LZ2UefHK;>[XUR
0_F\6(4eWO;#1<OY\Ga96&3a(8K7HET,aG715+Q:-^-;:F/58#/D5).JCe8<N=S7
-7>1BUQ=/62>>/E_.Sb(\bcY_5&Xe:EPHf.@]G0?B[dbLd,?D+ZR05JAH[47:-S^
Y(HYd0>O#F,D0>YB#/21/L9?R)Q1/=-#R(<BHPJMYN@=EcdG2L-+LQGaAI>YEY+V
/@GPZ+2C&GZ5O+_-TN0TG3H#&X7SfC[>_H<V0YF@N.W>e+<8cD+]b-0RV6OSAASS
/F=OdQeTdGWg-c>SAQU^Y2QD]+<O+[/N<e\?N21ac\9c(,+#\@2[9)CW+?O=[0a9
@GN(R?J/F2-e_0J9+c=GXMSC/>0K?F.bK2]bd6@JCRaV15<G[DF]P8B68]H?L3Tc
L&&U>UGYD5<3=&.X,1f?[I]SN)_:6])2(U,WXPQeBMK-EITbeCE,?ZI1\UbZ[41J
0R5LOIV&,Ve8.0V\7bGRTCE:E?H?DT2KcCM:AbE4c11bag,M-Oa<511+&36Wd[]Q
b(?5]]<5]QASE@.531L)7bC1^,If)24]9R/9#8EU==8N&J\gc<MG>e:,e3aR??&A
AQgSKZ.>QWe.=QX9a&Y0A:3QK4(=1.PZ3X+\755;[XX5JZ9Vc,S/E2-T^BN=QU=+
3RYN8f.0f2\R4B)5^CPYII)@-DK[/<WG6PULBD]UdUa+QJ4?f;-[UCgf<+:H).A>
DN32=_+?,B^]ac@_SaGR9X3TG#_XJH&H=C\37V[_E,WG-,VaL353-E[fF?4^<TL2
NLLU<7D9YUH55Ib3RYUcDPGRDJ0,<c[Jbf8A;5^4gSE&HPEV@f[6#Z0UJO4KQ&WJ
cCaea#.bP^0L-4\9V7JX.XX^PD\^Nf/\&-F+CBP>GE3@RQF[LWP2?D66O1]9--PQ
[Z2X@JdIb+1Y9gS(06YI1VQ#]4dBY4R::5(_&GE,DJ5F99-dO?#e#2RQ:fZX.<(B
eVVb=/^M^g4AX=:]@E(QLfBBb7<5)6<bg(8>0D171g2^PV(/b4H-U))dcYF._R8W
K3P.FR=6IM+D:g^,)=N41,X&X0c2L7G1I(^DHg@UGUD^X^74@SYg3I3cef-F9P5&
TXW=(]/:[FC:9FEX/.RQ=6-RZ0J.0J._D@Y\aa7^#IAR8Z\Mf&&X,TGKL8TZG>K:
5Wb+(I6A]Ld2PC\))\d(Y\UYELB&#DA,BLBcO;c]:5X2;H-)I<\JX9MdQ8QK8N+/
5E3S?&8N]#UaZJ/Bc)WP[,..cNARbNPR&@L&H3R.]CW;4J(]C^NWec=\bDMddVaC
>8JX7]C5S@M5P=8MS&=9MU@X]N^b>&PbYaK<UZgU9FKD1]0M;.6)@MV[JI-@XS3d
fSfd#+2BURAUD0\#d)NaN&SIIY8^\bIdBL[fe4>e1a0Q<^2>/5EW7.:_bHMeQdf>
)<G<?Ab;]SOf[J:KSVXG2>C9&\SaYJYJ@/O6gJ0E8N6QgKe1>HG[:1X:(K4W\P+B
/b:E=d#UJGVFb(66+@<-R.X2/WC1@=@0fdH]\<T3[FS:Nfd:JCQ^+?5+^=UR>b.B
<T<Pd8.J^J).<N3J6]?,X@@Qc155\c7TT&_OcKK52C0fJTCNf+[a^LF1Ec?EJE>b
aAF)LU)6]X-6f5IIF8dUIaFE9P.>a_QY#(Z,F\V,W(J[.LT/<fV]]?4#.0\W61cb
IYE6C9I_//(dTV6;d\C/K\.Z2)NH+X\,cSMVQ(235HMYa6;H<#;[f5O^-<MXL(=A
;<4/</L9&cZ+)4WO<G&M[@W(]DFDY14>B8D,;^NO[MbGJ(4/c3/C;WY#SS\/O9,:
#ZRTg1PZ9QadcU8+&<V=.ZRc@1,QD+#;.UGT?)4;W=bL5\f?87(?R1A8MC2]L1Y;
4E]/_L6]&PUF97-U&E9-ffDEMUR1>X0C9\DG7H=Lc(.>[PD3#)a,[H/da#(Ng8RO
XdR)S+GSP_KBY5>(TA7d6?d\A<<50_L[[W0CVMg^&DbU5BBNWIP9;E[_9aHWCeZ;
d,A7\CS@^//D75LCEc9A^-OBSGCZ,c&#7:WM5:d,#FdX<N-7,72F3>PF73U+383K
#^>==K?R[TT2433QbCBB,5P=XF:&dJ<.[N.cZ:0&.e\2)f)\S@8GJ=<H7VW_AZ@Y
E=dD<VJKA(\KY#.1SZE?4,CXdCXT0[G@[4?]1f_\Z9_EOHE0A_KE0,36-Xb8_eJH
cPERGD;/1=IFY9ETU.>eC+9OU174UX)6^b/I[5MMEYA@Y2dZHF,dIKK9G)#Md9#[
S3TS+/@cV).SU\VS^O=67O+\=d#FeW9E1^gg(-O-8WAA6,H[5NAJ\XBDN<5cISHB
P)e\U-^Lf(ZU4_W]f.KZ/-6IC2Y7PdWV?f^^JCPd=UK].VD5QPg444DV,;(0-E\7
?=d;If?2O6_)4Q2>](JP3(;4Rf3-,(IY8GI#ED#fC3:?=?^cFL<-V]<#62&;TG[R
<N#?7SM[/JXT.K7Za72Z3SJ(2g^7_61F@?C.HF^M[C/.#E(4g#@L7T=^dX]]MaeG
9b1\?V[,8RBJD[S][(5:;#098=K._YK4>f/H#WSF3I57HY-7@-?c:XVQa),f9O>>
[IfRC=)2.Ta,@B8#&/a5H12)\F]OLUW?L7gM:;<@aZ/RO3^@dFKE=B]GeL,I_499
5?D\;<eK89d=;]YMLZH+e>)>Q9TX+,D?(G8^/F@[0R=^+QF0AF4>BG,,L10OO\]J
,0eA&Ia/dgB-M4&55f@TVJ6^&g[BK2g(J.R=S9EZ/AP4EaOX[g:eZUVVd]9-APVD
8Gf,LM,g_(]cg?g1CKLTVWdV&50ANJTLLHf9bbSb&X,G.OFA\TF>9A9>LK)ZWVc=
@D4?L0;0[4XS7HG/.6#VC35B7-LRF>T.e^=26b=5^ABaZCD)3+e1HH][_L06B@&V
a-\=aIKR:X]--]YVOHLe0BL7O,J<#D.NX^H_HcBFIeLHW^L(AWL99(79Wf<BF]-6
#c;8X&BK3];E1/4P?U?ReZbT:^bS:eg]dI_4<B>Ee2HF6]UC2d?^cEH=C1C-43T9
0,E/8T]1&+,TPcIFW-&G]D<&3W1.D([RN;1@Z+1>AQ466Ye0-+.c9&PPI0O)<Hd4
O-V[K,d=DP>d>f\7V>Xf(de(D@b^=38.L=K9G3C7bBEZg[I+R>RZ4LYF7QB?J;PD
=e/b]&&(9c3]@Ec+)HBEMAG576R?92QH+gFXRU:a:&,0/B&\)&;T^\_Y@&9]O0K8
VY1#?bN([dc#+=0J;P;OM/+=>BTA,8I^b3_g12ed)7U2d,)JKJ\W9[O[;4RTYR0I
DX3:JINVb9D=5)B:0ARQEL=AgP>E9a[#PLEE+<F7+6PFJcf((IBU\e(&a>fB-b,U
&7W>]?E).4+?_.2^/_EY^B;NU,Wa(G(T5eDf3E@aGbGR1g;H3;a,TPVRL9YBZM#L
WCT9;KP)V;;cM=ZO?F7:WILb.LTg_>B+&d<54[Z[=+85O3<.\J0O43C<2G_F6H:,
)4)B),Z4L??:V^e1ae2S=;aBa4S+<8_9\F#Y(1S#+@f8.BWO6dH\@=JfS1f^L,bd
5gdE,]eS-3-CY:OK.QH_B0YD^,V;QJGVb[=[=_LCHJESM64ZWg_,d91/0W\=R^^9
F>B6SZ/bO1DT4[^<F[/7D\P(@cH>AbYL0V0NDeGLHR.R_g5BQ_CD83#2\K(Y.9?0
-_&W=,M&AfPVL+G^8EX8UDf3_<aIP_#2^0dVIF-WYB9W](&(M58+@7W<P_HeES\O
EEXbOdW>#dbAOYZ58G4Q6c.=\NA\P&UgRP;aBZDP9K^]^&GSWgMK/WS#CC8M@RV]
D5K@>[T:]e;4OGMI->C(H/]HPKQ>L;A77RT8PY)>Y7>30AJaVD(]S&WV@;QMSI9<
7fBK#3@FG<B9LL,.8B.9b7[0-CPZ6,V&697J<\S6UE4,]<8B@(RND05,/LS>7FB)
&f;KZZMcKSJ:Q/[+XEE-1\K:SR@UIF]4QR8DXU6J^[^X/ONR6F(Q=G1U0c+C^947
WVIgd1a0ZGFO#HCUU,LHBXB6YL+c)QN:Nc0_,b1K;ZQ<ZfN9._KNT10Q5\^QCI@Z
MQ;F)DPA<JNQ8>K-?J?]J_)DTJ.V=SW(/VAV)OMd48H4&]a&LH9DT_E5HP[Pg-\Y
<<ZF?b[:aWA>c/3VAd56SS,HV/EeG)YQ)],J8g?UNSF?10fPX0&5#1GJ<MQTS;V=
BBgK<QG,cN>G=[T-)3BT;0YX:N)5MF?F4GW^eI@IG4):)aD.)bK@OB.^=)>0G-J0
</[fe#L33\6+bM[G.C0?&&7-B=S#b?E.#+^;\;7-3SUb6V#YY9K?0X[M^FSPQ(7Z
3&.XR7#P?Q541T^7B8R@IB=BH9L=4Z><.B]C(5]bdg_aZQgB2YN3,;+cK34;A4(<
GB/d^+YJ?4-c-H;YcJFKJEa=5F(E=>Z,K)=R..F=<SWL-O4667]S@D#bR2>/(&^-
,6:aM0>,(/Z\SaQdM^WN:X44TI9S=.<+;7ASBM__^W(#F9F.ZVL.S.P8M,VSOV/[
CeBR0<.1b9V-HN6+f_@Ja>Sf&ZE1@0S,3SCG[9,c;OQ69GB/b,3JY61C[Z]#AL+/
e_R^5SH+9RAG)K)U^\P./-AgdXQ^G?Ea.VYU[VG^EF^<CaIA0MQ]1eQg6F@:g-B_
I8gY5Dc=F1#^U;E>_)?c)[=]N<YcRgTO@24SO;QKP&8>B?Bg3#JQ0;H?LZNgEZP0
T2<)TR,2QRHBd8-#=8__/?E2/5UJ6N0=Vc97-;?=acY7[(4&12D<2\?JJ/f0\==e
]E1BG.LdQED<ITQ5@]RYO\BQW>IOde\cW_U,-fJVF2YTbQ,&_g=5JZ<fa(W0N8?=
_=/?]NQc?OdRL7.VGP;1P;3Ze#/8L?V?M05:V#B27_+#7RQ7<&/d72ZW]/+eNPHa
=.(3;2>4]#Y[M4T6WefMV9bO3eT-AI>4Hbb@>5J7TTf&\>>81ZM)BWfg&/bG&]4^
^N+]f00JY1ET3P+WebFb+\N44=2WN4YLX\7@O#@AREU^9V]&08WIXA<VV2BU214I
X-X_bK_<;>ZTX+#ONJ_;V1IK?RP8OD2T)dJP;SXBTQe8B.FdBSN)0?2WSaW\fQ1N
31.DXY/U?dc76d]5Cb=c04+);O^=c;#DM>d#Sg/OAPA3PXGD5fI],gg>ZdF;_OJ6
I8MgfcF>VVFVgaJS.\RXATePW/+/)<F3<BUFO@N7[(^A36_I_0&XDB0VM4Eb>S^U
8a\I>d3,cXfD,N.M#GVdBdZZOAa.cYL.+OZCN50M8?06T5,NQ/3VQ4>?:GQ<S&_J
[(LG<]K#?X+(+9O4,?F;3D85g_DJNNMZ@;5Kb:723-6@gH4WbfGC^\fZ(L:UG.T7
.L;:7,gU5ePOH.JF:?eTIK\##:Y_g5I[M54]TNP39K-;RE3?E=OdHG\]#2FL+OU>
^Y#Z?;9132?aNWJA/#MF>a[)IAS=JB5&/92c^(D]/daJR_U.RO[4+NR]dX,AAVBV
P#eYZZA1=Ld\/)3B&cJ,fW\+WEO]de8)TYdE7H\Ce;PH=I@M1)\C5MN-V(<7<6[N
3QM;DUU;@97F:a>+E3)WbbdC&:&WR2cG(>4b@QEM<Pc/UcB?Le31<+8FaTM/;aJV
Y/7bVZ31^e-8-Q=63J1NVT6<(NMZX@.E;^-bVVef&5?8^W(\4_aTHLPId/YW5=L0
GSIR<RdGDAGW3+fcMD+MJ2e7M?aS+dLX7QH>[8525K=7SP@5Pg)#NEQN^-IJ/R,P
+T_M-&TL[G#ZQ^&VWcRRHPGTU^43e+MFE=TKNAPS5DE@3\-MZF#b0UbEG^;,R=HQ
&;1FN[#_P/,AZ3[fMTRggf?:UKV/@.N,E7cNY:0MdQ,HKS?P;a6K3C/N#9BI+gQ:
[=[K@c497P_dLGC^K?e]R]_11RGY[IGKVfLN^NgRJUQXWR6J.=-Gf;fb^_GdA#eO
Kc;JgMI@01D+cK/KZTZ#UY16GF<961SQ5Nb6_Y>51?1>86L&RVDCHG#bZ[cW@ZH8
?7&5/^J=8R:(QDS@5(a/Z^DF9C]4.-_G;G5K9_A;]BMOOFXQY_=^(VR-\.GPeY#.
APD2J@?aOTc7IB_T(/TJ=(dVJDUb<:ZCOPgH9LB+HVGT&7fO/Z.(1O4Jbe]VXf_c
8SceG2=IS3ST)D>G74VVag;.C)a\d&SLT#X-;>KOb;0#^G_+Q/=8.DU:5HO=EYPS
7O8,E),((2[d2df[I;_,W^a,05;IY=Ke>9e>[DWE.&4dP:2>,(5eJB&HS_39+W4f
N#C^7^;V:&Kcg;B8Q#FQ4]#>\MFaJ.KZB?UL45eXfXc.?M)>)Q->^G^:P#<I=Ve)
GEdHGANJ9P):)2I7V0I[]bV7f:2@?=5^1;TC<a[P)Za4\]H4eM?U@g=D495_9C0M
]:bWebB__@@cVQWNcBZ.d9<WWZN15\27Oaf7PPA25IV2GHc\(XI[>aM(M1J_MBI=
VTW>5?MEe6)6;NTcKZ),8GgeEU7_H]1\(f)TFb],B2-[JXa_Gg;^]SNC][8XFbcK
e4L/(\f7V[;5[,-SgK:)c,gDR6J&.N-e:)S:E=SdJS^<&9]WdbePc_e\L=^?L?[7
#+8J1OS,W9RXW?A#T:Rc)OEe/c3V&,I4VG_g_])Ac#+=LK84A^)QfL\QTfUR3][,
58KYX73(7(fLgGF1#XI&D&NbGMY;KB9cNCVa+^[&Q_:P-WbXM?g?GU(e&b9254E.
9V9\QXSX/dUM6;-bN_BGdYSUgL3(I#JQ]\G4I\WeJU3e]I.gc#W#7N--/.e=c?O&
ce4XI63c8[.KPM>@)-3+f4I_-R@=3#7H2MXVXRW6gK1N,T63E5GJf0_9#ga5OM62
[3:fg8+8:C#a-],AC5c/5Z6f0S.CPf3_,LC&dPY:PYI#g\;9dQ38H^6?ZOU#7)PT
WLK0M1CQ)4C-[:XZRGU^XU0XZ^H/KMaM]5@I.6UdRG8/O7-=+Zdc;]A+?YeXEZ;8
H7+,MI./,>.J-9SA7TY)ITH69P+PZP,Z@QSR_?a?6_P/D$
`endprotected


`endif // GUARD_SVT_MEM_BACKDOOR_BASE_SV
