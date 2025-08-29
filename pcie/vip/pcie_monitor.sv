`ifndef PCIE_MONITOR_SV
`define PCIE_MONITOR_SV

class pcie_monitor extends uvm_monitor;
  	`uvm_component_utils (pcie_monitor)

	extern function new (string name="pcie_monitor", uvm_component parent);
        extern virtual function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern virtual task drive_item ();

endclass : pcie_monitor

	function pcie_monitor::new (string name="pcie_monitor", uvm_component parent);
            super.new (name, parent);
        endfunction

        function void pcie_monitor::build_phase (uvm_phase phase);
           super.build_phase (phase);
           //if (! uvm_config_db #(virtual dut_if) :: get (this, "", "vif", vif)) begin
             // `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface dut_if")
           //end
        endfunction : build_phase

        task pcie_monitor::run_phase (uvm_phase phase);
           super.run_phase (phase);
        endtask : run_phase

        task pcie_monitor::drive_item ();
           // Drive based on bus protocol
        endtask : drive_item

`endif //PCIE_MONITOR_SV

