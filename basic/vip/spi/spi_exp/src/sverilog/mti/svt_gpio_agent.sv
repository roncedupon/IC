//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_AGENT_SV
`define GUARD_SVT_GPIO_AGENT_SV

// =============================================================================
/** The svt_gpio_agent operates in active mode *ONLY*.
 * The svt_gpio_agent is configured using the
 * #svt_gpio_configuration.  The configuration should be provided to the
 * agent in the build phase of the test using the configuration database, under
 * the name "cfg". 
 * After transactions are completed, the completed
 * sequence item is provided to the #item_observed_port of the agent.
 */
class svt_gpio_agent extends svt_agent;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Proto Driver */
  svt_gpio_driver driver;

  /** Sequencer */
  svt_gpio_sequencer sequencer;

  /** Analysis ports for executed transactions and interrupt requests */
  `SVT_XVM(analysis_port)#(svt_gpio_transaction) item_observed_port;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_gpio_configuration cfg_snapshot;
/** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this agent */
  local svt_gpio_configuration cfg;

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RSVhiBEWhpxptSvoSbuw2o5qxP8mWrj9qMo2rvivOqqIXA6vEeHkYUnIAxtSqsf2
zYCMpE7C15txT5sqVtyv0KrFIXgh8bfCmROIYEkH+SbsszblKocCn+MVD7mdUmBg
Fv2fP+zFWthOb6HnLQmcSO8smcd4Ub80vuM3q0XPUEc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 215       )
2lWvy0xlTZH73PWyoVhPTPodDcdCAbO11p2ctx5rclan1aM9yxRRvoqOaNFd4Tg3
jZIWRB1QZT5mHUKjuUI/gvgscODfbAkQOCkJa7ntb+4J/n22Wges5/R7aTvVaUoD
iKF2+o8RF+U0A/4p/3oIsOcGIo1NIg01ruoO6a+H20YX/K5EpneGWnWlIiTxqBSj
T2lhaHT8Rd1KuPBmAs5SdErFFq/qu9t/qUEZ3ifoynXcltg78a/kyY5V5vuMHmV5
G8WPfPgaXhpICHZ1u3p6hsrlVyF58XyVrXy2tMHKY58=
`pragma protect end_protected

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_gpio_agent)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_gpio_agent", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the #driver and #sequencer components
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer components.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Convenience API */
  // ---------------------------------------------------------------------------

  /** Execute a WRITE transaction on this agent */
  extern virtual task write(svt_gpio_data_t data);

  /** Execute a READ transaction on this agent */
  extern virtual task read(output svt_gpio_data_t rdat);

/** @cond PRIVATE */
  extern function void configure_interface();
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
/** @endcond */

endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FsqoFFo7Pa/0DprJtD3CbOD5Gzh89aVPbp+507DmPUVRvFkD+0lRXFoohlSewLyg
Cbdue6lr8lGa9yJGVWPzLlAsuhquofJl84+B7Iqn7DFU50skoCDeKXsuqJAIYQFW
PRbOremC+dR/4+IsUJYMdOcUq0pikqespdbtakjubtM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10496     )
YT0wU3X6ggtlSmiDpim2b6tK/S2j4MOIA4etDGVEHS2DfPsOC4THb85ffArjZjEL
o5+xLvJBroX0xz6Yd+6HvlU+mP3WWKCzvsYkgQCHGHLE0SWkadNoVJAH3y03JK47
TMmngOty7Cu6PmXl4GY3aTJjvBYL0Z+CK26MGeWsqZcwpfk1KIqZz104GNL6d1Zx
qiKgBnt+RbbdkLRA0qAZY+x7zFov6wt+PBsdYkzWjR4uJTZvxBWWIdzwP2g5Dy/d
CPAhAlb44Rnql4IvB7hfABMRU/Y2ZMmzL+f0d0IV8noDDDrDQxenVhlD369OkpXi
pk+njkBChQP52yia5Lw8lZB16sj3NNoLUwz+hNLmy1HZhVRbuPTdtM0T/YIsDCnI
XguGzLk4a2CGF+g+5GDeMP3vTp/mNgIaYWkmGAB9y4a5goOimSXhIuWbptRFWgAH
0Y+7HdOEeNkO+luVEJefJiLHA2xWvKsjdgJd7pqXYxxontjbgZNiavKCIaDhq2SJ
+ehz43XHjvOXoJVt3itFaMEAmIaAjrg3kgDlXpLlyBxVA74Q0xENHF7JV/F4/aqN
02HCIx5I5pTsVEiKZ72cy9I5W8OxADkXrjHOEEtszjaIpvGMqPrJlTewWh090IOp
V8kHZ0eBE7wCCs/9/eiYKc2jBGWe1lTpLGlObFYmVl4PegJrh6F8Norhff1JMAUV
3FZdF+EJikU43Cq0DAz1xJH0890L/aR/TtRf1RxiSlFrC82jX6tw/6V+6v96U9bg
asuWsaNlfM8CKcflNvBrSPdXw9SQRMXQnr0HJcEW1HC/RfrC/DoA11822XLx1dEr
yO9tXDtWtZUsfTG2HIGzxJf0bt2K9qH3UlfjVAR2gnD9iH6mLOzu16s5voxFWtB+
AMFgc5EC1bYRPVrjynCtHyYJ/ZFcHKEQX27mW+OUfMexVyvz/iMOb2THDPO1A76h
xOHLFimQSdbBZ+TaGLIqHu4EYSdA3jbSqnD2xeZsoY94E7XswffAwM1u7vb5AZAR
c7r5KkYm1p5+Kh5v/vgkpVQ2zfCXXeUz5NSLlIDaZfK8xBePLQwnp7gOwhXmxBBL
unCAZZCxNZvTxSPcQi3lVNyJTJi6D+L6MMzJOiADo0U1YtOQ1j0XmiD3KauH9K/t
/fP6EU9OBMTMsem3vVhXFKciGEKj4LTbc1D5xCZlBtSp55rXRAh1OHiIoBZpIwey
Zy4iImO2MbEE3SIK5bTkUcXTjMMF3u9R1wjA+Cnf7Nmz2bVPNh4QbGlMugPsbEsF
Iuhzw58GbFkJPZJBxL3uIQTit/xm0QVlxyYEvMNV3gkuQjIedoHFm7m/MVsE+rMf
kFrl/s2FTymlvgE1BHJMYaBDL/jXA1CR674Ten9hYHKPxnrXMEEKaM+LG5rXV3xI
sbI14IYFTAIX6HcvF3zCwzyiRPqMyxNF11TWSNQzO+I+3Djkxlja8on/z1aW08Ji
ZL92h57AKnz/hrwdtkzkXmcziTZUXC6BXmaV9Sa6pd4c0qCq6itzrIBRhFP8bw8y
SNKUsiQikyWagmvkSbygf0Ko5cFdYCTfqf9pBZbVOWmP/3APy24WLHqWtn6dxkip
+gezpI8T9TEjtUZ8dRLCm7mhyz3qUMf4NIGVExPWey3E+Ci2NO0O2kG8ZCCnLcyQ
cUPX1MkfziyL4j2RFO2WrVD9M8AFqzAuCtCNaCby82rhauU0d2COn6otSc9DVeQr
CLXurxgLoz2m8rJEBSxT+kxMm6o9qclHCpaH9flXAzDvIlXeEYjSs8PHnpeqReVz
Unml8shdhMjjxfEuiyocnatjI5wMNWoALqOgM8xUlA3QqclYGEzPw2FVbKMPI973
fZ1oy4SOjSadxwMggCGpHYcuAiuNEgWTwCnWZLoJh2r2AGVV3LVG5bHDmuEMx8Q9
5oFR3DX2f2BDK2eZrGPnXWCZgwyNfMZztcnkE1aQiBIzVdPwjLxEEs6w7T2UbgYx
ZEmTwjlQae4l/MZbs29gHXEAr9fsuu4BXC4ltA3BPGqCWf2Yz2D1EUhXqBC/3sw5
0K/h/JGo+Koldv8M8XUNMvMOVdgqsdQMom/NCtpIYt3GsfFRk3YCAg+5q4nTv0Qe
PL9KCtbm5iHHyeAxGtJXoitiwJE4g15540NRa669N+V6V2Q/NE8UXzdhoUiQgyfo
O/JdeaYLH8fr/oWaRyQDyW+gwT5LPZAC3ZxM8iA7QLS7zktrUbMe+2G67tnov+MO
s514GoEzHtXQGIbFBWGnoS3CNphYPMFBNbBAzhhcZkRN09YfijhyYWP+KhP+Z+Zw
88CxGEvNgsDNiEzWwYRO4/wKpo0e+esHX4I+EtZzlYMQoYv3SgA4VyAjFWjN0SGj
4z9tF+F6TtT5uTz/X3k2zY/O3SkpDn9MSl9auznWfudDNpxZE6qkCggIwnYyw64y
UZQbzTAMu7AQi8ItDw+8DIpbdXe29IynMQmSEmkAe4LevqFQwlKILsUI4CBFNUYo
Zuyw14lxhs6ce9xFLPR1tmUkCSc4s3qKTxqIuMin6+R/QliIyZ7DZ3qQ+t1ABIYL
unTSGmArwKUPOUISXJFqUGLm0vTJhHaA5ngn1WhM7Tuw2jPIjhBwO1PKGiHK+pTI
vGYyKRzFqX7V8UHh8rT3Tc/1jE+dO+1VmP6S6e1wnE8YbQLQRvrc/pbiSELH8Odi
yizlBCp3fnqDY6Lp9nJuOODV4Rensa+5kSMGc0T4O41X0ZKGL9+edC3gvHmGuKlE
5DUzdvr3viACkMf6SR8H4raaS8RGsIjysLUJpln6WmmwaHBlgyHOokTaFKiTqPxs
ZtsDY9jaQ+HccbZETgYtor4Nw93rDqhxREjoRGYiXlDcpVmQzAtiL/dg7e8b5fDr
9zZlTU1IFdHJiCn9L+IG2kUBR1HUyNEosrIHAXw0qQpXCNXSRYieiwr5hs1R5i/k
yaQ/mei1jlz4U8wJ8pRpHjD56O1QJ3BLdgHd+3VGth96y9jDB7iwOAGZCZc9MwYT
6s4vnlaUggqySkLUnEthRFxfIx+cHWUDMBxPQl/sJ4DbYjxy+HMPWWPgrhAjzSob
i/TjPKpOPjNBnTgcFGBj6jJvzZ8AeCQFvzBTdO0dmzUQzdomC2b37e7zFaGzATo/
HONXl5g4asT1JYMCbRPDzvauXGMEA0CQLs4cBCUR+n7ci8Gu4zSsLfLpUfhFnnN9
U4ige3NISN7jz2UxpXGM0pWHVv/UPGJ36peCeo1E3E7g4dSujsvbWguxKkxKLs6n
boemMc4pdiX1Dy2w/owoY7DBvo3sMJAPbE9wy0bnQPq9yqO7SuvGfNmCdV+d+wl6
6vCTAQMuAx4vypzgtdlP1iy0Pn6rHMQJP+AzGh4e3fdF6yOWwNnzB9EHgjOBVvXj
vdbjcCrZPoGX2c8cxpeirsssItMJXk+0LK6UaMT/DZLPB2F68bWgBtADZBNyGrcf
bWWxJ8rGkJZBA9tH0leFHQYhg4Kg4Z0NUKcMgcvwE3aFaQ/1i82/Z3drQsk0VPT8
chRNxo/awJ1Fp+DXwNxIAYvpIRoFKC+Z5zDOtckemQI3todlVhIL/NbjnQCrMH8b
GQ0/JIu3/qUnk/6KiQqF67Ve+ZF+KlcO+L8vD8XhTEvY4cHrd5f7v4B8OTOiflHb
2ydiZW/n4R/tnv9lNX1/4olHg9NWZukZmfklVp2IlRmTMjMJeThELqwyqAR0fYwS
CSRBNmHn9a8rnShHmyP6MSR5wI3kzpu+92iaGDMFlPL1Zr/3iTDNm6w6un/yy7vN
bZWqSLkEtxjFVD1vNAJ4AqoOoEDiEhh2P1QO71H9OJ4uCorqUfTgPKqthAbPKrDu
+aS1SDqcmhlUFWcUIVly/LtSIf5xUJx5A0I+6LYqJpLbSUGSLVWQDu/TSQqCKYDB
W1KO95TxMYNeEl1TVm96zEb85g8JatME9AGC3THB+Z/eetvxdrHelCizNXmmMIok
mAoV7AJDI6DIWitWVElXePKyoVlQOz8zP+a5yfjHWnPQwQjNOXzQLHu+ca9tDGpj
f6T0i9QjIDiaYG/rdLWPKSGaP50zMFx2jdq/G63tbtUqTPN8aXDsqyqWn2Qctqce
wz3R+XUTOSvCxEY+mlFKrSHh8f46QGvjV5/bBXWbN4j9BUasgGjoiziS2abN0eUt
fyKUU01GxRbj15s28Ef0XEOjgc4Ig98meGW8WjzVt4MSzByyMKl//+CTMRbc/pBG
NX7wHEXu0anw7YkpaJjWrhv7TIJHc0otGFKW97oIF9w809SspV13bGqbHzazN0df
C9tirDva1ZEv660Bx0JYP0ADpOba8W+6dKGNW3HkKSlkYrfPSQpL4uAYV7m24FQI
DZxo9999qr+FP8V/DrKrTQywsBz/0PLkwywte2ZBWtp8F7Q7hnJCDzYJpr/gLvOY
dhAdVlmJVqti1icC0dYrnfgpci/bObzl7VaYFlbrkbpjdscKhXBCb7krC+VR5s9H
tqyLGL5LOi6PSLcaIsDBSXWYhJ6e0TFlQcrl+dUKkwx6HL/Em1lefV8fupJcXMVg
SlE1i/5+aen1yq04CYAC/orhvZ8j6wlTPqvSDpggtP37t1pGl5Uio8+WxxR8pVnV
lbhgFRCbSWLtMXPQF5YDcJw+LLa9SPd5kk0Ct6nm54lPFizRbCuMsQBwF68Fihti
T/vKAfopQsOAxmlpqSBz87jt38Ph82kilcaykv+kZ3xvRMjbikcwlQrKrOlfqUaI
XcnCOQuwVkEjJKbguevYryFtISWTGUOt7f2Ws9ZhFzpx8UP117flgBsUwB16udsU
NXUelFxQmZPnGOhcm2RGYWt4RVP/d03HTtXsNgT4+8RqPqdG2y9u8HtsM6mQq4sz
rbVPNZGCtJ+WV3phQYJgiMar/5VXODXC3gFe4qVrlxmEO9laPfxzlVga/JdHL2kq
hUCUUCS5eG2t1RfJ8HhX6kPnAaW5/6gyNzUGiznmyEtpBWQgBI3XQnq8Sikrv1GW
fiaSG0nhUN/NKstB/kf/ToG/4ZI69iPKHpQZ6E0WWWH41SlnVBqgNG0K88gUJJrL
eh97ZnQUt7nMUNTjO/ccTpjzuYaa061F8ng3QgGwrBOIhTOODif+iJDRhRAOokCI
F2f7fRdBxqY0dorYRGvTWCPMbGmGSuxHzbJz9MwqxnavSTbJGiYmZGq/31+N9q9+
Y9fmUW14hytfXaVNcNspRNx32JX1pxvujp3h06VHszeCS5lhinDiOqNiReTlcJ8P
tf+/Er7b6H/kWSd/TzN2rX1alJp+xLjaDI9EhR/hoFH9Gwx+c2CMZnPEoItZi9EC
Ha+owRAqOXmMkBUqS00Q8HNfX6Ff+XbKrGOUHqn4yUy2/9gHEBbZTQnAczmgnP78
VMbbBc2GoI2fo46M7r39Req09HbkwcN0BJfmA/2e0ZK/hNbepU1dQhBM3CKH1ZM5
M16+VyE0mL6JPXtaABDNd4qiGjwAM6KkC3q9cYzXrjwFh4gwZsSmUrGKpLZM8yWQ
3BGBUa4R4sMX/Cu3HRMFQDU/fyV8xjabw1ImMUJXNAPnG5ecfOsOxHXT/iG74UzY
f8oTrjEiPh22wvBZNO3v21OkMOXIAedBAChaz/MUSH37vB9/zE6FS38qnH+j226u
OOpKMMlZ+j2V5VvEM6kjIUpIOdN2J8SrK34rMb3VqR15mBUObry2mO3PzAqIpdqD
jRXrr/irGJFkmj1mBaoUBMXC0lOICtfBfG1vjLOL2L5TlkcQq9RKDa2OddKPag5V
pGKoZGPT7O5ql4h+inYD+7ZqpDqOuK0fJHh5HhosP/vqWp+5FoDyTCzmwdCRP4Wd
r2qlVot/5lYg1mTQ+Szd8bqbvJLbbttYRcbrceaHPPRTOu4mR5BBAzSYZvZNlvfo
Y6LPKtLYGuOstdvm5UMCAgNO4ukjC2L140sqMnw9Fy8B5fCr89V/LZKVUhPzI1fB
NqFIAgvj+OQaM/k+eO6v4UYX/gVFwNZEVJ/CZkfGXL0z7F4oO3fWllCc2bIWFCpQ
VwfoJG4W8ZLqGKt4aQmrLIOFwg8S+oemfG74Ssdf1N8zvCpN1sfbhaYHk3rRCOjn
8mNLzUKUITo/DivzUasNwA5T9A/SWO8rPTxn94OQZxex7LCE4K4ispCEj5HtlWmD
iAAQLMyiRt1UN2ngqgiSg3ebKpQGkJ5gmxSjby1MLcopuKdKAGEXpZH1uFBty+0G
QxkQd+A9Av+mXjxOQDSa17jDnRTdjfnZ9MMHP9J6zmJTGpCt7azk/+HfTDXK3lrX
3RxMyy9lFdVt9YeGmDU3I6qMjFaXXsuJnIF/VSZby1VIVQ0jDjwFcLci7ZJf+a2P
H9Xw93z+eM0n7yLeDLcDjgiFIS5EVMZ8eXtLoU1N67XNjIx4gzOzWtErxYIiH9fk
a2qNvy6EPIqXzo0XXSBPdnIwKSiJdq14Q1HbQwEO8hQPyAbCjDWdUHmijMUaHwT5
hU8o4PH0qtK2XaGIpyY1J50Ql8G0qACeqHFFPWhXZQNIwu/vGY1eHNLhmTY4hNDv
fOMy8d6gNNAZY3eSlMgxLDAxK8Xkr8E5TV2KRA7IhLcknjwVbcy96ZFgoxbAEwKt
rK0BmFQGnCa5i8MkniDWw0AkpIwtvk3VkElAVIYnf9qmUvmTwMan7OCIxDbUFGrb
Lwkz2cxG8BjZf1sXVkCROPnb7I69VQxP6A9ufMBZtubsRtuHCKOF5a+4Op+nsVws
t2TcRzrGnZ2qZyGl2Ssp8X0DQEzCVB0Eyh06VLNj6vTcE+T/9VsTrGGUWY5uuEki
kYgSvNAGUFudR5Zsic3lSibLE0sYaE4EPpnkozp0azklxgvMeiR43T7hW2+P9CXR
D5mXxddx+eeyTCSxhh6kQoet9dNNwdsp8GfDpPxS4cNTRCYnsIs/DA5wCwLcC1CI
g48xnBoykpMfrQUYMng2XpV0RPzXnxCq1yRjN6TJWR8KF8wotCIHQze06Yiek49b
XsPvwiTFxuwdiMUN0S4ynFj2xDZR9a229XpMQPa4I7EG+NyjGCQpMV1TcBwUkBln
10X5KjQJ/6azEh2h1I4mH+vVdWDW0MCIXi8dSqXwnvneE8y6XT0kevsODxwmg6c/
zaWzdjipWVPnrcEklukKcimfFGsj+qFlOP+i9dNwSPyc2lDMQT8O4kx06ZrdL6FH
vb19cOU7CAmp4/TJj+ppLMoopScn5gDFAjzh9drKixsgG+igvlpzl+9k7ll+IlHT
UYUYFsyoqNp3LyXg25kdptumrF+SEU8aFqX3G3vYEZNbmKYAf0G1wRA4N3HpTt7q
pQtL5jFgfRi1KnyhdyACIPUqvq/OcP5a0H+B2gi22/800aCXm95SEt6Ozs867Ld+
Kadydc5wTNR0GYgfuIBxtMjQiJToAP+x2n2oWGl7So3mldttQL14HkjiXiHiVnGC
VEtVrDPGvihNsnY4EcM87M0bfZvg7wPP4FkBDutqbYqY4c/4PSoOE/dgu4v5hOhW
avSI+T1eJV2dzdy6kZRkpRPlzZ0QV43KBGe/qxRkSAJu2N4CtOdLSVxGueR6aYFa
I85VFxqRdTLkPatF9AG+CDD0NHuKlecwyDn2lDF2ks0JgiI8JIDHDUyNAYG2IEID
njMxEX//Znljlba9Y/xs9bwog+SE6H3gcUYcjg9JybiD/FkY97EPN98rwRki2l0O
DaqqIMmwT6Dsyqysocj6xLNMU76nD+aop7b0cip2sx2dmr7OuKbl4qNctqLiQcQG
UEsk172gFRh515eHoNzYp93Dr1LeFJCflRIs+1cShXt3m8IX97YJryrZeNMAw06W
mySangAyhyHfm97Smid7wfUAN9WKnQ3LsFVnzGp2pGLG++sJydhwH0U9mwn13w5k
PP2IQs0LxY0O0ieFPMfpLM0VfRtW4Y2QJIPdqGgFW8HBmRfyc3eLw6ftU0Aj0qbs
LwxslDg+pKjq6xIFFx2qZSJ5b3nFknSvI1UuH72y5u7vEDIC+ub3LDGMyxjfOXry
D6LUt93IJr5QoKKSS9rcUKyv5OblToWCpHaqj3E7TM0cRqKxr8Q1XHNFG/TNcfPM
r8VVwLfi3uJ2WRRteVuJAFDjoqzMfttyf19gs2MIjsmMl+hmQxasKHslKT9AEpTz
499sHF2GJNaM/TXDBQgKPVE2re/7a7PhhtxcslfNlf3IVGStEucZSf0wTIq0hLPU
Uoi7Hc/YcguJd8mFCrXknLC60bylxxpmy6OOcySWJdv7MGOkukQEmxscuAIxMVdz
eDL1wOhiaSEFkPVudo7k+ucqNybNpCtW1/WO2n4JX/BM4Fu6YoyyOccfulYhpUQz
iJS+EDvdbiXBHrBVqMsemx/4ACeNgOm8CjI8/6hkwSj9LA+aMh/6ugg9j30O1ehw
CZNv1tG8oz5qtfyNHcNQi8yuUbyZaePjrMVCeFxH7ZYe5PJ2lvaIDCzrOzhICdwV
I96Lz/SMeHN75wJNp1FR7GRFFi06L/J1nOQGJtjxhHY/6prWowSzTSU4fV0xYN2E
v/zGYELQecb5VvD+C7DXTygoEvjUoRnETpeDoXkzt52lCfKF1iCaK6lGVrLr1jNr
aLyO8pPJUUWWq1ODdH3URb1ZxM9dVa2ANlfe2Wlvrvvzr9O7U4SM8yE67jYHKlHf
UD1qtdZRURDFLwyb+2b6YeIB7LZx27hGjghaUYF3OwptZgPfzEuD/dG8uKid2MPA
+6JX0W3V4w4H76z3HRrpwiSDoq7GWuZSrh6RxsnXxzaiPbjzKnpYEu5KRlM3hx6e
ia07R7ofvkQxAblZI1nEEz52iUSqmqLnhE2tthUMZqHoE+wZJNt8vgwMNSIrDQIl
UMuReShhy7PlqAKhqdYHZcZR4ksNloZYrmze1g0JJO+Suw9NEgqwgzbje0AQrRkR
cBR4WEp5x/b/41zGtj8JLKb+obpYWCrDfqHkYVn/D2FSVnPALXzWUWHG3HxWRE2k
rVuvzAUZMgEGqp/x7LSL9GVI6IZLzBgwVxAjoQaax8GEdD34d+A+EMKdCJDvfzcm
38LfbWOuyz2o+H8fMlSWfdBtoaiQbg45e60OGDnvOKfeYrTQ7im30Zl6c3ZcQe6/
aGhhB3HPkCc3t2eii3spKYBhUTvJp/+7TphNjaaaEiVoIO+YWu5sQYwBEDIvYV/f
/EyxMHURieHVkw4fvgXlcmpL3YueTITshBta+oFmFFQ4pheGZFeiphrE8iOirdeh
ZnqQF9i24oDj2i6tv13N3FGVjCiMDGcxHGizaQgXofFWwniaVtKHVnnpInsbQtG3
uvmcrLqFQGcyGvQyIhwxQ/daJogAnBMiFzGKPuZ/F3J0hAIpx7MXFNAt/uxaPNwG
Q3bcn/ArSVsNftNPWmKYlASc6xBAtdNr0ykrKpaiWhd7U/fKWKzF6q8tJr6hdomX
l4ACPqe4wDkinWyVHvOsjtMDuUkChTDXexM7TRBZLITqjuki80XTv8rv+ooRhIWd
88E8PGw7b3NRKtVGagi8/RW3AhQpn6om/H+CpcMxOH2m2+MU/6U0Xt7jspMpe/dm
aXB+oGW5d3NAMkmRsK1sK/MUS4SUeNyhX+S5Mk/uDKrDcIqoh45ik3G9eqcytuxP
9gGSIh26xHb4phd9rfAGWalPE0KIV4h3MaFz2ikqRCUpO/6IxoR4+McGZVZ8VShI
CbTo9Nat3tYNA8jY+lHkx8cyjrnQ8XBqmk5PZzFoH+wynaaRn4tuxAhK4uNBDrXy
0nI8FwEV77dU8Hd9Vqurop48qVsBHENmprKsCN0M7tV9qdTgRQoQDs7kCffRqQEV
CiH1m0TZQKrjYPt0AeR24FKCHzdS+Td0GWOqK+y83G7u9zvb9S8Lq1neGpOYyTYe
abvye8I+iLNvwPj06+mGEWMvaClX/n07an2nu14/U951Cobnlm303fjUlKgIwUWB
MpTZZ6Rn+ehsCjVs9Z2zJVZ7LiWLT8gPdpKPHYXLYzrBUNc+333SwGaokZrsKU9C
hTZwhTEZ545xKfsPeAwjpYmKqAFZI9Zx5JiwuXspsgVwqwtr/8lwMKHaQ/gKPm1x
Fayu6QrFj+yXjVMVzb47WMXadj6AYtQSQmqniopEPiWtUEZxqGGu3ZuITkSxEnpr
ae/q2ift9ZnNyeYtjpKMYLLTxOsI9SzUjCzhFO1oS3zT35chA6DU+eYVcVZD6ahm
fNNnoiW+FrLuRmRheG9azWpkVsNwcTyNONGJAC3AIZxhn2Vwj9GdDUgawQ4Unz86
mIKJkBRufI8fP92pfOQrWYtWLfQtlSPv1BNTC2t8s42t5r49mfpjk4vI16+Lxxfj
NmOKyNVp3WfzDP8AX06Snu3HaHRCyy7IGAHjPBk3vysFSXG7VpXY8covjlQ0ba05
q6x/nlju2nzhgn0a9rfggSWkgKtLtSNJygUwL/vniDRtX51APpk+CXlAotk4sy1m
RoXNWxE/fZGXUQfbTuIoXWjocAXVXBlpTLnq4JRDwmEm82dvbARDZHkwFpgVFttM
yqB8cxLtWrlv0yYzVp8nTc6SVtDONMGZS6+btkFumPf8nRcs7qN91wOc2Ni6SRvK
OItq4M/15hcJojaQLjCay81k9wuoMLFNKgyPgmPgvIer85DKXFMjtTylkkyiSWEO
IoS2Dk/KilMrf0b9hn6RZJpVsSQZ1Jh9rEmBWwe4s4UbLEmeL9ynk93q6Wc279At
aJVOAj+F0TSDY8FMhY0OESl3Ne/uE6+WdB7HW3rRsxolItHe4ckTI0T/Bj9DS9qM
a9WZUGq0t69gkZnShG9zfGAU1knXha9OM8jtOSz3EIwpNwe3VsDdX4M+1LL5Y853
BkyUo9zir99BuWhypGIWS0xR3jzt4Vr84EfcA5Yb3lhT1uT3vjoXgYWaocraZSSM
cksZOqJk617Uun27mPis4UA1QxQi/84/dHvX6PyY2B+vP7UPVi7cyudKDajOmTJz
QbSOL61YPcCOKifUvRLPMYKlFf1n+PU0CjQRTvXIZypnBtdpiarrMZcKr41j9HGq
P/yEti2kFkVmNst3N1b8sbxHEFEdAJPzgEYm7lO389JaK2+ZaMoVya0c6YxEaBrv
NA1abLKaMnsp8OTnaiKLxz42Bnx1Kd0tH5bc7iHn/twQ4yNdHT5hytlp2ww3nDk5
vr5y0wKOmLOUUSYsx/hC+PBqg3cWSji0Pfx7D/rA9hRbONh2JWsD1eNnzyre/2Kc
GLr101PkXmZds0gG0onnezBHn8vNGvAqG1EPPA7oZtXV0f5XFVvYD5SWAe9hAkdD
QmMfnTIzT+1WSWXSZdMiZGKwTwMiEVhxVLpAL0MXjyMSRqlQ5syWpB45HTVfyZOT
v70bHoKtdfTBUZrrKK9zaJJGFxu5Gm/aGHi6Qd/748YyMZFBIh4QrKwwtuLCRp+K
7+GE7KVi55cXbEETsO9NnU0S7Mop+aoWRYgG070kaFu9d4UMel8xWSZZqer+XlUZ
uLJTr/M/v1bYG8zr+6TbpycK8SuBOXeFXTZQ6/cMRHAET0TawvdrDQiR51DPpv/t
IkMWWTCmyTmYJguTHWGfU5cjWMq48OW6p4hdOKCJrTVPPng7cQiA/YTBQIW+ljVz
CDBBczK0mzLxEueecutZ0cw5515y7SslFHMtuOnkyAgljQkMVb5nzmExCfzraY7P
z2qfLQGytqj2B7YK8+82o0+b6rzN91P+6nyqNu3RYvly5rV9+YYEe3yRHomS+oO6
QrRAL5vM5xdOUAFADDBDr92N0iin4+EhrDu2noQFTgfFz9bwQ9XdrMO/dpHyvFWU
IaUTRMDnuofVYViBwBgiw1KUuMBsHR2Pm66kd/MKkX9hDoYxrH1FPCcmAV9ZBDvJ
YjtWHrOR12PWiLmQ7a0WNg+ZUs6eiMaFRKpLffmH60mQC5jMd6gR4PRBEYH0QUjD
jLbgcQWqNPJvxhRqaloOoKHQrlqwGUoHTlVSkEMz+cmfmCyKTMjo7PHdoxGTySTo
gKcYdQbcQk/GdVRuDyKh7XsU6ip8nqbIJDIKoWuxSrjkAlcCgaryDoa1WqTLI0dA
n7vg8Yv5VO3VsUIjskwGIvoc9Hqkbgg4ktd/xgyMwLApSFPnpS3GM1odC1L+G7eA
zSbCxNbkpOcyGOmBLwu242OVh5V4GVdiydGSIekCJdtFRCqmD0JUNqRWMpL1FsGo
ZrSS2qKNzeZs8AEredRMcX4dn902qA3eZd5VwNc/EHaGTsDUKNJRQ3ncN7EYFXFP
gz3K9zk5Y7YPTwA9UeVBY4YOxqjZm2n97gUFB9VlB9CBc2WqY7PlBDw1DQkX7wjr
e7X1Rgn3mEhz+kDgAjqkcgfFszZotqrTjB9C8ZpVXnu6CX6ns5c6gwycdBeVKjZU
hSnDLHZdm7qvf3rQQ96RX0/iGOt7WaW/yJ0SU1c/oOyg+NlFuiQySxpqazKPyiSP
x0rBz3z7HBPymmlWTbmcJ6wiWlYNsALVjJREbiBhAAWXYjp7jFm7juQz+WhvWAzh
FSfIOant226Tfl3sHqejQ0JdvYj33+91G0bf3q1+GWOT8Kk6ObUTwdD1/UWodgye
6jQAlwjJFDRm5h2eFrhEemoAYzXNunJiMbxMQmIcs2TqPb0qjQNtb/66ILuV6kwE
1YaWK+1W5vEDgstt+/JABN6Ly08NecPl/60mPv6+bIdvPsZHgAhJI3PVnHbiPme5
3a5mR3HBHGMYH1flz2PUeVOpRPMUFZ7G22mGcrQiXcqJqG9kn1iheHHzMSrrLRUP
wcMhKUtGOkZ/I0p6e3spQJWeCBcXWjk9Bpxsv8PVh0z8HoZ/ps+/ILGmzb59Tvit
ZWqYzsem8+ltgCSASVFCOQdW6gmPyGrG1hLELGM76E3UzKYebl8OcGQ+8qYd8+Zu
9N/mIAVFfAESoGSqLvpxYIEEiYhSRaawrILdzuz+AvxhMgWSR5wU9zp4qi9fbfWg
NDnXiG4kXQLjvrTUYEMpYCu8GUJi+igPSKx9ZTRJ4GIJfVdULX31kpo0QMHTVIYR
rweg3WHmEMAVupKuk7aYot8w0H/A7yZzRy6Or3YRj6rEy8vvJqCg+nZ6vxX7UjGz
ET1nvzJPo9Vk/ljujhP1bqmRbYNx+S4MAU5rR2wGgKgmHzmweKegcyB4Dg4fkd/3
VZ08SdW2ClK4361viPsuB/2OCa7ZX0ks4Gb+2SpeVpcFmUtjRd3nvrcEiLl4X9jR
ZmiJIXtW6gPQ+o/eNJFDVDujShSVxJ9Sjf+mrXvvZjdgmS1OUYfvIXteX3tSU5Ak
8EjJjBRr4vzC551WFNfUX08psBg6Sf9opWdP2sB7Xhd/+PwmFJYFSOqIAg2EobNQ
BWrpR6vNIyuFvxvs0vlrd6vEoivV5POPGW7bm3DPn9mb06qB59pAHTEdlzihbAWS
j788vygkcLa4Evc1pQTKyNQz1AaXjz5PekRqTIhtIfRb+4sb5YQiK2AleLYC7Uwq
vcvFiU5EYYAm1sDS0Md8Q452/oXbl+WQdaAPAEoS8dIpkUqLpa2RkfRXbiaj7T9O
Z+iuQhW+7w/r1/IhRcBEB++WzHbV14IZqJym4x08rJgFdQt0Y2yA+K8BiJbQ+cxN
ZYZpiUrQnRAGi7hb0qHZ61BUJvpPZul88+lQaCUSLwzGEKQfmbPNjdqUa7Z/JZWb
7yEA4n/X6CRbdg1ZCrgLsSi2enJ8TIcj5Mn3ZMHK+Orkg5LrsMbVDNF6B1AngzIR
KViIbdeVbVuLylfyocUphg==
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_AGENT_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WUR97MtX+UXImY1pFfcqeJw+Py1Bn9oimO6K33RUxWioQcU5j/swXpO9wt+uM+Rt
V72rLMKizzTjwYxQGwbe8K+Pv4Sn+N5ZuGCRt8tVdP7ynkZ5DXIUf2kAaetB8A7J
uiOnix+3acV9LfEvhsN89SNWEBKVY8KOCA1jXN63skk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10579     )
dknENV2SgLPPFyQRfALCoz9dy9HdPnMhzDrkRKesv5jwA/ThKQAc0jTaxWgK8eZE
d5QdiaDR8dNpxnrLdJyhxcmOZOANW8BGDv6sTiJjzqbsgLvLtjrqbJePrlOa251F
`pragma protect end_protected
