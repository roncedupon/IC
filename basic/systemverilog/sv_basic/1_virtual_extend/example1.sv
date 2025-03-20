`ifndef TLM_EXAMPLE1
`define TLM_EXAMPLE1
//父类=子类的测试
//结论：父类a=子类b，如果a的fun1不加virtual，那么调用a.fun1则输出的是父类a中fun1的结果，否则是子类b的fun1结果
class base_class;
    virtual function void display;//这里可以试一下加关键字和不加关键字有何区别
        $display("Inside base class");
    endfunction
endclass

class extended_class extends base_class;
    function void display;
        $display("Inside extended class");
    endfunction
endclass

class extended_extended_class extends extended_class;
    function void display;//似乎只要父类加了关键字就行
        $display("Instde extended_extended class");
    endfunction
endclass
module virtual_class_test;
    initial begin
        base_class base;
        extended_class extended;
        extended_extended_class extended_extended;
        base=new();
        extended=new();
        extended_extended=new();
        base=extended;
        base.display();
        base=extended_extended;
        base.display();

        $display("=============================");
        // extended=base;
        extended.display();
        extended=extended_extended;
        extended.display();

    end
endmodule
`endif 
