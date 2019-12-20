


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity block_select is
    Port ( inc: in STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC;
           tcode : out STD_LOGIC_VECTOR (15 downto 0);
           stop : in STD_LOGIC
           );
end block_select;



architecture Behavioral of block_select is

component MUX is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           c : in STD_LOGIC_VECTOR (15 downto 0);
           d : in STD_LOGIC_VECTOR (15 downto 0);
           e : in STD_LOGIC_VECTOR (15 downto 0);
           f : in STD_LOGIC_VECTOR (15 downto 0);
           g : in STD_LOGIC_VECTOR (15 downto 0);
           en : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0));
end component;

component ROM1 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component ROM2 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component ROM3 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component ROM4 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component ROM5 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component ROM6 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component ROM7 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

component pc is
  port (
    clr   : in  std_logic;
    clk   : in  std_logic;
    inc   : in  std_logic;
    q     : out std_logic_vector(1 downto 0)
    );
end component;

component Prand is
    Port ( clk: in STD_LOGIC;
           rnd : out STD_LOGIC_VECTOR (2 downto 0));
end component;

Component reg is
	 generic(N:integer := 8);
	 port(
		 load : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 d : in STD_LOGIC_VECTOR(N-1 downto 0);
		 q : out STD_LOGIC_VECTOR(N-1 downto 0)
	     );
end component;

signal addr : STD_LOGIC_VECTOR (1 downto 0);
signal msel : STD_LOGIC_VECTOR (2 downto 0);
signal rclr : STD_LOGIC;
signal RO1, RO2, RO3, RO4, RO5, RO6, RO7, mout : STD_LOGIC_VECTOR (15 downto 0);
signal rcnt : STD_LOGIC_VECTOR (2 downto 0);
signal rld : STD_LOGIC;


begin

RM1 : ROM1 port map(addr => addr, M => RO1);
RM2 : ROM2 port map(addr => addr, M => RO2);
RM3 : ROM3 port map(addr => addr, M => RO3);
RM4 : ROM4 port map(addr => addr, M => RO4);
RM5 : ROM5 port map(addr => addr, M => RO5);
RM6 : ROM6 port map(addr => addr, M => RO6);
RM7 : ROM7 port map(addr => addr, M => RO7);

Prog : pc port map(clk => clk, clr => clr, inc => inc, q => addr);

rand : prand port map (clk => clk, rnd => rcnt);

rndreg: reg generic map (N => 3)
            port map (clk => clk, load => rld, d => rcnt, q => msel, clr => clr);
mreg : reg generic map (N => 16)
           port map (clk => clk, load => stop, d => mout, q => tcode, clr => rld); 

MX : MUX port map( a => RO1, b => RO2, c => RO3, d => RO4, e => RO5, f => RO6, g => RO7, s => msel, y => mout, en => clk);
 
rld <= not stop;

end Behavioral;
