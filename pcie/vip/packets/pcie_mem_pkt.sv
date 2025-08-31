
class pcie_mem_pkt extends pcie_header_pkt;

  rand bit [DATA_WIDTH-1:0] DATA[];

  // Factory Registration 
  `uvm_object_utils_begin(pcie_mem_pkt)
  `uvm_field_array_int(DATA,UVM_ALL_ON | UVM_HEX)
  `uvm_field_array_int(ADDRESS,UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end

   
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



