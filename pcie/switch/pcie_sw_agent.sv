class pcie_sw_agent extends uvm_agent;
   `uvm_component_utils (pcie_sw_agent)

   pcie_sw_driver                   m_pcie_sw_driver;
   pcie_sw_monitor                  m_pcie_sw_monitor;
   pcie_sw_sequencer                m_pcie_sw_sequencer;

   function new (string name = "pcie_sw_agent", uvm_component parent=null);
      super.new (name, parent);
   endfunction

   // If Agent is Active, create Driver and Sequencer, else skip
   // Always create Monitor regardless of Agent's nature

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
       m_pcie_sw_driver = pcie_sw_driver::type_id::create ("m_pcie_sw_driver", this);
       m_pcie_sw_monitor = pcie_sw_monitor::type_id::create ("m_pcie_sw_monitor", this);
       m_pcie_sw_sequencer = pcie_sw_sequencer::type_id::create ("m_pcie_sw_sequencer", this);

		// uvm_config_db #(agent_cfg) :: get (this, "*", "pcie_sw_agent", m_agt_cfg);

     /* if (get_is_active()) begin
         m_seqr0 = uvm_sequencer#(my_data)::type_id::create ("m_seqr0", this);
         m_drv0 = my_driver::type_id::create ("m_drv0", this);
         m_drv0.vif = m_agt_cfg.vif;
      end
      m_mon0 = my_monitor::type_id::create ("m_mon0", this);

      m_mon0.vif = m_agt_cfg.vif;*/
   endfunction

	  // Connect Sequencer to Driver, if the agent is active

   virtual function void connect_phase (uvm_phase phase);
     /* if (get_is_active())
         m_drv0.seq_item_port.connect (m_seqr0.seq_item_export);*/
   endfunction
endclass : pcie_sw_agent
