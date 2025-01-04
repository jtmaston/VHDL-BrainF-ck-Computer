library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity I2CPeripheral is

  generic (
    registerCount : positive := 4;
    address       : positive := 4
  );
  port (
    clk    : in    std_logic;
    sda    : inout std_logic;
    scl    : inout std_logic;
    enable : in    std_logic
  );
end entity;

architecture rtl of I2CPeripheral is
  signal addrLines      : std_logic_vector(7 downto 0);
  signal dataLines      : std_logic_vector(7 downto 0);
  signal ramAccessMode  : std_logic;
  signal romTransaction : std_logic;
  signal ramTransaction : std_logic;
  signal romEnable      : std_logic;

begin
  clockgenerator_inst: entity work.clockGenerator
    port map (
      clk_in  => clk,
      clk_out => scl,
      enable  => enable
    );

  ram_inst: entity work.RAM
    generic map (
      memoryCellCount => registerCount
    )
    port map (
      transact  => ramTransaction,
      addrLines => addrLines,
      dataLines => dataLines,
      mode      => ramAccessMode,
      enable    => enable
    );

  rom_inst: entity work.ROM
    generic map (
      romText => "IDENT"
    )
    port map (
      transact  => romTransaction,
      addrLines => addrLines,
      dataLines => dataLines
    );

end architecture;
