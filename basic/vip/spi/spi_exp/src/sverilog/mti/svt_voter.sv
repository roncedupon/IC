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

`ifndef GUARD_SVT_VOTER_SV
`define GUARD_SVT_VOTER_SV

`ifdef SVT_VMM_TECHNOLOGY

// Use vmm_voter for the basic voter definition
`define SVT_VOTER_BASE_TYPE vmm_voter

`else // SVT_O/UVM_TECHNOLOGY

// If not using VMM technology then create equivalent voter functionality, relying on uvm_objection
`define SVT_VOTER_BASE_TYPE svt_voter

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M1Ip8/XSeseTHTtptQKre8xcbnL0UWq3g8dZHY5+jDyHuK/XYtm0FR6CFnCMp5GR
R9/nwWr4aYO2WiS4EiTe8rMd3aqARZVMpj6hvaxYWiPlL+bGKjOiojkcj6zH1/Fw
dRfx36UkvUgSeMMMau6yN4W8UGUncuawm+K4pwHsRWA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 190       )
eAKIaM3zM5cjBHCJE/es/PfQH67Qf80fGWlIbyGCf1UE+tKh/1W3mwXgdqps7nx+
hMMQaViBbrbCkIPfSMfnWdTnXJEpZQpB2MpipCeaWRxDQYS5PL16cCYMubFe3VHz
YTaVMA3grpEA+YEbvhdfXe7378qlUNQhqUPOoAR/PFRuHcAOZpWRUkkvM4bpPyis
gqIilgeQKFsG3sF8G85WH8jOojW8S9nwpiNKrDLsesqzTBzhRPOTHjsDxGZH20SQ
`pragma protect end_protected

//---------------------------------------------------------------------
// svt_voter
//

class svt_voter;

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M/50tANlU56vWxBqe5QjtXcB3tU/+kC9KVGLYHMDFDNUjjJnaG6SDD/RTs0xFI60
is+gkeONkeVkxxa1CDYjxJEflBkjt1VQlsXx7HzZ9WwYancnZsGT8m+rwrl848g/
dvuydAa7p1lkPWHBFs9pzB5my7Bt+A2vQ4DEjvhOr4g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1083      )
GSqqooYrwUyLr1gYtB9+qYHP6aDzX92BMHLHmE/9NIzZBQv6a1i68rvEnfUvyjlI
+Mr0n630sXjEVb/ezlX0NnGGIKQGa0XoY7e9+vK4kpHCvpgcuSNl2a8K0DnQKXYu
TTRSZ0/F1Mvv7nN+cQNf7UGj4qFEWiMJduJq7WTfoZ0PkS8YlV9ycJMIqGJRC8hy
WutIU7vCRk0hsp9hSRwrz+8X6EwORrmtjaMRq4fVxVAwEs03XnjeQJInDjRk/WOb
k/hERw6ArqmLePRTjw5yV4l3VHxV9yyahkUuZ/7EHYhg2iQCqCFW59B/QURrH15Z
mPDKMJzpzEdKGRqEf/neuiTlvQE97yDX34YWXHJp2MTKmq0VddJVMlsf3Fd/STJl
8ZD5+w2NqNnK2PEy3pkG8FQkCteKg2mhuFYMEDOfiFminpt9iIxp2xkO2AVahojj
z1xVnxv8OZN5ukOlXWdbEhMQxND0GsDR5nE8rZA7hOU+6gLFHmDB83wI3koFrCQX
9cWSORoTDTJL4+M9XMI9fIban7uv0ValCLtCxF5oa6rJ7zAgBy3Nar7TQoj9M9i8
1cTiYwo16W2ziiXcuis0dSDseM7IghthqKpl4vw7rULZl04xaVKmBeoauKREh2d/
eE7Uh6CySVR0o1A1IHhOroAw8o2mk5Xl4OGbuDXsFNcZXeobdIkQvpeY2sRllrwB
/NoUyJMXfRnPEqsrKuk90h+bVyddi8XzwW2nZ2tI0Urq0Cei+ok98Zcnst8n5UQZ
BuTJP7RLJTtlZBmU0PgJ8neHKPO9le+v/wuw4NPzehl5s59qzLPaDM1djSkFw0ci
WYZ7KFs+YAUh3WC2BDSCgygu+wugu5s0XfmgFjuPHm8fp6Fyef3x7scs0cY91XM2
1Cbh0RRzTX/dIqMCQ9Tc9DLqs/I0Zza+h7YqQAYQGIN9ZmzRTcysF8wa2ODY6Fqz
nB/obG9+PpoKTXouZ9Rqjmg+4D03mdXHeDINRnt1AfeZpcP9mTiKIVXWdhul4N3j
qj9mYQi7rQtwljbE3nlVHv770WT8VcDD7Q4/OMuzE1veWcbLHjVMuPAiW9VXW1lq
gsaOjw6TTtUmyhxJzOZv4JpCqpy41Ev7nxM0VacB47v/LlWWP+2ZNCbazZCXZBF3
wBTWmbdKTuN9AO4gkZ3KJpHcwQtTfEeNkUdEEX/fqLQ=
`pragma protect end_protected

endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iCdWXA0EdpAGNTld0gmm+lM1DpZOQDownrM29ULWBoagtaWpbvpcAclTrXS5cijS
R4ddwONaGwylj/T4GMXchh7M1iilQmuB7XZULXE+y3DOzE22MWEgj9YgsyRqi6tz
tAk12c/GjNTMU3qf8SSDVhA1aYAWfgWPFKwYlqX85Yk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3381      )
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
`pragma protect end_protected

`endif // SVT_O/UVM_TECHNOLOGY

`endif // GUARD_SVT_VOTER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YnGUG0EVax4vaKfSfQj7f9bnvRtmCHaYv2RllSb20mDj/RzF21/sajtsuxCiKd/m
lLH6zQjeVLMvhOQMoxFfA753WnXDNjOzF9vC81boWrwcc/xGPzpYcnkuxgYKtny9
Tbyjll1IWdEYHVk6uWhvjFd5j5ihauIoRd/SARRf4e8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3464      )
bnv+WnuOA2Ou0xKJI5rTxtffGsreuxOuW91v6gV+nVKOWVrKjUDKY7IbjRrbMEkN
hFF/yFEUVNf6sAusiFrfWrMJ2XvD89lZLu2kIHwuzk0ilNKyy7S5gDsOLqIMLu7q
`pragma protect end_protected
