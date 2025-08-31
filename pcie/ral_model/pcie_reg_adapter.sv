class pcie_reg_adapter extends uvm_reg_adapter;
  `uvm_object_utils(pcie_reg_adapter)

  extern function new(string name="pcie_reg_adapter");
  //extern virtual function reg2bus(const ref uvm_reg_bus_op rw);
 // extern virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);

    // Convert RAL -> PCIe TLP
  //----------------------------------------------TODO---------------------------
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    uvm_sequence_item req = uvm_sequence_item::type_id::create("uvm_sequence_item");
  //  req.addr     = rw.addr;
  //  req.is_write = (rw.kind == UVM_WRITE);
  //  req.size     = 4;  // assume 32-bit accesses for config space
  //  if (rw.kind == UVM_WRITE)
      //req.data = rw.data;
   return req;
  endfunction : reg2bus


  //-----------------------TODO--------------------------------------
  // Convert PCIe TLP -> RAL bus response
  function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
   /* pcie_seq_item rsp;
    if (!$cast(rsp, bus_item)) begin
      `uvm_fatal("ADAPTER", "Provided bus_item is not a pcie_seq_item");
    end

    rw.addr = rsp.addr;
    rw.kind = rsp.is_write ? UVM_WRITE : UVM_READ;
    rw.data = rsp.data;
    rw.status = UVM_IS_OK;*/
  endfunction

endclass : pcie_reg_adapter


  function pcie_reg_adapter::new(string name="pcie_reg_adapter");
    super.new(name);
    // PCIe uses explicit response phase → set accordingly
    //supports_byte_enable = 0;
    //provides_responses   = 1;
  endfunction : new
  

