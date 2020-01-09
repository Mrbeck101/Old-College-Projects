
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY EXPONENT_TEST IS
END EXPONENT_TEST;
 
ARCHITECTURE behavior OF EXPONENT_TEST IS 
 

 
    COMPONENT EXPONENT_FUNCTION
    PORT(
         A : IN  std_logic_vector(12 downto 0);
         B : IN  std_logic_vector(12 downto 0);
         O : OUT  std_logic_vector(33 downto 0)
        );
    END COMPONENT;
    


   signal A : std_logic_vector(12 downto 0) := (others => '0');
   signal B : std_logic_vector(12 downto 0) := (others => '0');


   signal O : std_logic_vector(33 downto 0);

BEGIN

   uut: EXPONENT_FUNCTION PORT MAP (
          A => A,
          B => B,
          O => O
        );


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

      wait;
   end process;

END;
