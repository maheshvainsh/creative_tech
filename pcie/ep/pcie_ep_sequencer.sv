class pcie_ep_sequencer extends uvm_sequencer;
	`uvm_component_utils (pcie_ep_sequencer)
	
        extern function new (string name="pcie_ep_sequencer", uvm_component parent);

endclass:pcie_ep_sequencer
 

       function pcie_ep_sequencer::new (string name="pcie_ep_sequencer", uvm_component parent);
           super.new (name, parent);
       endfunction :new

