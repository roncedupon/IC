//第一个class
class Transaction;
    //输出数据包的地址，并计算循环冗余校验码(crc)
    bit [31:0]addr,crc,data[8];
    int a;
    function new();
        addr=3;
        a=10;
        foreach(data[i])begin
            data[i]=5;
        end
    endfunction

    function void display();
        $display("Transaction:%h",addr);
        $display("size of data.xor is %d",$size(data.xor));
        $display("^'b0101_0101 is %d",^('b0101_0101));//奇偶校验
        $display("^'b0101_0100 is %d",^('b0101_0100));//返回1bit数据,就是对0101_0100全部异或起来
        $display("('b0101_0100)^('b0101_0100)^('b0101_0100) is %b",('b0101_0100)^('b0101_0100)^('b0101_0100));//返回8 bit数据，逐bit异或
        $display("data.xor is %d",data.xor);
    endfunction

    function void calc_crc();

        crc=addr^data.xor;
    endfunction

endclass
//-----------------------------------------------------------------
//静态变量--在类中创建一个静态变量，该变量可以被这个类的所有实例所共享。

class Transaction_static extends Transaction;
    static int count=0;
    int id;
    // int a;
    function new();
        super.new();
        id=count++;
        a=20;
    endfunction
    function void mydisplay();
        $display("a is %d",a);
    endfunction

    //静态方法--实现一个显示静态变量的静态方法
    static function void display_statics();
        $display("Transaction nums is %0d",count);
    endfunction

endclass

module test;
    Transaction tr;
    initial begin
        tr=new();
        tr.display();
    end
//静态变量
    Transaction_static tr_st1;
    Transaction_static tr_st2;
    initial begin
        $display("=============beginning of %m===============");
        tr_st1=new();
        tr_st2=new();
        tr_st1.display();
        $display("tr_st1.count is %d ;tr_st1.id is %d;\ntr_st2.count is %d ;tr_st2.id is %d;",tr_st1.count,tr_st1.id,tr_st2.count,tr_st2.id);
        //通过类名对静态变量访问
        $display("Transaction_static::count is %d",Transaction_static::count);
        tr_st1.mydisplay();
    end
endmodule
//-----------------------------------------------------------------
//静态变量之间的继承
class Transaction_static_extend extends Transaction_static;
    function new();
        super.new();
    endfunction

endclass

module test_static_extend;

//静态变量继承
    Transaction_static_extend tr_st_extend1;
    Transaction_static_extend tr_st_extend2;
    initial begin
        $display("=============beginning of %m===============");
        tr_st_extend1=new();
        tr_st_extend2=new();
        $display("tr_st_extend1.count is %d",tr_st_extend1.count);
        $display("tr_st_extend1.count is %d ;tr_st_extend1.id is %d;\ntr_st_extend2.count is %d ;tr_st_extend2.id is %d;",tr_st_extend1.count,tr_st_extend1.id,tr_st_extend2.count,tr_st_extend2.id);
        //通过类名对静态变量访问
        $display("Transaction_static_extend::count is %d",Transaction_static_extend::count);
    end
endmodule
//结论:如果父类的静态成员变量不设置为protected的话，子类会继承父类的静态成员变量，并且多个不同tb中的子类和父类和父类共享该静态成员变量



