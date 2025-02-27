#command for complie ex
com : 
	echo "=======================compling start========================"
	vlog hello_world.sv
	echo "=======================compling done========================="
	echo "=======================start simulating======================"
	vsim -c tb -logfile hello_world.log -do "run -all; exit"
	echo "=======================end simulating========================"

#run :  com
