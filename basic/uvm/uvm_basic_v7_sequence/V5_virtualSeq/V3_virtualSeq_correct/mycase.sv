`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mytransaction.sv"
`include "myenv.sv"
import uvm_pkg::*;
class mycase extends uvm_test;
    myenv env1;
    myenv env2;
    myVseqr Vseqr;
    `uvm_component_utils(mycase)

    function new(string name="mycase",uvm_component parennt);    
        super.new(name,parennt);
    endfunction 
    virtual function void build_phase(uvm_phase phase);
        env1=myenv::type_id::create("env1",this);
        env2=myenv::type_id::create("env2",this);
        Vseqr=myVseqr::type_id::create("Vseqr",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        Vseqr.seqr1=env1.seqr;
        Vseqr.seqr2=env2.seqr;
    endfunction
endclass