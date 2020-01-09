
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity DIVIDE_FUNCTION is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
			  R : out std_logic_vector (5 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end DIVIDE_FUNCTION;

architecture Behavioral of DIVIDE_FUNCTION is

signal AIN, BIN, FIN, RIN : natural := 0;
signal u0 : std_logic_vector (15 downto 0);
signal u1 : std_logic_vector (5 downto 0);



begin

	AIN <= to_integer(unsigned(A));
	BIN <= to_integer(unsigned(B));
	
process (AIN, BIN, u1, u0, FIN)
begin
	if (BIN > 0) then
		FIN <= natural(AIN / BIN);
		RIN <= (AIN mod BIN);
		u0 <= std_logic_vector(to_unsigned(FIN, u0'length));
		u1 <= std_logic_vector(to_unsigned(RIN, u1'length));
		O <= u0;
		R <= u1;
		
	elsif (BIN = 0) then
		O <= "0000000000000000";
		r <= "000000";
	end if;
end process;
 



end Behavioral;

