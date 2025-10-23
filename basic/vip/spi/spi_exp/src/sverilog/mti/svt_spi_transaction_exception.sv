
`ifndef GUARD_SVT_SPI_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_SPI_TRANSACTION_EXCEPTION_SV

typedef class svt_spi_transaction;

// =============================================================================
/**
 * This class is the foundation <i>exception</i> descriptor for SPI
 * transactions. The exceptions are errors that may be introduced into
 * transactions, for the purpose of testing how the connected port of
 * a DUT responds.<p>
 * <p>
 * The ultimate goal of this class is to describe an error on a
 * transaction in the following terms:
 * <ul>
 *  <li>Which Signal is Affected</li>
 *  <li>Which Bit(s) of the Signal is(are) Affected</li>
 * </ul>
 * To accomplish this, a top-down abstraction-driven approach is used
 * to define the error. The error definition is based on the idea that
 * errors may be broadly classified as <i>Control</i> errors, or <i>Content</i>
 * errors. This class defines basic error <i>kind</i> abstractions, as follows:
 * <dl>
 *  <dt><b>Control Error</b></dt>
 *  <dd>Error which affects a signal that involves the control state machine
 *      of the transaction, but not its content.</dd>
 *  <dt><b>Content Error</b></dt>
 *  <dd>Error which affects a signal that is part of the data content
 *      of the transaction, but not its control. Errors of this type should
 *      be transparent to the SPI Protocol, but may affect higher level
 *      protocols.</dd>
 * <dl>
 * When an object of this class is randomized, the basic error <i>error_kind</i>
 * is selected first (defined by the value of the <b>error_kind</b> property).
 * Then an error-subtype is selected if applicable (defined by the value
 * of the <b>content_error</b> or <b>control_error</b> field). Once these
 * selections have been made, the signal to be affected, and which bits of
 * that signal are affected is determined, using a bit-wise masked overlay
 * of the values of the <b>error_mask</b>, and <b>error_val</b> properties.
 * Each '1' bit in the mask represents a bit position for which the value
 * of the error value will replace the original value in the transaction.
 * <p><p>
 * This class has built-in constraints to cause a randomized object
 * of this type to select valid error kinds, signals, and bits, given
 * a known configuration and transaction. However, it is understood that
 * this may not meet all needs. As such, this class supports an additional
 * mechanism for user extension. The <b>error_kind</b> value may be set (or
 * constrained) to <b>USER_DEFINED_ERROR</b> (in addition to the fundamental
 * error <i>kinds</i>). This has special meaning and effects, as follows:
 * <p><p>
 * Built-in constraints for tiered selection of error description
 * property values are bypassed. The user is responsible for
 * implementing their own constraints, which should be
 * conditional (i.e. only applied when <b>error_kind == USER_DEFINED_ERROR</b>).
 * Within the user's constraints ultimate goal should be to select a
 * <b>affected_signal</b>, <b>error_mask</b>, and
 * <b>error_val</b>, as these properties determine the effect
 * of the error injection. The user's constraints may also be used to
 * cause an error subtype to affect a signal that it ordinarily wouldn't.
 * For example, the constraints could force <b>content_error</b>
 * to <b>CONTENT_INJECT_X_ERROR</b>, while at the same time forcing
 * <b>affected_signal</b> to <b>cmd</b>. The result would be that
 * the VIP SPI Tx will occasionaly inject X's on randomly chosen bits
 * of <b>cmd</b>. Since in the built-in constraints, <b>cmd</b> is only
 * selected if the error kind is <b>CONTROL_ERROR</b>, and since
 * X-injection is not a type of control error, this user-defined
 * error has an effect not normally supported by the VIP.<p><p>
 * <b>Note:</b>When making use of <b>USER_DEFINED_ERROR</b> support, if
 * <b>control_error</b> and <b>content_error</b> are all constrained to their
 * <i>user-defined</i> values (i.e. <b>CONTROL_USER_DEFINED_ERROR</b> and
 * <b>CONTENT_USER_DEFINED_ERROR</b>, respectively) none of
 * this class' built-in error selection constraints are applies. The only
 * built-in constraints that apply are those that determine the affected
 * signal, and bits, based on the configuration (i.e. the built-in
 * constraints won't allow user-specified constraints to select a signal
 * that is not in the configuration, or bits outside the configured
 * width of a signal).<p><p>
 * Once the affected signal and signal bits are selected,
 * whether through the built-in constraints, or by the
 * <b>USER_DEFINED_ERROR</b> mechanism, the default (i.e. built-in)
 * error injection mechanisms will be applied to the signald
 * defined by the resulting values of the <b>affected_signal</b>,
 * <b>error_mask</b>, and <b>error_val</b> properties.
 * Please refer to the section on <b>Transaction Object Error
 * Injection</b>, below. For errors that are represented directly
 * by modifying the contents of the transaction descriptor,
 * this error injection takes place within the virtual method
 * <b>inject_error_into_xact()</b>. The user may optionally extend
 * or overload the <b>inject_error_into_xact()</b> method to implement
 * their own error injection efffect on the transaction object.
 * <b>Note:</b> If the user's constraints select an error subtype that
 * is covered in the <b>"Transactor Supported Error Injection"</b>
 * description below, the the transaction descriptor object should not
 * be modified in the <b>inject_error_into_xact()</b> method.
 * <p><p>
 * <b>Error Injection</b><p>
 * When an error is defined, it must them be injected into a transaction.
 * In the VIP there are two mechanisms that make this happen, as described
 * below...
 * <p>
 * <b>Transaction Object Error Injection</b><p>
 * For errors that do not require special handling, injection occurs by
 * this class modifying the contents of the transaction object itself.
 * the VIP transactor will then excute the transaction as it normally
 * would, based on the contents of the transaction object. All errors
 * possible are supported this way. However, for several special cases,
 * the VIP transactor must interpret and apply the error. Those
 * situations are described in the following section.
 * <p>
 * <b>Transactor Supported Error Injection</b><p>
 * Some error types/signals require special handling by the VIP
 * transactors, because they cannot be expressed directly in the
 * transaction object. In these cases, the transaction object is not
 * modified, but the transaction as executed by the VIP transactor is.
 * These cases are as follows:
 * <dl>
 *  <dt><b>CONTROL_ERROR</b></dt>
 *  <dd>This type of error causes the transactor to <i>supress</i>
 *      the affected control signal, forcing it to its inactive
 *      or default state when it should be active.</dd>
 *  <dt><b>CONTENT_ERROR : CONTENT_INJECT_X_ERROR</b></dt>
 *  <dd>This type of error causes the transactor to inject X values
 *      on the affected bits of the affected signal (as defined by
 *      the '1' bits in the <b>error_mask</b> property).</dd>
 * </dl>
 * <p>
 * <b>IMPORTANT</b><p>
 * If the user intends to take advantage of the <b>USER_DEFINED_ERROR</b>
 * capabilities of this class, it is important that the impact of the defined
 * solving order is understood. The <b>solve_order</b> constraint block in this
 * class specifies that the randomized variables be solved in the following
 * specific order:
 * <ul>
 *  <li><b>error_kind</b></li>
 *  <li><b>affected_signal</b></li>
 *  <li><b>affected_bit</b> + <b>error_mask</b></li>
 *  <li><b>error_val</b></li>
 * </ul>
 * As a result of this enforced solution order, if the user wishes to
 * spcifically constrain a property at one level, they must make sure
 * to constrain the properties at higher levels in the solve order to
 * be consistent with the desired lower level result.
 */
class svt_spi_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_spi_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_spi_transaction xact = null;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------
  /** 
   * Error enumerated type error_kind_enum: 
   * Select the appropriate error kind for inserting error. <br/>
   * Eg: To insert error type EMPSPI_INVALID_HEADER_BYTE select error_kind to EMPSPI_ERROR_KIND and empspi_error_kind to EMPSPI_INVALID_HEADER_BYTE.
   */
  typedef enum bit[2:0]
  {
    SPI_ERROR_KIND,/**< This error kind selects #spi_error_kind_enum */
    EMPSPI_ERROR_KIND,/**< This error kind selects #empspi_error_kind_enum */
    FLASH_ERROR_KIND,/**< This error kind selects #flash_error_kind_enum */
    SPI_SAFE_ERROR_KIND,/**< This error kind selects #spi_safe_error_kind_enum  */
    NO_OP_ERROR /**< This error kind selects no error */
  } error_kind_enum;

  /** Error enumerated type spi_error_kind_enum: */
  typedef enum bit[3:0]
  {
    SPI_OVERRIDE_IDLE_PHASE_TRISTATE,/**<
                             This error allows Master/Slave to override tristate('Z') with User Config Data in Idle Phase <br/>
                             after SS_N de-asserts. <br/>
                             Master starts driving this User Config Data after transmitting svt_spi_transaction::timer_idling_between_transfers (trans class). <br/>
                             Slave starts driving this User Config Data immediately after Clock Generation Stops. <br/>
                             The bus clock count after which User Config Data is driven on SPI Interface is in #exception_error_position, <br/>
                             the duration for which User Config Data is driven on SPI Interface is in #exception_error_duration <br/>
                             and User Config value is in #spi_override_idle_phase_tristate_error. <br/>
                             */
    SPI_OVERRIDE_WAIT_PHASE_TRISTATE,/**<
                             This error allows Master/Slave to override tristate('Z') with User Config Data in Wait Phase <br/>
                             after SS_N de-asserts. <br/>
                             The sclk count after which User Config Data is driven on SPI Interface is in #exception_error_position, <br/>
                             the duration for which User Config Data is driven on SPI Interface is in #exception_error_duration <br/>
                             and User Config value is in #spi_override_wait_phase_tristate_error. <br/>
                             */
    SPI_OVERRIDE_DATA_PHASE_TRISTATE,/**<
                             This error allows Master/Slave to override tristate('Z') with User Config Data in Data Phase <br/>
                             after SS_N de-asserts. <br/>
                             The sclk count after which User Config Data is driven on SPI Interface is in #exception_error_position, <br/>
                             the duration for which User Config Data is driven on SPI Interface is in #exception_error_duration <br/>
                             and User Config value is in #spi_override_data_phase_tristate_error. <br/>
                             */
    SPI_IDLE_PHASE_CLOCK_TOGGLE,/**<
                             This error allows Master to drive SCLK in Idle Phase after SS_N de-asserts. <br/>
                             Master starts driving this SCLK Data after transmitting svt_spi_transaction::timer_idling_between_transfers (trans class). <br/>
                             This exception is used in Master Mode Only since Master has the Clock control. <br/>
                             */
    SPI_LEADING_TIME_DEVIATION,/**
                                This Error type allows to model scenarios where Leading Time at SPI Interface is less than Minimum required Leading Time. <br/>  
                                The deviataion is captured through #leading_time_baud_rate_deviation_factor.
                               */
    SPI_TRAILING_TIME_DEVIATION,/**
                                 This Error type allows to model scenarios where Trailing Time at SPI Interface is less than Minimum required Trailing Time. <br/>  
                                 The deviataion is captured through #trailing_time_baud_rate_deviation_factor.
                                */
    SPI_IDLE_TIME_DEVIATION,/**
                             This Error type allows to model scenarios where IDLE Time at SPI Interface is less than Minimum required IDLE Time. <br/>  
                             The deviataion is captured through #idle_time_baud_rate_deviation_factor.
                             */
    SPI_NO_OP_ERROR
  } spi_error_kind_enum;

  /** Error enumerated type empspi_error_kind_enum: */
  typedef enum bit[1:0]
  {
    EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER = `SVT_SPI_EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER,/**<
                                                                     This error allows Slave to de-assert SPI_INT before its actual assertion i.e..<br/> 
                                                                     in middle of a byte transfer. This value can be programmed in terms of SCLK.
                                                                     This clock count after which SPI_INT to be de-asserted is in #empspi_deassert_spi_int_in_middle_of_byte_transfer_error <br/> 
                                                                     Applicable only for the Slave. <br/>
                                                                     Usage case as follows:<br/>
                                                                     Direct Write/Read frame is fired with SPI_INT de-assert in middle of byte transfer
                                                                     */
    EMPSPI_INVALID_HEADER_BYTE = `SVT_SPI_EMPSPI_INVALID_HEADER_BYTE,/**<
                                                                     This error corrupts the EMPSPI Header byte field of Direct Write and Direct Read frame.<br/> 
                                                                     This corrupted EMPSPI Header byte field value is in #empspi_invalid_header_byte_error <br/> 
                                                                     Applicable only for the Master. <br/>
                                                                     Usage case as follows: <br/> 
                                                                     Direct Write/Read frame is fired with corrupted Header byte
                                                                     */
    EMPSPI_INVALID_PAYLOAD_LENGTH = `SVT_SPI_EMPSPI_INVALID_PAYLOAD_LENGTH,/**<
                                                                     This error corrupts the EMPSPI Payload length field of Direct Write and Direct Read frame.<br/> 
                                                                     This corrupted EMPSPI Payload length field value is in #empspi_invalid_payload_length_error <br/> 
                                                                     Applicable for the Master when Direct Write frame is selected and . <br/>
                                                                     Applicable for the Slave when Direct Read frame is selected . <br/>
                                                                     Usage case as follows: <br/> 
                                                                     Master fires Direct Write frame with data size 10 and corrupts payload length with value 5.
                                                                     */
    EMPSPI_NO_OP_ERROR = `SVT_SPI_EMPSPI_NO_OP_ERROR
  } empspi_error_kind_enum;

  /** Error enumerated type flash_error_kind_enum: */
  typedef enum bit[1:0]
  {
    FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION = `SVT_SPI_FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION,/**<
                                                                     This error allows Master to de-assert SS_N before its actual assertion i.e..<br/> 
                                                                     in middle of a byte transfer. This value can be programmed in terms of SCLK.
                                                                     This clock count after which SS_N to be de-asserted is in #flash_deassert_ssn_in_middle_of_transmission_error <br/> 
                                                                     Applicable only for the Master. <br/>
                                                                     */
    FLASH_SCLK_DUTY_CYCLE = `SVT_SPI_FLASH_SCLK_DUTY_CYCLE,/**<
                                                         This error allows Master to assert SCLK High time as per the percentage of full clock cycle. <br/>
                                                         This value is programmed as per the percentage of full clock. <br/>
                                                         The value is stored in #flash_sclk_duty_cycle_error <br/>
                                                         Also, the values of spr and sppr should be set such as the Baud Rate should be the ratios get the half bus clk cycles.
                                                         Applicable only for the Master. <br/>
                                                         Ex: If value is 75. Then duty cycle of SCLK High will be 75 and SCLK Low will be 25. <br/>
                                                             the baud rate divisor should be minimum 2(spr=0,sppr=0) <br/>
                                                         */  
    FLASH_NO_OP_ERROR = `SVT_SPI_FLASH_NO_OP_ERROR
  } flash_error_kind_enum;

  /** Error enumerated type spi_safe_error_kind_enum: */
  typedef enum bit[2:0]
  {
    SPI_SAFE_INVALID_CRC,/**<
                     This error corrupts the SPI SAFE CRC frame with User Config value <br/>
                     This corrupted CRC value is the inverse of current CRC value. <br/> 
                     Applicable for Master/Slave
                     */
    SPI_SAFE_INVALID_FRAME_SIZE,/**<
                     This error corrupts the SPI SAFE frame size with User Config value <br/>
                     This corrupted CRC value is in #spi_safe_invalid_frame_size_error. <br/> 
                     Applicable for Master Only
                     */
    SPI_SAFE_NO_OP_ERROR
  } spi_safe_error_kind_enum;

  /** 
    * Specifies the frame format in which error is inserted 
    * For reasonable constraint please refer to #reasonable_error_kind
    */ 
  rand error_kind_enum error_kind = NO_OP_ERROR;

  /** 
    * Specifies the SPI error type which is to be inserted in the VIP
    * For reasonable constraint please refer to #reasonable_spi_error_kind
    * Default Value: SPI_NO_OP_ERROR
    */ 
  rand spi_error_kind_enum spi_error_kind = SPI_NO_OP_ERROR;

  /** 
    * Specifies the error type which is to be inserted in the VIP
    * For reasonable constraint please refer to #reasonable_empspi_error_kind
    * Default Value: EMPSPI_NO_OP_ERROR
    */ 
  rand empspi_error_kind_enum empspi_error_kind = EMPSPI_NO_OP_ERROR;

  /** 
    * Specifies the error type which is to be inserted in the VIP
    * For reasonable constraint please refer to #reasonable_flash_error_kind
    * Default Value: FLASH_NO_OP_ERROR
    */ 
  rand flash_error_kind_enum flash_error_kind = FLASH_NO_OP_ERROR;

  /** 
    * Specifies the SPI error type which is to be inserted in the VIP
    * For reasonable constraint please refer to #reasonable_spi_safe_error_kind
    * Default Value: SPI_NO_OP_ERROR
    */ 
  rand spi_safe_error_kind_enum spi_safe_error_kind = SPI_SAFE_NO_OP_ERROR;

  /**
    * Weight controlling how often the RANDOM value for SPI_OVERRIDE_IDLE_PHASE_TRISTATE is chosen
    */
  int SPI_OVERRIDE_IDLE_PHASE_TRISTATE_wt = 1;

  /**
    * Weight controlling how often the RANDOM value for SPI_OVERRIDE_WAIT_PHASE_TRISTATE is chosen
    */
  int SPI_OVERRIDE_WAIT_PHASE_TRISTATE_wt = 1;

  /**
    * Weight controlling how often the RANDOM value for SPI_OVERRIDE_DATA_PHASE_TRISTATE is chosen
    */
  int SPI_OVERRIDE_DATA_PHASE_TRISTATE_wt = 1;

  /**
    * Weight controlling how often the RANDOM value for SPI_IDLE_PHASE_CLOCK_TOGGLE is chosen
    */
  int SPI_IDLE_PHASE_CLOCK_TOGGLE_wt = 1;

  /**
   * Weight controlling how often Error type 'SPI_LEADING_TIME_DEVIATION' is selected.
   */ 
  int SPI_LEADING_TIME_DEVIATION_wt = 1;

  /**
   * Weight controlling how often Error type 'SPI_TRAILING_TIME_DEVIATION' is selected.
   */ 
  int SPI_TRAILING_TIME_DEVIATION_wt = 1;

  /**
   * Weight controlling how often Error type 'SPI_IDLE_TIME_DEVIATION' is selected.
   */ 
  int SPI_IDLE_TIME_DEVIATION_wt = 1;

  /**
    * Weight controlling how often the RANDOM value for SPI_NO_OP_ERROR is chosen
    */
  int SPI_NO_OP_ERROR_wt = 1;

  /**
    * Weight controlling how often the RANDOM value for EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER is chosen
    */
  int EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for EMPSPI_INVALID_HEADER_BYTE is chosen
    */
  int EMPSPI_INVALID_HEADER_BYTE_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for EMPSPI_INVALID_PAYLOAD_LENGTH is chosen
    */
  int EMPSPI_INVALID_PAYLOAD_LENGTH_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for EMPSPI_NO_OP_ERROR is chosen
    */
  int EMPSPI_NO_OP_ERROR_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION is chosen
    */
  int FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for FLASH_SCLK_DUTY_CYCLE is chosen
    */
  int FLASH_SCLK_DUTY_CYCLE_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for FLASH_NO_OP_ERROR is chosen
    */
  int FLASH_NO_OP_ERROR_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for SPI_SAFE_INVALID_CRC is chosen
    */
  int SPI_SAFE_INVALID_CRC_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for SPI_SAFE_INVALID_FRAME_SIZE is chosen
    */
  int SPI_SAFE_INVALID_FRAME_SIZE_wt = 1; 

  /**
    * Weight controlling how often the RANDOM value for SPI_SAFE_NO_OP_ERROR is chosen
    */
  int SPI_SAFE_NO_OP_ERROR_wt = 1; 

  /**
    * This register holds the value of error defined by SPI_OVERRIDE_IDLE_PHASE_TRISTATE. 
    * Default Value: 1'b0
    */
  rand bit spi_override_idle_phase_tristate_error = 1'b0;

  /**
    * This register holds the value of error defined by SPI_OVERRIDE_WAIT_PHASE_TRISTATE. 
    * Default Value: 1'b0
    */
  rand bit spi_override_wait_phase_tristate_error = 1'b0;

  /**
    * This register holds the value of error defined by SPI_OVERRIDE_DATA_PHASE_TRISTATE. 
    * Default Value: 1'b0
    */
  rand bit spi_override_data_phase_tristate_error = 1'b0;

  /**
    * This register holds the location of bit to be corrupted on SPI LINE
    * For reasonable constraint please refer to #reasonable_exception_error_position
    * Default Value: 0
    */
  rand int exception_error_position = 1;

  /**
    * This register holds the duration for which bit is to be corrupted on SPI LINE
    * For reasonable constraint please refer to
    * #reasonable_exception_error_duration
    * Default Value: 0
    */
  rand int exception_error_duration = 1;

  /**
    * This register holds the value of error defined by EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER. 
    * For reasonable constraint please refer to #reasonable_empspi_deassert_spi_int_in_middle_of_byte_transfer_error
    * Default Value: 32'd8
    */
  rand int empspi_deassert_spi_int_in_middle_of_byte_transfer_error = 8;  

  /**
    * This register holds the value of error defined by EMPSPI_INVALID_HEADER_BYTE. 
    * Default Value: 16'h0
    */
  rand bit [15:0] empspi_invalid_header_byte_error = 16'h0;  

  /**
    * This register holds the value of error defined by EMPSPI_INVALID_PAYLOAD_LENGTH.
    * For reasonable constraint please refer to #reasonable_empspi_invalid_payload_length_error
    * Default Value: 16'h0
    */
  rand bit [15:0] empspi_invalid_payload_length_error = 16'h0;  

  /**
    * This register holds the value of error defined by FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION. 
    * For reasonable constraint please refer to #reasonable_flash_deassert_ssn_in_middle_of_transmission_error
    * Default Value: 32'd8
    */
  rand int flash_deassert_ssn_in_middle_of_transmission_error = 8;  

  /**
    * This register holds the value of error defined by FLASH_SCLK_DUTY_CYCLE. 
    * The value is in terms of percentage of sclk period.
    * Ex: If Clock High Duty cycle is to be set as 60%, this field should
    * contain the value 60. The Clock Low Duty cycle.
    * Default Value: 32'd50
    */
  rand int flash_sclk_duty_cycle_error = 50;  

  /**
    * This register holds the value of error defined by SPI_SAFE_INVALID_FRAME_SIZE.
    * For reasonable constraint please refer to #reasonable_spi_safe_invalid_frame_size_error
    * Default Value: 32'd0
    */
  rand int spi_safe_invalid_frame_size_error = 1;

  /**
   * This field is used to inject error in Baud rate parameter used for Leading time(tL) calculation in Master agent. <br/> 
   * It specifies the deviation of BaudRateDivisor ((sppr + 1) * 2 ^(spr + 1)) that <br/>
   * is used by Master agent for Leading time (tL) calculation. <br/>
   * Override_BaudRateDivisor(Leading Time) = ((sppr + 1) * 2 ^(spr + 1)) - #leading_time_baud_rate_deviation_factor. <br/>
   * Effective leading_time = Override_BaudRateDivisor * timer_leading * Half BusClock Period <br/>
   */
  rand int leading_time_baud_rate_deviation_factor = 0;

  /**
   * This field is used to inject error in Baud rate parameter used for Trailing time(tT) calculation in Master agent. <br/> 
   * It specifies the deviation of BaudRateDivisor ((sppr + 1) * 2 ^(spr + 1)) that <br/>
   * is used by Master agent for Trailing time calculation. <br/>
   * Override_BaudRateDivisor(Trailing Time) = ((sppr + 1) * 2 ^(spr + 1)) - #trailing_time_baud_rate_deviation_factor. <br/>
   * Effective Trailing_time = Override_BaudRateDivisor * timer_trailing * Half BusClock Period <br/>
   */
  rand int trailing_time_baud_rate_deviation_factor = 0;

  /**
   * This field is used to inject error in Baud rate parameter used for Idle time(tI) between transfer calculation in Master agent. <br/> 
   * It specifies the deviation of BaudRateDivisor ((sppr + 1) * 2 ^(spr + 1)) that <br/>
   * is used by Master agent for Idle time calculation. <br/>
   * Override_BaudRateDivisor(Idle Time) = ((sppr + 1) * 2 ^(spr + 1)) - #idle_time_baud_rate_deviation_factor. <br/>
   * Effective Idle_time = Override_BaudRateDivisor * timer_trailing * Half BusClock Period <br/>
   */
  rand int idle_time_baud_rate_deviation_factor = 0;

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
   * Valid ranges constraints insure that the exception settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
    spi_error_kind dist {
      SPI_OVERRIDE_IDLE_PHASE_TRISTATE := SPI_OVERRIDE_IDLE_PHASE_TRISTATE_wt,
      SPI_OVERRIDE_WAIT_PHASE_TRISTATE := SPI_OVERRIDE_WAIT_PHASE_TRISTATE_wt,
      SPI_OVERRIDE_DATA_PHASE_TRISTATE := SPI_OVERRIDE_DATA_PHASE_TRISTATE_wt,
      SPI_IDLE_PHASE_CLOCK_TOGGLE := SPI_IDLE_PHASE_CLOCK_TOGGLE_wt,
      SPI_LEADING_TIME_DEVIATION   := SPI_LEADING_TIME_DEVIATION_wt,
      SPI_TRAILING_TIME_DEVIATION  := SPI_TRAILING_TIME_DEVIATION_wt,
      SPI_IDLE_TIME_DEVIATION := SPI_IDLE_TIME_DEVIATION_wt,
      SPI_NO_OP_ERROR := SPI_NO_OP_ERROR_wt
    };
    if(error_kind == SPI_ERROR_KIND) {
      if(~cfg.is_master)
        !(spi_error_kind inside {SPI_IDLE_PHASE_CLOCK_TOGGLE,SPI_LEADING_TIME_DEVIATION,SPI_TRAILING_TIME_DEVIATION,SPI_IDLE_TIME_DEVIATION});
    }
    empspi_error_kind dist {
      EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER := EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER_wt,
      EMPSPI_INVALID_HEADER_BYTE := EMPSPI_INVALID_HEADER_BYTE_wt,
      EMPSPI_INVALID_PAYLOAD_LENGTH := EMPSPI_INVALID_PAYLOAD_LENGTH_wt,
      EMPSPI_NO_OP_ERROR := EMPSPI_NO_OP_ERROR_wt
    };
    if(error_kind == EMPSPI_ERROR_KIND) {
      empspi_deassert_spi_int_in_middle_of_byte_transfer_error > 1;
      !(empspi_invalid_header_byte_error inside {16'h0100,16'h0200});
    }
    else {
      empspi_deassert_spi_int_in_middle_of_byte_transfer_error == 1;
      empspi_invalid_header_byte_error == 16'h0;
      empspi_invalid_payload_length_error == 16'h0;
    }
    flash_error_kind dist {
      FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION := FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION_wt,
      FLASH_SCLK_DUTY_CYCLE := FLASH_SCLK_DUTY_CYCLE_wt,                                             
      FLASH_NO_OP_ERROR := FLASH_NO_OP_ERROR_wt
    };
    if(error_kind == FLASH_ERROR_KIND) {
      flash_deassert_ssn_in_middle_of_transmission_error > 1;
      flash_sclk_duty_cycle_error inside {[1:99]};
    }
    else {
      flash_deassert_ssn_in_middle_of_transmission_error == 1;
      flash_sclk_duty_cycle_error == 50;
    }
    spi_safe_error_kind dist {
      SPI_SAFE_INVALID_CRC := SPI_SAFE_INVALID_CRC_wt,
      SPI_SAFE_INVALID_FRAME_SIZE := SPI_SAFE_INVALID_FRAME_SIZE_wt,
      SPI_SAFE_NO_OP_ERROR := SPI_SAFE_NO_OP_ERROR_wt
    };
    !(spi_safe_invalid_frame_size_error == xact.spi_safe_frame_size);
    if(cfg.frame_format == svt_spi_types::SPI_SAFE)
      spi_error_kind inside {SPI_IDLE_PHASE_CLOCK_TOGGLE,SPI_NO_OP_ERROR};  
  }

  /** Reasonable constraint for #error_kind
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_error_kind {
    if(cfg.frame_format == svt_spi_types::SPI_STD || cfg.frame_format == svt_spi_types::SPI_MULTILANE)
      error_kind == SPI_ERROR_KIND;  
    else if(cfg.frame_format == svt_spi_types::SPI_EMPSPI)
      error_kind == EMPSPI_ERROR_KIND;
    else if(cfg.frame_format == svt_spi_types::SPI_FLASH)
      error_kind inside {SPI_ERROR_KIND,FLASH_ERROR_KIND};
    else if(cfg.frame_format == svt_spi_types::SPI_SAFE)
      error_kind inside {SPI_SAFE_ERROR_KIND,SPI_ERROR_KIND};
    else
      error_kind == NO_OP_ERROR;  
  }

  /** Reasonable constraint for #spi_error_kind
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_spi_error_kind {
    if(error_kind == SPI_ERROR_KIND) {
      //if(cfg.frame_format == svt_spi_types::SPI_STD || cfg.frame_format == svt_spi_types::SPI_MULTILANE || cfg.frame_format == svt_spi_types::SPI_FLASH) {
      //  if(cfg.frame_format == svt_spi_types::SPI_STD && 
      //          (cfg.spi_feature == svt_spi_types::SPI || cfg.spi_feature == svt_spi_types::SSP))
      //    !(spi_error_kind inside {SPI_OVERRIDE_WAIT_PHASE_TRISTATE});
      //}
      if(cfg.frame_format == svt_spi_types::SPI_STD) {
        if(cfg.spi_feature == svt_spi_types::SPI || cfg.spi_feature == svt_spi_types::SSP)
          !(spi_error_kind inside {SPI_OVERRIDE_WAIT_PHASE_TRISTATE});
      }
      else if(cfg.frame_format == svt_spi_types::SPI_SAFE)
        spi_error_kind inside {SPI_IDLE_PHASE_CLOCK_TOGGLE,SPI_NO_OP_ERROR};  
      else if (cfg.frame_format == svt_spi_types::SPI_MULTILANE || cfg.frame_format == svt_spi_types::SPI_FLASH) {
        !(spi_error_kind inside {SPI_LEADING_TIME_DEVIATION,SPI_TRAILING_TIME_DEVIATION,SPI_IDLE_TIME_DEVIATION});  
      } 
      else
        spi_error_kind == SPI_NO_OP_ERROR;  
    }
    else
      spi_error_kind == SPI_NO_OP_ERROR; 
  }

  /** Reasonable constraint for #empspi_error_kind
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_empspi_error_kind {
    if(cfg.frame_format == svt_spi_types::SPI_EMPSPI) {
      if(cfg.is_master)
        empspi_error_kind inside {EMPSPI_INVALID_HEADER_BYTE, EMPSPI_INVALID_PAYLOAD_LENGTH};
      else
        empspi_error_kind inside {EMPSPI_DEASSERT_SPI_INT_IN_MIDDLE_OF_BYTE_TRANSFER, EMPSPI_INVALID_PAYLOAD_LENGTH};
    }
    else
      empspi_error_kind == EMPSPI_NO_OP_ERROR;  
  }

  /** Reasonable constraint for #flash_error_kind
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_flash_error_kind {
    if(cfg.frame_format == svt_spi_types::SPI_FLASH)
      flash_error_kind inside {FLASH_DEASSERT_SSN_IN_MIDDLE_OF_TRANSMISSION,FLASH_SCLK_DUTY_CYCLE};
    else
      flash_error_kind == FLASH_NO_OP_ERROR;  
  }

  /** Reasonable constraint for #spi_safe_error_kind
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_spi_safe_error_kind {
    if(cfg.frame_format == svt_spi_types::SPI_SAFE)
      spi_safe_error_kind inside {SPI_SAFE_INVALID_CRC,SPI_SAFE_INVALID_FRAME_SIZE};
    else
      spi_safe_error_kind == SPI_SAFE_NO_OP_ERROR;  
  }

  /** Reasonable constraint for #spi_override_wait_phase_tristate_error
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_spi_override_wait_phase_tristate_error {
    if(spi_error_kind == SPI_OVERRIDE_WAIT_PHASE_TRISTATE) {
      if(~cfg.is_master && cfg.spi_feature == svt_spi_types::UWIRE && cfg.frame_format == svt_spi_types::SPI_STD)  
        spi_override_wait_phase_tristate_error == 1;
      else 
        spi_override_wait_phase_tristate_error inside {0,1};
    }
    else
      spi_override_wait_phase_tristate_error == 0;
  }

  /** Reasonable constraint for #empspi_deassert_spi_int_in_middle_of_byte_transfer_error
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_empspi_deassert_spi_int_in_middle_of_byte_transfer_error {
    empspi_deassert_spi_int_in_middle_of_byte_transfer_error inside {[1:31]};
  }

  /** Reasonable constraint for #empspi_invalid_payload_length_error
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_empspi_invalid_payload_length_error {
    empspi_invalid_payload_length_error inside {[0:31]};
  }

  /** Reasonable constraint for #flash_deassert_ssn_in_middle_of_transmission_error
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_flash_deassert_ssn_in_middle_of_transmission_error {
    flash_deassert_ssn_in_middle_of_transmission_error inside {[1:xact.total_transmit_edge]};
  }

 /** Reasonable constraint for #exception_error_position
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
   constraint reasonable_exception_error_position {
     if(spi_error_kind == SPI_OVERRIDE_IDLE_PHASE_TRISTATE)
       exception_error_position inside {[1:`SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER-1]};
     else if(spi_error_kind == SPI_OVERRIDE_WAIT_PHASE_TRISTATE)
       exception_error_position inside {[1:xact.wait_cycle_count]};
     else if(spi_error_kind == SPI_OVERRIDE_DATA_PHASE_TRISTATE) {
       if(cfg.spi_feature == svt_spi_types::UWIRE && cfg.frame_format == svt_spi_types::SPI_STD && xact.uwire_transfer_state == svt_spi_types::NON_SEQUENTIAL)
         exception_error_position inside {[1:(cfg.data_frame_width/xact.data_lane_count)]};
       else
         exception_error_position inside {[1:((xact.data_frame_size*cfg.data_frame_width)/xact.data_lane_count)]};
     }
     else if(spi_error_kind == SPI_IDLE_PHASE_CLOCK_TOGGLE)
       exception_error_position inside {[1:`SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER-1]};
     else
       exception_error_position == 0;  
   }

 /** Reasonable constraint for #exception_error_duration
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
   constraint reasonable_exception_error_duration {
     if(spi_error_kind == SPI_OVERRIDE_IDLE_PHASE_TRISTATE)
       exception_error_duration inside {[1:(`SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER-exception_error_position+1)]};
     else if(spi_error_kind == SPI_OVERRIDE_WAIT_PHASE_TRISTATE)
       exception_error_duration inside {[1:xact.wait_cycle_count-exception_error_position+1]};
     else if(spi_error_kind == SPI_OVERRIDE_DATA_PHASE_TRISTATE) {
       if(cfg.spi_feature == svt_spi_types::UWIRE && cfg.frame_format == svt_spi_types::SPI_STD && xact.uwire_transfer_state == svt_spi_types::NON_SEQUENTIAL)
         exception_error_duration inside {[1:(cfg.data_frame_width/xact.data_lane_count)-exception_error_position+1]};
       else
         exception_error_duration inside {[1:((xact.data_frame_size*cfg.data_frame_width)/xact.data_lane_count)-exception_error_position+1]};
     }
     else if(spi_error_kind == SPI_IDLE_PHASE_CLOCK_TOGGLE)
       exception_error_duration inside {[1:(`SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER-exception_error_position+1)]};  
     else
       exception_error_duration == 0;  
   }

  /** Reasonable constraint for #spi_safe_invalid_frame_size_error
    *
    * This constraint is ON by default; reasonable constraints can be enabled/disabled
    * as a block via the #reasonable_constraint_mode method.
    *
    */
  constraint reasonable_spi_safe_invalid_frame_size_error {
    spi_safe_invalid_frame_size_error inside {[1:xact.spi_safe_frame_size+1]};
  }

 constraint reasonable_leading_time_baud_rate_deviation_factor {
   if (cfg.disable_baud_rate_divisor) 
     leading_time_baud_rate_deviation_factor == 0;
   else
     leading_time_baud_rate_deviation_factor inside {[1:get_baud_rate_divisor(cfg.sppr,cfg.spr)-1]};
 } 

 constraint reasonable_trailing_time_baud_rate_deviation_factor {
   if (cfg.disable_baud_rate_divisor) 
     trailing_time_baud_rate_deviation_factor == 0;
   else
     trailing_time_baud_rate_deviation_factor inside {[1:get_baud_rate_divisor(cfg.sppr,cfg.spr)-1]};
 } 

 constraint reasonable_idle_time_baud_rate_deviation_factor {
   if (cfg.disable_baud_rate_divisor) 
     idle_time_baud_rate_deviation_factor == 0;
   else
     idle_time_baud_rate_deviation_factor inside {[1:get_baud_rate_divisor(cfg.sppr,cfg.spr)-1]};
 } 

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_transaction_exception)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param name Instance name of the exception.
   */
  extern function new(string name = "svt_spi_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_UVM_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_transaction_exception)

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_transaction_exception.
   */
  extern virtual function vmm_data do_allocate();
`endif

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
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE compare.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation based on the
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
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
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
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   */
  extern virtual function int collision(svt_exception test_exception);

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  extern virtual function string get_description();

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  /** 
   * This function defines the print task for svt_spi_transaction_exception class.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void do_print(uvm_printer printer);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void do_print(ovm_printer printer);
`endif
  
  /**
   * This function returns the Baud Rate divisor based on selected configuration.
   */ 
  extern virtual function int get_baud_rate_divisor(int sppr, int spr);

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_transaction_exception)
  `vmm_class_factory(svt_spi_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
arFLxxwEGvfVKcphYHM8eOieW/rTRHrmL27GnZyaQCI/y7z8h2Ps18MfXGtRvHFK
WWEgzuWFnlaDa9slo8GeH7C4l0De53vzEpWdCqVSc22fUZZH8UI8iHusQs7RO77u
JyflTdvVmy7PFAg257qVUNYasbBtIskX4PSeSJZ/USM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 596       )
pjtIaZY/jzIFwezbi0ZQiitfh8tcPMGWA41Yx/rSFzzKqVPnQYyWNoLJIs3ATqyc
lV+f9GqBxXeA+KRhiYQNBEvD/WbBKJcP2gHw/7vxs4W1P3hmA1TgbcKOno2fCe1W
vmiEVUB1EIaYYif2kwCik8BtgAJCs84tKNZeLrkKzDt1Wr2vB426H1T57l1vfNcj
5e5DfJwPy6HQGarC0GXnLZqpS2DfnBagEXuDtZKh8ZtDELdrvf0qRK3Fe5N+6tuG
UizWC7texhYVtMv3DZh0MEJ35bjy11rqF1VstaoUWuzjT4K1U3KUnzfxGGj8MM4y
Dg7ap4bdYtgg0/61YFP5f6soG50TBX+xrobpxe05Lwmzk1+Hgeqz0+uV/7S63Hvx
prbZwOdGd1QKUnJHCnpe2OZUteQhpCphYMVJhz0CQf8F0cXwHa2X0Q3LCVGC9ldO
I+OFygQ0GhuBG1b9AJgi07u8E1vaqAniSUcEgxR8YTNj+fIHMpKAipAcP3lY1enr
9HHQxcNyEqaRLX1sKoXiAUJ8VWIgTK60szFCLbSRepxEPA9v/jrMyMA8bXIhd54r
fpzja6Qi4f166EZB1eBneGdm5iZ3qL6+OfG43llCzL85gbxMRbRW8T3Na2M4zyVi
Zc5WNGOXmvflAIlCX4i/xwOMNTsPnWQDwIojtFGdo9xs9mJ1hoXCTZnDDzqkxk9y
200+7nbXHu8AIbPUZ6VtNvyxCoiL/CHW8pDQ2QxkBVljWhkZsWIO1k/6zAdCrDr0
YcNVwSbNcZrhPbFHC4O8g9TLHCq+oHrGfz+3c6vbTWM=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
plLUrq8U0MUPFNr7qp/AfeeUbLHgq1eN0zERJKvoHBpluQc+w01UMncUivSmwdIb
db+7vKQ+NHIA5DBBO4NSexgJkLtoSS0xcJd/V9ihx2cJyljSj4bXTB8rJjyxSJIZ
sN3p4CkEXrRuhQdO8VfbKI/IA2bt9ltRUE4OSJ490m4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31865     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TRANSACTION_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Oppg44uQOv7AVibC40c4kwQv1tm0OM4fPVeRbu0SKuKBU9V1QdMHL/IWHLb3mRIg
egkqm5hzO78xZQJBZY8QFo0MpY6UHSvqTNCW1xtMeZn0WYxPJ2pBQG8C4ljNyO9+
8n8lImD/NO2N6tcddMqvBi/Bn8TnsXmI3HqDfS3uwKc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31948     )
DMQZ3syDFmUhUEQq72qJyWblTqRctX6wQZw5UgAaE4dBHMfG1Agf3ISMTWGESeSa
VThCBxCOi2A+qRp5P+Erfb3eddiIdyQ450vJSgySMZZDohV7CuH8QbSUheYu9YLr
`pragma protect end_protected
