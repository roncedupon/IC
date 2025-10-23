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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oND3h+Vmt5vGAPB6EF9TANcMJRYCWn7iCx/T8VuIB+mvFfhpCC2jt2lpTZJGqo6u
yCK01UwiZ2UFnN+qhxX7g8meOdRf0JaCAH8jKN1/1cJp7W537kY5aCiOTukS2jXe
KS2c3Kdc+v/akuolpN3BevDgtzKmHZLsYKqXqKzufSc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 252       )
iNErGfyaKII7oQfM4WiPrkJY2591Sc9qK7LJ7TvuLp3zhnknO3TqdLgvWJK4C69l
rtwPPOEmAl6OMp65VU3NycIdh0BGeY+i/Ix1W7r63LIJ13/94PmvNyuMaS1gEL8+
ogQO+eflDk/336DBHgQqNNvEck8UhzyOKt2ZZQdYcrltZO9Rj/Z1bSsEMJkzWh93
hUipfK3Z25fVibFCdIH186c8nyTvuk7anrRi3dot7+aJpjNmgUCocRqyM3Db9BHJ
ppRZZ/lJDi0vCRs16D+z/d2AkvrbdYxcSTx35W+k40APB6ImaDQ+0sy/rahc0qTw
GZIh+kQg4yxrZAcHf4YJuQ==
`pragma protect end_protected

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /** CONSTRUCTOR: Create a new SVT sequence library object */
  extern function new (string name = "svt_sequence_library", string suite_name="");

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TqVu5QoytlL0YRq4Oj6jnKJEVD3ZP0KMT0G1PB3x2b+0pzVtzotCGgMY7bPkRh7e
Zq1HbMI4viNeuj11amJaX86vjtOi14E5ai/Dzd/iyYUfmkDOCEFHjwfmrlJt6nu1
ZpQvt31guaiqFNR/N0piiDeMcnuCAQrZXHnLiAncjn0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 799       )
JKH1JFZT+90mPAWr5xQv67I4Vr2RDbkoyp22+drQCO9LOW5MeTpy5nXCH3j/S6WW
5ccYGM4fHTjwe8CcoACdTXLRtM3yUWGG5IgS/8CghJDhwqBmreXtaKtdHYYxhuKP
+UDwrYAKeYxpw3VOLJD0ty+5EJoXeH88F2qWmHV6r0eG9hxkZtJW2EWTRqVz6IWd
pzQoJYxtdzRHJtKmlBJLY9y3YVEcaL3UTZjwifnRqcRt0VTXqVHHRibP1lXZ0d5M
Y8Tkp9mwGK+NL7Vkkh+V9+Eb3c86VRKaKuJ3TQ2IeQcbXB9SPPj+4pKsYHR3TvYv
XfmnSnjVxUTdA5jVLmIqeVhf3mb1boXM0+JMgh77kCapjTu2OXtadq0NIQro2D1F
4ZnZQDHgMMUc6XJVkrU5fjS7eycg94U/+1bchTnICkiyQz0/QAGZ4Ll/1pinFJPM
8RvZcf+hfSuGhicZEpUqBf42hnd6BVsQNqX23oAyMZx304Rgnc8lcZYl12MbREWU
MFHQ5zHjT4pH/mVfuVK62SqTMEJkmzdSMf24FbocK+iKTSUj2fvLEqv8uRkKqNd0
2RIjrrP2qKcQQTkEesGOFM2c9WuDIVdp741nfGc4Q+zusSMdaZw0F8+CYzV7lRoy
hMYheUAIzB3k+YJcndzIyWTpZCl1f63OHv3AoMOgp5f5WzVoq6+00JSSvRo3OgjH
b/5pdlxwSy2a8Y0ZP5Ans0DW5l+lTBvCbHqBvMhV0No=
`pragma protect end_protected

  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WYrIfPFOp3Z6GySJbCmvl2RWPWtQeR3fexMOJnj+ZPpavVJr2glXGHp6+eMjHOPG
