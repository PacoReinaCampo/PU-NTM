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

use ieee.math_real.all;
use ieee.float_pkg.all;

use work.ntm_arithmetic_pkg.all;
use work.ntm_math_pkg.all;

package ntm_state_pkg is

  -----------------------------------------------------------------------
  -- Constants
  -----------------------------------------------------------------------

  constant DATA_SIZE    : integer := 32;
  constant CONTROL_SIZE : integer := 64;

  constant ZERO_CONTROL  : std_logic_vector(CONTROL_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0, CONTROL_SIZE));
  constant ONE_CONTROL   : std_logic_vector(CONTROL_SIZE-1 downto 0) := std_logic_vector(to_unsigned(1, CONTROL_SIZE));
  constant TWO_CONTROL   : std_logic_vector(CONTROL_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2, CONTROL_SIZE));
  constant THREE_CONTROL : std_logic_vector(CONTROL_SIZE-1 downto 0) := std_logic_vector(to_unsigned(3, CONTROL_SIZE));

  constant ZERO_DATA  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_float(0.0));
  constant ONE_DATA   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_float(1.0));
  constant TWO_DATA   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_float(2.0));
  constant THREE_DATA : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_float(3.0));

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  -- Buffer
  type vector_buffer is array (CONTROL_SIZE-1 downto 0) of std_logic_vector(DATA_SIZE-1 downto 0);
  type matrix_buffer is array (CONTROL_SIZE-1 downto 0, CONTROL_SIZE-1 downto 0) of std_logic_vector(DATA_SIZE-1 downto 0);
  type tensor_buffer is array (CONTROL_SIZE-1 downto 0, CONTROL_SIZE-1 downto 0, CONTROL_SIZE-1 downto 0) of std_logic_vector(DATA_SIZE-1 downto 0);

  -----------------------------------------------------------------------
  -- Components
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- STATE - TOP
  -----------------------------------------------------------------------

  component ntm_state_top is
    generic (
      DATA_SIZE    : integer := 32;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_C_IN_I_ENABLE : in std_logic;
      DATA_C_IN_J_ENABLE : in std_logic;
      DATA_D_IN_I_ENABLE : in std_logic;
      DATA_D_IN_J_ENABLE : in std_logic;

      DATA_A_I_ENABLE : out std_logic;
      DATA_A_J_ENABLE : out std_logic;
      DATA_B_I_ENABLE : out std_logic;
      DATA_B_J_ENABLE : out std_logic;
      DATA_C_I_ENABLE : out std_logic;
      DATA_C_J_ENABLE : out std_logic;
      DATA_D_I_ENABLE : out std_logic;
      DATA_D_J_ENABLE : out std_logic;

      DATA_K_IN_I_ENABLE : in std_logic;
      DATA_K_IN_J_ENABLE : in std_logic;

      DATA_K_I_ENABLE : out std_logic;
      DATA_K_J_ENABLE : out std_logic;

      DATA_X_OUT_ENABLE : out std_logic;
      DATA_Y_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_A_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_A_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_C_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_X_OUT : out std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_Y_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- STATE - OUTPUTS
  -----------------------------------------------------------------------

  component ntm_state_vector_output is
    generic (
      DATA_SIZE    : integer := 32;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_C_IN_I_ENABLE : in std_logic;
      DATA_C_IN_J_ENABLE : in std_logic;
      DATA_D_IN_I_ENABLE : in std_logic;
      DATA_D_IN_J_ENABLE : in std_logic;

      DATA_A_I_ENABLE : out std_logic;
      DATA_A_J_ENABLE : out std_logic;
      DATA_B_I_ENABLE : out std_logic;
      DATA_B_J_ENABLE : out std_logic;
      DATA_C_I_ENABLE : out std_logic;
      DATA_C_J_ENABLE : out std_logic;
      DATA_D_I_ENABLE : out std_logic;
      DATA_D_J_ENABLE : out std_logic;

      DATA_K_IN_I_ENABLE : in std_logic;
      DATA_K_IN_J_ENABLE : in std_logic;

      DATA_K_I_ENABLE : out std_logic;
      DATA_K_J_ENABLE : out std_logic;

      DATA_X_OUT_ENABLE : out std_logic;
      DATA_Y_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_A_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_A_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_C_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_X_OUT : out std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_Y_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_state_vector_state is
    generic (
      DATA_SIZE    : integer := 32;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_C_IN_I_ENABLE : in std_logic;
      DATA_C_IN_J_ENABLE : in std_logic;
      DATA_D_IN_I_ENABLE : in std_logic;
      DATA_D_IN_J_ENABLE : in std_logic;

      DATA_A_I_ENABLE : out std_logic;
      DATA_A_J_ENABLE : out std_logic;
      DATA_B_I_ENABLE : out std_logic;
      DATA_B_J_ENABLE : out std_logic;
      DATA_C_I_ENABLE : out std_logic;
      DATA_C_J_ENABLE : out std_logic;
      DATA_D_I_ENABLE : out std_logic;
      DATA_D_J_ENABLE : out std_logic;

      DATA_K_IN_I_ENABLE : in std_logic;
      DATA_K_IN_J_ENABLE : in std_logic;

      DATA_K_I_ENABLE : out std_logic;
      DATA_K_J_ENABLE : out std_logic;

      DATA_X_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_A_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_A_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_C_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_X_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- STATE - FEEDBACK
  -----------------------------------------------------------------------

  component ntm_state_matrix_state is
    generic (
      DATA_SIZE    : integer := 32;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_C_IN_I_ENABLE : in std_logic;
      DATA_C_IN_J_ENABLE : in std_logic;
      DATA_D_IN_I_ENABLE : in std_logic;
      DATA_D_IN_J_ENABLE : in std_logic;

      DATA_A_I_ENABLE : out std_logic;
      DATA_A_J_ENABLE : out std_logic;
      DATA_B_I_ENABLE : out std_logic;
      DATA_B_J_ENABLE : out std_logic;
      DATA_C_I_ENABLE : out std_logic;
      DATA_C_J_ENABLE : out std_logic;
      DATA_D_I_ENABLE : out std_logic;
      DATA_D_J_ENABLE : out std_logic;

      DATA_K_IN_I_ENABLE : in std_logic;
      DATA_K_IN_J_ENABLE : in std_logic;

      DATA_K_I_ENABLE : out std_logic;
      DATA_K_J_ENABLE : out std_logic;

      DATA_A_OUT_I_ENABLE : out std_logic;
      DATA_A_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_A_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_A_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_C_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_A_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_state_matrix_input is
    generic (
      DATA_SIZE    : integer := 32;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_D_IN_I_ENABLE : in std_logic;
      DATA_D_IN_J_ENABLE : in std_logic;

      DATA_B_I_ENABLE : out std_logic;
      DATA_B_J_ENABLE : out std_logic;
      DATA_D_I_ENABLE : out std_logic;
      DATA_D_J_ENABLE : out std_logic;

      DATA_K_IN_I_ENABLE : in std_logic;
      DATA_K_IN_J_ENABLE : in std_logic;

      DATA_K_I_ENABLE : out std_logic;
      DATA_K_J_ENABLE : out std_logic;

      DATA_B_OUT_I_ENABLE : out std_logic;
      DATA_B_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_B_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_B_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_B_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_state_matrix_output is
    generic (
      DATA_SIZE    : integer := 32;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      DATA_C_IN_I_ENABLE : in std_logic;
      DATA_C_IN_J_ENABLE : in std_logic;
      DATA_D_IN_I_ENABLE : in std_logic;
      DATA_D_IN_J_ENABLE : in std_logic;

      DATA_C_I_ENABLE : out std_logic;
      DATA_C_J_ENABLE : out std_logic;
      DATA_D_I_ENABLE : out std_logic;
      DATA_D_J_ENABLE : out std_logic;

      DATA_K_IN_I_ENABLE : in std_logic;
      DATA_K_IN_J_ENABLE : in std_logic;

      DATA_K_I_ENABLE : out std_logic;
      DATA_K_J_ENABLE : out std_logic;

      DATA_C_OUT_I_ENABLE : out std_logic;
      DATA_C_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_C_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_C_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      DATA_C_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_C_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_state_matrix_feedforward is
    generic (
      DATA_SIZE    : integer := 32;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      DATA_D_IN_I_ENABLE : in std_logic;
      DATA_D_IN_J_ENABLE : in std_logic;

      DATA_D_I_ENABLE : out std_logic;
      DATA_D_J_ENABLE : out std_logic;

      DATA_K_IN_I_ENABLE : in std_logic;
      DATA_K_IN_J_ENABLE : in std_logic;

      DATA_K_I_ENABLE : out std_logic;
      DATA_K_J_ENABLE : out std_logic;

      DATA_D_OUT_I_ENABLE : out std_logic;
      DATA_D_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_D_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_D_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      DATA_D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_D_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- STATE - FEEDBACK
  -----------------------------------------------------------------------

  function function_matrix_identity (
    SIZE_IN : std_logic_vector(CONTROL_SIZE-1 downto 0)
    ) return matrix_buffer;

  function function_state_matrix_state (
    SIZE_A_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_A_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_B_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_B_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_C_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_C_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_a_input : matrix_buffer;
    matrix_data_b_input : matrix_buffer;
    matrix_data_c_input : matrix_buffer;
    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer
    ) return matrix_buffer;

  function function_state_matrix_input (
    SIZE_B_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_B_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_b_input : matrix_buffer;
    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer
    ) return matrix_buffer;

  function function_state_matrix_output (
    SIZE_C_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_C_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_c_input : matrix_buffer;
    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer
    ) return matrix_buffer;

  function function_state_matrix_feedforward (
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer

    ) return matrix_buffer;

  -----------------------------------------------------------------------
  -- STATE - OUTPUTS
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- STATE - TOP
  -----------------------------------------------------------------------

end ntm_state_pkg;

package body ntm_state_pkg is

  -----------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- STATE - FEEDBACK
  -----------------------------------------------------------------------

  function function_matrix_identity (
    SIZE_IN : std_logic_vector(CONTROL_SIZE-1 downto 0)
    ) return matrix_buffer is

    variable matrix_output : matrix_buffer;

  begin

    -- Data Inputs
    for i in 0 to to_integer(unsigned(SIZE_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_IN))-1 loop
        if i = j then
          matrix_output(i, j) := ONE_DATA;
        else
          matrix_output(i, j) := ZERO_DATA;
        end if;
      end loop;
    end loop;

    return matrix_output;
  end function function_matrix_identity;

  function function_state_matrix_state (
    SIZE_A_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_A_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_B_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_B_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_C_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_C_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_a_input : matrix_buffer;
    matrix_data_b_input : matrix_buffer;
    matrix_data_c_input : matrix_buffer;
    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer
    ) return matrix_buffer is

    variable MATRIX_IDENTITY : matrix_buffer;

    variable matrix_first_product  : matrix_buffer;
    variable matrix_second_product : matrix_buffer;
    variable matrix_adder          : matrix_buffer;
    variable matrix_inverse        : matrix_buffer;

    variable matrix_in_int : matrix_buffer;

    variable data_interchange_in_int  : vector_buffer;
    variable data_interchange_out_int : vector_buffer;

    variable data_quotient_int : std_logic_vector(DATA_SIZE-1 downto 0);

    variable matrix_a_output : matrix_buffer;

  begin

    -- a = A-B·K·inv(I+D·K)·C

    -- Data Inputs
    MATRIX_IDENTITY := function_matrix_identity(SIZE_D_I_IN);

    -- matrix_first_product := function_matrix_product(SIZE_D_I_IN, SIZE_D_J_IN, SIZE_K_I_IN, SIZE_K_J_IN, matrix_data_d_input, matrix_data_k_input);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_first_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
          matrix_first_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_first_product(i, j))) + (to_real(to_float(matrix_data_d_input(i, m)))*to_real(to_float(matrix_data_k_input(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_adder := function_matrix_adder(SIZE_D_I_IN, SIZE_K_J_IN, MATRIX_IDENTITY, matrix_first_product);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_adder(i, j) := std_logic_vector(to_float(to_real(to_float(MATRIX_IDENTITY(i, j))) + to_real(to_float(matrix_first_product(i, j)))));
      end loop;
    end loop;

    -- matrix_inverse := function_matrix_inverse(SIZE_D_I_IN, SIZE_K_J_IN, matrix_adder);
    matrix_in_int := matrix_adder;

    for m in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      if (matrix_in_int(m, m) = ZERO_DATA) then
        for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
          if (matrix_in_int(i, m) /= ZERO_DATA) then
            for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
              data_interchange_in_int(j)  := matrix_in_int(m, j);
              data_interchange_out_int(j) := matrix_inverse(m, j);

              matrix_in_int(m, j)  := matrix_in_int(i, j);
              matrix_inverse(m, j) := matrix_inverse(i, j);

              matrix_in_int(i, j)  := data_interchange_in_int(j);
              matrix_inverse(i, j) := data_interchange_out_int(j);
            end loop;
          end if;
        end loop;
      end if;

      for i in m+1 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
        data_quotient_int := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, m)))/to_real(to_float(matrix_in_int(m, m)))));

        for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_in_int(i, j)  := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_in_int(m, j))))));
          matrix_inverse(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_inverse(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_inverse(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_first_product := function_matrix_product(SIZE_K_I_IN, SIZE_K_J_IN, SIZE_D_I_IN, SIZE_K_J_IN, matrix_data_k_input, matrix_inverse);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_first_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_first_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_first_product(i, j))) + (to_real(to_float(matrix_data_k_input(i, m)))*to_real(to_float(matrix_inverse(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_second_product := function_matrix_product(SIZE_K_I_IN, SIZE_K_J_IN, SIZE_D_I_IN, SIZE_K_J_IN, matrix_data_k_input, matrix_first_product);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_second_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_second_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_second_product(i, j))) + (to_real(to_float(matrix_data_k_input(i, m)))*to_real(to_float(matrix_first_product(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_first_product := function_matrix_product(SIZE_K_I_IN, SIZE_K_J_IN, SIZE_C_I_IN, SIZE_C_J_IN, matrix_second_product, matrix_data_c_input);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_C_J_IN))-1 loop
        matrix_first_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_first_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_first_product(i, j))) + (to_real(to_float(matrix_second_product(i, m)))*to_real(to_float(matrix_data_c_input(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_a_output := function_matrix_adder(SIZE_K_I_IN, SIZE_C_J_IN, matrix_data_a_input, matrix_first_product);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_C_J_IN))-1 loop
        matrix_a_output(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_data_a_input(i, j))) + to_real(to_float(matrix_first_product(i, j)))));
      end loop;
    end loop;

    return matrix_a_output;
  end function function_state_matrix_state;

  function function_state_matrix_input (
    SIZE_B_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_B_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_b_input : matrix_buffer;
    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer
    ) return matrix_buffer is

    variable MATRIX_IDENTITY : matrix_buffer;

    variable matrix_first_product  : matrix_buffer;
    variable matrix_second_product : matrix_buffer;
    variable matrix_adder          : matrix_buffer;
    variable matrix_inverse        : matrix_buffer;

    variable matrix_in_int : matrix_buffer;

    variable data_interchange_in_int  : vector_buffer;
    variable data_interchange_out_int : vector_buffer;

    variable data_quotient_int : std_logic_vector(DATA_SIZE-1 downto 0);

    variable matrix_b_output : matrix_buffer;

  begin

    -- b = B·(I-K·inv(I+D·K)·D)

    -- Data Inputs
    MATRIX_IDENTITY := function_matrix_identity(SIZE_D_I_IN);

    -- matrix_first_product := function_matrix_product(SIZE_D_I_IN, SIZE_D_J_IN, SIZE_K_I_IN, SIZE_K_J_IN, matrix_data_d_input, matrix_data_k_input);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_first_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
          matrix_first_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_first_product(i, j))) + (to_real(to_float(matrix_data_d_input(i, m)))*to_real(to_float(matrix_data_k_input(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_adder := function_matrix_adder(SIZE_D_I_IN, SIZE_K_J_IN, MATRIX_IDENTITY, matrix_first_product);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_adder(i, j) := std_logic_vector(to_float(to_real(to_float(MATRIX_IDENTITY(i, j))) + to_real(to_float(matrix_first_product(i, j)))));
      end loop;
    end loop;

    -- matrix_inverse := function_matrix_inverse(SIZE_D_I_IN, SIZE_K_J_IN, matrix_adder);
    matrix_in_int := matrix_adder;

    for m in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      if (matrix_in_int(m, m) = ZERO_DATA) then
        for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
          if (matrix_in_int(i, m) /= ZERO_DATA) then
            for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
              data_interchange_in_int(j)  := matrix_in_int(m, j);
              data_interchange_out_int(j) := matrix_inverse(m, j);

              matrix_in_int(m, j)  := matrix_in_int(i, j);
              matrix_inverse(m, j) := matrix_inverse(i, j);

              matrix_in_int(i, j)  := data_interchange_in_int(j);
              matrix_inverse(i, j) := data_interchange_out_int(j);
            end loop;
          end if;
        end loop;
      end if;

      for i in m+1 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
        data_quotient_int := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, m)))/to_real(to_float(matrix_in_int(m, m)))));

        for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_in_int(i, j)  := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_in_int(m, j))))));
          matrix_inverse(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_inverse(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_inverse(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_first_product := function_matrix_product(SIZE_K_I_IN, SIZE_K_J_IN, SIZE_D_I_IN, SIZE_K_J_IN, matrix_data_k_input, matrix_inverse);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_first_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_first_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_first_product(i, j))) + (to_real(to_float(matrix_data_k_input(i, m)))*to_real(to_float(matrix_inverse(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_second_product := function_matrix_product(SIZE_K_I_IN, SIZE_K_J_IN, SIZE_D_I_IN, SIZE_D_J_IN, matrix_first_product, matrix_data_d_input);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
        matrix_second_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_second_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_second_product(i, j))) + (to_real(to_float(matrix_first_product(i, m)))*to_real(to_float(matrix_data_d_input(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_adder := function_matrix_adder(SIZE_K_I_IN, SIZE_D_J_IN, MATRIX_IDENTITY, matrix_second_product);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
        matrix_adder(i, j) := std_logic_vector(to_float(to_real(to_float(MATRIX_IDENTITY(i, j))) + to_real(to_float(matrix_second_product(i, j)))));
      end loop;
    end loop;

    -- matrix_b_output := function_matrix_product(SIZE_K_I_IN, SIZE_D_J_IN, SIZE_B_I_IN, SIZE_B_J_IN, matrix_adder, matrix_data_b_input);
    for i in 0 to to_integer(unsigned(SIZE_K_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_B_J_IN))-1 loop
        matrix_b_output(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
          matrix_b_output(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_second_product(i, j))) + (to_real(to_float(matrix_adder(i, m)))*to_real(to_float(matrix_data_b_input(m, j))))));
        end loop;
      end loop;
    end loop;

    return matrix_b_output;
  end function function_state_matrix_input;

  function function_state_matrix_output (
    SIZE_C_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_C_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_c_input : matrix_buffer;
    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer
    ) return matrix_buffer is

    variable MATRIX_IDENTITY : matrix_buffer;

    variable matrix_product : matrix_buffer;
    variable matrix_adder   : matrix_buffer;
    variable matrix_inverse : matrix_buffer;

    variable matrix_in_int : matrix_buffer;

    variable data_interchange_in_int  : vector_buffer;
    variable data_interchange_out_int : vector_buffer;

    variable data_quotient_int : std_logic_vector(DATA_SIZE-1 downto 0);

    variable matrix_c_output : matrix_buffer;

  begin

    -- c = inv(I+D·K)·C

    -- Data Inputs
    MATRIX_IDENTITY := function_matrix_identity(SIZE_D_I_IN);

    -- matrix_product := function_matrix_product(SIZE_D_I_IN, SIZE_D_J_IN, SIZE_K_I_IN, SIZE_K_J_IN, matrix_data_d_input, matrix_data_k_input);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
          matrix_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_product(i, j))) + (to_real(to_float(matrix_data_d_input(i, m)))*to_real(to_float(matrix_data_k_input(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_adder := function_matrix_adder(SIZE_D_I_IN, SIZE_K_J_IN, MATRIX_IDENTITY, matrix_product);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_adder(i, j) := std_logic_vector(to_float(to_real(to_float(MATRIX_IDENTITY(i, j))) + to_real(to_float(matrix_product(i, j)))));
      end loop;
    end loop;

    -- matrix_inverse:= function_matrix_inverse(SIZE_D_I_IN, SIZE_K_J_IN, matrix_adder);
    matrix_in_int := matrix_adder;

    for m in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      if (matrix_in_int(m, m) = ZERO_DATA) then
        for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
          if (matrix_in_int(i, m) /= ZERO_DATA) then
            for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
              data_interchange_in_int(j)  := matrix_in_int(m, j);
              data_interchange_out_int(j) := matrix_inverse(m, j);

              matrix_in_int(m, j)  := matrix_in_int(i, j);
              matrix_inverse(m, j) := matrix_inverse(i, j);

              matrix_in_int(i, j)  := data_interchange_in_int(j);
              matrix_inverse(i, j) := data_interchange_out_int(j);
            end loop;
          end if;
        end loop;
      end if;

      for i in m+1 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
        data_quotient_int := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, m)))/to_real(to_float(matrix_in_int(m, m)))));

        for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_in_int(i, j)  := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_in_int(m, j))))));
          matrix_inverse(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_inverse(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_inverse(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_c_output := function_matrix_product(SIZE_D_I_IN, SIZE_K_J_IN, SIZE_C_I_IN, SIZE_C_J_IN, matrix_inverse, matrix_data_c_input);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
        matrix_c_output(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_c_output(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_c_output(i, j))) + (to_real(to_float(matrix_inverse(i, m)))*to_real(to_float(matrix_data_c_input(m, j))))));
        end loop;
      end loop;
    end loop;

    return matrix_c_output;
  end function function_state_matrix_output;

  function function_state_matrix_feedforward (
    SIZE_D_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_D_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_I_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);
    SIZE_K_J_IN : std_logic_vector(CONTROL_SIZE-1 downto 0);

    matrix_data_d_input : matrix_buffer;
    matrix_data_k_input : matrix_buffer
    ) return matrix_buffer is

    variable MATRIX_IDENTITY : matrix_buffer;

    variable matrix_product : matrix_buffer;
    variable matrix_adder   : matrix_buffer;
    variable matrix_inverse : matrix_buffer;

    variable matrix_in_int : matrix_buffer;

    variable data_interchange_in_int  : vector_buffer;
    variable data_interchange_out_int : vector_buffer;

    variable data_quotient_int : std_logic_vector(DATA_SIZE-1 downto 0);

    variable matrix_d_output : matrix_buffer;

  begin

    -- d = inv(I+D·K)·D

    -- Data Inputs
    MATRIX_IDENTITY := function_matrix_identity(SIZE_D_I_IN);

    -- matrix_product := function_matrix_product(SIZE_D_I_IN, SIZE_D_J_IN, SIZE_K_I_IN, SIZE_K_J_IN, matrix_data_d_input, matrix_data_k_input);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_product(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
          matrix_product(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_product(i, j))) + (to_real(to_float(matrix_data_d_input(i, m)))*to_real(to_float(matrix_data_k_input(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_adder := function_matrix_adder(SIZE_D_I_IN, SIZE_K_J_IN, MATRIX_IDENTITY, matrix_product);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
        matrix_adder(i, j) := std_logic_vector(to_float(to_real(to_float(MATRIX_IDENTITY(i, j))) + to_real(to_float(matrix_product(i, j)))));
      end loop;
    end loop;

    -- matrix_inverse:= function_matrix_inverse(SIZE_D_I_IN, SIZE_K_J_IN, matrix_adder);
    matrix_in_int := matrix_adder;

    for m in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      if (matrix_in_int(m, m) = ZERO_DATA) then
        for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
          if (matrix_in_int(i, m) /= ZERO_DATA) then
            for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
              data_interchange_in_int(j)  := matrix_in_int(m, j);
              data_interchange_out_int(j) := matrix_inverse(m, j);

              matrix_in_int(m, j)  := matrix_in_int(i, j);
              matrix_inverse(m, j) := matrix_inverse(i, j);

              matrix_in_int(i, j)  := data_interchange_in_int(j);
              matrix_inverse(i, j) := data_interchange_out_int(j);
            end loop;
          end if;
        end loop;
      end if;

      for i in m+1 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
        data_quotient_int := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, m)))/to_real(to_float(matrix_in_int(m, m)))));

        for j in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_in_int(i, j)  := std_logic_vector(to_float(to_real(to_float(matrix_in_int(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_in_int(m, j))))));
          matrix_inverse(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_inverse(i, j)))-(to_real(to_float(data_quotient_int))*to_real(to_float(matrix_inverse(m, j))))));
        end loop;
      end loop;
    end loop;

    -- matrix_d_output := function_matrix_product(SIZE_D_I_IN, SIZE_K_J_IN, SIZE_D_I_IN, SIZE_D_J_IN, matrix_inverse, matrix_data_d_input);
    for i in 0 to to_integer(unsigned(SIZE_D_I_IN))-1 loop
      for j in 0 to to_integer(unsigned(SIZE_D_J_IN))-1 loop
        matrix_d_output(i, j) := ZERO_DATA;

        for m in 0 to to_integer(unsigned(SIZE_K_J_IN))-1 loop
          matrix_d_output(i, j) := std_logic_vector(to_float(to_real(to_float(matrix_d_output(i, j))) + (to_real(to_float(matrix_inverse(i, m)))*to_real(to_float(matrix_data_d_input(m, j))))));
        end loop;
      end loop;
    end loop;

    return matrix_d_output;
  end function function_state_matrix_feedforward;

  -----------------------------------------------------------------------
  -- STATE - OUTPUTS
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- STATE - TOP
  -----------------------------------------------------------------------

end ntm_state_pkg;
