library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           c : in STD_LOGIC_VECTOR (15 downto 0);
           d : in STD_LOGIC_VECTOR (15 downto 0);
           e : in STD_LOGIC_VECTOR (15 downto 0);
           f : in STD_LOGIC_VECTOR (15 downto 0);
           g : in STD_LOGIC_VECTOR (15 downto 0);
           EN : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
    process(s, en)
        begin
           if en = '1' then
            case s is
                when "000" =>  y  <= a;
                when "001" =>  y  <= b;
                when "010" =>  y  <= c;
                when "011" =>  y  <= d;
                when "100" =>  y  <= e;
                when "101" =>  y  <= f;
                when "110" =>  y  <= g;
                when others =>
                    y <= X"0000";
             end case;
           else
                null;
           end if;
      end process;
end Behavioral; 