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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
AcwgK+YH4e8NTg8wGyN2+LIUetenqSXO4q1k6SB3JLSxeK3/kBmNKfQQZyf4gsnf
SAye0lF6Uas1rjGw8P08Nd56knmw6C1/Tm11ZuEUgSohwYzP2K5srAlDb/p26QKV
+oYRChAxsd6d1DWsje9CJue94/IbAPTDukbdQlfmm4bKtC4Wr+wRTA==
//pragma protect end_key_block
//pragma protect digest_block
XNidMoqI2+yyrQQuWiawhQ+bzQg=
//pragma protect end_digest_block
//pragma protect data_block
E1HFlq0qPmT6+SVld09SnvLus2G3nWwSAufPu+bLzbcm0L5tcz2FYJv/pccP3xIh
Co1gsaUCc6EAo+6naMRVb6z3gU6yMqRTxcjZrQ9ih8xtSjK7hlcd2bkyYejmEuP6
k76DaDeCfwJjPp+dK0AY6shcM4tTxx/nDbzViX4AlMNizsQL2Rzb9aFa8xVhF8Dk
ksob/9DxQ44DD215e0hJtOphpinn3IzJaU7Jo6sBetsiOAr8DkIYCaPoXgOr5fG5
+4MjgBm1YYBH86OJ34DI0XpIqt21gYwSFH26QNwbn0Dq7SWCzo2aMhtPNJvDlwrd
SO3uguZ++Ei9ncJD72KPbBnA83xbYn5s3TeV4doVO/a432hodAHK5Rghj5+w6WCo
kkbX5zDyOYfSmCLEjCxEnEMwAWEpFZeCEAh99h3MukuBUuds4eR0AeI55WoWKpEc
beXCsnsyvpnXDFsQ2PVrOpPFIByMFCZvGNV9FCJbtp57SQ0r8kTT1lz5G3wQpEA7
Zf7Ifstm9ANFw0SM0pzYWwKclQJJ2iNgLkQgEP1uJSdl/X3pwjctzbd0Xg2+RRZR
CD+d0IlmmJ5SXRo8HDMEaqtIyd9iQbOrg4BYseE448M5wfFaW3OoNG4KKxvJjX5b
fxO8tEsQVmJXphxuZthuvpRbdGhj/9UIXqUAEh2ygFrYS8u2AmzAN7qMNTwraMnf
QTewXtLaFNsJ/iIDws3ARMVBvvcuKTYxq66+HFsZYT0WPOrNG6USK7qW5RLiCwWY
0BzcGNkgWIY9VarrMFFLneIAIurUO/EPpL9daPBZLc01ch45N+ZhZehplAh57BDc
hJaERpUGq0QO1jfEt1hLRvK2jhjMIA4b47+hXUcEpH3r1unPgikUYlkzvwAbQZuU
gceP+BOdU1317Il034olHWVI1X4XonKwIhkky6q5Mk7bIvbJt4NK7zrXmMShyH4u
/HWYC15jFp3blYbTzqSavRwpq/R0s/EdRGH6B6OpvMJm2A53bd7USR8niJFRMR+G
l8u8WGbtsUsROob2aM20xr8CREikELOxmLZEsxn5YTR57xDmbzufC/PwXgMsFfrM
oQ+tbyFdaE1KNyP229L+DiMQv6kuZ36JB+IexSd+EWPM9WjceUXaey8LHbjL+xC0
6E1cIvJoibbTDXB3M7B/sB/WSnqho8DrjIL2er4LSl5+EBKF87O4NOHEnrlewfDY
mHuZ9kPDJNlWdjYW0K0SXn7aSqYRIIseM0rrbq2bwCI=
//pragma protect end_data_block
//pragma protect digest_block
PMwBrALk7dfVPvHl849BHOket9o=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5VNwrgvYKRHCCVALAEVzMrutT/3OBM9yV+vl7duIsBZVy/lhsS48YcyhER23SsR2
JZanxnj8YtVBCK8wLgD9WJLV5WbQ+ZESVUN6kIHyFdUPIkAPmAkJuuXM/Z3bTuEN
QGQTscBUYxWgd6fXiQvMtak2FjU+kpkJ1pKUMrGeL4IQxw5UVGfEyQ==
//pragma protect end_key_block
//pragma protect digest_block
foMcsxgNFt39OH/Eq7WGrSu7VlI=
//pragma protect end_digest_block
//pragma protect data_block
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
FcPg1wJzd2ENaMU4B/Wx9ppcXTavAuyHkhwW+5IJvPhQnnDnvKsUYsn1IG346HvD
u3LQZe1cnePHP+wPFrZL5LgbzlS6GsjB3SZC9Zlk3PMiOsOTOAlQLRoe89Wulggu
PrXCnTS8VnSiGCwyXiugYaibu03yCgmuaNXxJXBp/xt0Kv7KgvFZkCWk+GMpQ1SK
nfPcsSwhYuD+cYzWYsmtUDpKN00WSgUaASkYwyzUirmn8rtcmsNwvOKigoiwYiJg
koTPbienyeIVHp/9m2j9C6v0fYRPDcy1mxsoyFPjn2Jtc0S2/TpND1MoamCe3+1f
6L5CiWWnhvNYPQdxC7ucknLhogK6TgVKwSzDoUE8EgWkv2r3dN4v5VfWL6UY2ONx
OABnEH+YTZafoEqnGJjgzr1Aio0QMvyi+AD8mwfgkYLJBBF7crgmP3zZwiecOZqY
6USb9Wqh6IvycWBZdZ084e3lX/qvpzIsmTvjPMu+NV9swVPIz1K66MYgwR6WA8eY
nK3lxzGe8X6pmpZchsYDTdganG5lJa4z5vSKU6Z+2Bnu3lj91TF7Rkh+XXyl+R9v
cHTVKfVDeTPpZzHPbWGmk211c1p0WjsAs9mq7uxR6zU4ZKfHx8tqQkr8GYZH7qp1
Q87koDRKmRD4FXaL/hwXpamVrDE88z4sbco/+l0OM31PE16XSybvNz0IJo3JGalr
CeCRePKuyqg9BR0TrwQqmJjcqWNS5yyxJF03XULuyo68C75j3pt3nrLvHAbPLMgj
RU55HD3f3eXo4uaXYy2RXAGqoh02uDs67J1IRDonCj/qqyi5kdAw1AhXCC8dV91e
retWo5IPI4saOjNqFgJChCpGbJPlraVYssdKdPYVY7GypOPqZzmFw8zJfp1Ts81Z
jwgl7AeBxx7lU28CI5Zy+miFgP6kcXKLpYR7a5PVkFQQYRTL5bSzWFHEGrpOq939
sk4ZQtzifgb816viciq5DSx6lGg5oAgk2Z8Hxct+gOmGleMePXR0XYm3htcdgMLR
euXKZAh5PPTvpiYPdq0v/bnUn7qa3FGpglM1ocTL4b2zh0fpzsH4fekZqcopm0fz
jpBWPGIwSQU1gGFUZ3+IaDDekuND0Y1yRXCUrfSjdkIGz4H4H5M7VKCGBhdR0aoD
2Vjd/2u7hpQiCkoxmcdFLKHcp9r+r//XkdiyfPw702cqYEd5Xs3XRBpygPgMIMVo
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
4oQcCkkAUB6kK+kO6Ik5XVl3JbrdE6qNKJ/XTDBFk4T3nXHnTKWZelESXnCc6gPB
L6mG5cgu/65tSPchWj/VKnzqGEkoSQvuJdDvEj4odLGB8b47VnAzTqnW4FruP/TL
s4AER/2TZ/wgJbJbPRjfu9/GHCeLjPUMGnlBhIhjweX2yWImmtO4NrDkDhH6/bNL
JDNVwdq0CnNjuCcwJsAoh99Vov/UJNPu/9++h7iK2p05iGkTF/QrbqMuuM6t+Ufb
NsZJaakzAT8VG52aH11WoguA4klCq0VnTTtTnScTBIt0PsahgMzz4Q2oxbILTMDU
Zuza9jddBU74k1M9j5V6xptuIvrqvTrthZBVeAr2aupIul72jJiffGE4XKeM7Fp+
73RYlit+E7/NGSjjJOvGJkM43h5Hq3vM33fuOsaoFhg3UM5Vvlcc08PYu3A+ib/K
RRfVJPnHRcF5DPxU7ORdjjm9Hn/i7aA444Bh5Vh36FSJLxOQbg4ajBxGNXOHcbNp
dvwF/lCTReF1UTb38YS3X5yN8a8BQ1SzZ4naa3LkQkXtAoXCveknZDLE8ZyXCemO
YZ25NMppqxzXzpUM+vYgK2Y0IfQPmohQ6Zu8FTBtYn/E3uxIostRLnBRi5zpIpp8
dXW17QeHIiIFsih+Z00Xirfeum68VU2I3wCZa/95xjX1t+IvG0Rj9TeWSPn5Iijj
AYd6A+tdID5Fd6AZc2sOMXitkmNYZJNrosVVkADi2ijbsRIBYP4M+4sSrsk+jyC7
r6zALrvxIb/rYIUhP2mzwm2oz/gY5qSrfbvIC+8dC6Ym7s2AeuNZhSeiib8h696h
0TTts3H3ZrnS12qHuZHmh0NtWb09oEeuoDqo/TFa1Ne+zgkjqJ2phEd+/Nkjj72t
BWXwA0EgPDU3xuudOpoV/XmAUkFC9eawMov86skeIf4LHnkftEb8kGu/bPBSU+iK
x3H9aKhKFQmM1PvPi7Y0P/wACHfeBr02I/5qmTLLu4nXF1gTtiOq1Nyh2waiBJl4
xgC2sqYtLPoDIkeCKnOWtm3nTochueK7IED94qH4MxwX2GGciC4Tdl+5zQPHPGk4
4wnt56Da/Ff3ypNZzS+o0FvPIRGQ75oRk3haax+TEK+vbH/GkEdcMqTCcSk1up1m
6W7t6oXS0o4HhyohBufVEgGbC2NaPpIoKT6bGLa1Y8DvcZp0vUuecR9frmSu6w/z
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

//pragma protect end_data_block
//pragma protect digest_block
oAqjQTZhK/Gvh+1mFXElsVKv5ZU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif //  `ifndef GUARD_SVT_MEM_TRANSACTION_SV
   
   
