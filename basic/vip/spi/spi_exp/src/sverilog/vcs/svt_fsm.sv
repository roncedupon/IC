//=======================================================================
// COPYRIGHT (C) 2012-2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_FSM_SV
`define GUARD_SVT_FSM_SV

/**
 * The following define is provided to let clients know that this version
 * of the FSM implementation includes support for different transition
 * options, as defined by svt_fsm_state_base::state_transition_options_enum.
 * Prior to these options being available the only supported transition
 * choice was svt_fsm_state_base::EXTERNAL_INTERRUPT_NEXT.
 *
 * With the addition of these options VIPs can improve their performance
 * by updating to support and utilize the svt_fsm_state_base::INTERNAL_INTERRUPT_NEXT
 * transition choice.
 */
`define SVT_FSM_TRANSITION_OPTIONS_EXIST

// This code will need to be refactored to work with SVDOC (or SVDOC will need
// to be updated.

/** Automatically include the required support code
 *  for the specified FSM state type.
 *  Must be called in the FSM state class.
 */
`define svt_fsm_state_utils(__T) \
   `svt_type_factory_item(__T, svt_fsm_state_base) \
   virtual function string get_class_name(); return `SVT_DATA_UTIL_ARG_TO_STRING(__T); endfunction


/** Automatically include the required support code
 *  for the specified FSM type.
 *  Must be called in the FSM class.
 */
`define svt_fsm_utils(__T) \
   `svt_type_factory_item(__T, svt_fsm)

/** Create a state of the specified type in the specified variable.
 *  Must be used in the svt_fsm::build() method.
 */
`define svt_fsm_create_state(T, _st) \
begin \
   $cast(_st, m_create_state(T::__type::get())); \
   _st.set_fsm(this); \
end

/** Create a sub-FSM of the specified type with the specified name in the specified variable.
 *  Must be used in the svt_fsm::build() method.
 */
`define svt_fsm_create_fsm(T, _fsm, _name) \
begin \
   $cast(_fsm, create_fsm(T::__type::get(), _name)); \
end

/** Short-hand macro for defining the set of states than can transition
 *  into this state.
 *  Simply appends the specified array litteral of states to the list of
 *  incoming states specified by the base class.
 *  Must be specified within the state definition class,
 *  instead of explicitly implementing the svt_fsm_state_base::m_incoming_states() method.
 */
`define svt_fsm_from_states(_st) \
protected virtual function void m_incoming_states(ref svt_fsm_state_base state_q[$]); \
  svt_fsm_state_base new_q[$] = _st; \
  super.m_incoming_states(state_q); \
  state_q = {state_q, new_q}; \
endfunction


typedef class svt_fsm;
typedef class svt_fsm_state_base;

/**
 * Facade class for FSM state callbacks
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_fsm_state_callback;
`else
class svt_fsm_state_callback extends `SVT_XVM(callback);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Constructor provided so clients can pass in a name for the instance.
   */
  function new(string name = "svt_fsm_state_callback");
    super.new(name);
  endfunction
`endif

  /**
   * This method gets called whenever the FSM leaves this state.
   */
  virtual function void leaving(svt_fsm_state_base state);
  endfunction

  /**
   * This method gets called whenever the FSM reaches this state.
   */
  virtual function void entering(svt_fsm_state_base state);
  endfunction

endclass

typedef svt_callbacks#(svt_fsm_state_base, svt_fsm_state_callback) svt_fsm_state_callbacks;

  
/** FSM state base class.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_fsm_state_base;
  vmm_log log;
  local int m_inst_id;
  static protected int m_inst_count;

  virtual function void print();
    $write("%s\n", get_name());
  endfunction

`else
class svt_fsm_state_base extends `SVT_XVM(object);
  `svt_xvm_object_utils(svt_fsm_state_base)
  
  `SVT_XVM(report_object) reporter;
`endif
  
  `svt_callback_utils(svt_fsm_state_callback)
   
  /** The current state transition options. */
  typedef enum  {
    EXTERNAL_INTERRUPT_NEXT, /**< State transitions enabled, possibly to be interrupted externally. */
    INTERNAL_INTERRUPT_NEXT, /**< State transitions enabled, possibly to be interrupted internally. */
    DISABLED_NEXT            /**< State transitions disabled */
  } state_transition_options_enum;

`ifdef SVT_UVM_TECHNOLOGY  
  `uvm_register_cb(svt_fsm_state_base, svt_fsm_state_callback) 
`endif

  /** Indicates the transition options currently available to this state. */
  state_transition_options_enum transition_option = DISABLED_NEXT;

  /** Set of possible next states. */
  local int m_next_states[svt_fsm_state_base];

  /** State that has been identified as the next state to be entered. */
  local svt_fsm_state_base m_next_state_choice = null;

  /** Time corresponding to the last time FSM entered this state */
  local real m_enter_time                              = 0;

  /** Time corresponding to the last time FSM left this state */
  local real m_leave_time                              = 0;

  /** Cached callback_client_exists return value used to accelerate callback processing. */
  int callback_client_exists_cache = -1;

  // ---------------------------------------------------------------------------
  /** Constructor for the FSM state base class.
   */
