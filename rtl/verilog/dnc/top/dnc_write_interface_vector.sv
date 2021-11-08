////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              Peripheral-NTM for MPSoC                                      //
//              Neural Turing Machine for MPSoC                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////
// Author(s):
//   Paco Reina Campo <pacoreinacampo@queenfield.tech>

module dnc_write_interface_vector #(
  parameter DATA_SIZE=512
)
  (
    // GLOBAL
    input CLK,
    input RST,

    // CONTROL
    input START,
    output reg READY,

    // Write Key
    input WK_IN_L_ENABLE,  // for l in 0 to L-1
    input WK_IN_K_ENABLE,  // for k in 0 to W-1
    output reg K_OUT_ENABLE,  // for k in 0 to W-1

    // Write Strength
    input WBETA_IN_ENABLE,  // for l in 0 to L-1

    // Erase Vector
    input WE_IN_L_ENABLE,  // for l in 0 to L-1
    input WE_IN_K_ENABLE,  // for k in 0 to W-1
    output reg E_OUT_ENABLE,  // for k in 0 to W-1

    // Write Vector
    input WV_IN_L_ENABLE,  // for l in 0 to L-1
    input WV_IN_K_ENABLE,  // for k in 0 to W-1
    output reg V_OUT_ENABLE,  // for k in 0 to W-1

    // Allocation Gate
    input WGA_IN_ENABLE,  // for l in 0 to L-1

    // Write Gate
    input WGW_IN_ENABLE,  // for l in 0 to L-1

    // Hidden State
    input H_IN_ENABLE,  // for l in 0 to L-1

    // DATA
    input [DATA_SIZE-1:0] SIZE_W_IN,
    input [DATA_SIZE-1:0] SIZE_L_IN,
    input [DATA_SIZE-1:0] SIZE_R_IN,
    input [DATA_SIZE-1:0] WK_IN,
    input [DATA_SIZE-1:0] WBETA_IN,
    input [DATA_SIZE-1:0] WE_IN,
    input [DATA_SIZE-1:0] WV_IN,
    input [DATA_SIZE-1:0] WGA_IN,
    input [DATA_SIZE-1:0] WGW_IN,
    input [DATA_SIZE-1:0] H_IN,
    output reg [DATA_SIZE-1:0] K_OUT,
    output reg [DATA_SIZE-1:0] BETA_OUT,
    output reg [DATA_SIZE-1:0] E_OUT,
    output reg [DATA_SIZE-1:0] V_OUT,
    output reg [DATA_SIZE-1:0] GA_OUT,
    output reg [DATA_SIZE-1:0] GW_OUT
  );

  ///////////////////////////////////////////////////////////////////////
  // Types
  ///////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////
  // Constants
  ///////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////
  // Signals
  ///////////////////////////////////////////////////////////////////////

  // SCALAR PRODUCT
  // CONTROL
  wire start_scalar_product;
  wire ready_scalar_product;

  wire data_a_in_enable_scalar_product;
  wire data_b_in_enable_scalar_product;
  wire data_out_enable_scalar_product;

  // DATA
  wire [DATA_SIZE-1:0] modulo_in_scalar_product;
  wire [DATA_SIZE-1:0] length_in_scalar_product;
  wire [DATA_SIZE-1:0] data_a_in_scalar_product;
  wire [DATA_SIZE-1:0] data_b_in_scalar_product;
  wire [DATA_SIZE-1:0] data_out_scalar_product;

  // MATRIX PRODUCT
  // CONTROL
  wire start_matrix_product;
  wire ready_matrix_product;

  wire data_a_in_i_enable_matrix_product;
  wire data_a_in_j_enable_matrix_product;
  wire data_b_in_i_enable_matrix_product;
  wire data_b_in_j_enable_matrix_product;
  wire data_out_i_enable_matrix_product;
  wire data_out_j_enable_matrix_product;

  // DATA
  wire [DATA_SIZE-1:0] modulo_in_matrix_product;
  wire [DATA_SIZE-1:0] size_a_i_in_matrix_product;
  wire [DATA_SIZE-1:0] size_a_j_in_matrix_product;
  wire [DATA_SIZE-1:0] size_b_i_in_matrix_product;
  wire [DATA_SIZE-1:0] size_b_j_in_matrix_product;
  wire [DATA_SIZE-1:0] data_a_in_matrix_product;
  wire [DATA_SIZE-1:0] data_b_in_matrix_product;
  wire [DATA_SIZE-1:0] data_out_matrix_product;

  ///////////////////////////////////////////////////////////////////////
  // Body
  ///////////////////////////////////////////////////////////////////////

  // xi(t;?) = U(t;?;l)·h(t;l)

  // SCALAR PRODUCT
  ntm_scalar_product #(
    .DATA_SIZE(DATA_SIZE)
  )
  scalar_product(
    // GLOBAL
    .CLK(CLK),
    .RST(RST),

    // CONTROL
    .START(start_scalar_product),
    .READY(ready_scalar_product),

    .DATA_A_IN_ENABLE(data_a_in_enable_scalar_product),
    .DATA_B_IN_ENABLE(data_b_in_enable_scalar_product),
    .DATA_OUT_ENABLE(data_out_enable_scalar_product),

    // DATA
    .MODULO_IN(modulo_in_scalar_product),
    .LENGTH_IN(length_in_scalar_product),
    .DATA_A_IN(data_a_in_scalar_product),
    .DATA_B_IN(data_b_in_scalar_product),
    .DATA_OUT(data_out_scalar_product)
  );

  // MATRIX PRODUCT
  ntm_matrix_product #(
    .DATA_SIZE(DATA_SIZE)
  )
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
    .DATA_OUT(data_out_matrix_product)
  );

endmodule
