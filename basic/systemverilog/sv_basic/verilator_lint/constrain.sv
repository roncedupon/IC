class V3_constraint;
    rand bit [15:0]SCKDV;
    constraint SCKDV_RANGE{
        SCKDV dist{
            [2:32]:=1,
            65534 :=1
        };
    }
    function new();
        //do nothing
    endfunction
    function void print();
        $display("SCKDV is %0d",SCKDV);
    endfunction
endclass

class V4_constraint;
    rand bit [15:0]SCKDV;
    constraint SCKDV_RANGE{
        SCKDV dist{
            [2:32]:=1,
            65534 :=1
        };
    }
    function new();
        //do nothing
    endfunction
    function void print();
        $display("SCKDV is %0d",SCKDV);
    endfunction
endclass