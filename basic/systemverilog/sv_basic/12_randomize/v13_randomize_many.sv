//A 从{0，1，2}，3，4中进行选择
//主要是有这种场景：{1，3，3}代表一种模式，3，4也分别代表一种模式，在循环是，如果上一次和这一次模式相同，就不用执行一种操作op，否则必须执行该操作op
class randtest;
    rand bit [2:0]mode;
    constraint mode_cstr{
        (mode inside {0,1,2}) || (mode inside {3,4});//不太行的样子
    }
    
    task display();
        $display("%0d",mode);
    endtask
endclass

module top;
    initial begin
        randtest randtest_inst;
        randtest_inst=new();
        for(int i=0;i<100;i++)begin
            randtest_inst.randomize();
            randtest_inst.display();            
        end

    end

endmodule