library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM_CTRL is
    Port ( psh : in STD_LOGIC_VECTOR (4 downto 0);
           set : out STD_LOGIC;
           left : in STD_LOGIC;
           right : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           rin : in STD_LOGIC_VECTOR (9 downto 0);
           lflg : out STD_LOGIC;
           rflg : out STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (4 downto 0);
           rout : out STD_LOGIC_VECTOR (9 downto 0);
           wr_en : out STD_LOGIC_VECTOR (0 downto 0);
           tcode : in STD_LOGIC_VECTOR (15 downto 0));
end RAM_CTRL;

architecture Behavioral of RAM_CTRL is

signal r1 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
signal r11 : STD_LOGIC_VECTOR (9 downto 0);
signal r2 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
signal r22 : STD_LOGIC_VECTOR (9 downto 0);
signal r3 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
signal r33 : STD_LOGIC_VECTOR (9 downto 0);
signal r4 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
signal r44 : STD_LOGIC_VECTOR (9 downto 0);

signal rclr : STD_LOGIC_VECTOR (9 downto 0);
signal n1 : integer;
signal n2 : integer;
signal pshcnt : STD_LOGIC_VECTOR (4 downto 0);
signal pshs : STD_LOGIC_VECTOR (4 downto 0);
signal stpflg, stpflg1 : STD_LOGIC;

type state_type is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, checkLorR, s11rd, s3clr, s5clr, s7clr, s9clr, s3rd1, s5rd1, s7rd1, s9rd1,s3rd2, s5rd2, s7rd2, s9rd2, s2r, s2w, s3w, s5w, s7w, s9w, wait4psh, gameover);
signal present_state, next_state: state_type;

