//层次测试
// 文件名: my_dut.sv
package package_name;
    genvar i;
    generate
        
    endgenerate    
endpackage
class hh;

endclass


module my_dut;
  logic [3:0] abc;

  initial begin
    abc = 4'b1010;
  end
endmodule
// 文件名: aaa.sv

module aaa;
    genvar i;
    generate
        for(i=0;i<2;i++)begin:xxx_array
            my_dut xxx(); // 实例化两个 my_dut
        end
    endgenerate

  // 给 xxx[0].abc 和 xxx[1].abc 初始化不同的值
  initial begin
    xxx_array[0].xxx.abc = 4'b0001;
    xxx_array[1].xxx.abc = 4'b1110;
    #1000
    $finish();
  end

endmodule

// 文件名: top.sv
`define FLATTEN(i) gentask[```i```].test()
module top;
    aaa aaa_inst();
    genvar i;
    generate
        for(i=0;i<2;i=i+1)begin:gentask
            task test();
                $display("aaa_inst.xxx_array[i].xxx.abc is %d",aaa_inst.xxx_array[i].xxx.abc);
            endtask
        end          
    endgenerate


    `define WAVES_FSDB
    `ifdef WAVES_FSDB
        initial begin
            $fsdbDumpfile($sformatf("waves.fsdb"));
            $fsdbDumpvars("+all");
            $fsdbDumpSVA();
            $fsdbDumpMDA(0,$sformatf("%m"));
        end
    `elsif WAVES_VCD
        initial begin
            $dumpvars;
        end
    `elsif WAVES
        initial begin
            $vcdpluson;
        end    
    `endif
    initial begin
        for(int i=0;i<2;i++)begin
            if(i==0) gentask[0].test();
            if(i==1) gentask[1].test();
        end
    end
endmodule

