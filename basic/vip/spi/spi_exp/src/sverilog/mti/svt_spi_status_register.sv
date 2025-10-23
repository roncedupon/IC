
`ifndef GUARD_SVT_SPI_STATUS_REGISTER_SV
`define GUARD_SVT_SPI_STATUS_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is the SPI VIP SPISR (SPI Status Register) class.
 */
class svt_spi_status_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Mode fault flag, this bit is set if SS pin becomes low, when SPI is master and MODFEN is set. */
  bit modf = 0;

  /** This bit indicates that transmit data register is empty. */
  bit sptef = 0;

  /** This bit is set after received data byte is transferred into data register. */
  bit spif = 0;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_status_register)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_spi_status_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_status_register)
  `svt_data_member_end(svt_spi_status_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_status_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_status_register)
  `vmm_class_factory(svt_spi_status_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Sden2vYLcRZnKd5bYKZZ6A0k9xLkMMUzEnXEU7UFy9FORadpYOCdgSveycnLGvOp
iQXb7cyu5pyUgvPSCaepZ78Cdnx15kIVtFKTa/8PXbJp7RaW4Hh9u/ZzPcf2nJMs
guwda1W/Uk8sE1wTaYJSEB5Tk98yaZa19xGOEBKgsM4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 587       )
nyi4RP4IEVN5OlX75s/y24xG5DccLIDF2ULQBuX3eN965DlPuRisoEOHKF8hm9US
D+lA2bYNuG1GaBFpO8IPiYkAOFQLXjc3dPkyi8HxN8Ddm84q1OK8f4oLyPUSZQlD
TtMQ7O76vYbmFR/39JXuJ6DaTOchTlxl+5EspSgcEabSAdqr1dW9Y5ksn6LUPoZq
ktPvBROmrxRoUXx4ifXJwxs1dj2jzoBm8SOb/MQ4fICpIFPxZUpmoSN4fgfMrhsR
WytUwCZXO6doBYdJL69/8rziXZqY/2aBtsBsQ1YMJywknedxXuzSU0C/s9WKtMjy
bB50JlT29n165XDmwuM5uUQjbB90iQrLJB9NsL0ecA1NzA0bUBsCOrNt9/+9lNn5
CfFVe3/vxQ77OGt2b8/t3LN7yrmaQ2pGE3FQg5gG5Lu77yaK5ZND7vAneNfXEIBb
0e5mem2seXdCkwMLLsU7pLzpjq+wg0PpuDXMl2k49nXGVd+fAqh0kDN06z0kgf4I
Azp6EoHR97VAov65RwmrAR7+GgnvJtRWSojlWOoOUGA/oW4hARLlndtEJoknwX6R
cVcgHoD1Yx7eM/PNoZJY1bJ0Z2LGNUPA0OlDJ6AI/JabeXs2DYQj5PXO8IOBmPal
jRF739G1sI0UnwVj6xx8N2N15IzW4VF4KNEmHd5FSViwvOi8MNWfRBmru9UhqNkJ
Ey5rHOELi1yp18/bXo9ytzeoGPRFcpFuq3uHQ1GS93kaorNRpbZFULL8gBFpbBj1
8zF8neovs2bIgSrF4T/enA==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CQF8gV4EsL0v5+hfX8hm0L+eRTurjfwOFN91RVjXhD97PWo7/DPtD8OALkT5yS4+
xI8Nmpuh7EKbZuk5qOnqRSVwsNkreexC4lwgNiJ4r21D2ZejlVMIpVjBSbC8zR12
3sR+XjrAzTjtyJ/JQfRlivYQyORTRhIogzfJapV5si4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7688      )
jm2IEH0//jT/wqZDkOGNGpAWRtlotCihKrMCiuOrDi40JyX91GTHpAL9d8JdbbWR
ylYHMr95quZDryYg8jBDrLBxkuJDuOcRdHYfFjYtUSqMm0q9CFDJoTMZnOXXiyxh
HqKLkSdoM/6isK9xJEo9eWbn+yhWnvMlxT+/EHnzmBWBsfrf/GG4YIywSvY3D2cq
BxZCA9vVM51zFPEIy2NKgpCXpXYG9UMSSqYXnOEU2kxBOFZ62zOp4OSKpVK3VRpz
MUfqf27BeIqg7AppiGkbLbNtlmvKcUZtjhBzJsXQwdwxY4ZfKlUnmvTTcnx8aOQo
LUeVo7ZFKYcOkw4T1lRobPSlCCDp6t3ZixVC/87dgvZIDLF505GSWhLzsiiSxjGU
exyrvm9CHWYvuJh3NgQpnCpbKUMMPkcnWTLtGvMq+u9HN3sWS7qmNuW30//XiJUp
xCAH22uIepaTCYdpv7Sq5QGSzQFxGL05FlKKxTA45pseRp2HMgD79jSwY57SLkyu
pmGwACo+uxlBqIwjQRLg3hpYIK3uYhE9BjVu+w/9xhrI8mgTjRXVzwiH7DNGdjmK
Vv4ZHDRxx7PQzQ8xuuJ8q57Yzn3w5SFNWABzhm5/Mf/eOXby+CLdKdm1c7dw1PZ/
mWtpwf8CEhpTopFqkw0E3LwccFJWf+FoRZ8W5E+AfhbiOo7Bn7/fjRm8dDtrrC+w
mFgS0+qO0G0HgJzlAH5Svu/W6bzdl2Pm5de018imSwWebw0RGHw4kOgAz1dtjUTj
LM7nEJ711pYbm6QmiUow4LBAGKdV6LSNMUR6NA0XhOsk2aSJRXWVbxmwyYRCZ5a6
ddA/K8KlzBPByAoHW8mJhHm4yte9TbxoP2nzEf/AJMXYS2H/nGI6fUTkbQtYn8L+
SygdisN6o9Vcpl52TMp5G6WuKFRdsECCiDcAiGSrKaSwEsXhmgRzHzyThpFRoH2Z
+vS9hoN4LscZo/mdRVbrVaKvAmezH4/VF7+yp8wqIk0q/9Ivaw47yaGZgw7IASM8
3L6vs+o8hoFKgpxBDJi+31j8ZMDGsCI/XS+A6nrX//Ca58B2cKVncv/oaDePGkXf
1a46f4/MkvcQtS9/RYwvTdrhOFXPcMCo1x3/JNECcPQUCOYVw745pNVXbUZoD9hl
9kNkctJVZEWMxFBAKjNJiA9/2ZmpYj9QJiGxJFU4GvfOGiovO6imgK/xKskRsl2k
RCRbRmspMr0rNIpKfN+Q5kQ8cz4HMd1TEtKx28uQnh2VcqOuYHSG9uA8nS05QkEy
mcuJnYPxi5qGaQvWymGAfo84lV/V+ZPdu5W3C2yNBACKPKrka1nZ0WdaRumTZpj6
8swKF9B4N8ImiuGRAM6E9jwQz5EmqFIt4svCbDRGiDjf/w8+S9llq14pxk4ekFgB
b79akUOMHU/yhXw4inUka99J05VAeVY7z/acDqphM+/zI3de9wD/i2A3rVKl7fxe
RcBmuXuyruOrEXocphQVDUCN9UFMG0STPZbuylQNtwaJl7bBPGlkFE9579WWlLCg
QXgntCloSL3xI15IrSBwqchPGljLOLvD/I9jqrqKZoYwVQc3gW5FtUJNpL6UI4ld
2CUnpHlptkdau1iyTOHFsLZEX+ZAuFjwjGiNPNO4vAirioLZA+/w+Zw5ZebWSPyS
6vSdrL1MM4Uf7CvuMPmbzu/mpSL1vlqqHBsnLz0EY9sv7vIguPf3uINZ+VFwlvFt
0xhIJFNDJ7EPudSDQYy25bp1icFUdBdEsEeXmKXeb+NT9xhNl6ya/+49OIjApNTA
qU5q/dd7EZYkpEjKy86A8hHm6eKRdTh0aKPqM1J1pz4WixWBXuVTlecrkrIAZ0z1
CN8laXKSoEPQ8hgYTGhReUHdscMHATd2GqyArmV3CDIlzYZSCIUn80u4TdsDHHII
QJctk9RDJFiybvP3qfuxzZrXwido21sF6RKXTX05Ru3tgLKufL7iQ/5ftFNjcyv8
9R4l1EVR6Fwh9VoRRNzxEEGxiJbBfYLHvN3zxzWk2MBho0MyTwpbpwLHx7Xk0BYM
d8Rsaz0TGuk+Pa1b0injfBBe12vyG+Tk0/YykLwbAKV4GIR4FqAoiZGTbDdFYGeu
OhRbzLiBFzQw4SjDfvFtEJfWhjmjypFYmNcDyaMEgqpF4SxJJrFlp2bQ9Ve46OXc
J0im5iPx7yv94T0i7j33c0MQF/g6q9lb9Df6qqVXBt42MOc7k2Y12jLsdakxQMcV
w69m8obeviKLda6pmiIguKIClHDptBcf0EeSzAe84gDAzTwCip7jTmnot0OH/Esa
mTAonJTRAyqhUsxFjSltzFTDlSkck3ENFDxr5raob5VOYh2STfLBR8JzVha9mRjG
Vc/Z/jKLNQ7Eq+DTDobBL/elVlrwLD38dBKTGzQGJNw1HrjO9gVNMcPQzEnO+jbf
VZEsICl+A6P/RBNFr9oTVkUd5EqjnAl772tJSyLnEXU6Gt1Tie8wIkvAu6mOKY8h
SI0g/zA9IEHvjva0pR3Rawsl6UIBkYS64tOGJAiXmdmDIxiKuR2ckgJDmsEtgX9u
LT3GMv4BWd4QTiqOgAu2WYR8qzeM4WCLqrS5wotkelcnGN3Hbx+YPsH7u7RckzpF
cq2ryXJEAQlBCv5g7RoSxKIWZ616xuL0I8maoR8sJZQ3CXKGGd8meeTa7UwpdfwH
GLgxLBKbpP85zPyO2irApFAC+XHZQlJYQ37U9/j6qvSymocclieHCQwPZyKGt5F4
xECL1DkxMs9am3IsKzrLK4afRCTW5qS1o/tAYraSXM8kPXzAabHwp2JmtLo1I9Xc
S7+/074oUIAn0Nyma+I0k8JabY7FEP0Btc2a949jZLte1J5gjK+YDM+GxNHvF5D1
+g8l8tgbzyshJ6OCfeBCW25DO5D0yVWQyPVOFeC1VDlkzyldI5m8FNsSf6q9vd2G
1wm8glIViiSCH8qiheO9OrRGYmRNgyicZF5GgLpuDCJp4N6eFqMDYGDb4Ab4w+XG
8Hb3AlhRK8lNbZOAH3kCUfZZVAIvDmKfJCJsE6tXwJiYDGQMFALBK3wYC2RC9L4L
L3d+poqX+91px90+lMHl9AjZXj1ERidvHBqVZeEfGynMto2Kq2VuqJXFkhvMXcZW
7j86OplSSqFokiN3bJUrsHv6klxczMkWuB8Ws9T3+UHTLOcmbdqwLkpBOno+wBmU
u7E/o1jRe8ONUkmR+4rKMIATdz0gf4uuypsYl5eKjLF0bChtzvKMOqADIWzQUc1H
4c9WK6JUEhZEaluGyjiW240RMKRkC0aMkB+VuAkav1vPjhaymhTh2naSPOOHXpoH
Q1kIrB4CCelfjC1yOV7anp/WaK+EXOgr8e0cKzu0soXK/CKMoHOMq9MeQRq2i1l4
DlZGQjOwaWZPTOHE93zNwzvfNfW+06N4uhK8WpsB3L/oKDhuOjIThiYndz+459mZ
tnU4Q5g6ftk1/M2suIqxdmiPPIX9007W4KkPe/Qh3pp7n8KVSUgquSOtke2H8g9s
hnfHLFvwIZBgJPSJVzRkwEh3v4u5ZW84v5NAPblxZfPtu1FKlHTTwleXzkE3e0VP
ax68bLKxb/nY33KEq8kU+Y/aQqFtxw72BJIh01TtN1+lqgwW+hCku3jOSrCZ02xX
igwcxpvLuIip8j3HKOgGwf/aYPgoeg0ltBtbAy38/zdYNC/pDin1mnqL8sdAMJx6
zYAcsPBbFS2zYy6tRXOg2W+h7UD5tyJYZDBR+3OPIErUqyL6ZmkWe7HG33o7DCFK
KAzX9Em/nkvgQfCuh+Bjf6+6Onzxyvb84lCdWEf8PmtGcjBISBwymh4rrzMWve0+
sYqfchfBxMf/5HPNdROJjjKGQUdrO6WqHMRx5kuDpzYnLwHt3zKAkgbRXMehW+b1
cOQ7VxEJlN4E5D2xUutzY7B/4DnOTiQXULUyWZGqwhI2YHtUn+S0u+hY1WxGswwT
SHv+5Og8NAWSZonQrezo/7e2o7fgCi2lyVWHIMVEZNZW5T++UJgBtwEESjOkZ+12
PBGP+0IfczxbASHtG6eOhfE72aI7eU5WG6CbLQFVZRlj3WM0FyZ5Po9N/AbdNSNQ
mCgYFQQ9zgWhLeJmJXiTB/S5bTxTUfUxiKxdew0Ecr557nBrH8tXxPLeQeUaDZxa
DyL0GRlfGhv7wxx/cAUrR3d13dzVUNlMoO5GOFSQNEWeZNunr0rqc2EKcz6n7C8w
gj8HuAvBYWX0Z3j1tyNVESrLIQrp6/P0GpRJokFvDmuRhxDHLgTt6n2oeYsua3OQ
hDxLxQrIgkEZHxLgKK1BL/YF/Rnw8FIpxFHFRF3ymoQR6TJOfZVZGgw9TJOgqnKQ
cxk9cijDFpc0/oo0S/aZcVjvkCOwfu24gaEcYd+wMOqe9Gy4CWRyqsEFlBFtPziI
BKBkwwEpDETzvFVLslzb8FY6fnqNTxuVyb+XdUiyQOM754QF+szW8cFRs6xPnL5D
uUJvKEjZOir/iKyCF9xp/FKn/9UORVF+jOSjb5ngidP8PvrhvpK8eu5ksDktpHQj
YH9axtlmM7vp26rTIn3pJQAz8QOr3qrDI4y5nbvIVm2fZle9uhhHTzaoVvTc2awG
qfBbIKCvhR7F+ZbnZL11GAyH5oZnfkEyT1boEj04X8eTsdxVQuyreN4oG2I7bHrh
pr+emlH0Maedvir6/5ajfY4DTmAbsy08d9HG2IhzYBRtP0pQauxMYb0DAbD31L8Q
xV6ClfZLMBqzZ7WISxNpNghDXuJKBRJJoXFygadzxTWUrTgszvmmCaUhSrQzuYjg
AkFzyxbLRRSQplhtFHfmVo0afNyeg/b4zvlEUTXJCwyjliW6lLfqOEnUO+E9iwGy
Umfc/jiguhSFWJLjoKNyaFljWtSKhUzrM6E8YKtt9bEFihwLXHAcZcX/wWQFDaug
rAniekRGhk11OX5TgMEt3HDkPhDBH+m8z8QJOvXFqCMCZ52qAr/dyYid1vvUIdKy
GrZzFgJrFGn3V8OiVTKJYeyFd6OWMGDFNxpZzkE0r5FLTlUMBa8PaHmj87g7Okwb
XKEfzR7qBfbc21thZj3N3QB0LFi/tx4uiccAOgccPeftD2hDfLbhrA/0UJD19FLP
LkIiImJu5SevHCurVLLIEGAkXuruRwnq1N1xCwILJ+mVmaMpclfNH/0rbCjuHJS4
eJ/DHvwLX7pEGn6H4C8CFne1/ufe3L7mHRXw7UekGkVPKWdSLfikkBvInjO0PMUd
tEWjly9R4pqnuyxlJVWbEYyRN01yj/0GMBqOmkIFkl1PjZaarE/1MGWrKnDWQKxi
tvRkvPJlMIa4g7ObuAuAEPzNuxK9ZFMtSyUzWfaMbby4bigaM5axPhvCjl4882b+
wHXE62Hrc7Bvz44qESUQgUImM0KX8w5HLfqFS/XZH0N74u78ldNC26o4YOgClhDN
jzdnn31IXvUQV5CvpNatJ4z8c7DAGDX/d9A3Lr2kF5RhKBC16T7Z7KZDFd2WNtbl
O/ndRCi1ZEan8D3O19QIWYKmbYa7evAH4d9cGS2OgyG32+uO4WQa7q9tnrpqzsri
FRUQZQ4ogjMlP38xUfO9nuxuBb9wo7bV6tbwu8bn2nR1WzjR1CkAzavZaNergtl6
tdKEu5twuU8NsHyuaefNSAJGlW2JGFCDsyVFSppcjKoN1N6bO21zNqGUQiI6Typf
BhrCN14aD/5z4tETmkqs40Ty7w1sOc4ohoQm6R+VpZZtrNNrdiWoAo/DDeqZnqvb
aX+3ZJAAvosOAXDhyEoRAI5qYkDX1gU9/XLMOvKwlhUCKsEYvLtZ5DMZtGCA3zc1
z3F+LZkNt/l6u0hXx0vwZ7ciymA6hPBFCwwOnTNQcXqmIK4VyGXyhFVLIQrNoq56
Qk0IxS5pkG7NiVIB95mDbtha0wSJSzlTNKsNGJ5af9SWa2+YBWjWmu0qP0S0/caK
Gea7cMuOQnPCmkARv+GMYiO5Xj/q/LLnUPlysnz45eLKmje/hdgVmKTBBhrzPt8e
iPcnJdcucMuwOvKx7cd2QsJgylRcMgtdzF40PcbMG1Zoo0JsVlMXmxji8O6udhqV
FElxAuNZK6b73C5gdNZfQuF1XFzMd1QsOannvtwBLZINgrIfYYM4CF85QCOP/trs
TzWweCL0MfidUjx1+8La5H401EIUYsI7HlScwLdFdYODeLmpv+tqS9w7XjzNBs/S
0VJdHAGuDDeIYYKXWnlAdt7U3c+zoR86+p+NrsbaWsNNv7BPux6Fj4KvuPl2Z95+
atCC1srzw1aulxxMGbhe7GDWIutFKpWu21Xr3uocs4wDDYJsSntIszDFdnLJRhNg
ovN/Ri5lZndmudhLHni6ZlblwiWFbVpvkQNG9mCJ/Fx+PhzcprrllP0PFNqz1dqQ
ZdI/kYWBFUU8SH3BBCsXP9nDeV4IdqyQm0xr8jtPwd6nQUHa1PEo5ybyksva2e8M
b3HY825e/0I50/YFMrLg2JSh2Zgs0K3WNEqW0QMeqrBzSRUdHtmDsSs8e5CPDRa0
8ncGLE92n5kkb0GkrqGRPIkgSVSX+tVSbeDDt73OeMTNP3gXaDBCWVUPyGnyIxDN
o7gSB9f1kqQGPaX8UFrzPgdYgcHWTAPIs0dR83XmVeLZ7BZXvoBVlkgPKVabzPPZ
CcoM27WATDAeonUHczWcuZe6QqsdFnY0+F9p5GEoILk4B6Grpo470fWaSDyUBmcp
x6YMllAcWwtWXk184HVM08OUi/cF2PcFoiroclV8DXrVvLRBWt8hDVr0VE2MCtTR
89APQ7TqcyeKpQHs7IiMYTkIOxxrfORrzi+/mHs3ntIi833D1wI0UNlYYz+3WdHk
iss4KH7qh6O+aYoPMSBzhpkFQVKAodLltBm4KJR5W/geQoWKJ/XXG5BEHfPnZYA8
AH4wlA3w6rLbf0aIlwPKI4xppNpFSv2ENOBHF35CKRoOs+TZW0cHTRGo2tzOD9KD
plKBBtWIQdjk9uYjJ15UiFFAKbUmrI3Gy/BcXJm1A20qL7SAgFktybGe5BaHqqYj
5G3VEtPiBs3xNOj0Am9tpHHpcKnNVuCfPT9zu6gDtan618zAPN+BKXxbLPHdNsrU
fVVc5DVekgIaURiL4cepZFCPtFI6YnGrCamvmyFoOmrgMCGJj6r7I4EBWySeoqqR
Yy+nMavaWlV5xX9aPF3clNJCot95DS3sJRvA5CM1V/KaI65HYNmGLQ1atK1uiKHU
UvIA1DstMpTtcjVM54gA74pvRieBphK8OeI7ht5qRQriERdzcscS+49Stt4wu0j3
64u5dQOFA/yCWRVZc6Eiw7YRSui/Mlgh6qF1guMeLwUS6yvEAJ6HaRokFvBqDCtd
DIuqe1jc+Q6rN9Wyihn8tuTM76xueiICjI8VVT4tryU6tbWXgQTTCLL2s59716nS
4dM4inYbztnuP5g0D6H7ZaKqE2YJho7pSDnMNNTeBo5bxxo6OXtleSj1Pz1oZKLE
42FsR48RFtlNkDhewxMIX0iSbxZPs2CSrbiFdZWPq6k+Z4LbSBteg8iq1FpaOEFs
/BCI3qu9Jh1v/LvOUHfuHjFJoK9/v7Gime9GSDyOmUAQHy1/WBbJQke56sbyLh/i
s/AbbHtqEGMc5lQopRmjn6rak0n0SBoY956rrY7dJwdYsr0mI2TgYnTH0p6/BnbW
Vl8sildSdL3bRouw3bqNH1OOQPhmSS6MdLOy4tkoPbUzlyCtaIAAc2BDF06Oqv5C
Ior3nuiC92hrChJQjaRMho7zndrtHH11x09udOzxdVPQ8AqQ7O1F3+cXl/pkkIwG
nerG7uPlEg5t1cG3yG9V6hezAEtazUg4HLzz8i9jBbFXZ1VL1CtX+wtVGaCoQ4jT
KNsJo2iu3LKOBcon4URwcdxuobGnSIoXBl3fmEaT1ROB4PkZ0xDFrN9lrSjJnEsi
v6cbMvHWUJ9S42QWPdHxaU+j0sKwilaMliuDKk1/9gT7TfYFm/wyvHvUc5eMVqfw
42TFaGhO47A3Dfa7mzS3mjzV4fHRE1+mWqEyfra56rMv11hnVbqMeu9E8fJqU7bu
XpwIOaTHJbUznpS4oCM0HHRWqMC8yMjknEOUSjUQReIwsdJXifC4zsWvtXAkrSus
PiGng2CB/RFljhlmCE98wuo80HT8cuQHzcQJLqjaIlkdutcmxQg61z78x+MJ14pc
IyalpMsrn+gKO2+WQIDf+VLXnRvr2TEmSY0772fqrI4wZ/SswffnJsL06iePrruC
dNc5kHswsFvoZ2WN9OCsRnQK6jOGRpIh+ahlBKvwpyMlm/aX7eEBWK67vXQZD2rM
hl6Fcb0HaByxz6leXM+NTP/1jIoDLj6nX+qaITOeHPESongwoUYl1E6nnlbUKJVb
ihRyOpR4Qvdves567JDr3ouzBAF9DEQ6ar5MHYWKkJQFmMj6cf/IlY7NWA8ByFEw
KLz/914SI/q3QR8VcWtl6gAQSCe3wecoOrC2RzmbGcszHTx9GDJ/wcZ/Axv3xxuA
2YsFdnwOfERQ0Y0sGFz9Fziy5r0MNRLHpFGH+OLzUgfr2Go5rcwMeCYhMkfnqxhc
8h80fcF/tZaTKpyR3cFEGtVixdjFDwO9J9aOIdIZtdKYplrC793E8zLunjPhiMIO
w/GTauLvCHTaekq7NH+S1vBkmQ53of5tB2IUvBVhwZoHV5Ol4kYoTtxInNL9zF9a
Xbwv78EwagjRF4v2yvoU91XbO1GTh8hHjksyii6r808RrCZOwIj8eqY0nwtUx3sh
spoDLFJDyf/NalPlpA61r2jycHOOk0+t9OXkr75PkhNUNd5J/noORuXFMm2Dxfw9
VAOf8GJhYqllzNJNIPQQh3NgtrqeNBd6a72SejsJt59HRjZ9+Yukfw/JpI0yyFRA
tCUhI32ykDx2S/7bIR0ysFEnAinKOYaXzEUPQf9N0Kp9Y6V+AlDKGTM/O4eyKdaH
qZuw3Vp2Po98TlMXrExXW6MiLg3FQyNYshybWksX4fTF26x+FywGfEN/ZLUchwXl
/reAvDHlWbAgCKRPhKBAwvhSSBWXSh+V+aKP3dwrNJTjAlgNVS7Ddr6Ubc4/Kpdw
C0YaXkQUx8CUUL2Ir4KzwvC0IeCteJEQTjZU+vg3GN1423l63lOb4uI4Iog2N5Fn
Qi0NoYP2p7tj//DEhBoL/Hl70WPtQ5RuJPOT6j/WZ15ln7Ox1lS6So5Tu9Gmg7dC
SoFjhexMWXXEJXKh8ODM3CriioRjDC4j6CsQubB87SCwvnkJ/CzW7zByJm3WNiKo
o1wwjMUHP9NLddLHeqHzNmiuPzN7GY1bedAvmjmJkpF2Cc3Nq1s+03XpisQG12uL
Ke80gLIBbgSZ/3wWIgYanUebR7MHtZNfLlbLeOwsLcrS1ujapfG5N5j/djoDD+7t
EIPzRDqKpV+cdL6WO47pQYt28lDpCgV74ZngmuYvDQ1itcjNWicFpPA7UHPOtJaV
`pragma protect end_protected

`endif // GUARD_SVT_SPI_STATUS_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MmJh1/x4K96rDFi4PpLZmX4+8vnx+HSQjXarI92ioQvDYcNvCbw2aPK+njoUMFWX
o5UICsB3T/C87BwqUeeL8zr80pVbz/BSYCSj4P4mXaxtF7vX+pnGGChHVghGH4oq
2/tv+rR0SQbI67+OX0fSL7L9MnsOFM0TVgfElWCYvAQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7771      )
EnIqjhTeNowRRaG6IL4EcWngftRyE64cROmsS1tKSBDQIm02PmVzWWJ2RbXYN95O
rWXPIV7I8+R28IHi3GCXvpy8ADDtbwLSZqN1f0YFf0sygWUuWi6huy7WZJ/Z58ns
`pragma protect end_protected
