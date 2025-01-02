LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT ROM_Block
	PORT(
		clk : IN std_logic;
		addrLines : IN std_logic_vector(7 downto 0);          
		dataLines : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	SIGNAL clk 		 :  std_logic := '0' ; 
	SIGNAL addrLines :  std_logic_vector(7 downto 0);
	SIGNAL dataLines :  std_logic_vector(7 downto 0);
	

BEGIN

-- Please check and add your generic clause manually
	uut: ROM_Block PORT MAP(
		clk => clk,
		addrLines => addrLines,
		dataLines => dataLines
	);
	
	clk <= not clk after 100 ps; 


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
		for i in 0 to 13 loop
			wait on clk;
			addrLines <= std_logic_vector(to_unsigned(i, 8));
			-- wait until rising_edge(clk);
		end loop;
		wait;
      
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
