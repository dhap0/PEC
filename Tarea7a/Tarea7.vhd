LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;
ENTITY Tarea7 IS
	PORT (
		CLOCK_50 : IN std_logic;
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		LEDR : OUT std_logic_vector(8 DOWNTO 0)
	);
END Tarea7;
ARCHITECTURE Structure OF Tarea7 IS 
signal cnt : std_logic_vector(24 DOWNTO 0) := (others=>'0'); 
type num_map is ARRAY(0 to 9) of
    std_logic_vector(6 downto 0);
constant numword : num_map := ("1000000", -- "0"
										 "1111001", -- "1"
										 "0100100", -- "2"
										 "0110000", -- "3"
										 "0011001", -- "4"
										 "0010010", -- "5"
										 "0000010", -- "6"
										 "1111000", -- "7"
										 "0000000", -- "8"
										 "0010000" ); 
signal i : integer range 0 to 9 := 0;
BEGIN

cnt <= cnt+1 when falling_edge(CLOCK_50);
i <= 0 when falling_edge(cnt(24)) and i = 9 else i+1 when falling_edge(cnt(24)) ;
HEX0 <= numword(i);
LEDR <= std_logic_vector(to_unsigned(i,9));


END Structure;