`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
//目的:因为上一版V2使用blocking port无法实现广播，现在再试一下看一下analysis的广播

class analysisPort_Producer extends uvm_component;
    uvm_analysis_port#(tlm_tr)ap;
    `uvm_component_utils(analysisPort_Producer)
    function new(string name="analysisPort_Producer",uvm_component parent);
        super.new(name,parent);
        ap=new("ap",this);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        tlm_tr tr;
        tlm_tr tr;

        phase.raise_objection(this);
        super.run_phase(phase);

        #10 tr=new("tr");
        assert(tr.randomize());
        ap.write(tr);


        phase.drop_objection(this);
    endtask

endclass
class analysisPort_Consumer extends uvm_component;
    integer dly=0;
    uvm_analysis_imp#(tlm_tr,analysisPort_Consumer)imp;
    `uvm_component_utils(analysisPort_Consumer)
    function new(string name="analysisPort_Consumer",uvm_component parent);
        super.new(name,parent);
        imp=new("imp",this);;
    endfunction
    

    function void write(tlm_tr tr);
        $display("[%0d]write function in %s called",$time,get_name());
    endfunction

endclass

class analysisPort_Env extends uvm_component;
    analysisPort_Consumer csm0;
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
        csm0=analysisPort_Consumer::type_id::create("csm0",this);
        csm1=analysisPort_Consumer::type_id::create("csm1",this);
        csm2=analysisPort_Consumer::type_id::create("csm2",this);
        csm3=analysisPort_Consumer::type_id::create("csm3",this);
        pds=analysisPort_Producer::type_id::create("pds",this);//pds 是producer的缩写
    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        pds.ap.connect(csm0.imp);
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