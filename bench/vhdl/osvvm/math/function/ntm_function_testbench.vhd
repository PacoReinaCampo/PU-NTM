--------------------------------------------------------------------------------
--                                            __ _      _     _               --
--                                           / _(_)    | |   | |              --
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              --
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              --
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              --
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              --
--                  | |                                                       --
--                  |_|                                                       --
--                                                                            --
--                                                                            --
--              Peripheral-NTM for MPSoC                                      --
--              Neural Turing Machine for MPSoC                               --
--                                                                            --
--------------------------------------------------------------------------------

-- Copyright (c) 2020-2021 by the author(s)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ntm_pkg.all;

entity ntm_function_testbench is
end ntm_function_testbench;

architecture ntm_function_testbench_architecture of ntm_function_testbench is

  -----------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------

  -- GLOBAL
  signal CLK : std_logic;
  signal RST : std_logic;

  -----------------------------------------------------------------------
  -- SCALAR
  -----------------------------------------------------------------------

  -- CONVOLUTION
  -- CONTROL
  signal start_scalar_convolution : std_logic;
  signal ready_scalar_convolution : std_logic;

  -- DATA
  signal modulo_scalar_convolution : std_logic_vector(DATA_SIZE-1 downto 0);
  signal n_in_scalar_convolution   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal w_in_scalar_convolution   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal s_in_scalar_convolution   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal w_out_scalar_convolution  : std_logic_vector(DATA_SIZE-1 downto 0);

  -- COSINE SIMILARITY
  -- CONTROL
  signal start_scalar_cosine : std_logic;
  signal ready_scalar_cosine : std_logic;

  -- DATA
  signal modulo_scalar_cosine    : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_in_scalar_cosine   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_u_in_scalar_cosine : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_v_in_scalar_cosine : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_cosine  : std_logic_vector(DATA_SIZE-1 downto 0);

  -- COSH
  -- CONTROL
  signal start_scalar_cosh : std_logic;
  signal ready_scalar_cosh : std_logic;

  -- DATA
  signal modulo_scalar_cosh   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_in_scalar_cosh  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_cosh : std_logic_vector(DATA_SIZE-1 downto 0);

  -- SINH
  -- CONTROL
  signal start_scalar_sinh : std_logic;
  signal ready_scalar_sinh : std_logic;

  -- DATA
  signal modulo_scalar_sinh   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_in_scalar_sinh  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_sinh : std_logic_vector(DATA_SIZE-1 downto 0);

  -- TANH
  -- CONTROL
  signal start_scalar_tanh : std_logic;
  signal ready_scalar_tanh : std_logic;

  -- DATA
  signal modulo_scalar_tanh   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_in_scalar_tanh  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_tanh : std_logic_vector(DATA_SIZE-1 downto 0);

  -- LOGISTIC
  -- CONTROL
  signal start_scalar_logistic : std_logic;
  signal ready_scalar_logistic : std_logic;

  -- DATA
  signal modulo_scalar_logistic   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_in_scalar_logistic  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_logistic : std_logic_vector(DATA_SIZE-1 downto 0);

  -- SOFTMAX
  -- CONTROL
  signal start_scalar_softmax : std_logic;
  signal ready_scalar_softmax : std_logic;

  -- DATA
  signal modulo_scalar_softmax   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_in_scalar_softmax  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_in_scalar_softmax  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_softmax : std_logic_vector(DATA_SIZE-1 downto 0);

  -- ONEPLUS
  -- CONTROL
  signal start_scalar_oneplus : std_logic;
  signal ready_scalar_oneplus : std_logic;

  -- DATA
  signal modulo_scalar_oneplus   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_in_scalar_oneplus  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_oneplus : std_logic_vector(DATA_SIZE-1 downto 0);

  -----------------------------------------------------------------------
  -- VECTOR
  -----------------------------------------------------------------------

  -- CONVOLUTION
  -- CONTROL
  signal start_vector_convolution : std_logic;
  signal ready_vector_convolution : std_logic;

  -- DATA
  signal modulo_vector_convolution : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal n_in_vector_convolution   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal w_in_vector_convolution   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal s_in_vector_convolution   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal w_out_vector_convolution  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -- COSINE SIMILARITY
  -- CONTROL
  signal start_vector_cosine : std_logic;
  signal ready_vector_cosine : std_logic;

  -- DATA
  signal modulo_vector_cosine    : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal size_in_vector_cosine   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_u_in_vector_cosine : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_v_in_vector_cosine : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_vector_cosine  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -- COSH
  -- CONTROL
  signal start_vector_cosh : std_logic;
  signal ready_vector_cosh : std_logic;

  -- DATA
  signal modulo_vector_cosh   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_vector_cosh  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_vector_cosh : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -- SINH
  -- CONTROL
  signal start_vector_sinh : std_logic;
  signal ready_vector_sinh : std_logic;

  -- DATA
  signal modulo_vector_sinh   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_vector_sinh  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_vector_sinh : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -- TANH
  -- CONTROL
  signal start_vector_tanh : std_logic;
  signal ready_vector_tanh : std_logic;

  -- DATA
  signal modulo_vector_tanh   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_vector_tanh  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_vector_tanh : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -- LOGISTIC
  -- CONTROL
  signal start_vector_logistic : std_logic;
  signal ready_vector_logistic : std_logic;

  -- DATA
  signal modulo_vector_logistic   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_vector_logistic  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_vector_logistic : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -- SOFTMAX
  -- CONTROL
  signal start_vector_softmax : std_logic;
  signal ready_vector_softmax : std_logic;

  -- DATA
  signal modulo_vector_softmax   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal size_in_vector_softmax  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_vector_softmax  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_vector_softmax : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -- ONEPLUS
  -- CONTROL
  signal start_vector_oneplus : std_logic;
  signal ready_vector_oneplus : std_logic;

  -- DATA
  signal modulo_vector_oneplus   : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_vector_oneplus  : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_vector_oneplus : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);

  -----------------------------------------------------------------------
  -- MATRIX
  -----------------------------------------------------------------------

  -- CONVOLUTION
  -- CONTROL
  signal start_matrix_convolution : std_logic;
  signal ready_matrix_convolution : std_logic;

  -- DATA
  signal modulo_matrix_convolution : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal n_in_matrix_convolution   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal w_in_matrix_convolution   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal s_in_matrix_convolution   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal w_out_matrix_convolution  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

  -- COSINE SIMILARITY
  -- CONTROL
  signal start_matrix_cosine : std_logic;
  signal ready_matrix_cosine : std_logic;

  -- DATA
  signal modulo_matrix_cosine    : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal size_in_matrix_cosine   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_u_in_matrix_cosine : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_v_in_matrix_cosine : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_matrix_cosine  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

  -- COSH
  -- CONTROL
  signal start_matrix_cosh : std_logic;
  signal ready_matrix_cosh : std_logic;

  -- DATA
  signal modulo_matrix_cosh   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_matrix_cosh  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_matrix_cosh : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

  -- SINH
  -- CONTROL
  signal start_matrix_sinh : std_logic;
  signal ready_matrix_sinh : std_logic;

  -- DATA
  signal modulo_matrix_sinh   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_matrix_sinh  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_matrix_sinh : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

  -- TANH
  -- CONTROL
  signal start_matrix_tanh : std_logic;
  signal ready_matrix_tanh : std_logic;

  -- DATA
  signal modulo_matrix_tanh   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_matrix_tanh  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_matrix_tanh : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

  -- LOGISTIC
  -- CONTROL
  signal start_matrix_logistic : std_logic;
  signal ready_matrix_logistic : std_logic;

  -- DATA
  signal modulo_matrix_logistic   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_matrix_logistic  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_matrix_logistic : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

  -- SOFTMAX
  -- CONTROL
  signal start_matrix_softmax : std_logic;
  signal ready_matrix_softmax : std_logic;

  -- DATA
  signal modulo_matrix_softmax   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal size_in_matrix_softmax  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_matrix_softmax  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_matrix_softmax : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

  -- ONEPLUS
  -- CONTROL
  signal start_matrix_oneplus : std_logic;
  signal ready_matrix_oneplus : std_logic;

  -- DATA
  signal modulo_matrix_oneplus   : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_in_matrix_oneplus  : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal data_out_matrix_oneplus : std_logic_arithmetic_vector_matrix(X-1 downto 0)(Y-1 downto 0)(DATA_SIZE-1 downto 0);

