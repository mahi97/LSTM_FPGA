library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity sigmoid_matrix_1_2 is
    Port (
           clk : in std_logic;
           enable : in std_logic;
           input : in matrix_1_2;
           output : out matrix_1_2
         );
end sigmoid_matrix_1_2;

architecture Behavior of sigmoid_matrix_1_2 is

	component sigmoid_module is
	    Port (
	           clk : in std_logic;
	           enable : in std_logic;
	           input : in std_logic_vector(31 downto 0);
	           output : out std_logic_vector(31 downto 0));
	end component;

begin
sigmoid_m_0 : sigmoid_module port map (clk, enable, input(0), output(0));
sigmoid_m_1 : sigmoid_module port map (clk, enable, input(1), output(1));

end architecture ; -- Behavior