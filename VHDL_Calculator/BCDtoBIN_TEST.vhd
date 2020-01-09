--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:07:43 04/02/2017
-- Design Name:   
-- Module Name:   C:/Users/Jamar/Dynamic_Calculator/BCDtoBIN_TEST.vhd
-- Project Name:  Dynamic_Calculator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BCD_Converter
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
 
ENTITY BCDtoBIN_TEST IS
END BCDtoBIN_TEST;
 
ARCHITECTURE behavior OF BCDtoBIN_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BCD_Converter
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         c : IN  std_logic_vector(3 downto 0);
         d : IN  std_logic_vector(3 downto 0);
         e : IN  std_logic_vector(3 downto 0);
         f : IN  std_logic_vector(3 downto 0);
         g : IN  std_logic_vector(3 downto 0);
         bin_out : OUT  std_logic_vector(47 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal c : std_logic_vector(3 downto 0) := (others => '0');
   signal d : std_logic_vector(3 downto 0) := (others => '0');
   signal e : std_logic_vector(3 downto 0) := (others => '0');
   signal f : std_logic_vector(3 downto 0) := (others => '0');
   signal g : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal bin_out : std_logic_vector(47 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BCD_Converter PORT MAP (
          a => a,
          b => b,
          c => c,
          d => d,
          e => e,
          f => f,
          g => g,
          bin_out => bin_out
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
		a <= "1001";
		b <= "1001";
		c <= "1001";
		d <= "1001";
		e <= "1001";
		f <= "1001";
		g <= "1001";
      wait for 100 ns;
		
		a <= "0000";
		b <= "0000";
		c <= "1001";
		d <= "1001";
		e <= "0101";
		f <= "0000";
		g <= "1000";
      wait for 100 ns;
		
		a <= "0001";
		b <= "0101";
		c <= "0101";
		d <= "1000";
		e <= "1001";
		f <= "1001";
		g <= "1001";
      wait for 100 ns;
		

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
