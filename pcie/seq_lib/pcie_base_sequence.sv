//----------------------------------------------------------------------
// Project       : AUURORALANE
// File          : pcie_base_sequence.sv
//----------------------------------------------------------------------
// Created by    : MAHESH VANISH
//               : RUTVIK MAKWANA
// Creation Date : 2025-09-06
//----------------------------------------------------------------------
// Description   : 
//                 
//----------------------------------------------------------------------
`ifndef PCIE_BASE_SEQUENCE_SV
`define PCIE_BASE_SEQUENCE_SV

class pcie_base_sequence extends uvm_sequence#(master_pkt);
        pcie_mem_pkt m_pcie_mem_pkt;
        pcie_io_pkt  m_pcie_io_pkt;

       /*   pcie_cfg_pkt m_pcie_cfg_pkt;
          pcie_mem_pkt m_pcie_mem_pkt;
          pcie_io_pkt  m_pcie_io_pkt;
          pcie_msg_pkt  m_pcie_msg_pkt;
          pcie_comp_pkt  m_pcie_comp_pkt;*/
          master_pkt     m_master_pkt;
	`uvm_object_utils(pcie_base_sequence)
   
	//Constructor
	extern function new(string name = "pcie_base_sequence");
	extern virtual task body();

endclass : pcie_base_sequence


	 //Constructor
	function pcie_base_sequence::new(string name = "pcie_base_sequence");
	  super.new(name);
	endfunction

        task pcie_base_sequence::body();
           m_pcie_mem_pkt = pcie_mem_pkt::type_id::create("m_pcie_mem_pkt");
           m_pcie_io_pkt  = pcie_io_pkt::type_id::create("m_pcie_io_pkt");
  
          // assert(m_pcie_mem_pkt.randomize() with {TR_TYPE ==MRD;FMT == DW3_HEADER_WD;}); 
          // //assert(m_pcie_mem_pkt.randomize() with {TR_TYPE ==MWR;FMT == DW3_HEADER_WD;}); 
          // $cast(m_master_pkt, m_pcie_mem_pkt);
          

           assert(m_pcie_io_pkt.randomize() with {TR_TYPE ==IOWR;}); 
           $cast(m_master_pkt, m_pcie_io_pkt);
           m_master_pkt.print();

           //req = pcie_pkt::type_id::create("req");  //create the req (seq item)
          /*  m_pcie_cfg_pkt = pcie_cfg_pkt::type_id::create("m_pcie_cfg_pkt"); 
            m_pcie_mem_pkt = pcie_mem_pkt::type_id::create("m_pcie_mem_pkt"); 
            m_pcie_io_pkt  = pcie_io_pkt::type_id::create("m_pcie_io_pkt"); 
            m_pcie_msg_pkt  = pcie_msg_pkt::type_id::create("m_pcie_msg_pkt"); 
            m_pcie_comp_pkt  = pcie_comp_pkt::type_id::create("m_pcie_comp_pkt"); 
           assert(m_pcie_cfg_pkt.randomize() ); 
           assert(m_pcie_mem_pkt.randomize() ); 
           assert(m_pcie_io_pkt.randomize() ); 
           assert(m_pcie_msg_pkt.randomize() ); 
           assert(m_pcie_comp_pkt.randomize() ); 
           /*m_pcie_cfg_pkt.print();
           m_pcie_mem_pkt.print();
           m_pcie_io_pkt.print();
           m_pcie_msg_pkt.print();
           m_pcie_comp_pkt.print();*/

          // $cast(m_master_pkt, m_pcie_mem_pkt);
           //req.print();
                      //randomize the req                    
           //send_request(req);                           //send req to driver
           //wait_for_item_done();                        //wait for item done from driver
          // get_response(rsp);                           //get response from driver
       
         endtask
`endif //PCIE_BASE_SEQUENCE_SV
