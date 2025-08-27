
`ifndef PCIE_COMMON_PKG_SV //This avoid multiple comilation of the file
`define PCIE_COMMON_PKG_SV
package pcie_common_pkg;
import uvm_pkg::*;//compile uvm lib
`include "uvm_macros.svh"
`include "pcie_parameter.sv"
`include "pcie_trans.sv"
`include "packets/pcie_cfg_pkt.sv"
`include "packets/pcie_mem_pkt.sv"
`include "packets/pcie_io_pkt.sv"
`include "packets/pcie_msg_pkt.sv"
`include "packets/pcie_comp_pkt.sv"
`include "pcie_base_sequence.sv"
`include "pcie_virtual_sequencer.sv"
`include "pcie_env.sv"
`include "pcie_base_test.sv"
endpackage : pcie_common_pkg
`endif//PCIE_COMMON_PKG_SV
