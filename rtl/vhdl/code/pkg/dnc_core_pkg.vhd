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

use work.ntm_arithmetic_pkg.all;
use work.ntm_math_pkg.all;

package dnc_core_pkg is

  ------------------------------------------------------------------------------
  -- Components
  ------------------------------------------------------------------------------

  ------------------------------------------------------------------------------
  -- MEMORY
  ------------------------------------------------------------------------------

  component dnc_content_based_addressing is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      K_IN_ENABLE : in std_logic;       -- for j in 0 to J-1

      K_OUT_ENABLE : out std_logic;     -- for j in 0 to J-1

      M_IN_I_ENABLE : in std_logic;     -- for i in 0 to I-1
      M_IN_J_ENABLE : in std_logic;     -- for j in 0 to J-1

      M_OUT_I_ENABLE : out std_logic;   -- for i in 0 to I-1
      M_OUT_J_ENABLE : out std_logic;   -- for j in 0 to J-1

      C_OUT_ENABLE : out std_logic;     -- for i in 0 to I-1

      -- DATA
      SIZE_I_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      SIZE_J_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      K_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      M_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      C_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_allocation_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      U_IN_ENABLE : in std_logic;       -- for j in 0 to N-1

      U_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      A_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      U_IN      : in std_logic_vector(DATA_SIZE-1 downto 0);

      A_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_backward_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      L_IN_G_ENABLE : in std_logic;     -- for g in 0 to N-1 (square matrix)
      L_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1 (square matrix)

      L_OUT_G_ENABLE : out std_logic;   -- for g in 0 to N-1 (square matrix)
      L_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1 (square matrix)

      W_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1 (read heads flow)
      W_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1

      W_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      W_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      B_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      B_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      -- DATA
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      L_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      B_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_forward_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      L_IN_G_ENABLE : in std_logic;     -- for g in 0 to N-1 (square matrix)
      L_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1 (square matrix)

      L_OUT_G_ENABLE : out std_logic;   -- for g in 0 to N-1 (square tensor)
      L_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1 (square tensor)

      W_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1 (read heads flow)
      W_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1

      W_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      W_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      F_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      F_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      -- DATA
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      L_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      F_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_memory_matrix is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      M_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1
      M_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      W_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1
      V_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1
      E_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      W_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1
      V_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1
      E_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      M_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1
      M_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      M_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      V_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      E_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      M_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_memory_retention_vector is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      F_IN_ENABLE : in std_logic;       -- for i in 0 to R-1

      F_OUT_ENABLE : out std_logic;     -- for i in 0 to R-1

      W_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      W_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1

      W_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      W_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      PSI_OUT_ENABLE : out std_logic;   -- for j in 0 to N-1

      -- DATA
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      F_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      PSI_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_precedence_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      W_IN_ENABLE : in std_logic;       -- for j in 0 to N-1
      P_IN_ENABLE : in std_logic;       -- for j in 0 to N-1

      W_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1
      P_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      P_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      P_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_read_content_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      K_IN_ENABLE : in std_logic;       -- for k in 0 to W-1

      K_OUT_ENABLE : out std_logic;     -- for k in 0 to W-1

      M_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1
      M_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      M_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1
      M_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      C_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      K_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      M_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      C_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_read_vectors is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      M_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1
      M_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      M_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1
      M_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      W_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1 (read heads flow)
      W_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1

      W_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      W_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      R_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      R_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      -- DATA
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      M_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      R_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_read_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      PI_IN_I_ENABLE : in std_logic;    -- for i in 0 to R-1
      PI_IN_P_ENABLE : in std_logic;    -- for p in 0 to 2

      PI_OUT_I_ENABLE : out std_logic;  -- for i in 0 to R-1
      PI_OUT_P_ENABLE : out std_logic;  -- for p in 0 to 2

      B_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      B_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1

      B_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      B_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      C_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      C_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1

      C_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      C_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      F_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      F_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1

      F_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      F_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      W_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      W_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1

      -- DATA
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      PI_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      C_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      F_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      W_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_sort_vector is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      U_IN_ENABLE : in std_logic;       -- for j in 0 to N-1

      U_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      PHI_OUT_ENABLE : out std_logic;   -- for j in 0 to N-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      U_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      PHI_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_temporal_link_matrix is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      L_IN_G_ENABLE : in std_logic;     -- for g in 0 to N-1 (square matrix)
      L_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1 (square matrix)

      W_IN_ENABLE : in std_logic;       -- for j in 0 to N-1
      P_IN_ENABLE : in std_logic;       -- for j in 0 to N-1

      W_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1
      P_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      L_OUT_G_ENABLE : out std_logic;   -- for g in 0 to N-1 (square matrix)
      L_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1 (square matrix)

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      L_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      W_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      P_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      L_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_usage_vector is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      U_IN_ENABLE   : in std_logic;     -- for j in 0 to N-1
      W_IN_ENABLE   : in std_logic;     -- for j in 0 to N-1
      PSI_IN_ENABLE : in std_logic;     -- for j in 0 to N-1

      U_OUT_ENABLE   : out std_logic;   -- for j in 0 to N-1
      W_OUT_ENABLE   : out std_logic;   -- for j in 0 to N-1
      PSI_OUT_ENABLE : out std_logic;   -- for j in 0 to N-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      U_IN   : in std_logic_vector(DATA_SIZE-1 downto 0);
      W_IN   : in std_logic_vector(DATA_SIZE-1 downto 0);
      PSI_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      U_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_write_content_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      K_IN_ENABLE : in std_logic;       -- for k in 0 to W-1

      K_OUT_ENABLE : out std_logic;     -- for k in 0 to W-1

      M_IN_J_ENABLE : in std_logic;     -- for j in 0 to N-1
      M_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      M_OUT_J_ENABLE : out std_logic;   -- for j in 0 to N-1
      M_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      C_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      K_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      M_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      C_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_write_weighting is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      A_IN_ENABLE : in std_logic;       -- for j in 0 to N-1
      C_IN_ENABLE : in std_logic;       -- for j in 0 to N-1

      A_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1
      C_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      W_OUT_ENABLE : out std_logic;     -- for j in 0 to N-1

      -- DATA
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      A_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      C_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      GA_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      GW_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      W_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_addressing is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      K_READ_IN_I_ENABLE : in std_logic;  -- for i in 0 to R-1 (read heads flow)
      K_READ_IN_K_ENABLE : in std_logic;  -- for k in 0 to W-1

      K_READ_OUT_I_ENABLE : out std_logic;  -- for i in 0 to R-1 (read heads flow)
      K_READ_OUT_K_ENABLE : out std_logic;  -- for k in 0 to W-1

      BETA_READ_IN_ENABLE : in std_logic;  -- for i in 0 to R-1 (read heads flow)

      BETA_READ_OUT_ENABLE : out std_logic;  -- for i in 0 to R-1 (read heads flow)

      F_READ_IN_ENABLE : in std_logic;  -- for i in 0 to R-1 (read heads flow)

      F_READ_OUT_ENABLE : out std_logic;  -- for i in 0 to R-1 (read heads flow)

      PI_READ_IN_I_ENABLE : in std_logic;  -- for i in 0 to R-1 (read heads flow)
      PI_READ_IN_P_ENABLE : in std_logic;  -- for p in 0 to 2

      PI_READ_OUT_I_ENABLE : out std_logic;  -- for i in 0 to R-1 (read heads flow)
      PI_READ_OUT_P_ENABLE : out std_logic;  -- for p in 0 to 2

      K_WRITE_IN_K_ENABLE : in std_logic;  -- for k in 0 to W-1
      E_WRITE_IN_K_ENABLE : in std_logic;  -- for k in 0 to W-1
      V_WRITE_IN_K_ENABLE : in std_logic;  -- for k in 0 to W-1

      K_WRITE_OUT_K_ENABLE : out std_logic;  -- for k in 0 to W-1
      E_WRITE_OUT_K_ENABLE : out std_logic;  -- for k in 0 to W-1
      V_WRITE_OUT_K_ENABLE : out std_logic;  -- for k in 0 to W-1

      R_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      R_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      -- DATA
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_N_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      K_READ_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_READ_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      F_READ_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      PI_READ_IN   : in std_logic_vector(DATA_SIZE-1 downto 0);

      K_WRITE_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_WRITE_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      E_WRITE_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      V_WRITE_IN    : in std_logic_vector(DATA_SIZE-1 downto 0);
      GA_WRITE_IN   : in std_logic_vector(DATA_SIZE-1 downto 0);
      GW_WRITE_IN   : in std_logic_vector(DATA_SIZE-1 downto 0);

      R_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component dnc_addressing;

  ------------------------------------------------------------------------------
  -- READ HEADS
  ------------------------------------------------------------------------------

  component dnc_read_heads is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      RHO_IN_I_ENABLE : in std_logic;   -- for i in 0 to R-1
      RHO_IN_M_ENABLE : in std_logic;   -- for m in 0 to M-1

      RHO_OUT_I_ENABLE : out std_logic;  -- for i in 0 to R-1
      RHO_OUT_M_ENABLE : out std_logic;  -- for m in 0 to M-1

      K_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      K_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      BETA_OUT_ENABLE : out std_logic;  -- for i in 0 to R-1

      F_OUT_ENABLE : out std_logic;     -- for i in 0 to R-1

      PI_OUT_I_ENABLE : out std_logic;  -- for i in 0 to R-1
      PI_OUT_P_ENABLE : out std_logic;  -- for p in 0 to 2

      -- DATA
      SIZE_M_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      RHO_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      K_OUT    : out std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_OUT : out std_logic_vector(DATA_SIZE-1 downto 0);
      F_OUT    : out std_logic_vector(DATA_SIZE-1 downto 0);
      PI_OUT   : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  ------------------------------------------------------------------------------
  -- WRITE HEADS
  ------------------------------------------------------------------------------

  component dnc_write_heads is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      XI_IN_ENABLE : in std_logic;      -- for s in 0 to S-1

      XI_OUT_ENABLE : out std_logic;    -- for s in 0 to S-1

      K_OUT_ENABLE : out std_logic;     -- for i in 0 to W-1
      E_OUT_ENABLE : out std_logic;     -- for i in 0 to W-1
      V_OUT_ENABLE : out std_logic;     -- for i in 0 to W-1

      -- DATA
      SIZE_S_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      XI_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      K_OUT    : out std_logic_vector(DATA_SIZE-1 downto 0);
      BETA_OUT : out std_logic_vector(DATA_SIZE-1 downto 0);
      E_OUT    : out std_logic_vector(DATA_SIZE-1 downto 0);
      V_OUT    : out std_logic_vector(DATA_SIZE-1 downto 0);
      GA_OUT   : out std_logic_vector(DATA_SIZE-1 downto 0);
      GW_OUT   : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  ------------------------------------------------------------------------------
  -- TOP
  ------------------------------------------------------------------------------

  component dnc_top is
    generic (
      DATA_SIZE    : integer := 64;
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

      V_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1
      V_IN_S_ENABLE : in std_logic;     -- for s in 0 to S-1

      V_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1
      V_OUT_S_ENABLE : out std_logic;   -- for s in 0 to S-1

      D_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1 (read heads flow)
      D_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1
      D_IN_M_ENABLE : in std_logic;     -- for m in 0 to M-1

      D_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1 (read heads flow)
      D_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1
      D_OUT_M_ENABLE : out std_logic;   -- for m in 0 to M-1

      B_IN_ENABLE : in std_logic;       -- for l in 0 to L-1

      B_OUT_ENABLE : out std_logic;     -- for l in 0 to L-1

      X_IN_ENABLE : in std_logic;       -- for x in 0 to X-1

      X_OUT_ENABLE : out std_logic;     -- for x in 0 to X-1

      P_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      P_IN_Y_ENABLE : in std_logic;     -- for y in 0 to Y-1
      P_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      P_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      P_OUT_Y_ENABLE : out std_logic;   -- for y in 0 to Y-1
      P_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      Q_IN_Y_ENABLE : in std_logic;     -- for y in 0 to Y-1
      Q_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1

      Q_OUT_Y_ENABLE : out std_logic;   -- for y in 0 to Y-1
      Q_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1

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
      V_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      D_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      B_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      X_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      P_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      Q_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      Y_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_output_vector is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      P_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      P_IN_Y_ENABLE : in std_logic;     -- for y in 0 to Y-1
      P_IN_K_ENABLE : in std_logic;     -- for k in 0 to W-1

      P_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      P_OUT_Y_ENABLE : out std_logic;   -- for y in 0 to Y-1
      P_OUT_K_ENABLE : out std_logic;   -- for k in 0 to W-1

      R_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      R_IN_K_ENABLE : in std_logic;     -- for j in 0 to W-1

      R_OUT_I_ENABLE : out std_logic;   -- for i in 0 to R-1
      R_OUT_K_ENABLE : out std_logic;   -- for j in 0 to W-1

      Q_IN_Y_ENABLE : in std_logic;     -- for y in 0 to Y-1
      Q_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1

      Q_OUT_Y_ENABLE : out std_logic;   -- for y in 0 to Y-1
      Q_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1

      H_IN_ENABLE : in std_logic;       -- for l in 0 to L-1

      H_OUT_ENABLE : out std_logic;     -- for l in 0 to L-1

      Y_OUT_ENABLE : out std_logic;     -- for y in 0 to Y-1

      -- DATA
      SIZE_Y_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_L_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_W_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      P_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      R_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      Q_IN : in std_logic_vector(DATA_SIZE-1 downto 0);
      H_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      Y_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_interface_vector is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      -- Weight
      U_IN_S_ENABLE : in std_logic;     -- for s in 0 to S-1
      U_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1

      U_OUT_S_ENABLE : out std_logic;   -- for s in 0 to S-1
      U_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1

      -- Hidden State
      H_IN_ENABLE : in std_logic;       -- for l in 0 to L-1

      H_OUT_ENABLE : out std_logic;     -- for l in 0 to L-1

      -- Interface
      XI_OUT_ENABLE : in std_logic;     -- for s in 0 to S-1

      -- DATA
      SIZE_S_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_L_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      U_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      H_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      XI_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

  component dnc_interface_matrix is
    generic (
      DATA_SIZE    : integer := 64;
      CONTROL_SIZE : integer := 64
      );
    port (
      -- GLOBAL
      CLK : in std_logic;
      RST : in std_logic;

      -- CONTROL
      START : in  std_logic;
      READY : out std_logic;

      -- Weight
      U_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      U_IN_M_ENABLE : in std_logic;     -- for m in 0 to M-1
      U_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1

      U_OUT_I_ENABLE : in  std_logic;   -- for i in 0 to R-1
      U_OUT_M_ENABLE : out std_logic;   -- for m in 0 to M-1
      U_OUT_L_ENABLE : out std_logic;   -- for l in 0 to L-1

      -- Hidden State
      H_IN_I_ENABLE : in std_logic;     -- for i in 0 to R-1
      H_IN_L_ENABLE : in std_logic;     -- for l in 0 to L-1

      H_OUT_I_ENABLE : in std_logic;    -- for i in 0 to R-1
      H_OUT_L_ENABLE : in std_logic;    -- for l in 0 to L-1

      -- Interface
      RHO_OUT_I_ENABLE : out std_logic;  -- for i in 0 to R-1
      RHO_OUT_M_ENABLE : out std_logic;  -- for m in 0 to M-1

      -- DATA
      SIZE_M_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_R_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);
      SIZE_L_IN : in std_logic_vector(CONTROL_SIZE-1 downto 0);

      U_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      H_IN : in std_logic_vector(DATA_SIZE-1 downto 0);

      RHO_OUT : out std_logic_vector(DATA_SIZE-1 downto 0)
      );
  end component;

end dnc_core_pkg;