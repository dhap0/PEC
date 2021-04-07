LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY datapath IS
	PORT (
		clk : IN STD_LOGIC;
		op : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		wrd : IN STD_LOGIC;
		addr_a : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		addr_b : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		addr_d : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		immed : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		immed_x2 : IN STD_LOGIC;
		datard_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ins_dad : IN STD_LOGIC;
		pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		in_d : IN STD_LOGIC;
		addr_m : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		data_wr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)); 
END datapath;


ARCHITECTURE Structure OF datapath IS

    -- Aqui iria la declaracion de las entidades que vamos a usar
    -- Usaremos la palabra reservada COMPONENT ...
    -- Tambien crearemos los cables/buses (signals) necesarios para unir las entidades
	COMPONENT regfile IS
		PORT (clk    : IN  STD_LOGIC;
          wrd    : IN  STD_LOGIC;
          d      : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          addr_a : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			 addr_b : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          addr_d : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
          a      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			 b      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	COMPONENT alu IS
		PORT (
			x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			y : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			op : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			w : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
signal atox, wtod, immed_y, reg_d: STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN

    -- Aqui iria la declaracion del "mapeo" (PORT MAP) de los nombres de las entradas/salidas de los componentes
    -- En los esquemas de la documentacion a la instancia del banco de registros le hemos llamado reg0 y a la de la alu le hemos llamado alu0
	BR: regfile PORT MAP(clk => clk, wrd => wrd, d => reg_d , addr_a => addr_a, addr_b => addr_b, addr_d => addr_d, a => atox, b => data_wr );
	ALUop: alu PORT MAP(x => atox, y => immed_y , op => op, w => wtod );
	 
	with immed_x2 select immed_y <=
		immed(14 downto 0) & '0' when '1',
		immed when others;
		
	with in_d select reg_d <=
		datard_m when '1',
		wtod when others;
		
	with ins_dad select addr_m <=
		wtod when '1',
		pc when others;


END Structure;