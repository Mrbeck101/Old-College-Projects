library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity MULTI_FUNCTION is
	 Generic(N : integer := 4);
    Port ( A, B : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           P : out  STD_LOGIC_VECTOR (15 downto 0));
end MULTI_FUNCTION;

architecture Behavioral of MULTI_FUNCTION is



signal AIN, BIN, FIN : integer :=0;
signal u : std_logic_vector (15 downto 0);


begin

AIN <= to_integer(unsigned(A));
BIN <= to_integer(unsigned(B));

FIN <= (AIN * BIN);

u <= std_logic_vector(to_unsigned(FIN, u'length));
P <= u;

end behavioral; 


