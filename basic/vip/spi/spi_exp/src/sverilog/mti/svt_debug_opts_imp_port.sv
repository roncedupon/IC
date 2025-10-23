//=======================================================================
// COPYRIGHT (C) 2015-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV
`define GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV

// =============================================================================
// This file defines ports which are used to help intercept and record sequence
// items as they are going through a publicly accessible component port.
// =============================================================================

/**
 * Macro used to create simple imp ports. Used when there is just one imp port of
 * the given type on a component and suffixes are not necessary.
 */
`define SVT_DEBUG_OPTS_IMP_PORT(PTYPE,T,IMP) \
  svt_debug_opts_``PTYPE``_imp_port#(T, IMP, `SVT_XVM(PTYPE``_imp)#(T, IMP))

/**
 * Macro used to create imp ports for exports with suffixes. Used when there are multiple
 * imp ports of the same type on a component and the suffix is used to differentiate them.
 */
`define SVT_DEBUG_OPTS_IMP_PORT_SFX(PTYPE,SFX,T,IMP) \
  svt_debug_opts_``PTYPE``_imp_port#(T, IMP, `SVT_XVM(PTYPE``_imp``SFX)#(T, IMP))

/**
 * Macro used to define the common fields in the imp port intercept objects.
 */
`define SVT_DEBUG_OPTS_IMP_PORT_INTERCEPT_DECL(PTYPE,IMP,ETYPE) \
  /** Object used to intercept and log sequence items going through the report when enabled. */ \
  local svt_debug_opts_intercept_``PTYPE#(T,IMP,ETYPE) m_intercept;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gKCl1Aaf5R9c3FIZlhdH62bNTWA5iKr9IjGN7SFDezSOqKD/IlHReaW3szDB1dtz
BkVokRLQx9gSICBsdU6N+vAnVoEcXp1AUPtg5dKQHs7wvKgcREj+BEP7567r3tAK
q46UnmJw+q6BX0+qU7G/yvyjqmWxZUa7G0XBKRT8Dqo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 435       )
3uWbmwU6yFd3rf/N7NIBFrLhqNLemmHPYWWlQeIAZ2+Cy+bVjx1Lusabwmu6Rdzk
taZH1WNSsuVb4I0cpK779gWeefw+tTjrKQRcgYgzOIgUgttMzNftE44M97KuCW/f
BtHBHN85Vdnaq1yLkGOLfuXgFA6Lrgk4y/47iKdc4uZ5QlK6pNEt3bhG/8zWRvWs
nz2tWepj4x1xwnwU2QvPIeDRsQOowOzmR41WGmiYyP3PgNfqR/2fzr/chSGUCkwo
qYx+iwATRsTB0tPe1SY6a4LRLAsyktmn0cCUmuLiy16ttwkozb2Z/683OpGrziEA
kjE3yJbRCKuWM8VOtP305kjU0I8KiyhwWRHixemulTbGhXN8MR5/TQpoLaSqyhPG
QGMP6XyK9R7oqFpXVaQzs7JmSiYQ3F8iJ+v3QVsp8s71WvTJnIfoURuReFnT8MST
awsWBEQ1NgXm78EreWFBo0KqlD6mZvKZLaf5aWdOtKzx+qAstSRART+rT3q/MCq1
lOnEfTNS1tAc4KsNsc3cz45e2JKaVANK4c2mF9Q0OlxfHjFhRoqvxPyhKE4ZLT7d
d1DG/0MV9wzvIFB9tI8M3Q==
`pragma protect end_protected

