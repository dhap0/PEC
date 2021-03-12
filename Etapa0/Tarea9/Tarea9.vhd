LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Tarea9 IS
	PORT (
		CLOCK_50 : IN std_logic;
		KEY : IN std_logic_vector(1 DOWNTO 0);
		SW : IN std_logic_vector(2 DOWNTO 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		LEDR : OUT std_logic_vector(0 DOWNTO 0);
		LEDG : OUT std_logic_vector(0 DOWNTO 0)
	);
END Tarea9;
ARCHITECTURE Structure OF Tarea9 IS 
COMPONENT Reloj IS
	GENERIC (micros : integer := 1000000);	
	PORT (
		CLOCK_50 : IN std_logic;
		reloj : OUT std_logic
	);
END COMPONENT;
COMPONENT ControladorEstats IS
	PORT (
		rellotge : IN std_logic;
		KEY : IN std_logic_vector(1 DOWNTO 0);
		fin : IN std_logic;
		ini : OUT std_logic;
		rep : OUT std_logic
	);
END COMPONENT;
COMPONENT Actuador IS
	PORT (
		rel 		: IN std_logic;
		ini 		: IN std_logic;
		REP 		: IN std_logic;
		SW 		: IN std_logic_vector(2 DOWNTO 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		LEDR : OUT std_logic_vector(0 DOWNTO 0);
		LEDG : OUT std_logic_vector(0 DOWNTO 0);
		fin  : OUT std_logic
		
	);
END COMPONENT;
signal rellotge: std_logic := '0';
signal final, inici, repos : std_logic := '0';
BEGIN
rel : Reloj
  generic map (micros   => 500000)
  port map    (CLOCK_50   => CLOCK_50,
               reloj => rellotge);
ce : ControladorEstats
	PORT MAP(rellotge => rellotge, KEY => KEY, fin => final, ini => inici, rep => repos);
	
act : Actuador
	PORT MAP(rel => rellotge, ini => inici, REP => repos, SW => SW, HEX0 => HEX0, LEDR => LEDR, LEDG => LEDG, fin => final);

	
END Structure;