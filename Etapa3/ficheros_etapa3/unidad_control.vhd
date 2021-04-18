LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

LIBRARY work;
USE work.cte_tipos_UC_pkg.all;
USE work.cte_tipos_UF_pkg.all;

ENTITY unidad_control IS
	PORT (
		boot : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		pc_in     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		datard_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		op : OUT  STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
		Rb_N : OUT STD_LOGIC;
		wrd : OUT STD_LOGIC;
		addr_a : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		addr_b : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		addr_d : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		immed : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		pc_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		ins_dad : OUT STD_LOGIC;
		in_d : OUT STD_LOGIC;
		immed_x2 : OUT STD_LOGIC;
		wr_m : OUT STD_LOGIC;
		word_byte : OUT STD_LOGIC;
		ldpc_o : OUT STD_LOGIC);
END unidad_control;

ARCHITECTURE Structure OF unidad_control IS

    -- Aqui iria la declaracion de las entidades que vamos a usar
    -- Usaremos la palabra reservada COMPONENT ...
    -- Tambien crearemos los cables/buses (signals) necesarios para unir las entidades
    -- Aqui iria la definicion del program counter
	 COMPONENT control_l IS
		PORT (ir        : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				op        : OUT  STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
				Rb_N      : OUT STD_LOGIC;
				ldpc      : OUT STD_LOGIC;
				wrd       : OUT STD_LOGIC;
				addr_a    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
				addr_b    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
				addr_d    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
				immed     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				wr_m      : OUT STD_LOGIC;
				in_d      : OUT STD_LOGIC;
				immed_x2  : OUT STD_LOGIC;
				word_byte : OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT multi IS
	    PORT(clk       : IN  STD_LOGIC;
				boot      : IN  STD_LOGIC;
				ldpc_l    : IN  STD_LOGIC;
				wrd_l     : IN  STD_LOGIC;
				wr_m_l    : IN  STD_LOGIC;
				w_b       : IN  STD_LOGIC;
				ldpc      : OUT STD_LOGIC;
				wrd       : OUT STD_LOGIC;
				wr_m      : OUT STD_LOGIC;
				ldir      : OUT STD_LOGIC;
				ins_dad   : OUT STD_LOGIC;
				word_byte : OUT STD_LOGIC);
	END COMPONENT;
	
	signal pc_new, pc_tmp, ir, ir_reg : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal ldpc_t: STD_LOGIC;
	signal m0_ldpc_o: STD_LOGIC;
	signal wrd_t: STD_LOGIC;
	signal wr_m_t: STD_LOGIC;
	signal w_b_t: STD_LOGIC;
	signal ldir_o: STD_LOGIC;

BEGIN

    -- Aqui iria la declaracion del "mapeo" (PORT MAP) de los nombres de las entradas/salidas de los componentes
    -- En los esquemas de la documentacion a la instancia de la logica de control le hemos llamado c0
    -- Aqui iria la definicion del comportamiento de la unidad de control y la gestion del PC
	 deco : control_l PORT MAP(ir         =>  ir_reg,
	                           op         =>  op,
	                           Rb_N       =>  Rb_N,
								           		ldpc       =>  ldpc_t,
										       		wrd        =>  wrd_t,
										       		addr_a     =>  addr_a,
										       		addr_b     =>  addr_b,
       				        		       	addr_d     =>  addr_d,
										immed      =>  immed,
										wr_m       =>  wr_m_t,
										in_d       =>  in_d,
										immed_x2   =>  immed_x2,
										word_byte  =>  w_b_t);
										
	 m0 : multi PORT MAP(clk        =>  clk,
	                     boot       =>  boot,
								ldpc_l     =>  ldpc_t,
								wrd_l      =>  wrd_t,
								wr_m_l     =>  wr_m_t,
								w_b        =>  w_b_t,
								ldpc       =>  ldpc_o,
								wrd        =>  wrd,
								wr_m       =>  wr_m,
								ldir       =>  ldir_o,
								ins_dad    =>  ins_dad,
								word_byte  =>  word_byte);
								
--	 tmp_pc <= 	x"C000" when boot = '1' else
--					new_pc + 2 when ldpc_o = '1' else
--					x"C000";
--	 new_pc <= tmp_pc when rising_edge(clk);
--	 pc <= new_pc(15 DOWNTO 1) & '0';

	 pc_tmp <= 	x"C000" when boot  = '1' else pc_in;
					
	 pc_new <= pc_tmp when rising_edge(clk);
	 
	 pc_out <= pc_new(15 DOWNTO 1) & '0';
	 
	 --ldpc_o <= m0_ldpc_o;
	 --ldpc_o <= ldpc_t;

	 ir <= 	x"C000" when boot = '1' else
					datard_m when ldir_o = '1' else
					ir_reg;
	 ir_reg <= ir when rising_edge(clk);

END Structure;