kkYrEnoky6/VAGqU1uAD6lV/ijpq2mX2IY+fQ6jj/gKDW7GPWZKs+7VycpKXasWg
1+CB4y8xZccDwh5i2izROxrk2xVw/MoOEJRbIe0keRY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1123      )
b8034r3wSVb/+rXToWbUohp+vXVUpOQRT25kFUqCk4wKcF4VV06c+/Z56EMWrnY6
Rzr9glkha6p+g63y1NvP8cxF8hZozvWuBAD57eDuwupxjlYXMGeO2rEIHsWXWIPH
Cj/RPYIMPk8DX5pe41XYM+2OUgcB6yE4wbn3bNDwTVi1t8o5FyPrLAGLuX8TlqY3
E+alaqcqtYfORN1yiwc55R8wNzouuiArx1UgDlp46A4clhNlMyTxF+k0bQZUrea+
OSuRDaAVUKvzf62p2TNWsKEf/jwAFSTDfeUBsLKB3vpMbb+bdjtwKNp4/S3JRu0I
BPREz2lQhbi5CIid1qovlCE5Fc7Psn5TwIZMGjsFTqu2zTlTeXqUedbb9dHtFWih
4fUNJbATsZ9OWjGdhuJSps5OhB8bqpUf0FC3ZzNAYfc62r+tcHt2I3AbPfwGWQGa
`pragma protect end_protected

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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JBpJQ2AI962AvsYvnZ/HAuErNgHjAHXubjLgntIgvcfnAY9nfesoc3FmV461DkNp
0Kw4QdRewqLoqrQSqG44PRhRfLYPk/RhG2c8e8jEZ/qPMK2EuUa4zkU6PAwDGJbG
AViuFhIhZYqVhMfCH9DH2rdM+jWLP4evlxWckhof31c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2069      )
RusL0cUPdODbpMxOjQcbryWxhajn9yxbJroRz0PR1xiUsEm/SEfHJVz9YJkAvQVg
bXMTvBWXMixTdeKjUKg5mlsLG9zkg8KU3ALF9fekSt9RlGWJHzuSK4BoKmTj2BvU
6hZZdh69KkdwYMRUTC/7JhFKYXdTPlN4lNvtoDjQ8Lc5eOaejLVFYsYOz6oDi+r8
W9Y5Gz5wSASEYVncDcBMdQ3isGH5T+OhQA0UwXo9LgOvul75yrHr1OKpwuljtXZ2
wyHheK9nZlGnN8Z6KyLcehDEYZk+eSmiNETzAueiSpJyCRShDfOO34rwu2AUr/0H
RdxXTWG7JqaydDlOWCGuDrJw9a8SEdvCQfdaIsds/acKwXbM2e147UpFJztGXmbn
SAPbn/oNuV5bNBODl59kXzNjhSzE4eQupQlZxpajmbTRNN/voCa1E0ihPOm9bU94
inrYnhS/nmQjZi7REhkgnHh6WQyVMHllYt+h69HIW1r3AZ6KxdghS86G2nScdfke
qPYlPn2drPVoEjrZaVxQp9C+LhwnK3uRckeGfZ5Locu1Cz5oOwl5peJhG2Gtuyxc
LHQDJbTxrFUh189ZYchPdRs3YA3wOwkgQYAygVOe0HCPtj98/7DBHXpCS0z8IxQn
3/COJtXE1PSYlAEY/jn4c4Ng4Kbza41JgtWGArVDxZA0mwEqY6tcZL8tMLqteTqp
IyDD5rvZIQE6rWB3zkjzTRQbPixpoYe0eQbs4GcqkNqxSytdUNlR2jnxF2Id9jQG
5lGNMzZ8PPjrlL84bnpCC0XUxhjboMyjuuloakek2cnUwA/hgaytCbYS5tr5pYw0
dXPEa066BTMr/GtnwygnVBOT9nBZ4c9f6ni395bFZhIKILmbNvw62xzjIpwlJCIL
D9i6EcFPqMCH0XtMtqfRuyrMvuetV1FYvYj8G8z2EppvGQa6iYw1PfazM6cs4G0j
dCEtYb489kXTjAwMuIs39C68j0gCrZ//vEwhU3+GmX4Dx+yMHO+0FOYKn4yuNM56
+gWCJTQzo4mbV61o35oGFdaWS8oUpwPl8u1b/jcV1CNu3TJewbXBJ5WOQAFb1xJp
FKcPk0QaLaG4h1nmxxWuP9XF0RYYh3qqe/6B6Ey21XaZ/B5HZRps0DGiaJR3Buso
/i64dIzmLJO1TXL5vncHxQ58RE8X6xJk4myjg7MfkRjDUCyxBmCjB8g4q7j5yBH+
pXpTR7kQs5wP2vLZoEfZ9i6Qoqqozl2HtL4ucuz1HJ7m/0A3uTHCoxSjSHrKZ+fg
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WzH6FPICFeMh2vBQWN7fcM9QxNkcd7LnlSSHUDCRc8ycMz5QYPaf8ZklzPp70Ymu
Ok4d7xaCplqj674ayyW+Gz2Yqh92mDBks8ifJvWcBXOfYwnQKRPxv7cPPP+e1KM3
2CBMp39J1qCEuyswTTXMbnsLV0/p7od1M88uYqTHB0s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3252      )
NeSxahZrzsnhld5QEzGNJ0qiRY8LdtWdwPaXWabBq+c3JOJ8r+OW20A0iZLb86X0
t9BlvMB4RGxp6rPoBzLo6bY2GhcA4yPz+VVrpYRLEgvbHcTU9bwn3wgeJCMOAj3/
BkK+jHb6qCxOkRiYdlLXAsbESgN4/WZQstM87yJMcv6ZVMyjU6/PRkVv0Mxm3HJV
1bm9CG7hs7Ajf3B9arj4ohlTSGwHVuzi3lsiEacig+DDo7zMW8NqbFZ7VODKvmxv
ctqfC3vlSGW3yOisGgbrLbw61QWIsrzBxq5uekX5tUMhYJr7llB+U18hpAsI1Jwm
jPTE9eAr9FmlRmjhVI2etywLIN7gCIXKAqdVIwlFXTR4fLA2wZFiI5uDqCsjDEE9
k2vGEiZli4/y5XpMQVjnKhqQUee91dYKZfmFUDa/PJfxWFAKmz9vB6wme4wdMe7M
U4yM6sqe3aVnDlWLVQw1i+hmeBmOZf1T7MvmiHD+Fo2otsnItPOklDyNRwoAVEaW
aFV+JX3K51OHK0XxR5MwoATRcI2K2nF4jYyWnDg3fGTpp2PitTCtsO0VQr2lpGzS
DQzm1G61cN5yeoPK3HlQ8qUCx+MT5CE1Efeo0PcmK52rQJJb0jVHAb1MAt/Kv/wZ
1WWHtvDVUAb3v6e1rnPyTX66nqocyOA7tpPU2DKLPYB/uWokGp06HcHPHxNzv/jD
/DrX30kCxD31B0NrETOYfgBleIcNargxDhRxPPWGbvB8oV369HNVOxIkH0AwPbc/
92qahoeKnSZNpXHW9lXCJu2YkwJ8VE15xmQi9CMbThCS1Wt/0kPYeIEBOj/hWA9A
g7TdYIwRS2rSMknp3jxsd3Q/WONfvbhw893V/TgImlbtvmB9psnLI0kmKIxyU7FV
f4OdXnOVcGfjUOduaD3GgGVxqlZsP7t69FJh36vV1hIYItnt2dD23YsOcNPy8qNw
VKY68FC29YoXocrgpwdHfQEFA1HSiVbmEVciu4Y8mb5zNF8eom8c2Lt3bv6664zP
vOkSM3poNPH0O0lukcc6x/xLK1QFvTZyvPsxNCRFB9HsMsoi7VhieXmBu9y2Vjt1
BKdHzDBKHL5I+JSz4HGuNrMeN47aEWQ8fhJFi5usykv1asV+Cird/FXkaC9rASq4
5eSAiYOEbDc7YDvsCvyku03MWVIac/xXPsK1VU9ZGs8cn8bmllu45Bw6RFvd+BLQ
Yxkf6TsMEt9rxxJ6OgU2GpjcfWSsl4f4hfGcynOFIkR1tgOF3/11qsr/M8TgBcdP
QKVXe63N4xcjqZ5RG1QUi2/xJ1HBw9XnSA1nEllWPnkis5vfItIJNb9NBVJPsfvA
JNZ5p6q7peX6T1aOGOEC5lFJwwNa1LIYopeSossjInmKIwgmsLXqT++EDYD3PwbG
n/5L/5sDNqtGWesGVWpckv4/liOjZDTRsF4RB5xaumbYQP79ehpZ2QV5aoelcTLt
GlSvYmJCC0zUgj6eDgCC8ojK8kd5Un8s1sw/bzM4Rl0jamcoYjZSI7zLf5yXmflz
H9/T7eQ2T5r0uzJeIDIAXIl26HuHP/wsrDEVZSo/5lU=
`pragma protect end_protected

`endif // GUARD_SVT_SEQUENCE_LIBRARY_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pLdEsDGrB9Zo8RxrVasIqLloVXL0b/4n/rG6kGtT7Id4kxgH8DCmy/e1kx+GQNbx
ziJCIbGGh0kYgjuMMX/kcWeLWQXoNf8RO5l3RuwuOriZ1u9IwUsOWtyQel7AQ2ok
Iri1IQ+t9fLbMPPLzt/b4EhEKkoeKxSdwN1mFMjtVDA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3335      )
NDolnahpfGfHZVFIo+zZYNy7hnWsqjtme0Y0ajsbCYt9hEDae1MwYG4OPxOXePeL
vepfqD9GwcG+dG0VmILbEymcWkp3fw/37V2kCEQh5emQW6zPTnRom94CJAhzSyth
`pragma protect end_protected
