library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity testbench is
end entity;

architecture behavior of testbench is


component ROM is
  generic (
    romText : string := "ROM Test"
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
    for i in 0 to 13 loop
      wait on clk;
      addrLines <= std_logic_vector(to_unsigned(i, 8));
	  wait on clk;
    end loop;
    wait;

  end process;
  -- *** End Test Bench - User Defined Section ***
end architecture;
