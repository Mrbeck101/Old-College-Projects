--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:21:10 04/12/2017
-- Design Name:   
-- Module Name:   C:/Users/Jamar/Desktop/Dynamic_Calculator/BINtoBCDTEST.vhd
-- Project Name:  Dynamic_Calculator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BintoBCD
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
 
ENTITY BINtoBCDTEST IS
END BINtoBCDTEST;
 
ARCHITECTURE behavior OF BINtoBCDTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BintoBCD
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         binary_in : IN  std_logic_vector(15 downto 0);
         bcd0 : OUT  std_logic_vector(3 downto 0);
         bcd1 : OUT  std_logic_vector(3 downto 0);
         bcd2 : OUT  std_logic_vector(3 downto 0);
         bcd3 : OUT  std_logic_vector(3 downto 0);
         bcd4 : OUT  std_logic_vector(3 downto 0)

        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal binary_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal bcd0 : std_logic_vector(3 downto 0);
   signal bcd1 : std_logic_vector(3 downto 0);
   signal bcd2 : std_logic_vector(3 downto 0);
   signal bcd3 : std_logic_vector(3 downto 0);
   signal bcd4 : std_logic_vector(3 downto 0);


   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BintoBCD PORT MAP (
          clk => clk,
          reset => reset,
          binary_in => binary_in,
          bcd0 => bcd0,
          bcd1 => bcd1,
          bcd2 => bcd2,
          bcd3 => bcd3,
          bcd4 => bcd4
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
	   binary_in <= "0000000011100001";
		reset <= '1';
    wait for 100 ns;	
	   binary_in <= "0000000011100001";
		reset <= '0';
    wait for 100 ns;
	 
	 	binary_in <= "0000100011100001";
		reset <= '0';
    wait for 100 ns;
	

      -- insert stimulus here 

      wait;
   end process;

END;
