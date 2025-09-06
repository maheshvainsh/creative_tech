//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_virtual_sequencer.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_VIRTUAL_SEQUENCER_SV
`define PCIE_VIRTUAL_SEQUENCER_SV
class pcie_virtual_sequencer extends uvm_sequencer;
    pcie_sequencer m_pcie_sequencer;
    `uvm_component_utils(pcie_virtual_sequencer)

    extern function new(string name ="pcie_virtual_sequencer",uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);

endclass : pcie_virtual_sequencer

    function pcie_virtual_sequencer::new(string name ="pcie_virtual_sequencer",uvm_component parent);
        super.new(name,parent);
    endfunction : new

    function void pcie_virtual_sequencer::build_phase(uvm_phase phase);
       //Create the environment
    endfunction : build_phase

`endif //PCIE_VIRTUAL_SEQUENCER_SV


