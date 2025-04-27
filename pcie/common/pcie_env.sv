import pcie_ep_pkg::*;
import pcie_sw_pkg::*;
import pcie_rc_pkg::*;
class pcie_env extends uvm_env;
    
    pcie_rc_agent    m_pcie_rc_agent;
    pcie_ep_agent    m_pcie_ep_agent;
    pcie_sw_agent    m_pcie_sw_agent;
    pcie_virtual_sequencer m_pcie_virtual_sequencer;
    `uvm_component_utils(pcie_env)

    extern function new(string name ="pcie_env",uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);

endclass : pcie_env

    function pcie_env::new(string name ="pcie_env",uvm_component parent);
        super.new(name,parent);
    endfunction : new
    
    function void pcie_env::build_phase(uvm_phase phase);
       //Create the agents
       m_pcie_rc_agent = pcie_rc_agent::type_id::create("m_pcie_rc_agent", this);
       m_pcie_ep_agent = pcie_ep_agent::type_id::create("m_pcie_ep_agent", this);
       m_pcie_sw_agent = pcie_sw_agent::type_id::create("m_pcie_sw_agent", this);
    endfunction : build_phase

