--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:50:00 04/12/2017
-- Design Name:   
-- Module Name:   C:/Users/jbeck2/Desktop/Dynamic_Calculator/EXPONENTTEST.vhd
-- Project Name:  Dynamic_Calculator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXPONENT_FUNCTION
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
 
ENTITY EXPONENTTEST IS
END EXPONENTTEST;
 
ARCHITECTURE behavior OF EXPONENTTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXPONENT_FUNCTION
    PORT(
         A : IN  std_logic_vector(12 downto 0);
         B : IN  std_logic_vector(12 downto 0);
         O : OUT  std_logic_vector(33 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(12 downto 0) := (others => '0');
   signal B : std_logic_vector(12 downto 0) := (others => '0');
--   signal clk : std_logic := '0';

 	--Outputs
   signal O : std_logic_vector(33 downto 0);

   -- Clock period definitions
--   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXPONENT_FUNCTION PORT MAP (
          A => A,
          B => B,
          O => O
        );

   -- Clock process definitions
--   clk_process :process
--   begin
--		clk <= '0';
--		wait for clk_period/2;
--		clk <= '1';
--		wait for clk_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   A <= "0000000001111";
	B <= "0000000000011";
      wait for 100 ns;	
   A <= "0000000000111";
	B <= "0000000001011";
      wait for 100 ns;
	A <= "1011001100011";
	B <= "0000000000011";
      wait for 100 ns;

--      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
