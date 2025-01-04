-- In order to cut down on 

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity RAM is

  generic (
    memoryCellCount : positive := 14
  );
  port (
    transact  : in    std_logic;                    -- on rising edge, "transaction is performed"
    addrLines : in    integer range 0 to 255; -- address lines, load address to these lines before performing transaction
    dataLines : inout std_logic_vector(7 downto 0); -- data lines, load data before transaction or get data after transaction complete
    mode      : in    std_logic;                    -- '0' for read, '1' for write
    enable    : in    std_logic
  );
end entity;

architecture rtl of RAM is
  signal chipSelectLines : std_logic_vector(memoryCellCount - 1 downto 0) := (others => '0');
    signal readyTransact : std_logic := '0';
begin
  decoder: entity work.AddressDecoder(rtl) generic map (cellCount => memoryCellCount) port map (
    clock              => transact,
    addressLines       => addrLines,
    outputAddressLines => chipSelectLines,
    ready => readyTransact
  );
  memoryCells: for i in 0 to (memoryCellCount - 1) generate
    cell_i: entity work.RAM_Cell(rtl)
    generic map (cellSize => 8)
    port map (
        clk       => readyTransact,
        dataLines => dataLines,
        chipSel   => chipSelectLines(i),
        mode      => mode
    );
  end generate;

  process (transact, enable) is
  begin
    if (enable = '1') then
    else
      dataLines <= (others => 'Z');
    end if;
  end process;

end architecture;
