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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xLKXPjPZAW1Of0HorNGe4skQ03yvbQgUyLInvZBlMshbsce5ukJZLDPLUhNc2kZ+
lHR/VZwNqczS1WcjTfqu0cVFsz38B7Cu0ckWPgu5COwangu9NsHt3gdI9KFx6I/n
o78DJc3LQDgSPWt5UkGAHV+nhPMA4HWPS+/xXF0LiNPZRr8Tq1K49Q==
//pragma protect end_key_block
//pragma protect digest_block
ozpATPOYku2t058P/vi3gCbPdA0=
//pragma protect end_digest_block
//pragma protect data_block
ixOTz4MOGkjBsCzq7dpqMRgNSe40ugN25pzbbtasoaFmq3JyAJlC53P+bW6fqo3g
IvtCQuzcV9wntlpWkyxXXtiAJcawSgsHE2hXPiaOujK7LgscCzG6i214dN3CBTMQ
b0hslHPVRztjZNLym0pFP/zt6ZEo5O3WXoDAcDJcN/rrTp153rQb5mAVBj/7Sxva
UmmpgMOGIi770zjvXoFJRjEqiVzaUqWoum5x5LjJA99YMaixfBFtaKi4zTwn85FZ
jnKpqzWfqEK2iGgsRzqzqpjeyPrbGAyceUyUGG7MNZtuuUXxovBrlSOby24u+UVG
dNuHfvEs22Pe/cK5puRJEOnyfR3EATthjLv3EOAYKekGLW+2b5YWhJdUxH297Rjl
iLOBk+v8sMyIcMRe/8H3R3HQSnyl9lS4m/pNMPAG7OOEWfp+sVc9cyNsYP8joE1u
+SSWXIwixKDR8JSlDuHrmO/R+63XkXK85qyQkQhZZYWrGpxWElZ5kQej1JatPWZh
/pSnMb4DYleKAyTE84j+c+NIBZxjIRybe5j0K2/EyFhygQmTdkgp1o8s/b4nOeAr
ZbZ+lBglFj59PFpMgVEleNu5W19APqUUKzK9zpOPwvSbiefUGf90cwRr1KWlTBRl
Onla6qgTr274lSaVCti3Nx6uJ/dViS109YqNmGt7fwTpdmuHfgRvsd0kJRDuay1T
6WtLtdI39IbVnszGC0hbvKxVzw22M1Fy0ZJC4O8fF2FyXonqNy9pHiqmgd/3hPf0
9+f7fA0IBzAxCcz65f7mmrm+ifdKxAXfMuAZokxu4Og=
//pragma protect end_data_block
//pragma protect digest_block
q7Ai5PXUmDkThk6YZsaO9S1VpV0=
//pragma protect end_digest_block
//pragma protect end_protected

