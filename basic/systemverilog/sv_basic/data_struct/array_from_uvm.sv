//在看uvm源码的时候看到一个这个玩意:  protected bit                  m_types[uvm_object_wrapper];
//怀疑他是一个字典，通过对uvm_object_wrapper的索引返回一个bit值
module top;

bit[1:0] test[string];
    initial begin
        test["123"]=2'b11;
        test["321"]=2'b10;
        $display("123:%0d",test["123"]);
        $display("321:%0d",test["321"]);
    end

endmodule