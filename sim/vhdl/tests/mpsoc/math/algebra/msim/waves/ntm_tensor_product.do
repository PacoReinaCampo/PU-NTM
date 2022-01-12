onerror {resume}

quietly WaveActivateNextPane {} 0

add wave -noupdate /ntm_algebra_pkg/MONITOR_TEST
add wave -noupdate /ntm_algebra_pkg/MONITOR_CASE

add wave -noupdate -divider {=========================================}
add wave -noupdate -divider {NTM TENSOR PRODUCT TEST}
add wave -noupdate -divider {=========================================}

add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/CLK
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/RST
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/START
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/SIZE_A_I_IN
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/SIZE_A_J_IN
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/SIZE_A_K_IN
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/SIZE_B_I_IN
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/SIZE_B_J_IN
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/SIZE_B_K_IN
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_IN_A_I_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_IN_A_J_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_IN_A_K_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_IN_B_I_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_IN_B_J_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_IN_B_K_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_IN
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/READY
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_OUT_I_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_OUT_J_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_OUT_K_ENABLE
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/DATA_OUT

add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/product_ctrl_fsm_int

add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/index_i_loop
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/index_j_loop
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/index_k_loop

add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_a_in_i_multiplier_int
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_a_in_j_multiplier_int
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_a_in_k_multiplier_int
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_b_in_i_multiplier_int
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_b_in_j_multiplier_int
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_b_in_k_multiplier_int

add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/start_scalar_adder
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/operation_scalar_adder
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_a_in_scalar_adder
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_b_in_scalar_adder
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/ready_scalar_adder
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_out_scalar_adder
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/overflow_out_scalar_adder

add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/start_scalar_multiplier
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_a_in_scalar_multiplier
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_b_in_scalar_multiplier
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/ready_scalar_multiplier
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/data_out_scalar_multiplier
add wave -noupdate /ntm_algebra_testbench/ntm_tensor_product_test/tensor_product/overflow_out_scalar_multiplier

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