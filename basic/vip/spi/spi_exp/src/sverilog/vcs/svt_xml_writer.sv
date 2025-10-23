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

`ifndef GUARD_SVT_XML_WRITER_SV
`define GUARD_SVT_XML_WRITER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/** @cond SV_ONLY */
// =============================================================================
/**
 * Class which can be used to open and manage the interaction with an XML file
 * for use with the Protocol Analyzer.
 */
class svt_xml_writer;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  
  typedef enum {
    FSDB = `SVT_WRITER_FORMAT_FSDB,
    FSDB_PERF_ANALYSIS = `SVT_WRITER_FORMAT_FSDB_PERF_ANALYSIS,
    XML  = `SVT_WRITER_FORMAT_XML,
    BOTH = `SVT_WRITER_FORMAT_XML_N_FSDB
  } format_type_enum;

`ifdef SVT_VMM_TECHNOLOGY
  /** Built-in shared log instance that will be used by the XML writer instance. */
  vmm_log log;
`else
  /** Built-in shared reporter instance that will be used by the XML writer instance. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** VIP Writer instance to create FSDB or XML */
  protected svt_vip_writer vip_writer;   

  /** Handle to the file that is being written to. */
  protected int file;

  /** Flag to indicate whether we have executed the 'begin' for the xml. */
  protected bit begin_pa_xml_done = 0;

  /** Flag to indicate whether we have executed the 'begin' for the xml. */
  protected bit end_pa_xml_done = 0;

  /** Additional controls that clients can register and access during generation. */
  protected int client_control[string];

  /** Holds the uid for the current object.
   * Added to support backward compatibility.
   */
  string object_uid;

  /**
   * Register active writer when created, the string value is the 
   * component the writer is associated.
   */
  static svt_xml_writer active_writers[string];

  /**
   * Register active configuration, provides a way to cache cfg handles when the request 
   * to save a cfg occurs before the creation of the writer. The writer creation then accesses 
   * this cache to obtain a handle to the cfg and insure it is written into XML/FSDB.
   */
  static `SVT_DATA_TYPE active_cfgs[string];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_xml_writer class.
   *
   * @param prot_name The protocol associated with the object.  
   * @param inst_name The instance identifier for the object initiating the write.
   * @param version The version for the object, typically the suite version.
   * @param file_ext Optional file extension.  Only required for suites that support
   * PA with multiple sub-protocols.
   * @param suite_name Optional string associated with suite name of the protocol. For
   * suites with multiple sub protocol this value indentifies the suite_name for the
   * protocol. For single suite protocol this field should be empty.
   * For example in case of ddr family of protocol where the protocol name is ddr3_svt
   * the suite_name field value should carry "ddr_svt" and the prot_name filed value
   * should be ddr3_svt.
   * @param format_type Optional file dump format. 'FSDB' (the default) writes out data
   * in FSDB format, 'FSDB_PERF_ANALYSIS' writes out data in FSDB format optimized for
   * Performance Analyzer, 'XML' writes out data in XML format, 'BOTH' writes out data
   * in both XML and FSDB format.
   */
  extern function new(string prot_name, string inst_name, string version = "", string file_ext = "", string suite_name = "", format_type_enum format_type = FSDB);

  // ****************************************************************************
  // Access Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Get a handle to the file that is being written to. */
  extern function int get_file();

  // ---------------------------------------------------------------------------
  /**
   * Registers a client control with the XML writer.
   *
   * @param name The control being registered.
   * @param value The value being registered with the control. Must be >= 0.
   */
  extern function void register_client_control(string name, int value);

  // ---------------------------------------------------------------------------
  /**
   * Retrieves a client control value from the XML writer.
   *
   * @param name The control being retrieved.
   * @return The value associated with the control. If control not found, returns -1.
   */
  extern function int get_client_control(string name);

  // ****************************************************************************
  // Protocol Analyzer Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method opens the file and writes out the XML header.
   *
   * @param prot_name The protocol associated with the object.
   * @param inst_name The instance identifier for the object initiating the write.
   * @param version The version for the object, typically the suite version.
   *
   * @return Indicates success (1) or failure (0) of the request.
   */
  extern virtual function bit begin_pa_xml(string prot_name, string inst_name, string version = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes out the XML trailer and closes the file.
   *
   * @return Indicates success (1) or failure (0) of the request.
   */
  extern virtual function bit end_pa_xml();
 
  // ---------------------------------------------------------------------------
  /**
   * This method writes the XML header to the file.
   *
   * @param block_name The name of the block being opened.
   * @param block_text Text to be inserted as part of the block 'open' statement.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_block_open(string block_name, string block_text = "", string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes the XML trailer to the indicated XML file.
   *
   * @param block_name The name of the block being closed.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_block_close(string block_name, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes the object begin information to the file.
   *
   * @param object_type The object type.
   * @param object_uid The unique indentification value required for relationship handling.
   * @param parent_object_uid The parent unique indentification value required for parent child relation.
   * @param channel The channel of object. 
   * @param start_time The start time of the object.
   * @param end_time The end time of the object. Added to support backward compatibility. 
   * @param status The object status.
   * @param time_unit The time unit used during the simulation.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_begin( string object_type, string object_uid, string parent_object_uid, string channel, realtime start_time, realtime end_time, string status, string time_unit = "" );

  // ---------------------------------------------------------------------------
  /**
   * This method writes the object end information to the file.
   *
   * @param object_uid The unique identification value of the object.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_close(string object_uid);

  // ---------------------------------------------------------------------------
  /**
   * This method writes child references to the file.
   *
   * @param object_uid The current object uid.
   * @param child_object_uid Child object uid.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_child_reference(string object_uid, string child_object_uid);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a one field record out to the indicated XML file.
   *
   * @param record_name The name given to the record.
   * @param field_name The name of the one field in the record.
   * @param field_value The value of the one field of the record.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_one_field_record(string record_name, string field_name, string field_value, string prefix);

  // ---------------------------------------------------------------------------
  /**
   * This method calls the 'svt_vip_writer' API to add the interface path into FSDB.
   *
   * @param if_paths String array contains all the interface path.
   *
   */
  extern function void add_if_paths(string if_paths[]);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a name/value pair to the indicated XML file.
   * This method is added to set the filed name and field value to the
   * current object to be written to XML. This method is used only for backward
   * compatibility where some clients directly called the field value writing.
   * This methods needs to be removed once all the clients moved to new writer methods.
   *
   * @param name Name to be saved for the property.
   * @param value Value to be saved for the property.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_name_value(string name, string value, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes field name/value pair to XML/FSDB, the value will always be in bit vector
   * converted to right data type and written out to XML/FSDB accordingly.
   *
   * @param object_uid The unique identification of the object.
   * @param name The name of the field to be written out.
   * @param value The value to be written out.
   * @param expected_value The expected value of the field
   * @param typ The data type of the field value
   * @param is_expected The bit indicates expected value is present or not
   * @param bit_width Width of the field, in bits. Only applicable to fields with
   *        typ svt_pattern_data::BITVEC. 0 indicates "not set".
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_field_name_value(string object_uid, string name, bit [1023:0] value, bit [1023:0] expected_value, input svt_pattern_data::type_enum typ, bit is_expected=0, int unsigned bit_width = 0);

  // ---------------------------------------------------------------------------
  /**
   * This method writes field name and an a string representation of associated value to the indicated XML/FSDB file.
   *
   * @param object_uid Unique id of the object for which the name value to be written.
   * @param name Name of the filed.
   * @param arr_val The filed value.
   * @param arr_exp_val The expected value of the field.
   * @param is_expected The bit indicates expected value present or not.
   * @param prefix The prefix to be written in the begining
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_field_name_string_value(string object_uid, string name, string arr_val, string arr_exp_val, bit is_expected=0, string prefix);

  // --------------------------------------------------------------------------------
  /**
   * This method is added to retrieve the uid from the PA XML header string.
   * This should be used only for backward compatibility and not to be used by any 
   * new VIPs adding PA support or any update made by the existing VIPs.
   *
   * @param object_block_desc PA XML header block.
   *
   * @return The string which is unique ID of the object.
   */  
  extern local function string get_uid_from_object_block_desc(string object_block_desc);

  // ---------------------------------------------------------------------------
  /**
   * This method writes object begin block to XML file.
   * This method is added only to support backward compatibility for existing
   * VIPs, shouldn't be used by any new VIPs tor existing VIPs updatingPA XML support.
   *
   * @param object_uid Unique id of the object for which the name value to be written.
   * @param object_block_desc String holds the PA object begin XML data.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_begin_block(string object_uid, string object_block_desc);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a comment to the indicated XML file.
   * This method is deprecated shouldn't be used in new implementation.
   * Added to support backward compatibiltiy.
   *
   * @param comment Comment to be saved to the file.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_comment(string comment, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the #begin_pa_xml_done value.
   *
   * @return Indicates current #begin_pa_xml_done value.
   */
  extern function bit get_begin_pa_xml_done();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the #end_pa_xml_done value.
   *
   * @return Indicates current #end_pa_xml_done value.
   */
  extern function bit get_end_pa_xml_done();

  // ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the predecessor object 
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the predecessor data 
   * to indicated XML/FSDB. 
   *
   * @param object_uid
   *          The uid of the object whose predecessor object is to be specified.
   * @param predecessor_object_uid
   *          The uid of the predecessor object.
   * @param predecessor_writer
   *          The "svt_xml_writer" instance with which the predecessor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_predecessor( string object_uid,
                                                      string predecessor_object_uid, 
                                                      svt_xml_writer predecessor_writer = null );


  // ----------------------------------------------------------------------------
  /** 
   * This is a wrapper API provided for clients to capture the successor object 
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the successor data 
   * to indicated XML/FSDB. 
   *
   * @param object_uid
   *          The uid of the object to which a successor object is to be added.
   * @param successor_object_uid
   *          The uid of the successor object.
   * @param successor_writer
   *          The "svt_xml_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successor( string object_uid,
                                                    string successor_object_uid,
                                                    svt_xml_writer successor_writer = null );

  // ----------------------------------------------------------------------------
  /** 
   * This is a wrapper API provided for clients to capture the set of successor object's
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the set of successor data 
   * to indicated XML/FSDB.
   * @param object_uid
   *          The uid of the object to which a successor objects are to be added.
   * @param successor_object_uids
   *          The uids of the successor objects.
   * @param successor_writer
   *          The "svt_xml_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successors( string object_uid,
                                                     string successor_object_uids[], 
                                                     svt_xml_writer successor_writer = null );

 // ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the custom object 
   * relation inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the identical relation 
   * into indicated FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose custom relation object is to be specified.
   * @param target_object_uid
   *          The uid of the custom relation object.
   * @param relation_type
   *          The custom relation type which needs to associated, eg: if the two transactions
   *          are identical then the relation type value should 'identical'.
   * @param target_writer
   *          The "svt_xml_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_custom_relation( string source_object_uid,
                                                      string target_object_uid,
                                                      string relation_type, 
                                                      svt_xml_writer target_writer = null );

// ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the custom object 
   * relation inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the identical relation 
   * into indicated FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose custom relation object is to be specified.
   * @param target_object_uids
   *          Set of uids of the custom relation objects.
   * @param relation_type
   *          The custom relation type which needs to associated, eg: if the two transactions
   *          are identical then the relation type value should 'identical'.
   * @param target_writer
   *          The "svt_xml_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_custom_relations( string source_object_uid,
                                                       string target_object_uids[],
                                                       string relation_type, 
                                                       svt_xml_writer target_writer = null );


  // ----------------------------------------------------------------------------
  /** 
   * Retrive 'writer' instance for the given full hierarchical name. If the writer not found for
   * given full hierarchical name try if any 'writer' associated for 'parent hierarchical name', 
   * if found retrive writer and register 'parent' writer to given full hierarchical name 
   * to enahance performance for subsequent retrivals.
   *
   * @param inst_name
   *          The full hierarchical name for the required 'writer'.
   * @return The associated writer, if writer not found returns null.
   */
  extern function svt_xml_writer get_active_writer( string inst_name );

  // ----------------------------------------------------------------------------
  /**
   * Method used to get the format type of the writer.
   *
   * @return The format type associated with the writer.
   */ 
  extern function format_type_enum get_format_type();
  
  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a scope attribute.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @param scope_name The name of the stream for which the attribute needs to be added.
   *                    If the stream name is empty then the scope attribute will be added to the 
   *                    'parent' scope. The defalut stream name will be empty.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_scope_attribute(string attr_name, string attr_value, string scope_name = "");

  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a stream attribute.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_stream_attribute(string attr_name, string attr_value);

endclass
/** @endcond */

// =============================================================================

`protected
Xa-[ac=f03=a00@C(>]QaDK4L]TfD-074aJL?ag0YU^GP,CfcNd72)210<GeOddH
6BP=5>cZ5c/[T,MXSQaFdWa1@P\\/Q);+b/?QNb?Z<]@BRg_BPE#42#G[P/gBab=
U=Z4+8QE9Z_YIaB2f86Q4Z](0.E7L[N[SYMN)CM3bN@6YW_ZcO@aN\-9IK6&:(EB
CHAX81(ZWU6:K1IYFQJB2_P>+R]4^)DYRA+3B54[81Q4VeD/4:MY)VXK>@<R,fG+
QW@H3WT^7N<eL[N][,M_ST32PY=Cg/K.2J=KJ09A.gSe(LE28CE7.4TV(IZR4FV+
JYM6OT2U];Q_X#1,I^CX1@]@TXYG9f?S/<RJ[dN]5B&DLP#EdCc3U6;?(NRJ)ZW/
;K+[K-(Kd?.4AC2_d<K)HOAgO^@1J:Lf/7-C[SXW?8gI?+ed@RXD&/XV9@XVHOU6
S=;]0#P>6-Q]NeBIM5=L1374We.GDI0-/#&9A1-QCUggGR.6c#-7P)PJBZYXD=/a
Fe_NFQ/-PbbM[LId)ad6aZXV9H/@^V@Q+T0EKR:U8=[[0VDbU8T>R>eIEV#E]7f7
[V02_2^KdVbH=cfe+&&C0PRXRN,@\<8>QXSKX7PD2C3.]0\WUV,=3/cEfgbT7JMX
-4/8VJ&D8U6DYD=MGMQLD6E4IB@beDJZM^V-?76bagVAE^TdFF)O\8(,/R>>9+d;
)E&Z[QL4WbWT.LXSXd40McUZ?8#-LSJ3]#^U#\)HRgc+21edG#V-b+Oa]d@Xb-;<
TJ4EN6Y:>,b>b<Z>74(566EgD3,#PfSK[?V_dJ8<TBDc(C>fK/D#0I-R?C:0C@/W
N7NYK&X6^:)[UU6(.<(C+EFL6MZ/aHU+,eKd\4VISGB:>C5DbLdNX6L?:,@-SJ):
54&-e[4-@Dg-bc=V&XV7GL5Y@NePK/WA:EK0X7?]ac]CC4MHA.b1=R:BW<HF>F[T
9He[g=E8gXL74L??[/:>[3dL,\M-Kb2ECD,FdD+CN3#<0WA=ZEWe4>E>=U(Xc&/_
8?3<\/3VUGdROWAcHBSAORYI&ALV7VMFGE&2dUTZe)H3,W@5,U;P?7=JR>++M35/
5LfT15O)#T\1C/0]U9eYY6JQ18S79)7ReY.O]5c@B.\#,K,ZWJ[4>QWfC#8RaYK?
CUB<J57N#WR(cbX2RAM\QW02@L\Zf)b3W0eOb=449_Z;\bM73[fZZfGKcXfTADJX
J^Fa/aYU65/##6e+\O;.eOLYR>K9DBb(OH0;SgbD28,4c[@FG\H^:=TUIX2^-_(H
Z\9Z;Z?54@5SU<eU<d(AN:PS_(SV#XR.;T9dKX<e3QVVd/<NEYN7HW:5gH\YMNa+
Q#_MSZYIa^[8QHA7f()&4MZ6)8b:6M[60UK(d54W#?4.HIS:2,9Ve5@FP)GO@ff^
E4SS#c2S+7IH.9KMZ&.X=22)Fb_]58FLA8]1,b;^AKOI_ZD1LHf]I+0S)(GfBI]W
9W8cM-YF96&QGPWUJIC@#SdTW.Nf-UFL7-4)_,cf+dN=f#;P@H43TF\Ug6\^1)e+
S[1T<#0&23S0(E=5I=eaS7V:#fJ6[ZQP?aKVHB@8KcV9.5#?QaCH>WY:AE]XHGY5
#\/gWNe+J:f\N]F?T?R8e)]d8>)S3XFQF-KW1N?:L&5]2Z9_9P>b5?JK?K(SQ^?O
d@-;>+L/a^2ec&8Q_Mb6=f90)S[ZNMK=Vb[[-Q-#^S#E4ef]FWRGf<.?Y2]^XGH]
F+#NHMd3+4ZcBb03;GG#GIa</X@F;[a;,(^BF1(e]07+3X8XQ_^:g0WIT,YCD<UA
XYWKN7Z-;-P[;NI&J9]ES+-N4ECX4;=J_@>#T#S^?=I>d896&JF;DI3&=MRU^N?:
1cLJ(^GO1:eXL^,?5QV.06.\W(gY..4XU);P)TF<g6W3-ZC,.F=HO-\Ze;/@RDA&
,?<68\g-XR8HH,-:VB=gUF;9?YT)V?T_54\I1L#P).+^I8R5(8)26[@9aZNXV3X2
2>S,?[c)GRAH8?[M1d@XC0?a9MD=?[c+\UGb?Wc\9R/4dQL,[G;Ge?gNDba<\_17
g>8fDSc+2gQ2Jc>&fLU+X1FE38))7?GUX;O3]>,&BG02_HSE]ADbA7e;(<.P/<)4
cg2;L6YV1a)D&aG3#ZUX+beKX(+.Da(6[XQZ_^P;7XA:b&FV.[EMXJE#gN//cX>S
?P4[LVdS=I[E1/A.&7f+e2<7CDg&fIT<8S]NgWZ_P.^X?4gf9(U3;.E8b+/\PB))
QK/P2;VNOYGSE(<;f37JP](6f<8O?M<^UPg?H#e8E9C85#DX;22RIXD,JdQ(QV-&
cc^RgJN:FDg5SQ[1fcKQ7NZ3YS:&N<.,?^0#>G:-\UGCQN)6d4;=1e,R_PY7(X<.
7[ODdLa\GPV#OV<NTSMQ6PG?]Q:W2.A\()bTc)<QRUA=ZGGJGR]SZ],_\:4bRL_c
]eT\=\6AGf)Xg6)#HB<0J_@>gB]0?17YL2d_:)WbgSb3Ge)e;C2JZE_7FWOK_U9O
OWY(3W/5L&2cS4X>OT,P<OfRagV5A_\(Z_O&>1cVMd0,g79[;Hc@N<feOdfZCN@_
[#0BIDEa9CHQ@Q)79)YYFJ-S;+(Q)CJEa0gE@c=0a[b.OMM^a1:IM.1\EW[94PNT
^-&]8>P40ZZN_6]U/GZ5^>=<\:^;_e5d0R_Wf:5F-@^62FW1.D8)_9cgEX+>;G2J
.BIJ0G]<I4FXK&NP[MAG+-;#++Y=V5gEBU6f:Y@[3RNKJRW37aY^GN(H+[H9-TOJ
=^\VKC(.ggebG[&_f^cQ@>/N29d]<3;UL/f>:c@FJcb05/AYf89<<EDZ)=YC>4NA
[5Q-GUd4CEa>g?&<P<@Y4UeJc_-F=V/[VADc94]@K9SG9-H<W,8b3S#GX2cXIN#c
,<DJQJ?3(?cH_[Q5&5d)KYS.]XFCaC?_^5[Z;>NVM@B1R_J\O9Ab,AHXAA>8DQMO
;U>BcRLN(+@F,,9.A5Y;923Rc2W#Vb4/M[&5NfBeJb6&DOFRePA6N;379eUAFLZA
H,E0JIS&YLMbZ-[I=AfRT,CdNN(UQGM-Vf-TBHcSRb[+J040MW8[Ge-BTG.DQ-_)
NReY.6S7g1I^5f<2,^@d=dHY>#;(Q15_ICBUWBF,6K99OUB=@W#-?aC;Q?H[VXX+
7/0KT\1/:.3d/Ggb4g)/U50(1d6PRWCL9QQdXZM&;IM^#[_#8)D9g[64KSZ/0eO@
gB=&=)FT(1RRF)(]efWJ,L,L9:8&eS#_)DF?0,78cP<d#[.E>bb8#A>B\SRa#<ag
=I^8BacfTE5H[K==V^Q7F6W4G?A(?4\S<IZHTN;d[E(UM?VT>aTcJ.+Sc#74V?Te
\G+_Q^M\Gg+RZJE)_c8E8cdPH7cgPTWV)]^T->,d8DT/<V1-=/MRL:cAYZ]e[^=L
H\[ZM)V<SMR&(F0V->=^IJcX/FbgOFadCJe>Qg@TAeUCO_N5P<cd;)042H2^aFd;
).YF_6[Y[#K#5WA<#@/-TeG1SZDI4:QMIcMIB>XSWJDPI>5)//=NP9^7e1R_(4H#
V04N=Z]3>E(Ya&Z3_-RFG5?)>GeY]0K.HeB++/eC2Q-X4.NgM&T:01aSIGa-?c)R
YU?HcP0Y9RAXUE^ZM+/@GHHF;@37;?M<:(-8DM9(Kb&1+Qf=bP&N]975CX7#BA20
?W/<MYO3Z=Z5EOPBYZ+D3cC@^F()Mf+a6S-QU3,[X7g5e,?g3bT8-FK=]XKV.Z<2
GKC)FK.\,A;Y/e-6D&RC?1<1I+?G[OZ&Ya)RaHaO\FDBL0)2N3FO7A#d?X)1:J(9
K2(RWC0[),_QOCDdf/\3H+8UG-=.-eQN<C(?8EUbf4@_))VGAaKHOKDIc9aVgY61
b&>FAAMe6.],NfM0f6JcdA6;beV8^HP/fOC5beO_RG;T0X-=8)9_K^.)STfZ&LI5
[)+477;g/R<Z-#-Wc=?U01&<WY:gH_Zg#<:dR#W>Z,2X?L(=7@?ZRR6?(.c7&G3O
^.&E5>XTN[6-g(G4(\/@/S@_-JL]XAOFI]=dMK:?4JE/f_V2-X/O4S<LBb4F2PHX
SS8eNcSIN97P;c6L3CbJ3H7VgWSBg0Od)P.Q[S[bOZ1#]I2Q.VL&?M-,,ceEg/T+
C0BYGc7<,=ceCJ,?]6EB[b&1(@fDZ@gQCg4YXdLIUG6U;;T+HP,Jd9CIC^.f0YJQ
81.&Q]E_>V_V5C@K-#&a#ObZ-f.0=[\IE+(f]K_Vg?4>?\Y<U0ffE:KT?J&E71@F
X,4b_LRR3M=-Y6MJ;9A@BIa5F)F_[:@ffVPILCI0DB#A@Y7E#7]IFKI@)=aUL?R#
R,Hg2)Gf?7SWOU4YNS@/eK>[PJca?PRP[E4#OVfbCGUDDNa[.>Q));H+8WWMSSP>
KA.LSaB1M&;:>7V>S8?a\6Z77[+WGgB]ZX/W-K@,4.\I:1>;DIN3Kf:\K<((8<#/
U;(>ZDc-B1<J(WbaN8(Q#9g6RN37e^>V:ge_Q9F1>\T?FH@dAPcDC5c[2e]/P^Q#
QES+LZg.NACE[J;a(B2CLA^&5G>U0_Q8[RO6:@T>.ZRf#:PU/Y^A_:()8AUD;&[2
5(_4aT68&DPgIH)dHB>H.8eXOK[MBU_?;U;TK?J<NF#N_>\)Wf<_-UG6;R[LQe.b
QPJ<N0JX&J3b95R<_Md4c_K?SDe><,0f[(>G/]Y=a95--?QBR:[Q0bZd,c(IE2]J
H],^APf]F](P6@@U]&Y^J533@E3MU_]),W,PD_K@&e37=(/?N])F<,420.)CS<eU
.M./NfPWb3258Pg39F0gOgX/[UJ1@?GFdG:@4GZVO9gJ1gQMb2/^K_S[J:J8-AcM
+cA.2A55(QS.[#GG->ON]#N&g]HEU58\D8bE4ER)ag+d1P&Uca2c<[[I_4V&^8(:
dF9?1Y8[0d6?B:6EC@2/3\W2e2bMb[V=5Oa:_:gU0.eedZ@=GDRd,-<V&gOUK\)X
aVNAfVDY=b)C6IWHY+@Ydc]AHO?OK7Q[-3/^H\L9<.V_IC-[I\See9(F9;)2M.Mf
=.EdO\M.F:2S\5-)F8?^;(b:@cY1f@60Q2ad5@X5K6;??NYZ7a\OA\2He#62^Ib5
+ad:NFCTVM>E5]<G_Q1C[2W\,M2E4CGNe-N,?/OY,AJDSCFXT<2E-4M81Q[R>RNd
=R<\KA]CgQ4W+1[IW^V7E/2?B<]2J#H9/G7EPAC6K@NYV,:;bW<Gc]+-U>OeA#cO
/d=SW;-G[ae?H6U#2NJ#?]/8f+g>XH7#ceb&GT@LLB9>HO3)6F1gEQQXHbffEV/)
-8U,#;^<4=,4=,GDSX)a5J7D/7Vg<D&JOSHdC@QV@0,T.Y0L<EVO)@]\^KC0(_GA
cF8?W\c]aP(\::]MA.d(3:]4;[KGNR@NB?01<S_E2Kc2WRTc9JUG1eBd/G_YICK^
SAeJfSKP-)5\geZY=:^=GcLf>MXg@IJG+Ea^@5:FNDcdPQgcT,LQ7T+.^1?eHbf-
Ue8=4a4gCXPIe>:bQ^4]JLE^7?9UX<M8K(2V\C<@F8324S36bGbS;^41[<;MUC0d
dFQa&;U@/\Z^YgISX,\B7Z0#+A06\+[PXL&DU:]RK-SgERO.b39M)E=O#f\7=4@a
30DAb-RgV9J+,/:E]G:CHP;ed^^eEe&U(:\I=P0L&;g;.571b,9,afJ>Mc2K;fK1
43:TT7W1<.>?O21=[++,[WA54=R@[/+?56B;&1gQd7-M;Y1g_F<PLS/??[bTM[Qd
R(37Y+fJ>9R.J,T(Yd^V5XLMG0O3S97;Q&&K.C<[^+?9Vf[SG6[@?Ea@V=LTZXUK
/fCQf(Fab.\+QPL46ceeNQC/0\;]O]T&>1LeF1/241PLf5ON22\LI[LH+-aSIPDY
JZ6YD@7PDW_86CcgFRf)&;+)^6LZ8SBF>N9Te^I0<N(F&@CQD1U_=H-E=Kb:VE.C
E;2Afgc2D4<>L#_(6bT4U@V__+fU<-P75+<S1]a;>_5K/<e-@W.g[UfPe\KHJ95]
P-^Q<,SV9D36+4&6)CB+^=0QJC8MULV@d_Ld7:18^J;egW;;(DfWS+Q>T[0CSA_H
&-NT?UCJ(2W@I4dFJ2a;C)N8]FY3OX@NbB<fVL(X4?;)U<AFa/R5W61+RLeC&\>.
Yg;B_:-PLg.1O6>)M0>I5X;52IDC(JA1E<@Y;M/8;P;5Q7WQ4.I5\g>1D&CX5_&S
AX(XNgO]PCTYCUVJN&FeP;DY8]MMK6HgMT)c)EaW=T6Q=BCUSR,J/2^[O:WE.Yg&
5O6=W3DP[5a@V_;PAP3a9&54I8QO^W9IM9NbCX7H/JC(6##JKT\>U]Tb#>?60K4X
0CA5+4&CF#TS@L<K1f.?G&_S?=B=WQ<K\RQb@XAcL4[DcCOHcd^)5A_U6[@QWO\>
cSB&,.(:g/eKD<TDTQ0_>+0O_F1e)0^P0OZ,?;+R8C.71AL4Z)ZV+7PQ4=W;e1@e
&O_5K&f[B(Q?)e+SVKX.->_H+=>Kg7V[I6?LfF(Wa[=3Z=]3K1[,=:.K)5N/)O7Q
_D3Xb3TR,2AU/=PHV05EPdV@27GO90IEU?57U>SY]H_NL^9Pd8B:RPW038)=Vf[0
+e76B32J/V+UCaYE1,=>#P@SAFR55F>?^g#a1+W_<O_A8.e5T>LKNELK_-SB3If2
H_6&:R:#L227:/X/0(^9O#()NMMe2P]J4[7Kd0Y=CB2SRUf]K9W9[UO8dM)RURJ@
&TZCe]DMS5GXQOB]?:AC(>-5IP)I[f]S-TY=&0da(4ZfV7a1F^be;4/2[M#1OJ=,
JM4QGG+Q]O.&9Cg\RcUPG0[8_<fa83Gf0C8KQTIW:eQ[8BX3/,b=GG&-.F7\MNJA
FfL&6TT)BFIPFdb5S:8EQ/GEJ-O(_-G&d-WNf82g[d#cTTMH]B=,gMRO(JERCe,L
=15bU(:L.3^VM)Gb<<9K&M#C6(cYV;M-).0D@f]LgP+M]UHIHA5,2+f+RR41:Z^O
bMEVB]b&47EV:O&]4SS5SJIC#.X/ZO&3E2@PXc>23-I6<^=2Y<9#;7/X,V<-Z0^B
^^@3),>+ZdV^@F513@f.]TYW)9]-O1bGW;ZJeaeC]c_ELVD<7_>6G;6.A@^>&)82
W]^OHRf8W6,0Tf.V9:YJ7gHc/T<dLW-[^a5[F_V8P/,\WRcC/eXf+?+Wd)YWSVK7
:DOR[,USe.Vd>Ub:Q,E7dR2<5Z?1-aN4VS>+15?0WF008DGTAG,0\CZ/O9^Y:5^L
fcX:U#60M5=>gZI3c1F#a-QZb-G)HQN==O@?>+^76D>.P(Le+c55\3eEEP_GJe=f
Ta0f83eVQGIY/Le;]eT<#Da(WB]WWH0]/aDAUVX0[b_<e?[]Y=WeB2KMFKc]OAIS
ET#?,?N07>YPHA)<,)+G57X.XWR-\K^_>+.@J0=g=RJ5XAJdXbCA#bS?#FcR25B1
L8Q:EF4GK-K>E>8ASZIAEM=-@T8WfD4+,=U6g^ZZY(H>]PQEXUgKS3g(JfX<S1gV
K&4JUgCFQV.e]MW\2)0MeWPdcc,.Uc;U_YRJ\9=Z&AUWC=#=g#CQZAU60V^=DcX1
@5S-YM0d?4]ggdZ&0N/_6K7WT3+8#]2JROB+UQ_1WP?K]Y-D@f7+?AG<48F@DQ_8
V>a06-/^(H5F;1YO]OLRP@P-N9(:^X=LHT;^PgF,2(O\U];JI,-1RDT]LT-CK+_9
&bG(0I;Md(J;&#;ebTaS6B<81QF.&g9CERBc/B9NagLDDYXC3F9-Q<H3XY>;>PdS
B<F</DfV&S7;[N<AN7.Ib(E_029/O/AQNQc.e1AA0Z?XAP)?L/#628_Q]^)R44\I
J(A4HU7:ZD.V^W/JG3,.R@f_5Y4N5RP:ITR_@)#=3E=BZ,O#,g75bRUV8E>IQ-aY
OX1d]f7O]>@#ZJ,=9g_fX&T3>Lf&Q,HJX?ZWa3K=5NJR[HR4WKWIP/V?WgS+<5XT
EVYRDPK5,M>?ZQ0#YU5#]5IJ2KAP>DG/6PJH239+ObWBI-XJb5e.]EY68TTXgT3Y
N.e>5Q-6+1F\-3AJ7@/,8T?T:CX68)f8HHL5N9--6)eXJ@)-1aOAP0f[ZI>2^=8I
)F:GAJEV[<U@DbJDE:T/NI,Q;_@2-aQK0gL8Kg2):X3SDMb[)MUI=G20f5Y6#DDa
=GBW1^ZI4,&C/E7bIM9b(^W>QPEXAV6_D2^HY[94)(C40-:L/KH=2g#NSI;QL:86
T5FF5GV][^-37UA)=d0SK=[AOT>&LCe/Mg)6J/BL[gZ<HKf-\2^A/YGA?S9g4Y)W
Xb<e+AAY_aQaRQH;@:L[/(TWeAUF\;KUH_(0WL82Q\G.1(D0A(D:0R-1J#9@+TUG
fWdEg-DBU.1H20d00<IIUXQZg?3A#]CZ5C?03RFRe860a12a/9Y8VC_d13]0#TKM
J9X5H#_b7D[6FD^P+EBRG=>QSDDSHY<AZFb+E+CCF-L@D#U9YWe4J)(,VP9WT?]H
<J@&]:\bfUYaAcf&&CSBAe=;P53Of9R0V-NLDe[O4Dgbfa)c/d<AeVYNT0(aGN=H
5?S;G[&B1c>P[,+;]RTBCQV4HHaNY+3R>3V_R_SX8J=F;E8^dN7FgV1K:]IefG/,
1HP>\MGb\O(TN)/#:/M2T3\/Cg^W9;[Cd_Za^:D(J[C_(AS.7=&<;ZaP)1X?7+9b
O8OG45CV(ON\BNS96SdaRQH.(SJ5RGQ(8S6718CDRHRJA0c(<;#89X]_c:F9d5gB
50&-=<G(.]JA:@_1+&?;fKS@1fHLGRQRP5?1;QG?U(P=1f5;OH6I?Z6<6](>5-O3
B3.NKXg\EY3b5,L6g@N#:=W\_OgEa4CJIQ,KMV>WI#Y4gBGW<,PD^KRAURH,a+Y\
XY:HebB,2eXJ#dMce-LadJ&dM_,-W1&KfHD+0N:),#E;;dZeVFA_29JB^V4I,3A^
MDeXPOJF#O4fZWB]EV5VFUB:;-RP-+IH>YH06.=e7:B@/Vc/^fN,/2e9I:NNGDV+
@f)2aWeg8<R59ZIDMdC?;#]_U-\Df5^N38EecFd7/T3V/62LCFgCM/RUXQPFCac-
GNCX/=bU9[2^4^J((f#>XBb@&SfU+4LX.;M4C]D(LZdRS>/?_aX2IHL5AHJg^TU&
YGG_YbJLOI41J-fbY(MEU(a)fO@;1W/4B1B342B;C[QRaX<KF#1K(D#Q0?R\f]ER
c^IMF&R/SaN,>GP3OSbHHebK0T6I63XD+4Pa^);c+=[9^N?RPEAW^/BXcJ0)PXT=
HKED3b+gC8N?D91dXc\X4O?D/^:Q),3@>#WBS<IE)V#4\<G=fL:_R([]66@Y>4&H
)-dE7f#d?9ac]dOOd\@DBN^GC#K(@;_,(ZW4D]R&7/3@(^.1-b=+?b4\+]9&X6N_
gJO.1M;=.>I4[(VZ4ScS?;=b[aD,Z4LXd?V)+e5[,42(?=c0Pa,659XWf:JY&].D
<M2]Zb,Qa+eQK4=c=E#ZAdKW:Wa4@WW&B_FQ,/GAA[e1CT@>-L)@@KD&1\=UY+BY
1M_MbT2+RY=1>75=_@1.)4=RFODJC@Q_U.5fO9TId9-J3Y].A(3CD>C\O>=Q1.>d
[-0V6T8?5]ZDS,:YI/GCcH8[</6#,#9^XY/cS[J94<QRdLYAAQ19[E#[+4QDgeUC
&IJLBA6eIE<<H<^Z3UKg.>G9(SA4AAf]PI8F5c2AY-Gf7LB1JA#NDT,>9;)11c/=
a<d#+V3N[/EgO62:<La3c=_1DH.7WcgfgBXCf?IgS\#+LTFCIa?6Z(2=X73W8dXD
J(+C=0::XD+\b6S81e9d6e6?L9/G2]0L]J.<C+^Q/OfLUE(N6V>_>D;a?VeWP<Ua
cL3,Ccc/7Z<LYS=JH/,DMPY^S=FGf@=Tga-F)O?O?Y9I-57WD[&T05f-e3RaT[bY
G8J_/-)^O]NdJE[7L.Z-1F)3E5[QP&+)(BFK&FMGYS13e;(X7ageV&W/U_bbSQFW
(XD51GUMN+@24I5VgH^/JNOJcRZH2Kg#;dF9A1#VeIJF]A[.Ya@,V5DG]Q3KMgO7
PR@9&3MP]c/#Mf/b6O,><YH<PcN9@)-aV-?VgGU-_\6()c+1X(TKZ_6Qg=/+2M<G
J>b?^L1^[Z5F1WD/3>_BaGWN]^BN0Ac@:a/JQ+-<&&3L.1#a;4EB/W?I2Q>HH<eC
f3Ea/84EM8d\a-,WXIc/]1E5ISN^g8Y1U=F7.NKBcRH\&Ha3M:J5U+\gfM?V;cFN
Of-WGP9F#WQ#I5ZXI\4Oe\=g@_5I4YLB5#5#<I:;7SVcINAXAe1,c3=GP5XT+6]O
;]fa&5_:T@e?WVK,e&?K^b_PV0]L.FHb=;4eb.\PMCGbS4f1ND?:TbOFfBLK8VE_
3U]ZF/cCU0b@AG=d:[)DX\NA#;2(_TRfU>>&.bWdQ4[<bGHc3aHAYSP^HE5V44?Z
VcB]L8V=.ELWQ^>.EfeMM7SP#g<IOV@V<=DWD#C/ba?P:DD4Rc642UKGC=J\X3X/
g#:Ne)SOV^BDSc-[J5#2TWKVQ-TOPIT5:5_KaK:34:0X[b[148_I@EOCA7E^N[Z,
6AUf/F.;UfNgCc</Og<P9EWaT,I[G+&KW(_KQYJZ7SbaB>2/<_8D;BP3.4aW=cMf
b,]A]_C.[VR6C0Z_g[I[XdX0S>25?WS/(b9)(0&I]Q<ZX2;M?JX=X[YZ]/(dfO5R
)RYLWWL];bcJ:..NR.3A:>(Y8@=\beTb[HTMU:W59bIM#(L[_#]QPHTP)@+PB32d
A:YF&#=C?HT/MW(#aA5/;5e5)(LI(FOWZVA?=F>C+RVRL>gI:Y@-.WEe/U6:B_ea
32J+X]-?NV_WQOWddZ(DJI:fN<F_\\a9O_7D_55RY1>86IZQ/WcIBcf^13L:3[/6
gf+8F3/b>HV6\f65\,,&WFXT<Y/U(6/]3D:,7L[e1FZZDdY@/0Z:XNC2V>f2-42f
&0f\c4.+:?2J_SIB-:WX^ALaCA#H^52cPLD8G;I:Z?Efd(JY(U?_\?eH8XK4BBd>
DZ2CBf=Aa.SHYLAc1]c1;eT?2G?-.F#>E-//(W0;/PUEL/#1#8QJIGeGV9&@C[2R
QD2)UAV3?=G#A37<\G(F6\5dZM[]]NVD1F>4?C;?8Y_Hb](^0JU8Z-+F)R-SCV@e
-;JD]_HOT>VI\Z):AX&4(aV.RB<;b3,c?;B9(&aAHTf#QbWQK65\eQ=-SDNLY.bR
Z_-cO_,V-daQYFWFG562dIZ,>c0PD)gPLY5gFRDMK3=e<g(+24Y=#W#1bfC;Nc/T
160=2<N<#EUO3#WZT146d,-@9f(1NWRY#1)8Z)YbI4X;8:fPYC_=PZMd.._P_8_K
&A?dJ>bN)CbDM--g9aP6-R?+6WNYBKcSV/C^1.OR6MdV#G^JZ_Z7F.3M8D1e)@0d
9#>XKEWI22\[Fb&@9RYXEg5C(De]>;UH1)?a0B2g(dLQ<e8P(RLe:)\=@c1R83@=
I/VN(,,]_/I^Z;FgYQ9N?H/+Gf0K3TV4aBIEc.CA[7QdbBI?YTKbggT,?@Y()EYI
aSTU_Z&dTH^Z(J-<9Xd+I4:a-F&NNQME(.XG1CMa?B;F=#I2f0#)WX\H0fFR^TJH
E_YQZ5[Q<NEJ(G76HOB7.5<d++(N0(M=Q&E=)PEPU?gU8=a&T<)NV77L8g\>>Z0:
0MI]gFBJ_^>a7Y0Z.?A]+(DAU<JHP+&c5g#bNd+Rb26ZUUb(6T\H_(6>-e3(:/fW
?G1/&ZeV8US_#OVe++#]+GFR2IXI-[0<>f)R3bJS249@9b&##WbO\0T?7S=@VINa
)IMD65=9K.G:aX=N&PF-2YX#6I-a^3&EaEQ9\cK.c91UT=9]P(()/B+Nc@UDFO[1
1dD@TaJNg:QH)M^-e60DgEOgP/Q,@=f159Ba_B9RD\)A5.D2GWd5\Z(/I(d4-SHS
I&_gQC(>;c-A^[\6Q#GHUGc@6/V>c6@?4AA:1F@RIS5c=fU))[6L)=YP6+O=EXRP
+D23;SR-^,a#C7A+2XRcT07T5G;A7Q7SOZF/.5P..-.TI?O9,N<Qd#-SBU,R(LFL
^;6)e)=XJ0VbY/#DOg[/\3WNCW+(OC7b12b+4<CF3@c4>WT.[#_+-A06UcbNYN,^
(+F(\OS<;,W7YEcDIG0.Sf,;#-;c]/L^HR+fG)Q6HF;V2V0J=I?+a<gR>,(cE<-P
C5b=XA4O5H6ff<:V&C4@4>/M-d\0Y4(2Sd:5M&UW)W-SY68L@Hg<UO.2bKd[F60_
_eHHK(b:e&S.A?+22V+MC:];2IPE&O9U\6;[Q5\[6fH/YIJPNIF30;RcPAF=&<g1
#S(8?c1;bEL2J6Z5S3c0@B8[8_;.X+,KB=aPVL]:G^RIeH+Q_3Q))N=9_HPZNe4c
[P;[\A3=_M89]2f9)<AA<R[OVF[1gP^6QP13EU-4R3b4VH&aS[HZJ/TJL]^b8/Le
TgT=2EC\TLOK.J;3]SX:0J<?Q[UEG)ZS9cd5>NK,=09/.X^2BF_TKN]e^=GB031f
dG(5AZMHT/#2V-52DTf\RFCeL[@7ZK475f:??Uf5<G#R6;7D:bP/)<TT+XET@gaa
cEAM.&U[GX^.5fZFaPc]5Y0W(#/G(T(P(F<5_-7CV/\XWcKNAS(+(32&(KG?Q7bW
POB#VW#_W8YRH5YQ(#Ke\VZBD4#SE+5beK0C6N&f;@;B;2[9gO=CJ(f57)c?[E<S
::)\W\QE0+,\1dNXa#Q#U1YaF3F:B)CdH(7SF\.QM?EF.-a\4I:OO06J1P56b2g5
Gc9)OMW>T_Cba=dWP-</0O4;(AbE6J&I/1E=0PBR1VLT5.BE8@[DOWF)=5_Y7b=8
fU2S32DH3D[HK[:T.XVFXI81K:f))1^2(3,[MS\Q;A#^>e3;J8F0I6WXQ0FXRES)
bC-H,-<22MV5,M(+[L810#3XHQa>L5>4?C^18KAKLa5R57:_H/,EJE8-1;D\c8gg
FE@JRa?[3&:R[^.XHW)2<IX?E.B0+[4Q5)@;NYA_K>ZSA317a0577C#ca/199edI
5d<##b?)-AH/:\B-D[0(W28C_86T95E?/(8;GIa7<6?cINga=_Ke[3KWgM/BQ4P>
\WBO,J>b05b;3IaKaac]S&BE\][C)&))aSd+3K;\N02)N#M-NWEC-1a\f[0F]QVV
Mg]?CM@8e.YH4A7fH\OL3bB\^U9<#K48:?I-V=#[A:T2-)^f?8C2gU=L-[L9AMd#
4cQb=aBH?R<g1#^BE[F0;6\Bd<c66.?+:VXQPTbGW17UKH>,EE/KQ8?<:)^,6^ZV
XdGS=@T,?\DU/)Y3U\IOeTMP(#dRA>eCK,R6K4F=\eU].AD=(;WHD>/,5^3fF+cO
^HC>cb_AY+N.H67&NNQRQR)+^d>2Y,YOgDTXS8N&5]f0Zf=g)Y4Ye>(/NVDf0RHX
7ZZDRNf_\BM>)K/K[=0;1=RVOW@4c<&OaWD5+?\>PHeb)=Ae\-0902=&A@HX(WK=
Ae#1J=b#ag(d/1c29g\MPI7N4W(ZCHV^E3W9&feHP/CUR=#fQ)G#(5)?Ng)-9+IC
51/:@ZZ<;<&RC7N885&QX/?HH_YD6=bSB#FX1e_)#Y[#&EHMf852)VL-cU43CBKA
g@=&_O>b5FH=C_FN4Y9QFPC9WJX#6IMTBS87.2@++?.228\&83QG0TW;=R9Z3[[/
T<FCc7I;E)4LaUQ(M32OGVYR1@-bVb-A3.Qga#>-W@NaLg1#O-<#H&4eQe#WSRIZ
1/0#1B(=fJSTY8H[ZMLHZI;U,DBf0O;d5IXAEG>D+];00H)f?g/OWZZXV/]G[J>/
VIfe,UV^:ITaY.cFL[af:fP0PXOFJ4MF0]0.4UTSCC)#2#Yf\d^GTe>@#A8C^&OA
aC_X[]2c/3cM13<.>gFa[,-<eL#2;8\@K\56&FYFf-\JK]?GQ?(?PA=0;7gW=?C&
Q_A#QJIY.d.@#_W(AHFTRN?e5)HQWC#8Tf6G12#7Ae/\..WXDWNaD]_/B,[6#=X(
:=7DWMNKGRXWK_FFYd;Q=+0MMU@<8>P.0_5C<NYL[BUeCE7IO6-0DeO-IZgI]\-e
fcZcfYGCR5M<U]cEINOOJ\202GI26W32]dLe+\8QFEAd]/./5_:HcEC<5<BCcNS^
Gd[31AP^/L?ES7FaabV3>:L?7]KeQ28<TM9IZ;c30I,1[:FU7WC.K-SB=#=U,.^6
<>DPWYAbd/>0@S3X-C+B+e4Gb#@>U86g],:RM<K90D6PDgMB[,]8&\DD\YN&bNQ,
Y4J9Y;LC\^]Wd;[>eU=?Ma=Y[Q8If-I4K=OGXfcgC=9-S<LLZ15<dN#,4RHPG]2G
C1aEeN:J,FWa1abgF1K^671TH:A((?CY&aa40E\V:,[/\<WMM+W6JT:-8[>Ad5:Z
XcCNJQ08)NF(Tcb-24M<bP9RG7N11IVNBUO.9D-S4I>bBH+8:B.H0=c-W>F+?K/V
K9</.@.DGd4g;EYPZ?&KS@R.b^ee?@KV^Mf&TaS]P;\6F9@)Z&]6XVC962=a>M1-
&,-#D+?C[C#LLQ#5d3#7f+O3Q7P>Q--aN.f37Bf/\B&(g9BA&(5;@9eM.)dX4:TJ
b7(^:XeC_YIX.XY(L=fPc\9[==T_EU-+,+D>V7L1,^W;NGEXIbNF0c@Z@TKA.P.(
2TVO@13XVP^/U:4=P(Ha/VDE><8bA>/.cM1c4KF57A9(VS+SD(3(@[KYZ#=]3adI
+;QWdE53M49c/8NXK(IJS?(9.:Y,L&R>Z@34&:6K?1+W,AbFcE],.aVg0/_9[e(Y
,O<Z4W&)B_A&P@&B=Y/&ZHd1[3?fD(FAA:JH&-L^DVL_CC8T6fb)C=>TKS:O\O8]
_YXDDICY[E]\<D_L\_Y-FE@R(QQ]IVTY+M/UdHgVZ9:bOg1Xeb,bVWA.Vd]SL:cE
@_\DVEVS2d.:QgVZZ=D5bW>XPU:bV?Z.S#=&X7SRM:B8/A\9#<9FT36S]&X@/5J@
aW2+UdKN=\RTJ1SUE.XDA)&AQY:c4BD29(_3H;Q.NbFcS)^_^T^@910-]&5Q\cAZ
IW2YOgTC-2FVd44=3f5K8cPK_Y\B.3GdW.KM=]7g4d[/_X;?X4_P:a:,\J;R80E]
b2Vb&;+@dN@&B9F=QHD&e-E>&d?J-8f#LW5D69C4DV/(7fS]>g[T-KZX]NP2KQSB
:0TL>Z(^DfFMNaKc@#A0(c(]QRG2DdM4b1JMMI68&]K]]6ZDC\OG7C#/.LX668QP
><g.X0+bKcfX3^@_,begeQOBRBRAd6[Qc:;AgQe@EA<4Q,-E2[LF4Tb\5VQ?C@Vd
26?TP\c3:E(>9EG@+LfF+07;#(YCd@9#D(eS52VF.<D0=JbQ)A3YR09<LL+?X;(P
.>9-BM/+IPB(da+\H\IP>/,JZU5AJ)FD#LRG61G?9LC=cISdP.^S;[S#R+8+FL(2
eI@NTW<K.G\b/(TY6S<2b?^UU;:;B\;_)K@9P3@/=PVdA<V8\\C1>3c:#)+]UHZ]
>CEf+6@?L/0L4SZXR<1CF\AC;&@,eOTIfFga3cY_8345KK@F7F6Z[I)&K(G9fD<=
0d&g^EcE1)Ve8?1BEgN\)JDb>3:A59[:&3H4DM?GbT0J(Jb^JWN_2C1-][NEQb?@
:/@7LO&17Q2QY[d8S</BV6:4L@JNVRF>d&T\e=XY/QI^G4O:J&27Tg+69d?,>;HG
7G/Ne.][JW&X1QWg,X\3:_d-1P+D)G1&QP1#T=&7FS15.RNcW5L[9/<X#FBKMgfJ
N>Na6eBBW@V;WZL=Ma0f5PC5+IW5>DV]Y[a>gXH)U:g60]D4T)c._?P.RIN3I>]9
?XS5JPOX>?V\3a[[EV7ZZZ77XRL^ZJRE7^\ZO_,,QV^N:bPD6Y^2W_MGV0Y5.\]&
0YK6XcHR,I^4DKaJ:bHG00PbTORG47e<&;PB]gNeW:MaWF#5]=HJ^O+0K)@8g=;B
C+0R;U,-.81Vb;bbV[SRUPKZ?4W7I>18fZC0RaF3Y2cOgC0,2Ag\=4WCUN[dC2gK
?:g.c<+BGT.d4>^P)MgES:;2f+?U;C_XZb(AL&Q+c,La54J)eMMF[=YFNeUg8^VH
#=NgbM2ZMG7#7#cFS58YA/N[U?;5A1JVE#F/TQ7P[=Ef,cED#C?]VG\/aCab75&=
F]IcECQd7e>I)Ae^W;Sg#E)LVO,,H._3)6UA.bDD_;<\5cf6\B=Y+-58eR\:L3c-
.5O@eNdcMQd^O\XL7(]=KE_A,A8LAQ,8.DS+NB@Yb(M?@>_dV[12:aXS^M5X^B5d
FY??//S_Z_N]K+F=4ca<53?X2^E\<GSD?e2K;aB3KJ+f16R6^>43+R(>I0Fe;,#6
8cYS_8:QS#P3S+:bcP6dV,d:b[U9ML.9D8gDMZ0R_(T/a5&PDXDL4UBg_U#^E[<6
^N)N]3SVRPC\1LN?Q-CSc9?RKL6eCG?gOa4DU(O-NVaD9Jb&G&Pa&]\GQF82c\#,
IIf88L<C?/(>DZI\OMb/Cf.c=f<;^Y,=K,OQB1cWQ:)8-IY_07SL7f9cO6d8C6N\
c1a/bgfg;dYe.B^,a>A\;+gCMY@[)921N:^.TM[beY??=UXN[+5X31=LH#d+NH#3
bVF[IXWaXT:5-:g8J8?@G,/GHSBW9=bEK#]_0baVXRM^-a6dG=E^N,7aJJZ+e<[R
]^=2)V<LI<HeD.HPTO9B732RYJX5PeNB+:Ne8U+\]_&b]R_5TZ5b99.A\?c>cdG2
:O=A^\UGPVe@^=afM@283FOCB.AMJfUCb8+M(=>)3W]T>:>-9dMZa=0<8FHQ.E7C
>6A)5E7]U<KbS?:X@&e@7E17,_75e&WFgT05<H?9WfTH/C)-YHIeDUdK=TTGK?LO
b9.P,/d/@7Q]0MM1<d^\=fY39.;+],Y_=5e8/PM;ZDeD;-8JG>d^Kd>Ve3QZFaH(
BV-RH([_Yb3e1:C6[^S)3.&X@4(;XM;1?>CBYGc.<IJFH3cW;2NG&Z@3B]5(OIM&
2;[[^+([T.&^9#ga-#C)X=KQ(F93AeGBGIC>B/A0C0=Y4@7=d4Rd5#S]R\5YaS-B
@?PT:OKfF7S6U)I.Z02J0WXP?KWVG3)bbB16>1DWOXX27WN_KWc_ZQA4K^B4f9Q[
dg4;LW?K[4M6QM9>fV@\[48&:G_d^H.AY87L\HKR;3b[.eB@VFHTQS1;d-.Y?Hb\
e#Rg@W)-;VVcZ16c8R/_[/fdZN2SEa.7/Z414fX3(R?bRFa5f#D)JXUDJ\EMP.)8
MH8;gU.0+DBc-$
`endprotected


`endif // GUARD_SVT_XML_WRITER_SV




