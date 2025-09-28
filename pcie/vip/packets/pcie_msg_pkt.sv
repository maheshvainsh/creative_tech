//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_msg_pkt.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_MESSAGE_PACKET_SV
`define PCIE_MESSAGE_PACKET_SV
class pcie_base_msg_pkt extends pcie_header_pkt;

 rand Message_code_t msg_code;
 rand message_routing_t routing;
 rand pcie_message_t  msg_type;
 rand ecs_t ecss_code;

 //Factory Registration
 `uvm_object_utils(pcie_base_msg_pkt)

 extern function new(string name="pcie_base_msg_pkt"); 

endclass :pcie_base_msg_pkt

 function pcie_base_msg_pkt::new(string name="pcie_base_msg_pkt");
   super.new(name);
 endfunction

class pcie_msg_pkt #(pcie_message_t msg ) extends pcie_base_msg_pkt ;
  rand bit[BUS_NUM_WIDTH-1:0] BUS_NUMBER;
  rand bit[DEVICE_NUM_WIDTH-1:0] DEVICE_NUM;
  rand bit[FCN_NUM__WIDTH-1:0] FCN_NUM;
  rand bit[VENDOR_ID_WIDTH-1:0]VENDOR_ID; 

  //Factory Registration
  `uvm_object_param_utils_begin(pcie_msg_pkt#(msg))
  `uvm_field_enum(Message_code_t,msg_code,UVM_ALL_ON)
  `uvm_field_enum(message_routing_t,routing,UVM_ALL_ON)
  `uvm_field_enum(pcie_message_t,msg_type,UVM_ALL_ON)
  `uvm_field_enum(ecs_t,ecss_code,UVM_ALL_ON)
  `uvm_field_int(BUS_NUMBER,UVM_ALL_ON)
  `uvm_field_int(DEVICE_NUM,UVM_ALL_ON)
  `uvm_field_int(FCN_NUM,UVM_ALL_ON)
  `uvm_field_int(VENDOR_ID,UVM_ALL_ON)
  `uvm_object_utils_end
  

   constraint msg_t { msg_type == msg; 
                      REQUESTER_ID ==0; 
                      ATTR_1 == DEFAULT_ORDER;
                      TH==0;
                      AT == 0;
                      ATTR_2 == DEFAULT; // To Do (Need to Update in feature)
                      LN == 0;

                      if(msg_type == INTX_INTERRUPT_SIGNALING)
                        { TR_TYPE == MSG;
                          FMT == DW4_HEADER_ND;
                          routing==LOCAL_TO_RECEIVER;  
                          Type == 'b10100;
                          DATA.size()==0;
                          LENGTH == 0;
                          ecss_code ==0; 
                          msg_code inside {ASSERT_INTA,ASSERT_INTB,ASSERT_INTC,ASSERT_INTD,DEASSERT_INTA,DEASSERT_INTB,DEASSERT_INTC,DEASSERT_INTD};
                        }
                      else if(msg_type == POWER_MANAGEMENT)
                        { TR_TYPE == MSG;
                          FMT == DW4_HEADER_ND;
                          LENGTH == 0;
                          msg_code inside {PM_ACTIVE_STATE_NAK,PM_PME,PM_TURN_OFF,PM_TO_ACK};
                          if(msg_code ==PM_ACTIVE_STATE_NAK) { routing==LOCAL_TO_RECEIVER;  Type == 'b10100;}
                          if(msg_code ==PM_PME)              { routing==ROUTED_TO_RC;  Type == 'b10000;}
                          if(msg_code ==PM_TURN_OFF)         { routing==BROADCAST_FRM_RC;  Type == 'b10011;}
                          if(msg_code ==PM_TO_ACK)           { routing==GATHER_AND_ROUTED_TO_RC;  Type == 'b10101;}
                          ecss_code ==0; 
                          DATA.size()==0;
 
                        }
                      else if(msg_type == ERROR_SIGNALING)
                        { TR_TYPE == MSG;
                          FMT == DW4_HEADER_ND;
                          LENGTH == 0;
                          msg_code inside {ERR_COR,ERR_NONFATAL,ERR_FATAL};
                          routing == ROUTED_TO_RC;
                          Type == 'b10000; 
                          ecss_code inside {ECS_LEGACY,ECS_SIG_SFW,ECS_SIG_OS,ECS_EXTENDED};
                          DATA.size()==0;
                        }
                      else if(msg_type == LOCKED_TRANSACTION_SUPPORT)
                        {
                          TR_TYPE == MSG;
                          FMT == DW4_HEADER_ND;
                          LENGTH == 0;
                          msg_code == UNLOCK;
                          routing == BROADCAST_FRM_RC;
                          Type == 'b10011;
                          ecss_code ==0; 
                          DATA.size()==0;
                        }
                      else if(msg_type == SLOT_POWER_LIMIT_SUPPORT)
                        {
                         TR_TYPE == MSGD;
                         FMT == DW4_HEADER_WD;
                         DATA.size()==1;
                         msg_code == SET_SLOT_POWER_LIMIT;
                         routing == LOCAL_TO_RECEIVER;
                         Type == 'b10100;
                         ecss_code ==0;
                         LENGTH == 1;   // Need to Update
                        }
                      else if(msg_type == VENDOR_DEFINED_MESSAGES)
                        {
                          TR_TYPE inside {MSG,MSGD};
                          if(TR_TYPE == MSG)       {FMT == DW4_HEADER_ND; LENGTH == 0;DATA.size()==LENGTH;}
                          else if(TR_TYPE == MSGD) {FMT == DW4_HEADER_WD;  LENGTH == 1;DATA.size()==LENGTH;}
                          msg_code inside {VENDOR_DEFINED_TYPE0,VENDOR_DEFINED_TYPE1};
                          routing inside {ROUTED_TO_RC,ROUTED_BY_ID,BROADCAST_FRM_RC,LOCAL_TO_RECEIVER};
                          Type inside {'b10000,'b10010,'b10011,'b10100}; 
                          ecss_code ==0;
                        } 
                    }

   extern function new(string name="pcie_msg_pkt");
   extern function void post_randomize();  
   
endclass : pcie_msg_pkt

 function  pcie_msg_pkt::new(string name="pcie_msg_pkt");
  super.new(name);
 endfunction

function void  pcie_msg_pkt::post_randomize();
  int payload_data_index;

  //if( msg_type inside {INTX_INTERRUPT_SIGNALING,POWER_MANAGEMENT,ERROR_SIGNALING,LOCKED_TRANSACTION_SUPPORT}) begin
  if(TR_TYPE== MSG) begin
     payload= new[16](payload);
     for(int i=8; i<16; i++) begin
       payload[i] =0; 
     end
  end
  //else if (msg_type inside {SLOT_POWER_LIMIT_SUPPORT}) begin
  else if (TR_TYPE== MSGD) begin
     payload = new[20](payload);
     payload_data_index = 16;
     for(int i=8; i<16; i++) begin
       payload[i] =0; 
     end
     for(int i=($bits(DATA[0])/8)-1; i>=0;i--)begin
     payload[payload_data_index] = DATA[0][i*8+:8];
     $display("DATA = %0d",payload_data_index);
     payload_data_index++;      
     end
  end

  payload[4] = REQUESTER_ID[15:8];
  payload[5] = REQUESTER_ID[7:0];
  payload[6] = TAG;
  payload[7] = msg_code;
  if(msg_type!= VENDOR_DEFINED_MESSAGES)payload[8][7:5] = ecss_code;
  else if(msg_type == VENDOR_DEFINED_MESSAGES) begin
   payload[8] = BUS_NUMBER;
   payload[9][7:3]  = DEVICE_NUM;
   payload[9][2:0]  = FCN_NUM;
   payload[10] =  VENDOR_ID[15:8];
   payload[11] =  VENDOR_ID[7:0]; 
  end 
  endfunction    

`endif //PCIE_MESSAGE_PACKET_SV
