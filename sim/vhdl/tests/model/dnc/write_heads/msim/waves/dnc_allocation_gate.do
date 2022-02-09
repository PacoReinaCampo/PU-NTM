onerror {resume}

quietly WaveActivateNextPane {} 0

add wave -noupdate /dnc_write_heads_pkg/MONITOR_TEST
add wave -noupdate /dnc_write_heads_pkg/MONITOR_CASE

add wave -noupdate -divider {=========================================}
add wave -noupdate -divider {NTM ALLOCATION GATE TEST}
add wave -noupdate -divider {=========================================}

add wave -noupdate /dnc_write_heads_testbench/dnc_allocation_gate_test/allocation_gate/CLK
add wave -noupdate /dnc_write_heads_testbench/dnc_allocation_gate_test/allocation_gate/RST
add wave -noupdate /dnc_write_heads_testbench/dnc_allocation_gate_test/allocation_gate/START
add wave -noupdate /dnc_write_heads_testbench/dnc_allocation_gate_test/allocation_gate/GA_IN
add wave -noupdate /dnc_write_heads_testbench/dnc_allocation_gate_test/allocation_gate/READY
add wave -noupdate /dnc_write_heads_testbench/dnc_allocation_gate_test/allocation_gate/GA_OUT

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1042309203 ps} 0} {{Cursor 2} {7446987402 ps} 0}
configure wave -namecolwidth 305
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1134027470 ps} {1150214364 ps}