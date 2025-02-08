module test1;
    bit[3:0]mode;
    bit[1:0]key;
    reg clk;
    initial begin
        clk=0;
    end
    always #5 clk=~clk;

    function display();
        $display("[%0tns] mode=0x%0x,key=%0x0h",$time,mode,key);
    endfunction

    //  Covergroup: cg_CovGrp
    //
    covergroup cg_CovGrp@(posedge clk);
        coverpoint mode{
            bins featureA={0};
            bins featureB={[1:3]};
            bins common []={4:$};
            bins reserve=default;
        }
    endgroup: cg_CovGrp

    cg_CovGrp cov_inst=new();
endmodule