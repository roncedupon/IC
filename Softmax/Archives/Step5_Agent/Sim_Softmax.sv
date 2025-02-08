`include "driver.sv"
`include "SoftMax_Env.sv"
`include "interfaces.sv"
`include "./dut/Stage1_FindMax.sv"
`include "./dut/Stage2_ComputeZP.sv"
`include "./dut/Stage3_IEXP.sv"
module Sim_Softmax;
//生成激励
reg clk;
reg rstn;
reg[7:0]rxd;
reg rx_dv;
wire [7:0]txd;
wire tx_en;


// initial begin
//     my_driver drv;
//     drv=new("drv",null);
//     drv.main_phase(null);
//     $finish();
// end
//加载txt文件
parameter Mem_Depth =197*192;
parameter Mem_Width=8;//txt数据位宽
reg	[Mem_Width-1:0]	mem	[0:Mem_Depth-1];


   
initial begin
    clk=0;
    rstn=1'b0;

    #1000
    rstn=1'b1;

end


//例化VIF
mAxis input_if(clk,rstn);
sAxis Stage1_output_if(clk,rstn);


always#5 clk=~clk;//100M时钟

initial begin
    run_test("SoftMax_Env");
    
end
integer i;
reg [7:0] mem01 [0:3];

initial begin
    // run_test("my_dirver");
    uvm_config_db#(virtual mAxis)::set(null,"uvm_test_top.Stage1_FindMax_Agent.SoftMax_Driver_Inst","vif",input_if);//初始化interface
    uvm_config_db#(virtual sAxis)::set(null,"uvm_test_top.Stage1_FindMax_Agent.SoftMax_Monitor_Inst","vif",Stage1_output_if);//初始化interface
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0,Sim_Softmax,"+mda");
   
    $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
    $dumpvars(0,Sim_Softmax);
    
    // $dumpvars(0,"+mda");
    
    // for (i=0;i<100;i=i+1)
    //     $dumpvars(0,FindMax.Stage1_Mem[i]);
    // $dumpall;
    // $vcdplusfile("waves.vpd");
    // $vcdplusmemon(mem01);
    // $vcdpluson();
    
    // $vcdplusoff;
    
end

wire FindMax_mValid;
wire [63:0]FindMax_mData;
Stage1_FindMax#(197,64)FindMax(
    .clk(clk),
    .rstn(rstn),
    .sValid(input_if.mValid),
    .sData(input_if.mData),
    .sReady(input_if.mReady),
    .Matrix_Col(8'd197),
    .Matrix_Row(8'd197),
    .mValid(FindMax_mValid),
    .mData(FindMax_mData),
    .mLast(Stage1_output_if.sLast)
);
assign Stage1_output_if.sValid=FindMax_mValid;
assign Stage1_output_if.sData=FindMax_mData;

logic [63:0]P;
logic [63:0]Z;
logic Stage2_ComputeZ_mValid;

Stage2_ComputeZP Stage2_ComputeZ(
    // input start,
    .clk(clk),
    .rstn(rstn),
    .Scale(16'd1234),//这个就是(-S/ln2)<<16取整后的值----这里放大2^16倍完全够用,如果位宽超了,那就放大2^15倍试试精度
    .sData(FindMax_mData),
    .sValid(FindMax_mValid),

    .P(P),
    .Z(Z),
    .mValid(Stage2_ComputeZ_mValid)

);

Stage3_IEXP Stage3_IEXP(
    .clk(clk),
    .rstn(rstn),
    .Z(Z),
    .P(P),
    .sValid(Stage2_ComputeZ_mValid),
    .A('d1234),
    .B('d23),
    .C('d345)
);

logic [7:0]A;
logic [3:0]B;
assign A=8'b11110000;
assign B=A;
wire [-1:0]C;
assign C='d0;
endmodule