class svt_debug_opts_blocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_put_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Ml1L3fUHiWfpalPtUsfhuKw23dGqcgYLwJDlLI0JoNUUvyNw4zQPuIcJNvjT4xKG
QLm6zJOPA9LEUB3LtlH5r2EBQFBQGqn8pUdceXmMql8fLZOXBQZ0XdvXAzpAr2aX
QZC/6q4PsfhqeePBkYgSMHX/aiEMsASiulA0hWsDyArL2gIPiSwabA==
//pragma protect end_key_block
//pragma protect digest_block
J7azNgOCiNPbpOJ2J8gjYL+kxb0=
//pragma protect end_digest_block
//pragma protect data_block
vm/L1gp9aG8c+SURqBkgsmxkHQXy5MwNa9uXI2ql6JouTB1BoGuZfu+I3cv1uKP0
FiadIMM8/0NOh6p5eB/3+2UFq3qYBX4HZdO78nXavLg45opdYL0arvIZoor54yQm
2Ptx33B+7XPGzYxLvUURUklpJP4Yyy3/Yon2b4jA+eQ7rYrntBqendMT/I9dMvjC
FgyFViX3AOHQ8OLdXjq03vijJzT0WNJolXPNkc/5TEzTFQ3orno+926dKPebiV0S
L69no6RqXlCGQuJVPAw4Pb3vAIJW3P5tgZ2AmsFjM4GHIsdNs86/Bb2ORlz3Ytlf
niIReCq1NGiSuuWhk/t7CENNarmKXszHNttJmf1lzmwyJwfRLhDQng/+IyoeKIFO
eX9fHOWF4lNye1vo+189O3BV7HCU05LjcsxaWfNuHoc2Ay5vDYINsapWx1tHb4I/
vand6dt5NjlVOjPpQJCPiDeP07bj8QvBTF0VzjzGzHsYM7/kN9DFpGp9eGu3mvxk
JWA/uQi+RyA3mUbxJWA4AA==
//pragma protect end_data_block
//pragma protect digest_block
SQ9KL42NlVKoSNlC1orojI6Dku4=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the nonblocking_put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_put_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hPpMWWO8mZjye8uuQyM/i5Jjzzp4TaM8hjqZp9Gp4zt3RSXHaBJNdiM7ungToUe+
WYbUKLqoowjZXvwfQ4DC+ATUS83xS6Tu7UsdkK7wlZk0vvIHmj7l+eXvmLouwvKp
34muOzqawPPG2kcooAtdhEPMIytKa9Ej6Bw8X2aUtepryZURAEikmw==
//pragma protect end_key_block
//pragma protect digest_block
u6jGFKTAec/rvtHxS3smUqv325A=
//pragma protect end_digest_block
//pragma protect data_block
oi9ZhVjA3Jb+rMxHLVKwVxN2xjnqK82gVfT11cr1R43JgvRBX3Gqly7a5i4ETI34
qIlgl6GjRIglBGzb8DvxKGZi3Nv0OBxRaJENPakqIHM099bGL5B1KWI8lgCXbSan
JvwYtkv1MCFAhacTk6OahEhpw3/viBUKjuoSklHHsMTwVSHaeJBojby0RLjBDpxy
NSIGY18pWg7vGkZr20LXAQLSzJG4aSBQx34zfoU9f2GX9G9oOZe9v1l/blsfiV3f
e9JwTFwTeigLftAij+LW+pfpQ8dswPuy2vbUz4LoEphdju2n9hpNbQ9Ms7oJHF+U
X2MSxe1SFkO2P0MnBCP8aAIQ9NdJ03FSgI/fxOCWOLMtbFzMzaWIIAENOrUXkGDF
KwqMJhH6FztXMtYnMgUvMWFYeBiaUIXGqt5wm/yGuPH/Ax/+5BsqnZAAOJrEd9zF
OarrAcxzZAhshj1dyTINoD28vIabGG63hnPaXstS7dHG68IfK2zN9GLEDqfg9VPe
dikyYRsNNRY+joLuF9jRFg==
//pragma protect end_data_block
//pragma protect digest_block
Zx93cfqzpgg1vk8U9wmAOjQHL5E=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(put_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Qal3fJYibC4obDijppqoBwLPBDCDF9uEMHSoGMKS8clqIovVXF1fF2fGQwbmeMhk
TKvD0elJ9eurvSOrggklydmutSztyrPgvGL8oL4O7zGDVgFLZ4M+OnRu4NPFQSAp
SnSPps0HccGyy/Cdbu65bOHIghJM53xTFNgUB9H/I7gwfXUAccTD5Q==
//pragma protect end_key_block
//pragma protect digest_block
SsD8d/e3jQyIx+OgDbEGJvioWxM=
//pragma protect end_digest_block
//pragma protect data_block
CM174BVW/U69486mbrEDaHSLJQ6RYH6PseJH+YwdjLHUXKZMiZymYuWBT1dlOWLF
iGDWxrIaKRkD3b7tn/9SIUg56223uDllqUlCEIYoNS9Rkot8rp7NtPgdrVDWUo1P
B8EFwjmRxsQcvxZ/jgIF/sVV4FEVKW6EzB6SGaALf+LPhEZTak7bz22QUSrZDNz/
JSuBmtGXMd2FuZ7ZCDYxE+1vsWPpGoDN04cVFx1sbcwEz4nsRXk5Iqp8Qr5yk/4o
/7Kv4GYhqg6Tg7lfjk1mb18DyRsqLMioUj7RX8/EMbyWhQQHHnMVMubzgE9SUCpX
LCvcdva1hiFk8McZ44XROvR31R/B3I0JIaUXxGEY0fGEl2pP8McOOswWv/aZ498k
+f9a0M/mFc+f226DluNjg2aFYKZ2GOIY5wsQd+LuHLRpaklp32x0eCrq+70eKgCK
1Fs9qOfQRShkI+2HdXBR10ZTZv2Q4REhgrPsrj1GXrYemcrN0rTww6xoVHMBI87j

//pragma protect end_data_block
//pragma protect digest_block
og99/E5yqkgivDPc7FD4EM72wak=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the blocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+Pgw0YT2O9scVkvmmwB0I1yVAUk9oFKcz2EgdMxle+mnZKeSEhZ8naT0Vl/rW8Iq
NaZ+zGylE1m8OMtINqO9MoVjtt/AjClfiBH5ygjyRUAb8wfw20hmPgWem0M0FCA2
eAixdF1q2sDVSssj5K6dBxJf3tSTvZHzTiSg6+LyKkfYJ+blBuVDxg==
//pragma protect end_key_block
//pragma protect digest_block
Fn3DCMuWtPXJxaUMJiqFf7pnSFk=
//pragma protect end_digest_block
//pragma protect data_block
o9ZSOedca26HqzlZ+PAXzCnVufFA62EKKSHRoU6ilNi0hsz6wS2jbwDmn95jgfbm
2UwL4Bvqrv6bY0MSuzWfvlU2rZmmDyS0uVZkx6mYQ5Dt55u/PEE1Vjc1TwUFHwmP
ynh0szMB8GNM7mHrQMEmoPYlFZxrHJ1aZuS0Lo51OdvJCzoklhI/zo2FINX5Rub8
Cy8soEZVSXxl7CDCul8L2qqTkj9wZXGc+YQCvyRXjvGqW6gn4tkMl68DBC8T0KGv
Kg+V8LULVUnigH12YYQaXuhxNxDWySLQx2tl2Ihm3G6ZNprRTG/pNrwOag58SL9Y
K7Rju82rfYOKqBOQMf/meCd9yQogaJO59pgga+MQ4VnQMInmTSpaY24eVD2pKbgw
tF6kh2QMNrQMJYx2swFBHWYnLvjmsFn6gyCTjONt7/ZDZ+KODSZ76FwMt6waShKI
A5LyP/7GWhC5a4cBhw15jA/iA/sIK30r9Qwv1oAHcNoHAlX/15ZPvqI0nqO4gshk
kxyPh1lC4oPLDKKBhdwZsw==
//pragma protect end_data_block
//pragma protect digest_block
5jQ5wefN4A1d2lg9VQvWAhIYz7M=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the nonblocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lkdkz4RuEF+GXDRoP3CsFP7ZcQdl5GNsN4Wa6bGWg0PWpGSTSVqSyF1h72OYBQfB
tnumx3h7E6rjgbqPnrBp7SxsANc/zgFpZD2/8ElZpmNusQSO9MczVOxi6H9NSjfR
MgrIFSzqqd2uNva5VS1iXvBXNrIGlyRabZkXrOKuWdcWC1WhMa+Spg==
//pragma protect end_key_block
//pragma protect digest_block
0SpapktxT8Y5cu1A43i5I4RXj2o=
//pragma protect end_digest_block
//pragma protect data_block
iE2Qg6cNxBwxSImpvoUehlTmj+5TYz+25gSWkWYzTaQj59j1rcTEjE4t8wkbAj9H
SG7zaJzcg21D0NB72odgX80o6ZmsT7weiIzf/PqxtNN2CWFfOBcA8dMj7dv0Mw3e
tfvfCUjwmCb+zuKN8g2JfYQqHfkXYE+8xko9qsEPXtyNLYuyPy5RUAO3XxIZqnA2
pbdr6WsnIMsdjntdlxZtc4353z4qQ59g++34iFCeXWdPfaYh+4QpRxo9go2l2RnX
GFyEd1B6ZU6K8LAhPUHgqJIAVsIT6vp9ae42sMRic9xByvGp6TWyyEnFYKYtY9A5
TKENvPCK0WzyUhYCqcyz1Q/6ZbaTq6nOXfu70IEA9Ptas2GfduryzifUtZA3QRaH
Nd6zLS1E4LDUGd5nUci3PxhWBD5b6UXFgK0SVV+Ygp/w3P8Wxyyi43gJxHfgPyjM
x/cNGU5cAy6TJkh+DgTGglMbHApHYHV6JVpewuEEzxdXI4+TbXHKPR9XNrC5Q9yc
oLFpYA9Fk63Eo94ZZMHj2Q==
//pragma protect end_data_block
//pragma protect digest_block
qVCL6jKpzH3I5zLTA7IVOyWIxk8=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CEKrCAZejuilHWqfW5mGhXtIPGnst/c0Ar0yEV8DYR/iYRD5cP9urHDlMI7Pg8kN
7pl+RTm0lT1dB66PCcZ6SN/sbMuakBXRBk7CvxuAmI8O2VTrdz5qFxDveQw+lSp+
u8GeMJ9wyJAtb71+S1DaYlTtHi/5cdL1X/uDvZbL01PfvxwtMe3hmQ==
//pragma protect end_key_block
//pragma protect digest_block
1g+kZ/YCG0zvgcCUT2qATasT99M=
//pragma protect end_digest_block
//pragma protect data_block
IdyFTh7sBb4VpvawwZNjmgZejPewswz1FxkBtJWNEieG1dWIjvRPXL+W3EJyhb0I
V39DLRQlCkhnUspoZAC0vdy51BZBzQS3ooRaJ3zwe+QX5LiH32NCqtY6DFMhlI8q
iKVINlKSFXq6eIkvel/yNzAvHuZf4WJOL8CvuPv34ml2xGYCjt9Y3zACzO4ETMJn
pu2MlCgrmVq4b/zLXATfy8BPb8nXtHxUmT8l61sQiD82R0zK8b7hfyZ9GHHNnCDW
mUA/Ey/M/Dz1BuoDvuPr6poe4T3dAqAMxq8uvt7ieBtvfUWlMDC4BIFUJHO/vE3s
ubMDCw0GA9Xn7w7nYO3jD3vPm6o8LsrSNr1iL8cL2/YJqMrB0CyqdYNwmgUn+DMc
b0JnSr/GOwus3SfKs2WoUv6+yEzqK5b0J/UnoSh3mGcJsylNXZi93yQyN4GbP7bP
fPFQ3SuBLdsmSK6hp76wl/rFzLko7n2km+z0kTSeZlGTt0YsCtdjFZJlTzKCasw7

//pragma protect end_data_block
//pragma protect digest_block
k9Hl6Ny1xF5BwYSp29Hn47f3Kcs=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the blocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_peek_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mVM7To9Xlx2vGqU0GTsLAnREhfhrmjSKuIsRWwraj2s0ttk3B/ZMNk6NGsXs/YXI
zSVcegmFk76e8lThtf+Y8ANsWHgTIQtPeFiMCzJ50YzDkHI6HGpZK7ZHkZb/pto5
zurkp3rqPOnswY+r1E35l0gNlyiPjp+GXTeTqvOIWVT4tInw3vlNZQ==
//pragma protect end_key_block
//pragma protect digest_block
LZutyQCUo66Vgrf57L++UefWrtM=
//pragma protect end_digest_block
//pragma protect data_block
LZ4qkMs45EZ+3C2HKfALDsT3LrXX1h4PIXj7hDRS4TeOcs5ZAFxDGieKmxnO6yma
KZPi84j188fcSlfBehIK6RR6DkTetrbabSwUh1RWu7c4BPGXOTTh6LCyxIBm8AAU
KE8eqvfwSanxkqb44HdE0fZT2YhzRbld5KHOTk6tpBhtpiWk5GaAHOohbc08J6Sq
ZCiq6vVrnPjt0ESuD9+1n2J6H3UafYc6x6LYMkkkBP1M4vg/OSRhFvA9fEauA0ZJ
t3YxntGk7gcDNPPIdsihMybx8DO0KW2zRTmdzDkcwnLehF9eOT3wKcuvpb/RfkKf
aYSj0/6UDi9EuyxuSwOYPNt+78qRtVOeRkNshXdOOqLiQg5Y0sswA3bF67kvGL7t
7Fnkm7/60TmPx89xnNLSAvnblZIB1c/+tOWVQXoreJQttdKvU00N2fpiiz09t9lS
dqZdLI2Btv+hrysVZg5c3kNSNC7OFviTTfNPnRgcMT1CAIv7raMfZeKA8szD+UX9
wsvTc7HkfpGNXwhwgBxg1Q==
//pragma protect end_data_block
//pragma protect digest_block
Yu4ThLQufUdnxOuncqAIenyYdZQ=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the nonblocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_peek_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eD/Rd0ZRkZS5kiyRGXuPNbViYlWFRPutdz6kIiziDw2aCPNuVE8OHMrwPnz9oFH0
wmyJ4wtvdEYx2sQchOHGYBZO7n25jBxPmREWrqay3i3UZnsCjZdcIst3/jbz8Xjg
D9kwXdNMqIgn83jRGXWPR0lTktXBO64rNUy0G6CviHZM8NjdKWAo1w==
//pragma protect end_key_block
//pragma protect digest_block
dwrLW26pzhhnCGv+WdD2z8X7nH8=
//pragma protect end_digest_block
//pragma protect data_block
VywX31en9RRPI3GUWjNbzRkjywowACPLvQYMHzbHE9Kh8wFuBYiN0tXkjeRaNVcP
638y5tdEd8qFo0prV+4uComaB2uC2bVg/ZeCIu0WgocGrYZquA4cddGldt6HN1I6
G0vXw9SFkbg6i1rfg+fCobB6pOdOeMUt5VZz/nfdd5ncdik731f9nDF7KwRcaEeS
cbyzrUGCHX62zc3fX27XbnAyx7F1FKqiTfyM7vgU8AZFft4TyukP1lD3PXBuBcCa
5cdPd0AozyJcWdJfv0qW4YiTZJW+ZRisFv2/n5gKJcxZAt36kQtEyF/6Tr5d2Yd+
B4/vy4MNBjKMaUQFcr6pQaRF5zmwSmm9v6TYaUhHVZgPR0uQ6gPu1V9XGdVQ7DTM
0eiAQhOsxeVJZ9fb/VtkVxXWy291uCVaUZGHCwrndMEjBjprs3GefeJRAY5ga/35
vqjjWphquIWQ8mgQnjnpjwpXKw0pH75VkknwoWi0ye3eoFPlXjeainzpGWkhhjAU
t62PZosGbbr8XT3gny1bzQ==
//pragma protect end_data_block
//pragma protect digest_block
ciJ3ZZKG7OYB1fAn9plxaDfpcpQ=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(peek_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mz6exAr0SyEDmYSRNmpDOLtCn6kSPruEoVhAHobJbZl65qDkHsxbLXa40Y2okoJ3
Ub47vS0Dg3g9g0l/Z60hPF+VuOPc5Dgsow3ZHK6j9By9co8alS08y85CnXIiMGfX
OSp0FoKiEs0UC6K5k99RzPT/VbMyHMcyCUPfZ8siRvIFBvDllqsOIQ==
//pragma protect end_key_block
//pragma protect digest_block
fNcQXPCj6cMrbLYdKfK/KodsIO4=
//pragma protect end_digest_block
//pragma protect data_block
UEjni4qDezjkAIW0zDdydJmc8Qul9CqLZd4kNtr3Ljo10Y0Lop16j62fPyQCaqlp
JZOyJfcaHxiPu/82KjKz7nG1iQtj9lNoNp+3VSL/wf7HQyNuc/XBL8HmLbT7o6YU
ytPBeai6chZR8i0sI8KHkahE/qfmTx+6LyhFzO8aj2+lXL6eG0zxAjOTvcH9o2gk
NrVLywOl9rcjszdA1p01JD3BfQ8ONCAie1eGI5M5fYe+sfIkdEC671KgLfKMlRY+
JUM9jC7oTpQ3S1iqiedxl0u2TMcIH01uBe7os2+pbddMnulyeA/euSz0WtFOTaFr
NMAJF1qa4dzrKcErImjmXydS61X5MkePnmlu68/08Mqy+tSalrD4ENrW8ia0mPnr
m0XQJuGK71S2XYWNIDdWA5p0s4nCtVZmeMmybbhpzUsEtznaCdeRQKBwBJbO4TOX
jgafJWfC5fubZweqF4UTn1qPIm1DLkPfUrOKo7+tU/ZtNOG6eBq8s4aDNREZLZMr

//pragma protect end_data_block
//pragma protect digest_block
9vmFIqndVpQzipDAH8DeiXzFT4g=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the blocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_peek_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eZi25X9JCUXOClhv37MPEcLdewjgvLGBmqE6p34q7AZBkixnrguwKzH98V6Xf4GM
48HXh6wa/5Yb5abl+NyCe9+klE7QWkfSmDRm0xNJZ6iLOmKnH1HO7gVwHk+HSdc4
mEs+vDF6j8fYVA52Ql9aegwzhtn9b8AZriA+Gb4zgn7UJ7/sX+c5tg==
//pragma protect end_key_block
//pragma protect digest_block
8cUQrtSTtKyynWKHTUOQkxk1LE8=
//pragma protect end_digest_block
//pragma protect data_block
YP4VtSZrYvsXKSPjLTwqZuV0RDkPa9hrWaxSzcBUM+HQJaEcdrIaV3zbMxzzSKkS
HdHph6gUKeHSHb20mHnqvgL0O1GxQercpOX5crycC8ZxVOqN448RLmWiFIlokv7M
lamTsIeRGJsvNXFCq3NpIwZujtB/7IbATISNlwSpueePfColTw9MyMAWbOC82sVy
TONaCODkzjRTnctkX+NFqPyctZ/pMJWZOLpwI5gL0zDWxjDeFXwg8I3LVFEbgtq0
UUFDQr/V/u52USlORmLx7V4yyeV5EKrSsjcd27KAJiQdFL7Qev44KL9LlH7d7pzz
RPFgB5KR+HIlKCpxvWymQ8lgCi/JsS8finss7cQ77T0fAMl1TGIx/5T9qLH41tO9
9xMR4SyFQrkkkGr54hHwA2Rt4NLH6ZjkAZTCqRxLqA6nIoI3VkrSDyjWcTFaPdOs
TcFcm5IWmEce4RR1u8eWuCVAu9MkuMP+Uc1xcJazeZRgLxW/3XKkQ4P7JYtUsQRz
FPbCH8MOUuyqwDzeBC0LHg==
//pragma protect end_data_block
//pragma protect digest_block
musPWFdkEz2TkgJO/YLfi3P767k=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the nonblocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_peek_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fMf186RKhvSZgbXsZqof88nNkLaiAQQOmOX5GmvpQu3RNbm6/VU8Cls4qybxLxTm
NDNrJtwgarQix2vwZZm8NNmqe2/K6xD9WGG9tUC+TNA4ND9H5VK7CBsOZgeePP1R
2Ibm1p9CoSaB80QvpZ8QwoowT7YeUGwUKcjqXFzHk46FB4lIUr1uOQ==
//pragma protect end_key_block
//pragma protect digest_block
CjPlOpe+2uyCDOojDzbclS9NpGo=
//pragma protect end_digest_block
//pragma protect data_block
UkPnM+vNDJjLOjLoGu+ckwJwxe7N4y0RdCiWjHuJbWoKbJ+qpuQF8cvJPRvvW3Lq
CWj5Stgk5AtL7JD7KmKll9JKmVHGolmr2eqYtsqt+/O8QQGoEZL6pQnfoxnyZXN3
Hf2DihvIgjU+3EpwQeU7ABctBLfJLyfMwfHPLueRSZzl0qaViNH78m1rcuL1I9/G
VoNJIcjXzSwgrF5h9qmbWLoBW2JGcgkVlj2GXTa6DBcUQW9ALO04ModEYBAiySDP
iN74Od+PhO5KIAATYu/0FWKV5Sf8SdNcacFSUZlsREP1OcYSIjwyJP44Dyw1t3c8
peAr8KRfhBn+S49CzpKMymCBw9OKDGWCT4tAzhAzLSHF5AK2RibTMdKEMpAd1pUc
v65oYBsCyJ6vrEyzDWEYWcE7hjPeR9DRu+U3nvjd2sYYPdGL6MgCNDJ5Q46dPjhV
2MOMjB1hH/mxNc9Mo6SuJ1TuGVEqboVcjTuQVZXra314OIsBUIRBWo5uEyWomW96
TY364K23yBDSJIUz59hNOA==
//pragma protect end_data_block
//pragma protect digest_block
XGXmC0Eix2HF5Ifi1xux43qQ+Io=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_peek_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ruEgC0rPlEEoO01t58pPt1MeO6TaoPs0locECGobuZ2DrgTfTVmGk+O/KJEQcaRo
mhVjObcrTjwX5Oi0sK4yrwXEyAUY4AZ6Gmj9mZjEV7clopjB6XlPcF74k8HUeB0N
owH4mGYfciADtg8LCPH+PG/bRllCPqAUptpUTj6HyMDA0JoI4utNqg==
//pragma protect end_key_block
//pragma protect digest_block
jsNhqqv5Tm3E6xVZVGIQL8HJkJ0=
//pragma protect end_digest_block
//pragma protect data_block
lo6wCj+a7DSoZs4lEX/EBy6Ez9Km8mxbHzpA6mQn6TFKQzkI6URrJA68KoUgdNpT
X9pZr64Oijeg/HrFKZ+M/XdA0XMXZSDhAull0E8MTlaVMy83Lt1oYUPg807HfWby
PbRYlj2Xe3cQNZpn4IxlHk3sEVcxggkn2UuZYfEL/Ymzc9yHnuJE966exVmZc+CV
hsOtNdce7ehUq2SyQfP2f538TS4cEbDoB2lHKb9N4hsyGkAvQn29vRLcwRlxC5aP
vDyfU8LJLRl5eejnPHuNOnj2XUDY9NL09spnUu/d6F35NYPFUz5CDh6o+sFPB/b7
XwE1oZe7saoO2Dl+PssZiQ5s8/gXYGJBX+EkluVrDm0l8DySNl3iXnCEH6vsk1NI
3eh7vqTNnkzCDZoLIc4oH++gYVgMhtfum1evBlqp8tG82sap+sOrpV1k5CxWbkix
7uDSMY0Qf4jQjZE0HZr3RzF1LeC930ox4DxsT4KS9t/cYaw+3xcfs4as9PYfS6m6

//pragma protect end_data_block
//pragma protect digest_block
Zk+yT6umZZKnf2rpV3qM2VUZ5/0=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

/** This class extends the analysis port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_analysis_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(analysis_port)#(T);
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mcKOyzrQ+F5N4Ng9l8NPuLC1gDTzKvehEn2J7S1ij683U8FKHTx2LPssocTxGO39
1RwiNzvNuJQtlm2MWQQD8UYIQh52BFbziRhdci/UsJKj/7RA9Z1OqV05R2UVHSrh
GPD8CAk2rkmpQNClbAdFvGcuq1U7p9r2n3bocV+AWL68I0zsM1RAuA==
//pragma protect end_key_block
//pragma protect digest_block
P2JgEcEW5oFLbD9Poqf10teEv2A=
//pragma protect end_digest_block
//pragma protect data_block
IMMDBfMN2tIcoMCRRny9d2Qb6euraD6Fbs5f2DwyL/M7plczJ6+7T0c9ZFmChdkY
ivVcAN9tczTMaitgUNYii5fveQWUppeqTWvq1I2ZRhqGeVzDDGphUfwHjeRBIiD8
hhgrrcfm4LEmwQu20dtMTzvTIyjroxmMtzpeylbazVis0fOn0frzUaSEfAYi9CMH
xvIHZTDhHhUEbFjTSAOYI+GLjQDE+SmLA0zb4HDFpm/4OyT+gR382duKcCZTlNcV
cosngQJmcWNBG5EnHJZVY0wTR7tc4402tFeINIhdH3tR3Z7phtKKUGHVkthuPJFQ
1VA7qZH1nL2yB9B16lEbbwEIZCEX3Xp41IP63o8dPhBNd2YGKd8V0vPoy4fPlug0
pKzV1pVyE9PV/3BZf4HoOHJk7VicqLGzKa4FnC3UeXVgfwRgUjQp/QWvTFF9APjK
nrYlLOrty0T4kGVyiT7IcZQGhTgRqlERclTs/nyq2m/SNzOFXPclEYO8aHewGO6q
DWBczlysMvbkXgOdxr3rncJg4y+wwHgOGPdEXl29wHv2JtSIhs8YON7NyozEpzL0
xlruGTZwoWrTceDcBJPIb67H/Tzt6yPJwMApMO1DYC+lu1U9qX7vjGaKEvc74Ez3
wG8tZz74xF62xgecDf23g1MCpEqBS4vaMExlHSedG4fh2wT066sseK4bBZjhYEA6
MAJ1hZ3hX0dM7wcSD5qah9taFRQZ3ymZv+RoCsfSTHyYx4Dxb1ZsZ/8Yf96wLpfG
1LN/PqHm3YJ7sNX8J65SuTYRu1DSQU1rHeXXvwldKo7EwEd11JIjIkitTIjLWscN

//pragma protect end_data_block
//pragma protect digest_block
6VbQBzNhzDPrK+MZwtx+BQEKQhU=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

`endif // GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV
