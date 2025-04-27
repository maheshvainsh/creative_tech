class pcie_sw_driver extends uvm_driver;
  	`uvm_component_utils (pcie_sw_driver)

	extern function new (string name="pcie_sw_driver", uvm_component parent);
        extern virtual function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern virtual task drive_item ();

endclass : pcie_sw_driver

	function pcie_sw_driver::new (string name="pcie_sw_driver", uvm_component parent);
            super.new (name, parent);
        endfunction

        function void pcie_sw_driver::build_phase (uvm_phase phase);
           super.build_phase (phase);
           //if (! uvm_config_db #(virtual dut_if) :: get (this, "", "vif", vif)) begin
             // `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface dut_if")
           //end
        endfunction : build_phase

        task pcie_sw_driver::run_phase (uvm_phase phase);
           super.run_phase (phase);
        endtask : run_phase

        task pcie_sw_driver::drive_item ();
           // Drive based on bus protocol
        endtask : drive_item

