--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:26:45 04/10/2017
-- Design Name:   
-- Module Name:   C:/Users/Jamar/Downloads/Dynamic_Calculator mkII/Dynamic_Calculator/Dynamic_Calculator/DIVIDERTEST.vhd
-- Project Name:  Dynamic_Calculator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DIVIDE_FUNCTION
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
 
ENTITY DIVIDERTEST IS
END DIVIDERTEST;
 
ARCHITECTURE behavior OF DIVIDERTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DIVIDE_FUNCTION
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
			R : OUT  std_logic_vector(5 downto 0);
         O : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(15 downto 0);
   signal R : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DIVIDE_FUNCTION PORT MAP (
          A => A,
          B => B,
          O => O,
          R => R
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin
	A <= "1100";
	B <= "0000";
      wait for 50 ns;
		
	A <= "1111";
	B <= "0101";
      wait for 50 ns;
		
	A <= "1011";
	B <= "0110";
      wait for 50 ns;


--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
