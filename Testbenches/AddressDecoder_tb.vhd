--! @file AddressDecoder_tb.vhd
--! Example testbench for the Address Decoder. It basically sequentially shifts out incrementing values, to test the
--! lines.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AddressDecoder_tb is
end entity;

architecture behavior of AddressDecoder_tb is
    constant testCellCount    : positive    := 8;
    
    signal clock              : std_logic   := '0';                                                    -- Clock pulse on which the mux does the switching
    signal addressLines       : integer range 0 to 255;                                 -- Address lines to set the mux output
    signal outputAddressLines : std_logic_vector(testCellCount - 1 downto 0) := (others => '0'); -- Sets tge
    signal ready                : std_logic := '0';
    signal enableCell         : std_logic := '0';
begin
    uut: entity work.AddressDecoder(rtl)
    generic map (
        cellCount => testCellCount
    )
    port map (
        clock              => clock,
        addressLines       => addressLines,
        outputAddressLines => outputAddressLines,
        ready              => ready,
        enable             => enableCell
    );

    clock <= not clock after 100 ps;

    tb: process
    begin
        for i in 1 to 4 loop
            wait on clock;
        end loop;
        enableCell <= '1';
        wait until rising_edge(clock);

        for i in 1 to testCellCount - 1 loop
            addressLines <= i;
            for i in 1 to 3 loop
                wait on clock;
            end loop;
            
        end loop;

        wait until falling_edge(clock);
        enableCell <= '0';
        
        wait;
    end process;
  -- *** End Test Bench - User Defined Section ***
end architecture;


