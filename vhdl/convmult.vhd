library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity CONV_MULT is
	port (
		D0, D1, D2, D3, D4, D5, D6: in std_logic_vector(15 downto 0);
		C0, C1, C2, C3: in std_logic_vector(15 downto 0);
		M0, M1, M2, M3: out std_logic_vector(15 downto 0)
	);
end CONV_MULT;

architecture BEHAVIORAL of CONV_MULT is
	signal A0, A1, A2, A3: std_logic_vector(16 downto 0);
	signal B0, B1, B2, B3: std_logic_vector(32 downto 0);
begin

	-- Addition for taking advantage of the filter symmetricity.
	-- Result is in Q1.15.
	A0 <= (D0(15) & D0) + (D6(15) & D6);
	A1 <= (D1(15) & D1) + (D5(15) & D5);
	A2 <= (D2(15) & D2) + (D4(15) & D4);
	A3 <= (D3(15) & D3);
	
	-- Multiply by coeffs.
	B0 <= A0 * C0;
	B1 <= A1 * C1;
	B2 <= A2 * C2;
	B3 <= A3 * C3;
	
	-- Convert from Q1.31 to Q15.
	M0 <= B0(31 downto 16);
	M1 <= B1(31 downto 16);
	M2 <= B2(31 downto 16);
	M3 <= B3(31 downto 16);

end BEHAVIORAL;
