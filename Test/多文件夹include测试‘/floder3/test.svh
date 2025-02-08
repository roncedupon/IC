`include "uvm_macros.svh"
`include "uvm_pkg.sv"

class test extends uvm_sequence_item;//用来构建一笔传输
    rand logic[7:0]data;//随机的data
    rand logic valid;//随机的valid


    function void post_randomize();
        //do nothing
    endfunction

    function new(string name="Trans");
        super.new(name);
    endfunction


endclass



