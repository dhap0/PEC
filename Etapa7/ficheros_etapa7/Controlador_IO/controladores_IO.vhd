LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;        --Esta libreria sera necesaria si usais conversiones TO_INTEGER
USE ieee.std_logic_unsigned.all; --Esta libreria sera necesaria si usais conversiones CONV_INTEGER

library work;
use work.cte_tipos_UF_pkg.all;
use work.cte_tipos_IO_pkg.all;

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
	
	signal cont_ciclos  : STD_LOGIC_VECTOR(15 downto 0):=x"0000";
	signal cont_mili    : STD_LOGIC_VECTOR(15 downto 0):=x"0000";

BEGIN
	 rd_io      <= mem(conv_integer(addr_io(4 downto 0)));
	 led_rojos  <= mem(IO_PORT_LEDR)(7 downto 0);
	 led_verdes <= mem(IO_PORT_LEDG)(7 downto 0);
	 
	 process(CLOCK_50,wr_out)
	 begin
		if boot = '0' then
			if rising_edge(CLOCK_50) then
			   clear_char <= '0';
				
				mem(IO_PORT_KEY)           <= "000000000000"    & KEY;
				mem(IO_PORT_SW)            <= "00000000"     	& SW;
				mem(IO_PORT_KB_READ_CHAR)  <= "00000000"        & kb_read_char;
				mem(IO_PORT_KB_DATA_READY) <= "000000000000000" & kb_data_ready;
				mem(IO_PORT_CONT_CICLOS)   <= cont_ciclos;
				mem(IO_PORT_CONT_MILI)     <= cont_mili;
				
				hex_num        <= mem(IO_PORT_HEX_DISPLAY_EN);
				hex_display_en <= mem(IO_PORT_HEX_NUM)(3 downto 0);
				
				if wr_out = PE then
					if    addr_io = IO_PORT_KEY then
					elsif addr_io = IO_PORT_SW then
					elsif addr_io = IO_PORT_KB_READ_CHAR then
					elsif addr_io = IO_PORT_KB_DATA_READY then
					  clear_char <= '1';
					elsif addr_io = IO_PORT_CONT_CICLOS then
					elsif addr_io = IO_PORT_CONT_MILI then
					else
					  mem(conv_integer(addr_io(4 downto 0))) <= wr_io;
					end if;
				end if;
			end if;
		end if;
	 end process;
	 
	 kb : keyboard_controller port map (clk => CLOCK_50,
          reset      => boot,
          ps2_clk    => PS2_CLK,
          ps2_data   => PS2_DAT,
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
		
			if cont_ciclos=0 then
				cont_ciclos <= x"C350"; -- tiempo de ciclo=20ns(50Mhz) 1ms=50000ciclos
			else
				cont_ciclos <= cont_ciclos-1;
			end if;
		
			if wr_out = PE and addr_io = IO_PORT_CONT_MILI then
				cont_mili <= wr_io;
			elsif cont_mili > 0 and cont_ciclos = 0 then
				cont_mili <= cont_mili-1;
			end if;
			
		end if;
	end process;

END Structure;