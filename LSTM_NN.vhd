library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.neurals_utils.all;


entity LSTM_NN is
  port (
	  clk   : in  std_logic;
    rst   : in  std_logic;
	  xm    : in  matrix_20_4;
    om    : out matrix_1_2;
    ready : out std_logic
  ) ;
end entity ; -- LSTM

architecture arch of LSTM_NN is

component LSTM is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    x     : in  matrix_1_4;
    h_old : in  matrix_1_8;
    c_old : in  matrix_1_8;
    c_new : out matrix_1_8;
    h_new : out matrix_1_8;
    ready : out std_logic
  ) ;
end component ; -- LSTM

component Classify is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    X     : in  matrix_1_8;
    O     : out matrix_1_2;
    ready : out std_logic
  ) ;
end component ; -- Classify

signal h_0 , c_0 : matrix_1_8; signal r_0 : std_logic;
signal h_1 , c_1 : matrix_1_8; signal r_1 : std_logic;
signal h_2 , c_2 : matrix_1_8; signal r_2 : std_logic;
signal h_3 , c_3 : matrix_1_8; signal r_3 : std_logic;
signal h_4 , c_4 : matrix_1_8; signal r_4 : std_logic;
signal h_5 , c_5 : matrix_1_8; signal r_5 : std_logic;
signal h_6 , c_6 : matrix_1_8; signal r_6 : std_logic;
signal h_7 , c_7 : matrix_1_8; signal r_7 : std_logic;
signal h_8 , c_8 : matrix_1_8; signal r_8 : std_logic;
signal h_9 , c_9 : matrix_1_8; signal r_9 : std_logic;
signal h_10, c_10: matrix_1_8; signal r_10: std_logic;
signal h_11, c_11: matrix_1_8; signal r_11: std_logic;
signal h_12, c_12: matrix_1_8; signal r_12: std_logic;
signal h_13, c_13: matrix_1_8; signal r_13: std_logic;
signal h_14, c_14: matrix_1_8; signal r_14: std_logic;
signal h_15, c_15: matrix_1_8; signal r_15: std_logic;
signal h_16, c_16: matrix_1_8; signal r_16: std_logic;
signal h_17, c_17: matrix_1_8; signal r_17: std_logic;
signal h_18, c_18: matrix_1_8; signal r_18: std_logic;
signal h_19, c_19: matrix_1_8; signal r_19: std_logic;
signal h_20, c_20: matrix_1_8; signal r_20: std_logic;

begin
h_0 <= (others => (others => '0'));
c_0 <= (others => (others => '0'));

classifier: Classify port map (clk, rst, h_20, om, r_20);

lstm_0 : LSTM port map (clk, rst, xm(0 ), h_0 , c_0 , h_1 , c_1 , r_0 );
lstm_1 : LSTM port map (clk, rst, xm(1 ), h_1 , c_1 , h_2 , c_2 , r_1 );
lstm_2 : LSTM port map (clk, rst, xm(2 ), h_2 , c_2 , h_3 , c_3 , r_2 );
lstm_3 : LSTM port map (clk, rst, xm(3 ), h_3 , c_3 , h_4 , c_4 , r_3 );
lstm_4 : LSTM port map (clk, rst, xm(4 ), h_4 , c_4 , h_5 , c_5 , r_4 );
lstm_5 : LSTM port map (clk, rst, xm(5 ), h_5 , c_5 , h_6 , c_6 , r_5 );
lstm_6 : LSTM port map (clk, rst, xm(6 ), h_6 , c_6 , h_7 , c_7 , r_6 );
lstm_7 : LSTM port map (clk, rst, xm(7 ), h_7 , c_7 , h_8 , c_8 , r_7 );
lstm_8 : LSTM port map (clk, rst, xm(8 ), h_8 , c_8 , h_9 , c_9 , r_8 );
lstm_9 : LSTM port map (clk, rst, xm(9 ), h_9 , c_9 , h_10, c_10, r_9 );
lstm_10: LSTM port map (clk, rst, xm(10), h_10, c_10, h_11, c_11, r_10);
lstm_11: LSTM port map (clk, rst, xm(11), h_11, c_11, h_12, c_12, r_11);
lstm_12: LSTM port map (clk, rst, xm(12), h_12, c_12, h_13, c_13, r_12);
lstm_13: LSTM port map (clk, rst, xm(13), h_13, c_13, h_14, c_14, r_13);
lstm_14: LSTM port map (clk, rst, xm(14), h_14, c_14, h_15, c_15, r_14);
lstm_15: LSTM port map (clk, rst, xm(15), h_15, c_15, h_16, c_16, r_15);
lstm_16: LSTM port map (clk, rst, xm(16), h_16, c_16, h_17, c_17, r_16);
lstm_17: LSTM port map (clk, rst, xm(17), h_17, c_17, h_18, c_18, r_17);
lstm_18: LSTM port map (clk, rst, xm(18), h_18, c_18, h_19, c_19, r_18);
lstm_19: LSTM port map (clk, rst, xm(19), h_19, c_19, h_20, c_20, r_19);

ready <= r_0  and r_1  and r_2  and r_3  and r_4  and r_5  and r_6  and r_7  and r_8  and r_9  and 
         r_10 and r_11 and r_12 and r_13 and r_14 and r_15 and r_16 and r_17 and r_18 and r_19 and r_20;

end architecture ; -- arch