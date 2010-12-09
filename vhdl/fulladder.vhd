library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity FULL_ADDER is
	port(
		a     : in std_logic;
		b     : in std_logic;
		c_in  : in std_logic;
		sum   : out std_logic;
		c_out : out std_logic
	);
end FULL_ADDER;

architecture BEHAVIORAL of FULL_ADDER is
begin

	sum <= a xor b xor c_in;
	c_out <= (a and b) or (c_in and (a or b));

end BEHAVIORAL;
