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

`ifndef GUARD_SVT_SEQUENCE_SV
`define GUARD_SVT_SEQUENCE_SV

typedef class svt_sequence;

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT sequences.
 */
virtual class svt_sequence #(type REQ=`SVT_XVM(sequence_item),
                             type RSP=REQ) extends `SVT_XVM(sequence)#(REQ,RSP);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * A flag that enables automatic objection management.  If this is set to 1 in
   * an extended sequence class then an objection will be raised when the
   * pre_body() is called and dropped when the post_body() method is called.
   * Can be set explicitley or via a bit-type configuration entry named
   * "<seq-type-name>.manage_objection" or implicitly by setting the sequencer
   * manage_objection value to something other than the sequencer default value
   * of 1.
   *
   * For backwards compatibility reasons the sequence default value is '0' while
   * the sequencer default value is '1'. So by default the sequencer will manage
   * objections, but the sequence will not.
   *
   * This does not, however, reflect what happens if any client VIP or testbench
   * sets the manage_objection value on the sequence or the sequencer.
   *
   * If the manage_objection value is set locally, then it replaces the default.
   * It can, however, be overridden by configuration settings.
   *
   * If a manage_objection value is provided for the sequence in the configuration
   * then it will replace the locally specified value.
   *
   * If a manage_objection value is provided for the sequencer in the configuration
   * and there was not a manage_objection value provided for the sequence in the
   * configuration then the sequencer setting will replace the locally specified
   * value. 
   *
   * If a non-default value (i.e., 0) is set on the sequencer, it will be propagated
   * into the configuration to be accessed by the sequence. This will force the
   * manage_objection value of '0' for all svt_sequence sequences on the sequencer.
   * This will have no impact on sequences which have a manage_objection value
   * provided for them in the configuration, but should override the manage_objection
   * value in all other situations.
   */
  bit manage_objection = 0;

  /** All messages originating from data objects are routed through this reporter  */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();

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
hNv6JKXQeZPtGzznakff3lgu02BL0IDB9oXJpskIxmrbklA/eUkqEknAyx/WZIuT
YMdvurIET7EChf4HtL0y53Pay816TyyYu7Du8e2StEz86h68PVUtVPUojLxjBA1d
3AHF+zU1V8lo5KvEy/dV9OcSOLQU26JbPv6HxZt/rKM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 296       )
cLR7lqWhUWMpmhlRXHD4rdQY7TugXVPna8MCt2FHGCvwrnRcxg9+WR/ALnvD2CTb
k7M9lDAO3OEY/uK6Ie6b02h1oAAVOuopO/7bSt3Zfbd286W137rrC3wKaQwCvmwo
It4UoqXwsk0PWe5IbtOuTI7gBeK8syUMe08DZKsVkGG7F1Lw+TfH/hSmit5i8lrb
hDo/7vMvPKrKVMPW/nc7Ui69DkquwIEx/9toZp0GdFMWXe7nKCdRKJSZcR9husm2
6oybyi/eaZuzXNPHc/BAMQigbdDW0DbWgHtESPuUKjuiMv6999MAMrReArXc33T1
2Thrd1bv4S+RuRzRUl95QkCRfgxDOEaKAR+BR4J1zI4vtxYQDBYOc+CB+CQwrBGn
bhAUJgcfqfbuAjYDI5ks/A==
`pragma protect end_protected

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_sequence", string suite_name="");

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Div7r4u0OzHxhExSxb1IFWmIe+Q5j75NlQo94pMNn8w+KZZmm5L5PbR5brFQFEKI
YWk72J+E0T2QkgJqxh5/+HqJBm+qVjc4ipy4iGBZ744uQ5cga28fCul4KTgfCC+e
Xz1oJjbBgOUy+ZhVFyc31aTIVIU0zGKpA4xdri0n/jw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 699       )
nmCX6hGa26B6nvDoq8MTFnlTmYG9TRRP8JGkoHb3L/diw1sP4VcUE9Kl/NSUzQdj
QhFG9LW1edLH/N77sJKynJU/J2M8u2w4SoF1geFDntZ/Sdn8U9v1v7lmhqJ8szGh
wOc7bbSN1Yn1UySr+/kLe5ODU6f+i/CsazmoLGUNjpmdYBFTUJeW1xWQRKpaChDf
frxLv6V/eHWpm1pUFKBiG8fWq6ysc9TWknaSo2jASdOIl8LRzsPCq/J2yXeXoEEe
qHWNRdFss2q6pLdhEaRJWZswDAmZifsF4pOzKZhWYOY4j4rJpsW8rxjSTzpTAnXD
wNgMDZSxpApvDEWv9RoCIwD+vXw7kjhTrf6UC1sjAAarl2csImpv+KAatbJoK/PJ
nRgkGAAtiiA2pYQrCRKxc6AHTsugBOs5cHqVo2J1nw9nB3Hk2YrKSwnkYBQFXUxn
GF/6YbeCevihPl3b2hi1rMWXv5jkC35bqy6NSIRxiNkxh9MFJKRoBZDrU6/9JGyx
S+FFjUVx8OCcMYgDZn2P6cBLuWk9OZq+3L0c7BSIGcM=
`pragma protect end_protected

  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GHU75ilGB/ElG8XUjVmU8jceo1RdYN8fj4Hl+GLetO7csne1GCX4RkDuGOZyCh08
d48AMHiDG/LvyJi9wYGJ2p32TuRhup2PQPz+xqG+4yq3gf4Ct79j/oU/X4V26LWj
ritP8OEZ95pZntQhscWRy78eB7XmIjgf/xIm74eDcUQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1067      )
XCKS3obfHeuF4JluwL4hdSfV+MU1WmlyLHPWQHV649op7y3jKBXYEk4WnLNHcG8w
lsrKEcHtxDJ71HV/4x1+jf1F6hnqN7bhyx000wG/HTXSeIsPRpsq2REvQDaJJoQI
iLvOwNA5eW3HU9H01B/qLIWJxTAaqfFEfKh16fzYMNhkBGQxkiml7ma5Cawh4mju
c/4nHtgGTTTmXviGpnnV1eOwMplOV25VrMrjIv3GmU3M9jaJcNXRssSWWsH8iN8c
lZFmEZw93MzKMl7QcZmboj741vLa4L+yd2ac/ucKdlyl/g99Me8zM2Uf7ZUgVqFW
WTtQ0FTnO2SfR6B4/ZYW33lj28EA16N1qJr8AqCk84sxGpJWphXhHrSsC0OGX7VD
SvTlB7wzOZMBS6IPaDMldqpSE2MYnwZOrgnvIBp/GWF8tw89eOYHJo+bEswtrPt0
yH2E99AVTE3WrPCy7fhDh7GKbVw8hqNdXYawo+mQIa4xhrZzlO7qBwCzk6ADcoF2
`pragma protect end_protected
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the phase name that this sequence is executing in. If the sequence
   * is not configured as the default sequence for a phase then this method
   * returns a null string.  This can be used to retrieve information from the
   * configuration database like this:
   * 
   * void'(`SVT_XVM(config_db) #(int unsigned)::get(m_sequencer, 
   *                                          get_phase_name(),
   *                                          "default_sequence.sequence_length",
   *                                          sequence_length));
   * 
   */
  extern function string get_phase_name();

  // ---------------------------------------------------------------------------
  /**
   * Raise the objection for the current run-time phase
   */
  extern function void raise_phase_objection();

  // ---------------------------------------------------------------------------
  /**
   * Drop the previously-raised objection for the run-time phase
   */
  extern function void drop_phase_objection();

  // ---------------------------------------------------------------------------
  /** callback implementation to raise an objection */
  extern virtual task pre_body();

  // ---------------------------------------------------------------------------
  /** callback implementation to drop an objection */
  extern virtual task post_body();

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FpXMucyB257+GWQwvV18p14xrqkgZYMGJvoXxqZVUZg0qOvn7R5XXF8Z60WJQGiT
NlHdFeU8v+6Xitj1quLJNjAmBOeHuSqEfImVVridq3E4rOTWnDSPBoC8sKeF2oni
LQsS9bvdyalvo54If2KffzwXQj4XeK8B5qb5uzodl2E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1763      )
4p2KAXg7nXB6xiLsZtTI4B309sQqak2RHyVT4El7iNp+0xnHud4nLtPDYzQBeO/b
n3m/mZNNAXQSkD+Y06nzQUNY8HRwaDH8O33WlWDQx9C8EnvxxeGgb9ixDLILx/WM
LU+8uWDL5KjoJYxFCijdXeF4dze2jB1e6xqVKpxo5WJbRe1hj3GlF4FZ2qPns2lV
CxXP8xD4anDHtyuj/fEnqs9MDMvAnv14TYjzZ/r82yjYsQBKB2r1rsVH7+IBrCes
4VXTzHyMr1msTiPuTUanR30sgtLHM3T0WtNYgS0i46tOxTHO7V2FNIo9rePJDFfh
nDrNHyoIyJ7iYl7/IWCyyENT68iK+NW9rpccJnToBXeGKVaVwH0jgmbAI/8oKbyO
YhVh65qXin1FRYzZY/eF656qfw60j5J09hFil9HeQG+PSeSUDHPtZjZ/+LnS0z/s
k1Vijhru3jAREtSJc+fXtpTR6GDo63aK3+OGV89tbnlIrYR/G8PWx85NbZwyGfzF
ztpkAWHvztyc3jO+7D1AkH/QEo5v7knObGduSqbsMgnxp5/rdffHE7vYY4DFpdkI
uFb6+1nwHMyIsdGIamjBx3BZ1eiWQNdyheQFqVY4DxVi+UuS9Ah0flRVBKdEhKqJ
NuOsuEjwvz0ePHmSYMeywxFPTZI0EdpDxLtXSa5YmHYnDQcA+/dlzxI8LE7koSuq
WHrpryprlyyo/YfKwVUUlsjIqVkcINhBpL5ttQ8EYD4l19OXlNGJDZ3BIWjS+ABu
H7fc2Vpr7GotToAWXQ2pH3Xw0CB87D4x7m3uA2R9/fnqYcDaarWZnK/K+npQnhWM
flmqYysF4x/YCa06JBKRrdxOIwfNVdBcRSMuvZNYcqiAHV4X9I1++qCBG9ATtGt1
Jq5+n8IGtXqMQ71LavoxktY2+ZynSUGps3L8T4VN8pU=
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Obtains the starting_phase property from the uvm_sequence_base class.
   */
  extern function uvm_phase svt_get_starting_phase();
