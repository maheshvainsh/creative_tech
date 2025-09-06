//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_driver.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_DRIVER_SV
`define PCIE_DRIVER_SV
class pcie_driver extends uvm_driver;
  	`uvm_component_utils (pcie_driver)

	extern function new (string name="pcie_driver", uvm_component parent);
        extern virtual function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern virtual task drive_item ();

endclass : pcie_driver

	function pcie_driver::new (string name="pcie_driver", uvm_component parent);
            super.new (name, parent);
        endfunction

        function void pcie_driver::build_phase (uvm_phase phase);
           super.build_phase (phase);
           //if (! uvm_config_db #(virtual dut_if) :: get (this, "", "vif", vif)) begin
             // `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface dut_if")
           //end
        endfunction : build_phase

        task pcie_driver::run_phase (uvm_phase phase);
           super.run_phase (phase);
        endtask : run_phase

        task pcie_driver::drive_item ();
           // Drive based on bus protocol
        endtask : drive_item
`endif //PCIE_DRIVER_SV
