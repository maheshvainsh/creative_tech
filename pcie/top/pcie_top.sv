`ifndef PCIE_TOP_SV
`define PCIE_TOP_SV
import uvm_pkg::*;//compile uvm lib
`include "uvm_macros.svh"
`include "../vip/pcie_pkg.sv"
`include "../common/pcie_common_pkg.sv"
import pcie_pkg::*;
import pcie_common_pkg::*;
module pcie_top ;



//add interface here

//i2c_inf    vif();
//set interface here 


//generate clock 


//run test here 


initial begin
/*pcie_pkt1 pcie_pkt_t;

pcie_pkt_t =new();

pcie_pkt_t.randomize()  with {TR_TYPE == IOWR;FMT==DW3_HEADER_WD;LENGTH =='h1;};

pcie_pkt_t.print();*/
//uvm_config_db #(virtual i2c_inf)::set(null, "*", "vif", vif);
run_test("pcie_base_test");
//$display("Jay Shree Radhe Krishna");


end

endmodule : pcie_top
`endif //PCIE_TOP_SV

