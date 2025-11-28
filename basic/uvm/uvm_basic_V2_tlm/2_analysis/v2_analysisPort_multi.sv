`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
//测试analysis port的广播功能
class analysisPort_Producer extends uvm_component;
    uvm_analysis_port#(tlm_tr)ap;
    `uvm_component_utils(analysisPort_Producer)
    function new(string name="analysisPort_Producer",uvm_component parent);
        super.new(name,parent);
        ap=new("ap",this);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        tlm_tr tr;
        phase.raise_objection(this);
        super.run_phase(phase);
        repeat(10)begin
            #10 tr=new("tr");
            assert(tr.randomize());
            ap.write(tr);
        end
        phase.drop_objection(this);
    endtask

endclass
class analysisPort_Consumer extends uvm_component;
    uvm_analysis_imp#(tlm_tr,analysisPort_Consumer)imp;
    `uvm_component_utils(analysisPort_Consumer)
    function new(string name="analysisPort_Consumer",uvm_component parent);
        super.new(name,parent);
        imp=new("imp",this);;
    endfunction
    

    function void write(tlm_tr tr);
    `uvm_info(get_full_name(),$sformatf("[%0d]",$time),UVM_LOW)//csm是consumer的缩写
        tr.print();
    endfunction

endclass

class analysisPort_Env extends uvm_component;
    analysisPort_Consumer csm;
    analysisPort_Consumer csm1;
    analysisPort_Consumer csm2;
    analysisPort_Consumer csm3;
    analysisPort_Producer pds;
    `uvm_component_utils(analysisPort_Env)
    function new(string name="analysisPort_Env",uvm_component parent);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        csm=analysisPort_Consumer::type_id::create("csm",this);
        csm1=analysisPort_Consumer::type_id::create("csm1",this);
        csm2=analysisPort_Consumer::type_id::create("csm2",this);
        csm3=analysisPort_Consumer::type_id::create("csm3",this);
        
        pds=analysisPort_Producer::type_id::create("pds",this);//pds 是producer的缩写
    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        pds.ap.connect(csm.imp);
        pds.ap.connect(csm1.imp);
        pds.ap.connect(csm2.imp);
        pds.ap.connect(csm3.imp);
    endfunction
endclass
module top;
    initial begin
        run_test("analysisPort_Env");
    end
endmodule