// //数组
// module example_Array;
//     //1.数组定义--以下两种定义类型一样
//     int myFifo1[0:7];
//     int myFifo2[8];//这种定义方法与C类似

//     //2.多维数组定义
//     int muldim_array1[0:7][0:3];
//     integer muldim_array2[8][4];
//     logic muldim_array3[8][4];
//     logic [1:0]muldim_array4[1:9]='{default:2'b11};//数组下标可以不必从0开始
//     //3.数组越界
//         //如果是四值逻辑，例如logic，则返回X
//         //如果是二值逻辑，例如bit,则返回0
//         //wire在无驱动时则返回Z
//         //注意int 是二值逻辑，integer则是四值逻辑，所以int数组越界，返回0，integer 越界返回X
//     initial begin
//         muldim_array1[0][1]=123;
//         $display("=============beginning of %m===============");
//         $display("[addr out of range test]: (int )muldim_array1[1024][1024] is %x",muldim_array1[1024][1024]);
//         $display("[addr out of range test]: (integer )muldim_array2[1024][1024] is %x",muldim_array2[1024][1024]);
//         $display("[addr out of range test]: (logic )muldim_array3[1024][1024] is %x",muldim_array3[1024][1024]);
//         $display("--------------------------------------------------------------------");
//         $display("[0] of logic [1:0]muldim_array4[1:9]='{default:2'b11}; is %d",muldim_array4[0]);//x
//         $display("[1] of logic [1:0]muldim_array4[1:9]='{default:2'b11}; is %d",muldim_array4[1]);//3
//         $display("size of logic [1:0]muldim_array4[1:9]='{default:2'b11}; is %d",$size(muldim_array4));//9
//     end
// //======================================================================================================================
//     //4.数组初始化

//     //手动初始化为常量数组
//     int initial_array1[4]='{0,1,2,3};
//     int initial_array2[8];
    
//     initial begin
//         //只使用其中的几位
//         initial_array2[0:3]='{1,2,3,4};
//         $display("--------------------------------------------------------------------");
//         //默认值
//         initial_array2='{default:123};//不知道为啥'{2,3,default:123} 这样设置缺省值不可用？？todo
//         for (int i=0;i<8;i=i+1)begin
//             $display("%d",initial_array2[i]);
//         end
//     end
// //======================================================================================================================
//     //5.更高维度的数组以及$size()的用法

//     //    2              1
//     bit[31:0] size_test1[0:9];

//     //   3     4              1    2
//     bit[31:0][7:0] size_test2[0:9][0:19];//数组维度定义：先看右边再看左边，优先级排列从左往右，可以通过$size确定顺序
//     initial begin
//         $display("$size(x) of bit[31:0] size_test1[0:9] is %d",$size(size_test1));//10
//         $display("$size(x,1) of bit[31:0] size_test1[0:9] is %d",$size(size_test1,2));//32
//         $display("--------------------------------------------------------------------");
//         $display("$size(x) of bit[31:0][7:0] size_test2[0:9][0:9] is %d",$size(size_test2));//10
//         $display("$size(x,1) of bit[31:0][7:0] size_test2[0:9][0:9] is %d",$size(size_test2,1));//10
//         $display("$size(x,2) of bit[31:0][7:0] size_test2[0:9][0:9] is %d",$size(size_test2,2));//20
//         $display("$size(x,3) of bit[31:0][7:0] size_test2[0:9][0:9] is %d",$size(size_test2,3));//32
//         $display("$size(x,4) of bit[31:0][7:0] size_test2[0:9][0:9] is %d",$size(size_test2,4));//8
//     end
// //======================================================================================================================    
//     //6.数组循环操作：foreach
//     int md[2][3];
//     initial begin
//         int num=0;
//         $display("--------------------------------------------------------------------");
//         for(int i=0;i<$size(md,1);i=i+1)begin
//             for(int j=0;j<$size(md,2);j=j+1)begin
//                 md[i][j]=num;
//                 num=num+1;
//             end
//         end

//         foreach (md[i,j]) begin
//             $display("md[%0d][%0d] is %0d",i,j,md[i][j]);
//         end
//     end
// //====================================================================================================================== 
//     //7.packed 数组-注意这里的遍历顺序是从高位到低位遍历！！！！！！！！！
//     bit[3:0][7:0]m_data;
    
//     initial begin
//         m_data=32'hface_cafe;
//         $display("--------------------------------------------------------------------");
//         foreach(m_data[i])begin
//             $display("m_data[%0d] is %02x",i,m_data[i]);
//         end
//     end

// endmodule

module example_Dynamic_Array1;
    initial begin
        $display("=============beginning of %m===============");
    end    
    int array[];
    initial begin
        array=new[5];
        array='{31,32,33,34,35};
        foreach(array[i])
            $display("array[%0d]=%0d",i,array[i]);
    end

    initial begin
        $display("before delete: array size is %d",array.size());
        array.delete();
        $display("after delete: array size is %d",array.size());
    end
    // before delete: array size is           5
    // after delete: array size is           0
endmodule
module example_Dynamic_Array2;
    initial begin
        $display("=============beginning of %m===============");
    end    
    int array[][];
    initial begin
        array=new[5];
        // array='{default:33};
        // foreach(array[i])
        //     $display("array[%0d]=%0d",i,array[i]);
        foreach(array[i])begin
            array[i]=new[6];
        end
        foreach(array[i,j])begin
            array[i]='{31,32,33,34,35,36};
            $display("%0d %0d",i,j);
        end
    end

    initial begin
        $display("before delete: array size is %d",array[0].size());
        array.delete();
        $display("after delete: array size is %d",array.size());
    end

endmodule
module example_Dynamic_Array3;
    initial begin
        $display("=============beginning of %m===============");
    end    
    int array[];
    int id[];
    initial begin
        array=new[5];
        array='{1,2,3,4,5};
        $display("before delete: array size is %d",array.size());

        id=array;
        id=new[id.size()+1](id);//扩容一个大小
        id[id.size()-1]=6;//将6存到刚刚扩容的空间里
    end

endmodule