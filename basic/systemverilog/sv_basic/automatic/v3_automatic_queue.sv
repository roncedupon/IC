// =======================
// tb.sv
// =======================
`timescale 1ns/1ps

typedef int queue_of_int[$];  
function  queue_of_int get_register_name();
    queue_of_int ret;
    ret.push_back(1);
    ret.push_back(2);
    ret.push_back(5);
    ret.push_back(10);
    return ret;
endfunction

class test;

    function  queue_of_int get_register_name();
        queue_of_int ret;
        ret.push_back(1);
        ret.push_back(2);
        ret.push_back(5);
        ret.push_back(10);
        return ret;
    endfunction
endclass 

module tb;
    queue_of_int q,q1,q2,q3,q4;
    test test_inst;
    initial begin
        q = get_register_name();
        q1 = get_register_name();
        q2 = get_register_name();
        q3 = get_register_name();
        q4 = get_register_name();
        test_inst=new();

        $display("Returned Queue Size = %0d", q.size());
        $display("size of q4 is %d ",q4.size());


        q =  test_inst.get_register_name();
        q1 = test_inst.get_register_name();
        q2 = test_inst.get_register_name();
        q3 = test_inst.get_register_name();
        q4 = test_inst.get_register_name();
        $display("-------------------------------");
        $display("Returned Queue Size = %0d", q.size());
        $display("size of q4 is %d ",q4.size());

        #10 $finish;
    end

endmodule
