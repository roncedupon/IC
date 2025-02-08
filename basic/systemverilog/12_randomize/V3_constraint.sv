class V3_constraint;
    rand bit [15:0]SCKDV;
    constraint SCKDV_RANGE{
        SCKDV dist{
            [2:32]:=1,
            65534 :=1
        };
    }
    function new();
        //do nothing
    endfunction
    function void print();
        $display("SCKDV is %0d",SCKDV);
    endfunction
endclass

module top;
    V3_constraint cst_inst;
    int counter=0;
    initial begin
        cst_inst=new();
        repeat(100)begin

            assert (cst_inst.randomize()) else $fatal("Randomization failed");
            
            if(counter==0)begin
                cst_inst.SCKDV=2;
            end
            counter++;
            cst_inst.print();
        end
    end
endmodule