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

`ifndef GUARD_SVT_MEM_SEQUENCE_SV
`define GUARD_SVT_MEM_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_mem_sequence;

// =============================================================================
/**
 * Base class for all SVT mem sequences. Because of the mem nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
virtual class svt_mem_sequence extends svt_reactive_sequence#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
   
   
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_mem_sequence", string suite_spec = "");

  // =============================================================================

endclass


//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BKfqTvId/dxWDtgPKrtdqCcoM/7h8UySamrteWxkqhf5Kp6s1vgywTL3pZ87Gwvd
oyFU3Ai/fRvaWiRllKhmq+lzxPPUd+g8+t1cYiuk3q0WzisVyJIYOR272dxRU+/A
CxAx8sVlCXxfyzrXxeTBQ/HvWbYSCdS16ME0qAdVPsTFUAFuw3i+rg==
//pragma protect end_key_block
//pragma protect digest_block
GwPMFbic/WThM3tZE3SxdOSp6WE=
//pragma protect end_digest_block
//pragma protect data_block
rI4bnMqb8ku8s3kAB9ws6gecEHNg+20UXu1qj70/96YbZz9dBjhvjbOSANhsUw/1
kkh/FFhIfUYSXBxUVS3zMoXhKTqBkItOpRfz6WGsjzappQVueYSkIc4CyX8e4orQ
LmRXV7g/uvdchM83BPA1MQf0Zdl0u6Y7WlYZKUxTIakGPmxGGv8SlE8aA7EZw4gw
90UHGIs1xZOl4tyIJrJhTwzIcdJl8SRatpDGWEwQFwH/chQkUQL1GDlKt+yHyOBw
FYLrGlIjBy5FhLOpHilQLqBC+xHJVFKN2WpoTMllKenaRyfwze0LtyIAUhsgloy4
gXGtgKIW8+TCuUOCr+si5wD74zJJXpiM/TajxW7DL2vlhkgt0v43aoeXl/w4cudf
hUlvKXOuP3gn7i7CmXV7C5vMoacY1LrPbhH4zCTGSx4Wu7/EkutUe+IzsyJDgJQp
laaa++agTDB5nF2LetqvywQvetLNQJqf+qYVpMxVAHjQeZF2q+E1b7r5OZKHhIyg
GJKwsT981LYWNu2LIeYg6pmk1Ti6WGLKiRbCmhd+9QByljiLeLh1FIm2WkJiDsHj
dssF6T87Dx+BL3k0bC97eMRXqzuh9TS00Q1uIgvXFjC5xJgvzGPS4nbp+aBRdqre
tRr4dg74ymx+jyOaaWTiHbINl5AnH1OUdNs73pXFY+4=
//pragma protect end_data_block
//pragma protect digest_block
9ieFhROYHizSMe60v0sOugZ9Yi4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // !SVT_VMM_TECHNOLOGY

`endif // GUARD_SVT_MEM_SEQUENCE_SV
