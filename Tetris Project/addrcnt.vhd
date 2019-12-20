library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity addrcnt is
    Port ( clk: in STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (4 downto 0));
end addrcnt;

architecture Behavioral of addrcnt is

signal count : STD_LOGIC_VECTOR (4 downto 0) := "00000";
signal tmp : integer := 0;

begin
    process(count, clk)
        begin
          if rising_edge(clk) then
            if tmp < 3 then
                tmp <= tmp + 1;
            elsif  count /= "10011"  and tmp = 3 then
                count <= count + 1;
                tmp <= 0;
            elsif count = "10011"  and tmp = 3 then
                count <= "00000";
                tmp <= 0;
            end if;
          end if;
    end process;
    
    addr <= count;
end Behavioral;