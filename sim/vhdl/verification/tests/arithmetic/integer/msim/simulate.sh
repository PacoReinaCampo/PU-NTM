source ../../../../../../../settings64_msim.sh

make clean
make build

make simulate TARGET=accelerator_scalar_integer_adder
#make simulate TARGET=accelerator_scalar_integer_multiplier
#make simulate TARGET=accelerator_scalar_integer_divider
#make simulate TARGET=accelerator_vector_integer_adder
#make simulate TARGET=accelerator_vector_integer_multiplier
#make simulate TARGET=accelerator_vector_integer_divider
#make simulate TARGET=accelerator_matrix_integer_adder
#make simulate TARGET=accelerator_matrix_integer_multiplier
#make simulate TARGET=accelerator_matrix_integer_divider
#make simulate TARGET=accelerator_tensor_integer_adder
#make simulate TARGET=accelerator_tensor_integer_multiplier
#make simulate TARGET=accelerator_tensor_integer_divider
