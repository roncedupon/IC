
`ifndef GUARD_SVT_SPI_CONFIGURATION_SV
`define GUARD_SVT_SPI_CONFIGURATION_SV 

`include "svt_spi_defines.svi"

`protected
<<K9#cCG95LHMP7@:GSTQNdS/L@VfC6b?6EfdfCR-^bcMWJ#TVFR4)O;>7.dEbS#
(T^(9@8(?1L9Z@YXFTD1P9?88\O#2\#Kf1g<:<XdBW??&SQY2ZfWFX4(9TQO^>Y6
V\7eA\H:?7)=bCFH();fBW1AD_9I36@d3JY;^F/(TM.>^aGH1-5_)3H/RJXAO?^D
FXH4CXd_#GFAYY+RK#A_F9)1,??e_Q>^4[@)Y(98R:8d8BUN(dJIO/SgP.d\B(QA
&CZb;P?5[^]EYOa0ORR^0JVEP_P1QF8?^B&0RW@#fF8O6V\TJ^>_P6^J:FgQY,90
\:<@)3XOVKICbWYT<VGXQ@T(2G2,c3()eb.DWQSN?bL7AS#?A#2(U&aaBcdMf.,K
2#LQXSG,QKBA@<=II<\>HVGKAg+bY8d4McBPZ^:@D#(6bK8QI/TFSU@ZF(H=b41\
Bc/KXM+fI_8#001<EWDMCY<KJ-?eA>(fc[D]UQM@ZT&UU3D9S9RH3D.b@cTdQ)#-
=e:fGYDDE-XJ9&KFcAK0+?F,B9Z,e5Z/.1).OSZQ]R6BK-cU/=ME0DG]#WPIG&-+
e3U+.A<-Vc4?YBEI/A\FR[HT])F86D]XLA76]]96(TM_WJ+8Z,;\4g8:,?@VWbA7
KW9#5VW^RT7@0.^U9@R3B=.;\0M[?:W4GPeV0YY8VFFKGb\(VJ4RbRX9gN#J@M&d
50BZO-=D\aBEN(,IH?OAg&M)^6UIPC:R[\_:C_<B]bD2RU(.a_2[X\0P6COfa-;3
+Ha8eC_W>;dd@.-4b&N53L\QMB+L]AY),U_9M9755:,cc1bS^Yf\;B24VXTQPc@C
G+a2<=?9D&d:HdX4<QELTJ#&<H;K(;9<SCUZ92&VD6aKfWDFPeK5M=6,5NQPK;\(
eA4[INL3<&CE-D7+WgY8M4B<+-90X\6^N2[Tf6gLZI3fg_A1_?UP^A)Kf4XMX.A9
b)&2Rb/2.DIbM0]&deCXM,#fQdI2,RKKd[]C=PE7d++,?NMMeHB1]R]#9gHFXQ[L
GAA#<gf+/7Da@:O&PaS_Q8XK4M(?eV?b6-])ZaX@eUB<4;\GFM)]0O3E(C6J-DSU
(dAAd=7WC/JY+??L#=G1R-HJHZA+S>33>3M>AcBJ[<&]SIQ,Z+A+PM3EM$
`endprotected


typedef class svt_spi_mem_configuration;

// =============================================================================
/**
 * SPI Configuration Class.
 */
class svt_spi_configuration extends svt_configuration;

  /**
    @grouphdr spi_cfg_std Standard SPI and Multilane SPI  attributes
    This group contains attributes which are relevant to STD SPI and Multilane SPI.
    This also contains common parameters between SPI Modes.
    */

  /**
    @grouphdr spi_cfg_flash SPI Flash attributes
    This group contains attributes which are relevant to SPI Flash
    */

  /*
    @grouphdr spi_cfg_empspi EMPSPI attributes
    This group contains attributes which are relevant to EMPSPI.
    EMPSPI is custom feature.
    */

  /*
    @grouphdr spi_cfg_safespi SAFE SPI attributes
    This group contains attributes which are relevant to SAFE SPI.
    */
  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
`ifndef __SVDOC__
  /** Standard SPI Interface. */
  svt_spi_vif spi_if;

`protected
<3J,DF@bS&Ub)3^>M[T:6>+8GZA8N]8_A/Fe1,?Q]cVXUGW0)O+97)I7J_=b+2Rd
.gd8<I;PO8O#DDVLBSIKN=Za8Ob;O+PI^OIdLFb31.Q?AHe_.7Q=RPANOY[.d[Q^U$
`endprotected

`endif // __SVDOC__

  /**
   * It selects the serial specification from mentioned below supported specifications. <br/>
   * SPI   : Indicates SPI feature from Motorola  <br/>
   * SSP   : Indicates SSP feature from Texas Instrument <br/>
   * UWIRE : Indicates MicroWire feature from National Semiconductors <br/>
  */ 
  rand svt_spi_types::spi_feature_enum spi_feature = svt_spi_types::SPI;

  /**
   * @groupname spi_cfg_std
   * SPI Interrupt Enable Bit <br/> 
   * This bit enables SPI interrupt requests, if SPIF or MODF status flag is set. <br/>
   * 1'b1 : SPI interrupts enabled. <br/>
   * 1'b0 : SPI interrupts disabled.  <br/>
   */
  bit spi_interrupt_enable = 0;

  /**
   * @groupname spi_cfg_std
   * SPI System Enable Bit <br/> 
   * This bit enables the SPI system and dedicates the SPI port pins to SPI system functions. If SPE is <br/>
   * cleared, SPI is disabled and forced into idle state, status bits in SPISR register are reseted <br/>
   * 1'b1 : SPI enabled, port pins are dedicated to SPI functions. <br/>
   * 1'b0 : SPI disabled (lower power consumption).  <br/>
   */
  bit spi_system_enable = 1;

  /**
   * @groupname spi_cfg_std
   * SPI Transmit Interrupt Enable <br/> 
   * This bit enables SPI interrupt requests, if SPTEF flag is set. <br/>
   * 1'b1 : SPTEF interrupt enabled. <br/>
   * 1'b0 : SPTEF interrupt disabled.  <br/>
   */
  bit spi_transmit_interrupt_enable = 0;

/** @cond PRIVATE */
  /**
   * @groupname spi_cfg_empspi
   * This bit will allow to skip the Negotiation Request/Response between Master and Slave 
   */
  bit disable_empspi_negotiation = 0;
/** @endcond */

  /** 
   * @groupname spi_cfg_std
   * SPPR2-SPPR0  SPI Baud Rate Preselection Bits  
   */
  rand bit [2:0] sppr = 0;

  /** 
   * @groupname spi_cfg_std
   * SPR2-SPR0  SPI Baud Rate Selection Bits  
   */
  rand bit [2:0] spr = 0;

  /** 
   * @groupname spi_cfg_std
   * This field specifies whether the data is transmitted in little/big bit endian mode  <br/> 
   * LITTLE_ENDIAN : Indicates SPI LITTLE ENDIAN Format <br/>
   * BIG_ENDIAN    : Indicates SPI BIG ENDIAN Format <br/>
   */
  rand svt_spi_types::endianness_enum bit_endianness = svt_spi_types::LITTLE_ENDIAN;

  /**
   * @groupname spi_cfg_std
   * This field specifies whether the data is transmitted in little/big byte endian mode  <br/> 
   * LITTLE_ENDIAN : Indicates SPI LITTLE ENDIAN Format <br/>
   * BIG_ENDIAN    : Indicates SPI BIG ENDIAN Format <br/>
   */
  rand svt_spi_types::endianness_enum byte_endianness = svt_spi_types::LITTLE_ENDIAN;

  /** 
   * @groupname spi_cfg_std
   * This field specifies the number of bytes selected together on which byte endianness is applied. After successful Tx/Rx of byte count  <br/>
   * specified in Payload word size, Next set of bytes are picked from the data array. If number of bytes in data array do not match  <br/>
   * the payload word size then padding with zeros is done. <br/>
   * SPI_8B  : Indicates SPI 8 BIT WORD Format  <br/> 
   * SPI_16B : Indicates SPI 16 Bit WORD Format <br/>
   * SPI_32B : Indicates SPI 32 Bit WORD Format <br/>
   * In SPI_16B and SPI_32B alignments, the bit/byte endianness can be little or big endian. <br/>
          <table border="1" CELLPADDING="0" CELLSPACING="0">
     Thus total of ten combination with payload word size and endianness summarized below <br/>
          <tr>
            <th WIDTH="0.7%">Payload_Word_Size:</th>
            <th WIDTH="0.7%">Byte_Endianness:</th>
            <th WIDTH="0.7%">Bit_Endianness:</th>
            <th WIDTH="0.2%">Example:</th>
          </tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>8-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>NA</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B0 B1 B2 B3 B4 B5 B6 B7...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b0 b1 b2 b3 b4 b5 b6 b7</td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: None</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>8-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>NA</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B0 B1 B2 B3 B4 B5 B6 B7...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order:  b7 b6 b5 b4 b3 b2 b1 b0</td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: None</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>16-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B0 B1 B2 B3 B4 B5 B6 B7 ...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b0 b1 b2 b3 b4 b5 b6 b7 </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 16-bit aligned</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>16-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B0 B1 B2 B3 B4 B5 B6 B7 ...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b7 b6 b5 b4 b3 b2 b1 b0 </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 16-bit aligned</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>16-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B1 B0 B3 B2 B5 B4 B7 B6 ...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b0 b1 b2 b3 b4 b5 b6 b7 </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 16-bit aligned</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>16-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B1 B0 B3 B2 B5 B4 B7 B6 ...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b7 b6 b5 b4 b3 b2 b1 b0 </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 16-bit aligned</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>32-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B0 B1 B2 B3 B4 B5 B6 B7...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b0 b1 b2 b3 b4 b5 b6 b7  </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 32-bit aligned</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>32-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B0 B1 B2 B3 B4 B5 B6 B7...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b7 b6 b5 b4 b3 b2 b1 b0  </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 32-bit aligned</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>32-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Little</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B3 B2 B1 B0 B7 B6 B5 B4...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b0 b1 b2 b3 b4 b5 b6 b7  </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 32-bit aligned</td> </tr>
          </tr>
          <tr>
          <tr>
          <td ALIGN=CENTER ROWSPAN=5 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>32-bit</B></td>
          <tr>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER ROWSPAN=3 VALIGN=MIDDLE BGCOLOR="CCCCCC"><B>Big</B></td>
           <td ALIGN=CENTER BGCOLOR="CCCCCC">#Byte Order: B3 B2 B1 B0 B7 B6 B5 B4...</td>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Bit Order: b7 b6 b5 b4 b3 b2 b1 b0 </td> </tr>
           <tr> <td ALIGN=CENTER BGCOLOR="CCCCCC">#Padding: 32-bit aligned</td> </tr>
          </tr>
        </table>
    */  
  rand svt_spi_types::payload_word_size_enum payload_word_size = svt_spi_types::SPI_8B;

  /** 
   * @groupname spi_cfg_flash
   * It specifies the scale down factor to be used while using the specifies timer values in SPI_FLASH mode.  
   */
  rand int flash_timer_scale_down_factor = 1000;

  /**
   * @groupname spi_cfg_flash
   * This control bit disable the baud divisor generation logic and sclk frequency becomes same as bus_clk.
   */ 
  bit disable_baud_rate_divisor = 0;


  /**
   * @groupname spi_cfg_std
   * SPI Master/Slave Mode Select Bit   <br/> 
   * This bit selects, if the SPI operates in master or slave mode. Switching the SPI from master to slave or vice versa forces the SPI system into idle state. <br/> <br/>
   * 1'b1 = SPI is in Master mode <br/>
   * 1'b0 = SPI is in Slave mode  <br/>
   */
  rand bit is_master = 0;

  /**
   * @groupname spi_cfg_std
   * Mode Fault Enable Bit  <br/> 
   * This bit allows the MODF failure being detected. <br/>
   * In Multi-Master mode, with MODFEN asserted and SSOE de-asserted for connected Master <br/>
   * detects SS_N being driven by another Master on SPI System <br/>
   */
  bit modfen = 0;

  /**
   * @groupname spi_cfg_std 
   * Slave Select Output Enable  <br/> 
   * This Slave Select Output Enable along with MODFEN determines slave select (SS_n/SS_in_n) port behaviour in Master Configuration. For Master Configuration, <br/>
   * if SSOE is disabled, Slave select (SS_n/SS_in_n) is not used by Master Agent. <br/>
   * when MODFEN is enabled and SSOE is disabled, SS_n port is not used and instead SS_in_n port is sampled and used with MODF feature. <br/>
   * when MODFEN is enabled and SSOE is enabled, SS_n port is driven by Master Agent to select the slave   <br/>
   * In Multi-Master mode, only one Master should assert SSOE for initiating transaction on SPI Bus and all other connected Master shall de-assert SSOE <br/>
   * Insert delay between SSOE assert and next transfer(SS_N assert) to make sure Active Master SCLK is initialized before initiating transfer  <br/>
   */
  bit ssoe = 1;
  
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /** Slave ID. Only applicable when device is Slave. */
  rand int unsigned slave_id = 0;
  
  /** Master ID. Only applicable when device is Master. */
  rand int unsigned master_id = 0;
  
  /** Default Slave active on SPI Bus. Only applicable when device is Slave. */
  rand int unsigned default_slave = -1;
  
  /** 
   * @groupname spi_cfg_std
   * Default Master active on SPI Bus. <br/>
   * This denotes the Master ID which is active on SPI Bus. <br/>
   * This variable is now obselete in SPI STD Mode. <br/>
   */
  rand int unsigned default_master = -1;

  /** 
   * It selects from Standard SPI specification or Vendor specific extended version of SPI Specification mentioned below. <br/>
   * SPI_STD       : Indicates SPI Standard mode feature <br/>
   * SPI_MULTILANE : Indicates SPI dual/quad/octal mode. <br/>
   * SPI_FLASH     : Indicates SPI FLASH mode. <br/>
   * SPI_SAFE      : indicates SAFE SPI Mode <br/>
   * To select SPI_MULTILANE, the define (SVT_SPI_IO_WIDTH) value should be also set to MAX number of lanes. <br/>
   * Ex: If SPI_MULTILANE is selected and value of SVT_SPI_IO_WIDTH is 2, Single and DUAL I/O can be configured using transaction class parameters:
   * instruction_lane_count, address_lane_count, data_lane_count <br/>
   * Ex: If SPI_MULTILANE is selected and value of SVT_SPI_IO_WIDTH is 4, Single, DUAL and QUAD I/O can be configured using transaction class parameters:
   * instruction_lane_count, address_lane_count, data_lane_count <br/>
   */ 
  rand svt_spi_types::frame_format_enum frame_format = svt_spi_types::SPI_STD;

  /**
   * @groupname spi_cfg_std, spi_cfg_flash
   * This field selects one of four possible clock configuration mode for SPI Interface. <br/>
   * (CPOL, CPHA) tuple represents the Mode of operation; e.g., the value '(0, 1)' would indicate CPOL=0 and CPHA=1.  <br/>
   * CPOL represents the base value of clock in Idle state. <br/>
   * For CPHA=0, odd numbered edges on the SCK input cause the data at the serial data input pin to be latched. <br/>
   * If the CPHA bit is set, even numbered edges on the SCK input cause the data at the serial data input pin to be latched.  <br/>
   * SPI_MODE_0 : Indicates SPI CPOL = 0 , CPHA = 0<br/> 
   * SPI_MODE_1 : Indicates SPI CPOL = 0 , CPHA = 1<br/> 
   * SPI_MODE_2 : Indicates SPI CPOL = 1 , CPHA = 0<br/> 
   * SPI_MODE_3 : Indicates SPI CPOL = 1 , CPHA = 1<br/> 
   */ 
  rand svt_spi_types::operation_mode_enum operation_mode = svt_spi_types::SPI_MODE_0;

  /**
   * @groupname spi_cfg_std, spi_cfg_flash
   * This field specifies whether Chip select (ss_n/cs_n) to be asserted as Active High or Low. <br/>
   * Default : svt_spi_types::ACTIVE_LOW <br/> 
   * Texas Instrument SSP mode: 
   *   For default SSP behaviour(IDLE state of slave select port is logic LOW), this parameter must be set as ACTIVE_HIGH <br/> 
   *   explicitly while creating the configuration object.<br/> 
   *   If we require IDLE state of slave select port to be logic HIGH and frame indicator pulse is<br/>  
   *   indicated by ss_n toggling to logic low for one sclk period and then toggle back to logic HIGH,<br/> 
   *   this parameter should be set to ACTIVE_LOW<br/> 
   * For all Modes except SSP :
   *   ACTIVE_LOW  : Asserted when ss_n is 0 and De-asserted when ss_n is 1. <br/>
   *   ACTIVE_HIGH : Asserted when ss_n is 1 and De-asserted when ss_n is 0. <br/>
   */ 
  svt_spi_types::active_mode_enum cs_polarity = svt_spi_types::ACTIVE_LOW;

  /**
   * @groupname spi_cfg_std, spi_cfg_flash
   * This field specifies whether RESET Pin to be asserted as Active High or Low. <br/>
   * Default : svt_spi_types::ACTIVE_HIGH <br/> 
   */ 
  svt_spi_types::active_mode_enum reset_polarity = svt_spi_types::ACTIVE_HIGH;

  /**
   * @groupname spi_cfg_std
   * Few applications requires to transmit only subset of data frame width (Macro SVT_SPI_DATA_WIDTH) <br/>
   * This field specifies whether subset of data_frame is allowed in current device. <br/>
   * Default : 1'b0 (Disabled), all bits specified by macro SVT_SPI_DATA_WIDTH are sampled and transmitted. <br/>
   * #byte_endianness is ignored and only #bit_endianness determine order of Tx/Rx <br/>
   * After Driving/Sampling #data_frame_width bits, Next data_frame entry is <br/>
   * selected for Driving/Sampling. <br/>
   * Default : Disabled
   */ 
  bit enable_configurable_data_frame_width = 1'b0;

  /**
   * @groupname spi_cfg_std
   * This field specifies Maximum bit position up to which Tx/Rx is performed. <br/>
   * Default : `SVT_SPI_DATA_WIDTH
   * 
   */ 
  int data_frame_width = `SVT_SPI_DATA_WIDTH;
  
  /**
   * @groupname spi_cfg_std
   * This field is valid only for SPI Feature set to Microwire(UWIRE). <br/>
   * This field specifies the length of Control Word that can be transmitted by Master. <br/>
   * Default : `SVT_SPI_UWIRE_MAX_CONTROL_WORD_WIDTH
   * 
   */ 
  int uwire_control_word_width = `SVT_SPI_UWIRE_MAX_CONTROL_WORD_WIDTH;

  /**
   * @groupname spi_cfg_std
   * This field is valid only for SPI Feature set to Microwire(UWIRE). <br/>
   * This field is used to enable/disable the busy/ready handshaking mode for Microwire Protocol. <br/>
   * When Enabled, Master checks for ready status from slave from second transfer(busy/ready handshake is not required for first transfer) <br/>
   * onwards till completion of transfer. Completion of Transfer is Indicated <br/>
   * by Master by transmitting Start bit with Value = 1'b1.<br/>
   * In Slave mode, Slave drives the busy until it is ready to accept the<br/>
   * Incoming Data from Master. Duration of busy is controlled by parameter #uwire_busy_timer.<br/>
   * 
   */
  bit uwire_enable_handshaking_mode = 1'b0;

  /**
   * @groupname spi_cfg_std
   * This field is valid only for SPI Feature is set to Microwire(UWIRE) in Slave mode. <br/>
   * This field determines the duration for which Slave drives Busy to Master before accepting the Incoming Data from Master <br/>
   * Is specified in multiple of #bus_clk cycle.  <br/>
   */
  rand int uwire_busy_timer = 1;

  /**
   * @groupname spi_cfg_std
   * This field is valid only for SPI Feature is set to SSP in Master mode. <br/>
   * This field determines the number of SCLK cycles for which the Frame Indicator(slave select) will be asserted before the start of data transfer.  <br/>
   * Is specified in multiple of #sclk cycle.  <br/>
   */
  int ssp_assert_frame_indicator_sclk_period = 1;

  /**
   * @groupname spi_cfg_flash
   * This field specifies whether Master needs to generate one clock before SS_N asserts. <br/>
   * This is currently supported in SPI FLASH mode only.
   */
  bit enable_sclk_toggle_before_ssn_assert = 0;

  /**
   * @groupname spi_cfg_flash
   * This field specifies whether Master needs to generate one clock after SS_N deasserts. <br/>
   * This is currently supported in SPI FLASH mode only.
   */
  bit enable_sclk_toggle_after_ssn_deassert = 0;

  /**
   * @groupname spi_cfg_flash
   * This field specifies the number of clock cycles Master needs to generate before SS_N assert or after SS_N deassert. <br/>
   * This will insert #idle_phase_sclk_cycle_count number of clock cycles before SS_N assert when #enable_sclk_toggle_before_ssn_assert is set <br/>
   * OR <br/>
   * This will insert #idle_phase_sclk_cycle_count number of clock cycles after SS_N deassert when #enable_sclk_toggle_after_ssn_deassert is set <br/>
   * This is currently supported in SPI FLASH mode only.
   */
  int idle_phase_sclk_cycle_count = 1;

  /**
   * @groupname spi_cfg_safespi
   * This field specifies the number of bits in Programmable Slave Address . <br/>
   * This is valid only when frame_format is set to SPI_SAFE. <br/>
   * For reasonable constraint please refer to #reasonable_spi_safe_slave_select_size <br/>
   * Default Value: 0
   */
  rand int spi_safe_slave_select_size = 0;

  /**
   * @groupname spi_cfg_safespi
   * This field specifies the number of bits in Slave Sensor Address . <br/>
   * This is valid only when frame_format is set to SPI_SAFE. <br/>
   * For reasonable constraint please refer to #reasonable_spi_safe_sensor_address_size <br/>
   * Default Value: 0
   */
  rand int spi_safe_sensor_address_size = 0;

  /**
   * @groupname spi_cfg_safespi
   * This field specifies the total number of bits denoting Source or Target Address in a frame. <br/>
   * This is valid only when frame_format is set to SPI_SAFE. <br/>
   * For reasonable constraint please refer to #reasonable_spi_safe_address_size <br/>
   * Default Value: 0
   */
  rand int spi_safe_address_size = 0;

  /**
   * @groupname spi_cfg_safespi
   * This field specifies the number of bits denoting CRC size in a frame. <br/>
   * This is valid only when frame_format is set to SPI_SAFE. <br/>
   * For reasonable constraint please refer to #reasonable_spi_safe_crc_size <br/>
   * Default Value: 0
   */
  rand int spi_safe_crc_size = 0;

  /**
   * @groupname spi_cfg_safespi
   * The programmable slave address is the address uniquely identifying the content of the response data.
   * This is valid only when frame_format is set to SPI_SAFE
   */
  rand bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] spi_safe_slave_select_address;

  /**
   * @groupname spi_cfg_safespi
   * This field contains the sensor data addresses for a Slave Device
   * This is valid only when frame_format is set to SPI_SAFE
   */
  rand bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] spi_safe_sensor_address_list[];

  /**
   * @groupname spi_cfg_safespi
   * This field specifies the general frame format of SAFE SPI Feature. <br/>
   * IN_FRAME     : slave responses within the same time slot as the master's request <br/>
   * OUT_OF_FRAME : slave responses within the next frame of the master <br/>
   * Default : IN_FRAME
   */
  rand svt_spi_types::spi_safe_frame_mode_enum spi_safe_frame_mode = svt_spi_types::IN_FRAME;

  /**
   * @groupname spi_cfg_safespi
   * This field specifies whether Slave is configured with Unique Chip Select or not. <br/>
   * DEDICATED_CS : Slave contains a Unique SS_N. <br/>
   * COMMON_CS    : Slave shares SS_N with other Slave devices. <br/>
   * Default : DEDICATED_CS
   */
  rand svt_spi_types::cs_type_enum cs_type = svt_spi_types::DEDICATED_CS;

  /**
   * @groupname spi_cfg_std
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
  bit enable_mem_core = 0;

  /**
   * @groupname spi_cfg_std, spi_cfg_flash
   * This field specifies whether SCLK pause feature is enabled or not. <br/>
   * If enabled, this feature allows Master to pause SCLK after transaction class parameter #sclk_pause_after_sclk_count <br/>
   * number of clock edges for a duration of transaction class parameter #sclk_pause_duration. <br/>
   * The value for #sclk_pause_duration should be greater than the baud rate divisor. <br/>
   * This feature is applicable for frame formats SPI_STD/SPI_MULTILANE/SPI_SAFE/SPI_FLASH <br/>
   * Default : 0 
   */
  bit enable_sclk_pause_feature = 0;

/** @cond PRIVATE */
  /**
   * @groupname spi_cfg_empspi
   * This field specifies whether EMPSPI signal SPI_INT to be aserted as Active High or Low. <br/>
   * ACTIVE_LOW  : Asserted when SPI_INT is 0 and De-asserted when SPI_INT is 1. <br/>
   * ACTIVE_HIGH : Asserted when SPI_INT is 1 and De-asserted when SPI_INT is 0. <br/>
   */ 
  rand svt_spi_types::active_mode_enum empspi_spi_int_polarity = svt_spi_types::ACTIVE_LOW;

  /** 
   * @groupname spi_cfg_empspi
   * Time Master will hold SPI_CSN high until it sees SPI_INT continuously high for #timer_empspi_slave_hold_spi_int . 
   */
  rand bit[3:0] timer_empspi_master_hold_spi_csn = 3;

  /** 
   * @groupname spi_cfg_empspi
   * Time Slave will hold SPI_INT high until it sees SPI_CSN continuously high for #timer_empspi_master_hold_spi_csn . 
   */
  rand bit[3:0] timer_empspi_slave_hold_spi_int = 4;

  /** 
   * @groupname spi_cfg_empspi
   * Time after which Master asserts SPI_SSN after reset is applied  <br/>
   * It is in multiple of interface signal <a href="interfaces.html\#item_svt_spi_if_bus_clk"> bus_clk </a> . <br/>
   */
  rand bit[3:0] timer_empspi_master_assert_spi_ssn_after_reset = 1;

  /** 
   * @groupname spi_cfg_empspi
   * Time after which Slave asserts CLK_REQ after reset is applied  <br/>
   * It is in multiple of interface signal <a href="interfaces.html\#item_svt_spi_if_bus_clk"> bus_clk </a> . <br/>
   */
  rand bit[3:0] timer_empspi_slave_assert_clk_req_after_reset = 2;

  /** 
   * @groupname spi_cfg_empspi
   * Time after which Slave asserts SPI_INT after CLK_REQ is asserted  <br/>
   * It is in multiple of interface signal <a href="interfaces.html\#item_svt_spi_if_bus_clk"> bus_clk </a> . <br/>
   */
  rand bit[3:0] timer_empspi_slave_assert_spi_int_after_clk_req = 1;
/** @endcond */

  /**
   * @groupname spi_cfg_flash
   * Memory Configuration. This field is valid only when SPI is configured in
   * SPI_FLASH mode
   */
  svt_spi_mem_configuration spi_mem_cfg = null;

  /**
   * @groupname spi_cfg_std
   * Specifies the pattern value that must be driven continuously on Inactive <br/>
   * lane. Possible values supported are LINESTATE_0,LINESTATE_1 & LINESTATE_Z. <br/>
   * When LINESTATE_Z(High impedance) is selected oe_n port is de-asserted and for logical <br/>
   * values (LINESTATE_0,LINESTATE_1) oe_n port is asserted. <br/>
   * Default : LINESTATE_Z
   */
  svt_spi_types::linestate_value_enum pattern_during_electrical_idle = svt_spi_types::LINESTATE_Z;

  /**
   * @groupname spi_cfg_flash
   * Enables Set up and Hold time delay while driving ports. Currently suported for SPI Flash Mode Only. <br/>
   * It also enables checking timing parameters for violations. Error check <br/>
   * triggers when timing checks fail at Receiver. <br/> 
   * Default : 0 (Disabled) <br/> 
   */ 
  bit enable_gate_delay_modeling = 0;

  /**
   * @groupname spi_cfg_flash
   * Enables Modeling Board IO Propagation delay. <br/>
   * When enabled, Each Output port is driven with appropriate value after <br/>
   * delay specified using  delay parameter  t<port_name>_fly_by_delay_ns. <br/>
   * Since SPI Mostly works at MHz range, The delays are specified in ns <br/>
   * parameter. <br/>
   * Default : 0 (Disabled) <br/> 
   */ 
  bit enable_io_delay_modeling = 0;

  /**
   * Board output Propagation delay for SCLK Port in ns for Master mode.<br/> 
   * Default : 0 ns 
   */ 
  real tSCLK_fly_by_delay_ns = 0;

  /**
   * Board output Propagation delay for each MISO Port in ns for Slave mode.<br/> 
   * Default : 0 ns 
   */ 
  real tMISO_fly_by_delay_ns[`SVT_SPI_IO_WIDTH] = '{`SVT_SPI_IO_WIDTH{0}};

  /**
   * Board output Propagation delay for each MOSI Port in ns for Master mode.<br/> 
   * Default : 0 ns 
   */ 
  real tMOSI_fly_by_delay_ns[`SVT_SPI_IO_WIDTH] = '{`SVT_SPI_IO_WIDTH{0}};

  /**
   * Board output Propagation delay for SS_N Port in ns for Master mode.<br/> 
   * Default : 0 ns 
   */ 
  real tSS_N_fly_by_delay_ns = 0;

/** @cond PRIVATE */
  /**
   * Board output Propagation delay for Slave_Rdy Port in ns for Slave mode.<br/> 
   * Default : 0 ns 
   */ 
  real tSLAVE_RDY_fly_by_delay_ns = 0;
/** @endcond */

  /**
   * Board output Propagation delay for SPI Interrupt Port in ns.<br/> 
   * Default : 0 ns 
   */ 
  real tSPI_INTERRUPT_fly_by_delay_ns = 0;

  /**
   * Board output Propagation delay for hsb_n Port in ns for flash mode.<br/> 
   * Default : 0 ns 
   */ 
  real tHSB_N_fly_by_delay_ns = 0;

  /**
   * Board output Propagation delay for DQS Port in ns.<br/>
   * This is applicable only for Part Numbers where there is single DQS pin. <br/>
   * Default : 0 ns 
   */ 
  real tDQS_fly_by_delay_ns = 0;

  /**
   * Board output Propagation delay for DQS Port in ns.<br/> 
   * This is used for DQS multi port per device <br/>
   * Default : 0 ns 
   */ 
  real tDQS_arr_fly_by_delay_ns[`SVT_SPI_MAX_DQS_WIDTH] ='{`SVT_SPI_MAX_DQS_WIDTH{0}};

  /**
   * Board output Propagation delay for ECS Port in ns for Slave flash mode.<br/> 
   * Default : 0 ns 
   */ 
  real tECS_N_fly_by_delay_ns = 0;

  /**
   * Board output Propagation delay for dedicated Vpp Port in ns for Master flash mode.<br/> 
   * Default : 0 ns 
   */ 
  real tVPP_fly_by_delay_ns = 0; 

  /**
   * Board output Propagation delay for dedicated Hold_n Port in ns for Master flash mode.<br/> 
   * Default : 0 ns 
   */ 
  real tHOLD_N_fly_by_delay_ns = 0; 

  /**
   * Board output Propagation delay for dedicated write_protect_n Port in ns for Master flash mode.<br/> 
   * Default : 0 ns 
   */ 
  real tWRITE_PROTECT_N_fly_by_delay_ns = 0; 

  /**
   * Board output Propagation delay for Parallel I/O Port in ns.<br/> 
   * Default : 0 ns 
   */ 
  real tPARALLEL_IO_fly_by_delay_ns[`SVT_SPI_PIO_WIDTH] = '{`SVT_SPI_PIO_WIDTH{0}};

  /**
   * Controls how many data array elements are displayed in trace.
   * Defaults to '10', indicating display the first 10 elements. The supported values are:
   *  -  0  -- display all data array elements
   *  -  n  -- display the first n data array elements
   *  - -n  -- display the last  n data array elements
   *  .
   */
  int psdisplay_data_size = 10;

  /**
   * Controls how many control word array elements are displayed in trace.
   * Defaults to '10', indicating display the first 10 elements. The supported values are:
   *  -  0  -- display all control word array elements
   *  -  n  -- display the first n control word array elements
   *  - -n  -- display the last  n control word array elements
   *  .
   */
  int psdisplay_control_word_size = 10;

