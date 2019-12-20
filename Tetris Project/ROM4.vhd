library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity ROM4 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);
        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end ROM4;

architecture ROM4_arch of ROM4 is


type rom_array is array (NATURAL range <>)  of STD_LOGIC_VECTOR (15 downto 0);
constant rom: rom_array := (X"0462", X"006C", X"0462", X"006C");


begin

 process(addr)
 variable j: integer;
 begin 
      j := conv_integer(addr);
      M <= rom(j);
  end process;
  

end ROM4_arch;