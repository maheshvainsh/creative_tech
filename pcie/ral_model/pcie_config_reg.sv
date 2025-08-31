// Vendor ID Register (offset 0x00)
class pcie_vendor_id_reg extends uvm_reg;
  rand uvm_reg_field vendor_id;

  `uvm_object_utils(pcie_vendor_id_reg)

  function new(string name="pcie_vendor_id_reg");
    super.new(name, 16, UVM_NO_COVERAGE); // 16-bit register
  endfunction

  virtual function void build();
    vendor_id = uvm_reg_field::type_id::create("vendor_id");
    vendor_id.configure(this, 16, 0, "RO", 0, 16'h1234, 1, 0, 1);
  endfunction
endclass


// Device ID Register (offset 0x02)
class pcie_device_id_reg extends uvm_reg;
  rand uvm_reg_field device_id;

  `uvm_object_utils(pcie_device_id_reg)

  function new(string name="pcie_device_id_reg");
    super.new(name, 16, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    device_id = uvm_reg_field::type_id::create("device_id");
    device_id.configure(this, 16, 0, "RO", 0, 16'h5678, 1, 0, 1);
  endfunction
endclass


// Command Register (offset 0x04)
class pcie_command_reg extends uvm_reg;
  rand uvm_reg_field io_en, mem_en, bus_master_en;

  `uvm_object_utils(pcie_command_reg)

  function new(string name="pcie_command_reg");
    super.new(name, 16, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    io_en = uvm_reg_field::type_id::create("io_en");
    io_en.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 1);

    mem_en = uvm_reg_field::type_id::create("mem_en");
    mem_en.configure(this, 1, 1, "RW", 0, 1'h0, 1, 0, 1);

    bus_master_en = uvm_reg_field::type_id::create("bus_master_en");
    bus_master_en.configure(this, 1, 2, "RW", 0, 1'h0, 1, 0, 1);
  endfunction
endclass
