LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Actuador IS
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
END Actuador;
ARCHITECTURE Structure OF Actuador IS 
COMPONENT driver7Segmentos IS
	PORT (
		codigoCaracter : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		bitsCaracter : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;
COMPONENT mapAbc IS
	PORT( codigoCaracter : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			bitsCaracter   : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			lenCaracter    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;
COMPONENT Morse IS
 PORT( rel		 		 : IN std_logic;
		 ini 				 : IN std_logic;
		 bitsCaracter   : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 lenCaracter    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 LEDR 			 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
		 fin 				 : OUT std_logic);
END COMPONENT;

	signal bitsCaracter : std_logic_vector(10 downto 0);
	signal lenCaracter  : std_logic_vector(3 downto 0);
	signal morse_ledr	  : std_logic_vector(0 downto 0);

BEGIN
abc_m : mapAbc
  port map    (codigoCaracter   => SW,
               bitsCaracter => bitsCaracter,
					lenCaracter => lenCaracter);
morse_led : Morse
	PORT MAP(rel => rel, ini => ini, bitsCaracter => bitsCaracter, lenCaracter => lenCaracter, LEDR => morse_ledr, fin => fin);
	
	LEDR(0) <= '0' when REP = '1' else morse_ledr(0);
	LEDG(0) <= '1' when REP = '1' else '0'; 

driver : driver7Segmentos
	PORT MAP(codigoCaracter => SW, bitsCaracter => HEX0);
	
END Structure;