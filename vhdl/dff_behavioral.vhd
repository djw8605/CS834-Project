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
begin

	process (CLK)
	begin
		if rising_edge(CLK) then
			Q <= D;
		end if;	
	end process;
	
end BEHAVIORAL;
