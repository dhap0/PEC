LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;


ENTITY sisa IS
    PORT (CLOCK_50  : IN    STD_LOGIC;
          SRAM_ADDR : out   std_logic_vector(17 downto 0);
          SRAM_DQ   : inout std_logic_vector(15 downto 0);
          SRAM_UB_N : out   std_logic;
          SRAM_LB_N : out   std_logic;
          SRAM_CE_N : out   std_logic := '1';
          SRAM_OE_N : out   std_logic := '1';
          SRAM_WE_N : out   std_logic := '1';
          SW        : in std_logic_vector(9 downto 8);
			 KEY       : in std_logic_vector(0 downto 0);
			 LEDR :  OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			 HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		    HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		    HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		    HEX3 : OUT std_logic_vector(6 DOWNTO 0));
END sisa;

ARCHITECTURE Structure OF sisa IS
component MemoryController is
    port (CLOCK_50  : in  std_logic;
	      addr      : in  std_logic_vector(15 downto 0);
          wr_data   : in  std_logic_vector(15 downto 0);
          rd_data   : out std_logic_vector(15 downto 0);
          we        : in  std_logic;
          byte_m    : in  std_logic;
          -- se�ales para la placa de desarrollo
          SRAM_ADDR : out   std_logic_vector(17 downto 0);
          SRAM_DQ   : inout std_logic_vector(15 downto 0);
          SRAM_UB_N : out   std_logic;
          SRAM_LB_N : out   std_logic;
          SRAM_CE_N : out   std_logic := '1';
          SRAM_OE_N : out   std_logic := '1';
          SRAM_WE_N : out   std_logic := '1');
end component;
component proc IS
	PORT (
		clk : IN STD_LOGIC;
		boot : IN STD_LOGIC;
		datard_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		addr_m : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		data_wr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		wr_m : OUT STD_LOGIC;
		word_byte : OUT STD_LOGIC;
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		HEX3 : OUT std_logic_vector(6 DOWNTO 0);
		LEDR : OUT std_logic_vector(9 downto 0)
	);
end component;
component Reloj is
	GENERIC (factor : integer := 8);	
	PORT (
		CLOCK_50 : IN std_logic;
		reloj : OUT std_logic	);
-- GENERIC (factor : integer);
-- PORT( CLOCK_50 : IN std_logic;
-- contador : in std_logic_vector (factor-1 downto 0);
-- reloj : out std_logic);

end component;
component driverHex IS
	PORT (
		num : IN std_logic_vector(15 DOWNTO 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		HEX3 : OUT std_logic_vector(6 DOWNTO 0)
	);
END component;

signal rellotge, word_byte_t, wr_m_t : std_logic;
signal addr_m_t, data_wr_t, rd_data_t : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal clk_input: std_logic;
signal rel0_contador_in : std_logic_vector(3 downto 0) := x"8";--std_logic_vector(to_unsigned(8, 4));
BEGIN
					
	clk_input <= rellotge when sw(8) = '0' else KEY(0);
	rel0  : Reloj GENERIC MAP ( factor => 8) PORT MAP (CLOCK_50 => CLOCK_50, reloj => rellotge);
	--rel0 : Reloj generic map (4)
	--				 port map (CLOCK_50 => CLOCK_50, contador => rel0_contador_in, reloj => rellotge);
	proc0 : proc PORT MAP (clk => clk_input,
								  boot => SW(9),
								  datard_m => rd_data_t,
								  addr_m => addr_m_t,
								  data_wr => data_wr_t,
								  wr_m => wr_m_t,
								  word_byte => word_byte_t,
								  HEX0 => HEX0,
								  HEX1 => HEX1,
								  HEX2 => HEX2,
								  HEX3 => HEX3,
								  LEDR => LEDR);
								  
	mem0	: memoryController PORT MAP (CLOCK_50 => CLOCK_50, 
												  addr => addr_m_t,
                                      wr_data => data_wr_t,
												  rd_data => rd_data_t,
                                      we => wr_m_t,
                                      byte_m => word_byte_t,
                                      SRAM_ADDR => SRAM_ADDR,
                                      SRAM_DQ => SRAM_DQ,
                                      SRAM_UB_N => SRAM_UB_N,
                                      SRAM_LB_N => SRAM_LB_N,
                                      SRAM_CE_N => SRAM_CE_N,
                                      SRAM_OE_N => SRAM_OE_N,
                                      SRAM_WE_N => SRAM_WE_N);

END Structure;