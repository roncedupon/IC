//每次随机都与上一次不同
class random_permutation;
randc bit [2:0] numbers[7];  // randc 表示循环随机，自动不重复

function new();
  foreach(numbers[i]) numbers[i] = i;  // 初始化 0~9
endfunction
endclass

module test;
initial begin
  random_permutation rp = new();
  int count = 0;
  
  $display("Random permutation of 0-9:");
  repeat(10) begin
    assert(rp.randomize());
    $write("%0d ", rp.numbers[count]);
    count++;
  end
  $display("\n");
end
endmodule