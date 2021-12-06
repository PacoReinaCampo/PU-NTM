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
-- Author(s):
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ntm_math_pkg.all;
use work.ntm_memory_pkg.all;

entity ntm_memory_stimulus is
  generic (
    -- SYSTEM-SIZE
    DATA_SIZE  : integer := 512;
    INDEX_SIZE : integer := 512;

    X : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- x in 0 to X-1
    Y : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- y in 0 to Y-1
    N : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- j in 0 to N-1
    W : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- k in 0 to W-1
    L : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE));  -- l in 0 to L-1
    R : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(64, DATA_SIZE))   -- i in 0 to R-1
    );
  port (
    -- GLOBAL
    CLK : out std_logic;
    RST : out std_logic;

    -- CONTROL
    NTM_MEMORY_START : out std_logic;
    NTM_MEMORY_READY : in  std_logic;

    NTM_MEMORY_K_IN_ENABLE : out std_logic;
    NTM_MEMORY_S_IN_ENABLE : out std_logic;

    NTM_MEMORY_K_OUT_ENABLE : in std_logic;
    NTM_MEMORY_S_OUT_ENABLE : in std_logic;

    NTM_MEMORY_M_IN_J_ENABLE : out std_logic;
    NTM_MEMORY_M_IN_K_ENABLE : out std_logic;

    NTM_MEMORY_M_OUT_J_ENABLE : in std_logic;
    NTM_MEMORY_M_OUT_K_ENABLE : in std_logic;


    NTM_MEMORY_W_IN_ENABLE  : out std_logic;
    NTM_MEMORY_W_OUT_ENABLE : in  std_logic;

    -- DATA
    NTM_MEMORY_SIZE_N_IN : out std_logic_vector(DATA_SIZE-1 downto 0);
    NTM_MEMORY_SIZE_W_IN : out std_logic_vector(DATA_SIZE-1 downto 0);

    NTM_MEMORY_K_IN     : out std_logic_vector(DATA_SIZE-1 downto 0);
    NTM_MEMORY_BETA_IN  : out std_logic_vector(DATA_SIZE-1 downto 0);
    NTM_MEMORY_G_IN     : out std_logic_vector(DATA_SIZE-1 downto 0);
    NTM_MEMORY_S_IN     : out std_logic_vector(DATA_SIZE-1 downto 0);
    NTM_MEMORY_GAMMA_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);

    NTM_MEMORY_M_IN : out std_logic_vector(DATA_SIZE-1 downto 0);

    NTM_MEMORY_W_IN  : out std_logic_vector(DATA_SIZE-1 downto 0);
    NTM_MEMORY_W_OUT : in  std_logic_vector(DATA_SIZE-1 downto 0)
    );
end entity;

architecture ntm_memory_stimulus_architecture of ntm_memory_stimulus is

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- Constants
  -----------------------------------------------------------------------

  constant PERIOD : time := 10 ns;

  constant WAITING : time := 50 ns;
  constant WORKING : time := 1 ms;

  -----------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------

  -- GLOBAL
  signal clk_int : std_logic;
  signal rst_int : std_logic;

  -- CONTROL
  signal start_int : std_logic;

begin

  -----------------------------------------------------------------------
  -- Body
  -----------------------------------------------------------------------

  -- clk generation
  clk_process : process
  begin
    clk_int <= '1';
    wait for PERIOD/2;

    clk_int <= '0';
    wait for PERIOD/2;
  end process;

  -- rst generation
  rst_process : process
  begin
    rst_int <= '0';
    wait for WAITING;

    rst_int <= '1';
    wait for WORKING;
  end process;

  -- start generation
  start_process : process
  begin
    start_int <= '0';
    wait for WAITING;

    start_int <= '1';
    wait for PERIOD;

    start_int <= '0';
    wait for WORKING;
  end process;

  -----------------------------------------------------------------------
  -- STIMULUS
  -----------------------------------------------------------------------

  main_test : process
  begin

    if (STIMULUS_NTM_MEMORY_TEST) then

      -------------------------------------------------------------------
      MONITOR_TEST <= "NTM_MEMORY_TEST                         ";
      -------------------------------------------------------------------

      -------------------------------------------------------------------
      MONITOR_CASE <= "NTM_MEMORY_CASE_0                       ";
      -------------------------------------------------------------------

      -------------------------------------------------------------------
      MONITOR_CASE <= "NTM_MEMORY_CASE_1                       ";
      -------------------------------------------------------------------

    end if;

    assert false
      report "END OF TEST"
      severity failure;

  end process main_test;

end architecture;
