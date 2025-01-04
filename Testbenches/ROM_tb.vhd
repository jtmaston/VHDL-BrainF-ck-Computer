library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture behavior of rom_tb is
    constant romText : string := "ROM Test";

    component ROM is
        generic (
            romText : string := romText
        );
        port (
            transact  : in  std_logic;
            addrLines : in  integer range 0 to 255;
            dataLines : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clk       : std_logic := '0';
    signal addrLines : integer range 0 to 255;
    signal dataLines : std_logic_vector(7 downto 0);

begin

    uut: ROM
    port map (
        transact       => clk,
        addrLines => addrLines,
        dataLines => dataLines
    );

    clk <= not clk after 100 ps;

  -- *** Test Bench - User Defined Section ***

    tb: process
    begin
        for i in 0 to romText'length - 1 loop
            addrLines <= i;
            wait until rising_edge(clk);
        end loop;
        
        wait;
        

    end process;
  -- *** End Test Bench - User Defined Section ***
end architecture;
