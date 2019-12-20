library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_tetris_rules is
--  Port ( );
end tb_tetris_rules;

architecture Behavioral of tb_tetris_rules is

component tetris_rules is
    Port ( left : in STD_LOGIC;
           right : in STD_LOGIC;
           down : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           tcode : in STD_LOGIC_VECTOR (15 downto 0);
           dout : out STD_LOGIC_VECTOR (9 downto 0));
end component;



signal left : STD_LOGIC := '0';
signal right : STD_LOGIC := '0';
signal down : STD_LOGIC := '0';
signal clr : STD_LOGIC;
signal clk : STD_LOGIC := '0';
signal tcode : STD_LOGIC_VECTOR (15 downto 0) := X"0000";
signal dout : STD_LOGIC_VECTOR (9 downto 0);

begin
    clk <= not clk after 5ns;
    utt : tetris_rules port map( left => left, right => right, down => down, clr => clr, clk => clk, tcode => tcode, dout => dout);
    
    stim_proc : process
        begin
            clr <= '1';
            tcode <= X"0000";
            wait for 30 ns;
            
            clr <= '0';
            wait for 10 ns;
            
            tcode <= X"008E";
            wait for 40 ns;
            
            left <= '1'; 
            wait for 1400 ns;
            
            left <= '0';
            wait for 2 ms;
         end process;

end Behavioral;

        