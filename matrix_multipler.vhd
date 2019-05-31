library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;

entity matrix_multipler is
    Generic (
      input_a_rows : integer := 3;
      input_a_cols : integer := 3;
      input_b_rows : integer := 3;
      input_b_cols : integer := 3
    );
    Port (
           clk : in std_logic;
           rst : in std_logic;
           enable_a : in std_logic;
           enable_b : in std_logic;
           enable_r : in std_logic;
           input_a : in std_logic_vector(31 downto 0);
           input_b : in std_logic_vector(31 downto 0);
           ready : out std_logic;
           output : out std_logic_vector(31 downto 0)
         );
end matrix_multipler;
architecture Behavioral of matrix_multipler is
  type first_mem  is array (0 to input_a_rows-1,0 to input_a_cols-1) of std_logic_vector(31 downto 0);
  type second_mem is array (0 to input_b_rows-1,0 to input_b_cols-1) of std_logic_vector(31 downto 0);
  type result_mem is array (0 to input_a_rows-1,0 to input_b_cols-1) of std_logic_vector(31 downto 0);
  
  signal firstmem : first_mem;  
  signal secondmem : second_mem;
  signal resultmem : result_mem;
  signal a_ready : std_logic;
  signal b_ready : std_logic;
begin
  
  process(clk)
  variable i : integer := 0;
  variable j : integer := 0;
  begin
    if rising_edge(clk) then
      if rst='1' then
        a_ready <= '0';
        ready <= '0';  
      elsif enable_a='1' then
        if(a_ready ='0' ) then
          firstmem(i,j) <= input_a;
          i := i+1;
        end if;
      end if;
      if(i = input_a_rows) then 
        i := 0;
        j := j+1;
      end if;
      if(j = input_a_cols) then 
        a_ready <= '1' ;
      end if;
    end if;
  end process;

  process(clk)
  variable i : integer := 0;
  variable j : integer := 0;
  begin
    if rising_edge(clk) then
      if rst='1' then
        b_ready <= '0';
        ready   <= '0';  
      elsif enable_b='1' then
        if(b_ready ='0' ) then
          secondmem(i,j) <= input_b;
          i := i+1;
        end if;
      end if;
      if(i = input_b_rows) then 
        i := 0;
        j := j+1;
      end if;
      if(j = input_b_cols) then 
        a_ready <= '1' ;
      end if;
    end if;
  end process;  

  process(a_ready, b_ready)
  variable i : integer := 0;
  variable j : integer := 0;
  variable k : integer := 0;
  variable sum : real;
  begin
    if(a_ready ='1' and b_ready ='1') then
      l1: for i in 0 to input_a_rows-1 loop
        sum := 0.0;
        l2: for j in 0 to input_b_rows-1 loop
              l3: for k in 0 to input_a_cols-1 loop
                  sum := sum + slv_to_single_float(firstmem(i,k)) * slv_to_single_float(secondmem(k,j));
              end loop;
               resultmem(i,j) <= single_float_to_slv(sum);
            end loop;
      end loop;
      ready <= '1';  
    end if;
  end process;

process(clk)
  variable i : integer := 0;
  variable j : integer := 0;
  begin
    if rising_edge(clk) then
      if rst='1' then
        ready <= '0';  
      elsif enable_r='1' then
          output <= resultmem(i,j);
          i := i+1;
      end if;
      if(i = input_b_rows) then 
        i := 0;
        j := j+1;
      end if;
      if(j = input_b_cols) then 
        j:=0;
      end if;
    end if;
  end process;  

end Behavioral;
