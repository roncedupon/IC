//----------------------------------------------------------------------
//   Copyright 2010-2011 Mentor Graphics Corporation
//   Copyright 2011 Synopsys, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------


// Enum: svt_sequence_lib_mode
//
// Specifies the random selection mode of a sequence library
//
// SVT_SEQ_LIB_RAND  - Random sequence selection
// SVT_SEQ_LIB_RANDC - Random cyclic sequence selection
// SVT_SEQ_LIB_ITEM  - Emit only items, no sequence execution
// SVT_SEQ_LIB_USER  - Apply a user-defined random-selection algorithm

typedef enum
{
  SVT_SEQ_LIB_RAND,
  SVT_SEQ_LIB_RANDC,
  SVT_SEQ_LIB_ITEM,
  SVT_SEQ_LIB_USER
} svt_sequence_lib_mode;




//
// CLASS- svt_ovm_sequence_library
//
// The ~svt_ovm_sequence_library~ duplicates the behavior of the ~uvm_sequence_library~.
// is a sequence that contains a list of registered sequence types.
// It can be configured to create and execute these sequences
// any number of times using one of several modes of operation, including a
// user-defined mode.
//
// When started (as any other sequence), the sequence library will randomly
// select and execute a sequence from its ~sequences~ queue. If in
// <SVT_SEQ_LIB_RAND> mode, its <select_rand> property is randomized and used
// as an index into ~sequences~.  When in <SVT_SEQ_LIB_RANC> mode, the
// <select_randc> property is used. When in <SVT_SEQ_LIB_ITEM> mode, only
// sequence items of the ~REQ~ type are generated and executed--no sequences
// are executed. Finally, when in <SVT_SEQ_LIB_USER> mode, the
// <select_sequence> method is called to obtain the index for selecting the
// next sequence to start. Users can override this method in subtypes to
// implement custom selection algorithms.
//
//------------------------------------------------------------------------------

