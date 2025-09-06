//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_env.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_ENV_SV
`define PCIE_ENV_SV
import pcie_pkg::*;
class pcie_env extends uvm_env;
    
  pcie_agent    m_rc_agent;
  pcie_agent    m_sw_agent;
  pcie_agent    m_ep_agent;
  pcie_virtual_sequencer m_pcie_virtual_sequencer;
  pcie_cfg_block ral_model;
 // uvm_reg_predictor #(pcie_seq_item) reg_predictor;
  pcie_reg_adapter reg_adapter;
  `uvm_component_utils(pcie_env)

  extern function new(string name ="pcie_env",uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : pcie_env

  function pcie_env::new(string name ="pcie_env",uvm_component parent);
      super.new(name,parent);
  endfunction : new
  
  function void pcie_env::build_phase(uvm_phase phase);
     //Create the agents
     m_rc_agent = pcie_agent::type_id::create("m_rc_agent", this);
     m_ep_agent = pcie_agent::type_id::create("m_ep_agent", this);
     m_sw_agent = pcie_agent::type_id::create("m_sw_agent", this);
   
    // Build predictor and adapter
    //reg_predictor = uvm_reg_predictor#(pcie_seq_item)::type_id::create("reg_predictor", this);
    reg_adapter   = pcie_reg_adapter::type_id::create("reg_adapter",this);

     // Build RAL model
    ral_model = pcie_cfg_block::type_id::create("ral_model", this);
    ral_model.build();
    ral_model.lock_model();
  
  endfunction :  build_phase

  function void pcie_env::connect_phase(uvm_phase phase);
    // Tell RAL to use this sequencer + adapter
     ral_model.default_map.set_sequencer(m_rc_agent.m_pcie_sequencer, reg_adapter);

    // Connect monitor to predictor
   // reg_predictor.adapter = reg_adapter;
   // agent.monitor.ap.connect(reg_predictor.bus_in);
  endfunction : connect_phase
`endif //PCIE_ENV_SV
