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

`ifndef GUARD_SVT_CALLBACK_SOURCE_SV
`define GUARD_SVT_CALLBACK_SOURCE_SV

`ifndef SVT_VMM_TECHNOLOGY
class svt_callback extends `SVT_XVM(callback);

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new callback instance, passing the appropriate argument
   * values to the `SVT_XVM(callback) parent class.
   *
   * @param name Instance name
   */
  extern function new(string suite_name="", string name = "svt_callback");

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    return "svt_callback";
  endfunction  

  //----------------------------------------------------------------------------
  /**
   * Callback issued by component to allow callbacks to initiate activities.
   * This callback is issued during the start_of_simulation phase.
   *
   * @param component A reference to the component object issuing this callback.
   */
  extern virtual function void startup(`SVT_XVM(component) component);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by component to allow callbacks to finalize activities.
   * This callback is issued during the extract phase.
   *
   * @param component A reference to the component object issuing this callback.
   */
  extern virtual function void extract(`SVT_XVM(component) component);

endclass
`endif

`ifdef SVT_UVM_TECHNOLOGY
typedef svt_callback svt_uvm_callback;
`elsif SVT_OVM_TECHNOLOGY
typedef svt_callback svt_ovm_callback;
`endif

typedef enum {SVT_APPEND, SVT_PREPEND} svt_apprepend;

`ifdef SVT_UVM_TECHNOLOGY
class svt_callbacks#(type T=int, CB=int) extends uvm_callbacks#(T,CB);
endclass
`else
class svt_callbacks#(type T=int, CB=int);

`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log log;
`endif

  static function void add(T obj, CB cb, svt_apprepend ordering=SVT_APPEND);
     
     if (obj == null) begin
`ifdef SVT_OVM_TECHNOLOGY
       `ovm_error("CB/ADD/NULL",
                  "Despite documentation to the contrary, you cannot add a type-wide callback in OVM")
`else
       if (log == null) log = new("svt_callbacks", "global");
       `svt_error("CB/ADD/NULL",
                  "You cannot add a type-wide callback in VMM");
`endif
        return;
     end

`ifdef SVT_OVM_TECHNOLOGY
    begin
      ovm_callbacks#(T,CB) cbs;
      cbs = ovm_callbacks#(T,CB)::`SVT_GET_GLOBAL_CBS();
`ifdef SVT_OVM_2_1_1_3
      cbs.`SVT_ADD_CB(obj, cb, (ordering == SVT_APPEND) ? OVM_APPEND : OVM_PREPEND);
`else
      cbs.`SVT_ADD_CB(obj, cb, ordering == SVT_APPEND);
`endif
    end
`else
    if (ordering == SVT_APPEND) obj.append_callback(cb);
    else obj.prepend_callback(cb);
`endif
  endfunction

  static function void delete(T obj, CB cb);
     
     if (obj == null) begin
`ifdef SVT_OVM_TECHNOLOGY
       `ovm_error("CB/ADD/NULL",
                  "Despite documentation to the contrary, you cannot delete a type-wide callback in OVM")
`else
       if (log == null) log = new("svt_callbacks", "global");
       `svt_error("CB/ADD/NULL",
                  "You cannot delete a type-wide callback in VMM");
`endif
        return;
     end

`ifdef SVT_OVM_TECHNOLOGY
    begin
      ovm_callbacks#(T,CB) cbs;
      cbs = ovm_callbacks#(T,CB)::`SVT_GET_GLOBAL_CBS();
      cbs.`SVT_DELETE_CB(obj, cb);
    end
`else
    obj.unregister_callback(cb);
`endif
  endfunction
endclass
`endif

   
// =============================================================================

//svt_vcs_lic_vip_protect
`protected
\>Z)^]Ia-&X?_+WESPY1gQS?dXd<UNd?1<c<8DUWWgCYfg9T4d#0,(BW+2&H]:S3
<[OL>D1S-ZedV-g):Wd;_F,_U#FWZ:;d&M5e(SK0CBTU8T8dIUE/W-NKVS5eH-1Y
).SV0^6A^He\:#>d;D0[&II-XK@F:F?Q<>6QI#]:[NV-LL(=]LI;a=F=BZ;X&cW]
ECU2+7@K]Z?RCN7EfUI)1>;SU=-Z0eVE<)<#+GW7;:QK<L02FXB&A4<S2_G7M@R)
B5L<gH^]4ZB#4\Z(GTa4C.UZT>C?dL,L<2P&cF,Z>3[((U=[[.b@3PV=DXBJ[\1O
5CcbOTNOGYG,E/1B4Cg#e[FeH^fRJRQL3f0,.cE55^3G?GP&bAF/:gYeXS<c9Z)\
IJ3--Q;+W8XcVM;[&GG=N+:7UN6.>N&Kg\;<3dOX=TSU3Ng<M)5KP&Z\/]^?86BP
QTY_LU?]SbV6JY1V]e<S&7/73BJWB<g5gL&J^LI/N]N5#;333/.J>;/dJS8,D:&]
4f>gG)+OGZC)Zd@0(P7S4c<L>87D2e..F8Y8IT:9MU_VJ,72cG?OAe@<8?VVJgHS
+)aED=gZ>cRa#f5He@/A8Fc,_QLP83\g6g1RIbEW.,&=JB,cgeG/EV_TbAF&-T/>
CM2XbKc1CKM67fe9Yb=B:ZX?4XTL-/?^H=&<?#S-^A-]MSWWJ-NIY>eaO.f&gEL-
,f)[#c5=6A(N8@PP4BNGPO;0^?^[fX18]+W)HY5/1)/)8.2,PNV6,P#KI-W[V5Pd
C#9G=.^TO=4,DY5GCBXZ>gd.(Pd1_+17:],(bffV(>-3:27DFfWeBJ:7@Yc3[2bP
b&KO9O6&6XTI&3B55YBe[DDDS3ZO]M4A_?O,CL-3VPGKYW7g)U<E\QD<QHOPU9T3
;QAOIR6cCZYO_6&7T&EGYGN_eY[X#GXS9$
`endprotected


`endif // GUARD_SVT_CALLBACK_SOURCE_SV
