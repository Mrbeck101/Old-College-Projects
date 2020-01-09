----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:36:07 04/13/2017 
-- Design Name: 
-- Module Name:    counter2bit - Behavioral 
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
use IEEE.STD_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter2bit is
	port (
		 clk : in std_logic;
		q : out std_logic_vector (1 downto 0));
end counter2bit;

architecture Behavioral of counter2bit is

begin
process (clk)
variable  COUNT: STD_LOGIC_VECTOR (1 downto 0);
begin
--	if clr = '1' then
--		q <= "00";
	if clk'event and (clk = '1') then
		COUNT := COUNT + 1;
		q <= COUNT;
	end if;
end process;


end Behavioral;

