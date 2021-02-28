LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.numeric_std.all;

ENTITY mapAbc IS
	PORT( codigoCaracter : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			bitsCaracter   : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
			lenCaracter    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END mapAbc;
ARCHITECTURE Structure OF mapAbc IS
	type ABC_MAP is array (0 to 7) 
		of std_logic_vector(10 downto 0);
	constant abc_m : ABC_MAP := ("00000010111",   -- A
										"00111010101",   -- B
										"11101011101",   -- C
										"00001110101",	  -- D
										"00000000001",	  -- E
										"00101011101",	  -- F
										"00111011101",	  -- G
										"00001010101");  -- H
										
	type ABC_LEN is array (0 to 7) 
	of std_logic_vector(3 downto 0);
	constant abc_l : ABC_LEN :=  (std_logic_vector(to_unsigned(5,4)),   -- A
											std_logic_vector(to_unsigned(9,4)),   -- B
											std_logic_vector(to_unsigned(11,4)),  -- C
											std_logic_vector(to_unsigned(7,4)),   -- D
											std_logic_vector(to_unsigned(1,4)),   -- E
											std_logic_vector(to_unsigned(9,4)),   -- F
											std_logic_vector(to_unsigned(9,4)),   -- G
											std_logic_vector(to_unsigned(7,4)));  -- H
	
BEGIN
	bitsCaracter <= abc_m(to_integer(unsigned(CodigoCaracter)));
	lenCaracter  <= abc_l(to_integer(unsigned(CodigoCaracter)));
END Structure;