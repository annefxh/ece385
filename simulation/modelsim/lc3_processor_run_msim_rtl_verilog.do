transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/register.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/4to1_mux.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/2to1_mux.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/tristate.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/zxt.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/bus.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/datapath.sv}
vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/slc3.sv}

vlog -sv -work work +incdir+C:/Users/Suicheng\ Zhan/Desktop/385/ece385 {C:/Users/Suicheng Zhan/Desktop/385/ece385/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
