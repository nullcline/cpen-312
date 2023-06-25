library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder is
	port(
		a, b : in std_logic_vector(7 downto 0);
		subtract : in std_logic;
		sum : out std_logic_vector(7 downto 0);
		carry : out std_logic
	);
end adder;

architecture a of adder is
	signal temp : std_logic_vector(8 downto 0);
begin
	process(a,b,temp,subtract)
	begin
		if subtract = '0' then
			temp <= ('0' & a) + ('0' & b);
			carry <= temp(8);
			sum <= temp(7 downto 0);
		
		else 
			sum <=a-b;
		end if;
	end process;
end a;