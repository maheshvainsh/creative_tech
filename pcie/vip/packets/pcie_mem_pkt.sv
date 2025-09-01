
class pcie_mem_pkt extends pcie_header_pkt;

  // Factory Registration 
  `uvm_object_utils(pcie_mem_pkt)

    
  constraint tr_type { TR_TYPE inside {MRDLK,MRD,MWR} ;}
  
  constraint address_size { solve FMT before ADDRESS;
                            if(FMT inside {'b000,'b010}) {
                            ADDRESS.size() == 1;
                            }
                           else {
                               ADDRESS.size == 2;
                           }
                          }

    
  constraint data_size { solve TR_TYPE before DATA;
                         solve LENGTH before DATA;
                         solve FMT before DATA;
                         
                         if(TR_TYPE == MRD || TR_TYPE == MRDLK) {
                           DATA.size == 0;
                         } 
                         else if(TR_TYPE == MWR  ) { 
                          if(LENGTH !=0) {
                          DATA.size == LENGTH;
                          }
                         else {
                           DATA.size == 1024;
                        }
                        }
                       }
                      
  //-----------------------------------------------------------------
  //Decription :  This method is allocate memory space for this class
  //-----------------------------------------------------------------
  extern function new (string name = "pcie_mem_pkt");
  extern virtual function void do_print(uvm_printer printer);
  extern function void post_randomize();
              
endclass : pcie_mem_pkt

  //-----------------------------------------------------------------
  //Decription :  This method is allocate memory space for this class
  //-----------------------------------------------------------------
  function pcie_mem_pkt::new(string name = "pcie_mem_pkt");
      super.new(name);
      
  endfunction :new

  function void pcie_mem_pkt::do_print(uvm_printer printer);
      super.do_print(printer);
      //printer.print_field_int("LENGTH", LENGTH);
      //printer.print_string("LENGTH", $sformatf("%0d DW", LENGTH));
       //printer.print_string("m_name", "mny");
      
  endfunction : do_print

  function void pcie_mem_pkt::post_randomize(); 
    int  payload_data_index;
    int  payload_addr_index;
    bit [DATA_WIDTH-1:0] temp_data[];
    bit [31:0] temp_addr[];
 
    if(FMT == DW3_HEADER_WD)begin 
      payload= new[12+(DATA.size()*4)](payload);
      payload_data_index = 12;
      payload_addr_index = 8;
    end
    else if(FMT == DW4_HEADER_WD)begin
      payload= new[16+(DATA.size()*4)](payload);
      payload_data_index = 16;
      payload_addr_index = 8;
    end
     
     payload[4] =  REQUESTER_ID[15:8];
     payload[5] =  REQUESTER_ID[7:0];
     payload[6] =  TAG;
     payload[7][7:4] = DW_BE[7:4];
     payload[7][3:0] = DW_BE[3:0];
   
     for(int i=0; i<ADDRESS.size();i++)begin
       for(int j=($bits(ADDRESS[i])/8)-1; j>=0;j--)begin
         payload[payload_addr_index] = ADDRESS[i][j*8+:8];
         payload_addr_index++;
       end
     end
       
     for(int i=0; i<DATA.size(); i++)begin 
       for(int j= ($bits(DATA[i])/8)-1; j>=0;j++)begin
         payload[payload_data_index] = temp_data[i][j*8+:8];
         payload_data_index++;
       end
     end
      
  endfunction :post_randomize 



