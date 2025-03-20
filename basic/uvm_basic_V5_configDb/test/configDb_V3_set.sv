`ifndef TEST_ROOT
`define TEST_ROOT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "tlm_tr.sv"
import uvm_pkg::*;
//研究跨层次和同一层次设置的影响
typedef class son;//告诉编译器son的定义在后面
typedef class grandson;

class father extends uvm_component;
    son son0;
    son son1;
    `uvm_component_utils(father)
    function new(string name="father",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        son0=son::type_id::create("son0",this);
        son1=son::type_id::create("son1",this);

        //在father中设置grandson的值
        uvm_config_db#(int)::set(this,"son0","id0",666);
        uvm_config_db#(int)::set(this,"son1","id0",777);
    endfunction

endclass
class son extends uvm_component;
    int id;
    grandson grandson0;
    `uvm_component_utils_begin(son)
        `uvm_field_int(id,UVM_ALL_ON)
    `uvm_component_utils_end
    function new(string name="son",uvm_component parent=null);
        super.new(name,parent);
        grandson0=grandson::type_id::create("grandson0",this);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(int)::get(this,"","id0",grandson0.id))
            `uvm_fatal("son","grandson.id has not been set")
    endfunction
endclass

class grandson extends uvm_component;
    int id;
    `uvm_component_utils_begin(grandson)
        `uvm_field_int(id,UVM_ALL_ON)
    `uvm_component_utils_end
    function new(string name="grandson",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info($sformatf("grandson%0d",id),$sformatf("%s",this.get_full_name()),UVM_LOW);
        `uvm_info($sformatf("grandson%0d",id),$sformatf("this.father is %s",this.get_parent().get_full_name()),UVM_LOW);
    endfunction
endclass



module top;
    initial begin
        run_test("father");
    end
    initial begin
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son0","id",123);//这里也可以试一下如果第三个参数与变量名不一样会发生什么
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son1","id",321);//这里也可以试一下如果第三个参数与变量名不一样会发生什么

        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son0","id0",444);
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son1","id0",555);

        //先运行上面的，看不同层次set是什么结果，然后再将下面的注释解掉，看相同层次的set是什么结果
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son0","id0",1024);
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son1","id0",2048);
    end
endmodule

`endif