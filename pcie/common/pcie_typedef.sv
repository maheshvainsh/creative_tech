//	

typedef enum bit [2:0] {DW3_HEADER_ND  = 'b000,
                        DW4_HEADER_ND  = 'b001, 
                        DW3_HEADER_WD  = 'b010, 
                        DW4_HEADER_WD  = 'b011} fmt_t;

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