`endif
    
  // ---------------------------------------------------------------------------
  /**
   * Determines if this sequence can reasonably be expected to function correctly
   * on the supplied cfg object.
   * 
   * @param cfg The svt_configuration to examine for supportability.
   * @param silent Indicates whether issues with the configuration should be reported.
   *
   * @return Returns '1' if sequence is supported by the configuration, '0' otherwise.
   */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Utility method to get the do_not_randomize value for the sequence.
   *
   * @return The current do_not_randomize setting.
   */
  extern virtual function bit get_do_not_randomize();
`endif

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to start a sequence based on the provided priority.
   *
   * @param parent_sequence Containing sequence which is executing this sequence.
   * @param set_priority The priority provided to the sequencer for this sequence.
   */
  extern virtual task priority_start(`SVT_XVM(sequence_base) parent_sequence = null, int set_priority = -1);

  // ---------------------------------------------------------------------------
  /**
   * Utility method used to finish a sequence based on the provided priority.
   *
   * @param parent_sequence Containing sequence which is executing this sequence.
   * @param set_priority The priority provided to the sequencer for this sequence.
   */
  extern virtual task priority_finish(`SVT_XVM(sequence_base) parent_sequence = null, int set_priority = -1);
`endif

  // =============================================================================

`ifdef SVT_OVM_TECHNOLOGY
  local ovm_objection m_raised;
