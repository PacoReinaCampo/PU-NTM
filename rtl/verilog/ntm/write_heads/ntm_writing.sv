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

module ntm_writing(
  CLK,
  RST,
  START,
  READY,
  M_IN_ENABLE,
  A_IN_ENABLE,
  M_OUT_ENABLE,
  SIZE_N_IN,
  SIZE_W_IN,
  M_IN,
  A_IN,
  W_IN,
  M_OUT
);

  parameter [31:0] DATA_SIZE=512;

  // GLOBAL
  input CLK;
  input RST;

  // CONTROL
  input START;
  output READY;

  input M_IN_ENABLE;
  input A_IN_ENABLE;
  input M_OUT_ENABLE;

  // DATA
  input [DATA_SIZE - 1:0] SIZE_N_IN;
  input [DATA_SIZE - 1:0] SIZE_W_IN;
  input [DATA_SIZE - 1:0] M_IN;
  input [DATA_SIZE - 1:0] A_IN;
  input [DATA_SIZE - 1:0] W_IN;
  input [DATA_SIZE - 1:0] M_OUT;

  ///////////////////////////////////////////////////////////////////////
  // Types
  ///////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////
  // Constants
  ///////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////
  // Signals
  ///////////////////////////////////////////////////////////////////////

  // VECTOR ADDER
  // CONTROL
  wire start_vector_adder;
  wire ready_vector_adder;
  wire operation_vector_adder;
  wire data_a_in_enable_vector_adder;
  wire data_b_in_enable_vector_adder;
  wire data_out_enable_vector_adder;

  // DATA
  wire [DATA_SIZE - 1:0] modulo_in_vector_adder;
  wire [DATA_SIZE - 1:0] size_in_vector_adder;
  wire [DATA_SIZE - 1:0] data_a_in_vector_adder;
  wire [DATA_SIZE - 1:0] data_b_in_vector_adder;
  wire [DATA_SIZE - 1:0] data_out_vector_adder;

  // VECTOR MULTIPLIER
  // CONTROL
  wire start_vector_multiplier;
  wire ready_vector_multiplier;
  wire data_a_in_enable_vector_multiplier;
  wire data_b_in_enable_vector_multiplier;
  wire data_out_enable_vector_multiplier;

  // DATA
  wire [DATA_SIZE - 1:0] modulo_in_vector_multiplier;
  wire [DATA_SIZE - 1:0] size_in_vector_multiplier;
  wire [DATA_SIZE - 1:0] data_a_in_vector_multiplier;
  wire [DATA_SIZE - 1:0] data_b_in_vector_multiplier;
  wire [DATA_SIZE - 1:0] data_out_vector_multiplier;

  ///////////////////////////////////////////////////////////////////////
  // Body
  ///////////////////////////////////////////////////////////////////////

  // M(t;j;k) = M(t;j;k) + w(t;j)·a(t;k)

  // VECTOR ADDER
  ntm_vector_adder #(
    .DATA_SIZE(DATA_SIZE)
  )
  vector_adder(
    // GLOBAL
    .CLK(CLK),
    .RST(RST),

    // CONTROL
    .START(start_vector_adder),
    .READY(ready_vector_adder),

    .OPERATION(operation_vector_adder),

    .DATA_A_IN_ENABLE(data_a_in_enable_vector_adder),
    .DATA_B_IN_ENABLE(data_b_in_enable_vector_adder),
    .DATA_OUT_ENABLE(data_out_enable_vector_adder),

    // DATA
    .MODULO_IN(modulo_in_vector_adder),
    .SIZE_IN(size_in_vector_adder),
    .DATA_A_IN(data_a_in_vector_adder),
    .DATA_B_IN(data_b_in_vector_adder),
    .DATA_OUT(data_out_vector_adder)
  );

  // VECTOR MULTIPLIER
  ntm_vector_multiplier #(
    .DATA_SIZE(DATA_SIZE)
  )
  vector_multiplier(
    // GLOBAL
    .CLK(CLK),
    .RST(RST),

    // CONTROL
    .START(start_vector_multiplier),
    .READY(ready_vector_multiplier),

    .DATA_A_IN_ENABLE(data_a_in_enable_vector_multiplier),
    .DATA_B_IN_ENABLE(data_b_in_enable_vector_multiplier),
    .DATA_OUT_ENABLE(data_out_enable_vector_multiplier),

    // DATA
    .MODULO_IN(modulo_in_vector_multiplier),
    .SIZE_IN(size_in_vector_multiplier),
    .DATA_A_IN(data_a_in_vector_multiplier),
    .DATA_B_IN(data_b_in_vector_multiplier),
    .DATA_OUT(data_out_vector_multiplier)
  );

endmodule
