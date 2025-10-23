
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

`protected
bXOI#/dd8&F:)@.?MST;+6=^:D)DDf]E>DG.WcIM[b9I^8?80RRQ7)<Y_KgD3_5X
/7IP_./;FTQ,NRZ&#DK)f&GOM?D^AM&O.8\CUDW361=1<e^O8[&36[f19a[K7I?Y
-R=9bBUM2MKB0eV^[4T<KW-[_F3.-U-g?:>K=C]Qb<3VTQ7eSR<J-4V&A?>_2JLP
+Ua/9>-&6)Z8&OEHfF3+NdQUOfOBM]-8<3:MGP.cBUQ/e>VC^O=R_\YFbD:0(JR<
D92e#8&HX5XDWUc.68Q4FTgS1+dP1N4fPD<-8#D<N=^Q5AVW6XM+5->DLF-KZ_)/
RaLTG;bIRF+VA#68^&QB(U9P<8YbJIP+)1QOSO7Y&^2Xa1(If+_=F:O;;SD#c]aF
EVQAW0J]4:X#(2E59_Bg+EKc0]dNCK]9S-L#X#]PNCRR7-[?BD)TNHe>T;YO?Z&4
V&]R0f]X8V5GgJI,&VW4YC&Ygc@OE?972^/4TAA[S\+/,/JeUAOJgeI[OX1<?I.:
3-ZR)@0C@FaZBF55\R-289QLX-Y(JY47FW?9W+D=8345,O=EE-W=<ScEBQ5<B=]g
6^PV.Wad16LJWNA;,.L^6WIN?KMOEgR->dG[].Gf8Ta[)[TSNMc18Da;M84J\GV(
;:N95AWIYBgJ*$
`endprotected


