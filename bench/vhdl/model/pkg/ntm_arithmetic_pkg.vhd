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

package ntm_arithmetic_pkg is

  -----------------------------------------------------------------------
  -- Types
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- Constants
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- Components
  -----------------------------------------------------------------------

  -----------------------------------------------------------------------
  -- ARITHMETIC - MODULAR
  -----------------------------------------------------------------------

  -- SCALAR
  component ntm_scalar_modular_mod is
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
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_scalar_modular_adder is
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

      OPERATION : in std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_scalar_modular_multiplier is
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
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_scalar_modular_inverter is
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
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -- VECTOR
  component ntm_vector_modular_mod is
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

      DATA_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_IN   : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_vector_modular_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_IN   : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_vector_modular_multiplier is
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

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_IN   : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_vector_modular_inverter is
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

      DATA_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_IN   : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -- MATRIX
  component ntm_matrix_modular_mod is
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

      DATA_IN_I_ENABLE : in std_logic;
      DATA_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_matrix_modular_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_matrix_modular_multiplier is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_matrix_modular_inverter is
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

      DATA_IN_I_ENABLE : in std_logic;
      DATA_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -- TENSOR
  component ntm_tensor_modular_mod is
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

      DATA_IN_I_ENABLE : in std_logic;
      DATA_IN_J_ENABLE : in std_logic;
      DATA_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_tensor_modular_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_tensor_modular_multiplier is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_tensor_modular_inverter is
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

      DATA_IN_I_ENABLE : in std_logic;
      DATA_IN_J_ENABLE : in std_logic;
      DATA_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      MODULO_IN : in  std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_I_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in  std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_IN   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_OUT  : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- ARITHMETIC - INTEGER
  -----------------------------------------------------------------------

  -- SCALAR
  component ntm_scalar_integer_adder is
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

      OPERATION : in std_logic;

      -- DATA
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_scalar_integer_multiplier is
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

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_scalar_integer_divider is
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

      DATA_OUT      : out std_logic_vector(DATA_SIZE-1 downto 0);
      REMAINDER_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -- VECTOR
  component ntm_vector_integer_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_IN   : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_vector_integer_multiplier is
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

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_IN   : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_vector_integer_divider is
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

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_IN   : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT      : out std_logic_vector(DATA_SIZE-1 downto 0);
      REMAINDER_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -- MATRIX
  component ntm_matrix_integer_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_matrix_integer_multiplier is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_matrix_integer_divider is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT      : out std_logic_vector(DATA_SIZE-1 downto 0);
      REMAINDER_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -- TENSOR
  component ntm_tensor_integer_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_tensor_integer_multiplier is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component ntm_tensor_integer_divider is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT      : out std_logic_vector(DATA_SIZE-1 downto 0);
      REMAINDER_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  -----------------------------------------------------------------------
  -- ARITHMETIC - FLOAT
  -----------------------------------------------------------------------

  -- SCALAR
  component ntm_scalar_float_adder is
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

      OPERATION : in std_logic;

      -- DATA
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_scalar_float_multiplier is
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

      -- DATA
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_scalar_float_divider is
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

      -- DATA
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  -- VECTOR
  component ntm_vector_float_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_IN   : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_vector_float_multiplier is
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

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_IN   : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_vector_float_divider is
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

      DATA_A_IN_ENABLE : in std_logic;
      DATA_B_IN_ENABLE : in std_logic;

      DATA_OUT_ENABLE : out std_logic;

      -- DATA
      SIZE_IN   : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  -- MATRIX
  component ntm_matrix_float_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_matrix_float_multiplier is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_matrix_float_divider is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  -- TENSOR
  component ntm_tensor_float_adder is
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

      OPERATION : in std_logic;

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_tensor_float_multiplier is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  component ntm_tensor_float_divider is
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

      DATA_A_IN_I_ENABLE : in std_logic;
      DATA_A_IN_J_ENABLE : in std_logic;
      DATA_A_IN_K_ENABLE : in std_logic;
      DATA_B_IN_I_ENABLE : in std_logic;
      DATA_B_IN_J_ENABLE : in std_logic;
      DATA_B_IN_K_ENABLE : in std_logic;

      DATA_OUT_I_ENABLE : out std_logic;
      DATA_OUT_J_ENABLE : out std_logic;
      DATA_OUT_K_ENABLE : out std_logic;

      -- DATA
      SIZE_I_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_K_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      DATA_A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      DATA_B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      DATA_OUT     : out std_logic_vector(DATA_SIZE-1 downto 0);
      OVERFLOW_OUT : out std_logic
      );
  end component;

  -----------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------

  function to_stdlogic (input : boolean) return std_logic;

end ntm_arithmetic_pkg;

package body ntm_arithmetic_pkg is

  -----------------------------------------------------------------------
  -- Functions
  -----------------------------------------------------------------------

  function to_stdlogic (
    input : boolean
    ) return std_logic is
  begin
    if input then
      return('1');
    else
      return('0');
    end if;
  end function to_stdlogic;

end ntm_arithmetic_pkg;
