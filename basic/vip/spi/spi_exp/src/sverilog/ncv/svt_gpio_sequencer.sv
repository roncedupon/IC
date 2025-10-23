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

`ifndef GUARD_SVT_GPIO_SEQUENCER_SV
`define GUARD_SVT_GPIO_SEQUENCER_SV

// =============================================================================
class svt_gpio_sequencer extends svt_sequencer#(svt_gpio_transaction);

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
  `svt_xvm_component_utils(svt_gpio_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pPSr+ux2gvwwGYs85nTw1KlRhZV6YYTjOGUTTtxt1/uPw1EFkxAXBxx90EUeCQrI
geKPYafbWDKjuvfLsJlo+2LEbfCWrdSvkipKdvQqWINfwKsVH1zdJNnlrF938w9n
GHCqyGRTJ7qQIts8nBG15efxGoozEpdzMkjr+l7XNeUeoM6n4cGvgg==
//pragma protect end_key_block
//pragma protect digest_block
SaRmZw9e+/8H5DxYE9HpWppAu4o=
//pragma protect end_digest_block
//pragma protect data_block
b6ePPJd7iKKAhLBmmfVCvf1rwcF265FF6xmDGTZ03P93QzydQYzxOA64hDVWJbRJ
qU1L0OGS88J0muYGWkz0OdRmBHxQDgJTD6q+Dm/Hiyz/0yGOJPjg5YbYT/0V/kXK
xSjjdq2NjogUFIG0CXI6J3waPyP7vFUfQANMkHLbgvA52Un2tzSgG485fWJY/oyC
y+aAOydf/na1DuOlHBBrTWv+7YEmXfHrw2wl0e2xCbq2XRqIZ7nzlkXO/9S7ilqK
wcyxCjEsVLIgBwZkT0xsXXg3LcN6imjJSAupVaOod9BILPWrwmk+HX7HNyaSvzOk
qqLgX+WULlptJzcpCMxcywGKbKqoKyrzyXR+Or8VtfAeQLSZ4hkhC9FEmLk6bmSx
ggkBEttautJLfy+LhAyOyuavAMn9sFQsduWdNlFbn14yCPGEio388QDyUGO0Qymq
U6iin6wDEO7EMSeS1vGbFnVJK9FTi7VxlxquckFQl00HbWJyyLqiUykGYEAiORhR
M92TifQ8fo6osRXz7MrpVjsn9ZUBtGGbn2DK5oSwJMr2js3G29VtGCxwJI6AsDFm
cj6gTqvQqn/OXBhws1W1zO7yMi5mETKLBe2FzGrlsQTY/Wy6TvcNd0hzQMwR783O
r3uqoaLkuo0ggbNQ+WXZptVonkzND4eQ504ct0BqndKXs/mJabiNxXSCjVWKd/gz
oOO3BEihYzKluJwpiHmn/3Dkils4BvZ3JoJvflVrsPzviRyLXraBXq+ktn80WPTe
RMTV8Eaz5VRNbMT9Yc02hU5dkdeaC5FPUZRLubyJn+GLKy6Fv7yTFl1kxIYDg/ng
YygFuc36G388LWtftkfTl8ENzEzMgLigV0+cbiHVWRgTmvVsP7XEud2Df04QfFYl
NJeL29SZwEDFGIdmagYkKAJbge5Bzn7o5Yz7QnNkBCf+37xGW4Fkk7gvErRqT5Hs
HJJT09cn17fAUNadfCz8W4HhAuO+q3m5V3xD2x/xdEaoDlqqdWjyEo+G32z0khU7

//pragma protect end_data_block
//pragma protect digest_block
j0IMJHra8Dkn4Uzc/YduuSJ11hI=
//pragma protect end_digest_block
//pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_gpio_sequencer", `SVT_XVM(component) parent = null);

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fNAgnHAsIno0oDq6zczr1lr5K4YXyI8uXRhiLF4Udi1NWUbKvZSbuYG9j7bsKRdp
cMU+4+9zPon/4ns17kaqK/tRIB/aMPaiqJySKZGg+dn9B4v86SSgnRBz4hfx53ln
+NOBCJFJNTRgT551zkFcC4jSmBEi/DUic+m64ehCasXKnEVl7YYeOA==
//pragma protect end_key_block
//pragma protect digest_block
O/3J4fmfzOLcVI9l7voB7qOllJI=
//pragma protect end_digest_block
//pragma protect data_block
6yJj38F8QnCdTpVwdP010YquJw4EsnnMycLRk/nzC93/3vrFuPLZDFkL7+9BeToT
A9Uk8WdD+cmrlJkr6dYGhd3oSZ8J6QIXYVEhwN0ZXNs+sTzYEQr+Q7hLyBjD8wyK
kR1INZy1z30CgsETPLXW5o0AZ05DB2nnZ8VcPsNtTAgFY7CLGFQ+/kALArMqPlYF
0nstvwTTQA3hPZk947TRlXVUocOEtF9eHwfH2EXulViZx7fbQmNuMXODorEcDxu3
4L12qEyIqatxiawWOkkz8c8JxNdxYZkjILUg0AG23cu26PATrSkO6+kwZ+ZghevK
gwom6eQ2aDVgAIqx+NwDBJebWE370yiJxp74RiqcpiDp2XzFy5Z/XKnrAjmfLnDc
qSPXfzPo+CpmLEtgwHbhSj4WORrtA3LkCbm9RJVDY2OGCXYH8P0Kp5kg9Vi6Plrg
hQ2TemYYWiDA+NLIJqXUTgzhfAvGYp+LtJDIDTxvcLefR9gu+eDe4OQ7mxheXXSA
I3uf8csBxRGDojBOoAj7Rp3ZdJvZODTCPLjO3L+EQfx+tvM8brv/2UKFAEDfPw1A
UyQ70J0OIDmbdD8zb3KycjbXHxjYZelDPu8GJRiYxeQTzom6fSZcG26S9BAwp4MX
okmQOaUaSZSSU8pMs6pPVWwqc9wLc5fWe2TuIhgbL0aRoi/93Xc62qh2lsKYUgkq
Rf4SRbTZZST97U31KV6iqrc7eWg09RM3w5RwY4rBBG9h3w9eYoRFVKfvzP8hVi8+
xTxBo98mNCrlB8L0qQ5ralHBxdmgO+9dYulQV3x1IOGK9svD08/0VEsHn2hYigR+
VYTdOpCpmtYbgEVGs2Gjz5/KyBApiLJLfdeOfplUbSOvtbmgbdHrR/wmJHhYpjRZ
2zgn7r3Ug6qZYq4XN4v6SgJ08GqAUNY/n/a1A30G40WDEFywMtmLRU7eQHU1be8L
880jqYdzuFeTfbo/OoldeU6820YSsGTZNYqD6sMUv8w+kxvnaAcuECPijYMZFuK8
gwB7Ql/5pLsZG3uZ3+GtQFNIqM1qbt0S8EIpXZhUbgklcVGWFSWLWbfnUMcX/aEu
aOAGlKma+ad7k5t/xex+0SnK9ghp40HnXYsv2Z5d4f94owh4i2e2lGtQarsfMhJK
rlxPIIQvpRRvVQdfdY4hBlUcPkkLhOYI/JHn0AjSibo4PrL49oBesXivgm6ceQRf
s35zozZiNV7/sjeT/TNGRQ==
//pragma protect end_data_block
//pragma protect digest_block
7pfgAnmlg7sBHBJDx58bhDPTCQQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_SEQUENCER_SV

