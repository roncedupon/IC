`ifndef GURD_<CLASS_NAME>_SV
`define GURD_<CLASS_NAME>_SV

// uvm_driver template
class <CLASS_NAME> extends uvm_driver #(configuration_object); // Replace configuration_object with your config object type

  `uvm_component_utils(<CLASS_NAME>)

  // Define configuration object handle (replace configuration_object with your actual type)
  configuration_object  m_cfg;

  // Declare other class members like interface handle, etc.
  virtual interface vif; // Replace 'interface' with your actual interface type

  // Constructor
  function new(string name = "<CLASS_NAME>", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Configuration phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Get configuration object from uvm_config_db
    if (!uvm_config_db#(configuration_object)::get(this, "", "configuration_object", m_cfg)) // Replace "configuration_object" with your config object name
      `uvm_fatal("CONFIG_GET_FAILED", $sformatf("Failed to get configuration_object from uvm_config_db")) // Replace "configuration_object" with your config object name
    // Get interface handle from uvm_config_db
    if (!uvm_config_db#(virtual interface)::get(this, "", "vif", vif)) // Replace "interface" and "vif" with your actual interface type and name
      `uvm_fatal("CONFIG_GET_FAILED", $sformatf("Failed to get virtual interface vif from uvm_config_db")) // Replace "vif" with your actual interface name
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req); // req is typically declared as a transaction item
      drive_transfer(req);
      seq_item_port.item_done();
    end
  endtask

  // Drive transfer task (to be implemented)
  virtual task drive_transfer(configuration_object req); // Replace configuration_object with your transaction type
    `uvm_error("DRIVE_TRANSFER_NOT_IMPLEMENTED", "drive_transfer task is not implemented in this driver")
  endtask

endclass

`endif 