class pcie_rc_sequencer extends uvm_sequencer;
	`uvm_component_utils (pcie_rc_sequencer)
	
        extern function new (string name="pcie_rc_sequencer", uvm_component parent);

endclass:pcie_rc_sequencer
 

       function pcie_rc_sequencer::new (string name="pcie_rc_sequencer", uvm_component parent);
           super.new (name, parent);
       endfunction :new

