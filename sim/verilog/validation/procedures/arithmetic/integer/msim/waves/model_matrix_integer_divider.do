onerror {resume}

quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {=========================================}
add wave -noupdate -divider {NTM MATRIX INTEGER DIVIDER TEST}
add wave -noupdate -divider {=========================================}

add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/CLK
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/RST
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/START
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/SIZE_I_IN
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/SIZE_J_IN
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_A_IN_I_ENABLE
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_A_IN_J_ENABLE
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_A_IN
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_B_IN_I_ENABLE
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_B_IN_J_ENABLE
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_B_IN
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/READY
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_OUT_I_ENABLE
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/index_i_loop
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_OUT_J_ENABLE
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/index_j_loop
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/DATA_OUT
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/REMAINDER_OUT

add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/divider_ctrl_fsm_int

add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/start_scalar_integer_divider
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/data_a_in_i_divider_int
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/data_a_in_j_divider_int
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/data_a_in_scalar_integer_divider
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/data_b_in_i_divider_int
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/data_b_in_j_divider_int
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/data_b_in_scalar_integer_divider
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/ready_scalar_integer_divider
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/data_out_scalar_integer_divider
add wave -noupdate /model_integer_testbench/model_matrix_integer_divider_test/matrix_integer_divider/remainder_out_scalar_integer_divider

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
