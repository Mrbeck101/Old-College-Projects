library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tetris_rules is
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
end tetris_rules;

architecture Behavioral of tetris_rules is

Component RAM IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END component;

component RAM_CTRL is
    Port ( psh : in STD_LOGIC_VECTOR (4 downto 0);
           set : out STD_LOGIC;
           left : in STD_LOGIC;
           right : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           rin : in STD_LOGIC_VECTOR (9 downto 0);
           lflg : out STD_LOGIC;
           rflg : out STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (4 downto 0);
           rout : out STD_LOGIC_VECTOR (9 downto 0);
           wr_en : out STD_LOGIC_VECTOR (0 downto 0);
           tcode : in STD_LOGIC_VECTOR (15 downto 0));
end component;

component PSH_CNT is
    Port ( clk, clr : in STD_LOGIC;
           down : in STD_LOGIC;
           psh : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component Clock_Divider is
    port ( clk,reset: in  STD_LOGIC;
           clock_out: out STD_LOGIC);
end component;

signal rout : STD_LOGIC_VECTOR (9 downto 0);
signal addr : STD_LOGIC_VECTOR (4 downto 0);
signal rin : STD_LOGIC_VECTOR (9 downto 0);
signal wra : STD_LOGIC_VECTOR (0 downto 0);
signal pshs : STD_LOGIC_VECTOR (4 downto 0);
signal pclr : STD_LOGIC;
signal clk25 : STD_LOGIC;
signal sets : STD_LOGIC;


begin

PSH : PSH_CNT port map(clk => clk, clr => pclr, down => down, psh => pshs);
dRAM : RAM port map (clka => clk, clkb => clk, wea => wra, addra => addr, dina => rout, douta => rin, addrb => addrb , dinb => "0000000000", doutb => dout,  web => "0");
CTRL : RAM_CTRL port map ( psh => pshs, set => sets, left => left, right => right, lflg => lflg, rflg => rflg, clk => clk, clr => clr, rin => rin, rout => rout, addr => addr, wr_en => wra, tcode => tcode);
--div : Clock_Divider port map( clk => clk, reset => clr, clock_out => clk25);
pclr <= not sets;
set <= sets;


end Behavioral;
