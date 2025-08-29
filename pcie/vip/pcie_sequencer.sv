class pcie_sequencer extends uvm_sequencer;
	`uvm_component_utils (pcie_sequencer)
	
        extern function new (string name="pcie_sequencer", uvm_component parent);

endclass:pcie_sequencer
 

       function pcie_sequencer::new (string name="pcie_sequencer", uvm_component parent);
           super.new (name, parent);
       endfunction :new

