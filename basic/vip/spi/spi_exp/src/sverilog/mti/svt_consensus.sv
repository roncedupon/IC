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

`ifndef GUARD_SVT_CONSENSUS_SV
`define GUARD_SVT_CONSENSUS_SV

`ifdef SVT_VMM_TECHNOLOGY

// Use vmm_consensus for the basic consensus definition
`define SVT_CONSENSUS_BASE_TYPE vmm_consensus

`else // SVT_O/UVM_TECHNOLOGY

// If not using VMM technology then create equivalent consensus functionality, relying on uvm_objection
`define SVT_CONSENSUS_BASE_TYPE svt_consensus

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ABWdZYVdvZvuvtRMhE4DU4euRPAxTJ8zmuAmAjOSAOzJYMJ4MYzaaFVkSr9Xrks2
Ezm0cLoylLupsyq0MCML26e9GYk43WKnbq6zz4pWwmEg023YCwcImFOCcJrSyU1z
Q/UgHi87pGN/N4vTCMyIEeyFeajHur1qj+9qHXdUdU4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 186       )
+c97+ncsXh6AA2p4Xl3jWZYO14OkXOKRXKiXQM0d5QvqrLYVgzr43bP2yNCWyPhH
8TZrjxJUXU/8S/oGnxYGswxcSotMrMcI4JiVmvT02MKRz/Ma0NKT6jwBJSYHc9Wm
wIfBFSh82Vsy4YkZjXiBlYwrjtpjPwUM7OhqLb3SzhJxwDLyta1xZD5tmuFt4gBl
SCgF0Kfe+0OmAuekD+DABYKnidrJeYOIDgGayjbZmlw/GPVtIL6ECPTMPY0bvyAF
`pragma protect end_protected

/**
 * Consensus implementation used to provide a basic consensus capability in UVM.
 */
class svt_consensus extends `SVT_XVM(report_object);

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LK1TUArkVH6k8CXQwi9IVOfrIgv9f9XlmYRL5XfdpRjfFbhy4FbrD+UQG1vxjWMf
U2l+DMAxEMrSW2Ig96FQc0Qok7P5U+2fs4yNKskVwwK/GomL7H7cx6mjcfmdOAKD
z0EZr/GaKkTgutpMn9W32P8OHLpATmaf7l8RPgRSExQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1244      )
PrdM40zd9Lof8dmXLVGUESDscSq9jvbPAmpwFw+02KKIMK0eIWu8BD3CNNpG+2ha
8TTAfXGAsY3H2cHIl5xlCxTQa/jQDqFR7C5BuNeZFaKs5pxzaYU+7yAoDFsmP7qv
Sk17WKYTOljr4T+M4fMNty2xQsGXsS/RyRtEWDr1x+iszKYr4d8/KZyLE9ANarjR
icDJZTX+ReePuZzrqO+qNl7kDdLaGKXwHWtEHdraYdyTJGF4mvOFitsWgvIF9hvX
shQ1JLTzHofhNpaSJVaFVeuI/m+UbnloU6MFeiOzgJE2+HR0czILpk8YgprAalqy
DuRiGQTF2UgJtRQ7WIeI698FWLUO+L3i/zvBWHAmni/KfbpfnfFqFn6kmdmRe0sl
C71ZZn9Gs7Aouo/Bh8wMXQM2CTG7IQXLrbaCd/C7++Ed8lrMyM0hATYJkhWQudOG
YNw1k9/Eho2J6LLP93HGc8FkeZac7gooD2PDptrQw3OEwQ9iHyMMvOkL5sg1fBbb
nWk0j9BpnFsAm5wf/4ROvyFtLeyTDPoJjZF7en42tcm2gHb4t+nnwQalljdPdrBX
2uf5IB7Tsxs0LQwZRflm/U4oUy3wK4jlHXH/tOddYxehjiytKOkahLKn6zQfMWse
ky4+jBPB9KoC5mLw7WNMnAg66zoGb/8L3D1AmhIhrwp3FpiFo52n5+Q441QK2Hbt
UIiVhvgp1OEwXXtB1yEEviQP4XoKKpYBxrq7RmzsldsdGAZQR3HiUhOOwIGzgFxE
tW6EH3ni1WIHq/w5ATS2RD+OttIYVbDtDg4ZhD0v4ydtU+WTJATHazzZVoGk+d0/
HS6eGU/GeY32cuuUgp23n60XX+MjyKh6vIS9rAU5NJfqWrEf+J/63N4Lq351tv3i
mt7XUUt8MnD9PTQbbKKAPHbw2NoA8zWDTl6zM3Ad/qt6rEMyFgON5rlLAGqWEray
61rDhj1WERWUdjw19sRtWXGdtGnXvTSw4gVz8yq5gHKK4HX3WUCHZJnu9AbHsIO9
OuLAriWV4URaMYLdnYyyQ7sYAZY1PbJ6thSAnoqkMJoae7ZtPvqTS9kZ4FOp5E9w
m1SbUgJbaOTnOuk1QTYO9KDO5B4MxCUaWqgrbUaiWrjFeR65VOGW6d8OoBgvu/sX
mIU0E5I1jC/2pEa+nJOWj+4aEYAAPWczfFWFT4PNTaVU/7IR2YYM5met0br7ZkuP
GjQFrtHy8MIvAtekL2y+RjFpLPAzDI6grXYfom7BHKfjo0iLL/eI3OEpmcNBxAVu
dwkm1QN+fKpK9NFZE40CwRzhBJWu8Z5vX1UBljkJf93YRVbXl3ImFC8o1cWAsocz
Z4BnByswrSULS2+Z9tRDzyNS4ogOHuYBLfbI2jMLsX+bQCKMb5YiTlAc8y/WbFA7
StEwSKo9vG+AcG2ftuHY2g==
`pragma protect end_protected

endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cMsMxufurac+5a/3zMHS7XLZpb6hkVe+Ev7zD3W2PpVmPloFsaPIgT2Tkvli/ldl
NVT8ZuppAfajHHem1o0ZMxDgo2Pt/7H6UrXBEKzieGLmF20a4XXe2yC0dfswqEa7
qxqiUu0+DHQS+cnGZ/QZAx8HnjDig/p80k7qhH6NAEA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4210      )
YkXiKEYWzEXK1mbE8e8eR9aAx/pixg7opz2SGstT3XNHeLu1wTB+JZSOAbT3ra8T
D/3aTZ3oXZihXf+BSb4NAfuP5lo1KCc+nD6mmTBa2CpNiVkGAcj0Ux0naEKnEG9n
gWijaI763NHVWE/h7yd3ulbdDb5GSqqLINvCly0nYwk0wuMVfWl1xRn8nyvkvsL0
tW6hSpVWd7iDzGff4OPPdkxdnIEMamsRfiACdR86rv1Vncy8DFos/1lQkuVDMC2n
fbOmlndOmaTnDfmubeinzwfn6nejD7hmahAwRGDuqWrJDQF3V7uayznWpnC87yX/
zJ1ePZcxWD3gOIBwcK0BlbSRyO+HsZQpt2/j0W1L7AxXm4G5WbnHedZuYA6uZYiI
8VMMU08h8+fI3p61IX6hm9cmnlK806x4fiRy6Q5gjBs2cyYvKAKRFDEsklb2Q5Jn
FPLQXo7eaoHvq8RNB187v0kX0vri3wnUM4iEP2MOhKII4EYaWQ/m90o84E5eDMnx
k+pu7x8isuhGfMURch7/cnFJf+WAnTEosuw3FivgW1SihC3wqbihupprzHQZTRr/
tqpaptgGh3UQ7UufCVmjMBagdRMpR/iK6OSESy0zo+Mg5kWF2MGKxpLB/F+ui/R6
lxjvQahwJq2uo5LinnweNF5+o72zU2HP59V2KrUVA1DpARlcBrncIT5SWZ09SAox
ctX6ecGNjfGwr5IBFdUfAlXjQoyKAzCEvznkE0K+fF2kO6sLJb17rxw7pu7vFr1r
QdRcIVDFcRVBLIYCFx4FN8s/hMpUXQ/wUROk6gC81hdXh2wgaQTGLsjyuEfUjIXL
s2Y3ydDpv2nO8dzMM0ETPya7PH3bhSvLEc+/pENjf73u4SfCiVwhZ597TIAeFvTW
qD6wcqmhQgUCemO3UzF9O0NwxV89PygcRaTUWZNirauSZORe/j9YWIfCUJ/0a6LI
NflN3cX/yjIL810H21vhKxqu2jGBWt0qixwFjKO3ruo1ZHIWsEPl3KY44vqWVepB
FsDaAaTogTcdx5tF9Y+egnGKUNXBMa7YMVstnah1pc1OoyQcx6mmOxKPcZdln04O
r2Bf2ZO/UczBOL1+GB9vqrCb3m9M701iS0HEhc3DBbFigIg0OQt65b6LfizV6Dsy
7yCDPmsx1Y7UC1/LRLwgme4nylbDEinxONSa77JS0ElsQJF+cIUSkZDIiXxWgPMk
ejElJtCO5QyjsJw0HBWvRzlrspoMMOtiBMF1V2YCGIOyHC7+d8AyoUbqenOJcbER
jZPq0pKh/61b2D3/Hizt0c3tLFH6FYJrYeoJUlxihhitn5T20ERWxVvrfaQCts4N
ro+SvNe0+GN6wNigNWp0TQW4ScD7h2ma3OqEea8fH5m3ST2jbaHg7cCp32mov1kg
A886h0GQlrhmRD9/mzeiv6IpZ+eoIGEg7OaRKWX2xJakm8cJHTMSWcI7MUYXkooU
R1EwfMYWQKgsIiAEF7b3T4ml+7wScXkQ/6zxOjQfaxOl3aXwIl6lZKt9pITXO3vm
lfLJYMWst35gcYzydc/NTbUxBETfOVNKqdMTb35tkbOfqdT1cEah/xvMCP6obJv8
02g6ts41emrI9RySSPW5603INw8bbqXgdvVj5Jfywd8wSZErlpGTZvvZRoPbVlwU
q95hYrAL1Vuv4HlfoSkDSFYO+6wtmsAx38ifgXgd08V7E6WBLshdKTGu533UjRot
/t1t3A1HHo/5VF9F8iFA1SLJm8qmIXgNfoKm1nA7l/o8ZSi39RHlFz2F0sNmLIyr
Cy/O2EPTmeHDuO17zIVAZ2ACThSrs2VT6Y2sqEtjF5D4yyIyMJQLD1bx+lTCGIhv
eH4q91T398chSiHETc+1LTJV2yvECsZifKdfHbVYiLdbY/GZZA4UpL9lRWQWysDC
e5+iie53eN/nmnLj40ug3j4Hfv+2qVWSeUfcQJ/EZNPPtoKN+llvcJxnUax/nDZs
I1V5Q9aLLabSGYqG1uoVpQXVZP5CTHf0tJ36gwStAoHFTg/nNu4K5HMLnHHmstBm
2lh1bsDCui8Qjwc7nhsAD1dPvMHV/nEHLJgAaVD7v3mYAI/aQTrxRgPQ78m70eVN
VcX6z011YT3ihFcsYEsVpdM+gUo4p/z5SEUIDvwvI1yoPMV/jUuICvgzwXmnlYi0
PXYTEOrbCaDpTPF0kf9Dcba5hIZDeLrjIwQBp3K4ShTOP4yymIPCnqkCJIfCoqTl
KTc6ynfJSxkxgcPrN/ECn0aaeZdfXINRjPoV+w6xeHWUyd8DxDuoST1carokCU+z
MUi0eKWHvh0lGFTNtzBaekMX+PmPL5ezbSPjryW5Pi+BD4lCtLyohzJgWweimoe8
JzW2RnEtkywW7+NO5rlQimFDczX9ZCYqvEsMuHA02AWwFQgRUHzGgBcNHdPYpfpk
uTMRpV9msuq9kJd7CVi/23z/jw4K2FCUqSf8SjRvHbG9ftzi401UncE6tS1KFSot
dmeDjDumgcAOt9elhHd2FJdJAt+WVW0tmR1rihpXMzWamN0zoHef61XE/jrzmm2e
sxbniZng88gqld5bPeLhAGrbyv/EI1AymKLUKRdGw/LlXXl5neiFRvHZ/Wt2A35o
Jju6j9yoM7KyFD0/Ifpg/94exQn9wGi6KGBFz/eUT7Eh5tUaFWA2Pp6oWamgdp/f
pobPS7oFnHzFVNwcXS4pbz9eag725m0pY8IL1iA7qop02bPdx+NFC0DZ3cYkhZLf
KmuPnivqWodiPwf9cETaQbzdwLw2WFiGCW+mfpvGd/B1kxs27d+s+ml5f1MqlnLi
kdd9grXO7whuXhnkQR8MRA/JslsNVYMAy88LnNj5dTrtRhbjJoUOgMy9uShjlKCm
Fh9DwGxyT07pQYnTZTp7a/Bj9ttUPTDbxrCx+lPNQsosMOmQ0Gr12HSPqocd4zoD
ErMlEvKB6ubd/fs7CwbkV7JTgVPF0hcq0H8dkThtZ34hpNhC7LSurCNCbO1/UcZ/
SB0TlB7nn2BO4yP9RHvKEb4i48E4A6wmwCxoEUICw+soyxKXiVH6OOLk5l7j49il
PCexf2HB7ofbwrzuIm+yewW2k15/9pjsgZSP4ylzQSRYQM865s1CEojP/8tYtDf6
5I7AjyK/IRKPLioZsSGoLTI9jdUtC0V6QTz15F/Fqro5FgpVG3b9SssnhgDG3Miw
6Yie0xbtLmz/XKGkopIcK1q7z5kIYk0WNmY73Fz4zZsQ3rNL5Sl0R2Ny3fF5XgWu
l/Xaxo5neZlKLOEAP3KRRCKiuIOcqLQolplQFhJ8TtWqVVWKTtyy9Nm3yZURuxHL
ox9wN38Wc6CFHc/6XhfFanFctzTcxZm/17t7xdYeI8fD6qtQ69Xh+iZjO4cbp14J
lbkR9+ZhbRijfAhcNgR5jca0TCMMW0rEGfZOLNe5DaRfXghwt809rjt0IZB0r5lc
p8+B9gswW0MS7/1KihzlIXLKLxrCd4tUyxWuPujMYx6uDCf785EalQyrbwI+bUQ2
nwdumqTvEBzJbPrQJpKPv1my2caVcZoRy7LLWMdsRedcxDVR+0p+QIXbx3Upv0T3
+lT4EL/TTUpj3G5f7S1gojjKDc2rWPgd1xco/o6UOc2s9kTZea0fdHd31wXjOVPj
DR+AGMYMHaT2qX6YbDsB8IcVOgzO8jX2LIRnQEMeDn6R13R+YPDDw7djk4sahFUv
upR/cY4Tf5McZx/0TZJVPEhR6Pf8QOg+waFdBKk1/Lh1OPqGkWt1FlrR4yUQMCeG
AMlhb3KBz5jStOaPuntuZhRWH+lHFX4uahIoJaxbIyrlawx6VpTatRqO/Xs3W+N/
eRnUTfxGhONHhq6ClEsrbH05ZtZjqYNO3de2elmVhqcB7PFRNsV4NAhD9BETttzx
r5vovZljgTF829Cdj3jCFEdnbuW+YLH4Kj6WtTg7MDomEY7zuWOoEHwMYlaC5FTm
`pragma protect end_protected

`endif // SVT_UVM_TECHNOLOGY

`endif // GUARD_SVT_CONSENSUS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SuHwYQz6COqxA2NHs4glkhARWS7uTtrvwHrvj0bMB9YcWgBqVZRz706a1isixNM9
2EMD/HDYKL3+UVfPMA7qbadF4Tmoh8ZT5K9UKWZCqExBW/i8APRtnSImQSuTEw4O
7bn/QikwBbMGmw+sGvpuCFp9SSAMwUjJFAEEiftg8VU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4293      )
8RjyDOdd06b7w4P6Ve0ZUh7/7c8zp8Dq7CDL7IehjLMJ7TDo1aCjGzGo3h95HHja
c4MunFF1a3KECdmSt92oLiZElR1ebboalc7QawA4VGH5nf1KwFqXqXIDiuF0e5w1
`pragma protect end_protected
