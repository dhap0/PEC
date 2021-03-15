library ieee;
use ieee.std_logic_1164.all;

package sisa16_coop_funct_pkg is 

constant tamcoop:   integer := 4;
constant tamfunct1: integer := 1;

subtype codigooper  is std_logic_vector(tamcoop-1 downto 0);
subtype campofunct1 is std_logic;

-- SISA16 Base
-- Codigos de operacion (CO)
constant COOP_MOV:      codigooper := "0101";
constant COOP_HALT:     codigooper := "1111";

constant MOV_HI:  campofunct1 := '1';
constant MOV_I:   campofunct1 := '0';

END PACKAGE sisa16_coop_funct_pkg;