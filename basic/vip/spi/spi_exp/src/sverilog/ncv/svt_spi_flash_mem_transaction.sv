
`ifndef GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV
`define GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 * SPI Flash Memory Transaction.
 */
class svt_spi_flash_mem_transaction extends svt_mem_transaction;
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_spi_mem_configuration cfg = null;


  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_mem_transaction)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  //extern function new(vmm_log log = null,svt_spi_mem_configuration cfg);
  extern function new(vmm_log log = null,string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  //extern function new(string name = "svt_spi_flash_mem_transaction",svt_spi_mem_configuration cfg);
  extern function new(string name = "svt_spi_flash_mem_transaction",string suite_name="svt_mem_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mem_transaction)
   // `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_mem_transaction)

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_mem_transaction.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

`endif

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
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

  extern virtual function svt_mem_addr_t calculate_phy_address(input svt_mem_addr_t addr, int hier_index);
  extern virtual function void set_cfg(svt_spi_mem_configuration cfg);

 // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_transaction)
  `vmm_class_factory(svt_spi_transaction)
`endif


endclass

// =============================================================================
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
X+DmA9Agk/3xkWOSFZPuCaEsDCRxBCjh5xiV00mxGYjQDpU09cO8RzUDAkX/EIRy
jVSbdnUmyefwV+YrWNGGXsf2OiTTBOq1Q7wfiBs8sf8tR1u+bJTdiCSanj6pJEdJ
4Ue2qtWCUGbL3cn8IOFX4hV5sTQ+druIn6nDfSvAmK+QhbZL/Wgtrg==
//pragma protect end_key_block
//pragma protect digest_block
FtlxfWJsX72NLX0GfmNtmY+n8jU=
//pragma protect end_digest_block
//pragma protect data_block
HvHeqVFwtQ2SAT+YatgcLwIeyE2X/PY0m/MhpB1pVN3gWWCAy2A2eIdDDq5T1uRZ
rbHMgLkPy6K1OHRGdyQ2IEuBBO2VUQpYYxptU8Fq82swbbjtGfHVI4wnM3dy+0Be
leBQ3Ns6i6kdNOymWiN905ito2Vay6n9cKUVf+UVnShD1nVH9FaM2Uz6flPmCHR+
QpgU8pQtv0pwUNfKCe4wt1lyIzlSzSunkIckgoeJI90htackQFW4x+jfB2kB+H4f
CykAKIwpOts9tBoki9o2WKKWjom+LQMtxOK/MAV/qsUmxdMwNkd8Gu3FVJWRqlj7
pYb+2zDohcJZdrRHRpjs4WVEZoCT5uZrYbbh0wDz1uDSngnBqTFP/o6tteEZVJho
HwY70lGQkD+DhG/KbqyXY/7b2KyGhnuIc+KubC3A8OU5iz7FclKhEH9bzoEpVzpq
GAgZ24nwo75J7A8+ABxN/CiaV1C5zHp0vkGpsPOmyojfn72FP8O+ihOdlnAdkzKZ
jol98bgfZPeS+Bq+2SDJ29Kv1XcXGTqpdx/B8N5yHiQjygLPI+//FJdBsdNvbcp2
dstdHMaaO279pO2QIsb8ewmQFtNFe0sppCu2NB8IAnuV/oEIW1haEEXuweQ9tDhi
Tx2NonhBc3q6Q/LVqekxX+MTQUGT86keOQ7PnSs16TMrWLbJMGfQIxmbO/10XgXV
adCB63pCs5mTPdf2hgmMQLYgvk2FA3okkK3/yMRF84wKEQk75zI+x046VLwVx3XW
6TXKCD3rx4oDrWCk/Gtz2yXDVymkXRPQjd6Ui4s81S9jilFFTYlrHMImnZHngKCg
pITup+4Sx29zR3qzAL2BXvF2K8Z4JahfYnDn9PExw5/TBelaEL5/OG4xJelE3xtk
k7XCiqiL0VDAbmMtMr5BkgESNAZf2FjeZ/7o/woYc5HSj4u3qqZ7ZDeDCyx9qDY3
cyLGPqhVRrsTj7LLRNOmO4jpXQRwQIfOiF/e52weC6CjmO2o/wU8Sv7b/Qh5FKBC
NAQ+I4WECCT+Xu1yXPXBpy+0n6oh4n6RRk95Jovq5936DrcKWkcCtF6a/t3o+v0I
0YU+TO25agrEr7AGcVlsEsMTdlXWwmDQcW5h95652QMHmYo3f0GVm6/3vk589pH+
95A6FNHFnlebFE/4GO9+S6azELBYscR/eXgn0GdOe1EtyK93pcYRM9y5rNB2v/i+
bhgIhwNBJp0AfpD623FFAUzQjYi0+ozTfqVP5N30iQ7pzEude4i1IDrq8H28JP7o
43HJYa6APtQGS1KCy6LHVLpP8ARBOPmI+YgXY8EmDSC6gOqx2/wdgaixSx89hKCD
rmLCp2X+m5dae5z3kcW/9891Em5l506I65/CNh28HtzIC63iauB9hB245CFM0RNm

//pragma protect end_data_block
//pragma protect digest_block
cSlVuFiQvtjb/Pe4DS1tiDwGxEc=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
iF2DtWkkNULfde3BF2O0l9T+nwnNNehWmK71gD1G/sP0xukusZ6TycnC1C1m9uig
ersBtI5URN+V5pnLKBy7+M6LHahdbxU4XuEKsNFTgYoZe4Ya1CuT7YLmyIgh6cpQ
z4xqZdXqhklA/eHBFMGllO+aCHk9hBqY0pDctbMxGO5oKFRKz9b6Hg==
//pragma protect end_key_block
//pragma protect digest_block
gXzUnzloDIvsL5RKn5BxthFOhrY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
5gU5wyvaqlDAj0g076N3f7eCIdY=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV
