----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:12:24 04/13/2017 
-- Design Name: 
-- Module Name:    BCDmux - Behavioral 
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

entity BCDmux is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC_VECTOR (3 downto 0);
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR (3 downto 0);
			  sel : in std_logic_vector (1 downto 0));
end BCDmux;

architecture Behavioral of BCDmux is

begin
process (A, B, C, D, sel)
	begin
		case sel is 
			when "00" => O <= A;
			when "01" => O <= B;
			when "10" => O <= C;
			when others => O <= D;
		end case;
end process;


end Behavioral;

