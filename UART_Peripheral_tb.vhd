
-- VHDL Test Bench Created from source file ROM_Block.vhd -- Thu Dec 26 02:36:43 2024

--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Lattice recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "source->import"
-- menu in the ispLEVER Project Navigator to import the testbench.
-- Then edit the user defined section below, adding code to generate the 
-- stimulus for your design.
-- 3) VHDL simulations will produce errors if there are Lattice FPGA library 
-- elements in your design that require the instantiation of GSR, PUR, and
-- TSALL and they are not present in the testbench. For more information see
-- the How To section of online help.  
--
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
