library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity I2CPeripheral is

  generic (
    registerCount : positive := 4;
    address       : positive := x"0x0f"
  );
  port (
    clk    : in    std_logic;
    sda    : inout std_logic;
    scl    : inout std_logic;
    enable : in    std_logic
  );
end entity;

architecture rtl of I2CPeripheral is
begin
  clockgenerator_inst: entity work.clockGenerator
    port map (
      clk_in  => clk,
      clk_out => scl,
      enable  => enable
    );

  ram_block_inst: entity work.RAM_Block
    generic map (
      memoryCellCount => registerCount
    )
    port map (
      transact  => clk,
      addrLines => addrLines,
      dataLines => dataLines,
      mode      => mode,
      enable    => enable
    );

end architecture;
