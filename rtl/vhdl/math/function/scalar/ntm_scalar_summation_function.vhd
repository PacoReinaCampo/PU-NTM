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

entity ntm_scalar_summation_function is
  generic (
    DATA_SIZE  : integer := 512;
    INDEX_SIZE : integer := 512
    );
  port (
    -- GLOBAL
    CLK : in std_logic;
    RST : in std_logic;

    -- CONTROL
    START : in  std_logic;
    READY : out std_logic;

    DATA_IN_ENABLE : in std_logic;

    DATA_OUT_ENABLE : out std_logic;

    -- DATA
    MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
    LENGTH_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
    DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
    DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
    );
end entity;

architecture ntm_scalar_summation_function_architecture of ntm_scalar_summation_function is

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  type summation_ctrl_fsm is (
    STARTER_STATE,                      -- STEP 0
    INPUT_STATE,                        -- STEP 1
    SCALAR_ADDER_STATE                  -- STEP 2
    );

  -----------------------------------------------------------------------
  -- Constants
  -----------------------------------------------------------------------

  constant ZERO  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0, DATA_SIZE));
  constant ONE   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(1, DATA_SIZE));
  constant TWO   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2, DATA_SIZE));
  constant THREE : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(3, DATA_SIZE));

  constant FULL  : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '1');
  constant EMPTY : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '0');

  constant EULER : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '0');

  -----------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------

  -- Finite State Machine
  signal summation_ctrl_fsm_int : summation_ctrl_fsm;

  -- Control Internal
  signal index_loop : std_logic_vector(INDEX_SIZE-1 downto 0);

  -- SCALAR ADDER
  -- CONTROL
  signal start_scalar_adder : std_logic;
  signal ready_scalar_adder : std_logic;

  signal operation_scalar_adder : std_logic;

  -- DATA
  signal modulo_in_scalar_adder : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_a_in_scalar_adder : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_b_in_scalar_adder : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_scalar_adder  : std_logic_vector(DATA_SIZE-1 downto 0);

begin

  -----------------------------------------------------------------------
  -- Body
  -----------------------------------------------------------------------

  -- CONTROL
  ctrl_fsm : process(CLK, RST)
  begin
    if (RST = '0') then
      -- Data Outputs
      DATA_OUT <= ZERO;

      -- Control Outputs
      READY <= '0';

      -- Control Internal
      index_loop <= ZERO;

    elsif (rising_edge(CLK)) then

      case summation_ctrl_fsm_int is
        when STARTER_STATE =>  -- STEP 0
          -- Control Outputs
          READY <= '0';

          if (START = '1') then
            -- Control Internal
            index_loop <= ZERO;

            -- FSM Control
            summation_ctrl_fsm_int <= INPUT_STATE;
          end if;

        when INPUT_STATE =>  -- STEP 1

          if (DATA_IN_ENABLE = '1') then
            -- Data Inputs
            modulo_in_scalar_adder <= MODULO_IN;

            data_a_in_scalar_adder <= DATA_IN;
            data_b_in_scalar_adder <= data_out_scalar_adder;

            -- Control Internal
            start_scalar_adder <= '1';

            -- FSM Control
            summation_ctrl_fsm_int <= SCALAR_ADDER_STATE;
          else
            -- Control Outputs
            DATA_OUT_ENABLE <= '0';
          end if;

        when SCALAR_ADDER_STATE =>  -- STEP 2

          if (ready_scalar_adder = '1') then
            if (unsigned(index_loop) = unsigned(LENGTH_IN)-unsigned(ONE)) then
              -- Control Outputs
              READY <= '1';

              -- FSM Control
              summation_ctrl_fsm_int <= STARTER_STATE;
            else
              -- Control Internal
              index_loop <= std_logic_vector(unsigned(index_loop)+unsigned(ONE));

              -- FSM Control
              summation_ctrl_fsm_int <= INPUT_STATE;
            end if;

            -- Data Outputs
            DATA_OUT <= data_out_scalar_adder;

            -- Control Outputs
            DATA_OUT_ENABLE <= '1';
          else
            -- Control Internal
            start_scalar_adder <= '0';
          end if;

        when others =>
          -- FSM Control
          summation_ctrl_fsm_int <= STARTER_STATE;
      end case;
    end if;
  end process;

  -- SCALAR ADDER
  scalar_adder : ntm_scalar_adder
    generic map (
      DATA_SIZE  => DATA_SIZE,
      INDEX_SIZE => INDEX_SIZE
      )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_adder,
      READY => ready_scalar_adder,

      OPERATION => operation_scalar_adder,

      -- DATA
      MODULO_IN => modulo_in_scalar_adder,
      DATA_A_IN => data_a_in_scalar_adder,
      DATA_B_IN => data_b_in_scalar_adder,
      DATA_OUT  => data_out_scalar_adder
      );

end architecture;
