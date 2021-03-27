library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SRAMController is
    port (clk         : in    std_logic;
          -- se�ales para la placa de desarrollo
          SRAM_ADDR   : out   std_logic_vector(17 downto 0);
          SRAM_DQ     : inout std_logic_vector(15 downto 0);
          SRAM_UB_N   : out   std_logic;
          SRAM_LB_N   : out   std_logic;
          SRAM_CE_N   : out   std_logic := '1';
          SRAM_OE_N   : out   std_logic := '1';
          SRAM_WE_N   : out   std_logic := '1';
          -- se�ales internas del procesador
          address     : in    std_logic_vector(15 downto 0) := "0000000000000000";
          dataReaded  : out   std_logic_vector(15 downto 0);
          dataToWrite : in    std_logic_vector(15 downto 0);
          WR          : in    std_logic;
          byte_m      : in    std_logic := '0');
end SRAMController;

architecture comportament of SRAMController is
begin

	-- READ MODE: 
	SRAM_CE_N <= '0' ;
	SRAM_OE_N <= '0';
	SRAM_LB_N <= '0';
	SRAM_UE_N <= '0';
	SRAM_WE_N <= '1'; -- write not enabled
	dataReaded <= SRAM_DQ; -- lectura de word

	-- WRITE MODE
	SRAM_CE_N <= '0' ;
	SRAM_OE_N <= 'X';
	SRAM_LB_N <= '0'; -- 0 si es vol accedir al low byte (7 - 0)
	SRAM_UE_N <= '0'; -- 0 si es vol accedir al upper byte (15 - 8)
	SRAM_WE_N <= '0';  -- write enabled
	SRAM_DQ(7 downto 0) <= dataToWrite(7 downto 0);-- when SRAM_LB_N = '0' else (others => 'Z');
	SRAM_DQ(15 downto 8) <= dataToWrite(15 downto 8);-- when SRAM_UB_N = '0' else (others => 'Z');
	
end comportament;
