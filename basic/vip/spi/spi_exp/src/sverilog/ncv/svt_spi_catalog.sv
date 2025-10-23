
`ifndef GUARD_SVT_SPI_CATALOG_SV
`define GUARD_SVT_SPI_CATALOG_SV

/**
 * Catalog class SPI Catalogs. 
 */
class svt_spi_dwhome;
  static function string get();
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TnTrVZudwfO1UxGXW3SqZq6zbmTqcECQYG+fM8+yBPdAST1IWP86yAxn1JGZohEC
ynqeLk0vLXjlNJFpBfHrjkovTB/bHYV7cXgO2CfhKX3e5JIsWHS2nNZjA+af+8JF
95pER1RQqJ2M8C6k/s1FXPw0mYS7FYtqUr7obqxapcStpRa/auYLuQ==
//pragma protect end_key_block
//pragma protect digest_block
NzMKwcMIS9WWo3zIPyQ9DutfwJc=
//pragma protect end_digest_block
//pragma protect data_block
WQEFnPjrS3r8KdNffxUQXnW0NPerzv7tXzSQyDrFVfLlvqFNwQ5sTjiHvoPn+4Ac
ZqzZggBFfXGfoeqwiFmDjiSvrX1fg050UmusGkpe+XseCR5FdZiMnSmfq9kQ7yFU
DDGt7zZ/99vEj8H5mYvwIkl2kFlIhxwONcg9bYs1+6avkuIdU3EW6rjzzjl4+ad/
ExeDfieCcdrqxlqs6Gy9lsWdXrajrHyrx6O/z654PDAvquFaPKAKqd0zDaocEGEU
BRRve7GX0FeSIOiaXBP/HYpfATCcSXe32zXKwqhH27wXsVCQhZAUisV3QPNB/9qw
CtFUPDfNO53LOJwaPIV+QnZIsPg8VnNf533Qn9poycMbJlgOyatrifTfLmsI14/8
Vebx0l37N1jW2GPThE4fqZtcDZzRu8ELIgfTGUXNNpg=
//pragma protect end_data_block
//pragma protect digest_block
lRmMlRBPhFhuTp8xwZ6junKNZko=
//pragma protect end_digest_block
//pragma protect end_protected
  endfunction
endclass

typedef svt_mem_vendor_part#(svt_spi_dwhome) svt_spi_vendor_part;
typedef svt_mem_vendor_catalog#(svt_spi_vendor_part) svt_spi_vendor_catalog;

// Include the installed catalog pages
`include "svt_spi_catalog.snps.svi"
`include "svt_spi_catalog.user.svi"

// Optionally include user-defined pages
`ifdef SVT_SPI_USER_CATALOG
 `include `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_SPI_USER_CATALOG)
`endif

`ifndef __SVDOC__
// This includes spi NOR/NAND flash catalog.
`include "svt_spi_catalog.svi"
`endif

`endif
