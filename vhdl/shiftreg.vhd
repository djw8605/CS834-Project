library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity SHIFT_REG is
	port (
		sample: in std_logic_vector(15 downto 0);
		load: in std_logic;
		D0, D1, D2, D3, D4, D5, D6: out std_logic_vector(15 downto 0)
	);
end SHIFT_REG;

architecture BEHAVIORAL of SHIFT_REG is

	signal T0, T1, T2, T3, T4, T5, T6: std_logic_vector(15 downto 0);
	
	component D_FF is
		port(
			D: in std_logic_vector(15 downto 0);
			CLK: in std_logic;
			Q: out std_logic_vector(15 downto 0)
		);
	end component;
	
	for C0: D_FF use entity work.D_FF(BEHAVIORAL);
	for C1: D_FF use entity work.D_FF(BEHAVIORAL);
	for C2: D_FF use entity work.D_FF(BEHAVIORAL);
	for C3: D_FF use entity work.D_FF(BEHAVIORAL);
	for C4: D_FF use entity work.D_FF(BEHAVIORAL);
	for C5: D_FF use entity work.D_FF(BEHAVIORAL);
	for C6: D_FF use entity work.D_FF(BEHAVIORAL);
	
begin

	C0: D_FF port map (sample, load, T0);
	C1: D_FF port map (T0, load, T1);
	C2: D_FF port map (T1, load, T2);
	C3: D_FF port map (T2, load, T3);
	C4: D_FF port map (T3, load, T4);
	C5: D_FF port map (T4, load, T5);
	C6: D_FF port map (T5, load, T6);
	
	D0 <= T0;
	D1 <= T1;
	D2 <= T2;
	D3 <= T3;
	D4 <= T4;
	D5 <= T5;
	D6 <= T6;

end BEHAVIORAL;