`ifdef SVT_VMM_TECHNOLOGY
  function new(string name = "");
    m_inst_id = m_inst_count++;
`else
  function new(string name = "");
    super.new(name);
`endif
  endfunction

  // ---------------------------------------------------------------------------
  /** Return the set of states that can transition
   *  into this state.
   *  It is usually simpler to use the `svt_fsm_from_state macro.
   */
  protected virtual function void m_incoming_states(ref svt_fsm_state_base state_q[$]);
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether this state can be reached directly from the provided
   * state.
   *
   * @param test_incoming The state to be checked as a possible incoming state.
   * @return Indicates that this state can (1) or cannot (0) be reached directly from
   * the provided state. 
   */
  virtual function bit is_dest_fsm_state(svt_fsm_state_base test_incoming);
    svt_fsm_state_base actual_incoming[$];
    int incoming_idx[$];

    m_incoming_states(actual_incoming);
    incoming_idx = actual_incoming.find_first_index(item) with (item == test_incoming);

    is_dest_fsm_state = incoming_idx.size() > 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Initialize the state instance.
   *  Must not be called directly.
   *  Automatically called by svt_fsm::m_init();
   */
  function int m_init();
    svt_fsm fsm = get_fsm();
    svt_fsm_state_base frm_st[$];
    m_incoming_states(frm_st);
    foreach (frm_st[i]) begin
      frm_st[i].m_add_next_state(this);
    end

    // Create processes that can drive the state transitions.
    fork
      begin
        if (static_fsm_thread_enabled()) begin
          bit is_ok;
          svt_fsm_state_base current_state;
          while (1) begin
            wait(transition_option == INTERNAL_INTERRUPT_NEXT);
            is_ok = 0;
            current_state = fsm.get_current_state();
            while ((transition_option == INTERNAL_INTERRUPT_NEXT) && !is_ok) this.state_transition(current_state, is_ok);
            if (transition_option == INTERNAL_INTERRUPT_NEXT) current_state.set_next_state_choice(this);
          end
        end
      end
    join_none

    return frm_st.size();
  endfunction
 
  // ---------------------------------------------------------------------------
  /** Set the parent FSM that holds this FSM state instance.
   *  Implemented in svt_fsm_state.
   */
  virtual function void set_fsm(svt_fsm fsm);
`ifdef SVT_VMM_TECHNOLOGY
    log = fsm.log;
`else
    reporter = fsm.reporter;
