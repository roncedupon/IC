
/**
 * Abstract:
 * "Fake" AMBA-PV slave component that can be used to drive AMBA-PV-extended
 * Generic Payload TLM transactions to the slave master agent.
 * Normally, this component would be an ARM Fast Model or an AMBA-PV bridge
 * component. This allows an AMBA-PV TLM model to access a RTL AMBA subsystem
 * model via the slave agent VIP.
 * NOTE: For Read transaction, the AMBA-PV Slave returns data value as '0' and this is a known limitation
 */
`ifndef GUARD_AMBA_PV_SLAVE_SV
`define GUARD_AMBA_PV_SLAVE_SV

class amba_pv_slave extends uvm_component;

  /** UVM Component Utility macro */
  `uvm_component_utils(amba_pv_slave)

  /** Backward snoop transaction transport interface */
  uvm_tlm_b_target_socket#(amba_pv_slave, uvm_tlm_generic_payload) b_resp;

  svt_mem slave_mem;

  /** Class Constructor */
  function new(string name = "amba_pv_slave", uvm_component parent=null);
    super.new(name,parent);

    b_resp = new("b_resp", this);
  endfunction: new

  /**
   * Build Phase
   * - Create and apply the customized configuration transaction factory
   * - Create the TB ENV
   * - Set the default sequences
   */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);
    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  /**
   * Implementation of the backward path
   * 
   * Fullfill slave request using a memory model
   */
  task b_transport(uvm_tlm_generic_payload gp,
                   uvm_tlm_time            delay);
    
    if (gp.m_command == UVM_TLM_WRITE_COMMAND) begin
      foreach (gp.m_data[i]) begin
        bit _wstrb;
        if (gp.m_byte_enable[i] == 1'b1)
          _wstrb = 1;
        else
          _wstrb = 0;
        void'(slave_mem.write((gp.m_address+i),gp.m_data[i],_wstrb));
        `svt_xvm_debug("body", $sformatf("for write command gp.m_data[%0d]=%0h\n", i, gp.m_data[i]));
      end
    end
    else begin
      for (int i = 0; i < gp.m_length; i++) begin
        bit[7:0] _data = slave_mem.read(gp.m_address+i);
        gp.m_data[i] = _data;
        `svt_xvm_debug("body", $sformatf("for read command gp.m_data[%0d]=%0h\n", i, gp.m_data[i]));
      end
    end
    gp.m_response_status = UVM_TLM_OK_RESPONSE;
    `svt_xvm_debug("body", $sformatf("TLM SLV RESPONSE:\n%s", gp.sprint()));
    
  endtask

endclass

`endif // GUARD_AMBA_PV_SLAVE_SV