//vcs_vip_protect
`protected
<,?H#(XZIT)-^QeN\6#30M[\3OWX);c,S+F+GG<7d7=F.9]Sf8d#1(<DO8K;JB//
9O.-VKdYQHbbVIV^&..(-X<5B:OLU(.bRdU6<T;BBc2X?H(PUL7P^#>0NRgX,I-/
4D=bWI4eeT?C^.4/#5\b>WTZ7Mf<M=8RB:.Dd[[,OaZ,XACUQfb:FW<aeOA:DeaA
f(2\+4QC6<^TD#/5P01cZACB=XA=]XLP7C7D\Vcd9cOVZ^YA>R]Rga4[#L)e?,0/
(J,fB&JL8ee-B-4X5GH16?^FUUNQK(E[#eJN?[K#@bBC8B[gBE26gYb98UV@Y0]=
.;IWc(]8]>gA8]OfCb0\5cb\G?=YIFDNQ+A[>SKVXbCE5@FCQ<F,#>cZ0RP+G_M-
#E9/L_5?N+^U=EBV?K(B,GDGY=b?Le/fZ5Hd?DF6a8SG1-c)BE_7Bb7-(QVT@3G;
&)#5&bYH2MSC4=PKa,&AL20]1eENcIAT89>,93Fd_M=P9XUGHdfKLSST?DC+HV?8
T=0&HH8b/L6M68V[#FNH<-L7XMY9>S[QLF-[Z</K2KK[<#b<3gd#N9:G\.9=H=g9
Q^5Kc+(^d<3g[EJ(dDcSCd,UO6adC=M_]N:YQ2E<[0@=<GL)HfD8Q-Gfb)M.NGaB
LK@R44X]CeYQR7=GH:.:D)4Q_3:<VV]4c>UFM8JK;#dK]TC5PU7(KR_e>8P\HP9#
L<W4Y-d7X<F(1)5V:U0_>Z3Y#FIg,[,DH@#>dB(O^^_WJPY\0Q=YK8=1?XUaN;<G
H3U8C;/=9QU8+M16ZMQ++S4H3aM_gU6:\&F_V(/S).[2g7K4f6:\g=)S1A[07f6V
^RH@<W)=M]OYdK?O3J#2=C9G.GSe]g]ME4]Y5V4HA>:2;VOJ3[A5[5XaO#=CE?C>
,(-aa?&e+P_Q.LefbWEU&LDGT\+.;7Ve5b.)#-5ge\;\VG<;D\T;dZ36CQ7:/V>?
8.W7e+V=50;)/46Y+K_[/Y3<MI=4HOZ/\956_WA9eU5ZdB2CXH/Y@<Lb)&_.FO(2
B>>,gC=;JBA?e4Y2Y2QT2BI2YCMD.)MY/8/)G<9IVA7eGEUG1)+(g\RJJH)FV,LY
C&:O9ICC@d8,c#d_gg+_K<dR3aLe1:6Y+?L1K:E8XLK+>^V&SIU8Kef&f[6H)b86
dH6&1KZQd4-eaP&3LdZ3<FD4RHQ-??JbQQ?[XP?:#C_@b/XN]YO&^D3Gb]<PT(KZ
OJ5XPe@GIG(g4DS@D&\WVYD=[;@+J[<ge:J-=&gX4UWU:S(W_]0Z79NNV\VCM0EV
6AM&:T4RWP45PfcgDYEgJ<GQ>H5-U[I,?99#?^4U-Q,6O.[OD0.&eZOCVLC]HKd5
4Jb4^V6f+?@bc2I7P+IFBa@DdFe70d>b:_c3I3NY)I3Lf>d@=Wb[HZ#fHeO<\>R=
VgK@b.9:>dd&EU=Z_?4_JH7SW0cT>7?;VS#8@MOB,b1eU_^e:G@>T-+>[+/4:_]<
-]^GL6RTPQ4).V9H-U/[g3b=(XU;0dVT@.R2I+^(H,.<@:RZU7<I(3Xc7Hb2eg1W
e:L+&a8fKZD2W)[],ZON8#+&&@7UXC4-TaVaA6->&C(gL#Z7BfKR3\7X+MNBS?2X
^U_JXEWI&]_C7T/(XG=.:4)RKg=,DD+D1dWL[#I4]^-,9Bf?<.[1T>T2FX[5dR&L
0Q]a@;9F4MI22^dREfWYE238=KSV2]8e].V81Y&?cF3P1+=]03#WOO#\T3<8Z:Sa
S^90,@ITJ@#_]([fK1VNI3/Y&&HY/VQG721JLfNbT)=Q;JQ3Z2E<f;MJ5)XO)]_5
)LQae[@YeDE^DJY-A9@(5Wg=IaA_D#B?ZVXB-J8]=Bb;KDg#Bg0M-g#Y\Q;-Wf.X
L<1aSMCMRZ8QF<b0A2VL\(<-;8&f)7\F?]4<D,Xe_8Q+()-gAe6PYA)eX;=MG6dR
O;^b_RA,NIC=WR_0H?dU]:8W>#f/KBc2dH\EI@M.Z?,RKNaAMM^a0=W<?(6I]Z8Y
eH3LZ7G\FE&W5F1^&0gM.WO)Ce&/FgOM1(0<fD?7?Z3/<D\E4fYLQV.Wed3-aUWU
N;.#VCA#(_Z](^ZJ+GH>GBBa#K9EI_B+=(T:?Ydb=TD;YJ#2?,)665;5W;dd62LZ
<Yf9JY/VC=eW.\F>Q^WIaHd.9X)_^A47d&K9g]b#a-7\UTWW=5VQPN467G+Q:YRL
]1f1U/QR[^(M7(.U.cT>eE[f=G[,\U5H_,CF&599MG]-N2&V?^C(SR&(VD&2aL\&
N9.X[8:\dYN?<]Q=[G,P6#,:&>FV-[fIH]aU=&GGK.ZYG8JX&e/d6ZHM[;dAID:&
[)5a]D5G=)&XW]Y^5F>?f5)KW2F#\P5GYZ<T[)9ZHdGRT+bR2eJA=MM(?g0C_X.H
KYKUT1#&^KY48B]DI3N7Yc3=>IH;Z1GaPS?)JPT&[BKD+B14)7#^N<c_5+6<B>QR
UW(6gD/g\HJ\1:Xc8T2/YXcE0]7:6T2M>bDa[899NY8^KND?PZ/+&Y91U(>M6Q@R
B25Gae+?:bC;YUaDGg6+A.A)G7A0_c#beRW1ad8T6#&UR#&RH8U?T)EW=5P-5LO>
6]T:YK5bE&K>@AOIQ6PNSME:BL3Me\VOd[He>1Xd-<3OHE2_J&Pfb2_GR0Tf&JN4
0KV0&4#@D/gg0IXM=U/\^^62d;-OZ2G#5TAcZ&(8+]&52&B?Ydfe^I.+3T#Gb9N&
d4Z3CC1;TUe1G1MO7A>[M.e1?;,M<)eF;(L\=LKRfX_4_G5FNaO4Gg1b6L/IeL<)
80X#.[Ue.eU?^3W[(Z_\KS]JJJ74;N]2N6+P5OG1DVQ]7KIdE[+UY>b^3QLLA6:W
Y>c2EZ(3BJVBcBX+V?1(DK+&OcA/f>?>]7]:Gg.(>.&I6,MVSK4M/N\EA@0&A,JE
d+]]0/RZJL&L>a;FH)&15I22TIaHRNBc#9@3Y&G7Jf@VI&Y,+6@GH242a9KIV5+B
NOKH+XA#5eF\@G\^6BDN<)JSZ4G+.g0;6D+\3WcKc5R9RdR6DN6&&A0CDP#UTNRI
9>S2I\9LIWR7:[@@>QUGP-ZN9Q.AH&(JJN^)H=&E,K]D9E?bORULEc;4;<D3X=VV
/\4R4-b@Z/6XS1A4ZWFBIIe.Ib+I_0WQBf.<,cM7V.[X3C,?@_O;6JD.J6S]^MCf
G6a2&b^g+89@_EfP_\&CIV;80,731>-R9E\6?-/H<\)XAG>cPX[<99)C@)^R^.dW
XS8-0<EPYIXVb=X;Xb7TO]OX;Y2:<JM7WR7U7Ga=O>d2,]BO[VaR=KU-ZdFL^))c
FQfS)V/@:7d7_@4-H.VQG+b)-LA7>VD0<_.60,39S+MddKgER^\K#ZYATOc9AP1e
f[@GHK;,9?.?><X&RA7WfE<=cg5G69B5-6IF1@5G]A=&FE02312HA74RNP-DV6^O
3VaZ8)T8XE7=+b7eIG0BJ^dG=8PXgE(;(WD+)\e&@Q25HORgg7\U0>dC]1QWEQ=7
[PUXaUMB8_)&]M\J1II10\O1BecfD-@@G;?#e[RMPG\,f,&cD]L#9]R.[B#G?3_P
\C64O5cOH77GTD[(/e?H>T?MY.EbFMb0De7,M?g=3@0-a9=CgTL(BZO7\,0?(5WB
V#&eUaQc1f3VVR/M;#[IO9=W4/9]X;VG.+1.+-0CCdcS/U1O-MH;TVKP0H;QgJ35
QGSPa[QaWO_M>9E>6eG@6[_R;IW2b.W+&OGEa#H4.Z?D5,Tcg>T)?\3QT?;_A^gN
LcI\>dLJ2e#X-I0>H8AD#dB5/4P&W>WPD\e#&NB\_8&C:aG_e)GOHZTL72V\3,5G
AWASKaM1919Q[4#ROd\]>2C;R?L+?bPKX2Y-bC_IR:B\LbET;)e7ZfZ#9O6X:&RZ
Ed/B:dO484ADa&2PA(g^;CJa-#RV7Q22B^N;B<A#,7(bF=dC8391HWN_>NF\O&5C
0A5M0>,G@=Ra[#YQBR6c8+7[8U599P4T1[FbOG+UW&E]gW>30,^_@@RE5;#dG2Be
X<d;X&BgBbG7<K]TeISeJ:JBPgUTPege:N)RfR99fWD6-KM+<;VK;&4KI.JeKLYf
PdH3V>f2P>XE5PZ[]X06)_,gX0Fd.>]K:84S(8ZEU2)4dQ<L.8T@M+_AR=&3S>I2
O3Ef))H>K]QU=3I>?dYBR:@5Sg&f4]S.7deP9ZfVG/;A.J69P1:[RI[B_F27Z(XI
E4[#ID/0.;1V<=7L..&g]A(AI>W,W93T98B/I.PW/Cf=2gQL\=Rd5bD-RGAce\R@
1Q-<Y3?a\>CPcSI:,WL[L[LDI0289F^W,SW.[0B?U6_9dF^772X,?=Y=d(VdcL03
N3NF]6EcP[2/S5##HT,9-MbRD.D7K:\f_/54bNg+?XV1e\A,]NZ726O+fT8/A(ZV
_QE+-eWSIQ/G</VB@GL4e-],NEI8Ua4Q407DZ#T#P<1\&47,^:-YIJ5]7Q6E&,Gg
>c(+>&f80<O]P9fN&/BfAAa3X4&KQ<aP]7MO+UUW2E(]AQT72EUI_f9#10dB@2C&
dfW+5SX+8\^FWHO>@&93GIO_(B69;H._X,+U4O:C>ec/#2g@,S,I@ER(dfW&X5AG
g&D.\N_/_&K@g/JFcN6e_dbP,^+SR@>LRdV8+A(]NWKYbYTeD.KY)P_c#VVX.K\(
-T:+P06/FZe9[E)N[=FA-ELN+K,BJ4_2ScDJc7M.f./YS22gD:4HM059VL:FbS&\
US+e/c.,fb<S2G^ZKgb/O<PA=1;N&d[0WVLE^eMY((D>?J#dG<UGCZd0M)4+-gCa
4D?36N/:#:UYGTH3^78Sd>UG-QA_6YZWH4D_D5]LJOcFYXGGSVJ),ALe0VH[c1=4
C6B60f;0MCU&7QHGfMe1+.7-9fJcfO>12H5A9HKa[99K8L0cO:;+8R-f6(I^9+[4
3DFf=V0a9>/C9A0FWP0e:-@1R7.g85V0RfCUH,LOX#5\6MSbQV?C_:>QI63Q2#]9
;b>1[e;RWda#WF+KdP5B&M1QIR.:;,:f_&6N1Q^3)7+@^HHK>aBC3XXb(WaGV4bI
N\dYU+S=+YQY+?)0?)c=G>=@5F[TI:f@#WR?g?DH,YCDV2[gSXG5Fd42f(QLXB,5
?TMg:@CeS@XS\)\2cRAYePDS/#ZP4D\I]<D4Xf^52/JP<8^4PTZ_c9)SO-P4HR=g
[V[\+9Rb3OAEOa^^/(Yd,RQ)7>?_)O^ff3Gc)6eB4KHISSD\RU>[;>g)&3g<PFNb
N>8_\0(9T^bF\4GH[3NfaR#1[@_XXQ7b/3CY1RLdP=f+?N0BH;(f:+DT]\IOU?e,
1GER_.4)2N)5:ZOSM.Gb#SB&-#\4V/4fQW(-ZgE].<97]aEgL4]C;>AHQKRVI,/.
BFdEfO#0@:6b7f5IdV_/L76#ULIY^=MV/#^1;/TVfRRAA]e(aH^f;]LYO5eW8_,+
@c=9[3.EMEgAc&?/TfUc]1RU0YM<+;_/F=7gM(],:^RV@\&.gU]a)EIa1c5,Q+f(
22.L\_2_BOQ7P=J2c=H.)PIXa&K><feYOR65JHW]M9.+TU8O9YD_8:.HOPP1795&
SYDW7)dM\.JRSI7A\2LR3\ZCa@+^AI;b.?7/B7Sd1I)DPNURZ\fYcEGF9:#UY8c#
QH5ZQ5?#1O;+?MQ.8c]]HURKFL(Z5B+cHf,7;(_dW(-@01<cJ.=@Aa.F));T@aXQ
\fJS:_f,b1ICT6\W+IX]_(G)V3A<J)dT]+OMgW_3ULC?Q.FC,C:d7>cgGG:K7GWY
U:RA6@6T5#Mc&F_M=<-\c#>Hd2aWVb4O6MS)1fK7,Rg;__6L<8=U,#P-<OWd9BG>
cOBK+/\LFS>>)(e:8C:U@Of8JD<0H]cE\\Nc@Y1=F:NR[V2^@F0<^;#e(S7#JMI=
[&W<J4(VBfW#(?V4)-J+f;8+a-M4K\^]K</4&A.UX7A1>LU>e@>;2,5F5+SFeL&W
,BGY0=cfM@0(6.[<GY-@V/K,e=ZNM3(7Z=dbQ^P/H+[bYHd6Fg)2g^N2c@[HMgF-
daN8F<.KAdg.^QK6;&?c)PS;_9F5J7U_]-Ta,\Ec>;a,TS4UbN]f(K787HV:O=[>
/2aJ0f,9&JdOI:8\;X/HQg]C^]77T<Y2KZ7#Ba;)\b&a\,)@)((@QF5_H:2<TDF9
(ffM#O9V[.Ib,b)8fHJgGC8^99<QDH+XRL-49d.>?G]L]PVD(Z<@X6ZLY>((RX07
G_]?HVQcWW\&,1Za<F[4d_db9YI,[+D)V_9M,_Hgf(g@J0]Q+2?H@1LW#_+\g=K8
4>UN?S2D=baSO?@:#@:[V6P18f3DLTA>d??FX?CK,URH0Mae/T;+>L#&9UF,#L6X
7gI]>a/bAHA].<H:[FTc_TT.ZQLE=Wd8E>AKJTXBBKG?DaV:\+IQT-4a^7I_a,;;
cdD]9[;OJH)R59QN@=aUDX,=8S3=X5a=.\-Q8&0bF5N2C15#+Oe^W=Y>2]6)0_ER
Je6.CRQc-])FM0Q;E9/0#?c(a5:017Y9Ld9QYVP:[d6Og-.?1=0T-K:;(NA&L:>W
b(dfQW#DXC>_GMD),?gN+@?X+fX7bRU=_Mc14_G;PZ2f:aG0N6DQR01@J1eBb@W2
9@A8R6?@MdGaeX\^G,>W)b@=KMMc3B<\K[)VVc5#14efd5&:EJQY(ZK#fc=\N7/O
7gJK+7-T5Fe>9J#4.aQK=c9Yc#J5XB4QHX4ZWFaM[0SL>-f98](PHeI_\@^0P)Ac
;C(fW(g2ZOc9JVUg&#O(gXQ;NgL9LJfUA4+Zad5UK)5gZN00)&0Tf8/(bG3Y5Z-P
Rc;9Ld.H.@HX1:eN7)^<#IW+IT;S43c\9=Dfd#U-)K6fH,,6CD&7cT-V_CH,GNf5
cY:89c2U>g.WbK2#>ZU?K#]K3>DIA,PSI81W)X@,>W+f[8_8#L,?W-T2Lf>V/_O/
]O=K0<R8NfPNIB@\-\8]?L<)Ka6Jd)MSI8?TSJ&QbGDI17]gQP,ULe=XJ8gFZ/C:
O9O3H87ZY,bO19IW7Ne#<?;3S#MTNZUY/Q^b3OKIX.aAe@XV9[5AGF>/HR[Ic^<W
HP\-@-F@d7bN,G>3g@YD=7C)GPAAS5ND&8=KcI&WNVVg?YId>dVQR=QYW7>1F]UO
W_ZJ1HGMC>(.H>5^EA<V5H+A]e6=?7G2<P#6^gT-.f&4TfECI^_I-QBU+8C7#)X]
,Bf6,]fG30WKCP+6@MgJ/A-\M@L_&d51K))H#::S4Y#1OCHP1bd=_gD-]_9.^):^
BVJX:EBRFc@GLeUL6ISCIKF;?YQ#I]YZ>TXR:MRUIdM)8SL],XW4YK,H>S;VeVd.
d/QK(37[#?HI.KfbY=WfUF[,7)c_7e8(eZIVN@[JK+]+(CLaJ;)2.=08<?4<\:E&
I6QFOBDOTB3Z0(9X>ZVOYCQR_.[/QY\_]E/5YQCeK_fJ6UY]cQEF42\F7IYI[L[N
A\G/?UL)Ld&M,_fB=5:ccJRCeW;C8fMG]]Z(_)Be<Q=<+H4@\<[V\Z7/83W<X=BX
LTG#RQ@\()ZXcTX-OM.^/4N;]Q>Hc1RJ0;X1.SX9<Ua&>Q/44AJ+R0#a]Y7bgV-9
E_TMI?/FUTP@5EOdQWa28UYTG?e=Z7=?(H=+5Ce9^<@Fd/#6d6\g<_a:F49>-#Y<
CM<dS:1AAYdN]+04)gRDTMZ.fSLH^1L2S[MW5g&1G9L\O@^ac.)fg41@.\4f#S6+
<DWb)G?7W@,Q5cI&B2P<C3:(=d\-GC-+P0HCB.K8H#dIQMH2J^YH<G@_1DF4eVA6
9N#DI#:+M#aXMI694,W@gfe&.YQZMa_#P8c,=/I=::F^-TB:U5M[9Gg?@/JP)Q1L
3_RDc[b_WAOX8/0K663)8Z(RYdc^ffBCe^84P]aTeH3L]P;A/CC=>#\\=(GO+\=,
7RZNT@H+)+D\7YR4egBc6f]edff^EXF@2b<@A=-.cf(HN5FW+2Z11JW0+58K\O\@
P@eELFSLb3cT1:7?&P;JH\/L(9F_9V2L]6UbIOQX&+0XWT;0EGT90/+>dRdY0I]_
Y]ZHCg;T8]e;CQM]=NLPQHH&AG2H2^W2f8c#5ZRfUM/QJ#\D[gQ7<\?/UXVD6.#J
9bfKFL>Lf]M_JC7Q=;ZVCF6&[,fW\eD4BTB=a(H9Z)Y23F,+UcKPKK/N_=GMM#cQ
X>T66RKHENF:Z@.bH6Q><ff(TI:4NfTVL8ZQdB\5\b7Z][Cf3AN(>JLeP\Ub9@M+
dHE>@96fNQJL#TN#B;1Rfb#R#&5NWBRG9C4(9?5<_JZSD@3c2]YLOZ^=7=NfZe>\
Q1\O49KLR2_]TX].-8fH&M#1[6c.LV6AQMdC#_#SAPS&??U44g#QG/?5?CKXRY6_
_RM/[MM>4@6::3^DW7L/XR?CE:J(IL@7M.HJKb#YXL5O\>B^8IYdX.>2+\F1UVF-
2VY:7+]:g43WKb>FH4,G/^9E+-9[bdg37)PKf4<?4CA58/+eRY0^K47E:eN,(,[W
355?dQZU<3TbS^;HGW<+3e3&Q.KfE,4/?HK6GS;VAPS<YU8F?9V1QHI+gHS3c5d4
WM(8+PE2[#.F4@S(@TC:4&FDI063?AI@/;W]8Y-bc3dMTVd@;e7BFV?B3N_;+E.9
c89##-D)/5C]H1Q>AbICIX>N9Z(9N)<+)M@&P0J5[WLUK^5#U;/gea7H8d/7(V+=
1\#,=&8_c\\c>(-BH4B0P=REUB_e]VH=5^]0Z2_b-?&M[TQc,?(GA&5E_79]W.I&
EFfN-)DZZb0][-7Rc]Ha<SgK/>f?@U+HWTCE0ZNWSQAR?b:G<OR4-.H)\8fECR1F
FD<_Ed:=FA^Z6dWT0W@fJ<CdW3f?PXg:D\Bg(6<HbD))+,W@95#PGX+.)F#@G4+8
ZBVUDI2&#GGI;#[//RTZI>;(;IGEWL7LRU&9,YV0D(=[W[[fd,72Ja:4>[BE4-53
57Y,d+&Q1>#Ja)D1<SB6BW\f-8AcR?<OCFaO44X[_<Xb@?NL^6B7D&G;U-P;>Bb6
G@aE),BCGe<c#W^^]9:Hd)I9-1RWC&JS:^88@#<I2[WEeY13(S_W#g8[S-@,Jbd\
)4eFfd0=D8cYE?)g8DYL?,_XZQD;1a97DRL6G]@#2+a\:J8P#N+8W6+;X)(;B?c@
&aN.>/>gLa5)\--<E#,<./,J>A\LI==3]H5&&UQ8UYR4L@99JZ3+/[QDIa<P=X5+
<@+Qb+dT0dd[d;cFE6+ZE8^D6\b5>c;XH#;PB7+3RX7V;UfWHUP[6\c+c5VH.[[,
>eCDS/O(3=&-=FPY2T(NSUcH961;)L\/=BW::K.f8Z?>E(L;:_ICS9P(E50.MEfS
f-E@6J;)0QT50,I:_04R)O,Ed^MJ))(=IZIK9e-3^gP=IBdafGP_FY#-(&N\4g@I
gXIUeR^][8fPg[<X<HNKWVcC_Q;;EP@G=;W5f]8J6MV=eGJY37e?R;N9>/0H\Hb@
=LG3<A\VXWHPI:^I<33d?2X,JRf)214W7>@=4&=,7D/2:)B3f+])NT(A88Q_MN]U
TE:VH#--P0@]J[.A^W:#c>T^C]UYNe^fXOSXP,TJ1]cBWG?<1WP8GD^Z;f>=WfT&
:HdY?J+>O+:dFAd0[95C]H-HPd80GB>X;)8]7.[:C[3^YN1EEbMBEGK)F6N(8S2?
7SV)G:]b2Bc#M-;H)7TVP;Y_B&O;X>2]2eL/A\^B7OcMd<THXIL>D+8(.>f1U@+R
J/W5XK=34UV\eKK>XYTKB+MKYRT)7f37FHe&4geT7-R+JC+dO/T_eE38C@fg<8@S
JX2^[)f.Q2U6#4&Q>4K4ER^79[H7HWPeR,^I4CNBNWCAMfLQ_D2.7_UV8:3Ne9+P
X65)fVFdX:_bIJ7A4H[38J92[OQH^aK[LeSP9PK[VD[225NXL5U7:R>7cY:8Y\(>
OD&=@b[I7CZEfRg?T1;,f:\X4:<[XaWJ112V3WE9P@N@-UGAaE@E4WT/c-[B;)+<
:=(H34P0>1L89EKVbUZ(CQ_b8Z).R73ZU3GR+6[aHUSa)<>J9G,.CAV@e-XZ189U
A:D#?=:C47JV\GVFP0)_LO?\3^GIc+_PHc.e9DA,DR^+0O+eK;T.JIb>W,3-Q:O/
X5=9g^(F@Qd>Hb92:O9H14\O+AVQ>6NHZSTMP;f_[L,eMI&GF68\./YA\&CdTSPN
=/UO8RX#-P;XM.P@]Ud;(YD?P&GgcSS(:120D.@^G2N6Sc,X1a;KM]:K68VYf[_=
2NOO-.PGc-VF86R:Oa__8\N[2Y<LJJH0>DKBE)O.(NFUW_b#WWSB0HD,[+7cPe^R
UV5[INbP4?_aMMe4IJZ=SN<V&EFd:K:De.56(3H1W6966=ZZV1T]_P[A\A@Qg6-T
1J_QdZ],9a8S+b+8c^N_T;V(gQ>a7MLg=O^3>TICg]8Y77F@H/1C>@=)e5<c8^05
8MX9L/=2a+HQQN.Ba9H3\FOf#@[.FNGP,ZY^P(]>U)Z921/4f)PdbRFDQe&>J[VC
9)3RA[/Xc8NOB.JSS2-;VL/LZeZ=8QR8BaQO^c&;0MS9a29.8YE0=;CQ^HB7=TSM
cH_>fE+EU85JBg(\M8U4Ce-YFVLc,ZU+4RN2bS?4>5,VT1VGbSMJ]U^[SH8T=IL>
?Y39<1+P7g3^QMBM4H<BU(ZJ:D-_66SAP0M]C9cZ21D::fc2DQ-G/@O0^-P.CT;R
2eEe72cMcEZJ,P.,>b&PCGC::2_)(W(90Q^7GBXQ?7;=0]_,H5Xdb4;cb/O(RW1Z
BbZ\&d@e(B]FF[6\5=_3[\QL)UG4P/#U<M8\LUK;^?7MEF/fH9@cJ)8Zg7K5[=B_
GONb.e<2AY:NMJ/7-2T,g0OU6.9d/=>AX8Y/>A5=[g9\R=_Vb-PF:=MYE\@A1C>>
:#S_D7N6^D?4,Y<I1cK#3P^a)Z_cHMPVVWL7GTS_><?W/D?KeOUVPOb9dJ3g[MB<
V/8@Fb;I<JZQ^[0-Ze6+S(+I1E-[G=TQ2RT8Y1EZF.C7HdNMCF>?N0OGeIS_8S30
EUR6Q2;+&.-DYc7?f(c?b1E;Te8]7]?,(4K<#_2f)DO1<@75P^fO+BW@f?BFSfT;
]g#ZE?bPSL8TGL6.a4S+[:-T8OJ;MK&;\@8(>PdN?J:,^],dW-Z/R\4K_HMF7]4?
,fC+&Nf?Z?7XcS:/]:UAM-fN27S.V:]RFM9>50G;>9^F=M6;B9?E13Ud4cc-GFGI
ZBA1UBI_2/)7(GP>dI>H)[C0RDN4f_7PTZ2dN9I#.9HIKfT9)V<eg[;4L;Y8,W]E
NR_HC\AA)fT8-Y&X+K[Ve+07R4f#A2DLND[9e^c?J(PWVC3ZYgIN0B>[TY^V5Jf#
#9gSa&2S4Gb:L[K(X1-K.R5@cN1FS@S#=VMZ9Gc3NM[aQ+PS=:\3dK?dR^WZYI/[
9]=E/.?a:JGK@_CA0>_U\&(?O6.-cND2B9HbCf.PZ<Va.SU7Z0D9EDc5Z0LgF)]Z
_Qe3KeC<K?Sd4+gFbg6>bWS,RL<-1@M3-gVZ/1g@.DT.]O_Ce[6]#^J9:OKeQ8^2
d)LRf<1<bU_UDGB&9&f+JQ9L@1aa7e&9=HEP8COMdCA)@=U7+0b:L(>I[8g)d1@[
V5X?H4./BM8gc(6FJ)K1M<KKagAD.6V=;AY@)#705agO:RM(Y_=W(bBEJT)<c/X)
;F=Wd1[aM0TAgbR,2QJD@.VES9^=)JH4WO03^9;@J+\(VIaHY=3GQ]OF<BDL^4H(
I^ZS5DL4E_bZdDS53)_WbC5QG2[PG_5^O+EF63P2Sb2,U:3,g@,a9#A4EcNP.6aK
2fe&,(WQ4E?DIeCc_XS<(SZRB;4@6P//1.Bf2Z-9-KXg4F[X-aPY:>]]G(;\c>IR
HY9#AP?E>F1STM^M+>B4V&8:)=(\HQEJ/^?e[]9V]3)DV0&XCJS61UbZVB8gH]Y=
eN>O9WA#.MON9eN>]:0g/+XV1X1N?:+e1PcMR2]:Z1I@<EUTK,5L93U+A./g_;>a
8]E,X@/8eJLCZSFQMUGWb^=H>H4C,@=OagY6FM&CT&OSHHa9MMFIT)=JFN@/4X46
XB4>-N49<1G6,+)HQW_dfGNO#FB-Y)Ie#d0W3-=IJJFXVX))YCU)aJ[M+SE2d2-G
0gB@K5Ib4HTbd&f/=g2<Xb]Q[7c([491;P>.^MY-F0ZQ#)OLMQ_;\M]0)+<-PGTN
SU1_I0fNOQV^bbUIBVfOF7-GBKcg_c>)(-4L^P0<4OP4R?<CLF@JO9803MbD:HN[
>=d@?FGA<ZI5UcM5KXJOOE=206-=VS8T0g1J;7ZYa3f-aPPNNeG@^+\eB[M>J;[J
.GPHXFQ+UV+L?0&8#627c[,J;bOV8.0@89W6ae<@6J6=+.IL;Xf=eVLSDfe8OQf<
O<Q&BgV@_9N^7ECF@8JMd?98Y=^M54Da(_Z?@A0d,g.gE91=5.3:B;UM(MP__^Q1
M1YGLeX\5#K96XaS4+U2-5XZ_XAaF[>f/<C,(Ud<e:\.BRQTe,0^B2e2+?Z4SQ]E
5(C?CF#EfO9c/(LH8IF6]SFYQ=:cbTS\e=+2@P7DUZHEQY_OEDOBT#@0@G>gR6?/
:(D3;)F-ZB^--SU8:[C]L=BI4O]DWgU6\2ML+g#Q16W.cJ9+DP43#>)Z<?d2(8Tf
4P4V;g)8)//^R<&C>R@c)4.2IU8-D4_+][[PQ_Q7_^\?G:@(VgOB<12_5B0YLLNf
N4^MK3X]AN7#UaJ[<bT(2>G?cABgg2Pc))VF^7(TS,Q;+3QI0KQ9S=10@YA(^&a#
WVDd3<=484<TB.;RD5;5[(c/6+ASa9PBNa:RHBHfHa379E5@B0fQXa?)(<_>8d[-
MMA@cRY?23c43&4-K.\fTdC[1?OdI(6EHB,f8WY6c2a)23B@X1]@:@)-bXN1@VX[
(A@;7?T+)GIX-d5Z)dUQ]3M@@10@]^6M)CSU0RCR#Tg9N2=@LU00I[f@HcW4+Q/F
c,A[Vf)I7KEdGP<S.NNe/O;fH8L33a.LRKEHeKKOfQ80.g879T3J7BF(SHbO:7&=
&@gM_G4b^3aG=(1Z1KbRd#M<04R.Sb>CWJ@<Vafc+S_O?c<[ZG\gP7)?7e<OR.0\
Q?HNA24#DbD^R,>C9</(&Pf3&&(Y]]=_3fI6+]_[:R8>N284b&+FY59X=f2LH;UU
e3DEI7V>e+AF8M^d:;e<LM8B8?T1K(9K@BRYE]@6e&SD^?4R2D5IGg.3>NZe6b3I
(:Ca2L(.6dVQEedVU0OCSGVbDNS0X7EeN\TRA;_AJB\<K;a]PN5<L<=5IIS&+9SK
0&]^\fc[7df9fH#FNXc4C@X7MWEG7/(JS42:e(6/0B#L8\QNYUg&AQ[\IUJcQeH#
^(I8I86<.<-XUUM7\/HZdPW]_eWaH7C-DBK-YWa.>1caH)V:KbD?\G@OM[d8FOB6
@V>4XK@-X;_E)<_QU?XbKS;>N7MfV@,S<CXVa20Fa94,Q92CdTY3c.b0F6e(+31F
f&ED&g4bG9(R<d7HGfLERQe^2U@+ASR:8^)=DN:<d:4GBReEF+0>0KNd#YU;._]d
-74F0JEZ5S,^0O/J0=[+5gVUgP20U_S8BgWO;W;)7#,)JN3\BfY,^_ON)3M(_F0f
5-[8)I1@O=Y>EJUWC:5cJ6g5XKG&/W)@=T#Y#CZ6\cIWBf@L(O+KM)IAVYL^ac^-
]WE.D0(H>-<LL>#DSIKU.B/&/8_d4WX_RDccY_F.P,MAF2@cI+((-Y=GOJ#2I->)
N?eVZ))6D]4b&+@O?cT^E78X8Aa>@5+J/bU7>d^XLR3c875#ZRgA)&3bdK&[:F-:
f,\?XNdCgfX=/.#^<G1YBD6#LS-SgL3(3XZf^-+dMBP\S=><1]K@AH?<2M#^V/e\
BH2D_F\Y(2A?IAN(-:)L]c37PZ;C55;a=U#C:DW8J>Ne9bBX&<Q)@IRagJVe&_c(
5F>ea>?+I66E=8[?cSJYKEKSV4DIUNF<HG,,6d,;38Z,U?DFK;=P-R/XR(4H;WE^
X.XY76e?WH7PM/6>b,WcT[C9C_bS_J/X-S=eAC^+WQKRa4]/Pc,0X=4SLg]WS8V<
W)C>0+W>Jf1MR)]U^U5V&)3X37EA<VH>d79^B@-[YdQ5P=1#0]SVCOWUJ[4MBg[P
LVe&=F^=NJJC?9/UASf-@@/J9T^DcE/L#94c3=PE6M)Rgb+/[P3)(5Q.Y8;&4K5b
b9RXdUV@YOXY[>8_TG47H8G9KV1>T?;3<7F3=E&8a^<7YfS,E?7C5X808.GTC79:
]<_\[=_Q,4SWENH^+(g[<(^DJS?8T\QR<A#KF[ZZ8C)K=C#<V5J11F=B+LEE,b:S
fEd,44RUNU8/4&VWCVVW2Se9GSUE3CIe/)LD<@ET1e25[Q<B26?0]=#4TV5IZ5b<
9AdAR>E^)E#&F]:f)O>aW,WI:.OHZe;b_GU8Q1ALQ^XY;>1CMSAJfg.5#g9&aWCJ
]T9]>:H:96VW6LcQ+D^B/g88Q?f]c,@1850+.2N1+f;:C\S3P5-ZPS^^6ad6E[.f
6M<>AQ).HZHUZF\d+6O>0T)_RVXTE)WTJ@_IJIccNQ))6.O:BA\835DAe,@;/:ZG
UY3B^/M6g#8^+WE6[d?<WGQ:8(;=79]#O>eQ3SC8d[S6#:K9/Y/=(HE5=+=IKUB8
L\gCY13+0K0XYJ+5R7.YWSb@C6aKD:+A-[L7(^caK^:aJ9JM[QObH.T=/#HP5Z3M
I;.Cf1>_Bc8&+GI3gc7M#+=c_(JO0cN2]FKG;M7c.+;B8&dD[8?9cCQB4TKa@NJ8
FF,:3&6M9D/eV9a;P7EP<ZAU3(7<VdO4[GY:L4<O^)eJ4:+I/f1J4g&T1X^0??P+
H@JE;=E;SV[T(b3MSK\X94#;906OWTP_(NW3H\>B3Na6S3,9M,bL-fTCJL^^9[?H
A3I#HTcJI<XVOKRP0^?-&bG2^F1/0LUYBI[cW#a1Q?IQ8W?2[CV+e7-MOEBFKS/f
fa;Ze);&1+WaVgBZ][X?.dPN+H&,2KUbP&9UL6La\8M\0Ae^SNO0S,/;.I0IdDHc
0)=+#LWL>Yb0,NA\,YCee2g1URM:JQ<4=:EKc;=(.MU8I7PeALN+SW/@RAQMK7a4
b@b>K1=DL>g9X1F/1OM9NaI@d/1HQ^GZZ5Q=^S_e:+Y3baC-L(A_(X+;;8Weg&@2
J&OJ5.II][1?(_B),(.ZFFK\3_MfgOaZeM#W#5YZ=#2.W\&\Z)_X5ED1FF,eB@2L
?UIGUQ,3SH2f?)S7#&YUb/,^?2NE:UIIL\Q0G-PIRAgB.2()_G,9b<<4<_[S>K5.
bJ/8]8dV(S[C(/+PS=3P861Kd/5?0[6K\9/.]VQ=]<2R,dYTcVBgHaa0CM6>F),W
6]D19=_TTe(=7.cM5W\\]LF1Q-@9(B4fFK?E.5J16.I:N#1_d-1><5J4F3:8UR.\
?TW5?dHE@T5H#f_OU062&)S+)+8Y8=>NN_>PfENfdII;^QIfBSC5[^b-DKVPP>,[
^65X^^GU72/KOD&P(\>>>N8DWCA\T^H42D7:c-K.IUKg_/P/<=JM<EEQZCD-YX:,
X/@1\3R2b;A>HfegF=0,N4Ke3_#0\eRMGEg294QYVB&e\=^Ie2KaL,fM#@K11fUL
&@7g_]<[UYWUgI1PPC&V+>W[<PQC]R_?.CW]MNC5=eA-eQ\3=]g_0bS:U24)FKbc
H<D5?XQZ(Tc@7QM:V4Z9)b.=SG@+SP8T6g89gCUcPI0?GC?c3cK].Y]RcOGP0JdX
1-Ae:^+G&)#DR32;/D>=P2g0(W4@3<+geFQgJ.9^?>I+J7\]VWA37FZVZ3:@bT;,
RB^_K0B-M7<MG8-/[+;UO,SfKFX.b9b\XKf_a,M>KB.FOTV,d/@\0]SCA5\[,9Va
O_H.#S17+CeV?I3X0,UETHScd+QL-\&B31&+[3+/f@\e@cMGFb8IgOB23;-O1C?V
PH>-R>5MQ\8a#2Rba_bK#f3)b2N,f1BO&g[&,FQdRe,+?HXOH#AIK)9(E2@V>f7D
3Y=>(.>S.a+P1O>C9aN?VZ,DW&KKRI6g_/WO?SZDYHCbE4D>[(#^>9L,9@75\UDF
E8W,>AO/_7QbUW+@M##]O3@a@+HM4?gO&e[\]+11;^KK,fA^a4TB^E;06g+5LL\R
.X=H.=PU@OZd5W9+,EYS@LMQ2dSM[4]R(7];A+9^E;eFK0fXKEOZNXO6\T2X.g21
[U.4^D;5>TS+:dYaK(22VL>@<>7PMVW)N\3.Ca^7\_JR#=N+8?9,86=P>#-,AOfF
ZHU\d7:YUDbLS_1Hga.U)]#f24FK=P:@&Jf,B2c_,G,5[0D5a,#T&KafE>PNb7)<
O]36VT<],+6;BDS&eGc91/f^S9R>#\:^e]e@d:#Y/9Sb-/;A?WQ\dd.Y=7]B/aH,
0+<;d6JDdMV2T/#4J+4UO^A1ES-AI/Q(^L;9<&F:W#:3NR95YL0HUdf[I\L;O]>9
(&7W1?AJ^\gcRUCg5Vfg([V)AgOf]B7#,C^8&gG?UDXY(HU2PeTKS5]E0BNAeW).
YT_bNLV1\/V.\ML.=<EgE@O?N8dY-XT/\PLe>LN7-/6+5N(9JDVO^KHZL8:E^fe=
F--:>\F77:(U=I6=e[C9.9^#R9B,G,&AJTK1(:,a7MB^<6QLX-1CXV7W2^fDBI>F
\?&6ge,6.,Q[S\J[YCPKX6KcHc_LcD^L<a>E8C[9a_<0B\c@Ac<>Z]dT?LV7fL6E
&D@\IN757H==])4_O;C8R[32@KV:91bY94b=^7(,SN:>\g.+@HeF5@L9DN^M8[2D
5Bf7[A&B]>6>ME-=@.Ef63O0f06V\B3)Na_F.O;_OG=gZ7H,Q>](MF\=&/FBEO,b
d?gV]+WFFG_L195Z2#[O71:0)]_:>(#FCX/cNJFPW1Q&Ic+K5_Z@T&GZKf/3NgZ_
[#CB9/D1d9>0fN(@?0GE=43N/>Z]6&La8]ZBTP]A9/3[1HgPN;BI)\63,,K^M>)d
51Pf(JLIeE15Q9UBC3D?ZF8RN/_U4,a3UCVC:F\8d3-D0F64[XR]:/)@>^[3gF3]
B(?EOJN]PT9_MY=Kc;XY\ZS=U-X,cIcGO+9cK.3)I0AZTJ&6?_75,<02@F-1:FOK
:I[FHC\&^>AF_Q.J<M2;,D:b\e7\XK\A3+M63CB7@0J(d8>@g/,&6373b75&dY_g
2+=GM2=&R]e@=L20f\AEgKfQDL>>HWSH&0;E2Z.]OY:]./5N[W;cBO]Ag;3b93Ea
B9>2)K;/fSI@c@HJ=BE==UPf-08MPcAS-Sc]0O)R\=#LOF2DAV+4eELD0DW1dBE>
716b>/0&YF0?56P^8gXWQ68BaWaGM;5/.g)=_UO;c>.()LE^6CL-7R?L8I7,DM^Z
>@4^#Va)BcDdK_[]G##\UB0Fe/bE=d\?J^3W2B4fd&fRgXN:6bKESb^0+f\c(M5/
LYLSVP:&)>AJf?IZ7.\B,<]fZ:d&R8JK7PF[@1D^H85I_aWZXJAS2c3,/(3c]C3^
][TCM>=620ccV8T6F,&N(+QK:P+UZOER[Me&C9O:^N[?H;.Y;.dF[0:f1eB=7c^Y
.TUH>\[gf4U+U)U#b.9F@_)2X<P9G9e?KSR0YbKV.C6Y#W9fKDSe+T_HgNI78MTJ
O73=d>\1D6CFF7HR<\RfcJY-CV?S)L26MA.<:cSY]gJeJce@T.@S:@OcN7E?F#cU
HAQ6A?_GH6:)6Rc(@:NPbgH>?X;a52KMDB#,0eQ-V6(?K18g(1dO#+EaNO[1L:B_
XX^M]egaY4gBV3YZ#fF:@OF.b]<JdN2;><;f5<8,Ac45H_8K4L/&4)V&E8ZFa4)(
9=DF0a2Rb:<OBN0N\a\?.dR_4BHY-fCeg9(GU^MN03#IEO?:T@;@Q6@8=&eX]]XW
Z2#A]Fd:7_Y2dYQY@9;GT)4\_8,ZOa]cC<MBMV]JK25c,9/eX[QJW]/^4BF>gDK9
@KdAg1HXB<)bc\6;fI1B;=R/B.WZ\QdEK#S\T:G(0QFQDG8OJUZPJC(-BG@c:bZU
Vb.g0TQW6Qf+6C8Tea?V0=VH+d7^(C41-@:^[3YX81MFN33aHNEGA@4_NN9FTTLW
.0?dV#,N[[/aF4_<6dTCW\ed+F4YI4+T:T#/&c@OL6>f#QKQ8PR8114c.P:TKA.^
WP@++dYGGGJ)e&?+fUPJ=L(,@J>\B_(XJVNRE;Kc@,?1OFaO5E>LW]9eRIZ(O-7.
)5FTZZ]0?,gLC@Z?=FT<B_PNSJ47a#D0&DAXbe\NI7,V&^;,(;J?JS:]K^XU8()&
WJ1^UA>K0d5/36F+U4?KNV>(G[#Y6=,PZ/c@K9de6SD^7V-I\<[5dbL8Oc;R1_Q0
1R]H(fC;dD_5&E]SeP>CQA:X[,^U&5>S3M0W6I>00-S/[Jgg5MNH>b5V)EbJ/)Cd
JLE\L#>g.<O0&:Je9bM8B)2L.N(f>YL<J&1I)f.L](RaI&OX/X>()Z7T=NcO^3?g
-bI+GO+e>^(C^JV8=G@CV]fgY-TULBU0#DGJ#c5^cdDXY2Q/01JG<_V4Z?+@#?2]
9\dgCdU-VA9?,Z9#fTdC5MB@(XX(Y6+IVKGYH3VMT1P-WLS;.6O<C-f9a,<QX=@C
54^GP^>L/L>:?_ZE1W0\J>EN:(,aS_;2eR8ggHcEUe(8dVWQ\><A0,?E2IA;I@ZE
L&P\f?D171-#bUSBb@eO&6+)I.dF63>]6g:^7<Q]ADLK29&5,--F8U9/TG].3R2I
J.V^b;+L06(SeOYZ:S.W8T?Z^\_cT4?&^cN@?[Kg0II(X1aC;]>a?6;]0VcM#8J1
PVPRAIF^2:/3-F=D\J:U5)ab[0J4]I9,Yg9dHJR>;16YFVL)#a:SLI-7&NS^+/H;
@GOUg4[R\/.EP_@=HCWgeB1:8V5#D/&>3HIDX\[(AO5Q5KJ\7TKLXe3[SL[+?ET@
)CQ8;K7XNbLUVH4ORPF5E;/I0@,5-D7;[EF&FBQ0AV=W8E.W74Q5F:bFI-&,SXcC
cEEDNB+c/;5c6bU8df0&?DQ])R8bP4FCgV25f48LHU,e;B28cd],29>\gM:P__\E
2;AA,ARBaT(J3d\Z>-Y97QXKdDG[9c:0LU9XM;8@,&e7WE#W=1]ZCWMX/LB#8CK(
N>[ZKOK;I>O[abE1ANF&AGILSSTIT2?.GZ9Q6b[06D_00d>P=7F0b\@S[>ZJ8OSQ
T9X<]4V9eF,(YR>O5@.(2<IR1RT)J(_V3^dHHgd7-F0UJU<a2G?K_IITd(P@^B?[
g4f\aC.\TSQ0:.,O#]QI\3Jd6A+cW5H.3=OUY0PR2^>Tc]XV<Y8VV]=.;_^?;L3J
ADWLJ77BZd,54a,QP\[dIaRe68^d1R,JXPCQX<-e8cM7>O>VU:Nf=6fC[P]12fK;
.D>CA^18>=e(/KL/gbN6L:J(GPVF->&<E-YdYf.2cE)YJ^&<d8VE9Fb0UHBE(VSH
7<35HT@C;XbOJ\FVd5KL5BK)[,;^/2)U[&CZ3Qe4:]P5501BVL]\bFL:,BQ[\:=P
7WG:d@=MZ>CN;2RL76c8FE&NY.V^)2L(9:/9I9cfKF?F<YDRL[]W:5/b^/W\7Tf:
\^-f?6W3fSf?3PeX?V)a#7D+;HF/\S-<a).cZ;>Ic,-T\?[E5Za[?a.McNYd#L6_
NbL#d^Vg8/R:fCBG48<abIe]6<U]=R\g7-GQ\HC+JV0\F7Ob;YcH2AYH0,YedZ8S
+.Rd_B&+[;PLLB8\_<VC7:T4GXe-cU;QFM3/MIWd/c:b@TG?.#I#XT.XSgQIX[H4
V.>SKVR.KF.1Xe]17:7bI0-12I5/DPP,(PH>eaeA0Y->-1#6b-23E;W:\CcG-\52
XLbE&&Va9H>@M.J>S]5d?7fOIOa#QNSfcUJX:YN]0+3YV]a+#3.<4f/9-7/R#f7)
MW_-AMGUP\4PI4YXZ\4bTaWc-K/5-9V3>_JM1?,,e]Z5)HV:.<^RJ_7##-a1(TXg
G][J&6e=@C,<NKL:T@6&&]&_5I+:bCHdWWNDLC&c9ebNT#J/OK&SZcU_E+[6B1Ta
8&I.^O<gC^e4IUc)X2]TB:J2YHdc5;MR]S1e]eQ56eb<0-1+OTRSYf[EI((Hg(;0
gJe@f=P7,HF12Y(S4H];LTXD:&?_+&b;Y)OB)4D/4/=@G^0_[XfROVY=LH;Q;[H.
A.1V93CATWdc8b6XEBH?5475WQYb8P-PS0HB>dY51a\bO>CL0GBWP;@<LMgdN5JL
F(T(DRc+)F(&&BF/LPI2K^AVG??P>N;OHMB+H\P@H0b,N,V9#c_2[/WfbSLEFB,6
4C5XE2^g4B[HL5QU=ZEH]J>BGJR]5#XJMSfHB1GL>Y3QO?5]Q?.0Hf=9P+>=[.Ld
P68_+#(W41)b4Z.&W=D5b#WgXIV-WBd1-#B?P#[>1+ZJDaY&7fUE#->VMZ4DfOIe
.X&+cHQH]DK6N.EPG)[@/\,e+7L);H<f<Z1O>Z/(^HXc.K+.U<SUf>6.J,cXP3_@
<V(]fUOeJZ)5.X-f0;4](C3.:]Z_f@9/62(W_SY:d&fT8O+BR:]NU]Vbc8WF:T/e
67Z:<2OA?f(4Yc,XSdREU3bLF+LGa,H@,OcQ;@MT+2L576/KZ:<8e43Vf3^36g.P
TUS^K,V@V?G;+J>))f]H[M7f>_@M#/T0H@6]M29+Z0(?OPE]XGM>5R().ZT63CX9
SFa^0_K&7^6eY7b0bSPd\FdX(:S+AZI\TBTN>fEG4(=bT1-Gf2#]H_62W@+a&=M2
VJ^N9I9e6R;L\OJX+1>F9]L1,=TMNGV1:#XY,&dPNJ#\GAA-24eJ-VPY<C6Y[ZQA
f:]3,@P)]4\97PZ3N5\GT0AZR.B-HCFag/)NZ:D5^@>?H^Fg5\-J6)f(@]GM#>g9
I0?4cC1DFES8WEJW1DfO1V_0,.G]3?]c)Lb/+=E.UFR]8W.K:9;geKE&,J6R9?)X
OIUfFQ^d94H2JeOA2:gHTW_<XHG&Y+,\AO70bA[1PFHX+S<2+\TJDOU0&JdD/81S
8c,[g8<#8J#cgIZTE639XD/-K()g62bC2]-KAYL>P(5UZOc/PGcYP[#E+HL7>EY1
JWI_,U.C2HfJ1:-N_HGc>2HVIgDBM_:CAUGH0-K4f/^8GQNSH:,\Zg&;gX@6cd[<
,F/KUaM>,G2LfZ:FUO:N&M:,&bgS&/O:F]f0NA^&7dNFJa/>(_ed9QCd7L,UM>9\
8_<EafL4])TR]?+ZUAGNUUeXa>eN47Ub@g+7O1YC.#^W0H/1D=#f(SO?,dTOLfV+
+8aKKKT=JVHX&fKPaNeJQ7C0^;EC<&1e<7##19a(S5?\T++<CJ_O]^?N#1;IIc^#
NBE\d,QUP@OTN17)NE/b^V>X#Fg(?X1R-HEKR/UQe+AM)<\fL\83R=6>MG&b(1ZM
=SC72-UQW?M4M_754-@ZMC+/:W6S,CgZcE40NbR>fR2E(8Z]:K#Y[a2DI28[MQ0R
@,#REK;LJF/@gQ6XS^(KJNVY,[caZF<W&N<YS]gc3.5b@Reff)V5+),GfF?>C:,7
</c9#0bWG4YT.R&7I:OD9K3C\@>##8PM0Y=5CFf]eU(8)74\-..WD=B.&;\?:;>L
EN&=V-I<,dQ_QB^=L23EF@Q]V?;Z]Y4&=23=e?4A;dGCA8SGa@M4Hf_7b)J5O.?&
=\-=V]b3dRQ.La[V@(33\IgW3Wb<4^G\+Y\.J2ZV)DR/HV&&dW15>dTD/VeM8b^B
VZMfRf400;Vf6=f9ZBdf8e&Pd6=WU)WII^[-(fMGF6F8JQe3])TS#Y69T_CVOE#N
7.=J=RO0>VYRHC7g&->A_.GQJREc:[:7,@@.9EQAOJ#T>.6bS6#)_b8-Sa.eDAP/
f\6SVU^5VQZ3G>L8ZbN,eY^9gW.GV<Y5]JIP?E<RTAR[CWNWE^F<f,88LJLUI+dH
=U+fNS=9bJ#dSMG[AfWJ-S?#1g+]SA)#-&C5dYN>T5J7T\N7@=TKW0N#-@QFD@fU
VZ8NH\-[.2M?)TWcL\9UU1:_@K;_UNJ6;_P2P<F](-c88@U+-d]57I=e-PDNQKP4
aa66=>A@P[3H7J_^CZV6>DW(;_LX;8K>.)6B;.EfKPJNTRW>D<:d@SKdK>:<&XW/
I45^QQ:S^f0#aRI.?]5T^N4PAZ6cT:S_16^aH40[)64M,.Q==H_UU[ecQIT.1SDV
6GMJgKg4e]>fJGQ>5dV[5+eI/?DcH9NZ_7;;M-K=b[KbcXTeL(L?\3@Y&R.?M/gX
J_):9K[P;fV4+,?MXgeK1#J68U<@f>.cI9a&C<>b5g;D/7@KF7/)cKIHf6]T-Kf#
@(9RZ@K6>Q1<F?N?\Q6LGAg.4.cLX&7/[CcK@<]Y2D.SI8)K\2VSLHOXF3O6YM,U
PUG_P2?/Z<86e8]N>SY3&QFW\0\aDgb\DK9f_(_:_T-;:D9\^C&6V\@@?P1=)V)W
PEH9VZ614:,4T,gZO0\A&4@ZYA)XBDc96XP.V/0g9/9P7.ET<<[T7DI8ZBD7<JE6
@QO<CJ\a,=@@;\7Z@SF3D92K\d_^7SZ/B?#O#<UA[.[G5&Cbd??_A990>;/JR[QD
\5OFKTOQCeDD(U^9(0W:DSN=de1@6=Z)X>2LbD6cI_g:_Y\b1-B=fJD?0<LWM1[2
0GG),4gYS8:Y;XEW_eOB6/C/]^TBD45A8\.G>8-RcT#K_gb2Z);S;ND1QWTV228T
NT-2SVcODA(]b]TS)cKGM(&D)F.K8_P&^[TG;.MgRZ\CVdaCYN?a2E^21cQJ-></
YHJ<&+GNdV45LX+\B=3>4(6:)6IF2O[a-b1;YR_H1:T.5P7LXQSY0V4YU]G(b#:b
aHJd]-:dcMLM#M^e@#c[e/1a=LP]&1aAE/I3.+/EA[+>/GN)(Ec^Y5fV.A97+4.M
F7XIIfBHCPSLG\#WTf6YD]XAb30Paca.])GN5N7<5dF/W^bZbP4d,1Qa3WUdg-Me
=L1^]c<S1\\)Y:?UN#3_(R19eP=MAG)ObB_1\f\SVQ-XefX>-PETVf59N8X0MM]5
8#MNG0-F@H8VI,a^9d;C1VON:fM;bJ]_]#+\O#_<A)9.WANSbQ7UCSV(#KUT.:82
#5+EJ=[FT@Z[S57O/9/-b7F=:VdT=T>[acGW7&2WB@I]]2AIdM#d,GXRZNQ;-625
gOG<+[fR,c#5KIZ[\;fa&M/ZS[0JDOb-\5?6H>W2Qb?:Rf,N&3dXJ4,Q=&JH\,K-
b&/gLI[XY((3=_6K)VR7]P)#[R-/,GJfHT>g8GfN[F^bJG^SR3_K9N#P\#BW[KNS
#?#_P;5UcWIdc0Q=cEJ8R&K89GKg_?XLC)9<)E/GIUULeTK)^DS?XP47:K?]K37&
;NA1WdTg7DQ2OVB1b\TJ^/LU,g;g@8^.gT,I4S4&;-=&XDPC6d6,0>1@eBPB\_Yg
Y/+X1=gZM]fXIE1MT,g5,d@<8S>,P\3F[#HC&2R?ZU0428U9>Hf^4babH;OW=&8@
eD^-FR7#P_.EB>EA[9C<Zb9\+@B_g621XAa+d>D:]bG\LT3M)&YL.;(baIKZ3L.,
-741SK_E[49HKYDg@Ug^2F<5;7daUcI+YCS-<_]0A9Kee4,D^4-^W2Y^1[8AT;f_
<OdQJJ?V\Q_W5eH5S=_GL.KY]LFT/RP.BbN=<8PD5=]QB1_=f7/@7P;?,c5[_7TC
^A1+:(D1&#0Vc5W>4fSg_(V;UHcJRLdV:f.U-FD2@<<?+JFR7IX9MS-cL:[BR8@2
XU](,\ZX>+IY^8+=BF-31Wd23;WA0CU#A?>3LND+Y^3Qa.9LPSSD-ABRMdZMI]\S
/)KJ7?-#(0FRa&<SDg+M8^c=5;^TVD5Ze@H4PM5,#KV,]EPK&30M.Gd#)Z35(QC\
]=P/.9We\g,^b/4e];L)\bJH,<?IX(^,W-NQ#1Nf\>QR[=e,/cST)&6D.b_fC_;c
YDeUD9OW_g@GGbf^1Ofc_d(IHgS&e#N4[aC2+B.2H39END^;P#/,[,UbEKb85]RX
GOFc7XLK+Td4@U=P-_6(PHKf.PIZ@1&4ZI?aVJ,5NaSJJP3-?XTGQUG[B))#G?dX
,4MSTK;)[8_.5ED>IfLS:03ESa#Xc[O);bJ9X&?>WITeWFG,8YM0:S1Rc=Vb_/b#
_5H<@9-g(>+],_-)>=,<K#)Ae6I6]^<Y>TNBd^XNYM_28LU,dCM>#;/_Q;5J[?Bc
B<+b=0[#2#+]2ddc[@XL[[:G<^X6TV0a]XgVP\D-FdKa:J0CFXF]aC0Ng.-7MAgf
S#FS+@VOM-4Tc12V(R.^;bQWb6H[eUO]3;a+5#a5_?17IC/ZC>A8eQUJ&4(F4&?\
I&OZT^K=Y3A3&;W[Nc\a=.gd1ETL5)40e?#O[3TWW[B&=(,+,J.6L63XB4Yb&Uf;
^L9bb51P-T&f/&79.3cT3KA(^bDS63NR9fRC5^_ZH&c8EQ1WT=F.\3ZIP#P07^_a
I[E?ZM)]0XbEAPKa>8]P,1/F-ZZ@Cf9bRdSQeDB/4:PY9dUJbfKdYWP-?f.TH(G@
/);BUgJMg,B7M4-4YV3>d6VKNA-[5[&dM[U6A&@Qa2b&fI,0:^agWNdB@1H-362(
#CB\d=VEPLL7L0f+46IH4HcMd//>Yd0;07=\?(FC=I^-9Y45dRJP63,MdK,>7.Z.
LGTH/.HB#A)75_d89,APQ)V<_O_Re:RgfT95);OW[8849f6M8F]Y;Z&eKZ67K<:^
L#K\Z&J5T://9S40EZ,eLS8OFJRd_[266R+GNca4X,HMS(OX07?F73XO>IbXPD4f
7=H4JT+7PbZO,f^?+^d]WNPU87H^Qf<W\Ud_W7_F#]2E3]bG>/E:&]VUN/<UO_#L
Y1-4L&+eE.gEA>OJ99&JY+a]8I2,0O\M]1_SdNI,S#Y[07/3=/87AcI\?J?d863f
9e//.Q[&):_NWT_XgHaW6N1AE-:NVa?gQ8Z/#9H<HB2PH.;M5@Nb9A<TWK=55S;e
OY67;@A@3A?Z<3fY+b@Zg+e^O&]A4L3:Ja\V5]UX/S>a9.Wa,4M4c6Z8Q&^H56QV
XGbUa/8AASb^GJAU-TSG+XQOd2Oc>We&g.YLEf:#L1fcR:3d6QX3<S]5>LT-?-0V
4Z88ZZ(b?b[XPGW\HN168QO//F[g2dgZ:;-5Kc/PaUUJ\F5H\&D6NZ>JT4f>92W3
cA>eFR]T.X-&NcQ-aD,D1[2G/#dRRI1-WG1+(Q]M[NJ&gee/0K__1-R^Ff3ecP#3
=e7Z\H/b_H0?PTZbM_^EM6Vg@b0D5I9M)GX2IASUU2<Q(ROXT0f=Oc.I,J+<]4<D
f&3L66Gc+Ma)FN>U,;AMQU36aJVca[F05D#HV5McQ1G2.)R#+8<XP9&U5,ERPX#8
Ia80)=-)::W9_.WB,;^M]g19bF1J2R#^8)+TZ?&#ZZY-AbSR1J=N3];J_bL=)fR0
cBg4)W5cd7:d\X.DO)U>(CbL[+B]b(I4/KJYH1>H2,N^#f^&^82I7FT+M&,C@KU[
-K@I7+6cb<(Q3)>&YRP]1;]#1-^Z_RBWI(1ZWO#0SP]\K(\Q0RPddcT6C=H-ZT=4
Oe[b5VER@]Q#RI?D+d++bV-2(X(abOF):T_8TMVPX/\R[YP0^S?13BN122H>-5@G
MELUbbXJ/8#E+e,S8a/PX+\_]:g7Zb6+#H/>3;:TV6Z7(RODP/1^,0ae.YZFJDR1
9;]JE/=77F;L#<G-Z#N:U:]7)T8[&(_>FJ8C^94M-((;L(>fU6041Td<_0)<,bFe
18dYQ;_V\@a6/FaLNfUEbA@MeW[\B?HIeA4VGXHRR&(,N5RFCCP@X/:^@EVNI-N]
NQIE;Sff]b,&4)-?H5UBW7ZU?N8VRS@Nd-#-X6&)>d6INK3_V8ePDM5GOU2^RaCS
?a=07CT2,1EO/acWMeM69Pb3bT\0bc)&J[Ac7(,H_>D<:KGeO\J\7@&bQ27PJ-,1
U5UNPCKG5Gd9H399W>5Fdd)64fP&^U^OUK,(Z6]]P9R0/4-ca>>EXc0;LObTIcQ/
5S:66U#BX@WgRVZ>=e[3^F>e=837E^7BYWe:FJ>e4K>BSOEL4,Z9S^Jgf4]R2H\1
+4g@Z3R.6T4dff2e]M>/fA9g5ZJ2/;QGQ2/V6YH&U5,.6,a19]IJ@PHOPV62(7PS
H?\L)LPESdN5g+dAL0CM3_4WD,L9-6R6AKY8Ta-bf=;BOTXU4fbd0K^7[>IDK/G#
A1ROZ)YO23A##^P8B1_28I+/I\..SCgGKAF.];(WTc5KBT)?GEC5eAANb]5[L@<P
Sg_g351Y<7\HO.9,BSH)HR??L9Z/T3#D]AB+93[3Q,Hb/E4@NCbcLT]NcNYgD?#\
]3R;8QE?M]3_9=R3VIT+A:-T.4AEQ@SfV=Dg8)7GQBT>6-Y1E?>gZ_)OD#UG1X\Z
#ZP;W@3>@P.5\0R:MFbV1QVg#EA<QE&FC[;,Ld9<#PKZ&4^T02)HGb>B+;]B,dOA
gd>INHdb^V-cXBI7/g/f_gIf_ES^&c&<cY/MfZQ-?CPg?V@a2c_AVJEV)X]F7\Q1
T>/F#cAQZT)\/?SF><_<HL?>XU(#gVENWAKa,RB0T?_2>38.J-(<Q]WYQF4bb8cB
&4YILPZgaU8G]EVRN?R3>T(f73/,)W)9^@c,F0/@(K]CQ,4C[_^bKE8CT6WXNT68
3dQ]=f+eR:FBPO18N7&a/@LCPPP:NUE(3[WYR^cU_a3/C(5WAZW1DL>8E40M-WE/
1HeOVPQe2Ad[G8VX1GAL=d?B+-Z+<f@F9^VLd&6ZaYcHXbb6[]P3Q_CRbXgSJ2-H
?F8>6Z@S8,_[d?K5eD7D08>@/0PIR@,_5J3a_)<f[&G?/)UVGISJYc>KG5<I.16:
fQ/<\,LP2QO@3H0-ZA@&Y#A_0U[U+>W?/DEP1SFa:0H]+d6+G(B09+.eK:g3E02C
0.0\&5/dD8Occ(#6:g9A(<Q?Z:CWLaI[_LDLdT\4=+Sa\.0e##11c:\B,/V98?>:
LEK=SR4F,L(d-f[A,BI<B+K#T-KdfR?C;_-)-f?O;=_=B(XKW9g2M9(UQX]K#U^>
:Ca/@&9eFPH@I/]C19ADGX:TNL[4(\<=#KRc7.cXE)YfL2G#<^.7[S>.&=7]\eFN
&@LZ8g3dNJZW+C.</B19]bH,]OZaKaFSfD0PHL[Z?&?GE@6F[=SW:JWTZR@G][?N
9Q;[O(])3WMcdA_#U^B@Q([Z.0e[:JG,1Y^-5U(JcfK)I=f>6T5#2B)B-P0XL]T2
LP+,.B^V_:EQ,M_P&?F@_/,ggM-T-PefHO4,0./]/J=HM1DOb(b.+TPKafGb7R8\
A;Y<8OM1.^QP<4Y5bN1Z:@6.&g]N3_X^ND)KPI-CMXNQ5TJX^866d4LWS\ZE#ScX
gTS@4,1NH33F0]T[VF^6^81HPCAEGBgW21HO;,&^1eUYIdLO>5Z:#(0AZM++W0de
9UY9A?\.LJ&2L4EO0V3WQRa&R[DUW:<&Q-OGIK5=Q[:gH1?YJ^)M#.E<SRR9@W#E
NZQ?([.)1I,:9\N1Occ?a-A/-4>,N902b)09\<A\C#fagKK,d(/N^OY]4>+E=X#F
MV^XYXeJbe,FW[^.bVXPB5f>\UaV:#O.\B;_(NB:U\Oc?R)]8KOF0VBJCa,_O^[J
AM?^SNT9DNbeIV8:WfaaKEcJW=@Sg>4ENfIF63.F+JM-1gJaEA/A^0HO@&+006PS
+K+X4_>\W+aP292(7aZWe(,3gMW=VRg_<4-+96+G5A5#aC6GeZJUF]@GW#f]X@(g
48S<9ZT\V\JeSPJAM@BJ\Qc&41+X(,SK4FM[S10O4.fU-E[&RD^Qeg^9N;/:a\\R
#WgM_&G7G1+XcR1ZT8:Z1O\TAVbP(XcbI#A3IM;:b,K1fe=NQ]2BDWb@796,N>,V
HG?9V[QZc82Uc7?U9-+GTgd^H2I02HE=Q5W2Mc<A/F3V/I&SM[I<W5JK^(cbSPR?
?A-1eS5[.]6;F;F+#>U/2f,OSc?\c:&,;6Q.P41^-\a#YMZ2EbW]PY=Kb@b#Z:)@
bNSN6NQ&U6^N:W=G+Y8#,90YJ5OM7?LJ@)XOFPL6L#3FUH)N^N?ePB-RGFD=8;6?
KgLc_&J9eJ2FDQ-d1dW)2+.HJZR_:6\6U,4P,)5:=.\5_U3([g+)(<O3c<=0+O^T
MZLNK@;(J3&JCGWE8)Ca@=ABd=E-OM=5SfKIaJK6XSWdC_5L-=XM9GL09E&bSOdM
MG&&/A\^.W)NG<)&AA[KL1YdKZKR<CJE82SYRCFW?fM=@I]EPW_++37INS-+A-II
/ISEXZ:e7HA6GXcbUb:QSQgV9K,BT8e1cP2B4U48:1L&J__736=)+&>26;XN2Gba
,QAW\E&?UO.[_BfM#PWS]Qd]V6Ed.gG;K?79/#__5/G^V+49@[&-7B<T[_G,[EZ)
HA>4:0R-WY[AUZdZA[F>H]PB<5DD;3Q0/DB/[),+G(4fc(+]V#8dgNAAURMUJEe]
F#(81):#TfN_<8N5G1;/8YYN6DLe(O+Q7OQR39;>Q[U>Zd,aNWO.4f6RON+_38)I
6BO.V.fZEJg^31\8RS[c?WFLVI)+.SGU.+EEO-1aWOB68Ydf30U;WLAd-5:X<TC/
-I&J8e3BT.YWL6f&.,H8PEg1B=2I-9)U/B4bAIJL><(TY[8IcS&a:XBF.(Q=81?.
9PC#0O+<)_+=PUU5ER2..gg5/ePBRJEB=a(Xd,MedYPd.2N>A7WUK&V,0?ZWH<5=
VQe0HW<TX0:@JPK[KP6cV7:+f,ZF8da[_:0Q3R>2-7>f2ZV-W0MYH9#L,d3Kgbba
8ZaU[9U_U_]E]QU2HQ)>/2P\1SYFVOBLCgGd?N_I5RO]f#V]S36?JdQ(]?-))H2F
ae6R)_-SQ,7QC-;[JB9GYaM)8D91+PJ+CNJ=JKeQF#:&K;:Cd5P+X?B@GP2=a?L5
RLC(.[C_a4DF=J6@9XM\_]]?a@-)CAXZ0#^e1UZ_IERI<-Y?3AHaZ.FW>WeXc1L&
66HYW9.V@#gKP]M5.:K8_e&I3=&EJ)7a&>RB/X]Sd4V>ceT1?]c4e)J)RaPSWXeW
-Q>&W;Q/>bCE[;Y@#Od<+O::(H]U_D.1CEQgT:KZI4.7c<dcG])@WG&dV(6TFgCB
7CVH8V?aUYRd._HS&eHD[]?9\+AgS7#DGC1G[#9:1C[66@@)PcdUCc>E/>(;PSW(
D98Ag_PF7WA/\K:XTe&LE@c^)D08CI],Q(B1PYF>T?Y;RH6.P2ZLfT\S@gcZN>59
4-8WEdOa]_NfD\F):?Af.N0.?3bREMHL#=MBW+FDT4+N=6b1E2U3,J]NN?C5[#)O
Y[4\C0]ZKTY]bBULa]^;#]&B7-c2D9+XbcCeG:Df@;JNSEF)M<Fg]Q4/d1g\:S>4
3VQ2LfK6(g)5)aEg-OSa;a]J\(&VCL9J1AH#B7BVI[S(Hd_FP-<XLO5ZD7Z#9/O0
P(RA]DCULP4&c;EEVLH[VM^=^2S9VV?VQYWR,NP\+U8eVEIW2=M@J@4A+]>ePYNR
[b478&P?bX8NbPL#aQH[RDa600BDA<CH9R+<03fPIX&dcVC>eY,K:0_652>ITAF5
I-XIAXN4+Y=WZL3M3W:G>g^TH5F[WB];HZ3#HAX:]B>XF)^@S+H-UF,ZKY.\7#M8
4CD1OdBA;ACS@A7OHd_YPE2^P_(6d\U,g(+U/<@W>.D1ES(),;&c2LS+07Eg]F4I
MF.YR3g-HJT2_a4+C(<+P2dJ/EJ<UK>&L=5\H7K]K3_1-[[CIIK#MLYP=0TMRNVO
gFPZ=Y],,[e>OV&<.]BQ9Y6GW\d8bK\-+#-Q)^d0Z]AV&M4B(OA#=2.UfRUW],4[
P5c:TW;d&a0/G>R?c>g[PRTAEPWSIF3HY1bMd\/9JBU(DJR&/ZNTccNb&QX\fPF4
f_LSU^6;_\QJ-4RQ7X2bOQK]/H9gSY_;/O2>-A[[c^]PP-P]P_Pgc183GP,_YE\E
/004M1/X7e6WdBV_/aeJTACXDNd=.fJ8&=N]]EU(Y/@&eVW;Mb4E-5V9;RcgB/Se
^1]=)9YX45KZGeabL&M,cEW\W^)<3)@H.H=F50-RJAM(1G<TP,(+I&1:1g^96:B>
/Nc/C=G4@PUf)16FY:e?<>9@CJJ^O?>H3EB2J0C8cDWI;g+,4fM.G=QbYY]fe5IP
=HbL?[P]a<2S:EU?F><GeI::Z=/DeMcIIP?[3T4<N3T5#E4[_L+3PI-(;O3JK5S0
NKFPDgN+M]^W:[a30f#:,e3K)1<gL[;ABI[\b():DZH\-8TXCR<9I4J,[f8U_BgE
==Bg5?;>>2C12,1f_[+DT1/V4^F+389,.Z;Z[)O^D13:0M@R[Y9#H\TK<TKgb\PP
_)a)X^eP<BV&?GB_KKRcDA7U:/3-,PLDW<MG)?0+V<XE7T;)+K0]WZNCNL\X]\_:
&,H.)[Ae^;FISMZK>9ZI-ZTA8]8,[LBRKHPeVUB0;\D;@F]bdD0LAO6aD_4(:C3g
77T_:=I^72NU66?\(73],?NGH9gJO-Lc/?_@3&-g401)55F<ZY^eOZ8W.:ZMK2RS
2D_YE2(]F5^?aaL1\KMUMX#]89gBFA7:8/8(@D6RM;ZZICA&bL/M:\1NAeEKbR6+
ITZY73c^,G&=Y>U[dA#XLf^Te@HS,b693&?UH=(=P[]3)cFO,23Y1#.S3_J@?BOe
?Qg3e+(J5AD:K-Rd3dSV\K@S,VA]\ES36[Y7MOTU(/dA.M&Y@eF<3M4X,PI5RMIP
3,cO;^VV3L8a+TD\)M5EBV#:[11eJF2LT6NT7gAdgFO=CaR<_U-@9.>ba<P#cJ\F
0WQ(A_2V[O@e]EXEM0/;RX[\f#?eR1;?,cK7N/X\4I6^9cI976;)9WAP(AOLeEF&
=fa31^YdR<VP_b/2>(c+]R#b;&TGI</?G2>fMa<1O1YK;\d:)H@0KN5Ec\P.7L9F
/NS@\bK1If3U.Eg6:_fT:Z8UI1)O7@5ILb;<:0Dab/ONRb#2e=[>O8KfJbG<?(<^
3O.VdJ:Ud8L1+Z4TTD4Z^:2c@Ae+RCcA2+^L3M_0;G9/T5&_1>K5e;e-&+YFf7OS
0V4?Of2DE7JF&:\6EbR@/[\5QQAQ-ON1b75R/6Z#6:bYLM1ZE^g>X:7(9S<&T?60
X/QF/RNdW>3_<Af;L65NWSFRTY7[BB3_2;e#ZCR5c43CF5/6c_YR/3-JbI,F;Y2=
gCJa?:8=;6H^IRL]>L\U-)/Q9-/TbURg_,OXDO=U/KS.-GDf/(-I\?YPaOLFDY+b
^DI^7+X)Qf3AETc>+.Q0Ae9U0TM[@>9+6_,aXE\V-<.7PV&P-\HM(@(.KL([>+B@
NW:4;>&^^K:]c=KT8RSdT?IaCQf#-.KMW4(:[>.)f]:H=LM-,5-UVcRV-LA#2JdR
[@[7U#<D&:5gESH?.T3/CN\8O(&&)YV9)XZQKLM]G_<-;-GHE^TfYORDG&1X=dQ9
Y@NgM)+:3:5]O.VZ)5eR@?6W2WeJV#;:2-FGB<YdGCC6958R82X#[c5ILO_,/&^(
T:E?<_5O-7\9e\;P?UWdc?]GGUE1ZRcP<1JcW?_4bdT>6LN.BD\(8;U.UFbF^H+\
1S_@WX+V@)\\PM((]gSZ5\H\1@#0U1GS3PQQ)5/P[IGg-dW#Sd[BDMe(B-eX34O(
1=<8B,6PG31V4.4^J>[>^6Z8AF+QOYPZY2V?LEBBEZ@9+(()N39:BIQ_cbYdXC9e
eJcQ8V(#=XA)H0/aU=?@+QD#F6Gc7b<a@E[__7bb.A-QRe8^1\:33f\GUA8@](_8
.\V5\FV<?:I539FHLEf,S83W.?Y5:7g,CdH8;I(&cWb:Z2<d&8U5A4[REPQ8B]+&
>BD;fPXSWHd]9^fe1SRe4Z5f(.#V&6^FL]83NYcLA9K1gR1FDgc77V/Z/@(L/L[6
[C&36?AX](>&O](\0O2^4MP975af=64c1N6(D58JJM+93+26-bSg1TfXB_YH<QFE
S/8;ND3<e+D:E2f.=G;B[\MdEXF4)/d]OUEVIIfW?&M9.O[>=0dRHd/,WMKe#,S7
^>4^g\RU>[A?+I_70#>FW2>DJ#Z:D#AHMXT2/:O_H/NR>X?K8?-SgI+e&N9NT(R2
Qga4RT6)b\V5MKaYFXYZGS3MM_BFC^_^3S[Ne)LBaC?-BGd_]_1,,28-<>#4PRbT
^a39=6IX3H/@M;0J;Vg<eK0XVWF3,@H_IDKd[?VDbZFLf?>=DW;c+;24bEA4d9+P
VP>.1F;UQQa.2EG<5]Dc\B4WW31[^gC1T(/W\MK1Y#QW86,&4,2N6TQQCcDe357a
+08^c]^H](W@27G;0M.AOPaL(CFP&Z;UO.#)<F6+gFXVc+[.RZ#^XJgTNBZ[C?UW
9\NGU75Q=&.dRGKE:NE;YF@IeX1&42eRYO?P3.^a5&3<ZH=<N0B@HK\)<\\<&#I@
OA//US26TMY;VGT-X)&J^1A5]5UcN.+.Y&-Z;?OK1V_0YXW[1+=fLP)cBM2cYFgK
2N4A1<X6=O6&f],:JPJ-S(=KH.NE+Z#VVG^L<6IZ)b7(C477I47?9gd_fNU0acD8
+CG;KN158MaP9IM;.;=AaH:JGc-E:7&AUGW1Z[N_9c58)9d:V?U64<J(EdH.RNAX
cR9;Z/@FBPDOSF1,fdaZ0],VA#G\+;#^;,7^1F,+PMfR_bdT:9DWJ:49H4N,\/TM
SeVY.:LdRS?/gBP5CY2&1QYD8_XN<KWA_<Vb7GbP[.f/SI7R+R9FZ5b&1_[MX_?H
P8bU3)<9899&AdFe>KI1:ING4[Zd@(D0Q0[;MOO^N.<a1UXUVLAC0+1WU#;/:275
QFDa/f_cZb\7W,Z]LeDLQ)EO7R6E0;(PZCTUFJ1D#a?I6=J5W9PfLYON/U:DTg_:
UAbb6_K7Kbb1fPbb,_&>CC_PLA1S&\2,??7:d1Bb22f7UBNS0SF_dTZ>>>05C8V5
>aY(&]FCB[/1O6_IEZVUC8UQ8=?V4QX7:)Yg]WNe<RZQfKaOOHg<3EP_AXKJf1X]
:X58.U>UTJ#U64RS?PMMP37f(d:>QG?0b7bR4D\aC<2YEAAbJKT<Y0a[ebEMTW2+
,U]^=2H0,]DLWIUOK>[0)EG=NL+ZAY5R?X9c4#Mf<2JL7OC6]g74Y_eK+HZMO:;Q
#H9/f07FIBbGPW5EY8ePB_\Heb]g#BJJ@1XQ5>4SJ_&8OQ=1e57-EecT?5V._gaA
RZY//LPYfT2#=)&MW2STX82#:@Ue\e3(I6N^K\6X8L]A^7R=f.07?SQeaS\S9;YQ
V&QZB,R/W#IWa(&;(UR#><1VF=4\)b,5A#d?RR=&.FS5:W6NUgN8TZ[^>++&KD;C
Vb05[+C1+BW=f\5-feFJHA(:YDNE9c?7FE/-^,,M#JO&:S0c@]X,30QgdPd0,GP1
?VJ82BC[?@(5JYZ8:@\DBEKN56TY->E956M_\FeP:=W3S1ES_QP01e=>>D^C;VQ;
RdD,X[b-M5#9FgA]4=INK_@P\b?\;CW#BXH+ZG[ZG@/g.1646,,NRV1cg[0MCJ4f
6QWGHNT;C:]^S+BW;&=54TAHE_UPb1YDa,RCLFO\F6;#&I/D+g1+IFKO/&:GJ\L9
YCT=1VgTVIJ=&@X-7-e(P0Ne(.&ebCG)@J74&2:;&<9C;?T&WE;<;/.&.7<4;TZ3
7_bBg0cf-V=##@P8)5(3KR1.0C-L_B8B#fWQK8O5+;MbagET#077XY:2RdEYB#KY
CCBXS4RW@.c4U7B<8Ke70>Q<Z>Y)1Pdg]C<c2G)?-dAEWaX=a(@OFd_0YA=[X<.b
RZF:^G6eJdDIa(a0>gEQ0(D3+P>[RB/]VAZ#f/FYE_?MS8aAO&RCNM9Dc>C@USf<
OQ1]Z&\K9O:CADeE2UQ&JWQ77HW//5(0X3:Ve1b6R2_S@-S5BN\&fIN7?M8LT8aE
&UOZb)S<>4?aLOO.]TVG:INV,]7RH0,+aY9gS>]X#_L2\CUfGb0FG611b,LB37KX
GY39#(G/39S#N7T^aZIBF>6T4EY1P]3LM7Vca)+C^07>Y@FZ?JYCQC0_]7&3#_09
N<>G]5:(MS67RE>N>DHg0PbA;V)<?WIB^ARcPX@8+ZR/+:;]NU>ZAOVHM1/VZYee
1Bb0M,>?L-DLA;gbe>MD7])d2-3TW&V;>QPHXI>OVCd&dPI3O^4ccbJaLaQUJ(VZ
9<EIgN&X7\8YC:3FT6FFdBBb^Y@9N@4<A^@V.G+0\)eXYg?e9B\eX4=aU^cX;S2#
O@>?f6DCIIQQ8gKW7aD9MHW70F0e@-ZUTIcf.DWC]g=&D18@+_OT)-2:d=e=Ma-6
b6:6KZUB+8&KdXJV+NFV2N8&I62Jc?WKbBFCD)DQ0H1?K(M\Bdac.9I@\-#BZ&_a
=84D0+A);VUWCYEZ^>NJP#aagT+\JJWde6]@6>Y@TO:Mc.WOX@5=OH,VD,YGMW)0
#5X#f&TRHgD)YLGB0)K2#VW3/-MR)3(-0Ic>O0(1S?bH+PMXS+P.@#HWS&EAAPD6
Eb[2TMI&=5<SDX.DO+B^UEN^P>5@B7d0XB:\)c[Gcd.TZJH6EX#8?_U/9-M_]=Td
:X.GgNaCXf=_ZJ6\+]IP@/#^09\fQ=Ud0G9>=g\5E]S5E:FM7EPP-gg2X8,X1S4M
V;F;O@&g;M,][UNUb&-\F(LIBYQ;5+P(&XRb^/8O<_OKV-M-X1OZGKP.1R;,f2+a
==@+N62&<#f_4I@BRJKGP=T43ABb1^43Z4(>VPUHd0;&4+B&c69&VG5M.<9QFRaW
>;8R8,.25^VcB#,-\:\]DM=2&^[c8cPI1cOU]aXQZ:_:/IT00IDE24_MEgfU(IOG
Y=>AC:RC/3II;>1cT7BX9HC\dCVHK5W8IeBe((/@babNaHLHB[2_/.?Pf99]8M>Y
]3O[_N0R)(B)RF5T2RBARH]bFb6WF_ET9Pfd:&9UJd#VBZ>99U-cNUUB;53VIK3R
R/f5A:ZU8_>PT@cUc<:T[UJV_KU[(]E;&8UY\LO_N)GUU_&WOBPLP2BJI@gH>30,
4+NVcQCK#b_N::_a.g&O7J&B7DKE1FR;d</\.G(K7f.f0BWPQ?7U<?.g9./S\>7/
.Y81;Cg<E^PXAMNA<@1CaFB2Xfg_b7HQ9DLZdcH(00.CH[b^OHZ/F5AP<g4-(GgN
CCM2KGe?S2)])QIKUV<;XFF,Ic_F>A:67XGNb)?ES\.:5KAR;=+AU/2MQ,ZCLf]Z
S(<]:REg)4\43\^Z<[\D6<64fY&?,Be8bL\(QaFR/D#(=]F5bJCQLBPWHc@)+df>
(\L:DKXOK655f+Qb>Z3(U@b1DKB>c,2;^D=KX0+P(A?g<gK.)1:>^O6QK4DZcL/<
Z;)]ZOfZ>Z69K8+I^dL@H0>YWV0GUSQOV[Y+\JTUXbTDK142I>YWdOg2U9<S2[#G
)8V6ID_[SHA@<gK45b2BEB^(DD?dEK<;1\G,Q)<5c3FT=d,I:?LNA\I8c_DHc_>6
gFI/bMNNYSYA]H==.Jf1K@1KPbW76_Tafc5/)6Q[&,fdJaETYMES@UM],4FZ\#-2
dcAO:0cS^L<--dXSB0FEeD>8NM=cbQQ/5D0E,GLBf;\bP?W_L>=ZB4NNM38EZLeY
2#X3^(DG<5#1T-;(0+>0^1SW\2HJ&f2S>6B0^99c,(bNaX(KFL1MQ\1F@Da3F_S&
RfW,J=f]6EY8/U+AfC3&+EOS(dH<A-,WaO[f?c,#=EC]Q4.)gR5KQR8e6aa2EO?F
(K4TW3f78=]XW-EO\2-S>RaF4f+eePJR@?b?=LL0&9C50+1I):Y8AT^H)=eL#/eK
.]?>P9-FG4/3&]5FA-R5f2g>Z6GDTD:B?JcXVRaCO<McIBKGW^VQ?NU]0CM:GKNd
[L(JF_deJZ<fYc3)X<QYP;)5JB8?#LAe80]1-;[)4WALN-<EP&Wd=2:K24fP6,O6
cAL^4.7[)T=dCEf6eD/dPD03.1#f9RRd(eXLB9aRLVYKU.D_;S-#3RUEX44Wb^B+
Qa)TgUf]=e@<VYO&W-HSJ9+UF_QLOf5^]MX5>7e5&>0gd9XG=O5):\VLC,EAA_HX
L,<?@e2a.E0OKeN+&.@8A3#[?7]L3AZf,4(;FB2DG9<Pc@61&+([9W<JX#+;f]Q\
0^UeSe?4A>PRePAPU?[2@RN7VK24WbYDVJ]HW1C1CXYG#RcT&P,:XA?]U@:QK9bN
DdfdH3)#F\L<44>44aGJ+)CRRGDgWfO6E3c/1XI,3(5?=2d32;7Ne-R_8;^bL)JD
:2B&)ISZ1[+),_.XX/Q=E>4Z8;5a]A9IYe9K-1<HW[I5(TQg_d(F^d82YA/7A0RE
E\H1?Ndg3(>_=.]<>(CW,5[?S3)]2.eN.cY#CMY<QG6=LS(ZfKCB^ZE+CN4,/daf
\[aN+X@.\1B/5RKA6X:GA.=T;e@@D?N\fVUIL(WQA28]3?^H-B4W&g^aNR1UZ2SB
<Z9CYJ5,N;G;[)Q/Y./S;K4+=1I)^C8;W&ERW[gM,>/a1/TS@;dLT<WO)WUOHK_e
;D8>(SadQW3/Q,<5)]3S7?FD;7Z])_(5Y?0@ZFA]:XD1V;b6fcDe:]=[cC-QI2/]
I-PUXc8JI92-XJY7,E\WOe.0.2Z.26;]&5IM()]2Z>./D_(Q2\cNSc]bCSMa)HMT
R-G@Pb]-&EQ[:HG7^E#G&ZF271K(e2dW-(=(O<M[;,.@>NYBLHHD,#E;RXREPYe/
^:O?PK4UNI862JI7<[X1MW]UX>VCA0f1-(122A4=I?8=5F-J)\bVC2)6OUK6A5U(
35C:GAT07=C-#UL]I_/4(a6914@5HOF=&7\C3aP?W_UW8W6,I903)5e2-\?2d?>X
ER)J<b^Ae(9?@Na5@?a:WPXI_#-I#Pg1\&b+G_#C&(1[6C8N.aFY=N0JMD,E;gW4
P(43<]-A(+cKbb5W1f#L16:)SJc+b2_XAc1cC8WNDfYBN/JY9M4eRY3Cf#HFC74)
9\8B>JeLWUC.HGe]55X2W\,X[eG=QMf^\6b6,NK1Kg.HKUc=IW\[6LX=A;-GI4AF
]K)QD9ES@FTF7?/-#(c=L8;+0K>#;C0f7HK2[9,Y>9,,-XE,HaY;]Dc<1\]W\+\.
R1=Y0Fb0\d-OQ_PG74Z5^6f)(5ZL9fW&\:BP7d7K.Pe2N9[MF9:F6GNCUHE/fYS0
XXffDOg1/&TXb8#\,\MQ\QeE96FDTH<+7-6X3gH\I4F6>e2HfG+#<UKC.@1Z5DYD
@gAd\;N#I0ZDNVNP8#1g(DK_e3abP+Cg)S@[dU8F>?AZQQ/-X:02efOAWX#H9D/Y
EV,U&9\U:<2)EE_e):bVO723H&eK,8=FdR#FELPJ/@==HY2TF8_CbOgY1>SNd1G7
/E(;^c)4f&47HfC67<R[A:W-J_6@@/:WSK@21UC:@R@BD6e4/aBfcTa^F2&6FKRI
,g&K=cI,(d[L04B/&JMSSgcMaJdKBSL;XC]D6;/-50#UG,#E[[>]</KB-#bW]Xe:
6<U=4TH5ZZAA15+2EJ2[CEF=;S_PdUM?ZeFAJ&XM2f5ZL9FK\UDOC4)<Va_(Z7AB
EYZ]D<3@P59^<P:42e)KaWL;#PdF-Q0=Xd6d6B))07HV?Dce[EBNIGdFH:4Z\(gQ
F5+Xd\04?:,@?@=/&7NT=fb1dH28FWGXf>3K12dM01,L_?EE)>:JCRF^[0C95b>1
L=G7(,c:#PEP2K8,AJPX]gM[]:^B=7=SQCWMCT#UTAR[-ER\FYP&Bd.DF]/:K6N8
,RO?++F+BG0F4;O1V3.>GEGF/>&.?K9N/7c.D+)A<;e)TVS@)[QTZ(BReF#c[a@;
)b>#?)Y](&NR,NW>Q84fJJ^A>dW9-LJKY>6eX1-(97Uf@#?T<KbW6\:B<7E;^G-Z
:\+92IINc@,Gb0-#QHEAA0K3[ZAU;QZ2+<@\6F,:XHL/.RWEf)A+>3D;LW,UP5U2
5CK>_c/CbaMZcT/+2?.79<?D5eWUYRUa?K^93aIPRMT(bBQ.08&_KbR;IYUG\(:e
=XXXO3VLRR5\F1/gLG_M-)R+[e]4\a(O.T1225F>52S-dV\Y&JbKZ8V=db1G;XS\
ETHUdJA,V&Q-MGID;W?ICY-Y52U7+;eA]CJEVgb<.2A\BbK=E6YAD1(3e1FG[0P-
ef)G0W]=f^g.I@=N+#U>66UR_ST,T/cGTRRBZ_0IR_Q/;fR^,>_INS,J2SZE1OLJ
-6.^=Rdf3ZJ/E0;&>(S?aX\1:;]PW,(E)B^g1T]RR;DGAeD)OH/Hg6@AWaX.BS0?
L:3S9+YZ..Q,70GbF8WHb,fE249;e#\H6^Xa[DT.RaQF6GA1CYf5(aY::8X1<DJ6
:,<[WPNM.N)\1=Kf&Y2[00X,:USIVfd:F\K.E1MdQM)1,9bP@gGIG=gg/CUZ)(\e
Z<INZT9H#0(WbJeE7,gN6L&b6>+.#T]JaGE11=fFaLFN@)I/]f1OYIZ=YeR(gQZe
5RYK.YI^B(-&W:#\&H=?6GWM/<8ANgUUd1^bI;.]HI^H:_HY/FTW>G-+R(0+C>9A
>=\VK:W,Y(A#P?8b_3c09TF<_#3>e)4]L9Q-eR9)8>I-:a+KQXQ#)bDOXXC.X,XI
:)Y5U;MTE/KEb4F8N@J6gY\aH?EBcd0/3c#78#O/@I9W2M6K1SYW<H]^2D<PgRI:
IFO6U>GZEL(F5gd?M<<J@JSb]3f+<#5Y]&bHCX#CZPWD0\VRSgEUM;]3DEB^<OHf
3aO,)QJbeWVde=\\4ZYR8DcSa,1D<G,J0^F_G9/-@(_WOb:&f@-4X_]@B0C?6aP3
I(b)F=WOeR02BNS\-##41L\)1C6<ZC\ZdA(2-9]SMFU]5C<9A#=A@U#f1)RKB;(C
a@66N@AAXW&>RG1.O-V&-A+b6eI5;KGGG0Hd,<e/bSN]Jb)4P\W2WXB3S#J13)59
J5;N5-K#-3_,A5[D9=6)9Wa+3eB-[d7(UDYB,[M@IfG6YN@AT\U\[)5#G1/H2#fe
F9A5eJVfeH(3+/A=[>Z24E&):)CLdZY2&8-?a52PLR54@K]9Z3:U5dN(&:VbBYEZ
J&(agaAaGK6d1g&DD-.&L^V5V0Q-bIA]/=^DHQ?U5<>HBT8Z[d]?7WPJD&NAefGa
[_J+/.TK5?E[;AO#+^f?,G:C,4:N95L\:EVc@EWEOGg@_QGJ<-;Xe]:=,0063K.8
-;\@W,O,>QNVPLbL@FY7_B/F\O@f4dXA5QTX4PU-MC+;XW)XBVEOTSK#:@^<&]M0
5XL:=64E/,;F:55]C6_VX<HO2^gAeQ/;2&?-L[0?SgXB+@VIW(BOOJ4X7EN,NM6J
]IOREVQ_Y70KX5[]ESVcW/BcUUZa9;E]_)=9_3M&8VI>();4(R8+>[NH:JA^UR2/
b#F/8/.USC1)T.OJ3IJ+Z60cf[0592T_#H#)0G@-9\gMBM.[Zc8TIK]8+eZ)BCb/
:CT;0.d#+)_JCGdaZ<IT?/JL&;\cV3U3dKE>H?dc>A<M:1bBMG4bP_\8E3e(YB\>
g8VN,[g^:LF#PI&gO]MC(D5CJe.<:M\b,JF];-f4(T;FN^^Afb/QcSXd/c/)6?8(
eHINc2ZH.MCKX_(5-7I^>b53D?N(-@9UPg_Z#6Y4g#Fd;X#M]S//+9^Q.]aM]E.@
.]Q#TD_B_Q)I(MCMX8?e>RM?S-8\E#,d-/6K(U]0ON,-2Y+7^670XVY4^C1:E[EU
^I8@U\NJ5fU)G,YKI,U:3d];d_@.eC1UU2-&;U/]GR4J7TW;UU>LTX)(,L;VF\W_
Z7N4G7W4>[@BMfPZ9OO^Ig4<KM;M1<DR(N\UBKBWG]+:&T#;9X[=8[0Z@C9=Y/Q.
@8?3.2EX<Q5Id#XB.E]IJHeJGSHXT.WQT;[R-O/C&fC;.H/03c_:Q6@EMN5OY@XX
bNa]38L[^.A2;a22E0dH][B9OQ1;]f1VF35Sf[c&;^U@g_69EVE^-5M2e6MG1daB
27cEAe8T,&-KSH6[aB<FgLL[d#UJ#UIQ5:T)=I)A_&FJ8<8<-dcXdL#=&17E3#6X
PZ?9,>3_9RL,_KCac>Y[,Q:;\N(E.F52Sb6bX6:=.Ia>\A&&XMK7<f5b(TAN<f:_
L<9IgQb)gX.W\A+(L=]+_=CAM@G&a^\.JNXWWUE,]&U/H.5(=9=):Z&M#^^8OV2L
O/5247X<-6[B5:4T]T/[fVK^?5R[AgR-.CB5KXL73O)R=02J+V]f^dG;\3712d4.
a/>RH]RP_RPP.bY@0BY^d9aRDOJaJeS^a0Z-Fd#\>=GG0/TP^QCB)LRL35R?X0aK
N1&GOURX+Y-5ggDVFSYfCE11>QOb0(9NDgG8,@PJ4_WObgOFVNIY(V;=88ORMOQ1
f,319V@DD]1Ee1.C_[WF#3=D\BND;6?.aG(^AB8H9J/^UU.4@X=dR-#ZMfEDaeV#
0L\cCgRfg(I>EJN2ZTE15=SWI,)\9T+Dg_E.?abg78?8Y<CUdb<B5#a\eEC9LH?K
PF2eDZ)B@DKGC=KZ8MK/bacU/;Wc.P:2LYPZR6Z:3UJ)bBCV7^DUMV9M86+D[^&0
g&^[2&S,JPBT?f_)gPFVN5c\8P^8B)c,a^e]KBLNeMV+X(][e?_H;)Q5@JWB?3bF
#X7-(?f]1IB1UQaf/JK6RNQ7W(D#QB\,,>EX=P15T0e[)G8b>/5\JU1)[6J,BQdc
LeSTP18NR=7R)\PT?H1[N9+HED7@([KI<MeGYK\IQ2Lefe\=#HG5^V9618f-[);3
A-V+7ST+F(HN0R1(bH;g?Z#&9I,U)QQU&Y:UNd=[IS-8UPRgBR#ZO;dBXUK@/(,0
/6\NaBZE[fSYK3<IEUNN22W,HbQ\G-20(-VA3:W=8.C/FQOSaJ,+ae&.@;(UW;J+
#=]]>Y#I<SF,ec\V@M@ZQF,MffALO2M-fG8F77SL&DR?-^8N3AFb/PAeC+DDgB,T
;26?&IM,XR-BcTQY:Z7I<e7Ae9#_0OK8.V]6+]HYQ/+GW)@XO.8/:bR4_GPb6(7I
6(H13Q22QF_dBI+(3<=5])60S5A?feJ;ACXfH4H9B1^7+\N@#E&_,Z)YRIJ1<3@=
_e02g3[E9F<c2,HNR4V?B5aL=DdF+DKg7fML?_GgF;QWO&[&(e2#Ma@AFIc+e4G2
^002fC35QP##OedN9[#K;5aFB^4L7;Q,7CZNPOBRK:d;5V8CU+0Q\d7_&6G-2D&@
VG@Fd3&NU2._G6.,Z+Z)1ZGefOdbc@bZJa_Oc2[cf9HWUgeETYM-aBJfUZ#R7f7.
M-7f2[Y(RK]CN]@dIEe08L0Z)-c?9ZAJa3-gPJI(]LfM@MGe01M?SP:9<0:T\:BI
SL+9L_-BSL6\MMZ0-,H4aaZa,+LG9LMYOI#<N>IPG=-eI_>(GLLIEb[X(TC5bF[e
=D@V8I8d#A-(BN\6.9RNGPY-89/VeW#\G3PI&7,D4^.e8AKN=L1N,Q@6Adb@?(#Z
68:YRY5,#)3S1&&ZA+Ag42FVXbac6^aC8O:Q7H@\9HRMdT@]9g)9>7-GZ+\;S2\T
A7;6a8T^J:?gQI8fB.AY\;I?]1/XV+7IL4.G>6PV7Vd+-Y6,-[H(9JU21Z6gO,6E
.bBH=L,F@TN21?P99JXJ3>S<7,/[a2[[TcM[F?X:U4(:N6F&2,(-:d87_S\6PBAe
P.?g1D0:\4MaXXOLaS)We(BD,HZ<,D6SI[/N/^FJ:a9H8@]^&,cGT\3afb9;\COD
0=-1be;edJ4>IPCEc6G-3PI3D>MO,d4&?&T4K>W(]f]Y3dLVAY&V1+D\eLLDS,ZS
J03P8VCB3/bRe9.W>;[XAc]^VN6OZ.)&OQEbO4Ma1(=86\.Q5G^@0?L1;<K0ZCNX
[&X[ZY?9L2U_5,KRU:T^2HOSD1WKLAYB\;8[8DIe=+.+=cZf[3.PX3c]:P;RWAJC
Q0J(B/&ZA=G:#_P3H+)=_X^gY&1C[]>]ET1bQGM?U_/-fX77L6g&-1)^dWHb>NN&
+L;(We2b07@:<-?X:OH4I1&YQWHae<QgB3BGCb@b#)4UD0&d/E=7W[@1-bGAAfQH
6Q9NKP9V=DBU(+Pa94;7V555Y75:V?f(g\<;[3VX3.4\ZV3Vea0L(45dK:c:ICW]
7?J5ZT;gJ&#AT<NOJ&N,B06EfS/7_gMGWFXWC_>./)BN4K(FJ+.)b]\3RO2O4?>I
3#O0Xa+1;D:K_<BO/>82-/.X4P-I09-f>53fN^TRZIaf4cc;^:NcbP\3K$
`endprotected


`endif // GUARD_SVT_SPI_TRANSACTION_EXCEPTION_SV
