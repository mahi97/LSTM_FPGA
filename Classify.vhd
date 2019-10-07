library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;


entity Classify is
  port (
	  clk   : in  std_logic;
    rst   : in  std_logic;
	  X     : in  matrix_1_8;
    O     : out matrix_1_2;
    ready : out std_logic
  ) ;
end entity ; -- Classify

architecture arch of Classify is

	component sigmoid_matrix_1_2 is
    	Port (
           clk : in std_logic;
           enable : in std_logic;
           input : in matrix_1_2;
           output : out matrix_1_2
        );
	end component;

	component mat_mul_182 is
    Port (
           clk : in std_logic;
           rst : in std_logic;
           o_ready : out std_logic;
           input_mat_A : in matrix_1_8;
           input_mat_B : in matrix_2_8;
           output_mat  : out matrix_1_2
         );
  end component;

	component add_mat_1_2 is
    Port (
           inputx : in matrix_1_2;
           inputy : in matrix_1_2;
           output : out matrix_1_2
    );
	end component;

signal mul_ready : std_logic;
signal add_out : matrix_1_2;
signal mul_out : matrix_1_2;
signal W : matrix_2_8;
signal B : matrix_1_2;
begin

mul     : mat_mul_182 port map (clk, rst, mul_ready, X, W, mul_out);
add     : add_mat_1_2 port map (mul_out, B, add_out);
sigmoid : sigmoid_matrix_1_2 port map (clk, mul_ready, add_out, O);

ready <= mul_ready;


end architecture ; -- arch