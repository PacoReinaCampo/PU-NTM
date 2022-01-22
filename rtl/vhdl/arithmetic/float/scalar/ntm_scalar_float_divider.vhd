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

use work.ntm_arithmetic_pkg.all;

entity ntm_scalar_divider is
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

    -- DATA
    DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
    DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

    DATA_OUT : out std_logic_vector(DATA_SIZE-1 downto 0);
    REST_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
    );
end entity;

architecture ntm_scalar_divider_architecture of ntm_scalar_divider is

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  type divider_ctrl_fsm is (
    STARTER_STATE,                      -- STEP 0
    ARITHMETIC_STATE,                   -- STEP 1
    ADAPTATION_STATE,                   -- STEP 2
    NORMALIZATION_STATE,                -- STEP 3
    ENDER_STATE                         -- STEP 4
    );

  -----------------------------------------------------------------------
  -- Constants
  -----------------------------------------------------------------------

  constant EXPONENT_SIZE : integer := 15;
  constant MANTISSA_SIZE : integer := 112;

  constant ZERO_DATA  : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0, DATA_SIZE));
  constant ONE_DATA   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(1, DATA_SIZE));
  constant TWO_DATA   : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2, DATA_SIZE));
  constant THREE_DATA : std_logic_vector(DATA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(3, DATA_SIZE));

  constant ZERO_EXPONENT  : std_logic_vector(EXPONENT_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0, EXPONENT_SIZE));
  constant ONE_EXPONENT   : std_logic_vector(EXPONENT_SIZE-1 downto 0) := std_logic_vector(to_unsigned(1, EXPONENT_SIZE));
  constant TWO_EXPONENT   : std_logic_vector(EXPONENT_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2, EXPONENT_SIZE));
  constant THREE_EXPONENT : std_logic_vector(EXPONENT_SIZE-1 downto 0) := std_logic_vector(to_unsigned(3, EXPONENT_SIZE));

  constant ZERO_MANTISSA  : std_logic_vector(MANTISSA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0, MANTISSA_SIZE));
  constant ONE_MANTISSA   : std_logic_vector(MANTISSA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(1, MANTISSA_SIZE));
  constant TWO_MANTISSA   : std_logic_vector(MANTISSA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2, MANTISSA_SIZE));
  constant THREE_MANTISSA : std_logic_vector(MANTISSA_SIZE-1 downto 0) := std_logic_vector(to_unsigned(3, MANTISSA_SIZE));

  constant ZERO_EXPONENT_OUTPUT  : std_logic_vector(EXPONENT_SIZE downto 0) := std_logic_vector(to_unsigned(0, EXPONENT_SIZE+1));
  constant ONE_EXPONENT_OUTPUT   : std_logic_vector(EXPONENT_SIZE downto 0) := std_logic_vector(to_unsigned(1, EXPONENT_SIZE+1));
  constant TWO_EXPONENT_OUTPUT   : std_logic_vector(EXPONENT_SIZE downto 0) := std_logic_vector(to_unsigned(2, EXPONENT_SIZE+1));
  constant THREE_EXPONENT_OUTPUT : std_logic_vector(EXPONENT_SIZE downto 0) := std_logic_vector(to_unsigned(3, EXPONENT_SIZE+1));

  constant FULL  : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '1');
  constant EMPTY : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '0');

  constant FULL_EXPONENT  : std_logic_vector(EXPONENT_SIZE-1 downto 0) := (others => '1');
  constant EMPTY_EXPONENT : std_logic_vector(EXPONENT_SIZE-1 downto 0) := (others => '0');

  constant FULL_MANTISSA  : std_logic_vector(MANTISSA_SIZE-1 downto 0) := (others => '1');
  constant EMPTY_MANTISSA : std_logic_vector(MANTISSA_SIZE-1 downto 0) := (others => '0');

  constant EULER : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '0');

  constant BIAS : std_logic_vector(EXPONENT_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2**(EXPONENT_SIZE-1)-1, EXPONENT_SIZE));

  -----------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------

  -- Finite State Machine
  signal divider_ctrl_fsm_int : divider_ctrl_fsm;

  -- Control Internal
  signal data_out_ready_adder_int   : std_logic;
  signal data_out_ready_divider_int : std_logic;

  -- SCALAR ADDER
  -- CONTROL
  signal start_scalar_integer_adder : std_logic;
  signal ready_scalar_integer_adder : std_logic;

  signal operation_scalar_integer_adder : std_logic;

  -- DATA
  signal data_a_in_scalar_integer_adder : std_logic_vector(EXPONENT_SIZE-1 downto 0);
  signal data_b_in_scalar_integer_adder : std_logic_vector(EXPONENT_SIZE-1 downto 0);

  signal data_out_scalar_integer_adder     : std_logic_vector(EXPONENT_SIZE-1 downto 0);
  signal overflow_out_scalar_integer_adder : std_logic;

  -- SCALAR DIVIDER
  -- CONTROL
  signal start_scalar_integer_divider : std_logic;
  signal ready_scalar_integer_divider : std_logic;

  -- DATA
  signal data_a_in_scalar_integer_divider : std_logic_vector(MANTISSA_SIZE-1 downto 0);
  signal data_b_in_scalar_integer_divider : std_logic_vector(MANTISSA_SIZE-1 downto 0);

  signal data_out_scalar_integer_divider : std_logic_vector(MANTISSA_SIZE-1 downto 0);
  signal rest_out_scalar_integer_divider : std_logic_vector(MANTISSA_SIZE-1 downto 0);

  -- OUTPUT
  signal sign_int_scalar_divider : std_logic;

  signal exponent_int_scalar_divider : std_logic_vector(EXPONENT_SIZE downto 0);

  signal data_mantissa_int_scalar_divider : std_logic_vector(MANTISSA_SIZE-1 downto 0);
  signal rest_mantissa_int_scalar_divider : std_logic_vector(MANTISSA_SIZE-1 downto 0);

