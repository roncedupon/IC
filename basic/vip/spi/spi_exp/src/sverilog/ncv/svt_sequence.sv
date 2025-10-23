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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
o5QzdLjZvzrvh6umBEFVFrA0miOCsJPSw7L+1P7mHQl0KyhFCTk3xHGcmehevuUJ
WM9740T0fd7Y1aPWgK/KOu3YyhdRLtxemcF24Ya6I2xgu/bzCilxyHAYZbzR7E3e
Gin2RKxUQemGr8eZ69cCH6cnhnRxkGdZi6qHwTAkW4Ovl26wELEaRA==
//pragma protect end_key_block
//pragma protect digest_block
kXWLMyQtNrxAsG8udCXbeO7pLz4=
//pragma protect end_digest_block
//pragma protect data_block
rQuR9pUj8GxioGqyk4lH3FCVGvBfLk4sz9l26WgKDrZQrQTSuYTztJpZfgtq8k1X
TH1QjnDvmh5om5PfT/zDe7sxdRYZtYO+nvNzmAsY3vEI3Tlae+G85rRluOtGmKEp
noyW/X6/U9/AcRlavONRwwMTv3sXyT5PHrQEXoLXSYICxYigUXzLJQGn+bnEA3K2
frAHs6VdKg1akhwimTQB02gK5GF3aEIDPJjN5ZGoUSP0g1kqSAGL/tTpxTfKVdnI
eA6myU5LIzfkogeXR4liuqzqi859AcxyFS5x8LR/ztw8DQfHAUrak75Psa6oX8kA
oTMgocwk7+BdcVtcyMDy8KWrfnZL2ZMlaEtmJWarUUGn5a/6vievmlnylWssdP8Y
EHC/M900rTs01pGnZ/vtaRjkgxIz8aR23QLXt6w03oYwrMxENv8YKAviEQZXt/ol
koYIn09laWWXywlgkFxBRKPvXGBxjD/m01BiovZBrYzvIK8q48WC+6qKwb7yg8XR
FvGTxHf2p2wQ8TLMj59QqyyFhHnwZ5ewrkTFHe1Y2jFn8NbixX2728YJTiwphEft
4o4KLWQfmX7QJ1pw1OtFMDHMpvO9Uvb2VfatbxAb3vw=
//pragma protect end_data_block
//pragma protect digest_block
dlHRfkaq2GVY6SCRezselFK6tc0=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_sequence", string suite_name="");

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NtTlVJpAh65WWtsN1OBQVCTpPbcOBbtTbZqOXsDhzm0JzPVPCejTc4zg9ChbsvrG
ewQE1z1Pis4JYx1IuKqbHQHDEkEaCbTElD0Ak082sr/e3XzOnHW3ukqIdVjiDgKj
rwrYinlEo0/HMLUNBEUCHEVJUcPwsShR1vZo13wVJOHA5mT2MgN8Rg==
//pragma protect end_key_block
//pragma protect digest_block
LjTu1XVl+h0Kmlc7LymLhFDIoJ8=
//pragma protect end_digest_block
//pragma protect data_block
8Fu490haz5pLf357qnFegZ8pYowykro9mJt3IpOEejubfzNJArEqismHkPbwsSpJ
KrDXbr6TgM6aqIXBndcRvZbDu+KBf08C7eZvf/RMpr2Z6nOz5/O4mBoYagAEGPI0
Xuunj+J8sPH2sWZCyjvEMp5TQjBIo0tyvEq8MEwWQyC+N7xCuQziuC01coCdUBQx
/vRgszNHWqW/4swP2qRrQQsiJ/CzkurJtNzB6X6egf5zvuMOs9NL2yJnaK/Mcuot
I7851y4yFijPUQ8oQG8lmRPZxxzPm28mHdqHE6/nhC2wfYI6u8SsGm11cm8pVNzB
nk3p7VHmy1G+ZP5HZHL2MGxDgT94kko8tVPy/e0QGJR3x9Rr0OdY7HGfwIZ0sjDH
VEsDPd0KLKRjZcM6rXaZIPtPiGWPcaFiok/qenzsGMRcMMVEU5J439x2OgW7LTRE
XaFQq7uyNCOxQSPZVnXZPL4LtvTyPDtKHUOG8eD79tVJ/Mx0GJs4flCcqopigNAa
l/GiCy80goS2qwW9XExiTNWP+s12pIGJnqo8MarLNaQjHoJNB8byaZRA5dxL+hKS
OWDGXRc3BJi1pheQy57nxDkEBSICOOd8fcfHOS/UiJS8+9T5OPVOG+cXZRH/Iut8
tbBLQ0efOA3fxzf6CCDF2N7y50jIiFqq46fEvHL5J1tDe3AeX+TRvuaCXyNqYI30
6Fcqu0+K5+m4Rr2S5F4YDm8ZJVl76GJurEtddJuS3T+Axh1xrczT3Eerlb/YGzEs

