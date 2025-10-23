
`ifndef GUARD_SVT_SPI_TYPES_SVI
`define GUARD_SVT_SPI_TYPES_SVI 

`include "svt_spi_defines.svi"

// =============================================================================
/**
  * This class contains pre-defined enumerated types for svt_spi_types
  */
class svt_spi_types;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /** Values that set the operation speed. */
  typedef enum bit [1:0] {
    SPI   = `SVT_SPI_FEATURE_OFFICIAL,  /**< Indicates SPI feature by Motorola */
    SSP   = `SVT_SPI_FEATURE_SSP,  /**< Indicates SSP feature by Texas */
    UWIRE = `SVT_SPI_FEATURE_UWIRE /**< Indicates MicroWire feature by National Semiconductors*/  
  } spi_feature_enum;

  /** Values that set the operation speed. */
  typedef enum bit [2:0] {
    SPI_STD = `SVT_SPI_STD, /**< Indicates SPI Standard mode feature */
    SPI_EMPSPI = `SVT_SPI_EMPSPI,  /**< Indicates EMPSPI mode*/  
    SPI_MULTILANE = `SVT_SPI_MULTILANE,  /**< Indicates multilane(Dual/Quad/Octal)  mode*/ 
    SPI_FLASH = `SVT_SPI_FLASH,  /**< Indicates Flash mode (part number specific)*/ 
    SPI_SAFE = `SVT_SPI_SAFE /**< Indicates SAFE SPI mode*/
  } frame_format_enum;

  /** Values that set the operation speed. */
  typedef enum bit [1:0] {
    SPI_MODE_0 = `SVT_SPI_MODE_0, /**< Indicates SPI CPHA = 0 , CPOL = 0 */
    SPI_MODE_1 = `SVT_SPI_MODE_1, /**< Indicates SPI CPHA = 1 , CPOL = 0 */
    SPI_MODE_2 = `SVT_SPI_MODE_2, /**< Indicates SPI CPHA = 0 , CPOL = 1 */
    SPI_MODE_3 = `SVT_SPI_MODE_3  /**< Indicates SPI CPHA = 1 , CPOL = 1 */  
  } operation_mode_enum;

  /** Values that set the operation speed. */
  typedef enum bit {
    LITTLE_ENDIAN = `SVT_SPI_LITTLE_ENDIAN, /**< Indicates SPI LITTLE Endian Format */
    BIG_ENDIAN = `SVT_SPI_BIG_ENDIAN /**< Indicates SPI BIG ENDIAN Format */  
  } endianness_enum;

  /** Values that set the operation speed. */
  typedef enum bit [1:0] {
    SPI_8B = `SVT_SPI_8B_WORD, /**< Indicates SPI 8 BIT WORD Format */
    SPI_16B = `SVT_SPI_16B_WORD, /**< Indicates SPI 16 Bit WORD Format */ 
    SPI_32B = `SVT_SPI_32B_WORD /**< Indicates SPI 32 Bit WORD Format */  
  } payload_word_size_enum;

  /** Values that set the operation speed. */
  typedef enum bit [1:0] {
    RUN_MODE  = `SVT_SPI_RUN_MODE,   /**< Run Mode. */
    WAIT_MODE = `SVT_SPI_WAIT_MODE,  /**< Wait Mode */      
    STOP_MODE = `SVT_SPI_STOP_MODE   /**< Stop Mode */ 
  } op_mode;
  
  /** Values that set the operation speed. */
  typedef enum bit {
    ACTIVE_LOW =  `SVT_SPI_ACTIVE_LOW_POLARITY, /**< Active Low */
    ACTIVE_HIGH = `SVT_SPI_ACTIVE_HIGH_POLARITY /**< Active High */      
  } active_mode_enum;

  typedef bit [`SVT_SPI_DATA_WIDTH-1:0] word_sz;
  typedef word_sz word [];
  // For headers in EMPSPI where 8bit words are required to store Header variables
  typedef bit [7:0] hdr_word_sz;
  typedef hdr_word_sz hdr_word [];
  //
  typedef reg serial_queue[$];
  typedef bit[7:0] byte_type[$];
  
  typedef enum bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] {
    PROTECTION_REGISTER = 'hA0,
    FEATURE_REGISTER = 'hB0,
    STATUS_REGISTER = 'hC0
  } nand_flash_register_type;

  /** enum corresponding to SPI Bus states types. */
  typedef enum bit[1:0] {
    LINESTATE_0       = 0, 
    LINESTATE_1       = 1,
    LINESTATE_Z       = 2,
    LINESTATE_UNKNOWN = 3
  } linestate_value_enum;

  /** enum corresponding to SPI ports. */
  typedef enum bit[3:0] {
    GTX_MOSI             = 0, 
    GTX_MISO             = 1,
    GTX_OE_N             = 2,
    GTX_DQS              = 3,
    GTX_DM               = 4,
    GTX_PARALLEL_IO      = 5, 
    GTX_PARALLEL_IO_OE_N = 6, 
    GTX_SLAVE_RDY        = 7,
    DM_OE_N              = 8,
    DQS_OE_N             = 9
  } spi_port_enum;

  /** Values that define the configuration states. */
  typedef enum bit [1:0] {
    UNKNOWN_STATE,     /** Indicates Unknown State */
    REGISTER_UPDATE,   /** Indicates that Config Register has been updated */
    OPERATION_EXECUTED /** Indicates that Special Operation has been executed */  
  } config_security_state_enum;