begin
    Sreg : process (clk, clr)
        begin
            if clr = '1' then
                present_state <= s1;
            elsif clk'event and clk = '1' then
                present_state <= next_state;
            end if;
        end process;
        
    SM1: process (present_state, clr, tcode, r1, rin, pshcnt, psh, pshs)
    begin
       case present_state is
        when s1 =>
             if tcode /= X"0000" then
                next_state <= s2r;
            else
                next_state <= s1;
            end if;
        when s2r =>
            next_state <= s2w;
        when s2w =>
            next_state <= s2;
        when s2 =>
            if rin = "0000000000" then
                next_state <= wait4psh;
            else 
                next_state <= gameover;
            end if;
       when checkLorR =>
                next_state <= wait4psh;
       when s3rd1 =>
            next_state <= s3;
       when s3 =>
            next_state <= s4;
       when s4 =>
            next_state <= s5rd1; 
       when s5rd1 =>
            next_state <= s5;
       when s5 =>
            next_state <= s6; 
       when s6 =>
            next_state <= s7rd1;
       when s7rd1 =>
            next_state <= s7; 
       when s7 =>
            next_state <= s8; 
       when s8 =>
            next_state <= s9rd1;
       when s9rd1 =>
            next_state <= s9;
       when s9 =>
            next_state <= s10; 
       when s10 =>
            next_state <= s11rd;
       when s11rd =>
            next_state <= s11; 
       when s11 =>
            next_state <= s12;
       when s12 =>
            if (((r1 AND rin) /= "0000000000") OR (pshs = "01111")) then
                next_state <= s13;
            else
                next_state <= s3rd2;
            end if;
       when wait4psh =>
                next_state <= s3rd1;
       when s3rd2 =>
           next_state <= s3w;
       when s3w =>
           next_state <= s3clr;
       when s3clr =>
            next_state <= s5rd2;
       when s5rd2 =>
            next_state <= s5w;
       when s5w =>
            next_state <= s5clr;
       when s5clr =>
            next_state <= s7rd2;
       when s7rd2 =>
            next_state <= s7w;
       when s7w =>
            next_state <= s7clr;
       when s7clr =>
            next_state <= s9rd2;
       when s9rd2 =>
            next_state <= s9w; 
       when s9w =>
            next_state <= s9clr;
       when s9clr =>
            next_state <= checkLorR;
       when s13 =>
            next_state <= s1;
       when others =>
            null;
       end case;
   end process;
   
    SM2 : process(present_state, left, right, n1, n2, r11, r22, r33, r44, psh, pshs, pshcnt, r1, r2, r3, r4, stpflg, stpflg1, rin, tcode, rclr)
    begin
    --addr <= "00000"; 
    wr_en <= "0" ; set <= '1';
   
    
            if present_state = s1 then
                --set <= '1';
                r11 <= "0000000000";
                r22 <= "0000000000";
                r33 <= "0000000000";
                r44 <= "0000000000";
                rclr <= "1110000111";
                rout <= "0000000000";
                pshcnt <= "00001";
                pshs <= "00000";
                addr <= "00000";
                stpflg <= '0';
                stpflg1 <= '0';
                n1 <= 7; 
                n2 <= 2;
                rflg <= '0';
                lflg <= '0';
                
            elsif present_state =  s2r then
                addr <= "10000";
                
            elsif present_State = s2w then
                --dummy state to waste a clock cycle
                
            elsif present_state = s2 then
                r1 <= "000" & tcode(3 downto 0) & "000";
                r2 <= "000" & tcode(7 downto 4) & "000";
                r3 <= "000" & tcode(11 downto 8) & "000";
                r4 <= "000" & tcode(15 downto 12) &  "000";
                addr <= "10000";
                set <= '1';
                
            elsif present_state = checkLorR then
              if left = '1'  and stpflg = '0' then
                if ((r11(n1) = '0') and (r22(n1) = '0') and (r33(n1) = '0') and (r44(n1) = '0') and (r1(n1) = '0') and (r2(n1) = '0') and (r3(n1) = '0') and (r4(n1) = '0')) then --checks to see if left colum next to shape is empty
                    
                    if n1 < 9 then
                        n1 <= n1 + 1; -- increments for next column to check incase left or right is hit agian
                        n2 <= n2 + 1;
                        stpflg <= '1';
                    elsif n2 < 7 and n1 = 9 then 
                        n2 <= n2 + 1;
                        stpflg <= '1';
                    end if;
                end if;
                
              elsif right = '1' and stpflg = '0'then
                    if ((r11(n2) = '0') and (r22(n2) = '0') and (r33(n2) = '0') and (r44(n2) = '0') and (r1(n2) = '0') and (r2(n2) = '0') and (r3(n2) = '0') and (r4(n2) = '0')) then --checks to see if righ colum next to shape is empty
                        if n2 > 0 then 
                            n1 <= n1 - 1; -- decremnets for next column check whether it be left or right
                            n2 <= n2 - 1;
                            stpflg <= '1';
                        elsif n2 = 0 and n1 > 2 then 
                            n1 <= n1 - 1;
                            stpflg <= '1';
                        end if; 
                    end if;
               end if;
                
                if n1 = 1 then
                    r1 <= "000000000" & tcode(3 downto 3);
                    r2 <= "000000000" & tcode(7 downto 7);
                    r3 <= "000000000" & tcode(11 downto 11);
                    r4 <= "000000000" & tcode(15 downto 15);
                    rclr <= "1111111110";
                elsif n1 = 2 then
                    r1 <= "00000000" & tcode(3 downto 2);
                    r2 <= "00000000" & tcode(7 downto 6);
                    r3 <= "00000000" & tcode(11 downto 10);
                    r4 <= "00000000" & tcode(15 downto 14);
                    rclr <= "1111111100";
                elsif n1 = 3 then   
                    r1 <= "0000000" & tcode(3 downto 1);
                    r2 <= "0000000" & tcode(7 downto 5);
                    r3 <= "0000000" & tcode(11 downto 9);
                    r4 <= "0000000" & tcode(15 downto 13);
                    rclr <= "1111111000";
                elsif n1 = 4 then
                    r1 <= "000000" & tcode(3 downto 0);
                    r2 <= "000000" & tcode(7 downto 4);
                    r3 <= "000000" & tcode(11 downto 8);
                    r4 <= "000000" & tcode(15 downto 12);
                    rclr <= "1111110000";
                elsif n1 = 5 then
                    r1 <= "00000" & tcode(3 downto 0) & "0";
                    r2 <= "00000" & tcode(7 downto 4) & "0";
                    r3 <= "00000" & tcode(11 downto 8) & "0";
                    r4 <= "00000" & tcode(15 downto 12) & "0";
                    rclr <= "1111100001";
                elsif n1 = 6 then
                    r1 <= "0000" & tcode(3 downto 0) & "00";
                    r2 <= "0000" & tcode(7 downto 4) & "00";
                    r3 <= "0000" & tcode(11 downto 8) & "00";
                    r4 <= "0000" & tcode(15 downto 12) & "00";
                    rclr <= "1111000011";
                elsif n1 = 7 then
                    r1 <= "000" & tcode(3 downto 0) & "000";
                    r2 <= "000" & tcode(7 downto 4) & "000";
                    r3 <= "000" & tcode(11 downto 8) & "000";
                    r4 <= "000" & tcode(15 downto 12) & "000";
                    rclr <= "1110000111";
                elsif n1 = 8 then
                    r1 <= "00" & tcode(3 downto 0) & "0000";
                    r2 <= "00" & tcode(7 downto 4) & "0000";
                    r3 <= "00" & tcode(11 downto 8) & "0000";
                    r4 <= "00" & tcode(15 downto 12) &  "0000";
                    rclr <= "1100001111";
                elsif n1 = 9 and n2 = 4  then
                    r1 <= "0" & tcode(3 downto 0) & "00000";
                    r2 <= "0" & tcode(7 downto 4) & "00000";
                    r3 <= "0" & tcode(11 downto 8) & "00000";
                    r4 <= "0" & tcode(15 downto 12) &  "00000";
                    rclr <= "1000011111";
               elsif n2 = 5  then
                    r1 <= tcode(3 downto 0) & "000000";
                    r2 <= tcode(7 downto 4) & "000000";
                    r3 <= tcode(11 downto 8) & "000000";
                    r4 <= tcode(15 downto 12) &  "000000";
                    rclr <= "0000111111";
               elsif n2 = 6 then
                    r1 <= tcode (2 downto 0) & "0000000";
                    r2 <= tcode (6 downto 4) & "0000000";
                    r3 <= tcode (10 downto 8) & "0000000";
                    r4 <= tcode (14 downto 12) & "0000000";
                    rclr <= "0001111111";
                elsif n2 = 7 then
                    r1 <= tcode (1 downto 0) & "00000000";
                    r2 <= tcode (5 downto 4) & "00000000";
                    r3 <= tcode (9 downto 8) & "00000000";
                    r4 <= tcode (13 downto 12) & "00000000";
                    rclr <= "0011111111";
                elsif n2 = 8 then
                    r1 <= tcode (0 downto 0) & "000000000";
                    r2 <= tcode (4 downto 4) & "000000000";
                    r3 <= tcode (8 downto 8) & "000000000";
                    r4 <= tcode (12 downto 12) & "000000000";
                    rclr <= "0111111111";
                end if;
                
                rflg <= r1(0) or r2(0) or r3(0) or r4(0);
                lflg <= r1(9) or r2(9) or r3(9) or r4(9);
                  
            elsif present_state = s3 then
                --dummy state to waste a clock cycle
                stpflg1 <= '0';
            elsif present_state = s4 then
                rout <= r1 or rin;
                r11 <= r1 or rin;
                wr_en <= "1";
                
            elsif present_state = s5 then
                --dummy state to waste a clock cycle
                
            elsif present_state = s6 then
                rout <= r2 or rin;
                r22 <= r2 or rin;
                wr_en <= "1";
                
             elsif present_state = s7 then
               --dummy state to waste a clock cycle
               
               
            elsif present_state = s8 then
                rout <= r3 or rin;
                r33 <= r3 or rin;
                wr_en <= "1";
                
            elsif present_state = s9 then
               --dummy state to waste a clock cycle
               
               
            elsif present_state = s10 then
                rout <= r4 or rin;
                r44 <= r4 or rin;
                wr_en <= "1";
                
            elsif present_state = s11rd then
                addr <= "10000" - (pshs + 1);
                
            elsif present_state = s11 then
               --dummy state to waste a clock cycle
               
            elsif present_state = s12 then
               --dummy state to waste a clock cycle
               
            elsif present_state = s3rd2 then
                addr <= "10000" - pshs;
            elsif present_state = s3clr then
                rout <= rclr and rin;
                wr_en <= "1";
            elsif present_state = s5rd2 then
                addr <= "10001" - pshs;
            elsif present_state = s5clr then
                addr <= 17 - pshs;
                rout <= rclr and rin;
                wr_en <= "1";
            elsif present_state = s7rd2 then
                addr <= "10010" - pshs;
            elsif present_state = s7clr then
                addr <= 18 - pshs;
                rout <= rclr and rin;
                wr_en <= "1";
            elsif present_state = s9rd2 then
                addr <= "10011" - pshs;
            elsif present_state = s9clr then
                addr <= 19 - pshs;
                rout <= rclr and rin;
                stpflg <= '0';
                wr_en <= "1";
            elsif present_state = s3rd1 then
                addr <= "10000" - pshs;
            elsif present_state = s5rd1 then
                addr <= "10001" - pshs;
            elsif present_state = s7rd1 then
                addr <= "10010" - pshs;
            elsif present_state = s9rd1 then
                addr <= "10011" - pshs;
            elsif present_state = wait4psh then
                if psh >= pshcnt  and stpflg1 = '0' then
                    pshs <= pshs + "00001";
                    pshcnt <= pshcnt + "00001";
                    stpflg1 <= '1';
                end if;
            elsif present_state = s13 then
                set <= '0';
            end if;
        end process;
end Behavioral;
