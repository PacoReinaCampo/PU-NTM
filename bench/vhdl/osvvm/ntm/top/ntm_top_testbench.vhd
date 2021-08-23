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

use work.ntm_math_pkg.all;
use work.ntm_lstm_controller_pkg.all;
use work.ntm_core_pkg.all;

entity ntm_top_testbench is
end ntm_top_testbench;

architecture ntm_top_testbench_architecture of ntm_top_testbench is

  -----------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------

  -- GLOBAL
  signal CLK : std_logic;
  signal RST : std_logic;

  -- TOP
  -- CONTROL
  signal start_top : std_logic;
  signal ready_top : std_logic;

  -- DATA
  signal x_in_top : std_logic_arithmetic_vector_vector(X-1 downto 0)(DATA_SIZE-1 downto 0);
  signal r_in_top : std_logic_arithmetic_vector_vector(W-1 downto 0)(DATA_SIZE-1 downto 0);
  signal w_in_top : std_logic_arithmetic_vector_vector(N-1 downto 0)(DATA_SIZE-1 downto 0);
  signal u_in_top : std_logic_arithmetic_vector_vector(N-1 downto 0)(DATA_SIZE-1 downto 0);

  signal modulo_top : std_logic_arithmetic_vector_vector(Y-1 downto 0)(DATA_SIZE-1 downto 0);
  signal y_out_top  : std_logic_arithmetic_vector_vector(Y-1 downto 0)(DATA_SIZE-1 downto 0);

begin

  -----------------------------------------------------------------------
  -- Body
  -----------------------------------------------------------------------

  -- TOP
  top : ntm_top
    generic map (
      X => X,
      Y => Y,
      N => N,
      W => W,

      DATA_SIZE => DATA_SIZE
    )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_top,
      READY => ready_top,

      -- DATA
      X_IN   => x_in_top,
      R_IN   => r_in_top,
      W_IN   => w_in_top,
      U_IN   => u_in_top,

      MODULO => modulo_top,
      Y_OUT  => y_out_top
    );

end ntm_top_testbench_architecture;