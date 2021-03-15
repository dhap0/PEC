library ieee;
use ieee.std_logic_1164.all;

package cte_tipos_UC_pkg is

constant PE:  std_logic:= '1';

constant haltSI: std_logic:= '0';
constant haltNO: std_logic:= '1';

constant PC_INI: std_logic_vector(15 downto 0) := x"C000";

END PACKAGE cte_tipos_UC_pkg;