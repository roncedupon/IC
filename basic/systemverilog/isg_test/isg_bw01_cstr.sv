//----------------------------------------------------------- 
//Filename : release/instruction_v1.5.json
//Date     : 2025-02-17 07:43:13
//----------------------------------------------------------- 
class inference_instr_trans ;
rand bit [47:0]     dscarrayctrl        ;//bit[383:336]     
rand bit [0:0]      pgagainctrl         ;//bit[335:335]     
rand bit [0:0]      cellsum             ;//bit[334:334]     
rand bit [0:0]      bypass              ;//bit[320:320]     
rand bit [5:0]      prescale_n          ;//bit[269:264]     
rand bit [5:0]      prescale_p          ;//bit[261:256]     
rand bit [0:0]      biasdisable_n       ;//bit[248:248]     
rand bit [7:0]      biasvalue_n         ;//bit[247:240]     
rand bit [4:0]      be_n                ;//bit[236:232]     
rand bit [4:0]      bs_n                ;//bit[228:224]     
rand bit [0:0]      biasdisable_p       ;//bit[216:216]     
rand bit [7:0]      biasvalue_p         ;//bit[215:208]     
rand bit [4:0]      be_p                ;//bit[204:200]     
rand bit [4:0]      bs_p                ;//bit[196:192]     
rand bit [1:0]      arraysel            ;//bit[191:190]     
rand bit [1:0]      nssel               ;//bit[161:160]     
rand bit [11:0]     ye                  ;//bit[155:144]     
rand bit [11:0]     ys                  ;//bit[139:128]     
rand bit [14:0]     ototalsize          ;//bit[126:112]     
rand bit [13:0]     istepsize           ;//bit[109:96]      
rand bit [3:0]      infermode           ;//bit[95:92]       
rand bit [1:0]      ext                 ;//bit[89:88]       
rand bit [1:0]      barrierid           ;//bit[87:86]       
rand bit [0:0]      barrieren           ;//bit[85:85]       
rand bit [0:0]      intren              ;//bit[84:84]       
rand bit [11:0]     instrid             ;//bit[83:72]       
rand bit [7:0]      opcode              ;//bit[71:64]       
rand bit [13:0]     packetsize          ;//bit[45:32]       
rand bit [3:0]      l0logicid           ;//bit[27:24]       
rand bit [23:0]     taskid              ;//bit[23:0]        

rand bit [1023:0]   header              ;//all header       
rand bit [1023:0]   payload[]           ;//all payload      

