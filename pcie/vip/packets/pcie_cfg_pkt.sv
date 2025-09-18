//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_cfg_pkt.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_CONFIG_PKT_SV
`define PCIE_CONFIG_PKT_SV

 class pcie_cfg_pkt extends pcie_header_pkt;

  rand bit[BUS_NUM_WIDTH-1:0] BUS_NUMBER;
  rand bit[DEVICE_NUM_WIDTH-1:0] DEVICE_NUM;
  rand bit[FCN_NUM__WIDTH-1:0] FCN_NUM;
  rand bit[REG_NUMBER_WIDTH-1:0]REGISTER_NUMBER;
  rand bit[EXTEND_REG_WIDTH-1:0]EXTENDED_REGISTER_NUMBER;
 

  //Factory Registration
  `uvm_object_utils_begin(pcie_cfg_pkt)
   `uvm_field_int(BUS_NUMBER,UVM_ALL_ON)
   `uvm_field_int(DEVICE_NUM,UVM_ALL_ON)
   `uvm_field_int(FCN_NUM,UVM_ALL_ON)
   `uvm_field_int(REGISTER_NUMBER,UVM_ALL_ON)
   `uvm_field_int(EXTENDED_REGISTER_NUMBER,UVM_ALL_ON)
  `uvm_object_utils_end

  constraint tr_type { TR_TYPE inside {CFGR0,CFGWR0};}
  
  constraint length_size { solve TR_TYPE before LENGTH;
                           solve FMT     before LENGTH;
                           LENGTH == 1;
                         }

  constraint data_size { solve TR_TYPE before DATA;
                         solve FMT before DATA;
                         solve LENGTH before DATA;                          
                         TC[2:0] == 0;
                         ATTR_1 == DEFAULT_ORDER;
                         ATTR_2 == DEFAULT;
                         AT == 0;
                         DW_BE[7:4] ==0;   
                         TH==0;
                         LN ==0;
                         DW_BE[7:4] ==0;   
                          if(FMT == DW3_HEADER_ND) {DATA.size == 0;}
                          else if(FMT == DW3_HEADER_WD) {DATA.size== LENGTH;}        
                       }

  extern function new(string name ="pcie_cfg_pkt");
  extern function void post_randomize();
  extern virtual function void do_print(uvm_printer printer);

 endclass :pcie_cfg_pkt 

 function pcie_cfg_pkt::new(string name="pcie_cfg_pkt");
  super.new(name);
 endfunction :new

 function void pcie_cfg_pkt::do_print(uvm_printer printer);
  super.do_print(printer);
 endfunction : do_print

 function void pcie_cfg_pkt::post_randomize();
  int payload_data_index;

  if(TR_TYPE == CFGWR0) payload = new[16](payload);
  else if(TR_TYPE == CFGR0) payload = new[12](payload);

  payload[4] =  REQUESTER_ID[15:8];
  payload[5] =  REQUESTER_ID[7:0];
  payload[6] =  TAG;
  payload[7][7:4] = DW_BE[7:4];
  payload[7][3:0] = DW_BE[3:0];
  payload[8] = BUS_NUMBER;
  payload[9][7:3] = DEVICE_NUM;
  payload[9][2:0] = FCN_NUM;
  payload[10][7:4] = 0;
  payload[10][3:0] = EXTENDED_REGISTER_NUMBER;
  payload[11][7:2] = REGISTER_NUMBER;
  payload[11][1:0] = 0;   
  payload_data_index =12;

   if(payload.size>12) begin
     for(int i=($bits(DATA[0])/8)-1; i>=0;i--)begin
       payload[payload_data_index] = DATA[0][i*8+:8];
       $display("DATA = %0d",payload_data_index);
       payload_data_index++;      
     end
   end
 endfunction :post_randomize

`endif //PCIE_CONFIG_PKT_SV
