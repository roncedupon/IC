
`ifndef GUARD_SVT_SPI_CATALOG_SV
`define GUARD_SVT_SPI_CATALOG_SV

/**
 * Catalog class SPI Catalogs. 
 */
class svt_spi_dwhome;
  static function string get();
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WhL4Rypj6V5xmRVcejHpGqmRmY+rcE/NogYkNJlG0lNxRw1o9jJFX2NeGLbl9yaV
LzhWIAbKDyEk7p25ablQ1nYzQdrzRobTWERiU/hKNFfPSRE/nRQyMMRvheYLjPsQ
lnbwOqajr0knYhgFheNyw5dV0XKYAwpRWONGwDrME/U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 144       )
lZ1sJlQMJL5/3moZdLVbc9g4wMBruU8LJf6OWIgi57VpAYezCOGgpTofPVPEPKyn
bAxZcU9CR3sJsas9nLBcZwwVycQWw+9Jlm5SHoZqpunoc32RIonC63JeCIXd84jx
+qvS5FRT75AQWGTEIuQIPkzD7Kc0DqvxHqfIRVpFCSGLFvQ/ntFdmWTIcIPoJkI/
c9k7nMQGWXr/C9basoLifg==
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
X6YcR+Ama2kPYA4PUdlJWUxkO5eTn7KYaziGW2n8NCe+zWdQGZZkQFxaX5Qx15rT
UR50JSlnijRR7v8c2w4J3o/8QlvmSEQXyaCoGoXXAQ2K3DXK1yVwH2IMVvAiFKHH
77nC2fjfjMl+zLXU46t5JRQMMLlkW9bcj0GlDoKmi+Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 227       )
90Al+fwCaqMWoVNqYW0jZzVyo7/Ws16aARKB7nLJjK0h1qukYkXow8hDjasDO0S2
dyq6K9kVSJiofgWAF9wAyfP2JXnuavER7SOiGqRF3Uh/c1BoMqkXgNPpS64ipzwW
`pragma protect end_protected
