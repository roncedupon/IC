//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_FIFO_RATE_CONTROL
`define GUARD_SVT_FIFO_RATE_CONTROL
/**
  * Utility class which may be used by agents to model a FIFO based
  * resource class to control the rate at which transactions are sent
  * from a component
  */
class svt_fifo_rate_control extends `SVT_DATA_TYPE;
  
   // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_ADD_TO_ACTIVE = `SVT_FIFO_ADD_TO_ACTIVE,
    FIFO_REMOVE_FROM_ACTIVE = `SVT_FIFO_REMOVE_FROM_ACTIVE
  } fifo_mode_enum;


  // ****************************************************************************
  // Local Data
  // ****************************************************************************
   /** Semaphore used to access the FIFO */
   protected semaphore fifo_sema;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object -- only used in the call to the super constructor. */
  local static vmm_log shared_log = new ( "svt_fifo_rate_control", "class" );
`else
  /**
   * SVT message macros route messages through this reference. This overrides the shared
   * svt_sequence_item_base reporter.
   */
  protected `SVT_XVM(report_object) reporter;
`endif


  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** FIFO rate control configuration corresponding to this class */
  svt_fifo_rate_control_configuration fifo_cfg;

  /** The current fill level of the FIFO */
  int fifo_curr_fill_level = 0;

  /** The total expected fill level */
  int total_expected_fill_level = 0;


  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_fifo_rate_control", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control)
  `svt_field_object(fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY) 
  `svt_data_member_end(svt_fifo_rate_control)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

 `else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif
 //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Decrements FIFO levels by num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param num_bytes Number of bytes to be decremented from the current FIFO level.
   */
  extern virtual task update_fifo_levels_on_data_xmit(`SVT_TRANSACTION_TYPE xact, int num_bytes);

  // ---------------------------------------------------------------------------
  /**
   * Updates FIFO levels every clock. Must be implemented in an extended class
   */
  extern function void update_fifo_levels_every_clock();

  // ---------------------------------------------------------------------------
  /**
   * Updates #total_expected_fill_level based on num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param mode Indicates the mode in which this task is called. If the value passed
   *             is 'add_to_active', num_bytes are added to the #total_expected_fill_level.
   *             If the value passed is 'remove_from_active', num_bytes are decremented from
   *             #total_expected_fill_level.
   * @param num_bytes Number of bytes to be incremented or decremented from the #total_expected_fill_level. 
   */
  extern virtual task update_total_expected_fill_levels(`SVT_TRANSACTION_TYPE xact, fifo_mode_enum mode = svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, int num_bytes);

  // ---------------------------------------------------------------------------
  extern virtual function bit check_fifo_fill_level(`SVT_TRANSACTION_TYPE xact, 
                                                    int num_bytes
                                                    );

  // ---------------------------------------------------------------------------
  /**
   * Waits for the FIFO to be full after taking num_bytes into account
   * @param num_bytes The number of bytes to be added to the current fifo level 
            before checking whether FIFO is full or not.
   */
  extern virtual task wait_for_fifo_full(int num_bytes);

  // ---------------------------------------------------------------------------
  /** Resets the current fill level */
  extern function void reset_curr_fill_level();

  // ---------------------------------------------------------------------------
  /** Resets the semaphore */
  extern function void reset_sema();

  // ---------------------------------------------------------------------------
  /** Resets current and expected fill level and semaphore*/
  extern function void reset_all();

  // ---------------------------------------------------------------------------
