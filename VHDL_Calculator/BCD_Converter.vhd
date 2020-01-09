
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BCD_Converter is
    Port ( a, b, c, d, e, f, g : in  STD_LOGIC_VECTOR (3 downto 0);
           bin_out : out  STD_LOGIC_VECTOR (47 downto 0));
end BCD_Converter;




architecture Behavioral of BCD_Converter is

component MULTI_FUNCTION 
	 Generic(N : integer := 24);
    Port ( A, B : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           P : out  STD_LOGIC_VECTOR (47 downto 0));
end component MULTI_FUNCTION;

component ADD_FUNCTION
	 Generic(N : integer := 48);
    Port ( X, Y : in  STD_LOGIC_VECTOR ((N-1) downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR ((N-1) downto 0));
end component ADD_FUNCTION;

signal p0, p1, p2, p3, p4, p5, p6 : std_logic_vector (47 downto 0);
signal u0, u1, u2, u3, u4 : std_logic_vector (47 downto 0); 



signal q0, q1, q2, q3, q4, q5, q6 : std_logic_vector (23 downto 0);


begin
--CONVERT 4bit to 24bit
q0 <= "00000000000000000000" & a;
q1 <= "00000000000000000000" & b;
q2 <= "00000000000000000000" & c;
q3 <= "00000000000000000000" & d;
q4 <= "00000000000000000000" & e;
q5 <= "00000000000000000000" & f;
q6 <= "00000000000000000000" & g;

--MULTIPLY
a0 : MULTI_FUNCTION  port map (A => q0, B => "000000000000000000000001", P => p0); --1
b0 : MULTI_FUNCTION  port map (A => q1, B => "000000000000000000001010", P => p1); --10
c0 : MULTI_FUNCTION  port map (A => q2, B => "000000000000000001100100", P => p2); --100
d0 : MULTI_FUNCTION  port map (A => q3, B => "000000000000001111101000", P => p3); --1000
e0 : MULTI_FUNCTION  port map (A => q4, B => "000000000010011100010000", P => p4); --10000
f0 : MULTI_FUNCTION  port map (A => q5, B => "000000011000011010100000", P => p5); --100000
g0 : MULTI_FUNCTION  port map (A => q6, B => "000011110100001001000000", P => p6); --1000000

--ADDITION
v0 : ADD_FUNCTION port map (X => p0, Y => p1, cin => '0', S => u0);
v1 : ADD_FUNCTION port map (X => u0, Y => p2, cin => '0', S => u1);
v2 : ADD_FUNCTION port map (X => u1, Y => p3, cin => '0', S => u2);
v3 : ADD_FUNCTION port map (X => u2, Y => p4, cin => '0', S => u3);
v4 : ADD_FUNCTION port map (X => u3, Y => p5, cin => '0', S => u4);
v5 : ADD_FUNCTION port map (X => u4, Y => p6, cin => '0', S => bin_out);

end Behavioral;

