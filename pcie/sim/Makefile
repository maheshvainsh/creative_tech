LOGNAME=pcie
WLF=pcie

start :
	@echo 'welcome to pcie keep add commands here'
com :
	$(clean)
	vlog -sv +define+UVM_CMDLINE_NO_DPI +define+UVM_REGEX_NO_DPI +define+UVM_NO_REGISTERED_CONVERTER +incdir+$(UVM_HOME)/src +incdir+$(UVM_HOME)/src/uvm_pkg.sv +incdir+$(VIP_DIR)/vip +incdir+$(VIP_DIR)/vip/pcie_pkg.sv +incdir+$(VIP_DIR)/common +incdir+$(VIP_DIR)/common/pcie_common_pkg.sv $(VIP_DIR)/top/pcie_top.sv 
sim :
	vsim -c -voptargs=+acc +define+UVM_HDL_NO_DPI +define+UVM_REGEX_NO_DPI +define+UVM_NO_REGISTERED_CONVERTER +incdir+$(UVM_HOME)/src  pcie_top -wlf "log/$(WLF).wlf" -logfile "log/$(LOGNAME).log" -do "set SolveArrayResizeMax 0 log -r /*;run -all;exit"


help :
	@echo  'Cleaning targets:'	
	@echo   LOGNAME         - add output user defined log name 
	@echo  'clean           - Remove most generated files but keep the config and'
	@echo  'compile         - command for compile'
	@echo  'simulate        - Command for simulate'
	@echo  'Configuration targets:'
	@echo  ''

clean : 
	rm -rf work
