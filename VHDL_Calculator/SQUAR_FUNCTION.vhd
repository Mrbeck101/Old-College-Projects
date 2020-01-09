
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity SQUAR_FUNCTION is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end SQUAR_FUNCTION;

architecture Behavioral of SQUAR_FUNCTION is

signal AIN, FIN : integer :=0;
signal u : std_logic_vector (15 downto 0);


begin

AIN <= to_integer(unsigned(A));
FIN <= (AIN * AIN);

u <= std_logic_vector(to_unsigned(FIN, u'length));
O <= u;

end Behavioral;

