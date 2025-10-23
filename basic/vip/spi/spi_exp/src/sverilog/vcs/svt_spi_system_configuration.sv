
`ifndef GUARD_SVT_SPI_SYSTEM_CONFIGURATION_SV
`define GUARD_SVT_SPI_SYSTEM_CONFIGURATION_SV

/**
 * System configuration class contains configuration information about the 
 * entire SPI system.
 * This class is used to configure number of masters and slaves in the
 * SPI system and provide configurations to every master/slave agent.
 */
class svt_spi_system_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual SPI System interface */
`ifndef __SVDOC__
  typedef virtual svt_spi_sys_if svt_spi_sys_vif; 
`endif // __SVDOC__


  /**
   * @grouphdr spi_master_slave_config Master and slave configuration
   * This group contains attributes which are used to configure masters and 
   * slaves within the system
   */

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
`ifndef __SVDOC__
  /** Modport providing the system view of the bus */
  svt_spi_sys_vif sys_vif;
`endif

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** 
   * @groupname spi_master_slave_config
   * Number of DUT masters in the system 
   * - Min value: 1
   * - Max value: `SVT_SPI_MAX_NUM_MASTERS
   * - Configuration type: Static 
   * .
   */
  rand int num_dut_masters;

  /** 
   * @groupname spi_master_slave_config
   * Number of DUT slaves in the system 
   * - Min value: 1
   * - Max value: `SVT_SPI_MAX_NUM_SLAVES
   * - Configuration type: Static
   * .
   */
  rand int num_dut_slaves;

  /** 
   * @groupname spi_master_slave_config
   * Number of masters vip in the system 
   * - Min value: 1
   * - Max value: `SVT_SPI_MAX_NUM_MASTERS
   * - Configuration type: Static 
   * .
   */
  rand int num_vip_masters;

  /** 
   * @groupname spi_master_slave_config
   * Number of slaves vip in the system 
   * - Min value: 1
   * - Max value: `SVT_SPI_MAX_NUM_SLAVES
   * - Configuration type: Static
   * .
   */
  rand int num_vip_slaves;

  /**
   * In SPI_STD Mode, by default Dynamic data array in Transaction object holds the Data <br/>
   * bits for Tx/Rx. But few applications require storing large memory blocks <br/>
   * for operation. For such cases optimized Memory Core is used internally and this mode is enabled <br/>
   * through this configuration bit.  <br/>
   * When enabled, data array in Transaction object is not utilized for holding Data bits and instead Data is <br/>
   * stored in mem_core for Tx/Rx.  <br/>
   * Memory core Peek/Poke routines can be utilized for initilaizing and reading Data bits <br/>
   * Memory core buffer space size is determined by spi_mem_cfg.data_mem_addr_width field and is divided equally between Tx and Rx. <br/>
   * Tx Buffer space lies in lower half (from address '0' to Total space/2 -1).  <br/>
   * Rx Buffer space lies in upper half (from address 'Total space/2' till end of buffer space).  <br/>
   * This is currently supported only for Motorola SPI, #spi_feature set as SPI.
   * Default : 0 
   */
  rand bit enable_mem_core;

  /** 
   * @groupname spi_master_slave_config
   * Array holding the configuration of all the masters in the system.
   * Size of the array is equal to svt_spi_system_configuration::num_vip_masters.
   * @size_control svt_spi_system_configuration::num_vip_masters
   */
  rand svt_spi_agent_configuration master_cfg[];

  /** 
   * @groupname spi_master_slave_config
   * Array holding the configuration of all the slaves in the system.
   * Size of the array is equal to svt_spi_system_configuration::num_vip_slaves.
   * @size_control svt_spi_system_configuration::num_vip_slaves
   */
  rand svt_spi_agent_configuration slave_cfg[];

  // ***************************************************************************
  // Constraints
  // ***************************************************************************

  constraint system_configuration_valid_ranges {
    num_dut_masters >= 0;
    num_dut_slaves  >= 0;
    num_vip_masters >= 0;
    num_vip_slaves  >= 0;
    num_dut_masters + num_vip_masters <= `SVT_SPI_MAX_NUM_MASTERS;
    num_dut_slaves + num_vip_slaves  <= `SVT_SPI_MAX_NUM_SLAVES ;

    master_cfg.size() == num_vip_masters;
    slave_cfg.size()  == num_vip_slaves ;
  }

  constraint solve_order {
`ifndef SVT_MULTI_SIM_SOLVE_BEFORE_ARRAY
    solve num_vip_masters before master_cfg.size();
    solve num_vip_slaves before slave_cfg.size();
`endif
  }

  constraint reasonable_frame_format {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].frame_format == master_cfg[i].frame_format;
      }
    }
  }

  constraint reasonable_spi_feature {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].spi_feature == master_cfg[i].spi_feature;
      }
    }
  }

  constraint reasonable_baud_parameters {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].sppr == master_cfg[i].sppr;
        slave_cfg[j].spr == master_cfg[i].spr;
      }
    }
  }

  constraint reasonable_endianness {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].bit_endianness == master_cfg[i].bit_endianness;
        slave_cfg[j].byte_endianness == master_cfg[i].byte_endianness;
      }
    }
  }
  constraint reasonable_operation_mode {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].operation_mode == master_cfg[i].operation_mode;
      }
    }
  }

  constraint reasonable_payload_word_size {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].payload_word_size == master_cfg[i].payload_word_size;
      }
    }
  }
  constraint reasonable_spi_safe_frame_mode {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].spi_safe_frame_mode == master_cfg[i].spi_safe_frame_mode;
      }
    }
  }

  constraint reasonable_default_slave {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].default_slave == master_cfg[i].default_slave;
        slave_cfg[j].default_slave inside {[0:(`SVT_SPI_MAX_NUM_SLAVES -1)]};
      }
    }
  }

  constraint reasonable_default_master {
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j]) {
        slave_cfg[j].default_master == master_cfg[i].default_master;
        slave_cfg[j].default_master inside {[0:(`SVT_SPI_MAX_NUM_MASTERS -1)]};
      }
    }
  }


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************
  `svt_data_member_begin(svt_spi_system_configuration)
    `svt_field_array_object(master_cfg, `SVT_NOCOPY|`SVT_NOPACK|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(slave_cfg, `SVT_NOCOPY|`SVT_NOPACK|`SVT_DEEP,`SVT_HOW_DEEP)
  `svt_data_member_end(svt_spi_system_configuration)

  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_spi_system_configuration");
     
  /**
   * pre_randomize does the following:
   * 1) Allocate master and slave configuration object arrays
   */
  extern function void pre_randomize ();

  /**
   * Override post_randomize 
   */
  extern function void post_randomize();

  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);
   
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
   
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
   
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);
  
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);
  
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
  extern virtual function int unsigned do_byte_pack (ref bit [7:0]      bytes[]    , 
                                                     input int unsigned offset = 0 , 
                                                     input int          kind = -1) ;
  
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
  extern virtual function int unsigned do_byte_unpack (const ref bit [7:0] bytes[]    , 
                                                       input int unsigned  offset = 0 , 
                                                       input int           len = -1   , 
                                                       input int           kind = -1) ;
  
`endif //  `ifndef SVT_VMM_TECHNOLOGY

  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);
  
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
    
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   * In that case, the <b>prop_val</b> argument is meaningless. The component will then
   * store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
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
  extern virtual function bit get_prop_val (string             prop_name , 
                                            ref bit [1023:0]   prop_val  , 
                                            input int          array_ix  , 
                                            ref `SVT_DATA_TYPE data_obj) ;

  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * consruction is taken care of automatically by the command interface. If the <b>prop_name</b>
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
  extern virtual function bit set_prop_val (string      prop_name  , 
                                            bit [1023:0] prop_val  , 
                                            int          array_ix) ;
   
   
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();
  
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);
  
  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
  
  /**
   * Assigns a system interface to this configuration.
   *
   * @param sys_vif Interface for the SPI system
   */
  extern function void set_if(svt_spi_sys_vif sys_vif);

  /**
   * Allocates the master and slave configurations before a user sets the
   * parameters.  This function is to be called if (and before) the user sets
   * the configuration parameters by setting each parameter individually and
   * not by randomizing the system configuration. 
   */
  extern function void create_sub_cfgs(int num_vip_masters = 1, int num_vip_slaves = 1);

  /**
   * Allocates Mem configuration object for each VIP agent. 
   */ 
  extern function void create_sub_mem_cfgs();

  /**
   * Set the Master ID at given Master Configuration object array index
   */ 
  extern function void set_master_id(int index = 0, int id = 0);

  /**
   * Set the Slave ID at given Slave Configuration object array index
   */ 
  extern function void set_slave_id(int index = 0, int id = 0);

  /** Return the number of masters in system */   
  extern function int get_num_dut_masters();
  extern function int get_num_vip_masters();

  /** Return the number of slaves in system */   
  extern function int get_num_dut_slaves();
  extern function int get_num_vip_slaves();

  // ========================================================================================
  // The following method must not be called by users even if they are public
  // ========================================================================================
  /** @cond PRIVATE */
  extern virtual function void set_num_dut_masters (int num_dut_masters, int kind = -1);
  extern virtual function void set_num_dut_slaves (int num_dut_slaves, int kind = -1);
  extern virtual function void set_num_vip_masters (int num_vip_masters, int kind = -1);
  extern virtual function void set_num_vip_slaves (int num_vip_slaves, int kind = -1);
  /** @endcond */
  extern virtual function void set_default_master (int default_master_id = 0);
  extern virtual function void set_default_slave (int default_slave_id = 0);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_system_configuration)
  `vmm_class_factory(svt_spi_system_configuration)
`endif   
endclass : svt_spi_system_configuration

`protected
A6,V\\WZQX^9<TF.O:PZ,B..+X+N_Y51We-B4g9A]QabM4O_/3US0)IL0OZ4MA4:
TYOF<<e[bJ4^+MS(YM1e_C#=L:&2g:9R;8R:E0=((IN+a]=Ug&UCK+b^?4J=5+cK
;FU&U>>MDa8\.H=RLXUQCDS?O#@M^.bA(/cVX<4RGXGV(ES5)SW4G;P_5\A:?QWP
#8<Ag[8=1QH+,YadNX&.(?5&>3e8_6JV3fL?APF(UEVH;&Ad/Z^D-8g?1Q&Q9L]P
LdeB<Haeb7ULABSK_IY65(C[,WRA4Qbd&c;XYEG-V0D1fMY=TSVKC?E,RGY+-50Y
g5[\4Yf:AE0Q3:a3;+BeOaN^78OU_Z5I,6O>2=E^eC8,DA:A4Y23gN22OI_TS1d3
=<@a]_#EWf/6=409-+R7\eQd,;IdHU0IHAYJO@U5KLFV\bVI-5T,GG:;A.\KQIRY
@ASf/1P7(<J@JZ-TaQ^cM/f@??Y.>.]D>cXKPDHHdb>23+HAP<Z8VC-HPa<OGcc9
]&]+Z,J(<KE\@[]:X-;>f@2/<P&>#cR6#ZCgVOUD:A0M8I^89TH-:.@,E\+2gY3O
(5:=6bVTXN@Y)6@@NL8OFO8HF6=1.gJ74.aaeCE,:LUB&(G3Y@6&1OE6^:OCC;OY
(:_<+7e0a8F=2YJcLSI.=f2B3>#G[)-bWddbCK<I;TTCGV3YYeD@/AFE+.&(/O4-
X8F^KCXT&R)RX@K;KGec+WKY/0fb@4L=)FF-eb7U]RPJXI,bE/U_CBX,:bE7;=3dQ$
`endprotected


//vcs_vip_protect 
`protected
T9D[:H(-CJ,M4OQ^>(:BReJN5:[C9?<c8ccVU.;aE?@ZGOQ^H.;Y-(P\;LO._fLP
.e:?MEGAf\K25;#+2Y^f<I^g?N[dIg5RZd)T2@X]BJX46JJcTe[&Z@0gZ<TX&H4^
5=+.8Ac1<&SX5+F;>#)fd]G>TQ9X.07_-6;5eUC+1(8]:A[g)7KLC#02RJ-a2_RK
-G55-K0.+G93,D)T@^:5aT8Kd/f:6\2YNT8JLeCD/A>DKEBCV;2\LAZO+,B2W2=X
gCWQVJAbV_321<G.G]-W:B=(-LWAGZ0M]FA:?DLe<,(0-<ZXZ.THI/7<_I0G9065
XAS0N-@/L,QNfF9@fe5g&Jg@,QTN)#-f./OM3=C9>IGH18+)6U[L,59Sd]Y]3ZfF
ZVMN8;-+I5FAK3>K<2JS,&(IPW1_(f9[OO8OG0LE/0T5([\&(JPHUg78f1I&0UbI
U0JK<g29-@4Y4TE-Tf0+J(6B(MKd,E96-\c>TW9LIOXQI953H9_f-L^^eTT9<BUa
M;e;3c?U:Kf-1&(MT8f\J1f/PK+L(VN/3GPTJDY8-]g/2f^SLL=L]^3V8GA\f+aT
/,([(Q\2(Wb8ggaF_86@WJW,+:UVYd6]TCB:#O_@^Z<D0AGDL2acY;.NK[MA&1aY
G/\F;9ST<MEB\U3K0cVd1OVe8MbPK.c7YQF5/5\?Z:?<c&Pd15JLcNWQ6U8.JL)V
-P&W7,e4-@g:Z#(Vf\ENSLG.g?+da9W=c:;]5F/D<0@GHPMO]^fZVV6JE_Ea^+YU
+8(PT_E3]EU-\6OD>gJO+-WW/SGRDgH6O3Tf31M,Xb<g6@Q)/:3)C_5aWWT6aIHT
]\DC;456LD\QMD\?G?ZdHR#MU0[,O)F=3deO&Nd;[3g],B;U^HP1H^]_<U]>(JK=
WH3c_F-JR:A=LDNWJ.47)N,7;0C,bbRKYDMF(\2EN6TFMCS1.-/Y\.[599]HbW98
3;J&[Y>?XG1ceT\9OKdJa+&ZD&/L@,X/d1;Xfa[3;aC>1WK8f(?L4c&Y49>EVBR)
MTO^N6V@E#VBLBP1,J&(T.B-YVJbOb\8cD1[L#:\Q(J5fFQKU9_A,P\\XXN5WRGK
(7/(8>G,@#HJ75A2-CA?J0[-e4B5\V]>;#bgLMe3\0eG+A9K\>g<79NYFb#=bAZ#
#^)I-2>DE+Tge[G+L7D(OKD_L]7[KI1VaD6?T-_(>e4e-Y3&O<&N\I0+=OcA8O,0
Q6#WEMW2/UE?L(ACEHW=eb)c=]EY=?.L\&^\+.]V<::QIO^+dGW6GLF/^W-5?1YI
9.&,#IL3816eO1.J49=9[C=;C)>F[gS0>9=1T)JQe#:X1b#BUd?b=UHQQ]L@CG7G
.\S(d44U^G_Z9SaT@13/&()^\4EZ4OdPL&aKAC^H&<PRELeO/&-15]N1RRaO_/)<
I;8bQVg?JBec@^g8^+PZRf>R>X9d=(>.-XQW>6PNRR]@EA<=4R@)&X)b)<&.;C2_
,dKR:V9EKZ_RCNPJ1XW?,CeTKKaK.E:C,be2SZU(4M68[DV]1=d@I8YNG)F7S^#+
Q(KLO6Sa#/O-ceTYbd83)VFG<Q(\];QP^9NF_<4\(YX,>0F3c99X=W^Z]CSV&##H
Y(TK(/GC_=52g-N3_:Oe8847FPDg+=6-=dI.I/N[96)J^&[Ea@):INb;aB4A<eMT
:F/\-&T7(d?GI7D9@HQD3;:0dT^G],33;CFJ_C)/C21@Q.c[-D8_JMb5]e9<]a(>
&H2FW+;8;80]3.,=RIH^/Z.G3\IE4RCS&2(]\+?/ZfRAXUIDWR7cb[fb1Q8JG,SH
JDS/QI;G0EV@5V@:@;QcbD/7D(0:2bgB=PYL97&Fe\L(#gSgDd5N#2d16:E\ZJ#B
Y;2W]GEb]fCQ,N1G:>MHX+82W#YWL?aHecR3a(EA339fZ9bO8YM9Neg)5I.fBOY-
5eOP5aF^BJ0C.,aad5[.Q1;+8QY)a]1eCW\P7JOVQ5,@=b62E<+C&=f^ZW;#6,]]
U,E+8-94cV(M]W-]/)BO[]37J[X@9EaAN(d9)L-=L/gV:N^65]3cX9\E8##PJAN;
IL2,3+X:9eVR>RAU];:Te5R:CQC\VYZA5Ya#e2VdXZ[>:R\7U5:=U3eK1bB[.gSf
g:Aa>OPD.BEMB/93d/B6^fC^MNA+MB9a@gSF<K/OXA4E)a,?Z#,IW42Ba510>&A9
5_+ZR5M@ZI4bXQg:T_>MeKHG[M<\O5<XeNA?9/e_.VMf^T77A,S4HLA0&428\5?0
]:6^TRgA5<(#3=6YgJNc=]cV-MP.YI#P-\Xc])7XXbLFO^=18:aFX7cKAX\0cCLe
&3/#0JL,>WT52ddYV4)\J+N,f.7\C/BHU:@a7\/6IO+O(>1#YfXE^75W5>K:G8N@
,7M:cgH:A)aC:#;6?E9N^HEORKG09c&URZ+:J#FGZWeMQAV;-I/4d)Pa-A3UE[ge
9VKbV>FPb?=aV9E/bF8VXF^5,CTU6@(JHW;7XAQCbI,?a@ceeGCc)8FEY&=OC\^D
dAe6JQ9@,Jc:>)F([4RQC&8Z6X=M[E4T9=[0T;a3W4,-L6\#a1#&/\693H;H6;a/
Xe,WD3[8J<a3\Q?#b_Q,7&?^J)V-05[>C[&^ON5-#V,I]F=A3?/[/OA4QT-+Pfd@
(.GD9CcMC1(//)>^,]PZYLQ_,:B][DTNDea,FW:HT.#6UYTdU_.PC\1\SgT0ISHD
)a<:VbGXc)a3LeQ(SO5g9(5A/A,MI0V99;X-17K9<7(F8SY+gg9YC^2O))bK5=?6
>H=<4,S=Q:^OK8g8[@+)EM#^WQ7Ae9MFV]Q<);g\DFXWL(,eeLHPGKaDZgB.\?4\
MJ1CIRac]M#<WZ1UZc/aJ:2-=_I55FNK..;_H]TN8T=Z5NT5M8Ya3=gJPe=@MRQ=
7\R<G[XK1(MU<6F,OU1[3?>#I>ZfK>.O<8R:75^&A[NOR+e,UJ1FG_N\f=9);EU&
QW5VAZ#^9BSQNIgaDf3P;+:DU3#?L-7]T)DPQ0aNHY]Y8X-595F7aR:VfW?U<1\]
1^<4gPTB:=9gD08EZA9X^FI3;+A3BW+;e&^5dRa7eBF,BgPMZa^dA9EEIUfSZ=,>
^)WX)-4ZZ<2DE\+_Ag_g.^HHa(4aN<]-H;U7#H>0RBa>+KDC:QG=00OSZO>MKA@f
Gd]aC/(?[gT:0aXJP\fX676GV41-]2CE2LCPS#;OKP:Q,C/+-[H-G47Wb)>g-G;5
bQN9Z)-RC_>OQK:7(8Ze:94OD4c)PLf8aA>gYeVeW#PPNPfc:LD6)\HGGF,W_7-+
F4:4,=,;M@^2+Ba8<Z(5)]SH;9a+O6X@K6cEfSd\[cI#YNf5J&f,(;C,A)WJ4.Jg
UY_BN>W@WG9C]VKf@6GAFbPVNdBT4OYKa4eW#63LcL)2>_:Ja#X;+=dW0]W+>HXC
>C@+URgL_aUe5MbcbbQCNFbXTOG0dIQ#6dgBd5aW#gWGb3E5X\a^BAZGP>YcC;4Q
R5O.L_6M2?&)&D?LS,_DFMLK;:+XJX&]HdeY42=Y>Cgde5TG;6gHIJ]SL#AU5=59
gB02_-D+9-5e#A#+AT;85\8GVU6+MYYWJ_2M#-)V4C0RH\K>5ZQQ/Y)1e.;P?Q[E
c#M8:[G4,HFEA</,QN])WDSD4L@;aJf?&[;G5gGO,G=E#ENR.e]F;6\O9,>&=a-L
Q<SIZ+\0\\FbJLPb6bTVGYZ#,eN@+V?eA63@JRL.<<Q+E#:CTFZ\FW<;2U5/U1U]
_W3/H:NaVEHD:aI,=KZabb?J;Qcgbd/:f-gZ;^\8KEa+B/&Z].[;>:,.(0IX:cCU
:2TH>TO;V7_/e4-+=0HUB+?e)aG3e<#-02VI:V5ee7ANH;R8T(B9aT3eFeX?dO-:
1=]_T>(5\bJeTa=f<ZXWJ/HBUc2PK:/R##G#]EQ#7(7\JN^OP^BO7(+d:1^GWC?-
].G7[^:.?K.J7gBB_</RQ9KCPJG_E1D2C_.7R9.G0I#V4RefBe,\^XK2&:c[_<c]
e-Be#c-JDg)4ZUa_#\CY?<]=CKa-e,NQG8V]R8883D):efRJa?FYRa;3Zc5cJcN<
J0aNDLX.T1F=<CBX>)R;K?Ue7(\Y+#:P</IgQVZFD5KKKDLZg7^<[Z^X(/gA_8;&
#PGLXeSW/3[I@)bNY8^>VcJ.bf?;gJCe)JO[g,b@9;XM4_:6DNQ^N036\XF&3G//
M5@aDW<>?A>,765g1DCZ.927b0e8C;Z95&H?]U_Eb6\JHTX6H-KGfSNE&I/CT9Z7
GbH=_5dI10C4C:5?B=PM]^LE9?0&T@KY@R-J0;dVVPKc_)1VEI>9V6U>(35N7@/?
J/[Y)=-3O1+6L(.G=VK->GCVOOAW;d+GZC8Ef6P-FJ0=&L,a7M)GOA_AP#SI53PE
+,c^K,I=g4bOSb\J&VVXGS9\GR,__H<]?5PP6M2+d#8#f#BEgYFM?2aE0RG/a8]2
(KRI8cE])B8HZG:M3;f;(K\-288M,M?a-=A<N@&U7[?Nc@W6U9a]2+V/bQ4-3G@2
BAL=22DR/1Xgf\@C>PD).6S2>^VT3;-NT<&3WXGCfa[UdCdBJ14Z[M:>/)T0Eb=P
QWFHf)B)&cDT[Q?=8].AfMKPJ_+NZUS;J.5eIJ/+W0__M1RHG5cLYdLA#e3Y&HU2
eLNPRT+g[_=,AcJ#5eVU5O(U]f2^[VgBKD<S7WMY2)W&?7/afV^+WP,KXV-<#3VO
-bJ9-Y-Wc2S7QQXF8A\Z39U7OLP6W?S(,X(=;X>;@DbUc,dR=C/1K3+2=,=dDH4]
1ZZPZeJga>G_AN3^JNOI>3;J,cTBW0<)^,HRF>G<NY/Za0[>?CR^,6>F[)YO8)-@
1QP]TSd\XJ.+J3E\C&cPMUN85TZ8+-]CR(HED3Q:\@aISee0&&(X2]SYZYMF8#e\
)][9JWS)eVJR<]+=QH/>D=4SdX,5KPQ6Y&)(3\0\a>3019IR#aGY(=DA(?86d_/c
_G?,.-PZ]&H&^42.T/3A\->P?g#\\WVIdM8Z4aEgP.R];1PQUJG22[G[[^G+<Y15
@<gGC?K455.=W<NS6IU1M51>N<N+C2^:9#&3,4,c-NKa?KNH;BcAL^6,<C_A[-8<
Ked<EU\>0M0[P&F&Z@]EWOK-c@f3M<LTGHHCaWY1W_DU[fLL^P>#-J-_eD/L81W]
WTc,B)LPD-g_^/ST<66X,H.KE_@K-:eQN;3<be9-25cUcJR[L:Sb7dbO8+Pge)]F
B7CWMUbM(4^;3fRU[KMNcBS52_15RK4XNFTKEF+,-=Xd?UYIM#B@?O\]E6+2C-EA
>,)#NDE5AQ,Wa&&W9-c[DaY[VF.JX)2O]?GU?GggbMA3CA>B.eZ6KYc57>N0Q)RY
d1VB2XEa6;P@\P8[.+[@O&G2B\fHWfD+]e,IP_A0BXH;gG-75+&@R_AHC<6M)Q#5
\VUY&I/e@dFe0eX14(G]YRQ#d?0SIHUZf//b@fPTT.2)2IHKTKV1gQ_Ib9I80\#Y
L[62(c:O.9df,IT2/<X[?f?]A[cJDS:CUI\<ef@8b/G8H\e9&Ee=J.A-eMP3UR94
dMY33W(8#CUL957UKGQdaYE[Y=#8?B>+=If7Rb3]H^N4G2e+bUSX#R3JX2eObMQc
F.@F;W2g2gRe-a_E+c^J,JWT14/CCBD:^K@7S?-8>8KAH)+C9_B),Pf=<6[?YIP?
#JPEN3KHJ]IGEeZJO_ENO75OdaX/+.>eVRO,DVJB?&]1H#YPE]1ZO6@V::a[Sd[b
.affXRQD5^8YK=LTg&ebLWM]O;Vg1[BJ^;&R]-8I(@b(Vc&COAXgSEMT6H_Z2^9g
&,gW\g?,ALg7ES;]CJ<.9;;dH^g^_11Wf=<8g2gOgOfH]AZ\fY1PN7\[4IH6g7?.
O_d;3/.S8IJ;.E1R:G^/JEg:61EeHeVTEeM@]cU2[,cY1U+7PXW8C#7,B66]03,]
)?F.d,7K1C8,0T)6NT/MQ@\7#A0Bb)>=&,KfA^be[<+A)K]]<ESe)E:I).BR)S[F
<C<?YY7e?=)CQFXY-5@aW39&^^)eXa7F,,1_<cCK1USP&6aQ9]bbS?MG=SBNdBUV
9HCX5@XU1@]>RB[fZ1&(DFLJ9^14dCN.,H?10OWgJ-?.D8LTP(9G80V]ES[642f]
Md)Q/\AOH:5<&K1^0K\eREZEGN9H8PcEC-+QCY^K#9e+\IC>#YP906D3ZJd&?2\M
I^\5RD7)BNf2,69Z?6UQ<e4,Hbd3>UbI^(N?9<SY]_V,/B<XK_9OLCDPYD\8/=gY
_X=8Y,3W;^[H8M[B#AAO-WVU;@aELVa^IYcJ\Ce51^FPA<.1K7,gITL]PE44B5Xf
Oa\-]0<3M=9KQ0ST<YGLIf((Z[N34Uc^BYQcK=bI+T5[c/;P/(.Z^Ve(Z5NO2MCN
2QG&cYTG#/bKaH44H/G3GRM]CH&UY=7BaAgI]#T,2E>P\6Gg(^AQ/N_d:[=Y_f/E
S]&FC_FNED:E(_^T3^Lc0O4e1@DcWX#YXTcT,FAEOTg736#d@]X4A9DDL6<]fQ&^
+6P?ZYNL2/8N2EW870\F@6b8O_JWE\&VL@O\H\WAW9Q++g&?NPeI^O,J=2dC,b4U
a@E4(3DWVH[\;7:4Z5e0(8Kb\0Mb#5_@MTZbA(8?LB(:K\\JJIDRD0f84D?b3_fQ
&P8fP&)FKD>RMC(TPAc@[X6-;<fB>X[E/fbEGI_#6#+F?9L#FHIA+\,HbVDI02&)
8-,LL79U<,ZNGFO@cF+8DBPN,L62)#+bVc-4-]Rea3,<-4V=B:T:<[[a8S:f479-
_4^8SB7\eM1de.H5b\L>)OY#b2HaZ13dA@@W4@ZaPUFRfcD<MP]E)31CH0bE==Md
I^;-1.3J[P(gDc[>GQ[e.J;D_6[H:/66M_YU:CBXXbe[T2KK>HDX/Xe&d>a?23FH
:]SeX^dXQUbEBMMFS,9F^b-A38M\:?6@5=8[0BRc\&e^O.#K3I^X;)2+/(2G#WAG
QKC1]35>]]6@FR,D;YST5:(e)Z8]gQW5Ea/F(9Ma=[J61gQ0N8K/M<]RV4^/>@XU
7+U/T_,SW-30WDFH-:=N2bcMP/27Q<aE:?5Q0(0\Y3KEXa1M,I(#JM_6.F00=;5N
C:PQFQA,^QA(H(+[UK2_T4FJ1N5UW2ONZ,=4#8(#-74aQL5_<7&O4P:AD&gWbGCS
2--OO>=84IJ/K9aKNDYR?@YNM=N+ddHBE(e\.?4<ULJRc?9f:4)2(W_4BL->]Gf?
_QXN.SBCe[deW,2gVBf2330H]V93M6R_-J@?e:/[^K;a@-<[ab&C[D?2U&:35LQA
BHPa(g_+EI-HXB>G(QGQ7[JT_\9g7X_A(K4&Z+G=TCg8e(?0_cG3M6Z@Y75\d3.L
Uf]XEX2L3,?<G&EMG5Z6JAfGaV6_:e-=XCX.gE;IGKL#7#1=c4DSBU,68MNG)H==
N3f:<1T[O>=VX91\K2>EMLAA_WB5<=CGA0f#B^/:/:<EL3?U@QVT-3W6DZOeTLe0
C:4P]8@Y]aI6OfRW#7K_+K#FTD+L77-MER48RLcN7^P6a8F.W@Aa.7aS=&+=L_Tc
@<OK&E^#)WcNH_R]WQ]_KU8DOKP^Z^\TO<)R.B1JgD0>.GDRcB3f]@&VN6da3,<&
HgQc(&7GED=7,@]K4=d5MbZ0AWB]9g3J[?^d?6Y@+3QQ:=@-F)d7&(.-22NRfL1;
^)6<f0(Uc++4?4I/2V\7:V8=_>JV;\AWD[b5FFJ?SLGb9#Vf6?DIXg):YW:8d;&7
/SfT(^].KS>_?7;+9Z=N];?V#3GJ3abQ=@^^&WU1+B3X>Q3=fKG&7F<@B\&</[-a
)@MgeSe,+CA+A;KG@TU1@-:N.S4J637c3Lee8FUPDH1#]>3CGX<2-BNBHLaNP1@S
:#(C):HS5a.[-6F.T3?9dZ3+=#KYD^>12T+>>M1D8W/:caB5IIFMAd+=IH(R6(KW
]ecDSEVTM[/#QR[37e_,3&XB4>.7JQ70/J4DUHTc^L2C26>CIFBS&gA&[LVB/AOB
]Qaf7BL(/=6;2Ic#:7g4QUe33bVXT]]>_UW(_a4/CGOVOF3[7<&P5S95PTR/BAK&
:C+<2AdD_g:a.\=,&KZ\ENQLM]HYF5?I&I3_EIg(N^V=g&;GZW^3a4A-_Q0bF[WQ
.d4Jdg+a41(8]5C7]WIP+;+:R<_;b=8]WE@(YZHDYK4@QB>+U4YL?/P6fgG2HQPK
[L=:B(06B90W+.?YHW2Ne7(12OW^Tg&(\4g;I43Z3<,K?aJ-GT]DB)<4Y&QR;0U9
67U)EG;H4^3:_ZOIT02,Y8Rg&J[)Q)]-7S/Ag2_BL:GZ^X+N1V?JYAK1.HJ,<\@]
b6;VRV,<=.+5REA0@6)E>16\X6d=,5NP1gG9aJ_GB\7DA:E(Y8BfCg,<Q_-J2/AA
->]bDY5R-E=[OVJUTA8BOTQ23\1]^bYD./;T\ERK/&KPPH&\;M/G?(C\8BJHUFSX
(a1ILe^-/^C+PgUU7_3;407?BOX5POAXD?PUZ2H^2Sb=F7F])ODMRbB6eNAHF.VM
P]YA0SDO80SIZ2>IR\8;4.:D816CU9H2-2:4>_FCW)BAOA/5ZH@;ZZ=\c\;8@EBN
5+aa]HN;+e[31/U1^0JYeec.9QQMeAN>W8c,+F+5S,_(7S33TQ^TOIVCL6aZ._@S
d(L/T9L],/&bV0d4Y2Eg))+X]4]TIfU1+WU=fGgaCW&O&+;0P7/PNO\gLCE-;OZK
_+ggd_aEZ48RSVe?DQGOF@bJ/O(4F>Q-(2>E:0>64A\QNY/5_(D/N68WSH+2:JW3
[dKaQbZ7bH956)c@;K<4N-ETQ^96CF-I.@H_=8(I4aP:52V3Z9&.)GI=YHX5RLP-
9a96YFZ,,2=fA/Y3Zf/)1DAKP15;MfZ^>5Ue[)MZ/&+(/Z#AOSC>O>;eQIQ#3eDg
B]]USUU+P=;-W3^a8\G2HA84)^:DAGIEVY4(SQf4ReN7>I1[RAUVJ9^A8]]X;5Tf
6Q[,.g;ZecO89&fN0DD:.4^+9SD.U,,/V/41,#7;#JH<dDG&B0U5G:6.R7F3\b)G
VS7[#L9+=U\BS[g8#a<f2ZT?c59G].;/(^0fFabRB8dUJ@^IB;AJ3c_Q;Xd2W+&b
-Y[)^>36;3gP6(_Hg9gaT8;]-@fI#W[_,HFJdH?WX>WP<^68+J[V+Ka4S/QP2]gK
4acJ&)Og<TT<_a7\-&5LZ\44>)aWPcW.8C,6H_C^N&HGfOWX(OSWK1dbQXaKEPLa
\Y95gJDUgSAc1KeZc./fVEKaHJYb7I:JaZEN>DZGde4QgJ9Sc4>RdaZPOb-PZZV;
cOT4\6cNV,a/Z)7N1-@KCM7Z,aNXg31EK^=2.f&fO[_^4dF(Fb,P;C#Re^Ia]:<6
&,[J4>>g[04Y<bO&>+?R@SMF9R-#D]ND;HQg[1?-f]LS@?S-Jg<+Z>7+46?OXB,g
&CEc(_aWOCe8JeAdJI;[T5eN_fV5d=)W-G7AD9c:Z?>.\5EK^P[((25[aMU#BLQ\
XLL4#:[T.Y<f?;8C34WP,ZYKZ-<8O9?,8+U(P3;BLR:Mb69)I+gEf)RG#MB:8[?e
?Rc>9+L&;4M+&^d</eA4=fWKY0T&58MMC\/eD?KgNbY1^B4YN(#<E6E5(NF+JA^#
T3L3AT8Y0(Z&K1PG-0>T7F&D4^8;.O/X+_8.MAW5D7Z[\AF<7c/?eHDbMCa=@Ta:
#=&BD-S44C.(.,1[W\D)]J-aFDDa4O/T0^8KP?GEI9A=KaZG0g=S_CI;d=(#11X5
DE6ES[I&EOUUE6cIP0D0+0aH;Z>eK01RCZTY&c_cFP-P[_88=Q<Qf3;6.4K<MBT;
fM&1]8@a2X45Ngd98e//.44g<NB,Ge=>Eea6/L.f2798#U=>05XdAaeWX>Se52KS
DIP4AYadA@BgBKd&I)bWK_03E,H#TKd2C>[W(Z0H<d;R0A;2VIHXCS;@5f9=&_?G
P__5a<7Bc110(JbXLHUe+Deg4T[/ICVN[NN?A5?OUE>-97G-CSSL42SfN3KD4e=P
NZ3f,IW(5J\IF3Y:_cKO^K]9#<80/CS.OTXPfG(6NAgPO/f9Xb-1J&+1\O3N=YA4
?45L-_8b6,NTgB_3bD1^3&bNG6;7OLY[XK/WC(]>/8B(FKJVU,c0&U]6PMeU+1;P
/0P)SI[Yc?6&c[E-4&dB_RH7P0]:OJ1HXA-cDf;W7-3R@^)LK0KX(UTJ9?G^SFeI
:GT1D)A^^/_MSe0dM_M<^\ggL?f?bgVBYFeW<1YfD2G[B:L&EAWaY8H0cMXR>c\<
Ab4Z,8B;gD.J5-=NWSA@<NQ2#R7(OcQKb@(QO/)J^7L6S^#eGBV[6EU6f/Z#Df+G
f0efD7TJ<XCIc2KP?TNabf_#?WdW3;#aJY^fRHV([I3?9AE,[#LCUUgK+Z)M<,>^
PZf=@[fRUU34>IWW;FTH[H\WC+2].3-J;Y/ZXBIWK@PC]Ca4#[F/R);]#8La7-FL
RIV@(b=EAIV6KJOMBD,gHc4D7;a&_KG:/f0DR]&a?\f<@c6I)&Ieg;Z6THO_5aR2
4fC3_<V^_W36a:/@LPdb3d>U=1f><H)Q,c;&G:5IPDEC,dWC]6Q\a/F?VF9fWRY6
JW8)DL<B&Pe]/5A;UC[L.XY\QB5NfcJ(10AP_\N?9,C;H11NYC6]gM1e9MTCJU]:
ZYR:M(&?1S]]1#+8dT.@(-g\9Td1^Bf]FR[(eI<2L2KN)@/NF)ALWb:L&Z:7XE.a
+)VZ[/.1XMe@69]T]B0V8)3^YKHI0O^KWO_J14,2>82X<<3\FGe7]7S,;T2#,GU:
L#f.:e6:Q]B5[?D2Z>V\B)F_N2L5b6:\<]Wc00TdKSSJQ))D:.24KgIZ3+a@e(df
[P[FO/#(5ML2^?K^9?2NP0a\SZ6.^;\6^d^/NIT+.YHaL3A6KHH;Z48UJQ.;[2\B
b-C@P2UaVAc=f-9cOVgfMV+&-ZT2fFc0c=/)_LdV5^(L<0:Xe>Y1eHgW&9#cAST:
fa<:-LZD@T0]M225g8b1,Qag[a72G[O]M8XT5YN:I@J8+ZJ6gY;1E[D-LaJP.:A-
?[X^\)W39PcW7J(8Fe;?,(O06PIW3EQ;;&g0EYC5\ZUL4ZS>+0<>FIgB9QW>IS,;
G<@D^IU)eS3aX&SF>3g##Q9@_;e_BT[;gOgQC3caMf-C21?:QS,I@11a:DUH@2]Y
8Q9eNE=e63-.H,-T?Y5bT?b5,@<ZY68&e;P/40fe&9RDQLI<,,0d>D8]B]ZF^F:-
&_^:-b0.edTCL=&.D+Wf)L0W-8V^7:AG\[D;CYeb?6M&8UZ9cKaRF9-d5&bW:YGP
YU0dX(##Y5WH7WQ>/ERN&XSe4I^ISVV/;^RLUa,2^CbM_>U,4Z\E=#AZe(RJ<D8_
UH/PK=(V>aSQ_AA>HTa?&XD>IM;ZP[\34KEcVL4-bS[?_aPf_)KeRbEb.a&Q]>aQ
<G)210?7(N(H@.N;eN#:;>8(fFW>eC7I,/]a?.SM1YaK.88[L7HTSHLZ7/^c/FAF
(b=0A-?Sa._?R?HTJ;AA8)&If@(GV74C/6,.dI7KR:D:@D>>^A0SUgR+&3GbRVb7
<9T0fP\fBA2YZ5\)C8+c97=-f\1YZTZGb/bdELKD#D=QW&<YCW8&XG<:H(@b#3Hb
EWe:>-&)3WQd?..M>J[U?AOLD#5UZYF9#[>aLeSLT=G-#5_:A90IH-S\Ugg5Z^cU
&++USV;gU.J7Va+5;60EcXg:6dJ@Ze):X#H\S7\=F9@UCUM6eeN61+KRZ3dLRfY+
(FL.V[F</#I=Y>D6[T]4cC1(D:4.])c2#XM+&I\?<_>H92-.)0W3d&\4\01K__ZW
D#ZY1??.DcfMD(f>Q1R&<D#[NKd^9>(+C=;fYXIOOF&X/L9+00M7f?(FPB\<@:.Y
643>:ISEV??c43:g-[3+F>]]dYbD;,ed12GQU:\_:_X0dS.fP]:eI0T@8>JNdLg-
7-LYXW@;eJN;[<W2EXVUdPYW\9VWcRBOA[[aH)R#JL<=.[1Q[SBf2ZWA>+^4RC)V
/.L-Rd5OG1-,YZd4e@@BKa5BbX7338-W:[N7]J]82.,d;Kb(64V]RX>ZV5)VgN@c
N:e<-4<Q8X,B@dB;P8AN@B+b#(K/bGPV(4gE#Mg9b[L>a57-W7_8Zg)P5?=ZL(WF
YK5CC:0J59Z,G55EB;);Wa2]Z+.YFa,>WD0OOG8,Z4QIF+eWLDLdOGG.KR:<f.e9
-::\=e6e<#bSD;DFWF]RHL+#W8;;30<RAGGfR+M4#QfDd;TUJ(8La\-L7e)WSd,:
b[:ELaB#D5TZ??..9YaCa\JF1a5H;Z)=GL9Jb_VN8M7YHgN;>U5^-]+1X>J[B5@H
>[H_e]3VVaIWRMB#fWdS1B@EMHONC2UZJ^G?3TGBfLbe+=H?8.f[QFdXU6g#-KOA
fIZ-8VJ9?F81WKaN50<6R[MPM<Y,<N^a3[#/6LRB=Mg;cg,Y7).IZ@,L4PE7I:f[
d26@e6dgd<=#W#-<6T:/E8EYe-:1g1L=F409:=#+6_XUBV4-NcQb5\U)VQF-D&4C
)DT2TOb#PgAgLKI@ICc[1=;a^C#gAHF0_,40d)cRVc+&^Ae0]DfSO@ZI5I.,,P,e
a-4TcESDTKQ99-Q,F(/Kg?3?:8-U;=L#_=GQe0X[Kg:D;<:dCbU]U@&PBb)>DJL+
5Z-U\#4)LW5ZXU;8FPd5?f\PMJ;Z1H,CF].+L;F.:9U-?2.->WT9a23LYX</VW-U
&<:LCK))7Ma]g8d5@ZcH2O768Fg4+NX,gONcND_TI]W4PMUUHKF+8,-)/[a#=V<C
_:M;@.c)T#eX5_U3O;c3QW@f.^dRM)1\a3E=BVI^NV(1^5IJ@^FWc]0^BE\DL?0H
S]eP3.WGaW3ac/7,RTT3AVNTW?838;TZ.Z1Z?Ng@SRPg(GI>N-R\@^9-+gB0SZYc
A3.KHT3Q8-6_C2?5>;U@N#1TC6acTEa^8g<PZCN]N5aBA@T,5:=(IPIEZb)X:/OR
K@DI(@I7M+(M;1)DQ.aO.(I+[R7(D\,UGWRF3#=L3\9AL&eJT8H7N:MF6f?R1>DU
;G_V_cT05X@Db36QfRf<(^-f+NE(.&7Q#afTH).TaMScG_()0WP\@S_+DGgN<^&;
]I2=Z#IW)Z(LKE:0XS2/A<=GZSO#@1b&?HHB;C)Z=[bJcW;Z>@K_\_B+F/@XC]XQ
L7FA:?)N6Sd&P34-VO#g/UP9:R,@IW@SBAPWd5H6Z/--YO?BCe?8DgeA0dg2SS@T
]CMbWA^[)1):@-=^D,#)8R9JFA,d37HeQ;df:V,E43.Ug.\JM7cMF5R)TS5;;Ba#
6R==[,RRU=A]0\-9-Jd[f@#f0](Y_J/W5K46D/_RL7+>f#AD]4Nc//\CD3[Q/RK+
X&8896[FM.[SCTRd;J?c@<D>GXOMfSFgb#YYW78^4[O-K7:Qa>f-g\9]_O,ZfJ5G
LHCc??G96F&;g8\RLY]=d;&B[BLXY/>=A2gObL?M#SM,T(#&MGBVY@6P>7Rb=XLc
Q1K_ZK,37U;D2AgNZ6D3R5eN2C_#00]L5gKJWg4Z>?d(cL0>_Z_JDOG[9#.a>C7.
7[C6d]/)[]K)5=OVXceg9S4LY6@FeK[@&bg9_Se^a+)[4BG:c6=O2V7.KU^+K5Sa
S]0))d6_R;A>^\e=TU+_MEKZJGO3GM>Q/LGGb:7f8K^8\>a4.P3LNXaRPKLUUS+0
0EV&TH-^YA1N[BBD957)@RJIS\d]\&05T@DMO4);N]aEJUd=V]BDV/Z41e7+=BR^
)C<XaD:G9IG/4;)&0,<&6Z#:SLWE+\AR:N#;S>TG\f/MWDf-a?AO1&g4(57S(bSW
,YIS9,HSP-70;&9RWBf9g02?LB,W[b2GP@Mf+,gV^\\[\#ZQ+E:68-5OJaHXA@X(
M7H-Hb?539a,fAQ]+2S\GA)T=A]g?J,)\\4d=6FV5C/N_f/_@7&R<+Dc@HbQ=6GB
S+Xe7M17HgYZ@2374?gYRg?K5]O,D5^f2_0/,?;P>._5B?DRA2V:e(b8_B[2MTe)
Q>d\:5Ag)g)@QgW8>8WcD7P]?HaU4VdVR2XfeS2<Sa.T1SOaLdO\O8=5KJeN+(Q]
#W&S77M8)cFg]IZ99cONVCO6CgbNcS[><\X>d1S&:-XQW>FRWDG)D1T>V9&S;M;c
>06a/[QXT-.QAcWd5a17+,Y)[F@XA_L+6CO5Q:_PFFP4Xae,:LXX#J7,)[==0M6W
a8MDKSN(^R9O0N>c+=#[XgXd&SWZ;9GC<&TUa>\N8d=M,JgfG&?cWYZNfQXK^9ZJ
7g]eIW](I[@Da3Q?fdJ+@:D1dfI:7FN,U;_J/B7\-5+6A?N<TMF#J.^e[1MC[-H=
K#(.]9-K_Uc\8,]O//Ve/EDGC6>2_87aIgeA\[O<9:R=83GZCR/D<A4Ic__N>D0<
W[9\a>b5fX&Z?1O<,a[A0B62cO6.59ZJX[a<c@Y>.68MAJ+:WU^N<GB<CT#bQE]8
/Z?A@CP,-g&D_b91YFTT.B]XHB-13d@dLIa8RO5R]^Td.]8^NHF[f3?N/+DJ1(.7
_,ATQd.IECZ185W@#>e4Y@X#C_:I,\4?>&0IcMWSSU(_.5^>B83f:G#5CH4a/P_@
LE(7R_eT]d328bDA)YLHXY[c2M4TQPNLP>OF0@U?4#Z)NdbgW5D7;D/Q4U9URH7-
(a4dGYYB&DIATI8.ZYQdSEg,EeOA&SEEYf)dR_Ag<_2U4)O>1X#F]#5RcG,-X,8g
4-I78@+F=_^@#&>f[@;fg]&[0VLHbgR@&R/9QU.[7;>a[T0F&U\NNE90Q,)]62CG
,)d;O>Q;LAD/g:FAHP,LOf:9<O);Q#Xc]BbfQ=47TE#BVfB:eW:]WV[FIg_aDI^W
e(JQ&;@DO+_d2]J;REg03T3W2ga1Z+5IId(.]4(fUdc(6EVcKT]F7>ABY&S?-f=Q
S(P?_g^84QXF3==6cJ/W,IaFP/FJ[b]&#:f9M2MUV._([>QbW.LTNFRHWPa?S)cE
1[T8IS=:Ibcg;=9,S-W>EO=KbL6:aJ5[8fM-9FW;-1GLc4JYTGG&fC2X=4(YZ#CW
(acW5+99RPe.+O5L[Efd).Q0.QT#gOKFe-cM),gNYJ#<P0@c_-9B?K?_[EA[BbNF
3E;;4Q,eFSEEbAIa[MMASE)bCA;\RAULg/f:F:,#I3dc>)H6V(6ID6,[?3E]KR&-
d.U=#NOHFG#B;M@Z<E_#<27HQR#D812f2K,=#+b4V/A/8A?LA\EP&OTVR9)>V)U8
O7VP0.O;C#]2/BB3>]SDdL;SH@W<,gXD@_]+UL?]AG+1K38G9?PO4M?NJE/g&HB=
+6WR>gZ/f=-Q.0LLFB=;Vf,C8X)g6]+^Z12_=2L554TUW:\]8d#U\a0>,N/+@[49
BgBXV<;G]&>L_T(9HLOHN5eK\gPE^UEZYbG,K[WdPY^M7:9DI4eB0SQ_,[M\gKe1
3\@?fN6g5+9HCT]f&Yb@KR]JC8cHe<=1[MQJ_T?AQUJW5D]-N9[D_SI@4fFH.8D3
BWX=^B);Gf:L7_f\IK[d\8f?52CeX??^?B/GFRM^M5\@[AR.YEdE[;^TN5^A]WK4
NERA?@6>PYP<X7f[e#^H1GfY)4/IAaN#>H<B#Ld9KQC9/#fMJ](&@>&/&S)-K_[Y
SXPZ<^aa((6O#dAK5g.GA6F)GD]b#S&.\609Z06Z0?J&_0U3]-Q3@aS<.SJ=<_Wc
X?;KQYfW.[&KcDU#RDC)0B)Pbf8++XKDKceP_4eWOQLDYg[?^S<32216.A;78U28
4VU8BL0<Q[<IcZ&cE7:TQfUG+)WdFBYULHc9\,G4=W-e^U^bE^^<,>PP3R[6gTa#
Y2J:.SW:Bf+,D0+D;K4V>=([E=(+C=SLOIfRHU=]e7P>Y@M]Tf8.B3[[(<5f?UOR
I0B\aXK8acT7;QFGACTE7O+_XAOO>-PafbfA:S>,58R=f>FJO>.^Zf95&X(+;G^D
Ie@AZZT5WCVN6Z4CP-WXBH/<;f;g=&0PSX]3V=MB)MZ3I04S6J[MHPXb-^:9;IC/
#,c9@+g>b_UfW^Q2REG(V?H>Le5R8()&+>I8DK1GA[HKMA0PNO_55,NA5JBEeTeS
+L\R4gL1GKO-dTF_PXeC]&5XWT;^8BCJ[&^L]g-#71O8O7S+TM,^A4;AH8SQR0SA
G8;@f0:0NYf6f2>[RJ?Pb=FKK\gQM=TDeL+f#P8S/NP)e=)US)bMB<OH6O)GJaF-
PU&7faK8@e9>9^E>[U:Xd+ZN^81B:5QL:)=cFD0_Z_Ab#L[P?J8(L^4)P<<KaGZ2
b@F-UKNCPO0@UPdD3)eYD8Rg&GUSDd)=O0b/2K?6f5LJ>-fN49e\0>4<BCX.W;9,
/1dP,8>OP7EURM&U0@<X^D[0=RU_[-?aW]@TYMMb0(7S3.]M?DYaC?@)f&/2A9g6
^N,+67BD2cYC.X1HK[cg5.PX]<DSgY7&#_Y&a7W@g[MXE0_D,RW8:b@9D8M;Y<NV
VKT>^\K\NeQE7IG-TK>4AT3365I3Y7(K:Z6<a.]fA;3da+]dTag=[]OYJUYU;>+N
We]I[L[LNU3P@+KYROY)P,8A?7N;aK[CQL>6D2g+V0f8U]&@+E0Dbg&0=MQ4gED]
=:RCT@\:b&P7/#2:F(,@4Pf[EXTO:S>;=MSUK0?&g4S/^0:GK4GI,/2Ke]5,)89H
0.JDQH_K9Z\9<c,J63Hgc[+G+JLVF&a:)+c4V=.@2NL9X1Hb7>RO^/bASS9[\(Vg
@=S8C(:9Iad<Leb)&/H\SK\?8266Y4U6F<HKcgS+GNU2[V=O)7DBae^eY\HUf,gZ
EAC9e)=;cD&AQXKTSdVOU7PQ)9J>7)8g73T9E17D?<LEcJ@R>YK==Ace8M^:+/e4
2<C,F&TZ41aCKJ)D?2G7LDO..aDKZ+]M&DUJ_?PD,C,N\Ga1UNcG-P>PND;:+1\>
XDaKb=8[\)5U[3g;W9gBOP]@?<(d0L6T>/01\gNB,73e5+7FM6[N3d9F]O#HdP_2
+U^FU[1+XI;BaS+g_>G1g2FT.+c5fb4#I]&V,Q@K8VR903gE@C1?.2M93SA(V&K,
--bUMdWEO,RM)cV^+VA;c[LK,NG@-f<#U2QWC.+-fb6YePf:VQ#S)>H+#[?f>gDY
g;\VD6)0V&;bdL49Q<0;5Y7FY,<G7(+Q80CU626=KP.A;D^H+I(A2]69IQ@\#68/
OCDI.:4bPRW/+M^g+0.7[Z3>2EO+cgbPG6U,f][[PYWKF_8RA>WVR>V(EVZXaeFW
aUITUGL1=VXEFLXf;.-T]c1RVCPbAgY(/HcWgKc397CR2_dcF<JEB7aQH4WC[PJ#
^]D\1RK/5FR+_PHRYdRZ]HEA,[X^>Q+:7]#2Z\+#H&ETEJAebfR9.\7/J/+a1f?7
890P4PGWPYf75Kg=1^+NG.RDY/_g+]W5Ig39fgeDTLUAH#bLYMP=+;I1MTXTg?EA
^IB?gI\6:@(_V#2.E+K71U_Q]PCb&)4ZXZ3LFg5a3X:+E7@Bg<)e8d22TOF(7:.1
^07WLC/)P]c=\?NZI[6@>NVAcb/RRS@KUd(Z(4:5]O840S1Rd@5EL^.F;<1ZMG(-
7-c@[WY\6cC1aM,NKGF6XbgT:-QYGdeYeMdBB:RD#\?:S7geYNTE^F<[Ue4[4cW5
Q;SREK@(=+Q&Od+&\XQ3_,OSZR?4/bMO\ceLR=Ag:@R1AC4@<Oa_PeX^NbRUDeU\
I9MSQ+<:;^&,TKF)d=+DQ;gHT>0RcN=-QVUF3Q(5=[^a<(;5NN6+^M7[1;@40WU<
&c@OQb\P-,X6Z7M-BcfT6A-YQE1TTBQT(YWSK&3b1;J+D1(F92O7Q1(e=,G3Tb[d
FXCL(Y?:Hb<?B;3#-:.4JDTFKYLV[Be//41@2RC0fO/eV735_ERaaU,920>E\&:)
P4A6OJYSP=TWP3AHag&/0Xg&GH(IT?B4?D9:UGg,L9+?;8[6MI?QZGDQS,>A]YGT
g:BL>4=Ug;c.P[#W;K=7FG=SP;RFHOX2-Jc<^Z_F>]7E=+DU-f7d(>ARaU(7]JG2
E-^/b3RKE+I6TV\XI21HMdg1A,6]=?U,.>I^0+ZBfD,H_--e3a=RAVE@XEU(T+bB
U_M@JWI^1>(,BcN/<L>?\aPQB6PB)Qg(N4WOJf1.:Xf&TZ1>QW[,]HA/&\eOI)\&
e]HG\f^W\&C])]QMA[/-3:<LdE]452,;(.X,U6aTfU9[-Q?^ESMV70(LA,PfA6a;
EAA/U2Z]9bFT/34(5_+BdD6^\af4>VC@0YSB?gJ,_77V/@D)Y9Q:QCT<N#DZMOEY
@>a&,geX:XTE0C]@@2/D5MAYg@3?5AbB^cJ=1<OQWO\bQW4\2_;Q)2&eA]FDNFAD
f:E29@QAHF9UX[TG(5>RLH99e2/;a^GaWa33TA,bg+E</?]dLK;@=+E_2=JTg[6N
bIQ<F)I(><6I3?C?=-0ON86-a_V>]4/a;Bd<)&UST^E6&+97BFdC/d_P[gdV.JZI
#b>^E6L,1Q\YM[X2EMOMN++0^+_:3A8a7P0,[N?2CK\c5T:_^&9NS>/0A+8Q(,ZA
1Zfc-EFa9V9#9M)4AVHK&T-;/S^>&deM>36]c)\]0CSdB&B1Z)aDL-c]5c+>_TN>
)OX??Igf550F6H9L:U_J69dI8PEB8XI;PJLG)DTB0<LB+XY49=BbDBe<0[UX_#W/
DP\0W\2H&[WU(#Y9_Y<&dME\5d,^-Wb+C7GRdD0B#8(Z^[>U]H;+#\V@[N4)6g_Q
UY=0+11^P<L)V+W9]7?TUX[JJDW?e7bBK_UV(V,_d?XJ/H#(3Y/6>R7XH?D)\43A
XYb(1@fFQT]N^7^07H.?2V+dV^&_F4PJ=JaPe.5)U9@ZMG(C)C/e3V^bgR.#N/e(
7&fD&RZ:U.T(H:DVHKOPKaaMgM/2M>AOd\NPHK_(^^UA,4=A27/GIeR&72K5?Q1>
A(3R<;.fFO((2TVcGEg<8L8,b;2M5>cg3X1CGYW@D>LK(WX_RWA#\9+<@DK[eF-<
b6G&?\ZPbJ[MLJb+@;:S;^E:ME9K2F494^Fg81a4],1ZF-#54(Q0(P^V4dL(H>Pe
R1+ND\TZeTSTBB,bL4d2dR-=WP+&g6<Q5^PbJ9]]>NESFg-K6R\,]WVSAP&J1=&D
5O_L#Y9f;795,f#2PE+M8Tg(+WdNWcYe]R3O/F4;@dW(02?_2JL_>RFSFBe^[E@^
=g^gON\^_\0A#5KY49XQVAcKdbOQU[^BI<DHY6LOa@33c]DUV??(eB:G]-)@c4E?
.<_PK1a>dP6Q=[Qd\H??QKC[PM.J+AB_B<+Z,:2T^G_Jb1W1c[,01KXS(bG(V)49
=ebB==8;>f?bQ57+X+fc?Q]0[:PGbd6fgeC9K,YE<<Vb]Ve\+VOX,g\<XW3RLPbJ
&eK7J/R@a.V84Z3g5]]Sa1(SQ>@M@QC9X84;bZ,:+1:GT^d7,aFdZ?c4Q:bKIZOT
?NB=RN6.UT]_;B\#8G<BWJKA6<.T&_W@0_cN5I[QG@@08VW1#fT(F_/28XgM[MdK
PQU,Q[,>G7fUWLL2c30<:H1S;#GE&H-XY0#bS2_APMb;9U?a\d:cH_#A(G[aO[1F
JM7eC>W<KBD^]ZVMA8=\bNO21)^B?YY^EVHB;HOHF.A&VWA55ccLB\[[<^QcNFN8
F]E5@I&;(8#GfbGP][ATD3.AC/I)Kb;6#7/217=Cc4?+(TTUBY6YD5,&Gc[bXPY-
+/0D7CGe>=Y,U=5)^H@J4A@?0aL?52^;Z5C&-A\RCEZcUQGe]8a1=1X^8+<[S@;e
c6:G+cTK/[^5b[,&Q3ED8b77YD<(Ug5Z=WQb.-H5KJP3IY\gQL6MA?fNfS6W^+B^
-]SBN77c9GIXX7E9]\gF+bYE8F7=]?-@\D8e[H[NJKK6CGGR70]E&;K[&/<4<d1S
5d7[F(R.-_J^BA&\G@Dcb6FO/#:/3TV:f;3\+-a6aeKOMN4-&eH0&,Pb,0E2P(G(
Cd,0Q6K:Je.fEH+&C),eOUO(g=&XHI4#9-G+L0K22ITC.8d^QQG7-@XOT,+4R:/7
Qb7&^KfQYLDAG@2fd+)4MZM#^(b/6bcVW=CTe,S/.6gKX@(VB(DLUgN7Te0DVP,9
+/4Hb#,4ZWYFf=V?CI[KSdA9+):4OVb0dF79f:S0/GeZdRf>=09Q04[;-/.+NHZ,
AO88+B>M@GeaLJ><f5Q7aaOW<L#2,S>.VH-VQK>@P_e<@Q2e#B;IQ:3(1\2>I6LM
W->51)Z./d+MAS]:N6\GA.&e^5-YQX#c2g2OAe]2ISCB]NYB&3U+Mca>>6Z7CDE4
Lg3DKFL_8]=]GG5T&35MYE&PZ.N^@VSX103I?5746(0^-\+W<c:72_HTNUH2>L]2
(T(I.ZKW(LZ[<&f),S714[M(IP#;\=VV8gYLH;I:(7Y;6:gda18DQC-NU0P8CVQW
C>]QCU.D+&QgZL-EE+<29O(ADa,b[]:H04;2Q=NI)6a2cJ0XCc8E3SNY=eK<T.DV
Nf&-+f9A@XJ?P6Q[&?=BOVOQ(\@)1K\<Jc>)BH:73Y/>Dde-ca=Lb[<;8PG:P_@#
3cWeIM8Le9d]3>@76.U+0+g(-,3(?8NDaV#]Z(G+GY_&B?)Q#@3\M9_:^KR/FL-]
Q:4f6VZ?ZHLME:MAfOSIb<bAH?G1TN;Ac2-f:\Tf8I9?Q)<Ce6TUZ<e#I2;:aR2M
_H)[.Od^ENdK]We[R#)\UOe<AW_#ZS>QHYRZVG+X9&6UbYH@?;Gg6?1?fe:W&X6@
KO0(Ic,CE/PMO[3R;:e5J\1C@B0OdMN,LSYA1/\6dGLJ=GC&\8.#0#W4dVPa0K4+
ZLARW=]XHJ+?[9]d?LXR)OVa>N+>_+(\VEg)Qd3a/\McG44CRH&Y?d:,MPa&dQ)E
5;4=@Cge^33PR>5AQPe<+NdJeJ?CKGKLHO\TJ&Y_@(^,LggeXY0573[\X)O0_QU3
dd\U66=8JJ,1JM&ZCL<CG=:I>Z0MY,g+gOOYHZSLbaY@]==ASC&-V090+=0[=YVD
-\I:LTJ+fNSfWJ&U--Ye>eW-=0E\-4f4MALEXdC6<9TdcK;B8X5.e@^5/6Y1,BN1
g]SZTW\]@ZWHY;GX;IU7\-#a8L_d+IX0<L@233Q[J^^8Oa-2gS(MCe:SgZ/\5CH)
FaXdMBV<5.D8R]#Q&7gJ>(M?X72=]1c,.=@-3+Xf1ZD/=#0U)DS2eF54O72)56\2
5WALABBW&G/;aT;M>E45)YLB]aHAS98Yfc&@_[/:&McL8bSO:03-&.Dc5f4I7DKW
EWI;gcTN8MOAC12Xd23^a;Q23bV8[g-Wd54ZBe5;KBAO_.\^Dg/13TY<4Xf:Ide.
c,L+<4=.CQNM>E&I7Q:#O#>1a6&gfUJZe_J[[;7WVZ#NN<)[;f-:+Qb\<+.@6@:<
>2S8/:>dfQ.EPA,(LOK=/Y]@S@/QAJT9<D2YB(J6_U\]9e\UO[<D91+GEHWTTUdK
Q>:6?&=,B07JWW0:&:Q[O]WXM_O9W)SHJM@&E);<ZB)._LKL)>P-VS<Y3Bg5T@P^
[@#-LHMM+@]4aE7V.39ZVAg9a\3;8N>@NL+-9/5DQ;@W^O]@19749M17YY@?.FXL
>eM+3O,@da&.TUc/8UCB,V0FdIVC]CPQ)eBP=c(gMbA+84=a.(7-IeeBXAd&KbM]
-<)OT.UZMO3DQI7DG@8F,;SK8P@MS-JPN^TFQNF-I1X_11O_N^Z6Ra,Zb4+ZGJT>
c_9)@aSD2J=77MO(]fP08b,#aBY5WU(?.@3PCKgGX7D6gc&KeW\bb?O>B7E[)+8Q
d)[G909VL[,]KL@)D1,;eUR@NgD.@L_H<9G:T2YI4N41I([(YF[>KTLDX.#I^BIa
2O?Uc..)gTOUg[K=KH>OW]B07Z.+O[>2&D:-eaW0SU&;^7a?A2JgKQ8[R\,O9J.X
PH4RN5TJYbRH0VJ[(Nab=>@?)]SVPbf2)6Y(0)&U9.c:PHbgPg)C>Gd6@F(&P(F8
0D0d+&<85^MH+B577#cf/&:3a;1dUe<^fM77SND&LNUTL0R+cW&2>@aSQ@LOI=M\
5F)ZHc^ac5NIJB)THL5.dRO)1S+NN?V._[M)N-cP_dFDdGB\X[JSU/RW=PbN)ENW
BKZ.R#MM/V[\AGH_B2YF,7OLcIV>Bg2EJ-?b(H:7#C\E20J>+Q<#Z8bA5=W<<H<:
ZF?&@a:#)Z&(d^EKA@5B4DPB3g2c.-dD@.L;ANOD[>[L9J)QYfbNXWM3BUd.,7Aa
^a-GV-7=-cb[CZ4K<5fb8?LBeA)1XZPM=+S]8Q0d)L0R>AUee8\.#Q+2d;I<H61?
XX#R?eKfIg0.,1gReR,0CBd:1Md+P61;/@B+&2XZPMZM=bOE+OF>ZM1,M)RBL6HX
F,0VPfG]8cX:O&7<I,L9V3=7LBMK+05@>.-Q+&V:KR.GH\:XDP/EcWe=CcgGO#=]
Kd&YE1AF>c,2KCdB_[&CD3f3ZCA<c0,1c#3He3?AIg9PM8XZDYY.:Q[>W_8W1_&2
F;E/F[>dXQESFGGW_gS4(2IG[aDNc?aAYVN@QJXc\VMPPI1Y1f_&IR-)<:beD0[.
6VAHJJDYLZD45fZX\OIV[PO<[d.c/=9+;NX4T>Q]U[J2ZBDJ1TMW)G+7&(+ET4-K
389dSQ0M/\G9H9;E>,Q#YN7f.L\ZT.KE__XT8;L^46IQ2O5(0SI@/5E(JL#OP&g,
=PbGZ)G.2Za93RfQ2+M2DSGT[P)W\47MKd178JC+(D[[DB->R9DWC1Rb]/NZ^RP9
HIeAO_+=WD[IJVZ0La3C1\Jg\2:),Tg,2QJ5@#XM[g?We5RJB[:)/9VGc1?9OQ5A
?XUd[321&4KQ2=dSg8:#Y/]bOJ9CVIM2d]>4He/f7/-;0.L5fYP[17&Bf7]7I#Y5
(&\LW@4PT]6=Ia6cK1+-Lf7U>#g#_9@,71Nf,b9EQF6V5S?CTIQ91ONBd6e9^2G,
#ZOVHS],UT74,?&IZT;fG>[V,M8447;<BZ=L:EXTB^KHe2NHV)3IN=YcO-#g7MN6
EX.(@.eA6[Ea>Q6O1TWTH-dJTA;7RYZ]e1NWKRVKYIA4O=Lf[&7PXN=[cR/?G#-U
eHRB(a)P.G:0Z9@D7OU=M-D_@#0VW5PDe5aCP=_?PYI9f/=24U2D0/Td1=0;L0NZ
beER1bT\ITC;_9QgN&E)P:(Y+;dQ\/PW2WL9M,T&Y(Y-g(aH6_DM>J;,\a]<)0(e
cOB)dKX/V(OP/5I4c&NL+@P#B2N.Bcc\WSE?)6EI2CG)?&:-R/FMO[XN57-0JU.H
[^_C-VgH,)>3Nd-LNUAD\&N]&@ab#5XT+Ydd86D[Ad)LWTS5d^aWUVZV[TNZLaKD
1:?.53:X2\_RRcR/IR<<MWYbPRZ2B[>H(F#^2L9d/F)1Y.&/\?JPbM96-;095Ac,
_(?X_dPeUe1JQa;;dUF)F=CDF<gUc4/FP;I(/PSYV<2F9\F4\;<6J;?ZV8&::<G:
E-9BFaCRN.7_8C1\E8(_Q@SY8BZdT4NaJ@g1)8VUe./0J,b;3)Fa=f7I0cVg>)2U
.#:e;eBF_b(<b]8)5g:6d4NQ6(Gb7f)DDD:)/[c\#M3d&,V[3YS^JaZB4@Y?JZYP
H43cX\@B?]V;/9cb-e[D4UONBF4f/Y/G0ZHNW,cBHQ;Td.1S]Pf:A3A<N?QIRJ4.
,@:,g-6:@4Se0U\HXeI^)JL1_LZSTO<Z;(C^?4]ed,V2aKbPS#BC[1MXP<M]5Ub[
;@C@/0W?636)]dSbE).,f9:a,RZT@P1Y\VG=(D\_>d7,^RG;OMZXE7bb#bA[=2V9
.8a?gaaW,6T=\RIZ.]YW#TMU7ea>Z4_8<8YND5dLY6M3(2e03&QMb(f1T1.f\g33
eW0cJ-eM+@WSUCcYTSE=<^P70baK0U+ggMU4AV6DeTH.G]L<;>B;=Z4\,#U7c^dc
8OM\.BFb^@\6H(O,W6W&fNDI<+\fVYJT>Me;^IM+2K2>LR1R8H8DYFB(Z_5.6BID
0>[>J,_8^?Y33eSH0A91-=(Ac/(aF6O2BITfb1S&6,TMg.:JI(]20fXe@U:DGa)Y
/S-F#cE6c>OE+[;dKC]S/dP+4<gOJ>VW)?WNEETAWP7P#U<b=->5SY7H@@/0Zcg<
);0,fSO4FcPbU=-NOT&U[:8O#<[25^6cFAC8PA-.Z:#JU[S[a-YTfPT9I4L5AW4e
<\)\cZDCb+e[,Y=6SW//W+[P&R[2R/>O@8#NF1G(C57ZQg;9T&B_8#PAO87NZ]X<
@;WDbT.;(9<9<J8H/CgfB_JNQ:EN@;+PaJ/;Ec3XBHg)@O)<)+]LV06U@4O@-P8F
SLQH_)^42ER)d<gT7@YHR<:)^aGL:bY)B_@ZX4N7Bb+ggV+b3ES5fW3;&e7.422A
P(Uf;=OWHY_F<P3PDT<<NO^A];Jdc;><b3R[#bMb]a>2Eg=7EaLI\YU3@b./^AVU
+X]Q>.Q/S(91UcPG?[GgC)OUB-2>97YVJH8>;[2@/N<+N_EdUMEKSS(<O[>XC=Sd
/Z6.b18F3BId3/J)BDDH=L=fS4^@I,LKgU12STdA=N\D46KJ?SfJ=+ZJ4#K/-LgA
R,(G=N:)L(F.]5?#gf?0d,.5X/&+JLc9G#eTT/A)DD:gbJH2?-<^S,N23+;H:,21
]QUWP:_d1\KI;._A=F)M_3:(bVV@L)?WJ__)DNH=^<8<<cD;<cg:c1C<+G1:R>d&
ZE_\3)E-#f@2&)c3;.bQ4dXGOP:0\S2gQWf)BI-+B>7S[I^<;ZNV)bg/,ZKg)?S7
STT@8LVX5_(S?6UYS/f<Z;L;L3/HEK3LSF56fF0.UM..aQECW7@P;7d&(0VJ-/f?
KT:0(MST)GS2=7MO03C@6Y=(IgQ6b^RQ,+2,&BeXQD=VGYa,0[W=[;e9fWKGF)<b
Og=:[Rd_Pa##1>#151+/&bR7O.D]/LH/KD^[Jf#1#@\P)@7;(]IN+3.HKK^U2WUA
]+<WZ)B5UG5>R_dRDE,g3PGL5RMg[8LN)]MOf6d583(>4CFODFW[-G?gf>?6bZ)V
R<9JI^6b]C7ZTEgd.5<EG=&(.d@4^+_ND^.FMdDHab@=\K+NU7VNS-]7<N]VD89I
c8?e4\aa48N?#\8VaL[6:X^@89:)7SN+M[&f:fDF2.V?9QaJ+FFAA.7=C67&1ELU
,CcJBIV;bC&<Z:I5.GQC33T;CG\]X#Y^KY;HRc5&?TV4b_bT624S-Nb/JO?)G0#J
)\J]GPf=QcTgPW]DMN]1[SF?M:7]S\M[Q90CR[52V8aK9=BH6W8f?K9,+.;[0E&K
8+\48P9/gbAc)=Qg\X^YZ@>OG4e2&b#)Ff.TZ\85A.aG9=TQ^KC:e99.gBfAeb,V
;M3[fM:?12+35S164TW,I&<YKfN3U14>)@0W0Wa7.ZA@-M+BXWHS;fME7W^[Lg(f
#b8Xb?#EIC9#?bVDJOA_-9,V:#^QL5WTDR<\ZKVD2)\U]-0+a8+RY;VV3]#]HG)G
FWEg;_E[7ef3P-UJDYNVf^5U>1XW,./:YefDcIX==:UV\f=S.cYc##5DCJ?6fF_O
4UVJ#K.;JUg=?Bg@\[dO9PH@K<4B@9(7?HX0RRA;MZ>0-K/f[3Ce\_7&7T71W1BA
Y?gLFccV7\c:JFJ#+2;K46/0c7M,6a#e;J7?1E8fPMIbLcA<6U=4SSP:aCg_Vbf9
@]G-Q)+:/ESD8O@a=IEJ2c:@6N5a278V<#[8cY39)L1N@J/NFSI7G.QDJN<(N\Ea
,/0T)cGRZ3LJ^;a;VB-I#F\_#AD4bF;9ScBJ/GY2RXe:J/_b:7A6XY)4PO_f+1DW
/a=9(M^;6;f0AF9aD&0.N\A9EHa7Q7C3P#[7Z)+F^W[W@CGV]W#MA=4,ML8Y9(QC
<TNSbE.^+1].5,XS?#)K1DfW)T8dP&MKIKg\XH4QQNS6+6V)&NcJ/33&AM^X]@I,
=L&^S3\1250M3&N&/aUEL\/[:K8X4V]M(6R1C##-G:1b5)O#F3I9CR;0Gc.\]f8E
5O,9<T:5K&VKD&>VP8M4\&-2RY\/]XXL9+X]@L9?W(__Ka883]U#52;[WL0EVV<Z
&2K,O2;AO=aFb?W(IE.P<C/4;PNH.2g\KNDP+7BdDICf?;I\ZG_cG[DaH_SZ/13A
ceR=/;N#Z;^Q?<&V)gB\HSKg(GCK49-6XJbG57IOT30(W.CB#O9\IEMW2VD#0[AE
4/Cc[::?1=J<UGI:4(8b<+<#:4DAcQI]fTJK+EbB/^.\0T1De9]B/ffL3<YVDd#/
eKMT1DQ.P&)?;\<69<L(gUcZ+U[TRJ?..&)MFYVS6&I0\c(=E>ef[>,OQ?+eN6a,
@F]fa-,7QE:a[ePYJ\@E^Y6_ec@9ST&5=dDR?=JU=&c/,P0#ZNQ7DHG2D13]F\;=
0H<7R<IB<Y?_OAFe?[WHBee21E8G0dLgAZ=/fXHbM_))eUa\3d5gPS@dO^1\1LX<
?4WL5b&VMS^82\E<?^FH=4,fPgR9c3D<e/Y+-2)6)EL/>EN<bEI;]=+a/+X_cLfR
?Z6/O,<)#1<U7]BH9EDH0\23bPEB<.C=9J87Aa\L:KgW@RM+EUU7@QD]4)Jd@]VP
&0HXUTF19e2FH9Q/CY43N_(4&R3K]b:PdZ2RWQ4SQe5(8O1E)Y:-)^+e;QRdGU?7
FK,1<P0.KWV-8ZR-JU7H)HGHaF3aOf.T525EJOHdV&^Z,;>F&D](cZ_@B@;5>>2]
F\:fP>>LZZ^^I93(L8bfY.UgD<[15S:b1bGTR-#U0.)_<;@)+Tc>-\B)[d:IRb_E
LJX2:6aFV&S6\eWK<+XZ1KRe1YR_JfR[ZP\ED[\1(A\BG(1@]JK<f,483L(BKD.S
P447;&GO_.UH.:JAKSX;\gI=gRH(cSS2M3IdF\b<,IC30B62>[<1>;/eV,:72cc6
AV(.34DK+WcGX&A=_[<</J@b/PITd#SML^18d6]X(P6:QB8@^J&2M+K@KE:.O0P<
c<CH[67g36=9>_)I5@VJfEZCG#[P61/cJQCD+>)>H;X:<O+gFS>L_Y5=g)LVWD;.
=e#dZVB;N#V0KD^\;\0FY4\W[N5(SR9>a&LL?gb/I?\#2[a1-6SE(.O_T9_D>4_X
.SE&OX2DbPAc:3,2K=&-F5gHJ?70#YG[&gc4AQO]FKJ:ICE_B3B/(ZDN.JK3OK/g
fO2cI+.a>]44d+UH;]6>D_edU1Y_HeLK\dHYB:GdIBS9HS.W5:WLLE0?#Pb?U]>Z
=G&Y?O8]YXO)=?>A=Ug=[d:@WIVQX#B,SXG,(K:XCE\f>\/fOW9Le?bP.\]OZR6T
=)A@dc#SYcaW^c8S\&QD:Y5POg.C.;?-;=@\7KBXCa+\(FFVc(3.UX\R^:g&b9eE
4OaP1eaG=gN?#KaMZ7fcY4RXYUD?.#>Fa62eeK)e9BCQgE&H3RA)P.BML1Ia86?2
fC&@&OT0Q=<TXA<0ZE6B4^3>2ZE294C7FZK3<0[CMK2WI,I-)WX-_<L7BZV)9XdP
&FJNBX_^Q:>ca&[]b,QR.G#O0(O1W?,J3X/W8g42\+96/#LeAWdQ\FdV#NA,)6SM
&ga>SYQRX275XC\fc:Q&DGgb=3[]F,)0(C<dDCe7f;?P:#X6UP#Z_E4,J.&aI7<9
bDD+b=cLGR[=.SEdQ()OJadCLLF>#E>ERS(.N3.D9H]_O3WO/]??H31QDHA<A>[F
&RD,+R:\+ZR]DG,>N>(X5[;Ma]P2\PeDVKgLc\_4e-VM/V+\^_M0BNd@G2C&WJKU
RGSUD_PP04WB>-RCL^2bFE6S?-f-f2BI=fX;#NUcO[/NZC;PePdEK:cbOe>1C4,&
5^@f3&2N=@]86C#Q]^J8M2SdG0=X?,I7II;&3@WR4_Xe_P=/<@H1ZKaAPa[YQVSP
JXG36HJ=bf55IGHDC;J1#ZTIS\e-?_C^9Ef@XbN\6)XB\>)G[4-fRYVJ@=f?RAZ8
-W[g0:NZc6<+K(dIe(I9):gaN-SDdMTbJ6\X_UA+8C)X-24\IeS/KRF]C:P9-300
K(BQKSAM2P9eSD7J?Y/FC35OZAg;J_^)6eaKQ\LMJ#;10J7E?EgM\S7dILBVAI--
&Z69<(7S3g>5MZB5d;]4:0\=T8;c6+[W?ZQ=eYdG7&VT2J?\b-C>6T70KB?EX]WY
(GQ&J;R2&1_.J)WH7QbSbVQ-0fK^eJ>^70ZLIIYPBE<&P;IH5b+)ML3:Q1_cWZZJ
.>;BgT/IEU7WL?,L>O3IRbE?I9XF>c3ZNDSEcO(MX0c5_=-WF:f[V@J]D<3/3J,A
9+>IB>/>eDQG7RER[Q)Q63bSN@+@cQIf)3E_W_9f?EL/L2Q>UGS[+T>]QCF>R?T>
_Y#OE5;;/?5baD;#RO]2[13JJ5WTMNM64a6&(RgRb=YePW.:PCP=07b<C6]7Q[>f
,ddbX&1[YCWfF_Ge&e+S-HCc&X@8DO@>]),6YFcV([K6VW88:c85YD)IS(W:f7=2
0IJ=I1Z;fFJd,11e^fK3EdR9JQ[69\<Hfd&S:?GZ?[_FSd^Fg>HD-<+&2PI6N(aW
CB6L]J]OP4d)?dN>6;73+adV[6,a)I/-.A6IR,>M_.RYHK;b40d#O0_ABRSIE1KL
7N4&bA&,]&).I1#2=/I9XgI644+JR2:1TDN#8<=V=)(2N;^,W?BfWW>65GLCO]Bb
V,a/MX2(d+a(aLS?+]H-fK9]QY05].26SLBKa-7;],P>DR^0SM8ZK]:HQN#QX^2A
0RB38Ogb[WV2:,=IVe<4G8U&Q9=a[XB0KEBb78J;3^TN_5EWIbD2a._gR#bNBA_B
IKGP(2\YR-6Q2D86>F1Ka[(9cecCO1X1ZN?I7XT_cH+1=5@LZHcJZ+b@;V1,_7(&
(g)<6LOH):RL:)<+_C(2J:cGNKgH>-DSVKEUFC=Ja1ZRC#YZI^Z8&X\]>=A+Fd9M
=e1ZNYT4,bJ_bN->P8R/c\Xg4:DUESVW>bIg#]RC:-A,I/MZBJ\W,NLR+f.a#YPI
40+[#QDdDCP(4@&LK2f&Gf07,@U_/O8D]C;(B,.;a:T9@fM@^^0;XN23Y1TN&8#9
XUb#)Ab-M3XNQ04]J2=>0DQeR]YZR_<J-#6H&-B^UP+UfVGHQHIXPK\+d>6I>YHd
F.L(.BI>gaTCL?ceDF[WNO+(f&=.gP>8CHXPI?U4AFbD.eB+LFUc_F^50Q[d67H9
?<+aA0c^X@_LS77Ffe?4\&<.U5Q\@^R_^I0[UB8f)6?\+a^g=Vd4L2^^ZJ.f3+U6
7GfAa_RR.1cV?_MPTREIC&85KYfQT(1Y#TU-4ACVAcUAAVGg^CLJU18J+Y71JJ5-
QR54>-W62&JJ6W=D7IQXfT3QH)_RDV.OL^Qb/Taa:=/EJg]_E^U_HP;\dX;DD6:a
PED78E]&(GU\SS@-4#cSQ/W(+@[O#Z#CDY&[5BXNb+E@^5&8O3Q^:YP<F^H4bRVR
ZH6KMf(GH:]DOg3GO<Fa5>.^#GcO&H&4KT\AWQ/=?EXWEeK;0UbM8bI]e_D3e2f^
TGZ2GeL(5GH\a1&T7d)/g)#9cJH#)RWb06CfZ6;T:UVAJVQ6BV2[O+#+Y+,\cbb=
K2(6&FU)FF?7NW-Vc(Q_VUUJ75I_GN+bI7K>EZ<((6>O@>OXUDU/PBAPS3VX/>,2
G-(;7IG8(TVT7;_#_G@X<fU:\J/7;JKFcR03T;:c?N8)TVVDcYGK68LR72:FF?40
AGO:0;]5\CFfPVcRV[]6Nfe0H-EU^A02/P9WF)SSfdB6SV5CQ;)JU\fV0K7HM#?C
599UNS^X.N1=Re&5a<XVN-&S)ZB^ffL;e\=IIQ+6D/#&\.bP>b.0^3A[bJU[P)7N
Y2Je\ZV9L?[gY=3WVZ<\[&P1N)@II-HU)JR26e/WVQGDV]\G]66YDIY_RW2aSBWY
=OI2a1?X/7RO+gcSM+U6[cG.X<WI,#6Z7RX@4^Y7bL:5Q_DE47LZe&EJ57dL[84+
4?\&MQL6)D3RZZ8aT\E(4/:b-B)M][:IT0PD63M#0LU&Ic1^NQ2@4PcJdQFA5X<Y
(7@X(^:6X&gFAL=Q0,a,^\3S<Y65b^H3d+;[#PWN[FZT<L7cB&I4[4-K8VC4D[GJ
P\4L^VJdc__+)d?KJQ4QJ+T+:M:NDQg\\16C.2=UGQ0;4[L3a.TNLS,EfUaX.<^\
XD]OV33,F-N7]0]D_;]38HPOaI,Db#FHJ_T#W_>_^PSIM(c)K7SXN@a=-1AA^Q\T
T>I:EJJGJ,QK&Q:PVXT6HCF:<TfW0MHR[,Q#gbaG]2>UL/H2+1S]AF2@6WMV+NDA
fETNLJ;[5^B6LR5A@53cS#OQ@6^:3<U6(EfXL=L\R@884E9P@/\7//IL8D3b9UOH
d\W_W:S0e(A:_P;40W4\(TBQ,NEI7S?)@Y<QUg&^^g#gBE:(SEJ7FBU&)BWTS4?;
eZf\Y.-bOT-?2KEEYFc=0AX^/#?2;P1Hg9[LZ(dY).[ad9E8DSMeFEX04SU.Y5F/
AdL=,QS:RE58[\6KG=,E=#3,5g+?.)e1a^5^M.A,6)eBBga7Z#D77K<EF,;Z/.Y5
KN:CT:YPP3.aEYW5g_;?SPSa=I7C,FW0CSG^QL8D>DDec9RZY,Q\9SX-g^V<FTc?
+7&M(\;[[5)>8e7B308/<]S.aZ;X,+4NF/LH?VT6UK_6+(12R(2/J7=a]U6cU&WG
_N_O;W-,[_TP\UB<FD9^Z:6L9\aYbRN+F)4#deBSb0.3M(Z^#0-52Pf8.K--I2VL
J__&C1?;AA-X)U_4/[BZC:eL>G<O<],?O2e2[eDeBM;3E$
`endprotected
  
function void svt_spi_system_configuration::pre_randomize ();
//vcs_vip_protect 
`protected
_OA9<E6>^1;Q7O5dSGKU7<5I8\>Kfg,3:[PYJ#N=WH@3OZfWOJN3/(NR08-6ad@B
g;b=aMI9?CG9JO)3b5;&,<<#ZC1@8?\aP&BFL_<VK;^,).feDGdV9,(2#f][:KV2
f.Dd.+ALKS[aT0B<^RNB=:OW11A,X]C;?$
`endprotected

endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_spi_system_configuration::post_randomize();
`protected
.7K9S,WS99)CKd_gE9>1fC:7KYd6\67]4aFa=.B9MHEDUW=acKE64)gDME9ZaMS-
Bd/#-N\[?A)78)+FBG4FY_2d0D,/_26PD3JTEg]&XfMJ)/\\X(cZ1@cdKSbSW@LY
LVZ/B42UH^5G[HNYNGB)KbP,.UH6DW;3?31\cg,D<M,\Ze[-_Mg;>2#;MY88)6HI
5CS8e,-ca(bJ)UH=#-6DX#BOJZ&+1ccNH@,(&/L8I+gC]QV9G]P.4L]EP:>^5PWD
GQHeFf@e<8C+]Y/LF:TE&O-QGP)\;C4]<)T1[MMWTcOBAc&Id@;SI@4W)J^bfG>E
e(BBU@,_/5d=QPTV7AT4:a-Q5$
`endprotected

endfunction

// -----------------------------------------------------------------------------
function void svt_spi_system_configuration::set_default_master (int default_master_id = 0);
    foreach (this.master_cfg[i]) begin
      this.master_cfg[i].default_master = default_master_id;
    end 
    foreach (this.slave_cfg[i]) begin
      this.slave_cfg[i].default_master = default_master_id;
    end 
endfunction

// -----------------------------------------------------------------------------
function void svt_spi_system_configuration::set_default_slave (int default_slave_id = 0);
    foreach (this.master_cfg[i]) begin
      this.master_cfg[i].default_slave = default_slave_id;
    end 
    foreach (this.slave_cfg[i]) begin
      this.slave_cfg[i].default_slave = default_slave_id;
    end 
endfunction


`endif //  `ifndef GUARD_SVT_SPI_SYSTEM_CONFIGURATION_SV
