
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fSpPeglN3jqjc8o0D0Of8IUn9p7rWCEDaUkvJI335rvhuqaTuUOB2RWHROMCf9PN
QmZQWLnPLQMj6CVW6Y1wlxjnI/Pf2oyae4A7Dg3EYQf+yretjxJpP5OOuvrswOjO
ngJ4Y+n5bsZ4G6XBvos9ypaPK/y6lNgx9eCBYdKhGH2e/g+a0fdOag==
//pragma protect end_key_block
//pragma protect digest_block
tvUSXQmpRU6r1LgjaEwEWeph0es=
//pragma protect end_digest_block
//pragma protect data_block
0TWegyiKbYlq+R1ZJ1nVIXKXqpsHvxWMXjb1wF8IISyFLoJpvK9OUMTzbhT5wL4B
ghd6kZMdlRT0EztYQrkeOTSvNLyOse8vSgJvMOx6TTytKN/tgnB9kswg/fU3cZm9
fJhY/WtiyVLlE20rOBiC46uRT0OGHRULsw4Bbw/wuRd5jMnEqAiFsy9QgXHyZw1g
v51lbSGNI83JbujhebfsDrA/ZRKShQ64/S1tuxNTtHAcl8B2KK6DUDVsOWu2+B2E
0SpnGwCxtiUGmjxWygHil97PmdOTGq7tFxfM5SQwS8HBGoEGTVamwBuO/AOaaLvF
iRdyAJOKjoQYF0wtTkPL5NfpyEa0idl4F62VjMmJ4JL9g+rVJRu6TW1+FCO7uVe+
Boc7v96uYN3Jh970Q3sM82HGmsQeOhMVQDBLsCDYo+jtM3hixjNLs7K/zeOYlncg
GYKzfHoOZHPeV3iGeCxARN81v0UYy8c97eFlqMaY3Hyt1KVRhbmhymmRD8XmXscf
m8cpj9keQH6qHCRY2LkZOV4uSFkFAaeiB8vSYrgBL1XSEzPSOwESifhihon2xlop
5hmOwiP+Ay2an3BF7bZ3eCQanaeOKcLDLal4WG7HCu1Gg2/f8fvF3X2tCMS08clu
B8LiINlP1XSiiJDBxYPvuBRlVAo7FE+txE1BuO9Cf7CxVnvf1oo4TLPVslTlmLQR
w4o6T04WH0uUjexGrq1PjfRL3+5iAMQJYL4NQyblF+bZ1dTjQttT1uMzYP7MDPR7
1SxNW19bMjxAcivHoYDQMkH7eJ19DNjPqd459sE3GccB5EQnB+sV5REG/Bc+hxOH
nm5+rps1g6QtCb2okJuz32FJCAelN5EWEZQicG6K9YS+m0QzxwKX+CtItCH0za5I
yCQtEMAcvsVQ4O3xWU8x+TT0OtwpnWPXlBDbTBH8GA+NyzTQp3Tmudb71Vt+0Sre
gD9GwDDLz//LUN+yKK4fpMbaScCiilfAruFs/IP2Dhq7PuhALOs2X8JOHqh6etjY

//pragma protect end_data_block
//pragma protect digest_block
Dd64+My7ZraJkmIferl58ft2su0=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6O9rWfnftflUlJtamLyI3UDHBgzuOSy+3rtoEVMhnQsVcAwf2/oTRfMbXg0Xe+fy
GceEokvcA5vItlyo7qDptrnX8XxtJJJlhOSa/8DtHIX9oV7IOhBkr4AeAf5tBG3P
Zr6SL5xK5zg7/anm1QYDf12AxjPZRmrpXlDw0wAUO2lhuvUR/kmkBA==
//pragma protect end_key_block
//pragma protect digest_block
1o9wcESPV8Ijn+LY2xnxWFbQxHo=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
5xljdtxVK3URudHgsQhIkFGSy0o=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TRANSACTION_EXCEPTION_SV
