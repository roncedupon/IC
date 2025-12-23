//在task中使用随机,有一些限制是需要知道的
class randInTask;
    bit [31:0]data;//只能将data写在外面,作为一个成员变量而不是task中的局部变量
    task rand_task0();
        //bit [31:0]data;//写在这里是不行的
        // Error-[MFNFIOR] Constraint: member field
        // /mnt/disk_0/IC/basic/systemverilog/sv_basic/12_randomize/V8_randInTask.sv, 5
        // $unit, "data"
        //   Member field data not found in object this in randomize call.
        //   Only direct class members or member array elements can be referenced as 
        //   arguments to object randomize.        
        randomize(data)with{
            data>='h18_0000+(192)*1024;
            data<='h18_0000+(256-8)*1024;
            data[6:0]==0;
        };
        $display("data is %x",data);
    endtask 

endclass
module top;
    initial begin
        randInTask inst0;
        inst0=new();
        inst0.rand_task0();
        inst0.rand_task0();
        inst0.rand_task0();
        inst0.rand_task0();
    end
endmodule