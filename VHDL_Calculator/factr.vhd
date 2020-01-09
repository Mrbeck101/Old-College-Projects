
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity factr is
	port(O : out std_logic_vector (15 downto 0);
		  A : in std_logic_vector (3 downto 0));
	end factr;
	
architecture behavioral of factr is

signal N, Z : integer :=0;
signal u : std_logic_vector (15 downto 0);
shared variable Y, i : natural;
begin

N <= to_integer(unsigned(A));


	process (N)
		
		begin
		If (-1 < N) and (N < 8) then
				Y := 1; 
				i := 0;
			while (i < 7) loop
				i := i + 1;
				if (i < (N + 1)) then
					Y := Y * i;
				elsif (i = (N + 1)) then 
					exit;
				end if;
			end loop;
			
			Z <= Y;
			u <= std_logic_vector(to_unsigned(Z, u'length));
		else  
			u <= "0000000000000000";
		end if;
	end process;
			


O <= u;
	

end behavioral; 







