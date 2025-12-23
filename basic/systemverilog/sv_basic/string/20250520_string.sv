task func(input string str="asds");
    $display(str);//这样打印也行
endtask
module top;
    string aaa="1234";
    initial begin
        $display("%s",{aaa,{"ddddsada"}});
        func(.str({aaa,{"ddddsada"}}));
    end
endmodule