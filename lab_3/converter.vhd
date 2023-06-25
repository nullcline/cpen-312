library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity converter is
	port
	(
		Hr: in STD_LOGIC_VECTOR (7 downto 0);
		Military: in std_logic;
		PM: out std_logic;
		Display : out STD_LOGIC_VECTOR (7 downto 0)
	);
end converter;

architecture a of converter is
	
	begin
		process(Hr, Military) is
			begin
				if Military = '1' then
					Display <= Hr;
					case Hr is
						when "00010011" =>
							Display<="00000001";
							PM <= '1';
						when "00010100" =>
							Display<="00000010";
							PM <= '1';
						when "00010101" =>
							Display<="00000011";
							PM <= '1';
						when "00010110" =>
							Display<="00000100";
							PM <= '1';
						when "00010111" =>
							Display<="00000101";
							PM <= '1';
						when "00011000" =>
							Display<="00000110";
							PM <= '1';
						when "00011001" =>
							Display<="00000111";
							PM <= '1';
						when "00100000" => --20
							Display<="00001000";
							PM <= '1';
						when "00100001" =>
							Display<="00001001";
							PM <= '1';
						when "00100010" =>
							Display<="00010000";
							PM <= '1';
						when "00100011" =>
							Display<="00010001";
							PM <= '1';
						when "00000000" =>
							Display<="00010010";
							PM <= '0';
						when others =>
							PM <= '0';
					end case;
				else
					Display <= Hr;
					PM <= '0';
				end if;
		end process;
end a;