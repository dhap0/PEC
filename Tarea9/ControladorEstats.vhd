LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY ControladorEstats IS
	PORT (
		rellotge : IN std_logic;
		KEY : IN std_logic_vector(1 DOWNTO 0);
		fin : IN std_logic;
		ini : OUT std_logic;
		rep : OUT std_logic
	);
END ControladorEstats;
ARCHITECTURE Structure OF ControladorEstats IS 
signal auxini: std_logic := '0';
signal auxrep: std_logic := '1';
BEGIN

auxini <= fin when KEY(1) = '0' else '0' when KEY(0) = '1';
auxrep <= '1' when KEY(0) = '0' else fin;
ini <= auxini when falling_edge(rellotge);
rep <= auxrep when falling_edge(rellotge);
	
END Structure;