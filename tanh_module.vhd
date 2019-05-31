library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity tanh_module is
    Port (
           clk : in std_logic;
           enable : in std_logic;
           input : in std_logic_vector(31 downto 0);
           output : out std_logic_vector(31 downto 0));
end tanh_module;

architecture high_level_sim of tanh_module is
  type fifo is array(0 to 3) of std_logic_vector(input'length -1 downto 0); 
  signal internal_regs : fifo;
begin
  
  process(clk)
  variable ii : real;                
  variable   oo : real;
  begin
    if rising_edge(clk) then
      if enable='1' then
          ii := slv_to_single_float(input);
          oo := TANH(ii);
          internal_regs(0) <= single_float_to_slv(oo);
      end if; 
    end if;    
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if enable='1' then
          internal_regs(1) <= internal_regs(0);
      end if; 
    end if;    
  end process;

process(clk)
  begin
    if rising_edge(clk) then
      if enable='1' then
          internal_regs(2) <= internal_regs(1);
      end if; 
    end if;    
  end process;

process(clk)
  begin
    if rising_edge(clk) then
      if enable='1' then
          internal_regs(3) <= internal_regs(2);
      end if; 
    end if;    
  end process;  
  output <= internal_regs(3);
  
end high_level_sim;
