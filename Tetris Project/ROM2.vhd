library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity ROM2 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end ROM2;

architecture ROM2_arch of ROM2 is


type rom_array is array (NATURAL range <>)  of STD_LOGIC_VECTOR (15 downto 0);
constant rom: rom_array := (X"008E", X"0644", X"0071", X"0226");


begin

 process(addr)
 variable j: integer;
 begin 
      j := conv_integer(addr);
      M <= rom(j);
  end process;
  

end ROM2_arch;