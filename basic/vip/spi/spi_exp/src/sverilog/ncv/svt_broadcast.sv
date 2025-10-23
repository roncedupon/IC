//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_BROADCAST_SV
`define GUARD_SVT_BROADCAST_SV

`ifdef SVT_VMM_TECHNOLOGY

// Use vmm_broadcast for the basic broadcast definition
`define SVT_BROADCAST_BASE_TYPE vmm_broadcast

`else

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/NOFre+3fN/MF5oGqJamWnGOb6QoHC9Huykr3wZEsc7zAAD3xmzWjLxH+m76XGG3
nZsQXLXyjWnlUmvdbKszWta24lEvzykDjSV9sozRrsBXASmNN0zRLb5u+QIY/A+r
KlsAMqe3ZWgmo1F6oU1Nvy6mXz5EcSz9HYLsjutVks79/5nRnl4y+A==
//pragma protect end_key_block
//pragma protect digest_block
5lwNc9ATAIhFuD7lN6uKHlqNl+g=
//pragma protect end_digest_block
//pragma protect data_block
jomZri9ct/zclxBN4OGuewrT/izUHrvM9YA+Z6+djb4JJtCEEPYJdC7morTFBUfB
xuBlXltF48y0yW9vqcle3sMH+BrOFSGAiuDBWQPvv/SKWLzdAjZ0vLqnLNsgDMGm
y86u9O6Y+Xmr9rZNPLKexmcg+LeOSGG8hx/KBGc6jpGTQ+kBA0Vkt0N0wjfZFeNz
C1NUryzs5hf79PZaQedhGb3IkMdvj0cBaRqyxF7H9rrjY//frUEq5vZN6Vpxzb8g
ns0tlLP3PsPl1pD/xibUcE/DqMOUnpf7l5jt0Xv+RN2vjZaIKzQq1+X8/RN7z2t+
aTaTeyNTlAMdAH1NnPs3AZDnmb2vhZjYA1Nz+vw0w1++H+rrniXR9Plezl9Wnisa
Pif8tOYs/JvtR77Wd13LgbT1DmBGCXuc5d3g1qEtAtidKZ2IHXEffFFolNk06F9B
AegRzAEKO/xbgcbhz8BOdhMUKmUNE3Oa0XCxk4vW8/gfzRpozftB0JwBRStgm0mD
6wBoeZ3Ai24p1t4KEmrDmkkikRu1FRW0m+3IH/unT5c=
//pragma protect end_data_block
//pragma protect digest_block
2HAG98LTLpD1NBYM5NYQdughOEg=
//pragma protect end_digest_block
//pragma protect end_protected

/** @cond PRIVATE */

/**
 * This code is based on the vmm_broadcast implementations provided with VCS 2010.06-SP1
 */

