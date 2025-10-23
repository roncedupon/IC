//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_WORD_SV
`define GUARD_SVT_MEM_WORD_SV

// ======================================================================
/**
 * This class is used to represent a single word of data stored in memory.
 * It is intended to be used to create a sparse array of stored memory data,
 * with each element of the array representing a full data word in memory.
 * The object is initilized with, and stores the information about
 * the location (address space, and byte address) of the location
 * represented. It supports read and write (with byte enables)
 * operations, as well as lock/unlock operations.
 */
class svt_mem_word;

  /** Identifies the address space in which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace;

  /** Identifies the byte-level address at which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_WIDTH - 1:0] addr;

  /** The data word stored in this memory location. */
  local bit [`SVT_MEM_MAX_DATA_WIDTH - 1:0] data;

  /** When '1', indicates that this word is not writeable. */
  local bit locked = 0;

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class. This does not initialize
   * any data within this class. It simply constructs the data word object,
   * thereby preparing it for read/write operations.
   * 
   * @param addrspace Identifies the address space within which this data word
   * resides.
   * 
   * @param addr Identifies the byte address (within the address space) at which
   * this data word resides.
   * 
   * @param init_data (Optional) Sets the stored data to a default initial value.
   */
  extern function new(bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr,
                      bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] init_data = 'bx);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored by this object.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int),
   * locks this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked
   * state of this memory location is not changed.
   */
  extern virtual function bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] read(int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data word to be stored. If the memory location is currently
   * locked, the attempted write will not change the stored data, and the
   * function will return 0.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data word corresponding to
   * that bit position.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int), locks
   * this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked state
   * of this memory location is not changed.
   * 
   * @return 1 if the write was successful, or 0 if it was not successful (because
   * the memory location was locked).
   */
  extern virtual function bit write(bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
                                    bit [`SVT_MEM_MAX_DATA_WIDTH/8-1:0] byteen = ~0,
                                    int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Returns the locked/unlocked state of this memory location.
   * 
   * @return 1 if this memorly location is currently locked, or 0 if it is not.
   */
  extern virtual function bit is_locked();

  // --------------------------------------------------------------------
  /**
   * Returns the byte-level address of this memory location.
   * 
   * @return The byte-level address of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] get_addr();

  // --------------------------------------------------------------------
  /**
   * Returns the address space of this memory location.
   * 
   * @return The address space of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] get_addrspace();

  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this memory word object to a string which reports the
   * Address Space, Address, Locked/Unlocked Status, and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_word_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this memory location without the key prefixed (used
   * by the UVM print routine).
   */
  extern function string get_word_value_str(string prefix = "");

// =============================================================================
endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
W+LvkiNz6VOYhC0nZsM9p9vUowIPboCqULFEPsAZp+Ebch0NqINAi8ocdu7s34S5
S1T2CP1Y94Ls0FRKqI3x4wBz2ougEAXdAdDRPjTspToErVWZTRhKZ4GitQ6R2N4r
rQHXQ9I4dT01IVcgfbHxxGyYvN0L5IuYHLkjdRqMQl3V62NKh9SqGw==
//pragma protect end_key_block
//pragma protect digest_block
1ySYunLhYPI6miD1jL+Eb2+muDI=
//pragma protect end_digest_block
//pragma protect data_block
qCnJkUoCDlU5kQFiCHDsERiODpBB4LaOTVSsz3V6MNKEoKcJIX5nccJtzynREPg7
pQ2qsu6yo366GA+NaER8o8XZJoM/gusk6h2hq2OzzrWhGpeZWL4bjHuMmLaKmQi6
utno84pA/FX8CyOXuV9Ku/t4+e3JjQ+WlimE1IYbVbycgqWAEPpl8cbPC71mQC4G
LDSyVgOqrL+8Qq9j8EAEHmWdD+NkJRnsJR/FO4vqcGxUEKvDq2oj9QpDzpLDh79/
AKwOk4SgeZ/RS6dFwIaaXz0SPSM0Rx5J4g6T2dvMbQtXWrymcDBrzBTCFblXFN6H
F41Xgc/ygk7aVq9IMOLtUI624ynP3hZCCokgvwr28gFZIetaE59A76Vy1NrZBnYv
Nz0PL0CGRec+W2A+8ufYu6M4j30tgu/HX/dovYREZoSDhW+I+PDW2jAFCoSkVoDj
8EJpdhgFlsAo+H+B3BAUvUa654pYKQtVoxxbwUaL3+t64iwjdYrTGDipq+CSYkhm
cERXINEiUDf0m1nTVKG5rn0+kS1hRCQ1vzz/kocohQHJ6ufCLQBOBXgfnqimx/cc
5h5k+MaNocNnD7nTOusMpCLZkgXXUYcenbq0y8qiE1bmW7mC1lVP1SwzZf0D/Eca
3RGnrOSVnC+pk/1EUTJyW/Cot/DXTXKrCMmYlIK5/UdgZ4yR5ypFwAGgBipMRkl6
QZU3WbicpCaAD9D43Y8spIxhw1ndBwEkZROsEZYRY5VuBSb3eLS2cLbvHbNQ37L9
XvjicxyW+NZ0Fs5nZ6/H9Q2JZPD+wjSAIRKSXyqk6AzmXwy+orUgCNnMnFZ2fC+l
7V/NR4BSVmHvjqu4Y6Ip1APX7HWYSNuHdSuB6A+TmUcdm60Re1EDOaesEouXtzej
rudVXYbQdG6IDGSzwRyqNNk/TDI1J/cbEAEvTvFXcoI9KrpUNBYXvRJBwnN0k4Cf
tmaF/lUVRwg7uwgtmq07E8eWev5Y/+cj4MEe2iU2Mef9XGOcnYMpsZ6j/Me4yiBb
g+UXIHPMw45kg9BXnQ7i8zTKBviKtMSP4Rg4Fp6SQBttdoIzIKEY4YefBEb6+xKI
2XxdJmJHTF/n2XBRSoIEZ7DxneZ2qosruO2sQb/Bc7AXnAe3VeQcHjmPuXBXHmBt
IMvRRf543bw2uNQ7r556Cm3vJtkMY08kuj9LTTwbVSDFEvs33Wu0jHY1ssUblV4H
wMtP5lp8hQDEAGmU9bvg/NtdRGAjK2JgcrsgT2LyqCtRzI/+mGScE3GMiY1sQ3Ne
mI7MRLeQrFJuiyEygmHQSNsLu0En1JUUPgexMZuhbUKtO/mfuPNfElQ0CZcIzPdL
p+nAbqMbHd1lAgXoX9goeH1NbEpcik6XLQadMWXxDkdWJ3lm2PG1mp6hyzM4f4uc
QbRuCgwuwIQh7BN9Fwk2e7Fjzyv64EdZwWQmqzFd35jX9AwZ5HYYvKYD1cdOnNrk
WUe9OqvUK7qtieBJTvBkIQanwnY46Mkgnwhz+bHSbWWAI4krpjaG0T5UYAPAkGQE
bMpmSRG8ISFn3CTAlTDdkXwnPePoUdwTrKYbINXbG7/jhwNiqt8JbQbXbRktdDJ2
FRvgciDaRPBF8PTO7P8wkbHcs4y6tAtAF1nBJdFpnZEyNlIhz0YRXzWf8YeKDbfv
dkuXv4pHBfpPIptjnciLCaTV1K6b642HZPXVPSS47traJ1M5C02j2E9Yg+U7pKTE
3opd28JTrY1CjwD0Ufvz2VMO3wkj9mxCKeeQsGFF5z/4WwSO4dqV14GFgs4ngm/7
CjlzE8MUemCG28bVSrDC+igmixv1NnT2EZNOou+FlVakrcln0TH0f6+pztU54TMu
Hn6783TIDxERdRqPpl+Qfo8Knx/wdp7VjHSL1wKgDaIZcADUqS1jIJgJ0lzLWisG
PwdNHOtkuEqzKZGE0NT/Zc6od5lCo6WPGnALVz1S/VgQzJwQREjdLZd7ES/3L4fo
PcPPWKUQpPtonsKemP0RC1FlHTEEJC/IPertyxUhT743fd0Rva/xkaGs3f8sR0vN
cFjrpstiEpgZfOv5ZMoixzIkMo3FcCAfuU8Vek/YNu7iD2teJ4WQqwUlVWy+0ai5
tTbQP8g9Ki/etG4RgDX4qM3NgP9RIkxvhFuL5o5bu+rWpvHqw1Pcqr4XikRnRnPv
bFzUS+TasB8WWs3OBHw7SDumhuVtDDVtzvIczv0Fhd4WxMaoi5dXBmlb+VVctVCn
w/fYDjpkrJNOKrJkdbC1J7ABTk0OLJ8ocF3lv48Pcyn4OeCLAxjRJw4GpcXEo9sX
1fBQ72I4WcM0XW6ur1u5Rjq4bO+eJLMS88RAAOVNF1zFDeS/BadbFsGHx8Er6v18
OctOKejZ56NP+d4SvsbPDDNUy3dzWNQOVy56TcXVzeM7WKurrjvgLiWT1QY98Vht
Xjg1WdrZp4HI6majD+CD2Hrts6Zn17fqL2eUiHN4jUQhkoWoU7p0vGw/uMwTBden
eP6D/hknKhveEsPiw6MOh/dXaTZz1l4yJ4W5nbL29U6hN/oBdEyzRIBGUPPlXLyX
k4DCw+sseVy6Aeih8+HaIRD73Iqqw5/ysgITsMwJ8oS8xjrEJme5VkaGtKS+ytyV
gSRjzeBJHdVNbdnQpCvXbEqv2dCSRmAG6BAkklAWO1PG6Z/3TI/L9kC/vnThk8GX
4HU7WWR14huuA6a6Ltn353ZEBn8D/3e0zGkn/LvSSD9ZOfk0T8a9vo4/wny9JEVF
lg+XQf75VoOnuv+zhcbt3gGhlPZi8zqdMrZ5HWMqxsNpjEvuU8y4f+LevJkqBnD7
YAXtHUa2P/Go9FYvi79wOcCe4kcn00VRewMyiSSa6XEx89ovYSltql551RlsVfB3
tvGn9c1F81R/3fBIu1w+96B6f4iQjWMj3n9KJuaOVI1z/0OY3ebcYYDNCisBcH86
v+hw5knnRaCzVZTq0NpEWZsa0qGloC7NIC3/ktM7apjyb5YO/nHLX3sRdMpeXYb1
cPdtkhwI0RJo+mHVTKISQBBUVIxPELNJg3X9fyNaEUW7aPFzwP5llmlm98JoRCQm
mCyvl+Q9LQhMiSiqE3Ji5Jj+9c7sY2/Y7tRKzXbJUuQcfOwYwjUPSdEssh8V+CY4
w2iEQ0jqXA/ub/22lNGo7+GI9SmdYKVRUp6N7SZb5+eabqBDnsfNL8NwFSB6SgWD
AmygMOZmZhnVZK7cBtd0Sx2uVrqqaR93Jczn4j0b+gMzUTZxnV3Dq49ZLdC2RveB
FGhX/Q8/jCC/aAEz5VvKwi3Dxix1hhj5DS2G1t1C/htXta0JHPufAfIaNKw2Lklk
niXgCrV9ISAoSZJoqYVKwfpcCGRYU3mKThTWCf/sUFtjhINfVtpn4wT5aNkz7GSO
9PswWzVCyiqisoGIfogo3nPlgCABeZ7e7KA7n8qtmBd4mhR9ze5USj+jA8MRBa2S
bja53nDHfOxi7SHrtu+Fn4GCWquUkeRN/CQqppauwUnL10NqvEWApRyKYnFUq+/F
WGHWxZ3mBde3to6N59Dow023LsdoW2T2zW1zMlmsajJ1UWq9fKrfsqhVFQzzDijd
+fnO0zUQC/q3E6qbda76fU86wNQl0Vt1A0tlYFnXSitrYF00ZlmLXxLfqDLgiZqj
25YhoDYteOmnb2APozTXOjDUXNN3M8IQabPcZe0ltIyCkCYfONtjrRJusu2jko+k
LoimMSTRLrFVXSfgtS+hVI0KDNITTCK7UREY+7GBuDscFIvQtH+4wqVbBeR/kyQ9
D8INfICXV9TmeeFxkRm/7l82k8Ldm/8cbdI86KTQYLwvPJbuf/38pgvG09n+BxIt
XlBAt9mOmczehYdEkz6Jtw==
//pragma protect end_data_block
//pragma protect digest_block
b8boW5mTbIdqhuaK5zHMGthIvVw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_WORD_SV
