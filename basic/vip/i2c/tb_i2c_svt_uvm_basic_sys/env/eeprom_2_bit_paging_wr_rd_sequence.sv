

`ifndef GUARD_EEPROM_2_BIT_PAGING_WR_RD_SEQUENCE_SV
`define GUARD_EEPROM_2_BIT_PAGING_WR_RD_SEQUENCE_SV

/** 
 * Abstract:
 * This class is used by the testbench to provide master 
 * transaction sequence for EEPROM Slave ; which is initiated on the default 
 * virtual sequence through the virtual sequencer.<br/>
 * .
 */

class eeprom_2_bit_paging_wr_rd_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

  /* UVM object utility macro */
  `uvm_object_utils(eeprom_2_bit_paging_wr_rd_sequence)

  /* Object used to hold exceptions for a
   This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  /* I2C configuration obtained from the sequencer */
  svt_i2c_configuration i2c_cfg;
   
 bit [7:0]eeprom_mem_wr[8][65535:0] ;//memory to store write data
 int temp_loc;                       //variable to store eeprom pointer
 bit [7:0]eeprom_loc_lsb;  
 bit [7:0]eeprom_loc_msb;  
 int j;

  function new(string name="eeprom_2_bit_paging_wr_rd_sequence");
    super.new(name);
  for(int i =0 ; i <8 ; i++) begin
      for(int j = 0 ; j<65536; j++) begin
         eeprom_mem_wr[i][j] = 8'hAA;
       end
   end
  
  endfunction: new
 
  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase phase;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.raise_objection(this);
    end
  endtask: pre_body
  
  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    uvm_phase phase;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.drop_objection(this);
    end
  endtask: post_body
  /** Define task body() */
  virtual task body();

    /** SVT configuration handle */
    svt_configuration cfg;
    
    /** Get the SVT configuration */
    p_sequencer.get_cfg(cfg);

    /** Cast the SVT configuration handle on the local I2C configuration handle */
    if (!$cast(i2c_cfg, cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end



`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_000; //slave 0 page 0  -> eeprom_mem_wr[0][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 6;
                  req.data[0]         == 8'h00; // First byte of Starting Address
                  req.data[1]         == 8'ha8; // Second byte of Starting Address
                  req.data[2]         == 8'haa;  // Data Byte 0
                  req.data[3]         == 8'hbb;  // Data Byte 1
                  req.data[4]         == 8'hcc;  // Data Byte 2
                  req.data[5]         == 8'hdd;  // Data Byte 3
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[0][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end


    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

//Setting the EEPROM Memory Address to the location where read is supposed to
//happen (Dummy Write by Master).
//The dummy write contains 2 bytes of data, which represents address of
//EEPROM from where we need to start reading data bytes.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_000;  //slave 0 page 0 -> eeprom_mem_wr[0][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

 //READ command by Master to read 6 bytes data.

    `uvm_do( req,p_sequencer,-1,                { req.addr            == 10'b000_1010_000; //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })

    
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
        
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[0][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[0][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
        temp_loc++;
  end
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    //WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.

    `uvm_do( req,p_sequencer,-1,                { req.addr            == 10'b000_1010_000; //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 6;
                  req.data[0]         == 8'h00;   // First byte of Starting Address
                  req.data[1]         == 8'haa;   // Second byte of Starting Address
                  req.data[2]         == 8'h01;  // Data Byte 0
                  req.data[3]         == 8'h02;  // Data Byte 1
                  req.data[4]         == 8'h03;  // Data Byte 2
                  req.data[5]         == 8'h04;  // Data Byte 3
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[0][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end


    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

//Setting the EEPROM Memory Address to the location where read is supposed to
//happen (Dummy Write by Master).
//The dummy write contains 2 bytes of data, which represents address of
//EEPROM from where we need to start reading data bytes.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_000;  //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

 //READ command by Master to read 6 bytes data.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_000; //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })

    
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);


///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[0][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[0][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_001;   //slave 0 page 1 -> eeprom_mem_wr[1][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 4;
                  req.data[0]         inside {8'hff};  // First byte of Starting Address 
                  req.data[1]         inside {[8'hfc:8'hfd]};  // Second byte of Starting Address
                  req.data[2]         == 8'hde;  // Data Byte 0
                  req.data[3]         == 8'had;  // Data Byte 1
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[1][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_001; // slave 0 page 1 -> eeprom_mem_wr[1][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address 
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_001; //slave 0 page 1 -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[1][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[1][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
        temp_loc++;
  end
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_010; //slave 0 page 2 -> eeprom_mem_wr[2][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 5;
                  req.data[0]         inside {[8'h00:8'hff]};  // First byte of Starting Address 
                  req.data[1]         inside {[8'h00:8'hff]};  // Second byte of Starting Address
                  req.data[2]         == 8'hab;  // Data Byte 0
                  req.data[3]         == 8'hcd;  // Data Byte 1
                  req.data[4]         == 8'h12;  // Data Byte 2
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[2][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.
`uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_010;  //slave 0 page 2 -> eeprom_mem_wr[2][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do( req,p_sequencer,-1,                { req.addr            == 10'b000_1010_010;  //slave 0 page 2 -> eeprom_mem_wr[2][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
   
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[2][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[2][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end 


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do( req,p_sequencer,-1,                { req.addr            == 10'b000_1010_011;   //slave 0 page 3 -> eeprom_mem_wr[3][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 4;
                  req.data[0]         inside {[8'h00:8'hff]};  // First byte of Starting Address 
                  req.data[1]         inside {[8'h00:8'hff]};  // Second byte of Starting Address
                  req.data[2]         == 8'h00;  // Data Byte 0
                  req.data[3]         == 8'h11;  // Data Byte 1
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[3][temp_loc] =  req.data[a];
        if(temp_loc!=65535)
             temp_loc++;
        else
             temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.

    `uvm_do( req,p_sequencer,-1,                { req.addr            == 10'b000_1010_011;  //slave 0 page 3 -> eeprom_mem_wr[3][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_011; //slave 0 page 3 -> eeprom_mem_wr[3][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
    
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[3][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[3][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end 


//////////////////////////////////////////////////////////////////////////////////////////////////////



//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do( req,p_sequencer,-1,                { req.addr            == 10'b000_1010_001;   //slave 0 page 1 -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 7;
                  req.data[0]         inside {8'hff};  // First byte of Starting Address 
                  req.data[1]         inside {[8'hfa:8'hff]};  // Second byte of Starting Address
                  req.data[2]         == 8'h0a;  // Data Byte 0
                  req.data[3]         == 8'h0b;  // Data Byte 1
                  req.data[4]         == 8'h0c ; // Data Byte 1
                  req.data[5]         == 8'h0d;  // Data Byte 1
                  req.data[6]         == 8'h0e;  // Data Byte 1
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[1][temp_loc] =  req.data[a];
        if(temp_loc!=65535)
             temp_loc++;
        else
             temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_001; // slave 0 page 1 -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 16'h0000
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address 16'h0000
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do( req,p_sequencer,-1,
                { req.addr            == 10'b000_1010_001; //slave 0 page 1  -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
   
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[1][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[1][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`else
   //WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_000; //slave 0 page 0  -> eeprom_mem_wr[0][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 6;
                  req.data[0]         == 8'h00; // First byte of Starting Address
                  req.data[1]         == 8'ha8; // Second byte of Starting Address
                  req.data[2]         == 8'haa;  // Data Byte 0
                  req.data[3]         == 8'hbb;  // Data Byte 1
                  req.data[4]         == 8'hcc;  // Data Byte 2
                  req.data[5]         == 8'hdd;  // Data Byte 3
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[0][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end


    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

//Setting the EEPROM Memory Address to the location where read is supposed to
//happen (Dummy Write by Master).
//The dummy write contains 2 bytes of data, which represents address of
//EEPROM from where we need to start reading data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_000;  //slave 0 page 0 -> eeprom_mem_wr[0][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

 //READ command by Master to read 6 bytes data.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_000; //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })

    
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
        
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[0][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[0][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
        temp_loc++;
  end
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    //WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_000; //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 6;
                  req.data[0]         == 8'h00;   // First byte of Starting Address
                  req.data[1]         == 8'haa;   // Second byte of Starting Address
                  req.data[2]         == 8'h01;  // Data Byte 0
                  req.data[3]         == 8'h02;  // Data Byte 1
                  req.data[4]         == 8'h03;  // Data Byte 2
                  req.data[5]         == 8'h04;  // Data Byte 3
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[0][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end


    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

//Setting the EEPROM Memory Address to the location where read is supposed to
//happen (Dummy Write by Master).
//The dummy write contains 2 bytes of data, which represents address of
//EEPROM from where we need to start reading data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_000;  //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

 //READ command by Master to read 6 bytes data.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_000; //slave 0 page 0 -> eeprom_mem_wr[0][]

                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })

    
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);


///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[0][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[0][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do_with( req,
                { req.addr            == 10'b000_1010_001;   //slave 0 page 1 -> eeprom_mem_wr[1][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 4;
                  req.data[0]         inside {8'hff};  // First byte of Starting Address 
                  req.data[1]         inside {[8'hfc:8'hfd]};  // Second byte of Starting Address
                  req.data[2]         == 8'hde;  // Data Byte 0
                  req.data[3]         == 8'had;  // Data Byte 1
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[1][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_001; // slave 0 page 1 -> eeprom_mem_wr[1][]

                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address 
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_001; //slave 0 page 1 -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[1][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[1][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
        temp_loc++;
  end
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do_with( req,
                { req.addr            == 10'b000_1010_010; //slave 0 page 2 -> eeprom_mem_wr[2][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 5;
                  req.data[0]         inside {[8'h00:8'hff]};  // First byte of Starting Address 
                  req.data[1]         inside {[8'h00:8'hff]};  // Second byte of Starting Address
                  req.data[2]         == 8'hab;  // Data Byte 0
                  req.data[3]         == 8'hcd;  // Data Byte 1
                  req.data[4]         == 8'h12;  // Data Byte 2
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[2][temp_loc] =  req.data[a];
if(temp_loc!=65535)
     temp_loc++;
else
     temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_010;  //slave 0 page 2 -> eeprom_mem_wr[2][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_010;  //slave 0 page 2 -> eeprom_mem_wr[2][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
   
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[2][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[2][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end 


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do_with( req,
                { req.addr            == 10'b000_1010_011;   //slave 0 page 3 -> eeprom_mem_wr[3][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 4;
                  req.data[0]         inside {[8'h00:8'hff]};  // First byte of Starting Address 
                  req.data[1]         inside {[8'h00:8'hff]};  // Second byte of Starting Address
                  req.data[2]         == 8'h00;  // Data Byte 0
                  req.data[3]         == 8'h11;  // Data Byte 1
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[3][temp_loc] =  req.data[a];
        if(temp_loc!=65535)
             temp_loc++;
        else
             temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_011;  //slave 0 page 3 -> eeprom_mem_wr[3][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_011; //slave 0 page 3 -> eeprom_mem_wr[3][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
    
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[3][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[3][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end 


//////////////////////////////////////////////////////////////////////////////////////////////////////



//WRITE command by Master. First 2 bytes represents address of EEPROM from
    //where we need to start writing data bytes.
     `uvm_do_with( req,
                { req.addr            == 10'b000_1010_001;   //slave 0 page 1 -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 7;
                  req.data[0]         inside {8'hff};  // First byte of Starting Address 
                  req.data[1]         inside {[8'hfa:8'hff]};  // Second byte of Starting Address
                  req.data[2]         == 8'h0a;  // Data Byte 0
                  req.data[3]         == 8'h0b;  // Data Byte 1
                  req.data[4]         == 8'h0c ; // Data Byte 1
                  req.data[5]         == 8'h0d;  // Data Byte 1
                  req.data[6]         == 8'h0e;  // Data Byte 1
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    eeprom_loc_lsb = req.data[1];
    eeprom_loc_msb = req.data[0];
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
     for(int a = 2 ; a< req.data.size() ; a++)
       begin
        eeprom_mem_wr[1][temp_loc] =  req.data[a];
        if(temp_loc!=65535)
             temp_loc++;
        else
             temp_loc = 0;
       end
     /** 
     * Call get_response only if configuration attribute,
      * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //Setting the EEPROM Memory Address to the location where read is supposed to happen (Dummy Write by Master).
    //The dummy write contains 2 bytes of data, which represents address of
    //EEPROM from where we need to start reading data bytes.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_001; // slave 0 page 1 -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_WRITE;
                  req.data.size()     == 2;
                  req.data[0]         == eeprom_loc_msb;  // First byte of Starting Address 16'h0000
                  req.data[1]         == eeprom_loc_lsb;  // Second byte of Starting Address 16'h0000
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    temp_loc = {eeprom_loc_msb,eeprom_loc_lsb};
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    //READ command by Master to read 6 bytes data.

    `uvm_do_with( req,
                { req.addr            == 10'b000_1010_001; //slave 0 page 1  -> eeprom_mem_wr[1][]
                  req.cmd             == I2C_READ;
                  req.data.size()     == 6;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;
                })
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
   
///////////////////////////////////////////////data integrity check/////////////////////////////////////////////////////// 
for(int i = 0; i < rsp.data.size(); i++)
  begin
     if(eeprom_mem_wr[1][temp_loc] != rsp.data[i])
        `svt_error("slave 1010_000", $sformatf("Mismatch in Read Data & Write Data :: Write data at %h is %h , Read data at %h is %h",temp_loc,eeprom_mem_wr[1][temp_loc],temp_loc,rsp.data[i]));
     if(temp_loc== 65535)
        temp_loc = 0;
     else
     temp_loc++;
  end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`endif


  endtask: body

endclass: eeprom_2_bit_paging_wr_rd_sequence

`endif 