//pragma protect end_data_block
//pragma protect digest_block
eW+ryvG4zisjUlnFSF1n3IFZwbY=
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
p3xLTMBWfBhcLA0G184iz0xAo8SZwYxneqhH8G562qB0hpUjBnkrNF20t4eCLOOj
cI0f/3GfciCy34Jim6/dGkdD3o2+5mdv6Ive6DpqDxaga5zQBrWm4ijw1CHH1mgm
iUmQttpM8lL66Z1IakWQQzWC6B8EgT6ixu1x9BcK91P3pknqnPjkeQ==
//pragma protect end_key_block
//pragma protect digest_block
93910QO9n8dLZK/7dBUXye1YEmQ=
//pragma protect end_digest_block
//pragma protect data_block
Ahb9AxlMBzPS4Gfhg9Fxm+OE9UtWTqZQbBe1FHN9wG9KXHEFn7AimbXmTCW10g8h
sMofkmgkSKPbxLhKRFMby3RO6O5v67ubyZuZ3Dggk8bUG+RvGjBbya6t+MxmkeoT
xD93DTkNXS+ECigUgsknd9NUeHoPDcybvY2YqvE0wMKKUOXQSMVKMYeJ8+0sZRvq
UIdbCsPfGDtlwuHjXLzHTlySWIb6Nvr9hpXxG2Y9s6706QvJhI7zczS2NdkBYNZr
bT3uzkXMaqZUxLe5KCDi3MYxaTyVvDplSbpFiijqbYQNmV3Q1jGsYI+pYLX7i/FD
PMPIagVOpQlbaoK5IMxzB+1GW2IbW6LV5dHyOeUxemuCmF3NMREUlE6eAzmAeWYI
5YcslVtT/osV3QjaXMceScr5vT35bPyj6G9Mr5ke6EsZDjRdBn3w99GY05pzyCkr
GmUISoUoW48hRiDFZNLaimqlFaKCHwWfYemb4NraTeewXlTD2sPs7/IzWbOkCdmg
DrcqxzzveCDx9lWXINMT4IoIJzTCXv7pjG3kYVppyp1/Px42Sg8Pw5HxMMPTf4P0
15UYbAn9sVIqHcAuKy2ThjZriBOKDQ4DKWvXkI3Gv0G9lvL22/s8nM/seG2H9kwp
8dqroDKAldLumDIAzOB7GA9QIZByR0bcU2LB6ESNYwfJIXiUtm9ZFj8Fr+6SrOun
GFX2CGstPdKIyaRy4fxj5Q==
//pragma protect end_data_block
//pragma protect digest_block
82cZrG8WvVa3TCcaBIrDN9Oz/Kg=
//pragma protect end_digest_block
//pragma protect end_protected
  
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HqOwRwebdi1SWFiNQcC4FKHKOK5k5hyLXRXysf+iCRHxPVG/hMOL7by9oK+IZ257
XZ2I6OBshQKDih/jKuQMsuIP3oAaDnCr1FjgQLW/GXw2HQvt2sA+il0PcxO9iuhY
EyKJALJYRDvQHYxXJElDaPujTnaqv+s1/pHYFU9lSG5Nlvdn4mrQgQ==
//pragma protect end_key_block
//pragma protect digest_block
9uabjK+DZEkEZLaLO/j1Znrp0Ik=
//pragma protect end_digest_block
//pragma protect data_block
mToesPts9sYk0OV+Hv+eIm8Abc9c8f6XM1pANi5dWlXkzoAo2g1MPJSDBjeY/d7n
MUUQCSYvSOCAt42J0PRE5NjFPH4JBYxcBC5qN+Qva271PjbUUD0XrmuqmwhvzWGP
i6sArz0kW6uSm73AvCWWjfY+MXXAvsuRJUTim/uIXP34h+eXOVqleQ7gEP+55rqu
UdlPfm/rMR8JRISASafIcEDsTwNaXQfTrtFBr7QFkws+RdEB6+/jx0bsm34oiFx7
JOI4ZNVsPDZouIoiHqYJOqAva3jcCtaARQM1XpU658IW198D9qGr+eH7WdSGhZZP
k5fy2JeT+4DsNeB7zXxEGjVlO04jHX/3ZuQxwoVsqjW0Yk3pT4EEgaftTR+Ua/vn
NVFPTxA4yO4G4nKvldcG7j0oLHzaI8foOdv47E6kHO0mCOduIRigmRw31tOOx1iU
qvB0HKiT1A3Zd5AYs4ySRsZJ/0cTaTZsnkzvbUVOrW0qihbHe4c+3rPaNzLBv99I
qIYpkW8gsMyuDORTxrv0nDiO51sDB0u//hrf7CjNXRnqdyNHVzMcSVDY0jRoq8+o
9HQHwYjKkYd4rUWZx96jFttmMMt385i2mi3Fd/bPzUQExg6PQdSFUIZ1sE+weX7/
dwMWZ4GcQCt9DJyVKET2ITEOT0Wn3lUt1kk1mDRCq121ELTMlltlE4GIJSwRNJ1l
rZqBdaesj1/e9pVfgnGUHG+mf5Bq3fG1ZQIRkLeku7pDRg3DRLYpjAKUrqIo0u0l
a35BpZVcQfH08Ow2tROwFjaCFwms2N8x8BOZydV9p/1l0RuW6d+EkycPTJgwUViI
pXKlrx/Ct/uf3lZJmxSZ5aA3hrbjcyhzqkFqj7H8cEWij7Hbxx1mqaux87RS5rHL
MZMvR7f4Qixbiyhf4T61ax6eEHpdIBWd6NT0qbKaHrT5CJfKzJo9L1t2J120uCFm
ixRqSBZDnXYTpq6x/kxtd4seiRduGteY7+0e3r5gPuuGK19E4AAYFBP//unfCYdr
FQledUEw12qxWOkvumvrmSfckX+69yBi3+39Q4cu5LvxTLIvM9usYCasefY64Wrv
9QzzdSHnKtdPUEkUC8m8q09GcB0oJEwdln8ZI6VWJzevUAm8MolBJx1gOElHvjLf

