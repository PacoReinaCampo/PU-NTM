// File vhdl/controller/FNN/standard/ntm_trainer.vhd translated with vhd2vl v2.5 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 1995

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002, 2005, 2008-2010, 2015 Larry Doolittle - LBNL
//     http://doolittle.icarus.com/~larry/vhd2vl/
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

//------------------------------------------------------------------------------
//                                            __ _      _     _               --
//                                           / _(_)    | |   | |              --
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              --
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              --
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              --
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              --
//                  | |                                                       --
//                  |_|                                                       --
//                                                                            --
//                                                                            --
//              Peripheral-NTM for MPSoC                                      --
//              Neural Turing Machine for MPSoC                               --
//                                                                            --
//------------------------------------------------------------------------------
// Copyright (c) 2020-2021 by the author(s)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------
// Author(s):
//   Paco Reina Campo <pacoreinacampo@queenfield.tech>
// no timescale needed

module ntm_trainer(
CLK,
RST,
START,
READY,
H_IN_ENABLE,
X_IN_ENABLE,
W_OUT_L_ENABLE,
W_OUT_X_ENABLE,
K_OUT_I_ENABLE,
K_OUT_L_ENABLE,
K_OUT_K_ENABLE,
B_OUT_ENABLE,
SIZE_X_IN,
SIZE_W_IN,
SIZE_L_IN,
SIZE_R_IN,
H_IN,
X_IN,
W_OUT,
K_OUT,
B_OUT
);

parameter [31:0] DATA_SIZE=512;
// GLOBAL
input CLK;
input RST;
// CONTROL
input START;
output READY;
input H_IN_ENABLE;
// for l in 0 to L-1
input X_IN_ENABLE;
// for l in 0 to L-1
output W_OUT_L_ENABLE;
// for l in 0 to L-1
output W_OUT_X_ENABLE;
// for x in 0 to X-1
output K_OUT_I_ENABLE;
// for i in 0 to R-1 (read heads flow)
output K_OUT_L_ENABLE;
// for l in 0 to L-1
output K_OUT_K_ENABLE;
// for k in 0 to W-1
output B_OUT_ENABLE;
// for l in 0 to L-1
// DATA
input [DATA_SIZE - 1:0] SIZE_X_IN;
input [DATA_SIZE - 1:0] SIZE_W_IN;
input [DATA_SIZE - 1:0] SIZE_L_IN;
input [DATA_SIZE - 1:0] SIZE_R_IN;
input [DATA_SIZE - 1:0] H_IN;
input [DATA_SIZE - 1:0] X_IN;
output [DATA_SIZE - 1:0] W_OUT;
output [DATA_SIZE - 1:0] K_OUT;
output [DATA_SIZE - 1:0] B_OUT;

wire CLK;
wire RST;
wire START;
wire READY;
wire H_IN_ENABLE;
wire X_IN_ENABLE;
wire W_OUT_L_ENABLE;
wire W_OUT_X_ENABLE;
wire K_OUT_I_ENABLE;
wire K_OUT_L_ENABLE;
wire K_OUT_K_ENABLE;
wire B_OUT_ENABLE;
wire [DATA_SIZE - 1:0] SIZE_X_IN;
wire [DATA_SIZE - 1:0] SIZE_W_IN;
wire [DATA_SIZE - 1:0] SIZE_L_IN;
wire [DATA_SIZE - 1:0] SIZE_R_IN;
wire [DATA_SIZE - 1:0] H_IN;
wire [DATA_SIZE - 1:0] X_IN;
wire [DATA_SIZE - 1:0] W_OUT;
wire [DATA_SIZE - 1:0] K_OUT;
wire [DATA_SIZE - 1:0] B_OUT;


