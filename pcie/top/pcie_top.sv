import uvm_pkg::*;//compile uvm lib
`include "uvm_macros.svh"
`include "/home/mahesh/project/trunk/new_repo/creative_tech/pcie/ep/pcie_ep_pkg.sv"
`include "/home/mahesh/project/trunk/new_repo/creative_tech/pcie/rc/pcie_rc_pkg.sv"
`include "/home/mahesh/project/trunk/new_repo/creative_tech/pcie/switch/pcie_sw_pkg.sv"
`include "/home/mahesh/project/trunk/new_repo/creative_tech/pcie/common/pcie_common_pkg.sv"
import pcie_ep_pkg::*;
import pcie_sw_pkg::*;
import pcie_rc_pkg::*;
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


