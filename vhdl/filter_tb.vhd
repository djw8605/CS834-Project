library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
library STD;
use STD.textio.all;

entity TB is
end TB;

architecture FILTER_TEST of TB is
	
	-- Inputs.
	signal sample: std_logic_vector(15 downto 0);
	signal load: std_logic;
	
	-- Output.
	signal filtered: std_logic_vector(15 downto 0);

	component FILTER is
		port (
			sample: in std_logic_vector(15 downto 0);
			load: in std_logic;
			filtered: out std_logic_vector(15 downto 0)
		);
	end component;

	--type TEXTFILE is file of String;
	file INFILE: TEXT open READ_MODE is "input.txt";
	file OUTFILE: TEXT open WRITE_MODE is "output.txt";

	for C0: FILTER use entity work.FILTER(BEHAVIORAL);
begin

	C0: FILTER port map (sample, load, filtered);
			
	process
		variable v_ln: line;
		variable v_sample: std_logic_vector(15 downto 0);
	begin	
		sample <= "0000000000000000";
		for I in 0 to 50 loop
			load <= '0';
			wait for 100 ps;
			load <= '1';
			wait for 100 ps;
		end loop;
		
		load <= '0';
		for I in 0 to 100 loop
			readline(INFILE, v_ln);
			read(v_ln, v_sample);
			sample <= v_sample;
			load <= '0';
			write(v_ln, filtered);
			writeline(OUTFILE, v_ln);
			wait for 10 ns;
			load <= '1';
			wait for 10 ns;
		end loop;
		wait;
	end process;

end FILTER_TEST;