class svt_debug_opts_blocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_put_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BAhckbxKl6kuTFQtD0UhQekQy5aY8sYp2G9niBrgOvJvf8HaeRISZwzwv2TYrxYh
TSm+lq/0zjxRjr2k+HYuotVPr2QBZhvzSr1e9gKWsA9GJ208B9f+gn8NdeL6qAmv
KyitLTr0i+D+ujQH4hrTpWKYfXP3i/3wyep1g6hGnh8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 657       )
Tr08R1CiP7OyG1xOxdntIhiG5iJMz+4G65U7UejALPlxazsGal0XiJiUoIn8ERA2
yj2ve+C5pFSBMXOZX061LYqE6yALIFhTYq6/HM4NvA/lmiDYa5i2oeJyZQsAo8sp
WjieQ5JWLsG4yOZpQYeHMjzuA5jrYwD3TtEJdRbGswHyF75glOIFyFcnuT/FRgAo
PCWKuqsDBLmiBNUoLO4WxWy4F/maLsg6qJ8yZayyyTHFxKGASNoA3DAnem/TC+wI
rQw04XoQgaHrPF4W252loUMmnla+NRlFKpaNusPHgTM=
`pragma protect end_protected
endclass

/** This class extends the nonblocking_put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_put_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Mv0r6VA0QUvp7itNPFBmYbrhjGgiCYN3TSngewb8USSsaNEE7Fe/W437bPDGhbOI
Upbh5g2LptuaZQrY3ijTxBGtQijJFIVGDu6J6Y8e4+JKSmZcMotLNAJ/IjIJjyAd
+1O+YBVeS/t3maHNVi2NgeRm7VkPk7WeB6fhn9P7kgk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 882       )
Ky2FDCRSjqleXGYpjLlIhBFOlox4vTvXKp/OSGxMgUTiF2HeVnK3ZEvO4Cfnl2MH
lNCfpP0Yjd4gOIa9ea5ekmbKDj3y9KwQdH9i/bBUrxhLYhRKSdN6sWPmY4/UhB20
uiioU74scY0OfM2P7cKKRVlctZjH50mGlH+K6tOZMzUW6aJEMyG3NCKULJvhlMxh
yoI5ZvT7MDbf5UPkPOZUq0KBakRDE5vuN9H6kt+RXyr12EjXAQKXEPrkLngnvFzB
+tLTof+xT7pmDjRf9SzIP33qTpi6UZWj8E9d77goD7OEwascBtlNYc5VCq/+GHOr
`pragma protect end_protected
endclass

