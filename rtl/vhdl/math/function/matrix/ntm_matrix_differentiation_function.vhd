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

entity ntm_matrix_differentiation_function is
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

    DATA_IN_MATRIX_ENABLE : in std_logic;
    DATA_IN_VECTOR_ENABLE : in std_logic;
    DATA_IN_SCALAR_ENABLE : in std_logic;

    DATA_OUT_MATRIX_ENABLE : out std_logic;
    DATA_OUT_VECTOR_ENABLE : out std_logic;
    DATA_OUT_SCALAR_ENABLE : out std_logic;

    -- DATA
    MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
    SIZE_I_IN : in  std_logic_vector(INDEX_SIZE-1 downto 0);
    SIZE_J_IN : in  std_logic_vector(INDEX_SIZE-1 downto 0);
    PERIOD_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
    LENGTH_IN : in  std_logic_vector(INDEX_SIZE-1 downto 0);
    DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
    DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
    );
end entity;

architecture ntm_matrix_differentiation_function_architecture of ntm_matrix_differentiation_function is

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  type differentiation_ctrl_fsm is (
    STARTER_STATE,                      -- STEP 0
    INPUT_MATRIX_STATE,                 -- STEP 1
    INPUT_VECTOR_STATE,                 -- STEP 2
    INPUT_SCALAR_STATE,                 -- STEP 3
    ENDER_STATE                         -- STEP 4
    );

  -----------------------------------------------------------------------
  -- Constants

  constant ZERO_INDEX : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0, DATA_SIZE));
  constant ONE_INDEX  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(1, DATA_SIZE));

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
  signal differentiation_ctrl_fsm_int : differentiation_ctrl_fsm;

  -- Internal Signals
  signal index_matrix_loop : std_logic_vector(INDEX_SIZE-1 downto 0);
  signal index_vector_loop : std_logic_vector(INDEX_SIZE-1 downto 0);
  signal index_scalar_loop : std_logic_vector(INDEX_SIZE-1 downto 0);

  -- SOFTMAX
  -- CONTROL
  signal start_vector_differentiation : std_logic;
  signal ready_vector_differentiation : std_logic;

  signal data_in_vector_enable_vector_differentiation : std_logic;
  signal data_in_scalar_enable_vector_differentiation : std_logic;

  signal data_out_vector_enable_vector_differentiation : std_logic;
  signal data_out_scalar_enable_vector_differentiation : std_logic;

  -- DATA
  signal modulo_in_vector_differentiation : std_logic_vector(DATA_SIZE-1 downto 0);
  signal size_in_vector_differentiation   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal period_in_vector_differentiation : std_logic_vector(DATA_SIZE-1 downto 0);
  signal length_in_vector_differentiation : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_in_vector_differentiation   : std_logic_vector(DATA_SIZE-1 downto 0);
  signal data_out_vector_differentiation  : std_logic_vector(DATA_SIZE-1 downto 0);

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

      -- Assignations
      index_matrix_loop <= ZERO_INDEX;
      index_vector_loop <= ZERO_INDEX;
      index_scalar_loop <= ZERO_INDEX;

    elsif (rising_edge(CLK)) then

      case differentiation_ctrl_fsm_int is
        when STARTER_STATE =>  -- STEP 0
          -- Control Outputs
          READY <= '0';

          if (START = '1') then
            -- Assignations
            index_matrix_loop <= ZERO_INDEX;
            index_vector_loop <= ZERO_INDEX;
            index_scalar_loop <= ZERO_INDEX;

            -- FSM Control
            differentiation_ctrl_fsm_int <= INPUT_MATRIX_STATE;
          end if;

        when INPUT_MATRIX_STATE =>  -- STEP 1

          if (DATA_IN_MATRIX_ENABLE = '1') then
            -- Data Inputs
            modulo_in_vector_differentiation <= MODULO_IN;

            data_in_vector_differentiation <= DATA_IN;

            if (index_matrix_loop = ZERO_INDEX) then
              -- Control Internal
              start_vector_differentiation <= '1';
            end if;

            data_in_vector_enable_vector_differentiation <= '1';
            data_in_scalar_enable_vector_differentiation <= '1';

            -- FSM Control
            differentiation_ctrl_fsm_int <= ENDER_STATE;
          else
            -- Control Internal
            data_in_vector_enable_vector_differentiation <= '0';
            data_in_scalar_enable_vector_differentiation <= '0';
          end if;

          -- Control Outputs
          DATA_OUT_MATRIX_ENABLE <= '0';
          DATA_OUT_VECTOR_ENABLE <= '0';
          DATA_OUT_SCALAR_ENABLE <= '0';

        when INPUT_VECTOR_STATE =>  -- STEP 1

          if (DATA_IN_VECTOR_ENABLE = '1') then
            -- Data Inputs
            modulo_in_vector_differentiation <= MODULO_IN;
            size_in_vector_differentiation   <= SIZE_J_IN;

            data_in_vector_differentiation <= DATA_IN;

            if (index_vector_loop = ZERO_INDEX) then
              -- Control Internal
              start_vector_differentiation <= '1';
            end if;

            data_in_vector_enable_vector_differentiation <= '1';
            data_in_scalar_enable_vector_differentiation <= '1';

            -- FSM Control
            differentiation_ctrl_fsm_int <= ENDER_STATE;
          else
            -- Control Internal
            data_in_vector_enable_vector_differentiation <= '0';
            data_in_scalar_enable_vector_differentiation <= '0';
          end if;

          -- Control Outputs
          DATA_OUT_VECTOR_ENABLE <= '0';
          DATA_OUT_SCALAR_ENABLE <= '0';

        when INPUT_SCALAR_STATE =>  -- STEP 2

          if (DATA_IN_SCALAR_ENABLE = '1') then
            -- Data Inputs
            modulo_in_vector_differentiation <= MODULO_IN;
            length_in_vector_differentiation <= LENGTH_IN;

            data_in_vector_differentiation <= DATA_IN;

            if (index_scalar_loop = ZERO_INDEX) then
              -- Control Internal
              start_vector_differentiation <= '1';
            end if;

            data_in_scalar_enable_vector_differentiation <= '1';

            -- FSM Control
            differentiation_ctrl_fsm_int <= ENDER_STATE;
          else
            -- Control Internal
            data_in_scalar_enable_vector_differentiation <= '0';
          end if;

          -- Control Outputs
          DATA_OUT_SCALAR_ENABLE <= '0';

        when ENDER_STATE =>  -- STEP 3

          if (ready_vector_differentiation = '1') then
            if (unsigned(index_matrix_loop) = unsigned(SIZE_I_IN)-unsigned(ONE_INDEX) and unsigned(index_vector_loop) = unsigned(SIZE_J_IN)-unsigned(ONE_INDEX) and unsigned(index_scalar_loop) = unsigned(LENGTH_IN)-unsigned(ONE_INDEX)) then
              -- Control Outputs
              READY <= '1';

              DATA_OUT_VECTOR_ENABLE <= '1';

              -- FSM Control
              differentiation_ctrl_fsm_int <= STARTER_STATE;
            elsif (unsigned(index_matrix_loop) < unsigned(SIZE_I_IN)-unsigned(ONE_INDEX) and unsigned(index_vector_loop) = unsigned(SIZE_J_IN)-unsigned(ONE_INDEX) and unsigned(index_scalar_loop) = unsigned(LENGTH_IN)-unsigned(ONE_INDEX)) then
              -- Control Internal
              index_matrix_loop <= std_logic_vector(unsigned(index_matrix_loop) + unsigned(ONE_INDEX));
              index_vector_loop <= ZERO_INDEX;

              -- Control Outputs
              DATA_OUT_MATRIX_ENABLE <= '1';
              DATA_OUT_VECTOR_ENABLE <= '1';
              DATA_OUT_SCALAR_ENABLE <= '1';

              -- FSM Control
              differentiation_ctrl_fsm_int <= INPUT_MATRIX_STATE;
            elsif (unsigned(index_matrix_loop) < unsigned(SIZE_I_IN)-unsigned(ONE_INDEX) and unsigned(index_vector_loop) < unsigned(SIZE_J_IN)-unsigned(ONE_INDEX) and unsigned(index_scalar_loop) = unsigned(LENGTH_IN)-unsigned(ONE_INDEX)) then
              -- Control Internal
              index_vector_loop <= std_logic_vector(unsigned(index_vector_loop) + unsigned(ONE_INDEX));
              index_scalar_loop <= ZERO_INDEX;

              -- Control Outputs
              DATA_OUT_VECTOR_ENABLE <= '1';
              DATA_OUT_SCALAR_ENABLE <= '1';

              -- FSM Control
              differentiation_ctrl_fsm_int <= INPUT_VECTOR_STATE;
            elsif (unsigned(index_matrix_loop) < unsigned(SIZE_I_IN)-unsigned(ONE_INDEX) and unsigned(index_vector_loop) < unsigned(SIZE_J_IN)-unsigned(ONE_INDEX) and unsigned(index_scalar_loop) < unsigned(LENGTH_IN)-unsigned(ONE_INDEX)) then
              -- Control Internal
              index_scalar_loop <= std_logic_vector(unsigned(index_scalar_loop) + unsigned(ONE_INDEX));

              -- Control Outputs
              DATA_OUT_SCALAR_ENABLE <= '1';

              -- FSM Control
              differentiation_ctrl_fsm_int <= INPUT_SCALAR_STATE;
            end if;

            -- Data Outputs
            DATA_OUT <= data_out_vector_differentiation;
          else
            -- Control Internal
            start_vector_differentiation <= '0';

            data_in_vector_enable_vector_differentiation <= '0';
            data_in_scalar_enable_vector_differentiation <= '0';
          end if;

        when others =>
          -- FSM Control
          differentiation_ctrl_fsm_int <= STARTER_STATE;
      end case;
    end if;
  end process;

  -- VECTOR DIFFERENTIATION
  vector_differentiation_function : ntm_vector_differentiation_function
    generic map (
      DATA_SIZE  => DATA_SIZE,
      INDEX_SIZE => INDEX_SIZE
      )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_vector_differentiation,
      READY => ready_vector_differentiation,

      DATA_IN_VECTOR_ENABLE => data_in_vector_enable_vector_differentiation,
      DATA_IN_SCALAR_ENABLE => data_in_scalar_enable_vector_differentiation,

      DATA_OUT_VECTOR_ENABLE => data_out_vector_enable_vector_differentiation,
      DATA_OUT_SCALAR_ENABLE => data_out_scalar_enable_vector_differentiation,

      -- DATA
      MODULO_IN => modulo_in_vector_differentiation,
      SIZE_IN   => size_in_vector_differentiation,
      PERIOD_IN => period_in_vector_differentiation,
      LENGTH_IN => length_in_vector_differentiation,
      DATA_IN   => data_in_vector_differentiation,
      DATA_OUT  => data_out_vector_differentiation
      );

end architecture;
