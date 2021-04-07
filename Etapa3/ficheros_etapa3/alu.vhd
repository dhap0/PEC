LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
LIBRARY work;
USE work.cte_tipos_UF_pkg.all;

ENTITY alu IS
    PORT (x  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          y  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          op : IN  STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
          w  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END alu;


ARCHITECTURE Structure OF alu IS
BEGIN

    -- Aqui iria la definicion del comportamiento de la ALU	
	 with op select w <=
		y 										  when ALU_MOVI,
		y(7 downto 0) & x(7 downto 0)   when ALU_MOVHI,
		x + y                           when ALU_SUM,
		(others => '0') when others;

END Structure;