class pcie_base_sequence extends uvm_sequence#(pcie_pkt);
  
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
           req = pcie_pkt::type_id::create("req");  //create the req (seq item)
           assert(req.randomize() with {LENGTH==1;FMT == DW4_HEADER_WD;}); 
           req.print();
                      //randomize the req                    
           //send_request(req);                           //send req to driver
           //wait_for_item_done();                        //wait for item done from driver
          // get_response(rsp);                           //get response from driver
       
         endtask

