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
            addrLines : in  std_logic_vector(7 downto 0);
            dataLines : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clk       : std_logic := '0';
    signal addrLines : std_logic_vector(7 downto 0);
    signal dataLines : std_logic_vector(7 downto 0);

begin

  -- Please check and add your generic clause manually
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
            wait until falling_edge(clk);
            addrLines <= std_logic_vector(to_unsigned(i, 8));
        end loop;
        wait until falling_edge(clk);
        wait;
        

    end process;
  -- *** End Test Bench - User Defined Section ***
end architecture;
