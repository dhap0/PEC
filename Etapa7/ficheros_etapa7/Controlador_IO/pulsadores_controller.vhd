library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity pulsadores_controller is
    Port (clk        : in    STD_LOGIC;
          boot       : in    STD_LOGIC;
			 inta       : in    STD_LOGIC;
			 keys       : in    STD_LOGIC_VECTOR(3 DOWNTO 0);
			 intr       : out   STD_LOGIC;
			 read_key   : out   STD_LOGIC_VECTOR(3 DOWNTO 0));
end pulsadores_controller;


ARCHITECTURE Structure OF pulsadores_controller IS

signal keys_d : std_logic_vector(3 downto 0);
signal keys_q : std_logic_vector(3 downto 0);

BEGIN

	keys_d   <= keys;
	read_key <= keys_q;
	
	next_state : process (clk, boot)
	begin
		
		if falling_edge(boot) then
			intr <= '0';
		elsif rising_edge(clk) then		
			if inta = '1' then 
				intr <= '0';
			end if;
			if not (keys = keys_q) then
				intr <= '1';
				keys_q <= keys_d;
			end if;
		end if;
	
	end process;

END Structure;			 