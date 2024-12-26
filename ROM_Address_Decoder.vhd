library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM_Address_Decoder is
generic(
		cellCount	: positive := 16
);
port (
        clock               : in    std_logic;                          			-- Clock pulse on which the mux does the switching
        addressLines        : in    std_logic_vector (7 downto 0);      			-- Address lines to set the mux output
        outputAddressLines  : out   std_logic_vector (cellCount - 1 downto 0);    	-- Sets tge
        enable              : in    std_logic
);
end ROM_Address_Decoder;


architecture rtl of ROM_Address_Decoder is
    signal bits         : std_logic_vector (2 downto 0);
begin
    process(clock, enable) is
    begin
        if enable = '0' then
            outputAddressLines <= (others => 'Z');
        elsif rising_edge(clock) or falling_edge(clock) then
                outputAddressLines <= (others => '0');
                outputAddressLines(to_integer(unsigned(addressLines))) <= '1';
        end if;
    end process;

end rtl;


