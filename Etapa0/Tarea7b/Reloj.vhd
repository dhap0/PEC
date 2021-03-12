LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Reloj IS
	GENERIC (micros : integer := 1000000);	
	PORT (
		CLOCK_50 : IN std_logic;
		reloj : OUT std_logic
	);
END Reloj;
ARCHITECTURE Structure OF Reloj IS 
signal cnt: integer := micros*50;
signal aux: std_logic := '0';
BEGIN
cnt <= micros*50 when cnt = 0 else cnt-1 when falling_edge(CLOCK_50);
reloj <= '1' when cnt = 0 else '0';



END Structure;