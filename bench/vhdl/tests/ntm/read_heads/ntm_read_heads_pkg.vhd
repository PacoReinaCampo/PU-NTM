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

package ntm_read_heads_pkg is

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  -- SYSTEM-SIZE
  constant DATA_SIZE : integer := 512;

  constant CONTROL_X_SIZE : integer := 3;
  constant CONTROL_Y_SIZE : integer := 3;
  constant CONTROL_Z_SIZE : integer := 3;

  type tensor_buffer is array (0 to CONTROL_X_SIZE-1, 0 to CONTROL_Y_SIZE-1, 0 to CONTROL_Z_SIZE-1) of std_logic_vector(DATA_SIZE-1 downto 0);
  type matrix_buffer is array (0 to CONTROL_X_SIZE-1, 0 to CONTROL_Y_SIZE-1) of std_logic_vector(DATA_SIZE-1 downto 0);
  type vector_buffer is array (0 to CONTROL_X_SIZE-1) of std_logic_vector(DATA_SIZE-1 downto 0);

  -----------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------

  signal MONITOR_TEST : string(40 downto 1) := "                                        ";
  signal MONITOR_CASE : string(40 downto 1) := "                                        ";

  -----------------------------------------------------------------------
  -- Constants
  -----------------------------------------------------------------------

  -- SYSTEM-SIZE
  constant SIZE_I : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));
  constant SIZE_J : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));
  constant SIZE_K : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));

  constant SIZE : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));

  constant X : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- x in 0 to X-1
  constant Y : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- y in 0 to Y-1
  constant N : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- j in 0 to N-1
  constant W : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- k in 0 to W-1
  constant L : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- l in 0 to L-1
  constant R : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- i in 0 to R-1

  -- INTEGERS
  constant P_ZERO  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(0, DATA_SIZE));
  constant P_ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(1, DATA_SIZE));
  constant P_TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(2, DATA_SIZE));
  constant P_THREE : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(3, DATA_SIZE));
  constant P_FOUR  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(4, DATA_SIZE));
  constant P_FIVE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(5, DATA_SIZE));
  constant P_SIX   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(6, DATA_SIZE));
  constant P_SEVEN : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(7, DATA_SIZE));
  constant P_EIGHT : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(8, DATA_SIZE));
  constant P_NINE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(9, DATA_SIZE));

  constant N_ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-1, DATA_SIZE));
  constant N_TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-2, DATA_SIZE));
  constant N_THREE : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-3, DATA_SIZE));
  constant N_FOUR  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-4, DATA_SIZE));
  constant N_FIVE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-5, DATA_SIZE));
  constant N_SIX   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-6, DATA_SIZE));
  constant N_SEVEN : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-7, DATA_SIZE));
  constant N_EIGHT : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-8, DATA_SIZE));
  constant N_NINE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-9, DATA_SIZE));

  -- Buffer
  constant TENSOR_SAMPLE_A : tensor_buffer := (((P_TWO, P_ONE, P_FOUR), (P_NINE, P_FOUR, P_TWO), (P_ONE, P_ONE, P_TWO)), ((P_EIGHT, P_SIX, P_TWO), (P_EIGHT, P_FIVE, P_TWO), (P_ONE, P_FOUR, P_ONE)), ((P_THREE, P_ONE, P_SIX), (P_FIVE, P_ZERO, P_FOUR), (P_FIVE, P_EIGHT, P_FIVE)));
  constant TENSOR_SAMPLE_B : tensor_buffer := (((P_ONE, P_THREE, P_ONE), (P_TWO, P_FOUR, P_EIGHT), (P_FOUR, P_ONE, P_TWO)), ((P_NINE, P_ONE, P_FIVE), (P_NINE, P_EIGHT, P_ONE), (P_FIVE, P_EIGHT, P_FOUR)), ((P_FIVE, P_FOUR, P_ONE), (P_THREE, P_FOUR, P_SIX), (P_ONE, P_EIGHT, P_EIGHT)));

  constant MATRIX_SAMPLE_A : matrix_buffer := ((P_ONE, P_FOUR, P_ONE), (P_ZERO, P_EIGHT, P_FOUR), (P_FIVE, P_THREE, P_NINE));
  constant MATRIX_SAMPLE_B : matrix_buffer := ((P_ONE, P_TWO, P_SIX), (P_ONE, P_THREE, P_SIX), (P_EIGHT, P_FOUR, P_FOUR));

  constant VECTOR_SAMPLE_A : vector_buffer := (P_FOUR, P_SEVEN, N_THREE);
  constant VECTOR_SAMPLE_B : vector_buffer := (P_THREE, N_NINE, N_ONE);

  constant SCALAR_SAMPLE_A : std_logic_vector(DATA_SIZE-1 downto 0) := P_NINE;
  constant SCALAR_SAMPLE_B : std_logic_vector(DATA_SIZE-1 downto 0) := N_FOUR;

  -- FUNCTIONALITY
  signal STIMULUS_NTM_READ_HEADS_TEST   : boolean := false;
  signal STIMULUS_NTM_READ_HEADS_CASE_0 : boolean := false;
  signal STIMULUS_NTM_READ_HEADS_CASE_1 : boolean := false;

  -----------------------------------------------------------------------
  -- Components
  -----------------------------------------------------------------------

  component ntm_read_heads_stimulus is
    generic (
      -- SYSTEM-SIZE
      DATA_SIZE    : integer := 128;
      CONTROL_SIZE : integer := 64;

      X : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- x in 0 to X-1
      Y : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- y in 0 to Y-1
      N : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- j in 0 to N-1
      W : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- k in 0 to W-1
      L : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- l in 0 to L-1
      R : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE))  -- i in 0 to R-1
      );
    port (
      -- GLOBAL
      CLK : out std_logic;
      RST : out std_logic;

      -- CONTROL
      NTM_READ_HEADS_START : out std_logic;
      NTM_READ_HEADS_READY : in  std_logic;

      NTM_READ_HEADS_M_IN_J_ENABLE : out std_logic;
      NTM_READ_HEADS_M_IN_K_ENABLE : out std_logic;

      NTM_READ_HEADS_W_IN_ENABLE : out std_logic;

      NTM_READ_HEADS_M_OUT_J_ENABLE : in std_logic;
      NTM_READ_HEADS_M_OUT_K_ENABLE : in std_logic;

      NTM_READ_HEADS_W_OUT_ENABLE : in std_logic;

      NTM_READ_HEADS_R_OUT_ENABLE : in std_logic;

      -- DATA
      NTM_READ_HEADS_SIZE_N_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);
      NTM_READ_HEADS_SIZE_W_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);

      NTM_READ_HEADS_W_IN  : out std_logic_vector(DATA_SIZE-1 downto 0);
      NTM_READ_HEADS_M_IN  : out std_logic_vector(DATA_SIZE-1 downto 0);
      NTM_READ_HEADS_R_OUT : in  std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------

end ntm_read_heads_pkg;
