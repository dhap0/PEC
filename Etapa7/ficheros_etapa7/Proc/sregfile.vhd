LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;        --Esta libreria sera necesaria si usais conversiones TO_INTEGER
USE ieee.std_logic_unsigned.all; --Esta libreria sera necesaria si usais conversiones CONV_INTEGER

library work;
use work.cte_tipos_UF_pkg.all;

ENTITY sregfile IS
    PORT (clk    : IN  STD_LOGIC;
          wrd    : IN  STD_LOGIC;
          int    : IN  STD_LOGIC;
          op_d   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
          d      : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          addr_a : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
          addr_d : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
          a      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END sregfile;


ARCHITECTURE Structure OF sregfile IS
    -- Aqui iria la definicion de los registros
	type bancRegistres is array (0 to 7) of std_logic_vector(15 downto 0);
	signal BR: bancRegistres;

	
BEGIN

    -- Aqui iria la definicion del comportamiento del banco de registros
    -- Os puede ser util usar la funcion "conv_integer" o "to_integer"
    -- Una buena (y limpia) implementacion no deberia ocupar m�s de 7 o 8 lineas
  a <= BR(conv_integer(addr_a));
  p_write : process(clk,wrd)
  begin
    if rising_edge(clk) then
      if int = '1' then
        BR(0)    <= BR(7);
        BR(1)    <= d; -- TODO in_d com al jal!
        BR(2)    <= x"000F";
        BR(7)(1) <= '0';
      else
        case op_d is
          when "00" =>
            if wrd = PE then
              BR(conv_integer(addr_d)) <= d;
            end if;
          when "01" => BR(7)(1) <= '1';   --EI
          when "10" => BR(7)(1) <= '0';   --DI
          when "11" => BR(7)    <= BR(0); --DI
        end case; 
      end if;
    end if;
  end process;


END Structure;