`endif
  endfunction

  // ---------------------------------------------------------------------------
  /** Return the parent FSM for this state
   */
  virtual function svt_fsm get_fsm();
    return null;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Return the name of this state
   *
   * @return Name which represents the state.
   */
  virtual function string get_name();
    return "";
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Return the class name.
   *
   * @return Name which represents the class.
   */
  virtual function string get_class_name();
    return "";
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Returns a name that can be used to represent the state's object type in the XML
   * output.
   *
   * @return Name to be used for the state in XML output.
   */
  virtual function string get_xml_name();
    return "";
  endfunction

  // ---------------------------------------------------------------------------
  /** Method to get the last 'enter' time for the state */
  virtual function real get_enter_time();
    get_enter_time = m_enter_time;
  endfunction

  // ---------------------------------------------------------------------------
  /** Method to set the last 'enter' time for the state */
  virtual function void set_enter_time(real enter_time);
    m_enter_time = enter_time;
  endfunction

  // ---------------------------------------------------------------------------
  /** Method to get the last 'leave' time for the state */
  virtual function real get_leave_time();
    get_leave_time = m_leave_time;
  endfunction

  // ---------------------------------------------------------------------------
  /** Method to set the last 'leave' time for the state */
  virtual function void set_leave_time(real leave_time);
    m_leave_time = leave_time;
  endfunction

  // ---------------------------------------------------------------------------
  /** Add the specified FSM state to the states this state can transition to.
   *  Do not call directly.
   *  Automatically called by svt_fsm::m_init().
   */
  function void m_add_next_state(svt_fsm_state_base state);
    if (m_next_states.exists(state)) return;
    m_next_states[state] = 1;
  endfunction

  // ---------------------------------------------------------------------------
  /** Detect a transition from the specified state to this state.
   *  Set 'ok' to TRUE and return if no errors were detected.
   *  Set 'ok' to FALSE and return if a protocol violation was detected.
   *  Must be implemented in every FSM state definition.
   *  Implementations must not call super.state_transition().
   */
  virtual task state_transition(svt_fsm_state_base from_state, output bit ok);
    `svt_fatal("SNPS/SVT/FSM/NOTR", {"state_transition() not implemented for state ", get_name()});
    wait(0);
  endtask

  // ---------------------------------------------------------------------------
  /**
   * Indicates whether the state_transition method for this class will exit cleanly
   * if transition_option goes to DISABLED_NEXT. Default implmentation always returns 0.
   */
  virtual function bit static_fsm_thread_enabled();
    static_fsm_thread_enabled = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Function performed while the FSM is in this state.
   *  Will no look for state transition until it returns.
   *  If the state behavior is to execute as long as no transitions
   *  are observed, simply fork/join_none the behavior.
   */
  virtual task body();
  endtask

  // ---------------------------------------------------------------------------
  /** Call the registered svt_fsm_state_callback::entering() method.
   *  Called by svt_fsm, before body() is called. Do not call directly.
   */
  function void m_entering();
    this.m_enter_time = $realtime;
    if (callback_client_exists())
      `svt_do_callbacks(svt_fsm_state_base, svt_fsm_state_callback, entering(this))
  endfunction

  // ---------------------------------------------------------------------------
  /** Call the registered svt_fsm_state_callback::leaving() method.
   *  Called by m_goto_next_state after next_state has been recognized. Do not call directly.
   */
  function void m_leaving();
    this.m_leave_time = $realtime;
    if (callback_client_exists())
      `svt_do_callbacks(svt_fsm_state_base, svt_fsm_state_callback, leaving(this))
  endfunction

  // ---------------------------------------------------------------------------
  /** Set all of the m_next_states transition_option field values. */
  function void set_next_states_transition_option(state_transition_options_enum transition_option);
    foreach (m_next_states[state]) state.transition_option = transition_option;
  endfunction

  // ---------------------------------------------------------------------------
  /** Method to set the m_next_state_choice field. */
  function void set_next_state_choice(svt_fsm_state_base next_state);
    // Disable the 'next state' processing.
    foreach (m_next_states[state]) state.transition_option = DISABLED_NEXT;

    // Check to see if there is a conflict with a previously recognized 'next' value
    if (m_next_state_choice != null) begin
      `svt_error("SNPS/SVT/FSM/BADTR",
                 {"Transition from ", get_name(), " to ", next_state.get_name(),
                  " conflicts with transition to ", m_next_state_choice.get_name()});
    end else
      m_next_state_choice = next_state;
  endfunction

  // ---------------------------------------------------------------------------
  /** Method to get the m_next_state_choice field. */
  task get_next_state_choice(ref svt_fsm_state_base next_state);
    // Calculate the appropriate mode
    state_transition_options_enum supported_transition_option =
      (static_fsm_thread_enabled()) ? INTERNAL_INTERRUPT_NEXT : EXTERNAL_INTERRUPT_NEXT;

    // Enable the 'next state' processing.
    foreach (m_next_states[state]) state.transition_option = supported_transition_option;

    // Wait for a new state to show up.
    wait(m_next_state_choice != null);
    next_state = m_next_state_choice;
    m_next_state_choice = null;
  endtask

  // ---------------------------------------------------------------------------
  /** Look for a state transition condition out of this state.
   *  Do not call directly.
   */
  task m_goto_next_state(output svt_fsm_state_base next_state,
                         input bit dead_end_is_ok);
    process next_processes[svt_fsm_state_base];

    svt_fsm_state_base state_i;
    int ok;

    next_state = null;

    if (m_next_states.num() == 0 && !dead_end_is_ok) begin
      `svt_error("SNPS/SVT/FSM/DEAD", {"Dead-end state ", get_name()});
      return;
    end

    // Special case to avoid forking a single sub-process
    if (m_next_states.num() == 1) begin

      bit is_ok;

      void'(m_next_states.first(next_state));
      while (!is_ok) next_state.state_transition(this, is_ok);

    end else if (static_fsm_thread_enabled()) begin

      get_next_state_choice(next_state);

    end else begin

      for (ok = m_next_states.first(state_i);
           ok;
           ok = m_next_states.next(state_i)) begin
        fork
          automatic svt_fsm_state_base state = state_i;
          begin
            bit is_ok;
            next_processes[state] = process::self();
            while (!is_ok) state.state_transition(this, is_ok);
            if (next_state != null) begin
              `svt_error("SNPS/SVT/FSM/BADTR",
                         {"Transition from ", get_name(), " to ", state.get_name(),
                          " conflicts with transition to ", next_state.get_name()});
            end
            else next_state = state;
          end
        join_none
      end

      wait(next_state != null);

    end

    this.m_leaving();
    if (!static_fsm_thread_enabled()) begin
      for (ok = next_processes.first(state_i);
           ok;
           ok = next_processes.next(state_i)
      ) begin
        if ((next_processes[state_i].status() != process::KILLED) && (next_processes[state_i].status() != process::FINISHED)) next_processes[state_i].kill();
      end
    end

  endtask

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Method returns unique numeric instance identifier for the state.
   */
  virtual function int get_inst_id();
    return m_inst_id;
  endfunction
`endif

  // ---------------------------------------------------------------------------
  /**
   * This method can be used to obtain a unique identifier for the state.
   *
   * @return Unique identifier for the object.
   */
  virtual function string get_uid();
    get_uid = $sformatf("%0s%0d", get_name(), get_inst_id());
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * This method writes a description of the state to the XML file managed by the 
   * XML writer argument.
   *
   * @param writer Object which takes care of the basic write operations.
   * @param prefix String to be placed at the beginning of each generated line.
   * @param suffix Additional string that is placed at the end of the generated
   * XML block
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  virtual function bit save_to_xml(svt_xml_writer writer, string prefix = "", string suffix);
    save_to_xml = 1;
    if (writer == null) begin
      `svt_error("SNPS/SVT/FSM/BADXW", $sformatf("Null 'writer' provided. Unable to save '%0s' in XML format.", get_name()));
      save_to_xml = 0;
    end else begin
      svt_fsm fsm = get_fsm();
      if (fsm == null) begin
        `svt_error("SNPS/SVT/FSM/BADXF", $sformatf("'fsm' not set. Unable to save '%0s' in XML format.", get_name()));
        save_to_xml = 0;
      end else begin
        // SRM 08/01/2013 - We encountered an issue with VCS 2013.06 whereby it wasn't making
        // the proper connections between this 'base' state class and the extended state
        // classes defined by the VIP. The simulator was able to find the correct 'get_xml_name' method,
        // but not the proper 'get_class_name' method required by 'get_xml_name'. For some reasons
        // this 'forced' call to 'get_class_name' (i.e., even though we never use the return
        // value) is sufficient to get past this issue. Adding it for now, until we can get
        // VCS to resolve this issue. Can hopefully be removed someday.
        // STAR #9000652786 has been submitted against VCS on this issue.
        string class_desc = this.get_class_name();
        string fsm_desc = fsm.get_xml_name();
        string time_unit = `SVT_DATA_TYPE::get_timeunit_str("svt_fsm", fsm.`SVT_DATA_LOG_KEYWORD);
        // Floating point equality comparator might cause issue in certain case if there is issue with start time for 
  	// XML/FSDB please check the comparator and check if it is cause for the case.
        realtime m_end_time = m_leave_time == 0 ? -1 : m_leave_time;
        save_to_xml = writer.write_pa_object_begin(get_xml_name(),get_uid(),"", fsm_desc, m_enter_time, m_leave_time,"", time_unit);
        if (save_to_xml) begin
          save_to_xml = writer.write_pa_object_close(get_uid());
        end
      end
    end
  endfunction

  //------------------------------------------------------------------------------
  function bit callback_client_exists();
    if (callback_client_exists_cache != -1) begin
      // Return the cached value.
      callback_client_exists = callback_client_exists_cache[0];
    end else begin
