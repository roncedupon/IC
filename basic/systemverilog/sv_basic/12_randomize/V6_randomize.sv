class test;
    bit[31:0]data;
    task test_tsk();
       repeat(10)begin
            randomize(data)with{
                data>'h123;
                data<'h256;
            };
            $display("data randomize is %d",data);
        end
    endtask
endclass
module top;
    initial begin
        test test_inst;
        test_inst=new();
        test_inst.test_tsk();
        $display("end %d",123);
    end
endmodule