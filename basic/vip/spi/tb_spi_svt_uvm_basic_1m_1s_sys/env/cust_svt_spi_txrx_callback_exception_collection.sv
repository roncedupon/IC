
/** 
 * Task exception_callback class. Extend the callback to write own callback 
 */

class cust_svt_spi_txrx_callback_exception_base extends svt_spi_txrx_callback;

  svt_spi_configuration cfg = null;
  //create a local handle of exception class and exception list
  svt_spi_transaction_exception_list cust_exception_list;
  svt_spi_transaction_exception      exception;
  /** This flag when set insert exception to tansaction object. */
  bit insert_exception = 0;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    //create the exception class
    exception = new("cust_exception");
    exception.xact = xact;
    //create the exception list
    cust_exception_list = new("cust_exception_list",exception);
    //assign the type of error to be inserted in exception class
    exception.cfg = this.cfg;       

  endfunction
endclass

//----------------------------------------------------------------------------------------------------------------------
class cust_svt_spi_txrx_callback_override_idle_phase_tristate_error extends cust_svt_spi_txrx_callback_exception_base;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name, agent_cfg);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    super.post_seq_item_get(txrx, xact, drop);
    //assign the type of error to be inserted in exception class
    if (!exception.randomize() with{
      exception.error_kind      == svt_spi_transaction_exception::SPI_ERROR_KIND;
      exception.spi_error_kind  == svt_spi_transaction_exception::SPI_OVERRIDE_IDLE_PHASE_TRISTATE;
    }) 
    begin
      `uvm_fatal("post_seq_item_get", "Exception Callback Randomization failure.");
    end

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);
    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;
    xact.timer_idling_between_transfers = `SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER + 5;
  endfunction
endclass

//----------------------------------------------------------------------------------------------------------------------
class cust_svt_spi_txrx_callback_override_wait_phase_tristate_error extends cust_svt_spi_txrx_callback_exception_base;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name, agent_cfg);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    super.post_seq_item_get(txrx, xact, drop);
    //assign the type of error to be inserted in exception class
    if (!exception.randomize() with{
      exception.error_kind      == svt_spi_transaction_exception::SPI_ERROR_KIND;
      exception.spi_error_kind  == svt_spi_transaction_exception::SPI_OVERRIDE_WAIT_PHASE_TRISTATE;
    }) 
    begin
      `uvm_fatal("post_seq_item_get", "Exception Callback Randomization failure.");
    end

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);
    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;
  endfunction
endclass

//----------------------------------------------------------------------------------------------------------------------
class cust_svt_spi_txrx_callback_override_data_phase_tristate_error extends cust_svt_spi_txrx_callback_exception_base;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name, agent_cfg);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    super.post_seq_item_get(txrx, xact, drop);
    //assign the type of error to be inserted in exception class
    if (!exception.randomize() with{
      exception.error_kind      == svt_spi_transaction_exception::SPI_ERROR_KIND;
      exception.spi_error_kind  == svt_spi_transaction_exception::SPI_OVERRIDE_DATA_PHASE_TRISTATE;
    }) 
    begin
      `uvm_fatal("post_seq_item_get", "Exception Callback Randomization failure.");
    end

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);
    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;
  endfunction
endclass

//----------------------------------------------------------------------------------------------------------------------
class cust_svt_spi_txrx_callback_idle_phase_clock_toggle_error extends cust_svt_spi_txrx_callback_exception_base;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name, agent_cfg);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    super.post_seq_item_get(txrx, xact, drop);

    //assign the type of error to be inserted in exception class
    if (!exception.randomize() with{
      exception.error_kind      == svt_spi_transaction_exception::SPI_ERROR_KIND;
      exception.spi_error_kind  == svt_spi_transaction_exception::SPI_IDLE_PHASE_CLOCK_TOGGLE;
      exception.exception_error_position > 2; 
    }) 
    begin
      `uvm_fatal("post_seq_item_get", "Exception Callback Randomization failure.");
    end

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);
    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;
  endfunction
endclass


//----------------------------------------------------------------------------------------------------------------------
class cust_svt_spi_txrx_master_callback_min_leading_timer_error extends cust_svt_spi_txrx_callback_exception_base;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name, agent_cfg);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    super.post_seq_item_get(txrx, xact, drop);

    /** 
     * Insering exception to every alternate transaction sequence, 
     * thus generating odd even error sceanrios. 
     */
    insert_exception = ~insert_exception;
    if(insert_exception) begin
      if (!exception.randomize() with{
        exception.error_kind     == svt_spi_transaction_exception::SPI_ERROR_KIND;
        exception.spi_error_kind == svt_spi_transaction_exception::SPI_LEADING_TIME_DEVIATION;
        })
      begin
        `uvm_fatal("post_seq_item_get", "Exception Callback Randomization failure.");
      end
      //Add the exception class to the exception list
      cust_exception_list.add_exception(exception);
      //write the handle of the exception list on the trans class handle
      xact.exception_list = cust_exception_list;
    end
  endfunction

endclass

//----------------------------------------------------------------------------------------------------------------------
class cust_svt_spi_txrx_master_callback_min_trailing_timer_error extends cust_svt_spi_txrx_callback_exception_base;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name, agent_cfg);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    super.post_seq_item_get(txrx, xact, drop);

    /** 
     * Insering exception to every alternate transaction sequence, 
     * thus generating odd even error sceanrios. 
     */
    insert_exception = ~insert_exception;
    if(insert_exception) begin
      if (!exception.randomize() with{
        exception.error_kind     == svt_spi_transaction_exception::SPI_ERROR_KIND;
        exception.spi_error_kind == svt_spi_transaction_exception::SPI_TRAILING_TIME_DEVIATION;
        })
      begin
        `uvm_fatal("post_seq_item_get", "Exception Callback Randomization failure.");
      end
    
      //Add the exception class to the exception list
      cust_exception_list.add_exception(exception);
      //write the handle of the exception list on the trans class handle
      xact.exception_list = cust_exception_list;
    end
  endfunction

endclass

//----------------------------------------------------------------------------------------------------------------------
class cust_svt_spi_txrx_master_callback_min_idle_time_error extends cust_svt_spi_txrx_callback_exception_base;

  function new(string name, cust_svt_spi_agent_configuration agent_cfg);
    super.new(name, agent_cfg);
    if(!$cast(this.cfg,agent_cfg))
      `uvm_fatal("build_phase", "cfg not initialized");
  endfunction
  
  //Callback method
  virtual function void post_seq_item_get(svt_spi_txrx txrx,svt_spi_transaction xact, ref bit drop);
    super.post_seq_item_get(txrx, xact, drop);

    /** 
     * Insering exception to every alternate transaction sequence, 
     * thus generating odd even error sceanrios. 
     */
    insert_exception = ~insert_exception;
    if(insert_exception) begin
      if (!exception.randomize() with{
        exception.error_kind     == svt_spi_transaction_exception::SPI_ERROR_KIND;
        exception.spi_error_kind == svt_spi_transaction_exception::SPI_IDLE_TIME_DEVIATION;
        })
      begin
        `uvm_fatal("post_seq_item_get", "Exception Callback Randomization failure.");
      end 
        //Add the exception class to the exception list
        cust_exception_list.add_exception(exception);
        //write the handle of the exception list on the trans class handle
        xact.exception_list = cust_exception_list;
    end
  endfunction
endclass
