//=======================================================================
// COPYRIGHT (C) 2011-2016 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_REPORT_CATCHER_SV
`define GUARD_SVT_REPORT_CATCHER_SV

// =============================================================================
/**
 * Used to get around the fact that ovm_report_object is an abstract virtual object
 * in OVM 2.1.1/2.1.1_1.
 */
class svt_non_abstract_report_object extends `SVT_XVM(report_object);

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR:
   *
   * Just call the super.
   *
   * @param name Instance name of this object.
   */
  function new(string name = "svt_non_abstract_report_object");
    super.new(name);
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Static function which can be used to create a new svt_non_abstract_report_object.
   */
  static function `SVT_XVM(report_object) create_non_abstract_report_object(string name = "svt_non_abstract_report_object");
    svt_non_abstract_report_object na_report_object = new(name);
    create_non_abstract_report_object = na_report_object;
  endfunction

  // ---------------------------------------------------------------------------
endclass
 
`ifdef SVT_UVM_TECHNOLOGY

typedef uvm_report_catcher svt_report_catcher;

`elsif SVT_OVM_TECHNOLOGY

`define SVT_REPORT_CATCHER_SEVERITY severity
`define SVT_REPORT_CATCHER_ACTION action

class svt_report_catcher extends ovm_object;
  typedef enum { UNKNOWN_ACTION, THROW, CAUGHT} action_e;

  bit is_on ;

  local static ovm_severity m_modified_severity;
  local static int m_modified_verbosity;
  local static string m_modified_id;
  local static string m_modified_message;
  local static string m_file_name;
  local static int m_line_number;
  local static ovm_report_object m_client;
  local static ovm_action m_modified_action;
  local static bit m_set_action_called;
  local static ovm_report_server m_server;
  local static string m_name;
  
  local static int m_demoted_fatal;
  local static int m_demoted_error;
  local static int m_demoted_warning;
  local static int m_caught_fatal;
  local static int m_caught_error;
  local static int m_caught_warning;

  local static  ovm_severity  m_orig_severity;
  local static  ovm_action    m_orig_action;
  local static  string        m_orig_id;
  local static  int           m_orig_verbosity;
  local static  string        m_orig_message;

  local static  bit do_report;


  function new(string name);
     super.new(name);
     is_on = 1;
  endfunction

   
  // Group: Current Message State

  /**
   * Function: get_client
   *
   * Returns the <ovm_report_object> that has generated the message that
   * is currently being processes.
   */
  function ovm_report_object get_client();
    return this.m_client; 
  endfunction

  /**
   * Function: get_severity
   *
   * Returns the <ovm_severity> of the message that is currently being
   * processed. If the severity was modified by a previously executed
   * report object (which re-threw the message), then the returned 
   * severity is the modified value.
   */
  function ovm_severity get_severity();
    return this.m_modified_severity;
  endfunction
  
  /**
   * Function: get_verbosity
   *
   * Returns the verbosity of the message that is currently being
   * processed. If the verbosity was modified by a previously executed
   * report object (which re-threw the message), then the returned 
   * verbosity is the modified value.
   */
  function int get_verbosity();
    return this.m_modified_verbosity;
  endfunction
  
  /**
   * Function: get_id
   *
   * Returns the string id of the message that is currently being
   * processed. If the id was modified by a previously executed
   * report object (which re-threw the message), then the returned 
   * id is the modified value.
   */
  function string get_id();
    return this.m_modified_id;
  endfunction
  
  /**
   * Function: get_message
   *
   * Returns the string message of the message that is currently being
   * processed. If the message was modified by a previously executed
   * report object (which re-threw the message), then the returned 
   * message is the modified value.
   */
  function string get_message();
     return this.m_modified_message;
  endfunction
  
  /**
   * Function: get_action
   *
   * Returns the <ovm_action> of the message that is currently being
   * processed. If the action was modified by a previously executed
   * report object (which re-threw the message), then the returned 
   * action is the modified value.
   */
  function ovm_action get_action();
    return this.m_modified_action;
  endfunction
  
  /**
   * Function: get_fname
   *
   * Returns the file name of the message.
   */
  function string get_fname();
    return this.m_file_name;
  endfunction             

  /**
   * Function: get_line
   *
   * Returns the line number of the message.
   */
  function int get_line();
    return this.m_line_number;
  endfunction
  
  // Group: Change Message State

  /**
   * Function: set_severity
   *
   * Change the severity of the message to ~severity~. Any other
   * report catchers will see the modified value.
   */
  protected function void set_severity(ovm_severity severity);
    this.m_modified_severity = severity;
  endfunction
  
  /**
   * Function: set_verbosity
   *
   * Change the verbosity of the message to ~verbosity~. Any other
   * report catchers will see the modified value.
   */
  protected function void set_verbosity(int verbosity);
    this.m_modified_verbosity = verbosity;
  endfunction      

  /**
   * Function: set_id
   *
   * Change the id of the message to ~id~. Any other
   * report catchers will see the modified value.
   */
  protected function void set_id(string id);
    this.m_modified_id = id;
  endfunction
  
  /**
   * Function: set_message
   *
   * Change the text of the message to ~message~. Any other
   * report catchers will see the modified value.
   */
  protected function void set_message(string message);
    this.m_modified_message = message;
  endfunction
  
  /**
   * Function: set_action
   *
   * Change the action of the message to ~action~. Any other
   * report catchers will see the modified value.
   */
  protected function void set_action(ovm_action action);
    this.m_modified_action = action;
    this.m_set_action_called = 1;
  endfunction
  
  /**
   * Function: catch
   *
   * This is the method that is called for each registered report catcher.
   * There are no arguments to this function. The <Current Message State>
   * interface methods can be used to access information about the 
   * current message being processed.
   */
  virtual function action_e catch();
    return THROW;
  endfunction

  // Group: Reporting

  /**
   * Function: ovm_report_fatal
   *
   * Issues a fatal message using the current messages report object.
   * This message will bypass any message catching callbacks.
   */
  protected function void ovm_report_fatal(string id, string message, int verbosity, string fname = "", int line = 0 );
     string m;
     ovm_action a;
     OVM_FILE f;
     ovm_report_handler rh;
     
     rh   = this.m_client.get_report_handler();
     a    = rh.get_action(OVM_FATAL,id);
     f    = rh.get_file_handle(OVM_FATAL,id);
     
     m    = this.m_server.compose_message(OVM_FATAL,this.m_name, id, message, fname, line);
     this.m_server.process_report(OVM_FATAL, this.m_name, id, message, a, f, fname, line,
                                  m, verbosity, this.m_client);
  endfunction  

  /**
   * Function: ovm_report_error
   *
   * Issues a error message using the current messages report object.
   * This message will bypass any message catching callbacks.
   */
  protected function void ovm_report_error(string id, string message, int verbosity, string fname = "", int line = 0 );
     string m;
     ovm_action a;
     OVM_FILE f;
     ovm_report_handler rh;
     
     rh   = this.m_client.get_report_handler();
     a    = rh.get_action(OVM_ERROR,id);
     f    = rh.get_file_handle(OVM_ERROR,id);
     
     m    = this.m_server.compose_message(OVM_ERROR,this.m_name, id, message, fname, line);
     this.m_server.process_report(OVM_ERROR, this.m_name, id, message, a, f, fname, line,
                                  m, verbosity, this.m_client);
  endfunction  

  /**
   * Function: ovm_report_warning
   *
   * Issues a warning message using the current messages report object.
   * This message will bypass any message catching callbacks.
   */
  protected function void ovm_report_warning(string id, string message, int verbosity, string fname = "", int line = 0 );
     string m;
     ovm_action a;
     OVM_FILE f;
     ovm_report_handler rh;
     
     rh   = this.m_client.get_report_handler();
     a    = rh.get_action(OVM_WARNING,id);
     f    = rh.get_file_handle(OVM_WARNING,id);
     
     m    = this.m_server.compose_message(OVM_WARNING,this.m_name, id, message, fname, line);
     this.m_server.process_report(OVM_WARNING, this.m_name, id, message, a, f, fname, line,
                                  m, verbosity, this.m_client);
   endfunction  

  /**
   * Function: ovm_report_info
   *
   * Issues a info message using the current messages report object.
   * This message will bypass any message catching callbacks.
   */
  protected function void ovm_report_info(string id, string message, int verbosity, string fname = "", int line = 0 );
     string m;
     ovm_action a;
     OVM_FILE f;
     ovm_report_handler rh;
     rh    = this.m_client.get_report_handler();
     a    = rh.get_action(OVM_INFO,id);
     f     = rh.get_file_handle(OVM_INFO,id);
     
     m     = this.m_server.compose_message(OVM_INFO,this.m_name, id, message, fname, line);
     this.m_server.process_report(OVM_INFO, this.m_name, id, message, a, f, fname, line,
                                  m, verbosity, this.m_client);
  endfunction  

  /**
   * Function: issue
   * Immediately issues the message which is currently being processed. This
   * is useful if the message is being ~CAUGHT~ but should still be emitted.
   *
   * Issuing a message will update the report_server stats, possibly multiple 
   * times if the message is not ~CAUGHT~.
   */
  protected function void issue();
     string m;
     ovm_action a;
     OVM_FILE f;
     ovm_report_handler rh;
     
     rh = this.m_client.get_report_handler();
     a  =  this.m_modified_action;
     f  = rh.get_file_handle(this.m_modified_severity,this.m_modified_id);
     
     m  = this.m_server.compose_message(this.m_modified_severity, this.m_name,
                                        this.m_modified_id,
                                        this.m_modified_message,
                                        this.m_file_name, this.m_line_number);
     this.m_server.process_report(this.m_modified_severity, this.m_name,
                                  this.m_modified_id, this.m_modified_message,
                                  a, f, this.m_file_name, this.m_line_number,
                                  m, this.m_modified_verbosity,this.m_client);
  endfunction


  static local svt_report_catcher m_catchers[$];

  function void append();
`ifdef INCA
    // For some reason its legal in NC to call methods on null objects. Since its come up in internal testing,
    // flag it and avoid getting into more trouble downstream.
    if (this == null) begin
      ovm_report_error("RPTCTHRAPP", "append() method called for null 'this'. Ignored.", OVM_NONE, `ovm_file, `ovm_line);
      return;
    end
