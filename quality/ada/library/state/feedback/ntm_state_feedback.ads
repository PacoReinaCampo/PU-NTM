-----------------------------------------------------------------------------------
--                                            __ _      _     _                  --
--                                           / _(_)    | |   | |                 --
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 --
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 --
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 --
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 --
--                  | |                                                          --
--                  |_|                                                          --
--                                                                               --
--                                                                               --
--              Peripheral-NTM for MPSoC                                         --
--              Neural Turing Machine for MPSoC                                  --
--                                                                               --
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--                                                                               --
-- Copyright (c) 2020-2024 by the author(s)                                      --
--                                                                               --
-- Permission is hereby granted, free of charge, to any person obtaining a copy  --
-- of this software and associated documentation files (the "Software"), to deal --
-- in the Software without restriction, including without limitation the rights  --
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     --
-- copies of the Software, and to permit persons to whom the Software is         --
-- furnished to do so, subject to the following conditions:                      --
--                                                                               --
-- The above copyright notice and this permission notice shall be included in    --
-- all copies or substantial portions of the Software.                           --
--                                                                               --
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    --
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      --
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   --
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        --
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, --
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     --
-- THE SOFTWARE.                                                                 --
--                                                                               --
-- ============================================================================= --
-- Author(s):                                                                    --
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           --
--                                                                               --
-----------------------------------------------------------------------------------

with Ada.Text_IO;
use Ada.Text_IO;

with ntm_size;
use ntm_size;

with ntm_matrix_arithmetic;
use ntm_matrix_arithmetic;

with ntm_matrix_algebra;
use ntm_matrix_algebra;

package ntm_state_feedback is

  procedure ntm_eye_matrix (
    -- Inputs
    SIZE_I_IN : in integer;
    SIZE_J_IN : in integer;

    -- Outputs
    data_out : out matrix
  );

  procedure ntm_state_matrix_feedforward (
    -- Inputs
    data_d_in : in matrix;
    data_k_in : in matrix;

    -- Variables
    matrix_operation_int : out matrix;
    matrix_eye_int       : out matrix;

    -- Outputs
    data_d_out : out matrix
  );

  procedure ntm_state_matrix_input (
    -- Inputs
    data_b_in : in matrix;
    data_d_in : in matrix;
    data_k_in : in matrix;

    -- Variables
    matrix_operation_int : out matrix;
    matrix_eye_int       : out matrix;

    -- Outputs
    data_b_out : out matrix
  );

  procedure ntm_state_matrix_output (
    -- Inputs
    data_a_in : in matrix;
    data_b_in : in matrix;
    data_c_in : in matrix;
    data_d_in : in matrix;
    data_k_in : in matrix;

    -- Variables
    matrix_operation_int : out matrix;
    matrix_eye_int       : out matrix;

    -- Outputs
    data_c_out : out matrix
  );

  procedure ntm_state_matrix_state (
    -- Inputs
    data_a_in : in matrix;
    data_b_in : in matrix;
    data_c_in : in matrix;
    data_d_in : in matrix;
    data_k_in : in matrix;

    -- Variables
    matrix_operation_int : out matrix;
    matrix_eye_int       : out matrix;

    -- Outputs
    data_a_out : out matrix
  );

end ntm_state_feedback;
