import uvm_pkg::*;//compile uvm lib

`include "uvm_macros.svh"

`include "pcie_typedef.sv"

class master_pkt extends uvm_sequence_item ;
 
     rand bit[31:0] payload[] ; //main packet to be driven

      `uvm_object_utils_begin(master_pkt)
        `uvm_field_array_int(payload,UVM_ALL_ON)
      `uvm_object_utils_end

    //-----------------------------------------------------------------
    //Decription :  This method is allocate memory space for this class
    //-----------------------------------------------------------------
    extern function new (string name = "master_pkt");

   
endclass : master_pkt


    //-----------------------------------------------------------------
    //Decription :  This method is allocate memory space for this class
    //-----------------------------------------------------------------
    function master_pkt::new(string name = "master_pkt");
        super.new(name);
        
    endfunction :new

class pcie_header_pkt extends master_pkt ;

     //////////////////TLP PREFIX FIELD//////////////////////////////
     rand bit [7:0] TLP_PREFIX[];   //set if the TH is provided else reserved and not part of packet
     rand bit [7:0] ST ;            //field for tlp prefix 

     //////////////////////HEADER FIELDS START//////////////////////
     //-------BYTE 0-----------------
     rand fmt_t FMT; 
     rand type_t TR_TYPE; 
     rand bit [4:0] Type;

     //-------BYTE 1-----------------
     bit T9 ; //reserved
     rand bit [NO_OF_VC-1:0] TC; 
     bit T8 ; //reserved
     rand attr2_t  ATTR_2;     
     rand bit LN;
     rand bit TH;

     //-------BYTE 2-----------------
     rand bit TD;
     rand bit EP;
     rand attr1_t ATTR_1;    
     rand bit[1:0] AT;
 
     //-------BYTE 3-----------------
     rand bit [9:0] LENGTH;//byte 3
     //////////////////////HEADER FIELDS END////////////////////////

     rand bit [15:0] REQUESTER_ID;
     rand bit [7:0]  TAG;
     rand bit [7:0] DW_BE;
     
     rand bit [31:0] ADDRESS[];
 
     rand bit [31:0] TLP_DIGEST [];
     rand  ph_t PH;

    `uvm_object_utils_begin(pcie_header_pkt)
     `uvm_field_array_int(TLP_PREFIX,UVM_ALL_ON)
     `uvm_field_int      (ST, UVM_HEX|UVM_ALL_ON)
     `uvm_field_enum     (fmt_t, FMT, UVM_ALL_ON)
     `uvm_field_enum     (type_t, TR_TYPE, UVM_ALL_ON)
     `uvm_field_int      (Type, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (T9, UVM_DEC|UVM_ALL_ON)
     `uvm_field_int      (TC, UVM_BIN|UVM_ALL_ON)
     `uvm_field_enum     (attr2_t, ATTR_2, UVM_ALL_ON)
     `uvm_field_int      (LN, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (TH, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (TD, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (EP, UVM_BIN|UVM_ALL_ON)
     `uvm_field_enum     (attr1_t, ATTR_1, UVM_ALL_ON)
     `uvm_field_int      (LN, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (AT, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (LENGTH, UVM_DEC|UVM_ALL_ON)
     `uvm_field_int      (REQUESTER_ID, UVM_HEX|UVM_ALL_ON)
     `uvm_field_int      (TAG, UVM_HEX|UVM_ALL_ON)
     `uvm_field_int      (DW_BE, UVM_BIN|UVM_ALL_ON)
     `uvm_field_array_int(TLP_DIGEST,UVM_ALL_ON)

    //`uvm_field_queue_int(data, UVM_ALL_ON)
    //`uvm_field_object   (ext,  UVM_ALL_ON)
    //`uvm_field_string   (str,  UVM_ALL_ON)
   `uvm_object_utils_end


    constraint c_payload {
         payload.size==4;
         payload[0][4:0] == Type;
         payload[0][7:5] == FMT;
         payload[1][7] == T9;
         payload[1][5:4] == TC;
         payload[1][3] == T8;
         payload[1][2] == ATTR_2;
         payload[1][1] == LN;
         payload[1][0] == TH;
         payload[2][7] == TD;
         payload[2][6] == EP;
         payload[2][5:4] == ATTR_1;
         payload[2][3:2] == AT;
         payload[2][1:0] == LENGTH[9:8];
         payload[3] == LENGTH[7:0];
         
     }

     constraint c_type {
                solve TR_TYPE before FMT;
                solve TR_TYPE before Type;
                //Type == TR_TYPE == MRD ? 'b00000 : TR_TYPE == MRDLK ? 'b00001 :  TR_TYPE == MWR ? 'b00000 : TR_TYPE == IORD ? 'b00010 : TR_TYPE == IOWR ? 'b00010 : TR_TYPE == CFGR0 ? 'b00100 :  TR_TYPE == CFGWR0 ?  'b00100 : TR_TYPE == CFGRD1 ? 'b00101 : TR_TYPE == CFGWR1 ? 'b00101 : TR_TYPE == MSG ? 'b00101 : TR_TYPE == CPL ? 'b01010 : TR_TYPE == CPLD ? 'b01010 : TR_TYPE == CPL_LK ? 'b01011 : TR_TYPE == CPL_DLK ? 'b01011 : 'b00000;
               
                if(TR_TYPE == MRD)  {
                   Type == 'b00000;
                    FMT inside {'b000,'b001};
                }
                else if(TR_TYPE == MRDLK)  {
                   Type == 'b00001;
                   FMT inside {'b000,'b001};
                }
                else if(TR_TYPE == MWR)     {
                   Type == 'b00000;
                   FMT inside {'b010,'b011};
                }
                else if(TR_TYPE == IORD)    {
                   Type == 'b00010;
                   FMT inside {'b000};
                }
                else if(TR_TYPE == IOWR)    {
                   Type == 'b00010;
                   FMT inside {'b010};
                }
                else if(TR_TYPE == CFGR0)   {
                   Type == 'b00100;
                   FMT inside {'b000};
                }
                else if(TR_TYPE == CFGWR0)  {
                   Type == 'b00100;
                   FMT inside {'b010};
                }
                else if(TR_TYPE == CFGWR0)  {
                   Type == 'b00101;
                   FMT inside {'b010};
                }
                else if(TR_TYPE == CFGRD1)  {
                   Type == 'b00101;
                   FMT inside {'b000};
                }

               else if(TR_TYPE == CFGWR1)  {
                   Type == 'b00000;
                   FMT inside {'b010};
                }
               //else if(TR_TYPE == MSG)  {
                 //  FMT inside {'b010};
               // }
               else if(TR_TYPE == CPL)  {
                   Type == 'b01010;
                   FMT inside {'b000};
                }
               else if(TR_TYPE == CPLD)  {
                   Type == 'b01010;
                   FMT inside {'b010};
                }
               else if(TR_TYPE == CPL_LK)  {
                   Type == 'b01011;
                   FMT inside {'b000};
                }
               else if(TR_TYPE == CPL_DLK)  {
                   Type == 'b01011;
                   FMT inside {'b010};
                }

     }

         

      
    //-----------------------------------------------------------------
    //Decription :  This method is allocate memory space for this class
    //-----------------------------------------------------------------
    extern function new (string name = "pcie_header_pkt");
    extern virtual function void do_print(uvm_printer printer);


endclass :  pcie_header_pkt


    //-----------------------------------------------------------------
    //Decription :  This method is allocate memory space for this class
    //-----------------------------------------------------------------
    function pcie_header_pkt::new(string name = "pcie_header_pkt");
        super.new(name);
        
    endfunction :new

    function void pcie_header_pkt::do_print(uvm_printer printer);
        super.do_print(printer);
        //printer.print_field_int("LENGTH", LENGTH);
        //printer.print_string("LENGTH", $sformatf("%0d DW", LENGTH));
         //printer.print_string("m_name", "mny");
     endfunction : do_print




/*class pcie_pkt extends pcie_header_pkt ;
     // rand bit [15:0] REQUESTER_ID;
     // rand bit [7:0]  TAG;
     // rand bit [7:0] DW_BE;
      rand bit [7:0] ADDRESS[];
      rand bit [DATA_WIDTH-1:0] DATA[];
      rand  ph_t PH;
      rand bit [31:0] TLP_DIGEST [];
    
     `uvm_object_utils_begin(pcie_pkt)
       `uvm_field_enum     (ph_t, PH, UVM_ALL_ON)
       `uvm_field_array_int(DATA,UVM_ALL_ON)
       `uvm_field_array_int(ADDRESS,UVM_ALL_ON)
       `uvm_field_array_int(TLP_DIGEST,UVM_ALL_ON)
     
   `uvm_object_utils_end

     
     //consrtaint for tlp prefix is present or not 
     constraint c_tph {

         solve TH before TLP_PREFIX;
         solve TH before PH ;
         
         TLP_PREFIX.size()   == TH ? 4 : 0 ;
         
         if(TH == 0) {
           PH ==0;
           ST == 0 ;
         }
 
        if (TLP_PREFIX.size() >0) {
          TLP_PREFIX[1][7:0] ==  ST ;
        }
     }
       
     //3dw and 4dw data word address rules
    constraint c_addr {
                  solve FMT before ADDRESS;
                  if(FMT == DW3_HEADER_ND || FMT == DW3_HEADER_WD) {
                   ADDRESS.size() == 4;
                   //ADDRESS[0][0] == PH;
                  }
                  else {
                   ADDRESS.size() == 8;
                  // ADDRESS[0][0] == PH;
                  }
       }
    
     //rules for data payload , data present if with data packet initiate
     constraint c_data {
                   solve FMT before DATA;
                   solve LENGTH before DATA;
                  if(FMT == DW3_HEADER_WD || FMT == DW4_HEADER_WD) {
                     if(LENGTH>0) {
                       DATA.size() == LENGTH;
                     }
                     else {
                        DATA.size() == 'd1024;
                     }
                  }
                 else {
                   DATA.size() == 0;
                   
                 }
       }

       //Restriction while i/o trnasaction
       constraint c_io_tr {
                  solve TR_TYPE before LENGTH;
                  solve TR_TYPE before DW_BE;
                  if(TR_TYPE == IORD || TR_TYPE == IOWR) {
                   LENGTH == 1;
                   DW_BE[7:4] ==0;
                   ATTR_2 == DEFAULT;
                   ATTR_1 == DEFAULT_ORDER;
                   LN==0;
                   TH==0;
                   AT ==0;
                   TC ==0; 
                   ADDRESS[0][0] == PH;

                  }
                 }

        //Restriction while cfg trnasaction
       constraint c_cfg_tr {
                  solve TR_TYPE before LENGTH;
                  solve TR_TYPE before DW_BE;
                  if(TR_TYPE ==CFGR0 || TR_TYPE ==CFGWR0 || TR_TYPE ==CFGRD1 || TR_TYPE ==CFGWR1) {
                   LENGTH == 1;
                   DW_BE[7:4] ==0;
                   ATTR_2 == DEFAULT;
                   ATTR_1 == DEFAULT_ORDER;
                   LN==0;
                   TH==0;
                   AT ==0;
                   TC ==0;
                  }
                 }


    //-----------------------------------------------------------------
    //Decription :  This method is allocate memory space for this class
    //-----------------------------------------------------------------
    extern function new (string name = "pcie_pkt");
    extern virtual function void do_print(uvm_printer printer);
   // extern virtual function string convert2string();



endclass :  pcie_pkt


    //-----------------------------------------------------------------
    //Decription :  This method is allocate memory space for this class
    //-----------------------------------------------------------------
    function pcie_pkt::new(string name = "pcie_pkt");
        super.new(name);
        
    endfunction :new

    //-----------------------------------------------------------------
    //This Method used to add printing messages for this object
    //-----------------------------------------------------------------
    function void pcie_pkt::do_print(uvm_printer printer);
        super.do_print(printer);
         // foreach(ADDRESS[i]) begin
         //   printer.print_int($sformatf("ADDRESS2[%0d]", i), ADDRESS[i], $bits(ADDRESS[i]),UVM_HEX );
         //end
         //  foreach(DATA[i]) begin
         //   printer.print_int($sformatf("DATA2[%0d]", i), DATA[i], $bits(DATA[i]),UVM_HEX );
         //end
     endfunction*/
 
     


