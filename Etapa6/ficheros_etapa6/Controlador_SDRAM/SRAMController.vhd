library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity SRAMController is
    port (clk         : in    std_logic;
          -- seï¿½ales para la placa de desarrollo
          SRAM_ADDR   : out   std_logic_vector(17 downto 0);
          SRAM_DQ     : inout std_logic_vector(15 downto 0);
          SRAM_UB_N   : out   std_logic;
          SRAM_LB_N   : out   std_logic;
          SRAM_CE_N   : out   std_logic := '1';
          SRAM_OE_N   : out   std_logic := '1';
          SRAM_WE_N   : out   std_logic := '1';
          -- seï¿½ales internas del procesador
          address     : in    std_logic_vector(15 downto 0) := "0000000000000000";
          dataReaded  : out   std_logic_vector(15 downto 0);
          dataToWrite : in    std_logic_vector(15 downto 0);
          WR          : in    std_logic;
          byte_m      : in    std_logic := '0');
end SRAMController;

architecture comportament of SRAMController is
type state_enum is (Idl, Esc);
signal state : state_enum := Idl;

	signal lb_n, ub_n, we: std_logic := '0';
begin

	lb_n <= byte_m and address(0); -- si access a word o acces al byte de menys pes (negat)
	ub_n <=  byte_m and (not address(0)); -- si access a word o acces al byte de mes pes (negat)




	-- READ/WRITE MODE
	SRAM_CE_N <= '0' ;
	SRAM_OE_N <= '0'; --'X' when WR = '1' else '0';
	SRAM_LB_N <= lb_n; -- 0 si es vol accedir al low byte (7 - 0)
	SRAM_UB_N <= ub_n; -- 0 si es vol accedir al upper byte (15 - 8)
	SRAM_WE_N <= '0' when state = Esc else '1';  
	
	SRAM_DQ <= (others => 'Z') when WR = '0' else
					dataToWrite		when lb_n = '0' and ub_n = '0' else
					"ZZZZZZZZ" & dataToWrite(7 downto 0) when lb_n = '0' else
					dataToWrite(7 downto 0) & "ZZZZZZZZ" when ub_n = '0';
					
	dataReaded <= SRAM_DQ when lb_n = '0' and ub_n = '0' else
					  std_logic_vector(resize(signed(SRAM_DQ(7 downto 0)), dataReaded'length))	when lb_n = '0' else
					  std_logic_vector(resize(signed(SRAM_DQ(15 downto 8)), dataReaded'length)) when ub_n = '0'; -- lectura de word
	
	SRAM_ADDR <= "000" & address(15 downto 1);
	
	

		process(clk, WR)
	begin
		if WR = '0' then
			we <= '1';
		elsif rising_edge(clk) then
			case state is
				when Idl => 
					if we = '1' then
						state <= Esc;
						we <= '0';
					else state <= Idl;
					end if;
				when others => 
					state <= Idl;
					
			end case;
			
		end if;
	end process;

	
	
end comportament;