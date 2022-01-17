@echo off
call ../../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../../rtl/vhdl/pkg/ntm_arithmetic_pkg.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/pkg/ntm_math_pkg.vhd

ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/scalar/ntm_scalar_integer_adder.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/scalar/ntm_scalar_integer_multiplier.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/scalar/ntm_scalar_integer_divider.vhd

ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/vector/ntm_vector_integer_adder.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/vector/ntm_vector_integer_multiplier.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/vector/ntm_vector_integer_divider.vhd

ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/matrix/ntm_matrix_integer_adder.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/matrix/ntm_matrix_integer_multiplier.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/integer/matrix/ntm_matrix_integer_divider.vhd

ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/scalar/ntm_scalar_adder.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/scalar/ntm_scalar_multiplier.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/scalar/ntm_scalar_divider.vhd

ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/vector/ntm_vector_adder.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/vector/ntm_vector_multiplier.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/vector/ntm_vector_divider.vhd

ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/matrix/ntm_matrix_adder.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/matrix/ntm_matrix_multiplier.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/arithmetic/float/matrix/ntm_matrix_divider.vhd

ghdl -a --std=08 ../../../../../../../rtl/vhdl/math/calculus/scalar/ntm_scalar_differentiation.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/math/calculus/vector/ntm_vector_differentiation.vhd
ghdl -a --std=08 ../../../../../../../rtl/vhdl/math/calculus/matrix/ntm_matrix_differentiation.vhd

ghdl -a --std=08 ../../../../../../../bench/vhdl/tests/math/calculus/ntm_calculus_pkg.vhd
ghdl -a --std=08 ../../../../../../../bench/vhdl/tests/math/calculus/ntm_calculus_stimulus.vhd
ghdl -a --std=08 ../../../../../../../bench/vhdl/tests/math/calculus/ntm_calculus_testbench.vhd

ghdl -m --std=08 ntm_calculus_testbench
ghdl -r --std=08 ntm_calculus_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > ntm_calculus_testbench.tree
pause
