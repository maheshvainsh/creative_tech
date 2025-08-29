`ifndef PCIE_PKG_SV
`define PCIE_PKG_SV

package pcie_pkg;
import uvm_pkg::*;//compile uvm lib
`include "uvm_macros.svh"

`include "pcie_monitor.sv"
`include "pcie_driver.sv"
`include "pcie_sequencer.sv"
`include "pcie_agent.sv"

endpackage : pcie_pkg
`endif //PCIE_PKG_SV