/** This class extends the put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(put_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
J/eATWRXV2SkjLH7qrBJ0q/xsLn7nwcvv0Fx/mAmZ4Flde/VuM9lVIksnqwpDwiJ
Htb5AcU3dHE6YxKVw8FQrxjJ3ZLHXPBJnCg+pludtX+TJg47lCqhpYpK1jR6PsBs
RtZojUFdhn08AdtPgqCApcjfloIBTX2HtMVErlYAVzg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1095      )
faBPUPpQFmluzAmoIhOYBSXxujLGADaHR8IzjNb1OupiHlvucVVf828UpOqlR7d6
rsx82Xqqv0ghCGB6ATS/So/rqnxY4WMQnJkRB/TSpTMNgP7IQtdPLdNKJ63nyffp
FKpEn/igMDIGfOusnPKBHWFZbapilgVRVnYEkSvysF52jTvAxsG5VpHQCJtiCTB9
wGfeHDY60rRzRJXxYDudAE0quaJLoF98aMEghAaS3kpV20GZOCokNyworG9qEkQy
6D2DssOr+VMMbjBAG32yzDvGIUrTzI89pVzgcbyLHQM=
`pragma protect end_protected
endclass

/** This class extends the blocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XeMu/jxJ3KmVehK9XDClFDSVIxrgpXOe7a6VK4BrSGiLfHRX8tmUcS22eN+8bvRr
mVMztq0QmceqLlR6RRcTtfUW1L7+OKNZfe0YwDc+dgGDQ2Og3e4UcpWLQGzJ+MKQ
ydHInBRT9EHwl+eL9ExrBm7SFQIu3H8duNyKe920lOM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1317      )
yzUqCByU0HkXu+4g8Aee8dFdca0o6AiGrk937h0gW+LJ3BgG5vo9WF4gaG6YeM5h
cxZuEZzvH4nAykwgYv1NFOSeOCtw6LYsHWYARuRsgzB9I2By7CUstQU0iw/CaJes
3xCbp7mwJhpiDL75PGIJEQkAvDp9aNVpS/K6Oycckr5oN7JB+7o8iPr5M/XoPO1t
YM+KY6aoxeqyAtTosbGs64O9cUAYfmlceLbOU3z4Nzf+xOyYCWJTc6seFk44VwXh
70aqCPmVrWobm1eEY0D0T0ZyO+G3EkQ4TZqVds/QXqY=
`pragma protect end_protected
endclass

/** This class extends the nonblocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jYyAW8odNcb/gVMcdUI4mubFyiywEhygPVeSPhB2N2l1WopuDmzmnvNfMMnI4ReO
nicy8R6f6FjDbY1ta1ArYud3hBJIWjoryBoXi2xjS2WDWSxb/4sVyslHr+o1O3bc
U27AVWfIWxgM6mKE7cCkR08p5osT1FvpUsiocKSoJXw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1542      )
tTpsvAogWef1kIVn1lCnNuKQC1vHZ1UYEdou3ZUYNpc8V6PB7nwjGGexUaP8dHS2
2xOLiKHkl3wM03DUdGI5l9F7jxHajMAj7DpjDDd3j41Qth5AzagRyf3NBd4plUVY
YHHzBD6MisoUTUVcA1rIFabptPHrSHJz6J5CP7yJ8GBkP2dKqiKHXJonvVGl5LCR
ZqXhNfqpr8ZRqm3pxdzv3DjZaz0vN57hgPMdjjG4BH6BAOZH9nbBdn8BeuQbT6HB
WdXmgezOscsL3HxFPiTK4xRDLU/cqm65E9Dw1/ErfHTMaAMA4x6LuFpeY4jCyAmy
`pragma protect end_protected
endclass

/** This class extends the get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LmQTmGZY9Kh3eM64XhmD3qxTWxCeQOrYgU5Df1mfA9dVZhUFTWoA2o4uDS86Iu9C
KGFtuTJxgQrleBPjLoKMtll09Lc5ZA+fJZwy/p5YV2CGiLDqM85qBHFBasYQ4uI0
c98H6WTOVGgM5m4HhZWEK2J8MtWwVXRGxKBWldBkEEQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1755      )
Y0fE9Hpk1TAunUY1fSOWZ76NLjcsjmWFD8WPec+/OFjrHbq6xOCmnLTwFE99uz1X
bEEoSvS4vRRtogm9w20BUs3gjbaWaO20xbhatdBnaJ3+VD5Fmg4w8G8+MCn1SKhI
JucpPhwNkGPB6y+cWXKFVmUrXTVKTivgJyAj3PnBqGqlgGyVo2n2xDwPb7LrFlF/
mUtTa9AWbDpUMJnjQqEu1R6er5DRP9/4KAb6C6PVJJFxad1/JEEY0q+zlmfrdgA7
rlhdAmlhmsih7nrj43+Ij2k+gl2joLqh4CsyCvPjT7g=
`pragma protect end_protected
endclass

/** This class extends the blocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_peek_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UmQV2K2LXpq5RbjM8JvpExi8C5ul2LkB/z6t/EP9agWjOlQje3nrJf01ozlXWL9i
9dsfFVsH1PX/d+hMuHU1ekYU+9DgNtKO37Jjq0/vAp5cgp8Zy15zZzJ7KzHrFiQd
T6piHw36SJH5w7SjNh8W7j7YRFM26fs8LWXmX3jGCnY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1978      )
wCZG/cstPMg9yhlVde2lWwj+yzbAZJ4MR32I/+XEQ6V/undXuSjbjVZlZWwtnH7b
JO+pqtGkKNGhJscFw3QMX8FwYsSxMEv+Z/w2xFJQh/ooQmeOyEZrGaa83Q2a0Ifx
FKdyoDKLSr0Gjx8+RMTFShMqtFbX/nmnUqQgWHdt884Yc3TaJzNgUA47tOmV23mg
mZ4se0wLks87oN9olt3EdU6zWXf8Xqi8AoGHCfOtYXid5hSqKOxm6XE4Q7QIfrLX
34oY1CntY8cQfeFlBzi4ZfLIt7xCLFBKVvcSMenxT+0=
`pragma protect end_protected
endclass

/** This class extends the nonblocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_peek_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dxBDyPgosBraiVgRSBIGq6th+dbjO/uJxyhNF4/bKLbs5N7PgUsu8xpQfXRHPt/k
8sz6InROWsXmIBuREgHWomrFXeU8l4FgZaNP3QxVfd05Pg7ycj04ofnSPR0HtyP6
Rrp7rEkl81xUzizavZPb1uTqz7cdVA+QB+pgF4Ij784=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2204      )
hUnuemuL5CSG1i2KSJY93b5mfJswzjT3+ABGkabk5vN0dgTcKoKGymMKBHRvEDBs
uswS8IoYFcg05rcyw4IMoLQHlYfamUwukzf1VRjWazWLhAp1Vq0NcDbdIrjhB4YX
djncPOIuvMLs9Mfz4RPxZ0PHwB8S1CPiqGXIE6oTvIbrR2yt0Wscy2Jckd23mooR
y3teLySNAt5Quv64q2srJORR6UxIiWVomXBVrBL6/TKI79OhK8qgdmi7t2FQqrIi
50ILSdxpE46QhX228IHmQmbhXIVRJIZyMTy+u0u0NCtYUQ/I5VOQ1hiXSrF6QSWV
`pragma protect end_protected
endclass

/** This class extends the peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(peek_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Nf8RbMKmhUanlmqql5niLhpOuzmj6mpmd35qk9GYEfwsbo4QYkassL9NHgsoqhgi
dFmxjtftnyxOvLjTB/mKWCqvy6LGEZFXrvQMUWqYc6hDU7ZB3Svflf+QSZh1m9TK
Ut5ov0wxDpRe15q9oZjGVcUPUSLnGz9JIaREZdmv5o4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2418      )
WGVUGFr20nnEELKiPiks/9fCmR4MUfaiAwgORk2Fu9/F2PILCZtx3mqQiAI80cv7
RvfZ59MuXs92uk2RaPepsyQPLsvvvxUwcNtLGm3csQWJZFk5xFGHdyzH75hsm8uc
tybZ9jQBsSP9GlkhnLNlSxsa6a/mvjM2so6EugZsP8lr50IYrCO0CiJLr23uPdqc
WYeKLG2yjfTWKDM+pclJTCgGpL4m1PHPuJ0OlqQgVH7Bt9phTPEJGo7cgWXY6pMR
sId3WIrQ9pAaC2SQxUhbJgdwedp0clQ5J0O6h99F/bY=
`pragma protect end_protected
endclass

/** This class extends the blocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_peek_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kaMmeXpi/3QE0wQUPa4PXi84h+0gxgSGLPC494qfn6KDdY4DrhaVJQVhp0+JH329
/oi2oDg5LTJdp/mYDaF9/UMQaezCGRsdHdjJi0L3zhMS0RbVLHDNwMwm2dt1GFs7
0yt11m9reSexZGbYUb9slEEG+9wYg22SVDk42h1HNDc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2645      )
oPEXwteo0ktC8da4Gf0ylF9PZp4HEB4aO8byMiKc43CN4VxUqnU/Ti0P+8B01/zF
cu7lPkOJ+ZAiQlz76q2vZ6TJF4sQ/uLtQm+BJhFC1uGFmESbhTNckGpyfXg6ZnoY
wYMp65Vp4NBhjKPJYdU+gm6xGjgZH4l0rueBYhnJ4xEiacFIn7gBBAsdX0Xdlqwt
MdqXl9385jbDHw7201RTM5rRFxt9upuLuDooJXcAET6IjJN5uXH3yblwTb38gviI
8r8KYeeJEkTHHRanJEGr0MNobzdqzGEu6ekHKxWmt9aGWn+xdKivGOvyTlU7OraR
`pragma protect end_protected
endclass

/** This class extends the nonblocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_peek_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BtqRD8PuLZGHDGE5ED0cdrwik7m1ahY9JwXxCH+xq4iWpcDnOIEEg43TIWvBJZkU
V8A4FgQrny/f3QrG9TfyAMj7pOQ8onQfYlZKGu2GZHUrQ0Jwy7YDvutHPIaU6Aum
CezYRzR5ZzoZQUZlZus2ls7RUPURCGFopUD5lNHYlT0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2875      )
89btOh6oWAQaAyAD02L/AVUsNUebDxr/nluIj2XJQYUL2i0mo2yEV0zB37x62mmb
T86eEoDrp5yJJwaR+cdVWf0buCrytvtTOfdAyxXsS6kodTHgSWIUTEOPr/WuR5AF
YyDQuG6apaj0uD0l+Gks7w5PEnsh/3L8wrIEhhjiRU6zYKhcgIImBom23bV6FmTO
Ax6PRmsl5eBUEmbd9dfXYo/vE8BJdPyT1G/r2r4kt60Ks4Pn4y24u52ItC5mI3ay
PApqIMw4x0Tin4QaWIvt5MoMVWmr8pSgOt17MgaGurVNZsLqH/MJZhy1tzyo000+
`pragma protect end_protected
endclass

/** This class extends the get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_peek_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mWB81ntwMbLaYh+u+qTivoHxbuL+3EFJR2TBWa7Gf4WMJDbaAx+nwWqx0AtZirBf
aJPaTqA5Xvdn8o1erezRGyXd9MloJA0mlPJHWtbGchJSqMpPFDXF98b8SzQIt/r5
j/ww8WtAdroKT05FNHMZapzbQoR3sE/A2pvo/3iKjBI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3093      )
b3fPJrDdO4FDRkSW9/b/eeIxxElqTV1MCj3rVvwPKKYQes+IMC/zW88XzfH++bDE
+kuuEMCp04GiFaNz8kyWasgi9UGPEh0Lb6oVJSvNGWiyWf4mMUy4O4jf+Vh3qn5r
c/+MbNbpnOSr8WLQ5JtommPuE9FZ18jA19kWHcWxPNlwJU3JcUPkCbBn1bZj26S9
0pw6skaSUvf5mDuBxAKRK7N/78bTF/eTXgCkj/DGFFuSow1Z0K2fykV8GOGv1Cx4
/Yt2l5xY4RX0u+ghP0xp3RLj6ZJrRIzKh7aSR9igCWE=
`pragma protect end_protected
endclass

/** This class extends the analysis port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_analysis_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(analysis_port)#(T);
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VfSHCC43AHiUv9kCk2LaJJxXOpwV1MTXcgIbWQBUEQvWhHr8kLWpBQOzXCMZ5jMs
8+DS1T3QBMy4iDkTzyF94LgdvCiLyEU42PU3jIqbJ//K44QK2+d5hq4HHd+cMl5A
y4n+8Rpo0TCoF63wIuTVjzqAuzF2ziEvRkZ5In89G44=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3539      )
DF8mXmE6zcj60W5wRTVq5Nkm8sKgcvoAQilnS3lD96FgRqTvtkmceuAPyVlkt0Ei
jW4knq9J+yWaX17AozwgPlviqG/urB0pPEeKiYU08i3KIG9SUqv60u+2K/8mbI6i
wf6vo7vUjeuLNH/QTI7g0J0KfDAUg7DiVCeeONyTquA6KbatoCxVPA38ZWrm96nY
B8LduqNiL2uDv+FzGxRRGofSkf3xAPhzQmkr3Hb3h8l0IqDxDXwlbK7sYjI0tRql
Ad0n+eKQG91rnFmdgCrcJKFS6dlBIBjZJWMHA4Pv4BupVQ0jaBNNO0ov6AAE1SEl
sGxOoXR63ClL79p/iK1w43XfuSYPbYPg+FoHFycHn47/nii0yhs6d7PIQyWyPBy1
wAMfsxWnegiv5qXBOr29XcPaWH25BjK2K2G4dhjZYtW2ZQjIbmybuIwCEoqM2eBR
Pu4zr0IdajEjtLxpuEAwmvsX/xNYJr3xx3igmIVPODPtn6KzmpPkqqZgNIxz48tZ
Ts3gN8sdq30hpBJE3cbkEL7JOzZc0VGLQisM/4NzwsdmKn70mxHZoHY89i6aCClN
+ECFXdrvWla+A+cf1efT3g==
`pragma protect end_protected
endclass

`endif // GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
a6+G62Sssdgx4b6I5PgOZ5rBu7Wcjr0H3WEmRXrQkW7CLUtbgoNuqNDyk6OATsgB
aEyE8DtRUBV8a332DdMPfku+JAiAMq8e3p0XgTLG3w00sqp744Pg8NHHy90i0C3x
5rZ6YOMo/KQ6DtRLcr2lUmqBxbGDJ5Ljf+b/OEJXVxQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3622      )
SDd0+aC9KWlelgX/k4LCdIKYG/RSZ5GAiOEfFsIuPi8BHl3uw6wZ9CeHOT1VkQCk
5RQZm7ImwxLhUydHdU8Xef52g4r8Gl/Xkbyuz83JTATUwNEeyv4kxNby+Zf9JEeO
`pragma protect end_protected
