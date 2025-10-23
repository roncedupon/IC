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

`ifndef GUARD_SVT_MEM_RAM_SEQUENCE_SV
`define GUARD_SVT_MEM_RAM_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_mem_ram_sequence;

// =============================================================================
/**
 * Base class for all SVT mem ram sequences. 
 * It is extended from svt_mem_sequence which is a reactive sequence.
 */
class svt_mem_ram_sequence extends svt_mem_sequence;
  `svt_xvm_object_utils(svt_mem_ram_sequence)
  /** 
   * Parent Sequencer Declaration.
   */
  `svt_xvm_declare_p_sequencer(svt_mem_sequencer)

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
  extern function new (string name = "svt_mem_ram_sequence", string suite_spec = "");

  // =============================================================================
  /** body()
   *  Response to request from mem driver by performing read/write to memory core.
   */
  extern virtual task body ();

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HzT7pyl4aIxjOwI274RWbyYpGLqueEIthlgDz4kLW687JIVggwouGtCTA/uO2BvZ
4mnB5gJsZ4BdEOTPN03IvWfbTWkXQLS4iVDrLXmgSbtKeg3yLAkTvjRt06WH8AMX
QffA9My7ZpW/x4CxHwLaKB9jNyJ8pzxnHxUvUuaSVN45tOefUVeOew==
//pragma protect end_key_block
//pragma protect digest_block
dKulbthA9FfVSpEfzYn1V+Ph/OQ=
//pragma protect end_digest_block
//pragma protect data_block
/ls3OHAVcz0X6z0++XA2gVCYqkEmYJpfPobTatjpXb8NsL72JjU3WhBVIcqoW/KT
WPmjki3Y+FeErSV+gETzugtR2yuwK11gghJ9oJ3vaxdZo077q/hMZ2ciM4EmKqDm
fLUjcEV3bdy6ZPc33TOmycCWBxNSRst0uzkSFJMxWFhbvHCV4uAK7fnpt00t4Zz3
TkKipMtgIgbTNX0mpuPNGuZNDUV+GDAHOdeJam1v2x6tyfO5cQHYdmHkk8oyzh8V
DuhiLUKZrjv/VVExZThx7BICppImLpL+m11Tj38Y2M1a7mc17LGKaHiluxH5vnbN
Xdh3nBDahmh5oY1ZcDieypV1ldu40LceYVkuZvL8//+eD+R5In4J9e7hQpV5aXPm
kfPZLNYdD9lbRBlSi3FlP/bn+lSMx/wk6Bq0LTRCcC9/EepsfGAIU4PJQiqnRY8p
OtLHhIzOkkmlom8oxbPGUD93qaW9mMlG1/JSPiR5xYGeZYuj/++UGXKnkmoZbQFY
wZZc86sGkxKBUZ+DQeU4ixZAvjOs0wRKXnH8a46PAvZAx3kZTv/n9v0uP9WJCzx6
sTARNKtFXlRiWszwsiRpoid7nBoR1JC1JEcRMHxER61DMKJ0sM5w8ngixOKwkeI8
R6OYvrWsgaUIcxJsjQ2RQqDjLPsZfXfBL7uT3jhUe6JTU+R+RLwdFWA7QNMTB4aN
ImWqlyu/JEWuWafj0ZjKk1JgoPIo3fnfimrikH8u4D57eBnUPXAPJ660qIXCpUC7
G2XLMV68tP9j4KB4Ziz68HgKhfmDvGPVCzrYsY35Wfgz8szusn++pwWCjqnzxBev
ZC1kFJbPYSIGVHgQz1I399yHKQf0FilV583ul6ojkQE/dAbr9hxURnGNPhSyKWYG
mRp36sh9QFLEwFAJXdNMiNUeegH7hlvxRIg79wIVnLQD6C3i1mP2dA3ttVly5soZ
SFyH5bqjM3Bmc9fsiMgIQ8g1S7oHQCf2otFDbl1Edj0XjBvSsVmj2UWHO255MTt+
I6pZThTXp37Vtk3M/WTV9jl01rUwENJeKogsJQl/hx+RWF8pDXg00MdnBCpuj2/B
vlNTukbk1km+FBl52DzRGNMjXyilI/0kGvjnUAhZmb1C4vdS/lkidEy9FuQQ9/6N
kH2Ei5qgIK4KgNLqU1nsKWxZfgeASF/HYIIEXeZBQ5mr94eHseyhH97F3J8ukt5m
+YSyliXVWpYa0zMEg+CLtlS2lFNjjb9r4vwFIurrAGdkyCr3d0yNsc9RnIE+9YSL
w3OSUWhyxy+V4xAgpSdnox9CX/CwbmNfcQzkKkplMZZ1sTETSGXJ5TUumRG/rOle
g3T+9+vTvjbVCUOMKgq/IfyRp8szyg4vGAvcGbfO2pI2HWZbW5ly+qJzhZUOBqv4
8aATkW9EI14A8zQDVl6XSOWDcA7p+KQubPCkt0Cmaj2hdY0yltvgJascs/yzDuAu
qcEFB9PiUSftGbeWI2XuS04T1IrTZ5SH29LXpPifSrKPCXNMGoX3oKrzmm5Fvx1V
/BXQpaKj33pPbqiGMkOLH4q5EyNC02249FdpEV4Jtuq3qRndGSr4Azqrka+XUFi7
q4WEpbFyhTOeki89oQzJ+OPbjFz+cOBwD1vxQc4jaQhScPe9tzHYohPwnuwgjC5E
EO3Ktik1cie+lckAYY3nwk0gIa/xMxTMcJ+5GsW+aMM=
//pragma protect end_data_block
//pragma protect digest_block
RME77aDP9Fhg0ahT/Ec7CjvxOHc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // !SVT_VMM_TECHNOLOGY
//    
`endif // GUARD_SVT_MEM_RAM_SEQUENCE_SV
