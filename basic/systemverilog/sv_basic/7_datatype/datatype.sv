module datatype;
    //有符号+无符号
    logic signed[7:0]signed_data;
    logic [7:0]unsigned_data;
    logic [8:0]result;
    initial begin
        signed_data=8'he0;//-32--224
        unsigned_data=8'hf0;//-16--240
        result=signed_data+unsigned_data;
        $display("%d--%x",result,result);
    end
    logic [8:0]result1;
    initial begin
        signed_data=8'he0;//-32--224
        unsigned_data=8'hf0;//-16--240
        result1=signed_data+unsigned_data;
        $display("%d--%x",result1,result1);
    end
    
    logic [15:0]result2;
    initial begin
        signed_data=8'he0;//-32--224
        unsigned_data=8'hf0;//-16--240
        result2=signed_data*unsigned_data;
        $display("%d--%x",result2,result2);
    end

    logic signed[15:0]result3;
    initial begin
        signed_data=8'he0;//-32--224
        unsigned_data=8'hf0;//-16--240
        result3=signed_data*unsigned_data;
        $display("%0d--%x",result3,result3);
    end
    
endmodule

module datatype_test;
    //有符号+无符号
    logic [7:0]unsigned_data1;
    logic [7:0]unsigned_data2;
    logic [15:0]result;
    initial begin
        unsigned_data1=8'he0;//-32--224
        unsigned_data2=8'hf0;//-16--240
        result=unsigned_data1*unsigned_data2;
        $display("%d--%x",result,result);
    end
endmodule

module datatype_test1;
    //有符号+无符号
    logic [7:0]unsigned_data1;
    logic signed[7:0]signed_data2;
    logic [15:0]result;
    initial begin
        unsigned_data1=8'he0;//-32--224
        signed_data2=8'hf0;//-16--240
        result=unsigned_data1*signed_data2;
        $display("%d--%x",result,result);
    end
endmodule
module datatype_test2;
    //有符号+无符号
    logic [7:0]unsigned_data1;
    logic signed[7:0]signed_data2;
    logic [15:0]result;
    initial begin
        unsigned_data1=8'he0;//-32--224
        signed_data2=8'hf0;//-16--240
        result=$signed({1'b0,unsigned_data1})*signed_data2;
        $display("%d--%x",result,result);
    end
endmodule