LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- USE IEEE.std_logic_arith.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;


ENTITY Morse IS
 PORT( rel		 : IN std_logic;
		 ini 				 : IN std_logic;
		 bitsCaracter   : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 lenCaracter    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 LEDR 			 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
		 fin 				 : OUT std_logic);
END ;

ARCHITECTURE Structure OF Morse IS

	signal contadorCaracter : std_logic_vector(3 DOWNTO 0) := "0000";

BEGIN
--	contadorCaracter <= lenCaracter 					when rising_edge(rel) and ini = '1' else
--							  (contadorCaracter - 1)	when rising_edge(rel) and contadorCaracter > 0;

	contadorCaracter <= lenCaracter 					when ini = '1' else
							  (contadorCaracter - 1)	when falling_edge(rel) and contadorCaracter > 0;
							  
	fin <= '1' when contadorCaracter = 0 else
			 '0' when ini = '1';
			 
	LEDR(0) <= bitsCaracter(to_integer(unsigned(contadorCaracter - 1)));			
				
END Structure; 