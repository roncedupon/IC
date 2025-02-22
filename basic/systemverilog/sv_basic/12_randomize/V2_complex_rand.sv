class V2_complex_rand;
    randc int nums;
    randc bit[3:0]NDF;
    function new();
        this.randomize()with{
            
            NDF>=1;
            NDF<=10;
            nums>NDF;//int'(NDF);
            nums<1024;
        };
    endfunction
endclass
module test;
    V2_complex_rand rand_inst;
    initial begin
        rand_inst=new();
        $display("%0d--%0d",rand_inst.NDF,rand_inst.nums);
    end

endmodule