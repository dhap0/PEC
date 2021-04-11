library ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;
USE work.cte_tipos_UC_pkg.all;

entity multi is
    port(clk       : IN  STD_LOGIC;
         boot      : IN  STD_LOGIC;
         tknbr_in  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
         wrd_l     : IN  STD_LOGIC;
         wr_m_l    : IN  STD_LOGIC;
         w_b       : IN  STD_LOGIC;
         tknbr_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
         wrd       : OUT STD_LOGIC;
         wr_m      : OUT STD_LOGIC;
         ldir      : OUT STD_LOGIC;
         ins_dad   : OUT STD_LOGIC;
         word_byte : OUT STD_LOGIC);
end entity;

architecture Structure of multi is

    -- Aqui iria la declaracion de las los estados de la maquina de estados
	 	-- Build an enumerated type for the state machine
	type state_type is (F, DEMW);

	-- Register to hold the current state
	signal state   : state_type;

begin

    -- Aqui iria la m�quina de estados del modelos de Moore que gestiona el multiciclo
    -- Aqui irian la generacion de las senales de control que su valor depende del ciclo en que se esta.
	 
	 	-- Logic to advance to the next state
	next_state: process (clk, boot)
	begin
		if boot = '1' then
			state <= F;
		elsif (rising_edge(clk)) then
			case state is
				when F=>				
					state <= DEMW;
				when DEMW=>
					state <= F;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	outputs: process (state, tknbr_in, wrd_l, wr_m_l, w_b)
	begin
		case state is
			when F =>
				tknbr_out <= PC_BLOQ;
				wrd       <= '0';
				wr_m      <= '0';
				word_byte <= '0';
				ins_dad   <= '0';
				ldir      <= '1';
			when DEMW =>
				tknbr_out <= tknbr_in;
				wrd       <= wrd_l;
				wr_m      <= wr_m_l;
				word_byte <= w_b;
				ins_dad   <= '1';
				ldir      <= '0';
			
		end case;
	end process;
	

end Structure;