begin

  -----------------------------------------------------------------------
  -- Body
  -----------------------------------------------------------------------

  -- DATA_OUT = DATA_A_IN / DATA_B_IN = M_A_IN / M_B_IN · 2^(E_A_IN - E_B_IN)

  -- CONTROL
  ctrl_fsm : process(CLK, RST)
  begin
    if (RST = '0') then
      -- Data Outputs
      DATA_OUT <= ZERO_DATA;
      REST_OUT <= ZERO_DATA;

      -- Control Outputs
      READY <= '0';

      -- Control Internal
      start_scalar_integer_adder   <= '0';
      start_scalar_integer_divider <= '0';

      operation_scalar_integer_adder <= '0';

      data_out_ready_adder_int   <= '0';
      data_out_ready_divider_int <= '0';

      -- Data Internal
      data_a_in_scalar_integer_adder <= ZERO_EXPONENT;
      data_b_in_scalar_integer_adder <= ZERO_EXPONENT;

      data_a_in_scalar_integer_divider <= ZERO_MANTISSA;
      data_b_in_scalar_integer_divider <= ZERO_MANTISSA;

      sign_int_scalar_divider <= '0';

      exponent_int_scalar_divider <= ZERO_EXPONENT_OUTPUT;

      data_mantissa_int_scalar_divider <= ZERO_MANTISSA;
      rest_mantissa_int_scalar_divider <= ZERO_MANTISSA;

    elsif (rising_edge(CLK)) then

      case divider_ctrl_fsm_int is
        when STARTER_STATE =>  -- STEP 0
          -- Control Outputs
          READY <= '0';

          if (START = '1') then
            -- Control Internal
            start_scalar_integer_adder   <= '1';
            start_scalar_integer_divider <= '1';

            operation_scalar_integer_adder <= '1';

            data_out_ready_adder_int   <= '0';
            data_out_ready_divider_int <= '0';

            -- Data Internal
            sign_int_scalar_divider <= DATA_A_IN(DATA_SIZE-1) xor DATA_B_IN(DATA_SIZE-1);

            data_a_in_scalar_integer_adder <= DATA_A_IN(DATA_SIZE-2 downto MANTISSA_SIZE);
            data_b_in_scalar_integer_adder <= DATA_B_IN(DATA_SIZE-2 downto MANTISSA_SIZE);

            data_a_in_scalar_integer_divider <= DATA_A_IN(MANTISSA_SIZE-1 downto 0);
            data_b_in_scalar_integer_divider <= DATA_B_IN(MANTISSA_SIZE-1 downto 0);

            -- FSM Control
            divider_ctrl_fsm_int <= ARITHMETIC_STATE;
          end if;

        when ARITHMETIC_STATE =>  -- STEP 1

          if (ready_scalar_integer_adder = '1') then
            -- Data Outputs
            exponent_int_scalar_divider <= overflow_out_scalar_integer_adder & data_out_scalar_integer_adder;

            -- Control Internal
            data_out_ready_adder_int <= '1';
          else
            -- Control Internal
            start_scalar_integer_adder <= '0';
          end if;

          if (ready_scalar_integer_divider = '1') then
            -- Data Outputs
            data_mantissa_int_scalar_divider <= data_out_scalar_integer_divider;
            rest_mantissa_int_scalar_divider <= rest_out_scalar_integer_divider;

            -- Control Internal
            data_out_ready_divider_int <= '1';
          else
            -- Control Internal
            start_scalar_integer_divider <= '0';
          end if;

          if (data_out_ready_adder_int = '1' and data_out_ready_divider_int = '1') then
            -- Control Internal
            data_out_ready_adder_int   <= '0';
            data_out_ready_divider_int <= '0';

            -- FSM Control
            divider_ctrl_fsm_int <= ADAPTATION_STATE;
          end if;

        when ADAPTATION_STATE =>  -- STEP 2

          if (unsigned(rest_mantissa_int_scalar_divider) = unsigned(ZERO_MANTISSA)) then
            -- FSM Control
            divider_ctrl_fsm_int <= NORMALIZATION_STATE;
          else
            -- Data Outputs
            exponent_int_scalar_divider <= std_logic_vector(unsigned(exponent_int_scalar_divider) + unsigned(ONE_EXPONENT));

            data_mantissa_int_scalar_divider <= std_logic_vector(unsigned(data_mantissa_int_scalar_divider) srl 1);
            rest_mantissa_int_scalar_divider <= std_logic_vector(unsigned(rest_mantissa_int_scalar_divider) srl 1);
          end if;

        when NORMALIZATION_STATE =>  -- STEP 3

          if (rest_mantissa_int_scalar_divider(0) = '1') then
            -- FSM Control
            divider_ctrl_fsm_int <= ENDER_STATE;
          else
            -- Data Outputs
            exponent_int_scalar_divider <= std_logic_vector(unsigned(exponent_int_scalar_divider) - unsigned(ONE_EXPONENT));

            data_mantissa_int_scalar_divider <= std_logic_vector(unsigned(data_mantissa_int_scalar_divider) sll 1);
            rest_mantissa_int_scalar_divider <= std_logic_vector(unsigned(rest_mantissa_int_scalar_divider) sll 1);
          end if;

        when ENDER_STATE =>  -- STEP 4

          if (overflow_out_scalar_integer_adder = '0') then
            -- Data Outputs
            DATA_OUT <= sign_int_scalar_divider & exponent_int_scalar_divider(EXPONENT_SIZE-1 downto 0) & data_mantissa_int_scalar_divider;

            -- Control Outputs
            READY <= '1';

            -- FSM Control
            divider_ctrl_fsm_int <= STARTER_STATE;
          else
            -- Data Outputs
            exponent_int_scalar_divider <= std_logic_vector(unsigned(exponent_int_scalar_divider) - unsigned(ONE_EXPONENT));

            data_mantissa_int_scalar_divider <= std_logic_vector(unsigned(data_mantissa_int_scalar_divider) sll 1);
            rest_mantissa_int_scalar_divider <= std_logic_vector(unsigned(rest_mantissa_int_scalar_divider) sll 1);
          end if;

        when others =>
          -- FSM Control
          divider_ctrl_fsm_int <= STARTER_STATE;
      end case;
    end if;
  end process;

  -- SCALAR ADDER
  scalar_integer_adder : ntm_scalar_integer_adder
    generic map (
      DATA_SIZE    => EXPONENT_SIZE,
      CONTROL_SIZE => CONTROL_SIZE
      )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_integer_adder,
      READY => ready_scalar_integer_adder,

      OPERATION => operation_scalar_integer_adder,

      -- DATA
      DATA_A_IN => data_a_in_scalar_integer_adder,
      DATA_B_IN => data_b_in_scalar_integer_adder,

      DATA_OUT     => data_out_scalar_integer_adder,
      OVERFLOW_OUT => overflow_out_scalar_integer_adder
      );

  -- SCALAR DIVIDER
  scalar_integer_divider : ntm_scalar_integer_divider
    generic map (
      DATA_SIZE    => MANTISSA_SIZE,
      CONTROL_SIZE => CONTROL_SIZE
      )
    port map (
      -- GLOBAL
      CLK => CLK,
      RST => RST,

      -- CONTROL
      START => start_scalar_integer_divider,
      READY => ready_scalar_integer_divider,

      -- DATA
      DATA_A_IN => data_a_in_scalar_integer_divider,
      DATA_B_IN => data_b_in_scalar_integer_divider,

      DATA_OUT => data_out_scalar_integer_divider,
      REST_OUT => rest_out_scalar_integer_divider
      );

end architecture;