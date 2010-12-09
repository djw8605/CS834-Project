library ieee;
use ieee.std_logic_1164.all;

entity D_FF is
	port(
		D: in std_logic_vector(15 downto 0);
		CLK: in std_logic;
		Q: out std_logic_vector(15 downto 0)
	);
end D_FF;

architecture BEHAVIORAL of D_FF is

   signal a, b, c, e, f, g, h, lclk: std_logic_vector(15 downto 0) := "0000000000000000";
   
begin
	
	a <= not (D and g) after 100 ps;
	b <= not (a and c) after 100 ps;
	c <= not (b and lclk) after 100 ps;
	e <= not (c and f) after 100 ps;
	f <= not (g and e) after 100 ps;
	g <= not (c and lclk and a) after 100 ps;
	h <= e xor D after 100 ps;
	--lclk <= h and (15 downto 0 => CLK) after 100 ps;
	lclk <= (15 downto 0 => CLK) after 100 ps;

	Q <= e;
	
end BEHAVIORAL;
