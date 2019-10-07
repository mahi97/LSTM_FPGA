library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity add_mat_1_2 is
    Port (
           inputx : in matrix_1_2;
           inputy : in matrix_1_2;
           output : out matrix_1_2
         );
end add_mat_1_2;

architecture Behavior of add_mat_1_2 is

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

end architecture ; -- Behavior