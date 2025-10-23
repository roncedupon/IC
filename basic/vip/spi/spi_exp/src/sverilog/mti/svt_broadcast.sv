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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iQBjjPld6TIT7DrxgnvkJORIT4smKfKICb697BXeo1bTsXW9HIsMotkY6x9xlJKC
hK6Ak0izIIu+hqtd0Ll930l1dyxLR1GJtpqpAlWvJ/MDjeX4wKyei2pe2U9h39Y0
HYeKzJN/i8i+NfovmSR8J3OlLOalqzSSP62MRiA58Pg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 239       )
YscoSofSAi8PXtX4SIPI/K90HQIOGJVg4RU1fDvklE2tabbAZS33APgKZvLucHP3
NCstroCMcHVDiJvva3zFYz/G0CA4ziry01DxISlRlIWCpOTicXkgLz9wbzptuq3v
4UUtXVVFTwvXRAFYPpr9sUm+KDyPgrDJhssJ2AVnvRA6Vbe8M3lwQk71NmpyosJi
YdAbZywqkMBXUR8X6GHmky/S5nt/RCjbBDHRRkuVSxEBAHLB14xsM34zF2t0VVZY
QIf3fwdKpjmTQiA6ezCLixd0XW7D/se6ggvsmdpckDoVChz2Bq27V/jqWi/jWhnh
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hqI4Da4s8R2v6cDi/Dq+AMo8KZlXDWScloDXgKtEQ1ki0XzYz0DPFXDs7BSI3xcB
Ez1PamDQxL8j+DaiogLVs9R7A35drM6awPuW8wKyAhCgLVblqhaRk40wUL9+DLAe
LXXkE6ClJjOa57cQUWSHab/bZ5AkNZfLmIRzOUEBDHU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 598       )
LnWm4O4Oar1lHANELRHlrJexsurAbm72KassPKkCyAAPXtoRm7vbZlcvx92z7TqR
Nj9o3RWAT2FNyhC0JJCSktdaoUDu00eFQmr1Rr4kfrpvsST5se+/Ex56Fnef34Nr
tZQchbexsdOQoZtSGuy+V76ukhrOPenJji3te5zOW8pK7Ev3q0CZPCxXxg1FsBcF
wYT0gsmdpmkqxSTEARDzkiSOoBbd/rpGA/LnoUaelUWb8pntXzSn9UBtzwyuKboo
T7IC3jjC1/qPQinB85rozaHjShaOCyOv5bfq7I/uxfvdveni87n4tMT9gHi686Jc
ChsfK5gWD2RyTVlKBvXTPOQQu2/a1NmbJy82V7/5UQLCKoQUTaewQDpFkUYEIT9A
wKQnxEk3189OVYfr/zzfLCznzSYaNDd7Hq5FoUoOWPSVo2e0KuySHD9obVtJFGCP
6QYq+rx6pqxPTWadNqu/H+xBbT5nHA8B6YeHWZcqMqU=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eY+nsBOBfY0S4H0ul3v3AUkYJ4nlTU4Qjd2ZZEUvg9NPeZtIOChbWbWXNKzgNCRL
isubyBpThJBmzGbkrrEpl+QN7yZcLwyusvqpnqfxr3JwDbXpOtw9tV3sQM24Y7Ct
1+PTpVTD98Fi4I/bNm0MHbqGk/Dxj9/WKR52co4S8Zs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 837       )
zf90s7kr1LWgXjTl3TYCEOYmPMNjQwPAnZz6WEHUfqTSpMZjfUjJqy+SFLIV1ZLl
2GJucE+VW/MU32UMoq+7PsmpmNAs5x8mLRvqfiBjbJ2ZAhcCDLk2k+PD3bXadmx+
8bNqP3ud7Yph/tUtwM2SFdXkfmLCBxq5o7xq4OL7ppIuR72rGe4eCX5hyHdW+SJA
veZX2Lo9kXH4QaEOCLho1EGSVyHIj9L74BMcUddVOzYKPR5u0Goz/wdMJLn+NjKX
ArmsBdxa6pbYZj7Ov+bh2/y6QOaOrfDQkO8CO0kI+FNaPweDY8rAoVTyZRtPPW/T
`pragma protect end_protected

   extern virtual task bcast_to_output(int channel_id,
                                       int on_off);
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cy8hNxLTXK1a5WdesSndU40lEsY+t/EtovG6s349Haiw8vsSSqVfBDJmJ11ywgZ5
UTk+uF+tl9R+HWl9Na0y6jWyZfZwfOaYGAVhp/hfTzR+Jgretj2ZQeh42jTWf9U3
U/Ya/hX8AYQ7NcQJ/jnv+Eq3GHVqCV2JqCOBkQs8BAI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1084      )
fqmqo8R5igxkGvDq7FF6e/oOHtV49x+2peJTK0RshD+RgowzU7zkuv/fJ4UuUFvZ
8VeSBjsOJs+le4L2L/oBut2GtJfSZHjP5eOb2pO2eIZYZgdp7+6o35Bdwd0UgGOO
hs3DJX830PKnVVK3i76jLsglDxAnsb3XHRx5cCSPGEeTI9RvlS8pc39sVZO4xWDJ
SI54Xr9j5Gam3EjTUJTOwj0FbwUGbxAbzapclYRIMrtpVgaAwTLnfskE2ra3OlPL
4itdYx6UzWL0J1CHO7MTj4v/Y87MdFZLlQcq/de75KrgC5knqfYA0RLHUm8HjnBt
X+jssokz4gV/IP7QGihZuA==
`pragma protect end_protected
endclass : svt_broadcast

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
T5FNG2W709pN20srrDWTQl7zIEwnxYlihW6Wa8hGiI6p203KCcfas5uhiKoL5y06
94gYlo2X3FpBncx0Y7lH/yxI9IdQfo2ava3gviqya+SCR5b/IE5MWJ+dBXmf5+5a
U4L1VrO+Y5NSkI4kA+c7CWWd8ig4MQRwvN1TkevwLPg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3658      )
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
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hPlIB6xqLsn/CqOormdSZdXQEEhAoD1Q2VdmkfJR/WyB7xh6kBFh9h0HsYES2jv4
t/5Fi3sJe2wREGSKocdGUcLTPFkZG7AcgVhSyFZ1FcRqh5NUNbrhSkmSVIPV9VFG
GRwZDxgmjxO1uY7XGR48O4t4w0/vU8iFGNIiCM03dG0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4624      )
R1BG53KQtmQwfrBIZAQcFSv3YToFHBJ+ew5Cmo8jKrXC//AoEuixN/rAJ2cGk+yU
ouoDY8/nXEci/MU9kdz2+aF1ex5PH7QujEPG9F2Ow+PgeqhptwaYNH2qVCkwbAfm
Hq6obFgpOTvkKt4OHnt8QyMuWWJy3+prvZ54YNOGKY8LnUW5N+6krS7IcG1dtOq/
S1sZjjZkipei0VlbIc16ZNScIGNQY2lAohGQGdfpDwHouqXFJdiPI2R+XLMDrbdr
glrJtlls9R0mcIc0T2IMNbVRpFNAYx4V8SCuXe5vipH1c/MBp+rLLFgxoAAafS9z
ME28RMyJh0hQNoDps9wbua9KVyUH5+fptMRHHRP74dV6Hkwz8kUtB+zw5DaFgLfH
BAKsLsnKbmrzB/h555RKab7skL9BoE3uxFcqwmB9ffi43WV7hXdcLzOucVG1ezQR
5uAioM9GiH/TXuRZgxaCi/r1QQJjHVQ9pyp/pug9dq3Znj4rKISL73qawtHxAzka
n1CNFzURu7IMQTMUGnBbntbfZVPhmhHQJ/4qTBBxjrQrBKHWsB9MpvFT+IN8Dn1u
+BZRL+Xm0Iaf5q0e1D3Zb8C/VAEi96ugm2mJMTH7KEweZ60EY3eXO1AkAKWQWuIA
MkC75/rVL2VnYnCYMMLOF5BkuwBYnDCvqt6wlPix9dzhY1Rrp/p7c9fvwgZS9fji
HHQc3X8tcIXUlhgORthlZ7rO+p/jQRpLDTApdsgFn4pGxMT52V2IQmKmKDhJF/5z
PGAWOdSQW8Sj/mQCMXT7eT4AfPgVID89DV1Wcao3Q08ov25r/I9NtBrZQwBEFh3v
N+f4domkpGK/icXC5l/ufA//TOLsLHMJW8CPm6Tc/jDMQF6G7m90mHzJbbJOIKno
XQJTu8xQZJhqwaUwJ8PLgCnq6xqJgcJz/zXtX1/PeyxXAas4OWOg4TKJbXclDZ4d
B8M7g+4ZiW3hJrDseMN+zbCaAOa7CnTCrJaXIsOE7aIE/sO862p0pCyPLnBY/C0s
GuEwTXsow4wkqgiDjtGkk22OsEDdQIAK2pxMW4oMt/zfcxzLIKDZ+M6EiXCMk4lh
Pfajhyx9XdcuvS5uxPTPGdFLoQaB8ldCwG02IfjocWcA0+1QlbWYgU/Bhq24xTC7
pVPHE8YhqMaI7GwNFF6n0LsLS+LVSU6y8FkOcvfLER+DyxV5smyLUcHnIcGfiDky
fpRASI5osimxFO3xIHxDitsV125R5NK5jyqB+C18BLO+hNolqYyHZuckL9VrBih6
Dv5og34rRBFJSJlAjEoDOQ==
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
J8G5HkDhgsAMSLTJoOoJ1ArbkFezNhXxtMSMZI0mKJkQuBlaL7P0No0IJT9J5hvn
MSiVZm0y3xFtUVsrWRbBQA/oxPu3w2dhF+6nflKYFh0eEKeW/QCwVFZg79sbXszt
1/NsvWmfGoNWyw0ENxqXIKUgU8Ynxc/c+tUoK5R/TzI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5626      )
/86dU/aWh3cNxKTtVUoZU4M3lrhTz/e4vf7oHoHb50sz33895nc3Ki0iOgvgnZlk
hlxWm5xIMalYtq3w0OuAPPjA1PFIz/k0hfoKgzH56CP5+UQBbZwhsHo3+qzuu+vZ
YpbapsTrmoxYE69YWkDAP7A46fhgispJTLSaeYqQ1Xms+DE67C8UMEV0XiFVorJU
UWCV3+rfE2udg4Sv0mcgQMV4jAL5mxnjg1j8gbHr4s24GnyJ5HcpIaZbUWoVSaG4
Db5Hlr5HXiDwNBdLJEvQ7UVE0Otc70blOYvVX7mjlvdWEcMvleoq6oxMjBeE3Mjo
aHKR7kPPr32lCkXX7glbTP9RW5atjWRR7zwhEJRZQPV5HsFuzEQy4VoEh7DowOPA
gkzPrzgfrKCEwNe5a4viSiTYb5j1MSi12cVuFEXkxi9PhjoObQOEMy9KDfolv0Ni
oe6iHFq6aUgeATGO4g4946RnXXC9rDawOVJ30qECUEFVOhkVN4eO6uTyRPhitbYy
Jh17B3V20QPxKZAp1ON19Iw4pOXcycY10dBrHmRa9Q3FbX2QmRy7Ji7uxTd9xcS2
97oZ14R9ORirhLmqxjcnpeHtaZj7B5PkSRsPjDcdcCLvBH0a+1CrqagovPSWfzLz
2NcB+wkDpjB5cR1iD/3zDo92IKLY3Za/L2g0t6uVrC0h7fu3U+hjilMwjR9hgoiv
Jo939P73UTlFHR5Q/YJqf0CwYAaefIE9+tjkaytCmHFrPU1d+aHEv3hCN5/Dg/wP
B/pVRPs9bvMUk+nOVWRGFbQOpi7tvSTHpFxazbIDDGgBbzwGlMMPH8MC8e104pAa
bwQZakw7ESg/XocLe3n9+ZoMa9zdRZCWXWVWlNIlaVae5aPTO7T+eN/weW56OK9s
6uJUMasKexFL5E15DRtPyEJxiDaVszYkvGIdAs6gDdynvkyosP3QvbbQWfBT+2t8
b4mUn5W3ioG0JgLqtLlavzt7KIVl03lIK701oQRGMtbz8FrpQ8H0MVTw6Mva4k9L
Pjumg4DlTajzELFaA1WtLoCIuPrKEiwrXb/f5aZW3EYytNe3CQ2uv5DfKU103nR/
ilNBma29MbmVJ9ZJ1ba7JmQgy8RVbzNdErVJE0V5qdLY5jYypVq8zIoMknsP+1y6
T8aDrB5y15z+6m+FOq/8UoAwBkK4WFG6loCPZMMQMxpVRYZxeMG6Yfiu5ufOgR2n
qdyBUDP1qLvd7qdOpOf3DAY65YK3F/Bza2l1FNobu444p1Gvyu33Bn01OUGboEaO
uYB20kc5seO3Y7LvSq2miNFX6vKxTkjRuMtTgtX+xYTBe5qKJ8YjTZzJ5UaQE7/2
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JdoaU4L/A+94C87J0qSrhpuONErmTW8rYAOgWEK3rXSeHqtZEhIFP/ID8dCzlYRl
hd7ZmbG4Z4zxQAOLc2Sd/wRdCs5Du1M1Od148JVBN+XPONX3XpT7WfGyyooJ6gdJ
bUetSyeYmjfYmX6QCOKixjY6shoD+AbP0K2cTsRkVo0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10204     )
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
`pragma protect end_protected
/** @endcond */

`endif // SVT_UVM_TECHNOLOGY

`endif // GUARD_SVT_BROADCAST_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dfuhd5pIC+rSI2r0RrRXJQ/u/OCi8C367gYVqdcrCNAoBFTRVtSOJxNqwgABYcyN
4yJsOGMmTZJkmjt2OC1W4rTor+n4VpPn1O+RrC84aA9C408XjO2oTYsVGvznL9qB
G66a6EOSbNzgkOnuo2sbEjgInw5woBQmbL/O9T5Jh60=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10287     )
4r6CkbTcsabBk9zpY60t+PF1LcOnQPA8nY/Fce1fymxlf1ogsXdZYhVJBhAm87Qs
lDZj87i+GAghGH9mZSwBPa0UIEJCZQjOfELgwt2hg+dAx/nwb25sBGF04CS/3CQX
`pragma protect end_protected
