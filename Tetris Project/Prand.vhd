
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Prand is
    Port ( clk: in STD_LOGIC;
           rnd : out STD_LOGIC_VECTOR (2 downto 0));
end Prand;

architecture Behavioral of Prand is

signal count : STD_LOGIC_VECTOR (2 downto 0) := "000";


begin
    process(count, clk)
        begin
          if rising_edge(clk) then
            if  count /= "110" then
                count <= count + 1;
            elsif count = "110" then
                count <= "000";
            end if;
          end if;
    end process;
    
    rnd <= count;
end Behavioral;