endclass
// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B41R8s5J/79eHNfxIiKkwiYm9L4RbjmIAQTHa5k9cdI+mC4snDr8zhuFRehZHODh
cDo37Od/M0zZTorqZUpY1/WPOoVeZJugFc8t2UoFiNaKEisxMKy+gvpfOHCT6RLE
YSDjSS0Dt1pC/8HTGJKQ+NOtkEGOJf6xqJSHYD1GaBs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 514       )
RA/x3gr883As2OIY39AopsTrp/QrUBdP5ebV25urMIkhB9Z7BKuMRw7Kmzlt6S7x
TB5pJU9HqYj5OTMuZNOy5yxoK5hEoUUF+Uw71z0LLG0C97bQRXRXjcZEXDWiZNJ5
ULiOW11vI9QJB4DmXaXkpZWu/iHoznJnc9e7dq8K4sY3FoB4EO/Fs+XJO2OGEn8r
sOEk3QmYxfyKeiDC+x73Oe3Qy5AxJDgzngWM9gvsVvgokRauHmeB6/PgfwRPQA0R
RlkxkNVuC4EhSQijynJZDWvMNWFAzguC0l/AYMIjicKTrW9dPa17jaOOhm7Bv2XN
kXXoKAIHrUwShYiqGP+uR9cHF7rmlF0eAyuwa1quVFYs1eEqHQqS67lOjoVWh6G1
507YZQY3PsIyJPbg6uRonypUg1c6cTZAw75DwCu0+76zC7lKwa1PaRP/9DNKm3OH
sY6M65Ya91cc93LAzG0Umt7YDy92uRFwPnnvVycwKWhp1UPIl9qLT5pxa5c1T+s0
FLs9gj/lH0wHs1U98n48avgv69aQu0KImUEyqHuFHbTokT/ts5x4i04qLjs6wMMy
od+0FHOIBxj0hy22oeC0LJ0uFMQGYtvgrbJB2dkUWUmdZINGCqxtBQNQmlKR5bRN
f+Tk5Bs5vEMzXeUhoW1EoJEUfVtcfaq6mTqr7SGTkGBawf9FNYEdi2S0tJ5TD+PC
`pragma protect end_protected

 //svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jC/VvuGsBYj6ZhXC6bVAH4yHRzu9qAF3Y/1qW+W2E9IZA9jtlFFcrjt/SlZwA5Jv
+hrc6r3dp1ngHWltm8Yh1PFk7hCtDZJN7SpMF4Ao73ZGcVpISSiBkXFu1Gr1lu5f
+1cTWzMX9zOI2UFROhlfcLfYroiM5fN/knb+0Fp2zew=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13194     )
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
JIMx6xrFtD5FJ+8hE8HpZuUh1w9bFX5EsW9iHxLLZs700GjqTQobMMB0D044f6hq
0smPJnOe5oqkvW/2GMOcr2b2gp460qjU9a6W3z/cmNqMYrZTP6JkPi6iFNXdUzWX
8M8iPNa/CWy2Kz1fuFvy/v1Vplm8doNo6Ja2NgxLNTXxIpBySGkamviVnTjQt2cA
60ElgDNJP/aED4rqsEwJQ7wni+EqMMsHPe2/9ZkyD1mlPnclT6EjFLIKavN7s3d0
BFf30tp68MvqpTk5XbRlT9ITNfClMEYtIyRVJuxl1xQs1VN/yr3fUpcVjJ7lJrfL
QVSVO4hEAA+V5lYzMOJPO6r1dZH8tYAPbcLBLlenZdprFsRv/VBjglCbek+4+Iud
j7mdJel0pZPgCEtx7Zp4eA1QsSAsdYxHiN5PO0wZvWvX28pQ7x1lVUn0rl4tdBAj
pNAA1CMV7fDtMQ5IUiV/shHTYFpE7m+3vV0xUr87cbYtGNlxSmqJE2WkPrZkEyho
x24iCEgjAF+QL2AtMXocumigJF168qzN1wLQOA01IGxVpzQSmlDvgSm5c7xmniv0
4v0KK0hmq6tqG4P65nU9R0SyR5q0PH1PeOAUGze8Z7a6LOc9vlphCth0JBQHabZ/
ckNXxZDON6iivUa2K/7teP+Yp2LwZ9UlkAntMP/Juit7tFEKsdSGOYerVSes91I5
OT6OOEqxWaiAYI2j4TKg8dlccRGrzfcm4GTTv/cyymeX/2hhsGBxEje9h1n/X5ER
mfruQ0x63rx/bjvWi+oCVfvhdf7LhVfaw0VYwwWbGPgroiVAHZIxbsgPynueO2wY
LLzTteeyU0w6oiwfCtjlGWZdvJBGW6fzSXEI0ywoXplrmIi81cxm4gtBASjve/b3
11IfbelyZsPlusiPiXzHM4FbR7VMWXVpVjYTgVwCf4vL9ktBxj2c4VzgXEFpvN6n
Telw8Gsmuvt2hr/bRb00Zr0QjFy50jM/6OupLnXyZefUS6kEcq8IYowYKGYJk+BU
I3rhTbNMOX9dyOpqffXCX3Rcki2GGCf1bKRuNuBWxcaNUeMNRE6PtDznAaZQQwPx
6eC2bCHshwVwcCNLPvaAu425MH2cicFCPvS0hzeLcIMHEOiwKulxZbOxzakTVd4k
hiyj6SXif4E88dFqELlXegwMribzGmAgZVtWrQecdMUq8BKu3tpOv/P6dpia1XvQ
5T7/W241PV/UeAb58G6Ek5rROPCMJbTKiSZMrF9su9q8RGGDcvnlRsoApGCbafLm
qsUNTetfOBBQPFLSCAWGS40tDswsC6oIunKKS4gxsAOqm7EF4udXX5zN7iVnxjq5
J+0s/HnABZS4/vaxS9fhZt7iVO0Bt3EB2yYDT/XCF1XdwgzxW7lCH6keEPSd0P/E
4d0YDD9QAnl7tBfGFLoFKR7+owFia8Yr6VsEte/5Hw3TB5RcuuJACWvJR16XSWZF
rj9uY6oEAiKONkLObKTZKC970hJ1d9iQRU/wWL34vAHVKAHxpFemK0dIPDp140OF
lmnMwFdR6OosUt/bswGrkneX2PlCvPMCnfcT7Gl/zxao1eD8dpTaHCMBdxX6529c
MKo/riS0O3GN3d5D2CBJMxyCQaN5JH4K/NVdWb8udo5n/TpobXdZnlImk7IifRa4
tAjaeUdTZfc4DVGKoHwERvmjnC29RIj3x5ggjEZ2AKIgnWlfTfGpAFeDptoA4swQ
VOz5oWyj9s0VHvBDdIZTWMafolWv8F9lG97d+ViuS2tRfB/VXt+Hk+Oi9phCACfq
SMNpFjt9pN6c6TsDmqGAHrtoSQrYyP153QMnWsHm01LdDAiUHlV9WK1bcP0ILQvS
uiwW1zi1mxQZG/rVqMbTgnnv7b6yArhhY4+YBtNvPV60+jIsqpQoKKi7A9p7QPvh
dNP0NkzSVisMUgiqrH2cJ79N+BZWrttRaTIrh76W16tkvWq9h7VAyUA9oAByOsAU
W7dsN4I3CyRbjyOhMABBWv/LgbmLpFshQV3axXnyBESrmatMskSW2af+sD3gwtQr
/XW+z6VNHeWnuf3pKiH2BXyG4Ryp5303HgpOo5fxIgSs7GXh7fCIu5tSq+ACBJoV
EMug6SePKhRk8WOO7XMGXDQRgD447sEsfAES+invhwL86s+yfP31C9+2nMOD4z0G
njepprPfrnOSCwc0Sb17dgemTgKXIwXR3VDSdiwAGtTWH2Ok/s+Qto1O5jqwu6SD
ONkoqs/iq/+1EZXc2O+bYru6LTD9AjAdZYlrUT31M0wzCwt+H73xmRfiOAbFLY81
6V41tw9cQ42YZ0zuNenTVdJHv5+/d2ncrtHis4NcSh4eeX+3+zeZIqhxoruNm3rn
2PCZgATzQdiRwF37CEUohvp4YcfR33Y8cJz8T/DQgozzKvbfKcwW7sR9kj1oFnEu
AQtx3ipDafqDAijviAb3Vqe2bETP+XliSzvM+eN3INdXeIbY7JmRRJszV4iwYR79
KhioRT/AbqiDvYQ/yTmZr0I6HPrxQw/dm6QfKOuB5WFWImjmWKx+T4/Fg9EukgFc
u26/+WZVzQx/crUufEgiqd0GDyjcha2Efx6MHwQNrOg75SAjGUQQmF8I83OH+F1t
2eI/di8oyVva7zKSxwNUVp0iwa2n4AdLL7ynknHtQmW4TgOtnurZeuqnjvQ8fVcx
dX1Cd1O4VtHgDvqBO1j8mUMmKdACyQllJ1FvS6yYhaviS4JP/RJOZPvOz9ph+Zfs
kdmCV017OYKb+TCCsGmdhEB57p+P+AK9fMazn5AL5yedmOuw70GofaKWyWTzKWOV
1+8Jg4hfJuTuOKTD7GRh4YGZRtPgg4TlJSS5k04GmELv3HrK3Yw/hkP6fIILZ366
MPpK4XA7e7QIx5Xa6yCX8vcDCvMiGSivvcco6xRpujWNfZwz9F4X6T0TQI7HyB9Y
pvMezS9Cb1sCGm/k+EfZIX43LLbmSW8sDJCH485/YWvKTbDi2uXVX+jZe5JuClY1
x+lkM5Xc5S9P4Zv1JGhY4NnPncgxBZ88tJltBRR0LdblPqXEc8KXCNNi+GxEv4m9
UHPNgbZPz5sJvWFeRkc3Hyypfe2okAlIgEHbBfeuGp9LIR3zYMpr3PFqzyTlHDcB
5yMYvk9s3mgV+PAz+VioRGExnIhS+qLbJnY+FgZox4O+NX5SxXpCDTbeDo1FWTVT
ndTfVNjvkynDVIBLVDw0AYQ5Ruo0n7PLDlQv+czwXkTP2Q5Y/SOqrUQoiKmprsnU
J3YtjYcfGGwDImmIReecRUuiV6cIOTUPNeabCtQQ1SEoMvRTLe4o7UQaZN3IzmJb
6A7mTkRrDU6/T7xsJgao5iHyJd/wIDzkbIEZ+m/kewAotocG5JY7lpwlpOdpSuij
ZZAcX66Klcy8lbKY5/i/Gu5k7kaqJ2ydwKj5wOeql94emmXtv2txAjBCvzJsfg1+
VErORZ3+j0aakzQstOdgrsUUvlnzV2qmRRZlrDhWBop7hAkP4ZFHbkGVHor1OmgX
5Ms32r0O43v1iJhJGKiS0es+vOr5RNEC5b7bDUYPzYeDz1nGpjnCdoj3/reEPhX9
zcXla5LWjsPIQ5XiBMlfmQl3xtZ0KMrQ/gM0K4JTmypKp3VC/yXLKBFljPuK8lxg
J09ibZTwIrCxXgEkFAY3ABIiwo+qtHc0FU8WXEK+saWRzHXmBWp5BkIsHXnrncAN
1CT+eNwM86IFrfm2pa5YYrwCUJbvGnZvJfQt0WR84IsA4gsDzCF6LD00spNNVqJk
I3iUOb6wd39ZImeeUUGmH9aLxKGInNBu0EKe9NUVZc+emKW4sYGE3qxHBh1YpQL0
tIvt5HGt49QqMs5t7BDKEfOMx+PBdxxX+zND0etPE4s/Vowt5lJxoR9k8FuTH3s7
3p6bNKh9EYmJO2BgPQ+dcdbFR/UinPYeXMuwl893O/71u8qP/ilz8jX5BUablTXC
Gv63958MtjA3YwSZ/mIBvw0sNyGwNfReSkLDszR8MWLezvkzV7tTP02nfsfIrZs1
aT2BcS2tzk44KGQUbhy9huGWyPcLHF2DfBMZZRGkbnlksQq5aFawWNPq3as0S6Kt
FhiBMObI3cZ/EEy15eSR8eS2yzK6UwSRx8fUfR2LYfBw7+iFosANd8saVoq2DOfs
UEQg9Jrvp9BNko6fzKGujk9ECemLW2245QZTDddAmjEyN+PtJLA2+f+K9qkJi/4v
yjNYLnYaUac6hwSyggFUgz7gm+O246/FIHYfIMfyriVnl7nd7CbsdTgoW0CjlVQ/
ufMLhHR3Igi7Z2RLS9CUuWC2CtcC26cZ0NV7G4kP+OtgRyGMTnxH4JWDaT1LCSWh
Yb9szqZ2xev89ljArz6UBS8oaSEGI66B1otxEUxUGEVxTsHaVvCrC7Pv0cFpzwvl
PMU6GZBKnp5J+iVcY7EYk4syMc0M+t+jyVdfrHyeAHEuW35jKIMWLVjfPzalbXn5
hrbSe+x/SBmQQIQl0+fgLA6cPGMcNXrLvTO7wvNPeMbspx78zvpBN/0g0OjQNqxf
A+i3Sf2EUA+2VXuLPW3q1V8MuSrp7JhDWNH1RXHhsp7Xor2z0XlbHqmDycurG7k8
ZpgvouC+QD9L7hGWGFai4ttOu7yW8H67qy8PpTFbtbxrQSj/vpK5aBg2QsE9vrQg
8A/0knt8IcBOFvtHs4Loe7eZVRhh+LYkVrubpUNANYIlxH3dqzt140mxSB/aVKDl
1QUMHrs6Q5twuOPuenE9elYVZvxECPqvBgyPepICRiIQjjrTzXZo34CLOfvfn69n
rwjZqa/OvIUTg0PvafrNc7VIlB/PFKzzO+3PSpfBVyHhGlQGiQmqCB/kY01ALMeU
RtsV8eFbcbQIj5xhYTOvUP0Rh6LbnL2dFm7qsgZ8Sx2s/MKQH7kzYIErHNUUHLMV
YxVlSZebi0YeCXSXNJm9sN06ZuCDrnhRF1xZC25PwKxnYQq89iMqzyB74KQf+RpM
DFBy4sgZUZdJPTWwiWEMF0pXqNfAhfTaWCCB+HSL9WfL0JFF3Ar/wAkG4XABWbZD
GJZekYXN61NuEw1fHfLnDX0zY/JOUnQWErtMmRMAYC0Rz+9eqR0HFn+5uWGgC/MI
w9HzIn7Y54tJDhI8XOOKGcEFwm8mRRJSHLYZ6lyb2LQLs2HI7Tcrmelv3oYo1vhW
Qz5WrU0dpVZaoQdeTcS7a+dSbbqz6nUMwBk1VyZv8VKs+JXVf4QwLxuBvKH6V5d0
yiT3oznsl5v82lWA65HK6PMAnmdJAtOAI0rF/Qj2AfIrPztlMGaKlGApqE33wM2a
osF57EvwtLBl+siM52GfV6keNbatp8lf2vVcbFooZyavcUoAmTwH5+kOgFytmKX1
VVOAvNC9i5eKJgm7yQ7nG9i9T5FOxVIQTAn//SK5D+/iqxMObJH/nZt2LvgxZZlI
/GWTwhjzympeTTclq36WMX7kKdXSECClVf+qJPk+ZnCswg7UTMff/KPZLY5c1xsV
6356Ggx5ztJYwTTjwXi8ZOPiZEvJ53Ju4fiTaYZev4YEhsNRPKKy0RPrRXe3v8zp
Qn5OQsnQyaTKBpuab6nYLfkiNrgAaBdT5dh0Bhz/E4wjz9a2REOOxTbQFOlZTyQ+
HZL4P3XzsBue6F+WyRtU88zsS3QOGhfonJThF6RZZ+JiXveABvtgC9y4G1PTDFKp
LTyQ/AP1O5VefYOQbQvYpKm03bY30HDVdFDts/pPJVLSIpR9/g8jAY8seJ1l8WDu
IINntvgwUxVuz2ruFQSt9EacnBKMXADGUgnLamBNiRsH4kKdst6Gm5IvvM5MzozN
8TqM7xY6Gl5O56x43rcn72hWXEKIR5mJv3j/UelbEdgYS1TophdmCblt8IV+SbYI
35SntcN5LuDAEGUh5wUwhJjG8KBAnUdA0bMUbWge9DFROGunWErOnE0SL8ujkfId
1TXVx67TYFg/Uk66aF5RkD+JONCzvcCvisq1W4+4clrEdOKphgtt2FNmOb6eXLvy
vZuH1Xt7xyb5z8FcGY0HBRi55gaLR+eZd2bWkRcqN3fdBaY1iekeXlxjiiZ11ZyR
3PTb+9xyfGEUtc9litMN7UPq85E7mji71wuqL4LWJ3vKUSW/k09D7yi2v2rkfUK7
cwEYlJz+TmvvFDxLO4rUBAVEEJKYc+4fXiyVSGv53/VdHvkCTCOdWMbzCGFZsXjk
TVxwbJNbFKpWODxWdJYoHybOOEcINAENkUgnIR6INlgunjZ7ihlkwAZFt5u2YbD3
OmwzFnt6GNtWnzcO40KasZyls2SxnECHK3AiVkOjl0oDUTOUMRo1uwdWa9vNatTx
8qil7cM6mVuv+uvdTW/BxhHjyDIESCdgWWTroVNg+uIHw04F6XsjsvnnZhTUzxGO
I9V6v2kAgBDDh9oPkyq2BC9gf2l7vBd/l3oaoEN8DcHHGFRYJ7bPatYIX/MPDI8V
LJgJIH+cZEAj4trycsvH+kmmi7EJ2aUTKkuYqhHSSXsEWcqO1egRATu69FzJpy5W
QPsiytzUq1Lauj+ILFRMKvY1OZidTC5BY+PfyUg+6CcAYH34+GJxkbsvFx1FijAB
y/6K982U666RPl5kiIiVQ7hWCxnm/Nqtua42s0qsBANIVJmQXgKv96ANFTaqKYFL
By/M5MYTvqSnSN2QqKy2+525oaczXdaqCwei+zvzoWj05l1csQ9TB8/dW5d0KJTq
K560iVbn9AZYEQt8vZx/sgHJ9MpzbwlCh1uXVcMsFY/EktvGrDoB3cYSMW16Td5m
h2Jq81q2iqQS3SLNuBkqqOXj4kf0V0zw0hTwCB5Ki5zpgI7sNBge/CDCOscrsyIe
D5Mj49B7oUj2RWfsh6DL/N21uQbNgfemRYn3J4GwfxS5sjyBinm4Mqozpvp0n+5i
IPEfS+LeS/b2bKdz4OPPC56hp0cn7Zuc/+siAxdMb+68/00T8HPWI4hLgAXIqbC5
qBQePGffTIj3CKEbPFqO4c+pWEz4IsF/Tu9KzCCQ1IPVr1aSmloaKx7PAPmMchyB
b74I0IRJXW4SIDwJNgdwek3oYdBfQEK8LGcsq84gDdAel1c0DossnyAFdR2wslL7
vKae0xuxiF8HVLT5kYuHkrwo4nX5t0MIL/UyRu1HvAdQ9QvtNGgbnhO4TlKtzlNT
fWB+ae0uma8Dq6phaCQjPg==
`pragma protect end_protected

`endif //GUARD_SVT_FIFO_RATE_CONTROL
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XNoY4glbyQe2rqJS6KFVrsA9q6fuKmkg/yd4/Esduspsdjof9mE/gIdLqKsEbkLx
L31olC5RQOYZIeOJnTeEvWkjYkk/j8Vr7Qhm6pQCwJjpG+OtqdrhVlO80cSuiBl0
R18uapSiYWvpSAIZHRMGPbeFYRo3PeX7ftknjsBUwmE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13277     )
L/7MEY/Nu67ULhOw8kkH0L6WaCU9Kb75LazTJFZ7DIam6QLvw0Pg1qm+Y0d/6/Ue
frkQGFbn0YMtmNpqkLvJICPxxtrRhjwl7Jx7ap19hR5/5dyJmB+Voa+/p3PrCeSI
`pragma protect end_protected
