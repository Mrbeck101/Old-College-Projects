

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Logic_TopFile is
 port(
        mclk : in STD_LOGIC;
        btn : in STD_LOGIC_VECTOR(4 downto 0);
        dout : out STD_LOGIC_VECTOR (9 downto 0)
 );
 end entity;
 
architecture Behavioral of Logic_TopFile is

 
component tetris_rules is
    Port ( left : in STD_LOGIC;
           right : in STD_LOGIC;
           down : in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           rflg : out STD_LOGIC;
           lflg : out STD_LOGIC;
           set : out STD_LOGIC;
           addrb : in STD_LOGIC_VECTOR (4 downto 0);
           tcode : in STD_LOGIC_VECTOR (15 downto 0);
           dout : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component block_select is
    Port ( inc: in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           tcode : out STD_LOGIC_VECTOR (15 downto 0);
           stop : in STD_LOGIC
           );
end component;
 
component addrcnt is
    Port ( clk: in STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component Clock_Divider is
    port ( clk,reset: in  STD_LOGIC;
           clock_out: out STD_LOGIC);
end component;


signal set : std_logic;
signal addrb : std_logic_vector (4 downto 0);
signal tcode : std_logic_vector (15 downto 0);
--signal douts : std_logic_vector (9 downto 0);
--signal clk25 :std_logic;
--signal vidon : std_logic;
signal stop : std_logic;

begin
stop <= set;
p1 : tetris_rules port map(left => btn(2), right => btn(0), down => btn(3), clr => btn(4),clk => mclk, rflg => open, lflg => open, set => set, addrb => addrb, tcode => tcode, dout => dout);
p2 : block_select port map(inc => btn(1), clk => mclk, tcode => tcode, stop => stop, clr => btn(4));
p3 : addrcnt port map (clk => mclk, addr => addrb);


end Behavioral;
