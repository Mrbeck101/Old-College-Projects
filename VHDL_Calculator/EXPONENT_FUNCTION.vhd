library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity EXPONENT_FUNCTION is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end EXPONENT_FUNCTION;

architecture Behavioral of EXPONENT_FUNCTION is


signal AIN, BIN, F : integer := 0;
signal u : std_logic_vector (15 downto 0);



begin
		AIN <= to_integer(unsigned(A));
		BIN <= to_integer(unsigned(B));

process (AIN, BIN, F) 
variable N, i : natural;
	begin
		If (BIN > 0) then		
		N := AIN;
		i := 0;
			while (i < 15) loop
				i := i + 1;
			if (i < BIN) then
				N := N * AIN;
			elsif (i = BIN) then
				exit;
			end if;
			end loop;
			F <= N;
			u <= std_logic_vector(to_unsigned(F, u'length));
		elsif (BIN < 0) then   
			u <= "0000000000000000";
		end if;
end process;
O <= u;

end Behavioral;

