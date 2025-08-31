LOGNAME=pcie
WLF=pcie
TEST=pcie_base_test

start :
	@echo 'welcome to pcie keep add commands here'
com :
	$(clean)
	vlog -sv +UVM_VERBOSITY=UVM_LOW +UVM_SET_CONFIG_INT=*,recording_detail,1 +UVM_TOPOLOGY +define+UVM_CMDLINE_NO_DPI +define+UVM_REGEX_NO_DPI +define+UVM_NO_REGISTERED_CONVERTER +incdir+$(UVM_HOME)/src +incdir+$(UVM_HOME)/src/uvm_pkg.sv   +incdir+$(VIP_DIR)/vip +incdir+$(VIP_DIR)/vip/pcie_pkg.sv +incdir+$(VIP_DIR)/common +incdir+$(VIP_DIR)/common/pcie_common_pkg.sv $(VIP_DIR)/top/pcie_top.sv 
sim :
	vsim -c -voptargs=+acc +UVM_VERBOSITY=UVM_LOW +UVM_SET_CONFIG_INT=*,recording_detail,1 +UVM_TOPOLOGY +UVM_TESTNAME=$(TEST) +define+UVM_HDL_NO_DPI +define+UVM_REGEX_NO_DPI +define+UVM_NO_REGISTERED_CONVERTER +incdir+$(UVM_HOME)/src  pcie_top -wlf "log/$(WLF).wlf" -logfile "log/$(LOGNAME).log" -do "set SolveArrayResizeMax 0 log -r /*;run -all;exit"


help :
	@echo  'Cleaning targets:'	
	@echo   LOGNAME		- add output user defined log name default :- pcie.log
	@echo   WLF		- pass wave file name default:- pcie.wlf
	@echo   TEST		- Pass test from command line default :- pcie_base_test
	@echo  'clean           - Remove most generated files but keep the config and'
	@echo  'com             - command for compile'
	@echo  'sim             - Command for simulate'
	@echo  'Configuration targets:'
	@echo  ''

clean : 
	rm -rf work
