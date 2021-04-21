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
		PS2_CLK : inout std_logic;
      PS2_DAT : inout std_logic; 
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
COMPONENT keyboard_controller IS
    Port (clk        : in    STD_LOGIC;
          reset      : in    STD_LOGIC;
          ps2_clk    : inout STD_LOGIC;
          ps2_data   : inout STD_LOGIC;
          read_char  : out   STD_LOGIC_VECTOR (7 downto 0);
          clear_char : in    STD_LOGIC;
			 data_ready : out   STD_LOGIC);
END COMPONENT;

	type bancRegistres is array (0 to 31) of std_logic_vector(15 downto 0);
	signal mem: bancRegistres;
	signal hex_num : std_logic_vector(15 downto 0);
	signal hex_display_en : std_logic_vector(3 downto 0);
	signal kb_read_char : std_logic_vector(7 downto 0);
	signal kb_data_ready : std_logic;
	signal clear_char : std_logic;
	
	signal contador_ciclos       : STD_LOGIC_VECTOR(15 downto 0):=x"0000";
	signal contador_milisegundos : STD_LOGIC_VECTOR(15 downto 0):=x"0000";

BEGIN
	 rd_io <= mem(conv_integer(addr_io(4 downto 0)));
	 led_rojos <= mem(6)(7 downto 0);
	 led_verdes <= mem(5)(7 downto 0);
	 
	 process(CLOCK_50,wr_out)
	 begin
		if boot = '0' then
			if rising_edge(CLOCK_50) then
			   clear_char <= '0';
				mem(7) <= "000000000000"     & KEY;
				mem(8) <= "00000000"     	  & SW;
				mem(15) <= "00000000"        & kb_read_char;
				mem(16) <= "000000000000000" & kb_data_ready;
				mem(20) <= contador_ciclos;
				mem(21) <= contador_milisegundos;
				hex_num <= mem(10);
				hex_display_en <= mem(9)(3 downto 0);
				if wr_out = PE then
					if    addr_io = 7 then
					elsif addr_io = 8 then
					elsif addr_io = 15 then
					elsif addr_io = 16 then
					  clear_char <= '1';
					elsif addr_io = 20 then
					elsif addr_io = 21 then
					else
					  mem(conv_integer(addr_io(4 downto 0))) <= wr_io;
					end if;
				end if;
			end if;
		end if;
	 end process;
	 
	 kb : keyboard_controller port map (clk => CLOCK_50,
          reset    => boot,
          ps2_clk  => PS2_CLK,
          ps2_data => PS2_DAT,
          read_char  => kb_read_char,
          clear_char => clear_char,
			 data_ready => kb_data_ready); 
			 
	 hex : driverHex port map    (num  => hex_num,--"00000000"&SW,
		         display_en => hex_display_en,
               HEX0 => HEX0,
					HEX1 => HEX1,
					HEX2 => HEX2,
					HEX3 => HEX3);
					
	timer: process(CLOCK_50)
	 begin
		 if rising_edge(CLOCK_50) then
			 if contador_ciclos=0 then
				contador_ciclos<=x"C350"; -- tiempo de ciclo=20ns(50Mhz) 1ms=50000ciclos
				if wr_out = PE and addr_io = 21 then
					contador_milisegundos <= wr_io;
				elsif contador_milisegundos>0 then
					contador_milisegundos <= contador_milisegundos-1;
				end if;
			 else
			  contador_ciclos <= contador_ciclos-1;
			 end if;
		 end if;
	 end process;
END Structure;