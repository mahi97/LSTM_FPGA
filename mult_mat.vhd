library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity mul_mat_1_8 is
    Port (
           inputx : in matrix_1_8;
           inputy : in matrix_1_8;
           output : out matrix_1_8
         );
end mul_mat_1_8;

architecture Behavior of mul_mat_1_8 is

	component multiplier_module is
		Port (
       		inputx : in std_logic_vector(31 downto 0);
       		inputy : in std_logic_vector(31 downto 0);
       		output : out std_logic_vector(31 downto 0)
       	);
	end component;

begin
mul_m_0 : multiplier_module port map (inputx(0), inputy(0), output(0));
mul_m_1 : multiplier_module port map (inputx(1), inputy(1), output(1));
mul_m_2 : multiplier_module port map (inputx(2), inputy(2), output(2));
mul_m_3 : multiplier_module port map (inputx(3), inputy(3), output(3));
mul_m_4 : multiplier_module port map (inputx(4), inputy(4), output(4));
mul_m_5 : multiplier_module port map (inputx(5), inputy(5), output(5));
mul_m_6 : multiplier_module port map (inputx(6), inputy(6), output(6));
mul_m_7 : multiplier_module port map (inputx(7), inputy(7), output(7));

end architecture ; -- Behavior