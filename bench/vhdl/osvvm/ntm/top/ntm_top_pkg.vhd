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

package ntm_top_pkg is

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  -- SYSTEM-SIZE
  constant DATA_SIZE : integer := 64;

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
  constant X : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- x in 0 to X-1
  constant Y : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- y in 0 to Y-1
  constant N : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- j in 0 to N-1
  constant W : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- k in 0 to W-1
  constant L : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- l in 0 to L-1
  constant R : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- i in 0 to R-1

  -- INTEGERS
  constant INT_P_ZERO  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(0, DATA_SIZE));
  constant INT_P_ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(1, DATA_SIZE));
  constant INT_P_TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(2, DATA_SIZE));
  constant INT_P_THREE : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(3, DATA_SIZE));
  constant INT_P_FOUR  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(4, DATA_SIZE));
  constant INT_P_FIVE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(5, DATA_SIZE));
  constant INT_P_SIX   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(6, DATA_SIZE));
  constant INT_P_SEVEN : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(7, DATA_SIZE));
  constant INT_P_EIGHT : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(8, DATA_SIZE));
  constant INT_P_NINE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(9, DATA_SIZE));

  constant INT_N_ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-1, DATA_SIZE));
  constant INT_N_TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-2, DATA_SIZE));
  constant INT_N_THREE : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-3, DATA_SIZE));
  constant INT_N_FOUR  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-4, DATA_SIZE));
  constant INT_N_FIVE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-5, DATA_SIZE));
  constant INT_N_SIX   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-6, DATA_SIZE));
  constant INT_N_SEVEN : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-7, DATA_SIZE));
  constant INT_N_EIGHT : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-8, DATA_SIZE));
  constant INT_N_NINE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_signed(-9, DATA_SIZE));

  -- FLOATS
  constant FLOAT_P_ZERO  : std_logic_vector(DATA_SIZE-1 downto 0) := X"0000000000000000";
  constant FLOAT_P_ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := X"3FF199999999999A";
  constant FLOAT_P_TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := X"400199999999999A";
  constant FLOAT_P_THREE : std_logic_vector(DATA_SIZE-1 downto 0) := X"400A666666666666";
  constant FLOAT_P_FOUR  : std_logic_vector(DATA_SIZE-1 downto 0) := X"401199999999999A";
  constant FLOAT_P_FIVE  : std_logic_vector(DATA_SIZE-1 downto 0) := X"4016000000000000";
  constant FLOAT_P_SIX   : std_logic_vector(DATA_SIZE-1 downto 0) := X"401A666666666666";
  constant FLOAT_P_SEVEN : std_logic_vector(DATA_SIZE-1 downto 0) := X"401ECCCCCCCCCCCD";
  constant FLOAT_P_EIGHT : std_logic_vector(DATA_SIZE-1 downto 0) := X"402199999999999A";
  constant FLOAT_P_NINE  : std_logic_vector(DATA_SIZE-1 downto 0) := X"4023CCCCCCCCCCCD";
  constant FLOAT_P_INF   : std_logic_vector(DATA_SIZE-1 downto 0) := X"7FF0000000000000";

  constant FLOAT_N_ZERO  : std_logic_vector(DATA_SIZE-1 downto 0) := X"8000000000000000";
  constant FLOAT_N_ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := X"BFF199999999999A";
  constant FLOAT_N_TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := X"C00199999999999A";
  constant FLOAT_N_THREE : std_logic_vector(DATA_SIZE-1 downto 0) := X"C00A666666666666";
  constant FLOAT_N_FOUR  : std_logic_vector(DATA_SIZE-1 downto 0) := X"C01199999999999A";
  constant FLOAT_N_FIVE  : std_logic_vector(DATA_SIZE-1 downto 0) := X"C016000000000000";
  constant FLOAT_N_SIX   : std_logic_vector(DATA_SIZE-1 downto 0) := X"C01A666666666666";
  constant FLOAT_N_SEVEN : std_logic_vector(DATA_SIZE-1 downto 0) := X"C01ECCCCCCCCCCCD";
  constant FLOAT_N_EIGHT : std_logic_vector(DATA_SIZE-1 downto 0) := X"C02199999999999A";
  constant FLOAT_N_NINE  : std_logic_vector(DATA_SIZE-1 downto 0) := X"C023CCCCCCCCCCCD";
  constant FLOAT_N_INF   : std_logic_vector(DATA_SIZE-1 downto 0) := X"FFF0000000000000";

  -- Buffer
  constant TENSOR_SAMPLE_A : tensor_buffer := (((FLOAT_P_TWO, FLOAT_P_ONE, FLOAT_P_FOUR), (FLOAT_P_NINE, FLOAT_P_FOUR, FLOAT_P_TWO), (FLOAT_P_ONE, FLOAT_P_ONE, FLOAT_P_TWO)), ((FLOAT_P_EIGHT, FLOAT_P_SIX, FLOAT_P_TWO), (FLOAT_P_EIGHT, FLOAT_P_FIVE, FLOAT_P_TWO), (FLOAT_P_ONE, FLOAT_P_FOUR, FLOAT_P_ONE)), ((FLOAT_P_THREE, FLOAT_P_ONE, FLOAT_P_SIX), (FLOAT_P_FIVE, FLOAT_P_ZERO, FLOAT_P_FOUR), (FLOAT_P_FIVE, FLOAT_P_EIGHT, FLOAT_P_FIVE)));
  constant TENSOR_SAMPLE_B : tensor_buffer := (((FLOAT_P_ONE, FLOAT_P_THREE, FLOAT_P_ONE), (FLOAT_P_TWO, FLOAT_P_FOUR, FLOAT_P_EIGHT), (FLOAT_P_FOUR, FLOAT_P_ONE, FLOAT_P_TWO)), ((FLOAT_P_NINE, FLOAT_P_ONE, FLOAT_P_FIVE), (FLOAT_P_NINE, FLOAT_P_EIGHT, FLOAT_P_ONE), (FLOAT_P_FIVE, FLOAT_P_EIGHT, FLOAT_P_FOUR)), ((FLOAT_P_FIVE, FLOAT_P_FOUR, FLOAT_P_ONE), (FLOAT_P_THREE, FLOAT_P_FOUR, FLOAT_P_SIX), (FLOAT_P_ONE, FLOAT_P_EIGHT, FLOAT_P_EIGHT)));

  constant MATRIX_SAMPLE_A : matrix_buffer := ((FLOAT_P_ONE, FLOAT_P_FOUR, FLOAT_P_ONE), (FLOAT_P_ZERO, FLOAT_P_EIGHT, FLOAT_P_FOUR), (FLOAT_P_FIVE, FLOAT_P_THREE, FLOAT_P_NINE));
  constant MATRIX_SAMPLE_B : matrix_buffer := ((FLOAT_P_ONE, FLOAT_P_TWO, FLOAT_P_SIX), (FLOAT_P_ONE, FLOAT_P_THREE, FLOAT_P_SIX), (FLOAT_P_EIGHT, FLOAT_P_FOUR, FLOAT_P_FOUR));

  constant VECTOR_SAMPLE_A : vector_buffer := (FLOAT_P_FOUR, FLOAT_P_SEVEN, FLOAT_N_THREE);
  constant VECTOR_SAMPLE_B : vector_buffer := (FLOAT_P_THREE, FLOAT_N_NINE, FLOAT_N_ONE);

  constant SCALAR_SAMPLE_A : std_logic_vector(DATA_SIZE-1 downto 0) := FLOAT_P_NINE;
  constant SCALAR_SAMPLE_B : std_logic_vector(DATA_SIZE-1 downto 0) := FLOAT_N_FOUR;

  -- FUNCTIONALITY
  signal STIMULUS_NTM_TOP_TEST   : boolean := false;
  signal STIMULUS_NTM_TOP_CASE_0 : boolean := false;
  signal STIMULUS_NTM_TOP_CASE_1 : boolean := false;

  -----------------------------------------------------------------------
  -- Components
  -----------------------------------------------------------------------

  component ntm_top_stimulus is
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
      NTM_TOP_START : out std_logic;
      NTM_TOP_READY : in  std_logic;

      NTM_TOP_W_IN_L_ENABLE : out std_logic;
      NTM_TOP_W_IN_X_ENABLE : out std_logic;

      NTM_TOP_W_OUT_L_ENABLE : in std_logic;
      NTM_TOP_W_OUT_X_ENABLE : in std_logic;

      NTM_TOP_K_IN_I_ENABLE : out std_logic;
      NTM_TOP_K_IN_L_ENABLE : out std_logic;
      NTM_TOP_K_IN_K_ENABLE : out std_logic;

      NTM_TOP_K_OUT_I_ENABLE : in std_logic;
      NTM_TOP_K_OUT_L_ENABLE : in std_logic;
      NTM_TOP_K_OUT_K_ENABLE : in std_logic;

      NTM_TOP_U_IN_L_ENABLE : out std_logic;
      NTM_TOP_U_IN_P_ENABLE : out std_logic;

      NTM_TOP_U_OUT_L_ENABLE : in std_logic;
      NTM_TOP_U_OUT_P_ENABLE : in std_logic;

      NTM_TOP_B_IN_ENABLE : out std_logic;

      NTM_TOP_B_OUT_ENABLE : in std_logic;

      NTM_TOP_X_IN_ENABLE : out std_logic;

      NTM_TOP_X_OUT_ENABLE : in std_logic;

      NTM_TOP_Y_OUT_ENABLE : in std_logic;

      -- DATA
      NTM_TOP_SIZE_X_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);
      NTM_TOP_SIZE_Y_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);
      NTM_TOP_SIZE_N_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);
      NTM_TOP_SIZE_W_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);
      NTM_TOP_SIZE_L_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);
      NTM_TOP_SIZE_R_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);

      NTM_TOP_W_IN : out std_logic_vector(DATA_SIZE-1 downto 0);
      NTM_TOP_K_IN : out std_logic_vector(DATA_SIZE-1 downto 0);
      NTM_TOP_U_IN : out std_logic_vector(DATA_SIZE-1 downto 0);
      NTM_TOP_B_IN : out std_logic_vector(DATA_SIZE-1 downto 0);

      NTM_TOP_X_IN  : out std_logic_vector(DATA_SIZE-1 downto 0);
      NTM_TOP_Y_OUT : in  std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_top is
    generic (
      DATA_SIZE    : integer := 128;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      W_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1
      W_IN_X_ENABLE : in std_logic;     -- for x in 0 to X-1

      W_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1
      W_OUT_X_ENABLE : out std_logic;   -- for x in 0 to X-1

      K_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1 (read heads flow)
      K_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1
      K_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      K_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      K_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1
      K_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      U_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1
      U_IN_P_ENABLE : in std_logic;     -- for p in 0 to L-1

      U_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1
      U_OUT_P_ENABLE : out std_logic;   -- for p in 0 to L-1

      B_IN_ENABLE : in std_logic;       -- for l in 0 to L-1

      B_OUT_ENABLE : out std_logic;     -- for l in 0 to L-1

      X_IN_ENABLE : in std_logic;       -- for x in 0 to X-1

      X_OUT_ENABLE : out std_logic;     -- for x in 0 to X-1

      Y_OUT_ENABLE : out std_logic;     -- for y in 0 to Y-1

      -- DATA
      SIZE_X_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_Y_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_L_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      U_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      X_IN  : in  std_logic_vector(DATA_SIZE-1 downto 0);
      Y_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_interface_vector is
    generic (
      DATA_SIZE    : integer := 128;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      -- Key Vector
      WK_IN_L_ENABLE : in std_logic;    -- for l in 0 to L-1
      WK_IN_K_ENABLE : in std_logic;    -- for k in 0 to W-1

      WK_OUT_L_ENABLE : out std_logic;  -- for l in 0 to L-1
      WK_OUT_K_ENABLE : out std_logic;  -- for k in 0 to W-1

      K_OUT_ENABLE : out std_logic;     -- for k in 0 to W-1

      -- Key Strength
      WBETA_IN_ENABLE : in std_logic;   -- for l in 0 to L-1

      WBETA_OUT_ENABLE : out std_logic;  -- for l in 0 to L-1

      -- Interpolation Gate
      WG_IN_ENABLE : in std_logic;      -- for l in 0 to L-1

      WG_OUT_ENABLE : out std_logic;    -- for l in 0 to L-1

      -- Shift Weighting
      WS_IN_L_ENABLE : in std_logic;    -- for l in 0 to L-1
      WS_IN_J_ENABLE : in std_logic;    -- for j in 0 to N-1

      WS_OUT_L_ENABLE : out std_logic;  -- for l in 0 to L-1
      WS_OUT_J_ENABLE : out std_logic;  -- for j in 0 to N-1

      S_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      -- Sharpening
      WGAMMA_IN_ENABLE : in std_logic;  -- for l in 0 to L-1

      WGAMMA_OUT_ENABLE : out std_logic;  -- for l in 0 to L-1

      -- Hidden State
      H_IN_ENABLE : in std_logic;       -- for l in 0 to L-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_L_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      WK_IN     : in std_logic_vector(DATA_SIZE-1 downto 0);
      WBETA_IN  : in std_logic_vector(DATA_SIZE-1 downto 0);
      WG_IN     : in std_logic_vector(DATA_SIZE-1 downto 0);
      WS_IN     : in std_logic_vector(DATA_SIZE-1 downto 0);
      WGAMMA_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      H_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      K_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0);
      G_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      S_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      GAMMA_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_output_vector is
    generic (
      DATA_SIZE    : integer := 128;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      K_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      K_IN_Y_ENABLE : in std_logic;     -- for y in 0 to Y-1
      K_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      K_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      K_OUT_Y_ENABLE : out std_logic;   -- for y in 0 to Y-1
      K_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      R_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      R_IN_K_ENABLE : in std_logic;     -- for j in 0 to W-1

      R_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      R_OUT_K_ENABLE : out std_logic;   -- for j in 0 to W-1

      U_IN_Y_ENABLE : in std_logic;     -- for y in 0 to Y-1
      U_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1

      U_OUT_Y_ENABLE : out std_logic;   -- for y in 0 to Y-1
      U_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1

      H_IN_ENABLE : in std_logic;       -- for l in 0 to L-1

      H_OUT_ENABLE : out std_logic;     -- for l in 0 to L-1

      Y_OUT_ENABLE : out std_logic;     -- for y in 0 to Y-1

      -- DATA
      SIZE_Y_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_L_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      K_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      R_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      U_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      H_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      Y_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------

end ntm_top_pkg;
