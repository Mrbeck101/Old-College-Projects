
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity PSH_CNT is
    Port ( clk, clr : in STD_LOGIC;
           down : in STD_LOGIC;
           psh : out STD_LOGIC_VECTOR (4 downto 0));
end PSH_CNT;

architecture Behavioral of PSH_CNT is

signal count : integer := 0;
signal pshcnt : STD_LOGIC_VECTOR (4 downto 0) := "00000";


begin
    process(count, clk, clr, down)
        begin
          if clr = '1' then --clr will be assigned to the set signal in RAM CTRL and the cnt will be Reset after pshcnt exceeds 16
            count <= 0;
            pshcnt <= "00000"; 
          elsif rising_edge(clk) and clr = '0' then
            if  count <= 30 and down = '0'  then --counting  (100000000 = 2 secs) (
                count <= count + 1;
            elsif count <= 30 and down = '1'  then --speeds up counting if down button is pressed
                count <= count + 2; --10;
            elsif count >= 30 then --once 2 seconds has passed or the button has been pressed long enough
                count <= 0;
                pshcnt <= pshcnt + "00001"; --psh the datastack by 1
            end if;
          end if;
    end process;
    psh <= pshcnt;
end Behavioral;