--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:09:25 03/26/2017
-- Design Name:   
-- Module Name:   C:/Users/Jamar/Dynamic_Calculator/ADD_TEST.vhd
-- Project Name:  Dynamic_Calculator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ADD_FUNCTION
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
 
ENTITY ADD_TEST IS
END ADD_TEST;
 
ARCHITECTURE behavior OF ADD_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADD_FUNCTION
    PORT(
         X : IN  std_logic_vector(23 downto 0);
         Y : IN  std_logic_vector(23 downto 0);
         cin : IN  std_logic;
         cout : OUT  std_logic;
         s : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(23 downto 0) := (others => '0');
   signal Y : std_logic_vector(23 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal cout : std_logic;
   signal s : std_logic_vector(23 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADD_FUNCTION PORT MAP (
          X => X,
          Y => Y,
          cin => cin,
          cout => cout,
          s => s
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
		X<= "1001000110101010001110";
		Y<= "11111111101001010101110";
		
   wait for 100 ns;	
--
--      wait for <clock>_period*10;
--
--      -- insert stimulus here 

      wait;
   end process;

END;
