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
		led_rojos : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		KEY       : in std_logic_vector(3 downto 0);
		SW        : in std_logic_vector(7 downto 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		HEX3 : OUT std_logic_vector(6 DOWNTO 0)
		
	);
END controladores_IO;
ARCHITECTURE Structure OF controladores_IO IS 

COMPONENT driverHex IS
	PORT (
		num : IN std_logic_vector(15 DOWNTO 0);
		display_en : IN std_logic_vector(3 downto 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		HEX3 : OUT std_logic_vector(6 DOWNTO 0)
	);
END COMPONENT;

	type bancRegistres is array (0 to 15) of std_logic_vector(15 downto 0);
	signal mem: bancRegistres;
	signal hex_num : std_logic_vector(15 downto 0);
	signal hex_display_en : std_logic_vector(3 downto 0);
	
BEGIN
	 rd_io <= mem(conv_integer(addr_io));
	 led_rojos <= mem(6)(7 downto 0);
	 led_verdes <= mem(5)(7 downto 0);
	 
	 
	 
	 process(CLOCK_50,wr_out)
	 begin
		if boot = '0' then
			if rising_edge(CLOCK_50) then
				mem(7) <= "000000000000" & KEY;
				mem(8) <= "00000000"     & SW;
				hex_num <= mem(10);
				hex_display_en <= mem(9)(3 downto 0);
				if wr_out = PE then
					if    addr_io = 7 then
					elsif addr_io = 8 then
					else
							mem(conv_integer(addr_io(3 downto 0))) <= wr_io;
					end if;
				end if;
			end if;
		end if;
	 end process;
	 
	 	hex : driverHex port map    (num  => hex_num,--"00000000"&SW,
		         display_en => hex_display_en,
               HEX0 => HEX0,
					HEX1 => HEX1,
					HEX2 => HEX2,
					HEX3 => HEX3);
END Structure;