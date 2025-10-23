//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CONFIG_DB_SV
`define GUARD_SVT_CONFIG_DB_SV

/**
 * Methodology independent configuration database that can be used to share
 * integer values.
 */
class svt_config_int_db#(type T = int);

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_int(scope, variable, value);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      int val;
      if (contxt == null) contxt = ovm_root::get();
      if (scope != "") variable = {scope, ".", variable};
      get = contxt.get_config_int(variable, val);
      if (get) value = T'(val);
`endif
   endfunction
endclass


/**
 * Methodology independent configuration database that can be used to share
 * string values.
 */
class svt_config_string_db;

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            string value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(string)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_string(scope, variable, value);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout string value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(string)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      if (scope != "") variable = {scope, ".", variable};
      return contxt.get_config_string(variable, value);
`endif
   endfunction
endclass


/**
 * Methodology independent configuration database that can be used to share
 * object values.
 */
class svt_config_object_db#(type T = int);

   /** Matches the uvm_config_db 'set' signature, but provides support of OVM as well. */
   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_object(scope, variable, value, 0);
`endif
   endfunction

   /**
    * Alternative to 'set' which can be used to pass an object directly
    * from parent to child and avoid the competition with other similarly
    * named objects stored in other scopes. Used in concert with the
    * 'get_from_parent' method.
    */
   extern static function void set_for_child(`SVT_XVM(component) contxt,
                                             string scope = "",
                                             string variable,
                                             T value);

   /** Matches the uvm_config_db 'get' signature, but provides support of OVM as well. */
   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_OVM_TECHNOLOGY
      ovm_object obj;
`endif
      if (contxt == null) contxt = `SVT_XVM(root)::get();
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (scope != "") variable = {scope, ".", variable};
      if (!contxt.get_config_object(variable, obj, 0)) return 0;
      if (obj == null) return 0;
      if (!$cast(value, obj)) begin
         ovm_object_wrapper wobj = T::get_type();
         // Watch out for objects (e.g., svt_ovm_object_wrapper) that don't support get_type very well...
         if (wobj != null) begin
           contxt.ovm_report_fatal("CFG/OBJ/TYP/BAD",
                                   $sformatf("Object configured for \"%s.%s\" is of type \"%s\" instead of type \"%s\".",
                                             contxt.get_full_name(), variable,
                                             obj.get_type_name(), wobj.get_type_name()));
         end else begin
           // Just go to the object directly to get the type.
           contxt.ovm_report_fatal("CFG/OBJ/TYP/BAD",
                                   $sformatf("Object configured for \"%s.%s\" is of type \"%s\" instead of type \"%s\".",
                                             contxt.get_full_name(), variable,
                                             obj.get_type_name(), $typename(T)));
         end
         return 0;
      end
      return 1;
`endif
   endfunction

   /**
    * Alternative to 'get' which can be used to pass an object directly
    * from parent to child and avoid the competition with other similarly
    * named objects stored in other scopes. Used in concert with the
    * 'set_to_child' method.
    *
    * The 'use_fallback' argument can be used to establish the generic
    * 'get' method as a fallback, in the case where the 'get_from_parent'
    * processing doesn't find the object as expected.
    */
   extern static function bit get_from_parent(`SVT_XVM(component) contxt,
                                              string scope = "",
                                              string variable,
                                              inout T value,
                                              input bit use_fallback = 0);

endclass

//svt_vcs_lic_vip_protect
`protected
?dX^GO<7?>e+W6M6>;QH1[&64,\:Aa?I#7=8)M8/T7K+3)fTa,DF4(<+A:OSeYAU
XNWG2^X#:dI==cW(0>-9CV+A)(<G(Xe\S:/CcG,&0)3f<2Yb9D^(YT[PdRL43I3G
W[<6Ga_)-I;F5A\^LV;,Bc4R-;>?_.C)HF+4-+9GA;RC4<0/URL4,A7#2Qg;/NHD
+YXD14:I+Y^MLEL[KV^R=ab9(e\X?3e-H?;J-6.D8FI10Bf[0BfXc)430Kf[L1LX
f;8AGG43PFTT(=(6<M5..O3X_0WD3#G.#M3Lfc((cFWKBdM3<.1OB2A#_e4/PG9=
Y[5M9Z8/H_9,OH=/W9dX^HNQPf8RD@O+6R^0Zg<79/?U-32Yg(-FPXY#-7?A<ARe
>dC@F)&R.U<#<&_T2B8TgLA9-P(R#Lc=SI^7,d)HRLTccUUAQ>+e<9>c9Ceg-<Me
^=HS_VU7Jcd(QX46B0+16#.QV_a+\?LS@H:CM?O2e_5^_Q)gE7W8^)8PG2b8#:C=
Z1eWY5GONN#JLYP0LW9V:Z:47HIX]DJ+d&/L^(SEUGc,Y&B\CBaP;A,@;&ddee:]
A1)@Y5PZg[GZ+U(P.=G>64DQUe+/;=.9K0O6H8R7Jd4ag+)/8^/BI@Re724H^>E#
(XA>W-FQ_0@K6=\MR^4;J[d0]B0AA8O\[D,N4<YE#P-_N6,-@:=^KQ(8L2Y,(9FA
9,f:7GdO(.O4O],(P=IDA#)Z_K-J7PGbA#a5>,P+KL-bL1g6Pcg\8G15SBB0UBP,
MUJ/gd.W>B@M/,D84C/EU3WQXc?UaLYJ0,>[P[\3b:H05+9fe4>B&DQf9YNQPYDR
:G2B6M+BV@K4G0\4.G7d#eefKIRfFT1[^]CB?W>#4=MVW6-T\[:.M6S\d5I&,XOL
B[C8Z-@_,/YTN\,.<B:(.;E+<;Ie_YY2\XB]I?LJ8C;:]^,:E[,>/LI6&^ALE[?A
]_X5gDR02_QVdP]&KD_LEg#@Y-6_=+FF\G8G?L=H1c4M4.JJg^WJ+,6,?V.gE?9?
LZ3XT^#:)d_\?1(AZC_0D&H6LNb=#]L\N\PMG-CaS1[BfD->V)Sb8;&O,75L/Kb6
X=[3VLCGMG:1GP<=:-e5Sa:U]J[Z/ZH+5BAaR[5U,;,\He&=fQbU,+&<ZO-53]0G
P8Q?G)7KTK(CD8PaTZ-+\X>ZUO--gH@(9P.0-V1;_-DF>R0aM>Y,<,R5/7e\C1+V
?B+=)E>WDd:X(XKQ68\MK,+6AFA.bX;OL6\VE0,])MT^WN@FZ#VQ)//Z(gSD4ID_
(\,>DY8M5Rb5\+[HaKMOd(3<Neab=\IRP:/_2WUJN>MD.8A(E=J4W0g9eddV7?L8
Y@[/&^,C^:H9B=5FV2&@bPTDOF?FTc)ZBIM7?-YI3J46N61F+GV0;HIA<XaIDGH_
3G@8NKb9@.^+TO4LO:<9U/<FFVb\GN-ggE).6#F+>W94LMdD^9NZO=Vf8T4<E&25
4ED2AMN9^QKZUD6>.ge#IIJ1)ST0BgOXS>dBYJ]#c:0H:Q<K-]XX9cRE\?c[5]39
1g-6YUS](-&UCR@&G0G+BJ8/.g<IQCC/.SURXDKGIU9\:FKW.CCcK(6,@;1G=U<-
-NHb=Za@d_:=W4#@_X4R&4.Od/[PgN4\>9/PG,Z>]61;F@Z,8\F),\aK8Z8_Sg2>
J;Z/9=Y/BY9@A;M[7#4ZT0C<\Q3K7fTF?>#=bT;1K/AOV(FTIV6O^<1FWg2)1IT-
;I2c9,KPP+>[#B)]\.+2)bD[@ZPINXS_fBMUG;G3ceD:O>A^aed2[?WB#A.\\KCO
8#e]0^P)SBPL2>[VbR@>89VceJSG&,FL]AWK]9M&AWc4Ea=FNCY7Z#S]^EF5J7SW
/J?]I[6E)eW(X&^]1.PCeIQ1-VB>TWK9@d1e.RUSW_3)P1Z4JWIH:QI2N\&&S3ZU
.g&7feS:\9C0\d1UODcLdMafT>eE@e]P[3[eH;UC]J:#<\C8@F&0,-R6]dJ13N?#
Ye1L?a6@g/]0F3GU<<0WKC=HT\^.W6-]?dBX::e21<I#E$
`endprotected


/**
 * Methodology independent configuration database that can be used to share
 * virtual interface values.
 */
class svt_config_vif_db#(type T = int);

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      svt_ovm_object_wrapper#(T) wobj;
      if (contxt == null) contxt = ovm_root::get();
      wobj = new({contxt.get_full_name(), ".", scope, ".", variable});
      wobj.val = value;
      contxt.set_config_object(scope, variable, wobj, 0);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      svt_ovm_object_wrapper#(T) wobj;
      value = null;
      if (!svt_config_object_db#(svt_ovm_object_wrapper#(T))::get(contxt,
                                                                  scope,
                                                                  variable,
                                                                  wobj))
         return 0;
      if (wobj == null) return 0;
      if (wobj.val == null) return 0;
      value = wobj.val;
      return 1;
`endif
   endfunction
endclass


`endif // GUARD_SVT_CONFIG_DB_SV
