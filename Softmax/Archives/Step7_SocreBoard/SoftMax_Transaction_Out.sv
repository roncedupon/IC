`ifndef SOTFMAX_TRANSACTION_OUT
`define SOTFMAX_TRANSACTION_OUT
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
class SoftMax_Transaction_Out#(int Matrix_Row=197,int Matrix_Col=197) extends uvm_sequence_item;

    bit[63:0]Matrix[];
    string File_Loc="Softmax_Out.txt";
    `uvm_object_utils(SoftMax_Transaction_Out)//factory机制，注册
    //本次传输主要是传输一个矩阵，每个Transaction发送一个完整矩阵，矩阵的数据来源于pytorch生成的真实数据
    function new(string name="SoftMax_Transaction_Out",string File_Loc="Softmax_Out.txt");//这里采用实际矩阵大小，如果需要取整，在代码里面完成
        super.new(name);
        File_Loc=File_Loc;
        Matrix = new[Matrix_Row *(Matrix_Col/8+1)];//向下取整加1即可
    endfunction

    function DumpData(int size,string path=File_Loc);
        int file_handle = $fopen(path, "w");  // 打开文件以供写入
        if (file_handle == 0) begin
            $display("Error opening the file!");
            $finish;
        end
    
        // 循环遍历数组，并将每个元素输出到文件
        for (int i = 0; i < size; i = i + 1) begin
            $fwrite(file_handle, "Matrix[%d] = %h\n", i, Matrix[i]);
        end
        $fclose(file_handle);  // 关闭文件
    endfunction

    function printhhh();
        $display("getting in compare now");
    endfunction
    function bit Mycompare(SoftMax_Transaction_Out to_Compare);
        bit result=1;
        $display("getting in compare now");
        $display("getting in compare now");
        $display("getting in compare now");
        $display("getting in compare now");
        $display("getting in compare now");
        $display("getting in compare now");
        $display("getting in compare now");
        for (int i=0;i<Matrix_Row*(Matrix_Col/8+1);i=i+1)begin
            if(Matrix[i]==to_Compare.Matrix[i])begin
                // $display("[%d]  success ful",i);
                // `uvm_info("transaction", "Compare Successful", UVM_LOW);
            end
            else begin
                result=0;
                $display("error [%d] %h---%h",i,Matrix[i],to_Compare.Matrix[i]);
                // `uvm_info("transaction", "Compare error", UVM_LOW);
            end
        end
        return result;
    endfunction
endclass
`endif
