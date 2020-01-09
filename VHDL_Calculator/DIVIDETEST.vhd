--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:33:59 04/08/2017
-- Design Name:   
-- Module Name:   C:/Users/jbeck2/Desktop/Dynamic_Calculator/Dynamic_Calculator/DIVIDETEST.vhd
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
 
ENTITY DIVIDETEST IS
END DIVIDETEST;
 
ARCHITECTURE behavior OF DIVIDETEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DIVIDE_FUNCTION
    PORT(
         A : IN  std_logic_vector(12 downto 0);
         B : IN  std_logic_vector(12 downto 0);
         Oint : OUT  std_logic_vector(24 downto 0);
         Odec : OUT  std_logic_vector(24 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(12 downto 0) := (others => '0');
   signal B : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal Oint : std_logic_vector(24 downto 0);
   signal Odec : std_logic_vector(24 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
-- 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DIVIDE_FUNCTION PORT MAP (
          A => A,
          B => B,
          Oint => Oint,
          Odec => Odec
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
	A <= "0000000000011";
	B <= "0000000000000";
      wait for 50 ns;

	A <= "0000000001111";
	B <= "0000000000100";
      wait for 50 ns;

	A <= "0000010000000";
	B <= "0000000100110";
      wait for 50 ns;

	A <= "1000100011010";
	B <= "0000000011100";
      wait for 50 ns;

	A <= "1000000010100";
	B <= "1011100000000";
      wait for 50 ns;		

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
