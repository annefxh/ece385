onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testbench/S
add wave -noupdate -radix hexadecimal /testbench/Clk
add wave -noupdate -radix hexadecimal /testbench/Reset
add wave -noupdate -radix hexadecimal /testbench/Run
add wave -noupdate -radix hexadecimal /testbench/Continue
add wave -noupdate -radix hexadecimal /testbench/LED
add wave -noupdate -radix hexadecimal /testbench/ADDR
add wave -noupdate -radix hexadecimal /testbench/Data
add wave -noupdate -radix hexadecimal /testbench/slc3/state_controller/State
add wave -noupdate -label pc -radix hexadecimal /testbench/slc3/D0/pc_reg/out
add wave -noupdate -label LED -radix hexadecimal /testbench/slc3/D0/led/data
add wave -noupdate -label LED_out -radix hexadecimal /testbench/slc3/D0/led/out
add wave -noupdate -label IR -radix hexadecimal /testbench/slc3/D0/ir_reg/data
add wave -noupdate -label reg_file -radix hexadecimal /testbench/slc3/D0/register_file/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4250142 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4002500 ps} {5052500 ps}
