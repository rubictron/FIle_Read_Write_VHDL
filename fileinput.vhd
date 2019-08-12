library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity fileinput is
generic(
dataWidth : integer := 10
);
port(
clk : in std_logic;
ready: inout std_logic := '0';
output:out std_logic_vector(dataWidth-1 downto 0):=(others => '0')
);
end fileinput;

architecture behave of fileinput is
  file file_VECTORS : text;
  signal opened: std_logic:= '0';
  signal closed: std_logic:= '0';
begin

 
  process(clk,ready)
  
    variable v_ILINE     : line;
    variable v_DATA : std_logic_vector(dataWidth-1 downto 0);    
  begin 
	if(rising_edge(clk)) then

		if(ready = '0' and opened <= '0') then
			 file_open(file_VECTORS, "input.txt",  read_mode);
				ready <= '1';
				opened <= '1'; --for circulate the process remove this line
		 end if;

		if(ready <= '1' and endfile(file_VECTORS)) then	
			ready <= '0';
			closed <= '1';
		else
			readline(file_VECTORS, v_ILINE);
			read(v_ILINE, v_DATA);
		end if;

		
		if(ready = '0' and closed = '0'  and endfile(file_VECTORS))then
				file_close(file_VECTORS);
		end if;
		
		output <= v_DATA;
		
	end if;
	
end process;
	


end behave;