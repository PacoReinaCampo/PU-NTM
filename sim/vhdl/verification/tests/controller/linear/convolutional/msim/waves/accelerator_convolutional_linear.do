onerror {resume}

quietly WaveActivateNextPane {} 0

add wave -noupdate /accelerator_convolutional_linear_pkg/MONITOR_TEST
add wave -noupdate /accelerator_convolutional_linear_pkg/MONITOR_CASE

add wave -noupdate -divider {=========================================}
add wave -noupdate -divider {NTM STANDARD LINEAR TEST}
add wave -noupdate -divider {=========================================}

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/CLK
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/RST

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/START

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/SIZE_X_IN
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/SIZE_L_IN

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/W_IN_L_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/W_IN_X_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/W_IN
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_w_in_enable_int
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/W_OUT_L_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_l_w_in_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/W_OUT_X_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_x_w_in_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/B_IN_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/B_IN
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_b_in_enable_int
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/B_OUT_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_l_b_in_loop

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/X_IN_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/X_IN
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/X_OUT_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_x_x_in_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_x_in_enable_int

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/READY
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/H_OUT_ENABLE
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_l_h_out_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/H_OUT

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/start_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/operation_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/size_in_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_a_in_enable_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_a_in_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_b_in_enable_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_b_in_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/ready_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_vector_float_adder_enable_int
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_out_enable_vector_float_adder
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_vector_float_adder_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_out_vector_float_adder

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/start_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/size_a_i_in_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/size_a_j_in_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/size_b_in_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_a_in_i_enable_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_a_in_j_enable_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_a_in_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_b_in_enable_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_b_in_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_i_enable_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_i_matrix_vector_convolution_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_j_enable_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_j_matrix_vector_convolution_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/ready_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_matrix_vector_convolution_enable_int
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_out_enable_matrix_vector_convolution
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_out_matrix_vector_convolution

add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/start_vector_logistic
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/size_in_vector_logistic
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_in_enable_vector_logistic
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_in_vector_logistic
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/ready_vector_logistic
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_vector_logistic_enable_int
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_out_enable_vector_logistic
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/index_vector_logistic_loop
add wave -noupdate /accelerator_convolutional_linear_testbench/accelerator_convolutional_linear_test/controller/data_out_vector_logistic

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
