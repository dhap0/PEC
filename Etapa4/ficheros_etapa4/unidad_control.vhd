LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

LIBRARY work;
USE work.cte_tipos_UC_pkg.all;
USE work.cte_tipos_UF_pkg.all;

ENTITY unidad_control IS
	PORT (
		boot:      IN STD_LOGIC;
		clk :      IN STD_LOGIC;
		datard_m:  IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		z:         IN STD_LOGIC;
		pc_in:     IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
		op:        OUT  STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
		Rb_N:      OUT  STD_LOGIC;
		tknbr:     OUT  STD_LOGIC_VECTOR(1  DOWNTO 0);
		wrd:       OUT  STD_LOGIC;
		addr_a:    OUT  STD_LOGIC_VECTOR(2  DOWNTO 0);
		addr_b:    OUT  STD_LOGIC_VECTOR(2  DOWNTO 0);
		addr_d:    OUT  STD_LOGIC_VECTOR(2  DOWNTO 0);
		immed:     OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		pc_out:    OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		ins_dad:   OUT  STD_LOGIC;
		in_d:      OUT  STD_LOGIC_VECTOR(1  DOWNTO 0);
		immed_x2:  OUT  STD_LOGIC;
		wr_m:      OUT  STD_LOGIC;
		word_byte: OUT  STD_LOGIC);
END unidad_control;

ARCHITECTURE Structure OF unidad_control IS

    -- Aqui iria la declaracion de las entidades que vamos a usar
    -- Usaremos la palabra reservada COMPONENT ...
    -- Tambien crearemos los cables/buses (signals) necesarios para unir las entidades
    -- Aqui iria la definicion del program counter
	 COMPONENT control_l IS
		PORT (ir        : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		      z         : IN STD_LOGIC;
		      op        : OUT STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
		      tknbr     : OUT STD_LOGIC_VECTOR(1  DOWNTO 0);
		      Rb_N      : OUT STD_LOGIC;
		      wrd       : OUT STD_LOGIC;
		      addr_a    : OUT STD_LOGIC_VECTOR(2  DOWNTO 0);
		      addr_b    : OUT STD_LOGIC_VECTOR(2  DOWNTO 0);
		      addr_d    : OUT STD_LOGIC_VECTOR(2  DOWNTO 0);
		      immed     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		      wr_m      : OUT STD_LOGIC;
		      in_d      : OUT STD_LOGIC_VECTOR(1  DOWNTO 0);
		      immed_x2  : OUT STD_LOGIC;
		      word_byte : OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT multi IS
	    PORT(clk       : IN  STD_LOGIC;
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
	END COMPONENT;
	
	signal pc_new     : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal pc_tmp     : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal ir         : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal ir_reg     : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal wrd_t      : STD_LOGIC;
	signal wr_m_t     : STD_LOGIC;
	signal w_b_t      : STD_LOGIC;
	signal ldir_o     : STD_LOGIC;
	signal deco_tknbr : std_logic_vector(1 downto 0);
	signal ldpc_o     : std_logic_vector(1 downto 0);

BEGIN

    -- Aqui iria la declaracion del "mapeo" (PORT MAP) de los nombres de las entradas/salidas de los componentes
    -- En los esquemas de la documentacion a la instancia de la logica de control le hemos llamado c0
    -- Aqui iria la definicion del comportamiento de la unidad de control y la gestion del PC
	 deco : control_l PORT MAP(ir         =>  ir_reg,
	                           op         =>  op,
	                           tknbr      =>  deco_tknbr,
	                           Rb_N       =>  Rb_N,
	                           z          =>  z,
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
	                     tknbr_in   =>  deco_tknbr,
	                     wrd_l      =>  wrd_t,
	                     wr_m_l     =>  wr_m_t,
	                     w_b        =>  w_b_t,
	                     tknbr_out  =>  tknbr,
	                     wrd        =>  wrd,
	                     wr_m       =>  wr_m,
	                     ldir       =>  ldir_o,
	                     ins_dad    =>  ins_dad,
	                     word_byte  =>  word_byte);
	


	 pc_tmp <= 	x"C000" when boot  = '1' else pc_in;
					
	 pc_new <= pc_tmp when rising_edge(clk);
	 
	 pc_out <= pc_new(15 DOWNTO 1) & '0';
	 
	 ir     <= 	x"C000"    when boot = '1'    else
				   datard_m   when ldir_o = '1'  else  
				   ir_reg;
					
	 ir_reg <=  ir when rising_edge(clk);
	 

END Structure;