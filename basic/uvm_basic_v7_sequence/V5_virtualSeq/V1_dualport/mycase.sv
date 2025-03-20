`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mytransaction.sv"
`include "myenv.sv"
import uvm_pkg::*;
class mycase extends uvm_test;
    myenv env1;
    myenv env2;
    `uvm_component_utils(mycase)

    function new(string name="mycase",uvm_component parennt);    
        super.new(name,parennt);
    endfunction 
    virtual function void build_phase(uvm_phase phase);
        env1=myenv::type_id::create("myenv1",this);
        env2=myenv::type_id::create("myenv2",this);
    endfunction
endclass