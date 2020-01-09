----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:10 04/13/2017 
-- Design Name: 
-- Module Name:    MULTI7segdisplay - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MULTI7segdisplay is
    Port ( B0, B1, B2, B3 : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
           anode : in  STD_LOGIC_VECTOR (3 downto 0);
           A : out  STD_LOGIC_VECTOR (3 downto 0);
			  seg : out STD_LOGIC_VECTOR (6 downto 0));
end MULTI7segdisplay;

architecture Behavioral of MULTI7segdisplay is
 
Component counter2bit 
	port (
		 clk : in std_logic;
		q : out std_logic_vector (1 downto 0));
end component counter2bit;

component BCDmux
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC_VECTOR (3 downto 0);
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR (3 downto 0);
			  sel : in std_logic_vector (1 downto 0));
end component BCDmux;

component SevSeg 
    Port ( L : out  STD_LOGIC_VECTOR (6 downto 0);
           input : in  STD_LOGIC_VECTOR (3 downto 0));
end component SevSeg;

component Acode
    Port ( Aen : in  STD_LOGIC_VECTOR (3 downto 0);
           Asel : in  STD_LOGIC_VECTOR (1 downto 0);
           A : out  STD_LOGIC_VECTOR (3 downto 0));
end component Acode;

component Clock_Divider is
Port (
        clk_in : in  STD_LOGIC;
--        reset  : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end component Clock_Divider;

signal cq : std_logic_vector (1 downto 0);
signal m1 : std_logic_vector (3 downto 0);
signal m2 : Std_logic;

begin


i0 : clock_divider port map ( clk_in => clk,  clk_out => m2); 

c0 : counter2bit port map(clk => m2,  q => cq);



a0 : Acode port map ( Aen  => anode, Asel => cq, A => A);


g0: BCDmux port map (A => B0, B => B1, C => B2, D => B3, O => m1, sel => cq);

s0 : SevSeg port map (input => m1, L => seg);



end Behavioral;

