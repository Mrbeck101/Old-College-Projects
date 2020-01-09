--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:31:03 04/02/2017
-- Design Name:   
-- Module Name:   C:/Users/Jamar/Dynamic_Calculator/SQUARED_TEST.vhd
-- Project Name:  Dynamic_Calculator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SQUAR_FUNCTION
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
 
ENTITY SQUARED_TEST IS
END SQUARED_TEST;
 
ARCHITECTURE behavior OF SQUARED_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SQUAR_FUNCTION
    PORT(
         A : IN  std_logic_vector(12 downto 0);
         O : OUT  std_logic_vector(25 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(29 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
-- 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SQUAR_FUNCTION PORT MAP (
          A => A,
          O => O
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
		A <= "0000100001111";

      wait for 100 ns;
		
		A <= "0000000101111";

      wait for 100 ns;	
		
		A <= "0011000101111";

      wait for 100 ns;
		
		A <= "1000100101111";

      wait for 100 ns;	
		

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
