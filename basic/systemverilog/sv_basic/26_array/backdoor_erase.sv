//前门接收到信号后，根据给的行标从后门修改mem一行的数据
typedef string PATH_OF_ARRAY[$];
function int rowAddr_mapper(int phy_row_addr);//input phy addr,return logic addr
    assert (phy_row_addr>=1 && phy_row_addr<=8200 || phy_row_addr>=8203&&phy_row_addr<=8203+64) else $fatal("Invalid phy_row_addr: %0d is out of range.", phy_row_addr);

    if (phy_row_addr >= 1 && phy_row_addr <= 8200)
        return phy_row_addr/4;//Round down
    else if (phy_row_addr >= 8203 && phy_row_addr <= (8203 + 64))
        return phy_row_addr/4;//Round down
    else
        return -1;
endfunction

function bit ns_select(int logic_row_addr);//1-->n 0-->s
    return logic_row_addr[0];//even -->south  odd --> north
endfunction

function PATH_OF_ARRAY array_select(int l0_id,int phy_row_addr);
    string NS="N";
    PATH_OF_ARRAY path_list;
    if (!ns_select(rowAddr_mapper(phy_row_addr))) begin
        NS = "S";
    end
    //construct array memory path and push them back into queue
    path_list.push_back($sformatf("`NW_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
    path_list.push_back($sformatf("`NE_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
    path_list.push_back($sformatf("`SW_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
    path_list.push_back($sformatf("`SE_ARRAY_INNER_TRUNK_%s_PATH(%0d)", NS, l0_id));
    return path_list;    
endfunction


function void erase_array(int row_addr,int ph,int ns,int l0_id=0);
    PATH_OF_ARRAY path_list=array_select(l0_id,row_addr);
    assert(ns==ns_select(row_addr)) else $fatal($sformatf("[NS SELECT ERROR]phy row_addr=%0d dosen't match N/S select!!!",row_addr));
    if (ph) begin
        $fatal("[Function Not Implemented] Erase operation for PH area is not implemented!!!!");
    end
    else begin
        foreach(path_list[i])begin
            path_list[i][row_addr]='h0;
        end        
    end
endfunction
