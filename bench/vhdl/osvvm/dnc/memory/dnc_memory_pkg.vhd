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

package dnc_memory_pkg is

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
  constant ZERO  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0, DATA_SIZE));
  constant ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(1, DATA_SIZE));
  constant TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2, DATA_SIZE));
  constant THREE : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(3, DATA_SIZE));
  constant FOUR  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(4, DATA_SIZE));
  constant FIVE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(5, DATA_SIZE));
  constant SIX   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(6, DATA_SIZE));
  constant SEVEN : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(7, DATA_SIZE));
  constant EIGHT : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(8, DATA_SIZE));
  constant NINE  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(9, DATA_SIZE));

  -- Buffer
  constant TENSOR_SAMPLE_A : tensor_buffer := (((TWO, ONE, FOUR), (NINE, FOUR, TWO), (ONE, ONE, TWO)), ((EIGHT, SIX, TWO), (EIGHT, FIVE, TWO), (ONE, FOUR, ONE)), ((THREE, ONE, SIX), (FIVE, ZERO, FOUR), (FIVE, EIGHT, FIVE)));
  constant TENSOR_SAMPLE_B : tensor_buffer := (((ONE, THREE, ONE), (TWO, FOUR, EIGHT), (FOUR, ONE, TWO)), ((NINE, ONE, FIVE), (NINE, EIGHT, ONE), (FIVE, EIGHT, FOUR)), ((FIVE, FOUR, ONE), (THREE, FOUR, SIX), (ONE, EIGHT, EIGHT)));

  constant MATRIX_SAMPLE_A : matrix_buffer := ((ONE, FOUR, ONE), (ZERO, EIGHT, FOUR), (FIVE, THREE, NINE));
  constant MATRIX_SAMPLE_B : matrix_buffer := ((ONE, TWO, SIX), (ONE, THREE, SIX), (EIGHT, FOUR, FOUR));

  constant VECTOR_SAMPLE_A : vector_buffer := (FOUR, NINE, THREE);
  constant VECTOR_SAMPLE_B : vector_buffer := (THREE, NINE, ZERO);

  -- FUNCTIONALITY
  signal STIMULUS_DNC_MEMORY_TEST   : boolean := false;
  signal STIMULUS_DNC_MEMORY_CASE_0 : boolean := false;
  signal STIMULUS_DNC_MEMORY_CASE_1 : boolean := false;

  -----------------------------------------------------------------------
  -- Components
  -----------------------------------------------------------------------

  component dnc_memory_stimulus is
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
      DNC_MEMORY_START : out std_logic;
      DNC_MEMORY_READY : in  std_logic;

      DNC_MEMORY_K_READ_IN_I_ENABLE : out std_logic;  -- for i out 0 to R-1
      DNC_MEMORY_K_READ_IN_K_ENABLE : out std_logic;  -- for k out 0 to W-1

      DNC_MEMORY_K_READ_OUT_I_ENABLE : in std_logic;  -- for i out 0 to R-1
      DNC_MEMORY_K_READ_OUT_K_ENABLE : in std_logic;  -- for k out 0 to W-1

      DNC_MEMORY_BETA_READ_IN_ENABLE : out std_logic;  -- for i out 0 to R-1

      DNC_MEMORY_BETA_READ_OUT_ENABLE : in std_logic;  -- for i out 0 to R-1

      DNC_MEMORY_F_READ_IN_ENABLE : out std_logic;  -- for i out 0 to R-1

      DNC_MEMORY_F_READ_OUT_ENABLE : in std_logic;  -- for i out 0 to R-1

      DNC_MEMORY_PI_READ_IN_ENABLE : out std_logic;  -- for i out 0 to R-1

      DNC_MEMORY_PI_READ_OUT_ENABLE : in std_logic;  -- for i out 0 to R-1

      DNC_MEMORY_K_WRITE_IN_K_ENABLE : out std_logic;  -- for k out 0 to W-1
      DNC_MEMORY_E_WRITE_IN_K_ENABLE : out std_logic;  -- for k out 0 to W-1
      DNC_MEMORY_V_WRITE_IN_K_ENABLE : out std_logic;  -- for k out 0 to W-1

      DNC_MEMORY_K_WRITE_OUT_K_ENABLE : in std_logic;  -- for k out 0 to W-1
      DNC_MEMORY_E_WRITE_OUT_K_ENABLE : in std_logic;  -- for k out 0 to W-1
      DNC_MEMORY_V_WRITE_OUT_K_ENABLE : in std_logic;  -- for k out 0 to W-1

      DNC_MEMORY_R_OUT_I_ENABLE : in std_logic;  -- for i out 0 to R-1
      DNC_MEMORY_R_OUT_K_ENABLE : in std_logic;  -- for k out 0 to W-1

      -- DATA
      DNC_MEMORY_SIZE_R_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);
      DNC_MEMORY_SIZE_W_IN : out std_logic_vector(CONTROL_SIZE-1 downto 0);

      DNC_MEMORY_K_READ_IN    : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_BETA_READ_IN : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_F_READ_IN    : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_PI_READ_IN   : out std_logic_vector(DATA_SIZE-1 downto 0);

      DNC_MEMORY_K_WRITE_IN    : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_BETA_WRITE_IN : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_E_WRITE_IN    : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_V_WRITE_IN    : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_GA_WRITE_IN   : out std_logic_vector(DATA_SIZE-1 downto 0);
      DNC_MEMORY_GW_WRITE_IN   : out std_logic_vector(DATA_SIZE-1 downto 0);

      DNC_MEMORY_R_OUT : in std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------

end dnc_memory_pkg;
