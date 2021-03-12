library ieee;
use ieee.std_logic_1164.all;

package cte_tipos_UF_pkg is 

constant haltSI: std_logic:= '0';
constant haltNO: std_logic:= '1';

-- ALU OPCODES
constant ALU_MOVI: std_logic := '0';
constant ALU_MOVHI: std_logic := '1';
-- --
                                                
constant regPE:  std_logic:= '1';

END PACKAGE cte_tipos_UF_pkg;