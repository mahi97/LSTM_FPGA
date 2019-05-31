library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity add_mat_1_8 is
    Port (
           inputx : in matrix_1_8;
           inputy : in matrix_1_8;
           output : out matrix_1_8
         );
end add_mat_1_8;

architecture Behavior of add_mat_1_8 is

	component add_module is
		Port (
       		inputx : in std_logic_vector(31 downto 0);
       		inputy : in std_logic_vector(31 downto 0);
       		output : out std_logic_vector(31 downto 0)
       	);
	end component;

begin
add_m_0 : add_module port map (inputx(0), inputy(0), output(0));
add_m_1 : add_module port map (inputx(1), inputy(1), output(1));
add_m_2 : add_module port map (inputx(2), inputy(2), output(2));
add_m_3 : add_module port map (inputx(3), inputy(3), output(3));
add_m_4 : add_module port map (inputx(4), inputy(4), output(4));
add_m_5 : add_module port map (inputx(5), inputy(5), output(5));
add_m_6 : add_module port map (inputx(6), inputy(6), output(6));
add_m_7 : add_module port map (inputx(7), inputy(7), output(7));

end architecture ; -- Behavior