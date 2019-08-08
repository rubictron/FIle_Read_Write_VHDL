library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity fileinput is
port(
clk : in std_logic;
ready:out std_logic := '0';
output:out std_logic_vector(9 downto 0):=(others => '0')
);
end fileinput;

architecture behave of fileinput is

  file file_VECTORS : text;
  signal ready2 : std_logic:= '0';
  signal finished: std_logic:= '0';
begin

 
  process(clk)
  
    variable v_ILINE     : line;
    variable v_DATA : std_logic_vector(9 downto 0);
    variable v_SPACE     : character;    
  begin 
	if(clk'event and clk = '1') then

		if(ready2 = '0' and finished = '0') then
			 file_open(file_VECTORS, "input.txt",  read_mode);
				ready2 <= '1';
				finished <= '1'; --for circulate the process remove this line
		 end if;

		if(ready2 = '1') then
			readline(file_VECTORS, v_ILINE);
			read(v_ILINE, v_DATA);
		end if;
		
		if(clk'event and clk = '1' and endfile(file_VECTORS)) then
				file_close(file_VECTORS);
				ready2 <= '0';
		end if;
		
		output <= v_DATA;
		ready <= ready2;
		
		
	end if;
end process;
	


end behave;