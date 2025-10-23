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

`ifndef GUARD_SVT_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_SEQUENCE_LIBRARY_SV

/**
 * THIS MACRO IS BEING DEPRECATED !!!
 *
 * Clients should instead create sequence libraries manually, using the
 * SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE macro to populate the library.
 */
`define SVT_SEQUENCE_LIBRARY_DECL(ITEM) \
/** Sequence library for ITEM transaction. */ \
class ITEM``_sequence_library extends svt_sequence_library#(ITEM); \
`ifdef SVT_UVM_TECHNOLOGY \
  `uvm_object_utils(ITEM``_sequence_library) \
  `uvm_sequence_library_utils(ITEM``_sequence_library) \
`else \
  `ovm_object_utils(ITEM``_sequence_library) \
`endif \
  extern function new (string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequence_library)); \
endclass

/**
 * THIS MACRO IS BEING DEPRECATED !!!
 *
 * Clients should instead create sequence libraries manually, using the
 * SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE macro to populate the library.
 */
`define SVT_SEQUENCE_LIBRARY_IMP(ITEM, SUITE) \
function ITEM``_sequence_library::new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequence_library)); \
  super.new(name, `SVT_DATA_UTIL_ARG_TO_STRING(SUITE)); \
`ifdef SVT_UVM_TECHNOLOGY \
  init_sequence_library(); \
`endif \
endfunction

/**
 * Macro which can be used to add a sequence to a sequence library, after
 * checking to make sure the sequence is valid relative to the sequence
 * library cfg. When a sequence is added successfully the count variable
 * provided by the caller is incremented to indicate the successful
 * addition.
 */
`define SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE(seqtype,count) \
begin \
  seqtype seq = new(); \
  if (seq.is_applicable(cfg)) begin \
    this.add_sequence(seqtype::get_type()); \
    count++; \
  end \
end

`ifdef SVT_UVM_TECHNOLOGY

 `define svt_sequence_library_utils(TYPE) \
    `uvm_sequence_library_utils(TYPE)
        
 `define svt_add_to_seq_lib(TYPE,LIBTYPE) \
    `uvm_add_to_seq_lib(TYPE,LIBTYPE)

`elsif SVT_OVM_TECHNOLOGY

`define svt_sequence_library_utils(TYPE) \
\
   static protected ovm_object_wrapper m_typewide_sequences[$]; \
   \
   function void init_sequence_library(); \
     foreach (TYPE::m_typewide_sequences[i]) \
       sequences.push_back(TYPE::m_typewide_sequences[i]); \
   endfunction \
   \
   static function void add_typewide_sequence(ovm_object_wrapper seq_type); \
     if (m_static_check(seq_type)) \
       TYPE::m_typewide_sequences.push_back(seq_type); \
   endfunction \
   \
   static function bit m_add_typewide_sequence(ovm_object_wrapper seq_type); \
     TYPE::add_typewide_sequence(seq_type); \
     return 1; \
   endfunction

`define svt_add_to_seq_lib(TYPE,LIBTYPE) \
   static bit add_``TYPE``_to_seq_lib_``LIBTYPE =\
      LIBTYPE::m_add_typewide_sequence(TYPE::get_type());

`endif


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT sequences.
 */
`ifdef SVT_UVM_TECHNOLOGY
class svt_sequence_library#(type REQ=uvm_sequence_item,
                            type RSP=REQ) extends uvm_sequence_library#(REQ,RSP);
`elsif SVT_OVM_TECHNOLOGY
class svt_sequence_library#(type REQ=ovm_sequence_item,
                            type RSP=REQ) extends svt_ovm_sequence_library#(REQ,RSP);
