library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity sigmoid_matrix_1_8 is
    Port (
           clk : in std_logic;
           enable : in std_logic;
           input : in matrix_1_8;
           output : out matrix_1_8
         );
end sigmoid_matrix_1_8;

architecture Behavior of sigmoid_matrix_1_8 is

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
sigmoid_m_2 : sigmoid_module port map (clk, enable, input(2), output(2));
sigmoid_m_3 : sigmoid_module port map (clk, enable, input(3), output(3));
sigmoid_m_4 : sigmoid_module port map (clk, enable, input(4), output(4));
sigmoid_m_5 : sigmoid_module port map (clk, enable, input(5), output(5));
sigmoid_m_6 : sigmoid_module port map (clk, enable, input(6), output(6));
sigmoid_m_7 : sigmoid_module port map (clk, enable, input(7), output(7));

end architecture ; -- Behavior