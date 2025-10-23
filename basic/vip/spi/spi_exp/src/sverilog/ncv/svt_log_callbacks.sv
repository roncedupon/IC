//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_LOG_CALLBACKS_SV
`define GUARD_SVT_LOG_CALLBACKS_SV

// =============================================================================
// DECLARATIONS & IMPLEMENTATIONS: svt_log_callbacks class
/**
 * This class is an extension used by the verification environment to catch the
 * pre_abort() callback before the simulator exits.  In the callback extension,
 * the vmm_env::report() method is called in order to provide context to the
 * events that lead up to the fatal error.
 */
 class svt_log_callbacks extends vmm_log_callbacks;

  /** ENV backpointer that is used used by the pre_abort() method. */
  protected vmm_env env;

  // --------------------------------------------------------------------------
  /** CONSTRUCTOR: Creates a new instance of the svt_log_callbacks class.  */
  extern function new(vmm_env env = null);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is extended to catch situations when the simulator is
   * about to abort after the stop_after_n_errors limit has been reached or
   * a fatal error has been generated.  The only objective is to put out an
   * appropriate Passed/Failed message based on this event.
   */
  extern virtual function void pre_abort(vmm_log log);

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Zcff3+/FgucB2X33O+b4svezP1sEA+vq7b5Yy2hY/oT0RKAwz2wuHv97DyDNyYpg
M9CkF3Ly14rLBbUA0U2UogR8sSH9VIpV+x+ntq1os/2IQCJrhm+UG5w0PygxE1bO
2N6ep+cd8Dq5jRnblwpoZ1DszfwkhYuRdN1ekR0GXvkLLKwPV2EjfA==
//pragma protect end_key_block
//pragma protect digest_block
6ovf3F1N5JsCNMLkgBTkoI5+3T8=
//pragma protect end_digest_block
//pragma protect data_block
gu1Qz+DnyLzVTxcjJYfvWIET25h3AiHP1ijb7d4V+jeUA3Z0qef1kG0bviJfXgog
bfSeqW+l3Qk43606P8LjGSRp5yuRs4rci4eCyGExyfBwUD+3y0oajRULIgWX5NJT
L7aMO54YpE1lxmfOlt3dBNIdF5pBHRxkJDVrT2+Xu+ORzj5kJ3nODAUGtoVHvffY
FLkCY/z9imMm1rgf5vtyuqrMayhd7wSWrfHKUpCIIkz2y3tRmMi+ZMtlt6FGIus/
GkxNCQv+vpH6avWC7cOlwB9kGKg6HDOX6ij9zhlUP+XZAQ3F391pK1CR0t6mgTn9
HQLo4QQTbPNoqifATQBiUFE7+nPh3Idll+ws7RkHv2LgRKLa5FXGVOci+rhvxybi
Py6WXIMmJFuHJ1XH4SYeTxAoq0EcaDgXTPll5I2/CoBk/vkKj7YYMwOYRmUiZaiv
pFLTaE8cdBu3GJBzFMFjuBbhhchSHND9XGVe7hm8FbBkr9ojiiglgyFLAgtILRyz
Je83XxMa2qudciWixrShM3VB8gGPv8gaXTDsw0AzOfiWvKEkfKwyUcQcHC6Rr+fd
YnNeikQ3fgxO+5Pyd1su+hqKwhqey3j37xdYsgg9yHVZqHfCG4l4EUGcBfivoIgK
OK43ePwzyNcTWdK8irIeOOurTIwwyBLzUJS5cIgKULH+7GkNI4XYOP7KQ5Vq5EHX
NVi0L5FmETE3Te2WwwsHr7SVr3Da/VxvGpAnbwPylQ3b0LzY6hnRxnXjx230mhMA
7iknS4QFBIDN9Qn9FA80ohpz4+yl/hzLCAE8GSve/JFfc6ebPqj8Ks+duetzeD8o
I31XDxdQUoBe0t0P8swkOiShx/lIeOMdzH7nxx12AnBxctX0u1gFAUZlOEIQXUx5
mbfO3PWMFOz+NaUG1bh27+uLN3W+DvMQUEAjrp44NQHnkghOcMcqN6lvmiAlBLxC
TRHlwgowEgGZpnXxIaJN5wlgIwclc4xeIJtGcKxnx32/cB96VkeCCFoUYDtfLjs1
eS7RBeYza0w6QxhhkwORIQuOqmIU2JtYgnWgJH8YtTY0EopLWw819yOa+yR5KOAg
QRgB3r1Byjh25i3InMLK+5XSoNFcbGdc2jkunHILGCymXTU5PXYIMcDylEOrnWt3
4c/f0SJhjylwanr9fGf5Dft+cybmJj2sGJq4fSG2UVaHa0OvFhgDs05HIi1IrIy5
l4BC/xRHY0XVvbTKAAsj2Q==
//pragma protect end_data_block
//pragma protect digest_block
UCFWbjR0/YWtXGZP1i5jw6NKr84=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_LOG_CALLBACKS_SV
