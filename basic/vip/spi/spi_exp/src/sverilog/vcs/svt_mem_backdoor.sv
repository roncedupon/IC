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
`protected
Y5L=K,XH&X6G+6W([1PR,8KFE6c8/a\Q@[BTJ8D;e\NPJ:IOUFd&((^3\Rf[#=5>
0g)IZP&5dQ4JJ[F#M0:647LW];.9&gJ6RFL37V(0f0e3\GZ<:F3Ab2g39Mb)#W9-
HPF&MGGDg_-GJ36S/W]6aS6KKdA9N+W&Jb.9NSb]K@V?IcS,;VR=.+;b0YHY9PTM
=3(@BLTdGKP0)/#Mba)Z@E_W_b&)]eRS)GR=IW=>3P-T/,6(1M;Q6\LSJGa?7:_;
\>66QG@dFERIAXJ6.D(fC8L7,-1.]S_W_I#X9ZI#QP7<9@_K2RNg#gN]aC7#KdDY
G]fEHJH]=bUC<]^06:5FZ_=W1H1[.0V=V8.U.5)6ae^\KDQg/(D0QM2AKY-<(T?;
SH]X+^>8_;03A-:;;b/;RWg7.fG([aD1LV-N^(fVRH^&=7>M\,KSgCdId1.?Z&c9
;##Q=Q+N=3,3Q3MA6Y2eF#G&:X_5H#V/1<8^H6K4,)6#b(^bDWWW/fe1Q6NE.KX)
CN?8MX150Mc+g[\7./EH\5.I8FX=K7cgGU-bN4N5VP/53b1d0,862O)-Y\I-KR0@
#S2M_KT/\<ePU#WeNdRa+=TZb=EM3e+IG;72:@cNY@])EgY)b0I/bUIT.@]9LDBX
9aZAO=\JL4_VTSe,XZ&/_,/GL0)c>)[T?HT-6(C6M@Y]ARg,14<N/Ef8,6La=5bZ
_+.:&Gee=2BA76fMLeXYNU#e3OaLCe+e:>d7C#2X(CZHF^I0I+^.3TYGWUWYLKM&
]@ZfTVBH=HM(4?W@5FAO?#;W8Y3=TbgB1@YRaV)XT-5&AH,U.,RL.0I=U0EK]Y]2
06SVKHU:FEI;I^c+FWZ;I)[&\CgK0Va/geQS0eAY6VMLcE[V#9#S]T_F]JF7).b6
?P8NGf@aB4]e;1)E20HL7+gZAdNU&-L5\@8FUZEJ>C^bL6\_1^bTU-Q?a0CY^=T7
5EV1\W;4GQ+g_[NHGdM/WV0@0@7/LXO&JXS4aAb2#G#?d>97&>[BP<_XcIT);VT.
Q7b1P0S5VTD;fB[,bGFWN<;\P=((SZZ)aAAc7e:UXf7@WcLB[gPBD+_/a2BcT,AU
=(_g&R5?\R@#?]AO=P5_P11d_g(a3>Efc9/P/PAc7e[92+a#Fa/a3KF,[@F)F?+=
KB^8U6NKN,NGU5I080>#g;TXS)cGfJB(X<Tg=R\LRBAM:P(Ya:JeJ;1d-BW(IfRA
&e@,Y]6S1(g@/[STFQ6^S0&L)M;U#Lg+?9KaaWfc3@M9ODA_OO)OA2d2@59W,J@C
<KBF;&7Y@g?(=J]GII,R24R4d166;J0(UA][WVJBDTCL<3EMI(P:_:/<C<Q6_MP6
=ZgNT;If@1RE3_f,O(744D2&KcfS365bI2OA<@cB>;P]CR5&M,]IL.Y@73,H-D^9
GVf4CHG[Q8326TZ#C(]d6UDd;a1RR)e:?VD:MQH^dLECM7b1=0;^NXYQ[#]J4X6G
;DZ=Ca0J@Z-#dL\_E5]ZY40.dIM)X-Ke60SP#;S@&I2Va_(U25TQ/R&SR@cA0EbH
E1_L(6.M=R&MO5=U)[GHDHZPXGNeDTg#a4/:V1Z^I/@.8f/M^Z(TFR(C>NAO/+)Y
L;0]-G-L;2USJ1_61f;\7CS=PYR/6W#gD#I4d:/2S0@,S(6ef,Z2QG^)b\5#BH9[
#CND29K[6]]#-ZHBI;HW,SRbaIK_>CMR3,Oa]E1g)KFIP7#6bC(5aV^#VN<Y1Jd,
PP0EDZ7R@H8,6&A6^-NfGO-\V71gW\JVSSICE6c7JGGZ]0MgB/b[7N/7fPKV833a
8a#ST[YI.fJ.ZF&.JL\Oe@/)/^Ic2R5cY^WEUIX@VaOYg08S((<V/Q-7M[4M9K=0
G^S4fH3E0A_:O5=L,dY/FYTV._=?2R(>UT[be6I3)E7fAS9G,M(053f]8:e(DTGe
g#aGG>4X^ELM;1.V7-NM<E4b]R6ce@U9,SSPT(0)Se;H:FPEF<g1SX5Fc&6X>XL?
#_EZQ\c;5UdTG:L@d2c:M.D@Kc[P/fgW2ddYe)/@^<XWLb),];aYJLB+B@\S01,?
<+>-38OgG)23:AeeWOePU,2H-SY83J#_=RQP9J]D7U(2X8H\017UIeC#B-DF58N#
<<a9:=f9(g;cg@GK5DK(?Z9O79P,@QAaJd8K/P2R=Q]:&1cWC45QSQJU1Q;9AZS.
Wc92_RU9\5g8?9I=fbTG8U/BIc#]NNEZ=<cC0;=>U&^^#gX\Hd9aL_D.-#(^U[\d
5b+Q_(8N/F&#O)@9dN(UL;5?G59RORaHa=GB_H7Lg+RE\]RIX6a2OS]4<-A);EYL
cTd7Y#ac797>IO&f\2,4cIc<Q\03-&WB>B1I\.XNH>6(ZO+CC?FPeFL<UCZX_fDb
PR4cgC=Qge5RR?47K)eG0CZBAGc)L=@V0UA_aUJ2_^/5O^ae&)8?I96OEJ()(TX(
ca]b\L:7/Y^Ua_,9EP3NUe(Q<Q+LfbSYEL=)2Z4.>&bK+HWBRY6d_0>NQ\DP9CWN
Z_e?@5ZC(E\#89=BP)C:[/G4Rc&_INaB1)B@P&=[-=+,RbPVcDSd0+C03;W;S?@[
gU:?>EPB#8M#g7@\;RL39QWZ,+L@dbZb4^5S2)f7=1,g7f5J1cOR__6H^WOE5ZWV
gFU^)L0QAP/4Y?UeOEG@?a>LG>5827^[LI+L&.C+]72f@fN\99)2d-<X_4EZ--\[
C+81McF_RII=YM\4cMKc\I]=7/V-Q&BK2Td;BJRJ+DDe8N+BPZ^V<4bD_2I[PM>I
AIAQ/)GEQ(P9gcb=]9-V:KKXbJ#[DK1aBcg?,b21bR5V1(RK_V:H-V@L<.XZ()&8
e[7_5X/\7)BJ0O?f;<<124Kd4LHcJ65bCQ_?C[b,FRN#A4fgXWK@04f=(:Mc_&L7
_/<KXAL343aE+\AgO.XIVYb+KT:;3D>9gc2\eD7TLDLV\+]L_b=&Kc;NB;91fR9f
V&YVI\][A2gK:CMcR)EbL7?QYTCDA&Va89/803;d)^aU-=fMW;GYI+3cOS702XB8
>5NY#RJ=Z2YDgGNK4&c1IA,eEP_#+BI0G#U^15##^]DgGT@;>8.7)?TK)8&QI;QL
NK+652>e=1SRN2,PfTCJRWaFI].f3=)U3C-V0<Z]VKg)3@9P+B(&X]T[TVRJQ@B\
_BS2ZQND(U),L)]3WS\2RA[RRM1=3e_105cSb+Kg<==):)Q>\?R5fK3E<.b<<DY@
JK[Z),(:cNOT:SGecf3c>L:7Xdde15\DN9N;04:Q&F>3cD)\NEK9?[YCQT.UMW-X
/0?QTMKPH]=<U]4ZR5[B4?UE0[JbWXK9caBd0GR0+GR]gMcE#B9X3OIXd6^VUgIS
Y[@N@9cR:BfB>W[2A=fK1U)9H)D8SJ._EB0^g7dKVf(ZYNYeLK07[2[[a-)(/&e1
>Y46feT,O8YH5eQ//DW_GKQ;<])<M9/-?0>0H)U=ARdbf5?<=(]Z7Pg9-WZK&NP[
F\W]+Z)^031XH6/-32#f8(^A8[.S.2Z-UAAIB.Kb?Ua[.3J4g4Y3MK,P]?JbLdK+
,K9;27XWPV81eSRK1g->D(>?51FZMg+X64D0I..KE@L\^I6^G1Z,(<J+V)2b#3dS
A.;UMO[WH\?HX][2ML+8HM9.fdS:PSQ+:,RER<eG??IQF5JAT_GW/b,+M3\UNbUR
B>##H-/Na(+2^)7@JIR\4C.@-^9OH6.c<.A>R<#A/Td_e-,24F0#7E149N<\1P\#
E+#T5+8[=;<g,=Db>\Y1L4:0YX@#DdMIa<(-VR+0:63XA.@PNcD&A&/M?N&7CD5B
C;00@7[H&7+]OR86VDZ2M,7cG<RE/[1Fc\RDf0?T9gW2J4[e<_]e&RNEf=Q-5I[#
;[]K[6N>=<2g6=?P?U+AgeLaYH(S/3[]CDPeA7.M-J5Q@L]-6OS^EGGKBPMQa[+a
8GL?WcPfaX\AC[@U@3a2:ITXKda8,aNO);I7LTX/4#7;N5<Z5]3@/>R9<FL?OZ/^
[aSE).&CWWSML)/ZQb+7DR^0e=:<^\I4R>DINa-&C=UR>\#4T>0V=2>#Q(WI8/Dc
<(@(MHZ1R7Y\?XX3H4?&d8:\]UcF1IX^)P_Y:caF<2DD^ZTDVLE&c.c\@=C(cF?B
eQ@]8_\#+#aU7P\W640&R3b@91.@Ccc](T?>^b)P[DWG4.5XS:<gHP(cY=M+X7,8
AZ@G_.<X>O#Ee?3;0[#JG:W760_b=g8O?Xc1O.[PEE<\[X50WZ:ca?(JcYP;G,c+
I\X,;,E7;c:7L0+3GJK8P&R4/IcbO@GWOc]5(EEFP3.0\0SF#f:V8X5C@aY:U8bG
V;3[9VVFV)=]TIN491?&F/WY2C4O.g/+DJ./^PQ5XG6ES1/[g96/Gf0NUe]aL-G^
=F-5@LBF)_:=5O)0EQZ7W2TW_IfT2?ZFRHGeHd+PVG]bKfd,=:C4T3L6Z[HZF9NA
JA8\JB=3-0&JQPW96QJ]c#/9>_=Y1(e[SDX8EW.WBdLf4X4C_9MG[Md,9^RbKO;Z
b8KJGcW.AK:(S7<a-^+P9SfV>WXPRgMX@)YLOg;A3,I:VN&)eXL6+U7M&VJV+W\O
cA=SfM.O62X=5D)GCdR,##f1)I1TGLL<G2FTd1VBO5Q(UV(?DSM3]4Z[I9G7L&/A
eJSbZNb<V^Z:=#V@?GA2Ef<G6]S;8U5QJA<7fdWAU2_H:DgfB-X7O@(5CQ:BHHfE
>WVJ>C)c8\G>fKfS??PE)+IPUW14SS^XP^/bcWQgC2FN2HBZ8_b&eONXO1=YdB>U
:>T=6+XGDQD(0Q,;5D9O^VA3?&UdBd7N0<Q.^XP(cRKI0>9,=ceVdTXWa_1MY^>;
VO>DaMX.E#-(VQ1)e7DDA<MD>P)\POeVR&X3M;cZeO(7GQ0d],QN<93BNTEeCa8V
?E-FK&QKgOERBK<#N&EMX^4@)>E(<UgW]JaAK2K-4]<T09.[TC(8>Ab3(f?E&0eb
cN9,^VF,REX:=U]^Wg)=f_RMC5YgHUIJ#4g8a^N0ge3aBa2GP[U^c&KFb^(RCNBd
3.J.2_)M63VFQgdND>4YO9g,7Gg6TA.^9-,9_WJDF@1BT&Sag:CDOLB)EMN7AD[A
#].NLJQMQ6&1Y^)7,+KQ/UGeU7J9Ra+DKPG\A9@=XU+L<B1/Y.L\,]<2^SagWK3>
J=15cTfXE7ETRdfE<M-KI_<C.?U#M=e?.&KM3c]_LHTQD>WWGVA8F_3fDNL08RR^
S67+1L2_JQbAIcNef9;L[WE9\J](-A]f?V)XDE^8O2W+=&@e8[U-CQ/\d2f6\C#\
&M1E6AY/cG9:ZU_.\YE8NERE\);DDA?X(UFSB5I-=Dc>&4GAVT^RR;,eJ\:Q_d1)
DX/ISc1FJLO=a.0I7V\Q/]IQbb+=a\I^Na3Ub1cbF[<CfBUN8gdHd)eFB-7)G8[[
7HAF/W0HE\#ZdCZ2,dL](&Cf0G_5CZbXIM#Ge,X>;T?<8X9MEC)3AH1,/9P,;-Kb
PJ,WPFA:.H&_e#>JK[JN-@+@eFZFb</?Y?Z[WC/II?7W;0@PNHM87@OMM>WUJ\TU
Y;&5#T:IXY10#.2K@d;,;@IO^.J=WR<MZLS_d9+e<4Ra,&ZcR7ffOCIWI\(/O2-#
(gE2I8GS];Z,F<d1eU^;;&YSWZR>P7FF?FC9-/XfKcV-C\;.aL91LA>>YT,S^344
;P2;4]7RJ6VS.X[&b+f22_8V,MHa)W(HFg(,M?KJPf5O?[M7J>0a7/J[.S\&.+:f
b=,IFA4HALT.XG54e57d@/+2/Vea+\f.I2e2#dP3?L@DT<GD^OO?KR7\7C-9^HZf
>76;5fe4B@MAJL/3g6[CO1])NE,Z;8:>Z#498P\112IEbOMMd)g<b_I>9&VGT3.9
Tg#YF&JS>)aK5a#,-&KeSQ,BXYH8^ST&H^UBPP@_ZKS(_XNPFG.BVfE))\0.R+S7
G_[0UB38CR=)+29FQ@EKf6G0#e@7N7PWGLBbQHB#XJR\C^T\)HT3PgQL+/;.3cb?
N]EY?ceEA5_gFE=VVMSZ[&R6fdd5IBXMQAU</B1Y9H-Q(V4McVAH/b4BOAbA-Wb(
3EQ6?Ad6[BCAgYP-d+agM@BQ^faF7N_e[IbK_3ec[K2CcI.OB3_,+,^80JEN39Ag
XZbJ:95&V4>=C?OVNFb2-&CJ]PP\^@-K+-HgPY:T(^S[&56b4de.aCdN3[]fYC;[
(60P9QeOR].EF8W8[_8a<VJRHPa;HH:J+Z)<9^1<);>G&J9BD4I_O=0-]gK4/g&H
IFTQJ<#N0Sb9^,;Q6[?MFG87gUa(P.0#0QG:X3b++M?.eX(dYaNS6M:fd-5eO80K
7X14@<:_EZ?,dFO4BcI]CgZK9F>Hg-,HMFXUI3f<FS]?LD],-fVF;E;H5d3b(SHO
+F,cYBS;F#OQQ>A0NZ+NK-\GRYTIHF71eMfT_7;M56>5_>SdV46(faJ,_ISg3Z50
6RWJdJI4d^g@@V8&CTKNFHZ6(/_-.=N8:.ffP^ZLMX#EBU5Fa?#R/QVgdfU5DWC:
&c=B6M)\<9@(><+AcYXU2RT.500T=0-?[Sg2[R>65]5g4[/?&;5e<8/U47W-UB(@
_5_8P&KTgWKJ&5gCI3ce?+SR4BeC5]19/NM(R/(JN,2MVG0+MH>P<bbNbMR++-a+
+R^@8(RDB&.U\(>,b;PLAeZ3TcOVB\M)1HBGBPbF+(=MPVF[6D8BegGKg/[g:N8B
2XCL#>3M@1a529WOF.&1>:KG)Ng/42G.[@^1Qe7^gE>H)7+c,YMQUc]-6LYV3KgP
cW^J=HK;3^9\:)P083[>0Za/./cE?)OVBWE(HM;3Oc[V\62e6Y^Xe/^]&04a,A:(
DY:;V4E4Hc(?8Y:H-@TR#Ge8T9;&fEYTcfedID0#fYG]__0GR<7RI#(AcfTfdPX)
U3^QO,geOL94MO5fS:9PK5gDBaONT08c?P5O>@V[@-5;8(5-L9Q5Z+Ge+,?U2YNV
0+MA[b,fO5e:/Bbb/^GeE[YHeV3a>D41WK<)TY)Y.P[P>gFX8C6P<\5;Q?43H=DA
A+EE-?Ig2@]0YF3>Vf1c_:5(<>KdL9[>c2?9Q+La0G7@A(4=CL.EV):??gg[eN>S
32A5>T\ZB(Ne,/3(/O>-7N&K-ML(9)[-22LA(7WLd+aTBA#0cYg1Y3]X6.bVDdA5
PeUN9:W,CU:-Y1?8E/Y4:O,8[T8eBP.\;&9\(U_)=JBWH8+VL@VDUN_\MY\:G?0F
F_Y/[(=JLT[A=.[9GKQ#8]WX0>KOTYHa=dR3(\#_53F]U1Y&NLK+B.7/Q1B^,#SO
5P/8KM-J&T)bcDB(AP2-d0eUDGIOVd+.<gH[QcCbZ?g1GPR1A8AB]^Q]^b1_V58P
:7W6^J:NO25]5;G-R=3LEV@ZV+D(<N&K2F:bR>T[QQN>?6,KW(LZKRT3>MRL5E]8
DC.^M78aH:=UHNE/_Vf4P(,U]2MfbBb7dR#ZVDF2XHCD.:&O6VY&RfE<4]5>]9D5
Q-P+^>L3R9BGTSZDdg;fYS;(OPM,./=0HE<DW<IGgIMBU#/K(L\DZUA]<3N=b^LG
TB-0#gSg/ZR]3gd6g?)A0@,O+UMIcSFYd]e-LOe+DA]_6GHPG&CSdBJFg6DLOV\A
>/;:X5E0.KDU>96U8a0?d:Sd7HJ).RUORSc-^3)]@4dOVbb4&NU-[2R]2PgR+24>
2II.g9f13@<(JVI@9>@[-1Z<MO@=dKQN@0[LYfY=QEe=^X6PB(1cY(\0b>aaO:26
\H/b]?Sd?^[MAV(b1R=DX5@AL-G^e-]5Rf,:>M/L9=,\2;gbFbT?+=27cF&RM3BJ
N>X(5+KQ.?B^\c0[D8+8+gTSC071Z(U-9:Q<dGCAO?6\]c(P6?=LAYRFd7bM;&7C
?+Eb7MBDL54=5MAS^Ld]\Q<9=;ZS9ZId>ANRgEN-,a^DdFNVcdOED?0/?gcP&:<2
<_&>WHA=_35BW]aa0?N)0PNF:V@ICde@8ZQ63S<M..4bFbD:8:5KDNb>Ka6BT-U7
L>D)CB#6Tc<[5M>TX++Y(TXa+],e@_NW)R^]=[Q?cH:#AH4;8_JcG]62GU5NK,V]
cJ3MVPX@NLQVLSI(^+BfR3@MX8.@BR@=XdGP\9:bOBRQ),cHNgfY2E#BEL6;[9IU
<-1cNK7P]1&T(DR&IeXdA)X>d]D);5,C:;RC,2/^01Z1-?E(3\QV(gXULMZZLW+)
8-O](.:We4UDE,;IF+@35GAWb>4@Qe2fWTcZB7Ic#K(_,N7K3-DTIa,4a78Y;a_W
UWETF\WHaMcgaYB^Q@O\^V&7PdL&cQ,27-eJIEC->25gZ8IG\gJ,>2g21.6WHb:a
dK&<&,FgIME3H(Ec]W_bcNL]U6K.Y()aZZ0/4K8^2d]2QNdRfU>f)4BV-M8HA^L6
ZMCOG8#NZ&2e0_ORYeY)@OU=,PYG:@24]+J,U.OQ?+Q3-5+DQd5LfEGFSD@W_,&>
([_Gg-77TfLKKGV^A,D-H8-c:Y<b.(C17PF8_LUO_=MW29V_,JTNM2IG88CC(HAB
N?[>SHR8/&TYbA8@1&=I;]DLfMQQ&3:0F?eVOecQ3EK-:-K.-OWI:>^G-=&3<VSU
8[2TgM>,_^XESYdTJgZcI12BgcSPS9?KeFe\=-J[6TM6\Q+HB:SR>P\2J.b\/YKB
eCDCaXDC[fK>.U_O)19T0GfY.5CJ&;+)bAT_Db5TJTGLH^J5:.EGROO=K8&7cA..
8F=ReX1_f3b:6HD#RHX1Pc5@1+JAYV4I:];2XdP;1M0/=]ga64=dA3:bU])LdJ=<
AUg\NM)M:STaMWY3UM5d-aV71\HH?+D(#A@6YS_C8-\.LUPd=S#A1:8D9<dXJ3M#
R12gHYgfDHbgE=ARc5?6TVP75.[P<4eAW)9g>G:^6>7>[:F/M\bUQOg@E?;V;VAN
8#RI?TfKU#&eXfCMR>@0RGXTHf[c#DS^+1.g5,DP(=dXF-AN4J2._F;V9g@@b)91
F++J=\N>MCIR)&ALQT.M_>TB58a-RX(X2PT@7S>5F&VPa?Q2Jb;R-=AZ)(K;E151
fK4))?OUg-cV]TECMQC4/.B]fW/Y<\=HMX>T[=OO>^DbdSF#8\Q?V7GeE3,<e?2)
1H=L)N&\MG+2^68/)\17-f@@L7_4LV0Z5,K#TDPC07+d2F<SU?.O8B^]NNV5JMRc
P&ME=(PP<f>.A:E-=[N52QT(TI3C_=52Y.,8:S=Hc?NS9D0,T0Ce9cOAQ0L@S/[H
J9[Sg6I(B:FF#)W\1=D@U_0J5X,(MBHVP_KT^Nc)dF3E>eUEN3[?(?WUPU?G[P>5
].a#gRV>NB,=fbg]L7,7]MBeXB>0EC+<WIE9Lc[HRMNS:a:THJVJ=Y&<6=3=f=6+
gB^<:OM+30&X<f&f?VQ3M6>gL[5D7&BgabVHcN>SVP4N@9WI3XQF,X3Q/Z7UMaa[
e#:)&<Jf:bA,:AB2VWHgf[D?JVUcWV]d3I(2)7J9Z6TEbc3D@J7Q:Ec<49T@FDW/
HN=APXZC]:@f_E7a^#b;NVO1M=3SJ;R[=[-T\FcNP(C/e7dGHdD8d:aY.#+g,^d4
5UYQ+@cgbAER3X[,BV8I1AGD8=f3KZ[e,ZQ6Vf-cG<R@gH1b[L^.&ELKI7@YZR+P
c6WJ.K_d1M?\W)Z>+<E^B,#MOA>Oc9?c0?@;Z_W-RSc9)B==Lg&<2&/(e+1a;NRY
:+,d\RUUKb:32H=22gA1]6F+FXPX(>/1J/R8@Z(3#b\OK><MbD;ZXAA8,JOPAQ5;
\\Y]1QZ8QLa]CH7N0RcHLd-B,EGG0a:R+0:@?C=4>f:I\d]e.>F?9?Sb&8^P8O5:
BeM)?,V:AaZH;dUF;?N^X,W1b.24#2fbdPaS]DZ?3[c@:L.F([N5&Df5JbT3b#QX
gTMX=G7>QJd[@6.LFeMDAP->9Ib;=cd]&8N)L09=:/S,ZKdGeN<2/X/0g7dV2PVL
LAS@Oa\2QJO>^AJd)4//fFZPVQ[I,-UcG=0H5FZLU&DYB..3&7(d&5P=e#D.:AW#
/QWg\9]6ccFY.<Kb?a3O[dCE3>YaJR_;3STb<d9ETEQTWBeW03CE9_<DW/)C-\>3
?g:J96>BKeOG]66=:eeY_dQY-_:YNMUL<:JJN8&3D[@U1Z7P)#G=Wa[.B2L+U70>
8]928:4d]/(.FO+@Ke4ZdN&:dI7e4:9[KH@^<<QI&A-M[B66E:CN&<1CB#2;30CY
DfV8<aIFWMSJSOL-@(@f1EdL.N[ea+K@5EX@-EeO>TI3W4_g^P62[a6A&K/X6.NY
^;Z+<g[+4<09:[+CA.bS2ZG<#;5F/9W.[UFZ>Q,PA^:.JPB-4/-F4J8^_>6^6.O4
gF_;S.WLJU0>[][g\eG0c:)?X]7YW-0XL5\;aYABKG.e7.XBTIANK-[,Y7bD9IYd
@1W0_86e&<M(/VX)f7cfgP#8IOH>D_\_&EbEcQYE[8=WIDXgWLG2:064I4[g6,<4
<C.AGDB]JZaIXFS[^E,?F7YQ]b#?a9=H)QCW#4U7fX,0Eg&d@\.+.AdN<LGPDFN&
B2MRH]ce&>FD4U=YSPUeG8I16DOVX6E].G6#D1&HQ0#FD5ZaZ(HA5g<YVV(fU2>Z
DE],,/5-9U9GP?Fg.IDY\VC:C5&9J^3H9V8c4gJO^+I6=9YKa0U5(EGDDcAJ<7]P
1>)Q\49XSPZ^M1S?4eFT1Kdfa9,U&e)&(:.RPRYWB9-->I[4<PY[07&g,C7a-XU_
e=b^e\b2OJH0Q\D2^KMea[bfK92GI[9aY1SE4WW8DD^\Ya]PQEI)8ZC&O8PDa<:Z
2/W_JeM5cX1L]6XC?1E>JA(^6cG&FK(G3B,N0]FDMa4/53+HbbQ99,#TN@>FVP#C
36&GUa,g4QZMIMT\^^cbMeTd6Zg<R4)5MMC)LAE[e/,P=(V.\/eKA?a1CdPZ.T&d
PA+ae=YU<I/NUQe<6N/3R\#C5cK66K&cFOX7aYS][^ZYBE<9#1(3<U&,DVb;\DI0
dO2d,<\F;\V@dZ^-fAAc=E0gb?K>a<1<@Z6B.5)DZ9SQ@,+NX-=ALFDGO8G/D^5]
0J)F]bJUWX3f1TTS#SW&78/=Y=_Q?VN,=@W#J(M1P:=I1b,N-?eRHIaIJI;+fU,-
8ZJ3IV^<;D,8R=^KCFZA;Sc9W[R+J-ZK>[;_UXHZ7W5(e)\XV;,-AMK,RffVbX2J
UK24Z@910&aEO)0144g@WdTeJW:<e1=KGf7RV;^_65KH0&&-#bTPS(3Ld^3IQdPe
)J.DQF-DDU6D?cGCL6B[H=84d?5QGIVGW)>KfWAcdPPX^;;]4:c:Qg4gI_O;gFHM
98Y8L3EP5VgC&UVLDU_>\9Q_7N0gS#/&<Z^):g/J(ENJ2;5-1Vd#GDC)5LXRM+BD
LIXEZ8^CgWB_?/A>[ME<2F_VGV+[H;3EG]D>EC62E6:>J06,2)72&U6H5+#>1<Pe
+^W9bAFe\SV+SA>F5.DZYYTXRA0#N0-5=]2OgX0ZbRX&GCKD::(<+N&PBI5cEdM;
2(R_,V5+;)ZR8C\VLeK-[c>CA6D7U&dPB+7dMcOXPD1M]f.>]NR0^#^76a(WBCW7
6UJ#M(Q2PK]eX&KLXPa(O>?0()OPY\#==OH>dJBOL=PN^BF_7U@e#T+[cN6^e_-<
C+V1AKJM^\0Ee.Y;G#EERUR+b6a\^g,J3C>?0#6LTD@Be]B=Md63BgYB/M1EN+YL
,\0UAMS&b[JAF&ILW2<[CF)922.@I3?R9=])UCB/MSO0cF7/LYRXFZf,0UU1#I5g
@DJ]VUdX(a2>ME5dc_/Q/gI95VQ\+8;W<<<)1J0g&-e59Fd-5L<5;0)8Y9e(&e]&
K+.c)^#/(7?EWVJ<.<&Ze)@c&SV^Q8gcF-4c6/1S-E#-V#_>?I+HW^SR2#9QVXQ8
]A>4KQdgRHRZ9PY1aMCf=:S=<Y)D?;F;V>TJHQ[5,X=I;[4JY#4THbC[1+[Y(O-?
g/C,Q6A;Z9_H7UHR-1Fgc-HP]/8TG&=X;\Z<SSGa)F/PJ](L_b0IfM#OFW;d2E+U
a8a(4&BEb/8VDAT^@7BRd.O6<8??5c3CRcWV\&>[,Z<-eV0:/<9NJ0HUXR-12<C]
C@&7_+2+<dJRN-^/ZT_4#GG3c_a059VX>Fb&YM\.G,SGIY(1ESKPE/V.SP(,T=Nd
G0^:;8fED=0fVS52]+g8O0__AN1+441Rfa=>,>[O?b)M@UPd#6PM#L?dL@O/V:)V
-Gb[33J:S0f<bP[V9(8=2a0G:QbWAVgBTE;8fKP/)aTI;WS^g:@HGfX/bRT=c/M?
\4[FR1Vd^[TB=K.?FGT<R:d_/dD^ZHUN8Qc4/T.C-FE2MQ(?b=;>Q^DYWBWCf4B7
@?<6^HM\L:EZI^2F^88A409T@,@f(#^A/VSFW5B##SUJ,C[]&<La1<S/Dg:4J3&P
a?9E6;&e:PY=YfI;S?L/A>5+4Y8_0f7K^3gGU?:OM25>X0F,J=b3\Ob<:H]1cJW.
4,;(.Tb<cMG?Gd#TU+O8,3/Ja95W[\TXIW,G<aE@BZYRcde,;dc=bf.><3b:#A(P
FK6+/\<BCB@Re74/^93B4Zga_>6EBfc-/DeC<BaR[>bA4@WD4]#E(YMgW&Tb0Y><
cED_BM[#3]c5DQ/A7;>)T+U__eD]VP+R4<&/e[>65,YVBTYQOIGG;QVY9g7=FS1D
YE;:]SB]GUM;@g1Te#\3DVaV73Scc0]@7T^>ND9EX14L9SGOHgVVI.cW_a2RQH6E
IfP>T[Y5ePFbWL=R/62E8caPQ2LH+Be>YD,BfdNEU=TWAJ+QgMUU?L;9>9)2_WL4
N,WP;)DeQ/?:JFDJc2DO.[c:6BWT#AU6LOa-QKNRWN7dO:(@?:06V\b8O7))>/UD
c[X2\-T6IR(#BVUEV5P8Z4H-_S>A)B:DMB@<.2/MHF2+OBO@,Q(UcF8CXSKAE;>_
,:PR(NfH20_4/_>DWTI<-eDR)fbPbV,)L_OB;gVX5YS/gf@(Z9BK&976J^KeV-O;
1-HEGa&E:K?Yg5\RK4O7F^;#;>WTLeQFFSS92WXC+.H@Q>>DE;;T9[&fILX_dTN4
&LADA&K._VJW0@NML_?dQ(I1DDaJ19XMD=7&\O>YG:B.EW+6Q/(=8#-e=KK91@Y1
@-d>ETdRaD^.f6;PCNd+2H+EUE]17f\AHa0.HI4]a&-D6?=,VZ0/4Y7cFSM;:=XI
#IQ2JV(b-D@?2]E[G]=)/M+dMZ&50T92=_b]aaPLINU5WBA-a425Z:H4B^cQ3A58
BJaRf/48--f;:>GTPCb8/KcXWG/Q)45UX9c5G6VS7f,UEf+W1INZ\Ma\A3OJDfWM
TX:U-1bQ=(-@PDO?AHW@79,[a#I@2#^Ib9d52H&NPTdPN7_J9^Sa)L86VR?f/Aa&
:+[^QO3&8KNT#Q@D>E(M3PGbDHN9:=1.^/6P&QeW#9;Q@C4=?>YBa,&@ffeK-]S=
(10.:.2a35PMK)JP?\A<9(]6+SKO)=V]BRZdOH<30OT>L?=d.VERSbe<3?_D/A-:
(0a94;&^]L\A(;4=EeJ+DMaCVZAKg+34?CXK#)3H@@5//>/BN-);Ea\N?aBS[fV^
T+&W_/+Y:<F]XE#NOd^[=Hb;LRB:,Z8X,0D./d0HdeM93NP-L]W:[)IB5(;NJ>NQ
D37)(ZORWe2/?Y;#[KLOGg0MA1A+aN1]JW;L:MABV-@TUNZM#Ke3faZ49>GN&K](
AH-Z;#F_V37O)H\DD[bMLOA=#=PT4QV\-M.H.>.Wd,<04A^e70S5/;EUY?Gb6ZFW
CV=+Z]acJW)OS<eFN80^<YLK66\BJZFT1&;,>O\38O[M_TXTH+^LLH63I#aQ#cK;
D72\[@]+VB8Gd[,7XcWR1Y:ZGW)3;M6a&Y[=H5UXc.B?BCG)B/))H(BZ9aEHV#5-
VXD8(F@AGgBZcN<?A=S<7f@dZ1S(.f9,\FASS_L=BZMAU=5#(Z276#+,ff^KKIAf
RYIWUIRZb4KD5AA,aM8>,2GWBF)FX(TKe=<ZM>(4>XXWLcZ88b)3/3NT]g^59_J?
H^TP)#C0Z6HX=@(G4/^1Y<A#/g=b&GO3#@]W33#7I@1dZDF=\QIe<7\(]#H[HPMI
+G=a)f(TBG2O)1O.)42C=#,X?e,[>N+_9HVSRB#97aSD+S\7T<8)AQe[D),=-eb?
XSVHDMTbcHQ7.(-6[@4[CIS5WTe5Q(PVB<6&gQG(U8eM&L#.bTFLc\81Qd5NK:IZ
[&DL?3_]Pd;1cF:G\,9O@DR)5D4b&P/P6X]&?L\NgccB8Ug2+5c&HC,,3XIaOe/d
2V5dZBNC)&7fD=PR#>7T>74/OUMfJN=??e9eV2ff;f[O6:1.6;,d+-#?3X,>C6VK
L#F/M]WY<2S5f7_G1)&gBSAgefIH0BVd1I-;SW)/1YFM9QCN[80<K<LUWCf5--RI
d6Kg5bBV6GO#(C657:91T^5(F;.W;)03c1T44;),<Bf5_4;+N.f&JM]QU/@8Q3:@
SfMb\>cB)F-HZQJYG3^OW=CQ4dK+Z^[;g2P6CA[:GFI:+SfE\+ZGV,L=.J-H:=ed
IXS6RQAGU55+Lc>_]9fHIF/J)gg:(NQ:G\#&)=JDJBOcEE)BF.3\59B<_?R0^Y)#
)ULE[3PB&KaB,PAaC/HP;WL:P4_QJRf##7R;#Rc_,Aa=]X?R[6@AX+0@1AgNHJRH
6+YB8Y3YV(a7EAP\40Mb4<ZCdb@Z.C[-LeR,<3WJA&bb]68&@Ve5@<]/)@gWe@Xb
6@M3BN/;/bXbd2[)g,bgbT.^E@BXOY;HN@J74?dUY.M^=RLE^MGTbH,2>N42?-3c
FLeVBWB;P@J7?SHEe7bdS17MXN(GI.@>FX[WI=/[@RFMV_AJc7gEU22PZGR6cEU6
-2f)9#O]-U-X:cHF@_&Ha2b#d:=<)PY9#9R66YMEeg2<a\T[&P57D4@QN:\a[XY+
ZJbEP[R;#96+a11>@,+.#gBQ#^b)da&T8c;N\#L:C6127TegTHGUEVPA)b,f;KP(
M?T32dUGb^>N,1->.>A)0HQH[2J27><<57TKSEV[XLINeCLE[76FJNHHRBdOAY\S
\TY;6aXe^UR3dOCW+L^=?OB.T]XcBgXa(64&250)9f)D,bIG^bS1BIXLDfgae0eb
>&OGXd_=_+#4\;09-EG)JCV@.Yd>B8T776@D9T3X+:93NO-Hc#9[b_MZ=(GedTEe
\O-J)GVeBN+9&Y9]1f5O;\]@O9[dB3:H.9U)-)[@bLA\PXTCVZ]5;Cg,:#9V5YU\
a4gS.?1JU/2-EDDHQbaAbgR)>aX9N(7GR#_c7C[3)8+&7;.;W+4#(+R)^VWV.bDL
\c3YT67UYU>-2aWP[2g<+X#A(RD(9FGbXXJFcZFU,748\VfPJeI.#Y\8:WT@d=bX
C>=ggY?A9@G\NDTRV@5EOQb?N.AWcAMfXZ\+c;ae?2V>O^/aB&G/[\Q+ZY/g./-H
#6[f8Z[Ha\ED^Q=M<[,CLQaLIFTO-<[5+WJ=4XV6a4#&3N]H5J-2NX(UN4(N:UgR
I7EO12-CCQQ4K>V;b3gFU>278fN=,MESH;5.A9DI(=-F_21^+>9.\G:^.eS->Y^A
Nef:@KA?3D=922]YJ,/g]=Y6Z3g[XGSe^1OLG@Y4/Fa64RbNFZPPF:cV]GKSJFSU
U0AO5<)=MS9D(RJVHHC?D<GZ>9W0L5.=2=?O,7HggZ5+5^;g(T7TNf4]V971PYOQ
CE4C[.-;S0Jf7T1OV=dJSd?bWK+g=dF2&&SM]L)-OABAFX4E5TL&F?]>V.db(W=g
g)XC_fGY\H]GJ#b9@@F&8MAWSS\>deR,>D\4+gT.BGZgAX=&[aQIIX/a)&7A(4dI
H9gS[,@3V^73_H[48]R;5/](K=\UdBH[U0+U:\71WgQ-U_/)[HZ&YG=S](14OdRc
:(=DOD-GUG])5P=DA_.AQ-L46XNaLQK)Y<82(M\JCLBG5BZBE@fTg3&@Z]M/X5>f
26[1:=(/E>?.;c5=d1&C8=4=Ggd;BDdJR><W?+&=Y0/[-A54(^.G7a+[=@N)-2):
Zabdg2&5^LU]bXCKPW9=@G2OgHXF_>=ab4E^I\94<S85G<GN.U@1a^3=ZXT6Pe),
.B5<F;=OH,HTaGaPN(E-X6=LJKS13(4MPA/L^G-Ea@>:Q+G=Z:+7ET)Y1DGP<9b2
gK;PP5GfO6>fH[B6?0)ObfUCc2]&?fS54e<HIC7L[1@dMXIZG/D0FY9U62QeSLaa
N&;d06f),3KWePVd,O\OT&3LIX=;QOLTV[WR&2=,gT<8)6VE>K1^W)RD^KG9:LO&
M/VHY?6L]()W7>&>NT\[-JQWUD=SI/TI^8c^/6TXVOHe\_8D&<2=<-2]ZYFYIA,Y
@#LO=JW(NCC4];9aD,.JTASOPaE6]DK8d<0^L,a[6600F)d>_b1-].\eS7+Ma7Z2
W:3YQY-7.AE0V(]cAb?X>Q@6cTG\MD=5Q,20Z.ZD4,U?/55^CA>.>SP^_O6BU7_4
KgW4Fg+N?6?\3_Q)4&+94gQ9<X#UOg#.3_13^KD4egbeR=CMI\,eFaIO),F;Kgb#
AWQdR=;W\bQD_-##Uc[<E=3[TJL)bb7e1Fg?F+.b-ADfF2X)dU040ZTN<49#J7A-
gHY18Oe=WLc?Y8-77@5c9LI@5L8;(;C_>\N;0++E^Z)1V?1@CCc0NQ^[QVF77A5V
C6#:IRY9U_TW)?dC1XcFFbfaL_RKdA3A#\-5LY9ANGCaH_T/[dW+dS77a-5FN;Z;
7dA)R]8U6AdDT:/4K2^Hf=H4[c])-.D9#(G/W,#QYa,4?LIcb&1a)TgUDcAXd2+T
a+8-_@WQgD6RcFVa<X0SN7VO+UT,H-//b)9a?Hc^aP-PLQ:BS;2IA,LKIdJMgC\B
DBfbJ6:K^D2=G:KHX/4-10J(0YCdcYA4UbT:50D.?c]EMHJF<HCdVb&c2B4eVcC<
L1ITWc9MC(+,5IZ;ZN^><e#R\CcL7OI#O#)IJ<[DJD]/OK7-Qf-R8UIV5)@9M#4?
AR]8:4#+(1U2&OVO&\@VUMa4BYWDF37IW=NcZE(?VK>f?D]VRE;e7LCeO?=/]ECZ
F#,9D3T8[5H2+VGYA_cXCO2Y_cZ97b/.S4JZ_R.7Z14c(SD\EdB2d2<5:SJ?7[S)
W3K</&<<54M(GadNg)K.WR[95JG4;&][B[OE.#RQ;a/\9O@9[7aQE>^]77@GJF^+
LY8I0gLFS4B/0Y]CGed&cRV#&QEf<eIZ?g7Q>X&F77eV39K+AD6HG;F+I<1E-N@L
8I^VgHAZZ3_PNC;AaBWDG/<XB,geO5BO2SQBSeCYK(/CP?S[(1FFA0_G0dOcD;g3
@gNK.H]b5RJ:L5@(X&_G+6+2VEcI,D^eX1)gBX5N9ZTH-XBT+S7);&fYJ/MV<.9T
=c)5)b)X]/O-S?TF0O6EB;7cBKb7.W^6.8Hc=9c4(NI_AGO:6]b\>^0F/J;2]>DV
9YU3[@J3&Kd4I-WM7MdP\WOR<LFC(LJQ9/5+5;&Mda^QX@_3:/ea2>Ye[U1c7WCW
.cBN>aGXYY4Q]cKWV]G^M50DYCK&J2HOMKcf(:4DS.)faE@:M+6WHc,K>fT985:5
7#XLe?,)0Hb]3\#VXCLFQC+@77>PF9(2\_7USTUFf0-5_0;e(/;.0&1OD:U6]WR5
[Og+\<0-6<:Af@gIcH&IM[=8O\eCEbYe[^^YT,&FfgFN:7<3-V/1?,W^:ZdJ1;cY
f,3+)c+c=P?A.M_EY9@Sd(V1e_fA?;YLLO@1g;YR:]&/J;B(:9Da;LA]6aA8HH:0
bB3LY)#FF9.aD6eP3eENEFD0)[<M6X(LJbO(]L4a:d4Ha6B#[19G;HVQPcHH4:EJ
@.LOV7KgN;(EaKOKYd.9:c[[a,HJQW;S-5FP(8Bg1CLd6/+/_I,VV3,U6Q58Q-__
X?72]U,gT>&bADc>:@fc_34@I@@bX11M+W[8K.#E:NT7ZO,Y64b3\[4(M()E]2Xc
5VR^d3[;_F^T3dc,\T,T(;-f.0SK6FKcM2;PTL>&fDX[SL/R\_.NS_,8_<5Y2)AE
QYRCR1EH<\E4T#?ODEbOb.c^Q/Z-X=]5f@+Tb\,\&-GcZTVL:;2;VM=/<.a>LQDV
O1fI9_ecUIJ)@Z[UMJ8D5Y4P-]dXc/S8d6LRA[P\Fe_(TJUJ42;:-.8Y;YQFM,3N
R:BZ\GZ8^&K]KV#X8;M./CL455EV7U[GF?XYc:65CKO@_3f&ZOT#-370I.MMb1W#
LAJ];[@#^Z.S&WFNL=V1OOT1_[P/R0)N[]N3_=c#>RITY/F,Ybg/>=/[dd+8?ROQ
K;)IT?(?G5_IF^5acA9/^P^H<_L(M.Fgbc<W1_3Va-04@L/[_A)3(C->BVb]=b1K
AaL/LFH=M9F[1UR^7NO&e08(2H6Q8JMZE;DG4M?NZ3IT[]+f0;_5&]^KBf>K;0U6
37<:3EBSX?A-D]6)O@c=#>FR[K)YHNB_;Y(.)J^\g@E&LZ.?]H61?FI^+0b=e4X=
_#f;3[<G5Q8L?cEXD;Q_;K7/B[a8Q[:X;eJf.=1T)PGcRS\5\:C<L\;@RZD7XO(]
A52M_9g9U-I/CU,X:+?>-O2M.?a1ROFO@?;f-g\G8YO3H.\\>><c^J+_)GUQ3eE;
49eV-#GS:gB+G6D@_Qg_f,^&+\HM2-A-G0A\>0G75,2A7S\,^6)MfM^_89<gS@V>
BeBW7RWWF_VU<X=Q-]7H9<Y\)=Ic-KOJPAKMD&W-NA2#XF\bQZ&V4L,S-(^2K1X8
M_+&NBe8GTW60J;cV<:<Y[X?/D=@)G]8_HOR9_9>(((GR]6YTTUf&N((G^E5GB?9
dW^aR.)[VOI-&=aCR(P\8;Kg87_0b;\U8]_.(]?c2-(4L:G_.+>E22LY@f7F(0a8
1=FNEI#YZ,;>Z7[?+#/#+bZFPOBA3487.KUCVdX1NGZ0Y29NBXLJE43fD-^L8(,d
R0:CaG;<H34-1f9-<7Y)TX7RJ>SbV(.^FMX-8HYF@339WC7X5Bc2VGW;],JBDF1^
;_X?)0a=69Y:N:0<&2;.:X>f,a[VT8?)AeVf#Q8T0AW6>60DQE>fg\H&;@_(eDL7
XFCST(NQ.A2,UBD]d8e65UTHM#S+L#3Zc8PV(>2aW7S.P7(;b>5=47-BT0Na_WOG
DXcZN\KEVVg1]c&MOPBUG6DOcB:?+:J>)CGKZ>B??G59f^+@6@ONGQ7ICQ+T5g7J
R;XU[VbRX_e7EV@.9#N6JYSPOIc-+,U(^Taa5fS^a6NY61^8^<=)Q7EJ0T&(U@[J
LgJR[.G(R6?[9NdC=f<A9&SaQaD)cG./YVBTD;B9D#YOO9.K+g,^bR1I#A1E=<NO
5J(:C<T]g<Y8g^L.8.>^2?Z?NAgQ7B]BCg3&4faTb..K(gSYN/[2=S]XJ.2,H:ZH
gD_)O+]M\6AQ\V:#M]9DI1/:7391=I+e10d8BL7]&UcR/T0Na2eaHJ_JUX00,9BQ
AN(DZXJJ2OK_C.YLe]1C\&2OH)NO\,#LK6?;,5DgJ-eMeQ>W5Ea./XfeF[7E/]^\
8aTKG+U8>:eSUM0W,S^LEG=EX3HBf;-e.M@/eIfTO_b3+E0EZBZ,=ef&JO:+cZF(
?g)LL3<J?>R2><aA?HT03(HF8/E,g/;)[?J[V=S);4X9bc;#d&QgQW\1\;\(OLT;
-Bf31]DL_HN/8ZU\30(e9>Z7-A]f;,=]Z9,4R9@W2GGRBDVH+-)/]>\a;/@?<H<I
7b]73);G>#@/bP]7XM4/FA4PcCaFMB^4MT9fdUBcQO0,K#F^D3O2#g<3\W6/<FBJ
=2@,:d.T7^@\#9MBeGI7_I4P0cBEP:;TOgE.K]U,>,HHZUOMO8</aOA<1g&JH)f<
4,;+Z_Ug5L_5E5G6O1eIOQZ=2X7b.Y7#1g+b3BN)C4],#_5+HUaV?+XW?78fSH-&
/a/f4.II7=OU0P+B^)M1RJY8#\T5-DcMf=\?gE+SJ&X3Z3B1[Cf)>gJXbO8TWUVE
eXBZKE^ARDMQCJ2.,LcGC[4-3NS+#?.?Z]P]FDbGUB1?W9+@>a<^Q,1W._ZFHf=O
>&,+cgce&Y:.40:NQKQVR>Qb9QV&F=7XC-Gf:.,>b7(de#fG)+UQHWY8+L-T<DO[
c5[LT5KK8g[LMW\/._(HHM.P7R-CL:2L^(gPZ&H,X5fD5XCd<>JN6#)ca+d_G4fX
]HCIH)NLN<1N+VY\,.;I[>O)5_;NT#C?DL&,OKgc237d#E-LEVMFA4^:(JB,#V:9
=6V.6)Q(X4[FeK+@a9@>-bJfJW+F1O@_AD22L);\7;7OMF8AY[d(KN6,@4.C3^87
]#Z@015a^I_N8Xf;+DN:E>Yca(5SE?Z)SX2a]a1:LB?44N?\7]@IKGXU\M.V/=UP
&@3P[_Z,4@K)].E8FO]J9?)U&CZc_]I4CaI8BWVCEeO\66D->CV(3KKTT>OII;cD
T(DS(f7[Q3>^X>C8f=2E8M#][BX3eONPZSK417MFJHCAdeVf)NZS?f3&gG5M4EQ4
Q?45S98Ef3UY5)<W@J1<R@5ddXS3@J,F(\<cL+;8;M<V^1,CeZ+EYY7=7C8I7([\
R,HTWOS]W_UDd#UFcO<D&>c:P12],@KGLc_a9)W,^W&^#c>_26FYU?7Mb4J6RCTJ
ULc[+YD-PPc47X6L,)34+gIc^X#c4/_C5U2.\I4N6b;aKXDO?7D/aZeE9Q=UMI6[
6-b:7]:R\,FFVG1X07cB1TK]?)c:A=?;.Bf)K1I=\PHXg8<.FYN4I@NBB+=a.08V
;C&1U-b(E27Q/)4T@&/C#C?Y>OFVQ1\+6E7=C9YT.^_COXM<A5d9KO;MdM>;fBPg
&+6N+-25M),4>ZWNQ1+9]9Z/VB3:KA20PFBd4cgg;1EL7+/M9S>QMEA^MJ@?Ga,e
(M^1[)OE-ScESF@O9[24_Y-O2>A2811C5cR.X,/#_5?1Y&QM1d#6?FOO.;=D;aTS
M1>.SA#b6SP(O9GTQZ@+U1[)LO131#7IZ,3,ScPL(,A]JN;;7@]0=[aRgJY^ZAb@
b<@SNgD>+&c=FZ-NcHB?;Q>1;J])>E-XFKO;AbLgJ&--F;H[Q^7E3Sb8+.0f_Ibe
&_O13Y&H(fWGFb3,H=eDLR5#(#g3FH<?J]7&9XTg>P/F9O0C:LM/T]b<T/#U:.7Z
c]F@UU01UM@b#F=SD1/5@&P@d->9.3HCIN0K>C[Y)fQ(Xf82@TWJ,6GfbU2P#>9.
H_0>WKH4T;_L&+FBAf40g?F@>7-4>a2\?XY^[LSKfL-A,6]G1R]PTEc84XP[(X-;
YWU,8K@#\QA<FVBF@bE+Y6MA7M:e6SY8/<ZGJERN&6<MMH7+a._PX-CEE;0dEFeC
G[UKb\1L.,b#OX9eOTcNWB[Gg+UKeHc3XMYH9XPK4eN5PTSCZ1\Ea@L?U.1A0g5a
>8]S4#(QCe>][&:gQg68AX5DRG,Y/WE,;a)_YLNKRASCPWV(]TN8DNFACG&REW/4
_&]4J3A3DV(f:^5GITNbUVc:=3-2L[P)b3V7=\4_SV-?G2HY\-)UG<&&4b(+N^-2
g;e0RE52U]Y7@KIM;>Zfa6R1&<Db_F19#U6AK;L=P6C[2MB8;?ZDVW[,+25cC:AZ
dA^BaCCU2L-9_>ALWb+P+WT95^LfI27Q6A8I\-OP6M5H>M[XWJ)gR+O5,f]L>=[=
RfUb?,<3\Z4Mc1GcID5[(I=<I)A/JF_^W5E[MZG;16DNS?R9)3XM@^5>T##&5QE3
-F=^g#OP#ZRf,b+5MOVKb8.PBK-Nb3f64&2D4;9[>?N)E987M:B<9f.b<6>Wf10b
2O;MY\9f8b5V[6,IGd]6KQJDL36[IH4;868b.JMNe,&R;C02313VcDN48+)ROAW>
/fPW]b9BdO<Z>5OB=-/F1N0F>Ib_5&;PAN9WCddY]XVMX-RZ8Q\C06(A4@E^W?6N
J8c:FCXNZS=P<?\)F#R_N>PA<7IY38?ae448GWe[NHBbHO0/1BX&3<8Ze1JR=bY.
#64QaaP(<_..48Y_Id3M-1GPYCfSASV17aG1(?aN=,(2EBXL5f&M5]g8/0QYUN+U
HDLY5dB4P_\FT8UDC,Q\G,gFH-f:Dec2K+P9f(&V?g39UIH,;8)F1dUdD<Q7)#=F
EcL)09-K@He+;RRW3_c5]3XNJL;#/S3I.0HSG9Q]C,J>/(?MHgP(_L.B/#^I7G;e
>P:#1dMaRfTWOY[d7LJZS5X;KbY/3[8AINX=O\[&PJC)LdW;.8V?,:.:;8A<23T3
O>Gb3-ZN]SMB[W2]ANC53>D3\O6YH_ZN9c3aMP<9TUS7TC&4M_])ZHX1@Bf#DKQV
8Y@ZS.R;(E&+MKY?a-OX:ZN=OId,M)6b:Y-O.SIS?P5&Y+^a?;H6acaY:1b^T\3<
gd5]Rb=;3\9JcPWX&8JR[<8e+/&X[>C?XL_#TL,[)K\;Ue&D7YX(aRHa=M>;O&=,
G07=.U:L>b5.R&N(SfDPXZN;6CI+[aJfD5X3<UU6VbWUTgRYP)(A@;/eM5<Z1fQ.
+2W567gMWfeOI>Q(4+.^@4F,4/\EHLM\6>I/@f#5HaUFI1+a]FA3f71W9U<YaARa
H8XY&VZ)+>-/eeMCR<:WG.KegdG8d8?+5\Cc)PJJ[7;8374LALQSfF@T9ACA=>cI
WIa>0J)d#.(\>a4]_OU<?YC[EDB1IR/,>fGL<=KKN=[N+4>cQgW2:d>eYIA[<HWP
BXR^E&gAP^cSV6?=d465R=/,1HXI0</>YfJBE^5S?+_?+MS>dQZQ_[UO5O#Y>F;O
(FGbTMQWP^^/AQ6EL^E)T3VDN.@a?/7B0Ag#88Y/Og;4Q@\M9Z_406:OHPIA4g?S
PXT3E;\1QMRAUbV),R9^KF/NUUTYG7TI9H#KX\<^@K8Hgf\](1-VIVa73Pb+S.fV
f^A1-@)56DdYW>^e#7P4Mf)A+,eW<,GPAOX5T3:P.:.5Tf9XS)QYN#_ZfOG-EJGK
+.#,8CJX&-aA6K\()V+cF16RDOG/?2fU(g.gBa5IU(R6@H&YYY9?KGR>-^#HadNN
D_VQbcW<K^1H9;)fS3()QCcZVaLB><2.[IcTR[K8N-#7>8_2G,fK41TgQ.)-XVGX
aKU_0X0ac32_=GCNA,KJ@DC:,,CZV[_a[,=OI6AS4YPGHBICM>_@FcOW/:27G2^&
9H.g]50(Nb(Q[\K=4,;IUV>Nf?V\#E1eAT258fFf&Nb?:CI_^&_C2-fZGD_Q5489
fW2.YEL+KH.@XgH[5XLKD.Kg)1Td4\ea7d<af[@XeT\:Ba9&7QD/g[Y-5@KAJ.<b
\W_eIKR@5M[=IK@,eZQfD?79UeAY:WZZQ:W7gW9_4HQ2aMRUdM6H+,Q<H.]#4;(e
Y;O=B&NOM\Ke>D=^MU9--85[S2KD=#F58==P/RC8PZ<NEONDA?:5#KW0<2N&++H,
(P9g^faS-0g5=SKY[ZZE/8?7-&&D1&GaT.-H5=.^DRJ#9^,\?g6AD[e#e)@>&K.V
g<S\-_R:dSJ.X8Q8T#F()+eDXc=)MB^);A5Vf#)AJ+JJcDe;/Yc=\+9D_,)-5I=W
G&5e.LZ6c]e#YEe\S(]PL7@90[dM33RDDYM^gQaGM[fY:fJ-N=AU=K\gJO;#WT+>
O7^L8??92>?5H9)-MEcXdDHJ@^M#Y0BV\41H]B;,ZKRX,-31=ZbCJ]O39H>Y1TUB
1b>CAYJ5&@Ef_V2Db\e/AdO8][,038>eM\?_W-H?L[94cV_#4/E]YBJZ&E]-IcU0
Q,Rc1^ER,OQb.&,&>?QL;;Z^E\f:ZXK[M<PL>HBQR/@L>Pg_4:9(:ZdYPDHW/PN5
<@/QCII:5,G;O2(3/CWB;5b]5<\N@c(QF.GI1OX>R7Z?,#\=Jf9,GK(aKZ<>]FbK
8>H7#VC6/&Hg1/XCI=SagaaCL5O_/L.1Q(+c-R=e,P>II:1<g.Bddd&Y.23CaQEV
&eg&)cSec/AB&W8+fVUFOEQY(Q:&OA.8II1G(/BSP^NB1gUA5VA<fR-3C#O)<TOg
G6/4Z&SBgCR@UGW:Sa0<E6]Pa]E5-=-V3EeW@)e#XP^>^<H3eDPK19_8.Pa5F_H>
4O_UYZ)X1#^.QPHE(F#YdUB)3>VG:YS;HF0<d.IWHgKfGI25RQf#<JH#2F3=^RWL
8((7Ye+U9-TM^((FOA.GNdR=P6X7U6EA:CUId;V2V7965F.?>OK/0Yc0QW072LQc
TPfO7+)dD_J&R60F<F^Y;4Md<(@G_BaSY8Z/eAPUK+f?JWIaFA[d4F(FCNa;,Ad=
HJ:ODH2K3W(.3PXgBN3J,5IGJD&VBa]Q9LeR)c8K?LTYT+^ET23&\8S-T8B(Ee])
SVf)050T\LOZ/c7,[@;e#cV?I3HTZ/MR[SAEQ\O^(Z[V,7?#S7<FgJJ+.Me/V?aW
#URPWa2I>NVH_)bNXc2b,P091/^.BT_-D0#<2-Oa43fP4;)Q@]STN?5]^fU?0:?0
Z?;WZ:cA[,e.^.D@_?8&IaHH#AC+3;/Vb:M;UbOLKb;&,U;AHA+L&ZM9DSK=^H&B
Uf&7gHa(6_1JS0=,?69Z_D3VZ@>?_<g2;-Ec64F]_7K-;<1H89Z5Jg,L&5P,&314
;J;152a]L+GM4AKQ)O=XL+a(5&FSE4R7NS;48U)3FPfe@#a58=GdIFS5E]F<B9db
#^cIS6[\&I2Z#ZQ,C;&AIf/#D75QT;JT/EDaG8?H-:2g+\SOAVOHAHdJ&gc9[Z0K
Vc4-ba\f0/3S>O.U](RN(,PT8H)>;L-JEGa=OId9>>XgTF1N;]J=MH)<4B81@53A
b&SL9186Tc?__SNKU?6Be3.;Q(E)_G7B95?eJU9b@;&T;GL;;=6>.FTQF0GNJ?3#
<V2^ZJeSd=0cCM+@P.R6U3(O_8UMf2f^42LS[#:(+_f39-g)9]<X5?.4WDXeN4D.
)(G[aF9FZbXG1?Y28Q^K9<.2?XXG+:.638ObYC+9E#A=<<,XX]]ZY;<=>cJ<6<=0
R5=2/e7a+TcS7XHgFFR;)C.27$
`endprotected


`endif // GUARD_SVT_MEM_BACKDOOR_SV

