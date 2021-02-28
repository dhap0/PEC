LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Tarea8 IS
	PORT (
		CLOCK_50 : IN std_logic;
		SW : IN std_logic_vector(0 DOWNTO 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		HEX3 : OUT std_logic_vector(6 DOWNTO 0);
		LEDR : OUT std_logic_vector(2 DOWNTO 0)
	);
END Tarea8;
ARCHITECTURE Structure OF Tarea8 IS COMPONENT Reloj IS
	GENERIC (micros : integer := 1000000);	
	PORT (
		CLOCK_50 : IN std_logic;
		reloj : OUT std_logic
	);
END COMPONENT;
COMPONENT driver7Segmentos IS
	PORT (
		codigoCaracter : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		bitsCaracter : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;
signal cnt : std_logic_vector(2 DOWNTO 0);
signal bus_enlace0, bus_enlace1, bus_enlace2, bus_enlace3 :  std_logic_vector(2 DOWNTO 0) := "000";
signal rellotge : std_logic;
BEGIN

reloj1 : Reloj
  generic map (micros   => 1000000)
  port map    (CLOCK_50   => CLOCK_50,
               reloj => rellotge);

	cnt <= cnt+1 when falling_edge(rellotge) and (SW(0) = '0') else 
			 cnt-1 when falling_edge(rellotge) and (SW(0) = '1');
	LEDR <= cnt;

	bus_enlace0 <= cnt + 3;
	bus_enlace1 <= cnt + 2;
	bus_enlace2 <= cnt + 1;
	bus_enlace3 <= cnt;
	
	Visor0 : driver7Segmentos
	PORT MAP(codigoCaracter => bus_enlace0, bitsCaracter => HEX0);
	Visor1 : driver7Segmentos
	PORT MAP(codigoCaracter => bus_enlace1, bitsCaracter => HEX1);
	Visor2 : driver7Segmentos
	PORT MAP(codigoCaracter => bus_enlace2, bitsCaracter => HEX2);
	Visor3 : driver7Segmentos
	PORT MAP(codigoCaracter => bus_enlace3, bitsCaracter => HEX3);
	
END Structure;