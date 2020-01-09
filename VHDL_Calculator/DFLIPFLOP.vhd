library ieee;
use ieee.std_logic_1164.all;

entity DFLIPFLOP is
	port ( D, resetn,  clk: in std_logic;
			q : out std_logic);
end DFLIPFLOP;
	
architecture Behavioral of DFLIPFLOP is

 signal qt: std_logic;

begin

process (D, resetn, clk )
 begin
	if rising_edge(clk) then
		if (resetn = '0')  then
			qt <= d;
		elsif (resetn = '1') then
			qt <= '0';
		end if;
	end if;
end process;

q <= qt; 

end behavioral; 