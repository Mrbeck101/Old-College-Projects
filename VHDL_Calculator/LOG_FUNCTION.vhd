library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;




entity LOG_FUNCTION is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
			  O : out  STD_LOGIC_VECTOR (15 downto 0));
end LOG_FUNCTION;

architecture Behavioral of LOG_FUNCTION is

signal AIN : integer := 0;
signal u: std_logic_vector (15 downto 0);


begin

AIN <= to_integer(unsigned(A));



process (AIN)
   variable F : integer;

   begin
	if (AIN > 0) then
      F := 0;  
      while ((10 ** F) < AIN) loop
         F := F + 1;
      end loop;
		u <= std_logic_vector(to_unsigned(F, 16));
	else 
		u <= "0000000000000000";
	end if;
end process;

O <= u;




	




end Behavioral;

