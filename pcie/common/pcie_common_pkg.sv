//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_common_pkg.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------

`ifndef PCIE_COMMON_PKG_SV //This avoid multiple comilation of the file
`define PCIE_COMMON_PKG_SV
package pcie_common_pkg;
import uvm_pkg::*;//compile uvm lib
import pcie_pkg::*;
`include "uvm_macros.svh"
`include "../seq_lib/pcie_seq_lib.svh"
`include "pcie_virtual_sequencer.sv"
`include "../env/pcie_env.sv"
`include "../tests/pcie_test_lib.sv"
endpackage : pcie_common_pkg
`endif//PCIE_COMMON_PKG_SV