`endif
   
  /**
   Counter used internally to the select_sequence() method.
   */
  int unsigned select_sequence_counter = 0;
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Identifies the product suite with which a derivative class is associated. Can be
   * accessed through 'get_suite_name()', but cannot be altered after object creation.
   */
/** @cond SV_ONLY */
  protected string  suite_name = "";
/** @endcond */

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
EGehiq6gserQs3s/K0sW1+lsrhENgDnCSf77XYEy2L4umy+3WoE8vm+1/Cqr9tzH
vk75YyKNreveiYH1sUgchDWT20gHzc5H8EUnP20z+dxWuafrzlNWEkCOqOL9f0JX
K5BsPdDqdk8pIRh/hZw3+NERR84Pq3SkjBf1lnmmWe+pHn+JeBcuZg==
//pragma protect end_key_block
//pragma protect digest_block
Vdc/ZD+6mB7FggtL0Bv7PgtKeJg=
//pragma protect end_digest_block
//pragma protect data_block
WkNnMhrb3GhguJwyQD+OIjpWwSKupjbKYds9nOA1etPu0ZnsB14unnqb7it3YntR
pWICvZzbHufBGlGcupEF+RVww8MAhmBIkby4TPBEOmGJnXkO4vxbT4AzJvqcnFIM
cQfp1mf4SpG3FGa+eHgTLywAkniaAxr02KMBLG/fQge/udCFQrcUX8LQuCaujaxs
8kQ3VOr6cGUHSLhixltzSQLOynrTC6qj4tohPpb611BF9In2M4VlEDNRyuqVi0Tn
wbWLOsdTR+HSiwDgZaV3QkPGZVo100MCi/aB9ehD+dcgarUpqbpciXgcZQts6UU0
N0p8+jwq0eRBpJc34JdsEavpP8nADP/RizmrzI41OG4wx7mI7bfMf8kuqRN2tZEt
SJPy1li7j82Td66pE3VO39bQgZaEyxTTZEcU7xIu99YDT6J7Kdtvu9khBnDnp3Ry
zzqrqItFPb4CBXWRRMRWvDlymYo0GnF3a3hfGZQsBhVxYLhgh4h2w0jzoWaMuLAd
VEvdXaUVGqaIbQ/QNThFXyonCDYXXMzcI0BOxP0nYVrW3bhW2W4Am/7XmwhAqACr

//pragma protect end_data_block
//pragma protect digest_block
/W6yIhDn8FDbsBYOgc5/dN8uQd4=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /** CONSTRUCTOR: Create a new SVT sequence library object */
  extern function new (string name = "svt_sequence_library", string suite_name="");

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CIaIoYFe83/5NEMnrtCtDvvSf0t7bT6R7CwduDD6y5vHyMYePf/rtxQkrTcelcjy
vkKArdayaqgoanoQPX5+NRJ6kSDiQ+ZASzEVlgTeCN9Vyq/dmn86M1tMfUN9F4Ey
agEJYgOASFCItdByR/JCfXl44EC5Fs/IRajyTsBTwMLrHjxhLI2pXQ==
//pragma protect end_key_block
//pragma protect digest_block
lAaWG25G8aFcqfYJCwRdZdla7P8=
//pragma protect end_digest_block
//pragma protect data_block
Ct8qAWV15eW+K5cqzlqQaYGJGqYhN5KxiueXh7DPgQ61regwcBMVJclAivW2YcbI
DQf4LT1IcjI8dt1eYWhQAJqODJf5e/ESPivHgJr35OXpVCTaILbtHyMA9792e5Do
XGo6f+3/VQJyepPQaXuD5GpI8o44dZP7Kod3BRpeabnaiN1lja/EP53TnYNCD3m4
m7GsU9l+GZZHVp2hzI05sTDAWV43WY+fKDAvqHUP2ONhU4NVXVdelWxhLcxCw0jU
lU6iJJ8O/qYn7EsmjDAYLCkY/cWMLveFPQdAZEAcADfhygG190i5oKzarmwMu032
1UJOy+hsi9F6MvaLF/QHBRylvTkmvVAKKB0wyWJgEO0gzpyIIQ4xAped7ey76+25
lDD+T8LTMnsgCIxnb7z0YeGKBiqqfGqN/MHFrwRNYKe7sK4JviWpcBYzvPGhgI6q
GBC+Si0/EKHWkrtY6P6Ja6xanAV+9iRk4FfEmKhLDk5Da136b+Tzh4fTxNSyaQqG
NGoIYgNGdkOHcNOw0TQhxFIIchcQ+O67xJ3Xez+/wE6HkWBtj/1Cfmike4Bw//al
za+QlB16BTeZ57X9uTMeNL1QDsrmLdsRGtz4Io62u9jcfcp6pSsmkDbPdwwjBADC
EnGscelNtTHTvWhG3f18DyLHcagi2gTomAyve4zolFpWLrmkGaOb32bJBPLE6owl
cmSN6/kr8POeutlmHvnLUlFt1gtk8mim2VqjVgJw00+rGfJldpLPDss9eDukx5Wg
my9RFVbUGxUQsa4WpJiL9iUxVJS704vK0gm4LJVGlGSjZHiKs5gHROKmhkMpB8WQ
KhNBhhDKcHL0rR835P4btKj6jOKid7UdQ2h++AE0ne/BDrxMGH3BPF4jULK8BfhS
14iSPSlGw0/z+F0778XOtW35I0ghXhdqSZhkXstpZE3+fzINXGg7yuXvjqVBHqS+

//pragma protect end_data_block
//pragma protect digest_block
6sTg1ksnptztbr3+Q4Ir4CwssCE=
//pragma protect end_digest_block
//pragma protect end_protected

  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TbEbZjvxXMKmCsba40FYBjQIJgtH+C6FGei7J/q541CZRw6ls0b1nexw/w1/bUDv
7bw6Z4J8ydg6CHgo5p9iewwEtpznI4ulc+nalg9QY2tAeILPJiv8qI0Z886+RBjO
DERp7ryNMWuF8MAmLPFD24vTZrzb0lx1B36dKKiv/azSU2uplw1rdQ==
//pragma protect end_key_block
//pragma protect digest_block
lCOYXFq18vwrwPHOxk+ttiBj0xA=
//pragma protect end_digest_block
//pragma protect data_block
PY5lQXCsI6LHk++v7gstE1Q+6/PWNpLKsr4pwSIuIrNYEljB7CSAuvvZP+ITnaEZ
x9upz0LN8cBEHbYzep/NMluoOkK3tPk153UJOLiFSsPOHMN5iDZP9shOgv2P8HTX
WF3efblyM4BOPIxLodSQD6J5P4SNsSX2bxWnZOEqRQ2fbjYtxHj0KGyzSO5A/ks/
yQBPe3/yLznIdhZjhyUAbOd4kW1R8XbwyhBg2agdVTsmhb86+f9zqO33jzvN1w6H
bkXC+m8RmHZkqwitPqiHKwJ2c9YcmCw5k+pwz5Pac08PqkuyeBap9+Bp3jDK4V4T
crt+k/wHais895THdrN6kpDPNe1ws5uzKoeeY/fKS5IxlVje03xAsRDyF3U1NiM6
G5G/6WF0FsEzfUx4btOADyE5gpq2ADMYSsnFdJIhbsakFKV57OlU//Wv93mNtU2u
ThLJdxWxiw3U6UMqaClkCq+mbmRrZ5d05wu2+LCFukjHnfsIf4RCBJDGxnX8DsEG
fS7DTVL83/zDVT91MhrcBr8jWH1KqA6b7loXdmqPkP0hGkHyctg/n8nx1aS40kfL
92p2I5C3duWrsIdeStXXfwcaquXGmdiNA8YCj8pfY3d2mqTEdwp+u/yQ/O2yCs2P
xlvE3HODn5RXsPQtuVRwRA==
//pragma protect end_data_block
//pragma protect digest_block
j/zFbLfMi6+hWB2HXKdeLK181ZA=
//pragma protect end_digest_block
//pragma protect end_protected

  // ---------------------------------------------------------------------------
  /**
   * Populates the library with all of the desired sequences. This method registers
   * all applicable sequences to an instance of this class.  Expectation is to call
   * this method after creating an instance of this library.
   *
   * Base class currently implemented to generate an error and return '0'. The
   * implication of this is that extended classes must implement the method and
   * must not call the base class.
   *
   * @param cfg The configuration to validate against.
   * @return Returns the number of sequences added to the library.
   */
  extern function int unsigned populate_library(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Generates an index used to select the next sequence to execute.  Overrides must return a value between 0 and max,
   * inclusive.  Used only for UVM_SEQ_LIB_USER selection mode. The default implementation returns 0, incrementing on
   * successive calls, wrapping back to 0 when reaching max.
   *
   * @param max The maximum index value to select, typically the number of sequences registered with the library 1.
   * @return The selected index value.
   */
   extern function int unsigned select_sequence(int unsigned max);


  // =============================================================================
endclass


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
A9Td9FPijrPNRrukYZRiVUULRzYaT/WwqGyvac6/rJfD+rIqD/TCw4Kfdcua4lER
keSxtWTBPp8qpwy4yq1X+MznHkYiUpoMD/gCRk0E6/vwWihj07EH5L1NjpY64Woa
UOlAcahDIS1XS0OeFPawa1yZWLiYPdfnCw+D9hMEX5yf1orKWn9H2g==
//pragma protect end_key_block
//pragma protect digest_block
wj0/TeDIGvagwFZA2fQ6rQffD0E=
//pragma protect end_digest_block
//pragma protect data_block
rzY8j5QsDCBZlwciPSk/3Dmrwa41M/VuqCPhmnXZw+7tEPO+3IDs+wE+S3g9yfVI
APIE/hWowjARS63j7mlOMRXlaZh4Wtow9stIbL2bpRstZXdSt4sEPxrJFivt2XNU
ZABKYqIcGHXC3udfKtSkJEqsDtsJckdmPJuX4QqkuuzEAOnxMsGKf6RkwCp2nlYT
fKc+vN20rAB+2hK7n8QMWG3rZYYUXmjrfzEyyXrmo51iO2bFsGPfg4f71EWYKFSw
a27q5OPPb1xjiHQWxV8McB2z3kklACiyFVd2It5J05l9PZFarduwbqES6Yaq+iK7
UkfweHFV2pJMPsVcAQxqgiOcCJ1Zo/wjP43MJiRAwVklsJGfGl6Ua2MFjp+2/z5z
M47h1wtXdD0fOWaR0ciegQaUXckSycJDtfvZAyJZQV73pdCY699Y2ss6WTRqcNfv
ny5Q0cSZynX3Y0RvbbiRkPdfO86casFOlTP6Aw9rxdr6QwXfZU49M+cSl8UPhVb3
+Gg2knF1eC6JmUxSw2OOU3JIMtRzWInrV9fxjd8WmNt/1lrEDNlz8PfBEZbRNxjo
+aKanXDZMMTt6kLMQGgDf6kuKZKrb6GbgPHeM0qlj5Ekkdf0fmEIeHkSDeC57L/8
atbZmZrl7m+jHvhrp4FsM3eLZERZ2/Yr3mn5zN2RNFSisXJGi7KJmePrYDO/JvP7
W4fKmVux+7UWMlKsMce6We22cgmYCi6ItOnMCOlN5UplPhg3lRlIO4ZzhG7qdU/i
sixbFCrJVCfQUx+N5HwBr0J4uySOXSfJEZvZRaQ00K5Qe4bPq6ptn4zEImIRgdIs
oiZ1EjAETW1XPKa0wfKaYUtkTpsH14jN3cmRIKz6gxgvM2DMmNdhrtL2NqN6lV8a
s6Z6ZK7zNQNxwbA3iIwcog5UtMJNAlfxoeD79lPmPTspQVNUivncb080B3wwJoTa
7iIQY4ud7uTJMhWQCz1ttuebf5n8jwLrww+hxCo1JKQUxb2x/nfLFo+LKGvAr28j
onDwwwdA2Q/UtpUqONKulrxXVD+IydSlUj9XaWktSmPWahDwpdJ1j/W179yE0xvR
gRmM5OFLscn3tveGQbhtiKCuPF8O9mzdEVqr2CD9Kz5D/De8TbIx7Mg2nR2SDAXW
P+N6U1HmFBIsRmJDkrHONLPuiaT/zmhSEMLiUy3lGRbZz3TIN0ZbrHUufDgObW8V
r2rtWK4hLnzSE/a7pNXeJt7uZwGWy96EvD7vKuj59fsaaM72clD83EPcwSb0blvc
m9xEphu/sr203p2tgMuAc5TTRor0YYFCNmley1KtEzZ12/5qkR3I2l8MVpxUNPB3
1FqigzplhpeYSgqYDb/EtWRSI6Q8KxXRIrDZohaLs+HWqg7TY21qQfAWDxiOEjRJ
uImaoyHr7E9f30kLGvTqC+wjp0wNox688qJv85Em/8JmScjNc72JO/XnWw2TJcU2
diNRBfm/qtUeFz4HNML1HA==
//pragma protect end_data_block
//pragma protect digest_block
A18NMwbpPynfc9Bzo2mkuJ/MNRo=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
t0k1ILNnvMZPZBik2c0YexCjdBEBUfFZmzQHbZ16nNjWYcYKHBUw0q7BpyBfahMf
mX9mt0RlFPmw4pJ98hS1qN6SKxQdSlyM84/5/SiX5sZ++ae3AbzOrCbaodHHsdqN
C1kpNrWmnRBxWe2Y2FoPdSLgPjNKqXHksO8qdsNlumfjhTjNU7J+dQ==
//pragma protect end_key_block
//pragma protect digest_block
oW4qNTZX3qELkc400+1RSa/BfEU=
//pragma protect end_digest_block
//pragma protect data_block
2KLuLYYiFQlqvUNRrtepWfXlq5fSeu4gaHKRbFyjUk7+Gr345a/ig0zO4yDmWcdT
CRb/84SCel0F/WPgFZZsVXzC9Q1j3PyC4kdqUqgwGRjlbDv2y6nhwdF4ReeZDw2f
JRPBXE/wFzUn26bi4m8lusb54D345WTEE3pYiArTUbxmOhpgaDa7mHNSR/Nv0bjo
JZ0qfNzCtUiNq9Qf5/IzASMgO8Lp3C8mTcvDD3/rJEPb5FGIr8G+owTernzHLlq3
nR9W2VMD/JveR6Ad0Nt5kmUSzCcOzW4cbbAPXhbIN7NszAP/6b6wA9z9gb7IsbBY
v/eWeZ+VfPfncCcE6LrxSAqo5q5Yjv3MWZGlS8JE1TS4HZC1jzqCUI6r/hYePtsB
stbkrVHbFzAkUjqqSthGBnOEN4CGadZESRC5rO+tMcafD6l7kWPdLOh3gs+GzeE0
1MszTfK25u1rScxhfMzH4YXUxMncCeGb19oWLz1XLRBlKEeZNMT3OsN8PVygE5i2
DMm0SCI5aw8JCvgX+gSctje/uDI1yXh6NiIHrRJYcTHn1Z/v+0XI1PNr/TWnacjT
g+Yhe/1QzBRymjvDf6CyxtbTPS7F7xoQLVD/mMlzMX59MI93W0IcPBPpKGToWgUV
vsu4BLTl07/S/f59BjpajNqDD5XD8MDoQcZ8qKwHQyQ7EHF+hh2vxll0oQnTroND
eFNxebqbUQyiuUf/FzTR5RlPk7cWOh42FbfmeMwG2Ktq/HItns5kB/xzd8ENYggV
lIfeE6y17IfL6ZKTEedANFlPSVSH+OKdcGw7nOc6jex6xzmQt6XWS1t5BE2aLIWI
e9ysouSMA90FeJdus4PVNrSod+h4QfIUs+SLCqLUnKkKpT4u8P+b3abrh/b7b/G3
UDpBjqawfM5KCrtg/Uo3TNUTR5f2PXuVE69dwLu6cyufhvCJ7YTKBRPLP5dJyXyZ
2qEDzIL0gFplSrQ90ZPupFaaoy6rTYq/Xjpabi+ndhqw2i/zarMvH4ZYlHDwvO8S
c1vUUDG7NsjqRhe5ILjOxsLhedQ1ddq0Llo9uEPNBIrWlE0qkxc3A5wwXiWb9tDz
cdBPy82TO1uL4gMcMI1pakWDrDbLjIPkvt9QCfWsKMaMcVODwp93hIE8P/6X2JBO
5ILvKX+KSJfFOYO+oPVidpfRMBrMb+c8mmaVxT9emdfVTuXjJsrUOsfsPOBRzyGG
x16FEtGyxpG4OWqhFfkpb5aXukXmg7g7s+D/xae31pZS774I/OFiGUw7MPnackoG
85k7OibZbcWo3+SPt8exVQzOdpyonkzFyeLuHjo+E2UGIthVN57MDYESBjbnRTKj
wJhxg2N7snaYh7SeAMeitJqU9X2n6HglRVqgp9fYt9R0J79GX80jz3mJwxtHr954
AgNO0/B6DK0jF0dAKLkICEHxxmlulnwtJ6faaJwovN/aqlCZkYDYtQH/5tCZbo5d
gZYsciag57j/dCd7n75ooY/AagEn/TJDoDb//1DoiDEs3UJaPVU7HVcDueveBpqb
8nsgUxcCgXI+Zmkx6hpz+q4zmPZG3pJ9QCq3Ttf6F1GdSf/4NwrC6I2Ecn4/aica
u1OoLBvelMrP8Ra2GYNhEB/mwZrg69WbvbuTUgddTgf1WAe4hLYHY9LsEiS02Ner
/+c8nGxS1tcH1+SGcVP214VNyEc/IR3GY8KOodUHI2xa2c0BOVSuERkFeYrnbNw3
Y8wFAnZY0Kqut01C6Kpgpk0lBGOAiWl+XfSOp2yruYX1GFoT0zpXcxZmqIuQQ12+
UBAEHmTutlDxHfJu/wVnkA==
//pragma protect end_data_block
//pragma protect digest_block
9Sk6Nun/A642J8JUDOj83htjopw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SEQUENCE_LIBRARY_SV
