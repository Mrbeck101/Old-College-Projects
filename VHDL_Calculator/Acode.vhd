----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:04:23 04/13/2017 
-- Design Name: 
-- Module Name:    Acode - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Acode is
    Port ( Aen : in  STD_LOGIC_VECTOR (3 downto 0);
           Asel : in  STD_LOGIC_VECTOR (1 downto 0);
           A : out  STD_LOGIC_VECTOR (3 downto 0));
end Acode;

architecture Behavioral of Acode is

begin
	process(Aen, Asel)
	begin
	A <= "1111";
	case Asel is
		when "00" =>
			If Aen(0) = '1' then
				A <= "1110";
			end if;
		when "01" =>
			If Aen(1) = '1' then
				A <= "1101";
			end if;
		when "10" =>
			If Aen(2) = '1' then
				A <= "1011";
			end if;
		when others =>
			If Aen(3) = '1' then
				A <= "0111";
			end if;
		end case;
	end process;


end Behavioral;