`ifdef SVT_VMM_TECHNOLOGY
      callback_client_exists = (callbacks.size() > 0);
`elsif SVT_OVM_TECHNOLOGY
      ovm_callbacks#(svt_fsm_state_base, svt_fsm_state_callback) cbs =
        ovm_callbacks#(svt_fsm_state_base, svt_fsm_state_callback)::`SVT_GET_GLOBAL_CBS();
`ifdef SVT_OVM_2_1_1_3
      ovm_queue#(ovm_callback) cbq = cbs.m_base_inst.m_pool.get(this);
`else
      ovm_queue#(svt_fsm_state_callback) cbq = cbs.get(this);
`endif
      callback_client_exists = (cbq.size() > 0);
`else
      int ix;
      svt_fsm_state_callback cb = uvm_callbacks#(svt_fsm_state_base, svt_fsm_state_callback)::get_first(ix, this);
      callback_client_exists = (cb != null);
`endif
      callback_client_exists_cache = callback_client_exists;
    end
  endfunction

endclass

/** Base class for user-defined FSM states.
 *  Must be extended to specify the behavior of a state within a FSM.
 *  The 'FSM' parameter is the type of the parent FSM containing this state.
 *  The 'NAME' parameter is the name of the state.
 */
class svt_fsm_state #(type FSM = int, string NAME = "state") extends svt_fsm_state_base;

  /** Reference to the parent FSM
   */
  FSM p_fsm;

  function svt_fsm get_fsm();
    return p_fsm;
  endfunction

  function void set_fsm(svt_fsm fsm);
    super.set_fsm(fsm);
    $cast(p_fsm, fsm);
  endfunction

  function string get_name();
    return {p_fsm.get_name(), "[", NAME, "]"};
  endfunction

  /**
   * Returns a name that can be used to represent the state's object type in the XML
   * output. By default uses the class name.
   *
   * @return Name to be used for the object type in XML output.
   */
  virtual function string get_xml_name();
    return this.get_class_name();
  endfunction

endclass

/**
 * Class describing an exception that has occured on a FSM
 */
class svt_fsm_exception;
endclass

/**
 * Facade class for FSM callbacks
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_fsm_callback;
`else
class svt_fsm_callback extends `SVT_XVM(callback);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Constructor provided so clients can pass in a name for the instance.
   */
  function new(string name = "svt_fsm_callback");
    super.new(name);
  endfunction
`endif

  /**
   * This method gets called whenever the FSM change state.
   * 'from_state' is NULL when transitioning to the start state when svt_fsm::run() is called.
   * If 'to_state' is modified, the FSM will transition to the newly specified state.
   */
  virtual function void goto(svt_fsm_state_base from_state,
                             ref svt_fsm_state_base to_state);
  endfunction

  /**
   * This method gets called whenever the FSM is reset.
   * The goto() method to the reset state will be called afterward.
   */
  virtual function void reset(svt_fsm fsm);
  endfunction

  /**
   * This method gets called whenever the FSM is aborted.
   * The svt_fsm::run() method will return afterward.
   */
  virtual function void abort(svt_fsm fsm);
  endfunction

  /**
   * This method is called whenever the svt_fsm::exception() is called.
   */
  virtual function void exception(svt_fsm fsm,
                                  svt_fsm_exception except);
  endfunction
