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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mUEIt7XgNLA2UqTESpcCXmxPPonwPEVxAI//e3aP4+ThsNgbEqCYcJ5iT/IMyWGx
2dgI7n5GllspNmkXav0T7a0b+exlHCmKGBt2LJqZs2uhC/WzIjxRXSHQgEot6678
+gs0IgtEhs9U4P/ydoh7o6rz6gzYLWWZUW1pwXVZ30oCl0YlugN6KA==
//pragma protect end_key_block
//pragma protect digest_block
g8LbWRJzA8h0ViArByHh8mTqw5A=
//pragma protect end_digest_block
//pragma protect data_block
P5iKjIZfo+Vav9ZPZgQOxaLQL2TSqY149zVwjv+0WmkSowRbDoQzY2FD8pZiN6tm
w6PjIb4SaEl9WeQyRweh9vAHluJverFGi95ILNTh0pL3+ld7jCgLhKT1jnS/kVi/
YGRX4TGr7GgBCz0G5OokgKFqvhuj8Uo1K1Q7324yAGjjoqLevVTgPpENv9vYO7bY
txSxuv1TF+W77UJzUnfkKy6Sg600TIsWzuSMXH8e+KUqUq8A0hwYpTxHu+qtiXqw
aXF+8Au6QNMhWsjYLavBXETH65Q/YgZI1JnyJR9IyJtwvKU9z9XjasT8XFagbbYb
jxMQezImiVEEe6zmbb7MFIShh7E8D7hq8ahLXvnalDfCeC5ofppkfDYFmn+Gd93B
mQMSWFWWvYqEzHgiS0WMlyq16zoowLdaXuqoGljVukp44pGdrKCdWSzlMjeRBoRe
CYqjcroNbFrCWHCMZSlQMhcfDOLnA5aM4DCUxPvLf78=
//pragma protect end_data_block
//pragma protect digest_block
vTZyYo8sKwRd9csbXZ+LQexbV7A=
//pragma protect end_digest_block
//pragma protect end_protected

//---------------------------------------------------------------------
// svt_voter
//

class svt_voter;

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
k+kKXxMnzjGy+zuwdtiWqrDHT1d1niAmnhTyPcesrDWqlytiXcPyvub/d62NU8wT
A1n3NmCnx3RoYXArPhxlfhrTp/m2rzMr307Hzlj7ppY8pIX5kEqmxdYzyzbDj/iX
G3/P+Hv46Sdd4qE76W1uO2jblObrdu8tt8HFrTsDfWiewz/S12elFA==
//pragma protect end_key_block
//pragma protect digest_block
qzhWvXjmBRPGF06W8CWxcgku9lU=
//pragma protect end_digest_block
//pragma protect data_block
EmX1FfdZ4TF+XJJp70P3TJLBpQBS2Qtm4hbixrw3aNtMHcEulg5ThvR5k4BP9b7t
CE6DIf8ZieB1nB+XfLV3gI5pSuMqYiEZG5ws8igCn5Ver613ACofmSRE/6FHEdCd
ZBdaOLZcoBhMxr3Z4j4ErTA6vPGcHz8GPkCtmndplnZOHbLY+9F/oTl/FWb3wEP/
obDa+6yhFrOeW6P8zleqStBmJQQ6P4qE5wkYsb0sOmtoBbfFEggFtvx5P9+k98Vz
aGjvXxLXaEpn4wwHp8Kx3hupGWYc2uLxvs5iEK3PlPGYUvdKoZ9L8C2dOIUKhXSY
E8YkkmUHHL2BNYTCHykskVHKItq99kMjGBLDPhWxbTsQCi9AXZBvYYOpC9yIFxVm
abKQHsZ1nLAxY5Vj1+HU5fKca5FnabMyFKL61r/7Q2QKzFVBRd4boCxav2LQOGeW
vp7pqcWmAJK++kWhQlJB25jfpQxYkWoUGCw+s924HtJplB25VffnLvtbtjvhP/5f
lzh/5OUngEu7regiypsh5X+FXOOM1AqDcjOdGOhb9J7GFPiWP+e7KgpuScSWue1D
6YLKVnaEA/CtQMRW+hlQcjnaJKqj3k3OPevZvWdHihgHkKdT8r+Crw+388KZAIuz
CTdj6nJg3Hp5XYKSsojTFp6pfzV6iRZmwPqh88KRqx00sXuHoD9VzV5yqmRk3aXd
Lt0DWnR/+NU83NwxUdw1Z1/QQ4kS9FF3HtruBNf9DWiIa1hz/VWapStRsL8wybKV
LnEU5lKj/ZltXo5hXJf1zjqbOFADp9QqeAGkCBECc3VppfnFWvzqITpjoODJDN2k
mj/+bd9MVHNK9gWJlCTLf5EPMplAcvWIoQB4fvtWfHsDQ/cyFefVZpxfCue8YZgR
VUbzRT8jl5LG0ljfyWXOUzEKDKO8dfZUg7u7afex8VFIgQpZ6G3PgLtbXcvh8akz
icjTArYB9oIkUn8VWzAaagREK/uU8TZxOgJXeHJTGjTA2lTiyBG2+cRps5C30Uza
mza8lfj/jT5q0LjQ4TKBH7bT/Pe9DJlxHlk+v+PS0IJLkGuOw/JHYsmVE4ecK970
sPkg4NMzcUFGTjXjryomspcLSRrZWoQQ99GHQkaXzzGq4TyZTk0i9JTQ8fS7K286
RulKqcisUYUIYhtRsKFJlFtk7UyVWyUnQguGghTllIEyUqCOIA+PhAnoNzeHaRPq
5XCRXzKmy9oR8ImhXVeLmh/ZBGRConFe5WRBcnpBCFCJp5B+VlpnLiny+uFvHP2N
4oMmOm2FaDCQUrG0/yF9Ua2Zp5Gr4jdo9eDio+JVuTYfLTvEq5Jqwxbv/dqmqFNB
HhZXEQOwWYSFxcQguTr5BMeQKH2VkT5lg59sKTHQltw710ArGUSWajJz8+kc9crk
QbQ3vD6+pO6eEL9EIuEajw==
//pragma protect end_data_block
//pragma protect digest_block
0Fjx2w6tNn3eVny6MxZ5V0f9Veo=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/xvZHGXZ4H5GnPFt/hwbgykdaUmHcv5EiQh1EVj/nHhL3he0UaRIxx2wVJbFJaW9
5V9jGy+5cnLwN2pXHF6tEELXm08Ac1e5XnMfKvx6dUCQ9hK5P2WmAzWFsqlGDcqM
/+9MAeoenKmMVU4U8Egj18mJqmecYHSA+0oeGbnzwJe0pviKTIeJPg==
//pragma protect end_key_block
//pragma protect digest_block
yiwXoG91VvgezExwjU4xJP1ts/E=
//pragma protect end_digest_block
//pragma protect data_block
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
U6XFf1A1o+J3HVaTQj5sOg==
//pragma protect end_data_block
//pragma protect digest_block
FWJxIT+DqoT9uaub0MvEyrA+a7g=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_O/UVM_TECHNOLOGY

`endif // GUARD_SVT_VOTER_SV
