LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
USE work.cte_tipos_UF_pkg.all;

ENTITY proc IS
	PORT (
		clk:       IN  STD_LOGIC;
		boot:      IN  STD_LOGIC;
		rd_io:     IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		datard_m:  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		addr_m:    OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		data_wr:   OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		wr_m:      OUT STD_LOGIC;
		word_byte: OUT STD_LOGIC;
		addr_io   : OUT STD_LOGIC_VECTOR(7 downto 0); 
		rd_in     : OUT STD_LOGIC; 
		wr_io:     OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		wr_out     : OUT STD_LOGIC
	);
END proc;


ARCHITECTURE Structure OF proc IS

    -- Aqui iria la declaracion de las entidades que vamos a usar
    -- Usaremos la palabra reservada COMPONENT ...
    -- Tambien crearemos los cables/buses (signals) necesarios para unir las entidades
	 COMPONENT datapath IS
		PORT (clk:      IN  STD_LOGIC;
				rd_io:     IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				wr_io:     OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	END COMPONENT;
	COMPONENT unidad_control IS
		PORT (boot:      IN  STD_LOGIC;
		      clk:       IN  STD_LOGIC;
		      datard_m:  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		      pc_in:     IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		      z:         IN  STD_LOGIC;
		      op:        OUT STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
		      Rb_N:      OUT STD_LOGIC;
		      wrd:       OUT STD_LOGIC;
		      tknbr:     OUT STD_LOGIC_VECTOR(1  DOWNTO 0);
		      addr_a:    OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		      addr_b:    OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		      addr_d:    OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		      immed:     OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		      pc_out:    OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		      ins_dad:   OUT STD_LOGIC;
		      in_d:      OUT STD_LOGIC_VECTOR(1  DOWNTO 0);
		      immed_x2:  OUT STD_LOGIC;
		      wr_m:      OUT STD_LOGIC;
				addr_io: OUT STD_LOGIC_VECTOR(7 downto 0);
			   rd_in: OUT STD_LOGIC;
			   wr_out: OUT STD_LOGIC;
		      word_byte: OUT STD_LOGIC
	);
	END COMPONENT;


	signal w2w:          STD_LOGIC;
	signal insd2insd:    STD_LOGIC;
	signal ix2ix:        STD_LOGIC;
	signal ind2ind:      STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal rb2rb:        STD_LOGIC;
	signal z2z:          STD_LOGIC;
	signal o2o:          STD_LOGIC_VECTOR(tam_codigo_alu_op-1 downto 0);
	signal a2a:          STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal b2b:          STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal d2d:          STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal i2i:          STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal e0_pc_out:    STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal c0_pc_out:    STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal c0_tknbr_out: STD_LOGIC_VECTOR(1  DOWNTO 0);
	

BEGIN

    -- Aqui iria la declaracion del "mapeo" (PORT MAP) de los nombres de las entradas/salidas de los componentes
    -- En los esquemas de la documentacion a la instancia del DATAPATH le hemos llamado e0 y a la de la unidad de control le hemos llamado c0
	 c0 : unidad_control PORT MAP(boot      => boot,
	                              clk       => clk,
	                              datard_m  => datard_m,
	                              op        => o2o,
	                              Rb_N      => rb2rb,
	                              z         => z2z,
	                              wrd       => w2w,
	                              tknbr     => c0_tknbr_out,
	                              addr_a    => a2a,
	                              addr_b    => b2b,
	                              addr_d    => d2d,
	                              immed     => i2i,
	                              immed_x2  => ix2ix,
	                              pc_in     => e0_pc_out,
	                              pc_out    => c0_pc_out,
	                              ins_dad   => insd2insd,
	                              in_d      => ind2ind,
	                              wr_m      => wr_m,
											addr_io   => addr_io, 
			                        rd_in     => rd_in, 
			                        wr_out     => wr_out,
											
	                              word_byte => word_byte);
											
	 e0 : datapath PORT MAP(clk       =>  clk,
	                        op        =>  o2o,
	                        Rb_N      =>  rb2rb,
	                        z         =>  z2z,
	                        wrd       =>  w2w,
	                        addr_a    =>  a2a,
	                        addr_b    =>  b2b,
	                        addr_d    =>  d2d,
	                        immed     =>  i2i,
	                        immed_x2  =>  ix2ix,
	                        datard_m  =>  datard_m,
	                        ins_dad   =>  insd2insd,
	                        pc_in     =>  c0_pc_out,
	                        pc_out    =>  e0_pc_out,
									rd_io     => rd_io,
									wr_io      => wr_io,
	                        in_d      =>  ind2ind,
	                        tknbr     =>  c0_tknbr_out,
	                        addr_m    =>  addr_m,
	                        data_wr   =>  data_wr);
									


END Structure;