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
          SW        : in std_logic_vector(9 downto 9));
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
		word_byte : OUT STD_LOGIC
	);
end component;
component Reloj is
	GENERIC (factor : integer := 8);	
	PORT (
		CLOCK_50 : IN std_logic;
		reloj : OUT std_logic
	);
end component;

signal rellotge, word_byte_t, wr_m_t : std_logic;
signal addr_m_t, data_wr_t, rd_data_t : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	rel0  : Reloj GENERIC MAP ( factor => 8) PORT MAP (CLOCK_50 => CLOCK_50, reloj => rellotge);
	proc0 : proc PORT MAP (clk => rellotge,
								  boot => SW(9),
								  datard_m => rd_data_t,
								  addr_m => addr_m_t,
								  data_wr => data_wr_t,
								  wr_m => wr_m_t,
								  word_byte => word_byte_t);
								  
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