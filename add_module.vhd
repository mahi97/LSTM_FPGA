library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity add_module is
    Port (
       inputx : in std_logic_vector(31 downto 0);
       inputy : in std_logic_vector(31 downto 0);
       output : out std_logic_vector(31 downto 0));
end add_module;

architecture high_level_sim of add_module is

begin

  process(inputx, inputy)
  variable ix : real;                
  variable iy : real;                
  variable oo : real;
  begin
    ix := slv_to_single_float(inputx);
    iy := slv_to_single_float(inputy);
    oo := ix + iy;
    output <= single_float_to_slv(oo); 
  end process;
  
end high_level_sim;