//---------------------------------------------------------------------
// Types
//---------------------------------------------------------------------
//---------------------------------------------------------------------
// Constants
//---------------------------------------------------------------------
//---------------------------------------------------------------------
// Signals
//---------------------------------------------------------------------
// VECTOR SUMMATION
// CONTROL
wire start_vector_summation;
wire ready_vector_summation;
wire data_in_vector_enable_vector_summation;
wire data_in_scalar_enable_vector_summation;
wire data_out_vector_enable_vector_summation;
wire data_out_scalar_enable_vector_summation;  // DATA
wire [DATA_SIZE - 1:0] modulo_in_vector_summation;
wire [DATA_SIZE - 1:0] size_in_vector_summation;
wire [DATA_SIZE - 1:0] length_in_vector_summation;
wire [DATA_SIZE - 1:0] data_in_vector_summation;
wire [DATA_SIZE - 1:0] data_out_vector_summation;  // MATRIX PRODUCT
// CONTROL
wire start_matrix_product;
wire ready_matrix_product;
wire data_a_in_i_enable_matrix_product;
wire data_a_in_j_enable_matrix_product;
wire data_b_in_i_enable_matrix_product;
wire data_b_in_j_enable_matrix_product;
wire data_out_i_enable_matrix_product;
wire data_out_j_enable_matrix_product;  // DATA
wire [DATA_SIZE - 1:0] modulo_in_matrix_product;
wire [DATA_SIZE - 1:0] size_a_i_in_matrix_product;
wire [DATA_SIZE - 1:0] size_a_j_in_matrix_product;
wire [DATA_SIZE - 1:0] size_b_i_in_matrix_product;
wire [DATA_SIZE - 1:0] size_b_j_in_matrix_product;
wire [DATA_SIZE - 1:0] data_a_in_matrix_product;
wire [DATA_SIZE - 1:0] data_b_in_matrix_product;
wire [DATA_SIZE - 1:0] data_out_matrix_product;

  //---------------------------------------------------------------------
  // Body
  //---------------------------------------------------------------------
  // dW(t;l) = summation(dx(t;l) · x(t;l))[t in 0 to T]
  // dU(t;l) = summation(dx(t+1;l) · h(t;l))[t in 0 to T-1]
  // db(t;l) = summation(dx(t;l))[t in 0 to T]
  // VECTOR SUMMATION
  ntm_vector_summation_function #(
      .DATA_SIZE(DATA_SIZE))
  vector_summation_function(
      // GLOBAL
    .CLK(CLK),
    .RST(RST),
    // CONTROL
    .START(start_vector_summation),
    .READY(ready_vector_summation),
    .DATA_IN_VECTOR_ENABLE(data_in_vector_enable_vector_summation),
    .DATA_IN_SCALAR_ENABLE(data_in_scalar_enable_vector_summation),
    .DATA_OUT_VECTOR_ENABLE(data_out_vector_enable_vector_summation),
    .DATA_OUT_SCALAR_ENABLE(data_out_scalar_enable_vector_summation),
    // DATA
    .MODULO_IN(modulo_in_vector_summation),
    .SIZE_IN(size_in_vector_summation),
    .LENGTH_IN(length_in_vector_summation),
    .DATA_IN(data_in_vector_summation),
    .DATA_OUT(data_out_vector_summation));

  // MATRIX PRODUCT
  ntm_matrix_product #(
      .DATA_SIZE(DATA_SIZE))
  matrix_product(
      // GLOBAL
    .CLK(CLK),
    .RST(RST),
    // CONTROL
    .START(start_matrix_product),
    .READY(ready_matrix_product),
    .DATA_A_IN_I_ENABLE(data_a_in_i_enable_matrix_product),
    .DATA_A_IN_J_ENABLE(data_a_in_j_enable_matrix_product),
    .DATA_B_IN_I_ENABLE(data_b_in_i_enable_matrix_product),
    .DATA_B_IN_J_ENABLE(data_b_in_j_enable_matrix_product),
    .DATA_OUT_I_ENABLE(data_out_i_enable_matrix_product),
    .DATA_OUT_J_ENABLE(data_out_j_enable_matrix_product),
    // DATA
    .MODULO_IN(modulo_in_matrix_product),
    .SIZE_A_I_IN(size_a_i_in_matrix_product),
    .SIZE_A_J_IN(size_a_j_in_matrix_product),
    .SIZE_B_I_IN(size_b_i_in_matrix_product),
    .SIZE_B_J_IN(size_b_j_in_matrix_product),
    .DATA_A_IN(data_a_in_matrix_product),
    .DATA_B_IN(data_b_in_matrix_product),
    .DATA_OUT(data_out_matrix_product));


endmodule
