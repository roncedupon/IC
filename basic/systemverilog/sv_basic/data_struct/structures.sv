//浮点数
module example2_real;
//浮点数的表示以及打印方法
    real pi;
    real freq;

    initial begin
        pi=3.14;
        freq=1e6;
        $display("=============beginning of %m===============");
        $display("value of pi is %f",pi);
        $display("0.3f value of pi is %0.3f",pi);
        $display("value of freq is %0d",freq);
        
    end
endmodule

//结构体structure
module example2_structure;
    //structure 可以集成各种不同的数据类型
    typedef struct  {
        int data_int;//如果structue里没东西会报错
        logic [7:0]logic_data;
        real data_real;
    } struct_exp;

    //struct 初始化1--手动初始化
    struct_exp struct_exp1='{123,8'hab,3.14};

    //struct 初始化2--默认值初始化
    struct_exp struct_exp2='{default:0};

    //struct 初始化3--使用成员名称初始化
    // struct_exp struct_exp3='{data_int:123,logic_data:8'b1010_0101};//报错，因为初始化不全
    struct_exp struct_exp3='{data_int:123,logic_data:8'b1010_0101,default:0};//如果不想全写，那就用default进行剩下成员变量的初始化

    //struct 初始化4--根据变量名进行初始化
    struct_exp struct_exp4='{int:456,real:3.14,logic_data:'d255};

    //struct 初始化5--当然还可以在定义结构体的时候进行初始化
        //需要注意这里就没有typedef关键字了
    struct  {
        int data_int,data_int2,data_int3;//如果structue里没东西会报错
    }struct_exp2='{3{1}};
    initial begin
        $display("=============beginning of %m===============");
    end
    
endmodule




function int div_ceil(int A,int B);//除法向上取整
    // int result=0;
    return (A/B+(!(!(A%B))));//A/B向下取整，然后加上取模运算的Bool类型
endfunction