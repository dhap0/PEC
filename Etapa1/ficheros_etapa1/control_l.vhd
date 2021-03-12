LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

use work.sisa16_coop_funct_pkg.all;
use work.cte_tipos_UF_pkg.all;

ENTITY control_l IS
    PORT (ir     : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          op     : OUT STD_LOGIC;
          ldpc   : OUT STD_LOGIC;
          wrd    : OUT STD_LOGIC;
          addr_a : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
          addr_d : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
          immed  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END control_l;


ARCHITECTURE Structure OF control_l IS
BEGIN
	decoir: process(ir)
		variable coop:   codigooper;
		variable funct1: campofunct1;
	begin
		
		coop  := ir(15 downto 15-tamcoop);
		funct1 := ir(8);
		ldpc <= haltNO;
		wrd <= not regPE;
		
		case coop is
			when COOP_MOV =>
				wrd <= regPE;
				case funct1 is
					when MOV_I =>
						op <= ALU_MOVI;
					when MOV_HI =>
						op <= ALU_MOVHI;
				end case;
			when COOP_HALT =>
				ldpc <= haltSI;
		end case;
	end process;
END Structure;