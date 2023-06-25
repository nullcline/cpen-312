LIBRARY ieee ;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
ENTITY clock IS
	PORT (
	CLK_50, LSec, LMin, LHr : IN STD_LOGIC ; --clock for incrementing, L for latch. toggles for saving latched values to output
	ISec, IMin, IHr: in std_logic_vector(7 downto 0); -- I for input. latched values connected to clock, which are toggled by buttons
	Sec, Min, Hr : buffer std_logic_vector(7 downto 0)
	);	--each output is a bcd representation 
END clock; 
ARCHITECTURE a OF clock IS
	SIGNAL ClkFlag: STD_LOGIC;
	SIGNAL Internal_Count: STD_LOGIC_VECTOR(28 downto 0);
	BEGIN
		PROCESS (CLK_50) IS
			BEGIN
				if(CLK_50'event and CLK_50='1') then
					if Internal_Count<25000000 then
						Internal_Count<=Internal_Count+1;
					else
						Internal_Count<=(others => '0');
						ClkFlag<=not ClkFlag;
					end if;
				end if;
			END PROCESS;
				
		PROCESS (ClkFlag, LSec, Lmin, LHr, ISec, IMin, IHr) IS
			BEGIN
				IF LSec = '0' THEN
					Sec <= ISec;
				ELSIF LMin = '0' THEN
					Min <= IMin;
				ELSIF LHr = '0' THEN
					Hr <= IHr;
				ELSIF (ClkFlag'EVENT AND ClkFlag = '1') THEN -- if you're reading this, don't judge me.
					Sec(3 downto 0) <= Sec(3 downto 0) + "0001"; --increment the seconds place
					
					IF Sec(3 downto 0) = "1001" THEN --roll over the ones place for seconds
						Sec(3 downto 0) <= "0000";
						Sec(7 downto 4) <= Sec(7 downto 4) + "0001";
					END IF;
						
					IF Sec = "01011001" THEN --roll over the tens place for seconds
						Sec(7 downto 4) <= "0000";
						Min(3 downto 0) <= Min(3 downto 0) + "0001";
					END IF;
						
					IF Min(3 downto 0) = "1001" AND Sec = "01011001" THEN --ones place for minutes
						Min(3 downto 0) <= "0000";
						Min(7 downto 4) <= Min(7 downto 4) + "0001";
					END IF;
						
					IF Min = "01011001" AND Sec = "01011001" THEN --if we hit 60 minutes. roll back to 0 and shit
						Min(7 downto 4) <= "0000";
						Hr(3 downto 0) <= Hr(3 downto 0) + "0001";
					END IF;
						
					IF Hr(3 downto 0) = "1001" AND MIN = "01011001" AND Sec = "01011001" THEN --ones place for hours
						Hr(3 downto 0) <= "0000";
						Hr(7 downto 4) <= Hr(7 downto 4) + "0001";
					END IF;
					
					IF Hr = "00100011" AND MIN = "01011001" AND Sec = "01011001" THEN --if we hit 2400, roll back to 0
							Hr(3 downto 0) <= "0000";
							Hr(7 downto 4) <= "0000";
					END IF;
						
				END IF;
	END PROCESS;
END a;