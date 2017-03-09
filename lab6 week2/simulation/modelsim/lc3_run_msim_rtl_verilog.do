transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/tristate.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/register.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/bus.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/4to1_mux.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/2to1_mux.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/alu.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/regfile.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/sext.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/ben.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/benlogic.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/datapath.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/slc3.sv}

vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385/lab6\ week2 {C:/Users/Suicheng Zhan/Desktop/385/ece385/lab6 week2/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
