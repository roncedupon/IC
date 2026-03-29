`ifndef MAILBOX_RESIDUE_TEST_SV
`define MAILBOX_RESIDUE_TEST_SV

`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

typedef struct {
  int id;
  int value;
} data_item;

// 同一个 class，连续跑多次
class my_seq extends uvm_sequence;
  `uvm_object_utils(my_seq)

  mailbox #(data_item) mbx;
  int data_count = 0;

  function new(string name="my_seq");
    super.new(name);
    mbx = new();  // 每次 new 都会新建一个 mailbox
  endfunction

  virtual task body();
    `uvm_info("SEQ", $sformatf("===== SEQ %s start =====", get_full_name()), UVM_NONE)

    fork
      put_data();
      get_data();
      #30;  // 很短时间就 kill
    join_any
    disable fork;

    `uvm_info("SEQ", $sformatf("SEQ %s end, data_count=%0d", get_full_name(), data_count), UVM_NONE)
  endtask

  task put_data();
    data_item item;
    int i=0;
    forever begin
      item.id    = i;
      item.value = 0;  // 统一标记，方便看残留
      mbx.put(item);
      `uvm_info("PUT", $sformatf("put id=%0d", item.id), UVM_NONE)
      #5;
      i++;
    end
  endtask

  task get_data();
    data_item item;
    forever begin
      mbx.get(item);
      data_count++;
      `uvm_info("GET", $sformatf("got id=%0d", item.id), UVM_NONE)
      #10;
    end
  endtask

endclass

// 连续跑 2 次 seq，看是否串数据
module top;
  uvm_sequencer #(uvm_sequence_item) sqr;
  my_seq seq1, seq2;

  initial begin
    sqr = new("sqr");

    `uvm_info("TOP", "========== Run seq1 ==========", UVM_NONE)
    seq1 = new("seq1");
    seq1.start(sqr);

    `uvm_info("TOP", "========== Run seq2 ==========", UVM_NONE)
    seq2 = new("seq2");
    seq2.start(sqr);

    `uvm_info("TOP", "========== Test done ==========", UVM_NONE)
    $finish;
  end
endmodule

`endif