/** If using UVM technology then create equivalent broadcast functionality, but assuming sequence_items */
`define SVT_BROADCAST_BASE_TYPE svt_broadcast

/**
 * Broadcast implementation used to provide a basic broadcast capability in UVM.
 */
class svt_broadcast extends svt_xactor;
  
   typedef enum {AFAP = 1,
                 ALAP = 2
                 } bcast_mode_e;

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
S+bMdpyJjJ8Vh11RlKAWSdmaAQtJOTYKuFDkEMd5vzaBPY5WpHq+Agrb0nTj76WS
E+ELRca/KVM6eGMYnsXLR03JKs/aNEqqwZyDVnpb/7GAFsEUMYvLbYanlU79yeeP
GShel2gZvoAmGVKOn4YDpbFQxn5KAHO3BT5AH3sr9J38zkvOUaQApw==
//pragma protect end_key_block
//pragma protect digest_block
s5iivdLXM+KzTaeeuhOBgo/+wr4=
//pragma protect end_digest_block
//pragma protect data_block
aR9sg9RdvIsUIYGLrsJSe8GJH+/KjutkH2jNsGMfrspukj0twisvGHEQ89p4YzSS
M7NuFiD4V0CRsNMCymKLUp/1SXdWBZvGR48KGRn1+Qu7e48tL9C4Wgoy1qouXI6i
L0YwrMitKKXW+FOFPy9VhuZk+nGIVP/xOIzcjaasNMuumYWhCE+eTDt4/nmEJxwH
Wgk4YusGj61L5xyUVrbvsIcs+uguwBiJb8EA6hFYXtOWIhnfHOz9aUIb8C//ruyp
56wlkn1LP2XfzeCeqoLXtyAd8hgaN6qXA5G+YptDxvOeNB4pMXfY3WNyJAWFdTtl
CsyceS719pd4TRuVRam/aI4e0rNNGW3jVl8KcWrVJFzgLuuGUXBJ7Ww1KF+3g2nM
o7BYIfPJ21Dds6KVxfhw5tTk/9t1nkapnQZeMPzvwObVt6u1GJcTne+JHk44g1l8
mxxWl7Z20WXEARxzh5Fv3nxCCpGehhkkquXxjPHEKt2stk2aNkCKp9oLXY4nldbM
56s/KAO65rAx6fNBZItPrDwYvHEXcjhYdcX69fvj4KRrhzin0q6DdTUxvqVOIsnG
CQ+9KnGlyK7n+6KC0eZL6Q16HB1bHbNyIm3+0NviGVCG2trwpHprYZsR34y8gSIS
8/7n6tVWTmjj8hb4MIblx57/BmIr4nX0170cImrG3sEV8YbqwBBMh1LgrDlX+eHp

//pragma protect end_data_block
//pragma protect digest_block
CDMHh8Uw5tsLEU5e/lc27VyFdE8=
//pragma protect end_digest_block
//pragma protect end_protected

   extern function new(string      suite_name,
                       string      name,
                       `SVT_XVM(component) parent = null,
                       svt_channel source,
                       bit         use_references = 1,
                       int         mode           = AFAP
                       );

   extern virtual function int get_n_out_chans();

   extern virtual task broadcast_mode(bcast_mode_e mode);
   extern virtual function int new_output(svt_channel channel,
                                          logic use_references = 1'bx);
   extern function void delete_out_chans();
   extern virtual function void bcast_on(int unsigned output_id);
   extern virtual function void bcast_off(int unsigned output_id);
   extern virtual protected function bit add_to_output(int unsigned decision_id,
                                                       int unsigned output_id,
                                                       svt_channel       channel,
                                                       `SVT_TRANSACTION_TYPE    obj);
   extern virtual function void reset_xactor(svt_xactor::reset_e rst_typ = SOFT_RST);
   extern protected virtual task main();

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4xV9vy3CWBfXMT1lB8QT9Qm3svlxR0vvbDqmLPHNfoIb2SGnhPbQjYq5N7tDdgJ8
cBDO1Bb7rzsPtiZ+CRZHIPtUYGIY7BWXXW7BsxYh2UiYLTgkhP9eaLYEIVarM1XB
xjrIkTSs1/e9lATpc3mdM/xw739eExHtw6NMrIhwCXd4mwm2GHEm3A==
//pragma protect end_key_block
//pragma protect digest_block
J0C6FPEKGjlYXzHYMeBh0OoGkiA=
//pragma protect end_digest_block
//pragma protect data_block
4N0UBn1j+LdLkRV2muDXH0QSgALzPI2bunQdiDyXfSgCgvVdglbwRas1Bk+L/TTB
wrDXkZ130iSScCEi1tHYA/chy8AMXr60sdjiKRuYvXfhaogY+iWgkfRq0OeOlfPW
GLSQYaxcvjMZPz+CwcQRrfBnT26rdbv3KfY34rwDU8pB4xkCQT7K85SnIylmZOgA
0SY5dQ2g7S9OyrF/MQ+u/WVu2qMKEULKHgBkVCAK/ilNpyViSJvrvUplaF8xdFiQ
dZCdDoAflgyTZUgXmjQK7PxTFNMGJHgPyZEYKKd6LtOpJYoI/jrCCrZjcU+jP7dk
95GloJvTUap/+JBcc2M+N5m0IgxQhR7Aqti9IFDBgc7iyUAAHySxjhTuWbJ6L00f
HwmiNB5bILyZCQlux5oi2jfBBjXFCD1oOfUPoa0SJWB6Wn5Zvydn+mTvVWWAT89e
zmDnbmpTm1AkLZy5QWleKA1XW7RPvFzexH30txcujWh+bNNfVXOaUZkGbqzbzANz
wqYrfj/lhD3bDJRI/3u0Qk5Okok9RRCPRZ6O9V7N4lc=
//pragma protect end_data_block
//pragma protect digest_block
oui/hSir2mA737NEqOQtsCiVd1s=
//pragma protect end_digest_block
//pragma protect end_protected

   extern virtual task bcast_to_output(int channel_id,
                                       int on_off);
//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
29temsYvHD+WnD2YCzCbwn6TCzfaLwkR6tIl8C9ldHVFdrSj4Js+uzsAQIpvl7Qz
8GYd195Amj0een0SiXwjvob07SZl8Z+HiP3zj6SF2wUY0oGyk3Ig//JcRJh7ajRj
Q/8dQV5Nsyc+hBkhkiKYfHjGXlewKfnwXMncBOUlNF0n9zjYO+Zd5A==
//pragma protect end_key_block
//pragma protect digest_block
Fhhtuna58lltsDF0ovhv1EW748s=
//pragma protect end_digest_block
//pragma protect data_block
/rON0g36pwPvlARaaypqGtCSCIgQrbO7MllHC+5XMJotBv5Q8gDlaLAH/Q/SZjea
FgLcIZdOJ+idJ1oGasrEZEwFvPzLgFt/BGLNf/WY0JifNw/cWVWIDsc+ZANpP/vw
74Qz9IGZXIS7NuEulSTIo0b4YnNNCA+flyVureS2rvWlYMfr68gqyTZN8bb2aUSG
ulfQkw79jJdnIUy1ARjzFAjAT1lK33a87RHZuFrgni0x/X5kQI9mGixYVLl3YYl9
R+c5Yul1yoHpnXVUDFVvHXko4LLW5p3IJlGyXxaA/Gp/y1HV4ldCnw2DgiMGNCQA
npm4VysK/J8C4Gps90GegJDBBdliZSzTN44AXbSV+bCZhpwpff9/OtkIQyuwTy8U
FFlqg6ngNdsdh4/KRjYXGxG4BQmEr9wf7rhqHJRPS6P6Kk2cLSTGrusFvCi0LR9Q
FEuWXzZyoEZcBnWyl7hz8lQEaeREwccXJqsMgZ3B2yJxDyEgrJRnaQOltt+kT4ur
nOllniyy2CjLKyBmL5fX/i1fHzDYjo9SS/6Qs6FGMuc=
//pragma protect end_data_block
//pragma protect digest_block
wSwoTbHxFU9Y8y9RRymmieogkzM=
//pragma protect end_digest_block
//pragma protect end_protected
endclass : svt_broadcast

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+xHYi2ze2eTvw2uNbq3mxHoycDycNXHBsMPONdMeYVE9wpG4ISl4oZbWoltEdvD7
NHd0CeEa7aOKKSEUpbs3pCPN7LY9r5dH7WYCzTRt5VPNp1R/Zi5jAdGYUOZ3o/cw
t84RhRS9rRMrxcu9M4vGxL1y0iJBBLuo85LSedNbk/T4pInkGW/NHA==
//pragma protect end_key_block
//pragma protect digest_block
w1+yYt8m/2RyZr6o31cEj9XnSaE=
//pragma protect end_digest_block
//pragma protect data_block
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
QURs6JWNOapkCJwNHhxCWg==
//pragma protect end_data_block
//pragma protect digest_block
bOJQF49ib1TKAUyUInvPaf/ZrIs=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1Z8wYOCB9D3AWT44jMGCPM/ji2WJfkLJy68VlC+OiryXSqlrJAzBjRtt8sVaHcKS
Q+M5yfyOklumW/A7hXKfclLCUUxzN0j3pAUnLLIh5ubaRFtLTM3P2gu56fhMg/wA
D3F3ZmR7n+7HhPORNU2zMWGEwTI4DDbYqKg8eKwQKYP90eNes0FLhw==
//pragma protect end_key_block
//pragma protect digest_block
O0Sd2azo3RW7JCLqVztCCKdyNvg=
//pragma protect end_digest_block
//pragma protect data_block
ETyITMN4H3g0DMUopiMqeAV3UlketBfk63+YoqtdDa56KQcPVE1wdLKcflvsWalo
2UVvH4hYaDc8WOpfNU465noRci/1b67NTU9qA9IYeAujLuXaIT8Z5heHpjPqzxXJ
57/Skt3G5T13Uul2P66eCsZuQUJ3Tkb71Y2T2jO5i4tCwqONEX+XM6qKgl39BOeL
H0A3dmPTuuEqGZzm+Ha6CPE2ccgihpgSd7k+vYFTCl2nz2/hIRJH7dru2f+9pRR4
p15BFSMLDzxS0MhbStMqCfGnRq2q2uE3EfZf/FpNmTu7Z1GeQbOp8nRG2vifFv3x
Os62slgGyF6FVTZhdgWmAr0+fmEImgnhIArAF+f6sK+3glTEbqGoo+PS2OMmNUmV
2wEMbsE5Jbmvpdh3TNGQIGIGe+7oFJwBF+0L4WMsbFuxjeSC+27BhAXIcqk5NjtK
wuW0mDLd/SCQBAwSVdthQoNG+UKWi8ccEjIyqJ1quBMfO2zuwDuVS8Huweyhr8rI
fvZFQ2qtpqJoMTTck8kHq/cksIIdy2FkBn7KBl63hytUA2L33WDLENm3KQzlZnd0
cOFB67h5ZHJtKNPEVGdxSIWY8/Ak5MaN4PHfzBcGq9IBWsBoZ/mYYdbshZrrPTbE
Qi3xyH0CuiSfeHNYMX/g9tJZXq+J9Y84dsFwfrxoM4vlc/w3xnxUvMGZAmXZvMK5
PyJa9enxSB2o2DUhlj3+DFsQL0t9r8b5SFwmaerxwfMiVmeJhmba7J0zb6/qVYo8
p187KufFP2haVcPCZm/0V+bCZNoOTrrTcJ/KPfX8dbcWeziHNxx0aAFgVuNnvnDc
79xpBjJt9VIiji9cCcJypMmGJQ9JzQZcxqdGalg6+6cK46gycYWGjSSRnsU8lah/
NIVJp4vCM1scSBMrKprRucZY+ZeRMiOnpqT2RfRKT0/x7VZvEvdGc/Hv6C0AkJWu
BJ1dtgcOHxRVcQOXm6TRko1CsB5JVvsgms0AEk7yNbfypEFJtQiq4TgmmGcERNEI
Q1FIYwJhfvmHir+Iusxgz8+dHi8OIAyCFfDaOIlDicLPsrCxDcslsQJ5jSdXrCcl
0bMgRaczj+UiQMT9lLWoik4or/wQbtXRcD2dv57sigtvRxqNi+9JfQmo6+uvJQa5
i9Gldxg/JB3nm4qME/VTBJ5mIvg5UAl68/WxAMM3ilKpLf4jCxLZqyAgNqPSYcxs
kf0GcqXASIb4EEs+pnBNbizgPc762X4IsQCIDypQmzmgmbdmkq2WVjkb/CGGA8Vv
eHjAfj0IXqaBtaZs4f245zhuL6mQZ3kBCKTmpp8A5veZa7ihTKcMnw9XshUft1Qp
BC57WH7gNlwcrLJKCghJQgYKIZUhIcyQjlsWvf18NhN7BFFHgarbCEd4rY8Ka5/Z
BPVV0jG9BtAQd2ixPi1j7jvwC8KH/5PcxS5vn27SiuaAaUIH0/UAtUificzRObW4
C3t3979G+rh7ujuUz/3+uahIYM8w5RxcBg8E6j/yKgs=
//pragma protect end_data_block
//pragma protect digest_block
u5L8N7zXWeeIUbbCXYyx0CXLEgk=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eAOX4pyvdBXcWyYtX7TSniDcow9yUnfg3xQ+SvsPQ6NCDsUjPEE4imFp7UhZc0WH
D/M2qELTZ1NRKgZYBJjTEh1RqP93nGlqNSw1mkAv1SW7pzieyQ8Vn0n3bcUsXhT4
XTSfKUwyyfz33HK0tzX41qovtR1x+F45Kwyy4L+IOqdxWiNef9F63A==
//pragma protect end_key_block
//pragma protect digest_block
rhNjRTjN71gIjn0eNuE+cq82/kw=
//pragma protect end_digest_block
//pragma protect data_block
mGGuAjivBGLcT0JSzLlidLqy9j3gUQGCW7agWxM8MzYUjNoJSU1ldBpCWi+TX95P
KseAs68VSxTfB5qJ4WyEErkQPQM/jSn1timEi9oxPK+B42eR/ueJAieNisDzJSTy
4ly7wQUZp3W6y3lZe4MeRvS/dkrMscvkx/RdOSFdXY7ynaMhifiNYqB1fy/5cqME
uY7959CmkA0jb5lsGJtby3/41YzFwpn3bv5YmGHrPuhD2G6d9L283ZTH+1ZZ3Hje
M+oLQpX6WcrYtwG1lJzAuiO+Ali/DPgYWe+meVxvAeKQtjiQJ95w3nn0Pg+jXZnR
+moUMqR71UYTOCJKmNpd44OjMf4qePn2SknCT4qeiRDwM3SZ0gX+2yDF03sui1VK
mOidXVeb2ObIxBx6jmS0VXgUBxVh16cx+ocvkFknpYwfJx6EA2iQPswH2t8g65Je
qx8+NdT00cUQARK6WV7s1VWgVCa/W7RFoqp/h6hunnLIefikZCbk563m+MG9zWme
19WlHSOKvV/PfZ21r5Q9ALHMcerfuoEMT0FdZFr43+mNsnQ67LpyE9fetCdJeMz4
DkSoVgD3xvZcbCvLj3f7AE/mDS6jyWQXx0baAOEy0pbTdtgEZy1xswBwLiPADsD9
B8+Ky+x0IRqLNFS+WaGTGF8dFHMCw3la+46eBHT5Ui8N1LWk6INbkaR+H46DA09P
mRX/Dd0pg3tO/n8qF8a2eMDlmtDF4bMoClqe5G9MbB2vhxc3crfehtaGexdqnFUE
LSUrrnpr+CJDOut+D3WgV6OZ/sYu9PogM/CuRFyUXzNirwH2NgafuNkMXz5Bf1DJ
K8fUt9doFyzWyhiIdtff4xV2plPOYL9pGgEdRoFUUR4rXv14MsZSEdC/fKPwUdbV
UnEj44ONU4C0GeFluiWzhaRHaJzwm5joP4LcmSB28/0w5b1xLY4wRZSvQ3X52o5o
WkJjOkOQ4D97ieYjiLmG/84Bi5b2SQKGt79/osf3p2mkyPZFjwxGGGZYH+0hxXk6
0B9BQt/O009tjpnkZz7E/DJnLX2W6mcaprwh2KZJPSzIVGChCwmFCn12t+Crxlo7
2o5IzFtkWrKNULymQ7izlpwO3rWZYk/WxjyTzQmO2rw5gtsd2UsItSy3bf7remWR
+dEHWDbaheVAyTbUa7eGNVfvmG1Z3hwv5tI6MaqpyJj9PN3STsyXXEGHwgU8oMhI
ynxl4gcg/gaOyvwU3bIL/p65QxAxTrxUnhSYSKu6kt1DcI1uCorywXmbrJtIxeor
BSi0BPLVrUKEyKIW5bFd/OR1oVa52/K74/umNH6JqzqmNV0Db9t+UQwDjA5RLYrA
t4mF3ItmoHck+BmTJSG7faCSFQORFOoElqeajlniUd9NSImD/QpY36LyaHr8HA0/
4nO+CoM2aJm2H3Pos0tkNwAy5vVdBL78uKMi9WZpwfBkl5Ba6tqb/k1AGSh/QWLp
uK0MUo10ACSB1bX2MkxqouMgUhaAi14lVMpa8S4YQXPKVMb1chyA4TahYeHnuhcg
mV5nMffEYUl+ti45lgVYjw==
//pragma protect end_data_block
//pragma protect digest_block
/cY3FqjgIhh/nzlp4JVeqt+okZI=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BWiX3OBe3cfsyhUmePUGua6l/WKCBKOZjJ3FOCDgwKo0EluzbMAn3gUIZPpxZkeM
cvxTrnzruM5jNs6MTtMlAA2E6DKr+Wmf7sCMl4sSUwsmuq5H+e4XE7yWU6IAfQX5
AhV3GRpkIiOS9rG4fF/6XH6ELw6/wu18ISNwA4KQvOFFRvjIRFsISw==
//pragma protect end_key_block
//pragma protect digest_block
darLYSlisjheQ+a+sr1Gae9d7TQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
hAG+HbD9v+blHi5MN0pP0ZC5B/8=
//pragma protect end_digest_block
//pragma protect end_protected
/** @endcond */

`endif // SVT_UVM_TECHNOLOGY

`endif // GUARD_SVT_BROADCAST_SV