endclass

typedef svt_callbacks#(svt_fsm, svt_fsm_callback) svt_fsm_callbacks;

  
/**
 *  Base class for describing protocol state machines
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_fsm;
  vmm_log log;
  local int m_inst_id;
  static protected int m_inst_count;
`else
class svt_fsm extends `SVT_XVM(report_object);
  `SVT_XVM(report_object) reporter;
`endif

  `svt_callback_utils(svt_fsm_callback)
   
`ifdef SVT_UVM_TECHNOLOGY  
  `uvm_register_cb(svt_fsm, svt_fsm_callback) 
`endif

  local svt_type_factory#(svt_fsm_state_base) m_state_factory;
  local svt_type_factory#(svt_fsm)            m_fsm_factory;

  local svt_fsm_state_base    m_states[$];
   
  local svt_fsm_state_base m_start_state;
  local svt_fsm_state_base m_reset_state;
  local svt_fsm_state_base m_done_state;

  local svt_fsm_state_base m_forced_state;

  local svt_fsm_state_base m_current_state;
  local event              m_state_change;

  local event initiate_transition;

  local process            m_kill_process_to_abort;
  local process            m_kill_process_to_reset;
  local process            m_kill_forced_transition_process_to_reset;

  local svt_xml_writer     m_xml_writer;

  /** Flag to avoid having to repeatedly parse the enable_messages plusarg. */
  local bit m_enable_messages = 0;

  /** Cached callback_client_exists return value used to accelerate callback processing. */
  int callback_client_exists_cache = -1;

