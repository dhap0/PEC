library ieee;
use ieee.std_logic_1164.all;

package cte_tipos_UF_pkg is 

constant tam_codigo_alu_op: integer := 4;

subtype codigo_alu_op is std_logic_vector(tam_codigo_alu_op-1 downto 0);

-- ALU OPCODES
constant ALU_MOVI:    codigo_alu_op := "0000";
constant ALU_MOVHI:   codigo_alu_op := "0001";
constant ALU_SUM:     codigo_alu_op := "0010";

-- CMPLT
constant ALU_CMPLT:   codigo_alu_op := "1000";
constant ALU_CMPLE:   codigo_alu_op := "1001";
--                                     "1010";
constant ALU_CMPLEQ:  codigo_alu_op := "1011";
constant ALU_CMPLTU:  codigo_alu_op := "1100";
constant ALU_CMPLEU:  codigo_alu_op := "1101";
--                                     "1110";
--                                     "1111";
       
constant PE:  std_logic:= '1';

END PACKAGE cte_tipos_UF_pkg;