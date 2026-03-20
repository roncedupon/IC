`timescale 1ns/1ps

module width_demo;

  // 原始信号
  bit [31:0] data;

  
  initial begin
    string str;
    str=$sformatf({"----\n",
        "aaa=%x \n",
        "bbb=%x \n",
    "-----"},123,456);//这里不加大括号会乱码
    $display("%s",str);

    $finish;
  end
  
endmodule