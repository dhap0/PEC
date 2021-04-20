LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Reloj IS
	GENERIC (factor : integer := 8);	
	PORT (
		CLOCK_50 : IN std_logic;
		reloj : OUT std_logic
	);
END Reloj;
ARCHITECTURE Structure OF Reloj IS 
signal cnt: integer := factor/2;
signal aux: std_logic := '0';
BEGIN
cnt <= factor/2 when cnt = 0 else cnt-1 when rising_edge(CLOCK_50);
aux <= not aux when cnt = 0;
reloj <= aux;


END Structure;
