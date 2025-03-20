// task delay#(parameter width=8,parameter delay_times = 1)(input clk,input rst,input [width-1:0]Indata,output logic[width-1:0]outdata);

// endtask

module delay#(
    parameter width=8,
    parameter delay_times = 1)(
        input clk,
        input rstn,
        input [width-1:0]Indata,
        output logic[width-1:0]outdata
    );

    genvar i;
    logic [width-1:0]dly_array[0:delay_times];//不做延时用啥delay
    generate
        if(delay_times==0)begin
            assign outdata=Indata;
        end
        else begin
            always_ff @(posedge clk or negedge rstn) begin
                if(!rstn)begin
                    dly_array[0]<=0;
                end
                else dly_array[0]<=Indata;//打一拍
            end
            for(i=1;i<delay_times;i++)begin
                always_ff @(posedge clk or negedge rstn) begin
                    if(!rstn)begin
                        dly_array[i]<=0;
                    end
                    else dly_array[i]<=dly_array[i-1];
                end
            end
        end
    endgenerate
    assign outdata=dly_array[delay_times-1];
endmodule
//第二个版本↓
// logic Z_Valid;
// reg valid_dly[0:Zdelay_times-1];
// assign Z_Valid=valid_dly[Zdelay_times-1];
// generate;
//     if(Zdelay_times==1) begin
//         always@(posedge clk or negedge rstn)begin
//             if(!rstn)
//                 valid_dly<=0;
//             else valid_dly<=valid;
//         end
        
//     end
//     else begin
//         always_ff@(posedge clk or negedge rstn)begin
//             if(!rstn) for(int i=0;i<Zdelay_times;i=i+1)valid_dly[i]<=0;
//             else for(int i=0;i<Zdelay_times;i=i+1)valid_dly<={valid_dly[Zdelay_times-2:0],valid};
//         end
//     end
// endgenerate