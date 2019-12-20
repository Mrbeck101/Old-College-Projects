library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity Clock_Divider is
    port ( clk,reset: in  STD_LOGIC;
           clock_out: out STD_LOGIC);
end Clock_Divider;
  
architecture Behavioral of Clock_Divider is
  
signal count: integer := 1;
signal tmp : std_logic := '0';
  
    begin
        process(clk,reset, tmp)
            begin
                if(reset='1') then
                    count <= 1;
                    tmp <= '0';
                elsif(clk'event and clk='1') then
                    count <= count + 1;
                    if (count = 2) then
                        tmp <= NOT tmp;
                        count <= 1;
                    end if;
                end if;
                clock_out <= tmp;
        end process;
end Behavioral;