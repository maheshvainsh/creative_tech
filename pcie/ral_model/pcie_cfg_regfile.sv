//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_cfg_regfile.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
class pcie_cfg_regfile extends uvm_reg_file;
  `uvm_object_utils(pcie_cfg_regfile)

  pcie_vendor_id_reg  vendor_id;
  pcie_device_id_reg  device_id;
  pcie_command_reg    command;

  function new(string name="pcie_cfg_regfile");
    super.new(name);
  endfunction

  virtual function void build();
    // Create registers
    vendor_id = pcie_vendor_id_reg::type_id::create("vendor_id");
    device_id = pcie_device_id_reg::type_id::create("device_id");
    command   = pcie_command_reg::type_id::create("command");

    // Build them
    //vendor_id.build();
    //device_id.build();
    //command.build();
  endfunction
endclass
