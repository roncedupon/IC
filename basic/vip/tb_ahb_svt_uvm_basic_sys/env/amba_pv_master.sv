
/**
 * Abstract:
 * "Fake" AMBA-PV master component that can be used to drive AMBA-PV-extended
 * Generic Payload TLM transactions to the AHB master agent.
 * Normally, this component would be an ARM faster model or an AMBA-PV bridge
 * component. This allows an AMBA-PV TLM model to access a RTL AMBA subsystem
 * model via the master agent VIP.
 */
`ifndef GUARD_AMBA_PV_MASTER_SV
`define GUARD_AMBA_PV_MASTER_SV

class amba_pv_master extends uvm_component;

  /** UVM Component Utility macro */
  `uvm_component_utils(amba_pv_master)

  /** Forward transport interface */
  uvm_tlm_b_initiator_socket#(uvm_tlm_generic_payload) b_fwd;

  /** Class Constructor */
  function new(string name = "amba_pv_master", uvm_component parent=null);
    super.new(name,parent);

    b_fwd   = new("b_fwd", this);
  endfunction: new

endclass

`endif // GUARD_AMBA_PV_MASTER_SV
