//有rand和没有rand的区别
class test_no_rand;
    rand bit[31:0]data;//可以去掉这里的rand查看区别
    //无rand会报error
    // Error-[CNST-CIF] Constraints inconsistency failure
    // /mnt/disk_0/IC/basic/systemverilog/sv_basic/12_randomize/V7rand_and_no_rand.sv, 25
    //   Constraints are inconsistent and cannot be solved.
    //   Please check the inconsistent constraints being printed above and rewrite them.

    constraint c{
        data>10;
        data<15;
    };
    task display();
        $display("data is %d\n",data);
    endtask
endclass
module top;
    initial begin
        test_no_rand no_rand;
        no_rand=new();
        assert(no_rand.randomize());
        // else $fatal(0,"randomize failed");
        no_rand.display();
        assert(no_rand.randomize());
        // else $fatal(0,"randomize failed");
        no_rand.display();
        assert(no_rand.randomize());
        // else $fatal(0,"randomize failed");
        no_rand.display();
        assert(no_rand.randomize());
        // else $fatal(0,"randomize failed");
        no_rand.display();
    end
endmodule