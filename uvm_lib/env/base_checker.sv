//------------------------------------------------------------------------------
// UVM Checker: Standard Consumer Model
// Function: Auto receive transaction from Monitor via analysis port
//           Push all received transactions to internal array/queue automatically
// Monitor(Producer) -> ap.write(tr) -> Checker(Consumer) -> write() callback -> push to array
//------------------------------------------------------------------------------
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//------------------------------------------------------------------------------
class base_trans extends uvm_sequence_item;
  `uvm_object_utils(base_trans)
  
  bit[31:0] addr;
  bit[63:0] data;
  bit[2:0]  ost_id;
  bit       valid;

  function new(string name = "base_trans");
    super.new(name);
  endfunction

endclass
class base_checker extends uvm_component;
  `uvm_component_utils(base_checker)

  // Step 1: Declare UVM analysis export (core for consumer, match monitor's analysis port)
  uvm_analysis_export #(base_trans) trans_export;

  // Step 2: Internal array/queue to store all received transactions (YOUR CORE NEED)
  protected base_trans trans_array[];  // dynamic array
  protected base_trans trans_queue[$]; // queue (RECOMMENDED, more flexible for push/pop)

  // Constructor
  function new(string name = "base_checker", uvm_component parent = null);
    super.new(name, parent);
    trans_array = new[0];
  endfunction

  // Build phase: Initialize analysis export
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    trans_export = new("trans_export", this);
  endfunction

  // Step 3: Connect phase - Bind export to the write callback (UVM standard)
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    trans_export.connect(this.analysis_export);
  endfunction

  // Step 4: Core UVM analysis implementation - Mandatory callback function: write()
  // ✅ KEY FUNC: Automatically called when Monitor execute ap.write(tr)
  // ✅ Core logic: Push the received transaction to array/queue directly
  virtual function void write(base_trans tr);
    if(tr == null) begin
      `uvm_warning("NULL_TRANS", "Received null transaction from monitor")
      return;
    end
    trans_queue.push_back(tr);          // push to queue (RECOMMENDED)
    trans_array = new[trans_array.size()+1](trans_array);
    trans_array[trans_array.size()-1] = tr; // push to dynamic array
    `uvm_info("TRANS_RECEIVED", $sformatf("Receive transaction, push to array/queue, current count = %0d", trans_queue.size()), UVM_LOW)
  endfunction

  // Step 5: Aux function - Get transaction array/queue (for subsequent check)
  virtual function base_trans[] get_trans_array();
    return trans_array;
  endfunction

  virtual function base_trans get_trans_by_idx(int idx);
    if(idx < 0 || idx >= trans_queue.size()) begin
      `uvm_warning("INVALID_IDX", $sformatf("Index %0d out of range, queue size = %0d", idx, trans_queue.size()))
      return null;
    end
    return trans_queue[idx];
  endfunction

  // Aux function: Clear all stored transactions
  virtual function void clear_trans();
    trans_array.delete();
    trans_queue.delete();
    `uvm_info("CLEAR_ARRAY", "Clear all transactions in internal array/queue", UVM_LOW)
  endfunction

  // UVM internal analysis imp (bridge for export and write callback)
  protected uvm_analysis_imp #(base_trans, base_checker) analysis_export;

  // Constraint: Analysis imp must be initialized in constructor
  function void init_analysis_imp();
    analysis_export = new("analysis_export", this);
  endfunction

endclass

//------------------------------------------------------------------------------
// Base transaction class (match monitor's transaction)
