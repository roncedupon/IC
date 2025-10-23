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

`ifndef GUARD_SVT_MEM_WORD_SV
`define GUARD_SVT_MEM_WORD_SV

// ======================================================================
/**
 * This class is used to represent a single word of data stored in memory.
 * It is intended to be used to create a sparse array of stored memory data,
 * with each element of the array representing a full data word in memory.
 * The object is initilized with, and stores the information about
 * the location (address space, and byte address) of the location
 * represented. It supports read and write (with byte enables)
 * operations, as well as lock/unlock operations.
 */
class svt_mem_word;

  /** Identifies the address space in which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace;

  /** Identifies the byte-level address at which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_WIDTH - 1:0] addr;

  /** The data word stored in this memory location. */
  local bit [`SVT_MEM_MAX_DATA_WIDTH - 1:0] data;

  /** When '1', indicates that this word is not writeable. */
  local bit locked = 0;

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class. This does not initialize
   * any data within this class. It simply constructs the data word object,
   * thereby preparing it for read/write operations.
   * 
   * @param addrspace Identifies the address space within which this data word
   * resides.
   * 
   * @param addr Identifies the byte address (within the address space) at which
   * this data word resides.
   * 
   * @param init_data (Optional) Sets the stored data to a default initial value.
   */
  extern function new(bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr,
                      bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] init_data = 'bx);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored by this object.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int),
   * locks this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked
   * state of this memory location is not changed.
   */
  extern virtual function bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] read(int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data word to be stored. If the memory location is currently
   * locked, the attempted write will not change the stored data, and the
   * function will return 0.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data word corresponding to
   * that bit position.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int), locks
   * this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked state
   * of this memory location is not changed.
   * 
   * @return 1 if the write was successful, or 0 if it was not successful (because
   * the memory location was locked).
   */
  extern virtual function bit write(bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
                                    bit [`SVT_MEM_MAX_DATA_WIDTH/8-1:0] byteen = ~0,
                                    int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Returns the locked/unlocked state of this memory location.
   * 
   * @return 1 if this memorly location is currently locked, or 0 if it is not.
   */
  extern virtual function bit is_locked();

  // --------------------------------------------------------------------
  /**
   * Returns the byte-level address of this memory location.
   * 
   * @return The byte-level address of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] get_addr();

  // --------------------------------------------------------------------
  /**
   * Returns the address space of this memory location.
   * 
   * @return The address space of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] get_addrspace();

  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this memory word object to a string which reports the
   * Address Space, Address, Locked/Unlocked Status, and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_word_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this memory location without the key prefixed (used
   * by the UVM print routine).
   */
  extern function string get_word_value_str(string prefix = "");

// =============================================================================
endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QUzL2n0HGlt1rdQqarPFwI2+qiCMjeFGhw/0PSxgH831+jpC4PzBf1Tn3WVuN0xF
SlIUfuCsl8OkSuuylMePQk6eIg0mmscc6igQfkhKO7harm+/AHYIakH+nboSGBOb
R87ejf31JPuEpvw3vbzqYKnwLP1Yl6dmM0YiPBgpxY0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2723      )
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
`pragma protect end_protected

`endif // GUARD_SVT_MEM_WORD_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SM4RRkJPy1/mmKgEVMZb0mvl/PmJvqwN9w1Hn+Kr90SVKF/PQMmapJEqHZhjRnNj
GS0ILHYlLhHZP0VPIeTDY9RDk30ThuY6CRx1lXLT3heWQlm/lyqXsc86iMj+Xf4P
wn1DS3CjeWjyFUeyE80P3g8/5yKpuI+oarDbZ8TsvGo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2806      )
/jFg6F8kqjIfaMCiH7RaFBUVCrEU7KBZPWrv4fewpI8V+oIu/XORPQLT/KU8gb2N
YAdmJHXJ6c4gXBWBGHaDCGNwes4Cx5393GDMoEsbmBTODoNjsGiBBjhyo+IaYzr3
`pragma protect end_protected
