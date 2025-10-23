
`ifndef GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV
`define GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 * SPI Flash Memory Transaction.
 */
class svt_spi_flash_mem_transaction extends svt_mem_transaction;
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_spi_mem_configuration cfg = null;


  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_mem_transaction)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  //extern function new(vmm_log log = null,svt_spi_mem_configuration cfg);
  extern function new(vmm_log log = null,string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  //extern function new(string name = "svt_spi_flash_mem_transaction",svt_spi_mem_configuration cfg);
  extern function new(string name = "svt_spi_flash_mem_transaction",string suite_name="svt_mem_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mem_transaction)
   // `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_mem_transaction)

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_mem_transaction.
   */
  extern virtual function vmm_data do_allocate();
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

`endif

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
  /**
   * Method used to obtain the physical address for a specific beat within a burst.
   *
   * @param burst_ix Desired beat within the burst.
   *
   * @return The physical address for the indicated burst_ix.
   */
  extern virtual function void get_phys_addr(int burst_ix, ref int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX]);

  extern virtual function svt_mem_addr_t calculate_phy_address(input svt_mem_addr_t addr, int hier_index);
  extern virtual function void set_cfg(svt_spi_mem_configuration cfg);

 // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_transaction)
  `vmm_class_factory(svt_spi_transaction)
`endif


endclass

// =============================================================================
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
V6s5EkmQ9W1rn6Pfu86a3tJMUqloru+n77bAXwoL24mrLBcddLqmPoOlEQKk1UW/
gl2sob8TbBU8iUtvzTtfxtVlQDsy3sOiAcmKIE3rVtDHaDIghrpxj6IEK8dDFc44
g5QEmOKYeEI5Ts55asRouijvGdNFnfTZ4+cOkLRlODM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 889       )
HinDq/a0KJ4iWrm4O4M7qMyXlLw4NJ9ZpMshevFyMqx3x6Q+bsqzLbA3LXSAKHdp
667PKQyHIDzNcdLwVNpw967x/GYq6550lxJBm1sRCRgG6rNj9GwwyXtWrCWW8uGe
13uPgl/TI9M44/GLUeLXZEZvPnfMC9tU6NzXhKAbho7APWO5dIMrrOA+uuOr962c
TjnzciD4TqUWB1zpiwirpVyK1smWOB/IL1uo21nOk8MOI1MGwnVZ9s/6IsIYqOEr
wwaP6xbSFgHaQW3+o4Zw9IZUCQKV0IxlMIqM4RFhvHYpyII2jVTmdmERc5bmp5ok
54auvWxrEcOXuh4O2u3HsEUSDXZgX2w4Xpu+G9exhkzKQMwv4dAamQRRV4FmdXHr
0nYpVDEdHfWWyox3zlKLpNWapV6PrKpEFrizwIolPsHvSPwhwPM7Nc5v+Aa1Mczw
MJaz/dWTrlygnspZ3Bk1/39og1dVN1dRjm5rCuMbdg9exrg24gOHKDnGYcNGDvQ2
tGKH0r38oi/5KvOS/93m6nsS/fEI8Tk+Z2eVPLDb1E1eJdj2hIqchMqTrssY9G0Z
wq0ek0o3sZGLkc0OPb5HBy2TNkXLl7ukWw8eEtVo+ousJEpGmb2O7dPSz2qPtTXc
PmpZ1vpXJwrN3QigVDwaYKDHLpTB0tSUMKAG51Igqp4OxwOcunqRcbb0ef449muQ
tAg4uPmQJhyQPWJ1gyN1mU0tpnZEiEghZVVthq7lHF4ln87KZlQW8qc0V3qwBGxm
4NUN+ucN++htWePb3GPQUJlmIRGPMeJ5P3vFGcDDhVMgtH2TYN1p6PlFDEMVqv1J
3FgtTqUDJj/sDecDCh7FeC5JqXlXLr7u1bC6k5GjmdBDu5F2EcIh9vnKIocBMifv
17MEQR1HFX1fL7JvaDAEo+MwkBud3TOx2/HSDV7AIBZaJGuTVwndAqsfA/w8qyS7
cdPsQ1/zsGja8IZacLqFGxBUANH4LmFGSqBUgsaQMcsTf19Sk+O0mM0CwVtbobkC
eASQemNG0z+pF79JrNm42jA2ZAlvkMx6/5vu+KaWaxQoNc7VelZaC8W1e51HtHK/
NRU0fnU+47KZZoVX+eCW+fkAogxEQiWzvOaV6NeDkHXiZ1LjG6LWu43x0/bbfK31
HuM6nVA4pdo40xDq68vOIqepaFilhNpjPhZN/zrQIlg=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JPzSDfNAIPsKWf1NrdnCvuYMuRwbaRWhUlMm+o0cjuShP66m+AEgLULAXOxuaewS
AZ5rDtlwQ2rWImCeIvqi/hp8gui1ZZj9JSdM5RaTzIxaDRNT44bSvo+ihf/J/OX7
GFQriQv0jf0OjW+8YSIG/Ywu04EBxOPzQ4gMfnZRmNI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5355      )
ttXvHzw+M5TBCQlYNjXKWnPbj+DEbMMzkzSHgI4kYGbP0aY5wMlerJotxtVwA76c
ed3hsDv3QJmbZ0e6aCARVqM1WoDD15JztlSYM7z3+auD7t3Ic16BznET8xSiNBfd
XSeYlpWRfnFCuNUKogG5VAr/8G0czgkjylNjhqSPnv/r82Pjkcnz+53i0yhNTvcC
xDvjLcfsOXq50OS/mT/YVt8MRRpWyrxrXouagVbBpW8MN7XdspJQwBM+edc1JRpE
6bmvAIRtZI98j502P6LWFGY5zJAVVOMg+Tdc/09bO03DJG0AxZPBqyTRiG6cf6d3
emky0SfOwJoMW123cHCf1A7109HuYku1h/iP46uOptFx/T89nhb3bCPv5e9BKFzy
cVdj6yxZAyGtrk8nKr+tLLPbMUs5rXs4prsGSTKn1m6W0nJbFI2eekz4VzJ2iRmO
dyF1uCT0xgIT0dqVZcpoMXoJM1bRX3OjswYPeF3NIpqV/shHD3WpYJEm6/sa8Uat
S1IrXGCSx8LJSdKvvsZw1RRhO7yQ+Lqj7WzJnHmyJp+dZOitn8Wg2OSLiZ6XsIPq
d+oxfcz1KDn+gBCVLIoTH5ohM0WLvfatTyasnk9nolJ3ez/NcFjl+aafN6LuEo6L
0D/By6y9EzELyr4lk+9AYnDr4j3PT47pIkn41EdnvBa8/rgOSZH6mSJ9waNLjR6X
HJFhhYdllXiabiG5Wg3LWZe841wLLJHRG+UeUddqUmfziKDNjXVAJw5AYGoHI7Hj
eHNqhL0uFE8uzjlHiI6XOmFtrHm5CwN88C4WLuTg2iTAGHQTCIv1Y4iZjyth3yEl
h8LVSCZzGKaLT0sNkzg6+H5ncGSVHsRf6681eQF+awB7lIYqXo2jazYvB65IwI3s
00ilPMatN1X4OKqvdRac/s1uhV0L+XbeYE0ZmXa6MZctDZN6Ma1PEUec4xB8GXUp
6+Fc5MpCZ3wYztVRNWJ9AbQ+Mi9MzxdMa2l1N/eTcjaf/qrJ6S7g+N1PSdTzY1Wx
sQV6NnckWezETURCAAtPgBCFRt8Q15bmovwu/TeozKvIzqxxVhOO/ZHdNmXnzKMJ
Q7OpH+MzIvoTivPuh9dWeFsK58KnckZiscmDJkm4/Hllevyk0FUbnXTXez0VppGE
4/KxkLLe4qoy8meiqBvgkHVO2BrFMiqmoemJRVzh4q8mTyPOstXy+QaxZHk7/b22
D1gDBQA4+NIv63yhcFesrz29R4lwMo9VFRwlRzF07s/ycy/3mnMrBOIIPQLbFn1d
EKuD+oi7N6ND3Y/a6h2QrodVYp0zET+xvshK4Mdevq2/xk5+HGpZFPOlegxRkpXl
GW8evEpNLtHUEvAl6QOB8N7+mputoJugYGX39PSLz2oSrP0/ST3dT8D2ysuCfJcz
f7ybIQkWEqVMuFGAAwd9OzTuHRNurweATJ7Duo3JnD8jMd2PPLQh6eILE+6xTbb+
5mH7EIp9mTaXq+7Iu1IUi/hsjtlmUzOhKfYIKncEX2GEVMV4CRw1lNDBLqgklglK
mEVjteZgaR/sd9RB9Q/Gms+me2aHlJiWpWZ/eMHn2dGXFJs2Wu9GxBzUdCqsNUvt
30L1i2yn0pZS4QWsn/3hMMbogUhM75i7HmaSDyWD0bP9/TSPSykcxVtKMMAiRK5L
ylEDAjZQYy7FeXerrpkFq6y8EDHkDeAPYcR84icvRAKVrv3ZxRVdtp+AzSg9CXt9
qP4WaWRS/aIynzzIBi8vACIYfJVxjLVJ7kCJmlwmHm0b0RfgFX/FVwtwQ5kklBmW
JO3WrwPsyL+cuaiKhfy6w38s3/f0MWvB+VIxTkXWyLHvncCES3dbzpm3Gu+HoZSS
DXhZegXyzi57zlemVrQckQqnfuU+DFND9KXyZXg9SgNhjryuCFJiifpBruZjJHGJ
zCxf6o4Hk4xB+dlpBLYTe9hQE5LFm+eweaUGc99yUmkGrQ719ro2woTQ+EnnQ7Zo
ZfJgQbR4k9QHJlO4+JpJ0azzTanEfW4aHD5i6mPuZvbUSn3P22SsOZ+snukfn8Oz
FpBqYEDFlW1o8ENkER23S6Dh/zjzW1BM120v8k/B8GsbKo1tqSODkdb+aXSaDEHW
n+6rtFWtFATUWYOk/WkAJqgnWHULZzoRyDhkGGHCMjzvAKQT8zmUkKSoba4FhbOa
Py673Dh7MTR7k+djndVvXR5cKBx5ne8nMvVxeUCtVWsYg5Kwt0gd8DKaloYon5Xk
ZCQWfD1gZs62WYW7Lx9uK0Gg2gbsbHhrESbubYUs9jnUQ36MSps/sCYL61qowXaH
3YKiV7GvPYwNXI4BVN5Dc3P7rGHhmhbGUktd6qFeR+btskQ2XgrUDI4Zr68w/mOE
N0RYXiSGtjnCKS9gy22wbxdyy3g7drHbODoZbd9lmjMd0xMzYDXy/0TZWx2FV8io
LRrzYKXZ+3/ng62W7AAv1Cx1BF3a5GvSnQ0CzzXiV6tX9BWekD42LCv9e35YFo9n
EEpuAeaL1EcxUOBVnrGTbZuWO/Jl0eF6xF1E9Xw35/HygsP4kPu69c4Hl+m8tyXS
XHTnNtrUf541TXXfG5nCFeolHyoXRrPBhN6pkvhGsFlJJuOHEkW76C8rUHpVSfGM
EWNJ3CvLqgOs080628TsNDClqJ5Qlzf35NpqyI0FHPi2PGlBz2QIfwz/Wgr+iz9r
xXdomiun0VnIc8AInkUV9tEnvWI6qngV7x4Rcrn80JW05hQRKHEMMV7pNQtIWC3a
KcAkeDSNhh7vPsDUleNeHp/YfRK2br66uhJ47+tldvxKeQtZ8LYx2Ok311AaNrcc
49/Nf1irXW60/29oeC/6zXW3JI1cIiEonlvaxhX3j2AynaFoxcabt8gHz8fJvJdy
S6zyGL6a6MrYNJ+ttZLUd5o5IgIoZlDstbGJG6jh4lzg3FwIqJoDfGI4jhCVBAZU
mq/CgmgnK/EBY60UtduN2XSOSugjtd0DLI1v3oLZAFs5+V/wNT/XxZlQEz3PjTwQ
XYJ3+2erL+vO1FCYiJRzyQkRHbAFOcZEq3BSdE6V2N3Q39h7E6/Pgm3GiHfKAwyS
FOAGLs2K9fAR4m4vIySpJ9/C3hFXczX+qazbSAYV8vEryEVy1bmjm8+6V2pu+SRz
65Y9u5qJy3kdboINe7MKV+rOtA2Uub1/RtNteevmuMJ3BfSyfu8DgB3mHSo55RLH
oS97t72TQJW5hYjbr9awW594IN9Ws+m7L2RizZ+ze8nQG8pNG7qRuf6+3rXy/Cdg
M85GnODCAmFXmriMlUupnee/M1KShnx/gHNrRIuadz4PIp7/OpiORvZEyiFWWj4o
V2GkoFio5ebsqOVfAY8MmE4mTthJvDK9fX/BgbJJ+3Ny41IrhbB4vX3/n6SjKhvF
YrVj/oTLMr16gWZvPfY5juSsIZfY5+zuXfLBf2xh4AgKyOZgeEsBqNY93h3iKfhw
F+/qanolOVfex4jYaZ0kcV/BQChona7IAo89aMsatRdDketDLYan6wK6VfvN9ifa
BAHnjoiEAoH4Ji5ndD6KUCAC9EIkUBOqlUk5oKbwPANGtki/qNVjiUXo8xYG3jTt
zSWNJ/PW9TJK0jiF6REB9yeKLQtu3iTh4ujTJRTRs8ysfowosB3GRpZa8VkRir1Q
TUoxIrAxlC3LUYYqJYB+/pPUOHrVBx1PHn2SDOW2c00jEOpFY9LQdyVze7Gdirm2
BKmoBB5cd1a2Ljn7y3VdCedEIcdMynh3aHehADavFMjYL/OatS36JSkNddV1yEQu
BR+1d5nFSszOrlOpep/sT1bqZG42MZ9jvVgqKP4T6txMuzl8oxoYr8jKwne5aing
1k8OkVdsA8updeZV0M1z89Q1hY3zb+EcPJGKpEc+LXL07i3znNlf8pp2GjUKVrRL
ZE2hCzyPzr9TDhbbANj9UGq6QeEkm098jnDbBjnsJKI3KTk8swutswc9I+hYOO/L
RvFA6h2JKdM/yuYE74Zv8x1qu+ZWvOUQIe7X/9PH6oLM+EhClHMisJsS0at+5XJX
xwe1rtGpC+b/TF4Rk5tzCzcPvtkEYeoT3hv3L//MnEK0AGzxQ4g0/Ikrz6WLpNvF
rKJPUiN9PakJf8Jz5Vqu6WLDq6FvdB1A1lWEHL7P4wwP+AOudi/63pKU4b5HFQ/T
N9GduRx+g/T3bLIGUU7nT2SzSdlUPGfg8+ppXxgGaRFFiUJMfLfeO8D289VpYbn0
RKrSfnxB68DK8JeJKKqLTG4hdPiGFBFg6cqLgV+pwfh5D4T8UMMxFy0UQHMxklkO
V4YNiQ+mmGFtRsuk4MbhzWuIv9S7rKtEeL06CZh/dR7fyOOjxKwKn0z5gQE+QVf7
s4+TNbs4afanKKTY3yzk4F8Uef5GQSwVin1jE4Dxen4Ab/NZMpZgeeINJpp1Ki9L
YRo3uZmJs/44vkWBCW5ISq4JyTIn/RX7OEeOhNLAMX4SFwV+peb5m1uV9S5smRvC
44uRLdabZwdLrnM+gG38pnmTy7xoTEJRYbD/kfLvsXHEHzL1YV2pq1QA/4nNBYpn
Z8suFMLmlejg3XRqACzVRq3THshS4NBMFwXxMiCa+hfIry2/4++s45djz+ji+v22
ppD5QW8L0C5Je/SPTIVjkezMMhDdR9+jOO2XTwqs7unkUGt7Gv8xQf3CLsWoLG2h
530wI6drnt/L4uS7fqwRb/2GBcIkyE4ZM/qgHbvlJ2mtXuOlULeivr83mERtqv+n
T0Fi0pvL6dlF+vhT901q6nkGHYQoGWPIwHp9K/N5eOdRbKg5V8gPsUWlTvHoryFx
CwaC3WNmh/bMTzEuQIIjhZtLZsaCTeooPq0C49yvsnrFuATcfg0kvx7mS5W2grly
LRb9YV+A758p2mzNt/1Qwde3WxcQDUmVMW3+pnBevfd4QXFF3WHpyrBYxrZeCaWL
mTu1kFsEFR4MEPjS+9BsGZQF1xj+KfcDxWXSBIbTm1NWpbM36wT54jpCcwp77tb/
JaZHLGqW+82oadTieaXkLzTQZrcpewoPfVfunecc+cUNaAywz6hLFp3UQeQmp8/b
KU8QWzZTR34mGLwvguy5UJCDPVBU3UtmzDAxeG6viBJPibKrsJnSCfm1iFMohdit
KYbvMzseEfSsjfK+iOm9Ua2drW+LSkAs9nYFQu8KGguY7Q5esMIjCHh5Ytr5ayPB
LUnxpUkUXjj7M8Tcp0gSbNIl66LBvE0Y1FJwabZ5tJOyXVJQcByI7OejpvNeIzZU
GLCaATzLNMNKEgDQ9qb4Hkf5IxxyQms5oDme3dOe9bCzc7ba+4NomGl527G1S/AU
/td2gxFNwl8CcXlbUo/TVN5KKbEsy1+5GMBxSH2c/Bpv8ak/QpUxUTSMTpXx03Nb
I6Ilu7hsP+J9ELkj5UhIP5AuNzOh53CJmdh150j4753yaWihCjjetOVrIH2pIp05
EE3GZunPCtqDRMT/414OVyie3kN2gBRFMy2BTStci/btUSkGYAXqQw2w/x9qqVsi
HMYggNr7N8rFwOuCRa2ZObQOJPCuOZsge7Ofcg9/y+shlGTXaeuJdSDxU+40WX1G
/dk6c6i9EE4Fc5rfldMZsQPFCpzrkFEqO0vV46LwtM8JQ7vznFecAOnMCOlZL+iD
b/BrrM9EjziG2ax5dCmgS6WxqovQoLG1mVtnXUh+aaDd3IUqgCyPHXSKfjdYi+Cg
RkYHAut9vDyWF5TTcAppAlLfcZqvaOfTqGnE2dxQCd5NCKT7R+S+YLDA4Qe9hki4
qTHAhlGm3uMs10/cMh7fxsH5TM05QG196lt37XBg1hAj6XLgVcVtPqd7Q5dyg55E
SHDofcu/hMW2JM3ou73Tnr0Ma3Z0m1tvSI0Ngpp8ze33w0MtDmve8TB7xJwKdKCe
cRusWtQx6aouVoUjzJl+hpRBReUjMX5wGsL36NSYB7/AZfZmQoBkbgKPwpMx8vH/
2KYyyv0bJN/buAG/3pEkJw==
`pragma protect end_protected
`endif // GUARD_SVT_SPI_FLASH_MEM_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DUkcVObR1GHv/wy4P1oZc8vBWP1Ct0kSfIPqSMdPp9IWWD6t7uqWnJJF1PiPI3MH
hSyPwkJ6UbI01xvLK1/w56fRboCNu4L2N85nUSGKeeBCadY9DzTfvjbxwXGuP7qq
5f45t9+U85A8hj43pg8jIOufIaZ5V8cs0mg68nSKrSo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5438      )
5zlw3x3r8tq4ICyYm+PKQ6s9gAw2YJ1ECYSdn70eAjCDROD1iPCRy4CQXPSGmJid
eg49ehf5pTfjRp1Zu3eF5IaQkuSeCMMUTtCrKUqdHh4t5awy/yf4K0S8t1fNqbBY
`pragma protect end_protected
