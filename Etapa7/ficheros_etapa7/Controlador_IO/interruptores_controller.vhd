library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity interruptores_controller is
    Port (clk        : in    STD_LOGIC;
          boot       : in    STD_LOGIC;
			 inta       : in    STD_LOGIC;
			 switches   : in    STD_LOGIC_VECTOR(7 DOWNTO 0);
			 intr       : out   STD_LOGIC;
			 rd_switch  : out   STD_LOGIC_VECTOR(7 DOWNTO 0));
end interruptores_controller;


ARCHITECTURE Structure OF interruptores_controller IS

BEGIN

END Structure;			 