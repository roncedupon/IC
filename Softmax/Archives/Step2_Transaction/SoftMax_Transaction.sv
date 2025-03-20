`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
class SoftMax_Transaction#(int Matrix_Row=197,int Matrix_Col=197) extends uvm_sequence_item;

    bit[63:0]Matrix[];
    string File_Loc="Softmax_tensors.txt";
    `uvm_object_utils(SoftMax_Transaction)//factory机制，注册
    //本次传输主要是传输一个矩阵，每个Transaction发送一个完整矩阵，矩阵的数据来源于pytorch生成的真实数据
    function new(string name="SoftMax_Transaction",string File_Loc="Softmax_tensors.txt");//这里采用实际矩阵大小，如果需要取整，在代码里面完成
        super.new(name);
        
        File_Loc=File_Loc;
        
        Matrix = new[Matrix_Row *(Matrix_Col/8+1)];//向下取整加1即可

        $readmemh(File_Loc,Matrix);
        // for(int i=0;i<4852;i=i+1)
        // `uvm_info("SoftMax", $sformatf("matrix[%d] value is %h",i, Matrix[i]),UVM_LOW);

    endfunction


endclass
