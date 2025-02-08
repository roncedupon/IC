
`include "ahb_base_test.sv"
`include "ahb_null_virtual_sequence.sv"
`include "amba_pv_master.sv"
`include "amba_pv_slave.sv"

/**
 * Abstract:
 * This file creates test 'amba_pv_test', which is extended from the
 * base test class. This test uses AMBA-PV-extended UVM TLM Generic Payload
 * transactions to drive transactions through the AMBA-PV socket on the
 * master agent.
 * 
 * To enable this use_pv_socket must be set in the port configuration
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Create a component emulating a AMBA-PV master model
 *  - Disable the virtual sequence by assigning the null sequence
 *  - Configure axi_slave_random_response_sequence as the default sequence
 *    for the run phase of the Slave Sequencer
 *  .
 */
class amba_pv_test extends ahb_base_test;
  /** Fake AMBA-PV slave */
  amba_pv_slave pv_slave;
  /** UVM Component Utility macro */
  `uvm_component_utils (amba_pv_test)

  /** Class Constructor */
  function new (string name="amba_pv_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction : new

  virtual function void test_cfg(cust_svt_ahb_system_configuration cfg);
    cfg.master_cfg[0].use_pv_socket = 1;
    cfg.slave_cfg[0].use_pv_socket = 1;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    string mem_name;
    svt_mem slave_mem;
    `uvm_info ("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);
    mem_name = $sformatf("slave_mem[%0d]",this.cfg.slave_cfg[0].port_id);
    slave_mem = new(mem_name,
                    "AMBA3",
                    8,
                    0,
                    0,
                    ((1<<this.cfg.slave_cfg[0].addr_width)-1));
    /** Apply the null sequence to the System ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.sequencer.main_phase", "default_sequence", ahb_null_virtual_sequence::type_id::get());
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.slave*.sequencer.run_phase", "default_sequence", svt_ahb_slave_tlm_response_sequence::type_id::get());
    
    pv_slave = amba_pv_slave::type_id::create("pv_slave", this);
    pv_slave.slave_mem = slave_mem;

    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info ("connect_phase", "Entered...", UVM_LOW)
    env.ahb_system_env.slave[0].resp_socket.connect(pv_slave.b_resp);
    `uvm_info ("connect_phase", "Exiting...",UVM_LOW)
  endfunction: connect_phase

  task main_phase(uvm_phase phase);

    uvm_tlm_gp wr, rd;
    svt_amba_pv_extension pv = new;
    uvm_tlm_time delay = new();
    int unsigned len, siz;
    
    super.main_phase(phase);

    phase.raise_objection(this);

    repeat (20) begin
      wr = new;

      void'(std::randomize(len, siz) with {
                                     len inside {[1:3]};
                                     siz inside {1, 2, 4, 8, 16, 32, 64, 128};
                                     siz <= cfg.master_cfg[0].data_width / 8;
                                     });
      pv.set_length(len);
      pv.set_size(siz);
      pv.set_burst(svt_amba_pv::INCR);

      void'(wr.randomize() with {m_length             == pv.get_length() * pv.get_size();
                           m_data.size()        == m_length;
                           m_byte_enable_length == 0;
                           m_byte_enable.size() == m_byte_enable_length;
                           foreach (m_byte_enable[i]) { m_byte_enable[i] == 8'hFF; }
                           m_streaming_width    == m_length;
                           m_command            == UVM_TLM_WRITE_COMMAND;
                           m_address             < 1 << cfg.master_cfg[0].addr_width;
                           m_address             < 'h500 - m_length; // From cust_svt_ahb_master_transaction
                           m_address[9:0] dist { 10'h3FF:=50, [0:10'h3FE]:=50};
                           });
      // 75% mis-alignment
      if (siz > 2) begin
        wr.m_address[9:0] = wr.m_address[9:0] & ~((1<<(siz-2))-1);
      end
      
      void'(wr.set_extension(pv));
      
      wr.m_response_status = UVM_TLM_OK_RESPONSE;
      
      `uvm_info("body", $sformatf("Executing AMBA-PV WRITE:\n%s", wr.sprint()), UVM_LOW);
      env.pv_master[0].b_fwd.b_transport(wr, delay);
      `uvm_info("body", $sformatf("Completed AMBA-PV WRITE:\n%s", wr.sprint()), UVM_LOW);

      if (wr.m_response_status != UVM_TLM_OK_RESPONSE) begin
        `uvm_error("body", "The WRITE transaction did not complete with an OK response");
        continue;
      end
      
      rd = new;
      void'(rd.randomize() with {m_length             == wr.m_length;
                           m_data.size()        == m_length;
                           m_streaming_width    == m_length;
                           m_byte_enable_length == wr.m_byte_enable_length;
                           m_byte_enable.size() == m_byte_enable_length;
                           foreach (m_byte_enable[i]) { m_byte_enable[i] == wr.m_byte_enable[i]; }
                           m_command            == UVM_TLM_READ_COMMAND;
                           m_response_status    == UVM_TLM_INCOMPLETE_RESPONSE;
                           m_address            == wr.m_address;
                           });
      pv.reset();
      
      // Use a different read burst pattern 50% of the time
      if (siz > 2 && rd.m_address[5]) begin
        siz = siz / 2;
        len = len * 2;
      end
      pv.set_length(len);
      pv.set_size(siz);
      pv.set_burst(svt_amba_pv::INCR);
      void'(rd.set_extension(pv));
      
      `uvm_info("body", $sformatf("Executing AMBA-PV READ:\n%s", rd.sprint()), UVM_LOW);
      env.pv_master[0].b_fwd.b_transport(rd, delay);
      `uvm_info("body", $sformatf("Completed AMBA-PV READ:\n%s", rd.sprint()), UVM_LOW);
      
      if (rd.m_response_status != UVM_TLM_OK_RESPONSE) begin
        `uvm_error("body", "The READ transaction did not complete with an OK response");
        continue;
      end
      
      begin
        int be = 0;
        foreach (wr.m_data[j]) begin
          if (wr.m_byte_enable_length == 0 || wr.m_byte_enable[be]) begin
            if (wr.m_data[j] != rd.m_data[j]) begin
              `uvm_error("body", $sformatf("m_data[%0d] does not match between WRITE (0x%h) and READ (0x%h) transactions",
                                           j,wr.m_data[j],rd.m_data[j])); 
            end
          end
          if (wr.m_byte_enable_length > 0) be = (be + 1) % wr.m_byte_enable_length;
        end
      end
    end
    
    phase.drop_objection(this);
    
  endtask
endclass
