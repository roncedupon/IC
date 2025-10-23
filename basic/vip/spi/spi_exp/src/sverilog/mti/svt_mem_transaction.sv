//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_TRANSACTION_SV
`define GUARD_SVT_MEM_TRANSACTION_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_mem_sa_defs)

// =============================================================================
/**
 * This memory access transaction class is used as the request and response type
 * between a memory driver and a memory sequencer.
 */
class svt_mem_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /**
   * Indicates if the memory transaction is a READ or WRITE operation.
   * When set, indicates a READ operation.
   */
  rand bit is_read;

  /**
   * The base address of the memory burst operation,
   * using byte-level granularity.
   * How that base address is interpreted for the remainder of the data burst
   * depends on the component or transactor fulfilling the transaction.
   */
  rand svt_mem_addr_t addr;
 
  /**
   * Burst of data to be written or that has been read.
   * The length of the array specifies the length of the burst.
   * The bits that are valid in each array element is indicated
   * by the corresponding element in the 'valid' array
   */
  rand svt_mem_data_t data[];

  /**
   * Indicates which bits in corresponding 'data' array element are valid.
   * The size of this array must be either 0 or equal to the size of the 'data' array.
   * A size of 0 implies all data bits are valid. Defaults to size == 0.
   */
  rand svt_mem_data_t valid[];

  /**
   * Values representing the base physical address for the transaction.  These values
   * must be assigned in order to enable recording of the physical address.
   *
   * Actual production of physical addresses for communication with the memory
   * are done through the get_phys_addr() method.
   */
  int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
   
  constraint mem_transaction_valid_ranges {
    data.size() == valid.size();
  }
   
  constraint reasonable_data_size {
    data.size() <= `SVT_MEM_MAX_DATA_SIZE;
    data.size() > 0;
  }
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_transaction)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   * 
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(string name = "svt_mem_transaction", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_mem_transaction)
  `svt_data_member_end(svt_mem_transaction)

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_mem_transaction.
   */
  extern virtual function vmm_data do_allocate();

  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. If protocol
   * defines physical representation for transaction then -1 does RELEVANT
   * compare. If not, -1 does COMPLETE (i.e., all fields checked) compare.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.

   * The basic comparison function is implemented as follows:
   * For a given bit position, 
   *     If both sides have the corresponding valid bit set, the corresponding data bits are compared
   *     If both sides exist and only one side has valid bit set, it is considered a mismatch
   *     If both sides exist and no side has the valid bit set, it is considered a match
   *     If only one side exists, and if the valid bit is set, it is considered a mismatch
   *     If only one side exists, and if the valid bit is not set, it is considered a match
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on checking/enforcing
   * valid_ranges constraint. Only supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE.
   * If protocol defines physical representation for transaction then -1 does RELEVANT
   * is_valid. If not, -1 does COMPLETE (i.e., all fields checked) is_valid.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE is_valid.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_size calculation. If not, -1 kind results in an error.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE byte_size calculation.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_pack. If not, -1 kind results in an error. `SVT_DATA_TYPE::COMPLETE
   * always results in COMPLETE byte_pack.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_unpack. If not, -1 kind results in an error. `SVT_DATA_TYPE::COMPLETE
   * always results in COMPLETE byte_unpack.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   


  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Method used to obtain the physical address for a specific beat within a burst.
   *
   * @param burst_ix Desired beat within the burst.
   *
   * @return The physical address for the indicated burst_ix.
   */
  extern virtual function void get_phys_addr(int burst_ix, ref int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX]);

  // ---------------------------------------------------------------------------
endclass:svt_mem_transaction


`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_mem_transaction)
`vmm_atomic_gen(svt_mem_transaction, "VMM (Atomic) Generator for svt_mem_transaction data objects")
`vmm_scenario_gen(svt_mem_transaction, "VMM (Scenario) Generator for svt_mem_transaction data objects")
`endif

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
arXgRyhVTDX68BBpX+ie35TxjiUMMOPRSvW+6P8oYvGSN0diSug3IwWbBN3Le8Ii
QarbwdkNBW/yDom+HxlKGD2NasbqMpkKd3HhBROwJ/z0ige272XtslHPdR7i5Fz/
/uhrWtuUHKjpyplczqmQ6Qqi+iWCElQV0KHSGy7bpHg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 771       )
m7vWOUM1BQ/SuyrY+WiQy6XhyP8Kf5uns6XSNZQnRZlUa/Wl+UK1Bef4ssJQGq/P
bHRCcw2uQK5ObF6Q06S6VGAvuc/ne6M5TM7DnWhLcXIdT2F7N45DxTqj1mvWO5FM
7JE4QYeRBTPTki9HxHn2rw0vIvMNwjdtKQasAJ0eDv7fow2DYHES0nPOSDMPnFS3
iDyYOFbq7rGttWJYdam0t2TR+CFkCYCrDiOrGgEHoHBWpo4/7rOLLGGnbDodFTby
LSw6i2H90c7lewInDQVVjtsifbDkKHxeCQdrgt+kSunRIzuETpS8qHqsNwBR5ET9
YCrZILBBZwDQM8egbDAK1FeqQVQFzgbNY3yazePvy1SehPinoXV9EGrBoEkP32qM
E2L1v5qi9d7OqX3iT4rhAc4h1Ow6e9I8ZE9HdwDkJNZPautYiP415awxqaM/Rr8r
YL4AohjZIs73KR9799DlbnVuIAyz8Acov7jIy1avHkGmE/PZNYKyW1C7FNztFKs4
wtUnDFf7AW62N9HfeBl77410AZV43iBBI7jMi3L93UwdCpQT0l3SyPYrmMQejBfG
G+FCHfzmCC+970csNTEX1FAwT0XzLHWJ3cdGgJPyUN1i+CdJK4ZPmAmnDI8V5dFm
VwoXMF3acfFJzBlycqckCKP8die+tQWtLHoNLcABUnAzRnK6Mxi+WsQlyhdYJ1+l
QxpEdpgZ3nWHkVB4Pp3uD9UoEl/08bYXwx+gHMmrfuejhyeln9ufzbJWKR10uj2I
7hNIlZDa4AMU3Oa74KmY7T14MaugdVAw3+npbH5fab90AZJyz4gp0IAXeuy884R8
u7mbeKrPFrel6m9YPgu6dMonN5R/iOiSphWsLglDd7IXvCEUtts0ZrPSGBDtHyIT
oKgnQeW9yxDIm6Ve7ah6f5zqx98iyABl8/IOupG8yul35uSmdhaMMvk50HTHRfZ/
Iq60Y603crE5JYz7SqW8vqe+ronG8bq1ruRmQDhgAroSI6JXvBM16A9ItBIy3NC/
sBx6Xrnm4AbZ6Sy69skHuQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bDmI++Q+0PuREdZ/1ncyN6XUCgweWexvDy5foGYTnpebr7Wznl+INMTiPAPgZKRQ
aZuKqZPfbN/BexqGVkdSBnvElM4UQbHjyMLtnoJjcZqttWHB6U7jaSMfZ7K3oIm0
iMuZ8RKbgqECxiULTgxTUIL4ErSSy3AvP4xMQiLGZdg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16972     )
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
`pragma protect end_protected

`endif //  `ifndef GUARD_SVT_MEM_TRANSACTION_SV
   
   
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n6HUb6/q/4yjYK8p3/+FAwZFFvfyftacOeIgvpi/kvIjtBJ0rTo3HveH+BPPRSS2
CYMeD4VPUdDlTeHOIZPBWlcGM0AY7BXWwIUuY1d6837XLO/X+R5sqV9aCZ1CJGB5
IkuqSK/n2xjZGJFK6DcTjPEAVrLon8TkgLVTD2jtVW8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17055     )
1/FQGpIc+2w+nANY+jQ44W+6frjb5Jb+4VwFJ4hESfaSgYxEz57jtKtlrPlNwxDp
vX6g2H42Z+3CwcoeIqDJ5qSdfyjVU80tfpqYnDv6qY+xJtwOGbeXOhDT8yY1a37g
`pragma protect end_protected
