`ifndef SOFTMAX_FUNS
`define SOFTMAX_FUNS
package SoftMax_Funs;


    
    function int div_ceil(int A,int B);//除法向上取整
        // int result=0;
        return (A/B+(!(!(A%B))));//A/B向下取整，然后加上取模运算的Bool类型
    endfunction
endpackage
`endif 
