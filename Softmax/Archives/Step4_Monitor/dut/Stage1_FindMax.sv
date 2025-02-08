module Stage1_FindMax#(parameter BRAM_DEPTH =197,parameter DATA_WIDTH=64,parameter MAX_ROW=1024)(//现在一下进8个点，找最大值应该是按照8个点流水式地找
    //Bram的深度：200
    
    input clk,
    input rstn,
    input sValid,
    input [DATA_WIDTH-1:0]sData,//这里输入的Xq是Xq-Zp后的值
    output logic sReady,
    input [$clog2(BRAM_DEPTH)-1:0]Matrix_Col,//矩阵列数,若列数不是8的倍数，上层模块应该进行补零操作
    input [$clog2(MAX_ROW)-1:0]Matrix_Row,//矩阵列数,若列数不是8的倍数，上层模块应该进行补零操作
    output logic [DATA_WIDTH-1:0]mData,//最大值减去Xq
    output logic mValid,
    output logic mLast
);
genvar i;
// for (i=0;i<8;i=i+1)begin
//     wire [7:0]sData_Test;
//     assign sData_Test=sData[i*8+:8];
// end
// 向上取整
logic [$clog2(BRAM_DEPTH)-1:0]count_times;
logic remainder;
assign remainder=|Matrix_Col[$clog2(DATA_WIDTH)-1:0];
assign count_times=(Matrix_Col>>$clog2(DATA_WIDTH/8))+remainder;//todo:下面这种表示写法有问题，出来的结果是12，，运算符优先级的问题吧
// assign count_times=Matrix_Col>>$clog2(DATA_WIDTH/8)+remainder;

reg [$clog2(MAX_ROW)-1:0]Row_Cnt;//行计数器
logic [$clog2(BRAM_DEPTH)-1:0]Col_Cnt;//列计数器
logic signed[7:0]Max;
logic signed[7:0]Last_Max;
logic Col_Cnt_Valid;
assign Col_Cnt_Valid =(Col_Cnt==count_times-1&&sValid)||Col_Cnt==count_times-1&&Row_Cnt==Matrix_Row;//后面这一个条件是为了处理边界问题


always_ff@(posedge clk or negedge rstn) begin
    if(!rstn)begin
        Col_Cnt<=0;
    end
    else if(Col_Cnt_Valid)begin
        Col_Cnt<=0;
    end
    else if(sValid&sReady||Row_Cnt==Matrix_Row)Col_Cnt<=Col_Cnt+1'b1;//最后一行的时候也要读取数据
end

//构建一个多级流水的比较器

reg signed [7:0]Max_4[0:3];//对进来的8个点进行两两比较，取4个最大值

always_ff@(posedge clk or negedge rstn)begin
    if (!rstn)
        for (int i=0;i<4;i=i+1)
            Max_4[i]<=0;
    else begin
        
        for (int i = 0; i <4; i = i+1)//需要注意这里不加signed的话，比较就按无符号比较，于是出现负数比正数大的情况
            Max_4[i] <= $signed(sData[2*i*8+:8])<$signed(sData[(2*i+1)*8+:8])?sData[(2*i+1)*8+:8]:sData[2*i*8+:8];//>sData[7:0]?sData[7:0]:sData[7:0];//对比较结果打一拍
    end
end
// wire[7:0]testttttt[0:3];
// for(i=0;i<4;i=i+1)assign testttttt[i]=sData[(2*i)*8+:8];
reg signed [7:0]Max_2[0:1];//对上一级的4个点继续进行两两比较，取2个最大值

always_ff@(posedge clk or negedge rstn)begin
    if (!rstn)
        // Max_2 <= '{default: '0};
        for (int i=0;i<2;i=i+1)
            Max_2[i]<=0;
    else begin
        Max_2[0] <= Max_4[0]<Max_4[1]?Max_4[1]:Max_4[0];
        Max_2[1] <= Max_4[2]<Max_4[3]?Max_4[3]:Max_4[2];
    end
end

logic signed [7:0]Max_1;
wire Max1_Valid;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn |Col_Cnt_Valid)begin
        Max_1<='d0;
    end
    else begin
        Max_1<=Max_2[1]<Max_2[0]?Max_2[0]:Max_2[1];
    end
end



