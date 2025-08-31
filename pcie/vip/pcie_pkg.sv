`ifndef PCIE_PKG_SV
`define PCIE_PKG_SV

`include "pcie_if.sv"
package pcie_pkg;
import uvm_pkg::*;//compile uvm lib
`include "uvm_macros.svh"
`include "../ral_model/pcie_ral_pkg.sv"
`include "pcie_parameter.sv"
`include "../mem_model/mem_model.sv"
`include "pcie_trans.sv"
`include "packets/pcie_cfg_pkt.sv"
`include "packets/pcie_mem_pkt.sv"
`include "packets/pcie_io_pkt.sv"
`include "packets/pcie_msg_pkt.sv"
`include "packets/pcie_comp_pkt.sv"

`include "pcie_monitor.sv"
`include "pcie_driver.sv"
`include "pcie_sequencer.sv"
`include "pcie_agent.sv"

endpackage : pcie_pkg
`endif //PCIE_PKG_SV
