library ieee;
use ieee.std_logic_1164.all;

package cte_tipos_UF_pkg is 

constant tam_codigo_alu_op: integer := 2;

subtype codigo_alu_op is std_logic_vector(tam_codigo_alu_op-1 downto 0);

-- ALU OPCODES
constant ALU_MOVI:  codigo_alu_op := "00";
constant ALU_MOVHI: codigo_alu_op := "01";
constant ALU_SUM:   codigo_alu_op := "10";
-- --
       
constant PE:  std_logic:= '1';

END PACKAGE cte_tipos_UF_pkg;