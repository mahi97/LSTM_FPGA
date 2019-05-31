library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity mat_mul_148 is
    Port (
           clk : in std_logic;
           rst : in std_logic;
           o_ready : out std_logic;
           input_mat_A : in matrix_1_4;
           input_mat_B : in matrix_4_8;
           output_mat  : out matrix_1_8
         );
end mat_mul_148;

architecture Behavior of mat_mul_148 is

component matrix_multipler is
    Generic (
      input_a_rows : integer := 3;
      input_a_cols : integer := 3;
      input_b_rows : integer := 3;
      input_b_cols : integer := 3
    );
    Port (
           clk : in std_logic;
           rst : in std_logic;
           enable_a : in std_logic;
           enable_b : in std_logic;
           enable_r : in std_logic;
           input_a  : in std_logic_vector(31 downto 0);
           input_b  : in std_logic_vector(31 downto 0);
           ready    : out std_logic;
           output   : out std_logic_vector(31 downto 0)
         );
  end component;

signal enable_a : std_logic;
signal enable_b : std_logic;
signal enable_r : std_logic;
signal input_a  : std_logic_vector(31 downto 0);
signal input_b  : std_logic_vector(31 downto 0);
signal ready    : std_logic;
signal output   : std_logic_vector(31 downto 0);

type state is (S0, S1, S2, S3, S35, S4, SW, S5, SH);
signal current_state : state;
signal next_state : state;

begin

matmul_m: matrix_multipler 
            generic map (1,4,4,8) 
            port map (clk, rst, enable_a, enable_b, enable_r, input_a, input_b, ready, output);

  MATMUL_PRC : process( clk )
  variable a_i : integer := 0;
  variable a_j : integer := 0;
  variable b_i : integer := 0;
  variable b_j : integer := 0;
  begin
    if clk'event and clk = '1' then 

    end if;
  end process ; -- MATMUL_PRC

  -- next to current
  SM_PRC: process (clk, rst)
  begin
    if rst = '1' then
      current_state <= S0;
    elsif clk'event and clk = '1' then
      current_state <= next_state;
    end if;
  end process;

  -- next based on state
  process (current_state)
  variable a_i : integer := 0;
  variable a_j : integer := 0;
  variable b_i : integer := 0;
  variable b_j : integer := 0;
  variable r_i : integer := 0;
  variable r_j : integer := 0;
  begin
    case current_state is
      when S0 =>
        enable_a <= '0';
        enable_b <= '0';
        enable_r <= '0';
        o_ready <= '0';
        a_i = -1; a_j = 0;
        b_i = -1; b_j = 0;
        r_i = -1; r_j = 0;
        next_state <= S1;
      when S1 => 
        enable_a <= '1';
        enable_b <= '1';
        a_i += 1;
        b_i += 1;
        if a_i = 4 then a_i = 0; a_j += 1; end if;
        if a_j < 1 then
          input_a <= input_mat_A(a_i);
        end if;
        if b_i = 4 then a_i = 0; a_j += 1; end if;
        if b_j < 8 then
          input_b <= input_mat_B(b_i, b_j);
        end if;
        if b_j >= 8 and a_j >= 1 then 
          next_state <= S2;
        end if;
      when S2 =>
        if ready = '1' then
          enable_r <= '1';
          r_i += 1;
          if r_i = 4 then r_i = 0; r_j += 1; end if;
          if r_j < 1 then
            output_mat(r_i) <= output;
          end if;
        end if;
        if r_j >= 1 then
          next_state <= S3;
        end if;
      when S3 =>
        o_ready <= '1';
        if rst <= '1' then
          next_state <= S0;
        end if;
    end case;
  end process;

end architecture ; -- Behavior