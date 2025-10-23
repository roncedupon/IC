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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZTKQF7B9fIJh7q34H4smwM7w7jZ32XkKQLR4A7ShTNAbryQMZi/8oszDnLgmBae3
7v1rWQOP4b+6ttx60PqujWo9cGKvYZU4QFJzXPqA/LvWF6qVSZV5kSzaOfoyiC++
eHvNtnhZTXUoiIg4I37omEmp+in3gFY3Vajjyq+hGmA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 600       )
JBNOSBJLV7YROGVsUX0zTmPyO9kouc6RaVR3ahKva/hzsNCBmHXWq7LVNwxwaTb4
vrywtIwSa2fM6SV1xLIiJsQWt/LTg5Ht9mzLjDQi9jwBoTsKcW5/tyq+4JyaYWFQ
Jp9uaOGLMaz2dKWQcwvNJFnS/xNufcqwF++OERMLRHp/OyE310vm9BAhi1zGLG6R
qYIGUJEhjuuxRsuNCq0Rvr7QG/HRqftE+OGLXGTsKpD4hm/oXgtGdb5n7ciqPoBC
KFXv863UYovFkDVWu2crdxHNyKr1/dOME1M7CGeJ635T/CZgj3W0/ZzHWqPgKGO5
6RaowuZucXMCA4h3OcReIzZchJJiqBfZeMo4lLGmGvjHO1AxN6TWrn5evYwnTpJb
e+ldwAD++b2E6CXhYo7+nHIdT4/AsTMAishO3+1+6DagS5gwWvMNfLWHc0OQxOoA
q7WGSEJdfd1xWIigHyHhgNVmjhJYQEKeQ02fRRrqaK6AMVsf0f6d6+AlYt1YTBe2
OGcsunn3JnjPhzP8fJakZm/NhoQea+E65zSOzTqec+aUW0p7OmO/0uEG0JK5P6Kd
OY+A2c5cLJcG4jWqgA3bfdlUKYnCBeSoeVEq52p9sFHWF2/4Od1BVh40WMGo3ZAD
yz4yWUzSyZQQ3eyDeuwQ+D2SJE+O8WPui8Gl4/Y+1r5AXjnGMRHxNboxmdntWiQL
lOAD/tZ7XHxPlB2oWqjhLoVNmrRKTa4632iOV16py2ceAc1LGr2eRP//5mQItM5m
wBfWnpA3kWyiKkkZvzaapiwHxkYyW4giBdTUU8rQdzQ=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jgzFXaN+u69zJ9Mb6L/B1k9Bvp3WCEQqNQCCzPmKY0iLt8KHBADLsA1xvCNh3TDI
Zm4vJ1J+sAjv330JtBLY8e5WntGzvRx2WLDh9sFomR3FNIFTRpuOQwFiKxcUxPAa
LO1365do8YDpIMVxTZvkdhB/FHqToIHWfJLbIPFQKRs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1362      )
sH/J0q145QcVpS5oq/Xdv66MC+i8nwi2vYmvzB92a3/NLsXl3irYPT8BB8D+93Jr
WP+xZ4KVt1B5sgKGk96L74Qz8m99o/0AQ+D9uRGJqtYbUIm8dikmWd5OMy7WBj6u
cng57e1Mmd00aPT+HWfKcF6FKkI6VO/LOgU7F3RXyFmW0ZZzQIVq9GBqPNgPDj1H
Px6NRTKnDsEc4CRl5hrMZ7fBy5vgC2G8sKf4m5N/yAvuLgT70H6zue+PyBFq82xV
VyRgq1XmfOdi/USKV/+Ha6rvMee5n/gmTW6ciKd+xqz+VqiUsMHw1G8ZqcyT6cfD
xJt1MJ1rlTd/Om8dMXoW3cqjcV2AK1/resMfkH7veHgteYsbs9KxFh9G2BERWmWW
aCXREp3ej6kemqRTcykv7Ep7uSGw8f57ysHoiV0NerF1XyfwCwaENPcyINqZCkHZ
nfNIyu8whCbH61+ov90oztS5AsFZoosqNbk7CPV3nZOsmuHPU/xKcFTGOxJTxUgA
Eoaq+JFjm4MF27OWRHj4vcRKI66sBGLD5TwBTKPYmrwMKwBujqOlgZvbcthC5dvZ
NzglrsVTzswgpIWGFbZ8TxAW7eYDibUmOSnZeNL1yoV5K7V7YToXgUdSlYvciGGA
ZPfb0u0jvhnxrgQYRdguWWRnKHJ/nO1f1rovQi22Jjza3HyxazrNBcekmnyll1oJ
C634XlcBhc/QFYl6M2PS1eg/kr8kkzGjbZ+uhxYNZ6DUD0xCDlOnaLGiy2Eg57Xs
oh3gjoWw+RS9/lbTZq+tDHIuMIdbacTM996+eFV7YdernyihULiRd5Fk65AUkgNd
oh4OajWFgWZCws41ai8guH4GlVSXzSvyd5kKI7berapX0+O9U6g+5E7XeVtCxmGG
eNLKmi86mejP9oKSWukYrxRSKShT9KHja7GhyorBIFQ7DpXgcoTcCuQ1M6gojUwq
Tej6E/iJ4WDMd8K/Hjeiy4ye5XKIASI5iiqcQIq0jG/tOsR7Df60Ue7xdXk1WXrT
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
d0IUsHnoCKaPpBkp0QeZEszarwIubqUzpi3deOKdNbm2/JdgITXXvkNdDjJ7HnQ1
qrnkrAr+nrn3zNkPBH+BjLjtx19KkrjCtr4TCw6ntSr1G2DzOvdi/0KhNw4I6/9U
Io9rVZ7SrYDysFA54N0XAweXppe2cUu22HkxTnngcw4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1445      )
aTMv75qCIdJme6xovDlGrrsq1wh2TEAIjKEplybiCLu0pzzaE5WYeAo6J/ZI6XXM
ae7nnGtWr1XkrPRcdrh1jSe+6lzrvNRm1yLak+DaJvXgpKmxD29/R6Ya+R1T+Jv3
`pragma protect end_protected
