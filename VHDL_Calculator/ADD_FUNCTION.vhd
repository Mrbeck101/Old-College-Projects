library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity ADD_FUNCTION is
	 Generic(N : integer := 4);
    Port ( X, Y : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           s : out  STD_LOGIC_VECTOR (15 downto 0));
end ADD_FUNCTION;

architecture Behavioral of ADD_FUNCTION is

signal AIN, BIN, FIN : integer :=0;
signal u : std_logic_vector (15 downto 0);

begin



AIN <= to_integer(unsigned(X));
BIN <= to_integer(unsigned(Y));

FIN <= (AIN + BIN);

u <= std_logic_vector(to_unsigned(FIN, u'length));
S <= u;


end Behavioral;

