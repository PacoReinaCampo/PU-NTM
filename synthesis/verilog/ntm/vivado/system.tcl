###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              Peripheral-NTM for MPSoC                                         ##
##              Neural Turing Machine for MPSoC                                  ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2021-2022 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Francisco Javier Reina Campo <pacoreinacampo@queenfield.tech>               ##
##                                                                               ##
###################################################################################

read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/scalar/accelerator_scalar_float_adder.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/scalar/accelerator_scalar_float_multiplier.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/scalar/accelerator_scalar_float_divider.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/vector/accelerator_vector_float_adder.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/vector/accelerator_vector_float_multiplier.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/vector/accelerator_vector_float_divider.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/matrix/accelerator_matrix_float_adder.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/matrix/accelerator_matrix_float_multiplier.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/arithmetic/float/matrix/accelerator_matrix_float_divider.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/vector/accelerator_dot_product.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/vector/accelerator_vector_convolution.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/vector/accelerator_vector_cosine_similarity.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/vector/accelerator_vector_multiplication.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/vector/accelerator_vector_summation.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/vector/accelerator_vector_module.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_convolution.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_inverse.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_multiplication.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_product.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_summation.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_transpose.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_vector_convolution.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/matrix/accelerator_matrix_vector_product.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/tensor/accelerator_tensor_convolution.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/tensor/accelerator_tensor_inverse.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/tensor/accelerator_tensor_matrix_convolution.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/tensor/accelerator_tensor_matrix_product.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/tensor/accelerator_tensor_product.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/algebra/tensor/accelerator_tensor_transpose.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_differentiation.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_integration.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_softmax.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_differentiation.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_integration.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_softmax.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/tensor/accelerator_tensor_differentiation.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/tensor/accelerator_tensor_integration.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/tensor/accelerator_tensor_softmax.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/scalar/accelerator_scalar_logistic_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/scalar/accelerator_scalar_oneplus_function.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_logistic_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_oneplus_function.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_logistic_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_oneplus_function.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/scalar/accelerator_scalar_cosh_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/scalar/accelerator_scalar_exponentiator_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/scalar/accelerator_scalar_logarithm_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/scalar/accelerator_scalar_sinh_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/scalar/accelerator_scalar_tanh_function.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_cosh_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_exponentiator_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_logarithm_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_sinh_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/vector/accelerator_vector_tanh_function.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_cosh_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_exponentiator_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_logarithm_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_sinh_function.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/math/matrix/accelerator_matrix_tanh_function.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/trainer/lstm/accelerator_activation_trainer.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/trainer/lstm/accelerator_forget_trainer.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/trainer/lstm/accelerator_input_trainer.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/trainer/lstm/accelerator_output_trainer.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/nn/lstm/convolutional/accelerator_controller.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/lstm/convolutional/accelerator_activation_gate_vector.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/lstm/convolutional/accelerator_forget_gate_vector.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/lstm/convolutional/accelerator_hidden_gate_vector.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/lstm/convolutional/accelerator_input_gate_vector.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/lstm/convolutional/accelerator_output_gate_vector.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/lstm/convolutional/accelerator_state_gate_vector.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/read_heads/accelerator_reading.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/write_heads/accelerator_writing.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/write_heads/accelerator_erasing.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/memory/accelerator_addressing.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/memory/accelerator_content_based_addressing.sv

read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/top/accelerator_interface_vector.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/top/accelerator_output_vector.sv
read_verilog -sv ../../../../../../../rtl/verilog/code/nn/ntm/top/accelerator_top.sv

read_verilog -sv accelerator_top_synthesis.sv

read_xdc system.xdc

synth_design -part xc7z020-clg484-1 -include_dirs ../../../../../../../rtl/verilog/code/pkg -top accelerator_top_synthesis

opt_design
place_design
route_design

report_utilization
report_timing

write_edif -force system.edif
write_bitstream -force system.bit
