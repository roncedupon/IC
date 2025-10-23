
`ifndef GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV
`define GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV

// =============================================================================
/**
 *  This is the SPI VIP xSPI register pack class.
 */
class svt_spi_xSPI_register_pack extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** This field specifies register name  */
  string register_name = "";

  /** This field captures register field object handle index at svt_spi_mem_mode_register_configuration::xSPI_register_field_list */
  int xSPI_register_field_index[];

  /** This field captures register map object handle index at svt_spi_xSPI_register_field_list::register_map */
  int xSPI_reg_field_register_map_index[]; 

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
  `svt_vmm_data_new(svt_spi_xSPI_register_pack)
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
  extern function new(string name = "svt_spi_xSPI_register_pack");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_register_pack)
  `svt_data_member_end(svt_spi_xSPI_register_pack)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_register_pack.
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


`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

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

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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
  `vmm_typename(svt_spi_xSPI_register_pack)
  `vmm_class_factory(svt_spi_xSPI_register_pack)
`endif

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
dfDETJklcdnt1q3483R4n7neCPxvvk2k9JmbirwBVKN1Kd3gMPAtjPFlI31zkKfj
0oa7WdFpgJsssNkz9okTfLi4hElbWBzqd0vD38FcVTMapd5ZaAcA70mljnQl6LgM
Tw5xElTPOswNMnbhoy05AxQ+FIjhWbMrwTBhrUJpw33+DFsaUXu5yQ==
//pragma protect end_key_block
//pragma protect digest_block
UUglsHJu83rlru37ZD2WMpwzWUQ=
//pragma protect end_digest_block
//pragma protect data_block
TDOLAaAlesaGa9IUtF1t5nYSbyZhmHl7r2oBLF8oB0EL0QbXCpdOTdrh19JOPdbl
rpx4+obzTuVSUsswx/gfkz1dMvNyHV8yYb8Ybr1uK3IT0DNBCLqwEcuzu8JRHlpm
L1VeXBQhFiYjLvydLSNXlNwiqC0v6RcnBI5On4UcZqkNGHOaLhd8Lfud8oK9eFUG
xqDlDc+sqjfKdJQB9RNT5cFmV8j2qrSn2fmVmXi9PswPvzhSZxkR9kOIPktVZ5lM
5a7s8n7sO0EWsGu91GIMZTNwUqSPzNytghl5y4W2YZHAko5w4ekmSSJpaZmogDqd
r08NDl5/2XvdNQu38+j01FW6OH1HMcDHxfkSMPTT9IVQL2tsihBz0REiUne95YTh
FGVixdIx4r5GlDoTqjlIZPKILRrjRREZvvEsOOo+mpxGkdZ7TkB8IvAnTjp+6NVh
Tx/6hryTEIZ9UmStl71GN0WH6g3oLC9+FLVZ5L4QkX4Kv7LyS5jC1eC/Dl+xOpwE
TB9/mjcHgWq0UvycaGE1xWshHwf7Zs7H3+B+lxPjX2ot6PYy0nFhCjZ2iI7os2up
mORkgtBmbN4YNm670HzRZt/uniLkeG4Udr8ON4Ty3+JVIABmfLu7UW3qne72RPk/
lHEb4eFLpGiSQsEf3GIaqKjKSf6KiPM2jjYMjmlokhGBiJgM3iSlfuR+8hrM8a90
d+e47DPTD/uxsEYJSOD4mlhbpdEieiVytnjX9EYMK/mccz5SJ9rn3IFan1R6yYEa
VxEdIroNBeCqbYoLuCUV4q5U/FdOkB8+rK05YtVzaKp5P2M4NpRtwyucT2akoG3a
H3yeQkGdd4301GV94bqpfI2dtAxrAGilQYTMRCl4mb25XpDCOonor+qYZuD+MJ9H
3D0YlF5wroKG0CVj7n5sFr14h1y3D6di/g8Nkz6awDa1qMcNBEv3qFPJRYJGQ80f
YVJfGtyo6WaBQOSSMlrS6KfPVvZX1iEwvAPR3q1w+KQ3HYl3xa2uKimXrl8TVRnF

