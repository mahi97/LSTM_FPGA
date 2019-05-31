library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity tanh_matrix_1_8 is
    Port (
           clk : in std_logic;
           enable : in std_logic;
           input : in matrix_1_8;
           output : out matrix_1_8
         );
end tanh_matrix_1_8;

architecture Behavior of tanh_matrix_1_8 is

	component tanh_module is
	    Port (
	           clk : in std_logic;
	           enable : in std_logic;
	           input : in std_logic_vector(31 downto 0);
	           output : out std_logic_vector(31 downto 0));
	end component;

begin
tanh_m_0 : tanh_module port map (clk, enable, input(0), output(0));
tanh_m_1 : tanh_module port map (clk, enable, input(1), output(1));
tanh_m_2 : tanh_module port map (clk, enable, input(2), output(2));
tanh_m_3 : tanh_module port map (clk, enable, input(3), output(3));
tanh_m_4 : tanh_module port map (clk, enable, input(4), output(4));
tanh_m_5 : tanh_module port map (clk, enable, input(5), output(5));
tanh_m_6 : tanh_module port map (clk, enable, input(6), output(6));
tanh_m_7 : tanh_module port map (clk, enable, input(7), output(7));

end architecture ; -- Behavior