`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

class my_seq extends uvm_sequence #(my_trans);
  `uvm_object_utils(my_seq)

  function new(string name="my_seq");
    super.new(name);
  endfunction

  virtual task body();
    my_trans tr;

    `uvm_info("DEMO", $sformatf("Before uvm_do_with: tr=%0p", tr), UVM_LOW)

    // tr=null，会自动 create
    `uvm_do_with(tr, { data inside {[10:20]}; })
    `uvm_info("DEMO", $sformatf("After auto create: tr=%0p, data=%0d", tr, tr.data), UVM_LOW)

    // 手动 create + do_with
    tr = my_trans::type_id::create("tr_manual");
    `uvm_do_with(tr, { data == 42; })
    `uvm_info("DEMO", $sformatf("Manual create: tr=%0p, data=%0d", tr, tr.data), UVM_LOW)
  endtask
endclass


class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    my_seq seq;
    phase.raise_objection(this);

    seq = my_seq::type_id::create("seq");
    seq.start(null);   // 没有 sequencer 就传 null

    phase.drop_objection(this);
  endtask
endclass





module top;
  initial begin
    run_test("my_test");
  end
endmodule