`endif
endclass


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eiXv8Bc87siL4ByrAc5B6xhdaDEpkElKe50ERqgco9XCn3QDHy5fJ8AeHJH6N782
ZjAtjklgevnFEraipjLINPbM+th+60YE7bFR8jAvs02vp+ziYIF/JTdKlW65UDkE
Nikv7aVAwFY78xgvF+OsdQ8auxpIebHWV42nBp8fuMY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2890      )
i1PHl+vnsnouqzhhxxMXJUmDWmlWU/U5I5i5K0qc8dib4z5fXG3MW1R9kVdSL+/J
KCiwCCuauwkKygi7Q3AailFp2D2gGqQXhfpxB17/0wGMySZp/16jEZljw2UAtNiB
97EACNRkrgE+IXAl2BkOhudDU+4Z47K1QC+Nf6El4SAOo6b9wBeLZp2u2W6mP6Md
rJ8UIGdK2alGR3LGK0DpwzT4IkcxQPmaBxdTzeijqj++cSLfqXG4ORNEnMaKCmR6
DNFaGU8RmaaOscZ3PK7Vy723ToPXfaU14xfKZ/OEXpCP7W8CDboQFwfWQzhbPdYy
y08jlAGPvkTZR4vo/XDb0sZgQVaNB/QUSZb9kQRKVylrmGLap1NgfD3eF4r9trC8
lc5QLClR2OvDqVfU5Sd4FYm1Bwhcwxtlks85mdUN337uGhDAjjY5eqNhTYSnr/kM
0bZCkEm+wMRIRS7/r7Yocuv3/TNkMWmIHJB98v2UyDx419DzXkvkA2zn2ydRdlFU
FW+4pKaT7LpAJ1W9Rq7T6oNmDa1LRbvc0mJKmfBBGU4FYOkTceOcXi8XUKEKojm/
lEabHj2C+0nQ8wJJBKJn7eZzT395E/RsMtnNnHtzli7XZjB3QIz1FdX7VmexTLiH
KISzpkuyn69ttvIlI/sOSXSNiOVPZW+qW73rdq4Jrw36mcCm7IZKTP9CuqOY3BvW
heaPHhvcrkd3jjoQYTamuhuxui0CGL0X8jxxPEn8WvMOLeSIw9Ql5RC47dNZZAcj
iMfutidRwiAkspap9dSN1Td5qxjpGpTR1bWt01zRWtHd10nWajZQlmVmg5/VJfya
A5SCh/jc5He/6IXQM7RScjAHsXlry2HhXhRSuU5OGP7zWxwxRTyShguc+Hajq3mK
/irqYOFbDfYLOcxtr9qHho+ZeKiOyoU5CLy+QaFxNAuS/UELcidE41MY6wlBuCUo
hia1zczbbtHN1o2BS05QJ2x7VDLkAlUov+jQ7NoS/G3/OWwDONqGs9HuJGBEiU2N
rG9Ll5/Rr4h0WXNwAltz5JjhwYHiSf5uZ36awea1gIpBbozgXnQ+UAdsNIS+Hyb2
niOGwDTaQ0cge9EP6pN9AucQZ0XWIiRam9/PwVIOnwbqcrD7wdK3qxcYmJWZ9olF
rqpcaVOvLurfgOLNa5zlqwS3wR+iSCAja/qc8g1Q3kMnqNsjm5iQal4Oq5331WuY
A2/DjZVJGRDrW2B9/tVzuBBQ2Eir5b1/WPB4Fn3/UHvLIDurAAZtpD4aGs6V2I4q
FzvAIfHRWOne9syRy+ymtB/dDjjJiKjvyhstkoTvsAByGgGz7aW+hmUdg35C5/zA
w6un6+mxZeGo5X+GfmQd+Dof445+LcnKM9T9F6EkpLMVvoflMwAcwa2rv++U985S
Bf7J5W7Q9NW9OKv6Lsmw4mQ5N8Swo/E3MvTs4O9wC5Clq+7MGBpPwkVmodtErrD6
pmPAe30ftK/JDTjRVz/cDXyo8YGqu7djGUZ4GWEoDsw=
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OwE0D+Kaun7jfUq3UfRBzUEpYsNVNzqoDgGttbqWJ97bfeA1VHG62D026CrYInBv
8YXPbuI3phMP1bpWOEcnovuGiFumo+ZR3kbUNSVW2b4cFFzpl+MbpnW2Qi7sfa+c
jUI67U4I2evZpeQUS1Huinm4cFsP+UHJrHbBGyvUgGY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7937      )
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
QSmDXhhH4LHvcyfrwLeUHQ==
`pragma protect end_protected

`endif // GUARD_SVT_SEQUENCE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XXC1C4/D6mVqJYf6fV2XORoub+wtgGKokHn/qdKQ8wsWcXIagt3BgR0V7zHfumtl
momEliepUbDrzhrTBAYsUXJpvJTe/5MCRbbsI6f0f8pGV5W2EsTwnXc7+2GkjR3V
6Xfxe8iFOXx2WOMIT1RpoS8FapN3edpiIhEFfFyBBGs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8020      )
GSaaEMi6Uz196B+Vc9FWPSecRKY/ZO3RjTpinffQHu2bawPyka7U1j/3QkGLeBfn
RqejZvQCQtBsjL2DPM78mYpC+JFRdfqY9LzCwUZ/wKpkECMs9mhynpPdAxQo8Rab
`pragma protect end_protected
