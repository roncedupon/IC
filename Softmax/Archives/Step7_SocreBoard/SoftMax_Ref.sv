`ifndef SOFTMAX_REF
`define SOFTMAX_REF
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "SoftMax_Transaction.sv"
`include "SoftMax_Transaction_Out.sv"
//这里的参考模型主要是从agent获取输入和输出，然后根据输入处理得到标准输出
class SoftMax_Ref extends uvm_component;
    uvm_blocking_get_port#(SoftMax_Transaction_Out)port;
    uvm_analysis_port#(SoftMax_Transaction_Out) ap;
    int Matrix_Row;
    int Matrix_Col;
    extern function new(string name,uvm_component parent,int Matrix_Row_p=197,int Matrix_Col_p=197);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(SoftMax_Ref);
endclass

function SoftMax_Ref::new(string name,uvm_component parent,int Matrix_Row_p=197,int Matrix_Col_p=197);
    super.new(name,parent);
    Matrix_Row=Matrix_Row_p;
    Matrix_Col=Matrix_Col_p;
endfunction

function void SoftMax_Ref::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port=new("port",this);
    ap=new("ap",this);
endfunction

task SoftMax_Ref::main_phase(uvm_phase phase);
    bit signed[7:0] Max;
    
    SoftMax_Transaction_Out SoftMax_Input;//获取到SoftMax的输入
    SoftMax_Transaction_Out SoftMax_Std_Output;//在Reference Model中对SoftMax_Input进行处理,得到一个标准的输出,将来这个标准输出用于在Score中和oagent的输出进行对比
    super.main_phase(phase);
    `uvm_info("Ref Main phase","launch Reg main phase",UVM_LOW);
    
    while(1)begin
        port.get(SoftMax_Input);//这个是从iagent中的monitor中获取输入数据
        // $display("%h",SoftMax_Input.Matrix[0]);
        // $display("%h",SoftMax_Input.Matrix[0]);
        // $display("%h",SoftMax_Input.Matrix[0]);
        // $display("%h",SoftMax_Input.Matrix[0]);
        // $display("%h",SoftMax_Input.Matrix[0]);
        SoftMax_Std_Output=new("SoftMax_Std_Output");//这个是对输入数据进行处理后的标准输出
        if(SoftMax_Input==null)`uvm_fatal("SoftMax_Ref","SoftMax_Input is null !!!")

        // for(int i=0;i<1024;i=i+1)
        //     $display("%h",SoftMax_Input.Matrix[i]);


        for(int i=0;i<Matrix_Row;i=i+1)begin//遍历行
            $display("==========================[%d]===============================",i);
            Max=0;
            //先遍历列找最大值
            for(int j=0;j<Matrix_Col/8+1;j=j+1)begin
                for(int k=0;k<8;k=k+1)begin
                    if(Max<$signed(SoftMax_Input.Matrix[i*(Matrix_Col/8+1)+j][k*8+:8]))
                        Max=SoftMax_Input.Matrix[i*(Matrix_Col/8+1)+j][k*8+:8];
                end
                $display("%h Max is %h",SoftMax_Input.Matrix[i*(Matrix_Col/8+1)+j],Max);
            end

            //找完最大值后,再一次遍历列减去最大值
            for(int j=0;j<Matrix_Col/8+1;j=j+1)begin
                for(int k=0;k<8;k=k+1)begin
                    SoftMax_Std_Output.Matrix[i*(Matrix_Col/8+1)+j][8*k+:8]=$signed(SoftMax_Input.Matrix[i*(Matrix_Col/8+1)+j][8*k+:8])-Max;
                    // $display("%h",SoftMax_Std_Output.Matrix[i]);
                end
                
            end
        end
        // $display("%d   %d",Matrix_Row,Matrix_Col);
        // $display("%d   %d",Matrix_Row,Matrix_Col);
        // $display("%d   %d",Matrix_Row,Matrix_Col);
        // $display("%d   %d",Matrix_Row,Matrix_Col);
        // $display("%h",SoftMax_Std_Output.Matrix[0]);
        // $display("%h",SoftMax_Std_Output.Matrix[1]);
        // $display("%h",SoftMax_Std_Output.Matrix[2]);
        // $display("%h",SoftMax_Std_Output.Matrix[3]);
        // $display("%h",SoftMax_Std_Output.Matrix[4]);
        ap.write(SoftMax_Std_Output);
    end
    
endtask
`endif
