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
		rep : OUT std_logic;
		LEDG: OUT std_logic_vector(7 downto 6)
	);
END ControladorEstats;
ARCHITECTURE Structure OF ControladorEstats IS 
signal auxini: std_logic := '0';
signal auxrep: std_logic := '1';

signal estado    : std_logic := '0';
signal prxestado : std_logic := '0';

signal KEY_0 : std_logic := '1';
signal KEY_1 : std_logic := '1';

BEGIN

--auxini <= '1' when KEY(1) = '0' and (auxrep = '1' or fin = '1') else '0' when  KEY(0) = '0' or fin = '0';
--auxrep <= '0' when KEY(1) = '0' else '1' when (KEY(0) = '0') and auxrep = '0';
--
--ini <= auxini  when falling_edge(rellotge);
--rep <= auxrep or fin  when falling_edge(rellotge);

LEDG(7) <= prxestado;
LEDG(6) <= estado;
estado    <= prxestado when falling_edge(rellotge);
prxestado <= '1' when estado = '0' and KEY_1 = '0' else
				 '0' when estado = '1' and (KEY_0 = '0' ) else 
				 not fin when estado = '1';

KEY_0 <= '1' when estado = '0' else
			'0' when falling_edge(KEY(0));
			
KEY_1 <= '1' when (estado = '1' and prxestado = '0') or KEY_0 = '0'  else
			'0' when falling_edge(KEY(1));
			--'1' when falling_edge(rellotge);


auxini <= '1' when estado = '0' and prxestado = '1' else 
			 '0';
			 
auxrep <= '1' when estado = '0' else 
			 '0';

ini <= auxini  when falling_edge(rellotge);
rep <= auxrep  when falling_edge(rellotge);
	
END Structure;