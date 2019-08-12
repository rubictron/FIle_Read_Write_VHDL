library ieee;
use ieee.std_logic_1164.all;


entity top_level is
   port (
	iclk : in std_logic
   );
end entity top_level;

architecture arch of top_level is

component fileinput
generic (
dataWidth:integer:=8
); 
port(
clk : in std_logic;
ready:inout std_logic := '0';
output:out std_logic_vector(dataWidth-1 downto 0):=(others => '0')
);
end component;

component fileoutput
generic (
dataWidth:integer:=8
); 
port(
clk : in std_logic;
enable: in std_logic:='0';
input: in std_logic_vector(dataWidth-1 downto 0):=(others => '0')
);
end component;

signal ready: std_logic;
signal output: std_logic_vector(7 downto 0):=(others => '0');
signal enable:  std_logic;
signal input:  std_logic_vector(7 downto 0):=(others => '0');

begin

 process(iclk,ready,enable)
 begin
 if(rising_edge(iclk)) then
 input <= output;
 enable <= ready;
end if;
 end process;
 
  Inst_fileoutput: fileoutput
	PORT MAP(
		clk => iclk,
		enable => enable,
		input => input
	);
	
	  Inst_fileinput: fileinput PORT MAP(
		clk => iclk,
		ready => ready,
		output => output
	);

end architecture arch;