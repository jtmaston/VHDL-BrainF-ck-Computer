LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 
	SIGNAL clk 		 :  std_logic 	:= '0' ; 
	SIGNAL addrLines :  std_logic_vector(7 downto 0) 	:= (others => 'Z');
	SIGNAL dataLines :  std_logic_vector(7 downto 0) 	:= (others => 'Z');
	SIGNAL workMode	 :  std_logic 	:= '0';
	SIGNAL enableDec :  std_logic	:= '0';
	
	constant initData:	string		:= "RAM Cell testing";
	constant initLen :  positive	:= initData'LENGTH;
	

BEGIN
	uut: entity work.RAM_Block(rtl)
	GENERIC MAP(memoryCellCount => initLen)
	PORT MAP(
		clk => clk,
		addrLines => addrLines,
		dataLines => dataLines,
		mode  => workMode,
		enable => enableDec
	);
	
	clk <= not clk after 100 ps; 


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
   
	wait until rising_edge(clk);
	wait on clk;
	
	workMode  <= '1';
	enableDec <= '1';
	wait on clk;	
	
	for i in 0 to initLen - 1 loop								-- writing to ram cells section
		addrLines <= std_logic_vector(to_unsigned(i, 8));
		dataLines <= std_logic_vector(to_unsigned(character'pos(initData(i + 1)), 8));
		wait on clk;
		wait on clk;
	end loop;
	
	workMode  <= '0';
	enableDec <= '0';
	dataLines <= (others => 'Z');
	
	wait on clk; 
	enableDec <= '1';
	
	for i in 0 to initLen - 1 loop								-- reading from ram cells section
		addrLines <= std_logic_vector(to_unsigned(i, 8));
		wait on clk;
	end loop;
	wait;
		
		
		
   wait;
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;


