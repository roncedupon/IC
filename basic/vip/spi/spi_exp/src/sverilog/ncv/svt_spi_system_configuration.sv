
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6YvuQiyM7BhsLzxLayH/qoP0pTs37XKHodNMQ0t6FGTckJBI4yfCNzrGLwnxvIpq
tCPulNdS58rA9PpcvZI+u7qwYH8sbeq9pj/ZY0/cked+nrOCpO71Bh6MbEUqKLcx
nByXMVstaoQ662sbQiP5oifUrU32HHS5XQ/PsMpKwT0h4ybVeRpe8w==
//pragma protect end_key_block
//pragma protect digest_block
1kzIsvGdqAW98qP6F9ls5p/Hiu8=
//pragma protect end_digest_block
//pragma protect data_block
afzzIiPD9sNUHUJjmf/0f/7QVAQaTodorr25Vw25PH+MbdhP0tX7xjF4x4STVyAs
Bq27/O9pKisz/LnBk0rPpONLU3cF9Bbf/hSrb/lPuxFf0h3GxjTOZH5Q2Sqw3KlC
8ohzzxJqOV9QGKy9jk+pMdjL7aytwtgZZ4cYzhAoPcrLyn+AKafFQF4xLzZ1P4sQ
jjvTtYEavjlPpup/9Ew1kja/Es0t2++su2uS5JnkihUon2eO9nE1m0R9HbEutxdV
yTvql/K/FZ2CMAKqfpOAsZXIfd6ClBGLBJ0V8A8Zdzv1u5T0jG1JIlap9r8BQpiP
uBVQBOvE1BfZEesNupewTwG9L/2gxv17TMu8+z4qgslM/D2fJt/Gg8ull9mLvsmQ
Pvan+ZbAk0cbPuHxCMFM2jUALTMypko1hXFR7cHUfhny1IiEH5wuTXlFZ+/W/CPd
zuoSX76rGF2RZmYBxVqRdmOJvZ35xEmhOaRV+J9h0IDpryNd8cuu6ZWwouxkLy0L
BvKD9A+MIiWJ3e6rMad73lTCc0weQ11JBKkcsnwOTbsz7Qr57OBHK1DSQ13upk2J
e1PKZFbkdqG74C/fYPU3uzNU2Mk2jyIN/2SrF/hxO4iJ5p7SgU533gaTQZRF0vH/
FfrSSxJhERk9YKy4HO4JFXCLhozXvsNFhtV1CvgyjRVsGdAH91KEHWRRkC1Eeduj
3u9kQWk6FoKxFd7rMULFkDqFvHQEF5U26kJykPLNW/OZe6qd2Bmqc/U21P5Yafya
/y9cuKFT2Kws8NJsQKsHMMgquiITrw1TWG/yuBO0U7enyLpgbKIJTlzl0BArUwRE
Bc4SZ0IsQEh5Oh9h8K74sSSRdWimpjbb5lWvdzTnYRVOHwfQaYWPQjSuN09wRIPx
JTT9kbFntmPrwFyehviu9vDsFFb+cWAkpYsvEdQsyAlxFiVcLytrr5ZT7BM8aRH6
/DWGtrwmB54juFNlJgEQt/idolVV4kkX+xmIocGfvMZZOnOIsavNdKkdBLK3YR7t
FQ66svjcMngNw7CdrD7zfeLe9U2Ik3ebtuohDWEm05lvt1hxRjvUdNxiExsbtIy4
P3T0UhKGLGmdHRTG122NIKhchVgPR0GS4PGV96cDgPoYhQ9egHJQJF6OSzGBBclv
V6Lw4f+EbvLoJbVWQS1f+fo0wjTzophjoWm2QyWA1LeXmzff8EQDHloQtjoeK7T8
dJN4TMk7OtfrOE7mdK8gRmms3F3dEDUU7RRUGBbFGgs=
//pragma protect end_data_block
//pragma protect digest_block
0Wh/NGluF0SP1x3Zc1WMpNWChiw=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect 
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YZLvk/NkNqetwiFzzrkhR000ewY2985Gua/lfcW2LdXElDpb9cLAZGBrHFCxWQxn
aFSYhmpNSVMdCWFP58hEWn3YnjU77TaMqKUrF+mIGTYmXrNaNazA3anJWsAeKcy3
MCezZoO5M4cugIGrchNxbIZjd1vZhY7iqFCmxRYzNPKjZvZ61tKfzg==
//pragma protect end_key_block
//pragma protect digest_block
D2StUisE0S9tpILBKgvfFbE8fvw=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
WS2XuLG13J5ZL7Ey1R/HH8r2l7M=
//pragma protect end_digest_block
//pragma protect end_protected
function void svt_spi_system_configuration::pre_randomize ();
//vcs_vip_protect 
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jRNfRsqdDou3qOJTOpmR4jVF5tfvPLHYWH2YVg35XpbRAQv/IAB8s6WMhJQKOafT
CfddTOV3PJexVr+nlJQBgsTz4j9OE/RaQsT8vDjpUFjCR6Ed1xPOz/ACusxKZXJs
dIbjn3oUDeJ6Kc6HxelUUVzN5iLC/89CPIBX046XHE9zZ9lOk+bV+g==
//pragma protect end_key_block
//pragma protect digest_block
xLA49PfXX2RsA1YWVcs5kg4tFkU=
//pragma protect end_digest_block
//pragma protect data_block
+CU0jE8V8tWC5mg8ZD6h/8cwfh8TMKoKyxqlshmPCeYw0AXdD1ITc6r7VoLjRiu6
oX2gh0iCL2f7QJqC2A7BJygX9Y5tTwswuvaUKO3xB1u2iUEFX9FrgCWnEfWMnTzi
y78RGVIjvNQ1vYebdEwoeFLatfZyFcfyeRyu2beGLT9QganeP86HJs9W4qBjAI0r
Or7nDxt8JBlbE8eNdlT16pV6ChjNlqvQFLzka/r7dxjvu23RpNsvAeyii7MjsJk5
peK+OE7lQnI28hcvRw/UMDlni1Pauem7BiYsniNeINEOLQFqW/NiwYpAVhOINWtx
OWizZorFc9kH73XAy0nh0Krcvffu02xMBwifIi7mM/AAVmbfBxdyEgzuQCo4b/uY
Iwp4B+UOa81vsrCLIQ8FdH1iYsk+fY0xEAevxoSNtkg=
//pragma protect end_data_block
//pragma protect digest_block
4flfkzNylTGL1w9S1A7jiAurvvQ=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_spi_system_configuration::post_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uzEiMKzdwML2mhooWyCiM/OgB/X3WdJKygtjsRensqooeQF9swtMa6owjWa18T/c
K/DVCKg0Fk0cIqcSrDWYMWKBjCZAZmr48FqJc99SqRzQUyFsAkoUa/j0z2PubKmZ
DJnMUtUcGmo8vI4WeiV95LgNi5koefQ22Qa8Y6GiiZtNEiSsWIe11A==
//pragma protect end_key_block
//pragma protect digest_block
xFz3Eo1XRYyG654IbU7wzatgAS8=
//pragma protect end_digest_block
//pragma protect data_block
XnGmWyHUVAp/PbJqc+dNqbkWuZ0z5bIOgxqs5KgDpq/Ab/l73EwLhge8p77G8EfS
8gSqMdaMst5WJOKfOF+9a/HiFx4wzVUUqrVuTe5f3yd1qFlx4DF22Y2TjjXZbhgo
vXeQ5btzCkm2g46rqZYbl9Y9lgI5IA8D/+tDubejlP5w5QHRxUjorjhSbbCuhulv
MVjIBop5v7dJE7EiY9VHGQ9ghMMDdw3d4obquh2jOxRcIJhznAgxkMrWvuYTMeyz
8JrNMgjg8QXNsfImBaVQTpjcITm0epGygDSpzJ2GPAd1sOs1gEaxh2tIzk6excOS
6wp5lWLa8+P1QUW5NBCMHzxKHVjWhpHWBK6/qebqSPSI8Jrw3rnfvnqGgK27fVql
a+imwkHxWEa1y3GVmwP5P7uZoJKDPJh3Iyar4Q0GX1JHMgUBDee4xTJxtyzW4Dea
b93byWe47jamGIvzc0/Pr9mfiEBtWFESprbp5ZUk+6j69aEAPppaO4nFVQYsGdhG
bJUfsKU6hkI0ocetin/h6RK/aSUkGsfkCZfuGSVGbBRx4PbUUAl1No6WL9v2KdD6
eRCIc2Fc6mVz3yofTRQ+eoVKwHr0XaIwtRj1hX6QphF0EtcFTHOk1sikyVH/Tcja
41AvERJIA3MQOcLTFLGvtg==
//pragma protect end_data_block
//pragma protect digest_block
2vu2dTmrqmKi+UJcaDOgIvuOJFc=
//pragma protect end_digest_block
//pragma protect end_protected
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
