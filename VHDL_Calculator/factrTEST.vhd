
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY factrTEST IS
END factrTEST;
 
ARCHITECTURE behavior OF factrTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT factr
    PORT(
         O : OUT  std_logic_vector(33 downto 0);
         A : IN  std_logic_vector(12 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(33 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
-- 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: factr PORT MAP (
          O => O,
          A => A
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
      A <= "0000000000001";
      wait for 50 ns;
		
		A <= "0000000000010";
      wait for 50 ns;
		
		A <= "0000000000011";
      wait for 50 ns;
		
		A <= "0000000000100";
      wait for 50 ns;
		
		A <= "0000000000101";
      wait for 50 ns;
		
		A <= "0000000000110";
      wait for 50 ns;
		
		A <= "0000000000111";
      wait for 50 ns;

      A <= "0000000001000";
      wait for 50 ns;	

		A <= "0000000001001";
      wait for 50 ns;
			
		A <= "0000000001010";
      wait for 50 ns;	
		
		A <= "0000000001011";
      wait for 50 ns;	
		
		A <= "0000000001100";
      wait for 50 ns;	
		
--
--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
