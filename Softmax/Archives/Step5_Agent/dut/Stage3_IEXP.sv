module Stage3_IEXP#(
    parameter P_WIDTH=8,//P 在算法那边也是取整操作，所以8bit就够了
    parameter ZWIDTH=8,
    parameter A_WIDTH=16,//感觉对于A的处理没必要像Pytorch代码那样做，直接用16bit保存下来算了
                        //A=(2^16*coef[0] * scaling_factor**2)
    parameter B_WIDTH=8,
    parameter C_WIDTH=10//注意在pytorch算法那边，这个C的值可以到700多，所以目前暂定10bit，以后有问题记得修改这些参数的位宽
    )(
    input clk,
    input rstn,
    input [ZWIDTH*8-1:0]Z,//用于最后移位移回去
    input [P_WIDTH*8-1:0]P,//进来的Z和P已经对齐
    input sValid,
    input [A_WIDTH-1:0]A,//a*s^2
    input [B_WIDTH-1:0]B,//   b/(a*s)              这几个参数的位宽还不确定需要保留多少位
    input [C_WIDTH-1:0]C,//    c/(a*s^2)

    output [P_WIDTH*2+A_WIDTH-1:0]mData[0:7],
    output mValid
);
    //第一步：计算P+A-----L(Sin*P)=C*(P*(P+A)+B)
// logic [P_WIDTH*8-1:0]P_Dly;
// delay#(P_WIDTH*8,1)delay_sDaya(
//     .clk(clk),
//     .rstn(rstn),
//     .Indata(P),
//     .outdata(P_Dly)
// );
parameter MUL_P_DLY=1;
parameter MUL_A_DLY=1;
logic [P_WIDTH*2-1:0]Mul_1_Result[0:7];//(P+B)*P
logic [P_WIDTH*2-1:0]Add_C[0:7];//(P+B)*P+C
logic [P_WIDTH*2+A_WIDTH-1:0]Mul_A_Out[0:7];//A*((P+B)*P+C)
generate
    genvar i;

    for(i=0;i<8;i=i+1)begin
        
        Mul #(P_WIDTH,P_WIDTH,P_WIDTH*2,MUL_P_DLY)Mul_P(
            .clk(clk),
            .rstn(rstn),
            .A(P[i*P_WIDTH+:P_WIDTH]+B),
            .B(P[i*P_WIDTH+:P_WIDTH]),
            .C(Mul_1_Result[i])
        );
        assign Add_C[i]=Mul_1_Result[i]+C;//P(P+B)+C
    end
    

    for(i=0;i<8;i=i+1)begin
        Mul #(P_WIDTH*2,A_WIDTH,P_WIDTH*2+A_WIDTH,MUL_A_DLY)Mul_A(
            .clk(clk),
            .rstn(rstn),
            .A(Add_C[i]),
            .B(A),
            .C(Mul_A_Out[i])
        );
        assign mData[i]=Mul_A_Out[i];
    end

    
endgenerate


delay#(1,MUL_P_DLY+MUL_A_DLY) delay_mValid(
    .clk(clk),
    .rstn(rstn),
    .Indata(sValid),
    .outdata(mValid)
);




endmodule
