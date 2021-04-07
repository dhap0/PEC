LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
LIBRARY work;
USE work.cte_tipos_UF_pkg.all;

ENTITY alu IS
    PORT (x  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          y  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          op : IN  STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
          w  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			 z  : OUT STD_LOGIC);
END alu;


ARCHITECTURE Structure OF alu IS
signal w_t, resta: std_logic_vector(15 downto 0);
signal eq, cmpltu: std_logic;

BEGIN
	w <= w_t;
	z <= '1' when w_t = 0 else '0';
	
	resta <= x - y;
	eq <= '1' when x = y else '0';
	cmpltu <= '1' when unsigned(x) < unsigned(y) else '0';

	
	with op select w_t <=
		y 										         when ALU_MOVI,
		y(7 downto 0) & x(7 downto 0)          when ALU_MOVHI,
		x + y                           			when ALU_SUM,
		"000000000000000" &  resta(15)         when ALU_CMPLT,
		"000000000000000" & (resta(15) or eq)  when ALU_CMPLE,
		"000000000000000" &  eq                when ALU_CMPLEQ,
		"000000000000000" &  cmpltu            when ALU_CMPLTU,
		"000000000000000" & (cmpltu    or eq)  when ALU_CMPLEU,
		
		
		(others => '0') when others;
		

	

END Structure;