`endif
    foreach (m_catchers[i]) begin
      if (m_catchers[i] == this) return;
    end
    m_catchers.push_back(this);
  endfunction

  function void prepend();
     foreach (m_catchers[i]) begin
        if (m_catchers[i] == this) return;
     end
     m_catchers.push_front(this);
  endfunction

  function void delete();
     foreach (m_catchers[i]) begin
        if (m_catchers[i] == this) begin
           m_catchers.delete(i);
           return;
        end
     end
  endfunction

  static function void delete_all();
     m_catchers.delete();
  endfunction

  /**
   * process_all_report_catchers
   * method called by report_server.report to process catchers
   */
  static function int process_all_report_catchers( 
    input ovm_report_server server,
    input ovm_report_object client,
    ref ovm_severity severity, 
    input string name, 
    ref string id,
    ref string message,
    ref int verbosity_level,
    ref ovm_action action,
    input string filename,
    input int line 
  );
    int iter;
    svt_report_catcher catcher;
    int thrown = 1;
    ovm_severity orig_severity;
    static bit in_catcher;

    if(in_catcher == 1) begin
        return 1;
    end
    in_catcher = 1;    

    m_server             = server;
    m_client             = client;
    orig_severity        = severity;
    m_name               = name;
    m_file_name          = filename;
    m_line_number        = line;
    m_modified_id        = id;
    m_modified_severity  = severity;
    m_modified_message   = message;
    m_modified_verbosity = verbosity_level;
    m_modified_action    = action;

    m_orig_severity  = severity;
    m_orig_id        = id;
    m_orig_verbosity = verbosity_level;
    m_orig_action    = action;
    m_orig_message   = message;      

    foreach (m_catchers[i]) begin
      ovm_severity prev_sev;

      catcher = m_catchers[i];
       
      if (!catcher.is_on) continue;

      prev_sev = m_modified_severity;
      m_set_action_called = 0;
      thrown = catcher.process_report_catcher();

      // Set the action to the default action for the new severity
      // if it is still at the default for the previous severity,
      // unless it was explicitly set.
      if (!m_set_action_called &&
          m_modified_severity != prev_sev &&
          m_modified_action == m_client.get_report_action(prev_sev, "*@&*^*^*#")) begin
         m_modified_action = m_client.get_report_action(m_modified_severity, "*@&*^*^*#");
      end

      if(thrown == 0) begin 
        case(orig_severity)
          OVM_FATAL:   m_caught_fatal++;
          OVM_ERROR:   m_caught_error++;
          OVM_WARNING: m_caught_warning++;
         endcase   
         break;
      end 
    end //while

    // update counters if message was returned with demoted severity
    case(orig_severity)
      OVM_FATAL:    
        if(m_modified_severity < orig_severity)
          m_demoted_fatal++;
      OVM_ERROR:
        if(m_modified_severity < orig_severity)
          m_demoted_error++;
      OVM_WARNING:
        if(m_modified_severity < orig_severity)
          m_demoted_warning++;
    endcase
   
    in_catcher = 0;

    severity     = m_modified_severity;
    id              = m_modified_id;
    message         = m_modified_message;
    verbosity_level = m_modified_verbosity;
    action          = m_modified_action;

    return thrown; 
  endfunction

  /**
   * process_report_catcher
   * internal method to call user catch() method
   */
  local function int process_report_catcher();

    action_e act;

    act = this.catch();

    if(act == UNKNOWN_ACTION)
      this.ovm_report_error("RPTCTHR", {"ovm_report_this.catch() in catcher instance ", get_name(), " must return THROW or CAUGHT"}, OVM_NONE, `ovm_file, `ovm_line);

    return 1;

  endfunction

  /**
   * f_display
   * internal method to check if file is open
   */
  local static function void f_display(OVM_FILE file, string str);
    if (file == 0)
      $display("%s", str);
    else
      $fdisplay(file, "%s", str);
  endfunction

  /**
   * Function: summarize_report_catcher
   *
   * This function is called automatically by <ovm_report_server::summarize()>.
   * It prints the statistics for the active catchers.
   */
  static function void summarize_report_catcher(OVM_FILE file);
    string s;
    if(do_report) begin
      f_display(file, "");   
      f_display(file, "--- OVM Report catcher Summary ---");
      f_display(file, "");   
      f_display(file, "");
  
      $sformat(s, "Number of demoted OVM_FATAL reports  :%5d", m_demoted_fatal);
      f_display(file,s);
  
      $sformat(s, "Number of demoted OVM_ERROR reports  :%5d", m_demoted_error);
      f_display(file,s);
  
      $sformat(s, "Number of demoted OVM_WARNING reports:%5d", m_demoted_warning);
      f_display(file,s);

      $sformat(s, "Number of caught OVM_FATAL reports   :%5d", m_caught_fatal);
      f_display(file,s);
  
      $sformat(s, "Number of caught OVM_ERROR reports   :%5d", m_caught_error);
      f_display(file,s);
  
      $sformat(s, "Number of caught OVM_WARNING reports :%5d", m_caught_warning);
      f_display(file,s);
    end
  endfunction

endclass


class svt_ovm_report_server extends ovm_report_server;
   `_protected function new();
   endfunction

   static local svt_ovm_report_server m_singleton;

   static function svt_ovm_report_server get();
      if (m_singleton == null) m_singleton = new;
      return m_singleton;
   endfunction

   static local bit m_initialized = m_initialize();
   static local function bit m_initialize();
      ovm_report_global_server glob;
      svt_ovm_report_server svr;

      if (m_initialized) return 1;

      svr = svt_ovm_report_server::get();
      glob = new();
      glob.set_server(svr);

      return 1;
   endfunction

   static function void initialize();
      m_initialized = m_initialize();
   endfunction

   virtual function void report(
      ovm_severity severity,
      string name,
      string id,
      string message,
      int verbosity_level,
      string filename,
      int line,
      ovm_report_object client
      );
    string m;
    ovm_action a;
    OVM_FILE f;
    bit report_ok;
    ovm_report_handler rh;

    rh = client.get_report_handler();
    
    // filter based on verbosity level
 
    if(severity == ovm_severity'(OVM_INFO) && verbosity_level > rh.m_max_verbosity_level) begin
       return;
    end

    // determine file to send report and actions to execute

    a = rh.get_action(severity, id); 
    if( ovm_action_type'(a) == OVM_NO_ACTION )
      return;

    f = rh.get_file_handle(severity, id);

    // The hooks can do additional filtering.  If the hook function
    // return 1 then continue processing the report.  If the hook
    // returns 0 then skip processing the report.

    if(a & OVM_CALL_HOOK)
      report_ok = rh.run_hooks(client, severity, id,
                              message, verbosity_level, filename, line);
    else
      report_ok = 1;

    if(report_ok)
      report_ok = svt_report_catcher::process_all_report_catchers(
                     this, client, severity, name, id, message,
                     verbosity_level, a, filename, line);

    if(report_ok) begin
      m = compose_message(severity, name, id, message, filename, line); 
      process_report(severity, name, id, message, a, f, filename,
                     line, m, verbosity_level, client);
    end
    
   endfunction
endclass

`endif // SVT_UVM_TECHNOLOGY

`endif // GUARD_SVT_REPORT_CATCHER_SV
