----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:16:29 03/23/2017 
-- Design Name: 
-- Module Name:    PU_MULTI - Behavioral 
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

entity PU_MULTI is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
			  c : in STD_logic;
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
			  O : out STD_LOGIC);
end PU_MULTI;

architecture Behavioral of PU_MULTI is

component FullAdd 
    Port ( A, B, cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sum : out  STD_LOGIC);
end component FullAdd;

signal u : std_logic;

begin
u <= (a and b);


p0 : FullAdd port map ( A => c, B => u, cin => cin, sum => O, cout => cout);


end Behavioral;

