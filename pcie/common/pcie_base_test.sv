class pcie_base_test extends uvm_test;

     pcie_env m_pcie_env;
     pcie_base_sequence bseq;
    `uvm_component_utils(pcie_base_test)

    extern function new(string name ="pcie_base_test",uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void end_of_elaboration_phase (uvm_phase phase);
    extern task run_phase(uvm_phase phase);


endclass : pcie_base_test

    function pcie_base_test::new(string name ="pcie_base_test",uvm_component parent);
        super.new(name,parent);
    endfunction : new
    
    function void pcie_base_test::build_phase(uvm_phase phase);
        // Create the environment
        m_pcie_env = pcie_env::type_id::create("m_pcie_env", this);
        bseq = pcie_base_sequence::type_id::create("bseq");
    endfunction : build_phase
   
  // [Recommended] By this phase, the environment is all set up so its good to just print the topology for debug
   function void pcie_base_test::end_of_elaboration_phase (uvm_phase phase);
      uvm_top.print_topology ();
   endfunction
    
   
  task pcie_base_test::run_phase(uvm_phase phase);
    phase.raise_objection(this);
        
    //repeat(10) begin 
     #5; bseq.start(null);
    //end
    
    phase.drop_objection(this);
    `uvm_info(get_type_name, "End of testcase", UVM_LOW);
  endtask

    
