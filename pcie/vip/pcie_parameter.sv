//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_parameter.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_PARAMETER_SV
`define PCIE_PARAMETER_SV

//keep define common paramter here
parameter LAN_WIDTH   =1;
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 32;
parameter NO_OF_VC = 3;
parameter BUS_NUM_WIDTH = 8;
parameter DEVICE_NUM_WIDTH=5;
parameter FCN_NUM__WIDTH = 3;
parameter EXTEND_REG_WIDTH=4;
parameter REG_NUMBER_WIDTH = 6;
parameter VENDOR_ID_WIDTH = 16;

`endif //PCIE_PARAMETER_SV
