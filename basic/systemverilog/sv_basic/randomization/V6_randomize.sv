class test;
    bit[31:0]data;
    task test_tsk();
       repeat(10)begin
            randomize(data)with{
                data>'d123;
                data<'d256;
                data inside{[135:211]};
            };
            $display("data randomize is %d",data);
        end
    endtask
endclass
class trasnsation;
    rand bit[1:0]data1;
    rand bit[1:0]data2;
    task display();
        $display("data1 is %0d",data1);
        $display("data2 is %0d",data2);
    endtask
endclass
module top;
    initial begin
        test test_inst;
        trasnsation tr;
        tr=new();
        test_inst=new();
        test_inst.test_tsk();
        $display("end %d",123);
        tr.randomize()with{
            data1==2'b11 && data2==2'b11 || data1==2'b01 && data2==2'b01 ;
        };
        tr.display();
    end
endmodule