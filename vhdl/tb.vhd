library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity TB is
end TB;

architecture TEST of TB is
	
	-- Inputs.
	signal DATA_IN: std_logic_vector(15 downto 0);
	signal CLK: std_logic;	
	
	-- Output.
	signal O1, O2, O3, O4: std_logic_vector(15 downto 0);

	-- Wires.
	signal I0, I1, I2, I3, I4, I5, I6: std_logic_vector(15 downto 0);
	signal IC0, IC1, IC2, IC3: std_logic_vector(15 downto 0);
	
	component CONV_MULT is
		port (
			D0, D1, D2, D3, D4, D5, D6: in std_logic_vector(15 downto 0);
			C0, C1, C2, C3: in std_logic_vector(15 downto 0);
			M0, M1, M2, M3: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component \ShiftRegister\ is 
	port (data_in: in STD_LOGIC_VECTOR(15 downto 0);
	     clk: in STD_LOGIC;
	     A, B, C, D, E, F, G: out STD_LOGIC_VECTOR(15 downto 0));
	end component;

	for C1: \ShiftRegister\ use entity work.\ShiftRegister\(SHIFTER);
	for C2: CONV_MULT use entity work.CONV_MULT(BEHAVIORAL);
begin

	C1: \ShiftRegister\ port map (
			DATA_IN, CLK,
			I0, I1, I2, I3, I4, I5, I6);
	C2: CONV_MULT port map (
			I0, I1, I2, I3, I4, I5, I6,
			IC0, IC1, IC2, IC3,
			O1, O2, O3, O4);
			
	IC0 <= "0100000000000000";
	IC1 <= "0000010000000000";
	IC2 <= "0000000001000000";
	IC3 <= "0000000000000100";

	DATA_IN <= "0000000000000001" after 1 ns,
			"0000000000000010" after 2 ns,
			"0000000000000001" after 3 ns,
			"0000000000000001" after 4 ns,
			"0000000000000001" after 5 ns,
			"0000000000000001" after 6 ns,
			"0000000000000100" after 7 ns;

end TEST;
