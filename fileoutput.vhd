library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity fileoutput is
port(
clk : in std_logic;
enable: in std_logic:='0';
input: in std_logic_vector(9 downto 0):=(others => '0')
);
end fileoutput;


architecture behave of fileoutput is

  file file_RESULTS : text;
  signal opened:std_logic:='0';
  signal closed:std_logic:='0';
begin

  process(clk,enable)
  
    variable v_OLINE     : line;
	 
    
  begin 
	if(rising_edge(clk)) then

		if(enable = '1' and opened = '0') then
			 file_open(file_RESULTS, "output.txt", write_mode);
			 opened <= '1';
		 end if;
		 
		 
		if(enable = '1') then
			write(v_OLINE, input, right, 10);
			writeline(file_RESULTS, v_OLINE);
		end if;
	
		
		if(enable ='0' and closed = '0') then
			file_close(file_RESULTS);
		end if;
		
	end if;
end process;
	

end behave;