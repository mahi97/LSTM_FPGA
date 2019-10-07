library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity sop is
    Port (
          clk : in std_logic;
          rst : in std_logic;
          X : in  matrix_1_4;
          W : in  matrix_4_8;
          H : in  matrix_1_8;
          U : in  matrix_8_8;
          B : in  matrix_1_8;
          O : out matrix_1_8
         );
end sop;

architecture Behavior of sop is

  component mat_mul_148 is
      Port (
             clk : in std_logic;
             rst : in std_logic;
             o_ready : out std_logic;
             input_mat_A : in matrix_1_4;
             input_mat_B : in matrix_4_8;
             output_mat  : out matrix_1_8
           );
  end component;

  component mat_mul_188 is
      Port (
             clk : in std_logic;
             rst : in std_logic;
             o_ready : out std_logic;
             input_mat_A : in matrix_1_8;
             input_mat_B : in matrix_8_8;
             output_mat  : out matrix_1_8
           );
  end component;

  component add_mat_1_8 is
      Port (
             inputx : in matrix_1_8;
             inputy : in matrix_1_8;
             output : out matrix_1_8
           );
  end component;

signal ready_1 : std_logic;
signal ready_2 : std_logic;
signal out_1 : matrix_1_8;
signal out_2 : matrix_1_8;
signal in_1 : matrix_1_8;
signal in_2 : matrix_1_8;
signal in_3 : matrix_1_8;
signal out_3 : matrix_1_8;
begin

mul_first: mat_mul_148 port map (clk, rst, ready_1, X, W, out_1);
mul_second: mat_mul_188 port map (clk, rst, ready_2, H, U, out_2);

add_first  : add_mat_1_8 port map (in_1, in_2, in_3);
add_second : add_mat_1_8 port map (in_3, B, out_3);

SOP_PROC : process( clk )
begin
  if clk'event and clk = '1' then
    if ready_1 = '1' and ready_2 = '1' then
      in_1 <= out_1;
      in_2 <= out_2;
      O <= out_3;
    end if;
  end if;
end process ; -- SOP_PROC

end architecture ; -- Behavior