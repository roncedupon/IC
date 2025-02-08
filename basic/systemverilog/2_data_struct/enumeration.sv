module enuermution1;
    enum {RED,YELLOW,GREEN}e_light1;

    initial begin
        e_light1=GREEN;
        $display("=============beginning of %m===============");
        $display("e_light1 is %s=%0d",e_light1,e_light1);
    end
endmodule
module enuermution2;
    enum {e0,e1,e2,e3}e_nums;

    initial begin
        
        $display("=============beginning of %m===============");
        $display("e_nums.first() is %0d",e_nums.first());
        $display("e_nums.last() is  %0d",e_nums.last());
        $display("e_nums.next() is  %0d",e_nums.next(5));
        // $display("e_nums.next() is  %0d",e_nums.next(0));
        $display("e_nums.prev() is  %0d",e_nums.prev(5));//好像循环了
        $display("e_nums.num()) is  %0d",e_nums.num());
    end
endmodule
module enuermution3;
    //类型检查：只能给枚举类型赋值枚举列表里面的值，比如下面的e0，e1，e2或者e3
    //虽然e0就是0，但是直接赋值0是不行的
    typedef enum {e0,e1,e2,e3}e_nums;
    e_nums e;
    initial begin
        
        $display("=============beginning of %m===============");
        e=e_nums'(1);
    end
endmodule
// module enuermution4;
//     //类型检查：只能给枚举类型赋值枚举列表里面的值，比如下面的e0，e1，e2或者e3
//     //虽然e0就是0，但是直接赋值0是不行的
//     typedef enum {e0,e1,e2,e3}e_nums;
//     e_nums e;
//     initial begin
        
//         $display("=============beginning of %m===============");
//         // e_nums[e0]=123;
//         $display("%0d ",e_nums[e0]);
//     end
// endmodule