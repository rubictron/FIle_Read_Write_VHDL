library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity fileIO is
port(
clk : in std_logic
);
end fileIO;


architecture behave of fileIO is

  file file_VECTORS : text;
  file file_RESULTS : text;	
  signal output : std_logic_vector(9 downto 0) := (others => '0');  
  signal ready : std_logic:= '0';
  signal ready2 : std_logic:= '0';
  signal finished : std_logic:= '0';
  signal finished2 : std_logic:= '0'; 
begin

 
  process(clk)
  
    variable v_ILINE     : line;
    variable v_OLINE     : line;
    variable v_DATA : std_logic_vector(9 downto 0);
    variable v_SPACE     : character;
    variable i:integer:=0;
    
  begin 
	if(clk'event and clk = '1') then

		if(ready = '0') then
			 file_open(file_VECTORS, "input.txt",  read_mode);
			 file_open(file_RESULTS, "output.txt", write_mode);
				ready <= '1';
		 end if;

		if(ready = '1' and finished = '0') then
			readline(file_VECTORS, v_ILINE);
			read(v_ILINE, v_DATA);
		end if;
		
			output <= v_DATA;

		if(ready2 = '1' and finished2 = '0') then
			write(v_OLINE, output, right, 10);
			writeline(file_RESULTS, v_OLINE);
		end if;

		if(clk'event and clk = '1' and endfile(file_VECTORS)) then		`
				finished <= '1';
		end if;
		
		if(finished = '1') then
			file_close(file_VECTORS);
		end if;
		
		if(finished2 = '1') then
			file_close(file_RESULTS);
		end if;
		
	end if;
end process;
	
	process(clk,ready,finished)
	begin
	if(clk'event and clk = '1') then
	ready2 <= ready;
	finished2 <= finished;
	end if;
  end process;


end behave;