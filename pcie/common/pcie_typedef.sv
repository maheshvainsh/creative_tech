//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_typedef.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_TYPEDEF_PKG_SV
`define PCIE_TYPEDEF_PKG_SV

//	
typedef enum {MASTER,SLAVE} master_slave_e;

typedef enum bit [2:0] {DW3_HEADER_ND  = 'b000,
                        DW4_HEADER_ND  = 'b001, 
                        DW3_HEADER_WD  = 'b010, 
                        DW4_HEADER_WD  = 'b011, 
                        TLP_PREFIXH     = 'b100} fmt_t;

typedef enum {MRD,MRDLK,MWR,IORD,IOWR,CFGR0,CFGWR0,CFGRD1,CFGWR1,MSG,MSGD,CPL,CPLD,CPL_LK,CPL_DLK } type_t;

typedef enum bit [1:0] {DEFAULT_ORDER                = 'b00,
                        RELAXED_ORDER                = 'b01, 
                        ID_BASED_ORDER               = 'b10, 
                        RELAXED_PLUS_ID_BASED_ORDER  = 'b11} attr1_t;

typedef enum bit {DEFAULT   = 'b0,
                  NO_SNOOP  = 'b1} attr2_t;


typedef enum bit[1:0] {BI_DIRECTIONAL_DATA   = 'b00,
                       REQUESTER             = 'b01,
                       TARGET                = 'b10,
                       TARGET_WITH_PRIORITY  = 'b11
                      } ph_t;

typedef enum bit[2:0] {ROUTED_TO_RC             = 'b000,
                       ROUTED_BY_ADDRESS        = 'b001,
                       ROUTED_BY_ID             = 'b010,
                       BROADCAST_FRM_RC         = 'b011,
                       LOCAL_TO_RECEIVER        = 'b100,
                       GATHER_AND_ROUTED_TO_RC  = 'b101,
                       RESERVED               
                      } message_routing_t;

typedef enum {DL_INACTIVE,DL_FEATURE,DL_INIT,DL_ACTIVE,DL_UP,DL_DOWN} link_state_t;


typedef enum {ACK,MR_INIT,DATA_LINK_FEATURE,
              NAK,PM_ENTER_L1,PM_ENTER_L23, 
              PM_REQUEST_ACK,VENDOR_SPECIFIC, 
              NOP,INITFC1_PM,INITFC1_NP,MR_INIT_FC1, 
              INITFC2_P,INITFC2_NP,INIT_FC2_CPL,MR_INIT_FC2,
              UPDATE_FC_P,UPDATE_FC_NP,UPDATE_FC_CPL,MR_UPDATE_FC} DLLP_type_t;




typedef enum bit[7:0] {ASSERT_INTA = 'b0000_0010,   // INTERUPT MESSAGES
                       ASSERT_INTB = 'b0010_0001,   // INTERUPT MESSAGES
                       ASSERT_INTC = 'b0010_0010,   // INTERUPT MESSAGES
                       ASSERT_INTD = 'b0011_0010,   // INTERUPT MESSAGES
                       DEASSERT_INTA = 'b0010_0100, // INTERUPT MESSAGES
                       DEASSERT_INTB = 'b0100_0010, // INTERUPT MESSAGES
                       DEASSERT_INTC = 'b0110_0010, // INTERUPT MESSAGES
                       DEASSERT_INTD = 'b0111_0010, // INTERUPT MESSAGES
                       PM_ACTIVE_STATE_NAK = 'b0001_0001,  //POWER MANANGEMENT MESSAGES
                       PM_PME              = 'b1000_0001,  //POWER MANANGEMENT MESSAGES
                       PM_TURN_OFF         = 'b1001_0001,  //POWER MANANGEMENT MESSAGES
                       PM_TO_ACK           = 'b1011_0001,  //POWER MANANGEMENT MESSAGES
                       ERR_COR             = 'b0000_0011,  //ERROR SIGNALING MESSAGES
                       ERR_NONFATAL        = 'b0001_0011,  //ERROR SIGNALING MESSAGES
                       ERR_FATAL           = 'b0011_0011,  //ERROR SIGNALING MESSAGES
                       SET_SLOT_POWER_LIMIT= 'b0101_0000,  //SLOT POWER LIMIT SUPPORT
                       UNLOCK              = 'b0000_0000,
                       VENDOR_DEFINED_TYPE0 = 'b0111_1110,  //VENDOR DEFINED MESSAGES
                       VENDOR_DEFINED_TYPE1 = 'b0111_1111,  //VENDOR DEFINED MESSAGES
                       IGNORE_MESSAGE1      = 'b0100_0001,  //Igbored Messages
                       IGNORE_MESSAGE2      = 'b0100_0011, 
                       IGNORE_MESSAGE3      = 'b0100_0000, 
                       IGNORE_MESSAGE4      = 'b0100_0101, 
                       IGNORE_MESSAGE5      = 'b0100_0111, 
                       IGNORE_MESSAGE6      = 'b0100_0100, 
                       IGNORE_MESSAGE7      = 'b0100_1000, 
                       LTR                  = 'b0001_0000, //Latency Tolerence Reporting
                       ONFF                 = 'b0001_0010, //Optimized buffer flush/fill Message
                       PTM_REQUEST          = 'b0101_0010, //PRECISION TIME MEASURNMENT Message (initiares PTM Dialog)
                      // PTM_RESPONSE         = 'b0101_0011, //PRECISION TIME MEASURNMENT Message does not carry timing info(complete PTM dialog)
                       PTM_RESPONSED         = 'b0101_0011 //PRECISION TIME MEASURNMENT Message current PTM dialog-carries timing info
                       //TODO //need to add more messages here

                       } Message_code_t;


typedef enum bit[2:0]  { SUCCESSFUL_COMPLETION  = 'b000,
                         UNSUPPORTED_REQUEST    = 'b001,
                         CONFIGURATION_REQUEST_RETRY_STATUS = 'b010,
                         COMPLETER_ABORT    = 'b100
                        } completion_status_e;

typedef enum  bit[3:0] {INTX_INTERRUPT_SIGNALING,
                        POWER_MANAGEMENT,
                        ERROR_SIGNALING,
                        LOCKED_TRANSACTION_SUPPORT,
                        SLOT_POWER_LIMIT_SUPPORT,
                        VENDOR_DEFINED_MESSAGES,
                        LATENCY_TOLERANCE_REPORTING_MESSAGES,
                        OPTIMIZED_BUFFER_FLUSH_FILL_MESSAGES,
                        DEVICE_READINESS_STATUS_MESSAGES,
                        FUNCTION_READINESS_STATUS_MESSAGES,
                        PRECISION_TIME_MEASUREMENT_MESSAGES}pcie_message_t;

typedef enum bit[1:0] { ECS_LEGACY,
                        ECS_SIG_SFW,
                        ECS_SIG_OS,
                        ECS_EXTENDED}ecs_t;

                        
                         
`endif //PCIE_TYPEDEF_PKG_SV







