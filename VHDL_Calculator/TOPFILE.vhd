
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;




entity TOPFILE is
	port(
		j, k : in  STD_LOGIC_VECTOR (3 downto 0);
		clock, clr: in std_logic;
		An, An2 : out STD_logic_vector (3 downto 0);
      s: in  STD_LOGIC_VECTOR (2 downto 0);
		v : out STD_LOGIC_VECTOR (6 downto 0);
		R : out std_logic_vector (5 downto 0));
end TOPFILE;

    architecture Behavioral of TOPFILE is

component ADD_FUNCTION
	 Generic(N : integer := 4);
    Port ( X, Y : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           s : out  STD_LOGIC_VECTOR (15 downto 0));
end component ADD_FUNCTION;

component SUBTRACT_FUNCTION
	 Generic(N : integer := 4);
    Port ( X, Y : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           s : out  STD_LOGIC_VECTOR (15 downto 0));
end component SUBTRACT_FUNCTION;

component MULTI_FUNCTION
	 Generic(N : integer := 4);
    Port ( A, B : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           P : out  STD_LOGIC_VECTOR (15 downto 0));
end component MULTI_FUNCTION;

component DIVIDE_FUNCTION
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
			  R : out STD_LOGIC_VECTOR (5 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end component DIVIDE_FUNCTION;

component EXPONENT_FUNCTION 
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end component EXPONENT_FUNCTION;

component SQUAR_FUNCTION
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end component SQUAR_FUNCTION;

component LOG_FUNCTION is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end component LOG_FUNCTION;

component factr 
	port(O : out std_logic_vector (15 downto 0);
		  A : in std_logic_vector (3 downto 0));
end component factr;

component  MUX 
    Port ( S, T, U, V, W, X, Y, Z : in  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end component MUX;

component MULTI7segdisplay is
    Port ( B0, B1, B2, B3 : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
           anode : in  STD_LOGIC_VECTOR (3 downto 0);
           A : out  STD_LOGIC_VECTOR (3 downto 0);
			  seg : out STD_LOGIC_VECTOR (6 downto 0));
end component MULTI7segdisplay;

component BintoBCD 
    generic(N: positive := 16);
    port(
        clk, reset: in std_logic;
        binary_in: in std_logic_vector(N-1 downto 0);
        bcd0, bcd1, bcd2, bcd3, bcd4  : out std_logic_vector(3 downto 0)
    );
end component BintoBCD ;





--signal for FUNCTIONS
signal u0, u1, u2, u3, u4, u5, u6 ,u7 : std_logic_vector (15 downto 0);
signal d0 : std_logic_vector (5 downto 0);





--signal for BintoBCD
signal mO : std_logic_vector (15 downto 0);
signal b1, b2, b3, b4, b5 : std_logic_vector (3 downto 0);



begin

--Function Port Maps
r0 : ADD_FUNCTION port map (X => j, Y => k, s => u0);
r1 : SUBTRACT_FUNCTION port map (X => j, Y => k, s => u1);
r2 : MULTI_FUNCTION port map (A => j, B => k, P => u2);
r3 : DIVIDE_FUNCTION port map (A => j, B => k, O => u3, R => d0);
r4 : EXPONENT_FUNCTION port map (A => j, B => k, O => u4);
r5 : SQUAR_FUNCTION port map (A => j, O => u5);
r6 : LOG_FUNCTION port map (A => j, O => u6);
r7 : factr port map (A=> j, O => u7);

--MUX port map
M0 : MUX port map (S => u0, T => u1, U => u2, V => u3, W => u4, X => u5, Y => u6, Z => u7, sel => s, O => mO );

process (d0, s)
begin
	if (s <= "011") then 
		R <= d0;
	else
		R <= "000000";
	end if;
end process;

An2 <= "1111";

--BintoBCD port map
h0 : BintoBCD port map (clk => clock, reset => clr,  binary_in => mO, bcd0 => b1, bcd1 => b2, bcd2 => b3, bcd3 => b4, bcd4 => b5); 

--Sevenseg port map
l0 : MULTI7segdisplay port map (B0 => b1, B1 => b2, B2 => b3, B3 => b4, clk => clock, anode => "1111" , A => An, seg => v);








end Behavioral;
