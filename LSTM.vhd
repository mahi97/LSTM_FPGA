entity LSTM is
  port (
	clk   : in  std_logic;
	x     : in  matrix_1_4;
    h_old : in  matrix_1_8;
    c_old : in  matrix_1_8;
    c_new : out matrix_1_8;
    h_new : out matrix_1_8;
    ready : out std_logic
  ) ;
end entity ; -- LSTM

architecture arch of LSTM is

	component tanh_module is
	    Port (
	           clk : in std_logic;
	           enable : in std_logic;
	           input : in std_logic_vector(31 downto 0);
	           output : out std_logic_vector(31 downto 0));
	end component;

	

begin



end architecture ; -- arch