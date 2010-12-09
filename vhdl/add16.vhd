library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity ADD16 is
	port (
		A, B: in std_logic_vector(15 downto 0);
		c_in: in std_logic;
		S: out std_logic_vector(15 downto 0);
		c_out: out std_logic
	);
end ADD16;

architecture BEHAVIORAL of ADD16 is
	signal im: std_logic_vector(14 downto 0);
	
	component FULL_ADDER is
		port(
			a     : in std_logic;
			b     : in std_logic;
			c_in  : in std_logic;
			sum   : out std_logic;
			c_out : out std_logic
		);
	end component;
begin

	c0: FULL_ADDER port map(A(0), B(0), c_in, S(0), im(0));
	
	c: for i in 1 to 14 generate
		c1to14: FULL_ADDER port map (A(i), B(i), im(i-1), S(i), im(i));
	end generate;
	
	c15: FULL_ADDER port map(A(15), B(15), im(14), S(15), c_out);
	
end BEHAVIORAL;