begin

  -----------------------------------------------------------------------
  -- Body
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- SCALAR
  -----------------------------------------------------------------------

  -- CONVOLUTION
  scalar_convolution_function : ntm_scalar_convolution_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_convolution,
      READY => ready_scalar_convolution,

      -- DATA
      MODULO => modulo_scalar_convolution,
      N_IN   => n_in_scalar_convolution,
      W_IN   => w_in_scalar_convolution,
      S_IN   => s_in_scalar_convolution,
      W_OUT  => w_out_scalar_convolution
    );

  -- COSINE SIMILARITY
  scalar_cosine_similarity_function : ntm_scalar_cosine_similarity_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_cosine,
      READY => ready_scalar_cosine,

      -- DATA
      MODULO    => modulo_scalar_cosine,
      SIZE_IN   => size_in_scalar_cosine,
      DATA_U_IN => data_u_in_scalar_cosine,
      DATA_V_IN => data_v_in_scalar_cosine,
      DATA_OUT  => data_out_scalar_cosine
    );

  -- COSH
  scalar_cosh_function : ntm_scalar_cosh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_cosh,
      READY => ready_scalar_cosh,

      -- DATA
      MODULO   => modulo_scalar_cosh,
      DATA_IN  => data_in_scalar_cosh,
      DATA_OUT => data_out_scalar_cosh
    );

  -- SINH
  scalar_sinh_function : ntm_scalar_sinh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_sinh,
      READY => ready_scalar_sinh,

      -- DATA
      MODULO   => modulo_scalar_sinh,
      DATA_IN  => data_in_scalar_sinh,
      DATA_OUT => data_out_scalar_sinh
    );

  -- TANH
  scalar_tanh_function : ntm_scalar_tanh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_tanh,
      READY => ready_scalar_tanh,

      -- DATA
      MODULO   => modulo_scalar_tanh,
      DATA_IN  => data_in_scalar_tanh,
      DATA_OUT => data_out_scalar_tanh
    );

  -- LOGISTIC
  scalar_logistic_function : ntm_scalar_logistic_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_logistic,
      READY => ready_scalar_logistic,

      -- DATA
      MODULO   => modulo_scalar_logistic,
      DATA_IN  => data_in_scalar_logistic,
      DATA_OUT => data_out_scalar_logistic
    );

  -- SOFTMAX
  scalar_softmax_function : ntm_scalar_softmax_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_softmax,
      READY => ready_scalar_softmax,

      -- DATA
      MODULO   => modulo_scalar_softmax,
      SIZE_IN  => size_in_scalar_softmax,
      DATA_IN  => data_in_scalar_softmax,
      DATA_OUT => data_out_scalar_softmax
    );

  -- ONEPLUS
  scalar_oneplus_function : ntm_scalar_oneplus_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_oneplus,
      READY => ready_scalar_oneplus,

      -- DATA
      MODULO   => modulo_scalar_oneplus,
      DATA_IN  => data_in_scalar_oneplus,
      DATA_OUT => data_out_scalar_oneplus
    );

  -----------------------------------------------------------------------
  -- VECTOR
  -----------------------------------------------------------------------

  -- CONVOLUTION
  vector_convolution_function : ntm_vector_convolution_function
    generic map (
      X => X,

      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_convolution,
      READY => ready_vector_convolution,

      -- DATA
      MODULO => modulo_vector_convolution,
      N_IN   => n_in_vector_convolution,
      W_IN   => w_in_vector_convolution,
      S_IN   => s_in_vector_convolution,
      W_OUT  => w_out_vector_convolution
    );

  -- COSINE SIMILARITY
  vector_cosine_similarity_function : ntm_vector_cosine_similarity_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_cosine,
      READY => ready_vector_cosine,

      -- DATA
      MODULO    => modulo_vector_cosine,
      SIZE_IN   => size_in_vector_cosine,
      DATA_U_IN => data_u_in_vector_cosine,
      DATA_V_IN => data_v_in_vector_cosine,
      DATA_OUT  => data_out_vector_cosine
    );

  -- COSH
  vector_cosh_function : ntm_vector_cosh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_cosh,
      READY => ready_vector_cosh,

      -- DATA
      MODULO   => modulo_vector_cosh,
      DATA_IN  => data_in_vector_cosh,
      DATA_OUT => data_out_vector_cosh
    );

  -- SINH
  vector_sinh_function : ntm_vector_sinh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_sinh,
      READY => ready_vector_sinh,

      -- DATA
      MODULO   => modulo_vector_sinh,
      DATA_IN  => data_in_vector_sinh,
      DATA_OUT => data_out_vector_sinh
    );

  -- TANH
  vector_tanh_function : ntm_vector_tanh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_tanh,
      READY => ready_vector_tanh,

      -- DATA
      MODULO   => modulo_vector_tanh,
      DATA_IN  => data_in_vector_tanh,
      DATA_OUT => data_out_vector_tanh
    );

  -- LOGISTIC
  vector_logistic_function : ntm_vector_logistic_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_logistic,
      READY => ready_vector_logistic,

      -- DATA
      MODULO   => modulo_vector_logistic,
      DATA_IN  => data_in_vector_logistic,
      DATA_OUT => data_out_vector_logistic
    );

  -- SOFTMAX
  vector_softmax_function : ntm_vector_softmax_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_softmax,
      READY => ready_vector_softmax,

      -- DATA
      MODULO   => modulo_vector_softmax,
      SIZE_IN  => size_in_vector_softmax,
      DATA_IN  => data_in_vector_softmax,
      DATA_OUT => data_out_vector_softmax
    );

  -- ONEPLUS
  vector_oneplus_function : ntm_vector_oneplus_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_oneplus,
      READY => ready_vector_oneplus,

      -- DATA
      MODULO   => modulo_vector_oneplus,
      DATA_IN  => data_in_vector_oneplus,
      DATA_OUT => data_out_vector_oneplus
    );

  -----------------------------------------------------------------------
  -- MATRIX
  -----------------------------------------------------------------------

  -- CONVOLUTION
  matrix_convolution_function : ntm_matrix_convolution_function
    generic map (
      X => X,
      Y => Y,

      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_convolution,
      READY => ready_matrix_convolution,

      -- DATA
      MODULO => modulo_matrix_convolution,
      N_IN   => n_in_matrix_convolution,
      W_IN   => w_in_matrix_convolution,
      S_IN   => s_in_matrix_convolution,
      W_OUT  => w_out_matrix_convolution
    );

  -- COSINE SIMILARITY
  matrix_cosine_similarity_function : ntm_matrix_cosine_similarity_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_cosine,
      READY => ready_matrix_cosine,

      -- DATA
      MODULO    => modulo_matrix_cosine,
      SIZE_IN   => size_in_matrix_cosine,
      DATA_U_IN => data_u_in_matrix_cosine,
      DATA_V_IN => data_v_in_matrix_cosine,
      DATA_OUT  => data_out_matrix_cosine
    );

  -- COSH
  matrix_cosh_function : ntm_matrix_cosh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_cosh,
      READY => ready_matrix_cosh,

      -- DATA
      MODULO   => modulo_matrix_cosh,
      DATA_IN  => data_in_matrix_cosh,
      DATA_OUT => data_out_matrix_cosh
    );

  -- SINH
  matrix_sinh_function : ntm_matrix_sinh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_sinh,
      READY => ready_matrix_sinh,

      -- DATA
      MODULO   => modulo_matrix_sinh,
      DATA_IN  => data_in_matrix_sinh,
      DATA_OUT => data_out_matrix_sinh
    );

  -- TANH
  matrix_tanh_function : ntm_matrix_tanh_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_tanh,
      READY => ready_matrix_tanh,

      -- DATA
      MODULO   => modulo_matrix_tanh,
      DATA_IN  => data_in_matrix_tanh,
      DATA_OUT => data_out_matrix_tanh
    );

  -- LOGISTIC
  matrix_logistic_function : ntm_matrix_logistic_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_logistic,
      READY => ready_matrix_logistic,

      -- DATA
      MODULO   => modulo_matrix_logistic,
      DATA_IN  => data_in_matrix_logistic,
      DATA_OUT => data_out_matrix_logistic
    );

  -- SOFTMAX
  matrix_softmax_function : ntm_matrix_softmax_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_softmax,
      READY => ready_matrix_softmax,

      -- DATA
      MODULO   => modulo_matrix_softmax,
      SIZE_IN  => size_in_matrix_softmax,
      DATA_IN  => data_in_matrix_softmax,
      DATA_OUT => data_out_matrix_softmax
    );

  -- ONEPLUS
  matrix_oneplus_function : ntm_matrix_oneplus_function
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_matrix_oneplus,
      READY => ready_matrix_oneplus,

      -- DATA
      MODULO   => modulo_matrix_oneplus,
      DATA_IN  => data_in_matrix_oneplus,
      DATA_OUT => data_out_matrix_oneplus
    );

end ntm_function_testbench_architecture;