`ifndef PCIE_ENV_SV
`define PCIE_ENV_SV
import pcie_pkg::*;
class pcie_env extends uvm_env;
    
  pcie_agent    m_rc_agent;
  pcie_agent    m_sw_agent;
  pcie_agent    m_ep_agent;
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
     m_rc_agent = pcie_agent::type_id::create("m_rc_agent", this);
     m_ep_agent = pcie_agent::type_id::create("m_ep_agent", this);
     m_sw_agent = pcie_agent::type_id::create("m_sw_agent", this);
  endfunction : build_phase
`endif //PCIE_ENV_SV