`ifdef SVT_VMM_TECHNOLOGY
  function new(string name = "<unnamed FSM>");
    m_inst_id = m_inst_count++;
    log = new("svt_fsm", name);
`else
  function new(string name = "<unnamed FSM>", `SVT_XVM(report_object) reporter = null);
    super.new(name);
    if (reporter != null) begin
      this.reporter = reporter;
    end
    else begin
      this.reporter = this;
    end
`endif

    m_state_factory = new(get_name());
    m_fsm_factory   = new(get_name());

    m_current_state = null;

    m_enable_messages = $test$plusargs("svt_fsm_enable_messages");

  endfunction

  virtual function string get_name();
`ifdef SVT_VMM_TECHNOLOGY
    return log.get_name();
`else
    return super.get_name();
`endif
  endfunction

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Method returns unique numeric instance identifier for the FSM.
   */
  virtual function int get_inst_id();
    return m_inst_id;
  endfunction
`endif

  /**
   * This method can be used to obtain a unique identifier for a data object.
   *
   * @return Unique identifier for the object.
   */
  virtual function string get_uid();
    get_uid = $sformatf("%0s%0d", get_name(), get_inst_id());
  endfunction

  /**
   * This method provides a name which can be used to establish a channel associated with
   * this FSM in the XML output. If there are multiple FSMs this is needed to differentiate
   * this FSM from the other FSMs in the XML file. As such it needs to be unique across
   * the set of FSMs that will be included in the XML file.
   *
   * If there is just one state machine, then it is unnecessary to provide a channel for the
   * FSM in the XML. In this case get_xml_name can return an empty string. This will result
   * in the channel field not being included in the XML output.
   *
   * The default implementation uses get_name() to obtain a representative name that can be
   * used for the channel. This therefore supports there being multiple FSMs in the XML.
   *
   * @return Name to be used to define a channel for the FSM in the XML output.
   */
  virtual function string get_xml_name();
    get_xml_name = get_name();
  endfunction

  /**
   * The FSM states are created in extensions of this method,
   * using the `svt_fsm_create_state macro.
   */
  virtual function void build();
  endfunction

  /** Print a description of the FSM and its current state.*/
  virtual function void print();
    $write("FSM \"%s\":\n", get_name());
    foreach (m_states[i]) begin
      $write("   State \"%s\"", m_states[i].get_name());
      if (m_states[i] == m_start_state) $write(" (START)");
      if (m_states[i] == m_reset_state) $write(" (RESET)");
      if (m_states[i] == m_done_state)  $write(" (DONE)");
      $write("\n");
    end
    $write("   ");
    m_state_factory.print();
    $write("\n");

    $write("   ");
    m_fsm_factory.print();
    $write("\n");
  endfunction

  /** Override a state type with another state type for this FSM instance only.
   *  Must be called before build() is called.
   */
  function void override_state(svt_type_factory_override_base#(svt_fsm_state_base) orig,
                               svt_type_factory_override_base#(svt_fsm_state_base) over);
    m_state_factory.override(orig, over);
  endfunction

  /** Create a state of the specified type using the factory.
   *  Should not be called directly.
   *  Rather, the `svt_fsm_create_state macro should be used instead.
   */
  function svt_fsm_state_base m_create_state(svt_type_factory_override_base#(svt_fsm_state_base) typ);
    m_create_state = m_state_factory.create(typ);
    m_create_state.set_fsm(this);
    m_states.push_back(m_create_state);
  endfunction

  /** Override the type of a sub-FSM for this FSM instance only.
   *  Must be called before the state that creates the sub-FSM is started.
   */
  function void override_fsm(svt_type_factory_override_base#(svt_fsm) orig,
                             svt_type_factory_override_base#(svt_fsm) over);
    m_fsm_factory.override(orig, over);
  endfunction

  /** Create a sub-FSM instance of the specified type using the local factory.
   *  Should not be called directly.
   *  Rather, the `svt_fsm_create_fsm macro should be used instead.
   */
  function svt_fsm create_fsm(svt_type_factory_override_base#(svt_fsm) typ,
                              string name);
    create_fsm = m_fsm_factory.create(typ);
    create_fsm.set_name(name);
`ifndef SVT_VMM_TECHNOLOGY
    create_fsm.reporter = this.reporter;
`endif
  endfunction

  /** Initialize the FSM and it's states.
   *  Called automatically when run() is called.
   */
  function void m_init();
    foreach (m_states[i]) begin
      if (m_states[i].m_init() == 0 &&
          m_states[i] != m_start_state &&
          m_states[i] != m_reset_state) begin
        `svt_warning("SNPS/SVT/FSM/NFW", {"State ", m_states[i].get_name(), " is unreachable"});
      end
    end
  endfunction

  /** Set the name of the FSM instance
   */
  function void set_name(string name);
    m_state_factory.set_name(name);
    m_fsm_factory.set_name(name);
`ifdef SVT_VMM_TECHNOLOGY
    log.set_name(name);
`else
    super.set_name(name);
`endif
  endfunction

  /** Define the start state of the FSM (required).
   *  Should be called in an extension of build() or run().
   *  The start state is one of the state that can be a dead-end state.
   */
  protected function void set_start_state(svt_fsm_state_base state);
    if (state.get_fsm() != this) begin
      `svt_error("SNPS/SVT/FSM/BADST", {"Start state ", state.get_name(),
                                        " is not a state of FSM ", get_name()});
      return;
    end
    m_start_state = state;
  endfunction
 
  /** Define the reset state of the FSM (required if the start state is a dead-end state).
   *  Requires that wait_for_reset() be implemented.
   *  Should be called in an extension of build() or run().
   */
  protected function void set_reset_state(svt_fsm_state_base state);
    if (state.get_fsm() != this) begin
      `svt_error("SNPS/SVT/FSM/BADRST", {"Reset state ", state.get_name(),
                                         " is not a state of FSM ", get_name()});
      return;
    end
    m_reset_state = state;
  endfunction
 
  /** Define the final state of the FSM (optional).
   *  Should be called in an extension of build() or run().
   *  The final state should be a dead-end state.
   */
  protected function void set_done_state(svt_fsm_state_base state);
    if (state.get_fsm() != this) begin
      `svt_error("SNPS/SVT/FSM/BADDN", {"Done state ", state.get_name(),
                                        " is not a state of FSM ", get_name()});
      return;
    end
    m_done_state = state;
  endfunction

  /** Set the XML Writer, used to generate XML output at state transitions. */
  virtual function void set_xml_writer(svt_xml_writer xml_writer);
    m_xml_writer = xml_writer;
  endfunction

  /** Terminate the FSM.
   *  This will cause the run() method to return.
   */
  function void abort();
    if (m_kill_process_to_abort != null) m_kill_process_to_abort.kill();
    m_current_state = null;
  endfunction

  /** Must be implemented if a reset state is defined.
   *  Automatically invoked by the run() task,
   *  it must return only once the reset condition has been detected.
   *  The implementation must not call super.wait_for_reset().
   */
  protected virtual task wait_for_reset();
    `svt_fatal("SNPS/SVT/FSM/NOWFR", {"wait_for_reset() not defined for ", get_name()});
    wait(0);
  endtask

  /** Should be called whenever an error is detected by the FSM implementation
   *  Calls all registered instances of the svt_fsm_callback::exception() method.
   */
  function void exception(svt_fsm_exception except);
    if (callback_client_exists())
      `svt_do_callbacks(svt_fsm, svt_fsm_callback, exception(this, except))
  endfunction

  /** Start and run the FSM until it is aborted.
   */
  task run();
    if (m_forced_state == null) begin
      m_current_state = m_start_state;
      if (m_current_state == null) begin
        `svt_error("SNPS/SVT/FSM/NOST", "FSM does not have a start state");
        return;
      end
    end
    else begin
      m_current_state = m_forced_state;
      m_forced_state = null;
    end

    m_init();

    fork
      begin
        m_kill_process_to_abort = process::self();

        if (m_enable_messages)
          `svt_note("SNPS/SVT/FSM/START", {"Starting FSM in state ", m_current_state.get_name()});

        if (m_reset_state != null) begin
          fork
            begin
              svt_fsm_state_base next_state;
              forever begin
                // Make sure there is an active state
                wait(m_kill_process_to_reset != null);
                // Now watch for reset
                wait_for_reset();
                if (m_enable_messages)
                  `svt_note("SNPS/SVT/FSM/RST", {"Resetting FSM from state ", m_current_state.get_name()});

                m_current_state.set_next_states_transition_option(svt_fsm_state_base::DISABLED_NEXT);
                next_state = m_reset_state;
                if (callback_client_exists()) begin
                  `svt_do_callbacks(svt_fsm, svt_fsm_callback, reset(this))
                  `svt_do_callbacks(svt_fsm, svt_fsm_callback, goto(m_current_state, next_state))
                end
                m_current_state = next_state;
                m_kill_process_to_reset.kill();
                m_kill_forced_transition_process_to_reset.kill();
                @(m_state_change);
              end
            end
          join_none
        end

        forever begin
          svt_fsm_state_base next_state;
          fork
            begin: forced_transition
              m_kill_forced_transition_process_to_reset = process::self();
              while (m_current_state != m_done_state) begin
                wait(m_forced_state != null || next_state != null);
                if (m_forced_state != null) next_state = m_forced_state;
                @(initiate_transition);
              end
            end
            begin
              m_kill_process_to_reset = process::self();
         
              while (m_current_state != m_done_state) begin
                if (m_current_state.static_fsm_thread_enabled()) begin
                  m_current_state.m_entering();
                  m_current_state.body();
                  m_current_state.m_goto_next_state(next_state,
                                                    m_reset_state != null &&
                                                    m_reset_state != m_current_state);
                end else begin
                  fork begin
                  fork
                    begin: standard_transition
                      m_current_state.m_entering();
                      m_current_state.body();
                      m_current_state.m_goto_next_state(next_state,
                                                        m_reset_state != null &&
                                                        m_reset_state != m_current_state);
                    end
                  join_any
                  disable fork;
                  end join
                end

                goto_cb_exec(m_current_state, next_state);

                m_current_state = next_state;
                -> m_state_change;
                if (m_current_state == null) begin
                  `svt_fatal("SNPS/SVT/FSM/BYE", "FSM transitioned into limbo!");
                  break;
                end
                if (m_current_state.get_fsm() != this) begin
                  `svt_fatal("SNPS/SVT/FSM/ALIEN", {"FSM transitioned to foreign state ",
                                                    m_current_state.get_name()});
                  break;
                end
                if (m_enable_messages)
                  `svt_note("SNPS/SVT/FSM/GOTO", {"FSM transitioned to state ", m_current_state.get_name()});
                m_forced_state = null;
                next_state = null;
                ->initiate_transition;
              end

              if (m_enable_messages)
                `svt_note("SNPS/SVT/FSM/DONE", {"FSM reached 'done' state ", m_current_state.get_name()});
              wait(0);
            end
          join
        end
      end
    join

    if (m_enable_messages)
      `svt_note("SNPS/SVT/FSM/ABRT", "FSM was aborted");
    if (callback_client_exists())
      `svt_do_callbacks(svt_fsm, svt_fsm_callback, abort(this))

    m_current_state = null;
    -> m_state_change;
  endtask

  /** Wait for the FSM to transition state
   *  and return the state it just transitioned to.
   *  Returns NULL if the FSM was aborted.
   */
  task wait_for_state_transition(output svt_fsm_state_base to_state);
    @(m_state_change);
    to_state = m_current_state;
  endtask

  /**
   * Function encapsulating actions that occur at the transition from current to next
   * state, including calling the 'goto' callback.
   */
  function void goto_cb_exec(svt_fsm_state_base from_state, svt_fsm_state_base to_state);
    if ((from_state != null) && (this.m_xml_writer != null)) begin
      void'(from_state.save_to_xml(this.m_xml_writer, "", ""));
    end
    if (callback_client_exists())
      `svt_do_callbacks(svt_fsm, svt_fsm_callback, goto(from_state, to_state))
  endfunction

  /**
   * Function that can force the current state to get an end time and be forced out to XML.
   */
  function void save_current_state_to_xml();
    if ((m_current_state != null) && (this.m_xml_writer != null)) begin
      m_current_state.set_leave_time($realtime);
      void'(m_current_state.save_to_xml(this.m_xml_writer, "", ""));
    end
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Method which checks whether the provided fsm state can be reached directly from the
   * current fsm state.
   *
   * @param test_next The state to be checked as a possible next state.
   * @return Indicates that this state is (1) or is not (0) a viable next state.
   */
  protected virtual function bit is_viable_next_fsm_state(svt_fsm_state_base test_next);
    is_viable_next_fsm_state = test_next.is_dest_fsm_state(m_current_state);
  endfunction

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** Returns a handle to the current state */
  function svt_fsm_state_base get_current_state();
    return m_current_state;
  endfunction: get_current_state

  // ---------------------------------------------------------------------------
  /** Sets the current state (killing any active threads in the process)
   *
   * @param next_state_str String ID of the state to jump to
   */
  function void set_current_state(string next_state_str);
    svt_fsm_state_base next_state;
    foreach (m_states[i]) begin
      string name_context = {get_name(), "[", next_state_str, "]"};
      if (m_states[i].get_name() == name_context) begin
        next_state = m_states[i];
        break;
      end
    end

    if (next_state != null) begin
      if (m_enable_messages)
        `svt_note("SNPS/SVT/FSM/SETST", {"FSM state forced from ", m_current_state.get_name(), " to state ", next_state.get_name()});
      m_forced_state = next_state;
    end
    else begin
      `svt_error("SNPS/SVT/FSM/BADSETST",
                 {"FSM state ", next_state_str, " is not valid for this FSM"});
    end
  endfunction: set_current_state
/** @endcond */

  //------------------------------------------------------------------------------
  function bit callback_client_exists();
    if (callback_client_exists_cache != -1) begin
      // Return the cached value.
      callback_client_exists = callback_client_exists_cache[0];
    end else begin
`ifdef SVT_VMM_TECHNOLOGY
      callback_client_exists = (callbacks.size() > 0);
`elsif SVT_OVM_TECHNOLOGY
      ovm_callbacks#(svt_fsm, svt_fsm_callback) cbs =
        ovm_callbacks#(svt_fsm, svt_fsm_callback)::`SVT_GET_GLOBAL_CBS();
`ifdef SVT_OVM_2_1_1_3
      ovm_queue#(ovm_callback) cbq = cbs.m_base_inst.m_pool.get(this);
`else
      ovm_queue#(svt_fsm_callback) cbq = cbs.get(this);
`endif
      callback_client_exists = (cbq.size() > 0);
`else
      int ix;
      svt_fsm_callback cb = uvm_callbacks#(svt_fsm, svt_fsm_callback)::get_first(ix, this);
      callback_client_exists = (cb != null);
`endif
      callback_client_exists_cache = callback_client_exists;
    end
  endfunction

endclass

`endif // GUARD_SVT_FSM_SV

