@echo off
call ../../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../../model/vhdl/pkg/model_arithmetic_pkg.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/pkg/model_math_pkg.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/scalar/model_scalar_float_adder.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/scalar/model_scalar_float_multiplier.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/scalar/model_scalar_float_divider.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/vector/model_vector_float_adder.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/vector/model_vector_float_multiplier.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/vector/model_vector_float_divider.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/matrix/model_matrix_float_adder.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/matrix/model_matrix_float_multiplier.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/matrix/model_matrix_float_divider.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/scalar/model_scalar_float_adder.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/scalar/model_scalar_float_multiplier.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/scalar/model_scalar_float_divider.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/vector/model_vector_float_adder.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/vector/model_vector_float_multiplier.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/vector/model_vector_float_divider.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/matrix/model_matrix_float_adder.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/matrix/model_matrix_float_multiplier.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/arithmetic/float/matrix/model_matrix_float_divider.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/vector/model_vector_differentiation.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/vector/model_vector_integration.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/vector/model_vector_softmax.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/matrix/model_matrix_differentiation.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/matrix/model_matrix_integration.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/matrix/model_matrix_softmax.vhd

ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/tensor/model_tensor_differentiation.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/tensor/model_tensor_integration.vhd
ghdl -a --std=08 ../../../../../../../model/vhdl/math/calculus/tensor/model_tensor_softmax.vhd

ghdl -a --std=08 ../../../../../../../bench/vhdl/tests/model/math/calculus/model_calculus_pkg.vhd
ghdl -a --std=08 ../../../../../../../bench/vhdl/tests/model/math/calculus/model_calculus_stimulus.vhd
ghdl -a --std=08 ../../../../../../../bench/vhdl/tests/model/math/calculus/model_calculus_testbench.vhd
ghdl -m --std=08 model_calculus_testbench
ghdl -r --std=08 model_calculus_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > model_calculus_testbench.tree
pause