library ieee;
use ieee.std_logic_1164.all;

package sisa16_coop_funct_pkg is 

constant tamcoop:   integer := 4;
constant tamfunct1: integer := 1;
constant tamfunct3: integer := 3;

subtype codigooper  is std_logic_vector(tamcoop-1 downto 0);
subtype campofunct1 is std_logic;
subtype campofunct3 is std_logic_vector(tamfunct3-1 downto 0);

-- SISA16 Base
-- Codigos de operacion (CO)

constant COOP_CMP:      codigooper := "0001";
constant COOP_LD:       codigooper := "0011";
constant COOP_ST:       codigooper := "0100";
constant COOP_MOV:      codigooper := "0101";
constant COOP_LDB:      codigooper := "1101";
constant COOP_STB:      codigooper := "1110";
constant COOP_HALT:     codigooper := "1111";


constant F1_MOVHI:  campofunct1 := '1';
constant F1_MOVI:   campofunct1 := '0';

-- F3_CMP
constant F3_CMPLT : campofunct3  := "000";
constant F3_CMPLE : campofunct3  := "001";
--                                  "010"
constant F3_CMPEQ : campofunct3  := "011";
constant F3_CMPLTU : campofunct3 := "100";
constant F3_CMPLEU : campofunct3 := "101";

-- F3_A_L
constant F3_AND : campofunct3 := "000";
constant F3_OR :  campofunct3 := "001";
constant F3_XOR : campofunct3 := "010";
constant F3_NOT : campofunct3 := "011";
constant F3_ADD : campofunct3 := "100";
constant F3_SUB : campofunct3 := "101";
constant F3_SHA : campofunct3 := "110";
constant F3_SHL : campofunct3 := "111";



END PACKAGE sisa16_coop_funct_pkg;