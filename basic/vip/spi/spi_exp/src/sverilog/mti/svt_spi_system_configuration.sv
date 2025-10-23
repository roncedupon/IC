
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fmMiMIYAart7LvSDYr00KfoNGy8CfJjxS6NigrEfZ8ceXQm0a2M/EPiV64lod0d/
JY7rR/AKREVb0woCFcz560GvCoGTleuyQg5Xy9cqn+m80rPNLSXIMFElB56GC89A
vhEZOTkGd+P5PFaD0+Lf4wozM+2UKoRhniDgd4pOi2k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 771       )
P6hhQOU7z3T4UcOKt90JumzhojWL9meO5RDYO0rCj2keR7MSswnLpv81ms5VRsoH
qmfczmO/V08ShYGIzOjHjJsRLN00SISBOrB3P8XfnqxthKSZyQlqrMEDGGaZC+KD
I/LW22UJS4e2pe7PVEL1dyfTmMROWg7qVmst0TbGcKrnxkZ0As9/SrC/+ri8TJzU
zECylUezitIZohEzt8PTsj747KsHkLUyVOFwdzSE5ESRKsW5ErCQ+aPyWuDrW86k
WLSDHjMOf561U6qGMgTyYeb6FN/SH5XLv59HS1rIEWFK7396ZNKuhqV3SezUYmrj
r2njDEfS9IfbUYAtIDhqxRB9/YEaC5wTd8MT9uZ4egf5kpmjfdDjrSK5pFLyTqEs
4AoHd9jfNfjt3CLrLIg3Y8LkGL2saeZXgupGNdJoGb1L1kTpsmnLCedWsKDtGGWC
Fi+gtGA0dVvooFjkclGFP8jNy8MEYBzAWqs0gpxmtxMlJoxdfLupFisfZe8f9gqi
Hn6ixkxo0f1wUbyIZJLALj/vCg4VNkPK8S470POQCNq6aVSLoimo2J/W1DKNU7A5
a8gU+TgRil/GWcDvkZzZ+2I3LhzJMFDa6eEzt+h6I7VFTgfjZs+XGKRIHP1J+tCN
k8ItYiCgoQEkpBcu0FEsmPlWVPH1sMAeKv3CFjyXDs+L399tslvZeupieg4neCoW
JpZ5lJ1DZzHGKO4kmzWKZ6FxC0LCDwiBpxXcYMfRCmuKbmHz6MBKnRum8nRqlvLa
lsZ+euKAbGEWI/BzvXtFrZOJYbNNyFvJRyc/0tA10OtTa7BuWEIgEiHjtFkX+dcX
DZtm73uu002mY5wc3iFueYHd98Mm13HyPEsRKTi9y1j6m61r9r9rvO7dU7y8Z9J5
eqY0Y+KK4s4Vw5WQqxFjYCLmzChgC/b0MYfF9mV8Aoq/GhtYw7ba5331in+3xPNZ
o7SMntjdrHnhLqh/5l23iozMxhYbUN2QYw1VkuMqo/rkhfD1UJZHrjFwPRHxkc1C
WdgevmsiA3T66vG53ARgig==
`pragma protect end_protected

//vcs_vip_protect 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
X91IzezO+86vWdnCoadW99N2peT8zSrpPQr6ve7ZuJJ6WmU2LjF90P/P7P1U5ZFD
8UxV2DjFWlbg2yGmdshAslPeT9Adh4JZmIRfMDNq+QEWBlmMFtGHc1up8bVWKknS
3I1X+ANJ2l6SK0Dl0KCsHte2rMcKMsCWo62SZ+NcdR0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23634     )
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
II788mbnFolY4bJ6dLQNeQ==
`pragma protect end_protected  
function void svt_spi_system_configuration::pre_randomize ();
//vcs_vip_protect 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
D5pUV551OPmMbeV6/fKJaDNu3NYjZK4vEbPfAKz4RAsna32cR23JRfRXx/TjkB2k
haZSzO8nDfxCpBaQo3lhH2KlGrnQPsXj/lME+wudvBemvUVs/QdNyjQlGJX7UOg+
twOkpZOw2xz6gGkjkTTpS3OCjQ9KKbWWtdl+UJsktkU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23787     )
i756I7l4wg9q/faBBBHy68MrH03SFJjePTfJ05HAovu2yVIj/jcdeEub8Ss6VuxZ
e5Zi/Mvt8uhUeEtYjyKWRXrDoMKyeVHFzps892y+clV0UkGjH2rLIV4uHzEZ9fnC
pIEh/lH1njoU7KgnoUFxlq5BDy0Jlmv5u7G9nS3W08Z7atNFrFzj22TedZlAQ9ZR
mj1keC/DhYu+QbAI48+/EQ==
`pragma protect end_protected
endfunction: pre_randomize

// -----------------------------------------------------------------------------
function void svt_spi_system_configuration::post_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZYQwoQL+pUQ2kNOlOD3XR+A9uezQT2/T5vgmMFlIf1l9+asysBd2G7SNiglokjl1
/alcowhtjEYNgTE3uiod1EoHkoznnyIAYRdxzN9c7EFiPiZhKOWr5V5WVPm3NJTS
syBtsXAPFFAaNYHz1v8t/c0D7P5VUeT/XJE+nzHOH8E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24104     )
7wi76pOE2ECKKz3Bxebhvyvwf4gJKuKh6lChZ3uwTfriYMNmsyITLCCNr2BHChCj
qJmGMMP/kTreDuf4T/SBj6hGkgU9T69b4xPHxhzBxZ9I+9GORzx1S529GxiO+t5D
lo3kOFM9i88pE2K0z2UNUU/xVFpdHR+ZxetoOh6Lu64QaknjsPZYsPZ+lsYHeop6
e4/A4NbKCAXKS7sQy+Uh5/FzrkJa6T6Zp8bq3sbqaBfx75Pycqo9qKPk/5nOS4g7
OOKQVi/rXQeRvw3CYopNjnookNS1rFWGsRwKi+DcdBT3FWm1KP4Z0oXzhl8BhP2a
2mBEhMyPJxKXvRPoqJgyJBN+hD9rJMEhwEThUJqQqkECSq6LeCtlFijgrmW3QCtN
WeOdv7uy4rN2czdOx77/beGHM2HAIInxvtWRs3abuUs=
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B1LatnHmQmHX+DSRy77GtJNRRIoLCX3mW1NCGOV4F4tNedDgV/RLYEq/WdGG03WY
Z+YTicWMZgiC7zzMjM1SvsyclHQT1jq3FhBfuzYRasNtjeB4VGM2c2yeI0NJNshC
qEDpEYkJcWVztuffnVQgo17YFxxCgekBJMWd4cTzYbA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24187     )
/qkXtzIdjYCY/biI3Mh1vMlneDCzSRZL/VJ2pKa73h0XbYc5DUfW2GNdkCfIffMq
N1+WmTn1OmBlDn8GbeTqWBqskH3A6e+hP+GDPHdj9JnWjU2EedbAxnvAOcFb2Y2U
`pragma protect end_protected