constraint header_assign{ 
    header[383:336]    ==        dscarrayctrl;       
    header[335:335]    ==        pgagainctrl;        
    header[334:334]    ==        cellsum;            
    header[320:320]    ==        bypass;             
    header[269:264]    ==        prescale_n;         
    header[261:256]    ==        prescale_p;         
    header[248:248]    ==        biasdisable_n;      
    header[247:240]    ==        biasvalue_n;        
    header[236:232]    ==        be_n;               
    header[228:224]    ==        bs_n;               
    header[216:216]    ==        biasdisable_p;      
    header[215:208]    ==        biasvalue_p;        
    header[204:200]    ==        be_p;               
    header[196:192]    ==        bs_p;               
    header[191:190]    ==        arraysel;           
    header[161:160]    ==        nssel;              
    header[155:144]    ==        ye;                 
    header[139:128]    ==        ys;                 
    header[126:112]    ==        ototalsize;         
    header[109:96]     ==        istepsize;          
    header[95:92]      ==        infermode;          
    header[89:88]      ==        ext;                
    header[87:86]      ==        barrierid;          
    header[85:85]      ==        barrieren;          
    header[84:84]      ==        intren;             
    header[83:72]      ==        instrid;            
    header[71:64]      ==        opcode;             
    header[45:32]      ==        packetsize;         
    header[27:24]      ==        l0logicid;          
    header[23:0]       ==        taskid;             

// packetsize指定infer/calib指令中payLoad大小,payLoad中包含写入dac的数据,与ys/ye配置有关;复用时等于
    packetsize inside {0, ye - ys + 1};
    // opcode= 0x10/0x11 infer/calib
    opcode inside {8'h10, 8'h11};
    // infermode指定流水模式,从三种中选择一种
    infermode inside {4'd0, 4'd1, 4'd2};
    // istepsize用于前后指令中复用payLoad,只能全部复用或不复用,即配置为0或等于packetsize
    istepsize inside {0, packetsize};
    // ototalsize指定输出数据量,与xs/xe配置有关
    // ototalsize == xe - xs + 1;
    // 8 <= ys/ye <= 3327; ys <= ye;
    ys <= ye;
    ys inside {[0:3327]};
    ye inside {[0:3327]};
    // 8 <= xs/xe <= 3327; xs <= xe;
    // xs <= xe;
    // xs inside {[0:3327]};
    // xe inside {[0:3327]};
    // infer模式固定2'b11
    arraysel == 2'b11;
    // bs_p/bs_n = 8~30; be_p/be_n = 0~30; be_p/be_n >= bs_p/bs_n
    bs_p inside {[0:30]};
    be_p inside {[0:30]};
    bs_n inside {[0:30]};
    be_n inside {[0:30]};
    be_p >= bs_p;
    be_n >= bs_n;
    // biasdisable = 1时 biasvalue = 0,其余情况随机值
    (biasdisable_p == 1) -> (biasvalue_p == 0);
    (biasdisable_n == 1) -> (biasvalue_n == 0);
    // prescale指定dac数据乘系数大小,可配置为3'b000/3'b100/3'b110/3'b111
    prescale_n inside {3'b000, 3'b100, 3'b110, 3'b111};
    prescale_p inside {3'b000, 3'b100, 3'b110, 3'b111};
    // cellsum = 0/1
    cellsum inside {0, 1};    
}; //header_assign

function void display();
    $display("inference field dscarrayctrl value = %x"         ,dscarrayctrl       );        
    $display("inference field pgagainctrl value = %x"          ,pgagainctrl        );        
    $display("inference field cellsum value = %x"              ,cellsum            );        
    $display("inference field bypass value = %x"               ,bypass             );        
    $display("inference field prescale_n value = %x"           ,prescale_n         );        
    $display("inference field prescale_p value = %x"           ,prescale_p         );        
    $display("inference field biasdisable_n value = %x"        ,biasdisable_n      );        
    $display("inference field biasvalue_n value = %x"          ,biasvalue_n        );        
    $display("inference field be_n value = %x"                 ,be_n               );        
    $display("inference field bs_n value = %x"                 ,bs_n               );        
    $display("inference field biasdisable_p value = %x"        ,biasdisable_p      );        
    $display("inference field biasvalue_p value = %x"          ,biasvalue_p        );        
    $display("inference field be_p value = %x"                 ,be_p               );        
    $display("inference field bs_p value = %x"                 ,bs_p               );        
    $display("inference field arraysel value = %x"             ,arraysel           );        
    $display("inference field nssel value = %x"                ,nssel              );        
    $display("inference field ye value = %x"                   ,ye                 );        
    $display("inference field ys value = %x"                   ,ys                 );        
    $display("inference field ototalsize value = %x"           ,ototalsize         );        
    $display("inference field istepsize value = %x"            ,istepsize          );        
    $display("inference field infermode value = %x"            ,infermode          );        
    $display("inference field ext value = %x"                  ,ext                );        
    $display("inference field barrierid value = %x"            ,barrierid          );        
    $display("inference field barrieren value = %x"            ,barrieren          );        
    $display("inference field intren value = %x"               ,intren             );        
    $display("inference field instrid value = %x"              ,instrid            );        
    $display("inference field opcode value = %x"               ,opcode             );        
    $display("inference field packetsize value = %x"           ,packetsize         );        
    $display("inference field l0logicid value = %x"            ,l0logicid          );        
    $display("inference field taskid value = %x"               ,taskid             );        
endfunction

endclass
