
`include "constrain.sv"
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