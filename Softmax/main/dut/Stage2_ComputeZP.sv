// 第二阶段：计算Z并且缓存Z
// task delay(input int width,input reg [width-1:0],input int times);
//     for(int i=0;i<times;i++)begin
//         logic [width-1:0]dly_tmp;
//         always @(posedge clk or posedge rst) begin
//             if(rst)
//         end
//     end
// endtask

`include "Mul.sv"
`include "delay.sv"
//现在一下进8个点，所以需要进行8并行度的设计
//需要计算Z和P，Z=lceil(-X/ln2)
module Stage2_ComputeZP#(
    parameter SCALE1_WIDTH=16,//floor(-Scale/ln2)
    parameter SCALE1_SHIFT=16,//就是-S/ln2需要左移多少位,默认16,如果位宽不够,需要在算法和硬件这边同时修改
    parameter DATAWIDTH=64,
    parameter P_WIDTH=8)(
    // input start,
    input logic clk,
    input logic rstn,
    input logic[SCALE1_WIDTH-1:0]Scale1,//这个就是(-S/ln2)<<16取整后的值----这里放大2^16倍完全够用,如果位宽超了,那就放大2^15倍试试精度
    input logic[7:0]Scale2,//floor(-ln2/S)----为什么位宽不一样，可以参考pytorch的IntSoftmax代码，int_exp部分，
                            //大体思路：首先需要计算得到Z，Z需要X和Scale做计算，Scale用16bit表示是为了尽可能保证Z的值准确
                            //Scale2用8bit表示是因为在pytorch那边直接做了取整操作，所以无需定点化，直接拿过来用就行（前提保证pytorch那边来的数据在-128~127之间)-->以后可以让算法那边检查一下，但是估计问题不大(2024-4-29/22:08)

    input logic[DATAWIDTH-1:0]sData,
    input logic sValid,
    output logic [P_WIDTH*8-1:0]P,//p值，现在默认为P_WIDTHbit，在pytorch那边直接取整，所以用8bit就行
    output logic [64-1:0]Z,//Z和P同时出去
    output logic mValid
);
parameter Zdelay_times =1 ;//乘法器计算延时
parameter Pdelay_times =1 ;//乘法器计算延时
parameter delay_times=Zdelay_times+Pdelay_times;

// logic Z_Valid;
reg [delay_times-1:0]valid_dly;//对输入的valid进行延时，延时乘法需要一定的周期
assign mValid=valid_dly[delay_times-1];
generate;
    if(delay_times==1) begin
        always_ff@(posedge clk or negedge rstn)begin
            if(!rstn)
                valid_dly<=0;
            else valid_dly<=sValid;
        end
    end
    else begin
        always_ff@(posedge clk or negedge rstn)begin
            if(!rstn) for(int i=0;i<delay_times;i=i+1)valid_dly[i]<=0;
            else for(int i=0;i<delay_times;i=i+1)valid_dly<={valid_dly[delay_times-2:0],sValid};
        end
    end
endgenerate



wire [8+SCALE1_WIDTH-1:0]Z_Tmp[0:7];
generate;
    genvar i;
    for(i=0;i<8;i=i+1)begin
        Mul#(.AWidth(8),.BWidth(SCALE1_WIDTH),.CWidth(8+SCALE1_WIDTH),.delay_times(Zdelay_times))Compute_Z(//计算Z
            .clk(clk),//conpute Z=floor(Xq*Scale1)
            .rstn(rstn),
            .A(sData[i*8+:8]),
            .B(Scale1),
            .C(Z_Tmp[i])
        );
    end
endgenerate

wire [63:0]Z_Tmp2;
for (i=0;i<8;i=i+1)begin
    assign Z_Tmp2[i*8+:8]=Z_Tmp[i][8+SCALE1_WIDTH-1-:8+SCALE1_WIDTH-SCALE1_SHIFT];
end
delay#(64,Pdelay_times)Z_Dly_Md(
    .clk(clk),
    .rstn(rstn),
    .Indata(Z_Tmp2),
    .outdata(Z)
);

//得到Z后，继续得到P的值
logic[63:0]sDAta_Dly;
delay#(64,delay_times)sDAta_Dly_Md(
    .clk(clk),
    .rstn(rstn),
    .Indata(sData),
    .outdata(sDAta_Dly)
);
//得到Z后，继续得到P的值

wire [15:0]P_Tmp[0:7];
// wire [P_WIDTH-8-1:0]zeros;//如果P是8bit数据，那么zeros为[-1:0]，不会产生zeros--当然这里也可以写死，现在主要是担心以后P的位宽会发生变化
generate;
    for(i=0;i<8;i=i+1)begin
        Mul#(.AWidth(8),.BWidth(8),.CWidth(16),.delay_times(Pdelay_times))Compute_P(
            .clk(clk),//conpute Z=floor(Xq*Scale1)
            .rstn(rstn),
            .A(Scale2),
            .B(Z_Tmp[i][8+SCALE1_WIDTH-1-:8+SCALE1_WIDTH-SCALE1_SHIFT]),//移位取整后的Z
            .C(P_Tmp[i])//
        );
        assign P[i*P_WIDTH+:P_WIDTH]=$signed(sDAta_Dly[i*8+:8])-$signed(P_Tmp[i]);//此处是不是需要加一个signed？
    end
endgenerate











endmodule
