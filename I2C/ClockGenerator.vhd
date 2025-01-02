library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clockGenerator is

generic -- frequencies are divided by 10 to be able to fit into 32 bits
(
	target_frequency   	:  	integer		:= 400000;		-- by default, I2C clock of 400khz
	base_frequency		:	integer		:= 25000000		-- 25MHz clock for reference
);

port(
	clk_in				:	in 	std_logic;
	clk_out				:	out std_logic;
	enable				:	in	std_logic
);
end entity;

architecture rtl of clockGenerator is
begin
process(clk_in)
constant divider		:	integer		:= base_frequency / target_frequency;
variable counter		:	integer		:= 0;
variable state			: 	std_logic 	:= '0';

begin
	if(enable = '1') then
		if( rising_edge(clk_in) ) then
			counter := counter + 1;
			if(counter = divider) then
				clk_out <= state;
				state := not state;
				counter := 0;
			end if; 
		end if;
	else
		clk_out <= 'Z';
	end if;
end process;
		
end architecture;