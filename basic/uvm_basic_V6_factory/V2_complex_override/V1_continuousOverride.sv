`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class father extends uvm_object;
    `uvm_object_utils(father)
    
    function new(string name="father");
        super.new(name);
    endfunction
    virtual function void fun1();
        $display("this is fun1 in fateher");
    endfunction
    function void fun2();
        $display("this is fun2 in father");
    endfunction
endclass
class son extends father;
    `uvm_object_utils(son)
    function new(string name="son");
        super.new(name);
    endfunction
    function void fun1();
        $display("this is fun1 in son");
    endfunction

    function void fun2();
        $display("this is fun2 in son");
    endfunction
    function void fun3();
        $display("this is fun3 in son");
    endfunction
endclass
class grandson extends son;
    `uvm_object_utils(grandson)
    function new(string name="grandson");
        super.new(name);
    endfunction
    function void fun1();
        $display("this is fun1 in grandson");
    endfunction

    function void fun2();
        $display("this is fun2 in grandson");
    endfunction
    function void fun3();
        $display("this is fun3 in grandson");
    endfunction
endclass
class mycase extends uvm_component;
    `uvm_component_utils(mycase)
    son son_inst;
    father father_inst;
    grandson grandson_inst;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        if(0)begin
            //先用son替换father，再用grandson替换son
            set_type_override_by_type(father::get_type(),son::get_type());
            set_type_override_by_type(son::get_type(),grandson::get_type());
            father_inst=father::type_id::create("father_inst");
            son_inst=son::type_id::create("son_inst");
            grandson_inst=grandson::type_id::create("grandson_inst");
            // set_type_override_by_type(father::get_type(),son::get_type());
            print(father_inst);//grand_son
            $display("----------------");
            print(son_inst);   //grand_son     
            $display("----------------");
            print(grandson_inst);//grand_son
        end
        else begin
            if(0)begin//验证重载的先后顺序
                //先用son 替换father，再用grandson替换father
                set_type_override_by_type(father::get_type(),son::get_type());
                set_type_override_by_type(father::get_type(),grandson::get_type());
                father_inst=father::type_id::create("father_inst");
                son_inst=son::type_id::create("son_inst");
                grandson_inst=grandson::type_id::create("grandson_inst");
                // set_type_override_by_type(father::get_type(),son::get_type());
                print(father_inst);//grand_son
                $display("----------------");
                print(son_inst);        //son
                $display("----------------");
                print(grandson_inst);//grand_son
            end
            else begin//验证replace
                //先用son 替换father，再用grandson替换father
                set_type_override_by_type(father::get_type(),son::get_type());
                set_type_override_by_type(father::get_type(),grandson::get_type(),0);//将replace设置为0
                father_inst=father::type_id::create("father_inst");
                son_inst=son::type_id::create("son_inst");
                grandson_inst=grandson::type_id::create("grandson_inst");
                // set_type_override_by_type(father::get_type(),son::get_type());
                print(father_inst);//son
                $display("----------------");
                print(son_inst);        //son
                $display("----------------");
                print(grandson_inst);//grand_son
            end
        end

    endfunction
    function void print(father ptr);
        ptr.fun1();
        ptr.fun2();
        // ptr.fun3();
    endfunction
endclass
module top;
    father fd;
    grandson gs;
    initial begin
        run_test("mycase");
    end
    // initial begin
    //     gs=new("gs");
    //     fd=gs;
    //     fd.fun1();
    // end
endmodule