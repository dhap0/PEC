library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity interrupt_controller is
    Port (clk         : in   STD_LOGIC;
          boot        : in   STD_LOGIC;
			 inta        : in   STD_LOGIC;
			 key_intr    : in   STD_LOGIC;
			 ps2_intr    : in   STD_LOGIC;
			 switch_intr : in   STD_LOGIC;
			 timer_intr  : in   STD_LOGIC;
			 
			 intr        : out  STD_LOGIC;
			 key_inta    : out  STD_LOGIC;
			 ps2_inta    : out  STD_LOGIC;
			 switch_inta : out  STD_LOGIC;
			 timer_inta  : out  STD_LOGIC;
			 iid         : out  STD_LOGIC_VECTOR(7 DOWNTO 0));
end interrupt_controller;


ARCHITECTURE Structure OF interrupt_controller IS

BEGIN

END Structure;