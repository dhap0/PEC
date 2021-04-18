LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;        --Esta libreria sera necesaria si usais conversiones TO_INTEGER
USE ieee.std_logic_unsigned.all; --Esta libreria sera necesaria si usais conversiones CONV_INTEGER

library work;
use work.cte_tipos_UF_pkg.all;

ENTITY controladores_IO IS
	PORT (
		boot : IN STD_LOGIC;
		CLOCK_50 : IN std_logic;
		addr_io : IN std_logic_vector(7 DOWNTO 0);
		wr_io : IN std_logic_vector(15 DOWNTO 0);
		rd_io : OUT std_logic_vector(15 DOWNTO 0);
		wr_out : IN std_logic;
		rd_in : IN std_logic;
		led_verdes : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		led_rojos : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END controladores_IO;
ARCHITECTURE Structure OF controladores_IO IS 
	type bancRegistres is array (0 to 256) of std_logic_vector(15 downto 0);
	signal mem: bancRegistres;
	
BEGIN
	 rd_io <= mem(conv_integer(addr_io));
	 led_rojos <= mem(6)(7 downto 0);
	 led_verdes <= mem(5)(7 downto 0);
	 process(CLOCK_50,wr_out)
	 begin
	   if rising_edge(CLOCK_50) and wr_out = PE and boot = '0' then
			mem(conv_integer(addr_io)) <= wr_io;
		end if;
	 end process;
END Structure;