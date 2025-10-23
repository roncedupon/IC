//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_BASE_SEQUENCE_SV
`define GUARD_SVT_GPIO_BASE_SEQUENCE_SV

typedef class svt_gpio_sequencer;

// =============================================================================
class svt_gpio_base_sequence extends svt_sequence#(svt_gpio_transaction);

  `svt_xvm_declare_p_sequencer(svt_gpio_sequencer)

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_object_utils(svt_gpio_base_sequence)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * Called if the sequence is executing when an INTERRUPT is received
   * on the sequencer's analysis port
   */
  virtual function void write(svt_gpio_transaction interrupts);
  endfunction

  /** Register this sequencer as running so it can get notified of interrupts */
  extern task pre_start();
  extern task post_start();

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequence instance
   * 
   * @param name The name of this instance.
   */
  extern function new(string name = "svt_gpio_base_sequence");

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cindH02WH39SkC8N0Hg8zCxyB42RGXdeNXGCODittM2eCZ/BrHbb9QRaw/NiKap8
/vWugEGR03nl1skjUIl1I0QJmph/+jdDzjfHStEzXgVWYOKc1BidEvfPqVDVXyDd
k9sBFe+fKg3qep9swIxclxRunBretb6six+hOKn0IjXS97TiK6sJuw==
//pragma protect end_key_block
//pragma protect digest_block
TLDxdg642nvgnRVJb8ZgrMYN4Fo=
//pragma protect end_digest_block
//pragma protect data_block
pNhQliVWz94f8Mq9gkPpOAb6HaOTbH0scYje+OZkh/72Yv68+3i2OR6bBbubjoxg
okjOlODIf5e8Q8NtMpl+0L5Rsx623l5Vie59h+YyppDOOfHRNA62RGUMV4x162TN
nDlgmy3o86kXtE3yu4K/LLuAT+OxIRT2wsEdC+JqzmxuQKAj0tbOLjGD/HFOQbg2
2Fl1YST9/UexLj/zK4W12bZrnHwYhIB80qM/0DPfR3C+peQAOi17MQsjTM4WC6Q9
sHy8tAlUFaZEVg9PNKgZC6eNrnIWDD12jA/CSZLkDBtR2YJ3u55xS0gp37dW7Sb5
Pn71UA7awU510U0a5rXukke5I6kBdypCKx9N4tTcbYNR8eiKfRaz/qqNUkC5eZix
J3H50xL/Qb36m8RbqQqUuRC1vdBXkeMqTNk2a4f0z5/A+oDmUsMAV6HjNdWeJoIX
Ny3oKWBXBiLde5w3zrf2nu4mC1hPTw/yN+cM57TZjgxSTsInDuKkRRIWUxXbJa8m
2mEHUI6JVnU6t6Gm7Tvqou74E4pCGCvzGFXNGcpjSmUmXFZE5dWindQyd2zQPhL4
G0cLTEsLddhmXyvssMMmyqbCdslViW5SYKjBlbjD6MOQP1L/osJoRkIAZUWK4d3b
uVPOwlsuPzUOgPTmgm836+B1nnI6Hygc684ES4Obw1J10wj/iRtH6LcxODjlZsEP
+za30hKCEfBkQ9rZ4qgxWiZfkqCMA8Sbd53ZIZvyVbwbyT9d/PDvEwzI4ubnGO6R
JfGMajjmdX5DBr6N92oIyepyJIUI1cnCsrjy3InjmVV+dN/XImet/2WX7NV2HI/s
gkDH91BslloXxkwntD/gBmobWo2//y+T8BXUTK9PeWDfw70fGTlBvjTBQlkoMJZa
/UVtrwJeCha7Ggaor7RVE7OfMTYXoW1aW579lAwWn4z5Zd1ZNU/4mQzUsOoXTN+3
X4z1NwcAcFiQyZUevEClVYZMpxr1+ni0UYEEN8c3+VAsy7sFp3U/l9hGcGZhAEie
yhsZyenbduN95m+4TxiyuXFHU+CojP5F3z50rI/qyMrEIWVhQGBfQZgViAhWtdx5
wH4GcaJLmw8UODO22MqeW7pwwT0DmJuX5ho4z05a693zhfPXTlBlPG8C2QIzWGJd
i538AEYBh6O6iCMsXOfRlPJHh4Nxq/NxhcPUDt5iy9Y1vScV47vtpizVbqHm502C
UIAb2GCQ2SCnlLnYP+q+FT/CiJ3eKWda3QYwlTcZRdzK7o6rv3WTS07SuwlUIQlP

//pragma protect end_data_block
//pragma protect digest_block
jiOSqKU7qzXYpageOnXM0wKyoSE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_BASE_SEQUENCE_SV

