import uvm_pkg::*;//compile uvm lib

`include "uvm_macros.svh"

`include "pcie_typedef.sv"

class pcie_header_pkt extends uvm_sequence_item ;

     //-------BYTE 0-----------------
     rand fmt_t FMT; 
     rand type_t TR_TYPE; 
     rand bit [4:0] Type;

     //-------BYTE 1-----------------
     bit T9 ; //reserved
     rand bit [2:0] TC; 
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
 
    `uvm_object_utils_begin(pcie_header_pkt)
     `uvm_field_enum     (fmt_t, FMT, UVM_ALL_ON)
     `uvm_field_enum     (type_t, TR_TYPE, UVM_ALL_ON)
     `uvm_field_int      (Type, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (T9, UVM_DEC|UVM_ALL_ON)
     `uvm_field_int      (TC, UVM_DEC|UVM_ALL_ON)
     `uvm_field_enum     (attr2_t, ATTR_2, UVM_ALL_ON)
     `uvm_field_int      (LN, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (TH, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (TD, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (EP, UVM_BIN|UVM_ALL_ON)
     `uvm_field_enum     (attr1_t, ATTR_1, UVM_ALL_ON)
     `uvm_field_int      (LN, UVM_BIN|UVM_ALL_ON)
     `uvm_field_int      (AT, UVM_BIN|UVM_ALL_ON)
    // `uvm_field_int      (LENGTH, UVM_DEC|UVM_ALL_ON)
    //`uvm_field_queue_int(data, UVM_ALL_ON)
    //`uvm_field_object   (ext,  UVM_ALL_ON)
    //`uvm_field_string   (str,  UVM_ALL_ON)
   `uvm_object_utils_end


     constraint c_type {
                solve TR_TYPE before FMT;
                solve TR_TYPE before Type;
                if(TR_TYPE == MRD)  {
                   Type == 'b00000;
                   soft FMT inside {'b000,'b001};
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
                   Type == 'b00100;
                   FMT inside {'b010};
                }
                else if(TR_TYPE == CFGRD1)  {
                   Type == 'b00101;
                   FMT inside {'b000};
                }

               else if(TR_TYPE == CFGWR1)  {
                   Type == 'b00101;
                   FMT inside {'b010};
                }
               //else if(TR_TYPE == MSG)  {
                 //  Type == 'b00101;
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
        printer.print_string("LENGTH", $sformatf("%0d DW", LENGTH));
         //printer.print_string("m_name", "mny");
     endfunction : do_print




class pcie_pkt extends pcie_header_pkt ;

      rand bit [15:0] REQUESTER_ID;
      rand bit [7:0]  TAG;
      rand bit [7:0] DW_BE;
      rand bit [31:0] ADDRESS[];
      rand bit [31:0] DATA[];
      rand  ph_t PH;

     `uvm_object_utils_begin(pcie_pkt)
     `uvm_field_int      (REQUESTER_ID, UVM_HEX|UVM_ALL_ON)
     `uvm_field_int      (TAG, UVM_HEX|UVM_ALL_ON)
     `uvm_field_int      (DW_BE, UVM_BIN|UVM_ALL_ON)
     `uvm_field_enum     (ph_t, PH, UVM_ALL_ON)
   
   `uvm_object_utils_end

     //3dw and 4dw data word address rules
    constraint c_addr {
                  solve FMT before ADDRESS;
                  if(FMT == DW3_HEADER_ND || FMT == DW3_HEADER_WD) {
                   ADDRESS.size() == 1;
                  }
                  else {
                   ADDRESS.size() == 2;
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
       /*constraint c_io_tr {
                  solve TR_TYPE before LENGTH;
                  solve TR_TYPE before DW_BE;
                  if(TR_TYPE == IORD || TR_TYPE == IOWR) {
                   LENGTH == 1;
                   DW_BE[7:4] ==0;
                   ATTR_2 == DEFAULT;
                   ATTR_1 == DEFAULT_ORDER;
                   LN==0;
                   TH==0;

                  }
                 }*/

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
          foreach(ADDRESS[i]) begin
            printer.print_int($sformatf("ADDRESS[%0d]", i), ADDRESS[i], $bits(ADDRESS[i]),UVM_HEX );
         end
           foreach(DATA[i]) begin
            printer.print_int($sformatf("DATA[%0d]", i), DATA[i], $bits(DATA[i]),UVM_HEX );
         end

     endfunction
 
     


