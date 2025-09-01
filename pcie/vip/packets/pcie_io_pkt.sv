`ifndef PCIE_IO_PKT_SV
`define PCIE_IO_PKT_SV
class pcie_io_pkt extends pcie_header_pkt;

 //Factory Registration
 `uvm_object_utils(pcie_io_pkt)

 constraint tr_type { TR_TYPE inside {IORD,IOWR};}

 constraint address_size {solve FMT before ADDRESS;
                           if(FMT inside {'b000,'b010}) 
                           { ADDRESS.size==1;
                           }
                         } 
 constraint length_size { solve FMT before LENGTH;
                          if(FMT inside {'b000,'b010}){ LENGTH==1;}
                        }

 constraint data_size   { solve TR_TYPE before DATA;
                          solve FMT before DATA;
                          solve LENGTH before DATA; 
                          if(TR_TYPE == IORD)
                           { 
                            DATA.size == 0;
                            TC[2:0] == 0;
                            ATTR_1 == DEFAULT_ORDER;
                            ATTR_2 == DEFAULT;
                            AT == 0;
                            DW_BE[7:4] ==0;   
                            TH==0;
                            ADDRESS[0][1:0] ==0;       
                           }
                          else if(TR_TYPE == IOWR)
                          { TC[2:0] == 0;
                            ATTR_1 == 0;
                            AT == 0;
                            DW_BE[7:4] ==0;   
                            TH==0;            
                            DATA.size == LENGTH;
                            ADDRESS[0][1:0] ==0;       
                          }
                        }
 

  //-----------------------------------------------------------------
  //Decription :  This method is allocate memory space for this class
  //-----------------------------------------------------------------
   extern function new(string name="pcie_io_pkt");
   extern virtual function void do_print(uvm_printer printer);
   extern function void post_randomize();

endclass :pcie_io_pkt

  //-----------------------------------------------------------------
  //Decription :  This method is allocate memory space for this class
  //-----------------------------------------------------------------
  function pcie_io_pkt::new(string name ="pcie_io_pkt");
    super.new(name);
  endfunction :new

  
  function void pcie_io_pkt::do_print(uvm_printer printer);
    super.do_print(printer);
  endfunction : do_print

  function void pcie_io_pkt::post_randomize();
   int payload_addr_index;
   int payload_data_index;

   if(TR_TYPE == IOWR) 
     payload= new[16](payload);
   else
     payload= new[12](payload);
   payload[4] =  REQUESTER_ID[15:8];
   payload[5] =  REQUESTER_ID[7:0];
   payload[6] =  TAG;
   payload[7][7:4] = DW_BE[7:4];
   payload[7][3:0] = DW_BE[3:0];
   payload_addr_index = 8;
   payload_data_index =12;
   
   for(int i=($bits(ADDRESS[0])/8)-1; i>=0;i--)begin
     payload[payload_addr_index] = ADDRESS[0][i*8+:8];
     $display("Addr = %0d",payload_addr_index);
     payload_addr_index++;      
   end
   
   if(payload.size>12) begin
      for(int i=($bits(DATA[0])/8)-1; i>=0;i--)begin
     payload[payload_data_index] = DATA[0][i*8+:8];
     $display("DATA = %0d",payload_data_index);
     payload_data_index++;      
   end

  end
      
  endfunction :post_randomize 

`endif //PCIE_IO_PKT_SV

