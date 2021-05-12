library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity timer_controller is
    Port (CLOCK_50   : in    STD_LOGIC;
          boot       : in    STD_LOGIC;
			 inta       : in    STD_LOGIC;
			 intr       : out   STD_LOGIC);
end timer_controller;


ARCHITECTURE Structure OF timer_controller IS

component clock IS
	 GENERIC(N     : integer);
	 PORT(CLOCK_50 : IN  std_logic;
		   contador : in  std_logic_vector (N-1 downto 0);
		   clk      : out std_logic);
END component;

signal clock_20hz_clk : std_logic;

BEGIN

	clock_20hz : clock generic map (2500000)
					 port map (CLOCK_50 => CLOCK_50, contador => std_logic_vector(to_unsigned(8, 4)), clk => clock_20hz_clk);

	next_state: process (CLOCK_50, clock_20hz_clk, boot)
	begin
		
		if boot = '1' then
			intr <= '0';
		elsif rising_edge(CLOCK_50) then	
			case state is
				when BLOQ =>
					if inta = '1' then 
						if not rising_edge(clock_20hz_clk) then
							intr <= '0';
							state <= IDL;
						end if;
					end if;
				when IDL =>
					if rising_edge(clock_20hz_clk) then
						intr <= '1';
						state <= BLOQ;
					end if;
			end case;
		end if;
	
end process;
					 
END Structure;