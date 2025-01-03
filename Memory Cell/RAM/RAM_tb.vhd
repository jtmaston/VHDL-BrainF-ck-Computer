library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity testbench is
end entity;

architecture behavior of testbench is
  signal clk       : std_logic                    := '0';
  signal addrLines : std_logic_vector(7 downto 0) := (others => 'Z');
  signal dataLines : std_logic_vector(7 downto 0) := (others => 'Z');
  signal workMode  : std_logic                    := '0';
  signal enableDec : std_logic                    := '0';

  constant initData : string   := "RAM Cell testing";
  constant initLen  : positive := initData'LENGTH;

begin
  uut: entity work.RAM(rtl) generic map (memoryCellCount => initLen) port map (
    transact  => clk,
    addrLines => addrLines,
    dataLines => dataLines,
    mode      => workMode,
    enable    => enableDec
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