//pragma protect end_data_block
//pragma protect digest_block
lBvYPHDxMFB6Rv7xB3UqGHySNNQ=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
VZI0FbnJNSukjzaxdUCw+d6l0LP0s3Tz3Q1SjfJ/XFOCxUnUpYh8Rmqe50fZ19r/
oK24kAaDvKm+hAyUe5hWt/93+8wz+q099MbjYZQzS4dP/F12pFXszurpp1vl2cIH
iNe9tQgiUnXb0LrpSvkSa0+528z1/PLrKd7wtwv7H1OTrYJ4bJX27g==
//pragma protect end_key_block
//pragma protect digest_block
tn1LByzUNViY7gao/3aY6p/3Omw=
//pragma protect end_digest_block
//pragma protect data_block
uaL3CVIsFYkXCYiVrrD1fOaMR546YzipB2QK1r6Ylq7vXId2rj8urbr6vc2iaAe2
niwehaTka01E9KJEKwi2XuRhoYmw8fqSnY9Y52DpII5ICYBE0JGdUjkcN3H0FZFB
WdKKQf6Kyt3gIMyej8uvOCAaaq7agkc5/5JjjobO3mhC2KHlsJrEGEOJD7XeV3BS
xxLsgTOPITGO3RiDH/rSpDnV8YIJFp/A/bhT8actrwkKYZbRUbPh9QiXm0Yv0KJI
PCr1ts/ZI+WESGzktT5wHem/ka2hPXbdPnc+xPHSzlwMdoZNt9fBU37ljrdx6VrX
6vLVY7Qxd5M4a/H9qb5KYre8OjRV/I001rPCOblH0BDT2oEosKHDcHlTCtsRnptU
St27YpsRLX8/eIbX9iR+EMeh+CkvkxvMxiYyTGw7UmJw/Wvn08GsuOF/PRx9xa+6
SJnDcszLw2/5TLGwchG6HdxjhbPCO3gfrGM4xuNam9iu3UH+U0v3vh8Q97cFMpXj
VARu2ghxKWxxEyXZz6Sw7p4uwlXAvtRoN7MXAZC/lTwzBsvVUh58kuMtSNO36i94
9GTt1Vybk7RZuljrt+39S5yj1s+LJv18Toq8RTHbWAKJcgmcdD8yQN/NM28eb/Cu
8BnqS8qIAv6keJCsElrHe3x7AQguC8hMpLhtkGhFC9hY7K5ezOlyxi8vovHD+An5
o5XAhwDRsv5vOKitEcU3eJzVsxjYkC/+xZOXrIsbjQbyl8TuDiQdKSBm9PI2iR9I
heEkcqAx1i7CMFhSt4xkpSuf7pZLOvU4RVJ0EYrs2XTQBifhJHD0yeU/pd8RvvDL
+o2iBZOzTKub+440UKofHHPoFvnDNPOY2s/MdFx5J5Lj7ul+j8BTAoi1usse3KJ2
Xa0s7OLSqWESN/3Cd+BYMBIawbGus2hpN1jDP3cGgwp+WJPljxKNawwH8HBjZg6G
cub+UG1mTGUYGpC2rMOGWFV0Fb/SGBhxr/gNjbKm14G2LPswOKUCIpAqoBEV/B3I
xMXuT9nbV5EliPTndX3hPXs9IwMRQ9XY5VUBKrNjhB0/GNznVPAj8yIpch6QGD3E
DMCwgzstrpNQjG2yOgir88fljdVcaeZYkTGlNO1yJv6nRHvSj1JghY/2HOJfC3eL
hth0JEVQ9gj0e5ELg2KDZxNnYF3Adt2UZkowZo6BC6dfClDZv/H/q21UMT1W1hrV
96i+JlsUGO5S+EBGp0sHI1+Zsckjx5qHq6OcEomA5ZU3N9Jef7EtGbMu26X265kV
Yp/+mfl/nhSUrKdiJ9vkpiX73JOiHidWakMlOp4nbl4XY3smuEv0zeRzuFUAFHi4
SJW1XR7rmECbXgTdbZY7Ty8wZ0dP39DbvT6l3j2P6GIBcFoCqqv7W8sj+3SdasFM
gTo0I8orlBRza1CXSU6bC5MJEVGJsCUeBBFZ7ZHBpmWRg1JffMgtr0+Qf5G1FuSJ
RaUfdZru42Rlk/jC1wL+JOiCtJ+s+u17z+La0eBKkY8yr3PEMPinQBEmN4YJA8qA
un8yfNxbldg07V/JvSmnKRXKj8ikUbsXzNAq99Pqj36h+BKw2bmSKiZ/684xkVGj
Nm4hUya08YoxofgZs/b1krhorEwoo3EVuPY7owWVb++dKPgsRQtqTiqdejwWhpjA
6Ayb6b/GAcSYBaIwT20/MfKquD8akGPCRupzjSB6QVQvPF43LPLhdR96pXgrYDc8
FiThHBXl9+kXXCIcdmjH4pbuvMddjm4NmPTNT/UUVU/13kryiiirfb7m+Cw2ShYR
U9Djxee1ryzl0aZzOYoumlwCAB4jiB7yX4NGjYlQJrsX1lLOrrBHTwbj4oFFcKS5
fxXdnL1BVokLGd3LW9eVaUNTGPemEDkUyTGawV3XcwIsZnJxDm4FYNLb2+suMY5Q
9qVoyhQ+EQk8I8nvZjjCmm1db4vO0ttOdTDTgsWZRcncBHSJ1gSgsN8UKIj7yaae
aiQCJxD9rNZXDf+v75bs0voJ8IxgXCCN5X5zTsVyXlGndImVl86qOTjuMQjwig3c
/fIJrSUheZI/chpBCOS/hPCKu/ECRYqMepRwFo7mg8O5Es/H9ykrkx9Z2TXlsOw+
VxwR2jkFHVkfydegv1V6hjskkH6gRhyu5hNz9s9LARveU+7YLfpT9PneNstS9RMj
Y6kPESMcx/EwXNaGrDiRicYNKsjNbJc1L3Ys0pY19+hMbLcf9STielSE5CKEopHa
ae7NrYcgjHuQRSRzyKxORir79F4/6IykHihzvaYyQB/7rCDOy3rFIu6m6Ey4V0qk
ncoDox4JLXgL8Ghnm0LBeoguiafR388TmpPfXv8PHbV1Ee/vswlpfKPM0KJOw0Mv
qN0mOMPMaHpGUYruGiZwz80iz+t373pZT9xfhnB3NIIxxKYKAAiqTb0wto4ZghWt
KNveViKeDzCzVW3E+zzqCKh/cqtsIOYIr/3BEAHyILD+/QRv6D84fBgqWqnU+2IY
1IHRR0and6CIf4nJtJbcT94fGTo+dpABEf0mkbPAId1yqLAXY7qvXAga7SbDSy9v
HrRr7txJmac13P//+stxN1oI9dWW8CuiiDYiHNsvsl7jcCorKVewGIA7YUdapTa/
YCeipk3KxmELjfEq23B+HDgTjySwYIQQZf0U7Yn+q4Xf7BCz7ce4l4gHNIQnpw8W
xEVDj/gy5Xo8YvqjhsoGJ7en5WTJh2a7FqSEC19qri50MxkgT9/HRRoV1xglATHH
r0CjWTpTekAh7lb/L2SC1nmwO+nLf/d+okXQRi8H8CUdNiyIfMelI8mG4e5LKr5b
GZhq0JsU6li/Nlx7OzMdm6STJ0zmnG6z4PlX1VtpQUE1jvJeWpsImQfusLlkkv4d
58ISX3LeZ4Idc8dyJHhoYyGnkaMUf90/02eIQMxbjjeHUyfAz461wSXVbfRGwOF0
TEFnuSrjQhPxxPWuQN3os9NgRIAFOGQTN6Dv3DAepP2NXINT2bwB/feYT9WYLUOn
D0ImQfjWWjd5yEQydYDFTIxfzky8cgjGfE92SYS5eozd1HLYZXMqHcs3X4LLK3za
xebICvOaHJaqTiC6y2tjGl5zo3b8/FWZvvanRmLEAWsPC/e9niE3p2uqOGIurdIn
rhW3R66hpMpYhiEWW7Ko38vAu/hZloXhy4momykMmBY5hhGQVv6WgpsLVfq/JsjK
34+T4lS3I57FSZPw5Lk0En2iZ6MJpLsIz0SugjxcdedG7UhU4qUZBtRkUgn8FVya
R8WLGrKJYQZEjkKpP/rQ9OR5XOqBWcSx4CxeRsPsqAx8HxkIdORsLQdSxUETw/g1
aS01PG/V33o66+ATxDCtLsVhCSzouQbY7gxAZAQV1rKrYyTVwJBNFpmLfCRNxp1c
9dpk7EBKRJY/J9JUbYLjKKWHOqFlQV8JSTmM1TyaRkMZ78v5OZDNNpM/G7CL3qev
DgzM55+xasoqf99BOFs9LNkF493g4f9YOt8I3S1HnqXG16s7XYHs42CEFhSMdKss
pzQ4A6sFrhhrykLrX1hdoCD6IbKliwn0CuIf0Y5tvhMtXvRcrHAI9Z2j+VFoPF4K
2f0V7GmolKrc7svE3vGNoLzgZPmBv26tbV5wy09joDhIzPEe+E241+WPz6g4VDuy
6xzVwtPODw3f2AdMqvvTj5dd+wvFaE9gN1n+Aj7JULQx6FeOEulvPAGIpea8xt1+
KV4hh06WRSmahm44gnRzEPbEihY52tRtl1YoKl4aJWo+f/QD0h4Y0JXalXomVoF5
zwImxZtkmKt+CFNJgl2u3f6aiw80snaz4N9VwsEd7IJ33PxWaRq9eV0gUG2KXbUZ
d0/PEgczzTa2yGbulN8Rc9gidtJ5T8wrOHuRG0uXa0s2pna2d+J9wcT2DCpx5zMn
ZmbtPFINBkAny2Xlm/8ap05nNBae1g6KHna7tS0fV8zDT2bap89O1taErP7xguzA
47JXDfU0ZWgcaEpRaLE1pnqERxVLJHYjIFmb9K300dvtAKPM8secW/XlM04HxpZp
0ZdqaP9uLLyXmJXKoubWYyymeNQkyfnnf6idLprBeP72MxztNiC/Lc6EuNZBB7vb
BSzRlEJ/bsjMZjYrXf+EM9P8o7Per+G8AL+C+1NcEJp+Ozn3SnqdgKlniLqeecdW
UlY1kMAuXcWPilhTib7Pf6FM7bACsRqkurwnq+5SCYd5mPqA20R36/G910R9wqt+
BHN2ho8Jsg5brujGerVB9aSRRvfHHiRsb9NsXebiPV1exMkKNWo/Dobm4EZyb8eJ
A4cFBMdsuqH92Sy52lgFIFkCOrDWrNJh1b2gPYTxxU8ZEazmWCLTVT1PwtXaMIuq
g24oEkdbU/E2ZDTNfeGshVr9Qqgd84HZFohQCsJAb90XofE8h4ckLj2cN0ms+2gG
u1n7L6gnSos5d3fuRnS8F9PIWPbNr9zPL9XZ/sgKjxOYlcED5z/LI5JNz37l89sk
LLm5YrJ0NWNMMEWDR4MzwuvpkC/Ul/IVd4BFqpCKd5xxt/Bs2hm60WcR0/1FDjXs
7J7jn8eeWm/vMi+UaDwGIkPqcHzu5987G7e1YSc4i1IYLmp/7lqpY8oOPB+67MmT
2mvt5ojdCrCFatif0DSTU1lAFa5aT7VGX4yiYXInQVTWZb5TcrnC9fhKWinZxn2p
oHa1lzRrRUR8rWaqfolTugQIl+FISd8i6K4tL06V5ytd1lJ8wAH3wAApm4W2CSNQ
EI+hInnaB2Fxl5pQTix5hfjnMGx4Ahkqm3qmciEzkQBMqLwKKUnUCcincXBs9ZQl
vVaYQ1mKuXw9HSe5tG3FF5OyC/bptmPttEqkUHgF2d+cSEBFMuC8P/533esghFar
hFdPP74B3+UldLcelAOszEvGqlQlh0ii5dvqjkYrBhEwYOp5uK35rumFroLlLZtT
UMxXKMdsgffb3BC2BPSu5VQRj2NzI+iPEnVWz6Fn1psm92GIzSeHcvnBK+EP3IT5
nmqAICBh3JlK1bQDSqj2t7HwMkKesKhHbrfiVDSNUnBYdTsW0wQWifQS9K8bDMHs
TH1Uo212aebuIkQzmFwa78VoJr5kKjcumBj8Rfy52wBJYcoUQgfsTH35leYBLd5f
cwkQL0nkqrLJpq/DZdYA6bCC1rX5dj8rUdM+PmjAL7/c0Hj7Oce7mcV0LijCWhJC
Nhnn7Js1y0MOTSDPK+3GNt5DobV6m9D3mQYVP0kPHxJp5ohDmqI5zu1CwHr84hbq
I4PWa1/4S2hV5hPRrXn7Euv5OejPsWmoMLuWUH23Ait5/MnqF3hIsqgeMVUT8REY
czmxcAPXYSDFXrNO7bu4gRTQhxZUXQF+FTNM4vEuzYThKgj5iZ2snllo4Fz+FZEA
7hF4nXaGneE9fPiiIzr2Y94h2YvVD1O22EK4431OSHZAfJ8+0wswxv324RKYS2ND
Uqm2VT/G2PewS3I7zGieMv/sfu9rOuXz559dAXGt86gpxrlEBK2HReI2LDLBvXd1
Tr33To3qqlZoX9W6O5pcKetu7obkUeseXlx/iqGpd9ZAfmS0Qpc96fMlEyX/5pxq
D9JoPyDZXpcJCigw4KHGyQaYM7d0X8PZQBOxFG8o4YMzzW4QRfYdklwqL9vvkI++
99wx7lcxFSIn1MdFpDLFfXFgmhCwtHJadCS+2Y/8Ts1eQlJzo6s6h072QSSoj853
jcAKdkjgInePoPuAE9OiKzUZuuDLxTpLZBI13TwqvyHcc97PbPDHMulwmAF9TcQ8
BMDiX7JVK4VEDiaHH7l8IifPK9KeAl5b7P/YwYbW5yRoRuCcvefcUB9oeZtS7Dkg
koLDFWerNrRufBQgMkOWUz3/lsqvlybFXyEgt+RDqSSD5S2Z9xztB3KQVvCoGw7t
pRAFSpzT4AvO5cD8yc52Eaba22UUB/oeFpX+Q2zPzWGWeHeYpxLi2lDp/pOXgXDN
6Is4IrcfWjVkV0KNLX4iV1V6EVmNeycC19vEVh6DlTs8GNd+t/qYkGk3+x+V5uQN
ct+R0I5uuzihJjQz1l/XwRVr8cjWwze3PBJ8apLBVJ0eFAvWptr7eGVcC0TRl7MX
4C/vW6kBaSdC+ypdJ9frhBhGwe7l0HLL7oiKDbJJ4u1LUX3/cuBbO8P4NYiM56lK
bJBsMwPZfMxpZPXFCUii1e67WNUUZkI4OLk5dVw8z+4DwXM+njvI+T6cYm1wRLRK
S7FhQdGleowr0mJrRayn4SwhdZYYkjlUVEhdEPg4B0YwsctZhfBuIgQ/MqsedcIh
Lv8eI7jNJHYFqpxpgioA7qntILpgDDDtvwMAJihDLF4tKgISbgLycxvObsH4vCQZ
JpmM67Uw2Kj9E064DfWoIkLXlgwnFkBexIvyesdf3yjTIlbIuk/DvVMH6WqqYGju
OtRmyM9WaTHiSAYSRJEGdhqfMs7kyStNmG7jcIIjpsFKP9v5mUfDFwnU4cJuWs5T
sR21AnCDFFI8xqPDyVPG8SurXELGZkQpj/+zIzH185m3QnU8yZN513/XbPzxvF8p
Caza96dzRZJ8HHXjJ1hkMmU+NRNsWgnRUW39Jejj6Ugnms210H7PQMnDjScsWaYa
F/P03zNkow+IVQW9bSiIZ9sBwVcCQxr8SALIA5jtwx7fe+5Zxc8Jjx7TobyHAHoO
5tni0hICCfC0AbSOxyeDieJhlRIBw+D3STprMaWkpejtAf9F5Q2o+O1eYujjK9ez
/vE1QOa5INKHaL3TYD6i1j+8Ef+4Zwl+vqkq2T47PY8qcJOfdlkbLzc0NlWy+k2c
yX0nXD/iXF7hplr7+H2GpWLQXeEhZcMBvLab/OzXi+n2f4Ms6TKSzwlZfcdrep/u
c/PXUFe1eD0ShspygXuoGAuraH3WKoc4chCDGxYpg1jI1Ig5633GG3DNS0ERgD6m
VCC/+18O/7DFLppTtHBY61DEfquZAC55Kbm9ZZkllqQLNjPyyJ509Y3Ydjybd9Yl
yywzJrZhiaGD/uS7BZwePCw6r6kzDxyrn8L8RJlQTpoHQ5K/YQwd790ke7KiZkyu
fotnXZE25IcstOTwzyhxzhldTDriiI8RTQ/YwRjtNhdn3UVR0x9hs9SUjgdLRgQa
KgAIIxpYpz/wBKISihjaBVmV768HH//Sv+B9Bn/+r4Vhcz0RgEXP33iQKOrqSuyb
+QCbP9Z1SWJq3FlAcxQttIvWsDOdibechq2sNryCDnjxgxv1qVVw5l2IHIU4Idsw
nqqNgD+70y96s5Pykv0LlH6lwYyWDzwRZFre15FTUEXYKtu3u0vEczMBVlaM4izn
rgFIDvGBuMlIqhgu/8auvN2UXZxjqNPVAd9rnFBKKL0KMFWpwF5Z2To0R8YSmvyL
nBxZ5ZYmWj2MIeD6L0/cX8CMw7dV/nFQuuzXQDHANKUo3ex1On/XjfMHK68iOC6Q
/xQ+FYYS0KOsOHHpt1ATD4FOh8tkUUhCBCgAhdwA6iOnvUhMRq60sLzcsSgJqANd
hQA+fb7AadswWxtgL0xFsbCiYXStLxIKRGPVjnp94UodZGrQx8rIGwF+j4U0jBqm
fauzLWgoZ4pp/Onf6vApbPGl1Ne8IiaLlIsxagxwe1wmbIJ7z7sVLDFQbs1VdTl7
wAzq3nuibZn52Tepzh2S9yHgozIcvEhKCp4LWP855Q4dywOhUwkj1wH1kEZ1jTNq
sZSeUJZQ2wbDNKZanloR9QgOsfwvj4rNCg8/9buaENvZt94rYLEa7TSqwV1CCCbS
gZMKTVGsaEk82bV7keeXcHM0lO64G92acoHtIEWYfBaRtiZcJrFk2EspUOtQE7oo
sqPqgScfFRfzOU7WbpjNZsKf06bwa1ay5gOzMowhMvETzFx4DzLBWZ+TmemAlQIa
kuecvYl/qCv93wrDAH74HZlcaZlnK1LHqSF45eFLmhTfZp+qUlx7oWyhQjq3ET0U
fgmejjDbmLdRZ2GdLqQYvSic/nKY/3tjyWtEP7yOeTms8eXU74nBZJgdmIOI6FQp
MV1Xo73M+Egsr14U046LfFk3RYyqnDNme8/Ir4QOOxxMPApv0caXg6+ZbhJVHdoO
/3K98/I1Vic9INkxOBhgDxY+EpeNJJE0+7x9Kr8vGoQzQkU0DWHoHfPc1AZYOwCL
1fBDXhj69h/mUK3o7F1g/mFKk/4H9MKdnc8WYFh83Wrtfx7bIR0K4v6vSFVauGlE
KGb9i8qRsOTrY0WhiloRV8zapdezQgglEdLbPUGc062VQCvA/GAc4c2OSZVaf/iy
QLUXRWWPgFZ/eRd+B9MGqG+2bcpAiD9mb57QAUU9j431bHPDVs2AM4om7lW6nyhz
jmE3MemfBwkSvlsrFDHRxs4juS86sEeZxxSb8VrzH6bEgxzKg2oJ7jIjDmJMRLhf
bVPhmyLFObzItgd/D6Ugch2izj/XzQ2xKHdiLYUiAYLXfHi24zEsF3EE5pRtBE+H
hq/CM8c27Aej9zqMACWcbYoWFQOK5vsuF+QsHnJ3Z07sP3KSfFTMFjMAezAgFl1J
9VN42E9o69RwKec8fe6VgbpWHIVAwp3l0fqAXYxI+ByB4vVhwyt9Cr8pQPHjSGPk
FfgvgBKTNUCTyM8LOdz5JYjXnSgSlktq3gGccK7zHS5FVSFUaHz0VcdYDTROj4WP
2+lNnVrtfP+wzBSvzHw5TYLxf6zD7r8jJ4M6fC8hInFgyeI+5IceQLBD+HdBKaEJ
Q9BvYUi5vKMiY8iZmgu+J5EITzHRivJLvv16h8ZvbM2it9yEsD36UhYNaYE6+Td5
WKfoe6C65R+Mi2SBjAmo1wQ3WEGVSuUlxRxxTIo9yxQXjYY9XzbBaHj5OdkExU6N
rCpELP6HLjcS+dUKJ9FRu7ZY08NZksQXhrOn6YfwkV65M6CmAVh4rgdTs0D5b97R
EHU36MyFAMqw35xKMLTaclmMmpA5IgVvUGctv2UrUkdAX9I7dHDRIY0jR0uKrdR0
LOkdcS+t4jt9w3MzD4wFurj+lQ1Oo87iG6bgmKxiRAL8tkMWZIIO3bXAK/4AzYTP
NcEK8wQvLmBLgqbAT0c9hujC8lkIwrgB1mxGMlyGMJKjUexMNCf8mNK1Ddg3vg6R
Dk+KJ+P9MrceKxDJQ1SRKtECC2/a1GUOxPtv1J5opJoWRDGxw7HhmN6egFjvKTob
FCIL+WfHEnNK2Xr1KLwrftBE7M4E+7ryNzqcG1FqeeX3POZ/3Kr//CLAFI1CaCKf
/6ohy/ScIvq2hscwbqMi14BIgYMJbg0m5C8VbpcGjlWsRAIfSXw+qT8HDmRBl+v7
vvjYOyy3fl2cgOKx7+eHMgrkX5lJ0v70Xx9wqiSR64zxCJZ2EdNCibp+uohaTBBA
1MylZFJ2KTjJR8oCr9jwheoxP1EahXYImlwoQkbxyG3Y+g2aLjywuu9puBFKAPPf
My7bvDBoLoAPDG2ubfevdsWNgU/bvIbeiYERCZgatB8yWF+Mw0wEER7M5Y5aAgvz
MuiiBOPHeEGkkIo2i20hkc+C5AGRYs7FGxHo5z8RgMcLBpOsFMAnUx8jYe9jtwfF
GLEKpq8EurZ27VA2hJdvoCEfYj11JavBk0++QmONe8Kdjj9mNURF8IJOU/Djpwrq
BaPAxBvLTJygrc1fGt6hhHoU/8y++tZiRNkKQBPMoLbeQBxl/cNEXkp2wD8a8A08
IXLmX2PN13dF9HRNlXLUKasrKWDKIOnT2tsidoMvRs/T7veKzeNiQ4DUwRVHjpl5
udzydP5jV9lFCCpUlKuj9kJ2nywjq0l3Cpt9eCXsgmXhsXFrw51N0YfxqLlF38/L
Xtvon4/fg7dpPp2BczuvzpPN/+adYe/MYAE9AEuGQdG62o9pLRLP9wrSI+wEjnrv
0ArRttnq3PERCiAYpYLYMYazi9YEYqoQlCOPFV9v3sswAbTAFJraT41v+Sw/EVua
KzclSXIjR3TkwsjIxGIcHmpwaKDKVjKTbLxiUN+vCiMlRr+RPK5nH0VN6vDT5nxb
X/jXUFkb6MhmYQGiOa1vGF2wUEXLleml8OMl/rnSCD/xSD5ZlJykmZCFIgUnqFUk
vSTwUUNrmn1SjDCh6MkxRKShXseoudWGLN0goMsVEJeJVj/b8BLEwL2Uc3hGPH3C
zpBIQRcrtyGSeYYWC10NuZo5hpLrAN5NM8lK4oud03gsW/cU23M60XY5Gk1VgAYI
Usfk9/GZS9pNGFhm031z2Q9pRTBaJhaP4x332yeafPAfdgzW854cQAKyDo/tOiYE
Y5u/7zXdTrRmVePPjzVg3XsScPpib1JA9IzZvHvR+OA72EdUDHWx+UJoFy+ZWmRY
YRpfOiN+zQIGjrQnO98Nl3MAexmkbEdGwqSX+x9/rJf8yUK90e5fKgRYSvyoEx4O
GuCHgZ2nxvpdSYrfUbnvuf7t4b3GQ0blSyTD/ozPYlvhSel/sPGS4pBdlKe81dOQ
pYh4NvanTik1GEiIzkF71PYWPBDmzWxH6Fq9Z0yvWl59vFs+5DivlbFW2xwosWl+
TqzwUypfnZNoHtpHSh2R9eTW8uJ6elYCg0G/p39JqjbWcSNgJOh7xxlcwoVeI9eB
/bo0NDSp7NrHyU1Zuc68s24+FqsslC2eVEY+R89TfVczxZYlm8IRmzQLu9j1GT5D
6zcdAlKx9x6SF9GRebXIYXdiMT8yeNuBeycIJH31K/+sx3bXfJkK/qN40qXN6BEv
U2JiyQFO+MqAl3s+y1m7DwaIXyaySy1EHr66v9jdmJwB83wN8tJrbmohRx91WqsU
KxfnNRP3scr+kKlxGfmIfKI0ySQ+G66LIMNWPiV3g5Gl8VFkCde2w/VXghEmi30F
ja8Ns6GTCb7YFWxR62HX4k2h/5xUf/7E8cF8QMF391YIt5oQz70U43mvguuV6WGw
DCKHZw5tIbLWgMLVDcfmRlmBm0z/1IOK6hu5L/+vSJfZDTga1cSXV64YFp5EPkYN
FUJmL9qeGQPod4FqPaWM80a4TfS0M9fJCj3ri52wAt93CAskoGPnOL/waUbZZ2HD
z7aBxpj2a0w9SvjCnn7GA8KFPLbOEen2Xz85yZPIv9ygyFTkIET5BtWdpTQgtztw
lbREMWTjpm+BbLRoKh+MJGlo++rjMY0JJOVqxqXqnWRaBMSTjYYrLV00or9pKLKK
kQA2nyEHKt8svgkL0ttjQn5KmAgjOdEU5xtXtXzdSfz+XlN6nDBDYA3QX2mL2Ym4
xlevJAGGPYbDL22qXnLTdH3W9XnMGaZtMAohDMiNBaoyq2mo2zgECGQPv1IPezjj
CyMGpfOBt6FUbKpqemQjXCpqAzuQSnh9MFQxKKeDk19Pq+oVpEcTowSPCQAUbKMj
Ju2JlsPlq+zwFhlanCqutBpjCfW3UGtniELy804cUnV/CiBGxHkBVew+i29NN+a3
srAEYFdNdI5+vCEDaaixZTe0J4Vb6NM/l1Z10k8rYihFRIk34tUenHE3YSHSou9S
gwq3mSmfDe8BvIEF80og++Cyr/33ujwMWvQNj2PSDasqKiKtQeiCdqf+sJ3Q0gVz
HM3ekpwOKq82DuMwFG+shdN0dLRxObQ8zjvaw3cqu5Mrm1xvuRodrYnX3NZKJZi9
pHjo+0lLkMFJ7Bp1lilTUHdXFqFe5w08LIi4iZMUrUqQLT77Txg50T4gI8GptPfA
zByJdyVriEssrGt7rJ9y9/IX5zZSSnuc4JxSx0B+iuGpNBzqyw731hAHaIK17eCU
vxcWqawmG76OnYfQ8EEnHAzNUYhzmZ8UZl9scQPA/XPloC/8bHQxelPANcv+JtgQ
FomxSJ+wxYVBBB73pyznvg7+tx01OCtUo0idwF5hWf7gM1p/qO5+8EBJzMwtVgrN
EkmpvU3Ac2EkeU67rzXUpxFUZyWkAkUHqBbLUcO3hhTDbNkB81G6xwsbUikszeY+
cUpC/J/85i9bLDbNA4rn0mOPDsDTZws5Yabe7jQTI/b9G8ZqdZoQddiCKKQgUFP8
hN2PzHnglg4uOlaL+7b/n+ThkPjWBL4cILj8lS7BIHci6mAUP3nKLMzRfpiZthR8
NWtcTCpNfZzSmS2BQd2U/d1syuubMVcYYdGwOA+kc/sKw6l6ZRkfYZpYcEZlAVqh
K9lpgF8nuetbZWqcp0ao8+4lThuf3ZhmIsooZSfS0ZATtwLfNVk/dH++LOoxHJWD
tNpyl7wr7jCtu47N5nB8l/2RQhXjvunaRbmjbgAS8WLlpINxHgJwEXoZWr1el8ch
v7bJK4hpLAv/zUgXaBhYbAruX2zt6rf2aWGVpt01NOdYI8CRhCNmJz79OMhCSRs+
pZ3Zgej4Td6NBKNkH8dNx9b4vx8rBI+XjFcrnrlciqB8wYiskNPkYrQ3H0ZjNsVu
gOeeCr97gQPgcfTiiMETUxP8tyeBBZcVqTfzEMPrKzDTpFfT7YIEt0A3IBByQeIW
np6sN4t6ymH/+3pmGDx+JE2f5YULlBPwytCfz++qZeRb0Gd3ctKkLwly0HmhEIht
XOvTbfL09PVPbzTh3dWliJU8hBiACj4P1jrbgwptl/Rthvdb2RHRx5bY1b869Uh9
Wul7D59UrSGdPm37HOLQPve4JboN50yDe1R61XknP4SLkPltcw4JriDZZlD9R3xB
SHJsxDugpmmX/6sx2z74BuFdXJDDftyVJx2TFWWqXpaBE6m/1QZDBhh4RnloCDvP
L1nSAaTp4INUyZGJx+0KZeTRx8hPjxBgLX+iVTpr/1QxvVig5fRqRruqWqN4jA8F
5duSpFmMwBxtTf7AhSdibFjnuvx5J5zTOcEPv2AaBKcvELsjG5a3ja0FXAZCO/wb
N3620s3a8Ncz7QjvEt30+GfhPXFLxEm+mqlfHr4MUqJn6T0q/CKw2YDQbyTqhUYj
d3srK8G9ryllZHXTOJKqBy0AvNfmvTlKFpxzBXERnSFMR881w0mbRys/ajUhsqYk
l9hbpV2F7Xp0YE2AQsYUU9F9TjlpGBHS5/M1ljhIHNtrf1jagCcZZhgJ5sh1O0+5

//pragma protect end_data_block
//pragma protect digest_block
KN7L8AMzTmqR2Or34QQvnSL/zJM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV

