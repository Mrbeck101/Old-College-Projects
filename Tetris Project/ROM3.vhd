library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity ROM3 is
    port (
        addr: in STD_LOGIC_VECTOR (1 downto 0);

        M: out STD_LOGIC_VECTOR (15 downto 0)
    );
end ROM3;

architecture ROM3_arch of ROM3 is


type rom_array is array (NATURAL range <>)  of STD_LOGIC_VECTOR (15 downto 0);
constant rom: rom_array := (X"0027", X"0464", X"0262", X"0072");


begin

 process(addr)
 variable j: integer;
 begin 
      j := conv_integer(addr);
      M <= rom(j);
  end process;
  

end ROM3_arch;