//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_cfg_block.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
//----------------------------
// PCIe Config Block
//----------------------------
class pcie_cfg_block extends uvm_reg_block;
  rand pcie_vendor_id_reg vendor_id_reg;
  rand pcie_device_id_reg device_id_reg;
  rand pcie_command_reg   command_reg;

  `uvm_object_utils(pcie_cfg_block)

  function new(string name="pcie_cfg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    // Create address map: (name, base_addr, n_bytes, endian, byte_addressing)
    default_map = create_map("default_map", 'h0, 4, UVM_LITTLE_ENDIAN, 1);

    // Vendor ID
    vendor_id_reg = pcie_vendor_id_reg::type_id::create("vendor_id_reg");
    vendor_id_reg.build();
    vendor_id_reg.configure(this);  
    default_map.add_reg(vendor_id_reg, 'h00, "RO");

    // Device ID
    device_id_reg = pcie_device_id_reg::type_id::create("device_id_reg");
    device_id_reg.build();
    device_id_reg.configure(this);
    default_map.add_reg(device_id_reg, 'h02, "RO");

    // Command
    command_reg = pcie_command_reg::type_id::create("command_reg");
    command_reg.build();
    command_reg.configure(this);
    default_map.add_reg(command_reg, 'h04, "RW");

  endfunction
endclass : pcie_cfg_block

