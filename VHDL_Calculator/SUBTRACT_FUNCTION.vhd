library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity SUBTRACT_FUNCTION is
	 Generic(N : integer := 4);
    Port ( X, Y : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           s : out  STD_LOGIC_VECTOR (15 downto 0));
end SUBTRACT_FUNCTION;

architecture Behavioral of SUBTRACT_FUNCTION is

signal AIN, BIN, FIN : integer :=0;
signal u : std_logic_vector (15 downto 0);

begin



AIN <= to_integer(unsigned(X));
BIN <= to_integer(unsigned(Y));

FIN <= abs(AIN - BIN);

u <= std_logic_vector(to_unsigned(FIN, u'length));
S <= u;


end Behavioral;