class svt_ovm_sequence_library #(type REQ=ovm_sequence_item,RSP=REQ) extends ovm_sequence #(REQ,RSP);

   // Function- new
   //
   // Create a new instance of this class
   //
   extern function new(string name="");


   // Function- get_type_name
   //
   // Get the type name of this class
   //
   extern virtual function string get_type_name();

  /**
   * Raise the objection for the current run-time phase
   */
  extern function void raise_phase_objection();

  /**
   * Drop the previously-raised objection for the run-time phase
   */
  extern function void drop_phase_objection();

   //--------------------------
   // Group- Sequence selection
   //--------------------------

   // Variable- selection_mode
   //
   // Specifies the mode used to select sequences for execution
   //
   svt_sequence_lib_mode selection_mode;


   // Variable- min_random_count
   //
   // Sets the minimum number of items to execute. Use the configuration
   // mechanism to set. See <selection_mode> for an example.
   //
   int unsigned min_random_count=10;


   // Variable- max_random_count
   //
   // Sets the maximum number of items to execute. Use the configuration
   // mechanism to set. See <selection_mode> for an example.
   //
   //
   int unsigned max_random_count=10;



   // Variable- sequences_executed
   //
   // Indicates the number of sequences executed, not including the
   // currently executing sequence, if any.
   //
   protected int unsigned sequences_executed;


   // Variable- sequence_count
   //
   // Specifies the number of sequences to execute when this sequence
   // library is started. If in <SVT_SEQ_LIB_ITEM> mode, specifies the
   // number of sequence items that will be generated.
   //
   rand  int unsigned sequence_count = 10;


   // Variable- select_rand
   //
   // The index variable that is randomized to select the next sequence
   // to execute when in SVT_SEQ_LIB_RAND mode
   //
   // Extensions may place additional constraints on this variable.
   //
   rand  int unsigned select_rand;


   // Variable- select_randc
   //
   // The index variable that is randomized to select the next sequence
   // to execute when in SVT_SEQ_LIB_RANDC mode
   //
   // Extensions may place additional constraints on this variable.
   //
   randc bit [15:0] select_randc;



   // Variable- seqs_distrib
   //
   //
   //
   protected int seqs_distrib[string]
   `ifndef INCA
   = '{default:0}
   `endif
   ;


   // Variable- sequences
   //
   // The container of all registered sequence types. For <sequence_count>
   // times, this sequence library will randomly select and execute a
   // sequence from this list of sequence types.
   //
   protected ovm_object_wrapper sequences[$];



   // Constraint- valid_rand_selection
   //
   // Constrains <select_rand> to be a valid index into the ~sequences~ array
   //
   constraint valid_rand_selection {
         select_rand inside {[0:sequences.size()-1]};
   }



   // Constraint- valid_randc_selection
   //
   // Constrains <select_randc> to be a valid index into the ~sequences~ array
   //
   constraint valid_randc_selection {
         select_randc inside {[0:sequences.size()-1]};
   }


   // Constraint- valid_sequence_count
   //
   // Constrains <sequence_count> to lie within the range defined by
   // <min_random_count> and <max_random_count>.
   //
   constraint valid_sequence_count {
      sequence_count inside {[min_random_count:max_random_count]};
   }



   // Function- select_sequence
   //
   // Generates an index used to select the next sequence to execute. 
   // Overrides must return a value between 0 and ~max~, inclusive.
   // Used only for <SVT_SEQ_LIB_USER> selection mode. The
   // default implementation returns 0, incrementing on successive calls,
   // wrapping back to 0 when reaching ~max~.
   //
   extern virtual function int unsigned select_sequence(int unsigned max);



   //-----------------------------
   // Group- Sequence registration
   //-----------------------------

   // Function- add_typewide_sequence
   //
   // Registers the provided sequence type with this sequence library
   // type. The sequence type will be available for selection by all instances
   // of this class. Sequence types already registered are silently ignored.
   //
   extern static function void add_typewide_sequence(ovm_object_wrapper seq_type);



   // Function- add_typewide_sequences
   //
   // Registers the provided sequence types with this sequence library
   // type. The sequence types will be available for selection by all instances
   // of this class. Sequence types already registered are silently ignored.
   //
   extern static function void add_typewide_sequences(ovm_object_wrapper seq_types[$]);


   // Function- add_sequence
   //
   // Registers the provided sequence type with this sequence library
   // instance. Sequence types already registered are silently ignored.
   //
   extern function void add_sequence(ovm_object_wrapper seq_type);


   // Function- add_sequences
   //
   // Registers the provided sequence types with this sequence library
   // instance. Sequence types already registered are silently ignored.
   //
   extern virtual function void add_sequences(ovm_object_wrapper seq_types[$]);


   // Function- remove_sequence
   //
   // Removes the given sequence type from this sequence library
   // instance. If the type was registered statically, the sequence queues of
   // all instances of this library will be updated accordingly.
   // A warning is issued if te sequence is not registered.
   //
   extern virtual function void remove_sequence(ovm_object_wrapper seq_type);


   // Function- get_sequences
   //
   // 
   // Append to the provided ~seq_types~ array the list of registered <sequences>.
   //
   extern virtual function void get_sequences(ref ovm_object_wrapper seq_types[$]);


   // Function- init_sequence_library
   //
   // All subtypes of this class must call init_sequence_library in its
   // constructor.
   extern function void init_sequence_library();

   `ovm_object_param_utils(svt_ovm_sequence_library #(REQ,RSP))
   typedef svt_ovm_sequence_library #(REQ,RSP) this_type;

   static const string type_name = "svt_ovm_sequence_library #(REQ,RSP)";
   static protected ovm_object_wrapper m_typewide_sequences[$];
   bit m_abort;

   local int unsigned m_counter;

   extern static   function bit  m_static_check(ovm_object_wrapper seq_type);
   extern static   function bit  m_check(ovm_object_wrapper seq_type, this_type lib);
   extern          function bit  m_dyn_check(ovm_object_wrapper seq_type);
   extern          function void m_get_config();
   extern static   function bit  m_add_typewide_sequence(ovm_object_wrapper seq_type);
   extern virtual  task          execute(ovm_object_wrapper wrap);

   extern virtual  task          body();
   extern virtual  function void do_print(ovm_printer printer);
   extern          function void pre_randomize();

   local ovm_objection m_raised;

endclass



//------------------------------------------------------------------------------
//
// CLASS- svt_ovm_sequence_library_cfg
//
// A convenient container class for configuring all the sequence library
// parameters using a single ~set~ command.
//
//| svt_ovm_sequence_library_cfg cfg;
//| cfg = new("seqlib_cfg", UVM_SEQ_LIB_RANDC, 1000, 2000);
//|
//| set_config_object("env.agent.sequencer", "seq_lib.config", cfg);
//|
//------------------------------------------------------------------------------

class svt_ovm_sequence_library_cfg extends ovm_object;
  `ovm_object_utils(svt_ovm_sequence_library_cfg)
  svt_sequence_lib_mode selection_mode;
  int unsigned min_random_count;
  int unsigned max_random_count;
  function new(string name="",
               svt_sequence_lib_mode mode=SVT_SEQ_LIB_RAND,
               int unsigned min=1,
               int unsigned max=10);
    super.new(name);
    selection_mode = mode;
    min_random_count = min;
    max_random_count = max;
  endfunction
