`timescale 1ns/1ps

module width_demo;

  // 原始信号
  bit [31:0] data;
  typedef bit [96:0] token_hash_t;//exp: token_hash_t hash={instruction_index, group0_ost_id, group1_ost_id,nsu_addr};

  
  initial begin
    string str;
    token_hash_t token;
    token='h2048;
    str=$sformatf({"----\n",
        "aaa=%x \n",
        "bbb=%x \n",
    "-----"},123,456);//这里不加大括号会乱码
    $display("%s",str);
    $display($sformatf("%0x",token));
    $finish;
  end
  
endmodule