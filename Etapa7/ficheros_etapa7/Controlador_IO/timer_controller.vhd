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

type state_type is (IDL, BLOQ);

signal state          : state_type := IDL;
signal clock_20hz_clk : std_logic;
signal clock_20hz_cnt : std_logic_vector(21 downto 0) := x"2500000";

BEGIN

	clock_20hz : clock generic map (clock_20hz_cnt'length)
					 port map (CLOCK_50 => CLOCK_50, contador => clock_20hz_cnt, clk => clock_20hz_clk);

	int_handdler : process (CLOCK_50, clock_20hz_clk, boot)
	begin
		if boot = '1' then
			intr <= '0';
		else
			if rising_edge(CLOCK_50) then	
				if state = BLOQ then
					if inta = '1' then
						intr  <= '0';
						state <= IDL;
					end if;
				end if;
			end if;
			if rising_edge(clock_20hz_clk) then
				intr  <= '1';
				state <= BLOQ;
			end if;
		end if;
	end process;
						 
END Structure;