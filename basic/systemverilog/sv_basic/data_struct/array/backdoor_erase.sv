//前门接收到信号后，根据给的行标从后门修改mem一行的数据
typedef string PATH_OF_ARRAY[$];
function int rowAddr_mapper(int phy_row_addr);//input phy addr,return logic addr
    assert (phy_row_addr>=1 && phy_row_addr<=8200 || phy_row_addr>=8203&&phy_row_addr<=8203+64) else $fatal($sformatf("Invalid phy_row_addr: %0d is out of range.", phy_row_addr));
    //1~8200-->weight | 8203~8203+64 --> bias
    if (phy_row_addr >= 1 && phy_row_addr <= 8200)
        return phy_row_addr/4;//Round down
    else if (phy_row_addr >= 8203 && phy_row_addr <= (8203 + 64))
        return phy_row_addr/4;//Round down
    else
        return -1;
endfunction

// function bit ns_select(int logic_row_addr);//1-->n 0-->s
//     return logic_row_addr[0];//even -->south  odd --> north
// endfunction

// function PATH_OF_ARRAY array_select(int l0_id,int phy_row_addr);
//     string NS="N";
//     PATH_OF_ARRAY path_list;
//     if (!ns_select(rowAddr_mapper(phy_row_addr))) begin
//         NS = "S";
//     end
//     //construct array memory path and push them back into queue
//     path_list.push_back($sformatf("`NW_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
//     path_list.push_back($sformatf("`NE_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
//     path_list.push_back($sformatf("`SW_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
//     path_list.push_back($sformatf("`SE_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
//     return path_list;    
// endfunction


function automatic void erase_array(int phy_row_addr,int ph,int ns,int l0_id=0);// automatic is important
    PATH_OF_ARRAY path_list;
    string NS="N";
    int NS_int=1;
    int row_addr;
    row_addr=rowAddr_mapper(phy_row_addr);
    $display("logic row_addr %0d |ph %0d |ns %0d |l0_id %0d",row_addr,ph,ns,l0_id);
    $display("[DEBUG] NS = \"%s\"", NS);
    $display("[DEBUG] NS = \"%d\"", NS_int);
    if (!ns) begin
        NS = "S";
        NS_int=0;
    end    
    $display("[DEBUG] NS = \"%s\"", NS);
    $display("[DEBUG] NS = \"%d\"", NS_int);
    // assert(ns==ns_select(row_addr)) else $fatal($sformatf("[NS SELECT ERROR]phy row_addr=%0d dosen't match N/S select!!!",phy_row_addr));
    if (ph) begin
        $error("[Function Not Implemented] Erase operation for PH area is not implemented!!!!");
    end
    else begin
        if(NS=="N")begin
            $display("starting erase N area");
            `NW_ARRAY_INNER_TRUNK_N_PATH(l0_id)[row_addr]={2112{8'h01}};
            `NE_ARRAY_INNER_TRUNK_N_PATH(l0_id)[row_addr]={2112{8'h01}};
            `SW_ARRAY_INNER_TRUNK_N_PATH(l0_id)[row_addr]={2112{8'h01}};
            `SE_ARRAY_INNER_TRUNK_N_PATH(l0_id)[row_addr]={2112{8'h01}};
        end
        else begin
            $display("starting erase S area");
            `NW_ARRAY_INNER_TRUNK_S_PATH(l0_id)[row_addr]={{2112{8'h01}}};
            `NE_ARRAY_INNER_TRUNK_S_PATH(l0_id)[row_addr]={{2112{8'h01}}};
            `SW_ARRAY_INNER_TRUNK_S_PATH(l0_id)[row_addr]={{2112{8'h01}}};
            `SE_ARRAY_INNER_TRUNK_S_PATH(l0_id)[row_addr]={{2112{8'h01}}};        
        end
    end
endfunction
