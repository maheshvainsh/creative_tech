start :
	@echo 'welcome to pcie keep add commands here'
com :
	vlog -sv +define+UVM_CMDLINE_NO_DPI +define+UVM_REGEX_NO_DPI +define+UVM_NO_REGISTERED_CONVERTER +incdir+$(UVM_HOME)/src +incdir+$(UVM_HOME)/src/uvm_pkg.sv +incdir+$(VIP_DIR)/rc +incdir+$(VIP_DIR)/common +incdir+$(VIP_DIR)/common/pcie_common_pkg.sv $(VIP_DIR)/top/pcie_top.sv 
sim :
	vsim -c -voptargs=+acc +define+UVM_HDL_NO_DPI +define+UVM_REGEX_NO_DPI +define+UVM_NO_REGISTERED_CONVERTER +incdir+$(UVM_HOME)/src  pcie_top -wlf i2c.wlf -logfile i2c.log -do "set SolveArrayResizeMax 0 log -r /*;run -all;exit"


help :
	@echo  'Cleaning targets:'
	@echo  'clean           - Remove most generated files but keep the config and'
	@echo  'compile         - command for compile'
	@echo  'simulate        - Command for simulate'
	@echo  'Configuration targets:'
	@echo  ''
