LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

library work;
use work.sisa16_coop_funct_pkg.all;
use work.cte_tipos_UC_pkg.all;
use work.cte_tipos_UF_pkg.all;

ENTITY control_l IS
 PORT (ir        : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 op        : OUT STD_LOGIC_VECTOR(tam_codigo_alu_op-1 DOWNTO 0);
		 ldpc      : OUT STD_LOGIC;
		 wrd       : OUT STD_LOGIC;
		 addr_a    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 addr_b    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 addr_d    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 immed     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 wr_m      : OUT STD_LOGIC;
		 in_d      : OUT STD_LOGIC;
		 immed_x2  : OUT STD_LOGIC;
		 word_byte : OUT STD_LOGIC);
END control_l;


ARCHITECTURE Structure OF control_l IS
	signal coop: codigooper;
	signal f1:   campofunct1;
	signal immed_6:   std_logic_vector(5 downto 0);
	signal immed_8:   std_logic_vector(7 downto 0);
BEGIN
	
	coop    <= ir(15 downto 16-tamcoop);
	f1      <= ir(8);
	immed_6 <= ir(5 downto 0);
	immed_8 <= ir(7 downto 0);
	
	op <= ALU_MOVHI when coop = COOP_MOV and f1 = F1_MOVHI else
			ALU_MOVI  when coop = COOP_MOV and f1 = F1_MOVI  else
			ALU_ADD   when coop = COOP_LD  or 
			               coop = COOP_ST  or
			               coop = COOP_LDB or
			               coop = COOP_STB                   else
			(others => '0');
			
	
	ldpc <= haltSI when ir(15 downto 0) = x"FFFF" else '1';
	
	wrd <= PE when coop = COOP_MOV or
	               coop = COOP_LD  or
						coop = COOP_LDB else not PE;
			 
	addr_a <= ir(11 downto 9) when coop = COOP_MOV else
	          ir(8  downto 6) when coop = COOP_LD  else
				 ir(8  downto 6) when coop = COOP_ST  else
				 ir(8  downto 6) when coop = COOP_LDB else
				 ir(8  downto 6) when coop = COOP_STB else
				 ir(8  downto 6);
				 
	addr_b <= ir(11 downto 9) when coop = COOP_ST  else
	          ir(11 downto 9) when coop = COOP_STB else
				 ir(11 downto 9);
				 
	addr_d <= ir(11 downto 9);

	immed <= std_logic_vector(resize(signed(immed_8), immed'length)) when coop = COOP_MOV else
		      std_logic_vector(resize(signed(immed_6), immed'length)) when coop = COOP_ST  or 
				                                                             coop = COOP_LD  or
																								 coop = COOP_STB or 
																								 coop = COOP_LDB;
	
--	immed(5 downto 0) <= immed_8(5 downto 0) when coop = COOP_MOV else
--			               immed_6             when coop = COOP_ST  or 
--																 coop = COOP_LD  or
--															    coop = COOP_STB or
--																 coop = COOP_LDB else
--								(others => '0');
--																 
--	
--	immed(7 downto 6) <= immed_8(7 downto 6)  when coop = COOP_MOV else
--			               (others => immed_6(5)) when coop = COOP_ST or 
--															     coop = COOP_LD  or
--																  coop = COOP_STB or
--																 coop = COOP_LDB else
--								(others => '0');
--
--	immed(15 downto 8) <= (others => immed_8(7)) when coop = COOP_MOV else
--			                (others => immed_6(5)) when coop = COOP_ST or 
--																 coop = COOP_LD  or 
--																 coop = COOP_STB or
--																 coop = COOP_LDB else
--								(others => '0');


	wr_m <= PE when coop = COOP_ST  else
	        PE when coop = COOP_STB else 
			  not PE;
			  
	in_d <= '1' when coop = COOP_LD  else
	        '1' when coop = COOP_LDB else
			  '0';
			  
	immed_x2 <= '1' when coop = COOP_LD or coop = COOP_ST else '0';
	
	word_byte <= '1' when coop = COOP_LDB else
	             '1' when coop = COOP_STB else
					 '0';

END Structure;