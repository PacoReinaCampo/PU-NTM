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

module ntm_vector_adder #(
  parameter DATA_SIZE=512
)
  (
    // GLOBAL
    input CLK,
    input RST,

    // CONTROL
    input START,
    output reg READY,

    input OPERATION,

    input DATA_A_IN_ENABLE,
    input DATA_B_IN_ENABLE,
    output reg DATA_OUT_ENABLE,

    // DATA
    input [DATA_SIZE-1:0] MODULO_IN,
    input [DATA_SIZE-1:0] SIZE_IN,
    input [DATA_SIZE-1:0] DATA_A_IN,
    input [DATA_SIZE-1:0] DATA_B_IN,
    output reg [DATA_SIZE-1:0] DATA_OUT
  );

  ///////////////////////////////////////////////////////////////////////
  // Types
  ///////////////////////////////////////////////////////////////////////

  parameter [1:0] STARTER_STATE = 0;
  parameter [1:0] INPUT_STATE = 1;
  parameter [1:0] ENDER_STATE = 2;

  ///////////////////////////////////////////////////////////////////////
  // Constants
  ///////////////////////////////////////////////////////////////////////

  parameter ZERO = 0;
  parameter ONE = 1;
  
  ///////////////////////////////////////////////////////////////////////
  // Signals
  ///////////////////////////////////////////////////////////////////////

  // Finite State Machine
  reg [1:0] adder_ctrl_fsm_int;

  // Internal Signals
  reg [DATA_SIZE-1:0] index_loop;

  reg data_a_in_adder_int;
  reg data_b_in_adder_int;

  // ADDER
  // CONTROL
  reg start_scalar_adder;
  wire ready_scalar_adder;
  reg operation_scalar_adder;

  // DATA
  reg [DATA_SIZE-1:0] modulo_in_scalar_adder;
  reg [DATA_SIZE-1:0] data_a_in_scalar_adder;
  reg [DATA_SIZE-1:0] data_b_in_scalar_adder;
  wire [DATA_SIZE-1:0] data_out_scalar_adder;

  ///////////////////////////////////////////////////////////////////////
  // Body
  ///////////////////////////////////////////////////////////////////////

  // DATA_OUT = DATA_B_IN + DATA_A_IN mod MODULO_IN

  // CONTROL
  always @(posedge CLK or posedge RST) begin
    if(RST == 1'b0) begin
      // Data Outputs
      DATA_OUT <= ZERO;

      // Control Outputs
      READY <= 1'b0;

      // Assignations
      index_loop <= ZERO;

      data_a_in_adder_int <= 1'b0;
      data_b_in_adder_int <= 1'b0;
    end
    else begin
      case(adder_ctrl_fsm_int)
        STARTER_STATE : begin
          // STEP 0
          // Control Outputs
          READY <= 1'b0;

          if(START == 1'b1) begin
            // Assignations
            index_loop <= ZERO;

            // FSM Control
            adder_ctrl_fsm_int <= INPUT_STATE;
          end
        end
        INPUT_STATE : begin
          // STEP 1
          if(DATA_A_IN_ENABLE == 1'b1) begin
            // Data Inputs
            data_a_in_scalar_adder <= DATA_A_IN;

            // Control Internal
            data_a_in_adder_int <= 1'b1;
          end
          if(DATA_B_IN_ENABLE == 1'b1) begin
            // Data Inputs

            data_b_in_scalar_adder <= DATA_B_IN;
            // Control Internal
            data_b_in_adder_int <= 1'b1;
          end
          if(data_a_in_adder_int == 1'b1 && data_b_in_adder_int == 1'b1) begin
            if(index_loop == ZERO) begin
              // Control Internal
              start_scalar_adder <= 1'b1;
            end
            operation_scalar_adder <= OPERATION;
            // Data Inputs
            modulo_in_scalar_adder <= MODULO_IN;

            // FSM Control
            adder_ctrl_fsm_int <= ENDER_STATE;
          end
          // Control Outputs
          DATA_OUT_ENABLE <= 1'b0;
        end
        ENDER_STATE : begin
          // STEP 2
          if(ready_scalar_adder == 1'b1) begin
            if(index_loop == (SIZE_IN - ONE)) begin
              // Control Outputs
              READY <= 1'b1;

              // FSM Control
              adder_ctrl_fsm_int <= STARTER_STATE;
            end
            else begin
              // Control Internal
              index_loop <= (index_loop + ONE);

              // FSM Control
              adder_ctrl_fsm_int <= INPUT_STATE;
            end
            // Data Outputs
            DATA_OUT <= data_out_scalar_adder;

            // Control Outputs
            DATA_OUT_ENABLE <= 1'b1;
          end
          else begin
            // Control Internal
            start_scalar_adder <= 1'b0;
            data_a_in_adder_int <= 1'b0;
            data_b_in_adder_int <= 1'b0;
          end
        end
        default : begin
          // FSM Control
          adder_ctrl_fsm_int <= STARTER_STATE;
        end
      endcase
    end
  end

  // ADDER
  ntm_scalar_adder #(
    .DATA_SIZE(DATA_SIZE)
  )
  scalar_adder(
    // GLOBAL
    .CLK(CLK),
    .RST(RST),

    // CONTROL
    .START(start_scalar_adder),
    .READY(ready_scalar_adder),

    .OPERATION(operation_scalar_adder),

    // DATA
    .MODULO_IN(modulo_in_scalar_adder),
    .DATA_A_IN(data_a_in_scalar_adder),
    .DATA_B_IN(data_b_in_scalar_adder),
    .DATA_OUT(data_out_scalar_adder)
  );

endmodule