/** @cond PRIVATE */
  /** 
   * Enables/Disables the Baud Rate Checks for selected device configuration. <br/>
   * 0 : Baud Rate check is disabled <br/>
   * 1 : Baud Rate check is enabled
   */
  bit enable_baud_rate_check = 1;
/** @endcond */

  /**
   * @groupname spi_cfg_flash
   * Enables/Disables the unsed bytes reporting to analysis port. <br/>
   * 0 : Reports all bytes detected over data lanes <br/>
   * 1 : Reports only meaningful bytes <br/>
   * Ex: In APMEMORY when WRITE_MODE_REGISTER is decoded, only first byte is meaningful and rest are dont care. <br/>
   * Default Value: 0
   */
  bit disable_invalid_bytes_report = 0;
  
  /**
   * @groupname spi_cfg_std
   * Specifies the Minimum SPI Bus SCLK Period (Max Frequency in Mhz) in ns unit. <br/>
   * This parameter is compared against the observed sclk period at SPI Interface. <br/>
   * Default : 20 ns (50Mhz)
   */ 
  real min_spi_bus_sclk_period_ns = 20;

  /**
   * @groupname spi_cfg_std
   * Enables/Disables comparison of selected SPI Bus Maximum frequency against the sclk <br/>
   * period observed at SPI Interface. <br/>
   * Default Value: 1
   */ 
  bit enable_spi_bus_sclk_period_check = 1;

  /**
   * @groupname spi_cfg_std
   * Specifies the Minimum number of SPI half SCLK cycle delay between ss_n <br/>
   * assert and first sclk toggle. This parameter is compared against the observed<br/>
   * leading time at SPI Interface. <br/>
   * Default Value: 1
   */ 
  int min_leading_time = 1;

  /**
   * @groupname spi_cfg_std
   * Specifies the Minimum number of SPI half SCLK cycle delay between ss_n <br/>
   * assert and ss_n de-assert. This parameter is compared against the observed <br/>
   * idle time at SPI Interface. <br/>
   * Default Value: 2
   */ 
  int min_idle_time = 2;

  /**
   * @groupname spi_cfg_std
   * Enables/Disables comparison of leading time and idle time observed at SPI <br/>
   * Interface against min leading time and min idle time respectively expressed <br/>
   * in half sclk.  <br/>
   * When this bit is set to 0,  Checks logic evaluates on the basis of absolute <br/>
   * time observed at SPI interface. Absolute time ensures that asynchronous ss_n  <br/>
   * assertion w.r.t. first sclk meets timing requirements as per the SP specification <br/>
   * Default Value: 0
   */ 
  bit enable_event_based_timing_check = 0;

  /** 
   * @groupname spi_cfg_std
   * Disable Clock duration Checks when Clock is paused by greater than #min_spi_bus_sclk_pause_multiple_factor <br/> 
   * Default Value: 0
   */
  bit disable_spi_bus_sclk_pulse_check_upon_sclk_pause = 0;

  /** 
   * @groupname spi_cfg_std
   * It specifies the factor of clock period by which when the SCLK is paused, the checks shouldn't get triggered. <br/>  
   * Default Value: 4
   */
  int min_spi_bus_sclk_pause_multiple_factor = 4;

  /**
   * Minimum JEDEC Hardware Reset Assert CS Low Time
   */ 
  int jedec_hw_reset_cs_low_time_min_ns = 50;

  /**
   * Maximum JEDEC Hardware Reset Assert CS Low Time
   */ 
  int jedec_hw_reset_cs_low_time_max_ns = 200;

  /** Specifies the delay for sampling asynchronous signals during idle state. */
  int sample_async_signal_delay_during_idle_state = 1;

  /**
   * @groupname spi_cfg_std
   * Controls the level of entries (or above) at which the receive FIFO is assumed full and <br/>
   * Slave device communicates its inability to receive further Data by de-asserting <a href="interfaces.html\#item_svt_spi_if_slave_rdy"> slave_rdy </a>. <br/>
   * Slave's Flush service needs to be called upon to empty the receive buffer * <br/>
   * and asserts the slave_rdy to continue the data transfer.
   */
  int rx_buffer_threshold = 10;

  /**
   * @groupname spi_cfg_std
   * This field specifies whether slave_rdy Pin to be asserted as Active High or Low. <br/>
   * Default : svt_spi_types::ACTIVE_LOW <br/> 
   */ 
  svt_spi_types::active_mode_enum slave_rdy_polarity = svt_spi_types::ACTIVE_LOW;

  /**
   * @groupname spi_cfg_std
   * Enables/Disables Slave Ready Feature in the Master or Slave Mode. <br/>
   * Default Value: 0
   */
  bit enable_slave_rdy_feature = 0;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE SCLK Leading Time in ns unit. <br/>
   * This parameter is compared against the observed Enable Lead at SPI Interface. <br/>
   * Default : 40 ns
   */ 
  real spi_safe_sclk_enable_lead_time_ns = 40;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE SCLK Leading Time when SS_N is in de-asserted State in ns unit. <br/>
   * This parameter is compared against the observed Disable Lead at SPI Interface. <br/>
   * Default : 10 ns
   */ 
  real spi_safe_sclk_disable_lead_time_ns = 10;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE SCLK Lagging/Trailing Time in ns unit. <br/>
   * This parameter is compared against the observed Enable Lag at SPI Interface. <br/>
   * Default : 20 ns
   */ 
  real spi_safe_sclk_enable_lag_time_ns = 20;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE SCLK Lagging/Trailing Time when SS_N is in de-asserted State in ns unit. <br/>
   * This parameter is compared against the observed Disable Lag at SPI Interface. <br/>
   * Default : 10 ns
   */ 
  real spi_safe_sclk_disable_lag_time_ns = 10;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE SCLK High Time in ns unit. <br/>
   * This parameter is compared against the observed sclk high time at SPI Interface. <br/>
   * Default : 40 ns 
   */ 
  real spi_safe_sclk_high_time_ns = 40;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE SCLK Low Time in ns unit. <br/>
   * This parameter is compared against the observed sclk low time at SPI Interface. <br/>
   * Default : 40 ns 
   */ 
  real spi_safe_sclk_low_time_ns = 40;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum Duration in ns for which Slave Select must be deasserted in between Two sequences. <br/>
   * This parameter is applicable for svt_spi_types::OUT_OF_FRAME only <br/
   * This parameter is compared against the observed Sequential Transfer Delay at SPI Interface. <br/>
   */ 
  real spi_safe_OutOfFrame_sequential_transfer_delay_time_ns = 700;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum Duration in ns for which Slave Select must be deasserted in between Two sequences. <br/>
   * This parameter is applicable for svt_spi_types::IN_FRAME only <br/
   * This parameter is compared against the observed Sequential Transfer Delay at SPI Interface. <br/>
   */ 
  real spi_safe_InFrame_sequential_transfer_delay_time_ns = 200;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE MOSI Data Setup Duration with respect to SCLK in ns <br/>
   */ 
  real spi_safe_mosi_data_setup_min_time_ns = 10;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Maximum SPI SAFE MOSI Data Setup Duration with respect to SCLK in ns <br/>
   */ 
  real spi_safe_mosi_data_setup_max_time_ns = 20;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE MOSI Data Hold Duration with respect to SCLK in ns <br/>
   */ 
  real spi_safe_mosi_data_hold_min_time_ns = 20;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Maximum SPI SAFE MOSI Data Hold Duration with respect to SCLK in ns <br/>
   */ 
  real spi_safe_mosi_data_hold_max_time_ns = 30;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE SCLK transmit edge to MISO Data Valid Time in ns <br/>
   */ 
  real spi_safe_min_sclk_tx_edge_to_miso_data_valid_time_ns = 20;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Maximum SPI SAFE SCLK transmit edge to MISO Data Valid Time in ns <br/>
   */ 
  real spi_safe_max_sclk_tx_edge_to_miso_data_valid_time_ns = 30;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Maximum SPI SAFE SS_N assert to MISO Data Valid Time in ns <br/>
   * This is applicable when svt_spi_configuration::spi_safe_frame_mode is set to svt_spi_types::OUT_OF_FRAME.
   */ 
  real spi_safe_max_ss_n_assert_to_miso_data_valid_time_ns = 40;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Minimum SPI SAFE MISO Disable Lag time after SS_N de-assert in ns <br/>
   */ 
  real spi_safe_miso_data_disable_lag_min_time_ns = 50;

  /**
   * @groupname spi_cfg_safespi
   * Specifies the Maximum SPI SAFE MISO Disable Lag time after SS_N de-assert in ns <br/>
   */ 
  real spi_safe_miso_data_disable_lag_max_time_ns = 50;

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the configuration settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
    slave_id < `SVT_SPI_MAX_NUM_SLAVES;
    master_id < `SVT_SPI_MAX_NUM_MASTERS;
    default_slave < `SVT_SPI_MAX_NUM_SLAVES;
    default_master < `SVT_SPI_MAX_NUM_MASTERS;
  }
  
  constraint valid_bit_endianness {
    if (frame_format == svt_spi_types::SPI_FLASH || frame_format == svt_spi_types::SPI_SAFE)
      bit_endianness == svt_spi_types::BIG_ENDIAN;
  }
  
  constraint valid_byte_endianness {
    if (frame_format == svt_spi_types::SPI_FLASH || frame_format == svt_spi_types::SPI_SAFE)
      byte_endianness == svt_spi_types::BIG_ENDIAN;
  }
  
  constraint valid_payload_word_size {
    if (frame_format == svt_spi_types::SPI_FLASH || frame_format == svt_spi_types::SPI_SAFE)
      payload_word_size == svt_spi_types::SPI_8B;
    else if (frame_format == svt_spi_types::SPI_STD && spi_feature == svt_spi_types::UWIRE)
      payload_word_size == svt_spi_types::SPI_8B;
  }
  
  constraint reasonable_flash_timer_scale_down_factor {
    if (frame_format == svt_spi_types::SPI_FLASH)
      flash_timer_scale_down_factor == 1000;
    else 
      flash_timer_scale_down_factor == 1;
  }

  constraint reasonable_operation_mode {
    if (frame_format == svt_spi_types::SPI_FLASH)
      operation_mode inside {svt_spi_types::SPI_MODE_0,svt_spi_types::SPI_MODE_3};
    else if (frame_format == svt_spi_types::SPI_STD && spi_feature == svt_spi_types::UWIRE)
      operation_mode == svt_spi_types::SPI_MODE_0;
    else if (frame_format == svt_spi_types::SPI_STD && spi_feature == svt_spi_types::SSP)
      operation_mode == svt_spi_types::SPI_MODE_1;
    else if (frame_format == svt_spi_types::SPI_SAFE && spi_safe_frame_mode == svt_spi_types::IN_FRAME)
      operation_mode == svt_spi_types::SPI_MODE_1;
    else if (frame_format == svt_spi_types::SPI_SAFE && spi_safe_frame_mode == svt_spi_types::OUT_OF_FRAME)
      operation_mode == svt_spi_types::SPI_MODE_0;
`ifdef SPI_FLASH_FORCE_SPI_MODE_0
    operation_mode == svt_spi_types::SPI_MODE_0;
`endif
  }

  constraint valid_uwire_busy_timer {
    if (frame_format == svt_spi_types::SPI_STD && spi_feature == svt_spi_types::UWIRE)
      uwire_busy_timer inside {[1:`SVT_SPI_UWIRE_MAX_BUSY_TIMER]};
    else
      uwire_busy_timer == 0;
  }

  constraint reasonable_spi_safe_slave_select_size {
    if(frame_format == svt_spi_types::SPI_SAFE) 
      spi_safe_slave_select_size == 2;
    else
      spi_safe_slave_select_size == 0;
  }

  constraint reasonable_spi_safe_sensor_address_size {
    if(frame_format == svt_spi_types::SPI_SAFE) 
      spi_safe_sensor_address_size == 3;
    else
      spi_safe_sensor_address_size == 0;
  }

  constraint reasonable_spi_safe_address_size {
    if(frame_format == svt_spi_types::SPI_SAFE) {
      if(spi_safe_frame_mode == svt_spi_types::IN_FRAME)
        spi_safe_address_size == 5;
      else
        spi_safe_address_size == 10;
    }
    else
      spi_safe_address_size == 0;
  }

  constraint reasonable_spi_safe_crc_size {
    if(frame_format == svt_spi_types::SPI_SAFE)
      spi_safe_crc_size == 3;
    else
      spi_safe_crc_size == 0;
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = "svt_spi_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_configuration)
    `svt_field_object(spi_mem_cfg,`SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
  `svt_data_member_end(svt_spi_configuration)
 
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif 

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

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

  //----------------------------------------------------------------------------
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
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
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
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** 
   * This function defines the print task for svt_spi_configuration class.
   */
  extern function void do_print(`SVT_XVM(printer) printer);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
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
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
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
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
 
  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_configuration)
  `vmm_class_factory(svt_spi_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
YJY5#Qe:5DS+)FDA)/?;DfIG_G1]AaS?=0JSV&S=<gb\f.09ef@e2)T[Q=Z2XPYS
c](=^1X_G:_.:?R;#c=.;N0:5GKbVgfdX<#>&FY\7g>cUA8Q,V&9C[>KWV(PPRSC
>HN<<0(g:ON=@L9+Se07Y5IQ-7E-L2aM\RSW>ZbO#OgA/_b7/RNUNgHBZ<c9/IFG
4OY4@e#ZC=-e3dW7^[3+BTKZf^Wd+BNV712K\fM>,4U_JX,)-]NK@3f;4WM,d4Q[
;>@P<]bVV..L+HZ:2Q78Y^R>&,g2NZeZdV\B41,ALFJ6dKVG^3GA+)VVc9B:Rg=[
/#bO3XOGSKM7ZG::6K@P7<,78^B.WQ(&^PE8_CfI,f,:@,+PWL:F00-c7NI[F49f
E=T9GaZ6(-]c:a,H^NB@DTaKNA?))_RMR_D6f-@Rc>](=PGZRgcMN<2?;]I1T@AN
-2eCB;f@M3L1.8^WgVXG(B)SV]3A[)#-YEJ](R3XF/E\1KeCHg_^[N@Q.A^5f=E=
OAQa8L?MMb7HPOS04^@B]c/C8X]aF2?HHY3[E.)R@e9=HX[U_Oba]0:Y2C46E<@3
#[5de&ITHNH7eIS37&(J.5d.GMg,CaZVB6U@)YEQHg0cfBK;R05.&[W[3D<9H@XE
b0(2QfXMS9ZGJc<+&+>;]8;RHU403d,e4H3geZ=GJ/]J&RW5F/.KEg6I^0@Q#[I0
NU2f4T_7/X9Z7Z]EMVR?#@EA3KEe5cV:=;CA\+ZVQ6Ga#DEBAeR4E(6IL$
`endprotected


//vcs_vip_protect
`protected
c6Q#U93S]J8gUe:Re:8W1+LD++GR6DB>G7W0UA@#G+B4dcRLY6@A6(QYRcc)RQeM
,=VTYO;8>;DAE[H;b8&W>PT>=6Ua<&TF\4S^?FQD@[@#/(0IcVZ+?T\AHACME^V#
XB;^[-+]M\?JPZ@X(Hgff-=c\18RBCfLLIH--ELTge),X3>HY5Cd@PX=W1JKRIX9
4KBKR(U)HGDNE\FS9J#TY5@EBYF2+B:(d9G:+]W4d&MS6;OS7=.?dMc9MRENX\[<
UD5UQd;Fe\S\/RWLOc+KWNBBFa7B,fB7#bW;;]P0Q2^._UP4PCgf&+W(.E=b6O7-
\f7#<P8a3EA?\+4Y=eTTaZH9N)eQR:H8LW_;?>36Ee&Q0T?8_@f:ME-N@603HJ?/
TPCEeN/EM22)A(3TK:Pa+<,>;GG^dPY=B(P]Z#C+bd2/\4WK^?b(XL]050:6JB_S
^:0M(T:9TfBNMW&)(NER[NYHI/R:L1:86,TJR)VOEKf@NSXQAED=FcbCV9\CQ\?.
>6ZbM0XD2P0Ic4S,5>dNBUYM845^A,?Ha6D?;VAf2?&f+V/Z&D[E@GU@0gQ9R+I+
#_3dYa+N\JN^PH\O8]U?_-VZ]><PL&A/Q<;6FfMQ2N;.3^7g1&8EQ1=<cA_7Z^.P
=1S2ME:.+Y(eGM/ZQEDN]QY/OCLgS2==J96-2a7^61#C(V3,?\f\^KO40L3&7P2G
HV=KML]DO&#[B=aaYC03b>-NP@1HWO?427FL+2BAC0c/HJNEY=bK;^72OO.+7;ZJ
f=?WM<]>1Jc?7LB4_[8)8b1d@P0g;8IcbJ7GbK&AMF)72APT5N\_OPO81SQ0Z]4L
bU]1\QE](XdGaP1C;WTg3)V]Q+.IaH=&L;5a7FCVG+gV&R^g3cAW7)ce6OIQ1AKS
+@C5)G4V1PTdcUY#M,?IB95F1aF/+L16dFJ:NJIEd:U=5_/g#[5-^LC+T5a\RHG0
FBL]47^UDZ?W[&RY&9_^->TH1?#8M&gO(QGS0dWMSQ66ZP1HY(VD53[QU(#BD7&Y
,LU+(-D8F.39X508QeKY+XA^][HM[7I](a>&a/@NW3S.WW\RTWJaVfCTbWJQgg.e
5X9[=e>LK-&PPE5TBO#\)XBc3U]TSd&LC)aEA5SA/AM7XdK^HZ6aHO83D,Q&fJGF
bE2d.GM;QbQ94bbSO1G0PFc?Qb.G\K>G0b#g7K[,d0>c->A?M:=[@,g<FQ?M\C-6
YNa6PfQ.N]I,#[/VJC-Y8VGRcc.f[dO;MU(1?#=c,P@-QXE4K[B0[g1CbceN8RRZ
5ZeJ^\>>O5O&-(gN8QCS+fKPNMWQgOOE^QOWSYHCb:HFK+NJ<9-W:9]>]WE5?IX)
Z+@d5KI26d(C[ZfD:L0=_<Za@)[TPd,ZEXZZ+.V]:\SOCTSObAdUB=,&#X;HNJ_Y
(.9,-1#\81\X_BIDSfG)aN\UdB(,#-0>OJU@GbO\6[PD_gd:5_ZWHIJ5g@RN0\=@
L/0eIMTQE=>BQ/M4[H[;cP3B)NeDJ;LYM:Y_;WQ^a;79](OHW7OO,\4-^?bA=eO_
8,SGS@;&5A6MfFO5.-b_CP#.)BL)-PO:bUG0F9B@0GUVW8Ig:QRJ/0&_X-P8bE,#
XS0?)#dJW?:a&YfIcVXAI&f]K].(,3&7EP.3?XZU[TPQB5PZKRPEcaQ4>H]NN1\-
>:f;4&\3e^FQ:;BUL.4ddf2H9Ja=#[+Z\1VG;f^)@gP-,E0]X^CNfKS0,Vd.LL#@
P<H,[\ZJ+TbbBW4?N_HS4^e,6/(E.2=LR.3,F[5ge[-YY7gEO/Q5-DBeZ[A4NF,&
c6L=S;_DN\.@4N7=D#DHZ@f//Ed5VM]-7f)=Y4+^_8TH=CIC:0J(]L[+A5<TDA;e
C(JbTg5f1^FJA^X0L^3MBM2J.4&M]Z/;HUB<T>W-_-dM/&cZ9B9bA#5dTD#eADcI
M1fG0J;d)EB&+M#EA:fcJKXGce.97SU^73QF(\.)EQ<Z-V>.&CM]P4<R5X:\?fPA
\;-[L5)Wa(XQI2QPLQ=a_DG?&-d2_9UE(6[.N+Yd9A1(P\5GCP70dE3W(9\9C\2Z
;B=(P?9H;bS6Z)4]M5D1+A4TOgG[],OG?d[WWMQVBM11<MTV+]F[aWIO53A;,N,:
-Q]H=2@2SG.-,I;BJ7&HJc4D8?P2dIKNggED#XO9T[LBL63)1^KT;a6[(W,OYCU.
BdB35E:2XJOR5bBZ=DT]/Z2V+ZJ+<&(KHOG,ILXFQGW,Y/30H-S3(RVA8=^5VI/H
FaK^2(C0Y\Zc(1C(LgSX7?(]aZbaWJB::U<XHbE^3GNdc.>a,A^YO>S0WNY8,OZ0
T>U[R6ZBaSC3[P;63@5F@J,KO?ZAJQ10@7TaXOW_fF3THW,:Zf=<Kd.7ZIG;2/f;
g/NI2g\^FX5&eS.aV)W/<B4B5b1\/e[-C8K3H[IAe-/F_0de45^8&fV.HJ0U#5R_
_LC>NM)+[2Scd6@948B[-AY@E5(^&0Sg>H3D3B_M760c)CKAQRKg45EeS7XC1D_c
_FWc7de(MfTO:CPK9UaP2-0KQg16]:SNdMYF\?)04O\K2JLg3RcH,afI4a/#:b5E
6TEU>^Dd2c:L67dY3XXLbKB(P.[B0)=VgK3cdN6e(0&eHO_1D_-KZG02_)Z)e+O3
+dAQg0>B?0>(Z1g^EN^1.KSKF[1Xc^e.AVf)bS:KTc@CFWVdW>)cIPDMDL?01J<\
LIb<^<&Z.b:F;cbY9b_(gPJcAWXa^d-ZZR3+1[NO4BeVC3K6N]2#M-M(8E?B@N)-
+7bKHG>=g2977JA#9AW3^P23()gB7GbRUWB1S5[NK>_4@<_2M5X[4P4XMP,5R,XE
<^(UebJAB2ENLL,(G.J^Z6[S\@M<?D0192KGQ1#CZ-GCTfON(Z8g=;Df5,)TFeK=
LX2F,)RN0VO9U>5)I2&PQPQ05)T0TK#bf4ff?c4d=T/O1g/A=9C7:Y:\GE4cGDcM
;a?B-O_^04d8ZYVd?EdffOT7A>,)EY.<WXT1=459_CNMcbPIBcU(=:)If4XH?:U_
](3KFMP0gR,GG#5_N(7dGdO_;6>=I^YI;MVBVf;2NRU:C3aH.\TYaC\L8H64Z;cg
fEPH(g1[=?Y5\]98MIJ^=)3Y]1#_H8KU(g5E#]Ff8Y)]QPN8gZdRW<AX(VSgc?1>
E_b+BbDY<)LNE3KVTESYY#8YKe\>C:9XNdMWg-PG)6R3fYd?<X(X\Q2PUT7B>Vf2
&(]@<ESN_F+)Id]7+O1g76I&9-M29g[;&<]Z&Bf\_a[AV+#W+1f:XWVfd464e/-8
R(32&W;;d2A4dfFC?[[Y?Gd/2T;)_>4121cVdS)::P;B)+40aEL2;MFD[>R,X6bM
,@IDO;d0S^K3e4S,KMZ7R5])4O@/:](O@-HLb<ST(:@D.8)8FD>)cdb+[b<5g)Rb
H>,<&/fGN&7.BW+V#OC7GC4,\a<SZXSSJ_@)-UZ+I+07gNOQUM;XQM53fEMN158Q
5LKQ^NFUcN+Q417aV:,(H2=4.N1UDW.S:fJHcE[#Z;9J^55CS1@^dFReGeOK-=.6
[ea3a;I[aKNS;AHXbQ#<F?aa&bN&@U\_SD0Q:K&@#L[f7QLLcRgUF-;GZge@>\:E
VND]YEcLOH)EV6JSe)/[(=I,]5fbQ;^F5cg4F15dPDSDG;&7?.I=B<MO_H]X_eN5
6UH[^]/PKP9f)Nafe00@#6b&>..OLS2EU?QX(=9&1VaM\O#?U&3FG6HbO]=(a1Q6
XBB_YQ8cZZb(RAB3I_8(A[aMM3,[[+g_0\EeZ^Udb8VfM5OX:86N[#TI<V8=JJR4
A(Q-aSB2&4[0Z/@:Rd]TX/#+3E3DPW(OMW,(Kc)S.YK[;=)dA3PW(5ME(f@V4V9=
O7&+3g\GK@,gKa1eb:QNK#A5]0)1)Q0I:S8Bac\HcGRf)7SMJF7df7e#@UC(N:b3
L+?C9@J9Z@fP_-9&Y0FB2_(a451dg;WS-YP1,^Z5QfAS3T&#H=S)ObD:b]TKC7A4
56d#5)D0?4g8?^T</_\I/gG3.>_0V)[5R9ZP,<SEdgJHZ#,#Ha8dFOSN;+c;5<a_
-S#RQ5K8?HV653M;UMRc?H)C-P)/6J[E_F:^_gY+f(EY@H9L@6J3<R@7GL5Cg#B1
A^>W13<VWJDW[Q]VB7FWc&.#?:P]WMVJVO)c9YT+gEH=9,c+=W^2,L?f<TI7M2-B
c^WBa/If+C#.N+[[,bH924^aK5(Cdg-N7+;1IUG^RL6[<VD9b0\#E0VY3Q(O0aU,
[PI8C@TV7VM<dY3YRC[/RX44S2N3?K@K4Qb[Z,QXQX(@F-;:P(24OC1HGcUYFcgZ
Q-(MJ/8d^&4U<H#UT;SY6Gd9F&>?aB6&J[\M1e.JgD+6=c_^Y<A-B)XA;V<V&3^V
BLE=F\^5XS&@^eCCA6RYB_Z-S-EaU796/R#\X/I722-Nf^2AFeIX(:1HV+Z>_;LM
G1H(_(-:e^)42Nb:b,K.CZ_+ReX](L4V:eC[X4_#^Ve\AcY/SGO>:H[:1ILS.3]F
+Ta855IBMbJ:[86:KV&N9X72dSI(C0T)+5.00/Q:f^LCd>ggbd7.U(K;J^MRa/P0
f]IcG__a4HgCfe1X](DPDc+85c;&&eIP1SJb;?8\aH-,7bOWR/V7J0AVQ&dbd1AQ
YV>?O;R9+EL0KL3&8LACAgZG\C]W.e&QAC\=fTcaC+dfg#WSg8\&b7)\)gU?@F,X
FZ/Z?CN\DI\=N@3R/18\=5g]cMcI4R5=#<-OgfJKd0EdgT^8WHeFEfcOJJMaIHWR
XQ+,g.+Kd0JNR282[P2TMdXLZJ-8:E>?c/U+:fJ]Ube4.7^aRdH140\RUVE@8Qa;
,FI3:f:37-7]P(?<EV1+]c=NT#1=]c-2&EX.PbeZ@c:e_FUKJ9g7T/XNN3Z56XVF
<I#(QPUK+;ZV][+0JPGa6a\/=JK]U49XSedZ>]a&?)Xa49RaCgI//6+P+^8[e,#&
A0?/fgWO0,M+9?&8Jda0UA+++a;4@W&2OC+.KT9;f9Q<IF-O96J??=d(1<B6N?PV
II(G9V4g]<UbAXRXYXHG6g#N]SM_:_QZ\+Q2M+=c<F87-4C_?NV&4#5H^\>>T+45
;5e/+W@44eI&A/KA9]0bRFOVfZ9TX&gI._1A4?M5BH(.K@XVTI9.d0X4U)>cd2?)
.^?1YCQSNE4R+aP[AbR,?fRg7IT54A6&e,SBB@AP(0dJ\XMFdLWaWV_CgS]d(\=&
^FY4-2<^2F][\.b9-MaMCdB>T2\[?b(&+aFS1GYJUM_:@TV;Ddd@U3eL[KCCK2\a
R6G)@/K]++B/-@AG([M+FQ#/Ub=5S5E-cB7-bHPcF;-\PR&:,:YT++&AG]1C3gHK
;/:X_7Y6)FZ:9JF#g5G9CS)?@;dX&c?g=+g)JUCR.@PT23+[RA;)7O++CV0]D2C9
U^,#_fbL?CIMfePXOKYP?2:BT<L49D5R1=1_F:53&\d6=-e:Tca-84HJ)OVGA>9-
F?NO9LA8a#,MNM_M/<c#25Fg+f>944(8D4K1C?LZB-37@98549=)ZSJY.G3VcOQG
-D+2P9/K>-A:78UcWXFg(-fDC;<<gZO:G[SS6bAX51_O<Y/JTf)N^1[M>@3F,?2V
a426YB5F7A5F5R8<W]25J(S\bD^:II\<+XK7)?9W,RY3W+OJ2^UD,=?5NSP&UU1K
b.&.83EfI0eb2OY@.\9+53VE3M(d:25c]TMTW)8dS7@[YQEQV+(be6<4-8f9)]e7
SE2dG4M3?FJe0X+J5C(DcI?;#RY<1N#S[[b]-\#^.LD2U5c?U@9^c19F;Z+6^DS;
XBf@DC5ECX<AZO&F+#2]:W9S/S9\9>3-8F7+C4&@KDB4VaCEXd@[-e_6^E32;[Sg
>OGJe80e_3N5\M22Cff)NX:;H-;,K1Q8bEX>B^7>;5NLRK8ND-gKHJAXa)Xf6dJ9
1+583HFG5H#-BT08:_5EWEJVACIFZE?VHLSYV^e56\4=_C.F0aUP:c;DO-N70c<E
WH)MgQa9M/(4[(LQ1JH]g.-@DJ(J:cf.T>PP0aD=&&f,:NS4RaI^bbWNOPfcd-7E
Z6+G4+?@e2VB3XMK?6>(b5:OYZ,S8/JSUXWF/L)3V0.9I()3HH==4egXdN/aRGN]
H3G@^/Pg54@N3;+Pg(Y4R1<c8/<6M=J:4TXfB8=aV5FS]\fA+2FZ]6OdUK>G[?GL
_@G(b+Hf)>,@P_NWI--/JBPgHB:JOB71@-aUc^gaLZ0P84T>=^,2^.O@94L;V/9;
E)K-CU[;OG,cF,<_SdFQ#Of;\ZT[\+X)g3OMRc]QA.^9Y,74AX2TLKTBE&Od)DY-
UQ)+.#R-bfKQ:a8AW;B];:-51ES0P7VE>D:QUc^40\4OL&4AW;7[g#e_Va/Ld63B
B7M9-0&a5MH(\JgY1+Y_7D+ZN5,&DC9F7U-5Sd2J4:12@DHH9MYJ9+2CARB,\AB>
6]X)_;RB;M;J@c>3&E:P3MX^,5g&E>JL?]HZA5([\NIV]]66+fe&Vd]cSS:</&E&
E7<6f^>eR<1FA+3dH/N1]\F]?O0BA32aVQ/f[aAb@UI^(NN[gCU\H/B^Y6R-_9A.
&Ib^]KDM=-U4JH(f2&JJcS?&/;B0()&e0Qf<B^&?g9MgL;D#[9H391CR#EH8#+2-
Q7]S<F:9]1RMc7<0Y:]B_]B<<@W:ML)7J>1J0eZU7f;C=NG2S+\U(DH&_eF3MfMN
.5<[X#7TN;RW\?Jf+M8d^E(#;)VY8aUHbD@g5Fa_6?:b(Y8MBAH?_\-Z3[E2K?/B
?DU#OX?.D_@8<:CI#[[V?3X:gA5X&#)DX.<0FW-E\9Y66GLCXD,eNP9KcE2dV&KG
H]b?L4DSRT3G@HeT^bW\XcfFB@K;f52W9V[0(<Z-JKR5Z@Yb#9<)9XQa<@;99E[N
)54CTg06L2I/=&T)-B6cS))e^&OTC:J6P]J-^9J:&@D8YZfOcZI,@K5_[c4R(-.S
C#+94PJ#QXAZRH6@NdAeY/0J??f0Wc<BZ@_g:ZP04JcVK3aQGVPE&C>0LZQG7E+(
&RI_d+Z7I8#_a0MC@;>b[A#9Fc4Y=U&^MG^+aKa?E+;Sb7&G==1dKA&S<\d]ZIFG
<6/:dTYd?=OEKD#TL1]K+@g9&#IEPZNRM.</]_-]b6OB9/_a>68C:dJWXU:AU--R
ce@_#Ee0WKKXJ>\]\\)>IRC>QF9U8@UR;\45U986Za-=0^(@FSUB95WL+KI_0]=L
e88^KV#)UP+P4:#Z9Y,ZcfcEY144-LZEN.QOM>HU)Dd\#RFeIA&Y=&(=SF7cbI14
,<Y73QYJ3<GI<;_^JeN(9>,8fa;SKE.UeD<@)@XM<a)38S?:cfM3eAO@98Y(HO3#
^Q</UB&CV8CNHP/?9@RLf2bJSYCVd79Q-9GFdAGD-I^PCY5BF=c@Zf01bO7-_@)M
\3F71&,60E,IagIM[X,ZDE8^4?aLGH4.KEdeQ+&.X(3\0a3Ec\4A,-E/aF1C9Q#F
?8c:d;)U5]aI,<=5b<<<IMM8=<[)&1X<E^,=LTI;-gT&Y]IBUUV^aOG1E04HY>d=
.[013+U\ECGc/^d@VJZGA+\(H4b6,L3/.E1#ZW>3ZQ;9K0J7?/350Ycg&a[gU9ZT
,\eZ?@B-X^??PY.cd5AZ?gVM22g.QNCGR=dY2UGWbP5WdW^=.-(B<O#,4A2&8,,9
GNFf#/6M<0&NPXUSBRLY?&M#(_@gB;>d-I>@DefKYQ@1[-g^?EW47PeO_B,BA[Cc
_34S12G@7R@693fOI&&<TLd_dS&K<<C^F[B@1K3<2MNc3#SM;0D?[7a^a?e?.)>@
,@52<O]e]_D7A=?@[B-RXNWU\&B_]Jd17(6dQE1<0R_QOMFbCD.2&@I9^\d\9)0_
CSDUb(NTddO?LeEXeKeE98N0:]bTG:/ZbUDT;3>I?KB&fZ:2DY^CQ:RWV-fJfC-X
QF4cKJMQR[eX3.:9+LZF7eY0?&PJ->U>#?R5T0-E3\G^7X?M-[6U:)5AJ/X2C.GG
Yc@))Q_(A.^#FN5>5P=9X;70.Pa&g#5>dMI-D9V,=;VcW,[(HHS.4AI=f,KMJ=XT
OZSI&N]g#2UXOD)c@g<PX61_(d#<\O,[fZWUC56a;6aHI-KM4HZ:3E_/F#DRa,U5
ED8P[2c./=d@,.T0Z&/4;6DfP9bQ<V#&:a2>DS^fN8V)Rf;>\28V3.6;>Y+DO,11
^D]VD_cF^fRe#Cf/R,>e9/+OEO#TO:6L++dMFfA:B@bODULF&V=>_(FLF;([EVQ&
5[NK@H+O,6H4UU)[H4XI]/dLO/7&21FE2@;Q9fI_)P/UAC8<=;=2bN65Kd^1C]IN
R4b\&N-Z[aA_e@_#Ya#PK(P\?PJ4AQJDg.Md>.J9f+a_5G\c;=VeHYS(B9/<d=)a
.VYT1.BTS+@ag-5M-H?#HA56B&ce311IVVVL+Ed>Kc[S:BXB<HLTT8SfcC#]_80A
><H0VJ:e]6]QWRP[3F,&PbdE.bZ-=DR?D>]HFYN32FE3:D&0,</-TY30-WK5I-1>
XJ=E9=4eQ^+TH]TH0?c;8,E<LAePTC]8[Y7=?)a&^<g#]9-+[RdAI60AMU(ORGRd
R2Te@&cX\+?cXa:ceb,Qf9M?^_TR8477(C4e9?)/WZKf9#f3F#C2_WbM:5_ZBX:J
R:eV@<fHdGK5X1MfMOI/WCA;X05LIVK60d-NH7Bc)HYg[L@g_7acAd4<#=T23/fP
QgP:aLZ5b>LKg?eK63E])P9U3Va3#b0AE#@eTYN4d5B[VCcLcYa@ggAQ\@egWR;4
[W0K&5\&E+/+6:^0NW4RW++gGOWcOUS2f)N,>?)+d^4OfG,\K<WYSMXW;64GAf4T
4XbP4/<B8dg35P]FV78P+QC4KeeTb_2[KYdg[bWaZ^4K)U)g0-Z7.b<GA=5Z.ZLJ
O=_U(7C,M-SVf719_Y\G-UWFMZ0MOST<AQ8QD@NO3N]^]]E1\J;V?g4-E@L\>7eg
R?K2;]^aAQH>3I[LQfH(d?16ASL:QA14&-+1N\OH/)e2P,fE/0W...Ida6_@<FJ5
FK]+-RR[VQ4c+HN],6LT86dA9C_eZNY&7)2YCB-ff#F2_CE3@62f)QPgCU)FUgDe
M1I]Ieb,;gF73?IEb]FC7<EOIWgLI9X(IK0(.:6V8L\9a^A4W+&Z>0+U=PEQMdPD
VM53[39af(98b2Q00,0R@M1dW+Cb@5MCGb90H=([NCMC=Lc,cW?_(XL9,eMX97-O
HD4F#Q&:>=ZBM^8DD0C=:[U,)Q2Ld#Sa]aXNSDR8]J6LUKZ00d]aPC:[7_5ZC-01
CWeMELfD@bQ[_9KZ9/K3ONaV8#fa#gN[KC0@YL1-g6_(7Q0Z9AeLC>fCa^>0KO9J
LB\SE0b^(-2-0-#dC6WOI<&YJc,NH1_2[Z5eVTA8C43BWL^RF.,GUe3[9Y^^(RW=
:FGI=[dZ@9SN]PfM6A7RSa4A?W&6#,FAF+0\Qa.L=@dRU2^O=/L78C.>[U1^JdcR
G-e/1?TII>=[@>dE<&;NF^DAUX\4N.-<a_COEI)?_EWG#WWJV5(+&VD_121R=>78
[\6[4AL]47beW8_V^5eaMe@\J-ff2b4eX\c;,RIZ+;bLZRQ;,E\>^[C/bOUG?JC8
VXNg<.)S:Z(>Z+VF=^E&P;-SF&-^]A6)7RTVON7gIWf6G970RJ<\LT7_#MdCfW+N
Y<SZHe;YdCLc6&1b/\5ME4DcP?D?9(I[@Oc.23\gE&d7)UHD78=/PRUX_>4]D/&2
Ua,c[DC-YgH7B=Z8T5DPP=FV(b-V.C.7e]=#X#(CB<DbCJQ(KL\eRIBT:O-dUF+K
d5V[Y(E@7fV5+bf14]gQgZVTVIDMTUIY7N&KA3]c?Be.FW28&H9?YMX7A/fF_&Tc
5adg:6I/?b94B4d1A:^]PQU/.MG)WG,<)A=dV&50KK11aRed0.-TUc@CN2]MdSda
[A[1RKA=KS^L(QTWR<g5dROLCIL@Cbd([1OdCC2SU_D:G:;_G^[AMN+W#R4N&<B8
_S#MQ\3<E1PZ>SO3201]XW7OAFGO,N0^+GeF5UJa.0&fL?];6JJ8g96bCQ<#,@XM
5^J&9=4dHVNNOB[6+1d1gEO757aYQYNKYZ;Fc0-IGI]Z(S>#KPVeABL>I3->XFPN
:Z)<:K#Sbg)X_&cG:ME4Aa9cD^O&gA=H#](5a3.LA,PK81A/X/=M^M-^-GUU3F.5
15d\+O\DSdBg;\e&A4P4WS#H_JD&B-Z.F_.([I>IgTP7#;a+7YMaG[>PN7=_).(L
O[R6ENRPS84XP5=3R#3dSNcY9=E7LOMVI?_S/B;E?c.W_0&LAI4U(+:aY;UZUJKV
fcEM:C^f@]1a/c]_KZ0Q1MOMg@WH8cD1,V0+7_BUKTV+:^bNJ(G1UJO<#=^&e0KZ
3MMX&U2KN36,c\RZ2/7X0E/U(JbFWg\HHcK2C\f1N-KE6TR8.I)(82[K@D?UG,A=
B]5]W3FJ5T-]L2(aLNFEZb>T[/A.:99UERS,5NHK_DKGU.TNF=2Qf9]EeA2A6Y9S
aKZJP1K\?Ae&Y]9307\Z?T6_;e0\R[VJZ6<Q3eWW[SgAME_CD)^Ug6(98.\C(R5T
04JB^C_8QFVbMG\0C]FO70[5D<4,\KcH=5F>R=J_,5/g3T@E7JX;0V4aa06cP1EF
O86PI5A#::FAN5<<J,McY1G@]Ne[W5]ZX6d)9+#GVU_45895,/)<]+#9&LHR^bH;
0.c&^\fQMI>G@)MXDLRMa2-+/T-T8]2HCK;dI8BEG,+K)daAc/MRZFIMY6&JQK/]
5CR:cJ/_QP[:)d_U^A,GO.-IA=T\Wd?g;D,0,\Mc?X>GJ^XPJZA4?_d@;<)df_WG
=\aO8&)M/Y>_Fbe79e8cf.N&[DVJUC<L=dE/cNKRV/?TFe]X4LS(>;,[d:bfO-dc
B/f(H.[6<Q8N^EKCa+^T2LJQ0^2Y)L#U@3716G4^aed2H.?15dA5\EAMH:;,Ie/&
F]>S[dF>?D<W>EM;04,fAD<L?^]VJ6Jd1Y>Tc;N^<a+f,1.g(S]QEZS5ZQ-/9=cd
U,693^B:OU_T=)LG-,gD:0:^?,E47[7I>4BM[R#VN=OMb[7dNSLeZJ3X^cB\V^^:
H)#928\KO9bcB(<FEF#_94fDcUF_Y201YC:(B=8^8YENKUH74IK4RN;VV]2DE;aJ
HUcT&J^/=4ZGV:353cgT95?B5J30BI]/&5FR\Yb4]N8N5U]V.#C[;bIT.OKT.0K,
FPd5DQ<>)WB+#KJ,b+EC_0HgKM1VZO(@Q/CeBd?6XQ+H?K-64g0D.C6-JY[KW9Rf
63;>=60J,VbU>]dF=HMY9EJc36+)N5_ZGgUd0[gDb_LT095_PUb0,@7HLd\0=[7F
cL==X[[_A^MH(::;81UI7KKI[&9(^<Df15S5ED)&5OCS7:^cK88?)g0:&,[64;f?
E@S3>+4[dV\AGdX]C<<DY/5d3X[]4.DNU7LM6E7^I?5H-XCH>\ZXN-\dEX4AXa6g
Pd?D>fDCD,&T?#QGF#3,\?OFFF@:5d?YYN_L;>I3/MM^]H]<^Z\>ZK:Y>OdBNZS-
6K.ECP,La+Q61TWc1,C)cA65SJ@:K8]T<<@N<QHH,]EHb(+#QNZ[ZLU6<[W50fFR
W14JJ\=IPOIc=;8G+Q?W>1]UE2>H/g.\TQKOLY3E92bS,YWP<AB4Z6HXW:9f&VY;
?IeI:PdY?Fg/WV\;:bGHaP6Q4+JP,fJ5F6c50EeT1YUM(T<]?[J&8UNO3dfFQSZG
[@9P@NL0NeHEefTb=687@6Rg8gBOfb)^N.Z]0(,BBWN_#;[7D<ALcK<Ce<W;M8TC
f4FH=+<Tc:)VCH]U+0Ee\KG,fe[6YeMHAF@/We<:F5V@+gH<a\X3H,SFQYKRGU][
M>7YGC./>e/eBLB(N;YW7F0XS6F2FB>NNMFBXD8Y<3I2(;GERSXZ0:DcDUYJCUQQ
e.]B>a;Q_B@^/JdGJ9;<TBX=PUE.cTDQ&@QdX,MX\:[0N<:3K)U;JF\)-XJFNd)5
+ObN>>9(7b,D^H55-^65B_b0^?,2.S6=?XK(.ZSPGLWT)SR\f;bDL:VD\&D4g\f3
7bYJEcUD9?;X]FFMdO=TVb_2K4>&PBRSJY6(,aOQc(Mb@V0fa5:07U>Y_(F?/<Y/
=X.J6e9gcPcB-R_7O>C.?^dECbS76]E6]EJLg&D.:[E#A#ICI?I>8@D#K_/QK,]@
RFdPFKAHKTK;V9.P9S10:(b7VfMc;EeC:W1Cg#+]XG5TP#_TMGaBS1YLXIF\GY6A
]N4TD]DLd_0&?1If<]d:c@\4-[47[IAMX;1I9<D++F]gYfXR@G.A9+G\;0dQX2(J
:&dc^<WIOGb^^e3:VU6_GFD)4RM)\ed_BgZT]Qf]&/g=SeI,5BM^Ke2^VeKUe7.H
^<O]_3]]M4#L5bZ;.8=\+\=Wc4KVM(^L-N(;_YN<JW;1:[AOFF,(a-HG9,HN<+?7
J[T/&HX,\6ab_f[,?H[OPKg\Z)W[JA8b9RU9K[Z>YRg=;:92OdfR?g(&fO@A]O?V
AK6@,=HR7N,c^]=U[PZBS]B&Y]FQ_P>Q@6E#(f5IUFIFfHA+(13\X(c9A\^YLNFY
95?S(+Z9d0XM36R:)/R8?V)b.0V]RT8>GGF>6)Xdf2(4?YCG894FN]@@L8RB3FC3
IM#0J<[+.O:N:K\4-BQK16@/E\N[_\\HU27^1RF47Q&5X<Y.=8[?^2ND0c+K=,RH
XL-=MAYbd,&[KZM5@dIY-TRd?P0c=&J,3Z:<c2OH2;[0cPQ79AY3PDGTKe#<F+AZ
MM?8HE[8)UE1@g&]DYI26e7e:WGXGHF&_OcC(#dD0Xb_AHPL-fSO[>&;]5X+C\++
8C[B.\TX.E4M=ZAW.ET-KGI31g=UP[8HbHUS(BH\^g39Qd29@[>AcbT@\9KW3M=[
8#R;e38=U=a0GH6IYR2f)>J_T=.6NJ3,#W9.,J1H3^E2g^W_R3,JI_H&Y#e9=VUI
Je81ede(><MZ),f1[)a(eI#O#R_HS3;BD?-FQF,0/@/e]FRD.\6)?T,R#f<QLGg+
JXY,WMVL[6YYUT4cQ;Rc79Bf[@Z1UcCHRZ\ZS0FEWI@CUIZfUJ\.B2D-C6U0KLGU
UI]<@1^D:M3@Fb._OW(BLVVK@1MML1b7,NeIG/EIG9D>CKT)UNOF-ccH^PM5LLH/
F:+/D(e+.O)_ZfcBMWFecb5;ddOI)a17FPP4<3_HNd(FEVCO6V30fb(&K6+K<L&K
YLagJB&bfc1T9+71^X@:ISDDQ0FLHR^VIWN+G0N:5@&HFE@^Ug;^db_fQ:\&X&CR
UC.Je(^H<UEP]FUf/@96>TTDQ-b#)D=#g?-g#6.-X?QZ^_24e-E3U8=>QbV8(aZ)
:g>Q^CdA0[FB3DbRLe5SK3\&JW;RF4(._&KS]@C:4AHM,>=YA1X3LW&5Je/gc>2Y
L:)@SXeV;TE\<N:QMM;[NN<8LPJL[Q)aC\4+dgG0IE7fX>G0,4g_4D)]A+d/2K3<
O7aR2?F/(cSFFT?7T-\b[NW:8UT7XH36^K0bLTae9)1>4XOTZ8JZ_bE&96Zf^+2d
&IaadGV>2g.BE3)>;1a&6OWOSg&4#-TaD0J>]+BWd>>@O+aYMO_MT+b)R&_6K-W9
g\V1Z^:2g;2:&H5\Z&J39E:fDeO,VM(M@.eME.d)>1(e@58<)GUc&1cT\]=;(J\K
UU,CZeF]=CVC08Z_+IJgWd4-fNaE811/JI;)GO?,C6>\OgA?QT7^]-/WTW6M[fH9
9b45.3c+^XXFc\#9_7OWWe40b0MeS-f,6EgWV19D]AcQE6^dJ)a#N_d,IeZP@c\9
\3H@eg&&_<=7GgI&;._[<1XMG.7DLY(PEc::/XaG\.?H-(AS9\(<eG-egDdJb+[g
FU^SagUET&I>;f2cSQ0gOV[6gSaIFCeJ&:)gT;)\7IJUc:WR0cBcV(/5N?L#,:(O
B<UF0X-/2]LW^ZPNZ_#^];+KbW_;:9<.NUGZZ3YZO2;fN[Z;Q\?B5<+KX8a_Y<H#
d1G2?Sf(K>W0#\]8;&#g;A52A?4cf&PJ@39=PFaM[W57T39GC\:_ZH@O6(#BcS5P
eQ,5.VIE2,,:+U_RIOdTVV;#O\ea>?dbEN/C,BLSF)5N9/a-1=JTE)1NZ_G>c2,=
I.GAf,;^/b&1VdA5C[gHCfC^M18H5W<H<Z6I7R^VG2FgTZHOE[V@6dCD71&T/&e)
1b7G_TOR;fK,>S?g)bB)ZE+H6L\_WXX<^[N1Z<6ab.b6Rd3c#0J;RfR&PT.GPd8d
\,e:6>ZRQ04BKA3)QA>Dg.8IC5\\7fSf/aW8Q)dI]Y#QgL-P\K=KW+,J4>I=86@F
=<0TN#4:-_(6Y4JUBP8(49&J(55f2c;C]4616?=_6R2]]W8@6Z33TZE(JV]84S9X
2>G4H5E&A=#Xa-LCHH8cQ57P>QR+P0dL+0b&1(Xcb+[.NSIG]:3XFJ:+4[QK=,0>
BH:0[[@I9cK<U<b]c4,QQ;[(VN<4WM5].>C<D>G^BSK=:X40]&&5W\c\P@H9=gFL
,BddW(,X8==]=1<A+VgEgKKM&aAf8KZFHd419@232AQcN>6Te:+;^9W8A\3G3e1K
b+9#&g),GX&9\I82.AA/a3)d8FIgK5_][;Z1;)[9MeI>\/;I_R1C3@=g@.-EI)8Q
;PB-Y^VUBMTG.bL+de.LM2;VU_F1;/[&W(bUPbFK[.I(8_8U&M&bKM4B;NBeOb[8
<f9_&.,EC:()?U?3<a85@BLU/_?7I6T^A5\1L:d)-fR;C<?O?d8[@T8-3X[@,),C
UH3S2:M=/[Z.0MVTE?]ZI\f/?<L>#7#d)a0@U))1=0B56\PO^b7OHPTSO6\Y[IBb
RggP3FTE3RE8LaANA42C,ScRQ:IZTK7e0gFgF=Le+7H_be?D7T>@8-cBa&;bV0I)
IC<5=AE:[VH<P3>8M\.F/c?D\)[V4))^bK=OQgH8T,81J4AbgJfeP+cBE<V/\E.8
9:C4fK89D0[A;]Ag,2Ae.Bda_DFcfBI<GGCfB@cP+<AF5(JT?/+(5C@4I6&0N?QY
>(.==B.DDaJ=HT=E_&W(.@BdH&1)VL(<:eJYDL[834,TH6LL_(ZV>O2V<cHBcVcB
Z]6TZET\&615_86EB<)A<XN.MaFCeG_b]PKQU[^Q0L:d?=f:(J[]<>+FRT6+eb5a
c?9&gW)^FbN7d@>7<@0H9K45\a6g#a;:(N&\-8c_9:YQ@dLPJQXe&)NMIXNMg2+f
\BAVALS[JMYQYRRaaQ<EAMQL,TTbO..JS>aZ6+BM2?D+b1M5(@@XEXE].&?R,MR8
IS1U)8eM2dE:-:e/K]bQg-Q0N#HI]A0L/9Uc6Q6)NGgSNBME=Ld.?WO;b=+B9Z/Y
Q>eT=LeMBeF(3-KPL@_?/U9J)CRE,OF:44VXLOL)/9PcON5Q\,##dOEAXb1d]U)>
EGX>70a/T.1^K+2Xa^&Y_PQ3)A&E_FXf]]:aD=353?28JN6e=a20=cc)03aY(H9+
8_aO/75@TD;0cX33cPaSg9@S1LI;#VEd.:\M8.ONA>U_,AMaZUSJ6^-@1SQ,M-29
4-RJ+>V2eDZ6g\@7.T(RZC3PEc=-ZU^7M=]N.-IgU/UFZV3LGOK3Lb??b3^[MK79
F)@(9=R#JPBa.T5:1?a5TP[#]1V+[6c?M/L?/:GMT=JCVHDL=X[_,HP_;#d]cDIC
6VF3@8.,\=-SE89UIBd-?2FKd10Bc,V+TgO3EZEL/?70?c\YedWZNLT9^H&M7/Q)
8+/_dH9e9<H:)_16UA)35ZfXH26+#4\:-C57Ie\;RIO&O<4PZW;7Q^R_TA+gXTFQ
>E^:BN:#/D0E6DfKZ0aN?\]<>I(4EJW.GZb9JcYTb[XVG._:b629Z4,^LSV6@C?+
MWYGZ.UXX+/:UVb=bUG9B&DGJH3W66=FLJE^JSLAb_BQK/dg3WMc-,5gaXE(:HdZ
\6d8<79@EI[WFO6.4/LGR7\E?a5Qc4[Z/FOVHbM6:g39X0[@]QP.OH.bGD6,0?K9
R;>[R(E-412FN.]-W-KQTYRC@RWW()KB:\PC5e-@RIBdUQS<;?)HHL3f7_UNN0Y>
;Yea()H?WMVOeC;4W;E6AX14=_?YEY2-/[KW8)<Bc2E\eKFW_e;H&0\^@EBIU=d\
_HLTRRg2W[>7>NGPE=]dVSbFDg3[ZCEgb>-.3Tdbd5<)PWS4_3F3ad^.YRQXS(Vc
U/U):AfTb_BD7,EDLc#gG;[-5KC_THR80WeIB2^M,aF(M@Wd_0Z#PVR#BLF]+cFV
S?\c^P\^^g\=eN53GbR_fDa4RN+-H?3P;]75\-R)f&AYRb3>-G/gWGBFL4(Z[c)V
[2]S?_OJ=SS7c@RZ9]NEQ1UUN73/[?:<.FB<Le)+Cd4PF?_N&V_ca8@KSZZ,OC/;
2CE.6<9L\=dd1H6_YR09/HE,c;[[NgTYWUC-d@D3YBZC98ZD4)fg5=6-A>:4QgU7
NMM<YP2S.P@fe:H_];T0d(P39B66/6B3,SN)<JAD2Y.^/5XXOV.e[HTYJX7):JCe
2^7-MTG?G<>V84X^IK.C#a3E95D0=N7WdD9N[T)RAM?Hg)[(^[fMb=69cLaZe.B4
]NO47c0.LBY)T]NZ[A/25XM9UVUD\437aQ.2ATTc9+UCI[SdN02Y8.FXCC\.aP)@
db<d:\6C>(c4^Y^O><f(85S/VX]^#N@a,:b^JY(Y?X>?aB<OH<K(IA(B-37fee(C
3A)33=@K9RM1^?,K7OR:9MW0AZ==SeP#N7Q(:GKVMfFdWCEaDVeT@=423>UEb++&
CQ6V;=bZ#L+EH[W]TMa9WZCT3ZE::.O4O(.\baL_aDP210?1=3CN+&U:E09Y/L<S
G0/ee((Y^H0FR+I+_PB4>2B7MB?]]ZW;eX7)eF]a6<+e8N97)gE6BQP\Qc#^:D7a
UEP3Sb+Q>BBWbSbTA@T9(1^Ta0LLTVdM[0Y;I)-DY0VHcVSM=^KD&EB^/,=QTV32
,ZOe@<FbVP:QQ,dR#OBPeT&U7[38U(81@_L+Z]fG2XUZf<;1/aHY+Z9:/.:ERK-3
OW6VSPY^;+(W&ZS)5Y-8-T,]GS:GMQ-2gQ^=dQLcU[;L-I8g)2AV./IE#CDA8/-<
OfJ,>G.SHg=-.@HXV.<S7UK9O.9;/LU=V[?&f]V#)=aT1g0<-5YeCPe=TA;P_>S/
T82Wg#Y9H(LDc8[d:4^e:ZbNRe^&J(-]ScG+CL4;P\W@W[+>1[_-)9I?,#&L1Ha]
T(L+YcDA.=-6PdO/:<?]5:9B.Q&@C>X1J]91=>+F3_H;-+Zb,E)cU&+W>UT/@[V#
cd,)MQLg^RMR.U]95GD#-H5ee5V47f&VF:X:Y>TJ01XJb:Z=H&2XA(F\g=?&P/g9
Kc&GC?^P4\XY-F-+OU0NIeOKK9RZ8f.g0OQ^C\GFZbg;8T]NM=EG98#1SU5/VKQ4
VV0g+YPIX<B3;(@A&MH6Kf@1W3UPU#3L^NY=G^II^SeMeVDX#:82H<WF+B^Q[+:O
9eLYR4&a_ZSb(9M>g@845/MK)]<9@VF+HD^f#=9ffE&(((U7H.O7.WgOO8N<I254
1/aG-V6UXdN09<=aW.@?MR:XV8O9,ZGgR5eU5CLeB8_0b)E)]4S39FbgU.g:e:>L
9CG=1FDaDIS\5B7+_1Ia+SId>:\LL3Z9<Xf:e2<,6JM=@RLX^A_bCE2SA#1Td\+X
aMJ5W<[>3T#>29:@XNQRVaL/Y:/JX3R8g.O8S7DAT2ZaNY\W4Y6GO4P_BW\V(-d3
]9S4dVLaJ1D?V><AQIRDK8//YaC/PC2g&W2R2&M^F=g3UJJODQP>H^F)/LGO5=O7
K=Q5e2OEcO;8<-8ZI9U&@K++DI;UbJPLCAc#8LF&_H[8O9[@&\WBSFaC:J4b655S
5VWUJ@;S:FD3#>61XMLU8M/78#27@#]T8d7g6>VN9dN/)PMVUZa/D092:4P,\<_=
Ya)>;a@C^\PMLT2CZLY<+<9[S>af2a:2K7\?SZ7BZ,4S62(^>CL+<^cMA<Qg/e[:
TJ^D21W[B0cS-3O,X3LPLK+YHfDfa@GX)6f8D-.BT;>^[ab=DD@Rf_(0CYC_aJa7
c,:3gFET)XERFMEO-AX&0;3<a;cF.JEeN/b?MPE@<^Ig=R894WaVS;5<?Q&?VS7Z
]RO]1;f)QPU0+)<^2&<T@2cNfJY>K:g6NKFMCO>8d0V/agNf=,;BO-cR^=FNeG=S
32VgF.H85c-C7e9,H.;S_YX&1@/6OL38#1NdC510dc2-@EW@K_46H?#aH@):SKBc
WX=2.>84AR&&3<Xc0ZHedJe35:;=YJT4R(,T+]5KS9;6Y^eE0JD=58<]R;GI5RDW
/;X-PgdD<>Lc5<1_R:)dagUNdJgVHL[1,HN1_#(:8YR<10FA&?#:)I-Wa2[^0c4g
c]bDd4Hg7O3dG/FbPOb[H]E7[O<5RR0Pe\.O&Mf(?V13&Gf)HFKND#9ZcO,5Q3VH
9c&aa0@7Y##bD@[GcN,_KZ/J3LBIX.\&=[#ZK_g<AX>d@g#QdKgU2IDZ<?.U6X+=
OD)D4O(2AR#E+Bb@]M&[-#5B>(gKg=FM<FZ(2Z9b,+>>=Z2QcYEOa^_)7)>T.:1S
L8d3KHBT#,cMNW;8/SWcBOY(_QY.ERe7^?4./=V[.F_X&<>MMUC1FD4<Dc_:GcSW
U&^:5):M)dcE#JP)9L#J@L8@\(O^TG9:f(/Z@D/[ff@FZ.gaSK9,/F3_cb;#ZTS#
K5(6\#aT[^)+\]Nb^]2A2?AZXU\Od@_VZ>e_M]-D[c::Yf89]F,6?6LHOCeXLeZ;
UV64554Gc:>;dO.#7W,?J&fDg>+R.c-,F\ZJ4<WAA/9>P+0F608F3RgD^]UTG4MY
:?CJQ[\f<86NVW0ZRdA=UGCcFM9f^-OGSgS<EU4d<G;b2N?0cC^ZfVaP7WL;ReBQ
E.WO>,e5<[YAf8MRY2G>#/B3L0H]2?H(CF)+(C:(8&T5\I\67F(HfD+[5T\W.c3V
.B5cNN8;FaN27IX6Oe];)H_a2LQ1]W_WL_FAa;1.,U5eE]7:BN-R6B8#=B699EV7
KD.5&WJ:9R.(1YEIGd#H2/GAUU-.bBB/#aF65>\;[VYWKI=GMH]\e,W^,bb5YZ6[
Q)<_?>8-&8Y>bW9:_Fc4#aBSS5-=3C2>KEK,M0PUV]A1^G+BDVU<O73P8^/E--TR
=MUA?#-9e]2@gU5f=,\P_O#I?+^aa+7;9Df_:H:.#>-)@dfbXMcd(eMPS7c#J@H<
]Z3V^]1#/Q&4EC,:MYX\F_fbf+FK#HI_0U&HBI\.K+JdL5_ARgLgT@@21SRLQNG5
EI\O?#4Ub9KYD0]0?d09-M_SS,F>^7,:64YWd?+SQC]I-<;dXO_gLR7;UcHG=<b:
&0ec[R<b]8fH\PAE&F63S3F5R]L5AR);GN^<@0Q0X#YX(ML2@FV58O1YbK&11D0Y
ZMNLP?a1@e.Q1?2BTAX&<@0cH60N#/XZ+/1@/_LVSET^_;;5^;T_B_;9bE>4N<D2
V##dS_#9PEc@E;G?=Ze77)CUJ<80:+Y]R5_)QB\//T89P;G.YeI94MEE=a3UTbeJ
3d(&,TOE2OC+>R8OC_V&D1;;X.+>W:P_f<+QYaWU+I;2MDRZ1R?L[28@63(>:0PZ
[W)D,@;8Y]0dC2)Q,K?>G0E^YJg(K.<):=^S;Jc(0ROVWM4d-P;A@0g3B#0ZU97K
T,@UZgMZL)&N1,9R_A6Y:6DGHOS5[G0/,3)F/GBHBD]Mb8?=E2JT2NP(N3X@EQ2H
11D+^5>ZVCN;7DFLd5Qg@ZT?9,SLZfJ4@,3M:&Le1T@>F=^T6OF#XN.#P)0.#UaA
aM_W-(1I6GIFLE?2K-NCd8b,GCI1+BJ)D9G-9^4^-;Egb)X2aS=??cf\VfY_C;,>
2T@@/-2?GXEFT1KS[;4.R7:S\QBHY,2[ZS-T)6FTYOK[U#EME;3fZ.KNUVP2a>J+
(K&g=CR]48-?>I-9>A8/#@Tb^(>#]2L??[GMKdd:YX9#WPb\WG?Y.Re=;#PeT)aI
IU[b+-S0?LJ.C=_[[]dY.FT5cEc^eaO(VOdLB&Z<e-@?<_Ig4#D>FZ3FS@YMZAa0
R\9G/\INI.36T2cG,-1>aHB#ff(aQYS(+]38#ODIWKDB#JTX.LM#8L@EBG9./4Ng
T9F7ANHeT[BY+4/:cQOAZR7_:bQ5QDKWRUM]AQCfS8L/+OJ9@>^)&Y60X0_==Y+4
>.?<Q+:P?&5-0UE3\^<^>;]=24_6:O=5aSDQ)=N?eJb+=c#AbXSG/;;?#X?J2OIc
8Y^T7?SY-\30#eA?@/-b;<YPTSYe^RRb10Db7]#0fD[Z#L9eW0Q(VF6?5)Mb>G-[
2Q1M:GSI60[&4&G>WHAX&[1S/R;CCU84Be3J^L>+Zd(HAa_Q(-[\;U(/3g.H7TR8
^HR2_3A(Qa;-Y3L6G>MUS<ZV_;C0^EGG(232IbS(bY\Zb[BAN\=.U(bY^NFG8J-.
bd<:/eZWZX--SACdZVP\;-E??Wg,K2=+)D7bP>1J3@#X_;G;#,,HC9WNeBLDfRFF
N&E#V7dI7XQd)S]YMf.538NXK6ZYEZU]2#BF6Q,NQ,d?EW<XLB1a\1@eUIO;\?T,
5cY,3.HVQWYAVG&<Te3^-,b//S4J4fC#aDEdM#D>ePINYZ<YM5^_6;,FT-^;.=0Q
0##.-XOFLDSd#U.EO&-HCQb)9cJZ,[+c>:@3bJG_C@X^CVZ#2H+=#7F2_N\#QKUI
EI0)<^Ic9=>G@0[ENZ#326G:Kc-I\dGg:f.Q@_-W3FE&N;S-cN[0G@;e?eIeJ/TI
B2/2=HUe+d?^=U(1F3XZ;HBS@fR9f>N@Z/XP\IYbe0SMb[OZOG0NKb5=LcH?>XLC
g<4;A[\c[T_&N7VJ-1V/UX+e2cTG&TPBO]5c;)&;>558b2(NLFXef)O]=)B=\d&)
\<gcWda^9>M\RLc(RA5eWH#XOD^__H.HO14U2)d718W5>cD)eR002RS9URT4d?A_
_#8\Tf_]C]RaS2Z\3U96fD)>YHGY,9PDH>FK?@B&HNCPWPcEQJ,3(O+a_+eN88A_
&\/O2FM.?,TI2/W#L/V))>L^\>;/#@]E=F=N(MR0GLeZT;8,@AK]S0Ne5Z,BW6[C
/417<O4c6Y:HB-(-J&9e@U2,2_FXAfZ?7YOFfZfW6FX>E62HP3RI4KG?52.:DFHE
G@1Y,\PZcWa^fYfU]D1DGX>dTJ,EO^9U:@B_G;?HV?&LJ8,\[4B<.O^U.HA630[f
HB@F_X:fOV<0M)3DY]_E4UX>5-fS7M]b\d8cceIQ:V(DOF=?BMJ31D@d\@O8I8D4
[a@ZV-AccON-)/N.>g3H:]eP2@eK@62I./>U@C&&cRcSM_TTO5P,(2HaUBHMdaRN
[VYE6XdJ^IM2ZPOWR(P7U.^H5dGO4KD5EI&W6Pe^-\cO:f#\8=/^6_M]9_<=53S)
Jd;-fL2Qa#5YK@P@d^;FPE]8ecXYV#SI4RH>YK;dXQ#-D8C[>BK?L([6]79QfPL>
V]?L>=c+c;[bJ\McSAL(Kd]V=0>S96PYPEUGU-#L>9/2g5\PDW2I[432W;6ZS<UQ
UT_CVTOgf8D_O,A=g6ZRCg1?Ic@:FNN>H9R.M(\[&4f?#^M/J24eX8bNg1ScFGZ=
4SJ>#2/=;_-)gV)O_e]D?>8Df<b-[<Bd81XY]).=\^G.eb(=/]0ZU-cG,<;2eERE
W:IS]DgUN?J^2ZYG;(&J>.\S[QdIgVRLB>\/<bg@;6),=\QUN_J&cbBJIC+.24b.
,[,e[+1[9NgPR^dI8Y;aG_5[S6&,LW8a^cL^GBPZfR35(WcC6C<E>g?8Z,ba0O&;
00J+>T,G_/])Qd+,7R>S:_@_924@V7a[0F1-+JG\,;ZXT,]BT1D2Nf@3GZ[8LDWB
\>\\a3G/c3=9:da(2-TE,=^EYWKB/++B;K:WRg<5CEJ=fPQ5ZM.e+b&\_bR,OX_#
f0ME/RBN^eZ-g1F:S&1>_IaH1BZ4B?QN>d0PB;?1AV=6F,I#W99Y/GX@J/KKBD5M
25CV@T:L<2C7VA+.=9Keb9Y8Sg05#7<K.ZgT<AC.P?[EKP0PL,S5@A;;dVQ?NX_A
4AF0_V.=8Z<]1L,=Q[&RDR+C2&;YQ3^3+M4fDWG[797MDZFXH-TTYE1)cCH@^Wb5
B^I+I7]9AM7O<D=BR,A-8UMTESB;<?J0>g^QG#ea-8EeLbCgUK(Y460e7G<dF.>Q
5TCYaIOIEE^,IS_8CLTVYUH<L4QTd-AcVBgHZ3R)+ggR_>AU_Y48I+cDg,?0;7ZG
&>.^8PWARU6B8G+=MF4/M4MAK<H5YeMa<51U.?)41g=NPDa=R)G3QX;E5Q1]:FAY
aCP3\5>KO-6^;\0+gb]2^NaNSD_eFC7<X>6KN^9[8JI:VU?3YSaJM8&:]4Y+,&N]
egG>[2J-gVGRWHTZ=/XL:1SaSRaAZQWfM053^fX422bSBSA#9]IG/a@4F#F;M,&M
U3Q(<V1[YgW6fP+@U0De:f2<BQ8PaPbbAR+/KUW=1ND:RV7<KeMP@(a,0JdEFU:;
_./Y]Kb?gc\A)J@d,Af^\1;SE&].Z/K\/SgPbRB/[[=4OG7XL?CMX;fRT#DfYM-2
-d/6CbLe/31Z+3XR9RH4PD8@6ZfgF8Af0e+aWY]]U]T>2_/6\WNH3OJe,dafHN[J
ZcdgLBT>V#88I(cI#9TZe\\5EI:^JQOYg<>4H)E6bTCZPf-H4.9UIUCRGA_S]SQZ
>;g)#f&=D(?)7<9d+4AG=M[N-LZ)JZCc2?e859V588I>P&aY;,A,S.KCf59GO_@(
f37(YLG31B<=_[@^GAgUC>a15QIS?ECL+IPM_d4b,R&/5Rb3^TRDB0K<+SOS6c:d
ScG&BZ-@#dX^N4<c_39;97?-Fg=Fa)c)0gIMYWBN/Yg;Y<fc>gDe&BZP(dH#H?YD
=FZ6GW=X2U_LC0e@=G^F9#BA[A2QH;YUbAbKX^?IBg9[[(SB=5L\f-7Rc#=Q-HSc
/TIVXW</b(==BYXOG7?+g#2?CNKV]R]79FTg,3X?=[=3]6cTD(KLNCBKQgT,Q1T0
F7@]SB@HbWSGD==M::_(B7_#(AGA[Q38e[24#J&V<L,B2BN6:YLF04:Q9b=K4^^/
8QTS39?X/ca(FgAP7W8GI.T@LB]^TaDX\BT;]/2A:G:564@+A6:<a)0?=Zg4VdZ2
>XV5\\Ne:&I3)GGNK_38=)?P_^?78:)/25V\N+.1)&J@bK;3)U?MM=/^1.G6L\5;
E.1\G4_MgO[+=(3e_-2I(M#:=.1X2^H9VLN_OZ+6SMPBC#X@<\;LAJ/S+#A@6R9_
f5:8Z2T_8GP^D?M=/>BDQ7LHQgbH6B\\La:O5L2.+c+BbZ.A7eBW6XN09[P>R8Ad
X=dB064,->-@8[IG+3V\1C4V;a&+GN@FQ?NP2M?#Hd]gOded5_0g+,UAI.b8U6+)
_=YGeTaF,:-YZUZ&Qe[Ucb7K>A^=R+Rg?D3C2(1eIV_,^HTbVPLX0ccA>FSXC@-7
QbgCV^2c2VB(^?N[]X(W:]a;c:dRY7J7Y)G\TC[GGWcJB)WZYW\]&PPAIYbEA7Z?
(?Ka^D1+2Y2e_(7,XeCg@^M;V5.ca6O]b(c69cga<(b&<6N<<4->8WN,A-8#ID<\
E8Y8:)O,]?;OdDUb0TXC9-.,64;1TIYJgN:@)g#]A\#?.@bF8+1J4d8R9G/TL;MW
fb#S3@fCWQb\V6,Tf=J-&]WB?c-^NBI>+4??XV[IHO5V6bNAQPT@Pc26\3.Z\<>g
e<NO\\&&<D^.8e<Z5]>C=GFdX]g7BLKR&8C3gY[IEaA@=_R1JMCV4TcJ4ZM6Z#(#
cRcf&e7QMc>MQUO<Q&#S4FdP_IFW(?bN=@[HWH6+IEB?f)KR7BZL.65XA7.6TQMO
]UPE4OS_>-?Bf#G^T_:]bXb7f#1I4eXe@UO^-1]0c4R\/c@Z8JN;(LL5KIS81-6\
<BY@FT7Ve,/^73A;9WCM>C^cV;]5.D8V36\6P/C#c11KK(?G1?:U._9B.Z5K44;6
([SP>EC(EE-0fIC,HO^RO,L5RIH4-eM;^eG3U2:PJ;@4K97b=D7af56@CXG2Q,^Y
H&2_Yf[1W1(Bd?/4;X3WeZ#+8:bX+fcR56c:/.V#\A0GPWVP2M4T4bNAIM@<\#5f
\NKFBE0L;JM/eVVC=^+WJ7.5-,b#7X3Cd-c[5b1ANI-N03EJ8)O^>8:d)0G=Rg-=
S9Cc?f3X5^X9.Vf4JPL6UE[&N[_(5E]Q]MK.KSK0HW9#\?LENIN72=g<:]\E=3+Z
#&^3@#g]VEK33&eK]&<>b^e3g9]BY_@QK.\VZ9Ff2TXO8@TY()fWW<CW+8-TO,GY
f0\^cJKYbNI;6(@UC(]e@<aZY5RcR1NEd#V6Qf<f\AH\25A]^C]XGKQ4I>WMT>cJ
/L?GN8V73I?<g.FM)YKD^V:TQWO6>C->d@(a3&#CS07f96Oa2JE&_KO9B+?WafNV
e09PHQ_DBW,IM:0Kb1P?:8M#bB9JcR<U:&Df6.HaBT#9_/<a4_-VVT+>WXb+@?2K
Y.NWDcccaJbPSU6H,Mf-J+8S&DW=9V)&SHN8f2=MV3,6Ef?aRLL9@e9DAG-0-^)?
QZe-\B:\]>9JfB&8e1#b6/fP_&UeOMHBI+8AX8eX4[fGb(+^>2((]Z[8\4K<NFNY
JYa&5>Z3SI)T7V[0]KZGd<&D7S&/?#T>G1dFOgR3IcQ?5463IU(2D6e1LgK#8MLI
=4A9[?+>J#NNUI^eg+EYL0?Q#HKH2L_IVe1[JQ)B&DFAd1H\V9WSQC>Y\4+eEOdJ
V\+9,2efDJgU;W5)QY2D_<ULN;ZX@BDRTN<6MCZd&)aJO\JObW]B)FIbHA3]MCX1
;SdVP-DNaQB7\&YA:e4b?UD/(R#Y8c(B)G86)aaI]dOCB:JDT?R70[[US+,27U-Q
T#R[bG;d.EPEW+G\78^D)D.Zb)UO\<&c0;1;.&g#K5P,?<:0O@[BOHg:Hf\8Q#[R
DYDVP_]W)I\13)MI_K&Y1SAe0a?.2,[ELD7CMT?&H?((7gc:WTC#R+(DJF69CP.G
PFW3\3a<.VD4,-B/R9fKDP(QIQDR;U8]+CGBA4Wg-aKM#F=U.)SD(<a4N4IdB6Fa
VCLPF:A\#@gL9Fc827H#.J9XLB&YN^:W,CRO+LLL#^^fOMUF]b=PZCAZ?3@AVU&I
JT]=RZQQ&R:G4>G(),V(LAQ8NS(]LFS5>2\M2LaSc9(WA]8d_8ee,Y\64MW22,_Q
)#8>(Q83WQ4)&DC3L<V\4M.[2L0c5^\=D.1I,f44^^PfWa/g),-IUD?4aE\^/<[?
92_0I6_V0TSI\G0cE7?M#<_&77_:E4[CNO.0.KNE=d^AMbLO8D:dGbKSgSQBf<W@
CGZT7.MX2Z>9:_-LB-1C:gSYH_\#=+II_VCZCK&EG4YLIQ^f2.H);cfRGRUJ=(-U
HGJE>c8DR_a0M3/99LEd9EBcbd>-KgbgN3aCM<Le@4@.^2N:-eA@-RKdN:O2f.E,
:[a2BAEe076UNH/#+Yd+G>#4L/f2XaS7_3=X:I4<(gS1D.+E2826)[]X;a^+;5)4
F#]_RcNV8eXb7AHWKN7Da;Yf0)>2Nc^6d;P->PW&42&5(0JUIdK56g4:E8]<0DGY
FFPU[.Sf]6.7P:>1UMNQ@gdZ7>bGAX+1e)<@=I7[@DKYdcH@]^LT@bOB069.A\MJ
U_JEdWeS]^XF^bB8<J#Nb_Ac1g8MfC1^(RZ:G^^f;Y(5/f;0A_J;d6SU;ZaU30F7
e&c?gIDXDgK;5aX/<-1DcI1.&P4G->4T46?gO;#GMBBZ0R7X<=M.[Oc/7TR5fY1I
?KMPdRC6.F]DL-HdQ1RU@aD@?4>A2afd\bD>CY=LLJ=Nb:\:Zd2CN-E4#@=,4].K
b^3NVPFXL]?QC-c\>_EM+R0QHFL(.^F?##b=517<7).?3:M?Z[^.R8M+@[9c.Vg@
09gW<?R6B+J9]a1R7VfTfSQ52I,&4EFUP_]b.GXXe9a+SFUI_O.\4d9#;WBaVRN#
+GQB0;PU2D5_WM@^R7<MTB>]:N..cW/QJ#K[eWL-VCEe5c=L65L7?LHART3V\85@
L<cf(fDYSP;XQ-3-V3..]0H[1FXeL\AX,LTPTIBe600\,)9<K<)/bO0bMFT8&<YK
,a>RI3<+RL;42;O[eAE])^;M&;/+WB4)@FQKJQ#M&7VQgDF#Rc5Y#Mef-Y<.b;eZ
=02MY(F>ELL=__X2-(WIP7U4@GJf5F5T0XeU-RZeO8LP<N#_/F-#UWE\@1E,&]X6
UF<X-MNZJY,J+JLW,30M_RXaK4[H4XdK7JC>VM\DJI^edaZ5AdA9.VXfQ+/E/BWP
7Lbac2GGZF6S0f5?Fdf_a;N9BNI(DUV&[)U=7\+8b3HeWB:HWRI@U<EPYW0)/L2,
aHWW^.BAeM3JgJCHJ/7:T+I5G\P?&=T>[[.<AAf4J.I[+X2]1P)AU67QHP=W4>e7
HP5LQf077<&_>H8L(#3&\d,:?#Y?WKgL1f,a+dJ&4XUd4A#dW>U#^Pe?\=L.-,7Y
L)-Y_/Z5VIbbR(_Hg@(IZ#b])#4=3E@_4RUP5ARI>U+2;S,c2a:>IIg+af^@F-Fb
+J8\-;de(H=Yc35YQ&B<bZ17+NS^#A&D8Ue+/X:H7]?_CQ6<K:Y-g#DQQL:JC:J9
KRfRfV_B71f:DAO12LJ1>;<Q@S?X<G4+;W:AU3Gdad_/d-C?B@>HFXP3Q#MASZ0C
V;[@Z0^.LX6P71+W)dbV?^c0A9B3?QaL@PUE[K/46V[8^+[A+2[ISM7\UB&2XLLH
:dQ=FWE>4?8FgXMHI<W8c4e,(US05cX\U@9CH+Mg07OZ0:TQbE7]d=(PSBDY5T<a
YY.A21PN;2MMJ9724Q\cCO<>N7S^ASGT^L,#Mg-C^OK:9_J4[D92JGJGVNfM5?V7
@AV0>T>OJ#g#6U3H,3.PTM[Rd?b2g[#PNU>gFX[VQ)LR;=d+A7;dX8V(96[:=;O3
bPKDdR6.ZF#3]J#.Ra(cE,<XT>-<A5V0K_2WB/C1SNeUPH(NbF3#LLOB8#AE\G)C
GZ@a9?S5):?A9^+_7\_3IB+I\^KX@&E6/#2+L1@S?5[aH8_<0a?URgW?W/c[H-A)
K::[:UZfWCE=/Zg#SN-U&cKJA82MJ[Y1&]=8^I(V+<Yf7[,UEN[X[0c.Ad)LL60Y
+[:]Q3L+db;R1_D@Mf>CUR35fMJNM7-FY9:9@-d/4E8;+Z^P:@c1b1056R7X5A9,
O[B<e)A2,?4CR6_UCV3,3CAM.\gb]>1P[=Vaf#Q.=g5?N-I-8aL_5b&bX0_)RT9?
K/VFHM\8.J7Z3G9XFM(LFO//LUb/?BMNUC]->Od63VPCV<ZWOAC&,D:+VF+NI^_4
b=UOF(]cMgDAZ3YcY(9EUDgQ^80>YQ^#<MR<3-b^SAX,fMB8@F:&Q:fSf?F7UWZC
>&^+:RObF90-Y@Z[?KXI.L.MQV013F8<^/,1]\0.2c+MB#DIX1S&9-TU^Ef9\50/
M3DB)FXK3IFe7X@Zg3TE_U7RP,?X9:93^e,gSeH<U&E:0g>@EMJV>a1M@0U.9P@8
IVR.U,2.###E897<82cDUPCWN:QKM.aEZYae0>X<=BQIVHT@@?T9>PU16MPJX23J
J]e=Z@g?/D6T:ad^DB94Zaa-Zd0OW[Wd-U41&I]eJHJ]Ie^ELZQVKD-_=4-58_G:
]R?fL87Y+8AfcUL5T1GBC7^5f2Sa.\6R:[O<c^N#8\O[)H[EgU\_MRM6@aJ#FN=/
9\2Y#6]+<eXgU&2NQGN8N3cW?\R2P,M:[]0X)<#>>KH<cZ3Pe.UX)J4.8.5\Ye(Y
B3JIDUH,Rg)BO3,UE11+\Xg8HXK\g?HC4Q[XFJ:3f>K.05B>CMK5dgLbIU\a&Q.[
?#;@I?EKWaA?McT5VXT_?JH5+JW08.=?WY(bEa-YQ8-.VRGJK\6(:7PU,6I.YgaU
#RSP/eXc,(TcZ/7L<BPe>><-(@V(?R)J>BV=T?FJ6[@054EZAeZF^ATM/+=@:A#L
/;OUH.fQYN,9B.X;75YHCT6-8<=]YX[#6=Fa&?RbAPS7f^@FK<fH-c.:c/D6)2W0
8-ZY436997YKeD9\YU[8Ld5DLZM0&@24WZd6XB0Ig-(_d.-]4O_8]d.,TfB=B1HP
7BA,QLCG.XF:+A>a_2ICR0QZ+6cKD3,1;TQ9bAc\eN1e0e?M\&LfG-ZVJ5?>[UB;
_gWLS-U325,W_H4b6aZ38JY@I68#)^HT-bO-F9WK#0D5HQU:9V.b63CGBPK#cY6c
<M5.D]6V;UG0-,G;JX&f@.e>4L23F<-#PCJ>Y7LK7#2#=L7S[;MJ>SggPN3:90W@
+?>O:C^-7.0:aF_ERT9e)LFgNg7>F=-G@V9VP5(F@a?VN_ZJGP/B3MB6;dJ>>KVY
P=R\YW3CQ+NX3BIRf<WA3]0b<LH<G372Y-L\a<@YT&?P)dB;/dg)).6d5LA)a/,3
H5FQQ3>&<+&;\6@G^,3S3Zed(bF_Hg1EX:GcTNHZa9g8OMI071+Q3c)+\BA/L2N&
BNVG9G2^YG/L/8E(d)_Y9/TV25S+^KC9Ia:DRVK;1]eF[SPQ7/85SS^1ZWDNde9_
.\628DU7#S,5UXf2?MGg?4(B^^(Nc(JOA?5.OIcDP0+gE45F.;MZ#TULTHZXUbTM
LS]W#Q7)aeDH^]QK.:UWR^fa#]K;&,U[\[JK9,=AU7H;WF=\WN//9AX3R>Re4]QM
bINDXgc]W^]V/JWA7:b6e/2g),0:_T3NTF#8?S9K5?:6(Q86>T:Aa9M,6B2ZQ4EI
P(2;(@RRcWQ(NIWM+ECd-#,6ZXMYdE318V024YQ3E#L3c9LF5[,KI>5Y[GKKgZLX
=XQ/&1-\Ic01X6edcN/DK-cHO:M-a@Y9@I>&;3428SOORNWd1^<;YH_8d)F7;)>:
AA6-:]-W/NZK6/YI3/AN)[F+GQ1^NedL@]ET^6)T/L\Je1;<D9<=Q3D2W3;:2Haa
V&&P9eBU.;2;D+:<Z.6X)]::HAY/AGLVQ>eAJ)\f]VIMc.[/2+Q>fEIgc[T_A+e#
C<Jf>g.OC@=d:E)^TT+L2c3R-e.VF<6E\A>>G0S(P1dY\-:LR)9/:1<ON92]V/F7
.;_Z9Y,/#?:J1^FFPcQ[X/S?Q]>&#cBPb67N13<>gf;RU5MG@YX8>.WNF\7C[DK]
)31b^5XCQ5F+P7N7?(YP51DU32bR;X\Qd/^?\7SX9I,:0)Ze8\I84b]/^FSeH)da
e#L(W9.#,XUF+1^E_K-^6808JQ1,W<@^_R1_dE4D,8B:gR:O493fTT.BE,:-6Y6X
SA^<\0CNWfRRMOLA:Zf,F].4TWY&^\\)KS_fY&80SbHJb[F11WN^I8bU<Ba2.IVc
HGZ.J]Z:?SQ,W^;a>T@dI^b#KRK<0a4]JFHBVGX.Bg=e27DBfRfc@IcOX,=<&1S-
eM6EPT_7RCYY6T.Jg+Y@@3c4?[V(0Z4/O=dfR(IU)?\,+BED=gLBH?O/W[A@fSM3
8.^_/8RbN=+TZVGe_@3#PQ4_^<V45Q;ebK:]Xg?DSSRBU4\b:R4\0/Ac?dU[fHA&
O>GI=LfX+Dd&236R,=AaN3RP#S-J^_aX29d^Z9EFZXV,6/eE51US(TH@IA^_)Gc6
0HCMG48Z-9WSf0[]X/Pe6YXW-85(ga6,;fYD2L=4=,Q-O_>cUQ.,>X^UFQT,fMEg
_D1XM4>bQOg&X#2@-acS/T&N7?_3KE@\SP/Lg?gPNP8Z-(3<;Q>d92\NC9RW+PZg
8RR).^?M5LG>-EeMa-aK:XcV#[;,&8FWM-UBP@8EO#5ONe).NLE@1)4V)LHeMgD_
g-VT=c4b+eg2TLHVFe(##M[7=&L-F::)V,JWK]UW0>.F:TZ7<:=Fe5Y>\7E/5:W]
O@=8_;S8JBU+ODY]N>B)bg#_KHG=]?]IK>b1<cR:d,beWA7G<M_/<#a449(8@eXC
T.MdKKV]PJN6R^[I/=[UdM5Ne>8@,8d<H+I0Me3XFPDF:R;dF_M<CR]Id]HXfcP.
Z8Hgbg(Q+&cP?D)9?R9]@GTg1.3BOY^3O>=UCK08MU0?-CPaO@C0MC^=EQ;[K-^=
W;:W[1=^3(>W+DLCA7^@^-Ka_/B7]XIAf0&##FA_I:^53bGD>ZG.LO2+.@<7^[fT
.:[7V40P>eLW=P0FP-=FcN;bLLJ9f/<2cZP;#K\\I-f3>7-_=GY9+)QF#_;&];R4
5^3H3IA?=IR4;dVRbJF,_:PP77@A-VD3HcG?V#1g#PQK\M0W1&XD=GMGS#8_I)EO
-XGRO79AA,#EOW6>W)_[GU<0SEZ>L&PE=58ZLE.RUabWEPRf8OJRT/^CVRe\Wc)Z
O.IC-8N/,Ke?7Y6?GZ=0&+-2MV=;BU-_+EBP<3fef<,;^J;N-@3:9=);<U2g4IM#
Y)ee@BKK)&U_<X<KJ]/-@.Y40gZ<YWQ]HKfO@9GN<++8<]W:G71=g8?M=?,S1dCb
KU&3DFA7^6;8]PE>C,,a:G/+B@3RefC-^BN@TYRH@_\<RX/??Nf+BQCS<A<E\.J#
)cW-A?=GK?\<6]K.X1d0XR0-cD?3H/++PH-D0:Q73dB[CC:?ee?aaY\;2DeDe>WK
48<[HU#\+D:5_JSFWT+4RU.CVU8a1:)DL8NaH.65bIcC(R,6/OCR5N/&)1L84O8^
OC-+ZNf^.=/T<MSKa-4+2a:<&g(=;da=#0:cE=^:W9d68-T[>AC+G&2-g1_S>;Y2
)76=]QVQ8Bg6R:&DPVR\-IL[28@&<Dd<Q1;O\d)(^8Z=,IKL1UDRN.FMNXEGSg<?
7;G)R;.ZKM>bYW8LHV7S@8]aQb@2WRPMWeSbC#F=\#>5[Y7BV0I]1Z&/T-?Bb\g0
&bJ\CPMC)Y-UFD2F/RRD+Q.E4SPU>8ZA5RW>K94F8B<EC6]Y=3/c>dPfG\K/4/<I
YI\+L4.LU?R,_>>F-aGD^)@?G#:eAPSPNJ(EDB0QEgH1\7.@Y+[12[a^BR4-J+;L
VM:.P3Z[W\.\ad8E<=^EFdQ3#1A_.4M&4ENRbMFb=c\c#eV:;H11ZM1,2=6OF5_Z
ZL\,CZJ\T3\fRQY1I4e<_]20JX:&9>JI10C,Kc?/?TBRC2a8HR@SK[M/Fe,F[(c+
A_A1(W84TD#E6NM\Y4.ILW0,2?GS+6[a10>c\STI?;cfbKI9KUPVBc\ZWE[XT>#f
T4HP_d8Ya[:YPBN&Ja=gffDQ7GOV\U1,PXBdf\Ta11G1KE?ZY+M.VG7@]C/=Z<0X
6XZJ>:(faFNOXQ/eM>^H97::AN/\UAOV.\1>=PXUL-4VUb8PMaK&f(8[MEO:]E.V
IX>.-f4M7\WEK&T(7,,85T6WE9DG/[5S.EBW7b2\gUBMV^XG\BG?HK>Bc_=,A:V<
[(XSVA.P[=750JMBeA_cQRLK6QTdT+0M;[?#bVO7g\=3AW\KLYa/g8O#IFUb..VZ
5B8[(P6=OZe1JbL=+<7[adI;;eK92EJNffH(:_>6[H8)3V(HQ:[,AO+cZRZ/O<Ad
?ZLGSUbH)A<8A6;RP7U&YeR1;PIRb>]+9@>A97_&<KK/2Fe#-_\YNH,C(b:252Xd
(R7g:a#O4Z,HZRJ4gB9A+Vbd538GSBWB9+Y,-)abX,<Dgb+WRYg[V+cPCNCKY1/6
ZUQ>(7#2X\IOKg.7&GW?5(.JZ(][1M5Y4\>=-A.9b\G@KU+EX;?#:(@(FcBU-VVU
91Ff66]5,I595:-NSXMU;+gLH,__HUV.J+8]NLFL;;4XM\\G?7?^>U,V1c\eA:g#
=f:5+/ER1JL3af/G=>TX3e=+878>E&dH_R=R#.2(#J_DbH.7.S5b8c;[8S2,DQ_,
66&-OR4((UcQ>A^HQFJ[KcNOf-LLZ7Z;1KCL<K3MfWb)S,/Va\P--_bbC]ZWSUN@
O<^W-/Mc\0G^+9bfU3gMG^XZZW=#QTXP-84V38dWXRb6EG\C5g(K+C)UJ.>2XaRd
G[V.MbGL=.1,ReZA#XPRD/FbSPK84H&AR(C#Lde=/QW#>Z_>3H=<V,A:L==V@<X?
K.CNN)O>^d?ID-VPR&VF.[c5,?ZS08@D?SQ(&>TgP4EX8EH.^Ef4fAMCe=dPG-+\
YQ[9.,N^1C46>a08JLS_@N5^Z;?7g[UR>>)BL6:C7WS2I]XcO60RQ([e5ABGN-\\
&?Q@]>R\6aC=7#Z\:YW1C\LA8/HZ?K(603R@M.TW6MCTKI^36e93(F13Z?X9N.fc
gD#a#AFe;YA3QX=fUgGU2]H-L2U@QFZJ4NHYX@R[VEW+(2@/&G=g9LLMCR9Y7A)@
1;_A@?4]#Ffe1#X[(?bCLdc9^[B@cOUa;G&f_<b&\^T(,eQ3_^)YVaTaa2&MbB3Z
#082#>.LC<5K#IV9@M^V.Ze7g5+>]I0M>eBXF_.0(eK2N?TL,E1HO.YVfCR^E7P\
[\MW7A786g^LXTbTNV2dG^5RL/+\4BSDXFC8FXI2K_1FYP+:JdYA1Q<[4edQJ^AK
c_TeM#CQV)AE;OfT](,]\/D8a237H<1=OU\/KY2_HB4=_ZeA<1S/Zd<U.McPVRB+
VV&9.U.LcQ?BF&B\&@1[W:@L+<7AgF#:#^^RW(IbeHC0T5M5U)SYd.?^cKNe2B\2
;D,G,;)##cXH9#W:=;F/)NeQbe0SY>YJ0OIT_^W=9JTdB=UTd#NUWN]6AAU@]e@^
KY-[L<aZgX6-E?HfT\aPfI7QALWJ)0W?8;AQ/(O&7[c_W.4F6)11J\:#5FQ4ZXCW
)>2);ILD-JLPB1[)g-PHe-_;,<-A4a#4/>X93W?cf5LI)6F]GB;.@T#N2b-9<:Eb
1b<&CVBB1W>F6KA;^7aBJ>OaT8_PR_./N-6N#[I52FI5(cEW)I)c-H>cM0M6dCJ5
Y,f)XdB8LbFLR9NLGDf@#SWc;G;)ZW5[E-LDL1N\CfKOWT=L4&34EgEbJB=97Re4
#^aI76b&)J=)=X=M6;Zd.G/3[7]cS37PbWAcXU+/f(WPfBGMZ>U[Q2E)/UR3)^NO
+1T>FKDIId\b1K7d>M\EDC_LcN)JB;=/D?7N=5Y47fZcH&#5K(<OZLQ(HV]1YJ(2
[e^Wg[]<L3>RS.)-Ed3E##1FgWgg&DBAVd-)c)1APMJgg_Y+@+ENAX0;:BC,2KRB
7d&f&I[<e)03R,K\,4IeIXUJfZ=3O^E>:KCF(=+f[,g.1cJe\+0A3_:g_b^_X5eJ
ba4JS5K+M>IYQf>T50XNQ+b&\>gM2SCMC\d;BE5_G<:HLcZNfGBG<]\PR?Z&4-I+
0U1=cI^EaKN=-4;KC5a>a3^GX-LL8G++bGR#RFbRXe]c(EX9L)2D&g1(2:7D4Ob-
/B1N.;b/][-O9]/fOZ\]b>Ub<]@FBb0H?K/f]E?caLfaJIMa?1_Z1N(\OO-?BX3P
6.AaG<T7YR:2Z#;BUCT1CAT9G2V7VdK[(>ZY_);M=6&AF-=(SDL6BG8V92T+_4^+
&a&PPYD@DUU+/6V1ER7<XPVH+AY+0AcB=\b=RZX;.2=Xd\K99[/?\/Q@41#T;3^0
gH.U/cO0<Tfg/+=F#9WIJ3M)E4T&ca\JEc&Wa)CeHTAd1<&82;1[FCW+ST]B9PLU
Z>ZJUOAJT=^^NW_RYd1QcR.YFT2(\ff@535\20BSC#B:EQ;C45,8Z]LY\SaZ[S<-
A5(Fe+T=Fa;Se3b.cN@/K@Ea>cFBg):b1Kg/>MX[#D9S06dGaYX3[LJf.Y=,-)P[
X6JA3Df(]TgJTSZ]YKaV5^LX:RdIGFX3+\AAEcWH\E6:efRe5/K6DZU0D2Ubg?2C
0OY2Z:)+I@OVc+Ie[,4WMO5(&=FRaB7RB4NM1PED.(LZgRd];GJB6[6gc)B^aT^a
<Y>YX_NAS]SFZ#M8A[W(L>W))01T07:RL3[aK=_fS/Rd&)\_79US#D;LUW[,b7d?
4eQ:<ac-7XS@[_#fW3NCdT^;[JAMLf70.Re)10GN9?25(PA8.GO4&50:+#A\KVg.
McO84P<^5,U&,_X&eP=N&^X-S\_\@Kb[OR=_Y;,/C=M23)&80BWO9bM7)V#H0T>&
Hd/N?B@J^\gPbI,UKJLL<9KcH3Xfe-)=>bVE4>d2eVM1FT.K;_dMEKTZg97M+_2(
/]fe#G8/(TTF)K/-02O)f/fK248+6&Rg\46Y9^EU<;+><+Daa.D&KaDA7)II-4f^
=b4KB>98EZ7D0<]+6E1XC2H\E):=IW1^?UX#&/Vb:T?BZ&:JFCB[LG4)fCb62BBN
\O9LI\@\e@G4]&,:Q,NSSK5:G<3#I(;Y\C:2RL2+X]1^+5]JeHc5+E7;2\TBSQJK
cZJVOZ#g8B@?S>)3<=@(SPaA4(QJIHQ<]U2TW[=3IgIS?S+([A;H:Q.a/IU0YAHJ
/[H2OLS@bQBCJU(D@TTC(^A#cTH<dG;]A+#T4CcFfYQ:_R8g&H(>E:EaRH;(J9b^
\MNcK3V@#LW)<7U3@e(aeeX_\UFZ2YEY,B+WD<8#&a@G7X_;7Sf?)(Yg(:^,3RK4
@T0GGNU++>5?,0^DfK4^WbEeJ+1ffY^FY:3#?1EECUL]d.E0_4Z@bOdJ/H=E>KSP
[F\g-Y)V]8]+H7fRBG#T01-3K/+448?VUN99871?H\E<<MgL(;HV^OS4R\,(+M/N
VX86#IgcA##/UC0WV&d>+G+2a12[aD=KHXE&]+(XC6b_,c4OXc2W:MH:C.b>Lg@?
^UV)SXKf^(/YZZ,[U:&HJKe/eL,^gP5WHe+\fA_B,Gb=@I/[J\0::PIPITSK+>fF
PX9<<.C(50>2?:+:V=K?JPR3K68]T->&6^?/9DP;2f;6@(&][8U7;(BcJ?e-GV8J
/F/^@,9HX^G.#d;?]KJadW_6J/D/)FA(^g?8,-UL^9a.4_V(I@L/@0UM<WPAM/YI
L2,A@KZ(_bD/9)MI/)LC8N]XeNN4F2R@QE3JXE-Mc5d(<KC:b:#A=PTfKB-24@.1
:.Dgd;);8gTNTY=I8#0)R4N0P,[1/+G8S\A=#:M&KL:>C[GEa634&#LI.:W)@,5U
Z7dDDK?+8a8+2NUUD/+SN#E\H4+:AUM9Lg)^]=LFS8UPZS/S7^9P,&0Ab2@D6WEN
D_QZ=W.&+U.03I]Bb5G^QND@JO_fV/?N-S?6::d-]6.;KAOJ=D^34+&L3J<>,N4^
6I=7eW+@CQTZ(gPQ.?9g95R@,H;Ub84J&PAbPS9OKIM<2XF5,E):Kf-KZ,NKdM1,
\V:U:@K>Nd0NB6B1G<Q4d,VGZ64&KXT)Lb0Q-F3(PdcQ:CY5+[KX1HPR,IZL.YgF
U?Z[Ud6I,+F<4WZL_I>^]^T:2U7;[cFg_=PgV?WU4V9,OKUIO1cLZQC=&/9_6V-9
BRceBM<SP/:-9AWABU#?c>O)?IaRR4P7;?S\=KG7G.PR3N.Of=a[F-/Z:W:)UCaV
I5?6L^[[3Pf[IX]Nd_280ROd+GM++H<79_#LX3cb7A#.KgVbaI_?d]M\Fd0)Y7&]
SV\B656IT[U].A:c,2>=34gJO7\Xe/7ZfI?,[aS\0)0JYUBR7#-D/E).5>(W/LHg
OVHU//T;DE,U@6dSAG5Q_7OG_Q\)b;dd<_HD;A-0Q&dZ\ef6Pc7;@(JeB4d)CJfE
cBQeY+g+.eZaIGJ3=84-4MRf8A@94E-@\8VUEEcb92=dK>4gSc5[,-.U4,M4N[UL
N,f,633ZOPg48VD34(P<V,^2ggb&b6OFP52>(@):EZP@<NI8T#<U1#I1Z.T1+e);
I1eAX]6WY^G59;9gG]H94?CX?.U:>@CIb)Kf+6(b;eS;5Y47#&3e:DKCeZ60_SI3
7<Ve3F79K2\FdK^M5Qc1BeLSfFLX+PgX&IaQSgG)Z_C2=QF^H]Ab7b.J8Q:M?8U/
WBH@/@([=W-<T5.+dCKT;LOIV)#g:8A;6+aU]\;A/a6)5SIg:^JER\T;[aKb?OP2
X>J^>Q0:L(Vd9H-b2U>^PLI(8L3VEcD?Ed[9R4)J,-cPV5.[ZOaVcM6g6CXO<B7T
ZKC_<#+(7^\-e67_DG^f0(P6D;#FQf+1,0>\D,(<U)7+DOL-I#-]ff>-TA]31.#7
\TD)8[/d34def6e,90d;E<M+b]a>_PVJ?A-gD+48_+59D&cIg\GBAfHQ)QHS4I?9
0N,;IE#]4:PEfdQ4T+GY..(aOSb_e60HU8RM)F=F\gNZHQd/FH5[F2#?DIcA+NQ8
&aWXed:aX#\-FCf0RaUbbc;>594XI=3\6\GQWaI/d8>?G-@HePFAeC)E@,,e+3+:
ROS9>LD0RT@TZf@[[)JgDHK=\4aN;D(+&TC&SMD7,T,L5=628JXOZS6Kd@ZC3b=?
?=ZdK6@73>.#R=MWb7T#]Z@5c].O,_[b,L5=)gV(_H).XJcZB7E@g2JI8=]FBN&:
,NO8>(:G/+IDKT+V8(L_:b<Rc#=S1EN/A[AYZ^_EdX;^V6++K/UY;2]>-aa2=4SE
&Wa3??YdJc74P;eVRM:EOY8]V17TAZTEFYb:WW5ZdN8XBAF\9(_JM@\DK2?,1KX@
0[6.+-(K(^;90^XS087+1?_CcB_@_98N]5((,QE5A/eT27/YL50DG=B;9PJ[/I#f
4DPe[J=GUA8E/=_0^[GMV:N_KJJ<VGCMX011K:.MO#dO3]bD4]bdCCC4^<FW]?FJ
^:?3dD8Uf[U?E+@4c^OVF?]<f^_1T&^+OH8NC/V54ZJ(g8A4+T^c_KT0\=F7.:3]
8W-+H0UWWA6CbAJb,/6J_eC#?([X4(YNF+=4PcL1.e:Q7F]_f1TRH6=a4+/0,J8,
;M2VbL0g\BA?_Lg.@8LV\OW<RB?7MTX?JTC6c7G8D.<^E1<S/M9S\,Q#\6MB-3^U
\,ZMgJS=5=AQ1&#&-@\aU9#/\:K/V-._A4L>0+W,OW@H1=-(d9\14U40Xg\;AVX7
9gfI-8G44?C^PT0<HY,bg[P1ZOOVS1&#20.3<ZdN,OY#8U]FF^+e(NfL8<U&b4S5
1b\M_XZf34X>L\0/Qc4_RY3cK/I>W@K@d<6QY_3C<XUUDCHGQN&,T78:Nc8OA\:[
-&OKSEF>A<e@=TZ#&QYIQOF#0K><;#_;RK],?:,gQ]AHH@2=V)SRagJS[E7^TMM+
V-LQ[A/WCg[(92[G4-L?:?Z(]N?\9AX.Y]YfOOGK6EA=Oc75eAFZbg4.GJDU;-[Z
,+#M.#:g=]dS6bL/L[OX_XbFaB^JgTbdG6e\N8-P9f\0\aV8]RJ&O8[geT(V^ZYC
D.PHJbD?b+<YMKQ5XZ0dIRce0W9M]4^RI=AGHKB+VEJ>,X7:dJ8cL\>7_R,I6W7V
N[W5^I?Ce.[TL,D.&d-O<151IIGa+\D/8aJIDT-F9L339KUECW:ITa4EE2=[&J^U
#Oc#+YVVK?Q_H+,@#Ff=FX[26Q>)7LE[7fYNOV-DG^,7g-__\P)E+&,K-ZA?=UJ?
;51G&Y7)\b9DPX8?WD8.98EC;HQO:?dOP;VbW6Z-NM.U1<A8_H.K(:FZ:0185.c:
-_Ib9C0V2b6MeLVW-ZGL1R]DX.O)7H[H=5=RO4M0Y_UM-O@/g4Y7MSAT=FVC1S;O
3&Z,BL-Q2gQJ1\7^T/46)_=\BTD/LWWT[O__5Xb+K[7M>?0E=8MH9V\,)C3:=+Z:
&-_J_afe1J^Z60Q^U&N2]3F\1Y03FX[5YKcf228X)4O:Y7c+B@gPGNdN:,F,ba;W
[PV-O:BCQY70R=9U)O\5#(Y)7MRL/.U/C^H3RV9ACa=G7-;0V)T7SAVRN(2)XUF2
\EQaG9=>5WE9&eK@^7#C.V>)OMZEA2^SfCILMJ:Wd^(W2Cb860<]5PbL)W^T]B(S
PaBA2<VKU6HU9HU444)+Qb[O0HFH7S470E#^AL<3:RU3aGTNX41)JSS.C=gb557W
RHE^_SCA-faS8UBP^B3#RNEa?I0)N5_;CLYbP<=7XXb>B,5]AKV9Y[?aWAY)f4K_
,ITdO25;aPN:<Y9g4e7>Fc5(c\0J>LEPKKe2d3dULP_c4)AgL\d;9-KCBYG@S0)3
R)/TKK8-dR-0a<UBTIA3<5Y,:)<TKZPee[TO5^bAD8I1]X0-Lc\S3,4(-:00&Z_F
MP.1Cd.24I;.856HB3@\c>b8\=c1\BeA@7QcL&PKPYA=OQC8(eJ-<<^@L/8^)5SC
]^_Cg+HANZF#LMN8[@)27(AF;ge.FWb&=?_W7?C]/TSO\99IXS--0]0;BDUFJW0c
GW[,85@F+#RV3_:RBWJ/09YK/aP9HG^6W,IfHGE-adICCH&LY.@,O3#12HKKSPT(
A<6)5\.]P60@XOYS#/:AL1+9K0OG^OSbcUL61BfCY,7)1C_V<@DDB;IQ8>6]].>[
1P[::O)DEJGV4N#W;)#WN^V+Z>50_KIFU:O(..AKS,QCO&NHQ9,=\^W3DJPc9Z^W
.00SY8\]XCN(2d?KgX.f69N+X<XKO6g^NMVM?.QT80Nd(4f:?V<YT7?\MYK^@(V:
+gBL&>LY::T\J[M;9T7e.bF=3b9c^^a1fK/=[aCQXJSIP3ADFDHFVQa8AM;\V+GB
^7-e,0.2IXg[\R]YJMgME<3YN;Z<]U]BNg+LMI=6QH7dE=^OAe2;\2-OTC888/W?
_-fQ-]1a0UNUNJ<gabSS^&H(g(DUU<[bX+@=_=,_1P]93SH#I/YYNUDcOa^C)#R4
TY-ZB^DHWFbLD8MgR)2.NX&gI#]Q4)f9LS4N<[YDZWW1S;PHK)@)24Rbd\1_GW>^
C1^c[HEN@.-J5+LSEH_Ec+;;R_W2N/J0PV<QM?1O]MHLVM7,ADGbPP(G-?QUaCZF
WNAZ:aY>8Q5b[YD#O808&Xd\^?S/e_+L3&8a#aLdN4AERHCT##e8O[c/f:U=>f1H
d;;<gP8-CeV8W\5+?)VACM.fb;RdeeL(7cQ=4:We\U;U^X,6#3(D17ENB0^KC]M=
?=F&)[U&[Y.[\d11WffQ-Z&QK#^C.a4d.e>(XKSMZ=N9eY)7.98gUM@?MDS:Rf;R
5:-RY9XB.S6QE4D<;cOB3P;6Y;RV.UJXZTKLfCDZUH79>_I6Tc9?[b513K6.RfW_
/.FEg_7b.N[2Xc>X^ZC=)YYc+C-T:Y:\F2HK>KP^SP&bf\_ZX#Y.8HV\T8b)OIXg
/R6a=a5gL:[KMR4#WBR^;1<B&X7M;?FY]D#GLGS7X8deU(K)1)?Z7@0^5[<bbO/[
_FX4K2BPd-BEKg#K<@B+fW0=Q;8:72e&?Y4JB;bTS,,]B0FB@@)D)LF6RJPDb6M9
_?HNDOcA,KJ)5APQY?A60):D4Uaf52\G(2>aC1J3BA-AB>aG(c),gc66(UBY@3f0
56>g;[2X/2H#e?e]W\?45Z@RP[\MP8L[&gH6MYa:Me7[WTfaKU(8_^UE^BP)H1&O
#\bb6K?2gNBbG-379Ob3K&G5LD1bQ#O7-AE2]S/20:ACFJ-8YM5A/e>/FMI;BIY#
><-U@EO;IJNgf?)B8CF06fU\X]S4&W[<f-dYaJW7\^D<)Z#cd.J1<3PWJ91\g9#D
O4.c9cf7#dId_(+5[fLT;UQ[+-8@P)MS,DZS^5W<#UbN(KScRCV5SAU,M;M]WRTf
O_L+6<6HZc;aPQ/W04B^BU5F/CVZ85.2Z3+Qf/N#MDe.\/I:<7)-<R>W,I[?@bVQ
>878H@LN31W3HJXD.-Nag#b2LM2OMZ^?dH-V8[Y3SY+?c^FS8SSV_@eP3+Nd4_c#
eDCUb=2=K[AVFa,QHW?LB>OZHA#?7S4[B5MBQ>._:#bcO32WS@X/7I/4.DaWJRc2
N6X5>ED+e21078(<8DP?,8(9K,bfJOeAC/CfUUQ9LeH0K;<+^BC\V/)X##4:>O?/
1EYF4a>79:/M#?^A?cU76WQYN:KR0&E+W\KTaL4/ZD(UE4)(IJ==(R)?KMf\9D1J
a./bE@DS=S9aK++c>M;NBWD&>,b&UW_N-TIGDUD1L4\.F?)7&5T+NZc9I-fSaM^P
bSb2@a92OM4+T>KP1^bYaWK1OQIPe3fgS,e[?3bXY<KHYPU20>8XA?&(gD:=E>H5
+@U8)L-M377c3M;6F\[;[e3ZER6e:6(GRZ@ZPfcfaf#@d>X:g^Nd)N9A1<K#XY0/
bF:5+b9e(:<f6A^(U?V,;d_6d#Jg7#KcAZEW:,=)f4NcK#Z#M6LD9^c^V,28JKf,
HLbE?Ec;B@#f5bI+IM,3)]<C-,F]LO36\>3G/7g3+Mbf1#6U_B/9]=_gB>:,c_Z6
GA>3.[W()-(/++=B?O3?deLV92V[=+>P?\,IK2e90F5&I1#PAfG+ePGN)GE#6cgM
K0PQ-T;^V\#.M@JQ+32KZ(AA)^9Uc0>:[,2aV,.O>DSg4NZ876EId[Ef@)b+\Y=O
4/[@>^M^+8eI7#BL<W/1711T[)S(7WA>@B5VA[g96aSLH.B+P+TFJ@JK1TIfYABY
d=>25+U,M#Q&^USF36C,dJ>/D5968A3_7/O?Hf<PJI-^YDb(ARcO\VDJ1&[XLQSM
B7SNH5_E[Ia:,d--1Z15@cE[bbRLV0Dc&bB[K7T//-L;>GRM:1OP/JSP:^L>D[/\
;GQb.+6UG+N(NQg?+W0D<PAeB&TX,dP]H@O#T]=,OCEf(Kg^M[2g4_>_>#>?c<Q?
]Db)7EDX(E>1(HO0@&GHd,0_g9D=A698bW88O-@NKYZOb.b^@&3_d3R.9H+O2a-2
gaIAJ=gX>_6LMZW4U3IW8dOH.7fJPb^T3I0(Jc1Z16D#P-B[K#_8-&0,OQVaW72H
-+3N4XIZR6c43X[C:Pd78Qa?J4d[.V=D_JF@-I>)..MO<LTP3KdMW,2CI(.8UF.5
GJ-.5J[HY::H)\-8E5AYL9EHIB+/>C^I-U2I9[FJX(F^&8CeIP?TYKU=(C8c8U]9
J]<If5E].DCa:eZH?,-0HGU)Hb(d30C2^^FKBA1?V:?+RXP3;9J2C-2SYM?-Yf@M
6[b<W\:IffBXG2Z+6W4@H)1S7UNH4-L#9#<WV7=LA0]-]J3=:JaN6a9Oa,#QQ3J=
QQRL56M-]-\W[\C8<+SQ/ZV(;0e,dLJ;V?[K0g&(7^4cDT&Dg_AY:H+V0R9Nfc\a
^0cK^VT26UNLEHL02^M&4BGg.U::I.=BV/4#]^O14R\>&PMFc^^]MOC:Y_:cX.=:
0U2b6E_b</UMI^/(<S)]&\Ic.5/<QB1QY[N??SMV[529L7-2>D(8OC+G4Y.5(I4&
U1I/>Q,;7OU&4YK#a[Qc4R-M:D9(cCY)Z(&T;#3;S>/EWB,9Cf-)]=8dHd]SIeUg
UJX?D)_Z>PWT[/6&1;&.3[.T0KP-#ZWY[I.f36I<=7[bOf+E([//Z\0=<)BePWTX
/XXS=dQd\bCWg:B@7Qd_,B>K\Z/1R#aPLJ:V_2\Q9I/83I>--@J_D4GRTa<GP1(U
^TJ9MT6XP[A.f6\5J<J;D5XLR6ST0\?88<a_\5S/-f(F?\6V_KKV4g[RAKOfJ2J\
)dJ1SK@]E&&FVdQ4I[S^TFg4YK]</;NTH_&E+4S^;T@?6VeT=C8\29a2e3AP3a8E
fUdgRO0Gb,bY&Z<PHWP\\?2<ULMa)RDEfM>e]dL<[>eg<N[Q,0O6.5ceVM2Td2T+
4NRX\8:(,:_1EJ@\[L5#@cGHVBa>;Z8&dUadJc-BM\->aB<A]U4@?+0TI.e[))58
_+#DGRZeF:/L/J>-0Z4)QeY.7+TNCE=?^B?dcJgTJ4[U0SG3bc-RYOQaB_I#CRNf
+<YaXA[T=;;dT7e&&(B)MU]K^686;MOM].9G6eXPVHM#<7H<6Qe48DV/F5K[76a]
5-K9@<eQHO6C(@@IDVSbRcP&gP7+[I2fP.#d6N3W-UBJ;CLWdcd,,BZ:b,)]_SRG
/=9P[=9(C/QWDC+Y33([e]:D35]1&P\4PN<HHWID&]6K=Dc992VA3K@#b6/1,1EH
4W[\Z;(R=GGH+E?[-0Za.:4[_A=&7df]QVXNKV@C@7b].N@6P6E=D2Z.BaPP2cKd
1ESO2S#TQPf?=eM[G/EIGPdORe>,PBB-<\?=>]H<Sc-[R3PPRZY@^d1YDe#gA/DH
<b-IFV4O/\eIAOU@#fV8dHcG.f8-1P0AE5ZBF2Xe0M^,F_\F\H>IM9de6dO,A#U&
c<8XG=S-BO=4Y2YU7b1.@&]\K3LBT)&+BL2Y;QO]ED;>0QD\\4SF[Zg[>?7=K?\>
UHAIgC>QS61f4cV#P/@INc5+ca9]B?9Q^/+@FXBTVBX;4DeK)4TBCZAE\HfeP[TD
L4C,4&PIEfRJNUTfMC#-a2,.P_+.T(UN(9]Ud5SbR@Qc^aa[+&16>P9-UZ(QJU\Y
]K0d)A[<&(7Re3]8\6:@GKFA;]F=.?b9S.d7#;;PdD931De/Z7[NL,\.b.QG,XTU
2>]DgfQH(d46fF&Y0Y\a)/;7X^H__c[D[J?XAa.7MGBIb,L)c/R]K^.g/2\]M8OS
f>((gOe0&66O&P:^83^)Y4bO;SU<N[@G5ALB)8[]8.35>MPWTEY:_bQU[R>17SUV
ZQ2I3]_f]^4VN#0+E;[&[[NM^cEe:8#UW:9=H@/;4UCA:cH^L:]C]T4B=RZ:SO8+
QS]f+(6+Ag>Y.2:K2R:@(&[^:[?L20/J\Y#&V>LJ#SFRX\PSKX3T8T#d4]?O&JD7
_SX2))VU00.d<\8c=,Ud?1dNQWAAf606;I(3T=&;@3-JD:M<[gC2MIb:[;;1<2:?
.Ea<6._FAX6aZ1-?X,gW=7O/TF/QQ\8=&,^]Z-\PQH8P,<<CISS_OWH34gb4LXP)
HPgMATR@(U)^#1f;<b_5JO=^7M&(HNRUe3NL9#HdYCWXGdXBF?WV6+EK=ID?g/4@
=0WBG4bEEJXcD@gK8V_;[80S,6W#9N>AVN(VOZ:&CcQ@9GNXb^DT,:L2J&@fg#F<
fTNLQGUQ@ZC)9;N7M2LQEV9aC1Sc[FJ9CP?&I#@(^8K,5eE^_LNWDaNCG52Aa+JW
9U<4,ef@9G50dJaB8Ta2M6\_ac,^_S5GC>FgY,)324.1:)[>R>S/F;OA/LVJ1;G5
Qe\CVD_e1E&Ne<gAeeVI3OC9VCT9fTI,U^]P_&I:gJ;0_NfdT[)T:4H;]244f-@1
gX;(\d6P13YT3Z\Z,MZBV3UPWdHaD-9FdN3MHaPP<@HM3<9=+G7YN+K&:]Y]3/\J
/,0T,O((D3;1YBB[[0d.:H9SO?&5(8&Z[.\L\L.GZ]Q,9H,6NRA9b;1JOe5[76<)
&:B&+UcH1Rb=RZ@QU.87b/5ANb\X[&M3/22Q9W5#)?Wf;c0>DAL.>Td>8^f^M5]D
5(-C;_V5KY0EHNbe9aEgJVYVC+-KY.DY_N#)(S=Q-X_6I=M4U2WJRC^>^4KaBI65
T83f7L?\YUEGR+64UEU\\NgU+dF>C<74K1_]J77?P0X^\(<XPR#>4M9/0\]Q/]06
YM.N1GXbL6][9):XUZ#@+5.9<OFKP@J]/P/GS4U:9^Y.ff(ZAB^C989._4PE]T51
=9P_e8EcEXI[&TbNJXNFCJde]H2)E#[/aSKNPaKZ?3T6bXb]c@YeA7#(+b0+2;E,
-/M7+6_2-U(:[4U&ZIWT_?5<0JNKG^f0D0&7F;\7ZfN;Q<&GOc+TYJS?(dQ7PeS/
aNO,Ze4QX=Rbd:M\L;H2&T^4gRM8H\K4a?JN&JID4T_9><\U^#5aG5O;H;Z(>AeX
J[F_,@_Va\MO_G.;J.AffL=3cNdS/MQ7bcbBW<Kd]DR0Vc8\a]31cHE8LHB.W+1A
_gZ,&63W(Qf-Mda).5/@.M\-OW<+JJ24E.<>B[OLDS-.W];AaH]?P?SA)eU@6Q>4
Z?f8;Y/\-L9bI#^2#KFGCH9T(#7=ZL]c[-MfZNbfD4]99Q:MdRHTN=3J-CFP9?-S
[]=YTXAJ)6(HJ[/KR\=d[eQS9BX/@M3.064N?3@G-b]EQe/g/#G5\eMEF^#[gK]_
0VaIVA=;1GI,?ED^,S_Uf3eG,]a9;<AYCYc9J.J]UQ7-GX^WL\81&HQGUPU(0a^N
8BaC]/e&e2\9dg9PcV?]d=H-4;N6D5beY,>e&OOZ\#e&Y1^([J9/f:bfV=d&^=-D
B+,dbW39IZ@<T+X-0B_#1a]?TJ]C@OY+I)[XP-[G9Pf>6MJ,-HRe;0a4fO1(8J\,
6]JN;LgM,&aGO1AE92KKU@0Og-WQC).A5^J(B>WH6T@0,-;f\(@+Y,8Dg4gaPaag
.:R:YISWcNSW=e6ASgDO0.XV_dHJHL(,TdZ&)=.R&9,1)EXVVRC+eLZ2ZF/,Q4+R
BHb.OD&N6DeH,W5Og#EUQJ>cP>Y\0^1+Nb8C@HFM<H\@<\b78]??[Xa)+-U)JZT;
HRKd;J?b:0Lc9LdHdV8QCYF))bA64-)46\QOVP2C?CUM+\W<([4VTPSeH9?DJ:ZG
c3-,I.E)Q.9TRd9>EMD;GG)N(;?-Q+S(Z\O</,XR79.@3H^fC_.JWC]X4b=JWCO?
TPe,bGd1BT..IN5C]RPDY\7-EC.S+?6K6D#f2SHUWV^(MKW1<^,aPHQc/(HZ&gPF
b8P6OBB\1?GF;2gI&D@X]6UJER>g[?aZOSZ#UeRPX#1G6TB/gdI;3GIa7BX\UY&E
U<8J(3B#EI=IE.Y,^a6,:K#I<X2D>,#8=aO)YA.&<.Xc.P#>Z1Z3T.>OPDDQR6QE
3/M.EE7W.QefVKZ.,@BJ95S::&H&Z-,^2[@fR\XcA,?#.,A^X>be?V88STK00cdE
X6F^I-]32+bQL3Fg^L#:BS8VITLXaJ&dXNBKF&W8>(SZ=f)T097\8gWA?^2+@04:
8Se@>e4H[3fB?+=W-U4g1\=g8,__>-[[>31]TFQ.@O<eGII1DVcI7X:.@2?_@,I_
E)D(eV.C0-#@38.MLZYW;@5BN^g^]dGEc(9+]C[;F9f6+Pa+_MgG4#dK=O?[e?3O
.X,FX=M]LIN]G42,A[9)RaG7.[C,N,d4I]FXc,GF-e,IY^I8g31VK_A?]7/KIS>V
B2)DR16:..=AAFad2ZbY;9?2a=R1,Aa64_gV];Y1#VJ?\7\/Na261eX](S?M[+;(
Vb2T8=+(0Z;#2JYQHf9DaY;=gf9OQNc[IW#A_FX]a_WD<^a?_1XQ6&MDCLR:>]Ue
\eK?6;MaaA(XYFS@E&8R:H,UL>X2?NS/R:PNR:?gI6.AQJ3dX4<gY.@:3IZ>^E;@
MVQ-=G^b/\7,Q4P\E_2K/F?Q#TAKV)Sc#e\eFXQ^bX@IO>^KDJP/463XbQYg5]?4
>^@=TZ#PQ,_&>fVJ@H2Fa_:Q^eM.4R^b276R0I>bR;FN>\g_L&C)#;^Sb5A61);d
<)>.C5OE4a&,T-c6V38Z4R2VR+V[P1]N8T@>&(.9Sf)2.gfRRDLdPeJF[UG;HO>2
T)P&bL=(UA8d@8,@>SA([3X#_Oa(g;^d\]JEfFH)bE#Ze;f_=7-GTYO=[IF?+Bd/
SMa:7+WW<DBIJa&Z4d028RVI]L@HbO/DZD^abD#[PdZ8aVaY[\0#1E3AC;A[X1F<
&M80_A>Z^0[.fVY+U-J2(&80-/Z1d>QDf8,>2R/A;A/IP1fRIL^)EN_9;:\gHW^>
=L3c5dW8CA:O?(_8G_FMT&QbNQMKQ@b[.^5-(KUCB(Y+8=fPGGPe\Y/>A_GF-/?<
.=1[+Q34./3?aY/+QIf399J:fBe/Y-[F20L-c\E<J4FK6NLD+<3R19a?NCbNZ;Y9
[\W,L;=g@@N:X923f_F2110#M1?09R(#V@Gf#=[Z)Z].WJY&OEaM]dWS3\?L(R0g
gRK&R.-?2Y<c1NNO9TQR97^RSf<I_0@?Z@aOT57c\\5Pa&30056/T)/cb]BE79]4
S,=E6BU_VC#Z<.K\Ifc/G/U)\C4(G?eCH-b_SgL(4ca6f0_VJXCM0N@S\L=&/bDd
_e>+[HHZAH)/X24_IRb_>[c>fQ?C]@NUQV#H=;^G.]2I=PV5/(.5=>gDQYG/5O_F
YL[;-bd?GQ]Fe)0H<@:bI77]La\M/UMKPI=9PVW^?8BNQYf5Y7UWgF1PF;VH_JKD
JFbDD8SB1CgB\DXgdaK12HJ-?WC@5c^93I/5(&;>1\;5HIW/]Z<6e^8[_Q92d]8R
F7_eTcRB.W8b.LFH>R#/gfBTD,fB<3WEeM1V<HQ\TL4,L8=/0.aO[_X#e1E?_PNS
4RK9.gd0P)O<_0)aDB[M/5-PR21=W27Q_#\9T6V[;\Pf,B&H#BfH;afYS),Oe(GX
JJ^QE/c+Y?)(BPF#=;<K@V^J_W6K1#^[#Egd@[#8#G^A1gbM@V@7@&.5<g7R#YD&
B:bK(4HQ0\8DJ[4MGVIg/]7BX060GJ_aabR.-QF-1.;M<>S[eI@3J(gW1S(>HJC2
US+Y:EeZI.Z._Cf8G//U>)d0[6-[b9RKcZH3GD/H+6#6[gfDdLV>\N@D:@)RM7)D
eXcc,MGMaLTD&ebcO&SSYP<Bd(IRN6P-7I@97@Y@I220Q9\?DO<4[L0,KZP;8=b6
dYLR4&9gUWDEC(E^I2?[T4<Gc0S01?ZM\4:c1UJGgU?\EE[<cI:WP.1fQ7[Z#S.W
Gea])N8K^ED7OM4d;,QCOUEg5X4(=]U5A.[>B6-eVP9Wdg6G.?\69b?UO8&.>BSZ
C]1=R^FfRKW.bO1E/#++E6Db,UK:1,QG7K_-K,?13S;OM-bfEPPS46[,/0O>,P_M
[FK6:@b)0:5^JJIZ0ZXI2FeK46cX0Y)95@O&FMB,b22YK6NQK29a_;0FS3PP;\WY
IafMg4+CCJ,MKd+\,ALLA03]d[:RbSZ-@#D>cE\=TW^F1[8P4::4<EgeZ+cD=b<,
B[FVYb?&7&N()+)QAOMQN@TX#F7SAEWJ^FNOCOaXB.]L3CBW?:3JTR=]eBIfJFEX
eQ54F\C6^1>6]T>+7\QgI1AcVH-,D&1ce+Ta.);\1fVL2Y3NO9M5)XeG)87b>71<
e5B[CWWC=X/ZaS[O5YC_2EV1O?V]<@e7KSZZ_W<WC/9\g&;]f9,+G+;&ac#8+#VG
2<f+_R,5.+Ae:+8B2KJ+?2U,#4&T@^dW2(cVe,9e2a>5N4SXC2PQG?<gcA;,YOMD
0-O)TB9f&U=AB:IM[XB-/b?VOS22WX=XDB9?3:+7V.5(T(e)I]XR5TdBO^2fT+UX
b<B7#I>NJX+92JE+<f7;bVc>_7\X#TB;d=g^e([PK#DC&6)56d2fAOJ:g#;]85[?
.#1][;5gf6VG21O^gC5I(@C&Q[c5KM:F09c)C7F/F=,)>4_/9C9N;:>@30gNY5H+
.4DUYUTDIGfK&T:_2_b8]&e;Fc-_Z@>-ZSeP1E>;WCZ2>_2e1g>J0?_1-Ib9>N7B
EBOd\R[DY9.17LKP2P\\+]F8>6VB@X=,fPc):-4E/\P<\LCAE1.(S.KVY,-4-5O1
9gd1IKdZV=RSd0?=/+QcUTG<Y(O1NX:]cc2DH/53J0]O#(F+T5A;gNK_RRVR1/)I
7\5RW3[HKUd?Q-L^7Vf(:^Va8PN1FY]#b1HL?_/1J(/c[dWOD@E860(]RQR<@I:,
=[GI]5;4OLgP+)WAY4ZCDNG;72dO^>FY85BZ7Ua?<)T?.X\8;P>W^^NdY9WOXeF<
&^-a3;Nd:HKZ&>aH\ecGAa[JcTD:XID.[A.aM+K2WeFeNMD0-GT_+P](0;QEbQFX
1KYR@9N7aPdQ1?//8OCX:9MD@D(D10aZZc7CZ^7WGZe8J/K.VgB3&R+KJA4)2\55
dG2)QY/11>):[LQ#f0,fV,RN+c@bd:H5VDUbT)J7\NH3JBA;@U<2DN6FN41VHYbf
.6B5Z9GYN2C)22W2U2(;f[2&@Q9Ob-XX@//A::Wb,b:7QO&c5__2#.(SV:e9e^<^
BE-FTF7MMPH#^;;3KC69W^:#5HFSF2_;.V^<)ZOgH9e<(=FI<e_D9;Y_DUT>7?UO
P1Q[M,A)HE5U.^>,(3483EB\4?F00]gdJb].GFL@L2S8S8WB0[ULN7,QV>U+;cZ/
ZD<=+Z\YNe4N\-4N,X+-4_-6N3PAU0(32?K]R;_6Pc@Y2TF4C)&,VMLL&2(>g=BT
XXOCIGg8S5@^D/eG(PcIQHOXC[=dVHe-?0@@2EU&>DO4[F&D990CK?,b5_,N\?Kf
/;FMb01P?ePZ))Ge86;2D7Nb^>gc4g\a00;[=@4de>&/IQaE@/JEO7?N=8C/(;PO
-Sd[>GDUM\+WAUVEW.[VN^aXX=;;BYQe_QYa[-QV=Z&_7.0NRA;G2fPR4Y]fc6WO
XENLY7H,_YE_60@5O4?7E:Za+ePR77eJ75(\:<R(fBP<NI8bYF1UUHE]@N49D,e8
S/Qb0@QQ-U9FcOLE2IIef:+PdBIT>d_;bY?Ga67&>=[#eCGGDBf4^M4a90KIEJAK
.>-GP>DT@dNC=4],fPP>N8NbY\3EVb[?_V(+D(/.dE=.c(f/&RaB4,QS^a.Yb,0U
14LUK(8+PcJL1M#8-?g)5:IK_5V^H9+^W8UV02,dC;-)_[2a^Zb0F^Q3dS[[(?K;
>dX4eOKeJ(,G-_XY;9/:+ME=S,(D#^?aWS\c^/,F4+G2UZB9&&O2YQL[9[-#KH0e
FT:&_gQK[+ZfWU_XeS-GK^c8f:=E86\D?<IC(gZL1O>2PgIY/<EDRB6-Yf74#5,[
EWOB>KF:D&^gJ8dA.YP@53?MU)DXA,>DT6;;L:_I?CDI&LHX=Ge60_-_Qc1&@M6>
#ggG3V;04.I-3KSLgf,.,7D:_6>T>gTfa-ACcGbF(7@GCOBQ9P-g40WU<>D]KC&&
e/)1K>EYR:OgZM,.-e9B\D?EUV;L:1[N)>O7NU83Q_fE)TD3)PbO4YQ^&@;:.ea7
\]NSfEZC&/fX<#^H31M:D@0Z0[c48d;NAHH^J(f+2AS6@]A][e5U0I)&S4]b5aaA
81++BT\IWM70&I3:FE:0+DaT1>McL^PH25AaR@De4dN\^EcL8VENGd9Jd;g#A342
W)N^a^,A9^Vb7X,GQGDTcD@71>,\QPbfEeQGacaa+Q.\\#:,DZ.,QIeNbd8_7;2J
#7V#YAO(.D@X=P\O0>e^/85.?.UEe62+54VRYEYS=fKFEI3cdI)@B9[T&>Nd?\H(
F2>2GJ>eO/RTe5<edcKdfdXN3f&[Sf_2ST4a;OS(M4Q-C</&TS0E9/fYOg6[HSHD
fbUU.?Ug<Jg0;]W)IGR=T.6Ac3bfdR:?(;.HW]X=?]5bU_9bNQ4JOC?F)eP4=3P&
Z@NEeSY1MC+P6YMGP7N8QGA]8Z.M7NT:^2gdGEfA]c^?4&X/@_^MfHd1_;BNTAJO
QCXB_1/Xf41-(e:Z7/V,8M5YQ]K39UX5@e_bKQK879gbGOXP6UDJHge2+XBKQ9^e
HCUgUB6B3&4Q?UEJT<X:?c-@AC6RgM\X7PeFQZ0aX+A_c8OQ2XF#O0V^;G,?_f64
^BA)1M&e4<F\AO_^KGV6R#O_07()(]8IefH0_25^7G\P;@:PUf1D<9PD,BOX[MD@
7:MQ<2>P:bI<9LWOZY?7/VM#LYDHDB50A,5,L_#\M9LA]e?aMHD_g.bP_;4#UeJ[
-B]NGRcJJ8LXH2K5(IOdEYX4H9]6?M>@d\Q<N;/[Q@6O]^=#?dW28be#TE64O(45
(g@E.S_4XJ/^4V6]I0b+S[e97\fO_-Z.P6#6Q>A8Q1DI;b,-E]AgXZb[#VS,HU;J
[2;-@BRT7_Gc.L2(1:+QE?A/2,LBEJZ0dT;^4WM8de#BQ3\Y8>[WMJIGH\(^/0A^
^_a]dO)<4D=W_M60/6QG[TI&789N6Zg\S8C03F(Fe4cB)FWE-4.b@C=.@TDZZ6\Z
MX?4+6)fODN2PIEDY-cY3b-<D,G)65g7a+a\2d>Q3Lc8QC__]6532L71.?;<4cde
9Fc<(2?;f/:16-H6#?&J-);?L&B,&>V&E#V--B;XQ)JgH6LGI0?M8^B8X0,^c;@;
:),LeXa>X<E<BYUOS-M<gL0L>M\-FOQadH)>fYeb[>ZTO(9GO4AUg#ACEDLg#M;Y
6cadL@;.0\1f.W=?<GXb[Y:UU?Z0?@2@f(/T;TFWI.CRKH]d_4A,7IU,<>9dRQT;
1#M(;W:6R^28>Q_HJO&?g3KBfaUD_&G&8dL,dJ<UXNRL1H&:4,C5LQIS2P,VT90A
P>1,M,TS0UeV>B?[H8K-:D&0e<23T2LHUQdaNd1;Y>VO3(I36#L^.14]A^2U0R?&
?#d)9YG0JHUBcG:CMY&INf()/bUHNbOdV7W]^;Jd[gdZ5JX-gRO?b_,[Aa[5G,C1
S80agC1e[6;ZM0PG=>;CdL9HUA655BZKW8dSGBe>CJ2;M3]ISG(g91Q0G6?Q.7eV
RT<+)5G6QaSEAZ-_g8[.@5e1b.IB);e4YHORS1)U\_gUC15/]/BT:H?^\KfU8Q#N
7FMJQD8U0RQ?VJ4N2/(=Wef68/JD_eHUO,G3b8_A2Ja&0J/G\8K-=^JRA--41__A
5QC[SK-U2XV@B=?1G4H]c20M_L)\)@ZU.RcM?3W/ES0(gYWH@-96_6^AcP9F3b;>
/<8@Tc(J>8+W1N,BU55+@BX2fgCbL@ON3()dbFFO(E3Ca[C6-@QZ#S5>KKVf&LeB
Eb,?\LLFD4>8S8L9,;4>=P,C;M7_K.D.4VQ,;Ke#fW;+N5]B,,O@YSb-S_6+IGO]
=^_E4]]f#KPUP,J/K9)&FEKgO\_LA,1fG9OB7=:g=[+\JRd_;=5,U\R=9(1P8g#D
O92D^XF/-W&B>#b8=52Y7f/1:BK7d9A71GP\+>MSI+CNR@HeOSPN0W0?RbAG@d?X
3&5NPF)eL^A5BRSgNc@:IUZ-g#b:1Kf1SZHZ;#=\01N<X\(^\5A@3OPHY@>g&\E1
Q0V-aY^Y_,71[Z(^>81DC4)I@P6RS)8R)\g:A.Z&@YaeV<=I,C^FZ&=aA8[e9Mg\
7\(@Be+LO2UdfS@R?@C(KJH)Q)gd7KFR::CB=G]&<Ce67@Q:?c[K=H2d1Ncg+M>S
VDYffR=fb[JP;WD.g=GOE2d8[2Z8Ba:D[KeI3Y@R]P.+YZLNM@?8HE/RPAN0S]c5
?@:O4Q2ag:c]#QV<V=R:=PBP(.U_ES/0V[d@W_.H^EVJ:6Q-1_MVC>JP#6fQ-;&7
@JNLPIcSTfUT]GBQ3g3)JV^K\==4[A:GfY&&J71=KOcHb0U?^JZI517bP;;6c?Q^
bf/aMd@4BP1VC.7=@a7)#(f4=e?-T,gA6)&,3,#J+ZILP_86E8@bd(:d>E6aTZ/(
^,,;7LDA@QX(g4\SLW?57aL1K5^MgP/EO@VFa#4\GF[CDT80[:RPdC:)bVE79ZMa
2FB;STgOS,;R,M.UY2Pce].CU;I@TS(aDZf10_QK.fVR0/cP1Y<CXe_]W]RD+b+8
E+R;S57<IF4,cU1FTVLBEILC:Z[Nc)\VG@/@H.X_L#61:)ePWO\?VdA+7/T7C15Q
WJ?A@O6P3;NBQZXHfbXPS=I0g64NS2FQ:9g_J)Xc>EQJCfUXFf8#)HV4aWCa[UQG
a_/8JA?f3-PYKQ\)O+TD&2Cb,28cVcR0Wb&F1TYCC[[4VTF?gbBHH\P(4CK=VMYM
(WdZecg^E25R]Ed\2@W#IaZ/Q2+-]IA_4\cULJ>16DG9dUN/Y,c7[]BF<Q)37b6B
b:FaDVDE6/B:?WX9f?,5=PK34CJg[6&KH<XTQGSS4[50MaZ=7(/4d50\5?]H;)55
a_5?QXKD+<QH>90VG@#1_J,_JPV[fV3\-?T]G/Q7fRQ).Xb_91g1&2D&,JWZ1J^-
&/:_XM,E1LaeQ\dKRWZ4QF_R-I:gH8ZX4^>gc/]KY.D#==(U=]+=E2N9.UgKTdRN
NU0HA-f4=(VG977_G;5:K/#ELC><11H02GB_)8\=+R9TLCYdJa@F[=Ie1KK;-=(H
:NYac@I+EV-<NIO&II/P8#UffV]a4L;AGO57,)VJQcbc;MJc@aWe-=P1Rda#W?8S
SSPfD;.9^G[;X0X#A:d5M3\;D3cb99Y8X:f60T@2Z0C^CQ<-+F/K6cXf+<29Q57U
MP4eSGN9/?NBPE-a=:c(:=UZ@M&^7G&NabX9E4+,c#OF,7O2/E]Ed:6RJ]E:>\?I
?S5Y+#[)0^?-eRbJ6_0#JfP>G?WXDLc@MG+aF3]0LZUd-60AKOSO(fDNFHJTY@+/
KK=:U9BU5SF/4]Z>R=gKIVBWV^#8+0^@]I+[R(GM)_/;Z1Ecc#ZQF\;#[e2(+0IF
NeP3f_]a@T,DbS6[T_3J>-OWPLWP#&1CIBfUC4K7@D>ZVOO#-A,ZY2BF1NP(@,eQ
a;,6)K;^Q+#J<59K(<BRT[4^PFFcP=-,,<M2,QRZY^?L_+HEeQ^1QE=L.LQa8He)
H_=+ALObVV(Z4EK0G(A-<9PcF9e^ObOHd,]<C)Q-Pc4&WLg_-7e:gg9ZNeCCVA)7
)f+#_4RC)HNT(9f590N:9F4?.OP8^>75b3#>bgE=5-Og5L/ZP+E]E(9/R?:4TbG.
JADNQ0N46@B6:AX9R8[W2+_0PH1P:]_Vd3/Q<PbHS1-^+c:fDHB,3EHM6EDS.Lb>
U4EA(d;VQW?(\ARLI.PIH7<+Ig<:\WecUd[+DCgE_][_Y4dL1WD=;<?df&GE^8XX
?269GfW=G,\<Z98A#S(Q01>H4Ld9gP#RD07ZD#CUdOB&cIbOD?f?3ZfE:0b&_K[c
9F52]J6=?D.gTV,FU=X/1S3Xc636WBM,2CFEOVGLd/8>202_;JKZT62aa4LLb)f>
1WQR:C#6e1cWaK6I8@-0,IUY9^9Y4V=<LDOL5AD)S(T;fBQ_0@FX&]TFCRT_0HH5
>CXWFJba;Z5M:>2E5?,CWI89&[R>M,MX4#_5AV\3d-KAH<K\^+#XcSNIIdWZ43]B
g&WLC4BU;Z#_3Q,3)NLS?]bRFDBRQNNCI=T8-cPV+N>84LfW=5YAYfX:)F-_>IBe
5K>#BZGK>fI=6[U(BSMG6^.DQNE7&g(b=0+MS_DT?214<IG5.QfBD#+#8Na.=V0S
URdB8e-NcHf+H@KM(b?T7aM18RF-W^2IPWM5MZUR7#/.d@B.8]2M9@=+#N5=bL)R
a6/UFUQ)_/8B)5E3,C,TXEcTMJc\Q:ZMZ/.,+EPZ[USPXNIB=>fK]_.DC9TMTX;@
SJ=Y_6bXRV:L?-,W,-ZUBgG5A;+&d:_.XQg[7KW=E1/13egUI)#LCUK5D0MD:-Sc
C)<7H(eJ(&Y<:Q&#LNRYSdUQO/5=_G\_W3#\Fgg4UPT1R.\M<:gV^AAdS<4IaV=L
efASV0=.[^BILY;&FA[2?f[Pc6a;,RFP7CCEfPF:fU9&AK8d&TdBe\7K7=XNYVgL
A(&#A]b=1ZP,19Gb^BB]_?bP<5\#a[P040Af&_+9NV+OdTc<S<@CE[U(1c)<^QJT
?eL3.e]N=D-@O:W_H@ZEd/aCYI.OTZD2KK?52Z>/a0-5=OIgd\55A2#QAAVV<2&c
aCD<CEWQcX^2L5-@COT2G9a1V\=&W.N3G\]3K/<]B9OK.^cRXdcPJH-E-BB-caH\
;YZELILH5K37;dL#b@83Qg>1(PHK6aU59W];_(8TP&X]3=>/c>;5d7&\Oa:6^H@M
OQN.f49)BNAfT?7]TZFHN@8PdZ7DARB=<OXYB,2M\+E&gYC#JX0+4BMbUA/#KL&F
/YT-Yfd0=03:_4]OG5CEYOZEc+BOIf0355043Ng/61W=-/^:]dA(Q@,L:g65D,O=
M8bUU/8MY[IEWB]2;R#MH3@#MV6ePI8=XfXH/\AMZc6I[Kf9DF2VI<.CCa-R2ESB
BXMT<MDB;CR)W91:UW9@)S[a\[AeKb,>05+4dg30K3EG[=dP44C5dQP((be)2+&)
\Tg=3[N<DK;VTG(E^;&f8:S8;E(X</:T9?N>6_#>(JIH?44;MRJ&N;W?F/agHPO8
X]d9@;I^;82H)f^e^FW:O68^A##BF3EcNYWI7\5^\RFdNa4,GMF5C6VfaAdV=]/(
I:5ff40049(gU5dB5D)#Eg:OQ>9gP2=DB5P/B&^7YG7,/:44Df&7d.#H#,;/IA2@
U_]@8\4f73XHZe<TDUZ.=3>TPHI_fR<>J3)8PKRPRUfg<f_.7Bd>>JI\NK^Bf^2A
e8J/-4M()[[-#=LYTe0&<bgUWE5P0R/5ZgE1_I9aFN^#906H5,C2]AKO7:]<e,MP
.ORJLK>6-)Y#MZNJLK2F]BM[5PWX_RP9/.C;dT6UI6aTfZa<-JMV+=TP@JQL82;3
+F#BfM..aFXZ#b9CVAOGP?>:>f14)a2SFgI#)]c,&_4BNS>#[8QO-BE7FN0ZV@c:
4f]//?#PZ74DESF&ADETgR&89SMBA.<VBd(^8fadMd;F<<<C]ZcY=d?e?f7K=M&/
&&DHJ,&3G3KaEQCZG.,PFHK)99g6U8M6#O[>;8Q(AWM^,/6[aP;fOY_b;38gfQ-@
8.,];SC4<P4bUEYaHg#aHF-T6AJ]=UKOHG#\Efb(N?/KEO]2YJa?eLQeD0g03B<&
)G=CeGLH84-PX<c[.W0D-G+OSBWae\J(6Oc</G>U-XX]D5g-F?)/0T\VN:03,eWg
Ba>gR]cfHI_Z/Z5U=aUNM6=d&J>Hc(G7T#^T@6QHD(3+AYMe25@8LK.[Z=dF;P@;
=45gJOJ/[59^O._;?/&LaD8F_fZbPe;>W=#aF0(8d?(TCSG7ERDbfX>[;fUJ>,/?
E9<M>LL?OF2O(+_J=EOKN7)+#WZ7c192)SI7FcNI2^YX0EV>;f5[\GcVg5QJU2VZ
:2/^WB=dLF:07&Ga>0&B(\d0#SKg)H;bgEcJX.]P\0P>R;F.2\)aO?cTCDK=ZDac
-#2<ZQ/8DKMQQJ&J,??dRVBa5:U&_NU49_(]2IK=65])DJ6A=)I:H6ZX)Td&@-KC
3O]G3#9_6S>H5T?2,#.2c;IEGR[C>P[5P=/?BO]cXP=-NY_N8S<U2,\F\&e1YK9\
EDV)(&5c?2VWEPN.?4[Q&V>2G^g;baA;Ub1WG<LSUZAQ)TaS72,.040\F&SVCPRO
WKg9ZHF<;g>+>;?HZAJXf.^P_]CU&;]3&_->agcBUV2f8V/N<,b/9RdP&5gK:Z\Z
H(_U^_,O&=A<7+Y==Wc&E0QWB&O.R:9I]2Y2<H/2#.+,c>KJf6MMSEbd+-NTU<=X
)),;Tb#(;/e4Y992M9<ZcMONA_KBBUC.N/3RMPYP#C-@4S;)EE9b_B8^;7Q+6ENc
4c:>1QS9^^^=Og\dZLR)6>F^PTXcVb)N41;ZFb?<L]J,KS2XaWY[S^U[g?-F&/>S
IRAe8Va>1d?0NRR?9RT2d@Z,)P.]=\cN/Cfg5.7_DWd3=V;0+1KZ^Q2&[,cH]R8E
cA.LS\6M+6Xe9P=M?X;K<R]LO7J3LZCZW.45a+1.=WDZ);/C:?>e(6ZL+G;b7EUC
:6^I_A4b6c3QLZ(3gA<I8YZ8);]=,S0Q,9R7I1CC.D@YXEC/b@;G>@93?:<C1?1-
>bABQ^[?(]YPLHJH5URA40\]S&5)V;_Ac+,M-e-0d\SNdQg9.EE5EMR[NGc0g#4Z
S7+6e.R,-C=a=D&^PK;3=85Be=J0d=S@HUT01H[?(1g\8P3O;BPW,OgMg.LERUfL
WW@\7PU2FCTZ,6@7EU_811>T.#_9FD#cTZNID(e)eX8g,0XRD]2XH]fVKNKN;\NG
.>^42^R&>JSNX_1a^;C0J#--O41(4bP_0+M)bR7&4MV@6b59LI_SP@EWE3SY00/7
QK;,JBO1WXSG(O,.,]4=#a-Y3Sc<K[K;4M_5,#YI>4EdXM0+D0YFGJWVX00b(K5(
;AfMI6)>..35Q5TSR4XPNN2Zef_<G,FQ7Xd\LEV487+J\BQ1E^GZQO>9&YE<<U-B
bgCP+L3YUa&+OC3bCOcEJ7[B1D\6-3R>#=RNC>QOD]a?O0C,)b5W[9I#TJZ39De3
e06b;AR\JWI\VB\-E8JP86b=+7A?W[TIEW^)]P4:\4eM6,Y#5HB0][B7VD-Z:OLC
++[a#US[NBfHV6:4Ee:<RS@I=JVdB_\e_\,b8,ca30,LM[35g6bd<GLSCC^-A(gE
5^QM96Ic^)JL6Y6.8@2CC&c7bOTSJS6NP:F1>H92Ee/PbG+I4TJ#6CMMc)f+.Je3
_3fg./?H@HMJQ92gG;Tc.cbc\_aI1L>SWa&abEe+]YGUDKRT4b9(;()S>^GF83@R
)89M_XG8,,A\#F.(N_RR88?JK?V7EBUER9CL&ADP))H:K,QVY0--cgB?[RIJZBNb
E80JCU>-2H;e]WI=7FB@W4fad]@6&6O^D7UWN+657/bE8,9WZE1TD]^a,&\_IG#,
65NZ^0-BUCHK5bC-d:XW/I.-<=??We4S?],f/CU,OV>d,18PJ@)XO;;ZAHcgHIZT
?^fY7ae^O(T?U#E)IOASM(@ZMZ@TQ1Ad]KR)FVL7YZ7XVHJLe.S@:G9cB(XTH<eS
f0[=;/C2-J@MBa/,LW046N<)E>79)=^=g3bNX9Fd[\;CWcBHe?ae9Ha0,4^VYbEZ
B.38Y7PM<-7>CD_RG_?fPDFg8#1YFF4-;b5e\&]Q9W]U+645c)ZZa,YC+.B;9L2T
_13A&#0NM8QA;QR_C10>&,AQJR]d0f\Qd?MeIcUP(NVgE;AN<Q>H7ce-]dD>I1#_
/AcLaO(YOQg13_>+g[);#;Od[;5+5ePbBPKeX8DD3e]](e.KJ]g__?Ya#X^@:PGC
22eOBLWTZ)#N4e>CA=OPP=5(;PFP&3W@Q9L=U].H+;KO7:=^U]/;J<=MC,3dVNNA
ZULaYO-:15+G?D[CTCTXCbUaA1?dc96#bZ1^b6&3b?NVD6L<;@VMFc/GUV?@f?CH
U=LVXb6[,193@JF>dDE;HD.E]QJ)D:X/2P<1_EFdf@NG?K&40LZ_Z#K7Q?8K0BA-
;[[6NY[+,,C81?cY/g;NW+Ja+MRfP2@:.O27/JU<>NJAL24E3JCcV;=ZdP:a_(LM
IOHMFb+^g\7_CC0HE)QR=&[Sed[R&N+D[eC^(<(;AXQPQ87,e7];A1P3AC0>E8Z7
U)W[/?<W,;)?gebg264_4[a/[f+Lc),Y8QAOWOGL?MHdc#+f:P[9aF>TB2KO7?L7
LZKE:^ce1=.#D)SP7+b&T/IK@fTb#DW^6]?PYD5e[DAFF@]bPE1TV))7NT7bOFZ_
[?b5=8J>54F7TPG9NY7=HUD-KM3X@=N>=]dD;YFJ;@\J;3C[:eWE#eRL^])JQG-4
?M+TWd4c.\JX8_1\TSGP@bdd(^Ra/d;P-Z>I\K&RB8W26)^\S9QYb8M0PV,@[g]Q
CFaS)^M&);A(]cScQ9_=ZUG.8NLKG9<YUCP);W6]BaN377+(O8>NSC<X&gS.QT/O
KDK=.;VO]X5=)54H.PI<T.a,dI(_b&CJ47dJY\,S3R[/_LB.<G4K6E-WBaa6H=GE
>RCZ3cYN0;6@QcIIB2F\0#Y;Q?S4.N43HE<N(aGN[6_A@XLEI4OQE=3=;/0[0;+B
@^a>BbX^eDZ[QS=>0MYT0dZ&2_NdRcU]Le+a01,H_PYCNEGSH3F:WacIP?Q]f.[U
5=O9SYMAO7^4<\d#FFC@aA0(JdGY<729UGAFQ./e/aEedSXRJKA182G6J\d8)dg&
>d.]D2AM;QIIdD\,/b>].J<+YKG23?J[(QNId>/U:,eTZ(71F@MWIO#34F+JZRFB
M,_3?7=TE__=3fK5aeY;E=KOL>>D8aU2c,([0+)<OS9KeeU3GaDO>+GM9QWa)W.4
SKAd>b[U.gO#GP^BdYV)U[TSFH/A3YD/g]YZ<JT^1U&U,^OST_\14@R]XGUKWe0>
>bFf,,J(PBbQ)4&VUc)(ERSFA#3a55(<8?JJC:/_>XTO@a>[[;:D;>ONA/N:ALUK
V-SdA5#G3=@Wee;HIG40B]/Q6WHF-.4\PXY&Mc>0fRP>YJO2&(\(0Y225dAb>eID
].TM=K\a;WZ/-bN8]H4dD)?f9D=Sf70YNP_,Z_N][U4O;T>^YgJ(_bF7RZ\Fa-(9
W^E3@JX-MNBTfW2-X8VM(@C0S52b)@T5REDa]3W]G&[O.1VG1;GWTN0aceB;+\Q)
a9[YEMFY3]F,JXa;Y[UEcXYDN<@5K4=Z=dbI_=-&HGg+)Y+IP\<=)Afd)Y>FZSX1
b0[=-a/M;UX2<WYS<P>T^^Z+fS])3QaKQD2D6P-_+K12.a&+g4TMW+#RC;N3)56M
?Wg93X^]H<Oe/H>N=7V-N=E;]cXT@YEZ((@R31Q1L>O0NLAg6<4]QA>H8Q4_6:\B
>]5_76.b3Ng;LMHJ[?I^]03eG=a4gQ(/V#Bb8JBg7S^W=K7H+6bc=S)ecQb]J;7/
./@\Ec<WT<b0U3U+Je2ZL2D\AK[/XQ?LHFg<J5=CLeg9-CK-LAH4]AdFLc:E=ZS+
?OJHSb2Rd:]O^MeA;^CTL0S=T]Sa2@MPU99II.UZ6;a8ZdU6gTNdV[;1LQAP;ag8
ZQFS[OB)\41OA535P>Z01K]M,RI66KQ)8.DOCL=3><^[OD..XM?fI4#)X^@-=5d#
,bBeTcT.;KJW;c0bY2aG:Q_BID+S:Z^+.dca.UC3\BLKC:f85HAO)^#D<^9T0Z&(
Dc?[D^b,/66JQC7>&@bX&)K(cEc+#R/@Y=+37[_+FQD\>KUNg#M=89O7MZ\&:22,
a],-DX&JVXC[V56=(fbKKC[0S?(5Z0/M_.<;2XJ\+LYXXFYPWD))DLd.O-2E0(<Y
daSaEO_Y])9VM\4>\CPKW:;G74;I2FaRQXg.1Md:L]0cQJTGK.WAfF)66fa?7Eb?
1:aC204^PgJW,PQ<ZZHE?TRfc7Hb15E3#)319+P\,5b+ZQb1ff/28Pb(Oe7-,NL.
PGHc:.E)CIA#R8c](1W]JF2g]CfG@9Xe.:JYRI0KAZ[YR=gH+KYL1I6^4F#aB3\O
_57NaK<R];?[\Q&Qb(ZRV2PQRNY0:7L8Sa1^O587=GQB_YZG,:9>K;&F?FT9J0H3
[#5=;>IbQ7?.g=)C\BUNRSeF3eMOJ#V\GZ,LFN1YbA2O84BD&RbM]a/d-e_Z7W9W
eOQKNAe?96IK9[b+N-K:+O1ZeUGO+WV1X]BUgRO/Uf&M=OY1[JWE?0dC?/(],4ee
;-<RgIM?82f&]cTdYG&WXJU[S&WG7M&F^T,>C,NU?8:3I1ZOY2_,R_,^VRYTcH+8
0<aS??KMM[_Z#[E0I[.RbS=Oe+4S?\IeRFMdI6:>]T8Tg]U6CE_<-a+9,5F2F^]R
b2/E^dY/OUZ0](HZfYU6[=7A53bO1?7)3#cFa_Y<PU)_G>]E28NMG0:e^Q+gb&8B
8F0A[V1f+b=LGZB5Zf?.N,[3<3(N/a_SW[Fb?X+++KT;,HaHXIK5)7A3VSO@]3X)
_4Ub^fOJ-_/P@d/DaW&g@Q/XKVTQ+V,2VY[6R=25W/H)B-DcF532d86(;Y\=XHQ-
&aa\]aJ6A</8S(<3G/;Y0CGFdB(ec@&JW<KUFTO]#-D.E>#.Fd>NP/PNUW6PMB_F
#b97VbdM5Hg2)-Ze-UQAD:V&c8a7&BQR50YQ\RJ9]6CB8[2227_GW84(P&]=A8I3
&5+59E4=]3Q5DH@GYQ1/1TCc]D517eH1/-.77SKHTN^(\_J;WPabC>P&/OTT+=eC
(Y[Ddg=-7WA-V@.EKC(&SP+KH8ME_IbRM2=(KCBb]EUKRaI50.S/f)B@I6bH6[5I
ZHV:;H@cJ1G[+._cW#&5>><0g?UJUB20A\=Z^VYg>>1Z2(4I:=C]:N\b;,FQ/(Id
F\a)f3:K&7&eT>/^&S48=<L=BBSJ9Z=ME>T=1@Ed@1KK3]ccVJ3WaE\Sd--\#]fM
.5[6>P1g^gJ8@V:EE&@Rd4>/3M7>YR(XEYJ1VSWcA4/fV\fBSbg>[fJ.KC97)cHY
QXK:?_8CO]6&^YE80T^H[]PGV7cCSJVN;F()P#?]CSHYIBK,+c()eUdOX39+>GOZ
0fd^\6D0=B049;^2@D]6+ZI]d[R-UF,3+FAb>#+._Fa6B7,N_BJe?Q\7.6T_S[H+
Z]Kd;aYaV\/-I#2DX@Gc7MfN2X-^R<f88_QD]D1<HHY@6EN#UHVREa;X9c06\Q\D
,QT:6C0DL4LCWT;g35a7S+B164Y@UOXK.UW9E8B9=13;R0+[B:8][?+bU,IW_&4W
P:&/TCR\5IETJR_W/,BUTULE[\XZDESHXOdP<0aF,+C,\36P@[Z0Q&1Q2GE3Ba[1
PcXE9.O?2LHa]Z(f5/7))D1O2BG?77JKRK/d7A1:@eL1b=+^Q.HM8EF\a?]HFFe#
@O/I;[E8cL)\/8TGW?RBVB^5.>M+cL5VbB-Ve?II/5ZS5>RC/E7d/>S32W,@g2;5
YM<V[//[SWK?dW.0^Vd?:2VbVHaQ;U0ZP(6(Y3./^VXT2\_:g[.;9UXAU@b8PSXR
:?B+#)Q7DE8fCM9EX=<b8:IL(3F0b3L.Fce,5/P.Q8^Wc?+(AH#H(2:(WX6&@(d<
X.Q)&@4L#8^G]>3@VQ/&V;LV><K]MY1>C,0UC2C._X(c@\VP..c#1[6KMV:&fcBU
fP@d[EECD?ff57VU&f\3X/G\-R9FYb3MDS-Eg>X;MV+5O@fL(9^G:59+7#gd.R=G
5<KP&[5F03cV>/.Tf^]F(]ICOX,Lf7\;5EV)^-YSSKT1bc-d)[Qd6&;O:TgUYSa;
5>J.LD9Sb0D6-R]V>=DZ@4E2(VF4]SAUYIV1<9Z4@a^H2bO\<(c@#LX#630bN?WE
SeEFRUG\#N&d95C2^DY2]#7Z+dM\I+K;U8O6\4D4PET_2XcAAQ1:0+JT11=dZWE>
SCI,[e;3Y2TU:VM6OH8@<<B7\:@Gb@(ZC4B\#d2ZJ]0Sd1#9B4:c):_MeGcUCHgN
PF+D2^(Pd)e^,QSU+MO8L/D@A(U)VPI-5&3TQUXR.5K1\fN)-RM,R)PK7gFTC/,8
O>HbBGf51&56DfKEEcEf-RF3+Kg>[-@aYQEb+eAOgeZDX^<aNZRO)/TQ&#Ye;;A#
K\11@(VL9H-B0@V(<TPcS<0GN]Ic@Ta;:0AGQK13ca1A:?997L.TL&[AP3JJ)dWe
f8[Tc5<;4E+9355+M0eI#O8YE>9X-M&TR_4UHX2?a7OU8V9S\6VZHg=BJNUgKJa1
MCW/L&YW)AK)b\(9#I8HAY#4aD\[ac.Q<V;WZ>B4ZIF,<V=c@.5XC3A<f6G)K+;0
6KT\J6@J6]CB,Ca>G+QN5P\JY6?=ff+OL;LZX/&N9<eSOGB_d#:\.6Z/\=b(Ufd6
W/5D:.2.HR\I4QdB@25ZU20\6Q3,EH;]\IAL5:9g2?QRQ>+c_#:DfL;A>13>[e@2
dO3X9N;TS\]HN@cN)726UX;F@:9_1<HQF\I&S82M97W)?8bX#^3gKg7VWc:TB[g/
ON\W2H\,QG17/U/UFMFFW3A3P0BY?OTWKFfWdWQZ7MAXV]OIe5]D>N=RK,cR2L?N
94IFW:e:4A3^#JZHV7Te1)a9CT+H\2+LB15:K)UY^g\AJ7R8Y,d0/;:c3efON2R6
BG7W#DSE.G==(JW_f)B-AHBQg1,Vb&KUTSC8LVYOfIaY_OO\5EM\7A,bAXORe(.6
UZc(-Q-TZ2&C;_R3W^BSfBSG;0,#[acTN@>a0eL+KHcg]be+R3YP(\Y_-\Y7;.+B
8NI=^/d>2g3_YeGS;2d>R[[O1K,f2\8PX/d?Q:0R)3cg4ULQY9a.]&-g>bJ)Le.1
@E/[T38+VgL3d,V[SN>00\,TcH<FJ.=<a+C;+;W;7cQf6cf1FN8QE\P+3E6DIJ<2
SA;,D9X@^ZVHE04>4+#=R_>DX-bFR+(S2R]QQL6K=:NQ6D&.@Q#M,DeK^-WTR2--
\J2)J\WH=@PS,>/#g(PQ/8CR+ba&7=FS>3(6E<@B-0V9&T6U=8-IY&fE2deE9?7#
<55I,:6<?eWCN=fCYM>4)g3Af[-:J.6GI.9<F_<9I.>Y2^4X@:-4I3Y-YT#fd@5G
HG.4FcGGNG93-SB\5&d_QL.280]/]-HFBcdU\Q\3M)[O_IS6O-IS7bgNRU9I#ab&
E#5YB21>W)4H_OV>I=efc4V,[>;aK9U2f6^8,-cXI74Y6N1;E5N_?_bN7YJD3@@#
7eH_2AR+cLSA/J(cJ,ZHd7L=2^3FY_7M-Y736FbVKA5#,4@E;8.YJ7IAFcL>O#/<
4b15WU+GdJ,,bKNICa-fa;Q\g8bgVB.Uf+G;.E5XFNeL1&+RTA(C/#/^]bS]Ua#S
G#ZK^[g0(aIVVA;daaBV3W308Y=BI4[>Q&=.>+(P[MI#=d.JLO03E)fNbd.CEb9F
>C;AE2)c-?FC60U#FBU15cc;JabULcUZ6M@6Z6F(EZVa0_b?Bc8/f9aRBfRU,JOS
+1IXCMPfC7cLYS&;9A??=bC;-a^]:S1\J4?;0KD.]UT(G]O,,2;VdX,_2=8,.G75
N.gRKMdR3f9T2;PI&Q(I--f^PQ67@2W<&f-I&]ceDPC^I3:FFR^S;,3JY\G[,be8
=S\^;e1?Pfb<bX#)0U2ZFIDF1BIXL;ACDTT,<<P3PS7B4-QP\#3e.-U\\bM/f-F>
^0a>]]J7Rb5MO):eK6]f>1IH@H\aL>^AJP0T?c14W^13-;0E9+a>?O[NU,2&QSK0
_W#^_gVO_YMcLVT_bCYf;5HW_M\G[;cVKKHc/F;<QG;&cY]2XAJW+I^9c17@3c@-
e/6WEN;RG]/IEf5#b_+#.QRFTXP&bOURFNTXCG#RFLaA(FEE8JX0_Z58ZSV0[?RJ
53SeE[Lb8>N#_BdW,=_aOSTQV)X,JNg&b1ZG@8[A;PT-SAd<R//CP+547f164H8D
7ZKT6UCB]AW)8?TAYg1IJEH<Og0_C]Nd]4UK,_H^\CFQQ+U<H;?-HWE:+A.QG.K[
EYJ2TL]6G)R8cZVeCe8]<<AVPf?\&ML^AeUc3abdYYX(GFT?75AG8:5>M=L.c>74
<)L/OA;-fZQ#8?bHUAe8L@SKDd3,@]I[9:NQYIW+6&P<8a(/\Q]_&I0/L][L2Gd2
&3-&Z-Z@Y?F0<TB<cP)X?OQN6-B,-Bb(]8_?\:19T#Y^N@4MW6^MPH12MK/JO:(I
O^3Kgg(c0S,L1PEECSK^BN:Lc?fTT8JUM#eU.XaR7[M)[/[A(1/H2L8IG+)?4^6#
1XW</A10NUJ/b9TH>QZK2\bEU<1P;DY2:,Y6Ic/S7WZOHf25O:GD8#4A33IX+QQR
c2Ofdg=N5+928>D:abRA?OdXDdO5Qd#]1E@2.QM]&d=gF&M&M2)/@?aA[B^\c3^(
#4-27M1C+)LCWA<Y14K3N\SN1bFLQ(f2#1Q@;)dR[^[c3J;A&):0agMZY=2<:6[U
@^fX^),JGcQVTfZ_PUOW_U^.UUg4I\IEU]4N:_f1GLX8,V>Q1B;c/Jg<3T^FZ^a[
Y1.]e4,d,DbSgC9PgP58YON.]QeBA0=)]6Y&(4;[P5e/J\S@/^PRIT=FTUDHU+<R
/6+dIRc<V^NZQ_Z8P&H[9B:@@_5_M,#+Y7P0-]+A,H_:E(>Ibc,PdU8+1a6:C#>4
Be2,<Se-&-R?Q8JTGd^4ZSURE;4;Ye-J(Fb5NM<H&QTfK>bQLM;1fCH&GR1f7O7>
6B1\ad4W9d>fVFS,N5U#>>FLN2PbQ^1b[B)8/C:,>6M_Y/+O;Q/T@Y?H8/(^O)88
KSNDOGZY;2EDD#FQ-OW])47KJ.b51)S_c]GbQ7b=K2(O7Hf2)99cc>5?F?#^TX?b
3B6K5(.QTVBG)7]9W5OfNZW5f]H<<FNW>RRHTYFC(;Y7a1>Wb5a93>/?C?])F<]8
aRJKKK^T7EG<+#f8<c2L,9H3[Hd8SNWZ^E2OU(,\-J//;=_#7(@Y269:8S5@WM#T
eLM_/+B;X4a.S]g14gJ(VeY#]?(=D]bQ5M/S]d[IJKJGEZ[7:S(5?>UY?06R(Q?J
dILHNKNZ<gcVaX3)]?#D>6ESY,:[GG30Pc.R:^F#gP2g7IH??=-..#=5N:1^B75)
+)?<7cGH0Jg59:H@K>7gBL#B7Qc,D>:/R-d4RD&Cf@)S1OY-N.FC/ZN?]LNXBEU\
8>3d]BMWQ(<4ELLGA43P48Y?<P+)>)3DTA7C:.3><V)e5:-f31-Z6Nd^eA+S^XS^
0C0F5PE[GQ+A/9/e8_#L>]K5\KX_3>2T9&<43PRURVE@M,L?Y66.G^&8Tb9=9fd?
V,3M6^4RD(^IGW#@a-?3ZXANAUQV]#G@[=(-FXZUbQLa5-\g2.@.OT3)Ue)+8@HM
VVAHfQ4BC;#0JA/V/I]-+08;Jd3f82#Fa638^[\+XgR>#6c?>#E:M>+@V3\M)4W,
30bXIbQ@\G)]g?^^NHFLW&H^;-O-O;][KK5ZO7XG29d7VQXD#JH63(J&VJ5e6T+P
+[8KTB_c2g:fNB:F[0+1eMQ]_G#\X5J2D>)IX9>fRf7/S=KC3f6;3&eLI+,AE_Od
H85O9^c68FG5DPJH0(F:8)gG1,3De8_&_^/HgKU1<_@@Z0DaHX[D<WRQ3,#dR21f
SOb6UI15M;R/>-;\O4Mf+:b?^_W+@4QAHaIdUC:c@YgHKN[)Q@>c<B?Y5H7g<._(
B82AJJ5c_Z2?M1Z2^F0bC1K,DR3ZF;8-N@g4gOC)B7X9>ZWW&,XI&OCL+E>DGbe?
+Caf6)(Q2VYc&K-B4:/(0_3<e#Udb.+)S,MDHJc(TMII9b3#D55]FG;<:W\O8<-]
BH#,[=_&)E?+R32_PaGd)W#0]5O.TK6-/3UE@MX?\Ib#)]&)7=#g;1g65c8bAJF^
Zg&ENbdA@&F3Z\F\Rf;0_7)U@S3b[D-0W:?=L]+2&_bY[J37>W21+,?R6K\<<&F?
Z+ff1A68J46#-5UID]MVN9Q^<a9I]?=5eC.2bg5==TbWG7KJ?7><^9^Y1+_[NS,V
c9a(;bCJK<:-f/DKdG2&DMQ(QZ]+CN?.(+Pc6ID6EXePE)-TTMYQXBa#3F&,-76J
_T72@OaK[.DS/a[,>E1GA(0R,Z[03_Q.GLW/O@+#TZc=8-U+2+c,P30;EGN3TRSX
G[ND3fe-;7WJNF^45,L9cU[a3#P-+#G>_V<.KFa0fe(8d&Z9J7?/Q>fT\Z7_OfM3
F;F?FB1bJdFMQ?[,La7M/;-&f/Q<_7M]TKXbgWHH?F?fW?>9-YQS6;\40Igb\N=I
=b5CAN-Me59M^_MH/^,gKBbe9W]OO-:Tb4BMWD<RB#A]Kc>>1H@KT]XBdTaTF_G8
W^EMDbBB_1/J?Yg_8-UW-/V^Z<b;>BJXUIc3>UU:2[&;&gKRa[4U^[(DeM,#V4GW
gQ<923\V:fN,6S)d67c((5@X9Cgg=8N<c9V0S#4HN6,><W@^gSA774W;[NbTU\4)
K=5Z>dUK0=EO_4@CGFZ@bU2f_AG#d.I\XZU:+6OZDJ#Q-JVA#NRF-&IPY&@-O=,9
c6Uf7&5FLeRPFJbKN::QH(U&#[M[JGQ68.(<0Rg61BJ,.;a47@\b<@-K4F7;8_dY
\ZU?fbe)+A8YEY61#[6Y@7_A:2WH\c7@L\,M]2fEZ=Z/I4>J+e?>[4J/+;ZI>2YX
2JfBZ)WVa+>==?<)8TaKNMMcMW>Ia2=I^&P]b1M+1.U[0AR>:4;F[\\TX2]aA@+J
UfM[&g0H#?,C?HRH+W,\@ZdE-6:=+/b6<f]O]OeO4;[;V1cG1E<:_fNT,?\8ROfZ
655fDL]DKaKd?W_5J08MWU0JC_P=<3KTZ=QJ<]gQ75<+@@@K>N3?=&Mg3Od=9a)b
2aY(aLP.dc4PQK,4#g82R[&)D/M/3Z-aED71.TB4(1>?K&GCF^3:NI5VINWP=[8P
6_V?(_@5SLd\+FE5e28Q](N+cEZ4<LaT^OdSYe(8N,[G54F:0E?56+0ZFPL4NAG=
OP2[C^I6UE=d6O;>]>VU+;Vd5^9,-]fc0;cDQ1Nb2#XLL]eE?F.ABYREY/(^0Rfa
0Ha+/O/;,cDIcQJaA+Gg+LaW@R_^WD3U:a.SZ6TZW/0Y@;?NJ[Z#HFD@O.;#_]d7
9C<OK:W_dB=YQX+Bg:Z9R](E&84YR)^]4,3c:,)^2,)\)SW5#fTICV2H-:>324XF
]IE.d5^Ea98aP8f.,<MQW1?JI?D(IXV>==d;gU^T/[19F=+LTL2.:^bdK28TFZBG
@C);WU,D240CJ+c@=LDB=AS/917Q826@aX.23SdPF_^)bE9@/S<8f;MIA/cEPW@;
VRD;2_?>>_d<MRX?4)D4eTD)5^6X-<d^\-VeHQ&1NHRP\E0QaBO\5/<5P?DPQ1WY
FU;TDOR]Y5VV^63P&3SV2cC9(N4]N62afS6;H[KYFeQ4\WL]MAPA49W@fM@e\[P:
^#@4>48KJJT;\HA15BY_\f+W,+1&9T>75E&,#34P#&gH^539^>0SJ&#8&@N\S@:S
#1/Pf6dN4H.dd)OL>65N5GZ&ZbTQ0(66SK].0#<fa[+5ZV_O1)SNLdF2a2NgRgGZ
g6J&d1U/7FGKA)HeW??SMPT(9&,\M37gG@#;FB.c^AEV\\O/I;LDA@]ZcQNC2_Wd
0F/3C#d)X5<eg3fIE4f_?UVAP<a[&SF7AUZg^>:WSH+1@OE0<VY,1@\PMWH2-.)A
9-W@Mf=T[f5^c[-PMS+ObF2>XL(9)7=I>2H&Tf[D+7:DHC=\g7bGSaLO??f..D4A
;gKfX)?,cZ@N5?Q?:XIK>eR(WR)#2=_V@)#8:ICKF[8\9;J<]][HI-\WE96eJLI:
@34b)]LQOS7,#eWfWG+8+QVGZ.D7=18CI0cA?MGW>L[_P72D,Z^_@P.1F><Uf254
eK(13X]I/@=OM2<c>bVJ19T>4/ObL-3;FeUK_Q(Y:<JK8IK:7/<acJ-F/:H2;9V#
PCLF3-#V&:NE6HYa:4UIA&W=Q];6ULM1d.DMUL[1J6NU0d.V9TUXZSNNKL#ZP)5Q
G1#F+35/@0&2+V^2OA>8Dc+(eF0L2.,,@-&d^/U#>0,:G4K;&R:U;fb)9DQMJA=O
RJU?Zf]Z2^9(geZbPNY9-.YA?(bA->[FLUd&,R(5/1QCI)F]#Mbff3E->14Z\EP2
e2KDZ?4AGg3.Dc^a<<GPbQ>Z\9LC)\FS)TD-QA@Y<7daZ_eBYgN2D(W]1QY.52SJ
a:LW7-c#a3F/#SdETe3GBdQ=E=K<=F(\[WYb_f&=V0S@;SJ+O\SfF<3@>L;1+2B]
;;VJ&&KZ+dAP9TBaDU.<OJO([@W/OBJ\TeFC0KH2aJD4U>Xg_OJQEg_Z4-S2SBTf
cG4FACY8CK:gg\^c[g,#,2[&[>\6-2Uc,@GW]YK^3\SN#:fdaW].,+EIXQ4aQFW/
S6)dLIZI0]J^&0G+QT(eFd\2JZOC&<7>SUI)E;e^0?4ULe5e[]0X(2[\#/SFcCN\
7Jd+=g1^+5:9&&eO.b(e/:ZQZ)3O>J_NUe@1gMW2/;6[F,.M>a<+<]420T7@)fLD
^[PBR3[UJZ-8;G.5\SV]EWS/LNMeZ6)Y\EZ57T4Q@Lb<FG\/>OW11NY3UaBAce_f
I3@Lg\1@ZMVMQT_[>N&UZYAFQaZFg2RV_-R+0@Y-_OE6:.G-[93ONQS<8K(JYVSO
.MU2<X&K.40gP/=EJD]7.bI(aVOdIBe6(->=SfY3IMB19XU/;.PS\G9EMN@(M^df
BA[M6Z+7KU=YW5Pbc8#+HZ_NW84]0fb0@1M>Aa&S5PB5T5e>Y&+f4)PdX[WN\d&c
HWF462^9:#[Rgac_3\0d&8fHJZQ<14-ga-d,[Lg2<^XOB1U-?]gJV&MC)+HT/Ma-
0;+OIL0@d6(#:f#Sc#Q]\,XBR&QV3KScR0fU0+KG[SSR]0WRPS/\@(JE[J(CDA>8
]4A<G37;.4f8:KCAG&B@DbB4<=P>c#1,I058fMeU7A2_76]e,?W->SO24I^18?1H
8<O::^2/MTJA6V0W/OIUBX9_MMU268J#e7W,8g>TJ73[3T@R#UR+#2aYIK;(060Y
=.J1T7SNGX?36O>2O&#PNU67F).?IZCDVB^J4f[.P&,URGU\CQ/E-6<de7eLJLP6
dH14@:(#FXJQY0(-:-_GMLfL(PX<I&7ZY+SD3=CL(H\N9TYR8.L0fN8U,[A\2)<A
d-Se2)TL4-8?aZ/J12CWfe]GgIDX]4Df9N<W8Hg18+:=#[8a54ZI\]0fT(DG&C7Q
Bc8;a+d3TYO8VTAU=SGF::CTF8<LUT,\;KA@R3#W.aO<JN+MeR+@?[,053DR>c?Y
f_V_N+b6#1/fcHe-FBWZ3(1&B(Tf+BL;4Zg#c=;=>N_<>#SQM.0)O@QD0V#<?>A+
,H8(>ONd07>d91A])7XXGKe:-aO\5T7.]ed/O(6RDc](fgXKUB4+IGdX.A,G)RDR
MEO<R;7[<7CDI(67NZ.>+8YIJ8AYUK=/,cSS_59F(4EH0#a_?0RCT)N^@,)U><)K
+U9\=f:^WQ]-DZH:S/_6Q^Pd\NK[7>fe8YLASOaDGE0@0F]F-]--?QBP=(WPQOM?
E[EGK=aNA:L+afVF9)PWVI71I,Q9Y:QYY#FEL):;:PT<Q,[EQc)9=[#I#agLQ/dM
g[3=6N\bb/)RbBOAF59S6)K@2#84E=@H;J^Ec2g=7V,W.C<Z3BV0/L:b>FFC:J7Q
J++Fg748@;<eBJLPH&T@;@0_>[<(\fB)7E^2@M1I>SGC@_43\c.L#-WW&#4#5VU0
2TU_]F[K9/XSJfS/Q4Rae[TZ4F;YY9H+?)^N-0C5W9(=;CVZ;-IG[MD,/5/TZ7CJ
G#A71\[G\NXbB@T[0Y@9fUL)NZLF-AbR5D5X(3M0DWde0eeTEMCEG_M6;-3-TYT2
0G1V]Q/bDd-+GHA;F(P9)]O<)fWG>AH4A5-,.5.cOD-.f<AO3?HWNMW=7.^_ZVLE
bL.(A#J&R_2_:Y0@+:Lcd;[8=2(YP[VXEG,GA;22>WY)gS<bLFPfVBD#UOGR5bHg
/dQ0c3;ec3:S0V,U,SSc_VJcQY?X&:eZWAfY5@9f3L_&KSKX1WaP6:TMG+@I#J&N
S5.4PL0::>7YKZd^VV@6B/NR9VR^YOHb&OE.WT\RS[6^PQ8C^:BaA1PeY[?>4<>S
[J[D;0g8QHXfR;8L_4/.F>C\b48GHWFU:ZBB=JRUV+.@NC?.AT/b<[LRb=e_\cI#
B]ZYafM<M0@Q\0Q9PGCQFR4,N_G2#,JZ\\U:X[0+4d_bd(b4c<UGL<fa3CG-a3G^
ZH\ZZ>,6+6WdV[L_B=DS/O7LXT>KC>IB70F)CgXfA.^d>7Z49KMR56c9>5I/=QP_
+/,5J(D_E42\3TR?2DKQ#2(E2ABPM;P:TZ#UA#BV?81XJ\C;@?&8c1R&.a++NVgS
SD3VJ]D-3@:(1QP8;D_eGFT^M0=aa]K(MTbb^5Og81F&__2MWQG3g&_@\JHV8Y/4
bDa774F+P/RZ>:YG)5@#>Kd?+;GQLVF>;TSGIcVZ@U?&V4]?.=F&;9C@K&_6\VW7
<T7<FDdb?BMEV+N1?8V&9?ZaONBe/H0YE@K&eC,\7Lg>S>SN:Qa_a0b6C6SBPKOD
Xg17>\(.[^M.Qb:REG.6G?V6ZITX)RSY:_g?Tec#9=YFBb5Z\A&(B_dQH-PT^LW)
C31OEPHP/P&,3+\eP(P?WN1&AA9L3_/;/T8^H9C:NF3)#4eUW4_g(<b>Dae-B&cg
/6/;4)XF;)[#3XN?7:M99J883D>:GIDWDQ2R([Q&-Z#VK)bV#;LK3OIYV;OSN&e;
0]A(>M_/BY)9^W/7>SgITWW)@8=T?WL=_B/08_2PS##]R3\?.Gc<;W^LaJH,a1N)
eTW@cDTF+a)eU7B4bI94>QDb)Ud#9M+568IX(YV=Q18+S/)))7Z1WS5)L-Rd)?^^
O=OTZ1UD0@[Z[Xa9G9/_Y<R0afMbHE1Pf]MAVBAMBCHUREPWHe91/[8(U@RQLXce
,YgHQPMUI5@Z4),_c1RI/+&Y^5cS?A-CfE-a7E?]3(UD[XGZ?50>E:3(C<ec\AUf
EI++VV+P0KRb+5af^R?)1N58.A^<FZX9)EF3-3/=34MJS#PfUWa<9?8\A_fd4#U^
_HT^>#M1UCV5U83<ZD2.SZTbN-_>R/P^fSF^F^2@O\,:W09D8EA\-<,C?S[eeO5M
A\P+<cGgIg_<RFT>68fPPT(Kb.MSb;4(7gL/R03H84VL8Q#aUV]#:gXY+c+JfcTP
O03WgW62W+[_6T=T[).FJ1C:<X&d8[K;Hb5PCI3Ib&&75J;@8PaY01_d]DcHKb:N
&PSJG(#])ZIIdO+-QTG^YU_A>S5[TZ,#2=G6<PJMZ=\E3bB3+],CC6/dPX@((d^f
[H;7f35URJ@KQ6?V\f^W3P=F,IQPDO>OQDaR82bVVbaJOA-G0N9UP,g(Le-DWd1Q
AcST+)ME\f8L]Q56X6T5SD#I@IF(Zd_X33)WC)c^OfZZP:BXJPa-2M&^Y3;c&W8f
\S>?_PDD7O578=/S8_bd50T#]D:fO^@Ba0ZaDT)BF#?Z-Gg,?R.3&60cJJY.AQHR
/@1DJ=GDE8OGD-04E[@f]&D-1<)Y:_E+eS]:,+I.ZOHfKb6^BUZRVEg+R;;)N2[Z
=;GQ-<A-d\T,a=5S]eL)VJ<?1&B2Z6VV>SOVb7..OZ6CJ38[S[5VD@2C8/8./^<B
eGVfM,<W4QG[98[AZ?R(e2EHRee<Ldfd3,IB9[))CZ./XJd&Z?5@GN4b_.\c^fDX
)MIa<-:K1aC2[=Ie93CX\S-F]7VE\]N:YS+g2#T?6EFP#//)LB=A@;.A)VW/3R1F
T)>b&6IJT2J<SO]I]BT_aZD>Y.fO)H]FRUBE.fF,=1b1&5[I3N;ZQ^JaFYHS0aD=
OF50::\;6LLY.N:fT/V^F=7]ScKV\K?DL_P06fEg-YSF@dGNW67RaNW[(J&5:N,H
LM51PXM3N0MH.X/?d458\5g+E_-(Tb[KTK_7XCU_1ILI@>1Pf_=/GH=;KS078+e?
\1>]IG#).-I@PG0Kg-<Z8(L_1Y0&;8+e_<3@5gO&Y:+Q-,18/-D\\Vd6NeYNH>/P
TN]R^f@bf_>K:<fXJ?]3)UL36J2,)Vbg@EcQgYF-2Z#2FeGb]I7]BBNV6PR,]J?]
]=Ib\IN+#f?c=7(ZOI4S?PDScbLgUF@B>Lf9]1_2MWD=927Z#6+]/(62ePc@E::7
V[N)?0<EWZDB,>Ve-AZdK,HUM1g5XaP22:dA5HDI-Za20=f^L2Y.6]<+MdW?;4P8
Pg/RR@7X7_P=c]_]TC5]B[Ab::fZa.SO7F5L0N(1)7=&^f]0OEPaBL&EdC66BEG5
]EO#RSBa8LXZeSWb4TF)6gIE(Jfc/NE<7?\\[d,P>[@OCAES,[f\[#HaV22,M(5a
RU15VPHT_fIE[6e,R8Td9BN)6FeM7RO]XJR+:.+KUdC(7CO5R:?W(Q:3Y_Z(Ne#(
0)W+,ZVR&6=S?;LN2P]IAU\L/S[(>]aSKQRa[\21C2\SCP@+\;=Z?CV.T@/gUI>E
aO@Ca/:NER&U=NRf(PfM1+I.Nd)SN.0f[(EIb^W1cPc1W8V.f2Nc;GI.NU-Z_=?M
I<3W?F-BO@QM.2)YB&ge\+R2M53,1D:TH8dI1P(G^L\&@4)6F7bR0QN@;GCLA#5Q
-GU-<X8:-820OVN=@HO<M/3F\N;@UIf[bN5bF0dSVBNa#3DKbEV,OZDbDQQRSHY/
@E]SMIK9I]RA8C>b=[9A+I(^US\b[acDSe_bH=,CG3)2dS[B^UGc717c&870V6)+
B/e?C\C&VQ:gb4;.^7KG^KSNFa:>c92W)JK8?-ER=gKME1D_]^S?eF79U?(fEY)J
@,->CW^^F(Q#.ID3P/8<OMJfLeJH0<+2:YW9[7LMZGN6J2+/?65CF#e&d(OcCIAb
?0GZNRKbZHH15MR_5<S#UT?7-]4J&@)2#?5#SM6)K(c)=:d3ON0CfHTC57S@=QC@
_?](,KKAe]aR.(GF&edR=D@e<eQ_XDG/HBA8MI#cFUZGL7()1RFHK0:^UYNMMR(N
RL:SJ>0KS@&8+ZIS@)K.GS]-6eNVN#O:F+&F0TbL2c5;#P6.b,)CBVfEa^ba,-Z-
6SU;=:M(V_(C9cd::.^[3VE:-\RUKV:+Ha+K7O;N3=T]^6N_UEHLCK^)d(5)J^Y_
A:^]\-+L@DSF10aDULK[9<18BI+EHD3U>@#8cf.1^);g;K\QYH8Rf=-E63#)Xc5@
);;Ab_C<.BB7EN4d4#QO6H>OB5)^2O@UDbCS5.)S32Y1=P9Ffb.YaFd37BKWD-f+
;=CK,3a=V1^GIeb0]dD085+ZbaQ]bR-]OK1,/:K6HG--PW?bFO9E0.77J:=9A8F0
D@,SXV]d@C\;BQ\IAg9g#BS?BCGebN8_cRb7J=&5SY^[M&W:=GSUPXA=B-<La8QW
SF1,CSJ,aM7cdd[KY]-#:49L=HH7D4[WR[5MX&7K)+gf,F7-AX_6-)>@e@MV]J^7
-LcM/8/P_fD(Y_;&460Y2[O_ZJ(2V\,X^@:d_0W?(/O>d]?fF-9;HQQ[OJe:NS=g
;.<-2NQCeTG&gdAN1@6D.4=.^8=4KN2L5GC1H0^Z1III1Rb&&SMZS?&Z)UM.90a=
\Gd_/#52T.9E=T7dO@Y;]EG;9eW+\AI:cG.JJ<PTg89#@Kg1ZHa49d,)UQ<;4OBX
3@NE3]>>@_B;3SE)SYMGP\4Kb1ZE5ea#:=XBd29^Z@15VJLS,FNT<]:OUKb:8LN<
GI2&OU(D(8A.48P[HVII57_DK+UL(T2b_?eS3230CIdLERP9PI&:SLIF8JG:_;Q.
?^c1g0L\2X>53[+&KT?7&-gEaXSFQ^?S.-(MTIH6OME@>50IF<V[[[09UEeV<^);
1bIX4&0&2U76X_VUNF.H=)6^\)HLY3cYZ@PW@U49O6RZ@NGb.S0JG&]?>]?gC6KL
=2Q(8^G5+X>UG.dO;G#B,c-X&^FeM&.N3ZWI+->L.RC9Kc<4Y0LR5+3fd\M:1249
/eUgEB+/4/6@^F\:8bH/KZ/M4<ZJb5_KTP^#+BN@/VK@\29JWa+07BQJLR2D8\;.
f9?FMP#N5\5;@N0I=1\],9P[PI_)HZbb;@Q^^DdPge,LJ+SS>))Z3KW23K7BQC?S
4Y2U/YKS8JOONT(GD(GF=4FdbNKN>H_RU.F-eGM\K1Y3g&-PA8ad(Q+F.RI[X7@R
V>.[M43G0GB<03;RDGVYU<,CQPV7@A5()W]=]D#3Pd0#V\F\ZW#9M3eK02OR.^C^
-P9;32-_Y4L^:Z=ae&D77MeC>=A8F>UDD,FU1\LYe213JbQ,\L:MWT_9bTJ?OeJ_
O[g2Ne.FF\bY9/Z;Z:V-Od;:H9T5S<E-/bEG=))&B31,:7G(\DYbC_eYggK8D^_>
83+)#+0f+U[?-I:2F4LK-A]ZYb6;,YRN(g1,ebON5=__P@:5?8]JN=-H>6/J<g;A
VB,c^5N,C@CD<RA/e;;ZGE#7SQfbN5;R21=XCY;Eb2)<MZIV-S(_dVSbTIV0C_-F
\F8Y5++VE&_fKZ@^T/\71=N#US\4U?CR4PNAP)>_PO(Y3AMF02+Rb,ZU?f7?Xg-Y
C5,f,\N)XRXFKD=7011=A3DB>#Q-6(PNW\M1NJ:/<aZ(Bc7^I8/=??;_W2#N]aNE
SR&(g,:W2Kd&Nf]O4H7(94?YGRGa07-fFZ_UfW10?c,W1\0HdgQWB8gJdJ7?3M)\
I:Of:.c>__5^P;@#URaW-JS_GdcH)9N.]14ZM,&gP,\C-<2eA-<<;_E;7)0Z@&1Q
)dH3cdD+5MNeWcVF(&S)^R^D<D_-Z.J,bOJcGKLTV=SMW-X?PZ_#)4,2<V(P9@B?
daP^&H7;R8FA0Ja1CNB:1,c288=<U#90/HFa#cFC.N<3R&5eGfZ98c8]RR\F<:#E
6@\IH\=6,M:GV7/T.&/>Y&95]YM^+dfgBa?e,](/A)@HXI.<JA\=RKTPX]:IWY<-
&BGCfN))f#L7fSIQQ-]&cB:H\:GRJ[,W1BSBIZ@-,J&BgE7U8PS(e3.4HV?UXA+;
>?Y8b62JMHR.1O:PVFGYW@J\W\X8TKPbWDQ[:G;ag0aN3c-#WI2TA(e?>T+,S[NG
NV;MgTHCdKWL[<>gKdLbH[fZ7ET[TeO>(N+b[2CCBX,R;#QR/]AWg?1X&\N[aO69
^?[JNXIBQ6?(3e57R5RcZ<+ca#<aCAS;Y#0433P+UCHWI]QWWPc&23MPLHRC>MeE
JAeJ.@6>=G+R>(/TN3:a8__PRB-713X9BU;g^V/K0Y@3TE?C6^:+B/NW1dE^J)7C
VJ2QN43K1bOSXFS-RZ;+/,X1.--05gKW_@OMQZNC8g^V&C6SZ&e<WSSIP&RG#=aA
GOgOC3b6B4?3BgK6<&b#<7fIM(cc.IQ.6)LBE;GL/0DO0HNTMZR=I\6H+,bNCY+e
DURf9^bE5OgFW&A/3X+0#]DYLM4Fe2BW2OE#f#3FggJ38\#Q?^D-Tfa>f3<N2TGb
O(;cDa49UB())#[A0>R)&Z#0G/4D9FFJ_.Z]aWT[<]G8DbXSP24&e?^[F9OG_L#;
SQ@P^T95f_(,&B)2)<CN_KdO4Y^.M(13ERT0@<N?;P[J8&VMgU_ZdZXe<\:UOCR&
62AP=>dP9(PC.Z.Ab)aeUdQ:#XLB9E+;,.gG7&+TcFDT0R-/S#?2\41?E[P)\1:d
E-c[]0BFY5gR0;<A6-ce/R#a&@eTDVG)KL]CW?XC7F</a)dR=4DU&,^17FN^L;H+
@N..(54dcM)<OA)&&+T3BbaO[3HeegZGB>7R5IgVCgd#=\U8UV<8)EZ6dD&A3Ye[
;&:MQYI>?[7aA.1L;;OKV&?d).H-376F=?<JbJZ/D5b,]J=Jg6:4_8^CN6KX?TEd
.Z]X=O+fA/>3f9EIZ_,3CZAO#f4[:.B,;dZ[,N,4LU::U4SU[0XBI\D1f6_:N#5g
6G+d.(d8gf_g7]4Vc6:2eKRI]6d=&H3g+[SP(AgH_YH1gN6DJL](R>EV+Z:A>?+J
,[L+Fb<FDD(4X0BdL\B11\UZJ])c\<QMV^56aMWT4eGBX-J;GU[a=7;O1AgO:20/
aeY79O^NZKSg):Tef[2_<dD_H5\OATf,&\d?_)IU_?T3Y50I2V<(RH:LeLAZ56D@
&1R_cPI^SEg-SU;[Rc>aITBT>=M46H)]TVP7^G.[M;Zg>X-O:]V\2;VbBaRYX#9P
\#WBH](>XBFc0;ZP&Sd28(b=5Y9#6:CVOR?53b2c=]2GP9.#S9X@J>#LXegL0ST-
S@H9S&0:H_,MHb^+[[0PYJ=L<QB,WaYOe98JE6=c.[Yg9b7P+PRK=SCW+.XS>/3V
gY-TO#1c-,AG^C5d274^=]cCX)VVG<[I;c\#D>5O7a^5>X@V#6ZOcA0R2Q3,LR7[
0Cfd8_16OXZ>WGJ0(@aLEX2X(b?(H<]+#(JM6a\=8GA@ZTHBVK6CA>>_^&;M7E?Y
XJL=5f67C)V0;#8PcZY(b667\3/UW#5K/K8CCdbI1AH13eTM70E)=BdU[##b((2<
TXH?Oe;\N-2a.R_0/<:<GX6\J_AWRY7d/8&P)C9cF3cS=<bK=G?H1]Vb=A4,CYXb
2L[=D.DRP+/6Z#S=b+C)6/=3NJW41R.<dJ\A,@N/K+#b&\/AN^AY&eJNUBSQU#&N
]Ld,[Q+9>H+e5LPg8a<?GPG^O/fG<]JLAJ=;X)g=IgSaXQ,:/b:cU67V/Wf/?TLf
ZYddC])A7#BZ-&/^f4C1[Pg3&bWX5b?P#A\be?;/A3?f#RWg[ZQ:5JD<bg8Q/URR
T4<\T;[YS[e=4MFL7>J4D##gG61^&^G^1g5;9C=8O<1+?8D((@,W&B\ABF[#OZ=4
DSfX@?3Z/\Ha/;S6K^Q?W8]W5Q\:^AL=H5W-5S<&B.gJ/0b2/;+d&NB4O[T[/9>+
6#BD)MZHXE1g9?OYJ#5TH570GVEY_b-/JZ+D(aS34?:74&Xg8I=&^X)G;A5BS[A(
IEHE&<OD^GAe@cOZ@aLR+Ee<Y+;OJJYO]=]58+]J\^M5,&0/IV=)=b4>fG@aaOAI
]D0Md6(I+<^E7Y2Ha8fJJ]7gd#Y^B1>FHSBdR:AL.Ic>WAaB&4_90e0&-,7I\.>2
3B^(6O5I)C2R/J)XA)Rb2;QRWG^H_Y.KdH9PU4ZD]K2=dTB3(N\+^)0Ye+Q9>&H3
+<)4Y[1_aT?P10ecV,(F_HN2@e6_X3AL&DI@&<]?3G[?dM-WIG0V5HcRY=P5J\WJ
:3]Fb,)^^Ge0_.C4V>FO6UO:X0e,];QY,Z0ZV=;4;549>TJBe6Q@W=7:=H+P@AG:
Q-a;^KPW>NR[,eRNW.R64f:-8B,2DJ[,YK[XWb\A+YX4.SKCKM4d&6dDR7U>HA<A
9a?\NC42@aJb?LP.CS3&9(GI;7TJb.)E-&dY)-;:3WBN:aJ=N6#d7aP<E:/?W=AA
_-Me0W;3&CD0<L/EYC8Jb;IfB\5>;#A>4<7+/7_f-,4eP,_Q7,R;YXVWWQ8#P@-d
+WCO<POD)NXHMWJU2W/9J.=g.G32-4WMJgJ+FC8M1L#5QeE-X/5a7Q(7^;GBKI>1
AM:Gc@aU9#N_Y>PG,Z7QAS,-#0/C7U\b],Y_bO-_H=?@TF9^S?[+>CG0Q5cG)/(E
E99W22:b0fe2]GTFW>ZGM6/6;(P=MXQ/G-Af0:&@PC+^BZ(+FeD-3[P+R7a,^S=?
G<D2Sa26c4CFG4_b7g43>MOJNG.8-8e58b/-9M7X@GH<@a+eA\=)TX,^9H(^Ye#Y
O5H+0RV6\WC&UV9)YTgEQWUB\O4[J@8):>6H[\-E9.<TR:0C7LZIWR0B\RB(L8P/
I2V)a+aA]f:gY&+E]O/FRND,P)DZE_/ML@6bbM@.RLa8+)1Z[fVV8)BaaYg-/\;;
@=F3U1_a+-_.WONP:H:IC@Y^P-BK<T2<6\cX1\>:>9IUO63,6a564&M&[c\U<\Ff
F+^(&-F>9<]?RQY:(E29K9Z2G5+C?KW,T<IEd&&a5@J^K9@d#?c[=AZXf\fMfKFP
9&e2c&A>E433R5:TA5W;?9Ueg,XWA)YP>E,bQ_\RHFP<G5S4(AGM#BZg-8L45FK^
1+[(RK?[9Z[X44K+#b>S8^;XS@Q.S)(D?^AGVEJ_aJAMO3T-gO@Xf^-=[<EL=dC6
MWcW?9aX(ABEDOA1RIP-HF;M40?8[6@BMX^1A(XgE]>baLEP@G3X8/)N=P9)fB?I
P>fbD5]_61S9gQ=SR)19KW@GbVa(N>R;MZF4bO/IG^HZPN\+<^^VRHDLGAZ7L9cS
eM5GH_fN0(_-&X4cU[Se3QG]86AN3XVM7OYX-T\=2Q_]L]c1A[CYME^+Y(RLJJ6I
7M7@f1SA3][R()+3Dd\BWK+DN?6WVJ+&b1N(2_XF0(B?WDO@C+:[A8-d.gVNdGB-
EXM\]HF_Vg+^4#W@eW#>dN,ceBb\),.;=W+4CI1JA3PfZg15XM-6fT#2[TVV<[f,
DNZL:09.UJZbQI#c-V#TLQ6I8G=O:@S#GHTbbJ2@7,KKeBL;C3H;Fg5AF_.MU/f1
YQBWMZ]@Sa@[N5e2>=N[c9d54<_VOBD>>;f9X-#UNF+Z\#,//\Adbg]3T4_&a<E/
DT2VIFg3M8D^JHTN-T7^f@d[D1fG;I[[R<BUE]4>5/Q2X1-=3H5?eKgYUP[)f3)@
U)BO,/\?/)?Y3U.UbgLKO_6U,N)^Z?f-?7/?DL2Ng\,A4O-^X=Td=F(1g8:E\;fW
7-<L7YR]-K7/Z5/gMXH1U@B/Y9@1+7:8\L5af&V9e2EW;2JUa5L?C@e#IBd@b2,D
4TOYVG[d0:1W&V7+;_.O?FG>Ua4FHg@LcZ4Ia1H-JK9E^M)+[8@a;JX?eYfZ^NS:
QWbcH??/;EW[/_/1-YM^;OD]T[FE6LR\;SJ.MT?Z#O6:;NEL:;UTOfI5Rd;T-A:P
-U&B265@gZ).8)\F:UKJbXO&J/a)_W_9S(S7W3VZMF[\S\eVQMO#7SSa(#UCbO^R
fS#KZ:,5,.K[a^0)=JXVW@UcZ.(aE3.NT;YX35>a=P)Da7X;(X/Z_</HLY#1#(>/
<GcIXQBd)O]OJ8):OFO[W+0VHY)beO:6UA8:8V@LWYS08,RWNb0+,DU>;,F(:e_c
d1T5QYB[eCaW8V-d9#,U[S73DgS.55GM9XLg&VE/<+^_CaU3)NSZ7BBB6F/\EBZf
&WM9]]5:Pb87=7#^0fC59Je&-K^L/1HM.E2_T.V?&R:J?QPg:NZN3A;#+-TabMd>
;?V]O4M9b;#,b58UNI^3V0553Jac,9H:aO33.;Nd_O?S;14ZC&DRB<DW1>GG=3-F
I@278N3:EL-XC4CI:2,IW8P9:0YO#BM\G==4b(Ba=H5_K#9O?PV+N=c3E2IO>WI@
e9?(eWC;dQ++S[IWbWCJGL^8d70E@),=M/GXf\_.C#c_Xe)S&@b8HQ[5:^N^)_YJ
ZY#1Q6D8IS:U\>MBL?AW#+:Y63K:>4I.MD:LDY>QR@[cCV,=0,]/EE\679<;#=AU
EYAQ2_5S>7</&A.<C7,fN;<cM[GHfU_cK_<B;#?9H9XF:QG-gHLE2/d;<8ca?,<9
>-H1bRUG00dZ]5R^]2]9XT_L,2KbDK0\RB4d7R&f/7e./86=5Z5+3FaEDKL.O;RJ
.F,PU&:UU-=J+B>+XU]5VP_TNd4e[/4]_4gUG^<,EeJ-LSX;R)IDHHR=EN<3a+L<
g</\/)VTGUAT.e10c9WH4>17&KLGJQKHEFBQ:7V-#S(N)c06RN(9WdUBZ.1NO.1b
CODADfEZTF/]?AW:F+2Eg#Z4;F>)H+:9+C0R8>+/K,EBHQA9d3-7N.HBT.<CL5>(
7W6a&S,/83&WMH\\9\(#6gg;eLYI@3YH&3UeE88@];NZ+O4]^D_,HQLBVF^-de@C
DS7b:KbSUUJ7-W4JF?NL[T5f^?J^LJ^E(.@^<&gbAOfP()K,VEWUgMH-3g.L@8XG
5-^+ZH6RML:HPgBBWHOeD<M:NNO+RCDPTd/[MeXORM7)U;#,c0\fQ#1C3GdZed8e
&4FV?9)9dD@+1&G79IJVdP&aDB.SK;-bYZM).Xb;_ENBITGJK>7gZ;N&/PXAV<EB
Z.K(FPQd+/1=@:DC<?M;/JeM4[4QN_N8ZL.J4_d>@SUIZF>+)HC@9LM,6<GB&>\)
&3PBLaMf/T.87f1fW/N^5<65_K-)?Q-c/>M)H27M2P8ZAg>-a;G^N10(+-PXBZY5
_JX7I<YYKEFLV8C@Z9=7W6PDe/g01,[.#2=JDMc(8+eM:_JFZN<(eAS;Bc)]R?/M
]-X<.)bc_946QM.4#bXFQKGAgIK7Rg233,773)ULXSA1^6.b>XNe2df+IZ<OV&FC
?-]?g)RGQE2<-Ac:J4?PX]c\F@UE?UP<Y6>PQ8\P[Q7g&P)8Q)QU[@<1bR8=Y7LB
<c(#]\#WW,KRN?dLd(bT+-S17D5-Na:N2?9^QVZ^F?<U<,ZW9C@>e>O@<(A,/3b<
aBE+4f][AbM[a.JA+MH=1=71[DBEZ(.=@ec2YfcH(=+f<Z(IF9H_-J46bR.F.5E<
3SZJHBP;5LP8a[)O.UZ/HMBASA9BV:8,8VI0]d+&/)+)=f=C.8RQ0X)UV]>N3I=Z
W^LTALS49\(QZ]eHI3;L&:.F-&;F,2.XVOa[_c/3KaIXR+M9G:KVS5+[fQ]2b:4(
ME9@0U4ffb<fFQ]PH&S1>3+2CG()XASNaf_LF+b3QeYaQ6d][T;YF97&0\b3/B(C
FQCOH\M8AfJa6f@(c:dXd8/:J9KX+V[/AF2[b^B(__:^;118U0_#Ac((IX#P7bJ?
^GYJ24eZJ[&&-3#9K[&9#@b:^N>SNLDggNLQ<PQ32&2,=6[9PSL>,J+=:eU[):a,
)(^dO7]=CP)()LHPBG#CSZGVVQCb86-@[U?9YRO;>5dJ[bL/,:3_KE6IKF3[RALc
9QeZ9VTQH^M(KMbQDPE<:_+J#IL(X#1[9AfbE4(2-_B2;:#_:I.#WPS0<O.7I\f_
E^7(NDaQ9QX2]CFYfQE+6XCJ.\V\Ye[UP2EPK82AQc(1A-4f>G=/4^?B?]A#e__U
aO8QO1O;O/:WC49MWURPUP<TdKPT&F<B2Ke:d_.-NV[+Lee<)V#NB+;;3.\>#A^I
d@MTb++4APb9]+\5O<8#17^V8#BSdVU1BX_&,HMX];,EJLU<[.5.?_[7^\1<5[4&
W]SN4A2Beb]g(YYe)Lf),<SS&3MU[CSb#BFG3:#H:\+G4YPV0?;eP+6),gU/aTQ\
#=ee0@C:Ba0W+7I]J>9NbOZ=\Z)6GIJJQZQXR]-SNR-_SQBH]CZb[g)^]@+XWRTd
-YJ+I9&G]f,LeRF[W9ce?FA>W.S(O-A1NS&-1Rg0G0WH?c;4Q+JDJ73Yda4H>^5Y
;)Uc?bC<8+^8OgQ272)^/bP[4feN=gJ^dcKSH.fJ/XYgTBP3WWYLDdXK>Lf<KH44
/faGG^,C,ea8]d3P^V0&JW7aF0aH>3&bX+:JPbLdR&&f@SFeL8.&3VL\6a>5Gb&.
F>dbCWJ)_IW+V7CRNg\XMF;S#K.5<+eR6Q4MN6;=>Y/bVSL@;UL7dW>,R&&5\IFO
b:.:33Kg0B2C8XM0-/1(@&OP#WXY1DR3cQ??S8(TRZT3@d><-G&FPCUBKA1I5[[=
X+W:_V.6MX;7I-=cA)NdY6^)ag3__T;//0=g->E,OI0[YbN=ga;I<@Q-&TW0NBV0
OI+1B-)R5]PD<>+(FIJ,CH\CO]T8^SOYKJ8P8)L[g.Q,>#^&b/M5CV5X/?+bd5N.
BJ]P>O-Fg[bY[\a>_:N1,.08EBN4JK5]IYA(dIMRR>>BT=17?<c5WT)aJe:RE_A#
<aXe[[.I?5d/6fO7H[XBW<a4&ZGS+I6DYdXBW&-?\PJ&\DJG(C-S9+Oc2g^DJ:Z@
7SC:-CWf?5ZAP_-.F4:55L/XTB+Z+6&>3)6>;+A3F63?)),+7DE>4AbSddZAe;1#
.BJ@\FZ[#&^O(K1&MC6,J\S[5_BS0e2DXJ,&=f#/&M1Nff2@]Q)9fY22;YMA>9W#
&C\@7J4O0K][1_+=I3&HVc8VUF5R/5XDRIZHd:JPBTY9D1aI,F?#&cWf@&Y2P?<[
Y6?ZD7BPRZ[-],++A&g(fb?5#4>=C<-ZNeF+?6;KY;cCgWa<^Gc^XeaaG3PbIP,+
U:40Sa+<Vc8^#8F2BXJN6361B4)P8gMP<V[V?TX3K9OCSfHH///@OJf>R#AA_(D[
JUbcd0]Z)1SJZRCZaLHGffeV>VQR./@^Z\JY)@1NVSRXYG<X/(C=LBV7&UP7(8[X
H8L>C=&4@QH2?^3V^-@HbU>.Qc)QCZVPK:4ECT8J8,.adSBC=[F1)e:DOe[]XH@J
0Sg-22gf;?Q))7-,1Uf7[9^?Dc9(.:NJYC<6G-T2XJ[KUf1B@e-@&C2]f[e82F5d
P<2+#UQ,d+YOB[_06WGId?8O/66/_HTe<E-L;^&#E4@=fBV&d^7AE;9,)BH&+J;M
X-<gR\&:0&]U_[=Bce/a2P/e&e:_;/YU\3<=5/746Q^L,TcNH_;J8=M80YPUXRRK
,]-MfCIIdFW(UfK4baXB+>c)\BZ>#I(B^6I/a@GJJa4K3[CPbO+<F\6)9IVG<)GB
0)&7L;E1&\JNB]2KDQ2;a]19]H;Y,0RJ01ENZRY5+63^_dR+RI\6^SZD\\FFQ=[G
8,[_P[^dRA2-/-dK>,(:33>CU3,Fd^&;;RC&)?BQBXH2^[)gBA;KCP[Mg56f4=CV
Mb;E^;dC-dGA2()E(e#=@\g)XROCD]\2L0?U6G\Z#F.FZGX0P5;P0<UNFR^8/)8B
Fg;JZ/QT..BL_6=+4GO:TZ2XDK>3JBF[?=Fa),LK?S>^+bZCa#N1S<::\S6EO>EO
\U]OH:ffH&<3M<(f_NJ6Q5ZbcZM(8VZ\eBH\869Pa/-Q4Ob<O3X=KQVXe3P2MKIH
).A6?@;I6IVB]b30-:.L=[Q/#CQXQPCdQ9cDQ>>MVZ,-5[GSe;PE,U#CK4VERg#0
G<^DF>O&[[,UP-@XPbgNg81f>+JC6_M]KRQKLA:TU5_Ta=EeKPPG.KL4+UaL0Y)#
3_<+W3+8?C9N1&>bC[S/@C-N05e3GeACITK-dD5H#,Kb<EQg999+ZMQHJ]UX#3:g
#C@GB7,eFC^?5(&H/gH-1QJOLcb1e&6(V2a(QJd+O;a;K8;FYgNbXLQSA50_Y)-M
IT4G\V-0\:ZA9XE1gF?A=WLd=XY-ZgP4aZ-7_Ged)7/2R\E_S>c;E[6=5<&0A8;Y
_#ZUCQ@WNC78UEYR[>_L=E>56=\;RbX^(=VbJeD)-L^Yc+-A]ML@UF@,g6eMdg]X
_ZL(HU=@[PQJ<)M:f^HJ><4+:#:],\c.d+]f^0P(C)M)]RBdK]eEV(/\FXc3=_ZE
>0L7VDV<#<=CZ]M#U0=F73C0,XH^HD=^U-G;gQI5)_L\dY^<],SH2^eF[TTC.2ZJ
;Le8a/P4#b.7>L2OZEc3a<7RBg+J^?[0+?#ZTJS\4S/HHEgGC]bI-N\/b#-_dU:f
CbIdSc)OY>N:P7NVgDR5<R.I+17#Ob7XgOdeD7I6^(^T(D;4[630d[&UORVY)[5V
.W,4C\FX]]34U7N#[.DNQd(D,6-K>+-ZJ^?)9(YVVd=;YA9aFZ[764b^&U^:T>>E
#95:M)c/dW5Z0.<-GGYegb6OEBgSX]BDU7HWcg)bX,#ba[^&P_1:c.LA5I-Ie]:F
=.9QI#&Wc&?+BTR65?a3Y.?9X5?(Hc2-(TV=gLZ]=+B=V#YM9N]A9AVK>#0YS8[2
7UdFA0[c4Sc85NQBS]/88K6bUP+GG_+][FM=2[F\9NO&_#H,fe5W@4/(AV4I9?JR
gRO,5N#.4fETM7;DYSP1c5[gOeMEJa8TVdU#E-Y<1H96b)1g>&IC>X8UZ#V9S1EU
Q>2D49)W\d9C9P)MQN\5c>CJA3@\SD6V#(38)c/GTCcC&UaQF9PN@OU+Ia7?CCU;
M7FO9UD<<+&C.$
`endprotected


`endif // GUARD_SVT_SPI_CONFIGURATION_SV

