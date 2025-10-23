//-----------------------------------------------------------------------

`ifndef GUARD_SPI_SHARED_CFG_SV
`define GUARD_SPI_SHARED_CFG_SV

`ifdef SVT_UVM_TECHNOLOGY
  class spi_shared_cfg extends uvm_object;
`elsif SVT_OVM_TECHNOLOGY
  class spi_shared_cfg extends ovm_object;
`endif  
    /**
     * It selects the serial specification from mentioned below supported specifications.
     * SPI   : Indicates SPI feature by Motorola  <br/>
     * SSP   : Indicates SSP feature by Texas  <br/>
     * UWIRE : Indicates MicroWire feature by National Semiconductors <br/>
    */ 
    rand svt_spi_types::spi_feature_enum spi_feature = svt_spi_types::SPI;
  
    /** 
     * It selects from Standard SPI specification or Vendor specific extended version of SPI Specification mentioned below.
     * SPI_STD    : Indicates SPI Standard mode feature <br/>
     * SPI_DUAL   : Indicates SPI dual mode  <br/>
     * SPI_QUAD   : Indicates SPI quad mode  <br/>
     * SPI_EMPSPI : Indicates EMPSPI mode 
     */ 
    rand svt_spi_types::frame_format_enum frame_format = svt_spi_types::SPI_STD;
  
      /** SPPR2-SPPR0  SPI Baud Rate Preselection Bits  */
    rand bit [2:0] sppr = 0;
  
    /** SPR2-SPR0  SPI Baud Rate Selection Bits  */
    rand bit [2:0] spr = 0;
  
    /** 
     * This field specifies whether the data is transmitted in little/big bit endian mode  <br/> 
     * LITTLE_ENDIAN : Indicates SPI LITTLE ENDIAN Format <br/>
     * BIG_ENDIAN    : Indicates SPI BIG ENDIAN Format <br/>
    */
    rand svt_spi_types::endianness_enum bit_endianness = svt_spi_types::LITTLE_ENDIAN;
  
    /**
     * This field specifies whether the data is transmitted in little/big byte endian mode  <br/> 
     * LITTLE_ENDIAN : Indicates SPI LITTLE ENDIAN Format <br/>
     * BIG_ENDIAN    : Indicates SPI BIG ENDIAN Format <br/>
    */
    rand svt_spi_types::endianness_enum byte_endianness = svt_spi_types::LITTLE_ENDIAN;
    
    /**
     * This field selects one of four possible clock configuration mode for SPI Interface. <br/>
     * (CPOL, CPHA) tuple represents the Mode of operation; e.g., the value '(0, 1)' would indicate CPOL=0 and CPHA=1.  <br/>
     * CPOL represents the base value of clock in Idle state. <br/>
     * For CPHA=0, odd numbered edges on the SCK input cause the data at the serial data input pin to be latched. <br/>
     * If the CPHA bit is set, even numbered edges on the SCK input cause the data at the serial data input pin to be latched.  <br/>
     * SPI_MODE_0 : Indicates SPI CPHA = 0 , CPOL = 0 <br/> 
     * SPI_MODE_1 : Indicates SPI CPHA = 1 , CPOL = 0 <br/> 
     * SPI_MODE_2 : Indicates SPI CPHA = 0 , CPOL = 1 <br/> 
     * SPI_MODE_3 : Indicates SPI CPHA = 1 , CPOL = 1 <br/> 
     */ 
    rand svt_spi_types::operation_mode_enum operation_mode = svt_spi_types::SPI_MODE_0;
  
    /** 
     * @groupname spi_std_empspi
     * This field specifies whether the EMPSPI payloads to be transmitted in 8/16/32bit word size  <br/>
     * SPI_8B  : Indicates SPI 8 BIT WORD Format  <br/> 
     * SPI_16B : Indicates SPI 16 Bit WORD Format <br/>
     * SPI_32B : Indicates SPI 32 Bit WORD Format <br/>
     */
    rand svt_spi_types::payload_word_size_enum payload_word_size = svt_spi_types::SPI_8B;
  
    /** Default Slave active on SPI Bus. Only applicable when device is Slave. */
    rand int default_slave = -1;
    
    /** Default Master active on SPI Bus. Only applicable when device is Master. */
    rand int default_master = -1;
  
    /**
     * This field the EMPSPI signal SPI_INT to be asserted as Active High or Low. <br/>
     * ACTIVE_LOW  : Asserted when SPI_INT is 0 and De-asserted when SPI_INT is 1. <br/>
     * ACTIVE_HIGH : Asserted when SPI_INT is 1 and De-asserted when SPI_INT is 0. <br/>
     */ 
    rand svt_spi_types::active_mode_enum empspi_spi_int_polarity = svt_spi_types::ACTIVE_LOW;

    /**
     * This field is used to configure the safe SPI frame mode. <br/>
     * Safe SPI supports two types of frame mode, IN_FRAME and OUT_OF_FRAME. <br/>
     */ 
    rand svt_spi_types::spi_safe_frame_mode_enum spi_safe_frame_mode = svt_spi_types::IN_FRAME;

   /**
     * This constraint controls those properties which should be same for both the configuration objects.
     */
    constraint same_properties_across_link
    {
       default_slave inside {[0:(`SVT_SPI_MAX_NUM_SLAVES -1)]};
       default_master inside {[0:(`SVT_SPI_MAX_NUM_MASTERS -1)]};
       payload_word_size inside {svt_spi_types::SPI_8B,svt_spi_types::SPI_16B,svt_spi_types::SPI_32B};
       if (frame_format == svt_spi_types::SPI_FLASH)
         operation_mode inside {svt_spi_types::SPI_MODE_0,svt_spi_types::SPI_MODE_3};
       else if (frame_format == svt_spi_types::SPI_SAFE) {
         if (spi_safe_frame_mode == svt_spi_types::IN_FRAME)
           operation_mode == svt_spi_types::SPI_MODE_1;
         else
           operation_mode == svt_spi_types::SPI_MODE_0;
       }  
`ifdef SPI_FLASH_FORCE_SPI_MODE_0
         operation_mode == svt_spi_types::SPI_MODE_0;
`endif
`ifdef SPI_FLASH_FORCE_SPI_BAUD_PARAMETERS
       sppr == `SPI_FLASH_FORCE_SPI_BAUD_PARAMETERS;
       spr == `SPI_FLASH_FORCE_SPI_BAUD_PARAMETERS;
`endif
    }
  
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_object_utils_begin(spi_shared_cfg)
       `uvm_field_enum(svt_spi_types::spi_feature_enum, spi_feature, UVM_ALL_ON)
       `uvm_field_enum(svt_spi_types::frame_format_enum, frame_format, UVM_ALL_ON)
       `uvm_field_int(sppr, UVM_ALL_ON | UVM_BIN)
       `uvm_field_int(spr, UVM_ALL_ON | UVM_BIN)
       `uvm_field_enum(svt_spi_types::endianness_enum, bit_endianness, UVM_ALL_ON)
       `uvm_field_enum(svt_spi_types::endianness_enum, byte_endianness, UVM_ALL_ON)
       `uvm_field_enum(svt_spi_types::operation_mode_enum, operation_mode, UVM_ALL_ON)
       `uvm_field_enum(svt_spi_types::payload_word_size_enum, payload_word_size, UVM_ALL_ON)
       `uvm_field_int(default_master, UVM_ALL_ON | UVM_BIN)
       `uvm_field_int(default_slave, UVM_ALL_ON | UVM_BIN)
       `uvm_field_enum(svt_spi_types::active_mode_enum, empspi_spi_int_polarity, UVM_ALL_ON)
    `uvm_object_utils_end

`elsif SVT_OVM_TECHNOLOGY
    `ovm_object_utils_begin(spi_shared_cfg)
       `ovm_field_enum(svt_spi_types::spi_feature_enum, spi_feature, OVM_ALL_ON)
       `ovm_field_enum(svt_spi_types::frame_format_enum, frame_format, OVM_ALL_ON)
       `ovm_field_int(sppr, OVM_ALL_ON | OVM_BIN)
       `ovm_field_int(spr, OVM_ALL_ON | OVM_BIN)
       `ovm_field_enum(svt_spi_types::endianness_enum, bit_endianness, OVM_ALL_ON)
       `ovm_field_enum(svt_spi_types::endianness_enum, byte_endianness, OVM_ALL_ON)
       `ovm_field_enum(svt_spi_types::operation_mode_enum, operation_mode, OVM_ALL_ON)
       `ovm_field_enum(svt_spi_types::payload_word_size_enum, payload_word_size, OVM_ALL_ON)
       `ovm_field_int(default_master, OVM_ALL_ON | OVM_BIN)
       `ovm_field_int(default_slave, OVM_ALL_ON | OVM_BIN)
       `ovm_field_enum(svt_spi_types::active_mode_enum, empspi_spi_int_polarity, OVM_ALL_ON)
    `ovm_object_utils_end
`endif  
  
   
    //----------------------------------------------------------------------------
    /**
     * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
     * values to the super.
     *
     * @param name Instance name of the configuration
     */
    function new(string name = "spi_shared_cfg");
      super.new(name);
    endfunction
   //----------------------------------------------------------------------------
    /**
     * Returns the class name for the object.
     */
    virtual function string get_class_name ();
      get_class_name = "spi_shared_cfg";
    endfunction
  
  endclass
`endif
