
`ifndef GUARD_SVT_SPI_CATALOG_SV
`define GUARD_SVT_SPI_CATALOG_SV

/**
 * Catalog class SPI Catalogs. 
 */
class svt_spi_dwhome;
  static function string get();
//vcs_lic_vip_protect
`protected
4+XM]JQY>YE(:JG1QB^F>TIQ[PCZIbJQU2OH=T>5^5G&K97IU9=3,(:9G8T/TU@P
K-6bOT@I,a+K>dT_HbPDI^GWO]@A3K[<;.3/gc=c6ff<L_?Kf)V8GPG3fa6]ZUZ/
R?1XH=.>A\Y/MY\DcXbcIPGW6$
`endprotected

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
