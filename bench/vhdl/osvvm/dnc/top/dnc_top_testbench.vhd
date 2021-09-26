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
use work.dnc_core_pkg.all;
use work.dnc_top_pkg.all;

entity dnc_top_testbench is
  generic (
    -- SYSTEM-SIZE
    DATA_SIZE : integer := 512;

    X : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- x in 0 to X-1
    Y : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- y in 0 to Y-1
    N : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- j in 0 to N-1
    W : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- k in 0 to W-1
    L : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- l in 0 to L-1
    R : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- i in 0 to R-1

    -- FUNCTIONALITY
    ENABLE_DNC_TOP_TEST   : boolean := false;
    ENABLE_DNC_TOP_CASE_0 : boolean := false;
    ENABLE_DNC_TOP_CASE_1 : boolean := false
    );
end dnc_top_testbench;

architecture dnc_top_testbench_architecture of dnc_top_testbench is

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

  signal w_in_l_enable_top : std_logic;
  signal w_in_x_enable_top : std_logic;

  signal k_in_i_enable_top : std_logic;
  signal k_in_l_enable_top : std_logic;
  signal k_in_k_enable_top : std_logic;

  signal b_in_enable_top : std_logic;

  signal x_in_enable_top  : std_logic;
  signal y_out_enable_top : std_logic;

  -- DATA
  signal size_x_in_top : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_y_in_top : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_n_in_top : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_w_in_top : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_l_in_top : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_r_in_top : std_logic_vector(DATA_SIZE-1 downto 0);

  signal w_in_top : std_logic_vector(DATA_SIZE-1 downto 0);
  signal k_in_top : std_logic_vector(DATA_SIZE-1 downto 0);
  signal b_in_top : std_logic_vector(DATA_SIZE-1 downto 0);

  signal x_in_top  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal y_out_top : std_logic_vector(DATA_SIZE-1 downto 0);

begin

  -----------------------------------------------------------------------
  -- Body
  -----------------------------------------------------------------------

  top_stimulus : dnc_top_stimulus
    generic map (
      -- SYSTEM-SIZE
      DATA_SIZE => DATA_SIZE,

      X => X,
      Y => Y,
      N => N,
      W => W,
      L => L,
      R => R,

      -- FUNCTIONALITY
      STIMULUS_DNC_TOP_TEST   => STIMULUS_DNC_TOP_TEST,
      STIMULUS_DNC_TOP_CASE_0 => STIMULUS_DNC_TOP_CASE_0,
      STIMULUS_DNC_TOP_CASE_1 => STIMULUS_DNC_TOP_CASE_1
      )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      DNC_TOP_START => start_top,
      DNC_TOP_READY => ready_top,

      DNC_TOP_W_IN_L_ENABLE => w_in_l_enable_top,
      DNC_TOP_W_IN_X_ENABLE => w_in_x_enable_top,

      DNC_TOP_K_IN_I_ENABLE => k_in_i_enable_top,
      DNC_TOP_K_IN_L_ENABLE => k_in_l_enable_top,
      DNC_TOP_K_IN_K_ENABLE => k_in_k_enable_top,

      DNC_TOP_B_IN_ENABLE => b_in_enable_top,

      DNC_TOP_X_IN_ENABLE  => x_in_enable_top,
      DNC_TOP_Y_OUT_ENABLE => y_out_enable_top,

      -- DATA
      DNC_TOP_SIZE_X_IN => size_x_in_top,
      DNC_TOP_SIZE_Y_IN => size_y_in_top,
      DNC_TOP_SIZE_N_IN => size_n_in_top,
      DNC_TOP_SIZE_W_IN => size_w_in_top,
      DNC_TOP_SIZE_L_IN => size_l_in_top,
      DNC_TOP_SIZE_R_IN => size_r_in_top,

      DNC_TOP_W_IN => w_in_top,
      DNC_TOP_K_IN => k_in_top,
      DNC_TOP_B_IN => b_in_top,

      DNC_TOP_X_IN  => x_in_top,
      DNC_TOP_Y_OUT => y_out_top
      );

  -- TOP
  dnc_top_test : if (ENABLE_DNC_TOP_TEST) generate
    top : dnc_top
      generic map (
        DATA_SIZE => DATA_SIZE
        )
      port map (
        -- GLOBAL
        CLK => CLK,
        RST => RST,

        -- CONTROL
        START => start_top,
        READY => ready_top,

        W_IN_L_ENABLE => w_in_l_enable_top,
        W_IN_X_ENABLE => w_in_x_enable_top,

        K_IN_I_ENABLE => k_in_i_enable_top,
        K_IN_L_ENABLE => k_in_l_enable_top,
        K_IN_K_ENABLE => k_in_k_enable_top,

        B_IN_ENABLE => b_in_enable_top,

        X_IN_ENABLE  => x_in_enable_top,
        Y_OUT_ENABLE => y_out_enable_top,

        -- DATA
        SIZE_X_IN => size_x_in_top,
        SIZE_Y_IN => size_y_in_top,
        SIZE_N_IN => size_n_in_top,
        SIZE_W_IN => size_w_in_top,
        SIZE_L_IN => size_l_in_top,
        SIZE_R_IN => size_r_in_top,

        W_IN => w_in_top,
        K_IN => k_in_top,
        B_IN => b_in_top,

        X_IN  => x_in_top,
        Y_OUT => y_out_top
        );
  end generate dnc_top_test;

end dnc_top_testbench_architecture;
