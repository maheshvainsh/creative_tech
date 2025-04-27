class pcie_sw_sequencer extends uvm_sequencer;
	`uvm_component_utils (pcie_sw_sequencer)
	
        extern function new (string name="pcie_sw_sequencer", uvm_component parent);

endclass:pcie_sw_sequencer
 

       function pcie_sw_sequencer::new (string name="pcie_sw_sequencer", uvm_component parent);
           super.new (name, parent);
       endfunction :new

