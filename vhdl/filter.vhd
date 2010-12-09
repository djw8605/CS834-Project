library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity FILTER is
	port (
		sample: in std_logic_vector(15 downto 0);
		load: in std_logic;
		filtered: out std_logic_vector(15 downto 0)
	);
end FILTER;

architecture BEHAVIORAL of FILTER is
	signal D0, D1, D2, D3, D4, D5, D6: std_logic_vector(15 downto 0);
	signal M0, M1, M2, M3: std_logic_vector(15 downto 0);
	signal c_out: std_logic;
	
	component SHIFT_REG is 
		port (
			sample: in std_logic_vector(15 downto 0);
			load: in std_logic;
			D0, D1, D2, D3, D4, D5, D6: out std_logic_vector(15 downto 0)
		);
	end component;

	component SUM16 is
		port (
			M0, M1, M2, M3: in std_logic_vector(15 downto 0);
			S: out std_logic_vector(15 downto 0);
			c_out: out std_logic
		);
	end component;
	
	component CONV_MULT is
		port (
			D0, D1, D2, D3, D4, D5, D6: in std_logic_vector(15 downto 0);
			C0, C1, C2, C3: in std_logic_vector(15 downto 0);
			M0, M1, M2, M3: out std_logic_vector(15 downto 0)
		);
	end component;

	for SR0: SHIFT_REG use entity work.SHIFT_REG(BEHAVIORAL);
	for CM0: CONV_MULT use entity work.CONV_MULT(BEHAVIORAL);
	for SUM0: SUM16 use entity work.SUM16(BEHAVIORAL);
	
begin

	SR0: SHIFT_REG port map (sample, load, D0, D1, D2, D3, D4, D5, D6);

	CM0: CONV_MULT port map (D0, D1, D2, D3, D4, D5, D6,
			"1111110100011010", "0000000000000000",
			"0010001100010001", "0011111110101001",
			M0, M1, M2, M3);
	SUM0: SUM16 port map (M0, M1, M2, M3, filtered, c_out);

end BEHAVIORAL;
