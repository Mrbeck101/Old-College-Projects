library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc is
  port (
    clr   : in  std_logic;
    clk   : in  std_logic;
    inc   : in  std_logic;
    q     : out std_logic_vector(1 downto 0)
    );
end pc;

architecture pc_arch of pc is
  signal count : std_logic_vector (1 downto 0);
begin

  process (clk, clr)
  begin
    if clr = '1' then
      count <= (others => '0');
    elsif rising_edge(clk)  then
      if inc = '1' and count /= "11" then
          count <= count + 1;
      elsif inc = '1' and count = "11" then
        count <= (others => '0');
      end if;
    end if;
  end process;

  q <= count;

end pc_arch;