library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity SUM16 is
	port (
		M0, M1, M2, M3: in std_logic_vector(15 downto 0);
		S: out std_logic_vector(15 downto 0);
		c_out: out std_logic
	);
end SUM16;

architecture BEHAVIORAL of SUM16 is
	signal S01, S23, S0123: std_logic_vector(15 downto 0);
	signal C01, C23, C0123: std_logic;
	
	component ADD16 is
		port(
			A, B: in std_logic_vector(15 downto 0);
			c_in: in std_logic;
			S: out std_logic_vector(15 downto 0);
			c_out: out std_logic
		);
	end component;
	
	for c0: ADD16 use entity work.ADD16(BEHAVIORAL);
	for c1: ADD16 use entity work.ADD16(BEHAVIORAL);
	for c: ADD16 use entity work.ADD16(BEHAVIORAL);
begin

	c0: ADD16 port map (M0, M1, '0', S01, C01);
	c1: ADD16 port map (M2, M3, '0', S23, C23);
	c: ADD16 port map (S01, S23, '0', S0123, C0123);
	
	c_out <= C01 or C23 or C0123;
	S <= S0123;
	
	--S <= M0 + M1 + M2 + M3;
	--c_out <= '0';

end BEHAVIORAL;
