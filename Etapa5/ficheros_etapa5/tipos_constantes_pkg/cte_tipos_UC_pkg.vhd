library ieee;
use ieee.std_logic_1164.all;

package cte_tipos_UC_pkg is

-- constant PE:  std_logic:= '1';

constant haltSI: std_logic:= '0';
constant haltNO: std_logic:= '1';


constant PC_INCR:  std_logic_vector(1 downto 0) := "00";
constant BR_SI:    std_logic_vector(1 downto 0) := "01";
constant JMP_SI:   std_logic_vector(1 downto 0) := "10";
constant PC_BLOQ:  std_logic_vector(1 downto 0) := "11";

-- Mx betwen d <= (aluout | memory | current pc)
constant REGFILE_D_ALU: std_logic_vector(1 downto 0) := "00";
constant REGFILE_D_MEM: std_logic_vector(1 downto 0) := "01";
constant REGFILE_D_PC:  std_logic_vector(1 downto 0) := "10";

constant PC_INI: std_logic_vector(15 downto 0) := x"C000";

END PACKAGE cte_tipos_UC_pkg;