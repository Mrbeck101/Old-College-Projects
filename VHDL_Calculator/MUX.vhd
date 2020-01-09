
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( S, T, U, V, W, X, Y, Z : in  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
process (S, T, U, V, W, X, Y, Z, sel)
	begin
		case sel is 
			when "000" => O <= S;
			when "001" => O <= T;
			when "010" => O <= U;
			when "011" => O <= V;
			when "100" => O <= W;
			when "101" => O <= X;
			when "110" => O <= Y;
			when others => O <= Z;
		end case;
end process;

end Behavioral;
