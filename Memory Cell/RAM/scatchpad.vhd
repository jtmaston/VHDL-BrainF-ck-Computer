/*
		wait on clk;
		workMode  <= '1';
		wait on clk;
		enableDec <= '1';
		for i in 0 to initLen - 1 loop								-- writing to ram cells section
			addrLines <= std_logic_vector(to_unsigned(i, 8));
			wait on clk;
			wait on clk;
			dataLines <= std_logic_vector(to_unsigned(character'pos(initData(i + 1)), 8));
			wait on clk;
			
		end loop;
		
		enableDec <= '0';
		workMode  <= '0';
		dataLines <= (others => 'Z');
		addrLines <= (others => 'Z');
		
		wait on clk;
		enableDec <= '1';
		
		for i in 0 to initLen - 1 loop								-- reading from ram cells section
			wait on clk;
			addrLines <= std_logic_vector(to_unsigned(i, 8));
			wait on clk;
		end loop;
		wait;



for i in 0 to initLen - 1 loop								-- writing to ram cells section
		addrLines <= std_logic_vector(to_unsigned(i, 8));
		dataLines <= std_logic_vector(to_unsigned(character'pos(initData(i + 1)), 8));
		wait on clk;
		
	end loop;
	
	enableDec <= '0';
	workMode  <= '0';
	
	wait on clk;
	enableDec <= '1';
	wait until rising_edge(clk);
	
	for i in 0 to initLen - 1 loop								-- reading from ram cells section
		addrLines <= std_logic_vector(to_unsigned(i, 8));
		wait on clk;
	end loop;*/
] * /
