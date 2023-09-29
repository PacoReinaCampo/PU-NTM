@echo off
call ../../../../../../../settings64_msim.bat

vsim -c -do macros/run.do

vsim -view wlf/accelerator_scalar_integer_adder_test.wlf -do waves/accelerator_scalar_integer_adder.do
REM vsim -view wlf/accelerator_scalar_integer_multiplier.wlf -do waves/accelerator_scalar_integer_multiplier.do
REM vsim -view wlf/accelerator_scalar_integer_divider.wlf -do waves/accelerator_scalar_integer_divider.do
REM vsim -view wlf/accelerator_vector_integer_adder.wlf -do waves/accelerator_vector_integer_adder.do
REM vsim -view wlf/accelerator_vector_integer_multiplier.wlf -do waves/accelerator_vector_integer_multiplier.do
REM vsim -view wlf/accelerator_vector_integer_divider.wlf -do waves/accelerator_vector_integer_divider.do
REM vsim -view wlf/accelerator_matrix_integer_adder.wlf -do waves/accelerator_matrix_integer_adder.do
REM vsim -view wlf/accelerator_matrix_integer_multiplier.wlf -do waves/accelerator_matrix_integer_multiplier.do
REM vsim -view wlf/accelerator_matrix_integer_divider.wlf -do waves/accelerator_matrix_integer_divider.do
REM vsim -view wlf/accelerator_tensor_integer_adder.wlf -do waves/accelerator_tensor_integer_adder.do
REM vsim -view wlf/accelerator_tensor_integer_multiplier.wlf -do waves/accelerator_tensor_integer_multiplier.do
REM vsim -view wlf/accelerator_tensor_integer_divider.wlf -do waves/accelerator_tensor_integer_divider.do
pause
