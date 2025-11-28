class father;
    function new();
    endfunction
    virtual function void fun1();
        $display("this is fun1 in fateher");
    endfunction
endclass
class son extends father;
    function new();
        super.new();
    endfunction
    function void fun1();
        $display("this is fun1 in son");
    endfunction

    function void fun2();
        $display("this is fun2 in son");
    endfunction
endclass

module top;
    father father_ptr;
    son son_ptr;
    initial begin
        son_ptr=new();
        father_ptr=son_ptr;
        father_ptr.fun1();
    end
endmodule