//pragma protect end_data_block
//pragma protect digest_block
EuMfA9g+BRF1CRLQO+24QsL+XIc=
//pragma protect end_digest_block
//pragma protect end_protected

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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Qg4tI2cC7iQHf9FZAKV4Eh/4ZVgCzwU/V3PCjXxTyc/8kwg6/sUPK2DEgJedWivq
efrHtqBxg3soXjr25zEWhPZdMLIfMHQ3gEzcuULcukxyXZX5mSiBQVqkiwsHfg/P
xQhYYuWB9WXmHqVlyz0hdFuEcZnfPy4puq2oMo6lmEGl0guJi+XiJw==
//pragma protect end_key_block
//pragma protect digest_block
1ZjKGcRgyuZAKH2Np9xAdXpmN1E=
//pragma protect end_digest_block
//pragma protect data_block
ktc7VOuNypzJ+qfWycRLBsBiuHb+hou3XU92dYTQ+fwRIU70rtrdLQd/IO3ddDMx
qvqeXr0Cu1S4Rtdj0FRyzEULKqdceYy41T5mKazz5475w45oNWGtVIdAsBwRZ6tK
iU8TP3cAQMtYy4fXSBfCIsZVBO02ofdgW2f005MMixTuaNSRMf1P/7ldnflm0jyH
Ydc7BzBWnk1e6HRZe3GEgmknNSpp/PCz8A0+xLe9hX2kmGynYNQUJoOiBW6Qn6bl
ksxPrc0SrxalDLje+wiNgV8zUIl4LJIoCJclYXBLuCvOz8gVB25MpCNSCbYSVlx+
WlsAxXC1/Ml9cWc8oIBMcU343yWzTw105E2xHFeX8n7vmjnh8Ju+GahqK923l4Nj
FR437WddX10S3jaE/WrVMAS6Hqh5GvRxHC21AUO1Z8gwMqdjhU9PqJ3tY3SjU4JR
rRz6lkCdlT6USbEBVbdWgg/cjt5+sYn+vSostviAXIYkcxRORdL9HlFqbBylM20R
6lYzjbn/at9N7wIRha90kj9bL+XgmMxCwA17NJaUDS8tsfzq1WyKQO4bOsCim+Ss
Qoksup/gKu4yZ1FoDjwjB06BpW5g39PtEYRapDGBD3blWqLMYTLGwo4hQdH0GoX+
3yst3ipjI3gUPy90xiC0OIbJ/aQC9TDIpy8Cs7c+QIgUxZoVmm5BabuFVWTwwFbN
vP1IcvHcCljfeLVwUBGK0ko56xcINDp5D7dYwjyyntmuYcgtjFKNlzjpzoiP7dHx
02MUmWZNOgORXCgBwSkzl4l4ScItg/4/LTAu7YIkqDBEsoHSJ6kUa81IghWdvILm
Yk6POch3nLIM6BPUDp/0hUMEga2RCQPEPFy7SmZCEN9iveqR80SzVFwzFF0g/Xw0
HXbbjqnsedspvCf849b7uvBmt+q3RRvw6UI9X+CRy8ovm8Kp/2wK79U/HivubFZP
L+8DWnJDiCEAx0rB/9pLQy8BTwn3FFkmReqk+jhYvVc/lXq+LV6qqBkLlSof+PJF
u34nyXtb5dVWEpyZ07MFTcg/NhfTl2G2kJfWucguDK/jmugPRwxPNnrJceJoQIi4
xzFlqEb53nDdqz8y7guuNmjleeYOsgTJWjA2R7Dii6NnMMizZfKYKRasFBGvoFmx
uqrhnyt5Q8x3K1TuQiOwISa8go3eZXPE1sI+iZ0KcJqN5ssFknmiVYXIWN7X7dhU
/YZpZ+gubEYUlZ2PfansILjVjx8sI7PYhCLZWPxEr+Quw7PcDB/PkdcubUqUFF60
vKZ6XuH7aZSoylG2hw9op4lynypSfFwHa3yQOsg/eb0uTOM8EE9+I+wQ7m3+AiWb
KA/G8GdoB1Y+Gb6lWdaelMu69A/5CxSDLtVKykK45UKXFD8Ns/B804BbsvzniKib
cxFfQzbsygSZlBgK9oTDV1eVHXO9bTRz9BOkrH2/Xks7T6o8kq5TX8HGZ9wB0z8k
nR63zAK01FSVaBMcWPDkeBx9zBzNS5zTF7sgdMKA0UyjpdGqp+brh7aFglrYSw1c
N9jqOpYAMoNoi6jearFrVCemMRjvhEQfCtwiX4qdmm0yISa9nKyLO4EVvuxriqOT
kK00X6JZ1zsPxHyqirjT9WyKEtKZzNSvK1cywd/sg3DLhbSZTxRPuAJswDWabMqa
2KjE6ofZXiOB6A196UyefH+rYKmAxMSQoNEFkhouVWUoHXXRH/HdFULyY747CtDd

//pragma protect end_data_block
//pragma protect digest_block
B1J4lZJ1Qkvp6z/SqhEmZgIST10=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
u4+bGj2BYGcZmSLsdent2KlLhlHSSMoShBCjMNESvYOqIxkDOJgX8NdMwxDbMyOF
CWNKKmkASjEXWqz34g7rnAGzBIn+oMprh53HX3FBD0FRjEXg/y2e1oeWj6JLL6Es
DWhN8b49QBQVhzbBUL4Wj/XEwKQ25utfMtRLPe/kgWoFltxTsOeboQ==
//pragma protect end_key_block
//pragma protect digest_block
prZchZPrvPEJC/q2/bGtuzBgOlQ=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
p1BfCaioreMykfENsCQgy/ZtB0g=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SEQUENCE_SV