endclass



//------------------------------------------------------------------------------
// IMPLEMENTATION
//------------------------------------------------------------------------------

// new
// ---

function svt_ovm_sequence_library::new(string name="");
   super.new(name);
   init_sequence_library();
   valid_rand_selection.constraint_mode(0);
   valid_randc_selection.constraint_mode(0);
endfunction


// get_type_name
// -------------

function string svt_ovm_sequence_library::get_type_name();
  return type_name;
endfunction



// raise_phase_objection
// -----------------------

function void svt_ovm_sequence_library::raise_phase_objection();
  svt_sequencer#(REQ, RSP) sqr;
  if ($cast(sqr, m_sequencer) && sqr != null) begin
    if (m_raised != null) begin
       `ovm_error("SEQ/PH/OBJ/RAISE/BAD",
                  $sformatf("Sequence %s is attempting to raise %s but has not dropped objection to previously-raised %s",
                            get_full_name(), sqr.current_phase_objection.get_name(),
                            m_raised.get_name()))
    end
    sqr.current_phase_objection.raise_objection(this);
    m_raised = sqr.current_phase_objection;
  end
endfunction

// drop_phase_objection
// -----------------------

function void svt_ovm_sequence_library::drop_phase_objection();
  svt_sequencer#(REQ, RSP) sqr;
  if (m_raised == null) return;
  if ($cast(sqr, m_sequencer) && sqr != null) begin
    m_raised.drop_objection(this);
  end
endfunction

// m_add_typewide_sequence
// -----------------------

function bit svt_ovm_sequence_library::m_add_typewide_sequence(ovm_object_wrapper seq_type);
  this_type::add_typewide_sequence(seq_type);
  return 1;
endfunction


// add_typewide_sequence
// ---------------------

function void svt_ovm_sequence_library::add_typewide_sequence(ovm_object_wrapper seq_type);
  if (m_static_check(seq_type))
    m_typewide_sequences.push_back(seq_type);
endfunction


// add_typewide_sequences
// ----------------------

function void svt_ovm_sequence_library::add_typewide_sequences(ovm_object_wrapper seq_types[$]);
  foreach (seq_types[i])
    add_typewide_sequence(seq_types[i]);
endfunction


// add_sequence
// ------------

function void svt_ovm_sequence_library::add_sequence(ovm_object_wrapper seq_type);
  if (m_dyn_check(seq_type))
    sequences.push_back(seq_type);
endfunction


// add_sequences
// -------------

function void svt_ovm_sequence_library::add_sequences(ovm_object_wrapper seq_types[$]);
  foreach (seq_types[i])
    add_sequence(seq_types[i]);
endfunction


// remove_sequence
// ---------------

function void svt_ovm_sequence_library::remove_sequence(ovm_object_wrapper seq_type);
  foreach (sequences[i])
    if (sequences[i] == seq_type) begin
      sequences.delete(i);
      return;
    end
endfunction


// get_sequences
// -------------

function void svt_ovm_sequence_library::get_sequences(ref ovm_object_wrapper seq_types[$]);
  foreach (sequences[i])
    seq_types.push_back(sequences[i]);
endfunction


// select_sequence
// ---------------

function int unsigned svt_ovm_sequence_library::select_sequence(int unsigned max);
  select_sequence = m_counter;
  m_counter++;
  if (m_counter >= max)
    m_counter = 0;
endfunction


//----------//
// INTERNAL //
//----------//


// init_sequence_library
// ---------------------

function void svt_ovm_sequence_library::init_sequence_library();
  foreach (this_type::m_typewide_sequences[i])
    sequences.push_back(this_type::m_typewide_sequences[i]);
endfunction



// m_static_check
// --------------


function bit svt_ovm_sequence_library::m_static_check(ovm_object_wrapper seq_type);
  if (!m_check(seq_type,null))
    return 0;
  foreach (m_typewide_sequences[i])
    if (m_typewide_sequences[i] == seq_type)
      return 0;
  return 1;
endfunction


// m_dyn_check
// -----------

function bit svt_ovm_sequence_library::m_dyn_check(ovm_object_wrapper seq_type);
  if (!m_check(seq_type,this))
    return 0;
  foreach (sequences[i])
    if (sequences[i] == seq_type)
      return 0;
  return 1;
endfunction


// m_check
// -------

function bit svt_ovm_sequence_library::m_check(ovm_object_wrapper seq_type, this_type lib);
  ovm_object obj;
  ovm_sequence_base seq;
  ovm_root top;
  string name;
  string typ;
  obj = seq_type.create_object();
  name = (lib == null) ? type_name : lib.get_full_name();
  typ = (lib == null) ? type_name : lib.get_type_name();
  top = ovm_root::get();

  if (!$cast(seq, obj)) begin
    `ovm_error("SEQLIB/BAD_SEQ_TYPE",
        {"Object '",obj.get_type_name(),
        "' is not a sequence. Cannot add to sequence library '",name,
        "'"})
     return 0;
  end
  begin
    ovm_sequence#(REQ,RSP) seq;
    if (!( $cast(seq, obj))) begin
      `ovm_error("SEQLIB/BAD_REQ_TYPE",
        {"Can not add sequence '",seq.get_type_name(),"' ",
        "to sequence library of type '",typ,"' (instance ",name,") ",
        "as the request/response types are not type-compatible with ",
        "the request/response types of the sequence library."})
       return 0;
    end 
  end
  return 1;
endfunction


// pre_randomize
// -------------

function void svt_ovm_sequence_library::pre_randomize();
  m_get_config();
endfunction


// m_get_config
// ------------

function void svt_ovm_sequence_library::m_get_config();

  if (m_sequencer != null) begin
     svt_ovm_sequence_library_cfg cfg;
     ovm_object obj;
     
     if (m_sequencer.get_config_object("seq_lib.config", obj) &&
         obj != null && $cast(cfg, obj)) begin
        selection_mode = cfg.selection_mode; 
        min_random_count = cfg.min_random_count; 
        max_random_count = cfg.max_random_count; 
     end
     else begin
        int mode;
        void'(m_sequencer.get_config_int("seq_lib.min_random_count", min_random_count));
        void'(m_sequencer.get_config_int("seq_lib.max_random_count", max_random_count));
        if (m_sequencer.get_config_int("seq_lib.selection_mode", mode))
           selection_mode = svt_sequence_lib_mode'(mode);
     end
  end
                       
  if (max_random_count == 0) begin
    `ovm_warning("SEQLIB/MAX_ZERO",
       $sformatf("max_random_count (%0d) zero. Nothing will be done.",
       max_random_count))
    if (min_random_count > max_random_count)
      min_random_count = max_random_count;
  end
  else if (min_random_count > max_random_count) begin
    `ovm_error("SEQLIB/MIN_GT_MAX",
       $sformatf("min_random_count (%0d) greater than max_random_count (%0d). Setting min to max.",
       min_random_count,max_random_count))
    min_random_count = max_random_count;
  end
  else begin
    if (selection_mode == SVT_SEQ_LIB_ITEM) begin
      ovm_sequencer #(REQ,RSP) seqr;
      REQ req = new();
      if (req.get_type_name() == "ovm_sequence_item") begin
        `ovm_error("SEQLIB/BASE_ITEM", {"selection_mode cannot be SVT_SEQ_LIB_ITEM when ",
          "the REQ type is the base ovm_sequence_item. Using SVT_SEQ_LIB_RAND mode"})
        selection_mode = SVT_SEQ_LIB_RAND;
      end
      if (m_sequencer == null || !$cast(seqr,m_sequencer)) begin
        `ovm_error("SEQLIB/VIRT_SEQ", {"selection_mode cannot be SVT_SEQ_LIB_ITEM when ",
          "running as a virtual sequence. Using SVT_SEQ_LIB_RAND mode"})
        selection_mode = SVT_SEQ_LIB_RAND;
      end
    end
  end

endfunction


// body
// ----

task svt_ovm_sequence_library::body();

  ovm_object_wrapper wrap;

  if (m_sequencer == null) begin
    `ovm_fatal("SEQLIB/VIRT_SEQ", {"Sequence library 'm_sequencer' handle is null; ",
      " no current support for running as a virtual sequence."})
     return;
  end

  if (sequences.size() == 0) begin
    `ovm_error("SEQLIB/NOSEQS", "Sequence library does not contain any sequences.")
    return;
  end

  m_get_config();

  raise_phase_objection();

  `ovm_info("SEQLIB/START",
     $sformatf("Starting sequence library: %0d iterations in mode %s",
      sequence_count, selection_mode.name()),OVM_LOW)

   `ovm_info("SEQLIB/SPRINT",{"\n",sprint(ovm_default_table_printer)},OVM_FULL)

    case (selection_mode)

      SVT_SEQ_LIB_RAND: begin
        valid_rand_selection.constraint_mode(1);
        valid_sequence_count.constraint_mode(0);
        for (int i=1; i<=sequence_count; i++) begin
          if (!randomize(select_rand)) begin
            `ovm_error("SEQLIB/RAND_FAIL", "Random sequence selection failed")
            break;
          end
          else begin
            wrap = sequences[select_rand];
          end
          execute(wrap);
        end
        valid_rand_selection.constraint_mode(0);
        valid_sequence_count.constraint_mode(1);
      end

      SVT_SEQ_LIB_RANDC: begin
        ovm_object_wrapper q[$];
        valid_randc_selection.constraint_mode(1);
        valid_sequence_count.constraint_mode(0);
        for (int i=1; i<=sequence_count; i++) begin
          if (!randomize(select_randc)) begin
            `ovm_error("SEQLIB/RANDC_FAIL", "Random sequence selection failed")
            break;
          end
          else begin
            wrap = sequences[select_randc];
          end
          q.push_back(wrap);
        end
        valid_randc_selection.constraint_mode(0);
        valid_sequence_count.constraint_mode(1);
        foreach(q[i])
          execute(q[i]);
        valid_randc_selection.constraint_mode(0);
        valid_sequence_count.constraint_mode(1);
      end

      SVT_SEQ_LIB_ITEM: begin
        for (int i=1; i<=sequence_count; i++) begin
          wrap = REQ::get_type();
          execute(wrap);
        end
      end

      SVT_SEQ_LIB_USER: begin
        for (int i=1; i<=sequence_count; i++) begin
          int user_selection;
          user_selection = select_sequence(sequences.size()-1);
          if (user_selection >= sequences.size()) begin
            `ovm_error("SEQLIB/USER_FAIL", "User sequence selection out of range")
            wrap = REQ::get_type();
          end
          else begin
            wrap = sequences[user_selection];
          end
          execute(wrap);
        end
      end

      default: begin
        `ovm_fatal("SEQLIB/RAND_MODE", 
           $sformatf("Unknown random sequence selection mode: %0d",selection_mode))
      end
     endcase

  `ovm_info("SEQLIB/END", "Ending sequence library", OVM_LOW)

  foreach(seqs_distrib[idx])
    `ovm_info("SEQLIB/DSTRB",$sformatf("%s -> %d",idx,seqs_distrib[idx]),OVM_HIGH)  

  drop_phase_objection();
endtask


// execute
// -------

task svt_ovm_sequence_library::execute(ovm_object_wrapper wrap);

  ovm_object obj;
  ovm_factory factory;
  ovm_sequence_item seq_or_item;

  factory = ovm_factory::get();

  obj = factory.create_object_by_type(wrap,get_full_name(),
           $sformatf("%s:%0d",wrap.get_type_name(),sequences_executed+1));
  void'($cast(seq_or_item,obj)); // already qualified, 

  `ovm_info("SEQLIB/EXEC",{"Executing ",(seq_or_item.is_item() ? "item " : "sequence "),seq_or_item.get_name(),
                           " (",seq_or_item.get_type_name(),")"},OVM_FULL)
  seq_or_item.print_sequence_info = 1;
  `ovm_rand_send(seq_or_item)
  seqs_distrib[seq_or_item.get_type_name()] = seqs_distrib[seq_or_item.get_type_name()]+1;

  sequences_executed++;

endtask
  


// do_print
// --------

function void svt_ovm_sequence_library::do_print(ovm_printer printer);
   printer.print_field("min_random_count",min_random_count,32,OVM_DEC,,"int unsigned");
   printer.print_field("max_random_count",max_random_count,32,OVM_DEC,,"int unsigned");
   printer.print_generic("selection_mode","ovm_sequence_lib_mode",32,selection_mode.name());
   printer.print_field("sequence_count",sequence_count,32,OVM_DEC,,"int unsigned");

   printer.print_array_header("typewide_sequences",m_typewide_sequences.size(),"queue_object_types");
   foreach (m_typewide_sequences[i])
     printer.print_generic($sformatf("[%0d]",i),"ovm_object_wrapper","-",m_typewide_sequences[i].get_type_name());
   printer.print_array_footer();

   printer.print_array_header("sequences",sequences.size(),"queue_object_types");
   foreach (sequences[i])
     printer.print_generic($sformatf("[%0d]",i),"ovm_object_wrapper","-",sequences[i].get_type_name());
   printer.print_array_footer();

   printer.print_array_header("seqs_distrib",seqs_distrib.num(),"as_int_string");
   foreach (seqs_distrib[typ]) begin
     printer.print_field({"[",typ,"]"},seqs_distrib[typ],32,,OVM_DEC,"int unsigned");
   end
   printer.print_array_footer();
endfunction


