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

module ntm_vector_divider(
  CLK,
  RST,
  START,
  READY,
  DATA_A_IN_ENABLE,
  DATA_B_IN_ENABLE,
  DATA_OUT_ENABLE,
  MODULO_IN,
  SIZE_IN,
  DATA_A_IN,
  DATA_B_IN,
  DATA_OUT
);

  parameter [31:0] DATA_SIZE=512;

  // GLOBAL
  input CLK;
  input RST;

  // CONTROL
  input START;
  output READY;

  input DATA_A_IN_ENABLE;
  input DATA_B_IN_ENABLE;
  output DATA_OUT_ENABLE;

  // DATA
  input [DATA_SIZE - 1:0] MODULO_IN;
  input [DATA_SIZE - 1:0] SIZE_IN;
  input [DATA_SIZE - 1:0] DATA_A_IN;
  input [DATA_SIZE - 1:0] DATA_B_IN;
  output [DATA_SIZE - 1:0] DATA_OUT;

  ///////////////////////////////////////////////////////////////////////
  // Types
  ///////////////////////////////////////////////////////////////////////

  parameter [1:0] STARTER_STATE = 0;
  parameter [1:0] INPUT_STATE = 1;
  parameter [1:0] ENDER_STATE = 2;

  ///////////////////////////////////////////////////////////////////////
  // Constants
  ///////////////////////////////////////////////////////////////////////

  parameter ZERO = ((0));
  parameter ONE = ((1));

  ///////////////////////////////////////////////////////////////////////
  // Signals
  ///////////////////////////////////////////////////////////////////////

  // Finite State Machine
  reg [1:0] divider_ctrl_fsm_int;

  // Internal Signals
  reg [DATA_SIZE - 1:0] index_loop;

  reg data_a_in_divider_int;
  reg data_b_in_divider_int;

  // DIVIDER
  // CONTROL
  reg start_scalar_divider;
  wire ready_scalar_divider;

  // DATA
  reg [DATA_SIZE - 1:0] modulo_in_scalar_divider;
  reg [DATA_SIZE - 1:0] data_a_in_scalar_divider;
  reg [DATA_SIZE - 1:0] data_b_in_scalar_divider;
  wire [DATA_SIZE - 1:0] data_out_scalar_divider;

  ///////////////////////////////////////////////////////////////////////
  // Body
  ///////////////////////////////////////////////////////////////////////

  // DATA_OUT = DATA_B_IN / DATA_A_IN mod MODULO_IN
  always @(posedge CLK or posedge RST) begin
    if((RST == 1'b0)) begin
      // Data Outputs
      DATA_OUT <= ZERO;
      // Control Outputs
      READY <= 1'b0;
      // Assignations
      index_loop <= ZERO;
      data_a_in_divider_int <= 1'b0;
      data_b_in_divider_int <= 1'b0;
    end else begin
      case(divider_ctrl_fsm_int)
        STARTER_STATE : begin
          // STEP 0
          // Control Outputs
          READY <= 1'b0;
          if((START == 1'b1)) begin
            // Assignations
            index_loop <= ZERO;
            // FSM Control
            divider_ctrl_fsm_int <= INPUT_STATE;
          end
        end
        INPUT_STATE : begin
          // STEP 1
          if((DATA_A_IN_ENABLE == 1'b1)) begin
            // Data Inputs
            data_a_in_scalar_divider <= DATA_A_IN;
            // Control Internal
            data_a_in_divider_int <= 1'b1;
          end
          if((DATA_B_IN_ENABLE == 1'b1)) begin
            // Data Inputs
            data_b_in_scalar_divider <= DATA_B_IN;
            // Control Internal
            data_b_in_divider_int <= 1'b1;
          end
          if((data_a_in_divider_int == 1'b1 && data_b_in_divider_int == 1'b1)) begin
            if((index_loop == ZERO)) begin
              // Control Internal
              start_scalar_divider <= 1'b1;
            end
            // Data Inputs
            modulo_in_scalar_divider <= MODULO_IN;
            // FSM Control
            divider_ctrl_fsm_int <= ENDER_STATE;
          end
          // Control Outputs
          DATA_OUT_ENABLE <= 1'b0;
        end
        ENDER_STATE : begin
          // STEP 2
          if((ready_scalar_divider == 1'b1)) begin
            if((((index_loop)) == (((SIZE_IN)) - ((ONE))))) begin
              // Control Outputs
              READY <= 1'b1;
              // FSM Control
              divider_ctrl_fsm_int <= STARTER_STATE;
            end
            else begin
              // Control Internal
              index_loop <= (((index_loop)) + ((ONE)));
              // FSM Control
              divider_ctrl_fsm_int <= INPUT_STATE;
            end
            // Data Outputs
            DATA_OUT <= data_out_scalar_divider;
            // Control Outputs
            DATA_OUT_ENABLE <= 1'b1;
          end
          else begin
            // Control Internal
            start_scalar_divider <= 1'b0;
            data_a_in_divider_int <= 1'b0;
            data_b_in_divider_int <= 1'b0;
          end
        end
        default : begin
          // FSM Control
          divider_ctrl_fsm_int <= STARTER_STATE;
        end
      endcase
    end
  end

  // DIVIDER
  ntm_scalar_divider #(
    .DATA_SIZE(DATA_SIZE)
  )
  scalar_divider(
    // GLOBAL
    .CLK(CLK),
    .RST(RST),

    // CONTROL
    .START(start_scalar_divider),
    .READY(ready_scalar_divider),

    // DATA
    .MODULO_IN(modulo_in_scalar_divider),
    .DATA_A_IN(data_a_in_scalar_divider),
    .DATA_B_IN(data_b_in_scalar_divider),
    .DATA_OUT(data_out_scalar_divider)
  );

endmodule