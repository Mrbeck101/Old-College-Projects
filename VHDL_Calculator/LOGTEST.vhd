LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL."Log10";

 
 
ENTITY LOGTEST IS
END LOGTEST;
 
ARCHITECTURE behavior OF LOGTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LOG_FUNCTION
    PORT(
         A : IN  std_logic_vector(12 downto 0);
         O : OUT  std_logic_vector(29 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(29 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LOG_FUNCTION PORT MAP (
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
 

   -- Stimulus process
   stim_proc: process
   begin		
		A <= "0000000001010";
      wait for 100 ns;
		
		A <= "0000001010011";
      wait for 100 ns;
		
		A <= "0100000001100";
      wait for 100 ns;
		
		A <= "0111110000011";
      wait for 100 ns;

      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