/**
 * <u><b> Supported Commands :</b></u><br>
 *
 * <table border="1" cellpadding="1" cellspacing="1"">
 *   <thead>
 *    <tr><th bgcolor="#dddddd" colspan="4"><b>**This table specifies enum encoding for SPI Flash command in respective part number. </b></th></tr>
 *    <tr><th bgcolor="#dddddd"><b> Vendor   </b></th><th bgcolor="#dddddd"> Part Number </th><th bgcolor="#dddddd"><b> Command Enum </b></th><th bgcolor="#dddddd"><b> Command Opcode </b></th></tr>
 *   </thead>
 *   <tbody>
 *    <tr><td><b> MICRON         </b></td> <td> N25Q_1Gb_3V_65nm       </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_1                                           </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_2                                           </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> MULTIPLE_IO_READ_ID                                 </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h3D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h6D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_REGISTER                                  </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_REGISTER                                 </b></td><td>  8'hE5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FLAG_STATUS_REGISTER                           </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_FLAG_STATUS_REGISTER                          </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_CONFIGURATION_REGISTER             </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_CONFIGURATION_REGISTER            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_VOLATILE_CONFIGURATION_REGISTER                </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_CONFIGURATION_REGISTER               </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ENHANCED_VOLATILE_CONFIGURATION_REGISTER       </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENHANCED_VOLATILE_CONFIGURATION_REGISTER      </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_ADDRESS_REGISTER                      </b></td><td>  8'hC8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_EXTENDED_ADDRESS_REGISTER                     </b></td><td>  8'hC5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_INPUT_FAST_PROGRAM                             </b></td><td>  8'hA2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_DUAL_INPUT_FAST_PROGRAM                    </b></td><td>  8'hD2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DIE_ERASE                                           </b></td><td>  8'hC4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MICRON         </b></td> <td> N25Q_512Mb_3V_65nm     </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_1                                           </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_2                                           </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> MULTIPLE_IO_READ_ID                                 </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h3D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h6D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_REGISTER                                  </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_REGISTER                                 </b></td><td>  8'hE5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FLAG_STATUS_REGISTER                           </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_FLAG_STATUS_REGISTER                          </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_CONFIGURATION_REGISTER             </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_CONFIGURATION_REGISTER            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_VOLATILE_CONFIGURATION_REGISTER                </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_CONFIGURATION_REGISTER               </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ENHANCED_VOLATILE_CONFIGURATION_REGISTER       </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENHANCED_VOLATILE_CONFIGURATION_REGISTER      </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_ADDRESS_REGISTER                      </b></td><td>  8'hC8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_EXTENDED_ADDRESS_REGISTER                     </b></td><td>  8'hC5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_INPUT_FAST_PROGRAM                             </b></td><td>  8'hA2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_DUAL_INPUT_FAST_PROGRAM                    </b></td><td>  8'hD2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DIE_ERASE                                           </b></td><td>  8'hC4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM                   </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_64KB                                </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE                                          </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QUAD                                          </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QUAD                                           </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MICRON         </b></td> <td> N25Q_256Mb_1_8V_65nm   </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_1                                           </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_2                                           </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> MULTIPLE_IO_READ_ID                                 </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h3D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h6D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_REGISTER                                  </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_REGISTER                                 </b></td><td>  8'hE5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FLAG_STATUS_REGISTER                           </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_FLAG_STATUS_REGISTER                          </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_CONFIGURATION_REGISTER             </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_CONFIGURATION_REGISTER            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_VOLATILE_CONFIGURATION_REGISTER                </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_CONFIGURATION_REGISTER               </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ENHANCED_VOLATILE_CONFIGURATION_REGISTER       </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENHANCED_VOLATILE_CONFIGURATION_REGISTER      </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_ADDRESS_REGISTER                      </b></td><td>  8'hC8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_EXTENDED_ADDRESS_REGISTER                     </b></td><td>  8'hC5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_INPUT_FAST_PROGRAM                             </b></td><td>  8'hA2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_DUAL_INPUT_FAST_PROGRAM                    </b></td><td>  8'hD2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM                   </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_64KB                                </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE                                          </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QUAD                                          </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QUAD                                           </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MICRON         </b></td> <td> N25Q_16Mb_1_8V_65nm    </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_1                                           </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_2                                           </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> MULTIPLE_IO_READ_ID                                 </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_REGISTER                                  </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_REGISTER                                 </b></td><td>  8'hE5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FLAG_STATUS_REGISTER                           </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_FLAG_STATUS_REGISTER                          </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_CONFIGURATION_REGISTER             </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_CONFIGURATION_REGISTER            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_VOLATILE_CONFIGURATION_REGISTER                </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_CONFIGURATION_REGISTER               </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ENHANCED_VOLATILE_CONFIGURATION_REGISTER       </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENHANCED_VOLATILE_CONFIGURATION_REGISTER      </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_INPUT_FAST_PROGRAM                             </b></td><td>  8'hA2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_DUAL_INPUT_FAST_PROGRAM                    </b></td><td>  8'hD2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MICRON         </b></td> <td> MT25QU512ABB           </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_1                                           </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_2                                           </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> MULTIPLE_IO_READ_ID                                 </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h3D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h6D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_WORD_READ                                   </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ_DTR                             </b></td><td>  8'h0E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ_DTR                     </b></td><td>  8'hBE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ_DTR                     </b></td><td>  8'hEE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FLAG_STATUS_REGISTER                           </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_CONFIGURATION_REGISTER             </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_VOLATILE_CONFIGURATION_REGISTER                </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ENHANCED_VOLATILE_CONFIGURATION_REGISTER       </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_ADDRESS_REGISTER                      </b></td><td>  8'hC8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_GENERAL_PURPOSE_READ_REGISTER                  </b></td><td>  8'h96   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_CONFIGURATION_REGISTER            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_CONFIGURATION_REGISTER               </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENHANCED_VOLATILE_CONFIGURATION_REGISTER      </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_EXTENDED_ADDRESS_REGISTER                     </b></td><td>  8'hC5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_FLAG_STATUS_REGISTER                          </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_INPUT_FAST_PROGRAM                             </b></td><td>  8'hA2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_DUAL_INPUT_FAST_PROGRAM                    </b></td><td>  8'hD2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM                   </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_EXTENDED_QUAD_INPUT_FAST_PROGRAM          </b></td><td>  8'h3E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE                                          </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_32KB                                </b></td><td>  8'h5C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_64KB                                </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QUAD                                          </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QUAD                                           </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECTOR_PROTECTION                              </b></td><td>  8'h2D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECTOR_PROTECTION                           </b></td><td>  8'h2C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_REGISTER                                  </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_REGISTER                                 </b></td><td>  8'hE5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_LOCK_BITS                          </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_LOCK_BITS                         </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_NONVOLATILE_LOCK_BITS                         </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_GLOBAL_FREEZE_BIT                              </b></td><td>  8'hA7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_GLOBAL_FREEZE_BIT                             </b></td><td>  8'hA6   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'h27   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'h28   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'h29   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ_LOCK_REGISTER                        </b></td><td>  8'hE0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_WRITE_LOCK_REGISTER                       </b></td><td>  8'hE1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INTERFACE_ACTIVATION                                </b></td><td>  8'h9B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MICRON         </b></td> <td> MT25QL128ABA           </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_1                                           </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_2                                           </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> MULTIPLE_IO_READ_ID                                 </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h3D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ_DTR                           </b></td><td>  8'h6D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_WORD_READ                                   </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FLAG_STATUS_REGISTER                           </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_CONFIGURATION_REGISTER             </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_VOLATILE_CONFIGURATION_REGISTER                </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ENHANCED_VOLATILE_CONFIGURATION_REGISTER       </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_GENERAL_PURPOSE_READ_REGISTER                  </b></td><td>  8'h96   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_CONFIGURATION_REGISTER            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_CONFIGURATION_REGISTER               </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENHANCED_VOLATILE_CONFIGURATION_REGISTER      </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_FLAG_STATUS_REGISTER                          </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_INPUT_FAST_PROGRAM                             </b></td><td>  8'hA2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_DUAL_INPUT_FAST_PROGRAM                    </b></td><td>  8'hD2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE                                          </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QUAD                                          </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QUAD                                           </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECTOR_PROTECTION                              </b></td><td>  8'h2D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECTOR_PROTECTION                           </b></td><td>  8'h2C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_REGISTER                                  </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_REGISTER                                 </b></td><td>  8'hE5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_LOCK_BITS                          </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_LOCK_BITS                         </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_NONVOLATILE_LOCK_BITS                         </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_GLOBAL_FREEZE_BIT                              </b></td><td>  8'hA7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_GLOBAL_FREEZE_BIT                             </b></td><td>  8'hA6   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'h27   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'h28   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'h29   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INTERFACE_ACTIVATION                                </b></td><td>  8'h9B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MICRON         </b></td> <td> MT35XU512ABA           </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_1                                           </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID_2                                           </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_OUTPUT_FAST_READ                              </b></td><td>  8'h8B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_IO_FAST_READ                                  </b></td><td>  8'hCB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_OUTPUT_FAST_READ_DTR                          </b></td><td>  8'h9D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_OCTAL_OUTPUT_FAST_READ                    </b></td><td>  8'h7C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_OCTAL_IO_FAST_READ                        </b></td><td>  8'hCC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_OCTAL_IO_FAST_READ_DTR                    </b></td><td>  8'hFD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FLAG_STATUS_REGISTER                           </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_CONFIGURATION_REGISTER             </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_VOLATILE_CONFIGURATION_REGISTER                </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PROTECTION_MANAGEMENT_REGISTER                 </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_GENERAL_PURPOSE_READ_REGISTER                  </b></td><td>  8'h96   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_CONFIGURATION_REGISTER            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_CONFIGURATION_REGISTER               </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PROTECTION_MANAGEMENT_REGISTER                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_FLAG_STATUS_REGISTER                          </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> TUNING_DATA_PATTERN_OPERATION                       </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_INPUT_FAST_PROGRAM                            </b></td><td>  8'h82   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_OCTAL_INPUT_FAST_PROGRAM                   </b></td><td>  8'hC2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_OCTAL_INPUT_FAST_PROGRAM                  </b></td><td>  8'h84   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_EXTENDED_OCTAL_INPUT_FAST_PROGRAM         </b></td><td>  8'h8E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_128KB                                         </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE                                          </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_32KB                                </b></td><td>  8'h5C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_128KB                               </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECTOR_PROTECTION                              </b></td><td>  8'h2D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECTOR_PROTECTION                           </b></td><td>  8'h2C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_REGISTER                                  </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_REGISTER                                 </b></td><td>  8'hE5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_NONVOLATILE_LOCK_BITS                          </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_NONVOLATILE_LOCK_BITS                         </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_NONVOLATILE_LOCK_BITS                         </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_GLOBAL_FREEZE_BIT                              </b></td><td>  8'hA7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_GLOBAL_FREEZE_BIT                             </b></td><td>  8'hA6   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'h27   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'h28   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'h29   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ_LOCK_REGISTER                        </b></td><td>  8'hE0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_WRITE_LOCK_REGISTER                       </b></td><td>  8'hE1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INTERFACE_ACTIVATION                                </b></td><td>  8'h9B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MACRONIX       </b></td> <td> MX25R1635F             </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_SIGNATURE                           </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER                         </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_LENGTH                                    </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_SECURED_OTP_REGION                            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_SECURED_OTP_REGION                             </b></td><td>  8'hC1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RDSCUR                                              </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRSCUR                                              </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> NOP                                                 </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MACRONIX       </b></td> <td> MX25UM51245G           </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER                         </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER_2                       </b></td><td>  8'h71   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_CONFIGURATION_REGISTER_2                      </b></td><td>  8'h72   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_LENGTH                                    </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_64KB                                </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_SECURED_OTP_REGION                            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_SECURED_OTP_REGION                             </b></td><td>  8'hC1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RDSCUR                                              </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRSCUR                                              </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> NOP                                                 </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FAST_BOOT_REGISTER                             </b></td><td>  8'h16   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_FAST_BOOT_REGISTER                            </b></td><td>  8'h17   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_FAST_BOOT_REGISTER                            </b></td><td>  8'h18   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_DOWN_REGISTER                            </b></td><td>  8'h2C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_DOWN_REGISTER                             </b></td><td>  8'h2D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_SPB_REGISTER                                  </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SPB_REGISTER                                  </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SPB_REGISTER                                   </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DPB_REGISTER                                  </b></td><td>  8'hE1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_DPB_REGISTER                                   </b></td><td>  8'hE0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PROTECT_SELECT                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_LOCK                                     </b></td><td>  8'h7E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_UNLOCK                                   </b></td><td>  8'h98   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_IO_FAST_READ                                  </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_IO_FAST_READ_DTR                              </b></td><td>  8'hEE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'h27   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'h28   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'h29   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MACRONIX       </b></td> <td> MX25LM51245G           </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER                         </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER_2                       </b></td><td>  8'h71   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_CONFIGURATION_REGISTER_2                      </b></td><td>  8'h72   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_LENGTH                                    </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_64KB                                </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_SECURED_OTP_REGION                            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_SECURED_OTP_REGION                             </b></td><td>  8'hC1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RDSCUR                                              </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRSCUR                                              </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> NOP                                                 </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FAST_BOOT_REGISTER                             </b></td><td>  8'h16   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_FAST_BOOT_REGISTER                            </b></td><td>  8'h17   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_FAST_BOOT_REGISTER                            </b></td><td>  8'h18   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_LOCK_DOWN_REGISTER                            </b></td><td>  8'h2C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_LOCK_DOWN_REGISTER                             </b></td><td>  8'h2D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_SPB_REGISTER                                  </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SPB_REGISTER                                  </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SPB_REGISTER                                   </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DPB_REGISTER                                  </b></td><td>  8'hE1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_DPB_REGISTER                                   </b></td><td>  8'hE0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PROTECT_SELECT                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_LOCK                                     </b></td><td>  8'h7E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_UNLOCK                                   </b></td><td>  8'h98   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_IO_FAST_READ                                  </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> OCTAL_IO_FAST_READ_DTR                              </b></td><td>  8'hEE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'h27   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'h28   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'h29   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MACRONIX       </b></td> <td> MX25L6445E             </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE_DUAL_IO      </b></td><td>  8'hEF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE_QUAD_IO      </b></td><td>  8'hDF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE_QUAD_IO_DTR  </b></td><td>  8'hCF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_SECURED_OTP_REGION                            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_SECURED_OTP_REGION                             </b></td><td>  8'hC1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RDSCUR                                              </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRSCUR                                              </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CONTINUOUS_PROGRAM_MODE                             </b></td><td>  8'hAD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENABLE_SO_TO_OUTPUT                                 </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DISABLE_SO_TO_OUTPUT                                </b></td><td>  8'h80   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_SECURITY_REGISTER                             </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> HIGH_PERFORMANCE_ENABLE_MODE                        </b></td><td>  8'hA3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PROTECT_SELECT                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_LOCK                               </b></td><td>  8'h36   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_UNLOCK                             </b></td><td>  8'h39   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_BLOCK_LOCK                                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_LOCK                                     </b></td><td>  8'h7E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_UNLOCK                                   </b></td><td>  8'h98   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MACRONIX       </b></td> <td> MX25L12865E            </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE_DUAL_IO      </b></td><td>  8'hEF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE_QUAD_IO      </b></td><td>  8'hDF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE_QUAD_IO_DTR  </b></td><td>  8'hCF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_SECURED_OTP_REGION                            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_SECURED_OTP_REGION                             </b></td><td>  8'hC1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RDSCUR                                              </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRSCUR                                              </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CONTINUOUS_PROGRAM_MODE                             </b></td><td>  8'hAD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENABLE_SO_TO_OUTPUT                                 </b></td><td>  8'h70   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DISABLE_SO_TO_OUTPUT                                </b></td><td>  8'h80   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_SECURITY_REGISTER                             </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> HIGH_PERFORMANCE_ENABLE_MODE                        </b></td><td>  8'hA3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PROTECT_SELECT                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_LOCK                               </b></td><td>  8'h36   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_UNLOCK                             </b></td><td>  8'h39   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_BLOCK_LOCK                                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_LOCK                                     </b></td><td>  8'h7E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_UNLOCK                                   </b></td><td>  8'h98   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_PARALLEL_MODE                                 </b></td><td>  8'h55   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_PARALLEL_MODE                                  </b></td><td>  8'h45   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MACRONIX       </b></td> <td> MX25U3235F             </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_WORD_READ                                   </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PROTECT_SELECT                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QPI_MODE                                      </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QPI_MODE                                       </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_LENGTH                                    </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_QUAD_ID                                        </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_SECURED_OTP_REGION                            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_SECURED_OTP_REGION                             </b></td><td>  8'hC1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RDSCUR                                              </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRSCUR                                              </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_LOCK                               </b></td><td>  8'h36   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_UNLOCK                             </b></td><td>  8'h39   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_BLOCK_LOCK                                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_LOCK                                     </b></td><td>  8'h7E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_UNLOCK                                   </b></td><td>  8'h98   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> NOP                                                 </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SOFTWARE_RESET                                      </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MACRONIX       </b></td> <td> MX25U25635F            </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER                         </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_ADDRESS_REGISTER                      </b></td><td>  8'hC8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_EXTENDED_ADDRESS_REGISTER                     </b></td><td>  8'hC5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QPI_MODE                                      </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QPI_MODE                                       </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_START_FROM_TOP_SEGMENT            </b></td><td>  8'hEA   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_EXTENDED_QUAD_INPUT_FAST_PROGRAM          </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_32KB                                </b></td><td>  8'h5C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_128KB                               </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PROTECT_SELECT                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QPI_MODE                                      </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QPI_MODE                                       </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_LENGTH                                    </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FAST_BOOT_REGISTER                             </b></td><td>  8'h16   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_FAST_BOOT_REGISTER                            </b></td><td>  8'h17   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_FAST_BOOT_REGISTER                            </b></td><td>  8'h18   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_QUAD_ID                                        </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_SECURED_OTP_REGION                            </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_SECURED_OTP_REGION                             </b></td><td>  8'hC1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RDSCUR                                              </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRSCUR                                              </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> NOP                                                 </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SOFTWARE_RESET                                      </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> WINBOND        </b></td> <td> W25X_10BV              </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> W25X_20BV              </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> W25X_40BV              </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_DUAL_IO                 </b></td><td>  8'h92   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_UNIQUE_ID                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> WINBOND        </b></td> <td> W25Q_20BW              </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE_FOR_VOLATILE_STATUS_REGISTER           </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_2                              </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_WORD_READ                                   </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_OCTAL_WORD_READ                             </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_WITH_WRAP                                 </b></td><td>  8'h77   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_DUAL_IO                 </b></td><td>  8'h92   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_QUAD_IO                 </b></td><td>  8'h94   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_UNIQUE_ID                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SECURITY_REGISTERS                            </b></td><td>  8'h44   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECURITY_REGISTERS                          </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECURITY_REGISTERS                             </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> WINBOND        </b></td> <td> W25Q_16DW              </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE_FOR_VOLATILE_STATUS_REGISTER           </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_2                              </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_WORD_READ                                   </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_OCTAL_WORD_READ                             </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_WITH_WRAP                                 </b></td><td>  8'h77   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_DUAL_IO                 </b></td><td>  8'h92   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_QUAD_IO                 </b></td><td>  8'h94   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_UNIQUE_ID                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SECURITY_REGISTERS                            </b></td><td>  8'h44   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECURITY_REGISTERS                          </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECURITY_REGISTERS                             </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENABLE_QPI                                          </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DISABLE_QPI                                         </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_READ_PARAMETERS                                 </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BURST_READ_WITH_WRAP                                </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> WINBOND        </b></td> <td> W25Q_128BV             </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE_FOR_VOLATILE_STATUS_REGISTER           </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_2                              </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_WORD_READ                                   </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_OCTAL_WORD_READ                             </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_WITH_WRAP                                 </b></td><td>  8'h77   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_DUAL_IO                 </b></td><td>  8'h92   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_QUAD_IO                 </b></td><td>  8'h94   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_UNIQUE_ID                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SECURITY_REGISTERS                            </b></td><td>  8'h44   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECURITY_REGISTERS                          </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECURITY_REGISTERS                             </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> WINBOND        </b></td> <td> W25Q_256JW             </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE_FOR_VOLATILE_STATUS_REGISTER           </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_2                              </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_3                              </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER_2                             </b></td><td>  8'h31   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER_3                             </b></td><td>  8'h11   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_ADDRESS_REGISTER                      </b></td><td>  8'hC8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_EXTENDED_ADDRESS_REGISTER                     </b></td><td>  8'hC5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM                   </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_64KB                                </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_LOCK                                     </b></td><td>  8'h7E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_UNLOCK                                   </b></td><td>  8'h98   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_BLOCK_LOCK                                     </b></td><td>  8'h3D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_LOCK                               </b></td><td>  8'h36   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> INDIVIDUAL_BLOCK_UNLOCK                             </b></td><td>  8'h39   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_DUAL_IO                 </b></td><td>  8'h92   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID_QUAD_IO                 </b></td><td>  8'h94   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_UNIQUE_ID                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SECURITY_REGISTERS                            </b></td><td>  8'h44   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECURITY_REGISTERS                          </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECURITY_REGISTERS                             </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> CYPRESS        </b></td> <td> CY14V101Q3             </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SW_STORE                                            </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SW_RECALL                                           </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> AUTOSTORE_ENABLE                                    </b></td><td>  8'h59   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> AUTOSTORE_DISABLE                                   </b></td><td>  8'h19   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> CYPRESS        </b></td> <td> CY14V101QS             </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENABLE_DPI                                          </b></td><td>  8'h37   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENABLE_QPI                                          </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEFAULT_PROTOCOL_MODE                         </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER                         </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_CONFIGURATION_REGISTER                        </b></td><td>  8'h87   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_NUMBER_REGISTER                         </b></td><td>  8'hC3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_SERIAL_NUMBER_REGISTER                    </b></td><td>  8'hC9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_SERIAL_NUMBER_REGISTER                        </b></td><td>  8'hC2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_INPUT_FAST_PROGRAM                             </b></td><td>  8'hA2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_DUAL_INPUT_FAST_PROGRAM                    </b></td><td>  8'hA1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'hD2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_HIBERNATE_MODE                                </b></td><td>  8'hBA   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_ID                                        </b></td><td>  8'h9E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SW_STORE                                            </b></td><td>  8'h8C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SW_RECALL                                           </b></td><td>  8'h8D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> AUTOSTORE_ENABLE                                    </b></td><td>  8'h8E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> AUTOSTORE_DISABLE                                   </b></td><td>  8'h8F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE                                            </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> SPANSION       </b></td> <td> S25FL512S              </b></td><td> READ_ELECTRONIC_MANUFACTURER_SIGNATURE              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ELECTRONIC_SIGNATURE                           </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_2                              </b></td><td>  8'h07   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER                         </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_REGISTER                                      </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_STATUS_REGISTER                               </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_AUTOBOOT_REGISTER                              </b></td><td>  8'h14   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_AUTOBOOT_REGISTER                             </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_BANK_REGISTER                                  </b></td><td>  8'h16   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_BANK_REGISTER                                 </b></td><td>  8'h17   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ACCESS_BANK_REGISTER                                </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_DATA_LEARNING_PATTERN                          </b></td><td>  8'h41   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_NV_DATA_LEARNING_REGISTER                   </b></td><td>  8'h43   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_DATA_LEARNING_REGISTER               </b></td><td>  8'h4A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_DYB                                            </b></td><td>  8'hE0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DYB                                           </b></td><td>  8'hE1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PPB                                            </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PPB                                         </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_PPB                                           </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ASP                                            </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ASP                                         </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PPB_LOCK_BIT                                   </b></td><td>  8'hA7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PPB_LOCK_BIT                                  </b></td><td>  8'hA6   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ_DTR                             </b></td><td>  8'h0E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ_DTR                     </b></td><td>  8'hBE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ_DTR                     </b></td><td>  8'hEE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM                   </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM_2                           </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SUSPEND                                     </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_RESUME                                      </b></td><td>  8'h8A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE                                          </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_256KB                                         </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_256KB                               </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SUSPEND                                       </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_RESUME                                        </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SOFTWARE_RESET                                      </b></td><td>  8'hF0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> AUTOBOOT                                            </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> SPANSION       </b></td> <td> S25FS512S              </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_QUAD_ID                                        </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_2                              </b></td><td>  8'h07   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CONFIGURATION_REGISTER                         </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ANY_REGISTER                                   </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_REGISTER                                      </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ANY_REGISTER                                  </b></td><td>  8'h71   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_STATUS_REGISTER                               </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_STATUS_REGISTER_ALTERNATE                     </b></td><td>  8'h82   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_BURST_LENGTH                                    </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EVALUATE_ERASE_STATUS                               </b></td><td>  8'hD0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ECC_REGISTER                                   </b></td><td>  8'h19   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ_ECC_REGISTER                         </b></td><td>  8'h18   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_DATA_LEARNING_PATTERN                          </b></td><td>  8'h41   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_NV_DATA_LEARNING_REGISTER                   </b></td><td>  8'h43   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_VOLATILE_DATA_LEARNING_REGISTER               </b></td><td>  8'h4A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ_DTR                     </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_256KB                                         </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_256KB                               </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE                                          </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BULK_ERASE_2                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_3                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h8A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_3                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_ARRAY                                      </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_ARRAY                                   </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_READ_DYB                                 </b></td><td>  8'hFA   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_DYB                                            </b></td><td>  8'hE0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_WRITE_DYB                                </b></td><td>  8'hFB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DYB                                           </b></td><td>  8'hE1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_READ_PPB                                 </b></td><td>  8'hFC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PPB                                            </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_PROGRAM_PPB                              </b></td><td>  8'hFD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PPB                                         </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_PPB                                           </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ASP                                            </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ASP                                         </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PPB_LOCK_BIT                                   </b></td><td>  8'hA7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PPB_LOCK_BIT                                  </b></td><td>  8'hA6   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SOFTWARE_RESET                                      </b></td><td>  8'hF0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> STM            </b></td> <td> M95128                 </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_IDENTIFICATION_PAGE                            </b></td><td>  8'h83   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_IDENTIFICATION_PAGE                           </b></td><td>  8'h82   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> ADESTO         </b></td> <td> AT25SF321              </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE_FOR_VOLATILE_STATUS_REGISTER           </b></td><td>  8'h50   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER_2                              </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_SECURITY_REGISTERS                            </b></td><td>  8'h44   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_SECURITY_REGISTERS                          </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECURITY_REGISTERS                             </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> XIP_MODE_RESET                                      </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> ISSI           </b></td> <td> IS25WP128              </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM_2                           </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB_2                                         </b></td><td>  8'hD7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FUNCTION_REGISTER                              </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_FUNCTION_REGISTER                             </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QPI_MODE                                      </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QPI_MODE                                       </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_READ_PARAMETERS_NV                              </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_READ_PARAMETERS                                 </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_READ_PARAMETERS_2                               </b></td><td>  8'h63   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_EXTENDED_READ_PARAMETERS_NV                     </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_EXTENDED_READ_PARAMETERS                        </b></td><td>  8'h83   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_READ_PARAMETERS                                </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_READ_PARAMETERS                       </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID_QPI_MODE                              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_UNIQUE_ID                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> NOP                                                 </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SOFTWARE_RESET                                      </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_INFORMATION_ROW                               </b></td><td>  8'h64   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_INFORMATION_ROW                             </b></td><td>  8'h62   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_INFORMATION_ROW                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SECTOR_UNLOCK                                       </b></td><td>  8'h26   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SECTOR_LOCK                                         </b></td><td>  8'h24   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_AUTOBOOT_REGISTER                              </b></td><td>  8'h14   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_AUTOBOOT_REGISTER                             </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> ISSI           </b></td> <td> IS25WP256D             </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_OUTPUT_FAST_READ                               </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ                                   </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ_DTR                                       </b></td><td>  8'h0D   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DUAL_IO_FAST_READ_DTR                               </b></td><td>  8'hBD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ_DTR                               </b></td><td>  8'hED   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_READ                                      </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ                                 </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_OUTPUT_FAST_READ                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ                         </b></td><td>  8'hBC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_OUTPUT_FAST_READ                     </b></td><td>  8'h6C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ                         </b></td><td>  8'hEC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_FAST_READ_DTR                             </b></td><td>  8'h0E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_DUAL_IO_FAST_READ_DTR                     </b></td><td>  8'hBE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_IO_FAST_READ_DTR                     </b></td><td>  8'hEE   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM_2                           </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_PAGE_PROGRAM                              </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM                   </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM_2                 </b></td><td>  8'h3E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_4KB_2                                         </b></td><td>  8'hD7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_4KB                                 </b></td><td>  8'h21   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_32KB                                </b></td><td>  8'h5C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_ERASE_64KB                                </b></td><td>  8'hDC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_FUNCTION_REGISTER                              </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_FUNCTION_REGISTER                             </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'h48   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'h42   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QPI_MODE                                      </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QPI_MODE                                       </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'h75   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND_2                             </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'h7A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME_2                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_READ_PARAMETERS_NV                              </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_READ_PARAMETERS                                 </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_READ_PARAMETERS_2                               </b></td><td>  8'h63   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_EXTENDED_READ_PARAMETERS_NV                     </b></td><td>  8'h85   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_EXTENDED_READ_PARAMETERS                        </b></td><td>  8'h83   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_READ_PARAMETERS                                </b></td><td>  8'h61   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_EXTENDED_READ_PARAMETERS                       </b></td><td>  8'h81   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CLEAR_EXTENDED_READ_PARAMETERS                      </b></td><td>  8'h82   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_JEDEC_ID_QPI_MODE                              </b></td><td>  8'h90   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'hAF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_UNIQUE_ID                                      </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> NOP                                                 </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SOFTWARE_RESET                                      </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_INFORMATION_ROW                               </b></td><td>  8'h64   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_INFORMATION_ROW                             </b></td><td>  8'h62   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_INFORMATION_ROW                                </b></td><td>  8'h68   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SECTOR_UNLOCK                                       </b></td><td>  8'h26   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SECTOR_LOCK                                         </b></td><td>  8'h24   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FOUR_BYTE_SECTOR_UNLOCK                             </b></td><td>  8'h25   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SECTOR_LOCK                                         </b></td><td>  8'h24   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_AUTOBOOT_REGISTER                              </b></td><td>  8'h14   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_AUTOBOOT_REGISTER                             </b></td><td>  8'h15   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_BANK_REGISTER                                  </b></td><td>  8'h16   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_BANK_REGISTER_2                                </b></td><td>  8'hC8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_BANK_REGISTER                                 </b></td><td>  8'h17   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_BANK_REGISTER_2                               </b></td><td>  8'hC5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_BANK_REGISTER_NV                              </b></td><td>  8'h18   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_FOUR_BYTE_ADDRESS_MODE                        </b></td><td>  8'hB7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_FOUR_BYTE_ADDRESS_MODE                         </b></td><td>  8'h29   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_READ_DYB                                 </b></td><td>  8'hFA   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_DYB                                            </b></td><td>  8'hE0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_WRITE_DYB                                </b></td><td>  8'hFB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DYB                                           </b></td><td>  8'hE1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_READ_PPB                                 </b></td><td>  8'hFC   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PPB                                            </b></td><td>  8'hE2   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> THREE_BYTE_PROGRAM_PPB                              </b></td><td>  8'hFD   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PPB                                         </b></td><td>  8'hE3   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_PPB                                           </b></td><td>  8'hE4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ASP                                            </b></td><td>  8'h2B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ASP                                         </b></td><td>  8'h2F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PPB_LOCK_BIT                                   </b></td><td>  8'hA7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_PPB_LOCK_BIT                                  </b></td><td>  8'hA6   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_FREEZE_BIT                                      </b></td><td>  8'h91   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PASSWORD                                       </b></td><td>  8'hE7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_PASSWORD                                    </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNLOCK_PASSWORD                                     </b></td><td>  8'hE9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_LOCK                                     </b></td><td>  8'h7E   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GANG_BLOCK_UNLOCK                                   </b></td><td>  8'h98   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> MICROCHIP      </b></td> <td> MC23A1024              </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DUAL                                          </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QUAD                                          </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_DUAL_AND_QUAD                                  </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MODE_REGISTER                                  </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_MODE_REGISTER                                 </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> APMEMORY       </b></td> <td> APS6408LOAx7           </b></td><td> SYNC_READ                                           </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS6408LOAx5           </b></td><td> SYNC_WRITE                                          </b></td><td>  8'h80   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS3208LOAx7           </b></td><td> LINEAR_BURST_SYNC_READ                              </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS3208LOAx5           </b></td><td> LINEAR_BURST_SYNC_WRITE                             </b></td><td>  8'hA0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS12808LOAx7          </b></td><td> READ_MODE_REGISTER                                  </b></td><td>  8'h40   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS12808LOAx5          </b></td><td> WRITE_MODE_REGISTER                                 </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GLOBAL_RESET                                        </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_HALF_SLEEP                                     </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> APMEMORY       </b></td> <td> APS6408LOBx7           </b></td><td> SYNC_READ                                           </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS6408LOBx5           </b></td><td> SYNC_WRITE                                          </b></td><td>  8'h80   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS3208LOBx7           </b></td><td> LINEAR_BURST_SYNC_READ                              </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS3208LOBx5           </b></td><td> LINEAR_BURST_SYNC_WRITE                             </b></td><td>  8'hA0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS12808LOBx7          </b></td><td> READ_MODE_REGISTER                                  </b></td><td>  8'h40   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS12808LOBx5          </b></td><td> WRITE_MODE_REGISTER                                 </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GLOBAL_RESET                                        </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_HALF_SLEEP                                     </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> APMEMORY       </b></td> <td> APS256XXNOBRx7         </b></td><td> SYNC_READ                                           </b></td><td>  8'h00   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS256XXNOBRx5         </b></td><td> SYNC_WRITE                                          </b></td><td>  8'h80   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS512XXNOBRx7         </b></td><td> LINEAR_BURST_SYNC_READ                              </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS512XXNOBRx5         </b></td><td> LINEAR_BURST_SYNC_WRITE                             </b></td><td>  8'hA0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS25608NOBRx7         </b></td><td> READ_MODE_REGISTER                                  </b></td><td>  8'h40   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS25608NOBRx5         </b></td><td> WRITE_MODE_REGISTER                                 </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS51208NOBRx7         </b></td><td> GLOBAL_RESET                                        </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> APS51208NOBRx5         </b></td><td> EXIT_HALF_SLEEP                                     </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> APMEMORY       </b></td> <td> APS1604MSQR            </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE                                               </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_WRITE                                          </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRAPPED_READ                                        </b></td><td>  8'h8B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRAPPED_WRITE                                       </b></td><td>  8'h82   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MODE_REGISTER                                  </b></td><td>  8'hB5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_MODE_REGISTER                                 </b></td><td>  8'hB1   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QUAD                                          </b></td><td>  8'h35   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_QUAD                                           </b></td><td>  8'hF5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_ENABLE                                        </b></td><td>  8'h66   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET_MEMORY                                        </b></td><td>  8'h99   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BURST_LENGTH_TOGGLE                                 </b></td><td>  8'hC0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> EVERSPIN       </b></td> <td> MR10Q010               </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENABLE_QPI                                          </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> DISABLE_QPI                                         </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_OUTPUT_FAST_READ                               </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_IO_FAST_READ                                   </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> QUAD_INPUT_FAST_PROGRAM                             </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXTENDED_QUAD_INPUT_FAST_PROGRAM                    </b></td><td>  8'h12   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> TAMPER_DETECT                                       </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> EXIT_TAMPER_DETECT                                  </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h4B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *    <tr><td><b> APMEMORY       </b></td> <td> APS6404LSQR            </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b> GIGADEVICE     </b></td> <td> GD5F1GQ4               </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> GD5F1GQ4RB             </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GET_FEATURES                                        </b></td><td>  8'h0F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_FEATURES                                        </b></td><td>  8'h1F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_READ                                           </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_1                                        </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_2                                        </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_X2                                       </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_X4                                       </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_DUAL_IO                                  </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_QUAD_IO                                  </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_X4                                     </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_EXECUTE                                     </b></td><td>  8'h10   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_RANDOM_DATA                            </b></td><td>  8'h84   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_RANDOM_DATA_X4_1                       </b></td><td>  8'hC4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_RANDOM_DATA_X4_2                       </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_RANDOM_DATA_QUAD_IO                    </b></td><td>  8'h72   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_128KB                                         </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET                                               </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b> MICRON(NAND)   </b></td> <td> MT29F1G01AAADD         </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GET_FEATURES                                        </b></td><td>  8'h0F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_FEATURES                                        </b></td><td>  8'h1F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_READ                                           </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_1                                        </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_2                                        </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_X2                                       </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_X4                                       </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_EXECUTE                                     </b></td><td>  8'h10   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_RANDOM_DATA                            </b></td><td>  8'h84   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_128KB                                         </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET                                               </b></td><td>  8'hFF   </b></td><tr>  
 *    <tr><td><b> MICRON(NAND)   </b></td> <td> MT29F2G01ABBGDSF       </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> GET_FEATURES                                        </b></td><td>  8'h0F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SET_FEATURES                                        </b></td><td>  8'h1F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_READ                                           </b></td><td>  8'h13   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PAGE_CACHE_RANDOM                              </b></td><td>  8'h30   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_PAGE_CACHE_LAST                                </b></td><td>  8'h3F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_1                                        </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_2                                        </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_X2                                       </b></td><td>  8'h3B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_X4                                       </b></td><td>  8'h6B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_DUAL_IO                                  </b></td><td>  8'hBB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_CACHE_QUAD_IO                                  </b></td><td>  8'hEB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ID                                             </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_X4                                     </b></td><td>  8'h32   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_EXECUTE                                     </b></td><td>  8'h10   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_RANDOM_DATA                            </b></td><td>  8'h84   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_LOAD_RANDOM_DATA_X4_2                       </b></td><td>  8'h34   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PERMANENT_BLOCK_LOCK_PROTECTION                     </b></td><td>  8'h2C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_128KB                                         </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RESET                                               </b></td><td>  8'hFF   </b></td><tr>  
 *   </tbody>
 *  </table>
 * <br/> 
 * <br/> 
 * <br/> 
 * <table border="1" cellpadding="1" cellspacing="1"">
 *   <thead>
 *    <tr><th bgcolor="#dddddd" colspan="4"><b>**This table specifies enum encoding for xSPI Flash Command in respective part number. </b></th></tr>
 *    <tr><th bgcolor="#dddddd"><b> Vendor   </b></th><th bgcolor="#dddddd"> Part Number </th><th bgcolor="#dddddd"><b> Command Enum </b></th><th bgcolor="#dddddd"><b> Command Opcode </b></th></tr>
 *   </thead>
 *   <tbody>
 *    <tr><td><b> ADESTO         </b></td> <td> ATXP032                </b></td><td> FAST_READ                                           </b></td><td>  8'h0B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> ATXP032R               </b></td><td> ERASE_4KB                                           </b></td><td>  8'h20   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_32KB                                          </b></td><td>  8'h52   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ERASE_64KB                                          </b></td><td>  8'hD8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_1                                        </b></td><td>  8'h60   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> CHIP_ERASE_2                                        </b></td><td>  8'hC7   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PAGE_PROGRAM                                        </b></td><td>  8'h02   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BUFFER_WRITE                                        </b></td><td>  8'h84   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BUFFER_TO_MEMORY_WRITE                              </b></td><td>  8'h88   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_SUSPEND                               </b></td><td>  8'hB0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_ERASE_RESUME                                </b></td><td>  8'hD0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ENABLE                                        </b></td><td>  8'h06   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_DISABLE                                       </b></td><td>  8'h04   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROTECT_SECTOR                                      </b></td><td>  8'h36   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> UNPROTECT_SECTOR                                    </b></td><td>  8'h39   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SECTOR_PROTECTION_REGISTER                     </b></td><td>  8'h3C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> PROGRAM_OTP_SECURITY_REGISTER                       </b></td><td>  8'h9B   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_OTP_SECURITY_REGISTER                          </b></td><td>  8'h77   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_ANY_REGISTER                                   </b></td><td>  8'h65   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_STATUS_REGISTER                                </b></td><td>  8'h05   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ACTIVE_STATUS_INTERRUPT                             </b></td><td>  8'h25   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_ANY_REGISTER                                  </b></td><td>  8'h71   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER                               </b></td><td>  8'h01   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> WRITE_STATUS_REGISTER_2                             </b></td><td>  8'h31   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> SOFTWARE_RESET                                      </b></td><td>  8'hF0   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEEP_POWER_DOWN                               </b></td><td>  8'hB9   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> RELEASE_FROM_DEEP_POWER_DOWN                        </b></td><td>  8'hAB   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_ULTRA_DEEP_POWER_DOWN                         </b></td><td>  8'h79   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_SERIAL_FLASH_DISCOVERY_PARAMETER               </b></td><td>  8'h5A   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ                                                </b></td><td>  8'h03   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BUFFER_READ                                         </b></td><td>  8'hD4   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> READ_MANUFACTURER_DEVICE_ID                         </b></td><td>  8'h9F   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_QPI_MODE                                      </b></td><td>  8'h38   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_OCTAL_MODE                                    </b></td><td>  8'hE8   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> BURST_READ_WITH_WRAP                                </b></td><td>  8'h0C   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ECHO                                                </b></td><td>  8'hAA   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ECHO_WITH_INVERSION                                 </b></td><td>  8'hA5   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> ENTER_DEFAULT_PROTOCOL_MODE                         </b></td><td>  8'hFF   </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> JEDEC_HARDWARE_RESET                                </b></td><td>          </b></td><tr>
 *    <tr><td><b>                </b></td> <td> &nbsp                  </b></td><td> &nbsp                                               </b></td><td>  &nbsp   </b></td><tr>
 *   </tbody>
 *  </table>
 */ 
  typedef enum bit[8:0] {
    RESET_ENABLE                                    ,
    RESET_MEMORY                                    ,
    READ_ID_1                                       ,
    READ_ID_2                                       ,
    MULTIPLE_IO_READ_ID                             ,
    READ_SERIAL_FLASH_DISCOVERY_PARAMETER           ,
    READ                                            ,
    FAST_READ                                       ,
    DUAL_OUTPUT_FAST_READ                           ,
    DUAL_IO_FAST_READ                               ,
    QUAD_OUTPUT_FAST_READ                           ,
    QUAD_IO_FAST_READ                               ,
    QUAD_IO_FAST_READ_START_FROM_TOP_SEGMENT        ,
    QUAD_IO_WORD_READ                               ,  
    QUAD_IO_OCTAL_WORD_READ                         ,
    OCTAL_OUTPUT_FAST_READ                          ,
    OCTAL_IO_FAST_READ                              ,
    SET_BURST_WITH_WRAP                             ,
    FAST_READ_DTR                                   ,
    DUAL_OUTPUT_FAST_READ_DTR                       ,
    DUAL_IO_FAST_READ_DTR                           ,
    QUAD_OUTPUT_FAST_READ_DTR                       ,
    QUAD_IO_FAST_READ_DTR                           ,
    OCTAL_OUTPUT_FAST_READ_DTR                      ,
    FOUR_BYTE_READ                                  ,
    FOUR_BYTE_FAST_READ                             ,
    FOUR_BYTE_DUAL_OUTPUT_FAST_READ                 ,
    FOUR_BYTE_DUAL_IO_FAST_READ                     ,
    FOUR_BYTE_QUAD_OUTPUT_FAST_READ                 ,
    FOUR_BYTE_QUAD_IO_FAST_READ                     ,
    FOUR_BYTE_OCTAL_OUTPUT_FAST_READ                ,
    FOUR_BYTE_OCTAL_IO_FAST_READ                    ,
    FOUR_BYTE_OCTAL_IO_FAST_READ_DTR                ,
    WRITE_ENABLE                                    ,
    WRITE_ENABLE_FOR_VOLATILE_STATUS_REGISTER       ,
    WRITE_DISABLE                                   ,
    READ_STATUS_REGISTER                            ,
    WRITE_STATUS_REGISTER                           ,
    WRITE_STATUS_REGISTER_2                         ,
    WRITE_STATUS_REGISTER_3                         ,
    WRITE_CONFIGURATION_REGISTER_2                  ,
    READ_LOCK_REGISTER                              ,
    WRITE_LOCK_REGISTER                             ,
    READ_FLAG_STATUS_REGISTER                       ,
    CLEAR_FLAG_STATUS_REGISTER                      ,
    READ_NONVOLATILE_CONFIGURATION_REGISTER         ,
    WRITE_NONVOLATILE_CONFIGURATION_REGISTER        ,
    READ_VOLATILE_CONFIGURATION_REGISTER            ,
    WRITE_VOLATILE_CONFIGURATION_REGISTER           ,
    READ_ENHANCED_VOLATILE_CONFIGURATION_REGISTER   ,
    WRITE_ENHANCED_VOLATILE_CONFIGURATION_REGISTER  ,
    READ_EXTENDED_ADDRESS_REGISTER                  ,
    WRITE_EXTENDED_ADDRESS_REGISTER                 ,
    READ_GENERAL_PURPOSE_READ_REGISTER              ,
    READ_PROTECTION_MANAGEMENT_REGISTER             , 
    WRITE_PROTECTION_MANAGEMENT_REGISTER            , 
    TUNING_DATA_PATTERN_OPERATION                   ,
    PAGE_PROGRAM                                    ,
    DUAL_INPUT_FAST_PROGRAM                         ,
    EXTENDED_DUAL_INPUT_FAST_PROGRAM                ,
    QUAD_INPUT_FAST_PROGRAM                         ,
    EXTENDED_QUAD_INPUT_FAST_PROGRAM                ,
    OCTAL_INPUT_FAST_PROGRAM                        ,
    EXTENDED_OCTAL_INPUT_FAST_PROGRAM               ,
    ERASE_4KB                                       ,
    ERASE_64KB                                      ,
    DIE_ERASE                                       ,
    PROGRAM_ERASE_RESUME                            ,
    PROGRAM_ERASE_RESUME_2                          ,
    PROGRAM_ERASE_RESUME_3                          ,
    PROGRAM_ERASE_SUSPEND                           ,
    PROGRAM_ERASE_SUSPEND_2                         ,
    PROGRAM_ERASE_SUSPEND_3                         ,
    READ_OTP_ARRAY                                  ,
    PROGRAM_OTP_ARRAY                               ,
    ENTER_FOUR_BYTE_ADDRESS_MODE                    ,
    EXIT_FOUR_BYTE_ADDRESS_MODE                     ,
    FOUR_BYTE_PAGE_PROGRAM                          ,
    FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM               ,
    FOUR_BYTE_EXTENDED_QUAD_INPUT_FAST_PROGRAM      ,
    FOUR_BYTE_OCTAL_INPUT_FAST_PROGRAM              ,
    FOUR_BYTE_EXTENDED_OCTAL_INPUT_FAST_PROGRAM     ,
    FOUR_BYTE_ERASE_4KB                             ,
    FOUR_BYTE_ERASE_32KB                            ,
    FOUR_BYTE_ERASE_64KB                            ,
    FOUR_BYTE_ERASE_128KB                           ,
    FOUR_BYTE_ERASE_256KB                           ,   
    BULK_ERASE                                      ,
    ENTER_QUAD                                      ,
    EXIT_QUAD                                       ,
    ENTER_DEEP_POWER_DOWN                           ,
    RELEASE_FROM_DEEP_POWER_DOWN                    ,
    ERASE_32KB                                      ,
    CHIP_ERASE_1                                    ,
    CHIP_ERASE_2                                    ,
    READ_MANUFACTURER_DEVICE_ID                     ,
    READ_MANUFACTURER_DEVICE_ID_DUAL_IO             ,
    READ_MANUFACTURER_DEVICE_ID_QUAD_IO             ,
    READ_JEDEC_ID                                   ,
    READ_UNIQUE_ID                                  ,
    PROTOCOL_RESET                                  ,
    XIP_MODE_RESET                                  ,  
    XIP_MODE                                        , 
    SW_STORE                                        ,
    SW_RECALL                                       ,
    AUTOSTORE_ENABLE                                ,
    AUTOSTORE_DISABLE                               ,
    HW_RECALL                                       ,
    HW_STORE                                        ,
    AUTOSTORE                                       ,
    READ_ELECTRONIC_MANUFACTURER_SIGNATURE          ,   
    READ_ELECTRONIC_MANUFACTURER_SIGNATURE_DUAL_IO  ,   
    READ_ELECTRONIC_MANUFACTURER_SIGNATURE_QUAD_IO  ,   
    READ_ELECTRONIC_MANUFACTURER_SIGNATURE_QUAD_IO_DTR  ,   
    READ_ID                                         ,   
    READ_QUAD_ID                                    ,   
    READ_ELECTRONIC_SIGNATURE                       ,   
    READ_STATUS_REGISTER_2                          ,   
    READ_STATUS_REGISTER_3                          ,   
    READ_CONFIGURATION_REGISTER                     ,   
    READ_CONFIGURATION_REGISTER_2                   ,
    WRITE_REGISTER                                  ,   
    WRITE_CONFIGURATION_REGISTER                    ,   
    CLEAR_STATUS_REGISTER                           ,   
    CLEAR_STATUS_REGISTER_ALTERNATE                 ,
    READ_AUTOBOOT_REGISTER                          ,   
    WRITE_AUTOBOOT_REGISTER                         ,   
    READ_BANK_REGISTER                              ,   
    WRITE_BANK_REGISTER                             ,   
    ACCESS_BANK_REGISTER                            ,   
    READ_DATA_LEARNING_PATTERN                      ,   
    PROGRAM_NV_DATA_LEARNING_REGISTER               ,   
    WRITE_VOLATILE_DATA_LEARNING_REGISTER           ,   
    READ_DYB                                        , 
    WRITE_DYB                                       , 
    READ_PPB                                        , 
    PROGRAM_PPB                                     , 
    ERASE_PPB                                       , 
    READ_ASP                                        , 
    PROGRAM_ASP                                     , 
    READ_PPB_LOCK_BIT                               , 
    WRITE_PPB_LOCK_BIT                              , 
    READ_PASSWORD                                   , 
    PROGRAM_PASSWORD                                , 
    UNLOCK_PASSWORD                                 , 
    FOUR_BYTE_FAST_READ_DTR                         ,   
    FOUR_BYTE_DUAL_IO_FAST_READ_DTR                 ,   
    FOUR_BYTE_QUAD_IO_FAST_READ_DTR                 ,   
    QUAD_INPUT_FAST_PROGRAM_2                       ,
    FOUR_BYTE_QUAD_INPUT_FAST_PROGRAM_2             ,
    PROGRAM_SUSPEND                                 ,   
    PROGRAM_RESUME                                  ,   
    BULK_ERASE_2                                    ,   
    ERASE_256KB                                     ,   
    ERASE_SUSPEND                                   ,   
    ERASE_RESUME                                    ,   
    SOFTWARE_RESET                                  ,
    AUTOBOOT                                        ,
    GET_FEATURES                                    ,  
    SET_FEATURES                                    , 
    PAGE_READ                                       ,
    READ_PAGE_CACHE_RANDOM                          ,
    READ_PAGE_CACHE_LAST                            ,
    READ_CACHE_1                                    ,
    READ_CACHE_2                                    ,
    READ_CACHE_X2                                   ,           
    READ_CACHE_X4                                   ,           
    READ_CACHE_DUAL_IO                              ,    
    READ_CACHE_QUAD_IO                              ,   
    PROGRAM_LOAD                                    ,        
    PROGRAM_LOAD_X4                                 ,     
    PROGRAM_EXECUTE                                 ,     
    PROGRAM_LOAD_RANDOM_DATA                        ,                  
    PROGRAM_LOAD_RANDOM_DATA_X4_1                   ,               
    PROGRAM_LOAD_RANDOM_DATA_X4_2                   ,               
    PERMANENT_BLOCK_LOCK_PROTECTION                 ,               
    PROGRAM_LOAD_RANDOM_DATA_QUAD_IO                ,                     
    ERASE_128KB                                     ,
    ERASE_SECURITY_REGISTERS                        ,
    PROGRAM_SECURITY_REGISTERS                      ,
    READ_SECURITY_REGISTERS                         ,
    RDSCUR                                          ,
    WRSCUR                                          ,
    SET_BURST_LENGTH                                ,
    ENTER_SECURED_OTP_REGION                        ,
    EXIT_SECURED_OTP_REGION                         ,
    ENABLE_DPI                                      ,                              
    ENABLE_QPI                                      ,                              
    DISABLE_QPI                                     ,
    SET_READ_PARAMETERS                             ,
    BURST_READ_WITH_WRAP                            ,
    READ_SECTOR_PROTECTION                          ,
    PROGRAM_SECTOR_PROTECTION                       ,
    READ_NONVOLATILE_LOCK_BITS                      ,
    WRITE_NONVOLATILE_LOCK_BITS                     ,
    ERASE_NONVOLATILE_LOCK_BITS                     ,
    READ_GLOBAL_FREEZE_BIT                          ,
    WRITE_GLOBAL_FREEZE_BIT                         ,
    FOUR_BYTE_READ_LOCK_REGISTER                    ,
    FOUR_BYTE_WRITE_LOCK_REGISTER                   ,
    INTERFACE_ACTIVATION                            ,
    NOP                                             ,
    RESET                                           ,
    READ_FAST_BOOT_REGISTER                         , 
    WRITE_FAST_BOOT_REGISTER                        , 
    ERASE_FAST_BOOT_REGISTER                        , 
    WRITE_LOCK_DOWN_REGISTER                        , 
    READ_LOCK_DOWN_REGISTER                         , 
    WRITE_SPB_REGISTER                              , 
    ERASE_SPB_REGISTER                              , 
    READ_SPB_REGISTER                               , 
    WRITE_DPB_REGISTER                              , 
    READ_DPB_REGISTER                               , 
    WRITE_PROTECT_SELECT                            , 
    GANG_BLOCK_LOCK                                 , 
    GANG_BLOCK_UNLOCK                               , 
    READ_BLOCK_LOCK                                 , 
    INDIVIDUAL_BLOCK_LOCK                           ,
    INDIVIDUAL_BLOCK_UNLOCK                         ,
    OCTAL_IO_FAST_READ_DTR                          ,      
    READ_IDENTIFICATION_PAGE                        ,
    WRITE_IDENTIFICATION_PAGE                       ,
    ERASE_4KB_2                                     ,
    READ_JEDEC_ID_QPI_MODE                          ,
    SET_READ_PARAMETERS_2                           ,
    READ_FUNCTION_REGISTER                          ,
    WRITE_FUNCTION_REGISTER                         ,
    ENTER_QPI_MODE                                  ,
    EXIT_QPI_MODE                                   ,
    SET_READ_PARAMETERS_NV                          ,
    SET_EXTENDED_READ_PARAMETERS                    ,
    SET_EXTENDED_READ_PARAMETERS_NV                 ,
    READ_READ_PARAMETERS                            ,
    READ_EXTENDED_READ_PARAMETERS                   ,
    READ_INFORMATION_ROW                            ,
    PROGRAM_INFORMATION_ROW                         ,
    ERASE_INFORMATION_ROW                           ,
    SECTOR_UNLOCK                                   ,
    SECTOR_LOCK                                     ,
    FOUR_BYTE_SECTOR_UNLOCK                         ,
    THREE_BYTE_READ_DYB                             , 
    THREE_BYTE_WRITE_DYB                            , 
    THREE_BYTE_READ_PPB                             , 
    THREE_BYTE_PROGRAM_PPB                          , 
    CLEAR_EXTENDED_READ_REGISTER                    ,
    READ_BANK_REGISTER_2                            , 
    WRITE_BANK_REGISTER_2                           , 
    WRITE_BANK_REGISTER_NV                          ,
    SET_FREEZE_BIT                                  ,
    ENTER_DUAL                                      , 
    EXIT_DUAL_AND_QUAD                              , 
    READ_MODE_REGISTER                              , 
    WRITE_MODE_REGISTER                             , 
    SYNC_READ                                       , 
    SYNC_WRITE                                      , 
    LINEAR_BURST_SYNC_READ                          , 
    LINEAR_BURST_SYNC_WRITE                         , 
    GLOBAL_RESET                                    , 
    ENTER_HALF_SLEEP                                ,
    EXIT_HALF_SLEEP                                 ,
    CONTINUOUS_PROGRAM_MODE                         , 
    ENABLE_SO_TO_OUTPUT                             , 
    DISABLE_SO_TO_OUTPUT                            , 
    CLEAR_SECURITY_REGISTER                         ,
    HIGH_PERFORMANCE_ENABLE_MODE                    , 
    ENTER_PARALLEL_MODE                             ,
    EXIT_PARALLEL_MODE                              ,
    READ_ANY_REGISTER                               ,
    WRITE_ANY_REGISTER                              ,
    EVALUATE_ERASE_STATUS                           ,
    READ_ECC_REGISTER                               ,
    FOUR_BYTE_READ_ECC_REGISTER                     ,
    WRITE                                           ,
    QUAD_WRITE                                      ,
    WRAPPED_READ                                    ,
    WRAPPED_WRITE                                   ,
    BURST_LENGTH_TOGGLE                             ,
    ENTER_OCTAL_MODE                                , 
    ENTER_DEFAULT_PROTOCOL_MODE                     , 
    BUFFER_READ                                     , 
    BUFFER_WRITE                                    , 
    BUFFER_TO_MEMORY_WRITE                          , 
    PROTECT_SECTOR                                  , 
    UNPROTECT_SECTOR                                , 
    READ_SECTOR_PROTECTION_REGISTER                 ,
    READ_OTP_SECURITY_REGISTER                      , 
    PROGRAM_OTP_SECURITY_REGISTER                   , 
    ACTIVE_STATUS_INTERRUPT                         , 
    ENTER_ULTRA_DEEP_POWER_DOWN                     , 
    ECHO                                            , 
    ECHO_WITH_INVERSION                             , 
    JEDEC_HARDWARE_RESET                            ,  
    TAMPER_DETECT                                   ,
    EXIT_TAMPER_DETECT                              ,
    READ_SERIAL_NUMBER_REGISTER                     ,
    FAST_READ_SERIAL_NUMBER_REGISTER                ,
    WRITE_SERIAL_NUMBER_REGISTER                    ,
    ENTER_HIBERNATE_MODE                            ,
    FAST_READ_ID                                    ,
    PRFL_2_0_READ_MEMORY_WRAPPED                    ,
    PRFL_2_0_READ_MEMORY_LINEAR                     ,
    PRFL_2_0_WRITE_MEMORY_WRAPPED                   ,
    PRFL_2_0_WRITE_MEMORY_LINEAR                    ,
    PRFL_2_0_READ_REGISTER_WRAPPED                  ,
    PRFL_2_0_READ_REGISTER_LINEAR                   ,
    PRFL_2_0_WRITE_REGISTER_WRAPPED                 ,
    PRFL_2_0_WRITE_REGISTER_LINEAR                  ,
    PRFL_2_0_STATUS_REGISTER_ENABLE                 ,
    PRFL_2_0_STATUS_REGISTER_READ                   ,
    PRFL_2_0_STATUS_REGISTER_CLEAR                  ,
    PRFL_2_0_WRITE_ENABLE1                          ,
    PRFL_2_0_WRITE_ENABLE2                          ,
    PRFL_2_0_ENTER_DEFAULT_PROTOCOL_MODE            ,
    PRFL_2_0_CONF_REGISTER_LOAD                     ,
    PRFL_2_0_CONF_REGISTER_LOAD_EXTN                ,
    PRFL_2_0_CONF_REGISTER_READ                     ,
    PRFL_2_0_CONF_REGISTER_READ_EXTN                ,
    PRFL_2_0_NV_CONF_REGISTER_PROGRAM               ,
    PRFL_2_0_NV_CONF_REGISTER_PROGRAM_EXTN          ,
    PRFL_2_0_NV_CONF_REGISTER_READ                  ,
    PRFL_2_0_NV_CONF_REGISTER_READ_EXTN             ,
    PRFL_2_0_NV_CONF_REGISTER_ERASE                 ,
    PRFL_2_0_WORD_PROGRAM                           ,
    PRFL_2_0_WORD_PROGRAM_EXTN                      ,
    PRFL_2_0_WRITE_BUFFER                           ,
    PRFL_2_0_WRITE_BUFFER_EXTN1                     ,
    PRFL_2_0_WRITE_BUFFER_EXTN2                     ,
    PRFL_2_0_WRITE_BUFFER_PROGRAM                   ,
    PRFL_2_0_ERASE_ENTER                            ,
    PRFL_2_0_ERASE_EXTN1                            ,
    PRFL_2_0_ERASE_EXTN2                            ,
    PRFL_2_0_ERASE_SECTOR                           ,
    PRFL_2_0_ERASE_CHIP                             ,
    PRFL_2_0_PROGRAM_SUSPEND                        ,
    PRFL_2_0_PROGRAM_RESUME                         ,
    PRFL_2_0_ERASE_SUSPEND                          ,
    PRFL_2_0_ERASE_RESUME                           ,
    PRFL_2_0_ENTER_DEEP_POWER_DOWN                  ,
    PRFL_2_0_READ_SFDP                              ,
    PRFL_2_0_READ_SFDP_EXTN                         ,     
    NULL_OPCODE                                        
  } flash_command_enum;                             
                                                    
  typedef enum bit [2:0] {
    EXTENDED_SPI   = `SVT_SPI_EXTENDED_SPI,
    DUAL_IO        = `SVT_DUAL_IO,
    QUAD_IO        = `SVT_QUAD_IO,
    OCTAL_IO_STR   = `SVT_OCTAL_IO_STR,
    OCTAL_IO_DTR   = `SVT_OCTAL_IO_DTR,
    UNDEF          = `SVT_UNDEF_PROTOCOL
  } flash_protocol_mode_enum;

  typedef enum bit [3:0] {
    WRITE_REGISTER_TYPE,
    READ_REGISTER_TYPE,
    PROGRAM_MEMORY_TYPE,
    ERASE_MEMORY_TYPE,
    READ_MEMORY_TYPE,
    IDENTIFICATION_TYPE,
    OTP_OPERATIONS_TYPE,
    SUSPEND_RESUME_TYPE,
    XIP_MEMORY_TYPE,
    RESET_OPERATIONS_TYPE,
    DEEP_POWER_OPERATIONS_TYPE,
    ULTRA_DEEP_POWER_OPERATIONS_TYPE,
    HALF_SLEEP_OPERATIONS_TYPE,
    STORE_RECALL_TYPE, 
    PRFL_2_0_ASO_ENTRY_TYPE
  } flash_command_type_enum;

  typedef enum bit[3:0] {
    STANDBY_STATE,
    PROGRAM_ERASE_STATE,
    CONTINUOUS_PROGRAM_STATE,
    SUSPEND_STATE,
    ERASE_SUSPEND_STATE,
    PROGRAM_ERASE_ERROR_STATE,
    EVALUATE_ERASE_STATE,
    DEEP_POWER_STATE,
    EXIT_DEEP_POWER_STATE,
    ULTRA_DEEP_POWER_STATE,
    HALF_SLEEP_STATE,
    EXIT_HALF_SLEEP_STATE,
    SOFTWARE_RESET_STATE,
    JEDEC_HARDWARE_RESET_STATE
  } flash_device_state_type;

  typedef enum bit[2:0] {
    IDLE_STATE,
    TRANSMIT_RECEIVE_STATE
  } device_state_type;

  typedef enum int {
    OPERATION_SUCCESS,
    OPERATION_SUSPEND,
    OPERATION_IN_PROGRESS,
    OPERATION_ERROR
  } flash_status_enum;

  typedef enum bit[1:0] {
    SLAVE_SELECT_ADDR_MATCHED,
    SLAVE_SELECT_ADDR_MISMATCH,
    SPI_SAFE_OPERATION_ERROR
  } spi_safe_status_enum;

  typedef enum {
    POWER_UP,                  /**< This service command drives logic HIGH on Vcc pin . */
    POWER_DOWN,                /**< This service command drives logic LOW on Vcc pin . */
    ASSERT_HW_STORE,           /**< This service command asserts the Hardware Store Request on HSB pin for Cypress Flash device. */
    HW_IO_RESET,               /**< This service command asserts RESET on IO pin */
    MULTI_FACTOR_WAIT_CYCLE_LATENCY_WT, /**< This service command modifies the weight with multi_factor_wait_cycle_latency_wt */
    ASSERT_MODFEN,             /**< This service command asserts Mode Fault Feature */
    DEASSERT_MODFEN,           /**< This service command de-asserts Mode Fault Feature */
    ASSERT_SSOE,               /**< This service command asserts SSOE */
    DEASSERT_SSOE,             /**< This service command de-asserts SSOE */
    ASSERT_SLAVE_RDY,          /**< This service command asserts Slave Ready */
    DEASSERT_SLAVE_RDY,        /**< This service command de-asserts Slave Ready */
    FLUSH_RX_FIFO              /**< This service command flushes rxd_register of shared_status */
  } service_type_enum;

  typedef enum int {
    SECTOR_SIZE_64KB=64,  
    SECTOR_SIZE_128KB=128,  
    SECTOR_SIZE_256KB=256,
    SECTOR_SIZE_1MB=1024
  } flash_sector_size_enum;

  typedef enum bit[1:0] {
    BYTE_OPERATION       = `SVT_SPI_BYTE_OPERATION,
    PAGE_OPERATION       = `SVT_SPI_PAGE_OPERATION,
    SEQUENTIAL_OPERATION = `SVT_SPI_SEQUENTIAL_OPERATION
  } flash_mode_register_op_enum;

  typedef enum bit[1:0] {
    SINGLE_CHIP_PKG,
    MULTI_CHIP_PKG,
    MULTI_CHIP_PKG_COMMON_SS_N
  } device_package_type_enum;

  typedef enum bit[1:0] {
    HOLD_PIN_TOGGLE_TO_NEXT_SCLK_EDGE,
    SCLK_EDGE_TO_HOLD_PIN_TOGGLE
  } hold_feature_timing_check_enum;

  typedef enum bit[1:0] {
    TX,
    RX
  } direction_enum;

  typedef enum bit {
    NON_SEQUENTIAL = `SVT_SPI_UWIRE_NON_SEQUENTIAL, /** Indicates there must be a control word for each data word that is transmitted or received. */ 
    SEQUENTIAL = `SVT_SPI_UWIRE_SEQUENTIAL          /** Indicates only one control word is needed to transmit or receive complete array of data word. */
  } uwire_transfer_state_enum;

  typedef enum bit {
    IN_FRAME ,
    OUT_OF_FRAME 
  } spi_safe_frame_mode_enum;

  typedef enum bit {
    DEDICATED_CS , 
    COMMON_CS 
  } cs_type_enum;

  typedef enum bit {
    RD_WR,              /** Indicates the xSPI register field is readable and writable.  */
    RD                  /** Indicates the xSPI register field is readable only.  */
  } xSPI_register_field_access_type_enum;

  typedef enum bit[1:0] {
    VOLATILE,           /** Indicates field type as Volatile     */
    NON_VOLATILE,       /** Indicates field type as Non Volatile */
    OTP                 /** Indicates field type as OTP          */
  } xSPI_register_field_type_enum;

  typedef enum bit[1:0] {
    NO_PROFILE,         /** Indicates No Profile type     */
    PROFILE_1_0,        /** Indicates Profile type as 1.0 */
    PROFILE_2_0         /** Indicates Profile type as 2.0 */
  } xSPI_profile_type_enum;

  typedef enum bit[5:0] {
    READ_STATE,  
    WREN1_STATE,  
    WREN2_STATE, 
    CONF_REG_PROG_VOLATILE_STATE,
    CONF_REG_PROG_VOLATILE_EXTN_STATE,
    CONF_REG_READ_VOLATILE_STATE,
    CONF_REG_READ_VOLATILE_EXTN_STATE,
    CONF_REG_PROG_NV_STATE,
    CONF_REG_READ_NV_STATE,
    CONF_REG_ERASE_NV_STATE,
    WORD_PROG_STATE,
    PROGRAM_STATE,
    PROGRAM_ERROR_STATE,
    WRITE_BUFFER_STATE,
    WRITE_BUFFER_EXTN1_STATE,
    WRITE_BUFFER_EXTN2_STATE,
    WRITE_BUFFER_PROG_STATE,
    PROG_SUSP_STATE,
    ERASE_ENTER_STATE,
    ERASE_EXTN1_STATE,
    ERASE_EXTN2_STATE,
    ERASE_STATE,
    ERASE_ERROR_STATE,
    ERASE_SUSP_STATE,
    SFDP_STATE,
    DEEP_POWER_DOWN_STATE,
    JEDEC_HW_RESET_STATE
  } flash_prfl_2_0_device_state_type;
  // ---------------------------------------------------------------------------
endclass
`endif // GUARD_SVT_SPI_TYPES_SVI