parameter Max_Dly_Times=4;//对Max_valid 延时4拍
parameter Max1_Dly_Times=3;//对Max_valid 延时4拍
reg [Max_Dly_Times-1:0]Max_Valid_Dly;
reg [Max1_Dly_Times-1:0]Max1_Valid_Dly;
assign Max1_Valid=Max1_Valid_Dly[Max1_Dly_Times-1];
wire Max_Valid;
assign Max_Valid=Max_Valid_Dly[Max_Dly_Times-1];

always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        Max<='d0;
    end
    else if(Max_Valid)Max<=0;
    else begin
        Max<=(Max<Max_1)&&Max1_Valid?Max_1:Max;
    end
end
always_ff@(posedge clk or negedge rstn)begin
    if (!rstn)begin
        Max_Valid_Dly<='d0;
        Max1_Valid_Dly<='d0;
        // Max_Valid<=1'b0;
    end
    else begin
        Max_Valid_Dly<={Max_Valid_Dly[Max_Dly_Times-2:0],Col_Cnt_Valid};
        Max1_Valid_Dly<={Max1_Valid_Dly[Max1_Dly_Times-2:0],sValid};
        // Max_Valid<=Max_Valid_Dly[Max_Dly_Times-1];//这里不知道怎么回事，赋值位Max_Dly[3]，VCS也没有报错。。
    end
end

always_ff@(posedge clk or negedge rstn) begin
    if(!rstn)begin
        Last_Max<='b0;
    end
    else if(Max_Valid)begin
        Last_Max<=Max;
    end
end


logic IS_GET_ONE_COL;
always_ff @(posedge clk or negedge rstn) begin
    if(!rstn)begin
        IS_GET_ONE_COL<=1'b0;
    end
    else if(Max_Valid)begin
        IS_GET_ONE_COL<=1'b1;
    end
end



always_ff @(posedge clk or negedge rstn)begin
    if(!rstn)begin
        sReady<=1'b1;
    end
    else if (Col_Cnt_Valid)sReady<=1'b0;//这样做的目的是让进来的数停一下，因为比较器中还有一些残留的数据没处理完
    else if (Max_Valid)sReady<=1'b1;
end
//同时加一个缓存模块
//当进完一行数据后,之后就需要从MEM中取数据了
logic [DATA_WIDTH-1:0]Stage1_Mem[0:BRAM_DEPTH-1];
//每进一个数,就把它存下来

reg [$clog2(BRAM_DEPTH)-1:0]waddr;//写地址，写地址要慢都地址一拍，防止读写冲突
reg [DATA_WIDTH-1:0]wdata;
reg wen;//写使能
always_ff@(posedge clk or negedge rstn)begin
    if (!rstn)begin
        waddr<=0;
        wdata<=0;
        wen<=0;
    end
    else begin
        waddr<=Col_Cnt;//Col_Cnt其实也是读地址，写地址永远慢读地址一拍
        wdata<=sData;
        wen<=sValid&&sReady;
    end
end

always_ff @(posedge clk) begin
    if(wen)begin
        Stage1_Mem[waddr]<=wdata;//进一个数,存下来
    end
end

//接下来的策略就是读快写一拍，每进一个数，先读再写，有Col_Cnt控制读写地址

    for (i=0;i<DATA_WIDTH/8;i=i+1)begin
        always_ff@(posedge clk or negedge rstn)begin
            if (!rstn)mData[i*8+:8]<=0;//Last_Max-
            else mData[i*8+:8]<=Last_Max-Stage1_Mem[Col_Cnt][i*8+:8];//-Last_Max;
        end
    end

wire Row_Cnt_Valid;
assign Row_Cnt_Valid=(Row_Cnt==Matrix_Row)&&Col_Cnt_Valid;//Row_Cnt需要多数一行
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)Row_Cnt<=0;
    else if(Row_Cnt_Valid)Row_Cnt<=0;
    else if(Col_Cnt_Valid)Row_Cnt<=Row_Cnt+1'b1;
end

// logic valid_next;
    //还是把这里改成fifo好了
always_ff @(posedge clk or negedge rstn) begin
    if(!rstn)begin
        mValid<=0;
        mLast<=0;
    end
    else begin
        mLast<=Row_Cnt_Valid;
        mValid<=(IS_GET_ONE_COL&sValid&sReady)||Row_Cnt==Matrix_Row;//进一个数，往外面蹦一个数
    end 

end
endmodule  

