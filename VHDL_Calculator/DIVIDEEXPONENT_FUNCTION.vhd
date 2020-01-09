
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL."FLOOR";
use IEEE.MATH_REAL."abs";


entity DIVIDEEXPONENT_FUNCTION is
    Port ( A : in  STD_LOGIC_VECTOR (25 downto 0);
           B : in  STD_LOGIC_VECTOR (25 downto 0);
           Oint : out  STD_LOGIC_VECTOR (25 downto 0);
			  Odec : out  STD_LOGIC_VECTOR (9 downto 0));
end DIVIDEEXPONENT_FUNCTION;

architecture Behavioral of DIVIDEEXPONENT_FUNCTION is

signal AIN, BIN, FIN, FIN2 : integer := 1;
signal FR, FR2, FR3 : real :=0.0000;
signal u0 : std_logic_vector (25 downto 0);
signal u1 : std_logic_vector (9 downto 0);



begin

	AIN <= to_integer(signed(A));
	BIN <= to_integer(signed(B));
	
process (AIN, BIN, u1, u0, FIN, FR, FR3, FIN2)
begin



	if (BIN /= 0) then
		FR <= real((real(AIN)) / (real(BIN)));
		FR3 <= real (AIN /BIN);
		FIN <= integer(FR3);
			if (FIN > 0) then
				FIN2 <= integer((FR - (FLOOR(FR))) * 1000.0000);
			elsif (FIN < 0) then
				FIN2 <= 999 - (integer((FR - (FLOOR(FR))) * 1000.0000));
			end if;

		u0 <= std_logic_vector(to_signed(FIN, 26));
		u1 <= std_logic_vector(to_signed(FIN2, 10));
		
		Oint <= u0;
		Odec <= u1;
		
	elsif (BIN = 0) then
		Oint <= "0000000000000000000000000";
		Odec <= "0000000000";
	end if;
end process;
 
end Behavioral;