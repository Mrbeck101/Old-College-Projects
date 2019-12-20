library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity ROM1 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end ROM1;

architecture ROM1_arch of ROM1 is


type rom_array is array (NATURAL range <>)  of STD_LOGIC_VECTOR (15 downto 0);
constant rom: rom_array := (X"0017", X"0622", X"00E8", X"0446");


begin

 process(addr)
 variable j: integer;
 begin 
      j := conv_integer(addr);
      M <= rom(j);
  end process;
  

end ROM1_arch;