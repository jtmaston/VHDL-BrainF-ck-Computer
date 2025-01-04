library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity addressdecoder_tb is
end entity;

architecture behavior of addressdecoder_tb is
  signal clock              : in std_logic;                                                    -- Clock pulse on which the mux does the switching
  signal addressLines       : in std_logic_vector(7 downto 0);                                 -- Address lines to set the mux output
  signal outputAddressLines : out std_logic_vector(cellCount - 1 downto 0) := (others => '0'); -- Sets tge
  signal enable             : in std_logic constant initData : string      := "RAM Cell testing";
  constant initLen : positive := initData'LENGTH;

begin
  uut: entity work.AddressDecoder
    generic map (
      cellCount => cellCount
    )
    port map (
      clock              => clock,
      addressLines       => addressLines,
      outputAddressLines => outputAddressLines,
      enable             => enable
    );

  clk <= not clk after 100 ps;

  -- *** Test Bench - User Defined Section ***

  tb: process
  begin

    wait until rising_edge(clk);
    wait on clk;

    workMode <= '1';
    enableDec <= '1';
    wait on clk;

    for i in 0 to initLen - 1 loop -- writing to ram cells section
      addrLines <= std_logic_vector(to_unsigned(i, 8));
      dataLines <= std_logic_vector(to_unsigned(character'pos(initData(i + 1)), 8));
      wait on clk;
      wait on clk;
    end loop;

    workMode <= '0';
    enableDec <= '0';
    dataLines <= (others => 'Z');

    wait on clk;
    enableDec <= '1';

    for i in 0 to initLen - 1 loop -- reading from ram cells section
      addrLines <= std_logic_vector(to_unsigned(i, 8));
      wait on clk;
    end loop;
    wait;

    wait;
  end process;
  -- *** End Test Bench - User Defined Section ***
end architecture;


