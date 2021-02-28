LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Tarea7b IS
	PORT (
		CLOCK_50 : IN std_logic;
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		HEX3 : OUT std_logic_vector(6 DOWNTO 0)
	);
END Tarea7b;
ARCHITECTURE Structure OF Tarea7b IS 
COMPONENT Reloj IS
	GENERIC (micros : integer := 1000000);	
	PORT (
		CLOCK_50 : IN std_logic;
		reloj : OUT std_logic
	);
END COMPONENT;
COMPONENT driverHex IS
	PORT (
		num : IN std_logic_vector(15 DOWNTO 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		HEX3 : OUT std_logic_vector(6 DOWNTO 0)
	);
END COMPONENT;
signal rellotge : std_logic := '0';
signal numero : std_logic_vector(15 DOWNTO 0) := (others => '0');
BEGIN
rlj: Reloj
  generic map (micros   => 2000000)
  port map    (CLOCK_50   => CLOCK_50,
               reloj => rellotge);

numero <= numero+1 when falling_edge(rellotge);					
driver : driverHex
  port map    (num   => numero,
               HEX0 => HEX0,
					HEX1 => HEX1,
					HEX2 => HEX2,
					HEX3 => HEX3);
					

END Structure;