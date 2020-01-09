--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:58:03 04/14/2017
-- Design Name:   
-- Module Name:   C:/Users/jbeck2/Downloads/DONE SORTA (2)/DONE SORTA/Dynamic_Calculator/topfiletest.vhd
-- Project Name:  Dynamic_Calculator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOPFILE
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY topfiletest IS
END topfiletest;
 
ARCHITECTURE behavior OF topfiletest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOPFILE
    PORT(
         j : IN  std_logic_vector(3 downto 0);
         k : IN  std_logic_vector(3 downto 0);
         clock : IN  std_logic;
         clr : IN  std_logic;
         An : OUT  std_logic_vector(3 downto 0);
         s : IN  std_logic_vector(2 downto 0);
			R : OUT std_logic_vector (5 downto 0);
         v : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal j : std_logic_vector(3 downto 0) := (others => '0');
   signal k : std_logic_vector(3 downto 0) := (others => '0');
   signal clock : std_logic := '0';
   signal clr : std_logic := '0';
   signal s : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal An : std_logic_vector(3 downto 0);
	signal R : std_logic_vector (5 downto 0);
   signal v : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOPFILE PORT MAP (
          j => j,
          k => k,
          clock => clock,
          clr => clr,
          An => An,
			 R => R,
          s => s,
          v => v
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	j <= "1011"; 
	k <= "0100";
	clr <= '0';
	s <= "011";
      wait for clock_period*10;
		
	j <= "0011"; 
	k <= "0100";
	clr <= '0';
	s <= "011";
      wait for clock_period*10;	
		
		
	j <= "1011"; 
	k <= "0100";
	clr <= '0';
	s <= "011";
      wait for clock_period*10;
		
	j <= "0111"; 
	k <= "0100";
	clr <= '0';
	s <= "011";
      wait for clock_period*10;

	j <= "0011"; 
	k <= "0110";
	clr <= '0';
	s <= "011";
      wait for clock_period*10;


	j <= "1111"; 
	k <= "0100";
	clr <= '0';
	s <= "011";
      wait for clock_period*10;

	j <= "0011"; 
	k <= "0101";
	clr <= '0';
	s <= "011";
      wait for clock_period*10;		

      

      -- insert stimulus here 

      wait;
   end process;

END;
